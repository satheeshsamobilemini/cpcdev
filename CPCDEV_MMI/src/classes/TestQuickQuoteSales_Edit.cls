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
private class TestQuickQuoteSales_Edit {

    static testMethod void test_QuickQuoteSales_Edit(){
		User u=MMITestDataProvider.getUser();
		System.runAs(u) {
		    Test.startTest();
            Account acc=MMITestDataProvider.getAccount();
            insert acc;
		    Lead newLead=MMITestDataProvider.getLead();
		    insert newLead;
            Opportunity opp=MMITestDataProvider.getOpportunity();
            insert opp;
            MMI_Quotes__c mmiQQ=MMITestDataProvider.getQuickQuote();
            insert mmiQQ;
            HB_Sales_Inventory__c salesInv=MMITestDataProvider.getHBSalesInventory();
            insert salesInv;
            
			System.currentPageReference().getParameters().put('recId',newLead.Id);
            System.currentPageReference().getParameters().put('selectedProd','1');
            System.currentPageReference().getParameters().put('prodCode','20i');
            System.currentPageReference().getParameters().put('selectedTex','1');
            System.currentPageReference().getParameters().put('selectedAddr','1');
            System.currentPageReference().getParameters().put('Id',mmiQQ.Id);
            System.currentPageReference().getParameters().put('fBranchCode','1');
                  
           	QuickQuoteSales_Edit.shippingAddress shippingAdd3 = new QuickQuoteSales_Edit.shippingAddress();
           	QuickQuoteSales_Edit.quickQuote qQuote2 = new QuickQuoteSales_Edit.quickQuote();
           	
           	ApexPages.StandardController sc = new ApexPages.StandardController(mmiQQ);
	         
	        QuickQuoteSales_Edit QQ = new QuickQuoteSales_Edit(sc);
			QQ.QuickQuoteSales_Edit_initalize();
	        QQ.salesInventories=MMITestDataProvider.getSalesProductSales();
            QQ.DescarteInnerClassList =MMITestDataProvider.getSalesQQDecarteWrapper();
			QQ.ShowProduct=true; 
            QQ.qqWrapper=MMITestDataProvider.getQQWrapper();
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
	       // QQ.getSalesFleets('40ZS');
	     //   QQ.getNetValue();
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
	        QQ.CheckCapacity();
	        QQ.ProductSearch();        
	        QQ.Refresh();        
	        QQ.SaveForLater();
	        QQ.NoSale();       
	        QQ.RaiseSalesQuote();
	        QQ.ConvertToRentalQuote();
	        QQ.SaveAddress();        
	        QQ.CancelAddress();
	        QuickQuoteSales_Edit.InnerProductClass InnerProductClassRef = new QuickQuoteSales_Edit.InnerProductClass();
	        QQ.ShowProductPopUp();
	        QQ.ProductsSelection();
	        QQ.getStateOptions();
	        QQ.getCountryOptions();
	        QQ.getInnerProductsList();
	        QQ.getInnerProductSearchList();
	        QQ.SearchProduct();
	        QQ.getShowProduct();
	        QuickQuoteSales_Edit.AddressInnerClass AddressInnerClassRef = new QuickQuoteSales_Edit.AddressInnerClass();
	  		QQ.getAddressInnerClassList();
	  	   	
	  		QQ.ValidateAddress();
	  		QQ.SelectedAddressId();
	  		QQ.CancelSelectedAddressId();
	  		QQ.SelectFulfillingBranch();
	  		QQ.getSelectFulfillingLoaded();
	  		QQ.FulfillingBranchSelected();
	  		QQ.CancelFulfillingBranchSelected();
	  		QQ.getDescarteInnerClassList();
	  		QuickQuoteSales_Edit.DescarteInnerClass DescarteInnerClassRef = new QuickQuoteSales_Edit.DescarteInnerClass();
	  		QQ.getDispDescProductPopUp();
	  		QQ.CountriesList();
	  		QQ.StatesList();
	  		QuickQuoteSales_Edit.stateInnerClass stateInnerClassRef = new QuickQuoteSales_Edit.stateInnerClass();
	  		QQ.TransactionWebservice();
	  		QQ.getTransactionOptionsList();
	  		QQ.inc();
	  		QQ.dec();
	  		QQ.RefreshQuickQuote();
	  	  	
	  		QQ.LoadWBs();
	  		QQ.callBranchWebservice();
	  		QQ.getBranchIdNames();
	  		QQ.getBranchSearchList();
	  		QuickQuoteSales_Edit.showbranches showbranchesRef = new QuickQuoteSales_Edit.showbranches();
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
            QQ.getSpecificBranchIDMethod();
            
		}
	}
	
