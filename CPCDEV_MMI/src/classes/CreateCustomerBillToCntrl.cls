Public class CreateCustomerBillToCntrl{
    
    public string billTo{get;set;}
    public string accID{get;set;}
    public Account currentAccount{get;set;}
    public boolean redirectAcc{get;set;}
    public string companyCode{get;set;}
    
    public CreateCustomerBillToCntrl(){
    
        redirectAcc = false;
        accID = ApexPages.currentPage().getParameters().get('accid');
        currentAccount = [SELECT ID,SAP_Bill_To__c,BillingCity,BillingCountry,BillingPostalCode,BillingState,BillingStreet,Name,Sales_Org__c,SAP_Sold_To__c FROM Account where ID=:accID];
        
        if('USA'.equalsignorecase(currentAccount.BillingCountry))
            currentAccount.BillingCountry = 'US';
        
        if('UNITED STATES'.equalsignorecase(currentAccount.BillingCountry))
            currentAccount.BillingCountry = 'US';
        
        if('CAN'.equalsignorecase(currentAccount.BillingCountry))
            currentAccount.BillingCountry = 'CA';
            
        currentAccount.Name = currentAccount.Name.replace('\'',''); 
        //currentAccount.BillingPostalCode  = currentAccount.BillingPostalCode.replace(' ','');
        companyCode = currentAccount.Sales_Org__c;
        
        if(currentAccount.Sales_Org__c == '1500' || currentAccount.Sales_Org__c == '1501')
            companyCode = '1000';    
        
       /* if(currentAccount.SAP_Bill_To__c == null || currentAccount.SAP_Bill_To__c == ''){
             if(Test.isRunningTest())
                makeCreateBillToCallout();  
        }else{
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '"SAP Bill To" number already exists for the customer.'));
             redirectAcc = false;
        }  */  
    }
    
    public void makeCreateBillToCallout(){
        
        /* ===>>>>>> Chaitanya START 9-11-2016 <<<<<=== */
          //CENTRAL_DATA
            if(currentAccount.SAP_Bill_To__c == null || currentAccount.SAP_Bill_To__c == ''){
                 sapComDocumentSapRfcFunctions3.CMDS_EI_CMD_CENTRAL cmd_DATA = new sapComDocumentSapRfcFunctions3.CMDS_EI_CMD_CENTRAL();
                  sapComDocumentSapRfcFunctions3.CMDS_EI_VMD_CENTRAL_DATA vmd_DATA = new sapComDocumentSapRfcFunctions3.CMDS_EI_VMD_CENTRAL_DATA();
                  vmd_DATA.KTOKD = 'ZDOT';
                  cmd_DATA.Data = vmd_DATA;         
                  sapComDocumentSapRfcFunctions3.CVIS_EI_ADDRESS1 address = new sapComDocumentSapRfcFunctions3.CVIS_EI_ADDRESS1();  
                  sapComDocumentSapRfcFunctions3.CVIS_EI_1VL VL = new sapComDocumentSapRfcFunctions3.CVIS_EI_1VL();
                  sapComDocumentSapRfcFunctions3.BAPIAD1VL  AD1VL = new sapComDocumentSapRfcFunctions3.BAPIAD1VL();  
                  AD1VL.NAME = currentAccount.Name;
                  AD1VL.CITY = currentAccount.BillingCity;
                  AD1VL.POSTL_COD1  = currentAccount.BillingPostalCode;
                  AD1VL.STREET = currentAccount.BillingStreet;
                  AD1VL.HOUSE_NO = '';
                  AD1VL.COUNTRY = currentAccount.BillingCountry;
                  AD1VL.LANGU = 'EN';
                  AD1VL.REGION = currentAccount.BillingState;
                  AD1VL.SORT1 = 'Search-002';
                  AD1VL.SORT2 = 'Search-003';
                  VL.DATA = AD1VL;
                  address.TASK = 'I';
                  address.POSTAL = VL;
                  sapComDocumentSapRfcFunctions3.CVIS_EI_CVIS_TEXT text = new sapComDocumentSapRfcFunctions3.CVIS_EI_CVIS_TEXT();
                    sapComDocumentSapRfcFunctions3.CVIS_EI_TEXT_T ei_Text = new sapComDocumentSapRfcFunctions3.CVIS_EI_TEXT_T();  
                       sapComDocumentSapRfcFunctions3.CVIS_EI_TEXT ei_Text1 = new sapComDocumentSapRfcFunctions3.CVIS_EI_TEXT();     
                          sapComDocumentSapRfcFunctions3.CVIS_EI_LONGTEXT_DATA_KEY data_KEY = new sapComDocumentSapRfcFunctions3.CVIS_EI_LONGTEXT_DATA_KEY();        
                                ei_Text1.TASK = 'I';
                                data_KEY.TEXT_ID = ''; 
                                ei_Text1.DATA_KEY = data_KEY;        
                  sapComDocumentSapRfcFunctions3.CVIS_EI_VAT_NUMBERS vatNumber = new sapComDocumentSapRfcFunctions3.CVIS_EI_VAT_NUMBERS();
                  sapComDocumentSapRfcFunctions3.CMDS_EI_CMD_TAX tax = new sapComDocumentSapRfcFunctions3.CMDS_EI_CMD_TAX();
                  sapComDocumentSapRfcFunctions3.CMDS_EI_CMD_TAX_IND taxIND = new sapComDocumentSapRfcFunctions3.CMDS_EI_CMD_TAX_IND();
                  sapComDocumentSapRfcFunctions3.CMDS_EI_CMD_EXPORT exportCMD = new sapComDocumentSapRfcFunctions3.CMDS_EI_CMD_EXPORT();
                  sapComDocumentSapRfcFunctions3.CMDS_EI_CMD_LOADING LOADING = new sapComDocumentSapRfcFunctions3.CMDS_EI_CMD_LOADING();
                  sapComDocumentSapRfcFunctions3.CMDS_EI_CENTRAL_DATA  CENTRAL_DATA = new sapComDocumentSapRfcFunctions3.CMDS_EI_CENTRAL_DATA();
                  CENTRAL_DATA.CENTRAL = cmd_DATA;
                  CENTRAL_DATA.ADDRESS = address;
                  CENTRAL_DATA.TEXT = text;
          //COMPANY_Data
                   sapComDocumentSapRfcFunctions3.CMDS_EI_CMD_COMPANY COMPANY_DATA = new sapComDocumentSapRfcFunctions3.CMDS_EI_CMD_COMPANY();
                   sapComDocumentSapRfcFunctions3.CMDS_EI_COMPANY_T COMPANY_T = new sapComDocumentSapRfcFunctions3.CMDS_EI_COMPANY_T();  
                     List<sapComDocumentSapRfcFunctions3.CMDS_EI_COMPANY> EI_COMPANY_LIST = new List<sapComDocumentSapRfcFunctions3.CMDS_EI_COMPANY>();   
                        sapComDocumentSapRfcFunctions3.CMDS_EI_COMPANY EI_COMPANY = new sapComDocumentSapRfcFunctions3.CMDS_EI_COMPANY();
                        sapComDocumentSapRfcFunctions3.CMDS_EI_COMPANY_KEY COMPANY_DATA_KEY = new sapComDocumentSapRfcFunctions3.CMDS_EI_COMPANY_KEY();
                            COMPANY_DATA.CURRENT_STATE = currentAccount.BillingState;
                            COMPANY_DATA.COMPANY = COMPANY_T;
                            COMPANY_DATA_KEY.BUKRS = companyCode;
                            EI_COMPANY.TASK = 'I';
                            EI_COMPANY.DATA_KEY = COMPANY_DATA_KEY;
                            EI_COMPANY_LIST.add(EI_COMPANY);
                            COMPANY_T.item = EI_COMPANY_LIST;
          //I_Header_Data 
                  sapComDocumentSapRfcFunctions3.CMDS_EI_HEADER I_HEADER = new sapComDocumentSapRfcFunctions3.CMDS_EI_HEADER();
                  I_HEADER.OBJECT_TASK = 'I';
          //SALES_DATA 
                  sapComDocumentSapRfcFunctions3.CMDS_EI_CMD_SALES SALES_DATA = new sapComDocumentSapRfcFunctions3.CMDS_EI_CMD_SALES();
                  SALES_DATA.CURRENT_STATE = currentAccount.BillingState;
                    sapComDocumentSapRfcFunctions3.CMDS_EI_SALES_T  EI_SALES_T = new sapComDocumentSapRfcFunctions3.CMDS_EI_SALES_T();
                      List<sapComDocumentSapRfcFunctions3.CMDS_EI_SALES>  CMDS_EI_SALES_List = new List<sapComDocumentSapRfcFunctions3.CMDS_EI_SALES>();
                        sapComDocumentSapRfcFunctions3.CMDS_EI_SALES  CMDS_EI_SALES = NEW sapComDocumentSapRfcFunctions3.CMDS_EI_SALES();
                            CMDS_EI_SALES.TASK = 'I';
                                sapComDocumentSapRfcFunctions3.CMDS_EI_SALES_KEY EI_SALES_KEY = NEW sapComDocumentSapRfcFunctions3.CMDS_EI_SALES_KEY();       EI_SALES_KEY.VKORG = currentAccount.Sales_Org__c;
                                    EI_SALES_KEY.VTWEG = '10';
                                    EI_SALES_KEY.SPART = '10';                         
                            CMDS_EI_SALES.DATA_KEY = EI_SALES_KEY;
                            CMDS_EI_SALES_List.add(CMDS_EI_SALES);
                                sapComDocumentSapRfcFunctions3.CMDS_EI_CMD_FUNCTIONS  EI_CMD_FUNCTIONS = NEW sapComDocumentSapRfcFunctions3.CMDS_EI_CMD_FUNCTIONS();
                                    sapComDocumentSapRfcFunctions3.CMDS_EI_FUNCTIONS_T  EI_FUNCTIONS_T = NEW sapComDocumentSapRfcFunctions3.CMDS_EI_FUNCTIONS_T();
                                       List<sapComDocumentSapRfcFunctions3.CMDS_EI_FUNCTIONS> EI_FUNCTIONS_List = new List<sapComDocumentSapRfcFunctions3.CMDS_EI_FUNCTIONS>();
                                          sapComDocumentSapRfcFunctions3.CMDS_EI_FUNCTIONS EI_FUN = NEW sapComDocumentSapRfcFunctions3.CMDS_EI_FUNCTIONS();
                                              EI_FUN.TASK = 'I';
                                                sapComDocumentSapRfcFunctions3.CMDS_EI_FUNCTIONS_KEY DATA_KEY_fun = NEW sapComDocumentSapRfcFunctions3.CMDS_EI_FUNCTIONS_KEY();
                                                  DATA_KEY_fun.PARVW = 'ZS';
                                                  DATA_KEY_fun.PARZA = '001';   
                                              EI_FUN.DATA_KEY = DATA_KEY_fun;
                                                sapComDocumentSapRfcFunctions3.CMDS_EI_FUNCTIONS_DATA EI_FUN_DATA = new sapComDocumentSapRfcFunctions3.CMDS_EI_FUNCTIONS_DATA();
                                                    EI_FUN_DATA.PARTNER = currentAccount.SAP_Sold_To__c;
                                              EI_FUN.DATA = EI_FUN_DATA;
                                       EI_FUNCTIONS_List.add(EI_FUN);
                                    EI_FUNCTIONS_T.item = EI_FUNCTIONS_List;
                                EI_CMD_FUNCTIONS.FUNCTIONS = EI_FUNCTIONS_T;
                           CMDS_EI_SALES.FUNCTIONS = EI_CMD_FUNCTIONS;                 
                     EI_SALES_T.item = CMDS_EI_SALES_List;
                   SALES_DATA.SALES = EI_SALES_T;
           //Passing the parameters to Web Service method
                    mobileminiComEccMaintaincustomer.HTTP_Port mmi = new mobileminiComEccMaintaincustomer.HTTP_Port();           
                    //Blob headerValue_1 = Blob.valueOf('data_int' + ':' + 'Letm3in!');
                    Blob headerValue_1 = Blob.valueOf('pipremote' + ':' + 'L3tm31n$$');
                    String authorizationHeader_1 = 'Basic ' + EncodingUtil.base64Encode(headerValue_1);
                    Map<string,string> input_1 = new Map<string,string>();
                    input_1.put('Authorization',authorizationHeader_1);
                    mmi.inputHttpHeaders_x = input_1; 
           //Capturing the response
                  sapComDocumentSapRfcFunctions3.E_RETURN_element e_return = new sapComDocumentSapRfcFunctions3.E_RETURN_element();    
                  List<sapComDocumentSapRfcFunctions3.BAPIRET2> bp_List = new List<sapComDocumentSapRfcFunctions3.BAPIRET2>();
                  sapComDocumentSapRfcFunctions3.BAPIRET2 bp = new sapComDocumentSapRfcFunctions3.BAPIRET2();
                  bp_List.add(bp);          
                  e_return.item = bp_List;
                    system.debug('CENTRAL_DATA====>>>>>>'+CENTRAL_DATA);
                    system.debug('COMPANY_DATA====>>>>>>'+COMPANY_DATA);
                    system.debug('I_HEADER====>>>>>>'+I_HEADER);
                    system.debug('SALES_DATA====>>>>>>'+SALES_DATA);
                  e_return = mmi.os_Maintain_Customer(CENTRAL_DATA,COMPANY_DATA,I_HEADER,SALES_DATA);
                  system.debug('e_return====>>>>>>'+e_return);         
                  system.debug('e_return.MESSAGE_V1====>>>>>>'+e_return.item[0].MESSAGE_V1);
           //Updating the SAP BILL TO field in Account object
                   if(e_return.item[0].TYPE_x == 'S'){            
                        Account objAccount = new Account();
                        objAccount.ID = currentAccount.ID;
                        objAccount.SAP_Bill_To__c = e_return.item[0].MESSAGE_V1;
                       if(!Test.isRunningTest()){
                           update objAccount;
                       }
                        
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,e_return.item[0].MESSAGE + '. You will be redirected to Account detail page'));
                   }else{
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e_return.item[0].MESSAGE + '. You will be redirected to Account detail page'));
                   } 
            }else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '"SAP Bill To" number already exists for the customer.'));
                redirectAcc = True;
            } 
            
        /* ===>>>>>> Chaitanya END 9-11-2016 <<<<<=== */       
              
        /* ===>>>>>> Commented by Chaitanya START 10-11-2016 <<<<<=== */    
             /* HTTP htp = new HTTP();
                httpRequest req = new httpRequest();
                Blob headerValue = Blob.valueOf('data_int' + ':' + 'Letm3in!');
                String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
                req.setHeader('Authorization',authorizationHeader);
                req.setHeader('mediaType','application/json');
                req.setEndPoint('http://vpipiddb.mobilemini.com:50000/RESTAdapter/REST_Sen_MaintainCustomer/ecc/customermaintenance');
                req.setMethod('POST');
                req.setBody('{"I_CENTRAL_DATA": { "CENTRAL": { "DATA": { "KTOKD": "ZDOT" } },"ADDRESS": {"TASK": "I","POSTAL": {"DATA": {"NAME": "' +currentAccount.Name + '","CITY": "' + currentAccount.BillingCity + '","POSTL_COD1": "' + currentAccount.BillingPostalCode + '","STREET": "' + currentAccount.BillingStreet + '","HOUSE_NO": "","COUNTRY": "' + currentAccount.BillingCountry + '","LANGU": "EN","REGION": "' + currentAccount.BillingState + '","SORT1": "Search-002","SORT2": "Search-003"}}},},"I_COMPANY_DATA": {"COMPANY": {"item": {"TASK": "I","DATA_KEY": { "BUKRS": "' + companyCode + '" }}}},"I_HEADER": { "OBJECT_TASK": "I" },"I_SALES_DATA": {"SALES": {"item": {"TASK": "I","DATA_KEY": {"VKORG": "' + currentAccount.Sales_Org__c + '","VTWEG": "10","SPART": "10"},"FUNCTIONS": {"FUNCTIONS": {"item": {"TASK": "I","DATA_KEY": {"PARVW": "ZS","PARZA": "001"},"DATA": {"PARTNER": "' + currentAccount.SAP_Sold_To__c + '"}}}},}}}}}');
                
                String resString;
                if(!Test.isRunningTest()){
                    httpResponse res = htp.send(req);
                    resString = res.getBody();
                }
                
                if(Test.isRunningTest()){
                    resString = '{"ZSD_MAINTAIN_CUSTOMER_CPQ.Response":{"E_RETURN":{"item":{"TYPE": "S","ID": "ZSD","NUMBER": "001","MESSAGE": "Customer 0000120232 Created/Changed","LOG_NO": "","LOG_MSG_NO": "000000","MESSAGE_V1": "0000120232","MESSAGE_V2": "","MESSAGE_V3": "","MESSAGE_V4": "","PARAMETER": "","ROW": 0,"FIELD": "","SYSTEM": ""}}}}';
                } 
                */
        /* ===>>>>>> Commented by Chaitanya END 10-11-2016 <<<<<=== */ 
        /*
        Integer startPos = resString.indexOf(':');
        resString = resString.subString(startPos+1, resString.length()-1);
        
        //startPos = resString.indexOf(':');
        //resString = resString.subString(startPos+1, resString.length()-1);
        
        system.debug('===res sdfs===' +resString);
        
        ResponseEleWrapper billToRes = (ResponseEleWrapper)JSON.deserialize(resString,ResponseEleWrapper.class);
        system.debug('===res==='+billToRes );
        //CreateBillToResponseWrapper resBT =  new CreateBillToResponseWrapper();
        //resBT = billToRes.resEle;
        */       
        /* ===>>>>>> Commented by Chaitanya START 10-11-2016 <<<<<=== */ 
              /*  CreateBillToResponseWrapper resBT =  new CreateBillToResponseWrapper();
                JSONParser parser = JSON.createParser(resString);
                while (parser.nextToken() != null) {
                    
                    if ( (parser.getCurrentName() == 'TYPE') )
                        resBT.type_x =  parser.getText();           
                    
                    else if ( (parser.getCurrentName() == 'ID') )
                        resBT.id_x =  parser.getText();           
                    
                    else if ( (parser.getCurrentName() == 'NUMBER') )
                        resBT.number_x =  parser.getText();                   
                    
                    else if ( (parser.getCurrentName() == 'MESSAGE') )
                        resBT.message =  parser.getText();           
                        
                    else if ( (parser.getCurrentName() == 'LOG_NO') )
                        resBT.log_no =  parser.getText();               
                       
                    else if ( (parser.getCurrentName() == 'LOG_MSG_NO') )
                        resBT.log_msg_no =  parser.getText();              
                       
                    else if ( (parser.getCurrentName() == 'MESSAGE_V1') )
                        resBT.message_v1 =  parser.getText();           
                        
                    else if ( (parser.getCurrentName() == 'MESSAGE_V2') )
                        resBT.message_v2 =  parser.getText();               
                        
                    else if ( (parser.getCurrentName() == 'MESSAGE_V3') )
                        resBT.message_v3 =  parser.getText();           
                    
                    else if ( (parser.getCurrentName() == 'MESSAGE_V4') )
                        resBT.message_v4 =  parser.getText();           
                    
                    else if ( (parser.getCurrentName() == 'PARAMETER') )
                        resBT.parameter =  parser.getText(); 
                        
                    else if ( (parser.getCurrentName() == 'ROW') )
                        resBT.row =  parser.getText();
                        
                    else if ( (parser.getCurrentName() == 'FIELD') )
                        resBT.field =  parser.getText();
                        
                    else if ( (parser.getCurrentName() == 'SYSTEM') )
                        resBT.system_x =  parser.getText();
                        
                                                  
                    parser.nextToken();
                }
               
                if(resBT.type_x == 'S'){
                    
                    billTo = resBT.MESSAGE_V1;
                    
                    Account acc = new Account();
                    acc.ID = currentAccount.ID;
                    acc.SAP_Bill_To__c = billTo;
                    update acc;
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,resBT.message + '. You will be redirected to Account detail page'));
                }
                else
                {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,resBT.message + '. You will be redirected to Account detail page'));
                    
                } */
        /* ===>>>>>> Commented by Chaitanya END 10-11-2016 <<<<<=== */ 
        
    }
    
    public void redirectAccount(){
        redirectAcc = true;
        //Integer start = System.Now().millisecond();
        //while(System.Now().millisecond() < start+300){ }
        for(Integer i=0;i<1000000;i++){}
    }
    
    /*
    public Class ResponseEleWrapper{
    
        public List<CreateBillToResponseWrapper> records{get;set;}
    
        public ResponseEleWrapper(){}
    
    }
    */
    /*public class CreateBillToResponseWrapper{
    
        public string type_x{get;set;}
        public string id_x{get;set;}
        public string number_x{get;set;}
        public string message{get;set;}
        public string log_no{get;set;}
        public string log_msg_no{get;set;}
        public string message_v1{get;set;}
        public string message_v2{get;set;}
        public string message_v3{get;set;}
        public string message_v4{get;set;}
        public string parameter{get;set;}
        public string row{get;set;}
        public string field{get;set;}
        public string system_x{get;set;}
        
        public CreateBillToResponseWrapper(){}
        
    } */
    
}