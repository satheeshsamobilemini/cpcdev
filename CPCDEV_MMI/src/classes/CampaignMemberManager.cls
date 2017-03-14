//commented for I-28389 the class should run on system permission regardless of which user has logged in.
//public with sharing class CampaignMemberManager {
public without sharing class CampaignMemberManager {

	Public Static VOID AddCampaignMembers(List <Lead> listLeads, List <ID> listCampaignIDs){

        List<CampaignMember> newCampaignMembers = new List<CampaignMember>();
	
		for (integer i=0;i<listLeads.size();i++){
	       
	        newCampaignMembers.add(new CampaignMember(CampaignId = listCampaignIDs[i], LeadId = listLeads[i].Id, Lead_Status__c = listLeads[i].Status, Lead_Unread__c = listLeads[i].isUnreadByOwner, Status = 'Responded'));
	
		}	
	
		// system.debug('$$$$ --> Insert newCampaignMembers');
		insert newCampaignMembers;   		
		
	}
	
	Public Static VOID UpdateCampaignMembersLead(List <Lead> listLeads){

		Map <ID, CampaignMember> mapLeadIdtoCampaignMember = New Map <ID, CampaignMember>();
	
		// Get a list of Campaign Members that match our Leads
		CampaignMember[] cm = [Select Id, Lead_Status__c, Lead_Unread__c, LeadId FROM CampaignMember Where LeadId in :listLeads for Update]; 
		
		for (CampaignMember cmem : cm){
		
			if (!mapLeadIdtoCampaignMember.containsKey(cmem.LeadId)){
				mapLeadIdtoCampaignMember.put(cmem.LeadId, cmem);
			}
		
		}
		
		for (Lead l : listLeads){
		
			if (mapLeadIdtoCampaignMember.containsKey(l.Id)){ 
				mapLeadIdtoCampaignMember.get(l.Id).Lead_Status__c = l.Status;
				mapLeadIdtoCampaignMember.get(l.Id).Lead_Unread__c = l.isUnreadByOwner;
			}
		}
	
		Update cm;
	
	}
	
	Public Static VOID UpdateCampaignMembersOppty(List <ID> listLead, Map <ID, String> MapLeadIdToOpptyStage){
	
		Map <ID, CampaignMember> mapLeadIdtoCampaignMember = New Map <ID, CampaignMember>();
		system.debug('-------listLead--------'+listLead);
		// Get a list of Campaign Members that match our Leads
		List<CampaignMember> cm = new List<CampaignMember>();
		if(RecursiveTriggerUtility.isCampaignMemberManager == false){
			cm = [Select Id, Opportunity_Stage__c, LeadId FROM CampaignMember Where LeadId in :listLead for Update];
			RecursiveTriggerUtility.isCampaignMemberManager = true;	
		}
	
		
		for (CampaignMember cmem : cm){
		
			if (!mapLeadIdtoCampaignMember.containsKey(cmem.LeadId)){
				mapLeadIdtoCampaignMember.put(cmem.LeadId, cmem);
			}
		
		}
		
		for (integer i=0;i<listLead.size();i++){
		
			if (mapLeadIdtoCampaignMember.containsKey(listLead[i])){ 
				mapLeadIdtoCampaignMember.get(listLead[i]).Opportunity_Stage__c = MapLeadIdToOpptyStage.get(listLead[i]);
			}
		}
		if(!cm.isEmpty()){
		Update cm;
		}	
	}	


/*

	@Future Public Static VOID AddCampaignMembers(List <ID> listLeadIds, List <ID> listCampaignIDs){

		Lead[] listLeads = [Select Id, Status, isUnreadByOwner from Lead Where Id in: listLeadIds];

        List<CampaignMember> newCampaignMembers = new List<CampaignMember>();
	
		for (integer i=0;i<listLeads.size();i++){
	       
	        newCampaignMembers.add(new CampaignMember(CampaignId = listCampaignIDs[i], LeadId = listLeads[i].Id, Lead_Status__c = listLeads[i].Status, Lead_Unread__c = listLeads[i].isUnreadByOwner, Status = 'Responded'));
	
		}	
	
		// system.debug('$$$$ --> Insert newCampaignMembers');
		insert newCampaignMembers;   		
		
	}
	
	@Future Public Static VOID UpdateCampaignMembersLead(List <Id> listLeadIds){

		Lead[] listLeads = [Select Id, Status, isUnreadByOwner from Lead Where Id in: listLeadIds];
	
		Map <ID, CampaignMember> mapLeadIdtoCampaignMember = New Map <ID, CampaignMember>();
	
		// Get a list of Campaign Members that match our Leads
		CampaignMember[] cm = [Select Id, Lead_Status__c, Lead_Unread__c, LeadId FROM CampaignMember Where LeadId in :listLeads]; 
		
		for (CampaignMember cmem : cm){
		
			if (!mapLeadIdtoCampaignMember.containsKey(cmem.LeadId)){
				mapLeadIdtoCampaignMember.put(cmem.LeadId, cmem);
			}
		
		}
		
		for (Lead l : listLeads){
		
			if (mapLeadIdtoCampaignMember.containsKey(l.Id)){ 
				mapLeadIdtoCampaignMember.get(l.Id).Lead_Status__c = l.Status;
				mapLeadIdtoCampaignMember.get(l.Id).Lead_Unread__c = l.isUnreadByOwner;
			}
		}
	
		Update cm;
	
	}
	
	@Future Public Static VOID UpdateCampaignMembersOppty(List <ID> listLead, Map <ID, String> MapLeadIdToOpptyStage){
	
		Map <ID, CampaignMember> mapLeadIdtoCampaignMember = New Map <ID, CampaignMember>();
	
		// Get a list of Campaign Members that match our Leads
		CampaignMember[] cm = [Select Id, Opportunity_Stage__c, LeadId FROM CampaignMember Where LeadId in :listLead]; 
		
		for (CampaignMember cmem : cm){
		
			if (!mapLeadIdtoCampaignMember.containsKey(cmem.LeadId)){
				mapLeadIdtoCampaignMember.put(cmem.LeadId, cmem);
			}
		
		}
		
		for (integer i=0;i<listLead.size();i++){
		
			if (mapLeadIdtoCampaignMember.containsKey(listLead[i])){ 
				mapLeadIdtoCampaignMember.get(listLead[i]).Opportunity_Stage__c = MapLeadIdToOpptyStage.get(listLead[i]);
			}
		}
	
		Update cm;
	
	}	

*/

}