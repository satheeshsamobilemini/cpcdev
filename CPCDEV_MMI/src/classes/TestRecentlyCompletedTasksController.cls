/*************************************************************************
Name          : TestRecentlyCompletedTasksController
Usage         : Test class for class RecentlyCompletedTasksController.
Created By    : Parth Tamhaney
Created Date  : July 14, 2009

Modified By   : Aashish Mathur
Modified Date : Nov 30, 2009
*************************************************************************/

@isTest
private class TestRecentlyCompletedTasksController {
    private static Account account;
    
    @isTest
    public static void test_RecentlyCompletedTasksController() {
        setupAccountandContact();
        
        ApexPages.StandardController stdCtrl = new ApexPages.StandardController(account);
        
        RecentlyCompletedTasksController controller = new RecentlyCompletedTasksController(stdCtrl);
        System.assertEquals(controller.relatedTask.size(), 0);
        
        addTasks();
        controller = new RecentlyCompletedTasksController(stdCtrl);
        System.assertEquals(controller.relatedTask.size(), 5);
        
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
    }
    
    @isTest
    private static void setupAccountandContact() {
        account = new Account(Name= 'testAccount', shippingcountry='USA', shippingPostalCode='83527');
        insert account;
        
        List<Contact> listContact = new List<Contact>();
        for (Integer i = 0; i < 4; i++) {
            Contact contact = new Contact();
            contact.AccountId = account.Id;
            contact.FirstName = 'firstName' + i;
            contact.LastName = 'LastName' + i;
            listContact.add(contact);
        }
        
        insert listContact;
    }
    
    @isTest
    private static void addTasks() {
        if (account == null) {
            return;
        }
        
        List<Task> relatedTask = new List<Task>();
        for (Integer i = 0; i < 5; i++) {
            Task task = new Task();
            task.Subject= 'Call';
            task.Call_Type__c = 'IB - Existing Customer';
            task.Status = 'Completed';
            task.Priority = 'Normal';
            task.Whatid = account.Id;
            task.Call_Result__c = 'Spoke with Customer/Prospect';
            relatedTask.add(task);
        }
        
        insert relatedTask;
    }
}