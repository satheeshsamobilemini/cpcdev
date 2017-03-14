/**
* (c) 2015 TEKsystems Global Services
*
* Name           : TestInvoiceHistoryCtrl
* Created Date   : 14 Dec, 2015 
* Created By     : Jailabdin
* Purpose        : Test class for InvoiceHistoryCtrl class.
* 
**/

@isTest
public class TestInvoiceHistoryCtrl {
    static testmethod void TestInvceHistyCtrl () {
        Account a = new Account(name = 'test');
        insert a;
        CPQActiveURL__c ca =new CPQActiveURL__c(Name='test2');
        
        ca.CPQ_URL__c='http://cpq-devweb/CPQ'; 
        ca.Environment__c = 'cs42';
        ca.Portal_URL__c = 'http://cpq-devweb.mobilemini.com/CPQ';
        insert ca;
        apexpages.currentpage().getparameters().put('id',a.id);
        InvoiceHistoryCtrl IHC = new InvoiceHistoryCtrl();
        IHC.change();
    }
}