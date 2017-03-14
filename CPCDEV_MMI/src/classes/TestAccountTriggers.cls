@isTest
public class TestAccountTriggers{
    static testmethod void testAccountTriggers(){
        
        
                
        Test.startTest();
        
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
            
                    
            acc.recordtypeid =  [select id,name from RecordType where name = 'Business Account'].ID;
            acc.BillingCountry = 'CAN';
            update acc;
            
            acc.recordtypeid =  [select id,name from RecordType where name = 'Business Account'].ID;
            acc.BillingCountry = 'US';
            update acc;
            
            acc.recordtypeid =  [select id,name from RecordType where name = 'ETS/WMI'].ID;
            acc.BillingCountry = 'US';
            acc.ETS_WMI_Branch_ID__c = '1144';
            update acc;
            
            acc.recordtypeid =  [select id,name from RecordType where name = 'ETS/WMI'].ID;
            acc.BillingCountry = 'US';
            acc.ETS_WMI_Branch_ID__c = '3002';
            update acc;
            
            Task t = new Task();
            t.whatId = acc.id;
            t.subject = 'test';
            insert t;
                        
            Account acc1 = new Account();
            acc1.name='test account';
            acc1.Revenue_Q1__c=100.00;
            acc1.Revenue_Q2__c=200.00;
            acc1.Revenue_Q3__c=100.00;
            acc1.Revenue_Q4__c=222.00;
            acc1.Revenue_Q5__c=565.00;
            acc1.Revenue_Q6__c=5656.00;
            acc1.Revenue_Q7__c=56.00;
            acc1.Revenue_QC__c=566.00;
            acc1.BillingState = 'AZ';
            acc1.BillingCountry = 'US';
            acc1.recordtypeid =  [select id,name from RecordType where name = 'Business Account - UK'].ID;
            insert acc1;
            
            acc1.Revenue_Q6__c = 0;
            acc1.Type = 'Competitor';
            update acc1;
            
            acc1.type = 'Customer - Government Account';
            update acc1;
    
           /* User u = new User();
            u.lastname = 'test';
            u.Alias = 'test';
            u.Email = 'test@test.com';
            u.Username = 'testuser@test.com';
            u.CommunityNickname = 'test';
            TimeZoneSidKey
            LocaleSidKey
            EmailEncodingKey
            ProfileId
            insert u;*/
        Test.stopTest();
        
        opportunity opp = new opportunity();
        opp.name = 'test';
        opp.accountid = acc.id;
        opp.StageName = 'Quoted - No Decision';
        opp.CloseDate = Date.today();
        insert opp;
        
        update acc;
               
        delete acc1;
        
    }
}