@isTest
public class BatchApexToUpdateAccountTerritoryTest {
    static testMethod void TestBranchFilter(){
         Account objAcc = new Account();
           objAcc.Name = 'testAccount';
           objAcc.Territory__c = 'territory';
           objAcc.is_Branch_account_updated__c = false;
           objAcc.BillingPostalCode  = '02548';
         insert objAcc;       
        
          List<Account> accountinsertList = new List<Account>();
          accountinsertList.add(objAcc);
        
         Lead objLead = new Lead();
           objLead.FirstName ='testfirst';
           objLead.LastName = 'lastName';
           objLead.Company = 'tek';
           objLead.is_Territory_update__c = false;
           objLead.Shipping_Territory__c = 'test';
        insert objLead;
        
        List<Lead> leadinsertList = new List<Lead>();
        leadinsertList.add(objLead);
        
          Database.BatchableContext BC;
        
         BatchApexToUpdateAccountTerritory BTAT = new BatchApexToUpdateAccountTerritory();
         BTAT.execute(BC,accountinsertList);
         Database.executeBatch(BTAT);
        
         BatchApexToUpdateLeadTerritory batch = new BatchApexToUpdateLeadTerritory();
         batch.execute(bc,leadinsertList);
         Database.executeBatch(batch);
        
         List<sObject> scope = new List<sObject>();
         BatchDodgeProjectUpdate  bt = new BatchDodgeProjectUpdate();
          bt.execute(BC,scope);
         Database.executeBatch(bt);
        
        BatchDodgeProjectUpdateTerritory  bd = NEW BatchDodgeProjectUpdateTerritory();
          bD.execute(BC,scope);
         Database.executeBatch(bD);
    } 
}