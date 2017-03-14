public class MaintainBranchAccounts {
    Public Map<String, ID> branchQueues = New Map<String, ID>();
    
    
    public static Map<id, User> usersToUpdate = new Map<id, User>();

    Public Static VOID addAccountsToQueue(List<Account> addAccountToQueue, List<String> branchCode, map<ID,String> mapAccIdETSbranch){

        system.debug('------ map--------------' + mapAccIdETSbranch);
        Map<String, ID> branchQueues = New Map<String, ID>();
        map<String, ID> branchQueuesETS = new map<String, ID>();    // TFS 3873
        ID OwnerIdETS;                        // TFS 3873
        
        MaintainBranchAccounts.getBranchCodes(branchQueues, branchQueuesETS);  // TFS 3873
        
        system.debug('------ queue--------------' + branchQueuesETS);
        
        List<Branch_Account__c> listBA = New List<Branch_Account__c>();
        
        Boolean branchQueueIDFound = true;
        
        for (integer i=0;i<addAccountToQueue.size();i++){
        
          if(!mapAccIdETSbranch.containskey(addAccountToQueue[i].ID)){
          
            // See if we have a null or branch code that does not exist
            branchQueueIDFound = branchQueues.containsKey(branchCode[i]);
            if (branchQueueIDFound == false){
                branchCode[i] = '000';
            }
            
            Branch_Account__c ba = New Branch_Account__c(Account__c = addAccountToQueue[i].Id, OwnerID = branchQueues.get(branchCode[i]));  
            system.debug('-----ba------------'+ba);  
            listBA.add(ba);
          } 
         else{ 
              OwnerIdETS = branchQueuesETS.get(mapAccIdETSbranch.get(addAccountToQueue[i].ID));
              OwnerIdETS = (OwnerIdETS <> NULL)? OwnerIdETS : branchQueuesETS.get('000');
              Branch_Account__c ba = New Branch_Account__c(Account__c = addAccountToQueue[i].Id, OwnerID = OwnerIdETS);  
               system.debug('-----ba------------'+ba);  
              listBA.add(ba);
          }       
        }       
      
        insert listBA;
        
    }
    
    Public Static VOID removeAccountsFromQueue(List<Id> removeAccountFromQueue){
    
        Branch_Account__c[] ba = [Select ID from Branch_Account__c where Account__c in :removeAccountFromQueue];
        
        delete ba;
    
    }
    
    Public Static VOID getBranchCodes(Map<String, ID> branchQueues, map<String, ID> branchQueuesETS){
        List<QueueSobject> myQueues = new List<QueueSobject>(); 
            myQueues = [Select Queue.Id, Queue.Name from QueueSobject WHERE Queue.Name like :('Branch Accounts -%')];
        
        for (integer i=0;i<myQueues.size();i++){
          if(!myQueues[i].Queue.Name.contains('ETS') && !myQueues[i].Queue.Name.contains('WMI')) // TFS 3873
            { branchQueues.put(myQueues[i].Queue.Name.subString(18, 21), myQueues[i].Queue.Id);  }
          else
            {  if(myQueues[i].Queue.Name.contains('3163') && myQueues[i].Queue.Name.contains('Corpus'))    // TFS 3873,4850
                 { branchQueuesETS.put(myQueues[i].Queue.Name.substring(21,25),myQueues[i].Queue.Id); }
               else if(myQueues[i].Queue.Name.contains('3023')||myQueues[i].Queue.Name.contains('3159'))  // TFS 3873,4850
                 { branchQueuesETS.put(myQueues[i].Queue.Name.substring(23,27),myQueues[i].Queue.Id); }  
               else if(myQueues[i].Queue.Name.contains('Exception'))     // TFS 3873,4850
                 {  branchQueuesETS.put('000',myQueues[i].Queue.Id);}
               else{ branchQueuesETS.put(myQueues[i].Queue.Name.substring(24,28).trim(),myQueues[i].Queue.Id);  } // TFS 3873,4850
            }
        }
     }
    
    /* TFS-2013
    //Added By Akanksha for Story S-151272
    @future
    public static void updateUser(Map<Id,boolean> userIdAndAddFlag)
    {
        for(User usr : [select id, Total_Accounts__c from User where id in: userIdAndAddFlag.keySet()])
        {
            system.debug('@@@usr'+usr);
        if(userIdAndAddFlag.get(usr.id))
        {
            if(usersToUpdate.containsKey(usr.id))
            {
                User userData = usersToUpdate.get(usr.id);
                userData.Total_Accounts__c = userData.Total_Accounts__c+1;
                usersToUpdate.put(userData.id, userData);
            }
            else
            {
                if(usr.Total_Accounts__c != null)
                    usr.Total_Accounts__c = usr.Total_Accounts__c+1;
                else
                    usr.Total_Accounts__c = 1;
                
                usersToUpdate.put(usr.id, usr);
            }
        }
        else
        {
            if(usersToUpdate.containsKey(usr.id))
            {
                User userData = usersToUpdate.get(usr.id);
                userData.Total_Accounts__c = userData.Total_Accounts__c-1;
                usersToUpdate.put(userData.id, userData);
            }
            else
            {
                usr.Total_Accounts__c = usr.Total_Accounts__c-1;
                usersToUpdate.put(usr.id, usr);
            }
            
        }
    }
    system.debug('@@@'+usersToUpdate);
    if(usersToUpdate.size() > 0)
    {
    // Modified by Yeturu for story(MIXED_DML_OPERATION, DML operation on setup object is not permitted after you have updated a non-setup object (or vice versa))
        if(Test.isRunningTest()) {
            System.runAs(new User(Id = Userinfo.getUserId())) {
                update usersToUpdate.values();
            }
        }else {
           update usersToUpdate.values();
        }  
    }
    }
    //End By Akanksha for Story S-151272
    TFS-2013 */
    
    // TFS-2013 
    @future
    public static void updateUser(Map<Id,boolean> userIdAndAddFlag)
    {   
        map<ID,Integer> mapUserCount = new map<ID,Integer>();
        
        List<AggregateResult> aResults = [select count(ID) UserCount, OwnerID UserID from Account where OwnerID IN: userIdAndAddFlag.keyset() and parentID = null GROUP BY OwnerID];
        
        for(AggregateResult a : aResults)
         {  
            system.debug('------ Count value ---------------' + a.get('UserCount'));
            system.debug('----------- User ID ------------' + a.get('UserID'));
            mapUserCount.put((ID)a.get('UserID'),(Integer)a.get('UserCount'));
         }   
         
        for(User u : [select ID,Total_Accounts__c from User where Id IN: mapUserCount.keyset()])
         {  
            u.Total_Accounts__c = (Integer)mapUserCount.get(u.ID);
            usersToUpdate.put(u.ID,u);
         } 
                   
        system.debug('@@@'+usersToUpdate);
         if(usersToUpdate.size() > 0)
         {
   // Modified by Yeturu for story(MIXED_DML_OPERATION, DML operation on setup object is not permitted after you have updated a non-setup object (or vice versa))
          if(Test.isRunningTest()) {
          System.runAs(new User(Id = Userinfo.getUserId())) 
           {   update usersToUpdate.values();  }
         }else 
           {  update usersToUpdate.values();  }  
       }
    }
}