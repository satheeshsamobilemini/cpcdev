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
private class TestQuickQuoteMainController_AC {
	static testMethod void test_QuickQuoteMainController()
        {
            User u=MMITestDataProvider.getUser();
            System.runAs(u) {
            Test.startTest();
            Account acc=MMITestDataProvider.getAccount();
            insert acc;
            Lead newLead=MMITestDataProvider.getLead();
            insert newLead;
            Opportunity opp=MMITestDataProvider.getOpportunity();
            insert opp;
            Manage_Triggers__c manageTrigCustomSetting = new Manage_Triggers__c();
      manageTrigCustomSetting.Name = 'SendDeadLeadTo360IntegrationService';
      manageTrigCustomSetting.Active__c = true;
      insert manageTrigCustomSetting;
            
                  //    System.assert( QuickQuoteMainDAO.getLeadRecord(newLead.Id)!=null);
                System.currentPageReference().getParameters().put('recId',newLead.Id);
                 System.currentPageReference().getParameters().put('selectedProd','2');
                 System.currentPageReference().getParameters().put('prodCode','20i');
                 System.currentPageReference().getParameters().put('selectedTex','1');
                  System.currentPageReference().getParameters().put('selectedAddr','1');
                   System.currentPageReference().getParameters().put('SelectedBranch','2');
                 

                QuickQuoteMainController_AC QQ = new QuickQuoteMainController_AC();
                QQ.QuickQuoteMainController_AC_initalize();
                QQ.ShowProduct=true;
            
                QQ.qqWrapper=MMITestDataProvider.getQQWrapper();
                QQ.DescarteInnerClassList =MMITestDataProvider.getQQSaveDecarteWrapper();
                QQ.onTypeChangePageRedi();
	            QQ.qqType = 'Rental';
                QQ.addressInner=MMITestDataProvider.getQQAddressWrapper();
                QQ.descarteInner=MMITestDataProvider.getQQDecarteWrapper();
                QQ.productInner=MMITestDataProvider.getQQInnerProdWrapper();
                QQ.showBranches=MMITestDataProvider.getQQShowBranchWrapper();
                QQ.stateInner=MMITestDataProvider.getQQStateInnerWrapper();
                QQ.proRef=MMITestDataProvider.getQuickQuote();
                
                QQ.address1='123 abc';
                QQ.address2='123 abc';
                QQ.address3='123 abc';
                QQ.address4='123 abc';
                QQ.state2='AZ';
                QQ.zipCode2='85282';
                QQ.countryId2='USA';
                QQ.BranchId='113';
                QQ.salesRepErr=true;
                
                QQ.getClientLoaded();
                QQ.setClientLoaded();
                QQ.hideError();
                QQ.getproRef();
                QQ.getOppRef();
                QQ.getLeadRef();        
                QQ.CalculateTotals();
                QQ.getDispAddressPopUp();
                QQ.getDispProductPopUp();
                QQ.SelectedProduct();
                QQ.CloseProductPopUp();        
                QQ.AmendShipping();        
                QQ.ViewBrnchSnapshot();
                QQ.ProductSearch();        
                QQ.Refresh();        
                QQ.SaveAddress();        
                QQ.CancelAddress();
                QuickQuoteMainController_AC.InnerProductClass InnerProductClassRef = new QuickQuoteMainController_AC.InnerProductClass();
                QQ.ShowProductPopUp();
                QQ.ProductsSelection();
                QQ.getStateOptions();
                QQ.getCountryOptions();
                QQ.getInnerProductsList();
                QQ.getInnerProductSearchList();
                QQ.getShowProduct(); 
                QuickQuoteMainController_AC.AddressInnerClass AddressInnerClassRef = new QuickQuoteMainController_AC.AddressInnerClass();
                QQ.getAddressInnerClassList();
                QQ.ValidateAddress();
                QQ.SelectedAddressId();
                QQ.CancelSelectedAddressId();
                QQ.SelectFulfillingBranch();
                QQ.getSelectFulfillingLoaded();
                QQ.FulfillingBranchSelected();
                QQ.CancelFulfillingBranchSelected();
                QQ.getDescarteInnerClassList();
                QuickQuoteMainController_AC.DescarteInnerClass DescarteInnerClassRef = new QuickQuoteMainController_AC.DescarteInnerClass();
                QQ.getDispDescProductPopUp();
                QQ.CountriesList();
                QQ.StatesList();
                QuickQuoteMainController_AC.stateInnerClass stateInnerClassRef = new QuickQuoteMainController_AC.stateInnerClass();
                QQ.TransactionWebservice();
                QQ.getTransactionOptionsList();
                QQ.inc();
                QQ.dec();
                QQ.LoadWBs();
                QQ.callBranchWebservice();
                QQ.getBranchIdNames();
                QQ.getBranchSearchList();
                QuickQuoteMainController_AC.showbranches showbranchesRef = new QuickQuoteMainController_AC.showbranches();
                QQ.getshowSearchBranchIdTable();
                QQ.SearchDescAddress();
                QQ.SelectedBranchMethod();
                QQ.hidedispBranchPopUp();
                QQ.showdispBranchPopUp();
                QQ.saveQuickQuote();
                QQ.makeAddAvailable();
                QQ.checkMandatoryField();
                QQ.checkZipCodeValidation();
                QQ.getSpecificProductDetail();
                QQ.getRateOnDurationChange();
                QQ.disableSaveButton();
                QQ.changeIncludeLLW();
                QQ.SaveForLater();
                QQ.NoSale();
                QQ.RaiseSalesQuote();
                QQ.ConvertToRentalQuote();
                QQ.cancelFullQuote();
                QQ.onChangeFulfillingBranchId();
                
                Test.stopTest();
                }
        }
        
                
        static testMethod void test_QuickQuoteMainController2()
        {
            User u=MMITestDataProvider.getUser();
            System.runAs(u) {
            Test.startTest();
            Account acc=MMITestDataProvider.getAccount();
            insert acc;
            Lead newLead=MMITestDataProvider.getLead();
            insert newLead;
            Opportunity opp=MMITestDataProvider.getOpportunity();
            insert opp;
            Manage_Triggers__c manageTrigCustomSetting = new Manage_Triggers__c();
      manageTrigCustomSetting.Name = 'SendDeadLeadTo360IntegrationService';
      manageTrigCustomSetting.Active__c = true;
      insert manageTrigCustomSetting;
                        
                  //    System.assert( QuickQuoteMainDAO.getLeadRecord(newLead.Id)!=null);
                        
                System.currentPageReference().getParameters().put('recId',opp.Id);
                  System.currentPageReference().getParameters().put('selectedProd','2');
                 System.currentPageReference().getParameters().put('prodCode','20i');
                 System.currentPageReference().getParameters().put('selectedTex','1');
                  System.currentPageReference().getParameters().put('selectedAddr','1');
                   System.currentPageReference().getParameters().put('SelectedBranch','2');

                QuickQuoteMainController_AC QQ1 = new QuickQuoteMainController_AC();
                QQ1.QuickQuoteMainController_AC_initalize();
                QQ1.ShowProduct=false;
                QQ1.qqWrapper=MMITestDataProvider.getQQWrapper();
                QQ1.DescarteInnerClassList =MMITestDataProvider.getQQSaveDecarteWrapper();
                QQ1.addressInner=MMITestDataProvider.getQQAddressWrapper();
                QQ1.descarteInner=MMITestDataProvider.getQQDecarteWrapper();
                QQ1.productInner=MMITestDataProvider.getQQInnerProdWrapper();
                QQ1.showBranches=MMITestDataProvider.getQQShowBranchWrapper();
                QQ1.stateInner=MMITestDataProvider.getQQStateInnerWrapper();
                
                QQ1.getClientLoaded();
                QQ1.setClientLoaded();
                QQ1.hideError();
                QQ1.getproRef();
                QQ1.getOppRef();
                QQ1.getLeadRef();        
                QQ1.CalculateTotals();
                QQ1.getDispAddressPopUp();
                QQ1.getDispProductPopUp();
                QQ1.SelectedProduct();
                QQ1.CloseProductPopUp();        
                QQ1.AmendShipping();        
                QQ1.ViewBrnchSnapshot();
                QQ1.ProductSearch();        
                QQ1.Refresh();        
                QQ1.SaveAddress();        
                QQ1.CancelAddress();
                QQ1.ShowProductPopUp();
                QQ1.ProductsSelection();
                QQ1.getStateOptions();
                QQ1.getCountryOptions();
                QQ1.getInnerProductsList();
                QQ1.getInnerProductSearchList();
                QQ1.getShowProduct();
                QQ1.getAddressInnerClassList();
                QQ1.ValidateAddress();
                QQ1.SelectedAddressId();
                QQ1.CancelSelectedAddressId();
                QQ1.SelectFulfillingBranch();
                QQ1.getSelectFulfillingLoaded();
                QQ1.FulfillingBranchSelected();
                QQ1.CancelFulfillingBranchSelected();
                QQ1.getDescarteInnerClassList();
                QQ1.getDispDescProductPopUp();
                QQ1.CountriesList();
                QQ1.StatesList();
                QQ1.TransactionWebservice();
                QQ1.getTransactionOptionsList();
                QQ1.inc();
                QQ1.dec();
                QQ1.LoadWBs();
                QQ1.callBranchWebservice();
                QQ1.getBranchIdNames();
                QQ1.getBranchSearchList();
                QQ1.getshowSearchBranchIdTable();
                QQ1.SearchDescAddress();
                QQ1.SelectedBranchMethod();
                QQ1.hidedispBranchPopUp();
                QQ1.showdispBranchPopUp();
                QQ1.saveQuickQuote();
                QQ1.makeAddAvailable();
                QQ1.checkMandatoryField();
                QQ1.checkZipCodeValidation();
                QQ1.getSpecificProductDetail();
                QQ1.getRateOnDurationChange();
                QQ1.disableSaveButton();
                QQ1.changeIncludeLLW();
                QQ1.SaveForLater();
                QQ1.NoSale();
                QQ1.RaiseSalesQuote();
                QQ1.ConvertToRentalQuote();
                QQ1.cancelFullQuote();
                QQ1.onChangeFulfillingBranchId();
                

                Test.stopTest();
                }
        }
        
        
         static testMethod void test_QuickQuoteMainController3()
        {
            User u=MMITestDataProvider.getUser();
            System.runAs(u) {
            Test.startTest();
            Account acc=MMITestDataProvider.getAccount();
            insert acc;
            Lead newLead=MMITestDataProvider.getLead();
            insert newLead;
            Opportunity opp=MMITestDataProvider.getOpportunity();
            insert opp;
            Manage_Triggers__c manageTrigCustomSetting = new Manage_Triggers__c();
      manageTrigCustomSetting.Name = 'SendDeadLeadTo360IntegrationService';
      manageTrigCustomSetting.Active__c = true;
      insert manageTrigCustomSetting;
            
                  //    System.assert( QuickQuoteMainDAO.getLeadRecord(newLead.Id)!=null);
                System.currentPageReference().getParameters().put('recId',acc.Id);
                 System.currentPageReference().getParameters().put('selectedProd','2');
                 System.currentPageReference().getParameters().put('prodCode','20i');
                 System.currentPageReference().getParameters().put('selectedTex','1');
                  System.currentPageReference().getParameters().put('selectedAddr','1');
                   System.currentPageReference().getParameters().put('SelectedBranch','2');
    

                QuickQuoteMainController_AC QQ1 = new QuickQuoteMainController_AC();
                QQ1.QuickQuoteMainController_AC_initalize();
                 QQ1.ShowProduct=false;
                QQ1.qqWrapper=MMITestDataProvider.getQQWrapper();
                 QQ1.DescarteInnerClassList =MMITestDataProvider.getQQSaveDecarteWrapper();
                QQ1.addressInner=MMITestDataProvider.getQQAddressWrapper();
                QQ1.descarteInner=MMITestDataProvider.getQQDecarteWrapper();
                QQ1.productInner=MMITestDataProvider.getQQInnerProdWrapper();
                QQ1.showBranches=MMITestDataProvider.getQQShowBranchWrapper();
                QQ1.stateInner=MMITestDataProvider.getQQStateInnerWrapper();
                
                QQ1.getClientLoaded();
                QQ1.setClientLoaded();
                QQ1.hideError();
                QQ1.getproRef();
                QQ1.getOppRef(); 
                QQ1.getLeadRef();        
                QQ1.CalculateTotals();
                QQ1.getDispAddressPopUp();
                QQ1.getDispProductPopUp();
                QQ1.SelectedProduct();
                QQ1.CloseProductPopUp();        
                QQ1.AmendShipping();        
                QQ1.ViewBrnchSnapshot();
                QQ1.ProductSearch();        
                QQ1.Refresh();        
                QQ1.SaveAddress();        
                QQ1.CancelAddress();
                QQ1.ShowProductPopUp();
                QQ1.ProductsSelection();
                QQ1.getStateOptions();
                QQ1.getCountryOptions();
                QQ1.getInnerProductsList();
                QQ1.getInnerProductSearchList();
                QQ1.getShowProduct();
                QQ1.getAddressInnerClassList();
                QQ1.ValidateAddress();
                QQ1.SelectedAddressId();
                QQ1.CancelSelectedAddressId();
                QQ1.SelectFulfillingBranch();
                QQ1.getSelectFulfillingLoaded();
                QQ1.FulfillingBranchSelected();
                QQ1.CancelFulfillingBranchSelected();
                QQ1.getDescarteInnerClassList();
                QQ1.getDispDescProductPopUp();
                QQ1.CountriesList();
                QQ1.StatesList();
                QQ1.TransactionWebservice();
                QQ1.getTransactionOptionsList();
                QQ1.inc();
                QQ1.dec();
                QQ1.LoadWBs();
                QQ1.callBranchWebservice();
                QQ1.getBranchIdNames();
                QQ1.getBranchSearchList();
                QQ1.getshowSearchBranchIdTable();
                QQ1.SearchDescAddress();
                QQ1.SelectedBranchMethod();
                QQ1.hidedispBranchPopUp();
                QQ1.showdispBranchPopUp();
                QQ1.saveQuickQuote();
                QQ1.makeAddAvailable();
                QQ1.checkMandatoryField();
                QQ1.checkZipCodeValidation();
                QQ1.getSpecificProductDetail();
                QQ1.getRateOnDurationChange();
                QQ1.disableSaveButton();
                QQ1.changeIncludeLLW();
                QQ1.SaveForLater();
                QQ1.NoSale();
                QQ1.RaiseSalesQuote();
                QQ1.ConvertToRentalQuote();
                QQ1.cancelFullQuote();
                QQ1.onChangeFulfillingBranchId();
				
                Test.stopTest();
                }
        }
        
