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
private class  TestFullQuoteMainController {

    /*static testMethod void myUnitTest1() {
        // TO DO: implement unit test
        User userObj = MMIFullquoteTestDataProvider.getUser();
        System.runAs(userObj){
            test.startTest();
            Account accNew = MMIFullquoteTestDataProvider.getAccount();
            accNew.Result_Id__c = '12557879';
            insert accNew;
            Opportunity opp = MMIFullquoteTestDataProvider.getOpportunity();
            opp.AccountId = accNew.Id;
            insert opp;
            
            MMI_Full_Quotes__c mmiFqObj = MMIFullquoteTestDataProvider.getnewteMMIFullQuote();
            mmiFqObj.Opportunity__c = opp.Id;
            mmiFqObj.Account__c = opp.AccountId;
            insert mmiFqObj;
            System.currentPageReference().getParameters().put('fullQUoteId',mmiFqObj.Quote_Id__c);
            FullQuoteMainController_AC fqMainContObj1 = new FullQuoteMainController_AC();
            //fqMainContObj1.LoadWBs();
            fqMainContObj1.extraWsCall();
            test.stopTest();
        }
    }*/
    
    /*static testMethod void myUnitTest2() {
        // TO DO: implement unit test
        User userObj = MMIFullquoteTestDataProvider.getUser();
        System.runAs(userObj){
            test.startTest();
            Account accNew = MMIFullquoteTestDataProvider.getAccount();
            accNew.Result_Id__c = '12557879';
            insert accNew;
            Opportunity opp = MMIFullquoteTestDataProvider.getOpportunity();
            opp.AccountId = accNew.Id;
            insert opp;
            
            MMI_Quotes__c mmiQqObj = MMIFullquoteTestDataProvider.getQuickQuote();
            mmiQqObj.Opportunity__c = opp.Id;
            insert mmiQqObj;
            System.currentPageReference().getParameters().put('QuickQuoteId',mmiQqObj.Id);
            FullQuoteMainController_AC fqMainContObj2 = new FullQuoteMainController_AC();
            //fqMainContObj2.LoadWBs();
            fqMainContObj2.extraWsCall();
            test.stopTest();
        }
    }*/
    
    /*static testMethod void myUnitTest2A() {
        // TO DO: implement unit test
        User userObj = MMIFullquoteTestDataProvider.getUser();
        System.runAs(userObj){
            test.startTest();
            //---------------------2nd set of record-----------------------------------------
            Account accNew2 = MMIFullquoteTestDataProvider.getAccount();
            insert accNew2;
            Opportunity opp2 = MMIFullquoteTestDataProvider.getOpportunity();
            opp2.AccountId = accNew2.Id;
            insert opp2;
            
            MMI_Quotes__c mmiQqObj2 = MMIFullquoteTestDataProvider.getQuickQuote();
            mmiQqObj2.Opportunity__c = opp2.Id;
            mmiQqObj2.Transaction_Type__c = 'MOBO';
            insert mmiQqObj2;
            System.currentPageReference().getParameters().put('QuickQuoteId',mmiQqObj2.Id);
            FullQuoteMainController_AC fqMainContObj22 = new FullQuoteMainController_AC();
            fqMainContObj22.FullQuoteMainController_AC_initialize();
            if(Test.isRunningTest() && Limits.getFutureCalls() < Limits.getLimitFutureCalls()) {
                fqMainContObj22.LoadWBs();
            }
            if(Test.isRunningTest() && Limits.getFutureCalls() < Limits.getLimitFutureCalls()) {
                fqMainContObj22.callQqToFQConversion();
            }
            test.stopTest();
        }
    }*/
    
    /*static testMethod void myUnitTest2B() {
        // TO DO: implement unit test
        User userObj = MMIFullquoteTestDataProvider.getUser();
        System.runAs(userObj){
            test.startTest();
            //---------------------3rd set of record-----------------------------------------
            Account accNew2 = MMIFullquoteTestDataProvider.getAccount();
            insert accNew2;
            Opportunity opp2 = MMIFullquoteTestDataProvider.getOpportunity();
            opp2.AccountId = accNew2.Id;
            insert opp2;
            
            MMI_Quotes__c mmiQqObj2 = MMIFullquoteTestDataProvider.getQuickQuote();
            mmiQqObj2.Opportunity__c = opp2.Id;
            mmiQqObj2.Transaction_Type__c = 'SOFL';
            mmiQqObj2.Name = 'Sales';
            mmiQqObj2.QQ_Type__c = 'sales';
            mmiQqObj2.Ecode__c = '542512';
            mmiQqObj2.Product__c = '10I';
            insert mmiQqObj2;
            
            HB_Sales_Inventory__c siObj = MMIFullquoteTestDataProvider.getHBSalesInventory();
            siObj.E_Code__c = '542512';
            siObj.Line_Item_ID__c = '10I';
            insert siObj;
            
            System.currentPageReference().getParameters().put('QuickQuoteId',mmiQqObj2.Id);
            FullQuoteMainController_AC fqMainContObj22 = new FullQuoteMainController_AC();
            fqMainContObj22.FullQuoteMainController_AC_initialize();
            if(Test.isRunningTest() && Limits.getFutureCalls() < Limits.getLimitFutureCalls()) {
                fqMainContObj22.LoadWBs();
            }
            if(Test.isRunningTest() && Limits.getFutureCalls() < Limits.getLimitFutureCalls()) {
                fqMainContObj22.callQqToFQConversion();
            }
            test.stopTest();
        }
    }*/
    
    static testMethod void myUnitTest3() {
        // TO DO: implement unit test
        User userObj = MMIFullquoteTestDataProvider.getUser();
        System.runAs(userObj){
            test.startTest();
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
            
            System.currentPageReference().getParameters().put('Id',opp.Id);
            FullQuoteMainController_AC fqMainContObj3 = new FullQuoteMainController_AC();
            fqMainContObj3.FullQuoteMainController_AC_initialize();
            System.currentPageReference().getParameters().put('Id',opp1.Id);
            FullQuoteMainController_AC fqMainContObj4 = new FullQuoteMainController_AC();
            fqMainContObj4.FullQuoteMainController_AC_initialize();
            fqMainContObj4.LoadWBs();
            fqMainContObj4.extraWsCall();
            test.stopTest();
        }
    }
    
    static testMethod void myUnitTest4() {
        // TO DO: implement unit test
        User userObj = MMIFullquoteTestDataProvider.getUser();
        System.runAs(userObj){
            test.startTest();
            
            Full_Quote_Transactional__c fqsmObj = MMIFullquoteTestDataProvider.getnewFullQuoteTransaction();
            insert fqsmObj;
            Summary_Line__c summaryLine = MMIFullquoteTestDataProvider.getnewSummaryLine1();
            summaryLine.Full_Quote_Transactional__c = fqsmObj.Id;
            insert summaryLine;
            Product_Extras__c extraLine = MMIFullquoteTestDataProvider.getnewProductExtras();
            extraLine.Full_Quote_Transactional__c = fqsmObj.Id;
            insert extraLine;
            AdditionalAnalysisSet__c additionalAS = MMIFullquoteTestDataProvider.getAdditionalAnalysisSet();
            additionalAS.Full_Quote_Transactional__c = fqsmObj.Id;
            insert additionalAS;
            AnalysisSet__c analysisSet = MMIFullquoteTestDataProvider.getAnalysisSet();
            analysisSet.Full_Quote_Transactional__c = fqsmObj.Id;
            insert analysisSet;
            
            User  us = MMIFullquoteTestDataProvider.getUser();
            us.Alias = 'tu41'; 
            us.username = 'TEST.USER41@TEST.TEST';
            insert us;
            Standard_Modification__c stand = MMIFullquoteTestDataProvider.getStandardModification();
            insert stand;
            list<Modification_Option_Transactional__c> lstModOption = MMIFullquoteTestDataProvider.getModificationOptionTransactionalList();
            lstModOption[0].Full_Quote_Transactional__c = fqsmObj.Id;
            lstModOption[0].Is_Rejected__c = true;
            lstModOption[0].Approver_User__c = us.Id;
            lstModOption[0].Submitter_User__c = us.Id;
            lstModOption[0].Standard_Modification__c = stand.id;
            insert lstModOption[0];
            
            User  us2 = MMIFullquoteTestDataProvider.getUser();
            us2.Alias = 'tu42'; 
            us2.username = 'TEST.USER42@TEST.TEST';
            insert us2;
            Standard_Modification__c stand2 = MMIFullquoteTestDataProvider.getStandardModification();
            stand2.ModId__c = 'test2';
            stand2.Modification_Option__c ='4585622';
            stand2.sequence__c = 2;
            insert stand2;
            list<Modification_Option_Transactional__c> lstModOption2 = MMIFullquoteTestDataProvider.getModificationOptionTransactionalList();
            lstModOption2[0].Full_Quote_Transactional__c = fqsmObj.Id;
            lstModOption2[0].IsApproved__c = false;
            lstModOption2[0].Approver_User__c = us2.Id;
            lstModOption2[0].Submitter_User__c = us2.Id;
            lstModOption2[0].Standard_Modification__c = stand2.id;
            insert lstModOption2[0];
            
            User  us3 = MMIFullquoteTestDataProvider.getUser();
            us3.Alias = 'tu43'; 
            us3.username = 'TEST.USER43@TEST.TEST';
            insert us3;
            Standard_Modification__c stand3 = MMIFullquoteTestDataProvider.getStandardModification();
            stand3.ModId__c = 'test3';
            stand3.Modification_Option__c ='4585623';
            stand3.sequence__c = 3;
            insert stand3;
            list<Modification_Option_Transactional__c> lstModOption3 = MMIFullquoteTestDataProvider.getModificationOptionTransactionalList();
            lstModOption3[0].Full_Quote_Transactional__c = fqsmObj.Id;
            lstModOption3[0].IsApproved__c = true;
            lstModOption3[0].Approver_User__c = us3.Id;
            lstModOption3[0].Submitter_User__c = us3.Id;
            lstModOption3[0].Standard_Modification__c = stand3.id;
            insert lstModOption3[0];
            
            System.currentPageReference().getParameters().put('FQSM',fqsmObj.Id);
            FullQuoteMainController_AC fqMainContObj4 = new FullQuoteMainController_AC();
            fqMainContObj4.FullQuoteMainController_AC_initialize();
            fqMainContObj4.extraWsCall();
            //---------------2nd set-------------------------------------------------------------------
            Full_Quote_Transactional__c fqsmObj2 = MMIFullquoteTestDataProvider.getnewFullQuoteTransaction();
            insert fqsmObj2;
            Summary_Line__c summaryLine2 = MMIFullquoteTestDataProvider.getnewSummaryLine1();
            summaryLine2.Full_Quote_Transactional__c = fqsmObj2.Id;
            insert summaryLine2;
            Product_Extras__c extraLine2 = MMIFullquoteTestDataProvider.getnewProductExtras();
            extraLine2.Full_Quote_Transactional__c = fqsmObj2.Id;
            insert extraLine2;
            AdditionalAnalysisSet__c additionalAS2 = MMIFullquoteTestDataProvider.getAdditionalAnalysisSet();
            additionalAS2.Full_Quote_Transactional__c = fqsmObj2.Id;
            insert additionalAS2;
            AnalysisSet__c analysisSet2 = MMIFullquoteTestDataProvider.getAnalysisSet();
            analysisSet2.Full_Quote_Transactional__c = fqsmObj2.Id;
            insert analysisSet2;
            
            User  us4 = MMIFullquoteTestDataProvider.getUser();
            us4.Alias = 'tu44'; 
            us4.username = 'TEST.USER44@TEST.TEST';
            insert us4;
            Standard_Modification__c stand4 = MMIFullquoteTestDataProvider.getStandardModification();
            stand4.ModId__c = 'test4';
            stand4.Modification_Option__c ='4585624';
            stand4.sequence__c = 4;
            insert stand4;
            list<Modification_Option_Transactional__c> lstModOption4 = MMIFullquoteTestDataProvider.getModificationOptionTransactionalList();
            lstModOption4[0].Full_Quote_Transactional__c = fqsmObj2.Id;
            lstModOption4[0].Is_Rejected__c = true;
            lstModOption4[0].IsApproved__c = false;
            lstModOption4[0].Approver_User__c = us4.Id;
            lstModOption4[0].Submitter_User__c = us4.Id;
            lstModOption4[0].Standard_Modification__c = stand4.id;
            insert lstModOption4[0];
            System.currentPageReference().getParameters().put('FQSM',fqsmObj2.Id);
            System.currentPageReference().getParameters().put('clone','true');
            FullQuoteMainController_AC fqMainContObj5 = new FullQuoteMainController_AC();
            fqMainContObj5.FullQuoteMainController_AC_initialize();
            fqMainContObj5.LoadWBs();
            test.stopTest();
        }
    }
    
