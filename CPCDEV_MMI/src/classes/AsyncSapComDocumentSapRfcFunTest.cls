@isTest
public class AsyncSapComDocumentSapRfcFunTest {
    static testMethod void myUnitTest1() {
        
        AsyncSapComDocumentSapRfcFunctionsFin asynch = new AsyncSapComDocumentSapRfcFunctionsFin();
        AsyncSapComDocumentSapRfcFunctionsFin.ZFIF_FINANCIAL_SUMMARY_Response_elementFuture   finance = new AsyncSapComDocumentSapRfcFunctionsFin.ZFIF_FINANCIAL_SUMMARY_Response_elementFuture();
        finance.getValue();
        
        AsyncSapComDocumentSapRfcFunctions SapRfc = new AsyncSapComDocumentSapRfcFunctions();
        AsyncSapComDocumentSapRfcFunctions.ZSD_CONTRACT_SEARCH_Response_elementFuture RfcFun =new AsyncSapComDocumentSapRfcFunctions.ZSD_CONTRACT_SEARCH_Response_elementFuture();
        RfcFun.getValue();
        
        AsyncMobileminiComEccOrderchange AMCEOC = new AsyncMobileminiComEccOrderchange();
        AsyncMobileminiComEccOrderchange.AsyncHTTP_Port AMCEOCASHP = new AsyncMobileminiComEccOrderchange.AsyncHTTP_Port();
        Continuation con = new Continuation(60);
		sapComDocumentOrderchange.RETURN_element RETURN_x = new sapComDocumentOrderchange.RETURN_element();
        AMCEOCASHP.beginOs_Order_Update_DocuSign_Status(con,'DOCUSIGN_DONE','SALESDOCUMENT','test Quote',RETURN_x);
        
        AsyncMobileminiComEccFinancialsummary AMCEFS = new AsyncMobileminiComEccFinancialsummary();
        AsyncMobileminiComEccFinancialsummary.AsyncHTTPS_Port AMCEFSASHP = new AsyncMobileminiComEccFinancialsummary.AsyncHTTPS_Port();
    	sapComDocumentSapRfcFunctionsFin.ET_RETURN_element ET_RETURN = new sapComDocumentSapRfcFunctionsFin.ET_RETURN_element();
        sapComDocumentSapRfcFunctionsFin.ET_FIN_SUM_element ET_RETURN1 = new sapComDocumentSapRfcFunctionsFin.ET_FIN_SUM_element();
        sapComDocumentSapRfcFunctionsFin.ZFIF_FINANCIAL_SUMMARY_Response_element ET_RETURN2 = new sapComDocumentSapRfcFunctionsFin.ZFIF_FINANCIAL_SUMMARY_Response_element();
        sapComDocumentSapRfcFunctionsFin.BAPIRET1 ET_RETURN3 = new sapComDocumentSapRfcFunctionsFin.BAPIRET1();
        sapComDocumentSapRfcFunctionsFin.ZFI_KUNNR_FIN_SUM ET_RETURN4 = new sapComDocumentSapRfcFunctionsFin.ZFI_KUNNR_FIN_SUM();
        AMCEFSASHP.beginOs_Financial_Summary(con,'I_KEY_DATE','I_KUNRE','I_VKORG',ET_RETURN);
        
        AsyncMobileminiComEccContractsearch AMCECS = new AsyncMobileminiComEccContractsearch();
        AsyncMobileminiComEccContractsearch.AsyncHTTP_Port AMCECSASHP = new AsyncMobileminiComEccContractsearch.AsyncHTTP_Port();
        sapComDocumentSapRfcFunctions.I_CUSTOMERS_element I_CUSTOMER = new sapComDocumentSapRfcFunctions.I_CUSTOMERS_element();
        sapComDocumentSapRfcFunctions.ZSD_CUSTOMER_REQ I_CUSTOMER1 = new sapComDocumentSapRfcFunctions.ZSD_CUSTOMER_REQ();
        sapComDocumentSapRfcFunctions.ZSD_ORDER_HEADER I_CUSTOMER2 = new sapComDocumentSapRfcFunctions.ZSD_ORDER_HEADER();
        sapComDocumentSapRfcFunctions.T_CONTRACT_HEADERS_element I_CUSTOMER3 = new sapComDocumentSapRfcFunctions.T_CONTRACT_HEADERS_element();
        sapComDocumentSapRfcFunctions.ZSD_CONTRACT_SEARCH_Response_element I_CUSTOMER4 = new sapComDocumentSapRfcFunctions.ZSD_CONTRACT_SEARCH_Response_element();
        sapComDocumentSapRfcFunctions.BAPIRET2 I_CUSTOMER5 = new sapComDocumentSapRfcFunctions.BAPIRET2();
        sapComDocumentSapRfcFunctions.ZSD_ORDER_ITEM I_CUSTOMER6 = new sapComDocumentSapRfcFunctions.ZSD_ORDER_ITEM();
        sapComDocumentSapRfcFunctions.T_RETURN_element I_CUSTOMER7 = new sapComDocumentSapRfcFunctions.T_RETURN_element();
        sapComDocumentSapRfcFunctions.T_CONTRACT_ITEMS_element I_CUSTOMER8 = new sapComDocumentSapRfcFunctions.T_CONTRACT_ITEMS_element();
        AMCECSASHP.beginOs_ContractSearch_III(con,'I_CONTRACT_NUMBER','I_CON_EN_DAT','I_CON_ST_DAT',I_CUSTOMER,'I_NO_CONTRACT_RET','I_PARTNER_FUNCTION','I_SERIAL_NUMBER','I_STATUS');
    	
        AsyncSapComDocumentOrderchange orderChange = new AsyncSapComDocumentOrderchange();
        AsyncSapComDocumentOrderchange.ZSD_ORDER_UPDATE_DOCUSIGN_STS_Response_elementFuture element = new AsyncSapComDocumentOrderchange.ZSD_ORDER_UPDATE_DOCUSIGN_STS_Response_elementFuture();
        sapComDocumentOrderchange.RETURN_element scdsrf = new sapComDocumentOrderchange.RETURN_element();
        //element.getValue();
    }
}