/**
 * Test class for populateOwnerAndNSCManagers
 */
@isTest
private class Test_PopulateOwnerAndNSCManagers {

    static testMethod void testBranchManager() {
    	
    	User thisUser = [ select Id from User where Id = :UserInfo.getUserId() ];
    	User testUser;
    	Account testAccount;
    	Opportunity testOpportunity;
   		System.runAs ( thisUser ) {
   			//test user with NSC role
    		testUser = createUser();
    		//test Account
        	testAccount = createAccount();
        	System.assert(testAccount.id != null);
        	//create test opportunity
        	testOpportunity = createOpportunity(testUser.id, '103');
   		}
        System.assert(testUser.id != null);
       	testOpportunity.servicing_Branch__c ='101';
       	update testOpportunity;
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
        insert acc ;
        return acc;
    }
    
    private static Opportunity createOpportunity(Id ownerId, String servicingId) {
        Opportunity opportunity = new Opportunity(Name= 'testOpportunity',stageName='Working',closeDate = Date.Today().addDays(10),Servicing_Branch__c = servicingId);
        if(ownerId != null){
        	opportunity.ownerId =ownerId;
        }
        insert opportunity;
        return opportunity;
        
    }
    
    private static User createUser(){
    	Id UserRoleId =   [Select Id from  UserRole Where Name like 'NSC%' Limit 1].Id ;
		Profile p2 = [select id from profile where name='System Administrator'];
		User user = new User(Available_For_Leads__c=True,alias = 'SubUser', email='salesrep@testorg.com',
                 emailencodingkey='UTF-8', firstname='SubUserTesting' + DateTime.now(),lastname='SubUserTesting' +DateTime.now(),languagelocalekey='en_US',
                 localesidkey='en_US', profileid = p2.Id, timezonesidkey='America/Los_Angeles', 
                 username='salesrep@testorg.com' ,UserRoleId= UserRoleId ,Branch__c ='101');
       insert user;
       return user;
   }
}