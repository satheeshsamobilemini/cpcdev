/*******************************************************************
Name : UpdateLastActivityDateOfJobProfileBatch
Created By : Appirio Offshore (Akanksha)
Created Date : 30 November 2012
Description : Batch class to populate the data in the last activity date field of job profile
**********************************************************************/
global class UpdateLastActivityDateOfJobProfileBatch implements Database.Batchable<sObject> {


    
    public String jobQuery;
    
    global UpdateLastActivityDateOfJobProfileBatch() {
        jobQuery = 'select id, Job_Profile_Id__c,Task_Completed_Date_Time__c from task  where task.Status = \'Completed\' and Task.Job_Profile_Id__c != null';
         }

    global Database.QueryLocator start(Database.BatchableContext info){
         if(test.isRunningTest()){
        jobQuery += ' LIMIT 1 ' ;
        }
        return Database.getQueryLocator(jobQuery);
    }
    
    global void execute(Database.BatchableContext info, List<task> jobQueryData){
   			Map<id,task> jobMap = new Map<id,task>();
   			List<Job_Profile__c> jobprofilesToUpdate = new List<Job_Profile__c>();
           for(Task data :jobQueryData)
           {
           		jobMap.put(data.Job_Profile_Id__c, data);
           }
           if(jobMap.size() > 0)
			{
			for(Job_Profile__c jobdata :[select id, Last_Activity_Date__c from Job_Profile__c where Job_Profile__c.id in : jobMap.keySet()])
			{
				Task taskData = jobMap.get(jobdata.id);
				if(taskData != null && (jobdata.Last_Activity_Date__c == null || taskData.Task_Completed_Date_Time__c.Date() > jobdata.Last_Activity_Date__c ))
				{
					jobdata.Last_Activity_Date__c = taskData.Task_Completed_Date_Time__c.Date();
					jobprofilesToUpdate.add(jobdata);
				}
				
			}
		}
		if(jobprofilesToUpdate.size() > 0)
		{
			upsert jobprofilesToUpdate;
		}
    }
    
    global void finish(Database.BatchableContext info){
        
    }
    
    @isTest
    public static void UpdateLastActivityDateOfJobProfileBatchTest(){
       UpdateLastActivityDateOfJobProfileBatch jobRptbatch = new UpdateLastActivityDateOfJobProfileBatch();
       //accountRptbatch.accountQuery += ' limit 10';
       Test.startTest();
       Database.executeBatch(jobRptbatch, 1);
       Test.stopTest();
   }


}