/**
 
 */
@isTest
private class TestJobProfileUpdateTask {

    static testMethod void testUpdateJobProfileNameInTask() {
        
        Job_Profile__c jp = New Job_Profile__c(Name = 'test Job profile'+DateTime.now(), Job_Site_Zip__c = '90210-4444', Job_Site_Country__c = 'USA');
        insert jp;
        addTasks(jp.id);
        for(task t : [Select Id,job_Profile_ID__c ,job_Profile_Name__c,Status,Subject,whatId,whoId from Task where Job_Profile_Id__c = : jp.id]){
                System.debug('---'+jp.id +'---'+t.job_Profile_ID__c+'--'+t.job_Profile_Name__c);
        }
        jp.Name = 'Test Job profile'+DateTime.now().addDays(1);
        update jp;
        for(task t : [Select Id,job_Profile_ID__c ,job_Profile_Name__c,Status,Subject,whatId,whoId from Task where Job_Profile_Id__c = : jp.id]){
                System.debug('---'+jp.id +'---'+t.job_Profile_ID__c+'--'+t.job_Profile_Name__c);
        }
        
    }
    
     private static void addTasks(String jobProfileId) {
        
        List<Task> tasks = new List<Task>();
        for (Integer i = 0; i < 5; i++) {
            Task task = new Task();
            task.Subject= 'Call - '+i;
            task.Call_Type__c = 'IB - Existing Customer';
            task.Status = 'Completed';
            task.Priority = 'Normal';
            task.Call_Result__c = 'Spoke with Customer/Prospect';
            task.Job_Profile_ID__c = jobProfileId.substring(0,15);
            tasks.add(task);
        }
       
       Task task_1 = new Task();
            task_1.Subject= 'Call - 1';
            task_1.Call_Type__c = 'IB - Existing Customer';
            task_1.Status = 'In Progress';
            task_1.Priority = 'Normal';
            task_1.Call_Result__c = 'Spoke with Customer/Prospect';
            task_1.Job_Profile_ID__c = jobProfileId.substring(0,15);
            tasks.add(task_1); 
        
        insert tasks;
        
        task_1.Status = 'Completed';
        update task_1;
        
        task_1.Status = 'In Progress';
        update task_1;
        
    }
}