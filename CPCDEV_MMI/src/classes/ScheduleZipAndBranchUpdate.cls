global class ScheduleZipAndBranchUpdate implements Schedulable{
    
    global void execute(SchedulableContext sc){
        try{ 
            UpdateZipAndBranchIdBatch batchObj = new UpdateZipAndBranchIdBatch();    
            Database.executeBatch(batchObj, 10);
             
        }catch(Exception ex){
            System.debug('Exception in Updating zip and Branch code :::'+ex.getMessage());
        } 
    }
}