@isTest
public class TestOpportunitiesSweepSchedule {
   public static testMethod void testContoller() { 
       OpportunitiesSweepSchedule OS = new OpportunitiesSweepSchedule();
        String Sc ='20 30 8 10 2 ?';
        system.schedule('test', sc, OS);
   }
}