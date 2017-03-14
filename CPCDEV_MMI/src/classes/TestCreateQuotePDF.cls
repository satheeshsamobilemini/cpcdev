/**
* (c) 2016 TEKsystems Global Services
*
* Name           : TestCreateQuotePDF 
* Created Date   : 31 Mar, 2016
* Created By     : Ankur (TEKSystems) 
* Purpose        : Test class for CreateQuotePDF class.
* 
**/
@isTest
public class TestCreateQuotePDF {
    static testMethod void Test1()
    {
       
        String testResult;
        String quoteID;
        String salesOrgID;
        String type;
        
        Account acc = new Account();
            acc.name='test account';
            //acc.recordtypeid =  [select id,name from RecordType where name = 'Business Account'].ID;
            acc.recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Business Account').getRecordTypeId();
            insert acc;
        
        Contact con = new Contact(LastName='Test');
        con.FirstName = 'Test';
        con.Email = 'agoyal@Teksystems.com';
        con.AccountId = acc.id;
        insert con;
        
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
        //opp.recordtypeid =  [select id,name from RecordType where name = 'Standard Opportunity'].ID;
        opp.recordtypeid = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity').getRecordTypeId();
        insert opp;
        
      
            
        List<Quote_Header__c> recentQuotes = new List<Quote_Header__c>();
        Quote_Header__c QH1=new Quote_Header__c();
            QH1.status__C='Open';
            QH1.Opportunity__c = opp.id;
            QH1.SalesRep_Email__c = 'testuser@salesrep.com';
            QH1.Account__c=acc.id;
            QH1.Start_Date__c=Date.Today();
            QH1.Delivery_Date__c=Date.Today();
            QH1.Delivery_City__c = 'Test City';
            QH1.contact__c = con.id;
            QH1.Sales_Organization__c = '1500';
            QH1.type__c = 'ZREN';
            recentQuotes.add(QH1);
        insert recentQuotes;
        
        List<Quote_Item_Level__c > recentQuotes2 = new List<Quote_Item_Level__c >();
        Quote_Item_Level__c QL1 =new Quote_Item_Level__c();
            QL1.Quote_Header__c=QH1.id;
            QL1.Item_Code__c='TESTCODE';
            QL1.Actual_Amount__c=25.00;
            QL1.Description__c = 'DELIVERY';
            recentQuotes2.add(QL1);
       
          //  insert recentQuotes2;
       
        quoteID = QH1.id;
        salesOrgID = QH1.Sales_Organization__c;
        type = QH1.type__c;
        testResult = CreateQuotePDF.createAndAttachPDF(quoteID,salesOrgID,type);
        testResult = CreateQuotePDF.createAndAttachPDF(quoteID,salesOrgID,type);
        
        Quote_Header__c QH2=new Quote_Header__c();
            QH2.status__C='Open';
            QH2.Opportunity__c = opp.id;
            QH2.SalesRep_Email__c = 'testuser@salesrep.com';
            QH2.Account__c=acc.id;
            QH2.Start_Date__c=Date.Today();
            QH2.Delivery_Date__c=Date.Today();
            QH2.Delivery_City__c = 'Test City';
            QH2.contact__c = con.id;
            QH2.Sales_Organization__c = '1000';
            QH2.type__c = 'ZSLS';
            //recentQuotes.add(QH1);
        insert QH2;
        
        Quote_Item_Level__c QL2 =new Quote_Item_Level__c();
            QL2.Quote_Header__c=QH1.id;
            QL2.Item_Code__c='TESTCODE';
            QL2.Actual_Amount__c=25.00;
            QL2.Description__c = 'DELIVERY';
            //recentQuotes2.add(QL1);
       
           // insert QL2;
       
        quoteID = QH2.id;
        salesOrgID = QH2.Sales_Organization__c;
        type = QH2.type__c;
        testResult = CreateQuotePDF.createAndAttachPDF(quoteID,salesOrgID,type);
        testResult = CreateQuotePDF.createAndAttachPDF(quoteID,salesOrgID,type);
        
        Quote_Header__c QH3=new Quote_Header__c();
            QH3.status__C='Open';
            QH3.Opportunity__c = opp.id;
            QH3.SalesRep_Email__c = 'testuser@salesrep.com';
            QH3.Account__c=acc.id;
            QH3.Start_Date__c=Date.Today();
            QH3.Delivery_Date__c=Date.Today();
            QH3.Delivery_City__c = 'Test City';
            QH3.contact__c = con.id;
            QH3.Sales_Organization__c = '1200';
            QH3.type__c = 'ZSLS';
            //recentQuotes.add(QH1);
        insert QH3;
        
        Quote_Item_Level__c QL3 =new Quote_Item_Level__c();
            QL3.Quote_Header__c=QH1.id;
            QL3.Item_Code__c='TESTCODE';
            QL3.Actual_Amount__c=25.00;
            QL3.Description__c = 'DELIVERY';
            //recentQuotes2.add(QL1);
       
           // insert QL3;
       
        quoteID = QH3.id;
        salesOrgID = QH3.Sales_Organization__c;
        type = QH3.type__c;
        testResult = CreateQuotePDF.createAndAttachPDF(quoteID,salesOrgID,type);
        testResult = CreateQuotePDF.createAndAttachPDF(quoteID,salesOrgID,type);
        
     }
    
}