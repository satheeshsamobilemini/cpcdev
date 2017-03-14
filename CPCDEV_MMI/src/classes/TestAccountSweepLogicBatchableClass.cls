/**************************************************************************
Name: TestAccountSweepLogicBatchableClass
----------------------------------------------------------------------
Purpose: This class is created to test AccountSweepLogic : account sweep process 
Created by TEKsystem Development team
----------------------------------------------------------------------
**************************************************************************/


@isTest
private with sharing class TestAccountSweepLogicBatchableClass{
  static testmethod void myTestMethod()
  {  Test.startTest();
  	
  	Account acc = new Account();
  		acc.Name = 'TestAccount1';
  		acc.Industry = '0-Non-classified/Unknown';
  		acc.Type = 'Prospect - National Account';
  		acc.Territory__c = '158-01';
		acc.BillingCountry = 'USA';
		insert acc;
   
   Set<ID> accSet = new Set<ID>(); 		
		accSet.add(acc.id);
     AccountSweepLogicBatchableClass accbatch = new AccountSweepLogicBatchableClass(accSet,system.now());
	 accbatch.isTest = True;
     Database.executeBatch(accbatch); 
	 Test.stopTest();
	 
  }
}