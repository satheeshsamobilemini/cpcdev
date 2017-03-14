global class OpportunitiesSweepSchedule implements Schedulable{
    //public static String jobID = '';
    global void execute(SchedulableContext sc){
        DateTime currentTime  = DateTime.now();  
        try{ 
             
            /*OpportunitySweepLogicBatchableClasse opporutunitySweep = new OpportunitySweepLogicBatchableClasse(null,DateTime.now()); 
            Database.executeBatch(opporutunitySweep , 10);*/
            
            //Shankar-Trigger both 1hr and 24hrs sweep as both have to run every one hour.
            OpportunitySweepLogicBatchableClass_1hr optySweep1hr = new OpportunitySweepLogicBatchableClass_1hr(null, DateTime.now());
            Database.executeBatch(optySweep1hr, 10);
            
            /*OpportunitySweepLogicBatchableClass_24hr optySweep24hr = new OpportunitySweepLogicBatchableClass_24hr(null, DateTime.now());
            Database.executeBatch(optySweep24hr, 10);*/
            
        }catch(Exception ex){ 
            System.debug('Exception in reminder for branch snapshot ::'+ex.getMessage());
        } 
        //Commented by Najma Ateeq on 12 july 2013 for case 00050014
        /*ABORT CURRENTLY RUNNING JOB ? MUST BE AT VERY END OF EXECUTE METHOD OR IT WILL NOT WORK
        System.abortJob(sc.getTriggerId());
        // SCHEDULE NEXT JOB HERE 
        
        //Schedule next scheduler for currenttime + scheduler frequency.
        scheduleNSCSweepOpportunities scheduleNSC = new scheduleNSCSweepOpportunities();
        
        //proper timestamp
        String sch = nextScheduleTime(currentTime);
        
        //schedule the new job
        jobID = system.schedule('Schedule NSC sweep '+ String.valueof(currentTime) ,sch,scheduleNSC );
        */
    }
    //Commented by Najma Ateeq on 12 july 2013 for case 00050014
    /*
    public String nextScheduleTime(DateTime currentTime){
       currentTime = currentTime.addhours(1);
       String sch = String.valueOf(currentTime.second() ) + ' ' + String.valueOf(currentTime.minute() ) + ' ' + String.valueOf( currentTime.hour() ) + ' ' + String.valueOf( currentTime.day() ) + ' ' + String.valueOf( currentTime.month() ) + ' ' + '? ' + String.valueOf( currentTime.year() );
       return sch;
    } */
        
}