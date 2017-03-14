trigger OpportunityNextTaskInfo on Task (after insert, after update ,after delete) {
 
 if(TriggerSwitch.isTriggerExecutionFlagDisabled('Task','OpportunityNextTaskInfo')){ return;}
    
  Map<Id , Opportunity> oppsToUpdate = new Map<Id,Opportunity>();
  //Added delete event by reena for story -140256 so added insert/update condition here for existing code.
  
  if((Trigger.isInsert || Trigger.isUpdate) && Trigger.new.size() == 1 && RecursiveTriggerUtility.isNextTaskInfoOpportunity == false) {
    Task tk = Trigger.New[0];
    String str = tk.whatid; 
    if(str != null && str.substring(0,3)== '006')
    {
         //Added createdDate in query as next activity date was not updating properly .Issue reported by kim under S-140256
         Opportunity opp = [select OwnerId,Createddate,Next_Scheduled_Activity__c ,Next_Activity_Date__c,Last_Activity_Datetime__c from Opportunity where Id = :tk.WhatId ];

        List<Task> tskMin = [Select ActivityDate,Subject From Task where whatid=:tk.whatid and  what.type = 'Opportunity' and Status != 'Completed' order By ActivityDate limit 1];
        List<Task> tskLastCompleted = [Select ActivityDate,Subject,Task_Completed_Date_Time__c From Task where whatid=:tk.whatid and  what.type = 'Opportunity' and Status = 'Completed' order By Task_Completed_Date_Time__c desc limit 1];  
        
        if(tskLastCompleted.size() > 0){
            opp.Last_Activity_Datetime__c = tskLastCompleted[0].Task_Completed_Date_Time__c;
        }else{
            opp.Last_Activity_Datetime__c = null;        
        }
        
        if (tskMin.size()>0) {
                opp.Next_Activity_Date__c =tskMin[0].ActivityDate;
        }
        else {
                opp.Next_Activity_Date__c =null;
        }
        if(date.valueOf(opp.CreatedDate) > date.newinstance(2012, 02, 08)){
           // update opp;
           oppsToUpdate.put(opp.Id, opp);
        }
    }
}


    //Added by Reena for story : S-140256
    //Note : Code above this block is not handling bulk trigger so we have not done any changes on that.
     List<Task> tasks = new List<Task>();
     if(Trigger.isDelete)
         tasks = Trigger.Old;
     else
         tasks = Trigger.New;     
        
    //Get data to be updated 
    oppsToUpdate = ActivityManagement.updateNextActivityOnOpportunity(tasks, null, oppsToUpdate);
    //Update opportunity.
    update oppsToUpdate.values();
    RecursiveTriggerUtility.isNextTaskInfoOpportunity = true;
    //End of Reena's changes for S-140256   
}