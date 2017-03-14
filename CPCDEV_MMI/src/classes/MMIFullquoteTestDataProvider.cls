/**************************************************************************
Name:  MMIFullquoteTestDataProvider()
Copyright � 2013  MMI
----------------------------------------------------------------------
Purpose:
This class is created to provide test data to all test methods.
Created by TEKsystem Development team
-----------------------------------------------------------------------
History:

VERSION  AUTHOR                 DATE        DETAIL              
1.0  -  TEKsystems             14/11/2013   INITIAL DEVELOPMENT  
**************************************************************************/
public with sharing class MMIFullquoteTestDataProvider {
	
	public static String generateRandomString(Integer len) {
	    final String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz';
	    String randStr = '';
	    while (randStr.length() < len) {
	       Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), 62);
	       randStr += chars.substring(idx, idx+1);
	    }
	    return randStr; 
	}

	 public static User getUser() {
    	Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        User u= new User(Alias='TESTUSER',Email='TEST.USER@TEST.TEST',
            EmailEncodingKey='UTF-8',FirstName='First_TEST',LastName='TEST_LAST_NAME', LanguageLocaleKey='en_US',
            LocaleSidKey='en_GB',timezonesidkey='Europe/London',Title='TEST TITLE',
            username='TEST.USER@TEST.TEST',Branch__c='101-Phoenix',ProfileId = p.Id);
     return u;
    }
    public static User getUserWithAdmin() {
    	Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        User u= new User(Alias='TUfES',Email='TEST.USER2@TEST.TEST',
            EmailEncodingKey='UTF-8',FirstName='First_TEST',LastName='TEST_LAST_NAME', LanguageLocaleKey='en_US',
            LocaleSidKey='en_GB',timezonesidkey='Europe/London',Title='TEST TITLE',
            username='TEST.USER2@TEST.TEST',Branch__c='101-Phoenix',ProfileId = p.Id);
     return u;
    }
    public static Account getAccount(){
    	//String CurrntTimeStamp = String.valueOf(DateTime.now().millisecond());
    	String RandomString = generateRandomString(8);
          Account acc = new Account(ShippingCity= generateRandomString(8), ShippingCountry='USA', ShippingPostalCode='85282',
                                    ShippingState= generateRandomString(8), ShippingStreet= generateRandomString(8), BillingCity= generateRandomString(8), BillingCountry='USA',
                                    BillingPostalCode='85282', BillingState= generateRandomString(8), BillingStreet= generateRandomString(8) ,FirstName = generateRandomString(15),LastName= generateRandomString(15) ) ;
         return acc;                
    }
    
    public static Account getBusinessAccount(){
          Account acc = new Account(ShippingCity= generateRandomString(8), ShippingCountry='USA', ShippingPostalCode='85282',
                                    ShippingState= generateRandomString(8), ShippingStreet= generateRandomString(8), BillingCity= generateRandomString(8), BillingCountry='USA',
                                    BillingPostalCode='85282', BillingState= generateRandomString(8), BillingStreet= generateRandomString(8) , Name= generateRandomString(20) ) ;
         return acc;                
    }
     
    public static  Branch_Lookup__c getBranchLookup(){
    	Branch_Lookup__c branch = new Branch_Lookup__c(Zip__c = '56077', County__c = 'USA');
    	return branch;

    	 	
     }
     public static  Document getDocument(){
     	Blob b = Blob.valueOf('Test Data');
    	Document Docume= new Document(Name = 'Image',Body = b);
    	return Docume;

    	 	
     }
     
    public static List<Account> getBusinessAccountList(){
    	List<Account> newBusinessAccountList = new List<Account>();
          Account acc = new Account(ShippingCity= generateRandomString(8), ShippingCountry='USA', ShippingPostalCode='85282',
                                    ShippingState= generateRandomString(8), ShippingStreet= generateRandomString(8), BillingCity = generateRandomString(8), BillingCountry='USA',
                                    BillingPostalCode='85282', BillingState= generateRandomString(8), BillingStreet= generateRandomString(8) ,Name= generateRandomString(20) ) ;
         newBusinessAccountList.add(acc);
         return newBusinessAccountList;                
    }
    
    public static List<Contact> getContactList(){
    	List<Contact> contList = new List<Contact>();
    	List<Account> acc = getBusinessAccountList();
    	insert acc;
    	Contact con = new Contact(LastName='ln', AccountId=acc[0].Id, Decision_Maker__c='Yes', email='test@tester.com') ;
    	contList.add(con);
    	return contList;
    }
     
     public static Opportunity getOpportunity(){
          Account acc=getAccount();
          insert acc;
          Opportunity opp=new Opportunity(Name= 'testOpportunity - 1',stageName='Working',closeDate = Date.Today().addDays(15),
                                          Opportunity_Lost_Category__c ='Price',Branch__c = '298',
                                          AccountId=acc.id,Valid_Address_Id__c='', Servicing_Branch__c='113');
         return opp;                
    } 
    
    
    public static Lead getLeadWithDeliveryAdd(){
          Lead newLead=new Lead(FirstName = 'Test First', LastName ='Last ',City='city', Street='Street1',
                                 postalCode='BT28 1J' ,Country = 'USA',company='Test Company',Status='Open', phone='1234',
                                 leadSource ='Hot',Auto_Assign_Lead__c = false,Industry='abc',Servicing_Branch_Id__c='113',Branch__c='113',
                                 Delivery_Street__c='123 abc', Delivery_Postal_Code__c='85282',Delivery_Country__c='USA',Delivery_State__c='AZ');
         return newLead;                
    }
    
    public static Job_Profile__c getJobProfile(){
          Job_Profile__c jp = new Job_Profile__c(Name= generateRandomString(8), Job_Site_Address__c = generateRandomString(8), Expected_Completion_Date__c=system.today(), Job_Site_Zip__c='85282',
                                    Job_Site_Country__c='USA' ) ;
         return jp;                
    } 
    
    public static Contact getContact(){
    	  Account Acc = getBusinessAccount();
    	  insert Acc;
          Contact con = new Contact(LastName='ln', AccountId=Acc.Id, Decision_Maker__c='Yes', email='test@tester.com') ;
         return con;                
    }
    public static Product_Brochures_Lookup__c getProductBrochureLookup(){
    	Product_Brochures_Lookup__c productB = new Product_Brochures_Lookup__c();
    	productB.Product_Document_Brochures_Name__c = 'test';
    	productB.Product_Id__c = '10i';
    	productB.Product_Image__c = 'test';
    	
    	return productB;
    }
    
    public static MMI_Quotes__c getQuickQuote(){
    	
    	   Opportunity opp=MMITestDataProvider.getOpportunity();
            insert opp;
    	
           MMI_Quotes__c insertQuote=new MMI_Quotes__c();
   
               insertQuote.Branch_id__c = '209';
                insertQuote.City__c = 'test';
                insertQuote.Name = 'Rental';
                insertQuote.Date_From__c = Date.Today();
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
                insertQuote.Reoccurring_Monthly_Charges__c = 55.0;
                insertQuote.Product__c = '10I';
                insertQuote.QQ_Type__c = 'Rental'; 
         
         return insertQuote;                
    } 
    
    public static List<CustomerActivityParser.quote> getCustomerActivityParserquoteList() {
    	List<CustomerActivityParser.quote> newCustomerActivityParserquoteList = new List<CustomerActivityParser.quote>();
    	CustomerActivityParser.quote newCustomerActivityParserquote = new CustomerActivityParser.quote();
			newCustomerActivityParserquote.quoteNumber = 'test';
			newCustomerActivityParserquote.mobilisation = 1.22;
			newCustomerActivityParserquote.region = '1';
			newCustomerActivityParserquote.quoteCreated = '2013-2-12';
			newCustomerActivityParserquote.quoteDate = '2013-2-12';
			newCustomerActivityParserquote.salesRep = '12546';
			newCustomerActivityParserquote.documentType = 'test';
			newCustomerActivityParserquote.transactionCode = 'OFF';
			newCustomerActivityParserquote.itemDefinitionCode = '2';
			newCustomerActivityParserquote.itemDescription = '23';
			newCustomerActivityParserquote.ecode = '2333';
			newCustomerActivityParserquote.binLocation = 'AZ';
			newCustomerActivityParserquote.price = '123';
			newCustomerActivityParserquote.deliveryCharges = '12';
			newCustomerActivityParserquote.deliverySurcharge = '32';
			newCustomerActivityParserquote.pickupCharges = '34';
			newCustomerActivityParserquote.pickupSurcharge = '323';
			newCustomerActivityParserquote.branchId = '102';
			newCustomerActivityParserquote.productId = '32';
			
			newCustomerActivityParserquoteList.add(newCustomerActivityParserquote);
			
			return newCustomerActivityParserquoteList;

	    }
	    
    
    public static MMI_Full_Quotes__c getnewteMMIFullQuote(){
    	Account accNew = getAccount();
    	insert accNew;
    	Opportunity opp = getOpportunity();
    	insert opp;
          MMI_Full_Quotes__c NewteMMIFullQuote = new MMI_Full_Quotes__c();
          	NewteMMIFullQuote.Opportunity__c = opp.id; 
          	NewteMMIFullQuote.Account__c = accNew.id; 
  			NewteMMIFullQuote.Name = 'rental';
			NewteMMIFullQuote.Quote_Id__c = '106043383';
			NewteMMIFullQuote.Unit_Price__c = 12.00;	
			NewteMMIFullQuote.product__c = '10i'; 
			NewteMMIFullQuote.Mobilization__c = '1.00';
			NewteMMIFullQuote.Transaction_Type__c = 'OFF';
			NewteMMIFullQuote.Write_Up_Rep_Id__c = '98765';
			NewteMMIFullQuote.Write_Up_Rep_Name__c = 'Jennifer Dankovic';
			NewteMMIFullQuote.Assisting_Rep_Id__c = '98765';
			NewteMMIFullQuote.Assisting_Rep_Name__c = 'Jennifer Dankovic';
			NewteMMIFullQuote.Account_Id__c = '10492';
			NewteMMIFullQuote.Account_Name__c = 'ALLEN CONSTRUCTION CO///CCA';        			
			NewteMMIFullQuote.Address_Id__c = '0';
			NewteMMIFullQuote.Billing_Address__c = '326 COOPER STREET BLDG A 1';
			NewteMMIFullQuote.Tax_Exempt__c = true;
			NewteMMIFullQuote.No_Reservation__c = true;
			NewteMMIFullQuote.Invoiced_Balance__c = '120.00'; 
			NewteMMIFullQuote.YTD_Sales__c = '23';
			NewteMMIFullQuote.Last_Invoice__c = '123';
			NewteMMIFullQuote.Status__c = 'Q';	
			NewteMMIFullQuote.Credit_Status__c = 'test';
			NewteMMIFullQuote.Billing_City__c = 'CEDAR HILL';
			NewteMMIFullQuote.Billing_County__c = 'USA';
			NewteMMIFullQuote.Billing_State__c = 'AZ';
			NewteMMIFullQuote.Billing_Country__c = 'USA';
			NewteMMIFullQuote.Billing_Zip_Code__c = '75104-2628';
			NewteMMIFullQuote.Billing_Contact_Id__c = '1';
			NewteMMIFullQuote.Billing_Contact_Name__c = 'gina';
			NewteMMIFullQuote.Billing_Contact_Tel__c = '457854';
			NewteMMIFullQuote.Billing_Contact_Fax__c = '2343432';
			NewteMMIFullQuote.Billing_Contact_Email__c = 'tek@system.com';
			NewteMMIFullQuote.PO_Contact__c = '3454';
		    NewteMMIFullQuote.PO_Expires__c = system.today();
			NewteMMIFullQuote.Credit_Approval__c = 'Yes';
			NewteMMIFullQuote.Tax_Exempt_Authorization__c = '111';
			NewteMMIFullQuote.Quote_Total__c = 'FL'; 
			NewteMMIFullQuote.Fulfilling_Branch_Id__c = '102';  
			NewteMMIFullQuote.Job_or_Location__c = 'test';    
			NewteMMIFullQuote.COD_Instructions__c = 'test';
			NewteMMIFullQuote.Start_Date__c = system.today();
			NewteMMIFullQuote.Quote_expires__c = system.today();
			NewteMMIFullQuote.Rental_Length__c = '2';
			NewteMMIFullQuote.Shipping_Id__c = '1';
			NewteMMIFullQuote.Shipping_Address__c = 'test address';   			
			NewteMMIFullQuote.Shipping_City__c = 'Call he';
			NewteMMIFullQuote.Shipping_County__c = 'USA';
			NewteMMIFullQuote.Shipping_State__c = 'AZ';
			NewteMMIFullQuote.Shipping_Country__c = 'USA';
			NewteMMIFullQuote.Shipping_Zip_Code__c = '75104-2628'; 
			NewteMMIFullQuote.Shipping_Fulfilling_Branch_Id__c = '106';
			NewteMMIFullQuote.Shipping_Fulfilling_Branch_Name__c = 'Dallas';
			NewteMMIFullQuote.Shipping_Cross_Street1__c = 'test';
			NewteMMIFullQuote.Shipping_Cross_Street2__c = 'test';
			NewteMMIFullQuote.Delivery_Contact_Id__c = '1';
			NewteMMIFullQuote.Delivery_Contact_Name__c = 'gian';
			NewteMMIFullQuote.Delivery_Contact_Tel__c = '23434';
			NewteMMIFullQuote.Delivery_Contact_Fax__c = '23434534';
			NewteMMIFullQuote.Delivery_Contact_Email__c = 'teksystm@tek.com';
			NewteMMIFullQuote.Scheduled_Delivery__c = system.today();
			NewteMMIFullQuote.Loaded_Move_In__c = system.today();
			NewteMMIFullQuote.Delivery_Slot__c = 'PM';
			NewteMMIFullQuote.Delivery_Zone__c = 'A';
			NewteMMIFullQuote.Distance_from_Branch__c = 120.332;
			NewteMMIFullQuote.Rental_Charge__c = 12.25;	
			NewteMMIFullQuote.Delivery__c = 125.25;
			NewteMMIFullQuote.LLW__c = 125.2;
			NewteMMIFullQuote.Pickup__c = 58.00;
			NewteMMIFullQuote.Other__c = 34.34;
			NewteMMIFullQuote.Accessories__c = 12.3;
			NewteMMIFullQuote.COD_Amount__c = 54.4;
			NewteMMIFullQuote.Total_COD_Amount__c = 54.4;
			NewteMMIFullQuote.Tax__c = 21.12;
			NewteMMIFullQuote.PPE_Total__c = 43.23;	
			NewteMMIFullQuote.Terms__c = 'testas';
			NewteMMIFullQuote.Terms_Code__c = '233';
			NewteMMIFullQuote.Longitude__c = '12312';
			NewteMMIFullQuote.Latitude__c =  '-232343';
			NewteMMIFullQuote.Tax_id__c = '234121342';
			NewteMMIFullQuote.Shipping_Tax_id__c = '2341245';
			NewteMMIFullQuote.Item_Image_Url__c = 'adfsdf';
          	
          return NewteMMIFullQuote;
    }
    
    
	 public static Full_Quote_Transactional__c getnewFullQuoteTransaction(){
          Full_Quote_Transactional__c newFullQuoteTransaction = new Full_Quote_Transactional__c(
          			 ytdSales__c = '0.00',
					 writeUpRepCommission__c='test',
					 viewDocumentIn__c=true, 
					 type__c='rental', 
					 transactionId__c = 'OFF', 
					 totalCodAmount__c = '427.74', 
					 termsCode__c = 'Monthly Recurri', 
					 tax__c = '32.60', 
					 taxExempt__c = true, 
					 taxExemptAuthorisation__c = 'test', 
					 status__c='NORM', 
					 startDate__c = '2013-11-12', 
					 shippingInstructions__c = 'test', 
					 shippingDate__c = '2013-11-12', 
					 shippingAddress_zoneWarning__c = 'B', 
					 shippingAddress_zipCode__c = '85613', 
					 shippingAddress_taxId__c = '4312345', 
					 shippingAddress_state__c = 'AZ', 
					 shippingAddress_oldPostalCode__c = 'test', 
					 shippingAddress_name__c = 'test', 
					 shippingAddress_longitude__c = '-96.9522', 
					 shippingAddress_latitude__c = '96.9522', 
					 shippingAddress_fulfillingBranchName__c = 'Dallas', 
					 shippingAddress_fulfillingBranchId__c = '106', 
					 shippingAddress_distanceFromBranch__c = '12', 
					 shippingAddress_distanceBranch__c = '2', 
					 shippingAddress_deliveryZone__c = 'A', 
					 shippingAddress_crossStreet2__c = 'test', 
					 shippingAddress_crossStreet1__c = 'test', 
					 shippingAddress_countryId__c = 'USA', 
					 shippingAddress_cityZone__c = 'test', 
					 shippingAddress_address4__c = 'test', 
					 shippingAddress_address3__c = 'test', 
					 shippingAddress_address2__c = 'AZZ', 
					 shippingAddress_address1__c = 'test', 
					 shippingAddressId__c = '0', 
					 salesRep2__c = '98765', 
					 salesRep2Name__c = 'Jennifer Dankovic', 
					 salesRep1__c = '98765', 
					 salesRep1Name__c = 'Jennifer Dankovic', 
					 reservationId__c = 'test', 
					 rentalLength__c = '2', 
					 rentalLengthInProduct__c = 2, 
					 rentalCharge__c = '12.00', 
					 reference__c = '903536095', 
					 quoteTotal__c = 'FI', 
					 quoteExpires__c = '2013-12-12', 
					 portalContact__c ='test', 
					 portalContactEmail__c = 'test@gmail.com', 
					 poRequired__c = 'test', 
					 poExpires__c='2013-12-12',
					 plannedCollectionDate__c = '2013-12-10', 
					 pickUp__c = '12.00',
					 other__c = '12.00', 
					 nscRepCommission__c = '12.00', 
					 narrative2__c = '12', 
					 narrative1__c = 'test', 
					 modifiedTimestamp__c = '1384360856000',
					 mobilization__c = '1.00', 
					 messageDetails__c = 'test', 
					 llw__c = '234', 
					 lastInvoiceDate__c = '2013-08-19', 
					 invoicedBalance__c = '120.20', 
					 instructionText__c = 'test', 
					 homeOwner__c = 'test', 
					 hireTerms__c = 'test',
					 emailPortalLink__c = true,
					 isAddressValidated__c = true,
					 isMainProductAdded__c = true,
					 documentId__c = '102345',
					 delivery__c = '23',
					 customerText1__c = 'abc',
					 creditStatus__c = 'NORM',
					 creditApproval__c='yes',
					 companyId__c = '1',
					 codAmount__c = '234',
					 certificateOfInsurance__c = 'Certificate NOT on file',
					 branchId__c = '106',
					 billingAddress_zoneWarning__c = 'Error',
					 billingAddress_zipCode__c = '587582',
					 billingAddress_taxId__c = '123454',
					 billingAddress_state__c = 'AZ',
					 billingAddress_oldPostalCode__c = '34565',
					 billingAddress_name__c = 'Test acount',
					 billingAddress_longitude__c = '2345',
					 billingAddress_latitude__c = '-12314',
					 billingAddress_fulfillingBranchName__c='test',
					 billingAddress_fulfillingBranchId__c='106',
					 billingAddress_distanceFromBranch__c = '23',
					 billingAddress_distanceBranch__c = '21',
					 billingAddress_deliveryZone__c = '23',
					 billingAddress_crossStreet2__c='test',
					 billingAddress_crossStreet1__c='cross',
					 billingAddress_countryId__c = '1',
					 billingAddress_cityZone__c='TESCO',
					 billingAddress_address4__c = 'ates',
					 billingAddress_address3__c = '23s',
					 billingAddress_address2__c = 'asdfs',
					 billingAddress_address1__c = 'zwsc',
					 billingAddressId__c='1',
					 alreadyRegistered__c = true,
					 account_Name__c = 'teste',
					 accountId__c = '50737',
					 accessories__c='0.00',
					 User_sign__c='test sigm',
					 Transaction_Name__c = 'Rental mobile office',
					 ShippingContactDetails_tel__c = '80825852', 
					 ShippingContactDetails_name__c = 'gina',
					 ShippingContactDetails_mobile__c = '1252421', 
					 ShippingContactDetails_id__c = '1',
					 ShippingContactDetails_fax__c='43532334',
					 ShippingContactDetails_email__c='test@teksystem.com',
					 Name = 'Full Quote Transactional',
					Image_previewQuote__c = 'PreviewQuote_Images/highsecurity.jpg',
					BillingContactDetails_tel__c = '58458623',
					 BillingContactDetails_name__c = 'gina',
					 BillingContactDetails_mobile__c='9036356095',
					 BillingContactDetails_id__c = '1',
					 BillingContactDetails_fax__c = '2548523',
					 BillingContactDetails_email__c = 'testat@telsys.com');
         return newFullQuoteTransaction;                
    } 
     public static Summary_Line__c getnewSummaryLine(){
    	Full_Quote_Transactional__c fullQuoteTra = getnewFullQuoteTransaction();
        insert fullQuoteTra;
        
        Summary_Line__c newSummaryLine = new Summary_Line__c(reference__c = 'test',
		 rate8__c = '0.00', 
		 rate7__c = '0.00',
		 rate5__c = '0.00',
		 rate4__c = '0.00',
		 rate3__c = '0.00',
		 rate2__c = '0.00',
		 rate1__c = '0.00',
		 quantity__c = '1',
		 price__c = '97.00',
		 lockItemCode__c ='2',
		 lineValue__c = '2344',
		 itemId__c = 'CG1',
		 invoiceDiscountApplicable__c = true,
		 ecode__c = '23',
		 description__c = '10 Deluxe door on 1 end',
		 commission2__c = 'test',
		 commission1__c='test',
		 Sequence__c = 1 ,
		 Full_Quote_Transactional__c = fullQuoteTra.id, 
		 ChargeCode_description__c='test1',
		 ChargeCode_active__c = true);
         return newSummaryLine;                
    }  
    public static Summary_Line__c getnewSummaryLine1(){
    	Full_Quote_Transactional__c fullQuoteTra = getnewFullQuoteTransaction();
    	fullQuoteTra.type__c = 'sales';
        insert fullQuoteTra;
        
        Summary_Line__c newSummaryLine = new Summary_Line__c(reference__c = 'test',
		 rate8__c = '0.00', 
		 rate7__c = '0.00',
		 rate5__c = '0.00',
		 rate4__c = '0.00',
		 rate3__c = '0.00',
		 rate2__c = '0.00',
		 rate1__c = '0.00',
		 quantity__c = '1',
		 price__c = '97.00',
		 lockItemCode__c ='2',
		 lineValue__c = '2344',
		 itemId__c = '10i',
		 invoiceDiscountApplicable__c = true,
		 ecode__c = '23',
		 description__c = '10 Deluxe door on 1 end',
		 commission2__c = 'test',
		 commission1__c='test',
		 Sequence__c = 1 ,
		 Full_Quote_Transactional__c = fullQuoteTra.id, 
		 ChargeCode_description__c='test1',
		 ChargeCode_active__c = true);
         return newSummaryLine;                
    }  
    
    public static List<Summary_Line__c> getnewSummaryLineList(){
    	Full_Quote_Transactional__c fullQuoteTra = getnewFullQuoteTransaction();
    	fullQuoteTra.type__c = 'sales';
        insert fullQuoteTra;
        List<Summary_Line__c> newnewSummaryLineList = new List<Summary_Line__c>();
        Summary_Line__c newSummaryLine = new Summary_Line__c(reference__c = 'test',
		 rate8__c = '0.00', 
		 rate7__c = '0.00',
		 rate5__c = '0.00',
		 rate4__c = '0.00',
		 rate3__c = '0.00',
		 rate2__c = '0.00',
		 rate1__c = '0.00',
		 quantity__c = '1',
		 price__c = '97.00',
		 lockItemCode__c ='2',
		 lineValue__c = '2344',
		 itemId__c = '10i',
		 invoiceDiscountApplicable__c = true,
		 ecode__c = '23',
		 description__c = '10 Deluxe door on 1 end',
		 commission2__c = 'test',
		 commission1__c='test',
		 Sequence__c = 1 ,
		 Full_Quote_Transactional__c = fullQuoteTra.id, 
		 ChargeCode_description__c='test1',
		 ChargeCode_active__c = true);
		 newnewSummaryLineList.add(newSummaryLine);
         return newnewSummaryLineList;                
    }  
     
    
    public static Product_Extras__c getnewProductExtras(){
    	Full_Quote_Transactional__c fullQuoteTra = getnewFullQuoteTransaction();
    	fullQuoteTra.type__c = 'rental';
        insert fullQuoteTra;
        
        Product_Extras__c newProductExtras = new Product_Extras__c(mandatory__c = true,
			include__c = true,
			total__c = '115.00',
			rate8__c = '0.00',
			rate7__c = '0.00', 
			rate5__c = '0.00', 
			rate4__c = '0.00', 
			rate3__c = '0.00', 
			rate2__c = '0.00', 
			rate1__c = '0.00', 
			quantity__c = '1', 
			quantityRequired__c = true,
			quantityEditable__c = true,
			price__c = '115.00',
			priceEditable__c = true,
			id__c = 'DELIVERY',
			description__c = 'Delivery Zone',
			Sequence__c = 1,
			Full_Quote_Transactional__c = fullQuoteTra.id);
         return newProductExtras;                
    }  
    
    
    
    
    public static Product_Extras__c getnewProductExtras1(){
    	Full_Quote_Transactional__c fullQuoteTra = getnewFullQuoteTransaction();
    	fullQuoteTra.type__c = 'sales';
        insert fullQuoteTra;
        
        Product_Extras__c newProductExtras = new Product_Extras__c(mandatory__c = true,
			include__c = true,
			total__c = '115.00',
			rate8__c = '0.00',
			rate7__c = '0.00', 
			rate5__c = '0.00', 
			rate4__c = '0.00', 
			rate3__c = '0.00', 
			rate2__c = '0.00', 
			rate1__c = '0.00', 
			quantity__c = '1', 
			quantityRequired__c = true,
			quantityEditable__c = true,
			price__c = '115.00',
			priceEditable__c = true,
			id__c = 'DELIVERY',
			description__c = 'Delivery Zone',
			Sequence__c = 1,
			Full_Quote_Transactional__c = fullQuoteTra.id);
         return newProductExtras;                
    }
    
    public static AdditionalAnalysisSet__c getAdditionalAnalysisSet(){
    	Full_Quote_Transactional__c fullQuoteTra = getnewFullQuoteTransaction();
        insert fullQuoteTra;
        
        AdditionalAnalysisSet__c newAdditionalAnalysisSet = new AdditionalAnalysisSet__c(Name = 'Additional Analysis Set',
			Header_description__c = 'test',
			Header_id__c = 'test',
			Selection_description__c = 'test',
			Selection_id__c = 'DEX',
			Sequence__c = 1,
			Full_Quote_Transactional__c = fullQuoteTra.id);
         return newAdditionalAnalysisSet;                
    }  
    
    public static List<AdditionalAnalysisSet__c> getAdditionalAnalysisSetList(){
    	Full_Quote_Transactional__c fullQuoteTra = getnewFullQuoteTransaction();
        insert fullQuoteTra;
        List<AdditionalAnalysisSet__c> newAdditionalAnalysisSetList = new List<AdditionalAnalysisSet__c>();
        AdditionalAnalysisSet__c newAdditionalAnalysisSet = new AdditionalAnalysisSet__c(Name = 'Additional Analysis Set',
			Header_description__c = 'test',
			Header_id__c = 'test',
			Selection_description__c = 'test',
			Selection_id__c = 'DEX',
			Sequence__c = 1,
			Full_Quote_Transactional__c = fullQuoteTra.id);
			newAdditionalAnalysisSetList .add(newAdditionalAnalysisSet);
         return newAdditionalAnalysisSetList;                
    }  
    
    
    public static AnalysisSet__c getAnalysisSet(){
    	Full_Quote_Transactional__c fullQuoteTra = getnewFullQuoteTransaction();
        insert fullQuoteTra;
        
        AnalysisSet__c newAnalysisSet = new AnalysisSet__c(Name = 'Additional Analysis Set',
			Header_description__c = 'Ad Source',
			Header_id__c = '102',
			Selection_description__c = '360MobileOffice',
			Selection_id__c = '360',
			Sequence__c = 1,
			Full_Quote_Transactional__c = fullQuoteTra.id);
         return newAnalysisSet;                
    }
    
    public static List<AnalysisSet__c> getAnalysisSetList(){
    	Full_Quote_Transactional__c fullQuoteTra = getnewFullQuoteTransaction();
        insert fullQuoteTra;
        List<AnalysisSet__c> newAnalysisSetList = new List<AnalysisSet__c>();
        AnalysisSet__c newAnalysisSet = new AnalysisSet__c(Name = 'Additional Analysis Set',
			Header_description__c = 'Ad Source',
			Header_id__c = '102',
			Selection_description__c = '360MobileOffice',
			Selection_id__c = '360',
			Sequence__c = 1,
			Full_Quote_Transactional__c = fullQuoteTra.id);
			
			newAnalysisSetList.add(newAnalysisSet);
         return newAnalysisSetList;                
    }  
    
      
     public static Weekly_Snapshot_Branch_Report__c getWeeklySnapshotBranchReport(){
    	Full_Quote_Transactional__c fullQuoteTra = getnewFullQuoteTransaction();
        insert fullQuoteTra;
        
        Weekly_Snapshot_Branch_Report__c newWeeklySnapshotBranchReport = new Weekly_Snapshot_Branch_Report__c(Street__c = 'test',
			County__c = 'USA',
			City__c =  'TAX', 
			State__c = 'AZ',
			Zipcode__c = '5845882',
			Country__c = 'USA',
			Servicing_Branch__c = '106 - Dallas');
         return newWeeklySnapshotBranchReport ;                
    } 
    
    public static  Rate__c  getRate(){
        Rate__c newRate = new Rate__c();
        Product_Extras__c newProductExtras = getnewProductExtras1();
        insert newProductExtras;
		
		newRate.Product_Extras__c = newProductExtras.id;
		newRate.description__c = 'USA';
		newRate.editable__c = true;
		newRate.rate__c = '12.00';
		newRate.Sequence__c = 1;
        return newRate;                
    } 
    
    public static List<Rate__c> getRateList(){
    	List<Rate__c> newRateList = new List<Rate__c>();
        Rate__c newRate = new Rate__c();
        Product_Extras__c newProductExtras = getnewProductExtras1();
        insert newProductExtras;
		
		newRate.Product_Extras__c = newProductExtras.id;
		newRate.description__c = 'USA';
		newRate.editable__c = true;
		newRate.rate__c = '12.00';
		newRate.Sequence__c = 1;
		newRateList.add(newRate);
        return newRateList;                
    } 
    
    public static List<accessories__c> getaccessory(){
    	List<accessories__c> newaccessoryList = new List<accessories__c>();
        accessories__c newaccessory = new accessories__c();
		newaccessory.Name = 'access';
		newaccessory.Definition_Code__c = 'test';
		newaccessory.Item_Description__c = 'te4sw';
		newaccessory.Item_Group_Code__c = 'test';
		newaccessory.Item_Type__c = 1;
		newaccessoryList.add(newaccessory);
        return newaccessoryList;                
    } 
    
    public static Standard_Modification__c getStandardModification(){
    	Standard_Modification__c  newStandardModification = new Standard_Modification__c();
    	newStandardModification.ModId__c = 'test';
    	newStandardModification.Modification_Option__c ='458562';
    	newStandardModification.sequence__c = 1;
    	return newStandardModification;
    }
    public static List<Standard_Modification__c> getStandardModificationList(){
    	List<Standard_Modification__c>  newStandardModificationList = new List<Standard_Modification__c>();
    	Standard_Modification__c  newStandardModification = new Standard_Modification__c();
    	newStandardModification.ModId__c = 'test';
    	newStandardModification.Modification_Option__c ='45856';
    	newStandardModification.sequence__c = 1;
    	newStandardModificationList.add(newStandardModification);
    	return newStandardModificationList;
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
    
     public static List<HB_Sales_Inventory__c> getHBSalesInventoryList(){
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
    
     
    
     public static List<Modification_Option_Transactional__c> getModificationOptionTransactionalList(){
    	List<Modification_Option_Transactional__c> newModificationOptionTransactionalList = new List<Modification_Option_Transactional__c>();
        Modification_Option_Transactional__c newModificationOptionTransactional = new Modification_Option_Transactional__c();
		
		Full_Quote_Transactional__c fullQuoteTra = getnewFullQuoteTransaction();
        insert fullQuoteTra;
		/*User  us = getUser();
		us.Alias = 'TESTUR4'; 
		us.username = 'TEST.USER3@TEST.TEST';
		insert us;*/
		
		/*Standard_Modification__c stand = getStandardModification();
		insert stand;*/
		
		newModificationOptionTransactional.Full_Quote_Transactional__c = fullQuoteTra.id;
		newModificationOptionTransactional.ApproverEmail__c = 'tesk@system.com';
		//newModificationOptionTransactional.Approver_User__c =  us.id;
		newModificationOptionTransactional.IsApproved__c = true;
		newModificationOptionTransactional.IsModificationCompleted__c = true;
		newModificationOptionTransactional.Is_Rejected__c = false;
		newModificationOptionTransactional.IsSelected__c = true;
		newModificationOptionTransactional.Is_Submitted__c = false;
		newModificationOptionTransactional.ModId__c = '1234';
		newModificationOptionTransactional.ModificationOptionDesc__c = 'plz appr';
		newModificationOptionTransactional.Quantity__c = 1;
		newModificationOptionTransactional.Sale_Price__c = 122;
		newModificationOptionTransactional.SandForApproval__c = true;
		newModificationOptionTransactional.SenderEmail__c = 'teksystem@teksystem.com';
		newModificationOptionTransactional.Sequence__c = 1;
		newModificationOptionTransactional.SourceID__c = '12313424';
		//newModificationOptionTransactional.Standard_Modification__c = stand.id;
		newModificationOptionTransactional.Submit_Or_Reject_Or_Approved_Time__c = system.today();
		//newModificationOptionTransactional.Submitter_User__c = us.id;
		
		
		newModificationOptionTransactionalList.add(newModificationOptionTransactional);
        return newModificationOptionTransactionalList;                
    } 
    
    public static List<Modification_Approver_List__c> getModificationApproverList(){
    	List<Modification_Approver_List__c> newModificationApproverList = new List<Modification_Approver_List__c>();
    	Modification_Approver_List__c  newModificationApprover = new Modification_Approver_List__c();
    	newModificationApprover.Approver_EmailId__c = 'teksystem@tek.com';
    	newModificationApprover.Approver_Name__c = 'Approval';
    	newModificationApprover.Fulfiling_Branch__c = '106';

		newModificationApproverList.add(newModificationApprover);
    	return newModificationApproverList;
    }
    
    
    
    
    // Full Quote wrepper  
    
    public static  fullquoteWrapper getFullWrapper()
    {   
    	FullQuoteWrapper fullQWrapper=new FullQuoteWrapper();
    	
    	fullQWrapper.unitPriceInvoice = '10.00';
		fullQWrapper.BillDiscountInvoice = '12';
		fullQWrapper.extrasInvoice = '12.00';
		fullQWrapper.deliveryInvoice = '22';
		fullQWrapper.totalInvoice = '1250';
		fullQWrapper.taxInvoice = '12';
		fullQWrapper.SelectedShipingTaxId = '25482212'; 
		fullQWrapper.QouteStatus = 'NORM';
		fullQWrapper.TransactionType  = 'MOBO';
		fullQWrapper.startDate = '2013-2-12';
		fullQWrapper.Quoteexpires = '2013-2-12';
		fullQWrapper.POExpiresdate = '2013-2-12';
		fullQWrapper.LoadedMoveIn = '2013-2-12';
		fullQWrapper.ScheduledDelivery = '2013-2-12';
		fullQWrapper.imageNameForPreivewQuote = 'priveimage';
		fullQWrapper.WriteUpRep  = '98765';
		fullQWrapper.WriteUpRepName  = 'Gaurav Dixit';
		fullQWrapper.AssistingRep  = '98765';
		fullQWrapper.AssistingRepName  = 'Gaurav Dixit';
		fullQWrapper.AccountName  = 'Test';
		fullQWrapper.AccountId  = '50737';
		fullQWrapper.BillingContactID  = '1';
		fullQWrapper.ID  = '50737';
		fullQWrapper.TaxExempt  = true;
		fullQWrapper.Status  = 'U';
		fullQWrapper.Name  = 'Gina';
		fullQWrapper.Name1  = 'Gina';
		fullQWrapper.telePhone  = '985765';
		fullQWrapper.Address  = 'Test';
		fullQWrapper.Fax  = '5878565';
		fullQWrapper.Email  = 'test@teksystem.com';
		fullQWrapper.City  = 'TESCO';
		fullQWrapper.POContact  = '2013-2-12';
		fullQWrapper.Country  = 'USA';
		fullQWrapper.POExpires  = '2013-2-12'; 
		fullQWrapper.State  = 'AZ';
		fullQWrapper.County  = 'USA';	
		fullQWrapper.zipCode  = '856475';
		fullQWrapper.CreditApproval  = 'Trest';
		fullQWrapper.TaxExemptAuthorization  = '111';
		fullQWrapper.JoborLocation  = 'test t';
		fullQWrapper.CODInstructions  = 'tes 2';
		fullQWrapper.QuoteTotal  = '2585';
		fullQWrapper.AdSource  = '245';
		fullQWrapper.CustomerType  = 'Norm';
		fullQWrapper.Deferred  = 'Dell time';
		fullQWrapper.OutsideRep  = '100000';
		fullQWrapper.CertofInsurance  = 'tess'; 
		fullQWrapper.fulFillingBranchInBilling  = '103';
		fullQWrapper.fulFillingBranchNameInBilling  = 'Test';
		fullQWrapper.RentalCharge  = '121';
		fullQWrapper.Terms  = 'true';
		fullQWrapper.PPETotal  = '1252'; 
		fullQWrapper.TermsCode  = '1251';
		fullQWrapper.LLWTotal  = '1254'; 
		fullQWrapper.InvoicedBalance  = '125';
		fullQWrapper.DeliveryFee  = '225';  
		fullQWrapper.LastInvoice  = '2013-2-12'; 
		fullQWrapper.ReturnFee  = '125';
		fullQWrapper.YTDSales  = '12'; 
		fullQWrapper.FuelSurchargeFee  = '123';
		fullQWrapper.LocksTotal  = '34';
		fullQWrapper.Accessories  = '125';
		fullQWrapper.TaxTotal  = '23';
		fullQWrapper.CODAmount  = '23';
		fullQWrapper.TotalCODAmount  = '12';
		fullQWrapper.DeliveryInInvoicing  = '34';
		fullQWrapper.otherInInvoicing  = '4';
		fullQWrapper.ItemCode  = '1oi';
		fullQWrapper.Reference  = 'test';
		fullQWrapper.ImageUrlForPDF = 'asdf';
		fullQWrapper.ECode  = '23';
		fullQWrapper.SuggestedPrice  = '234';
		fullQWrapper.MinPrice  = '12';
		fullQWrapper.NetBookValue  = '234';
		fullQWrapper.sellingPrice  = '345';
		fullQWrapper.assetDescription  = '231';
		fullQWrapper.GradeDescription  = 'test';
		fullQWrapper.ModificationCost  = '345';
		fullQWrapper.showEcodeValues = true;
		fullQWrapper.MMI  = '120';
		fullQWrapper.LengthOfRental  = '2';
		fullQWrapper.InternetCoupon  = '323';
		fullQWrapper.minimumTerm  = '11';
		fullQWrapper.national  = '345';
		fullQWrapper.LockType  = '1';
		fullQWrapper.isLead  = false;
		fullQWrapper.ModificationComments  = '34';
		fullQWrapper.ApproverComments  = '12';
		fullQWrapper.rentalLength  = '2';   	
		fullQWrapper.shippingId  = '1';   	
		fullQWrapper.NameInShippingDates  = 'test';   
		fullQWrapper.deliveryContactId  = '23';
		fullQWrapper.AddressInShippingDates  = '1';
		fullQWrapper.NameInShippingDates1  = 'tds';
		fullQWrapper.cityInShippingDates  = 'tesc';
		fullQWrapper.countyInShippingDates  = 'USA';
		fullQWrapper.stateInShippingDates  = 'AZ';
		fullQWrapper.countryInShippingDates  = 'USA';
		fullQWrapper.fulFillingBranchInShippingDates  = '106';
		fullQWrapper.fulFillingBranchNameInShippingDates  = 'test';
		fullQWrapper.telInShippingDates  = '2343';
		fullQWrapper.faxInShippingDates  = '123123';
		fullQWrapper.emailInShippingDates  = 'atte@teksystem.com';
		fullQWrapper.crossStreetInShippingDates  = '2343';
		fullQWrapper.crossStreet2InShippingDates  = '1sf';
		fullQWrapper.certOfInsurenceInShippingDates  = '234df';
		fullQWrapper.cityZoneInShippingDates  = 'adf';
		fullQWrapper.ZipCodeInShipping  = '58856';	
		fullQWrapper.delTime  = '12pm';
		fullQWrapper.delTimeDesc  = '23';
		fullQWrapper.callFirst  = 'callfirst';
		fullQWrapper.callFirstDesc  = 'cllfidztdes';
		fullQWrapper.noReservation  = false;
		fullQWrapper.doorDir  = 'sdf';
		fullQWrapper.doorDirDesc  = '121';
		fullQWrapper.movementType  = 'test';
		fullQWrapper.movementTypeDesc  = 'adf';
		fullQWrapper.appearance  = 'ad';
		fullQWrapper.deliverySlot  = '25';
		fullQWrapper.distFromBranch  = '123';
		fullQWrapper.deliveryCharge  = '22'; 
		fullQWrapper.pickupCharge  = '234'; 
		fullQWrapper.deliveryInstructions  = 'test sa';
		fullQWrapper.LLWTotalInShipping  = 12.00;
		fullQWrapper.deliveryZoneInShipping  = 'A';
		fullQWrapper.fuelSurchargeInShipping  = 23.00;
		fullQWrapper.isUseBillingAddress  =  true;
		fullQWrapper.productSearchWord  = 'dasd';
		fullQWrapper.ProductType  = 'sales';
		fullQWrapper.ProductSize  = '2';
		fullQWrapper.PrimaryOnly  =true;
		fullQWrapper.deliverySetUp  = '5ad';
		fullQWrapper.returnTearDown  = 'tes';
		fullQWrapper.SideRollDoors  = true;
	    fullQWrapper.EndRollDoors  = true; 
	    fullQWrapper.RecordStorage  = true;
	    fullQWrapper.HighCubes  = true;
	    fullQWrapper.Shelving  = true;
	    fullQWrapper.rentalLengthInProduct  = '1252'; 			
		fullQWrapper.isCapacityReservedDurinEdit  = false;
		fullQWrapper.analysisSetSelectedId  = 'atesas';		
		fullQWrapper.isSalesRep = true;
		fullQWrapper.sourceId  = '25452';
		
		fullQWrapper.showValidateAddressPopUp = true;
    	fullQWrapper.showValidateAddressShippingPopUp = true;
    	fullQWrapper.showTaxIdShippingPopUp = true;
    	fullQWrapper.showTaxIdBillingPopUp = true;
        fullQWrapper.showBranchPopUp = true;
        fullQWrapper.addressPopUp = true;
    	fullQWrapper.shippingAddressPopUp = true;
    	fullQWrapper.showAccountPopUp = true;
    	fullQWrapper.showEcodePopUp = true;
    	fullQWrapper.contactShippingPopUp = true;
    	fullQWrapper.showAnalysisCodePopup = true;
    	fullQWrapper.contactPopup = true;
    	fullQWrapper.showEditProduct = true;
    	fullQWrapper.showMinimumTermPopUp = true;
    	fullQWrapper.showAnalysisCodePopupInProduct = true;
    	fullQWrapper.showBranchBillingPopUp = true;
    	fullQWrapper.showAnalysisCodeShippingPopup = true;
    	fullQWrapper.showErrorPopUp = true;
    	fullQWrapper.showSearchBranchIdTable = true;
    	fullQWrapper.showSearchBranchShippingIdTable = true;
    	fullQWrapper.showSearchAnalysisSetCodeInBilling = true;
    	fullQWrapper.showSearchAnalysisSetCodeInShipping = true;
    	fullQWrapper.showSearchChargeCodeList = true;
    	fullQWrapper.showWriteUpRepSearchList = true;
    	fullQWrapper.showAssistingRepSearchList = true;
    	fullQWrapper.showContactSearchInBilling = true;
    	fullQWrapper.showContactSearchInShipping = true;
    	fullQWrapper.enable1Period = true;
    	fullQWrapper.enable2To6Period = true;
    	fullQWrapper.enable7To12Period = true;
    	fullQWrapper.enable13Period = true;  
    	fullQWrapper.enableVAddresBtnInBilling = true;
    	fullQWrapper.enableRefreshQuote = true;
    	fullQWrapper.enableSaveQuote = true;
    	fullQWrapper.convertQuoteToOrder = true;
    	fullQWrapper.enableProductadd = true;
    	fullQWrapper.enableVAddresBtnInShipping = true;
    	fullQWrapper.enableMarkAsLostButton = true;	  
    	fullQWrapper.fullfillingBranch = true;
		fullQWrapper.invoiceTabEnableDis = true;
    	fullQWrapper.startDateonchange = true;
    	fullQWrapper.analysisSetHeadValue = true;
    	fullQWrapper.isBillingAddressValidated = true;
    	fullQWrapper.isShippingAddressValidated = true;  	
	 	fullQWrapper.showCapacityLookupPopup = true;
	 	fullQWrapper.selectedFullQUote = 'Rental';
		fullQWrapper.showSalesfleet = true;
		fullQWrapper.showSalesRepPopup = true;
	  	fullQWrapper.reserveCapacityId = 'true';
        fullQWrapper.showReserveCapacityId = true;
     	fullQWrapper.showOrderPopUp  = true;
     	fullQWrapper.OrderMessage  = 'true';
     	fullQWrapper.orderQuoteId  = 'test';
     	fullQWrapper.orderContractId  = 'test';
 		fullQWrapper.showCapacityPopUp  = true;
   		fullQWrapper.ifCapacityYes  = true; 
       		
        return fullQWrapper;
    } 
    public static FullQuoteWrapper.lockTypesAndQuantity getFullQuoteWrplockTypesAndQuantity(){
    		FullQuoteWrapper.lockTypesAndQuantity newFullQuoteWrplockTypesAndQuantity = new FullQuoteWrapper.lockTypesAndQuantity();
    		
    		newFullQuoteWrplockTypesAndQuantity.LockName = 'test';
            newFullQuoteWrplockTypesAndQuantity.LockDescription = '234';
            newFullQuoteWrplockTypesAndQuantity.isLockselected = true;
            newFullQuoteWrplockTypesAndQuantity.lockQuantity = 1;
            newFullQuoteWrplockTypesAndQuantity.LockPrice ='123';
            
            return newFullQuoteWrplockTypesAndQuantity;
            
    }
    public static FullQuoteWrapper.stateInnerClass getFullQuoteWrpstateInnerClass(){
    	FullQuoteWrapper.stateInnerClass newFullQuoteWrpstateInnerClass = new FullQuoteWrapper.stateInnerClass();
    	
    		newFullQuoteWrpstateInnerClass.companyId = 'USA';
            newFullQuoteWrpstateInnerClass.countryId = 'USA';
            newFullQuoteWrpstateInnerClass.Id = 'AZ';
            newFullQuoteWrpstateInnerClass.Name = 'AZ';
            
            return newFullQuoteWrpstateInnerClass;
    }
    public static FullQuoteWrapper.AddressInnerClass getFullQuoteWrpAddressInnerClass(){
    	FullQuoteWrapper.AddressInnerClass newFullQuoteWrpAddressInnerClass = new FullQuoteWrapper.AddressInnerClass();
	    	newFullQuoteWrpAddressInnerClass.Id = 'test';
	        newFullQuoteWrpAddressInnerClass.taxAreaStatus  = 'test'; 
	        newFullQuoteWrpAddressInnerClass.country  = 'USA';
	        newFullQuoteWrpAddressInnerClass.countryDescription  = 'USA'; 
	        newFullQuoteWrpAddressInnerClass.country1  = '1';
	        newFullQuoteWrpAddressInnerClass.state  = 'AZ';
	        newFullQuoteWrpAddressInnerClass.stateDescription  = 'AZ'; 
	        newFullQuoteWrpAddressInnerClass.city  = 'TESCO';
	        newFullQuoteWrpAddressInnerClass.isSelected  = true;
	        newFullQuoteWrpAddressInnerClass.RecUniqId  = 1;

	        return newFullQuoteWrpAddressInnerClass;
    }
    
    public static FullQuoteWrapper.DescarteInnerClass getFullQuoteWrpDescarte(){
    	FullQuoteWrapper.DescarteInnerClass newFullQuoteWrpDescarte = new FullQuoteWrapper.DescarteInnerClass();
    	
	    	newFullQuoteWrpDescarte.companyId = '1';       
	        newFullQuoteWrpDescarte.branchId = '2';
	        newFullQuoteWrpDescarte.address1 ='test';
	        newFullQuoteWrpDescarte.address2 ='test2';
	        newFullQuoteWrpDescarte.address3  = 'tesk';
	        newFullQuoteWrpDescarte.address4  = 'Washington';
	        newFullQuoteWrpDescarte.countryId ='USA';
	        newFullQuoteWrpDescarte.state ='AZ';
	        newFullQuoteWrpDescarte.zipCode ='20521-2050';
	        newFullQuoteWrpDescarte.crossStreet1 ='test';
	        newFullQuoteWrpDescarte.crossStreet2 ='test2';
	        newFullQuoteWrpDescarte.taxId ='2342534';
	        newFullQuoteWrpDescarte.distanceFromBranch = '106'; 
	        newFullQuoteWrpDescarte.deliveryZone ='A';
	        newFullQuoteWrpDescarte.zoneWarning ='error';
	        newFullQuoteWrpDescarte.latitude ='-123123';
	        newFullQuoteWrpDescarte.longitude ='23434';
	        newFullQuoteWrpDescarte.distanceBranch ='74';
	        newFullQuoteWrpDescarte.fulfillingBranch ='106';
	        newFullQuoteWrpDescarte.fulfillingBranchName ='Gina';
	        newFullQuoteWrpDescarte.oldPostalCode ='20521-2050';
	        newFullQuoteWrpDescarte.isSelected = true; 
	        newFullQuoteWrpDescarte.RecUniqId  = 124585;
	        
     
    	return newFullQuoteWrpDescarte;
    	
    } 
    public static FullQuoteWrapper.stdModification getFullQuoteWrpstdModification(){
    		
    		FullQuoteWrapper.stdModification newFullQuoteWrpstdModification = new FullQuoteWrapper.stdModification();
    		
    		newFullQuoteWrpstdModification.modId  = '1';
            newFullQuoteWrpstdModification.price  = '123';
            newFullQuoteWrpstdModification.modificationOption  = 'test';
            newFullQuoteWrpstdModification.isSelected  = true;
            newFullQuoteWrpstdModification.Quantity  = '1';
            newFullQuoteWrpstdModification.isSubmmited  = true;
            newFullQuoteWrpstdModification.isApproved  = true;
            newFullQuoteWrpstdModification.isRejected  = false;
            newFullQuoteWrpstdModification.Submitter  = 'test';
            newFullQuoteWrpstdModification.Approver  = 'yes';
            newFullQuoteWrpstdModification.WorkflowActionDateTime  = system.today(); 
            newFullQuoteWrpstdModification.WorkflowStatus  = 'test';
            newFullQuoteWrpstdModification.isModificationCompleted  = true; 
            newFullQuoteWrpstdModification.sequence  = 1;
            newFullQuoteWrpstdModification.sourceID  = '234';
            
            return newFullQuoteWrpstdModification;
    }
    
    public static List<FullQuoteWrapper.stdModification> getFullQuoteWrpstdModificationList(){
    		List<FullQuoteWrapper.stdModification> newFullQuoteWrpstdModificationList = new List<FullQuoteWrapper.stdModification>();
    		FullQuoteWrapper.stdModification newFullQuoteWrpstdModification = new FullQuoteWrapper.stdModification();
    		
    		newFullQuoteWrpstdModification.modId  = 'test';
            newFullQuoteWrpstdModification.price  = '123';
            newFullQuoteWrpstdModification.modificationOption  = 'test';
            newFullQuoteWrpstdModification.isSelected  = true;
            newFullQuoteWrpstdModification.Quantity  = '1';
            newFullQuoteWrpstdModification.isSubmmited  = true;
            newFullQuoteWrpstdModification.isApproved  = true;
            newFullQuoteWrpstdModification.isRejected  = false;
            newFullQuoteWrpstdModification.Submitter  = 'test';
            newFullQuoteWrpstdModification.Approver  = 'yes';
            newFullQuoteWrpstdModification.WorkflowActionDateTime  = system.today(); 
            newFullQuoteWrpstdModification.WorkflowStatus  = 'test';
            newFullQuoteWrpstdModification.isModificationCompleted  = true; 
            newFullQuoteWrpstdModification.sequence  = 1;
            newFullQuoteWrpstdModification.sourceID  = '234';
        	
        	newFullQuoteWrpstdModificationList.add(newFullQuoteWrpstdModification);    
            return newFullQuoteWrpstdModificationList;
    }
    
    public static FullQuoteWrapper.ApproverList getFullQuoteWrpApproverList(){
    		FullQuoteWrapper.ApproverList newFullQuoteWrpApproverList = new FullQuoteWrapper.ApproverList();
    		newFullQuoteWrpApproverList.emailID  = 'tes@teksystem.com';
            newFullQuoteWrpApproverList.fulfillingBranch  =  '102';
            newFullQuoteWrpApproverList.name  = 'testing';
            newFullQuoteWrpApproverList.recId  = 12345;
            
            return newFullQuoteWrpApproverList ;
            
    }
    public static FullQuoteWrapper.quote getFullQuoteWrpquote(){
    		FullQuoteWrapper.quote newFullQuoteWrpquote = new FullQuoteWrapper.quote();
    		newFullQuoteWrpquote.quoteNumber = '1232';
			newFullQuoteWrpquote.mobilisation = 23.00;
			newFullQuoteWrpquote.region = 'twse';
			newFullQuoteWrpquote.quoteCreated = '2013-2-12';
			newFullQuoteWrpquote.quoteDate = '2013-2-12';
			newFullQuoteWrpquote.salesRep = '98765';
			newFullQuoteWrpquote.documentType = 'tes';
			newFullQuoteWrpquote.transactionCode = 'OFF';
			newFullQuoteWrpquote.itemDefinitionCode = 'yes';
			newFullQuoteWrpquote.itemDescription = 'ad';
			newFullQuoteWrpquote.ecode = '23';
			newFullQuoteWrpquote.binLocation = '234'; 
			newFullQuoteWrpquote.price = '234';
			newFullQuoteWrpquote.deliveryCharges = '123'; 
			newFullQuoteWrpquote.deliverySurcharge =  '345';
			newFullQuoteWrpquote.pickupCharges = '456';
			newFullQuoteWrpquote.pickupSurcharge = '235';
			newFullQuoteWrpquote.branchId = '123';
			newFullQuoteWrpquote.productId =  '10i';
			newFullQuoteWrpquote.deliveryRate = '35';
			newFullQuoteWrpquote.pickupRate = '4';
			newFullQuoteWrpquote.activationDate = '2013-2-12';
			
			return newFullQuoteWrpquote;
    }
    public static List<FullQuoteWrapper.quote> getFullQuoteWrpquoteList(){
    	List<FullQuoteWrapper.quote> newFullQuoteWrpquoteList = new List<FullQuoteWrapper.quote>();
    		FullQuoteWrapper.quote newFullQuoteWrpquote = new FullQuoteWrapper.quote();
    		newFullQuoteWrpquote.quoteNumber = '1232';
			newFullQuoteWrpquote.mobilisation = 23.00;
			newFullQuoteWrpquote.region = 'twse';
			newFullQuoteWrpquote.quoteCreated = '2013-2-10';
			newFullQuoteWrpquote.quoteDate = '2013-2-12';
			newFullQuoteWrpquote.salesRep = '98765';
			newFullQuoteWrpquote.documentType = 'tes';
			newFullQuoteWrpquote.transactionCode = 'OFF';
			newFullQuoteWrpquote.itemDefinitionCode = 'yes';
			newFullQuoteWrpquote.itemDescription = 'ad';
			newFullQuoteWrpquote.ecode = '23';
			newFullQuoteWrpquote.binLocation = '234'; 
			newFullQuoteWrpquote.price = '234';
			newFullQuoteWrpquote.deliveryCharges = '123'; 
			newFullQuoteWrpquote.deliverySurcharge =  '345';
			newFullQuoteWrpquote.pickupCharges = '456';
			newFullQuoteWrpquote.pickupSurcharge = '235';
			newFullQuoteWrpquote.branchId = '123';
			newFullQuoteWrpquote.productId =  '10i';
			newFullQuoteWrpquote.deliveryRate = '35';
			newFullQuoteWrpquote.pickupRate = '4';
			newFullQuoteWrpquote.activationDate = '2013-2-10';
			newFullQuoteWrpquoteList .add( newFullQuoteWrpquote);
			
			FullQuoteWrapper.quote newFullQuoteWrpquote2 = new FullQuoteWrapper.quote();
    		newFullQuoteWrpquote2.quoteNumber = '1232';
			newFullQuoteWrpquote2.mobilisation = 23.00;
			newFullQuoteWrpquote2.region = 'twse';
			newFullQuoteWrpquote2.quoteCreated = '2013-2-11';
			newFullQuoteWrpquote2.quoteDate = '2013-2-12';
			newFullQuoteWrpquote2.salesRep = '98765';
			newFullQuoteWrpquote2.documentType = 'tes';
			newFullQuoteWrpquote2.transactionCode = 'OFF';
			newFullQuoteWrpquote2.itemDefinitionCode = 'yes';
			newFullQuoteWrpquote2.itemDescription = 'ad';
			newFullQuoteWrpquote2.ecode = '23';
			newFullQuoteWrpquote2.binLocation = '234'; 
			newFullQuoteWrpquote2.price = '234';
			newFullQuoteWrpquote2.deliveryCharges = '123'; 
			newFullQuoteWrpquote2.deliverySurcharge =  '345';
			newFullQuoteWrpquote2.pickupCharges = '456';
			newFullQuoteWrpquote2.pickupSurcharge = '235';
			newFullQuoteWrpquote2.branchId = '123';
			newFullQuoteWrpquote2.productId =  '10i';
			newFullQuoteWrpquote2.deliveryRate = '35';
			newFullQuoteWrpquote2.pickupRate = '4';
			newFullQuoteWrpquote2.activationDate = '2013-2-11';
			newFullQuoteWrpquoteList .add( newFullQuoteWrpquote2);
			
			FullQuoteWrapper.quote newFullQuoteWrpquote3 = new FullQuoteWrapper.quote();
    		newFullQuoteWrpquote3.quoteNumber = '1232';
			newFullQuoteWrpquote3.mobilisation = 23.00;
			newFullQuoteWrpquote3.region = 'twse';
			newFullQuoteWrpquote3.quoteCreated = '2013-2-12';
			newFullQuoteWrpquote3.quoteDate = '2013-2-12';
			newFullQuoteWrpquote3.salesRep = '98765';
			newFullQuoteWrpquote3.documentType = 'tes';
			newFullQuoteWrpquote3.transactionCode = 'OFF';
			newFullQuoteWrpquote3.itemDefinitionCode = 'yes';
			newFullQuoteWrpquote3.itemDescription = 'ad';
			newFullQuoteWrpquote3.ecode = '23';
			newFullQuoteWrpquote3.binLocation = '234'; 
			newFullQuoteWrpquote3.price = '234';
			newFullQuoteWrpquote3.deliveryCharges = '123'; 
			newFullQuoteWrpquote3.deliverySurcharge =  '345';
			newFullQuoteWrpquote3.pickupCharges = '456';
			newFullQuoteWrpquote3.pickupSurcharge = '235';
			newFullQuoteWrpquote3.branchId = '123';
			newFullQuoteWrpquote3.productId =  '10i';
			newFullQuoteWrpquote3.deliveryRate = '35';
			newFullQuoteWrpquote3.pickupRate = '4';
			newFullQuoteWrpquote3.activationDate = '2013-2-12';
			newFullQuoteWrpquoteList .add( newFullQuoteWrpquote3);
			return newFullQuoteWrpquoteList;
    }
    
    public static FullQuoteWrapper.ProductSales getFullQuoteWrpProductSales(){
    	FullQuoteWrapper.ProductSales newFullQuoteWrpProductSales = new FullQuoteWrapper.ProductSales();
    	
    		newFullQuoteWrpProductSales.area = 'tes';
			newFullQuoteWrpProductSales.blowout = 'tes';
			newFullQuoteWrpProductSales.companyId = '1';
			newFullQuoteWrpProductSales.displayPicture = 'link'; 
			newFullQuoteWrpProductSales.eCode = '23';
			newFullQuoteWrpProductSales.fulfillingBranchCode ='106'; 
			newFullQuoteWrpProductSales.gradeCode = '345';
			newFullQuoteWrpProductSales.gradeDescription = 'tesste'; 
			newFullQuoteWrpProductSales.itemRef =  '43';
			newFullQuoteWrpProductSales.lineItemID = '1';
			newFullQuoteWrpProductSales.minimumPrice = 25.20; 
			newFullQuoteWrpProductSales.nbv = 20.00;
			newFullQuoteWrpProductSales.notes = 'tesadf note';
			newFullQuoteWrpProductSales.reasonCode = '234';
			newFullQuoteWrpProductSales.status = 'NORM';
			newFullQuoteWrpProductSales.suggestedPrice =12.05; 
			newFullQuoteWrpProductSales.recId = 1;
			
    	return newFullQuoteWrpProductSales ;
    }
    
    public static List<FullQuoteWrapper.ProductSales> getFullQuoteWrpProductSalesList(){
    	List<FullQuoteWrapper.ProductSales> newFullQuoteWrpProductSalesList = new List<FullQuoteWrapper.ProductSales>();
    	FullQuoteWrapper.ProductSales newFullQuoteWrpProductSales = new FullQuoteWrapper.ProductSales();
    	
    		newFullQuoteWrpProductSales.area = 'tes';
			newFullQuoteWrpProductSales.blowout = 'tes';
			newFullQuoteWrpProductSales.companyId = '1';
			newFullQuoteWrpProductSales.displayPicture = 'link'; 
			newFullQuoteWrpProductSales.eCode = '23';
			newFullQuoteWrpProductSales.fulfillingBranchCode ='106'; 
			newFullQuoteWrpProductSales.gradeCode = '345';
			newFullQuoteWrpProductSales.gradeDescription = 'tesste'; 
			newFullQuoteWrpProductSales.itemRef =  '43';
			newFullQuoteWrpProductSales.lineItemID = '1';
			newFullQuoteWrpProductSales.minimumPrice = 25.20; 
			newFullQuoteWrpProductSales.nbv = 20.00;
			newFullQuoteWrpProductSales.notes = 'tesadf note';
			newFullQuoteWrpProductSales.reasonCode = '234';
			newFullQuoteWrpProductSales.status = 'NORM';
			newFullQuoteWrpProductSales.suggestedPrice =12.05; 
			newFullQuoteWrpProductSales.recId = 1;
			
			newFullQuoteWrpProductSalesList .add(newFullQuoteWrpProductSales );		
    	return newFullQuoteWrpProductSalesList;
    }
    
    public static FullQuoteWrapper.SalesImages getFullQuoteWrpSalesImages(){
    	FullQuoteWrapper.SalesImages newFullQuoteWrpSalesImages = new FullQuoteWrapper.SalesImages();
    		
    		newFullQuoteWrpSalesImages.imageURL = 'url link'; 
			newFullQuoteWrpSalesImages.perentId = '1';
			newFullQuoteWrpSalesImages.sfdcRecId = 'test';
			
    	return newFullQuoteWrpSalesImages;
    }
    public static FullQuoteWrapper.NewCustomerAccount getFullQuoteWrpNewCustomerAccount(){
    	FullQuoteWrapper.NewCustomerAccount newFullQuoteWrpNewCustomerAccount = new FullQuoteWrapper.NewCustomerAccount();

			newFullQuoteWrpNewCustomerAccount.name = 'test';
			newFullQuoteWrpNewCustomerAccount.invoicedBalance ='123'; 
			newFullQuoteWrpNewCustomerAccount.lastInvoiceDate = '234';
			newFullQuoteWrpNewCustomerAccount.taxExemptionCertificate ='111';  
			newFullQuoteWrpNewCustomerAccount.taxExempt = 'test';
			newFullQuoteWrpNewCustomerAccount.creditStatus = 'Norm';
			newFullQuoteWrpNewCustomerAccount.duplicateNo = '1';
			newFullQuoteWrpNewCustomerAccount.dateCreated = '2013-2-12';
			newFullQuoteWrpNewCustomerAccount.createdBy = 'user';
			newFullQuoteWrpNewCustomerAccount.status = 'U';
			newFullQuoteWrpNewCustomerAccount.phoneNumber ='23453'; 
			newFullQuoteWrpNewCustomerAccount.salesforceId = 'testete';
			newFullQuoteWrpNewCustomerAccount.addressType = 'test';
			newFullQuoteWrpNewCustomerAccount.accountType = 'nor';
			newFullQuoteWrpNewCustomerAccount.id = '50737';
			newFullQuoteWrpNewCustomerAccount.ytdSales = '3454';
			newFullQuoteWrpNewCustomerAccount.addressNo = '1'; 
			newFullQuoteWrpNewCustomerAccount.addressLine1 = 'test'; 
			newFullQuoteWrpNewCustomerAccount.addressLine2 = 'test';
			newFullQuoteWrpNewCustomerAccount.addressLine3 = 'test';
			newFullQuoteWrpNewCustomerAccount.addressLine4 = 'test';
			newFullQuoteWrpNewCustomerAccount.state = 'AZ';
			newFullQuoteWrpNewCustomerAccount.countryId = 'USA';
			newFullQuoteWrpNewCustomerAccount.zipCode = '586856';
			newFullQuoteWrpNewCustomerAccount.recId  = 1; 
			return newFullQuoteWrpNewCustomerAccount;
    }
    public static FullQuoteWrapper.productTypes getFullQuoteWrpproductTypes(){
    	FullQuoteWrapper.productTypes newFullQuoteWrpproductTypes = new FullQuoteWrapper.productTypes();
		 
		newFullQuoteWrpproductTypes.isSelected = true;
        newFullQuoteWrpproductTypes.productType = 'mobo';
        newFullQuoteWrpproductTypes.RecUniqId  =  1; 
        
        return newFullQuoteWrpproductTypes;
        
    }
    public static FullQuoteWrapper.productSizes getFullQuoteWrpproductSizes(){
    	FullQuoteWrapper.productSizes newFullQuoteWrpproductSizes = new FullQuoteWrapper.productSizes();
    	
    	newFullQuoteWrpproductSizes.isSelected = true;
        newFullQuoteWrpproductSizes.productSize = 'test';
        newFullQuoteWrpproductSizes.RecUniqId  =  1;
        
        return newFullQuoteWrpproductSizes;
    }
    
     public static HomeBaseBeans.CreateFullQuoteResponse getHomeBaseBeansCreateFullQuoteResponse(){
    	HomeBaseBeans.CreateFullQuoteResponse newHomeBaseBeansCreateFullQuoteResponse = new HomeBaseBeans.CreateFullQuoteResponse(); 
    	
	    	newHomeBaseBeansCreateFullQuoteResponse.companyId ='1';
			newHomeBaseBeansCreateFullQuoteResponse.documentId = '102';
			newHomeBaseBeansCreateFullQuoteResponse.type ='sales';
			newHomeBaseBeansCreateFullQuoteResponse.mobilization ='1';
			newHomeBaseBeansCreateFullQuoteResponse.errorMessage ='';
        
        return newHomeBaseBeansCreateFullQuoteResponse;
    }
    
    public static List<HomeBaseBeans.SalesFleets> getHomeBaseBeansSalesFleetsList(){
		List<HomeBaseBeans.SalesFleets> newHomeBaseBeansSalesFleetsList = new List<HomeBaseBeans.SalesFleets>();
		HomeBaseBeans.SalesFleets newHomeBaseBeansSalesFleets = new HomeBaseBeans.SalesFleets();
		newHomeBaseBeansSalesFleets.productId ='10i';
        newHomeBaseBeansSalesFleets.productDescription ='main prod';
        newHomeBaseBeansSalesFleets.ecode ='12';
        newHomeBaseBeansSalesFleets.reference ='23';
        newHomeBaseBeansSalesFleets.ImageUrl ='testur';
        newHomeBaseBeansSalesFleets.grade ='1';
        newHomeBaseBeansSalesFleets.suggestedPrice = '102';
        newHomeBaseBeansSalesFleets.minimumPrice ='12';
        newHomeBaseBeansSalesFleets.netBookValue ='23';
        newHomeBaseBeansSalesFleets.commissionBonusReason ='123';
        newHomeBaseBeansSalesFleets.notes ='test note';
        newHomeBaseBeansSalesFleets.errorMessage = '';
		    	 
		newHomeBaseBeansSalesFleetsList.add(newHomeBaseBeansSalesFleets);
        return newHomeBaseBeansSalesFleetsList;
    }
    
    public static List<HomeBaseBeans.allocations> getHomeBaseBeansallocationsList(){
		List<HomeBaseBeans.allocations> newHomeBaseBeansallocationsList = new List<HomeBaseBeans.allocations>();
		HomeBaseBeans.allocations newHomeBaseBeansallocations  = new HomeBaseBeans.allocations();
		
			newHomeBaseBeansallocations.ecode = '23232';
			newHomeBaseBeansallocations.reference = 'tes';
			newHomeBaseBeansallocations.status = 'norm';
			newHomeBaseBeansallocations.availableDate = '2013-12-12';
			newHomeBaseBeansallocations.sale = '23';
			newHomeBaseBeansallocations.reserved = '232';
			newHomeBaseBeansallocations.allocated = '2323';
			newHomeBaseBeansallocations.sell = '23';
			newHomeBaseBeansallocations.agedMonths ='1' ;
			newHomeBaseBeansallocations.cost = '23';
			newHomeBaseBeansallocations.price = '121';
			newHomeBaseBeansallocations.discount = '121';
			newHomeBaseBeansallocations.netBookValue = '121';
			newHomeBaseBeansallocations.pickUp = '123';
			newHomeBaseBeansallocations.reRented = '123';
     		newHomeBaseBeansallocations.errorMessage = '';
		    	 
		newHomeBaseBeansallocationsList .add(newHomeBaseBeansallocations);
        return newHomeBaseBeansallocationsList;
    }
    
    public static HomeBaseBeans.ProspectAccountParam getHomeBaseBeansProspectAccountParam(){
		HomeBaseBeans.ProspectAccountParam newHomeBaseBeansProspectAccountParam  = new HomeBaseBeans.ProspectAccountParam();
		
			newHomeBaseBeansProspectAccountParam.companyName ='test';
	   		newHomeBaseBeansProspectAccountParam.salesforceID = '987654';
	   		newHomeBaseBeansProspectAccountParam.contactName = 'gina';
	   		newHomeBaseBeansProspectAccountParam.address1 = 'test 1';
	   		newHomeBaseBeansProspectAccountParam.city = 'tesco';
	   		newHomeBaseBeansProspectAccountParam.state  = 'AZ'; 
	   		newHomeBaseBeansProspectAccountParam.zip  = '85705';
	   		newHomeBaseBeansProspectAccountParam.Country  = 'USA';
	   		newHomeBaseBeansProspectAccountParam.phone1  = '9036356095';
	   		newHomeBaseBeansProspectAccountParam.repCode  = '232';
	   		newHomeBaseBeansProspectAccountParam.branchCode  = '102';
		    	 
        return newHomeBaseBeansProspectAccountParam  ;
    }
    
    public static HomeBaseBeans.capacityLookupRequest getHomeBaseBeanscapacityLookupRequest(){
		HomeBaseBeans.capacityLookupRequest newHomeBaseBeanscapacityLookupRequest  = new HomeBaseBeans.capacityLookupRequest();
     
			newHomeBaseBeanscapacityLookupRequest.itemName ='10i';
	   		newHomeBaseBeanscapacityLookupRequest.addressLine1 = 'test';
	   		newHomeBaseBeanscapacityLookupRequest.city = 'tesco';
	   		newHomeBaseBeanscapacityLookupRequest.countryCode ='USA';
	   		newHomeBaseBeanscapacityLookupRequest.postalCode ='85705';
	   		newHomeBaseBeanscapacityLookupRequest.stateCode ='AZ';
	   		newHomeBaseBeanscapacityLookupRequest.crossStreet1 ='tset1';
	   		newHomeBaseBeanscapacityLookupRequest.crossStreet2  ='test2';
	   		newHomeBaseBeanscapacityLookupRequest.itemDescription ='10i des';
	   		newHomeBaseBeanscapacityLookupRequest.volume ='12';
	   		newHomeBaseBeanscapacityLookupRequest.sellingStoreNumber = '232'; 
	   		newHomeBaseBeanscapacityLookupRequest.longitude  ='1212';
	        newHomeBaseBeanscapacityLookupRequest.latitude  ='2323';
	        newHomeBaseBeanscapacityLookupRequest.BranchId  ='106';
	        newHomeBaseBeanscapacityLookupRequest.DeliveryDateTime ='2014-1-1'; 
    
        return newHomeBaseBeanscapacityLookupRequest  ;
    }
    
    
    
    
     
    public static List<HomeBaseBeans.Products> getHomeBaseBeansProductsList(){
    	List<HomeBaseBeans.Products> newHomeBaseBeansProductsList = new List<HomeBaseBeans.Products>();
    	HomeBaseBeans.Products newHomeBaseBeansProducts = new HomeBaseBeans.Products();
    	newHomeBaseBeansProducts.Id  = '10i';
        newHomeBaseBeansProducts.Description = '10i test';
        newHomeBaseBeansProducts.qtyAvail = '1';
        newHomeBaseBeansProducts.qtyFree ='1232'; 
        newHomeBaseBeansProducts.qtyWip = '1';  
        newHomeBaseBeansProducts.qtyWip1 = '1';  
        newHomeBaseBeansProducts.qtyWip2 = '1';  
        newHomeBaseBeansProducts.qtyWip3 = '1';  
        newHomeBaseBeansProducts.qtyWip4 = '1';  
        newHomeBaseBeansProducts.qtyWip5 = '1';  
        newHomeBaseBeansProducts.qtyWip6 = '1';  
        newHomeBaseBeansProducts.qtyWip7 = '1';  
        newHomeBaseBeansProducts.qtyWip8 = '1';  
        newHomeBaseBeansProducts.qtyWip9 = '1';  
        newHomeBaseBeansProducts.qtyWip10 = '1';  
        newHomeBaseBeansProducts.HILRM = 'test'; 	
        newHomeBaseBeansProducts.qtyRented = '1';  
        newHomeBaseBeansProducts.UtilPercent = '112';  
        newHomeBaseBeansProducts.thumbnailUrl = '1tes';  
        newHomeBaseBeansProducts.qtyReserved = '1';  
        newHomeBaseBeansProducts.qtyTotal = '100';  
        newHomeBaseBeansProducts.commission1 = '12';  
        newHomeBaseBeansProducts.commission2 = '18';  
        newHomeBaseBeansProducts.commission3 = '18';  
        newHomeBaseBeansProducts.commission4 = '18';        
        newHomeBaseBeansProducts.llw = '12';  
        newHomeBaseBeansProducts.ppe = '11';  
        newHomeBaseBeansProducts.mainFeature = '18';  
        newHomeBaseBeansProducts.errorMessage ='' ;
        newHomeBaseBeansProducts.isSelected = true; 
        newHomeBaseBeansProducts.lineCount =1; 
        newHomeBaseBeansProducts.quantity  = 1.20;
    	
		newHomeBaseBeansProducts.rate1 = getratesValue();
		newHomeBaseBeansProducts.rate2 = getratesValue();
		newHomeBaseBeansProducts.rate3 = getratesValue();
		newHomeBaseBeansProducts.rate4 = getratesValue();
		newHomeBaseBeansProducts.rate5 = getratesValue();
		newHomeBaseBeansProducts.rate6 = getratesValue();
		newHomeBaseBeansProducts.rate7 = getratesValue();
		newHomeBaseBeansProducts.rate8 = getratesValue();
		
    	newHomeBaseBeansProductsList.add(newHomeBaseBeansProducts);
    	
    	HomeBaseBeans.Products newHomeBaseBeansProducts2 = new HomeBaseBeans.Products();
    	newHomeBaseBeansProducts2.Id  = 'CG1';
        newHomeBaseBeansProducts2.Description = '10i test';
        newHomeBaseBeansProducts2.qtyAvail = '1';
        newHomeBaseBeansProducts2.qtyFree ='1232'; 
        newHomeBaseBeansProducts2.qtyWip = '1';  
        newHomeBaseBeansProducts2.qtyWip1 = '1';  
        newHomeBaseBeansProducts2.qtyWip2 = '1';  
        newHomeBaseBeansProducts2.qtyWip3 = '1';  
        newHomeBaseBeansProducts2.qtyWip4 = '1';  
        newHomeBaseBeansProducts2.qtyWip5 = '1';  
        newHomeBaseBeansProducts2.qtyWip6 = '1';  
        newHomeBaseBeansProducts2.qtyWip7 = '1';  
        newHomeBaseBeansProducts2.qtyWip8 = '1';  
        newHomeBaseBeansProducts2.qtyWip9 = '1';  
        newHomeBaseBeansProducts2.qtyWip10 = '1';  
        newHomeBaseBeansProducts2.HILRM = 'test'; 	
        newHomeBaseBeansProducts2.qtyRented = '1';  
        newHomeBaseBeansProducts2.UtilPercent = '112';  
        newHomeBaseBeansProducts2.thumbnailUrl = '1tes';  
        newHomeBaseBeansProducts2.qtyReserved = '1';  
        newHomeBaseBeansProducts2.qtyTotal = '100';  
        newHomeBaseBeansProducts2.commission1 = '12';  
        newHomeBaseBeansProducts2.commission2 = '18';  
        newHomeBaseBeansProducts2.commission3 = '18';  
        newHomeBaseBeansProducts2.commission4 = '18';        
        newHomeBaseBeansProducts2.llw = '12';  
        newHomeBaseBeansProducts2.ppe = '11';  
        newHomeBaseBeansProducts2.mainFeature = '18';  
        newHomeBaseBeansProducts2.errorMessage ='' ;
        newHomeBaseBeansProducts2.isSelected = true; 
        newHomeBaseBeansProducts2.lineCount =1; 
        newHomeBaseBeansProducts2.quantity  = 1.20;
    	
		newHomeBaseBeansProducts2.rate1 = getratesValue();
		newHomeBaseBeansProducts2.rate2 = getratesValue();
		newHomeBaseBeansProducts2.rate3 = getratesValue();
		newHomeBaseBeansProducts2.rate4 = getratesValue();
		newHomeBaseBeansProducts2.rate5 = getratesValue();
		newHomeBaseBeansProducts2.rate6 = getratesValue();
		newHomeBaseBeansProducts2.rate7 = getratesValue();
		newHomeBaseBeansProducts2.rate8 = getratesValue();
		
    	newHomeBaseBeansProductsList.add(newHomeBaseBeansProducts2);
    	
    	return newHomeBaseBeansProductsList;
    }
    public static  List<HomeBaseBeans.quoteLine> getQuoteLine()
    {   
    		List<HomeBaseBeans.quoteLine> NewQuoteLineList = new List<HomeBaseBeans.quoteLine>(); 
    		HomeBaseBeans.quoteLine NewQuoteLine = new HomeBaseBeans.quoteLine();
    		NewQuoteLine.itemId ='20zs';
			NewQuoteLine.ecode = '123';
			NewQuoteLine.reference = '25s';
			NewQuoteLine.description = '234';
			NewQuoteLine.lineValue = '234';
			NewQuoteLine.quantity = 1.0;			
			NewQuoteLine.price = 2.0;
			NewQuoteLine.estimatedCost = 2.52;
			NewQuoteLine.payment = 52.00;
			NewQuoteLine.modificationCharge = 52;				
			NewQuoteLine.internetCoupon  = 'asdf';
			NewQuoteLine.lockItemCode = '123';
			NewQuoteLine.commission1 = 123;
			NewQuoteLine.commission2 = 123;
			NewQuoteLine.commission3 = 123;
			NewQuoteLine.commission4 = 123;
			NewQuoteLine.invoiceDiscountApplicable = true; 
			NewQuoteLine.errorMessage = 'teste';
			NewQuoteLine.lineCount = 1;
			NewQuoteLine.isSelected  = true; 
			NewQuoteLine.LockType = 'teste';
			NewQuoteLine.SelectedAccountId = 'teste';
			NewQuoteLine.SelectedPeriod = '2';
			NewQuoteLine.SelectedFromDate = 'teste';
			NewQuoteLine.SelectedRate1 = 'teste';
			NewQuoteLine.SelectedRate2 = 'teste';
			NewQuoteLine.SelectedRate3 = 'teste';
			NewQuoteLine.SelectedRate4 = 'teste';
			NewQuoteLine.LockTypeTotal = 123;
			NewQuoteLine.lineId = '10i';
			NewQuoteLine.removeLine = 'teste';
			NewQuoteLine.gpPercent = 123;
			NewQuoteLine.netBookValue = 123;
			NewQuoteLine.paymentType = 'teste';
			NewQuoteLine.isAccessories = true;
			NewQuoteLine.itemType = 'Accessories Item';
			
			HomeBaseBeans.rates newrate1 = new HomeBaseBeans.rates();
			newrate1.rate = '120.00';
	        newrate1.description = 'test';
	        newrate1.editable = true;
			NewQuoteLine.rate1=newrate1;
			HomeBaseBeans.rates newrate2 = new HomeBaseBeans.rates();
			newrate2.rate = '120.00';
	        newrate2.description = 'test';
	        newrate2.editable = true;
			NewQuoteLine.rate2=newrate2;
			HomeBaseBeans.rates newrate3 = new HomeBaseBeans.rates();
			newrate3.rate = '120.00';
	        newrate3.description = 'test';
	        newrate3.editable = true;
			NewQuoteLine.rate3=newrate3;
			HomeBaseBeans.rates newrate4 = new HomeBaseBeans.rates();
			newrate4.rate = '120.00';
	        newrate4.description = 'test';
	        newrate4.editable = true;
			NewQuoteLine.rate4=newrate4;
			HomeBaseBeans.rates newrate5 = new HomeBaseBeans.rates();
			newrate5.rate = '120.00';
	        newrate5.description = 'test';
	        newrate5.editable = true;
			NewQuoteLine.rate5=newrate5;
			HomeBaseBeans.rates newrate6 = new HomeBaseBeans.rates();
			newrate6.rate = '120.00';
	        newrate6.description = 'test';
	        newrate6.editable = true;
			NewQuoteLine.rate6=newrate6;
			HomeBaseBeans.rates newrate7 = new HomeBaseBeans.rates();
			newrate7.rate = '120.00';
	        newrate7.description = 'test';
	        newrate7.editable = true;
			NewQuoteLine.rate7=newrate7;
			
			HomeBaseBeans.rates newrate8 = new HomeBaseBeans.rates();
			newrate8.rate = '120.00';
	        newrate8.description = 'test';
	        newrate8.editable = true;
			NewQuoteLine.rate8=newrate8;
			NewQuoteLineList.add(NewQuoteLine);
			
			
			HomeBaseBeans.quoteLine NewQuoteLine1 = new HomeBaseBeans.quoteLine();
    		NewQuoteLine1.itemId ='20zs';
			NewQuoteLine1.ecode = '123';
			NewQuoteLine1.reference = '25s';
			NewQuoteLine1.description = '234';
			NewQuoteLine1.lineValue = '234';
			NewQuoteLine1.quantity = 1.0;			
			NewQuoteLine1.price = 2.0;
			NewQuoteLine1.estimatedCost = 2.52;
			NewQuoteLine1.payment = 52.00;
			NewQuoteLine1.modificationCharge = 52;				
			NewQuoteLine1.internetCoupon  = 'asdf';
			NewQuoteLine1.lockItemCode = '123';
			NewQuoteLine1.commission1 = 123;
			NewQuoteLine1.commission2 = 123;
			NewQuoteLine1.commission3 = 123;
			NewQuoteLine1.commission4 = 123;
			NewQuoteLine1.invoiceDiscountApplicable = true; 
			NewQuoteLine1.errorMessage = 'teste';
			NewQuoteLine1.lineCount = 1;
			NewQuoteLine1.isSelected  = true; 
			NewQuoteLine1.LockType = 'teste';
			NewQuoteLine1.SelectedAccountId = 'teste';
			NewQuoteLine1.SelectedPeriod = '2';
			NewQuoteLine1.SelectedFromDate = 'teste';
			NewQuoteLine1.SelectedRate1 = 'teste';
			NewQuoteLine1.SelectedRate2 = 'teste';
			NewQuoteLine1.SelectedRate3 = 'teste';
			NewQuoteLine1.SelectedRate4 = 'teste';
			NewQuoteLine1.LockTypeTotal = 123;
			NewQuoteLine1.lineId = '10i';
			NewQuoteLine1.removeLine = 'teste';
			NewQuoteLine1.gpPercent = 123;
			NewQuoteLine1.netBookValue = 123;
			NewQuoteLine1.paymentType = 'teste';
			NewQuoteLine1.isAccessories = true;
			NewQuoteLine1.itemType = 'Accessories Item';
			
			NewQuoteLine1.rate1=newrate1;
			NewQuoteLine1.rate2=newrate2;
			NewQuoteLine1.rate3=newrate3;
			NewQuoteLine1.rate4=newrate4;
			NewQuoteLine1.rate5=newrate5;
			NewQuoteLine1.rate6=newrate6;
			NewQuoteLine1.rate7=newrate7;
			NewQuoteLine1.rate8=newrate8;
			NewQuoteLineList.add(NewQuoteLine1);
			
    	
        return NewQuoteLineList;
    }
    
    public static  list<List<HomeBaseBeans.quoteLine>> getAllQuoteLine(){
    	list<list<HomeBaseBeans.quoteLine>> allRefreshQuoteList = new list<list<HomeBaseBeans.quoteLine>>();
        list<HomeBaseBeans.quoteLine> rl1 = getQuoteLine();
        rl1[0].errorMessage = '';
        allRefreshQuoteList.add(rl1);
        list<HomeBaseBeans.quoteLine> rl2 = getQuoteLine();
        rl2[0].itemId = 'CG1';
        allRefreshQuoteList.add(rl2);
        return allRefreshQuoteList;
    }
     
    public static   HomeBaseBeans.quoteLine getQuoteLinerecoed()
    {   
    		HomeBaseBeans.quoteLine NewQuoteLine = new HomeBaseBeans.quoteLine();
    		NewQuoteLine.itemId ='test';
			NewQuoteLine.ecode = '123';
			NewQuoteLine.reference = '25s';
			NewQuoteLine.description = '234';
			NewQuoteLine.lineValue = '234';
			NewQuoteLine.quantity = 1.0;			
			NewQuoteLine.price = 2.0;
			NewQuoteLine.estimatedCost = 2.52;
			NewQuoteLine.payment = 52.00;
			NewQuoteLine.modificationCharge = 52;				
			NewQuoteLine.internetCoupon  = 'asdf';
			NewQuoteLine.lockItemCode = '';
			NewQuoteLine.commission1 = 123;
			NewQuoteLine.commission2 = 123;
			NewQuoteLine.commission3 = 123;
			NewQuoteLine.commission4 = 123;
			NewQuoteLine.invoiceDiscountApplicable = true; 
			NewQuoteLine.errorMessage = 'teste';
			NewQuoteLine.lineCount = 1;
			NewQuoteLine.isSelected  = true; 
			NewQuoteLine.LockType = 'teste';
			NewQuoteLine.SelectedAccountId = 'teste';
			NewQuoteLine.SelectedPeriod = '2';
			NewQuoteLine.SelectedFromDate = 'teste';
			NewQuoteLine.SelectedRate1 = 'teste';
			NewQuoteLine.SelectedRate2 = 'teste';
			NewQuoteLine.SelectedRate3 = 'teste';
			NewQuoteLine.SelectedRate4 = 'teste';
			NewQuoteLine.LockTypeTotal = 123;
			NewQuoteLine.lineId = '10i';
			NewQuoteLine.removeLine = 'teste';
			NewQuoteLine.gpPercent = 123;
			NewQuoteLine.netBookValue = 123;
			NewQuoteLine.paymentType = 'teste';
			NewQuoteLine.isAccessories = true;
			NewQuoteLine.itemType = 'Accessories Item';
			
    	
        return NewQuoteLine;
    } 
    
   public static  HomeBaseBeans.chargeCodes getchargeCodes()
    { 
    	HomeBaseBeans.chargeCodes newchargeCodes = new HomeBaseBeans.chargeCodes();
			newchargeCodes.id  = '';
			newchargeCodes.description ='test';
			newchargeCodes.active = false;
			newchargeCodes.chargeCode ='1232';
			newchargeCodes.errorMessage = ''; 
			newchargeCodes.isSelected =true;
			
			return newchargeCodes;
    }
    
     public static  HomeBaseBeans.rates getratesValue()
    {
    	HomeBaseBeans.rates newRatevalue = new HomeBaseBeans.rates();
        newRatevalue.rate = '12.00';
        newRatevalue.description = 'test';
        newRatevalue.editable = true;
        return newRatevalue; 
    }
    
   public static  List<HomeBaseBeans.AnalysisSetHeaders> getanalysisSetHeader(){
   		List<HomeBaseBeans.AnalysisSetHeaders> newAnalysisHeadList = new List<HomeBaseBeans.AnalysisSetHeaders>();
    	HomeBaseBeans.AnalysisSetHeaders analysisHead = new HomeBaseBeans.AnalysisSetHeaders();
		analysisHead.id = '1';
		analysisHead.description = 'Cost Center';
		analysisHead.Longdescription = ' ';
		analysisHead.errorMessage = '';
		analysisHead.isSelected = true;
		analysisHead.selectedId = '00';
		analysisHead.selectedDescription = 'NA';				
		analysisHead.isEnabled  = true;
    	newAnalysisHeadList.add(analysisHead);
    	
    	HomeBaseBeans.AnalysisSetHeaders analysisHead1 = new HomeBaseBeans.AnalysisSetHeaders();
		analysisHead1.id = '1';
		analysisHead1.description = 'Cost Center';
		analysisHead1.Longdescription = ' ';
		analysisHead1.errorMessage = '';
		analysisHead1.isSelected = true;
		analysisHead1.selectedId = '00';
		analysisHead1.selectedDescription = 'NA';				
		analysisHead1.isEnabled  = true;
    	newAnalysisHeadList.add(analysisHead1);
    	
    	
    	return newAnalysisHeadList;
    	
    }
    
     public static  List<HomeBaseBeans.AnalysisSetHeaders> getanalysisSetHeader2(){
   		List<HomeBaseBeans.AnalysisSetHeaders> newAnalysisHeadList = new List<HomeBaseBeans.AnalysisSetHeaders>();
    	HomeBaseBeans.AnalysisSetHeaders analysisHead = new HomeBaseBeans.AnalysisSetHeaders();
		analysisHead.id = '1';
		analysisHead.description = 'Cost Center';
		analysisHead.Longdescription = ' ';
		analysisHead.errorMessage = '';
		analysisHead.isSelected = true;
		analysisHead.selectedId = null;
		analysisHead.selectedDescription = 'NA';				
		analysisHead.isEnabled  = true;
    	newAnalysisHeadList.add(analysisHead);
    	
    	HomeBaseBeans.AnalysisSetHeaders analysisHead1 = new HomeBaseBeans.AnalysisSetHeaders();
		analysisHead1.id = '1';
		analysisHead1.description = 'Cost Center';
		analysisHead1.Longdescription = ' ';
		analysisHead1.errorMessage = '';
		analysisHead1.isSelected = true;
		analysisHead1.selectedId = null;
		analysisHead1.selectedDescription = 'NA';				
		analysisHead1.isEnabled  = true;
    	newAnalysisHeadList.add(analysisHead1);
    	
    	
    	HomeBaseBeans.AnalysisSetHeaders analysisHead2 = new HomeBaseBeans.AnalysisSetHeaders();
		analysisHead2.id = '1';
		analysisHead2.description = 'Cost Center';
		analysisHead2.Longdescription = ' ';
		analysisHead2.errorMessage = '';
		analysisHead2.isSelected = true;
		analysisHead2.selectedId = null;
		analysisHead2.selectedDescription = 'NA';				
		analysisHead2.isEnabled  = true;
    	newAnalysisHeadList.add(analysisHead2);
    	
    	
    	HomeBaseBeans.AnalysisSetHeaders analysisHead3 = new HomeBaseBeans.AnalysisSetHeaders();
		analysisHead3.id = '1';
		analysisHead3.description = 'Cost Center';
		analysisHead3.Longdescription = ' ';
		analysisHead3.errorMessage = '';
		analysisHead3.isSelected = true;
		analysisHead3.selectedId = null;
		analysisHead3.selectedDescription = 'NA';				
		analysisHead3.isEnabled  = true;
    	newAnalysisHeadList.add(analysisHead3);
    	
    	
    	return newAnalysisHeadList;
    	
    }
    
    
     public static List<HomeBaseBeans.analysisSetCodes> getAnalysisSetCodes(){
   		List<HomeBaseBeans.analysisSetCodes> anylsisCodeList = new List<HomeBaseBeans.analysisSetCodes>();
    	HomeBaseBeans.analysisSetCodes ac = new HomeBaseBeans.analysisSetCodes();
		ac.id = '1';
		ac.description = 'Ad Source';
		ac.Longdescription= 'Ad Source';
		ac.isSelected = true;	
    	anylsisCodeList.add(ac);
    	return anylsisCodeList;
    	
    }
    
     public static List<HomeBaseBeans.analysisSetCodes> getAnalysisSetCodesOutsideTSM(){
   		List<HomeBaseBeans.analysisSetCodes> outTsm = getAnalysisSetCodes();
		outTsm[0].id = '00';
		outTsm[0].description = 'Outside TSM';
    	return outTsm;
    }
    
    public static List<HomeBaseBeans.analysisSetCodes> getAnalysisSetCodesDeferredBill(){
   		List<HomeBaseBeans.analysisSetCodes> defBill = MMIFullquoteTestDataProvider.getAnalysisSetCodes();
		defBill[0].id = '00';
		defBill[0].description = 'Deferred Bill';
    	return defBill;
    }
    
    public static List<HomeBaseBeans.analysisSetCodes> getAnalysisSetCodesWriteOffAc(){
   		List<HomeBaseBeans.analysisSetCodes> woa = MMIFullquoteTestDataProvider.getAnalysisSetCodes();
		woa[0].id = '00';
		woa[0].description = 'Write Off A/c';
    	return woa;
    }
    
    public static List<HomeBaseBeans.analysisSetCodes> getAnalysisSetCodesCostCenter(){
   		List<HomeBaseBeans.analysisSetCodes> cstCntr = MMIFullquoteTestDataProvider.getAnalysisSetCodes();
		cstCntr[0].id = '00';
		cstCntr[0].description = 'Cost Center';
    	return cstCntr;
    }
    
    public static List<HomeBaseBeans.analysisSetCodes> getAnalysisSetCodesAdSource(){
   		List<HomeBaseBeans.analysisSetCodes> addSrc = MMIFullquoteTestDataProvider.getAnalysisSetCodes();
		addSrc[0].id = '00';
		addSrc[0].description = 'Ad Source';
    	return addSrc;
    }
    
     public static List<HomeBaseBeans.analysisSetCodes> getAnalysisSetCodesCustomerType(){
   		List<HomeBaseBeans.analysisSetCodes> cusTyp = MMIFullquoteTestDataProvider.getAnalysisSetCodes();
		cusTyp[0].id = '00';
		cusTyp[0].description = 'Customer Type';
    	return cusTyp;
    }
    
    public Static list<HomeBaseBeans.AnalysisSetHeaders> getAnalysisSetHeaderAll(){
    	List<HomeBaseBeans.AnalysisSetHeaders> testAnaLst = new List<HomeBaseBeans.AnalysisSetHeaders>();
		List<HomeBaseBeans.AnalysisSetHeaders> taLst1 = getanalysisSetHeader();
		taLst1[0].id = '1';
		taLst1[0].description = 'Ad Source';
		testAnaLst.add(taLst1[0]);
		
		List<HomeBaseBeans.AnalysisSetHeaders> taLst2 = getanalysisSetHeader();
		taLst2[0].id = '2';
		taLst2[0].description = 'Customer Type';
		testAnaLst.add(taLst2[0]);
		
		List<HomeBaseBeans.AnalysisSetHeaders> taLst3 = getanalysisSetHeader();
		taLst3[0].id = '3';
		taLst3[0].description = 'Deferred Bill';
		testAnaLst.add(taLst3[0]);
		
		List<HomeBaseBeans.AnalysisSetHeaders> taLst4 = getanalysisSetHeader();
		taLst4[0].id = '4';
		taLst4[0].description = 'Outside TSM';
		testAnaLst.add(taLst4[0]);
		
		List<HomeBaseBeans.AnalysisSetHeaders> taLst5 = getanalysisSetHeader();
		taLst5[0].id = '5';
		taLst5[0].description = 'Write Off A/c';
		testAnaLst.add(taLst5[0]);
		
		List<HomeBaseBeans.AnalysisSetHeaders> taLst6 = getanalysisSetHeader();
		taLst6[0].id = '5';
		taLst6[0].description = 'Cost Center';
		testAnaLst.add(taLst6[0]);
		return testAnaLst;
    }
    
    public static List<HomeBaseBeans.extras> getProductExtrasList(){
   		List<HomeBaseBeans.extras> newExtraList = new List<HomeBaseBeans.extras>();
    	HomeBaseBeans.extras prodexr = new HomeBaseBeans.extras();
			prodexr.id = '10i';
			prodexr.description = 'Delivery';
			prodexr.quantity= '1';
			prodexr.price = '120.00';
			prodexr.total = '120.00';	
	        prodexr.include = true;
	        prodexr.mandatory = true;
	        prodexr.priceEditable = true;
	        prodexr.quantityEditable = true;
	        prodexr.quantityRequired = true;
	        prodexr.errorMessage  = '';
	    	newExtraList.add(prodexr);
	    	return newExtraList;
    	
    }
    
   
    
    public static List<HomeBaseBeans.rates> getHomeBaseBeansrates(){
   		List<HomeBaseBeans.rates> newHomeBaseBeansrates = new List<HomeBaseBeans.rates>();
    	HomeBaseBeans.rates newrate = new HomeBaseBeans.rates();
			newrate.rate = '120.00';
	        newrate.description = 'test';
	        newrate.editable = true;
	        newHomeBaseBeansrates .add(newrate);
	    	return newHomeBaseBeansrates ;
    }
    
    
	public static HomeBaseBeans.TaxIds gethomeBaseBeanTaxId(){
		HomeBaseBeans.TaxIds newHomeBaseBeanTaxId = new HomeBaseBeans.TaxIds();
		newHomeBaseBeanTaxId.Id  = '23423';
        newHomeBaseBeanTaxId.taxAreaStatus = 'NORM';
        newHomeBaseBeanTaxId.country ='USA';
        newHomeBaseBeanTaxId.countryDescription = 'USA';
        newHomeBaseBeanTaxId.country1 ='USA';
        newHomeBaseBeanTaxId.state ='AZ';
        newHomeBaseBeanTaxId.stateDescription ='test';
        newHomeBaseBeanTaxId.city ='TESCP';
        newHomeBaseBeanTaxId.errorMessage = '';
        newHomeBaseBeanTaxId.isSelected = true;
        newHomeBaseBeanTaxId.RecUniqId = 1;
        return newHomeBaseBeanTaxId;
	}
	
	    public static  fullquoteWrapper getFullWrapperSales()
    {   
    	FullQuoteWrapper fullQWrapper=new FullQuoteWrapper();
    	
    	fullQWrapper.unitPriceInvoice = '10.00';
		fullQWrapper.BillDiscountInvoice = '12';
		fullQWrapper.extrasInvoice = '12.00';
		fullQWrapper.deliveryInvoice = '22';
		fullQWrapper.totalInvoice = '1250';
		fullQWrapper.taxInvoice = '12';
		fullQWrapper.SelectedShipingTaxId = '25482212'; 
		fullQWrapper.QouteStatus = 'NORM';
		fullQWrapper.TransactionType  = 'MOBO';
		fullQWrapper.startDate = '2013-2-12';
		fullQWrapper.Quoteexpires = '2013-2-12';
		fullQWrapper.POExpiresdate = '2013-2-12';
		fullQWrapper.LoadedMoveIn = '2013-2-12';
		fullQWrapper.ScheduledDelivery = '2013-2-12';
		fullQWrapper.imageNameForPreivewQuote = 'priveimage';
		fullQWrapper.WriteUpRep  = '98765';
		fullQWrapper.WriteUpRepName  = 'Gaurav Dixit';
		fullQWrapper.AssistingRep  = '98765';
		fullQWrapper.AssistingRepName  = 'Gaurav Dixit';
		fullQWrapper.AccountName  = 'Test';
		fullQWrapper.AccountId  = '50737';
		fullQWrapper.BillingContactID  = '1';
		fullQWrapper.ID  = '50737';
		fullQWrapper.TaxExempt  = true;
		fullQWrapper.Status  = 'U';
		fullQWrapper.Name  = 'Gina';
		fullQWrapper.Name1  = 'Gina';
		fullQWrapper.telePhone  = '985765';
		fullQWrapper.Address  = 'Test';
		fullQWrapper.Fax  = '5878565';
		fullQWrapper.Email  = 'test@teksystem.com';
		fullQWrapper.City  = 'TESCO';
		fullQWrapper.POContact  = '2013-2-12';
		fullQWrapper.Country  = 'USA';
		fullQWrapper.POExpires  = '2013-2-12'; 
		fullQWrapper.State  = 'AZ';
		fullQWrapper.County  = 'USA';	
		fullQWrapper.zipCode  = '856475';
		fullQWrapper.CreditApproval  = 'Trest';
		fullQWrapper.TaxExemptAuthorization  = '111';
		fullQWrapper.JoborLocation  = 'test t';
		fullQWrapper.CODInstructions  = 'tes 2';
		fullQWrapper.QuoteTotal  = '2585';
		fullQWrapper.AdSource  = '245';
		fullQWrapper.CustomerType  = 'Norm';
		fullQWrapper.Deferred  = 'Dell time';
		fullQWrapper.OutsideRep  = '100000';
		fullQWrapper.CertofInsurance  = 'tess'; 
		fullQWrapper.fulFillingBranchInBilling  = '103';
		fullQWrapper.fulFillingBranchNameInBilling  = 'Test';
		fullQWrapper.RentalCharge  = '121';
		fullQWrapper.Terms  = 'true';
		fullQWrapper.PPETotal  = '1252'; 
		fullQWrapper.TermsCode  = '1251';
		fullQWrapper.LLWTotal  = '1254'; 
		fullQWrapper.InvoicedBalance  = '125';
		fullQWrapper.DeliveryFee  = '225';  
		fullQWrapper.LastInvoice  = '2013-2-12'; 
		fullQWrapper.ReturnFee  = '125';
		fullQWrapper.YTDSales  = '12'; 
		fullQWrapper.FuelSurchargeFee  = '123';
		fullQWrapper.LocksTotal  = '34';
		fullQWrapper.Accessories  = '125';
		fullQWrapper.TaxTotal  = '23';
		fullQWrapper.CODAmount  = '23';
		fullQWrapper.TotalCODAmount  = '12';
		fullQWrapper.DeliveryInInvoicing  = '34';
		fullQWrapper.otherInInvoicing  = '4';
		fullQWrapper.ItemCode  = '1oi';
		fullQWrapper.Reference  = 'test';
		fullQWrapper.ImageUrlForPDF = 'asdf';
		fullQWrapper.ECode  = '23';
		fullQWrapper.SuggestedPrice  = '234';
		fullQWrapper.MinPrice  = '12';
		fullQWrapper.NetBookValue  = '234';
		fullQWrapper.sellingPrice  = '345';
		fullQWrapper.assetDescription  = '231';
		fullQWrapper.GradeDescription  = 'test';
		fullQWrapper.ModificationCost  = '345';
		fullQWrapper.showEcodeValues = true;
		fullQWrapper.MMI  = '120';
		fullQWrapper.LengthOfRental  = '2';
		fullQWrapper.InternetCoupon  = '323';
		fullQWrapper.minimumTerm  = '11';
		fullQWrapper.national  = '345';
		fullQWrapper.LockType  = '1';
		fullQWrapper.isLead  = false;
		fullQWrapper.ModificationComments  = '34';
		fullQWrapper.ApproverComments  = '12';
		fullQWrapper.rentalLength  = '9';   	
		fullQWrapper.shippingId  = '1';   	
		fullQWrapper.NameInShippingDates  = 'test';   
		fullQWrapper.deliveryContactId  = '23';
		fullQWrapper.AddressInShippingDates  = '1';
		fullQWrapper.NameInShippingDates1  = 'tds';
		fullQWrapper.cityInShippingDates  = 'tesc';
		fullQWrapper.countyInShippingDates  = 'USA';
		fullQWrapper.stateInShippingDates  = 'AZ';
		fullQWrapper.countryInShippingDates  = 'USA';
		fullQWrapper.fulFillingBranchInShippingDates  = '106';
		fullQWrapper.fulFillingBranchNameInShippingDates  = 'test';
		fullQWrapper.telInShippingDates  = '2343';
		fullQWrapper.faxInShippingDates  = '123123';
		fullQWrapper.emailInShippingDates  = 'atte@teksystem.com';
		fullQWrapper.crossStreetInShippingDates  = '2343';
		fullQWrapper.crossStreet2InShippingDates  = '1sf';
		fullQWrapper.certOfInsurenceInShippingDates  = '234df';
		fullQWrapper.cityZoneInShippingDates  = 'adf';
		fullQWrapper.ZipCodeInShipping  = '58856';	
		fullQWrapper.delTime  = '12pm';
		fullQWrapper.delTimeDesc  = '23';
		fullQWrapper.callFirst  = 'callfirst';
		fullQWrapper.callFirstDesc  = 'cllfidztdes';
		fullQWrapper.noReservation  = false;
		fullQWrapper.doorDir  = 'sdf';
		fullQWrapper.doorDirDesc  = '121';
		fullQWrapper.movementType  = 'test';
		fullQWrapper.movementTypeDesc  = 'adf';
		fullQWrapper.appearance  = 'ad';
		fullQWrapper.deliverySlot  = '25';
		fullQWrapper.distFromBranch  = '123';
		fullQWrapper.deliveryCharge  = '22'; 
		fullQWrapper.pickupCharge  = '234'; 
		fullQWrapper.deliveryInstructions  = 'test sa';
		fullQWrapper.LLWTotalInShipping  = 12.00;
		fullQWrapper.deliveryZoneInShipping  = 'A';
		fullQWrapper.fuelSurchargeInShipping  = 23.00;
		fullQWrapper.isUseBillingAddress  =  true;
		fullQWrapper.productSearchWord  = 'dasd';
		fullQWrapper.ProductType  = 'sales';
		fullQWrapper.ProductSize  = '2';
		fullQWrapper.PrimaryOnly  =true;
		fullQWrapper.deliverySetUp  = '5ad';
		fullQWrapper.returnTearDown  = 'tes';
		fullQWrapper.SideRollDoors  = true;
	    fullQWrapper.EndRollDoors  = true; 
	    fullQWrapper.RecordStorage  = true;
	    fullQWrapper.HighCubes  = true;
	    fullQWrapper.Shelving  = true;
	    fullQWrapper.rentalLengthInProduct  = '1252'; 			
		fullQWrapper.isCapacityReservedDurinEdit  = false;
		fullQWrapper.analysisSetSelectedId  = 'atesas';		
		fullQWrapper.isSalesRep = true;
		fullQWrapper.sourceId  = '25452';
		
		fullQWrapper.showValidateAddressPopUp = true;
    	fullQWrapper.showValidateAddressShippingPopUp = true;
    	fullQWrapper.showTaxIdShippingPopUp = true;
    	fullQWrapper.showTaxIdBillingPopUp = true;
        fullQWrapper.showBranchPopUp = true;
        fullQWrapper.addressPopUp = true;
    	fullQWrapper.shippingAddressPopUp = true;
    	fullQWrapper.showAccountPopUp = true;
    	fullQWrapper.showEcodePopUp = true;
    	fullQWrapper.contactShippingPopUp = true;
    	fullQWrapper.showAnalysisCodePopup = true;
    	fullQWrapper.contactPopup = true;
    	fullQWrapper.showEditProduct = true;
    	fullQWrapper.showMinimumTermPopUp = true;
    	fullQWrapper.showAnalysisCodePopupInProduct = true;
    	fullQWrapper.showBranchBillingPopUp = true;
    	fullQWrapper.showAnalysisCodeShippingPopup = true;
    	fullQWrapper.showErrorPopUp = true;
    	fullQWrapper.showSearchBranchIdTable = true;
    	fullQWrapper.showSearchBranchShippingIdTable = true;
    	fullQWrapper.showSearchAnalysisSetCodeInBilling = true;
    	fullQWrapper.showSearchAnalysisSetCodeInShipping = true;
    	fullQWrapper.showSearchChargeCodeList = true;
    	fullQWrapper.showWriteUpRepSearchList = true;
    	fullQWrapper.showAssistingRepSearchList = true;
    	fullQWrapper.showContactSearchInBilling = true;
    	fullQWrapper.showContactSearchInShipping = true;
    	fullQWrapper.enable1Period = true;
    	fullQWrapper.enable2To6Period = true;
    	fullQWrapper.enable7To12Period = true;
    	fullQWrapper.enable13Period = true;  
    	fullQWrapper.enableVAddresBtnInBilling = true;
    	fullQWrapper.enableRefreshQuote = true;
    	fullQWrapper.enableSaveQuote = true;
    	fullQWrapper.convertQuoteToOrder = true;
    	fullQWrapper.enableProductadd = true;
    	fullQWrapper.enableVAddresBtnInShipping = true;
    	fullQWrapper.enableMarkAsLostButton = true;	  
    	fullQWrapper.fullfillingBranch = true;
		fullQWrapper.invoiceTabEnableDis = true;
    	fullQWrapper.startDateonchange = true;
    	fullQWrapper.analysisSetHeadValue = true;
    	fullQWrapper.isBillingAddressValidated = true;
    	fullQWrapper.isShippingAddressValidated = true;  	
	 	fullQWrapper.showCapacityLookupPopup = true;
	 	fullQWrapper.selectedFullQUote = 'Sales';
		fullQWrapper.showSalesfleet = true;
		fullQWrapper.showSalesRepPopup = true;
	  	fullQWrapper.reserveCapacityId = 'true';
        fullQWrapper.showReserveCapacityId = true;
     	fullQWrapper.showOrderPopUp  = true;
     	fullQWrapper.OrderMessage  = 'true';
     	fullQWrapper.orderQuoteId  = 'test';
     	fullQWrapper.orderContractId  = 'test';
 		fullQWrapper.showCapacityPopUp  = true;
   		fullQWrapper.ifCapacityYes  = true; 
       		
        return fullQWrapper;
    } 
    
    public static FullQuoteRefreshParser_AC getRefreshRespo(){
    FullQuoteRefreshParser_AC refreshResponse=new FullQuoteRefreshParser_AC();
    refreshResponse.errorMessage=null;
    FullQuoteRefreshParser_AC.RentalQuote editRental = new  FullQuoteRefreshParser_AC.RentalQuote();
   
   editRental.accessories='yes';
   editRental.accountId='1234';
   
   FullQuoteRefreshParser_AC.AnalysisSet1 a=new FullQuoteRefreshParser_AC.AnalysisSet1();
   FullQuoteRefreshParser_AC.Header h=new  FullQuoteRefreshParser_AC.Header();
   
   h.id='111';
   h.description='Del Time';
   FullQuoteRefreshParser_AC.Selection s=new FullQuoteRefreshParser_AC.Selection();
   s.id='';
   s.description='';
   a.header=h;
   a.selection=s;
   
   editRental.additionalAnalysisSet1=a;
   editRental.additionalAnalysisSet2=a;
   editRental.additionalAnalysisSet3=a;
   editRental.additionalAnalysisSet4=a;
   editRental.additionalAnalysisSet5=null;
   editRental.alreadyRegistered=true;
   editRental.analysisSet1=a;
   editRental.analysisSet2=a;
   editRental.analysisSet3=a;
   editRental.analysisSet4=a;
   editRental.analysisSet5=null;
   
   FullQuoteRefreshParser_AC.BillingAddress addr=new FullQuoteRefreshParser_AC.BillingAddress();
        addr.address1='123 abc';
        addr.address2='abc';
        addr.address3='Tempe';
        addr.address4='AZ';
        //addr.branchId='113';
        //addr.companyId='1';
        addr.countryId='USA';
        addr.crossStreet1='sdas';
        addr.crossStreet2='ddfdf';
        addr.deliveryZone='test';
        addr.distanceBranch='123';
        addr.fulfillingBranchId='101';
        addr.fulfillingBranchName='test';
       // addr.isSelected=true;
        addr.latitude='test';
        addr.longitude='test';
        addr.oldPostalCode='85828';
       // addr.RecUniqId=1;
        addr.state='AZ';
        addr.taxId='1234';
        addr.zipCode='85282';
        addr.zoneWarning='test'; 
   
       editRental.billingAddress=addr;
       editRental.billingAddressId='0';
      FullQuoteRefreshParser_AC.BillingContactDetails bcd=new FullQuoteRefreshParser_AC.BillingContactDetails();
      bcd.email='test@test.com';
      bcd.fax='';
      bcd.id='0';
      bcd.mobile='1234567890';
      bcd.name='test';
      bcd.tel='1234567890';
      
      editRental.billingContactDetails=bcd;
      editRental.branchId='102';
      
      editRental.certificateOfInsurance='yes';
      editRental.codAmount='100';
      editRental.companyId='1';
      editRental.creditApproval='';
      editRental.creditStatus='NORM';
      editRental.customerText1='';
      editRental.delivery='100';
      editRental.documentId='0';
     editRental.emailPortalLink=true;
    
    FullQuoteRefreshParser_AC.Extras extra=new FullQuoteRefreshParser_AC.Extras();
    extra.description='DELIVERY';
    extra.id='DELIVERY';
    extra.include=true;
    extra.mandatory=true;
    extra.price='100';
    extra.priceEditable=true;
    extra.quantity='2';
    extra.quantityEditable=true;
    extra.quantityRequired=true;
    extra.total='100';
    
    FullQuoteRefreshParser_AC.Rate1_Z rateEX=new FullQuoteRefreshParser_AC.Rate1_Z();
    rateEX.description='';
    rateEX.editable=true;
    rateEX.rate='100';
    
    extra.rate1=rateEX;
    extra.rate2=rateEX;
    extra.rate3=rateEX;
    extra.rate4=rateEX;
    extra.rate5=rateEX;
    extra.rate6=rateEX;
    extra.rate7=rateEX;
    extra.rate8=rateEX;
    
    List<FullQuoteRefreshParser_AC.Extras> extLST=new  List<FullQuoteRefreshParser_AC.Extras>();
    extLST.add(extra);
   
   editRental.extras=extLST;
   editRental.hireTerms='';
   editRental.homeOwner='';
   editRental.instructionText='';
   editRental.invoicedBalance='200';
   editRental.lastInvoiceDate='2013-08-29';
   editRental.llw='100';
    
   FullQuoteRefreshParser_AC.Lines line=new FullQuoteRefreshParser_AC.Lines();
   line.commission1='';
   line.commission2='';
   line.commission3='';
   line.commission4='';
   line.description='20 Deluxe door on 1 end';
   line.ecode='12345';
   line.internetCoupon='';
   line.invoiceDiscountApplicable=true;
   line.itemId='20zs';
   line.lineId='1.00';
   line.lockItemCode='';
   line.netBookValue='2222';
   line.price='2222';
   line.quantity='1';
   line.reference='';
   
    FullQuoteRefreshParser_AC.Rate1 rate=new FullQuoteRefreshParser_AC.Rate1();
    rate.description='';
    rate.editable=true;
    rate.rate='100';
    line.rate1=rate;
    line.rate2=rate;
    line.rate3=rate;
    line.rate4=rate;
    line.rate5=rate;
    line.rate6=rate;
    line.rate7=rate;
    line.rate8=rate;
    
     List<FullQuoteRefreshParser_AC.Lines> lineLST=new  List<FullQuoteRefreshParser_AC.Lines>();
     lineLST.add(line);
     editRental.lines=lineLST;
     
     editRental.messageDetails='';
     editRental.mobilization='1.0';
     editRental.modifiedTimestamp='0';
     editRental.narrative1='';
     editRental.narrative2='';
     editRental.nscRepCommission='';
     editRental.other='';
     editRental.pickUp='10';
     editRental.plannedCollectionDate='2013-08-29';
     editRental.poExpires='2013-08-29';
     editRental.poRequired='123456';
     editRental.portalContact='';
     editRental.portalContactEmail='';
     editRental.quoteExpires='2013-08-29';
     editRental.quoteTotal='1000';
     editRental.reference='';
     editRental.rentalCharge='200';
     editRental.rentalLength='8';
    editRental.reservationId='';
    editRental.salesRep1='1234';
    editRental.salesRep1Name='Amit';
    editRental.salesRep2='1234';
    editRental.salesRep2Name='Amit';
    editRental.shippingAddressId='0';
    editRental.shippingDate='2013-08-29';
    editRental.shippingInstructions='';
    editRental.startDate='2013-08-29';
    editRental.status='Q';
    
    FullQuoteRefreshParser_AC.ShippingAddress sAdd=new FullQuoteRefreshParser_AC.ShippingAddress();
        sAdd.address1='123 abc';
        sAdd.address2='abc';
        sAdd.address3='Tempe';
        sAdd.address4='AZ';
       // sAdd.branchId='113';
    //    sAdd.companyId='1';
        sAdd.countryId='USA';
        sAdd.crossStreet1='sdas';
        sAdd.crossStreet2='ddfdf';
        sAdd.deliveryZone='test';
        sAdd.distanceBranch='123';
        sAdd.fulfillingBranchId='101';
        sAdd.fulfillingBranchName='test';
       // sAdd.isSelected=true; 
        sAdd.latitude='test';
        sAdd.longitude='test'; 
        sAdd.oldPostalCode='85828';
        //sAdd.RecUniqId=1;
        sAdd.state='AZ';
        sAdd.taxId='1234';
        sAdd.zipCode='85282';
        sAdd.zoneWarning='test';
        
       editRental.shippingAddress=sAdd;
       
   FullQuoteRefreshParser_AC.ShippingContactDetails scd=new FullQuoteRefreshParser_AC.ShippingContactDetails();
      scd.email='test@test.com';
      scd.fax='';
      scd.id='0';
      scd.mobile='1234567890';
      scd.name='test';
      scd.tel='1234567890';
      
      editRental.shippingContactDetails=scd;
      editRental.tax='110';
      editRental.taxExempt=true;
      editRental.taxExemptAuthorisation='';
      editRental.termsCode='';
      editRental.totalCodAmount='100';
      editRental.transactionId='OFF';
      editRental.type='Rental';
      editRental.viewDocumentIn=false;
      editRental.writeUpRepCommission='';
      editRental.ytdSales='100';
      
      refreshResponse.rentalQuote=editRental;
      
      
       FullQuoteRefreshParser_AC.salesQuote editsales = new  FullQuoteRefreshParser_AC.salesQuote();
   
   editsales.accessories='yes';
   editsales.accountId='1234';
  
   editsales.additionalAnalysisSet1=a;
   editsales.additionalAnalysisSet2=a;
   editsales.additionalAnalysisSet3=a;
   editsales.additionalAnalysisSet4=a;
   editsales.additionalAnalysisSet5=null;
   editsales.alreadyRegistered=true;
   editsales.analysisSet1=a;
   editsales.analysisSet2=a;
   editsales.analysisSet3=a;
   editsales.analysisSet4=a;
   editsales.analysisSet5=null;
   
   
       editsales.billingAddress=addr;
       editsales.billingAddressId='0';

      editsales.billingContactDetails=bcd;
      editsales.branchId='102';
      
      editsales.certificateOfInsurance='yes';
      editsales.codAmount='100';
      editsales.companyId='1';
      editsales.creditApproval='';
      editsales.creditStatus='NORM';
      editsales.customerText1='';
      editsales.delivery='100';
      editsales.documentId='0';
     editsales.emailPortalLink=true;
    
    
   editsales.extras=extLST;
   editsales.hireTerms='';
   editsales.homeOwner='';
   editsales.instructionText='';
   editsales.invoicedBalance='200';
   editsales.lastInvoiceDate='2013-08-29';
   editsales.llw='100';
    
  
     editsales.lines=lineLST;
     
     editsales.messageDetails='';
     editsales.mobilization='1.0';
     editsales.modifiedTimestamp='0';
     editsales.narrative1='';
     editsales.narrative2='';
     editsales.nscRepCommission='';
     editsales.other='';
     editsales.pickUp='10';
     editsales.plannedCollectionDate='2013-08-29';
     editsales.poExpires='2013-08-29';
     editsales.poRequired='123456';
     editsales.portalContact='';
     editsales.portalContactEmail='';
     editsales.quoteExpires='2013-08-29';
     editsales.quoteTotal='1000';
     editsales.reference='';
     editsales.rentalCharge='200';
     editsales.rentalLength='8';
    editsales.reservationId='';
    editsales.salesRep1='1234';
    editsales.salesRep1Name='Amit';
    editsales.salesRep2='1234';
    editsales.salesRep2Name='Amit';
    editsales.shippingAddressId='0';
    editsales.shippingDate='2013-08-29';
    editsales.shippingInstructions='';
    editsales.startDate='2013-08-29';
    editsales.status='Q';
    
   
        
       editsales.shippingAddress=sAdd;
       
 
      
      editsales.shippingContactDetails=scd;
      editsales.tax='110';
      editsales.taxExempt=true;
      editsales.taxExemptAuthorisation='';
      editsales.termsCode='';
      editsales.totalCodAmount='100';
      editsales.transactionId='OFF';
      editsales.type='Sales';
      editsales.viewDocumentIn=false;
      editsales.writeUpRepCommission='';
      editsales.ytdSales='100';
      
       refreshResponse.salesQuote=editsales;
     
    	return refreshResponse;
    }
	  
	  
	public static  EditFullQUoteService_AC getEditFullQuoteData()
    { 
    	String json = '{'+
		'    \"rentalQuote\": {'+
		'        \"documentId\": 126025351,'+
		'        \"companyId\": 1,'+
		'        \"transactionId\": \"ON\",'+
		'        \"salesRep1\": \"1234\",'+
		'        \"salesRep1Name\": \"Lavanya Shivara\",'+
		'        \"salesRep2\": \"1234\",'+
		'        \"salesRep2Name\": \"Lavanya Shivara\",'+
		'        \"narrative1\": \"\",'+
		'        \"narrative2\": \"\",'+
		'        \"instructionText\": \"\",'+
		'        \"status\": \"Q\",'+
		'        \"modifiedTimestamp\": 1366615671000,'+
		'        \"billingContactDetails\": {'+
		'            \"id\": \"\",'+
		'            \"name\": \"ALLEN CONSTRUCTION CO///CCA\",'+
		'            \"tel\": \"972-293-7846\",'+
		'            \"fax\": \"\",'+
		'            \"email\": \"\",'+
		'            \"mobile\": null'+
		'        },'+
		'        \"reference\": \"REQUIRED\",'+
		'        \"poExpires\": null,'+
		'        \"creditApproval\": \"\",'+
		'        \"taxExemptAuthorisation\": \"\",'+
		'        \"taxExempt\": false,'+
		'        \"quoteTotal\": \"FI\",'+
		'        \"lines\": ['+
		'            {'+
		'                \"itemId\": \"10S2\",'+
		'                \"ecode\": \"\",'+
		'                \"reference\": \"\",'+
		'                \"description\": \"10\' CONTAINER\",'+
		'                \"lineValue\": \"0.00\",'+
		'                \"quantity\": 1,'+
		'                \"price\": \"0.00\",'+
		'                \"invoiceDiscountApplicable\": false,'+
		'                \"lockItemCode\": null,'+
		'                \"lineId\": 1,'+
		'                \"internetCoupon\": \"\",'+
		'                \"chargeCode\": {'+
		'                    \"description\": null,'+
		'                    \"active\": false,'+
		'                    \"id\": \"MONTHLY\"'+
		'                },'+
		'                \"rate1\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": \"1 Period\",'+
		'                    \"editable\": true'+
		'                },'+
		'                \"rate2\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": \"2-6 Periods\",'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate3\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": \"7-12 Periods\",'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate4\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": \"13+ Periods\",'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate5\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": \"Contractor\",'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate6\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": \"National\",'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate7\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": \"Xmas Rate\",'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate8\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": \"Min Xmas\",'+
		'                    \"editable\": false'+
		'                },'+
		'                \"commission1\": \"0.00\",'+
		'                \"commission2\": \"0.00\",'+
		'                \"commission3\": \"0.00\",'+
		'                \"commission4\": \"0.00\"'+
		'            }'+
		'        ],'+
		'        \"analysisSet1\": {'+
		'            \"header\": {'+
		'                \"id\": 102,'+
		'                \"description\": \"Ad Source\"'+
		'            },'+
		'            \"selection\": {'+
		'                \"id\": \"DM\",'+
		'                \"description\": \"Direct Mail\"'+
		'            }'+
		'        },'+
		'        \"analysisSet2\": {'+
		'            \"header\": {'+
		'                \"id\": 103,'+
		'                \"description\": \"Customer Type\"'+
		'            },'+
		'            \"selection\": {'+
		'                \"id\": \"2\",'+
		'                \"description\": \"Retail Trade\"'+
		'            }'+
		'        },'+
		'        \"analysisSet4\": {'+
		'            \"header\": {'+
		'                \"id\": 103,'+
		'                \"description\": \"Customer Type\"'+
		'            },'+
		'            \"selection\": {'+
		'                \"id\": \"2\",'+
		'                \"description\": \"Retail Trade\"'+
		'            }'+
		'        },'+
		'        \"analysisSet3\": {'+
		'            \"header\": {'+
		'                \"id\": 110,'+
		'                \"description\": \"Deferred\"'+
		'            },'+
		'            \"selection\": {'+
		'                \"id\": \"YES\",'+
		'                \"description\": \"Yes\"'+
		'            }'+
		'        },'+
		'        \"analysisSet5\": null,'+
		'        \"additionalAnalysisSet1\": {'+
		'            \"header\": {'+
		'                \"id\": 111,'+
		'                \"description\": \"Del Time\"'+
		'            },'+
		'            \"selection\": {'+
		'                \"id\": \"1PM\",'+
		'                \"description\": \"Priority PM\"'+
		'            }'+
		'        },'+
		'        \"additionalAnalysisSet2\": {'+
		'            \"header\": {'+
		'                \"id\": 112,'+
		'                \"description\": \"Call First\"'+
		'            },'+
		'            \"selection\": {'+
		'                \"id\": \"YES\",'+
		'                \"description\": \"Call First\"'+
		'            }'+
		'        },'+
		'        \"additionalAnalysisSet3\": {'+
		'            \"header\": {'+
		'                \"id\": 113,'+
		'                \"description\": \"Door Dir\"'+
		'            },'+
		'            \"selection\": {'+
		'                \"id\": \"DPCMM\",'+
		'                \"description\": \"MMI Cab\"'+
		'            }'+
		'        },'+
		'        \"additionalAnalysisSet4\": {'+
		'            \"header\": {'+
		'                \"id\": 114,'+
		'                \"description\": \"Movement Type\"'+
		'            },'+
		'            \"selection\": {'+
		'                \"id\": \"DR\",'+
		'                \"description\": \"Dry Run\"'+
		'            }'+
		'        },'+
		'        \"additionalAnalysisSet5\": {'+
		'            \"header\": {'+
		'                \"id\": 115,'+
		'                \"description\": \"Appearance\"'+
		'            },'+
		'            \"selection\": {'+
		'                \"id\": \"VIMP\",'+
		'                \"description\": \"Very Important\"'+
		'            }'+
		'        },'+
		'        \"termsCode\": \"New Customer\",'+
		'        \"invoicedBalance\": \"0.00\",'+
		'        \"lastInvoiceDate\": null,'+
		'        \"writeUpRepCommission\": null,'+
		'        \"nscRepCommission\": null,'+
		'        \"portalContact\": \"\",'+
		'        \"portalContactEmail\": \"\",'+
		'        \"alreadyRegistered\": false,'+
		'        \"homeOwner\": \"\",'+
		'        \"creditStatus\": \"HFCZ\",'+
		'        \"poRequired\": \"Optional\",'+
		'        \"viewDocumentIn\": false,'+
		'        \"emailPortalLink\": false,'+
		'        \"messageDetails\": null,'+
		'        \"reservationId\": null,'+
		'        \"accountId\": \"10492\",'+
		'        \"startDate\": \"2013-05-02\",'+
		'        \"plannedCollectionDate\": \"2013-05-29\",'+
		'        \"billingAddressId\": 0,'+
		'        \"billingAddress\": {'+
		'            \"name\": \"ALLEN CONSTRUCTION CO///CCA\",'+
		'            \"address1\": \"326 COOPER STREET BLDG A 1\",'+
		'            \"address2\": \"\",'+
		'            \"address3\": \"CEDAR HILL\",'+
		'            \"address4\": \"\",'+
		'            \"state\": \"TX\",'+
		'            \"countryId\": \"USA\",'+
		'            \"crossStreet1\": null,'+
		'            \"crossStreet2\": null,'+
		'            \"taxId\": null,'+
		'            \"deliveryZone\": null,'+
		'            \"cityZone\": 0,'+
		'            \"zoneWarning\": null,'+
		'            \"latitude\": null,'+
		'            \"longitude\": null,'+
		'            \"oldPostalCode\": null,'+
		'            \"zipCode\": \"75104-2628\",'+
		'            \"distanceFromBranch\": null,'+
		'            \"distanceBranch\": null,'+
		'            \"fulfillingBranchId\": null,'+
		'            \"fulfillingBranchName\": null'+
		'        },'+
		'        \"extras\": ['+
		'            {'+
		'                \"id\": \"DELIVERY\",'+
		'                \"description\": \"Delivery\",'+
		'                \"quantity\": 1,'+
		'                \"price\": \"90.00\",'+
		'                \"total\": \"90.00\",'+
		'                \"rate1\": {'+
		'                    \"rate\": \"90.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate2\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate3\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate4\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate5\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate6\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate7\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate8\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"include\": true,'+
		'                \"mandatory\": true,'+
		'                \"priceEditable\": true,'+
		'                \"quantityEditable\": false,'+
		'                \"quantityRequired\": false'+
		'            },'+
		'            {'+
		'                \"id\": \"PICKUP\",'+
		'                \"description\": \"Pick up\",'+
		'                \"quantity\": 1,'+
		'                \"price\": \"90.00\",'+
		'                \"total\": \"90.00\",'+
		'                \"rate1\": {'+
		'                    \"rate\": \"90.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate2\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate3\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate4\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate5\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate6\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate7\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate8\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"include\": true,'+
		'                \"mandatory\": true,'+
		'                \"priceEditable\": true,'+
		'                \"quantityEditable\": false,'+
		'                \"quantityRequired\": false'+
		'            },'+
		'            {'+
		'                \"id\": \"DELFSCG\",'+
		'                \"description\": \"Fuel Surcharge Delivery\",'+
		'                \"quantity\": 1,'+
		'                \"price\": \"18.00\",'+
		'                \"total\": \"18.00\",'+
		'                \"rate1\": {'+
		'                    \"rate\": \"18.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate2\": {'+
		'                    \"rate\": \"25.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate3\": {'+
		'                    \"rate\": \"45.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate4\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate5\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate6\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate7\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate8\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"include\": true,'+
		'                \"mandatory\": true,'+
		'                \"priceEditable\": false,'+
		'                \"quantityEditable\": false,'+
		'                \"quantityRequired\": false'+
		'            },'+
		'            {'+
		'                \"id\": \"PUFSCG\",'+
		'                \"description\": \"Fuel Surcharge Pick Up\",'+
		'                \"quantity\": 1,'+
		'                \"price\": \"18.00\",'+
		'                \"total\": \"18.00\",'+
		'                \"rate1\": {'+
		'                    \"rate\": \"18.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate2\": {'+
		'                    \"rate\": \"25.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate3\": {'+
		'                    \"rate\": \"45.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate4\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate5\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate6\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate7\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate8\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"include\": true,'+
		'                \"mandatory\": true,'+
		'                \"priceEditable\": false,'+
		'                \"quantityEditable\": false,'+
		'                \"quantityRequired\": false'+
		'            },'+
		'            {'+
		'                \"id\": \"PPE1\",'+
		'                \"description\": \"Personal Property Expense\",'+
		'                \"quantity\": 1,'+
		'                \"price\": \"4.20\",'+
		'                \"total\": \"0.00\",'+
		'                \"rate1\": {'+
		'                    \"rate\": \"4.20\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate2\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate3\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate4\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate5\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate6\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate7\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate8\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"include\": true,'+
		'                \"mandatory\": true,'+
		'                \"priceEditable\": false,'+
		'                \"quantityEditable\": false,'+
		'                \"quantityRequired\": false'+
		'            }'+
		'        ],'+
		'        \"quoteExpires\": \"2013-05-22\",'+
		'        \"certificateOfInsurance\": \"On-Site - Not Applicable\",'+
		'        \"delivery\": \"108.00\",'+
		'        \"rentalCharge\": \"0.00\",'+
		'        \"pickUp\": \"108.00\",'+
		'        \"accessories\": \"0.00\",'+
		'        \"llw\": \"0.00\",'+
		'        \"other\": \"0.00\",'+
		'        \"codAmount\": \"0.00\",'+
		'        \"tax\": \"17.82\",'+
		'        \"totalCodAmount\": \"233.82\",'+
		'        \"hireTerms\": \"Net 10\",'+
		'        \"customerText1\": \"\",'+
		'        \"type\": \"rental\",'+
		'        \"mobilization\": 1,'+
		'        \"branchId\": \"106\",'+
		'        \"ytdSales\": 0,'+
		'        \"shippingDate\": \"2013-05-01\",'+
		'        \"shippingAddressId\": 0,'+
		'        \"shippingAddress\": {'+
		'            \"name\": \"ALLEN CONSTRUCTION CO///CCA\",'+
		'            \"address1\": \"326 COOPER STREET BLDG A 1\",'+
		'            \"address2\": \"\",'+
		'            \"address3\": \"CEDAR HILL\",'+
		'            \"address4\": \"\",'+
		'            \"state\": \"TX\",'+
		'            \"countryId\": \"USA\",'+
		'            \"crossStreet1\": \"\",'+ 
		'            \"crossStreet2\": \"\",'+
		'            \"taxId\": \"441133680\",'+ 
		'            \"deliveryZone\": \"\",'+
		'            \"cityZone\": 0,'+
		'            \"zoneWarning\": null,'+
		'            \"latitude\": null,'+
		'            \"longitude\": null,'+
		'            \"oldPostalCode\": null,'+
		'            \"zipCode\": \"75104-2628\",'+
		'            \"distanceFromBranch\": 0,'+
		'            \"distanceBranch\": null,'+
		'            \"fulfillingBranchId\": \"106\",'+
		'            \"fulfillingBranchName\": \"Dallas\"'+
		'        },'+
		'        \"shippingContactDetails\": {'+
		'            \"id\": \"\",'+
		'            \"name\": \"James Collins\",'+
		'            \"tel\": \"\",'+
		'            \"fax\": \"\",'+
		'            \"email\": \"\",'+
		'            \"mobile\": \"\"'+
		'        },'+
		'        \"shippingInstructions\": \"\",'+
		'        \"rentalLength\": 1'+
		'    }'+
		'}';
		EditFullQUoteService_AC obj = new EditFullQUoteService_AC();
		return obj.parse(json);
    }   
    
    
    
    public static  EditFullQUoteService_AC getEditSalesFullQuoteData()
    { 
    	String json = '{'+
		'    \"salesQuote\": {'+
		'        \"documentId\": 126025351,'+
		'        \"companyId\": 1,'+
		'        \"transactionId\": \"ON\",'+
		'        \"salesRep1\": \"1234\",'+
		'        \"salesRep1Name\": \"Lavanya Shivara\",'+
		'        \"salesRep2\": \"1234\",'+
		'        \"salesRep2Name\": \"Lavanya Shivara\",'+
		'        \"narrative1\": \"\",'+
		'        \"narrative2\": \"\",'+
		'        \"instructionText\": \"\",'+
		'        \"status\": \"Q\",'+
		'        \"modifiedTimestamp\": 1366615671000,'+
		'        \"billingContactDetails\": {'+
		'            \"id\": \"\",'+
		'            \"name\": \"ALLEN CONSTRUCTION CO///CCA\",'+
		'            \"tel\": \"972-293-7846\",'+
		'            \"fax\": \"\",'+
		'            \"email\": \"\",'+
		'            \"mobile\": null'+
		'        },'+
		'        \"reference\": \"REQUIRED\",'+
		'        \"poExpires\": null,'+
		'        \"creditApproval\": \"\",'+
		'        \"taxExemptAuthorisation\": \"\",'+
		'        \"taxExempt\": false,'+
		'        \"quoteTotal\": \"FI\",'+
		'        \"lines\": ['+
		'            {'+
		'                \"itemId\": \"10S2\",'+
		'                \"ecode\": \"\",'+
		'                \"reference\": \"\",'+
		'                \"description\": \"10\' CONTAINER\",'+
		'                \"lineValue\": \"0.00\",'+
		'                \"quantity\": 1,'+
		'                \"price\": \"0.00\",'+
		'                \"invoiceDiscountApplicable\": false,'+
		'                \"lockItemCode\": null,'+
		'                \"lineId\": 1,'+
		'                \"internetCoupon\": \"\",'+
		'                \"chargeCode\": {'+
		'                    \"description\": null,'+
		'                    \"active\": false,'+
		'                    \"id\": \"MONTHLY\"'+
		'                },'+
		'                \"rate1\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": \"1 Period\",'+
		'                    \"editable\": true'+
		'                },'+
		'                \"rate2\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": \"2-6 Periods\",'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate3\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": \"7-12 Periods\",'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate4\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": \"13+ Periods\",'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate5\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": \"Contractor\",'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate6\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": \"National\",'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate7\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": \"Xmas Rate\",'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate8\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": \"Min Xmas\",'+
		'                    \"editable\": false'+
		'                },'+
		'                \"commission1\": \"0.00\",'+
		'                \"commission2\": \"0.00\",'+
		'                \"commission3\": \"0.00\",'+
		'                \"commission4\": \"0.00\"'+
		'            }'+
		'        ],'+
		'        \"analysisSet1\": {'+
		'            \"header\": {'+
		'                \"id\": 102,'+
		'                \"description\": \"Ad Source\"'+
		'            },'+
		'            \"selection\": {'+
		'                \"id\": \"DM\",'+
		'                \"description\": \"Direct Mail\"'+
		'            }'+
		'        },'+
		'        \"analysisSet2\": {'+
		'            \"header\": {'+
		'                \"id\": 103,'+
		'                \"description\": \"Customer Type\"'+
		'            },'+
		'            \"selection\": {'+
		'                \"id\": \"2\",'+
		'                \"description\": \"Retail Trade\"'+
		'            }'+
		'        },'+
		'        \"analysisSet3\": {'+
		'            \"header\": {'+
		'                \"id\": 110,'+
		'                \"description\": \"Deferred\"'+
		'            },'+
		'            \"selection\": {'+
		'                \"id\": \"YES\",'+
		'                \"description\": \"Yes\"'+
		'            }'+
		'        },'+
		'        \"analysisSet4\": null,'+
		'        \"analysisSet5\": null,'+
		'        \"additionalAnalysisSet1\": {'+
		'            \"header\": {'+
		'                \"id\": 111,'+
		'                \"description\": \"Del Time\"'+
		'            },'+
		'            \"selection\": {'+
		'                \"id\": \"1PM\",'+
		'                \"description\": \"Priority PM\"'+
		'            }'+
		'        },'+
		'        \"additionalAnalysisSet2\": {'+
		'            \"header\": {'+
		'                \"id\": 112,'+
		'                \"description\": \"Call First\"'+
		'            },'+
		'            \"selection\": {'+
		'                \"id\": \"YES\",'+
		'                \"description\": \"Call First\"'+
		'            }'+
		'        },'+
		'        \"additionalAnalysisSet3\": {'+
		'            \"header\": {'+
		'                \"id\": 113,'+
		'                \"description\": \"Door Dir\"'+
		'            },'+
		'            \"selection\": {'+
		'                \"id\": \"DPCMM\",'+
		'                \"description\": \"MMI Cab\"'+
		'            }'+
		'        },'+
		'        \"additionalAnalysisSet4\": {'+
		'            \"header\": {'+
		'                \"id\": 114,'+
		'                \"description\": \"Movement Type\"'+
		'            },'+
		'            \"selection\": {'+
		'                \"id\": \"DR\",'+
		'                \"description\": \"Dry Run\"'+
		'            }'+
		'        },'+
		'        \"additionalAnalysisSet5\": {'+
		'            \"header\": {'+
		'                \"id\": 115,'+
		'                \"description\": \"Appearance\"'+
		'            },'+
		'            \"selection\": {'+
		'                \"id\": \"VIMP\",'+
		'                \"description\": \"Very Important\"'+
		'            }'+
		'        },'+
		'        \"termsCode\": \"New Customer\",'+
		'        \"invoicedBalance\": \"0.00\",'+
		'        \"lastInvoiceDate\": null,'+
		'        \"writeUpRepCommission\": null,'+
		'        \"nscRepCommission\": null,'+
		'        \"portalContact\": \"\",'+
		'        \"portalContactEmail\": \"\",'+
		'        \"alreadyRegistered\": false,'+
		'        \"homeOwner\": \"\",'+
		'        \"creditStatus\": \"HFCZ\",'+
		'        \"poRequired\": \"Optional\",'+
		'        \"viewDocumentIn\": false,'+
		'        \"emailPortalLink\": false,'+
		'        \"messageDetails\": null,'+
		'        \"reservationId\": null,'+
		'        \"accountId\": \"10492\",'+
		'        \"startDate\": \"2013-05-02\",'+
		'        \"plannedCollectionDate\": \"2013-05-29\",'+
		'        \"billingAddressId\": 0,'+
		'        \"billingAddress\": {'+
		'            \"name\": \"ALLEN CONSTRUCTION CO///CCA\",'+
		'            \"address1\": \"326 COOPER STREET BLDG A 1\",'+
		'            \"address2\": \"\",'+
		'            \"address3\": \"CEDAR HILL\",'+
		'            \"address4\": \"\",'+
		'            \"state\": \"TX\",'+
		'            \"countryId\": \"USA\",'+
		'            \"crossStreet1\": null,'+
		'            \"crossStreet2\": null,'+
		'            \"taxId\": null,'+
		'            \"deliveryZone\": null,'+
		'            \"cityZone\": 0,'+
		'            \"zoneWarning\": null,'+
		'            \"latitude\": null,'+
		'            \"longitude\": null,'+
		'            \"oldPostalCode\": null,'+
		'            \"zipCode\": \"75104-2628\",'+
		'            \"distanceFromBranch\": null,'+
		'            \"distanceBranch\": null,'+
		'            \"fulfillingBranchId\": null,'+
		'            \"fulfillingBranchName\": null'+
		'        },'+
		'        \"extras\": ['+
		'            {'+
		'                \"id\": \"DELIVERY\",'+
		'                \"description\": \"Delivery\",'+
		'                \"quantity\": 1,'+
		'                \"price\": \"90.00\",'+
		'                \"total\": \"90.00\",'+
		'                \"rate1\": {'+
		'                    \"rate\": \"90.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate2\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate3\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate4\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate5\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate6\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate7\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate8\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"include\": true,'+
		'                \"mandatory\": true,'+
		'                \"priceEditable\": true,'+
		'                \"quantityEditable\": false,'+
		'                \"quantityRequired\": false'+
		'            },'+
		'            {'+
		'                \"id\": \"PICKUP\",'+
		'                \"description\": \"Pick up\",'+
		'                \"quantity\": 1,'+
		'                \"price\": \"90.00\",'+
		'                \"total\": \"90.00\",'+
		'                \"rate1\": {'+
		'                    \"rate\": \"90.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate2\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate3\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate4\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate5\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate6\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate7\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate8\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"include\": true,'+
		'                \"mandatory\": true,'+
		'                \"priceEditable\": true,'+
		'                \"quantityEditable\": false,'+
		'                \"quantityRequired\": false'+
		'            },'+
		'            {'+
		'                \"id\": \"DELFSCG\",'+
		'                \"description\": \"Fuel Surcharge Delivery\",'+
		'                \"quantity\": 1,'+
		'                \"price\": \"18.00\",'+
		'                \"total\": \"18.00\",'+
		'                \"rate1\": {'+
		'                    \"rate\": \"18.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate2\": {'+
		'                    \"rate\": \"25.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate3\": {'+
		'                    \"rate\": \"45.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate4\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate5\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate6\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate7\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate8\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"include\": true,'+
		'                \"mandatory\": true,'+
		'                \"priceEditable\": false,'+
		'                \"quantityEditable\": false,'+
		'                \"quantityRequired\": false'+
		'            },'+
		'            {'+
		'                \"id\": \"PUFSCG\",'+
		'                \"description\": \"Fuel Surcharge Pick Up\",'+
		'                \"quantity\": 1,'+
		'                \"price\": \"18.00\",'+
		'                \"total\": \"18.00\",'+
		'                \"rate1\": {'+
		'                    \"rate\": \"18.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate2\": {'+
		'                    \"rate\": \"25.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate3\": {'+
		'                    \"rate\": \"45.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate4\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate5\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate6\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate7\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate8\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"include\": true,'+
		'                \"mandatory\": true,'+
		'                \"priceEditable\": false,'+
		'                \"quantityEditable\": false,'+
		'                \"quantityRequired\": false'+
		'            },'+
		'            {'+
		'                \"id\": \"PPE1\",'+
		'                \"description\": \"Personal Property Expense\",'+
		'                \"quantity\": 1,'+
		'                \"price\": \"4.20\",'+
		'                \"total\": \"0.00\",'+
		'                \"rate1\": {'+
		'                    \"rate\": \"4.20\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate2\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate3\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate4\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate5\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate6\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate7\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate8\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"include\": true,'+
		'                \"mandatory\": true,'+
		'                \"priceEditable\": false,'+
		'                \"quantityEditable\": false,'+
		'                \"quantityRequired\": false'+
		'            }'+
		'        ],'+
		'        \"quoteExpires\": \"2013-05-22\",'+
		'        \"certificateOfInsurance\": \"On-Site - Not Applicable\",'+
		'        \"delivery\": \"108.00\",'+
		'        \"rentalCharge\": \"0.00\",'+
		'        \"pickUp\": \"108.00\",'+
		'        \"accessories\": \"0.00\",'+
		'        \"llw\": \"0.00\",'+
		'        \"other\": \"0.00\",'+
		'        \"codAmount\": \"0.00\",'+
		'        \"tax\": \"17.82\",'+
		'        \"totalCodAmount\": \"233.82\",'+
		'        \"hireTerms\": \"Net 10\",'+
		'        \"customerText1\": \"\",'+
		'        \"type\": \"rental\",'+
		'        \"mobilization\": 1,'+
		'        \"branchId\": \"106\",'+
		'        \"ytdSales\": 0,'+
		'        \"shippingDate\": \"2013-05-01\",'+
		'        \"shippingAddressId\": 0,'+
		'        \"shippingAddress\": {'+
		'            \"name\": \"ALLEN CONSTRUCTION CO///CCA\",'+
		'            \"address1\": \"326 COOPER STREET BLDG A 1\",'+
		'            \"address2\": \"\",'+
		'            \"address3\": \"CEDAR HILL\",'+
		'            \"address4\": \"\",'+
		'            \"state\": \"TX\",'+
		'            \"countryId\": \"USA\",'+
		'            \"crossStreet1\": \"\",'+ 
		'            \"crossStreet2\": \"\",'+
		'            \"taxId\": \"441133680\",'+ 
		'            \"deliveryZone\": \"\",'+
		'            \"cityZone\": 0,'+
		'            \"zoneWarning\": null,'+
		'            \"latitude\": null,'+
		'            \"longitude\": null,'+
		'            \"oldPostalCode\": null,'+
		'            \"zipCode\": \"75104-2628\",'+
		'            \"distanceFromBranch\": 0,'+
		'            \"distanceBranch\": null,'+
		'            \"fulfillingBranchId\": \"106\",'+
		'            \"fulfillingBranchName\": \"Dallas\"'+
		'        },'+
		'        \"shippingContactDetails\": {'+
		'            \"id\": \"\",'+
		'            \"name\": \"James Collins\",'+
		'            \"tel\": \"\",'+
		'            \"fax\": \"\",'+
		'            \"email\": \"\",'+
		'            \"mobile\": \"\"'+
		'        },'+
		'        \"shippingInstructions\": \"\",'+
		'        \"rentalLength\": 1'+
		'    }'+
		'}';
		EditFullQUoteService_AC obj = new EditFullQUoteService_AC();
		return obj.parse(json);
    } 
    
     public static Summary_Line__c getSummaryLineTransactionalList(string ftId){
       
        Summary_Line__c newSummaryLine = new Summary_Line__c(reference__c = 'test',
		 rate8__c = '0.00', 
		 rate7__c = '0.00',
		 rate5__c = '0.00',
		 rate4__c = '0.00',
		 rate3__c = '0.00',
		 rate2__c = '0.00',
		 rate1__c = '0.00',
		 quantity__c = '1',
		 price__c = '97.00',
		 lockItemCode__c ='2',
		 lineValue__c = '2344',
		 itemId__c = '10i',
		 invoiceDiscountApplicable__c = true,
		 ecode__c = '23',
		 description__c = '10 Deluxe door on 1 end',
		 commission2__c = '0',
		 commission1__c='0',
		 Sequence__c = 1 ,
		 Full_Quote_Transactional__c = ftId, 
		 ChargeCode_description__c='test1',
		 ChargeCode_active__c = true);

         return newSummaryLine;                
    }  

     public static list<HomeBaseBeans.transactions> getTransactionType(){
     	list<HomeBaseBeans.transactions> lstTrans = new list<HomeBaseBeans.transactions>();
     	HomeBaseBeans.transactions trans1 = new HomeBaseBeans.transactions();
     	trans1.Id = 'OFF';
     	trans1.description = 'Rental Office';
     	lstTrans.add(trans1);
     	HomeBaseBeans.transactions trans2 = new HomeBaseBeans.transactions();
     	trans2.Id = 'MOBO';
     	trans2.description = 'Mobile Office';
     	lstTrans.add(trans2);
     	HomeBaseBeans.transactions trans3 = new HomeBaseBeans.transactions();
     	trans3.Id = 'SOFL';
     	trans3.description = 'Sales Fleet Service';
     	lstTrans.add(trans3);
     	return lstTrans;
    }
     public static Product_Extras__c getProductExtrasTransactional(string ftId){
        Product_Extras__c newProductExtras = new Product_Extras__c(mandatory__c = true,
			include__c = true,
			total__c = '115.00',
			rate8__c = '0.00',
			rate7__c = '0.00', 
			rate5__c = '0.00', 
			rate4__c = '0.00', 
			rate3__c = '0.00', 
			rate2__c = '0.00', 
			rate1__c = '0.00', 
			quantity__c = '1', 
			quantityRequired__c = true,
			quantityEditable__c = true,
			price__c = '115.00',
			priceEditable__c = true,
			id__c = 'DELIVERY',
			description__c = 'Delivery Zone',
			Sequence__c = 1,
			Full_Quote_Transactional__c = ftId);
         return newProductExtras;                
    }  
    public static list<HomeBaseBeans.contactSummaryList> getContactSummaryList(){
     	list<HomeBaseBeans.contactSummaryList> lstCons = new list<HomeBaseBeans.contactSummaryList>();
     	HomeBaseBeans.contactSummaryList cl1 = new HomeBaseBeans.contactSummaryList();
     	cl1.surname = 'test surname';
     	cl1.contactId = '1';
     	cl1.emailId = 'contact@test.com';
     	cl1.forename = 'test fn';
     	cl1.isSelected = true;
     	lstCons.add(cl1);
     	
     	HomeBaseBeans.contactSummaryList cl2 = new HomeBaseBeans.contactSummaryList();
     	cl2.surname = 'test surname2';
     	cl2.contactId = '2';
     	cl2.emailId = 'contact2@test.com';
     	cl2.forename = 'test fn2';
     	cl2.isSelected = true;
     	lstCons.add(cl2);
     	
     	return lstCons;
    }
    
    
    public static list<HomeBaseBeans.countries> getCountryList(){
     	list<HomeBaseBeans.countries> lstCountry = new list<HomeBaseBeans.countries>();
     	HomeBaseBeans.countries c1 = new HomeBaseBeans.countries();
     	c1.id = 'USA';
     	c1.Name = 'USA';
     	lstCountry.add(c1);
     	
     	HomeBaseBeans.countries c2 = new HomeBaseBeans.countries();
     	c2.id = 'CANADA';
     	c2.Name = 'CANADA';
     	lstCountry.add(c2);
     	
     	return lstCountry;
    }
    
    public static list<HomeBaseBeans.States> getStateList(){
     	list<HomeBaseBeans.States> lstStates = new list<HomeBaseBeans.States>();
     	HomeBaseBeans.States s1 = new HomeBaseBeans.States();
     	s1.companyId = '1';
     	s1.countryId = '1';
     	s1.id = 'AZ';
     	s1.Name = 'AZ';
     	lstStates.add(s1);
     	
     	HomeBaseBeans.States s2 = new HomeBaseBeans.States();
     	s2.companyId = '1';
     	s2.countryId = '2';
     	s2.id = 'CA';
     	s2.Name = 'CA';
     	lstStates.add(s2);
     	
     	return lstStates;
    } 
    
    public static list<HomeBaseBeans.salesReps> getSalesRepList(){
    	list<HomeBaseBeans.salesReps> lstSrList = new list<HomeBaseBeans.salesReps>();
     	HomeBaseBeans.salesReps sr1 = new HomeBaseBeans.salesReps();
     	sr1.id = '102';
     	sr1.name = 'Jeniffer';
     	sr1.isSelected = true;
     	lstSrList.add(sr1);
     	
     	HomeBaseBeans.salesReps sr2 = new HomeBaseBeans.salesReps();
     	sr2.id = '106';
     	sr2.Name = 'Paul';
     	sr2.isSelected = true;
     	lstSrList.add(sr2);
     	
     	return lstSrList;
    	
    }
    
    
    public static HomeBaseBeans.salesRepsId getSalesRepId(){
     	HomeBaseBeans.salesRepsId sr1 = new HomeBaseBeans.salesRepsId();
     	sr1.id = '102';
     	sr1.name = 'Jeniffer';
     	return sr1;
    	
    }
public static Full_Quote_Transactional__c getTransactionalFullQuote(string ftId){
        Full_Quote_Transactional__c rec=FullQuoteDAO.getFullQuoteTransactional(ftId);
         return rec;                
    }  
    
     public static String getMMIErrorResponse(){
         String error='{"errorCode":"e1"}';
         return error;                
    }
    public static String getMMIExceptionResponse(){
         String error='"error"';
         return error;                
    }
public static HttpResponse getHttpResponse(){
         HttpResponse respo=new HttpResponse();
         respo.setBody('/9j/4AAQSkZJRgABAQEAYABgAAD/4QBuRXhpZgAASUkqAAgAAAAB');
         return respo;                
    }
    
     public static SalesInventoryImages__c getSalesInvImage(){
     	HB_Sales_Inventory__c hb=getHBSalesInventory();
     	insert hb;
        SalesInventoryImages__c rec=new SalesInventoryImages__c();
        rec.Display_Picture__c='http://172.20.20.5:22038/docrep/repository?securitytoken=1377706785492&job=get&uuid=3d7feab1-4e8c-4177-bf5e-e4d2a3b028ab';
        rec.HB_Sales_Inventory__c=hb.Id;
         return rec;                
    }  
    
     public static list<HomeBaseBeans.analysisDtls> getAnalysisDtlsLst(){
     	list<HomeBaseBeans.analysisDtls> adList = new list<HomeBaseBeans.analysisDtls>();
     	HomeBaseBeans.analysisDtls ad1 = new HomeBaseBeans.analysisDtls();
     	ad1.longDescription = 'test lons';
     	ad1.setCodeId = 'CNAP';
     	ad1.setCodeInternal = '102';
     	ad1.setLabel = 'test label';
     	ad1.setNumber = '002';
     	ad1.shortDescription = 'tl';
     	ad1.slotNumber = '1';
     	adList.add(ad1);
     	
     	HomeBaseBeans.analysisDtls ad2 = new HomeBaseBeans.analysisDtls();
     	ad2.longDescription = 'test lons';
     	ad2.setCodeId = 'CNAGP';
     	ad2.setCodeInternal = '102';
     	ad2.setLabel = 'test label';
     	ad2.setNumber = '002';
     	ad2.shortDescription = 'tl';
     	ad2.slotNumber = '2';
     	adList.add(ad2);
     	return adList;
    }
    
    public static HomeBaseBeans.account getAccountList(){
     	HomeBaseBeans.account acc1 = new HomeBaseBeans.account();
     	HomeBaseBeans.accountAddress acc = new HomeBaseBeans.accountAddress();
     	acc1.accountAddress = acc;
     	acc1.name = 'test acc';
     	acc1.id = '1';
     	acc1.invoicedBalance = 102.25;
     	acc1.salesTerms = 'test terms';
     	acc1.termsCode = '002';
     	acc1.creditStatus = 'tl';
     	acc1.errorMessage = '';
     	acc1.analysisDetails = getAnalysisDtlsLst();
     	
     	return acc1;
    }
    
    public static list<HomeBaseBeans.Products> getProductList(){
    	list<HomeBaseBeans.Products> plst = new list<HomeBaseBeans.Products>();
    	
    	HomeBaseBeans.Products p1 = new HomeBaseBeans.Products();
    	p1.Id = '10i';
    	p1.Description = '10i';
    	p1.qtyAvail = '10i';
    	p1.qtyFree = '10i';
    	p1.qtyWip = '10i';
    	p1.qtyWip1 = '10i';
    	p1.qtyWip2 = '10i';
    	p1.qtyWip3 = '10i';
    	p1.qtyWip4 = '10i';
    	p1.qtyWip5 = '10i';
    	p1.qtyWip6 = '10i';
    	p1.qtyWip7 = '10i';
    	p1.qtyWip8 = '10i';
    	p1.qtyWip9 = '10i';
    	p1.qtyWip10 = '10i';
    	p1.HILRM = '10i';
    	p1.qtyRented = '10i';
    	p1.UtilPercent = '10i';
    	p1.thumbnailUrl = '10i';
    	p1.qtyReserved = '10i';
    	p1.qtyTotal = '10i';
    	p1.commission1 = '10i';
    	p1.commission2 = '10i';
    	p1.commission3 = '10i';
    	p1.commission4 = '10i';
    	p1.llw = '10i';
    	p1.ppe = '10i';
    	p1.mainFeature = '10i';
    	p1.LockType = '10i';
    	p1.lineValue = '10i';
    	
    	p1.quantity = 1.0;
    	p1.lineCount = 1;
    	p1.isSelected = true;
    	
    	HomeBaseBeans.rates r1 = new HomeBaseBeans.rates();
    	r1.rate = '';
    	r1.description = '';
    	r1.editable = true;
    	p1.rate1 = r1;
    	
    	HomeBaseBeans.rates r2 = new HomeBaseBeans.rates();
    	r2.rate = '';
    	r2.description = '';
    	r2.editable = true;
    	p1.rate2 = r2;
    	HomeBaseBeans.rates r3 = new HomeBaseBeans.rates();
    	r3.rate = '';
    	r3.description = '';
    	r3.editable = true;
    	p1.rate3 = r3;
    	HomeBaseBeans.rates r4 = new HomeBaseBeans.rates();
    	r4.rate = '';
    	r4.description = '';
    	r4.editable = true;
    	p1.rate4 = r4;
    	HomeBaseBeans.rates r5 = new HomeBaseBeans.rates();
    	r5.rate = '';
    	r5.description = '';
    	r5.editable = true;
    	p1.rate5 = r5;
    	HomeBaseBeans.rates r6 = new HomeBaseBeans.rates();
    	r6.rate = '';
    	r6.description = '';
    	r6.editable = true;
    	p1.rate6 = r6;
    	HomeBaseBeans.rates r7 = new HomeBaseBeans.rates();
    	r7.rate = '';
    	r7.description = '';
    	r7.editable = true;
    	p1.rate7 = r7;
    	HomeBaseBeans.rates r8 = new HomeBaseBeans.rates();
    	r8.rate = '';
    	r8.description = '';
    	r8.editable = true;
    	p1.rate8= r8;
    	
    	plst.add(p1);
    	
    	HomeBaseBeans.Products p2 = new HomeBaseBeans.Products();
    	p2.Id = '10i';
    	p2.Description = '10i';
    	p2.qtyAvail = '10i';
    	p2.qtyFree = '10i';
    	p2.qtyWip = '10i';
    	p2.qtyWip1 = '10i';
    	p2.qtyWip2 = '10i';
    	p2.qtyWip3 = '10i';
    	p2.qtyWip4 = '10i';
    	p2.qtyWip5 = '10i';
    	p2.qtyWip6 = '10i';
    	p2.qtyWip7 = '10i';
    	p2.qtyWip8 = '10i';
    	p2.qtyWip9 = '10i';
    	p2.qtyWip10 = '10i';
    	p2.HILRM = '10i';
    	p2.qtyRented = '10i';
    	p2.UtilPercent = '10i';
    	p2.thumbnailUrl = '10i';
    	p2.qtyReserved = '10i';
    	p2.qtyTotal = '10i';
    	p2.commission1 = '10i';
    	p2.commission2 = '10i';
    	p2.commission3 = '10i';
    	p2.commission4 = '10i';
    	p2.llw = '10i';
    	p2.ppe = '10i';
    	p2.mainFeature = '10i';
    	p2.LockType = '10i';
    	p2.lineValue = '10i';
    	
    	p2.quantity = 1.0;
    	p2.lineCount = 1;
    	p2.isSelected = true;
    	
    	HomeBaseBeans.rates r12 = new HomeBaseBeans.rates();
    	r12.rate = '';
    	r12.description = '';
    	r12.editable = true;
    	p2.rate1 = r12;
    	
    	HomeBaseBeans.rates r22 = new HomeBaseBeans.rates();
    	r22.rate = '';
    	r22.description = '';
    	r22.editable = true;
    	p2.rate2 = r22;
    	HomeBaseBeans.rates r32 = new HomeBaseBeans.rates();
    	r32.rate = '';
    	r32.description = '';
    	r32.editable = true;
    	p2.rate3 = r32;
    	HomeBaseBeans.rates r42 = new HomeBaseBeans.rates();
    	r42.rate = '';
    	r42.description = '';
    	r42.editable = true;
    	p2.rate4 = r42;
    	HomeBaseBeans.rates r52 = new HomeBaseBeans.rates();
    	r52.rate = '';
    	r52.description = '';
    	r52.editable = true;
    	p2.rate5 = r52;
    	HomeBaseBeans.rates r62 = new HomeBaseBeans.rates();
    	r62.rate = '';
    	r62.description = '';
    	r62.editable = true;
    	p2.rate6 = r62;
    	HomeBaseBeans.rates r72 = new HomeBaseBeans.rates();
    	r72.rate = '';
    	r72.description = '';
    	r72.editable = true;
    	p2.rate7 = r72;
    	HomeBaseBeans.rates r82 = new HomeBaseBeans.rates();
    	r82.rate = '';
    	r82.description = '';
    	r82.editable = true;
    	p2.rate8= r82;
    	
    	plst.add(p2);
    	return plst; 
    }
    
    public static list<FullQuoteWrapper.ContactEmailId> getContactEmailList(){
    	list<FullQuoteWrapper.ContactEmailId> conLst = new list<FullQuoteWrapper.ContactEmailId>();
    	FullQuoteWrapper.ContactEmailId cl1 = new FullQuoteWrapper.ContactEmailId();
    	Contact conObj = getContact();
    	insert conObj;
    	cl1.conRec = conObj;
    	cl1.IsSelected = true;
    	conLst.add(cl1);
    	
    	FullQuoteWrapper.ContactEmailId cl2 = new FullQuoteWrapper.ContactEmailId();
    	Contact conObj2 = getContact();
    	insert conObj2;
    	cl2.conRec = conObj2;
    	cl2.IsSelected = true;
    	conLst.add(cl2);
    	return conLst;
    } 
    
     public static List<HomeBaseBeans.webAddresses> getdescartesLookupFullQuote(){
     	List<HomeBaseBeans.webAddresses> dlList = new List<HomeBaseBeans.webAddresses>();
     	HomeBaseBeans.webAddresses dlObj = new HomeBaseBeans.webAddresses();
     	dlObj.companyId = '1';
     	dlObj.branchId = '1';
     	dlObj.address1 = '1';
     	dlObj.address2 = '1';
     	dlObj.address3 = '1';
     	dlObj.address4 = '1';
     	dlObj.state = '1';
     	dlObj.zipCode = '1';
     	dlObj.countryId = '1';
     	dlObj.crossStreet1 = '1';
     	dlObj.crossStreet2 = '1';
     	dlObj.taxId = '1';
     	dlObj.distanceFromBranch = '1';
     	dlObj.deliveryZone = '1';
     	dlObj.zoneWarning = '1';
     	dlObj.latitude = '1';
     	dlObj.longitude = '1';
     	dlObj.distanceBranch = '1';
     	dlObj.fulfillingBranchId = '1';
     	dlObj.fulfillingBranchName = '1';
     	dlObj.oldPostalCode = '1';
     	dlObj.isSelected = true;
     	dlList.add(dlObj);
     	return dlList;
     }
     
     public static List<HomeBaseBeans.Branches> getBranchesList(){
     	List<HomeBaseBeans.Branches> branchList = new List<HomeBaseBeans.Branches>();
     	HomeBaseBeans.Branches rnchObj = new HomeBaseBeans.Branches();
     	rnchObj.id = '1';
     	rnchObj.name = '1';
     	rnchObj.isSelected = true;
     	branchList.add(rnchObj);
     	return branchList;
     }
     public static List<NewCustomerAccountParser.duplicateAccount> getNewCustomerAccountParserduplicateAccountList(){
     	List<NewCustomerAccountParser.duplicateAccount> NewCustomerAccountParserduplicateAccountList = new List<NewCustomerAccountParser.duplicateAccount>();
     	NewCustomerAccountParser.duplicateAccount NewCustomerAccountParserduplicateAccount = new NewCustomerAccountParser.duplicateAccount();
     	
     		NewCustomerAccountParserduplicateAccount.name ='test';
			NewCustomerAccountParserduplicateAccount.invoicedBalance = '1';
			NewCustomerAccountParserduplicateAccount.lastInvoiceDate = '2013-10-12';
			NewCustomerAccountParserduplicateAccount.taxExemptionCertificate = 'true';
			NewCustomerAccountParserduplicateAccount.taxExempt = ' true';
			NewCustomerAccountParserduplicateAccount.creditStatus = 'Y';
			NewCustomerAccountParserduplicateAccount.duplicateNo = '1';
		    NewCustomerAccountParserduplicateAccount.dateCreated = '2.13-12-12';
			NewCustomerAccountParserduplicateAccount.createdBy = 'Admin';
			NewCustomerAccountParserduplicateAccount.status = 'A';
			NewCustomerAccountParserduplicateAccount.phoneNumber = '895865';
			NewCustomerAccountParserduplicateAccount.salesforceId = '1';
			NewCustomerAccountParserduplicateAccount.addressType ='2';
			NewCustomerAccountParserduplicateAccount.accountType = '1';
			NewCustomerAccountParserduplicateAccount.id = '1';
			NewCustomerAccountParserduplicateAccount.ytdSales = '23';
			NewCustomerAccountParser.address addre = new NewCustomerAccountParser.address();
			addre.addressLine1 = 'test';
			addre.addressLine2 = '53w';
			addre.addressLine3 = 'test';
			addre.addressLine4 = 'iute';
			addre.addressNo = '1';
			addre.countryId = 'USA';
			addre.state = 'AZ';
			addre.zipCode = '587854';
			NewCustomerAccountParserduplicateAccountList.add(NewCustomerAccountParserduplicateAccount);
			return NewCustomerAccountParserduplicateAccountList ;
     
     }
     public static List<HomeBaseBeans.addresses> getAddressesList(){
     	List<HomeBaseBeans.addresses> addrList = new List<HomeBaseBeans.addresses>();
     	HomeBaseBeans.addresses addr1 = new HomeBaseBeans.addresses();
     	addr1.addressNo = '1';
     	addr1.addressLine1 = '1';
     	addr1.addressLine2 = '1';
     	addr1.addressLine3 = '1';
     	addr1.addressLine4 = '1';
     	addr1.state = '1';
     	addr1.zipCode = '1';
     	addr1.countryId = '1';
     	addr1.County = '1';
     	
     	addr1.isInvoiceAddress = true;
     	addr1.isDeliveryAddress = true;
     	addr1.invoiceAddress = true;
     	addr1.deliveryAddress = true;
     	addr1.isSelected = true;
     	
     	addrList.add(addr1);
     	return addrList;
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
    
     public static  List<HomeBaseBeans.quoteLine> getQuoteLineWithoutError()
    {   
    		List<HomeBaseBeans.quoteLine> NewQuoteLineList = new List<HomeBaseBeans.quoteLine>(); 
    		HomeBaseBeans.quoteLine NewQuoteLine = new HomeBaseBeans.quoteLine();
    		NewQuoteLine.itemId ='20zs';
			NewQuoteLine.ecode = '123';
			NewQuoteLine.reference = '25s';
			NewQuoteLine.description = '234';
			NewQuoteLine.lineValue = '234';
			NewQuoteLine.quantity = 1.0;			
			NewQuoteLine.price = 2.0;
			NewQuoteLine.estimatedCost = 2.52;
			NewQuoteLine.payment = 52.00;
			NewQuoteLine.modificationCharge = 52;				
			NewQuoteLine.internetCoupon  = 'asdf';
			NewQuoteLine.lockItemCode = '123';
			NewQuoteLine.commission1 = 123;
			NewQuoteLine.commission2 = 123;
			NewQuoteLine.commission3 = 123;
			NewQuoteLine.commission4 = 123;
			NewQuoteLine.invoiceDiscountApplicable = true; 
			NewQuoteLine.errorMessage = null;
			NewQuoteLine.lineCount = 1;
			NewQuoteLine.isSelected  = true; 
			NewQuoteLine.LockType = 'teste';
			NewQuoteLine.SelectedAccountId = 'teste';
			NewQuoteLine.SelectedPeriod = '2';
			NewQuoteLine.SelectedFromDate = 'teste';
			NewQuoteLine.SelectedRate1 = 'teste';
			NewQuoteLine.SelectedRate2 = 'teste';
			NewQuoteLine.SelectedRate3 = 'teste';
			NewQuoteLine.SelectedRate4 = 'teste';
			NewQuoteLine.LockTypeTotal = 123;
			NewQuoteLine.lineId = '10i';
			NewQuoteLine.removeLine = 'teste';
			NewQuoteLine.gpPercent = 123;
			NewQuoteLine.netBookValue = 123;
			NewQuoteLine.paymentType = 'teste';
			NewQuoteLine.isAccessories = true;
			NewQuoteLine.itemType = 'Accessories Item';
			
			HomeBaseBeans.rates newrate1 = new HomeBaseBeans.rates();
			newrate1.rate = '120.00';
	        newrate1.description = 'test';
	        newrate1.editable = true;
			NewQuoteLine.rate1=newrate1;
			HomeBaseBeans.rates newrate2 = new HomeBaseBeans.rates();
			newrate2.rate = '120.00';
	        newrate2.description = 'test';
	        newrate2.editable = true;
			NewQuoteLine.rate2=newrate2;
			HomeBaseBeans.rates newrate3 = new HomeBaseBeans.rates();
			newrate3.rate = '120.00';
	        newrate3.description = 'test';
	        newrate3.editable = true;
			NewQuoteLine.rate3=newrate3;
			HomeBaseBeans.rates newrate4 = new HomeBaseBeans.rates();
			newrate4.rate = '120.00';
	        newrate4.description = 'test';
	        newrate4.editable = true;
			NewQuoteLine.rate4=newrate4;
			HomeBaseBeans.rates newrate5 = new HomeBaseBeans.rates();
			newrate5.rate = '120.00';
	        newrate5.description = 'test';
	        newrate5.editable = true;
			NewQuoteLine.rate5=newrate5;
			HomeBaseBeans.rates newrate6 = new HomeBaseBeans.rates();
			newrate6.rate = '120.00';
	        newrate6.description = 'test';
	        newrate6.editable = true;
			NewQuoteLine.rate6=newrate6;
			HomeBaseBeans.rates newrate7 = new HomeBaseBeans.rates();
			newrate7.rate = '120.00';
	        newrate7.description = 'test';
	        newrate7.editable = true;
			NewQuoteLine.rate7=newrate7;
			
				HomeBaseBeans.rates newrate8 = new HomeBaseBeans.rates();
			newrate8.rate = '120.00';
	        newrate8.description = 'test';
	        newrate8.editable = true;
			NewQuoteLine.rate8=newrate8;
			
    	 	NewQuoteLineList.add(NewQuoteLine);
    	
        return NewQuoteLineList;
    } 
    
     public static  List<HomeBaseBeans.quoteLine> getQuoteLinewithLock()
    {   
    		List<HomeBaseBeans.quoteLine> NewQuoteLineList = new List<HomeBaseBeans.quoteLine>(); 
    		HomeBaseBeans.quoteLine NewQuoteLine = new HomeBaseBeans.quoteLine();
    		NewQuoteLine.itemId ='CG1';
			NewQuoteLine.ecode = '123';
			NewQuoteLine.reference = '25s';
			NewQuoteLine.description = '234';
			NewQuoteLine.lineValue = '234';
			NewQuoteLine.quantity = 1.0;			
			NewQuoteLine.price = 2.0;
			NewQuoteLine.estimatedCost = 2.52;
			NewQuoteLine.payment = 52.00;
			NewQuoteLine.modificationCharge = 52;				
			NewQuoteLine.internetCoupon  = 'asdf';
			NewQuoteLine.lockItemCode = '123';
			NewQuoteLine.commission1 = 123;
			NewQuoteLine.commission2 = 123;
			NewQuoteLine.commission3 = 123;
			NewQuoteLine.commission4 = 123;
			NewQuoteLine.invoiceDiscountApplicable = true; 
			NewQuoteLine.errorMessage = null;
			NewQuoteLine.lineCount = 1;
			NewQuoteLine.isSelected  = true; 
			NewQuoteLine.LockType = 'teste';
			NewQuoteLine.SelectedAccountId = 'teste';
			NewQuoteLine.SelectedPeriod = '2';
			NewQuoteLine.SelectedFromDate = 'teste';
			NewQuoteLine.SelectedRate1 = 'teste';
			NewQuoteLine.SelectedRate2 = 'teste';
			NewQuoteLine.SelectedRate3 = 'teste';
			NewQuoteLine.SelectedRate4 = 'teste';
			NewQuoteLine.LockTypeTotal = 123;
			NewQuoteLine.lineId = '10i';
			NewQuoteLine.removeLine = 'teste';
			NewQuoteLine.gpPercent = 123;
			NewQuoteLine.netBookValue = 123;
			NewQuoteLine.paymentType = 'teste';
			NewQuoteLine.isAccessories = true;
			NewQuoteLine.itemType = 'Accessories Item';
			
			HomeBaseBeans.rates newrate1 = new HomeBaseBeans.rates();
			newrate1.rate = '120.00';
	        newrate1.description = 'test';
	        newrate1.editable = true;
			NewQuoteLine.rate1=newrate1;
			HomeBaseBeans.rates newrate2 = new HomeBaseBeans.rates();
			newrate2.rate = '120.00';
	        newrate2.description = 'test';
	        newrate2.editable = true;
			NewQuoteLine.rate2=newrate2;
			HomeBaseBeans.rates newrate3 = new HomeBaseBeans.rates();
			newrate3.rate = '120.00';
	        newrate3.description = 'test';
	        newrate3.editable = true;
			NewQuoteLine.rate3=newrate3;
			HomeBaseBeans.rates newrate4 = new HomeBaseBeans.rates();
			newrate4.rate = '120.00';
	        newrate4.description = 'test';
	        newrate4.editable = true;
			NewQuoteLine.rate4=newrate4;
			HomeBaseBeans.rates newrate5 = new HomeBaseBeans.rates();
			newrate5.rate = '120.00';
	        newrate5.description = 'test';
	        newrate5.editable = true;
			NewQuoteLine.rate5=newrate5;
			HomeBaseBeans.rates newrate6 = new HomeBaseBeans.rates();
			newrate6.rate = '120.00';
	        newrate6.description = 'test';
	        newrate6.editable = true;
			NewQuoteLine.rate6=newrate6;
			HomeBaseBeans.rates newrate7 = new HomeBaseBeans.rates();
			newrate7.rate = '120.00';
	        newrate7.description = 'test';
	        newrate7.editable = true;
			NewQuoteLine.rate7=newrate7;
			
				HomeBaseBeans.rates newrate8 = new HomeBaseBeans.rates();
			newrate8.rate = '120.00';
	        newrate8.description = 'test';
	        newrate8.editable = true;
			NewQuoteLine.rate8=newrate8;
			
    	 	NewQuoteLineList.add(NewQuoteLine);
    	
        return NewQuoteLineList;
    } 
    
        public static  HomeBaseBeans.CreateFullQuoteResponse getSaveResponse(){   
    	HomeBaseBeans.CreateFullQuoteResponse respo=new HomeBaseBeans.CreateFullQuoteResponse();
        respo.companyId='1';
        respo.documentId='1234567';
        respo.mobilization='1.0';
        respo.type='sales';
        return respo;
    }
    
    public static QuoteToOrderParser_AC getConvertToOrderResponse(){
    	QuoteToOrderParser_AC qto = new QuoteToOrderParser_AC();
    	QuoteToOrderParser_AC.cls_convertedContractPK qtoCPK = new QuoteToOrderParser_AC.cls_convertedContractPK();
    	qtoCPK.companyId = 1;
    	qtoCPK.documentId = 125464;
    	qtoCPK.mobilization = 1.0;
    	qtoCPK.type = 'rental'; 
    	qto.convertedContractPK = qtoCPK;
    	QuoteToOrderParser_AC.cls_quotePK qtoQPK = new QuoteToOrderParser_AC.cls_quotePK();
    	qtoQPK.companyId = 1;
    	qtoQPK.documentId = 125464125;
    	qtoQPK.mobilization = 1.0;
    	qtoQPK.type = 'rental';
    	qto.quotePK = qtoQPK;
    	return qto;
    }
	     
}