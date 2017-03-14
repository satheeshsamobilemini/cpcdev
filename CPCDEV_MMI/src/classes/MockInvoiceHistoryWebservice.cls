@isTest
 global class MockInvoiceHistoryWebservice  implements WebServiceMock{
 global void doInvoke(
           Object stub,
           Object request,
           Map<string, object> response,
           String endpoint,
           String soapAction,
           String requestName,
           String responseNS,
           String responseName,
           String responseType) {
                sapComDocumentSapRfcInvoiceHistory.ZSDF_INVOICE_HISTORY_Response_element respElement = new sapComDocumentSapRfcInvoiceHistory.ZSDF_INVOICE_HISTORY_Response_element();
                List<sapComDocumentSapRfcInvoiceHistory.ZSD_INVOICE_HISTORY> invHistoryList = new List<sapComDocumentSapRfcInvoiceHistory.ZSD_INVOICE_HISTORY>();
                
                sapComDocumentSapRfcInvoiceHistory.ZSD_INVOICE_HISTORY invHistoryVar = new sapComDocumentSapRfcInvoiceHistory.ZSD_INVOICE_HISTORY();
                invHistoryVar.KUNNR = '0000800015';
                invHistoryVar.VBELN = '0090000035';
                 
                sapComDocumentSapRfcInvoiceHistory.ZSD_INVOICE_HISTORY invHistoryVar1 = new sapComDocumentSapRfcInvoiceHistory.ZSD_INVOICE_HISTORY();
                invHistoryVar1.KUNNR = '0000800015';
                invHistoryVar1.VBELN = '0090000037';
               
               invHistoryList.add(invHistoryVar);
               invHistoryList.add(invHistoryVar1);
               
               sapComDocumentSapRfcInvoiceHistory.ET_INVOICE_element sie = new sapComDocumentSapRfcInvoiceHistory.ET_INVOICE_element();
               sie.item = invHistoryList;
               
               List<sapComDocumentSapRfcInvoiceHistory.BAPIRET2> bapList = new List<sapComDocumentSapRfcInvoiceHistory.BAPIRET2>();
               sapComDocumentSapRfcInvoiceHistory.BAPIRET2 bapVar = new sapComDocumentSapRfcInvoiceHistory.BAPIRET2();
               
                bapVar.TYPE_x='';
                bapVar.ID='';
                bapVar.NUMBER_x='';
                bapVar.MESSAGE='';
                bapVar.LOG_NO='';
                bapVar.LOG_MSG_NO='';
                bapVar.MESSAGE_V1='';
                bapVar.MESSAGE_V2='';
                bapVar.MESSAGE_V3='';
                bapVar.MESSAGE_V4='';
                bapVar.PARAMETER='';
                bapVar.ROW=0;
                bapVar.FIELD='';
                bapVar.SYSTEM_x='';
                
               bapList.add(bapVar);
               sapComDocumentSapRfcInvoiceHistory.ET_RETURN_element sre = new sapComDocumentSapRfcInvoiceHistory.ET_RETURN_element();
               sre.item = bapList;
               
               respElement.ET_INVOICE = sie;
               respElement.ET_RETURN = sre;
                  response.put('response_x', respElement); 
               
               
           }
             
}