        testMethod static void test_SelectedProduct(){

        User u=MMITestDataProvider.getUser();
        System.runAs(u) {
        Test.startTest();
        Account acc=MMITestDataProvider.getAccount();
        insert acc;
        Lead newLead=MMITestDataProvider.getLead();
        insert newLead;
        Opportunity opp=MMITestDataProvider.getOpportunity();
        insert opp;
        Manage_Triggers__c manageTrigCustomSetting = new Manage_Triggers__c();
      manageTrigCustomSetting.Name = 'SendDeadLeadTo360IntegrationService';
      manageTrigCustomSetting.Active__c = true;
      insert manageTrigCustomSetting;
        
        //System.assert( QuickQuoteMainDAO.getLeadRecord(newLead.Id)!=null);
        System.currentPageReference().getParameters().put('recId',newLead.Id);
        System.currentPageReference().getParameters().put('selectedProd','2');  
          System.currentPageReference().getParameters().put('prodCode','20i');
          System.currentPageReference().getParameters().put('selectedTex','1');
          System.currentPageReference().getParameters().put('selectedAddr','1');
    
         QuickQuoteMainController_AC QQ1 = new QuickQuoteMainController_AC();
         QQ1.QuickQuoteMainController_AC_initalize();
        QuickQuoteMainController_AC.InnerProductClass innProd1=new QuickQuoteMainController_AC.InnerProductClass();
        innProd1=MMITestDataProvider.getQQControllerInnerProdWrapper();
        List<QuickQuoteMainController_AC.InnerProductClass> innProdLst1=new List<QuickQuoteMainController_AC.InnerProductClass>();
        innProdLst1.add(innProd1);
        QQ1.innerProductList= innProdLst1;
        QQ1.SelectedProduct();
        
        QuickQuoteMainController_AC QQ = new QuickQuoteMainController_AC();
        QQ.QuickQuoteMainController_AC_initalize();
        QuickQuoteMainController_AC.InnerProductClass innProd=new QuickQuoteMainController_AC.InnerProductClass();
        innProd=MMITestDataProvider.getQQControllerInnerProdWrapper();
        List<QuickQuoteMainController_AC.InnerProductClass> innProdLst=new List<QuickQuoteMainController_AC.InnerProductClass>();
        innProdLst.add(innProd);
        QQ.innerProductSearchList=innProdLst; 
        QQ.SelectedProduct();
        
        
         Test.stopTest();
        
        }
       
     }
     

