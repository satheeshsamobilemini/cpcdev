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
private class TestQuickQuoteSalesController {

    static testMethod void test_QuickQuoteMainController(){
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
		           
		            MMI_Quotes__c mmqu = new MMI_Quotes__c();
		            mmqu.Close_Date__c=system.today();
		            mmqu.Date_From__c = system.today();
		            mmqu.Opportunity__c = opp.id;
		            insert mmqu;
		             
		            System.currentPageReference().getParameters().put('recId',newLead.Id);
            System.currentPageReference().getParameters().put('selectedProd','1');
			        System.currentPageReference().getParameters().put('prodCode','20i');
			        System.currentPageReference().getParameters().put('selectedTex','1');
			        System.currentPageReference().getParameters().put('selectedAddr','1');
            System.currentPageReference().getParameters().put('fBranchCode','1');
			        
		            QuickQuoteSalesController QQ = new QuickQuoteSalesController();
					QQ.QuickQuoteSalesController_initalize();
                    QQ.qqType = 'Sales';
                    QQ.source = 'jp';
	                QQ.onTypeChangePageRedi();
                    QQ.qqType = 'Sales';
                    QQ.ContId = 'TEST';
	                QQ.onTypeChangePageRedi();
                   
                    QQ.qqType = 'Rental';
                    QQ.source = 'jp';
                    QQ.onTypeChangePageRedi();
                    QQ.qqType = 'Rental';
	                QQ.ContId = 'TEST';
	                QQ.onTypeChangePageRedi();
                
	                /*QQ.addressInner=MMITestDataProvider.getQQAddressWrapper();
	                QQ.descarteInner=MMITestDataProvider.getQQDecarteWrapper();
	                QQ.productInner=MMITestDataProvider.getQQInnerProdWrapper();
	                QQ.showBranches=MMITestDataProvider.getQQShowBranchWrapper();
	                QQ.stateInner=MMITestDataProvider.getQQStateInnerWrapper();
	                
	                */
	                QQ.mmiQuote=MMITestDataProvider.getQuickQuote(); 
	                  QQ.salesInventories=MMITestDataProvider.getSalesProductSales();
                     QQ.DescarteInnerClassList =MMITestDataProvider.getSalesQQSaveDecarteWrapper();
                     QQ.qqWrapper=MMITestDataProvider.getQQWrapper();
                
		            //    System.assert( QuickQuoteMainDAO.getLeadRecord(newLead.Id)!=null);
		             QQ.qqWrapper.sellingPrice='100';
			            QQ.hideError();
			            QQ.getOppRef();
			            QQ.getmmiQuote();
			            QQ.getLeadRef();        
			            QQ.getDispAddressPopUp();
			            QQ.getDispProductPopUp();
			            QQ.SelectedProduct();
			            QQ.CloseProductPopUp();        
			            QQ.AmendShipping();        
			            QQ.ProductSearch();        
			            QQ.Refresh();        
			            QQ.SaveAddress();        
			            QQ.ProductsSelection();
			            QQ.ValidateAddress();
			            QQ.SelectedAddressId();
			            QQ.CancelSelectedAddressId();
			            QQ.SelectFulfillingBranch();
			            QQ.getSelectFulfillingLoaded();
			            QQ.FulfillingBranchSelected();
			            QQ.CancelFulfillingBranchSelected();
			            QQ.CountriesList();
			            QQ.StatesList();
			            QQ.TransactionWebservice();
			            QQ.LoadWBs();
			            QQ.callBranchWebservice();
			            QQ.SearchDescAddress();
			            QQ.SelectedBranchMethod();
			            QQ.hidedispBranchPopUp();
			            QQ.showdispBranchPopUp();
			            QQ.makeAddAvailable();
			            QQ.checkMandatoryField();
			            QQ.checkZipCodeValidation();
			            QQ.getSpecificProductDetail();
			            QQ.disableSaveButton();
			            QQ.changeIncludeLLW();
		
                      
                   
                       QQ.getSpecificBranchIDMethod();
	
			            QQ.saveQuickQuoteSales();
			           // QQ.getNetValue();
			            QQ.viewBranchPage();
			            QuickQuoteWrapper.SalesFleetWapper salesFleet=new QuickQuoteWrapper.SalesFleetWapper();
			            ValidateAddressService_AC vali = new ValidateAddressService_AC();
			            
			            QuickQuoteWrapper.InnerProductClass innProd1=new QuickQuoteWrapper.InnerProductClass();
				        innProd1=MMITestDataProvider.getQQControllerInnerProdWrapper1();
				        List<QuickQuoteWrapper.InnerProductClass> innProdLst1=new List<QuickQuoteWrapper.InnerProductClass>();
				        innProdLst1.add(innProd1);
				        QQ.innerProductSearchList= innProdLst1;
                
				Test.stopTest();
			}
		}
		
		static testMethod void test_QuickQuoteMainController2(){
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
		            System.currentPageReference().getParameters().put('selectedProd','2');
		            System.currentPageReference().getParameters().put('prodCode','20i');
		            System.currentPageReference().getParameters().put('selectedTex','1');
		            System.currentPageReference().getParameters().put('selectedAddr','1');
					QuickQuoteSalesController QQ1 = new QuickQuoteSalesController();
					QQ1.QuickQuoteSalesController_initalize();
			            QQ1.qqWrapper=MMITestDataProvider.getQQWrapper();
			            QQ1.hideError();
			            QQ1.getOppRef();
			            QQ1.getmmiQuote();
			            QQ1.getLeadRef();        
			            QQ1.getDispAddressPopUp();
			            QQ1.getDispProductPopUp();
			            QQ1.SelectedProduct();
			            QQ1.CloseProductPopUp();        
			            QQ1.AmendShipping();        
			            QQ1.ProductSearch();        
			            QQ1.Refresh();        
			            QQ1.SaveAddress();        
			            QQ1.ProductsSelection();
			            QQ1.ValidateAddress();
			            QQ1.SelectedAddressId();
			            QQ1.CancelSelectedAddressId();
			            QQ1.SelectFulfillingBranch();
			            QQ1.getSelectFulfillingLoaded();
			            QQ1.FulfillingBranchSelected();
			            QQ1.CancelFulfillingBranchSelected();
			            QQ1.CountriesList();
			            QQ1.StatesList();
			            QQ1.TransactionWebservice();
			            QQ1.LoadWBs();
			            QQ1.callBranchWebservice();
			            QQ1.SearchDescAddress();
			            QQ1.SelectedBranchMethod();
			            QQ1.hidedispBranchPopUp();
			            QQ1.showdispBranchPopUp();
			            QQ1.makeAddAvailable();
			            QQ1.checkMandatoryField();
			            QQ1.checkZipCodeValidation();
			             QQ1.getSpecificProductDetail();
			            QQ1.disableSaveButton();
			            QQ1.changeIncludeLLW();
			           
                     
                    
                       QQ1.getSpecificBranchIDMethod();
	
			            QQ1.saveQuickQuoteSales();
			            QuickQuoteWrapper.SalesFleetWapper salesFleet=new QuickQuoteWrapper.SalesFleetWapper();
			            ValidateAddressService_AC vali = new ValidateAddressService_AC();
			            
			            QuickQuoteWrapper.InnerProductClass innProd1=new QuickQuoteWrapper.InnerProductClass();
				        innProd1=MMITestDataProvider.getQQControllerInnerProdWrapper1();
				        List<QuickQuoteWrapper.InnerProductClass> innProdLst1=new List<QuickQuoteWrapper.InnerProductClass>();
				        innProdLst1.add(innProd1);
				        QQ1.innerProductSearchList= innProdLst1;
                
				Test.stopTest();
			}
		}
		
		static testMethod void test_QuickQuoteMainController3(){
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
		  
					System.currentPageReference().getParameters().put('recId',acc.Id);
					System.currentPageReference().getParameters().put('selectedProd','2');  
					System.currentPageReference().getParameters().put('prodCode','20i');
					System.currentPageReference().getParameters().put('selectedTex','1');
					System.currentPageReference().getParameters().put('selectedAddr','1');
					QuickQuoteSalesController QQ1 = new QuickQuoteSalesController();
					QQ1.QuickQuoteSalesController_initalize();
			            QQ1.qqWrapper=MMITestDataProvider.getQQWrapper();
			            QQ1.hideError();
			            QQ1.getOppRef();
			            QQ1.getmmiQuote();
			            QQ1.getLeadRef();        
			            QQ1.getDispAddressPopUp();
			            QQ1.getDispProductPopUp();
			            QQ1.SelectedProduct();
			            QQ1.CloseProductPopUp();        
			            QQ1.AmendShipping();        
			            QQ1.ProductSearch();        
			            QQ1.Refresh();        
			            QQ1.SaveAddress();        
			            QQ1.ProductsSelection();
			            QQ1.ValidateAddress();
			            QQ1.SelectedAddressId();
			            QQ1.CancelSelectedAddressId();
			            QQ1.SelectFulfillingBranch();
			            QQ1.getSelectFulfillingLoaded();
			            QQ1.FulfillingBranchSelected();
			            QQ1.CancelFulfillingBranchSelected();
			            QQ1.CountriesList();
			            QQ1.StatesList();
			            QQ1.TransactionWebservice();
			            QQ1.LoadWBs();
			            QQ1.callBranchWebservice();
			            QQ1.SearchDescAddress();
			            QQ1.SelectedBranchMethod();
			            QQ1.hidedispBranchPopUp();
			            QQ1.showdispBranchPopUp();
			            QQ1.makeAddAvailable();
			            QQ1.checkMandatoryField();
			            QQ1.checkZipCodeValidation();
			             QQ1.getSpecificProductDetail();
			            QQ1.disableSaveButton();
			            QQ1.changeIncludeLLW();
			           
                     
                    
                       QQ1.getSpecificBranchIDMethod();
	
			            QQ1.saveQuickQuoteSales();
			            QuickQuoteWrapper.SalesFleetWapper salesFleet=new QuickQuoteWrapper.SalesFleetWapper();
			            ValidateAddressService_AC vali = new ValidateAddressService_AC();
			            
			            QuickQuoteWrapper.InnerProductClass innProd1=new QuickQuoteWrapper.InnerProductClass();
				        innProd1=MMITestDataProvider.getQQControllerInnerProdWrapper1();
				        List<QuickQuoteWrapper.InnerProductClass> innProdLst1=new List<QuickQuoteWrapper.InnerProductClass>();
				        innProdLst1.add(innProd1);
				        QQ1.innerProductSearchList= innProdLst1;
                
				Test.stopTest();
			}
		}
		
       /* testMethod static void test_SelectedProduct(){
	        User u=MMITestDataProvider.getUser();
	        System.runAs(u) {
		        Test.startTest();
			        Account acc=MMITestDataProvider.getAccount();
			        insert acc;
			        Lead newLead=MMITestDataProvider.getLead();
			        insert newLead;
			        Opportunity opp=MMITestDataProvider.getOpportunity();
			        insert opp;
			        System.currentPageReference().getParameters().put('recId',newLead.Id);
			        System.currentPageReference().getParameters().put('selectedProd','2');  
			        System.currentPageReference().getParameters().put('prodCode','20i');
			        System.currentPageReference().getParameters().put('selectedTex','1');
			        System.currentPageReference().getParameters().put('selectedAddr','1');
			        QuickQuoteSalesController QQ1 = new QuickQuoteSalesController();
				        QQ1.SelectedProduct();
			        QuickQuoteSalesController QQ = new QuickQuoteSalesController();
				        QQ.SelectedProduct();
				Test.stopTest();
			}
	     }*/
		testMethod static void test_AmendShipping(){
	        User u=MMITestDataProvider.getUser();
    	    System.runAs(u){
        		Test.startTest();
			        Account acc=MMITestDataProvider.getAccountOnlyBillingAdd();
			        insert acc;
			        Lead newLead=MMITestDataProvider.getLeadWithDeliveryAdd();
			        insert newLead;
			        Opportunity opp=MMITestDataProvider.getOppoWithDeliveryAdd();
			        insert opp; 
					System.currentPageReference().getParameters().put('recId',newLead.Id);
		            System.currentPageReference().getParameters().put('selectedProd','2');  
		            System.currentPageReference().getParameters().put('prodCode','20i');
		            System.currentPageReference().getParameters().put('selectedTex','1');
		           	System.currentPageReference().getParameters().put('selectedAddr','1');
					QuickQuoteSalesController QQ = new QuickQuoteSalesController();
					QQ.QuickQuoteSalesController_initalize();
	           			QQ.AmendShipping();
  		            System.currentPageReference().getParameters().put('recId',opp.Id);
		            QuickQuoteSalesController QQ1 = new QuickQuoteSalesController();
		            QQ1.QuickQuoteSalesController_initalize();
			            QQ1.AmendShipping();
		            Opportunity opp1=MMITestDataProvider.getOppoWithOutDeliveryAddAccShippAdd();
					insert opp1; 
            		System.currentPageReference().getParameters().put('recId',opp1.Id);
           			QuickQuoteSalesController QQ2 = new QuickQuoteSalesController();
           			QQ2.QuickQuoteSalesController_initalize();
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
					System.assert( QuickQuoteMainDAO.getLeadRecord(newLead.Id)!=null);
					System.currentPageReference().getParameters().put('recId',newLead.Id);
					System.currentPageReference().getParameters().put('selectedProd','2');  
					System.currentPageReference().getParameters().put('prodCode','20i');
					System.currentPageReference().getParameters().put('selectedTex','1');
					System.currentPageReference().getParameters().put('selectedAddr','1');
		            QuickQuoteSalesController QQ = new QuickQuoteSalesController();
		            QQ.QuickQuoteSalesController_initalize();
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
		        System.assert( QuickQuoteMainDAO.getLeadRecord(newLead.Id)!=null);
		        System.currentPageReference().getParameters().put('recId',newLead.Id);
		        System.currentPageReference().getParameters().put('selectedProd','2');  
		        System.currentPageReference().getParameters().put('prodCode','20i');
		        System.currentPageReference().getParameters().put('selectedTex','2');
          		System.currentPageReference().getParameters().put('selectedAddr','2');
	            QuickQuoteSalesController QQ = new QuickQuoteSalesController();
	            QQ.QuickQuoteSalesController_initalize();
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
	            QuickQuoteSalesController QQ = new QuickQuoteSalesController();
	           	QQ.QuickQuoteSalesController_initalize();
	           	
	           	QQ.qqWrapper = new QuickQuoteWrapper();
	           	QQ.qqWrapper = qw;
	           	
	           	QQ.CapacityIdSelected();
	           	//QQ.ZipCodeFinder();
	           	QQ.DisableKnowDelZoneBtn();
				QQ.NoDelZoneRates();
				
				System.currentPageReference().getParameters().put('recId',opp2.Id);
				QuickQuoteSalesController QQ1 = new QuickQuoteSalesController();
	           	//QQ1.QuickQuoteSalesController_initalize();
	           	QQ1.qqWrapper = new QuickQuoteWrapper();
	           	QQ1.qqWrapper = qw;
	           	
	           	QQ1.CapacityIdSelected();
	            //QQ1.ZipCodeFinder();
	           	QQ1.DisableKnowDelZoneBtn();
				QQ1.NoDelZoneRates();
				
				System.currentPageReference().getParameters().put('recId',acc.Id);
				QuickQuoteSalesController QQ2 = new QuickQuoteSalesController();
	           	//QQ2.QuickQuoteSalesController_initalize();
	           	QQ2.qqWrapper = new QuickQuoteWrapper();
	           	QQ2.qqWrapper = qw;
	           	QQ2.CapacityIdSelected();
	           	//QQ2.ZipCodeFinder();
	           	QQ2.DisableKnowDelZoneBtn();
				QQ2.NoDelZoneRates();
				
				System.currentPageReference().getParameters().put('recId',jp.Id);
				System.currentPageReference().getParameters().put('scId',sc.Id);
				System.currentPageReference().getParameters().put('conId',con.Id);
				System.currentPageReference().getParameters().put('accId',acc.Id);
				System.currentPageReference().getParameters().put('source','jp');
				
				QuickQuoteSalesController QQ3 = new QuickQuoteSalesController();
	           	//QQ3.QuickQuoteSalesController_initalize();
	           	QQ3.qqWrapper = new QuickQuoteWrapper();
	           	QQ3.qqWrapper = qw;
	           	QQ3.CapacityIdSelected();
	           	//QQ3.ZipCodeFinder();
	           	QQ3.DisableKnowDelZoneBtn();
				QQ3.NoDelZoneRates();
				//QQ3.displayCOntactDetail(con.Id);
				
				Test.stopTest();
            
        	}
        }
}