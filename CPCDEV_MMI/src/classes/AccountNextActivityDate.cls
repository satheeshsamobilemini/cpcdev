public without sharing class AccountNextActivityDate {

    /*
    
        Used by TaskSetAccountNextAcivityDate.trigger
    
    */

    public static void GetNextActivityDate (List <Id> listAcct, List <Id> listOppty){
    
        Map <Id, Id> mapOpptyToAcct = New Map <Id, Id>();
        Map <Id, Account> mapIDToAcct = New Map <Id, Account>();
        
        List <Account> acctsToUpdate = New List <Account>();
     
        // See if we have any Opportunity IDs
        // If we do, get the associated Account so we can add the Account ID to our list of Acct Ids
        
        Opportunity[] oppty = [Select Id, AccountId from Opportunity where Id in :listOppty and AccountId != null ];
        
        for (Opportunity op : oppty){
        
            listAcct.Add(op.AccountId);
        
        }
        
        // Clear this list -- we will reuse it
        listOppty.clear();
        
        // Get a list of Opportunities associated for each Account in our List
        oppty = [Select Id, AccountId from Opportunity Where AccountId In :listAcct];
        
        for (Opportunity op : oppty){
        
            listAcct.Add(op.AccountId);
            listOppty.Add(op.Id);
            
            mapOpptyToAcct.put(op.Id, op.AccountId);
        
        }
        
        // Get a list of Accounts with Next_Activity_Date__c
        Account[] acct = [Select Id, Next_Activity_Date__c, Number_of_Open_Tasks__c from Account where Id in :listAcct];
        
        for (Account a : acct){
        
            /*
        
            if (a.Number_of_Open_Tasks__c <= 0){
                // This handles the event where all tasks have been deleted/closed
                a.Next_Activity_Date__c = NULL;
            }
            
            */
            
            // Set Next_Activity_Date__c to NULL -- if any Open tasks exist, it will be overwritten with Task.ActivityDate
            // If this is not NULL -- the date can never be updated unless a new task with an earlier date is inserted/updated 
            a.Next_Activity_Date__c = NULL;
            mapIDToAcct.put(a.Id, a);
        }
        
        system.debug('$$$$$$$$$$$$$ --> mapIDToAcct = ' + mapIDToAcct);
        
        // Get a a list of Open tasks related to either our Accounts or Opportunities
        
        Integer remainingQueryRows = 10000 - Limits.getQueryRows();
        System.Debug('>>>>>>>Account list'+listAcct+'>>>listOppty '+listOppty);
        Task[] taskList = [Select Id, ActivityDate, WhatId from Task WHERE ( (WhatId in :listAcct OR WhatId in :listOppty) AND IsClosed = False) Order By ActivityDate ASC LIMIT :remainingQueryRows];
    
        System.debug('$$$$$$ --> taskList.size() = ' + taskList.size());
        System.debug('$$$$$$ --> listOppty = ' + listOppty);
        System.debug('$$$$$$ --> listAcct = ' + listAcct);
    
        Date NextActivityDate = null;
        Boolean isOpportuty = false;
        Account currentAcct = New Account();
    
        for (Task t : taskList){
        
            system.debug('$$$$$$$$ --> t.Id = ' + t.Id);
            System.Debug('$$$$$$$$ --> t.WhatId = ' + t.WhatId);

            // Reset this value
            NextActivityDate = null;
        
            // Is this related to an account or opportunity?
            isOpportuty = mapOpptyToAcct.containsKey(t.WhatId);
            
            system.debug('$$$$$$$$$ --> isOpportuty = ' + isOpportuty);
            
            if (isOpportuty == TRUE){
            
                currentAcct = mapIDToAcct.get(mapOpptyToAcct.get(t.WhatId));
            
                if (currentAcct != NULL && currentAcct.Next_Activity_Date__c != NULL){
            
                    NextActivityDate = currentAcct.Next_Activity_Date__c;
    
                }
                
                if (NextActivityDate == NULL){
                    mapIDToAcct.get(mapOpptyToAcct.get(t.WhatId)).Next_Activity_Date__c = t.ActivityDate;
                }
                
                else if (NextActivityDate > t.ActivityDate){
                    mapIDToAcct.get(mapOpptyToAcct.get(t.WhatId)).Next_Activity_Date__c = t.ActivityDate;
                }           
                
                System.debug('$$$$$$$$$ --> Before: ' + NextActivityDate + ' - After: ' + mapIDToAcct.get(mapOpptyToAcct.get(t.WhatId)).Next_Activity_Date__c);     

            }
            else{
            
                currentAcct = mapIDToAcct.get(t.WhatId);
            
                if (currentAcct != NULL && currentAcct.Next_Activity_Date__c != NULL){
            
                    NextActivityDate = currentAcct.Next_Activity_Date__c;

                }
                if (NextActivityDate == NULL && mapIDToAcct.get(t.WhatId) != NULL){
                    mapIDToAcct.get(t.WhatId).Next_Activity_Date__c = t.ActivityDate;
                }
                else if (NextActivityDate > t.ActivityDate && mapIDToAcct.get(t.WhatId) != NULL ){
                    mapIDToAcct.get(t.WhatId).Next_Activity_Date__c = t.ActivityDate;
                }                       
                
            }
            
        }
    
        
        acctsToUpdate = mapIDToAcct.values();
        //Added by Najma on 7 feb 2013
        If(!Test.isRunningTest())
        update acctsToUpdate;
    
        
        
        /*
        // New Direction
        
        Sub_Contractor__c[] subc = [Select Id, Next_Activity_Date__c, Account__c From Sub_Contractor__c where Account__c in : mapIDToAcct.keySet() and Job_Profile__r.Project_Stage_Status__c <> 'Completed'];
    
        for (Sub_Contractor__c sc : subc){
        
            sc.Next_Activity_Date__c = mapIDToAcct.get(sc.Account__c).Next_Activity_Date__c;
        
        }
        
        update subc;
        
        */
    
    }

}