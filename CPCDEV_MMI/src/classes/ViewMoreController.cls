/**
* (c) 2015 TEKsystems Global Services
*
* Name           : ViewMoreController 
* Created Date   : 27 July, 2015 
* Created By     : Jailabdin S (TEKSystems)
* Purpose        : Controller class used by 'Quote_More' & ''ViewMorePage' VF page.
* Last Updated By: Ankur Goyal (TEKSystems)
* Last Updated Date: 21-Jan-2016
**/

global class ViewMoreController 
{
    public Transient List<QuoteHeaderWrapper> listWrapQuoteHaeders{get;set;}
    public Transient static List<QuoteHeaderWrapper> listWrapQuoteHaeders1{get;set;}
    public List<Wrapperforcontracts> latestContractsList {get; set;}
    public List<Sobject> result{get;set;}
    public list<Schema.FieldSetMember> fieldsetMem{get;set;}
    public String accountId{get;set;}
    public static String accID{get;set;}
    public String fromObject{get;set;}
    //public String quoteID{get;set;}
    public String salesOrgID{get;set;}
    public String cpqURL{get;set;}
    public String portalURL{get;set;}
    public Account currentAccount{get;set;}
    public list<String> listFiledSetFileds{get;set;}
    public Map<String,List<String>> mapStringtoObject;
    public Boolean subtableval{
    get{
        return subtableval;
    }
    set;}
    public Boolean subtablevalcontract{get;set;}
    
    public String contractStatus{get;set;}  
    public String contractSrNo{get;set;}
    public String contractsFromDate{get;set;}
    public String contractsToDate{get;set;}
    public String contractNumber{get;set;}
    public String returnContractsCount;
    //public date mydate{get;set;}
    public Boolean isOnMore{get;set;}
    Public String newURL{get;set;}
    Public Boolean isBillingValid{get;set;}
    public string fromDate{get;set;}
    public string toDate{get;set;}
    
    public static string serviceErrorMessage{get;set;}
    public static Boolean isConServiceAvailable{get;set;}
        
    public static string caname{get;set;}
    public static string caID{get;set;}
    public static string casorg{get;set;}
    
    public ViewMoreController(){
        
        accountId = ApexPages.currentPage().getParameters().get('accId');
        accID = accountId;
        returnContractsCount = '100'; 
        contractStatus = null;
        contractSrNo = null;
        contractNumber = null;
        isOnMore = True;
        /*date curEnDate = date.today();
        date curStDate = curEnDate.addMonths(-12);
        fromDate = string.valueof(curStDate);
        toDate = string.valueof(curEnDate);
        fromDate = fromDate.replace('-','/');
        toDate = toDate.replace('-','/');      
        contractsFromDate = String.valueof(curStDate);
        contractsFromDate = contractsFromDate.replace('-','');
        contractsToDate = String.valueof(curEnDate);
        contractsToDate = contractsToDate.replace('-',''); */
        contractsFromDate = '20000101';
        contractsToDate = '20991201';
        
        newURL = String.valueof(System.URL.getSalesforceBaseUrl().getHost());
        
        //accId=001560000038B6pAAE&from=CS&isQuote=false&status=OFF%20RENT&fromdt=2016/02/11&todt=2016/02/10&srno=232
        
        String conStatus = ApexPages.currentPage().getParameters().get('status');
        String conFromDt = ApexPages.currentPage().getParameters().get('fromdt');
        String conToDt   = ApexPages.currentPage().getParameters().get('todt');
        String conNumber = ApexPages.currentPage().getParameters().get('srno');
        String fltr = ApexPages.currentPage().getParameters().get('fromFilter');
        
        if(fltr == 'YES')
        {
            contractsFromDate = '';
            contractsToDate   = '';
        }
        
        if(conStatus != null && conStatus != '')
        {
            contractStatus =  conStatus;   
        } 
        
        if(conFromDt != null && conFromDt != '')
        {
            if(conToDt == null || conToDt == '')
            {
                fromDate = conFromDt;
                conFromDt = conFromDt.replace('/','-');
                Date dt = Date.valueof(conFromDt);
                Date newDt = dt.addMonths(12);
                //contractsToDate = String.valueof(newDt.year()) + String.valueof(newDt.month()) + String.valueof(newDt.day());
                contractsToDate = String.valueof(newDt);
                contractsToDate = contractsToDate.replace('-','');
            } 
            fromDate = conFromDt;
            conFromDt = conFromDt.replace('/','');
            contractsFromDate =  conFromDt; 
             
        }
        
        if(conToDt != null && conToDt != '')
        {
            if(conFromDt == null || conFromDt == '')
            {
                toDate = conToDt;
                conToDt = conToDt.replace('/','-');
                Date dt = Date.valueof(conToDt);
                Date newDt = dt.addMonths(-12);
                //contractsFromDate = String.valueof(newDt.year()) + String.valueof(newDt.month()) + String.valueof(newDt.day());
                contractsFromDate = String.valueof(newDt);
                contractsFromDate = contractsFromDate.replace('-','');
            } 
            toDate = conToDt;
            conToDt = conToDt.replace('/','');
            contractsToDate =  conToDt;   
        }
        
        if(conNumber != null && conNumber != '')
        {
            contractNumber =  conNumber;   
        }       
        
        //fetch the details for current acocunt 
        currentAccount = [SELECT Id, Name,recordtype.name,SAP_Bill_To__c,Sales_Org__c,PersonBirthdate,Valid_Billing_Address__c FROM Account  WHERE Id =:accID ];
        isBillingValid = Boolean.valueOf(currentAccount.Valid_Billing_Address__c);
        fromObject = ApexPages.currentPage().getParameters().get('from');
        listWrapQuoteHaeders = new List<QuoteHeaderWrapper>();
        listWrapQuoteHaeders1 = new List<QuoteHeaderWrapper>();
        listWrapQuoteHaeders = getQuotes1();
        listWrapQuoteHaeders1 = listWrapQuoteHaeders;
        salesOrgID = currentAccount.Sales_Org__c ;
        subtableval = false;
        subtablevalcontract = false;
        mapStringtoObject = new Map<String,List<String>>();
        mapStringtoObject.put('QU',new List<String>{'MMI_Full_Quotes_UK__c','Account__c'});
        mapStringtoObject.put('CS',new List<String>{'Service_Order_Request__c','Account_Name__c'});
        mapStringtoObject.put('SOR',new List<String>{'Service_Order_Request__c','Account_Name__c'});
        mapStringtoObject.put('NPS',new List<String>{'Net_Promoter_Score__c','Account__c'});
        
        
        listFiledSetFileds = new List<String>();
        
        result = new List<Sobject>();
        fieldsetMem = readFieldSet('Account_Dashboard',mapStringtoObject.get(fromObject)[0]); 
        queryFields(fieldsetMem); 
        
        List<Wrapperforcontracts> contractsList = new List<Wrapperforcontracts>();
        latestContractsList = new List<Wrapperforcontracts>();
        isConServiceAvailable = true;
        serviceErrorMessage = '';
        contractsList = getContracts(currentAccount.SAP_Bill_To__c,currentAccount.recordtype.name,returnContractsCount,contractsFromDate,contractsToDate,contractStatus,contractSrNo,contractNumber);
        //contractsList.sort();
        
        for(Integer i = 0; i<=contractsList.size()-1;i++)
        {
            latestContractsList.add(contractsList.get(i));
        }
        //fetch cpq and portal url from custom setting
        cpqURL = '';
        portalURL = '';
        String curHost = System.URL.getSalesforceBaseUrl().getHost();
        for(CPQActiveURL__c cu: CPQActiveURL__c.getAll().values()){
            if(curHost.containsignorecase(cu.Environment__c)){
                cpqURL = cu.CPQ_URL__c;
                portalURL = cu.Portal_URL__c;
            }
        } 
        
        caname = currentAccount.name;
        caname = caname.replace('\'','');
        caid = currentAccount.id;
        casorg = currentAccount.Sales_Org__c;
        
    } //end of constructor ViewMoreController
   
    //Ankur: return account ID to angularJS on QuoteMore page
    public static String getAccID(){
        return JSON.serialize(accID);
    }
    
    //Ankur: return all quotes list to angularJS on QuoteMore page
    public static String getAllQuotes(){
        return JSON.serialize(listWrapQuoteHaeders1);
    }
   
    //Ankur: return all contracts list to angularJS on QuoteMore page  
    public String getAllContracts(){
        return JSON.serialize(latestContractsList);
    } 
    
    public void getVAl(){
        subtableval = true;
    }
    
    //Ankur- Returns contract status Select List
    public List<SelectOption> getContractStatusList() {
        List<SelectOption> conStatusList = new List<SelectOption>();
        conStatusList.add(new SelectOption('','--- Select Status ---'));
        conStatusList.add(new SelectOption('PENDING','Pending'));
        conStatusList.add(new SelectOption('PENDING W/DELIV','Pending w/Deliv'));
        conStatusList.add(new SelectOption('ON RENT','On Rent'));
        conStatusList.add(new SelectOption('OFF RENT','Off Rent'));
        conStatusList.add(new SelectOption('CREDIT REVIEW','Credit Review'));
        conStatusList.add(new SelectOption('INVALID SALES ORDER','Invalid Sales Order'));
        conStatusList.add(new SelectOption('REJECTED','Rejected'));
        conStatusList.add(new SelectOption('SOLD','Sold'));
        conStatusList.add(new SelectOption('RETURNED','Returned'));
        conStatusList.add(new SelectOption('ORNPU','ORNPU'));
        
        return conStatusList;
        
    } //end of getContractStatusList
    
    public void applyContractFilters()
    {
        //if(contractSrNo != null){
        //    latestContractsList = new List<Wrapperforcontracts>();
        //}else{
        isOnMore = false;
        List<Wrapperforcontracts> contractsList = new List<Wrapperforcontracts>();
        latestContractsList = new List<Wrapperforcontracts>();
        contractsFromDate = '20000101';
        contractsToDate = '20991201';
        contractStatus = 'ON RENT';
        contractSrNo = null;
        contractNumber = null;
        contractsList = getContracts(currentAccount.SAP_Bill_To__c,currentAccount.recordtype.name,returnContractsCount,contractsFromDate,contractsToDate,contractStatus,contractSrNo,contractNumber);
        contractsList.sort();
        for(Integer i = contractsList.size()-1; i>=0;i--)
        {
            latestContractsList.add(contractsList.get(i));
        }
        newURL = String.valueof(System.URL.getSalesforceBaseUrl().getHost());
      //}          
    }
    
    public void resetContractFilters()
    {
        contractStatus =null;
        contractSrNo = null;
        List<Wrapperforcontracts> contractsList = new List<Wrapperforcontracts>();
        latestContractsList = new List<Wrapperforcontracts>();
        contractsList = getContracts(currentAccount.SAP_Bill_To__c,currentAccount.recordtype.name,returnContractsCount,contractsFromDate,contractsToDate,contractStatus,contractSrNo,contractNumber);
        contractsList.sort();
        for(Integer i = contractsList.size()-1; i>=0;i--)
        {
            latestContractsList.add(contractsList.get(i));
        }   
    }
      
    //Shankar - Get list of latest 5 Quotes for the accountid.
    //Ankur- Returns a list of QuoteHeader and related QuoteItemLevel Records for the accountid.
  /*  public LIST<QuoteHeaderWrapper> getQuotes(){
        Quote_Item_Level__c QIL= new Quote_Item_Level__c();
        List<Quote_Header__c> recentQuotesList = new List<Quote_Header__c>();
        List<Quote_Item_Level__c> quoteitemlist = new List<Quote_Item_Level__c>();
        
        //iterate through each quote record corresponding to current account and add to quotes List being displayed on more page(used in QuoteMore VF Page)
        for(Quote_Header__c quoteRecord : [SELECT Account__c,Id,Opportunity__c, Name, Contact__c,Status__c, Branch__c,Start_Date__c,Delivery_Charge__c,Delivery_City__c,Delivery_Date__c,Total_Initial_Charges__c,Shipto_State__c,
                                           (SELECT Id,Product_Id__c,Actual_Amount__c,Description__c,Item_Code__c,Unit_Type__c,Type__c,Quantity__c FROM Quote_Item_Levels__r 
                                           
                                           Order by LastModifiedDate Desc) FROM Quote_Header__c
                                           WHERE Account__c=:accountId and Status__c in ('Open','Lost','Won') and Opportunity__c != null Order by LastModifiedDate Desc]){
            
            recentQuotesList.add(quoteRecord); 
        } //where Description__c in ('Pickup Charge','Delivery Charge','Base Rental Rate')
         
        integer i=0;
        List<QuoteHeaderWrapper> listWrapQuoteHaeder = new List<QuoteHeaderWrapper>();
        for(Quote_Header__c QHeader:recentQuotesList)
        {
            if(i > 999 )
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
    } // end of getQuotes
    */
    private LIST<QuoteHeaderWrapper> getQuotes1(){
        //String salesOrg = currentAccount.Sales_Org__c;
        Quote_Item_Level__c QIL= new Quote_Item_Level__c(); 
        List<Quote_Header__c> recentQuotes = new List<Quote_Header__c>();
        List<Quote_Item_Level__c> quoteitemlist = new List<Quote_Item_Level__c>();
        List<Quote_Sub_Item_Level__c> quoteSubItemList; // = new List<Quote_Sub_Item_Level__c>();
        Set<ID> currentAccQuoteIDSet = new Set<ID>();
        Map<ID,Decimal> lineItemEnteredAmt = new map<ID,Decimal>();
                               
        //iterate through each quote corresponding to the current account ID and add it to quotes list which is 
        //used on the dashboard to display the quotes
        for(Quote_Header__c quoteRecord : [SELECT Id, Opportunity__c, Name, Contact__c,Status__c,createddate,Fulfilling_Branch_Name__c,Branch__c,Start_Date__c,Delivery_Charge__c,Delivery_City__c,Delivery_Date__c,Total_Initial_Charges__c,Shipto_State__c,
                                           (SELECT Id,Name,Product_Id__c,Actual_Amount__c,Description__c,Item_Code__c,Unit_Type__c,Type__c,Quantity__c,Quote_Item_Number__c,Quote_Item_Higher_Level__c,Plant_ID__c  FROM Quote_Item_Levels__r 
                                           Order by Quote_Item_Number__c ASC) FROM Quote_Header__c
                                           WHERE Account__c=: currentAccount.Id and Status__c in ('Open','Lost','Won') and Opportunity__c != null Order by LastModifiedDate Desc limit 1000]){
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
            
            if(qsli.Quantity__c != null &&  Integer.valueOf(qsli.Quantity__c) != 0)
            {
                actAmt = (qsli.Actual_Amount__c/qsli.Quantity__c);
                lineItemEnteredAmt.put(qsli.Quote_Item_level_ID__c,actAmt);
            }
            else{
                actAmt = 0.00;
                lineItemEnteredAmt.put(qsli.Quote_Item_level_ID__c,actAmt);
            }
            
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
                    if(lineItemEnteredAmt.containsKey(qilevel.ID))
                        qilevel.Actual_Amount__c = lineItemEnteredAmt.get(qilevel.ID);
                    else
                        qilevel.Actual_Amount__c = 0.00;
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
           
    public static List<Schema.FieldSetMember> readFieldSet(String fieldSetName, String ObjectName)
    {
        Map<String, Schema.SObjectType> GlobalDescribeMap = Schema.getGlobalDescribe(); 
        Schema.SObjectType SObjectTypeObj = GlobalDescribeMap.get(ObjectName);
        Schema.DescribeSObjectResult DescribeSObjectResultObj = SObjectTypeObj.getDescribe();
        system.debug('====>' + DescribeSObjectResultObj.FieldSets.getMap().get(fieldSetName));
        Schema.FieldSet fieldSetObj = DescribeSObjectResultObj.FieldSets.getMap().get(fieldSetName);
        return fieldSetObj.getFields(); 
    } //end of readFieldSet
   
    public void queryFields(List<Schema.FieldSetMember> fieldsetMem){
        String queryFields = '';
        for(Schema.FieldSetMember f : fieldsetMem) {
            if(queryFields.length() > 0) {
                queryFields += ', ';
            }
            queryFields += f.getFieldPath();
            listFiledSetFileds.add(f.getFieldPath());
        }
        String queryString;
        if(fromObject=='CS'){
            queryString =  ' SELECT id,' + queryFields + ',RecordType.name,Customer_Email_Address__c,Customer_Contact__r.name  FROM ' + mapStringtoObject.get(fromObject)[0] +' WHERE ( ' + mapStringtoObject.get(fromObject)[1] +'= \''+ accountId+'\' AND recordtype.name !=\'Service Order Request (ETS) 1500\' AND recordtype.name !=\'Service Order Request (MMI) 1000\' AND recordtype.name !=\'Service Order Request (WMI) 1501\' AND recordtype.name !=\'Service Order Request - (MMI UK) 1200\') Order by LastModifiedDate Desc';
        }
        else if(fromObject=='SOR'){
            queryString =  ' SELECT id,' + queryFields + ',createddate,RecordType.name,Customer_Email_Address__c,Customer_Contact__c  FROM ' + mapStringtoObject.get(fromObject)[0] +' WHERE ( ' + mapStringtoObject.get(fromObject)[1] +'= \''+ accountId+'\' AND(recordtype.name =\'Service Order Request (ETS) 1500\' OR recordtype.name =\'Service Order Request (MMI) 1000\' OR recordtype.name =\'Service Order Request (WMI) 1501\' OR recordtype.name =\'Service Order Request - (MMI UK) 1200\')) Order by LastModifiedDate Desc';
        }
        else{
            //Query the records you want to display
            queryString =  ' SELECT id,' + queryFields + ' FROM ' + mapStringtoObject.get(fromObject)[0] +' WHERE ' + mapStringtoObject.get(fromObject)[1] +'= \''+ accountId+'\'';
        }
        this.result = Database.query(queryString);
    } // end of queryFields
    
    
    //jailabdin -Wrapper class to process QuoteHeader and Quoteitemlevel records
    public class QuoteHeaderWrapper
    {
        public Quote_Header__c quoteHeader{get;set;}
        public String prodId{get;set;}
        public Decimal AclamtId{get;set;}
        public String QHStartDate{get;set;}
        public String QHDelDate {get;set;}
        public String quoteCreateDate {get;set;}
        public integer delDateFilter{get;set;}
        public integer quoteCreatetFilter{get;set;}
        public String plantCode{get;set;}
        
        public QuoteHeaderWrapper(Quote_Header__c QH,String pid,Decimal actid,String recTypeName,String plantCode)
        {
            quoteHeader = QH;
            prodId = pid;
            AclamtId = actid;
            QHStartDate = '';
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
                String tempQHDate1 = recTypeName.containsIgnoreCase('UK')?startDateTime.format('yyyy/MM/dd HH:mm:ss',userTimeZone):startDateTime.format('yyyy/MM/dd HH:mm:ss',userTimeZone);
                String delDate1 = tempQHDate1.split(' ')[0];
                String dldt = delDate1.replace('/','');
                this.delDateFilter = integer.valueof(dldt);
                
            }
            
            if(QH.createddate != null)
            {
                DateTime startDateTime = datetime.newInstance(QH.createddate.year(),QH.createddate.month(),QH.createddate.day()); 
                String userTimeZone = String.valueOf(UserInfo.getTimeZone());
                String tempQHDelDate = recTypeName.containsIgnoreCase('UK')?startDateTime.format('dd/MM/yyyy HH:mm:ss',userTimeZone):startDateTime.format('MM/dd/yyyy HH:mm:ss',userTimeZone);
                quoteCreateDate = tempQHDelDate.split(' ')[0];
                String tempQHDate1 = recTypeName.containsIgnoreCase('UK')?startDateTime.format('yyyy/MM/dd HH:mm:ss',userTimeZone):startDateTime.format('yyyy/MM/dd HH:mm:ss',userTimeZone);
                String delDate1 = tempQHDate1.split(' ')[0];
                String dldt = delDate1.replace('/','');
                this.quoteCreatetFilter = integer.valueof(dldt);
                
            }
        
        }
    } //end of class QuoteHeaderWrapper
    
    
    //Ankur - Get list of latest Contracts for the accound by consuming SOAP service.
    public static LIST<Wrapperforcontracts> getContracts(String sapID,String recName,String returnContractsCount,String contractsFromDate,String contractsToDate,String contractStatus,String contractSrNo,String contractNumber){
              
        LIST<Wrapperforcontracts> tempData = new LIST<Wrapperforcontracts>();
        try{
            if(sapID != '' && sapID != null)          {
                List<WrapperContractItems> contractItemsList; // = new List<WrapperContractItems>();
                //LIST<sapComDocumentSapRfcFunctions.ZSD_ORDER_HEADER> dataContrcts = new LIST<sapComDocumentSapRfcFunctions.ZSD_ORDER_HEADER>(); 
                sapComDocumentSapRfcFunctions.ZSD_CONTRACT_SEARCH_Response_element dataContrcts = new sapComDocumentSapRfcFunctions.ZSD_CONTRACT_SEARCH_Response_element();
                dataContrcts = DataForcontracts.fetchContractsFromResponse(sapID,returnContractsCount,contractsFromDate,contractsToDate,contractStatus,contractSrNo,contractNumber);
                if( dataContrcts.T_CONTRACT_HEADERS.item.size() > 0   ) {  //size() > 0   ) {
                    String contractHeaderPlant = '';
                    String contractHeaderMaterial = '';
                     String contractHeaderFulDepot = '';
                     string goodsIssueDate = '';
                    for(sapComDocumentSapRfcFunctions.ZSD_ORDER_HEADER temp : dataContrcts.T_CONTRACT_HEADERS.item){  //dataContrcts){
                        contractItemsList = new List<WrapperContractItems>();            
                        if(temp.orderitems.size() > 0)
                        {
                            contractHeaderPlant = temp.orderitems[0].plant;
                            //contractHeaderMaterial = temp.orderitems[0].material;
                            contractHeaderFulDepot = temp.orderitems[0].Name1;
                            //goodsIssueDate = temp.orderitems[0].PGI_Date;
                            for(sapComDocumentSapRfcFunctions.ZSD_ORDER_ITEM torder : temp.orderitems){
                                contractItemsList.add(new WrapperContractItems(torder.contract, torder.itm_number, torder.status, torder.material, torder.short_text, torder.serial_number,torder.plant,torder.rate, torder.con_st_dat_l,torder.con_en_dat_l,recName,torder.PGI_Date,torder.Name1,torder.BILL_PLAN_REL));    
                                if(torder.PGI_Date != null && torder.PGI_Date != '' && torder.PGI_Date != '0000-00-00' && goodsIssueDate == '' && ( torder.status == 'ON RENT' || torder.status == 'ORNPU')  ){
                                    goodsIssueDate =  torder.PGI_Date;  
                                    contractHeaderMaterial = torder.material;
                                }
                                if(contractHeaderMaterial == '' && torder.status != 'REJECTED')
                                    contractHeaderMaterial = torder.material;  
                            } 
                            
                        }
                        tempData.add(new Wrapperforcontracts(temp.contract, temp.purch_no_c, temp.street, temp.city, temp.region, temp.postl_code,contractItemsList,contractHeaderPlant,contractHeaderFulDepot,contractHeaderMaterial,temp.con_st_dat_h,temp.con_en_dat_h,recName,goodsIssueDate,temp.credit_Block));
                        goodsIssueDate = '';
                        contractHeaderMaterial  =''; 
                    }
                }
                if(dataContrcts.T_RETURN.item.size() > 0)
                {
                    //system.debug('Service not avaliable, error: '+dataContrcts.T_RETURN.item[0].message);
                    serviceErrorMessage = dataContrcts.T_RETURN.item[0].message;
                    isConServiceAvailable = false;
                }
            }
         } //end of try
        catch(Exception e){
            return tempData;    
        }
        return tempData;
 } // end of getContracts
    
    //Ankur: Wrapper for contracts
    global class Wrapperforcontracts implements Comparable{
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
        public string con_st_dat{get;set;}
        public string con_en_dat{get;set;}
        public integer srNumber{get;set;}
        public integer endDate{get;set;}
        public string goodsIssueDate{get;set;}
        public integer gIssueDateFilter{get;set;}
        public string creditBlock{get;set;}
        
        public Wrapperforcontracts(String contract, String purch_no_c, string street, String city, String region, string postl_code,List<WrapperContractItems> contractItemsList,String contractHeaderPlant,string contractHeaderFulDepot,String contractHeaderMaterial,string con_st_dat,string con_en_dat,String recTypeName,string goodsIssueDate,string creditBlock){      
            
            this.contract= contract;
            
            //purch_no_c = purch_no_c.replace('!','');
            this.purch_no_c= purch_no_c.replace('!','');
            this.street= street;
            this.city = city;
            this.region= region; 
            this.postl_code= postl_code; 
            this.contractItems = new List<WrapperContractItems>();
            this.contractItems = contractItemsList; 
            this.plant = contractHeaderPlant;
            this.fulDepot = contractHeaderFulDepot;
            this.material = contractHeaderMaterial;
            
            if(creditBlock == 'X')
                this.creditBlock = 'Yes';
            else     
                this.creditBlock = 'No';
                
            if(con_st_dat != null && con_st_dat != '' && con_st_dat != '0000-00-00')
            {
                Date dt = Date.valueof(con_st_dat);
                DateTime startDateTime = datetime.newinstance(dt.year(),dt.month(),dt.day()); 
                String userTimeZone = String.valueOf(UserInfo.getTimeZone());
                String tempQHDate = recTypeName.containsIgnoreCase('UK')?startDateTime.format('dd/MM/yyyy HH:mm:ss',userTimeZone):startDateTime.format('MM/dd/yyyy HH:mm:ss',userTimeZone);
                String stDate = tempQHDate.split(' ')[0];
                //stDate = stDate.replace('/','-');
                this.con_st_dat = stDate; //Date.valueof(stDate);
                String tempQHDate1 = recTypeName.containsIgnoreCase('UK')?startDateTime.format('yyyy/MM/dd HH:mm:ss',userTimeZone):startDateTime.format('yyyy/MM/dd HH:mm:ss',userTimeZone);
                String stDate1 = tempQHDate1.split(' ')[0];
                String stdt = stDate1.replace('/','');
                this.srNumber = integer.valueof(stdt);
            }
            //else
            //    this.con_st_dat = '';    
            
            if(con_en_dat != null && con_en_dat != '' && con_en_dat != '0000-00-00')
            {
                Date dt = Date.valueof(con_en_dat);
                DateTime startDateTime = datetime.newinstance(dt.year(),dt.month(),dt.day()); 
                String userTimeZone = String.valueOf(UserInfo.getTimeZone());
                String tempQHDate = recTypeName.containsIgnoreCase('UK')?startDateTime.format('dd/MM/yyyy HH:mm:ss',userTimeZone):startDateTime.format('MM/dd/yyyy HH:mm:ss',userTimeZone);
                String enDate = tempQHDate.split(' ')[0];
                //enDate = enDate.replace('/','-');
                this.con_en_dat = enDate; //Date.valueof(enDate);
                String tempQHDate1 = recTypeName.containsIgnoreCase('UK')?startDateTime.format('yyyy/MM/dd HH:mm:ss',userTimeZone):startDateTime.format('yyyy/MM/dd HH:mm:ss',userTimeZone);
                String enDate1 = tempQHDate1.split(' ')[0];
                String endt = enDate1.replace('/','');
                this.endDate = integer.valueof(endt);
            }
            
            if(goodsIssueDate != null && goodsIssueDate != '' && goodsIssueDate != '0000-00-00')
            {
                Date dt = Date.valueof(goodsIssueDate);
                DateTime startDateTime = datetime.newinstance(dt.year(),dt.month(),dt.day()); 
                String userTimeZone = String.valueOf(UserInfo.getTimeZone());
                String tempQHDate = recTypeName.containsIgnoreCase('UK')?startDateTime.format('dd/MM/yyyy HH:mm:ss',userTimeZone):startDateTime.format('MM/dd/yyyy HH:mm:ss',userTimeZone);
                this.goodsIssueDate = tempQHDate.split(' ')[0];
                
                String tempQHDate1 = recTypeName.containsIgnoreCase('UK')?startDateTime.format('yyyy/MM/dd HH:mm:ss',userTimeZone):startDateTime.format('yyyy/MM/dd HH:mm:ss',userTimeZone);
                String stDate1 = tempQHDate1.split(' ')[0];
                String stdt = stDate1.replace('/','');
                this.gIssueDateFilter = integer.valueof(stdt);
            }
            
            
           // else
           //     this.con_en_dat = '';
        }
        global Integer compareTo(Object ObjToCompare) {
            return contract.CompareTo(((Wrapperforcontracts)ObjToCompare).contract);
        }
    } //end of class Wrapperforcontracts 

    //Ankur: Wrapper for contract items
    public class WrapperContractItems{
        public string contract{get;set;}
        public string itm_number{get;set;}
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
        
        public WrapperContractItems(String contract, String itm_number, string status, String material, String short_text, string serial_number,String plant,string rate, string con_st_dat,string con_en_dat,String recTypeName,string goodsIssueDate,string fulDepot,string billingPlanRel){
            this.contract= contract;
            this.itm_number= itm_number;
            this.status= status;
            this.material= material;
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
        }    
    } //end of class WrapperContractItems

} //end of class ViewMoreController