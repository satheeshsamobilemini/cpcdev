trigger BulkUpdate on Account (before Update) {
  //call to future method not enabled
    //1.Generate set of accountids
  //2. retrieve all Accounts with 3 level manager info
  //3. Add all Account owner ids to a set
  //4. Add all Manager ids to the correct Level set
  //5. Create a Map for User Id to RoleId mapping
  //6. retrieve row for all user ids and manager ids from Sum_Accounts_Without_Callbacks__c 
  //7. Add Sum_Accounts_Without_Callbacks__c  rows to a map
  //8. Loopover all Account owner ids and get the count of accounts without open tasks 
  //    and update Sum_Accounts_Without_Callbacks__c.ownCount__c in Map
  //9. LoopOver all Manager ids, starting from lowest level and for each manager:
  //    a. retrieve his immidiate subordinates totals from Sum_Accounts_Without_Callbacks__c  and sum them
  //    b. Update the sum to Sum_Accounts_Without_Callbacks__c.Count__c in Map
  //10.Upsert Sum_Accounts_Without_Callbacks__c Map values

  // Note- Managers are Handled till Regional manager only
  
  Set<Id> accIds = new Set<Id>();
  Set<String> userIds= new Set<String>();

   //Commented as we dont need toupdate countof Subordiantes and Managers
	    //We will only keep cownt of accounts owned by the user 
/*
  Set<Id> mgrIdsLvl1 = new Set<Id>();
  Set<Id> mgrIdsLvl2 = new Set<Id>();
  Set<Id> mgrIdsLvl3 = new Set<Id>();
*/
  Map<Id,Id> userRoleIdmap = new Map<Id,Id>();
  
  //Create set of AccIds
  if(trigger.isUpdate){
    for(Account acc : trigger.new){
       if(!accIds.contains(acc.Id)){
          accIds.add(acc.Id);
       }
       
    }
  }
  
 
 Map<Id,Integer> accountCountMap = new Map<Id,Integer>();
  
  Set<Id> mgrIds = new Set<Id>();
  //Retrieve accounts  with 3 levels on manager info and add it to a map
  List<Account> accounts = new List<Account>([Select Id, Number_of_Open_Tasks__c, 
         OwnerId ,Owner.UserRoleId, Owner.UserRole.Name,  Owner.ManagerId,
          Owner.Manager.Managerid,Owner.Manager.UserRoleId, Owner.Manager.UserRole.Name,
          Owner.Manager.Manager.Managerid,Owner.Manager.Manager.UserRoleId, Owner.Manager.Manager.UserRole.Name,
          Owner.Manager.Manager.Manager.Managerid,Owner.Manager.Manager.Manager.UserRoleId, Owner.Manager.Manager.Manager.UserRole.Name,
          (Select Id From OpenActivities Limit 1)from Account 
          where Id in :accIds and IsDeleted=false 
          and Owner.Name<>'Branch Account' and Type <> 'Competitor' and Type <> 'Partner'
          and Owner.UserRoleId <> null]);
  for(Account acc : accounts){
    List<OpenActivity> opAct = acc.OpenActivities;
    acc.Number_of_Open_Tasks__c = opAct.size();
    
    //Update acc in Trigger.new
    trigger.newMap.get(acc.Id).Number_of_Open_Tasks__c = opAct.size();
    
    if(acc.Number_of_Open_Tasks__c < 1){
        Integer Count= 1;
        if(accountCountMap.containsKey(acc.OwnerId)){
            Count = accountCountMap.get(acc.OwnerId);
            Count += 1;
        }
        accountCountMap.put(acc.OwnerId,Count);
    }
    if(! userIds.contains(acc.OwnerId)){
      userIds.add(acc.OwnerId );
      addToUserRoleMap(acc.OwnerId, acc.Owner.UserRoleId);
    }
    
       //Commented as we dont need toupdate countof Subordiantes and Managers
	    //We will only keep cownt of accounts owned by the user 
	 /*   
    //Create Sets of UserID, ManagerIds of each level 

    if(acc.Owner.ManagerId <> null && (!mgrIds.contains(acc.Owner.ManagerId)) && acc.Owner.Manager.UserRoleId <> null){
        System.Debug('Parth*** Level1 Manager');
        System.Debug('Parth*** acc.Owner.Manager.UserRole.Name=' + acc.Owner.Manager.UserRole.Name);
        addToManagerIdSets(acc.Owner.Manager.UserRole.Name,acc.Owner.ManagerId);
        addToUserRoleMap(acc.Owner.ManagerId,acc.Owner.Manager.UserRoleId);
        
        if(acc.Owner.Manager.ManagerId <> null && (!mgrIds.contains(acc.Owner.Manager.ManagerId))&& acc.Owner.Manager.Manager.UserRoleId <> null){
            System.Debug('Parth*** Level2 Manager');
            System.Debug('Parth*** acc.Owner.Manager.Manager.UserRole.Name=' + acc.Owner.Manager.Manager.UserRole.Name);
            addToManagerIdSets(acc.Owner.Manager.Manager.UserRole.Name,acc.Owner.Manager.ManagerId);
            addToUserRoleMap(acc.Owner.Manager.ManagerId,acc.Owner.Manager.Manager.UserRoleId);
            
            if(acc.Owner.Manager.Manager.ManagerId <> null && (!mgrIds.contains(acc.Owner.Manager.Manager.ManagerId))&& acc.Owner.Manager.Manager.Manager.UserRoleId <> null){
                System.Debug('Parth*** Level3 Manager');
                System.Debug('Parth*** acc.Owner.Manager.Manager.UserRole.Name=' + acc.Owner.Manager.Manager.UserRole.Name);
                addToManagerIdSets(acc.Owner.Manager.Manager.Manager.UserRole.Name,acc.Owner.Manager.Manager.ManagerId);
                addToUserRoleMap(acc.Owner.Manager.Manager.ManagerId,acc.Owner.Manager.Manager.Manager.UserRoleId);
            }  
        }  
    } */ 
  }
  
    
 //Commented as we dont need toupdate countof Subordiantes and Managers
 //We will only keep cownt of accounts owned by the user 
/*	    
  List<Set<Id>> MgrIdList= new List<Set<Id>>();
  MgrIdList.add(mgrIdsLvl1);
  MgrIdList.add(mgrIdsLvl2);
  MgrIdList.add(mgrIdsLvl3);
  */  
  

   Map<Id, Sum_Accounts_Without_Callbacks__c > MapTotals = new Map<Id, Sum_Accounts_Without_Callbacks__c >();
   Map<Id,Sum_Accounts_Without_Callbacks__c> UpdateTotalList = new Map<Id,Sum_Accounts_Without_Callbacks__c>();
   
    List<List<Sum_Accounts_Without_Callbacks__c>> aggregateList = new List<List<Sum_Accounts_Without_Callbacks__c>>();
    for(List<Sum_Accounts_Without_Callbacks__c> lst : [Select Id,RoleId__c,
            UserId__c,Count__c,ownCount__c from Sum_Accounts_Without_Callbacks__c 
            where UserId__c in :userIds //added as we only need to update counts of accounts owned by the user
            Limit :(Limits.getLimitQueryRows() - Limits.getQueryRows())]){
        if(lst.size()>0){
            for(Sum_Accounts_Without_Callbacks__c obj : lst){
                if(! MapTotals.containskey(obj.UserId__c)){
                    MapTotals.put(obj.UserId__c,obj);
                }
            }
        }
    }
    
    //Update counts
    //1.Update Count of accounts owned by the user which have noopen activities
    
    for(Id userId : userIds){
        Integer count = 0;
        if( accountCountMap.containsKey(userId)){
            count = accountCountMap.get(userId);
        }
        
        //Update Sum_Accounts_Without_Callbacks__c
        Sum_Accounts_Without_Callbacks__c obj;
        if(!MapTotals.containskey(userId)){
            obj = new Sum_Accounts_Without_Callbacks__c(UserId__c = userId, RoleId__c = userRoleIdmap.get(userId),Count__c = 0,ownCount__c = count);
            System.Debug('Parth***NewObj= ' + obj );
        }
        else{
            obj = MapTotals.get(userId );
            System.Debug('Parth***Obj =' +UserId + '**'+ obj);
            /*if(obj.ownCount__c==null){
                obj.ownCount__c = 0;
            }*/
            obj.ownCount__c += count;
        }
        MapTotals.put(userId ,obj);
        UpdateTotalList.put(userId , obj);
    
    }
    
    //Commented as we dont need toupdate countof Subordiantes and Managers
 //We will only keep cownt of accounts owned by the user 
 /*
    //2. Aggregate counts of sub users
    Map<Id,Integer> newCountsMap ;
   for(Integer i=0; i < MgrIdList.size(); i++){
       newCountsMap= new Map<Id,Integer>() ;
       Set<Id> mgrIdset = MgrIdList.get(i);
       if(mgrIdset.size() > 0){
           for(List<User> subUsers : [Select Id, ManagerId  from User where  ManagerId in : mgrIdset  and IsActive=true and Name<>'Branch Account'  Limit :(Limits.getLimitQueryRows() - Limits.getQueryRows())]){
               for(User subUsr : subUsers ){
                    
                    if(! newCountsMap.containskey(subUsr.ManagerId)){
                        newCountsMap.put(subUsr.ManagerId,0);
                    }
                
                    Integer cnt = newCountsMap.get(subUsr.ManagerId);
                    if( MapTotals.containskey(subUsr.Id)){
                        //Get counts of sub user from Totals table
                        Sum_Accounts_Without_Callbacks__c  subuserTotalObj = MapTotals.get(subUsr.Id);
                        System.Debug('subuserTotalObj = '+ subuserTotalObj);
                        //Add them to 
                        cnt  += subuserTotalObj.Count__c.intValue();
                        cnt  += subuserTotalObj.ownCount__c.intValue();
                    }
                    
                    newCountsMap.put(subUsr.ManagerId,cnt);
               }
            }
            //Add The updated count values to The Maptotal
            for(Id id : newCountsMap.keySet() ){
                Sum_Accounts_Without_Callbacks__c obj;
                if(! MapTotals.containskey(id)){
                    obj=new Sum_Accounts_Without_Callbacks__c(UserId__c = id, RoleId__c = userRoleIdmap.get(id),Count__c = newCountsMap.get(id),ownCount__c = 0);
                    System.Debug('Parth****NewObj = '+ obj);
                }
                else{
                    obj = MapTotals.get(id );
                    obj.Count__c = newCountsMap.get(id);
                   
                }  
                System.Debug('Parth****UpdatedObj = '+ obj);
                 MapTotals.put(id ,obj); 
                 UpdateTotalList.put(id , obj);
            }
       }
    }*/
    
    //Update Totals Table
    Upsert UpdateTotalList.values();
        
    
  //function to add UserId - rolemap 
  private void addToUserRoleMap(Id userId, Id roleId){
      if(! userRoleIdmap.containsKey(userId)){
            userRoleIdmap.put(userId,roleId);
        }
  }
  
  //Commented as we dont need toupdate countof Subordiantes and Managers
 //We will only keep cownt of accounts owned by the user 
 /*
  //function To add Managerid into correct level set
  private void addToManagerIdSets(String ManagerRoleName, String ManagerId ){
      mgrIds.add(ManagerId);
      
      if(ManagerRoleName.contains('Sales Manager')){
            mgrIdsLvl1.add(ManagerId );
        }
        else if(ManagerRoleName.contains('Branch Manager')){
            mgrIdsLvl2.add(ManagerId );
        }
        else if(ManagerRoleName.contains('Regional Manager')){
            mgrIdsLvl3.add(ManagerId );
        }
        //else if(ManagerRoleName.contains('SVP Sales')){
        //}
        //else if(ManagerRoleName.contains('Executive Management')){
        //}
        //else if(ManagerRoleName.contains('CEO')){
        //}
  }*/
}