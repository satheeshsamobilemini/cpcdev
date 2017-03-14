global class ScheduleBranchSnapshotReminder implements Schedulable{
    
    global void execute(SchedulableContext sc){
        try{ 
            BranchSnapshotReminderBatchProcess batch = new BranchSnapshotReminderBatchProcess(null,DateTime.now()); 
            Database.executeBatch(batch, 100);
             
        }catch(Exception ex){ 
            System.debug('Exception in reminder for branch snapshot ::'+ex.getMessage());
        } 
    }
}