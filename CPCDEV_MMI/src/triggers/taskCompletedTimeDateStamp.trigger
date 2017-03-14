trigger taskCompletedTimeDateStamp on Task (before insert, before update) {
  
  if(TriggerSwitch.isTriggerExecutionFlagDisabled('Task','taskCompletedTimeDateStamp')){ return; } 
    List<Task> completedTasks = New List<Task>(); 

    if (trigger.isInsert){

        for (integer i=0;i<trigger.new.size();i++){
        
            // Only process if status = Completed
            if (trigger.new[i].Status == 'Completed'){
                // Add the Task to the list 
                completedTasks.add(trigger.new[i]);
            }
        
        }

    }
    
    if (trigger.isUpdate){
    
        for (integer i=0;i<trigger.new.size();i++){
        
            // Only process if status changes to completed and it was not previously
            // AND 
            // there is not a current time stamp
            if ((trigger.old[i].Task_Completed_Date_Time__c == null) && ((trigger.new[i].Status == 'Completed') && (trigger.old[i].Status != 'Completed'))){
                // Add the Task to the list 
                completedTasks.add(trigger.new[i]);
            }
        
        }

    }
    
    // See if we have any Tasks to process
    if (completedTasks.Size() > 0){
        taskCompletedTimeDateStamp.timeStampCompletedTasks(completedTasks);
    } 
}