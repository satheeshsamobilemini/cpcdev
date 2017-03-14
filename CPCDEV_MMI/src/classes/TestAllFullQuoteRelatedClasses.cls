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
private class TestAllFullQuoteRelatedClasses {

    static testmethod void testUpdateAccount_AC(){
        User u=MMIFullquoteTestDataProvider.getUser();
        System.runAs(u) {
            Test.startTest();
                UpdateAccount_AC udatAcc = new UpdateAccount_AC();
                udatAcc.responseJSON = MMITestDataProvider.getMMIErrorResponse();
                udatAcc.changeAccountNo('5462532','accit','50737');
                
                UpdateAccount_AC udatAcc1 = new UpdateAccount_AC();
                udatAcc1.responseJSON = MMITestDataProvider.getMMIExceptionResponse();
                udatAcc1.changeAccountNo('5462532','accit','50737');
    
                
                UpdateAccount_AC.parseChangeAccResponse pareCh = new UpdateAccount_AC.parseChangeAccResponse();
                
            Test.stopTest();
        }
        
    }
    
    static testMethod void testRemoveLineService_AC(){
        
        List<HomeBaseBeans.quoteLine> summaryLineInEdit = MMIFullquoteTestDataProvider.getQuoteLine();
        HomeBaseBeans.quoteLine newquoteline = MMIFullquoteTestDataProvider.getQuoteLinerecoed();
        
        RemoveLineService_AC removeLine = new RemoveLineService_AC();
        removeLine.addNewItemToSummaryLine(newquoteline, summaryLineInEdit);
        removeLine.CreateDuplicateCopyOfSummaryLine(summaryLineInEdit);
        removeLine.removeItemFromSummaryLine(1,'10i','2',summaryLineInEdit);
    }
    
    static testmethod void testReserveCapacityParser_AC(){
        ReserveCapacityParser_AC reserveCap = new ReserveCapacityParser_AC();
        reserveCap.callReserveCapacity(system.today(), 'test','1245251','1', '1', 'rental');        
    } 
    
    static testMethod void testRefreshLineService()
    {
        User u=MMIFullquoteTestDataProvider.getUser();
        System.runAs(u) { 
            Test.startTest();
        RefreshLineService_AC refreshLineService = new RefreshLineService_AC();
        RefreshLineService_AC.refreshLineClass innrClass = new RefreshLineService_AC.refreshLineClass();
                RefreshLineService_AC.refreshLineForSalesClass refreshLine = new RefreshLineService_AC.refreshLineForSalesClass();
                
        refreshLineService.refreshLineResponse = '"errorCode"';
        
                HomeBaseBeans.quoteLine quoteLineBean = MMIFullquoteTestDataProvider.getQuoteLinerecoed();
                
                HomeBaseBeans.quoteLine quoteLineBean1 = MMIFullquoteTestDataProvider.getQuoteLinerecoed();
                quoteLineBean1.SelectedPeriod = 'tes';
                
                HomeBaseBeans.chargeCodes newchargeCodes =MMIFullquoteTestDataProvider.getchargeCodes(); 
                quoteLineBean.chargeCode = newchargeCodes;
                
        
        refreshLineService.refreshLineResponse = '"error"';
                refreshLineService.refreshLine(quoteLineBean,'OFF','102','rental' );
            Test.stopTest();
    }
    }
    static testMethod void testRefreshLineService1()
    {
        User u=MMIFullquoteTestDataProvider.getUser();
        System.runAs(u) {
            Test.startTest();
                RefreshLineService_AC refreshLineService = new RefreshLineService_AC();
                RefreshLineService_AC refreshLineService1 = new RefreshLineService_AC();
                RefreshLineService_AC refreshLineService2 = new RefreshLineService_AC();
                RefreshLineService_AC refreshLineService3 = new RefreshLineService_AC();
                
                RefreshLineService_AC.refreshLineClass innrClass = new RefreshLineService_AC.refreshLineClass();
                refreshLineService.refreshLineResponse = '"errorCode"';
                
                HomeBaseBeans.quoteLine quoteLineBean = MMIFullquoteTestDataProvider.getQuoteLinerecoed();
                quoteLineBean.SelectedPeriod = '2';
                
                HomeBaseBeans.chargeCodes newchargeCodes =MMIFullquoteTestDataProvider.getchargeCodes(); 
                quoteLineBean.chargeCode = newchargeCodes;
                
                refreshLineService.refreshLineResponse = '"error"';
                refreshLineService.refreshLine(quoteLineBean,'MOBO','102','sales' );
            Test.stopTest();
        }
    }
    static testMethod void testRefreshLineService2()
    {
        User u=MMIFullquoteTestDataProvider.getUser();
        System.runAs(u) {
            Test.startTest();
                RefreshLineService_AC refreshLineService = new RefreshLineService_AC();
                RefreshLineService_AC.refreshLineClass innrClass = new RefreshLineService_AC.refreshLineClass();
                refreshLineService.refreshLineResponse = '"errorCode"';
                
                HomeBaseBeans.quoteLine quoteLineBean = MMIFullquoteTestDataProvider.getQuoteLinerecoed();
                quoteLineBean.SelectedPeriod = '2';
                HomeBaseBeans.chargeCodes newchargeCodes =MMIFullquoteTestDataProvider.getchargeCodes(); 
                quoteLineBean.chargeCode = newchargeCodes;
                
                refreshLineService.refreshLineResponse = '"error"';
                refreshLineService.refreshLine(quoteLineBean,'OFF','102','sales' );
            Test.stopTest();
            
        }
    }
    static testMethod void testRefreshLineService3()
    {
        User u=MMIFullquoteTestDataProvider.getUser();
        System.runAs(u) {
            Test.startTest();
                RefreshLineService_AC refreshLineService = new RefreshLineService_AC();
                RefreshLineService_AC.refreshLineClass innrClass = new RefreshLineService_AC.refreshLineClass();
                refreshLineService.refreshLineResponse = '"errorCode"';
                
                HomeBaseBeans.quoteLine quoteLineBean = MMIFullquoteTestDataProvider.getQuoteLinerecoed();
                quoteLineBean.SelectedPeriod = '2';
                HomeBaseBeans.chargeCodes newchargeCodes =MMIFullquoteTestDataProvider.getchargeCodes(); 
                quoteLineBean.chargeCode = newchargeCodes;
                
                refreshLineService.refreshLineResponse = '"error"';
                refreshLineService.refreshLine(quoteLineBean,'OFF','102','sales' );
                
                RefreshLineService_AC refreshLineService1 = new RefreshLineService_AC();
                refreshLineService1.refreshLine(quoteLineBean,'MOBO','102','sales' );
            Test.stopTest();
            
        }
    }
    static testMethod void testRefreshLineService4()
    {
        User u=MMIFullquoteTestDataProvider.getUser();
        System.runAs(u) {
            Test.startTest();
                RefreshLineService_AC refreshLineService = new RefreshLineService_AC();
                RefreshLineService_AC.refreshLineClass innrClass = new RefreshLineService_AC.refreshLineClass();
                refreshLineService.refreshLineResponse = '"errorCode"';
                
                HomeBaseBeans.quoteLine quoteLineBean7 = MMIFullquoteTestDataProvider.getQuoteLinerecoed();
                quoteLineBean7.SelectedPeriod = '7';
                HomeBaseBeans.chargeCodes newchargeCodes7 =MMIFullquoteTestDataProvider.getchargeCodes(); 
                quoteLineBean7.chargeCode = newchargeCodes7;
                
                refreshLineService.refreshLineResponse = '"error"';
                refreshLineService.refreshLine(quoteLineBean7,'OFF','102','sales' );
                
                RefreshLineService_AC refreshLineService1 = new RefreshLineService_AC();
                refreshLineService1.refreshLine(quoteLineBean7,'MOBO','102','sales' );
                
                
            Test.stopTest();
            
        }
    }
    static testMethod void testRefreshLineService5()
    {
        User u=MMIFullquoteTestDataProvider.getUser();
        System.runAs(u) {
            Test.startTest();
                RefreshLineService_AC refreshLineService = new RefreshLineService_AC();
                RefreshLineService_AC.refreshLineClass innrClass = new RefreshLineService_AC.refreshLineClass();
                refreshLineService.refreshLineResponse = '"errorCode"';
                
                HomeBaseBeans.quoteLine quoteLineBean13 = MMIFullquoteTestDataProvider.getQuoteLinerecoed();
                quoteLineBean13.SelectedPeriod = '13';
                HomeBaseBeans.chargeCodes newchargeCodes2 =MMIFullquoteTestDataProvider.getchargeCodes(); 
                quoteLineBean13.chargeCode = newchargeCodes2;
    
                refreshLineService.refreshLineResponse = '"error"';
                refreshLineService.refreshLine(quoteLineBean13,'OFF','102','sales' );
                
                RefreshLineService_AC refreshLineService1 = new RefreshLineService_AC();
                refreshLineService1.refreshLine(quoteLineBean13,'MOBO','102','sales' );
                
            Test.stopTest();
            
        }
    }
    static testMethod void testRefreshLineService6()
    {
        User u=MMIFullquoteTestDataProvider.getUser();
        System.runAs(u) {
            Test.startTest();
                RefreshLineService_AC refreshLineService = new RefreshLineService_AC();
                RefreshLineService_AC.refreshLineClass innrClass = new RefreshLineService_AC.refreshLineClass();
                refreshLineService.refreshLineResponse = '"errorCode"';
                HomeBaseBeans.quoteLine quoteLineBean25 = MMIFullquoteTestDataProvider.getQuoteLinerecoed();
                quoteLineBean25.SelectedPeriod = '28';
                HomeBaseBeans.chargeCodes newchargeCodes25 =MMIFullquoteTestDataProvider.getchargeCodes(); 
                quoteLineBean25.chargeCode = newchargeCodes25;
                refreshLineService.refreshLineResponse = '"error"';
                refreshLineService.refreshLine(quoteLineBean25,'OFF','102','sales' );
                
                RefreshLineService_AC refreshLineService1 = new RefreshLineService_AC();
                refreshLineService1.refreshLine(quoteLineBean25,'MOBO','102','sales' );
            Test.stopTest();
        }
    }   
    
