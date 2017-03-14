@isTest
public class ShiptoTriggerTest {
    static testMethod void ShiptoTriggerTest() {
        Account objAcc = new Account();
          objAcc.Name = 'testAccount'; 
        Insert objAcc;
        
        Shipto__c objShipTo = new Shipto__c();
          objShipTo.Account__c = objAcc.Id; 
          objShipTo.Zip__c = '5232';
          objShipTo.City__c = 'Bangalore'; 
          objShipTo.Country__c = 'India';
          objShipTo.State__c = 'KA';
        Insert objShipTo;
        
         objShipTo.State__c = 'KA';
          update objShipTo;
    }
}