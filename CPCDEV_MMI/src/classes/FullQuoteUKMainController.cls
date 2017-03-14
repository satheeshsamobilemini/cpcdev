/**
* (c) 2015 TEKsystems Global Services
*
* Name           : FullQuoteUKMainController
* Created Date   : 18 March, 2015 @ 1130
* Created By     : Shankar Rao
* Purpose        : Controller class used by 'FullQuoteFormUKPage' VF page.
* 
**/

public class FullQuoteUKMainController {

    public MMI_Full_Quotes_UK__c fullQuote {get; set;}
    public String purchaseOrder {get;set;} 
    public Boolean saveRecord = true;
    public String quoteExpires {get; set;}
    public ID getURLID {get; set;}
    public String selectedRecordId {get; set;}
    public String selectedContactId {get; set;}
    public List<Full_Quote_UK_LineItem__c> allSelectedProducts {get; set;}
    public LIST<String> allAccessories {get; set;}
    public Map<Id, ProductsAgreedWrapper> pdtsAccessoryMap {get; set;}
    public Map<String, LIST<ProductsAgreedWrapper>> pdtTypeAccessoryListMap {get; set;}
    public Boolean ctrlContactSearchButton {get; set;}
    public String billingContactID {get; set;}
    public String billingDelFlag {get; set;}
    public String source{get;set;}
    Map<String, FullQuoteUKHistoryMapping__c> FQCustomSetting;
    public Lead selectedLead;
    public Account selectedAccount{get;set;}
    public Contact selectedContact;
    public String selRate{get;set;}
    public map<Id, Product_UK__c> mapOfProduct;
    Set<String> MainTypeSet;
    private Map<String, Double> selectedRateMap {get; set;}
    private ProductsAgreedWrapper currentProduct {get; set;}
    public boolean markAsRequired{get;set;}
    public string quoteExipreddate{get;set;}
    public boolean isUpsertSuccess{get;set;}
    public static string dummyBillConId{get;set;}
    public boolean sendOrderConfirmation{get; set;}
    public boolean closequote{get; set;}
    public string useremail{get; set;}
    Map<String,String> mapProdTypetoUnitInfo;
    Map<String,String> mapProdTypetoBrochure;
    Branch_Detail__c  objBranchDet;
    Boolean isQuoteFromLead;
    
    
    public FullQuoteUKMainController(){
      closequote= true;  
      MainTypeSet = new Set<String>();
      objBranchDet = new Branch_Detail__c();
      List<Schema.PicklistEntry> pick_list_values = MMI_Full_Quotes_UK__c.getsObjectType().getDescribe().Fields.getMap().get('Product_Type__c').getDescribe().getPickListValues();
      Map<String, SobjectField> fieldMap = MMI_Full_Quotes_UK__c.getsObjectType().getDescribe().Fields.getMap(); 
      for(Schema.PicklistEntry pickvl : pick_list_values){
      MainTypeSet.add(pickvl.getLabel());
      }
       markAsRequired = true;
       ctrlContactSearchButton = false;
       FQCustomSetting = new Map<String, FullQuoteUKHistoryMapping__c>();
       mapProdTypetoUnitInfo = new Map<String,String>();
       mapProdTypetoBrochure = new Map<String,String>();
       selectedLead = new Lead();
       selectedAccount = new Account();
       selectedRateMap = new Map<String, Double>();
       allSelectedProducts = new List<Full_Quote_UK_LineItem__c>();
       isUpsertSuccess = true;
       sendOrderConfirmation = false;
       String queryString = 'Select Sales_Rep__c,Mail_RFD__c, Sales_Rep__r.email,Lead__r.street,Lead__r.state,Lead__r.company,Lead__r.title,Lead__r.LeadSource,Account__r.isPersonAccount,Opportunity__r.Opportunity_Contact_Name_LookUpFilter__c,';
       
      //Sreenivas - Getting quote api names from custom setting to form query
       FQCustomSetting = FullQuoteUKHistoryMapping__c.getAll();
       for(FullQuoteUKHistoryMapping__c CSMap : FQCustomSetting.values())
       {
        queryString = queryString + CSMap.Quote_Field_API_Name__c+',';
       }
       queryString = queryString.removeEnd(',');
       
      //Sreenivas - Prodcuct type,UnitInfo and Brochure mapping from custom setting
       for(ProdTypeDocMapping__c prodMap : ProdTypeDocMapping__c.getAll().values())
       {
          mapProdTypetoUnitInfo.put(prodMap.Product_Type__c,prodMap.UnitInfo_Document_Name__c);
          mapProdTypetoBrochure.put(prodMap.Product_Type__c,prodMap.Brochure_Document_Name__c);
       }
       
       selectedRecordId = ApexPages.currentPage().getParameters().get('Id');
       selectedContactId = ApexPages.currentPage().getParameters().get('conId');
       
       //Shankar - Check if ID is missing in the URL
       if(selectedRecordId == null){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Lead/Account ID is missing'));
       }
       else
       {
        source = selectedRecordId.substring(0, 3) == '00Q' ? 'Lead':selectedRecordId.substring(0, 3) == '001'?'Account':'FullQuote';
       }
       
       //Sreenivas -Logic to execute when user is coming from quote
       if('FullQuote'.equalsIgnoreCase(source))
       {
            queryString = queryString + ' From MMI_Full_Quotes_UK__c where id = \''+selectedRecordId+'\'';
            System.debug('queryString ...'+queryString);
            fullQuote = database.query(queryString);
            purchaseOrder = fullQuote.opportunity__r.Purchase_Order__c;
            if(fullQuote.Status__c == 'Lost')
            {
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Quote already "Lost".So,you can\'t modify the Quote further'));
              
            }
            
