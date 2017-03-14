public with sharing class updateTaskBranchCode {

	Public Static VOID updateBranchCodesOnTask(List<ID> ownerIds, List<Task> tasksToUpdate){
	
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
		for (integer i=0;i<tasksToUpdate.size();i++){
			tasksToUpdate[i].branch__c = userToBranchCodeMap.get(tasksToUpdate[i].OwnerId);
		}
	
	}
	
	static testMethod void myUnitTest() {
	
		User salesRep1 = [Select Id, Branch_Id__c from User where Branch_id__c = '101' and isActive = True LIMIT 1];

		User salesRep2 = [Select Id, Branch_Id__c from User where Branch_id__c = '102' and isActive = True LIMIT 1];
	
		Task newTask = New Task(Subject = 'Test APEX Task', Call_Type__c = 'Live Chat', OwnerID = salesRep1.Id);
		
		insert newTask;

		newTask.ownerid = salesRep2.Id;
		
		update newTask;

		Task queryNewTask = [Select Id, Branch__c from Task where Id = :newTask.Id];
		//system.assertEquals(queryNewTask.Branch__c, salesRep2.Branch_Id__c);

		delete newTask;
			
	}

}