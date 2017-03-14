@isTest
public class TestAccountSweepSchedule {
   static testmethod void testaccountSweep() {
         String CRON_EXP = '0 0 0 15 3 ? 2022';
         String jobId = System.schedule('ScheduleApexClassTest',
                        CRON_EXP, 
                        new AccountSweepSchedule());
        // AccountSweepSchedule ASS = new AccountSweepSchedule();
         
   }
}