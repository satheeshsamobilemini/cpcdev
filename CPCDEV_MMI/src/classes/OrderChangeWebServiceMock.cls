@isTest
global class OrderChangeWebServiceMock implements WebServiceMock {
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
       sapComDocumentOrderchange.ZSD_ORDER_UPDATE_DOCUSIGN_STS_Response_element  respElement = new sapComDocumentOrderchange.ZSD_ORDER_UPDATE_DOCUSIGN_STS_Response_element ();
       
       sapComDocumentOrderchange.BAPIRET2 rei = new sapComDocumentOrderchange.BAPIRET2();
       rei.TYPE_x = '' ;
       rei.ID = '' ;
       rei.NUMBER_x = '' ;
       rei.MESSAGE = '' ;
       rei.LOG_NO = '000' ;
       rei.LOG_MSG_NO = '000' ;
       rei.MESSAGE_V1 = '' ;
       rei.MESSAGE_V2 = '' ;
       rei.MESSAGE_V3 = '' ;
       rei.MESSAGE_V4 = '' ;
       rei.PARAMETER = '' ;
       rei.ROW = 0 ;
       rei.FIELD = '' ;
       rei.SYSTEM_x = '' ;       
       
       List<sapComDocumentOrderchange.BAPIRET2> reiList = new List<sapComDocumentOrderchange.BAPIRET2>(); 
       reiList.add(rei);
       
       sapComDocumentOrderchange.RETURN_element  re = new sapComDocumentOrderchange.RETURN_element ();
       re.item = reiList;
      
       respElement.RETURN_x = re;
       System.debug('respElement...........'+respElement);
       response.put('response_x', respElement); 
   }
}