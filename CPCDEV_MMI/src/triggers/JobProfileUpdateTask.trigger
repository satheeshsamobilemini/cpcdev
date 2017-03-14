trigger JobProfileUpdateTask on Job_Profile__c (after update) {
if(TriggerSwitch.isTriggerExecutionFlagDisabled('Job_Profile__c','JobProfileUpdateTask')){
        return;
    }

    Map<Id,String> jobProfileNameMap = new Map<Id,String>();
    List<Task> taskToBeUpdated = new List<Task>();
    for(Job_Profile__c  jobProfile : trigger.new){
        if(jobProfile.Name != null &&  jobprofile.Name != trigger.oldMap.get(jobProfile.id).Name){
            jobProfileNameMap.put(jobProfile.id,jobProfile.Name);
        }
    }
    System.debug('--job profile Id set megha debug ---'+jobProfileNameMap);
    if(jobProfileNameMap.size() >0){
        for(Task t : [Select Id,job_Profile_ID__c ,Status,Subject,whatId,whoId from Task where Job_Profile_Id__c in : jobProfileNameMap.keySet()]){
            if(jobProfileNameMap.containsKey(t.job_profile_ID__c)){
                t.Job_Profile_Name__c = jobProfileNameMap.get(t.job_profile_ID__c); 
                taskToBeUpdated.add(t); 
            }
            if(taskToBeUpdated.size() ==199){
                update taskToBeUpdated;
                taskToBeUpdated.clear();
            }
        }
        if(taskToBeUpdated.size() > 0){
            update taskToBeUpdated;
        }
   }
}