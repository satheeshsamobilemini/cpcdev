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
private class TestDodgeFeed {

    static testMethod void myUnitTest() {
        // TO DO: implement unit test
        Test.startTest();
        Dodge_Project__c dr = new Dodge_Project__c();
        dr.Dodge_Report_Number__c = '123456';
        dr.Zip__c = '85282';
        dr.Country__c = 'USA';
        dr.Branch_ID__C = '102';
		dr.Action_Stage__c = 'GC Bidding';
		dr.GC_Awarded__c = true;
		dr.Job_Profile_Status__c = 'Created';
		insert dr;
		
		Company__c c = new Company__c();
		c.Country__c = 'USA';
		c.Dodge_Project__c = dr.Id;
		c.Dodge_Report_Number__c = '123456';
		c.Factor_Type__c = 'GC';
		c.Zip__c = '85282';
		c.FactorKey__c = 'Bidder';
		insert c;
		c.FactorKey__c = 'GC';
		update c;
		delete c;
		Test.stopTest();
		
    }
}