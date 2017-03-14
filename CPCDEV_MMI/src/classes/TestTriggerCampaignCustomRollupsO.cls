//**********************************************************************/
// Name : TestTriggerCampaignCustomRollupsO
// Author : Kirtesh Jain
// Created Date : October 09 , 2009
// Usage : Tests Trigger CampaignCustomRollupsO
//*********************************************************************/
@isTest
private class TestTriggerCampaignCustomRollupsO {
  static testMethod void testTriggerCampaignCustomRollupsO() {
    List<Lead> listLead = new List<Lead>();
    for(Integer i = 0 ; i < 2 ; i++){
       Lead lead = new Lead();
       lead.lastName = 'test'+i;
       listLead.add(lead);
    }
    insert listLead ;
      
    List<Opportunity> listOpportunity = new List<Opportunity>();
     	
    for(Integer i = 0 ; i < 2 ; i++){
      Opportunity opp = New Opportunity(Name = 'test'+i , stageName ='Won' , closeDate = Date.Today().addMonths(21));
      opp.Lead_Id__c =  listLead[i].Id ;
      listOpportunity.add(opp);
    }
    
    insert listOpportunity ;
    
    update listOpportunity ;
  }
}