/*
* (c) 2015 TEKsystems Global Services
*
* Name           : OpportunitySweepValidation
* Created Date   : 6 September, 2015 @ 0130
* Created By     : Shankar Rao
* Edited Date    : 8 September, 2016 @ 0455
* Edited By      : Harthi Sundaramurthy
* Purpose        : Perform all opportunity sweep validate and extract only valid opportunities.
* 
*/
public class OpportunitySweepValidation {
    
    public SET<Id> ukRecordTypeIdSET = new SET<Id>();
    
    public OpportunitySweepValidation(){
        for(RecordType optyRT : [SELECT Id FROM RecordType WHERE SobjectType = 'Opportunity' 
                                                       AND (DeveloperName = 'Government_Opportunity_UK' 
                                                            OR DeveloperName = 'National_Account_Opportunity_UK' 
                                                            OR DeveloperName = 'Standard_Opportunity_UK')]){
            ukRecordTypeIdSET.add(optyRT.Id);                                                           
        }
    }
    
    //Shankar - validate all the opportunities before the opp sweep process.
    public void validateOpportunities(List<Opportunity> oppList){
        List<Opportunity> opptySweepList = new List<Opportunity>();
         List<Opportunity> opptySweepSPOCDSSList = new List<Opportunity>();
         List<Opportunity> opptySweepDSSList = new List<Opportunity>();
       
        for(Opportunity optyItem : oppList){
            //if(!isUKOpportunity(optyItem) && !optyItem.Account.isSPOC_Account__c&& (!(optyItem.Owner.Profile.Name == 'Digital Sales Specialist') ||((optyItem.Owner.Profile.Name == 'Digital Sales Specialist') && optyItem.Transaction_Type__c == 'Sale'))){
            if(!isUKOpportunity(optyItem) && !optyItem.Account.isSPOC_Account__c&& ((!(optyItem.CreatedBy.Profile.Name == 'Digital Sales Specialist') && optyItem.Transaction_Type__c != 'Sale') ||((optyItem.CreatedBy.Profile.Name == 'Digital Sales Specialist') && optyItem.Transaction_Type__c == 'Sale'))){
               opptySweepList.add(optyItem); 
            }
            if(!isUKOpportunity(optyItem) && (optyItem.Account.isSPOC_Account__c )){
                
                opptySweepSPOCDSSList.add(optyItem); 
            }
            
        }
        OpportunitySweepMainLogic.processOptySweepLogic(opptySweepList);
        OpportunitySweepMainLogic.processSPOCDSSOpty(opptySweepSPOCDSSList);
        
        
    }
    
    
    //Shankar - isUKOpportunit check
    public Boolean isUKOpportunity(Opportunity opp){
        Boolean isUKOpp = false;
        if(ukRecordTypeIdSET.contains(opp.RecordTypeId) || (opp.Branch__c <> null && opp.Branch__c <> '' 
                                                            && (opp.Branch__c.startswith('7') 
                                                                || opp.Billing_Country__c.toUpperCase() == 'UK' 
                                                                || opp.Billing_Country__c.toUpperCase() == 'UNITED KINGDOM' 
                                                                || opp.Billing_Country__c.toUpperCase() == 'GB' 
                                                                || opp.Billing_Country__c.toUpperCase() == 'GREAT BRITAIN' 
                                                                || opp.Billing_Country__c.toUpperCase() == 'ENG' 
                                                                || opp.Billing_Country__c.toUpperCase() == 'ENGLAND'))){
            
            isUKOpp = true;
        }
        return isUKOpp;
    }
    
   
}