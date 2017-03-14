trigger DefaultAccountCurrency on Account (Before insert, Before update) {
    if(TriggerSwitch.isTriggerExecutionFlagDisabled('Account','DefaultAccountCurrency')){
        return;
    }
    List<Account> accList = new List<Account>();
    for(Account acc : trigger.new)
    {
        //String recName = [select id,name from RecordType where id =: acc.recordtypeid].name;
        if(acc.Sales_Org__c == '1000' || acc.Sales_Org__c == '1500' || acc.Sales_Org__c == '1501')         //(recName.containsIgnoreCase('UK')) // == 'Business Account - UK' || acc.recordtype.name == 'Residential Account - UK')
            acc.CurrencyIsoCode = 'USD';
        if(acc.Sales_Org__c == '1200')
            acc.CurrencyIsoCode = 'GBP';
        if(acc.Sales_Org__c == '1100')
            acc.CurrencyIsoCode = 'CAD';    
        accList.add(acc);    
    }
    
    if(trigger.isBefore && trigger.isInsert){
        for(Account acc : trigger.new)
        {
            acc.SAP_Bill_To__c = '';
        }    
    }         
}