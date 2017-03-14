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
private class TestFullQuoteMainService { 
	 
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
            MMI_Full_Quotes__c mmifullQuote = MMIFullquoteTestDataProvider.getnewteMMIFullQuote();
            insert mmifullQuote;
            
            list<Modification_Option_Transactional__c> ModificationOptionTransactionalList = MMIFullquoteTestDataProvider.getModificationOptionTransactionalList();
            insert ModificationOptionTransactionalList;
            List<Modification_Approver_List__c> ModificationApproverList = MMIFullquoteTestDataProvider.getModificationApproverList();
            insert ModificationApproverList;
            
            List<Standard_Modification__c> StandardModificationList = MMIFullquoteTestDataProvider.getStandardModificationList();
            insert StandardModificationList;
            
            List<HB_Sales_Inventory__c>  HBSalesInventoryList =  MMIFullquoteTestDataProvider.getHBSalesInventoryList();
            insert HBSalesInventoryList;
            
            List<accessories__c> accessoryList = MMIFullquoteTestDataProvider.getaccessory();
            insert accessoryList;
            
			FullQuoteMainService fullQuotmainSer = new FullQuoteMainService();
			
			
			fullQuotmainSer.getOppStageUpdate(opp.id);
			fullQuotmainSer.getFullQuote('21');
			fullQuotmainSer.getApproverList('branch');
			fullQuotmainSer.getStandardModificationList();
			fullQuotmainSer.getSalesInventories('102');	
			fullQuotmainSer.getSalesInventoriesSearch('102','mobo');
			fullQuotmainSer.getSpecificSalesInventories('10i','102');
			fullQuotmainSer.searchAccessories('test');
					
            /*fullQuotmainSer.getConvertLeadResult(newLead.id, u.id);
            fullQuotmainSer.getConvertLeadResultWithResultId(newLead.id, u.id, '50737', acc.id);*/
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
            
            List<HomeBaseBeans.AnalysisSetHeaders> AdditionalAnalysisSetList  =  new  List<HomeBaseBeans.AnalysisSetHeaders>();
            AdditionalAnalysisSetList = MMIFullquoteTestDataProvider.getanalysisSetHeader();
            //insert AdditionalAnalysisSetList ;
            
            Rate__c rateList = MMIFullquoteTestDataProvider.getRate();
            insert rateList;
            
            list<Modification_Option_Transactional__c> ModificationOptionTransactionalList = MMIFullquoteTestDataProvider.getModificationOptionTransactionalList();
            ModificationOptionTransactionalList[0].Full_Quote_Transactional__c = FullQuoteTransactional.id;
            insert ModificationOptionTransactionalList;
            
            FullQuoteWrapper fullQWrapper= MMIFullquoteTestDataProvider.getFullWrapper();
            system.debug('-------fullQWrapper-----------'+fullQWrapper);
            FullQuoteWrapper.DescarteInnerClass fullQuteDescard = new FullQuoteWrapper.DescarteInnerClass();
        	fullQuteDescard = MMIFullquoteTestDataProvider.getFullQuoteWrpDescarte();
        	
        	List<HomeBaseBeans.AnalysisSetHeaders> analysisSetHeaderResponseList = new List<HomeBaseBeans.AnalysisSetHeaders>(); 
        	analysisSetHeaderResponseList = MMIFullquoteTestDataProvider.getanalysisSetHeader();
        	
        	List<HomeBaseBeans.extras> ProductExtrasList = new List<HomeBaseBeans.extras>();
        	ProductExtrasList = MMIFullquoteTestDataProvider.getProductExtrasList();
        	
        	
        	List<HomeBaseBeans.rates> newHomeBaseBeansrates = new List<HomeBaseBeans.rates>();
            newHomeBaseBeansrates  = MMIFullquoteTestDataProvider.getHomeBaseBeansrates();
            
            List<HomeBaseBeans.quoteLine> quoteLineData = new List<HomeBaseBeans.quoteLine>();
        	quoteLineData = MMIFullquoteTestDataProvider.getQuoteLine();
        
        	List<FullQuoteWrapper.stdModification> fullQutestadearlist = new List<FullQuoteWrapper.stdModification>();
        	fullQutestadearlist = MMIFullquoteTestDataProvider.getFullQuoteWrpstdModificationList();
        
            String startDate = '2013-2-12';
	        string plannedCollectionDate = 'test';
	        String expDate= '2013-2-12';
	        String POExpires = '2013-2-12';
	        String scheduledDelivery = '2013-2-12';
	        String SelectedShipingTaxId = '421525';
            String loadedMoveIn = '2013-2-12';
            
