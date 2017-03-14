/************************************************************************************************************
* Name          : TestActivityManagement
* Created By    : Appirio Offshore(Hemant)
* Created Date  : 17th Jan 2013
* Description   : Test class for ActivityManagement class and Task trigger "TaskLeadResponseTimeCalculation"
************************************************************************************************************/
@isTest
private class TestActivityManagement {
    
    static testMethod void insertTaskOnLead() {
        
        Lead newLead = getLead();
        if(newLead.Id!=null) {
            Task newTask;
            Test.startTest();
            newTask = new Task(WhoId = newLead.Id,Subject = 'Call test', Status = 'Not Started');
            insert newTask;
            newTask.status ='Completed';
            update newTask;
            //Now check the results
            newLead = [SELECT Id, First_Activity_DateTime__c, Response_Time__c, CreatedDate FROM Lead WHERE Id = :newLead.Id];
            newTask = [SELECT Id, CreatedDate FROM Task WHERE Id = :newTask.Id];
            
            //System.assertNotEquals(newLead.Response_Time__c, null);
            Test.stopTest();
        }
    }
    
    static Lead getLead(){
        Lead newLead = new Lead(Company = 'Test Company', FirstName = 'Test Lead FN', LastName = 'Test Lead LN', Phone = '9876543210',Country='USA');
        insert newLead;
        return newLead;     
    }
    
    static testMethod void InsertTaskonAccOppConQuote(){
      List<Task> tList = new List<Task>();
      
      Account acc = new Account(Name = 'Smart Company',BillingCountry = 'UK',Branch__c = '761');
      acc.RecordTypeId = Schema.SobjectType.Account.getRecordTypeInfosByName().get('Business Account - UK').getRecordTypeId();
      insert acc;
      
      Opportunity op = new Opportunity(Name = 'Smart123',Billing_Country__c='UK',Branch__c = '761',AccountId = acc.Id,StageName='Not Quoted',CloseDate=date.today());
      insert op;
      
      Contact con = new Contact(LastName = 'Smithem',AccountId=acc.Id);
      insert con; 
      
      MMI_Full_Quotes_UK__c qt = new MMI_Full_Quotes_UK__c(Name='FQ - 1',Account__c=acc.Id);
      insert qt;
      
      UKrecordTypes__c uRecType = new UKrecordTypes__c(Name='UK Record Type',RecTypeId__c = 'Account_012800000007E2W');
      insert uRecType; 
      
      Task t1 = new Task(WhatId=acc.Id,Subject='Call',Status='Completed');
      tList.add(t1);
      
      Task t2 = new Task(WhatId=op.Id,Subject='Call for More Business',Status='Completed');
      tList.add(t2);
      
      Task t3 = new Task(WhatId=qt.Id,Subject='Called',Status='Completed');
      tList.add(t3);
      
      Task t4 = new Task(WhoId=con.Id,Subject='Call - Left Voice Mail',Status='Completed');
      tList.add(t4);
      
      Test.startTest();
      insert tList;
      Test.stopTest();
      
    }
}