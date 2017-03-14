public without sharing class NSCSweepUtil {
    private static Map<String, Branch_Lookup__c> allBranches = new Map<String, Branch_Lookup__c>();
    private static Map<String, User> ownersForAccount = new Map<String, User>();
    private static String BRANCH_ACCOUNT = 'Branch Account';
    private static String NSC_ACCOUNT = 'NSC Account';
    private static Map<Id, User> userUpdateMap = new Map<Id, User>();
    private static User NSCSweepIBExceptionUser = new User();
    private static Id TaskDefaultrecordTypeId;
    
    static{
        for(User usr : [Select id from User where userRole.name =  :system.label.NSC_Sweep_IB_Exception_User]){
                NSCSweepIBExceptionUser = usr;   
        }   
        TaskDefaultrecordTypeId = Task.SObjectType.getDescribe().getRecordTypeInfosByName().get('Standard Task').getRecordTypeId();
        
        AssignmentRules.isNSCSweepRunning = true;        
    }
    
    public static void processNonConstructionOpportunities(List<Opportunity> opportunities){
        Set<Id> opportunityIdsForProcess = initialize(opportunities,false);
        Branch_Lookup__c branch;
        Set<Id> accountIds = new Set<Id>();
        Map<Id, Account> accountMap = new Map<Id, Account>();
        Map<Id, Contact> contactMap = new Map<Id, Contact>();
        Map<Id, Opportunity> opportunityMap = new Map<Id, Opportunity>();
        List<Task> taskToBeUpdate = new List<Task>();
        ownersForAccount = loadOwnerForAccount();
        for(Opportunity opp : opportunities){
            if(opp.is_NSC_Processed__c){
                if(!opp.isClosed){
                    for(Task t : opp.tasks){
                        t.OwnerId = opp.ownerId;
                        taskToBeUpdate.add(t);
                     }
                     createTasks(null,opp);
                     opportunityMap.put(opp.Id,opp);
                }else
                    opportunityMap.put(opp.Id,new Opportunity(Id = opp.Id, is_NSC_Processed__c = true));    
            }
            else{
                system.debug('test-->Not processed===');
                opportunityMap.put(opp.Id,new Opportunity(Id = opp.Id, is_NSC_Processed__c = true));
                
                if(allBranches.containsKey(opp.Servicing_Branch__c)){
                    branch =  allBranches.get(opp.Servicing_Branch__c);
                }    
                            
                String country = branch != null ? branch.Country__c : 
                                (opp.Account.ShippingCountry != null ? opp.Account.ShippingCountry :  
                                (opp.Account.BillingCountry != null ? opp.Account.BillingCountry : ''));
                                
                Boolean hasOwnerChanged = runAssignmentAlgoForNonConstructOpportunity(opp,branch,country);   
                
                //T-58665
                // If no SB on Oppty and Account does not have country -> currently then this should go to IB Manager- Roger (custom setting we alredy have) 
                if(!hasOwnerChanged){
                    opp.ownerId = NSCSweepIBExceptionUser.Id;
                    opp.is_NSC_Processed__c = true; 
                }
                
                //I-27605 
                if(!opp.isClosed){
                    system.debug('If not closed====');
                    opportunityMap.put(opp.id, opp);
                    if(hasOwnerChanged){
                        if(opp.tasks.size() > 0){
                        for(Task t : opp.tasks){
                                t.OwnerId = opp.ownerId;
                                taskToBeUpdate.add(t);
                            }
                        }
                        createTasks(null,opp);
                    }    
                    
                    //added for T-79604
                    if(opp.AccountId != null){
                        if(!accountMap.containsKey(opp.AccountId)){
                            if(opp.Account.Industry != null && opp.Account.Industry.contains(System.Label.Home_Owner_Account)){
                                accountMap.put(opp.AccountId , new Account(id = opp.AccountId, OwnerId = ownersForAccount.get(BRANCH_ACCOUNT).id));
                            }else{
                                //changed by Najma on 11 feb 2013 for #00039637 changed NSC to Branch
                               // accountMap.put(opp.AccountId , new Account(id = opp.AccountId, OwnerId = ownersForAccount.get(NSC_ACCOUNT).id));
                                accountMap.put(opp.AccountId , new Account(id = opp.AccountId, OwnerId = ownersForAccount.get(BRANCH_ACCOUNT).id));
                            }
                           
                        }
                        
                    }                                   
                }//added for T-79604
                else if(opp.isWon && opp.AccountId != null && !accountMap.containsKey(opp.AccountId)){
                    //added  If condition for 00035442
                    system.debug('If closed=====');
                    if(opp.Account.Industry != null && opp.Account.Industry.contains(System.Label.Home_Owner_Account)){
                        //changed by Najma on 11 feb 2013 for #00039637 changed NSC to Branch
                         //accountMap.put(opp.AccountId , new Account(id = opp.AccountId, OwnerId = ownersForAccount.get(NSC_ACCOUNT).id));
                         accountMap.put(opp.AccountId , new Account(id = opp.AccountId, OwnerId = ownersForAccount.get(BRANCH_ACCOUNT).id));
                    }
                    else{
                    accountMap.put(opp.AccountId , new Account(id = opp.AccountId, OwnerId = opp.ownerId));
                    createTasks(accountMap.get(opp.AccountId),opp);
                    }
                }               
            }  
        }
          
            
        update opportunityMap.values();
        
        if(taskToBeUpdate.size() > 0){
            update taskToBeUpdate;
        }
        
        //commented for T-79604
        /*for(Contact con : [select id, name , AccountId, Account.name , Account.OwnerId,Account.Industry from contact where AccountId in : accountIds]){
            if(con.Account.Industry != null && con.Account.Industry.contains(System.Label.Home_Owner_Account)){
                contactMap.put(con.id, new Contact(Id = con.id , OwnerId = ownersForAccount.get(BRANCH_ACCOUNT).id));
            }else{
                contactMap.put(con.id, new Contact(Id = con.id , OwnerId = ownersForAccount.get(NSC_ACCOUNT).id));
            }
        }*/
        
        //added for T-79604
        for(Contact con : [select id, name , AccountId from contact where AccountId in : accountMap.keyset()]){
            contactMap.put(con.id, new Contact(Id = con.id , OwnerId = accountMap.get(con.AccountId).ownerid));
        }
        
        if(accountMap.size() > 0){
            update accountMap.values();
        }
        if(contactMap.size() > 0){
            update contactMap.values();
        }
        
        if(newTasks.size() > 0 ){
            insert newTasks;
        }
        if(userUpdateMap.size() > 0){
            update userUpdateMap.values();
        }
        Messaging.sendEmail(notificationEmails);
    }
    
     private static Set<Id> initialize(List<Opportunity> opportunities, Boolean isContruction){
         Set<String> branches = new Set<String>();
         Set<Id> opportunityIdsForProcess = new Set<Id>();
        for(Opportunity opp : opportunities){
            if((opp.Account.Owner.isActive) && !(opp.Account.Owner.Name == 'NSC Account' || opp.Account.Owner.Name == 'Branch Account' || (opp.Account.Owner.UserRoleId != null && opp.Account.Owner.UserRole.Name.Contains('Inbound')) )){
                opp.OwnerId = opp.Account.OwnerId;  
                opp.is_NSC_Processed__c = true;              
            }
            else if(opp.Servicing_Branch__c != null && (opp.Servicing_Branch__c.startsWith('1') || opp.Servicing_Branch__c.startsWith('9') || (opp.Servicing_Branch__c.startsWith('2') && opp.Servicing_Branch__c != '298'))){
                branches.add(opp.Servicing_Branch__c);
                opportunityIdsForProcess.add(opp.Id);
            }else if(isContruction){
                opp.ownerId = NSCSweepIBExceptionUser.Id;
                opp.is_NSC_Processed__c = true;
            }
        }
        if(!isContruction){  
            branches.add('298');
            branches.add('777');
        }
        system.debug('bharti===branches====' + branches);
        allBranches = GetAllBranchLookups(branches);
         system.debug('bharti===branches====' + allBranches );
        AssignmentRules.GetAllSellingRegions(branches);
        AssignmentRules.FillCountryBranchTeamCodeMap();
        AssignmentRules.allUsers = AssignmentRules.GetAllUsers(branches);
        return  opportunityIdsForProcess;
     }
     
     
    /* public static void runAssignmentAlgo(List<Lead> objNewList)
    {
      
      for(Lead newLead : unassignedleadList) 
      {   
        AssignmentRules.applyAssignmentAlgoForLead(newLead);
      
      }
            
      //email('megh.agar@gmail.com','lead list >>>'+unassignedleadList);
      //update objNewList;
      update AccountUpdateList.values();
      update UserUpdateList.values();
      insert assignmentLogsList;
      
    }*/ 
    
    
    //Fills the Branch Lookup Collection
    private static Map<String,Branch_Lookup__c> GetAllBranchLookups(Set<String> branches)
    {       system.debug('======' + branches);
        
        //commented for T-79604
        //I-28214
        //AssignmentRules.timeZones = new Set<String>();       
        
        Map<String,Branch_Lookup__c>  tempAllBranches = new Map<String,Branch_Lookup__c>();
        String dynamisBranchLookupQueryString = 'SELECT b.Time_Zone__c, b.Zip__c, b.Branch_Name__c, b.Branch_Code__c ,b.Country__c, '+
                               ' b.NSC_Team__c, b.NSC_Team_Live__c,b.Sales_Manager_ID__c,b.National_Account_Manager_ID__c '+
               ' FROM Branch_Lookup__c b WHERE  b.Branch_Code__c in : branches ';
        System.debug('---Query----'+dynamisBranchLookupQueryString);      
        for(Branch_Lookup__c branch:Database.query(dynamisBranchLookupQueryString)){
          tempAllBranches.put(branch.Branch_Code__c, branch);
        }
        
        System.debug('---------PR-07809--------'+allBranches);
        //added for PR-05727 and get all the user which is inactive sales and national manager
        return tempAllBranches;
    }
    
    //Runs the Assignment algorithm for opportunity
    private static Boolean runAssignmentAlgoForNonConstructOpportunity(Opportunity opp, Branch_Lookup__c branch, String country)
    {
           opp.is_NSC_Processed__c = true; 
           System.debug(':::::AssignmentRules.allUsers::::'+AssignmentRules.allUsers);
           
           //T-58665
           User salesRep = branch != null? AssignmentRules.getAvailableSellingRegionUser(branch) :
                                           AssignmentRules.getAvailableSalesRep(opp.Servicing_Branch__c,branch,'',country,'',null);
                                           
           System.debug(':::::salesRep::::'+salesRep);
           
           if(salesRep != null){   
                opp.OwnerId = salesRep.Id;
                if(!opp.IsClosed){                                
                    salesRep.LastOpptyAlocation__c = Datetime.now();
                    if(!userUpdateMap.containsKey(salesRep.Id))
                    {
                        userUpdateMap.put(salesRep.Id,salesRep);
                    }
                }
                return true;
           }          
           
           return false;         
         
    }
    private static Map<String,User> loadOwnerForAccount(){
        Map<String, User> tempUserMap = new Map<String, User>();
        for(User usr : [select id , Name from User where Name in (:BRANCH_ACCOUNT,:NSC_ACCOUNT)]){
            tempUserMap.put(usr.Name , usr);
        }
        return tempUserMap;
    } 
    
    public static void processConstructionOpportunities(List<Opportunity> opportunities){
        Set<Id> opportunityIdsForProcess = initialize(opportunities,true);
        
        Branch_Lookup__c branch;
        //Set<Id> accountIds = new Set<Id>();
        Map<Id, Account> accountMap = new Map<Id, Account>();
        Map<Id, List<Contact>> contactMapWithAccountId = new Map<Id, List<Contact>>();
        Map<Id, Opportunity> opportunityMap = new Map<Id, Opportunity>();
        List<Task> taskToBeUpdate = new List<Task>();
        Set<Id> processedAccountId = new Set<Id>();
        for(Opportunity opp : opportunities){
            if(!accountMap.containsKey(opp.AccountId) && (!opp.is_NSC_Processed__c || opp.ownerId != opp.Account.OwnerId)){
                accountMap.put(opp.AccountId , new Account(id = opp.AccountId));
            }
        }
        for(Contact con : [select id, name , AccountId, Account.name , Account.OwnerId,Account.Industry from contact where AccountId in : accountMap.keySet()]){
            
            if(!contactMapWithAccountId.containskey(con.AccountId)){
                contactMapWithAccountId.put(con.AccountId, new List<Contact>());
            }
            contactMapWithAccountId.get(con.AccountId).add(new Contact(Id = con.Id));
        }
        for(Opportunity opp : opportunities){
           
            //If Account is owned by ISR, and Oppty closed(won) by IB, schedule a task with normal priority to Account Owner.
            //if account has already been processed then dont process it again for a close opportunity
            if(processedAccountId.contains(opp.accountId) && opp.isClosed){
                opportunityMap.put(opp.Id,new Opportunity(Id = opp.Id, is_NSC_Processed__c = true));
                opp.Account = accountMap.containsKey(opp.accountId)? accountMap.get(opp.accountId) : opp.Account;
                createTasks(null ,opp);
            } 
            else{               
                if(!opp.is_NSC_Processed__c){
                    if(opp.Servicing_Branch__c != null){
                    branch =  allBranches.get(opp.Servicing_Branch__c);
                    }
                    if(allBranches.containsKey(opp.Servicing_Branch__c)){
                        branch =  allBranches.get(opp.Servicing_Branch__c);
                    }else {
                        branch = null; 
                    }
                    runAssignmentAlgoForConstructOpportunity(opp,accountMap.get(opp.accountId),contactMapWithAccountId.get(opp.accountId));
                }               
                
                if(opp.AccountId != null && accountMap.containsKey(opp.AccountId)){
                    accountMap.get(opp.accountId).OwnerId = opp.OwnerId;
                }
                processedAccountId.add(opp.AccountId);
                
                if(!opp.isClosed){
                    opportunityMap.put(opp.id, opp);
                    if(opp.tasks.size() > 0){
                        for(Task t : opp.tasks){
                            t.ownerId = opp.ownerId;
                            taskToBeUpdate.add(t);
                        }
                    }    
                    createTasks(accountMap.containsKey(opp.accountId)? accountMap.get(opp.accountId): opp.Account ,opp);            
                }else{
                    opportunityMap.put(opp.Id,new Opportunity(Id = opp.Id, is_NSC_Processed__c = true));
                    opp.Account = accountMap.containsKey(opp.accountId)? accountMap.get(opp.accountId) : opp.Account;
                    createTasks(null ,opp);    
                }      
            }     
        }
        
        update opportunityMap.values();
        if(taskToBeUpdate.size() > 0){
            update taskToBeUpdate;
        }
        if(userUpdateMap.size() > 0){
            update userUpdateMap.values();
        }
        if(accountMap.size() > 0){
            update accountMap.values();
        }
        
        if(newTasks.size() > 0 ){
            insert newTasks;
        }
        
        if(contactMapWithAccountId.size() > 0){
            List<Contact> contacts = new List<Contact>();
            for(Id accId : contactMapWithAccountId.keySet()){
                contacts.addAll(contactMapWithAccountId.get(accId));
            }
            update contacts;
        }
        
        Messaging.sendEmail(notificationEmails);
                
    }
    
     //Runs the Assignment algorithm for opportunity
    private static void runAssignmentAlgoForConstructOpportunity(Opportunity opp,Account account,List<Contact> contacts)
    {
       System.debug(':::::AssignmentRules.allUsers::::'+AssignmentRules.allUsers);
       if(opp.servicing_Branch__c != null){
            User salesRep = AssignmentRules.getAvailableSalesRep(opp.Servicing_Branch__c,null,'','','',null);
            System.debug(':::::salesRep::::'+salesRep);
            if(salesRep == null){
                //TO Do
                salesRep = NSCSweepIBExceptionUser;
            }
            //else{
              //assignAccount,contacts and Opportunities to Sales rep 
                opp.OwnerId = salesRep.Id;
                account.ownerId = salesRep.id;
                if(contacts != null && contacts.size() > 0){
                    for(Contact con : contacts){
                        con.ownerId = salesRep.id;
                    }
                }
                if(!opp.IsClosed){                                
                    salesRep.LastOpptyAlocation__c = Datetime.now();
                    if(!userUpdateMap.containsKey(salesRep.Id))
                    {
                        userUpdateMap.put(salesRep.Id,salesRep);
                    }
                }
            //}
            opp.is_NSC_Processed__c = true;
        }
    }
    
    //Method to create a new task after a construction account is moved through NSC sweep
    //T-21291 
    private static list<Task> newTasks = new list<Task>();
    private static List<Messaging.SingleEmailMessage> notificationEmails = new List<Messaging.SingleEmailMessage>(); 
    private static void createTasks(Account account,Opportunity oppty){
        String mailBody = '';
        Id ownerId;
        if(account != null){
            Task task1 = new Task();
            task1.Subject = 'Review Account moved from Inbound';
            task1.Call_Type__c = 'OB - Sales/Customer Service';
            task1.RecordTypeId = TaskDefaultrecordTypeId;
            task1.WhatId =  account.Id;   
            task1.OwnerId = account.ownerId;
            task1.Priority  =  oppty.IsClosed ? 'Normal' : 'High';
            // Case 00040379 by Hemlata 
            task1.ActivityDate = System.today();
            newTasks.add(task1);
            mailBody += 'This account is assigned to you. Click the following link to view this Account in Salesforce:\n';
            mailBody += System.Label.Organization_URL + account.id + '\n';
            ownerId = account.ownerId;
        }
        
        if(oppty != null){
            if(!oppty.IsClosed){
                Task task2 = new Task();
                task2.Subject = 'Review Opportunity moved from Inbound';
                task2.Call_Type__c = 'OB - Sales/Customer Service';
                task2.RecordTypeId = TaskDefaultrecordTypeId;
                task2.WhatId =  oppty.Id;   
                task2.OwnerId = oppty.ownerId;
                task2.Priority  =  'High';
                // Case 00040379 by Hemlata
                if (oppty.NSC_Sweep_Date__c != null ) {
                    task2.ActivityDate = date.newinstance(oppty.NSC_Sweep_Date__c.year(), oppty.NSC_Sweep_Date__c.month(), oppty.NSC_Sweep_Date__c.day());
                }    
                newTasks.add(task2);
                mailBody += 'This Opportunity is assigned to you. Click the following link to view this Opportunity in Salesforce:\n';
                mailBody += System.Label.Organization_URL + oppty.id + '\n';
                ownerId = oppty.ownerId;
            }else if(account == null){
                 Task task1 = new Task();
                 task1.Subject = 'Won Opportunity From IB – Call for more business';
                 task1.Call_Type__c = 'OB - Sales/Customer Service';
                 task1.RecordTypeId = TaskDefaultrecordTypeId;
                 task1.WhatId =  oppty.account.Id;   
                 task1.OwnerId = oppty.account.ownerId;
                 task1.Priority  =  'Normal';
                 // Case 00040379 by Hemlata                
                 task1.ActivityDate = System.today();                  
                 newTasks.add(task1);
                 mailBody += 'Won Opportunity From IB – Call for more business. Click the following link to view this Opportunity in Salesforce:\n';
                 mailBody += System.Label.Organization_URL + oppty.Id + '\n';
                 ownerId = oppty.account.ownerId;
            }
        }
        
        system.debug('====' + newTasks);
                    
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setTargetObjectId(ownerId);
        mail.setSubject('Record Moved');
        mail.setPlainTextBody(mailBody);      
        mail.setSaveAsActivity(false);    
        notificationEmails.add(mail);           
    }
}