    /*******************************************************************
                    TESTS
    ********************************************************************/
    static testMethod void testProductSearchService()
    { 
        User u=MMITestDataProvider.getUser();
        System.runAs(u) {
        
        Test.startTest();
        HomeBaseBeans.ProductSearch searchProduct = MMITestDataProvider.getprodSearch();
       
        ProductSearchService_AC.PrimaryProducts innrClass1 = new ProductSearchService_AC.PrimaryProducts('','','','','');
        ProductSearchService_AC.SpecificProduct specific = new ProductSearchService_AC.SpecificProduct();
        ProductSearchService_AC service = new ProductSearchService_AC();
        
        /*System.assert(service.listPrimaryProducts(MMITestDataProvider.getUserBranch())!=null);
        System.assert(service.searchProduct(searchProduct,MMITestDataProvider.getUserBranch())!=null);
        System.assert(service.getSpecificProducts('20i',MMITestDataProvider.getUserBranch())!=null);
        System.assert(service.listProductsBasedOnTransactionType(MMITestDataProvider.getUserBranch(),'OFF','Rental')!=null);
        System.assert(service.listSalesProducts(MMITestDataProvider.getUserBranch())!=null);
        System.assert(service.searchSalesProduct(searchProduct,MMITestDataProvider.getUserBranch())!=null);
        System.assert(service.getSpecificSalesProducts('20i',MMITestDataProvider.getUserBranch())!=null);*/
        
         
        ProductSearchService_AC service1 = new ProductSearchService_AC();
        service1.primaryProductResponse = MMITestDataProvider.getMMIErrorResponse();
        service1.searchProductsResponse = MMITestDataProvider.getMMIErrorResponse();
        service1.singleProductResponse=MMITestDataProvider.getMMIErrorResponse();
        /*System.assert(service1.listPrimaryProducts(MMITestDataProvider.getUserBranch())!=null);
        System.assert(service1.searchProduct(searchProduct,MMITestDataProvider.getUserBranch())!=null);
        System.assert(service1.getSpecificProducts('20i',MMITestDataProvider.getUserBranch())!=null);
        System.assert(service1.listProductsBasedOnTransactionType(MMITestDataProvider.getUserBranch(),'OFF','Rental')!=null);
        System.assert(service1.searchSalesProduct(searchProduct,MMITestDataProvider.getUserBranch())!=null);
        System.assert(service1.listSalesProducts(MMITestDataProvider.getUserBranch())!=null);
        System.assert(service1.getSpecificSalesProducts('20i',MMITestDataProvider.getUserBranch())!=null);*/
        
        ProductSearchService_AC service2 = new ProductSearchService_AC();
        service2.primaryProductResponse = MMITestDataProvider.getMMIExceptionResponse();
        service2.searchProductsResponse = MMITestDataProvider.getMMIExceptionResponse();
        service2.singleProductResponse = MMITestDataProvider.getMMIExceptionResponse();
        /*System.assert(service2.listPrimaryProducts(MMITestDataProvider.getUserBranch())!=null);
        System.assert(service2.searchProduct(searchProduct,MMITestDataProvider.getUserBranch())!=null);
        System.assert(service2.getSpecificProducts('20i',MMITestDataProvider.getUserBranch())!=null);
        System.assert(service2.listProductsBasedOnTransactionType(MMITestDataProvider.getUserBranch(),'OFF','Rental')!=null);
        System.assert(service2.listSalesProducts(MMITestDataProvider.getUserBranch())!=null);
        System.assert(service2.searchSalesProduct(searchProduct,MMITestDataProvider.getUserBranch())!=null);
        System.assert(service2.getSpecificSalesProducts('20i',MMITestDataProvider.getUserBranch())!=null);*/
        
        Test.stopTest(); 
        }
    
    }
    
    static testmethod void testSalesFleet_Service(){
        
        User u=MMIFullquoteTestDataProvider.getUser();
            System.runAs(u) {
                Test.startTest();
                    List<HomeBaseBeans.SalesFleets> HomeBaseBeansSalesFleetsList = MMIFullquoteTestDataProvider.getHomeBaseBeansSalesFleetsList();
                    List<HomeBaseBeans.allocations> HomeBaseBeansallocationsList = MMIFullquoteTestDataProvider.getHomeBaseBeansallocationsList();
                    
                    SalesFleet_Service salesFleSer = new SalesFleet_Service();
                    salesFleSer.getSalesFleet('10i','102');
                    salesFleSer.listEcodeList('23232', '102', 'OFF', system.today(),'50737','23232');
                    SalesFleet_Service.SalesFleet salFlt = new SalesFleet_Service.SalesFleet();
                    SalesFleet_Service.Allocation allcotn = new SalesFleet_Service.Allocation();            
                Test.stopTest();
            }
    }
    static testmethod void testUpdateFullQuoteService_AC(){
        User u=MMIFullquoteTestDataProvider.getUser();
        System.runAs(u) {
            Test.startTest();
                fullquoteWrapper fullQWrapper = MMIFullquoteTestDataProvider.getFullWrapper();
                UpdateFullQuoteService_AC updateFullQteser = new UpdateFullQuoteService_AC();
                
                updateFullQteser.updateQuote('test','123121','1','102','98765','rental',fullQWrapper);
            Test.stopTest();
        }
    }
    static testmethod void testQuickQuoteDeleteError(){
    User u=MMIFullquoteTestDataProvider.getUser();
        System.runAs(u) {
            Test.startTest();
                MMI_Quotes__c updateQuoteRec = MMITestDataProvider.getQuickQuote();
                insert updateQuoteRec;
                ApexPages.StandardController sc = new ApexPages.StandardController(updateQuoteRec);
                QuickQuoteDeleteError quickqutoeDetel = new QuickQuoteDeleteError(sc);
                System.currentPageReference().getParameters().put('id',updateQuoteRec.id);
                quickqutoeDetel.deleteQuote();
            Test.stopTest();
        }
    }
    static testmethod void testCapacityLookupService_AC(){
        User u=MMIFullquoteTestDataProvider.getUser();
        System.runAs(u) {
            Test.startTest();
            HomeBaseBeans.capacityLookupRequest clr = MMIFullquoteTestDataProvider.getHomeBaseBeanscapacityLookupRequest();
                CapacityLookupService_AC capiser = new CapacityLookupService_AC();
                capiser.callWebservice(clr);
                                
            Test.stopTest();
        }
    }
    
        static testMethod void testQuickQuoteErrorHandler()
    {
        Test.startTest();
        //System.assert(QuickQuoteErrorHandler.handleError(MMITestDataProvider.getMMIErrorResponse())!=null);
        //System.assert(QuickQuoteErrorHandler.handleError(MMITestDataProvider.getMMIExceptionResponse())!=null);
        QuickQuoteErrorHandler.parseErr innrClass = new QuickQuoteErrorHandler.parseErr();
        Test.stopTest();
        
    }
    
    static testMethod void test_UpdateQuickQuoteService()
    {
        User u=MMITestDataProvider.getUser();
        System.runAs(u) {
            Test.startTest();
            
            UpdateQuickQuoteService updateqq = new UpdateQuickQuoteService();
            updateqq.updateQuoteResponse = MMITestDataProvider.getMMIErrorResponse();
           
            //system.assert(updateqq.updateQuickQuote('q1234','test')!=null);
            updateqq.updateQuoteResponse = MMITestDataProvider.getMMIExceptionResponse();
            //system.assert(updateqq.updateQuickQuote('q1234','test')!=null);
    
            
            
            Test.stopTest();
        }
    }
    
