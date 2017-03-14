@isTest
public class TestAccountHistoryProcessor {
    static testMethod  void TestAccountHistoryProcessor1(){
        Account acc = new Account();
        acc.LastName = 'Test';
        acc.SAP_Bill_To__c = '123456789';
        insert acc;
        Account_History__c accHis =new Account_History__c();
        accHis.Start_Date__c = Date.today();
        accHis.Account__c = acc.Id;
        insert accHis;
        accHis.Start_Date__c = Date.today()-1;
        update accHis;
        acc.SAP_Bill_To__c = null;
        update acc;
        acc.SAP_Bill_To__c = '123456235';
        update acc;
        Test.startTest();
            List<ID> accIDs = new List<ID>();
            accIDs.add(acc.ID);
            AccountHistoryProcessor.updateAccountHistory(accIDs);
        Test.stopTest();    
     }       
/*    
     static testMethod  void TestAccountHistoryProcessor2(){
        Account acc1 = new Account();
        acc1.LastName = 'Test1';
        acc1.SAP_Bill_To__c = null;
        Account_History__c accHis1 =new Account_History__c();
        accHis1.Start_Date__c = Date.today()-1;
        accHis1.Account__c = acc1.Id;
        insert accHis1;
        insert acc1;
        acc1.isSPOC_Account__c = true;
        update acc1;
         
    }*/
}