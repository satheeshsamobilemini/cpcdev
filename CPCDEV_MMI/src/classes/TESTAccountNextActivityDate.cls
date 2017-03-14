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
private class TESTAccountNextActivityDate {

    static testMethod void myUnitTest() {
    
		Date today = Date.Today();
		Date todayPlus7 = Date.Today() + 7;
		Date todayPlus30 = Date.Today() + 30;
		
		Account myAcct = New Account (Name='Test Account - TESTAccountNextActivityDate');
		insert myAcct;
		
		Task t1 = New Task(ActivityDate = todayPlus30, WhatId = myAcct.Id, Subject = 'Test Task - TESTAccountNextActivityDate');
		insert t1;
		
		/*
		Account acct = [Select Id, Next_Activity_Date__c From Account Where Id = :myAcct.Id];
		System.AssertEquals(todayPlus30, acct.Next_Activity_Date__c);
		*/
		
		Task t2 = New Task(ActivityDate = todayPlus7, WhatId = myAcct.Id, Subject = 'Test Task - TESTAccountNextActivityDate');
		insert t2;
		
		/*
		acct = [Select Id, Next_Activity_Date__c From Account Where Id = :myAcct.Id];
		System.AssertEquals(todayPlus7, acct.Next_Activity_Date__c);
		*/
		
		Task t3 = New Task(ActivityDate = today, WhatId = myAcct.Id, Subject = 'Test Task - TESTAccountNextActivityDate');
		insert t3;
		
		/*
		acct = [Select Id, Next_Activity_Date__c From Account Where Id = :myAcct.Id];
		System.AssertEquals(today, acct.Next_Activity_Date__c);
		*/
		Test.StartTest();
		t3.Status = 'Completed';
		t3.Call_Result__c = 'Spoke with Customer/Prospect';
		update t3;
		
		/*
		acct = [Select Id, Next_Activity_Date__c From Account Where Id = :myAcct.Id];
		System.AssertEquals(todayPlus7, acct.Next_Activity_Date__c);
		*/
		
		delete t2;
		
		/*
		acct = [Select Id, Next_Activity_Date__c From Account Where Id = :myAcct.Id];
		System.AssertEquals(todayPlus30, acct.Next_Activity_Date__c);
		*/
		
		t1.Status = 'Completed';
		t1.Call_Result__c = 'Spoke with Customer/Prospect';
		update t1;
		Test.StopTest();
		/*
		acct = [Select Id, Next_Activity_Date__c From Account Where Id = :myAcct.Id];
		System.AssertEquals(NULL, acct.Next_Activity_Date__c);
		*/
		
    }
}