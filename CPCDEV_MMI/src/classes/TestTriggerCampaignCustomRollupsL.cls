//**********************************************************************/
// Name : TestTriggerCampaignCustomRollupsL
// Author : Kirtesh Jain
// Created Date : October 09 , 2009
// Usage : Tests Trigger CampaignCustomRollupsL
//*********************************************************************/
@isTest
private class TestTriggerCampaignCustomRollupsL {

    static testMethod void testTriggerCampaignCustomRollupsL() {
       Campaign cmp = new Campaign( Name='Meeting', Status = 'In Progress',Lead_Source__c='BuyerZonex');
       insert cmp ;
       
       List<Lead> listLead  = new List<Lead>();
       for( Integer i = 0 ; i < 2 ; i++){
         Lead lead = new Lead( LastName='Testing'+i, LeadSource ='BuyerZonex');
         listLead.add(lead);
       }
       
       Test.startTest();
       insert listLead ;
       Test.stopTest();
       
       List<Id> Ids = new List<Id> ();
       for( Lead lead  : listLead){
         Ids.add( lead.Id ) ;
       }
       
       List<CampaignMember> listCampaignMember = new List<CampaignMember>();       
       listCampaignMember = [ Select CampaignId from CampaignMember where LeadId IN : Ids ];
       //System.assertEquals(listCampaignMember[0].CampaignId , cmp.Id );
       
       Delete listLead;
       
       listCampaignMember = [ Select CampaignId from CampaignMember where LeadId IN : Ids ];
       
       System.assertEquals(listCampaignMember.size() , 0 );
       
    }
}