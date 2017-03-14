global class BatchDodgeProjectUpdateTerritory implements Database.Batchable<SObject>, Database.Stateful{
    
    global Database.queryLocator start(Database.BatchableContext ctx){
        return Database.getQueryLocator([Select d.Zip__c, d.Territory__c, d.Project_Valuation_Low__c, d.Project_Valuation_High__c, d.OwnerId, d.Name, 
                                                d.LastModifiedDate, d.LastModifiedById, d.Job_Profile_URL__c, d.Job_Profile_Status__c, d.Id, d.IsChecked__c, d.CreatedDate, 
                                                d.CreatedById, d.Country__c, d.Branch_ID__c, d.Address_2__c, d.Address_1__c, d.Action_Stage__c 
                                         From Dodge_Project__c d where (d.Territory__c = NULL OR d.Territory__c = '') and (d.Zip__c != NULL) and (d.Zip__c != '')]);
                                         
    }
    
    global void execute(Database.BatchableContext ctx, List<Sobject> scope){
        List<Dodge_Project__c> Dprojlist = (List<Dodge_Project__c>)scope;
        system.debug('------ Dprojlist.size() -----------' + Dprojlist.size());
         if(Dprojlist.size() > 0){
         for(Integer i = 0; i < Dprojlist.size(); i++){
            { Dprojlist[i].IsChecked__c = True;          }
          }
         }   
        ProcessorControl.inFutureContext = true;
        List<Database.SaveResult> dsrs = Database.update(Dprojlist, false);
    }
    
    global   void finish(Database.BatchableContext ctx){    
    }
}