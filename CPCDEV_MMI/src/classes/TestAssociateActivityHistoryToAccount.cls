/**
 * 
 */
@isTest
private class TestAssociateActivityHistoryToAccount {

    static testMethod void testassociatedActivityHistory() {
    	
    	List<Account> accountList = new List<Account>();
    	
    	Account account = new Account(name='Test Account - 1');
    	accountList.add(account);
    	
    	Account account1 = new Account(name='Test Account Gold Notes');
    	accountList.add(account1);
    	
    	insert accountList;
    	System.assert(account.Id != null);
    	System.assert(account1.Id != null); 
    	
    	List<Contact> contactList = new List<Contact>();
    	Contact con  = new Contact(LastName='Test Conatct',AccountId= account.Id);
    	contactList.add(con);
    	
    	Contact con1  = new Contact(LastName='Test Conatct - 1',AccountId= account1.Id);
    	contactList.add(con1);
    	insert contactList;
    	
    	System.assert(con.id != null);
    	System.assert(con1.id != null); 
    	
    	System.Debug('Query Rows >>>>>>>>'+Limits.getQueryRows());
    	Task task = new Task(Subject='call',WhoId=con.id,whatId=null,ActivityDate=Date.Today().addDays(5),status='completed',Call_Result__c='Left Voice Mail/Message');
    	//Test.startTest();
    	insert task;
    	System.Debug('task who Id >>'+task.whoId);    	
    	List<Event> eventList= new List<Event>();
    	Event event = new Event(Subject='call',WhoId=con.id,Call_Result__c='Left Voice Mail/Message',StartDateTime=DateTime.now(),endDateTime = DateTime.now().addHours(2));
    	eventList.add(event);
    	
    	/*Event event1 = new Event(Subject='Send',whoId=con.id,Call_Result__c='Left Voice Mail/Message',StartDateTime=DateTime.now(),endDateTime = DateTime.now().addHours(4));
    	eventList.add(event1);*/
    	
    	
    	insert eventList;
    	
    	test.startTest();
    	delete contactList;
    	test.stopTest();
    	
    	Set<String> accountIdSet = new Set<String>();
    	accountIdSet.add(account.id); 
    	accountIdSet.add(account1.id);
    	/*List<Task> taskList = [select Id,whatId from Task where whatId in :  accountIdSet];
    	System.assertEquals(taskList.size(),2);*/
    	
    	List<Event> eventList1 = [select Id,whatId from Event where whatId =: account.id];
    	//System.assertEquals(eventList1.size(),1);
    	
    }
}