     testMethod static void test_AmendShipping(){

        User u=MMITestDataProvider.getUser();
        System.runAs(u) {
        Test.startTest();
        Account acc=MMITestDataProvider.getAccountOnlyBillingAdd();
        insert acc;
        Lead newLead=MMITestDataProvider.getLeadWithDeliveryAdd();
        insert newLead;
        Opportunity opp=MMITestDataProvider.getOppoWithDeliveryAdd();
        insert opp; 
        Manage_Triggers__c manageTrigCustomSetting = new Manage_Triggers__c();
      manageTrigCustomSetting.Name = 'SendDeadLeadTo360IntegrationService';
      manageTrigCustomSetting.Active__c = true;
      insert manageTrigCustomSetting;
        
        //System.assert( QuickQuoteMainDAO.getLeadRecord(newLead.Id)!=null);
          System.currentPageReference().getParameters().put('recId',newLead.Id);
          System.currentPageReference().getParameters().put('selectedProd','2');  
          System.currentPageReference().getParameters().put('prodCode','20i');
          System.currentPageReference().getParameters().put('selectedTex','1');
          System.currentPageReference().getParameters().put('selectedAddr','1');

           QuickQuoteMainController_AC QQ = new QuickQuoteMainController_AC();
           QQ.QuickQuoteMainController_AC_initalize();
           QQ.AmendShipping();

           System.currentPageReference().getParameters().put('recId',opp.Id);
           QuickQuoteMainController_AC QQ1 = new QuickQuoteMainController_AC();
           QQ1.QuickQuoteMainController_AC_initalize();
           QQ1.AmendShipping();
           
           Opportunity opp1=MMITestDataProvider.getOppoWithOutDeliveryAddAccShippAdd();
            insert opp1; 
            System.currentPageReference().getParameters().put('recId',opp1.Id);
           QuickQuoteMainController_AC QQ2 = new QuickQuoteMainController_AC();
           QQ2.QuickQuoteMainController_AC_initalize();
           QQ2.AmendShipping();
         
         Test.stopTest();
        
        }
       
     }
      
      
       testMethod static void test_ProductSearch(){

        User u=MMITestDataProvider.getUser();
        System.runAs(u) {
        Test.startTest();
         Lead newLead=MMITestDataProvider.getLead();
         insert newLead;
         Manage_Triggers__c manageTrigCustomSetting = new Manage_Triggers__c();
      manageTrigCustomSetting.Name = 'SendDeadLeadTo360IntegrationService';
      manageTrigCustomSetting.Active__c = true;
      insert manageTrigCustomSetting;
          System.assert( QuickQuoteMainDAO.getLeadRecord(newLead.Id)!=null);
          System.currentPageReference().getParameters().put('recId',newLead.Id);
          System.currentPageReference().getParameters().put('selectedProd','2');  
          System.currentPageReference().getParameters().put('prodCode','20i');
          System.currentPageReference().getParameters().put('selectedTex','1');
          System.currentPageReference().getParameters().put('selectedAddr','1');
          
           QuickQuoteMainController_AC QQ = new QuickQuoteMainController_AC();
           QQ.QuickQuoteMainController_AC_initalize();
           QQ.qqWrapper=MMITestDataProvider.getQQWrapper();
          
           
           QQ.ProductSearch();
          
           
          
         Test.stopTest();
        
        }
       
     }
     
