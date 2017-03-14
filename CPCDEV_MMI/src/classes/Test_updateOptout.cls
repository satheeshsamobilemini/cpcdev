/*************************************************************************************
Name : Test_updateOptout 
Created By : Mohit (Appirio Offshore)
Created Date : Sept 20, 2013
Description : The Test class is used to cover UpdateOptOut trigger.
***************************************************************************************/
@isTest
public class Test_updateOptout{
    
     static testMethod void myUnitTest() {
        Campaign cmp = new Campaign(name ='testCamp');
        insert cmp;
        iContactforSF__iContact_Sent_Message__c msg = new iContactforSF__iContact_Sent_Message__c(iContactforSF__Campaign__c = cmp.id);
        insert msg;
        iContactforSF__iContact_Message_Statistic__c dataOut = new iContactforSF__iContact_Message_Statistic__c(iContactforSF__iContact_Sent_Message__c = msg.id);
        insert dataOut;
     }
}