/**
* (c) 2015 TEKsystems Global Services
*
* Name           : TestAccountDashboardCntrl
* Created Date   : 17 August, 2015 @ 1130
* Created By     : Srinivas M
* Purpose        : Test class for AccountDashboardCntrl class.
* 
**/

@isTest
public class TestAccountDashboardCntrl{
    static testmethod void testaccountctrl() {
        
        Account acc = new Account();
            acc.name='test account';
            acc.Revenue_Q1__c=100.00;
            acc.Revenue_Q2__c=200.00;
            acc.Revenue_Q3__c=100.00;
            acc.Revenue_Q4__c=222.00;
            acc.Revenue_Q5__c=565.00;
            acc.Revenue_Q6__c=5656.00;
            acc.Revenue_Q7__c=56.00;
            acc.Revenue_QC__c=566.00;
            acc.BillingState = 'AZ';
            acc.BillingCountry = 'US';
            acc.recordtypeid =  [select id,name from RecordType where name = 'Business Account - UK'].ID;
            insert acc;
        
        Contact con = new Contact(LastName='Test');
        insert con;
        
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
        opp.recordtypeid =  [select id,name from RecordType where name = 'Standard Opportunity - UK'].ID;
        insert opp;
        
        Opportunity opp1 = new Opportunity(name='Test Opp1');
        opp1.CloseDate = date.today();
        opp1.StageName = 'Not Quoted';
        opp1.Opportunity_Rating__c = 'Warm (Possibly Order)';
        opp1.Opportunity_Contact_Name_LookUpFilter__c = con.id;
        opp1.Account = acc;
        opp1.Billing_Zip_Postal_Code__c = '85226';
        opp1.Delivery_Zip_Postal_Code__c = '85226';
        opp1.Why_do_you_need_storage_Picklist__c = 'Retail';
        opp1.How_long_will_you_need_your_unit_UK__c = 2;
        opp1.recordtypeid =  [select id,name from RecordType where name = 'Standard Opportunity - UK'].ID;
        insert opp1;
            
        List<Quote_Header__c> recentQuotes = new List<Quote_Header__c>();
        Quote_Header__c QH1=new Quote_Header__c();
            QH1.status__C='Open';
            QH1.Opportunity__c = opp.id;
            QH1.Account__c=acc.id;
            QH1.Start_Date__c=Date.Today();
            QH1.Delivery_Date__c=Date.Today();
            QH1.Delivery_City__c = 'Test City';
            recentQuotes.add(QH1);
        Quote_Header__c QH2=new Quote_Header__c();
            QH2.status__C='Open';
            QH2.Opportunity__c = opp1.id;
            QH2.Account__c=acc.id;
            QH2.Start_Date__c=Date.Today();
            QH2.Delivery_Date__c=Date.Today();
            QH2.Delivery_City__c = 'Test City1';
            recentQuotes.add(QH2);
        insert recentQuotes;
        
        List<Quote_Item_Level__c > recentQuotes2 = new List<Quote_Item_Level__c >();
        Quote_Item_Level__c QL1 =new Quote_Item_Level__c();
            QL1.Quote_Header__c=QH1.id;
            QL1.Item_Code__c='TESTCODE';
            QL1.Actual_Amount__c=25.00;
            recentQuotes2.add(QL1);
        Quote_Item_Level__c QL2 =new Quote_Item_Level__c();
            QL2.Quote_Header__c=QH1.id;
            QL2.Item_Code__c='TESTCODE2';
            QL2.Actual_Amount__c=25.00;
            recentQuotes2.add(QL2);
            insert recentQuotes2;
        
        List<Quote_Sub_Item_Level__c > recentQuotes3 = new List<Quote_Sub_Item_Level__c >();
        Quote_Sub_Item_Level__c QSL1 =new Quote_Sub_Item_Level__c();
            QSL1.Quote_Header__c=QH1.id;
            QSL1.Quantity__c=2;
          QSL1.Actual_Amount__c=25.00;
            QSL1.ADJ_COND_TYPE__c='ZTOT';
            recentQuotes3.add(QSL1);
        Quote_Sub_Item_Level__c QSL2 =new Quote_Sub_Item_Level__c();
            QSL2.Quote_Header__c=QH1.id;
            QSL2.Quantity__c=0;
          QSL2.Actual_Amount__c=0.00;
            QSL2.ADJ_COND_TYPE__c='ZTOT';
            recentQuotes3.add(QSL2);
            insert recentQuotes3;
        
        
        CPQActiveURL__c cpq=new CPQActiveURL__c();
            //cpq.URL_Active__c=true; 
            cpq.Name='DevURL';
            cpq.CPQ_URL__c='http://cpq-devapp/CPQ';
            cpq.Environment__c = URL.getSalesforceBaseUrl().getHost(); 
            cpq.Portal_URL__c = 'http://cpq-devweb.mobilemini.com/CPQ';
            insert cpq;
            
        Test.startTest();
        List<Service_Order_Request__c> sorlist = new List<Service_Order_Request__c>();
        Service_Order_Request__c sor1=new Service_Order_Request__c();
        sor1.Account_Name__c=acc.id;
        sor1.Status__c='Submitted';
        sor1.RecordtypeId = [select Id from RecordType where sObjectType = 'Service_Order_Request__c' and name = 'Service Order Request - (MMI UK) 1200'].id;
            //sor1.recordtypeid =  [select id,name from RecordType where name = 'Service Order Request (ETS) 1500'].id;
          //sor1.recordtypename='Service Order Request (ETS) 1500';
            sorlist.add(sor1);
        Service_Order_Request__c sor2=new Service_Order_Request__c();
        sor2.Account_Name__c=acc.id;
        sor2.Status__c='Submitted';
        sor2.RecordtypeId = [select Id from RecordType where sObjectType = 'Service_Order_Request__c' and name = 'Credits (MMI) 1000'].id;
            //sor2.recordtypeid =  [select id,name from RecordType where name = 'Service Order Request (ETS) 1500'].id;
          //sor2.recordtypename='Service Order Request (ETS) 1500';
            sorlist.add(sor2);
            insert sorlist;
            
            date dt=date.today();
            string CON_ST_DAT=String.valueOf(dt);
            string CON_EN_DAT=String.valueOf(dt);
           
       
        ApexPages.currentPage().getParameters().put('Id',acc.id);
        AccountDashboardCntrl controller = new AccountDashboardCntrl(new ApexPages.StandardController(acc));
        controller.salesOrgID ='1200'; 
        controller.Createopportunity();
        
        controller.salesOrgID ='1000'; 
        controller.Createopportunity();
        
        controller.salesOrgID ='1300'; 
        controller.Createopportunity();
        
        controller.click();
        List<AccountDashboardCntrl.WrapperContractItems> contractItemsList = new List<AccountDashboardCntrl.WrapperContractItems>();
        AccountDashboardCntrl.FinancialSummaryWrapper fsw =new AccountDashboardCntrl.FinancialSummaryWrapper('t','t','t','t','t','t','t','t',CON_ST_DAT,'t','t',CON_ST_DAT,'t','t','t','t','t','t');
        AccountDashboardCntrl.WrapperContractItems conti = new AccountDashboardCntrl.WrapperContractItems('1234567890','1234567890', 'Pending', 'material', 'short_text', '1234567890','plant','1234567890', CON_ST_DAT,CON_ST_DAT,'UK',CON_ST_DAT,'fulDepot','billingPlanRel');
         contractItemsList.add(conti);
        AccountDashboardCntrl.Wrapperforcontracts cont = new AccountDashboardCntrl.Wrapperforcontracts('1234567890', '1234567890', 'street', 'city', 'region','postl_code',contractItemsList,null,'plant','Material',CON_ST_DAT,CON_ST_DAT,'UK',CON_ST_DAT,'X');
        doFinCallOut();
        doCallOut(); 
        Test.stopTest();  
    }
    
   
    
    //@future(callout=true)
  private static void doFinCallOut( ){
        Test.setMock(WebServiceMock.class, new WebServiceFinMockImpl());
        //sapComDocumentSapRfcFunctionsFin.ZFIF_FINANCIAL_SUMMARY_Response_element finSum = DataForcontracts.fetchFinancialSummaryFromCPQResponse('800015','1000');
        AccountDashboardCntrl.FinancialSummaryWrapper finSum = AccountDashboardCntrl.getFinSumData('800015','1000'); 
    }
    
    // @future(callout=true)
   private static void doCallOut( ){
        date dt=date.today();
        date stdt = dt.addMonths(-12);
        string CON_ST_DAT=String.valueOf(dt);
        string CON_EN_DAT=String.valueOf(stdt);
        Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
        //sapComDocumentSapRfcFunctions.ZSD_CONTRACT_SEARCH_Response_element contractsList= DataForcontracts.fetchContractsFromResponse('800015','100',CON_ST_DAT,CON_ST_DAT,'','','');
       List<AccountDashboardCntrl.Wrapperforcontracts> contractsList = AccountDashboardCntrl.getContracts('800015','Business Account - UK','100',CON_ST_DAT,CON_EN_DAT,'','',''); 
    }
    
    
}