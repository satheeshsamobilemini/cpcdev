global Class BatchUpdateJobProfileTerritory implements Database.Batchable <sObject>{
 
  global BatchUpdateJobProfileTerritory(){   
  // Constructor 
  }

  global Database.QueryLocator start(Database.BatchableContext bc){
   String jbQuery = 'select Id,Job_Site_Zip__c,Job_Site_Country__c,Branch_ID__c,Territory__c,isTerritoryUpdate__c from Job_Profile__c where isTerritoryUpdate__c = false AND (Territory__c = \'\' OR Territory__c = null)';
    return Database.getQueryLocator(jbQuery); 
  }
  global void execute(Database.BatchableContext bc, List<sObject> sObjList){
    List<Job_Profile__c> jbList = new List<Job_Profile__c>();
      for(sObject s : sObjList)
      {  Job_Profile__c jb = (Job_Profile__c)s;
         jb.isTerritoryUpdate__c = true;
         jbList.add(jb); 
         system.debug('---- ID ------' + jb.Id);
      }
     
     system.debug('------- JB List -------------' + jblist.size());
      
     update jbList;
  }
  
  global  void finish(Database.BatchableContext bc){}

}