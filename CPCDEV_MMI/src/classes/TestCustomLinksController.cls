/*************************************************************************
Name   : TestCustomLinksController
Usage  : Test class to test CustomLinksController apex class.
Author : Kirtesh jain
Date   : July 15, 2009
*************************************************************************/
public class TestCustomLinksController {
  @isTest
  public static void Test_CustomLinksController(){
    string currentUser= UserInfo.getUserId();
    CustomLinksController testObj =new CustomLinksController();
    
      Integer myOpenHotLeads = [Select count() 
                        From Lead l 
                        where l.Rating = 'Hot (Probably Order)' and  l.Status = 'Open' and l.LeadSource <> 'Dodge'
                              and l.OwnerId =: currentUser Limit 1000];

      Integer myOpenWarmDodgeLeads = [Select count() 
                        From Lead l 
                        where l.Rating = 'Hot (Probably Order)' and  l.Status = 'Open' and l.LeadSource = 'Dodge'
                              and l.OwnerId =: currentUser Limit 1000];
     
      Integer myOpenLeads = [ Select count() 
                      From Lead l 
                      where  l.Status ='Open' and l.OwnerId=: currentUser limit 2000];  
      
      Integer myAccounts = [ Select count()
                     From  Account
                     where OwnerId=:currentUser ];  
      
      Integer myContacts = [ Select count() 
                     From Contact 
                     where OwnerId=:currentUser ];
      
      Integer myOpenOpportunities = [ Select count()  
                           From Opportunity 
                           where StageName != 'Quoted - Won'and OwnerId=:currentUser ];
      
      Integer myOverdueTasks = [ Select count()
                            FROM Task
                            Where ActivityDate < TODAY AND isclosed = false AND OwnerId=:currentUser ];
    
    //Integer  myAccountsWithNoCallbacks =  AccountTasksReportController.getRecordCount();  
    
    /*System.assertEquals(testObj.myOpenHotLeads,myOpenHotLeads );
    System.assertEquals(testObj.myOpenHotDodgeLeads,myOpenHotDodgeLeads );
    System.assertEquals(testObj.myOpenLeads,myOpenLeads);
    System.assertEquals(testObj.myOpenOpportunities,myOpenOpportunities);
    System.assertEquals(testObj.myAccounts,myAccounts);
    System.assertEquals(testObj.myContacts,myContacts);
    System.assertEquals(testObj.myOverdueTasks,myOverdueTasks);*/
    //System.assertEquals(testObj.myAccountsWithNoCallbacks , myAccountsWithNoCallbacks );
  }
  
  // TFS 3982_4221 - ETS/WMI Custom Links..
   @isTest
  public static void Test_ETSCustomLinksController(){
    String uId = UserInfo.getUserId();
    RecordType aRec = [select Id from RecordType where SobjectType= 'Account' and Name = 'ETS/WMI'];
    Account acc = new Account(Name= 'TestLink Account', ownerId = uId, RecordtypeId = String.valueOf(aRec.Id));
    insert acc;
    Task t = new Task(WhatId = acc.Id, CallType = 'Inbound', Status = 'Completed', Subject= 'Call');
    t.ActivityDate = Date.Today().addDays(-40);
    insert t;
    CustomLinksController_ETS ets = new CustomLinksController_ETS();
  }
}