	static testMethod void test_QuickQuoteSales_Edit2(){
		User u=MMITestDataProvider.getUser();
		System.runAs(u) {
		    Test.startTest();
            Account acc=MMITestDataProvider.getAccount();
            insert acc;
		    Lead newLead=MMITestDataProvider.getLead();
		    insert newLead;
            Opportunity opp=MMITestDataProvider.getOpportunity();
            insert opp;
            MMI_Quotes__c mmiQQ=MMITestDataProvider.getQuickQuote();
            insert mmiQQ;
            HB_Sales_Inventory__c salesInv=MMITestDataProvider.getHBSalesInventory();
            insert salesInv;
            
            System.currentPageReference().getParameters().put('recId',opp.Id);
            System.currentPageReference().getParameters().put('selectedProd','1');
            System.currentPageReference().getParameters().put('prodCode','20i');
            System.currentPageReference().getParameters().put('selectedTex','1');
            System.currentPageReference().getParameters().put('selectedAddr','1');
            System.currentPageReference().getParameters().put('Id',mmiQQ.Id);
            System.currentPageReference().getParameters().put('fBranchCode','1');
                  
           ApexPages.StandardController sc = new ApexPages.StandardController(mmiQQ);
	        QuickQuoteSales_Edit QQ1 = new QuickQuoteSales_Edit(sc);
	        QQ1.QuickQuoteSales_Edit_initalize();
            
            QQ1.DescarteInnerClassList =MMITestDataProvider.getSalesQQDecarteWrapper();
            QQ1.ShowProduct=true;
            QQ1.qqWrapper=MMITestDataProvider.getQQWrapper();
            QQ1.addressInner=MMITestDataProvider.getQQAddressWrapper();
            QQ1.descarteInner=MMITestDataProvider.getQQDecarteWrapper();
            QQ1.productInner=MMITestDataProvider.getQQInnerProdWrapper();
            QQ1.showBranches=MMITestDataProvider.getQQShowBranchWrapper();
            QQ1.stateInner=MMITestDataProvider.getQQStateInnerWrapper();
            QQ1.proRef=MMITestDataProvider.getQuickQuote();
            QQ1.address1='123 abc';
            QQ1.address2='123 abc';
            QQ1.address3='123 abc';
            QQ1.address4='123 abc';
            QQ1.state2='AZ';
            QQ1.zipCode2='85282';
            QQ1.countryId2='USA';
            QQ1.BranchId='113';
            QQ1.salesRepErr=true;
	        
	        QQ1.getClientLoaded();
	      //  QQ1.getNetValue();
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
	        QQ1.CheckCapacity();
	        QQ1.ProductSearch();        
	        QQ1.Refresh();        
	        QQ1.SaveForLater();
	        QQ1.NoSale();       
	        QQ1.RaiseSalesQuote();
	        QQ1.ConvertToRentalQuote();
	        QQ1.SaveAddress();        
	        QQ1.CancelAddress();
	        QuickQuoteSales_Edit.InnerProductClass InnerProductClassRef1 = new QuickQuoteSales_Edit.InnerProductClass();
	        QQ1.ShowProductPopUp();
	        QQ1.ProductsSelection();
	        QQ1.getStateOptions();
	        QQ1.getCountryOptions();
	        QQ1.getInnerProductsList();
	        QQ1.getInnerProductSearchList();
	        QQ1.SearchProduct();
	        QQ1.getShowProduct();
	        QuickQuoteSales_Edit.AddressInnerClass AddressInnerClassRef1 = new QuickQuoteSales_Edit.AddressInnerClass();
	  		QQ1.getAddressInnerClassList();
	  	   	
	  		QQ1.ValidateAddress();
	  		QQ1.SelectedAddressId();
	  		QQ1.CancelSelectedAddressId();
	  		QQ1.SelectFulfillingBranch();
	  		QQ1.getSelectFulfillingLoaded();
	  		QQ1.FulfillingBranchSelected();
	  		QQ1.CancelFulfillingBranchSelected();
	  		QQ1.getDescarteInnerClassList();
	  		QuickQuoteSales_Edit.DescarteInnerClass DescarteInnerClassRef1 = new QuickQuoteSales_Edit.DescarteInnerClass();
	  		QQ1.getDispDescProductPopUp();
	  		QQ1.CountriesList();
	  		QQ1.StatesList();
	  		QuickQuoteSales_Edit.stateInnerClass stateInnerClassRef1 = new QuickQuoteSales_Edit.stateInnerClass();
	  		QQ1.TransactionWebservice();
	  		QQ1.getTransactionOptionsList();
	  		QQ1.inc();
	  		QQ1.dec();
	  		QQ1.RefreshQuickQuote();
	  	  	
	  		QQ1.LoadWBs();
	  		QQ1.callBranchWebservice();
	  		QQ1.getBranchIdNames();
	  		QQ1.getBranchSearchList();
	  		QuickQuoteSales_Edit.showbranches showbranchesRef1 = new QuickQuoteSales_Edit.showbranches();
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
            QQ1.getSpecificBranchIDMethod();
            
	        QuickQuoteWrapper qw = new QuickQuoteWrapper();
            qw.oppContactName = 'erwerw';
            qw.oppContactPhone = '123423452';
            qw.oppContactLastName = 'erwerw';
            qw.ZipCode = '85226';
            QQ1.qqWrapper = new QuickQuoteWrapper();
	        QQ1.qqWrapper = qw;
	            
	        QQ1.ZipCodeFinder();
	        QQ1.DisableKnowDelZoneBtn();
	        QQ1.NoDelZoneRates();
            
	        Test.stopTest();
		}
	}
	