     testMethod static void test_SelectedAddressId(){

        User u=MMITestDataProvider.getUser();
        System.runAs(u) {
        Test.startTest(); 
         Lead newLead=MMITestDataProvider.getLead();
         insert newLead;
         Manage_Triggers__c manageTrigCustomSetting = new Manage_Triggers__c();
      manageTrigCustomSetting.Name = 'SendDeadLeadTo360IntegrationService';
      manageTrigCustomSetting.Active__c = true;
      insert manageTrigCustomSetting;
          System.assert( QuickQuoteMainDAO.getLeadRecord(newLead.Id)!=null);
          System.currentPageReference().getParameters().put('recId',newLead.Id);
          System.currentPageReference().getParameters().put('selectedProd','2');  
          System.currentPageReference().getParameters().put('prodCode','20i');
          System.currentPageReference().getParameters().put('selectedTex','2');
          System.currentPageReference().getParameters().put('selectedAddr','2');
          
           QuickQuoteMainController_AC QQ = new QuickQuoteMainController_AC();
           QQ.QuickQuoteMainController_AC_initalize();
           QQ.AddressInnerClassList=MMITestDataProvider.getQQControllerAddressWrapper();
           QQ.DescarteInnerClassList=MMITestDataProvider.getQQControllerDecarteWrapper();
           QQ.SelectedAddressId(); 
           
            QQ.qqWrapper=MMITestDataProvider.getQQWrapper();
            QQ.checkZipCodeValidation();
            QQ.SelectFulfillingBranch();
          
         Test.stopTest();
        
        }
       
     }
     
