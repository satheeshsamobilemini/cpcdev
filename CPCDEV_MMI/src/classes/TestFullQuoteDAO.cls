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
private class TestFullQuoteDAO {
	
	static testMethod void myUnitTest3() {
       
		User u=MMIFullquoteTestDataProvider.getUser();
		u.Alias = 'TESTUS';
		u.username = 'TEST.USER@TEST.TEST';
		insert u;
		System.runAs(u) {
		    Test.startTest();
            Account acc=MMIFullquoteTestDataProvider.getAccount();
            insert acc;
		    Lead newLead=MMIFullquoteTestDataProvider.getLeadWithDeliveryAdd();
		    insert newLead;
            Opportunity opp=MMIFullquoteTestDataProvider.getOpportunity();
            insert opp;

            FullQuoteDAO fullQutDAO = new FullQuoteDAO();
            
            FullQuoteDAO.getBranchId('', acc.id);
            FullQuoteWrapper fqWrap = new FullQuoteWrapper();
            fqWrap.Name = 'test fn';
            fqWrap.telePhone = '21233334545';
            FullQuoteDAO.convertLead(newLead.id, u.id);
            FullQuoteDAO.convertLeadWithResultId(newLead.id, u.id, '50737', acc.id,fqWrap);
            /*Lead newLead2=MMIFullquoteTestDataProvider.getLeadWithDeliveryAdd();
            newLead2.Country = 'USA';
            newLead2.Company = 'tek';
            newLead2.Delivery_Country__c = '';
            
		    insert newLead2;
		    FullQuoteDAO.convertLead(newLead2.id, u.id);
            FullQuoteDAO.convertLeadWithResultId(newLead2.id, u.id, '', acc.id);*/
            
	        Test.stopTest();
	      
		}
	
    }

