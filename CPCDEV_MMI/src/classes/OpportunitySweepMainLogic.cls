/*
* (c) 2015 TEKsystems Global Services
*
* Name           : OpportunitySweepMainLogic
* Created Date   : 6 September, 2015 @ 0130
* Created By     : Shankar Rao
* Edited Date    : 8 September, 2016 @ 0455
* Edited By      : Harthi Sundaramurthy
* Purpose        : Perform the business process for both 1hr and 24hr opportunity sweep.
* 
*/
public class OpportunitySweepMainLogic {
    
  
    //Shankar-Process opp sweep 
    public static void processOptySweepLogic(List<Opportunity> oppList){
        List<sObject> updateOpportunityList = new List<sObject>();
        List<Opportunity> updateOpportunityNoEmailList = new List<Opportunity>();
        Set<String> delTerritoryBranchCodeSet = new Set<String>();
        
        for(Opportunity opp : oppList){
            if(String.isNotBlank(opp.Servicing_Branch__c)){
                delTerritoryBranchCodeSet.add(opp.Shipping_Territory__c+'_'+opp.Servicing_Branch__c);
            }
        }
        Map<String, User> delTerritoryBranchCodeMap = RoutingLogic.getNewOpportunityOwner(delTerritoryBranchCodeSet);
        List<Task> updateRelatedOpenTaskList = new List<Task>();
        for(Opportunity opp : oppList){
            User newOppOwner = delTerritoryBranchCodeMap.get(opp.Shipping_Territory__c+'_'+opp.Servicing_Branch__c);
            
            if(newOppOwner == null){
                opp.Assignment_Cause__c = 'No Sales Rep, Branch Manager, Regional Inside Sales/Outside Sales Manager found for the shipping Zip/Postal code.';
                updateOpportunityNoEmailList.add(opp);
            }else{
                Id oppOwnerId = opp.OwnerId;
                opp.OwnerId =newOppOwner.Id;
                opp.isOpportunitySweep__c = true;
                opp.is_NSC_Processed__c = true;
                opp.Assignment_Cause__c = 'Opportunity successfully assigned to '+newOppOwner.Name+' - '+newOppOwner.UserRole.Name;
                updateOpportunityList.add(opp);
                
                List<Task> openTasks = RoutingLogic.getUpdateRequiredRelatedTasks(opp.Id,oppOwnerId,newOppOwner.Id);
                updateRelatedOpenTaskList.addAll(openTasks); 
                
            }
            
           
        }
        
        if(!updateOpportunityList.isEmpty()){
            finishOppSweepDML(updateOpportunityList,true);   
        }
         if(!updateOpportunityNoEmailList.isEmpty()){
            finishOppSweepDML(updateOpportunityNoEmailList,false);   
        }
        if(!updateRelatedOpenTaskList.isEmpty()){
            update updateRelatedOpenTaskList;
        }
    }
    
      public static void processSPOCDSSOpty(List<Opportunity> oppList){
        List<Opportunity> updateOpportunityList = new List<Opportunity>();
         List<Opportunity> updateOpportunityNoEmailList = new List<Opportunity>();
         List<Task> updateRelatedOpenTaskList = new List<Task>();
         for(Opportunity opp : oppList){
            String convertedZip = AssignmentRules.getConvertedZipCode(opp.Account.BillingPostalCode, opp.Account.BillingCountry);   
            //User newOppOwner = getNewAccountOwner(convertedZip);
            //Account acc = new Account(Id=opp.AccountId, OwnerId= newOppOwner.Id);
            User newOppOwner = new User(Id = opp.Account.OwnerId);
            Account acc = new Account(Id=opp.AccountId, OwnerId= newOppOwner.Id);
            if(newOppOwner != null){
                if(newOppOwner.Id != opp.OwnerId){
                    Id oppOwnerId = opp.OwnerId;
                    opp.OwnerId = acc.OwnerId;
                    opp.isOpportunitySweep__c = true;
                    opp.is_NSC_Processed__c = true;
                    opp.Assignment_Cause__c = 'Opportunity successfully assigned to '+newOppOwner.Name+' - '+newOppOwner.UserRole.Name;
                    updateOpportunityList.add(opp);
                    
                    List<Task> openTasks = RoutingLogic.getUpdateRequiredRelatedTasks(opp.Id,oppOwnerId,acc.OwnerId);
                    updateRelatedOpenTaskList.addAll(openTasks);
                    
                }else{
                    opp.Assignment_Cause__c = 'Sweep was not made as the Account Territory owner is already the Opportunity Owner';
                    updateOpportunityNoEmailList.add(opp);
                }
           }else{
                opp.Assignment_Cause__c = 'No Account Territory Owner found for the opportunity';
                updateOpportunityNoEmailList.add(opp);
           }
            
        }
        
        if(!updateOpportunityList.isEmpty()){
            finishOppSweepDML(updateOpportunityList,true);   
        }
         if(!updateOpportunityNoEmailList.isEmpty()){
            finishOppSweepDML(updateOpportunityNoEmailList,false);   
        }
        if(!updateRelatedOpenTaskList.isEmpty()){
            update updateRelatedOpenTaskList;
        }
    }
  
     //Shankar - Find territory specific user for account ownership or return branch account User.
    public static User getNewAccountOwner(String convertedZip){
        List<User> newUser = new List<User>();
        List<Branch_Lookup__c> branchLookup = [SELECT Id, Branch_Code__c, Territory__c, Selling_Region__c, 
                                            Zip__c FROM Branch_Lookup__c Where Zip__c =: convertedZip LIMIT 1];
        if(!branchLookup.isEmpty() && String.isNotBlank(branchLookup[0].Territory__c)){
            newUser = [SELECT Id, Name, UserRole.Name FROM User WHERE Territory__c =:branchLookup[0].Territory__c
                                                                AND isActive = true
                                                                And UserRole.Name LIKE 'Sales Rep%'];
            if(newUser.isEmpty()){
                newUser = [SELECT Id, Name, UserRole.Name FROM User WHERE Name ='Branch Account' AND isActive = true];
            }
        }
        else{
            system.debug('Invalid Zip - Branch not found, hence throw exception.');
            throw new MyException('Invalid Zip, branch details not found for the billing zip/postal code of the Account.');
        }
        return newUser[0];
    }
  
    //Shankar-Perform update of account and opportunities.
    private static void finishOppSweepDML(List<Opportunity> updateOpportunityList , Boolean mailOption){
        try{
            Database.DMLOptions option = new Database.DMLOptions(); 
            option.EmailHeader.triggerUserEmail = mailOption;
            Database.update(updateOpportunityList, option); 
        }catch(Exception e){
            system.debug('Exception Occurred : '+e.getMessage());
        } 
    }
}