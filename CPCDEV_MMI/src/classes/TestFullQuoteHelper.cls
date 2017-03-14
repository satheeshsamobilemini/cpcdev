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
private class TestFullQuoteHelper {

    static testMethod void myUnitTestforFullQuoteHelper() {
    	User u=MMIFullquoteTestDataProvider.getUser();
    	System.runAs(u) {
    	Test.startTest();
        FullQuoteHelper fullQuoteHelp = new FullQuoteHelper();
        
        List<HomeBaseBeans.quoteLine> quoteLineData = new List<HomeBaseBeans.quoteLine>();
        quoteLineData = MMIFullquoteTestDataProvider.getQuoteLine();
        
        List<HomeBaseBeans.AnalysisSetHeaders> analysisSetHeaderResponseList = new List<HomeBaseBeans.AnalysisSetHeaders>(); 
        analysisSetHeaderResponseList = MMIFullquoteTestDataProvider.getanalysisSetHeader();
        List<HomeBaseBeans.AnalysisSetHeaders> analysisSetHeaderResponseShippingList = new List<HomeBaseBeans.AnalysisSetHeaders>();
        analysisSetHeaderResponseShippingList = MMIFullquoteTestDataProvider.getanalysisSetHeader();
        
        
        List<HomeBaseBeans.extras> ProductExtrasList = new List<HomeBaseBeans.extras>();
        ProductExtrasList = MMIFullquoteTestDataProvider.getProductExtrasList();
        
        FullQuoteWrapper.DescarteInnerClass fullQuteDescard = new FullQuoteWrapper.DescarteInnerClass();
        fullQuteDescard = MMIFullquoteTestDataProvider.getFullQuoteWrpDescarte();
        
        FullQuoteWrapper fullQWrapper= MMIFullquoteTestDataProvider.getFullWrapper(); 
        
        MMI_Full_Quotes__c updateQuoteRec = MMIFullquoteTestDataProvider.getnewteMMIFullQuote();
        insert updateQuoteRec;
        Full_Quote_Transactional__c fullQuote_tran = MMIFullquoteTestDataProvider.getnewFullQuoteTransaction();
        insert fullQuote_tran;
        
        Summary_Line__c summryLine=MMIFullquoteTestDataProvider.getSummaryLineTransactionalList(fullQuote_tran.id);
        insert summryLine;
        Product_Extras__c prodExtra=MMIFullquoteTestDataProvider.getProductExtrasTransactional(fullQuote_tran.id);
        insert prodExtra;
      
        Full_Quote_Transactional__c fullQuotTransactional =MMIFullquoteTestDataProvider.getTransactionalFullQuote(fullQuote_tran.id);
        
        HomeBaseBeans.TaxIds selectedTaxRecInShipping = new HomeBaseBeans.TaxIds();
        HomeBaseBeans.TaxIds selectedTaxRecInBilling = new HomeBaseBeans.TaxIds();
        selectedTaxRecInShipping = MMIFullquoteTestDataProvider.gethomeBaseBeanTaxId();
        selectedTaxRecInBilling = MMIFullquoteTestDataProvider.gethomeBaseBeanTaxId();
        
        FullQuoteRefreshParser_AC EditResponse = MMIFullquoteTestDataProvider.getRefreshRespo();
        EditFullQUoteService_AC EditResponse2=MMIFullquoteTestDataProvider.getEditFullQuoteData();
        
        String startDate = '2013-2-12';
        string plannedCollectionDate = 'test';
        String quoteExpires = '2013-2-12';
        String PO_Expires = '2013-2-12';
        String shippingDate = '2013-2-12';
        String SelectedShipingTaxId = '421525';
        String SelectedRentalLength = '2';
        string docId = '1';
        string cloneTrue = 'true';
        Integer summaryLineCount = 1;
        
        fullQuoteHelp.getrefreshFullQwrapper(fullQWrapper);
        fullQuoteHelp.getRefreshPayload(fullQWrapper,quoteLineData,analysisSetHeaderResponseList, analysisSetHeaderResponseShippingList, ProductExtrasList, fullQuteDescard,fullQuteDescard, startDate,plannedCollectionDate, quoteExpires, PO_Expires, shippingDate,selectedTaxRecInShipping,selectedTaxRecInBilling,SelectedShipingTaxId, SelectedRentalLength,docId,updateQuoteRec);
        fullQuoteHelp.assingModificationValue(fullQuotTransactional,fullQWrapper,ProductExtrasList,summaryLineCount,quoteLineData,fullQuteDescard,fullQuteDescard,analysisSetHeaderResponseList,analysisSetHeaderResponseShippingList);
        fullQuoteHelp.assignRefreshValue(fullQWrapper,quoteLineData,analysisSetHeaderResponseList,analysisSetHeaderResponseShippingList,ProductExtrasList,fullQuteDescard,fullQuteDescard,startDate,plannedCollectionDate, quoteExpires, PO_Expires, shippingDate,selectedTaxRecInBilling,selectedTaxRecInShipping,EditResponse);                              
    	fullQuoteHelp.assignEditValue(EditResponse2,fullQWrapper,ProductExtrasList,summaryLineCount,quoteLineData,fullQuteDescard,fullQuteDescard,analysisSetHeaderResponseList,analysisSetHeaderResponseShippingList);
    	fullQuoteHelp.getSavePayload(cloneTrue,docId,fullQWrapper,quoteLineData,analysisSetHeaderResponseList,analysisSetHeaderResponseShippingList,ProductExtrasList,fullQuteDescard,fullQuteDescard,
                                           startDate,plannedCollectionDate, quoteExpires, PO_Expires, shippingDate,
                                           selectedTaxRecInBilling,
                                           selectedTaxRecInShipping,
                                           SelectedShipingTaxId,
                                           '0',
                                          '1.0', SelectedRentalLength,updateQuoteRec );
    	
    	 Test.stopTest();
    	}
    	
    }
    
