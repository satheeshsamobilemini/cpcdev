/**************************************************************************
Name:  QuickQuoteMainController_AC()
Copyright ? 2013  MMI
----------------------------------------------------------------------
Purpose:
This is the Main COntroller class for Create Quick Quote functionality 
-----------------------------------------------------------------------
History:

VERSION  AUTHOR                 DATE        DETAIL              
1.0  -  TEKsystems             11/2/2013   INITIAL DEVELOPMENT  
**************************************************************************/
global with sharing class QuickQuoteMainController_AC 
{
    //new Wrapper 
    public QuickQuoteWrapper qqWrapper{get;set;}
    public String addressErrorMessage{get;set;}
    public QuickQuoteWrapper.AddressInnerClass addressInner{get;set;}
    public QuickQuoteWrapper.DescarteInnerClass descarteInner{get;set;}
    public QuickQuoteWrapper.InnerProductClass productInner{get;set;}
    public QuickQuoteWrapper.showbranches showBranches{get;set;}
    public QuickQuoteWrapper.stateInnerClass stateInner{get;set;}
    public String userBranchId{get;set;}
    
    public String address1{get;set;}
    public String address2{get;set;}
    public String address3{get;set;}
    public String address4{get;set;}
    public String crossStreet2{get;set;}
    public String state2{get;set;}
    public String zipCode2{get;set;}
    public String countryId2{get;set;}
    public String BranchId{get;set;}
    public boolean salesRepErr{get;set;}
    
    public Boolean disableAddressOkButton{get;set;}
    public Boolean disableTaxOkButton{get;set;}
    public List<SelectOption> durationOptions {get;set;} 
    public List<SelectOption> productTypeOptions {get;set;}
    public List<SelectOption> productSizeOptions {get;set;}
    public boolean enableDuration{get;set;}
    public boolean isknowZoneRatesBtnDisabled {get;set;} // for TFS 2507
    public User loginUserRec{get;set;}
    
    boolean showProductPopup = false;
    boolean showAddressPopup = false;
    boolean clientLoaded = false;
    boolean isLead = false;
    String leadRecId ;
    public String validAddressId{get;set;}
    boolean isErrorInValidateAddress = false;
    boolean isValidated;
    boolean istransChanged;
    public String qqType{get;set;}
    public Branch_Lookup__c BranchLookup{get;set;} 
    public boolean getClientLoaded(){ 
        return clientLoaded; 
    } 
    
    public MMI_Quotes__c proRef;
    public MMI_Quotes__c getproRef()
    {
        return proRef;  
    }
  
    List<Lead> leadRec = new List<Lead>();
    Lead lead_ref = new Lead();
    public Opportunity opp_ref = new Opportunity();
    List<Opportunity> oppRec = new List<Opportunity>();
    List<Account> accountRec = new List<Account>(); // For Account Object Record
    public list<SelectOption> storageUseOptionsList {get;set;} // for TFS 2719
    public list<SelectOption> HowLongWillYouNeedTheUnitOptionsList {get;set;} // for TFS 2854
    Account accRec = new Account();
    public Lead getLeadRef()
    {
        return lead_ref;
    }
    public Opportunity getOppRef()
    {
        return opp_ref;
    }
    
     public Account getAccRef()
    {
        return accRec;
    }
    
    public List<InnerProductClass> innerProductList;
    public List<InnerProductClass> innerProductSearchList;
    public List<SelectOption> StateOptions;
    
   // List<QuickQuoteWrapper.productTypes> productTypesList = new List<QuickQuoteWrapper.productTypes>();
   // List<QuickQuoteWrapper.productSizes> productSizesList = new List<QuickQuoteWrapper.productSizes>();
    
    public List<QuickQuoteWrapper.productTypes> productTypesListNew{get;set;}
    public List<QuickQuoteWrapper.productSizes> productSizesListNew{get;set;}
   
    
    public List<SelectOption> getStateOptions()
    {
        return stateOptions;
    }
    
    public List<SelectOption> CountryOptions;
    public List<SelectOption> getCountryOptions()
    {
        return CountryOptions;
    }
    
    public List<InnerProductClass> getInnerProductsList()
    {
        return innerProductList;
    }
    
    public List<InnerProductClass> getInnerProductSearchList() 
    {
        return innerProductSearchList;
    }
    
    public List<DescarteInnerClass> DescarteInnerClassList = new List<DescarteInnerClass>();
    public List<DescarteInnerClass> getDescarteInnerClassList()
    {
            return DescarteInnerClassList;
    }
        
    public boolean dispDescAddrPopUp =false;
    public boolean getDispDescProductPopUp()
    {
        return dispDescAddrPopUp;
    }
    
    public List<showbranches> getBranchIdNames()
    {
       return branchList;
    }
    
    public List<showbranches> getBranchSearchList()
    {
        return branchSearchList;
    }
    
    public List<showbranches> branchList = new List<showbranches>();
    public List<showbranches> branchSearchList = new List<showbranches>();
    public boolean dispBranchPopUp{get;set;}
    
    public boolean showSearchBranchIdTable = false;
    
    public boolean getshowSearchBranchIdTable()
    {
        return showSearchBranchIdTable;
    }
    public boolean ShowProduct= false;
    public boolean getShowProduct()
    {
        return ShowProduct;
    }

    public List<AddressInnerClass> AddressInnerClassList;
    public List<AddressInnerClass> getAddressInnerClassList()
    {
        return AddressInnerClassList;
    }
     public List<SelectOption> transactionOptions = new List<SelectOption>();
    public List<SelectOption> getTransactionOptionsList()
    {
        return transactionOptions;  
    }  
    //----public variables for capacity lookup------------------------------
    public Boolean isShowcapacityLookupPopUp {get;set;}
    public list<HomeBaseBeans.CapacityLookupHandler> CapacityLookupList {get;set;}
    public String latitudeForCapLukp {get;set;}
    public String longitudeForCapLukp {get;set;}
    public String selectedProdDescForCapLkup {get;set;}
    
    //-----------QQ from JP--------------------------------------------------
    public String source {get;set;}
    public String jobProfId {get;set;}
    public String ContactOfJp {get;set;}
    public String subContractorId {get;set;}
    //-----------QQ from JP--------------------------------------------------
    public String ContId {get;set;}
    public String selectedConPh {get;set;}
    
    
    public map<String,String> mapTransactionTypeAndDefCode {get;set;}// TFS 3916
    /*******************************************************************
    Purpose     : This is constructor for the QuickQuoteMainController 
    Parameters  : None
    Returns     : None
    ********************************************************************/
    public void QuickQuoteMainController_AC_initalize()
    {
         system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainController_AC :constructor');
        //new wrapper
        map<String,String> mapTransactionTypeAndDefCode = new map<String,String>(); // TFS 3916
        makeTransactionTypeAndDefCodeMap();// TFS 3916
        
        //------------ for TFS 2719-------------------
        storageUseOptionsList = new list<SelectOption>();
        Schema.DescribeFieldResult fieldResult = Opportunity.Why_do_you_need_storage_Picklist__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        storageUseOptionsList.add(new SelectOption('', '--None--'));
        for(Schema.PicklistEntry p : ple){
        	storageUseOptionsList.add(new SelectOption(p.getValue(), p.getValue()));
        }
        //------------ for TFS 2719-------------------
        //------------ for TFS 2854------------------
        HowLongWillYouNeedTheUnitOptionsList = new list<SelectOption>();
        Schema.DescribeFieldResult fieldResult2 = Opportunity.How_long_will_you_need_your_unit__c.getDescribe();
        List<Schema.PicklistEntry> ple2 = fieldResult2.getPicklistValues();
        HowLongWillYouNeedTheUnitOptionsList.add(new SelectOption('', '--None--'));
        for(Schema.PicklistEntry p : ple2){
        	HowLongWillYouNeedTheUnitOptionsList.add(new SelectOption(p.getValue(), p.getValue()));
        }
        //------------ for TFS 2854-------------------
        
        isknowZoneRatesBtnDisabled = true;
        isShowcapacityLookupPopUp = false;
        CapacityLookupList = new list<HomeBaseBeans.CapacityLookupHandler>();
        proRef = new MMI_Quotes__c();
        innerProductList = new List<InnerProductClass>();
      innerProductSearchList = new List<InnerProductClass>();
      StateOptions = new List<SelectOption>();
      CountryOptions = new List<SelectOption>();
      AddressInnerClassList = new List<AddressInnerClass>();
        loginUserRec = [Select Id,LastName,Branch_Id__c,FirstName,MobilePhone,Country,City,Street,UserRole.Name, UserRoleId, State, PostalCode,Email,Fax,Phone,Extension__c, Name, Sales_Rep_Id__c from User where Id =: UserInfo.getUserId()];
        addressErrorMessage = '';
        qqWrapper= new QuickQuoteWrapper();
        addressInner= new QuickQuoteWrapper.AddressInnerClass();
        descarteInner= new QuickQuoteWrapper.DescarteInnerClass ();
        productInner= new QuickQuoteWrapper.InnerProductClass ();
        showBranches= new QuickQuoteWrapper.showbranches ();
        stateInner= new QuickQuoteWrapper.stateInnerClass();
        
        durationOptions=QuickQuoteUtilities.getDurationList();
        productTypesListNew=QuickQuoteUtilities.getProductTypeNewList();
        productSizesListNew=QuickQuoteUtilities.getProductSizeNewList();
        
       // productTypesList=QuickQuoteUtilities.getProductTypeNewList();
       // productSizesList=QuickQuoteUtilities.getProductSizeNewList();
        
        QuickQuoteMainService qqService=new QuickQuoteMainService();
        salesRepErr=false;
        enableDuration=false;
        qqWrapper.PrimaryOnly=true;
     
        //userBranchId = qqService.getuserBranchInfo();
        //qqWrapper.UserBranchId = userBranchId;
        source = System.currentPageReference().getParameters().get('source') ;
        if(source == 'jp'){
        	leadRecId = System.currentPageReference().getParameters().get('accId') ;
        	qqWrapper.accountId = leadRecId;
        	jobProfId = System.currentPageReference().getParameters().get('recId');
        	qqWrapper.jobProfileId = jobProfId;
        	subContractorId = System.currentPageReference().getParameters().get('scId');
        	qqWrapper.subContId = subContractorId;
        	ContactOfJp = System.currentPageReference().getParameters().get('conId');
        	qqWrapper.contactId = ContactOfJp;
        }else{   
        	leadRecId = System.currentPageReference().getParameters().get('recId') ;
        	ContId = System.currentPageReference().getParameters().get('conId') ;
        }
        selectedConPh = System.currentPageReference().getParameters().get('conPh') ;
        if(selectedConPh != null && selectedConPh != '' && selectedConPh != 'null'){
        	qqwrapper.primaryContactNo = selectedConPh;  
        }    
        leadRec = qqService.getLeadinfo(leadRecId);
        oppRec = qqService.getOppInfo(leadRecId);
        accountRec=qqService.getAccounListInfo(leadRecId);
        if(leadRec.size() > 0)
        {
            qqWrapper.LeadOppName = leadRec[0].Name;
            lead_ref = leadRec[0];
            isLead = true;
            qqWrapper.tabStyle = 'Lead';
            if(leadRec[0].Servicing_Branch_Id__c!=null){
                userBranchId=leadRec[0].Servicing_Branch_Id__c;
                qqWrapper.UserBranchId = userBranchId;
            }else if(leadRec[0].Branch__c!=null){
                userBranchId=leadRec[0].Branch__c;
                qqWrapper.UserBranchId = userBranchId;
            }
            qqWrapper.oppContactName = leadRec[0].FirstName;
            qqWrapper.oppContactLastName = leadRec[0].LastName;
            qqWrapper.oppContactPhone = leadRec[0].Phone;
            qqWrapper.oppContactMob = leadRec[0].MobilePhone;
            qqWrapper.oppContactEmail = leadRec[0].Email;
        } 
        if(oppRec.size() > 0)
        {
            qqWrapper.tabStyle = 'Opportunity';
            qqWrapper.LeadOppName = oppRec[0].Name;
            opp_ref = oppRec[0];
            opp_ref.Next_Activity_Date__c = null;
            if(oppRec[0].AccountId != null)
            {
                accRec =qqService.getAccInfo(oppRec[0].AccountId); 
            }
            if(oppRec[0].Servicing_Branch__c!=null){
                userBranchId=oppRec[0].Servicing_Branch__c;
                qqWrapper.UserBranchId = userBranchId;
            }else if(oppRec[0].Branch__c!=null){
                userBranchId=oppRec[0].Branch__c;
                qqWrapper.UserBranchId = userBranchId;
            }
            //-issue 1238-------------------
            /*qqWrapper.oppContactName = oppRec[0].Contact_Name__c;
            qqWrapper.oppContactLastName = oppRec[0].Contact_Last_Name__c;
            qqWrapper.oppContactPhone = oppRec[0].Contact_Phone__c;*/
            if(ContId != null && ContId != ''){
        		displayCOntactDetail(ContId);
        	}
        }
        
        if(accountRec.size() > 0)
        {
            if(source == 'jp'){
            	//get contact id and display selected contact detail....
            	ContactOfJp = System.currentPageReference().getParameters().get('conId');
            	if(ContactOfJp != null && ContactOfJp != ''){
            		Contact conObjRec = QuickQuoteMainDAO.getContactRecord(ContactOfJp);
            		if(conObjRec != null){
            			qqWrapper.oppContactName = conObjRec.FirstName;
			            qqWrapper.oppContactLastName = conObjRec.LastName;
			            qqWrapper.oppContactPhone = conObjRec.Phone;
			            qqWrapper.oppContactMob = conObjRec.MobilePhone;
            			qqWrapper.oppContactEmail = conObjRec.Email;
            		}
            	}
            	system.debug('--------qqWrapper.oppContactName----------'+qqWrapper.oppContactName);
            	system.debug('--------qqWrapper.oppContactLastName----------'+qqWrapper.oppContactLastName);
            	system.debug('--------qqWrapper.oppContactPhone----------'+qqWrapper.oppContactPhone);
            }
            qqWrapper.tabStyle = 'Account';
            qqWrapper.LeadOppName = accountRec[0].Name;
            accRec = accountRec[0];
           
            if(accountRec[0].Servicing_Branch_Id__c!=null){
                userBranchId=accountRec[0].Servicing_Branch_Id__c;
                qqWrapper.UserBranchId = userBranchId;
            }else if(accountRec[0].Branch__c!=null){
                userBranchId=accountRec[0].Branch__c;
                qqWrapper.UserBranchId = userBranchId;
            }
            //-------------issue no 1270-------------------
            if(ContId != null && ContId != ''){
        		displayCOntactDetail(ContId);
        	}
        }
                  
        qqWrapper.Quantity = 1; 
        qqWrapper.Locks = 0;
        qqWrapper.Duration='1';
        qqWrapper.disableReCalcBtn = true;
        system.debug(LoggingLevel.DEBUG,'Exiting to  QuickQuoteMainController_AC : Constructor');
    }
    
    public void displayCOntactDetail(String conId){
    	if(conId != null && conId != ''){
    		Contact contactRec = QuickQuoteMainDAO.getContactRecord(conId);
    		if(contactRec != null){
    			qqWrapper.oppContactName = contactRec.FirstName;
	            qqWrapper.oppContactLastName = contactRec.LastName;
	            qqWrapper.oppContactPhone = contactRec.Phone;
	            qqWrapper.oppContactMob = contactRec.MobilePhone;
            	qqWrapper.oppContactEmail = contactRec.Email;
    		}
    	}
    }
    
    public Pagereference onTypeChangePageRedi(){
	    if(qqType == 'Sales'){
	    	if(source == 'jp'){
	    		PageReference pageRef= new PageReference('/apex/QuickQuote_sales?recId='+jobProfId+'&scId='+subContractorId+'&conId='+ContactOfJp+'&accId='+leadRecId+'&source=jp');
	        	return pageRef;
	    	}
	    	if(ContId != null && ContId != ''){
	    		PageReference pageRef= new PageReference('/apex/QuickQuote_sales?recId='+leadRecId+'&conId='+ContId+'&conPh='+selectedConPh);
	    		return pageRef;
	    	}else{
	      		PageReference pageRef= new PageReference('/apex/QuickQuote_sales?recId='+leadRecId);
	      		return pageRef;
	    	}
	    }else if(qqType == 'Rental'){
	    	if(source == 'jp'){
	    		PageReference pageRef= new PageReference('/apex/QuickQuoteMain_VF?recId='+jobProfId+'&scId='+subContractorId+'&conId='+ContactOfJp+'&accId='+leadRecId+'&source=jp');
	        	return pageRef;
	    	}
	    	if(ContId != null && ContId != ''){
	    		PageReference pageRef= new PageReference('/apex/QuickQuoteMain_VF?recId='+leadRecId+'&conId='+ContId+'&conPh='+selectedConPh);
	    		return pageRef;
	    	}else{
	      		PageReference pageRef= new PageReference('/apex/QuickQuoteMain_VF?recId='+leadRecId);
	      		return pageRef;
	    	}
	        
	    }else {
	      return null;
	    }
    } 
    /*******************************************************************
    Purpose     : This Method is use to calculate the rates 
    Parameters  : None
    Returns     : None
    ********************************************************************/
     public pagereference CalculateTotals(){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainController_AC :CalculateTotals'+ qqWrapper+validAddressId +'---'+qqwrapper.TaxId);
        QuickQuoteHelper QQRHelper=null;
        try{
                if(qqWrapper!=null){
                        QQRHelper=new QuickQuoteHelper();
                        QQRHelper.calculateTotal(qqWrapper);
                }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainController_AC CalculateTotals:'+e.getMessage());
        }
            system.debug(LoggingLevel.DEBUG,'Exiting to  QuickQuoteMainController_AC : CalculateTotals()'+qqWrapper);
        return null;
    }
   
    /*******************************************************************
    Purpose     : This action function is use to select product after product
                  search service
    Parameters  : None
    Returns     : None
    ********************************************************************/
    public void SelectedProduct(){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainController_AC :SelectedProduct()'+validAddressId +'---'+qqwrapper.TaxId+innerProductList);
        QuickQuoteHelper qqHelper=null;
        try{
                 qqHelper=new QuickQuoteHelper();
                if(ShowProduct){   
                    for(InnerProductClass I : innerProductList){
                        Integer recNumber;
                        if(System.currentPageReference().getParameters().get('selectedProd') != null)
                        {       
                            recNumber =  Integer.valueOf(System.currentPageReference().getParameters().get('selectedProd'));
                        }
                        if(I.RecUniqId == recNumber)
                        {  
                            //-------------------tfs 3916--------------------------------------
                            if(!ValidateProductWithTransactionType(I.PID, qqWrapper.TransactionType)){
				           		ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,'The selected Product is not allowed with this transaction type!');
				                ApexPages.addMessage(msg);
				                break;
				            }else{
	                            qqhelper.assignSelectedProdRate(qqWrapper,I);
	                            qqhelper.getDurationRate(qqWrapper);
	                            selectedProdDescForCapLkup = I.PDescription;
	                            qqwrapper.productDescToInsert = I.PDescription;
	                            break;
                            }
                        }
                    }
               }else{
                    for(InnerProductClass I : innerProductSearchList){
                        Integer recNumber;
                        if(System.currentPageReference().getParameters().get('selectedProd') != null)
                        {       
                                recNumber =  Integer.valueOf(System.currentPageReference().getParameters().get('selectedProd'));
                        }
                        if(I.RecUniqId == recNumber)
                        {       
                                //-------------------tfs 3916--------------------------------------
                                if(!ValidateProductWithTransactionType(I.PID, qqWrapper.TransactionType)){
					           		ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,'The selected Product is not allowed with this transaction type!');
					                ApexPages.addMessage(msg);
					                break;
					            }else{
	                                //qqWrapper.Product = I.PID;
	                                qqhelper.assignSelectedProdRate(qqWrapper,I);
	                                qqhelper.getDurationRate(qqWrapper);
	                                selectedProdDescForCapLkup = I.PDescription;
	                                qqwrapper.productDescToInsert = I.PDescription;
	                                break;
                                }
                        }
                    }
               }
                    
                    qqHelper.emptyQQWrapper(qqWrapper);
                
                      qqwrapper.showSearchError = false;                
                      qqwrapper.showValidateAddress = false;
                      qqwrapper.showProdSelect = true;
                      qqwrapper.showRefreshQUote = true;
                      qqwrapper.showSaveButton = false;
                      showProductPopup = false;
                      
                      enableDuration=true;
                      
                  if(qqwrapper.TaxId==null){
                      SelectedAddressId();
                   }      
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainController_AC SelectedProduct:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Exiting to  QuickQuoteMainController_AC : SelectedProduct()'+qqwrapper);
    }
    
    /*******************************************************************
    Purpose     : This action function is use to close product search popup
    Parameters  : None
    Returns     : None
    ********************************************************************/
      public PageReference CloseProductPopUp(){       
        showProductPopup = false;
        qqwrapper.showSearchError = false; 
        qqwrapper.showValidateAddress = false;
        qqwrapper.showProdSelect = true;
        return null;
    }
    
    /*******************************************************************
    Purpose     : This action function is use to get and assign address info
    Parameters  : None
    Returns     : None
    ********************************************************************/
    public PageReference AmendShipping(){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainController_AC :AmendShipping()');
        try{
                if(leadRec.size() > 0){ 
                        if(leadRec[0].Delivery_Street__c != null || leadRec[0].Delivery_Postal_Code__c != null 
                            || leadRec[0].Delivery_Country__c != null || leadRec[0].Delivery_State__c != null || leadRec[0].Delivery_City__c != null){
                                
                            qqWrapper.Address = leadRec[0].Delivery_Street__c;
                            qqWrapper.City = leadRec[0].Delivery_City__c;
                            qqWrapper.ZipCode = leadRec[0].Delivery_Postal_Code__c;
                                
                            if(leadRec[0].Delivery_Country__c!=null && leadRec[0].Delivery_Country__c.toLowerCase() == 'canada'){
                            qqWrapper.Country = 'CAN';
                            }else if(leadRec[0].Delivery_Country__c!=null && leadRec[0].Delivery_Country__c.equalsIgnoreCase('united states')){
                             qqWrapper.Country = 'USA';
                            } else{
                                    if(leadRec[0].Delivery_Country__c != null && leadRec[0].Delivery_Country__c != ''){
                            qqWrapper.Country = leadRec[0].Delivery_Country__c.toUpperCase();
                                    }else{
                                        if(leadRec[0].Delivery_Country__c==null){
                                           qqWrapper.Country = 'USA';
                                        }
                                    }
                                 }
                                 if(leadRec[0].Delivery_State__c != null && leadRec[0].Delivery_State__c != ''){
                            qqWrapper.State = leadRec[0].Delivery_State__c.toUpperCase();
                          }
                        }else{
                                qqWrapper.Address = leadRec[0].Street;
                            qqWrapper.City = leadRec[0].City;
                            qqWrapper.ZipCode = leadRec[0].PostalCode;
                            if(leadRec[0].Country!=null && leadRec[0].Country.toLowerCase() == 'canada'){
                            qqWrapper.Country = 'CAN';
                            }else if(leadRec[0].Country!=null && leadRec[0].Country.equalsIgnoreCase('united states')){
                             qqWrapper.Country = 'USA';
                            }else{
                             if(leadRec[0].Country!=null){
                                qqWrapper.Country = leadRec[0].Country.toUpperCase();
                                 }else{
                                    if(leadRec[0].Country==null){
                                          qqWrapper.Country = 'USA';
                                     }
                                 }
                             }
                              if(leadRec[0].State!=null){
                                qqWrapper.State = leadRec[0].State.toUpperCase();
                            }
                            
                        }
                        
                } else if(oppRec.size() > 0){
                        //------------------TFS 2720-----------------------------------
                        if(oppRec[0].of_Units__c != null){
                        	qqWrapper.Quantity = Integer.valueOf(oppRec[0].of_Units__c);
                        }
                        system.debug('-------------oppRec[0].Quote_Comments__c---------------------'+oppRec[0].Quote_Comments__c);
                        if(oppRec[0].Quote_Comments__c != null){
                        	qqwrapper.QuoteComments = oppRec[0].Quote_Comments__c;
                        }
                        if(oppRec[0].Delivery_Country__c != null || oppRec[0].Delivery_State_Province__c != null
                            || oppRec[0].Delivery_Street__c != null || oppRec[0].Delivery_Zip_Postal_Code__c != null){  
                        
                            qqWrapper.Address = oppRec[0].Delivery_Street__c;
                            qqWrapper.City = oppRec[0].Delivery_City__c;
                            qqWrapper.ZipCode = oppRec[0].Delivery_Zip_Postal_Code__c;
                            if(oppRec[0].Delivery_Country__c!=null  && oppRec[0].Delivery_Country__c.toLowerCase() == 'canada'){
                            qqWrapper.Country = 'CAN';
                            }else if(oppRec[0].Delivery_Country__c!=null && oppRec[0].Delivery_Country__c.equalsIgnoreCase('united states')){
                                 qqWrapper.Country = 'USA';
                             }else{
                                if(oppRec[0].Delivery_Country__c!=null && oppRec[0].Delivery_Country__c!='N/A'){
                            qqWrapper.Country = oppRec[0].Delivery_Country__c.toUpperCase();
                                }else{
                                    if(oppRec[0].Delivery_Country__c==null){
                                          qqWrapper.Country = 'USA';
                                     }
                                 }
                            }
                            if(oppRec[0].Delivery_State_Province__c != null && oppRec[0].Delivery_State_Province__c != ''){
                            qqWrapper.State = oppRec[0].Delivery_State_Province__c.toUpperCase();
                            }
                            
                            
                        }else{
                            if(accRec.Id != null){
                                            if(accRec.ShippingStreet != null || accRec.ShippingCity != null || accRec.ShippingCountry != null || accRec.ShippingState != null || accRec.ShippingPostalCode != null )     
                                            {            
                                                qqWrapper.Address = accRec.ShippingStreet;
                                                qqWrapper.City = accRec.ShippingCity;
                                                qqWrapper.ZipCode = accRec.ShippingPostalCode;
                                    
                                                if(accRec.ShippingState != null && accRec.ShippingState != ''){
                                                    qqWrapper.State = accRec.ShippingState.toUpperCase();
                                                }
                                                
                                    if(accRec.ShippingCountry!=null  && accRec.ShippingCountry.toLowerCase() == 'canada'){
                                                qqWrapper.Country = 'CAN';
                                    }else if(accRec.ShippingCountry!=null && accRec.ShippingCountry.equalsIgnoreCase('united states')){
                                         qqWrapper.Country = 'USA';
                                     }else{
                                        if(accRec.ShippingCountry!=null && accRec.ShippingCountry!='N/A'){
                                                qqWrapper.Country = accRec.ShippingCountry.toUpperCase();
                                        }else{
                                            if(accRec.ShippingCountry==null){
                                                  qqWrapper.Country = 'USA';
                                             }
                                         }
                                    }
                                                                
                                            }else{
                                                qqWrapper.Address = accRec.BillingStreet;
                                                qqWrapper.City = accRec.BillingCity;
                                                qqWrapper.ZipCode = accRec.BillingPostalCode;
                                                if(accRec.BillingState!=null){
                                                    qqWrapper.State = accRec.BillingState.toUpperCase();
                                                }
                                               
                                        if(accRec.BillingCountry!=null  && accRec.BillingCountry.toLowerCase() == 'canada'){
                                               qqWrapper.Country = 'CAN';
                                        }else if(accRec.BillingCountry!=null && accRec.BillingCountry.equalsIgnoreCase('united states')){
                                             qqWrapper.Country = 'USA';
                                         }else{
                                            if(accRec.BillingCountry!=null && accRec.BillingCountry!='N/A'){
                                                    qqWrapper.Country = accRec.BillingCountry.toUpperCase();
                                            }else{
                                                if(accRec.BillingCountry==null){
                                                      qqWrapper.Country = 'USA';
                                            }
                                    } 
                       }
                       
                                    }
                             } 
                     }
                     if(oppRec[0].When_will_you_need_your_unit__c != null){
                                proRef.When_will_you_need_your_unit__c = oppRec[0].When_will_you_need_your_unit__c; 
                            }
                            if(oppRec[0].Why_do_you_need_storage_Picklist__c != null && oppRec[0].Why_do_you_need_storage_Picklist__c != ''){
                                qqwrapper.Whydoyouneedstorage  = oppRec[0].Why_do_you_need_storage_Picklist__c;  
                            }
                            
                            if(oppRec[0].What_will_you_be_storing__c != null && oppRec[0].What_will_you_be_storing__c != ''){
                                qqwrapper.Whatwillyoubestoring = oppRec[0].What_will_you_be_storing__c; 
                            }
                            if(oppRec[0].How_often_will_you_need_to_access__c != null && oppRec[0].How_often_will_you_need_to_access__c != ''){
                                qqwrapper.Howoftenwillyouneedtoaccess= oppRec[0].How_often_will_you_need_to_access__c;  
                            }
                           
                            if(oppRec[0].How_long_will_you_need_your_unit__c != null && oppRec[0].How_long_will_you_need_your_unit__c != ''){
                                qqwrapper.Howlongwillyouneedyourunit = oppRec[0].How_long_will_you_need_your_unit__c;   
                            } 
                            
                            if(oppRec[0].Who_is_going_to_be_accessing_your_unit__c != null && oppRec[0].Who_is_going_to_be_accessing_your_unit__c != ''){
                                qqwrapper.Whoisgoingtobeaccessingyourunit = oppRec[0].Who_is_going_to_be_accessing_your_unit__c;    
                            }
                       
                }else if(accountRec.size() > 0){
                	if(source == 'jp'){
                		populateAddressFromJp();
                	}else{
	                    if(accountRec[0].ShippingStreet != null || accountRec[0].ShippingCity != null || accountRec[0].ShippingCountry != null || accountRec[0].ShippingState != null || accountRec[0].ShippingPostalCode != null )     
	                    {                  
		                    qqWrapper.Address = accountRec[0].ShippingStreet;
		                    qqWrapper.City = accountRec[0].ShippingCity;
		                    qqWrapper.ZipCode = accountRec[0].ShippingPostalCode;
	                  		if(accountRec[0].ShippingCountry!=null && accountRec[0].ShippingCountry.toLowerCase() == 'canada'){
	                   			qqWrapper.Country = 'CAN';
	                  		}else if(accountRec[0].ShippingCountry!=null && accountRec[0].ShippingCountry.equalsIgnoreCase('united states')){
	                   			qqWrapper.Country = 'USA';
	                  		}else{
	                        	if(accountRec[0].ShippingCountry != null && accountRec[0].ShippingCountry != ''){
	                      			qqWrapper.Country = accountRec[0].ShippingCountry.toUpperCase();
	                        	}else{
	                            	if(accountRec[0].ShippingCountry == null){
	                                	qqWrapper.Country = 'USA';
	                            	}
	                        	}
	                          
	                  			if(accountRec[0].ShippingState == 'N/A'){
	                    			accountRec[0].ShippingState = '';
	                  			}
				                if(accountRec[0].ShippingState != null && accountRec[0].ShippingState != ''){
				        		              qqWrapper.State = accountRec[0].ShippingState.toUpperCase();
				                }
	                     
	                		} 
	                  
	                  }else{
	                  		qqWrapper.Address = accountRec[0].BillingStreet;
	                  		qqWrapper.City = accountRec[0].BillingCity;
	                  		qqWrapper.ZipCode = accountRec[0].BillingPostalCode;
	                  		if(accountRec[0].BillingCountry!=null && accountRec[0].BillingCountry.toLowerCase() == 'canada'){
	                   			qqWrapper.Country = 'CAN';
	                  		}else if(accountRec[0].BillingCountry!=null && accountRec[0].BillingCountry.equalsIgnoreCase('united states')){
	                   			qqWrapper.Country = 'USA';
	                  		}else{
	                    		if(accountRec[0].BillingCountry!=null){
	                      			qqWrapper.Country = accountRec[0].BillingCountry.toUpperCase();
	                            }else{
	                                if(accountRec[0].BillingCountry == null){
	                                    qqWrapper.Country = 'USA';
	                                }
	                    		}
	                  			if(accountRec[0].BillingState !=null && accountRec[0].BillingState == 'N/A'){
	                    			accountRec[0].BillingState = '';
	                  			}
	                  			if(accountRec[0].BillingState!=null){
	                     			qqWrapper.State = accountRec[0].BillingState.toUpperCase();
	                			}
	                	   }
	                    
	                  }
	                  
	                }	
                }
               StatesList();
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainController_AC AmendShipping:'+e.getMessage());
        } 
        system.debug(LoggingLevel.DEBUG,'Exiting to  QuickQuoteMainController_AC : AmendShipping()'+qqWrapper);      
        return null;
    }
   
   public void populateAddressFromJp(){
   		String jobProfileId = System.currentPageReference().getParameters().get('recId');
    	if(jobProfileId != null && jobProfileId != ''){
    		Job_Profile__c jpObjRec = QuickQuoteMainDAO.getJobProfRecord(jobProfileId);
    		if(jpObjRec != null){
    			qqWrapper.Address = jpObjRec.Job_Site_Address__c;
	            qqWrapper.City = jpObjRec.Job_Site_City__c;
	            qqWrapper.State = jpObjRec.Job_Site_State__c;
	            qqWrapper.ZipCode = jpObjRec.Job_Site_Zip__c;
	            if(jpObjRec.Job_Site_Country__c != null && (jpObjRec.Job_Site_Country__c.equalsIgnoreCase('united states') || jpObjRec.Job_Site_Country__c.equalsIgnoreCase('us') )){
	            	qqWrapper.Country = 'USA';
	            }else if(jpObjRec.Job_Site_Country__c != null && (jpObjRec.Job_Site_Country__c.equalsIgnoreCase('canada') || jpObjRec.Job_Site_Country__c.equalsIgnoreCase('can') )){
	            	qqWrapper.Country = 'CAN';
	            }else{
	            	qqWrapper.Country = 'USA';
	            }
    		}else{
    			qqWrapper.Country = 'USA';
    		}
    	}
   	}
   
    /*******************************************************************
    Purpose     : This action function is use to initiate product search webservice
    Parameters  : None
    Returns     : None
    ********************************************************************/
    public void ProductSearch()
    {
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainController_AC :ProductSearch()'+validAddressId +'---'+qqwrapper.TaxId);
        Integer recCount = 1;
        integer minSize =0;
        integer maxSize =0;
        HomeBaseBeans.ProductSearch productSearchPattern =null;
        ProductSearchService_AC productService=null;
        List<HomeBaseBeans.Products> productList ;
        String selectedPT='';
        String selectedPS='';
        try{   
          
           // productTypesListNew  QuickQuoteWrapper.productTypes
    
             // productSizesListNew  QuickQuoteWrapper.productSizes
             
             selectedPT=System.currentPageReference().getParameters().get('SelectedPT');
             selectedPS=System.currentPageReference().getParameters().get('SelectedPS');
             
              if(selectedPS!=null && selectedPS!=''){
              
              for(QuickQuoteWrapper.productSizes pSize :productSizesListNew){
                if(pSize.RecUniqId==integer.valueOf(selectedPS)){
                  qqWrapper.ProductSize=pSize.productSize; 
                }
              }
              
              }else{
                qqWrapper.ProductSize='';
              }
              
              if(selectedPT!=null && selectedPT!=''){
              for(QuickQuoteWrapper.productTypes pSize :productTypesListNew){
                if(pSize.RecUniqId==integer.valueOf(selectedPT)){
                  qqWrapper.ProductType=pSize.productType;
                }
              }
              }else{
                qqWrapper.ProductType='';
              }
          
                innerProductSearchList.clear();
                if(qqWrapper.ProductSize.contains('5'))
                {
                        minSize = 5; 
                        maxSize = 9;
                }
                if(qqWrapper.ProductSize.contains('10'))
                {
                        minSize = 10;
                        maxSize = 19;
                }
                if(qqWrapper.ProductSize.contains('20'))
                {
                        minSize = 20;
                        maxSize = 29;
                }
                if(qqWrapper.ProductSize.contains('30'))
                {
                        minSize = 30;
                        maxSize = 39;
                }
                if(qqWrapper.ProductSize.contains('40'))
                {
                        minSize = 40;           
                }        
                innerProductSearchList = new List<InnerProductClass>();
                productSearchPattern = new HomeBaseBeans.ProductSearch();
                productSearchPattern.pattern = EncodingUtil.urlEncode(qqWrapper.productSearchWord,'UTF-8');
                productSearchPattern.defId = qqWrapper.ProductType;
                if(maxSize!=0){
                  productSearchPattern.maxsize = maxSize;
                }
                if(minSize!=0){
                  productSearchPattern.minsize = minSize;
                }
                
                productSearchPattern.primaryOnly = qqWrapper.PrimaryOnly;
                productService = new ProductSearchService_AC();
                if(qqWrapper.FulfillingBranch!=null && qqWrapper.FulfillingBranch!=''){
                  if(!Test.isRunningTest()){ 
                     productList = productService.searchProduct(productSearchPattern,qqWrapper.FulfillingBranch);
                  }else{
                    productList=MMITestDataProvider.getQHomeBaseProduct();
                  }
                }else{
                         productList = productService.searchProduct(productSearchPattern,qqWrapper.UserBranchId);
                }
                qqwrapper.showSearchError = false; 
         
            if(productList[0].errorMessage == null)
            { 
                for(HomeBaseBeans.Products p : productList)
                {              
                    InnerProductClass IC = new InnerProductClass();
                    IC.PID = p.Id;
                    IC.PDescription = p.Description;
                    IC.PQtyAvail = p.qtyAvail;    
                    IC.PQtyFree = p.qtyFree;
                    IC.PQtyWip = p.qtyWip;
                    IC.PQtyReserved = p.qtyReserved;
                    IC.PQtyTotal = p.qtyTotal;
                    IC.PRate1 = p.rate1.rate;
                    IC.PRate2 = p.rate2.rate;
                    IC.PRate3 = p.rate3.rate;
                    IC.PRate4 = p.rate4.rate;
                    IC.PRate5 = p.rate5.rate;
                    IC.PRate6 = p.rate6.rate;
                    IC.PRate7 = p.rate7.rate;
                    IC.PRate8 = p.rate8.rate;
                    IC.PCommission1 = p.commission1;
                    IC.PCommission2 = p.commission2;
                    IC.PCommission3 = p.commission3;
                    IC.PCommission4 = p.commission4;                        
                    IC.Pllw = p.llw;
                    IC.ppe = p.ppe;
                    IC.mainFeature = p.mainFeature;                 
                    IC.isSelected = false;
                    IC.RecUniqId = recCount;
                    
                    
                     IC.pHILRM = String.valueOf(Decimal.valueOf(p.qtyWip1)+ Decimal.valueOf(p.qtyWip5));
             if(Decimal.valueOf(p.qtyTotal) > 0){
				Decimal UtilPercentInDecimal =  (Decimal.valueOf(p.qtyRented) / Decimal.valueOf(p.qtyTotal)) * 100;
                IC.pUtilPercent = String.valueOf(UtilPercentInDecimal.round(System.RoundingMode.HALF_EVEN));
              }else{
                IC.pUtilPercent = '';
          }
          IC.pORNPU = p.qtywip6;
                    
                    
                    
                    recCount++;
                
                    innerProductSearchList.add(IC);
                }
            }
            else
            {
                qqwrapper.showSearchError = true; 
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,productList[0].errorMessage);
                ApexPages.addMessage(msg);
            } 
            system.debug(LoggingLevel.DEBUG,'Exiting to  QuickQuoteMainController_AC : ProductSearch()'+innerProductSearchList);
        }
        catch(Exception e)
        {
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainController_AC ProductSearch:'+e.getMessage());
        }         
         
         showProductPopup = true;
         ShowProduct = false;
         system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainController_AC :ProductSearch()'+validAddressId +'---'+qqwrapper.TaxId);
        
    }
    /*******************************************************************
    Purpose     : This action function is use to initiate Refresh Quick 
                  Quote webservice
    Parameters  : None
    Returns     : None
    ********************************************************************/
    public void Refresh(){  
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainController_AC :Refresh()'+validAddressId +'---'+qqwrapper.TaxId +qqwrapper.isIncludeLLW);
        QuickQuoteHelper QQRHelper=null;
        HomeBaseBeans.QuickQuoteRefreshFormat QQRF =null;
        HomeBaseBeans.quickQuoteRefresh d =null;
        RefreshQuickQuoteService_AC refreshQuote=null;
        qqwrapper.DisplayErrorPopUp=false;
        qqWrapper.disableReCalcBtn = true;
        try{
            qqWrapper.tyleofQuoute = qqType;     
            if(!checkMandatoryField())
            {     
                 if(qqwrapper.TaxId==null){
                     SelectedAddressId();
                   }
                   if(qqwrapper.TransactionType=='ON'){
                       qqwrapper.isIncludeLLW=false;
                   }
                   if(qqWrapper.address==Null || qqWrapper.address==''){
                   qqWrapper.address=qqWrapper.CrossStreets;
                  }
                  
                    QQRHelper=new QuickQuoteHelper();
                    //QQRHelper.getDurationRate(qqWrapper);
                    QQRF = new HomeBaseBeans.QuickQuoteRefreshFormat();
                    if(qqWrapper.FulfillingBranch!=null && qqWrapper.FulfillingBranch!=''){
                         QQRF=QQRHelper.refreshQQwrapper(qqWrapper, qqWrapper.FulfillingBranch, qqwrapper.TaxId, proRef.Date_From__c);
                    }else{
                         QQRF=QQRHelper.refreshQQwrapper(qqWrapper, qqWrapper.UserBranchId, qqwrapper.TaxId, proRef.Date_From__c);
                    }
                    
                if(QQRF!=null){
                     refreshQuote = new RefreshQuickQuoteService_AC();
                     d = refreshQuote.refreshQuickQuote(QQRF);  
                }       
                if(d!=null)
                {
                    if(d.errorMessage == null)
                    {
                        QQRHelper.calculateTotalAfterRefresh(d,qqWrapper);
                        system.debug('--------------qqWrapper.Rate-----------------'+qqWrapper.Rate);        
                        qqwrapper.showValidateAddress = false;
                        qqwrapper.showProdSelect = true;
                        qqwrapper.showRefreshQUote = true;
                        qqwrapper.showSaveButton = true;
                        //----------------issue 1272---------------
				          if(qqWrapper.TransactionType == 'SECO'){
				          	//qqWrapper.securityDeposit = '200.00';
				          	decimal totalCharge = 00.00;
				          	if(qqWrapper.Rate != null && qqWrapper.Rate != ''){
				          		totalCharge += decimal.valueOf(qqWrapper.Rate);
				          	}
				          	if(qqWrapper.LLW != null && qqWrapper.LLW != ''){
				          		totalCharge += decimal.valueOf(qqWrapper.LLW);
				          	}
				          	if(qqWrapper.Rental_PP_E != null && qqWrapper.Rental_PP_E != ''){
				          		totalCharge += decimal.valueOf(qqWrapper.Rental_PP_E);
				          	}
				          	if(qqWrapper.DeliveryTotal != null && qqWrapper.DeliveryTotal != ''){
				          		totalCharge += decimal.valueOf(qqWrapper.DeliveryTotal);
				          	}
				          	if(qqWrapper.PickUpTotal != null && qqWrapper.PickUpTotal != ''){
				          		totalCharge += decimal.valueOf(qqWrapper.PickUpTotal);
				          	}
				          	if(qqWrapper.LocksAmount != null && qqWrapper.LocksAmount != ''){
				          		totalCharge += decimal.valueOf(qqWrapper.LocksAmount);
				          	}
				          	if(qqWrapper.Tax != null && qqWrapper.Tax != ''){
				          		totalCharge += decimal.valueOf(qqWrapper.Tax);
				          	}
				          	qqWrapper.securityDeposit = String.valueOf(decimal.valueOf(qqWrapper.COD) - totalCharge);
				          }else{
				          	qqWrapper.securityDeposit = '00.00';
				          }
				          
				            decimal totalRecCharge = 00.00;
				            if(qqWrapper.Rate != null && qqWrapper.Rate != ''){
				          		totalRecCharge += decimal.valueOf(qqWrapper.Rate);
				          	}
				          	if(qqWrapper.LLW != null && qqWrapper.LLW != ''){
				          		totalRecCharge += decimal.valueOf(qqWrapper.LLW);
				          	}
				          	if(qqWrapper.Rental_PP_E != null && qqWrapper.Rental_PP_E != ''){
				          		totalRecCharge += decimal.valueOf(qqWrapper.Rental_PP_E);
				          	}
				          	qqWrapper.ExtraRecurringTax = String.valueOf(decimal.valueOf(qqWrapper.RecurringMonthlyCharges) - totalRecCharge);
			          //----------------issue 1272---------------
                    }         
                    else
                    {
                         ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,d.errorMessage);
                         ApexPages.addMessage(msg);
                         qqwrapper.DisplayErrorPopUp=true;
                    }
                }else{
                     ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,'Internal Server Error.');
                     ApexPages.addMessage(msg);
                     qqwrapper.DisplayErrorPopUp=true;
                }
            }
            else
            {
                 ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,'Please fill required fields');
                 ApexPages.addMessage(msg);
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainController_AC Refresh:'+e.getMessage());
        } 
        system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteMainController_AC :Refresh()');
  
    }
    
        
    public PageReference CancelAddress()
    {
        showAddressPopup = false;
        qqWrapper.Address = null;
        qqWrapper.City =null;
        qqWrapper.Country = null;
        qqWrapper.State = null;
        qqWrapper.ZipCode = null;
        
       return null;
    }      
    
    /*******************************************************************
    Purpose     : This method is use to get the list of products 
    Parameters  : None
    Returns     : None
    ********************************************************************/
    public void ProductsSelection()
    {                
         system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainController_AC :ProductsSelection'+qqWrapper+validAddressId +'---'+qqwrapper.TaxId);            
         Integer recCount = 1;
         // String resString = null;
         showProductPopup = false;
         ProductSearchService_AC productService =null;
         List<HomeBaseBeans.Products> productList =null ;
         qqwrapper.DisplayErrorPopUp=false;
         qqWrapper.ProductSize='';
         qqWrapper.PrimaryOnly=true;
         qqWrapper.ProductType='';
         qqWrapper.productSearchWord='';
         
        productTypesListNew=QuickQuoteUtilities.getProductTypeNewList();
        productSizesListNew=QuickQuoteUtilities.getProductSizeNewList();
        
         try
         {   
           if(qqwrapper.TaxId==null){
                  SelectedAddressId();
            }
            innerProductList = new List<InnerProductClass>();
            // resString = QuickQuoteProducts_AC.callProductWebservice();
            productService = new ProductSearchService_AC();
            productList=new  List<HomeBaseBeans.Products>();
            innerProductList.clear();
            if(qqWrapper.FulfillingBranch!=null && qqWrapper.FulfillingBranch!=''){
                
                if(!Test.isRunningTest()){ 
                    //productList = productService.listPrimaryProducts(qqWrapper.FulfillingBranch);
                     productList = productService.listProductsBasedOnTransactionType(qqWrapper.FulfillingBranch, qqwrapper.TransactionType, qqType);
                    
                  }else{
                    productList=MMITestDataProvider.getQHomeBaseProduct();
                  }
            }else{
               // productList = productService.listPrimaryProducts(qqWrapper.UserBranchId);
                 productList = productService.listProductsBasedOnTransactionType(qqWrapper.UserBranchId, qqwrapper.TransactionType, qqType);
            }
            if(productList[0].errorMessage == null)
            {   
              
                for(HomeBaseBeans.Products p : productList)
                {
                    InnerProductClass IC = new InnerProductClass();
                    IC.PID = p.Id;
                    IC.PDescription = p.Description;
                    IC.PQtyAvail = p.qtyAvail;                  
                    IC.PQtyFree = p.qtyFree;
                    IC.PQtyWip = p.qtyWip;
                    IC.PQtyReserved = p.qtyReserved;
                    IC.PQtyTotal = p.qtyTotal;
                    IC.PRate1 = p.rate1.rate;
                    IC.PRate2 = p.rate2.rate;
                    IC.PRate3 = p.rate3.rate;
                    IC.PRate4 = p.rate4.rate;
                    IC.PRate5 = p.rate5.rate;
                    IC.PRate6 = p.rate6.rate;
                    IC.PRate7 = p.rate7.rate;
                    IC.PRate8 = p.rate8.rate;
                    IC.PCommission1 = p.commission1;
                    IC.PCommission2 = p.commission2;
                    IC.PCommission3 = p.commission3;
                    IC.PCommission4 = p.commission4;                
                    IC.Pllw = p.llw;
                    IC.ppe = p.ppe;
                    IC.mainFeature = p.mainFeature;                 
                    IC.isSelected = false;
                    IC.RecUniqId = recCount;
                    
                    IC.pHILRM = String.valueOf(Decimal.valueOf(p.qtyWip1)+ Decimal.valueOf(p.qtyWip5));
             if(Decimal.valueOf(p.qtyTotal) > 0){
				Decimal UtilPercentInDecimal =  (Decimal.valueOf(p.qtyRented) / Decimal.valueOf(p.qtyTotal)) * 100;
                IC.pUtilPercent = String.valueOf(UtilPercentInDecimal.round(System.RoundingMode.HALF_EVEN));
              }else{
                IC.pUtilPercent = '';
          }
          IC.pORNPU = p.qtywip6;
                    recCount++;
                    
                    innerProductList.add(IC);
                }
            }else{
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,productList[0].errorMessage);
                ApexPages.addMessage(msg);
                showProductPopup = true;
                ShowProduct = true;
            }
             
         }
         catch(Exception e)
         {
                
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainController_AC ProductsSelection:'+e.getMessage());
         }
         
         showProductPopup = true;
         ShowProduct = true;
         system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteMainController_AC :ProductsSelection'+validAddressId +'---'+qqwrapper.TaxId);
    }
    
    
    /*******************************************************************
    Purpose     : This method is use to createa a map between Transaction Type and Product Def Code
    Parameters  : none
    Returns     : map
    ********************************************************************/
    public void makeTransactionTypeAndDefCodeMap()
    { 
    	List<TransactionTypeAndDefCode__c> transactionTypeAndDefCodeList = null;
        mapTransactionTypeAndDefCode = new map<String,String>();
        transactionTypeAndDefCodeList = TransactionTypeAndDefCode__c.getAll().Values();
        if(transactionTypeAndDefCodeList != null && !transactionTypeAndDefCodeList.isEmpty()){
              String ttDefCodeList = transactionTypeAndDefCodeList.get(0).Transaction_Type_And_Def_Code_Map__c;
              list<String> lstTtDefCode = ttDefCodeList.split(',');
              for(String s : lstTtDefCode){
                    list<String> ttDefCode = s.split('_');
                    mapTransactionTypeAndDefCode.put(ttDefCode[0],ttDefCode[1]);
              }
     	 }
    }
    
    /*******************************************************************
    Purpose     : This method is use to validate the products according to Transaction Type
    Parameters  : Product Name, Transaction Type
    Returns     : True / false
    ********************************************************************/
    public Boolean ValidateProductWithTransactionType(String ProductName, String TransactionType)
    { 
    	if(mapTransactionTypeAndDefCode.containsKey(TransactionType) && mapTransactionTypeAndDefCode.get(TransactionType) == 'All'){
    		return true;
    	}
    	Boolean isValid = false;
    	List<Product_And_Def_Code__c> lstProductAndDefCode = QuickQuoteMainDAO.getLstProductAndDefCode(ProductName);
    	if(lstProductAndDefCode != null && !lstProductAndDefCode.isEmpty()){
    		if(mapTransactionTypeAndDefCode.get(TransactionType) == lstProductAndDefCode[0].Def_Code__c){
    			isValid =  true;
    		}
    	}
    	return isValid;
    }
    
    /*******************************************************************
    Purpose     : This method is use to get the list of products 
    Parameters  : None
    Returns     : None
    ********************************************************************/
    public void getSpecificProductDetail()
    {                
         system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainController_AC :getSpecificProductDetail'+qqWrapper.Product+validAddressId +'---'+qqwrapper.TaxId);            
         Integer recCount = 1;
         ProductSearchService_AC productService =null;
         HomeBaseBeans.Products productDetail =null ;
         QuickQuoteHelper qqHelper=null;
         string prodCodeId;
         qqwrapper.DisplayErrorPopUp=false;
         try
         {   if(qqwrapper.TaxId==null){
                  SelectedAddressId();
              }
           prodCodeId=System.currentPageReference().getParameters().get('prodCode');
           if(!ValidateProductWithTransactionType(prodCodeId, qqWrapper.TransactionType)){
           		ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,'The selected Product is not allowed with this transaction type!');
                ApexPages.addMessage(msg);
           }
            productService = new ProductSearchService_AC();
            productDetail=new  HomeBaseBeans.Products();
           if(prodCodeId==''|| prodCodeId==null){
                     qqwrapper.showValidateAddress = false;
                  qqwrapper.showProdSelect = true;
                  qqwrapper.showRefreshQUote = true;
                  qqwrapper.showSaveButton = false;
                  enableDuration=false;
                  qqwrapper.Rate1 = null;
                  qqwrapper.Rate5 = null;
                  qqwrapper.Rate7 = null;
           }else{
              if(qqWrapper.FulfillingBranch!=null && qqWrapper.FulfillingBranch!=''){
                  if(!Test.isRunningTest()){ 
                     productDetail = productService.getSpecificProducts(prodCodeId, qqWrapper.FulfillingBranch);
                  }else{
                    productDetail=MMITestDataProvider.getQHomeBaseProductSingle();
                  }
              }else{
                   productDetail = productService.getSpecificProducts(prodCodeId, qqWrapper.UserBranchId);
              }
           
              if(productDetail.errorMessage == null)
              {
                      InnerProductClass IC = new InnerProductClass();
                      IC.PID = productDetail.Id;
                      IC.PDescription = productDetail.Description;
                      IC.PQtyAvail = productDetail.qtyAvail;                  
                      IC.PQtyFree = productDetail.qtyFree;
                      IC.PQtyWip = productDetail.qtyWip;
                      IC.PQtyReserved = productDetail.qtyReserved;
                      IC.PQtyTotal = productDetail.qtyTotal;
                      IC.PRate1 = productDetail.rate1.rate;
                      IC.PRate2 = productDetail.rate2.rate;
                      IC.PRate3 = productDetail.rate3.rate;
                      IC.PRate4 = productDetail.rate4.rate;
                      IC.PRate5 = productDetail.rate5.rate;
                      IC.PRate6 = productDetail.rate6.rate;
                      IC.PRate7 = productDetail.rate7.rate;
                      IC.PRate8 = productDetail.rate8.rate;
                      IC.PCommission1 = productDetail.commission1;
                      IC.PCommission2 = productDetail.commission2;
                      IC.PCommission3 = productDetail.commission3;
                      IC.PCommission4 = productDetail.commission4;                
                      IC.Pllw = productDetail.llw;
                      IC.ppe = productDetail.ppe;
                      IC.mainFeature = productDetail.mainFeature;                 
                      IC.isSelected = true;
                      IC.RecUniqId = recCount;
                      
                      //qqWrapper.Duration='1';
                      qqHelper=new QuickQuoteHelper(); 
                      qqhelper.assignSelectedProdRate(qqWrapper,IC);
                      qqhelper.getDurationRate(qqWrapper);
                      system.debug('selected product rate after manual change'+qqWrapper.Rate1 +qqWrapper.Rate2 +qqWrapper.Rate3 +qqWrapper.Rate4);
          
                      qqHelper.emptyQQWrapper(qqWrapper);
        
                      qqwrapper.showValidateAddress = false;
                      qqwrapper.showProdSelect = true;
                      qqwrapper.showRefreshQUote = true;
                      qqwrapper.showSaveButton = false;
                      enableDuration=true;
                        

              }else{
                  ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,productDetail.errorMessage);
                  ApexPages.addMessage(msg);
                  qqwrapper.showValidateAddress = false;
                  qqwrapper.showProdSelect = true;
                  qqwrapper.showRefreshQUote = true;
                  qqwrapper.showSaveButton = false;
                  enableDuration=false;
                  qqwrapper.Rate1 = null;
                  qqwrapper.Rate5 = null;
                  qqwrapper.Rate7 = null;
              }
           }
           
         }
         catch(Exception e)
         {    
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainController_AC getSpecificProductDetail:'+e.getMessage());
         }
         system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteMainController_AC :getSpecificProductDetail'+qqwrapper);
    }

    /*******************************************************************
    Purpose     : This method is use to get the list of products 
    Parameters  : None
    Returns     : None
    ********************************************************************/
    public void getRateOnDurationChange()
    {                
         system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainController_AC :getRateOnDurationChange'+istransChanged+isValidated+qqWrapper+validAddressId +'---'+qqwrapper.TaxId);  
         QuickQuoteHelper qqHelper=null;
         qqwrapper.DisplayErrorPopUp=false;
         string prodCodeId;
         try
         {   
         
           
           if(qqWrapper.Product!=null && qqWrapper.Product!=''){
                  qqHelper=new QuickQuoteHelper(); 
                  qqHelper.emptyQQWrapper(qqWrapper);
                  qqhelper.getDurationRate(qqWrapper);
            } 
            qqwrapper.showSaveButton = false;
             qqwrapper.showRefreshQUote=true;
            /*if(qqwrapper.TaxId!=null && isValidated==true){
              isValidated=false;
              istransChanged=false;
            }
            
            if(isValidated!=null && isValidated==false){
                qqwrapper.showRefreshQUote=true; 
                system.debug('button enabled');
            }else if(istransChanged!=null && istransChanged==true){
              qqwrapper.showRefreshQUote=false;
               system.debug('button disabled');
            }*/
             
         }catch(Exception e)
         {    
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainController_AC getRateOnDurationChange:'+e.getMessage());
         }
         system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteMainController_AC :getRateOnDurationChange'+qqwrapper.Rate+validAddressId +'---'+qqwrapper.TaxId+qqWrapper.showRefreshQUote+ istransChanged+isValidated);
    }
   
    /*******************************************************************
    Purpose     : This action function is use to initiate the validate address
                  webservice
    Parameters  : None
    Returns     : None
    ********************************************************************/
    public pageReference ValidateAddress()
    {         
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainController_AC :ValidateAddress'+countryId2+zipCode2+state2+validAddressId +'---'+qqwrapper.TaxId);
        qqwrapper.DisplayErrorPopUp = false;
        dispDescAddrPopUp=false;
        disableTaxOkButton=false;
        HomeBaseBeans.AddressBean addressBean =null;
        try{ 
              
                        addressBean = new HomeBaseBeans.AddressBean();
                        if(address1!=null){
                        addressBean.street = address1;
                        }else{
                                addressBean.street='';
                        }
                        if(address3!=null){
                        addressBean.city = address3;
                        }else{
                                addressBean.city='';
                        }
                        if(state2 == null ||  state2 == 'null')
                        addressBean.state = '';
                        else
                        addressBean.state = state2;
                        if(countryId2!=null){
                        if(countryId2.equalsIgnoreCase('CANADA')){
                            addressBean.country = 'CAN';
                        }else{
                                addressBean.country = countryId2;
                        }
                        }else{
                                 addressBean.country='';
                        }
                        if(zipCode2!=null){
                        addressBean.zip = zipCode2;
                        }else{
                                addressBean.zip='';
                        }
                    AddressInnerClassList.clear();    
                    ValidateAddressService_AC validateAddress = new ValidateAddressService_AC();
                    List<HomeBaseBeans.TaxIds> validateAddressResponse = validateAddress.taxIdLookup(addressBean);
                     if(Test.isRunningTest()){ 
                     validateAddressResponse = MMITestDataProvider.getQHomeBaseTax();
                  }

                    AddressInnerClassList = new List<AddressInnerClass>();
         
                    System.debug(addressBean+'Validate address lookup is : '+validateAddressResponse);
                    
                     Integer addressRecCount = 1;
                     if(validateAddressResponse[0].errorMessage == null){
                         for(HomeBaseBeans.TaxIds TI : validateAddressResponse){
                            AddressInnerClass IC = new AddressInnerClass();
                            IC.Id = TI.Id;
                            IC.city = TI.city;
                            IC.taxAreaStatus = TI.taxAreaStatus;
                            IC.country = TI.country;
                            IC.country1 = TI.country1;
                            IC.state = TI.state;
                            IC.stateDescription = TI.stateDescription;
                            IC.countryDescription = TI.countryDescription;
                            IC.RecUniqId = addressRecCount;
                            AddressInnerClassList.add(IC);  
                            addressRecCount++;              
                         }
                         showAddressPopup  = true;
                     }else{
                         ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,validateAddressResponse[0].errorMessage);
                         ApexPages.addMessage(msg);
                         disableTaxOkButton=true;
                         showAddressPopup  = true;
                     } 
                
            }catch(Exception e){
                     system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainController_AC ValidateAddress:'+e.getMessage());
            }           
        system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteMainController_AC :ValidateAddress'+AddressInnerClassList+validAddressId +'---'+qqwrapper.TaxId);  
       return null;
    }
    

    // On click on OK button on Validate Address
    public void SelectedAddressId()
    {
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainController_AC :SelectedAddressId()'+istransChanged+isValidated+AddressInnerClassList+validAddressId +'---'+qqwrapper.TaxId);  
        showAddressPopup  = false;
        isValidated=false;
        istransChanged=false;
        try{
                for(AddressInnerClass I : AddressInnerClassList)
                {
                    Integer recNumber;
                    if(System.currentPageReference().getParameters().get('selectedTex') != null)
                    {       
                            recNumber =  Integer.valueOf(System.currentPageReference().getParameters().get('selectedTex'));
                    }
                    if(I.RecUniqId == recNumber)
                    {       
                        validAddressId = I.Id;
                        qqwrapper.TaxId=I.Id;
                        
                        
                        if(I.city!=null && I.city!=''){
                 qqWrapper.city=I.city;
                }
                
                if(I.state!=null && I.state!=''){
                 qqWrapper.state=I.state;
                } 

                        if(!isErrorInValidateAddress)
                        {    
                            qqwrapper.showValidateAddress = false;
                            qqwrapper.showProdSelect = true;
                            qqwrapper.showRefreshQUote = true;
                            if(qqWrapper.Product!=null && qqWrapper.Product!=''){
                              enableDuration=true;
                            }
                             
                        }                        
                    }
                }
                system.debug('-----------qqWrapper.TransactionType------------'+qqWrapper.TransactionType);
                if(qqWrapper.TransactionType == 'MOBO' || qqWrapper.TransactionType == 'SECO'){
                	qqWrapper.Duration='2';
                }else{
                	qqWrapper.Duration='1';
                }
               
        }catch(Exception e){
                     system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainController_AC ValidateAddress:'+e.getMessage());
            } 
        system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteMainController_AC :SelectedAddressId()'+validAddressId+'--'+qqwrapper.TaxId+isValidated+' '+istransChanged);
    }
    
   
    /*******************************************************************
    Purpose     : This action function is use to initiate the Descarte webservice 
                  for fulfilling branch
    Parameters  : None
    Returns     : None
    ********************************************************************/
   public PageReference SelectFulfillingBranch()
    {
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainController_AC :SelectFulfillingBranch()'+validAddressId +'---'+qqwrapper.TaxId);
        ValidateAddressService_AC validateAddress=null;
        List<HomeBaseBeans.webAddresses> validateAddressResponse;
        DescarteInnerClassList = new List<DescarteInnerClass>();
        disableAddressOkButton=false;
        showAddressPopup  = false;
       // if(checkZipCodeValidation())
       // {
        HomeBaseBeans.AddressBean addressBean = new HomeBaseBeans.AddressBean();
        //addressBean.BranchId=qqWrapper.UserBranchId;
        addressBean.BranchId = loginUserRec.Branch_Id__c;
        if(qqWrapper.address!=null && qqWrapper.address!=''){
          addressBean.street = qqWrapper.address;
        }
        addressBean.crossStreet=qqWrapper.CrossStreets;
         addressBean.fulfillingId = qqWrapper.FulfillingBranch;
        if(qqWrapper.city!=null ){
        addressBean.city = qqWrapper.city;
        }
        
        if(qqWrapper.state!=null && qqWrapper.state!='-None-'){
        addressBean.state = qqWrapper.state;
        }else{
              addressBean.state='';
        }
        addressBean.country = qqWrapper.country;
        if(qqWrapper.zipCode!=null ){
           addressBean.zip = qqWrapper.zipCode;
        }
        
        if(qqWrapper.TransactionType!=null && qqWrapper.TransactionType!='-None-'){
            addressBean.transactionType=qqWrapper.TransactionType;
        }else{
          addressBean.transactionType='';
        }
        
       // if(qqWrapper.country!=null && qqWrapper.country!='' && qqWrapper.zipCode!=null && qqWrapper.State != null)
      //  {
      if(qqWrapper.country!=null && qqWrapper.country!='' && ((qqWrapper.CrossStreets!=null && qqWrapper.CrossStreets!='') || (qqWrapper.address!=null && qqWrapper.address!='')))
       {
            try{ 
                DescarteInnerClassList.clear();
                validateAddress = new ValidateAddressService_AC();  
                validateAddressResponse = validateAddress.descartesLookup(addressBean);
                if(Test.isRunningTest()){ 
                       validateAddressResponse = MMITestDataProvider.getQHomeBaseWebAdd();
               }
                System.debug(addressBean+'Validate address lookup is : '+validateAddressResponse);
                if(validateAddressResponse[0].errorMessage == null)
                {
                   
                    Integer i = 1;
                    
                    for(HomeBaseBeans.webAddresses w : validateAddressResponse)
                    {
                            DescarteInnerClass IC = new DescarteInnerClass();
                            IC.companyId = w.companyId;
                            IC.branchId = w.branchId;
                            IC.address1 = w.address1;
                            IC.address2 = w.address2;
                            IC.address3 = w.address3;
                            IC.address4 = w.address4;
                            IC.state = w.state;
                            IC.zipCode = w.zipCode;
                            IC.countryId = w.countryId;
                            IC.crossStreet1 = w.crossStreet1;
                            IC.crossStreet2 = w.crossStreet2;
                            IC.taxId = w.taxId;
                            if(w.distanceFromBranch!=null){
                               IC.distanceFromBranch = string.valueof(Decimal.valueof(w.distanceFromBranch).setScale(2));
                            }
                            IC.deliveryZone = w.deliveryZone;
                            IC.zoneWarning = w.zoneWarning;
                            if(w.zoneWarning != null && w.zoneWarning != ''){
                              IC.zoneWarning = w.zoneWarning;
                            }
                            IC.latitude = w.latitude;
                            IC.longitude = w.longitude;
                            IC.distanceBranch = w.distanceBranch;
                            
                            if(w.fulfillingBranchId != null && w.fulfillingBranchId != ''){
                            IC.fulfillingBranch = w.fulfillingBranchId;
                            }else{
                               IC.fulfillingBranch = qqWrapper.FulfillingBranch;
                            }
                            if(w.fulfillingBranchName != null && w.fulfillingBranchName != ''){
                              IC.fulfillingBranchName = w.fulfillingBranchName;
                            }else{
                            IC.fulfillingBranchName = w.fulfillingBranchName;
    
                            }
                            IC.oldPostalCode = w.oldPostalCode;  
                            IC.RecUniqId = i;
                            i++;
                            DescarteInnerClassList.add(IC);                 
                    }
                    isErrorInValidateAddress = false;
                    
                    if(!DescarteInnerClassList.isEmpty()){
                        disableAddressOkButton=true;
                    }
                    
                }
                else
                {
                    ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,validateAddressResponse[0].errorMessage);
                    ApexPages.addMessage(msg);
                    isErrorInValidateAddress = true;
                    //DisplayErrorPopUp=true;
                }
               
                dispDescAddrPopUp = true;
                selectFulfillingLoaded = true; 
            }
            catch(Exception e)
            {
               system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainController_AC SelectFulfillingBranch:'+e.getMessage());
                isErrorInValidateAddress = true;
            }
            
         }
       else
        {
             ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,'Required fields are missing');
             ApexPages.addMessage(msg);
             dispDescAddrPopUp = true;
             selectFulfillingLoaded = true;
             isErrorInValidateAddress = true;  
        }
       /* }else{
            dispDescAddrPopUp = true;
            selectFulfillingLoaded = true;

            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,'Zip Code is not valid');
            ApexPages.addMessage(msg);
        }*/
        system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteMainController_AC :SelectFulfillingBranch()'+validAddressId +'---'+qqwrapper.TaxId+    dispDescAddrPopUp);
        return null;
        
    }
        
    boolean selectFulfillingLoaded = false;
    public boolean getSelectFulfillingLoaded()
    {
            return selectFulfillingLoaded;
    }
        
    /*******************************************************************
    Purpose     : This action function is use to select fulfilling branch
                   functionality 
    Parameters  : None
    Returns     : None
    ********************************************************************/ 
    public PageReference FulfillingBranchSelected()
    {
        system.debug(LoggingLevel.DEBUG,'Entring QuickQuoteMainController_AC :FulfillingBranchSelected()');
        latitudeForCapLukp = '';
        longitudeForCapLukp = '';
        /*address1 = null;
        address2 = null;
        address3 = null;
        address4 = null;
        state2 = null;
        zipCode2 = null;
        countryId2  = null;*/
  
        dispDescAddrPopUp  = false;
        try{
                for(DescarteInnerClass I : DescarteInnerClassList)
                {
                    Integer recNumber;
                    if(System.currentPageReference().getParameters().get('selectedAddr') != null)
                    {       
                        recNumber =  Integer.valueOf(System.currentPageReference().getParameters().get('selectedAddr'));
                    }
                    if(I.RecUniqId == recNumber)
                    {       
                        qqWrapper.FulfillingBranch = I.fulfillingBranch;
                        //qqWrapper.UserBranchId = I.fulfillingBranch;
                        qqWrapper.distanceFromBranch=I.distanceFromBranch;
                        qqWrapper.DeveloperZone = I.deliveryZone;
                        address1 = I.address1;
                        address2 = I.address2;
                        address3 = I.address3;
                        address4 = I.address4;
                        if(I.State!=null)
                        state2 = I.State;
                        if(I.zipCode!=null)
                        zipCode2 = I.zipCode;
                        if(I.countryId!=null)
                        countryId2  = I.countryId;
                        crossStreet2=I.crossStreet1;
                        
                        if(I.crossStreet1!=null && I.crossStreet1!=''){
                          qqWrapper.CrossStreets=I.crossStreet1;
                        }
                
                if(I.address3!=null && I.address3!=''){
                 qqWrapper.city=I.address3;
                }
                addressErrorMessage = I.zoneWarning;
                if(I.State!=null && I.State!=''){
                 qqWrapper.state=I.State;
                }
                if(I.countryId!=null && I.countryId!=''){
                   qqWrapper.country=I.countryId;
                }
               
                if(I.zipCode!=null && I.zipCode!=''){
                   qqWrapper.zipCode=I.zipCode;
                }
                    latitudeForCapLukp = I.latitude;
                    longitudeForCapLukp = I.longitude;
                    qqWrapper.longitudeToInsert =I.longitude;
                    qqWrapper.latitudeToInsert=I.latitude;
                        
                    }
                 }
             
              system.debug('--------------------qqWrapper.DeveloperZone-------------'+qqWrapper.DeveloperZone);
             ValidateAddress();
             DisableKnowDelZoneBtn();
             system.debug('--------------------isknowZoneRatesBtnDisabled-------------'+isknowZoneRatesBtnDisabled);
         }catch(Exception e){
              system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainController_AC FulfillingBranchSelected:'+e.getMessage());
         }
            
         system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteMainController_AC :FulfillingBranchSelected()');
         return null;
        
    }
        
    public PageReference CancelFulfillingBranchSelected()
    {   
        dispDescAddrPopUp  = false;
        qqwrapper.showValidateAddress = true;
        qqwrapper.showProdSelect = false;
        return null;
    }
        
   
    /*******************************************************************
    Purpose     : This method is use to initiate country webservice
    Parameters  : None
    Returns     : None
    ********************************************************************/  
    public void CountriesList()
    {
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainController_AC :CountriesList()');
        CountryService_AC CountryService = null;
        List<HomeBaseBeans.countries> Countries;
        qqwrapper.DisplayErrorPopUp = false;
        try
        {   
            CountryService = new CountryService_AC();
            Countries = CountryService.listCountry();
             if(Test.isRunningTest()){ 
                  Countries = MMITestDataProvider.getQHomeBasecontry();
             }
            System.debug('Countries are : '+Countries);
            if(Countries[0].errorMessage == null)
            {
                List<String> countryNameList = new List<String>();
                CountryOptions.add(new SelectOption('','-None-'));
                for(HomeBaseBeans.countries c : Countries)
                {   
                    if(c.Name == 'USA' || c.Name == 'Canada')
                    {
                        CountryOptions.add(new SelectOption(c.Id,c.Name));
                    }
                }  
                if(qqWrapper.Country != 'USA' && qqWrapper.Country != 'CAN'){
                  qqWrapper.Country = 'USA';
                } 
            }
            else
            {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,Countries[0].errorMessage);
                ApexPages.addMessage(msg);
                qqwrapper.DisplayErrorPopUp=true;
            }
        }
        catch(Exception e)
        {
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainController_AC CountriesList:'+e.getMessage());
        }    
        system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteMainController_AC :CountriesList()'+CountryOptions);
    }
    
    /*******************************************************************
    Purpose     : This method is use to initiate state webservice
    Parameters  : None
    Returns     : None
    ********************************************************************/  
    public void StatesList(){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainController_AC :StatesList()');               
        StateService_AC stateService = null;
        List<HomeBaseBeans.States> states ;
        qqwrapper.DisplayErrorPopUp = false;
        try{   
            if(qqWrapper.Country != 'USA' && qqWrapper.Country != 'CAN'){
              qqWrapper.Country = 'USA';
            }  
            stateService = new StateService_AC();
            states = stateService.listStates(qqWrapper.Country);
             if(Test.isRunningTest()){ 
                  states = MMITestDataProvider.getQHomeBaseState();
             }
            StateOptions = new List<SelectOption>();
            if(states[0].errorMessage == null){    
                StateOptions = new List<SelectOption>();
                StateOptions.add(new SelectOption('','-None-'));
                innerStateList = new List<stateInnerClass>();
                for(HomeBaseBeans.States ss : states)
                {
                    StateOptions.add(new SelectOption(ss.Id,ss.Id));
                    
                    stateInnerClass IC = new stateInnerClass();
                    IC.Id = ss.Id;
                    IC.Name = ss.Name;
                    IC.countryId = ss.countryId;
                    IC.companyId = ss.companyId;
                    
                    innerStateList.add(IC);
                }
                
                makeAddAvailable();
            }else{
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,states[0].errorMessage);
                ApexPages.addMessage(msg);
                qqwrapper.DisplayErrorPopUp=true;
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainController_AC StatesList:'+e.getMessage());

        } 
        system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteMainController_AC :StatesList()'+innerStateList);  
    }       
    
    public List<stateInnerClass> innerStateList = new List<stateInnerClass>();
   
        
    /*******************************************************************
    Purpose     : This method is use to initiate TransactionList
                  webservice
    Parameters  : None
    Returns     : None
    ********************************************************************/  
    public PageReference TransactionWebservice()
    {
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainController_AC :TransactionWebservice()');
        TransactionListService_AC transactionService =null;
        List<HomeBaseBeans.transactions> transactionResponse ; 
        try{
                transactionService = new TransactionListService_AC();
              
                if(qqWrapper.FulfillingBranch!=null && qqWrapper.FulfillingBranch!=''){
                 transactionResponse = transactionService.listActiveTransactions(qqWrapper.FulfillingBranch);
            }else{
                  transactionResponse = transactionService.listActiveTransactions(qqWrapper.UserBranchId);
            }
                qqwrapper.DisplayErrorPopUp = false;
                if(transactionResponse[0].errorMessage == null)
                {
                    transactionOptions = new List<SelectOption>();
                    transactionOptions.add(new SelectOption('-None-','-None-'));
                    for(HomeBaseBeans.transactions TT : transactionResponse)
                    {       
                        if(TT.description!='Chico Non-Container Rental'&&
                        TT.description!='OTG'&&
                        TT.description!='OTG Warehouse' && TT.description!='Sales Order Fleet Sales' && 
                        TT.description!='Sales Order MFG/Accessories' && TT.description!='Sale of Service' &&
                        TT.description!='Sales Order Wholesale Direct')           
                        transactionOptions.add(new SelectOption(TT.Id,TT.description));
                    }
                }
                else
                {
                     ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,transactionResponse[0].errorMessage);
                     ApexPages.addMessage(msg);
                     qqwrapper.DisplayErrorPopUp=true;
                }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainController_AC TransactionWebservice:'+e.getMessage());

        } 
        system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteMainController_AC :TransactionWebservice()'+transactionOptions);  
        return null;
       
    }
     /*******************************************************************
    Purpose     : This method is use to increase lock and quantity 
    Parameters  : None
    Returns     : None
    ********************************************************************/  
    public void inc()
    {
        if(qqWrapper.Locks >= 0)
        {
          qqWrapper.Locks = qqWrapper.Locks + 1;
        } 
        if(qqWrapper.Quantity >= 0)
        {
           qqWrapper.Quantity = qqWrapper.Quantity + 1; 
        }
    }
    
    /*******************************************************************
    Purpose     : This method is use to decrease lock and quantity 
    Parameters  : None
    Returns     : None
    ********************************************************************/ 
    public void dec()
    {
       if(qqWrapper.Locks > 0)
       {
          qqWrapper.Locks = qqWrapper.Locks - 1;
       }
       if(qqWrapper.Quantity > 0)
       {
          qqWrapper.Quantity = qqWrapper.Quantity - 1; 
       }
    }
    
    /*******************************************************************
    Purpose     : This method is use to call webservice methods on load
    Parameters  : None
    Returns     : None
    ********************************************************************/ 
    public void LoadWBs()
    {
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainController_AC :LoadWBs()');
        qqWrapper.isIncludeLLW = true;
        qqWrapper.isFuelSurcharge = true;  
        qqWrapper.showValidateAddress = true;
        String salesRepId;
       
        try{
              Oauth_WebService.TestCallout();
              AmendShipping();
              qqwrapper.DisplayErrorPopUp = false;
              CountriesList(); 
              if(qqWrapper.UserBranchId != null || qqWrapper.FulfillingBranch!=null)
              {
                 TransactionWebservice();
              }         
              callBranchWebservice();
              QuickQuoteMainService qqService=new QuickQuoteMainService();
              salesRepId=qqService.getuserSalesRepId();
              
              boolean check = pattern.matches('[0-9]+',salesRepId.trim()); 
              if(!check){
                salesRepErr=true;
                
              }
     
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainController_AC LoadWBs:'+e.getMessage());

        }
        system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteMainController_AC :LoadWBs()');
    }
    
    /*******************************************************************
    Purpose     : This action function is use to call branch webservice 
    Parameters  : None
    Returns     : None
    ********************************************************************/
    public pagereference callBranchWebservice()
    {
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainController_AC :callBranchWebservice()');
        FulfillingBranchService_AC fulFillingBranch =null;
        List<HomeBaseBeans.branches> branches;
        try{
            fulFillingBranch = new FulfillingBranchService_AC();
            branches = fulFillingBranch.listBranches();
            
            if(Test.isRunningTest()){ 
               branches = MMITestDataProvider.getQHomeBaseBranch();
            }
            
            qqwrapper.DisplayErrorPopUp = false;
            if(branches[0].errorMessage == null)
            {  
               branchList = new List<showbranches>();
               Integer i = 1;
               for(HomeBaseBeans.branches w : branches){
                    showbranches s = new showbranches();
                    s.id = w.id;
                    s.name = w.name;
                    s.RecUniqId = i;
                    i++;
                    branchList.add(s);
                }
              }else{
                  ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,branches[0].errorMessage);
                  ApexPages.addMessage(msg);
                  qqwrapper.DisplayErrorPopUp=true;
             }
         }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainController_AC callBranchWebservice:'+e.getMessage());

         }
         system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteMainController_AC :callBranchWebservice()'+branchList);
         return null;
        
    }
    
    /*******************************************************************
    Purpose     : This action function is use to search address functionality
    Parameters  : None
    Returns     : None
    ********************************************************************/
    public PageReference SearchDescAddress()
    {
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainController_AC :SearchDescAddress()');
        try{
            branchSearchList = new List<showbranches>();      
            if((qqWrapper.BranchIdSearchWord == null || qqWrapper.BranchIdSearchWord == '') && (qqWrapper.BranchNameSearchWord == null || qqWrapper.BranchNameSearchWord == ''))
            {   
                showSearchBranchIdTable = false;
            }
            else
            {           
                for(showbranches I : branchList)
                {
                    if((qqWrapper.BranchIdSearchWord!= '') && (I.Id).startswith(qqWrapper.BranchIdSearchWord) || (qqWrapper.BranchNameSearchWord != '' ) &&(I.Name.toLowerCase()).Contains(qqWrapper.BranchNameSearchWord.toLowerCase()))
                    {
                        branchSearchList.add(I);
                    }
                }
                showSearchBranchIdTable = true;
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainController_AC SearchDescAddress:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteMainController_AC :SearchDescAddress()'+branchSearchList);    
        return null;
        
    }
    /*******************************************************************
    Purpose     : This method is use to select branch functionality
    Parameters  : None
    Returns     : None
    ********************************************************************/
    public void SelectedBranchMethod(){
       system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainController_AC :SelectedBranchMethod()'+branchList);                              
       dispBranchPopUp  = false;  
       try{          
           addressErrorMessage = '';
      qqWrapper.distanceFromBranch = '';  
           for(showbranches I : branchList){
               Integer recNumber;            
               if(System.currentPageReference().getParameters().get('selectedBranch') != null){       
                   recNumber =  Integer.valueOf(System.currentPageReference().getParameters().get('selectedBranch'));
               }
               if(I.RecUniqId == recNumber){
                   BranchId = I.id;
                   qqWrapper.FulfillingBranch = I.id;              
               }
           }
           if(qqwrapper.showValidateAddress){
                qqwrapper.showValidateAddress = true;
           }else{
                qqwrapper.showValidateAddress = false;
           }
           
           if(qqwrapper.showSaveButton){
               qqwrapper.showSaveButton = true;
           }else{
               qqwrapper.showSaveButton = false;
           }
           if(qqwrapper.showRefreshQUote){
               qqwrapper.showRefreshQUote = true;
           }else{
               qqwrapper.showRefreshQUote = false;
           }
           if(qqwrapper.showProdSelect){
               qqwrapper.showProdSelect = true;
           }else{
               qqwrapper.showProdSelect = false;
           }
     makeAddAvailable();
       }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainController_AC SelectedBranchMethod:'+e.getMessage());
       }
       system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteMainController_AC :SelectedBranchMethod()'+System.currentPageReference().getParameters().get('selectedBranch')+ qqWrapper.FulfillingBranch);
    }
        
   
     public Pagereference onChangeFulfillingBranchId(){
        try{
          addressErrorMessage = ''; 
          qqWrapper.distanceFromBranch = null;
      if(qqWrapper.FulfillingBranch != null && qqWrapper.FulfillingBranch != ''){
        String ErrorMessageIs='Yes';
            for(showbranches I : branchList){
             if(qqWrapper.FulfillingBranch == I.id){
               qqWrapper.FulfillingBranch = I.id;
               ErrorMessageIs = 'No';
             }
            }
            if(qqWrapper.FulfillingBranch != null && qqWrapper.FulfillingBranch != ''){
              if(ErrorMessageIs == 'Yes'){ 
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,'Fulfilling Branch '+qqWrapper.FulfillingBranch+ ' Not Found');
                ApexPages.addMessage(msg);
                qqWrapper.FulfillingBranch = null;
              }
            }
      }
      makeAddAvailable();
        }catch(Exception e){
        }
        return null;
     }
        
    /*******************************************************************
    Purpose     : This action function is use to save quick quote functionality
                  and call insert quick quote web service .
    Parameters  : None
    Returns     : None
    ********************************************************************/
    public pagereference saveQuickQuote()
    {
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainController_AC :saveQuickQuote()');
        QuickQuoteMainService qqService=new QuickQuoteMainService();
        Database.LeadConvertResult lcr=null;
        MMI_Quotes__c insertQuote =null;
        String quoteOppID=null;
        string quoteOppIDAfterUpdate;
        PageReference pf=null;
        String dateval = null;
        Map<boolean,integer> IntMap=null;
        String savePayload =null;
        CreateQuickQuoteService_AC createQuickQuote = null;
        HomeBaseBeans.CreateQuoteResponse createQuickQuoteResponse;
        string salesRepId; 
        try { 
                
             if(qqWrapper.oppContactName == null || qqWrapper.oppContactName == ''){
             	ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,'Please provide Contact First Name');
                ApexPages.addMessage(msg);
                return null;
             }
             
             if(qqWrapper.oppContactLastName == null || qqWrapper.oppContactLastName == ''){
             	ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,'Please provide Contact Last Name');
                ApexPages.addMessage(msg);
                return null;
             }
             
             if(qqWrapper.oppContactPhone == null || qqWrapper.oppContactPhone == ''){
             	ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,'Please provide Contact Phone');
                ApexPages.addMessage(msg);
                return null;
             }
             
             if(qqWrapper.Quantity == 0 ){
             	ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,'Please provide # of Units');
                ApexPages.addMessage(msg);
                return null;
             }
             /*if(qqWrapper.Duration == '0' ){
             	ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,'Please provide rental duration');
                ApexPages.addMessage(msg);
                return null;
             }*/
             if(qqWrapper.Whydoyouneedstorage == null ||  qqWrapper.Whydoyouneedstorage == '' || qqWrapper.Whydoyouneedstorage == '--None--'){
             	ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,'Please select storage use');
                ApexPages.addMessage(msg);
                return null;
             }
             if(qqwrapper.Howlongwillyouneedyourunit == null || qqwrapper.Howlongwillyouneedyourunit == '' || qqwrapper.Howlongwillyouneedyourunit == '--None--'){
             	ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,'Please select How long will you need your unit?');
                ApexPages.addMessage(msg);
                return null;
             }
             
             if(proRef.Date_From__c!=null && proRef.Date_From__c >= system.today()){
               if(proRef.Close_Date__c!=null  &&  proRef.Close_Date__c >= system.today()){
                        
                 dateval = proRef.Date_From__c.year()+'-'+proRef.Date_From__c.month()+'-'+proRef.Date_From__c.day();
           
                 IntMap = new Map<boolean, integer>();
                 IntMap.put(true,1);
                 IntMap.put(false,0);
                 salesRepId=qqService.getuserSalesRepId();
                 //"accountId":"G101251",removed  before product
                 if(qqwrapper.TaxId==null){
                  SelectedAddressId();
                 }
                 
                 
                 if(qqWrapper.address==Null || qqWrapper.address==''){
                   qqWrapper.address=qqWrapper.CrossStreets;
                 }
                 //----------------issue 1272---------------
                  /*if(qqWrapper.TransactionType == 'SECO'){
                  	qqWrapper.securityDeposit = '200.00';
                  }else{
                  	qqWrapper.securityDeposit = '00.00';
                  }*/
                  //----------------issue 1272---------------
                 QuickQuoteSaveRequestGenerator qqsaveRequest=new QuickQuoteSaveRequestGenerator();
                  if(qqWrapper.FulfillingBranch!=null && qqWrapper.FulfillingBranch!=''){
                    savePayload=qqsaveRequest.getQuickQuoteRefreshRequest(qqWrapper,qqWrapper.FulfillingBranch,dateval,salesRepId, 'Rental');
                     
                 }else{
                    savePayload=qqsaveRequest.getQuickQuoteRefreshRequest(qqWrapper,qqWrapper.UserBranchId,dateval,salesRepId, 'Rental');
                     
                 }
                   
                /*  if(qqWrapper.FulfillingBranch!=null && qqWrapper.FulfillingBranch!=''){
                 
                      savePayload = '{"quickQuote":{"duration":'+qqWrapper.Duration+',"lead":"'+qqWrapper.LeadOppName+'","transport":"'+qqWrapper.Transport+'","transactionId":"'+qqWrapper.TransactionType+'","rate":"'+qqWrapper.Rate+'","rentalPPETotal":"'+ qqWrapper.Rental_PP_E+'","quickQuoteTotal":"'+qqWrapper.QuickQuote+'","dateFrom":'+dateval+',"shippingAddress":{"state":"'+qqWrapper.State+'","countryId":"'+qqWrapper.country+'","address1":"'+qqWrapper.Address+'","address2":"","address3":"'+qqWrapper.City+'","address4":"","zipCode":"'+qqWrapper.zipcode+'", "taxId": "'+qqwrapper.TaxId+'","fulfillingBranchId": "'+qqWrapper.FulfillingBranch+'"},"productId":"'+qqWrapper.Product+'","branchId":"'+qqWrapper.FulfillingBranch+'","llwTotal":"'+qqWrapper.LLW+'","locksTotal":"'+qqWrapper.LocksAmount+'","taxTotal":"'+qqWrapper.Tax+'","codAmount":"'+qqWrapper.COD+'","includeLLW":'+IntMap.get(qqWrapper.isIncludeLLW)+',"fuelSurcharge":'+IntMap.get(qqWrapper.isFuelSurcharge)+',"locksQty":'+qqWrapper.Locks+',"companyId": 1, "operatorId" : "result", "salesRep":'+salesRepId+', "status":"Active" }}';
                 }else{
                   savePayload = '{"quickQuote":{"duration":'+qqWrapper.Duration+',"lead":"'+qqWrapper.LeadOppName+'","transport":"'+qqWrapper.Transport+'","transactionId":"'+qqWrapper.TransactionType+'","rate":"'+qqWrapper.Rate+'","rentalPPETotal":"'+ qqWrapper.Rental_PP_E+'","quickQuoteTotal":"'+qqWrapper.QuickQuote+'","dateFrom":'+dateval+',"shippingAddress":{"state":"'+qqWrapper.State+'","countryId":"'+qqWrapper.country+'","address1":"'+qqWrapper.Address+'","address2":"","address3":"'+qqWrapper.City+'","address4":"","zipCode":"'+qqWrapper.zipcode+'", "taxId": "'+qqwrapper.TaxId+'","fulfillingBranchId": "'+qqWrapper.UserBranchId+'"},"productId":"'+qqWrapper.Product+'","branchId":"'+qqWrapper.UserBranchId+'","llwTotal":"'+qqWrapper.LLW+'","locksTotal":"'+qqWrapper.LocksAmount+'","taxTotal":"'+qqWrapper.Tax+'","codAmount":"'+qqWrapper.COD+'","includeLLW":'+IntMap.get(qqWrapper.isIncludeLLW)+',"fuelSurcharge":'+IntMap.get(qqWrapper.isFuelSurcharge)+',"locksQty":'+qqWrapper.Locks+',"companyId": 1, "operatorId" : "result", "salesRep":'+salesRepId+', "status":"Active" }}';
                 }*/
                 createQuickQuote = new CreateQuickQuoteService_AC();
                 createQuickQuoteResponse = createQuickQuote.createQuickQuote(savePayload);
                 if(Test.isRunningTest()){ 
                     createQuickQuoteResponse = MMITestDataProvider.getQHomeBaseCreateQQ();
                  }
                 
                     if(createQuickQuoteResponse.errorMessage == null){
                        //Add item code descruiption if it is null
                        //if(qqwrapper.productDescToInsert == null || qqwrapper.productDescToInsert == ''){  // commented for TFS 2709
                            //Added by Rajib----Issue 1177--------
                            String brId = FullQuoteDAO.getBranchId(qqWrapper.FulfillingBranch, leadRecId);
                            ProductSearchService_AC productServiceTemp = new ProductSearchService_AC();
                            HomeBaseBeans.Products SpecificProduct = new HomeBaseBeans.Products();
                            SpecificProduct = productServiceTemp.getSpecificProducts(qqWrapper.Product,brId);
                            if(SpecificProduct.errorMessage == null || SpecificProduct.errorMessage == ''){
                                qqwrapper.productDescToInsert = SpecificProduct.Description;
                            }
                            //Added by Rajib------Issue 1177------
                        //} // commented for TFS 2709
                        insertQuote = new MMI_Quotes__c();   
                        qqwrapper.DisplayErrorPopUp = false;
                        if(!leadRec.isEmpty()){
                                //FullQuoteDAO.createTaskBeforeSavingFQ(leadRec[0].id,'Quick Quote');
                                lcr=qqService.getConvertLeadResult(leadRec[0].id, UserInfo.getUserId(), qqwrapper);
                                FullQuoteDAO.createTaskBeforeSavingFQ(lcr.getOpportunityId(),'Quick Quote');
                                qqwrapper.SourceOfQQ = 'lead';
                                if(qqWrapper.FulfillingBranch!=null && qqWrapper.FulfillingBranch!=''){
                                     quoteOppID=qqService.insertQuickQuoteRecord(insertQuote, qqWrapper.FulfillingBranch, proRef.Date_From__c, qqwrapper.TaxId, lcr.getOpportunityId(), createQuickQuoteResponse.documentId, qqwrapper,lcr.getAccountId());
                                }else{
                                    quoteOppID=qqService.insertQuickQuoteRecord(insertQuote, qqWrapper.UserBranchId, proRef.Date_From__c, qqwrapper.TaxId, lcr.getOpportunityId(), createQuickQuoteResponse.documentId, qqwrapper,lcr.getAccountId());

                                }
                                if(quoteOppID!=null){
                                	qqwrapper.selectedOrConvertedContactId = string.valueOf(lcr.getContactId());
                                    quoteOppIDAfterUpdate=qqService.updateOppNameSales(quoteOppID, qqwrapper,proRef.Close_Date__c, proRef.When_will_you_need_your_unit__c,leadRec[0].Servicing_Branch_Id__c);
                                } 
                        }else if(!oppRec.isEmpty()){
                               qqwrapper.SourceOfQQ = 'opportunity'; 
                               if(qqWrapper.FulfillingBranch!=null && qqWrapper.FulfillingBranch!=''){
                                     quoteOppID=qqService.insertQuickQuoteRecord(insertQuote, qqWrapper.FulfillingBranch, proRef.Date_From__c, qqwrapper.TaxId,oppRec[0].id, createQuickQuoteResponse.documentId, qqwrapper,oppRec[0].AccountId);
                               }else{
                                    quoteOppID=qqService.insertQuickQuoteRecord(insertQuote, qqWrapper.UserBranchId, proRef.Date_From__c, qqwrapper.TaxId,oppRec[0].id, createQuickQuoteResponse.documentId, qqwrapper,oppRec[0].AccountId);

                               }
                               if(quoteOppID!=null){
                               		qqwrapper.selectedOrConvertedContactId = ContId;    
                                    quoteOppIDAfterUpdate=qqService.updateOppNameSales(quoteOppID, qqwrapper,proRef.Close_Date__c, proRef.When_will_you_need_your_unit__c,null);
                                }
                        }else if(!accountRec.isEmpty()){
                            qqwrapper.SourceOfQQ = 'account';
                            String oppID= qqService.insertOpportunity(accountRec[0]);
                          
                           if(qqWrapper.FulfillingBranch!=null && qqWrapper.FulfillingBranch!=''){
                                     quoteOppID=qqService.insertQuickQuoteRecord(insertQuote, qqWrapper.FulfillingBranch, proRef.Date_From__c, qqwrapper.TaxId,oppID, createQuickQuoteResponse.documentId, qqwrapper,accountRec[0].Id);
                             }else{
                                    quoteOppID=qqService.insertQuickQuoteRecord(insertQuote, qqWrapper.UserBranchId, proRef.Date_From__c, qqwrapper.TaxId,oppID, createQuickQuoteResponse.documentId, qqwrapper,accountRec[0].Id);

                             }
                             if(quoteOppID!=null){
                             		qqwrapper.selectedOrConvertedContactId = ContId;  
                                    quoteOppIDAfterUpdate=qqService.updateOppNameSales(quoteOppID, qqwrapper,proRef.Close_Date__c, proRef.When_will_you_need_your_unit__c,null);
                                } 
                          
                        }
                        if(quoteOppID!=null){
                        	 if(source == 'jp'){
                        	 	QuickQuoteMainDAO.createTaskForQQCreatedFromJP(qqwrapper.jobProfileId, 'qq');
                        	 }
                        	 //-----------------Issue 1269------------------------
                        	 Opportunity OpportunityRecAfterContactLookup = QuickQuoteMainDAO.getOppToUpdate(quoteOppID);
                        	 if(OpportunityRecAfterContactLookup != null && OpportunityRecAfterContactLookup.Opportunity_Contact_Name_LookUpFilter__c != null){
                        	 	if(!QuickQuoteMainDAO.isFollowUptaskPresent(quoteOppID)){
                        	 		QuickQuoteMainDAO.createTaskAfterQQCreationForFollowUpCall(quoteOppID,'qq',opp_ref.Next_Activity_Date__c,OpportunityRecAfterContactLookup.Opportunity_Contact_Name_LookUpFilter__c,qqwrapper);
                        	 	}
                        	 }
                        	 //-----------------Issue 1269------------------------
                             pf = new PageReference('/'+quoteOppID);
                                
                        }else{
                            return null;
                        }
                     }
                     else
                     {
                        ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,createQuickQuoteResponse.errorMessage);
                        ApexPages.addMessage(msg);
                        qqwrapper.DisplayErrorPopUp=true;
                        
                        return null;
                      }  
           }else{
              ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,'Close Date is Required and can not be past date.');
              ApexPages.addMessage(msg);
              return null;
           } 
                      
           }else{
              ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,'Delivery Date can not be past date.');
              ApexPages.addMessage(msg);
              return null;
           } 
        }
        catch(Exception e) {
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainController_AC saveQuickQuote:'+e.getMessage());
           return null; 
        }
        system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteMainController_AC :saveQuickQuote()');
        return pf;

    }

    public void ClearFullFillBrnch(){
    	qqWrapper.FulfillingBranch = '';
    	qqWrapper.DeveloperZone = '';
    	qqWrapper.distanceFromBranch = '';
    	makeAddAvailable();
    }
    /*******************************************************************
    Purpose     : This method is use to enable/disable buttons 
    Parameters  : None
    Returns     : None
    ********************************************************************/
    public void makeAddAvailable()
    {
      addressErrorMessage = '';
        qqwrapper.showValidateAddress = true;
        qqwrapper.showSaveButton = false;
        qqwrapper.showRefreshQUote = false;
        qqwrapper.showProdSelect= false;
        enableDuration=false;
       /* if(qqWrapper.product==null || qqWrapper.product=='')
        {
            qqwrapper.showProdSelect = false;
            qqwrapper.showRefreshQUote = false;
            qqwrapper.showSaveButton = false;
        }else{
                //qqwrapper.showRefreshQUote = true;
        }*/
    }
    
    /*******************************************************************
    Purpose     : This method is use to validate mendatory fields 
    Parameters  : None
    Returns     : None
    ********************************************************************/  
    public boolean checkMandatoryField()
    {
        if(qqwrapper.Product==null||qqwrapper.Product==''||
                qqwrapper.Quantity==null||
                proRef.Date_From__c==null||
                qqwrapper.Duration==null ||
                qqwrapper.TransactionType==null|| qqwrapper.TransactionType=='-None-'||
                qqwrapper.Locks == null)
        {
                return true;
        }
        else
        {
                return false;
        }
    }
        
    /*******************************************************************
    Purpose     : This method is use for zipcode validations 
    Parameters  : None
    Returns     : None
    ********************************************************************/  
    public boolean checkZipCodeValidation()
    {
        String zipRegex=null;
        Boolean isMatch=false;
        if(qqwrapper.Country == 'USA')
        {
            if(qqwrapper.ZipCode!=null && qqwrapper.ZipCode.trim()!='' && qqwrapper.ZipCode.length()<=10){
                        zipRegex='^\\d{5}((\\-)?\\d{4})?$';
                        isMatch=Pattern.matches(zipRegex,qqwrapper.ZipCode);
                                if(isMatch){
                                        return true; 
                                }else{
                                        return false;
                                }
                }else{
                   return false;
                }
        }
        else if(qqwrapper.Country == 'CAN')
        {
            if(qqwrapper.ZipCode!=null && qqwrapper.ZipCode.trim()!='' && qqwrapper.ZipCode.length()<=10){
                        zipRegex='^[ABCEGHJKLMNPRSTVXY]\\d[ABCEGHJKLMNPRSTVWXYZ]( )?\\d[ABCEGHJKLMNPRSTVWXYZ]\\d$';
                        isMatch=Pattern.matches(zipRegex,qqwrapper.ZipCode);
                                if(isMatch){
                                        return true; 
                                }else{
                                        return false;
                                }
                }else{
                   return false;
                }
        }else{
            return true;
        }
    }
    
    //action functions 
    
    
  
     public PageReference ViewBrnchSnapshot()
    {
        return new PageReference('/home/home.jsp');
    }
        
    public PageReference CancelSelectedAddressId()
    {
        showAddressPopup  = false;
        return null;
    }
    
      public PageReference SaveForLater()
    {
        return null;
    }
    public PageReference NoSale()
    {
        return null;
    }
    public PageReference RaiseSalesQuote()
    {
        return null;
    }
    public PageReference ConvertToRentalQuote()
    {
        return null;
    }
    public PageReference SaveAddress()
    {
        showAddressPopup = false;
        return null;
    }
   
    public pageReference hidedispBranchPopUp(){
    dispBranchPopUp = false;
    return null;
    }
    public pageReference showdispBranchPopUp() 
    {
      qqWrapper.BranchIdSearchWord='';
      qqWrapper.BranchNameSearchWord='';
       showSearchBranchIdTable = false;
      
        dispBranchPopUp = true;
        return null;
    }

   
     public boolean getDispAddressPopUp()
    {
        return showAddressPopup;
    }
    
    public boolean getDispProductPopUp()
    {
        return showProductPopup;
    }
    
    public PageReference setClientLoaded(){
    clientLoaded = true;
    return null; 
    } 
    public pagereference hideError()
    {
       qqWrapper.DisplayErrorPopUp = false;
        return null;
    }
    
    public class AddressInnerClass
    {
        public String Id {get;set;}
        public String taxAreaStatus {get;set;}
        public String country {get;set;}
        public String countryDescription {get;set;}
        public String country1 {get;set;}
        public String state {get;set;}
        public String stateDescription {get;set;}
        public String city {get;set;}
        public Boolean isSelected {get;set;}
        public Integer RecUniqId {get;set;}
    }
    
    public class InnerProductClass
    {
        public String PID {get;set;}
        public String PDescription {get;set;}
        public String PQtyAvail {get;set;}
        public String PQtyFree {get;set;}
        public String PQtyWip {get;set;}
        public String PQtyReserved {get;set;}
        public String PQtyTotal {get;set;}
        public String PRate1 {get;set;} 
        public String PRate2 {get;set;}
        public String PRate3 {get;set;}
        public String PRate4 {get;set;}
        public String PRate5 {get;set;}
        public String PRate6 {get;set;}
        public String PRate7 {get;set;}
        public String PRate8 {get;set;}
        public String PCommission1 {get;set;}
        public String PCommission2 {get;set;}
        public String PCommission3 {get;set;}
        public String PCommission4 {get;set;}
        
        public String pORNPU {get;set;}
        public String pHILRM {get;set;}
        public String pUtilPercent {get;set;}
        
        
        public String Pllw {get;set;}
        public String ppe {get;set;}
        public String mainFeature {get;set;}
        public boolean  isSelected {get;set;}
        public Integer RecUniqId {get;set;}
    }
     public class DescarteInnerClass
    {
            public String companyId {get;set;}      
            public String branchId {get;set;}
            public String address1 {get;set;}
            public String address2 {get;set;}
            public String address3 {get;set;}
            public String address4 {get;set;}
            public String countryId {get;set;}
            public String state {get;set;}
            public String zipCode {get;set;}
            public String crossStreet1 {get;set;}
            public String crossStreet2 {get;set;}
            public String taxId {get;set;}
            public String distanceFromBranch {get;set;}
            public String deliveryZone {get;set;}
            public String zoneWarning {get;set;}
            public String latitude {get;set;}
            public String longitude {get;set;}
            public String distanceBranch {get;set;}
            public String fulfillingBranch {get;set;}
            public String fulfillingBranchName {get;set;}
            public String oldPostalCode {get;set;}
            public boolean isSelected {get;set;}
            public Integer RecUniqId {get;set;}             
    }
    
     public class showbranches
    {
        public boolean isSelected{get;set;}
        public String Id{get;set;}
        public String Name{get;set;}
        public Integer RecUniqId {get;set;}      
    }
     public class stateInnerClass
    {
        public String companyId {get;set;}
        public String countryId {get;set;}
        public String Id {get;set;}
        public String Name {get;set;}
    }
    
    public void ShowProductPopUp()
    {
         ShowProduct = true;
         showProductPopup = true;
    } 
    
    public void disableSaveButton()
    {
        qqwrapper.showSaveButton = false;
        if(!qqWrapper.showValidateAddress){
         qqwrapper.showRefreshQUote=true;
        }
        String isItemPriceChanged = System.currentPageReference().getParameters().get('prodRate') ;
        if(isItemPriceChanged != null && isItemPriceChanged == 'edited'){
        	qqWrapper.disableReCalcBtn = false;
        }
    }
    
    public void disableReCalcButton()
    {
        qqWrapper.disableReCalcBtn = false;
    }  
    
    
    public void onChangeDelivery()
    {
        proRef.When_will_you_need_your_unit__c=proRef.Date_From__c;
        
        qqwrapper.showSaveButton = false;
        if(!qqWrapper.showValidateAddress){
         qqwrapper.showRefreshQUote=true;
        }
        
    } 
    
    
    public void changeIncludeLLW()
    {
        //disableSaveButton();
        qqWrapper.showValidateAddress=true;
        enableDuration=false;
        qqwrapper.showRefreshQUote=false;
        qqwrapper.showSaveButton = false;
        if(qqwrapper.TransactionType=='ON'){
                qqWrapper.isIncludeLLW=false;
        }else{
          qqWrapper.isIncludeLLW=true;
          if(qqwrapper.TransactionType=='MOBO' || qqwrapper.TransactionType=='SECO'){
            qqWrapper.Duration='2';
          
          }else{
            qqWrapper.Duration='1';
          }
        }
     }
    public Pagereference cancelFullQuote(){
    String cancelId;
    
    if(leadRec.size() > 0)
        {
            cancelId = leadRec[0].id;
        } 
        if(oppRec.size() > 0)
        {
            cancelId = oppRec[0].id;
      
        }
          if(accountRec.size() > 0)
        {
          cancelId = accountRec[0].id;
        }
       PageReference pf=null;
       pf = new PageReference('/'+cancelId);
      pf.setRedirect(true);
      return pf;
  }
