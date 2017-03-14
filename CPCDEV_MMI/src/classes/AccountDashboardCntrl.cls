/**
* (c) 2015 TEKsystems Global Services
*
* Name           : AccountDashboardCntrl
* Created Date   : 27 July, 2015 @ 1130
* Created By     : Shankar Rao (TEKSystems)
* Purpose        : Controller class used by 'AccountDashboard' VF page.
* Last Updated By: Ankur Goyal (TEKSystems)
* Last Updated Date: 21-Jan-2016
**/
global class  AccountDashboardCntrl {
    public Id oppId{get;set;}
    public String  salesOrgID{get;set;}
    public Account currentAccount {get;set;}
    public Integer openCases {get; set;}
    public Integer openSOR {get; set;}
    public String  certExpiration {get; set;}
    public Integer openUOR {get; set;}
    Public integer revenue1{get; set;}
    Public integer revenue2{get; set;}
    Public integer revenue3{get; set;}
    Public integer revenue4{get; set;}
    Public integer revenue5{get; set;}
    Public integer revenue6{get; set;}
    Public integer revenue7{get; set;}
    Public integer revenue8{get; set;}
    public Map<Id, String> caseIDDateMap {get; set;}
    public Map<Id, String> sorIDDateMap {get; set;}
    public Map<Id, String> npsIDDateMap {get; set;}
    public Map<Id, String> contractIDDateMap {get; set;}
    public Map<Id, String> quoteIDDateMap {get; set;}
    public List<Wrapperforcontracts> latestContractsList {get; set;}
    public List<Service_Order_Request__c> latestCasesList {get; set;}
    //public List<Service_Order_Request__c> latestSORList {get; set;}
    public List<WrapperForSOR> latestSORList {get; set;}
    public List<Net_Promoter_Score__c> latestNPSList {get; set;}
    Public static List<String> statusList{get; set;} 
    public Map<String, List<String>> quarterTimelineYearsQuarterMap {get; set;}
    public List<QuoteHeaderWrapper> listWrapQuoteHaeders{get;set;}
    public static LIST<sapComDocumentSapRfcFunctions.ZSD_ORDER_ITEM> orderItemsList = new List<sapComDocumentSapRfcFunctions.ZSD_ORDER_ITEM>();
    public String currentPage{get;set;}
    public String cpqURL{get;set;}
    public String portalURL{get;set;}
    public boolean creditSt{get;set;}
    public boolean creditStAvlbl{get;set;}
    public FinancialSummaryWrapper finSum{get;set;}
    public String curHost{get;set;}
    
    public String contractStatus{get;set;}  
    public String contractSrNo{get;set;}
    public String contractsFromDate{get;set;}
    public String contractsToDate{get;set;}
    public String contractNumber{get;set;}
    public String returnContractsCount;
    public Boolean creditStGreen{get;set;}
    public Boolean creditStYellow{get;set;}
    public Boolean creditStRed{get;set;}  
    public Boolean isBillingValid{get;set;}
    public static string serviceErrorMessage{get;set;}
    public static Boolean isConServiceAvailable{get;set;}
    
    public static string finServiceErrorMessage{get;set;}
    public static Boolean isFinServiceAvailable{get;set;}
    
    public boolean redirectClone{get;set;}
      
    //Shankar - Account Dashboard constructor 
    public AccountDashboardCntrl(ApexPages.StandardController controller) {
        
        currentAccount = (Account)controller.getRecord();
        openCases = 0;
        caseIDDateMap = new Map<Id, String>();
        sorIDDateMap = new Map<Id, String>();
        npsIDDateMap = new Map<Id, String>();
        contractIDDateMap = new Map<Id, String>();
        quoteIDDateMap = new Map<Id, String>();
        listWrapQuoteHaeders = new List<QuoteHeaderWrapper>();
        statusList =new List<String>();
        
        currentPage = 'https://' + ApexPages.currentPage().getHeaders().get('Host');
        
        returnContractsCount = '100'; 
        contractsFromDate = '20000101';
        contractsToDate = '20991201';
        contractStatus = null;
        contractSrNo = null;
        contractNumber = null;
        redirectClone = false;
        //fetch cpq and portal url from custom setting based on the current instance(Dev/QA/Prod)
        cpqURL = '';
        portalURL = '';
        curHost = String.valueof(System.URL.getSalesforceBaseUrl().getHost());
        for(CPQActiveURL__c cu: CPQActiveURL__c.getAll().values()){
            if(curHost.containsignorecase(cu.Environment__c)){
                cpqURL = cu.CPQ_URL__c;
                portalURL = cu.Portal_URL__c;
            }
        }
      
       
        if(currentAccount.Id != null){
            //query the account fields to be displayed on dashboard for current account ID
            currentAccount = [SELECT Id,BillingState, Name, SAP_Bill_To__c,SAP_Sold_To__c, Revenue_LTM__c, CurrencyIsoCode, Credit_Status__c, Credit_Status_Image__c, NPS_Status_Icon__c, NPS_Status__c, LLW_Status__c,recordtype.name,
                                     Insurance_Cert_Exp__c, Special_Instructions__c, Activations_Q5__c , Activations_Q1__c, Activations_Q4__c, Activations_QC__c,
                                     Activations_Q7__c, Activations_Q3__c, Activations_Q6__c, Activations_Q2__c, Revenue_Q1__c, Revenue_Q2__c, Revenue_Q3__c,
                                     Revenue_Q4__c, Revenue_Q5__c, Revenue_Q6__c, Revenue_Q7__c, Revenue_QC__c, Summary_balance_current__c, Summary_balance_30_days__c, 
                                     Summary_balance_60_days__c, Summary_balance_90_days__c, Summary_balance_120_days__c, Special_Billing_Instructions__c,Terms__c,Sales_Org__c,Last_Invoice_Date__c , Credit_Collector_Name__c ,Valid_Billing_Address__c
                                     FROM Account WHERE Id =:currentAccount.Id];
            isBillingValid = Boolean.valueOf(currentAccount.Valid_Billing_Address__c);                         
            certExpiration = currentAccount.Insurance_Cert_Exp__c == null?'':currentAccount.Insurance_Cert_Exp__c.format();
            salesOrgID = currentAccount.Sales_Org__c  ;
            
            if(currentAccount.Activations_Q7__c == null){currentAccount.Activations_Q7__c=0;}
            if(currentAccount.Activations_Q6__c == null){currentAccount.Activations_Q6__c=0;}
            if(currentAccount.Activations_Q5__c == null){currentAccount.Activations_Q5__c=0;}
            if(currentAccount.Activations_Q4__c == null){currentAccount.Activations_Q4__c=0;}
            if(currentAccount.Activations_Q3__c == null){currentAccount.Activations_Q3__c=0;}
            if(currentAccount.Activations_Q2__c == null){currentAccount.Activations_Q2__c=0;}
            if(currentAccount.Activations_Q1__c == null){currentAccount.Activations_Q1__c=0;}
            if(currentAccount.Activations_QC__c == null){currentAccount.Activations_QC__c=0;}
            if(currentAccount.Revenue_Q1__c == null){currentAccount.Revenue_Q1__c=0;}
            if(currentAccount.Revenue_Q2__c == null){currentAccount.Revenue_Q2__c=0;}
            if(currentAccount.Revenue_Q3__c == null){currentAccount.Revenue_Q3__c=0;}
            if(currentAccount.Revenue_Q4__c == null){currentAccount.Revenue_Q4__c=0;}
            if(currentAccount.Revenue_Q5__c == null){currentAccount.Revenue_Q5__c=0;}
            if(currentAccount.Revenue_Q6__c == null){currentAccount.Revenue_Q6__c=0;}
            if(currentAccount.Revenue_Q7__c == null){currentAccount.Revenue_Q7__c=0;}
            if(currentAccount.Revenue_QC__c == null){currentAccount.Revenue_QC__c=0;}
        }
        openUOR = 0;
        List<Wrapperforcontracts> contractsWrapperList = new List<Wrapperforcontracts>();
        latestContractsList = new List<Wrapperforcontracts>();
        isConServiceAvailable = true;
        serviceErrorMessage = '';
        contractsWrapperList = getContracts(currentAccount.SAP_Bill_To__c,currentAccount.recordtype.name,'5',contractsFromDate,contractsToDate,contractStatus,contractSrNo,contractNumber);
        contractStatus = 'ON RENT';returnContractsCount = '';
        openUOR = getUORForCurrentAccount(currentAccount.SAP_Bill_To__c,currentAccount.recordtype.name,returnContractsCount,contractsFromDate,contractsToDate,contractStatus,contractSrNo,contractNumber);
        //contractsWrapperList.sort();
        for(Integer i = 0; i<=contractsWrapperList.size()-1;i++)
        {
            latestContractsList.add(contractsWrapperList.get(i));
        }
        
        creditStAvlbl = false;
        creditSt = false;
        creditStGreen = false;
        creditStYellow = false;
        creditStRed = false;
        isFinServiceAvailable = true;
        finServiceErrorMessage = '';
        finSum = new FinancialSummaryWrapper();
        finSum = getFinSumData(currentAccount.SAP_Bill_To__c,currentAccount.Sales_Org__c);
        
        if(finSum != null)
        {
            creditStAvlbl = true;
            string riskCat = finSum.risk_cat;
            if( riskCat == 'Z09' || riskCat == 'Z10'){
                creditStGreen = true;
            } 
            else if(riskCat == 'NEW' || riskCat == 'new' || riskCat == 'New' || riskCat == 'Z01' || riskCat == 'Z02' || riskCat == 'Z11' || riskCat == 'Z13'){
                creditStYellow =  true;       
            }   
            else{
                if(riskCat != '' && riskCat != null){
                    creditStRed = true; }
            } 
        }
        
        listWrapQuoteHaeders = getQuotes1();
        latestCasesList = getCases();
        latestSORList = new List<WrapperForSOR>();
        latestSORList = getServiceOrderRequests(currentAccount.recordtype.name);
        latestNPSList = getNPS();
        quarterTimelineYearsQuarterMap = new Map<String, List<String>>();
        setUpActivationRevenueLists();
        
        revenue1= Integer.valueOf(currentAccount.Revenue_Q1__c);
        revenue2= Integer.valueOf(currentAccount.Revenue_Q2__c);
        revenue3= Integer.valueOf(currentAccount.Revenue_Q3__c);
        revenue4= Integer.valueOf(currentAccount.Revenue_Q4__c);
        revenue5= Integer.valueOf(currentAccount.Revenue_Q5__c);
        revenue6= Integer.valueOf(currentAccount.Revenue_Q6__c);
        revenue7= Integer.valueOf(currentAccount.Revenue_Q7__c);
        revenue8= Integer.valueOf(currentAccount.Revenue_QC__c);
    }
    
    //Ankur - Get financial summary data by consuming SOAP webservice
    public static FinancialSummaryWrapper getFinSumData(String sapBillTo, string salesorg){
        List<FinancialSummaryWrapper> financialSummaryList;
        financialSummaryList = new List<FinancialSummaryWrapper>();
        FinancialSummaryWrapper finSumData = new FinancialSummaryWrapper();
        try{
            if(sapBillTo != '' && sapBillTo != null && sapBillTo != '0')
            { 
                //LIST<sapComDocumentSapRfcFunctionsFin.ZFI_KUNNR_FIN_SUM> finSumRes = new LIST<sapComDocumentSapRfcFunctionsFin.ZFI_KUNNR_FIN_SUM>(); 
                
                sapComDocumentSapRfcFunctionsFin.ZFIF_FINANCIAL_SUMMARY_Response_element finSumRes = new sapComDocumentSapRfcFunctionsFin.ZFIF_FINANCIAL_SUMMARY_Response_element();
                finSumRes = DataForcontracts.fetchFinancialSummaryFromCPQResponse(sapBillTo,salesorg);  //salesOrgID
                if( finSumRes.ET_FIN_SUM.item.size() > 0   ) {
                    for(sapComDocumentSapRfcFunctionsFin.ZFI_KUNNR_FIN_SUM temp : finSumRes.ET_FIN_SUM.item){
                        financialSummaryList.add(new FinancialSummaryWrapper(temp.customer, temp.due_0_to_29, temp.due_30_to_59, temp.due_60_to_89, temp.due_90_to_119, temp.due_120_plus,temp.credit_limit,
                                   temp.risk_cat,temp.exp_date,temp.collector_name,temp.risk_cat_desc,temp.last_invoice_dt,temp.pay_terms,temp.customer_group,temp.certfct_file,temp.billing_inst,temp.CREDIT_USED,temp.DELTA_CREDIT));    //temp.exp_date,temp.code_desc,temp.collector_name
                    }
                } 
                
                if(financialSummaryList.size() > 0){
                    finSumData = financialSummaryList[0];
                } 
                
                if(finSumRes.ET_RETURN.item != null)
                {
                    //system.debug('Service not avaliable, error: '+dataContrcts.T_RETURN.item[0].message);
                    finServiceErrorMessage = finSumRes.ET_RETURN.item[0].message;
                    isFinServiceAvailable = false;
                }
            }
        } //end of try
        catch(Exception e){
            system.debug('-- Exception -- : '+e);
            return finSumData;
        } 
        return finSumData ;
    }  //end of getFinSumData
    
    //Ankur - Get list of latest Contracts for the accound by consuming SOAP service.
    public static LIST<Wrapperforcontracts> getContracts(String sapBillTo,String recName,String returnContractsCount,String contractsFromDate,String contractsToDate,String contractStatus,String contractSrNo,String contractNumber){
        LIST<Wrapperforcontracts> tempContractsList = new LIST<Wrapperforcontracts>();
        statusList.clear();
        try{
            if(sapBillTo != '' && sapBillTo != null && sapBillTo != '0' ) {
                
                List<WrapperContractItems> contractItemsList = new List<WrapperContractItems>();
                //LIST<sapComDocumentSapRfcFunctions.ZSD_ORDER_HEADER> dataContrcts = new LIST<sapComDocumentSapRfcFunctions.ZSD_ORDER_HEADER>(); 
                sapComDocumentSapRfcFunctions.ZSD_CONTRACT_SEARCH_Response_element dataContrcts = new sapComDocumentSapRfcFunctions.ZSD_CONTRACT_SEARCH_Response_element();
                dataContrcts = DataForcontracts.fetchContractsFromResponse(sapBillTo,returnContractsCount,contractsFromDate,contractsToDate,contractStatus,contractSrNo,contractNumber);
                if( dataContrcts.T_CONTRACT_HEADERS.item.size() > 0   ) {  //size() > 0   ) {
                    String contractHeaderPlant = '';
                    String contractHeaderMaterial = '';
                    String contractHeaderFulDepot = '';
                    string goodsIssueDate = '';
                    //String tempMaterial = '';
                    for(sapComDocumentSapRfcFunctions.ZSD_ORDER_HEADER temp : dataContrcts.T_CONTRACT_HEADERS.item){ 
                        contractItemsList = new List<WrapperContractItems>();            
                        if(temp.orderitems.size() > 0)
                        {   
                            //system.debug('contract items:::::::::::::::::::'+temp.orderitems); 
                            contractHeaderPlant = temp.orderitems[0].plant;
                            //contractHeaderMaterial = temp.orderitems[0].material;
                            //tempMaterial = temp.orderitems[0].material;
                            contractHeaderFulDepot = temp.orderitems[0].Name1;
                            //goodsIssueDate = temp.orderitems[0].PGI_Date;
                            for(sapComDocumentSapRfcFunctions.ZSD_ORDER_ITEM torder : temp.orderitems){
                                contractItemsList.add(new WrapperContractItems(torder.contract, torder.itm_Number, torder.status, torder.material, torder.short_text, torder.serial_number,torder.plant,torder.rate, torder.con_st_dat_l,torder.con_en_dat_l,recName,torder.PGI_Date,torder.Name1,torder.BILL_PLAN_REL));    
                                if(torder.PGI_Date != null && torder.PGI_Date != '' && torder.PGI_Date != '0000-00-00' && goodsIssueDate == '' && ( torder.status == 'ON RENT' || torder.status == 'ORNPU') ){
                                    goodsIssueDate =  torder.PGI_Date;  
                                    contractHeaderMaterial = torder.material;
                                }
                                if(contractHeaderMaterial == '' && torder.status != 'REJECTED')
                                    contractHeaderMaterial = torder.material;    
                                if(torder.status.equalsignorecase('ON RENT')){
                                    statusList.add(torder.status);
                                }
                            } 
                            
                        }
                        tempContractsList.add(new Wrapperforcontracts(temp.contract, temp.purch_no_c, temp.street, temp.city, temp.region, temp.postl_code,contractItemsList,contractHeaderPlant,contractHeaderFulDepot,contractHeaderMaterial,temp.con_st_dat_h,temp.con_en_dat_h,recName,goodsIssueDate,temp.credit_Block));  
                        goodsIssueDate = '';
                        contractHeaderMaterial  ='';                    
                    }
                }
                if(dataContrcts.T_RETURN.item != null)
                {
                    //system.debug('Service not avaliable, error: '+dataContrcts.T_RETURN.item[0].MESSAGE);
                    serviceErrorMessage = dataContrcts.T_RETURN.item[0].message;
                    isConServiceAvailable = false;
                }
                
            }
            
        } //end of try
        catch(Exception e){
            system.debug('=== exp === '+e);
            return tempContractsList;    
        }
        return tempContractsList;
   }  //end of getContracts
   
   //Ankur - Get UOR for the current accound by consuming SOAP service.
    public static Integer getUORForCurrentAccount(String sapBillTo,String recName,String returnContractsCount,String contractsFromDate,String contractsToDate,String contractStatus,String contractSrNo,String contractNumber){
        //LIST<Wrapperforcontracts> tempContractsList = new LIST<Wrapperforcontracts>();
        //statusList.clear();
        Integer UORs = 0;
        try{
            if(sapBillTo != '' && sapBillTo != null && sapBillTo != '0' ) {
                
                //List<WrapperContractItems> contractItemsList = new List<WrapperContractItems>();
                //LIST<sapComDocumentSapRfcFunctions.ZSD_ORDER_HEADER> dataContrcts = new LIST<sapComDocumentSapRfcFunctions.ZSD_ORDER_HEADER>(); 
                //sapComDocumentSapRfcFunctions.ZSD_CONTRACT_SEARCH_Response_element dataContrcts = new sapComDocumentSapRfcFunctions.ZSD_CONTRACT_SEARCH_Response_element();
                UORs = DataForcontracts.fetchUORsFromResponse(sapBillTo,returnContractsCount,contractsFromDate,contractsToDate,contractStatus,contractSrNo,contractNumber);
            }
            
        } //end of try
        catch(Exception e){
            system.debug('=== exp === '+e);
            return UORs;    
        }
        return UORs;
   }  //end of getContracts
    
    //Shankar - Get list of latest Quotes for the accound.  
  /*  private LIST<QuoteHeaderWrapper> getQuotes(){
        Quote_Item_Level__c QIL= new Quote_Item_Level__c(); 
        List<Quote_Header__c> recentQuotes = new List<Quote_Header__c>();
        List<Quote_Item_Level__c> quoteitemlist = new List<Quote_Item_Level__c>();
        //iterate through each quote corresponding to the current account ID and add it to quotes list which is 
        //used on the dashboard to display the quotes
        for(Quote_Header__c quoteRecord : [SELECT Id, Opportunity__c, Name, Contact__c,Status__c,Branch__c,Start_Date__c,Delivery_Charge__c,Delivery_City__c,Delivery_Date__c,Total_Initial_Charges__c,Shipto_State__c,
                                           (SELECT Id,Product_Id__c,Actual_Amount__c,Description__c,Item_Code__c,Unit_Type__c,Type__c,Quantity__c  FROM Quote_Item_Levels__r 
                                           
                                           Order by LastModifiedDate Desc) FROM Quote_Header__c
                                           WHERE Account__c=: currentAccount.Id and Status__c in ('Open','Lost','Won') and Opportunity__c != null Order by LastModifiedDate Desc]){
            if(quoteRecord.Delivery_City__c != '' && quoteRecord.Delivery_City__c != null){
              if(quoteRecord.Delivery_City__c.length() > 7)
                quoteRecord.Delivery_City__c= quoteRecord.Delivery_City__c.subString(0,7); 
            }   //where Description__c in ('Pickup Charge','Delivery Charge','Base Rental Rate')
            recentQuotes.add(quoteRecord); 
            
        }
         
         integer i=0;
         List<QuoteHeaderWrapper> listWrapQuoteHaeder = new List<QuoteHeaderWrapper>();
         for(Quote_Header__c QHeader:recentQuotes)
         {
            if(i >999 )
                break;
            i = i+1;
            List<Quote_Item_Level__c> quoteitemlist2 = QHeader.Quote_Item_Levels__r;
            if(!quoteitemlist2.isEmpty())
            {
                String temProdid =String.isNotBlank(quoteitemlist2[0].Item_Code__c)?quoteitemlist2[0].Item_Code__c:null;
                Decimal temAclamtid=quoteitemlist2[0].Actual_Amount__c;
                listWrapQuoteHaeder.add(new QuoteHeaderWrapper(QHeader,temProdid,temAclamtid,currentAccount.recordtype.name));
            }
            else{
            listWrapQuoteHaeder.add(new QuoteHeaderWrapper(QHeader,null,0.0,currentAccount.recordtype.name));
            }
         }                                                                  
         return listWrapQuoteHaeder;     
    } //end of getQuotes   
    */
    private LIST<QuoteHeaderWrapper> getQuotes1(){
        //String salesOrg = currentAccount.Sales_Org__c;
        Quote_Item_Level__c QIL= new Quote_Item_Level__c(); 
        List<Quote_Header__c> recentQuotes = new List<Quote_Header__c>();
        List<Quote_Item_Level__c> quoteitemlist = new List<Quote_Item_Level__c>();
        List<Quote_Sub_Item_Level__c> quoteSubItemList; // = new List<Quote_Sub_Item_Level__c>();
        Set<ID> currentAccQuoteIDSet = new Set<ID>();
        Map<ID,Decimal> lineItemEnteredAmt = new map<ID,Decimal>();
        Map<ID,String> lineItemQuantity = new map<ID,String>();
                               
        //iterate through each quote corresponding to the current account ID and add it to quotes list which is 
        //used on the dashboard to display the quotes
        for(Quote_Header__c quoteRecord : [SELECT Id, Opportunity__c, Name, Contact__c,Status__c,Branch__c,Start_Date__c,Delivery_Charge__c,Delivery_City__c,Delivery_Date__c,Total_Initial_Charges__c,Shipto_State__c,
                                           (SELECT Id,Name,Product_Id__c,Actual_Amount__c,Description__c,Item_Code__c,Unit_Type__c,Type__c,Quantity__c,Quote_Item_Number__c,Quote_Item_Higher_Level__c,Plant_ID__c  FROM Quote_Item_Levels__r 
                                           Order by Quote_Item_Number__c ASC) FROM Quote_Header__c
                                           WHERE Account__c=: currentAccount.Id and Status__c in ('Open','Lost','Won') and Opportunity__c != null Order by LastModifiedDate Desc limit 10]){
            currentAccQuoteIDSet.add(quoteRecord.ID);
            if(quoteRecord.Delivery_City__c != '' && quoteRecord.Delivery_City__c != null){
              if(quoteRecord.Delivery_City__c.length() > 7)
                quoteRecord.Delivery_City__c= quoteRecord.Delivery_City__c.subString(0,7); 
            }   //where Description__c in ('Pickup Charge','Delivery Charge','Base Rental Rate')
            recentQuotes.add(quoteRecord); 
        } //end of for
        
        quoteSubItemList = [select Id,Quote_Item_Number__c,Quote_Item_Higher_Level__c,ADJ_COND_TYPE__c,Actual_Amount__c,Amount__c,Base_Amount__c,Entered_Amount__c,Quote_Item_level_ID__c,Quantity__c  
                           FROM Quote_Sub_Item_Level__c where ADJ_COND_TYPE__c like 'ZTOT' and Quote_Header__c in:currentAccQuoteIDSet order by Quote_Item_Number__c asc];
        
        Decimal actAmt = 0.00;
        for(Quote_Sub_Item_Level__c qsli : quoteSubItemList){
            if(qsli.Quantity__c != null && (qsli.Quantity__c) != 0)
            {
                actAmt = (qsli.Actual_Amount__c/qsli.Quantity__c);
                lineItemEnteredAmt.put(qsli.Quote_Item_level_ID__c,actAmt);
                lineItemQuantity.put(qsli.Quote_Item_level_ID__c,String.valueof(qsli.Quantity__c));
            }
            else{
                actAmt = 0.00;
                lineItemEnteredAmt.put(qsli.Quote_Item_level_ID__c,actAmt);
                lineItemQuantity.put(qsli.Quote_Item_level_ID__c,String.valueof(0)); //qsli.Quantity__c
            }
        system.debug('SFDC qsli.Quote_Item_level_ID__c is: ' + qsli.Quote_Item_level_ID__c + ' , the qsli.Id is: '+ qsli.Id + 'and qsli.Quantity__c String is: ' +String.valueof(qsli.Quantity__c));              
        }            
         
         integer i=0;
         List<QuoteHeaderWrapper> listWrapQuoteHaeder = new List<QuoteHeaderWrapper>();
         //List<QuoteLineItemWrapper> quoteLineItemWrapperList = new List<QuoteLineItemWrapper>();
         for(Quote_Header__c QHeader : recentQuotes)
         {
            string plantCode = '';
            if(i >999 )
                break;
            i = i+1;
            //quoteLineItemWrapperList.clear();
            List<Quote_Item_Level__c> quoteitemlist2 = QHeader.Quote_Item_Levels__r;
            if(!quoteitemlist2.isEmpty()){
                for(Quote_Item_Level__c qilevel : QHeader.Quote_Item_Levels__r ){
                    /*for(Quote_Sub_Item_Level__c qsil : quoteSubItemList)
                    {
                        if(String.valueof(qilevel.Id) == String.valueof(qsil.Quote_Item_level_ID__c) && String.valueof(qilevel.Quote_Item_Number__c) == String.valueof(qsil.Quote_Item_Number__c) ){
                        ===    QuoteLineItemWrapper qliw = new QuoteLineItemWrapper();
                            qliw.qilId       = qilevel.ID;
                            qliw.qliDesc     = qilevel.Description__c;
                            qliw.qliItem     = qilevel.Item_Code__c;
                            qliw.qliQty      = String.valueof(qilevel.Quantity__c);
                            qliw.totalAmount = String.valueof(qsil.Amount__c);
                            qliw.totalActAmount     = String.valueof(qsil.Actual_Amount__c);    
                            qliw.totalBaseAmount    = String.valueof(qsil.Base_Amount__c);
                            qliw.totalEnteredAmount = String.valueof(qsil.Entered_Amount__c); ====
                            quoteLineItemWrapperList.add(new QuoteLineItemWrapper(qilevel.ID,qilevel.Description__c,qilevel.Item_Code__c,String.valueof(qilevel.Quantity__c),String.valueof(qsil.Amount__c),String.valueof(qsil.Actual_Amount__c),String.valueof(qsil.Base_Amount__c),String.valueof(qsil.Entered_Amount__c)));  
                                
                        }
                    } */
                    
                    if(qilevel.Plant_ID__c != null && qilevel.Plant_ID__c != '')
                        plantCode = qilevel.Plant_ID__c;
                    if(lineItemEnteredAmt.containsKey(qilevel.ID)){
                        qilevel.Actual_Amount__c = lineItemEnteredAmt.get(qilevel.ID);
                    }else{
                        qilevel.Actual_Amount__c = 0.00;
                    }    
                    if(lineItemQuantity.containsKey(qilevel.ID)){
                        system.debug('SFDC qilevel.ID is: ' +qilevel.ID);
                        system.debug('SFDC lineItemQuantity.get(qilevel.ID) is: '+lineItemQuantity.get(qilevel.ID));
                        qilevel.Quantity__c = Decimal.valueof(lineItemQuantity.get(qilevel.ID));
                        system.debug('SFDC qilevel.Quantity__c is: ' +qilevel.Quantity__c);
                    }else{
                        qilevel.Quantity__c = 0;
                    }    
                }
                String temProdid =String.isNotBlank(quoteitemlist2[0].Item_Code__c)?quoteitemlist2[0].Item_Code__c:null;
                Decimal temAclamtid=quoteitemlist2[0].Actual_Amount__c;
                listWrapQuoteHaeder.add(new QuoteHeaderWrapper(QHeader,temProdid,temAclamtid,currentAccount.recordtype.name,plantCode));
            }
            else{
                listWrapQuoteHaeder.add(new QuoteHeaderWrapper(QHeader,null,0.0,currentAccount.recordtype.name,plantCode));
            }
            
         }                                                                  
         return listWrapQuoteHaeder;     
    } //end of getQuotes1
 /*   
    Public Class QuoteLineItemWrapper{
        public string qliDesc{get;set;}
        public string qliItem{get;set;}
        public string qliQty{get;set;}
        public string totalAmount{get;set;}
        public string totalActAmount{get;set;}
        public string totalBaseAmount{get;set;}
        public string totalEnteredAmount{get;set;}
        public ID qilId{get;set;}
    
        public QuoteLineItemWrapper(ID qilID,String qliDesc ,String qliItem,String qliQty,String totalAmount ,String totalActAmount ,String totalBaseAmount ,String totalEnteredAmount ){
            this.qilId = qilId;
            this.qliDesc = qliDesc ;
            this.qliItem = qliItem ;
            this.qliQty = qliQty ;
            this.totalAmount = totalAmount ;
            this.totalActAmount = totalActAmount ;
            this.totalBaseAmount = totalBaseAmount ;
            this.totalEnteredAmount = totalEnteredAmount ;
        }
        
    } */
    
    Public class QuoteHeaderWrapper
    {
        public Quote_Header__c quoteHeader{get;set;}
        public String prodId{get;set;}
        public Decimal AclamtId{get;set;}
        public String QHStartDate{get;set;}
        public String QHDelDate{get;set;}
        public String plantCode{get;set;}
        //public List<QuoteLineItemWrapper> qhLineItmes{get;set;} 
        
        public QuoteHeaderWrapper(Quote_Header__c QH,String pid,Decimal actAmount,String recTypeName,String plantCode)
        {
            quoteHeader = QH;
            prodId = pid;
            AclamtId = actAmount;
            QHStartDate = '';
            QHDelDate = '';
            this.plantCode = plantCode;
            if(QH.Start_Date__c!=null)
            {
                DateTime startDateTime = datetime.newInstance(QH.Start_Date__c.year(),QH.Start_Date__c.month(),QH.Start_Date__c.day()); 
                String userTimeZone = String.valueOf(UserInfo.getTimeZone());
                String tempQHStartDate = recTypeName.containsIgnoreCase('UK')?startDateTime.format('dd/MM/yyyy HH:mm:ss',userTimeZone):startDateTime.format('MM/dd/yyyy HH:mm:ss',userTimeZone);
                QHStartDate = tempQHStartDate.split(' ')[0];
            }
            
            if(QH.Delivery_Date__c != null)
            {
                DateTime startDateTime = datetime.newInstance(QH.Delivery_Date__c.year(),QH.Delivery_Date__c.month(),QH.Delivery_Date__c.day()); 
                String userTimeZone = String.valueOf(UserInfo.getTimeZone());
                String tempQHDelDate = recTypeName.containsIgnoreCase('UK')?startDateTime.format('dd/MM/yyyy HH:mm:ss',userTimeZone):startDateTime.format('MM/dd/yyyy HH:mm:ss',userTimeZone);
                QHDelDate = tempQHDelDate.split(' ')[0];
            }
        }
                
    }  //end of class QuoteHeaderWrapper
    
    //Shankar - Get list of latest Cases for the accound.
    private LIST<Service_Order_Request__c> getCases(){
        openCases = 0;
        List<Service_Order_Request__c> recentCases = new List<Service_Order_Request__c>();
        
        //iterate through each SOR corresponding to the current account ID and add it to list which is 
        //used on the dashboard to display the cases
        for(Service_Order_Request__c caseRecord : [SELECT Id, Name, Date__c,recordtype.name, Status__c, Service_Issue__c, Branch_ID__c,Customer_Email_Address__c,Customer_Contact__r.name 
                                                                                                         FROM Service_Order_Request__c
                                                                                                         WHERE (Account_Name__c =:currentAccount.Id AND recordtype.name !='Service Order Request (ETS) 1500' AND recordtype.name !='Service Order Request (MMI) 1000' AND recordtype.name !='Service Order Request (WMI) 1501' AND recordtype.name !='Service Order Request - (MMI UK) 1200' )
                                                                                                         Order by LastModifiedDate Desc]){
            if('Completed' != caseRecord.Status__c && 'Cancelled' != caseRecord.Status__c){
                openCases++;        
            }
                        
            if(caseRecord.recordtype.name != null && caseRecord.recordtype.name !=''){
                string rectype=caseRecord.recordtype.name.right(4);
                if(currentAccount.Sales_Org__c == '1100')
                    rectype = '1100';
                if(rectype==currentAccount.Sales_Org__c){
                    recentCases.add(caseRecord);
                }
            }   
        }
        return recentCases;
    } //end of getCases
    
    //Ankur - Get list of latest 3 SOR for the accound.
    private List<WrapperForSOR> getServiceOrderRequests(String recName){
        openSOR = 0;
        //List<Service_Order_Request__c> recentSOR = new List<Service_Order_Request__c>();
        List<WrapperForSOR> recentSOR = new List<WrapperForSOR>();
        
        //iterate through each SOR corresponding to the current account ID and add it to SOR list which is 
        //used on the dashboard to display the service order requests
        for(Service_Order_Request__c sorRecord : [SELECT Id, Name, Createddate,Date__c,recordtype.name, Status__c, Service_Issue__c, Branch_ID__c,Customer_Email_Address__c,Customer_Contact__c 
                                                                                                         FROM Service_Order_Request__c
                                                                                                         WHERE (Account_Name__c =:currentAccount.Id AND(recordtype.name ='Service Order Request (ETS) 1500' OR recordtype.name ='Service Order Request (MMI) 1000' OR recordtype.name ='Service Order Request (WMI) 1501' OR recordtype.name ='Service Order Request - (MMI UK) 1200'))
                                                                                                         Order by LastModifiedDate Desc]){
            
            sorIDDateMap.put(sorRecord.Id, sorRecord.Date__c == null?'':sorRecord.Date__c.format());
            if('Completed' != sorRecord.Status__c && 'Cancelled' != sorRecord.Status__c){
                openSOR++;    
            }
            
            if(sorRecord.recordtype.name != null && sorRecord.recordtype.name !=''){
                string rectype=sorRecord.recordtype.name.right(4);
                if(rectype==currentAccount.Sales_Org__c){
                    //recentSOR.add(sorRecord);
                    recentSOR.add(new WrapperForSOR(sorRecord.ID,sorRecord.Name,string.valueof(sorRecord.Createddate),sorRecord.recordtype.name,sorRecord.Status__c,sorRecord.Service_Issue__c,sorRecord.Branch_ID__c,sorRecord.Customer_Contact__c,sorRecord.Customer_Email_Address__c,recName));
                }
            }
        }
        return recentSOR;
    } //end of getServiceOrderRequests
    
    //Shankar - Get list of latest 3 NPS for the accound.
    private LIST<Net_Promoter_Score__c> getNPS(){
        List<Net_Promoter_Score__c> recentNPS = new List<Net_Promoter_Score__c>();
        //iterate through each NPS record corresponding to the current account ID and add it to NPS list which is 
        //used on the dashboard to display the NPS records: Net Promoter Score
        for(Net_Promoter_Score__c npsRecord : [SELECT Id, Name, UKSurveyID__c, Service_Date__c, Would_you_recommend_us__c, Customer_Effort_Score__c,
                                                      Hot_Sheet_Generated__c FROM Net_Promoter_Score__c
                                                                             WHERE Account__c =:currentAccount.Id Order by LastModifiedDate Desc]){
        
            npsIDDateMap.put(npsRecord.Id, npsRecord.Service_Date__c == null?'':npsRecord.Service_Date__c.date().format());
            recentNPS.add(npsRecord);    
        }
        return recentNPS;
    }  //end of getNPS
    
    //Shankar - Extract labels and form four public list to store details to display quarter timeline.
    public void setUpActivationRevenueLists(){
        
        for(Schema.FieldSetMember field : SObjectType.Account.FieldSets.ActivationQuarters.getFields()){
            quarterTimelineYearsQuarterMap.put(field.getLabel().subString(field.getLabel().length() - 4), new List<String>());
        }
        
        for(Schema.FieldSetMember field : SObjectType.Account.FieldSets.ActivationQuarters.getFields()){
            String fieldLabel = field.getLabel().subString(field.getLabel().length() - 7);
            quarterTimelineYearsQuarterMap.get(field.getLabel().subString(field.getLabel().length() - 4)).add(fieldLabel.subString(0,2));
        }
    }

    //wrapper for SOR
    public class WrapperForSOR{
        public string id{get;set;}
        public string name{get;set;}
        public string Createddate{get;set;}
        public string recordtypeName{get;set;}
        public string status{get;set;}
        public string serviceIssue{get;set;}
        public string branchID{get;set;}
        public string customerContact{get;set;}
        public string customerEmailAddress{get;set;}
        
        public WrapperForSOR(String id,String name, String Createddate, String recordtypeName, String status, String serviceIssue, String branchID, String customerContact,string customerEmailAddress,string recTypeName ){
            this.id = id;
            this.name = name;
            this.recordtypeName = recordtypeName;
            this.status = status;
            this.serviceIssue = serviceIssue;
            this.branchID = branchID;
            this.customerContact = customerContact;
            this.customerEmailAddress = customerEmailAddress;
            Date dt = Date.valueof(Createddate);
            DateTime startDateTime = datetime.newinstance(dt.year(),dt.month(),dt.day()); 
            String userTimeZone = String.valueOf(UserInfo.getTimeZone());
            String tempCrtDate = recTypeName.containsIgnoreCase('UK')?startDateTime.format('dd/MM/yyyy HH:mm:ss',userTimeZone):startDateTime.format('MM/dd/yyyy HH:mm:ss',userTimeZone);
            this.Createddate = tempCrtDate.split(' ')[0];
        }
    }
    
    
    global class Wrapperforcontracts implements Comparable {
        public string contract{get;set;}
        public string purch_no_c{get;set;}
        public string street{get;set;}
        public string city{get;set;}
        public string region{get;set;}
        public string postl_code{get;set;}
        public List<WrapperContractItems> contractItems{get;set;}
        public String plant{get;set;}
        public String fulDepot{get;set;}
        public String material{get;set;}
        public String con_st_dat{get;set;}
        public String con_en_dat{get;set;}
        public string goodsIssueDate{get;set;}
        public string creditBlock{get;set;}
        
        public Wrapperforcontracts(String contract, String purch_no_c, string street, String city, String region, string postl_code,List<WrapperContractItems> contractItemsList,String contractHeaderPlant,string contractHeaderFulDepot,String contractHeaderMaterial,string con_st_dat,string con_en_dat,String recTypeName,string goodsIssueDate,string creditBlock){      
            this.contract= contract;
            if(purch_no_c.length() > 15)
                this.purch_no_c= purch_no_c.subString(0,15);
            else
                this.purch_no_c= purch_no_c;
            
            if(street.length() > 15)            
                this.street= street.subString(0,15);
            else
                this.street= street;    
            
            this.creditBlock = creditBlock;
            this.city = city;
            this.region= region;    
            this.postl_code= postl_code; 
            this.contractItems = new List<WrapperContractItems>();
            this.contractItems = contractItemsList; 
            this.plant  =contractHeaderPlant;
            this.fulDepot = contractHeaderFulDepot;
            this.material = contractHeaderMaterial;
            
            if(con_st_dat != null && con_st_dat != '' && con_st_dat != '0000-00-00')
            {
                Date dt = Date.valueof(con_st_dat);
                DateTime startDateTime = datetime.newinstance(dt.year(),dt.month(),dt.day()); 
                String userTimeZone = String.valueOf(UserInfo.getTimeZone());
                String tempQHDate = recTypeName.containsIgnoreCase('UK')?startDateTime.format('dd/MM/yyyy HH:mm:ss',userTimeZone):startDateTime.format('MM/dd/yyyy HH:mm:ss',userTimeZone);
                this.con_st_dat = tempQHDate.split(' ')[0];
            }
            else
                this.con_st_dat = '';    
            
            if(con_en_dat != null && con_en_dat != '' && con_en_dat != '0000-00-00')
            {
                Date dt = Date.valueof(con_en_dat);
                DateTime startDateTime = datetime.newinstance(dt.year(),dt.month(),dt.day()); 
                String userTimeZone = String.valueOf(UserInfo.getTimeZone());
                String tempQHDate = recTypeName.containsIgnoreCase('UK')?startDateTime.format('dd/MM/yyyy HH:mm:ss',userTimeZone):startDateTime.format('MM/dd/yyyy HH:mm:ss',userTimeZone);
                this.con_en_dat = tempQHDate.split(' ')[0];
            }
            else
                this.con_en_dat = '';
                
            if(goodsIssueDate != null && goodsIssueDate != '' && goodsIssueDate != '0000-00-00')
            {
                Date dt = Date.valueof(goodsIssueDate );
                DateTime startDateTime = datetime.newinstance(dt.year(),dt.month(),dt.day()); 
                String userTimeZone = String.valueOf(UserInfo.getTimeZone());
                String tempQHDate = recTypeName.containsIgnoreCase('UK')?startDateTime.format('dd/MM/yyyy HH:mm:ss',userTimeZone):startDateTime.format('MM/dd/yyyy HH:mm:ss',userTimeZone);
                this.goodsIssueDate = tempQHDate.split(' ')[0];
            }
            else
                this.goodsIssueDate = '';     
            
        }
        global Integer compareTo(Object ObjToCompare) {
            return con_st_dat.CompareTo(((Wrapperforcontracts)ObjToCompare).con_st_dat);
        }
    } //end of Wrapperforcontracts 

    //Ankur: Contract items wrapper
    public class WrapperContractItems{
        public string contract{get;set;}
        public string itm_Number{get;set;}
        public string status{get;set;}
        public string material{get;set;}
        public string short_text{get;set;}
        public string serial_number{get;set;}
        public string plant{get;set;}
        public string rate{get;set;}
        public string con_st_dat{get;set;}
        public string con_en_dat{get;set;}
        public string goodsIssueDate{get;set;}
        public string fulDepot{get;set;}
        public string billingPlanRel{get;set;}
        
        public WrapperContractItems(String contract, String itm_Number, string status, String material, String short_text, string serial_number,String plant,string rate, string con_st_dat,string con_en_dat,String recTypeName,string goodsIssueDate,string fulDepot,string billingPlanRel){
            this.contract= contract;
            this.itm_Number= itm_Number;
            
            if(status.length() > 13)
                this.status= status.subString(0,13);
            else
                this.status= status;
                
            this.material= material;
            
            if(short_text.length() > 10)
                this.short_text= short_text.subString(0,10); 
            else
                this.short_text= short_text;
                
            this.serial_number= serial_number; 
            this.plant= plant;
            this.rate= rate;
            if(con_st_dat != null && con_st_dat != '' && con_st_dat != '0000-00-00')
            {
                Date dt = Date.valueof(con_st_dat);
                DateTime startDateTime = datetime.newinstance(dt.year(),dt.month(),dt.day()); 
                String userTimeZone = String.valueOf(UserInfo.getTimeZone());
                String tempQHDate = recTypeName.containsIgnoreCase('UK')?startDateTime.format('dd/MM/yyyy HH:mm:ss',userTimeZone):startDateTime.format('MM/dd/yyyy HH:mm:ss',userTimeZone);
                this.con_st_dat = tempQHDate.split(' ')[0];
            }
            else
                this.con_st_dat = '';    
            
            if(con_en_dat != null && con_en_dat != '' && con_en_dat != '0000-00-00')
            {
                Date dt = Date.valueof(con_en_dat);
                DateTime startDateTime = datetime.newinstance(dt.year(),dt.month(),dt.day()); 
                String userTimeZone = String.valueOf(UserInfo.getTimeZone());
                String tempQHDate = recTypeName.containsIgnoreCase('UK')?startDateTime.format('dd/MM/yyyy HH:mm:ss',userTimeZone):startDateTime.format('MM/dd/yyyy HH:mm:ss',userTimeZone);
                this.con_en_dat = tempQHDate.split(' ')[0];
            }
            else
                this.con_en_dat = ''; 
           
           if(goodsIssueDate != null && goodsIssueDate != '' && goodsIssueDate != '0000-00-00')
            {
                Date dt = Date.valueof(goodsIssueDate);
                DateTime startDateTime = datetime.newinstance(dt.year(),dt.month(),dt.day()); 
                String userTimeZone = String.valueOf(UserInfo.getTimeZone());
                String tempQHDate = recTypeName.containsIgnoreCase('UK')?startDateTime.format('dd/MM/yyyy HH:mm:ss',userTimeZone):startDateTime.format('MM/dd/yyyy HH:mm:ss',userTimeZone);
                this.goodsIssueDate = tempQHDate.split(' ')[0];
            }
            else
                this.goodsIssueDate = ''; 
           
            this.fulDepot = fulDepot;
            this.billingPlanRel = billingPlanRel;
            
        }    //end of constructor

    } //end of class WrapperContractItems


    //Ankur: Customer details on account dashboard to be populated from WSDL. Below class will act as a wrapper for details received from CPQ.
    global class FinancialSummaryWrapper{
        public String customer{get;set;}
        public String due_0_to_29{get;set;}
        public String due_30_to_59{get;set;}
        public String due_60_to_89{get;set;}
        public String due_90_to_119{get;set;}
        public String due_120_plus{get;set;}
        public String credit_limit{get;set;}
        public String risk_cat{get;set;}
        public Date   exp_date{get;set;}
        //public String code_desc{get;set;}
        public String collector_name{get;set;}
        public String risk_cat_desc{get;set;}
        public Date   last_invoice_dt{get;set;}
        public String pay_terms{get;set;}
        public String customer_group{get;set;}
        public String certfct_file{get;set;}
        public String billing_inst{get;set;}
        public String credit_used{get;set;}
        public String delta_credit{get;set;}
        
        public FinancialSummaryWrapper( ){
        }
        
        public FinancialSummaryWrapper(String customer,String due_0_to_29,String due_30_to_59,String due_60_to_89,String due_90_to_119,String due_120_plus,String credit_limit,
                                    String risk_cat,String exp_date,String collector_name,String risk_cat_desc,String last_invoice_dt,String pay_terms,String customer_group,
                                    String certfct_file,String billing_inst,String credit_used,String delta_credit){
            this.customer = customer;
            this.due_0_to_29 = due_0_to_29;
            this.due_30_to_59 = due_30_to_59;
            this.due_60_to_89 = due_60_to_89;
            this.due_90_to_119 = due_90_to_119;
            this.due_120_plus = due_120_plus;
            this.credit_limit = credit_limit;
            this.risk_cat     = risk_cat;
            if(exp_date != '' && exp_date != '0000-00-00')
                this.exp_date = Date.valueof(exp_date);
            else
                this.exp_date = null;
            //this.code_desc    = code_desc;
            this.collector_name= collector_name;
            this.risk_cat_desc= risk_cat_desc;
            if(last_invoice_dt != '' && last_invoice_dt != '0000-00-00')
                this.last_invoice_dt = Date.valueof(last_invoice_dt);
            else
                this.last_invoice_dt = null;
            this.pay_terms     = pay_terms;
            this.customer_group= customer_group;
            this.certfct_file  = certfct_file  ;
            this.billing_inst  = billing_inst  ;
            this.credit_used  = credit_used  ;
            this.delta_credit  = delta_credit  ;
            
        } //end of constructor

    } //end of class FinancialSummaryWrapper

    //Ankur: Create opportunity record and set oppId so that opportunity Id can be passed to CPC
    public void Createopportunity(){
        Opportunity newOpp = new Opportunity();
        newOpp.name = currentAccount.name;
        newOpp.AccountId = currentAccount.id;
        newOpp.StageName = 'Not Quoted';
        //newOpp.Opportunity_Contact_Name_LookUpFilter__c = contactId;
        newOpp.CloseDate = date.today() + 21;
         
        if(salesOrgID == '1200' )
            newOpp.recordTypeID = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity - UK').getRecordTypeId();
        else if(salesOrgID == '1000' || salesOrgID == '1100')
            newOpp.recordTypeID = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity').getRecordTypeId();
        else    
            newOpp.recordTypeID = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('ETS Rental').getRecordTypeId();    
        newOpp.From_New_Quote__c = true;
        insert newOpp;
        oppId = newOpp.id;
        redirectClone = true;
        
    } //end of Createopportunity
    
    public void click(){
    }
 }