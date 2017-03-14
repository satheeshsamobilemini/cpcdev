global class BatchAccountSICCode implements Database.Batchable<SObject>, Database.Stateful{
    
    global Database.queryLocator start(Database.BatchableContext ctx){
        return Database.getQueryLocator([select Id, SIC_code__c  from Account where SIC_code__c  != null and isChecked__c = false]);
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope){
    	 List<Account> accs = (List<Account>)scope;
        
        for(Account acc : accs){
        	acc.isChecked__c = true;
        } 
        ProcessorControl.inFutureContext = true;
        List<Database.SaveResult> dsrs = Database.update(accs, false);
    }

   global void finish(Database.BatchableContext BC){
   }
}