        static testmethod void testAPIRestSalesInventorynew(){
        List<String> st = new List<string>();
        List<HB_Sales_Inventory__c> newQuickHBSalesInventoryList  = MMITestDataProvider.getQuickHBSalesInventoryList();
        //insert newQuickHBSalesInventoryList;
        st.add('test');
        APIRestSalesInventory apirestSaleIn = new APIRestSalesInventory();
        APIRestSalesInventory.doPost('XZaY69470Dzsejl3859hty!Te' ,'new','1','test', '102' ,'10i' ,'542512','2','3243','test des','232' ,'23','43', '2' , '54', true, 'test', 'NORM', true, st);
        APIRestSalesInventory.validateTokenValue('XZaY69470Dzsejl3859hty!Te');
        
    }
     static testmethod void testAPIRestSalesInventoryupdate(){
        List<String> st = new List<string>();
        List<HB_Sales_Inventory__c> newQuickHBSalesInventoryList  = MMITestDataProvider.getQuickHBSalesInventoryList();
        insert newQuickHBSalesInventoryList;
        st.add('test');
        APIRestSalesInventory apirestSaleIn = new APIRestSalesInventory();
        APIRestSalesInventory.doPost('XZaY69470Dzsejl3859hty!Te' ,'update','1','test', '102' ,'10i' ,'542512','2','3243','test des','232' ,'23','43', '2' , '54', true, 'test', 'NORM', true, st);
        APIRestSalesInventory.validateTokenValue('XZaY69470Dzsejl3859hty!Te');
        
    }
     static testmethod void testAPIRestSalesInventorydelete(){
        List<String> st = new List<string>();
        List<HB_Sales_Inventory__c> newQuickHBSalesInventoryList  = MMITestDataProvider.getQuickHBSalesInventoryList();
        insert newQuickHBSalesInventoryList;
        
        st.add('test');
        APIRestSalesInventory apirestSaleIn = new APIRestSalesInventory();
        APIRestSalesInventory.doPost('XZaY69470Dzsejl3859hty!Te' ,'delete','1','test', '102' ,'10i' ,'542512','2','3243','test des','232' ,'23','43', '2' , '54', true, 'test', 'NORM', true, st);
        APIRestSalesInventory.validateTokenValue('XZaY69470Dzsejl3859hty!Te');
        
    }
    static testmethod void testAPIRestSalesInventorydeletesuggestNull(){
        List<String> st = new List<string>();
        
        List<HB_Sales_Inventory__c> newQuickHBSalesInventoryList1  = MMITestDataProvider.getQuickHBSalesInventoryList();
        insert newQuickHBSalesInventoryList1;
        
        st.add('test');
        APIRestSalesInventory apirestSaleIn = new APIRestSalesInventory();
        APIRestSalesInventory.doPost('XZaY69470Dzsejl3859hty!Te' ,'update','1','test', '102' ,'10i' ,'542512','2','3243','test des','null' ,'null','null', '2' , '54', true, 'test', 'NORM', true, st);
        APIRestSalesInventory.validateTokenValue('XZaY69470Dzsejl3859hty!Te');
        
    }
    static testmethod void testAPIRestSalesInventorydeletesuggestNullforNew(){
        List<String> st = new List<string>();
        
        List<HB_Sales_Inventory__c> newQuickHBSalesInventoryList2  = MMITestDataProvider.getQuickHBSalesInventoryList();
        insert newQuickHBSalesInventoryList2;
        
        st.add('test');
        APIRestSalesInventory apirestSaleIn = new APIRestSalesInventory();
        APIRestSalesInventory.doPost('XZaY69470Dzsejl3859hty!Te' ,'new','1','test', '102' ,'10i' ,'54212512','2','3243','test des','null' ,'null','null', '2' , '54', true, 'test', 'NORM', true, st);
        APIRestSalesInventory.validateTokenValue('XZaY69470Dzsejl3859hty!Te');
        
    }
    
    static testmethod void testAPIRestSalesInventoryupdatewrongEcoceforUpdate(){
        List<String> st = new List<string>();
        List<HB_Sales_Inventory__c> newQuickHBSalesInventoryList  = MMITestDataProvider.getQuickHBSalesInventoryList();
        insert newQuickHBSalesInventoryList;
        st.add('test');
        APIRestSalesInventory apirestSaleIn = new APIRestSalesInventory();
        APIRestSalesInventory.doPost('XZaY69470Dzsejl3859hty!Te' ,'update','1','test', '102' ,'10i' ,'52342512','2','3243','test des','232' ,'23','43', '2' , '54', true, 'test', 'NORM', true, st);
        APIRestSalesInventory.validateTokenValue('XZaY69470Dzsejl3859hty!Te');
        
    }
     static testmethod void testAPIRestSalesInventorydeletewrongEcodeforNew(){
        List<String> st = new List<string>();
        List<HB_Sales_Inventory__c> newQuickHBSalesInventoryList  = MMITestDataProvider.getQuickHBSalesInventoryList();
        insert newQuickHBSalesInventoryList;
        
        st.add('test');
        APIRestSalesInventory apirestSaleIn = new APIRestSalesInventory();
        APIRestSalesInventory.doPost('XZaY69470Dzsejl3859hty!Te' ,'delete','1','test', '102' ,'10i' ,'23542512','2','3243','test des','232' ,'23','43', '2' , '54', true, 'test', 'NORM', true, st);
        APIRestSalesInventory.validateTokenValue('XZaY69470Dzsejl3859hty!Te');
        
    }
    static testmethod void testAPIRestSalesInventorydeletewrongEcodefornotanyaction(){
        List<String> st = new List<string>();
        List<HB_Sales_Inventory__c> newQuickHBSalesInventoryList  = MMITestDataProvider.getQuickHBSalesInventoryList();
        insert newQuickHBSalesInventoryList;
        
        st.add('test');
        APIRestSalesInventory apirestSaleIn = new APIRestSalesInventory();
        APIRestSalesInventory.doPost('XZaY69470Dzsejl3859hty!Tetes' ,'','1','test', '102' ,'10i' ,'23542512','2','3243','test des','232' ,'23','43', '2' , '54', true, 'test', 'NORM', true, st);
        APIRestSalesInventory.validateTokenValue('XZaY69470Dzsejl3859hty!Te');
        
    }
    
    static testMethod void testProductSearchServiceSalesQQ()
    { 
        User u=MMITestDataProvider.getUser();
        System.runAs(u) {
        
        Test.startTest();
        HomeBaseBeans.ProductSearch searchProduct = MMITestDataProvider.getprodSearch();
       
        ProductSearchServiceSalesQQ.PrimaryProducts innrClass1 = new ProductSearchServiceSalesQQ.PrimaryProducts('','','','','');
        ProductSearchServiceSalesQQ service = new ProductSearchServiceSalesQQ();
        /*System.assert(service.listPrimaryProducts(MMITestDataProvider.getUserBranch())!=null);
        System.assert(service.searchProduct(searchProduct,MMITestDataProvider.getUserBranch())!=null);
        System.assert(service.getSpecificProducts('20w',MMITestDataProvider.getUserBranch())!=null);*/
        
        ProductSearchServiceSalesQQ service1 = new ProductSearchServiceSalesQQ();
        service1.primaryProductResponse = MMITestDataProvider.getMMIErrorResponse();
        service1.searchProductsResponse = MMITestDataProvider.getMMIErrorResponse();
        /*System.assert(service1.listPrimaryProducts(MMITestDataProvider.getUserBranch())!=null);
        System.assert(service1.searchProduct(searchProduct,MMITestDataProvider.getUserBranch())!=null);
        System.assert(service1.getSpecificProducts('20w',MMITestDataProvider.getUserBranch())!=null);*/
        
        ProductSearchServiceSalesQQ service2 = new ProductSearchServiceSalesQQ();
        service2.primaryProductResponse = MMITestDataProvider.getMMIExceptionResponse();
        service2.searchProductsResponse = MMITestDataProvider.getMMIExceptionResponse();
        /*System.assert(service2.listPrimaryProducts(MMITestDataProvider.getUserBranch())!=null);
        System.assert(service2.searchProduct(searchProduct,MMITestDataProvider.getUserBranch())!=null);
        System.assert(service2.getSpecificProducts('20w',MMITestDataProvider.getUserBranch())!=null);*/
        
        Test.stopTest();
        }
    
    }
     
