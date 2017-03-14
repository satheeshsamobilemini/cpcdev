global class AccountMethods {

   /*public static Set<String> getUserRoleSet(){
        Set<String> tempSet = new Set<String>();
        tempSet.add('Sales Rep - 131 - Milwaukee');
        tempSet.add('Territory Sales Mgr - 131 - Milwaukee');
        tempSet.add('Sales Rep - 131 - Milwaukee');
        tempSet.add('Territory Sales Mgr - 131 - Milwaukee');
        tempSet.add('Branch Manager - 131/175 - Milwaukee/Mad');
        tempSet.add('Sales Rep - 187 - Newberry');
        tempSet.add('Branch Manager - 159/187- Worcester/NB');
        tempSet.add('Territory Sales Mgr - 147 - Boston');
        return tempSet;
   }*/

    webService static VOID ChangeAccountOwner(String accountId, String OwnerId){
       // Set<String> allowUserRoles = getUserRoleSet();
        Account a = [Select Id, OwnerId, IsTakeOwnerShip__c,IsConvertedAccount__c FROM Account where Id = :accountId];
        User owner;
        for(User usr : [select Id,UserRoleId, UserRole.Name from User where id =: OwnerId limit 1]){
            owner = usr;
        }        
        a.OwnerId = OwnerId;
        a.IsTakeOwnerShip__c = true;
       // system.debug('---OwnerRole--'+owner.UserRole.Name+'--'+allowUserRoles.contains(owner.UserRole.Name));
        //if(owner.UserRole.Name != null && allowUserRoles.contains(owner.UserRole.Name)){
          //  a.IsConvertedAccount__c = false;
        //}else{
            a.IsConvertedAccount__c = true;
        //}
        
        Update a;
    
    } 
    
    // This method is to change Account Owner of ETS Accounts
     webService static String ChangeETSaccOwner(String aID, String uID, String apName){
       String msg = '';
             
       Account a = [select ID,Approver_ETS__c,ApproverEmail_ETS__c,Branch_Account_Approval_Status__c,ApprovalRequester_ETS__c,OwnerID,ApprovalRequesterName_ETS__c from Account where Id=: aID LIMIT 1];
       
       a.Approver_ETS__c = null;
       a.ApproverEmail_ETS__c = null;
       
       for(User u : [select ID,UserRole.Name,Email,ManagerId,Manager.Email from User where Id =: uID and ManagerId <> null])
          {   a.Approver_ETS__c = u.ManagerId;        // assign to account Owner Manager
              a.ApproverEmail_ETS__c = (u.Manager.Email <> null && u.Manager.Email <> '') ? u.Manager.Email : '';
          }
          
         if(a.Branch_Account_Approval_Status__c <> 'Approved')
         {  a.ApprovalRequester_ETS__c = uID; 
            a.ApprovalRequesterName_ETS__c = apName;
         } 
                 
                           
        update a;
       
       if(a.Branch_Account_Approval_Status__c <> 'Approved' && !Test.isRunningTest()){
       // start a approval process
       Approval.Processsubmitrequest ap = new Approval.Processsubmitrequest();
       ap.setObjectId(a.id);
       String rID = ap.getSubmitterId();
       system.debug('------------ rID ----------' + rID);
       Approval.Processresult result = Approval.process(ap); 
       msg = 'Approval Process';
     }
      
      return msg; 
    }
    
    /* This method assign account to sales manager and send a mail to sales manager */
    
    webservice static String sendToNSC(String accountId){
        Account account;
        String message = '';
        Savepoint savePoint = Database.setSavepoint();
        try{
            for(Account acc : [select Id, OwnerId, Name, Branch__c,Servicing_Branch_Id__c from Account where id = : accountId limit 1]){
                account = acc;
            }
            
            if(account != null && account.Branch__c != null){
                if(account.Servicing_Branch_Id__c == null){
                     message = 'Please update the Servicing Branch in order to send an account to NSC';
                }else{
                    account = loadNewOwnerId(account);
                    List<Opportunity> oppList = [Select o.OwnerId, o.AccountId
                                                 From Opportunity o
                                                 Where o.AccountId = :account.Id
                                                 AND o.ownerId = :account.ownerId
                                                 AND stageName in ('Quoted - No Decision','Not Quoted')];                                
                    if(account.ownerId != null){
                        sendNotidicationMail(account,account.ownerId,false,oppList);  
                        message = 'Account was successfully sent to NSC';              
                    }else{
                        message = 'There is no sales Manager related to account \'s branch Id';
                    }
                }
                
                System.debug('---Account NSC---'+account);
            }
        }catch(Exception ex){
            Database.rollback(savePoint);
            message = 'Account was not sent to NSC . Due to : '+ex.getMessage();
        }
        System.debug('---Message---'+message);
        return message;
    }
     
    webservice static String sendToBranch(Id accountId){
        Savepoint savePoint = Database.setSavepoint();
        String message = '';
        try{
            Account account = AssignmentRules.runAssignmentAlgoForAccount(accountId,true);
            
            List<Opportunity> oppList = [Select o.OwnerId, o.AccountId
                                           From Opportunity o
                                           Where o.AccountId = :account.Id
                                           and stageName in ('Quoted - No Decision','Not Quoted')];
          
            //for(Account acc : [select Id, OwnerId, Name, Branch__c from Account where id = : accountId limit 1]){
           //     account = acc;
           // }
            if(account != null){
                sendNotidicationMail(account, account.OwnerId,false , oppList);
            }  
            message = 'Account was successfully sent to Branch Rep'; 
            System.debug('---Account Branch---'+account);
        }catch(Exception ex){
            Database.rollback(savePoint);
            message = 'Account was not sent to Branch . Due to : '+ex.getMessage();
        }
        return message;
    }
    
    public static void sendNotidicationMail(Account account,Id newOwnerId, Boolean isNSC , list<Opportunity> oppList){
        system.debug('=======account====='+account);
        String email = '';
        for(User usr :[Select Email from user where id = :newOwnerId] ){
           // email = 'nikita.jain.poly@gmail.com';
            system.debug('======usr.email==='+usr.email);
            email = usr.Email;
        }               
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setTargetObjectId(newOwnerId);
        mail.setToAddresses(new String []{email});        
       // mail.setToAddresses(new String []{'nikita.jain.poly@gmail.com'});
        mail.setSubject('Account Notification');
        mail.setPlainTextBody(loadBody(account,isNSC,oppList));      
        mail.setSaveAsActivity(false);      
        Messaging.sendEmail(new Messaging.SingleEmailMessage [] {mail});        
        createTask(newOwnerId , account);
    } 
    
    //Method for creation of new task
    public static void createTask(Id newOwnerId , Account account){
        Task tsk = new Task();
        tsk.OwnerId = newOwnerId;  
        tsk.Subject = 'Account Notification';
        tsk.WhatId =  account.Id;                         
        insert tsk;
        system.debug('=================task========='+tsk.Id);
    }
    
    
    /*public static Id loadNewOwnerId(String branchId){
        Id ownerId;
        for(Branch_Lookup__c branch : [select Id, Name, zip__c,Country__c, Branch_Code__c,Sales_Manager_ID__c,US_NSC_Sales_Manager_ID__c from Branch_Lookup__c  where Branch_Code__c = : branchId and ((Sales_Manager_ID__c != null or Sales_Manager_ID__c != '') or (US_NSC_Sales_Manager_ID__c != null or US_NSC_Sales_Manager_ID__c != '')) limit 1 ]){
            if(branch.Country__c != null && branch.Country__c.equals('UK')){
                ownerId = branch.Sales_Manager_ID__c;
            }else if (branch.Country__c.equals('US')){
                ownerId = branch.US_NSC_Sales_Manager_ID__c;
            }
        }
        return ownerId;
    }*/
    
    public static Account loadNewOwnerId(Account acc){
        for(Branch_Lookup__c branch : [select Id, Name, zip__c,Country__c, Branch_Code__c,Sales_Manager_ID__c,US_NSC_Sales_Manager_ID__c from Branch_Lookup__c  where Branch_Code__c = : acc.Branch__c and ((country__c = 'UK') AND (Sales_Manager_ID__c != null or Sales_Manager_ID__c != '')) limit 1 ]){
            
            if(branch.Country__c != null && branch.Country__c.equals('UK')){
                acc.ownerId = branch.Sales_Manager_ID__c;                
                update acc;
                return acc;
            }
        }
        acc = AssignmentRules.runAssignmentAlgoForAccount(acc.Id,false);
        return acc;
    }
    
    
    /* This method used to generate email body */
    public static String loadBody(Account acc,Boolean isNSC,List<Opportunity> oppList){
        String body = '';
        body += 'This account is assigned to you. Click the following link to view this Account in Salesforce:\n';
        body += System.Label.Organization_URL+acc.id+'\n';
       
        
        system.debug('===acc==='+acc);
        /*if(isNSC){
            body += '\nClick the following link to assign this Account to any of the sales rep :\n';
            body += System.Label.Organization_URL + 'apex/NSCOwnerChange?id='+acc.id+'&recordType=Account\n';
        }*/
        Account acc1 = [Select name , branch__c from account where id = :acc.Id];
        body += '\nAccount Details'+'\n';
        body += '-----------------------------------------------------------------------\n';
        body += 'Account Name: '+ acc1.Name+'\n';
        body += 'Branch Id: '+ acc1.branch__c+'\n\n';
        
        if(oppList != null){
        body += 'Following Opportunities are also assigned to you . Click on the related links to view these Opportunities : \n';
            
            for(Opportunity opp : oppList){
                body += System.Label.Organization_URL+opp.id+'\n\n';
                 
            }
        }
        return body;
    }
    static testMethod void myUnitTest() {
    
        Account a = new Account(Name = 'Apex Test Account');
        User u = [Select Id from User WHERE isActive = true LIMIT 1];
        
        insert a;
        
        AccountMethods.ChangeAccountOwner(a.Id, u.Id);
        
        delete a;
         
    }
    /* Test method for ChangeETSaccOwner */
    static testMethod void testETSOwner()
    { String name = 'Tester Name';
      User u = [select Id, ManagerId from User where isActive = true and ManagerId != null limit 1];
       if(u.Id != null){
        String usr = u.Id;
        RecordType aRec = [select Id from RecordType where SObjectType = 'Account' and Name = 'ETS/WMI' LIMIT 1];  
         if(aRec.Id != null){
          Account acc = new Account(name = 'Apex Account', ownerid = usr, recordtypeId = String.valueOf(aRec.Id));
           insert acc;
         String accId = acc.id;
         String result = ChangeETSaccOwner(accId,usr,name); 
        }  
      }
    }
    /* Test method for SendToNSC */
    static testMethod void testSendToNSC(){
        List<User> usrs  = [select Id from User where Branch_Id__c != '298' and isActive =true limit 1];
        Account a = new Account(Name = 'Apex Test Account', Branch__c = '103', Servicing_Branch_Id__c ='103');
        if(usrs.size() > 0){
            a.OwnerId = usrs.get(0).Id;
        }
        insert a;
        AccountMethods.sendToNSC(a.Id);
        
        delete a;
      
    }
    
    static testMethod void testSendToBranch(){
        List<User> usrs  = [select Id from User where Branch_Id__c != '298' and isActive =true limit 1];
        Account a = new Account(Name = 'Apex Test Account', Branch__c = '103');
        if(usrs.size() > 0){
            a.OwnerId = usrs.get(0).Id;
        }
        insert a;
        AccountMethods.sendToBranch(a.Id);
        
        delete a;
    }

}