	        String SelectedRentalLength = '2';
	        string docId = '1';
	        Integer summaryLineCount = 1;
        
            FullQuoteMainService fullQuotmainSer = new FullQuoteMainService();
            FullQuoteMainService fullQuotmainSer1 = new FullQuoteMainService();
            FullQuoteMainService fullQuotmainSer2 = new FullQuoteMainService();
            fullQuotmainSer.getuserBranchInfo();
            fullQuotmainSer.getuserSalesRepId(); 
            fullQuotmainSer.getAccessoryInfo('test');
            fullQuotmainSer.insertAnalysisSet(analysisSetHeaderResponseList,FullQuoteTransactional.id);
            fullQuotmainSer.insertAdditionalAnalysisSet(AdditionalAnalysisSetList,FullQuoteTransactional.id);
            fullQuotmainSer.insertProductExtras(ProductExtrasList,FullQuoteTransactional.id);
            fullQuotmainSer.insertSummuryLIne(quoteLineData,FullQuoteTransactional.id);
            fullQuotmainSer.updateModificationOption(fullQutestadearlist,FullQuoteTransactional.id,'Approved');
            fullQuotmainSer2.updateModificationOption(fullQutestadearlist,FullQuoteTransactional.id,'Rejected');
            
	        Test.stopTest();
		}
    }
   /*static testMethod void myUnitTest2() {
       
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
            
            
            List<Rate__c> rateList = MMIFullquoteTestDataProvider.getRateList();
            insert rateList;
            
            List<Summary_Line__c> summaryLineList = MMIFullquoteTestDataProvider.getnewSummaryLineList();
            insert summaryLineList;
            
            List<AnalysisSet__c> AnalysisSetList = MMIFullquoteTestDataProvider.getAnalysisSetList();
            insert AnalysisSetList;
            
            List<AdditionalAnalysisSet__c> AdditionalAnalysisSetList = MMIFullquoteTestDataProvider.getAdditionalAnalysisSetList();
            insert AdditionalAnalysisSetList ;
            
            
            HB_Sales_Inventory__c  HBSalesInventory =  MMIFullquoteTestDataProvider.getHBSalesInventory();
            insert HBSalesInventory;
            
            MMI_Quotes__c quickQuoteid = MMIFullquoteTestDataProvider.getQuickQuote();
            insert quickQuoteid;
            
            FullQuoteMainService fullQuotmainSer = new FullQuoteMainService();
            fullQuotmainSer.getLeadinfo(newLead.id);
            fullQuotmainSer.getLeadIndustry(newLead.id);
            fullQuotmainSer.getAccountEmailList(acc.id);
            fullQuotmainSer.getOppInfo(opp.id);
            fullQuotmainSer.getAccounListInfo(acc.id);
            fullQuotmainSer.getQqInfo(quickQuoteid.id);
            fullQuotmainSer.getModificationOption(FullQuoteTransactional.id);
            fullQuotmainSer.getAccInfo(acc.id);
            
            
	        Test.stopTest();
		}
    }*/
    
     
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
            MMI_Full_Quotes__c mmifullQuote = MMIFullquoteTestDataProvider.getnewteMMIFullQuote();
            insert mmifullQuote;
            
            list<Modification_Option_Transactional__c> ModificationOptionTransactionalList = MMIFullquoteTestDataProvider.getModificationOptionTransactionalList();
            insert ModificationOptionTransactionalList;
            List<Modification_Approver_List__c> ModificationApproverList = MMIFullquoteTestDataProvider.getModificationApproverList();
            insert ModificationApproverList;
            
            List<Standard_Modification__c> StandardModificationList = MMIFullquoteTestDataProvider.getStandardModificationList();
            insert StandardModificationList;
            
            List<HB_Sales_Inventory__c>  HBSalesInventoryList =  MMIFullquoteTestDataProvider.getHBSalesInventoryList();
            insert HBSalesInventoryList;
            
            List<accessories__c> accessoryList = MMIFullquoteTestDataProvider.getaccessory();
            insert accessoryList;
            
			FullQuoteMainService fullQuotmainSer = new FullQuoteMainService();
			
			
			fullQuotmainSer.getOppStageUpdate(opp.id);
			fullQuotmainSer.getFullQuote('21');
			fullQuotmainSer.getApproverList('branch');
			fullQuotmainSer.getStandardModificationList();
			fullQuotmainSer.getSalesInventories('102');	
			fullQuotmainSer.getSalesInventoriesSearch('102','mobo');
			fullQuotmainSer.getSpecificSalesInventories('10i','102');
			fullQuotmainSer.searchAccessories('test');
					
            fullQuotmainSer.getConvertLeadResult(newLead.id, u.id);
            FullQuoteWrapper fqWrap = new FullQuoteWrapper();
            fqWrap.Name = 'test fn';
            fqWrap.telePhone = '21233334545';
            fullQuotmainSer.getConvertLeadResultWithResultId(newLead.id, u.id, '50737', acc.id,fqWrap);
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
            	
	             FullQuoteMainService fullQuotmainSer1 = new FullQuoteMainService();
            
	            Lead newLead2=MMIFullquoteTestDataProvider.getLeadWithDeliveryAdd();
	            newLead2.Country = 'USA';
	            newLead2.Company = 'tek';
	            newLead2.Delivery_Country__c = '';
	            insert newLead2;
	            
	            Product_Extras__c newProductExtras = MMIFullquoteTestDataProvider.getnewProductExtras();
			    insert newProductExtras;
			    
			    List<Rate__c> RateList = MMIFullquoteTestDataProvider.getRateList();
			    RateList[0].Product_Extras__c = newProductExtras.id;
			    insert RateList;

			    Set<id> prodId = new set<id>();
            	prodId.add(newProductExtras.id);
            	FullQuoteWrapper fqWrap = new FullQuoteWrapper();
	            fqWrap.Name = 'test fn';
	            fqWrap.telePhone = '21233334545';
			    fullQuotmainSer1.getFullQuoteTransactional('test');
			    fullQuotmainSer1.getConvertLeadResult(newLead2.id, u.id);
	            fullQuotmainSer1.getConvertLeadResultWithResultId(newLead2.id, u.id, '', acc.id,fqWrap);
	            fullQuotmainSer1.getRateListInfo(prodId);
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
			    
			    Account acc=MMIFullquoteTestDataProvider.getAccount();
            	insert acc;
	            FullQuoteMainService fullQuotmainSer2 = new FullQuoteMainService();
            
	            Lead newLead3=MMIFullquoteTestDataProvider.getLeadWithDeliveryAdd();
	            newLead3.Country = '';
	            newLead3.Company = 'tek';
	            newLead3.Delivery_Country__c = 'USA';
			    insert newLead3;
	            FullQuoteWrapper fqWrap = new FullQuoteWrapper();
	            fqWrap.Name = 'test fn';
	            fqWrap.telePhone = '21233334545';
	            fullQuotmainSer2.getConvertLeadResult(newLead3.id, u.id);
	            fullQuotmainSer2.getConvertLeadResultWithResultId(newLead3.id, u.id, '50737', '',fqWrap);
				Test.stopTest();
			}
		 }
            
     static testMethod void myUnitTest6() {
       
		User u=MMIFullquoteTestDataProvider.getUser();
		u.Alias = 'TESTUS';
		u.username = 'TEST.USER@TEST.TEST';
		insert u;
		System.runAs(u) {
		    Test.startTest();
            Account acc=MMIFullquoteTestDataProvider.getAccount();
            insert acc;
            Opportunity opp=MMIFullquoteTestDataProvider.getOpportunity();
            insert opp;
            Lead newLead3=MMIFullquoteTestDataProvider.getLeadWithDeliveryAdd();
		    insert newLead3;
		    
		    MMI_Full_Quotes__c mmifullQuote = MMIFullquoteTestDataProvider.getnewteMMIFullQuote();
		    mmifullQuote.Account__c = acc.id;
		    mmifullQuote.Opportunity__c = opp.id;
            insert mmifullQuote;
			
			MMI_Full_Quotes__c mmifullQuote1 = new MMI_Full_Quotes__c();
			HomeBaseBeans.CreateFullQuoteResponse newCreateFullQuoteResponse =MMIFullquoteTestDataProvider.getHomeBaseBeansCreateFullQuoteResponse();
            //insert newCreateFullQuoteResponse;
            
            FullQuoteWrapper fullQWrapper= MMIFullquoteTestDataProvider.getFullWrapper();
            
            FullQuoteWrapper.DescarteInnerClass  newDescarteInnerClass  = MMIFullquoteTestDataProvider.getFullQuoteWrpDescarte();
            //insert newDescarteInnerClass;
            
        	FullQuoteMainService fullQuotmainSerCre = new FullQuoteMainService();
        	
        	
			fullQuotmainSerCre.insertFullQuoteRecord(mmifullQuote1, system.today(), system.today(), system.today(), system.today(), system.today(), opp.id, '', newCreateFullQuoteResponse, fullQWrapper, '123455', '45675', newDescarteInnerClass, '10i','true');
			fullQuotmainSerCre.updateFullQuoteRecord(mmifullQuote1,'test' ,'102',system.today(),system.today(),system.today() ,system.today(),system.today(),opp.id, fullQWrapper,'123533','test',newDescarteInnerClass ,'10i');
				
			}		  
	        Test.stopTest();
	      
		}
		static testMethod void myUnitTest7() {
       
		User u=MMIFullquoteTestDataProvider.getUser();
		u.Alias = 'TESTUS';
		u.username = 'TEST.USER@TEST.TEST';
		insert u;
		System.runAs(u) {
		    Test.startTest();
		    Full_Quote_Transactional__c FullQuoteTransactional=MMIFullquoteTestDataProvider.getnewFullQuoteTransaction();
            insert FullQuoteTransactional;
            
			Full_Quote_Transactional__c mmifullQuotetra1 = new Full_Quote_Transactional__c();
			MMI_Full_Quotes__c mmifullQuote1 = new MMI_Full_Quotes__c();
			Account acc=MMIFullquoteTestDataProvider.getAccount();
            insert acc;
            Opportunity opp=MMIFullquoteTestDataProvider.getOpportunity();
            insert opp;
			HomeBaseBeans.CreateFullQuoteResponse newCreateFullQuoteResponse =MMIFullquoteTestDataProvider.getHomeBaseBeansCreateFullQuoteResponse();
            //insert newCreateFullQuoteResponse;
            
            List<HomeBaseBeans.quoteLine> summaryLineList = new List<HomeBaseBeans.quoteLine>();
        	summaryLineList = MMIFullquoteTestDataProvider.getQuoteLine();
 			
 			List<HomeBaseBeans.AnalysisSetHeaders> analysisSetHeaderResponseList = new List<HomeBaseBeans.AnalysisSetHeaders>(); 
        	analysisSetHeaderResponseList = MMIFullquoteTestDataProvider.getanalysisSetHeader();
        	       	
 			List<HomeBaseBeans.extras> ProductExtrasList = new List<HomeBaseBeans.extras>();
        	ProductExtrasList = MMIFullquoteTestDataProvider.getProductExtrasList();
        	
        	FullQuoteWrapper.DescarteInnerClass fullQuteDescard = new FullQuoteWrapper.DescarteInnerClass();
        	fullQuteDescard = MMIFullquoteTestDataProvider.getFullQuoteWrpDescarte();
        	           
            FullQuoteWrapper fullQWrapper= MMIFullquoteTestDataProvider.getFullWrapper();
            
            FullQuoteWrapper.DescarteInnerClass  newDescarteInnerClass  = MMIFullquoteTestDataProvider.getFullQuoteWrpDescarte();
            //insert newDescarteInnerClass;
            Standard_Modification__c stdmodification = MMIFullquoteTestDataProvider.getStandardModification();
            insert stdmodification;
            
            List<FullQuoteWrapper.stdModification>  stdmodiflist = MMIFullquoteTestDataProvider.getFullQuoteWrpstdModificationList();
            
            	
        	FullQuoteMainService fullQuotmainSerCre = new FullQuoteMainService();
        	fullQuotmainSerCre.insertFullQuoteRecord(mmifullQuote1, system.today(), system.today(), system.today(), system.today(), system.today(), opp.id, acc.id, newCreateFullQuoteResponse, fullQWrapper, '123455', '45675', newDescarteInnerClass, '10i','false');
			fullQuotmainSerCre.insertFullQuoteApprovalProcess(mmifullQuotetra1 ,summaryLineList,analysisSetHeaderResponseList,analysisSetHeaderResponseList, ProductExtrasList, fullQuteDescard, fullQuteDescard,  system.today(),  system.today(),  system.today(),  system.today(),  system.today(), fullQWrapper, '123242', '5456352', true, true, '102', '1', '32423433');
			fullQuotmainSerCre.insertModificationOption(stdmodiflist,FullQuoteTransactional.id,'teksystem@tek.com');
				
			}		  
	        Test.stopTest();
	      
		}
	
 
}