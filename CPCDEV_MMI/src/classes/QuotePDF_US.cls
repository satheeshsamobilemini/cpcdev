/**
* (c) 2015 TEKsystems Global Services
*
* Name           : QuotePDF_US
* Created Date   : 06 Nov, 2015
* Created By     : Ankur Goyal (TEKSystems)
* Purpose        : Controller class used by 'QuotePDF_US' VF page.
* Last Updated By: Chaitanya Ranade (TEKSystems)
* Last Updated Date: 18-Oct-2016
**/

public class QuotePDF_US{

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
    public Date quoteEnddate{get;set;}
    public integer quoteNOofdates{get;set;}
    public Date quoteEnd{get;set;}
    public String type{get;set;}
   
    
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
    public string showTOC{get;set;}
    //public string periodString{get;set;}
    public boolean isETS{get;set;}
    public String showWMIAcc{get;set;}
    
    public Boolean showlumpSum{get;set;}
    
    public QuotePDF_US(){
        //current quote ID
        quoteID = ApexPages.currentPage().getParameters().get('quoteid');
        //type of the PDF ie. Sales or Rental
        type = ApexPages.currentPage().getParameters().get('type');
        slaesorgID =ApexPages.currentPage().getParameters().get('salorg');
        pdftype =ApexPages.currentPage().getParameters().get('pdftype');
        showTOC =ApexPages.currentPage().getParameters().get('toc');
        string accFlag = ApexPages.currentPage().getParameters().get('accflag');
        String lmpsm = ApexPages.currentPage().getParameters().get('lumpSum');
        if(accFlag == null || accFlag == '' || accFlag == 'No')
            showWMIAcc = 'No';
        else
            showWMIAcc = 'Yes';
        if(lmpsm == null || lmpsm == '' || lmpsm == 'No')
            showlumpSum = false;
        else
            showlumpSum = true;  
        if(slaesorgID == '1500')  
        {
            showlumpSum = false;
            showWMIAcc = 'Yes';    
        }
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
       
       isETS = false;
       if(slaesorgID=='1500' || slaesorgID=='1501'){
            listofchgs=new list<string>{'ZPDY','ZPWK','ZPMN','ZTOT'};
            currencysymbol='$';
            isETS = true;
       }
       if(slaesorgID=='1000'|| slaesorgID=='1100'){
            if(pdftype == 'normal')
                listofchgs=new list<string>{'ZTOT'};
            else
                listofchgs=new list<string>{'ZP01'};        
            currencysymbol='$';
       }
       
       
    }
        
    
    
