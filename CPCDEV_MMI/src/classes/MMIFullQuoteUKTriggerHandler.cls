/**
* (c) 2015 TEKsystems Global Services
*
* Name           : MMIFullQuoteUKTriggerHandler
* Created Date   : 30 April, 2015 @ 1130
* Created By     : Sreenivas M
* Purpose        : Hnadler class used by MMIFullQuoteUKTrigger
* Test ClassName : AllFullQuoteUKClassesTriggersTest
* 
**/
public class MMIFullQuoteUKTriggerHandler
{
  public static boolean runBefTrigger =true;
  public static boolean runAftTrigger =true;
  //Sreenivas - Method to create a new Quote History UK record
  public static void createMMIFullQuoeUKHistory(List<MMI_Full_Quotes_UK__c> triggerNew)
   {
        List<Quote_History_UK__c> listQuoteHistory = new List<Quote_History_UK__c>();        
        Map<String,FullQuoteUKHistoryMapping__c> MapApiNames = FullQuoteUKHistoryMapping__c.getAll();

        for(MMI_Full_Quotes_UK__c quote : triggerNew)
        {
            Quote_History_UK__c objQuoteHistory = new Quote_History_UK__c();
            for(FullQuoteUKHistoryMapping__c apiNames :MapApiNames.values())
            {
                if(String.isNotBlank(apiNames.Quote_Field_API_Name__c) && String.isNotBlank(apiNames.Quote_History_Field_API_Name__c)) {
                
                    if(apiNames.IsRelationShipField__c)
                     objQuoteHistory.put(apiNames.Quote_History_Field_API_Name__c,String.valueOf(quote.get(apiNames.Quote_Field_API_Name__c)));
                    else
                     objQuoteHistory.put(apiNames.Quote_History_Field_API_Name__c,quote.get(apiNames.Quote_Field_API_Name__c));
                }
            }
         
            listQuoteHistory.add(objQuoteHistory);
        }
        try
        {
        
            insert listQuoteHistory;

        }
        Catch(Exception e)
        {
         System.debug('Exception thrown at History Line Items insertion'+e);
        }
    }
}