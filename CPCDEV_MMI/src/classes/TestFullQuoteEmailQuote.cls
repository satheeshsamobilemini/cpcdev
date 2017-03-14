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
private class TestFullQuoteEmailQuote {
	static testMethod void test_FullQuoteEmailQuote(){
			User u=MMIFullquoteTestDataProvider.getUser();
	        System.runAs(u) {
	        Summary_Line__c newSummaryLine = MMIFullquoteTestDataProvider.getnewSummaryLine();
	        insert newSummaryLine;
	        AdditionalAnalysisSet__c NewAdditionalAnalysisSet = MMIFullquoteTestDataProvider.getAdditionalAnalysisSet();
	        insert NewAdditionalAnalysisSet;
	        AnalysisSet__c NewAnalysisSet = MMIFullquoteTestDataProvider.getAnalysisSet();
	        insert NewAnalysisSet;
	        Weekly_Snapshot_Branch_Report__c NewWeeklySnapshotBranchReport = MMIFullquoteTestDataProvider.getWeeklySnapshotBranchReport();
	        insert NewWeeklySnapshotBranchReport;    
	        ApexPages.currentPage().getParameters().put('quoteid',newSummaryLine.Full_Quote_Transactional__c);
	        FullQuoteEmailQuote fQE = new FullQuoteEmailQuote();
	        fQE.GetPDFcontent();
			fQE.deleteQuoutId(newSummaryLine.Full_Quote_Transactional__c);
     		fQE.totalRentalCharat = 2.00;
			fQE.totalOneTimeCharges = 3.00;
			fQE.totalInitialCharges = 5.00;
			fQE.totalSalesCharat = 6.00;
			}
		}
		static testMethod void test_FullQuoteEmailQuote34(){
			User u=MMIFullquoteTestDataProvider.getUser();
	        System.runAs(u) {
	        Summary_Line__c newSummaryLine = MMIFullquoteTestDataProvider.getnewSummaryLine1();
	        insert newSummaryLine;
	        AdditionalAnalysisSet__c NewAdditionalAnalysisSet = MMIFullquoteTestDataProvider.getAdditionalAnalysisSet();
	        insert NewAdditionalAnalysisSet;
	        AnalysisSet__c NewAnalysisSet = MMIFullquoteTestDataProvider.getAnalysisSet();
	        insert NewAnalysisSet;
	        Weekly_Snapshot_Branch_Report__c NewWeeklySnapshotBranchReport = MMIFullquoteTestDataProvider.getWeeklySnapshotBranchReport();
	        insert NewWeeklySnapshotBranchReport;    
	        ApexPages.currentPage().getParameters().put('quoteid',newSummaryLine.Full_Quote_Transactional__c);
	        FullQuoteEmailQuote fQE = new FullQuoteEmailQuote();
	        fQE.GetPDFcontent();
			fQE.deleteQuoutId(newSummaryLine.Full_Quote_Transactional__c);
     		fQE.totalRentalCharat = 2.00;
			fQE.totalOneTimeCharges = 3.00;
			fQE.totalInitialCharges = 5.00;
			fQE.totalSalesCharat = 6.00;
			}
		}
		
