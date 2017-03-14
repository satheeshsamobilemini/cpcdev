@isTest
global class WebServiceMockImpl implements WebServiceMock {
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
       sapComDocumentSapRfcFunctions.ZSD_CONTRACT_SEARCH_Response_element respElement = new sapComDocumentSapRfcFunctions.ZSD_CONTRACT_SEARCH_Response_element();
       
       sapComDocumentSapRfcFunctions.ZSD_ORDER_ITEM ci = new sapComDocumentSapRfcFunctions.ZSD_ORDER_ITEM();
       ci.CONTRACT = '800015';
       ci.ITM_NUMBER = '10';
       ci.STATUS = 'On Rent';
       ci.MATERIAL = '40ZS';
       ci.SHORT_TEXT = 'Mock txt';
       ci.SERIAL_NUMBER = '01235';
       ci.PLANT = '101';
       ci.RATE = '150';
       ci.CON_ST_DAT_L = '2015-12-12';
       ci.CON_EN_DAT_L = '2040-12-12';
        
       sapComDocumentSapRfcFunctions.ZSD_ORDER_ITEM ci1 = new sapComDocumentSapRfcFunctions.ZSD_ORDER_ITEM();
       ci1.CONTRACT = '800015';
       ci1.ITM_NUMBER = '10';
       ci1.STATUS = 'On Rent';
       ci1.MATERIAL = '40ZS';
       ci1.SHORT_TEXT = 'Mock txt';
       ci1.SERIAL_NUMBER = '01235';
       ci1.PLANT = '101';
       ci1.RATE = '150';
       ci1.CON_ST_DAT_L = '2015-12-12';
       ci1.CON_EN_DAT_L= '2040-12-12'; 
       
       List<sapComDocumentSapRfcFunctions.ZSD_ORDER_ITEM> ciList = new List<sapComDocumentSapRfcFunctions.ZSD_ORDER_ITEM>();
       ciList.add(ci);
       ciList.add(ci1);       
             
       sapComDocumentSapRfcFunctions.ZSD_ORDER_HEADER ch = new sapComDocumentSapRfcFunctions.ZSD_ORDER_HEADER();
       ch.CONTRACT = '800015';
       ch.SOLD_TO = '800015';
       ch.PURCH_NO_C = 'Mock P';
       ch.STREET = 'Mock str';
       ch.CITY = 'Mock ct';
       ch.REGION = 'Mock rgn';
       ch.POSTL_CODE = '123122';
       ch.orderitems = ciList;
       ch.con_st_dat_h ='2015-12-12';
       ch.con_en_dat_h ='2040-12-15';
               
       
       sapComDocumentSapRfcFunctions.ZSD_ORDER_HEADER ch1 = new sapComDocumentSapRfcFunctions.ZSD_ORDER_HEADER();
       ch1.CONTRACT = '800015';
       ch1.SOLD_TO = '800015';
       ch1.PURCH_NO_C = 'Mock P';
       ch1.STREET = 'Mock str';
       ch1.CITY = 'Mock ct';
       ch1.REGION = 'Mock rgn';
       ch1.POSTL_CODE = '123122';
       ch1.orderitems = ciList;
       ch1.con_st_dat_h ='2015-12-12';
       ch1.con_en_dat_h ='2040-12-15';
       
       List<sapComDocumentSapRfcFunctions.ZSD_ORDER_HEADER> chList = new List<sapComDocumentSapRfcFunctions.ZSD_ORDER_HEADER>();
       chList.add(ch);
       chList.add(ch1);
       
       sapComDocumentSapRfcFunctions.T_CONTRACT_HEADERS_element che = new sapComDocumentSapRfcFunctions.T_CONTRACT_HEADERS_element();
       che.item = chList;
       
       sapComDocumentSapRfcFunctions.T_CONTRACT_ITEMS_element cie = new sapComDocumentSapRfcFunctions.T_CONTRACT_ITEMS_element();
       cie.item = ciList;
       
       sapComDocumentSapRfcFunctions.BAPIRET2 rei = new sapComDocumentSapRfcFunctions.BAPIRET2();
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
       
       List<sapComDocumentSapRfcFunctions.BAPIRET2> reiList = new List<sapComDocumentSapRfcFunctions.BAPIRET2>(); 
       reiList.add(rei);
       
       sapComDocumentSapRfcFunctions.T_RETURN_element re = new sapComDocumentSapRfcFunctions.T_RETURN_element();
       re.item = reiList;
       
       respElement.T_CONTRACT_HEADERS  =  che; 
       respElement.T_CONTRACT_ITEMS = cie;
       respElement.T_RETURN = re;
       System.debug('respElement...........'+respElement);
       response.put('response_x', respElement); 
   }
}