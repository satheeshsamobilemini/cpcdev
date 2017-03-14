/************************************************************************************************
Name : DeleteInactiveContactBatchProcessor
Created By : Appirio Offshore
Created Date : 4 April , 2010
Usage : This batch apex find inactive contact.
*************************************************************************************************/
global class DeleteInactiveContactBatchProcessor implements Database.Batchable<sObject>{
    
    public String contactQuery; 
    global DeleteInactiveContactBatchProcessor (){
        contactQuery = 'Select Id,Name,(select id from tasks where IsRecurrence  = true) from Contact where Inactivate_will_be_deleted__c = true or Name like \'Lead-%\' ';
        
    }  
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(contactQuery);
    }
    global void execute(Database.BatchableContext BC, List<Contact> scope){
        try{
            System.debug('--Scope111111--'+scope);
            if(scope != null && scope.size() >0){
                System.debug('--Scope--'+scope);
                for(Contact cont : scope){
                    for(Task tsk : cont.Tasks){
                       database.delete(tsk, false);
                    }
                }
                database.DeleteResult[] results = database.delete(scope , false);
                List<Contact> contacts = new List<Contact>();
                for(Database.DeleteResult res : results){
                   if((!res.isSuccess()) && res.getId() != null){                   
                      contacts.Add(new Contact (id =res.getID(), ErrorComment__c = res.getErrors().get(0).Message));
                   }
                }
                update contacts;
            }
        }catch(Exception ex){
            System.debug('--Exception While Creating Net Promoter Calculation Score ---'+ex);
        }
            
    }
    
    global void finish(Database.BatchableContext BC){}
    
}