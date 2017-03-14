trigger VehicleReg_UpdateBranchMGR on Vehicle_Registration_Tracking__c (before insert, before update) {

	// Finds the branch manager given a branch ID

	List<String> BranchIds = New List<String>();

	if (trigger.isInsert){

		// Get the list of Branch IDs
		for (integer i=0;i<trigger.new.size();i++){
		
			BranchIds.add(trigger.new[i].Branch_ID__c);
		
		}
	
	}
	
	if (trigger.isUpdate){

		// Get the list of Branch IDs
		for (integer i=0;i<trigger.new.size();i++){
		
			// Only bother if the value has changed
			if (trigger.new[i].Branch_ID__c != trigger.old[i].Branch_ID__c){
				
				BranchIds.add(trigger.new[i].Branch_ID__c);
			
			}
				
		}
	
	}
	
	// Do we have any Branch Managers to lookup?
	if (BranchIds.size() > 0){
	
		// Create a map of Branch ID --> Branch Manager
		Map<String, ID> branchMGRMap = New Map<String, ID>();
	
		User[] branchManagers = [select id, branch_id__c from user where branch_id__c in :BranchIds and IsActive = True and UserRole.Name like 'Branch Manager%'];
		
		for (integer x=0;x<branchManagers.size();x++){
		
			branchMGRMap.put(branchManagers[x].branch_id__c, branchManagers[x].Id);
		
		}
		
		for (integer y=0;y<trigger.new.size();y++){
			
			if ( branchMGRMap.containsKey(trigger.new[y].Branch_ID__c) == true ){
				trigger.new[y].Branch_Manager__c = branchMGRMap.get(trigger.new[y].Branch_ID__c);
			}
		
		}
	
	}
	
}