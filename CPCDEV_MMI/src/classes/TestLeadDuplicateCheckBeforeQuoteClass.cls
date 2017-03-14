@isTest
public class TestLeadDuplicateCheckBeforeQuoteClass {
    public static testMethod void testContoller() {
          Account objAcc = new Account();
            objAcc.Name = 'testAccount';
            objAcc.Type= 'test';
         insert objAcc;
         
         Lead objLead = new Lead();
          objLead.FirstName = 'testFirst';
          objLead.LastName = 'testLast';
          objLead.Email = 'test@gmail.com';
          objLead.Company = 'test';
         insert objLead;
          
         //ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(objAcc);
        ApexPages.currentPage().getParameters().put('ldId',objLead.id);
        ApexPages.currentPage().getParameters().put('qType','testType');
       // ApexPages.currentPage().getParameters().put('CF00N80000004bVA6_lkid','CF00N80000004bVA6_lkid');
        PageReference pageRef =new PageReference('/apex/LeadDuplicate?');
        Test.setCurrentPage(pageRef);
        LeadDuplicateCheckBeforeQuoteClass LDPC = NEW LeadDuplicateCheckBeforeQuoteClass();
         LDPC.qType ='fq';
         LDPC.redirectToQuote();
         LDPC.qType ='qq';
         LDPC.redirectToQuote();
         LDPC.FirstName ='testfirst';
         LDPC.customSearch();
         LDPC.LastName ='testlast';
         LDPC.customSearch();
         LDPC.Cancel();
         LDPC.hasMorethanTwoCharacter('test');
         LDPC.errorMessage('test msg');
         LDPC.encodeChars('test data');
         LDPC.getppcKeywordParam();
        // LDPC.setFields();
        
    }
}