    static testMethod void myUnitTestForPreviewQuote() {
        // TO DO: implement unit test
        User userObj = MMIFullquoteTestDataProvider.getUser();
        System.runAs(userObj){
            test.startTest();
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
            
            
            
            System.currentPageReference().getParameters().put('Id',opp1.Id);
            FullQuoteMainController_AC fqMainContObj = new FullQuoteMainController_AC();
            fqMainContObj.FullQuoteMainController_AC_initialize();
            
            list<HomeBaseBeans.quoteLine> sumList1 = MMIFullquoteTestDataProvider.getQuoteLine();
            sumList1[0].itemId = '10I';
            fqMainContObj.summaryLineList.add(sumList1[0]);
            list<HomeBaseBeans.quoteLine> sumList2 = MMIFullquoteTestDataProvider.getQuoteLine();
            sumList2[0].itemId = 'CG1';
            fqMainContObj.summaryLineList.add(sumList2[0]);
            
            list<HomeBaseBeans.extras> prodExtra1 = MMIFullquoteTestDataProvider.getProductExtrasList();
            prodExtra1[0].description = 'Delivery';
            fqMainContObj.ProductExtrasList.add(prodExtra1[0]);
            list<HomeBaseBeans.extras> prodExtra2 = MMIFullquoteTestDataProvider.getProductExtrasList();
            prodExtra2[0].description = 'PickUp';
            fqMainContObj.ProductExtrasList.add(prodExtra2[0]);
            list<HomeBaseBeans.extras> prodExtra3 = MMIFullquoteTestDataProvider.getProductExtrasList();
            prodExtra3[0].description = 'Pick Up';
            fqMainContObj.ProductExtrasList.add(prodExtra3[0]);
            list<HomeBaseBeans.extras> prodExtra4 = MMIFullquoteTestDataProvider.getProductExtrasList();
            prodExtra4[0].description = 'Loss Limitation';
            fqMainContObj.ProductExtrasList.add(prodExtra4[0]);
            list<HomeBaseBeans.extras> prodExtra5 = MMIFullquoteTestDataProvider.getProductExtrasList();
            prodExtra5[0].description = 'Fuel Surcharge';
            fqMainContObj.ProductExtrasList.add(prodExtra5[0]);
            list<HomeBaseBeans.extras> prodExtra6 = MMIFullquoteTestDataProvider.getProductExtrasList();
            prodExtra6[0].description = 'Personal Property Expense';
            fqMainContObj.ProductExtrasList.add(prodExtra6[0]);
            list<HomeBaseBeans.extras> prodExtra7 = MMIFullquoteTestDataProvider.getProductExtrasList();
            prodExtra7[0].description = 'Security Deposit';
            fqMainContObj.ProductExtrasList.add(prodExtra7[0]);
            FullQuoteWrapper fQWrapper = new FullQuoteWrapper();
            fQWrapper.rentalLengthInProduct = '1';
            fqMainContObj.fullQWrapper = fQWrapper;
            fqMainContObj.previewQuote();
            fqMainContObj.QuoteType = 'sales';
            
            fqMainContObj.printViewQuote();
            test.stopTest();
        }
    }
    
    static testMethod void myUnitTestForAddressAssign1() {
        // TO DO: implement unit test
        User userObj = MMIFullquoteTestDataProvider.getUser();
        System.runAs(userObj){
            test.startTest();
            
            Lead ldObj = MMIFullquoteTestDataProvider.getLeadWithDeliveryAdd();
            insert ldObj;
            
            System.currentPageReference().getParameters().put('Id',ldObj.Id);
            FullQuoteMainController_AC fqMainContObj = new FullQuoteMainController_AC();
            fqMainContObj.FullQuoteMainController_AC_initialize();
            fqMainContObj.AddressAssign();
            
            Account accNew = MMIFullquoteTestDataProvider.getAccount();
            accNew.Result_Id__c = '12557879';
            insert accNew;
            Opportunity opp = MMIFullquoteTestDataProvider.getOpportunity();
            opp.AccountId = accNew.Id;
            opp.Delivery_Country__c = 'canada';
            opp.Delivery_State_Province__c = 'N/A';
            insert opp;
            
            Opportunity opp2 = MMIFullquoteTestDataProvider.getOpportunity();
            opp2.AccountId = accNew.Id;
            opp2.Delivery_Country__c = 'united states';
            opp2.Delivery_State_Province__c = 'N/A';
            insert opp2;
            
            System.currentPageReference().getParameters().put('Id',opp.Id);
            FullQuoteMainController_AC fqMainContObj2 = new FullQuoteMainController_AC();
            fqMainContObj2.FullQuoteMainController_AC_initialize();
            fqMainContObj2.AddressAssign();
            
            System.currentPageReference().getParameters().put('Id',opp2.Id);
            FullQuoteMainController_AC fqMainContObj3 = new FullQuoteMainController_AC();
            fqMainContObj3.FullQuoteMainController_AC_initialize();
            fqMainContObj3.AddressAssign();
            
            test.stopTest();
        }
    }
    
    static testMethod void myUnitTestForAddressAssign2() {
        // TO DO: implement unit test
        User userObj = MMIFullquoteTestDataProvider.getUser();
        System.runAs(userObj){
            test.startTest();
            Account accNew = MMIFullquoteTestDataProvider.getAccount();
            accNew.Result_Id__c = '12557879';
            insert accNew;
            Job_Profile__c jpObj = MMIFullquoteTestDataProvider.getJobProfile();
            jpObj.Job_Site_Country__c = 'canada';
            jpObj.Job_Site_State__c = 'NA';
            insert jpObj;
            Opportunity opp3 = MMIFullquoteTestDataProvider.getOpportunity();
            opp3.AccountId = accNew.Id;
            opp3.Job_Profile__c = jpObj.Id;
            opp3.Sub_Contractor_Role__c = 'General Contractor';
            opp3.Delivery_Country__c = 'test';
            opp3.Delivery_State_Province__c = 'N/A';
            insert opp3;
            
            Job_Profile__c jpObj2 = MMIFullquoteTestDataProvider.getJobProfile();
            jpObj2.Job_Site_Country__c = 'united states';
            jpObj2.Job_Site_State__c = 'NA';
            insert jpObj2;
            Opportunity opp4 = MMIFullquoteTestDataProvider.getOpportunity();
            opp4.AccountId = accNew.Id;
            opp4.Job_Profile__c = jpObj2.Id;
            opp4.Sub_Contractor_Role__c = 'General Contractor';
            opp4.Delivery_Country__c = 'united states';
            opp4.Delivery_State_Province__c = 'N/A';
            insert opp4;
            
            System.currentPageReference().getParameters().put('Id',opp3.Id);
            FullQuoteMainController_AC fqMainContObj4 = new FullQuoteMainController_AC();
            fqMainContObj4.FullQuoteMainController_AC_initialize();
            fqMainContObj4.AddressAssign();
            
            System.currentPageReference().getParameters().put('Id',opp4.Id);
            FullQuoteMainController_AC fqMainContObj5 = new FullQuoteMainController_AC();
            fqMainContObj5.FullQuoteMainController_AC_initialize();
            fqMainContObj5.AddressAssign();
            
            test.stopTest();
        }
    }
    
    static testMethod void myUnitTestForAddressAssign3() {
        // TO DO: implement unit test
        User userObj = MMIFullquoteTestDataProvider.getUser();
        System.runAs(userObj){
            test.startTest();
            Account accNew = MMIFullquoteTestDataProvider.getAccount();
            accNew.Result_Id__c = '12557879';
            accNew.ShippingState = 'N/A';
            accNew.BillingState = 'N/A';
            insert accNew;
            
            Account accNew2 = MMIFullquoteTestDataProvider.getAccount();
            accNew2.Result_Id__c = '12557879';
            accNew2.ShippingCountry = 'canada';
            accNew2.BillingCountry = 'canada';
            insert accNew2;
            
            Account accNew3 = MMIFullquoteTestDataProvider.getAccount();
            accNew3.Result_Id__c = '12557879';
            accNew3.ShippingCountry = 'united states';
            accNew3.BillingCountry = 'united states';
            insert accNew3;
            
            System.currentPageReference().getParameters().put('Id',accNew.Id);
            FullQuoteMainController_AC fqMainContObj1 = new FullQuoteMainController_AC();
            fqMainContObj1.FullQuoteMainController_AC_initialize();
            fqMainContObj1.AddressAssign();
            
            System.currentPageReference().getParameters().put('Id',accNew2.Id);
            FullQuoteMainController_AC fqMainContObj2 = new FullQuoteMainController_AC();
            fqMainContObj2.FullQuoteMainController_AC_initialize();
            fqMainContObj2.AddressAssign();
            
            System.currentPageReference().getParameters().put('Id',accNew3.Id);
            FullQuoteMainController_AC fqMainContObj3 = new FullQuoteMainController_AC();
            fqMainContObj3.FullQuoteMainController_AC_initialize();
            fqMainContObj3.AddressAssign();
            
            test.stopTest();
        }
    }
    
    static testMethod void myUnitTestForTransactionWebservice() {
        // TO DO: implement unit test
        User userObj = MMIFullquoteTestDataProvider.getUser();
        System.runAs(userObj){
            test.startTest();
            Account accNew = MMIFullquoteTestDataProvider.getAccount();
            accNew.Result_Id__c = '12557879';
            accNew.ShippingState = 'N/A';
            accNew.BillingState = 'N/A';
            insert accNew;
            
            System.currentPageReference().getParameters().put('Id',accNew.Id);
            FullQuoteMainController_AC fqMainContObj1 = new FullQuoteMainController_AC();
            fqMainContObj1.FullQuoteMainController_AC_initialize();
            FullQuoteWrapper fQWrapper = new FullQuoteWrapper();
            fQWrapper.TransactionType = 'MOBO';
            fQWrapper.selectedFullQUote = 'Rental';
            fqMainContObj1.fullQWrapper = fQWrapper;
            fqMainContObj1.isLoadedTrap = true;
            fqMainContObj1.transactionWebservice();
            
            test.stopTest();
        }
    }
    
    static testMethod void myUnitTestForContactsWebservice() {
        // TO DO: implement unit test
        User userObj = MMIFullquoteTestDataProvider.getUser();
        System.runAs(userObj){
            test.startTest();
            Account accNew = MMIFullquoteTestDataProvider.getAccount();
            accNew.Result_Id__c = '12557879';
            accNew.ShippingState = 'N/A';
            accNew.BillingState = 'N/A';
            insert accNew;
            
            System.currentPageReference().getParameters().put('Id',accNew.Id);
            FullQuoteMainController_AC fqMainContObj1 = new FullQuoteMainController_AC();
            fqMainContObj1.FullQuoteMainController_AC_initialize();
            fqMainContObj1.contactsWebservice();
            
            test.stopTest();
        }
    }
    
    static testMethod void myUnitTestForContactIdEnterbyUser() {
        // TO DO: implement unit test
        User userObj = MMIFullquoteTestDataProvider.getUser();
        System.runAs(userObj){
            test.startTest();
            Account accNew = MMIFullquoteTestDataProvider.getAccount();
            accNew.Result_Id__c = '12557879';
            accNew.ShippingState = 'N/A';
            accNew.BillingState = 'N/A';
            insert accNew;
            
            System.currentPageReference().getParameters().put('Id',accNew.Id);
            FullQuoteMainController_AC fqMainContObj1 = new FullQuoteMainController_AC();
            fqMainContObj1.FullQuoteMainController_AC_initialize();
            fqMainContObj1.contactsResponseList = MMIFullquoteTestDataProvider.getContactSummaryList();
            FullQuoteWrapper fQWrapper = new FullQuoteWrapper();
            fQWrapper.BillingContactID = '1';
            fQWrapper.deliveryContactId = '1';
            fqMainContObj1.fullQWrapper = fQWrapper;
            
            fqMainContObj1.contactIdEnterbyUser();
            fqMainContObj1.fullQWrapper.BillingContactID = '5';
            fqMainContObj1.fullQWrapper.deliveryContactId = '5';
            fqMainContObj1.contactIdEnterbyUser();
            fqMainContObj1.contactIdSelected();
            
            QuickQuoteWrapper qqWrap = new QuickQuoteWrapper();
            qqWrap.contactIdSearchWord = 'test';
            fqMainContObj1.qqWrapper = qqWrap;
            fqMainContObj1.seachContactsInBilling();
            fqMainContObj1.clearAllDataOnChnagetype();
            test.stopTest();
        }
    }
    
    /*static testMethod void myUnitTestForAnalysisWebservice1() {
        // TO DO: implement unit test
        User userObj = MMIFullquoteTestDataProvider.getUser();
        System.runAs(userObj){
            test.startTest();
            
            Lead ldObj = MMIFullquoteTestDataProvider.getLeadWithDeliveryAdd();
            ldObj.LeadSource = 'Ad Source';
            ldObj.Industry = 'Customer Type';
            insert ldObj;
            System.currentPageReference().getParameters().put('Id',ldObj.Id);
            FullQuoteMainController_AC fqMainContObj = new FullQuoteMainController_AC();
            
            FullQuoteWrapper fQWrapper123 = new FullQuoteWrapper();
            fQWrapper123 = MMIFullquoteTestDataProvider.getFullWrapperSales();
            
            fQWrapper123.selectedFullQUote = 'sales';
            fQWrapper123.TransactionType = 'SOFL';
            fqMainContObj.fullQWrapper = fQWrapper123;
            fqMainContObj.analysisWebservice();
            
            Account accNew = MMIFullquoteTestDataProvider.getAccount();
            accNew.Result_Id__c = '12557879';
            accNew.Lead_Source__c = 'Ad Source';
            accNew.ShippingState = 'N/A';
            accNew.BillingState = 'N/A';
            insert accNew;
            
            Account accNew2 = MMIFullquoteTestDataProvider.getAccount();
            accNew2.Result_Id__c = '12557879';
            insert accNew2;
            Opportunity opp2 = MMIFullquoteTestDataProvider.getOpportunity();
            opp2.AccountId = accNew2.Id;
            opp2.Delivery_Country__c = 'canada';
            opp2.Delivery_State_Province__c = 'N/A';
            insert opp2;
            
            System.currentPageReference().getParameters().put('Id',accNew.Id);
            FullQuoteMainController_AC fqMainContObj1 = new FullQuoteMainController_AC();
            fqMainContObj1.analysisWebservice();*/
            
