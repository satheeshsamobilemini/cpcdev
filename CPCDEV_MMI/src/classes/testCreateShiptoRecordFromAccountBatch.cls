/**
* (c) 2015 TEKsystems Global Services
*
* Name           : testCreateShiptoRecordFromAccountBatch
* Created Date   : 25 Sept 2015 @16:45
* Created By     : Ankur Goyal
* Purpose        : Test class for CreateShiptoRecordFromAccountBatch batchable class
*                
**/

@isTest
public class testCreateShiptoRecordFromAccountBatch{

    static testmethod void testCreateShiptoRecordFromxistingAccounts(){
        List<Account> accs = new List<Account>();
        for(integer i = 0; i < 200; i++){
            accs.add(new Account(name = 'test-batch',BillingPostalCode='64632'));
        }
        insert accs;

        //start the test  
    
        Test.startTest();
        Database.executeBatch(new CreateShiptoRecordFromAccountBatch(),2000);
        Test.stopTest();

        // Verify the test worked  
    
        accs = [SELECT id, name FROM account 
                WHERE name = 'test-batch'];
        System.assert(accs.size() == 200);
        
        List<shipto__c> sto = [select id from shipto__c where account__c in
        (select id from account where name = 'test-batch') ];
        
        System.assert(sto.size() == 200);
       system.debug('==total accs created==' + accs.size() + '== total shipto records created ==' + sto.size());
    }
}