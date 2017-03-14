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
private class TESTSubContractorManageOpportunity {

    static testMethod void myUnitTest() {
        
        Account acct = New Account(Name = 'TEST APEX Contruction');
        insert acct;

        Dodge_Project__c dp = New Dodge_Project__c(Project_Name__c = 'Test Dodge Project');
        insert dp;
        
        Job_Profile__c jp = New Job_Profile__c(Name = 'TEST APEX Job Profile', Job_Site_Zip__c = '90210', Job_Site_Country__c = 'USA');
        insert jp;
        
        Sub_Contractor__c subc = New Sub_Contractor__c (Job_Profile__c = jp.Id, Role__c = 'General Contractor', Account__c = acct.Id); 
        insert subc;
        
        /*
        
        Job_Profile__c jp1 = [Select Id, General_Contractors__c  FROM Job_Profile__c where Id = :jp.Id];
        system.assertequals(1, jp1.General_Contractors__c);
        
        Opportunity oppty = [Select Id from Opportunity where Job_Profile__c = :jp.Id LIMIT 1];
        system.assert(oppty.Id != NULL);
        
        */
        
        delete subc;
        
        Job_Profile__c jp1 = [Select Id, General_Contractors__c  FROM Job_Profile__c where Id = :jp.Id];
        system.assertequals(0, jp1.General_Contractors__c);
        
        
    }
}