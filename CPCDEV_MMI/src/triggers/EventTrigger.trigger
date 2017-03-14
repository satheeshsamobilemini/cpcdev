/********************************************************************************
Name : EventTrigger 
Created by : Luke Slevin
Created Date : 9th Oct , 2013
Description : Story : S-133221 :Refactor Triggers
********************************************************************************/
trigger EventTrigger on Event (after delete, after insert, after update, 
before insert, before update) {
	Map<Id, Opportunity> oppsToUpdate = new Map<Id, Opportunity>();
	
	// Creates a map between User ID and the User's branch code
	Map<ID, String> userBranchCode = New Map<ID, String>();
	List<ID> ownerIds = New List<ID>();
	List<Event> eventsToUpdate = New List<Event>();

	Private String BranchUserID = '';	
	try{
		User branchAccountUserID = [Select Id from User where name = 'Branch Account'];
		BranchUserID = branchAccountUserID.Id;
	}

	catch (QueryException e) {
		System.debug('Query Issue: ' + e);
	}	
	
	//UpdateBranchCodeEvent Logic
	if(trigger.isBefore) {
		
		if (trigger.isInsert){
	
			for (integer i=0;i<trigger.new.size();i++){
				// only process if the owner is not "Branch Account"
				if (trigger.new[i].ownerId != BranchUserID){
					ownerIds.add(trigger.new[i].OwnerId);
					eventsToUpdate.add(trigger.new[i]);
				}
			}
		}

		if (trigger.isUpdate){
	
			for (integer i=0;i<trigger.new.size();i++){
				// only process if:
				// the owner has changed AND the owner is not "Branch Account"
				// OR
				// Branch__c is currently null
				if (((trigger.new[i].ownerId != trigger.old[i].ownerId) && trigger.new[i].ownerId != BranchUserID) || ((trigger.old[i].Branch__c == '') || (trigger.old[i].Branch__c == null))){
					ownerIds.add(trigger.new[i].OwnerId);
					eventsToUpdate.add(trigger.new[i]);
				}
			}
		}
	
		// Do we need to process any Events?
		if (eventsToUpdate.size()>0){
			updateEventBranchCode.updateBranchCodesOnEvent(ownerIds, eventsToUpdate);
		}	
	}
	
	//SetScheduledActivityDate Logic
	if(trigger.isAfter)	{
		
		if(Trigger.isInsert || Trigger.isUpdate){
       		oppsToUpdate = ActivityManagement.updateNextActivityOnOpportunity(null ,Trigger.new, oppsToUpdate );
   	 	}else if(Trigger.isDelete){
       		oppsToUpdate = ActivityManagement.updateNextActivityOnOpportunity(null ,Trigger.old , oppsToUpdate );
    	}
    	
    //Update Opportunities
    if(oppsToUpdate.size() > 0 )
        update oppsToUpdate.values();
	}
}