global class ProcessConstructionBatchProcessor implements Database.Batchable<sobject>{
    public Set<Id> oppIds;
    public DateTime currentTime;
    public DateTime startTime;
    global ProcessConstructionBatchProcessor(Set<Id> oppIds, DateTime currentTime){
         this.oppIds = oppIds;
         this.currentTime = currentTime;
         this.startTime = DateTime.newInstance(currentTime.year(), currentTime.month(), currentTime.day()).addDays(-14);
    } 
    
    global Database.QueryLocator start(Database.batchableContext bc){
      
        //String openOpportunityQuery = 'select id , isClosed , OwnerId,AccountId, Account.OwnerId, servicing_Branch__c,is_NSC_Processed__c, (select id , ownerId from tasks where status != \'Completed\') from Opportunity where (Account.industry  = \'13-Home Builders\' OR Account.industry = \'5-Construction\' OR Account.Name like \'%Construction%\' OR Account.Name like \'%Contractor%\' ) AND ( CreatedDate > : startTime AND Account.NSC_Sweep_Date__c < : currentTime) AND is_NSC_Processed__c = FALSE AND On_The_Go__c = FALSE AND (Account.Owner.Name = \'NSC Account\' OR Account.Owner.Name = \'Branch Account\' OR Account.Owner.UserRole.Name  like \'%Inbound%\' OR Account.Owner.Profile.Name  like \'%Inbound%\' OR Account.Owner.Profile.Name like \'Business Development Specialist (OB)%\' OR Account.owner.UserRole.Name like \'Business Development Specialist (OB)%\') ';
        // Case 00040379 Added NSC_Sweep_Date__c to query - By Hemlata
        String openOpportunityQuery = 'select id , NSC_Sweep_Date__c, isClosed , OwnerId,AccountId, Account.OwnerId,Account.Owner.Name,Account.Owner.UserRole.Name,Account.Owner.Profile.Name,Account.Owner.isActive, servicing_Branch__c,is_NSC_Processed__c, (select id , ownerId from tasks where status != \'Completed\') from Opportunity where ( NSC_Sweep_Date_Construction__c > : startTime AND NSC_Sweep_Date_Construction__c < : currentTime AND is_NSC_Processed__c = FALSE AND On_The_Go__c = FALSE) AND (Account.industry IN (\'13-Home Builders\',\'5-Construction\') OR Account.Name like \'%Construction%\' OR Account.Name like \'%Contractor%\' )  AND (Owner.UserRole.Name  like \'%Inbound%\' OR Owner.Profile.Name  like \'%Inbound%\' ) ';
        
        system.debug('======curenttime===='+currentTime);              
        if(oppIds!= null){ 
            openOpportunityQuery += ' and id  in : oppIds';
        }
        
        openOpportunityQuery += ' order by isClosed';        
        return Database.getQueryLocator(openOpportunityQuery);
    }
     
    global void execute(Database.batchableContext bc, List<sobject> scope){
    
       List<Opportunity> opportunities = (List<Opportunity>)scope;        
        NSCSweepUtil.processConstructionOpportunities(opportunities);
    } 
    
    global void finish(Database.batchableContext bc){}
}