            if(fullQuote.Lead__c==null)
            {
             selectedAccount = [SELECT Id, Name,isPersonAccount,BillingCity,BillingPostalCode,BillingStreet,BillingState,FirstName, LastName, Phone,PersonMobilePhone, PersonEmail, Fax 
                                                   FROM Account WHERE ID = :fullQuote.Account__c];
              
              if(selectedAccount.isPersonAccount)
                 ctrlContactSearchButton = true;
            }
            else if(fullQuote.Lead__c!=null)
            {
               ctrlContactSearchButton = true;
               selectedLead = [SELECT Id,HasOptedOutOfEmail, Company, FirstName, LastName, Phone, MobilePhone,LeadSource, Email, Fax,Street,State,Title,Country FROM Lead WHERE ID = :fullQuote.Lead__c];
            }
            quoteExipreddate = fullQuote.Quote_Expires__c!=null?fullQuote.Quote_Expires__c.format():null;
            //FullQuote Line Item Query.
            allSelectedProducts = [SELECT Id, Name, MMI_Full_Quote_UK__c, Product_UK__c,TransportSize__c, Frequency__c, Details__c, Unit_Type_2__c, Is_Other__c, TransportCost__c, Description__c, Itemcode__c, Unit_Type__c, Quantity__c, Price__c, Total__c, LLW__c,is_LLW_Editable__c,Is_Main_Unit__c,Main_Product_Type__c FROM Full_Quote_UK_LineItem__c where MMI_Full_Quote_UK__c =:selectedRecordId];
            if(String.isNotBlank(ApexPages.currentPage().getParameters().get('retURL')))
              fullQuote.status__c = 'Lost';
       }
       else
       {
            selectedContact = new Contact();
            fullQuote = populateOnloadFieldValues();
            fullQuote.Del_Pickup_Costs__c = 0;
            fullQuote.Other__c = 0;
            fullQuote.status__c = 'Draft';
            if('Account'.equalsIgnoreCase(source))
              fullQuote.Account__c = selectedRecordId;
              fullQuote.Quote_Ref__c = populateQuoteRef();
            system.debug('Lead Id : '+selectedRecordId);
             if('Lead'.equalsIgnoreCase(source))
              ctrlContactSearchButton  = true;
       }
    }
        
    //Sreenivas- Method used to generate QuoteRef field value
    public string populateQuoteRef()
     {
         String[] dateArr = String.valueOf(System.now()).split(' ')[0].split('-');
         Map<String,String> mapQuoteRefCS= new Map<String,String>();
         String strdate = '';
         for(QuoteRefMapping__c refCS :QuoteRefMapping__c.getAll().values())
         {
          mapQuoteRefCS.put(refCS.Month_Hour_Value__c,refCS.Month_Hour_String__c);
         }
         
         User logedinUser = [SELECT Id, Quote_Id_Number__c, Name FROM User where id=:UserInfo.getUserId()];
         if(String.isBlank(logedinUser.Quote_Id_Number__c))
         {
          closequote=false;
          ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Please set the "Quote Id Number" field value in User Object'));
          return null;
         }
         //String searchString = 'FQUK'+logedinUser.Quote_Id_Number__c+mapQuoteRefCS.get(dateArr[1])+dateArr[0].subString(2,4)+'%';
         String searchString = Test.isrunningtest() == true?'FQUK007E15001/02':'FQUK'+logedinUser.Quote_Id_Number__c+mapQuoteRefCS.get(dateArr[1])+dateArr[0].subString(2,4)+'%';
         System.debug('searchString...'+searchString);
         List<MMI_Full_Quotes_UK__c> listfulQuote =[SELECT Quote_Ref__c from MMI_Full_Quotes_UK__c where Quote_Ref__c LIKE :searchString order by createddate desc limit 1];
         
         
         if(!listfulQuote.isEmpty())
         {
          String prevQuoteRef = listfulQuote[0].Quote_Ref__c; 
          String[] quorefArr = prevQuoteRef.split('/');
          System.debug('quorefArr...'+quorefArr);
          Integer ver = Integer.valueOf(quorefArr[0].subString(9,12))+1;
          String strVer = '';
          if(String.valueOf(ver).length()==1)
          { 
            strVer = '00'+String.valueOf(ver);
          }
          else if(String.valueOf(ver).length()==2)
          {
            strVer = '0'+String.valueOf(ver);
          }
          else if(String.valueOf(ver).length() == 3)        
          {     
            strVer = String.valueOf(ver);       
          }          
          
          strdate += quorefArr[0].subString(0,9)+strVer+'/00';
          return strDate;
         }
         else
         {
         // System.debug('quorefArr.else..'+quorefArr);
          strdate += searchString.removeEnd('%') +'001/00';
          return strDate;
         } 
     }
    
    //Shankar - Private method to auto populate fields on page load.
    private MMI_Full_Quotes_UK__c populateOnloadFieldValues(){
        
        //SOQL on user object to populate Rep Id, Rep Name
        User currentUserDetails = [SELECT Id, Name,email,Sales_Rep_Id__c FROM User WHERE Id =:Userinfo.getUserId()];
        
        //Populate some default values irrespective of user being navigated form Lead or Account
        MMI_Full_Quotes_UK__c fullQuoteFields = new MMI_Full_Quotes_UK__c();
          fullQuoteFields.Rep_Name__c = currentUserDetails.Name;
          fullQuoteFields.Rep_ID__c = currentUserDetails.Sales_Rep_Id__c;
          fullQuoteFields.Billing_Country__c = 'United Kingdom';
          fullQuoteFields.Delivery_Country__c = 'United Kingdom';
          fullQuoteFields.Sales_Rep__c = currentUserDetails.id;
        
        if(selectedRecordId != null && selectedContactId == null){
               
               //Populate lead details
               if(selectedRecordId.substring(0, 3) == '00Q'){
                    //SOQL on Lead object to retrieve all the required details to per populate the fields
                    selectedLead = [SELECT Id,HasOptedOutOfEmail,Company, city,postalcode,Transaction_Type__c,FirstName, LastName, Phone, MobilePhone,LeadSource, Email,
                                    Fax,Street,State,Title,Country FROM Lead WHERE ID = :selectedRecordId];
                    fullQuoteFields.Type__c = selectedLead.Transaction_Type__c;
                    fullQuoteFields.lead__c = selectedLead.id;
                         
                         //Billing Address details
                         fullQuoteFields.Billing_Company_Name__c = selectedLead.Company;
                         fullQuoteFields.Delivery_Company_Name__c = selectedLead.Company;
                         fullQuoteFields.Billing_Address__c = selectedLead.Street;
                         fullQuoteFields.Billing_City__c = selectedLead.city;
                         fullQuoteFields.Billing_County__c = selectedLead.State;
                         fullQuoteFields.Billing_Postcode__c = selectedLead.postalcode;
                         
                         //Billing Customer Details
                         fullQuoteFields.Billing_First_Name__c = selectedLead.FirstName;
                         fullQuoteFields.Billing_Last_Name__c = selectedLead.LastName;
                         fullQuoteFields.Billing_Phone__c = selectedLead.Phone;
                         fullQuoteFields.Billing_Mobile__c = selectedLead.MobilePhone;
                         fullQuoteFields.Billing_Email__c = selectedLead.Email; 
                         fullQuoteFields.Billing_Fax__c = selectedLead.Fax;
               }
               
               else{
                   ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Unable to find the source, please navigate form Lead or Account page.'));
               }
         }
          else if(selectedContactId != null){
         
                   ctrlContactSearchButton = false;
                   
                   //SOQL on Contact object to retrieve all the required details to per populate the fields if Account type is Bussiness Account
                    selectedContact = [SELECT Id,AccountID, Account.Name, Account.BillingCity,Account.BillingPostalCode,Account.BillingStreet,Account.BillingState,
                                       Account.isPersonAccount, FirstName, LastName, Phone, MobilePhone, Email, Fax FROM Contact WHERE ID =:selectedContactId];
                    selectedAccount = [SELECT Id, Name, BillingCity,BillingPostalCode,BillingStreet,BillingState, FirstName, LastName, Phone,PersonMobilePhone, 
                                       PersonEmail, Fax FROM Account WHERE ID = :selectedRecordId];
                                               
                      fullQuoteFields.BillingContact_RecId__c = selectedContact.id;
                     System.debug('selectedAccount....'+selectedAccount);
                           
                           fullQuoteFields.Account__c = selectedContact.AccountID;
                           if(selectedContact.Account.isPersonAccount)
                                ctrlContactSearchButton = true;
                           //Billing address details
                           fullQuoteFields.Billing_Company_Name__c = selectedContact.Account.Name;
                           fullQuoteFields.Delivery_Company_Name__c = selectedContact.Account.Name;
                           fullQuoteFields.Type__c = 'Hire';
                           fullQuoteFields.Billing_Address__c = selectedContact.Account.BillingStreet;
                           fullQuoteFields.Billing_City__c = selectedContact.Account.BillingCity;
                           fullQuoteFields.Billing_County__c = selectedContact.Account.BillingState;
                           fullQuoteFields.Billing_Postcode__c = selectedContact.Account.BillingPostalCode;
                           
                           
                           //Billing Customer Details
                           fullQuoteFields.Billing_First_Name__c = selectedContact.FirstName;
                           fullQuoteFields.Billing_Last_Name__c = selectedContact.LastName;
                           fullQuoteFields.Billing_Phone__c = selectedContact.Phone;
                           fullQuoteFields.Billing_Mobile__c = selectedContact.MobilePhone;
                           fullQuoteFields.Billing_Email__c = selectedContact.Email; 
                           fullQuoteFields.Billing_Fax__c = selectedContact.Fax;
            }
        
        return fullQuoteFields;
    }
    
    //Shankar - Get contract value fieldset fields on Summary tab
    public List<Schema.FieldSetMember> getContractValueFields() {
        return SObjectType.MMI_Full_Quotes_UK__c.FieldSets.ContractValue.getFields();
    }
    
    //Sreenivas - Get Mark As Lost fieldset fields on FullQuoteMarkAsLost_UK page
    public List<Schema.FieldSetMember> getMarkAsLostFields() {
        return SObjectType.MMI_Full_Quotes_UK__c.FieldSets.Mark_As_Lost.getFields();
    }
    
    //Sreenivas - Get Mark As Lost fieldset fields on FullQuoteMarkAsLost_UK page
    public List<Schema.FieldSetMember> getMarkAsLostAddFields() {
        return SObjectType.MMI_Full_Quotes_UK__c.FieldSets.MarkAsLost_Additional.getFields();
    }
      
    //Shankar - Get all products for the selected product type
    public List<ProductsAgreedWrapper> getProductsWithAgreed(){
        try{
            // Public Map of productId(Key) and ProductsAgreedWrapper(Value) commonly used for all 
            // the actions performed post search.
            pdtsAccessoryMap = new Map<Id, ProductsAgreedWrapper>();
            pdtTypeAccessoryListMap = new Map<String, LIST<ProductsAgreedWrapper>>();
            //dummyPdtInstance is been used as placeholder in table to show blank rows.
            Product_UK__c dummyPdtInstance = new Product_UK__c();
            List<ProductsAgreedWrapper> products = new List<ProductsAgreedWrapper>();
                                products.add(new ProductsAgreedWrapper(dummyPdtInstance, null));
                                products.add(new ProductsAgreedWrapper(dummyPdtInstance, null));
                                products.add(new ProductsAgreedWrapper(dummyPdtInstance, null));
                                products.add(new ProductsAgreedWrapper(dummyPdtInstance, null));
                                products.add(new ProductsAgreedWrapper(dummyPdtInstance, null));
            
            if(fullQuote.Product_Type__c != null && fullQuote.Unit_Size__c != null){
                String productType = '%' + fullQuote.Product_Type__c + '%';
                String unitSize = fullQuote.Unit_Size__c + '%';
                Set<String> accessories = new Set<String>();
                Map<Id, Product_UK_Agreed_Value__c> pdtAgreedValueMap = new Map<Id, Product_UK_Agreed_Value__c>();
                
                List<Product_UK__c> filteredProducts = [SELECT Id, Description__c, Code__c, Type__c, Type2__c, Rate__c, TransportSize__c, Goal__c, Is_Other__c,
                                                               Accessories__c, LLW__c, is_LLW_Editable__c, Unit_Type_2__c FROM Product_UK__c 
                                                                                                                          WHERE Type__c LIKE :productType 
                                                                                                                          AND Size__c LIKE :unitSize
                                                                                                                          AND IsActive__c = true];
                
                if(filteredProducts.isEmpty()){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'No Main Units found for the selected Product Type and Unit Size.'));
                }
                //Get agreed values from the junction object for the selected account.
                String accountPrefix = selectedRecordId == null || selectedRecordId == ''? 'none' : selectedRecordId.substring(0, 3);
                if(accountPrefix == '001'){
                    for(Product_UK_Agreed_Value__c pdtAccAgreed : [SELECT Id, Account__c, Product__c, Agreed_Value__c FROM Product_UK_Agreed_Value__c
                                                                                                                      WHERE Account__c =: selectedRecordId
                                                                                                                      AND Product__c IN :filteredProducts]){
                        pdtAgreedValueMap.put(pdtAccAgreed.Product__c, pdtAccAgreed);        
                    }
                }
                products = new List<ProductsAgreedWrapper>();
                
                //All products main items displayed in the first table, with agreed rates.
                for(Product_UK__c pdts : filteredProducts){
                    
                    if(pdtAgreedValueMap.get(pdts.Id) == null){
                        ProductsAgreedWrapper varPdtAgreedWrapper = new ProductsAgreedWrapper(pdts, '0.0');
                        products.add(varPdtAgreedWrapper);
                        pdtsAccessoryMap.put(pdts.Id, varPdtAgreedWrapper);
                    }
                    else{
                        ProductsAgreedWrapper varPdtAgreedWrapper = new ProductsAgreedWrapper(pdts, String.valueOf(pdtAgreedValueMap.get(pdts.Id).Agreed_Value__c));
                        products.add(varPdtAgreedWrapper);
                        pdtsAccessoryMap.put(pdts.Id, varPdtAgreedWrapper);
                    }
                }
                for(ProductAccessoriesMapping__c accCategory : ProductAccessoriesMapping__c.getAll().values()){
                    if(accCategory.Product_Type__c == fullQuote.Product_Type__c){
                        accessories.add(accCategory.Accessory__c);
                        pdtTypeAccessoryListMap.put(accCategory.Accessory__c.toLowerCase(), new LIST<ProductsAgreedWrapper>());   
                    }
                }
                allAccessories = new LIST<String>();
                allAccessories.addAll(accessories);
                allAccessories.sort();
                system.debug('Accessories = '+allAccessories);
                
                getAccessories();
                
                if(products.size() < 5){
                    INTEGER size = 5 - products.size();
                    for(Integer i=0; i<size; i++)
                    {
                       products.add(new ProductsAgreedWrapper(dummyPdtInstance, null));
                    }
                }
            }
            return products;
        }catch(Exception e){
            system.debug('searchProducts method Exception : '+e);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, e.getMessage()));
            return null;
        }
    }
    
    //Shankar - Get all accessories for the products
    public void getAccessories(){
        try{
            if(allAccessories.isEmpty()){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'No Accessories found for the selected Product Type.'));  
            }
            else{
                 String unitSize = fullQuote.Unit_Size__c + '%';
                 for(Product_UK__c accessories : [SELECT Id, Description__c, Code__c, Type__c, Type2__c, Rate__c, Goal__c, TransportSize__c, Is_Other__c, 
                                                         Accessories__c, LLW__c, is_LLW_Editable__c, Unit_Type_2__c FROM Product_UK__c 
                                                                                                                    WHERE Type__c LIKE :allAccessories
                                                                                                                    AND (Size__c LIKE :unitSize OR Size__c=null)
                                                                                                                    AND IsActive__c = true]){
                     ProductsAgreedWrapper varPdtAgreedWrapper = new ProductsAgreedWrapper(accessories, '0.0');
                         pdtsAccessoryMap.put(accessories.Id, varPdtAgreedWrapper);
                         pdtTypeAccessoryListMap.get(accessories.Type__c.toLowerCase()).add(varPdtAgreedWrapper);
                 }
            }
        }catch(Exception e){
            system.debug('getAccessories method Exception : '+e);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, e.getMessage()));
        }
    }
    
    //Shankar - Selected product item
    public void getSelectedProductDetails(){
        try{
            String currentProductId = Apexpages.currentPage().getParameters().get('ProductID');
            
            ProductsAgreedWrapper getSelectedPdtDetails = pdtsAccessoryMap.get(currentProductId);
                //Get the selected product in the private global product variable for future use. 
                
                currentProduct = getSelectedPdtDetails;
                
                    //Get the product kicker & goal rate in private map variable for future use.
                    selectedRateMap.put('Kicker', getSelectedPdtDetails.pdtItem.Rate__c == null || getSelectedPdtDetails.pdtItem.Rate__c==''? 
                                                  0.0 : Decimal.valueOf(getSelectedPdtDetails.pdtItem.Rate__c));
                    selectedRateMap.put('Goal', getSelectedPdtDetails.pdtItem.Goal__c == null ? 0.0 : getSelectedPdtDetails.pdtItem.Goal__c);
                    selectedRateMap.put('Agreed', Decimal.valueOf(getSelectedPdtDetails.pdtAgreedValue));
                
                    //Populate the kicker rate for the selected product.
                    fullQuote.Select_Rate__c = 'Kicker';
                    fullQuote.Selected_rate__c = getSelectedPdtDetails.pdtItem.Rate__c==null? 0.0 : Decimal.valueOf(getSelectedPdtDetails.pdtItem.Rate__c);
                    selRate = getSelectedPdtDetails.pdtItem.Rate__c==null? '0.0' : getSelectedPdtDetails.pdtItem.Rate__c;
                    fullQuote.Quantity__c = 1; 
        }catch(Exception e){
            system.debug('getSelectedProductDetails method Exception : '+e);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, e.getMessage()));
        }  
    }
    
    //Shankar - OnChange of Select Rate picklist in Products Tab the below method is called.
    public void getSelectRate(){
        try{
            if(selectedRateMap.isEmpty() && currentProduct == null){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Please select a product first.'));    
            }
            else{
                    if(fullQuote.Select_Rate__c == 'Kicker'){
                        fullQuote.Selected_rate__c = Decimal.valueOf(selectedRateMap.get('Kicker'));
                        selRate = String.valueOf(selectedRateMap.get('Kicker'));
                    }
                    else if(fullQuote.Select_Rate__c == 'Goal'){
                        fullQuote.Selected_rate__c = Decimal.valueOf(selectedRateMap.get('Goal'));
                        selRate = String.valueOf(selectedRateMap.get('Goal'));
                    }
                    else if(fullQuote.Select_Rate__c == 'Agreed'){
                        fullQuote.Selected_rate__c = Decimal.valueOf(selectedRateMap.get('Agreed'));
                        selRate = String.valueOf(selectedRateMap.get('Agreed'));
                    }
                    else{
                        fullQuote.Selected_rate__c = 0.0;
                        selRate = '0.0';
                    }
                }
        }catch(Exception e){
            system.debug('getSelectRate method Exception : '+e);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, e.getMessage()));
        }
    }
    
    //Shankar - Add to basket functionality
    public void addToBasket(){
        try{    
            if(selectedRateMap.isEmpty() && currentProduct == null){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Please select a product first.'));    
            }
            else{
                fullQuote.Delivery_Postcode__c = Apexpages.currentPage().getParameters().get('PostCode');
                if(fullQuote.Delivery_Postcode__c == null || fullQuote.Delivery_Postcode__c == ''){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Please enter a valid Post Code in Delivery Tab.'));
                }
                else{
                    String quantity =  Apexpages.currentPage().getParameters().get('Quantity');
                    String selectedRate = Apexpages.currentPage().getParameters().get('SelectedRate');
                    fullQuote.Delivery_Postcode__c = Apexpages.currentPage().getParameters().get('PostCode');
                    quantity = quantity == null||quantity==''? '1' : quantity;
                    selectedRate = selectedRate == null||selectedRate==''? '0.0' : selectedRate;
                    system.debug('Quantity = '+ quantity+' Selected Rate = '+selectedRate);
                    system.debug('Product = '+currentProduct);
                    if(currentProduct != null){
                        addToBasketList(currentProduct, Integer.valueOf(quantity), Decimal.valueOf(selectedRate), true, fullQuote.Product_Type__c);
                        //Reset summary tab fields if basket is empty.
                        if(fullQuote.Rental_Charges__c != null){
                            resetSummaryTabFields();
                        }
                    }
                    else{
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Unexpect error occured, contact your System Administrator or Reload the page.'));
                    }
                }        
            } 
        }
        catch(Exception e){
            system.debug('addToBasket method Exception : '+e);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, e.getMessage()));
        }
    }
    
    //Shankar - Dummy please remove.
    public void addAccessoryToBasket(){}
    
    //Shankar - Add accessories to Shopping Basket
    public void addAccessoriesToBasket(){
        system.debug('--inside addaccessoriestobasket--');
        try{
            String accPdtId = Apexpages.currentPage().getParameters().get('AccessoryProductItemId');
            Integer accListIndex = Integer.valueOf(Apexpages.currentPage().getParameters().get('AccessoryProductItemIndex'));
            system.debug('pdtsAccessoryMap'+pdtsAccessoryMap);
            ProductsAgreedWrapper getSelectedPdtDetails = pdtTypeAccessoryListMap.get(pdtsAccessoryMap.get(accPdtId).pdtItem.Type__c.toLowerCase())[accListIndex];
            if(getSelectedPdtDetails.pdtItem.Id != accPdtId){
                getSelectedPdtDetails = null;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Unexpected error occured, please contact System Admin.'));
            }
            if(getSelectedPdtDetails == null){
               ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'No Record found, please refresh the page.')); 
            }
            else{
                if(getSelectedPdtDetails.pdtItem.Unit_Type_2__c.toLowerCase() == 'service' && getSelectedPdtDetails.pdtItem.Is_Other__c){
                    if(String.isBlank(getSelectedPdtDetails.accessoryFrequency)){
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Frequency for Accessory of type '+getSelectedPdtDetails.pdtItem.Description__c+' cannot be blank.'));    
                    }
                    else{
                        if(getSelectedPdtDetails.accessoryFrequency.isAlpha()){
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please enter valid frequency, frequency cannot be alphabet or special character.'));    
                        }
                        else{
                            Decimal selectedRate = getSelectedPdtDetails.pdtItem.Rate__c == null? 0.0 : Decimal.valueOf(getSelectedPdtDetails.pdtItem.Rate__c);
                            addToBasketList(getSelectedPdtDetails, Integer.valueOf(getSelectedPdtDetails.accessoryQuantity), selectedRate, false, 'Accessory');
                            //Reset summary tab fields if basket is empty.
                            if(fullQuote.Rental_Charges__c != null){
                                resetSummaryTabFields();
                            }
                        }
                    }
                }
                else{
                    Decimal selectedRate = getSelectedPdtDetails.pdtItem.Rate__c == null? 0.0 : Decimal.valueOf(getSelectedPdtDetails.pdtItem.Rate__c);
                    addToBasketList(getSelectedPdtDetails, Integer.valueOf(getSelectedPdtDetails.accessoryQuantity), selectedRate, false, 'Accessory');
                    //Reset summary tab fields if basket is empty.
                    if(fullQuote.Rental_Charges__c != null){
                        resetSummaryTabFields();
                    }
                }
            } 
        } catch(Exception e){
            system.debug('addToBasketList method Exception : '+e);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, e.getMessage()));
        }
    }
    
    private void addToBasketList(ProductsAgreedWrapper currentProducttoAdd, Integer quantity, Decimal selectedRate, Boolean isMainUnit, String mainProductType){
        try{
            Decimal vartotal = quantity * selectedRate;
            Decimal transportCost = 0.00;
            
            if(String.isNotBlank(currentProducttoAdd.pdtItem.TransportSize__c)){
               Map<String, Decimal> transportSizeCostMap = new Map<String, Decimal>();
               LIST<String> transportSizeSet = new LIST<String>();
               transportSizeSet.add(currentProducttoAdd.pdtItem.TransportSize__c);    
               transportSizeCostMap = fetchDelPickupCostMap(transportSizeSet);
               transportCost = transportSizeCostMap.get(currentProducttoAdd.pdtItem.TransportSize__c) * quantity;
            }
            
            allSelectedProducts.add(new Full_Quote_UK_LineItem__c(Name = currentProducttoAdd.pdtItem.Description__c,
                                                                  Product_UK__c = currentProducttoAdd.pdtItem.Id,
                                                                  Description__c = currentProducttoAdd.pdtItem.Description__c,
                                                                  Itemcode__c = currentProducttoAdd.pdtItem.Code__c,
                                                                  Unit_Type__c = currentProducttoAdd.pdtItem.Type__c,
                                                                  Quantity__c = Decimal.valueOf(quantity),
                                                                  Price__c = selectedRate,
                                                                  Total__c = vartotal,
                                                                  LLW__c = currentProducttoAdd.pdtItem.LLW__c,
                                                                  TransportSize__c = currentProducttoAdd.pdtItem.TransportSize__c,
                                                                  TransportCost__c = transportCost,
                                                                  Frequency__c = currentProducttoAdd.accessoryFrequency == null || currentProducttoAdd.accessoryFrequency == ''? '':currentProducttoAdd.accessoryFrequency,
                                                                  Is_Main_Unit__c = isMainUnit,
                                                                  is_LLW_Editable__c = currentProducttoAdd.pdtItem.is_LLW_Editable__c,
                                                                  Unit_Type_2__c = currentProducttoAdd.pdtItem.Unit_Type_2__c,
                                                                  Is_Other__c = currentProducttoAdd.pdtItem.Is_Other__c,
                                                                  Main_Product_Type__c = mainProductType));        
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, currentProducttoAdd.pdtItem.Description__c+' added to the shopping basket'));
        
        } catch(Exception e){
            system.debug('addToBasketList method Exception : '+e);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, e.getMessage()));
        }
    }
    
    //Shankar - Get selected products(Product Basket Table)
    public List<Full_Quote_UK_LineItem__c> getSelectedProducts(){
        system.debug('allSelectedProducts = '+allSelectedProducts);
        List<Full_Quote_UK_LineItem__c> pdtSelected = new List<Full_Quote_UK_LineItem__c>();
            pdtSelected.addAll(allSelectedProducts);
            system.debug('allSelectedProducts Return Value = '+pdtSelected);
        return pdtSelected;
    }
    
    //Shankar - Remove item from basket logic
    public PageReference removeProductItem(){
        try{
            system.debug('removeProductItem '+ fullQuote);
            INTEGER rowIndex = Integer.valueOf(ApexPages.currentPage().getParameters().get('rowIndex'));
            system.debug('removeProductItem row Index = '+ rowIndex );
            String pdtDesc = allSelectedProducts[rowIndex].Description__c;
            allSelectedProducts.remove(rowIndex);
            //Reset summary tab fields if basket is empty.
            if(fullQuote.Rental_Charges__c != null){
                resetSummaryTabFields();
            }
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, pdtDesc+' removed successfully.'));
            
            return null;
        }catch(Exception e){
            system.debug('quoteExpiresDate method Exception : '+e);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, e.getMessage()));
            return null;
        }
    }
    
    //Shankar - Update Quote Expires date based on Required Date field
    public PageReference quoteExpiresDate(){
        try{
            system.debug('quoteExpiresDate '+ fullQuote);
            fullQuote.Quote_Expires__c = fullQuote.Required_Date__c + 30;
            quoteExpires = fullQuote.Quote_Expires__c.format();
        }catch(Exception e){
            system.debug('quoteExpiresDate method Exception : '+e);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, e.getMessage()));
        }
        return null;
    }
    
    //Shankar - Method used to search products for the selected product type and unit size
    public void searchProducts(){
        try{
            if(fullQuote.Product_Type__c == null || fullQuote.Unit_Size__c == null){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Product Type or Unit Size cannot be none.'));
            }
            else{
                fullQuote.Select_Rate__c = null;
                fullQuote.Selected_rate__c = null;
                selRate = null;
                fullQuote.Quantity__c = null;
                currentProduct = null;
                selectedRateMap.clear();
                system.debug('searchProducts '+ fullQuote);
            }
        }catch(Exception e){
            system.debug('searchProducts method Exception : '+e);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, e.getMessage()));
        }  
    }
    
    //Sreenivas - Method used to update quote
    public PageReference updateQuote(){
        try
        {    
             system.debug('----inside updateQuote method----');
             isQuoteFromLead = false;
             Integer ver = Integer.valueOf(fullQuote.Quote_Ref__c.split('/')[1])+1;
             String strVer = String.valueOf(ver); 
             if(strVer.length()==1)
             { 
                strVer = '0'+String.valueOf(ver);
             }                         
             fullQuote.Quote_Ref__c = fullQuote.Quote_Ref__c.split('/')[0]+'/'+strVer;
             fullQuote.Name = fullQuote.Quote_Ref__c;
             fullQuote.Quote_Expires__c = system.today().addDays(30);
             quoteExipreddate = fullQuote.Quote_Expires__c.format();
             if((objBranchDet =getBranchDetail())!=null)
             {
                update fullQuote;
                insertFQLineItems(fullQuote.id);
                
             }
      
        }
        catch(Exception e){
            system.debug('UpdateQuote method Exception : '+e);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, e.getMessage()));
        }
        
        return null;
    }
    
    //Shankar - Method used to save/update quote(Save or Update Quote button)
    public PageReference saveOrUpdateQuote(){
        try{    
            if(saveRecord){
               //Save logic to be added.
               system.debug('Save Method'+fullQuote); 
            }else{
               //Update logic to be added.
               system.debug('Update Method'+fullQuote); 
            }
        }
        catch(Exception e){
            system.debug('saveOrUpdateQuote method Exception : '+e);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, e.getMessage()));
        }
        
        return null;
    }
    
    //Shankar - Method used by Refresh button
      public void refresh(){
        try{
            //SummaryTab calculations
            Decimal varRentalCharges = 0.0;
            Decimal varLLW = 0.0;
            Integer varNoOfUnits = 0;
            fullQuote.Del_Pickup_Costs__c = 0;
            system.debug('refresh = '+fullQuote);
            fullQuote.OtherServicesTotal__c = 0;
            fullQuote.OneoffcostTotal__c = 0;
            
            for(Full_Quote_UK_LineItem__c basketItem : allSelectedProducts){
                basketItem.TransportCost__c = basketItem.TransportCost__c == null?0.0:basketItem.TransportCost__c;
                fullQuote.Del_Pickup_Costs__c = fullQuote.Del_Pickup_Costs__c + (basketItem.TransportCost__c * 2);
                
                //LLW calculation for all main units.
                if(basketItem.LLW__c == Label.LLW_UK){
                    varLLW = varLLW + (basketItem.Total__c * 4);
                } 
                if(basketItem.Is_Main_Unit__c){
                    varNoOfUnits = varNoOfUnits + Integer.valueOf(basketItem.Quantity__c);
                }
                if(basketItem.Unit_Type_2__c != null && basketItem.Unit_Type_2__c.toLowerCase() == 'service'){
                    for(Frequency_Multiplier_Mapping__c frequencyMultiplier : Frequency_Multiplier_Mapping__c.getall().values()){
                        if(basketItem.Description__c.toLowerCase().contains(frequencyMultiplier.Name.toLowerCase())){
                            varRentalCharges = varRentalCharges + (basketItem.Total__c * frequencyMultiplier.Multiplier__c);    
                        }
                    }
                    if(basketItem.Is_Other__c){
                        fullQuote.OtherServicesTotal__c = fullQuote.OtherServicesTotal__c + basketItem.Total__c;    
                    }  
                }
                else if(basketItem.Unit_Type_2__c != null && basketItem.Unit_Type_2__c.toLowerCase() == 'one off cost'){
                    //One time cost calculations.
                    fullQuote.OneoffcostTotal__c = fullQuote.OneoffcostTotal__c + basketItem.Total__c;
                }
                else{
                    varRentalCharges = varRentalCharges + (basketItem.Total__c * 4);
                }
            }
            //IF delTime is firstDrop add 50 for each unit.
            String[] str = Label.DelTime_UK.split('/');
            if(fullQuote.Del_Time__c == str[0]){
                fullQuote.Del_Pickup_Costs__c = fullQuote.Del_Pickup_Costs__c + (Integer.valueOf(str[1])*varNoOfUnits);
            }
            varLLW = 0.10 * varLLW;
            setContractValues(varRentalCharges.setscale(2), varLLW.setscale(2), fullQuote.Other__c, varNoOfUnits, fullQuote.Del_Pickup_Costs__c);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'<b>Summary Tab calculations completed successfully</b>.'));
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'Del / Pickup Costs is <b> £'+fullQuote.Del_Pickup_Costs__c+'</b>.'));
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'Total charges per billing cycle is <b> £'+fullQuote.Total_Monthly_Charges__c+'</b>.'));    
        }catch(Exception e){
            system.debug('refresh method Exception : '+e);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, e.getMessage()));
        }
    }
    
    //Shankar - Method to asign the values for the contract value fields.
    private void setContractValues(Decimal rentalCharges, Decimal lLW, Decimal others, Integer noOfUnits, Decimal delPickupCost){
        system.debug('Contract Value Params: RentalCharges = '+rentalCharges+' LLW = '+lLW+' Others = '+others+' No. Of Units = '+noOfUnits+' DelPickupCost = '+delPickupCost);
        //Assign values to the contract value fields. 
        fullQuote.Rental_Charges__c = rentalCharges;
        fullQuote.LLW__c = lLW;
        fullQuote.Other__c = others;
        String[] str = Label.DelTime_UK.split('/');
        if(fullQuote.Del_Time__c == str[0]){
            if(delPickupCost > 0 ){
                fullQuote.Collection__c =  (delPickupCost - (Integer.valueOf(str[1])*noOfUnits))/2;
                fullQuote.Delivery__c = fullQuote.Collection__c + (Integer.valueOf(str[1])*noOfUnits);
            }
            else{
                fullQuote.Collection__c =  0;
                fullQuote.Delivery__c = fullQuote.Collection__c;
            }
        }
        else{
            fullQuote.Collection__c =  delPickupCost / 2;
            fullQuote.Delivery__c = fullQuote.Collection__c;
        }
        fullQuote.No_of_units__c = noOfUnits;
        fullQuote.Total_Transport_Charges__c = fullQuote.Delivery__c+fullQuote.Collection__c;
        fullQuote.Total_Monthly_Charges__c = rentalCharges + Integer.valueOf(others) + lLW;
        fullQuote.First_Invoice_Total__c = fullQuote.Total_Monthly_Charges__c + fullQuote.Total_Transport_Charges__c;
        system.debug('FullQuote setContractValuesMethod = '+fullQuote);
    }
    
    //Shankar - Reset summarytab
    public void resetSummaryTabFields(){
        fullQuote.Del_Pickup_Costs__c = 0;
        fullQuote.Other__c = 0;
        fullQuote.Rental_Charges__c = null;
        fullQuote.LLW__c = null;
        fullQuote.Collection__c = null;
        fullQuote.Delivery__c = null;
        fullQuote.No_of_units__c = null;
        fullQuote.Total_Transport_Charges__c = null;
        fullQuote.Total_Monthly_Charges__c = null;
        fullQuote.First_Invoice_Total__c = null;
        fullQuote.OtherServicesTotal__c = null;
        fullQuote.OneoffcostTotal__c = null;
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'All calculations are defaulted, please click Refresh button to re-calculate.'));
    }
    
    //Shankar - Set Basket Changes
    public void setBasketChanges(){
        system.debug(fullQuote);
    }
    
    //Shankar - Other value onchange.
    public void onChangeOfOtherValue(){
        try{
            fullQuote.Total_Monthly_Charges__c = fullQuote.Rental_Charges__c + Integer.valueOf(fullQuote.Other__c) + fullQuote.LLW__c;
            fullQuote.First_Invoice_Total__c = fullQuote.Total_Monthly_Charges__c + fullQuote.Total_Transport_Charges__c;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Calculations updated successfully. Total Charges Per Billing Cycle is <b> £'+fullQuote.Total_Monthly_Charges__c+'</b> &amp; First Invoice Total is <b> £'+fullQuote.First_Invoice_Total__c+'</b>.'));
        }catch(Exception e){
            system.debug('onChangeOfOtherValue method Exception : '+e);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
        }
    }
    
    //Shankar - onPostCode change
    public void delPostCodeChange(){
        try{
            fullQuote.Delivery_Postcode__c = ApexPages.currentPage().getParameters().get('PostCodeChangeValue');
            system.debug('Post Code = '+fullQuote.Delivery_Postcode__c);
            LIST<String> transportSizeList = new LIST<String>();
            for(Full_Quote_UK_LineItem__c basketItems : allSelectedProducts){
               if(String.isNotBlank(basketItems.TransportSize__c)){
                   system.debug('Transport Size = '+basketItems.TransportSize__c);
                   transportSizeList.add(basketItems.TransportSize__c); 
               }
            }
            if(!transportSizeList.isEmpty()){
                Map<String, Decimal> transportSizeCostMap = fetchDelPickupCostMap(transportSizeList);
                for(INTEGER i=0; i<allSelectedProducts.size(); i++){
                    if(String.isNotBlank(allSelectedProducts[i].TransportSize__c)){
                        allSelectedProducts[i].TransportCost__c = transportSizeCostMap.get(allSelectedProducts[i].TransportSize__c);
                    }
                }
                resetSummaryTabFields();
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Transport Cost for all items in Shopping basket has been re-calculated as per the new post code entered.'));   
            }
        }catch(Exception e){
            system.debug('delPostCodeChange method Exception : '+e);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, e.getMessage()));
        }
        
    }
    
    //Vivek - Transport Cost for all transportSize.
    public Map<String, Decimal> fetchDelPickupCostMap(List<String> transportSizeList)
    {
     system.debug('-----Inside fetchDelPickupCostMap-----');
     Map<String, Decimal> mapTransportsizeToCost = new Map<String, Decimal>();
     //Decimal cost;
     Map<String, String> mapOfLabelwithAPI = new Map<String, String>();
        try{ 
            Map<String, SobjectField> fieldMap = Post_Code_Rate__c.getsObjectType().getDescribe().Fields.getMap(); 
            for(String f :  fieldMap.keySet()){
                mapOfLabelwithAPI.put(fieldMap.get(f).getDescribe().getLabel(), f);
            }   
            if(fullQuote.Delivery_Postcode__c.contains(' ') && !fullQuote.Delivery_Postcode__c.endsWith(' ')){
            fullQuote.Delivery_Postcode__c.toUpperCase();
            String concetenateZIP = fullQuote.Delivery_Postcode__c.substring(0, fullQuote.Delivery_Postcode__c.indexOf(' ', 0)) + fullQuote.Delivery_Postcode__c.substring(fullQuote.Delivery_Postcode__c.indexOf(' ', 0)+1, fullQuote.Delivery_Postcode__c.indexOf(' ', 0)+2);
            system.debug('concetenateZIP = '+concetenateZIP);
            
            String queryP = 'select ';
            for(string Labelset : mapOfLabelwithAPI.keyset()){
                queryP = queryP + mapOfLabelwithAPI.get(Labelset)+', ';
            }
            queryP = queryP.substring(0, queryP.length()-2)+' from Post_Code_Rate__c where name =: concetenateZIP';
            
            system.debug('queryP = '+queryP);
            List<Post_Code_Rate__c> PostCodeRcrd =  Database.query(queryP);
            if(PostCodeRcrd.size()>0){
                for(String transportSize : transportSizeList){
                    if(mapTransportsizeToCost.get(transportSize) == null)
                    //cost = (Decimal)PostCodeRcrd[0].get(mapOfLabelwithAPI.get(transportSize)); 
                    mapTransportsizeToCost.put(transportSize, (Decimal)PostCodeRcrd[0].get(mapOfLabelwithAPI.get(transportSize)) );
                }
            }else{
                    //cost = (Decimal)PostCodeRcrd[0].get(mapOfLabelwithAPI.get(transportSize)); 
                      for(String transportSize : transportSizeList){
                      if(mapTransportsizeToCost.get(transportSize) == null)
                      //cost = (Decimal)PostCodeRcrd[0].get(mapOfLabelwithAPI.get(transportSize)); 
                      mapTransportsizeToCost.put(transportSize, 0 );
                      }
                }
            }
            else{     
                      for(String transportSize : transportSizeList){
                      if(mapTransportsizeToCost.get(transportSize) == null)
                      //cost = (Decimal)PostCodeRcrd[0].get(mapOfLabelwithAPI.get(transportSize)); 
                      mapTransportsizeToCost.put(transportSize, 0 );
                      }
                    }
            
            return mapTransportsizeToCost;
                    
        }catch(Exception e){
            system.debug('fetchDelPickupCostMap method Exception : '+e);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, e.getMessage()));
            return null;
        }
    
    }
    
    //Shankar - Process Quote, LineItems, Opportunity before sending email.
    public void processConvertToOrder(){
        try{
            system.debug('convertToOrder = '+fullQuote);
            if(fullQuote.Delivery_First_Name__c == null 
            || fullQuote.Delivery_Last_Name__c == null
            || fullQuote.Delivery_Phone__c == null
            || fullQuote.Delivery_Mobile__c == null
            || fullQuote.Delivery_Email__c == null){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Site Contact details cannot be empty, please enter values for <b>First Name, Last Name, Phone, Mobile & Email</b>.'));    
            }
            else{
                if(fullQuote.Opportunity__c != null || fullQuote.Opportunity__c != ''){
                    
                    Branch_Detail__c branchmail = [SELECT Id, Branch_Email__c FROM Branch_Detail__c WHERE Branch_Name__c =:fullQuote.Fulfilling_Depot__c LIMIT 1];
                    if(branchmail == null || branchmail.Branch_Email__c == null){
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Branch Details/Email not found for '+fullQuote.Fulfilling_Depot__c+' Depot.'));    
                    }
                    else{
                            //Update quote if there is any changes in the page the changes are saved to the quote,
                            // but doesn't quote email to customer.
                            // insertFQLineItems(fullQuote.id);
                            fullQuote.Status__c = 'Won';
                            database.update(fullQuote);
                            insertFQLineItems(fullQuote.id);
                           
                            MMI_Full_Quotes_UK__c  objeFQ =[select Status__c,OtherServicesTotal__c,Total_Transport_Charges__c,Rental_Length__c, OneoffcostTotal__c, Total_Monthly_Charges__c,Total_Line_Items_Cost__c,opportunity__r.Opportunity_Rating__c,opportunity__c,opportunity__r.closedate,
                                                            BillingContact_RecId__c,Sales_Rep__r.email From MMI_Full_Quotes_UK__c where id =:fullquote.id];
                            updateOpportunity(objeFQ);
                            sendOrderConfirmation = true;
                            system.debug(sendOrderConfirmation);
                        }
                       ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Please wait while the system generates Request For Delivery and send email.')); 
                }
                else{
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Opportunity Not Found for this Quote.'));
                }
              }
        }catch(Exception e){
            system.debug('processConvertToOrder method Exception : '+e);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, e.getMessage()));
        }
    }
    public PageReference RFDsending(){       
        
        EmailTemplate emailTemplateForCustomer = [SELECT Id, Name, DeveloperName, FolderId FROM EmailTemplate where DeveloperName = 'ConvertToOrderUKCustomerConfirmation'];
        User salesRep = [SELECT Id, Name, MobilePhone, Email FROM USER WHERE Sales_Rep_Id__c =:fullQuote.Rep_ID__c AND Name =:fullQuote.Rep_Name__c];
        List<Messaging.SingleEmailMessage> allConvertToOrderMailList = new List<Messaging.SingleEmailMessage>();
        PageReference pdf = new PageReference('/apex/RequestForDeliveryFormUK_PDF?Id='+fullQuote.id);
        Blob pdfRFDBlob = (Test.isrunningtest() == true?Blob.valueOf('Test') :pdf.getContent());
        
        // Create the email attachment
                List<Messaging.EmailFileAttachment> attachRFDList = new List<Messaging.EmailFileAttachment>();
                String accName = fullQuote.Billing_Company_Name__c == null?fullQuote.Billing_First_Name__c+' '+fullQuote.Billing_Last_Name__c
                                                                          :fullQuote.Billing_Company_Name__c;
                Messaging.EmailFileAttachment rfdPDF = new Messaging.EmailFileAttachment();
                    rfdPDF.setFileName('RFD for '+accName+'.pdf');
                    rfdPDF.setContentType('application/pdf');
                    rfdPDF.setInline(false);
                    rfdPDF.Body = pdfRFDBlob;
                    attachRFDList.add(rfdPDF);
                String salesRepMobile = salesRep.MobilePhone == null?' ':salesRep.MobilePhone;  
                String emailSubject = 'RFD for '+accName+' '+fullQuote.Required_Date__c.format()+' '+fullQuote.Delivery_Postcode__c;
                String emailBody = 'Dear '+fullQuote.Fulfilling_Depot__c+',<br><br>'+
                                   'Please find attached a RFD for '+accName+'.<br><br>'+
                                   'If you have any questions please call '+salesRep.Name+'.<br><br>'+
                                   'Kind regards,<br>'+salesRep.Name+'<br>'+salesRepMobile+'<br>'+salesRep.Email+'<br><br>'+
                                   '<img src = "'+Label.UK_Signature_Link+'" />';
                
                String[] toAddress = new String[]{};
                toAddress.add(fullQuote.Mail_RFD__c);
                Messaging.SingleEmailMessage mailtoBranch = new Messaging.SingleEmailMessage();
                    
                    mailtoBranch.setSenderDisplayName('Mobile Mini UK LTD.');
                    mailtoBranch.setToAddresses(toAddress);
                   // mailtoBranch.setCcAddresses(new String[] { salesRep.Email });
                    mailtoBranch.setHtmlBody(emailBody);
                    mailtoBranch.setSubject(emailSubject);
                    mailtoBranch.setFileAttachments(attachRFDList);
                    mailtoBranch.setReplyTo(salesRep.Email);
                    //mailtoBranch.setSaveAsActivity(false);
                
                //Send Confirmation to Customer
              /*  MMI_Full_Quotes_UK__c fullQuoteNewContactId =[SELECT BillingContact_RecId__c, Delivery_Email__c FROM MMI_Full_Quotes_UK__c WHERE Id =:fullquote.id];
                
                Messaging.SingleEmailMessage mailtoCustomer = new Messaging.SingleEmailMessage();
             
                    mailtoCustomer.setSenderDisplayName('Mobile Mini UK LTD.');
                    mailtoCustomer.setCcAddresses(new String[] { fullQuoteNewContactId.Delivery_Email__c, salesRep.Email });
                    mailtoCustomer.setTemplateId(emailTemplateForCustomer.Id);
                    mailtoCustomer.setWhatId(fullQuote.id);
                    mailtoCustomer.setTargetObjectId(fullQuoteNewContactId.BillingContact_RecId__c);
                    mailtoCustomer.setReplyTo(salesRep.Email);
                    mailtoCustomer.setSaveAsActivity(false);
                  */  
                  allConvertToOrderMailList.add(mailtoBranch);
                  //allConvertToOrderMailList.add(mailtoCustomer);
                  
                  if(fullQuote.Status__c=='Won'){
                      Messaging.SendEmailResult[] results = Messaging.SendEmail(allConvertToOrderMailList);
                      ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Mail sent sucessfully'));
                      
                  }
                  else{
                      ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'This Quote is Not Converted to Order'));
                      
                  }
                  return null;
    }
    
    
    //Shankar - Method used to convert quote to order (Convert to Order button)
    public PageReference genOrderAndSendMail(){
        try{
            if(sendOrderConfirmation){
                Branch_Detail__c branchmail = [SELECT Id, Branch_Email__c FROM Branch_Detail__c WHERE Branch_Name__c =:fullQuote.Fulfilling_Depot__c LIMIT 1];
                
                //Get Email Template and Sales Rep details.
                EmailTemplate emailTemplateForCustomer = [SELECT Id, Name, DeveloperName, FolderId FROM EmailTemplate where DeveloperName = 'ConvertToOrderUKCustomerConfirmation'];
                system.debug('Sales Rep = '+fullQuote.Sales_Rep__c);
                User salesRep = [SELECT Id, Name, MobilePhone, Email FROM USER WHERE Sales_Rep_Id__c =:fullQuote.Rep_ID__c AND Name =:fullQuote.Rep_Name__c];
                
                List<Messaging.SingleEmailMessage> allConvertToOrderMailList = new List<Messaging.SingleEmailMessage>();
                //Generate RFD pdf for the current quote.
                PageReference pdf = new PageReference('/apex/RequestForDeliveryFormUK_PDF?Id='+fullQuote.id);
        
                // Get the PDF content
                //Blob pdfRFDBlob = pdf.getContent();
                Blob pdfRFDBlob = (Test.isrunningtest() == true?Blob.valueOf('Test') :pdf.getContent());    
                   
                // Create the email attachment
                List<Messaging.EmailFileAttachment> attachRFDList = new List<Messaging.EmailFileAttachment>();
                String accName = fullQuote.Billing_Company_Name__c == null?fullQuote.Billing_First_Name__c+' '+fullQuote.Billing_Last_Name__c
                                                                          :fullQuote.Billing_Company_Name__c;
                Messaging.EmailFileAttachment rfdPDF = new Messaging.EmailFileAttachment();
                    rfdPDF.setFileName('RFD for '+accName+'.pdf');
                    rfdPDF.setContentType('application/pdf');
                    rfdPDF.setInline(false);
                    rfdPDF.Body = pdfRFDBlob;
                    attachRFDList.add(rfdPDF);
                
                String salesRepMobile = salesRep.MobilePhone == null?' ':salesRep.MobilePhone;
                String emailSubject = 'RFD for '+accName+' '+fullQuote.Required_Date__c.format()+' '+fullQuote.Delivery_Postcode__c;
                String emailBody = 'Dear '+fullQuote.Fulfilling_Depot__c+',<br><br>'+
                                   'Please find attached a RFD for '+accName+'.<br><br>'+
                                   'If you have any questions please call '+salesRep.Name+'.<br><br>'+
                                   'Kind regards,<br>'+salesRep.Name+'<br>'+salesRepMobile+'<br>'+salesRep.Email+'<br><br>'+
                                   '<img src = "'+Label.UK_Signature_Link+'" />';
                
                String[] toAddress = new String[]{};
                toAddress.add(branchmail.Branch_Email__c);
                Messaging.SingleEmailMessage mailtoBranch = new Messaging.SingleEmailMessage();
                    
                    mailtoBranch.setSenderDisplayName('Mobile Mini UK LTD.');
                    mailtoBranch.setToAddresses(toAddress);
                    mailtoBranch.setCcAddresses(new String[] { salesRep.Email });
                    mailtoBranch.setHtmlBody(emailBody);
                    mailtoBranch.setSubject(emailSubject);
                    mailtoBranch.setFileAttachments(attachRFDList);
                    mailtoBranch.setReplyTo(salesRep.Email);
                    mailtoBranch.setSaveAsActivity(false);
                
                //Send Confirmation to Customer
                MMI_Full_Quotes_UK__c fullQuoteNewContactId =[SELECT BillingContact_RecId__c, Delivery_Email__c FROM MMI_Full_Quotes_UK__c WHERE Id =:fullquote.id];
                
                Messaging.SingleEmailMessage mailtoCustomer = new Messaging.SingleEmailMessage();
             
                    mailtoCustomer.setSenderDisplayName('Mobile Mini UK LTD.');
                    mailtoCustomer.setCcAddresses(new String[] { fullQuoteNewContactId.Delivery_Email__c, salesRep.Email });
                    mailtoCustomer.setTemplateId(emailTemplateForCustomer.Id);
                    mailtoCustomer.setWhatId(fullQuote.id);
                    mailtoCustomer.setTargetObjectId(fullQuoteNewContactId.BillingContact_RecId__c);
                    mailtoCustomer.setReplyTo(salesRep.Email);
                    mailtoCustomer.setSaveAsActivity(false);
                    
                  allConvertToOrderMailList.add(mailtoBranch);
                  allConvertToOrderMailList.add(mailtoCustomer);
                  
                  Messaging.SendEmailResult[] results = Messaging.SendEmail(allConvertToOrderMailList);
                  if (results[0].isSuccess()) {
                      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Delivery Request Form sent successfully to Branch.'));
                      system.debug('Delivery Request Form sent successfully to Branch.');
                  } 
                  if(results[1].isSuccess()){
                      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Confirmation email sent successfully to Customer.'));
                      system.debug('Confirmation email sent successfully to Customer.');
                  }
                  else {
                     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, results[0].getErrors()[0].getMessage()));
                     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, results[1].getErrors()[1].getMessage()));
                     system.debug('Error Convert to Order Email = '+results);
                  }
                  PageReference pg = new PageReference('/'+fullQuote.Opportunity__c);
                              pg.setRedirect(true);
                    return pg;        
            }
            else{
                return null;
            }
        }catch(Exception e){
            system.debug('convertToOrder method Exception : '+e);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, e.getMessage()));
             return null;
        }
    }
    
    //Sreenivas- Method used to mark Quote as lost (Mark as Lost button)
    public PageReference markAsLost(){
        try{
            fullQuote.Status__c = 'Lost';
            PageReference p = new PageReference ('/apex/FullQuoteMarkAsLost_UK?id='+fullQuote.id+'&retURL=/apex/FullQuoteFormUK_VF?id='+fullQuote.id);
            p.setRedirect(true);
             return p;  
           
        }catch(Exception e){
            system.debug('markAsLost method Exception : '+e);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, e.getMessage()));
            return null;
        }
         
    }
    
    //Sreenivas- Method used to mark Quote as lost save (Mark as Lost button page save)
    public PageReference markAsLostSave(){
        try{
            update fullQuote;
            Opportunity opp = [select id,StageName, CloseDate from opportunity where id =:fullQuote.opportunity__c];
            opp.StageName= 'Quoted - Lost Business';
            opp.CloseDate = System.today();
            update opp;
            
            PageReference p = new PageReference ('/'+opp.id);
            p.setRedirect(true);
             return p;  
           
        }catch(Exception e){
            system.debug('markAsLost method Exception : '+e);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, e.getMessage()));
            return null;
        }
         
    }
    
    //Sreenivas - Method used to close the quote page and save record as draft (Close Quote button)
    public PageReference closeQuote(){
        try{
             markAsRequired = true;
            system.debug('closeQuote = '+fullQuote);
              if(fullQuote.Is_First_Email_Sent__c && selectedRecordId != null){            
                PageReference pg = new PageReference('/'+selectedRecordId);
                              pg.setRedirect(true);
                   return pg;
                }
              else
              {
                system.debug('closeQuote.Delivery_City__c = '+  fullQuote.Delivery_City__c);
                fullQuote.Name = fullQuote.Quote_Ref__c;
                upsert fullQuote;
                insertFQLineItems(fullQuote.id);
                PageReference pg = new PageReference('/'+selectedRecordId);
                              pg.setRedirect(true);
                  return pg;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Return URL not found'));
                  return null;
              }
              
         }catch(Exception e){
            system.debug('closeQuote method Exception : '+e);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, e.getMessage()));
            return null;
        }
          
    }
    
    //Sreenivas -Populate contact details in Customer&Delivery tab based on selected contact in popup page
    public void searchConatct()
    {
       billingDelFlag = Apexpages.currentPage().getParameters().get('delFlag');
       System.debug('billingContactID....'+billingContactID + ' falg = '+billingDelFlag );
       if(billingContactID!=null && billingContactID !='' ){
       
           system.debug('fullq'+billingContactID);
           Contact billContact = [SELECT Id, FirstName, LastName, Phone, Fax, MobilePhone, Email FROM Contact where id=:billingContactID];
           if(billingDelFlag == 'Delivery'){
               fullQuote.Delivery_First_Name__c = billContact.firstname;
               fullQuote.Delivery_Last_Name__c= billContact.lastname;
               fullQuote.Delivery_Phone__c = billContact.phone;
               fullQuote.Delivery_Mobile__c = billContact.MobilePhone;
               fullQuote.Delivery_Email__c = billContact.email;
               fullQuote.Delivery_Fax__c = billContact.fax;
           }
           else{
               fullQuote.Billing_First_Name__c = billContact.firstname;
               fullQuote.Billing_Last_Name__c = billContact.lastname;
               fullQuote.Billing_Phone__c = billContact.phone;
               fullQuote.Billing_Mobile__c = billContact.MobilePhone;
               fullQuote.Billing_Email__c = billContact.email;
               fullQuote.Billing_Fax__c = billContact.fax;
           }
          system.debug('fullq'+fullQuote);
       }
       
    }
    
    //Sreenivas- Method to check fulfilling depot related branch record is existing or not?
    private Branch_Detail__c getBranchDetail()
    {
      List<Branch_Detail__c> listbranchDetail = [select Branch_Address__c, Branch_Code__c, Branch_Email__c, Branch_Mobile__c, Branch_Phone__c from Branch_Detail__c where Branch_Name__c =: fullQuote.Fulfilling_Depot__c];
      if(listbranchDetail.isEmpty())
      {
        return null;
      }
      return listbranchDetail[0];
    }
    
    // Sreenivas - Save or Convert Quote and Email Quote to Customer and SalesRep
   public pagereference saveAndEmailQuote()
   {
     system.debug('----inside saveandEmailQuote----');  
     try
     {
       isQuoteFromLead = false;
      if(String.isBlank(fullQuote.Quote_Ref__c))
       {
          ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Please set the "Quote Id Number" field value in User Object'));
          return null;
       }
       if((objBranchDet =getBranchDetail())==null)
        return null; 
           
      if(String.isBlank(fullQuote.Account__c) && String.isBlank(fullQuote.Opportunity__c))
       {
          Database.LeadConvert lc = new Database.LeadConvert();
          Account acc = new Account();
          acc.Fax               = fullQuote.Billing_Fax__c;
          acc.Phone             = fullQuote.Billing_Phone__c;
          acc.BillingStreet     = fullQuote.Billing_Address__c;
          acc.BillingCity       = fullQuote.Billing_City__c; 
          acc.BillingState      = fullQuote.Billing_County__c; 
          acc.BillingPostalCode = fullQuote.Billing_Postcode__c; 
          acc.BillingCountry    = fullQuote.Billing_Country__c;
          acc.RecordTypeId   = String.isNotBlank(selectedLead.company)?Schema.SObjectType.Account.getRecordTypeInfosByName().get('Business Account - UK').getRecordTypeId():Schema.SObjectType.Account.getRecordTypeInfosByName().get('Residential Account - UK').getRecordTypeId();
          if(String.isNotBlank(selectedLead.company))
          {
             acc.name = fullQuote.Billing_Company_Name__c;
             
          }
          else
          {
            acc.FirstName = fullQuote.Billing_First_Name__c;
            acc.LastName = fullQuote.Billing_Last_Name__c;
            acc.PersonHasOptedOutOfEmail = selectedLead.HasOptedOutOfEmail;
          }
          
          insert acc;
          
          if(acc.RecordTypeId == Schema.SObjectType.Account.getRecordTypeInfosByName().get('Residential Account - UK').getRecordTypeId())
          {
            contact perContact = [select Id, Name,Phone, MobilePhone, Email from Contact where AccountId = :acc.id];
            fullQuote.BillingContact_RecId__c = perContact.id;
          } 
          system.debug('----------Account created----------'+acc.id);
          system.debug('----------fullQuote.Lead__r.company----------'+selectedLead.company);
          if(String.isNotBlank(selectedLead.company))
           {
              List<Contact> listContact = new List<Contact>();
              // Billing Tab section contact creation
              Contact billCon = new Contact ();
              billCon.AccountId = acc.id;
              billCon.Phone = fullQuote.Billing_Phone__c;
              billCon.FirstName = fullQuote.Billing_First_Name__c;
              billCon.LastName = fullQuote.Billing_Last_Name__c;
              billCon.mobilePhone = fullQuote.Billing_Mobile__c;
              billCon.Email = fullQuote.Billing_Email__c;
              billCon.Fax = fullQuote.Billing_Fax__c;
              billCon.LeadSource = selectedLead.LeadSource;
              billCon.HasOptedOutOfEmail = selectedLead.HasOptedOutOfEmail;
              listContact.add(billCon);
              
              // Delivery Tab section contact creation
              Contact delCon = new Contact ();
              delCon.AccountId = acc.id;
              delCon.Phone = fullQuote.Delivery_Phone__c;
              delCon.FirstName = fullQuote.Delivery_First_Name__c;
              delCon.LastName = fullQuote.Delivery_Last_Name__c;
              delCon.mobilePhone = fullQuote.Delivery_Mobile__c;
              delCon.Email = fullQuote.Delivery_Email__c;
              delCon.Fax = fullQuote.Delivery_Fax__c;
              delCon.LeadSource = selectedLead.LeadSource;
              if((delCon.Phone!=null || delCon.mobilePhone!=null || delCon.Email!=null || delCon.Fax!=null || delCon.FirstName!=null) && delCon.LastName==null)
              {
               ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Site Contact Last Name is missing '));
               return null;
              }
              else if(delCon.LastName!=null)
              { 
                listContact.add(delCon);
              }
              insert listContact;
              
              fullQuote.BillingContact_RecId__c = listContact[0].id;
              if(delCon.LastName!=null)
                  fullQuote.DeliveryContact_RecID__c = listContact[1].id;
              lc.setContactId(listContact[0].id);
            }
          
          lc.setLeadId(selectedLead.id);
          lc.setAccountId(acc.id);
          
          
          LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
          lc.setConvertedStatus(convertStatus.MasterLabel);

          Database.LeadConvertResult lcr = Database.convertLead(lc);
          if(lcr.isSuccess())
            {
               isQuoteFromLead = true;
               system.debug('----------Inside Success----------');
               Lead leadObj = [SELECT Id,ConvertedAccountId, ConvertedContactId, ConvertedOpportunityId FROM Lead where id =:selectedLead.id limit 1];
                              
               fullQuote.Lead__c = null;
               fullQuote.Opportunity__c = leadObj.ConvertedOpportunityId;
               fullQuote.Account__c = acc.id;
               fullQuote.Is_First_Email_Sent__c = true;
               
               Integer ver = Integer.valueOf(fullQuote.Quote_Ref__c.split('/')[1])+1;
               String strVer = String.valueOf(ver);
               if(strVer.length()==1)
                { 
                    strVer = '0'+String.valueOf(ver);
                }                          
               fullQuote.Quote_Ref__c = fullQuote.Quote_Ref__c.split('/')[0]+'/'+strVer;
               
               fullQuote.status__c = 'Open';
               fullQuote.Quote_Expires__c = system.today().addDays(30);
               fullQuote.Name = fullQuote.Quote_Ref__c;
               quoteExipreddate = fullQuote.Quote_Expires__c.format();
               if((objBranchDet =getBranchDetail())!=null){
                    upsert fullQuote;
                    insertFQLineItems(fullQuote.id);
                }
                            
            }
       }
       else if(String.isBlank(fullQuote.Opportunity__c))
       {
         Opportunity opp = new Opportunity();
         System.debug('selectedAccount.Name..'+selectedAccount.Name+'..selectedAccount.Name..'+selectedAccount);
         opp.Name = selectedAccount.Name;
         opp.AccountId = selectedAccount.id;
         opp.StageName = 'Quoted - No Decision';
         opp.CloseDate = System.today() + 30;
         opp.Contact_Phone__c = fullQuote.Billing_Phone__c;
         opp.Contact_Mobile__c = fullQuote.Billing_Mobile__c;
         opp.RecordtypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity - UK').getRecordTypeId();
         system.debug('--inside email quote'+ fullQuote.Opportunity__r.Purchase_Order__c);
         opp.Purchase_Order__c = purchaseOrder;
         insert opp;
         system.debug('a1b'+opp.CloseDate);
         fullQuote.Opportunity__c = opp.id;
         fullQuote.Account__c = selectedAccount.id;
         
         Integer ver = Integer.valueOf(fullQuote.Quote_Ref__c.split('/')[1])+1;
         String strVer = String.valueOf(ver);
         if(strVer.length()==1)
           { 
             strVer = '0'+String.valueOf(ver);
           }                        
         fullQuote.Quote_Ref__c = fullQuote.Quote_Ref__c.split('/')[0]+'/'+strVer;
         fullQuote.Name = fullQuote.Quote_Ref__c;
         fullQuote.Is_First_Email_Sent__c = true;
         fullQuote.status__c = 'Open';
         fullQuote.Quote_Expires__c = system.today().addDays(30);
         quoteExipreddate = fullQuote.Quote_Expires__c.format();
         if((objBranchDet =getBranchDetail())!=null){
                Database.UpsertResult srList = Database.upsert(fullQuote, true);
                insertFQLineItems(fullQuote.id);
            }
         
      
       }
     }
     Catch(Exception e)
     {
      system.debug('saveAndEmailQuote method Exception : '+e);
      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, e.getMessage()));
     }
     return null;
   }
  
  //Sreenivas-Insert QuoteLineItems 
   private void insertFQLineItems(Id fqId)
   {
      System.debug('BD...fqLineitem ....'+allSelectedProducts);
     Delete ([select id from Full_Quote_UK_LineItem__c where MMI_Full_Quote_UK__c=:fqId]);
     
     List<Full_Quote_UK_LineItem__c> listFQLineItems = new List<Full_Quote_UK_LineItem__c>();
     
     for(Full_Quote_UK_LineItem__c fqLineitem :allSelectedProducts)
     {
        Full_Quote_UK_LineItem__c fqitem = new Full_Quote_UK_LineItem__c();
        
        fqitem.Name = fqLineitem.Name;
        fqitem.Product_UK__c = fqLineitem.Product_UK__c;
        fqitem.Description__c = fqLineitem.Description__c;
        fqitem.Itemcode__c = fqLineitem.Itemcode__c;
        fqitem.Unit_Type__c = fqLineitem.Unit_Type__c;
        fqitem.Quantity__c = fqLineitem.Quantity__c;
        fqitem.Price__c = fqLineitem.Price__c;
        fqitem.Total__c = fqLineitem.Total__c;
        fqitem.LLW__c = fqLineitem.LLW__c;
        fqitem.is_LLW_Editable__c = fqLineitem.is_LLW_Editable__c;
        fqitem.Details__c = fqLineitem.Details__c;
        fqitem.TransportSize__c = fqLineitem.TransportSize__c;
        fqitem.TransportCost__c = fqLineitem.TransportCost__c;
        fqitem.Frequency__c = fqLineitem.Frequency__c;
        fqitem.Is_Main_Unit__c = fqLineitem.Is_Main_Unit__c;
        fqitem.Unit_Type_2__c = fqLineitem.Unit_Type_2__c;
        fqitem.Is_Other__c = fqLineitem.Is_Other__c;
        fqitem.Main_Product_Type__c = fqLineitem.Main_Product_Type__c;
        fqitem.MMI_Full_Quote_UK__c = fqId;
        listFQLineItems.add(fqitem);
       System.debug('fqLineitem ....'+fqitem);
     } 
     insert listFQLineItems;
   }
   
   //Sreenivas-Send email to customer and Update Opportunity
   public pagereference sendEmailUpdates()
   {
    system.debug('send email');
        try{
            if(objBranchDet==null)
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Fullfilling branch related branch details is not found'));
                return null;
            }
            String address = String.isBlank(objBranchDet.Branch_Address__c)?' ' :objBranchDet.Branch_Address__c;
            PageReference pdf = new PageReference('/apex/FullQuotePDF_UK?id='+fullQuote.id+'&address='+address);
            
            // Take the PDF content
            //Blob b = pdf.getContent();
            Blob b = (Test.isrunningtest() == true?Blob.valueOf('Test') :pdf.getContent()); 
               
            // Create the email attachment
            List<Messaging.EmailFileAttachment> listefa = new List<Messaging.EmailFileAttachment>();
            List<Messaging.SingleEmailMessage> listMail = new List<Messaging.SingleEmailMessage>();
            List<Messaging.SingleEmailMessage> dummylistMail = new List<Messaging.SingleEmailMessage>();
            EmailTemplate  emailTemp =[SELECT Id, Name, DeveloperName, FolderId FROM EmailTemplate where DeveloperName ='Full_Quote_Details' limit 1];
           
            Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
            efa.setFileName('Quote.pdf');
            efa.setContentType('application/pdf');
            efa.setInline(false);
            efa.Body = b;
            listefa.add(efa);
                      
            set<String> setDocumentNames = new set<String>();
            
            for(Full_Quote_UK_LineItem__c FQLI : allSelectedProducts)
            {
              if(FQLI.Is_Main_Unit__c && fullQuote.Unit_Info__c)
                    setDocumentNames.add(mapProdTypetoUnitInfo.get(FQLI.Main_Product_Type__c));
            
              if(FQLI.Is_Main_Unit__c && fullQuote.Brochure__c)
                    setDocumentNames.add(mapProdTypetoBrochure.get(FQLI.Main_Product_Type__c));
              
                           
              if(FQLI.Is_Main_Unit__c && 'Y'.equalsIgnoreCase(FQLI.LLW__c))
                    setDocumentNames.add(ProdTypeDocMapping__c.getInstance(FQLI.Main_Product_Type__c).Damage_Waiver_DocName__c);
             
            }
            
            if(fullQuote.SHAF__c)
               setDocumentNames.add(ProdTypeDocMapping__c.getAll().values()[0].SHAF_Document_Name__c);
            
            if(isQuoteFromLead)
               setDocumentNames.add(ProdTypeDocMapping__c.getAll().values()[0].Account_Application_DocName__c);
            
            List<Document> listDocumnets = [SELECT Id, name, DeveloperName, ContentType, Type, Body, Description FROM Document where DeveloperName in :setDocumentNames];
           
            for(Document doc : listDocumnets){
            
                Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
                attach.setContentType(doc.contentType);
                attach.setFileName(doc.name+'.'+doc.type);
                attach.setInline(false);
                attach.Body = doc.Body;
                listefa.add(attach);
            }
          
            MMI_Full_Quotes_UK__c  objeFQ =[select Status__c,OtherServicesTotal__c,Rental_Length__c,Total_Transport_Charges__c, OneoffcostTotal__c,Total_Monthly_Charges__c,Total_Line_Items_Cost__c,opportunity__r.Opportunity_Rating__c,opportunity__c,opportunity__r.closedate,BillingContact_RecId__c,Sales_Rep__r.email From MMI_Full_Quotes_UK__c where id =:fullquote.id];
            System.debug('objeFQ..BillingContact_RecId__c..'+objeFQ.BillingContact_RecId__c);
            
            //Update Opportunity
            updateOpportunity(objeFQ);
                     
            Messaging.SingleEmailMessage finalemail = new Messaging.SingleEmailMessage();
            finalemail.setTargetObjectId(objeFQ.BillingContact_RecId__c);
            finalemail.setTemplateId(emailTemp.id);
            finalemail.setWhatId(fullQuote.id);
            finalemail.setFileAttachments(listefa);
            
            finalemail.setSenderDisplayName('Mobile Mini UK LTD.');
            
            String[] listCCEmail = new List<String>();
            boolean setCcaddres = false;
            if(fullQuote.Delivery_Email__c!= null && fullQuote.Delivery_Email__c.trim() != '')
            {
              System.debug('inside cc....');
              listCCEmail.add(fullQuote.Delivery_Email__c);
              setCcaddres = true;
            }
            
            if(objeFQ.Sales_Rep__r.email !=null && objeFQ.Sales_Rep__r.email.trim() !='')
            {
             listCCEmail.add(objeFQ.Sales_Rep__r.email);
             finalemail.setReplyTo(objeFQ.Sales_Rep__r.email);
             setCcaddres = true;
            }
            
            if(setCcaddres)
               finalemail.setCcAddresses(listCCEmail);
            listMail.add(finalemail);
            Messaging.SendEmail(listMail);
       }
       Catch(exception e)
       {
         System.debug('exception..'+e);
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
         return null;
       }
     PageReference P = new PageReference('/'+fullQuote.opportunity__c);
     System.debug('p....'+p);
     p.setRedirect(true);
     return p;
   }
   
   //Sreenivas - Update opportunity whenever quote inserted/updated
  private void updateOpportunity(MMI_Full_Quotes_UK__c  fq)
   {
        Opportunity opp = new Opportunity(id=fq.Opportunity__c);
        opp.RecordtypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity - UK').getRecordTypeId();
        opp.Contact_Phone__c = fullQuote.Billing_Phone__c;
        opp.Contact_Mobile__c = fullQuote.Billing_Mobile__c;
        opp.Opportunity_Contact_Name_LookUpFilter__c = fq.BillingContact_RecId__c;
        opp.Contact_Name__c = fullQuote.Billing_First_Name__c;
        opp.Contact_Last_Name__c = fullQuote.Billing_Last_Name__c;
               
        System.debug('BA..'+fullQuote.Billing_Address__c+'BC.'+fullQuote.Billing_County__c+'FD..'+fullQuote.Fulfilling_Depot__c);
        opp.Billing_Street__c = fullQuote.Billing_Address__c;
        opp.Billing_City__c = fullQuote.Billing_City__c;
        opp.Billing_State_Province__c = fullQuote.Billing_County__c;
        opp.Billing_Country__c = fullQuote.Billing_Country__c;
        opp.Billing_Zip_Postal_Code__c = fullQuote.Billing_Postcode__c;
        
        opp.Delivery_Street__c = fullQuote.Delivery_Address__c;
        opp.Delivery_City__c = fullQuote.Delivery_City__c;
        opp.Delivery_State_Province__c = fullQuote.Delivery_County__c;
        opp.Delivery_Country__c = fullQuote.Delivery_Country__c;
        opp.Delivery_Zip_Postal_Code__c = fullQuote.Delivery_Postcode__c;
        opp.Servicing_Branch_UK__c = fullQuote.Fulfilling_Depot__c;
        
        
        opp.Why_do_you_need_storage_Picklist__c = fullQuote.Industry__c;
        opp.What_will_you_be_storing__c = fullQuote.Unit_Purpose__c;
        opp.How_long_will_you_need_your_unit_UK__c = fullQuote.Rental_Length__c;
        opp.When_will_you_need_your_unit__c = fullQuote.Required_Date__c;
        opp.Last_Activity_Datetime__c = System.now();
        opp.CloseDate =System.today() + 30;
        opp.Purchase_Order__c = purchaseOrder;
        
        if('Open'.equalsIgnoreCase(fq.Status__c))
          opp.StageName = 'Quoted - No Decision';
        
        if(String.isBlank(fq.Opportunity__r.Opportunity_Rating__c) )
          opp.Opportunity_Rating__c = 'Hot (Probably Order)';
        
       if('Won'.equalsIgnoreCase(fq.Status__c)){
          opp.StageName = 'Quoted - Won';
          opp.CloseDate =System.today(); 
       }

        
          opp.Amount = 0.0;        
        if(fq.Total_Monthly_Charges__c > 0 && fq.Rental_Length__c > 0){
         opp.Amount = (fq.Total_Monthly_Charges__c/4)*fq.Rental_Length__c;
        }
        opp.Amount = opp.Amount+fq.Total_Transport_Charges__c+fq.OtherServicesTotal__c+fq.OneoffcostTotal__c;
        update opp;
       system.debug('a1a'+opp.CloseDate);
        if(opp.StageName == 'Quoted - Won')
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Opportunity marked as <b>'+opp.StageName+'</b>.'));
   }   
  
  //Sreenivas-Mark As Lost Page Cancel button logic
  public PageReference cancel()
  {
   PageReference returnPage = new PageReference(ApexPages.currentPage().getParameters().get('retURL'));
   returnPage.setRedirect(true);
   return returnPage;
   
  } 
  
  //Sreenivas-Logic to bypass mandatory fields on click of close quote 
  public void setRequiredVar()
  {
   markAsRequired  = false;
   System.debug('enterd in setRequiredVar method..'+markAsRequired);
                  
  }
  
}