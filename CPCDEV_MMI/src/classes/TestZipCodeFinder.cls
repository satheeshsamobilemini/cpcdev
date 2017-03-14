/**
 * Test Class for ZipCodeFinder
 */
@isTest
private class TestZipCodeFinder {

    static testMethod void testZipCodeFinder() {
      List<Branch_Lookup__c> branches = new List<Branch_Lookup__c>();
      Branch_Lookup__c branch = new Branch_Lookup__c(zip__c ='BL-81',Country__c='USA',Branch_Code__c ='888');
      branches.add(branch);  
    
      Branch_Lookup__c branch1= new Branch_Lookup__c(zip__c ='BL-82',Country__c='USA',Branch_Code__c ='888',US_NSC_Sales_Manager_ID__c = userInfo.getUserId(),Territory__c= '440-01',Branch_Name__c='440-Albuquerque');
       branches.add(branch1);    
      insert branches;
      ZipCodeFinderController zipCodeFinder = new ZipCodeFinderController();
      zipCodeFinder.zipCode = 'BL-828';
      zipCodeFinder.searchZipCode();
      System.assert(zipCodeFinder.branchCodeWrappers.size()==1);
    }
    
    static testMethod void testZipCodeFinderWithBlankNSC() {
      List<Branch_Lookup__c> branches = new List<Branch_Lookup__c>();
      Branch_Lookup__c branch = new Branch_Lookup__c(zip__c ='BL-81',Country__c='USA',Branch_Code__c ='888');
      branches.add(branch);  
    
      Branch_Lookup__c branch1= new Branch_Lookup__c(zip__c ='BL-82',Country__c='USA',Branch_Code__c ='888',Territory__c= '440-01',Branch_Name__c='440-Albuquerque');
       branches.add(branch1);    
      insert branches;
      ZipCodeFinderController zipCodeFinder = new ZipCodeFinderController();
      zipCodeFinder.zipCode = 'BL-82';
      zipCodeFinder.searchZipCode();
      System.assert(zipCodeFinder.branchCodeWrappers.size()==1);
    }
}