    static testMethod void testQuickQuoteEditService_AC()
    { 
        User u=MMITestDataProvider.getUser();
        System.runAs(u) {
        
        Test.startTest();

        QuickQuoteEditService_AC.qqEditResponse = MMITestDataProvider.getMMIErrorResponse();
        //System.assert(QuickQuoteEditService_AC.getQuickQuoteDetails('q123')==null);
            
        
        QuickQuoteEditService_AC.qqEditResponse = MMITestDataProvider.getMMIExceptionResponse();
        //System.assert(QuickQuoteEditService_AC.getQuickQuoteDetails('q123')!=null);
        
        Test.stopTest();
        }
    
    }
    // Test method
    static testMethod void testCreateQuoteService_AC()
    {
        CreateQuoteService_AC service = new CreateQuoteService_AC();
        service.quoteResponse = MMIFullquoteTestDataProvider.getMMIErrorResponse();
        service.CreateQuote('106','102','sales');
        
        CreateQuoteService_AC service1 = new CreateQuoteService_AC();
        service1.quoteResponse = MMIFullquoteTestDataProvider.getMMIExceptionResponse();
        service1.CreateQuote('106','102','sales');
        
    }
    static testMethod void testRefreshQuoteService_AC6()
    {
        User u=MMIFullquoteTestDataProvider.getUser();
        System.runAs(u) {
            Test.startTest();
                RefreshQuoteService_AC refreshQuoteServe = new RefreshQuoteService_AC();
                refreshQuoteServe.quoteRefreshResponse = MMITestDataProvider.getMMIErrorResponse();
                refreshQuoteServe.callRefreshQuoteService('test','102','98765', 'rental');
                                
                RefreshQuoteService_AC refreshQuoteServe1 = new RefreshQuoteService_AC();
                refreshQuoteServe1.quoteRefreshResponse = MMITestDataProvider.getMMIExceptionResponse();
                refreshQuoteServe1.callRefreshQuoteService('test','102','98765', 'rental');
                                
            Test.stopTest();
        }
    }
      
    testMethod static void test_QuickQuoteHelper(){
         Test.startTest();
         QuickQuoteWrapper.InnerProductClass productDetail=new QuickQuoteWrapper.InnerProductClass();
         QuickQuoteHelper helper=new QuickQuoteHelper();
         /*system.assert(helper.calculateTotal(MMITestDataProvider.getQQWrapper())==null);
         system.assert(helper.calculateTotalAfterRefresh(MMITestDataProvider.getHBQQRefresh(),MMITestDataProvider.getQQWrapper())==null);
         system.assert(helper.getDurationRate(MMITestDataProvider.getQQWrapper())==null);
         system.assert(helper.emptyQQWrapper(MMITestDataProvider.getQQWrapper())==null);
         system.assert(helper.refreshQQwrapper(MMITestDataProvider.getQQWrapper(), '126', '301233444', system.today())!=null);
         system.assert(helper.assignValuesLoadWBsEditQuote(MMITestDataProvider.getQQWrapper(), MMITestDataProvider.getQuickQuote(), MMITestDataProvider.getQuickQuote(), '30123456')==null);
         system.assert(helper.assignSelectedProdRate(MMITestDataProvider.getQQWrapper(), MMITestDataProvider.getinnerProd())==null);
         system.assert(helper.assignSelectedProdRateEdit(MMITestDataProvider.getQQWrapper(), MMITestDataProvider.getinnerProdEdit())==null); 
         system.assert(helper.assignSelectedProdRateSales(MMITestDataProvider.getQQWrapper(), productDetail)==null);
         
          system.assert(helper.assignValuesLoadWBsEditSalesQuote(MMITestDataProvider.getQQWrapper(), MMITestDataProvider.getQuickQuote(), MMITestDataProvider.getQuickQuote(), '30123456',MMITestDataProvider.getEditSalesQQwrap())==null);*/ 
        
         Test.stopTest();
    }
    static testMethod void testStateService()
    {
        User u=MMITestDataProvider.getUser();
        System.runAs(u) {
            Test.startTest();
            Account acc=MMITestDataProvider.getAccount();
            insert acc;
            Lead newLead=MMITestDataProvider.getLeadWithDeliveryAdd();
            insert newLead;
            Opportunity opp=MMITestDataProvider.getOpportunity();
            insert opp;

            MMI_Quotes__c mmiQuote=MMITestDataProvider.getQuickQuoteDAO(opp.id);
            insert mmiQuote;
            
            Manage_Triggers__c manageTrigCustomSetting = new Manage_Triggers__c();
      manageTrigCustomSetting.Name = 'SendDeadLeadTo360IntegrationService';
      manageTrigCustomSetting.Active__c = true;
      insert manageTrigCustomSetting;
      
            /*System.assert( QuickQuoteMainDAO.getLeadRecord(newLead.Id)!=null);
            System.assert( QuickQuoteMainDAO.getUserBranchDetails()!=null);
            System.assert(QuickQuoteMainDAO.getAccRecord(acc.Id)!=null);
            //System.assert(QuickQuoteMainDAO.convertLead(newLead.Id, u.Id)!=null);
            System.assert(QuickQuoteMainDAO.getLeadStatus()!=null);
            System.assert(QuickQuoteMainDAO.insertQuickQuote(mmiQuote)==null);
            System.assert(QuickQuoteMainDAO.getOppRecord(newLead.Id)!=null);
            System.assert(QuickQuoteMainDAO.getQuickQuoteRecord(mmiQuote.Id)!=null);
            System.assert(QuickQuoteMainDAO.updateQuickQuotes(mmiQuote)!=null);
            System.assert(QuickQuoteMainDAO.getOppToUpdate(opp.Id)!=null);
            System.assert(QuickQuoteMainDAO.updateOppName(opp)!=null);
            System.assert(QuickQuoteMainDAO.getAccountList(acc.id)!=null);
            System.assert(QuickQuoteMainDAO.insertOpportunity(opp)!=null);*/
            
            

            Test.stopTest();
        }
    }
    // Test method
    static testMethod void testSalesRepService()
    {
        User u=MMIFullquoteTestDataProvider.getUser();
        System.runAs(u) {
            Test.startTest();
        SalesRepService SalesRepServiceRef = new SalesRepService();
        SalesRepServiceRef.salesRepResponse = '"errorCode"';
        SalesRepServiceRef.listSalesReps();
                SalesRepServiceRef.SalesReps('98765');
        
        SalesRepServiceRef.salesRepResponse = '"error"';
        SalesRepServiceRef.listSalesReps();
                SalesRepServiceRef.SalesReps('98765');
                        
        SalesRepService.salesRepListClass innrClass = new SalesRepService.salesRepListClass();
                SalesRepService.SalesRepRes innrclasssale = new SalesRepService.SalesRepRes(); 
            Test.stopTest();
        }
        
    }
    static testMethod void testAddressesService()
    {
        
        User u=MMITestDataProvider.getUser();
        System.runAs(u) {
        Test.startTest();
        CreateQuickQuoteService_AC addreService = new CreateQuickQuoteService_AC();
        
        HomeBaseBeans.CreateQuickQuoteRequest QQCR = new HomeBaseBeans.CreateQuickQuoteRequest();
        String request=addreService.getCreateRequestRequest(QQCR);
        
        
        addreService.createQuoteResponse = MMITestDataProvider.getMMIErrorResponse();
        addreService.createQuickQuote(request);
        
        CreateQuickQuoteService_AC addreService1 = new CreateQuickQuoteService_AC();
        addreService1.createQuoteResponse = MMITestDataProvider.getMMIExceptionResponse();
        addreService1.createQuickQuote(request);
        
        Test.stopTest();
        }
    }
    static testMethod void testAccountService()
    {
        AccountService acctService = new AccountService();
        acctService.accountResponse = '"errorCode"';
        acctService.listAccounts('1','CHES','test');
        acctService.listAccountsSearchPattern('test','CHES','test');
        
        AccountService acctService1 = new AccountService();
        acctService1.accountResponse = '"error"';
        acctService1.listAccounts('1','CHES','test');
        acctService1.listAccountsSearchPattern('test','CHES','test');
                        
        AccountService.AccountClass innrClass = new AccountService.AccountClass();
        AccountService.AccountListpattern innerClassList = new AccountService.AccountListpattern(); 
    }
    
