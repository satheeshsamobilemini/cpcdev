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
public class TestCloneQuoteCPCRedirect{
    static testmethod void CloneQuoteCPCRedirect() {
        
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
        con.FirstName = 'Test';
        con.Email = 'abc@abc.com';
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
        
        CPQActiveURL__c cpq=new CPQActiveURL__c();
        cpq.Name='DevURL';
        cpq.CPQ_URL__c='http://cpq-devapp/CPQ';
        cpq.Environment__c = URL.getSalesforceBaseUrl().getHost(); 
        cpq.Portal_URL__c = 'http://cpq-devweb.mobilemini.com/CPQ';
        insert cpq;
    
        ApexPages.currentPage().getParameters().put('caname',acc.name);
        ApexPages.currentPage().getParameters().put('caid',acc.id);
        ApexPages.currentPage().getParameters().put('casorg','1000');
        ApexPages.currentPage().getParameters().put('quoteid',QH1.id);
    
        CloneQuoteCPCRedirect cpcRedirect = new CloneQuoteCPCRedirect();
        cpcRedirect.createOpportunity();
        
            
        
        CloneQuoteCPCRedirect cpcRedirect1 = new CloneQuoteCPCRedirect();
        
        cpcRedirect1.casorg = '1200';
        cpcRedirect1.createOpportunity();
        
        cpcRedirect1.casorg = '1000';
        cpcRedirect1.createOpportunity();
    }
    
}