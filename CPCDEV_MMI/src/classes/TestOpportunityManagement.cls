/**
 * Test class for OpportunityManagement
 */
@isTest
private class TestOpportunityManagement {
    
     static testMethod void testSendEmailToBranchManager() {
        
        User thisUser = [ select Id,Branch__c from User where Id = :UserInfo.getUserId() ];
        User testUser;
        Account testAccount;
        List<Opportunity> testOpportunities;
        Set<ID> accIDs = new Set<ID>();
        OpportunityManagement.isTest = true;
        //SendEmailNotificationToBranchManagers.isTest = true;
        System.runAs ( thisUser ) {
            //test user with 298 branch
            
            testUser = createUser();
            //test Account
            testAccount = createAccount();
            Account acc = new Account() ;
            accIDs.add(acc.ID);
            System.assert(testAccount.id != null);
            //create test opportunity
            
        }
        //create opportunity by test user
        test.starttest();
        System.runAs(testUser){
            
            testOpportunities = createOpportunities(testUser.id, '101',testAccount);
            Task t = new Task();
            t.description= 'test task';
            t.subject = 'test';
            t.OwnerId = testOpportunities.get(1).ownerid;
            t.whatid = testOpportunities.get(1).id;
            insert t;
            Task t1 = new Task();
            t1.description= 'test task';
            t1.subject = 'test';
            t1.OwnerId = testOpportunities.get(0).ownerid;
            t1.whatid = testOpportunities.get(0).id;
            insert t1;
            System.assert(testUser.id != null);
            testOpportunities.get(0).Opportunity_Lost_Category__c ='Product';
            testOpportunities.get(1).name ='Updated Product';
            update testOpportunities;
            //OpportunityManagement oppMgmt = new OpportunityManagement();
            OpportunityManagement.loadBody(testOpportunities[0]);
            OpportunityManagement.updateServicingBranchId(accIDs,testOpportunities);
            OpportunityManagement.sendMailNotificationCreatedUser(testOpportunities[0].ID,testUser.ID,'Ankur Goyal');
        }
        test.stoptest();
        
     }
    
     private static Account createAccount(){
        Account acc = new Account() ;
        acc.shippingPostalCode =  'ML5' ;
        acc.shippingcountry = 'UK' ;
        List<RecordType> rts = [Select r.Name, r.Id From RecordType r where Name='Business Account' and SObjectType='Account' limit 1];
        
        if(rts.size() > 0){
            acc.RecordTypeId=rts.get(0).id;
        }
        acc.Name = 'test Account';
        acc.Servicing_Branch_Id__c = '103';
        insert acc ;
        return acc;
    }
    
    private static List<Opportunity> createOpportunities(Id ownerId, String servicingId,Account account) {
        List<Opportunity> opportunities = new List<Opportunity>();
        Opportunity opportunity = new Opportunity(Name= 'testOpportunity',stageName='Working',closeDate = Date.Today().addDays(10),Servicing_Branch__c = servicingId, Branch__c = '298');
        
        Opportunity opportunity1 = new Opportunity(Name= 'testOpportunity - 1',stageName='Working',closeDate = Date.Today().addDays(15),Servicing_Branch__c = servicingId, Opportunity_Lost_Category__c ='Price',Branch__c = '298');
        if(ownerId != null){
            opportunity.ownerId =ownerId;
            opportunity1.ownerId =ownerId;
        }
        if(account != null){
            opportunity.AccountId = account.id;
            opportunity1.AccountId = account.id;
        }
        opportunity1.notify_CreatedUser__c = true;
        opportunity1.Servicing_Branch__c = '298';
        opportunity.Servicing_Branch__c = '298';
        opportunity1.Branch__c = '298';
        opportunity.Branch__c = '777';
        opportunities.add(opportunity);
        opportunities.add(opportunity1);
        insert opportunities;
        return opportunities; 
        
    }
    
    private static User createUser(){
        Profile p2 = [select id from profile where name='System Administrator'];
        UserRole usrrole = [select id from userrole where name = 'Branch Manager - 101 - Phoenix'];
        
        User user = new User(Available_For_Leads__c=True,alias = 'SubUser', email='salesrep@testorg.com',
                 emailencodingkey='UTF-8', firstname='SubUserTesting' + DateTime.now(),lastname='SubUserTesting' +DateTime.now(),languagelocalekey='en_US',
                 localesidkey='en_US', profileid = p2.Id, timezonesidkey='America/Los_Angeles', 
                 username='salesrep@testorg.com' ,Branch__c ='298',userrole=usrrole);
       insert user;
       return user;
   }
}