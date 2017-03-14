/**
* (c) 2015 TEKsystems Global Services
*
* Name           : BranchLookupHistoryBatch
* Created Date   : 22 Feb,2015
* Created By     : Sreenivas M (TEK)
* Purpose        : Batch class to create a history records for existing Branch lookup records
* 
**/

global class BranchLookupHistoryBatch implements Database.Batchable<sObject>
{
 //global final String Query;
 
 public BranchLookupHistoryBatch()
 {
   //query = q;
 }
 
 global Database.QueryLocator start(Database.BatchableContext bc)
 {
  
  return Database.getQueryLocator([SELECT id,zip__c,Territory__c FROM Branch_Lookup__c]);

 }
 
 global void execute (Database.BatchableContext BC, list<Branch_Lookup__c> listBranchlookup)
 {
    List<Branch_Lookup_History__c> listHistRecordstoInsert = new List<Branch_Lookup_History__c>();
    for(Branch_Lookup__c bl :listBranchlookup)
    {
     Branch_Lookup_History__c blh = new Branch_Lookup_History__c();
     blh.Branch_Lookup__c = bl.id;
     blh.Start_Date__c = System.date.newInstance(2016, 01, 01);
     blh.Territory__c = bl.Territory__c;
     blh.Zip__c = bl.Zip__c;
     blh.isActive__c = true;
     listHistRecordstoInsert.add(blh);
    }
    try
    {
     insert listHistRecordstoInsert;
    }
    Catch(Exception e)
    {
    System.debug('Exception in excute method..'+e);
    }
 
 }
 
 global void finish(Database.BatchableContext BC)
 {

 }

 
}