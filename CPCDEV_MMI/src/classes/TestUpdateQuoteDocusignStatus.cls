/**
 * (c) 2015 TEKsystems Global Services
 *
 * Name           : TestUpdateQuoteDocusignStatus
 * Created Date   : 15 July 2016
 * Created By     : Ankur Goyal (TEKSystems)
 * Purpose        : Test class to test the trigger "updateQuoteDocusignStatus "
 * Last Updated By: Ankur Goyal (TEKSystems)
 * Last Updated Date: 18-Jul-2016
 **/


@isTest
Public class TestUpdateQuoteDocusignStatus{
    
    static testmethod void testDocusignStatusUpdate(){
    
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
        
        
        Opportunity opp = new Opportunity(name='Test Opp');
        opp.CloseDate = date.today();
        opp.StageName = 'Not Quoted';
        opp.Opportunity_Rating__c = 'Warm (Possibly Order)';
        opp.Opportunity_Contact_Name_LookUpFilter__c = con.id;
        opp.AccountId = acc.Id;
        opp.Billing_Zip_Postal_Code__c = '85226';
        opp.Delivery_Zip_Postal_Code__c = '85226';
        opp.Why_do_you_need_storage_Picklist__c = 'Retail';
        opp.How_long_will_you_need_your_unit_UK__c = 2;
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
        //insert QH1;
        
        dsfs__DocuSign_Status__c dsp = new dsfs__DocuSign_Status__c();
        dsp.Quote_Header__c = QH1.ID;
        insert dsp;
        
        dsfs__DocuSign_Recipient_Status__c dsr = new dsfs__DocuSign_Recipient_Status__c ();
        dsr.dsfs__Parent_Status_Record__c = dsp.id;
        dsr.dsfs__DocuSign_Recipient_Id__c = '11F85E9E-9603-439C-BE21-AECC6219C50B';
        dsr.Name = 'Ankur Goyal';
        dsr.dsfs__DocuSign_Recipient_Email__c = 'xyz@gmail.com';
        insert dsr;
        
        dsfs__DocuSign_Recipient_Status__c dsr1 = new dsfs__DocuSign_Recipient_Status__c ();
        dsr1.id = dsr.id;
        dsr1.dsfs__Recipient_Status__c = 'Completed';
        update dsr1;
        
        dsfs__DocuSign_Recipient_Status__c dsr2 = new dsfs__DocuSign_Recipient_Status__c ();
        dsr2.id = dsr.id;
        //dsr2.dsfs__Recipient_Status__c = 'Declined';
        update dsr2;
        
    }

}