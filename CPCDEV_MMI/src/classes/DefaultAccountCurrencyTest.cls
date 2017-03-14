/**
* (c) 2016 TEKsystems Global Services
*
* Name           : DefaultAccountCurrencyTest
* Created Date   : 23 March 2016
* Created By     : Sreenivas M (TEK)
* Purpose        : Test class for DefaultAccountCurrency batch class
*
**/
@isTest
public class DefaultAccountCurrencyTest
{
   static testMethod void testAccCurrency()
   {
    List<Account> listAcc = new List<Account>();
       
     for(integer i=0;i<10;i++)
     {
      Account acc = new Account();
      acc.billingcountry='CAN';
      if(i!=4 && i!=5)
       acc.Name = 'TestAccount'+i;      
      
      if(i==2)
      {
         acc.billingcountry='NoCAN';
         acc.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Business Account').getRecordTypeId();    
      }
      if(i==3)
         acc.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Business Account - UK').getRecordTypeId();    
      if(i==4 || i==5)
      {
         acc.firstname ='testfna'+i;
         acc.lastname ='testlname'+i;
         acc.RecordTypeId = i==4?Schema.SObjectType.Account.getRecordTypeInfosByName().get('Residential Account').getRecordTypeId():Schema.SObjectType.Account.getRecordTypeInfosByName().get('Residential Account - UK').getRecordTypeId();
      }
            
      listAcc.add(acc);
     
     }
     insert listAcc;
     //List<SObject> aList = Test.loadData(Account.sObjectType,'AccountTestData');
     DefaultAccountCurrency defAccCur = new DefaultAccountCurrency();
     ID batchprocessid = Database.executeBatch(defAccCur,2000);
   }
}