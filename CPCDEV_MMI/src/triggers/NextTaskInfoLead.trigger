trigger NextTaskInfoLead on Task (after insert, after update) {
  
  if(TriggerSwitch.isTriggerExecutionFlagDisabled('Task','NextTaskInfoLead')){ return; }
   
  if(Trigger.new.size() == 1 ) {
    Task tk = Trigger.New[0];
    String str = tk.Whoid; 
    if(str != null && str.substring(0,3)== '00Q')
    {
         Lead leads= [select OwnerId,Next_Activity_Date__c,Last_Activity_Datetime__c from Lead where Id = :tk.WhoId ];

        List<Task> tskMin = [Select ActivityDate,Subject From Task where Whoid=:tk.Whoid and  Who.type = 'Lead' and Status != 'Completed'  order By ActivityDate limit 1];  
        List<Task> tskLastCompleted = [Select ActivityDate,Subject,Task_Completed_Date_Time__c From Task where Whoid=:tk.Whoid and  Who.type = 'Lead' and Status = 'Completed'  order By Task_Completed_Date_Time__c desc limit 1];
        if(tskLastCompleted.size() > 0){
            leads.Last_Activity_Datetime__c = tskLastCompleted[0].Task_Completed_Date_Time__c;
        }else{
            leads.Last_Activity_Datetime__c = null;
        }
        if (tskMin.size()>0) {
                leads.Next_Activity_Date__c = tskMin[0].ActivityDate;
                //leads.Last_Activity_Datetime__c = system.now();
        }
        else {
                leads.Next_Activity_Date__c = null;
                //leads.Last_Activity_Datetime__c = null;      
        }
        update leads;
    }
  }
}