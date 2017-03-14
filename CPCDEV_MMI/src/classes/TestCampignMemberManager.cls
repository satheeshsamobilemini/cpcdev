//**********************************************************************/
// Name : TestCampignMemberManager
// Author : Kirtesh Jain
// Created Date : October 09 , 2009
// Usage : Tests CampignMemberManager class
//*********************************************************************/

@isTest
private class TestCampignMemberManager {

    static testMethod void testCampignMemberManager() {
       List<Lead> listLead = new List<Lead>();
       for(Integer i = 0 ; i < 2 ; i++){
         Lead lead = new Lead();
         lead.lastName = 'test'+i;
         listLead.add(lead);
       }
       insert listLead ;
       
       List<Lead> setLeads = new  List<Lead>();
       for( Lead lead    : listLead ){
         setLeads.add(lead);
       }
       
       List<Campaign> listcmpaign = new List<Campaign>();
       for(Integer i = 0 ; i < 2 ; i++){
         Campaign cmp = new Campaign();
         cmp.Name = 'Meeting'+i;
         listcmpaign.add(cmp);
       }
       insert listcmpaign ;
       
       List<Id> setCmpIds = new  List<Id>();
       for( Campaign cmp : listcmpaign ){
         setCmpIds.add(cmp.Id);
       }
       
       Test.startTest();
       CampaignMemberManager.AddCampaignMembers(setLeads ,setCmpIds );
       Test.stopTest();

       List<CampaignMember> listMember = [Select LeadId from CampaignMember Where Leadid in : setLeads AND CampaignId IN :setCmpIds  AND Status ='Responded'];       
       System.assertEquals( 2, listMember.size() );
       
    }
}