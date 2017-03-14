/**************************************************************************
Name: TestAccountSweepLogic
----------------------------------------------------------------------
Purpose: This class is created to test AccountSweepLogic : account sweep process 
Created by TEKsystem Development team
----------------------------------------------------------------------
**************************************************************************/

@isTest
private with sharing class TestAccountSweepLogic {

   static testMethod void myUnitTestMethod1(){  // Account Sweep..
    // Test for scenario where account sweep takes place
    User usrObj = MMIFullquoteTestDataProvider.getUser();
    Profile p = [select id from profile WHERE Name='Sales Rep - US'];
    UserRole usrole =[SELECT Id,Name FROM UserRole WHERE Name = 'Sales Rep - 121 - El Paso' LIMIT 1];
        
    usrObj.Territory__c = '152-02';
    system.runAs(usrObj){
        
        test.startTest();
        
        User AccountTerritoryUser = new User(Alias='TESTUSER',Email='TEST.USER@TEST.TEST',EmailEncodingKey='UTF-8',FirstName='AccountTerritory_TEST',LastName='TEST_LAST_NAME', LanguageLocaleKey='en_US',LocaleSidKey='en_GB',timezonesidkey='Europe/London',Title='TEST TITLE',
            username='TEST1.USER1@TEST1.TEST1',Branch__c='101-Phoenix',Territory__c = '158-01',IsActive = True,ProfileId = p.Id,UserRoleId = usrole.id);
        insert AccountTerritoryUser;    
        
        
        
        Account acc = new Account();
        acc.Name = 'TestAccount1';
        acc.Industry = '0-Non-classified/Unknown';
        acc.Type = 'Prospect - National Account';
        acc.Territory__c = '158-01';
        acc.BillingCountry = 'USA';
        insert acc;
        
        Contact con = new Contact();
        con.AccountId = acc.id;
        con.LastName = 'Test_LAST';
        insert con;
        
        List<Account> acclist1 = new List<Account>();
        acclist1.add(acc);
        AccountSweepLogic accsweep1 = new AccountSweepLogic();
        AccountSweepLogic.isTest = True;
        AccountSweepLogic.ISRusers.put(AccountTerritoryUser.Territory__c,AccountTerritoryUser); 
        AccountSweepLogic.processAccounts(acclist1);
        
        Account acc2 = new Account();
        acc2.Name = 'TestAccount1';
        acc2.Industry = '1-Homeowner/Misc. Storage';
        acc2.Type = 'Prospect - National Account';
        acc2.Territory__c = '';
        acc2.BillingCountry = 'USA';
        insert acc2;
        List<Account> acclist2 = new List<Account>();
        acclist2.add(acc2); 
        //AccountSweepLogic.processAccounts(acclist2); 
    }
  }

 static testMethod void myUnitTestMethod2(){   // Account with Territory NULL ..
    // Test for scenario where account Territory is NULL.   
    User usrObj = MMIFullquoteTestDataProvider.getUser();
       
    UserRole usrole =[SELECT Id,Name FROM UserRole WHERE Name = 'Sales Rep - 121 - El Paso' LIMIT 1];
        
    usrObj.UserRoleId  = usrole.id;
    usrObj.Territory__c = '152-02';
    //system.runAs(usrObj){
        
        test.startTest();
             
        Account acc = new Account();
        acc.Name = 'TestAccount2';
        acc.Industry = '0-Non-classified/Unknown';
        acc.Type = 'Prospect - National Account';
        acc.BillingCountry = 'USA';
        insert acc;
        
        List<Account> acclist2 = new List<Account>();
        acclist2.add(acc);
        AccountSweepLogic accsweep2 = new AccountSweepLogic();
        AccountSweepLogic.processAccounts(acclist2);
                
        test.stopTest();
        
    //}
  }
  
  static testMethod void myUnitTestMethod3(){       // HomeOwner Accounts ..
    // Test for scenario where account HomeOwner Account.   
    User usrObj = MMIFullquoteTestDataProvider.getUser();
        
    UserRole usrole =[SELECT Id,Name FROM UserRole WHERE Name = 'Sales Rep - 121 - El Paso' LIMIT 1];
    
    usrObj.UserRoleId  = usrole.id;
    usrObj.Territory__c = '152-02';
   // system.runAs(usrObj){
        
        test.startTest();
        
        Account acc = new Account();
        acc.Name = 'TestAccount3';
        acc.Industry = '1-Homeowner/Misc. Storage';
        acc.Type = 'Prospect - National Account';
        acc.BillingCountry = 'USA';
        insert acc;
        
        List<Account> acclist3 = new List<Account>();
        acclist3.add(acc);
        AccountSweepLogic accsweep3 = new AccountSweepLogic();
        AccountSweepLogic.processAccounts(acclist3);
                
        test.stopTest();
        
   // }
  }
  
  static testMethod void myUnitTestMethod4(){       // UK Accounts ..
    // Test for scenario where account is UK Account.   
    User usrObj = MMIFullquoteTestDataProvider.getUser();
       
    UserRole usrole =[SELECT Id,Name FROM UserRole WHERE Name = 'Sales Rep - 121 - El Paso' LIMIT 1];
    
    usrObj.UserRoleId  = usrole.id;
    usrObj.Territory__c = '152-02';
    
    RecordType  AccRecType = [SELECT Id,Name,SobjectType FROM RecordType WHERE SobjectType = 'Account' AND Name = 'Business Account - UK'];
    //system.runAs(usrObj){
        
        test.startTest();
        
        Account acc = new Account();
        acc.Name = 'TestAccount4';
        acc.Industry = '0-Non-classified/Unknown';
        acc.Type = 'Prospect - National Account';
        acc.RecordTypeId = AccRecType.Id ;
        acc.BillingCountry = 'USA';
        insert acc;
        
        List<Account> acclist4 = new List<Account>();
        acclist4.add(acc);
        AccountSweepLogic accsweep4 = new AccountSweepLogic();
        AccountSweepLogic.processAccounts(acclist4);
                
        test.stopTest();
        
   // }
  } 
}