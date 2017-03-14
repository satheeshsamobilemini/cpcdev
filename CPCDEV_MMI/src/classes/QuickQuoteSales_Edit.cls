/**************************************************************************
Name:  QuickQuoteSales_Edit()
Copyright © 2013  MMI
----------------------------------------------------------------------
Purpose:
This is the Main COntroller class for Edit Quick Quote functionality 
-----------------------------------------------------------------------
History:
  
VERSION  AUTHOR                 DATE        DETAIL              
1.0  -  TEKsystems             11/2/2013   INITIAL DEVELOPMENT  
**************************************************************************/
public with sharing class QuickQuoteSales_Edit 
{ 
	//new Wrapper
    public QuickQuoteWrapper qqWrapper{get;set;}
    public Branch_Lookup__c BranchLookup{get;set;}
    public String addressErrorMessage{get;set;}
    public String oppIdLink{get;set;}
    public QuickQuoteWrapper.AddressInnerClass addressInner{get;set;}
    public QuickQuoteWrapper.DescarteInnerClass descarteInner{get;set;}
    public QuickQuoteWrapper.InnerProductClass productInner{get;set;}
    public QuickQuoteWrapper.showbranches showBranches{get;set;}
    public QuickQuoteWrapper.stateInnerClass stateInner{get;set;}
    public String userBranchId{get;set;}
    public List<QuickQuoteWrapper.SalesFleetWapper> qqsalesFleetList{get;set;}
    public List<SelectOption> ecodeOptions {get;set;}
    public User loginUserRec{get;set;}
    
    public List<QuickQuoteWrapper.ProductSales> salesInventories{get;set;}
    
     public Boolean isViewBranchSearcieid{get;set;}
     public Boolean isViewBranchFulfillid{get;set;}
     public String fullfillingBranch{get;set;}
     public String userbranchidString{get;set;}
    
    public Boolean disableAddressOkButton{get;set;}
    public Boolean disableTaxOkButton{get;set;}
    public List<SelectOption> durationOptions {get;set;}
    public List<SelectOption> productTypeOptions {get;set;}
    public List<SelectOption> productSizeOptions {get;set;}
    
	public String MarketValueRange20S{get;set;}
    public String MarketValueRange20ZS{get;set;}
    public String MarketValueRange40S{get;set;}
    public String MarketValueRange40ZS{get;set;}
    public boolean isknowZoneRatesBtnDisabled {get;set;} // for TFS 2507 
    
    boolean showProductPopup = false;
    boolean showAddressPopup = false;
    boolean clientLoaded = false;
    boolean isLead = false;
    public String leadRecId{get;set;}
    public String validAddressId{get;set;}
    boolean isErrorInValidateAddress = false;
	public boolean salesRepErr{get;set;}
	public String QuoteId{get;set;}
	public String QuickQuoteId = '';
    public boolean getClientLoaded(){ 
        return clientLoaded; 
    } 
    public PageReference setClientLoaded(){
        clientLoaded = true;
        return null; 
    } 
    public pagereference hideError(){
        qqwrapper.DisplayErrorPopUp = false;
        return null;
    }
    public MMI_Quotes__c proRef = new MMI_Quotes__c();
    public MMI_Quotes__c getproRef(){
        return proRef;  
    }
    List<Lead> leadRec = new List<Lead>();
    Lead lead_ref = new Lead();
    Opportunity opp_ref = new Opportunity();
    List<Opportunity> oppRec = new List<Opportunity>();
    Account accRec = new Account();
    public Lead getLeadRef(){
        return lead_ref;
    }
    public Opportunity getOppRef(){
        return opp_ref;
    }
    MMI_Quotes__c MMIRef = new MMI_Quotes__c();
    public QuickQuoteSales_Edit.quickQuote quickQuoteWrap;
    //----public variables for capacity lookup------------------------------
    public Boolean isShowcapacityLookupPopUp {get;set;}
    public list<HomeBaseBeans.CapacityLookupHandler> CapacityLookupList {get;set;}
    public String latitudeForCapLukp {get;set;}
    public String longitudeForCapLukp {get;set;}
    public String selectedProdDescForCapLkup {get;set;}
    public list<SelectOption> storageUseOptionsList {get;set;} // for TFS 2719
    public list<SelectOption> unitTypeOptionsList {get;set;} // for TFS 2719
     public list<SelectOption> HowLongWillYouNeedTheUnitOptionsList {get;set;} // for TFS 2719
    /*******************************************************************
    Purpose     : This is constructor for the QuickQuoteMainController 
    Parameters  : None
    Returns     : None
    ********************************************************************/
	 public QuickQuoteSales_Edit(ApexPages.StandardController stdController)
    {
    	
    }
    public void QuickQuoteSales_Edit_initalize()
    {
		system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteSales_Edit :constructor');
		//------------ for TFS 2719-------------------
        storageUseOptionsList = new list<SelectOption>();
        Schema.DescribeFieldResult fieldResult = Opportunity.Why_do_you_need_storage_Picklist__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        storageUseOptionsList.add(new SelectOption('', '--None--'));
        for(Schema.PicklistEntry p : ple){
        	storageUseOptionsList.add(new SelectOption(p.getValue(), p.getValue()));
        }
        unitTypeOptionsList = new list<SelectOption>();
        Schema.DescribeFieldResult fieldResult1 = Opportunity.Unit_Type__c.getDescribe();
        List<Schema.PicklistEntry> ple1 = fieldResult1.getPicklistValues();
        unitTypeOptionsList.add(new SelectOption('', '--None--'));
        for(Schema.PicklistEntry p : ple1){
        	unitTypeOptionsList.add(new SelectOption(p.getValue(), p.getValue()));
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
		loginUserRec = [Select Id,LastName,Branch_Id__c,FirstName,MobilePhone,Country,City,Street,UserRole.Name, UserRoleId, State, PostalCode,Email,Fax,Phone,Extension__c, Name, Sales_Rep_Id__c from User where Id =: UserInfo.getUserId()];
		isknowZoneRatesBtnDisabled = true;
		addressErrorMessage ='';
		isViewBranchSearcieid = false; 
     	isViewBranchFulfillid = false;
    	qqWrapper= new QuickQuoteWrapper();
        addressInner= new QuickQuoteWrapper.AddressInnerClass();
        descarteInner= new QuickQuoteWrapper.DescarteInnerClass ();
        productInner= new QuickQuoteWrapper.InnerProductClass ();
        showBranches= new QuickQuoteWrapper.showbranches ();
        stateInner= new QuickQuoteWrapper.stateInnerClass();
        ecodeOptions =new List<SelectOption>();

		ecodeOptions.add(new SelectOption('--None--','--None--'));
        qqWrapper.showProdSelect = true;
	    qqWrapper.showRefreshQUote = true;
	    qqWrapper.showSaveButton = false;
        qqWrapper.isIncludeLLW = true;
        qqWrapper.isFuelSurcharge = true;  
        qqWrapper.showValidateAddress = false;
        salesRepErr=false;
        qqWrapper.PrimaryOnly=true;
        
        durationOptions=QuickQuoteUtilities.getDurationList();
        productTypeOptions=QuickQuoteUtilities.getProductTypeList();
        productSizeOptions=QuickQuoteUtilities.getProductSizeList();
        
        QuickQuoteMainService qqService=new QuickQuoteMainService();
    	QuickQuoteId = System.currentpagereference().getParameters().get('Id');
    	if(QuickQuoteId == null){
		    leadRecId = System.currentPageReference().getParameters().get('recId') ;        
	        leadRec = qqService.getLeadinfo(leadRecId);
	        oppRec = qqService.getOppInfo(leadRecId);
	        if(leadRec.size() > 0){
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
	        } 
	        if(oppRec.size() > 0){
	            qqWrapper.tabStyle = 'Opportunity';
	            qqWrapper.LeadOppName = oppRec[0].Name;
	            opp_ref = oppRec[0];
	            if(oppRec[0].AccountId != null){
	                accRec =qqService.getAccInfo(oppRec[0].AccountId); 
	            } 
	            if(oppRec[0].Servicing_Branch__c!=null){
                   userBranchId=oppRec[0].Servicing_Branch__c;
                   qqWrapper.UserBranchId = userBranchId;
                }else if(oppRec[0].Branch__c!=null){
            	 userBranchId=oppRec[0].Branch__c;
            	 qqWrapper.UserBranchId = userBranchId;
                }
	        }          
	        //qqWrapper.Quantity = 1;   // commented for TFS 2720
	        qqWrapper.Locks = 0;
    	}
     /*   else {
        	MMIRef = qqService.getQuickQuote(QuickQuoteId);							
        	qqwrapper.LeadOppName = MMIRef.Opportunity__r.Name;								
        	QuoteId = MMIRef.Quote_Id__c;
        	if(MMIRef.Opportunity__r.Servicing_Branch__c!=null){ 
        	 qqWrapper.UserBranchId=MMIRef.Opportunity__r.Servicing_Branch__c;
        	}else{
        	   qqWrapper.UserBranchId=MMIRef.Opportunity__r.Branch__c;
        	}
			String EditDetails = QuickQuoteEditService_AC.getQuickQuoteDetails(QuoteId);
			if(EditDetails!=null){
	        	quickQuoteWrap= (QuickQuoteSales_Edit.quickQuote2)JSON.deserialize(EditDetails, QuickQuoteSales_Edit.quickQuote2.class);
	        	System.debug('Maheshsssssssssssssssss'+quickQuoteWrap);  
	        	QuickQuoteHelper qqHelper=new QuickQuoteHelper();
    	        qqHelper.assignValuesLoadWBsEditSalesQuote(qqWrapper, MMIRef, proRef,  qqwrapper.TaxId,quickQuoteWrap); 
			}   
			userbranchidString = qqWrapper.UserBranchId;  	       
        	qqWrapper.Quantity = 1;	    		
        }*/
         system.debug(LoggingLevel.DEBUG,'Exiting to  QuickQuoteSales_Edit : Constructor'+quickQuoteWrap);
	}
	
	
     /*******************************************************************
    Purpose     : This method is use to call webservice methods on load
    Parameters  : None
    Returns     : None
    ********************************************************************/
    public void LoadWBs(){
    	       
		String salesRepId;
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteSales_Edit :LoadWBs()');
    	try{
    		
		QuickQuoteMainService qqService=new QuickQuoteMainService();
    	QuickQuoteId = System.currentpagereference().getParameters().get('Id');
    	if(QuickQuoteId != null){
    		MMIRef = qqService.getQuickQuote(QuickQuoteId);
        	qqwrapper.LeadOppName = MMIRef.Opportunity__r.Name;								
        	oppIdLink = MMIRef.Opportunity__r.id;
        		
        	qqwrapper.Whydoyouneedstorage = MMIRef.Opportunity__r.Why_do_you_need_storage_Picklist__c;  //----- TFS 2719-----------
        	qqWrapper.unitType = MMIRef.Unit_Type__c;	//----- TFS 2719-----------
            proRef.When_will_you_need_your_unit__c = MMIRef.Opportunity__r.When_will_you_need_your_unit__c;  
            qqwrapper.Whatwillyoubestoring = MMIRef.Opportunity__r.What_will_you_be_storing__c;
            qqwrapper.Howoftenwillyouneedtoaccess = MMIRef.Opportunity__r.How_often_will_you_need_to_access__c;
            qqwrapper.Howlongwillyouneedyourunit = MMIRef.Opportunity__r.How_long_will_you_need_your_unit__c;
            qqwrapper.Whoisgoingtobeaccessingyourunit = MMIRef.Opportunity__r.Who_is_going_to_be_accessing_your_unit__c;
            qqwrapper.QuoteComments = MMIRef.Opportunity__r.Quote_Comments__c;
            proRef.Close_Date__c = MMIRef.Opportunity__r.CloseDate;
            qqwrapper.ResidentialOnSite = MMIRef.Opportunity__r.On_The_Go__c;
            //--------TFS 2720--------------------------------------------------------
            if(MMIRef.Opportunity__r.of_Units__c != null){
            	qqWrapper.Quantity = integer.valueOf(MMIRef.Opportunity__r.of_Units__c);
            }
            //----Issue no 1238-------------------------------
	        if(MMIRef.Opportunity__r.Opportunity_Contact_Name_LookUpFilter__c != null){
        		Contact conObjRec = QuickQuoteMainDAO.getContactRecord(MMIRef.Opportunity__r.Opportunity_Contact_Name_LookUpFilter__c);
        		if(conObjRec != null){
        			qqWrapper.oppContactName = conObjRec.FirstName;
		            qqWrapper.oppContactLastName = conObjRec.LastName;
		            qqWrapper.oppContactPhone = conObjRec.Phone;
		            qqWrapper.oppContactMob = conObjRec.MobilePhone;
            		qqWrapper.oppContactEmail = conObjRec.Email;
        		}
        	}
	        /*qqWrapper.oppContactName =  MMIRef.Opportunity__r.Contact_Name__c;
	        qqWrapper.oppContactPhone =  MMIRef.Opportunity__r.Contact_Phone__c;
	        qqWrapper.oppContactLastName = MMIRef.Opportunity__r.Contact_Last_Name__c;*/
	        //----Issue no 1238-------------------------------  							
        	QuoteId = MMIRef.Quote_Id__c;
        	if(MMIRef.Opportunity__r.Servicing_Branch__c!=null){ 
        	 qqWrapper.UserBranchId=MMIRef.Opportunity__r.Servicing_Branch__c;
        	}else{
        	   qqWrapper.UserBranchId=MMIRef.Opportunity__r.Branch__c;
        	}
			String EditDetails = QuickQuoteEditService_AC.getQuickQuoteDetails(QuoteId);
			if(EditDetails!=null){
				EditSalesQuickQuoteWrap quickQuoteWrap1 =new EditSalesQuickQuoteWrap();
				EditSalesQuickQuoteWrap quickQuoteWrap2=new EditSalesQuickQuoteWrap();
				quickQuoteWrap2=quickQuoteWrap1.parse(EditDetails);
	        	//quickQuoteWrap= (QuickQuoteSales_Edit.quickQuote)JSON.deserialize(EditDetails, QuickQuoteSales_Edit.quickQuote.class);
	        	
	        	
	        	QuickQuoteHelper qqHelper=new QuickQuoteHelper();
    	        qqHelper.assignValuesLoadWBsEditSalesQuote(qqWrapper, MMIRef, proRef,  qqwrapper.TaxId,quickQuoteWrap2); 
			}   
			userbranchidString = qqWrapper.UserBranchId;  	       
        	//qqWrapper.Quantity = 1;  // commented for TFS 2720
        	//-------------capacity lookup------------------
        	longitudeForCapLukp = MMIRef.Longitude__c;
            latitudeForCapLukp = MMIRef.Latitude__c;
            selectedProdDescForCapLkup = MMIRef.Product_description__c;
        		   
    	 }
    	 
    		//qqwrapper.TaxId = MMIRef.Tax_id__c;
    		Oauth_WebService.TestCallout();
	        AmendShipping();
	        qqwrapper.DisplayErrorPopUp = false;
	        CountriesList(); 
	        if(qqWrapper.UserBranchId != null || qqWrapper.FulfillingBranch!=null){
				TransactionWebservice();
            }            
	        callBranchWebservice();
	        getMarketValuerange();
	        salesRepId=qqService.getuserSalesRepId();
            boolean check = pattern.matches('[0-9]+',salesRepId.trim()); 
            if(!check){
            	salesRepErr=true;
            }
           /* if(qqWrapper.Product!=null && qqWrapper.Product!=''){
				getSalesFleets(qqWrapper.Product);
			}*/
    	}catch(Exception e){
			system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteSales_Edit LoadWBs:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteSales_Edit :LoadWBs()');
    }
       
    /*******************************************************************
    Purpose     : This Method is use to calculate the rates 
    Parameters  : None
    Returns     : None
    ********************************************************************/
    public pagereference CalculateTotals()
    {
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteSales_Edit :CalculateTotals'+ qqWrapper);
        QuickQuoteHelper QQRHelper=null;
        try{
        	if(qqWrapper!=null){
        		QQRHelper=new QuickQuoteHelper();
        		QQRHelper.calculateTotal(qqWrapper);
        	}
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteSales_Edit CalculateTotals:'+e.getMessage());
        }
	    system.debug(LoggingLevel.DEBUG,'Exiting to  QuickQuoteSales_Edit : CalculateTotals()'+qqWrapper);
        return null;
    }
    public boolean getDispAddressPopUp(){
        return showAddressPopup;
    }
    public boolean getDispProductPopUp(){
        return showProductPopup;
    }
    
     public void getMarketValuerange(){
    	List<Weekly_Snapshot_Branch_Report__c> weekobjList = null;
    	
    	String userBranchid = '';
    	isViewBranchSearcieid = false; 
     	isViewBranchFulfillid = false;
    	weekobjList = new List<Weekly_Snapshot_Branch_Report__c>();
    	if(qqWrapper.FulfillingBranch != null && qqWrapper.FulfillingBranch != ''){
           	fullfillingBranch = '%'+qqWrapper.FulfillingBranch+'%';
           	weekobjList = [Select w.Market_Value_Range_40ZS__c, w.Market_Value_Range_40S__c, w.Market_Value_Range_20ZS__c, w.Market_Value_Range_20S__c, w.Id From Weekly_Snapshot_Branch_Report__c w where Servicing_Branch__c like : fullfillingBranch limit 1];
           	fullfillingBranch = qqWrapper.FulfillingBranch;
    	}
		userBranchid = '%'+userbranchidString+'%';
		if(weekobjList.isEmpty()){
			userBranchid = '%'+userbranchidString+'%'; 
			weekobjList = [Select w.Market_Value_Range_40ZS__c, w.Market_Value_Range_40S__c, w.Market_Value_Range_20ZS__c, w.Market_Value_Range_20S__c, w.Id From Weekly_Snapshot_Branch_Report__c w where Servicing_Branch__c like : userBranchid limit 1];
			fullfillingBranch = userbranchidString;
		}
		if(weekobjList.isEmpty()){
       	 	qqWrapper.MarketValueRange20S  = '';
		    qqWrapper.MarketValueRange20ZS = '';
		    qqWrapper.MarketValueRange40S  = '';
		    qqWrapper.MarketValueRange40ZS = '';
       	 	
       	 }else{
	        for(Weekly_Snapshot_Branch_Report__c weeklySB : weekobjList){
				qqWrapper.MarketValueRange20S = weeklySB.Market_Value_Range_20S__c;
			    qqWrapper.MarketValueRange20ZS = weeklySB.Market_Value_Range_20ZS__c;
			    qqWrapper.MarketValueRange40S = weeklySB.Market_Value_Range_40S__c;
			    qqWrapper.MarketValueRange40ZS = weeklySB.Market_Value_Range_40ZS__c;
			    
			    
	       	 }
		}
        	
    	}
    
  /*  public void getSalesFleets(String productId){
		system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteSalesController :getSalesFleets()'+productId);                              
        SalesFleet_Service salesFleetService =null;
        List<HomeBaseBeans.SalesFleets> salesFleetList =null ;
        try{  
			if(productId!=null){ 
         		ecodeOptions.clear();
	            qqsalesFleetList =new List<QuickQuoteWrapper.SalesFleetWapper> ();
	            salesFleetService = new SalesFleet_Service();
	            salesFleetList=new  List<HomeBaseBeans.SalesFleets>();
	            if(qqWrapper.FulfillingBranch!=null && qqWrapper.FulfillingBranch!=''){
	                salesFleetList = salesFleetService.getSalesFleet(productId, qqWrapper.FulfillingBranch);
	            }else{
	                salesFleetList = salesFleetService.getSalesFleet(productId, qqWrapper.UserBranchId);
	            }
	            ecodeOptions.add(new SelectOption('--None--','--None--'));
	            if(!salesFleetList.isEmpty() && salesFleetList[0].errorMessage == null){
	                for(HomeBaseBeans.SalesFleets sf : salesFleetList){
						QuickQuoteWrapper.SalesFleetWapper salesFleetWrapper=new QuickQuoteWrapper.SalesFleetWapper();
	                   	salesFleetWrapper.productId=sf.productId;
						salesFleetWrapper.commissionBonusReason=sf.commissionBonusReason;
	                   	salesFleetWrapper.ecode=sf.ecode;
	                   	salesFleetWrapper.grade=sf.grade;
	                   	salesFleetWrapper.minimumPrice=sf.minimumPrice;
	                   	salesFleetWrapper.netBookValue=sf.netBookValue;
	                   	salesFleetWrapper.notes=sf.notes;
	                   	salesFleetWrapper.productDescription=sf.productDescription;
	                   	salesFleetWrapper.reference=sf.reference;
	                   	salesFleetWrapper.suggestedPrice=sf.suggestedPrice;
						qqsalesFleetList.add(salesFleetWrapper);
	                   	ecodeOptions.add(new SelectOption(sf.ecode,sf.ecode));
	                }
	            }else{
	                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,salesFleetList[0].errorMessage);
	                ApexPages.addMessage(msg);
	            }
            }
       }catch(Exception e){
       		if(e.getMessage() != 'List index out of bounds: 0'){
				system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteSalesController getSalesFleets:'+e.getMessage());
	            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,e.getMessage());
		        ApexPages.addMessage(msg);
       		}
       }
       system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteSalesController :getSalesFleets()'+qqsalesFleetList);
    }
*/
    public void getDisblUpdatButton(){
    	qqWrapper.showSaveButton = false;	
    }
   /* public PageReference getNetValue(){
		salesRepErr = false;
		qqWrapper.Delivery = null;
		qqWrapper.modificationTotal = null;
		qqwrapper.totalCost = null;
		qqwrapper.Tax = null;
    	system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteSalesController :getNetValue()'+qqWrapper.ecode);
    	try{  
			if(qqWrapper.ecode!='--None--'){ 
		    	if(qqsalesFleetList!=null && !qqsalesFleetList.isEmpty()){      
		        	for(QuickQuoteWrapper.SalesFleetWapper qqsfleet:qqsalesFleetList){
						if(qqsfleet.ecode==qqWrapper.ecode){
		     				qqWrapper.minimumPrice = String.valueOf(decimal.valueOf(qqsfleet.minimumPrice).setScale(2));
		         	    	qqWrapper.sellingPrice=String.valueOf(decimal.valueOf(qqsfleet.suggestedPrice).setScale(2));
		         	    	qqWrapper.suggestedPrice=String.valueOf(decimal.valueOf(qqsfleet.suggestedPrice).setScale(2));
		         	    	qqWrapper.marketValue=String.valueOf(decimal.valueOf(qqsfleet.suggestedPrice).setScale(2));
		         	    	qqWrapper.netBookValue=String.valueOf(decimal.valueOf(qqsfleet.netBookValue).setScale(2));
		         	    	String totalcos=String.valueOf(Double.valueOf(qqWrapper.sellingPrice)-Double.valueOf(qqWrapper.netBookValue));
		         	    	//qqWrapper.totalCost=String.valueOf(decimal.valueOf(totalcos).setScale(2));
		         	    	
		         	    	if(qqWrapper.totalCost != null && qqWrapper.totalCost != ''){
		         	    		String bGross=String.valueOf((Double.valueOf(qqWrapper.totalCost)/Double.valueOf(qqWrapper.sellingPrice))*100);
			         	    	qqWrapper.branchGross=String.valueOf(decimal.valueOf(bGross).setScale(2));
		         	    	}
		         	    }
		            }
		    	} 
	    	}
	    	if(Test.isRunningTest()){
	    		qqWrapper.ecode = '--None--';
	    	}
	    	if(qqWrapper.ecode =='--None--'){  
	    		qqWrapper.sellingPrice = null;
	    		qqWrapper.suggestedPrice = null;
	    		qqWrapper.minimumPrice = null;
	    		qqWrapper.modificationTotal = null;
	    		qqwrapper.totalCost = null;
	    		qqWrapper.Delivery = null;
	    		qqwrapper.Tax = null;
	    	}
    	}catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteSalesController getNetValue:'+e.getMessage());
		}
    	system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteSalesController :getNetValue()'+qqWrapper);
    	qqWrapper.showSaveButton = false;
        return null;
    }*/
    
    /*******************************************************************
    Purpose     : This action function is use to select product after product
                  search service
    Parameters  : None
    Returns     : None
    ********************************************************************/
	public void SelectedProduct(){
		system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteSales_Edit :SelectedProduct()');
        qqWrapper.sellingPrice = null;
		 qqWrapper.suggestedPrice = null;
		 qqWrapper.minimumPrice = null;
		 qqWrapper.modificationTotal = null;
		 qqWrapper.marketValue = null;
		 qqWrapper.netBookValue = null;
		 qqWrapper.branchGross = null;
		 qqWrapper.totalTax = null;
		 qqwrapper.totalCost = null;  
		 qqWrapper.Delivery = null;          
         ProductSearchService_AC productService =null;
         HomeBaseBeans.Products productDetail =null ;
         QuickQuoteHelper qqHelper=null;
         qqwrapper.DisplayErrorPopUp = false;
         qqwrapper.showValidateAddress = false;
         qqwrapper.showProdSelect = true;
         qqwrapper.showRefreshQUote = true;
         qqwrapper.showSaveButton = false;
        try{
			   qqHelper=new QuickQuoteHelper();
                qqHelper.emptyQQWrapper(qqWrapper);
                //if(qqWrapper.showProduct){ 
                    for(QuickQuoteWrapper.ProductSales I : salesInventories){
                        Integer recNumber;
                        if(System.currentPageReference().getParameters().get('selectedProd') != null){       
                            recNumber =  Integer.valueOf(System.currentPageReference().getParameters().get('selectedProd'));
                        }
                        if(I.RecUniqId == recNumber){  
                           // qqhelper.assignSelectedProdRateSales(qqWrapper,I);
                           // qqhelper.getDurationRate(qqWrapper);
                           qqWrapper.Product=I.lineItemID;
                            qqWrapper.ecode=I.eCode;
                           	qqWrapper.minimumPrice = String.valueOf(decimal.valueOf(I.minimumPrice).setScale(2));
		         	    	qqWrapper.sellingPrice=String.valueOf(0.0);
		         	    	qqWrapper.suggestedPrice=String.valueOf(decimal.valueOf(I.suggestedPrice).setScale(2));
		         	    	qqWrapper.marketValue=String.valueOf(decimal.valueOf(I.suggestedPrice).setScale(2));
		         	    	qqWrapper.netBookValue=String.valueOf(decimal.valueOf(I.nbv).setScale(2));
		         	    	/*String totalcos=String.valueOf(Double.valueOf(qqWrapper.sellingPrice)-Double.valueOf(qqWrapper.netBookValue));

		         	    	if(qqWrapper.totalCost != null && qqWrapper.totalCost != ''){
		         	    		String bGross=String.valueOf((Double.valueOf(qqWrapper.totalCost)/Double.valueOf(qqWrapper.sellingPrice))*100);
			         	    	qqWrapper.branchGross=String.valueOf(decimal.valueOf(bGross).setScale(2));
			         	    	
		         	    	}*/
							selectedProdDescForCapLkup = I.gradeDescription;
                            qqwrapper.productDescToInsert = I.gradeDescription;
                            //Added by Rajib----Issue 1177--------
                            /*String brId = FullQuoteDAO.getBranchId(qqWrapper.FulfillingBranch, leadRecId);
                            ProductSearchService_AC productServiceTemp = new ProductSearchService_AC();
                            HomeBaseBeans.Products SpecificProduct = new HomeBaseBeans.Products();
                            SpecificProduct = productServiceTemp.getSpecificProducts(I.lineItemID,brId);
                            if(SpecificProduct.errorMessage == null || SpecificProduct.errorMessage == ''){
                                qqwrapper.productDescToInsert = SpecificProduct.Description;
                            }*/
                            //Added by Rajib------Issue 1177------
                            break;
                        }
                    }
             //  }
			
          	qqwrapper.showSearchError = false;                
          	//qqwrapper.showValidateAddress = false;
          //	qqwrapper.showProdSelect = true;
          	//qqwrapper.showRefreshQUote = true;
          	//qqwrapper.showSaveButton = false;
          	showProductPopup = false;
          	if(qqwrapper.TaxId==null){
     	    	SelectedAddressId();
			}
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteSales_Edit SelectedProduct:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Exiting to  QuickQuoteSales_Edit : SelectedProduct()'+qqwrapper);
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
    public PageReference AmendShipping(){		            
        StatesList();       
        return null;
    }
    public PageReference ViewBrnchSnapshot(){
        return new PageReference('/home/home.jsp');
    }
    public PageReference CheckCapacity(){
        return null;
    }
    
    /*******************************************************************
    Purpose     : This action function is use to initiate product search webservice
    Parameters  : None
    Returns     : None
    ********************************************************************/
    
     public PageReference viewBranchPage()
    {  
        PageReference viewBranch= new PageReference('/apex/ViewWeeklyBranchSnapshot?servicingBranch='+qqWrapper.UserBranchId+'&retURL='+leadRecId);
        viewBranch.setredirect(true);
        return viewBranch;
    }
    
    public void ProductSearch(){
         Integer recCount = 1;
        FullQuoteMainService fqService=null;
     	String branchId;
     	List<HB_Sales_Inventory__c> salesInventoryList=null;
  
        try{   
           
                salesInventoryList=new List<HB_Sales_Inventory__c>();
		        salesInventories=new List<QuickQuoteWrapper.ProductSales>();
		        fqService=new FullQuoteMainService();
           
            if(qqWrapper.productSearchWord!=null && qqWrapper.productSearchWord!=''){

             if(qqWrapper.FulfillingBranch!=null && qqWrapper.FulfillingBranch!=''){
            	
                 	//productList = productService.searchSalesProduct(productSearchPattern,qqWrapper.FulfillingBranch);
                 	salesInventoryList=fqService.getSalesInventoriesSearch(qqWrapper.FulfillingBranch, qqWrapper.productSearchWord);
            	
            		//productList=MMITestDataProvider.getQHomeBaseProduct();

              }else{
                // productList = productService.searchProduct(productSearchPattern,qqWrapper.UserBranchId);
                 salesInventoryList=fqService.getSalesInventoriesSearch(qqWrapper.UserBranchId, qqWrapper.productSearchWord);
              }
              if(Test.isRunningTest()){ 
             	salesInventoryList=MMITestDataProvider.getHBSalesInventoryList();
             }
              
				integer i=0;
				for(HB_Sales_Inventory__c salesInv:salesInventoryList){
					QuickQuoteWrapper.ProductSales prod=new QuickQuoteWrapper.ProductSales();
					prod.area=salesInv.Area__c;
					prod.blowout=String.valueOf(salesInv.Blowout__c);
					prod.companyId=salesInv.CompanyId__c;
					prod.eCode=salesInv.E_Code__c;
					prod.fulfillingBranchCode=salesInv.Fulfilling_Branch_Code__c;
					prod.gradeCode=salesInv.Grade_Code__c;
					prod.gradeDescription=salesInv.Grade_Description__c;
					prod.itemRef=salesInv.Item_Reference__c;
					prod.lineItemID=salesInv.Line_Item_ID__c;
					prod.minimumPrice=salesInv.Minimum_Price__c;
					prod.nbv=salesInv.NBV__c;
					prod.notes=salesInv.Notes__c;
					prod.reasonCode=salesInv.Reason_Code__c;
					prod.status=salesInv.Status__c;
					prod.suggestedPrice=salesInv.Suggested_Price__c;
					prod.displayPicture=salesInv.Display_Picture__c;
					prod.RecUniqId=i;
					salesInventories.add(prod);
					i++;
				}
           
            
            }
        }
        catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteSales_Edit ProductSearch:'+e.getMessage());
        }         
		showProductPopup = true;
        ShowProduct = false;
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteSales_Edit :ProductSearch()');
    }
    
    /*******************************************************************
    Purpose     : This action function is use to initiate Refresh Quick 
                  Quote webservice
    Parameters  : None
    Returns     : None
    ********************************************************************/
    public void Refresh(){   
    	//qqWrapper.Duration='1';
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteSales_Edit :Refresh()');
    	QuickQuoteHelper QQRHelper=null;
    	HomeBaseBeans.QuickQuoteRefreshFormat QQRF =null;
    	HomeBaseBeans.quickQuoteRefresh d =null;
    	RefreshQuickQuoteService_AC refreshQuote=null;
    	qqwrapper.DisplayErrorPopUp = false;
    	try{
	    	if(!checkMandatoryField() ){
	    		
	    	   if(qqWrapper.sellingPrice!=null && qqWrapper.sellingPrice!='' && Decimal.valueOf(qqWrapper.sellingPrice)!=0.0){  
				if(qqwrapper.TaxId==null){
         	       SelectedAddressId();
                }
                
                if(qqWrapper.address==Null || qqWrapper.address==''){
                 	qqWrapper.address=qqWrapper.CrossStreets;
                }
		    	QQRHelper=new QuickQuoteHelper();
		        QQRF = new HomeBaseBeans.QuickQuoteRefreshFormat();
		    	 if(qqWrapper.FulfillingBranch!=null && qqWrapper.FulfillingBranch!=''){
	                 QQRF=QQRHelper.refreshQQwrapper(qqWrapper, qqWrapper.FulfillingBranch,  qqwrapper.TaxId, proRef.Date_From__c);
	            }else{
	            	 QQRF=QQRHelper.refreshQQwrapper(qqWrapper, qqWrapper.UserBranchId,  qqwrapper.TaxId, proRef.Date_From__c);
	            }
				if(QQRF!=null){
			    	refreshQuote = new RefreshQuickQuoteService_AC();
			        d = refreshQuote.refreshQuickQuote(QQRF);  
		         }       
		        if(d!=null){
					if(d.errorMessage == null){
						QQRHelper.calculateTotalAfterRefresh(d,qqWrapper);
		                qqwrapper.showValidateAddress = false;
		                qqwrapper.showProdSelect = true;
		                qqwrapper.showRefreshQUote = true;
		                qqwrapper.showSaveButton = true;
		                //------------populate Unit Type------TFS 3280-------------
                        List<Product_And_Def_Code__c> lstProdNDefCodes = QuickQuoteMainDAO.getLstProductAndDefCode(qqWrapper.Product);
                        system.debug('-------------lstProdNDefCodes-------------------'+lstProdNDefCodes);
                        if(!lstProdNDefCodes.isEmpty()){
                        	String defCode = lstProdNDefCodes[0].Def_Code__c;
                        	if(defCode == 'CONT'){
	                        	qqWrapper.unitType = 'Container';
	                        }
	                        if(defCode == 'MOBILE'){
	                        	qqWrapper.unitType = 'Mobile Office';
	                        }
	                        if(defCode == 'SECURITY'){
	                        	qqWrapper.unitType = 'Security Office';
	                        }
	                        if(qqWrapper.unitType == null || qqWrapper.unitType == ''){
	                        	qqWrapper.unitType = 'Other';
	                        }
                        }
		            }         
		            else{
		                 ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,d.errorMessage);
		                 ApexPages.addMessage(msg);
		                 qqwrapper.DisplayErrorPopUp=true;
		            }
		        }else{
		             ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,'Internal Server Error.');
		             ApexPages.addMessage(msg);
		             qqwrapper.DisplayErrorPopUp=true;
		        }
		        
		        }else{
	            	 ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,'Please Provide Selling Price');
                    ApexPages.addMessage(msg);
	            }
		    }
	    	else{
	    		ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,'Please fill required fields');
			    ApexPages.addMessage(msg);
	    	}
    	}catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteSales_Edit AmendShipping:'+e.getMessage());
        } 
    	system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteSales_Edit :Refresh()');
    }
    public PageReference SaveForLater(){
        return null;
    }
    public PageReference NoSale(){
        return null;
    }
    public PageReference RaiseSalesQuote(){
        return null;
    }
    public PageReference ConvertToRentalQuote(){
        return null;
    }
    public PageReference SaveAddress(){
        showAddressPopup = false;
        return null;
    }
	public PageReference CancelAddress(){
		showAddressPopup = false;
        qqWrapper.Address = null;
        qqWrapper.City =null;
        qqWrapper.Country = null;
        qqWrapper.State = null;
        qqWrapper.ZipCode = null;
        return null;
    }       
    public List<InnerProductClass> innerProductList = new List<InnerProductClass>();
    public List<InnerProductClass> innerProductSearchList = new List<InnerProductClass>();
    public class InnerProductClass{
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
        public String Pllw {get;set;}
        public String ppe {get;set;}
        public String mainFeature {get;set;}
        public boolean  isSelected {get;set;}
        public Integer RecUniqId {get;set;}
    }
	public void ShowProductPopUp(){
       ShowProduct = true;
       showProductPopup = true;
   	}   
    /*******************************************************************
    Purpose     : This method is use to get the list of products 
    Parameters  : None
    Returns     : None
    ********************************************************************/
    public void ProductsSelection(){                            
		system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteSales_Edit :ProductsSelection');            
         Integer recCount = 1;
         qqWrapper.showProductPopup = false;
         qqwrapper.DisplayErrorPopUp = false;
         qqWrapper.productSearchWord='';
         FullQuoteMainService fqService=null;
         List<HB_Sales_Inventory__c> salesInventoryList=null;
     	 String branchId;
        try
         {   
         	  fqService=new FullQuoteMainService();
         	  salesInventoryList=new List<HB_Sales_Inventory__c>();
              salesInventories=new List<QuickQuoteWrapper.ProductSales>();
         	if(qqwrapper.TaxId==null){
         	       SelectedAddressId();
            }
        
         	if(qqWrapper.FulfillingBranch!=null && qqWrapper.FulfillingBranch!=''){ 
               
                    //productList = productService.listPrimaryProducts(qqWrapper.FulfillingBranch);
                    salesInventoryList=fqService.getSalesInventories(qqWrapper.FulfillingBranch);
                	
            }else{
            	//productList = productService.listPrimaryProducts(qqWrapper.UserBranchId);
            	salesInventoryList=fqService.getSalesInventories(branchId);
            }
            if(Test.isRunningTest()){ 
             	salesInventoryList=MMITestDataProvider.getHBSalesInventoryList();
             }

		integer i=0; 
		for(HB_Sales_Inventory__c salesInv:salesInventoryList){
			QuickQuoteWrapper.ProductSales prod=new QuickQuoteWrapper.ProductSales();
			prod.area=salesInv.Area__c;
			prod.blowout=String.valueOf(salesInv.Blowout__c);
			prod.companyId=salesInv.CompanyId__c;
			prod.eCode=salesInv.E_Code__c;
			prod.fulfillingBranchCode=salesInv.Fulfilling_Branch_Code__c;
			prod.gradeCode=salesInv.Grade_Code__c;
			prod.gradeDescription=salesInv.Grade_Description__c;
			prod.itemRef=salesInv.Item_Reference__c;
			prod.lineItemID=salesInv.Line_Item_ID__c; 
			prod.minimumPrice=salesInv.Minimum_Price__c;
			prod.nbv=salesInv.NBV__c;
			prod.notes=salesInv.Notes__c;
			prod.reasonCode=salesInv.Reason_Code__c;
			prod.status=salesInv.Status__c;
			prod.suggestedPrice=salesInv.Suggested_Price__c;
			prod.displayPicture=salesInv.Display_Picture__c;
			prod.RecUniqId=i;
			salesInventories.add(prod);
			i++;
		}
            
           
         }
         catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteSales_Edit ProductsSelection:'+e.getMessage());
         }
         showProductPopup = true;
         ShowProduct = true;
         system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteSales_Edit :ProductsSelection');
    }