            /*System.currentPageReference().getParameters().put('Id',opp2.Id);
            FullQuoteMainController_AC fqMainContObj2 = new FullQuoteMainController_AC();
            fqMainContObj2.analysisWebservice();
            
            fqMainContObj2.analysisSetbtnEnable();
            
            FullQuoteWrapper fQWrapper = new FullQuoteWrapper();
            fQWrapper.analysisSetHeadValue = true;
            fqMainContObj1.fullQWrapper = fQWrapper;
            fqMainContObj1.analysisSetbtnEnable();*/
            
            /*test.stopTest();
        }
    }*/
    
    /*static testMethod void myUnitTestForAnalysisWebservice11() {
        // TO DO: implement unit test
        User userObj = MMIFullquoteTestDataProvider.getUser();
        System.runAs(userObj){
            test.startTest();
            
            Lead ldObj = MMIFullquoteTestDataProvider.getLeadWithDeliveryAdd();
            ldObj.LeadSource = 'Ad Source';
            ldObj.Industry = 'Customer Type';
            insert ldObj;
            System.currentPageReference().getParameters().put('Id',ldObj.Id);
            FullQuoteMainController_AC fqMainContObj = new FullQuoteMainController_AC();
            
            FullQuoteWrapper fQWrapper123 = new FullQuoteWrapper();
            fQWrapper123 = MMIFullquoteTestDataProvider.getFullWrapperSales();
            
            fQWrapper123.selectedFullQUote = 'sales';
            fQWrapper123.TransactionType = 'SOFL';
            fqMainContObj.fullQWrapper = fQWrapper123;
            fqMainContObj.analysisWebservice();
            
            Account accNew = MMIFullquoteTestDataProvider.getAccount();
            accNew.Result_Id__c = '12557879';
            accNew.Lead_Source__c = 'Ad Source';
            accNew.ShippingState = 'N/A';
            accNew.BillingState = 'N/A';
            insert accNew;
            
            Account accNew2 = MMIFullquoteTestDataProvider.getAccount();
            accNew2.Result_Id__c = '12557879';
            insert accNew2;
            Opportunity opp2 = MMIFullquoteTestDataProvider.getOpportunity();
            opp2.AccountId = accNew2.Id;
            opp2.Delivery_Country__c = 'canada';
            opp2.Delivery_State_Province__c = 'N/A';
            insert opp2;*/
            
            /*System.currentPageReference().getParameters().put('Id',accNew.Id);
            FullQuoteMainController_AC fqMainContObj1 = new FullQuoteMainController_AC();
            fqMainContObj1.analysisWebservice();*/
            
            /*System.currentPageReference().getParameters().put('Id',opp2.Id);
            FullQuoteMainController_AC fqMainContObj2 = new FullQuoteMainController_AC();
            fqMainContObj2.analysisWebservice();
            
            fqMainContObj2.analysisSetbtnEnable();
            
            FullQuoteWrapper fQWrapper = new FullQuoteWrapper();
            fQWrapper.analysisSetHeadValue = true;
            fqMainContObj2.fullQWrapper = fQWrapper;
            fqMainContObj2.analysisSetbtnEnable();
            
            test.stopTest();
        }
    }*/
    
    static testMethod void myUnitTestForAnalysisSetSelectedInBilling(){
        // TO DO: implement unit test
        User userObj = MMIFullquoteTestDataProvider.getUser();
        System.runAs(userObj){
            test.startTest();
            Account accNew = MMIFullquoteTestDataProvider.getAccount();
            accNew.Result_Id__c = '12557879';
            accNew.Lead_Source__c = 'Ad Source';
            accNew.ShippingState = 'N/A';
            accNew.BillingState = 'N/A';
            insert accNew;
            
            System.currentPageReference().getParameters().put('Id',accNew.Id);
            FullQuoteMainController_AC fqMainContObj = new FullQuoteMainController_AC();
            fqMainContObj.FullQuoteMainController_AC_initialize();
            fqMainContObj.analysisSetSelectedInBilling();
            fqMainContObj.analysisShippingWebservice();
            fqMainContObj.selectedAnalysisSet = 'Ad Source';
            fqMainContObj.analysisSetCodeWebService();
            fqMainContObj.selectedAnalysisSet = 'Customer Type';
            fqMainContObj.analysisSetCodeWebService();
            fqMainContObj.selectedAnalysisSet = 'Deferred Bill';
            fqMainContObj.analysisSetCodeWebService();
            fqMainContObj.selectedAnalysisSet = 'Outside TSM';
            fqMainContObj.analysisSetCodeWebService();
            fqMainContObj.selectDeliveryPlanSecFields();
            fqMainContObj.analysisSetCodeWebServiceInShipping();
            fqMainContObj.analysisSetCodeSelectedInShipping();
            test.stopTest();
        }
    }
    
     static testMethod void myUnitTestEditFQ1() {
        // TO DO: implement unit test
        User userObj = MMIFullquoteTestDataProvider.getUser();
        System.runAs(userObj){
            test.startTest();
            
            MMI_Full_Quotes__c mmiFqObj = MMIFullquoteTestDataProvider.getnewteMMIFullQuote();
            insert mmiFqObj;
            System.currentPageReference().getParameters().put('fullQUoteId',mmiFqObj.Id);
            FullQuoteMainController_AC fqMainContObj1 = new FullQuoteMainController_AC();
            fqMainContObj1.FullQuoteMainController_AC_initialize();
            //fqMainContObj1.payLoadtoSaveQuote();
            test.stopTest();
        }
    }
    
    static testMethod void myUnitQQToFQ() {
        // TO DO: implement unit test
        User userObj = MMIFullquoteTestDataProvider.getUser();
        System.runAs(userObj){
            test.startTest();
            Account accNew2 = MMIFullquoteTestDataProvider.getAccount();
            insert accNew2;
            Opportunity opp2 = MMIFullquoteTestDataProvider.getOpportunity();
            opp2.AccountId = accNew2.Id;
            insert opp2;
            MMI_Quotes__c mmiQqObj = MMIFullquoteTestDataProvider.getQuickQuote();
            mmiQqObj.Opportunity__c = opp2.Id;
            insert mmiQqObj;
            System.currentPageReference().getParameters().put('QuickQuoteId',mmiQqObj.Id);
            FullQuoteMainController_AC fqMainContObj2 = new FullQuoteMainController_AC();
            fqMainContObj2.FullQuoteMainController_AC_initialize();
            test.stopTest();
        }
    }
    
    static testMethod void myUnitTestForAnalysisSetCodeSeachFunInShipping(){
        // TO DO: implement unit test
        User userObj = MMIFullquoteTestDataProvider.getUser();
        System.runAs(userObj){
            test.startTest();
            Account accNew = MMIFullquoteTestDataProvider.getAccount();
            accNew.Result_Id__c = '12557879';
            accNew.Lead_Source__c = 'Ad Source';
            accNew.ShippingState = 'N/A';
            accNew.BillingState = 'N/A';
            insert accNew;
            
            System.currentPageReference().getParameters().put('Id',accNew.Id);
            FullQuoteMainController_AC fqMainContObj = new FullQuoteMainController_AC();
            fqMainContObj.FullQuoteMainController_AC_initialize();
            fqMainContObj.analysisSetCodeSeachFunInShipping();
            QuickQuoteWrapper qQWrapperShip = new QuickQuoteWrapper();
            qQWrapperShip.analysisIdSearchWord = '1';
            qQWrapperShip.analysisNameSearchWord = 'an';
            fqMainContObj.qqWrapperShipping = qQWrapperShip;
            fqMainContObj.analysisSetCodeSeachFunInShipping();
            fqMainContObj.analysisSetSearch();
            fqMainContObj.analysisSetCodeSelected();
            fqMainContObj.analysisSetCodeSearch();
            QuickQuoteWrapper qqWrap = new QuickQuoteWrapper();
            qqWrap.analysisIdSearchWord = '1';
            qqWrap.analysisNameSearchWord = 'ad';
            fqMainContObj.qqWrapper = qqWrap;
            fqMainContObj.analysisSetCodeSearch();
            fqMainContObj.analysisSetHeaderSelected();
            fqMainContObj.salesRepSearch();
            fqMainContObj.salesRepIdEnter();
            test.stopTest();
        }
    }
    
    static testMethod void myUnitTestForSalesRepSearch(){
        // TO DO: implement unit test
        User userObj = MMIFullquoteTestDataProvider.getUser();
        System.runAs(userObj){
            test.startTest();
            Account accNew = MMIFullquoteTestDataProvider.getAccount();
            accNew.Result_Id__c = '12557879';
            accNew.Lead_Source__c = 'Ad Source';
            accNew.ShippingState = 'N/A';
            accNew.BillingState = 'N/A';
            insert accNew;
            
            System.currentPageReference().getParameters().put('Id',accNew.Id);
            FullQuoteMainController_AC fqMainContObj = new FullQuoteMainController_AC();
            fqMainContObj.FullQuoteMainController_AC_initialize();
            fqMainContObj.salesRepSearch();
            fqMainContObj.salesRepIdEnter();
            fqMainContObj.assigSalesRepId();
            fqMainContObj.SalesRepSelected();
            fqMainContObj.SalesRepSearchFun();
            QuickQuoteWrapper qqWrap = new QuickQuoteWrapper();
            qqWrap.writeUpRepIdSearchWord = '102';
            qqWrap.writeUpRepNameSearchWord = 'ad';
            fqMainContObj.qqWrapper = qqWrap;
            fqMainContObj.SalesRepSearchFun();
            fqMainContObj.AssistingSalesRepSelected();
            fqMainContObj.contactsResponseList = MMIFullquoteTestDataProvider.getContactSummaryList();
            fqMainContObj.shippingContactIdSelected();
            fqMainContObj.seachContactsInShipping();
            fqMainContObj.qqWrapper.contactIdSearchWord = '1';
            fqMainContObj.qqWrapper.contactFNameSearchWord = 'paul';
            fqMainContObj.seachContactsInShipping();
            test.stopTest();
        }
    }
    
    static testMethod void myUnitTestForAccountIDInBilling(){
        // TO DO: implement unit test
        User userObj = MMIFullquoteTestDataProvider.getUser();
        System.runAs(userObj){
            test.startTest();
            Account accNew = MMIFullquoteTestDataProvider.getAccount();
            accNew.Result_Id__c = '12557879';
            accNew.Lead_Source__c = 'Ad Source';
            accNew.ShippingState = 'N/A';
            accNew.BillingState = 'N/A';
            insert accNew;
            
            System.currentPageReference().getParameters().put('Id',accNew.Id);
            FullQuoteMainController_AC fqMainContObj = new FullQuoteMainController_AC();
            fqMainContObj.FullQuoteMainController_AC_initialize();
            FullQuoteWrapper fQWrapper = new FullQuoteWrapper();
            fQWrapper.ID = '50737';
            fQWrapper.AccountId = '';
            fqMainContObj.fullQWrapper = fQWrapper;
            fqMainContObj.accountIDInBilling();
            fQWrapper.ID = '10492';
            fqMainContObj.accountIdSelected();
            fqMainContObj.fullQWrapper.AccountName = 'test';
            fqMainContObj.accountPatternSearch();
            fqMainContObj.accountIdSelected();
            test.stopTest();
        }
    }
    
