/**
* (c) 2015 TEKsystems Global Services
*
* Name           : TestOrphanOpportunityPurge
* Created Date   : 14 Apr,2016
* Created By     : Ankur G (TEK)
* Purpose        : Test class to test the Batch class to delete the opportunities which are not associated with any quote header record.
* 
**/
@isTest
public class TestOrphanOpportunityPurge {
    static testMethod void OpportunityPurge(){
        
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
        opp.Opportunity_Contact_Name_LookUpFilter__c = con.id;
        opp.Account = acc;
        opp.Billing_Zip_Postal_Code__c = '85226';
        opp.Delivery_Zip_Postal_Code__c = '85226';
        opp.Why_do_you_need_storage_Picklist__c = 'Retail';
        opp.How_long_will_you_need_your_unit_UK__c = 2;
        opp.From_New_Quote__c = true;
        //opp.recordtypeid =  [select id,name from RecordType where name = 'Standard Opportunity - UK'].ID;
        opp.recordtypeid =Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity - UK').getRecordTypeId();
        listOppty.add(opp); 
        
        Opportunity opp1 = new Opportunity(name='Test Opp');
        opp1.CloseDate = date.today();
        opp1.StageName = 'Not Quoted';
        opp1.Opportunity_Rating__c = 'Warm (Possibly Order)';
        opp1.Opportunity_Contact_Name_LookUpFilter__c = con.id;
        opp1.Account = acc;
        opp1.Billing_Zip_Postal_Code__c = '85226';
        opp1.Delivery_Zip_Postal_Code__c = '85226';
        opp1.Why_do_you_need_storage_Picklist__c = 'Retail';
        opp1.How_long_will_you_need_your_unit_UK__c = 2;
        opp1.From_New_Quote__c = true;
        //opp1.recordtypeid =  [select id,name from RecordType where name = 'Standard Opportunity'].ID;
        opp1.recordtypeid = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity').getRecordTypeId();
        listOppty.add(opp1); 
        
        
        Opportunity opp2 = new Opportunity(name='Test Opp');
        opp2.CloseDate = date.today();
        opp2.StageName = 'Not Quoted';
        opp2.Opportunity_Rating__c = 'Warm (Possibly Order)';
        opp2.Opportunity_Contact_Name_LookUpFilter__c = con.id;
        opp2.Account = acc;
        opp2.Billing_Zip_Postal_Code__c = '85226';
        opp2.Delivery_Zip_Postal_Code__c = '85226';
        opp2.Why_do_you_need_storage_Picklist__c = 'Retail';
        opp2.How_long_will_you_need_your_unit_UK__c = 2;
        opp2.From_New_Quote__c = true;        
        //opp2.recordtypeid =  [select id,name from RecordType where name = 'Standard Opportunity'].ID;
        opp2.recordtypeid =Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity').getRecordTypeId();
        
        listOppty.add(opp2);
            insert listOppty;
        
        Quote_Header__c QH=new Quote_Header__c();
        QH.status__C='Open';
        QH.Account__C=acc.id;
        QH.Contact__c=con.id;
        QH.Distance_from_Branch__c = 10.34;
        QH.Docusign_Status__c = 'Completed';
        QH.Status__c = 'Won';
        QH.Opportunity__c = listOppty[0].id;
        QH.Start_Date__c=Date.Today();
        QH.Delivery_Date__c=date.newinstance(2016, 4, 17);
        QH.How_long_do_you_need_your_unit_weeks__c=date.newinstance(2016, 8, 17);
        QH.Delivery_City__c = 'Test City';
        QH.Branch__c='101';
        QH.Billing_Zip__c='85022';
        
        insert QH;
        
        Test.startTest();

            String sch = '0 0 23 * * ?';
            OrphanOpportunityPurgeSchedule oppPurge = new OrphanOpportunityPurgeSchedule();
            system.schedule('OrphanOpportunityPurgeSchedule', sch, oppPurge);             
                        
        Test.stopTest();
        
    }
}