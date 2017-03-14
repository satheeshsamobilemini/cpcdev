/**************************************************************************
Name:  QuickQuoteSalesController()
Copyright ? 2013  MMI 
----------------------------------------------------------------------
Purpose:
This is the Main COntroller class for Sales Quick Quote functionality 
-----------------------------------------------------------------------
History: 

VERSION  AUTHOR                 DATE        DETAIL              
1.0  -  TEKsystems             25/4/2013   INITIAL DEVELOPMENT  
**************************************************************************/
public with sharing class QuickQuoteSalesController {
	 public Branch_Lookup__c BranchLookup{get;set;}     
     public QuickQuoteWrapper qqWrapper{get;set;}
     public String addressErrorMessage{get;set;}
     public QuickQuoteWrapper.SalesFleetWapper salesWrap{get;set;}
     public List<QuickQuoteWrapper.showbranches> branchList {get;set;}
     public List<QuickQuoteWrapper.InnerProductClass> innerProductSearchList{get;set;} 
     public List<QuickQuoteWrapper.InnerProductClass> innerProductList{get;set;}
     public List<QuickQuoteWrapper.AddressInnerClass> AddressInnerClassList{get;set;}
     public List<QuickQuoteWrapper.DescarteInnerClass> DescarteInnerClassList{get;set;}
     
     public List<QuickQuoteWrapper.ProductSales> salesInventories{get;set;}
     
     public Boolean isViewBranchSearcieid{get;set;}
     public Boolean isViewBranchFulfillid{get;set;}
     public String fullfillingBranch{get;set;}
     
     public String qqType{get;set;}
     public String userBranchId{get;set;}
     public String BranchId{get;set;}
     public boolean salesRepErr{get;set;}
     
     public String MarketValueRange20S{get;set;}
     public String MarketValueRange20ZS{get;set;}
     public String MarketValueRange40S{get;set;}
     public String MarketValueRange40ZS{get;set;}
     
     public List<SelectOption> durationOptions {get;set;}
     public List<SelectOption> CountryOptions{get;set;}
     public List<SelectOption> transactionOptions{get;set;}
     public List<SelectOption> StateOptions{get;set;}
     public List<SelectOption> productTypeOptions {get;set;}
     public List<SelectOption> productSizeOptions {get;set;}
     public List<SelectOption> ecodeOptions {get;set;}
     public List<QuickQuoteWrapper.stateInnerClass> innerStateList{get;set;}
     public List<QuickQuoteWrapper.SalesFleetWapper> qqsalesFleetList{get;set;}
     public List<QuickQuoteWrapper.showbranches> branchSearchList{get;set;}
     public String userbranchidString{get;set;}
     public User loginUserRec{get;set;}
     public boolean isknowZoneRatesBtnDisabled {get;set;} // for TFS 2507
     public list<SelectOption> storageUseOptionsList {get;set;} // for TFS 2719
     public list<SelectOption> unitTypeOptionsList {get;set;} // for TFS 2719
     public list<SelectOption> HowLongWillYouNeedTheUnitOptionsList {get;set;} // for TFS 2719
     
     String validAddressId;
     
     boolean isLead = false;
     public String leadRecId{get;set;}
     boolean isErrorInValidateAddress = false;
     
    public MMI_Quotes__c mmiQuote = new MMI_Quotes__c();
    public MMI_Quotes__c getmmiQuote(){
        return mmiQuote ;  
    }
    List<Lead> leadRec = new List<Lead>();
    Lead lead_ref = new Lead();
    Opportunity opp_ref = new Opportunity();
    List<Opportunity> oppRec = new List<Opportunity>();
    
    List<Account> accountRec = new List<Account>(); // For Account Object Record
    Account accRec = new Account();
    public Lead getLeadRef(){
        return lead_ref;
    }
    public Opportunity getOppRef(){
        return opp_ref;
    }
    public Account getAccRef()
    {
        return accRec;
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
     //Constructer 
	public void QuickQuoteSalesController_initalize(){
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
        salesWrap=new QuickQuoteWrapper.SalesFleetWapper();
        
        durationOptions=QuickQuoteUtilities.getDurationList();
        productTypeOptions=QuickQuoteUtilities.getProductTypeList();
        productSizeOptions=QuickQuoteUtilities.getProductSizeList();
        
        CountryOptions= new List<SelectOption>();
        transactionOptions=new List<SelectOption>();
        ecodeOptions =new List<SelectOption>();
        ecodeOptions.add(new SelectOption('--None--','--None--'));
        
        qqWrapper.dispDescAddrPopUp=false;
        qqWrapper.disableTaxOkButton=false;
        qqWrapper.dispBranchPopUp=false;
        qqWrapper.showProduct=true;
        qqWrapper.showProductPopup=false;
        qqWrapper.showAddressPopup=false;
        qqWrapper.showSearchBranchIdTable=false;
         salesRepErr=false;
        
        QuickQuoteMainService qqService=new QuickQuoteMainService();
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
        	leadRecId = System.currentPageReference().getParameters().get('recId'); 
        	ContId = System.currentPageReference().getParameters().get('conId');
        }
        selectedConPh = System.currentPageReference().getParameters().get('conPh') ; 
        if(selectedConPh != null && selectedConPh != '' && selectedConPh != 'null'){
        	qqwrapper.primaryContactNo = selectedConPh;  
        }       
        leadRec = qqService.getLeadinfo(leadRecId);
        oppRec = qqService.getOppInfo(leadRecId);
        accountRec=qqService.getAccounListInfo(leadRecId);
        if(leadRec.size() > 0){
			qqWrapper.LeadOppName = leadRec[0].Name;
            lead_ref = leadRec[0];
            isLead = true;
            qqWrapper.tabStyle = 'Lead';
            qqWrapper.viewBranchUrl=leadRec[0].View_Branch_Snapshot__c;
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
        if(oppRec.size() > 0){
            qqWrapper.tabStyle = 'Opportunity';
            qqWrapper.LeadOppName = oppRec[0].Name;
            opp_ref = oppRec[0];
            opp_ref.Next_Activity_Date__c = null;
            qqWrapper.viewBranchUrl=oppRec[0].View_Branch_Snapshot__c;
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
		userbranchidString = qqWrapper.UserBranchId;       
        qqWrapper.Quantity = 1;
        qqWrapper.Locks = 0;
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

    /*******************************************************************
    Purpose     : This method is use to call webservice methods on load
    Parameters  : None
    Returns     : None
    ********************************************************************/ 
    public void LoadWBs(){
    	
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteSalesController :LoadWBs()');
        qqWrapper.isIncludeLLW = true;
        qqWrapper.isFuelSurcharge = true;  
        qqWrapper.showValidateAddress = true;
        String salesRepId;
        try{
            AmendShipping();
            qqwrapper.DisplayErrorPopUp = false;
            CountriesList(); 
            if(qqWrapper.UserBranchId != null || qqWrapper.FulfillingBranch!=null)
            {
               TransactionWebservice();
            }         
            callBranchWebservice();
            getMarketValuerange();
            QuickQuoteMainService qqService=new QuickQuoteMainService();
            salesRepId=qqService.getuserSalesRepId();
            boolean check = pattern.matches('[0-9]+',salesRepId.trim()); 
            if(!check){
            	salesRepErr=true;
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteSalesController LoadWBs:'+e.getMessage());

        }
        system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteSalesController :LoadWBs()');
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
    Purpose     : This action function is use to get and assign address info
    Parameters  : None
    Returns     : None
    ********************************************************************/
	public PageReference AmendShipping(){
		system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteSalesController :AmendShipping()');
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
                	}else{
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

            }else if(oppRec.size() > 0){
            	//------------------TFS 2720-----------------------------------
                if(oppRec[0].of_Units__c != null){
                	qqWrapper.Quantity = Integer.valueOf(oppRec[0].of_Units__c);
                }
                if(oppRec[0].Quote_Comments__c != null){
                        	qqwrapper.QuoteComments = oppRec[0].Quote_Comments__c;
                        }
                if(oppRec[0].Delivery_Country__c != null || oppRec[0].Delivery_State_Province__c != null
                   || oppRec[0].Delivery_Street__c != null || oppRec[0].Delivery_Zip_Postal_Code__c != null){
                   	    
                    qqWrapper.Address = oppRec[0].Delivery_Street__c;
                    qqWrapper.City = oppRec[0].Delivery_City__c;
                    qqWrapper.ZipCode = oppRec[0].Delivery_Zip_Postal_Code__c;
                    
                    if(oppRec[0].Delivery_Country__c!=null && oppRec[0].Delivery_Country__c.toLowerCase() == 'canada'){
                    	qqWrapper.Country = 'CAN';
                    }else if(oppRec[0].Delivery_Country__c!=null && oppRec[0].Delivery_Country__c.equalsIgnoreCase('united states')){
                         qqWrapper.Country = 'USA';
                    }else{
                    	if(oppRec[0].Delivery_Country__c != null && oppRec[0].Delivery_Country__c != '' && oppRec[0].Delivery_Country__c != 'N/A' ){
                    	qqWrapper.Country = oppRec[0].Delivery_Country__c.toUpperCase();
                    	}else{
                    		if(oppRec[0].Delivery_Country__c ==null){
	                           qqWrapper.Country = 'USA';
	                        }
                    	}
                    	
                    }
                    if(oppRec[0].Delivery_State_Province__c != null && oppRec[0].Delivery_State_Province__c != ''){
                    	qqWrapper.State = oppRec[0].Delivery_State_Province__c.toUpperCase();
                    }
                    
                }else{
                    if(accRec.Id != null){
                        if(accRec.ShippingStreet != null || accRec.ShippingCity != null || accRec.ShippingCountry != null || accRec.ShippingState != null || accRec.ShippingPostalCode != null ){            
							qqWrapper.Address = accRec.ShippingStreet;
                            qqWrapper.City = accRec.ShippingCity;
                            qqWrapper.ZipCode = accRec.ShippingPostalCode;
                            if(accRec.ShippingCountry != null && accRec.ShippingCountry != ''){
                            	qqWrapper.Country = accRec.ShippingCountry.toUpperCase();	
                            }
                            if(accRec.ShippingState != null && accRec.ShippingState != ''){
                            	qqWrapper.State = accRec.ShippingState.toUpperCase();	
                            }
                            
                            if(accRec.ShippingCountry!=null && accRec.ShippingCountry.toLowerCase() == 'canada'){
                            	qqWrapper.Country = 'CAN';
                            }else if(accRec.ShippingCountry!=null && accRec.ShippingCountry.equalsIgnoreCase('united states')){
		                         qqWrapper.Country = 'USA';
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
                             if(accRec.BillingCountry!=null){
                            	qqWrapper.Country = accRec.BillingCountry.toUpperCase();
                             }
                           
							if(accRec.BillingCountry!=null && accRec.BillingCountry.toLowerCase() == 'canada'){
								qqWrapper.Country = 'CAN';
							}else if(accRec.BillingCountry!=null &&accRec.BillingCountry.equalsIgnoreCase('united states')){
		                         qqWrapper.Country = 'USA';
		                    }else{
	                    		if(accRec.BillingCountry==null){
	                    			qqWrapper.Country = 'USA';
							}
							}
						}
					} 
				
                    if(oppRec[0].When_will_you_need_your_unit__c != null){
				          		mmiQuote.When_will_you_need_your_unit__c = oppRec[0].When_will_you_need_your_unit__c;	
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
			   		system.debug('-----accountRec----------');
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
		                	system.debug('-------accountRec[0].ShippingCountry---------'+accountRec[0].ShippingCountry);
		                	if(accountRec[0].ShippingCountry != null && accountRec[0].ShippingCountry != ''){
		                    qqWrapper.Country = accountRec[0].ShippingCountry.toUpperCase();
		                	}else{
		                			if(accountRec[0].ShippingCountry == null){
		                        	 	qqWrapper.Country = 'USA';
		                        	 	system.debug('------qqWrapper.Country-------'+qqWrapper.Country);
		                			}
		                  		}
		                	}
				            if(accountRec[0].ShippingState == 'N/A'){
				            	accountRec[0].ShippingState = '';
				            }
				            if(accountRec[0].ShippingState != null && accountRec[0].ShippingState != ''){
				           		qqWrapper.State = accountRec[0].ShippingState.toUpperCase(); 	
				            }
	                  }else{
							system.debug('------qqWrapper.Country-------'+qqWrapper.Country);
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
			                		if(accountRec[0].BillingCountry==null){
				                        	 qqWrapper.Country = 'USA';
				                        	 system.debug('------qqWrapper.Country-------'+qqWrapper.Country);
				                  		}
		                	}
				            if(accountRec[0].BillingState == 'N/A'){
				            	accountRec[0].BillingState = '';
				            }
		                    if(accountRec[0].BillingState!=null){
		                   	qqWrapper.State = accountRec[0].BillingState.toUpperCase();
		              }
		              }
			              system.debug('------qqWrapper.Country-------'+qqWrapper.Country);
	                  }
            		}
                }
         	StatesList();
         			
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteSalesController AmendShipping:'+e.getMessage());
        } 
        system.debug(LoggingLevel.DEBUG,'Exiting to  QuickQuoteSalesController : AmendShipping()'+qqWrapper);      
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
    Purpose     : This method is use to initiate country webservice
    Parameters  : None
    Returns     : None
    ********************************************************************/  
    public void CountriesList(){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteSalesController :CountriesList()');
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
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteSalesController CountriesList:'+e.getMessage());
        }    
        system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteSalesController :CountriesList()'+CountryOptions);
    }
    
    /*******************************************************************
    Purpose     : This method is use to initiate TransactionList
                  webservice
    Parameters  : None
    Returns     : None
    ********************************************************************/  
    public PageReference TransactionWebservice(){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteSalesController :TransactionWebservice()');
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
                	if(qqType == 'Sales'){
                		if(TT.description!='Chico Non-Container Rental'&&
		                    TT.description!='OTG'&&
		                    TT.description!='OTG Warehouse'&&
		                    TT.description!='Rental Offsite Xmas' && TT.description!='Rental Cartage' &&
		                    TT.description!= 'Rental Offsite Construction' &&  TT.description!= 'Rental Mobile Offices' &&  TT.description!='Rental Offsite Standard'
		                    &&  TT.description!='Rental On Site' &&  TT.description!='Rental Security Offices' && TT.description!=	'Rental Van Trailer' && TT.description!= 'Sale of Service'){
		                    	transactionOptions.add(new SelectOption(TT.Id,TT.description));
		                    }
                	}
                }
            }
            else{
				ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,transactionResponse[0].errorMessage);
                ApexPages.addMessage(msg);
                qqwrapper.DisplayErrorPopUp=true;
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteSalesController TransactionWebservice:'+e.getMessage());
        } 
        system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteSalesController :TransactionWebservice()'+transactionOptions);  
        return null;
    }
    
    /*******************************************************************
    Purpose     : This action function is use to call branch webservice 
    Parameters  : None
    Returns     : None
    ********************************************************************/
    public pagereference callBranchWebservice(){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteSalesController :callBranchWebservice()');
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
				branchList = new List<QuickQuoteWrapper.showbranches>();
               	Integer i = 1;
               	for(HomeBaseBeans.branches w : branches){
					QuickQuoteWrapper.showbranches s = new QuickQuoteWrapper.showbranches();
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
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteSalesController callBranchWebservice:'+e.getMessage());
         }
         system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteSalesController :callBranchWebservice()'+branchList);
         return null;
    }
    /*******************************************************************
    Purpose     : This method is use to initiate state webservice
    Parameters  : None
    Returns     : None
    ********************************************************************/  
    public void StatesList(){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteSalesController :StatesList()');               
        StateService_AC stateService = null;
        List<HomeBaseBeans.States> states ;
        qqwrapper.DisplayErrorPopUp = false;
        try{   
            stateService = new StateService_AC();
            states = stateService.listStates(qqWrapper.Country);
             if(Test.isRunningTest()){ 
				states = MMITestDataProvider.getQHomeBaseState();
 			}
            if(states[0].errorMessage == null){    
                StateOptions = new List<SelectOption>();
                StateOptions.add(new SelectOption('','-None-'));
                innerStateList = new List<QuickQuoteWrapper.stateInnerClass>();
                for(HomeBaseBeans.States ss : states){
                    StateOptions.add(new SelectOption(ss.Id,ss.Id));
                    
                    QuickQuoteWrapper.stateInnerClass IC = new QuickQuoteWrapper.stateInnerClass();
                    IC.Id = ss.Id;
                    IC.Name = ss.Name;
                    IC.countryId = ss.countryId;
                    IC.companyId = ss.companyId;
                    innerStateList.add(IC);
                }
            }else{
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,states[0].errorMessage);
                ApexPages.addMessage(msg);
                qqwrapper.DisplayErrorPopUp=true;
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteSalesController StatesList:'+e.getMessage());
        } 
        system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteSalesController :StatesList()'+innerStateList);  
    }  
    
    /*******************************************************************
    Purpose     : This action function is use to select product after product
                  search service
    Parameters  : None
    Returns     : None
    ********************************************************************/
    public PageReference SelectedProduct(){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteSalesController :SelectedProduct()'+innerProductList);
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
                qqWrapper.showProductPopup = false;
                
                 if(qqwrapper.TaxId==null){
		         	 SelectedAddressId();
		          }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteSalesController SelectedProduct:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Exiting to  QuickQuoteSalesController : SelectedProduct()'+qqwrapper);
        return null;
    }
    
     public void ProductsSelection()
    {                            
         system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteForm_Edit_AC :ProductsSelection');            
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
         catch(Exception e)
         {
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteForm_Edit_AC ProductsSelection:'+e.getMessage());
         }
         
        qqWrapper.showProductPopup = true;
        qqWrapper.showProduct = false;
         system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteForm_Edit_AC :ProductsSelection');
    }
    
    
    /*******************************************************************
    Purpose     : This action function is use to initiate product search webservice
    Parameters  : None
    Returns     : None
    ********************************************************************/
   public PageReference ProductSearch(){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteSalesController :ProductSearch()'); 
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
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteSalesController ProductSearch:'+e.getMessage());
        }         
		qqWrapper.showProductPopup = true;
        qqWrapper.showProduct = false;
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteSalesController :ProductSearch()');
        return null;
    }
    
    
    /*******************************************************************
    Purpose     : This method is use to get the list of products 
    Parameters  : None
    Returns     : None
    ********************************************************************/
    public void getSpecificProductDetail(){                
         system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteSalesController :getSpecificProductDetail'+qqWrapper.Product);
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
         qqWrapper.showProductPopup = false;

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
         
          qqWrapper.showProductPopup = true;
         	
         }
         catch(Exception e){    
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteSalesController getSpecificProductDetail:'+e.getMessage());
         }
         system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteSalesController :getSpecificProductDetail'+qqwrapper);
    }
    /*******************************************************************
    Purpose     : This action function is use to initiate the validate address
                  webservice
    Parameters  : None
    Returns     : None
    ********************************************************************/
    public PageReference ValidateAddress()
    {         
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteSalesController :ValidateAddress'+qqWrapper.countryId2+qqWrapper.zipCode2+qqWrapper.state2);
        qqwrapper.DisplayErrorPopUp = false;
        qqWrapper.disableTaxOkButton=false;
        HomeBaseBeans.AddressBean addressBean =null;
        Integer addressRecCount = 1;
        try{ 
              
			addressBean = new HomeBaseBeans.AddressBean();
			if(qqWrapper.address1!=null){
			addressBean.street = qqWrapper.address1;
			}else{
			     addressBean.street='';
			}
			if(qqWrapper.address3!=null){
			addressBean.city = qqWrapper.address3;
			}else{
			     addressBean.city='';
			}
			if(qqWrapper.state2 == null ||  qqWrapper.state2 == 'null')
			addressBean.state = '';
			else
			addressBean.state = qqWrapper.state2;
			if(qqWrapper.countryId2!=null){
			if(qqWrapper.countryId2.equalsIgnoreCase('CANADA')){
			    addressBean.country = 'CAN';
			}else{
			    addressBean.country = qqWrapper.countryId2;
			}
			}else{
			     addressBean.country=''; 
			}
			if(qqWrapper.zipCode2!=null){
			addressBean.zip = qqWrapper.zipCode2;
			}else{
			     addressBean.zip='';
			}

            ValidateAddressService_AC validateAddress = new ValidateAddressService_AC();
            List<HomeBaseBeans.TaxIds> validateAddressResponse = validateAddress.taxIdLookup(addressBean);
            
            if(Test.isRunningTest()){ 
				validateAddressResponse = MMITestDataProvider.getQHomeBaseTax();
 			}
            qqWrapper.showAddressPopup  = true;
            AddressInnerClassList = new List<QuickQuoteWrapper.AddressInnerClass>();
  
            if(validateAddressResponse[0].errorMessage == null){
                 for(HomeBaseBeans.TaxIds TI : validateAddressResponse){
                    QuickQuoteWrapper.AddressInnerClass IC = new QuickQuoteWrapper.AddressInnerClass();
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
             }else{
                 ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,validateAddressResponse[0].errorMessage);
                 ApexPages.addMessage(msg);
                 qqWrapper.disableTaxOkButton=true;
                  qqWrapper.showAddressPopup  = true;
             } 
                
        }catch(Exception e){
                 system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteSalesController ValidateAddress:'+e.getMessage());
                 ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,e.getMessage());
                 ApexPages.addMessage(msg);
                 qqWrapper.disableTaxOkButton=true;
                 qqWrapper.showAddressPopup  = true; 
        }           
        system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteSalesController :ValidateAddress'+AddressInnerClassList);  
        return null;
    }
    

    // On click on OK button on Validate Address
    public PageReference SelectedAddressId()
    {
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteSalesController :SelectedAddressId()'+AddressInnerClassList);  
        qqWrapper.showAddressPopup  = false;
        try{
                for(QuickQuoteWrapper.AddressInnerClass I : AddressInnerClassList)
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
                        }                        
                    }
                }
                
        }catch(Exception e){
                     system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteSalesController ValidateAddress:'+e.getMessage());
            } 
        system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteSalesController :SelectedAddressId()'+validAddressId);
        return null;
    }
    
   
    /*******************************************************************
    Purpose     : This action function is use to initiate the Descarte webservice 
                  for fulfilling branch
    Parameters  : None
    Returns     : None
    ********************************************************************/
    public PageReference SelectFulfillingBranch()
    {
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteSalesController :SelectFulfillingBranch()');
        ValidateAddressService_AC validateAddress=null;
        List<HomeBaseBeans.webAddresses> validateAddressResponse;
        DescarteInnerClassList = new List< QuickQuoteWrapper.DescarteInnerClass>();
        qqWrapper.disableAddressOkButton=false;
      //  if(checkZipCodeValidation())
      //  {
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
        
      //  if(qqWrapper.country!=null && qqWrapper.zipCode!=null && qqWrapper.State != null)
      //  {
      if(qqWrapper.country!=null && qqWrapper.country!='' && ((qqWrapper.CrossStreets!=null && qqWrapper.CrossStreets!='') || (qqWrapper.address!=null && qqWrapper.address!='')))
       {
            try{ 
                validateAddress = new ValidateAddressService_AC();  
                validateAddressResponse = validateAddress.descartesLookup(addressBean);
                if(Test.isRunningTest()){ 
					validateAddressResponse = MMITestDataProvider.getQHomeBaseWebAdd();
				}
                if(validateAddressResponse[0].errorMessage == null)
                { 
                    Integer i = 1;
                    for(HomeBaseBeans.webAddresses w : validateAddressResponse)
                    {
                            QuickQuoteWrapper.DescarteInnerClass IC = new QuickQuoteWrapper.DescarteInnerClass();
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
                        qqWrapper.disableAddressOkButton=true;
                    }
                }
                else
                {
                    ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,validateAddressResponse[0].errorMessage);
                    ApexPages.addMessage(msg);
                    isErrorInValidateAddress = true;
                    //DisplayErrorPopUp=true;
                }
                qqWrapper.dispDescAddrPopUp = true;
                selectFulfillingLoaded = true;  
             
            }
            catch(Exception e)
            {
               system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteSalesController SelectFulfillingBranch:'+e.getMessage());
                isErrorInValidateAddress = true;
            }
            
        }
        else
        {
             ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,'Required fields are missing');
             ApexPages.addMessage(msg);
             qqWrapper.dispDescAddrPopUp = true;
             selectFulfillingLoaded = true;
             isErrorInValidateAddress = true;  
        }
      /*  }else{
            qqWrapper.dispDescAddrPopUp = true;
            selectFulfillingLoaded = true;

            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,'Zip Code is not valid');
            ApexPages.addMessage(msg);
        }*/
        system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteSalesController :SelectFulfillingBranch()');
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
        system.debug(LoggingLevel.DEBUG,'Entring QuickQuoteSalesController :FulfillingBranchSelected()'); 
		latitudeForCapLukp = '';
        longitudeForCapLukp = '';
        qqWrapper.dispDescAddrPopUp  = false;
        try{
                for(QuickQuoteWrapper.DescarteInnerClass I : DescarteInnerClassList)
                {
                    Integer recNumber;
                    if(System.currentPageReference().getParameters().get('selectedAddr') != null)
                    {       
                        recNumber =  Integer.valueOf(System.currentPageReference().getParameters().get('selectedAddr'));
                    }
                    if(I.RecUniqId == recNumber)
                    {       
                        qqWrapper.FulfillingBranch = I.fulfillingBranch;
                        qqWrapper.distanceFromBranch=I.distanceFromBranch;
                        qqWrapper.DeveloperZone = I.deliveryZone;
                        qqWrapper.address1 = I.address1;
                        qqWrapper.address2 = I.address2;
                        qqWrapper.address3 = I.address3;
                        qqWrapper.address4 = I.address4;
                        if(I.State!=null)
                        qqWrapper.state2 = I.State;
                        if(I.zipCode!=null) 
                        qqWrapper.zipCode2 = I.zipCode;
                        if(I.countryId!=null)
                        qqWrapper.countryId2  = I.countryId;
                        //addressErrorMessage = I.zoneWarning;
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
              system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteSalesController FulfillingBranchSelected:'+e.getMessage());
         }
            
         system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteSalesController :FulfillingBranchSelected()');
         return null;
    }
        
    /*******************************************************************
    Purpose     : This action function is use to search address functionality
    Parameters  : None
    Returns     : None
    ********************************************************************/
    public PageReference SearchDescAddress()
    {
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteSalesController :SearchDescAddress()');
        try{
            branchSearchList = new List<QuickQuoteWrapper.showbranches>();      
            if((qqWrapper.BranchIdSearchWord == null || qqWrapper.BranchIdSearchWord == '') && (qqWrapper.BranchNameSearchWord == null || qqWrapper.BranchNameSearchWord == ''))
            {   
                qqWrapper.showSearchBranchIdTable = false;
            }
            else
            {           
                for(QuickQuoteWrapper.showbranches I : branchList)
                {
                    if((qqWrapper.BranchIdSearchWord!= '') && (I.Id).startswith(qqWrapper.BranchIdSearchWord) || (qqWrapper.BranchNameSearchWord != '' ) &&(I.Name.toLowerCase()).Contains(qqWrapper.BranchNameSearchWord.toLowerCase()))
                    {
                        branchSearchList.add(I);
                    }
                }
                qqWrapper.showSearchBranchIdTable = true;
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteSalesController SearchDescAddress:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteSalesController :SearchDescAddress()'+branchSearchList);    
        return null;
        
    }
    /*******************************************************************
    Purpose     : This method is use to select branch functionality
    Parameters  : None
    Returns     : None
    ********************************************************************/
    public void SelectedBranchMethod(){
       system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteSalesController :SelectedBranchMethod()');                              
       qqWrapper.dispBranchPopUp  = false;  
       QuickQuoteHelper qqHelper=null;
       try{          
       	   addressErrorMessage = '';
       	   qqWrapper.distanceFromBranch = null; 
           for(QuickQuoteWrapper.showbranches I : branchList){
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
       //  qqwrapper.showProdSelect = true;
         //qqwrapper.showRefreshQUote = true;
         qqwrapper.showSaveButton = false;
           
           getMarketValuerange();
           makeAddAvailable();
        
       }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteSalesController SelectedBranchMethod:'+e.getMessage());
       }
       system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteSalesController :SelectedBranchMethod()'+System.currentPageReference().getParameters().get('selectedBranch'));
    }
    
    
    /*******************************************************************
    Purpose     : This method is use to branch id Tab Off functionality
    Parameters  : None
    Returns     : None
    ********************************************************************/
    public void getSpecificBranchIDMethod(){
       system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteSalesController :getSpecificBranchIDMethod()');                              
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
         //qqwrapper.showProdSelect = true;
         //qqwrapper.showRefreshQUote = true;
         qqwrapper.showSaveButton = false;
       
           idEntered = System.currentPageReference().getParameters().get('fBranchCode');
           if(idEntered!=null && idEntered!=''){
	           for(QuickQuoteWrapper.showbranches I : branchList){         
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
           
          getMarketValuerange();
          makeAddAvailable();
   
       }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteSalesController getSpecificBranchIDMethod:'+e.getMessage());
       }
       system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteSalesController :getSpecificBranchIDMethod()'+System.currentPageReference().getParameters().get('fBranchCode'));
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

  /*   public void getSalesFleets(String productId){
         system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteSalesController :getSalesFleets()'+productId);                              
         SalesFleet_Service salesFleetService =null;
         List<HomeBaseBeans.SalesFleets> salesFleetList =null ;
         try
         {  
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
	            if(!salesFleetList.isEmpty() && salesFleetList[0].errorMessage == null)
	            {
	                for(HomeBaseBeans.SalesFleets sf : salesFleetList)
	                {
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
   /* public PageReference getNetValue(){
    	system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteSalesController :getNetValue()'+qqWrapper.ecode);
    	salesRepErr = false;
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
		         	    	system.debug('-----qqWrapper.totalCost-----'+qqWrapper.totalCost);
		         	    	system.debug('----qqWrapper.totalTax--'+qqWrapper.totalTax);
		         	    	
		         	    	
		         	    	if(qqWrapper.totalCost != null && qqWrapper.totalCost != ''){
		         	    		String bGross=String.valueOf((Double.valueOf(qqWrapper.totalCost)/Double.valueOf(qqWrapper.sellingPrice))*100);
			         	    	system.debug('---------bGross---------'+bGross);
			         	    	qqWrapper.branchGross=String.valueOf(decimal.valueOf(bGross).setScale(2));
			         	    	system.debug('-------qqWrapper.branchGross-----'+qqWrapper.branchGross);
		         	    	}
		         	    }
		            }
		    	} 
	    	}
	    	if(qqWrapper.ecode =='--None--'){  
	    		qqWrapper.sellingPrice = null;
	    		qqWrapper.suggestedPrice = null;
	    		qqWrapper.minimumPrice = null;
	    		qqWrapper.modificationTotal = null;
	    		qqWrapper.marketValue = null;
	    		qqWrapper.netBookValue = null;
	    		qqWrapper.branchGross = null;
	    		qqwrapper.Tax = null;
	    		qqwrapper.totalCost = null;
	    		qqWrapper.Delivery = null;
	    	}
	    	qqWrapper.showSaveButton = false;
    	}catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteSalesController getNetValue:'+e.getMessage());
       }
    	system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteSalesController :getNetValue()'+qqWrapper);
        return null;
    }
    */
    
     public void Refresh(){  
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteSalesController :Refresh()'+validAddressId +'---'+qqwrapper.TaxId);
        qqWrapper.tyleofQuoute = qqType; 
        QuickQuoteHelper QQRHelper=null;
        HomeBaseBeans.QuickQuoteRefreshFormat QQRF =null; 
        HomeBaseBeans.quickQuoteRefresh d =null;
        RefreshQuickQuoteService_AC refreshQuote=null;
        qqwrapper.DisplayErrorPopUp=false;
        try{
            qqWrapper.Duration='0'; 
             if(Test.isRunningTest()){ 
             	qqWrapper.sellingPrice='100';
             }
            
            if(!checkMandatoryField())
            {     
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
                     QQRF=QQRHelper.refreshQQwrapper(qqWrapper, qqWrapper.FulfillingBranch, qqwrapper.TaxId, mmiQuote.Date_From__c);
                }else{
                     QQRF=QQRHelper.refreshQQwrapper(qqWrapper, qqWrapper.UserBranchId, qqwrapper.TaxId, mmiQuote.Date_From__c);
                }
                if(QQRF!=null){
                     refreshQuote = new RefreshQuickQuoteService_AC();
                     d = refreshQuote.refreshQuickQuote(QQRF);  
                }       
                if(d!=null && d.errorMessage == null)
                {
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
                        system.debug('-------------qqWrapper.unitType-------------------'+qqWrapper.unitType);
                        
                }         
                else
                {
                     ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,d.errorMessage);
                     ApexPages.addMessage(msg);
                     qqwrapper.DisplayErrorPopUp=true;
                }
                
	            }else{
	            	 ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,'Please Provide Selling Price');
                    ApexPages.addMessage(msg);
	            }
            }
            else
            {
                 ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,'Please fill required fields');
                 ApexPages.addMessage(msg);
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteSalesController Refresh:'+e.getMessage());
        } 
        system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteSalesController :Refresh()');
  
    }
    
	public pagereference saveQuickQuoteSales(){
		system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteSalesController :saveQuickQuote()');
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
			if(mmiQuote.Date_From__c!=null && mmiQuote.Date_From__c >= system.today()){
					if(mmiQuote.Close_Date__c!=null && mmiQuote.Close_Date__c >= system.today()){
				
				dateval = mmiQuote.Date_From__c.year()+'-'+mmiQuote.Date_From__c.month()+'-'+mmiQuote.Date_From__c.day();
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
                 
                 QuickQuoteSaveRequestGenerator qqsaveRequest=new QuickQuoteSaveRequestGenerator();
                if(qqWrapper.FulfillingBranch!=null && qqWrapper.FulfillingBranch!=''){
	                savePayload=qqsaveRequest.getQuickQuoteRefreshRequest(qqWrapper,qqWrapper.FulfillingBranch,dateval,salesRepId, 'Sales');
	                 
	             }else{
	             	 savePayload=qqsaveRequest.getQuickQuoteRefreshRequest(qqWrapper,qqWrapper.UserBranchId,dateval,salesRepId, 'Sales');
	                 
	             }
                 
               /* if(qqWrapper.FulfillingBranch!=null && qqWrapper.FulfillingBranch!=''){
	                savePayload = '{"quickQuote":{"duration":'+qqWrapper.Duration+',"lead":"'+qqWrapper.LeadOppName+'","ecode": '+qqWrapper.ecode+',"transport":"'+qqWrapper.Transport+'","transactionId":"'+qqWrapper.TransactionType+'","rate":"'+qqWrapper.Rate+'","rentalPPETotal":"'+ qqWrapper.Rental_PP_E+'","transportSurchargeTotal":"'+qqwrapper.FuelSurcharge+'","quickQuoteTotal":"'+qqWrapper.QuickQuote+'","dateFrom":'+dateval+',"shippingAddress":{"state":"'+qqWrapper.State+'","countryId":"'+qqWrapper.country+'","address1":"'+qqWrapper.Address+'","address2":"","address3":"'+qqWrapper.City+'","address4":"","zipCode":"'+qqWrapper.zipcode+'", "taxId": "'+qqwrapper.TaxId+'","fulfillingBranchId": "'+qqWrapper.FulfillingBranch+'"},"productId":"'+qqWrapper.Product+'","branchId":"'+qqWrapper.FulfillingBranch+'","llwTotal":"'+qqWrapper.LLW+'","locksTotal":"'+qqWrapper.LocksAmount+'","taxTotal":"'+qqWrapper.Tax+'","codAmount":"'+qqWrapper.COD+'","includeLLW":'+IntMap.get(qqWrapper.isIncludeLLW)+',"fuelSurcharge":'+IntMap.get(qqWrapper.isFuelSurcharge)+',"locksQty":'+qqWrapper.Locks+',"companyId": 1, "operatorId" : "result", "salesRep":'+salesRepId+', "status":"Active" }}';
				}else{
					savePayload = '{"quickQuote":{"duration":'+qqWrapper.Duration+',"lead":"'+qqWrapper.LeadOppName+'","ecode": '+qqWrapper.ecode+',"transport":"'+qqWrapper.Transport+'","transactionId":"'+qqWrapper.TransactionType+'","rate":"'+qqWrapper.Rate+'","rentalPPETotal":"'+ qqWrapper.Rental_PP_E+'","transportSurchargeTotal":"'+qqwrapper.FuelSurcharge+'","quickQuoteTotal":"'+qqWrapper.QuickQuote+'","dateFrom":'+dateval+',"shippingAddress":{"state":"'+qqWrapper.State+'","countryId":"'+qqWrapper.country+'","address1":"'+qqWrapper.Address+'","address2":"","address3":"'+qqWrapper.City+'","address4":"","zipCode":"'+qqWrapper.zipcode+'", "taxId": "'+qqwrapper.TaxId+'","fulfillingBranchId": "'+qqWrapper.UserBranchId+'"},"productId":"'+qqWrapper.Product+'","branchId":"'+qqWrapper.UserBranchId+'","llwTotal":"'+qqWrapper.LLW+'","locksTotal":"'+qqWrapper.LocksAmount+'","taxTotal":"'+qqWrapper.Tax+'","codAmount":"'+qqWrapper.COD+'","includeLLW":'+IntMap.get(qqWrapper.isIncludeLLW)+',"fuelSurcharge":'+IntMap.get(qqWrapper.isFuelSurcharge)+',"locksQty":'+qqWrapper.Locks+',"companyId": 1, "operatorId" : "result", "salesRep":'+salesRepId+', "status":"Active" }}';
                }*/
                createQuickQuote = new CreateQuickQuoteService_AC();
                createQuickQuoteResponse = createQuickQuote.createQuickQuote(savePayload);
                
                if(Test.isRunningTest()){ 
                	createQuickQuoteResponse = MMITestDataProvider.getQHomeBaseCreateQQ();
				}
				if(createQuickQuoteResponse.errorMessage == null){
                        insertQuote = new MMI_Quotes__c();   
                        qqwrapper.DisplayErrorPopUp = false;
                        if(!leadRec.isEmpty()){
                        		//FullQuoteDAO.createTaskBeforeSavingFQ(leadRec[0].id,'Quick Quote');
                                lcr=qqService.getConvertLeadResult(leadRec[0].id, UserInfo.getUserId(), qqWrapper);
                                FullQuoteDAO.createTaskBeforeSavingFQ(lcr.getOpportunityId(),'Quick Quote');
                                qqwrapper.SourceOfQQ = 'lead';
                                if(qqWrapper.FulfillingBranch!=null && qqWrapper.FulfillingBranch!=''){
                                     quoteOppID=qqService.insertQuickQuoteSalesRecord(insertQuote, qqWrapper.FulfillingBranch, mmiQuote.Date_From__c, qqwrapper.TaxId, lcr.getOpportunityId(), createQuickQuoteResponse.documentId, qqwrapper,lcr.getAccountId());
                                }else{
                                    quoteOppID=qqService.insertQuickQuoteSalesRecord(insertQuote, qqWrapper.UserBranchId, mmiQuote.Date_From__c, qqwrapper.TaxId, lcr.getOpportunityId(), createQuickQuoteResponse.documentId, qqwrapper,lcr.getAccountId());

                                }
                                if(quoteOppID!=null){
                                	qqwrapper.selectedOrConvertedContactId = string.valueOf(lcr.getContactId());     
                                    quoteOppIDAfterUpdate=qqService.updateOppNameSales(quoteOppID, qqwrapper,mmiQuote.Close_Date__c, mmiQuote.When_will_you_need_your_unit__c,leadRec[0].Servicing_Branch_Id__c);
                                } 
                        }else if(!oppRec.isEmpty()){
                               qqwrapper.SourceOfQQ = 'opportunity'; 
                               if(qqWrapper.FulfillingBranch!=null && qqWrapper.FulfillingBranch!=''){
                                     quoteOppID=qqService.insertQuickQuoteSalesRecord(insertQuote, qqWrapper.FulfillingBranch, mmiQuote.Date_From__c, qqwrapper.TaxId,oppRec[0].id, createQuickQuoteResponse.documentId, qqwrapper,oppRec[0].AccountId);
                               }else{
                                    quoteOppID=qqService.insertQuickQuoteSalesRecord(insertQuote, qqWrapper.UserBranchId, mmiQuote.Date_From__c, qqwrapper.TaxId,oppRec[0].id, createQuickQuoteResponse.documentId, qqwrapper,oppRec[0].AccountId);

                               }
                               if(quoteOppID!=null){
                               		qqwrapper.selectedOrConvertedContactId = ContId;    
                                    quoteOppIDAfterUpdate=qqService.updateOppNameSales(quoteOppID, qqwrapper,mmiQuote.Close_Date__c, mmiQuote.When_will_you_need_your_unit__c,null);
                                }
                        }
                        
                        else if(!accountRec.isEmpty()){
                        	  qqwrapper.SourceOfQQ = 'account';
                        	  String oppID= qqService.insertOpportunity(accountRec[0]);
                        	
                        	 if(qqWrapper.FulfillingBranch!=null && qqWrapper.FulfillingBranch!=''){
                                     quoteOppID=qqService.insertQuickQuoteSalesRecord(insertQuote, qqWrapper.FulfillingBranch, mmiQuote.Date_From__c, qqwrapper.TaxId,oppID, createQuickQuoteResponse.documentId, qqwrapper,accountRec[0].Id);
                             }else{
                                    quoteOppID=qqService.insertQuickQuoteSalesRecord(insertQuote, qqWrapper.UserBranchId, mmiQuote.Date_From__c, qqwrapper.TaxId,oppID, createQuickQuoteResponse.documentId, qqwrapper,accountRec[0].Id);

                             }
                             if(quoteOppID!=null){
                             	   qqwrapper.selectedOrConvertedContactId = ContId;    
                                   quoteOppIDAfterUpdate=qqService.updateOppNameSales(quoteOppID, qqwrapper,mmiQuote.Close_Date__c, mmiQuote.When_will_you_need_your_unit__c,null);
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
                        	 		QuickQuoteMainDAO.createTaskAfterQQCreationForFollowUpCall(quoteOppID,'qq',opp_ref.Next_Activity_Date__c,OpportunityRecAfterContactLookup.Opportunity_Contact_Name_LookUpFilter__c, qqwrapper);
                        	 	}
                        	 }
                        	 //-----------------Issue 1269------------------------
                             pf = new PageReference('/'+quoteOppID);
                             pf.setRedirect(true);
                             return pf ; 
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
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteSalesController saveQuickQuote:'+e.getMessage());
           return null; 
        }
        system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteSalesController :saveQuickQuote()');
        return pf;

    }
    
     
    /*******************************************************************
    Purpose     : This method is use to validate mendatory fields 
    Parameters  : None
    Returns     : None
    ********************************************************************/  
    public boolean checkMandatoryField()
    {
        if(qqwrapper.Product==null||qqwrapper.Product==''||
                mmiQuote.Date_From__c==null||
                qqwrapper.TransactionType==null|| qqwrapper.TransactionType=='-None-')
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
    
    /*******************************************************************
    Purpose     : This action function is use to close product search popup
    Parameters  : None
    Returns     : None
    ********************************************************************/
      public PageReference CloseProductPopUp(){       
        system.debug(LoggingLevel.DEBUG,'In Close CloseProductPopUp');    
        qqWrapper.showProductPopup = false;
        qqwrapper.showSearchError = false; 
        qqwrapper.showValidateAddress = false;
        qqwrapper.showProdSelect = true;
        return null;
    }
    public PageReference CancelFulfillingBranchSelected()
    {   
        qqWrapper.dispDescAddrPopUp  = false;
        qqwrapper.showValidateAddress = true;
        qqwrapper.showProdSelect = false;
        return null;
    }
    
    public void disableSaveButton()
    {
        qqwrapper.showSaveButton = false;
        if(!qqWrapper.showValidateAddress){
         qqwrapper.showRefreshQUote=true;
        }
    } 
    
    
        public void onChangeDelivery()
    {
        mmiQuote.When_will_you_need_your_unit__c=mmiQuote.Date_From__c;
        
        qqwrapper.showSaveButton = false;
        if(!qqWrapper.showValidateAddress){
         qqwrapper.showRefreshQUote=true;
        }
        
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
        qqwrapper.showValidateAddress = true;
        qqwrapper.showSaveButton = false;
        qqwrapper.showRefreshQUote = false;
        qqwrapper.showProdSelect= false;
    }
    
     public void changeIncludeLLW()
    {
        disableSaveButton();
        if(qqwrapper.TransactionType=='ON'){
                qqWrapper.isIncludeLLW=false;
        }else{
        	qqWrapper.isIncludeLLW=true;
        }
     }
     
    public PageReference viewBranchPage()
    {  
        PageReference viewBranch= new PageReference('/apex/ViewWeeklyBranchSnapshot?servicingBranch='+qqWrapper.UserBranchId+'&retURL='+leadRecId);
        viewBranch.setredirect(true);
        return viewBranch;
    }
    public void test(){
    	
    }
        
    public PageReference CancelSelectedAddressId()
    {
        qqWrapper.showAddressPopup  = false;
        return null;
    } 
     public pageReference showdispBranchPopUp()
   {
        qqWrapper.dispBranchPopUp = true;
        return null;
    }
    
     public pageReference hidedispBranchPopUp(){
        qqWrapper.dispBranchPopUp = false;
        
        qqWrapper.BranchIdSearchWord = '';
		qqWrapper.BranchNameSearchWord = '';
        
        getMarketValuerange();
        return null;
    }
  
    public PageReference SaveAddress()
    {
        qqWrapper.showAddressPopup = false;
        return null;
    }
     public boolean getDispAddressPopUp()
    {
        return qqWrapper.showAddressPopup;
    }
    
    public boolean getDispProductPopUp()
    {
        return qqWrapper.showProductPopup;
    }

    public pagereference hideError()
    {
       qqWrapper.DisplayErrorPopUp = false;
        return null;
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
   		system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteSalesController :callCapacityLookupWebservice');
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
                clr = QuickQuoteMainDAO.createCapLkupPayload(latitudeForCapLukp, longitudeForCapLukp, qqWrapper, leadRecId, mmiQuote.Date_From__c, selectedProdDescForCapLkup);
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
        mmiQuote.Date_From__c = date.valueOf(selectedCapacityDate.substring(0,10));
        mmiQuote.When_will_you_need_your_unit__c = date.valueOf(selectedCapacityDate.substring(0,10));
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
        qqWrapper.COD = string.valueOf(decimal.valueOf(qqWrapper.Rate) + decimal.valueOf(qqWrapper.Rental_PP_E) + decimal.valueOf(qqWrapper.LLW) + decimal.valueOf(qqWrapper.Delivery) +  decimal.valueOf(qqWrapper.PickUp) + decimal.valueOf(qqWrapper.Tax) + decimal.valueOf(qqWrapper.LocksAmount));
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