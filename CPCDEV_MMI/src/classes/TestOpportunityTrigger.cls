@isTest
Class TestOpportunityTrigger{

    static testmethod void testOppTrigger(){
        
        Account acc = new Account();
        acc.name='test account';
        acc.recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Business Account').getRecordTypeId();
        acc.BillingState = 'AZ';
        acc.BillingCountry = 'US';
        insert acc;
        
        Contact con = new Contact(LastName='Test');
        con.FirstName = 'Test';
        con.Email = 'abc@abc.com';
        con.AccountId = acc.id;
        insert con;
        
        Test.startTest();
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
            opp.Quote_Status_Changed__c = true;
            //opp.recordtypeid =  [select id,name from RecordType where name = 'Standard Opportunity'].ID;
            opp.recordtypeid = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity').getRecordTypeId();
            insert opp;
            
            Quote_Header__c QH1=new Quote_Header__c();
            QH1.status__C='Open';
            QH1.Opportunity__c = opp.id;
            QH1.SalesRep_Email__c = 'testuser@salesrep.com';
            QH1.Account__c=acc.id;
            QH1.Start_Date__c=Date.Today();
            QH1.Delivery_Date__c=Date.Today();
            QH1.Delivery_City__c = 'Test City';
            QH1.contact__c = con.id;
            QH1.type__c = 'ZREN';
            insert QH1;
            
            Quote_Header__c QH2=new Quote_Header__c();
            QH2.status__C='Lost';
            QH2.Opportunity__c = opp.id;
            QH2.SalesRep_Email__c = 'testuser@salesrep.com';
            QH2.Account__c=acc.id;
            QH2.Start_Date__c=Date.Today();
            QH2.Delivery_Date__c=Date.Today();
            QH2.Delivery_City__c = 'Test City';
            QH2.contact__c = con.id;
            QH2.type__c = 'ZSLS';
            insert QH2;
            
            
            List<Quote_Item_Level__c > recentQuotes = new List<Quote_Item_Level__c >();
            Quote_Item_Level__c QL1 =new Quote_Item_Level__c();
            QL1.Quote_Header__c=QH1.id;
            QL1.Item_Code__c='TESTCODE';
            QL1.Quantity__c=2;
            QL1.Quote_Item_Higher_Level__c='000000';
            QL1.Actual_Amount__c=25.00;
            QL1.Description__c = 'Delivery';
            QL1.Contract_Number__c = '10000026401000002640100000264010000026401000002640';
            recentQuotes.add(QL1);            
           
            Quote_Item_Level__c QL2 =new Quote_Item_Level__c();
            QL2.Quote_Header__c=QH2.id;
            QL2.Item_Code__c='TESTCODE';
            QL2.Quantity__c=2;
            QL2.Quote_Item_Higher_Level__c='000000';
            QL2.Actual_Amount__c=25.00;
            QL2.Contract_Number__c = '10000016401000002640100000264010000026401000002640';
            QL2.Description__c = 'Delivery';
            recentQuotes.add(QL2);
            
            insert recentQuotes;
            
            List<Quote_Sub_Item_Level__c > recentQuotes3 = new List<Quote_Sub_Item_Level__c >();
            Quote_Sub_Item_Level__c QSL1 =new Quote_Sub_Item_Level__c();
            QSL1.Quote_Header__c=QH1.id;
            QSL1.Quantity__c=2;
            QSL1.Actual_Amount__c=25.00;
            QSL1.ADJ_COND_TYPE__c='ZTOT';
            QSL1.Recurring__c = 'X';
            QSL1.Quote_Item_level_ID__c=recentQuotes[0].id;
            recentQuotes3.add(QSL1);
            
         
            Quote_Sub_Item_Level__c QSL2 =new Quote_Sub_Item_Level__c();
            QSL2.Quote_Header__c=QH2.id;
            QSL2.Quantity__c=2;
            QSL2.Actual_Amount__c=25.00;
            QSL2.ADJ_COND_TYPE__c='ZTOT';
            QSL2.Quote_Item_level_ID__c=recentQuotes[1].id;
            recentQuotes3.add(QSL2);
            insert  recentQuotes3;
        Test.stopTest();
            
            Task tk = new Task();
            tk.subject = 'Test';
            tk.whatid = opp.id;
            insert tk;
            
            opp.Billing_Zip_Postal_Code__c = '85225';
            update opp;
    }
}