public pageReference callCapacityLookupWebservice(){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainController_AC :callCapacityLookupWebservice');
        HomeBaseBeans.capacityLookupRequest clr = null;
        isShowcapacityLookupPopUp = true;
        try{
         if(test.isRunningTest()){
           latitudeForCapLukp = '12.321';
           longitudeForCapLukp = '-34.234';
         }
         if(longitudeForCapLukp != null && latitudeForCapLukp != null){
                isShowcapacityLookupPopUp = false;
                clr = new HomeBaseBeans.capacityLookupRequest();
                /*clr.addressLine1 = qqWrapper.Address;
                clr.City = qqWrapper.City;
                clr.countryCode = qqWrapper.Country;
                clr.postalCode = qqWrapper.ZipCode;
                clr.stateCode = qqWrapper.State;
                
                clr.sellingStoreNumber = qqWrapper.FulfillingBranch;
                clr.longitude = longitudeForCapLukp;
                clr.latitude = latitudeForCapLukp;
                
           if(test.isRunningTest()){
             clr.BranchId = '102';  
           }else{
                clr.BranchId = FullQuoteDAO.getBranchId(qqWrapper.FulfillingBranch, leadRecId);
           }
                DateTime ScheduleDelvDate = system.now();
                if(proRef.Date_From__c != null){
                    ScheduleDelvDate = proRef.Date_From__c;
                }
                String MonthVal = '';
                String DateVal = '';
                if(String.valueOf((ScheduleDelvDate).Month()).length() != 2){
                    MonthVal = '0'+(ScheduleDelvDate).Month();
                }else{
                    MonthVal = String.valueOf((ScheduleDelvDate).Month());
                }
                if(String.valueOf((ScheduleDelvDate).day()).length() != 2){
                    DateVal = '0'+(ScheduleDelvDate).day();
                }else{
                    DateVal = String.valueOf((ScheduleDelvDate).day());
                }
                String DeliveryDateTimeForCL = (ScheduleDelvDate).year()+'-'+MonthVal+'-'+DateVal;
                if(qqWrapper.deliverySlot == 'AM'){
                    DeliveryDateTimeForCL = DeliveryDateTimeForCL + 'T11:59:00.000Z'; 
                }
                if(qqWrapper.deliverySlot == 'PM'){
                    DeliveryDateTimeForCL = DeliveryDateTimeForCL + 'T23:59:00.000Z'; 
                }
                clr.DeliveryDateTime = DeliveryDateTimeForCL;
                if(qqWrapper.Product != null && qqWrapper.Product != '')
                {
                    clr.itemName = qqWrapper.Product;
                    clr.itemDescription = selectedProdDescForCapLkup;
                }*/
                clr = QuickQuoteMainDAO.createCapLkupPayload(latitudeForCapLukp, longitudeForCapLukp, qqWrapper, leadRecId, proRef.Date_From__c, selectedProdDescForCapLkup);
                 if(clr != null){
                     isShowcapacityLookupPopUp = true;
                     CapacityLookupList = new List<HomeBaseBeans.CapacityLookupHandler>();
                     CapacityLookupService_AC CLA = new  CapacityLookupService_AC();
                     CapacityLookUpXMLParser_AC c = new CapacityLookUpXMLParser_AC();
                     String CapacityResponse = CLA.callWebservice(clr);
                     if(CapacityResponse != null && CapacityResponse != ''){
                         CapacityLookupList = c.returnWebserviceResponse(CapacityResponse);
                         if(!CapacityLookupList.isEmpty()){
                         if(CapacityLookupList[0].ErrorString !='' && CapacityLookupList[0].ErrorString != null){
                             ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,CapacityLookupList[0].ErrorString);
                             ApexPages.addMessage(msg);
                             isShowcapacityLookupPopUp = true;
                         }
                         }
                         isShowcapacityLookupPopUp = true;
                     }
                 }
            }else{
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,'Longitude or Latitude is not found for the selected address.');
                ApexPages.addMessage(msg);
                isShowcapacityLookupPopUp = true;
            }
             
         }catch(Exception e){
             system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteMainController_AC callCapacityLookupWebservice: '+e.getMessage());
             ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,e.getMessage());
             ApexPages.addMessage(msg);
             isShowcapacityLookupPopUp = true;
         }
         //system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteMainController_AC :callCapacityLookupWebservice'+CapacityLookupList);
         return null;
   }
   
   public pageReference hideCapacitylookupPop(){
        isShowcapacityLookupPopUp = false;
        return null;
   }
   
   public pageReference CapacityIdSelected(){
        String selectedCapacityDate = System.currentPageReference().getParameters().get('capacitySelactedValue');
        if(test.isRunningTest()){
            selectedCapacityDate = '2013-10-10 00:00:00';
        }
        isShowcapacityLookupPopUp = false;
        proRef.Date_From__c = date.valueOf(selectedCapacityDate.substring(0,10));
        proRef.When_will_you_need_your_unit__c = date.valueOf(selectedCapacityDate.substring(0,10));
        return null;
   }
    public void ZipCodeFinder(){
        BranchLookup = new Branch_Lookup__c(); 
        system.debug('------qqWrapper.ZipCode-----'+qqWrapper.ZipCode);
        if(qqWrapper.ZipCode != null && qqWrapper.ZipCode != ''){
            QuickQuoteMainService qqService=new QuickQuoteMainService();
            BranchLookup = qqService.getBranchLookupinfo(qqWrapper.ZipCode);
            system.debug('-------BranchLookup-----------'+BranchLookup);
            if(BranchLookup != null ){
                if(BranchLookup.Country__c == 'US'){
                    qqWrapper.Country = 'USA';  
                }
                if(BranchLookup.Country__c == 'CA'){
                    qqWrapper.Country = 'CAN';  
                }
                system.debug('----qqWrapper.Country-----'+qqWrapper.Country);
                StatesList();
                qqWrapper.State = BranchLookup.State__c;
                qqWrapper.City =  BranchLookup.City__c;
            }
        }
        makeAddAvailable();
    }
    
     public void reCalculatePrice(){
     	decimal codAmt = decimal.valueOf(qqWrapper.Rate) + decimal.valueOf(qqWrapper.Rental_PP_E) + decimal.valueOf(qqWrapper.LLW) + decimal.valueOf(qqWrapper.DeliveryTotal) +  decimal.valueOf(qqWrapper.PickUpTotal) + decimal.valueOf(qqWrapper.Tax) + decimal.valueOf(qqWrapper.LocksAmount);
        if(qqWrapper.securityDeposit != null){
        	codAmt = codAmt + decimal.valueOf(qqWrapper.securityDeposit);
        }
        qqWrapper.COD = string.valueOf(codAmt);
        decimal recChrage = decimal.valueOf(qqWrapper.Rate) + decimal.valueOf(qqWrapper.Rental_PP_E) + decimal.valueOf(qqWrapper.LLW);
        if(qqWrapper.ExtraRecurringTax != null){
        	recChrage = recChrage + decimal.valueOf(qqWrapper.ExtraRecurringTax);
        } 
        qqWrapper.RecurringMonthlyCharges = string.valueOf(recChrage);
    }
    
    public void DisableKnowDelZoneBtn(){
    	system.debug('----------------qqWrapper.DeveloperZone-----------------------'+qqWrapper.DeveloperZone);
    	if(qqWrapper.DeveloperZone != null && qqWrapper.DeveloperZone != ''){
         	isknowZoneRatesBtnDisabled = true;
         }else{
         	isknowZoneRatesBtnDisabled = false;
         }
    }
    
    
    public void NoDelZoneRates(){
    	if(qqWrapper.Product != null && qqWrapper.Product != ''){
	    	HomeBaseBeans.knowZoneRatesEmailParam paramObj = new HomeBaseBeans.knowZoneRatesEmailParam();
	    	paramObj.quoteType = 'qq';
	    	if(leadRec.size() > 0){
	    		paramObj.sourceOfQuote = 'lead';
	    	}
	    	paramObj.fulfillingBranchId = qqWrapper.FulfillingBranch;
	    	paramObj.itemCode = qqWrapper.Product;
	    	QuickQuoteWrapper qq = new QuickQuoteWrapper();
	    	qq = qqWrapper;
	    	paramObj.qqWrapper = qq;
	    	paramObj.loggedInUserEmail = loginUserRec.Email;
	    	if(oppRec.size() > 0){
	    		User accOwnerDetail = QuickQuoteMainDAO.UserDetails(accRec.OwnerId);
	    		if(accOwnerDetail!= null){
	    			paramObj.sfdcAccOwnerEmail = accOwnerDetail.Email;
	    		}
	    		paramObj.oppId = oppRec[0].Id;
	    	}
	    	if(accountRec.size() > 0){
	    		User accOwnerDetail = QuickQuoteMainDAO.UserDetails(accountRec[0].OwnerId);
	    		if(accOwnerDetail!= null){
	    			paramObj.sfdcAccOwnerEmail = accOwnerDetail.Email;
	    		}
	    	}
	    	String mailError = QuickQuoteMainDAO.SendEmailToBranch(paramObj);
	    	if(test.isRunningTest()){
	    		mailError = 'test';
	    	}
	    	if(mailError != null && mailError != '' && mailError != 'Mail has been sent successfully!'){
	    		ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,mailError);
	            ApexPages.addMessage(msg);
	    	}
	    	if(test.isRunningTest()){
	    		mailError = 'Mail has been sent successfully!';
	    	}
	    	if(mailError != null && mailError != '' && mailError == 'Mail has been sent successfully!'){
	    		ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.confirm,mailError);
	            ApexPages.addMessage(msg);
	    	}
    	}else{
    		ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Please select a product!');
	        ApexPages.addMessage(msg);
    	}
    }
}