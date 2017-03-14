public with sharing class updateOpportunityBranchCode {

    Public Static VOID updateBranchCodesOnOpportunity(List<ID> ownerIds, List<Opportunity> opportunitiesToUpdate){
    
        Map<ID, String> userToBranchCodeMap = New Map<ID, String>();
        
        User[] u = [Select Id, Branch_Id__c from User where ID in :ownerIds];
        
        // Build the user map
        for (integer i=0;i<u.size();i++){
    
            // See if we already have this key (User ID)
            Boolean contains = userToBranchCodeMap.containsKey(u[i].Id);
            if (contains == false){
                userToBranchCodeMap.put(u[i].Id, u[i].Branch_Id__c);
            }

        }
        
        // Update the contacts
        for (integer i=0;i<opportunitiesToUpdate.size();i++){
            opportunitiesToUpdate[i].branch__c = userToBranchCodeMap.get(opportunitiesToUpdate[i].OwnerId);
        }
    
    }
    
    static testMethod void myUnitTest() {
    
        User salesRep1 = [Select Id, Branch_Id__c from User where Branch_id__c = '101' and isActive = true LIMIT 1];

        User salesRep2 = [Select Id, Branch_Id__c from User where Branch_id__c = '102' and isActive = true LIMIT 1];
    
        Account newAccount = New Account(Name='Test Account', ownerid=salesRep1.Id);

        insert newAccount;
        
        Opportunity newOppty = New Opportunity(Name = 'Test APEX Opportunity', AccountID = newAccount.Id, StageName = 'Quoted - No Decision', CloseDate = Date.newInstance(2009,07,30));
        
        insert newOppty;

        newOppty.ownerid = salesRep2.Id;
        
        update newOppty;

        Opportunity queryNewOpportunity = [Select Id, Branch__c from Opportunity where Id = :newOppty.Id];
        //system.assertEquals(queryNewOpportunity.Branch__c, salesRep2.Branch_Id__c);

        delete newAccount;
    
    }

}