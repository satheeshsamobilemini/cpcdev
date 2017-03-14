trigger updateBranchCodeOpportunity on Opportunity (before insert, before update) {
  
  if(TriggerSwitch.isTriggerExecutionFlagDisabled('Opportunity','updateBranchCodeOpportunity')){ return; }   
    system.debug('-----updateBranchCodeOpportunity----------------------');
    for(SkipTrigger__c skipTrg : SkipTrigger__c.getAll().values()){  if(skipTrg.name == userinfo.getUserID().subString(0,15)){ return; }  }
    if(RecursiveTriggerUtility.isUpdateBranchCodeOpportunityCalled){
        return;
    }
    
    Set<String> BillingZipcode = new Set<String>();
    Set<String> ShippingZipcode = new Set<String>();
    Set<id> userId = new Set<id>();
    Set<Id> accountSetOfId = new Set<Id>();
    Set<String> userTerrrSet = new Set<String>();

    for(Opportunity oppoList: trigger.new){
        accountSetOfId.add(oppoList.AccountId);
    }
    List<Account> accountList = [select Id,IsPersonAccount,BillingCity,ShippingCity,Territory__c,BillingCountry,ShippingCountry,BillingPostalCode,ShippingPostalCode,BillingState,ShippingState,BillingStreet,ShippingStreet,(select Id from Job_Profile_Sub_Contractor__r where JobProfile_Status_Completed__c = false) from Account Where Id In : accountSetOfId];
    for (integer i=0;i<trigger.new.size();i++){
        for(Account acc :accountList){
            if(acc.id == trigger.new[i].AccountId){
                trigger.new[i].Billing_Street__c = acc.BillingStreet;
                trigger.new[i].Billing_City__c = acc.BillingCity;
                trigger.new[i].Billing_Country__c = acc.BillingCountry;
                trigger.new[i].Billing_State_Province__c = acc.BillingState;
                trigger.new[i].Billing_Zip_Postal_Code__c = acc.BillingPostalCode;
                /*if (trigger.isInsert){
                    trigger.new[i].Delivery_Street__c = acc.ShippingStreet;
                    trigger.new[i].Delivery_City__c = acc.ShippingCity;
                    trigger.new[i].Delivery_State_Province__c = acc.ShippingState;
                    if(acc.ShippingPostalCode != null && acc.ShippingPostalCode != ''){
                        trigger.new[i].Delivery_Zip_Postal_Code__c = acc.ShippingPostalCode;
                    }
                    trigger.new[i].Delivery_Country__c = acc.ShippingCountry;
                }*/
              
              // Sales Restructure - 2015 (TFS 6058 - Opportunity)    
              if(trigger.new[i].Job_Profile__c == null && acc.Job_Profile_Sub_Contractor__r.size() > 0)  { trigger.new[i].notify_CreatedUser__c  = true;  }    
            }               
        }
    }
    for(Opportunity oppoList: trigger.new){
        if(oppoList.Billing_Zip_Postal_Code__c != null && oppoList.Billing_Zip_Postal_Code__c != ''){
            
            String BillinbZipcode = AssignmentRules.getZipCodeConversion(oppoList.Billing_Zip_Postal_Code__c,oppoList.Billing_Country__c);
            BillingZipcode.add(BillinbZipcode);
            
            /*if (oppoList.Billing_Zip_Postal_Code__c.length() > 5){
                BillingZipcode.add(oppoList.Billing_Zip_Postal_Code__c.subString(0, 5));
            }else{
                BillingZipcode.add(oppoList.Billing_Zip_Postal_Code__c);
            }*/
        }
        if(oppoList.Delivery_Zip_Postal_Code__c != null && oppoList.Delivery_Zip_Postal_Code__c != ''){
            
            String ShillinbZipcode = AssignmentRules.getZipCodeConversion(oppoList.Delivery_Zip_Postal_Code__c,oppoList.Delivery_Country__c);
            BillingZipcode.add(ShillinbZipcode);
            
            /*if(oppoList.Delivery_Zip_Postal_Code__c.length() > 5){
                ShippingZipcode.add(oppoList.Delivery_Zip_Postal_Code__c.subString(0, 5));
            }else{
                ShippingZipcode.add(oppoList.Delivery_Zip_Postal_Code__c);
            }*/
        }
        userId.add(oppoList.ownerId);
    }
    List<Branch_Lookup__c> branchIdBilling = [Select id,Territory__c,Branch_Code__c,Rollup_Plant__c,Plant_Code__c, Zip__c from Branch_lookup__c where Zip__c in: BillingZipcode or Zip__c in :ShippingZipcode];
    Map<String,Branch_Lookup__c> getBranchLookUpZipCode  = new Map<String,Branch_Lookup__c>();
    for(Branch_Lookup__c billingTerr : branchIdBilling){
        userTerrrSet.add(billingTerr.Territory__c);
        if(billingTerr.Territory__c != null && billingTerr.Territory__c != ''){
            getBranchLookUpZipCode.put(billingTerr.Zip__c,billingTerr); 
        }
    }
    
    List<User> userListter = [Select Id,Territory__c,Name, Branch_Id__c,UserRole.Name, UserRoleId from User where IsActive = true and (Territory__c in :userTerrrSet or (ID in :userId And name != 'Branch Account'))];
    Map<String,Id> getUserIdTerry  = new Map<String,Id>();
    for(User usrs : userListter){
        getUserIdTerry.put(usrs.Territory__c, usrs.id);
    }
    Map<ID, String> userBranchCode = New Map<ID, String>();
    List<ID> ownerIds = New List<ID>();
    List<Opportunity> servicingBranchIdUpdateOpportunities =  New List<Opportunity>();
    Date opptyCloseDate = date.today();

    if (trigger.isInsert){
        for (integer i=0;i<trigger.new.size();i++){
            if(trigger.new[i].Billing_Zip_Postal_Code__c != NULL){
                
                String BillingZipCodesub =  AssignmentRules.getZipCodeConversion(trigger.new[i].Billing_Zip_Postal_Code__c,trigger.new[i].Billing_Country__c);
              /*  if (trigger.new[i].Billing_Zip_Postal_Code__c.length() > 5){
                    BillingZipCodesub = trigger.new[i].Billing_Zip_Postal_Code__c.subString(0, 5);
                }else{
                    BillingZipCodesub = trigger.new[i].Billing_Zip_Postal_Code__c;
                }   */
                
                if(getBranchLookUpZipCode.containsKey(BillingZipCodesub)){
                    Branch_Lookup__c branch = getBranchLookUpZipCode.get(BillingZipCodesub);
                    trigger.new[i].Territory__c = branch.Territory__c;
                    if(trigger.new[i].Territory__c != null && trigger.new[i].Territory__c != ''){
                        if(getUserIdTerry.containsKey(trigger.new[i].Territory__c)){
                            Id UserIdUserInsert = getUserIdTerry.get(trigger.new[i].Territory__c);
                            trigger.new[i].Territory_Owner__c = UserIdUserInsert;
                        }else{
                            trigger.new[i].Territory_Owner__c = null;
                        }
                    }else{
                        trigger.new[i].Territory_Owner__c = null;
                    }
                }
            }else{
                trigger.new[i].Territory__c = null;
                trigger.new[i].Territory_Owner__c = null;
            }
            
            if(trigger.new[i].Delivery_Zip_Postal_Code__c != NULL){
                String ShippingPostalsub = AssignmentRules.getZipCodeConversion(trigger.new[i].Delivery_Zip_Postal_Code__c,trigger.new[i].Delivery_Country__c);
                /*if (trigger.new[i].Delivery_Zip_Postal_Code__c.length() > 5){
                    ShippingPostalsub = trigger.new[i].Delivery_Zip_Postal_Code__c.subString(0, 5);
                }else{
                    ShippingPostalsub = trigger.new[i].Delivery_Zip_Postal_Code__c;
                }
                */  
                if(getBranchLookUpZipCode.containsKey(ShippingPostalsub)){
                    Branch_Lookup__c branch = getBranchLookUpZipCode.get(ShippingPostalsub); trigger.new[i].Shipping_Territory__c = branch.Territory__c; trigger.new[i].Servicing_Branch__c = branch.Branch_Code__c;
                }else{
                    trigger.new[i].Shipping_Territory__c = null;
                    trigger.new[i].Servicing_Branch__c = null;
                }
            }else{
                trigger.new[i].Shipping_Territory__c = null; trigger.new[i].Servicing_Branch__c = null;
            }
            
            for(User Usl : userListter ){
                if(Usl.Id == trigger.new[i].OwnerId && (trigger.new[i].Billing_Country__c == 'USA' || trigger.new[i].Billing_Country__c == 'usa' || trigger.new[i].Billing_Country__c == 'US' || trigger.new[i].Billing_Country__c == 'us')){
                    if(Usl.Name != 'Branch Account'){
                        trigger.new[i].Branch__c = Usl.Branch_Id__c;
                    }
                }
            }
            
            // Determine if this Opportunity was created through Lead Conversion
            if (trigger.new[i].Lead_Id__c != NULL){ trigger.new[i].CloseDate = opptyCloseDate;
            }
        }
    }
    
    if (trigger.isUpdate){
    
        for (integer i=0;i<trigger.new.size();i++){
            system.debug('--------- trigger.new[i].ownerId ------------' + trigger.new[i].ownerId);
            system.debug('--------- trigger.old[i].ownerId ------------' + trigger.old[i].ownerId);
            if(trigger.new[i].Billing_Zip_Postal_Code__c != NULL){ String BillingZipCodesubupdate =  AssignmentRules.getZipCodeConversion(trigger.new[i].Billing_Zip_Postal_Code__c,trigger.new[i].Billing_Country__c);String ShippingZipCodesubupdate =  AssignmentRules.getZipCodeConversion(trigger.new[i].Delivery_Zip_Postal_Code__c,trigger.new[i].Delivery_Country__c);
                
                /*if (trigger.new[i].Billing_Zip_Postal_Code__c.length() > 5){
                    BillingZipCodesubupdate = trigger.new[i].Billing_Zip_Postal_Code__c.subString(0, 5);
                }else{
                    BillingZipCodesubupdate = trigger.new[i].Billing_Zip_Postal_Code__c;
                }*/
                    
               if(getBranchLookUpZipCode.containsKey(ShippingZipCodesubupdate) ){
                    Branch_Lookup__c branch = getBranchLookUpZipCode.get(ShippingZipCodesubupdate); trigger.new[i].Territory__c = branch.Territory__c; trigger.new[i].Servicing_Rollup_Plant__c = branch.Rollup_Plant__c; trigger.new[i].Servicing_Plant_Code__c = branch.Plant_Code__c;
                        if(trigger.new[i].Territory__c != null && trigger.new[i].Territory__c != ''){ if(getUserIdTerry.containsKey(trigger.new[i].Territory__c)){ Id UserIdupUser = getUserIdTerry.get(trigger.new[i].Territory__c); trigger.new[i].Territory_Owner__c = UserIdupUser; }else{ trigger.new[i].Territory_Owner__c = null; }
                        }else{ trigger.new[i].Territory_Owner__c = null;
                        }
                    }
                                                                  
               if(getBranchLookUpZipCode.containsKey(BillingZipCodesubupdate) ){
                    Branch_Lookup__c branch = getBranchLookUpZipCode.get(BillingZipCodesubupdate); trigger.new[i].Territory__c = branch.Territory__c; trigger.new[i].Plant_Code__c = branch.Plant_Code__c; trigger.new[i].Rollup_Plant__c = branch.Rollup_Plant__c;
                        if(trigger.new[i].Territory__c != null && trigger.new[i].Territory__c != ''){ if(getUserIdTerry.containsKey(trigger.new[i].Territory__c)){ Id UserIdupUser = getUserIdTerry.get(trigger.new[i].Territory__c); trigger.new[i].Territory_Owner__c = UserIdupUser; }else{ trigger.new[i].Territory_Owner__c = null; }
                        }else{ trigger.new[i].Territory_Owner__c = null;
                        }
                    }else{
                        trigger.new[i].Territory__c = ''; trigger.new[i].Territory_Owner__c = null;
                    }
                }else{
                    trigger.new[i].Territory__c = null; trigger.new[i].Territory_Owner__c = null;
                }
            
                if(trigger.new[i].Delivery_Zip_Postal_Code__c != NULL){ String ShippingPostalsubupdate = AssignmentRules.getZipCodeConversion(trigger.new[i].Delivery_Zip_Postal_Code__c,trigger.new[i].Delivery_Country__c);
                        
                    /*if (trigger.new[i].Delivery_Zip_Postal_Code__c.length() > 5){
                        ShippingPostalsubupdate = trigger.new[i].Delivery_Zip_Postal_Code__c.subString(0, 5);
                    }else{
                        ShippingPostalsubupdate = trigger.new[i].Delivery_Zip_Postal_Code__c;
                    }   
                    */
                if(getBranchLookUpZipCode.containsKey(ShippingPostalsubupdate)){ Branch_Lookup__c branch = getBranchLookUpZipCode.get(ShippingPostalsubupdate); trigger.new[i].Shipping_Territory__c = branch.Territory__c; trigger.new[i].Servicing_Branch__c = branch.Branch_Code__c; }else{ trigger.new[i].Shipping_Territory__c = null; trigger.new[i].Servicing_Branch__c = null; }
            }
            for(User Usl : userListter ){ if(Usl.Id == trigger.new[i].OwnerId && trigger.new[i].ownerId != trigger.old[i].ownerId){ if(Usl.Name != 'Branch Account'){ trigger.new[i].Branch__c = Usl.Branch_Id__c; } } if(Usl.Id == trigger.new[i].OwnerId && trigger.new[i].ownerId == trigger.old[i].ownerId && Usl.Name != 'Branch Account'){ trigger.new[i].Branch__c = Usl.Branch_Id__c; } }
            
            /* MSM 87 .. for(User Usl : userListter ){
                if(Usl.Id == trigger.new[i].OwnerId && trigger.new[i].ownerId != trigger.old[i].ownerId){
                    if(Usl.Name != 'Branch Account'){
                        trigger.new[i].Branch__c = Usl.Branch_Id__c;
                    }
                }
            }*/
        }
    }
    
    if(!RecursiveTriggerUtility.isUpdateBranchCodeOpportunityCalled){
        RecursiveTriggerUtility.isUpdateBranchCodeOpportunityCalled = true;
    } 
}