    static testMethod void testmarkaslost()
    {
        User u=MMIFullquoteTestDataProvider.getUser();
        System.runAs(u) {
        Test.startTest();
            MarkAsLostService markaslost = new MarkAsLostService();
            markaslost.quoteResponse = MMITestDataProvider.getMMIErrorResponse();
            markaslost.CreateQuote('renta', 'test', '23425', '102');
            
            
            MarkAsLostService markaslost1 = new MarkAsLostService();
            markaslost1.quoteResponse = MMITestDataProvider.getMMIExceptionResponse();
            markaslost1.CreateQuote('sales', 'test', '23425', '102');
            
            MarkAsLostService.MarkAsLostQuote markinnrClass = new MarkAsLostService.MarkAsLostQuote();
            Test.stopTest();
        }
    }
    // Test method
    static testMethod void testAdAddressesService()
    {
        AddressesService addreService = new AddressesService();
        addreService.addressResponse = '"errorCode"';
        addreService.listAddresses('1');
        
        AddressesService addreService1 = new AddressesService();
        addreService1.addressResponse = '"error"';
        addreService1.listAddresses('1');
        
        AddressesService.AddressesClass innrClass = new AddressesService.AddressesClass();
    }
    // Test method
    static testMethod void testAnalysisSetCodesService()
    {
        //--------------------TFS 1380------------------------
        /*AnalysisSetCodesService_AC service = new AnalysisSetCodesService_AC();
        service.analysisResponse = '"errorCode"';
        service.listActiveTransactions('106');
        
        AnalysisSetCodesService_AC service1 = new AnalysisSetCodesService_AC();
        service1.analysisResponse = '"error"';
        service1.listActiveTransactions('106');
        
        AnalysisSetCodesService_AC.AnalysisParentClass innrClass = new AnalysisSetCodesService_AC.AnalysisParentClass();*/
        //-------Added-------------TFS 1380------------------------
        User u=MMITestDataProvider.getUser();
        System.runAs(u) {
            Test.startTest();
            list<Transaction_Type__c> lstTT = new list<Transaction_Type__c>();
            Transaction_Type__c tt1 = new Transaction_Type__c();
            tt1.Name = 'OFF';
            tt1.Description__c = 'offsite';
            lstTT.add(tt1);
            Transaction_Type__c tt2 = new Transaction_Type__c();
            tt2.Name = 'SOFL';
            tt2.Description__c = 'sales order fleet service';
            lstTT.add(tt2);
            insert lstTT;
            
            list<Analysis_set_header__c> lstASH = new list<Analysis_set_header__c>();
            Analysis_set_header__c ashObj1 = new Analysis_set_header__c();
            ashObj1.Id__c = '111';
            ashObj1.Description__c = 'wrwere';
            ashObj1.Transaction_Type__c = tt1.id;
            lstASH.add(ashObj1);
            Analysis_set_header__c ashObj2 = new Analysis_set_header__c();
            ashObj2.Id__c = '112';
            ashObj2.Description__c = 'wrzzczxcd were';
            ashObj2.Transaction_Type__c = tt2.id;
            lstASH.add(ashObj2);
            Analysis_set_header__c ashObj3 = new Analysis_set_header__c();
            ashObj3.Id__c = '142';
            ashObj3.Description__c = 'wrwasds asd ere';
            ashObj3.Transaction_Type__c = tt1.id;
            lstASH.add(ashObj3);
            Analysis_set_header__c ashObj4 = new Analysis_set_header__c();
            ashObj4.Id__c = '103';
            ashObj4.Description__c = 'wrwera  adsde';
            ashObj4.Transaction_Type__c = tt1.id;
            lstASH.add(ashObj4);
            
            insert lstASH;
            
            list<Analysis_set_code__c> ascLst = new list<Analysis_set_code__c>();
            Analysis_set_code__c ascObj1 = new Analysis_set_code__c();
            ascObj1.Id__c = '1234';
            ascObj1.Description__c = '1234';
            ascObj1.Long_description__c = '1234';
            ascObj1.Analysis_set_header__c = ashObj1.Id;
            ascLst.add(ascObj1);
            Analysis_set_code__c ascObj2 = new Analysis_set_code__c();
            ascObj2.Id__c = '1234';
            ascObj2.Description__c = '1234';
            ascObj2.Long_description__c = '1234';
            ascObj2.Analysis_set_header__c = ashObj1.Id;
            ascLst.add(ascObj2);
            Analysis_set_code__c ascObj3 = new Analysis_set_code__c();
            ascObj3.Id__c = '1234';
            ascObj3.Description__c = '1234';
            ascObj3.Long_description__c = '1234';
            ascObj3.Analysis_set_header__c = ashObj2.Id;
            ascLst.add(ascObj3);
            Analysis_set_code__c ascObj4 = new Analysis_set_code__c();
            ascObj4.Id__c = '1234';
            ascObj4.Description__c = '1234';
            ascObj4.Long_description__c = '1234';
            ascObj4.Analysis_set_header__c = ashObj2.Id;
            ascLst.add(ascObj4);
            
            insert ascLst;
            
            AnalysisSetCodesService_AC service1 = new AnalysisSetCodesService_AC();
            service1.listActiveTransactions('111');
            service1.listActiveTransactions('112');
             
            Test.stopTest();
        }
    }
    
    // Test method
    static testMethod void testAnalysisSetsService()
    {
        //--------------------TFS 1380------------------------
        /*AnalysisSetsService_AC service = new AnalysisSetsService_AC();
        service.analysisResponse = '"errorCode"';
        service.listActiveTransactions('rest/api/v1/companies/1/transactions/OFF/analysis_sets');
        
        AnalysisSetsService_AC service1 = new AnalysisSetsService_AC();
        service1.analysisResponse = '"error"';
        service1.listActiveTransactions('rest/api/v1/companies/1/transactions/OFF/analysis_sets');
        
        AnalysisSetsService_AC.AnalysisParentClass innrClass = new AnalysisSetsService_AC.AnalysisParentClass();*/
        //--------Added------------TFS 1380------------------------
        User u=MMITestDataProvider.getUser();
        System.runAs(u) {
            Test.startTest();
            list<Transaction_Type__c> lstTT = new list<Transaction_Type__c>();
            Transaction_Type__c tt1 = new Transaction_Type__c();
            tt1.Name = 'OFF';
            tt1.Description__c = 'offsite';
            lstTT.add(tt1);
            Transaction_Type__c tt2 = new Transaction_Type__c();
            tt2.Name = 'SOFL';
            tt2.Description__c = 'sales order fleet service';
            lstTT.add(tt2);
            insert lstTT;
            
            list<Analysis_set_header__c> lstASH = new list<Analysis_set_header__c>();
            Analysis_set_header__c ashObj1 = new Analysis_set_header__c();
            ashObj1.Id__c = '111';
            ashObj1.Description__c = 'wrwere';
            ashObj1.Transaction_Type__c = tt1.id;
            lstASH.add(ashObj1);
            Analysis_set_header__c ashObj2 = new Analysis_set_header__c();
            ashObj2.Id__c = '112';
            ashObj2.Description__c = 'wrzzczxcd were';
            ashObj2.Transaction_Type__c = tt2.id;
            lstASH.add(ashObj2);
            Analysis_set_header__c ashObj3 = new Analysis_set_header__c();
            ashObj3.Id__c = '142';
            ashObj3.Description__c = 'wrwasds asd ere';
            ashObj3.Transaction_Type__c = tt1.id;
            lstASH.add(ashObj3);
            Analysis_set_header__c ashObj4 = new Analysis_set_header__c();
            ashObj4.Id__c = '103';
            ashObj4.Description__c = 'wrwera  adsde';
            ashObj4.Transaction_Type__c = tt1.id;
            lstASH.add(ashObj4);
            
            insert lstASH;
            AnalysisSetsService_AC service1 = new AnalysisSetsService_AC();
            service1.listActiveTransactions('OFF');
            service1.listActiveTransactions('OFF_Extra');
             
            Test.stopTest();
        }
        
    }
    