    static testMethod void myUnitTestForAllFn1(){
        // TO DO: implement unit test
        User userObj = MMIFullquoteTestDataProvider.getUser();
        System.runAs(userObj){
            test.startTest();
            Account accNew = MMIFullquoteTestDataProvider.getAccount();
            accNew.Result_Id__c = '12557879';
            accNew.Lead_Source__c = 'Ad Source';
            accNew.ShippingState = 'N/A';
            accNew.BillingState = 'N/A';
            insert accNew;
            
            System.currentPageReference().getParameters().put('Id',accNew.Id);
            FullQuoteMainController_AC fqMainContObj = new FullQuoteMainController_AC();
            fqMainContObj.FullQuoteMainController_AC_initialize();
            FullQuoteWrapper fQWrapper = MMIFullquoteTestDataProvider.getFullWrapper();
            fqMainContObj.fullQWrapper = fQWrapper;
            
            
            fqMainContObj.contactsResponseList = MMIFullquoteTestDataProvider.getContactSummaryList();
            fqMainContObj.contactsResponseListForEmailQutoe = MMIFullquoteTestDataProvider.getContactSummaryList();
            fqMainContObj.contactsResponseSearchList = MMIFullquoteTestDataProvider.getContactSummaryList();
            //--------set public list value---------------------------
            HomeBaseBeans.chargeCodes cl1 = MMIFullquoteTestDataProvider.getchargeCodes();
            HomeBaseBeans.chargeCodes cl2 = MMIFullquoteTestDataProvider.getchargeCodes();
            list<HomeBaseBeans.chargeCodes> chargeCodeLst = new list<HomeBaseBeans.chargeCodes>();
            chargeCodeLst.add(cl1);
            chargeCodeLst.add(cl2);
            fqMainContObj.chargeCodeList = chargeCodeLst;
            fqMainContObj.chargeCodeSearchList = chargeCodeLst;
            fqMainContObj.ProductExtrasList = MMIFullquoteTestDataProvider.getProductExtrasList();
            fqMainContObj.analysisSetCodesResponseListInShipping = MMIFullquoteTestDataProvider.getAnalysisSetCodes();
            list<FullQuoteWrapper.NewCustomerAccount> ncaLst = new list<FullQuoteWrapper.NewCustomerAccount>();
            FullQuoteWrapper.NewCustomerAccount ncaObj = MMIFullquoteTestDataProvider.getFullQuoteWrpNewCustomerAccount();
            ncaLst.add(ncaObj);
            fqMainContObj.customerAccList = ncaLst;
            fqMainContObj.summaryLineInEdit = MMIFullquoteTestDataProvider.getQuoteLine();
            fqMainContObj.eCodeAllocationList = MMIFullquoteTestDataProvider.getHomeBaseBeansallocationsList();
            fqMainContObj.summaryLineList = MMIFullquoteTestDataProvider.getQuoteLine();
            fqMainContObj.modList = MMIFullquoteTestDataProvider.getModificationOptionTransactionalList();
            
            //--------set public list value---------------------------
            
            fqMainContObj.addressWebservice();
            fqMainContObj.fullQWrapper.ID = '0';
            fqMainContObj.addressIdSelected();
            fqMainContObj.shippingAddressIdSelected();
            fqMainContObj.callBranchWebservice();
            fqMainContObj.fulFillingIdBillingSelected();
            fqMainContObj.searchFulFillingBranchInBilling();
            fqMainContObj.searchFulFillingBranchInShipping();
            fqMainContObj.fulFillingIdSelected();
            fqMainContObj.fullQWrapper.fulFillingBranchInShippingDates = '1';
            fqMainContObj.fullfillingBranchIdUserEnter();
            fqMainContObj.fullQWrapper.ZipCodeInShipping = '856150';
            fqMainContObj.validateShippingAddress();
            fqMainContObj.validateAddressShippingIdSelected();
            fqMainContObj.taxValidateShippingAddressService();
            fqMainContObj.taxIdShippingSelected();
            fqMainContObj.ProductsSelection();
            fqMainContObj.ClearProductSummarylines();
            fqMainContObj.ClearLockSelect();
            fqMainContObj.editProduct();
            fqMainContObj.isTransTmoboORseco = true;
            fqMainContObj.editProduct();
            fqMainContObj.onchangScheduledDeliverDate();
            fqMainContObj.chargeCode('10i');
            fqMainContObj.callRefreshLineService();
            fqMainContObj.CreateExtraLineItem();
            fqMainContObj.ckeckModificationItem('Test');
            MMI_Quotes__c qqObj = MMIFullquoteTestDataProvider.getQuickQuote();
            insert qqObj;
            fqMainContObj.CalculateBranchIdDuringQqToFQConversion(qqObj, '102');
            fqMainContObj.callSpecificProductService();
            fqMainContObj.isTransTmoboORseco = false;
            fqMainContObj.callSpecificProductService();
            fqMainContObj.callEditSaleProduct();
            fqMainContObj.getProductDetails('10I');
            fqMainContObj.ProductSearch();
            list<HomeBaseBeans.Products> pl = MMIFullquoteTestDataProvider.getProductList();
            fqMainContObj.isTransTmoboORseco = true;
            fqMainContObj.formatProductPriceForMoboSeco(pl);
            fqMainContObj.enablePeriod();
            //fqMainContObj.addNationalValue('1');
           // fqMainContObj.resetOldActualValue('1','2');
       
            
            test.stopTest();
        }
    }
    
    static testMethod void myUnitTestForAllFn2(){
        // TO DO: implement unit test
        User userObj = MMIFullquoteTestDataProvider.getUser();
        System.runAs(userObj){
            test.startTest();
            Account accNew = MMIFullquoteTestDataProvider.getAccount();
            accNew.Result_Id__c = 'P12557879';
            accNew.Lead_Source__c = 'Ad Source';
            accNew.ShippingState = 'N/A';
            accNew.BillingState = 'N/A';
            insert accNew;
            
            System.currentPageReference().getParameters().put('Id',accNew.Id);
            FullQuoteMainController_AC fqMainContObj = new FullQuoteMainController_AC();
            fqMainContObj.FullQuoteMainController_AC_initialize();
            FullQuoteWrapper fQWrapper = MMIFullquoteTestDataProvider.getFullWrapper();
            fQWrapper.LastName = 'testln';
            fqMainContObj.fullQWrapper = fQWrapper;
            //--------set public list value---------------------------
            HomeBaseBeans.chargeCodes cl1 = MMIFullquoteTestDataProvider.getchargeCodes();
            HomeBaseBeans.chargeCodes cl2 = MMIFullquoteTestDataProvider.getchargeCodes();
            list<HomeBaseBeans.chargeCodes> chargeCodeLst = new list<HomeBaseBeans.chargeCodes>();
            chargeCodeLst.add(cl1);
            chargeCodeLst.add(cl2);
            fqMainContObj.chargeCodeList = chargeCodeLst;
            fqMainContObj.chargeCodeSearchList = chargeCodeLst;
            fqMainContObj.ProductExtrasList = MMIFullquoteTestDataProvider.getProductExtrasList();
            fqMainContObj.analysisSetCodesResponseListInShipping = MMIFullquoteTestDataProvider.getAnalysisSetCodes();
            list<FullQuoteWrapper.NewCustomerAccount> ncaLst = new list<FullQuoteWrapper.NewCustomerAccount>();
            FullQuoteWrapper.NewCustomerAccount ncaObj = MMIFullquoteTestDataProvider.getFullQuoteWrpNewCustomerAccount();
            ncaLst.add(ncaObj);
            fqMainContObj.customerAccList = ncaLst;
            fqMainContObj.summaryLineInEdit = MMIFullquoteTestDataProvider.getQuoteLine();
            fqMainContObj.eCodeAllocationList = MMIFullquoteTestDataProvider.getHomeBaseBeansallocationsList();
            fqMainContObj.summaryLineList = MMIFullquoteTestDataProvider.getQuoteLine();
            fqMainContObj.modList = MMIFullquoteTestDataProvider.getModificationOptionTransactionalList();
            
            //--------set public list value---------------------------
            fqMainContObj.MinimumTermIdSelected();
            fqMainContObj.MinimumTermIdSearchFun();
            fqMainContObj.AnalysisCodeIdSelectedInProduct();
            fqMainContObj.copyBillingAddressToShipping();
            fqMainContObj.addProductToSummaryLines();
            fqMainContObj.removeLineItemSummaryLine();
            fqMainContObj.callProductExtrasService();
            fqMainContObj.setContractValue();
            fqMainContObj.changeExtrasInShippingTab();
            fqMainContObj.InvoiceTabFieldValueChange();
            fqMainContObj.payLoadtoSaveQuote();
            fqMainContObj.closeDecarteErrorPopup();
            
            Account accNewBussiness = MMIFullquoteTestDataProvider.getBusinessAccount();
            accNewBussiness.Result_Id__c = 'P2557879';
            insert accNewBussiness;
            Contact conObj = new Contact();
            conObj.AccountId = accNewBussiness.Id;
            conObj.FirstName = 'etrte';
            conObj.LastName = 'etrte';
            insert conObj;
            
            Opportunity opp = MMIFullquoteTestDataProvider.getOpportunity();
            opp.AccountId = accNewBussiness.Id;
            insert opp;
            fqMainContObj.summaryLineList = MMIFullquoteTestDataProvider.getQuoteLine();
            List<HomeBaseBeans.extras> prodExtLst = new List<HomeBaseBeans.extras>();
            HomeBaseBeans.extras prodExt = MMIFullquoteTestDataProvider.getProductExtrasList()[0];
            prodExt.id = 'DELIVERY';
            prodExt.Description = 'Fuel Surcharge Delivery';
            prodExtLst.add(prodExt);
            HomeBaseBeans.extras prodExt2 = MMIFullquoteTestDataProvider.getProductExtrasList()[0];
            prodExt2.id = 'PICKUP';
            prodExt2.id = 'Fuel Surcharge Pick Up';
            prodExtLst.add(prodExt2);
            fqMainContObj.ProductExtrasList = prodExtLst;
            //fqMainContObj.updateOppAddress(opp.Id,'SaveQuoteDate');
            fqMainContObj.payLoadtoMarkAsLost();
            fqMainContObj.closeMarkAsLostPopUp();
            fqMainContObj.ChangeButtonStatus();
            
            test.stopTest();
        }
    }
    
    static testMethod void myUnitTestForAllFn3(){
        // TO DO: implement unit test
        User userObj = MMIFullquoteTestDataProvider.getUser();
        System.runAs(userObj){
            test.startTest();
            Account accNew = MMIFullquoteTestDataProvider.getAccount();
            accNew.Result_Id__c = '12557879';
            accNew.Lead_Source__c = 'Ad Source';
            accNew.ShippingState = 'N/A';
            accNew.BillingState = 'N/A';
            insert accNew;
            
            System.currentPageReference().getParameters().put('Id',accNew.Id);
            FullQuoteMainController_AC fqMainContObj = new FullQuoteMainController_AC();
            fqMainContObj.FullQuoteMainController_AC_initialize();
            FullQuoteWrapper fQWrapper = MMIFullquoteTestDataProvider.getFullWrapper();
            fqMainContObj.fullQWrapper = fQWrapper;
            //--------set public list value---------------------------
            HomeBaseBeans.chargeCodes cl1 = MMIFullquoteTestDataProvider.getchargeCodes();
            HomeBaseBeans.chargeCodes cl2 = MMIFullquoteTestDataProvider.getchargeCodes();
            list<HomeBaseBeans.chargeCodes> chargeCodeLst = new list<HomeBaseBeans.chargeCodes>();
            chargeCodeLst.add(cl1);
            chargeCodeLst.add(cl2);
            fqMainContObj.chargeCodeList = chargeCodeLst;
            fqMainContObj.chargeCodeSearchList = chargeCodeLst;
            fqMainContObj.ProductExtrasList = MMIFullquoteTestDataProvider.getProductExtrasList();
            fqMainContObj.analysisSetCodesResponseListInShipping = MMIFullquoteTestDataProvider.getAnalysisSetCodes();
            list<FullQuoteWrapper.NewCustomerAccount> ncaLst = new list<FullQuoteWrapper.NewCustomerAccount>();
            FullQuoteWrapper.NewCustomerAccount ncaObj = MMIFullquoteTestDataProvider.getFullQuoteWrpNewCustomerAccount();
            ncaLst.add(ncaObj);
            fqMainContObj.customerAccList = ncaLst;
            fqMainContObj.summaryLineInEdit = MMIFullquoteTestDataProvider.getQuoteLine();
            fqMainContObj.eCodeAllocationList = MMIFullquoteTestDataProvider.getHomeBaseBeansallocationsList();
            fqMainContObj.summaryLineList = MMIFullquoteTestDataProvider.getQuoteLine();
            fqMainContObj.modList = MMIFullquoteTestDataProvider.getModificationOptionTransactionalList();
            
            //--------set public list value---------------------------
            fqMainContObj.printViewQuote();
            fqMainContObj.refreshQuote();
            fqMainContObj.analysisSetValidation();
            fqMainContObj.callShippingAnalysisSetsService();
            fqMainContObj.analysisSetSelectedInShipping();
            fqMainContObj.ModifySummaryLine();
            fqMainContObj.reserveCapacity();
            fqMainContObj.analysisSetCodeAssignment(MMIFullquoteTestDataProvider.getEditFullQuoteData());
            fqMainContObj.analysisWebservicesCustomer(MMIFullquoteTestDataProvider.getEditFullQuoteData());
            fqMainContObj.ConvertToOrder();
            fqMainContObj.callConvertToOrder();
            fqMainContObj.returnSavePayload();
            fqMainContObj.callCapacityLookupWebservice();
            fqMainContObj.hideCapacitylookupPop();
            fqMainContObj.CapacityIdSelected();
            
            test.stopTest();
        }
    }
    
