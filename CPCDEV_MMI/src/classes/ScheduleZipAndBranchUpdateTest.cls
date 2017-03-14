@isTest
private class ScheduleZipAndBranchUpdateTest{
    @isTest static void testSchedule(){
        Test.StartTest();
        ScheduleZipAndBranchUpdate SZBU = new ScheduleZipAndBranchUpdate();
        String SZU = '0 0 23 * * ?';
        system.schedule('Test Zip and Branch', SZU, SZBU);
        Test.stopTest();
    }
}