@isTest
private class updateOpportunityBranchCodeTest{
    @isTest static void testupdateOpportunityBranchCode(){
        list<Id> ownIds = new list<Id>();
        List<USer> usrlist =  [select id from User];
        for(USer U :usrlist){
            ownIds.add(U.Id);
        }
        User salesRep1 = [Select Id, Branch_Id__c from User where Branch_id__c = '101' and isActive = true AND ID in :ownIds LIMIT 1];
        
        Account acc = New Account();
        acc.Name='Test Account';
        acc.ownerid=salesRep1.Id;
        insert acc;
        
        Opportunity Opp = New Opportunity();
        Opp.Name = 'Test APEX Opportunity'; 
        Opp.AccountID = acc.Id;
        Opp.StageName = 'Quoted - No Decision'; 
        Opp.CloseDate = Date.newInstance(2009,07,30);
        insert Opp;
        
        
        List<Opportunity> lstopp = new List<Opportunity>();
        lstopp.add(Opp);
        
         /*Map<ID, String> userToBranchCodeMap = New Map<ID, String>();
         User testUser = [SELECT Id,Branch_Id__c FROM User WHERE Id = :UserInfo.getUserId()]; 
         userToBranchCodeMap.put(testUser.Id,testUser.Branch_Id__c);
         Boolean contains = userToBranchCodeMap.containsKey(testUser.Id); */
         
        updateOpportunityBranchCode.updateBranchCodesOnOpportunity(ownIds,lstopp);
    }
}