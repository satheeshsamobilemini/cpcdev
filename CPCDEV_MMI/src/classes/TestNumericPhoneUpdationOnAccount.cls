/**
 * Test class for NumericPhoneUpdationOnAccount
 */
@isTest
private class TestNumericPhoneUpdationOnAccount {

    static testMethod void testCreditCollectorInformation() {
       Account myAcct = New Account (Name='Test Account - TESTCreditCollector', credit_Collector__c = '200111');//,National_Account_Pricing_From_Result__c = 'Nat 7'
	   insert myAcct;
	   String creditCollectorName = '';
	   for(User u : [select Name, Collection_Controller_Number__c, Extension__c from User where Collection_Controller_Number__c = '200111']){
	   		creditCollectorName = u.Name;
  			if(u.Extension__c != null){
  				creditCollectorName += ' ' + '- '+u.Extension__c;
  			}
	   }
	   if(creditCollectorName!= null && creditCollectorName.length() > 0){
	   	for(Account acc : [select Id,credit_Collector__c,credit_Collector_Name__c from Account where id = : myAcct.id ]){
	   		//System.assertEquals(acc.credit_Collector_Name__c,creditCollectorName);
	   	}
	   }
    }
}