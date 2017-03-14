/************************************************************************************************************
* Name          : TestSelectBranchForBMExt
* Created By    : Appirio Offshore(Hemant)
* Created Date  : 1 March 2013
* Description   : Test class for SelectBranchForBMExt class
************************************************************************************************************/
@isTest
private class TestSelectBranchForBMExt {
    
    //test method for SelectBranchForBMExt class
    static testMethod void SelectBranchForBMExt() {
    	
    	Id profileId;
	    for(Profile profile : [select Id from Profile where Name='System Administrator' limit 1]){
	        profileId = profile.Id;
	    }
	    Id userRoleId;
	    for(UserRole userRole : [Select Id From UserRole where Name like 'Branch Manager%' limit 1]){
	        userRoleId = userRole.Id;
	    }
	    User user = createUser(userRoleId ,profileId,true);
	    System.RunAs(user){
	    	// Insert account
		    Account account = new Account();
		    account.Name = 'account';
		    insert account;
		    
		    //insert BranchMgrWithMultipleBranches__c customsetting data
		    BranchMgrWithMultipleBranches__c BMBranches = new BranchMgrWithMultipleBranches__c(Name = 'tstUserFN tstUserLN', Branches_for_BM__c = '125,170');
		    insert BMBranches;
		    Test.startTest();
		    
		    selectBranchForBMExt SelBrnch = new selectBranchForBMExt(new ApexPages.StandardController(account));
		    SelBrnch.selectedBranch = '125';
		    SelBrnch.redirect();
		    Test.stopTest();
    	}
    }
    
    //A method to create a user
    static User createUser(Id userRoleId,Id profileId,Boolean isInsert){
        User user = new User(
            Username = 'tst_usr_case_00039090@test.com',
            Email = 'test_user@test.com',
            FirstName = 'tstUserFN',
            LastName = 'tstUserLN',
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