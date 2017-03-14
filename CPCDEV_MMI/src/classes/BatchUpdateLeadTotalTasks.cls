global class BatchUpdateLeadTotalTasks implements Database.Batchable<sObject>{
   global String qString;
   global Boolean isTest = false;
   
  global BatchUpdateLeadTotalTasks(String qs, Boolean isTest)
  {     this.qString = qs;
        this.isTest = isTest;
  } 
     
   global Database.QueryLocator start(Database.BatchableContext BC){
     if(!isTest)
     { 
       String qString = 'Select id,Total_Tasks__c,Owner.isActive,(select id,status,isTask from OpenActivities where isTask = true and status = \'Completed\') from Lead where Owner.isActive = True and isConverted = false'; 
     }  
      system.debug('------ qString ----------------' + qString); 
      return Database.getQueryLocator(qString);
   }

   global void execute(Database.BatchableContext BC,List<sObject> scope){
     List<Lead> LDlist = (List<Lead>)scope;
     Integer count = 0;
     
     system.debug('---------- Lead size -------' + LDlist.size());
     
     for(integer i = 0; i< LDlist.size(); i++)
      { List<OpenActivity> Olist = LDlist[i].OpenActivities;
         count = Olist.size();
        LDlist[i].Total_Tasks__c = count; 
      }
      
    system.debug('---------- Leads to Update -------' + LDlist.size());
     update LDlist;   
   }

   global void finish(Database.BatchableContext BC){

   }

}