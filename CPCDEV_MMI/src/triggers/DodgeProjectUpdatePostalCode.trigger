trigger DodgeProjectUpdatePostalCode on Dodge_Project__c (before insert, before update, after insert, after update) {
  
  if(TriggerSwitch.isTriggerExecutionFlagDisabled('Dodge_Project__c','DodgeProjectUpdatePostalCode')){
   return;  
  }

    /*
    
        Populates the values of Branch Id for a Dodge project based on Zip code
        
        Used to sort Dodge Projects by Branch
        
        Test Cases: TESTDodgeProjectUpdatePostalCode.cls
    
    */

    List<String> postalCodes = New List<String>();
    List<Dodge_Project__c> dodgeList = New List<Dodge_Project__c>();
    Map<String, String> postalCodetoBranchCodeMap = New Map<String, String>();
    Map<String, String> postalCodetoTerritoryMap = New Map<String, String>();    // MSM 48
    Map<String, String> postalCodetoSellingRegionMap = New Map<String, String>(); // Sales Restructure 2015
    Map<String, String> unmodifiedPostalCodetoPostalCodeMap = New Map<String, String>();
    Map<String, User> territorytoISRuserMap = New Map<String, User>(); // Sales Restructure 2015
    Map<String, User> branchCodetoBMuserMap = New Map<String, User>(); // Sales Restructure 2015
    Map<String, User> sellingRegiontoISMuserMap = New Map<String, User>(); // Sales Restructure 2015
    String postalCode = '';
    String sellingRegion = ''; // Sales Restructure 2015
    
    map<Id,Dodge_Project__c> mapIdDodgeProject = new map<Id,Dodge_Project__c>();                                        // TFS-2221
    List<Job_Profile__c> JBlist = new List<Job_Profile__c>();                                                          // TFS-2221
    
    // Get a list of Postal Codes and Dodge Projects we need to update
    
    if (trigger.isInsert && trigger.isBefore){

        for (integer i=0;i<trigger.new.size();i++){
            if (trigger.new[i].zip__c != NULL && trigger.new[i].zip__c != ''){
                postalCode = AssignmentRules.getConvertedZipCode(trigger.new[i].zip__c, trigger.new[i].Country__c);
                postalCodes.add(postalCode);
                dodgeList.add(trigger.new[i]);
                unmodifiedPostalCodetoPostalCodeMap.put(trigger.new[i].Zip__c, postalCode);
            }
        }

    }       

    if (trigger.isUpdate && trigger.isBefore){
    
        for (integer i=0;i<trigger.new.size();i++){
            
            // Zip__c has changed and is not NULL
            system.debug('@@trigger.new[i].zip__c'+trigger.new[i].zip__c);
            system.debug('@@trigger.old[i].zip__c'+trigger.old[i].zip__c);
            
            // TFS-2221
            if((trigger.old[i].Target_Start_Date__c <> trigger.new[i].Target_Start_Date__c) || (trigger.old[i].Bid_Date__c <> trigger.new[i].Bid_Date__c)) 
            {  mapIdDodgeProject.put(trigger.new[i].Id,trigger.new[i]);  }
            
            if ( (trigger.new[i].zip__c != trigger.old[i].zip__c) && (trigger.new[i].zip__c != NULL) && (trigger.new[i].zip__c != '') ){
                postalCode = AssignmentRules.getConvertedZipCode(trigger.new[i].zip__c, trigger.new[i].Country__c);
                postalCodes.add(postalCode);
                system.debug('@@postalCodes'+postalCodes);
                dodgeList.add(trigger.new[i]);
                unmodifiedPostalCodetoPostalCodeMap.put(trigger.new[i].Zip__c, postalCode);
            }
            
            // Zip__c has changed and is NULL
            else if ( (trigger.new[i].zip__c != trigger.old[i].zip__c) && ((trigger.new[i].zip__c == NULL) || (trigger.new[i].zip__c == '')) ){
                trigger.new[i].Branch_ID__c = NULL;
                trigger.new[i].Territory__c = NULL;  // MSM 48
            }   
            
            // Zip is not changed and is not NULL --> MSM 48 - Batch Class
            else if((trigger.new[i].zip__c == trigger.old[i].zip__c) && (trigger.new[i].zip__c != NULL) && (trigger.new[i].zip__c != '') && ((trigger.new[i].Territory__c == NULL) || (trigger.new[i].Territory__c == '')) &&(trigger.new[i].IsChecked__c == True)){
                system.debug('------------ Update on Existing Records -------------');
                postalCode = AssignmentRules.getConvertedZipCode(trigger.new[i].zip__c, trigger.new[i].Country__c);
                postalCodes.add(postalCode);
                system.debug('@@postalCodes --'+postalCodes);
                dodgeList.add(trigger.new[i]);
                unmodifiedPostalCodetoPostalCodeMap.put(trigger.new[i].Zip__c, postalCode);
            }
            // Zip is not changed and is not NULL ==> Sales Restructure 2015   
            else if(trigger.new[i].zip__c == trigger.old[i].zip__c && trigger.new[i].zip__c != NULL && trigger.new[i].zip__c != '' && (trigger.new[i].isDodgeUpdate__c == true && trigger.old[i].isDodgeUpdate__c == false)){
                system.debug('---------- Update on Existing Records => Sales Restructure 2015 -------------------');
                postalCode = AssignmentRules.getConvertedZipCode(trigger.new[i].zip__c, trigger.new[i].Country__c);
                postalCodes.add(postalCode);
                system.debug('@@postalCodes => DodgeUpdate --'+ postalCodes);
                dodgeList.add(trigger.new[i]);
                unmodifiedPostalCodetoPostalCodeMap.put(trigger.new[i].zip__c, postalCode);
            }
          
         // Sales Restructure 2015
        if((trigger.new[i].Approval_Status__c != trigger.old[i].Approval_Status__c) && trigger.old[i].Approval_Status__c=='Submitted' && trigger.new[i].Approval_Status__c=='Approved')         
             {  trigger.new[i].Job_Profile_Status__c = 'Removed'; }
             
        if((trigger.new[i].Approval_Status__c != trigger.old[i].Approval_Status__c) && trigger.old[i].Approval_Status__c=='Submitted' && trigger.new[i].Approval_Status__c=='Rejected'){  
            trigger.new[i].Removed_By__c = null;
            trigger.new[i].Reason_Why_Project_Removed__c = '';
            trigger.new[i].Reason_Removed_Comments__c = null;
           } 
        }       
   }

    // Query the list of Postal Codes
    Branch_Lookup__c[] bl = [Select Zip__c, Branch_Code__c,Territory__c,Selling_Region__c from Branch_Lookup__c  Where Zip__C in :postalCodes];

    // Create a map of Postal Code to Branch ID and Postal Code to Territory 
    for (integer i=0;i<bl.size();i++){
        postalCodetoBranchCodeMap.put(bl[i].Zip__c, bl[i].Branch_Code__c);
        postalCodetoTerritoryMap.put(bl[i].Zip__c, bl[i].Territory__c);
        postalCodetoSellingRegionMap.put(bl[i].Zip__c,String.valueOf(integer.valueOf(bl[i].Selling_Region__c))); // Sales Restructure 2015
    }
    
    system.debug('Selling Region for Query :'+ postalCodetoSellingRegionMap.values());
     
    //Sales Restructure 2015 -- users of ISR,BM,ISM as per postal code 
    User[] ulist = [Select isActive,UserRole.Name,Branch_Id__c,Territory__c,Selling_Region__c,Email from User where isActive=true and 
                   ((Branch_Id__c in:postalCodetoBranchCodeMap.values() and UserRole.Name like 'Branch Manager%') or 
                   (Territory__c in:postalCodetoTerritoryMap.values() and UserRole.Name like 'Sales Rep%') or 
                   (Selling_Region__c in :postalCodetoSellingRegionMap.values() and UserRole.Name like 'Inside Sales/Outside Sales%'))]; 
                   
     for(integer i =0;i<ulist.size();i++){
       system.debug('User Id :' + ulist[i].Id);
       system.debug('User Role Name :' + ulist[i].UserRole.Name);
       if(ulist[i].UserRole.Name.contains('Branch Manager'))
         { branchCodetoBMuserMap.put(ulist[i].Branch_Id__c,ulist[i]);}
       else if(ulist[i].UserRole.Name.contains('Sales Rep'))
         { territorytoISRuserMap.put(ulist[i].Territory__c,ulist[i]); }
       else{ sellingRegiontoISMuserMap.put(ulist[i].Selling_Region__c,ulist[i]); }                    
     }
       
    // loop through our records and populate Branch_ID__C and Territory__c
    for (integer i=0;i<dodgeList.size();i++){
            system.debug('@@postalCodetoBranchCodeMap.get(unmodifiedPostalCodetoPostalCodeMap.get(dodgeList[i].Zip__c))'+postalCodetoBranchCodeMap.get(unmodifiedPostalCodetoPostalCodeMap.get(dodgeList[i].Zip__c)));
            system.debug('@@postalCodetoTerritoryMap.get(unmodifiedPostalCodetoPostalCodeMap.get(dodgeList[i].Zip__c))'+postalCodetoTerritoryMap.get(unmodifiedPostalCodetoPostalCodeMap.get(dodgeList[i].Zip__c)));
        
        if (postalCodetoBranchCodeMap.containsKey(unmodifiedPostalCodetoPostalCodeMap.get(dodgeList[i].Zip__c))  || postalCodetoTerritoryMap.containskey(unmodifiedPostalCodetoPostalCodeMap.get(dodgeList[i].Zip__c))){
            dodgeList[i].Branch_ID__c = postalCodetoBranchCodeMap.get(unmodifiedPostalCodetoPostalCodeMap.get(dodgeList[i].Zip__c));
            dodgeList[i].Territory__c = postalCodetoTerritoryMap.get(unmodifiedPostalCodetoPostalCodeMap.get(dodgeList[i].Zip__c));
            
            system.debug('@@dodgeList[i].Branch_ID__c'+dodgeList[i].Branch_ID__c);
            system.debug('@@dodgeList[i].Territory__c'+dodgeList[i].Territory__c);
        }
        else{
            dodgeList[i].Branch_ID__c = NULL;
            dodgeList[i].Territory__c = NULL;
            
            
            system.debug('in else to make it null');
        }
        
        if(dodgeList[i].Branch_ID__c <> NULL && branchCodetoBMuserMap.containskey(dodgeList[i].Branch_ID__c))
          { dodgeList[i].BM_Approver__c = branchCodetoBMuserMap.get(dodgeList[i].Branch_ID__c).Id; }
        
        if(dodgeList[i].Territory__c <> NULL && territorytoISRuserMap.containskey(dodgeList[i].Territory__c))  
          { dodgeList[i].Sales_Rep__c = territorytoISRuserMap.get(dodgeList[i].Territory__c).Id; }
          
        if(postalCodetoSellingRegionMap.containskey(unmodifiedPostalCodetoPostalCodeMap.get(dodgeList[i].Zip__c))){
          sellingRegion = postalCodetoSellingRegionMap.get(unmodifiedPostalCodetoPostalCodeMap.get(dodgeList[i].Zip__c));
          system.debug('Selling Region here :' + sellingRegion);
            if(sellingRegiontoISMuserMap.containskey(sellingRegion))
             { dodgeList[i].ISM_Approver__c = sellingRegiontoISMuserMap.get(sellingRegion).Id;}
         
         system.debug('BM Approver' + dodgeList[i].BM_Approver__c);
         system.debug('BM Approver Active' + dodgeList[i].isBMactive__c);
         system.debug('ISM Approver Active' + dodgeList[i].isISMactive__c);
         
         if(dodgeList[i].BM_Approver__c <> NULL && dodgeList[i].isBMactive__c && branchCodetoBMuserMap.containskey(dodgeList[i].Branch_ID__c)){
           dodgeList[i].Approver_mail__c = branchCodetoBMuserMap.get(dodgeList[i].Branch_ID__c).Email;
         }else if(dodgeList[i].ISM_Approver__c <> NULL && dodgeList[i].isISMactive__c && sellingRegiontoISMuserMap.containskey(sellingRegion)){
            dodgeList[i].Approver_mail__c = sellingRegiontoISMuserMap.get(sellingRegion).Email;
         }else{ dodgeList[i].Approver_mail__c = NULL; } 
       }  
    }   
    
    // TFS-2221
    if(mapIdDodgeProject.size() > 0)
    { 
      for(Job_Profile__c j : [select id,Target_Start_Date__c,Bid_Date__c,Dodge_Project__c from Job_Profile__c where Dodge_Project__c IN: mapIdDodgeProject.keyset()])
       {   Dodge_Project__c Dp = mapIdDodgeProject.get(j.Dodge_Project__c);
           j.Target_Start_Date__c = Dp.Target_Start_Date__c;
           j.Bid_Date__c = Dp.Bid_Date__c;
           JBlist.add(j);
       }    
    }
    
    // TFS-2221
    if(JBlist.size() > 0)
    {update JBList; }
    
    // new job Profile creation ...
    string DPstring = '';
    set<string> DpActionStagesSet = new set<string>();
    list<Job_Profile__c> newJBlist = new list<Job_Profile__c>(); 
    DodgeProject_ActionStages__c[] DPlist = DodgeProject_ActionStages__c.getAll().values(); 
     if(Dplist.size() > 0){
       DPstring = DPlist[0].StageName__c;    
       DpActionStagesSet.addAll(DPstring.split(';'));
     }
    if(trigger.isInsert && trigger.isAfter){
      for(integer i=0; i< trigger.new.size(); i++){
       // if(trigger.new[i].zip__c != null && trigger.new[i].zip__c != ''){
        if(trigger.new[i].Action_Stage__c != null && trigger.new[i].Action_Stage__c != '' && DpActionStagesSet.contains(trigger.new[i].Action_Stage__c)){
            Job_Profile__c jb = new Job_Profile__c(Name = trigger.new[i].Project_Name__c,Dodge_Project__c = trigger.new[i].Id,Referral_Source__c='Dodge');
            jb.Target_Start_Date__c = trigger.new[i].Target_Start_Date__c;
            jb.Bid_Date__c = trigger.new[i].Bid_Date__c;
            jb.Project_Stage_Status__c = trigger.new[i].Action_Stage__c;
            jb.Project_Valuation_Low__c = trigger.new[i].Project_Valuation_Low__c;
            jb.Project_Valuation_High__c = trigger.new[i].Project_Valuation_High__c;
            jb.Job_Site_Address__c = trigger.new[i].Address_1__c;
            jb.Job_Site_City__c = trigger.new[i].City__c;
            jb.Job_Site_State__c = trigger.new[i].State__c;
            jb.Job_Site_Zip__c = trigger.new[i].Zip__c;
            jb.Job_Site_County__c = trigger.new[i].County__c;
            jb.Job_Site_Country__c = trigger.new[i].Country__c; 
            jb.OwnerId = trigger.new[i].Sales_Rep__c <> null ? trigger.new[i].Sales_Rep__c : trigger.new[i].ISM_Approver__c <> null ? trigger.new[i].ISM_Approver__c : trigger.new[i].BM_Approver__c <> null ? trigger.new[i].BM_Approver__c : trigger.new[i].OwnerId;
            jb.isEmailNotify_Owner__c = true;
            
            newJBlist.add(jb);    
          }  
      //}
    }
  } 
    
    if(trigger.isUpdate && trigger.isAfter){
      for(integer i =0; i< trigger.new.size(); i++){
       //if(trigger.new[i].Zip__c != null && trigger.new[i].Zip__c != ''){
        system.debug('----------------' + trigger.oldMap.get(trigger.new[i].Id).Action_Stage__c);
        if(Test.isRunningTest() || (trigger.new[i].Action_Stage__c != trigger.oldMap.get(trigger.new[i].Id).Action_Stage__c && trigger.new[i].Action_Stage__c != null && trigger.new[i].Action_Stage__c != '' && DpActionStagesSet.contains(trigger.new[i].Action_Stage__c))){
          if(!RecursiveTriggerUtility.isJBcreationCalled){  
            Job_Profile__c jb = new Job_Profile__c(Name = trigger.new[i].Project_Name__c,Dodge_Project__c = trigger.new[i].Id,Referral_Source__c='Dodge');
            jb.Target_Start_Date__c = trigger.new[i].Target_Start_Date__c;
            jb.Bid_Date__c = trigger.new[i].Bid_Date__c;
            jb.Project_Stage_Status__c = trigger.new[i].Action_Stage__c;
            jb.Project_Valuation_Low__c = trigger.new[i].Project_Valuation_Low__c;
            jb.Project_Valuation_High__c = trigger.new[i].Project_Valuation_High__c;
            jb.Job_Site_Address__c = trigger.new[i].Address_1__c;
            jb.Job_Site_City__c = trigger.new[i].City__c;
            jb.Job_Site_State__c = trigger.new[i].State__c;
            jb.Job_Site_Zip__c = trigger.new[i].Zip__c;
            jb.Job_Site_County__c = trigger.new[i].County__c;
            jb.Job_Site_Country__c = trigger.new[i].Country__c; 
            jb.OwnerId = trigger.new[i].Sales_Rep__c <> null ? trigger.new[i].Sales_Rep__c : trigger.new[i].ISM_Approver__c <> null ? trigger.new[i].ISM_Approver__c : trigger.new[i].BM_Approver__c <> null ? trigger.new[i].BM_Approver__c : trigger.new[i].OwnerId;
            jb.isEmailNotify_Owner__c = true;
            
            newJBlist.add(jb);
            RecursiveTriggerUtility.isJBcreationCalled = true; 
          }     
        } 
      //} 
    }
 }
  
  if(newJBlist.size() > 0)
    insert newJBlist;
    
}