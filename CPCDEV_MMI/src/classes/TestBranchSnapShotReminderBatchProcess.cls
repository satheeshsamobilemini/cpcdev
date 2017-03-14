/**
 * Test Class for BranchSnapshotReminderBatchProcess
 */
@isTest
private class TestBranchSnapShotReminderBatchProcess {
    @isTest
    static void testExecute() {
        Weekly_Snapshot_Branch_Report__c branchSnapshot = new Weekly_Snapshot_Branch_Report__c(Servicing_Branch__c = '101 - Phoenix');
        insert branchSnapshot;
        Test.startTest();
        BranchSnapshotReminderBatchProcess batch = new BranchSnapshotReminderBatchProcess(branchSnapshot.id,DateTime.now());
        batch.isTest = true;    
        Database.executeBatch(batch, 100);
        Test.stopTest();
    }
    
    @isTest
    static void testTueReminder() {
        User u = MMIFullquoteTestDataProvider.getUser();   // for issue MSM 89..
        insert u;
        Weekly_Snapshot_Branch_Report__c branchSnapshot = new Weekly_Snapshot_Branch_Report__c(Servicing_Branch__c = '101 - Phoenix',ownerID = u.id);
        insert branchSnapshot;
        Date currentDate = Date.Today().toStartOfWeek();
        List<Weekly_Snapshot_Branch_Report__c> branchSnapshots = new List<Weekly_Snapshot_Branch_Report__c>();
        branchSnapshots.add(branchSnapshot);
        DateTime currentTime = DateTime.newInstance(currentDate.addDays(1),Time.newInstance(0, 0, 0, 0));
        Test.startTest();
        System.debug(':::::currentTime:::::'+currentTime);
        BranchSnapShotReminderUtil.sendMail(branchSnapshots,currentTime);
        Test.stopTest();
    }
}