public class QuoteHEaderTriggerHelper{
    public static boolean accountMerge = false;
    public static boolean isExecuted = false;
    @future(callout=true)
    public static void docusignStatusUpdateCallout(set<string> quoteHdrSet){
        isExecuted = true;
        mobileminiComEccOrderchange.HTTP_Port  stub = new mobileminiComEccOrderchange.HTTP_Port();
        stub.inputHttpHeaders_x = new Map<String, String>();

        Blob headerValue = Blob.valueOf('data_int' + ':' + 'Letm3in!');
        //Blob headerValue = Blob.valueOf('PIPREMOTE' + ':' + 'L3tm31n$$');
        String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
        
        //Setting a basic authentication header
        stub.inputHttpHeaders_x.put('Authorization', authorizationHeader);
        stub.timeout_x = 120000;
        String message = '';
        List<quote_header__c> qhList = [select id,name,SAP_Error_Log__c,Docusign_Status__c,Contract_Number__c from quote_header__c where name in:quoteHdrSet];
        system.debug('----- qhList-----'+ qhList);
        List<quote_header__c> qhUpdateList = new List<quote_header__c>();
        quote_header__c qh;
        for(Quote_Header__c quote :qhList){
            sapComDocumentOrderchange.RETURN_element responseElement = new sapComDocumentOrderchange.RETURN_element();
            try{
                responseElement = stub.os_Order_Update_DocuSign_Status('X', null, quote.id, null);  //quote.Contract_Number__c
                if(responseElement.item != null){
                    List<sapComDocumentOrderchange.BAPIRET2> errorResponse = responseElement.item;
                    message = errorResponse[0].message;
                    qh = new quote_header__c();
                    qh.id = quote.id;
                    qh.SAP_Error_Log__c = message;
                    qhUpdateList.add(qh);
                }
                /*else{
                    qh = new quote_header__c();
                    qh.id = quote.id;
                    qh.SAP_Error_Log__c = 'No response from service';
                    qhUpdateList.add(qh);
                }*/
            }
            catch(Exception e){
                qh = new quote_header__c();
                qh.id = quote.id;
                qh.SAP_Error_Log__c = e.getMessage();
                qhUpdateList.add(qh); 
            }
        }   
        if(!qhUpdateList.isEmpty())
            update qhUpdateList;        
    }

}