/**
* (c) 2015 TEKsystems Global Services
*
* Name           : ViewMoreControllerTest
* Created Date   : 1 December, 2015
* Created By     : Jailabdin shaik
* Purpose        : Test class for ViewMoreController class.
* 
**/


@isTest
public class ViewMoreControllerTest {
    static testmethod void viewmoretest() {
        
        Account acc = new Account();
        acc.name='test account';
        //acc.recordtypeid =  [select id,name from RecordType where name = 'Business Account - UK'].ID;
        acc.recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Business Account - UK').getRecordTypeId();
        acc.BillingState = 'AZ';
        acc.BillingCountry = 'US';
        insert acc;
        
        Contact con = new Contact(LastName='Test');
        insert con;
        
        Test.startTest();
        Opportunity opp = new Opportunity(name='Test Opp');
        opp.CloseDate = date.today();
        opp.StageName = 'Not Quoted';
        opp.Opportunity_Rating__c = 'Warm (Possibly Order)';
        opp.Opportunity_Contact_Name_LookUpFilter__c = con.id;
        opp.Account = acc;
        opp.Billing_Zip_Postal_Code__c = '85226';
        opp.Delivery_Zip_Postal_Code__c = '85226';
        opp.Why_do_you_need_storage_Picklist__c = 'Retail';
        opp.How_long_will_you_need_your_unit_UK__c = 2;
        //opp.recordtypeid =  [select id,name from RecordType where name = 'Standard Opportunity - UK'].ID;
        opp.recordtypeid =  Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity - UK').getRecordTypeId();
        insert opp;
        
        Quote_Header__c QH1=new Quote_Header__c();
        QH1.status__C='Open';
        QH1.Opportunity__c = opp.id;
        
        QH1.Account__c=acc.id;
        QH1.Start_Date__c=Date.Today();
        QH1.Delivery_Date__c=Date.Today() + 10;
        QH1.Delivery_City__c = 'Test City';
        insert QH1;
        
        Quote_Item_Level__c QL1 =new Quote_Item_Level__c();
        QL1.Quote_Header__c=QH1.id;
        QL1.Item_Code__c='TESTCODE';
        QL1.Actual_Amount__c=25.00;
        insert QL1;
        
        Quote_Item_Level__c QL2 =new Quote_Item_Level__c();
        QL2.Quote_Header__c=QH1.id;
        QL2.Item_Code__c='TESTCODE2';
        QL2.Actual_Amount__c=25.00;
        insert QL2;
      
        Quote_Sub_Item_Level__c QSL1 = new Quote_Sub_Item_Level__c();
        QSL1.Quantity__c =10;
        QSL1.Quote_Header__c = QH1.id;
        QSL1.Quote_Item_level_ID__c = QL1.id;
        QSL1.Actual_Amount__c = 1000;
        QSL1.ADJ_COND_TYPE__c = 'ZTOT';  
        insert QSL1;
        
        Quote_Sub_Item_Level__c QSL2 = new Quote_Sub_Item_Level__c();
        QSL2.Quantity__c =0;
        QSL2.Quote_Header__c = QH1.id;
        QSL2.Actual_Amount__c = 1000;
        QSL2.ADJ_COND_TYPE__c = 'ZTOT';  
        insert QSL2;
        
        // Service_Order_Request__c sor1=new Service_Order_Request__c();
       // sor1.Account_Name__c=acc.id;
       // sor1.Status__c='Submitted';
        
       // sor1.recordtypeid = Schema.SObjectType.Service_Order_Request__c.getRecordTypeInfosByName().get('Service Order Request (MMI) 1000').getRecordTypeId();
       // insert sor1;
        
        CPQActiveURL__c cpq=new CPQActiveURL__c();
        //cpq.URL_Active__c=true; 
        cpq.Name='DevURL';
        cpq.CPQ_URL__c='http://cpq-devapp/CPQ';
        cpq.Environment__c = URL.getSalesforceBaseUrl().getHost(); 
        cpq.Portal_URL__c = 'http://cpq-devweb.mobilemini.com/CPQ';
        insert cpq;
        Test.stopTest();
        date dt=date.today();
        string dateinstring=String.valueOf(dt);
        
        ApexPages.currentPage().getParameters().put('accId', acc.Id);
        ApexPages.currentPage().getParameters().put('from','SOR');
        ApexPages.currentPage().getParameters().put('status','teststatus');
        ApexPages.currentPage().getParameters().put('fromdt', dateinstring);
        ApexPages.currentPage().getParameters().put('todt', dateinstring);
        ApexPages.currentPage().getParameters().put('srno','123456');
        ApexPages.currentPage().getParameters().put('fromFilter','YES');
         
        ViewMoreController viewmore = new ViewMoreController();
        
        
        
        ViewMoreController.getAccID();
        ViewMoreController.getAllQuotes();
        viewmore.getAllContracts();
        //viewmore.getQuoteLineItem();
        viewmore.getVAl();
        
        viewmore.getContractStatusList();
        viewmore.applyContractFilters();
        viewmore.resetContractFilters();
        
        ViewMoreController.QuoteHeaderWrapper QHW =new ViewMoreController.QuoteHeaderWrapper(QH1,'tst',0.0,'Business Account','1234');
        
        ViewMoreController.WrapperContractItems WCI = new ViewMoreController.WrapperContractItems('1','1','1','1','1','1','1','1',dateinstring,dateinstring,'rec',dateinstring,'fuldepot','billingPlanRel');
        List<ViewMoreController.WrapperContractItems> wciList = new List<ViewMoreController.WrapperContractItems>();
        wciList.add(WCI);
        String dt1 = String.valueOf(date.today());
       // String dt2 = String.valueOf(date.today());
        ViewMoreController.Wrapperforcontracts WC = new ViewMoreController.Wrapperforcontracts('800015','12345','street','city','rg','123456',wciList,'exp','expMaterial','plant name',dt1,dt1,'US',dt1,'X');
               
        doCallOut(); 
          ApexPages.currentPage().getParameters().put('fromdt', '2015/02/02');
        ApexPages.currentPage().getParameters().put('todt','');
        ApexPages.currentPage().getParameters().put('from','CS');
        ViewMoreController viewmore3 = new ViewMoreController();
        
        ApexPages.currentPage().getParameters().put('fromdt', '');
        ApexPages.currentPage().getParameters().put('from','NPS');
        ApexPages.currentPage().getParameters().put('todt','2015/02/02');
        
        ViewMoreController viewmore2 = new ViewMoreController();
        
      
        
    }
    
    @future(callout=true)
    private static void doCallOut( ){
         date dt=date.today();
        date stdt = dt.addMonths(-12);
        string CON_ST_DAT=String.valueOf(dt);
        string CON_EN_DAT=String.valueOf(stdt);
        Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
        //List<sapComDocumentSapRfcFunctions.ZSD_ORDER_HEADER> = DataForcontracts.fetchContractsFromResponse('800015');
        List<ViewMoreController.Wrapperforcontracts> contractsList = ViewMoreController.getContracts('800015','Business Account - UK','100',CON_ST_DAT,CON_EN_DAT,'','',''); 
    }
    
}