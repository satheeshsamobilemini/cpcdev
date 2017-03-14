trigger CampaignCustomRollupsCM on CampaignMember (after delete, after insert, after undelete, after update) {

/*

	List <ID> listCampaignIds = New List <ID>();

	if (trigger.IsInsert || trigger.IsUpdate){
	
		for (CampaignMember cm : trigger.New){
	
			listCampaignIds.add(cm.Campaign.Id);
			
		}
	
	}
	
	if (trigger.IsDelete || trigger.IsUndelete){
	
		for (CampaignMember cm : trigger.Old){
	
			listCampaignIds.add(cm.Campaign.Id);
			
		}
	
	}	
	
	if (listCampaignIds.size() > 0){
	
		CampaignCustomRollups.initCampaignRollupHierarchy(listCampaignIds);
	
	}

*/
	
	/*

	// Trigger.New --> only available in insert and update triggers
	// Trigger.Old --> only available in update and delete triggers

	List <ID> leadIDsToProcess = New List <ID>();
	// List <String> leadIDsToProcessTrimmed = New List <String>();

	Map <ID, String> mapLeadStatus = New Map <ID, String>();
	Map <ID, Boolean> mapLeadUnread = New Map <ID, Boolean>();

	Map <ID, String> mapOpportintyStatus = New Map <ID, String>();
	
	//Map <ID, ID> mapCampaignIDs = New Map <ID, ID>();
	List <ID> listCampaignIDs = New List <ID>();
	
	Boolean mapContainsKey = false;

	if ( (trigger.isBefore) && ((trigger.isInsert) || (trigger.isUpdate)) ){
	
		system.debug('$$$$ --> Start of Before + Insert/Update Trigger');
	
		// Create a list of Leads ID from the Campaign Member Records in our batch
		// Also create a list of Campaign IDs to pass to our rollup method
		for (integer i=0;i<trigger.New.size();i++){
		
			leadIDsToProcess.Add(trigger.new[i].LeadID);
			// leadIDsToProcessTrimmed.Add(trigger.new[i].LeadID);
			// leadIDsToProcessTrimmed.set(i, leadIDsToProcessTrimmed.get(i).substring(0,15));
			
		}
	
		// Get a List of Leads that match our Campaign Members
		List <Lead> listLeads = [Select ID, Status, IsUnreadByOwner from Lead Where ID in :leadIDsToProcess]; 
		
		if (listLeads.size() != 0){
		
			for (integer i=0;i<listLeads.size();i++){
			
				mapContainsKey = mapLeadStatus.containsKey(listLeads[i].ID);
			
				if (mapContainsKey == false){
			
					mapLeadStatus.put(listLeads[i].Id, listLeads[i].Status);
					mapLeadUnread.put(listLeads[i].Id, listLeads[i].IsUnreadByOwner);			

				}
			
			}			
		
		}
		
		// Get a List of Opportunities that match our Campaign Members
		// system.debug('$$$$ --> leadIDsToProcessTrimmed = ' + leadIDsToProcessTrimmed);
		List <Opportunity> listOpportunities = [Select Lead_ID__c, StageName from Opportunity Where Lead_ID__c in :leadIDsToProcess]; 
		
		system.debug('$$$$ --> listOpportunities.size() = ' + listOpportunities.size());
		
		if (listOpportunities.size() != 0){
		
			for (integer i=0;i<listOpportunities.size();i++){
			
				mapContainsKey = mapOpportintyStatus.containsKey(listOpportunities[i].Lead_ID__c);
			
				if (mapContainsKey == false){
			
					system.debug('$$$$ --> Oppty StageName = ' + listOpportunities[i].StageName);
					mapOpportintyStatus.put(listOpportunities[i].Lead_ID__c, listOpportunities[i].StageName);

				}
			
			}			
		
		}

		
		// Iterate through our records and update the Lead Information
		for (integer i=0;i<trigger.New.size();i++){
		
			trigger.New[i].Lead_Status__c = mapLeadStatus.get(trigger.New[i].LeadID);
			trigger.New[i].Lead_Unread__c = mapLeadUnread.get(trigger.New[i].LeadID);
			
			trigger.New[i].Opportunity_Stage__c = mapOpportintyStatus.get(trigger.New[i].LeadID);
		
		}
		
		system.debug('$$$$ --> End of Before + Insert/Update Trigger');

	}
	
	if ( (trigger.isAfter) && ((trigger.isInsert) || (trigger.isUpdate)) ){

		//

		system.debug('$$$$ --> Start of After - Insert/Update Trigger');
	
		for (integer i=0;i<trigger.New.size();i++){
		
			listCampaignIDs.Add(trigger.new[i].CampaignID);	
			
		}	
	
		// Call method to rollup hierarchy totals
		 CampaignCustomRollups.initCampaignRollupHierarchy(listCampaignIDs);

		system.debug('$$$$ --> End of After - Insert/Update Trigger');

		// 
		
	}

	if ( (trigger.isAfter) && (trigger.isDelete) ){

		system.debug('$$$$ --> Start of After - Delete Trigger');
	
		for (integer i=0;i<trigger.Old.size();i++){
		
			listCampaignIDs.Add(trigger.Old[i].CampaignID);	
			
		}	
	
		// Call method to rollup hierarchy totals
		CampaignCustomRollups.initCampaignRollupHierarchy(listCampaignIDs);

		system.debug('$$$$ --> End of After - Delete Trigger');
				
	}	
	
	*/
}