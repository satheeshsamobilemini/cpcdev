/**
* (c) 2015 TEKsystems Global Services
*
* Name           : OrphanOpportunityPurge
* Created Date   : 14 Apr,2016
* Created By     : Ankur G (TEK)
* Purpose        : Batch class to delete the opportunities which are not associated with any quote header record.
* 
**/


global class OrphanOpportunityPurge implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext BC) {
        Datetime d = datetime.now().addhours(-1);
        String query = 'select id, name,From_New_Quote__c from Opportunity where Id NOT IN (select Opportunity__c from Quote_Header__c) AND From_New_Quote__c = true AND createddate > 2016-04-03T00:00:00-07:00';
        return Database.getQueryLocator(query);
    }
   
    global void execute(Database.BatchableContext BC, List<Opportunity> scope) {
        delete scope;    
    }   
    
    global void finish(Database.BatchableContext BC) {
    }
}