public class InvoiceSearchController {

    public String invoiceNumber {get;set;}
    public String caseOwner {get;set;}
    public Account accVar{get; set;}
    public Service_Order_Request__c SORVar{get;set;}
    public list<SelectOption> branchIDPickList {get; set;}
    public list<SelectOption> reasonForCreditPickList {get; set;}
    public list<SelectOption> invNumbersPickList{get;set;}
    public String accountName {get;set;}
    public String AccName{ get;set; }
    public Id AccId{get;set;}
    public List<WrapperInvoiceHistory> invHistoryList;
    public Id caseID{get;set;}
    public String billFromDate{get;set;}
    public String billToDate{get;set;}
    public List<SelectOption> invoiceStatusPickList{get;set;}
    public List<SelectOption> invoiceNumberPicklist{get;set;}
    public String selectedInvoiceStatus{get;set;}
    public String selectedNumOfRecords{get;set;}
    public String ContactNumber{get;set;}
    public String invNumbers{get;set;}
    public boolean displayPopup {get;set;}
    public boolean displayInvList {get;set;}
    public boolean displayInvText{get;set;}
    public String selectedInvoice{get;set;}
    public String invoiceText{get;set;}
    public Set<String> invHistorySet{get;set;} 
    public List<WrapperLineItems> lineItemsList {get;set;}
    public WrapperInvoiceHeader invoiceHeader {get;set;}
    public List<WrapperLineItemPricing> linePricingList {get;set;}
    public String INVOICE_NUMBER{get;set;}
    public String INVOICE_DATE{get;set;}
    public String TERMS_CODE{get;set;}
    public String SALES_ORG{get;set;}
    public String DISTR_CHAN{get;set;}
    public String INVOICE_AMOUNT{get;set;}
    public String CURRENCY_x{get;set;}
    public String PAYING_CUSTOMER{get;set;}
    public String SOLD_TO_CUSTOMER{get;set;}
    public String SHIP2_CUSTOMER{get;set;} 
    public String CONTRACT{get;set;}
    public String DOC_CATEG{get;set;}
    public string CONDITIONAL_VALUE{get;set;}
    public boolean showLinePricing {get;set;}
    public boolean displayCreditArea{get;set;}
    public boolean displayinvoiceSearch{get;set;}
    public Id recordTypeId{get;set;}
    public boolean displayCreditMMI{get;set;}
    public boolean displayCreditETS{get;set;}
    public boolean displayCreditWMI{get;set;}
    public boolean displayGeneralCredit{get;set;} 
    public Decimal gcCreditAmount{get;set;}
    public Map<String,String> reasonForCreditCharCodeMap;
    
    public list<Contact> lstContact {get;set;}
    public boolean displayContactPopUp{get;set;}
    public string selectedContactName {get;set;}
    public boolean displayCreateContact {get;set;}
    public String conFn {get;set;}
    public String conLn {get;set;}
    public String conPh {get;set;}
    public String conMob {get;set;}
    public String conEmail {get;set;}
    public String conFax{get;set;}
    public Boolean isFromNewContact {get;set;}
    public Boolean IsContactPresent {get;set;}
    public String newConId;
    public String selectedPh; 
    public String selectedConId2;
    public Boolean alertMsg{get;set;}
    list<RecordType> CredRecTypes;
    
