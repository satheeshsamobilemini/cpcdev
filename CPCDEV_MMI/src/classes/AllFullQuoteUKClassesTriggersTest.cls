/**
* (c) 2015 TEKsystems Global Services
*
* Name           : AllFullQuoteUKClassesTriggersTest
* Created Date   : 22 May 2015
* Created By     : Sreenivas M (TEK)
* Purpose        : Test class for below components 
                   1.MMIFullQuoteUKTrigger
                   2.FullQuoteUKLineItemTrigger
                   3.FullQuotePDF_UK_Ctrl
                   4.RFDUKPDFController
*
**/
@isTest
public class AllFullQuoteUKClassesTriggersTest
{
   static testmethod void createQuoteHistoryRecod()
    {
       User u=MMIFullquoteTestDataProvider.getUser(); 
        System.runAs(u) {
                  
           // Load the test accounts from the static resource
           List<sObject> ls = Test.loadData(FullQuoteUKHistoryMapping__c.sObjectType, 'testFullQuoteUKCusSettings');
       }      
       Account objBusAcc = MMIFullquoteTestDataProvider.getBusinessAccount();
       insert objBusAcc;
       
       MMI_Full_Quotes_UK__c objFQUK = TestDataUtil_UK.createFullQuoteUk();
       objFQUK.Account__c = objBusAcc.id;
       insert objFQUK;
       
       List<Product_UK__c> listProducts = TestDataUtil_UK.createProductList();
       insert listProducts;
       
       Frequency_Multiplier_Mapping__c objFMM = new Frequency_Multiplier_Mapping__c(name='Fortnightly',Multiplier__c=2.00);
       insert objFMM;
       
       Full_Quote_UK_LineItem__c objFQLI1 = new Full_Quote_UK_LineItem__c(Unit_Type__c ='Servicing',Total__c = 56, MMI_Full_Quote_UK__c=objFQUK.id,Product_UK__c = listProducts[0].id,Price__c=60.0,Quantity__c = 2,Unit_Type_2__c='Service',Description__c='other',Frequency__c='1');
       Full_Quote_UK_LineItem__c objFQLI2 = new Full_Quote_UK_LineItem__c(MMI_Full_Quote_UK__c=objFQUK.id,Total__c = 56, Product_UK__c = listProducts[0].id,Price__c=60.0,Quantity__c = 2,Unit_Type_2__c='Service',Description__c='Fortnightly',Frequency__c='1',Details__c ='Test');
       Full_Quote_UK_LineItem__c objFQLI3 = new Full_Quote_UK_LineItem__c(Unit_Type__c ='Servicing', Total__c = 56, MMI_Full_Quote_UK__c=objFQUK.id,Product_UK__c = listProducts[0].id,Price__c=60.0,Quantity__c = 2,Unit_Type_2__c='Service',Description__c='other',Frequency__c='2');
       Full_Quote_UK_LineItem__c objFQLI4 = new Full_Quote_UK_LineItem__c(Unit_Type__c ='Servicing', Total__c = 56, MMI_Full_Quote_UK__c=objFQUK.id,Product_UK__c = listProducts[0].id,Price__c=60.0,Quantity__c = 2,Unit_Type_2__c='Accessory',Description__c='other',Frequency__c='2');
       insert new List<Full_Quote_UK_LineItem__c>{objFQLI1,objFQLI2,objFQLI3,objFQLI4};
       
       System.assert([select id from Quote_History_UK_LineItem__c].size()==4,'Error while creating quote history lineitems record');
        System.assert([select id from Quote_History_UK__c where Quote__c =:objFQUK.id].size()==1,'Error while creating quote history record');
        //Logic to cover QuoteEdit page
       ApexPages.StandardController stdCtrl = new ApexPages.StandardController(objFQUK);
       FullQuoteEditFormUK_Extn fqEditExtn = new FullQuoteEditFormUK_Extn(stdCtrl);
       Pagereference p =fqEditExtn.gotoEdit();
       System.debug('p...'+p);
       
        p.setRedirect(true);
       Test.setCurrentPage(p);
      
       //Logic to cover FullQuotePDF_UK_Ctrl class    FullQuotePDF_UK_Ctrl objFQPDFCtrl = 
       ApexPages.currentPage().getParameters().put('Id',objFQUK.id);
       new FullQuotePDF_UK_Ctrl();
       
       //Logic to cover RFDUKPDFController class RFDUKPDFController rfdPDFCtrk = 
       new RFDUKPDFController();
        
    }
    
    static testmethod void testContactCreation()
    {
       User u=MMIFullquoteTestDataProvider.getUser(); 
        System.runAs(u) {
                  
           // Load the test accounts from the static resource
           List<sObject> ls = Test.loadData(FullQuoteUKHistoryMapping__c.sObjectType, 'testFullQuoteUKCusSettings');
       }      
       Account objBusAcc = MMIFullquoteTestDataProvider.getBusinessAccount();
       objBusAcc.RecordTypeId =Schema.SObjectType.Account.getRecordTypeInfosByName().get('Business Account - UK').getRecordTypeId();
       insert objBusAcc;
       
       Opportunity opp = MMIFullquoteTestDataProvider.getOpportunity();
       opp.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity - UK').getRecordTypeId();
       insert opp;
       
       MMI_Full_Quotes_UK__c objFQUK = TestDataUtil_UK.createFullQuoteUk();
       objFQUK.Account__c = objBusAcc.id;
       objFQUK.opportunity__c = opp.id;
       objFQUK.Billing_Last_Name__c = 'gtstkek';
       objFQUK.Delivery_Last_Name__c = 'gghhww';
       
       insert objFQUK;
       MMIFullQuoteUKTriggerHandler.runBefTrigger = true;
       update objFQUK;
    }          
      
}