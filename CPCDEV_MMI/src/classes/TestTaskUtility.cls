//-------------------------------------------------------------------
// Name : TestTaskUtility
// Created By : Alka Taneja
// Created Date : 17 May 2013
//-------------------------------------------------------------------
@isTest(seeAllData=false)
public with sharing class TestTaskUtility {
	
	static testMethod void unitTest() {
		
		Test.startTest();
		
		Account acc = new Account();
   	acc.Name = 'accName';
   	acc.phone = '1111111111';
   	insert acc;
   	
   	acc = [select id, name, phone, OwnerId from Account where id = :acc.id];
   	
   	Contact con = new Contact();
	  con.FirstName = 'MethodFirstleadNameTest';
	  con.LastName = 'accName';
	  con.phone = '1111111111';
	  con.AccountId = acc.id;
	  insert con;
	  
	  Task tsk = new Task();
    tsk.OwnerId = acc.OwnerId;  
    tsk.Subject = 'Contact Notification';
    tsk.WhatId =  acc.Id;   
    tsk.whoId = con.id;                      
    insert tsk;
	  
	  Set<String> setConId = new Set<String>();
	  setConId.add(con.Id);
	  
		TaskUtility.updateTask(setConId); 
		
		Test.stopTest();
	}

}