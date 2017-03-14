/********************************************************************************************
Name   : NumericPhoneUpdationOnAccount
Usage  : used to update Numericphone field of Account
Author : Kirtesh Jain
Date   : Oct 01, 2009
********************************************************************************************/

trigger NumericPhoneUpdationOnAccount on Account (before insert, before update) {
  
   /*If custom setting holds logged in user's ID then trigger will not fire.
    This is done by Reena for S-117407 to avoid firing trigger of Account during data update of account.
    If user want to perform data update on account but want to avoid firing of trigger then
    Set user's salesforce ID in SkipTrigger custom setting and then perform update.*/
    
 /* for(SkipTrigger__c skipTrg : SkipTrigger__c.getAll().values()){
    if(skipTrg.name == userinfo.getUserID().subString(0,15)){
        return;
    }
   }

  
  Set<String> creditCollectorId = new Set<String>();
  List<Account> accountToBeUpdate = new List<Account>();
  Set<String> nationalAccountNumbers = new Set<String>();
  boolean isAdded = false;
  for( Account aAccount : trigger.new){
    if( aAccount.phone != null )
     aAccount.NumericPhone__c = Utils.processNumericPhone(aAccount.phone);
    else
     aAccount.NumericPhone__c = null;
     if(aAccount.Credit_Collector__c != null){
        creditCollectorId.add(aAccount.Credit_Collector__c);
        accountToBeUpdate.add(aAccount);
        isAdded = true;
     }
     if(aAccount.National_Account_Pricing_From_Result__c != null){
        nationalAccountNumbers.add(aAccount.National_Account_Pricing_From_Result__c);
        if(!isAdded){
            accountToBeUpdate.add(aAccount);
        }
     }
  }
  
  Map<String,String> creditCollectorMap = new Map<String,String>();
  Map<String,String> nationalAccountNumberInSFDCMap = new Map<String, String>(); 
  String creditCollectorName;
  String nationalAccountNumber;
  for(User u : [select Name, Collection_Controller_Number__c, Extension__c from User where Collection_Controller_Number__c in : creditCollectorId]){
    creditCollectorName = u.Name;
    if(u.Extension__c != null){
        creditCollectorName += ' ' + '- '+u.Extension__c;
    }
    creditCollectorMap.put(u.Collection_Controller_Number__c,creditCollectorName);
  }
  for(National_Account_Pricing_Information__c nap : [select National_Account_Pricing_from_Result__c, National_Account_Pricing_In_SFDC__c from National_Account_Pricing_Information__c where National_Account_Pricing_from_Result__c in : nationalAccountNumbers]){
    nationalAccountNumberInSFDCMap.put(nap.National_Account_Pricing_from_Result__c,nap.National_Account_Pricing_In_SFDC__c);
  }
  for(Account acc : accountToBeUpdate){
    if(acc.credit_Collector__c != null && creditCollectorMap.containsKey(acc.credit_Collector__c)){
        acc.Credit_Collector_Name__c = creditCollectorMap.get(acc.credit_Collector__c);
    }else{
        acc.Credit_Collector_Name__c ='';
    }
    if(acc.National_Account_Pricing_From_Result__c != null && nationalAccountNumberInSFDCMap.containsKey(acc.National_Account_Pricing_From_Result__c)){
        acc.National_Account_Pricing__c = nationalAccountNumberInSFDCMap.get(acc.National_Account_Pricing_From_Result__c);
    }else{
        acc.National_Account_Pricing__c = '';
    }
  }
  */
}