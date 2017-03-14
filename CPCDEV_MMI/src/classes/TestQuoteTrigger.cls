/**
* (c) 2016 TEKsystems Global Services
*
* Name           : TestQuoteTrigger
* Created Date   : 22 March, 2016
* Created By     : Sreenivas M ,Harthi Sundaramurthy
* Purpose        : Test class for all Quote header, Quote Item Level and Quote SubItem Level.
* 
**/
@isTest
public class TestQuoteTrigger {
    static testmethod void testQuote() {
         
        Account acc = new Account();
        acc.name='test account';
        acc.BillingState = 'AZ';
        acc.BillingCountry = 'US';
        insert acc;
        
        Contact con = new Contact(LastName='Test');
        insert con;
        
        List<Opportunity> listOppty = new List<Opportunity>();
        Opportunity opp = new Opportunity(name='Test Opp');
        opp.CloseDate = date.today();
        opp.StageName = 'Not Quoted';
        opp.Opportunity_Rating__c = 'Warm (Possibly Order)';
        //opp.Opportunity_Contact_Name_LookUpFilter__c = con.id;
        opp.Account = acc;
        opp.Billing_Zip_Postal_Code__c = '85226';
        opp.Delivery_Zip_Postal_Code__c = '85226';
        opp.Why_do_you_need_storage_Picklist__c = 'Retail';
        opp.How_long_will_you_need_your_unit_UK__c = 2;
        //opp.recordtypeid =  [select id,name from RecordType where name = 'Standard Opportunity - UK'].ID;
        opp.recordtypeid =Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity - UK').getRecordTypeId();
        opp.Quote_Status_Changed__c = true; 
        listOppty.add(opp); 
        
        Opportunity opp1 = new Opportunity(name='Test Opp');
        opp1.CloseDate = date.today();
        opp1.StageName = 'Not Quoted';
        opp1.Opportunity_Rating__c = 'Warm (Possibly Order)';
        //opp1.Opportunity_Contact_Name_LookUpFilter__c = con.id;
        opp1.Account = acc;
        opp1.Billing_Zip_Postal_Code__c = '85226';
        opp1.Delivery_Zip_Postal_Code__c = '85226';
        opp1.Why_do_you_need_storage_Picklist__c = 'Retail';
        opp1.How_long_will_you_need_your_unit_UK__c = 2;
        //opp1.recordtypeid =  [select id,name from RecordType where name = 'Standard Opportunity'].ID;
        opp1.recordtypeid = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity').getRecordTypeId();
        opp1.Quote_Status_Changed__c = true;
        listOppty.add(opp1); 
        
        
        Opportunity opp2 = new Opportunity(name='Test Opp');
        opp2.CloseDate = date.today();
        opp2.StageName = 'Not Quoted';
        opp2.Opportunity_Rating__c = 'Warm (Possibly Order)';
        //opp2.Opportunity_Contact_Name_LookUpFilter__c = con.id;
        opp2.Account = acc;
        opp2.Billing_Zip_Postal_Code__c = '85226';
        opp2.Delivery_Zip_Postal_Code__c = '85226';
        opp2.Why_do_you_need_storage_Picklist__c = 'Retail';
        opp2.How_long_will_you_need_your_unit_UK__c = 2;
        //opp2.recordtypeid =  [select id,name from RecordType where name = 'Standard Opportunity'].ID;
        opp2.recordtypeid =Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity').getRecordTypeId();
        
        listOppty.add(opp2);
        
        Opportunity opp3 = new Opportunity(name='Test Opp');
        opp3.CloseDate = date.today();
        opp3.StageName = 'Not Quoted';
        opp3.Opportunity_Rating__c = 'Warm (Possibly Order)';
        //opp3.Opportunity_Contact_Name_LookUpFilter__c = con.id;
        opp3.Account = acc;
        opp3.Billing_Zip_Postal_Code__c = '85226';
        opp3.Delivery_Zip_Postal_Code__c = '85226';
        opp3.Why_do_you_need_storage_Picklist__c = 'Retail';
        opp3.How_long_will_you_need_your_unit_UK__c = 2;
        //opp2.recordtypeid =  [select id,name from RecordType where name = 'Standard Opportunity'].ID;
        opp3.recordtypeid =Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity').getRecordTypeId();
        
        listOppty.add(opp3);
        
        insert listOppty;
        
        Test.startTest();
            List<Quote_Header__c> listQH = new List<Quote_Header__c>();
            Quote_Header__c QH=new Quote_Header__c();
            QH.status__C='Open';
            QH.Account__C=acc.id;
            QH.Contact__c=con.id;
            QH.Distance_from_Branch__c = 10.34;
            QH.Docusign_Status__c = 'Completed';
            //QH.Status__c = 'Won';
            QH.Opportunity__c = listOppty[0].id;
            QH.Start_Date__c=Date.Today();
            QH.Delivery_Date__c=date.newinstance(2016, 4, 17);
            QH.How_long_do_you_need_your_unit_weeks__c=date.newinstance(2016, 8, 17);
            QH.Delivery_City__c = 'Test City';
            QH.Branch__c='101';
            QH.Billing_Zip__c='85022';
            QH.type__c = 'ZSLS';
            qh.Quote_Status_Changed__c = true;
            listQH.add(QH);
            
            
            Quote_Header__c QH1=new Quote_Header__c();
            QH1.status__C='Open';
            QH1.Account__C=acc.id;
            QH1.Contact__c=con.id;
            QH1.Distance_from_Branch__c = 10.34;
            QH1.Docusign_Status__c = 'Completed';
            //QH1.Status__c = 'Won';
            //QH1.Actual_Createdby__c='sjailabd@teksystems.com';
            QH1.Opportunity__c = listOppty[1].id;
            QH1.Start_Date__c=Date.Today();
            QH1.Delivery_Date__c=date.newinstance(2016, 4, 17);
            QH1.How_long_do_you_need_your_unit_weeks__c=date.newinstance(2016, 8, 17);
            QH1.Delivery_City__c = 'Test City';
            QH1.Branch__c='101';
            QH1.Billing_Zip__c='85022';
            QH1.Sales_Organization__c = '1200';
            QH1.type__c = 'ZREN';
            listQH.add(QH1);
            
            Quote_Header__c QH2=new Quote_Header__c();
            QH2.status__C='Open';
            QH2.Account__C=acc.id;
            QH2.Contact__c=con.id;
            QH2.Distance_from_Branch__c = 10.34;
            QH2.Docusign_Status__c = 'Completed';
            //QH2.Status__c = 'Won';
            //QH2.Actual_Createdby__c='sjailabd@teksystems.com';
            QH2.Opportunity__c = listOppty[2].id;
            QH2.Start_Date__c=Date.Today();
            QH2.Delivery_Date__c=date.newinstance(2016, 4, 17);
            QH2.How_long_do_you_need_your_unit_weeks__c=date.newinstance(2016, 8, 17);
            QH2.Delivery_City__c = 'Test City';
            QH2.Branch__c='101';
            QH2.Billing_Zip__c='85022';
            QH2.Sales_Organization__c = '1000';
            QH2.type__c = 'ZREN';
            listQH.add(QH2);
                 
            Quote_Header__c QH3=new Quote_Header__c();
            QH3.status__C='Open';
            QH3.Account__C=acc.id;
            QH3.Contact__c=con.id;
            QH3.Distance_from_Branch__c = 10.34;
            QH3.Docusign_Status__c = 'Completed';
            //QH3.Status__c = 'Won';
            //QH3.Actual_Createdby__c='sjailabd@teksystems.com';
            QH3.Opportunity__c = listOppty[3].id;
            QH3.Start_Date__c=Date.Today();
            QH3.Delivery_Date__c=date.newinstance(2016, 4, 17);
            QH3.How_long_do_you_need_your_unit_weeks__c=date.newinstance(2016, 8, 17);
            QH3.Delivery_City__c = 'Test City';
            QH3.Branch__c='101';
            QH3.Billing_Zip__c='85022';
            QH3.Sales_Organization__c = '1200';
            QH3.type__c = 'ZREN';
            listQH.add(QH3);
            insert listQH;
            
            
            listQH[2].Distance_from_Branch__c = 10.78;
            update  listQH[2]; 
            
            String sampleContractNunber ='';
            for(Integer i =0;i<17;i++)
               sampleContractNunber+='101010101010101010101010101010101010101010101010101010101010';
            
            List<Quote_Item_Level__c > recentQuotes = new List<Quote_Item_Level__c >();
            Quote_Item_Level__c QL1 =new Quote_Item_Level__c();
            QL1.Quote_Header__c=listQH[0].id;
            QL1.Item_Code__c='TESTCODE';
            QL1.Quantity__c=2;
            QL1.Quote_Item_Higher_Level__c='000000';
            QL1.Actual_Amount__c=25.00;
            QL1.Description__c = 'Delivery';
            QL1.Contract_Number__c = '1000002640'+sampleContractNunber.substring(0,1010);
            recentQuotes.add(QL1);            
           
            Quote_Item_Level__c QL2 =new Quote_Item_Level__c();
            QL2.Quote_Header__c=listQH[1].id;
            QL2.Item_Code__c='TESTCODE';
            QL2.Quantity__c=2;
            QL2.Quote_Item_Higher_Level__c='000000';
            QL2.Actual_Amount__c=25.00;
            QL2.Contract_Number__c = '1000001640'+sampleContractNunber.substring(0,800);
            QL2.Description__c = 'Delivery';
            recentQuotes.add(QL2);
            
            Quote_Item_Level__c QL3 =new Quote_Item_Level__c();
            QL3.Quote_Header__c=listQH[2].id;
            QL3.Item_Code__c='TESTCODE';
            QL3.Quantity__c=1;
            QL3.Quote_Item_Higher_Level__c='000010';
            QL3.Actual_Amount__c=25.00;
            QL3.Contract_Number__c = '1000000640'+sampleContractNunber.substring(0,510);
            QL3.Description__c = 'Delivery';
            recentQuotes.add(QL3);
           
            
            Quote_Item_Level__c QL4 =new Quote_Item_Level__c();
            QL4.Quote_Header__c=listQH[3].id;
            QL4.Item_Code__c='TESTCODE';
            QL4.Quantity__c=1;
            QL4.Quote_Item_Higher_Level__c='000020';
            QL4.Contract_Number__c = '1000000040'+sampleContractNunber.substring(0,300);
            QL4.Actual_Amount__c=25.00;
            QL4.Description__c = 'Pickup';
            recentQuotes.add(QL4);
            
            insert recentQuotes;
           
            
            List<Quote_Sub_Item_Level__c > recentQuotes3 = new List<Quote_Sub_Item_Level__c >();
            Quote_Sub_Item_Level__c QSL1 =new Quote_Sub_Item_Level__c();
            QSL1.Quote_Header__c=listQH[0].id;
            QSL1.Quantity__c=2;
            QSL1.Actual_Amount__c=25.00;
            QSL1.ADJ_COND_TYPE__c='ZTOT';
            QSL1.Recurring__c = 'X';
            QSL1.Quote_Item_level_ID__c=recentQuotes[0].id;
            recentQuotes3.add(QSL1);
            
         
            Quote_Sub_Item_Level__c QSL2 =new Quote_Sub_Item_Level__c();
            QSL2.Quote_Header__c=listQH[3].id;
            QSL2.Quantity__c=2;
            QSL2.Actual_Amount__c=25.00;
            QSL2.ADJ_COND_TYPE__c='ZTOT';
            QSL2.Quote_Item_level_ID__c=recentQuotes[1].id;
            recentQuotes3.add(QSL2);    
            
            Quote_Sub_Item_Level__c QSL3 =new Quote_Sub_Item_Level__c();
            QSL3.Quote_Header__c=listQH[3].id;
            QSL3.Quantity__c=2;
            QSL3.Actual_Amount__c=25.00;
            QSL3.ADJ_COND_TYPE__c='TOT1';
            QSL3.Recurring__c = 'X';
            QSL3.Quote_Item_level_ID__c=recentQuotes[2].id;
            recentQuotes3.add(QSL3);
            
            insert recentQuotes3;
            update recentQuotes;
           // delete recentQuotes[2];
          Test.stopTest();
        
    
    }
}