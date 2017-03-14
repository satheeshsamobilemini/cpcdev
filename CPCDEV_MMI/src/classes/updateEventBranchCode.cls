public with sharing class updateEventBranchCode {

	Public Static VOID updateBranchCodesOnEvent(List<ID> ownerIds, List<Event> eventsToUpdate){
	
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
		for (integer i=0;i<eventsToUpdate.size();i++){
			eventsToUpdate[i].branch__c = userToBranchCodeMap.get(eventsToUpdate[i].OwnerId);
		}
	
	}
	
	static testMethod void myUnitTest() {
	
		User salesRep1 = [Select Id, Branch_Id__c from User where Branch_id__c = '101' and isActive = true LIMIT 1];

		User salesRep2 = [Select Id, Branch_Id__c from User where Branch_id__c = '102' and isActive = true LIMIT 1];
		
		datetime myDateTime = datetime.now();	
		
		Event newEvent = New Event(Subject = 'Test APEX Task', DurationInMinutes = 60, ActivityDateTime = myDateTime,OwnerID = salesRep1.Id);
		
		insert newEvent;

		newEvent.ownerid = salesRep2.Id;
		
		update newEvent;

		Event queryNewEvent = [Select Id, Branch__c from Event where Id = :newEvent.Id];
		system.assertEquals(queryNewEvent.Branch__c, salesRep2.Branch_Id__c);

		delete newEvent;
			
	}


}