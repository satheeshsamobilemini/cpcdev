@isTest
public class TestInvoiceSearchController {
    static testmethod void invSearchTest(){
       Test.startTest();
        Account acc = new Account();
            acc.name='test accounthart';
            acc.SAP_Bill_To__c = '0000800015';
            acc.SAP_Sold_To__c = '0000800015';
            
            acc.BillingState = 'AZ';
            acc.BillingCountry = 'US';
            acc.recordtypeid =  [select id,name from RecordType where name = 'Business Account'].ID;
            insert acc;
        
            Contact con = new Contact(LastName='TestHSundara');
        con.AccountId = acc.Id;
            con.Email = 'hsundara@teksystems.com';
            insert con;
            String caseOwner = [Select Id,Name from User where Id=:userinfo.getuserId()].Name;
            
             ApexPages.currentPage().getParameters().put('invoicenum','0090000040');
            InvoiceSearchController invVar = new InvoiceSearchController();
            invVar.conFn = 'test';
            invVar.conLn = 'con';
            invVar.conPh = '234567';
            invVar.AccId = acc.Id;
          InvoiceSearchController.DomainOrderReason dor = new InvoiceSearchController.DomainOrderReason();
        InvoiceSearchController.DomainWrapper dw = new InvoiceSearchController.DomainWrapper();
        InvoiceSearchController.WrapperLineItemPricing linePriceVar = new InvoiceSearchController.WrapperLineItemPricing();
                linePriceVar.ITM_NUMBER ='000010';
                linePriceVar.STEP_NUMBER ='90';
                linePriceVar.COUNTER = '02';
                linePriceVar.COND_TYPE = 'ZP00';
                linePriceVar.VTEXT = 'MMI 28 Day Rate';
                linePriceVar.RATE = 1425.00;
                linePriceVar.CURRENCY_x = 'USD';
                linePriceVar.AMOUNT = 1425.00;
                linePriceVar.CONDITIONAL_VALUE = 10.00;
        List<InvoiceSearchController.WrapperLineItemPricing> linePriceList = new List<InvoiceSearchController.WrapperLineItemPricing>();
        linePriceList.add(linePriceVar);
        InvoiceSearchController.WrapperLineItems invLineVar = new   InvoiceSearchController.WrapperLineItems('000010','40ZK','40ZK 40 Double Doors','1.000','EA',1691.4,'0000000077','','1101','ZSL1',0.00,linePriceList);
            /* invLineVar.ITM_NUMBER = '000010';
                invLineVar.MATERIAL = '40ZK';
                invLineVar.DESCRIPTION = '40ZK 40 Double Doors';
                invLineVar.QUANTITY = '1.000';
                invLineVar.UNIT_OF_MEASURE = 'EA';
                invLineVar.AMOUNT = 1691.4;
                invLineVar.CONTRACT ='0000000077';
                invLineVar.CONTRACT_LINE = '';
                invLineVar.PLANT = '1101';
                invLineVar.ITEM_CATEG = 'ZSL1';
                invLineVar.ITEM_TAX = 0.00;
                invLineVar.linePricingList = linePriceList;*/
        List<InvoiceSearchController.WrapperLineItems> invLineList = new List<InvoiceSearchController.WrapperLineItems>();
        invLineList.add(invLineVar);
        InvoiceSearchController.WrapperInvoiceHeader invHdr = new InvoiceSearchController.WrapperInvoiceHeader();
                    invHdr.INVOICE_NUMBER='0090000040';
                    invHdr.SALES_ORG= '1000';
                    invHdr.DISTR_CHAN = '210';
                    invHdr.INVOICE_DATE='06/29/2015';
                    invHdr.TERMS_CODE='NT30';
                    invHdr.INVOICE_AMOUNT='1779.98';
                    invHdr.CURRENCY_x='USD';
                    invHdr.PAYING_CUSTOMER='0000800015';
                    invHdr.SOLD_TO_CUSTOMER='0000800015';
                    invHdr.CONTRACT ='0000000077' ;
                    invHdr.DOC_CATEG = 'M';
                    invHdr.lineItemList=invLineList;
            invVar.invoiceHeader = invHdr;
            invVar.billFromDate='2016/06/5';
            invVar.billToDate='2016/06/5';
            invVar.displayHeaderLineItem(invHdr);
            invVar.lineItemsList = invLineList;
                        
            Id CredMMIRecTypeId = [SELECT id,Name, DeveloperName FROM RecordType WHERE isActive = true AND (sObjectType = 'Service_Order_Request__c' AND DeveloperName = 'SAP_Credits_MMI')].Id;
            ApexPages.currentPage().getParameters().put('RecordType', CredMMIRecTypeId);
            ApexPages.currentPage().getParameters().put('accName',acc.Name);
            ApexPages.currentPage().getParameters().put('accId',acc.Id);
            Apexpages.currentPage().getParameters().put('con',con.Id);
           doCallOut3();
            doCallOut(acc.Id,acc.Name);
            invVar.showsearchPopup();
            invVar.closePopup();
            //invVar.setSORContact();
            invVar.retrieveInvoiceList();
            invVar.redirect();
            invVar.NavigateBack();
            doCallOut2();
            invVar.navigateToPrev();
        invVar.saveGeneralCreditCase();
            invVar.saveCreditCase();
            //doCallout3(acc.Id,acc.Name,con.Id);
            invVar.showContactPopup();
            invVar.closeContactPopup();
            invVar.selectedContact();
            invVar.invHistoryload();
            invVar.setSORContact();
            //invVar.ContactCreateArea(); --> TFS - Apex
            invVar.CreateContact();
          Test.stopTest();  
     }   
    @future(callout=true)
     private static void doCallOut(Id accId , String accName){
         InvoiceSearchController inv = new InvoiceSearchController();
        Test.setMock(WebServiceMock.class, new MockInvoiceHistoryWebservice());
         inv.selectedInvoiceStatus = '';
        //inv.getInvoiceHistory(accId,accName,'20150101','20160701','Open',null,false,null);
        inv.getInvoiceHistory(accId,accName,'20150101','20160701','Open','10',null,false,null);
    }
    
    @future(callout=true)
    private static void doCallOut2(){
        
        Test.setMock(WebServiceMock.class, new MockInvoiceDetailWebservice());
        
       InvoiceSearchController.WrapperInvoiceHeader invHdrRespVar = InvoiceSearchController.getInvoiceDetails('0090000040');
        
       
    }
 
    @future(callout=true)
    private static void doCallOut3(){
        // Set mock callout class 
       InvoiceSearchController inv = new InvoiceSearchController();
        Test.setMock(HttpCalloutMock.class, new MockSeedDataWebservice());
       inv.getReasonForCreditPickList();
     }
        
       
     

}