        static testMethod void myUnitTestforFullQuoteHelper2() {
    	User u=MMIFullquoteTestDataProvider.getUser();
    	System.runAs(u) {
    	Test.startTest();
        FullQuoteHelper fullQuoteHelp = new FullQuoteHelper();
        
        List<HomeBaseBeans.quoteLine> quoteLineData = new List<HomeBaseBeans.quoteLine>();
        quoteLineData = MMIFullquoteTestDataProvider.getQuoteLine();
        
        List<HomeBaseBeans.AnalysisSetHeaders> analysisSetHeaderResponseList = new List<HomeBaseBeans.AnalysisSetHeaders>(); 
        analysisSetHeaderResponseList = MMIFullquoteTestDataProvider.getanalysisSetHeader();
        List<HomeBaseBeans.AnalysisSetHeaders> analysisSetHeaderResponseShippingList = new List<HomeBaseBeans.AnalysisSetHeaders>();
        analysisSetHeaderResponseShippingList = MMIFullquoteTestDataProvider.getanalysisSetHeader();
        
        
        List<HomeBaseBeans.extras> ProductExtrasList = new List<HomeBaseBeans.extras>();
        ProductExtrasList = MMIFullquoteTestDataProvider.getProductExtrasList();
        
        FullQuoteWrapper.DescarteInnerClass fullQuteDescard = new FullQuoteWrapper.DescarteInnerClass();
        fullQuteDescard = MMIFullquoteTestDataProvider.getFullQuoteWrpDescarte();
        
        FullQuoteWrapper fullQWrapper= MMIFullquoteTestDataProvider.getFullWrapperSales(); 
        
        MMI_Full_Quotes__c updateQuoteRec = MMIFullquoteTestDataProvider.getnewteMMIFullQuote();
        insert updateQuoteRec;
        Full_Quote_Transactional__c fullQuote_tran = MMIFullquoteTestDataProvider.getnewFullQuoteTransaction();
        insert fullQuote_tran;
         Summary_Line__c summryLine=MMIFullquoteTestDataProvider.getSummaryLineTransactionalList(fullQuote_tran.id);
        insert summryLine;
        Product_Extras__c prodExtra=MMIFullquoteTestDataProvider.getProductExtrasTransactional(fullQuote_tran.id);
        insert prodExtra;
        
        Full_Quote_Transactional__c fullQuotTransactional =MMIFullquoteTestDataProvider.getTransactionalFullQuote(fullQuote_tran.id);
        
        HomeBaseBeans.TaxIds selectedTaxRecInShipping = new HomeBaseBeans.TaxIds();
        HomeBaseBeans.TaxIds selectedTaxRecInBilling = new HomeBaseBeans.TaxIds();
        selectedTaxRecInShipping = MMIFullquoteTestDataProvider.gethomeBaseBeanTaxId();
        selectedTaxRecInBilling = MMIFullquoteTestDataProvider.gethomeBaseBeanTaxId();
        
        FullQuoteRefreshParser_AC EditResponse = MMIFullquoteTestDataProvider.getRefreshRespo();
         EditFullQUoteService_AC EditResponse2=MMIFullquoteTestDataProvider.getEditSalesFullQuoteData();
        
        String startDate = '2013-2-12';
        string plannedCollectionDate = 'test';
        String quoteExpires = '2013-2-12';
        String PO_Expires = '2013-2-12';
        String shippingDate = '2013-2-12';
        String SelectedShipingTaxId = '421525';
        String SelectedRentalLength = '2';
        string docId = '1';
        Integer summaryLineCount = 1;
		string cloneTrue = 'true';
        fullQuoteHelp.getRefreshPayload(fullQWrapper,quoteLineData,analysisSetHeaderResponseList, analysisSetHeaderResponseShippingList, ProductExtrasList, fullQuteDescard,fullQuteDescard, startDate,plannedCollectionDate, quoteExpires, PO_Expires, shippingDate,selectedTaxRecInShipping,selectedTaxRecInBilling,SelectedShipingTaxId, SelectedRentalLength,docId,updateQuoteRec);
        fullQuoteHelp.assingModificationValue(fullQuotTransactional,fullQWrapper,ProductExtrasList,summaryLineCount,quoteLineData,fullQuteDescard,fullQuteDescard,analysisSetHeaderResponseList,analysisSetHeaderResponseShippingList);
        fullQuoteHelp.assignRefreshValue(fullQWrapper,quoteLineData,analysisSetHeaderResponseList,analysisSetHeaderResponseShippingList,ProductExtrasList,fullQuteDescard,fullQuteDescard,startDate,plannedCollectionDate, quoteExpires, PO_Expires, shippingDate,selectedTaxRecInBilling,selectedTaxRecInShipping,EditResponse);                              
    	fullQuoteHelp.assignEditValue(EditResponse2,fullQWrapper,ProductExtrasList,summaryLineCount,
                                  quoteLineData,fullQuteDescard,fullQuteDescard,
                                  analysisSetHeaderResponseList,analysisSetHeaderResponseShippingList);
                                  
        fullQuoteHelp.getSavePayload(cloneTrue,docId,fullQWrapper,quoteLineData,
                                         analysisSetHeaderResponseList,
                                          analysisSetHeaderResponseShippingList,
                                          ProductExtrasList,
                                          fullQuteDescard,
                                          fullQuteDescard,
                                           startDate,plannedCollectionDate, quoteExpires, PO_Expires, shippingDate,
                                           selectedTaxRecInBilling,
                                           selectedTaxRecInShipping,
                                           SelectedShipingTaxId,
                                           '0',
                                          '1.0', SelectedRentalLength,updateQuoteRec );
    	
    	 Test.stopTest();
    	}
    	
    	
    	
    }
}