    static testMethod void myUnitTestForAllFn4(){
        // TO DO: implement unit test
        User userObj = MMIFullquoteTestDataProvider.getUser();
        System.runAs(userObj){
            test.startTest();
            Account accNew = MMIFullquoteTestDataProvider.getAccount();
            accNew.Result_Id__c = '12557879';
            accNew.Lead_Source__c = 'Ad Source';
            accNew.ShippingState = 'N/A';
            accNew.BillingState = 'N/A';
            insert accNew;
            
            System.currentPageReference().getParameters().put('Id',accNew.Id);
            FullQuoteMainController_AC fqMainContObj = new FullQuoteMainController_AC();
            fqMainContObj.FullQuoteMainController_AC_initialize();
            FullQuoteWrapper fQWrapper = MMIFullquoteTestDataProvider.getFullWrapper();
            fqMainContObj.fullQWrapper = fQWrapper;
            //--------set public list value---------------------------
            HomeBaseBeans.chargeCodes cl1 = MMIFullquoteTestDataProvider.getchargeCodes();
            HomeBaseBeans.chargeCodes cl2 = MMIFullquoteTestDataProvider.getchargeCodes();
            list<HomeBaseBeans.chargeCodes> chargeCodeLst = new list<HomeBaseBeans.chargeCodes>();
            chargeCodeLst.add(cl1);
            chargeCodeLst.add(cl2);
            fqMainContObj.chargeCodeList = chargeCodeLst;
            fqMainContObj.chargeCodeSearchList = chargeCodeLst;
            fqMainContObj.ProductExtrasList = MMIFullquoteTestDataProvider.getProductExtrasList();
            fqMainContObj.analysisSetCodesResponseListInShipping = MMIFullquoteTestDataProvider.getAnalysisSetCodes();
            list<FullQuoteWrapper.NewCustomerAccount> ncaLst = new list<FullQuoteWrapper.NewCustomerAccount>();
            FullQuoteWrapper.NewCustomerAccount ncaObj = MMIFullquoteTestDataProvider.getFullQuoteWrpNewCustomerAccount();
            ncaLst.add(ncaObj);
            fqMainContObj.customerAccList = ncaLst;
            fqMainContObj.summaryLineInEdit = MMIFullquoteTestDataProvider.getQuoteLine();
            fqMainContObj.eCodeAllocationList = MMIFullquoteTestDataProvider.getHomeBaseBeansallocationsList();
            fqMainContObj.summaryLineList = MMIFullquoteTestDataProvider.getQuoteLine();
            fqMainContObj.modList = MMIFullquoteTestDataProvider.getModificationOptionTransactionalList();
            
            //--------set public list value---------------------------
            fqMainContObj.getSaveFullQuoteOptions();
            fqMainContObj.getIsSales();
            fqMainContObj.callSalesFleetService();
            fqMainContObj.callEcodeAllocationWs();
            fqMainContObj.allocationIdSelected();
            fqMainContObj.cancelAllocationIdPopup();
            fqMainContObj.fillEcodes();
            fqMainContObj.showImage();
            fqMainContObj.hideSalesFleet();
            fqMainContObj.contactsResponseList = MMIFullquoteTestDataProvider.getContactSummaryList();
            fqMainContObj.showContactPopUpEmail();
            fqMainContObj.showContactPopUp();
            fqMainContObj.cancelContactPopUp();
            fqMainContObj.hideReserveCapacityId();
            fqMainContObj.capReservePopUpYes();
            fqMainContObj.capReservePopUpNo();
            fqMainContObj.getShowSummaryLineSec();
            fqMainContObj.getEnableContractorField();
            fqMainContObj.disableSaveQuoteBtn();
            fqMainContObj.CancelTaxIdShippingIdSelected();
            fqMainContObj.CancelValidateAddressShippingIdSelected();
            fqMainContObj.hideErrorPopUp();
            fqMainContObj.disableMinimumTermPopUp();
            
            test.stopTest();
        }
    }
    
    static testMethod void myUnitTestForAllFn5(){
        // TO DO: implement unit test
        User userObj = MMIFullquoteTestDataProvider.getUser();
        System.runAs(userObj){
            test.startTest();
            Account accNew = MMIFullquoteTestDataProvider.getAccount();
            accNew.Result_Id__c = '12557879';
            accNew.Lead_Source__c = 'Ad Source';
            accNew.ShippingState = 'N/A';
            accNew.BillingState = 'N/A';
            insert accNew;
            
            System.currentPageReference().getParameters().put('Id',accNew.Id);
            FullQuoteMainController_AC fqMainContObj = new FullQuoteMainController_AC();
            fqMainContObj.FullQuoteMainController_AC_initialize();
            FullQuoteWrapper fQWrapper = MMIFullquoteTestDataProvider.getFullWrapper();
            fqMainContObj.fullQWrapper = fQWrapper;
            //--------set public list value---------------------------
            HomeBaseBeans.chargeCodes cl1 = MMIFullquoteTestDataProvider.getchargeCodes();
            HomeBaseBeans.chargeCodes cl2 = MMIFullquoteTestDataProvider.getchargeCodes();
            list<HomeBaseBeans.chargeCodes> chargeCodeLst = new list<HomeBaseBeans.chargeCodes>();
            chargeCodeLst.add(cl1);
            chargeCodeLst.add(cl2);
            fqMainContObj.chargeCodeList = chargeCodeLst;
            fqMainContObj.chargeCodeSearchList = chargeCodeLst;
            fqMainContObj.ProductExtrasList = MMIFullquoteTestDataProvider.getProductExtrasList();
            fqMainContObj.analysisSetCodesResponseListInShipping = MMIFullquoteTestDataProvider.getAnalysisSetCodes();
            list<FullQuoteWrapper.NewCustomerAccount> ncaLst = new list<FullQuoteWrapper.NewCustomerAccount>();
            FullQuoteWrapper.NewCustomerAccount ncaObj = MMIFullquoteTestDataProvider.getFullQuoteWrpNewCustomerAccount();
            ncaLst.add(ncaObj);
            fqMainContObj.customerAccList = ncaLst;
            fqMainContObj.summaryLineInEdit = MMIFullquoteTestDataProvider.getQuoteLine();
            fqMainContObj.eCodeAllocationList = MMIFullquoteTestDataProvider.getHomeBaseBeansallocationsList();
            fqMainContObj.summaryLineList = MMIFullquoteTestDataProvider.getQuoteLine();
            fqMainContObj.modList = MMIFullquoteTestDataProvider.getModificationOptionTransactionalList();
            
            //--------set public list value---------------------------
            fqMainContObj.enableAnalysisCodePopupInProduct();
            fqMainContObj.cancelAnalysisSetCodeSearch();
            fqMainContObj.cancelAnalysisSetSearch();
            fqMainContObj.enableBilingAddressFields();
            fqMainContObj.disableBilingAddressFields();
            fqMainContObj.onChangeAddressIdInBillingTab();
            fqMainContObj.enableVAddressBtnWhenChange();
            fqMainContObj.onChangeAddressIdInShippingTab();
            fqMainContObj.onchangeNoReservation();
            fqMainContObj.enableVAddressBtnWhenChangeInShipping();
            fqMainContObj.cancelAnalysisSetCodeSelectedInShipping();
            fqMainContObj.salesRep();
            fqMainContObj.assistingSalesRep();
            fqMainContObj.cancelSalesPopUp();
            fqMainContObj.showShippingContactPopUp();
            fqMainContObj.cancelShippingContactPopUp();
            fqMainContObj.cancelAccountIdPopup();
            fqMainContObj.showAddressPopUp();
            fqMainContObj.showShippingAddressPopUp();
            fqMainContObj.cancelAddressIdSelected();
            fqMainContObj.cancelOrderPopUp();
            fqMainContObj.cancelShippingAddressIdSelected();
            fqMainContObj.showFulFillingIdBillingSelected();
            fqMainContObj.cancelFulFillingIdBillingSelected();
            fqMainContObj.showFulFillingIdSelected();
            fqMainContObj.cancelFulFillingIdSelected();
            fqMainContObj.CancelTaxIdBillingIdSelected();
            fqMainContObj.CancelValidateAddressIdSelected();
            FullQuoteWrapper fQWrapper1 = MMIFullquoteTestDataProvider.getFullWrapper();
            fqMainContObj.fullQWrapper = fQWrapper1;
            fqMainContObj.newAccountId = '478514545';
            fqMainContObj.createProspectAccount();
            fqMainContObj.finishCreateNewCustomerAccount();
            fqMainContObj.enableMinimumTermPopUp();
            fqMainContObj.disableAnalysisCodePopupInProduct();
            fqMainContObj.buttonEnableDesable();
            fqMainContObj.invoicingTabbuttonEnableDesable();
            fqMainContObj.cancelFullQuote();
            
            test.stopTest();
        }
    }
    