    public InvoiceSearchController(){

      
        System.debug('displayCreditMMI .....'+displayCreditMMI);
        AccName= ApexPages.currentPage().getParameters().get('accName');
        AccId= ApexPages.currentPage().getParameters().get('accId');
        caseOwner = [Select Id,Name from User where Id=:userinfo.getuserId()].Name;
        displayCreateContact = false;
        newConId = '';
        selectedPh = '';
        selectedConId2 = '';        
        isFromNewContact = false;
        IsContactPresent = false;
        
        displayCreditMMI = true;  displayCreditETS = false;
        displayCreditWMI = false; displayGeneralCredit = false;  
        
       SORVar = new Service_Order_Request__c();
       if(!test.isRunningtest()){
           getReasonForCreditPickList();
       }
       
       //related contacts
       displayContactPopUp = false;
       lstContact = new list < Contact > ();
       lstContact = [select Id, Name, firstname, lastname, Phone, MobilePhone, Email, Fax from Contact where AccountId = :AccId];
       
       branchIDPickList = new list<SelectOption>();
       //reasonForCreditPickList  = new list<SelectOption>(); 
       Schema.DescribeFieldResult branchIDList = Service_Order_Request__c.Branch_ID__c.getDescribe();
       //Schema.DescribeFieldResult reasonForCreditList  = Service_Order_Request__c.Reason_for_Credit__c.getDescribe();
      //Id CredMMIRecTypeId = [SELECT id,Name, DeveloperName FROM RecordType WHERE isActive = true AND (sObjectType = 'Service_Order_Request__c' AND DeveloperName = 'Credits_MMI')].Id;
      //Id CredMMIRecTypeId = [SELECT id,Name, DeveloperName FROM RecordType WHERE isActive = true AND (sObjectType = 'Service_Order_Request__c' AND DeveloperName = 'SAP_Credits_MMI')].Id;  
       CredRecTypes = [SELECT id,Name, DeveloperName FROM RecordType WHERE isActive = true AND (sObjectType = 'Service_Order_Request__c') AND DeveloperName in ('SAP_Credits_MMI','SAP_Credits_ETS','SAP_Credits_WMI')];
        recordTypeId = ApexPages.currentPage().getParameters().get('RecordType');
        for(RecordType rt : CredRecTypes){ 
          if(rt.DeveloperName == 'SAP_Credits_MMI' && rt.Id == recordTypeId){
            displayCreditMMI = true;
            displayCreditETS = false;
            displayCreditWMI = false;
            displayGeneralCredit = false;            
          }else if(rt.DeveloperName == 'SAP_Credits_ETS' && rt.Id == recordTypeId){
            displayCreditMMI = false;
            displayCreditETS = true;
            displayCreditWMI = false;
            displayGeneralCredit = false; 
          }else if(rt.DeveloperName == 'SAP_Credits_WMI' && rt.Id == recordTypeId){
            displayCreditMMI = false;
            displayCreditETS = false;
            displayCreditWMI = true;
            displayGeneralCredit = false;
          }        
       }
        /*if(CredMMIRecTypeId == recordTypeId){
            displayCreditMMI = true;
            displayGeneralCredit = false;
        }else{
            displayCreditMMI = false;
            displayGeneralCredit = true;
        }*/
       for (Schema.Picklistentry picklistEntry : branchIDList.getPicklistValues())
        {
            branchIDPickList.add(new SelectOption(pickListEntry.getValue(),pickListEntry.getLabel()));
        }
           
         /*  reasonForCreditPickList.add(new selectOption('','---None---'));
       for (Schema.Picklistentry picklistEntry : reasonForCreditList.getPicklistValues())
        {
            reasonForCreditPickList.add(new SelectOption(pickListEntry.getValue(),pickListEntry.getLabel()));
        }*/
        
        SORVar.Account_Name__c = AccId;
       //SORVar.Account_ID__c = AccId; // new change
        
        
        if(displayCreditMMI || displayCreditETS || displayCreditWMI){
               displayPopup = false;
               displayInvList  = false;
               displayInvText = true;
               showLinePricing = false;
              displayCreditArea = false;
               displayinvoiceSearch = true;
               
               String fromDate = string.valueOf(system.today().addyears(-1)).replace('-','');
               String toDate = string.valueOf(system.today()).replace('-','');
                              
               if(!test.isrunningtest()) {
                //getInvoiceHistory(AccId,AccName,null,null,null,null,null,true,null);
                getInvoiceHistory(AccId,AccName,fromDate,toDate,null,'999',null,true,null);
                }
                
                List<String> invoiceStatusContent = new List<String>();
                invoiceStatusContent.add('Open');
                invoiceStatusContent.add('All');
                invoiceStatusPickList = new List<selectOption>();
                invoiceStatusPickList.add(new selectOption('','---None---'));
                for(String invStatusVar : invoiceStatusContent){
                         invoiceStatusPickList.add(new selectOption(invStatusVar,invStatusVar));
                     }
                
                invoiceNumberPickList = new List<selectOption>();
                invoiceNumberPickList.add(new selectOption('','---None---'));
                invoiceNumberPicklist.add(new selectOption('10','10'));
                invoiceNumberPicklist.add(new selectOption('20','20'));
                invoiceNumberPicklist.add(new selectOption('30','30'));
                invoiceNumberPicklist.add(new selectOption('40','40'));
                invoiceNumberPicklist.add(new selectOption('50','50'));
                      
                   if(String.isNotBlank(ApexPages.currentPage().getParameters().get('invoicenum'))) {
                       invoiceText = ApexPages.currentPage().getParameters().get('invoicenum');
                      
                       lineItemsList = new List<WrapperLineItems>();
                       linePricingList = new List<WrapperLineItemPricing>();
                      /* invoiceHeader = getInvoiceDetails(invoiceNumber);
                       lineItemsList = invoiceHeader.lineItemList;
                       displayHeaderLineItem(invoiceHeader);  */     
                  } 
            }  
      }


