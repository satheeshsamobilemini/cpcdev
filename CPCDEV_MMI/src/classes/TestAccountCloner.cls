/*****************************************************************************
 * Name             : TestAccountCloner 
 * Created By       : Bharti(Appirio Offshore)
 * Created Date     : 3rd March, 2012.
 * Purpose          : TestClass for AccountCloner 
*****************************************************************************/
@isTest
private class TestAccountCloner {

    static testMethod void myUnitTest() {
        
        Id profileId;
        for(Profile profile : [select Id from Profile where Name='System Administrator']){
            profileId = profile.Id;
        }
        Id userRoleId;
        for(UserRole userRole : [Select Id From UserRole where Name = 'Branch Manager - 147 - Boston']){
            userRoleId = userRole.Id;
        }
        User user = createUser(userRoleId ,profileId,true);
        System.RunAs(user){
        
        // Insert account
        Account account = new Account();
        account.Name = 'account';
        insert account;
        
        Test.startTest();
            Id accountID = AccountCloner.createClone(account.Id, '');
            Account acc = retrieveAccount(accountID);
            system.assertEquals(acc.IsCloneInProgress__c,true);
            Boolean testBool = AccountCloner.isNSCBranchUserRole();
            Boolean testBool2 = AccountCloner.isBMHasMultipleBranches(account.Id);
        Test.stopTest();
        }
    }
    static Account retrieveAccount(Id accId){
        for(Account acc : [select Id,IsCloneInProgress__c from Account where Id = :accId]){
            return acc;
        }
        return null;
    }
    
    //A method to create a user
    static User createUser(Id userRoleId,Id profileId,Boolean isInsert){
        User user = new User(
            Username = 'john123456789@acme.com',
            Email = 'john@acme.com',
            LastName = 'vhir',
            Alias = 'sv',
            ProfileID = profileId,
            LocaleSidKey = 'en_US',
            LanguageLocaleKey = 'en_US',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey='UTF-8',
            UserRoleId = userRoleId
        );
        if(isInsert)
            insert user;
        return user;
    }
}