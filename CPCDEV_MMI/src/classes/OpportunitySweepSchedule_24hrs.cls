global class OpportunitySweepSchedule_24hrs implements Schedulable{
  global void execute(SchedulableContext sc){
    //try{ 
           //Shankar-Commented below code as the batch class name is changed to OpportunitySweepLogicBatchableClass_1hr,
           //		 both the 24hr and 1hr is trigger every hr from OpportunitySweepSchedule Class.
           
           /*OpportunitySweepLogicBatchableClass_24hr oppSweep = new OpportunitySweepLogicBatchableClass_24hr(null,DateTime.now()); 
            Database.executeBatch(oppSweep , 10);*/
            
      /* }catch(Exception ex){ 
          System.debug('Exception Generated'+ex.getMessage());
       } */
   }
}