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
private class TestSelectContact {

    static testMethod void myUnitTestForSelectContactController1() {
        // TO DO: implement unit test
        User u=MMIFullquoteTestDataProvider.getUser();
		//u.Alias = 'TESTUS';
		//u.username = 'TEST.USER@TEST.TEST';
		//insert u;
		System.runAs(u) {
		    Test.startTest();
		    Account accNewBussiness = MMIFullquoteTestDataProvider.getBusinessAccount();
	        accNewBussiness.Result_Id__c = 'P2557879';
	    	insert accNewBussiness;
            Contact conObj = new Contact();
	    	conObj.AccountId = accNewBussiness.Id;
	    	conObj.FirstName = 'etrte';
	    	conObj.LastName = 'etrte';
	    	insert conObj;
            Apexpages.currentPage().getParameters().put('id',accNewBussiness.Id);
       		Apexpages.currentPage().getParameters().put('operation','qq');
            SelectContactController sc = new SelectContactController();
            sc.getContactRecord();
            sc.conFn = 'testFn';
            sc.conLn = 'testLn';
            sc.conPh = 'conPh';
            sc.CreateContact();
            sc.next();
            
	        Test.stopTest();
	      
		}
    }
    
    static testMethod void myUnitTestForSelectContactController2() {
        // TO DO: implement unit test
        User u=MMIFullquoteTestDataProvider.getUser();
		//u.Alias = 'TESTUS';
		//u.username = 'TEST.USER@TEST.TEST';
		//insert u;
		System.runAs(u) {
		    Test.startTest();
		    Account accNewBussiness = MMIFullquoteTestDataProvider.getBusinessAccount();
	        accNewBussiness.Result_Id__c = 'P2557879';
	    	insert accNewBussiness;
            Contact conObj = new Contact();
	    	conObj.AccountId = accNewBussiness.Id;
	    	conObj.FirstName = 'etrte';
	    	conObj.LastName = 'etrte';
	    	insert conObj;
	    	
	    	Opportunity opp=MMIFullquoteTestDataProvider.getOpportunity();
	    	opp.AccountId = accNewBussiness.Id;
            insert opp;
            
            Apexpages.currentPage().getParameters().put('id',opp.Id);
       		Apexpages.currentPage().getParameters().put('operation','fq');
            SelectContactController sc = new SelectContactController();
            sc.getContactRecord();
            sc.conFn = '';
            sc.conLn = '';
            sc.conPh = 'conPh';
            sc.CreateContact();
            sc.next();
            
	        Test.stopTest();
	      
		}
    }
    
    static testMethod void myUnitTestForSelectContactController3() {
        // TO DO: implement unit test
        User u=MMIFullquoteTestDataProvider.getUser();
		//u.Alias = 'TESTUS';
		//u.username = 'TEST.USER@TEST.TEST';
		//insert u;
		System.runAs(u) {
		    Test.startTest();
		    Account accNewBussiness = MMIFullquoteTestDataProvider.getBusinessAccount();
	        accNewBussiness.Result_Id__c = 'P2557879';
	    	insert accNewBussiness;
               	
	    	Opportunity opp=MMIFullquoteTestDataProvider.getOpportunity();
	    	opp.AccountId = accNewBussiness.Id;
            insert opp;
            
            Apexpages.currentPage().getParameters().put('id',opp.Id);
       		Apexpages.currentPage().getParameters().put('operation','fq');
            SelectContactController sc = new SelectContactController();
            sc.getContactRecord();
            sc.conFn = '';
            sc.conLn = '';
            sc.conPh = 'conPh';
            sc.CreateContact();
            sc.next();
            
	        Test.stopTest();
	      
		}
    }
    
     static testMethod void myUnitTestForSelectContactController4() {
        // TO DO: implement unit test
        User u=MMIFullquoteTestDataProvider.getUser();
		//u.Alias = 'TESTUS';
		//u.username = 'TEST.USER@TEST.TEST';
		//insert u;
		System.runAs(u) {
		    Test.startTest();
		    Account accNewBussiness = MMIFullquoteTestDataProvider.getBusinessAccount();
	        accNewBussiness.Result_Id__c = 'P2557879';
	    	insert accNewBussiness;
            Contact conObj = new Contact();
	    	conObj.AccountId = accNewBussiness.Id;
	    	conObj.FirstName = 'etrte';
	    	conObj.LastName = 'etrte';
	    	insert conObj;	 	    	
	    	Opportunity opp=MMIFullquoteTestDataProvider.getOpportunity();
	    	opp.AccountId = accNewBussiness.Id;
            insert opp;
            
            Apexpages.currentPage().getParameters().put('id',opp.Id);
       		Apexpages.currentPage().getParameters().put('operation','clone');
       		Apexpages.currentPage().getParameters().put('fqId','124312412');
            SelectContactController sc = new SelectContactController();
            sc.getContactRecord();
            sc.selectedConId = conObj.Id;
            sc.next();
            
	        Test.stopTest();
	      
		}
    }
}