    static testMethod void myUnitTestForAllFn6(){
        // TO DO: implement unit test
        User userObj = MMIFullquoteTestDataProvider.getUser();
        System.runAs(userObj){
            test.startTest();
            Account accNew = MMIFullquoteTestDataProvider.getAccount();
            accNew.Result_Id__c = '12557879';
            accNew.Lead_Source__c = 'Ad Source';
            accNew.ShippingState = 'N/A';
            accNew.BillingState = 'N/A';
            insert accNew;
            
            System.currentPageReference().getParameters().put('Id',accNew.Id);
            FullQuoteMainController_AC fqMainContObj = new FullQuoteMainController_AC();
            fqMainContObj.FullQuoteMainController_AC_initialize();
            FullQuoteWrapper fQWrapper = MMIFullquoteTestDataProvider.getFullWrapper();
            fqMainContObj.fullQWrapper = fQWrapper;
            //--------set public list value---------------------------
            HomeBaseBeans.chargeCodes cl1 = MMIFullquoteTestDataProvider.getchargeCodes();
            HomeBaseBeans.chargeCodes cl2 = MMIFullquoteTestDataProvider.getchargeCodes();
            list<HomeBaseBeans.chargeCodes> chargeCodeLst = new list<HomeBaseBeans.chargeCodes>();
            chargeCodeLst.add(cl1);
            chargeCodeLst.add(cl2);
            fqMainContObj.chargeCodeList = chargeCodeLst;
            fqMainContObj.chargeCodeSearchList = chargeCodeLst;
            fqMainContObj.ProductExtrasList = MMIFullquoteTestDataProvider.getProductExtrasList();
            fqMainContObj.analysisSetCodesResponseListInShipping = MMIFullquoteTestDataProvider.getAnalysisSetCodes();
            list<FullQuoteWrapper.NewCustomerAccount> ncaLst = new list<FullQuoteWrapper.NewCustomerAccount>();
            FullQuoteWrapper.NewCustomerAccount ncaObj = MMIFullquoteTestDataProvider.getFullQuoteWrpNewCustomerAccount();
            ncaLst.add(ncaObj);
            fqMainContObj.customerAccList = ncaLst;
            fqMainContObj.summaryLineInEdit = MMIFullquoteTestDataProvider.getQuoteLine();
            fqMainContObj.eCodeAllocationList = MMIFullquoteTestDataProvider.getHomeBaseBeansallocationsList();
            fqMainContObj.summaryLineList = MMIFullquoteTestDataProvider.getQuoteLine();
            fqMainContObj.modList = MMIFullquoteTestDataProvider.getModificationOptionTransactionalList();
            
            //--------set public list value---------------------------
            fqMainContObj.selectModification();
            fqMainContObj.onChangeModification();
            fqMainContObj.cancleApproverPopUp();
            list<Standard_Modification__c> smLst = new list<Standard_Modification__c>();
            smLst.add(MMIFullquoteTestDataProvider.getStandardModification());
            fqMainContObj.InitializeModificationList(smLst);
            fqMainContObj.sendToBranchModification();
            fqMainContObj.getCustomerActivityHistory();
            fqMainContObj.SendingMail();
            fqMainContObj.contactEmailId = MMIFullquoteTestDataProvider.getContactEmailList();
            fqMainContObj.contactsResponseListForEmailQutoe = MMIFullquoteTestDataProvider.getContactSummaryList();
            fqMainContObj.contactEmailSelect();
            
            fqMainContObj.cancelSending();
            
            
            
            Lead ldObj = MMIFullquoteTestDataProvider.getLeadWithDeliveryAdd();
            ldObj.LeadSource = 'Ad Source';
            ldObj.Industry = 'Customer Type';
            insert ldObj;
           
            
            System.currentPageReference().getParameters().put('Id',ldObj.Id);
            FullQuoteMainController_AC fqMainContObj1 = new FullQuoteMainController_AC();
            fqMainContObj1.FullQuoteMainController_AC_initialize();
            fqMainContObj1.newAccountId = '';
            fqMainContObj1.fullQWrapper = fQWrapper;
            
            fqMainContObj.createNewCustomerAccount();
            fqMainContObj.newCustomerAccountIdSelected();
            
            test.stopTest();
        }
    }
    static testMethod void myUnitTestForAllFn7(){
        User userObj = MMIFullquoteTestDataProvider.getUser();
        System.runAs(userObj){
            test.startTest();
               
              FullQuoteMainController_AC fqController=new FullQuoteMainController_AC();
              fqController.FullQuoteMainController_AC_initialize();
              fqController.getfullQuote();
              fqController.getLeadRefForHeader();
              fqController.getAccountRefForHeader();
              fqController.getOppRefForHeader();
              fqController.getLeadRef();
              fqController.getLeadRef1();
              fqController.getLeadRef3();
              fqController.getLeadRef4();
              fqController.getCapacityLookupList();
              fqController.getAnalysisSetHeaderResponseList();
              fqController.getAnalysisSetHeaderResponseShippingList();
              fqController.getAnalysisSetCodeResponseList();
              fqController.getAnalysisSetCodeResponseSearchList();
              fqController.getAnalysisSetCodeResponseSearchShippingList();
              fqController.getTaxAddressShippingResponseList();
              fqController.getAddressResponseList();
              fqController.getAddressshippingList();
              fqController.getaddressBillingList();
              fqController.getTaxAddressBillingResponseList();
              fqController.getSalesReps();
              fqController.getSalesRepsSearchList();
              fqController.getValidateAddressResponse();
              fqController.getDescarteInnerClassList();
              fqController.getDescarteInnerClassShippingList();
              fqController.getProductList();
              fqController.getEditProduct();
              fqController.getsummaryLineListForRental();
              fqController.getSalesFleetList();
              fqController.getFulFillingBranchList();
              fqController.getFulFillingBranchSearchList();
              
              fqController.getFulFillingBranchSearchShippingList();
              fqController.getAccountResponseList();
              fqController.getCountryOptions();
              fqController.getStateOptions();
              fqController.getshippingStateOptions();
              fqController.getTransactionOptionsList();
             
              
            Lead ldObj = MMIFullquoteTestDataProvider.getLeadWithDeliveryAdd();
            ldObj.LeadSource = 'Ad Source';
            ldObj.Industry = 'Customer Type';
            insert ldObj;
            System.currentPageReference().getParameters().put('Id',ldObj.Id);
            FullQuoteMainController_AC fqMainContObj = new FullQuoteMainController_AC();
            fqMainContObj.FullQuoteMainController_AC_initialize();
            fqMainContObj.analysisWebservice();
            
            Account accNew = MMIFullquoteTestDataProvider.getAccount();
            accNew.Result_Id__c = '12557879';
            accNew.Lead_Source__c = 'Ad Source';
            accNew.ShippingState = 'N/A';
            accNew.BillingState = 'N/A';
            insert accNew;
            
            Account accNew2 = MMIFullquoteTestDataProvider.getAccount();
            accNew2.Result_Id__c = '12557879';
            insert accNew2;
            Opportunity opp2 = MMIFullquoteTestDataProvider.getOpportunity();
            opp2.AccountId = accNew2.Id;
            opp2.Delivery_Country__c = 'canada';
            opp2.Delivery_State_Province__c = 'N/A';
            insert opp2;
            
            System.currentPageReference().getParameters().put('Id',accNew.Id);
            FullQuoteMainController_AC fqMainContObj1 = new FullQuoteMainController_AC();
            fqMainContObj1.FullQuoteMainController_AC_initialize();
            fqMainContObj1.analysisWebservice();
            
            System.currentPageReference().getParameters().put('Id',opp2.Id);
            FullQuoteMainController_AC fqMainContObj2 = new FullQuoteMainController_AC();
            fqMainContObj2.FullQuoteMainController_AC_initialize();
            fqMainContObj2.analysisWebservice();
            
            fqMainContObj2.analysisSetbtnEnable();
            
            FullQuoteWrapper fQWrapper = new FullQuoteWrapper();
            fQWrapper.analysisSetHeadValue = true;
            fqMainContObj1.fullQWrapper = fQWrapper;
            fqMainContObj1.analysisSetbtnEnable();
            fqMainContObj1.fullQWrapper.fulFillingBranchInShippingDates='';
             fqMainContObj1.fullfillingBranchIdUserEnter();
             
            /*fqMainContObj1.fullQWrapper.selectedFullQUote = 'sales';
            fqMainContObj1.fullQWrapper.disableModificationSelection=true;
            fqMainContObj1.summaryLineList=MMIFullquoteTestDataProvider.getQuoteLine();
            fqMainContObj1.callRefreshLineService();*/
               
            test.stopTest();
        }
    }
    /*static testMethod void myUnitTestForAllFn8(){
        // TO DO: implement unit test
        User userObj = MMIFullquoteTestDataProvider.getUser();
        System.runAs(userObj){
            test.startTest();
            Account accNew = MMIFullquoteTestDataProvider.getAccount();
            accNew.Result_Id__c = '12557879';
            accNew.Lead_Source__c = 'Ad Source';
            accNew.ShippingState = 'N/A';
            accNew.BillingState = 'N/A';
            insert accNew;
            
            Account accNew1 = MMIFullquoteTestDataProvider.getAccount();
            accNew1.Result_Id__c = 'pg12557879';
            accNew1.Lead_Source__c = 'Ad Source';
            accNew1.ShippingState = 'N/A';
            accNew1.BillingState = 'N/A';
            insert accNew1;
            
            Account accNew2 = MMIFullquoteTestDataProvider.getAccount();
            accNew2.Result_Id__c = '';
            accNew2.Lead_Source__c = 'Ad Source';
            accNew2.ShippingState = 'N/A';
            accNew2.BillingState = 'N/A';
            insert accNew2;
            
            System.currentPageReference().getParameters().put('Id',accNew.Id);
            FullQuoteMainController_AC fqMainContObj = new FullQuoteMainController_AC();
            FullQuoteWrapper fQWrapper = MMIFullquoteTestDataProvider.getFullWrapper();
            fqMainContObj.fullQWrapper = fQWrapper;
            //--------set public list value---------------------------
            HomeBaseBeans.chargeCodes cl1 = MMIFullquoteTestDataProvider.getchargeCodes();
            HomeBaseBeans.chargeCodes cl2 = MMIFullquoteTestDataProvider.getchargeCodes();
            list<HomeBaseBeans.chargeCodes> chargeCodeLst = new list<HomeBaseBeans.chargeCodes>();
            chargeCodeLst.add(cl1);
            chargeCodeLst.add(cl2);
            fqMainContObj.chargeCodeList = chargeCodeLst;
            fqMainContObj.chargeCodeSearchList = chargeCodeLst;
            fqMainContObj.ProductExtrasList = MMIFullquoteTestDataProvider.getProductExtrasList();
            fqMainContObj.analysisSetCodesResponseListInShipping = MMIFullquoteTestDataProvider.getAnalysisSetCodes();
            list<FullQuoteWrapper.NewCustomerAccount> ncaLst = new list<FullQuoteWrapper.NewCustomerAccount>();
            FullQuoteWrapper.NewCustomerAccount ncaObj = MMIFullquoteTestDataProvider.getFullQuoteWrpNewCustomerAccount();
            ncaLst.add(ncaObj);
            fqMainContObj.customerAccList = ncaLst;
            fqMainContObj.summaryLineInEdit = MMIFullquoteTestDataProvider.getQuoteLine();
            fqMainContObj.eCodeAllocationList = MMIFullquoteTestDataProvider.getHomeBaseBeansallocationsList();
            fqMainContObj.summaryLineList = MMIFullquoteTestDataProvider.getQuoteLine();
            fqMainContObj.modList = MMIFullquoteTestDataProvider.getModificationOptionTransactionalList();
            
            //--------set public list value---------------------------
            fqMainContObj.populateContactDetails('00654564asfas');
            fqMainContObj.getContactDetailFromAccount('001sdfgsdfd');
            fqMainContObj.clearProductSearchData();
            fqMainContObj.updateFqWithNewAcc('21133','213155');
            MMI_Full_Quotes__c mmiFqObj = MMIFullquoteTestDataProvider.getnewteMMIFullQuote();
            mmiFqObj.Account__c = accNew1.Id;
            insert mmiFqObj;
            fqMainContObj.docId = mmiFqObj.Quote_Id__c;
            fqMainContObj.doPgConvert();
            fqMainContObj.noPgConvert();
            fqMainContObj.updateAccount(accNew2.Id);
            
            test.stopTest();
        }
    }*/
    
static testMethod void testcallRefreshLineService(){
        User userObj = MMIFullquoteTestDataProvider.getUser();
        System.runAs(userObj){
            test.startTest();
             Account accNew2 = MMIFullquoteTestDataProvider.getAccount();
            accNew2.Result_Id__c = '12557879';
            insert accNew2;
            Opportunity opp2 = MMIFullquoteTestDataProvider.getOpportunity();
            opp2.AccountId = accNew2.Id;
            opp2.Delivery_Country__c = 'canada';
            opp2.Delivery_State_Province__c = 'N/A';
            insert opp2;
            
            System.currentPageReference().getParameters().put('Id',opp2.Id);
            FullQuoteMainController_AC fqMainContObj1 = new FullQuoteMainController_AC();
            fqMainContObj1.FullQuoteMainController_AC_initialize();
            fqMainContObj1.analysisWebservice();
            FullQuoteWrapper fQWrapper = new FullQuoteWrapper();
            fqMainContObj1.fullQWrapper = MMIFullquoteTestDataProvider.getFullWrapperSales();
            
            fqMainContObj1.fullQWrapper.selectedFullQUote = 'sales';
            fqMainContObj1.fullQWrapper.disableModificationSelection=true;
            fqMainContObj1.summaryLineList=MMIFullquoteTestDataProvider.getQuoteLine();
            fqMainContObj1.callRefreshLineService();
            fqMainContObj1.fullQWrapper.selectedFullQUote = 'rental';
            fqMainContObj1.callRefreshLineService();
               
            test.stopTest();
        }
        }
        static testMethod void testcallRefreshLineService2(){
        User userObj = MMIFullquoteTestDataProvider.getUser();
        System.runAs(userObj){
            test.startTest();
             Account accNew2 = MMIFullquoteTestDataProvider.getAccount();
            accNew2.Result_Id__c = 'P12557879';
            insert accNew2;
            Opportunity opp2 = MMIFullquoteTestDataProvider.getOpportunity();
            opp2.AccountId = accNew2.Id;
            opp2.Delivery_Country__c = 'canada';
            opp2.Delivery_State_Province__c = 'N/A';
            insert opp2;
            
             MMI_Full_Quotes__c mmiFqObj = MMIFullquoteTestDataProvider.getnewteMMIFullQuote();
            insert mmiFqObj;
            
            System.currentPageReference().getParameters().put('Id',opp2.Id);
            
            
            FullQuoteMainController_AC fqMainContObj1 = new FullQuoteMainController_AC();
            fqMainContObj1.FullQuoteMainController_AC_initialize();
            fqMainContObj1.analysisWebservice();
            FullQuoteWrapper fQWrapper = new FullQuoteWrapper();
            fqMainContObj1.fullQWrapper = MMIFullquoteTestDataProvider.getFullWrapperSales();
            
            
            fqMainContObj1.fullQWrapper.disableModificationSelection=true;
            fqMainContObj1.summaryLineList=MMIFullquoteTestDataProvider.getQuoteLineWithoutError();
            fqMainContObj1.fullQWrapper.selectedFullQUote = 'rental';
            fqMainContObj1.callRefreshLineService();
             fqMainContObj1.refreshLineAllResponseList.clear();
             fqMainContObj1.refreshLineAllResponseList.add(MMIFullquoteTestDataProvider.getQuoteLineWithoutError());
            fqMainContObj1.CreateExtraLineItem();
            
            fqMainContObj1.fullQWrapper.deliverySetUp = null;
            fqMainContObj1.ProductSearch();
            List<HomeBaseBeans.Products> pl=MMIFullquoteTestDataProvider.getQHomeBaseProduct();
            fqMainContObj1.formatProductPriceForMoboSeco(pl);
           
            fqMainContObj1.payLoadtoSaveQuote();
            
            test.stopTest();
        }
    }
    
    static testMethod void testcallRefreshLineService3(){
        User userObj = MMIFullquoteTestDataProvider.getUser();
        System.runAs(userObj){
            test.startTest();
             Account accNew2 = MMIFullquoteTestDataProvider.getAccount();
            accNew2.Result_Id__c = 'P12557879';
            insert accNew2;
            Opportunity opp2 = MMIFullquoteTestDataProvider.getOpportunity();
            opp2.AccountId = accNew2.Id;
            opp2.Delivery_Country__c = 'canada';
            opp2.Delivery_State_Province__c = 'N/A';
            insert opp2;
            
             MMI_Full_Quotes__c mmiFqObj = MMIFullquoteTestDataProvider.getnewteMMIFullQuote();
            insert mmiFqObj;
            
            System.currentPageReference().getParameters().put('Id',opp2.Id);
            
             //System.currentPageReference().getParameters().put('fullQUoteId',mmiFqObj.Quote_Id__c);
             FullQuoteMainController_AC fqMainContObj2 = new FullQuoteMainController_AC();
             fqMainContObj2.FullQuoteMainController_AC_initialize();
             fqMainContObj2.refreshLineAllResponseList.add(MMIFullquoteTestDataProvider.getQuoteLinewithLock());
             fqMainContObj2.CreateExtraLineItem();
             fqMainContObj2.fullQWrapper.rentalLengthInProduct=null;
            fqMainContObj2.enablePeriod();
            fqMainContObj2.fullQWrapper.isUseBillingAddress=false;
            fqMainContObj2.copyBillingAddressToShipping();
            
            System.currentPageReference().getParameters().put('sLineId','1');
            fqMainContObj2.summaryLineList= MMIFullquoteTestDataProvider.getQuoteLine();
            fqMainContObj2.removeLineItemSummaryLine();
            // fqMainContObj2.payLoadtoSaveQuote();
            
            test.stopTest();
        }
    }
    
