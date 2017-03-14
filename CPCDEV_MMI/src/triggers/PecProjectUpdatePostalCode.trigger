trigger PecProjectUpdatePostalCode on Pec_Project__c (before insert, before update) {

    /*
    
        Populates the values of Branch Id for a Pec project based on Zip code
        
        Used to sort Pec Projects by Branch
        
        Test Cases: TESTPecProjectUpdatePostalCode.cls
    
    */

    List<String> postalCodes = New List<String>();
    List<Pec_Project__c> PecList = New List<Pec_Project__c>();
    Map<String, String> postalCodetoBranchCodeMap = New Map<String, String>();
    Map<String, String> postalCodetoTerritoryMap = New Map<String, String>();    // MSM 48
    Map<String, String> unmodifiedPostalCodetoPostalCodeMap = New Map<String, String>();
    String postalCode = '';
    
    // Get a list of Postal Codes and Pec Projects we need to update
    
    if (trigger.isInsert){

        for (integer i=0;i<trigger.new.size();i++){
            if (trigger.new[i].zip__c != NULL && trigger.new[i].zip__c != ''){
                postalCode = AssignmentRules.getConvertedZipCode(trigger.new[i].zip__c, trigger.new[i].Country__c);
                postalCodes.add(postalCode);
                PecList.add(trigger.new[i]);
                unmodifiedPostalCodetoPostalCodeMap.put(trigger.new[i].Zip__c, postalCode);
            }
        }

    }       

    if (trigger.isUpdate){
    
        for (integer i=0;i<trigger.new.size();i++){
            
            // Zip__c has changed and is not NULL
            system.debug('@@trigger.new[i].zip__c'+trigger.new[i].zip__c);
            system.debug('@@trigger.old[i].zip__c'+trigger.old[i].zip__c);
            
            if ( (trigger.new[i].zip__c != trigger.old[i].zip__c) && (trigger.new[i].zip__c != NULL) && (trigger.new[i].zip__c != '') ){
                postalCode = AssignmentRules.getConvertedZipCode(trigger.new[i].zip__c, trigger.new[i].Country__c);
                postalCodes.add(postalCode);
                system.debug('@@postalCodes'+postalCodes);
                PecList.add(trigger.new[i]);
                unmodifiedPostalCodetoPostalCodeMap.put(trigger.new[i].Zip__c, postalCode);
            }
            
            // Zip__c has changed and is NULL
            else if ( (trigger.new[i].zip__c != trigger.old[i].zip__c) && ((trigger.new[i].zip__c == NULL) || (trigger.new[i].zip__c == '')) ){
            	trigger.new[i].Branch_ID__c = NULL;
                trigger.new[i].Territory__c = NULL;  // MSM 48
           }
            
        }       
    
    }

    // Query the list of Postal Codes
    Branch_Lookup__c[] bl = [Select Zip__c, Branch_Code__c,Territory__c from Branch_Lookup__c  Where Zip__C in :postalCodes];

    // Create a map of Postal Code to Branch ID and Postal Code to Territory 
    for (integer i=0;i<bl.size();i++){
        postalCodetoBranchCodeMap.put(bl[i].Zip__c, bl[i].Branch_Code__c);
        postalCodetoTerritoryMap.put(bl[i].Zip__c, bl[i].Territory__c);
        
    }   
    // loop through our records and populate Branch_ID__C
    for (integer i=0;i<PecList.size();i++){
            system.debug('@@postalCodetoBranchCodeMap.get(unmodifiedPostalCodetoPostalCodeMap.get(PecList[i].Zip__c))'+postalCodetoBranchCodeMap.get(unmodifiedPostalCodetoPostalCodeMap.get(PecList[i].Zip__c)));
            system.debug('@@postalCodetoTerritoryMap.get(unmodifiedPostalCodetoPostalCodeMap.get(PecList[i].Zip__c))'+postalCodetoTerritoryMap.get(unmodifiedPostalCodetoPostalCodeMap.get(PecList[i].Zip__c)));
        
        if (postalCodetoBranchCodeMap.containsKey(unmodifiedPostalCodetoPostalCodeMap.get(PecList[i].Zip__c))  || postalCodetoTerritoryMap.containskey(unmodifiedPostalCodetoPostalCodeMap.get(PecList[i].Zip__c))){
            PecList[i].Branch_ID__c = postalCodetoBranchCodeMap.get(unmodifiedPostalCodetoPostalCodeMap.get(PecList[i].Zip__c));
            PecList[i].Territory__c = postalCodetoTerritoryMap.get(unmodifiedPostalCodetoPostalCodeMap.get(PecList[i].Zip__c));
            system.debug('@@PecList[i].Branch_ID__c'+PecList[i].Branch_ID__c);
            system.debug('@@PecList[i].Territory__c'+PecList[i].Territory__c);
        }
        else{
            PecList[i].Branch_ID__c = NULL;
            PecList[i].Territory__c = NULL;
            
            system.debug('in else to make it null');
        }
    }   
}