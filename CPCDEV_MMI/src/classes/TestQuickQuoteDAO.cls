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
private class TestQuickQuoteDAO {

    static testMethod void myUnitTestQqFromJp() {
       
		User u=MMIFullquoteTestDataProvider.getUser();
		u.Alias = 'TESTUS';
		u.username = 'TEST.USER@TEST.TEST';
		insert u;
		System.runAs(u) {
		    Test.startTest();
		    
		    Account acc = MMIFullquoteTestDataProvider.getBusinessAccount();
            insert acc;
            
            Opportunity opp=MMIFullquoteTestDataProvider.getOpportunity();
            opp.AccountId = acc.id; 
            insert opp;
		    
		    Contact con = new Contact();
		    con.FirstName = 'testfn';
		    con.LastName = 'ln';
		    con.email = 'asdf@sdfds.com';
		    con.Phone = '56545444654';
		    con.AccountId = acc.Id;
		    insert con;
		    
		    Job_Profile__c jp = MMIFullquoteTestDataProvider.getJobProfile();
		    insert jp;
		    
		    Sub_Contractor__c sc = new Sub_Contractor__c();
		    sc.Account__c = acc.Id;
		    sc.Job_Profile__c = jp.Id;
		    sc.Role__c = 'Bidder';
		    insert sc;
		    
		    QuickQuoteMainDAO.getContactRecord(con.Id);
		    QuickQuoteMainDAO.getJobProfRecord(jp.Id);
		    QuickQuoteMainDAO.getSCRecord(sc.Id);
		    QuickQuoteMainDAO.createTaskForQQCreatedFromJP(jp.Id, opp.Id);
		    
	        Test.stopTest();
	      
		}
    }
    
    static testMethod void myUnitTestQqDao() {
       
		User u=MMIFullquoteTestDataProvider.getUser();
		u.Alias = 'TESTUS';
		u.username = 'TEST.USER@TEST.TEST';
		insert u;
		System.runAs(u) {
		    Test.startTest();
		    Lead newLead=MMITestDataProvider.getLead();
	        insert newLead;
	            
		    Account acc = MMIFullquoteTestDataProvider.getBusinessAccount();
            insert acc;
            
            Opportunity opp=MMIFullquoteTestDataProvider.getOpportunity();
            opp.AccountId = acc.id; 
            insert opp;
            
            Opportunity opp1=MMIFullquoteTestDataProvider.getOpportunity();
            opp1.AccountId = acc.id; 
            opp1.Id = opp.Id;
		    
		    Contact con = new Contact();
		    con.FirstName = 'testfn';
		    con.LastName = 'ln';
		    con.email = 'asdf@sdfds.com';
		    con.Phone = '56545444654';
		    con.AccountId = acc.Id;
		    insert con;
		    
		    Job_Profile__c jp = MMIFullquoteTestDataProvider.getJobProfile();
		    insert jp;
		    
		    Sub_Contractor__c sc = new Sub_Contractor__c();
		    sc.Account__c = acc.Id;
		    sc.Job_Profile__c = jp.Id;
		    sc.Role__c = 'Bidder';
		    insert sc;
		    
		    MMI_Quotes__c qqObj = MMIFullquoteTestDataProvider.getQuickQuote();
	        insert qqObj;
	        
	        MMI_Quotes__c qqObj1 = MMIFullquoteTestDataProvider.getQuickQuote();
	        qqObj1.Id = qqObj.Id;
	        
		    QuickQuoteMainDAO.getLeadRecord(newLead.Id);
		    QuickQuoteMainDAO.getOppRecord(opp.Id);
		    QuickQuoteMainDAO.getAccRecord(acc.Id);
		    QuickQuoteMainDAO.insertQuickQuote(qqObj);
		    
		    QuickQuoteMainDAO.getQuickQuoteRecord(qqObj.Id);
		    QuickQuoteMainDAO.updateQuickQuotes(qqObj1);
		    QuickQuoteMainDAO.getOppToUpdate(opp.Id);
		    QuickQuoteMainDAO.updateOppName(opp1);
		    QuickQuoteMainDAO.getAccountList(acc.Id);
		    QuickQuoteMainDAO.insertOpportunity(opp);
		    
		    QuickQuoteWrapper qw1 = new QuickQuoteWrapper();
            qw1.oppContactName = 'erwerw';
            qw1.oppContactPhone = '123423452';
            qw1.oppContactLastName = 'erwerw';
            qw1.ZipCode = '85226';
            qw1.followUpTaskComments = 'sdg  dfgfdhgfd';
		    
		    QuickQuoteMainDAO.createTaskAfterQQCreationForFollowUpCall(opp.Id, 'fq', system.today(), con.Id, qw1);
		    
		    QuickQuoteWrapper qw = new QuickQuoteWrapper();
            qw.oppContactName = 'erwerw';
            qw.oppContactPhone = '123423452';
            qw.oppContactLastName = 'erwerw';
            qw.ZipCode = '85226';
            
            qw.Address = '5858 w Chandler';
            qw.City = 'test';
            qw.State = 'test';
            qw.Country = 'test';
            
            FullQuoteWrapper fqw = new FullQuoteWrapper();
            fqw.AddressInShippingDates = '5858 w Chandler';
            fqw.cityInShippingDates = 'test';
            fqw.stateInShippingDates = 'test';
            fqw.countryInShippingDates = 'test';
            fqw.ZipCodeInShipping = '85226';
            fqw.AccountName = '34534';
            fqw.AccountName = 'test';
            
		    QuickQuoteMainDAO.convertLead(newLead.Id, newLead.OwnerId,qw);
		    
		    HomeBaseBeans.knowZoneRatesEmailParam paramObj = new HomeBaseBeans.knowZoneRatesEmailParam();
		    paramObj.fulfillingBranchId = '102';
		    paramObj.loggedInUserEmail = 'asfas@sdfsd.com';
		    paramObj.sfdcAccOwnerEmail = 'sdgsdfd@sdtsd.com';
		    paramObj.quoteType = 'qq';
		    paramObj.qqWrapper = qw;
		    paramObj.itemCode = '10I';
		    QuickQuoteMainDAO.SendEmailToBranch(paramObj);
		    paramObj.quoteType = 'fq';
		    paramObj.fullQWrapper = fqw;
		    QuickQuoteMainDAO.SendEmailToBranch(paramObj);
		    
	        Test.stopTest();
	      
		}
    }
}