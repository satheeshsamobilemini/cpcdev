trigger JobProfileUpdatePostalCode on Job_Profile__c (before insert, before update) {
 
if(TriggerSwitch.isTriggerExecutionFlagDisabled('Job_Profile__c','JobProfileUpdatePostalCode')){
        return;
    }


  /*
  
    Populates the value of Branch Id and Territory (TFS-3726) for a Job Site based on Zip code
    
    Used to sort Job Sites by Branch
    
    Test Cases: TESTJobProfileUpdatePostalCode.cls
  
  */

  List<String> postalCodes = New List<String>();
  List<Job_Profile__c> jobProfileList = New List<Job_Profile__c>();
  Map<String, String> postalCodetoBranchCodeMap = New Map<String, String>();
  Map<String, String> postalCodetoTerritoryMap = New Map<String, String>();                   // TFS 3726
  Map<String, String> unmodifiedPostalCodetoPostalCodeMap = New Map<String, String>();
  Map<String,User> territorytoUserMap = New Map<String,User>(); // Sales Restructure 2015
  Set<String> territorySet = New Set<String>(); // Sales Restructure 2015
  String postalCode = '';
  Id currentUserId = UserInfo.getUserId();
  String currentUserRole = '';
  
  // Get a list of Postal Codes and Dodge Projects we need to update
  
  if (trigger.isInsert){

    for (integer i=0;i<trigger.new.size();i++){
      if (trigger.new[i].Job_Site_Zip__c != NULL && trigger.new[i].Job_Site_Zip__c != ''){
        postalCode = AssignmentRules.getConvertedZipCode(trigger.new[i].Job_Site_Zip__c, trigger.new[i].Job_Site_Country__c);
        postalCodes.add(postalCode);
        jobProfileList.add(trigger.new[i]);
        unmodifiedPostalCodetoPostalCodeMap.put(trigger.new[i].Job_Site_Zip__c, postalCode);
        
      }
    }

  }    

  if (trigger.isUpdate){
  
    for (integer i=0;i<trigger.new.size();i++){
      
      // Job_Site_Zip__c has changed and is not NULL
      if ( ((trigger.new[i].Job_Site_Zip__c != trigger.old[i].Job_Site_Zip__c) || trigger.new[i].isTerritoryUpdate__c || trigger.new[i].isTerritoryChange__c) && (trigger.new[i].Job_Site_Zip__c != NULL) && (trigger.new[i].Job_Site_Zip__c != '') ){
        postalCode = AssignmentRules.getConvertedZipCode(trigger.new[i].Job_Site_Zip__c, trigger.new[i].Job_Site_Country__c);
        postalCodes.add(postalCode);
        jobProfileList.add(trigger.new[i]);
        unmodifiedPostalCodetoPostalCodeMap.put(trigger.new[i].Job_Site_Zip__c, postalCode);
        trigger.new[i].isTerritoryChange__c = false;
      }
      
      // Job_Site_Zip__c has changed and is NULL
      else if ( (trigger.new[i].Job_Site_Zip__c != trigger.old[i].Job_Site_Zip__c || trigger.new[i].isTerritoryUpdate__c) && ((trigger.new[i].Job_Site_Zip__c == NULL) || (trigger.new[i].Job_Site_Zip__c == '')) ){
        trigger.new[i].Branch_ID__c = NULL;
        trigger.new[i].Territory__c = NULL;                                        // TFS 3726
      }
      
    }    
  
  }

  if (postalCodes.size() > 0){

    // Query the list of Postal Codes
    Branch_Lookup__c[] bl = [Select Zip__c, Branch_Code__c,Territory__c from Branch_Lookup__c  Where Zip__c in :postalCodes];
  
    // Create a map of Postal Code to Branch ID
    for (integer i=0;i<bl.size();i++){
      postalCodetoBranchCodeMap.put(bl[i].Zip__c, bl[i].Branch_Code__c);
      postalCodetoTerritoryMap.put(bl[i].Zip__c, bl[i].Territory__c);                      // TFS 3726
    }
    
    territorySet.addAll(postalCodetoTerritoryMap.values());  // Sales Restructure 2015
    
    // Query the list of Territory Owners - Sales Restructure 2015
    User[] uList = [select Id,Territory__c,UserRole.Name from User where isActive = true and ((UserRole.Name like 'Sales Rep%'and Territory__c in :territorySet) or id =:currentUserId)];
        
    //Create a map of Territory to Territory Owner
     for(integer i=0;i<uList.size();i++){
       if(uList[i].Territory__c <> null && territorySet.contains(uList[i].Territory__c) && uList[i].UserRole.Name.contains('Sales Rep')){
        territorytoUserMap.put(uList[i].Territory__c,uList[i]);
       }
       if(uList[i].Id == currentUserId){
        currentUserRole = uList[i].UserRole.Name;
       }    
     }  
    
    // loop through our records and populate Branch_ID__C
    for (integer i=0;i<jobProfileList.size();i++){
      if (postalCodetoBranchCodeMap.containsKey(unmodifiedPostalCodetoPostalCodeMap.get(jobProfileList[i].Job_Site_Zip__c)) 
            && postalCodetoTerritoryMap.containsKey(unmodifiedPostalCodetoPostalCodeMap.get(jobProfileList[i].Job_Site_Zip__c))){
        
        jobProfileList[i].Branch_ID__c = postalCodetoBranchCodeMap.get(unmodifiedPostalCodetoPostalCodeMap.get(jobProfileList[i].Job_Site_Zip__c));
        jobProfileList[i].Territory__c = postalCodetoTerritoryMap.get(unmodifiedPostalCodetoPostalCodeMap.get(jobProfileList[i].Job_Site_Zip__c));
   
      }
      else{
        jobProfileList[i].Branch_ID__c = NULL;
        jobProfileList[i].Territory__c = NULL;                                          // TFS 3726
      }
     
     // Sales Restructure 2015
     if(jobProfileList[i].Territory__c<>NULL && territorytoUserMap.containsKey(jobProfileList[i].Territory__c)){
        jobProfileList[i].JP_TerritoryOwner__c = territorytoUserMap.get(jobProfileList[i].Territory__c).Id;
     } 
         
     if(trigger.isInsert && jobProfileList[i].JP_TerritoryOwner__c<>NULL && !jobProfileList[i].isEmailNotify_Owner__c && (currentUserRole.contains('Branch Manager')||currentUserRole.contains('Sales Rep'))){
       jobProfileList[i].OwnerId = jobProfileList[i].JP_TerritoryOwner__c; 
       jobProfileList[i].isEmailNotify__c = true;
      }
    }  
  }
}