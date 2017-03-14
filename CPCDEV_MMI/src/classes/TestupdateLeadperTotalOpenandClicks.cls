/**************************************************************************
Name: TestupdateLeadperTotalOpenandClicks
----------------------------------------------------------------------
Purpose: This class is created for trigger : updateLeadperTotalOpenandClicks 
Created by TEKsystem Development team
----------------------------------------------------------------------
**************************************************************************/

@isTest

public with sharing class TestupdateLeadperTotalOpenandClicks {
	
	
  static testmethod void myUnitTestMethod1(){
	  
	  Test.startTest();
	  
	  User u = MMIFullquoteTestDataProvider.getUser();  
	  u.Territory__c = '643-01';
	  insert u;
	       
      Branch_Lookup__c branch = new Branch_Lookup__c(Zip__c = '85282', County__c = 'USA',Territory__c = '643-01');
      insert branch; 
		       
      Lead l = new Lead(FirstName = 'Test First', LastName ='Last ',PostalCode = '85282' ,OwnerId = u.id);
      insert l;   
            
      Campaign camp = new Campaign(name = 'Test_iContact');
      insert camp;
      
      iContactforSF__iContact_Sent_Message__c cm =  new iContactforSF__iContact_Sent_Message__c(iContactforSF__Campaign__c = camp.id);
      insert cm;
      
      iContactforSF__iContact_Message_Statistic__c cmStat = new iContactforSF__iContact_Message_Statistic__c(iContactforSF__iContact_Sent_Message__c = cm.id,iContactforSF__Lead__c = l.id,iContactforSF__Opens__c = 0,iContactforSF__Clicks__c =0,iContactforSF__Campaign__c = camp.id); 
      insert cmStat;
            	
        cmStat.iContactforSF__Opens__c = 4;
        cmStat.iContactforSF__Clicks__c = 3;
        update cmStat;
             	
       Test.stopTest();
       
      }  
}