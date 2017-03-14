public Class CreditMemoReqResp{

//Map<String,Customer_Request_Invoice__c> itmNumLineItemMap{ get;set;}
public CreditMemoReqResp(){
    //sendReq('a0d56000007OYL6');
}

@future(callout = true)
public static void sendReq(List<Id> caseIdList){
    system.debug('----------- caseIdList ------------' + caseIdList);
    Id caseId = caseIdList[0];
    string cvar;
    Service_Order_Request__c creditMMIVar = null;
List<Service_Order_Request__c> creditMMIVarList = [Select Id,Name,Sales_Org__c,Distribution_Channel__c,Document_Category__c,Order_Reason_Char_Code__c,Description__c,Reason_for_Credit__c,Invoice_Number__c,SAP_Bill_To__c,SAP_Sold_To__c,SAP_Ship_To__c,Invoice_Currency__c,
                                       (Select Item_Number__c,Material__c,Plant__c,Quantity__c,Unit_of_Measure__c,Condition_Type__c,Conditional_Value__c,Invoice_Currency__c,Invoice_Number__c 
                                        from Customer_Request_Invoices__r where Conditional_Value__c!= null ) 
                                      From Service_Order_Request__c where Id = :caseId AND Status__c = 'Submitted' LIMIT 1];
                System.debug('creditMMIVar...'+creditMMIVar);
                //System.debug('creditMMIVar.Customer_Request_Invoices__r...'+creditMMIVar.Customer_Request_Invoices__r);

if(!creditMMIVarList.isEmpty()){
   creditMMIVar = creditMMIVarList[0];  
   cvar = creditMMIVar.Reason_for_Credit__c; 
}                  
                               
if(creditMMIVar != null){
    //List<Credit_Order_Reason__c> corList = [select Id,Char_Code__c,Description__c from Credit_Order_Reason__c where Description__c =: cvar LIMIT 1]; 
    //List<Customer_Request_Invoice__c> creditedLineItemsList = creditMMIVar.Customer_Request_Invoices__r;
  
    sapComDocumentSapRfcFnCreditMemo.BAPISDHD1 SALES_HEADER_IN = new sapComDocumentSapRfcFnCreditMemo.BAPISDHD1();
    SALES_HEADER_IN.DOC_TYPE = 'ZCR';
    SALES_HEADER_IN.SALES_ORG = creditMMIVar.Sales_Org__c;
    SALES_HEADER_IN.DISTR_CHAN = String.valueOf(creditMMIVar.Distribution_Channel__c);
    SALES_HEADER_IN.DIVISION = '10';
    SALES_HEADER_IN.REQ_DATE_H = String.valueOf(Date.today()).replace('-','');  
    if(!test.isRunningTest())
    {SALES_HEADER_IN.ORD_REASON = creditMMIVar.Order_Reason_Char_Code__c;
    }else{
        SALES_HEADER_IN.ORD_REASON = 'C07';
        //'C07'; //creditMMIVar.Reason_for_Credit__c;
        
    }
    SALES_HEADER_IN.PURCH_NO_C = creditMMIVar.Name;
    SALES_HEADER_IN.REF_DOC = creditMMIVar.Invoice_Number__c;
    SALES_HEADER_IN.REFDOC_CAT = creditMMIVar.Document_Category__c;
    SALES_HEADER_IN.REF_DOC_L = creditMMIVar.Invoice_Number__c;
   
    System.debug('SALES_HEADER_IN.....'+SALES_HEADER_IN);
    
    sapComDocumentSapRfcFnCreditMemo.ZSD_ORDER_HEADER_IN ADD_SALES_HEADER_IN = new  sapComDocumentSapRfcFnCreditMemo.ZSD_ORDER_HEADER_IN();
    ADD_SALES_HEADER_IN.SFDC_QUOTE = creditMMIVar.Id;
    System.debug('ADD_SALES_HEADER_IN.....'+ADD_SALES_HEADER_IN);
    
        sapComDocumentSapRfcFnCreditMemo.ORDER_TEXT_element ORDER_TEXT = new sapComDocumentSapRfcFnCreditMemo.ORDER_TEXT_element();
        List<sapComDocumentSapRfcFnCreditMemo.BAPISDTEXT> orderTextList = new List<sapComDocumentSapRfcFnCreditMemo.BAPISDTEXT> ();
        Integer descLen;
       
            //creditMMIVar.Description__c = 'test';
            
            descLen = creditMMIVar.Description__c.length();
           
            Integer remainder = math.mod(descLen , 132);
            Integer noOfOrderText = descLen/132;
            Integer descBits = 0;
            if(remainder != 0 ){
               noOfOrderText += 1;
            }
            
            for(Integer i=0; i<noOfOrderText ; i++){
                    sapComDocumentSapRfcFnCreditMemo.BAPISDTEXT orderTextVar = new sapComDocumentSapRfcFnCreditMemo.BAPISDTEXT();
                    orderTextVar.ITM_NUMBER = '000000';
                    orderTextVar.TEXT_ID = 'ZA01';
                    orderTextVar.LANGU = 'EN';
                    if(i != noOfOrderText-1){  
                        orderTextVar.TEXT_LINE = creditMMIVar.Description__c.substring(descBits,descBits+132);
                        }else{
                            orderTextVar.TEXT_LINE = creditMMIVar.Description__c.substring(descBits,descLen); 
                        }
 
                    orderTextList.add(orderTextVar);
                
                    descBits+=131;  
                }
               
        
        ORDER_TEXT.item = orderTextList;
         System.debug('ORDER_TEXT.....'+ORDER_TEXT);
   
  
   
   
   
    sapComDocumentSapRfcFnCreditMemo.SALES_PARTNERS_element SALES_PARTNERS = new sapComDocumentSapRfcFnCreditMemo.SALES_PARTNERS_element();
     List<sapComDocumentSapRfcFnCreditMemo.BAPIPARNR> partnerList = new List<sapComDocumentSapRfcFnCreditMemo.BAPIPARNR>();
    for(Integer slsPtnr = 0; slsPtnr < 3;slsPtnr++)
    {
       sapComDocumentSapRfcFnCreditMemo.BAPIPARNR partner = new sapComDocumentSapRfcFnCreditMemo.BAPIPARNR();
        if(slsPtnr == 0){
            partner.PARTN_ROLE = 'RG';
            partner.PARTN_NUMB = creditMMIVar.SAP_Bill_To__c;
        }else if(slsPtnr == 1){
            partner.PARTN_ROLE = 'AG';
            partner.PARTN_NUMB = creditMMIVar.SAP_Sold_To__c;
        }else{
            partner.PARTN_ROLE = 'WE';
            partner.PARTN_NUMB = creditMMIVar.SAP_Ship_To__c;
        }
        partnerList .add(partner);
    } 
    SALES_PARTNERS.item = partnerList;
    System.debug('SALES_PARTNERS.....'+SALES_PARTNERS);
    
    
    sapComDocumentSapRfcFnCreditMemo.SALES_CONDITIONS_IN_element SALES_CONDITIONS_IN = new sapComDocumentSapRfcFnCreditMemo.SALES_CONDITIONS_IN_element();
    List<sapComDocumentSapRfcFnCreditMemo.BAPICOND> itmPricingList = new  List<sapComDocumentSapRfcFnCreditMemo.BAPICOND>();
    Map<String,Customer_Request_Invoice__c> itmNumLineItemMap = new Map<String,Customer_Request_Invoice__c>();
    for(Customer_Request_Invoice__c creditedLineItemsVar :  creditMMIVar.Customer_Request_Invoices__r){
       
            System.debug('creditedLineItemsVar...'+creditedLineItemsVar);
            if(!(itmNumLineItemMap.containsKey(creditedLineItemsVar.Item_Number__c))){
                Customer_Request_Invoice__c custreqInvVar = new Customer_Request_Invoice__c();
                custreqInvVar.Item_Number__c = creditedLineItemsVar.Item_Number__c;
                custreqInvVar.Material__c= creditedLineItemsVar.Material__c;
                custreqInvVar.Plant__c = creditedLineItemsVar.Plant__c ;
                custreqInvVar.Quantity__c = creditedLineItemsVar.Quantity__c; 
                custreqInvVar.Unit_of_Measure__c = creditedLineItemsVar.Unit_of_Measure__c;
                custreqInvVar.Invoice_Number__c = creditedLineItemsVar.Invoice_Number__c ;
                itmNumLineItemMap.put(creditedLineItemsVar.Item_Number__c,custreqInvVar);
            
            }
            sapComDocumentSapRfcFnCreditMemo.BAPICOND itemPricingVar = new sapComDocumentSapRfcFnCreditMemo.BAPICOND();
            itemPricingVar.ITM_NUMBER = creditedLineItemsVar.Item_Number__c;
            itemPricingVar.COND_TYPE =  creditedLineItemsVar.Condition_Type__c;  
           
            if((creditedLineItemsVar.Condition_Type__c == 'ZLLW' || creditedLineItemsVar.Condition_Type__c == 'ZPPE' || creditedLineItemsVar.Condition_Type__c == 'ZFUE')){ 
                if(creditedLineItemsVar.Conditional_Value__c != 0){
                    itemPricingVar.CURRENCY_2 = creditMMIVar.Invoice_Currency__c;                   
                }
                itemPricingVar.CONDVALUE = String.valueOf(creditedLineItemsVar.Conditional_Value__c);     
            }else{ 
                 itemPricingVar.COND_VALUE = String.valueOf(creditedLineItemsVar.Conditional_Value__c);   
                itemPricingVar.CURRENCY_x = creditedLineItemsVar.Invoice_Currency__c;
             }
             itmPricingList.add(itemPricingVar);   
        
        
    
    }
    SALES_CONDITIONS_IN .item = itmPricingList;
     System.debug('SALES_CONDITIONS_IN .....'+SALES_CONDITIONS_IN);
    
    System.debug('itmNumLineItemMap...'+itmNumLineItemMap);
    
    sapComDocumentSapRfcFnCreditMemo.SALES_ITEMS_IN_element SALES_ITEMS_IN = new sapComDocumentSapRfcFnCreditMemo.SALES_ITEMS_IN_element();
    List<sapComDocumentSapRfcFnCreditMemo.BAPISDITM> lineItemList = new List<sapComDocumentSapRfcFnCreditMemo.BAPISDITM>();
    for(String lineItemNum : itmNumLineItemMap.keySet() ){
        sapComDocumentSapRfcFnCreditMemo.BAPISDITM lineItemVar = new sapComDocumentSapRfcFnCreditMemo.BAPISDITM();
        Customer_Request_Invoice__c custReqInvVar = itmNumLineItemMap.get(lineItemNum);
        lineItemVar.ITM_NUMBER = custreqInvVar.Item_Number__c;
        lineItemVar.MATERIAL = custreqInvVar.Material__c;
        lineItemVar.PLANT = custreqInvVar.Plant__c;
        lineItemVar.TARGET_QTY = String.valueOf(custreqInvVar.Quantity__c);   
        lineItemVar.TARGET_QU = custreqInvVar.Unit_of_Measure__c;
        lineItemVar.REF_DOC = creditMMIVar.Invoice_Number__c;    
        lineItemVar.REF_DOC_IT = custreqInvVar.Item_Number__c;
        lineItemVar.REF_DOC_CA = creditMMIVar.Document_Category__c; 
        lineItemList.add(lineItemVar); 
    }
    SALES_ITEMS_IN.item = lineItemList;
     System.debug('SALES_ITEMS_IN.....'+SALES_ITEMS_IN);
    
     mobileminiComEccCreditmemo.HTTP_Port  stub = new mobileminiComEccCreditmemo.HTTP_Port();
     stub.inputHttpHeaders_x = new Map<String, String>();
     //Blob headerValue = Blob.valueOf('data_int' + ':' + 'Letm3in!');
     Blob headerValue = Blob.valueOf('PIPREMOTE' + ':' + 'L3tm31n$$');
     String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
     stub.inputHttpHeaders_x.put('Authorization', authorizationHeader);
     stub.timeout_x = 120000;
                
    sapComDocumentSapRfcFnCreditMemo.ZSD_PROCESS_CREDIT_MEMO_Response_element creditMemoResp = stub.os_Credit_Memo_Request(ADD_SALES_HEADER_IN,ORDER_TEXT,SALES_CONDITIONS_IN,SALES_HEADER_IN,SALES_ITEMS_IN,SALES_PARTNERS);
    if(creditMemoResp.RETURN_x.item != null){
    String respMsg = '';
       for(Integer i =0;i<creditMemoResp.RETURN_x.item.size();i++){
            respMsg += creditMemoResp.RETURN_x.item[i].MESSAGE+'.';
           
       }
     
       
   if(respMsg != null){
            creditMMIVar.Credit_Memo_SAP_Status__c = respMsg ;
            if( creditMemoResp.BILLING_BLOCK == ''){
                creditMMIVar.Status__c = 'Completed';
                creditMMIVar.Actual_Credit_Amount__c = Decimal.valueOf(creditMemoResp.NET_VALUE);
               
            }
             creditMMIVar.Billing_Block__c =  creditMemoResp.BILLING_BLOCK;
             creditMMIVar.Sales_Document__c = creditMemoResp.SALESDOCUMENT_EX;
           
            update creditMMIVar;
        }
        
    }
}else{
    //handle saying this caseId provided isn't valid
}
                                     
      
                                      


}

}