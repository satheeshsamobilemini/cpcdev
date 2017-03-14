@isTest
private class SchedulerForDeleteInactiveContactTest{
    @isTest static void testSchedule(){
        Test.StartTest();
        SchedulerForDeleteInactiveContact SDIC = new SchedulerForDeleteInactiveContact();   
        String SZU = '0 0 23 * * ?';
        system.schedule('Delete Inactive Contact', SZU, SDIC);
        Test.stopTest();
    }
}