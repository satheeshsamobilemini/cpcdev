trigger UpdateActivityDateOnJobProfileTrigger on Task (before insert, before update) {
  
  if(TriggerSwitch.isTriggerExecutionFlagDisabled('Task','UpdateActivityDateOnJobProfileTrigger')){ return; }  
    List<Task> completedTasks = New List<Task>(); 
    List<Job_Profile__c> jobprofilesToUpdate = new List<Job_Profile__c>();
    //List<id> jobIds = new List<id>();
    Set<id> jobIds = new Set<id>();
    map<Id,string> mapJBTaskStatus = new map<Id,string>();
    List<Job_Profile__c> jobProfileUpdate = new List<Job_Profile__c>();
    
    if (trigger.isInsert || trigger.isUpdate){

        for (integer i=0;i<trigger.new.size();i++){
        
            // Only process if status = Completed
            if (trigger.new[i].Status == 'Completed' && trigger.new[i].Job_Profile_Id__c != null){
                // Add the jobIds to the list 
                if((trigger.new[i].Job_Profile_Id__c.length() == 15 || trigger.new[i].Job_Profile_Id__c.length() == 18))//// Added check for Job Profile custom field length by Najma Ateeq for #00051948 on 19 August 2013
                jobIds.add(trigger.new[i].Job_Profile_Id__c);
            }
            if(trigger.isInsert && trigger.new[i].Status != 'Completed' && trigger.new[i].Job_Profile_Id__c != null)
               mapJBTaskStatus.put(trigger.new[i].Job_Profile_ID__c,'Open');
               
            if(trigger.isInsert && trigger.new[i].Status == 'Completed' && trigger.new[i].Job_Profile_Id__c != null)
               mapJBTaskStatus.put(trigger.new[i].Job_Profile_ID__c,'Close');
               
            if(trigger.isUpdate && trigger.new[i].Status == 'Completed' && trigger.OldMap.get(trigger.new[i].Id).Status != 'Completed' && trigger.new[i].Job_Profile_Id__c != null)     
               mapJBTaskStatus.put(trigger.new[i].Job_Profile_ID__c,'OpenToClose');
               
            if(trigger.isUpdate && trigger.new[i].Status != 'Completed' && trigger.OldMap.get(trigger.new[i].Id).Status == 'Completed' && trigger.new[i].Job_Profile_Id__c != null)   
               mapJBTaskStatus.put(trigger.new[i].Job_Profile_ID__c,'CloseToOpen');
        }
        if(jobIds.size() > 0 || mapJBTaskStatus.keyset().size() > 0)
        {
            for(Job_Profile__c jobdata :[select id, Last_Activity_Date__c, Total_Open_Activities__c, Total_Complete_Activities__c from Job_Profile__c where Job_Profile__c.id in : jobIds or id in: mapJBTaskStatus.keyset()])
            {
               if(jobIds.contains(jobdata.Id))
               {
               //jobdata.Last_Activity_Date__c = system.now().date();
                jobdata.Last_Activity_Date__c = date.today();
                jobprofilesToUpdate.add(jobdata);
               }
               if(mapJBTaskStatus.containskey(jobdata.Id)){
                  jobdata.Total_Open_Activities__c = jobdata.Total_Open_Activities__c == null ? 0 : jobdata.Total_Open_Activities__c;
                  jobdata.Total_Complete_Activities__c = jobdata.Total_Complete_Activities__c == null ? 0 : jobdata.Total_Complete_Activities__c;
                    
                    if(mapJBTaskStatus.get(jobdata.Id) == 'Open'){
                        jobdata.Total_Open_Activities__c = jobdata.Total_Open_Activities__c + 1;
                        jobProfileUpdate.add(jobdata); 
                    }else if(mapJBTaskStatus.get(jobdata.Id) == 'Close'){
                        jobdata.Total_Complete_Activities__c = jobdata.Total_Complete_Activities__c + 1;
                        jobProfileUpdate.add(jobdata);
                    }else if(mapJBTaskStatus.get(jobdata.Id) == 'OpenToClose'){
                        jobdata.Total_Open_Activities__c = jobdata.Total_Open_Activities__c - 1;
                        jobdata.Total_Complete_Activities__c = jobdata.Total_Complete_Activities__c + 1;
                        jobProfileUpdate.add(jobdata);              
                   }else if(mapJBTaskStatus.get(jobdata.Id) == 'CloseToOpen'){
                        jobdata.Total_Open_Activities__c = jobdata.Total_Open_Activities__c + 1;
                        jobdata.Total_Complete_Activities__c = jobdata.Total_Complete_Activities__c - 1;
                        jobProfileUpdate.add(jobdata);
                   } 
               }               
            }
        }
        if(jobprofilesToUpdate.size() > 0)
        {
            upsert jobprofilesToUpdate;
        }
        
        if(jobProfileUpdate.size() > 0)
           update jobProfileUpdate;
        
    }  
}