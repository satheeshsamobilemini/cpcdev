@isTest
public class TestDeleteInactiveContactBatchProcessor {
    static testMethod void Test1(){
        String query = 'Select Id,Name,(select id from tasks where IsRecurrence  = true) from Contact where Inactivate_will_be_deleted__c = true or Name like \'Lead-%\' ';
        List<Contact> conList = new List<Contact>();
                
        for(integer i = 0; i<10; i++){
            Contact objContact = new Contact();
             objContact.FirstName = 'testFirst';
             objContact.LastName = 'testLast';
             objContact.Email = 'test@tek.com';
             objContact.Inactivate_will_be_deleted__c = true;
             objContact.Decision_Maker__c = 'Yes';
             conList.add(objContact);
         }
        
        Task objTask = new Task();
           objTask.Subject = 'test';
           objTask.Call_Type__c = 'OB - 2/3 Month Followup';
           objTask.WhoId = conList[0].id;
        insert objTask;
        
        Insert conList;
        Test.StartTest();
        DeleteInactiveContactBatchProcessor DICBP = new DeleteInactiveContactBatchProcessor();
        Database.executeBatch(DICBP);
        Test.StopTest();
    }
}