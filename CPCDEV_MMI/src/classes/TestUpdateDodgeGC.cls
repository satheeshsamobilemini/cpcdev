/**
 * Created By Akanksha Bhatia on 09/20/2013 for trigger UpdateDodgeGC.trigger
 */
@isTest
private class TestUpdateDodgeGC {

    static testMethod void myUnitTest() {
        
        Dodge_Project__c dodge = TestRemoveDodgeManagementController.createDodgeProject(); // Sales Restructure 2015 
        
        Test.startTest();
        
        Account acc = new Account(Name ='Test Account',FactorKey__c ='SNOOK23',CKMS__c ='CKS00000012',Branch__c ='890', isSPOC_Account__c =True);
        insert acc;
        
        Company__c comp1 = new Company__c( Factor_Type__c='Construction Manager', Dodge_Project__c = dodge.id, Dodge_Report_Number__c='13324');
        insert comp1;
        
        Company__c comp2 = new Company__c( Factor_Type__c='Low Bidder', Dodge_Project__c = dodge.id, Dodge_Report_Number__c='13324', Rank__c='2',CKMS__c='CKS00000012');
        insert comp2;
        
        dodge.Sales_Rep__c = null;
        update dodge;
        Company__c comp3 = new Company__c( Factor_Type__c='General Contractor', Dodge_Project__c = dodge.id, Dodge_Report_Number__c='13324');
        insert comp3;
        
        dodge.BM_Approver__c = null;
        update dodge;
        Company__c comp4 = new Company__c( Factor_Type__c='GC', Dodge_Project__c = dodge.id, Dodge_Report_Number__c='13324');
        insert comp4;
        
        Test.stopTest();
       
    }
}