    static testmethod void testmethodfullQuote(){
        User userObj = MMIFullquoteTestDataProvider.getUser();
        System.runAs(userObj){
            test.startTest();
               System.currentPageReference().getParameters().put('SelectedVaddressRadio','1');
               List<HB_Sales_Inventory__c>  HBSalesInventoryList = MMIFullquoteTestDataProvider.getHBSalesInventoryList();
               insert HBSalesInventoryList;
               List<accessories__c>  getaccessoryList = MMIFullquoteTestDataProvider.getaccessory();
               insert getaccessoryList;
               Account accNew = MMIFullquoteTestDataProvider.getAccount();
               insert accNew;
               
               Product_Brochures_Lookup__c ProductBrochureLookup = MMIFullquoteTestDataProvider.getProductBrochureLookup();
               insert ProductBrochureLookup;
               
               List<HomeBaseBeans.addresses> AddressesList = MMIFullquoteTestDataProvider.getAddressesList();
                
               FullQuoteMainController_AC fqMainContObj  = new FullQuoteMainController_AC();
               fqMainContObj.FullQuoteMainController_AC_initialize(); 
               FullQuoteWrapper fQWrapper = MMIFullquoteTestDataProvider.getFullWrapper();
               fQWrapper.ID  = '50737';
                fqMainContObj.fullQWrapper = fQWrapper;
                list<HomeBaseBeans.quoteLine> sumList1 = MMIFullquoteTestDataProvider.getQuoteLine();
                sumList1[0].itemId = '10I'; 
                fqMainContObj.summaryLineList.add(sumList1[0]);
                list<HomeBaseBeans.quoteLine> sumList2 = MMIFullquoteTestDataProvider.getQuoteLine();
                sumList2[0].itemId = 'CG1';
                fqMainContObj.summaryLineList.add(sumList2[0]);             
                list<FullQuoteWrapper.NewCustomerAccount> ncaLst = new list<FullQuoteWrapper.NewCustomerAccount>();
                FullQuoteWrapper.NewCustomerAccount ncaObj = MMIFullquoteTestDataProvider.getFullQuoteWrpNewCustomerAccount();
                ncaLst.add(ncaObj);
                fqMainContObj.customerAccList = ncaLst;
                
                fQWrapper.AccountId = '';
                fqMainContObj.getNewCustomerAcc();
                
                fqMainContObj.searchSalesInventory();
                fqMainContObj.getSalesInventoryList();
                fqMainContObj.sendEmailToUser();
                fqMainContObj.createOrUpdateContact(accNew.id);
                fqMainContObj.onChangeAddressIdInShippingTab();
                fqMainContObj.onChangeAddressIdInBillingTab();
                
            test.stopTest();
        }
    }
     static testmethod void testmethodfullQuote1(){
        User userObj = MMIFullquoteTestDataProvider.getUser();
        System.runAs(userObj){
            test.startTest();
                Lead ldObj = MMIFullquoteTestDataProvider.getLeadWithDeliveryAdd();
                ldObj.LeadSource = 'Ad Source';
                ldObj.Industry = 'Customer Type';
                insert ldObj;
                Full_Quote_Transactional__c fqsmObj = MMIFullquoteTestDataProvider.getnewFullQuoteTransaction();
                insert fqsmObj;
                Standard_Modification__c stand = MMIFullquoteTestDataProvider.getStandardModification();
                insert stand;
                
                list<Modification_Option_Transactional__c> lstModOption = MMIFullquoteTestDataProvider.getModificationOptionTransactionalList();
                lstModOption[0].Full_Quote_Transactional__c = fqsmObj.Id;
                lstModOption[0].Is_Rejected__c = true;
                lstModOption[0].Approver_User__c = userObj.Id;
                lstModOption[0].Submitter_User__c = userObj.Id;
                lstModOption[0].Standard_Modification__c = stand.id;
                insert lstModOption[0];
                
                System.currentPageReference().getParameters().put('FQSM',fqsmObj.id) ;
                
                
                HomeBaseBeans.account AccountList = MMIFullquoteTestDataProvider.getAccountList();
                System.currentPageReference().getParameters().put('Id',ldObj.Id);
                FullQuoteMainController_AC fqMainContObj  = new FullQuoteMainController_AC();
                fqMainContObj.FullQuoteMainController_AC_initialize();
                fqMainContObj.isApproverButton = true;
                FullQuoteWrapper fQWrapper = MMIFullquoteTestDataProvider.getFullWrapper();
                fQWrapper.LastName = 'tefre';
                fqMainContObj.fullQWrapper = fQWrapper;
                fqMainContObj.CreateAccountInSF();
                fqMainContObj.onchangeNoReservation();
                fqMainContObj.sendToBranchModification();
                fqMainContObj.payLoadtoMarkAsLost();
                
            test.stopTest();
        }
    }
    static testmethod void testsendEmailtoapprov(){
        User userObj = MMIFullquoteTestDataProvider.getUser();
        System.runAs(userObj){
            test.startTest();
                Lead ldObj = MMIFullquoteTestDataProvider.getLeadWithDeliveryAdd();
                ldObj.LeadSource = 'Ad Source';
                ldObj.Industry = 'Customer Type';
                insert ldObj;
                Full_Quote_Transactional__c fqsmObj = MMIFullquoteTestDataProvider.getnewFullQuoteTransaction();
                insert fqsmObj;
                Standard_Modification__c stand = MMIFullquoteTestDataProvider.getStandardModification();
                insert stand;
                
                list<Modification_Option_Transactional__c> lstModOption = MMIFullquoteTestDataProvider.getModificationOptionTransactionalList();
                lstModOption[0].Full_Quote_Transactional__c = fqsmObj.Id;
                lstModOption[0].Is_Rejected__c = true;
                lstModOption[0].Approver_User__c = userObj.Id;
                lstModOption[0].Submitter_User__c = userObj.Id;
                lstModOption[0].Standard_Modification__c = stand.id;
                insert lstModOption[0];
                
                System.currentPageReference().getParameters().put('FQSM',fqsmObj.id) ;
                
                
                HomeBaseBeans.account AccountList = MMIFullquoteTestDataProvider.getAccountList();
                System.currentPageReference().getParameters().put('Id',ldObj.Id);
                FullQuoteMainController_AC fqMainContObj  = new FullQuoteMainController_AC();
                fqMainContObj.FullQuoteMainController_AC_initialize();
                fqMainContObj.isApproverButton = false;
                FullQuoteWrapper fQWrapper = MMIFullquoteTestDataProvider.getFullWrapper();
                fqMainContObj.fullQWrapper = fQWrapper;
                fqMainContObj.sendToBranchModification();
                
            test.stopTest();
        }
    }

    static testMethod void myUnitTestForaddProductToSummaryLines(){
        // TO DO: implement unit test
        User userObj = MMIFullquoteTestDataProvider.getUser();
        System.runAs(userObj){
            test.startTest();
            Account accNew = MMIFullquoteTestDataProvider.getAccount();
            accNew.Result_Id__c = '12557879';
            accNew.Lead_Source__c = 'Ad Source';
            accNew.ShippingState = 'N/A';
            accNew.BillingState = 'N/A';
            insert accNew;
            
            System.currentPageReference().getParameters().put('Id',accNew.Id);
            FullQuoteMainController_AC fqMainContObj = new FullQuoteMainController_AC();
            fqMainContObj.FullQuoteMainController_AC_initialize();
            FullQuoteWrapper fQWrapper = MMIFullquoteTestDataProvider.getFullWrapper();
            fqMainContObj.fullQWrapper = fQWrapper;
            //--------set public list value---------------------------
            list<FullQuoteWrapper.lockTypesAndQuantity> lockList = new list<FullQuoteWrapper.lockTypesAndQuantity>();
            FullQuoteWrapper.lockTypesAndQuantity lockListObj = MMIFullquoteTestDataProvider.getFullQuoteWrplockTypesAndQuantity();
            lockListObj.LockName = 'CG1';
            lockList.add(lockListObj);
            fqMainContObj.lockTypeList = lockList;
            list<list<HomeBaseBeans.quoteLine>> allRefreshQuoteList = new list<list<HomeBaseBeans.quoteLine>>();
            list<HomeBaseBeans.quoteLine> rl1 = MMIFullquoteTestDataProvider.getQuoteLine();
            allRefreshQuoteList.add(rl1);
            list<HomeBaseBeans.quoteLine> rl2 = MMIFullquoteTestDataProvider.getQuoteLine();
            rl2[0].itemId = 'CG1';
            allRefreshQuoteList.add(rl2);
            fqMainContObj.refreshLineAllResponseList = allRefreshQuoteList;
            map<String,string> mapItemName = new map<String,string>();
            mapItemName.put('123','test');
            fqMainContObj.mapItemNameDesc = mapItemName;
            fqMainContObj.SelectedProductDesc = '';
            fqMainContObj.fullQWrapper.disableModificationSelection = true;
            fqMainContObj.fullQWrapper.selectedFullQUote = 'sales';
            /*HomeBaseBeans.chargeCodes cl1 = MMIFullquoteTestDataProvider.getchargeCodes();
            HomeBaseBeans.chargeCodes cl2 = MMIFullquoteTestDataProvider.getchargeCodes();
            list<HomeBaseBeans.chargeCodes> chargeCodeLst = new list<HomeBaseBeans.chargeCodes>();
            chargeCodeLst.add(cl1);
            chargeCodeLst.add(cl2);
            fqMainContObj.chargeCodeList = chargeCodeLst;
            fqMainContObj.chargeCodeSearchList = chargeCodeLst;
            fqMainContObj.ProductExtrasList = MMIFullquoteTestDataProvider.getProductExtrasList();
            fqMainContObj.analysisSetCodesResponseListInShipping = MMIFullquoteTestDataProvider.getAnalysisSetCodes();
            list<FullQuoteWrapper.NewCustomerAccount> ncaLst = new list<FullQuoteWrapper.NewCustomerAccount>();
            FullQuoteWrapper.NewCustomerAccount ncaObj = MMIFullquoteTestDataProvider.getFullQuoteWrpNewCustomerAccount();
            ncaLst.add(ncaObj);
            fqMainContObj.customerAccList = ncaLst;
            fqMainContObj.summaryLineInEdit = MMIFullquoteTestDataProvider.getQuoteLine();
            fqMainContObj.eCodeAllocationList = MMIFullquoteTestDataProvider.getHomeBaseBeansallocationsList();*/
            fqMainContObj.summaryLineList = MMIFullquoteTestDataProvider.getQuoteLine();
            fqMainContObj.summaryLineList.add(MMIFullquoteTestDataProvider.getQuoteLine()[0]);
            fqMainContObj.modList = MMIFullquoteTestDataProvider.getModificationOptionTransactionalList();
            
            //--------set public list value---------------------------
            fqMainContObj.addProductToSummaryLines();
            fqMainContObj.fullQWrapper.selectedFullQUote = 'sales';
            fqMainContObj.addProductToSummaryLines();
            fqMainContObj.removeLineItemSummaryLine();
            
            test.stopTest();
        }
    }
    static testmethod void testFullQuoteAccountCreation(){
        User userObj = MMIFullquoteTestDataProvider.getUser();
        System.runAs(userObj){
            test.startTest();
            Lead ldObj = MMIFullquoteTestDataProvider.getLeadWithDeliveryAdd();
                ldObj.LeadSource = 'Ad Source';
                ldObj.Industry = 'Customer Type';
                insert ldObj;
                Full_Quote_Transactional__c fqsmObj = MMIFullquoteTestDataProvider.getnewFullQuoteTransaction();
                insert fqsmObj;
                Standard_Modification__c stand = MMIFullquoteTestDataProvider.getStandardModification();
                insert stand;
                
                list<Modification_Option_Transactional__c> lstModOption = MMIFullquoteTestDataProvider.getModificationOptionTransactionalList();
                lstModOption[0].Full_Quote_Transactional__c = fqsmObj.Id;
                lstModOption[0].Is_Rejected__c = true; 
                lstModOption[0].Approver_User__c = userObj.Id;
                lstModOption[0].Submitter_User__c = userObj.Id;
                lstModOption[0].Standard_Modification__c = stand.id;
                insert lstModOption[0];
                Branch_Lookup__c branch = MMIFullquoteTestDataProvider.getBranchLookup();
                insert branch;
                System.currentPageReference().getParameters().put('FQSM',fqsmObj.id) ;
                FullQuoteWrapper fQWrapper = MMIFullquoteTestDataProvider.getFullWrapper();
                FullQuoteMainController_AC fqMainContObj  = new FullQuoteMainController_AC();
                fqMainContObj.FullQuoteMainController_AC_initialize();
                fqMainContObj.fullQWrapper = fQWrapper;
                fqMainContObj.newAccountId = 'test';
                fqMainContObj.sendToBranchModification();
                fqMainContObj.ZipCodeFinder();
                fqMainContObj.ZipCodeFinderShipping();
                fqMainContObj.newAccountId = 'test';
                
                
            test.stopTest();
        }
    }
    
