/************************************************************************************************
Name : SchedulerForDeleteInactivateContact
Created By : Appirio Offshore
Created Date : 4 April , 2010
Usage : This class runs every friday and calls
         a batch process to find inactive contact.
***************************************************************************************************/
global class SchedulerForDeleteInactiveContact implements Schedulable{
    global void execute(SchedulableContext SC){ 
        DeleteInactiveContactBatchProcessor  deleteInactiveContact = new DeleteInactiveContactBatchProcessor();
        Database.executeBatch(deleteInactiveContact, 200);
    }
}