    static testMethod void testContactsService()
    {
        ContactsService_AC service = new ContactsService_AC();
        service.contactsResponse = '"errorCode"';
        service.listContacts('1');
        
        service.contactsResponse = '"error"';
        service.listContacts('1');      
        
        ContactsService_AC.countryListClass innrClass = new ContactsService_AC.countryListClass();
    }
    static testMethod void testCustomSort()
    {
        User u=MMIFullquoteTestDataProvider.getUser();
        System.runAs(u) {
            Test.startTest();
                List<FullQuoteWrapper.quote> FullquoteWrpQuoteList = MMIFullquoteTestDataProvider.getFullQuoteWrpquoteList();
                CustomSort newcustomSort = new CustomSort();
                CustomSort.sortByLastDate(FullquoteWrpQuoteList,'Desc');
            
                CustomSort.sortByLastDate(FullquoteWrpQuoteList,'Acs');
                
            Test.stopTest();
        }
        }
        static testMethod void testchargeCodesService()
    {
        chargeCodesService_AC service = new chargeCodesService_AC();
        service.chargeCodeResponse = '"errorCode"';
        service.getChargeCodeList('1');
        
        service.chargeCodeResponse = '"error"';
        service.getChargeCodeList('1');
        
        chargeCodesService_AC.ChargeCodesClass innrClass = new chargeCodesService_AC.ChargeCodesClass();
    }
    static testMethod void testQuickQuoteMainService() 
    {
        User u=MMITestDataProvider.getUser();
        System.runAs(u) {
            Test.startTest();
            QuickQuoteWrapper qqwrap=MMITestDataProvider.getQQWrapper();
            Account acc=MMITestDataProvider.getAccount(); 
            insert acc;
            Lead newLead=MMITestDataProvider.getLead();
            insert newLead;
            Opportunity opp=MMITestDataProvider.getOpportunity();
            insert opp; 
            
             
            MMI_Quotes__c qq=new MMI_Quotes__c();
            MMI_Quotes__c qq1=MMITestDataProvider.getQuickQuote();
            insert qq1;
            Manage_Triggers__c manageTrigCustomSetting = new Manage_Triggers__c();
      manageTrigCustomSetting.Name = 'SendDeadLeadTo360IntegrationService';
      manageTrigCustomSetting.Active__c = true;
      insert manageTrigCustomSetting;
            
             
            
            QuickQuoteMainService qqservice=new QuickQuoteMainService();
            
            /*System.assert(qqservice.getuserBranchInfo()!=null);
            System.assert(qqservice.getLeadinfo(newLead.Id)!=null);
            System.assert(qqservice.getOppInfo(newLead.Id)!=null);
            System.assert( qqservice.getAccInfo(acc.Id)!=null);
            System.assert(qqservice.insertQuickQuoteRecord(qq,'201',Date.Today(),'30123456',opp.Id,'q111',qqwrap,acc.id)!=null);
            System.assert(qqservice.getQuickQuote(qq1.id)!=null);
            System.assert(qqservice.updateQuickQuoteRecord(qq1,'126',system.today(),'30123456', qqwrap)!=null);*/
            
            Test.stopTest();
        }
    }
    static testMethod void testQuickQuoteMainService2() 
    {
        User u=MMITestDataProvider.getUser();
        System.runAs(u) {
            Test.startTest();
            QuickQuoteWrapper qqwrap = MMITestDataProvider.getQQWrapper();
            Account acc=MMITestDataProvider.getAccount(); 
            insert acc;
            Lead newLead=MMITestDataProvider.getLead();
            insert newLead;
            Opportunity opp=MMITestDataProvider.getOpportunity();
            opp.AccountId = acc.id;
            insert opp;
            
            MMI_Quotes__c qq=new MMI_Quotes__c();
            MMI_Quotes__c qq1=MMITestDataProvider.getQuickQuote();
          
            Manage_Triggers__c manageTrigCustomSetting = new Manage_Triggers__c();
            manageTrigCustomSetting.Name = 'SendDeadLeadTo360IntegrationService';
            manageTrigCustomSetting.Active__c = true;
            insert manageTrigCustomSetting;
            
             
            
            QuickQuoteMainService qqservice=new QuickQuoteMainService();
            
            /*System.assert(qqservice.insertQuickQuoteSalesRecord(qq,'201',Date.Today(),'30123456',opp.Id,'q111',qqwrap,acc.id)!=null);
            System.assert(qqservice.updateQuickQuoteSalesRecord(qq1,'126',system.today(),'30123456', qqwrap)!=null);
            System.assert(qqservice.updateOppName(opp.id,qqwrap)!=null);*/
            qqservice.insertOpportunity(acc);       
            qqservice.getuserSalesRepId();
            QuickQuoteWrapper qqWrap1 = new QuickQuoteWrapper();
            qqWrap1.oppContactName = 'testfn';
            qqWrap1.oppContactLastName = 'testfn';
            qqWrap1.oppContactPhone = '21133131';
            qqservice.getConvertLeadResult(newLead.id,u.id,qqWrap1);
            qqservice.getAccounListInfo(acc.id);
            qqservice.updateOppNameSales(opp.id ,qqwrap, system.today(), date.today(), '102');
            
            Test.stopTest();
        }
    }
    
    static testMethod void testQuoteToOrderService_AC()
    {
        QuoteToOrderService_AC service = new QuoteToOrderService_AC();
        service.quoteToOrderResponse = MMIFullquoteTestDataProvider.getMMIErrorResponse();
        service.callQuoteToOrder('123456','1.0','1234','rental');
        
        QuoteToOrderService_AC service1 = new QuoteToOrderService_AC();
        service1.quoteToOrderResponse = MMIFullquoteTestDataProvider.getMMIExceptionResponse();
        service1.callQuoteToOrder('123456','1.0','1234','rental');
        
    }
    
    static testMethod void testCountryService()
    {
        User u=MMITestDataProvider.getUser();
        System.runAs(u) {
            Test.startTest();
            CountryService_AC.countryListClass innerclass=new CountryService_AC.countryListClass();
            CountryService_AC acctService = new CountryService_AC();
            acctService.countryResponse = MMITestDataProvider.getMMIErrorResponse();
            System.assert(acctService.listCountry()!=null);

            CountryService_AC acctService1 = new CountryService_AC();
            acctService1.countryResponse = MMITestDataProvider.getMMIExceptionResponse();
            System.assert(acctService1.listCountry()!=null);
            Test.stopTest();
        }
    }
    static testMethod void testFulfillingBranchService()
    {
        User u=MMITestDataProvider.getUser();
        System.runAs(u) {
            Test.startTest();
            
            FulfillingBranchService_AC addreService = new FulfillingBranchService_AC();
            addreService.branchesResponse = MMITestDataProvider.getMMIErrorResponse();
            //System.assert(addreService.listBranches()!=null);
            
            FulfillingBranchService_AC addreService1 = new FulfillingBranchService_AC();
            addreService1.branchesResponse =MMITestDataProvider.getMMIExceptionResponse();
            //System.assert(addreService1.listBranches()!=null);
            FulfillingBranchService_AC.BranchAddresses branchadd=new FulfillingBranchService_AC.BranchAddresses();

            Test.stopTest();
        }
    }
        static testMethod void testServiceProxy()
    {
        User u=MMITestDataProvider.getUser();
        System.runAs(u) {
            Test.startTest();
            
            ServiceProxy ServiceProxyRef = new ServiceProxy();
            ServiceProxyRef.createErrorHistory('testEndpoint','wsMethod','Payload','responseBody',200,'ErrorMsg','ErrorStackTrace',10);
            delete [select id from MMI_Webservices_Config__c];
            insert MMITestDataProvider.getMMICustomSettings();
            
            //System.assert(ServiceProxyRef.callRestService(MMITestDataProvider.getTestServiceEndpoint(), MMITestDataProvider.getTestServiceMethod(), MMITestDataProvider.getTestServiceRequestBody())!=null);
            Test.stopTest();
        }
    
    }
    
