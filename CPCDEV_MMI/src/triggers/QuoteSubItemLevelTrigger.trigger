/**
* (c) 2016 TEKsystems Global Services
*
* Name              : QuoteSubItemLevelTrigger 
* Purpose           : Trigger to update Recurring field in Quote Item Level when Quote Sub Item Level is inserted.
* Created Date      : 8,Mar,2016 
* Created By        : Jailabdin shaik
* Last Updated Date : 8,Mar,2016  
* Last Updated By   : Jailabdin shaik
* 
**/

Trigger QuoteSubItemLevelTrigger on Quote_Sub_Item_Level__c (after insert){
    List<id> QuoteitemlevelIdList = new List<id>();
    List<Quote_Item_Level__c> UpdateQuoteItemList = new List<Quote_Item_Level__c>();
    Map<Id,Quote_Item_Level__c> QuoteItemMap =new Map<Id,Quote_Item_Level__c>();
    
    for(Quote_Sub_Item_Level__c qsil: Trigger.new){
        if(qsil.Recurring__c != null){
            QuoteitemlevelIdList.add(qsil.Quote_Item_level_ID__c);
        }
    }
    
    QuoteItemMap =new Map<Id,Quote_Item_Level__c>([select id,name,Recurring__c,(select id,name,Recurring__c from Quote_Sub_Item_Levels__r) from Quote_Item_Level__c where Id In:QuoteitemlevelIdList]);
    
    for(Quote_Sub_Item_Level__c qsil: Trigger.new){
        if(qsil.Recurring__c != null){
            Quote_Item_Level__c Qil = QuoteItemMap.get(qsil.Quote_Item_level_ID__c);
            Qil.Recurring__c=qsil.Recurring__c;
            UpdateQuoteItemList.add(Qil);
            
        }
    }
    
    update UpdateQuoteItemList;
}