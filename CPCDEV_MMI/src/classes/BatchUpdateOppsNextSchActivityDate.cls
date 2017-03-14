/*************************************************************************
Name : BatchUpdateOppsNextSchActivityDate
Author : Reena Acharya
Date : 4th Sept , 2013
Usage : This class is used to Update Next_Scheduled_Activity__c  on opportunity.
**************************************************************************/
global class BatchUpdateOppsNextSchActivityDate implements Database.Batchable<SObject>{
    public string query{get;set;}
    
    //DataBase.Batchable Start method
    global database.querylocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(query);
    }
    
    //Execute method
    global void execute(Database.BatchableContext BC, LIST<SObject> listData){
        //Get opportunities with coming activity.
        List<Opportunity> opportunities = (List<Opportunity>)listData;
        Map<Id, Opportunity> oppsToUpdate = new Map<Id, Opportunity>();
        oppsToUpdate = ActivityManagement.doCalculationForNextActivity(opportunities , oppsToUpdate );
        database.update(oppsToUpdate.values() , false);
    }
    
    global void finish(Database.BatchableContext BC){
         
    }
   }