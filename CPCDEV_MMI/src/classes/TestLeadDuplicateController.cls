/*********************************************************************
Name  : TestLeadDuplicateController
Author: Kirtesh Jain(Appirio)
Date  : August 24, 2009
Usage : Used as TestClass  for LeadDuplicateController
*********************************************************************/

@isTest
private class TestLeadDuplicateController {
 
 private static Lead insertLeadAccountContact(){
     List<Lead> leadlist = new list<Lead>();
     
     for( integer i = 0 ; i < 5; i++ ){
       
       Lead lead = new Lead();
       lead.firstname = 'MethodFirstleadNameTest';
       lead.phone = '90090909'+i;
       if( i < 3 ){
        lead.Company = 'testmethodcompany';
       }
       lead.Lastname = 'MethodLastNametest';
       leadlist.add(lead);
     }
     
     insert leadlist ;
     
     List<Account> accountLIst = new List<Account>();
     for( integer i = 0 ; i < 5 ;i++ ){
       Account acc = new Account();
       acc.Name = 'accName';
       acc.phone = '90090909'+i;
       accountLIst.add(acc);
     }
     insert accountLIst ;
     
     List<contact> ContactLIst = new List<Contact>();
     for( integer i = 0 ; i < 5; i++ ){
       Contact con = new Contact();
       con.FirstName = 'MethodFirstleadNameTest';
       con.LastName = 'accName';
       con.phone = '90090909'+i;
       ContactLIst.add(con);
     }
     insert ContactLIst ;
     
     return leadlist[0];
 }	
	
 static testMethod void Test_TestLeadDuplicateController() {
    ApexPages.currentPage().getParameters().put('00N800000042rYJ','1234');
    PageReference pageRef = Page.LeadDuplicate;
    Test.setCurrentPage(pageRef);
    Lead lead = insertLeadAccountContact();
    ApexPages.StandardCOntroller stdcontroller = new ApexPages.StandardController(lead);
    LeadDuplicateController leadDuplicate = new  LeadDuplicateController(stdcontroller);
    leadDuplicate.chkboxFirstName = true ;
	leadDuplicate.chkboxLastName = true ;
	leadDuplicate.chkboxphone  = false ;
	leadDuplicate.chkboxCompany = false ;
	leadDuplicate.firstName = 'MethodFirstleadNameTest';
	leadDuplicate.LastName = 'MethodLastNametest';
	leadDuplicate.customSearch() ;
	System.assertEquals(leadDuplicate.countAccount , 0 );
	System.assertEquals(leadDuplicate.countLead,  5  ) ;
	System.assertEquals(leadDuplicate.countContact,0);
    leadDuplicate.Cancel();
    leadDuplicate.chkboxphone  = true ;
	leadDuplicate.chkboxCompany = true ;
    leadDuplicate.phone = '900909091';
	leadDuplicate.Company = 'testmethodcompany';
    leadDuplicate.customSearch() ;
    System.assertEquals(leadDuplicate.countAccount , 0 );
	System.assertEquals(leadDuplicate.countLead,  1  ) ;
	System.assertEquals(leadDuplicate.countContact,0);
    leadDuplicate.createNewLead();
    leadDuplicate.chkboxphone  = false;
	leadDuplicate.chkboxCompany = false ;
    leadDuplicate.chkboxFirstName = false ;
    leadDuplicate.customSearch() ;
    System.assertEquals(leadDuplicate.countLead,  5  ) ;
    leadDuplicate.chkboxphone  = true;
    leadDuplicate.phone = '90090909';
    leadDuplicate.chkboxLastName = false ;
    leadDuplicate.customSearch() ;
    System.assertEquals(leadDuplicate.countAccount ,5 );
	System.assertEquals(leadDuplicate.countLead, 5  ) ;
	System.assertEquals(leadDuplicate.countContact,5);
	leadDuplicate.phone = '1' ;
	leadDuplicate.customSearch() ;
	leadDuplicate.chkboxLastName = true ;
	leadDuplicate.lastName = '1' ;
	leadDuplicate.customSearch() ;
  }
  
  static testmethod void testPPCKeywordParam(){
  	
  	
    Lead lead = insertLeadAccountContact();
    PageReference pageRef = Page.LeadDuplicate;
    Test.setCurrentPage(pageRef);
    ApexPages.currentPage().getParameters().put('00N800000042rYJ','1234');
    ApexPages.StandardCOntroller stdcontroller = new ApexPages.StandardController(lead);
    LeadDuplicateController leadDuplicate = new  LeadDuplicateController(stdcontroller);
    leadDuplicate.chkboxFirstName = true ;
	leadDuplicate.chkboxLastName = true ;
	leadDuplicate.chkboxphone  = false ;
	leadDuplicate.chkboxCompany = false ;
	leadDuplicate.firstName = 'MethodFirstleadNameTest';
	leadDuplicate.LastName = 'MethodLastNametest';
	leadDuplicate.customSearch() ;
	leadDuplicate.createNewLead();
	
  }
    
}