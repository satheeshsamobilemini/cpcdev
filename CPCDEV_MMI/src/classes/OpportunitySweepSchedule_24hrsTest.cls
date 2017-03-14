@isTest
private class OpportunitySweepSchedule_24hrsTest{
    @isTest static void testSchedule(){
        Test.StartTest();
        OpportunitySweepSchedule_24hrs SZBU = new OpportunitySweepSchedule_24hrs();
        String SZU = '0 0 23 * * ?';
        system.schedule('Test Zip and Branch', SZU, SZBU);
        Test.stopTest();
    }
}