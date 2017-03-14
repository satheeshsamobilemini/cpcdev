global class UpdateAccountCountOfUserBatch implements Database.Batchable<sObject>{
    
    public String projectsQuery;
    
    global UpdateAccountCountOfUserBatch() {
       //projectsQuery = 'select id,Total_Accounts__c from User';                                         TFS-2013
         projectsQuery = 'select id,Total_Accounts__c,isActive from User where isActive = True';        //TFS-2013 
        }

    global Database.QueryLocator start(Database.BatchableContext info){
         if(test.isRunningTest()){
            projectsQuery += ' LIMIT 1' ;
        }
        return Database.getQueryLocator(projectsQuery);
    }
    
    global void execute(Database.BatchableContext info, List<User> userData){
      //List<id> userIdList = new List<id>();                                                            TFS-2013 
        Set<id> userIdSet = new Set<id>();                                                             //TFS-2013   
        List<User> usersToUpdate = new List<User>();
        for(User user : userData)
        {
          //userIdList.add(user.id);                                                                     TFS-2013       
            userIdSet.add(user.id);                                                                    //TFS-2013     
        }
      //for (AggregateResult ar : [select count(Id) accCount, OwnerId userId from Account where ownerId in :userIdList and parentId = '' Group By OwnerId])  TFS-2013
        for (AggregateResult ar : [select count(Id) accCount, OwnerId userId from Account where ownerId in :userIdSet and parentId = '' Group By OwnerId]) //TFS-2013  
        {
            
            system.debug('--------------'+(Id)ar.get('userId') + '****'+ (Integer)ar.get('accCount'));  
            User userNew = new User(id = (Id)ar.get('userId'), Total_Accounts__c = (Integer)ar.get('accCount'));
            usersToUpdate.add(userNew);                 
        }   
        system.debug('--------------usersToUpdate'+usersToUpdate);
        if(usersToUpdate.size() > 0)    
        {
            update usersToUpdate;
        }   
    
    }
   
     global void finish(Database.BatchableContext info){
        
    }
    
    @isTest
    public static void UpdateAccountCountOfUserBatchTest(){
       UpdateAccountCountOfUserBatch userBatch = new UpdateAccountCountOfUserBatch();
       //donationbatch.donationQuery += ' limit 10';
       Test.startTest();
       Database.executeBatch(userBatch, 1);
       Test.stopTest();
   }



}