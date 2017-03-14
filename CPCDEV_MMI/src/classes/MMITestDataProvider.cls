/**************************************************************************
Name:  MMITestDataProvider()
Copyright © 2013  MMI
----------------------------------------------------------------------
Purpose:
This class is created to provide test data to all test methods.
Created by TEKsystem Development team
-----------------------------------------------------------------------
History:

VERSION  AUTHOR                 DATE        DETAIL              
1.0  -  TEKsystems             12/3/2013   INITIAL DEVELOPMENT  
**************************************************************************/
public with sharing class MMITestDataProvider {
    //test data for servic proxy

    public static String getTestServiceEndpoint(){
         String testEndpoint='rest/api/v1/accounts/10492?company_id=1';
         return testEndpoint;                
    }
    public static Product_Brochures_Lookup__c getProductBrochureLookupquic(){
      Product_Brochures_Lookup__c productB = new Product_Brochures_Lookup__c();
      productB.Product_Document_Brochures_Name__c = '10I';
      
      productB.Product_Id__c = '10I';
      productB.Product_Image__c = 'test';
      
      return productB;
    }
    public static String getTestServiceMethod(){
         String testmethods='GET';
         return testmethods;                
    }

     public static String getTestServiceRequestBody(){
         String testmethods='Test Payload';
         return testmethods;                
    }
    
    //test data for country service
    public static String getMMIErrorResponse(){
         String error='{"errorCode":"e1"}';
         return error;                
    }
    public static String getMMIExceptionResponse(){
         String error='"error"';
         return error;                
    }
     public static String getMMIInvalidTokenResponse(){
         String error='{"error":"invalid_token"}';
         return error;                
    }
    public static User getUser() {
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        User u= new User(Alias='TESTUSER',Email='TEST.USER@TEST.TEST',
            EmailEncodingKey='UTF-8',FirstName='First_TEST',LastName='TEST_LAST_NAME', LanguageLocaleKey='en_US',
            LocaleSidKey='en_GB',timezonesidkey='Europe/London',Title='TEST TITLE',
            username='TEST.USER@TEST.TEST',Branch__c='101-Phoenix',ProfileId = p.Id);
     return u;
    }
    public static  String getUserBranch()
    {
        User u=[select Branch_Id__c, Branch__c from user where id=: userInfo.getUserId()];
        return u.Branch_Id__c;
    } 
     public static String getCountrycode(){
         String ccode='CAN';
         return ccode;                
    } 
    
    //
     public static Lead getLead(){
          Lead newLead=new Lead(FirstName = 'Test First', LastName ='Last ',City='city', Street='Street1',
                                 postalCode='BT28 1J' ,Country = 'USA',company='Test Company',Status='Open', phone='1234',
                                 leadSource ='Hot',Auto_Assign_Lead__c = false,Industry='abc',Servicing_Branch_Id__c='113',Branch__c='113');
         return newLead;                
    } 
    
    public static Lead getLeadWithDeliveryAdd(){
          Lead newLead=new Lead(FirstName = 'Test First', LastName ='Last ',City='city', Street='Street1',
                                 postalCode='BT28 1J' ,Country = 'USA',company='Test Company',Status='Open', phone='1234',
                                 leadSource ='Hot',Auto_Assign_Lead__c = false,Industry='abc',Servicing_Branch_Id__c='113',Branch__c='113',
                                 Delivery_Street__c='123 abc', Delivery_Postal_Code__c='85282',Delivery_Country__c='USA',Delivery_State__c='AZ');
         return newLead;                
    } 
    
    public static String generateRandomString(Integer len) {
        final String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz';
        String randStr = '';
        while (randStr.length() < len) {
           Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), 62);
           randStr += chars.substring(idx, idx+1);
        }
        return randStr; 
    }
    
    public static Account getAccount(){
          Account acc = new Account(ShippingCity= generateRandomString(8), ShippingCountry='USA', ShippingPostalCode='85282',
                                    ShippingState= generateRandomString(8), ShippingStreet= generateRandomString(8), BillingCity= generateRandomString(8), BillingCountry='USA',
                                    BillingPostalCode='85282', BillingState= generateRandomString(8), BillingStreet= generateRandomString(8) ,FirstName= generateRandomString(15),LastName=  generateRandomString(15) ) ;
         return acc;                
    } 
     public static Account getAccountOnlyBillingAdd(){
          Account acc = new Account(BillingCity= generateRandomString(8), BillingCountry='USA',
                                    BillingPostalCode='85282', BillingState= generateRandomString(8), BillingStreet= generateRandomString(8) , Name= generateRandomString(20)) ;
         return acc;                
    } 
    public static Account getAccountOnlyBillingAddSihpping(){
          Account acc = new Account(ShippingCity =  generateRandomString(8),ShippingCountry = 'USA',ShippingState = 'AZ',ShippingPostalCode = '58705',Name= generateRandomString(20)) ;
         return acc;                
    } 
    
    public static Opportunity getOpportunity(){
          Account acc=getAccount();
          insert acc;
          Opportunity opp=new Opportunity(Name= 'testOpportunity - 1',stageName='Working',closeDate = Date.Today().addDays(15),
                                          Opportunity_Lost_Category__c ='Price',Branch__c = '298',
                                          AccountId=acc.id,Valid_Address_Id__c='', Servicing_Branch__c='113');
         return opp;                
    } 
    
    public static Opportunity getOppoWithDeliveryAdd(){
          Account acc=getAccountOnlyBillingAdd();
          insert acc;
          Opportunity opp=new Opportunity(Name= 'testOpportunity - 1',stageName='Working',closeDate = Date.Today().addDays(15),
                                          Opportunity_Lost_Category__c ='Price',Branch__c = '298',
                                          AccountId=acc.id,Valid_Address_Id__c='', Servicing_Branch__c='113',
                                          Delivery_Country__c='USA',Delivery_State_Province__c='AZ',Delivery_Street__c='123 abc',Delivery_Zip_Postal_Code__c='85282');
         return opp;                
    } 
    public static Opportunity getOppoWithOutDeliveryAddAccShippAdd(){
          Account acc=getAccountOnlyBillingAdd();
          insert acc;
          Opportunity opp=new Opportunity(Name= 'testOpportunity - 1',stageName='Working',closeDate = Date.Today().addDays(15),
                                          Opportunity_Lost_Category__c ='Price',Branch__c = '298',
                                          AccountId=acc.id,Valid_Address_Id__c='', Servicing_Branch__c='113');
         return opp;                
    } 
    
    public static MMI_Quotes__c getQuickQuote(){
        
           Opportunity opp=MMITestDataProvider.getOpportunity();
            insert opp;
        
           MMI_Quotes__c insertQuote=new MMI_Quotes__c();
           insertQuote.Product__c = '10I';
               insertQuote.Branch_id__c = '209';
                insertQuote.City__c = 'test';
                insertQuote.Name = 'Quick';
                insertQuote.Date_From__c = system.today().addDays(5);
                insertQuote.Close_Date__c = system.today().addDays(5);
                insertQuote.Opportunity__c = opp.Id;
                insertQuote.State__c = 'Alaska';
                insertQuote.Status__c = 'Active';
                insertQuote.Zip_Code__c = '43543';
                insertQuote.Address__c = 'testadd';
                insertQuote.Country__c = 'New York';
                insertQUote.COD__c = 10.0;
                insertQuote.COD_Total__c = 10.0;
                insertQuote.Delivery__c = 20.0;
                insertQUote.Delivery_Total__c = 20.0;
                insertQuote.Duration__c = '2';
                insertQuote.Fuel_surcharge__c = true;
                insertQUote.Fuel_Surcharge_N__c = 25.0;
                insertQUote.Fuel_Surcharge_Total__c = 25.0;
                insertQuote.Fulfilling_Branch__c = '101';
                insertQuote.Include_LLW__c = true;
                insertQuote.LLW__c = 55.0;
                insertQuote.LLW_Total__c = 55.0;
                insertQuote.Locks__c = 2.0;
                insertQuote.Locks_N__c = 33.0;
                insertQuote.Locks_Total__c = 30.0;
                insertQuote.Pick_Up__c = 22.0;
                insertQUote.Pick_Up_Total__c = 22.0;
                insertQuote.Qty__c = 2;
                insertQuote.Quick_Quote__c = 200.0;
                insertQuote.Quick_Quote_Total__c = 200.0;
                insertQuote.Rental_PP_E__c = 15.0;
                insertQuote.Rental_PP_E_Total__c = 15.0;
                insertQuote.Rental_Rate__c = 20.0;
                insertQuote.Tax__c = 10.0;
                insertQuote.Tax_id__c = '101';
                insertQuote.Tax_Total__c = 10.0;
                insertQuote.Transport_Costs__c = 10.0;
                insertQuote.Transaction_Type__c = 'Rental Cartage';
                insertQuote.QQ_Type__c = 'rental';
                insertQuote.Reoccurring_Monthly_Charges__c = 55.0; 
                insertQuote.Close_Date__c=system.today();
         
         return insertQuote;                
    } 
    
    /*public static List<HB_Sales_Inventory__c> getHBSalesInList(){
        List<HB_Sales_Inventory__c> newHBSalesInList = new List<HB_Sales_Inventory__c>();
        HB_Sales_Inventory__c newHBSalesIn = new HB_Sales_Inventory__c();
        
        
        newHBSalesInList.add(newHBSalesIn);
        return newHBSalesInList;
    }*/
    
    public static List<HB_Sales_Inventory__c> getQuickHBSalesInventoryList(){
        List<HB_Sales_Inventory__c>  newHBSalesInventoryList = new List<HB_Sales_Inventory__c>();
        HB_Sales_Inventory__c  newHBSalesInventory = new HB_Sales_Inventory__c();
         newHBSalesInventory.Area__c = 'test';
         newHBSalesInventory.Blowout__c = true;
         newHBSalesInventory.CompanyId__c = '1';
         newHBSalesInventory.Display_Picture__c = 'test';
         newHBSalesInventory.E_Code__c = '542512';
         newHBSalesInventory.Fulfilling_Branch_Code__c = '106';
         newHBSalesInventory.Grade_Code__c = '120.00';
         newHBSalesInventory.Grade_Description__c = 'test pr';
         newHBSalesInventory.Item_Reference__c = '234';
         newHBSalesInventory.Line_Item_ID__c = '23';
         newHBSalesInventory.Minimum_Price__c = 12.20;
         newHBSalesInventory.NBV__c = 122.22;
         newHBSalesInventory.Notes__c = 'note test';
         newHBSalesInventory.Populated__c = true;
         newHBSalesInventory.Reason_Code__c = 'testa';
         newHBSalesInventory.Status__c = 'tes';
         newHBSalesInventory.Suggested_Price__c = 12.22;

        newHBSalesInventoryList.add(newHBSalesInventory);
        return newHBSalesInventoryList;
    }
    
    
    public static void getHomebaseInitialize(){
              
        HomeBaseBeans.AddressBean AddrBean = new HomeBaseBeans.AddressBean();   
        HomeBaseBeans.ProductSearch pSearch = new HomeBaseBeans.ProductSearch();
        HomeBaseBeans.Branches branch = new HomeBaseBeans.Branches();
        HomeBaseBeans.QuickQuoteRefreshFormat QQRefresh = new HomeBaseBeans.QuickQuoteRefreshFormat();
        HomeBaseBeans.States stateBean = new HomeBaseBeans.States();
        HomeBaseBeans.States stateBean1 = new HomeBaseBeans.States('','','','');
        HomeBaseBeans.countries countryBean = new HomeBaseBeans.countries();
        HomeBaseBeans.countries countryBean1 = new HomeBaseBeans.countries('','');
        HomeBaseBeans.transactions tranBean = new HomeBaseBeans.transactions();
        HomeBaseBeans.transactions tranBean1 = new HomeBaseBeans.transactions('','');
        HomeBaseBeans.webAddresses webAddreBean = new HomeBaseBeans.webAddresses();
        HomeBaseBeans.webAddresses webAddreBean1 = new HomeBaseBeans.webAddresses('','','','','','','','','','','','',
                                                                        '','','','','','','','','');
        HomeBaseBeans.TaxIds taxBean = new HomeBaseBeans.TaxIds();
        HomeBaseBeans.TaxIds taxBean1 = new HomeBaseBeans.TaxIds('','','','','','','',''); 
        HomeBaseBeans.Products proBean = new HomeBaseBeans.Products();
        HomeBaseBeans.Products proBean1 = new HomeBaseBeans.Products('','','','','','','','','','','','','','');
        
        HomeBaseBeans.quickQuoteRefresh QQRefreshBean = new HomeBaseBeans.quickQuoteRefresh();
        /*HomeBaseBeans.quickQuoteRefresh QQRefreshBean1 = new HomeBaseBeans.quickQuoteRefresh('','','','','','','','','','',
                                                                                          '','','','','','','','','','',
                                                                                          '','','','','','','','','','','');*/
    
        HomeBaseBeans.shippingAddress2 shipingAddrBean = new HomeBaseBeans.shippingAddress2();
        HomeBaseBeans.shippingAddress2 shipingAddrBean1 = new HomeBaseBeans.shippingAddress2('','','','','','','','','','',
                                                                                             '','','','','','','','','','');
        HomeBaseBeans.CreateQuickQuoteRequest createQQReqBean = new HomeBaseBeans.CreateQuickQuoteRequest();
        HomeBaseBeans.CreateQuoteResponse createQQResBean = new HomeBaseBeans.CreateQuoteResponse();
        HomeBaseBeans.contactSummaryList conSumBean = new HomeBaseBeans.contactSummaryList();
        HomeBaseBeans.contactSummaryList conSumBean1 = new HomeBaseBeans.contactSummaryList('','','','');
        HomeBaseBeans.contact contactBean = new HomeBaseBeans.contact('','','','','','','');
        HomeBaseBeans.contact contactBean1 = new HomeBaseBeans.contact();
        HomeBaseBeans.AnalysisSetHeaders analysisSetBean = new HomeBaseBeans.AnalysisSetHeaders();
        HomeBaseBeans.analysisSetCodes analysisSetCodeBean = new HomeBaseBeans.analysisSetCodes();
        HomeBaseBeans.addresses addresBean = new HomeBaseBeans.addresses();
        HomeBaseBeans.account accountBean = new HomeBaseBeans.account('','',10.0,'','','',10.0,'','',true,'','');
        HomeBaseBeans.account accountBean1 = new HomeBaseBeans.account();
        
        HomeBaseBeans.accountAddress accAddrBean = new HomeBaseBeans.accountAddress();
        HomeBaseBeans.accountAddress accAddrBean1 = new HomeBaseBeans.accountAddress('','','','','','','','','','','','','','','','','','');
        HomeBaseBeans.salesReps salesRepsBean = new HomeBaseBeans.salesReps();
        //HomeBaseBeans.rentalQuote rentalQuoteBean = new HomeBaseBeans.rentalQuote();
        HomeBaseBeans.billingContactDetails billingContactDetailsBean = new HomeBaseBeans.billingContactDetails('','','','','',''); 
        //HomeBaseBeans.lines linesBean = new HomeBaseBeans.lines();
        HomeBaseBeans.analysisSet analysisSetBean1 = new HomeBaseBeans.analysisSet();
        HomeBaseBeans.additionalAnalysisSet additionalAnalysisSetBean = new HomeBaseBeans.additionalAnalysisSet();
        HomeBaseBeans.header headerBean = new HomeBaseBeans.header(); 
        HomeBaseBeans.header headerBean1 = new HomeBaseBeans.header('','');
        HomeBaseBeans.selection selectionBean = new HomeBaseBeans.selection();
        HomeBaseBeans.selection selectionBean1 = new HomeBaseBeans.selection('','','');
        HomeBaseBeans.billingAddress billingAddressBean = new HomeBaseBeans.billingAddress('','','','','','','','','','','','','','','','','','','','','');
        HomeBaseBeans.extras extrasBean = new HomeBaseBeans.extras(); 
        HomeBaseBeans.extras extrasBean1 = new HomeBaseBeans.extras('','','1','10','10',true,true,true,true,true); 
        HomeBaseBeans.shippingAddress shippingAddressBean = new HomeBaseBeans.shippingAddress('','','','','','','','','','','','','','','','','',10.0,'','','');
        HomeBaseBeans.shippingContactDetails shippingContactDetailsBean = new HomeBaseBeans.shippingContactDetails();
        HomeBaseBeans.quoteLine quoteLineBean = new HomeBaseBeans.quoteLine();
        HomeBaseBeans.quoteLine quoteLineBean1 = new HomeBaseBeans.quoteLine('','','','','',10.0,10.0,'','',10.0,10.0,10.0,10.0,true);
        HomeBaseBeans.chargeCodes chargeCodesBean = new HomeBaseBeans.chargeCodes(); 
        HomeBaseBeans.chargeCodes chargeCodesBean1 = new HomeBaseBeans.chargeCodes('','',true,'');     
        HomeBaseBeans.Extras2 ext=new HomeBaseBeans.Extras2('','',1,'','',true,true,true,true,true); 
        HomeBaseBeans.CapacityLookupHandler capacityHandler=new HomeBaseBeans.CapacityLookupHandler(); 
        HomeBaseBeans.capacityLookupRequest capacityRequest=new HomeBaseBeans.capacityLookupRequest();  
        HomeBaseBeans.SalesFleets salesfleet=new HomeBaseBeans.SalesFleets();  
        HomeBaseBeans.rentalQuote rental=new HomeBaseBeans.rentalQuote('',10.0,'','','','','',true,'','','',true,true,'','','','','',10.0,'','',10.0,'',10.0);
        HomeBaseBeans.product newproduct = new HomeBaseBeans.product('', '',true, '','','','','', '','','','','');
        HomeBaseBeans.rates newRate = new HomeBaseBeans.rates('','');
        HomeBaseBeans.payment newpayment = new HomeBaseBeans.payment();
        HomeBaseBeans.CreateFullQuoteResponse craetfullquoteres = new HomeBaseBeans.CreateFullQuoteResponse();
        HomeBaseBeans.analysisDtls newanlysisd = new HomeBaseBeans.analysisDtls();
        HomeBaseBeans.salesRepsId salesRepId = new HomeBaseBeans.salesRepsId();
        HomeBaseBeans.lines newline = new HomeBaseBeans.lines();
        HomeBaseBeans.rates1  newrate1 = new HomeBaseBeans.rates1('','',true);
        HomeBaseBeans.shippingContactDetails newShippingCon = new HomeBaseBeans.shippingContactDetails('','','','','','');
        HomeBaseBeans.allocations  newAcclocaiton = new HomeBaseBeans.allocations();
        HomeBaseBeans.orderAndDeliveries neworderAnd = new HomeBaseBeans.orderAndDeliveries();
        HomeBaseBeans.MainLine    newMainline = new HomeBaseBeans.MainLine();
        HomeBaseBeans.OrderAndDeliveriesParam neworderAndDele = new HomeBaseBeans.OrderAndDeliveriesParam();
        HomeBaseBeans.orderDetails neworder = new HomeBaseBeans.orderDetails();
        HomeBaseBeans.ExtraInOrderDetails newExtraIn = new HomeBaseBeans.ExtraInOrderDetails();
        HomeBaseBeans.ProspectAccountParam  newProspestAcc = new HomeBaseBeans.ProspectAccountParam();
        
    }
    
     public static  QuickQuoteWrapper getQQWrapper()
    {   
        QuickQuoteWrapper qqWapper=new QuickQuoteWrapper();
        qqWapper.sellingPrice = '123';
        qqWapper.Address='123 abc';
        qqWapper.address1='123 abc';
        qqWapper.address2='';
        qqWapper.address3='tempe';
        qqWapper.address4='';
        qqWapper.BranchId='126';
        qqWapper.City='tempe';
        qqWapper.COD='120';
        qqWapper.CODTotal='120';
        qqWapper.Country='USA';
        qqWapper.countryId2='USA';
        qqWapper.DateFrom='10/4/2013';
        qqWapper.DateString='10/4/2013';
        qqWapper.Delivery='100';
        qqWapper.DeliveryFuel='100';
        qqWapper.DeliveryFuelTotal='50';
        qqWapper.DeliveryTotal='50';
        qqWapper.DisplayErrorPopUp=true;
        qqWapper.distanceFromBranch='30';
        qqWapper.delFuelSurcharge='50';
        qqWapper.pickupFuelSurcharge='50';
        qqWapper.Duration='2';
        qqWapper.FuelSurcharge='20';
        qqWapper.FuelSurchargeTotal='20';
        qqWapper.FulfillingBranch='101';
        qqWapper.isFuelSurcharge=true;
        qqWapper.isIncludeLLW=true;
        qqWapper.LeadOppName='test';
        qqWapper.LLW='20';
        qqWapper.LLWTotal='20';
        qqWapper.Locks=2;
        qqWapper.LocksAmount='20';
        qqWapper.LocksAmountTotal='20';
        qqWapper.OneTimeCharges='20';
        qqWapper.OneTimeChargesTotal='20';
        qqWapper.PickUp='20';
        qqWapper.PickUpTotal='20';
        qqWapper.PrimaryOnly=true;
        qqWapper.Product='20s';
        qqWapper.ProductSize='5';
        qqWapper.ProductType='';
        qqWapper.Quantity=2;
        qqWapper.QuickQuote='200';
        qqWapper.QuickQuoteTotal='200';
        qqWapper.Rate='100';
        qqWapper.Rate1='100';
        qqWapper.Rate2='100';
        qqWapper.Rate3='100';
        qqWapper.Rate4='100';
        qqWapper.RecurringMonthlyCharges='100';
        qqWapper.RecurringMonthlyChargesTotal='100';
        qqWapper.Rental_PP_E='20';
        qqWapper.Rental_PP_E_Total='20';
        qqWapper.ReturnFuel='20';
        qqWapper.ReturnFuelTotal='20';
        qqWapper.showProdSelect=true;
        qqWapper.showRefreshQUote=true;
        qqWapper.showSaveButton=true;
        qqWapper.showSearchError=true;
        qqWapper.showValidateAddress=true;
        qqWapper.State='AZ';
        qqWapper.state2='AZ';
        qqWapper.Tax='50';
        qqWapper.TaxTotal='50';
        qqWapper.TransactionType='Rantel';
        qqWapper.Transport='100';
        qqWapper.UserBranchId='132';
        qqWapper.ZipCode='85282';
        qqWapper.zipCode2='85282';
        qqWapper.productSearchWord='20i';
        qqWapper.ecode = 'test';
        
        return qqWapper;
    } 
    public static QuickQuoteWrapper.productTypes getQuickQuoteWrapperproductTypes(){
        QuickQuoteWrapper.productTypes QuickQuoteWrapperproductTypesNew = new QuickQuoteWrapper.productTypes();
        QuickQuoteWrapperproductTypesNew.isSelected = true;
        QuickQuoteWrapperproductTypesNew.productType = '10i';
        QuickQuoteWrapperproductTypesNew.RecUniqId  = 1;
        return QuickQuoteWrapperproductTypesNew; 
    }
    public static list<QuickQuoteWrapper.productTypes> getQuickQuoteWrapperproductTypesList(){
        List<QuickQuoteWrapper.productTypes> QuickQuoteWrapperproductTypesNewList = new List<QuickQuoteWrapper.productTypes>();
        QuickQuoteWrapper.productTypes QuickQuoteWrapperproductTypesNew = new QuickQuoteWrapper.productTypes();
        QuickQuoteWrapperproductTypesNew.isSelected = true;
        QuickQuoteWrapperproductTypesNew.productType = '10i';
        QuickQuoteWrapperproductTypesNew.RecUniqId  = 1;
        QuickQuoteWrapperproductTypesNewList.add(QuickQuoteWrapperproductTypesNew);
        return QuickQuoteWrapperproductTypesNewList; 
    }
    
    public static List<QuickQuoteWrapper.productSizes> getnewProductSizeNewList(){
        List<QuickQuoteWrapper.productSizes> QuickQuoteWrapperproductTypesNewList = new List<QuickQuoteWrapper.productSizes>();
        QuickQuoteWrapper.productSizes QuickQuoteWrapperproductTypesNew = new QuickQuoteWrapper.productSizes();
        QuickQuoteWrapperproductTypesNew.isSelected = true;
        QuickQuoteWrapperproductTypesNew.productSize = '10i';
        QuickQuoteWrapperproductTypesNew.RecUniqId  = 1;  
        
        QuickQuoteWrapperproductTypesNewList.add(QuickQuoteWrapperproductTypesNew);
        return QuickQuoteWrapperproductTypesNewList; 
    }
    
    public static QuickQuoteWrapper.ProductSales getQuickQuoteWrapperProductSales(){
        QuickQuoteWrapper.ProductSales newQuickQuoteWrapperProductSales = new QuickQuoteWrapper.ProductSales();
            newQuickQuoteWrapperProductSales.area = '23';
            newQuickQuoteWrapperProductSales.blowout = '23';
            newQuickQuoteWrapperProductSales.companyId = '1';
            newQuickQuoteWrapperProductSales.displayPicture = 'yes';
            newQuickQuoteWrapperProductSales.eCode = '---none---';
            newQuickQuoteWrapperProductSales.fulfillingBranchCode = '102';
            newQuickQuoteWrapperProductSales.gradeCode = '34534';
            newQuickQuoteWrapperProductSales.gradeDescription = '34';
            newQuickQuoteWrapperProductSales.itemRef = '2';
            newQuickQuoteWrapperProductSales.lineItemID = '2';
            newQuickQuoteWrapperProductSales.minimumPrice = 20.00;
            newQuickQuoteWrapperProductSales.nbv = 12.25;
            newQuickQuoteWrapperProductSales.notes = 'test';
            newQuickQuoteWrapperProductSales.reasonCode = '53445';
            newQuickQuoteWrapperProductSales.status = 'norm';
            newQuickQuoteWrapperProductSales.suggestedPrice = 1.02;
            newQuickQuoteWrapperProductSales.RecUniqId = 1;
            
            return newQuickQuoteWrapperProductSales ;
        
    }
     public static  HomeBaseBeans.quickQuoteRefresh getHBQQRefresh()
    {   
        HomeBaseBeans.quickQuoteRefresh HBQQRefres=new HomeBaseBeans.quickQuoteRefresh();
        HBQQRefres.accountId='123 abc';
        HBQQRefres.branchId='126';
        HBQQRefres.codAmount='20';
        HBQQRefres.companyId='1';
        HBQQRefres.dateFrom='10/4/2013';
        HBQQRefres.duration='2';
        HBQQRefres.errorMessage='error';
        HBQQRefres.fuelSurcharge='10';
        HBQQRefres.id='1234dff';
        HBQQRefres.includeLLW='10';
        HBQQRefres.lead='test';
        HBQQRefres.llwTotal='20';
        HBQQRefres.locksPrice='20';
        HBQQRefres.locksQty='2';
        HBQQRefres.locksTotal='20';
        HBQQRefres.multipleUnitsQty='3';
        HBQQRefres.operatorId='123';
        HBQQRefres.pickUpTotal='20';
        HBQQRefres.productId='20s';
        HBQQRefres.quickQuoteTotal='100';
        HBQQRefres.rate='120';
        HBQQRefres.rentalPPETotal='150';
        HBQQRefres.salesRep='1234';
        HBQQRefres.status='';
        HBQQRefres.taxTotal='10';
        HBQQRefres.transactionId='122';
        HBQQRefres.transportSurchargeTotal='10';
        HBQQRefres.transportTotal='20';
        
        return HBQQRefres;
    } 
    
      public static  QuickQuoteMainController_AC.InnerProductClass getinnerProd()
    {   
        QuickQuoteMainController_AC.InnerProductClass innerProd=new QuickQuoteMainController_AC.InnerProductClass();
        innerProd.PID='20s';
        innerProd.PRate1='100';
        innerProd.PRate2='100';
        innerProd.PRate3='100';
        innerProd.PRate4='100';
        
        return innerProd;
    } 
     public static  QuickQuoteForm_Edit_AC.InnerProductClass getinnerProdEdit()
    {   
        QuickQuoteForm_Edit_AC.InnerProductClass innerProd=new QuickQuoteForm_Edit_AC.InnerProductClass();
        innerProd.PID='20s';
        innerProd.PRate1='100';
        innerProd.PRate2='100';
        innerProd.PRate3='100';
        innerProd.PRate4='100';
        
        return innerProd;
    } 
    
    
     public static  HomeBaseBeans.ProductSearch getprodSearch()
    {   
        HomeBaseBeans.ProductSearch prodSearch=new HomeBaseBeans.ProductSearch();
        prodSearch.defId='1233';
        prodSearch.maxsize=20;
        prodSearch.minsize=5;
        prodSearch.pattern='abc';
        prodSearch.primaryOnly=true;
        
        return prodSearch;
    } 
    
    
    public static MMI_Webservices_Config__c getMMICustomSettings(){
        MMI_Webservices_Config__c mmiSetting=new MMI_Webservices_Config__c();
        mmiSetting.Authorization_Header__c='Bearer 1224334fddfg';
        mmiSetting.Content_Type__c='application/json';
        mmiSetting.MMI_End_Point__c='http://testendpoint.com';
        mmiSetting.Name='mmi web service config';
        mmiSetting.Time_Out__c=6000;
        mmiSetting.ClientId__c='28349576287365981654189765974584';
        mmiSetting.SecretId__c='iqwtyw3478tywiourtywiurytw3847tyiesdfdsfg';
        mmiSetting.Retry__c=1;
        return mmiSetting;
   }
   
   public static  QuickQuoteWrapper.AddressInnerClass getQQAddressWrapper()
    {   
        QuickQuoteWrapper.AddressInnerClass qqWapper=new QuickQuoteWrapper.AddressInnerClass();
        qqWapper.city='Tempe';
        qqWapper.country='USA';
        qqWapper.country1='USA';
        qqWapper.countryDescription='USA';
        qqWapper.Id='12345';
        qqWapper.isSelected=true;
        qqWapper.RecUniqId=1;
        qqWapper.state='AZ';
        qqWapper.stateDescription='AZ';
        qqWapper.taxAreaStatus='Normal';
        return qqWapper;
    } 
    public static  QuickQuoteWrapper.DescarteInnerClass getQQDecarteWrapper()
    {   
        QuickQuoteWrapper.DescarteInnerClass qqWapper=new QuickQuoteWrapper.DescarteInnerClass();
        qqWapper.address1='123 abc';
        qqWapper.address2='abc';
        qqWapper.address3='Tempe';
        qqWapper.address4='AZ';
        qqWapper.branchId='113';
        qqWapper.companyId='1';
        qqWapper.countryId='USA';
        qqWapper.crossStreet1='sdas';
        qqWapper.crossStreet2='ddfdf';
        qqWapper.deliveryZone='test';
        qqWapper.distanceBranch='123';
        qqWapper.fulfillingBranch='101';
        qqWapper.fulfillingBranchName='test';
        qqWapper.isSelected=true;
        qqWapper.latitude='test';
        qqWapper.longitude='test';
        qqWapper.oldPostalCode='85828';
        qqWapper.RecUniqId=1;
        qqWapper.state='AZ';
        qqWapper.taxId='1234';
        qqWapper.zipCode='85282';
        qqWapper.zoneWarning='test';
        return qqWapper;
    } 
    
    public static  QuickQuoteWrapper.InnerProductClass getQQInnerProdWrapper()
    {   
        QuickQuoteWrapper.InnerProductClass qqWapper=new QuickQuoteWrapper.InnerProductClass();
        qqWapper.isSelected=true;
        qqWapper.mainFeature='test';
        qqWapper.PCommission1='test';
        qqWapper.PCommission2='test';
        qqWapper.PCommission3='test';
        qqWapper.PCommission4='test';
        qqWapper.PDescription='test';
        qqWapper.PID='20i';
        qqWapper.Pllw='10';
        qqWapper.ppe='10';
        qqWapper.PQtyAvail='2';
        qqWapper.PQtyFree='1';
        qqWapper.PQtyReserved='2';
        qqWapper.PQtyTotal='12';
        qqWapper.PQtyWip='2';
        qqWapper.PRate1='100';
        qqWapper.PRate2='90';
        qqWapper.PRate3='100';
        qqWapper.PRate4='90';
        qqWapper.PRate5='100';
        qqWapper.PRate6='90';
        qqWapper.PRate7='100';
        qqWapper.PRate8='90';
        qqWapper.RecUniqId=2;
       
        return qqWapper;
    } 
    
      public static  QuickQuoteWrapper.showbranches getQQShowBranchWrapper()
    {   
        QuickQuoteWrapper.showbranches qqWapper=new QuickQuoteWrapper.showbranches();
        qqWapper.Id='101';
        qqWapper.isSelected=true;
        qqWapper.Name='test';
        qqWapper.RecUniqId=2;
        return qqWapper;
    } 
    
    public static  QuickQuoteWrapper.stateInnerClass getQQStateInnerWrapper()
    {   
        QuickQuoteWrapper.stateInnerClass qqWapper=new QuickQuoteWrapper.stateInnerClass();
        qqWapper.companyId='1';
        qqWapper.countryId='USA';
        qqWapper.Id='23';
        qqWapper.Name='AZ';
       
        return qqWapper;
    } 
    
     public static  QuickQuoteMainController_AC.InnerProductClass getQQControllerInnerProdWrapper()
    {   
        QuickQuoteMainController_AC.InnerProductClass qqWapper=new QuickQuoteMainController_AC.InnerProductClass();
        qqWapper.isSelected=true;
        qqWapper.mainFeature='test';
        qqWapper.PCommission1='test';
        qqWapper.PCommission2='test';
        qqWapper.PCommission3='test';
        qqWapper.PCommission4='test';
        qqWapper.PDescription='test';
        qqWapper.PID='20i';
        qqWapper.Pllw='10';
        qqWapper.ppe='10';
        qqWapper.PQtyAvail='2';
        qqWapper.PQtyFree='1';
        qqWapper.PQtyReserved='2';
        qqWapper.PQtyTotal='12';
        qqWapper.PQtyWip='2';
        qqWapper.PRate1='100';
        qqWapper.PRate2='90';
        qqWapper.PRate3='100';
        qqWapper.PRate4='90';
        qqWapper.PRate5='100';
        qqWapper.PRate6='90';
        qqWapper.PRate7='100';
        qqWapper.PRate8='90';
        qqWapper.RecUniqId=2;
       
        return qqWapper;
    } 
    
    public static  QuickQuoteWrapper.InnerProductClass getQQControllerInnerProdWrapper1()
    {   
        QuickQuoteWrapper.InnerProductClass qqWapper=new QuickQuoteWrapper.InnerProductClass();
        qqWapper.isSelected=true;
        qqWapper.mainFeature='test';
        qqWapper.PCommission1='test';
        qqWapper.PCommission2='test';
        qqWapper.PCommission3='test';
        qqWapper.PCommission4='test';
        qqWapper.PDescription='test';
        qqWapper.PID='20i';
        qqWapper.Pllw='10';
        qqWapper.ppe='10';
        qqWapper.PQtyAvail='2';
        qqWapper.PQtyFree='1';
        qqWapper.PQtyReserved='2';
        qqWapper.PQtyTotal='12';
        qqWapper.PQtyWip='2';
        qqWapper.PRate1='100';
        qqWapper.PRate2='90';
        qqWapper.PRate3='100';
        qqWapper.PRate4='90';
        qqWapper.PRate5='100';
        qqWapper.PRate6='90';
        qqWapper.PRate7='100';
        qqWapper.PRate8='90';
        qqWapper.RecUniqId=2;
       
        return qqWapper;
    } 
    
    
      public static  QuickQuoteForm_Edit_AC.InnerProductClass getQQControllerEditInnerProdWrapper()
    {   
        QuickQuoteForm_Edit_AC.InnerProductClass qqWapper=new QuickQuoteForm_Edit_AC.InnerProductClass();
        qqWapper.isSelected=true;
        qqWapper.mainFeature='test';
        qqWapper.PCommission1='test';
        qqWapper.PCommission2='test';
        qqWapper.PCommission3='test';
        qqWapper.PCommission4='test';
        qqWapper.PDescription='test';
        qqWapper.PID='20i';
        qqWapper.Pllw='10';
        qqWapper.ppe='10';
        qqWapper.PQtyAvail='2';
        qqWapper.PQtyFree='1';
        qqWapper.PQtyReserved='2';
        qqWapper.PQtyTotal='12';
        qqWapper.PQtyWip='2';
        qqWapper.PRate1='100';
        qqWapper.PRate2='90';
        qqWapper.PRate3='100';
        qqWapper.PRate4='90';
        qqWapper.PRate5='100';
        qqWapper.PRate6='90';
        qqWapper.PRate7='100';
        qqWapper.PRate8='90';
        qqWapper.RecUniqId=2;
       
        return qqWapper;
    } 
    
     public static  List<HomeBaseBeans.Products> getQHomeBaseProduct()
    {   
        HomeBaseBeans.Products qqWapper=new HomeBaseBeans.Products();
        qqWapper.mainFeature='test';
        qqWapper.commission1='test';
        qqWapper.commission2='test';
        qqWapper.commission3='test';
        qqWapper.commission4='test';
        qqWapper.Description='test';
        qqWapper.Id='20i';
        qqWapper.llw='10';
        qqWapper.ppe='10';
        qqWapper.qtyAvail='2';
        qqWapper.qtyFree='1';
        qqWapper.qtyReserved='2';
        qqWapper.qtyTotal='12';
        qqWapper.qtyWip='2';
        
         HomeBaseBeans.rates rate=new  HomeBaseBeans.rates();
        rate.description='test';
        rate.editable=true;
        rate.rate='100';
       
        
        qqWapper.rate1=rate;
        qqWapper.rate2=rate;
        qqWapper.rate3=rate;
        qqWapper.rate4=rate;
        qqWapper.rate5=rate;
        qqWapper.rate6=rate;
        qqWapper.rate7=rate;
        qqWapper.rate8=rate;
        qqWapper.isSelected=true;
        qqWapper.lineCount=2;
        qqWapper.lineValue='20i';
        qqWapper.quantity=2;
        
       List<HomeBaseBeans.Products> prodList=new List<HomeBaseBeans.Products>();
        prodList.add(qqWapper);
        
        return prodList;
    } 
    
    
     public static HomeBaseBeans.Products getQHomeBaseProductSingle()
    {   
        HomeBaseBeans.Products qqWapper=new HomeBaseBeans.Products();
        qqWapper.mainFeature='test';
        qqWapper.commission1='test';
        qqWapper.commission2='test';
        qqWapper.commission3='test';
        qqWapper.commission4='test';
        qqWapper.Description='test';
        qqWapper.Id='20i';
        qqWapper.llw='10';
        qqWapper.ppe='10';
        qqWapper.qtyAvail='2';
        qqWapper.qtyFree='1';
        qqWapper.qtyReserved='2';
        qqWapper.qtyTotal='12';
        qqWapper.qtyWip='2';
        
         HomeBaseBeans.rates rate=new  HomeBaseBeans.rates();
        rate.description='test';
        rate.editable=true;
        rate.rate='100';
       
        
        qqWapper.rate1=rate;
        qqWapper.rate2=rate;
        qqWapper.rate3=rate;
        qqWapper.rate4=rate;
        qqWapper.rate5=rate;
        qqWapper.rate6=rate;
        qqWapper.rate7=rate;
        qqWapper.rate8=rate;
        qqWapper.isSelected=true;
        qqWapper.lineCount=2;
        qqWapper.lineValue='20i';
        qqWapper.quantity=2;
        
      
        
        return qqWapper;
    } 
    
     public static  List<HomeBaseBeans.TaxIds> getQHomeBaseTax()
    {   
        HomeBaseBeans.TaxIds qqWapper=new HomeBaseBeans.TaxIds();
        qqWapper.city='tempe';
        qqWapper.country='USA';
        qqWapper.country1='USA';
        qqWapper.countryDescription='USA';
        qqWapper.Id='123456';
        qqWapper.isSelected=true;
        qqWapper.RecUniqId=2;
        qqWapper.state='AZ';
        qqWapper.stateDescription='AZ';
        qqWapper.taxAreaStatus='Normal';
            
        List<HomeBaseBeans.TaxIds> taxList=new List<HomeBaseBeans.TaxIds>();
        taxList.add(qqWapper);
        
        return taxList;
    } 
    
     public static List<QuickQuoteMainController_AC.AddressInnerClass> getQQControllerAddressWrapper()
    {   
        QuickQuoteMainController_AC.AddressInnerClass qqWapper=new QuickQuoteMainController_AC.AddressInnerClass();
        qqWapper.city='Tempe';
        qqWapper.country='USA';
        qqWapper.country1='USA';
        qqWapper.countryDescription='USA';
        qqWapper.Id='12345';
        qqWapper.isSelected=true;
        qqWapper.RecUniqId=2;
        qqWapper.state='AZ';
        qqWapper.stateDescription='AZ';
        qqWapper.taxAreaStatus='Normal';
        
        List<QuickQuoteMainController_AC.AddressInnerClass> addressList=new List<QuickQuoteMainController_AC.AddressInnerClass>();
        addressList.add(qqWapper);
        return addressList;
    } 
    
    public static  List<QuickQuoteMainController_AC.DescarteInnerClass> getQQControllerDecarteWrapper()
    {   
        QuickQuoteMainController_AC.DescarteInnerClass qqWapper=new QuickQuoteMainController_AC.DescarteInnerClass();
        qqWapper.address1='123 abc';
        qqWapper.address2='abc';
        qqWapper.address3='Tempe';
        qqWapper.address4='AZ';
        qqWapper.branchId='113';
        qqWapper.companyId='1';
        qqWapper.countryId='USA';
        qqWapper.crossStreet1='sdas';
        qqWapper.crossStreet2='ddfdf';
        qqWapper.deliveryZone='test';
        qqWapper.distanceBranch='123';
        qqWapper.fulfillingBranch='101';
        qqWapper.fulfillingBranchName='test';
        qqWapper.isSelected=true;
        qqWapper.latitude='test';
        qqWapper.longitude='test';
        qqWapper.oldPostalCode='85828';
        qqWapper.RecUniqId=1;
        qqWapper.state='AZ';
        qqWapper.taxId='1234';
        qqWapper.zipCode='85282';
        qqWapper.zoneWarning='test';
        
        List<QuickQuoteMainController_AC.DescarteInnerClass> descarteList=new List<QuickQuoteMainController_AC.DescarteInnerClass>();
        descarteList.add(qqWapper);
        return descarteList;
    } 
    
     public static  List<HomeBaseBeans.countries> getQHomeBasecontry()
    {   
        HomeBaseBeans.countries qqWapper=new HomeBaseBeans.countries();
        qqWapper.id='USA';
        qqWapper.Name='USA';
        
            
        List<HomeBaseBeans.countries> taxList=new List<HomeBaseBeans.countries>();
        taxList.add(qqWapper);
        
        return taxList;
    } 
    
    public static  List<HomeBaseBeans.States> getQHomeBaseState()
    {   
        HomeBaseBeans.States qqWapper=new HomeBaseBeans.States();
        qqWapper.companyId='1';
        qqWapper.countryId='USA';
        qqWapper.id='AZ';
        qqWapper.Name='AZ';
        
        List<HomeBaseBeans.States> taxList=new List<HomeBaseBeans.States>();
        taxList.add(qqWapper);
        
        return taxList;
    } 
    
   
      public static  HomeBaseBeans.CreateQuoteResponse getQHomeBaseCreateQQ()
    {   
         HomeBaseBeans.CreateQuoteResponse qqWapper=new  HomeBaseBeans.CreateQuoteResponse();
         qqWapper.documentId='123';
    
        return qqWapper;
    } 
 
   public static  List<HomeBaseBeans.webAddresses> getQHomeBaseWebAdd()
    {   
         HomeBaseBeans.webAddresses qqWapper=new  HomeBaseBeans.webAddresses();
        qqWapper.address1='123 abc';
        qqWapper.address2='abc';
        qqWapper.address3='Tempe';
        qqWapper.address4='AZ';
        qqWapper.branchId='113';
        qqWapper.companyId='1';
        qqWapper.countryId='USA';
        qqWapper.crossStreet1='sdas';
        qqWapper.crossStreet2='ddfdf';
        qqWapper.deliveryZone='test';
        qqWapper.distanceBranch='123';
        qqWapper.fulfillingBranchId='101';
        qqWapper.fulfillingBranchName='test';
        qqWapper.isSelected=true;
        qqWapper.latitude='test';
        qqWapper.longitude='test';
        qqWapper.oldPostalCode='85828';
        qqWapper.state='AZ';
        qqWapper.taxId='1234';
        qqWapper.zipCode='85282';
        qqWapper.zoneWarning='test';
        List<HomeBaseBeans.webAddresses> webAddList=new List<HomeBaseBeans.webAddresses>();
        webAddList.add(qqWapper);
    
        return webAddList;
    } 
    
    
     public static  List<HomeBaseBeans.branches> getQHomeBaseBranch()
    {   
        HomeBaseBeans.branches qqWapper=new HomeBaseBeans.branches();
        qqWapper.id='101';
        qqWapper.isSelected=true;
        qqWapper.name='abc';
        
       List<HomeBaseBeans.branches> taxList=new List<HomeBaseBeans.branches>();
        taxList.add(qqWapper);
        
        return taxList;
    } 
    
    
     public static List<QuickQuoteForm_Edit_AC.AddressInnerClass> getQQControllerEditAddressWrapper()
    {   
        QuickQuoteForm_Edit_AC.AddressInnerClass qqWapper=new QuickQuoteForm_Edit_AC.AddressInnerClass();
        qqWapper.city='Tempe';
        qqWapper.country='USA';
        qqWapper.country1='USA';
        qqWapper.countryDescription='USA';
        qqWapper.Id='12345';
        qqWapper.isSelected=true;
        qqWapper.RecUniqId=2;
        qqWapper.state='AZ';
        qqWapper.stateDescription='AZ';
        qqWapper.taxAreaStatus='Normal';
        
        List<QuickQuoteForm_Edit_AC.AddressInnerClass> addressList=new List<QuickQuoteForm_Edit_AC.AddressInnerClass>();
        addressList.add(qqWapper);
        return addressList;
    } 
    
    public static  List<QuickQuoteForm_Edit_AC.DescarteInnerClass> getQQControllerEditDecarteWrapper()
    {   
        QuickQuoteForm_Edit_AC.DescarteInnerClass qqWapper=new QuickQuoteForm_Edit_AC.DescarteInnerClass();
        qqWapper.address1='123 abc';
        qqWapper.address2='abc';
        qqWapper.address3='Tempe';
        qqWapper.address4='AZ';
        qqWapper.branchId='113';
        qqWapper.companyId='1';
        qqWapper.countryId='USA';
        qqWapper.crossStreet1='sdas';
        qqWapper.crossStreet2='ddfdf';
        qqWapper.deliveryZone='test';
        qqWapper.distanceBranch='123';
        qqWapper.fulfillingBranch='101';
        qqWapper.fulfillingBranchName='test';
        qqWapper.isSelected=true;
        qqWapper.latitude='test';
        qqWapper.longitude='test';
        qqWapper.oldPostalCode='85828';
        qqWapper.RecUniqId=1;
        qqWapper.state='AZ';
        qqWapper.taxId='1234';
        qqWapper.zipCode='85282';
        qqWapper.zoneWarning='test';
        
        List<QuickQuoteForm_Edit_AC.DescarteInnerClass> descarteList=new List<QuickQuoteForm_Edit_AC.DescarteInnerClass>();
        descarteList.add(qqWapper);
        return descarteList;
    } 
    
     public static MMI_Quotes__c getQuickQuoteDAO(string oppid){

           MMI_Quotes__c insertQuote=new MMI_Quotes__c();
   
               insertQuote.Branch_id__c = '209';
                insertQuote.City__c = 'test';
                insertQuote.Name = 'Quick';
                insertQuote.Date_From__c = Date.Today();
                insertQuote.Opportunity__c = oppid;
                insertQuote.State__c = 'Alaska';
                insertQuote.Status__c = 'Active';
                insertQuote.Zip_Code__c = '43543';
                insertQuote.Address__c = 'testadd';
                insertQuote.Country__c = 'New York';
                insertQUote.COD__c = 10.0;
                insertQuote.COD_Total__c = 10.0;
                insertQuote.Delivery__c = 20.0;
                insertQUote.Delivery_Total__c = 20.0;
                insertQuote.Duration__c = '2';
                insertQuote.Fuel_surcharge__c = true;
                insertQUote.Fuel_Surcharge_N__c = 25.0;
                insertQUote.Fuel_Surcharge_Total__c = 25.0;
                insertQuote.Fulfilling_Branch__c = '101';
                insertQuote.Include_LLW__c = true;
                insertQuote.LLW__c = 55.0;
                insertQuote.LLW_Total__c = 55.0;
                insertQuote.Locks__c = 2.0;
                insertQuote.Locks_N__c = 33.0;
                insertQuote.Locks_Total__c = 30.0;
                insertQuote.Pick_Up__c = 22.0;
                insertQUote.Pick_Up_Total__c = 22.0;
                insertQuote.Qty__c = 2;
                insertQuote.Quick_Quote__c = 200.0;
                insertQuote.Quick_Quote_Total__c = 200.0;
                insertQuote.Rental_PP_E__c = 15.0;
                insertQuote.Rental_PP_E_Total__c = 15.0;
                insertQuote.Rental_Rate__c = 20.0;
                insertQuote.Tax__c = 10.0;
                insertQuote.Tax_id__c = '101';
                insertQuote.Tax_Total__c = 10.0;
                insertQuote.Transport_Costs__c = 10.0;
                insertQuote.Transaction_Type__c = 'Rental Cartage';
                insertQuote.Reoccurring_Monthly_Charges__c = 55.0; 
         
         return insertQuote;                
    } 
    
     public static EditSalesQuickQuoteWrap getEditSalesQQwrap()
    {   
        
        EditSalesQuickQuoteWrap qqWapper=new EditSalesQuickQuoteWrap();
        qqWapper.accountId='';
        qqWapper.branchId='102';
        qqWapper.certificate='';
        qqWapper.codAmount='100';
        qqWapper.companyId='1';
        qqWapper.dateFrom='10/4/2013';
        qqWapper.duration='2';
        qqWapper.ecode='12345';
        qqWapper.fuelSurcharge=true;
        qqWapper.id='0';
        qqWapper.includeLLW=true;
        qqWapper.lead='test';
        qqWapper.lineValue='100';
        qqWapper.llwTotal='100';
        qqWapper.locksPrice='10';
        qqWapper.locksQty='2';
        qqWapper.locksTotal='20';
        qqWapper.modificationCharge='0.0';
        qqWapper.operatorId='1';
        qqWapper.pickupSurchargeTotal='10';
       qqWapper.pickUpTotal='10';
       qqWapper.productId='10i';
       qqWapper.quickQuoteTotal='200';
       qqWapper.rate='200';
       qqWapper.rentalPPETotal='10';
       qqWapper.rentalQuoteConvertible=true;
       qqWapper.salesQuoteConvertible=true;
       qqWapper.salesRep='1234';
       qqWapper.status='active';
       qqWapper.taxTotal='100';
       qqWapper.transactionId='SOFL';
       qqWapper.transport='25';
       qqWapper.transportSurchargeTotal='10';
     
       EditSalesQuickQuoteWrap.ShippingAddress addr=new  EditSalesQuickQuoteWrap.ShippingAddress();
         addr.address1='123 abc';
        addr.address2='abc';
        addr.address3='Tempe';
        addr.address4='AZ';
        addr.cityZone='A';
       
        addr.countryId='USA';
        addr.crossStreet1='sdas';
        addr.crossStreet2='ddfdf';
        addr.deliveryZone='test';
        addr.distanceFromBranch='1.2';
        addr.distanceBranch='123';
        addr.fulfillingBranchId='101';
        addr.fulfillingBranchName='test';
       
        addr.latitude='test';
        addr.longitude='test';
        addr.oldPostalCode='85828';
       
        addr.state='AZ';
        addr.taxId='1234';
        addr.zipCode='85282';
        addr.zoneWarning='test';
        qqWapper.shippingAddress3=addr;
        
        return qqWapper;
    } 
    public static  HB_Sales_Inventory__c  getHBSalesInventory(){
        HB_Sales_Inventory__c  newHBSalesInventory = new HB_Sales_Inventory__c();
         newHBSalesInventory.Area__c = 'test';
         newHBSalesInventory.Blowout__c = true;
         newHBSalesInventory.CompanyId__c = '1';
         newHBSalesInventory.Display_Picture__c = 'test';
         newHBSalesInventory.E_Code__c = '542512';
         newHBSalesInventory.Fulfilling_Branch_Code__c = '106';
         newHBSalesInventory.Grade_Code__c = '120.00';
         newHBSalesInventory.Grade_Description__c = 'test pr';
         newHBSalesInventory.Item_Reference__c = '234';
         newHBSalesInventory.Line_Item_ID__c = '23';
         newHBSalesInventory.Minimum_Price__c = 12.20;
         newHBSalesInventory.NBV__c = 122.22;
         newHBSalesInventory.Notes__c = 'note test';
         newHBSalesInventory.Populated__c = true;
         newHBSalesInventory.Reason_Code__c = 'testa';
         newHBSalesInventory.Status__c = 'tes';
         newHBSalesInventory.Suggested_Price__c = 12.22;
        return newHBSalesInventory;
    }
    
   
     public static  List<QuickQuoteSales_Edit.DescarteInnerClass> getSalesQQDecarteWrapper()
    {   
        QuickQuoteSales_Edit.DescarteInnerClass qqWapper=new QuickQuoteSales_Edit.DescarteInnerClass();
        qqWapper.address1='123 abc';
        qqWapper.address2='abc';
        qqWapper.address3='Tempe';
        qqWapper.address4='AZ';
        qqWapper.branchId='113';
        qqWapper.companyId='1';
        qqWapper.countryId='USA';
        qqWapper.crossStreet1='sdas';
        qqWapper.crossStreet2='ddfdf';
        qqWapper.deliveryZone='test';
        qqWapper.distanceBranch='123';
        qqWapper.fulfillingBranch='101';
        qqWapper.fulfillingBranchName='test';
        qqWapper.isSelected=true;
        qqWapper.latitude='test';
        qqWapper.longitude='test';
        qqWapper.oldPostalCode='85828';
        qqWapper.RecUniqId=1;
        qqWapper.state='AZ';
        qqWapper.taxId='1234';
        qqWapper.zipCode='85282';
        qqWapper.zoneWarning='test';
        
        List<QuickQuoteSales_Edit.DescarteInnerClass> descarteList=new List<QuickQuoteSales_Edit.DescarteInnerClass>();
        descarteList.add(qqWapper);
        return descarteList;
    } 
    
    
     public static  List<QuickQuoteWrapper.ProductSales> getSalesProductSales()
    {   
        
        QuickQuoteWrapper.ProductSales qp=new QuickQuoteWrapper.ProductSales();
        qp.area='';
        qp.blowout='true';
        qp.companyId='1';
        qp.displayPicture='test';
        qp.eCode='1234';
        qp.fulfillingBranchCode='102';
        qp.gradeCode='A';
        qp.gradeDescription='test';
        qp.itemRef='20z';
        qp.lineItemID='1';
        qp.minimumPrice=100;
        qp.nbv=100;
        qp.notes='test';
        qp.reasonCode='test';
        qp.RecUniqId=1;
        qp.status='test';
        qp.suggestedPrice=100;
        
        
        List<QuickQuoteWrapper.ProductSales> descarteList=new List<QuickQuoteWrapper.ProductSales>();
        descarteList.add(qp);
        return descarteList;
    } 
    
    public static   List<HB_Sales_Inventory__c>  getHBSalesInventoryList(){ 
        HB_Sales_Inventory__c  newHBSalesInventory = new HB_Sales_Inventory__c();
         newHBSalesInventory.Area__c = 'test';
         newHBSalesInventory.Blowout__c = true;
         newHBSalesInventory.CompanyId__c = '1';
         newHBSalesInventory.Display_Picture__c = 'test'; 
         newHBSalesInventory.E_Code__c = '542512';
         newHBSalesInventory.Fulfilling_Branch_Code__c = '106';
         newHBSalesInventory.Grade_Code__c = '120.00';
         newHBSalesInventory.Grade_Description__c = 'test pr';
         newHBSalesInventory.Item_Reference__c = '234';
         newHBSalesInventory.Line_Item_ID__c = '23';
         newHBSalesInventory.Minimum_Price__c = 12.20;
         newHBSalesInventory.NBV__c = 122.22;
         newHBSalesInventory.Notes__c = 'note test';
         newHBSalesInventory.Populated__c = true;
         newHBSalesInventory.Reason_Code__c = 'testa';
         newHBSalesInventory.Status__c = 'tes';
         newHBSalesInventory.Suggested_Price__c = 12.22;
          List<HB_Sales_Inventory__c> SalesInventoryList=new List<HB_Sales_Inventory__c>();
         SalesInventoryList.add(newHBSalesInventory);
        return SalesInventoryList;
    }
    
      public static  List<QuickQuoteWrapper.DescarteInnerClass> getSalesQQSaveDecarteWrapper()
    {   
        QuickQuoteWrapper.DescarteInnerClass qqWapper=new QuickQuoteWrapper.DescarteInnerClass();
        qqWapper.address1='123 abc';
        qqWapper.address2='abc';
        qqWapper.address3='Tempe';
        qqWapper.address4='AZ';
        qqWapper.branchId='113';
        qqWapper.companyId='1';
        qqWapper.countryId='USA';
        qqWapper.crossStreet1='sdas';
        qqWapper.crossStreet2='ddfdf';
        qqWapper.deliveryZone='test';
        qqWapper.distanceBranch='123';
        qqWapper.fulfillingBranch='101'; 
        qqWapper.fulfillingBranchName='test';
        qqWapper.isSelected=true;
        qqWapper.latitude='test';
        qqWapper.longitude='test';
        qqWapper.oldPostalCode='85828';
        qqWapper.RecUniqId=1;
        qqWapper.state='AZ';
        qqWapper.taxId='1234';
        qqWapper.zipCode='85282';
        qqWapper.zoneWarning='test';
         
        List<QuickQuoteWrapper.DescarteInnerClass> descarteList=new List<QuickQuoteWrapper.DescarteInnerClass>();
        descarteList.add(qqWapper);
        return descarteList;
    }  
    
     public static  List<QuickQuoteMainController_AC.DescarteInnerClass> getQQSaveDecarteWrapper()
    {   
        QuickQuoteMainController_AC.DescarteInnerClass qqWapper=new QuickQuoteMainController_AC.DescarteInnerClass();
        qqWapper.address1='123 abc';
        qqWapper.address2='abc';
        qqWapper.address3='Tempe';
        qqWapper.address4='AZ';
        qqWapper.branchId='113';
        qqWapper.companyId='1';
        qqWapper.countryId='USA';
        qqWapper.crossStreet1='sdas';
        qqWapper.crossStreet2='ddfdf';
        qqWapper.deliveryZone='test';
        qqWapper.distanceBranch='123';
        qqWapper.fulfillingBranch='101'; 
        qqWapper.fulfillingBranchName='test';
        qqWapper.isSelected=true;
        qqWapper.latitude='test';
        qqWapper.longitude='test';
        qqWapper.oldPostalCode='85828';
        qqWapper.RecUniqId=1;
        qqWapper.state='AZ';
        qqWapper.taxId='1234';
        qqWapper.zipCode='85282';
        qqWapper.zoneWarning='test';
         
        List<QuickQuoteMainController_AC.DescarteInnerClass> descarteList=new List<QuickQuoteMainController_AC.DescarteInnerClass>();
        descarteList.add(qqWapper);
        return descarteList; 
    } 
    
}