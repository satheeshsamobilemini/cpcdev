/**
* (c) 2015 TEKsystems Global Services
*
* Name           : DataForcontracts 
* Created Date   : 8 September, 2015 
* Created By     : Sreenivas M (TEKSystems)
* Purpose        : class to consume the Contracts/Financial Summary SOAP webservices 
* Last Updated By: Ankur Goyal (TEKSystems)
* Last Updated Date: 21-Jan-2016
**/


public class DataForcontracts{
    
    public static List<sapComDocumentSapRfcFunctions.ZSD_ORDER_HEADER> contractsList = new List<sapComDocumentSapRfcFunctions.ZSD_ORDER_HEADER>();
    public static List<sapComDocumentSapRfcFunctions.ZSD_ORDER_ITEM> contractItemsList= new List<sapComDocumentSapRfcFunctions.ZSD_ORDER_ITEM>();
    public static List<sapComDocumentSapRfcFunctionsFin.ZFI_KUNNR_FIN_SUM> financialSummaryList = new List<sapComDocumentSapRfcFunctionsFin.ZFI_KUNNR_FIN_SUM>();


    //Ankur : fetch the contract information from response received via SOAP callout
    //public static LIST<sapComDocumentSapRfcFunctions.ZSD_ORDER_HEADER> fetchContractsFromResponse(String curAccID,String returnContractsCount,String contractsFromDate,String contractsToDate,String contractStatus,String contractSrNo,String contractNumber){
    public static sapComDocumentSapRfcFunctions.ZSD_CONTRACT_SEARCH_Response_element fetchContractsFromResponse(String curAccID,String returnContractsCount,String contractsFromDate,String contractsToDate,String contractStatus,String contractSrNo,String contractNumber){
        mobileminiComEccContractsearch.HTTP_Port  stub = new mobileminiComEccContractsearch.HTTP_Port();
        stub.inputHttpHeaders_x = new Map<String, String>();

        //Blob headerValue = Blob.valueOf('data_int' + ':' + 'Letm3in!');
        //Blob headerValue = Blob.valueOf('data_int' + ':' + 'Letm3in!');
        Blob headerValue = Blob.valueOf('PIPREMOTE' + ':' + 'L3tm31n$$');
        SAPWebserviceConnectionInfo.getWebserviceDetails();
        //Blob headerValue = Blob.valueOf(SAPWebserviceConnectionInfo.userName + ':' + SAPWebserviceConnectionInfo.password);
        String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
        
        //Setting a basic authentication header
        stub.inputHttpHeaders_x.put('Authorization', authorizationHeader);
        stub.timeout_x = 120000;
       
        sapComDocumentSapRfcFunctions.I_CUSTOMERS_element I_CUSTOMERS = new sapComDocumentSapRfcFunctions.I_CUSTOMERS_element();
        List<sapComDocumentSapRfcFunctions.ZSD_CUSTOMER_REQ> customerReqList = new List<sapComDocumentSapRfcFunctions.ZSD_CUSTOMER_REQ>();
        sapComDocumentSapRfcFunctions.ZSD_CUSTOMER_REQ customerReq = new sapComDocumentSapRfcFunctions.ZSD_CUSTOMER_REQ();
        customerReq.CUSTOMER = curAccID;
        customerReq.COMPANYCODE = ''; 
        customerReqList.add(customerReq);
        I_CUSTOMERS.item = customerReqList;
        
        sapComDocumentSapRfcFunctions.ZSD_CONTRACT_SEARCH_Response_element responseElement = new sapComDocumentSapRfcFunctions.ZSD_CONTRACT_SEARCH_Response_element();
        sapComDocumentSapRfcFunctions.T_CONTRACT_HEADERS_element conHeaderElement = new sapComDocumentSapRfcFunctions.T_CONTRACT_HEADERS_element();
        sapComDocumentSapRfcFunctions.T_RETURN_element errorRetElement = new sapComDocumentSapRfcFunctions.T_RETURN_element();
        try{
        sapComDocumentSapRfcFunctions.ZSD_CONTRACT_SEARCH_Response_element resContracts = stub.os_ContractSearch_III(contractNumber, contractsToDate, contractsFromDate, I_CUSTOMERS, returnContractsCount, 'RE' ,contractSrNo, contractStatus);
        integer i=0;  
        if(resContracts.T_CONTRACT_HEADERS.item != null)
        {
            LIST<sapComDocumentSapRfcFunctions.ZSD_ORDER_HEADER> totalContractsList = resContracts.T_CONTRACT_HEADERS.item;
            sapComDocumentSapRfcFunctions.ZSD_ORDER_HEADER contractHeader;
            
            //process the contract headers and contract items
            for(sapComDocumentSapRfcFunctions.ZSD_ORDER_HEADER tContract : totalContractsList)
            {
                if(i > 200 )
                    break;
                i = i+1;
                contractHeader = new sapComDocumentSapRfcFunctions.ZSD_ORDER_HEADER();    
                contractHeader.contract = tContract.contract;
                contractHeader.purch_no_c = tContract.purch_no_c;
                contractHeader.street = tContract.street;
                contractHeader.city = tContract.city;
                contractHeader.region = tContract.region;
                contractHeader.postl_code = tContract.postl_code;
                contractHeader.CON_ST_DAT_H = tContract.CON_ST_DAT_H;
                contractHeader.CON_EN_DAT_H = tContract.CON_EN_DAT_H;
                contractHeader.CREDIT_BLOCK = tContract.CREDIT_BLOCK;
                contractHeader.orderitems = new List<sapComDocumentSapRfcFunctions.ZSD_ORDER_ITEM>();
                integer j=0;
                if(resContracts.T_CONTRACT_ITEMS.item != null){
                    LIST<sapComDocumentSapRfcFunctions.ZSD_ORDER_ITEM> contractHeaderItems = resContracts.T_CONTRACT_ITEMS.item;
                    sapComDocumentSapRfcFunctions.ZSD_ORDER_ITEM contractItem;
                    for(sapComDocumentSapRfcFunctions.ZSD_ORDER_ITEM contractHeaderItem : contractHeaderItems )
                    {
                        if(String.valueof(contractHeaderItem.contract) == tContract.contract ){
                            if(j > 500 )
                                break;
                            j = j+1;
                            contractItem = new sapComDocumentSapRfcFunctions.ZSD_ORDER_ITEM();    
                            contractItem.contract = contractHeaderItem.contract;
                            contractItem.itm_number = contractHeaderItem.itm_number;
                            contractItem.status = contractHeaderItem.status;
                            contractItem.material = contractHeaderItem.material;
                            contractItem.short_text = contractHeaderItem.short_text;
                            contractItem.serial_number = contractHeaderItem.serial_number;
                            contractItem.plant = contractHeaderItem.plant;
                            contractItem.Name1 = contractHeaderItem.Name1;
                            contractItem.rate = contractHeaderItem.rate;
                            contractItem.con_st_dat_l = contractHeaderItem.con_st_dat_l;
                            contractItem.con_en_dat_l = contractHeaderItem.con_en_dat_l;
                            contractItem.PGI_DATE     =  contractHeaderItem.PGI_DATE   ;
                            contractItem.BILL_PLAN_REL =  contractHeaderItem.BILL_PLAN_REL;                            
                            contractHeader.orderitems.add(contractItem);
                        }
                    }
                }
                                                
                contractsList.add(contractHeader);
            }
           // system.debug('====contracts received in the response===='+contractsList);
        }
            errorRetElement.item = resContracts.T_RETURN.item;
            conHeaderElement.item = contractsList;
            responseElement.T_CONTRACT_HEADERS = conHeaderElement;
            responseElement.T_CONTRACT_ITEMS = resContracts.T_CONTRACT_ITEMS;
            responseElement.T_RETURN  = errorRetElement;
                    //    system.debug('==responseElement.T_CONTRACT_HEADERS.item=='+responseElement.T_CONTRACT_HEADERS.item);
                    //    system.debug('==responseElement.T_CONTRACT_ITEMS.item=='+responseElement.T_CONTRACT_ITEMS.item);
                    //    system.debug('==responseElement.T_RETURN.item=='+responseElement.T_RETURN.item);
        } //end of try
        catch(Exception e){
            throw e;
        }
                
        return responseElement; //contractsList;
    } //end of fetchContractsFromResponse
    
    
    //Ankur : fetch the units on rent for current account from response received via SOAP callout
    public static Integer fetchUORsFromResponse(String curAccID,String returnContractsCount,String contractsFromDate,String contractsToDate,String contractStatus,String contractSrNo,String contractNumber){
        mobileminiComEccContractsearch.HTTP_Port  stub = new mobileminiComEccContractsearch.HTTP_Port();
        stub.inputHttpHeaders_x = new Map<String, String>();

        //Blob headerValue = Blob.valueOf('data_int' + ':' + 'Letm3in!');
        //Blob headerValue = Blob.valueOf('data_int' + ':' + 'Letm3in!');
        Blob headerValue = Blob.valueOf('PIPREMOTE' + ':' + 'L3tm31n$$');
        SAPWebserviceConnectionInfo.getWebserviceDetails();
        //Blob headerValue = Blob.valueOf(SAPWebserviceConnectionInfo.userName + ':' + SAPWebserviceConnectionInfo.password);
        String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
        
        //Setting a basic authentication header
        stub.inputHttpHeaders_x.put('Authorization', authorizationHeader);
        stub.timeout_x = 120000;
        
        sapComDocumentSapRfcFunctions.I_CUSTOMERS_element I_CUSTOMERS = new sapComDocumentSapRfcFunctions.I_CUSTOMERS_element();
        List<sapComDocumentSapRfcFunctions.ZSD_CUSTOMER_REQ> customerReqList = new List<sapComDocumentSapRfcFunctions.ZSD_CUSTOMER_REQ>();
        sapComDocumentSapRfcFunctions.ZSD_CUSTOMER_REQ customerReq = new sapComDocumentSapRfcFunctions.ZSD_CUSTOMER_REQ();
        customerReq.CUSTOMER = curAccID;
        customerReq.COMPANYCODE = ''; 
        customerReqList.add(customerReq);
        I_CUSTOMERS.item = customerReqList; 
        
        sapComDocumentSapRfcFunctions.ZSD_CONTRACT_SEARCH_Response_element responseElement = new sapComDocumentSapRfcFunctions.ZSD_CONTRACT_SEARCH_Response_element();
        sapComDocumentSapRfcFunctions.T_CONTRACT_HEADERS_element conHeaderElement = new sapComDocumentSapRfcFunctions.T_CONTRACT_HEADERS_element();
        sapComDocumentSapRfcFunctions.T_RETURN_element errorRetElement = new sapComDocumentSapRfcFunctions.T_RETURN_element();
        integer UORs=0;
        try{
            sapComDocumentSapRfcFunctions.ZSD_CONTRACT_SEARCH_Response_element resContracts = stub.os_ContractSearch_III(contractNumber, contractsToDate, contractsFromDate, I_CUSTOMERS, returnContractsCount, 'RE' ,contractSrNo, contractStatus);
            
              
            if(resContracts.T_CONTRACT_ITEMS.item != null )
            {
                for(sapComDocumentSapRfcFunctions.ZSD_ORDER_ITEM conItem : resContracts.T_CONTRACT_ITEMS.item){
                    if(conItem.SERIAL_NUMBER != '' && conItem.SERIAL_NUMBER != null)
                        UORs =  UORs + 1 ; //resContracts.T_CONTRACT_ITEMS.item.size();    
                }
            }
        } //end of try
        catch(Exception e){
            throw e;
        }
                
        return UORs; 
    } //end of fetchUORsFromResponse


