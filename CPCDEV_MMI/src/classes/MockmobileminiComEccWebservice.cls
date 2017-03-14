@isTest
 global class MockmobileminiComEccWebservice  implements WebServiceMock{
 global void doInvoke(
            Object stub,
           Object request,
           Map<string, object> response,
           String endpoint,
           String soapAction,
           String requestName,
           String responseNS,
           String responseName,
           String responseType
           ) {
                  sapComDocumentSapRfcFunctions3.ZSD_MAINTAIN_CUSTOMER_CPQ_Response_element response_x = new sapComDocumentSapRfcFunctions3.ZSD_MAINTAIN_CUSTOMER_CPQ_Response_element();
                  sapComDocumentSapRfcFunctions3.E_RETURN_element e_return1 = new sapComDocumentSapRfcFunctions3.E_RETURN_element();    
                  List<sapComDocumentSapRfcFunctions3.BAPIRET2> bp_List = new List<sapComDocumentSapRfcFunctions3.BAPIRET2>();
                  sapComDocumentSapRfcFunctions3.BAPIRET2 bp = new sapComDocumentSapRfcFunctions3.BAPIRET2();
                  bp.ID = 'ZSD';   
                  bp.NUMBER_x = '001';
                  bp.MESSAGE = 'Customer 0000200287 Created/Changed';
                  bp.LOG_MSG_NO = '000000';
                  bp.ROW = 0;
                  bp.TYPE_x = 'S';   
                  bp.MESSAGE_V1 = '0000200260';
                  bp.MESSAGE_V2='';
                  bp.MESSAGE_V3='';
                  bp.MESSAGE_V4='';
                  bp.PARAMETER='';
                  bp.FIELD='';
                  bp.SYSTEM_x='';
                  bp_List.add(bp);          
                  e_return1.item = bp_List;
               response_x.E_RETURN = e_return1;  
               response.put('response_x',response_x);
               /*AsyncSapComDocumentSapRfcFunctions3.ZSD_MAINTAIN_CUSTOMER_CPQ_Response_elementFuture asynch = new AsyncSapComDocumentSapRfcFunctions3.ZSD_MAINTAIN_CUSTOMER_CPQ_Response_elementFuture();
               asynch.getvalue();
               response_x.E_RETURN = e_return1; 
               response.put('response_x',response_x);*/
           }
     
     
}