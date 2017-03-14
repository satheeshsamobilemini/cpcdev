//Generated by wsdl2apex

public class sapComDocumentSapRfcFnInvoice {
    public class ZSD_INVOICE_DETAILS_Response_element {
        public sapComDocumentSapRfcFnInvoice.ZSD_INVOICE_HEADER E_HEADER;
        public sapComDocumentSapRfcFnInvoice.E_INVOICE_LINES_element E_INVOICE_LINES;
        public sapComDocumentSapRfcFnInvoice.E_LINE_PRICING_element E_LINE_PRICING;
        public sapComDocumentSapRfcFnInvoice.BAPIRET2 RETURN_x;
        private String[] E_HEADER_type_info = new String[]{'E_HEADER','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] E_INVOICE_LINES_type_info = new String[]{'E_INVOICE_LINES','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] E_LINE_PRICING_type_info = new String[]{'E_LINE_PRICING','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] RETURN_x_type_info = new String[]{'RETURN','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:sap-com:document:sap:rfc:functions','false','false'};
        private String[] field_order_type_info = new String[]{'E_HEADER','E_INVOICE_LINES','E_LINE_PRICING','RETURN_x'};
    }
    public class ZSD_INVOICE_LINE {
        public String ITM_NUMBER;
        public String MATERIAL;
        public String DESCRIPTION;
        public String QUANTITY;
        public String UNIT_OF_MEASURE;
        public String AMOUNT;
        public String CONTRACT;
        public String CONTRACT_LINE;
        public String PLANT;
        public String ITEM_CATEG;
        public String ITEM_TAX;
        private String[] ITM_NUMBER_type_info = new String[]{'ITM_NUMBER','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] MATERIAL_type_info = new String[]{'MATERIAL','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] DESCRIPTION_type_info = new String[]{'DESCRIPTION','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] QUANTITY_type_info = new String[]{'QUANTITY','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] UNIT_OF_MEASURE_type_info = new String[]{'UNIT_OF_MEASURE','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] AMOUNT_type_info = new String[]{'AMOUNT','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] CONTRACT_type_info = new String[]{'CONTRACT','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] CONTRACT_LINE_type_info = new String[]{'CONTRACT_LINE','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] PLANT_type_info = new String[]{'PLANT','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] ITEM_CATEG_type_info = new String[]{'ITEM_CATEG','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] ITEM_TAX_type_info = new String[]{'ITEM_TAX','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:sap-com:document:sap:rfc:functions','false','false'};
        private String[] field_order_type_info = new String[]{'ITM_NUMBER','MATERIAL','DESCRIPTION','QUANTITY','UNIT_OF_MEASURE','AMOUNT','CONTRACT','CONTRACT_LINE','PLANT','ITEM_CATEG','ITEM_TAX'};
    }
    public class ZSD_INVOICE_HEADER {
        public String INVOICE_NUMBER;
        public String SALES_ORG;
        public String DISTR_CHAN;
        public String DOC_CATEG;
        public String INVOICE_DATE;
        public String TERMS_CODE;
        public String INVOICE_AMOUNT;
        public String CURRENCY_x;
        public String PAYING_CUSTOMER;
        public String SOLD_TO_CUSTOMER;
        public String CONTRACT;
        public String SHIP2_CUSTOMER;
        private String[] INVOICE_NUMBER_type_info = new String[]{'INVOICE_NUMBER','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] SALES_ORG_type_info = new String[]{'SALES_ORG','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] DISTR_CHAN_type_info = new String[]{'DISTR_CHAN','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] DOC_CATEG_type_info = new String[]{'DOC_CATEG','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] INVOICE_DATE_type_info = new String[]{'INVOICE_DATE','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] TERMS_CODE_type_info = new String[]{'TERMS_CODE','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] INVOICE_AMOUNT_type_info = new String[]{'INVOICE_AMOUNT','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] CURRENCY_x_type_info = new String[]{'CURRENCY','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] PAYING_CUSTOMER_type_info = new String[]{'PAYING_CUSTOMER','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] SOLD_TO_CUSTOMER_type_info = new String[]{'SOLD_TO_CUSTOMER','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] CONTRACT_type_info = new String[]{'CONTRACT','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] SHIP2_CUSTOMER_type_info = new String[]{'SHIP2_CUSTOMER','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:sap-com:document:sap:rfc:functions','false','false'};
        private String[] field_order_type_info = new String[]{'INVOICE_NUMBER','SALES_ORG','DISTR_CHAN','DOC_CATEG','INVOICE_DATE','TERMS_CODE','INVOICE_AMOUNT','CURRENCY_x','PAYING_CUSTOMER','SOLD_TO_CUSTOMER','CONTRACT'};
    }
    public class ZSD_LINE_PRICE {
        public String ITM_NUMBER;
        public String STEP_NUMBER;
        public String COUNTER;
        public String COND_TYPE;
        public String RATE;
        public String CURRENCY_x;
        public String AMOUNT;
        public String VTEXT;
        private String[] ITM_NUMBER_type_info = new String[]{'ITM_NUMBER','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] STEP_NUMBER_type_info = new String[]{'STEP_NUMBER','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] COUNTER_type_info = new String[]{'COUNTER','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] COND_TYPE_type_info = new String[]{'COND_TYPE','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] RATE_type_info = new String[]{'RATE','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] CURRENCY_x_type_info = new String[]{'CURRENCY','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] AMOUNT_type_info = new String[]{'AMOUNT','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] VTEXT_type_info = new String[]{'VTEXT','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:sap-com:document:sap:rfc:functions','false','false'};
        private String[] field_order_type_info = new String[]{'ITM_NUMBER','STEP_NUMBER','COUNTER','COND_TYPE','RATE','CURRENCY_x','AMOUNT','VTEXT'};
    }
    public class E_INVOICE_LINES_element {
        public sapComDocumentSapRfcFnInvoice.ZSD_INVOICE_LINE[] item;
        private String[] item_type_info = new String[]{'item','urn:sap-com:document:sap:rfc:functions',null,'0','-1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:sap-com:document:sap:rfc:functions','false','false'};
        private String[] field_order_type_info = new String[]{'item'};
    }
    public class BAPIRET2 {
        public String TYPE_x;
        public String ID;
        public String NUMBER_x;
        public String MESSAGE;
        public String LOG_NO;
        public String LOG_MSG_NO;
        public String MESSAGE_V1;
        public String MESSAGE_V2;
        public String MESSAGE_V3;
        public String MESSAGE_V4;
        public String PARAMETER;
        public Integer ROW;
        public String FIELD;
        public String SYSTEM_x;
        private String[] TYPE_x_type_info = new String[]{'TYPE','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] ID_type_info = new String[]{'ID','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] NUMBER_x_type_info = new String[]{'NUMBER','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] MESSAGE_type_info = new String[]{'MESSAGE','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] LOG_NO_type_info = new String[]{'LOG_NO','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] LOG_MSG_NO_type_info = new String[]{'LOG_MSG_NO','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] MESSAGE_V1_type_info = new String[]{'MESSAGE_V1','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] MESSAGE_V2_type_info = new String[]{'MESSAGE_V2','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] MESSAGE_V3_type_info = new String[]{'MESSAGE_V3','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] MESSAGE_V4_type_info = new String[]{'MESSAGE_V4','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] PARAMETER_type_info = new String[]{'PARAMETER','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] ROW_type_info = new String[]{'ROW','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] FIELD_type_info = new String[]{'FIELD','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] SYSTEM_x_type_info = new String[]{'SYSTEM','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:sap-com:document:sap:rfc:functions','false','false'};
        private String[] field_order_type_info = new String[]{'TYPE_x','ID','NUMBER_x','MESSAGE','LOG_NO','LOG_MSG_NO','MESSAGE_V1','MESSAGE_V2','MESSAGE_V3','MESSAGE_V4','PARAMETER','ROW','FIELD','SYSTEM_x'};
    }
    public class ZSD_INVOICE_DETAILS_element {
        public String I_INVOICE;
        public String I_SUMM_TAX;
        private String[] I_INVOICE_type_info = new String[]{'I_INVOICE','urn:sap-com:document:sap:rfc:functions',null,'1','1','false'};
        private String[] I_SUMM_TAX_type_info = new String[]{'I_SUMM_TAX','urn:sap-com:document:sap:rfc:functions',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:sap-com:document:sap:rfc:functions','false','false'};
        private String[] field_order_type_info = new String[]{'I_INVOICE','I_SUMM_TAX'};
    }
    public class E_LINE_PRICING_element {
        public sapComDocumentSapRfcFnInvoice.ZSD_LINE_PRICE[] item;
        private String[] item_type_info = new String[]{'item','urn:sap-com:document:sap:rfc:functions',null,'0','-1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:sap-com:document:sap:rfc:functions','false','false'};
        private String[] field_order_type_info = new String[]{'item'};
    }
}