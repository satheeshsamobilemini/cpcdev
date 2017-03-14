global class CrtUpdateTaskOnQuoteCrtUpdateSchdl implements Schedulable{
  global void execute(SchedulableContext sc){
    try{ 
            CrtUpdateTaskOnQuoteCrtUpdate crtUpdateTask = new CrtUpdateTaskOnQuoteCrtUpdate();
            Database.executeBatch(crtUpdateTask, 10);
       }catch(Exception ex){ 
          System.debug('Exception Generated'+ex.getMessage());
       } 
   }
}