    static testMethod void testStateService3()
    {
        User u=MMITestDataProvider.getUser();
        System.runAs(u) {
            Test.startTest();
            //--------TFS 1380-----------------------------------
            /*StateService_AC stateService = new StateService_AC();
            stateService.branchesResponse = MMITestDataProvider.getMMIErrorResponse();
            System.assert(stateService.listStates(MMITestDataProvider.getCountrycode())!=null);
            
            StateService_AC stateService1 = new StateService_AC();
            stateService1.branchesResponse =MMITestDataProvider.getMMIExceptionResponse();
            System.assert(stateService1.listStates(MMITestDataProvider.getCountrycode())!=null);
            StateService_AC.stateListClass innrClass = new StateService_AC.stateListClass();*/
            //----Added----TFS 1380-----------------------------------
            list<Country_and_State__c> lstStates = new list<Country_and_State__c>();
            Country_and_State__c cs1 =new Country_and_State__c();
            cs1.Name = 'US';
            cs1.State__c = 'AZ';
            lstStates.add(cs1);
            Country_and_State__c cs2 =new Country_and_State__c();
            cs2.Name = 'US';
            cs2.State__c = 'LA';
            lstStates.add(cs2);
            Country_and_State__c cs3 =new Country_and_State__c();
            cs3.Name = 'CA';
            cs3.State__c = 'ON';
            lstStates.add(cs3);
            insert lstStates;
            StateService_AC stateService = new StateService_AC();
            stateService.branchesResponse = MMITestDataProvider.getMMIErrorResponse();
            stateService.listStates('USA');
            stateService.listStates('Canada');
            StateService_AC.stateListClass SSSTC = new  StateService_AC.stateListClass();
            
            MMITestDataProvider MMITDP = new MMITestDataProvider();
            MMITestDataProvider.getTestServiceEndpoint();
            MMITestDataProvider.getProductBrochureLookupquic();
            MMITestDataProvider.getTestServiceMethod();
            MMITestDataProvider.getTestServiceRequestBody();
            MMITestDataProvider.getUserBranch();
            MMITestDataProvider.getCountrycode();
            MMITestDataProvider.getAccountOnlyBillingAdd();
            MMITestDataProvider.getAccountOnlyBillingAddSihpping();
            MMITestDataProvider.getOppoWithDeliveryAdd();
            MMITestDataProvider.getOppoWithOutDeliveryAddAccShippAdd();
            MMITestDataProvider.getHomebaseInitialize();
            MMITestDataProvider.getQuickQuoteWrapperproductTypes();
            MMITestDataProvider.getQuickQuoteWrapperProductSales();
            MMITestDataProvider.getHBQQRefresh();
            MMITestDataProvider.getinnerProd();
            MMITestDataProvider.getinnerProdEdit();
            MMITestDataProvider.getQQAddressWrapper();
            MMITestDataProvider.getQQDecarteWrapper();
            MMITestDataProvider.getQQInnerProdWrapper();
            MMITestDataProvider.getQQShowBranchWrapper();
            MMITestDataProvider.getQQStateInnerWrapper();
            MMITestDataProvider.getQQControllerInnerProdWrapper();
            MMITestDataProvider.getQQControllerInnerProdWrapper1();
            MMITestDataProvider.getQQControllerEditInnerProdWrapper();
            MMITestDataProvider.getQHomeBaseProduct();
            MMITestDataProvider.getQHomeBaseProductSingle();
            MMITestDataProvider.getQHomeBaseTax();
            MMITestDataProvider.getQQControllerAddressWrapper();
            MMITestDataProvider.getQQControllerDecarteWrapper();
            MMITestDataProvider.getQHomeBasecontry();
            MMITestDataProvider.getQHomeBaseState();
            MMITestDataProvider.getQHomeBaseCreateQQ();
            MMITestDataProvider.getQHomeBaseWebAdd();
            MMITestDataProvider.getQHomeBaseBranch();
            MMITestDataProvider.getQQControllerEditAddressWrapper();
            MMITestDataProvider.getQQControllerEditDecarteWrapper();
            MMITestDataProvider.getEditSalesQQwrap();
            MMITestDataProvider.getHBSalesInventory();
            MMITestDataProvider.getSalesQQDecarteWrapper();
            MMITestDataProvider.getSalesProductSales();
            MMITestDataProvider.getHBSalesInventoryList();
            MMITestDataProvider.getSalesQQSaveDecarteWrapper();
            MMITestDataProvider.getQQSaveDecarteWrapper();
            
            MMIFullquoteTestDataProvider.getUserWithAdmin();
            MMIFullquoteTestDataProvider.getBranchLookup();
            MMIFullquoteTestDataProvider.getDocument();
            MMIFullquoteTestDataProvider.getProductBrochureLookup();
            MMIFullquoteTestDataProvider.getnewSummaryLine();
            MMIFullquoteTestDataProvider.getnewSummaryLineList();
            MMIFullquoteTestDataProvider.getnewProductExtras1();
            MMIFullquoteTestDataProvider.getAdditionalAnalysisSetList();
            MMIFullquoteTestDataProvider.getAnalysisSetList();
            MMIFullquoteTestDataProvider.getWeeklySnapshotBranchReport();
            MMIFullquoteTestDataProvider.getRate();
            MMIFullquoteTestDataProvider.getRateList();
            MMIFullquoteTestDataProvider.getaccessory();
            MMIFullquoteTestDataProvider.getStandardModificationList();
            MMIFullquoteTestDataProvider.getHBSalesInventoryList();
            MMIFullquoteTestDataProvider.getFullQuoteWrpstateInnerClass();
            MMIFullquoteTestDataProvider.getFullQuoteWrpAddressInnerClass();
            MMIFullquoteTestDataProvider.getFullQuoteWrpstdModification();
            MMIFullquoteTestDataProvider.getFullQuoteWrpApproverList();
            MMIFullquoteTestDataProvider.getFullQuoteWrpquote();
            MMIFullquoteTestDataProvider.getFullQuoteWrpProductSales();
            MMIFullquoteTestDataProvider.getFullQuoteWrpSalesImages();
            MMIFullquoteTestDataProvider.getFullQuoteWrpproductTypes();
            MMIFullquoteTestDataProvider.getFullQuoteWrpproductSizes();
            MMIFullquoteTestDataProvider.getHomeBaseBeansCreateFullQuoteResponse();
            MMIFullquoteTestDataProvider.getanalysisSetHeader2();
            MMIFullquoteTestDataProvider.getHomeBaseBeansrates();
            MMIFullquoteTestDataProvider.getRefreshRespo();
            MMIFullquoteTestDataProvider.getEditSalesFullQuoteData();
           /* Full_Quote_Transactional__c FQT = new Full_Quote_Transactional__c();
            FQT.Name = 'Test Quote';
            insert FQT;
            MMIFullquoteTestDataProvider.getSummaryLineTransactionalList(FQT);
            MMIFullquoteTestDataProvider.getProductExtrasTransactional(FQT);
            MMIFullquoteTestDataProvider.getTransactionalFullQuote(FQT);*/
            
            Test.stopTest();
        }
    }
    
    static testMethod void testTransactionListService()
    {
        User u=MMITestDataProvider.getUser();
        System.runAs(u) {
            Test.startTest();
            
            //--------------TFS 2380----------------------
            /*TransactionListService_AC.TransactionClass innrClass = new TransactionListService_AC.TransactionClass();
          
            TransactionListService_AC transactionService = new TransactionListService_AC();
            transactionService.transactionResponse = MMITestDataProvider.getMMIErrorResponse();
            System.assert(transactionService.listActiveTransactions(MMITestDataProvider.getUserBranch())!=null);
            
            TransactionListService_AC transactionService1 = new TransactionListService_AC();
            transactionService1.transactionResponse = MMITestDataProvider.getMMIExceptionResponse();
            System.assert(transactionService1.listActiveTransactions(MMITestDataProvider.getUserBranch())!=null);*/
            //------Added--------TFS 2380----------------------
            list<Transaction_Type__c> lstTT = new list<Transaction_Type__c>();
            Transaction_Type__c tt1 = new Transaction_Type__c();
            tt1.Name = 'OFF';
            tt1.Description__c = 'offsite';
            lstTT.add(tt1);
            Transaction_Type__c tt2 = new Transaction_Type__c();
            tt2.Name = 'SOFL';
            tt2.Description__c = 'sales order fleet service';
            lstTT.add(tt2);
            insert lstTT;
            TransactionListService_AC transactionService = new TransactionListService_AC();
            transactionService.listActiveTransactions('112');
            
            Test.stopTest();
        }
    }
    static testMethod void testOauth_WebService()
    {
        User u=MMITestDataProvider.getUser();
        System.runAs(u) {
            Test.startTest();
            Oauth_WebService.Bearer oauthserv=new Oauth_WebService.Bearer();
            delete [select id from MMI_Webservices_Config__c];
            insert MMITestDataProvider.getMMICustomSettings();  
            //System.assert(Oauth_WebService.TestCallout()==null);
            Test.stopTest();
        }
    
    }
        static testMethod void testServiceProxyclass()
    {
        User u=MMITestDataProvider.getUser();
        System.runAs(u) {
            Test.startTest();

            SaleInventoryImageService s=new SaleInventoryImageService();

            delete [select id from MMI_Webservices_Config__c];
            insert MMITestDataProvider.getMMICustomSettings();
            
            //System.assert(s.callEditWEbservice('79d06061-bb4b-4ee1-a19c-6e28f595e06a')!=null); 
            Test.stopTest();
        }
        
    }
    static testMethod void testEditSalesQuickQuoteWrap()
    {
        Test.startTest();
        EditSalesQuickQuoteWrap editSQ=new EditSalesQuickQuoteWrap();
        EditSalesQuickQuoteWrap.ShippingAddress es=new EditSalesQuickQuoteWrap.ShippingAddress();
        Test.stopTest();
        
    }
     
