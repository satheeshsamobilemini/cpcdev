/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class TestScheduleDeleteOfAccounts {

     /*static testMethod void myUnitTest() {
        Account account = new Account();
        account.Name = 'account';
        account.BillingCountry  = 'sassadsad';
        account.IsCloneInProgress__c = true;
        insert account;
        
        Test.StartTest();
        String scheduleStr = String.valueOf(DateTime.now().second())+' '+ String.valueOf(DateTime.now().minute())+ ' '+String.valueOf(DateTime.now().hourGmt()) +' * * ?';
        ScheduleDeleteOfAccounts schedule = new ScheduleDeleteOfAccounts();
        String jobId = System.schedule('test schedule', scheduleStr, schedule);
        system.debug('jobId ::: '+ jobId);
        
        ScheduleDeleteOfAccounts batchDR = new ScheduleDeleteOfAccounts();
        Database.executebatch(batchDR);
        Test.StopTest();
    }*/
    @isTest static void testSchedule(){
        Test.StartTest();
        ScheduleDeleteOfAccounts SDOA = new ScheduleDeleteOfAccounts();
        String SZU = '0 0 23 * * ?';
        system.schedule('Delete Of Accounts', SZU, SDOA);
        Database.executebatch(SDOA);
        Test.stopTest();
    }
    @isTest static void testBatch(){
        Test.StartTest();
        Account Acc = new Account();
        Acc.Name = 'Test';
        Acc.IsCloneInProgress__c = true;
        insert Acc;
        ScheduleDeleteOfAccounts BatchSDOA = new ScheduleDeleteOfAccounts();
        Database.executebatch(BatchSDOA);
        Test.stopTest();
    }
}