    public pageReference getReasonForCreditPickList(){
        Blob headerValue = Blob.valueOf('PIPREMOTE'+':'+'L3tm31n$$');
        //Blob headerValue = Blob.valueOf('Data_int'+':'+'Letm3in!');
        string authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
       // try{ 
        httpRequest req = new HttpRequest();
        req.setHeader('Authorization',authorizationHeader);
        req.setHeader('mediaType','application/json');
       req.setEndpoint('http://vpipipdb.mobilemini.com:50000/RESTAdapter/GetSeedData');
       //req.setEndpoint('http://vpipiqdb.mobilemini.com:50000/RESTAdapter/GetSeedData');
        req.setMethod('POST');
        req.setBody('{"Domain": "TRANSACTION_TYPE",}');
        System.debug('before req...');
        Http hp = new Http();
        HttpResponse res = hp.send(req);
       reasonForCreditCharCodeMap = new Map<String,String>();
            List<DomainOrderReason> orderReasonList = new  List<DomainOrderReason>();
            System.debug('res.getBody()......'+res.getBody());
             String s = res.getBody();
             if(String.isNotBlank(s) &&  s != '""'){
                  String s1 = '';
                 if(!test.isRunningTest()){
                     Integer startPos = s.indexOf(':');
                     s1 = s.subString(startPos+1, s.length()-1);
                 }else{
                     s1 = s;
                 }
                 System.debug('clean string...'+s1);
                 Type resultType = Type.forName('DomainWrapper');
                  System.debug('after req...'+res);
                  
               DomainWrapper domVar = (DomainWrapper) JSON.deserialize(s1,DomainWrapper.class);
               System.debug('domVar ....'+domVar);
                 orderReasonList = domVar.Records;
                 System.debug('domVar.domainList......'+domVar.Records);
                 System.debug('orderReasonList .....'+orderReasonList );
                         for(DomainOrderReason DORVar : orderReasonList){
                            if(DORVar.ParentDomainID == 1000 || DORVar.ParentDomainID == 1100){
                               reasonForCreditCharCodeMap.put(DORVar.DomainDescription , DORVar.DomainID); 
                            }
                         }
              reasonForCreditPickList = new List<SelectOption>();
            system.debug('--- resMap ----'+ reasonForCreditCharCodeMap);
            reasonForCreditPickList.add(new selectOption('','---None---'));
            for(String Reason : reasonForCreditCharCodeMap.keySet()){
                reasonForCreditPickList.add(new SelectOption(Reason,Reason));
            }
            //system.debug('--- res.getBody() ----'+ res.getBody());   
       } else{
               reasonForCreditPickList = new List<SelectOption>();
            
            reasonForCreditPickList.add(new selectOption('','---None---'));
          // ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No values for Reason for Credit !'));
              // return null;
       
       }   
       /* }catch(exception exe){
          system.debug('---- exe -----' + exe); 
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,exe.getMessage()));
               return null;
        }*/
        return null;
    }
   
   
    public pageReference getInvoiceHistory(Id AccId,String AccName,String billFromDateToSend,String billToDateToSend,String selectedInvoiceStatus,String selectedNumOfRecords,String ContractNumber,boolean onload,String Err){
        List<WrapperInvoiceHistory> invHistoryWrapperList;
        Set<WrapperInvoiceHistory> invHistoryWrapperSet;
        Id  AccId2= ApexPages.currentPage().getParameters().get('accId');
        Account accVar = [SELECT ID,SAP_Bill_To__c FROM Account where ID = :AccId2];
        String SAPBillTo = accVar.SAP_Bill_To__c;
        String IFLAG = null;
        Integer numOfRec = (selectedNumOfRecords == '' || selectedNumOfRecords == null) ? 0 : Integer.valueOf(selectedNumOfRecords);
        String ErrorMsg ='';
        
       
          if(String.isNotBlank(Err)){
                 ErrorMsg += Err;
            }
          if(String.isNotBlank(ErrorMsg)){
                  displayPopup = true;
                  ErrorMsg = ErrorMsg.substring(0,ErrorMsg.length()-5);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,ErrorMsg));
                return null;
            
            }
        
        
        if(selectedInvoiceStatus == 'Open'){
            IFLAG = 'X';
        }
        if(SAPBillTo != null || SAPBillTo != ''){
            mobileminiComEccInvoicehistory.HTTP_Port stub = new mobileminiComEccInvoicehistory.HTTP_Port(); 
            stub.inputHttpHeaders_x = new Map<String, String>();
            Blob headerValue = Blob.valueOf('PIPREMOTE' + ':' + 'L3tm31n$$');
            //Blob headerValue = Blob.valueOf('data_int' + ':' + 'Letm3in!');
            String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
            stub.inputHttpHeaders_x.put('Authorization', authorizationHeader);
            stub.timeout_x = 120000;
            sapComDocumentSapRfcInvoiceHistory.ZSDF_INVOICE_HISTORY_Response_element invHistoryResp = stub.os_Invoice_History(billFromDateToSend,billToDateToSend,ContractNumber,IFLAG,SAPBillTo,numOfRec,null,null);
             
              if(invHistoryResp.ET_INVOICE.item != null){
                             invHistoryWrapperList = new List<WrapperInvoiceHistory>();
                             invHistoryWrapperSet = new Set<WrapperInvoiceHistory>();
                             for(sapComDocumentSapRfcInvoiceHistory.ZSD_INVOICE_HISTORY respinvHistory : invHistoryResp.ET_INVOICE.item){
                                 WrapperInvoiceHistory invHistoryVar = new WrapperInvoiceHistory();
                                 invHistoryVar.InvoiceNumber = respinvHistory.VBELN;
                                 invHistoryWrapperList.add(invHistoryVar);
                            } 
              }else if(invHistoryResp.ET_RETURN.item != null){
                    for(sapComDocumentSapRfcInvoiceHistory.BAPIRET2 respErrMsg : invHistoryResp.ET_RETURN.item){
                          
                          if(respErrMsg.MESSAGE.contains('Invalid Contract')){
                                 
                                ErrorMsg += 'Please enter valid Contract Number !!<br/>';
                          }else{
                                 ErrorMsg += respErrMsg.MESSAGE+'<br/>';
                          }
                    } 
              }
        }
        if(!onload){
        
            Double billFromDateToCmpr = 0.00;
          
            Double billToDateToCmpr = 0.00;
           
            if(String.isEmpty(selectedInvoiceStatus)){
                ErrorMsg += 'Please select Invoice Status !!<br/>';
            }
            
            if(String.isEmpty(selectedNumOfRecords)){
               ErrorMsg += 'Please select number of invoices to display !! <br/>';
            }
            
            if(String.isNotBlank(billFromDate) ){
                
                 Double todayDt = Double.valueOf(String.valueOf(Date.today()).replace('-',''));
               
                 billFromDateToCmpr = Double.valueOf(billFromDate);
                 if(billFromDateToCmpr > todayDt){
                    ErrorMsg += 'Bill From Date cannot be a future date !!<br/>';
                 }
            }
            if(String.isNotBlank(billFromDate)  && String.isNotBlank(billToDate)){
                billFromDateToCmpr = Double.valueOf(billFromDate.replace('/',''));
                billToDateToCmpr = Double.valueOf(billToDate.replace('/',''));
                if( billFromDateToCmpr > billToDateToCmpr ){
                    ErrorMsg += 'Bill From Date cannot be greater than Bill To Date !!<br/>';
                }
            }
            
           
      }  
          
          if(String.isNotBlank(ErrorMsg)){
                  displayPopup = true;
                  ErrorMsg = ErrorMsg.substring(0,ErrorMsg.length()-5);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,ErrorMsg));
                return null;
            
            }
            
          if(invHistoryWrapperList != null){
                displayPopup = false;
                invHistorySet = new Set<String>();
                for(WrapperInvoiceHistory invHistoryVar : invHistoryWrapperList){
                     invHistorySet.add(invHistoryVar.InvoiceNumber);
                    
                 }
                 
                invNumbersPickList = new List<selectOption>();
                invNumbersPickList.add(new selectOption('','---None---'));
                invNumbers = '';
                 for(String invHistoryVar : invHistorySet){
                     invNumbersPickList.add(new selectOption(invHistoryVar,invHistoryVar));
                      invNumbers += invHistoryVar+';';
                 }
                 if(!onload){
                      displayInvList  = true;
                      displayInvText = false;
                  }
                      
             }
        return null; 
    }


    public PageReference showsearchPopup(){
        displayPopup = true;
        return null;
        
    }
    
    public PageReference closePopup(){
        displayPopup = false;
        return null;
        
    }
    
    public PageReference showContactPopup(){
        displayContactPopUp = true;
        return null;
        
    }
    
    public PageReference closeContactPopup(){
        displayContactPopUp = false;
        return null;
        
    }
    
    public PageReference selectedContact(){
        displayContactPopUp = false;
        //String selectedConId = System.currentPageReference().getParameters().get('hiddenContact');
        //string selectedConId = Apexpages.currentPage().getParameters().get('con');
        //Contact con = [select id,name from contact where id= :selectedConId];
        //SORVar.Customer_Contact__c =  con.id ;
        //selectedContactName = con.name;
        return null;
    }
    public PageReference setSORContact(){
        //String selectedConId = System.currentPageReference().getParameters().get('hiddenContact');
        string selectedConId = Apexpages.currentPage().getParameters().get('con');
        List<Contact> conList = [select id,name from contact where id= :selectedConId LIMIT 1];
         if(!conList.isEmpty()){
          contact con = conList[0];
          SORVar.Customer_Contact__c = con.id ;
          selectedContactName = con.name;
         }
        return null;
    }

    public pageReference retrieveInvoiceList(){
         String Err='';
        
        if(!String.isNotBlank(billFromDate) && !String.isNotBlank(billToDate))
          alertMsg = true;
          
        if(String.isNotBlank(billFromDate)){
          
           list<String> billFromDatelist = billFromDate.split('/');
           Integer len = billFromDatelist.size();
           if(billFromDatelist[len - len].length() != 2)
                billFromDatelist[len - len] = '0'+billFromDatelist[len - len];
            if(billFromDatelist[len-2].length() != 2)
                billFromDatelist[len-2] = '0'+billFromDatelist[len-2];
            if(billFromDatelist[len-1].length() != 4)
                Err ='Invalid Year in Bill From Date!! <br/>';
                            
             billFromDate = billFromDatelist[len-1]+billFromDatelist[len-len]+billFromDatelist[len-2];

        }else 
             billFromDate = string.valueOf(system.today().addyears(-1)).replace('-','');
                    
        if(String.isNotBlank(billToDate)){
           
            list<String> billToDatelist = billToDate.split('/');
             Integer len = billToDatelist.size();
            if(billToDatelist[len-len].length() != 2)
                billToDatelist[len-len] = '0'+billToDatelist[len-len];
            if(billToDatelist[len-2].length() != 2)
                billToDatelist[len-2] = '0'+billToDatelist[len-2];
            if(billToDatelist[len-1].length() != 4)
                Err +='Invalid Year in Bill To Date !! <br/>';
                
            billToDate  = billToDatelist[len-1]+billToDatelist[len-len]+billToDatelist[len-2];
        }else 
            billToDate = string.valueOf(system.today()).replace('-',''); 

        String AccName= ApexPages.currentPage().getParameters().get('accountName');
          Id AccId= ApexPages.currentPage().getParameters().get('accountId');
          if(!test.isrunningtest()) {
           getInvoiceHistory(AccId,AccName,billFromDate,billToDate,selectedInvoiceStatus,selectedNumOfRecords,ContactNumber,false,Err);
          }     
               
          invHistoryList = new list<WrapperInvoiceHistory>();
          return null;
    }

    public void invHistoryload(){
       
    }


    public PageReference redirect(){
        String Errors = '';
        
        if(String.isNotEmpty(selectedInvoice)){
            invoiceNumber  = selectedInvoice;  
        }else if(String.isNotEmpty(invoiceText)){
            invoiceNumber  = invoiceText;
        }
        if(SORVar.Customer_Contact__c== null){
            Errors += ' Please select Customer Contact !!<br/>';
        }  
        if(SORVar.Reason_for_Credit__c == null){
            Errors += ' Please select Reason For Credit !!<br/>';
        }
        if(String.isEmpty(SORVar.Description__c)){
            Errors += ' Please enter Description !!<br/>';
                  
        }  
        if(invoiceNumber  == null ){
            Errors += 'Please enter/select Invoice Number !!<br/>';
        }
        if(invHistorySet != null && String.isNotBlank(invoiceNumber) ){
            boolean invFound = false;
            for(String invHistoryVar : invHistorySet){
                if(invoiceNumber  == invHistoryVar  ){
                    invFound= true;
                    break;
                }
            }
            if(!invFound){
                Errors += 'Please enter/select valid Invoice Number !!<br/>';
            }
        }
       if(SORVar.Customer_Contact__c != null){
            Boolean contactFound = false;
          //  List<Contact> contactsList = [SELECT Id, FirstName, LastName FROM Contact WHERE AccountId = :AccId];
            for(Contact contactVar : lstContact ){
                if(SORVar.Customer_Contact__c == contactVar.Id ){
                    contactFound = true;
                    break;
                }
            }
            if(!contactFound){
                Errors += 'Please enter/select contact realted to the Account !!<br/>';
            }
        }
        ID caseCreated ; 
        if(String.isNotBlank(Errors)){
            Errors = Errors.substring(0,Errors.length()-5);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,Errors));
            return null;  
        } 
        
        displayCreditArea = true;
        displayinvoiceSearch = false;
        if(!test.isrunningtest()) {
        invoiceHeader = getInvoiceDetails(invoiceNumber);
        }
               lineItemsList = invoiceHeader.lineItemList;
               displayHeaderLineItem(invoiceHeader); 
        return null;
         //nextPage = true;        
       /* PageReference retURL = new PageReference('/apex/SelectLineItemsForCredit?&invoicenum='+invoiceNumber+'&accId='+AccId+'&accName='+AccName+'&nextPage='+true);
        retURL.setRedirect(true);
        return retURL;*/
                  
           
    }

    public PageReference NavigateBack(){
             PageReference retURL = new PageReference('/'+AccId);
             retURL.setRedirect(true);
             return retURL;
    }
     
     
        public void displayHeaderLineItem(WrapperInvoiceHeader invoiceHeader){
        WrapperInvoiceHeader invoiceHeaderVar = new WrapperInvoiceHeader ();
        INVOICE_NUMBER=invoiceHeader.INVOICE_NUMBER;
        SALES_ORG=invoiceHeader.SALES_ORG;
        System.debug('SALES_ORG...'+SALES_ORG);
        DISTR_CHAN=invoiceHeader.DISTR_CHAN;
        String invDate=invoiceHeader.INVOICE_DATE;
        String[] dts = invDate.split('-');
            if(!test.isRunningTest()){
                 invDate = dts[1]+'/'+dts[2]+'/'+dts[0];
            }
       
        INVOICE_DATE = invDate; 
        TERMS_CODE=invoiceHeader.TERMS_CODE;
        INVOICE_AMOUNT=invoiceHeader.INVOICE_AMOUNT;
        CURRENCY_x=invoiceHeader.CURRENCY_x;
        PAYING_CUSTOMER=invoiceHeader.PAYING_CUSTOMER;
        SOLD_TO_CUSTOMER=invoiceHeader.SOLD_TO_CUSTOMER;
        SHIP2_CUSTOMER=invoiceHeader.SHIP2_CUSTOMER;
        CONTRACT =invoiceHeader.CONTRACT;
        INVOICE_AMOUNT = invoiceHeader.INVOICE_AMOUNT;
        DOC_CATEG = invoiceHeader.DOC_CATEG;
       
        
    }

     
    public static WrapperInvoiceHeader getInvoiceDetails(String invoiceNumber){

     List<WrapperLineItems> lineItemsWrapperList;
     WrapperInvoiceHeader invoiceHeaderWrapperVar;
     List<WrapperLineItemPricing> linePricingWrapperList;
     List<WrapperLineItemPricing> lineItemPricingList;
  
         if(String.isNotBlank(invoiceNumber)|| invoiceNumber !='0'){
                mobileminiComEccInvoicedetails.HTTP_Port  stub = new mobileminiComEccInvoicedetails.HTTP_Port();
                stub.inputHttpHeaders_x = new Map<String, String>();
                Blob headerValue = Blob.valueOf('PIPREMOTE' + ':' + 'L3tm31n$$');
                //Blob headerValue = Blob.valueOf('data_int' + ':' + 'Letm3in!');
                String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
                stub.inputHttpHeaders_x.put('Authorization', authorizationHeader);
                stub.timeout_x = 120000;
                
                  sapComDocumentSapRfcFnInvoice.ZSD_INVOICE_DETAILS_Response_element InvoiceResp =  stub.os_Get_Invoice_Details(invoiceNumber,null);    
                 linePricingWrapperList = new List<WrapperLineItemPricing>();
                 if(InvoiceResp.E_LINE_PRICING.item != null){
                         List<WrapperLineItemPricing> linePricingList = new List<WrapperLineItemPricing>();
                         WrapperLineItemPricing linePriceVar;
                         for(sapComDocumentSapRfcFnInvoice.ZSD_LINE_PRICE respLinePrice : InvoiceResp.E_LINE_PRICING.item){
                                // if(respLinePrice.COND_TYPE == 'ZP00' || respLinePrice.COND_TYPE == 'ZP01' || respLinePrice.COND_TYPE == 'ZPPE'|| respLinePrice.COND_TYPE == 'ZLLW'|| respLinePrice.COND_TYPE == 'ZFUE' ){
                                        linePriceVar = new WrapperLineItemPricing();
                                        linePriceVar.ITM_NUMBER=respLinePrice.ITM_NUMBER;
                                        linePriceVar.STEP_NUMBER=respLinePrice.STEP_NUMBER;
                                        linePriceVar.COUNTER=respLinePrice.COUNTER;
                                        linePriceVar.COND_TYPE=respLinePrice.COND_TYPE;
                                        linePriceVar.RATE = Decimal.valueOf(respLinePrice.RATE).setScale(2);
                                        linePriceVar.CURRENCY_x=respLinePrice.CURRENCY_x;
                                        linePriceVar.AMOUNT=Decimal.valueOf(respLinePrice.AMOUNT).setScale(2);
                                        linePriceVar.VTEXT = respLinePrice.VTEXT;
                                        linePricingWrapperList.add(linePriceVar);
                               // }
                        } 
                }
                
                List<WrapperLineItems> lineItemList ;
                lineItemsWrapperList= new List<WrapperLineItems>();
                if(InvoiceResp.E_INVOICE_LINES.item != null){
                        lineItemList = new List<WrapperLineItems>();
                        WrapperLineItems lineItemVar;
                        for(sapComDocumentSapRfcFnInvoice.ZSD_INVOICE_LINE  respLineItem : InvoiceResp.E_INVOICE_LINES.item){
                                lineItemVar = new WrapperLineItems();
                                lineItemVar.ITM_NUMBER = respLineItem.ITM_NUMBER;
                                lineItemVar.MATERIAL = respLineItem.MATERIAL;
                                lineItemVar.DESCRIPTION = respLineItem.DESCRIPTION;
                                lineItemVar.QUANTITY = respLineItem.QUANTITY;
                                lineItemVar.UNIT_OF_MEASURE = respLineItem.UNIT_OF_MEASURE;
                                lineItemVar.AMOUNT = Decimal.valueOf(respLineItem.AMOUNT).setScale(2);
                                lineItemVar.CONTRACT = respLineItem.CONTRACT;
                                lineItemVar.CONTRACT_LINE = respLineItem.CONTRACT_LINE;
                                lineItemVar.PLANT = respLineItem.PLANT;
                                lineItemVar.ITEM_CATEG = respLineItem.ITEM_CATEG;
                                lineItemVar.ITEM_TAX = Decimal.valueOf(respLineItem.ITEM_TAX).setScale(2);
                                lineItemPricingList = new List<WrapperLineItemPricing>();
                                for(WrapperLineItemPricing linePricingVar: linePricingWrapperList){
                                     if(linePricingVar.ITM_NUMBER == respLineItem.ITM_NUMBER){
                                         lineItemPricingList.add(new WrapperLineItemPricing(linePricingVar.ITM_NUMBER,linePricingVar.STEP_NUMBER,linePricingVar.COUNTER,linePricingVar.COND_TYPE,linePricingVar.RATE,linePricingVar.CURRENCY_x,linePricingVar.AMOUNT,linePricingVar.VTEXT));
                                     }
                                } 
                              lineItemVar.linePricingList = lineItemPricingList;
                                lineItemsWrapperList.add(lineItemVar);
                        } 
                          
                }
               
               
                 sapComDocumentSapRfcFnInvoice.ZSD_INVOICE_HEADER invoiceHeaderVar;
                 if(InvoiceResp.E_HEADER != null){
                     invoiceHeaderVar = new sapComDocumentSapRfcFnInvoice.ZSD_INVOICE_HEADER();
                     sapComDocumentSapRfcFnInvoice.ZSD_INVOICE_HEADER respInvoiceHeader = InvoiceResp.E_HEADER ;
                     invoiceHeaderVar.INVOICE_NUMBER=respInvoiceHeader.INVOICE_NUMBER;
                     invoiceHeaderVar.SALES_ORG=respInvoiceHeader.SALES_ORG;
                     invoiceHeaderVar.DISTR_CHAN=respInvoiceHeader.DISTR_CHAN;
                     invoiceHeaderVar.INVOICE_DATE=respInvoiceHeader.INVOICE_DATE;
                     invoiceHeaderVar.TERMS_CODE=respInvoiceHeader.TERMS_CODE;
                     invoiceHeaderVar.INVOICE_AMOUNT=respInvoiceHeader.INVOICE_AMOUNT;
                     invoiceHeaderVar.CURRENCY_x=respInvoiceHeader.CURRENCY_x;
                     invoiceHeaderVar.PAYING_CUSTOMER=respInvoiceHeader.PAYING_CUSTOMER;
                     invoiceHeaderVar.SOLD_TO_CUSTOMER=respInvoiceHeader.SOLD_TO_CUSTOMER;
                     invoiceHeaderVar.SHIP2_CUSTOMER=respInvoiceHeader.SHIP2_CUSTOMER;
                     invoiceHeaderVar.CONTRACT =respInvoiceHeader.CONTRACT;
                     invoiceHeaderVar.DOC_CATEG =respInvoiceHeader.DOC_CATEG;
                     
                 }
                  invoiceHeaderWrapperVar = new WrapperInvoiceHeader(invoiceHeaderVar.INVOICE_NUMBER,invoiceHeaderVar.SALES_ORG,invoiceHeaderVar.DISTR_CHAN,invoiceHeaderVar.INVOICE_DATE,invoiceHeaderVar.TERMS_CODE,invoiceHeaderVar.INVOICE_AMOUNT,invoiceHeaderVar.CURRENCY_x,invoiceHeaderVar.PAYING_CUSTOMER,invoiceHeaderVar.SOLD_TO_CUSTOMER,invoiceHeaderVar.SHIP2_CUSTOMER,invoiceHeaderVar.CONTRACT,invoiceHeaderVar.DOC_CATEG,lineItemsWrapperList);
                    if(invoiceHeaderWrapperVar != null)
                         {
                          return invoiceHeaderWrapperVar;
                          }
                  else{
                      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Cannot find Invoice Details for the Account '+ ApexPages.currentPage().getParameters().get('accName') ));
                      return null;
                  }
            } 
           else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Sorry! Error in the System, Please try again after sometime'));
                return null;
           }
    
 
  
    }

    
    
    public PageReference saveCreditCase(){     
                Double SumOfCredit = 0.00; 
             String credAmtErr = '';  
             String PlantId = '';
            
            for(WrapperLineItems lineItemVar : lineItemsList){
                for(WrapperLineItemPricing linePricingVar : lineItemVar.linePricingList){
                     SumOfCredit += linePricingVar.CONDITIONAL_VALUE;
                     if(linePricingVar.AMOUNT < linePricingVar.CONDITIONAL_VALUE){
                                           credAmtErr += 'Credit Amount cannot be greater than Amount for '+ lineItemVar.DESCRIPTION+' at '+linePricingVar.COND_TYPE+' !!<br/>';
                                           
                                       }
                     }
                     
                  }
                   if(SumOfCredit  <= 0){
                          //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Cannot create Credit case without Credit Amount, please enter credit amount greater than 0.00 !!'));
                            credAmtErr += 'Cannot create Credit case without Credit Amount, please enter credit amount greater than 0.00 !!';                          
                      }
                      if(String.isNotBlank(credAmtErr)){
                              credAmtErr = credAmtErr.subString(0,credAmtErr.length()-5);
                              ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,credAmtErr));
                              return null;
                          }
              //insert child object and update sor details
            List<Customer_Request_Invoice__c> custReqInvListToInsert = new List<Customer_Request_Invoice__c> ();
           
          
            SORVar.Invoice_Number__c = invoiceNumber;     
            SORVar.Document_Category__c = DOC_CATEG;
            SORvar.SAP_Ship_To__c = SHIP2_CUSTOMER;
            SORVar.Invoice_Currency__c = CURRENCY_x;
            SORVar.Distribution_Channel__c = Integer.valueOf(DISTR_CHAN);
            SORVar.Document__c = CONTRACT;
            //RecordType CredMMIRecType = [SELECT id,Name, DeveloperName FROM RecordType WHERE isActive = true AND (sObjectType = 'Service_Order_Request__c' AND DeveloperName = 'Credits_MMI')];
            //RecordType CredMMIRecType = [SELECT id,Name, DeveloperName FROM RecordType WHERE isActive = true AND (sObjectType = 'Service_Order_Request__c' AND DeveloperName = 'SAP_Credits_MMI')];            
            Id CredRecTypeId;
            if(CredRecTypes.size() > 0){
              for(RecordType rec : CredRecTypes){
                 if(displayCreditMMI && rec.Developername == 'SAP_Credits_MMI')
                   CredRecTypeId = rec.Id;
                 else if(displayCreditETS && rec.Developername == 'SAP_Credits_ETS')  
                   CredRecTypeId = rec.Id;
                 else if(displayCreditWMI && rec.Developername == 'SAP_Credits_WMI')
                   CredRecTypeId = rec.Id;  
              }
            }
            SORVar.RecordTypeId = CredRecTypeId;
            //SORVar.RecordTypeId = CredMMIRecType.Id;
            SORVar.Date__c = Date.today();
            SORVar.Invoice_List__c = invNumbers;
            if(!test.isRunningTest()){
                SORVar.Order_Reason_Char_Code__c = reasonForCreditCharCodeMap.get(SORVar.Reason_for_Credit__c);
             }
                              
             for(WrapperLineItems lineItemVar : lineItemsList){
                      
                           for(WrapperLineItemPricing linePricingVar : lineItemVar.linePricingList){
                              Customer_Request_Invoice__c custReqInvVarToInsert = new Customer_Request_Invoice__c();
                              System.debug('linePricingVar.COND_TYPE.....'+linePricingVar.COND_TYPE);
                                custReqInvVarToInsert.Condition_Type__c = linePricingVar.COND_TYPE;
                                if(linePricingVar.CURRENCY_x != null){
                                    custReqInvVarToInsert.Invoice_Currency__c = linePricingVar.CURRENCY_x;
                                }
                                custReqInvVarToInsert.Amount__c = linePricingVar.AMOUNT;
                                custReqInvVarToInsert.Conditional_Value__c = linePricingVar.CONDITIONAL_VALUE;
                                    SumOfCredit += linePricingVar.CONDITIONAL_VALUE;
                                    if(linePricingVar.AMOUNT < linePricingVar.CONDITIONAL_VALUE){
                                       credAmtErr += 'Credit Amount cannot be greater than Amount for '+ lineItemVar.DESCRIPTION+' at '+linePricingVar.COND_TYPE+' !!<br/>';
                                       
                                   } 
                                custReqInvVarToInsert.Item_Number__c = linePricingVar.ITM_NUMBER;  
                             
                              
                              //custReqInvVarToInsert.Customer_Request__c = createdcase.Id;
                              custReqInvVarToInsert.Contract_Number__c = lineItemVar.CONTRACT;    
                              custReqInvVarToInsert.Description__c = lineItemVar.DESCRIPTION;
                              custReqInvVarToInsert.Material__c = lineItemVar.MATERIAL;
                              custReqInvVarToInsert.Plant__c = lineItemVar.PLANT;
                              PlantId = lineItemVar.PLANT;
                              //custReqInvVarToInsert.Quantity__c = Integer.valueOf(lineItemVar.QUANTITY);
                              custReqInvVarToInsert.Quantity__c = Decimal.valueOf(lineItemVar.QUANTITY).setScale(2);
                              custReqInvVarToInsert.Unit_of_Measure__c = lineItemVar.UNIT_OF_MEASURE;
                              custReqInvVarToInsert.Invoice_Number__c = invoiceHeader.INVOICE_NUMBER; 
                              
                              custReqInvListToInsert.add(custReqInvVarToInsert);
                          }
                          
                         
                           
                      }
                
                try{
                SORVar.Branch_ID__c = PlantId;
                insert SORVar;
                }catch(exception e){
                    throw(e);
                }
            
            Service_Order_Request__c createdcase = [Select ID,Status__c from Service_Order_Request__c where Invoice_Number__c = :invoiceNumber order by CreatedDate DESC LIMIT 1];     
                
             for(Customer_Request_Invoice__c custReqInvVarToInsert : custReqInvListToInsert)   
                custReqInvVarToInsert.Customer_Request__c = createdcase.Id;
                
                insert custReqInvListToInsert;
                if(!test.isRunningTest()){
                     createdcase.Status__c = 'SAP Credit Process';
                     //createdcase.SAP_Credit_Approval__c = true;                     
                     update createdcase;
                }
               
                
                PageReference retURL = new PageReference('/'+createdcase.Id);
                retURL.setRedirect(true);
                return retURL; 
                  
              
     }
     
     
     
     
     
    public PageReference navigateToPrev(){     
                displayCreditArea = false;
                displayinvoiceSearch = true;
                return null;       
             /* PageReference retURL = new PageReference('/apex/InvoiceSearch?accId='+ApexPages.currentPage().getParameters().get('accId')+'&accName='+ApexPages.currentPage().getParameters().get('accName')+'&invoicenum='+ApexPages.currentPage().getParameters().get('invoicenum')+'&caseId='+ApexPages.currentPage().getParameters().get('caseId'));
              retURL.setRedirect(true);
              return retURL;*/
     }
     
    public class DomainOrderReason{
        public String Domain {get;set;}
        public String DomainID{get;set;}
        public String DomainDescription{get;set;}
        public Integer ParentDomainID{get;set;}
        
        public DomainOrderReason(){}
    }

    public class DomainWrapper{
        public List<DomainOrderReason> Records;
        
        public DomainWrapper(){}
    
    }

    public class WrapperInvoiceHistory{

        public String InvoiceNumber{get;set;}

        public WrapperInvoiceHistory(){}



    }


    public class WrapperInvoiceHeader{

            public String INVOICE_NUMBER;
            public String SALES_ORG;
            public String DISTR_CHAN;
            public String INVOICE_DATE;
            public String TERMS_CODE;
            public String INVOICE_AMOUNT;
            public String CURRENCY_x;
            public String PAYING_CUSTOMER;
            public String SOLD_TO_CUSTOMER;
            public String SHIP2_CUSTOMER; 
            public String CONTRACT;
            public String DOC_CATEG;
            public List<WrapperLineItems> lineItemList;
          
            public WrapperInvoiceHeader(){}
            
            public WrapperInvoiceHeader(String INVOICE_NUMBER,String SALES_ORG,String DISTR_CHAN,String INVOICE_DATE,String TERMS_CODE,String INVOICE_AMOUNT,String CURRENCY_x,String PAYING_CUSTOMER,String SOLD_TO_CUSTOMER,String SHIP2_CUSTOMER,String CONTRACT,String DOC_CATEG,List<WrapperLineItems> lineItemList){
                    this.INVOICE_NUMBER=INVOICE_NUMBER;
                    this.SALES_ORG= SALES_ORG;
                    this.DISTR_CHAN = DISTR_CHAN;
                    this.INVOICE_DATE=INVOICE_DATE;
                    this.TERMS_CODE=TERMS_CODE;
                    this.INVOICE_AMOUNT=INVOICE_AMOUNT;
                    this.CURRENCY_x=CURRENCY_x;
                    this.PAYING_CUSTOMER=PAYING_CUSTOMER;
                    this.SOLD_TO_CUSTOMER=SOLD_TO_CUSTOMER;
                    this.SHIP2_CUSTOMER = SHIP2_CUSTOMER;
                    this.CONTRACT =CONTRACT ;
                    this.DOC_CATEG = DOC_CATEG;
                    this.lineItemList=lineItemList;
            }

    }

    public class WrapperLineItems{

            public String ITM_NUMBER{get;set;}
            public String MATERIAL{get;set;}
            public String DESCRIPTION{get;set;}
            public String QUANTITY{get;set;}
            public String UNIT_OF_MEASURE{get;set;}
            public Decimal AMOUNT{get;set;}
            public String CONTRACT{get;set;}
            public String CONTRACT_LINE{get;set;}
            public String PLANT{get;set;}
            public String ITEM_CATEG{get;set;}
            public Decimal ITEM_TAX{get;set;}
            public List<WrapperLineItemPricing> linePricingList{get;set;}
            
            public WrapperLineItems(){}
            
            public WrapperLineItems(String ITM_NUMBER,String MATERIAL,String DESCRIPTION,String QUANTITY,String UNIT_OF_MEASURE,Decimal AMOUNT,String CONTRACT,String CONTRACT_LINE,String PLANT,String ITEM_CATEG,Decimal ITEM_TAX,List<WrapperLineItemPricing> linePricingList){
                this.ITM_NUMBER=ITM_NUMBER;    
                this.MATERIAL=MATERIAL;
                this.DESCRIPTION=DESCRIPTION;
                this.QUANTITY=QUANTITY;
                this.UNIT_OF_MEASURE=UNIT_OF_MEASURE;
                this.AMOUNT=AMOUNT;
                this.CONTRACT=CONTRACT;
                this.CONTRACT_LINE=CONTRACT_LINE;
                this.PLANT=PLANT;
                this.ITEM_CATEG=ITEM_CATEG;
                this.ITEM_TAX=ITEM_TAX;
                this.linePricingList=linePricingList;
          
          }  
           

    }

    public class WrapperLineItemPricing{

            public String ITM_NUMBER{get;set;}
            public String STEP_NUMBER{get;set;}
            public String COUNTER{get;set;}
            public String COND_TYPE{get;set;}
            
            public Decimal RATE{get;set;}
            public String CURRENCY_x{get;set;}
            public Decimal AMOUNT{get;set;}
            public String VTEXT{get;set;}
            public Decimal CONDITIONAL_VALUE{get;set;}
            public String CREDIT_AMOUNT{get;set;}
            
            
            public WrapperLineItemPricing(){
                this.CONDITIONAL_VALUE = 0.00;
            }
            
            public WrapperLineItemPricing(String ITM_NUMBER,String STEP_NUMBER,String COUNTER,String COND_TYPE,Decimal RATE,String CURRENCY_x,Decimal AMOUNT,String VTEXT){
                this.ITM_NUMBER=ITM_NUMBER;
                this.STEP_NUMBER=STEP_NUMBER;
                this.COUNTER=COUNTER;
                this.COND_TYPE=COND_TYPE;
                this.RATE=RATE;
                this.CURRENCY_x=CURRENCY_x;
                this.AMOUNT=AMOUNT;
                this.VTEXT=VTEXT;
           }

    }
    
    
     public PageReference saveGeneralCreditCase(){   
     
      /* String Errors = '';
        
        
        if(SORVar.Customer_Contact__c== null){
            Errors += ' Please select Customer Contact !!<br/>';
        }  
        if(SORVar.Reason_for_Credit__c == null){
            Errors += ' Please select Reason For Credit !!<br/>';
        }
        if(String.isEmpty(SORVar.Description__c)){
            Errors += ' Please enter Description !!<br/>';
                  
        }  
         if(gcCreditAmount == null){
            Errors += ' Please enter Credit Amount!!<br/>';
        }
        if(gcCreditAmount <= 0.00){
            Errors += ' Please enter Credit Amount greater than 0!!<br/>';
        }
        if(gcCreditAmount > 0.00){
            if(String.valueOf(gcCreditAmount).length() > 19){
                Errors  += 'Max length of Credit Amount is 16 with 2 decimals !';
            }
        }
        if(String.isNotBlank(Errors)){
            Errors = Errors.substring(0,Errors.length()-5);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,Errors));
            return null;  
        } 
     
     
        Customer_Request_Invoice__c custReqInvVarToInsert = new Customer_Request_Invoice__c ();
           
           // SORVar.Document__c = CONTRACT;
            RecordType CredMMIRecType = [SELECT id,Name, DeveloperName FROM RecordType WHERE isActive = true AND (sObjectType = 'Service_Order_Request__c' AND DeveloperName = 'General_Credits_MMI')];
            SORVar.RecordTypeId = CredMMIRecType.Id;
            SORVar.Date__c = Date.today();
            
            try{
                insert SORVar;
                }catch(exception e){
                  if(e.getMessage().contains('FIELD_FILTER'))
                      {ApexPages.addMessages(e);}
                  //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,''));
                    return null;  
                }
            Service_Order_Request__c createdcase = [Select ID,Status__c from Service_Order_Request__c order by CreatedDate DESC LIMIT 1];  
              
                custReqInvVarToInsert.Customer_Request__c = createdcase.Id;
                custReqInvVarToInsert.Conditional_Value__c = gcCreditAmount;
                insert custReqInvVarToInsert;
                if(!test.isRunningTest()){
                    createdcase.Status__c = 'In Process';
                    update createdcase;
                }
                
                
                PageReference retURL = new PageReference('/'+createdcase.Id);
                retURL.setRedirect(true);
                return retURL; */
                return null;
                  
              
     }
     public pageReference ContactCreateArea(){
        displayCreateContact = true;
        return null;
    } 
     
     public pageReference CreateContact(){
        try{
            Contact con = new Contact();
            String Error = '';
            
                System.debug('conFn...'+conFn);
                con.FirstName = conFn;
                con.LastName = conLn;
                con.Phone = conPh;
                con.Email = conEmail;
                con.MobilePhone = conMob;
                con.Fax= conFax;
                system.debug('----AccId-----'+AccId);
                con.AccountId = Id.valueOf(AccId);
                insert con;
                //isFromNewContact = true;
                conFax = '';
                conFn = '';
                conLn = '';
                conPh = '';
                conMob = '';
                conEmail = '';
               
                ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.CONFIRM, 'New Contact has been created successfully!');
                ApexPages.addMessage(msg);
                lstContact = new list < Contact > ();
           lstContact = [select Id, Name, firstname, lastname, Phone, MobilePhone, Email, Fax from Contact where AccountId = :AccId order by CreatedDate DESC];
       }catch(Exception e){
           if(!e.getMessage().contains('INVALID_EMAIL_ADDRESS')){
                ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage());
               ApexPages.addMessage(msg);
           }
        }
       return null;
    }
    
    

}