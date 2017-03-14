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
private class TESTAccountCopyDescSpecInstructions {

    static testMethod void myUnitTest() {
        
        test.startTest();
		//4.5.2013-Case40559-LSLEVIN Industry added to creation of lead below-START
		Lead myLead = new Lead(lastname = 'Fry', company='Fry And Sons', Description = 'Here are my Special instructions', Industry = '2-Retail Trade/Services');
		//END
		insert myLead;
		Database.LeadConvert lc = new database.LeadConvert();
		lc.setLeadId(myLead.id);
		LeadStatus convertStatus = [Select Id, MasterLabel from LeadStatus where IsConverted=true
		limit 1];
		lc.setConvertedStatus(convertStatus.MasterLabel);
		Database.LeadConvertResult lcr = Database.convertLead(lc);
		System.assert(lcr.isSuccess());
		
		Lead convertedLead = [Select Id, ConvertedAccountId  FROM Lead where Id = :myLead.Id];
		
		Account acct = [Select Id, Description, Special_Instructions__c  FROM Account where Id = :convertedLead.ConvertedAccountId]; 
        
        System.Debug('$$$$$$ --> Special Instructions = ' + acct.Special_Instructions__c);
        
        System.AssertEquals(acct.Description, acct.Special_Instructions__c);
        
        test.stopTest();
        
    }
}