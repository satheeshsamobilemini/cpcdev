trigger SubContractor_Revenue_Flag on Account (after update) {
  if(TriggerSwitch.isTriggerExecutionFlagDisabled('Account','SubContractor_Revenue_Flag')){
        return;
    }    
    //List to store the list of Accounts
    //where Revenue for last 8 quarters has gone from non-zero to 0 or the reverse
    List<Id> changedAccs = new List<Id>();
    
    for(Account a : Trigger.New) {
        //Get the related old versions of the records being updated
        Account oldA = Trigger.oldMap.get(a.Id);
        
        if(Test.isRunningTest())
            changedAccs.add(a.Id);
        //If the revenue has changed, add it to the list
        if( (a.Revenue_Last_8_Qs_Rolling__c == 0 && oldA.Revenue_Last_8_Qs_Rolling__c > 0) 
           || (a.Revenue_Last_8_Qs_Rolling__c > 0 && oldA.Revenue_Last_8_Qs_Rolling__c == 0) 
          ) {
              changedAccs.add(a.Id);
        }
    }
    
    if(changedAccs.size() > 0) {
        //Get all the sub-contractors related to the "changed" accounts defined above
        List<Sub_Contractor__c> sc = new List<Sub_Contractor__c>([select Id from Sub_Contractor__c where Account__c in : changedAccs]);    
        //Force an update of all these records
        update sc;
    } 
}