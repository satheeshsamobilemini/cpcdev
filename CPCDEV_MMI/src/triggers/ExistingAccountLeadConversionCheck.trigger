trigger ExistingAccountLeadConversionCheck on Account (after insert) {
  if(TriggerSwitch.isTriggerExecutionFlagDisabled('Account','ExistingAccountLeadConversionCheck')){  return;    } 
    /*If custom setting holds logged in user's ID then trigger will not fire.
    This is done by Reena for S-117407 to avoid firing trigger of Account during data update of account.
    If user want to perform data update on account but want to avoid firing of trigger then
    Set user's salesforce ID in SkipTrigger custom setting and then perform update.*/
    
    for(SkipTrigger__c skipTrg : SkipTrigger__c.getAll().values()){  if(skipTrg.name == userinfo.getUserID().subString(0,15)){ return; }     }
  
    for (Account acct : trigger.New){
    
        if (acct.Lead_Existing_Account_Owned_By_Branch__c == true){  acct.adderror('There is an existing Account owned by Branch that matches this lead.  Please select the appropriate Account from the Account Name picklist.  ');  }
        
        else if(acct.Lead_Existing_Account_Owned_by_Rep__c == true){ acct.adderror('There is an existing Account owned by you that matches this lead.  Please select the appropriate Account from the Account Name picklist');        }
    
    }
}