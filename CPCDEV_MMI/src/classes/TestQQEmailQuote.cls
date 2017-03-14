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
private class TestQQEmailQuote {

    static testMethod void myUnitTest1() {
        // TO DO: implement unit test
        User userObj = MMIFullquoteTestDataProvider.getUser();
        System.runAs(userObj){
	        test.startTest();
	        Account acc=MMITestDataProvider.getAccount();
            insert acc;
		    Lead newLead=MMITestDataProvider.getLead();
		    insert newLead;
            Opportunity opp=MMITestDataProvider.getOpportunity();
            insert opp;
            MMI_Quotes__c mmiQQ=MMITestDataProvider.getQuickQuote();
            insert mmiQQ;
            System.currentPageReference().getParameters().put('recId',mmiQQ.Id);
            QuickQuoteEmailQuote qqEmailQuote = new QuickQuoteEmailQuote();
	        test.stopTest();
		}
    }
    static testMethod void myUnitTest2() {
        // TO DO: implement unit test
        User userObj = MMIFullquoteTestDataProvider.getUser();
        System.runAs(userObj){
	        test.startTest();
	        Account acc=MMITestDataProvider.getAccount();
            insert acc;
		    Lead newLead=MMITestDataProvider.getLead();
		    insert newLead;
            Opportunity opp=MMITestDataProvider.getOpportunity();
            insert opp;
            MMI_Quotes__c mmiQQ=MMITestDataProvider.getQuickQuote();
            insert mmiQQ;
            System.currentPageReference().getParameters().put('recId',mmiQQ.Id);
            QuickQuoteSendEmailQuote qqSendEmailQuote = new QuickQuoteSendEmailQuote();
            qqSendEmailQuote.toAddress = 'test@test.com';
            qqSendEmailQuote.ccAddress = 'test1@test.com';
            qqSendEmailQuote.bccAddress = 'test2@test.com';
            
            qqSendEmailQuote.fillTo();
            qqSendEmailQuote.fillCC();
            qqSendEmailQuote.fillBCC();
            qqSendEmailQuote.sendMail();
            qqSendEmailQuote.cancelMail();
            qqSendEmailQuote.checkEmailAddress('abcd@abcd.com');
            qqSendEmailQuote.checkEmailAddress('abcd@abcd');
            
	        test.stopTest();
		}
    }
}