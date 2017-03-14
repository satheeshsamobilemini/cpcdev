@isTest
public class TestAccountBillingData {
    static testmethod void testAccData() { 
          
           Account acc = new Account();
            acc.name='test account';
            acc.SAP_Bill_To__c='800015';
            acc.BillingStreet = 'test Street';
            acc.BillingCity = 'tst city'; 
            acc.Fax = '123445667';
            acc.BillingState = 'tst state'; 
            acc.Billing_Mobile__c = '';
            acc.Billing_Email__c = 'acc@test.com';
            acc.BillingPostalCode = '123456'; 
            acc.Type = '';
            acc.SAP_Sold_To__c = '800017';
            insert acc;
         
         acc.SAP_Bill_To__c='800015';
         update acc;
         
         AccountBillingData.updateAccountBillingDetails('800015','test Street','test Street','123445667','tst state','9889889090','acc@test.com','123456','test account','Prospect - National Account','800015');
         AccountBillingData.updateAccountBillingDetails('800016','test Street','test Street','123445667','tst state','9889889090','acc@test.com','123456','test account','Prospect - National Account','800015');
         AccountBillingData.updateAccountBillingDetails('','test Street','test Street','123445667','tst state','9889889090','acc@test.com','123456','test account','Prospect - National Account','800015');


     }

}