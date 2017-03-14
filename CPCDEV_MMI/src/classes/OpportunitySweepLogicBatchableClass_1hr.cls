global class OpportunitySweepLogicBatchableClass_1hr implements Database.Batchable<sobject> {
    public Set<Id> oppIds;
    public DateTime currentTime;
    public DateTime startTime;
    public String formatedStartTime;
    public String formatedCurrentTime;
    //public Boolean isTest = False;
    public Set<String> AccountOwnerProfileSet = new Set<String>{'National Accounts Manager/Coordinator - US','National Accounts SVP - US','Major Accounts Manager','Business Development Manager'};
    public Set<ID> ETSOppRecordTypeSet = new Set<ID>{AssignmentRules.getETSWMIrectypeID('OpportunitySale'),AssignmentRules.getETSWMIrectypeID('OpportunityRental'),AssignmentRules.getETSWMIrectypeID('OpportunityWMI')}; // TFS 3981, 4220
    public ID ETSAccRecordTypeID = AssignmentRules.getETSWMIrectypeID('Account'); // TFS 3981, 4220
    public Set<String> ETSprofileSet = AssignmentRules.getETSnWMIprofileNames(); // TFS 3981, 4220

    global OpportunitySweepLogicBatchableClass_1hr(Set<Id> oppIds, DateTime currentTime){
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
        //Shankar - Modified query as per the new Sweep process
        String openOppQuery = 'SELECT id,Name,Branch__c,RecordTypeId,Account.name,Account.isSPOC_Account__c,isOpportunitySweep__c,';
               openOppQuery +='Owner_manager_id__c,CreatedById,CreatedBy.ManagerId,CreatedBy.Profile.Name,';
               openOppQuery +='CreatedBy.Manager.isActive,CreatedBy.Territory__c,StageName,Owner.Profile.Name,';
               openOppQuery +='Territory__c,is_NSC_Processed__c,Billing_Zip_Postal_Code__c,Account.Territory__c,';
               openOppQuery +='Account.RecordTypeId, Account.Owner.Profile.Name,Account.CreatedBy.Profile.Name,';
               openOppQuery +='Account.industry,Account.OwnerId, OwnerId,AccountId, Account.ShippingCountry,';
               openOppQuery +='Account.BillingCountry,Account.BillingPostalCode,Account.isEmailNotify__c, Owner.UserRoleId,';
               openOppQuery +='CreatedBy.UserRoleId, CreatedBy.UserRole.Name,Owner.UserRole.Name,Account.Owner.UserRole.Name,';
               openOppQuery +='Account.Owner.isActive,Account.Owner.Name,Account.Owner.UserRoleId,account.Account_Exception__c,';
               openOppQuery +='account.Temporary_Assignment__c,Billing_Country__c,Shipping_Territory__c,Servicing_Branch__c,';
               openOppQuery +='Opportunity_sweep_after_1_hr__c,IsClosed,Selling_Region__c,Transaction_Type__c,NSC_Sweep_Date__c,Assignment_Cause__c ';
               
               openOppQuery +='FROM Opportunity WHERE CreatedBy.Profile.Name NOT IN : ETSprofileSet ';
               openOppQuery +='AND Account.CreatedBy.Profile.Name NOT IN : ETSprofileSet ';
               openOppQuery +='AND Account.Owner.Profile.Name NOT IN : AccountOwnerProfileSet ';
               openOppQuery +='AND Account.Owner.Profile.Name NOT IN : ETSprofileSet ';
               openOppQuery +='AND Owner.Profile.Name NOT IN : ETSprofileSet ';
               openOppQuery +='AND RecordTypeId NOT IN : ETSOppRecordTypeSet ';
               openOppQuery +='AND Account.RecordTypeId !=: ETSAccRecordTypeID ';
               //openOppQuery +='AND Transaction_Type__c != \'Sale\' '; // TFS-7539
               openOppQuery +='AND BatchClass_Opportunity_sweep_after_1_hr__c > ' +formatedStartTime;
               openOppQuery +='AND BatchClass_Opportunity_sweep_after_1_hr__c < ' +formatedCurrentTime;
               openOppQuery +='AND isOpportunitySweep__c = FALSE AND is_NSC_Processed__c = FALSE AND On_The_Go__c = FALSE ';    
               //Shankar - Check if the opp account is of type SPOC/MAR
               //openOppQuery +='AND Account.isSPOC_Account__c = FALSE';
           
        system.debug('------openOppQuery-------'+openOppQuery);
        List<Opportunity> OppList  = Database.query(openOppQuery);
        for(Opportunity op : OppList){
          system.debug('------id----'+ op.Id);
          system.debug('------id---ob-'+ op);
        }
        return Database.getQueryLocator(openOppQuery);  
    }
    
     global void execute(Database.batchableContext bc, List<sobject> scope){
       List<Opportunity> oList = (List<Opportunity>)scope;
       system.debug('---------- oList.size()--------------------'+ oList.size()); 
       //Shankar - New Opty Sweep logic.
        OpportunitySweepValidation oppSweepValidate = new OpportunitySweepValidation();
        oppSweepValidate.validateOpportunities(oList);
       //OpportunitySweepLogic.processOpportunities(oList,false); 
    } 

    global void finish(Database.batchableContext bc){}
}