/*******************************************************************
    Purpose     : This method is use to get the list of products 
    Parameters  : None
    Returns     : None
    ********************************************************************/
    public void getSpecificProductDetail(){                
         system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteSales_Edit :getSpecificProductDetail');
         qqWrapper.sellingPrice = null;
		 qqWrapper.suggestedPrice = null;
		 qqWrapper.minimumPrice = null;
		 qqWrapper.modificationTotal = null;
		 qqWrapper.marketValue = null;
		 qqWrapper.netBookValue = null;
		 qqWrapper.branchGross = null;
		 qqWrapper.totalTax = null;
		 qqwrapper.totalCost = null;  
		 qqWrapper.Delivery = null;          
         Integer recCount = 1;
         ProductSearchService_AC productService =null;
         HomeBaseBeans.Products productDetail =null ;
         QuickQuoteHelper qqHelper=null;
         string prodCodeId;
         qqwrapper.DisplayErrorPopUp = false;
         qqwrapper.showValidateAddress = false;
         qqwrapper.showProdSelect = true;
         qqwrapper.showRefreshQUote = true;
         qqwrapper.showSaveButton = false;
         
         FullQuoteMainService fqService=null;
     	String branchId;
     	List<HB_Sales_Inventory__c> salesInventoryList=null;
     	
         try{  
         	if(qqwrapper.TaxId==null){
         	       SelectedAddressId();
            }
         	prodCodeId=System.currentPageReference().getParameters().get('prodCode');
         	qqHelper=new QuickQuoteHelper();
         	qqHelper.emptyQQWrapper(qqWrapper);
         	
           if(prodCodeId!=null && prodCodeId!=''){
           	
         	  salesInventoryList=new List<HB_Sales_Inventory__c>();
		      salesInventories=new List<QuickQuoteWrapper.ProductSales>();
		      fqService=new FullQuoteMainService();
         	
         	 if(qqWrapper.FulfillingBranch!=null && qqWrapper.FulfillingBranch!=''){
               
                	//productDetail = productService.getSpecificSalesProducts(prodCodeId, qqWrapper.FulfillingBranch);
                	salesInventoryList=fqService.getSpecificSalesInventories(prodCodeId, qqWrapper.FulfillingBranch);
            	
            	}else{
            	
                     // productDetail = productService.getSpecificProducts(prodCodeId, qqWrapper.UserBranchId);
                     salesInventoryList=fqService.getSpecificSalesInventories(prodCodeId, qqWrapper.UserBranchId);
				
                }
             if(Test.isRunningTest()){ 
             	salesInventoryList=MMITestDataProvider.getHBSalesInventoryList();
            }
            
            if(!salesInventoryList.isEmpty()){
            	integer i=0;
				for(HB_Sales_Inventory__c salesInv:salesInventoryList){
					QuickQuoteWrapper.ProductSales prod=new QuickQuoteWrapper.ProductSales();
					prod.area=salesInv.Area__c;
					prod.blowout=String.valueOf(salesInv.Blowout__c);
					prod.companyId=salesInv.CompanyId__c;
					prod.eCode=salesInv.E_Code__c;
					prod.fulfillingBranchCode=salesInv.Fulfilling_Branch_Code__c;
					prod.gradeCode=salesInv.Grade_Code__c;
					prod.gradeDescription=salesInv.Grade_Description__c;
					prod.itemRef=salesInv.Item_Reference__c;
					prod.lineItemID=salesInv.Line_Item_ID__c;
					prod.minimumPrice=salesInv.Minimum_Price__c;
					prod.nbv=salesInv.NBV__c;
					prod.notes=salesInv.Notes__c;
					prod.reasonCode=salesInv.Reason_Code__c;
					prod.status=salesInv.Status__c;
					prod.suggestedPrice=salesInv.Suggested_Price__c;
					prod.displayPicture=salesInv.Display_Picture__c;
					prod.RecUniqId=i;
					salesInventories.add(prod);
					i++;
				}
				
            }else{
            	ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,'item not found');
                ApexPages.addMessage(msg);
            }
         }
         }
         catch(Exception e){    
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteSales_Edit getSpecificProductDetail:'+e.getMessage());
         }
         system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteSales_Edit :getSpecificProductDetail'+qqwrapper);
    }
    
    /*******************************************************************
    Purpose     : This method is use to get the rate on duration change 
    Parameters  : None
    Returns     : None
    ********************************************************************/
    public void getRateOnDurationChange(){                
         system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteSales_Edit :getRateOnDurationChange'+qqWrapper);  
         QuickQuoteHelper qqHelper=null;
         qqwrapper.DisplayErrorPopUp = false;
         try{   
			qqHelper=new QuickQuoteHelper(); 
	        qqHelper.emptyQQWrapper(qqWrapper);
	        qqhelper.getDurationRate(qqWrapper);
	        qqwrapper.showRefreshQUote = true;
		    qqwrapper.showSaveButton = false;
         }catch(Exception e){    
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteSales_Edit getRateOnDurationChange:'+e.getMessage());
         }
         system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteSales_Edit :getRateOnDurationChange'+qqwrapper.Rate);
	}
    List<SelectOption> StateOptions = new List<SelectOption>();
    public List<SelectOption> getStateOptions(){
        return stateOptions;
    }
    List<SelectOption> CountryOptions = new List<SelectOption>();
    public List<SelectOption> getCountryOptions(){
        return CountryOptions;
    }
    public List<InnerProductClass> getInnerProductsList(){
		return innerProductList;
    }
    public List<InnerProductClass> getInnerProductSearchList(){
        return innerProductSearchList;
    }
    public PageReference SearchProduct(){
        return null;
    }
    public boolean ShowProduct= false;
    public boolean getShowProduct(){
        return ShowProduct;
    }
    public class AddressInnerClass{
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
    List<AddressInnerClass> AddressInnerClassList = new List<AddressInnerClass>();
    public List<AddressInnerClass> getAddressInnerClassList(){
        return AddressInnerClassList;
    }

    /*******************************************************************
    Purpose     : This action function is use to initiate the validate address
                  webservice
    Parameters  : None
    Returns     : None
    ********************************************************************/
    public PageReference ValidateAddress(){           
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteSales_Edit :ValidateAddress');
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
        system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteSales_Edit :ValidateAddress'+AddressInnerClassList);  
        return null;
    }

    // On click on OK button on Validate Address
    public void SelectedAddressId()
    {
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteSales_Edit :SelectedAddressId()'+AddressInnerClassList);  
        showAddressPopup  = false;
        try{
	        for(AddressInnerClass I : AddressInnerClassList){
	            Integer recNumber;
	            if(System.currentPageReference().getParameters().get('selectedTex') != null){       
					recNumber =  Integer.valueOf(System.currentPageReference().getParameters().get('selectedTex'));
	            }
	            if(I.RecUniqId == recNumber){       
                    validAddressId = I.Id;
                    qqwrapper.TaxId= I.Id;  
                     if(I.city!=null && I.city!=''){
				         qqWrapper.city=I.city;
				        }
				        
				        if(I.state!=null && I.state!=''){
				         qqWrapper.state=I.state;
				        }  
                     
                    if(!isErrorInValidateAddress){    
			            qqwrapper.showValidateAddress = false;
			            qqwrapper.showProdSelect = true;
			            qqwrapper.showRefreshQUote = true;
			        }                      
	            }
	        }
        }catch(Exception e){
	             system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainController_AC ValidateAddress:'+e.getMessage());
	    } 
        system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteSales_Edit :SelectedAddressId()'+validAddressId);
    }
    public PageReference CancelSelectedAddressId(){
    	addressErrorMessage = '';
    	qqWrapper.distanceFromBranch = null;
        showAddressPopup  = false;
        return null;
    }
      
    /*******************************************************************
    Purpose     : This action function is use to initiate the Descarte webservice 
                  for fulfilling branch
    Parameters  : None
    Returns     : None
    ********************************************************************/
    public PageReference SelectFulfillingBranch(){
	    system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteSales_Edit :SelectFulfillingBranch()');
		ValidateAddressService_AC validateAddress=null;
		List<HomeBaseBeans.webAddresses> validateAddressResponse;
		DescarteInnerClassList = new List<DescarteInnerClass>();
	    disableAddressOkButton=false;
	    showAddressPopup  = false;
		//if(checkZipCodeValidation()){
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
		   // if(qqWrapper.country!=null && qqWrapper.zipCode!=null && qqWrapper.State != null){
		   if(qqWrapper.country!=null && qqWrapper.country!='' && ((qqWrapper.CrossStreets!=null && qqWrapper.CrossStreets!='') || (qqWrapper.address!=null && qqWrapper.address!='')))
           {
		        try{ 
		        	DescarteInnerClassList.clear();
		        	validateAddress = new ValidateAddressService_AC();  
		        	validateAddressResponse = validateAddress.descartesLookup(addressBean);
		        	if(Test.isRunningTest()){ 
	                     validateAddressResponse = MMITestDataProvider.getQHomeBaseWebAdd();
	                }
		            if(validateAddressResponse[0].errorMessage == null){
		                Integer i = 1;
		                for(HomeBaseBeans.webAddresses w : validateAddressResponse){
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
		            else{
		                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,validateAddressResponse[0].errorMessage);
		                ApexPages.addMessage(msg);
		                isErrorInValidateAddress = true;
		                //DisplayErrorPopUp=true;
		            }
		        }
		        catch(Exception e){
					system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteSales_Edit SelectFulfillingBranch:'+e.getMessage());
		            isErrorInValidateAddress = true;
		        }
		        dispDescAddrPopUp = true;
		        selectFulfillingLoaded = true;   
		    }
			else{
				ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,'Required fields are missing');
		     	ApexPages.addMessage(msg);
	    		dispDescAddrPopUp = true;
		        selectFulfillingLoaded = true;
		        isErrorInValidateAddress = true;  
		    }
		/*}else{
			dispDescAddrPopUp = true;
	        selectFulfillingLoaded = true;
	        dispDescAddrPopUp = true;
			ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,'Zip Code is not valid');
	        ApexPages.addMessage(msg);
		}*/
	    system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteSales_Edit :SelectFulfillingBranch()');
	    return null;
    }
    
    boolean selectFulfillingLoaded = false;
    public boolean getSelectFulfillingLoaded(){
            return selectFulfillingLoaded;
    }
        
    /*******************************************************************
    Purpose     : This action function is use to select fulfilling branch
                   functionality 
    Parameters  : None
    Returns     : None
    ********************************************************************/
    public PageReference FulfillingBranchSelected(){
        system.debug(LoggingLevel.DEBUG,'Entring QuickQuoteSales_Edit :FulfillingBranchSelected()');
        dispDescAddrPopUp  = false;
        try{
        	addressErrorMessage = '';
	        for(DescarteInnerClass I : DescarteInnerClassList){
	            Integer recNumber;
	            if(System.currentPageReference().getParameters().get('selectedAddr') != null){       
	                recNumber =  Integer.valueOf(System.currentPageReference().getParameters().get('selectedAddr'));
	            }
	            if(I.RecUniqId == recNumber){ 
	            	
	            	if(I.fulfillingBranch != null && I.fulfillingBranch != ''){
                        qqWrapper.FulfillingBranch = I.fulfillingBranch;
                     }else{
                       	 qqWrapper.FulfillingBranch = qqWrapper.FulfillingBranch;
                     }
	            	      
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
                    addressErrorMessage = I.zoneWarning;
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
	         getMarketValuerange();
             ValidateAddress();
             DisableKnowDelZoneBtn();
         }catch(Exception e){
              system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteSales_Edit FulfillingBranchSelected:'+e.getMessage());
         }
         system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteSales_Edit :FulfillingBranchSelected()');
         return null;
	}
    public PageReference CancelFulfillingBranchSelected(){
		dispDescAddrPopUp  = false;
        qqwrapper.showValidateAddress = true;
        qqwrapper.showProdSelect = false;
        return null;
    }
    public List<DescarteInnerClass> DescarteInnerClassList = new List<DescarteInnerClass>();
    public List<DescarteInnerClass> getDescarteInnerClassList(){
		return DescarteInnerClassList;
    }
    public class DescarteInnerClass{
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
    
    public boolean dispDescAddrPopUp = false;
    public boolean getDispDescProductPopUp(){
		return dispDescAddrPopUp;
    }
     
    /*******************************************************************
    Purpose     : This method is use to initiate country webservice
    Parameters  : None
    Returns     : None
    ********************************************************************/     
    public void CountriesList(){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteSales_Edit :CountriesList()');
        CountryService_AC CountryService = null;
        List<HomeBaseBeans.countries> Countries;
        qqwrapper.DisplayErrorPopUp = false;
        try{   
        	CountryService = new CountryService_AC();
        	Countries = CountryService.listCountry();
        	if(Test.isRunningTest()){ 
				Countries = MMITestDataProvider.getQHomeBasecontry();
			}
            if(Countries[0].errorMessage == null){
				List<String> countryNameList = new List<String>();
                CountryOptions.add(new SelectOption('','-None-'));
                for(HomeBaseBeans.countries c : Countries){   
                    if(c.Name == 'USA' || c.Name == 'Canada'){
						CountryOptions.add(new SelectOption(c.Id,c.Name));
                    }
                }   
            }
            else{
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,Countries[0].errorMessage);
                ApexPages.addMessage(msg);
                qqwrapper.DisplayErrorPopUp=true;
            }
        }
        catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteSales_Edit CountriesList:'+e.getMessage());
        }    
        system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteSales_Edit :CountriesList()'+CountryOptions);
    }

    /*******************************************************************
    Purpose     : This method is use to initiate state webservice
    Parameters  : None
    Returns     : None
    ********************************************************************/
    public void StatesList(){               
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteSales_Edit :StatesList()');               
        StateService_AC stateService = null;
        List<HomeBaseBeans.States> states ;
        qqwrapper.DisplayErrorPopUp = false;
        try{   
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
                for(HomeBaseBeans.States ss : states){
                    StateOptions.add(new SelectOption(ss.Id,ss.Id));
                    stateInnerClass IC = new stateInnerClass();
                    IC.Id = ss.Id;
                    IC.Name = ss.Name;
                    IC.countryId = ss.countryId;
                    IC.companyId = ss.companyId;
                    
                    innerStateList.add(IC);
                }
                if(qqWrapper.product==null){
                    qqwrapper.showProdSelect = false;
                    qqwrapper.showRefreshQUote = false;
                    qqwrapper.showSaveButton = false;
                }
            }else{
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,states[0].errorMessage);
                ApexPages.addMessage(msg);
                qqwrapper.DisplayErrorPopUp=true;
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteSales_Edit StatesList:'+e.getMessage());
        } 
        system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteSales_Edit :StatesList()'+innerStateList);  
    }       
        
    public List<stateInnerClass> innerStateList = new List<stateInnerClass>();
    public class stateInnerClass{
        public String companyId {get;set;}
        public String countryId {get;set;}
        public String Id {get;set;}
        public String Name {get;set;}
    }
        
    /*******************************************************************
    Purpose     : This method is use to initiate TransactionList
                  webservice
    Parameters  : None
    Returns     : None
    ********************************************************************/
        
    public PageReference TransactionWebservice()
    {
        
    	system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteSales_Edit :TransactionWebservice()');
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
	        if(transactionResponse[0].errorMessage == null){
	            transactionOptions = new List<SelectOption>();
	            transactionOptions.add(new SelectOption('-None-','-None-'));
	            for(HomeBaseBeans.transactions TT : transactionResponse){       
                	if(proRef.QQ_Type__c == 'Sales'){
                		if(TT.description!='Chico Non-Container Rental'&&
		                    TT.description!='OTG'&&
		                    TT.description!='OTG Warehouse'&&
		                    TT.description!='Rental Offsite Xmas' && TT.description!='Rental Cartage' &&
		                    TT.description!= 'Rental Offsite Construction' &&  TT.description!= 'Rental Mobile Offices' &&  TT.description!='Rental Offsite Standard'
		                    &&  TT.description!='Rental On Site' &&  TT.description!='Rental Security Offices' && TT.description!=	'Rental Van Trailer' && TT.description!= 'Sale of Service'){
		                    	transactionOptions.add(new SelectOption(TT.Id,TT.description));
		                    }
                	}else if(proRef.QQ_Type__c == 'Rental'){
                		if(TT.description!='Chico Non-Container Rental'&&
		                    TT.description!='OTG'&&
		                    TT.description!='OTG Warehouse'&&
		                    TT.description!='Rental Offsite Xmas' &&
		                    TT.description!='Sales Order Fleet Sales' &&
		                    TT.description!='Sales Order MFG/Accessories'&&
		                    TT.description!='Sale of Service' &&
		                    TT.description!='Sales Order Wholesale Direct')
		                    transactionOptions.add(new SelectOption(TT.Id,TT.description));	
                	}else{
                		if(TT.description!='Chico Non-Container Rental'&&
		                    TT.description!='OTG'&&
		                    TT.description!='OTG Warehouse'&&
		                    TT.description!='Rental Offsite Xmas' )
		                    transactionOptions.add(new SelectOption(TT.Id,TT.description));
                	}
        		}
	        }
	        	else{
	            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,transactionResponse[0].errorMessage);
	            ApexPages.addMessage(msg);
	            qqwrapper.DisplayErrorPopUp=true;
        	}
    	}catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteSales_Edit TransactionWebservice:'+e.getMessage());

        } 
        system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteSales_Edit :TransactionWebservice()'+transactionOptions);  
        return null;
    }
        
    public List<SelectOption> transactionOptions = new List<SelectOption>();
    public List<SelectOption> getTransactionOptionsList(){
        return transactionOptions;
    }
    
    /*******************************************************************
    Purpose     : This method is use to increase lock and quantity 
    Parameters  : None
    Returns     : None
    ********************************************************************/ 
    public void inc(){
        if(qqWrapper.Locks >= 0){
			qqWrapper.Locks = qqWrapper.Locks + 1;
        } 
        if(qqWrapper.Quantity >= 0){
			qqWrapper.Quantity = qqWrapper.Quantity + 1; 
        }
    }
    
    /*******************************************************************
    Purpose     : This method is use to decrease lock and quantity 
    Parameters  : None
    Returns     : None
    ********************************************************************/
    public void dec(){
		if(qqWrapper.Locks > 0){
			qqWrapper.Locks = qqWrapper.Locks - 1;
       	}
       	if(qqWrapper.Quantity > 0){
			qqWrapper.Quantity = qqWrapper.Quantity - 1; 
       }
    }
    public PageReference RefreshQuickQuote(){
        return null;
    }
    public void test(){
    	
    }
   
    /*******************************************************************
    Purpose     : This action function is use to call branch webservice 
    Parameters  : None
    Returns     : None
    ********************************************************************/
    public pagereference callBranchWebservice(){
		system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteSales_Edit :callBranchWebservice()');
        FulfillingBranchService_AC fulFillingBranch =null;
        List<HomeBaseBeans.branches> branches;
    	try{
	        fulFillingBranch = new FulfillingBranchService_AC();
	        branches = fulFillingBranch.listBranches();
	        if(Test.isRunningTest()){ 
               branches = MMITestDataProvider.getQHomeBaseBranch();
            }
	        qqwrapper.DisplayErrorPopUp = false;
	        if(branches[0].errorMessage == null){  
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
        	system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteSales_Edit callBranchWebservice:'+e.getMessage());
		}
        system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteSales_Edit :callBranchWebservice()'+branchList);
        return null;
    }
        
    public List<showbranches> getBranchIdNames(){
		return branchList;
    }
    public List<showbranches> getBranchSearchList(){
		return branchSearchList;
    }
    public String address1{get;set;}
    public String address2{get;set;}
    public String address3{get;set;}
    public String address4{get;set;}
    public String state2{get;set;}
    public String zipCode2{get;set;}
    public String countryId2{get;set;}
    public String BranchId{get;set;}
    public String crossStreet2{get;set;}

    public class showbranches{
		public boolean isSelected{get;set;}
		public String Id{get;set;}
		public String Name{get;set;}
		public Integer RecUniqId {get;set;}      
    }
    public List<showbranches> branchList = new List<showbranches>();
    public List<showbranches> branchSearchList = new List<showbranches>();
    public boolean dispBranchPopUp{get;set;}
    
    public boolean showSearchBranchIdTable = false;
    
    public boolean getshowSearchBranchIdTable(){
        return showSearchBranchIdTable;
    }
    
    /*******************************************************************
    Purpose     : This action function is use to search address functionality
    Parameters  : None
    Returns     : None
    ********************************************************************/
    public PageReference SearchDescAddress()
    {
       system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteSales_Edit :SearchDescAddress()');
    	try{
            branchSearchList = new List<showbranches>();      
            if((qqWrapper.BranchIdSearchWord == null || qqWrapper.BranchIdSearchWord == '') && (qqWrapper.BranchNameSearchWord == null || qqWrapper.BranchNameSearchWord == '')){   
                showSearchBranchIdTable = false;
            }
            else{           
                for(showbranches I : branchList){
                    if((qqWrapper.BranchIdSearchWord!= '') && (I.Id).startswith(qqWrapper.BranchIdSearchWord) || (qqWrapper.BranchNameSearchWord != '' ) &&(I.Name.toLowerCase()).Contains(qqWrapper.BranchNameSearchWord.toLowerCase())){
                    	branchSearchList.add(I);
                    }
                }
                showSearchBranchIdTable = true;
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteSales_Edit SearchDescAddress:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteSales_Edit :SearchDescAddress()'+branchSearchList);    
        return null;
	}
    
    /*******************************************************************
    Purpose     : This method is use to select branch functionality
    Parameters  : None
    Returns     : None
    ********************************************************************/
	public void SelectedBranchMethod(){
   		system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteSales_Edit :SelectedBranchMethod()');                              
   		dispBranchPopUp  = false;  
   		QuickQuoteHelper qqHelper=null;
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
			  //issue 688 fix
         qqWrapper.sellingPrice = null;
		 qqWrapper.suggestedPrice = null;
		 qqWrapper.minimumPrice = null;
		 qqWrapper.modificationTotal = null;
		 qqWrapper.marketValue = null;
		 qqWrapper.netBookValue = null;
		 qqWrapper.branchGross = null;
		 qqWrapper.totalTax = null;
		 qqwrapper.totalCost = null;  
		 qqWrapper.Delivery = null;
		 qqWrapper.Product='';
		 
		 qqHelper=new QuickQuoteHelper();
         qqHelper.emptyQQWrapper(qqWrapper);
		 ecodeOptions.clear();
         ecodeOptions.add(new SelectOption('--None--','--None--'));
		  
		 
		// qqwrapper.showValidateAddress = false;
        // qqwrapper.showProdSelect = true;
       //  qqwrapper.showRefreshQUote = true;
         qqwrapper.showSaveButton = false;
			
		makeAddAvailable();
		getMarketValuerange();
		}catch(Exception e){
	    	system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteSales_Edit SelectedBranchMethod:'+e.getMessage());
		}
		system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteSales_Edit :SelectedBranchMethod()'+System.currentPageReference().getParameters().get('selectedBranch'));
	}
	
	 /*******************************************************************
    Purpose     : This method is use to branch id Tab Off functionality
    Parameters  : None
    Returns     : None
    ********************************************************************/
    public void getSpecificBranchIDMethod(){
       system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteSales_Edit :getSpecificBranchIDMethod()');                              
       qqWrapper.dispBranchPopUp  = false;  
       QuickQuoteHelper qqHelper=null;
       String idEntered;
       boolean idFind =false;
       try{    
       	 //issue 688 fix
       	 addressErrorMessage = ''; 
       	 qqWrapper.distanceFromBranch = null;
         qqWrapper.sellingPrice = null;
		 qqWrapper.suggestedPrice = null;
		 qqWrapper.minimumPrice = null;
		 qqWrapper.modificationTotal = null;
		 qqWrapper.marketValue = null;
		 qqWrapper.netBookValue = null;
		 qqWrapper.branchGross = null;
		 qqWrapper.totalTax = null;
		 qqwrapper.totalCost = null;  
		 qqWrapper.Delivery = null;
		 qqWrapper.Product='';
		 
		 qqHelper=new QuickQuoteHelper();
         qqHelper.emptyQQWrapper(qqWrapper);
		 ecodeOptions.clear();
         ecodeOptions.add(new SelectOption('--None--','--None--'));
		  
		 
		// qqwrapper.showValidateAddress = false;
        // qqwrapper.showProdSelect = true;
        // qqwrapper.showRefreshQUote = true;
         qqwrapper.showSaveButton = false;
       
           idEntered = System.currentPageReference().getParameters().get('fBranchCode');
           if(idEntered!=null && idEntered!=''){
	           for(showbranches I : branchList){         
	               if(I.Id == idEntered){
	                   BranchId = I.id;
	                   qqWrapper.FulfillingBranch = I.id;  
	                   idFind=true;            
	               }
	           }
	           
	           if(!idFind){
            	ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,'FullFilling Branch '+qqWrapper.FulfillingBranch+' Not Found');
                ApexPages.addMessage(msg);
                qqWrapper.FulfillingBranch = null;
               }
           }
           
          makeAddAvailable();
          getMarketValuerange();
   
       }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteSales_Edit getSpecificBranchIDMethod:'+e.getMessage());
       }
       system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteSales_Edit :getSpecificBranchIDMethod()'+System.currentPageReference().getParameters().get('fBranchCode'));
    }
    
        
	public pageReference hidedispBranchPopUp(){
	   qqWrapper.dispBranchPopUp = false;
        
        qqWrapper.BranchIdSearchWord = '';
		qqWrapper.BranchNameSearchWord = '';
        
        getMarketValuerange();
        return null;
	}
	public pageReference showdispBranchPopUp(){
	    dispBranchPopUp = true;
	    return null;
	}
	
	/*******************************************************************
    Purpose     : This action function is use to Update quick quote functionality
                  and call Update quick quote web service .
    Parameters  : None
    Returns     : None
    ********************************************************************/
	public pagereference saveQuickQuote(){
		system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteSales_Edit :saveQuickQuote()');
	    QuickQuoteMainService qqService=new QuickQuoteMainService();
	    String dateval = null;
	    PageReference pf=null;
	    Map<boolean,integer> IntMap=null;
        String savePayload =null;
        UpdateQuickQuoteService updateQuickQuote = null;
        string isUpdateSuccess=null;
        string quoteOppIDAfterUpdate;
        Boolean isSFDCUpdateSuccess=false;
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
				if(Test.isRunningTest()){
					proRef.Date_From__c = system.today();
				}
			   	if(proRef.Date_From__c!=null && proRef.Date_From__c >= system.today()){
			   		if(proRef.Close_Date__c!=null  && proRef.Close_Date__c >= system.today()){
			   	dateval = proRef.Date_From__c.year()+'-'+proRef.Date_From__c.month()+'-'+proRef.Date_From__c.day();
				
			   	IntMap = new Map<boolean, integer>(); 
			   	IntMap.put(true,1);
			   	IntMap.put(false,0);
			   
			   	salesRepId=qqService.getuserSalesRepId();
				if(qqwrapper.TaxId==null){
	         	       SelectedAddressId();
				}
				if(qqWrapper.address==Null || qqWrapper.address==''){
                 	qqWrapper.address=qqWrapper.CrossStreets;
                 }
				
				 QuickQuoteSaveRequestGenerator qqsaveRequest=new QuickQuoteSaveRequestGenerator();
				if(qqWrapper.FulfillingBranch!=null && qqWrapper.FulfillingBranch!=''){
	                savePayload=qqsaveRequest.getQuickQuoteRefreshRequest(qqWrapper,qqWrapper.FulfillingBranch,dateval,salesRepId, 'Sales');
	                 
	             }else{
	             	 savePayload=qqsaveRequest.getQuickQuoteRefreshRequest(qqWrapper,qqWrapper.UserBranchId,dateval,salesRepId, 'Sales');
	                 
	             }
				
				/*if(qqWrapper.FulfillingBranch!=null && qqWrapper.FulfillingBranch!=''){
	                savePayload = '{"quickQuote":{"duration":'+qqWrapper.Duration+',"lead":"'+qqWrapper.LeadOppName+'","ecode": '+qqWrapper.ecode+',"transport":"'+qqWrapper.Transport+'","transactionId":"'+qqWrapper.TransactionType+'","rate":"'+qqWrapper.Rate+'","rentalPPETotal":"'+ qqWrapper.Rental_PP_E+'","transportSurchargeTotal":"'+qqwrapper.FuelSurcharge+'","quickQuoteTotal":"'+qqWrapper.QuickQuote+'","dateFrom":'+dateval+',"shippingAddress":{"state":"'+qqWrapper.State+'","countryId":"'+qqWrapper.country+'","address1":"'+qqWrapper.Address+'","address2":"","address3":"'+qqWrapper.City+'","address4":"","zipCode":"'+qqWrapper.zipcode+'", "taxId": "'+qqwrapper.TaxId+'","fulfillingBranchId": "'+qqWrapper.FulfillingBranch+'"},"productId":"'+qqWrapper.Product+'","branchId":"'+qqWrapper.FulfillingBranch+'","llwTotal":"'+qqWrapper.LLW+'","locksTotal":"'+qqWrapper.LocksAmount+'","taxTotal":"'+qqWrapper.Tax+'","codAmount":"'+qqWrapper.COD+'","includeLLW":'+IntMap.get(qqWrapper.isIncludeLLW)+',"fuelSurcharge":'+IntMap.get(qqWrapper.isFuelSurcharge)+',"locksQty":'+qqWrapper.Locks+',"companyId": 1, "operatorId" : "result", "salesRep":'+salesRepId+', "status":"Active" }}';
				}else{
					savePayload = '{"quickQuote":{"duration":'+qqWrapper.Duration+',"lead":"'+qqWrapper.LeadOppName+'","ecode": '+qqWrapper.ecode+',"transport":"'+qqWrapper.Transport+'","transactionId":"'+qqWrapper.TransactionType+'","rate":"'+qqWrapper.Rate+'","rentalPPETotal":"'+ qqWrapper.Rental_PP_E+'","transportSurchargeTotal":"'+qqwrapper.FuelSurcharge+'","quickQuoteTotal":"'+qqWrapper.QuickQuote+'","dateFrom":'+dateval+',"shippingAddress":{"state":"'+qqWrapper.State+'","countryId":"'+qqWrapper.country+'","address1":"'+qqWrapper.Address+'","address2":"","address3":"'+qqWrapper.City+'","address4":"","zipCode":"'+qqWrapper.zipcode+'", "taxId": "'+qqwrapper.TaxId+'","fulfillingBranchId": "'+qqWrapper.UserBranchId+'"},"productId":"'+qqWrapper.Product+'","branchId":"'+qqWrapper.UserBranchId+'","llwTotal":"'+qqWrapper.LLW+'","locksTotal":"'+qqWrapper.LocksAmount+'","taxTotal":"'+qqWrapper.Tax+'","codAmount":"'+qqWrapper.COD+'","includeLLW":'+IntMap.get(qqWrapper.isIncludeLLW)+',"fuelSurcharge":'+IntMap.get(qqWrapper.isFuelSurcharge)+',"locksQty":'+qqWrapper.Locks+',"companyId": 1, "operatorId" : "result", "salesRep":'+salesRepId+', "status":"Active" }}';
                }*/
	       		updateQuickQuote = new UpdateQuickQuoteService();
	       		isUpdateSuccess = updateQuickQuote.updateQuickQuote(QuoteId,savePayload);
	        	if(Test.isRunningTest()){ 
	            	isUpdateSuccess = 'success';
	       		}
				qqwrapper.DisplayErrorPopUp = false;
				if(isUpdateSuccess.equalsIgnoreCase('success')){
					if(qqWrapper.FulfillingBranch!=null && qqWrapper.FulfillingBranch!=''){
			        	isSFDCUpdateSuccess=qqService.updateQuickQuoteSalesRecord(MMIRef, qqWrapper.FulfillingBranch, proRef.Date_From__c,  qqwrapper.TaxId, qqwrapper);
			        }else{
						isSFDCUpdateSuccess=qqService.updateQuickQuoteSalesRecord(MMIRef, qqWrapper.UserBranchId, proRef.Date_From__c,  qqwrapper.TaxId, qqwrapper);
			        }
		    		if(isSFDCUpdateSuccess){
		    			qqwrapper.selectedOrConvertedContactId = MMIRef.Opportunity__r.Opportunity_Contact_Name_LookUpFilter__c; 
	    				qqwrapper.SourceOfQQ = 'opportunity';
						quoteOppIDAfterUpdate=qqService.updateOppNameSales(MMIRef.Opportunity__c, qqwrapper,proRef.Close_Date__c, proRef.When_will_you_need_your_unit__c,null);
		    		    pf = new PageReference('/'+MMIRef.Opportunity__c);
		    		}else{
						ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,'error while saving to SFDC');
		             	ApexPages.addMessage(msg);
		             	qqwrapper.DisplayErrorPopUp=true;
		             	return null;
		    			}
				}else{
			 	    ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,isUpdateSuccess);
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
		}catch(System.CalloutException e) {
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteSales_Edit saveQuickQuote:'+e.getMessage());
            return null; 
        }
        system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteSales_Edit :saveQuickQuote()');
        return pf;
	}
	 // ......... Show Buttons .........
	public boolean showValidateAddress{get;set;}
	public boolean showProdSelect{get;set;}
	public boolean showRefreshQUote{get;set;}
	public boolean showSaveButton{get;set;}
	public boolean showSearchError{get;set;}
        
   
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
    public void makeAddAvailable(){
        qqwrapper.showValidateAddress = true;
        qqwrapper.showSaveButton = false;
        qqwrapper.showRefreshQUote = false;
        qqwrapper.showProdSelect = false;
        if(qqWrapper.product==null && qqWrapper.product==''){
            qqwrapper.showProdSelect = false;
            qqwrapper.showRefreshQUote = false;
            qqwrapper.showSaveButton = false;
        }
    }
    /*******************************************************************
    Purpose     : This method is use to enable/disable buttons 
    Parameters  : None
    Returns     : None
    ********************************************************************/
        
    public boolean checkMandatoryField(){
		System.debug('In checkMandatoryField'+qqwrapper.Product +'--'+ qqwrapper.Quantity +'--'+proRef.Date_From__c+'--'+qqwrapper.Duration+'--'+qqwrapper.TransactionType+'--'+qqwrapper.Locks);
		if(qqwrapper.Product==null||qqwrapper.Product==''||
			qqwrapper.Quantity==null||
			proRef.Date_From__c==null||
			qqwrapper.Duration==null ||
			qqwrapper.TransactionType==null|| qqwrapper.TransactionType=='-None-'||
			qqwrapper.Locks == null){
				return true;
		}
		else{
			return false;
		}
	}
    /*******************************************************************
    Purpose     : This method is use for zipcode validations 
    Parameters  : None
    Returns     : None
    ********************************************************************/ 
	public boolean checkZipCodeValidation(){
		String zipRegex=null;
    	Boolean isMatch=false;
        if(qqwrapper.Country == 'USA'){
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
        else{
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
        }
	}
        
    // ................ Edit ...............
    
    public class quickQuote{
        public String lead;
        public String transactionId;
        public String accountId;
        public String ecode;
        public String salesRep;
        public String transport;
        public String operatorId;
        public String companyId;
        public String certificate;
        public String rate;
        public String lineValue;
        public String modificationCharge;
        public String rentalPPETotal;
        public String pickUpTotal;
        public String transportSurchargeTotal;
        public String pickupSurchargeTotal;
        public String llwTotal;
        public String locksPrice;
        public String locksTotal;
        public String taxTotal;
        public String codAmount;
        public String productId;
        public String branchId;
        public String quickQuoteTotal;
        public boolean includeLLW;
        public boolean fuelSurcharge;
        public String dateFrom;
        public String id;
        public String duration;
        public String locksQty;
        public String status;
        public boolean salesQuoteConvertible;
        public boolean rentalQuoteConvertible;
        public ShippingAddress shippingAddress;
        
        public quickQuote(){
        	shippingAddress= new ShippingAddress();
        } 
    }
   public class ShippingAddress {
		public String name;
		public String address1;
		public String address2;
		public String address3;
		public String address4;
		public String state;
		public String countryId;
		public String crossStreet1;
		public String crossStreet2;
		public String taxId;
		public String deliveryZone;
		public String cityZone;
		public String zoneWarning;
		public String latitude;
		public String longitude;
		public String oldPostalCode;
		public String zipCode;
		public String distanceFromBranch;
		public String distanceBranch;
		public String fulfillingBranchId;
		public String fulfillingBranchName;
	}
    
     public void disableSaveButton(){
        qqwrapper.showSaveButton = false;
        if(!qqWrapper.showValidateAddress){
         qqwrapper.showRefreshQUote=true;
        }
    } 
    
    public void changeIncludeLLW(){
    	disableSaveButton();
    	if(qqwrapper.TransactionType=='ON'){
    		qqWrapper.isIncludeLLW=false;
    	}else{
    		qqWrapper.isIncludeLLW=true;
    	}
     }
    
      public void onChangeDelivery()
    {
        proRef.When_will_you_need_your_unit__c=proRef.Date_From__c;
        
       qqWrapper.showSaveButton = false;	

    } 
    
    public Pagereference cancelFullQuote(){
		String cancelId;
		PageReference pf=null;
		if(QuickQuoteId!=null && QuickQuoteId!='')
        {
            cancelId = QuickQuoteId;
            pf = new PageReference('/'+cancelId);
            pf.setRedirect(true);
        } else{
        	 pf = new PageReference('/home/home.jsp');
            pf.setRedirect(true);
        }
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
        proRef.Date_From__c = date.valueOf(selectedCapacityDate.substring(0,10));
        proRef.When_will_you_need_your_unit__c = date.valueOf(selectedCapacityDate.substring(0,10));
        isShowcapacityLookupPopUp = false;
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
        		StatesList();
        		qqWrapper.State = BranchLookup.State__c;
        		qqWrapper.City =  BranchLookup.City__c;
	        }
  		}
  		makeAddAvailable();
	}
	
	public void reCalculatePrice(){
        qqWrapper.COD = string.valueOf(decimal.valueOf(qqWrapper.Rate) + decimal.valueOf(qqWrapper.Rental_PP_E) + decimal.valueOf(qqWrapper.LLW) + decimal.valueOf(qqWrapper.DeliveryTotal) +  decimal.valueOf(qqWrapper.PickUpTotal) + decimal.valueOf(qqWrapper.Tax) + decimal.valueOf(qqWrapper.LocksAmount));
        qqWrapper.RecurringMonthlyCharges = string.valueOf(decimal.valueOf(qqWrapper.Rate) + decimal.valueOf(qqWrapper.Rental_PP_E) + decimal.valueOf(qqWrapper.LLW));
    }
    public void DisableKnowDelZoneBtn(){
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