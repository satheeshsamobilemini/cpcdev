/**************************************************************************
Name: TESTPecProjectUpdatePostalCode
----------------------------------------------------------------------
Purpose: Test Class for trigger  : PecProjectUpdatePostalCode
Created by TEKsystem Development team
----------------------------------------------------------------------
**************************************************************************/

@isTest private with sharing class TESTPecProjectUpdatePostalCode {
 // method for Insert Operation : PEC Project..  
  static testMethod void myUnitTest1() {	
	User usrObj = MMIFullquoteTestDataProvider.getUser();
	system.runAs(usrObj){
		Test.startTest();
		
		Branch_Lookup__c bl = new Branch_Lookup__c(Zip__c = '90320', Branch_Code__c = '241' ,Territory__c = '234-01');
		insert bl;		
		
		Pec_Project__c pc = New Pec_Project__c(Project_Name__c = 'Test', Zip__c = '90320-3333', Country__c = 'US');
      	insert pc;
      	
      	// Quering to perform assert operations.. 
      	Pec_Project__c pcAfterInsert = [Select id, Branch_Id__c,Territory__c, Zip__c From Pec_Project__c Where id = :pc.Id  LIMIT 1];
      	Branch_Lookup__c blAfterInsert = [Select Id, Branch_Code__c,Territory__c from Branch_Lookup__c where Zip__c = '90320' and id =:bl.id LIMIT 1]; 
      	
      	system.assertequals(pcAfterInsert.Id, pc.Id);
      	system.assertequals(blAfterInsert.Branch_Code__c, pcAfterInsert.Branch_ID__c);
      	system.assertequals(blAfterInsert.Territory__c, pcAfterInsert.Territory__c);		
	
	   Test.stopTest();
	}
   }

// method for update operation : PEC Project.. 
/*     static testMethod void myUnitTest2() {	
	User usrObj = MMIFullquoteTestDataProvider.getUser();
	system.runAs(usrObj){
		Test.startTest();
		
		Branch_Lookup__c bl = new Branch_Lookup__c(Zip__c = '90320', Branch_Code__c = '241' ,Territory__c = '234-01');
		insert bl;		
		
		Branch_Lookup__c bl2 = new Branch_Lookup__c(Zip__c = '96543', Branch_Code__c = '113' ,Territory__c = '312-02');
		insert bl2;	
		
		Pec_Project__c pc = New Pec_Project__c(Project_Name__c = 'Test', Zip__c = '90320-3333', Country__c = 'US');
      	insert pc;
      	
      	system.debug('---------- pc.Branch_ID__c ------------------' + pc.Branch_ID__c);
      	system.debug('------------- pc.Territory__c ------------' + pc.Territory__c);
      	
      	// Quering to perform assert operations.. 
      	Pec_Project__c pcToUpdate = [Select id, Branch_Id__c, Zip__c,Territory__c From Pec_Project__c Where id = :pc.Id LIMIT 1];
      	Branch_Lookup__c bl2AfterInsert = [Select Id, Branch_Code__c,Territory__c from Branch_Lookup__c where Zip__c = '96543' and id =: bl2.id LIMIT 1 ]; 
      	
      	system.debug('---------- pcToUpdate.Branch_ID__c ------------------' + pcToUpdate.Branch_ID__c);
      	system.debug('------------- pcToUpdate.Territory__c ------------' + pcToUpdate.Territory__c);
      	
      	// for update..
      	pcToUpdate.Zip__c = '96543-4444';
      	update pcToUpdate;
      	
      	system.debug('---------- pc.Branch_ID__c ------------------' + pc.Branch_ID__c);
      	system.debug('------------- pc.Territory__c ------------' + pc.Territory__c);
      	
      	system.assertequals(pcToUpdate.Id, pc.Id);
      	system.assertequals(bl2AfterInsert.Branch_Code__c, pcToUpdate.Branch_ID__c);
      	system.assertequals(bl2AfterInsert.Territory__c,pcToUpdate.Territory__c);
      	      	
	    Test.stopTest();
	}
   } 
*/   
   // method for update operation (No value for ZipCode): PEC Project.. 
     static testMethod void myUnitTest3() {	
	User usrObj = MMIFullquoteTestDataProvider.getUser();
	system.runAs(usrObj){
		Test.startTest();
		
		Branch_Lookup__c bl = new Branch_Lookup__c(Zip__c = '90320', Branch_Code__c = '241' ,Territory__c = '234-01');
		insert bl;		
		
		Branch_Lookup__c bl2 = new Branch_Lookup__c(Zip__c = '96543', Branch_Code__c = '193' ,Territory__c = '312-02');
		insert bl2;	
		
		Pec_Project__c pc = New Pec_Project__c(Project_Name__c = 'Test', Zip__c = '90320-3333', Country__c = 'US');
      	insert pc;
      	
      	// Quering to perform assert operations.. 
      	Pec_Project__c pcToUpdate = [Select id, Branch_Id__c, Zip__c, Territory__c From Pec_Project__c Where id = :pc.Id LIMIT 1];
      	Branch_Lookup__c bl2AfterInsert = [Select Id, Branch_Code__c,Territory__c from Branch_Lookup__c where Zip__c = '96543' and id =: bl2.id LIMIT 1]; 
      	
      	// for update..
      	pcToUpdate.Zip__c = '';
      	update pcToUpdate;
      	
      	system.assertequals(pcToUpdate.Id, pc.Id);
      	system.assertequals(NULL, pc.Branch_ID__c);
      	system.assertequals(NULL, pc.Territory__c);
      	      	
	    Test.stopTest();
	}
   } 
}