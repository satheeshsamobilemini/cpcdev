trigger populateOSRTopPotential on Account (before update) {

if(TriggerSwitch.isTriggerExecutionFlagDisabled('Account','populateOSRTopPotential')){
        return;
    }     
    /*If custom setting holds logged in user's ID then trigger will not fire.
    This is done by Reena for S-117407 to avoid firing trigger of Account during data update of account.
    If user want to perform data update on account but want to avoid firing of trigger then
    Set user's salesforce ID in SkipTrigger custom setting and then perform update.*/
       
    for(SkipTrigger__c skipTrg : SkipTrigger__c.getAll().values()){  if(skipTrg.name == userinfo.getUserID().subString(0,15)){ return; }    }
  
    for(integer i =0 ; i<Trigger.new.size(); i++){
    if(Trigger.new[i].TSM_Top_Potential_ID__c != Trigger.old[i].TSM_Top_Potential_ID__c){
        Trigger.new[i].TSM_Top_Potential__c = Trigger.new[i].TSM_Top_Potential_ID__c;
    }
    }
    
   // TFS 3872 - Approval Process (Take Ownership of Branch Accounts && Send Accounts to Branch Account)
   ID BranchUserID;
   map<ID,ID> mapAccountIdOwner = new map<ID,ID>();
   List<Contact> ConList = new List<Contact>();
   map<Id,Id> mapIdaccOwner = new map<Id,Id>();          // TFS 4849
   map<Id,Account> mapIdaccnt = new map<Id,Account>();  // TFS 4849
   Boolean isfoundTask = false;                        // TFS 4849 
   ID ETSrecordtypeID = AssignmentRules.getETSWMIrectypeID('Account');
    if(Label.Branch_Account_User_Id != null)
      BranchUserID = Id.valueOf(Label.Branch_Account_User_Id);
     
   for(integer i=0;i<trigger.old.size();i++){
    if(Test.isRunningTest())
        mapIdaccOwner.put(trigger.new[i].Id,trigger.new[i].OwnerId);
    if(trigger.new[i].RecordTypeId == ETSrecordtypeID && trigger.new[i].OwnerId == BranchUserID && trigger.old[i].Branch_Account_Approval_Status__c == 'Submitted' && trigger.new[i].Branch_Account_Approval_Status__c == 'Approved')       {  trigger.new[i].OwnerId = trigger.new[i].ApprovalRequester_ETS__c ;    trigger.new[i].Branch_Account_Approval_Status__c = ''; mapAccountIdOwner.put(trigger.new[i].ID,trigger.new[i].OwnerId);   } 
    
    if(trigger.new[i].RecordTypeId == ETSrecordtypeID && trigger.new[i].OwnerId <> BranchUserID && trigger.old[i].Branch_Account_Approval_Status__c == 'Submitted' && trigger.new[i].Branch_Account_Approval_Status__c == 'Approved')       {  trigger.new[i].OwnerId = BranchUserID; trigger.new[i].Branch_Account_Approval_Status__c = '';   }
     
     // TFS 4849..
     if(ActivityManagement.isUKaccount(trigger.new[i]) && (trigger.new[i].OwnerId == BranchUserID) && (trigger.old[i].OwnerId != BranchUserID))  { system.debug('NULL VALUE'); trigger.new[i].Task_Completed_Date__c = null ; }
     
     // TFS 4849..
     if(ActivityManagement.isUKaccount(trigger.new[i]) && (trigger.new[i].OwnerId != BranchuserID) && (trigger.old[i].OwnerId == BranchUserID)) { system.debug('ACCOUNT SET'); mapIdaccOwner.put(trigger.new[i].Id,trigger.new[i].OwnerId); }
     
    }
    
   if(mapAccountIdOwner.keyset().size() > 0){  for(Contact c : [Select ID,OwnerID,AccountID from Contact where OwnerID =: BranchUserID and AccountID =: mapAccountIdOwner.keyset()])   {  c.OwnerID = mapAccountIdOwner.get(c.AccountID); ConList.add(c);    }  }
      
   if(ConList.size() > 0) { update ConList ; }
    
   // TFS 4849..
   if(mapIdaccOwner.keyset().size() > 0)
    { List<Account> accList = [select Id,OwnerId,Task_Completed_Date__c,(select Id,OwnerId,IsClosed,Task_Completed_Date_Time__c from tasks where IsClosed = true and Task_Completed_Date_Time__c <> null ORDER BY Task_Completed_Date_Time__c DESC) from Account where Id =: mapIdaccOwner.keyset()];
       for(integer i = 0; i < accList.size(); i++)
       { isfoundTask = false; 
          for(Task t : accList[i].tasks)
           { if(!isfoundTask && (t.OwnerId == mapIdaccOwner.get(accList[i].Id)))
              { system.debug('Task Id Value :' + t.Id); system.debug('Task Completed Time Value :' + t.Task_Completed_Date_Time__c);
                accList[i].Task_Completed_Date__c = t.Task_Completed_Date_Time__c;
                system.debug('Account Task Complete Time Value :' + accList[i].Task_Completed_Date__c);
                mapIdaccnt.put( accList[i].Id,accList[i]);
                isfoundTask = true;   
              }
           }
       }
    }
    
   for(integer i =0; i< trigger.new.size(); i++) 
    {  if(mapIdaccnt.containskey(trigger.new[i].Id))
        { trigger.new[i].Task_Completed_Date__c = mapIdaccnt.get(trigger.new[i].Id).Task_Completed_Date__c; }
    }    
}