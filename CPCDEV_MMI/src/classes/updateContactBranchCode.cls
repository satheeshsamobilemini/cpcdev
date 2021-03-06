public with sharing class updateContactBranchCode {

	Public Static VOID updateBranchCodesOnContact(List<ID> ownerIds, List<Contact> contactsToUpdate){
	
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
		for (integer i=0;i<contactsToUpdate.size();i++){
			contactsToUpdate[i].branch__c = userToBranchCodeMap.get(contactsToUpdate[i].OwnerId);
		}
	
	}
	
	static testMethod void myUnitTest() {
	
		User salesRep1 = [Select Id, Branch_Id__c from User where Branch_id__c = '101' and isActive = true LIMIT 1];

		User salesRep2 = [Select Id, Branch_Id__c from User where Branch_id__c = '102' and isActive = true LIMIT 1];
	
		Account newAccount = New Account(Name='Test Account', ownerid=salesRep1.Id);

		insert newAccount;
		
		Contact newContact = New Contact(LastName = 'Test APEX Contact', AccountID = newAccount.Id);
		
		insert newContact;

		newContact.ownerid = salesRep2.Id;
		
		update newContact;

		Contact queryNewContact = [Select Id, Branch__c from Contact where Id = :newContact.Id];
		system.assertEquals(queryNewContact.Branch__c, salesRep2.Branch_Id__c);

		delete newAccount;
	
	}

}