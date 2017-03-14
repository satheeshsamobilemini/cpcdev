global class AccountSweepSchedule implements Schedulable{
  global void execute(SchedulableContext sc){
    try{ 
            AccountSweepLogicBatchableClass accountSweep = new AccountSweepLogicBatchableClass(null,DateTime.now()); 
            Database.executeBatch(accountSweep , 10);
            
       }catch(Exception ex){ 
          System.debug('Exception Generated'+ex.getMessage());
       } 
   }
}