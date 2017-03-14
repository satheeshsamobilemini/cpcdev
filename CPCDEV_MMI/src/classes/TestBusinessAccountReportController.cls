/**
 * Test Class for BusinessAccountReportController
 */
@isTest
private class TestBusinessAccountReportController {
 /* TFS 2291 start 1
    static testMethod void testBookOfBusiness() {
        List<User> users = createUsers(2);
        BussinessAccountReportController BAReportContrl = new BussinessAccountReportController();
        List<SelectOption> salesReps = BAReportContrl.getSReps();
        if(salesReps.size() > 1){
               List<Account> accounts = createAccounts(3,salesReps.get(1).getValue());
               BAReportContrl.SRepId = salesReps.get(1).getValue();
               BAReportContrl.searchAction();
               System.assert(BAReportContrl.getAccntWrapperList().size()>0);
       }
            
    }
    
    public static List<User> createUsers(integer size){
        List<User> users = new List<User>();
        Id profileId;
        List<Profile> profiles = [select id from profile where name = 'Customer Sales Specialist - NSC - US' limit 1];
        if(profiles.size() > 0){
            profileId= profiles.get(0).id;
        }else{
            Profile p2 = [select id from profile where name='System Administrator'];
            profileId = p2.id;
        }
        
        for(Integer i=0;i < size ;i++){
            User user = new User(Available_For_Leads__c=True,alias = 'SubUser', email='salesrep@testorg.com',
                 emailencodingkey='UTF-8', firstname='SubUserTesting' + DateTime.now()+'--'+i,lastname='SubUserTesting' +DateTime.now()+'-'+i,languagelocalekey='en_US',
                 localesidkey='en_US', profileid = profileId, timezonesidkey='America/Los_Angeles', 
                 username='salesrep@testorg.com'+i ,Branch__c ='101');
            users.add(user);
        }
        insert users;
        return users;
    }
    
    public static List<Account> createAccounts(integer size,String ownerId){
        List<Account> accounts = new List<Account>();
        for(Integer i=0;i< size;i++){
            Account myAcct = New Account (Name='Test Account -'+i,ownerId = ownerId,Book_of_Business__c = true,User_Type__c='Seasonal',Rental_Use_Comments__c = 'test');
            accounts.add(myAcct);
        }
        insert accounts;
        return accounts;
    }
  TFS 2291 end 1 */  
}