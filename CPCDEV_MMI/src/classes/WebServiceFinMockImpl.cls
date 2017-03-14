@isTest
global class WebServiceFinMockImpl implements WebServiceMock {
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
       sapComDocumentSapRfcFunctionsFin.ZFIF_FINANCIAL_SUMMARY_Response_element respElement = new sapComDocumentSapRfcFunctionsFin.ZFIF_FINANCIAL_SUMMARY_Response_element();
       
       sapComDocumentSapRfcFunctionsFin.ZFI_KUNNR_FIN_SUM fs = new sapComDocumentSapRfcFunctionsFin.ZFI_KUNNR_FIN_SUM();
       fs.CUSTOMER = '800015';
       fs.DUE_0_TO_29 = '29';
       fs.DUE_30_TO_59 = '59';
       fs.DUE_60_TO_89 = '89';
       fs.DUE_90_TO_119 = '119';
       fs.DUE_120_PLUS = '120';
       fs.CREDIT_LIMIT = '10';
       fs.RISK_CAT = 'New';
       fs.EXP_DATE = '2016-10-31';
       
       fs.COLLECTOR_NAME = 'Collector';
       fs.RISK_CAT_DESC = 'New Customer';
       fs.LAST_INVOICE_DT = '2016-09-27';
       fs.PAY_TERMS = 'NT21';
       fs.CUSTOMER_GROUP = 'Monthly Recurring';
       fs.CERTFCT_FILE = 'PPE Exempt';
       fs.BILLING_INST = 'Invoice must go to job site address';
       
       sapComDocumentSapRfcFunctionsFin.ZFI_KUNNR_FIN_SUM fs1 = new sapComDocumentSapRfcFunctionsFin.ZFI_KUNNR_FIN_SUM();
       fs1.CUSTOMER = '800015';
       fs1.DUE_0_TO_29 = '29';
       fs1.DUE_30_TO_59 = '59';
       fs1.DUE_60_TO_89 = '89';
       fs1.DUE_90_TO_119 = '119';
       fs1.DUE_120_PLUS = '120';
       fs1.CREDIT_LIMIT = '10';
       fs1.RISK_CAT = 'New';
       fs1.EXP_DATE = '2016-10-31';
       
       fs1.COLLECTOR_NAME = 'Collector';
       fs1.RISK_CAT_DESC = 'New Customer';
       fs1.LAST_INVOICE_DT = '2016-09-27';
       fs1.PAY_TERMS = 'NT21';
       fs1.CUSTOMER_GROUP = 'Monthly Recurring';
       fs1.CERTFCT_FILE = 'PPE Exempt';
       fs1.BILLING_INST = 'Invoice must go to job site address';
              
       List<sapComDocumentSapRfcFunctionsFin.ZFI_KUNNR_FIN_SUM> fsList = new List<sapComDocumentSapRfcFunctionsFin.ZFI_KUNNR_FIN_SUM>();
       fsList.add(fs);
       fsList.add(fs1);       
                    
       sapComDocumentSapRfcFunctionsFin.ET_FIN_SUM_element  fse = new sapComDocumentSapRfcFunctionsFin.ET_FIN_SUM_element();
       fse.item = fsList;
       
       sapComDocumentSapRfcFunctionsFin.BAPIRET1 rei = new sapComDocumentSapRfcFunctionsFin.BAPIRET1();
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
       
       List<sapComDocumentSapRfcFunctionsFin.BAPIRET1> reiList = new List<sapComDocumentSapRfcFunctionsFin.BAPIRET1>(); 
       reiList.add(rei);
             
       sapComDocumentSapRfcFunctionsFin.ET_RETURN_element re = new sapComDocumentSapRfcFunctionsFin.ET_RETURN_element();
       re.item = reiList;
       
       respElement.ET_FIN_SUM=  fse; 
       respElement.ET_RETURN = re;
       
       response.put('response_x', respElement); 
   }
}