@isTest
public class TestFullQuoteEdit_AC {
   public static testMethod void testContoller() {
       Account objAcc = new Account();
            objAcc.Name = 'testAccount';
            objAcc.Type= 'test';
         insert objAcc;
       
       Opportunity objOppty =  new Opportunity();
          objOppty.Name = 'testOppty';
          objOppty.AccountID = objAcc.id;
          objOppty.CloseDate = Date.parse('05/11/2017');
          objOppty.StageName = 'Not Quoted';
          objOppty.Opportunity_Rating__c = 'Cold';
          objOppty.Billing_Zip_Postal_Code__c = '12456';
          objOppty.Delivery_Zip_Postal_Code__c = '12456';
          objOppty.Why_do_you_need_storage_Picklist__c = 'test';
          objOppty.of_Units__c = 10;
         insert objOppty;  
       
        MMI_Full_Quotes__c objMMIFullQuote = new MMI_Full_Quotes__c();
            objMMIFullQuote.Name = 'test full quote';
            objMMIFullQuote.Opportunity__c = objOppty.id;
         insert objMMIFullQuote;
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(objMMIFullQuote);
       
        FullQuoteEdit_AC FQE = new FullQuoteEdit_AC(sc);
         FQE.gotoEdit();
         FQE.gotoClone();
   }
}