    //Ankur : fetch the financial summary data from response received via SOAP callout
    public static sapComDocumentSapRfcFunctionsFin.ZFIF_FINANCIAL_SUMMARY_Response_element fetchFinancialSummaryFromCPQResponse(String sapId,string salesOrg){
    //List<sapComDocumentSapRfcFunctionsFin.ZFI_KUNNR_FIN_SUM> fetchFinancialSummaryFromCPQResponse(String sapId,string salesOrg){
    
        mobileminiComEccFinancialsummary.HTTP_Port stub = new mobileminiComEccFinancialsummary.HTTP_Port();
        stub.inputHttpHeaders_x = new Map<String, String>();
        
        //Blob headerValue = Blob.valueOf('data_int' + ':' + 'Letm3in!');
        //Blob headerValue = Blob.valueOf('data_int' + ':' + 'Letm3in!');
        Blob headerValue = Blob.valueOf('PIPREMOTE' + ':' + 'L3tm31n$$');
        
        SAPWebserviceConnectionInfo.getWebserviceDetails();
        //Blob headerValue = Blob.valueOf(SAPWebserviceConnectionInfo.userName + ':' + SAPWebserviceConnectionInfo.password);
        String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
        
        //Setting a basic authentication header
        stub.inputHttpHeaders_x.put('Authorization', authorizationHeader);
        stub.timeout_x = 120000;
        
        sapComDocumentSapRfcFunctionsFin.ZFIF_FINANCIAL_SUMMARY_Response_element finResEle = new sapComDocumentSapRfcFunctionsFin.ZFIF_FINANCIAL_SUMMARY_Response_element();
        sapComDocumentSapRfcFunctionsFin.ET_FIN_SUM_element finSumEle = new sapComDocumentSapRfcFunctionsFin.ET_FIN_SUM_element();
        sapComDocumentSapRfcFunctionsFin.ET_RETURN_element finErrEle = new sapComDocumentSapRfcFunctionsFin.ET_RETURN_element();
        
        try{
        sapComDocumentSapRfcFunctionsFin.ZFIF_FINANCIAL_SUMMARY_Response_element resFinSum = stub.os_Financial_Summary(null,sapId,salesOrg,null);
        
        if(resFinSum.ET_FIN_SUM.item != null)
        {
            LIST<sapComDocumentSapRfcFunctionsFin.ZFI_KUNNR_FIN_SUM> totalFinSum = resFinSum.ET_FIN_SUM.item;
            sapComDocumentSapRfcFunctionsFin.ZFI_KUNNR_FIN_SUM financialSummary;
            
            for(sapComDocumentSapRfcFunctionsFin.ZFI_KUNNR_FIN_SUM tfs : totalFinSum)
            {
                financialSummary = new sapComDocumentSapRfcFunctionsFin.ZFI_KUNNR_FIN_SUM();    
                financialSummary.customer      = tfs.customer;
                financialSummary.due_0_TO_29   = tfs.due_0_TO_29;
                financialSummary.due_30_TO_59  = tfs.due_30_TO_59;
                financialSummary.due_60_TO_89  = tfs.due_60_TO_89;
                financialSummary.due_90_TO_119 = tfs.due_90_TO_119;
                financialSummary.due_120_PLUS  = tfs.due_120_PLUS;
                financialSummary.credit_limit  = tfs.credit_limit;
                financialSummary.risk_cat      = tfs.risk_cat;
                financialSummary.exp_date      = tfs.exp_date;
                //financialSummary.code_desc     = tfs.code_desc;
                financialSummary.collector_name= tfs.collector_name;
                financialSummary.risk_cat_desc = tfs.risk_cat_desc;
                financialSummary.last_invoice_dt= tfs.last_invoice_dt;
                financialSummary.pay_terms     = tfs.pay_terms;
                financialSummary.customer_group= tfs.customer_group;
                financialSummary.certfct_file  = tfs.certfct_file;
                financialSummary.billing_inst  = tfs.billing_inst;
                financialSummary.CREDIT_USED   = tfs.CREDIT_USED;
                financialSummary.DELTA_CREDIT  = tfs.DELTA_CREDIT;
                financialSummaryList.add(financialSummary);
           }
        }
        
            finSumEle.item = financialSummaryList;
            finErrEle.item = resFinSum.ET_RETURN.item;
            finResEle.ET_FIN_SUM = finSumEle;
            finResEle.ET_RETURN = finErrEle;
           
        } //end of try
        catch(Exception e){
            throw e;
        }
        return finResEle; //financialSummaryList;
    } //end of fetchFinancialSummaryFromCPQResponse
    
    
    //Fetch and process the collector notes
    public static List<CollectorNotesCntrl.WrapperCollectorNotes> getCollectorNotesData(String customer,String segment,string sinceDate,string recType){
        
        Map<String,String> contactTypeMap = new Map<String,String>();
        Map<String,String> contactResultMap = new Map<String,String>();
        Map<String,String> contactDirectionMap = new Map<String,String>();
        
        //get contact type to text mapping from custom setting Collector_Notes_Contact_Type_Mapping__c and store in map
        for(Collector_Notes_Contact_Type_Mapping__c ctm : Collector_Notes_Contact_Type_Mapping__c.getAll().Values()){
            contactTypeMap.put(ctm.name,ctm.Contact_Type_Text__c);    
        }
        
        //get contact result type to text mapping from custom setting Collector_Notes_Contact_Result_Mapping__c and store in map
        for(Collector_Notes_Contact_Result_Mapping__c crm : Collector_Notes_Contact_Result_Mapping__c.getAll().values()){
            contactResultMap.put(crm.name,crm.Result_Type_Text__c);    
        }
        
        //contact direction to text map - currently hard coded as only two possible values are there. Later custom setting may be introduced if records increases
        contactDirectionMap.put('I','Inbound');
        contactDirectionMap.put('O','Outbound');
        
        //List<sapComDocumentCustomercontacts.BDM_CCT> collectorNotesDataList = new List<sapComDocumentCustomercontacts.BDM_CCT>();
        List<CollectorNotesCntrl.WrapperCollectorNotes> collectorNotesWrapperList = new List<CollectorNotesCntrl.WrapperCollectorNotes>();
        
        if(Test.isRunningTest()){
            sapComDocumentCustomercontacts.BDM_CCT bdm = new sapComDocumentCustomercontacts.BDM_CCT();
            sapComDocumentCustomercontacts.BUPA_PARTNER bupa = new sapComDocumentCustomercontacts.BUPA_PARTNER();
            sapComDocumentCustomercontacts.ET_NOTES_element etnote = new sapComDocumentCustomercontacts.ET_NOTES_element();
            sapComDocumentCustomercontacts.ET_CCT_ATTR_element etcct = new sapComDocumentCustomercontacts.ET_CCT_ATTR_element();
            sapComDocumentCustomercontacts.BAPIRET2 bapiret= new sapComDocumentCustomercontacts.BAPIRET2();
            sapComDocumentCustomercontacts.BAPI_DISPUTE_SPLIT_NOTES bapi = new sapComDocumentCustomercontacts.BAPI_DISPUTE_SPLIT_NOTES();
            sapComDocumentCustomercontacts.BDM_CCT_REL bdmcct = new sapComDocumentCustomercontacts.BDM_CCT_REL();
            sapComDocumentCustomercontacts.ET_RELATIONS_element etrel = new sapComDocumentCustomercontacts.ET_RELATIONS_element();
            sapComDocumentCustomercontacts.IT_BRANCH_element itbr = new sapComDocumentCustomercontacts.IT_BRANCH_element();
        }
        mobileminiComEccCustomercontacts.HTTP_Port stub = new mobileminiComEccCustomercontacts.HTTP_Port();
        stub.inputHttpHeaders_x = new Map<String, String>();
        
        SAPWebserviceConnectionInfo.getWebserviceDetails();
        //Blob headerValue = Blob.valueOf(SAPWebserviceConnectionInfo.userName + ':' + SAPWebserviceConnectionInfo.password);
        Blob headerValue = Blob.valueOf('PIPREMOTE' + ':' + 'L3tm31n$$');
        String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
        
        //Setting a basic authentication header
        stub.inputHttpHeaders_x.put('Authorization', authorizationHeader);
        stub.timeout_x = 120000;
    
        sapComDocumentCustomercontacts.ZSD_GET_COLLECTION_NOTES_Response_element colNotesFullResEle = new sapComDocumentCustomercontacts.ZSD_GET_COLLECTION_NOTES_Response_element();
        sapComDocumentCustomercontacts.IT_CCT_GUID_element colNotesResEle = new sapComDocumentCustomercontacts.IT_CCT_GUID_element();
        
        try{
        
            colNotesFullResEle = stub.os_RequestCustomerContacts(null,null,null,segment,customer,null,sinceDate);
        
            if(colNotesFullResEle.ET_CCT_ATTR.item != null){
                
                List<sapComDocumentCustomercontacts.BDM_CCT> tempCollectorNotesDataList = colNotesFullResEle.ET_CCT_ATTR.item;
                //system.debug('====total notes===='+tempCollectorNotesDataList.size());
                
                for(sapComDocumentCustomercontacts.BDM_CCT colNote : tempCollectorNotesDataList){
                    
                    List<CollectorNotesCntrl.WrapperCollectorNotesItems> collectorNotesItemsWrapperList = new List<CollectorNotesCntrl.WrapperCollectorNotesItems>();
                    if(colNotesFullResEle.ET_NOTES.item != null){
                        List<sapComDocumentCustomercontacts.BAPI_DISPUTE_SPLIT_NOTES> collNotesItems = colNotesFullResEle.ET_NOTES.item;   
                        //system.debug('====total notes11111===='+collNotesItems.size());
                        for(sapComDocumentCustomercontacts.BAPI_DISPUTE_SPLIT_NOTES cni : collNotesItems){
                            if(String.valueof(cni.CASE_GUID) == colNote.CCT_GUID )
                               collectorNotesItemsWrapperList.add(new CollectorNotesCntrl.WrapperCollectorNotesItems(cni.CASE_GUID,cni.FORMAT_COL,cni.TEXT_LINE));
                        }
                    }
                    colNote.CCT_TYPE_TEXT = contactDirectionMap.get(string.valueOf(colNote.CCT_DIRECTION)) + ' ' + contactTypeMap.get(string.valueOf(colNote.CCT_TYPE));
                    colNote.CCT_RESULT_TXT = contactResultMap.get(string.valueOf(colNote.CCT_RESULT));
                    collectorNotesWrapperList.add(new CollectorNotesCntrl.WrapperCollectorNotes(colNote.CCT_GUID,colNote.CUSTOMER,colNote.COLL_SEGMENT,colNote.CCT_ID,colNote.COLL_SPECIALIST,
                            colNote.COLL_SPECIALIST_NAME,colNote.CONTACT_KEY,colNote.CCT_NAME,colNote.CCT_EMAIL,colNote.CCT_PHONE,colNote.CCT_FAX,colNote.CCT_FAXC,colNote.CCT_DIRECTION,
                            colNote.CCT_TYPE,colNote.CCT_TYPE_TEXT,colNote.CCT_RESULT,colNote.CCT_RESULT_TXT,colNote.CCT_TIME,colNote.CCT_DURATION,colNote.CREATED_BY,colNote.CREATED_BY_NAME,
                            colNote.CREATED_AT,colNote.CHANGED_BY,colNote.CHANGED_BY_NAME,colNote.CHANGED_AT,colNote.CCT_ATTCH_COUNT,collectorNotesItemsWrapperList,recType));                     
                    system.debug('------con type'+colNote.CCT_TYPE_TEXT);
                    system.debug('------res type'+colNote.CCT_RESULT_TXT);
                    system.debug('------time'+colNote.CCT_TIME);
                }
            }
        }
        catch(Exception e){
            return collectorNotesWrapperList;
        }
        return collectorNotesWrapperList;
    
    }
    
    
} //end of DataForcontracts