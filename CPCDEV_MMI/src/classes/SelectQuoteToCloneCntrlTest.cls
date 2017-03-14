@isTest
public class SelectQuoteToCloneCntrlTest{

    private testmethod static void testCloneQuote(){
    
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
        opp.Account = acc;
        opp.Billing_Zip_Postal_Code__c = '85226';
        opp.Delivery_Zip_Postal_Code__c = '85226';
        opp.Why_do_you_need_storage_Picklist__c = 'Retail';
        opp.How_long_will_you_need_your_unit_UK__c = 2;
        opp.recordtypeid =Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity - UK').getRecordTypeId();
        insert opp;
        
        Quote_Header__c QH=new Quote_Header__c();
        QH.status__C='Open';
        QH.Account__C=acc.id;
        QH.Contact__c=con.id;
        QH.Distance_from_Branch__c = 10.34;
        QH.Docusign_Status__c = 'Completed';
        QH.Status__c = 'Won';
        QH.Opportunity__c = opp.id;
        QH.Start_Date__c=Date.Today();
        QH.Delivery_Date__c=date.newinstance(2016, 4, 17);
        QH.How_long_do_you_need_your_unit_weeks__c=date.newinstance(2016, 8, 17);
        QH.Delivery_City__c = 'Test City';
        QH.Branch__c='101';
        QH.Billing_Zip__c='85022';
        insert QH;
        
        SelectQuoteToCloneCntrl scq = new SelectQuoteToCloneCntrl();
        scq.quoteNum = '12345';
        scq.fetchQuoteDetails();
        
        scq.quoteNum = '1234567890';
        scq.fetchQuoteDetails();
    }

}