	static testMethod void test_QuickQuoteSales_Edit3(){
		User u=MMITestDataProvider.getUser();
		System.runAs(u) {
		    Test.startTest();
            Account acc=MMITestDataProvider.getAccount();
            insert acc;
		    Lead newLead=MMITestDataProvider.getLead();
		    insert newLead;
            Opportunity opp=MMITestDataProvider.getOpportunity();
            insert opp;
            MMI_Quotes__c mmiQQ=MMITestDataProvider.getQuickQuote();
            insert mmiQQ;
            HB_Sales_Inventory__c salesInv=MMITestDataProvider.getHBSalesInventory();
            insert salesInv;
            
            System.currentPageReference().getParameters().put('recId',mmiQQ.Id);
            System.currentPageReference().getParameters().put('selectedProd','2');
            System.currentPageReference().getParameters().put('prodCode','20i');
            System.currentPageReference().getParameters().put('selectedTex','1');
            System.currentPageReference().getParameters().put('selectedAddr','1');
             System.currentPageReference().getParameters().put('Id',mmiQQ.Id);
             System.currentPageReference().getParameters().put('fBranchCode','1');
                  
           ApexPages.StandardController sc = new ApexPages.StandardController(mmiQQ);
	        QuickQuoteSales_Edit QQ11 = new QuickQuoteSales_Edit(sc);
			QQ11.QuickQuoteSales_Edit_initalize();
			QQ11.DescarteInnerClassList =MMITestDataProvider.getSalesQQDecarteWrapper();
			QQ11.ShowProduct=true;
            QQ11.qqWrapper=MMITestDataProvider.getQQWrapper();
            QQ11.addressInner=MMITestDataProvider.getQQAddressWrapper();
            QQ11.descarteInner=MMITestDataProvider.getQQDecarteWrapper();
            QQ11.productInner=MMITestDataProvider.getQQInnerProdWrapper();
            QQ11.showBranches=MMITestDataProvider.getQQShowBranchWrapper();
            QQ11.stateInner=MMITestDataProvider.getQQStateInnerWrapper();
            //MMI_Quotes__c mq=new MMI_Quotes__c();
			//QQ11.proRef=mq;
            QQ11.address1='123 abc';
            QQ11.address2='123 abc';
            QQ11.address3='123 abc';
            QQ11.address4='123 abc';
            QQ11.state2='AZ';
            QQ11.zipCode2='85282';
            QQ11.countryId2='USA';
            QQ11.BranchId='113';
            QQ11.salesRepErr=true;
        
	        QQ11.getClientLoaded();
	      //  QQ11.getNetValue();
	        QQ11.setClientLoaded();
	        QQ11.hideError();
	        QQ11.getproRef();
	        QQ11.getOppRef();
	        QQ11.getLeadRef();        
	        QQ11.CalculateTotals();
	        QQ11.getDispAddressPopUp();
	        QQ11.getDispProductPopUp();
	        QQ11.SelectedProduct();
	        QQ11.CloseProductPopUp();        
	        QQ11.AmendShipping();        
	        QQ11.ViewBrnchSnapshot();
	        QQ11.CheckCapacity();
	        QQ11.ProductSearch();        
	        QQ11.Refresh();        
	        QQ11.SaveForLater();
	        QQ11.NoSale();       
	        QQ11.RaiseSalesQuote();
	        QQ11.ConvertToRentalQuote();
	        QQ11.SaveAddress();        
	        QQ11.CancelAddress();
	        QuickQuoteSales_Edit.InnerProductClass InnerProductClassRef11 = new QuickQuoteSales_Edit.InnerProductClass();
	        QQ11.ShowProductPopUp();
	        QQ11.ProductsSelection();
	        QQ11.getStateOptions();
	        QQ11.getCountryOptions();
	        QQ11.getInnerProductsList();
	        QQ11.getInnerProductSearchList();
	        QQ11.SearchProduct();
	        QQ11.getShowProduct();
	        QuickQuoteSales_Edit.AddressInnerClass AddressInnerClassRef11 = new QuickQuoteSales_Edit.AddressInnerClass();
	  		QQ11.getAddressInnerClassList();
	  	   	
	  		QQ11.ValidateAddress();
	  		QQ11.SelectedAddressId();
	  		QQ11.CancelSelectedAddressId();
	  		QQ11.SelectFulfillingBranch();
	  		QQ11.getSelectFulfillingLoaded();
	  		QQ11.FulfillingBranchSelected();
	  		QQ11.CancelFulfillingBranchSelected();
	  		QQ11.getDescarteInnerClassList();
	  		QuickQuoteSales_Edit.DescarteInnerClass DescarteInnerClassRef11 = new QuickQuoteSales_Edit.DescarteInnerClass();
	  		QQ11.getDispDescProductPopUp();
	  		QQ11.CountriesList();
	  		QQ11.StatesList();
	  		QuickQuoteSales_Edit.stateInnerClass stateInnerClassRef11 = new QuickQuoteSales_Edit.stateInnerClass();
	  		QQ11.TransactionWebservice();
	  		QQ11.getTransactionOptionsList();
	  		QQ11.inc();
	  		QQ11.dec();
	  		QQ11.RefreshQuickQuote();
	  	  	
	  		QQ11.callBranchWebservice();
	  		QQ11.getBranchIdNames();
	  		QQ11.getBranchSearchList();
	  		QuickQuoteSales_Edit.showbranches showbranchesRef11 = new QuickQuoteSales_Edit.showbranches();
	  		QQ11.getshowSearchBranchIdTable();
	  		QQ11.SearchDescAddress();
	  		QQ11.SelectedBranchMethod();
	  		QQ11.hidedispBranchPopUp();
	  		QQ11.showdispBranchPopUp();
	  		
	  		QQ11.makeAddAvailable();
	  		QQ11.checkMandatoryField();
	  		QQ11.checkZipCodeValidation();
	  		QQ11.getSpecificProductDetail();
            QQ11.getRateOnDurationChange();
            QQ11.disableSaveButton();
            QQ11.changeIncludeLLW();
            QQ11.SaveForLater();
            QQ11.NoSale();
            QQ11.RaiseSalesQuote();
            QQ11.ConvertToRentalQuote();
            QQ11.getSpecificBranchIDMethod();
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
		         MMI_Quotes__c mmiQQ=MMITestDataProvider.getQuickQuote();
                insert mmiQQ;
                HB_Sales_Inventory__c salesInv=MMITestDataProvider.getHBSalesInventory();
            insert salesInv;
				System.currentPageReference().getParameters().put('recId',newLead.Id);
		        System.currentPageReference().getParameters().put('selectedProd','2');  
				System.currentPageReference().getParameters().put('prodCode','20i');
		        System.currentPageReference().getParameters().put('selectedTex','1');
		        System.currentPageReference().getParameters().put('selectedAddr','1');
		        
		        ApexPages.StandardController sc = new ApexPages.StandardController(mmiQQ);
		        QuickQuoteSales_Edit QQ1 = new QuickQuoteSales_Edit(sc);
		        QQ1.QuickQuoteSales_Edit_initalize();
		        QuickQuoteSales_Edit.InnerProductClass innProd1=new QuickQuoteSales_Edit.InnerProductClass();
		        List<QuickQuoteSales_Edit.InnerProductClass> innProdLst1=new List<QuickQuoteSales_Edit.InnerProductClass>();
		        innProdLst1.add(innProd1);
		        QQ1.innerProductList= innProdLst1; 
		        QQ1.SelectedProduct();
		        QuickQuoteSales_Edit QQ = new QuickQuoteSales_Edit(sc);
		        QQ.QuickQuoteSales_Edit_initalize();
		        QuickQuoteSales_Edit.InnerProductClass innProd=new QuickQuoteSales_Edit.InnerProductClass();
		        List<QuickQuoteSales_Edit.InnerProductClass> innProdLst=new List<QuickQuoteSales_Edit.InnerProductClass>();
		        innProdLst.add(innProd);
		        QQ.innerProductSearchList=innProdLst;
		        QQ.SelectedProduct();
		        QQ.LoadWBs();
		        QQ.saveQuickQuote();
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
		        MMI_Quotes__c mmiQQ=MMITestDataProvider.getQuickQuote();
                insert mmiQQ;
                HB_Sales_Inventory__c salesInv=MMITestDataProvider.getHBSalesInventory();
            insert salesInv;
		        
		        Weekly_Snapshot_Branch_Report__c weksn= new Weekly_Snapshot_Branch_Report__c();
		        weksn.Market_Value_Range_20S__c = '2600 C, 2900 B, dbl dr A 6200';
		        weksn.Market_Value_Range_20ZS__c = '3500-4800';
		        weksn.Market_Value_Range_40S__c = '2900-3250. Dbl Dr tunnel 7200';
		        weksn.Market_Value_Range_40ZS__c = '4200-6000';
		        weksn.Street__c = '7121 Statesville Rd.';
		        weksn.City__c = 'Charlotte';
		        weksn.State__c = 'NC';
		        weksn.Zipcode__c = '28269';
		        weksn.County__c = 'Mecklenburg';
		        weksn.Country__c = 'USA';
		        weksn.Servicing_Branch__c = '102 - Tucson';
		        insert weksn; 
		        
				System.currentPageReference().getParameters().put('recId',newLead.Id);
	          	System.currentPageReference().getParameters().put('selectedProd','2');  
	          	System.currentPageReference().getParameters().put('prodCode','20i');
	          	System.currentPageReference().getParameters().put('selectedTex','1');
	          	System.currentPageReference().getParameters().put('selectedAddr','1');
	          	
	          	ApexPages.StandardController sc = new ApexPages.StandardController(mmiQQ);
				QuickQuoteSales_Edit QQ = new QuickQuoteSales_Edit(sc);
				QQ.QuickQuoteSales_Edit_initalize();
	           	QQ.AmendShipping();
	
	           	System.currentPageReference().getParameters().put('recId',opp.Id);
	           	QuickQuoteSales_Edit QQ1 = new QuickQuoteSales_Edit(sc);
	           	QQ1.QuickQuoteSales_Edit_initalize();
	           	QQ1.AmendShipping();
				
				Opportunity opp1=MMITestDataProvider.getOppoWithOutDeliveryAddAccShippAdd();
            	insert opp1; 
            	System.currentPageReference().getParameters().put('recId',opp1.Id);
	           	QuickQuoteSales_Edit QQ2 = new QuickQuoteSales_Edit(sc); 
	           	QQ2.QuickQuoteSales_Edit_initalize();
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
         		MMI_Quotes__c mmiQQ=MMITestDataProvider.getQuickQuote();
                insert mmiQQ;
                HB_Sales_Inventory__c salesInv=MMITestDataProvider.getHBSalesInventory();
            insert salesInv;
	          	System.assert( QuickQuoteMainDAO.getLeadRecord(newLead.Id)!=null);
	          	System.currentPageReference().getParameters().put('recId',newLead.Id);
	          	System.currentPageReference().getParameters().put('selectedProd','2');  
	          	System.currentPageReference().getParameters().put('prodCode','20i');
	          	System.currentPageReference().getParameters().put('selectedTex','1');
	          	System.currentPageReference().getParameters().put('selectedAddr','1');
	          	ApexPages.StandardController sc = new ApexPages.StandardController(mmiQQ);
	          	
				QuickQuoteSales_Edit QQ = new QuickQuoteSales_Edit(sc);
				QQ.QuickQuoteSales_Edit_initalize();
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
		         MMI_Quotes__c mmiQQ=MMITestDataProvider.getQuickQuote();
                insert mmiQQ;
		         System.assert( QuickQuoteMainDAO.getLeadRecord(newLead.Id)!=null);
		         System.currentPageReference().getParameters().put('recId',newLead.Id);
		         System.currentPageReference().getParameters().put('selectedProd','2');  
		         System.currentPageReference().getParameters().put('prodCode','20i');
		         System.currentPageReference().getParameters().put('selectedTex','2');
		         System.currentPageReference().getParameters().put('selectedAddr','2');
		         ApexPages.StandardController sc = new ApexPages.StandardController(mmiQQ);
		         QuickQuoteSales_Edit QQ = new QuickQuoteSales_Edit(sc);
		         QQ.QuickQuoteSales_Edit_initalize();
		         QQ.SelectedAddressId();
		         QQ.qqWrapper=MMITestDataProvider.getQQWrapper();
		         QQ.checkZipCodeValidation();
		         QQ.SelectFulfillingBranch();
	         Test.stopTest();
		}
	}
}