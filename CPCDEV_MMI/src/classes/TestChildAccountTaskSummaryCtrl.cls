/*************************************************************************
Name          : TestChildAccountTaskSummaryCtrl
Usage         : Test class for class ChildAccountTaskSummaryController.
Created By    : Megha Agarwal(Appirio Offshore)
Created Date  :  May 25, 2010
*************************************************************************/

@isTest
private class  TestChildAccountTaskSummaryCtrl {
		
	@isTest
    public static void test_childAccountTasksSummaryController() {
    	//insert parent Acocunt
    	Account parentAccount = setAccount('Test Parent Account','USA','21138',null);
    	System.assert(parentAccount.id != null);
    	
    	Contact contact = new contact(AccountId =parentAccount.id,firstName ='Test',lastName ='Contact');
    	insert contact;
    	System.assert(contact.id != null);
    	
    	//Insert child Accounts
	    Account childAccount1 = setAccount('Test Child Account - 1','USA','21138',parentAccount.Id);
	    System.assert(childAccount1.id!=null);
	    Account childAccount2 = setAccount('Test Child Account - 2','USA','21138',parentAccount.Id);
	    System.assert(childAccount2.id!=null);
	    
	    ApexPages.StandardController stdController = new ApexPages.StandardController(parentAccount);
        childAccountTaskSummaryController controller = new childAccountTaskSummaryController(stdController);
        System.assertEquals(controller.taskSummaryList.size(),0);
        
        //insert tasks
        List<Task> taskList = new List<Task>();
        Task t = setTask('Call',Date.Today().addDays(-5),'IB - Existing Customer','Completed',childAccount1.Id,contact.id,'Spoke with Customer/Prospect');
        taskList.add(t);
        
        Task t1 = setTask('Send Quote',Date.Today().addDays(-8),'IB - Existing Customer','Not started',childAccount1.Id,contact.id,'Spoke with Customer/Prospect');
	    taskList.add(t1);
	    
	    Task t2 = setTask('Send Mail',Date.Today(),'IB - Existing Customer','In progress',childAccount1.Id,null,'Spoke with Customer/Prospect');
	    taskList.add(t2);
	    
	    Task t3 = setTask('Other',Date.Today().addDays(-3),'IB - Existing Customer','Not started',childAccount2.Id,contact.id,'Spoke with Customer/Prospect');
	    taskList.add(t3);
	    
	    Task t4 = setTask('Send Mail',Date.Today().addDays(-2),'IB - Existing Customer','In progress',childAccount2.Id,null,'Spoke with Customer/Prospect');
	    taskList.add(t4);
	    
	    Task t5 = setTask('Other',Date.Today().addDays(-6),'IB - Existing Customer','In progress',childAccount2.Id,contact.id,'Spoke with Customer/Prospect');
	    taskList.add(t5);
	    insert taskList;
	    
	    controller = new childAccountTaskSummaryController(stdController);  
	    System.assertEquals(controller.taskSummaryList.size(),6);
	    
	    controller.orderBy = 'Subject';
        controller.sortData();
        System.assertEquals(controller.imgSrc, '/img/sort_desc_arrow.gif');
        controller.sortData();
        System.assertEquals(controller.imgSrc, '/img/sort_asc_arrow.gif');
        
        controller.orderBy = 'ActivityDate';
        controller.sortData();
        System.assertEquals(controller.imgSrc, '/img/sort_desc_arrow.gif');
        controller.sortData();
        System.assertEquals(controller.imgSrc, '/img/sort_asc_arrow.gif');
        
        controller.orderBy = 'Who.Name';
        controller.sortData();
        System.assertEquals(controller.imgSrc, '/img/sort_desc_arrow.gif');
        controller.sortData();
        System.assertEquals(controller.imgSrc, '/img/sort_asc_arrow.gif');
        
        controller.orderBy = 'What.Name';
        controller.sortData();
        System.assertEquals(controller.imgSrc, '/img/sort_desc_arrow.gif');
        controller.sortData();
        System.assertEquals(controller.imgSrc, '/img/sort_asc_arrow.gif');
	    
	    
        controller.orderBy = 'CallType';
        controller.sortData();
        System.assertEquals(controller.imgSrc, '/img/sort_desc_arrow.gif');
        controller.sortData();
        System.assertEquals(controller.imgSrc, '/img/sort_asc_arrow.gif');
	    
    }
    
    private static Account setAccount(String testAccount,String country,String zipcode,String parentAccountId){
    	 Account account = new Account(Name= testAccount, shippingcountry=country, shippingPostalCode=zipcode);
    	 if(parentAccountId != null){
    	 	account.ParentId = parentAccountId;
    	 }
    	 insert account; 
         return account;
    }
    
    private static Task setTask(String subject,Date ActivityDate,String callType,String status,String what,String who,String callResult){
    	Task task = new Task();
         task.Subject= subject;
         task.ActivityDate = ActivityDate;
	     task.Call_Type__c = callType;
	     task.Status = status;
	     if(who != null)
	     	task.WhoId = who;
	     task.Priority = 'Normal';
	     task.Whatid =what;
	     task.Call_Result__c = callResult;
	     return task;	
    }

}