/**
* (c) 2015 TEKsystems Global Services
*
* Purpose        : Trigger to create Quote History lineitem records
* Name           : MMIFullQuoteUKTriggerHandler
* Created Date   : 18 May, 2015 @ 1130
* Created By     : Sreenivas M
* Test ClassName : AllFullQuoteUKClassesTriggersTest
* 
**/
trigger FullQuoteUKLineItemTrigger on Full_Quote_UK_LineItem__c (after insert) 
{
  if(Trigger.isAfter && Trigger.isInsert)
  {
    List<Id> listQuoteIds = new List<id>();
    Map<id,id> mapquoteToHistory = new Map<id,id>();
    List<Quote_History_UK_LineItem__c> listHistoryLI = new List<Quote_History_UK_LineItem__c>();
    
    for(Full_Quote_UK_LineItem__c  fqli : Trigger.new)
    {     
     listQuoteIds.add(fqli.MMI_Full_Quote_UK__c);
    }
    
    for(MMI_Full_Quotes_UK__c FQ : [SELECT Id,(select id from Quote_Histories_UK__r order by createddate desc limit 1) FROM MMI_Full_Quotes_UK__c where id in:listQuoteIds])
    {
     
     Quote_History_UK__c tempHist= FQ.Quote_Histories_UK__r;
     mapquoteToHistory.put(FQ.id,tempHist.id);
    }
    
    if(!mapquoteToHistory.isEmpty())
    {
      for(Full_Quote_UK_LineItem__c  fqli : Trigger.new)
        {
            Quote_History_UK_LineItem__c newHistLI = new Quote_History_UK_LineItem__c();
            newHistLI.Price__c            =fqli.Price__c;
            newHistLI.Total__c            =fqli.Total__c;
            newHistLI.Is_Main_Unit__c     =fqli.Is_Main_Unit__c;
            newHistLI.Product_UK__c       =fqli.Product_UK__c;
            newHistLI.Quantity__c         =fqli.Quantity__c;
            newHistLI.Description__c      =fqli.Description__c;
            newHistLI.Quote_History_UK__c =mapquoteToHistory.get(fqli.MMI_Full_Quote_UK__c);
            newHistLI.Name                =fqli.Name;
            newHistLI.TransportSize__c    =fqli.TransportSize__c;
            newHistLI.Unit_Type__c        =fqli.Unit_Type__c;
            newHistLI.LLW__c              =fqli.LLW__c;
            newHistLI.Itemcode__c         =fqli.Itemcode__c;
            newHistLI.is_LLW_Editable__c  =fqli.is_LLW_Editable__c;
            newHistLI.TransportCost__c    =fqli.TransportCost__c;
            newHistLI.Details__c          =fqli.Details__c;
            newHistLI.Frequency__c        =fqli.Frequency__c;
            newHistLI.Unit_Type_2__c      =fqli.Unit_Type_2__c;
            newHistLI.Main_Product_Type__c=fqli.Main_Product_Type__c;
            
            listHistoryLI.add(newHistLI);
        }
      insert listHistoryLI;
    }
  }
}