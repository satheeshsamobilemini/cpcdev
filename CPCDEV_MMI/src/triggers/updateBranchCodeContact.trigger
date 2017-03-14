trigger updateBranchCodeContact on Contact (before insert, before update) {

	// Creates a map between User ID and the User's branch code
	Map<ID, String> userBranchCode = New Map<ID, String>();
	List<ID> ownerIds = New List<ID>();
	List<Contact> contactsToUpdate = New List<Contact>();

	Private String BranchUserID = '';	
	List<Branch_Account_User_id__c> BranchAccountIdList = null;
    BranchAccountIdList = Branch_Account_User_id__c.getAll().Values();

    if(test.isRunningTest()){
		User branchAccountUserID = [Select Id from User where name = 'Branch Account'];
		BranchUserID = branchAccountUserID.Id;
    }else{
	    if(BranchAccountIdList != null && !BranchAccountIdList.isEmpty()){
			BranchUserID = BranchAccountIdList.get(0).User_Id__c;	
	}
	}	

	if (trigger.isInsert){
	
		for (integer i=0;i<trigger.new.size();i++){
			// only process if the owner is not "Branch Account"
			if (trigger.new[i].ownerId != BranchUserID){
				ownerIds.add(trigger.new[i].OwnerId);
				contactsToUpdate.add(trigger.new[i]);
			}
		}
	
	}

	if (trigger.isUpdate){
	
		for (integer i=0;i<trigger.new.size();i++){
			// only process if the owner has changed AND the owner is not "Branch Account"
			if ((trigger.new[i].ownerId != trigger.old[i].ownerId) && trigger.new[i].ownerId != BranchUserID){
				ownerIds.add(trigger.new[i].OwnerId);
				contactsToUpdate.add(trigger.new[i]);
			}
			
			// for MSM 87 issue..
			if((trigger.new[i].ownerId == trigger.old[i].ownerId) && trigger.new[i].ownerId != BranchUserID){
				system.debug( '---------- trigger.new[i].ownerId ----------' + trigger.new[i].ownerId);
				system.debug(' ----------- trigger.old[i].ownerId ---------' + trigger.old[i].ownerId);
				ownerIds.add(trigger.new[i].OwnerId);
				contactsToUpdate.add(trigger.new[i]);
			}
		}
	
	}
	
	// Do we need to process any contacts?
	if (contactsToUpdate.size()>0){
		updateContactBranchCode.updateBranchCodesOnContact(ownerIds, contactsToUpdate);
	}

}