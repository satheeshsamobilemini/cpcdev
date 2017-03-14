/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class TestDuplicateLeadCheckingMetaPhone {

   public static testMethod void testScheduleAccountUpdateMetaPhoneKey() {
		List <Account> AccountList = new List<Account>();
	    for(integer i = 0; i<10; i++){
	        Account Acc = new Account();
		    Acc.Name = 'test'+i;
		    Acc.Type = 'Partner';
	        AccountList.add(Acc);
	    }
		insert AccountList;
		ScheduleAccountUpdateMetaPhoneKey sch = new ScheduleAccountUpdateMetaPhoneKey();
		sch.UpdateAccountMetaphone();
	}
	public static testMethod void testScheduleContactUpdateMetaPhoneKey() {
		Account Acc = new Account();
        Acc.Name = 'test';
        Acc.Type = 'Partner';
        insert Acc;
	        
	   List <Contact> ContactList = new List<Contact>();
	      for(integer i = 0; i<10; i++){
	        Contact con = new Contact();
	        con.FirstName = 'test'+i;
	        con.LastName = 'Partner'+i;
	        con.AccountId = Acc.Id;
	        con.Decision_Maker__c = 'Yes';
	        ContactList.add(con);
	      }
	    insert ContactList;
		ScheduleContactUpdateMetaPhoneKey sch = new ScheduleContactUpdateMetaPhoneKey();
		sch.UpdateContactMetaphone();
	}
	
	public static testMethod void testScheduleLeadUpdateMetaPhoneKey() {
		
		List <Lead> LeadList = new List<Lead>();
	    for(integer i = 0; i<10; i++){
	        Lead ldObj1 = new Lead();
	 		ldObj1.FirstName = 'testFn'+i;
	 		ldObj1.LastName = 'testLn'+i;
	 		ldObj1.Company = 'testCompany'+i;
	 		ldObj1.Phone = '9741857587';
	 		ldObj1.Status = 'Open';
	 		ldObj1.Rating = 'Hot (Probably Order)';
	 		ldObj1.RecordTypeId = '012800000007Ium';
	 		ldObj1.Decision_Maker__c = 'No';
	 		ldObj1.Primary_Contact_Method__c = 'Phone';
	 		ldObj1.LeadSource = 'ABI';
	 		ldObj1.Industry ='8-Mining';
	        LeadList.add(ldObj1);
	    }
		insert LeadList;
		ScheduleLeadUpdateMetaPhoneKey sch = new ScheduleLeadUpdateMetaPhoneKey();
		sch.UpdateLeadMetaphone();
	}
	public static testMethod void testSchedulingClassToUpdateAccountMetaPhone() {
		Test.StartTest();
		SchedulingClassToUpdateAccountMetaPhone sh = new SchedulingClassToUpdateAccountMetaPhone();
		String sch = '0 0 23 * * ?';
		system.schedule('Test', sch, sh);
		Test.stopTest();
	}
	public static testMethod void testSchedulingClassToUpdateContactMetaPhone() {
		Test.StartTest();
		SchedulingClassToUpdateContactMetaPhone sh = new SchedulingClassToUpdateContactMetaPhone();
		String sch = '0 0 23 * * ?';
		system.schedule('Test', sch, sh);
		Test.stopTest();
	}
	 public static testMethod void testScheduleLeadUpdateMetaPhoneKey1() {
		Test.StartTest();
		SchedulingClassToUpdateLeadMetaPhoneKey sh = new SchedulingClassToUpdateLeadMetaPhoneKey();
		String sch = '0 0 23 * * ?';
		system.schedule('Test', sch, sh);
		Test.stopTest();
	}
	public static testMethod void BatchApexToUpdateAccountTest() {
		
		   List <Account> AccountList = new List<Account>();
		      for(integer i = 0; i<10; i++){
		        Account Acc = new Account();
		        Acc.Name = 'test'+i;
		        Acc.Type = 'Partner';
		        AccountList.add(Acc);
		      }
		   
		   insert AccountList;
		   
		   Test.StartTest();
		   BatchApexToUpdateAccount BatchObj = new BatchApexToUpdateAccount();
		   ID batchprocessid = Database.executeBatch(BatchObj);
		   Test.StopTest();
	 }
	  public static testMethod void BatchApexToUpdateContactTest() {
			Account Acc = new Account();
	        Acc.Name = 'test';
	        Acc.Type = 'Partner';
	        insert Acc;
	        
		   List <Contact> ContactList = new List<Contact>();
		      for(integer i = 0; i<10; i++){
		        Contact con = new Contact();
		        con.FirstName = 'test'+i;
		        con.LastName = 'Partner'+i;
		        con.AccountId = Acc.Id;
		        con.Decision_Maker__c = 'Yes';
		        ContactList.add(con);
		      }
		   
		   insert ContactList;
		   
		   Test.StartTest();
		   BatchApexToUpdateContact BatchObj = new BatchApexToUpdateContact();
		   ID batchprocessid = Database.executeBatch(BatchObj);
		   Test.StopTest();
	 }
	 
	  public static testMethod void BatchApexToUpdateLeadTest() {
		
		   List <Lead> LeadList = new List<Lead>();
		      for(integer i = 0; i<10; i++){
		        Lead ldObj1 = new Lead();
		 		ldObj1.FirstName = 'testFn'+i;
		 		ldObj1.LastName = 'testLn'+i;
		 		ldObj1.Company = 'testCompany'+i;
		 		ldObj1.Phone = '9741857587';
		 		ldObj1.Status = 'Open';
		 		ldObj1.Rating = 'Hot (Probably Order)';
		 		ldObj1.RecordTypeId = '012800000007Ium';
		 		ldObj1.Decision_Maker__c = 'No';
		 		ldObj1.Primary_Contact_Method__c = 'Phone';
		 		ldObj1.LeadSource = 'ABI';
		 		ldObj1.Industry ='8-Mining';
		        LeadList.add(ldObj1);
		      }
		   
		   insert LeadList;
		   
		   Test.StartTest();
		   BatchApexToUpdateLead BatchObj = new BatchApexToUpdateLead();
		   ID batchprocessid = Database.executeBatch(BatchObj);
		   Test.StopTest();
	 }
}