    static testMethod void test_MethodsSprint5()
        {
            User u=MMITestDataProvider.getUser();
            System.runAs(u) {
	            Test.startTest();
	            
	            Lead newLead=MMITestDataProvider.getLead();
	            insert newLead;
	            
	            Account accNew = MMIFullquoteTestDataProvider.getAccount();
	        accNew.Result_Id__c = '12557879';
	    	insert accNew;
	    	
	    	Account accNewBussiness = MMIFullquoteTestDataProvider.getBusinessAccount();
	        //accNewBussiness.Result_Id__c = '12557879';
	    	insert accNewBussiness;
	    	
	    	Opportunity opp = MMIFullquoteTestDataProvider.getOpportunity();
	    	opp.AccountId = accNew.Id;
	    	insert opp;
	    	
	    	Opportunity opp1 = MMIFullquoteTestDataProvider.getOpportunity();
	    	opp1.AccountId = accNewBussiness.Id;
	    	insert opp1;
	    	
	    	Account acc = MMIFullquoteTestDataProvider.getBusinessAccount();
	    	acc.BillingCountry = 'USA';
            insert acc;
            
            Opportunity opp2=MMIFullquoteTestDataProvider.getOpportunity();
            opp2.AccountId = acc.id; 
            insert opp2;
		    
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
		    
		    	QuickQuoteWrapper qw = new QuickQuoteWrapper();
	            qw.oppContactName = 'erwerw';
	            qw.oppContactPhone = '123423452';
	            qw.oppContactLastName = 'erwerw';
	            qw.ZipCode = '85226';
	            
	            System.currentPageReference().getParameters().put('recId',newLead.Id);
	            QuickQuoteMainController_AC QQ = new QuickQuoteMainController_AC();
	           	QQ.QuickQuoteMainController_AC_initalize();
	           	
	           	QQ.qqWrapper = new QuickQuoteWrapper();
	           	QQ.qqWrapper = qw;
	           	QQ.CapacityIdSelected();
	           	//QQ.ZipCodeFinder();
	           	QQ.DisableKnowDelZoneBtn();
				QQ.NoDelZoneRates();
				
				System.currentPageReference().getParameters().put('recId',opp2.Id);
				QuickQuoteMainController_AC QQ1 = new QuickQuoteMainController_AC();
	           	//QQ1.QuickQuoteMainController_AC_initalize();
	           	QQ1.qqWrapper = new QuickQuoteWrapper();
	           	QQ1.qqWrapper = qw;
                //QQ1.CapacityIdSelected();
	           	//QQ1.ZipCodeFinder();
	           	QQ1.DisableKnowDelZoneBtn();
				QQ1.NoDelZoneRates();
				
				System.currentPageReference().getParameters().put('recId',acc.Id);
				QuickQuoteMainController_AC QQ2 = new QuickQuoteMainController_AC();
	           //	QQ2.QuickQuoteMainController_AC_initalize();
	           	QQ2.qqWrapper = new QuickQuoteWrapper();
	           	QQ2.qqWrapper = qw;
	           //	QQ2.CapacityIdSelected();
	           //	QQ2.ZipCodeFinder();
	           	QQ2.DisableKnowDelZoneBtn();
				QQ2.NoDelZoneRates();
				
				System.currentPageReference().getParameters().put('recId',jp.Id);
				System.currentPageReference().getParameters().put('scId',sc.Id);
				System.currentPageReference().getParameters().put('conId',con.Id);
				System.currentPageReference().getParameters().put('accId',acc.Id);
				System.currentPageReference().getParameters().put('source','jp');
				
				QuickQuoteMainController_AC QQ3 = new QuickQuoteMainController_AC();
               
	           	QQ3.qqWrapper = new QuickQuoteWrapper();
	           	QQ3.qqWrapper = qw;
	           	//QQ3.CapacityIdSelected();
	           	//QQ3.ZipCodeFinder();
	           	QQ3.DisableKnowDelZoneBtn();
				QQ3.NoDelZoneRates();
				//QQ3.displayCOntactDetail(con.Id);
				
				Test.stopTest();
            
        	}
        }
}