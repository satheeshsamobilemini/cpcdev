global class OrphanOpportunityPurgeSchedule implements Schedulable{
  global void execute(SchedulableContext sc){
    try{ 
            OrphanOpportunityPurge oppPurge = new OrphanOpportunityPurge();
            Database.executeBatch(oppPurge, 200);
            
       }catch(Exception ex){ 
          System.debug('Exception Generated'+ex.getMessage());
       } 
   }
}