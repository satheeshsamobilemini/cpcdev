global class OpportunitySweepLogicBatchableClasse implements Database.Batchable<sobject>{
    public Set<Id> oppIds;
    public DateTime currentTime;
    public DateTime startTime;
    public String formatedStartTime;
    public String formatedCurrentTime;
    public Set<String> AccountOwnerProfileSet = new Set<String>{'National Accounts Manager/Coordinator - US','National Accounts SVP - US','Major Accounts Manager','Business Development Manager'};
    public Set<ID> ETSOppRecordTypeSet = new Set<ID>{AssignmentRules.getETSWMIrectypeID('OpportunitySale'),AssignmentRules.getETSWMIrectypeID('OpportunityRental'),AssignmentRules.getETSWMIrectypeID('OpportunityWMI')}; // TFS 3981, 4220 
    public ID ETSAccRecordTypeID = AssignmentRules.getETSWMIrectypeID('Account');   // TFS 3981, 4220
    public Set<String> ETSprofileSet = AssignmentRules.getETSnWMIprofileNames();  // TFS 3981, 4220
    
    global OpportunitySweepLogicBatchableClasse(Set<Id> oppIds, DateTime currentTime){
         this.oppIds = oppIds; 
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
        String openOpportunityQuery = 'select id,Branch__c,Billing_Country__c,RecordTypeId,Account.name,isOpportunitySweep__c,Owner_manager_id__c,CreatedById,CreatedBy.ManagerId,CreatedBy.Manager.isActive,CreatedBy.Profile.Name,CreatedBy.Territory__c,StageName, NSC_Sweep_Date__c ,Territory__c,Billing_Zip_Postal_Code__c,Account.Territory__c, Account.industry,Account.Owner.Profile.Name, isWon ,Account.OwnerId, OwnerId, isClosed ,AccountId, Account.ShippingCountry, Account.BillingCountry,Account.isEmailNotify__c, Owner.UserRoleId,Owner.Profile.Name,CreatedBy.UserRoleId, CreatedBy.UserRole.Name,Owner.UserRole.Name,Account.Owner.UserRole.Name, servicing_Branch__c,Account.Owner.isActive,Account.RecordTypeId,Account.Owner.Name,Account.Owner.UserRoleId,Account.CreatedBy.Profile.Name,account.Account_Exception__c,account.Temporary_Assignment__c,is_NSC_Processed__c,Selling_Region__c,(select id, status, ownerId from tasks where status != \'Completed\')from Opportunity where (CreatedBy.UserRole.Name like \'%Inbound Sales Specialist%\' or CreatedBy.UserRole.Name like \'%Sales Rep - %\') AND CreatedBy.Profile.Name NOT IN : ETSprofileSet AND Account.CreatedBy.Profile.Name NOT IN : ETSprofileSet AND  Opportunity_sweep_after_24_hrs__c > ' +formatedStartTime+ ' AND Opportunity_sweep_after_24_hrs__c < ' +formatedCurrentTime+ ' AND Account.Owner.Profile.Name NOT IN : AccountOwnerProfileSet AND Account.Owner.Profile.Name NOT IN : ETSprofileSet AND Owner.Profile.Name NOT IN : ETSprofileSet AND RecordTypeId NOT IN : ETSOppRecordTypeSet AND Account.RecordTypeId !=: ETSAccRecordTypeID AND is_NSC_Processed__c = FALSE AND isOpportunitySweep__c = false AND On_The_Go__c = FALSE ';
        //String openOpportunityQuery = 'select id,Branch__c,Billing_Country__c,RecordTypeId,Account.name,isOpportunitySweep__c,Owner_manager_id__c,CreatedById,CreatedBy.ManagerId,CreatedBy.Manager.isActive,CreatedBy.Territory__c,StageName, NSC_Sweep_Date__c ,Territory__c,Billing_Zip_Postal_Code__c,Account.Territory__c, Account.industry, isWon ,Account.OwnerId, OwnerId, isClosed ,AccountId, Account.ShippingCountry, Account.BillingCountry, Owner.UserRoleId,CreatedBy.UserRoleId, CreatedBy.UserRole.Name,Owner.UserRole.Name,Account.Owner.UserRole.Name, servicing_Branch__c,Account.Owner.isActive,Account.Owner.Name,Account.Owner.UserRoleId,account.Account_Exception__c,account.Temporary_Assignment__c,is_NSC_Processed__c, (select id, status, ownerId from tasks where status != \'Completed\')from Opportunity where (CreatedBy.UserRole.Name like \'%Inbound Sales Specialist%\' or CreatedBy.UserRole.Name like \'%Sales Rep%\') and  Opportunity_sweep_after_48_hrs__c > ' +formatedStartTime+ ' and Opportunity_sweep_after_48_hrs__c <' +formatedCurrentTime+ ' and is_NSC_Processed__c = FALSE AND isOpportunitySweep__c = false AND On_The_Go__c = FALSE ';
       //String openOpportunityQuery = 'select id,Account.name,isOpportunitySweep__c,Owner_manager_id__c,CreatedById,StageName,NSC_Sweep_Date__c ,Territory__c,Billing_Zip_Postal_Code__c,Account.Territory__c, Account.industry, isWon ,Account.OwnerId, OwnerId, isClosed ,AccountId, Account.ShippingCountry, Account.BillingCountry, Owner.UserRoleId,CreatedBy.UserRoleId, CreatedBy.UserRole.Name, Owner.UserRole.Name,Account.Owner.UserRole.Name, servicing_Branch__c,Account.Owner.isActive,Account.Owner.Name,Account.Owner.UserRoleId,is_NSC_Processed__c, (select id , ownerId from tasks where status != \'Completed\')from Opportunity where CreatedBy.UserRole.Name like \'%Inbound Sales Specialist%\' and  Opportunity_sweep_after_48_hrs__c > '+formatedStartTime+'  and is_NSC_Processed__c = FALSE AND isOpportunitySweep__c = false AND On_The_Go__c = FALSE and id=\'006S0000007Nktd\'';
         system.debug('------openOpportunityQuery-------'+openOpportunityQuery);
        List<Opportunity> ooList  = Database.query(openOpportunityQuery);
        for(Opportunity op : ooList){
          system.debug('------id----'+op.Id);
          system.debug('------id---ob-'+op);
        }
        return Database.getQueryLocator(openOpportunityQuery);
    }
     
 global void execute(Database.batchableContext bc, List<sobject> scope){
    
       List<Opportunity> opportunities = (List<Opportunity>)scope;        
        OpportunitySweepLogic.processOpportunities(opportunities,true);
    } 
    
    global void finish(Database.batchableContext bc){}
}