/**
 * (c) 2015 TEKsystems Global Services
 *
 * Name           : FullQuoteUKMainControllerTest
 * Created Date   : 22 March 2015
 * Created By     : Vivek (TEK)
 * Purpose        : Test class for FullQuoteUKMainController
 *
 **/
 @isTest
 public class FullQuoteUKMainControllerTest{
 
 @testSetup static void setup() {
        // Create common test accounts
        List<sObject> ls1 = Test.loadData(FullQuoteUKHistoryMapping__c.sObjectType, 'testFullQuoteUKCusSettings');
        List<sObject> ls2 = Test.loadData(ProdTypeDocMapping__c.sObjectType, 'ProdTypeDocMapping');
        List<sObject> ls3 = Test.loadData(ProductAccessoriesMapping__c.sObjectType, 'ProductAccessoriesMapping');
       // List<sObject> ls4 = Test.loadData(ProductCategoriesMapping__c.sObjectType, 'ProductCategoriesMapping');
        List<sObject> ls5 = Test.loadData(QuoteRefMapping__c.sObjectType, 'QuoteRefMapping');      
        
        Frequency_Multiplier_Mapping__c fm = new Frequency_Multiplier_Mapping__c ();
        fm.Multiplier__c = 2.00;
        fm.name = 'Fortnightly';
        insert fm;
      
    }
 
 Static TestMethod void FullQuoteUKMainControllerMethod1(){
 Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];
      
      User userinstance = TestDataUtil_UK.createUser('TestName', 'Alias', 'Test@test.com', 'testdata12@test.com', 'CommunityNickname', p.Id, true, '345735735', 'UTF-8', 'en_US', 'America/Los_Angeles', 'en_US');
      insert userinstance;     
      
      MMI_Full_Quotes_UK__c fullQuoteUK = TestDataUtil_UK.createFullQuoteUkWithParam(userinstance.id,  'Canteen' ,'40\'');
      fullQuoteUK.Quote_Ref__c = 'FQUK007E15001/02';
      insert fullQuoteUK;
      
      Post_Code_Rate__c postCodeRate = new Post_Code_Rate__c();
      postCodeRate.Service_Branch__c = 'TestServiceBranch';
      insert postCodeRate;
      
      Account objBussinessAcc= MMIFullquoteTestDataProvider.getBusinessAccount();
       objBussinessAcc.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Business Account - UK').getRecordTypeId();
       insert objBussinessAcc;
       
        
      Contact conObj = new Contact();
       conObj.AccountId = objBussinessAcc.Id;
       conObj.FirstName = 'duplicte';
       conObj.LastName = 'contact';
       insert conObj;
       
       Apexpages.currentPage().getParameters().put('Id', objBussinessAcc.Id);
       Apexpages.currentPage().getParameters().put('conId', conObj.Id);
 
 FullQuoteUKMainController mainControllerInstance =  new FullQuoteUKMainController();
 //selectFulfillingInstance.fulfildepot = 'TestAddressId';
 
 }
 
 Static TestMethod void FullQuoteUKMainControllerMethod2(){
 
 Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];
      
      User userinstance = TestDataUtil_UK.createUser('TestName', 'Alias', 'Test@test.com', 'testdata12@test.com', 'CommunityNickname', p.Id, true, '345735735', 'UTF-8', 'en_US', 'America/Los_Angeles', 'en_US');
      insert userinstance;     
      
      MMI_Full_Quotes_UK__c fullQuoteUK = TestDataUtil_UK.createFullQuoteUkWithParam(userinstance.id, 'Canteen' ,'40\'');
      insert fullQuoteUK;
      
      Post_Code_Rate__c postCodeRate = new Post_Code_Rate__c();
      postCodeRate.Service_Branch__c = 'TestServiceBranch';
      insert postCodeRate;
       
      Lead Leadinstance = TestDataUtil_UK.createLead('LastNameTestData', 'test@test1.com'); 
      Leadinstance.Street = 'Test';
      insert Leadinstance;
 
 Apexpages.currentPage().getParameters().put('Id', Leadinstance.Id);
 
 FullQuoteUKMainController mainControllerInstance =  new FullQuoteUKMainController();
 //selectFulfillingInstance.fulfildepot = 'TestAddressId';
 
 }
 
 Static TestMethod void FullQuoteUKMainControllerMethod3(){
 
      Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];
      
      User userinstance = TestDataUtil_UK.createUser('TestName', 'Alias', 'Test@test.com', 'testdata12@test.com', 'CommunityNickname', p.Id, true, '345735735', 'UTF-8', 'en_US', 'America/Los_Angeles', 'en_US');
      userinstance.FirstName= 'TestName';
      insert userinstance;
      
      Account objBussinessAcc= MMIFullquoteTestDataProvider.getBusinessAccount();
       objBussinessAcc.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Business Account - UK').getRecordTypeId();
       insert objBussinessAcc;
       
       Contact conObj = new Contact();
       conObj.AccountId = objBussinessAcc.Id;
       conObj.FirstName = 'duplicte';
       conObj.LastName = 'contact';
       conObj.email = 'test@test.com';
       insert conObj;     
      
      MMI_Full_Quotes_UK__c fullQuoteUK = TestDataUtil_UK.createFullQuoteUkWithParam(userinstance.id, 'Canteen' ,'40\'');
      fullQuoteUK.Delivery_Postcode__c = 'AL7 1';
      fullQuoteUK.Quote_Ref__c = 'FQUKnullE/02';
      fullQuoteUK.Fulfilling_Depot__c = 'Test';
      fullQuoteUK.Account__c = objBussinessAcc.id;
      fullQuoteUK.Delivery_First_Name__c = 'Test';
      fullQuoteUK.Delivery_Last_Name__c = 'Test';
      fullQuoteUK.Delivery_Phone__c = '2353565';
      fullQuoteUK.Delivery_Mobile__c = '6775676';
      fullQuoteUK.Delivery_Email__c = 'Test@test.com';
      //fullQuoteUK.Opportunity__c = o.id;
      fullQuoteUK.Rep_ID__c = '345735735';
      fullQuoteUK.Product_Type__c = 'Canteen';
      fullQuoteUK.SHAF__c = true;
      fullQuoteUK.Brochure__c = true;
      fullQuoteUK.Rep_Name__c = 'TestName TestName';
      fullQuoteUK.BillingContact_RecId__c = conObj.id;
      fullQuoteUK.Del_Time__c = 'First Drop';
      fullQuoteUK.Total_Transport_Charges__c = 35;
      insert fullQuoteUK;
      
      Post_Code_Rate__c postCodeRate = new Post_Code_Rate__c();
      postCodeRate.Service_Branch__c = 'London';
      postCodeRate.name = 'AL71';
      postCodeRate.Size_8ft_to_24ft_Units__c = 23;
      insert postCodeRate;
      
      Document doc = new Document();
      doc.developername = 'Account_Application_Form';
      doc.Body = Blob.valueOf('Test');
      doc.name = 'name';
      doc.FolderId = UserInfo.getUserId();
      insert doc;
       
      Lead Leadinstance = TestDataUtil_UK.createLead('LastNameTestData', 'test@test1.com'); 
      insert Leadinstance;
      
      Product_UK__c productInstance = TestDataUtil_UK.createProduct('test', '32.5', 'Furniture', '40\'', true, 'Accessory');
      //productInstance.Unit_Type_2__c = 'Accessory';
      productInstance.TransportSize__c = '8ft to 24ft Units';
      productInstance.Description__c = 'other';
      productInstance.IsActive__c = true;
      insert productInstance;
      
      Branch_Detail__c branchName = new Branch_Detail__c();
      branchName.Branch_Address__c = 'Test';
      branchName.Branch_Name__c = 'Test';
      branchName.Branch_Code__c = 'Test';
      branchName.Branch_Email__c = 'Test@test.com';
      insert branchName;
      
      Product_UK__c productInstance2 = TestDataUtil_UK.createProduct('20HEL', '32.5', 'Furniture', '40\'', true, 'Accessory');
      //productInstance2.Unit_Type_2__c = 'Accessory';
      productInstance2.Description__c = '\'20\' Office / Store COMBO';
      productInstance2.TransportSize__c = '';
      productInstance2.IsActive__c = true;
      insert productInstance2;
      
      Full_Quote_UK_LineItem__c lineItem = new Full_Quote_UK_LineItem__c();
      lineItem.Name = 'Test';
      lineItem.MMI_Full_Quote_UK__c = fullQuoteUK.id;
      lineItem.Product_UK__c = productInstance.id;
      lineItem.TransportSize__c = '8ft to 24ft Units';
      lineItem.TransportCost__c = 32;
      lineItem.Is_Main_Unit__c = True;
      lineItem.Quantity__c = 2;
      lineItem.LLW__c = 'Y'; 
      lineItem.Is_Main_Unit__c = True;
      lineItem.IsService__c = True;
      lineItem.Description__c = 'Fortnightly';
      lineItem.Total__c = 165;
      lineItem.Frequency__c = '2';
      lineItem.Unit_Type_2__c = 'Service';
      insert lineItem;
       
       Product_UK_Agreed_Value__c  Product_UK_Agreed_Value = new Product_UK_Agreed_Value__c();
       Product_UK_Agreed_Value.Account__c = objBussinessAcc.id;
       Product_UK_Agreed_Value.Product__c = productInstance.id;
       Product_UK_Agreed_Value.Agreed_Value__c = 12.02;
       insert Product_UK_Agreed_Value;
       
       Product_UK_Agreed_Value__c  Product_UK_Agreed_Value2 = new Product_UK_Agreed_Value__c();
       Product_UK_Agreed_Value2.Account__c = objBussinessAcc.id;
       Product_UK_Agreed_Value2.Product__c = productInstance2.id;
       Product_UK_Agreed_Value2.Agreed_Value__c = 12.02;
       insert Product_UK_Agreed_Value2;
       
       Apexpages.currentPage().getParameters().put('Id', fullQuoteUK.Id);
       Apexpages.currentPage().getParameters().put('conId', conObj.Id);
       Apexpages.currentPage().getParameters().put('PostCode', 'AL7 1');
       Apexpages.currentPage().getParameters().put('AccessoryProductItemId', productInstance.id);
       Apexpages.currentPage().getParameters().put('AccessoryProductItemIndex', '1');
       Apexpages.currentPage().getParameters().put('rowIndex', '1');
       Apexpages.currentPage().getParameters().put('PostCodeChangeValue', 'AL7 1');
       Apexpages.currentPage().getParameters().put('delFlag', 'Delivery');
       Apexpages.currentPage().getParameters().put('retURL', 'apex/test');
       //ProductsAgreedWrapper wrapperInstance = new ProductsAgreedWrapper();
       
       FullQuoteUKMainController mainControllerInstance =  new FullQuoteUKMainController();
       mainControllerInstance.fullQuote = fullQuoteUK;
       List<ProductsAgreedWrapper>  wrapperInstance =  mainControllerInstance.getProductsWithAgreed();
       mainControllerInstance.billingContactID = conObj.id;
       
       Apexpages.currentPage().getParameters().put('ProductID', productInstance.id);
       mainControllerInstance.getSelectedProductDetails();
       mainControllerInstance.getSelectedProducts();
       
       mainControllerInstance.getSelectRate();
       fullQuoteUK.Select_Rate__c = 'Goal';
       update fullQuoteUK;
       mainControllerInstance.getSelectRate();
        
       mainControllerInstance.addToBasket();
       mainControllerInstance.addAccessoriesToBasket();
       Apexpages.currentPage().getParameters().put('AccessoryProductItemId', productInstance2.id);
       mainControllerInstance.addAccessoriesToBasket();
       mainControllerInstance.getContractValueFields();
       mainControllerInstance.getMarkAsLostFields();
       mainControllerInstance.getMarkAsLostAddFields();
       mainControllerInstance.removeProductItem();
       mainControllerInstance.quoteExpiresDate();
       mainControllerInstance.searchProducts();
       mainControllerInstance.updateQuote();
       mainControllerInstance.saveOrUpdateQuote();
       mainControllerInstance.refresh();
       //mainControllerInstance.delPostCodeChange();
       //mainControllerInstance.fetchDelPickupCost('8ft to 24ft Units');
       mainControllerInstance.fetchDelPickupCostMap(new List<String>{'8ft to 24ft Units'});
       mainControllerInstance.closeQuote();
       mainControllerInstance.saveAndEmailQuote();
       mainControllerInstance.processConvertToOrder();
       mainControllerInstance.genOrderAndSendMail();
       mainControllerInstance.searchConatct();
       mainControllerInstance.sendEmailUpdates();
       mainControllerInstance.cancel();
       mainControllerInstance.setRequiredVar();
       mainControllerInstance.markAsLost();
       mainControllerInstance.markAsLostSave();
       //mainControllerInstance.delPostCodeChange();
       
 }
 
   Static TestMethod void FullQuoteUKMainControllerMethod4(){
     
      Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];
      
      User userinstance = TestDataUtil_UK.createUser('TestName', 'Alias', 'Test@test.com', 'testdata12@test.com', 'CommunityNickname', p.Id, true, '345735735', 'UTF-8', 'en_US', 'America/Los_Angeles', 'en_US');
      userinstance.FirstName= 'TestName';
      insert userinstance;
      
      Lead Leadinstance = TestDataUtil_UK.createLead('LastNameTestData', 'test@test1.com');
      Leadinstance.company = 'Test'; 
      Leadinstance.RecordTypeId= Schema.SObjectType.Lead.getRecordTypeInfosByName().get('MMI UK Lead').getRecordTypeId();
      //insert Leadinstance;
      
       Account objBussinessAcc= MMIFullquoteTestDataProvider.getBusinessAccount();
       objBussinessAcc.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Business Account - UK').getRecordTypeId();
       insert objBussinessAcc;
       
      MMI_Full_Quotes_UK__c fullQuoteUK = TestDataUtil_UK.createFullQuoteUkWithParam(userinstance.id, 'Canteen' ,'40\'');
      fullQuoteUK.Delivery_Postcode__c = 'AL7 1';
      fullQuoteUK.Quote_Ref__c = 'FQUKnullE/02';
      fullQuoteUK.Fulfilling_Depot__c = 'Test';
      fullQuoteUK.Delivery_First_Name__c = 'Test';
      fullQuoteUK.Delivery_Last_Name__c = 'Test';
      fullQuoteUK.Billing_First_Name__c = 'Test';
      fullQuoteUK.Billing_Last_Name__c = 'Test';
      fullQuoteUK.Delivery_Phone__c = '2353565';
      fullQuoteUK.Delivery_Mobile__c = '6775676';
      fullQuoteUK.Delivery_Email__c = 'Test@test.com';
      //fullQuoteUK.Opportunity__c = o.id;
      fullQuoteUK.Billing_Company_Name__c = 'Test';
      fullQuoteUK.Lead__c = Leadinstance.id;
      fullQuoteUK.Rep_ID__c = '345735735';
      fullQuoteUK.Status__c = 'Lost';
      fullQuoteUK.Account__c = objBussinessAcc.id;
      fullQuoteUK.Rep_Name__c = 'TestName TestName';
      insert fullQuoteUK;
      
      Post_Code_Rate__c postCodeRate = new Post_Code_Rate__c();
      postCodeRate.Service_Branch__c = 'London';
      postCodeRate.name = 'AL71';
      postCodeRate.Size_8ft_to_24ft_Units__c = 23;
      insert postCodeRate;
      
      Product_UK__c productInstance = TestDataUtil_UK.createProduct('test', '32.5', 'Canteen', '40\'', true, 'Main');
      //productInstance.Unit_Type_2__c = 'Main';
      productInstance.TransportSize__c = '8ft to 24ft Units';
      insert productInstance;
      
      Branch_Detail__c branchName = new Branch_Detail__c();
      branchName.Branch_Address__c = 'Test';
      branchName.Branch_Name__c = 'Test';
      branchName.Branch_Code__c = 'Test';
      branchName.Branch_Email__c = 'Test@test.com';
      insert branchName;
      
      Product_UK__c productInstance2 = TestDataUtil_UK.createProduct('20HEL', '32.5', 'Furniture', '40\'', true, 'Accessory');
      //productInstance2.Unit_Type_2__c = 'Accessory';
      productInstance2.Description__c = '\'20\' Office / Store COMBO';
      productInstance2.TransportSize__c = '';
      insert productInstance2;
      
      Full_Quote_UK_LineItem__c lineItem = new Full_Quote_UK_LineItem__c();
      lineItem.Name = 'Test';
      lineItem.MMI_Full_Quote_UK__c = fullQuoteUK.id;
      lineItem.Product_UK__c = productInstance.id;
      lineItem.TransportSize__c = '8ft to 24ft Units';
      lineItem.TransportCost__c = 32;
      lineItem.Is_Main_Unit__c = True;
      lineItem.Quantity__c = 2;
      lineItem.LLW__c = 'Y'; 
      lineItem.Is_Main_Unit__c = True;
      lineItem.IsService__c = True;
      lineItem.Description__c = 'Test';
      lineItem.Total__c = 165;
      insert lineItem;
       
      
      Apexpages.currentPage().getParameters().put('AccessoryProductItemId', productInstance2.id);
      Apexpages.currentPage().getParameters().put('AccessoryProductItemIndex', '1');
      Apexpages.currentPage().getParameters().put('Id', fullQuoteUK.Id); 
      FullQuoteUKMainController mainControllerInstance =  new FullQuoteUKMainController();
      mainControllerInstance.fullQuote = fullQuoteUK;
      mainControllerInstance.addAccessoriesToBasket();
      mainControllerInstance.saveAndEmailQuote();
 }
 
    Static TestMethod void FullQuoteUKMainControllerMethod5(){
      Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];
      
      Account objBussinessAcc= MMIFullquoteTestDataProvider.getBusinessAccount();
      objBussinessAcc.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Business Account - UK').getRecordTypeId();
      insert objBussinessAcc;
      
      User userinstance = TestDataUtil_UK.createUser('TestName', 'Alias', 'Test@test.com', 'testdata12@test.com', 'CommunityNickname', p.Id, true, '345735735', 'UTF-8', 'en_US', 'America/Los_Angeles', 'en_US');
      userinstance.FirstName= 'TestName';
      insert userinstance;
      
      MMI_Full_Quotes_UK__c fullQuoteUK = TestDataUtil_UK.createFullQuoteUkWithParam(userinstance.id, 'Canteen' ,'40\'');
      fullQuoteUK.Delivery_Postcode__c = 'AL7 1';
      fullQuoteUK.Quote_Ref__c = 'FQUKnullE/02';
      fullQuoteUK.Fulfilling_Depot__c = 'Test';
      fullQuoteUK.Delivery_First_Name__c = 'Test';
      fullQuoteUK.Delivery_Last_Name__c = 'Test';
      fullQuoteUK.Billing_First_Name__c = 'Test';
      fullQuoteUK.Billing_Last_Name__c = 'Test';
      fullQuoteUK.Delivery_Phone__c = '2353565';
      fullQuoteUK.Delivery_Mobile__c = '6775676';
      fullQuoteUK.Delivery_Email__c = 'Test@test.com';
      fullQuoteUK.Billing_Company_Name__c = 'Test';
      //fullQuoteUK.Lead__c = Leadinstance.id;
      fullQuoteUK.Rep_ID__c = '345735735';
      //fullQuoteUK.Opportunity__c = op.id;
      fullQuoteUK.account__c = objBussinessAcc.id;
      fullQuoteUK.Rep_Name__c = 'TestName TestName';
      insert fullQuoteUK;
      
      Post_Code_Rate__c postCodeRate = new Post_Code_Rate__c();
      postCodeRate.Service_Branch__c = 'London';
      postCodeRate.name = 'AL71';
      postCodeRate.Size_8ft_to_24ft_Units__c = 23;
      insert postCodeRate;
      
      Product_UK__c productInstance = TestDataUtil_UK.createProduct('test', '32.5', 'Canteen', '40\'', true, 'Main');
      //productInstance.Unit_Type_2__c = 'Main';
      productInstance.TransportSize__c = '8ft to 24ft Units';
      insert productInstance;
      
      Branch_Detail__c branchName = new Branch_Detail__c();
      branchName.Branch_Address__c = 'Test';
      branchName.Branch_Name__c = 'Test';
      branchName.Branch_Code__c = 'Test';
      branchName.Branch_Email__c = 'Test@test.com';
      insert branchName;
      
      Product_UK__c productInstance2 = TestDataUtil_UK.createProduct('20HEL', '32.5', 'Furniture', '40\'', true, 'Accessory');
      //productInstance2.Unit_Type_2__c = 'Accessory';
      productInstance2.Description__c = '\'20\' Office / Store COMBO';
      productInstance2.TransportSize__c = '';
      insert productInstance2;
      
      Full_Quote_UK_LineItem__c lineItem = new Full_Quote_UK_LineItem__c();
      lineItem.Name = 'Test';
      lineItem.MMI_Full_Quote_UK__c = fullQuoteUK.id;
      lineItem.Product_UK__c = productInstance.id;
      lineItem.TransportSize__c = '8ft to 24ft Units';
      lineItem.TransportCost__c = 32;
      lineItem.Is_Main_Unit__c = True;
      lineItem.Quantity__c = 2;
      lineItem.LLW__c = 'Y'; 
      lineItem.Is_Main_Unit__c = True;
      lineItem.IsService__c = True;
      lineItem.Description__c = 'Test';
      lineItem.Total__c = 165;
      insert lineItem;
       
      Apexpages.currentPage().getParameters().put('Id', fullQuoteUK.Id);
    
      FullQuoteUKMainController mainControllerInstance =  new FullQuoteUKMainController();
      mainControllerInstance.fullQuote = fullQuoteUK;
      mainControllerInstance.saveAndEmailQuote();
 }
 
 }