trigger ABIProjectUpdateBranchID on ABI_Project__c (before insert, before update) {

	/*
	
		Populates the values of Branch Id for an ABI project based on Zip code
		
		Used to sort ABI Projects by Branch
		
		Test Cases: TESTABIProjectUpdateBranchID.cls
	
	*/

	List<String> postalCodes = New List<String>();
	List<abi_Project__c> abiList = New List<abi_Project__c>();
	Map<String, String> postalCodetoBranchCodeMap = New Map<String, String>();
	Map<String, String> unmodifiedPostalCodetoPostalCodeMap = New Map<String, String>();
	String postalCode = '';
	
	// Get a list of Postal Codes and abi Projects we need to update
	
	if (trigger.isInsert){

		for (integer i=0;i<trigger.new.size();i++){
			if (trigger.new[i].Ptpcode__c != NULL && trigger.new[i].Ptpcode__c != ''){
				postalCode = AssignmentRules.getConvertedZipCode(trigger.new[i].Ptpcode__c, 'UK');
				postalCodes.add(postalCode);
				abiList.add(trigger.new[i]);
				unmodifiedPostalCodetoPostalCodeMap.put(trigger.new[i].Ptpcode__c, postalCode);
			}
		}

	}		

	if (trigger.isUpdate){
	
		for (integer i=0;i<trigger.new.size();i++){
			
			// Ptpcode__c has changed and is not NULL
			if ( (trigger.new[i].Ptpcode__c != trigger.old[i].Ptpcode__c) && (trigger.new[i].Ptpcode__c != NULL) && (trigger.new[i].Ptpcode__c != '') ){
				postalCode = AssignmentRules.getConvertedZipCode(trigger.new[i].Ptpcode__c, 'UK');
				postalCodes.add(postalCode);
				abiList.add(trigger.new[i]);
				unmodifiedPostalCodetoPostalCodeMap.put(trigger.new[i].Ptpcode__c, postalCode);
			}
			
			// Ptpcode__c has changed and is NULL
			else if ( (trigger.new[i].Ptpcode__c != trigger.old[i].Ptpcode__c) && ((trigger.new[i].Ptpcode__c == NULL) || (trigger.new[i].Ptpcode__c == '')) ){
				trigger.new[i].Branch_ID__c = NULL;
			}
			
		}		
	
	}

	// Query the list of Postal Codes
	Branch_Lookup__c[] bl = [Select Zip__c, Branch_Code__c from Branch_Lookup__c  Where Zip__C in :postalCodes];

	// Create a map of Postal Code to Branch ID
	for (integer i=0;i<bl.size();i++){
		postalCodetoBranchCodeMap.put(bl[i].Zip__c, bl[i].Branch_Code__c);
	}	
	
	// loop through our records and populate Branch_ID__C
	for (integer i=0;i<abiList.size();i++){
		if (postalCodetoBranchCodeMap.containsKey(unmodifiedPostalCodetoPostalCodeMap.get(abiList[i].Ptpcode__c))){
			abiList[i].Branch_ID__c = postalCodetoBranchCodeMap.get(unmodifiedPostalCodetoPostalCodeMap.get(abiList[i].Ptpcode__c));
		}
		else{
			abiList[i].Branch_ID__c = NULL;
		}
	}
	
}