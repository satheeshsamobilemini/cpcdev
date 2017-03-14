Public with sharing class CampaignCustomRollups {

	Public Static Boolean isInFuture = FALSE;

	Public Static VOID initCampaignRollupHierarchy(List <ID> listCampaignIDs){
		
		if (isInFuture == FALSE){
			isInFuture = TRUE;
			kickOffRollups(listCampaignIDs);
			isInFuture = FALSE;
		}

	}
	
	@Future Public Static VOID kickOffRollups(List <ID> listCampaignIDs){
		campaignRollupHierarchy(listCampaignIDs);
	}
	
	Public Static void campaignRollupHierarchy(List <ID> listCampaignIDs){

		// system.debug('$$$$ --> Start of campaignRollupHierarchy');
		// system.debug('$$$$ --> Number of Non-Unique Campaign IDs: ' + listCampaignIDs.size());

		List <ID> listParentCampaignIDs = New List <ID>();	
		List <ID> listCampaignswithChildren = New List <ID>();
		
		Boolean mapContainsKey = false;

		// Create a list of Campaigns and see if any of the campaigns have a parent
		Campaign[] c = [select id, Name, ParentID, Number_of_Leads_Dead__c, Total_Dead_Leads_in_Hierarchy__c, Number_of_Leads_Open__c, Total_Open_Leads_in_Hierarchy__c, Number_of_Leads_Unread__c, Total_Unread_Leads_in_Hierarchy__c from Campaign where ID in :listCampaignIDs];

		// system.debug('$$$$ --> Number of Campaigns Records: ' + c.size());

		Map <ID, Boolean> mapHasChildren = hasChildren(listCampaignIDs);

		// Get the list of the Parent Campaigns
		for (integer i=0;i<c.size();i++){
	
			if (c[i].ParentID != NULL){
				listParentCampaignIDs.Add(c[i].ParentID);
			}
			
		}

		// Roll up the hierarchy data for this Level
		campaignRollupChildren(listCampaignIDs, mapHasChildren);

		// Call the function again if we have parent campaigns
		if (listParentCampaignIDs.size() > 0){
		
			// system.debug('$$$$ --> Calling campaignRollupHierarchy recursively');
			campaignRollupHierarchy(listParentCampaignIDs);
		
		}
	
		// system.debug('$$$$ --> End of campaignRollupHierarchy');
	
	}
	
	Public Static Map <ID, Boolean> hasChildren (List <ID> listCampaignIDs){
	
		// system.debug('$$$$ --> Start of hasChildren');
	
		Map <ID, Boolean> childCampaigns = New Map <ID, Boolean>();
		Map <ID, Boolean> mapHasChildren = New Map <ID, Boolean>();
	
		Boolean mapContainsKey = false;
	
		List <Campaign> listChildCampaigns = [select ID, ParentID from Campaign Where ParentID in :listCampaignIDs];
		
		// system.debug('$$$$ --> listChildCampaigns.size=' + listChildCampaigns.size());
	
		for (integer i=0;i<listChildCampaigns.size();i++){
		
			mapContainsKey = childCampaigns.containsKey(listChildCampaigns[i].ParentID);
			
			if (mapContainsKey == false){
				
				childCampaigns.put(listChildCampaigns[i].ParentID, true);
				
			}
		
		}
		
		// loop trough the list of campaign IDs we passed in to see if they exist in the map childCampaigns
		for (integer i=0;i<listCampaignIDs.size();i++){
		
			mapContainsKey = childCampaigns.containsKey(listCampaignIDs[i]);
			
			mapHasChildren.put(listCampaignIDs[i], mapContainsKey);
		
		}

		// system.debug('$$$$ --> mapHasChildren (C ID, Has Children)=' + mapHasChildren);
		// system.debug('$$$$ --> End of hasChildren');
			
		return mapHasChildren;
	}
	
	Public Static VOID campaignRollupChildren (List <ID> listCampaignIDs, Map <ID, Boolean> mapHasChildren){
	
		// system.debug('$$$$ --> Start of campaignRollupChildren');
	
		Campaign[] parentCampaigns = [select id, ParentID, Name, Number_of_Leads_Dead__c, Number_of_Leads_Open__c, Number_of_Leads_Unread__c, Num_of_Lost_Opportunites__c, Num_of_Pending_Opportunities__c from Campaign where ID in :listCampaignIDs Order By ID];
		Campaign[] childCampaigns = [select id, ParentID, Name, Number_of_Leads_Dead__c, Number_of_Leads_Open__c, Number_of_Leads_Unread__c, Num_of_Lost_Opportunites__c, Num_of_Pending_Opportunities__c, Total_Dead_Leads_in_Hierarchy__c, Total_Open_Leads_in_Hierarchy__c, Total_Unread_Leads_in_Hierarchy__c, Total_Lost_Opportunities_in_Hierarchy__c, Total_Pending_Opportunities_in_Hierarchy__c from Campaign where ParentID in :listCampaignIDs Order By ID];

		// system.debug('$$$$ --> childCampaigns size=' + childCampaigns.size());
		// system.debug('$$$$ --> parentCampaigns size=' + parentCampaigns.size());

			for (integer i=0;i<parentCampaigns.size();i++){

				// system.debug('$$$$ --> Current parentCampaigns i=' + i + ' (' + parentCampaigns[i].Name + ')');

				// Zero these out since we are going to recalculate
				parentCampaigns[i].Total_Dead_Leads_in_Hierarchy__c = 0;
				parentCampaigns[i].Total_Open_Leads_in_Hierarchy__c = 0;
				parentCampaigns[i].Total_Unread_Leads_in_Hierarchy__c = 0;
				parentCampaigns[i].Total_Pending_Opportunities_in_Hierarchy__c = 0;
				parentCampaigns[i].Total_Lost_Opportunities_in_Hierarchy__c = 0;
				
				// See if this campaign has children
				// If it does not, copy the values 
				if (mapHasChildren.get(parentCampaigns[i].Id) == FALSE){
				
					parentCampaigns[i].Total_Dead_Leads_in_Hierarchy__c = parentCampaigns[i].Number_of_Leads_Dead__c;
					parentCampaigns[i].Total_Open_Leads_in_Hierarchy__c = parentCampaigns[i].Number_of_Leads_Open__c;
					parentCampaigns[i].Total_Unread_Leads_in_Hierarchy__c = parentCampaigns[i].Number_of_Leads_Unread__c;
					parentCampaigns[i].Total_Pending_Opportunities_in_Hierarchy__c = parentCampaigns[i].Num_of_Pending_Opportunities__c;
					parentCampaigns[i].Total_Lost_Opportunities_in_Hierarchy__c = parentCampaigns[i].Num_of_Lost_Opportunites__c;
				}

				else{

					for (integer x=0;x<childCampaigns.size();x++){
					
						if (parentCampaigns[i].Id == childCampaigns[x].ParentId){
	
							// system.debug('$$$$ --> ID Check Parent: ' + parentCampaigns[i].Id + ' (' + parentCampaigns[i].Name + ')');
							// system.debug('$$$$ --> ID Check Child: ' + childCampaigns[x].ParentId + ' (' + childCampaigns[x].Name + ')');

							/*
							// system.debug('$$$$ --> parentCampaigns[i].Total_Dead_Leads_in_Hierarchy__c=' + parentCampaigns[i].Total_Dead_Leads_in_Hierarchy__c);
							// system.debug('$$$$ --> parentCampaigns[i].Total_Open_Leads_in_Hierarchy__c=' + parentCampaigns[i].Total_Open_Leads_in_Hierarchy__c);
							// system.debug('$$$$ --> parentCampaigns[i].Total_Unread_Leads_in_Hierarchy__c=' + parentCampaigns[i].Total_Unread_Leads_in_Hierarchy__c);
							// system.debug('$$$$ --> childCampaigns[x].Number_of_Leads_Dead__c=' + childCampaigns[x].Number_of_Leads_Dead__c);
							// system.debug('$$$$ --> childCampaigns[x].Number_of_Leads_Open__c=' + childCampaigns[x].Number_of_Leads_Open__c);
							// system.debug('$$$$ --> childCampaigns[x].Number_of_Leads_Unread__c=' + childCampaigns[x].Number_of_Leads_Unread__c);
							*/
							
							parentCampaigns[i].Total_Dead_Leads_in_Hierarchy__c = parentCampaigns[i].Total_Dead_Leads_in_Hierarchy__c + parentCampaigns[i].Number_of_Leads_Dead__c + childCampaigns[x].Total_Dead_Leads_in_Hierarchy__c;
							parentCampaigns[i].Total_Open_Leads_in_Hierarchy__c = parentCampaigns[i].Total_Open_Leads_in_Hierarchy__c + parentCampaigns[i].Number_of_Leads_Open__c + childCampaigns[x].Total_Open_Leads_in_Hierarchy__c;
							parentCampaigns[i].Total_Unread_Leads_in_Hierarchy__c = parentCampaigns[i].Total_Unread_Leads_in_Hierarchy__c + parentCampaigns[i].Number_of_Leads_Unread__c + childCampaigns[x].Total_Unread_Leads_in_Hierarchy__c;
							
							parentCampaigns[i].Total_Pending_Opportunities_in_Hierarchy__c = parentCampaigns[i].Total_Pending_Opportunities_in_Hierarchy__c + parentCampaigns[i].Num_of_Pending_Opportunities__c + childCampaigns[x].Total_Pending_Opportunities_in_Hierarchy__c;
							parentCampaigns[i].Total_Lost_Opportunities_in_Hierarchy__c = parentCampaigns[i].Total_Lost_Opportunities_in_Hierarchy__c + parentCampaigns[i].Num_of_Lost_Opportunites__c + childCampaigns[x].Total_Lost_Opportunities_in_Hierarchy__c;
							
						}
					
					}

				}
			
			}
	
		// system.debug('$$$$ --> End of campaignRollupChildren');
		
		update parentCampaigns;
	}
	
}