trigger IsBranchAccount on Account (after insert, after update, before Delete) {
    system.debug('------IsBranchAccount--------');
    if(TriggerSwitch.isTriggerExecutionFlagDisabled('Account','IsBranchAccount')){ return;   }

    /*If custom setting holds logged in user's ID then trigger will not fire.
    This is done by Reena for S-117407 to avoid firing trigger of Account during data update of account.
    If user want to perform data update on account but want to avoid firing of trigger then
    Set user's salesforce ID in SkipTrigger custom setting and then perform update.*/
    
    for(SkipTrigger__c skipTrg : SkipTrigger__c.getAll().values()){  if(skipTrg.name == userinfo.getUserID().subString(0,15)){  return;   } }

    //changed BranchUserID variable type to Id from String by Najma on 30 August 2013 for #00051948
    private Id BranchUserID = null;   
    //commented below 2 line by Najma Ateeq
    //User branchAccountUserID = [Select Id from User where name = 'Branch Account'];
    //BranchUserID = branchAccountUserID.Id;
    //Start of case-00051948 by Najma Ateeq on 30 August 2013
    if(Label.Branch_Account_User_Id != null) BranchUserID = Id.valueOf(Label.Branch_Account_User_Id);
     //End of case-00051948 by Najma Ateeq on 30 August 2013
    
    ID ETSrecordtypeID = AssignmentRules.getETSWMIrectypeID('Account');                // TFS 3873
    map<ID,String> mapAccIdETSbranch = new map<ID,String>();                           // TFS 3873
    String ETSbranch = '';                                                            // TFS 3873   
    List<Account> addAccountToQueue = New List<Account>();
    List<ID> removeAccountFromQueue = New List<ID>();
    List<String> branchCode = New List<String>();
    //Added By Akanksha for Story S-151272
    Map<Id,boolean> userIdAndAddFlag = new Map<Id,boolean>();
    //End By Akanksha for Story S-151272
    if (trigger.isInsert){
        system.debug('@@@@trigger.new'+trigger.new);
        for(integer i=0;i<trigger.new.size();i++){
            //Added By Akanksha for Story S-151272
            if(trigger.new[i].ownerId <> BranchUserID && (trigger.new[i].parentId == null)) { userIdAndAddFlag.put(trigger.new[i].ownerId,true);       } 
            // End the list if the ownerId = Branch Account
            if (trigger.new[i].ownerId == BranchUserID){  addAccountToQueue.add(trigger.new[i]);   if (trigger.new[i].Branch__c != null){  branchCode.add(trigger.new[i].Branch__c);  } else{ branchCode.add('000'); }  if(trigger.new[i].RecordTypeId == ETSrecordtypeID) {  ETSbranch = ((trigger.new[i].ETS_WMI_Branch_ID__c != null && trigger.new[i].ETS_WMI_Branch_ID__c != '') ? trigger.new[i].ETS_WMI_Branch_ID__c : '000'); mapAccIdETSbranch.put(trigger.new[i].ID,ETSbranch);     }     }               
            
        }

    }
    system.debug('@@@trigger.isUpdate'+trigger.isUpdate);
    if (trigger.isUpdate){
        
        Set<Id> AccountIdSet = new Set<id>();
        for(integer i=0;i<trigger.new.size();i++){
            AccountIdSet.add(trigger.new[i].id);
            system.debug('---AccountIdSet----'+AccountIdSet);
        }
        List<Opportunity> oppList = [Select o.Billing_Zip_Postal_Code__c, o.Billing_Street__c, o.Billing_State_Province__c, o.Billing_Country__c, o.Billing_City__c,o.Branch__c,o.AccountId, o.ownerId, o.owner.Name From Opportunity o where AccountId in :AccountIdSet];
        Map<ID,Opportunity> mapIDoppUpdate = new Map<ID,Opportunity>();
        for(Opportunity opp : oppList){
            for(integer i=0;i<trigger.new.size();i++){
               // system.debug('--opp.Billing_Street__c---'+opp.Billing_Street__c);
              //  system.debug('--opp.ownerId ---'+ opp.ownerId);
               // system.debug('--opp.owner.Name ---'+ opp.owner.Name);
                if(opp.AccountId == trigger.new[i].Id){
                    if(trigger.new[i].BillingStreet != trigger.old[i].BillingStreet || trigger.new[i].BillingCity != trigger.old[i].BillingCity || trigger.new[i].BillingCountry != trigger.old[i].BillingCountry || trigger.new[i].BillingPostalCode != trigger.old[i].BillingPostalCode || trigger.new[i].BillingState != trigger.old[i].BillingState){
                        opp.Billing_Street__c = trigger.new[i].BillingStreet; opp.Billing_City__c = trigger.new[i].BillingCity; opp.Billing_Country__c = trigger.new[i].BillingCountry; opp.Billing_Zip_Postal_Code__c = trigger.new[i].BillingPostalCode;   opp.Billing_State_Province__c = trigger.new[i].BillingState;             mapIDoppUpdate.put(opp.id,opp);                 }
                    
                    if(opp.ownerId == trigger.new[i].ownerId && trigger.new[i].ownerId <> BranchUserID && opp.Branch__c <> trigger.new[i].Branch__c)           // opp update happens 
                    {   if(!mapIDoppUpdate.containskey(opp.id))    mapIDoppUpdate.put(opp.id,opp);
                    }
                }
            }
            
        }
        if(mapIDoppUpdate.keyset().size() > 0){         update mapIDoppUpdate.values();          } 
   
   /*  COMMENTED -- MSM 87 ISSUE..
      
        List<Opportunity> oppUpdateList = new List<Opportunity>();
        for(Opportunity opp : oppList){
            for(integer i=0;i<trigger.new.size();i++){
                system.debug('--opp.Billing_Street__c---'+opp.Billing_Street__c);
                system.debug('--opp.ownerId ---'+ opp.ownerId);
                system.debug('--opp.owner.Name ---'+ opp.owner.Name);
                if(opp.AccountId == trigger.new[i].Id){
                    if(trigger.new[i].BillingStreet != trigger.old[i].BillingStreet || trigger.new[i].BillingCity != trigger.old[i].BillingCity || trigger.new[i].BillingCountry != trigger.old[i].BillingCountry || trigger.new[i].BillingPostalCode != trigger.old[i].BillingPostalCode || trigger.new[i].BillingState != trigger.old[i].BillingState){
                        opp.Billing_Street__c = trigger.new[i].BillingStreet;
                        opp.Billing_City__c = trigger.new[i].BillingCity;
                        opp.Billing_Country__c = trigger.new[i].BillingCountry;
                        opp.Billing_Zip_Postal_Code__c = trigger.new[i].BillingPostalCode;
                        opp.Billing_State_Province__c = trigger.new[i].BillingState;
                        oppUpdateList.add(opp);
                    }
                }
            }
            
        }
        if(oppUpdateList.size() > 0){
            update oppUpdateList;   
        }
   */         
        
        for(integer i=0;i<trigger.old.size();i++){
            //system.debug('@@@In If'+(trigger.old[i].ownerId != trigger.new[i].ownerId && trigger.new[i].parentId == ''));
          //  system.debug('@@@In If old ownerId'+trigger.old[i].ownerId);
          //  system.debug('@@@In If new Owner'+trigger.new[i].ownerId);
           // system.debug('@@@In If parentId'+trigger.new[i].parentId);
            //START Case 00056159 - DLOSEY - 10/25/13
            //if(trigger.old[i].ownerId != trigger.new[i].ownerId && (trigger.new[i].parentId == '' || trigger.new[i].parentId == null))
            if(trigger.old[i].ownerId != trigger.new[i].ownerId && (trigger.new[i].parentId == null))
            //END Case 00056159 - DLOSEY - 10/25/13
            {   if(trigger.new[i].ownerId <> BranchUserID)  { userIdAndAddFlag.put(trigger.new[i].ownerId,true); } if(trigger.old[i].ownerId <> BranchUserID) { userIdAndAddFlag.put(trigger.old[i].ownerId,false); }             }
           // system.debug('@@@userIdAndAddFlag'+userIdAndAddFlag);
            // Account is now owned by Branch Account
            // Only add to the list if ownerId = Branch Account and it was not beforehand
            if ((trigger.old[i].ownerId != trigger.new[i].ownerId) && (trigger.new[i].ownerId == BranchUserID)){   addAccountToQueue.add(trigger.new[i]);
                
                if (trigger.new[i].Branch__c != null){ branchCode.add(trigger.new[i].Branch__c); } else{ branchCode.add('000');      }
                
                 if(trigger.new[i].RecordTypeId == ETSrecordtypeID) {  ETSbranch = ((trigger.new[i].ETS_WMI_Branch_ID__c != null && trigger.new[i].ETS_WMI_Branch_ID__c != '') ? trigger.new[i].ETS_WMI_Branch_ID__c : '000');      mapAccIdETSbranch.put(trigger.new[i].ID,ETSbranch);       }
            }           
            
            // Account is now owned by a Sales Rep
            // Only add to the list if ownerId != Branch Account and it was beforehand
            if ((trigger.old[i].ownerId == BranchUserID) && (trigger.new[i].ownerId != BranchUserID)){  removeAccountFromQueue.add(trigger.old[i].Id);         }       
            
            // Account.Branch__c has changed AND still owned by Branch Account
            if ((trigger.old[i].ownerId == BranchUserID) && (trigger.new[i].ownerId == BranchUserID) && (trigger.old[i].Branch__c != trigger.new[i].Branch__c || trigger.old[i].ETS_WMI_Branch_ID__c != trigger.new[i].ETS_WMI_Branch_ID__c)){

                // Remove the Account from the existing queue
                removeAccountFromQueue.add(trigger.old[i].Id);             addAccountToQueue.add(trigger.new[i]);
                
                if (trigger.new[i].Branch__c != null){ branchCode.add(trigger.new[i].Branch__c); } else{ branchCode.add('000');    }    
               
               if(trigger.new[i].RecordTypeId == ETSrecordtypeID) {  ETSbranch = ((trigger.new[i].ETS_WMI_Branch_ID__c != null && trigger.new[i].ETS_WMI_Branch_ID__c != '') ? trigger.new[i].ETS_WMI_Branch_ID__c : '000');  mapAccIdETSbranch.put(trigger.new[i].ID,ETSbranch);   }
               
            }       
            
                        
        }

    }
    
    if (trigger.isDelete){
        system.debug('--------trigger.old[i].Id---------'+trigger.old.size());
        for(integer i=0;i<trigger.old.size();i++){
            //START Case 00056159 - DLOSEY - 10/25/13
            //if(trigger.old[i].parentId == '' || trigger.old[i].parentId == null)
            system.debug('--------trigger.old[i].Id---------'+trigger.old[i].Id);
            
            if(trigger.old[i].parentId == null)
            //END Case 00056159
            if(trigger.old[i].ownerId <> BranchUserID && (trigger.old[i].parentId == null)) { userIdAndAddFlag.put(trigger.old[i].ownerId,false); } 
            system.debug('--------trigger.old[i].Id---------'+trigger.old[i].Id);
            removeAccountFromQueue.add(trigger.old[i].Id);
            system.debug('--------trigger.old[i].Id---------'+removeAccountFromQueue);
                        
        }   
    
    }   
    //Added By Akanksha for Story S-151272
    system.debug('@@@@userIdAndAddFlag'+userIdAndAddFlag);
    if(userIdAndAddFlag.size() > 0 && !system.isbatch())  { MaintainBranchAccounts.updateUser(userIdAndAddFlag);   }
    //End By Akanksha for Story S-151272
    

    // Process the Accounts
    system.debug('------removeAccountFromQueue---------'+removeAccountFromQueue);
    if (removeAccountFromQueue.size() > 0){    MaintainBranchAccounts.removeAccountsFromQueue(removeAccountFromQueue);  }       

    if (addAccountToQueue.size() > 0){  MaintainBranchAccounts.addAccountsToQueue(addAccountToQueue, branchCode, mapAccIdETSbranch); }       
        
}