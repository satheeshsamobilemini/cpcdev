/*************************************************************************
Name          : TestTaskOnOpportunityController
Usage         : Test class for class TaskOnOpportunityController.
Created By    : Megha Agarwal
Created Date  : August 25, 2010

*************************************************************************/
@isTest
private class TestTaskOnOpportunityController {
    
    private static Opportunity opportunity; 
    
    static testMethod void testTaskOnOpportunity() {
    	Account myAcct = New Account (Name='Test Account - TESTAccountNextActivityDate');
		insert myAcct;
		
        setupOpportunity(myAcct.id);
        
        ApexPages.StandardController stdCtrl = new ApexPages.StandardController(opportunity);
        
        TaskOnOpportunityController controller = new TaskOnOpportunityController(stdCtrl);
        System.assertEquals(controller.taskList.size(), 0);
        
        addTasks();
        controller = new TaskOnOpportunityController(stdCtrl);
        System.assertEquals(controller.taskList.size(), 1);
        
        controller.orderBy = 'Subject';
        controller.sortData();
        System.assertEquals(controller.imgSrc, '/img/sort_desc_arrow.gif');
        controller.sortData();
        System.assertEquals(controller.imgSrc, '/img/sort_asc_arrow.gif');
        
    }
    
    private static void setupOpportunity(Id acctId) {
        opportunity = new Opportunity(Name= 'testOpportunity',stageName='Working',closeDate = Date.Today().addDays(10), accountId = acctId);
        insert opportunity;
        
    }
    
    private static void addTasks() {
        if (opportunity == null) {
            return;
        }
        
        List<Task> relatedTask = new List<Task>();
        for (Integer i = 0; i < 1; i++) {
            Task task = new Task();
            task.Subject= 'Call';
            task.Call_Type__c = 'IB - Existing Customer';
            task.Status = 'Completed';
            task.Priority = 'Normal';
            task.Whatid = opportunity.Id;
            task.Call_Result__c = 'Spoke with Customer/Prospect';
            relatedTask.add(task);
        }
        
        insert relatedTask;
    }
        
}