/********************************************************************************************
Name   : ScheduleVRTReminder
Author : Jyoti Singh
Date   : Feb 15, 2013
Usage  : Used to execute VRTReminderBatchProcess batch class.
********************************************************************************************/  
global class ScheduleVRTReminder implements Schedulable{
    
    global void execute(SchedulableContext sc){
        try{ 
            VRTReminderBatchProcess batch = new VRTReminderBatchProcess();    
            Database.executeBatch(batch, 200);             
        }catch(Exception ex){
            System.debug('Exception in reminder for VRT :::'+ex.getMessage());
        } 
    }
    
    public static testMethod void batchTest(){
       Test.startTest();
       ScheduleVRTReminder m = new ScheduleVRTReminder();
       String sch = '00 27 06 * * ?';
       system.schedule('Batch Schedule', sch, m);
       Test.stopTest();
   } 
}