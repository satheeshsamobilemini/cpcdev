global class ProcessNonConstructionBatchProcessor implements Database.Batchable<sobject>{
    public Set<Id> oppIds;
    public DateTime currentTime;
    Public DateTime startTime;
    global ProcessNonConstructionBatchProcessor(Set<Id> oppIds, DateTime currentTime){
         this.oppIds = oppIds;
         this.currentTime = currentTime;
         this.startTime = DateTime.newInstance(currentTime.year(), currentTime.month(), currentTime.day()).addDays(-14);
    }  
    
    global Database.QueryLocator start(Database.batchableContext bc){
       String openOpportunityQuery = 'select id ,NSC_Sweep_Date__c , isWon , OwnerId,isClosed ,AccountId, Account.ShippingCountry, Account.BillingCountry, Account.OwnerId, Account.Owner.Name,Account.Owner.UserRole.Name,Account.Owner.UserRoleId ,Account.Owner.isActive, servicing_Branch__c,Account.Industry,is_NSC_Processed__c,(select id , ownerId from tasks where status != \'Completed\') from Opportunity where (Account.industry  != \'13-Home Builders\' AND Account.industry != \'5-Construction\' AND (NOT Account.Name like \'%Construction%\') AND (NOT Account.Name like \'%Contractor%\') ) AND ( NSC_Sweep_Date__c > : startTime AND NSC_Sweep_Date__c < : currentTime) AND is_NSC_Processed__c = FALSE AND On_The_Go__c = FALSE AND (Owner.UserRole.Name  like \'%Inbound%\' OR Owner.Profile.Name  like \'%Inbound%\' )  ';
        
        if(oppIds!= null){ 
            openOpportunityQuery += ' and id  in : oppIds';
        }
        
        openOpportunityQuery += ' order by isClosed';
        
        system.debug('===query==='+openOpportunityQuery );
        return Database.getQueryLocator(openOpportunityQuery);
    }
    
    global void execute(Database.batchableContext bc, List<sobject> scope){
        List<Opportunity> opportunities = (List<Opportunity>)scope;
        NSCSweepUtil.processNonConstructionOpportunities(opportunities);
    }
    
    global void finish(Database.batchableContext bc){}
    

}