    static testMethod void myUnitTest() {
       
		User u=MMIFullquoteTestDataProvider.getUser();
		u.Alias = 'TESTUS2';
		u.username = 'TEST.USER2@TEST.TEST';
		insert u;
		System.runAs(u) {
		    Test.startTest();
            Account acc=MMIFullquoteTestDataProvider.getAccount();
            insert acc;
		    Lead newLead=MMIFullquoteTestDataProvider.getLeadWithDeliveryAdd();
		    insert newLead;
            Opportunity opp=MMIFullquoteTestDataProvider.getOpportunity();
            insert opp;

            MMI_Full_Quotes__c mmifullQuote = MMIFullquoteTestDataProvider.getnewteMMIFullQuote();
            insert mmifullQuote;
            
            Full_Quote_Transactional__c FullQuoteTransactional=MMIFullquoteTestDataProvider.getnewFullQuoteTransaction();
            insert FullQuoteTransactional;
            
            Weekly_Snapshot_Branch_Report__c weeklySnapshortBr = MMIFullquoteTestDataProvider.getWeeklySnapshotBranchReport();
            insert weeklySnapshortBr;
            Product_Extras__c productList = MMIFullquoteTestDataProvider.getnewProductExtras();
            insert productList;
            
            Rate__c rateList = MMIFullquoteTestDataProvider.getRate();
            insert rateList;
            
            FullQuoteDAO fullQutDAO = new FullQuoteDAO();
            FullQuoteDAO.getFullQuoteTransactional(FullQuoteTransactional.id);
            FullQuoteDAO.insertFullQuote(mmifullQuote );
            FullQuoteDAO.updateFullQuote(mmifullQuote );
            FullQuoteDAO.getLeadRecord(newLead.id);
            FullQuoteDAO.getAccountRecord(acc.id);
            FullQuoteDAO.getBranchId('', newLead.id);
            FullQuoteDAO.getWeeklySnapShortBranchReport(weeklySnapshortBr.id);
            FullQuoteDAO.getLeadIndustry(opp.id);
            FullQuoteDAO.getUserBranchDetails();
            FullQuoteDAO.getUserDetails(u.id);
            FullQuoteDAO.getOppRecord(opp.id);
            FullQuoteDAO.getAccountList(acc.id);
            FullQuoteDAO.getLeadStatus();
            FullQuoteDAO.getOppStageUpdate(opp.id);
            FullQuoteDAO.getFullQuoteRecord('106043383');
            FullQuoteDAO.insertProductExtra(productList);
            
	        Test.stopTest();
		}
    }
    static testMethod void myUnitTest2() {
       
		User u=MMIFullquoteTestDataProvider.getUser();
		insert u;
		System.runAs(u) {
		    Test.startTest();
            Account acc=MMIFullquoteTestDataProvider.getAccount();
            insert acc;
		    Lead newLead=MMIFullquoteTestDataProvider.getLeadWithDeliveryAdd();
		    insert newLead;
            Opportunity opp=MMIFullquoteTestDataProvider.getOpportunity();
            insert opp;

            MMI_Full_Quotes__c mmifullQuote = MMIFullquoteTestDataProvider.getnewteMMIFullQuote();
            insert mmifullQuote;
            
            Full_Quote_Transactional__c FullQuoteTransactional=MMIFullquoteTestDataProvider.getnewFullQuoteTransaction();
            insert FullQuoteTransactional;
            
            Weekly_Snapshot_Branch_Report__c weeklySnapshortBr = MMIFullquoteTestDataProvider.getWeeklySnapshotBranchReport();
            insert weeklySnapshortBr;
            Product_Extras__c productList = MMIFullquoteTestDataProvider.getnewProductExtras();
            insert productList;
            
            List<accessories__c> accessoryList = MMIFullquoteTestDataProvider.getaccessory();
            insert accessoryList;
            
            list<Modification_Option_Transactional__c> ModificationOptionTransactionalList = MMIFullquoteTestDataProvider.getModificationOptionTransactionalList();
            insert ModificationOptionTransactionalList;
            
            List<Rate__c> rateList = MMIFullquoteTestDataProvider.getRateList();
            insert rateList;
            
            List<Summary_Line__c> summaryLineList = MMIFullquoteTestDataProvider.getnewSummaryLineList();
            insert summaryLineList;
            
            List<Standard_Modification__c> StandardModificationList = MMIFullquoteTestDataProvider.getStandardModificationList();
            insert StandardModificationList;
             
            List<AnalysisSet__c> AnalysisSetList = MMIFullquoteTestDataProvider.getAnalysisSetList();
            insert AnalysisSetList;
            
            List<AdditionalAnalysisSet__c> AdditionalAnalysisSetList = MMIFullquoteTestDataProvider.getAdditionalAnalysisSetList();
            insert AdditionalAnalysisSetList ;
            
            List<Modification_Approver_List__c> ModificationApproverList = MMIFullquoteTestDataProvider.getModificationApproverList();
            insert ModificationApproverList;
            
            List<HB_Sales_Inventory__c>  HBSalesInventoryList =  MMIFullquoteTestDataProvider.getHBSalesInventoryList();
            insert HBSalesInventoryList;
            
            HB_Sales_Inventory__c  HBSalesInventory =  MMIFullquoteTestDataProvider.getHBSalesInventory();
            insert HBSalesInventory;
            
            
            FullQuoteDAO fullQutDAO = new FullQuoteDAO();
            FullQuoteDAO.getBranchId('', opp.id);
            FullQuoteDAO.getAccessory(accessoryList[0].Name);
            FullQuoteDAO.getModificationOption(FullQuoteTransactional.id);
            FullQuoteDAO.getStamdardModification('test');
            FullQuoteDAO.insertFullQuoteApprovalProcess(FullQuoteTransactional);
            FullQuoteDAO.insertModificationOption(ModificationOptionTransactionalList);
            FullQuoteDAO.updateModificationOption(ModificationOptionTransactionalList);
            FullQuoteDAO.insertSummuryLine(summaryLineList);
            FullQuoteDAO.insertAnalysisSet(AnalysisSetList);
            FullQuoteDAO.insertAdditionalAnalysisSet(AdditionalAnalysisSetList);
            FullQuoteDAO.insertRates(rateList);
            FullQuoteDAO.getApproverList('106');
            FullQuoteDAO.getStandardModificationList();
            FullQuoteDAO.getSalesInventoryList('106');
            FullQuoteDAO.getSpecificSalesInventoryList('23', '542512');
            FullQuoteDAO.getSpecificSalesInventoryList2('23', '542512');
            FullQuoteDAO.searcSalesInventoryList('106', '542512');
            FullQuoteDAO.searchAccessories('access');

	        Test.stopTest();
		}
    }
   /* static testMethod void myUnitTest3() {
       
		User u=MMIFullquoteTestDataProvider.getUser();
		u.Alias = 'TESTUS';
		u.username = 'TEST.USER@TEST.TEST';
		insert u;
		System.runAs(u) {
		    Test.startTest();
            Account acc=MMIFullquoteTestDataProvider.getAccount();
            insert acc;
		    Lead newLead=MMIFullquoteTestDataProvider.getLeadWithDeliveryAdd();
		    insert newLead;
            Opportunity opp=MMIFullquoteTestDataProvider.getOpportunity();
            insert opp;

            FullQuoteDAO fullQutDAO = new FullQuoteDAO();
            
            FullQuoteDAO.getBranchId('', acc.id);
            FullQuoteWrapper fqWrap = new FullQuoteWrapper();
            fqWrap.Name = 'test fn';
            fqWrap.telePhone = '21233334545';
            FullQuoteDAO.convertLead(newLead.id, u.id);
            FullQuoteDAO.convertLeadWithResultId(newLead.id, u.id, '50737', acc.id,fqWrap);
            Lead newLead2=MMIFullquoteTestDataProvider.getLeadWithDeliveryAdd();
            newLead2.Country = 'USA';
            newLead2.Company = 'tek';
            newLead2.Delivery_Country__c = '';
            
		    insert newLead2;
		    FullQuoteDAO.convertLead(newLead2.id, u.id);
            FullQuoteDAO.convertLeadWithResultId(newLead2.id, u.id, '', acc.id,fqWrap);
            
	        Test.stopTest();
	      
		}
	
    }*/
     static testMethod void myUnitTest4() {
       
		User u=MMIFullquoteTestDataProvider.getUser();
		u.Alias = 'TESTUS';
		u.username = 'TEST.USER@TEST.TEST';
		insert u;
		System.runAs(u) {
		    Test.startTest();
            Account acc=MMIFullquoteTestDataProvider.getAccount();
            insert acc;
            
            Lead newLead3=MMIFullquoteTestDataProvider.getLeadWithDeliveryAdd();
            newLead3.Country = '';
            newLead3.Company = 'tek';
            newLead3.Delivery_Country__c = 'USA';
		    insert newLead3;
		    
		    Product_Extras__c newProductExtras = MMIFullquoteTestDataProvider.getnewProductExtras();
		    insert newProductExtras;
		    
		    List<Rate__c> RateList = MMIFullquoteTestDataProvider.getRateList();
		    RateList[0].Product_Extras__c = newProductExtras.id;
		    insert RateList;
		    FullQuoteWrapper fqWrap = new FullQuoteWrapper();
            fqWrap.Name = 'test fn';
            fqWrap.telePhone = '21233334545';
		    FullQuoteDAO.convertLead(newLead3.id, u.id);
            FullQuoteDAO.convertLeadWithResultId(newLead3.id, u.id, '50737', '',fqWrap);
            FullQuoteDAO.getAccRecord(acc.id);
            Set<id> prodId = new set<id>();
            prodId.add(newProductExtras.id);
            FullQuoteDAO.getRateRecord(prodId);
		  
	        Test.stopTest();
	      
		}
	
	
    }
     static testMethod void myUnitTest5() {
       
		User u=MMIFullquoteTestDataProvider.getUser();
		u.Alias = 'TESTUS';
		u.username = 'TEST.USER@TEST.TEST';
		insert u;
		System.runAs(u) {
		    Test.startTest();
            
            Lead newLead3=MMIFullquoteTestDataProvider.getLeadWithDeliveryAdd();
            newLead3.Country = '';
            newLead3.Company = 'tek';
            newLead3.Delivery_Country__c = 'USA';
		    insert newLead3;
		    
		    Account acc=MMIFullquoteTestDataProvider.getAccount();
		    acc.Result_Id__c = '10492';
            insert acc;
		    
            Opportunity opp=MMIFullquoteTestDataProvider.getOpportunity();
            opp.AccountId = acc.id; 
            insert opp;
            Branch_Lookup__c branch  = MMIFullquoteTestDataProvider.getBranchLookup();
            insert branch;
		    MMI_Full_Quotes__c mmifullQuote = MMIFullquoteTestDataProvider.getnewteMMIFullQuote();
		    mmifullQuote.Opportunity__c =  opp.id;
		    mmifullQuote.Account__c = acc.id;
            insert mmifullQuote;
		    
		    FullQuoteDAO.createTaskBeforeLoad();
		    FullQuoteDAO.CheckMultiplleFqOFSamePgAcc(mmifullQuote.id);
		    FullQuoteDAO.getBranchLookUpRecord(branch.Zip__c);
		    FullQuoteDAO.createTaskBeforeSavingFQ(opp.Id, 'test');
	        Test.stopTest();
	      
		}
		
	
    }
    
}