    public PageReference getPDFContent(){
        
        quoteID = ApexPages.currentPage().getParameters().get('quoteid');
        type = ApexPages.currentPage().getParameters().get('type');

         
        if(type == 'rental')
            isRental = true; 
        else
            isRental = false; 
        qHeader = new Quote_Header__c();
        //fetch the quote header information for the current quote to be used in geneating the quote PDF
        qHeader = [select  Name,Account__c,Account__r.name, Billing_address__c, Billing_City__c, Billing_Country__c, Billing_Zip__c, Billling_State__c,
                   Branch__c, Contact__c, Delivery_Charge__c, Delivery_City__c,Delivery_Date__c,How_long_do_you_need_your_unit_weeks__c, Billing_Email__c, Expected_rental_length_in_days__c, 
                   Expiry_Date__c, Fulfilling_Branch_Name__c, Rental_Length__c, Purchase_Order__c, Quote_Number__c, 
                   Other_Charges__c, Shipto_address__c, Shipto_City__c, Shipto_Country__c, Shipto_Mobile__c, Shipto_State__c,
                   Shipto_Zip__c, Start_Date__c, Total_Initial_Charges__c, Total_One_Time_Charges__c, Total_Rental_Charges__c, Transaction_Type__c, Type__c,
                   Unit_Purpose__c, Actual_Createdby__c,Quote_Comments__c from Quote_Header__c where ID=:quoteID ];   
           
        //quote items to display in the pdf corresponding to the current quote
            List<Quote_Item_Level__c> QilList = new List<Quote_Item_Level__c>();
            for(Quote_Item_Level__c qil:
                                        [select Actual_Amount__c,Quote_Item_Higher_Level__c,Short_Text__c,Frequency__c, Base_Amount__c,  Delivery_Date__c, Description__c, Item_Code__c,Period__c,Recurring__c, Quantity__c, ship_to__c, Type__c, Unit_Type__c,Quote_Item_Number__c,Accessory__c,
                                         ITEM_CATEG__c,
                                        (select Actual_Amount__c,Entered_Amount__c,Quote_Item_Number__c, Frequency__c, Base_Amount__c,  Description__c, Item_Code__c, 
                                        Period__c, Quantity__c,  Type__c, Unit_Type__c,ADJ_COND_TYPE__c 
                                        from Quote_Sub_Item_Levels__r where Quote_Header__c =:quoteID order by Description__c asc)

                                        from Quote_Item_Level__c where Quote_Header__c =:quoteID  order by Quote_Item_Number__c asc]){
                                            
                if(qil.ITEM_CATEG__c == 'Z003' && slaesorgID == '1501' && showWMIAcc == 'No' && (qil.Accessory__c == 'X' || qil.Accessory__c == 'x')){
                    //exclude accessories for WMI with category code Z003
                }
                else
                    QilList.add(qil);                           
            }
            
            List<String> condTypeETS = new List<String>();
            Boolean isETSLLW = FALSE;
            
            for(Quote_Item_Level__c qtl:QilList){
                Decimal fuelCharge = 0;
                List<Quote_Sub_Item_Level__c> Quotesubitemslist = new List<Quote_Sub_Item_Level__c>();
                List<Quote_Sub_Item_Level__c>  qsillist = qtl.Quote_Sub_Item_Levels__r;
                Map<String,String> condTypesubitemListMap= new Map<String,String>();
                Map<String,String> condZPOOsubitemListMap= new Map<String,String>();    //new
                condZPOOsubitemListMap.put('ZP00','--');  //new
                Map<String,List<String>> ItemNumberCondTypeMap= new Map<String,List<String>>();
                
                    
                for(string listofchgsVar:listofchgs){
                       condTypesubitemListMap.put(listofchgsVar, '--');
                }
                             
                for(Quote_Sub_Item_Level__c qsillistVar:qsillist){
         
                    Boolean isMainProd  = false;
                    Decimal ResultZPOO;
                    if(qsillistVar.ADJ_COND_TYPE__c == 'ZLLW' || qsillistVar.ADJ_COND_TYPE__c == 'ZTOT' ){
                        if(ItemNumberCondTypeMap.containsKey(qsillistVar.Quote_Item_Number__c)){
                            ItemNumberCondTypeMap.get(qsillistVar.Quote_Item_Number__c).add(qsillistVar.ADJ_COND_TYPE__c+'_'+qsillistVar.Actual_Amount__c);
                        }
                        else{
                            ItemNumberCondTypeMap.put(qsillistVar.Quote_Item_Number__c, new List<String>());
                            ItemNumberCondTypeMap.get(qsillistVar.Quote_Item_Number__c).add(qsillistVar.ADJ_COND_TYPE__c+'_'+qsillistVar.Actual_Amount__c);
                        }
                    }
                    
                    if( Integer.valueof(qtl.Quote_Item_Higher_Level__c) == 0  && (qsillistVar.ADJ_COND_TYPE__c == 'ZP00' || qsillistVar.ADJ_COND_TYPE__c == 'ZPMN' || qsillistVar.ADJ_COND_TYPE__c == 'ZPWK' || qsillistVar.ADJ_COND_TYPE__c == 'ZPDY' || qsillistVar.ADJ_COND_TYPE__c == 'ZP30') && !isETS ){
                        isMainProd = True;
                        if(qtl.Quantity__c > 0){
                                ResultZPOO= (qsillistVar.Actual_Amount__c/qtl.Quantity__c).setscale(2);
                                condZPOOsubitemListMap.put(qsillistVar.ADJ_COND_TYPE__c,string.valueOf(ResultZPOO));
                        }else
                            condZPOOsubitemListMap.put(qsillistVar.ADJ_COND_TYPE__c,string.valueOf(0));
                        qsillistVar.ADJ_COND_TYPE__c = 'ZP01';    
                    }
                    
                    //if PDF type is extended treat accessories amount as ZP01 ie. replace ZPMN/ZPWK/ZPDY/ZP00 with ZP01 in the list not in Database. 
                    //This will populate the correct amounts in pdf for accessories irespective of the condition type being populated by CCP
                    if( (pdftype == 'extended' || pdftype == 'Extended') && (qtl.Accessory__c != null && qtl.Accessory__c != '') && (qsillistVar.ADJ_COND_TYPE__c == 'ZP00' || qsillistVar.ADJ_COND_TYPE__c == 'ZPMN' || qsillistVar.ADJ_COND_TYPE__c == 'ZPWK' || qsillistVar.ADJ_COND_TYPE__c == 'ZPDY' || qsillistVar.ADJ_COND_TYPE__c == 'ZP30') ){
                        qsillistVar.ADJ_COND_TYPE__c = 'ZP01';
                    }
                    
                    if(('ZFUE'.equalsignorecase(qsillistVar.ADJ_COND_TYPE__c)) && isETS && ( 'Delivery Fuel Surcharge'.equalsignorecase(qsillistVar.Description__c) || 'Pickup Fuel Surcharge'.equalsignorecase(qsillistVar.Description__c)  ))
                    {
                        if(qtl.Quantity__c > 0)
                              fuelCharge = qsillistVar.Actual_Amount__c; //(qsillistVar.Actual_Amount__c/qtl.Quantity__c).setscale(2);
                        else
                              fuelCharge = 0;
                    }
                    
                    
                    
                    
                    if(condTypesubitemListMap.containsKey(qsillistVar.ADJ_COND_TYPE__c)){
                                    
                        //integer actamountVar = integer.valueOf(qsillistVar.Actual_Amount__c);
                        //condTypesubitemListMap.put(qsillistVar.ADJ_COND_TYPE__c,string.valueOf(actamountVar));
                        if(qsillistVar.ADJ_COND_TYPE__c!='ZP01'){
                          if(qtl.Quantity__c > 0){
                              Decimal Result = 0;
                              if( ('Total Delivery'.equalsignorecase(qsillistVar.Description__c) || 'Total Pickup'.equalsignorecase(qsillistVar.Description__c) ) && isETS ){
                                  Result= ((qsillistVar.Actual_Amount__c-fuelCharge)).setscale(2); //-fuelCharge)/qtl.Quantity__c)
                                  fuelCharge = 0;
                              }    
                              else{
                                  if( ('ZPDY'.equalsignorecase(qsillistVar.ADJ_COND_TYPE__c) || 'ZPWK'.equalsignorecase(qsillistVar.ADJ_COND_TYPE__c) || 'ZPMN'.equalsignorecase(qsillistVar.ADJ_COND_TYPE__c)) && isETS )
                                      Result= (qsillistVar.Entered_Amount__c).setscale(2);        
                                  else{
                                      if( isETS) Result= (qsillistVar.Actual_Amount__c).setscale(2);   ///qtl.Quantity__c             
                                      else Result= (qsillistVar.Actual_Amount__c/qtl.Quantity__c).setscale(2);
                                  }    
                              }
                              condTypesubitemListMap.put(qsillistVar.ADJ_COND_TYPE__c,string.valueOf(Result));
                          }
                          else{
                              Decimal Result = 0;
                              if( ('ZPDY'.equalsignorecase(qsillistVar.ADJ_COND_TYPE__c) || 'ZPWK'.equalsignorecase(qsillistVar.ADJ_COND_TYPE__c) || 'ZPMN'.equalsignorecase(qsillistVar.ADJ_COND_TYPE__c)) && isETS )
                              {
                                      Result= (qsillistVar.Entered_Amount__c).setscale(2);
                                      condTypesubitemListMap.put(qsillistVar.ADJ_COND_TYPE__c,string.valueOf(Result));
                              }
                              else
                                  condTypesubitemListMap.put(qsillistVar.ADJ_COND_TYPE__c,string.valueOf(0));            
                          }
                        }
                        else{
                            if(isMainProd)
                            {
                                condTypesubitemListMap.put(qsillistVar.ADJ_COND_TYPE__c,string.valueOf(ResultZPOO));    
                            }
                            else{
                                if(qtl.Quantity__c > 0){
                                    Decimal Result = 0;
                                      if( ('Total Delivery'.equalsignorecase(qsillistVar.Description__c) || 'Total Pickup'.equalsignorecase(qsillistVar.Description__c) ) && isETS ){
                                          Result= ((qsillistVar.Actual_Amount__c-fuelCharge)/qtl.Quantity__c).setscale(2);
                                          fuelCharge = 0;
                                      }    
                                      else
                                          Result= (qsillistVar.Actual_Amount__c /qtl.Quantity__c).setscale(2);
                                    
                                    condTypesubitemListMap.put(qsillistVar.ADJ_COND_TYPE__c,string.valueOf(Result));
                                }
                                else
                                    condTypesubitemListMap.put(qsillistVar.ADJ_COND_TYPE__c,string.valueOf(0));
                            }
                        }
                    }
                    
                    if( ('ZLLW'.equalsignorecase(qsillistVar.ADJ_COND_TYPE__c) || 'ZPPE'.equalsignorecase(qsillistVar.ADJ_COND_TYPE__c) || 'ZFUE'.equalsignorecase(qsillistVar.ADJ_COND_TYPE__c)) && (slaesorgID=='1000' || slaesorgID=='1100')  ){
                    
                        Quotesubitemslist.add(qsillistVar);
                    }
                    
                    if((('ZFUE'.equalsignorecase(qsillistVar.ADJ_COND_TYPE__c)) ||('ZLLW'.equalsignorecase(qsillistVar.ADJ_COND_TYPE__c))) && (slaesorgID=='1500' || slaesorgID=='1501')  ){
                    
                        Quotesubitemslist.add(qsillistVar);
                    
                    }
                    
                    if(('ZLLW'.equalsignorecase(qsillistVar.ADJ_COND_TYPE__c)) && (slaesorgID=='1500' || slaesorgID=='1501')  ){
                    
                        isETSLLW = TRUE;
                    
                    }
                    
                    
                    
                }
                
                    if(ItemNumberCondTypeMap.containsKey(qtl.Quote_Item_Number__c) && (slaesorgID=='1500' || slaesorgID=='1501') && isETSLLW == TRUE){
                            condTypeETS = ItemNumberCondTypeMap.get(qtl.Quote_Item_Number__c);
                            decimal n1,n2,rate;
                            String x;
                            
                             for(String l: condTypeETS){
                                     
                                  list<string> sList = l.split('_');
                                  if(sList[0] == 'ZTOT'){
                                   n1 =  decimal.valueof(sList[1]);
                                  }
                                  else if(sList[0] == 'ZLLW'){
                                  n2 = decimal.valueof(sList[1]);
                                  }
                                  }
                                  if(n2 != null){
                                  rate= n1-n2;
                                  x = String.valueof(rate);
                                  }
                                 else{
                                 x= String.valueof(n1);
                                 }                            
                                  
                                 condTypesubitemListMap.remove('ZTOT');
                                 condTypesubitemListMap.put('ZTOT',x);
                                        
                                         
                                }     
                                        
                        
                    
                    system.debug('items are.....'+qtl+''+Quotesubitemslist);
                    //if(!isMainProd)
                        
                    updatequoteItems.add(new Qilwrapper(qtl,condTypesubitemListMap.values(),Quotesubitemslist));
                   // if(isMainProd)
                    //    updatequoteItems.add(new Qilwrapper(qtl,condZPOOsubitemListMap.values(),Quotesubitemslist));    
                    system.debug('updatequoteItems..........'+updatequoteItems);
                   
            }
            
            
            system.debug('updatequoteItems outside..........'+updatequoteItems);
             quoteItems = new List<Qilwrapper>();
            quoteItems.addall(updatequoteItems);
            system.debug('quoteItems.......'+quoteItems);
           // quoteItems2=updatequoteItems2;
           
        if( (showTOC == 'Yes' || showTOC == 'YES') && (slaesorgID == '1100' || slaesorgID == '1000') )   
        {    
            quoteSubItems = [select Actual_Amount__c,Entered_Amount__c,Frequency__c,Base_Amount__c,Description__c,Item_Code__c,Period__c,Quantity__c,
                         Type__c,Unit_Type__c,Quote_Item_Number__c,ADJ_COND_TYPE__c from Quote_Sub_Item_Level__c where Quote_Header__c=:quoteID and Quote_Item_Number__c = '999999' order by ADJ_COND_TYPE__c asc];
        }
        else{
            quoteSubItems = [select Actual_Amount__c,Entered_Amount__c,Frequency__c,Base_Amount__c,Description__c,Item_Code__c,Period__c,Quantity__c,
                         Type__c,Unit_Type__c,Quote_Item_Number__c,ADJ_COND_TYPE__c from Quote_Sub_Item_Level__c where Quote_Header__c=:quoteID and Quote_Item_Number__c = '999999' and ADJ_COND_TYPE__c !='TOT6' order by ADJ_COND_TYPE__c asc];
        }
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
        
        quoteDeldate = date.valueOf(qHeader.Delivery_Date__c);
        quoteEnddate = date.valueOf(qHeader.How_long_do_you_need_your_unit_weeks__c);
        if(qHeader.Start_Date__c !=null && qHeader.How_long_do_you_need_your_unit_weeks__c!= null){
        quoteNOofdates=  qHeader.Start_Date__c.daysBetween(qHeader.How_long_do_you_need_your_unit_weeks__c)+1;
        }
        //quoteEnd = date.valueof(qHeader.Expiry_Date__c);
        /*if(qHeader.Expiry_Date__c == null  && quoteDeldate != null){
            qHeader.Expiry_Date__c = qHeader.Start_Date__c.addDays(30);
            quoteEnd = date.valueOf(qHeader.Expiry_Date__c);
        }*/
        if(qHeader.Expiry_Date__c != null){
            quoteEnd = date.valueOf(qHeader.Expiry_Date__c);    
        }
            
        return null;
        //end of getPDFContent
    }
    public class Qilwrapper{
                public Quote_Item_Level__c Quoteitemlevels{get; set;}
                public list<string> itemchargs {get; set;}
                public List<Quote_Sub_Item_Level__c> subitemlist {get; set;}
                public Decimal pricePerLineItm{get;set;}
                
                public Qilwrapper(Quote_Item_Level__c QuItLe,List<string> chargs,List<Quote_Sub_Item_Level__c> Quotsubitemslist){
                    
                    Quoteitemlevels=QuItLe;
                    itemchargs = chargs;
                    subitemlist = Quotsubitemslist;
                    if(chargs.size() == 4 && chargs[3] != '--' && QuItLe.Quantity__c != 0 && QuItLe.Quantity__c != null)
                        pricePerLineItm = (Decimal.valueOf(chargs[3])/QuItLe.Quantity__c).setScale(2);
                    else 
                        pricePerLineItm = 0.00;
                }
            }
    
}  //end of class QuotePDF_US