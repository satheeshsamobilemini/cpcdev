/**
* (c) 2015 TEKsystems Global Services
*
* Name           : FullQuoteEditFormUK_Extn
* Created Date   : 18 April, 2015 @ 1130
* Created By     : Sreenivas M (TEK)
* Purpose        : Extension class used by 'FullQuoteEditFormUK_VF' VF page to edit/clone FullQuote UK.
* 
**/
public class FullQuoteEditFormUK_Extn
{
  String fullQuoteId = '';
  MMI_Full_Quotes_UK__c MMIFQ = new MMI_Full_Quotes_UK__c();
  public FullQuoteEditFormUK_Extn(ApexPages.StandardController controller)
  {
    MMIFQ = (MMI_Full_Quotes_UK__c)controller.getRecord();
    fullQuoteId = MMIFQ.id;
  }  
  
  public pageReference gotoEdit()
  {
    pageReference pf = new pageReference('/apex/FullQuoteFormUK_VF?Id='+fullQuoteId);
    return pf;
  }
    
}