/**
 * Test Class for ScheduleSafetyAttachmentReminder
 */
@isTest
private class TestScheduleSafetyAttachmentReminder {
	@isTest
    static void testExcute() {
    	Test.StartTest();
        String scheduleStr = String.valueOf(DateTime.now().second())+' '+ String.valueOf(DateTime.now().minute())+ ' '+String.valueOf(DateTime.now().hourGmt()) +' * * ?';
        ScheduleSafetyAttachmentReminder scheduleSafetyAttachment = new ScheduleSafetyAttachmentReminder();
        String jobId = System.schedule('test schedule', scheduleStr, scheduleSafetyAttachment);
	    system.debug('jobId ::: '+ jobId);
		List<CronTrigger> cronTriggers = [SELECT id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
		System.assert(cronTriggers.size() > 0);
		System.assertEquals(cronTriggers.get(0).TimesTriggered, 0);
        Test.StopTest();
     
    }
}