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
private class TESTJobProfileUpdatePostalCode {

    static testMethod void myUnitTest() {


    /*
    
        Test cases for: JobProfileUpdatePostalCode.trigger
    
    */

        test.startTest();
        
        Dodge_Project__c dp = New Dodge_Project__c(Project_Name__c = 'Test Dodge Project122');
        insert dp;
        
        Job_Profile__c jp = New Job_Profile__c(Name = 'TEST Call Center Project', Job_Site_Zip__c = '90210-4444', Job_Site_Country__c = 'USA');
        insert jp;
        
        system.debug('$$$$$ --> New Job Profile: ' + jp);
        
        Job_Profile__c jpAfterInsert = [Select id, Branch_Id__c, Job_Site_Zip__c From Job_Profile__c Where id = :jp.Id];
        
        system.debug('$$$$$ --> New Job Profile (After Insert): ' + jpAfterInsert);
        
        //Branch_Lookup__c bl = [Select Id, Branch_Code__c from Branch_Lookup__c where Zip__c = '90210']; 
        
        system.assertequals(jpAfterInsert.Id, jp.Id);
        //system.assertequals(bl.Branch_Code__c, jpAfterInsert.Branch_Id__c);
        
        test.stopTest();
        
    }
    
    static testMethod void myUnitTest2(){
    
       Dodge_Project__c dodge = TestRemoveDodgeManagementController.createDodgeProject();
       
       User BMuser = [select Id,Branch__c,Email from User where isActive = true and UserRole.Name like 'Branch Manager%' LIMIT 1];
       BMuser.Branch__c = '890';
       update BMuser;
       
       system.runAs(BMuser){
       
       Test.startTest();
       Job_Profile__c jb = new Job_Profile__c(Name = 'TEST APEX Job Profile' ,Job_Site_Zip__c ='9807' ,Job_Site_Country__c ='USA' );  
       insert jb;
       
       jb.Job_Site_Zip__c = '90210'; 
       update jb;
       
       Test.stopTest();
       
       }
   }
}