    testMethod static void test_getDurationList(){
         Test.startTest();
         
            List<QuickQuoteWrapper.productTypes>  newProductTypeNewList = MMITestDataProvider.getQuickQuoteWrapperproductTypesList();
            List<QuickQuoteWrapper.productSizes> newProductSizeNewList = MMITestDataProvider.getnewProductSizeNewList();
            
            /*system.assert(QuickQuoteUtilities.getProductSizeNewListFullQuote()!=null);
            system.assert(QuickQuoteUtilities.getProductSizeNewList()!=null);
            system.assert(QuickQuoteUtilities.getProductTypeNewListFullQuote()!=null);
            system.assert(QuickQuoteUtilities.getProductTypeNewList()!=null);
          system.assert(QuickQuoteUtilities.getDurationList()!=null); 
          system.assert(QuickQuoteUtilities.getProductTypeList()!=null);
          system.assert(QuickQuoteUtilities.getProductSizeList()!=null); */ 
              
         Test.stopTest();
    }
        static testMethod void testRefreshQuickQuoteService()
    {

        User u=MMITestDataProvider.getUser();
        System.runAs(u) {
            Test.startTest();
            
            RefreshQuickQuoteService_AC refreshQQService = new RefreshQuickQuoteService_AC();
            refreshQQService.quickQuoteRefreshResponse  = MMITestDataProvider.getMMIErrorResponse();
            //System.assert(refreshQQService.refreshQuickQuote(new HomeBaseBeans.QuickQuoteRefreshFormat())!=null);
            //System.assert(refreshQQService.getQuickQuoteRefreshRequest(new HomeBaseBeans.QuickQuoteRefreshFormat())!=null);
            
            RefreshQuickQuoteService_AC refreshQQService1 = new RefreshQuickQuoteService_AC();
            refreshQQService1.quickQuoteRefreshResponse = MMITestDataProvider.getMMIExceptionResponse();
            //System.assert(refreshQQService1.refreshQuickQuote(new HomeBaseBeans.QuickQuoteRefreshFormat())!=null);
            
            Test.stopTest();
        }
            
    }
        static testMethod void testHomeBaseBeans()
    { 
        Test.startTest();   
         //system.assert(MMITestDataProvider.getHomebaseInitialize()==null);

        Test.stopTest();

    }
    static testMethod void testCustomerActivityService()
    {
        CustomerActivityService customerActiSer = new CustomerActivityService();
        customerActiSer.callCAOrderService('12');
         customerActiSer.callEditWEbservice('12','98765','102');
        
    }
    static testMethod void testFullQuoteEditResponseService_AC()
    {
        FullQuoteEditResponseService_AC service = new FullQuoteEditResponseService_AC();
        service.callEditWEbservice('101', '98765', '102', 'salesl');
        
    }
    static testMethod void testParse() {
        String json=        '{'+
        '    "quotePK": {'+
        '        "companyId": 1,'+
        '        "documentId": 100000549,'+
        '        "type": "rental",'+
        '        "mobilization": 1.00'+
        '    },'+
        '    "message": "Quote conversionsucceeded.",'+
        '    "convertedContractPK": {'+
        '        "companyId": 1,'+
        '        "documentId": 100000304,'+
        '        "type": "rental",'+
        '        "mobilization": 1.00'+
        '    }'+
        '}';
        QuoteToOrderParser_AC obj = new QuoteToOrderParser_AC();
        obj.parseResponse(json);
        QuoteToOrderParser_AC.cls_quotePK quotepk = new QuoteToOrderParser_AC.cls_quotePK();
        QuoteToOrderParser_AC.cls_convertedContractPK converConPK = new QuoteToOrderParser_AC.cls_convertedContractPK();
        //System.assert(obj != null);
    }
        static testMethod void testSalesInvImageController()
    {
        User u=MMITestDataProvider.getUser();
        System.runAs(u) {
            SalesInventoryImages__c si= MMIFullquoteTestDataProvider.getSalesInvImage();
            insert si;
            Test.startTest();
            System.currentPageReference().getParameters().put('recId',si.id);
            SalesInvImageController control=new SalesInvImageController();

            Test.stopTest();
        }
    
    }
       static testmethod void testQuickQuoteSaveRequestGenerator(){
            User u=MMITestDataProvider.getUser();
            System.runAs(u) {
                Test.startTest();
                    QuickQuoteWrapper QQWrapper = MMITestDataProvider.getQQWrapper();
                    QuickQuoteSaveRequestGenerator quickQtesaveRe = new QuickQuoteSaveRequestGenerator();
                    quickQtesaveRe.getQuickQuoteRefreshRequest(QQWrapper,'102', 'test','dixit','rental');
        
                    QuickQuoteSaveRequestGenerator.SaveRentalQQRequest saveRentInnerClass = new QuickQuoteSaveRequestGenerator.SaveRentalQQRequest();
                    QuickQuoteSaveRequestGenerator.SaveSalesQQRequest saveSaleInnerClass = new QuickQuoteSaveRequestGenerator.SaveSalesQQRequest();
                    QuickQuoteSaveRequestGenerator.QuickQuoteWrap qickquoteWrpInnerCalss = new QuickQuoteSaveRequestGenerator.QuickQuoteWrap(); 
                    QuickQuoteSaveRequestGenerator.QuickQuoteSalesWrap quickQuoteSaleWrp = new QuickQuoteSaveRequestGenerator.QuickQuoteSalesWrap();
                    QuickQuoteSaveRequestGenerator.Address addressInnerClass = new  QuickQuoteSaveRequestGenerator.Address();
                Test.stopTest();            
            }
        }
        static testmethod void testQuickQuoteSaveRequestGenerator1(){
            User u=MMITestDataProvider.getUser();
            System.runAs(u) {
                Test.startTest();
                    QuickQuoteWrapper QQWrapper = MMITestDataProvider.getQQWrapper();
                    QuickQuoteSaveRequestGenerator quickQtesaveRe = new QuickQuoteSaveRequestGenerator();
                    quickQtesaveRe.getQuickQuoteRefreshRequest(QQWrapper,'102', 'test','dixit','sales');
                Test.stopTest();            
            }
        }
            static testMethod void testStateServicetest()
    {
            Test.startTest();
            QuickQuoteWrapper qqwrapper=new QuickQuoteWrapper();
            QuickQuoteWrapper.AddressInnerClass addressInner =new QuickQuoteWrapper.AddressInnerClass();
            QuickQuoteWrapper.DescarteInnerClass descarteInner=new QuickQuoteWrapper.DescarteInnerClass();
            QuickQuoteWrapper.InnerProductClass productInner=new QuickQuoteWrapper.InnerProductClass();
            QuickQuoteWrapper.showbranches showBranches=new QuickQuoteWrapper.showbranches ();
            QuickQuoteWrapper.stateInnerClass stateInner=new QuickQuoteWrapper.stateInnerClass();
            QuickQuoteWrapper.SalesFleetWapper salesFleet=new QuickQuoteWrapper.SalesFleetWapper();
            QuickQuoteWrapper.productTypes productTypeinn = new QuickQuoteWrapper.productTypes();
            QuickQuoteWrapper.productSizes produsizeinn = new QuickQuoteWrapper.productSizes();

            Test.stopTest();
    
    }
    
                static testMethod void testCapacityLookUpXMLParser_AC()
    {
            Test.startTest();
           CapacityLookUpXMLParser_AC cap = new CapacityLookUpXMLParser_AC();
           string response = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"><soapenv:Body><ns2:capacityResponse xmlns:ns2="http://capacity.services.operation.cuberoute.com"><return>'+
                            '<response><responseCode>Success</responseCode>'+
                                '<capacities>'+
                                    '<date>2013-05-08T04:00:00.000Z</date>'+        
                                    '<mileage>20.85073</mileage>'+
                                    '<storeNumber>941</storeNumber>'+
                                    '<storeType>Location</storeType>'+
                                    '<depotGroup>Rialto Tilt</depotGroup>'+
                                    '<amCapacity>0</amCapacity>'+
                                    '<pmCapacity>3</pmCapacity>'+
                                    '<noPrefCapacity>0</noPrefCapacity>'+
                                '</capacities>'+    
                                '<capacities>'+
                                    '<date>2013-05-09T04:00:00.000Z</date>'+
                                    '<mileage>20.85073</mileage>'+
                                    '<storeNumber>941</storeNumber>'+
                                    '<storeType>Location</storeType>'+
                                    '<depotGroup>Rialto Tilt</depotGroup>'+
                                    '<amCapacity>0</amCapacity>'+
                                    '<pmCapacity>3</pmCapacity>'+
                                    '<noPrefCapacity>0</noPrefCapacity>'+
                                '</capacities>'+
                            '<capacityReservationID xsi:nil="1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"/>'+
                            '</response></return></ns2:capacityResponse></soapenv:Body></soapenv:Envelope>'; 
           cap.loadData(response);

            Test.stopTest();
    
    }
    static testmethod void testCreateProspectAccount_AC(){
        User u=MMIFullquoteTestDataProvider.getUser();
        System.runAs(u) {
            Test.startTest();
            HomeBaseBeans.ProspectAccountParam prose = MMIFullquoteTestDataProvider.getHomeBaseBeansProspectAccountParam();
            
            CreateProspectAccount_AC createProsAc = new CreateProspectAccount_AC();
            createProsAc.ProspectAcct(prose);
            CreateProspectAccount_AC.ResponseObj innerRespo = new CreateProspectAccount_AC.ResponseObj();
            createProsAc.parseResponse('<?xml version="1.0"?>'+'<goldmineImporter><Company>test</Company>'+'<SalesforceID>123</SalesforceID>'+'<Contact>123</Contact>'+'<Address1>test</Address1><Address2></Address2>'+'<Address3></Address3>'+'<City>tesc</City>'+'<State>az</State>'+'<Zip>123</Zip><Country>usa</Country>'+'<Phone1>123</Phone1><Phone2></Phone2><Phone3></Phone3>'+'<FAX></FAX><Email></Email>'+'<RepCode>1234</RepCode>'+'<BranchCode>34</BranchCode><WebSite></WebSite>'+'<JobTitle></JobTitle><Ext1></Ext1><Salutation></Salutation>'+'<ResultParent></ResultParent><ResultID></ResultID>'+'</goldmineImporter>');
            CreateProspectAccount_AC.ResponseObj innerrclass = new CreateProspectAccount_AC.ResponseObj();
            Test.stopTest();
        }
    }
    
}