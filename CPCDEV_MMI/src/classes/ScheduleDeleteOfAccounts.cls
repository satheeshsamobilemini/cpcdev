global class ScheduleDeleteOfAccounts implements Schedulable,Database.Batchable<SObject>{
        global ScheduleDeleteOfAccounts(){
        }
        global void execute(SchedulableContext SC) {
            Database.executeBatch(new ScheduleDeleteOfAccounts());
        }
        global Database.QueryLocator start(Database.BatchableContext BC){
            return Database.getQueryLocator('select Id from Account where IsCloneInProgress__c = true');    
        }
        global void execute(Database.BatchableContext BC,List<sObject> scope){
            if(scope != null && scope.size() > 0)
                delete scope;
        }
        global void finish(Database.BatchableContext BC){ 
            
        }
}