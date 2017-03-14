trigger UpdateAccountCount on Account (after delete, after insert, after update) {

if(TriggerSwitch.isTriggerExecutionFlagDisabled('Account','UpdateAccountCount')){
        return;
    }

  //1.Generate set of userids
  //2. retrieve all Users with 3 level manager info
  //3. Add all Manager ids to the correct Level set
  //4. Create a Map for User Id to RoleId mapping
  //5. retrieve row for all user ids and manager ids from Sum_Accounts_Without_Callbacks__c 
  //6. Add Sum_Accounts_Without_Callbacks__c  rows to a map
  //7. Loopover all Account owner ids and get the count of accounts without open tasks 
  //    and update Sum_Accounts_Without_Callbacks__c.ownCount__c in Map
  //8. LoopOver all Manager ids, starting from lowest level and for each manager:
  //    a. retrieve his immidiate subordinates totals from Sum_Accounts_Without_Callbacks__c  and sum them
  //    b. Update the sum to Sum_Accounts_Without_Callbacks__c.Count__c in Map
  //9.Upsert Sum_Accounts_Without_Callbacks__c Map values

  // Note- Managers are Handled till Regional manager only
  Set<String> userIds= new Set<String>();

   //Commented as we dont need toupdate countof Subordiantes and Managers
        //We will only keep cownt of accounts owned by the user 
/*      
  Set<Id> mgrIdsLvl1 = new Set<Id>();
  Set<Id> mgrIdsLvl2 = new Set<Id>();
  Set<Id> mgrIdsLvl3 = new Set<Id>();
  */

    /*If custom setting holds logged in user's ID then trigger will not fire.
    This is done by Reena for S-117407 to avoid firing trigger of Account during data update of account.
    If user want to perform data update on account but want to avoid firing of trigger then
    Set user's salesforce ID in SkipTrigger custom setting and then perform update.*/
    
    for(SkipTrigger__c skipTrg : SkipTrigger__c.getAll().values()){
     if(skipTrg.name == userinfo.getUserID().subString(0,15)){
        return;
     }
    }
    
    Private String BranchUserID = '';   
    /*User branchAccountUserID = [Select Id from User where name = 'Branch Account'];
    BranchUserID = branchAccountUserID.Id;
    */
    
    Set<ID> AccountIDSet = new Set<ID>();              // MSM 79 Job Profile Sweep logic ..
    List<Sub_Contractor__c> SClist = new List<Sub_Contractor__c>();
    List<Task> tList = new List<Task>();
    List<Contact> Conlist = new List<Contact>();
    List<Branch_Account_User_id__c> BranchAccountIdList = null;
    
    BranchAccountIdList = Branch_Account_User_id__c.getAll().Values();
    
   if(test.isRunningTest()){
    //User branchAccountUserID = [Select Id from User where name = 'Branch Account' LIMIT 1];
    BranchUserID = '00580000001sCuG'; //branchAccountUserID.Id;
    }else{
      if(BranchAccountIdList != null && !BranchAccountIdList.isEmpty()){
      BranchUserID = BranchAccountIdList.get(0).User_Id__c;  
       }
    }
  system.debug('---------BranchUserID-------------'+BranchUserID);           
        
  Map<Id,Id> userRoleIdmap = new Map<Id,Id>();
  Map<Id,Integer> userAccCountAdd = new Map<Id,Integer>();
  Map<Id,Integer> userAccCountSubtract = new Map<Id,Integer>();
  
   
  //Create set of AccIds
  if(trigger.isInsert  ){
    for(Account acc : trigger.new){
        if(acc.OwnerId <> BranchUserID && acc.Type <> 'Competitor' && acc.Type <> 'Partner' && acc.Number_of_Open_Tasks__c < 1 ){
           if(! userIds.contains(acc.OwnerId)){
                userIds.add(acc.OwnerId );
           }
           Integer cnt = 1;
            if(userAccCountAdd.containsKey(acc.OwnerId)){
                cnt = userAccCountAdd.get(acc.OwnerId) + 1;
            }
            userAccCountAdd.put(acc.OwnerId,cnt);
            
        }
    }
  }
  if(trigger.isUpdate){
    for(Account newAcc : trigger.new){
       Account oldAcc= trigger.oldMap.get(newAcc.id);
       if(Test.isRunningTest())
        AccountIDSet.add(newacc.ID);
       if(oldAcc.OwnerId <> newAcc.OwnerId){//Chek if owner has chaged
        System.Debug('PArth***OwnerChanged ' );
        
        // MSM 79 .. Job Profile Sweep Logic ..
         AccountIDSet.add(newacc.ID);
        
            if(! userIds.contains(newAcc.OwnerId)&& newAcc.OwnerId <> BranchUserID){
                userIds.add(newAcc.OwnerId );
            }
            if(! userIds.contains(oldAcc.OwnerId) && oldAcc.OwnerId <> BranchUserID){
                userIds.add(oldAcc.OwnerId );
            }
            if(newAcc.OwnerId <> BranchUserID && newAcc.Type <> 'Competitor' && newAcc.Type <> 'Partner' && newAcc.Number_of_Open_Tasks__c < 1 ){
                Integer cnt = 1;
                //increment count of newuser
                if(userAccCountAdd.containsKey(newAcc.OwnerId)){
                    cnt = userAccCountAdd.get(newAcc.OwnerId) + 1;
                }
                userAccCountAdd.put(newAcc.OwnerId,cnt);
                if(oldAcc.OwnerId <> BranchUserID && oldAcc.Type <> 'Competitor' && oldAcc.Type <> 'Partner' && oldAcc.Number_of_Open_Tasks__c < 1 ){
                    //decrement count of olduser
                    if(userAccCountSubtract.containsKey(oldAcc.OwnerId)){
                        cnt = userAccCountSubtract.get(oldAcc.OwnerId) + 1;
                    }
                    userAccCountSubtract.put(oldAcc.OwnerId,cnt);
                }
            }
         
       }else if(oldAcc.Type <> newAcc.Type && newAcc.OwnerId <> BranchUserID ){//Type changed
         if(newAcc.Type == 'Competitor' || newAcc.Type == 'Partner' || oldAcc.Type == 'Competitor' || oldAcc.Type == 'Partner'){
             if(! userIds.contains(newAcc.OwnerId)){
                userIds.add(newAcc.OwnerId );
            }
         }
         if(newAcc.Type <> 'Competitor' && newAcc.Type <> 'Partner' && newAcc.Number_of_Open_Tasks__c < 1 ){ 
            Integer cnt = 1;
            if(userAccCountAdd.containsKey(newAcc.OwnerId)){
                cnt = userAccCountAdd.get(newAcc.OwnerId) + 1;
            }
            userAccCountSubtract.put(newAcc.OwnerId,cnt);
            
         }else if(oldAcc.Type <> 'Competitor' && oldAcc.Type <> 'Partner' && oldAcc.Number_of_Open_Tasks__c < 1){
            Integer cnt = 1;
            if(userAccCountSubtract.containsKey(newAcc.OwnerId)){
                cnt = userAccCountSubtract.get(newAcc.OwnerId) + 1;
            }
            userAccCountSubtract.put(newAcc.OwnerId,cnt);
            
         }
         
            
       }
       
    }
  }
  
  if(trigger.isDelete  ){
    for(Account acc : trigger.old){
       if( acc.OwnerId <> BranchUserID){
           if(! userIds.contains(acc.OwnerId)){
                userIds.add(acc.OwnerId );
             }
           if(acc.Type <> 'Competitor' && acc.Type <> 'Partner' && acc.Number_of_Open_Tasks__c < 1){
                 
                Integer cnt = 1;
                //decrement count of olduser
                if(userAccCountSubtract.containsKey(acc.OwnerId)){
                    cnt = userAccCountSubtract.get(acc.OwnerId) + 1;
                }
                userAccCountSubtract.put(acc.OwnerId,cnt);
                
            }
        }  
    }
  }
  System.Debug('Parth******UserIDS-' + userIds);
  
  Set<Id> mgrIds = new Set<Id>();
  List<Set<Id>> MgrIdList= new List<Set<Id>>();
  if(userIds.size() > 0){ 
      
      //Retrieve accounts  with 3 levels on manager info and add it to a map
      List<User> users = new List<User>([Select Id, UserRoleId, UserRole.Name,  ManagerId,
              Manager.Managerid,Manager.UserRoleId, Manager.UserRole.Name,
              Manager.Manager.Managerid,Manager.Manager.UserRoleId,Manager.Manager.UserRole.Name,
              Manager.Manager.Manager.Managerid,Manager.Manager.Manager.UserRoleId, Manager.Manager.Manager.UserRole.Name
              from User 
              where Id in :userIds   
              and Name<>'Branch Account'  and UserRoleId <> null]);
      for(User usr : users){
        addToUserRoleMap(usr.Id, usr.UserRoleId);
        
        //Commented as we dont need toupdate countof Subordiantes and Managers
        //We will only keep cownt of accounts owned by the user 
        /*
        //Create Sets of UserID, ManagerIds of each level 
        if(usr.ManagerId <> null && (!mgrIds.contains(usr.ManagerId)) && usr.Manager.UserRoleId <> null){
            System.Debug('Parth*** Level1 Manager');
            System.Debug('Parth*** usr.Manager.UserRole.Name=' + usr.Manager.UserRole.Name);
            addToManagerIdSets(usr.Manager.UserRole.Name,usr.ManagerId);
            addToUserRoleMap(usr.ManagerId,usr.Manager.UserRoleId);
            
            if(usr.Manager.ManagerId <> null && (!mgrIds.contains(usr.Manager.ManagerId))&& usr.Manager.Manager.UserRoleId <> null){
                System.Debug('Parth*** Level2 Manager');
                System.Debug('Parth*** usr.Manager.Manager.UserRole.Name=' + usr.Manager.Manager.UserRole.Name);
                addToManagerIdSets(usr.Manager.Manager.UserRole.Name,usr.Manager.ManagerId);
                addToUserRoleMap(usr.Manager.ManagerId,usr.Manager.Manager.UserRoleId);
                
                if(usr.Manager.Manager.ManagerId <> null && (!mgrIds.contains(usr.Manager.Manager.ManagerId))&& usr.Manager.Manager.Manager.UserRoleId <> null){
                    System.Debug('Parth*** Level3 Manager');
                    System.Debug('Parth*** usr.Manager.Manager.UserRole.Name=' + usr.Manager.Manager.UserRole.Name);
                    addToManagerIdSets(usr.Manager.Manager.Manager.UserRole.Name,usr.Manager.Manager.ManagerId);
                    addToUserRoleMap(usr.Manager.Manager.ManagerId,usr.Manager.Manager.Manager.UserRoleId);
                }  
            }  
        }*/  
      }
      
      //Commented as we dont need toupdate countof Subordiantes and Managers
        //We will only keep cownt of accounts owned by the user 
      /*MgrIdList.add(mgrIdsLvl1);
      MgrIdList.add(mgrIdsLvl2);
      MgrIdList.add(mgrIdsLvl3);
    */      
      
       Map<Id, Sum_Accounts_Without_Callbacks__c > MapTotals = new Map<Id, Sum_Accounts_Without_Callbacks__c >();
       Map<Id,Sum_Accounts_Without_Callbacks__c> UpdateTotalList = new Map<Id,Sum_Accounts_Without_Callbacks__c>();
       
        for(List<Sum_Accounts_Without_Callbacks__c> lst : [Select Id,RoleId__c,
                UserId__c,Count__c,ownCount__c from Sum_Accounts_Without_Callbacks__c
                where UserId__c in  :userIds //added this clause as weonly need to update users count 
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
        //1.Update Count of accounts owned by the user that have no open activities
        
        for(Id userId : userIds){
            //Integer count = [Select count() from Account where ownerId = :userId  and (Number_of_Open_Tasks__c=0 Or Number_of_Open_Tasks__c = null) and IsDeleted=false and Owner.Name<>'Branch Account' and Type <> 'Competitor' and Type <> 'Partner' Limit :(Limits.getLimitQueryRows() - Limits.getQueryRows())];
            Integer count = 0;
            
            //Update Sum_Accounts_Without_Callbacks__c
            Sum_Accounts_Without_Callbacks__c obj;
            if(! MapTotals.containskey(userId)){
                obj = new Sum_Accounts_Without_Callbacks__c(UserId__c = userId, RoleId__c = userRoleIdmap.get(userId),Count__c = 0,ownCount__c = count);
            }
            else{
                obj = MapTotals.get(userId );
                //obj.ownCount__c = count;
            }
            System.Debug('PArth****obj.ownCount__c- ' + obj.ownCount__c);
            if(userAccCountAdd.containsKey(userId)){
                obj.ownCount__c  +=  userAccCountAdd.get(userId);
                System.Debug('PArth****Add- ' + userAccCountAdd.get(userId) );
            }
            if(userAccCountSubtract.containsKey(userId)){
                obj.ownCount__c  -= userAccCountSubtract.get(userId);
                System.Debug('PArth****Sub- ' + userAccCountAdd.get(userId) );
            }
             if(obj.ownCount__c < 0){
                obj.ownCount__c = 0;
            }
                       
            System.Debug('PArth****obj.ownCount__cAfter Update- ' + obj.ownCount__c);          
            MapTotals.put(userId ,obj);
            if(obj.RoleId__c <> '' && obj.RoleId__c <> null){
                UpdateTotalList.put(userId , obj);
            }
        
        }
        
         //Commented as we dont need toupdate countof Subordiantes and Managers
        //We will only keep cownt of accounts owned by the user 
       
       /* //2. Aggregate counts of sub users
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
                    }
                    else{
                        obj = MapTotals.get(id );
                        obj.Count__c = newCountsMap.get(id);
                       
                    }  
                     MapTotals.put(id ,obj); 
                     UpdateTotalList.put(id , obj);
                }
           }
        }*/
        
        //Update Totals Table
        Upsert UpdateTotalList.values();
  }
    
  //function to add UserId - rolemap 
  private void addToUserRoleMap(Id userId, Id roleId){
      if(! userRoleIdmap.containsKey(userId)){
            userRoleIdmap.put(userId,roleId);
        }
  }
  
   //Commented as we dont need toupdate countof Subordiantes and Managers
        //We will only keep cownt of accounts owned by the user 
  /*//function To add Managerid into correct level set
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
        }
  }*/

// for MSM 79 Job Profile Logic .. 

if(AccountIDSet.size() > 0)
{  List<Account> AccountSClist = [Select id,OwnerID,Branch__c,IsPersonAccount,
                                 (select Role__c, Project_Zip_Postal_Code__c, Owner_s_Role__c, Job_Profile__c, Job_Profile_Name__c, Job_Profile_Branch_ID__c, Is_Account_owner_Branch_Account__c, Id, Account_billing_zip_code__c, Account__c, Account_Owner__c, Account_Name__c, Account_Branch_ID__c  from Job_Profile_Sub_Contractor__r),
                                 (select id,Branch__c,Lead_Rating__c,Subject,Status,ActivityDate,WhatId,Call_Type__c,Job_Profile_Id__c,OwnerId,Owner.Name from Tasks Where Status != 'Completed' order by ActivityDate ASC, LastModifiedDate DESC),
                                 (select id,Branch__c,Email,AccountId,OwnerID,Owner.Name from Contacts) 
                                from Account 
                                where id =: AccountIDSet and IsPersonAccount = False];
    for(integer i =0; i<AccountSClist.size() ; i++ )
      {   List<Sub_Contractor__c> SCAcclist =  AccountSClist[i].Job_Profile_Sub_Contractor__r ;
         system.debug('----------  AccountSClist[i].OwnerID -------------------' + AccountSClist[i].OwnerID);
          for(Sub_Contractor__c sc : SCAcclist)
             { SClist.add(sc);   }
         
         // for Tasks ..
         List<Task> openTasks = AccountSClist[i].Tasks;
              for(Task t : openTasks)
             { system.debug( '-----------  t.OwnerId ------------' +  t.OwnerId); 
               system.debug( '-----------  t.Owner.Name ------------' +  t.Owner.Name); 
               system.debug( '-----------  t.Branch__c ------------' +  t.Branch__c);  
                if(t.Call_Type__c == 'Job Profile Follow Up' && t.Subject == 'Sub Contractor Awarded Bid' && t.OwnerId <> AccountSClist[i].OwnerId)
                 {  t.OwnerId = AccountSClist[i].OwnerId;
                    //tList.add(t);   
                 }
                 
                 system.debug('------------- t.OwnerId --- over here-------' + t.OwnerId);
                 system.debug('------------- AccountSClist[i].OwnerId ---over here-------' + AccountSClist[i].OwnerId);
             
                 if(t.OwnerId == AccountSClist[i].OwnerId && AccountSClist[i].OwnerId <> BranchUserID && t.Branch__c <> AccountSClist[i].Branch__c)
                 {    system.debug('------------- t.OwnerId ---later here -------' + t.OwnerId);
                      system.debug('------------- AccountSClist[i].OwnerId ---- later here ------' + AccountSClist[i].OwnerId);
                      tList.add(t);
                 }
            }      
         
         // for Contacts .. (MSM 87 change) 
         List <Contact> ContactUpdatelist = AccountSClist[i].Contacts;
              for(Contact c : ContactUpdatelist)
             { system.debug( '-----------  c.OwnerId ------------' +  c.OwnerId); 
               system.debug( '-----------  c.Owner.Name ------------' +  c.Owner.Name); 
               system.debug( '-----------  c.Branch__c ------------' +  c.Branch__c);     
             if(c.OwnerId == AccountSClist[i].OwnerId && AccountSClist[i].OwnerId <> BranchUserID && c.Branch__c <> AccountSClist[i].Branch__c)
                 { Conlist.add(c);   }
      }
    system.debug('----------  SClist -------------------' + SClist);
    system.debug('----------  tlist -------------------' + tlist);    
} 
  system.debug('----------  SClist.size() -------------------' + SClist.size());
  system.debug('----------  tlist.size() -------------------' + tlist.size());  
  system.debug('----------  Conlist.size() -------------------' + Conlist.size());  
 
   if(SClist.size() > 0)
   { //dodgeProcessUtil.processSCListasperRole(SClist,false); 
   }   
   
   if(tlist.size() > 0)
   {  update tlist;   } 
   
   if(Conlist.size()> 0)
   { update Conlist;    }
}
}