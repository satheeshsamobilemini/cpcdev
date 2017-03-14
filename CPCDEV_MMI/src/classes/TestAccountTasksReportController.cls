/*************************************************************************
Name          : TestAccountTasksReportController
Usage         : Test class for AccountTasksReportController.
Created By    : Parth Tamhaney
Created Date  : July 16 2009

Modified By :    Kirtesh Jain
Modified Date :  July 29, 2009
*************************************************************************/
@isTest
private class TestAccountTasksReportController {
    
    static testMethod void TestBranchFilter(){
        
     // System.runAs(getUser()){
        Test.startTest();
        InsertAccountWIthOpenTask();
        AccountTasksReportController cont = new AccountTasksReportController();
        
        cont.branchId = 'tes';
        cont.applyBranchFilter();
        System.debug('Parth********' + cont.accountList.size());
        System.debug('Parth********UserName' + UserInfo.getUserName());
        System.debug('Parth********' + cont.accounts.size());
        
        for(List<Account> lstAccount : cont.accounts){
            for(Account acc : lstAccount){
                if(acc.Branch__c != 'tes'){
                  System.assert(false, 'B id: ' + acc.Branch__c);
                  break;
                }
            }
        }
        
        Test.stopTest();
     // }
        
    }
    
    static testMethod void TestSort() {
      //System.runAs(getUser()){
          Test.startTest();
          InsertAccountWIthOpenTask();
          AccountTasksReportController cont = new AccountTasksReportController();
          cont.sortField = 'Account.Branch__c';
          cont.sortData();
          System.assertEquals(cont.getIsAsc(),true);
          cont.sortData();
          System.assertEquals(cont.getIsAsc(),false);
          System.assertEquals(cont.previousSortField,'Account.Branch__c');
          Test.stopTest();
       // }
     }
   
    static testMethod void TestPaging() {
      
     // System.runAs(getUser()){
          Test.startTest();
          InsertAccountWIthOpenTask();
          System.debug('Parth********TestPAging');
          AccountTasksReportController cont = new AccountTasksReportController();
          System.assertEquals(cont.isNextPageAvailable,false);
          System.assertEquals(cont.isPreviousPageAvailable,false);
          System.debug('testKirtesh*********************accountinsideTestpaging'+cont.accountList );
          if(cont.totalPage>1){
            cont.getNextAccounts();
            System.assertEquals(cont.index,1);
            System.assertEquals(cont.isPreviousPageAvailable,true);
            
            cont.getPrevAccounts();
            System.assertEquals(cont.isNextPageAvailable,true);
            System.assertEquals(cont.isPreviousPageAvailable,false);
            System.assertEquals(cont.index,0);
          }
        
          for(integer i=0; i<=cont.totalPage; i++){
            cont.getNextAccounts();
          }
       
          System.assertEquals(cont.isNextPageAvailable,false);
          System.assertEquals(cont.isPreviousPageAvailable,false);
          Test.stopTest();
       // }
     }
    
    
     public static void  InsertAccountWIthOpenTask(){
       List<Account> accountList = new List<Account>();
       User u = [Select Branch_Id__c ,Id from User Where Id =: UserInfo.getUserId() Limit 1 ];
       System.debug('testKirtesh'+u);
       for( integer i = 0 ; i  < 30 ; i++ ){
         Account acc = new Account() ;
         acc.Name = 'test'+i;
         acc.OwnerId = u.Id ;
         acc.Branch__c = u.Branch_Id__c ;
         acc.Number_of_Open_Tasks__c = 0 ;
         acc.BillingCountry = 'USA';  // TFS 7891
         accountList.add( acc);
       }
       insert accountList ;
       
       System.debug('testKirtesh*********************account'+accountList);
     }
     
     public static User getUser(){
      
       Integer i = 10;
       Datetime datenow = system.now();
       Profile profile = [select id from Profile limit 1];
       
       UserRole role1 = new UserRole();
       role1.Name = 'Parent Manager';
       insert role1;
 
       i++;
       String uniqueId = 'salesrep'+i+'@testorg.com';
       User managerUser = new User(Available_For_Leads__c=True,alias = 'SUser'+ i, email='salesrep@testorg.com',
                       emailencodingkey='UTF-8', firstname='SubUserTesting' + (7-i),lastname='SubUserTesting' +i,languagelocalekey='en_US',
                       localesidkey='en_US', profileid = profile.Id, timezonesidkey='America/Los_Angeles', 
                       username=uniqueId  ,UserRoleId = role1.Id , Branch__c = 'tes');
       insert managerUser;
       
         UserRole newRole = new UserRole() ;
          newRole.Name = 'child SalesRep';
          newRole.ParentRoleID = role1.Id;
          insert newRole ;
       i++;
       String uniqueId2 = 'salesrep'+i+'@testorg.com';
       User user = new User(Available_For_Leads__c=True,alias = 'RUser'+ i, email='salesrep@testorg.com',
                       emailencodingkey='UTF-8', firstname='bUserTesting' + (7-i),lastname='SubUserTesting' +i,languagelocalekey='en_US',
                       localesidkey='en_US', profileid = profile.Id, timezonesidkey='America/Los_Angeles', 
                       username=uniqueId2 ,UserRoleId= newRole.id , Branch__c = 'tes');
       insert user;
       
       
       
       return managerUser;
     }
     
     static testMethod void TestPagingination() {
        //System.runAs(getUser()){
         Test.startTest();
         InsertAccountWIthOpenTask();
         AccountTasksReportController cont = new AccountTasksReportController();
         Test.stopTest();
      // }
    }
}