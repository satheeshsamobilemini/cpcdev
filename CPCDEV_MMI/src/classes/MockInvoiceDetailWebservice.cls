@isTest
global class MockInvoiceDetailWebservice implements WebserviceMock{
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
        sapComDocumentSapRfcFnInvoice.ZSD_INVOICE_DETAILS_Response_element respElement = new sapComDocumentSapRfcFnInvoice.ZSD_INVOICE_DETAILS_Response_element();
         
               sapComDocumentSapRfcFnInvoice.ZSD_INVOICE_HEADER invHdr = new sapComDocumentSapRfcFnInvoice.ZSD_INVOICE_HEADER();
                invHdr.INVOICE_NUMBER = '0090000040';
                invHdr.SALES_ORG = '1000';
                invHdr.DISTR_CHAN = '10';
                invHdr.DOC_CATEG = 'M';
                invHdr.INVOICE_DATE = '06/29/2015';
                invHdr.TERMS_CODE = 'NT30';
                invHdr.INVOICE_AMOUNT = '1779.98';
                invHdr.CURRENCY_x = 'USD';
                invHdr.PAYING_CUSTOMER = '0000800015';
                invHdr.SOLD_TO_CUSTOMER ='0000800015';
                invHdr.CONTRACT ='0000000077';
               
              List<sapComDocumentSapRfcFnInvoice.ZSD_INVOICE_LINE> invLineList = new List<sapComDocumentSapRfcFnInvoice.ZSD_INVOICE_LINE>();
              
              sapComDocumentSapRfcFnInvoice.ZSD_INVOICE_LINE invLineVar = new sapComDocumentSapRfcFnInvoice.ZSD_INVOICE_LINE();
                invLineVar.ITM_NUMBER = '000010';
                invLineVar.MATERIAL = '40ZK';
                invLineVar.DESCRIPTION = '40ZK 40 Double Doors';
                invLineVar.QUANTITY = '1.000';
                invLineVar.UNIT_OF_MEASURE = 'EA';
                invLineVar.AMOUNT = '1691.48';
                invLineVar.CONTRACT ='0000000077';
                invLineVar.CONTRACT_LINE = '';
                invLineVar.PLANT = '1101';
                invLineVar.ITEM_CATEG = 'ZSL1';
                invLineVar.ITEM_TAX = '0.00';
               
               sapComDocumentSapRfcFnInvoice.ZSD_INVOICE_LINE invLineVar1 = new sapComDocumentSapRfcFnInvoice.ZSD_INVOICE_LINE();
                invLineVar1.ITM_NUMBER = '000020';
                invLineVar1.MATERIAL = 'DELIVERY';
                invLineVar1.DESCRIPTION = 'Delivery Charge';
                invLineVar1.QUANTITY = '1.000';
                invLineVar1.UNIT_OF_MEASURE = 'LE';
                invLineVar1.AMOUNT = '88.50';
                invLineVar1.CONTRACT ='0000000077';
                invLineVar1.CONTRACT_LINE = '';
                invLineVar1.PLANT = '1101';
                invLineVar1.ITEM_CATEG = 'ZOTC';
                invLineVar1.ITEM_TAX = '0.00';
              
               invLineList.add(invLineVar);
               invLineList.add(invLineVar1);
               
               sapComDocumentSapRfcFnInvoice.E_INVOICE_LINES_element sile = new sapComDocumentSapRfcFnInvoice.E_INVOICE_LINES_element();
               sile.item = invLineList;
               
               List<sapComDocumentSapRfcFnInvoice.ZSD_LINE_PRICE> linePriceList = new List<sapComDocumentSapRfcFnInvoice.ZSD_LINE_PRICE>();
               sapComDocumentSapRfcFnInvoice.ZSD_LINE_PRICE linePriceVar = new sapComDocumentSapRfcFnInvoice.ZSD_LINE_PRICE();
                linePriceVar.ITM_NUMBER ='000010';
                linePriceVar.STEP_NUMBER ='90';
                linePriceVar.COUNTER = '02';
                linePriceVar.COND_TYPE = 'ZP00';
                linePriceVar.VTEXT = 'MMI 28 Day Rate';
                linePriceVar.RATE = '1425.00';
                linePriceVar.CURRENCY_x = 'USD';
                linePriceVar.AMOUNT = '1425.00';
               
                sapComDocumentSapRfcFnInvoice.ZSD_LINE_PRICE linePriceVar1 = new sapComDocumentSapRfcFnInvoice.ZSD_LINE_PRICE();
                linePriceVar1.ITM_NUMBER ='000020';
                linePriceVar1.STEP_NUMBER ='90';
                linePriceVar1.COUNTER = '02';
                linePriceVar1.COND_TYPE = 'ZP00';
                linePriceVar1.VTEXT = 'MMI 28 Day Rate';
                linePriceVar1.RATE = '75.00';
                linePriceVar1.CURRENCY_x = 'USD';
                linePriceVar1.AMOUNT = '75.00';
                
               linePriceList.add(linePriceVar);
               linePriceList.add(linePriceVar1);
               
               sapComDocumentSapRfcFnInvoice.E_LINE_PRICING_element slpe = new sapComDocumentSapRfcFnInvoice.E_LINE_PRICING_element();
               slpe.item = linePriceList;
               
              sapComDocumentSapRfcFnInvoice.BAPIRET2 bapVar = new sapComDocumentSapRfcFnInvoice.BAPIRET2();
               
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
     
                respElement.E_HEADER = invHdr;
               respElement.E_INVOICE_LINES = sile;
               respElement.E_LINE_PRICING = slpe;
               respElement.RETURN_x = bapVar;
               response.put('response_x', respElement);
           
           }


}