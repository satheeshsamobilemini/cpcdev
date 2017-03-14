/**
* (c) 2015 TEKsystems Global Services
*
* Name           : FullQuotePDF_UK_Ctrl
* Created Date   : 04 May 2015
* Created By     : Sreenivas M (TEK)
* Purpose        : Controller class used by 'FullQuotePDF_UK' VF page.
* Test ClassName : AllFullQuoteUKClassesTriggersTest
*
**/
public class FullQuotePDF_UK_Ctrl
{
 public MMI_Full_Quotes_UK__c fullQuote{get;set;}
 public List<Full_Quote_UK_LineItem__c> allSelectedProducts{get;set;}
 public List<Full_Quote_UK_LineItem__c> allOtherProducts{get;set;}
 public List<Full_Quote_UK_LineItem__c> allOneTimeCostProducts{get;set;}
 public String reqDate{get;set;}
 public String quoteDate{get;set;}
 public String quoteExpires{get;set;}
 public Decimal hireTotal{get;set;}
 
 public FullQuotePDF_UK_Ctrl()
   {
      fullQuote = new MMI_Full_Quotes_UK__c();
      hireTotal = 0;
      allSelectedProducts = new List<Full_Quote_UK_LineItem__c>();
      allOtherProducts = new List<Full_Quote_UK_LineItem__c>();
      allOneTimeCostProducts = new List<Full_Quote_UK_LineItem__c>();
      String quoteId = ApexPages.currentPage().getParameters().get('Id');
      String queryString = 'Select Sales_Rep__r.email, Sales_Rep__r.phone, Sales_Rep__r.MobilePhone, Account__r.Lastname,';
      
            
       for(FullQuoteUKHistoryMapping__c custSettMap : FullQuoteUKHistoryMapping__c.getAll().values())
       {
        queryString = queryString + custSettMap.Quote_Field_API_Name__c+',';
       }
       queryString = queryString.removeEnd(',');
       system.debug('quoteId .....'+quoteId);
       queryString = queryString + ' From MMI_Full_Quotes_UK__c where id = \''+quoteId+'\'';
       fullQuote = database.query(queryString);
       fullQuote.Billing_Company_Name__c = fullQuote.Billing_Company_Name__c == null?fullQuote.Billing_First_Name__c+' '+fullQuote.Billing_Last_Name__c:fullQuote.Billing_Company_Name__c;    
       
       if(fullQuote.Required_Date__c != null)
       reqDate = fullQuote.Required_Date__c.format();
       if(fullQuote.Quote_Expires__c != null)
       quoteExpires = fullQuote.Quote_Expires__c.format();
       quoteDate = date.today().format();
       List<Full_Quote_UK_LineItem__c> pdtLineItems = [SELECT Id, Name, Details__c, Frequency__c, MMI_Full_Quote_UK__c, Product_UK__c, Description__c, Itemcode__c, Unit_Type__c,Unit_Type_2__c, 
                                                       Quantity__c, Price__c, Total__c, LLW__c, Is_Other__c FROM Full_Quote_UK_LineItem__c where MMI_Full_Quote_UK__c =:fullQuote.id];
        
       for(INTEGER i=0; i<pdtLineItems.size(); i++){
           system.debug(pdtLineItems[i]);
           if(pdtLineItems[i].LLW__c == Label.LLW_UK){
               Decimal llwCost = 0.10 * pdtLineItems[i].Total__c;
               pdtLineItems[i].Total__c = pdtLineItems[i].Total__c + llwCost.setscale(2);
               llwCost = 0.10 * pdtLineItems[i].Price__c;
               pdtLineItems[i].Price__c = pdtLineItems[i].Price__c + llwCost.setscale(2);
               pdtLineItems[i].Description__c = pdtLineItems[i].Description__c + ' with Damage Waiver';
           }
           hireTotal = hireTotal + pdtLineItems[i].Total__c;
           if('Service'.equalsIgnoreCase(pdtLineItems[i].Unit_Type_2__c)){
               
               if(String.isNotBlank(pdtLineItems[i].Unit_Type__c)){
                   pdtLineItems[i].Description__c = pdtLineItems[i].Unit_Type__c +' - '+pdtLineItems[i].Description__c;
               }
               pdtLineItems[i].Unit_Type__c = 'Serv';
               
               //Shankar - Seprate Others
               if(pdtLineItems[i].Is_Other__c){
                   hireTotal = hireTotal - pdtLineItems[i].Total__c;
                   if(String.isNotBlank(pdtLineItems[i].Frequency__c) && pdtLineItems[i].Frequency__c != '-'){
                       if(Integer.valueOf(pdtLineItems[i].Frequency__c) > 1){
                           pdtLineItems[i].Description__c = pdtLineItems[i].Description__c+' every '+pdtLineItems[i].Frequency__c+' days';    
                       }
                       else{
                           pdtLineItems[i].Description__c = pdtLineItems[i].Description__c+' every '+pdtLineItems[i].Frequency__c+' day';
                       }
                   }
                   
                   allOtherProducts.add(pdtLineItems[i]); 
               }
               else{
                   allSelectedProducts.add(pdtLineItems[i]);
               }
           }
           else if('one off cost'.equalsIgnoreCase(pdtLineItems[i].Unit_Type_2__c)){
               hireTotal = hireTotal - pdtLineItems[i].Total__c;
               //One of Code population.
               pdtLineItems[i].Unit_Type__c = 'Inst';
               allOneTimeCostProducts.add(pdtLineItems[i]);
           }
           else{
               pdtLineItems[i].Unit_Type__c = 'Wk';
               allSelectedProducts.add(pdtLineItems[i]);
           }
       }
   }
 
}