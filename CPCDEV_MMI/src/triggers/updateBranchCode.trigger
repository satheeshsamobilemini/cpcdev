trigger updateBranchCode on Account (before insert, before update) {
    system.debug('------updateBranchCode----');
 if(TriggerSwitch.isTriggerExecutionFlagDisabled('Account','updateBranchCode')){   return;    }     
     for(SkipTrigger__c skipTrg : SkipTrigger__c.getAll().values()){  if(skipTrg.name == userinfo.getUserID().subString(0,15)){   return;  }   }
    Set<Id> sicCodeSetOfId = new Set<id>();
    Set<String> BillingZipcode = new Set<String>();
    Set<String> ShippingZipcode = new Set<String>();
    Set<id> userId = new Set<id>();
  
    for(Account accrec : trigger.new){
        if(accrec.Sic_Code__c != null){ sicCodeSetOfId.add(accrec.Sic_Code__c);   }
        
        if(accrec.BillingPostalCode != null && accrec.BillingPostalCode != ''){  String BillinbZipcode = AssignmentRules.getZipCodeConversion(accrec.BillingPostalCode,accrec.BillingCountry);  system.debug('-----BillinbZipcode--------'+BillinbZipcode); BillingZipcode.add(BillinbZipcode); }
        
        if(accrec.ShippingPostalCode != null && accrec.ShippingPostalCode != ''){ String ShillinbZipcode = AssignmentRules.getZipCodeConversion(accrec.ShippingPostalCode,accrec.ShippingCountry);          BillingZipcode.add(ShillinbZipcode);   }
        
        /*if(accrec.BillingPostalCode != null && accrec.BillingPostalCode != ''){
            getZipCodeConversion(accrec.BillingPostalCode,accrec.BillingCountry);
            if (accrec.BillingPostalCode.length() > 5){
                BillingZipcode.add(accrec.BillingPostalCode.subString(0, 5));
              }else{
                BillingZipcode.add(accrec.BillingPostalCode);
            }
        }
        if(accrec.ShippingPostalCode != null && accrec.ShippingPostalCode != ''){
            if (accrec.ShippingPostalCode.length() > 5){
                ShippingZipcode.add(accrec.ShippingPostalCode.subString(0, 5));
              }else{
                ShippingZipcode.add(accrec.ShippingPostalCode);
            }
            
        }*/
        system.debug('-----accrec.ownerId---'+accrec.ownerId);
        userId.add(accrec.ownerId);
        system.debug('----userId--'+userId);
    }
    
    // NumericPhoneUpdationOnAccount trigger code : change by : Tek systems(3rd March 2014) 
    
        Set<String> creditCollectorId = new Set<String>();
        List<Account> accountToBeUpdate = new List<Account>();
        Set<String> nationalAccountNumbers = new Set<String>();
        boolean isAdded = false;
        for( Account aAccount : trigger.new){
            if( aAccount.phone != null ){ aAccount.NumericPhone__c = Utils.processNumericPhone(aAccount.phone); }else{
                aAccount.NumericPhone__c = null;
            }
            
            if(aAccount.Credit_Collector__c != null){ creditCollectorId.add(aAccount.Credit_Collector__c); accountToBeUpdate.add(aAccount);   isAdded = true;          }
            
            if(aAccount.National_Account_Pricing_From_Result__c != null){ nationalAccountNumbers.add(aAccount.National_Account_Pricing_From_Result__c);  if(!isAdded){ accountToBeUpdate.add(aAccount); }   }
        }
        
        Map<String,String> creditCollectorMap = new Map<String,String>();
        Map<String,String> nationalAccountNumberInSFDCMap = new Map<String, String>(); 
        String creditCollectorName;
        String nationalAccountNumber;
        
         
        List<Sic_Code_Lookup__c> sicCodeList = new List<Sic_Code_Lookup__c>();
        List<Branch_Lookup__c> branchIdBilling  = new List<Branch_Lookup__c>();
        Map<String,Branch_Lookup__c> getBranchLookUpZipCode  = new Map<String,Branch_Lookup__c>();
        Map<String,Branch_Lookup__c> getBranchLookUpZipCodeshippinng  = new Map<String,Branch_Lookup__c>();
        List<User> userList = new List<User>();
        List<National_Account_Pricing_Information__c> NationalAccountList = new List<National_Account_Pricing_Information__c>();
        
        if(ShippingZipcode.size() > 0){ if(RecursiveTriggerUtility.isUpdateservicingBranch == false){ branchIdBilling = [Select id,Territory__c,Branch_Code__c, Zip__c,Country__c from Branch_lookup__c where Zip__c in: ShippingZipcode]; for(Branch_lookup__c branch : branchIdBilling){ getBranchLookUpZipCodeshippinng.put(branch.Zip__c,branch);   }   RecursiveTriggerUtility.isUpdateservicingBranch = true;        }            }
        //if(BillingZipcode.size() > 0 ){
            if(RecursiveTriggerUtility.isSicUpdate == false){ 
                if(!RecursiveTriggerUtility.isBranchCodeUserQueryCalled){
                    userList = [Select Id,Territory__c, Branch_Id__c,Name, Collection_Controller_Number__c,Extension__c,UserRole.Name, UserRoleId from User where ID in :userId or Collection_Controller_Number__c in : creditCollectorId];
                    RecursiveTriggerUtility.isBranchCodeUserQueryCalled = true;
                }
                if(BillingZipcode.size() > 0 ){
                    sicCodeList = [Select s.SystemModstamp, s.OwnerId, s.Name, s.LastModifiedDate, s.LastModifiedById, s.IsDeleted, s.Industry__c, s.Id, s.Description__c, s.CurrencyIsoCode, s.CreatedDate, s.CreatedById From Sic_Code_Lookup__c s where id IN :sicCodeSetOfId]; branchIdBilling = [Select id,Territory__c,Branch_Code__c, Zip__c ,Country__c from Branch_lookup__c where Zip__c in: BillingZipcode or Zip__c in: ShippingZipcode];
                    //userList = [Select Id,Territory__c, Branch_Id__c,Name, Collection_Controller_Number__c,Extension__c,UserRole.Name, UserRoleId from User where ID in :userId or Collection_Controller_Number__c in : creditCollectorId];
                    
                    for(User u : userList ){   creditCollectorName = u.Name;   if(u.Extension__c != null){    creditCollectorName += ' ' + '- '+u.Extension__c;  }           creditCollectorMap.put(u.Collection_Controller_Number__c,creditCollectorName);           }
                  
                    for(National_Account_Pricing_Information__c nap : [select National_Account_Pricing_from_Result__c, National_Account_Pricing_In_SFDC__c from National_Account_Pricing_Information__c where National_Account_Pricing_from_Result__c in : nationalAccountNumbers]){ nationalAccountNumberInSFDCMap.put(nap.National_Account_Pricing_from_Result__c,nap.National_Account_Pricing_In_SFDC__c);                }
                    
                    for(Branch_lookup__c branch : branchIdBilling){  getBranchLookUpZipCode.put(branch.Zip__c,branch);      }      RecursiveTriggerUtility.isSicUpdate = true;             }
            }
        //}     
        
        for(Account acc : accountToBeUpdate){
            if(acc.credit_Collector__c != null && creditCollectorMap.containsKey(acc.credit_Collector__c)){  acc.Credit_Collector_Name__c = creditCollectorMap.get(acc.credit_Collector__c);   }else{      acc.Credit_Collector_Name__c ='';     }
            if(acc.National_Account_Pricing_From_Result__c != null && nationalAccountNumberInSFDCMap.containsKey(acc.National_Account_Pricing_From_Result__c)){       acc.National_Account_Pricing__c = nationalAccountNumberInSFDCMap.get(acc.National_Account_Pricing_From_Result__c);  }else{    acc.National_Account_Pricing__c = '';   }   }     
    // SIC code lookup logic by : TEK systems
    // Territory Field update logic by : TEK systems
    
    
    if(trigger.isInsert){ 
        for(integer i=0;i<trigger.new.size();i++){
            if(trigger.new[i].BillingPostalCode != NULL){
                String BillingZipCodesub = AssignmentRules.getZipCodeConversion(trigger.new[i].BillingPostalCode,trigger.new[i].BillingCountry);
             
            /*  if (trigger.new[i].BillingPostalCode.length() > 5){
                    BillingZipCodesub = trigger.new[i].BillingPostalCode.subString(0, 5);
                }else{
                    BillingZipCodesub = trigger.new[i].BillingPostalCode;
                }   */
                
                if(getBranchLookUpZipCode.containsKey(BillingZipCodesub)){
                    Branch_Lookup__c branch = getBranchLookUpZipCode.get(BillingZipCodesub);
                    trigger.new[i].Territory__c = branch.Territory__c;
                }else{
                    trigger.new[i].Territory__c = '';
                }
            }else{
                trigger.new[i].Territory__c = '';
            }
            
            if(trigger.new[i].ShippingPostalCode != NULL){
                String ShippingPostalsub = AssignmentRules.getZipCodeConversion(trigger.new[i].ShippingPostalCode,trigger.new[i].ShippingCountry);
                
                /*if (trigger.new[i].ShippingPostalCode.length() > 5){
                    ShippingPostalsub = trigger.new[i].ShippingPostalCode.subString(0, 5);
                }else{
                    ShippingPostalsub = trigger.new[i].ShippingPostalCode;
                }
                */  
                if(getBranchLookUpZipCodeshippinng.size() > 0){ if(getBranchLookUpZipCodeshippinng.containsKey(ShippingPostalsub)){    Branch_Lookup__c branch = getBranchLookUpZipCodeshippinng.get(ShippingPostalsub); trigger.new[i].Servicing_Branch_Id__c = branch.Branch_Code__c;  }else{   trigger.new[i].Servicing_Branch_Id__c = '';     }    }
            }
            
            trigger.new[i].OwnerId__c = trigger.new[i].OwnerId;  for(Sic_Code_Lookup__c sic : sicCodeList){ if(trigger.new[i].Sic_Code__c != null){ if(trigger.new[i].Sic_Code__c == sic.Id){ trigger.new[i].Industry = sic.Industry__c; trigger.new[i].IsChecked__c = true;  }    }
            }
            system.debug('------userList------'+userList);
            system.debug('----trigger.new[i].OwnerId-----'+trigger.new[i].OwnerId);
            for(User Usl : userList ){
                if(Usl.Id == trigger.new[i].OwnerId && (trigger.new[i].BillingCountry == 'USA' || trigger.new[i].BillingCountry == 'usa' || trigger.new[i].BillingCountry == 'US' || trigger.new[i].BillingCountry == 'us')){
                    if(Usl.Name == 'Branch Account'){ if(trigger.new[i].Territory__c != null ){ trigger.new[i].Branch__c = trigger.new[i].Territory__c.subString(0,3);   }  }else{  trigger.new[i].Branch__c = Usl.Branch_Id__c;  }   }
                if(Usl.Id == trigger.new[i].OwnerId){
                    String BillingZipCodesub = AssignmentRules.getZipCodeConversion(trigger.new[i].BillingPostalCode,trigger.new[i].BillingCountry);
                    system.debug('-----BillingZipCodesub-------'+BillingZipCodesub);
                    system.debug('---Usl.Name---i----'+Usl.Name);
                    system.debug('---Usl.Branch_Id__c--i-----'+Usl.Branch_Id__c);
                    system.debug('---BillingZipCodesub-i-----'+BillingZipCodesub);
                    system.debug('---getBranchLookUpZipCode-i-----'+getBranchLookUpZipCode);
                    system.debug('---trigger.new[i].BillingCountry-----'+trigger.new[i].BillingCountry);
                    if(trigger.new[i].BillingCountry!= null && ((trigger.new[i].BillingCountry.toUpperCase() == 'GB') || (trigger.new[i].BillingCountry.toUpperCase() == 'UK') || (trigger.new[i].BillingCountry.toUpperCase() == 'UNITED KINGDOM') || (trigger.new[i].BillingCountry.toUpperCase() == 'GREAT BRITAIN') || (trigger.new[i].BillingCountry.toUpperCase() == 'ENGLAND') || (trigger.new[i].BillingCountry.toUpperCase() == 'ENG'))){
                        if(Usl.Name == 'Branch Account'){ if(getBranchLookUpZipCode.containsKey(BillingZipCodesub)){   Branch_Lookup__c branch = getBranchLookUpZipCode.get(BillingZipCodesub);          trigger.new[i].Branch__c = branch.Branch_Code__c;        }           }else{     trigger.new[i].Branch__c = Usl.Branch_Id__c;          }             }
                    /*if(getBranchLookUpZipCode.containsKey(BillingZipCodesub)){
                        Branch_Lookup__c branch = getBranchLookUpZipCode.get(BillingZipCodesub);
                        if(branch.Country__c == 'UK' || branch.Country__c == 'uk' ){
                            if(Usl.Name == 'Branch Account'){
                                trigger.new[i].Branch__c = branch.Branch_Code__c;   
                            }else{
                                trigger.new[i].Branch__c = Usl.Branch_Id__c;    
                            }
                        }else{
                            trigger.new[i].Branch__c = Usl.Branch_Id__c;        
                        }
                    }else if(Usl.Name != 'Branch Account' && trigger.new[i].BillingCountry!= null && ((trigger.new[i].BillingCountry.toUpperCase() == 'GB') || (trigger.new[i].BillingCountry.toUpperCase() == 'UK') || (trigger.new[i].BillingCountry.toUpperCase() == 'UNITED KINGDOM') || (trigger.new[i].BillingCountry.toUpperCase() == 'GREAT BRITAIN') || (trigger.new[i].BillingCountry.toUpperCase() == 'ENGLAND') || (trigger.new[i].BillingCountry.toUpperCase() == 'ENG'))){
                        system.debug('---else--i---');
                        trigger.new[i].Branch__c = Usl.Branch_Id__c;
                    }*/
                }
                system.debug('--------trigger.new[i].Branch__c-------'+trigger.new[i].Branch__c);
            }
        }
    }
    if(trigger.isUpdate){    
        for(integer i=0;i<trigger.new.size();i++) {
            
            trigger.new[i].OwnerId__c = trigger.new[i].OwnerId;      for(Sic_Code_Lookup__c sic : sicCodeList){ if(trigger.new[i].Sic_Code__c != null){ if(trigger.new[i].Sic_Code__c == sic.Id){ trigger.new[i].Industry = sic.Industry__c; trigger.new[i].IsChecked__c = true; }  }    }   
            
            if(trigger.new[i].BillingPostalCode != NULL){  String BillingZipCodesubUpdate = AssignmentRules.getZipCodeConversion(trigger.new[i].BillingPostalCode,trigger.new[i].BillingCountry);
                if(getBranchLookUpZipCode.size () > 0){ if(getBranchLookUpZipCode.containsKey(BillingZipCodesubUpdate)){ Branch_Lookup__c branch = getBranchLookUpZipCode.get(BillingZipCodesubUpdate); trigger.new[i].Territory__c = branch.Territory__c; }else{ trigger.new[i].Territory__c = ''; }   }  }else{  trigger.new[i].Territory__c = ''; }
            
            if(trigger.new[i].ShippingPostalCode != NULL){ String BillingZipCodesubUpdate = AssignmentRules.getZipCodeConversion(trigger.new[i].ShippingPostalCode,trigger.new[i].ShippingCountry);
                
                /*if (trigger.new[i].ShippingPostalCode.length() > 5){
                    BillingZipCodesubUpdate = trigger.new[i].ShippingPostalCode.subString(0, 5);
                }else{
                    BillingZipCodesubUpdate = trigger.new[i].ShippingPostalCode;
                }*/
                
                if(getBranchLookUpZipCodeshippinng.size () > 0){    if(getBranchLookUpZipCodeshippinng.containsKey(BillingZipCodesubUpdate)){ Branch_Lookup__c branch = getBranchLookUpZipCodeshippinng.get(BillingZipCodesubUpdate);   trigger.new[i].Servicing_Branch_Id__c = branch.Branch_Code__c; }else{ trigger.new[i].Servicing_Branch_Id__c = '';              }     }
            }
            system.debug('------userList------'+userList);
            system.debug('----trigger.new[i].OwnerId-----'+trigger.new[i].OwnerId);
            for(User Usl : userList ){
                if(Usl.Id == trigger.new[i].OwnerId && (trigger.new[i].BillingCountry == 'USA' || trigger.new[i].BillingCountry == 'usa' || trigger.new[i].BillingCountry == 'US' || trigger.new[i].BillingCountry == 'us')){ if(Usl.Name == 'Branch Account'){ if(trigger.new[i].Territory__c != null ){ trigger.new[i].Branch__c = trigger.new[i].Territory__c.subString(0,3);   } }else{ trigger.new[i].Branch__c = Usl.Branch_Id__c;      }      }
                if(Usl.Id == trigger.new[i].OwnerId){ String BillingZipCodesub = AssignmentRules.getZipCodeConversion(trigger.new[i].BillingPostalCode,trigger.new[i].BillingCountry);
                   // system.debug('-----BillingZipCodesub-------'+BillingZipCodesub);
                   // system.debug('---Usl.Name----u---'+Usl.Name);
                    //system.debug('---Usl.Branch_Id__c---u----'+Usl.Branch_Id__c);
                   // system.debug('---trigger.new[i].BillingCountry-----'+trigger.new[i].BillingCountry);
                    if(trigger.new[i].BillingCountry!= null && ((trigger.new[i].BillingCountry.toUpperCase() == 'GB') || (trigger.new[i].BillingCountry.toUpperCase() == 'UK') || (trigger.new[i].BillingCountry.toUpperCase() == 'UNITED KINGDOM') || (trigger.new[i].BillingCountry.toUpperCase() == 'GREAT BRITAIN') || (trigger.new[i].BillingCountry.toUpperCase() == 'ENGLAND') || (trigger.new[i].BillingCountry.toUpperCase() == 'ENG'))){
                        if(Usl.Name == 'Branch Account'){ if(getBranchLookUpZipCode.containsKey(BillingZipCodesub)){ Branch_Lookup__c branch = getBranchLookUpZipCode.get(BillingZipCodesub); trigger.new[i].Branch__c = branch.Branch_Code__c;   } }else{ trigger.new[i].Branch__c = Usl.Branch_Id__c;   }                 }
                    /*if(getBranchLookUpZipCode.containsKey(BillingZipCodesub)){
                        Branch_Lookup__c branch = getBranchLookUpZipCode.get(BillingZipCodesub);
                        if(branch.Country__c == 'UK' || branch.Country__c == 'uk' ){
                            if(Usl.Name == 'Branch Account'){
                                trigger.new[i].Branch__c = branch.Branch_Code__c;   
                            }else{
                                trigger.new[i].Branch__c = Usl.Branch_Id__c;    
                            }
                        }else{
                            trigger.new[i].Branch__c = Usl.Branch_Id__c;        
                        }
                    }else if(Usl.Name != 'Branch Account' && trigger.new[i].BillingCountry!= null && ((trigger.new[i].BillingCountry.toUpperCase() == 'GB') || (trigger.new[i].BillingCountry.toUpperCase() == 'UK') || (trigger.new[i].BillingCountry.toUpperCase() == 'UNITED KINGDOM') || (trigger.new[i].BillingCountry.toUpperCase() == 'GREAT BRITAIN') || (trigger.new[i].BillingCountry.toUpperCase() == 'ENGLAND') || (trigger.new[i].BillingCountry.toUpperCase() == 'ENG'))){
                        system.debug('---else---u--');
                        trigger.new[i].Branch__c = Usl.Branch_Id__c;
                    }*/
                }
            }
            system.debug('-------trigger.new[i].Branch__c----------'+trigger.new[i].Branch__c);
            // populateOSRTopPotential trigger code: change by : Tek systems(3rd March 2014) 
             
            if(Trigger.new[i].TSM_Top_Potential_ID__c != Trigger.old[i].TSM_Top_Potential_ID__c){ Trigger.new[i].TSM_Top_Potential__c = Trigger.new[i].TSM_Top_Potential_ID__c;        }
        }
    }
    system.debug('--------RecursiveTriggerUtility.isSicUpdate----------'+RecursiveTriggerUtility.isSicUpdate);

}