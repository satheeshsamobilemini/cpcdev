@isTest
global class MockCreditMemoWebservice implements WebserviceMock{
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
               
                sapComDocumentSapRfcFnCreditMemo.ZSD_PROCESS_CREDIT_MEMO_Response_element respElement = new  sapComDocumentSapRfcFnCreditMemo.ZSD_PROCESS_CREDIT_MEMO_Response_element ();
               
               List<sapComDocumentSapRfcFnCreditMemo.BAPIRET2> bapList = new List<sapComDocumentSapRfcFnCreditMemo.BAPIRET2>();
               sapComDocumentSapRfcFnCreditMemo.BAPIRET2 bapVar = new sapComDocumentSapRfcFnCreditMemo.BAPIRET2();
               bapVar.TYPE_x='';
                bapVar.ID='';
                bapVar.NUMBER_x='';
                bapVar.MESSAGE='credit 34444444545 sucessfully saved!';
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
              sapComDocumentSapRfcFnCreditMemo.RETURN_element retEle = new sapComDocumentSapRfcFnCreditMemo.RETURN_element();
               retEle.item = bapList;
               
               respElement.BILLING_BLOCK = 'X';
               respElement.NET_VALUE = '10.00';
               respElement.SALESDOCUMENT_EX =  '34444444545';
               respElement.RETURN_x = retEle;
               response.put('response_x', respElement);

}
    
}