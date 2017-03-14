/**
* (c) 2015 TEKsystems Global Services
*
* Name           : TestQuotePDFUS
* Created Date   : 15 March, 2015 @ 20:00
* Created By     : Jailabdin Shaik(TEK)
* Purpose        : Test class for QuotePDF_US class.
* 
**/


@isTest
public class TestQuotePDFUS{
    static testmethod void TestQuotePDF() {
        
        Account acc = new Account();
        acc.name='test account';
        acc.BillingState = 'AZ';
        acc.BillingCountry = 'US';
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
        //opp.recordtypeid =  [select id,name from RecordType where name = 'Standard Opportunity - UK'].ID;
        opp.recordtypeid =  Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity - UK').getRecordTypeId();
        
        insert opp;    
        
        Quote_Header__c QH=new Quote_Header__c();
        QH.status__C='Open';
        QH.Account__C=acc.id;
        QH.Contact__c=con.id;
        //QH.Actual_Createdby__c='sjailabd@teksystems.com';
        QH.Opportunity__c = opp.id;
        QH.Start_Date__c=Date.Today();
        QH.Delivery_Date__c=date.newinstance(2016, 4, 17);
        QH.How_long_do_you_need_your_unit_weeks__c=date.newinstance(2016, 8, 17);
        QH.Delivery_City__c = 'Test City';
        QH.Branch__c='101';
        QH.Billing_Zip__c='85022';
        insert QH;
        
        List<Quote_Item_Level__c > recentQuotes2 = new List<Quote_Item_Level__c >();
        Quote_Item_Level__c QL1 =new Quote_Item_Level__c();
        QL1.Quote_Header__c=QH.id;
        QL1.Item_Code__c='TESTCODE';
        QL1.Quantity__c=2;
        QL1.Quote_Item_Higher_Level__c='000000';
        QL1.Actual_Amount__c=25.00;
        recentQuotes2.add(QL1);
        Quote_Item_Level__c QL2 =new Quote_Item_Level__c();
        QL2.Quote_Header__c=QH.id;
        QL2.Item_Code__c='TESTCODE2';
        QL2.Quantity__c=1;
        QL2.Quote_Item_Higher_Level__c='000010';
        QL2.Actual_Amount__c=25.00;
        recentQuotes2.add(QL2);
        insert recentQuotes2;
        
        List<Quote_Sub_Item_Level__c > recentQuotes3 = new List<Quote_Sub_Item_Level__c >();
        Quote_Sub_Item_Level__c QSL1 =new Quote_Sub_Item_Level__c();
        QSL1.Quote_Header__c=QH.id;
        QSL1.Quantity__c=2;
        QSL1.Actual_Amount__c=25.00;
        QSL1.Entered_Amount__c=25.00;
        QSL1.ADJ_COND_TYPE__c='ZTOT';
        QSL1.Quote_Item_level_ID__c=QL1.id;
        recentQuotes3.add(QSL1);
        Quote_Sub_Item_Level__c QSL2 =new Quote_Sub_Item_Level__c();
        QSL2.Quote_Header__c=QH.id;
        QSL2.Quantity__c=0;
        QSL2.Actual_Amount__c=50.00;
        QSL2.Entered_Amount__c=25.00;
        QSL2.ADJ_COND_TYPE__c='ZPMN';
        QSL2.Quote_Item_level_ID__c=QL1.id;
        recentQuotes3.add(QSL2);
        insert recentQuotes3;  
        
        Branch_Lookup__c Bl = new Branch_Lookup__c();
        Bl.Branch_Code__c= QH.Branch__c;
        Bl.Zip__c=QH.Billing_Zip__c;
        insert Bl;
        
        Weekly_Snapshot_Branch_Report__c WBNS= new Weekly_Snapshot_Branch_Report__c();
        WBNS.Servicing_Branch__c=QH.Branch__c;
        insert WBNS; 
        
        ApexPages.currentPage().getParameters().put('quoteid',QH.id);
        ApexPages.currentPage().getParameters().put('type','sales');
        ApexPages.currentPage().getParameters().put('salorg','1500');
        ApexPages.currentPage().getParameters().put('pdftype','normal');
        QuotePDF_US QuotePDFUS  = new  QuotePDF_US();
        QuotePDFUS.getPDFContent();
        
        ApexPages.currentPage().getParameters().put('type','rental');
        ApexPages.currentPage().getParameters().put('salorg','1000');
        ApexPages.currentPage().getParameters().put('accflag','testacc');
        ApexPages.currentPage().getParameters().put('lumpSum','testlump');
        ApexPages.currentPage().getParameters().put('pdftype','extended');
        QuotePDF_US QuotePDFUS2  = new  QuotePDF_US();
        QuotePDFUS2.getPDFContent();
        
         ApexPages.currentPage().getParameters().put('salorg','1000');
        ApexPages.currentPage().getParameters().put('pdftype','normal');
        QuotePDF_US QuotePDFUS3  = new  QuotePDF_US();
        QuotePDFUS3.getPDFContent();
    }
}