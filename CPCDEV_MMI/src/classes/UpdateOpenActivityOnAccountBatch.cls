/*******************************************************************
Name : UpdateOpenActivityOnAccountBatch
Created By : Appirio Offshore (Akanksha)
Created Date : 25 September 2013
Description : Batch class ro update the  other accounts open activity count

**********************************************************************/
global class UpdateOpenActivityOnAccountBatch implements Database.Batchable<sObject>{
    public String dataQuery;
    public List<String> st = new List<String>{'Completed','Deferred'};
        global UpdateOpenActivityOnAccountBatch() {
            
            //customersQuery = 'select id, whatID from Task where status != \'Completed\' AND status != \'Deferred\'';
            dataQuery = 'Select id, (Select Id, IsTask, Status From OpenActivities) From Opportunity';
            
        }
    
    global Database.QueryLocator start(Database.BatchableContext info){
        if(test.isRunningTest()){
            dataQuery += ' LIMIT 1' ;
        }
        system.debug('@@@'+dataQuery);
        return Database.getQueryLocator(dataQuery);
    }
    
    global void execute(Database.BatchableContext info, List<Opportunity> oppData){
        
        List<Opportunity> oppToUpdate = new List<Opportunity>();
        for(Opportunity opp : oppData)
        {
            opp.OpenActivities__c = opp.OpenActivities.size();
            oppToUpdate.add(opp);
        }
        /*Set<Id> OppIdList = new Set<Id>();
            for(Task tsk : taskData)
            {
            string tempId = string.valueOf(tsk.WhatId);
            if(tempId != null && tempId != '' && tempId.startsWith('006'))
            OppIdList.add(tsk.whatId);
            }
            
            if(OppIdList.size() > 0)
            {
            for(Opportunity opp : [select id,OpenActivities__c from Opportunity where id in : OppIdList and (OpenActivities__c = 0 or OpenActivities__c = null)])
            {
            if(opp.OpenActivities__c != null && opp.OpenActivities__c != 0)
            {
            opp.OpenActivities__c = opp.OpenActivities__c+1;
            }
            else
            {
            opp.OpenActivities__c = 1;
            }
            oppToUpdate.add(opp);
            }
            }*/
        if(oppToUpdate.size() > 0)
        {
            upsert oppToUpdate;
        } 
        
    }
    global void finish(Database.BatchableContext info){
        
    }
    
    @isTest
    public static void TestUpdateOpenActivityOnAccountBatch(){
        UpdateOpenActivityOnAccountBatch kamBatch = new UpdateOpenActivityOnAccountBatch();
        //donationbatch.donationQuery += ' limit 10';
        Account acc = New Account();
        acc.Name='Test Account';
        //acc.ownerid=salesRep1.Id;
        insert acc;
        
        Opportunity Opp = New Opportunity();
        Opp.Name = 'Test APEX Opportunity'; 
        Opp.AccountID = acc.Id;
        Opp.StageName = 'Quoted - No Decision'; 
        Opp.CloseDate = Date.newInstance(2009,07,30);
        insert Opp;
        
        Test.startTest();
        
        Database.executeBatch(kamBatch, 1);
        Test.stopTest();
    }
    
}