    static testMethod void myUnitTestFqFromJP() {
        // TO DO: implement unit test
        User userObj = MMIFullquoteTestDataProvider.getUser();
        System.runAs(userObj){
            test.startTest();
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
            
            System.currentPageReference().getParameters().put('source','jp');
            System.currentPageReference().getParameters().put('accId',acc.Id);
            System.currentPageReference().getParameters().put('Id',jp.Id);
            System.currentPageReference().getParameters().put('scId',sc.Id);
            System.currentPageReference().getParameters().put('conId',con.Id);
            FullQuoteMainController_AC fqMainContObj3 = new FullQuoteMainController_AC();
            fqMainContObj3.FullQuoteMainController_AC_initialize();
            /*fqMainContObj3.populateAddressFromJp();
            fqMainContObj3.rePopulateContactDetail();
            fqMainContObj3.updateAccount(acc.Id);
            fqMainContObj3.sendHfcStatusMail();*/
            test.stopTest();
        }
    }
    
    
    static testMethod void myUnitTestEditFQ() {
        // TO DO: implement unit test
        User userObj = MMIFullquoteTestDataProvider.getUser();
        System.runAs(userObj){
            test.startTest();
            
            MMI_Full_Quotes__c mmiFqObj = MMIFullquoteTestDataProvider.getnewteMMIFullQuote();
            insert mmiFqObj;
            System.currentPageReference().getParameters().put('fullQUoteId',mmiFqObj.Id);
            FullQuoteMainController_AC fqMainContObj1 = new FullQuoteMainController_AC();
            fqMainContObj1.FullQuoteMainController_AC_initialize();
            //fqMainContObj1.payLoadtoSaveQuote();
            test.stopTest();
        }
    }
    
    static testMethod void myUnitTestForEmailNoZone() {
        // TO DO: implement unit test
        User userObj = MMIFullquoteTestDataProvider.getUser();
        System.runAs(userObj){
            test.startTest();
            
            Lead ldObj = MMIFullquoteTestDataProvider.getLeadWithDeliveryAdd();
            insert ldObj;
            
            System.currentPageReference().getParameters().put('Id',ldObj.Id);
            FullQuoteMainController_AC fqMainContObj = new FullQuoteMainController_AC();
            fqMainContObj.FullQuoteMainController_AC_initialize();
            fqMainContObj.AddressAssign();
            
            Account accNew = MMIFullquoteTestDataProvider.getAccount();
            accNew.Result_Id__c = '12557879';
            insert accNew;
            Opportunity opp = MMIFullquoteTestDataProvider.getOpportunity();
            opp.AccountId = accNew.Id;
            opp.Delivery_Country__c = 'canada';
            opp.Delivery_State_Province__c = 'N/A';
            insert opp;
            
            Opportunity opp2 = MMIFullquoteTestDataProvider.getOpportunity();
            opp2.AccountId = accNew.Id;
            opp2.Delivery_Country__c = 'united states';
            opp2.Delivery_State_Province__c = 'N/A';
            insert opp2;
            
            System.currentPageReference().getParameters().put('Id',opp.Id);
            FullQuoteMainController_AC fqMainContObj2 = new FullQuoteMainController_AC();
            fqMainContObj2.FullQuoteMainController_AC_initialize();
            fqMainContObj2.DisableKnowDelZoneBtn();
            fqMainContObj2.NoDelZoneRates();
            
            test.stopTest();
        }
    }
    
    static testMethod void myUnitTestForCustomerAndBilling() {
        // TO DO: implement unit test
        User userObj = MMIFullquoteTestDataProvider.getUser();
        System.runAs(userObj){
            test.startTest();
            Lead ldObj = MMIFullquoteTestDataProvider.getLeadWithDeliveryAdd();
            insert ldObj;
            
            System.currentPageReference().getParameters().put('Id',ldObj.Id);
            FullQuoteMainController_AC fqMainContObj = new FullQuoteMainController_AC();
            fqMainContObj.FullQuoteMainController_AC_initialize();
            fqMainContObj.AddressAssign();
            
            Account accNew = MMIFullquoteTestDataProvider.getAccount();
            accNew.Result_Id__c = '12557879';
            insert accNew;
            Opportunity opp = MMIFullquoteTestDataProvider.getOpportunity();
            opp.AccountId = accNew.Id;
            opp.Delivery_Country__c = 'canada';
            opp.Delivery_State_Province__c = 'N/A';
            insert opp;
            
            Opportunity opp2 = MMIFullquoteTestDataProvider.getOpportunity();
            opp2.AccountId = accNew.Id;
            opp2.Delivery_Country__c = 'united states';
            opp2.Delivery_State_Province__c = 'N/A';
            insert opp2;
            
            System.currentPageReference().getParameters().put('Id',opp.Id);
            FullQuoteMainController_AC fqMainContObj2 = new FullQuoteMainController_AC();
            fqMainContObj2.FullQuoteMainController_AC_initialize();
            fqMainContObj2.showContactPopUp();
            fqMainContObj2.showAddContactPopUp();
            fqMainContObj2.callLIstContactWS('102', '50737');
            fqMainContObj2.callSpecificContactWS('1','50737');
            fqMainContObj2.callAddOrUpdateContactWS('102','50737','affsdfsdfsd','add');
            fqMainContObj2.generateAddOrUpdatePayload('1','102', null, null);
            fqMainContObj2.cancelAddContactPopUp();
            fqMainContObj2.AddContact();
            fqMainContObj2.ListContact();
            fqMainContObj2.EditContact();
            fqMainContObj2.resetContactForm();
            fqMainContObj2.resetCardForm();
            fqMainContObj2.BackToContact();
            fqMainContObj2.renderContactTab();
            fqMainContObj2.renderCardTab();
            fqMainContObj2.renderAchTab();
            fqMainContObj2.UpdateContact();
            fqMainContObj2.showAddCardTab();
            fqMainContObj2.AddCard();
            fqMainContObj2.EditCard();
            fqMainContObj2.UpdateCard();
            fqMainContObj2.callListCards('1','50737');
            fqMainContObj2.callListACH('1','50737');
            fqMainContObj2.callAddCard();
            fqMainContObj2.callUpdateCard();
            fqMainContObj2.generateAddOrUpdateCardPayload('1','-1223555','566555','34534534','add');
            
            fqMainContObj2.showAddAchTab();
            fqMainContObj2.BackToCard();
            fqMainContObj2.resetAchForm();
            fqMainContObj2.AddAch();
            fqMainContObj2.PershingError('sdfgdfgdf c:firstName');
            fqMainContObj2.EditAch();
            fqMainContObj2.UpdateAch();
            fqMainContObj2.generateAddOrUpdateAchPayload('1','-213213','3242343','234','add');
            fqMainContObj2.callAddAch();
            fqMainContObj2.callUpdateAch();
            fqMainContObj2.deliveryContactIdEnterbyUser();
           // fqMainContObj2.rePopulateContactDetail();
            
            EmailTemplate validEmailTemplate = new EmailTemplate();
            validEmailTemplate.isActive = true;
            validEmailTemplate.Name = 'name';
            validEmailTemplate.Body = 'Bodyval';
            validEmailTemplate.DeveloperName = 'sarfd423423';
            validEmailTemplate.TemplateType = 'text';
            validEmailTemplate.FolderId = UserInfo.getUserId();
            insert validEmailTemplate;
            
            fqMainContObj2.showEmailTemplate();
            fqMainContObj2.selectedEmailTemplateId = validEmailTemplate.Id;
            fqMainContObj2.generateEmailBody();
            
            test.stopTest();
        }
    }
    
    private static testMethod void  UnitTestHomebase() {
         HomeBaseBeans hBase = new HomeBaseBeans();
              HomeBaseBeans.AddressBean hm = new HomeBaseBeans.AddressBean();
              HomeBaseBeans.ProductSearch  ps = new HomeBaseBeans.ProductSearch();
              HomeBaseBeans.Branches  pb = new HomeBaseBeans.Branches();
              HomeBaseBeans.QuickQuoteRefreshFormat qq = new HomeBaseBeans.QuickQuoteRefreshFormat();
              HomeBaseBeans.QuickQuoteRefreshFormat  qqr =new HomeBaseBeans.QuickQuoteRefreshFormat();
              HomeBaseBeans.rates  rate = new HomeBaseBeans.rates('test','testDescription');
              HomeBaseBeans.QuickQuoteRefreshFormat  qqrf = new HomeBaseBeans.QuickQuoteRefreshFormat();
              HomeBaseBeans.States state = new HomeBaseBeans.States('cmyId','cuntryId','Id','name');
              HomeBaseBeans.countries  count = new HomeBaseBeans.countries('test1','test');
              HomeBaseBeans.transactions  trans = new HomeBaseBeans.transactions('id','description');
              HomeBaseBeans.webAddresses web = new HomeBaseBeans.webAddresses('cmyId','branchId','addr1', 'addr2','addr3','addr4',
                                                    'state', 'zipCode','countryId','cStreet1','cStreet2','taxId',
                                                     'distanceFromBranch','deliveryZone','zoneWarning','latitude','longitude',
                                                     'distanceBranch','fulfillingBranchId','fulfillingBranchName', 'oldPostalCode');
        
              HomeBaseBeans.TaxIds  tax = new HomeBaseBeans.TaxIds('Id','tas','country','CouDesc','country1','state','stateDesc','city');
              HomeBaseBeans.Products prod = new HomeBaseBeans.Products('Id','des','qtyavail','qFree','qWip','qReserved',
                                         'qTotal','cmm1','cmm2','cmm3','cmm4','llw','ppe','mainFeature');
              HomeBaseBeans.product  prd = new HomeBaseBeans.product('id','description',true,'qtyAvail','qtyFree','qtyWip',
                        'qtyReserved','qtyTotal','chargeCode','commission1','commission2',
                        'commission3','commission4');
              //HomeBaseBeans.payment  pay = new HomeBaseBeans.payment(10,11);
              HomeBaseBeans.quickQuoteRefresh  quick = new HomeBaseBeans.quickQuoteRefresh();
              HomeBaseBeans.shippingAddress2  shp = new HomeBaseBeans.shippingAddress2();
              HomeBaseBeans.CreateQuickQuoteRequest quick1 = new HomeBaseBeans.CreateQuickQuoteRequest();
              HomeBaseBeans.CreateQuoteResponse  cqr = new HomeBaseBeans.CreateQuoteResponse();
              HomeBaseBeans.contactSummaryList   csl = new HomeBaseBeans.contactSummaryList('surname',
                                       'contactId',
                                       'emailId',
                                      'forename');
              HomeBaseBeans.contact con = new HomeBaseBeans.contact('surname',
                           'position',
                           'email',
                           'contactId',
                            'forename',
                           'telNumber',
                           'telMobile');
             HomeBaseBeans.AnalysisSetHeaders  ana = new HomeBaseBeans.AnalysisSetHeaders();
             HomeBaseBeans.analysisSetCodes setcode = new HomeBaseBeans.analysisSetCodes();
             HomeBaseBeans.addresses add = new HomeBaseBeans.addresses();
           
            HomeBaseBeans.analysisDtls dtls = new HomeBaseBeans.analysisDtls(); 
            HomeBaseBeans.QuickQuoteRefreshFormat   qqrf1 = new HomeBaseBeans.QuickQuoteRefreshFormat();
            //HomeBaseBeans.payment pay = new   HomeBaseBeans.payment(10,Date.parse('05/11/2010'));
            HomeBaseBeans.quickQuoteRefresh   refresh = new HomeBaseBeans.quickQuoteRefresh();
            
          HomeBaseBeans.CreateQuickQuoteRequest  quickRequest = new HomeBaseBeans.CreateQuickQuoteRequest();
          HomeBaseBeans.CreateQuoteResponse   res = new HomeBaseBeans.CreateQuoteResponse();
          HomeBaseBeans.account acc = new HomeBaseBeans.account('name', 
                           'id',
                           10.12,
                           'lastInvoiceDate',
                           'salesTerms',
                           'termsCode',
                           10.45,
                           'rentalTerms',
                           'taxExemptionCertificate',
                           true,
                           'creditStatus',
                           'certificateOfInsurance');
          HomeBaseBeans.AddCardResponse   cResponse = new  HomeBaseBeans.AddCardResponse();
          HomeBaseBeans.AutocheckResponse   autoResponse = new  HomeBaseBeans.AutocheckResponse();
          HomeBaseBeans.UpdateContact updateCon = new HomeBaseBeans.UpdateContact();
          HomeBaseBeans.knowZoneRatesEmailParam   emailParam = new HomeBaseBeans.knowZoneRatesEmailParam();
          HomeBaseBeans.ExtraInOrderDetails  inOrderDetail = new HomeBaseBeans.ExtraInOrderDetails();
          HomeBaseBeans.OrderAndDeliveriesParam    deliverParam = new HomeBaseBeans.OrderAndDeliveriesParam();
          HomeBaseBeans.MainLine  mainLine = new HomeBaseBeans.MainLine();
          HomeBaseBeans.orderAndDeliveries orderOndel = new HomeBaseBeans.orderAndDeliveries();
          HomeBaseBeans.lines ln= new HomeBaseBeans.lines();
          HomeBaseBeans.rates1 r1 = new HomeBaseBeans.rates1();
          HomeBaseBeans.billingAddress bAdd = new HomeBaseBeans.billingAddress();
          HomeBaseBeans.billingContactDetails bcd = new HomeBaseBeans.billingContactDetails();
          HomeBaseBeans.product pr = new HomeBaseBeans.product();
          HomeBaseBeans.QuickQuoteRefreshFormat rFormat = new HomeBaseBeans.QuickQuoteRefreshFormat();
    }
    
    
}