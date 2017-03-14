trigger AccountCopyDescriptiontoSpecInstructions on Account (before insert) {

	/*

	for (Account acct : Trigger.new){
	
		if (acct.Special_Instructions__c == NULL && acct.Description != NULL){
		
			acct.Special_Instructions__c = acct.Description;
		
		}
	
	}

	*/

	/*

	// We need this code since we cannot map this field in Lead conversion

	Lead[] leads = [Select Id, Description, ConvertedAccountId from Lead where ConvertedAccountId in :trigger.new];

	// Build a Map of ConvertedAccountID to Description
	
	Map<ID, String> mapConvertedAccountIDtoDescription = New Map<ID, String>();

	for (integer i=0;i<leads.size();i++){

		if (mapConvertedAccountIDtoDescription.containsKey(leads[i].ConvertedAccountId) == false){		
			mapConvertedAccountIDtoDescription.put(leads[i].ConvertedAccountId, leads[i].Description);
		}
	
	}
	
	// See if we have found any Lead Conversions
	System.Debug('$$$$$$ --> Number of Converted Leads = ' + leads.size());
	
	if (leads.size() > 1){
		
		// Get the Accounts that matched
		Account[] accts = [Select Id, Special_Instructions__c from Account where Id in :mapConvertedAccountIDtoDescription.keySet()];
	
		// Loop through our new Accounts
		for (integer x=0;x<accts.size();x++){
		
			if (mapConvertedAccountIDtoDescription.containsKey(accts[x].Id) == true){
				accts[x].Special_Instructions__c = mapConvertedAccountIDtoDescription.get(accts[x].Id);

			}
		
		}
			

	}
	
	*/
	
}