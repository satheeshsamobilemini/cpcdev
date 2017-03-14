global class ScheduleSafetyAttachmentReminder implements Schedulable{
    
    global void execute(SchedulableContext sc){
        try{ 
            SafetyAttachmentReminderBatchProcess batch = new SafetyAttachmentReminderBatchProcess(null);    
            Database.executeBatch(batch, 20);
             
        }catch(Exception ex){
            System.debug('Exception in reminder for Safety Attachment :::'+ex.getMessage());
        } 
    }
}