global class AccountSweepLogicBatchableClass implements Database.Batchable<sobject> {
    public Set<Id> accIds;
    public DateTime currentTime;
    public DateTime startTime;
    public String formatedStartTime;
    public String formatedCurrentTime;
    public Boolean isTest = False;
    public Set<String> AccountOwnerProfileSet = new Set<String>{'National Accounts Manager/Coordinator - US','National Accounts SVP - US','Major Accounts Manager','Business Development Manager'}; // TFS 3981, 4220
    public ID ETSAccRecordTypeID = AssignmentRules.getETSWMIrectypeID('Account'); // TFS 3981, 4220
    public Set<String> ETSprofileSet = AssignmentRules.getETSnWMIprofileNames(); // TFS 3981, 4220
   
    global AccountSweepLogicBatchableClass(Set<Id> accIds, DateTime currentTime){
         this.accIds = accIds; 
         this.currentTime = DateTime.newInstance(currentTime.year(), currentTime.month(), currentTime.day());
         this.formatedCurrentTime = string.valueOf(currentTime);
         String dateStrc = formatedCurrentTime.subString(0,10);
         String timeStrc = formatedCurrentTime.subString(11,19);
         formatedCurrentTime = dateStrc + 'T' +timeStrc+'.000Z';
         
         this.startTime = DateTime.newInstance(currentTime.year(), currentTime.month(), currentTime.day()).addDays(-5);
         this.formatedStartTime = string.valueOf(startTime);
         String dateStr = formatedStartTime.subString(0,10);
         String timeStr = formatedStartTime.subString(11,19);
         formatedStartTime = dateStr + 'T' +timeStr+'.000Z';
         
    }
    
    global Database.QueryLocator start(Database.batchableContext bc){
        system.debug('---------formatedCurrentTime-------'+formatedCurrentTime);
        system.debug('---------formatedStartTime-------'+formatedStartTime);
        String openAccountQuery = 'Select Territory__c, Temporary_Assignment__c,ShippingStreet, CreatedBy.UserRole.Name,CreatedBy.Profile.Name, CreatedBy.Territory__c,CreatedBy.ManagerId, CreatedBy.Manager.isActive,Servicing_Branch__c, Servicing_Branch_Id__c, RecordTypeId, Phone, Owner_s_Role__c,OwnerId__c, OwnerId, Name, Lead_Source__c, IsPersonAccount, Industry, Id,Created_Date_Time__c, Created_By_Role__c, CreatedDate, CreatedById, Branch__c, BillingStreet, BillingState, BillingPostalCode, BillingCountry, BillingCity, Account_Exception__c,Owner.Profile.Name,(select id, status, ownerId from tasks where status != \'Completed\'),(select id from Opportunities) From Account where';
        //String openAccountQuery = 'Select  Territory__c, Temporary_Assignment__c,ShippingStreet, CreatedBy.UserRole.Name,CreatedBy.Territory__c,CreatedBy.ManagerId, Servicing_Branch__c, Servicing_Branch_Id__c, RecordTypeId, Phone, Owner_s_Role__c,OwnerId__c, OwnerId, Name, Lead_Source__c, IsPersonAccount, Industry, Id, Created_Date_Time__c, Created_By_Role__c, CreatedDate, CreatedById, Branch__c, BillingStreet, BillingState, BillingPostalCode, BillingCountry, BillingCity, Account_Exception__c,(select id, status, ownerId from tasks where status != \'Completed\'),(select id from Opportunities) From Account where CreatedBy.UserRole.Name like \'%Sales Rep%\'  AND isAccountSweep__c = false  and account_sweep_after_48_hrs__c > formatedStartTime  and account_sweep_after_48_hrs__c < formatedCurrentTime';
         
         if(isTest == True && accIds.size() > 0 )
        { openAccountQuery += ' id IN : accIds';    }
        
        else
        { openAccountQuery += ' CreatedBy.UserRole.Name like \'%Sales Rep - %\' and CreatedBy.Profile.Name NOT IN : ETSprofileSet and Owner.Profile.Name NOT IN : AccountOwnerProfileSet and Owner.Profile.Name NOT IN : ETSprofileSet and RecordTypeId !=: ETSAccRecordTypeID and account_sweep_after_48_hrs__c > ' +formatedStartTime+ ' and account_sweep_after_48_hrs__c <  ' +formatedCurrentTime+ ' and isAccountSweep__c = false'; } 
        
         if(isTest == True)
        {openAccountQuery += ' limit 1';}
             
         system.debug('------openAccountQuery-------'+openAccountQuery);
        List<Account> accList  = Database.query(openAccountQuery);
        for(Account acct : accList){
          system.debug('------id----'+acct.Id);
          system.debug('------id---ob-'+acct);
        }
        return Database.getQueryLocator(openAccountQuery);   
    }
    
    global void execute(Database.batchableContext bc, List<sobject> scope){
       List<Account> AccList = (List<Account>)scope;
       system.debug('---------- Acclist.size()--------------------'+ Acclist.size()); 
       
       List <Account> accounts = new List<Account>();
       
       for(integer i=0; i< AccList.size(); i++)
       {    if(AccList[i].Opportunities.size() == 0)
             {   system.debug('------------ AccList[i].Opportunities.size() --------------------'+ AccList[i].Opportunities.size());
               system.debug('------------ AccList[i] --------------------'+ AccList[i]);  
               accounts.add(AccList[i]); 
             }    
       }
       system.debug('-------- accounts.size() -------------' + accounts.size());     
       AccountSweepLogic.processAccounts(accounts); 
    } 
    
    global void finish(Database.batchableContext bc){}
}