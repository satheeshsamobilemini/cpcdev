/**
* (c) 2015 TEKsystems Global Services
*
* Name           : RFDUKPDFController
* Created Date   : 04 May 2015
* Created By     : Shankar (TEK)
* Test ClassName : AllFullQuoteUKClassesTriggersTest
*/

public class RFDUKPDFController {
    public MMI_Full_Quotes_UK__c fullQuote{get;set;}
    public List<Full_Quote_UK_LineItem__c> allSelectedProducts{get;set;}
    public String requestDate {get; set;}
    public String requiredDate {get; set;}
    public String customerName {get; set;}
    public String commentsStringRowOne {get; set;}
    public String commentsStringRowTwo {get; set;}
    public Decimal hirePerWeek {get; set;}
    public Decimal totalServiceRate {get; set;}
    public Decimal totalTransportCost {get; set;}
    public Map<String, Integer> pdtLineItemQuantityMap {get; set;}
    public Map<String, Decimal> accessoryServiceRateMap {get; set;}
    
    public RFDUKPDFController(){
        fullQuote = new MMI_Full_Quotes_UK__c();
        allSelectedProducts = new List<Full_Quote_UK_LineItem__c>();
        pdtLineItemQuantityMap = new Map<String, Integer>();
        accessoryServiceRateMap = new Map<String, Decimal>();
        hirePerWeek = 0;
        totalTransportCost = 0;
        totalServiceRate = 0;
        String varRFDQuoteID = ApexPages.currentPage().getParameters().get('Id');
        String varQueryString = getQueryString(varRFDQuoteID);
        requestDate = system.today().format();
        //Query for the Quote record.
        if(varRFDQuoteID != null){
            fullQuote = database.query(varQueryString);
            system.debug('a1a'+fullQuote.Delivery_Last_Name__c);
            //Change date format
            requiredDate = fullQuote.Required_Date__c.format();
            customerName = fullQuote.Billing_Company_Name__c == null?fullQuote.Billing_First_Name__c+' '+fullQuote.Billing_Last_Name__c : fullQuote.Billing_Company_Name__c;
            
            fullQuote.Delivery_Phone__c = fullQuote.Delivery_Phone__c == null ? fullQuote.Delivery_Mobile__c : 
                                         fullQuote.Delivery_Mobile__c == null ? fullQuote.Delivery_Phone__c : fullQuote.Delivery_Phone__c+', '+fullQuote.Delivery_Mobile__c;
            fullQuote.Billing_Phone__c = fullQuote.Billing_Phone__c == null ? fullQuote.Billing_Mobile__c : 
                                         fullQuote.Billing_Mobile__c == null ? fullQuote.Billing_Phone__c:fullQuote.Billing_Phone__c+', '+fullQuote.Billing_Mobile__c;
            fullQuote.Delivery_City__c = fullQuote.Delivery_County__c == null? fullQuote.Delivery_City__c+', '+fullQuote.Delivery_Postcode__c+', '+fullQuote.Delivery_Country__c
                                                                             : fullQuote.Delivery_City__c+', '+fullQuote.Delivery_County__c+', '+fullQuote.Delivery_Postcode__c+', '+fullQuote.Delivery_Country__c;
            
            //Query product line items for the quote.
            allSelectedProducts = [SELECT Id, Description__c, Details__c, Quantity__c, Price__c, LLW__c, Unit_Type_2__c, Frequency__c, 
                                   TransportCost__c, Unit_Type__c, Is_Other__c FROM Full_Quote_UK_LineItem__c WHERE MMI_Full_Quote_UK__c =:fullQuote.id];
            if(!allSelectedProducts.isEmpty()){
                for(Full_Quote_UK_LineItem__c pdtAcc : allSelectedProducts){
                    pdtLineItemQuantityMap.put(pdtAcc.Id,Integer.valueOf(pdtAcc.Quantity__c));
                    pdtAcc.Price__c = pdtAcc.Price__c /* Integer.valueOf(pdtAcc.Quantity__c)*/;
                    hirePerWeek = hirePerWeek + pdtAcc.Price__c;
                    accessoryServiceRateMap.put(pdtAcc.Id, 0);
                    
                    //Concatenate type string with all services.
                    if('Service'.equalsIgnoreCase(pdtAcc.Unit_Type_2__c)){
                        hirePerWeek = hirePerWeek - pdtAcc.Price__c;
                        for(Frequency_Multiplier_Mapping__c frequencyMultiplier : Frequency_Multiplier_Mapping__c.getall().values()){
                            if(pdtAcc.Description__c.toLowerCase().contains(frequencyMultiplier.Name.toLowerCase())){
                                pdtAcc.Description__c = pdtAcc.Unit_Type__c+' - '+pdtAcc.Description__c;
                            }
                        }
                        if(pdtAcc.Is_Other__c){
                            if(String.isNotBlank(pdtAcc.Frequency__c) && pdtAcc.Frequency__c != '-'){
                                if(Integer.valueOf(pdtAcc.Frequency__c) > 1){
                                    pdtAcc.Description__c = pdtAcc.Unit_Type__c+' - '+pdtAcc.Description__c+' every '+pdtAcc.Frequency__c+' days';
                                }
                                else{
                                    pdtAcc.Description__c = pdtAcc.Unit_Type__c+' - '+pdtAcc.Description__c+' every '+pdtAcc.Frequency__c+' day';
                                }
                            } 
                        }
                        totalServiceRate = totalServiceRate + pdtAcc.Price__c;
                        accessoryServiceRateMap.put(pdtAcc.Id, pdtAcc.Price__c);
                        pdtAcc.Price__c = 0;
                    }
                    else if('One off cost'.equalsIgnoreCase(pdtAcc.Unit_Type_2__c)){
                        hirePerWeek = hirePerWeek - pdtAcc.Price__c;
                        totalServiceRate = totalServiceRate + pdtAcc.Price__c;
                        accessoryServiceRateMap.put(pdtAcc.Id, pdtAcc.Price__c);
                        pdtAcc.Price__c = 0;
                    }
                    system.debug(accessoryServiceRateMap);
                    //Transport Cost
                    pdtAcc.TransportCost__c = pdtAcc.TransportCost__c==null?0.00:pdtAcc.TransportCost__c;
                    totalTransportCost = totalTransportCost + pdtAcc.TransportCost__c;
                    
                    //Concatenate Details with description.
                    if(pdtAcc.Details__c != null){
                        pdtAcc.Description__c = pdtAcc.Description__c+' - '+ pdtAcc.Details__c;
                    }
                }
            }
            String[] str = Label.DelTime_UK.split('/');
            if(fullQuote.Del_Time__c == str[0]){
                Decimal delTimeCharges = fullQuote.No_of_units__c * Integer.valueOf(str[1]);
                commentsStringRowOne = 'Please note \u00a350 per unit, total of \u00a3'+delTimeCharges+', will be added to the Delivery Cost for '+str[0]+'.';
                commentsStringRowTwo = fullQuote.Additional_Notes__c;
            }
            else{
                commentsStringRowOne = fullQuote.Additional_Notes__c;
            }
        }
        
    }
    
    //Form query from custom settings.
    private String getQueryString(String quoteId){
        String queryString = 'Select Account__r.Result_Id__c,';
        for(FullQuoteUKHistoryMapping__c CSMap : FullQuoteUKHistoryMapping__c.getAll().values()){
            queryString = queryString + CSMap.Quote_Field_API_Name__c+',';
        }
        queryString = queryString.removeEnd(',');
        queryString = queryString + ' From MMI_Full_Quotes_UK__c where id = \''+quoteId+'\'';
        return queryString;
    }
}