		static testMethod void test_FullQuoteEmailQuote1(){
        	User u=MMIFullquoteTestDataProvider.getUser();
	        System.runAs(u) {
	        Product_Extras__c newProductExtras1 = MMIFullquoteTestDataProvider.getnewProductExtras();
	        newProductExtras1.description__c = 'Fuel Surcharge Pick Up';
	        insert newProductExtras1;
	        AdditionalAnalysisSet__c NewAdditionalAnalysisSet = MMIFullquoteTestDataProvider.getAdditionalAnalysisSet();
	        insert NewAdditionalAnalysisSet;
	        AnalysisSet__c NewAnalysisSet = MMIFullquoteTestDataProvider.getAnalysisSet();
	        insert NewAnalysisSet;
	        Weekly_Snapshot_Branch_Report__c NewWeeklySnapshotBranchReport = MMIFullquoteTestDataProvider.getWeeklySnapshotBranchReport();
	        insert NewWeeklySnapshotBranchReport; 
	        ApexPages.currentPage().getParameters().put('quoteid',newProductExtras1.Full_Quote_Transactional__c);
	        FullQuoteEmailQuote fQE7 = new FullQuoteEmailQuote();
	        fQE7.GetPDFcontent();
	        fQE7.deleteQuoutId(newProductExtras1.Full_Quote_Transactional__c);
	        }
		}
		static testMethod void test_FullQuoteEmailQuote2(){
        	User u=MMIFullquoteTestDataProvider.getUser();
	        System.runAs(u) {
	        Product_Extras__c newProductExtras1 = MMIFullquoteTestDataProvider.getnewProductExtras();
	        newProductExtras1.description__c = 'Fuel Surcharge Delivery Mobile Office';
	        insert newProductExtras1;
	        AdditionalAnalysisSet__c NewAdditionalAnalysisSet = MMIFullquoteTestDataProvider.getAdditionalAnalysisSet();
	        insert NewAdditionalAnalysisSet;
	        AnalysisSet__c NewAnalysisSet = MMIFullquoteTestDataProvider.getAnalysisSet();
	        insert NewAnalysisSet;
	        Weekly_Snapshot_Branch_Report__c NewWeeklySnapshotBranchReport = MMIFullquoteTestDataProvider.getWeeklySnapshotBranchReport();
	        insert NewWeeklySnapshotBranchReport; 
	        ApexPages.currentPage().getParameters().put('quoteid',newProductExtras1.Full_Quote_Transactional__c);
	        FullQuoteEmailQuote fQE7 = new FullQuoteEmailQuote();
	        fQE7.GetPDFcontent();
	        fQE7.deleteQuoutId(newProductExtras1.Full_Quote_Transactional__c);
	        }
		}
		static testMethod void test_FullQuoteEmailQuote3(){
        	User u=MMIFullquoteTestDataProvider.getUser();
	        System.runAs(u) {
	        Product_Extras__c newProductExtras1 = MMIFullquoteTestDataProvider.getnewProductExtras();
	        newProductExtras1.description__c = 'Security Deposit';
	        insert newProductExtras1;
	        AdditionalAnalysisSet__c NewAdditionalAnalysisSet = MMIFullquoteTestDataProvider.getAdditionalAnalysisSet();
	        insert NewAdditionalAnalysisSet;
	        AnalysisSet__c NewAnalysisSet = MMIFullquoteTestDataProvider.getAnalysisSet();
	        insert NewAnalysisSet;
	        Weekly_Snapshot_Branch_Report__c NewWeeklySnapshotBranchReport = MMIFullquoteTestDataProvider.getWeeklySnapshotBranchReport();
	        insert NewWeeklySnapshotBranchReport; 
	        ApexPages.currentPage().getParameters().put('quoteid',newProductExtras1.Full_Quote_Transactional__c);
	        FullQuoteEmailQuote fQE7 = new FullQuoteEmailQuote();
	        fQE7.GetPDFcontent();
	        fQE7.deleteQuoutId(newProductExtras1.Full_Quote_Transactional__c);
	        }
		}
		static testMethod void test_FullQuoteEmailQuote4(){
        	User u=MMIFullquoteTestDataProvider.getUser();
	        System.runAs(u) {
	        Product_Extras__c newProductExtras1 = MMIFullquoteTestDataProvider.getnewProductExtras();
	        newProductExtras1.description__c = 'Fuel Surcharge Pick Up Mobile Offc';
	        insert newProductExtras1;
	        AdditionalAnalysisSet__c NewAdditionalAnalysisSet = MMIFullquoteTestDataProvider.getAdditionalAnalysisSet();
	        insert NewAdditionalAnalysisSet;
	        AnalysisSet__c NewAnalysisSet = MMIFullquoteTestDataProvider.getAnalysisSet();
	        insert NewAnalysisSet;
	        Weekly_Snapshot_Branch_Report__c NewWeeklySnapshotBranchReport = MMIFullquoteTestDataProvider.getWeeklySnapshotBranchReport();
	        insert NewWeeklySnapshotBranchReport; 
	        ApexPages.currentPage().getParameters().put('quoteid',newProductExtras1.Full_Quote_Transactional__c);
	        FullQuoteEmailQuote fQE7 = new FullQuoteEmailQuote();
	        fQE7.GetPDFcontent();
	        fQE7.deleteQuoutId(newProductExtras1.Full_Quote_Transactional__c);
	        }
		}
		static testMethod void test_FullQuoteEmailQuote5(){
        	User u=MMIFullquoteTestDataProvider.getUser();
	        System.runAs(u) {
	        Product_Extras__c newProductExtras1 = MMIFullquoteTestDataProvider.getnewProductExtras();
	        newProductExtras1.description__c = 'Loss Limitation Waiver';
	        insert newProductExtras1;
	        AdditionalAnalysisSet__c NewAdditionalAnalysisSet = MMIFullquoteTestDataProvider.getAdditionalAnalysisSet();
	        insert NewAdditionalAnalysisSet;
	        AnalysisSet__c NewAnalysisSet = MMIFullquoteTestDataProvider.getAnalysisSet();
	        insert NewAnalysisSet;
	        Weekly_Snapshot_Branch_Report__c NewWeeklySnapshotBranchReport = MMIFullquoteTestDataProvider.getWeeklySnapshotBranchReport();
	        insert NewWeeklySnapshotBranchReport; 
	        ApexPages.currentPage().getParameters().put('quoteid',newProductExtras1.Full_Quote_Transactional__c);
	        FullQuoteEmailQuote fQE7 = new FullQuoteEmailQuote();
	        fQE7.GetPDFcontent();
	        fQE7.deleteQuoutId(newProductExtras1.Full_Quote_Transactional__c);
	        }
		}
		static testMethod void test_FullQuoteEmailQuote6(){
        	User u=MMIFullquoteTestDataProvider.getUser();
	        System.runAs(u) {
	        Product_Extras__c newProductExtras1 = MMIFullquoteTestDataProvider.getnewProductExtras();
	        newProductExtras1.description__c = 'Personal Property Expense';
	        insert newProductExtras1;
	        AdditionalAnalysisSet__c NewAdditionalAnalysisSet = MMIFullquoteTestDataProvider.getAdditionalAnalysisSet();
	        insert NewAdditionalAnalysisSet;
	        AnalysisSet__c NewAnalysisSet = MMIFullquoteTestDataProvider.getAnalysisSet();
	        insert NewAnalysisSet;
	        Weekly_Snapshot_Branch_Report__c NewWeeklySnapshotBranchReport = MMIFullquoteTestDataProvider.getWeeklySnapshotBranchReport();
	        insert NewWeeklySnapshotBranchReport; 
	        ApexPages.currentPage().getParameters().put('quoteid',newProductExtras1.Full_Quote_Transactional__c);
	        FullQuoteEmailQuote fQE7 = new FullQuoteEmailQuote();
	        fQE7.GetPDFcontent();
	        fQE7.deleteQuoutId(newProductExtras1.Full_Quote_Transactional__c);
	        }
		}
		static testMethod void test_FullQuoteEmailQuote7(){
        	User u=MMIFullquoteTestDataProvider.getUser();
	        System.runAs(u) {
	        Product_Extras__c newProductExtras1 = MMIFullquoteTestDataProvider.getnewProductExtras();
	        newProductExtras1.description__c = 'PickUp Zone';
	        insert newProductExtras1;
	        AdditionalAnalysisSet__c NewAdditionalAnalysisSet = MMIFullquoteTestDataProvider.getAdditionalAnalysisSet();
	        insert NewAdditionalAnalysisSet;
	        AnalysisSet__c NewAnalysisSet = MMIFullquoteTestDataProvider.getAnalysisSet();
	        insert NewAnalysisSet;
	        Weekly_Snapshot_Branch_Report__c NewWeeklySnapshotBranchReport = MMIFullquoteTestDataProvider.getWeeklySnapshotBranchReport();
	        insert NewWeeklySnapshotBranchReport; 
	        ApexPages.currentPage().getParameters().put('quoteid',newProductExtras1.Full_Quote_Transactional__c);
	        FullQuoteEmailQuote fQE7 = new FullQuoteEmailQuote();
	        fQE7.GetPDFcontent();
	        fQE7.deleteQuoutId(newProductExtras1.Full_Quote_Transactional__c);
	        }
		}
		static testMethod void test_FullQuoteEmailQuote8(){
        	User u=MMIFullquoteTestDataProvider.getUser();
	        System.runAs(u) {
	        Product_Extras__c newProductExtras1 = MMIFullquoteTestDataProvider.getnewProductExtras();
	        newProductExtras1.description__c = 'Delivery Zone';
	        insert newProductExtras1;
	        AdditionalAnalysisSet__c NewAdditionalAnalysisSet = MMIFullquoteTestDataProvider.getAdditionalAnalysisSet();
	        insert NewAdditionalAnalysisSet;
	        AnalysisSet__c NewAnalysisSet = MMIFullquoteTestDataProvider.getAnalysisSet();
	        insert NewAnalysisSet;
	        Weekly_Snapshot_Branch_Report__c NewWeeklySnapshotBranchReport = MMIFullquoteTestDataProvider.getWeeklySnapshotBranchReport();
	        insert NewWeeklySnapshotBranchReport; 
	        ApexPages.currentPage().getParameters().put('quoteid',newProductExtras1.Full_Quote_Transactional__c);
	        FullQuoteEmailQuote fQE7 = new FullQuoteEmailQuote();
	        fQE7.GetPDFcontent();
	        fQE7.deleteQuoutId(newProductExtras1.Full_Quote_Transactional__c);
	        }
		}
		static testMethod void test_FullQuoteEmailQuote9(){
        	User u=MMIFullquoteTestDataProvider.getUser();
	        System.runAs(u) {
	        Product_Extras__c newProductExtras1 = MMIFullquoteTestDataProvider.getnewProductExtras1();
	        newProductExtras1.description__c = 'Delivery Zone';
	        insert newProductExtras1;
	        AdditionalAnalysisSet__c NewAdditionalAnalysisSet = MMIFullquoteTestDataProvider.getAdditionalAnalysisSet();
	        insert NewAdditionalAnalysisSet;
	        AnalysisSet__c NewAnalysisSet = MMIFullquoteTestDataProvider.getAnalysisSet();
	        insert NewAnalysisSet;
	        Weekly_Snapshot_Branch_Report__c NewWeeklySnapshotBranchReport = MMIFullquoteTestDataProvider.getWeeklySnapshotBranchReport();
	        insert NewWeeklySnapshotBranchReport; 
	        ApexPages.currentPage().getParameters().put('quoteid',newProductExtras1.Full_Quote_Transactional__c);
	        FullQuoteEmailQuote fQE7 = new FullQuoteEmailQuote();
	        fQE7.GetPDFcontent();
            FullQuoteEmailQuote.wrapperSummaryLine  FQE = new FullQuoteEmailQuote.wrapperSummaryLine();
                
	        fQE7.deleteQuoutId(newProductExtras1.Full_Quote_Transactional__c);
	        }
		}
}