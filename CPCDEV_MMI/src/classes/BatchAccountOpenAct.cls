global class BatchAccountOpenAct implements Database.Batchable<SObject>, Database.Stateful{
    
    global Database.queryLocator start(Database.BatchableContext ctx){
        return Database.getQueryLocator([select Id, Number_of_Open_Tasks__c, 
          OwnerId ,Owner.UserRoleId, Owner.UserRole.Name,  Owner.ManagerId,
          Owner.Manager.Managerid,Owner.Manager.UserRoleId, Owner.Manager.UserRole.Name,
          Owner.Manager.Manager.Managerid,Owner.Manager.Manager.UserRoleId, Owner.Manager.Manager.UserRole.Name,
          Owner.Manager.Manager.Manager.Managerid,Owner.Manager.Manager.Manager.UserRoleId, Owner.Manager.Manager.Manager.UserRole.Name,
          (Select Id,OwnerId,Owner.IsActive,Owner.Name From OpenActivities order by ActivityDate ASC, LastModifiedDate DESC)from Account 
          where IsDeleted=false 
          and Owner.Name<>'Branch Account' and Type <> 'Competitor' and Type <> 'Partner'
          and Owner.UserRoleId <> null]);
    }
    
    global   void execute(Database.BatchableContext ctx, List<Sobject> scope){
        Integer count = 0;
        List<Account> accs = (List<Account>)scope;
        system.debug('------------ accs.size() ----------------' + accs.size());
         for(Integer i = 0; i < accs.size(); i++){
            count = 0 ;
            List<OpenActivity> opAct = accs[i].OpenActivities;
             for(OpenActivity oa : opAct){
                 if(oa.Owner.IsActive == True)
                    { count ++ ;   }
              }
              accs[i].Number_of_Open_Tasks__c = count;
         }   
        
        ProcessorControl.inFutureContext = true;
        List<Database.SaveResult> dsrs = Database.update(accs, false);
    }
    
    global   void finish(Database.BatchableContext ctx){    
    }
}