/**
* (c) 2015 TEKsystems Global Services
*
* Name           : QuotePDF_US
* Created Date   : 06 Nov, 2015
* Created By     : Ankur Goyal (TEKSystems)
* Purpose        : Controller class used by 'QuotePDF_US' VF page.
* Last Updated By: Jailabdin shaik (TEKSystems)
* Last Updated Date: 17-Mar-2016
**/

global class QuotePDFCtrl{

    public Branch_Lookup__c brlkp{get;set;}
    public Weekly_Snapshot_Branch_Report__c brWklySnap{get;set;}
    public User usrDetails{get;set;}
    public List<User> usrDetails1{get;set;}
    public Contact delDetails{get;set;}
    //public Account custDetails{get;set;}
    public List<Qilwrapper> quoteItems{get;set;}
    public List<Qilwrapper> quoteItems2{get;set;}
    public List<Qilwrapper> updatequoteItems{get;set;}
    public List<Qilwrapper> updatequoteItems2{get;set;}
    public List<Quote_Sub_Item_Level__c > quoteSubItems{get;set;}
    public String quoteID{get;set;} 
    public Boolean isRental{get;set;}   
    public Quote_Header__c qHeader{get;set;}
    public Date quoteDeldate{get;set;}
    public Date quoteValidTill{get;set;}
    public Date quoteEnddate{get;set;}
    public integer quoteNOofdates{get;set;}
    public Date quoteEnd{get;set;}
    public Date quoteStart{get;set;}
    public Date quoteReqStart{get;set;}
    public String type{get;set;}
    public string paymentTerms{get;set;}
    
    //public boolean checkchargeisthere{get; set;}
    
    //public boolean isDamageWaiver {get;set;}
    public list<string> listofcuststng {get; set;}
    public list<string> listofchgs {get; set;}
    public list<string> testlistofchgs {get; set;}
    public string slaesorgID {get; set;}
    public string pdftype {get; set;}
    public string currencysymbol{get; set;}
    public boolean shownormalitems {get; set;}
    public boolean showextendeditems {get; set;}
    //public string periodString{get;set;}
    public QuoteSummary quoteSum{get;set;}
    public boolean isOppClose{get;set;}
    
    public QuotePDFCtrl(){
        //current quote ID
        quoteID = ApexPages.currentPage().getParameters().get('id');
        //type of the PDF ie. Sales or Rental
        type = ApexPages.currentPage().getParameters().get('type');
        slaesorgID =ApexPages.currentPage().getParameters().get('salorg');
        pdftype =ApexPages.currentPage().getParameters().get('pdftype');
        updatequoteItems = new List<Qilwrapper>();
        updatequoteItems2 = new List<Qilwrapper>();
        if(type == 'rental')
            isRental = true; 
        else
            isRental = false;     
            
       // Map<String,Salesorg_Cond_Type__c> allCodes = Salesorg_Cond_Type__c.getAll();
       // list<Salesorg_Cond_Type__c> listofcharges = allCodes.values();  
        
        listofcuststng=new list<string>();
        
        testlistofchgs=new list<string>();
       /* for(Salesorg_Cond_Type__c sct :listofcharges ){
          
            if(sct.SalesOrgID__c == slaesorgID)
            {
                string test= sct.Column_Label__c;
                listofcuststng= test.split('\\;');
                string testcodes= sct.Charges__c;
                testlistofchgs= testcodes.split('\\;');
                currencysymbol=sct.Currency_Symbol__c;
                periodString = sct.Period__c;
            }
        }
        for(string trimstring:testlistofchgs)  {
            string teststring=trimstring.trim();
            listofchgs.add(teststring);
        }
       */ 
        if(pdftype=='normal'){
           shownormalitems= true;
        }
        else shownormalitems= false;
        
        if(pdftype=='extended'){
           showextendeditems= true;
        }
        else showextendeditems= false;
       
       
       if(slaesorgID=='1200'){
            listofchgs=new list<string>{'ZTOT'};
            currencysymbol='£';
       }
       
       
    }
        
    
    
    public PageReference getPDFContent(){
        
        quoteID = ApexPages.currentPage().getParameters().get('id');
        type = ApexPages.currentPage().getParameters().get('type');

         
        if(type == 'rental')
            isRental = true; 
        else
            isRental = false; 
        qHeader = new Quote_Header__c();
        //fetch the quote header information for the current quote to be used in geneating the quote PDF
        qHeader = [select  Name,createddate,Account__c,Account__r.name, Account__r.SAP_Bill_To__c,Billing_address__c, Billing_City__c, Billing_Country__c, Billing_Zip__c, Billling_State__c,Opportunity_Close_Date__c ,
                   Branch__c, Contact__c, Delivery_Charge__c, Delivery_City__c,Delivery_Date__c,How_long_do_you_need_your_unit_weeks__c, Billing_Email__c, Expected_rental_length_in_days__c, 
                   Expiry_Date__c,Fulfilling_Branch_Name__c, Rental_Length__c, Purchase_Order__c, Quote_Number__c, 
                   Other_Charges__c, Shipto_address__c, Shipto_City__c, Shipto_Country__c, Shipto_Mobile__c, Shipto_State__c,
                   Shipto_Zip__c, Start_Date__c, Total_Initial_Charges__c, Total_One_Time_Charges__c, Total_Rental_Charges__c, Transaction_Type__c, Type__c,
                   Unit_Purpose__c, Actual_Createdby__c,Quote_Comments__c from Quote_Header__c where ID=:quoteID ];   
        
        //quote items to display in the pdf corresponding to the current quote
            List<Quote_Item_Level__c> QilList = new List<Quote_Item_Level__c>();
            for(Quote_Item_Level__c qil:
                                        [select Actual_Amount__c,Quote_Item_Higher_Level__c, Frequency__c, Base_Amount__c,  Delivery_Date__c, Description__c, Item_Code__c,Period__c,Recurring__c, Quantity__c, ship_to__c, Type__c, Unit_Type__c,Quote_Item_Number__c,Serial_Number__c,Short_Text__c,Accessory__c,
                                         
                                        (select Actual_Amount__c,Entered_Amount__c, Frequency__c, Base_Amount__c,  Description__c, Item_Code__c, 
                                        Period__c, Quantity__c,  Type__c, Unit_Type__c,ADJ_COND_TYPE__c 
                                        from Quote_Sub_Item_Levels__r where Quote_Header__c =:quoteID order by Description__c asc)

                                        from Quote_Item_Level__c where Quote_Header__c =:quoteID  order by Quote_Item_Number__c asc]){
                                            
                QilList.add(qil);                           
            }
            
            List<QuoteSummary> quoteSummaryList = new List<QuoteSummary>();
            decimal rentalUnits = 0;
            decimal rentalChg = 0;
            Decimal delCount = 0;
            Decimal delTotal = 0;
            Decimal collTotal= 0;
            Decimal oneOff = 0;
            List<Quote_Sub_Item_Level__c> oneOffList = [select Actual_Amount__c from Quote_Sub_Item_Level__c where Quote_Header__c =:quoteID and ADJ_COND_TYPE__c in ('TOT2')];
            if(oneOffList.size() > 0 )
                oneoff = oneOffList[0].Actual_Amount__c;
            Decimal costTotal = 0; 
            List<Quote_Sub_Item_Level__c> costTotalList = [select Actual_Amount__c from Quote_Sub_Item_Level__c where Quote_Header__c =:quoteID and ADJ_COND_TYPE__c in ('TOT6','SLS1')];
            if(costTotalList.size() > 0 )
                costTotal = costTotalList[0].Actual_Amount__c;
            Decimal totalLLWCharges = 0;
            List<ProductTotals> prodTot = new List<ProductTotals>();
            Map<String,List<String>> prodSummaryMap = new Map<String,List<String>>();
            Integer mainItemNumber = 0;
            for(Quote_Item_Level__c qtl:QilList){
                
                List<Quote_Sub_Item_Level__c> Quotesubitemslist = new List<Quote_Sub_Item_Level__c>();
                List<Quote_Sub_Item_Level__c>  qsillist = qtl.Quote_Sub_Item_Levels__r;
                Map<String,String> condTypesubitemListMap= new Map<String,String>();
                // Map<String,String> condZPOOsubitemListMap= new Map<String,String>();    //new
                // condZPOOsubitemListMap.put('ZP00','--');  //new
                qtl.Quote_Item_Number__c = String.valueOf(Integer.valueOf(qtl.Quote_Item_Number__c));
                if(Integer.valueof(qtl.Quote_Item_Higher_Level__c) == 0){
                    mainItemNumber = Integer.valueof(qtl.Quote_Item_Number__c);
                } 
                
                if( qtl.Accessory__c != null && qtl.Accessory__c != '' && mainItemNumber != 0){
                    mainItemNumber = mainItemNumber + 5;
                    qtl.Quote_Item_Number__c = String.valueof(mainItemNumber);
                    mainItemNumber = mainItemNumber - 5;
                } 
                    
                for(string listofchgsVar:listofchgs){
                       condTypesubitemListMap.put(listofchgsVar, '--');
                }
                             
                for(Quote_Sub_Item_Level__c qsillistVar:qsillist){
                    Boolean isMainProd  = false;
                    Decimal ResultZPOO;
                    
                    if( Integer.valueof(qtl.Quote_Item_Higher_Level__c) == 0  && qsillistVar.ADJ_COND_TYPE__c == 'ZTOT'){
                        //isMainProd = True;
                        //ResultZPOO= (qsillistVar.Actual_Amount__c).setscale(2);
                        //condZPOOsubitemListMap.put(qsillistVar.ADJ_COND_TYPE__c,string.valueOf(ResultZPOO));
                        qsillistVar.ADJ_COND_TYPE__c = 'ZXYZ';    
                    }
                    
                    if( Integer.valueof(qtl.Quote_Item_Higher_Level__c) == 0  && (qsillistVar.ADJ_COND_TYPE__c == 'ZP00' || qsillistVar.ADJ_COND_TYPE__c == 'ZPMN' || qsillistVar.ADJ_COND_TYPE__c == 'ZPWK' || qsillistVar.ADJ_COND_TYPE__c == 'ZP30' || qsillistVar.ADJ_COND_TYPE__c == 'ZP01' || qsillistVar.ADJ_COND_TYPE__c == 'ZPDY') ){
                        isMainProd = True;
                        ResultZPOO= (qsillistVar.Actual_Amount__c).setscale(2);
                        //condZPOOsubitemListMap.put(qsillistVar.ADJ_COND_TYPE__c,string.valueOf(ResultZPOO));
                        qsillistVar.ADJ_COND_TYPE__c = 'ZTOT';    
                    }
                                        
                    if('Total Delivery'.equalsignorecase(qsillistVar.Description__c)){
                        delCount = delCount + qsillistVar.Quantity__c; 
                        delTotal = delTotal + qsillistVar.Actual_Amount__c; 
                    }
                    
                    if('Total Pickup'.equalsignorecase(qsillistVar.Description__c) && qheader.Type__c != 'ZSLS' ){
                        //delCount = qsillistVar.Quantity__c; 
                        collTotal = collTotal + qsillistVar.Actual_Amount__c; 
                    }
                    
                    if('TOT2'.equalsignorecase(qsillistVar.ADJ_COND_TYPE__c)){
                        //delCount = qsillistVar.Quantity__c; 
                        oneOff = qsillistVar.Actual_Amount__c; 
                    }
                    
                    if(condTypesubitemListMap.containsKey(qsillistVar.ADJ_COND_TYPE__c)){
                         
                        if(Integer.valueof(qtl.Quote_Item_Higher_Level__c) == 0 || (qtl.Accessory__c != null && qtl.Accessory__c != '' && qtl.Recurring__c != null && qtl.Recurring__c != '' ) ){ //
                        
                            if(prodSummaryMap.containsKey(qtl.Item_Code__c)){
                                List<string> prodSumList = prodSummaryMap.get(qtl.Item_Code__c);
                                String descr = prodSumList.get(0);
                                Decimal qty = Decimal.valueof(prodSumList.get(1));
                                Decimal amt = Decimal.valueof(prodSumList.get(2));
                                qty = qty + qtl.Quantity__c;
                                amt = amt + qsillistVar.Actual_Amount__c;
                                List<string> prodSumList1 = new List<string>();
                                prodSumList1.add(descr);
                                prodSumList1.add(string.valueof(qty));
                                prodSumList1.add(string.valueof(amt));
                                prodSummaryMap.put(qtl.Item_Code__c,prodSumList1);
                            }
                            else{
                                String descr = qtl.Description__c;
                                Decimal qty = qtl.Quantity__c;
                                Decimal amt = qsillistVar.Actual_Amount__c;
                                List<string> prodSumList1 = new List<string>();
                                prodSumList1.add(descr);
                                prodSumList1.add(string.valueof(qty));
                                prodSumList1.add(string.valueof(amt));
                                prodSummaryMap.put(qtl.Item_Code__c,prodSumList1);    
                            }
                        
                            //String pdesc = 'Total of ' +qtl.Description__c;
                            //decimal quantity = 0;
                            //decimal actAmt = 0;
                            rentalUnits = rentalUnits + qtl.Quantity__c;
                            rentalChg = rentalChg + qsillistVar.Actual_Amount__c;
                            
                            //if(qtl.Quantity__c > 0)
                            //    quantity =  qtl.Quantity__c;
                            //if(qsillistVar.Actual_Amount__c > 0)       
                            //    actAmt = qsillistVar.Actual_Amount__c;
                            //prodTot.add(new ProductTotals(pdesc,'-','Master Number',String.valueof(quantity),string.valueof(actAmt)) );    
                        } 
                         
                                    
                        //integer actamountVar = integer.valueOf(qsillistVar.Actual_Amount__c);
                        //condTypesubitemListMap.put(qsillistVar.ADJ_COND_TYPE__c,string.valueOf(actamountVar));
                        if(qsillistVar.ADJ_COND_TYPE__c =='ZTOT'){
                          if( !isMainProd ){
                              Decimal Result= (qsillistVar.Actual_Amount__c).setscale(2);
                              condTypesubitemListMap.put(qsillistVar.ADJ_COND_TYPE__c,string.valueOf(Result));
                          }
                          else{
                              condTypesubitemListMap.put(qsillistVar.ADJ_COND_TYPE__c,string.valueOf(ResultZPOO));
                          }
                        }
                        
                    }
                    
                    if( 'ZLLW'.equalsignorecase(qsillistVar.ADJ_COND_TYPE__c) && qheader.Type__c != 'ZSLS' && qsillistVar.Actual_Amount__c > 0  ){    
                        Quotesubitemslist.add(qsillistVar);
                        if('ZLLW'.equalsignorecase(qsillistVar.ADJ_COND_TYPE__c)){
                            totalLLWCharges = totalLLWCharges + qsillistVar.Actual_Amount__c;
                        }    
                    }
                    
                    
                }
                    
                    system.debug('items are.....'+qtl+''+Quotesubitemslist);
                    //if(!isMainProd)
                    updatequoteItems.add(new Qilwrapper(qtl,condTypesubitemListMap.values(),Quotesubitemslist));
                   // if(isMainProd)
                    //    updatequoteItems.add(new Qilwrapper(qtl,condZPOOsubitemListMap.values(),Quotesubitemslist));    
                    system.debug('updatequoteItems..........'+updatequoteItems);
                   
            }
            //costTotal = rentalChg + delTotal + collTotal + oneOff + totalLLWCharges;
            
            for(String iCode : prodSummaryMap.keySet())
            {
                List<string> prodValues = prodSummaryMap.get(iCode);
                String descr = 'Total of ' + prodValues.get(0);
                Decimal qty = Decimal.valueof(prodValues.get(1));
                Decimal amt = Decimal.valueof(prodValues.get(2));
                prodTot.add(new ProductTotals(descr,'-','Master Number',String.valueof(qty),string.valueof(amt)) );        
            }
            
            quoteSummaryList.add(new  QuoteSummary(string.valueof(rentalUnits),string.valueof(rentalChg),string.valueof(delCount),string.valueof(delTotal),string.valueof(collTotal),string.valueof(oneOff),string.valueof(costTotal),string.valueof(totalLLWCharges),prodTot) );
            quoteSum = quoteSummaryList[0];
            
            system.debug('updatequoteItems outside..........'+updatequoteItems);
             quoteItems = new List<Qilwrapper>();
            quoteItems.addall(updatequoteItems);
            quoteItems.sort();
            system.debug('quoteItems.......'+quoteItems);
            // quoteItems2=updatequoteItems2;
                      
                  
        
        quoteSubItems = [select Actual_Amount__c,Entered_Amount__c,Frequency__c,Base_Amount__c,Description__c,Item_Code__c,Period__c,Quantity__c,
                         Type__c,Unit_Type__c,Quote_Item_Number__c,ADJ_COND_TYPE__c from Quote_Sub_Item_Level__c where Quote_Header__c=:quoteID and Quote_Item_Number__c = '999999' and ADJ_COND_TYPE__c !='TOT6' order by ADJ_COND_TYPE__c asc];
        if(quoteSubItems.isEmpty()){
            Quote_Sub_Item_Level__c qsil=new Quote_Sub_Item_Level__c();
            qsil.Description__c='No Total charges found';
            qsil.Entered_Amount__c=0.0;
            quoteSubItems.add(qsil);
        }
        
        brWklySnap = new Weekly_Snapshot_Branch_Report__c();
        brlkp = new Branch_Lookup__c();
        if(qHeader.Branch__c != '' && qHeader.Branch__c != null){
            String branchCode = qHeader.Branch__c;
            String zipCode = qHeader.Billing_Zip__c;
            List<Branch_Lookup__c> br = new List<Branch_Lookup__c >(); 
            //fetch branch related information corresponding to the quote header branch code
            br = [select City__c, Country__c, County__c, State__c, Zip__c, Selling_Region__c, 
                     Branch_Title__c, Branch_Name__c, Branch_Code__c  from Branch_Lookup__c where Branch_Code__c= :branchCode and Zip__c=:zipCode limit 1]; 
            if(br.size() > 0)
                brlkp = br[0]; 
            List<Weekly_Snapshot_Branch_Report__c>  brsnap = [select City__c,Country__c,County__c,State__c,Street__c,Zipcode__c,BranchId__c
                                 from Weekly_Snapshot_Branch_Report__c where BranchId__c=:branchCode] ;
             if(brsnap.size() > 0)
                 brWklySnap  = brsnap[0];
                        
        }
        system.debug('userid.....'+qHeader.Actual_Createdby__c);
        usrDetails = new User();
        if(qHeader.Actual_Createdby__c != null){
            
            string userID = qHeader.Actual_Createdby__c;
            //fetch user details corresponding to the quote header createdby Id
            
            usrDetails1 = [Select Id,Email, Fax, Phone, street,city,state,postalcode, Extension__c, Name, Sales_Rep_Id__c from User where ID =: userID limit 1]; 
            if(usrDetails1.size() > 0)
                usrDetails= usrDetails1[0];
            
        }
        
        delDetails = new Contact();
        if(qHeader.Contact__c != null){
            String conID = qHeader.Contact__c;
            //fetch contact details corresponding to the quote header Contact ID
            delDetails = [select Email, Name, Phone from Contact where ID = :conID];  
        }
        
        //paymentTerms = qHeader.Any_payroll_requirements__c;
        quoteDeldate = date.valueOf(qHeader.createddate);
        quoteValidTill = date.valueOf(qHeader.createddate).addDays(30);
        quoteEnddate = date.valueOf(qHeader.Start_Date__c);
        if(qHeader.Opportunity_Close_Date__c != null ){
            quoteStart = date.valueOf(qHeader.Opportunity_Close_Date__c);
            isOppClose = true;
        }    
        quoteEnd = date.valueOf(qHeader.Expiry_Date__c);
        quoteReqStart = date.valueOf(qHeader.Delivery_Date__c);
       // if(qHeader.How_long_do_you_need_your_unit_weeks__c!= null != null && qHeader.How_long_do_you_need_your_unit_weeks__c!= null != '')
        //    quoteHowlong        
        
        if(qHeader.Start_Date__c !=null && qHeader.How_long_do_you_need_your_unit_weeks__c!= null){
            quoteNOofdates=  qHeader.Start_Date__c.daysBetween(qHeader.How_long_do_you_need_your_unit_weeks__c)+1;
        }
        //quoteEnd = date.valueof(qHeader.Expiry_Date__c);
        /*if(qHeader.Expiry_Date__c == null  && quoteDeldate != null){
            qHeader.Expiry_Date__c = qHeader.Start_Date__c.addDays(30);
            quoteEnd = date.valueOf(qHeader.Expiry_Date__c);
        }*/
        //if(qHeader.Expiry_Date__c != null){
        //    quoteEnd = date.valueOf(qHeader.Expiry_Date__c);    
        //}
            
        return null;
        //end of getPDFContent
    }
    
    Global class Qilwrapper implements Comparable{
        public Quote_Item_Level__c Quoteitemlevels{get; set;}
        public integer itemNumber{get;set;}
        public list<string> itemchargs {get; set;}
        public List<Quote_Sub_Item_Level__c> subitemlist {get; set;}
        
        public Qilwrapper(Quote_Item_Level__c QuItLe,List<string> chargs,List<Quote_Sub_Item_Level__c> Quotsubitemslist){
            
            Quoteitemlevels=QuItLe;
            itemchargs = chargs;
            subitemlist = Quotsubitemslist;
            itemNumber = Integer.Valueof(QuItLe.Quote_Item_Number__c);
        }
        
        global Integer compareTo(Object ObjToCompare) {
            Qilwrapper compareQilwrapper = (Qilwrapper)ObjToCompare;
            if(itemNumber == compareQilwrapper.itemNumber) return 0;
            if(itemNumber > compareQilwrapper.itemNumber) return 1;
            return -1;
            //return itemNumber.CompareTo(((Qilwrapper)ObjToCompare).itemNumber);
        }
    }
    
    public class QuoteSummary{
        public string totalRentalUnits{get; set;}
        public string totalRentalCharges{get; set;}
        public string delCount{get; set;}
        public string deliveryTotal{get; set;}
        public string collectionTotal{get; set;}
        public string oneOffCosts{get; set;}
        public string totalCosts{get; set;}
        public string totalLLWCharges{get; set;}
        public List<ProductTotals> productTots{get;set;}
        
        public QuoteSummary(String totalRentalUnits,String totalRentalCharges,String delCount,String deliveryTotal,String collectionTotal,String oneOffCosts,String totalCosts,String totalLLWCharges,List<ProductTotals> productTots){
            this.totalRentalUnits = totalRentalUnits;
            this.totalRentalCharges = totalRentalCharges;
            this.delCount = delCount;
            this.deliveryTotal = deliveryTotal;
            this.collectionTotal = collectionTotal;
            this.oneOffCosts = oneOffCosts;
            this.totalCosts = totalCosts;
            this.totalLLWCharges = totalLLWCharges;
            this.productTots = productTots;        
        }
    }
    
    public class ProductTotals{
        public string productDesc{get;set;}
        public string mmiNo{get;set;}
        public string item{get;set;}
        public string quantity{get;set;}
        public string ratePrice{get;set;}
        
        public ProductTotals(string productDesc,string mmiNo,string item,string quantity,string ratePrice){
            this.productDesc = productDesc;
            this.mmiNo = mmiNo;
            this.item = item;
            this.quantity = quantity;
            this.ratePrice = ratePrice;
        }
     }
    
    
}  //end of class QuotePDF_US