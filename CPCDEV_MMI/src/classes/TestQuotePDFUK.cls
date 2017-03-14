/**
* (c) 2015 TEKsystems Global Services
*
* Name           : TestQuotePDFUK
* Created Date   : 18 May, 2016 
* Created By     : Ankur Goyal(TEKGlobal)
* Purpose        : Test class for QuotePDFctrl class.
* 
**/


@isTest
public class TestQuotePDFUK{
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
            QH.Opportunity_Close_Date__c = date.today();
            //QH.Actual_Createdby__c = con.ID;
            insert QH;
         
         List<Quote_Item_Level__c > recentQuotes2 = new List<Quote_Item_Level__c >();
         Quote_Item_Level__c QL1 =new Quote_Item_Level__c();
            QL1.Quote_Header__c=QH.id;
            QL1.Item_Code__c='TESTCODE';
            QL1.Quantity__c=2;
            QL1.Quote_Item_Higher_Level__c='000000';
            QL1.Quote_Item_Number__c = '000010';
            QL1.Actual_Amount__c=25.00;
            QL1.Accessory__c = 'X';
            recentQuotes2.add(QL1);
         Quote_Item_Level__c QL2 =new Quote_Item_Level__c();
            QL2.Quote_Header__c=QH.id;
            QL2.Item_Code__c='TESTCODE2';
            QL2.Quantity__c=1;
            QL2.Quote_Item_Higher_Level__c='000010';
            QL2.Quote_Item_Number__c = '000020';
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
         Quote_Sub_Item_Level__c QSL3 =new Quote_Sub_Item_Level__c();
            QSL3.Quote_Header__c=QH.id;
            QSL3.Quantity__c=2;
            QSL3.Actual_Amount__c=25.00;
            QSL3.Entered_Amount__c=25.00;
            QSL3.ADJ_COND_TYPE__c='ZP00';
            QSL3.Quote_Item_level_ID__c=QL1.id;
            recentQuotes3.add(QSL3); 
         Quote_Sub_Item_Level__c QSL4 =new Quote_Sub_Item_Level__c();
            QSL4.Quote_Header__c=QH.id;
            QSL4.Quantity__c=2;
            QSL4.Actual_Amount__c=25.00;
            QSL4.Entered_Amount__c=25.00;
            QSL4.ADJ_COND_TYPE__c='TOT2';
            QSL4.Quote_Item_level_ID__c=QL1.id;
            recentQuotes3.add(QSL4);
         Quote_Sub_Item_Level__c QSL5 =new Quote_Sub_Item_Level__c();
            QSL5.Quote_Header__c=QH.id;
            QSL5.Quantity__c=2;
            QSL5.Actual_Amount__c=25.00;
            QSL5.Entered_Amount__c=25.00;
            QSL5.ADJ_COND_TYPE__c='TOT6';
            QSL5.Quote_Item_level_ID__c=QL1.id;
            recentQuotes3.add(QSL5);     
         Quote_Sub_Item_Level__c QSL2 =new Quote_Sub_Item_Level__c();
            QSL2.Quote_Header__c=QH.id;
            QSL2.Quantity__c=0;
            QSL2.Actual_Amount__c=50.00;
            QSL2.Entered_Amount__c=25.00;
            QSL2.ADJ_COND_TYPE__c='ZLLW';
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
           
          ApexPages.currentPage().getParameters().put('id',QH.id);
          ApexPages.currentPage().getParameters().put('type','sales');
          ApexPages.currentPage().getParameters().put('salorg','1200');
          
          QuotePDFctrl QuotePDFUK  = new  QuotePDFctrl();
          QuotePDFUK.getPDFContent();
          
          ApexPages.currentPage().getParameters().put('type','rental');
          ApexPages.currentPage().getParameters().put('salorg','1200');
          QuotePDFctrl QuotePDFUS2  = new  QuotePDFctrl();
          QuotePDFUS2.getPDFContent();
    }
}