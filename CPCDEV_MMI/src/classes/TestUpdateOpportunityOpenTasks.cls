@isTest
Class TestUpdateOpportunityOpenTasks {
    
    static testmethod void unittest1(){
        
        Account acc = new Account();
        acc.name='test account';
        acc.recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Business Account').getRecordTypeId();
        acc.BillingState = 'AZ';
        acc.BillingCountry = 'US';
        insert acc;
        
        Lead ld  = new Lead();
        ld.LastName = 'test';
        insert ld;
        
        Contact con = new Contact(LastName='Test');
        con.FirstName = 'Test';
        con.Email = 'abc@abc.com';
        con.AccountId = acc.id;
        insert con;
        Test.startTest();
            List<Opportunity> oppinsertList = new  List<Opportunity>();
            Opportunity opp = new Opportunity(name='Test Opp');
            opp.CloseDate = date.today();
            opp.StageName = 'Not Quoted';
            opp.Lead_ID__c = ld.id;
            opp.Opportunity_Rating__c = 'Warm (Possibly Order)';
            opp.Opportunity_Contact_Name_LookUpFilter__c = con.id;
            opp.AccountId = acc.Id;
            opp.Billing_Zip_Postal_Code__c = '85226';
            opp.Delivery_Zip_Postal_Code__c = '85226';
            opp.Delivery_Country__c='USA';
            opp.Why_do_you_need_storage_Picklist__c = 'Retail';
            opp.How_long_will_you_need_your_unit_UK__c = 2;
            opp.notify_CreatedUser__c = true;
            
            opp.recordtypeid = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity').getRecordTypeId();
            oppinsertList.add(opp);
            insert oppinsertList;
            Task t1 = new Task(Status = 'In Progress',WhatId = opp.Id);
            insert t1; 
            RecursiveTriggerUtility.isUpdateOpportunityOpenTasks = false;
            update t1;
            RecursiveTriggerUtility.isUpdateOpportunityOpenTasks = false;
            delete t1;
        Test.stopTest();
    }
}