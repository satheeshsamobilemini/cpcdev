/**
 * Test Class for ScheduleBranchSnapshotReminder
 */
@isTest
private class TestScheduleBranchSnapshotReminder {
	@isTest
    static void testExecute() {
        Test.StartTest();
        String scheduleStr = String.valueOf(DateTime.now().second())+' '+ String.valueOf(DateTime.now().minute())+ ' '+String.valueOf(DateTime.now().hourGmt()) +' * * ?';
        ScheduleBranchSnapshotReminder scheduleBranchSnapshot = new ScheduleBranchSnapshotReminder();
        String jobId = System.schedule('test schedule', scheduleStr, scheduleBranchSnapshot);
	    system.debug('jobId ::: '+ jobId);
		List<CronTrigger> cronTriggers = [SELECT id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
		System.assert(cronTriggers.size() > 0);
		System.assertEquals(cronTriggers.get(0).TimesTriggered, 0);
        Test.StopTest();
    }
}