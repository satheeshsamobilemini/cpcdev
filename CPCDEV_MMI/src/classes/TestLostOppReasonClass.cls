/**
* (c) 2015 TEKsystems Global Services
*
* Name           : TestLostOppReasonClass
* Created Date   : 15 Dec, 2015 
* Created By     : Jailabdin shaik
* Purpose        : Test class for LostOppReasonClass class.
* 
**/

@isTest
public class TestLostOppReasonClass{
    static testmethod void LstOpReasClas() {
       // List<User> u = createUsers(1);
        account acc =new account(name='test');
        acc.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Competitor').getRecordTypeId();  
        acc.BillingState = 'AZ';
        acc.BillingCountry = 'US';
        insert acc;
        
        account acc1 =new account(name='test');
        acc1.recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Business Account - UK').getRecordTypeId();
        acc1.BillingState = 'AZ';
        acc1.BillingCountry = 'US';
        insert acc1;
        
        //account acc2=[select id,name from account  limit 1];
        //account acc2 =new account(name='test2');
        //insert acc2;
        
        Opportunity opp = new Opportunity();
        opp.name='testopp';
        opp.StageName='Quoted - Lost Business';
        opp.CloseDate=date.today();
        opp.Account= acc;
        opp.Lost_Business_To__c=acc.id;
        opp.Lost_Opportunity_Reason_New__c='Delivery - Could Not Meet Timing';
        insert opp;
        
        Quote_Header__c qh = new Quote_Header__c();
        qh.Account__c=acc1.id;
        qh.Opportunity__c = opp.id;
        qh.Start_Date__c = date.today();
        qh.How_long_do_you_need_your_unit_weeks__c= date.today().addDays(20);
       // qh.OwnerId = u[0].id;
        insert qh;
         ApexPages.currentPage().getParameters().put('id',opp.id);
        ApexPages.currentPage().getParameters().put('quoteid',qh.id);
        
        LostOppReasonClass controller = new LostOppReasonClass(new ApexPages.StandardController(opp));
        controller.Save();
    }
    
      
}