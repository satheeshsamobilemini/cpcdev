public with sharing class FullQuoteMainService {
	
	
	public Full_Quote_Transactional__c getFullQuoteTransactional(String fqtId){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteMainService :getFullQuoteTransactional');
        Full_Quote_Transactional__c fullQuoteTran=null;
        try{ 
        	fullQuoteTran=FullQuoteDAO.getFullQuoteTransactional(fqtId);
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteMainService getFullQuoteTransactional:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteMainService : getFullQuoteTransactional()'+fullQuoteTran);
        
        return fullQuoteTran;
    }  
    
    public List<Rate__c> getRateListInfo(Set<id> productId){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteMainService :getRateListInfo');
        List<Rate__c> rateList=null;
        try{
            if(productId!=null){
                rateList=FullQuoteDAO.getRateRecord(productId); 
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteMainService getRateListInfo:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteMainService : getRateListInfo()'+rateList);
        
        return rateList;
    }
    
    
	
	 /*********************************************************************
    Purpose     : To get Users Branch info
    Parameters  : none 
    Returns     : Branch id 
    **********************************************************************/
    public string getuserBranchInfo(){
        system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteMainService : getuserInfo'); 
        User userInfo=null;
        try{
            //invoke DAO mathod to get profile detail
             userInfo=FullQuoteDAO.getUserBranchDetails();
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting FullQuoteMainService  getuserInfo:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to   FullQuoteMainService : getuserInfo()'+userInfo);
        return userInfo.Branch_Id__c;
    
    }
    /*********************************************************************
    Purpose     : To get Users Branch info
    Parameters  : none 
    Returns     : Branch id 
    **********************************************************************/
    public string getuserSalesRepId(){
        system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteMainService : getuserSalesRepId'); 
        User userInfo=null;
        try{
            //invoke DAO mathod to get profile detail
             userInfo=FullQuoteDAO.getUserBranchDetails();
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting FullQuoteMainService  getuserSalesRepId:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to   FullQuoteMainService : getuserSalesRepId()'+userInfo);
        return userInfo.Sales_Rep_Id__c;
    
    }
    
    /*********************************************************************
    Purpose     : To get Lead info
    Parameters  : lead id 
    Returns     :list of  Lead object
    **********************************************************************/
    public List<Lead> getLeadinfo(String leadRecID){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteMainService :getLeadinfo');
        List<Lead> leadRec=null;
        try{
            if(leadRecID!=null){
                leadRec=FullQuoteDAO.getLeadRecord(leadRecID);
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteMainService getLeadinfo:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteMainService : getLeadinfo()'+leadRec);
        
        return leadRec;
    }
    
     /*********************************************************************
    Purpose     : To get Lead info getLeadIndustry
    Parameters  : lead id 
    Returns     :list of  Lead object
    **********************************************************************/
    public List<Lead> getLeadIndustry(String leadRecID){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteMainService :getLeadinfo');
        List<Lead> leadRec=null;
        try{
            if(leadRecID!=null){
                leadRec=FullQuoteDAO.getLeadIndustry(leadRecID);
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteMainService getLeadinfo:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteMainService : getLeadinfo()'+leadRec);
        
        return leadRec;
    }
    
    public List<Account> getAccountEmailList(String accountId){
    	List<Account> accEmailList=null;
    	system.debug('---------accountId------------'+accountId);
    	try{
    		if(accountId != null){
    			accEmailList = FullQuoteDAO.getAccountRecord(accountId);
    		}
    	}catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteMainService getAccountEmailList:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteMainService : getAccountEmailList()'+accEmailList);
        system.debug('--------accEmailList-----------'+accEmailList.size());
        return accEmailList;
    	
    }
    
    /*********************************************************************
    Purpose     : To get opportunity info
    Parameters  : lead id 
    Returns     : list of Opportunity object
    **********************************************************************/
    public List<Opportunity> getOppInfo(String leadRecID){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteMainService :getOppInfo');
        List<Opportunity> oppRec=null;
        try{
            if(leadRecID!=null){
                oppRec=FullQuoteDAO.getOppRecord(leadRecID);
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteMainService getOppInfo:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteMainService : getOppInfo()'+oppRec);
        
        return oppRec;
    }
    
    
    public List<Account> getAccounListInfo(String AccountRedId){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteMainService :AccountRedId'+AccountRedId);
        List<Account> accRec=null;
        try{
            if(AccountRedId!=null){
                accRec=FullQuoteDAO.getAccountList(AccountRedId); 
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteMainService AccountRedId:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteMainService : AccountRedId()'+accRec);
        
        return accRec;
    }
    
    /*********************************************************************
    Purpose     : To get Quick Quote info
    Parameters  : lead id 
    Returns     : list Quick Quote object
    **********************************************************************/
    public MMI_Quotes__c getQqInfo(String QqRecID){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteMainService :getQqInfo');
        MMI_Quotes__c QqRec = new MMI_Quotes__c();
        try{
            if(QqRecID != null && QqRecID != ''){
                QqRec = [Select m.Zip_Code__c, m.Transport_Costs__c, m.Transaction_Type__c, m.Tax_id__c, m.Tax__c, m.Tax_Total__c, m.SystemModstamp, m.Suggested_Price__c, m.Status__c, m.State__c, m.Start_Date__c, m.Selling_Price__c, m.Reoccurring_Monthly_Charges__c, m.Rental_Rate__c, m.Rental_PP_E__c, m.Rental_PP_E_Total__c, m.Quote_Id__c, m.Quick_Quote__c, m.Quick_Quote_Total__c, m.Qty__c, m.QQ_Type__c, m.Product__c, m.Pick_Up__c, m.Pick_Up_Total__c, m.Opportunity__c, m.Name, m.Modification_Charge__c, m.Minimum_Price__c, m.Locks__c, m.Locks_Total__c, m.Locks_N__c, m.LastModifiedDate, m.LastModifiedById, m.LastActivityDate, m.LLW__c, m.LLW_Total__c, m.IsDeleted, m.Include_LLW__c, m.Id, m.Fulfilling_Branch__c, m.Fuel_surcharge__c, m.Fuel_Surcharge_Total__c, m.Fuel_Surcharge_N__c, m.Ecode__c, m.Duration__c, m.Distance_from_branch__c, m.Delivery__c, m.Delivery_Total__c, m.Date_From__c, m.CurrencyIsoCode, m.Cross_Streets__c, m.CreatedDate, m.CreatedById, m.Country__c, m.City__c, m.COD__c, m.COD_Total__c, m.Branch_id__c, m.Address__c From MMI_Quotes__c m where m.Id = :QqRecID];
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteMainService getOppInfo:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Exiting to  FullQuoteMainService : getQqInfo()'+QqRec.Quote_Id__c);
        
        return QqRec;
    }
    
    /*********************************************************************
    Purpose     : To get Account info
    Parameters  : Account Id 
    Returns     : Account object
    **********************************************************************/
    public Account getAccInfo(String accID){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteMainService :getAccInfo');
        Account accRec=null;
        try{
            if(accID!=null){
                accRec=FullQuoteDAO.getAccRecord(accID);
                
            }   
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteMainService getAccInfo:'+e.getMessage());
        }
         system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteMainService : getAccInfo()'+accRec);
        
        return accRec;
    }
   
   
	/*********************************************************************
    Purpose     : To get convert the existing lead
    Parameters  : lead id and owner id 
    Returns     : Lead conversion result
    **********************************************************************/
    public Database.LeadConvertResult getConvertLeadResult(String leadId , String ownerId){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteMainService :getConvertLeadResult'+leadId + ownerId);
        Database.LeadConvertResult leadConverResult=null;
        try{
            if(leadId!=null && ownerId!=null){
                leadConverResult=FullQuoteDAO.convertLead(leadId, ownerId);
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteMainController_AC getConvertLeadResult:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteMainService : getConvertLeadResult()'+leadConverResult);
        
        return leadConverResult;
    }	
    
    
    /*********************************************************************
    Purpose     : To get convert the existing lead
    Parameters  : lead id ,owner id and resultid
    Returns     : Lead conversion result
    **********************************************************************/
    public Database.LeadConvertResult getConvertLeadResultWithResultId(String leadId , String ownerId,String resultId,String AccObjId, FullQuoteWrapper fullQWrapper){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteMainService :getConvertLeadResult'+leadId + ownerId);
        Database.LeadConvertResult leadConverResult=null;
        try{
            if(leadId!=null && ownerId!=null){
                leadConverResult=FullQuoteDAO.convertLeadWithResultId(leadId, ownerId,resultId,AccObjId, fullQWrapper);
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteMainController_AC getConvertLeadResult:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteMainService : getConvertLeadResult()'+leadConverResult);
        
        return leadConverResult;
    }
    public void getOppStageUpdate(String oppId){
    	FullQuoteDAO.getOppStageUpdate(oppId);
    }
    
    
    
    /*********************************************************************
    Purpose     : To insert Full quote record
    Parameters  :MMI_Full_Quotes__c objct
                 
    Returns     : Opportunity id
    **********************************************************************/
    public String insertFullQuoteRecord(MMI_Full_Quotes__c insertQuote,Date POExpires,Date startDate , Date expDate ,Date scheduledDelivery,Date loadedMoveIn,String opportunityID, String accountId, HomeBaseBeans.CreateFullQuoteResponse createQuoteResponse,FullQuoteWrapper fullQWrapper,string selectedTaxRecInBillingid,string selectedTaxRecInShippingid,FullQuoteWrapper.DescarteInnerClass selectedShipAddr , String poductId,String cloneIsTrue){
    	
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteMainService :insertFullQuoteRecord');
        String oppID=null;
        system.debug('---cloneIsTrue----'+cloneIsTrue);
        system.debug('---opportunityID----'+opportunityID);
        Account accRec = null;
        try{
            if(insertQuote!=null ){
            	system.debug('---opportunityID----'+opportunityID);
            	accRec = new Account(); 
            	if(accountId != null && cloneIsTrue != 'true'){
            		Opportunity opp = null;
            		system.debug('---accountId----'+accountId);
            		opp = new Opportunity();
            		accRec = [Select Id,Name, ShippingCity, ShippingCountry, ShippingPostalCode, ShippingState, ShippingStreet, BillingCity, BillingCountry, BillingPostalCode, BillingState, BillingStreet,Branch__c,Servicing_Branch_Id__c from Account where Id =: accountId limit 1];
            		opp.AccountId = accRec.id;
            		opp.Branch__c = accRec.Branch__c;
            		opp.Servicing_Branch__c = accRec.Servicing_Branch_Id__c;
            		opp.Name = accRec.Name;
            		opp.Delivery_Street__c = accRec.ShippingStreet;
            		opp.Delivery_City__c = accRec.ShippingCity;
            		opp.Delivery_Country__c = accRec.ShippingCountry;
            		opp.Delivery_State_Province__c = accRec.ShippingState;
            		opp.Delivery_Zip_Postal_Code__c = accRec.ShippingPostalCode;
            		opp.StageName = 'Not Quoted';
            		opp.CloseDate = system.today();
                
            		insert opp;
            		insertQuote.Opportunity__c = opp.id;
            		insertQuote.Account__c = accountId;
	           	}else{
	           		system.debug('---opportunityID----'+opportunityID);
	           		if(opportunityID.startsWith('a0z')){
	           			MMI_Quotes__c qqObj = [select Id, Opportunity__c from MMI_Quotes__c where Id = :opportunityID];
	           			if(qqObj != null){
	           				opportunityID = qqObj.Opportunity__c;
	           			}
	           		}
	           		Opportunity opp = [Select Id, AccountId From Opportunity where id =:opportunityID];
	           		system.debug('---opp----'+opp.AccountId);
    	       		insertQuote.Opportunity__c=opportunityID;
    	       		insertQuote.Account__c = opp.AccountId;
    	       		system.debug('---opp----'+opp.AccountId);
        	   	}
                    if(fullQWrapper.selectedFullQUote == 'rental'){
                    	fullQWrapper.selectedFullQUote = 'Rental';
                    }
                    insertQuote.Name = fullQWrapper.selectedFullQUote;
                    //insertQuote.Account__c = accountId;
        			insertQuote.Quote_Id__c = createQuoteResponse.documentId;
        			if(fullQWrapper.unitPriceInvoice != null){
        				insertQuote.Unit_Price__c = double.valueOf(fullQWrapper.unitPriceInvoice);	
        			}
        			insertQuote.product__c = poductId; 
        			insertQuote.Mobilization__c = createQuoteResponse.mobilization;
        			insertQuote.Transaction_Type__c = fullQWrapper.TransactionType;
        			insertQuote.Write_Up_Rep_Id__c = fullQWrapper.WriteUpRep;
        			insertQuote.Write_Up_Rep_Name__c = fullQWrapper.WriteUpRepName;
        			insertQuote.Assisting_Rep_Id__c = fullQWrapper.AssistingRep;
        			insertQuote.Assisting_Rep_Name__c = fullQWrapper.AssistingRepName;
        			insertQuote.Account_Id__c = fullQWrapper.AccountId;
        			insertQuote.Account_Name__c = fullQWrapper.AccountName;        			
        			insertQuote.Address_Id__c = fullQWrapper.ID;
        			insertQuote.Billing_Address__c = fullQWrapper.Address;
        			insertQuote.Tax_Exempt__c = fullQWrapper.TaxExempt;
        			insertQuote.No_Reservation__c = fullQWrapper.noReservation;
        			insertQuote.Invoiced_Balance__c = fullQWrapper.InvoicedBalance; 
        			insertQuote.YTD_Sales__c = fullQWrapper.YTDSales;
        			insertQuote.Last_Invoice__c = fullQWrapper.LastInvoice;
        			if(fullQWrapper.QouteStatus != null){
        				insertQuote.Status__c = fullQWrapper.QouteStatus;	
        			}
        			insertQuote.Credit_Status__c = fullQWrapper.Status;
        			insertQuote.Billing_City__c = fullQWrapper.City;
        			insertQuote.Billing_County__c = fullQWrapper.County;
        			insertQuote.Billing_State__c = fullQWrapper.State;
        			insertQuote.Billing_Country__c = fullQWrapper.Country;
        			insertQuote.Billing_Zip_Code__c = fullQWrapper.ZipCode;
        			insertQuote.Billing_Contact_Id__c = fullQWrapper.BillingContactID;
        			insertQuote.Billing_Contact_Name__c = fullQWrapper.Name;
        			insertQuote.Billing_Contact_Tel__c = fullQWrapper.telePhone;
        			insertQuote.Billing_Contact_Fax__c = fullQWrapper.Fax;
        			insertQuote.Billing_Contact_Email__c = fullQWrapper.Email;
        			insertQuote.PO_Contact__c = fullQWrapper.POContact;
        			if(POExpires!=null){
        			   insertQuote.PO_Expires__c = POExpires;
        			}
        			insertQuote.Credit_Approval__c = fullQWrapper.CreditApproval;
        			insertQuote.Tax_Exempt_Authorization__c = fullQWrapper.TaxExemptAuthorization;
        			insertQuote.Quote_Total__c = fullQWrapper.QuoteTotal; 
        			insertQuote.Fulfilling_Branch_Id__c = fullQWrapper.fulFillingBranchInBilling;  
        			insertQuote.Job_or_Location__c = fullQWrapper.JoborLocation;    
        			insertQuote.COD_Instructions__c = fullQWrapper.CODInstructions;
        			
        			// Shipping screen
        			
        			insertQuote.Start_Date__c = startDate;
        			insertQuote.Quote_expires__c = expDate;
        			insertQuote.Rental_Length__c = fullQWrapper.rentalLength;
        			insertQuote.Shipping_Id__c = fullQWrapper.shippingId;
        			insertQuote.Shipping_Address__c = fullQWrapper.AddressInShippingDates;   			
        			insertQuote.Shipping_City__c = fullQWrapper.cityInShippingDates;
        			insertQuote.Shipping_County__c = fullQWrapper.countyInShippingDates;
        			insertQuote.Shipping_State__c = fullQWrapper.stateInShippingDates;
        			insertQuote.Shipping_Country__c = fullQWrapper.countryInShippingDates;
        			insertQuote.Shipping_Zip_Code__c = fullQWrapper.ZipCodeInShipping; 
        			insertQuote.Shipping_Fulfilling_Branch_Id__c = fullQWrapper.fulFillingBranchInShippingDates;
        			insertQuote.Shipping_Fulfilling_Branch_Name__c = fullQWrapper.fulFillingBranchNameInShippingDates;
        			insertQuote.Shipping_Cross_Street1__c = fullQWrapper.crossStreetInShippingDates;
        			insertQuote.Shipping_Cross_Street2__c = fullQWrapper.crossStreet2InShippingDates;
        			insertQuote.Delivery_Contact_Id__c = fullQWrapper.deliveryContactId;
        			insertQuote.Delivery_Contact_Name__c = fullQWrapper.NameInShippingDates1;
        			insertQuote.Delivery_Contact_Tel__c = fullQWrapper.telInShippingDates;
        			insertQuote.Delivery_Contact_Fax__c = fullQWrapper.faxInShippingDates;
        			insertQuote.Delivery_Contact_Email__c = fullQWrapper.emailInShippingDates;
        			insertQuote.Scheduled_Delivery__c = scheduledDelivery;
        			insertQuote.Loaded_Move_In__c = loadedMoveIn;
        			insertQuote.Delivery_Slot__c = fullQWrapper.deliverySlot;
        			insertQuote.Delivery_Zone__c = fullQWrapper.deliveryZoneInShipping;
        			if(!(fullQWrapper.distFromBranch == '' || fullQWrapper.distFromBranch == null))
        			{	
        				insertQuote.Distance_from_Branch__c = Decimal.valueOf(fullQWrapper.distFromBranch).setScale(2);
        			}
        			
        			// Invoicing screen
        			if(fullQWrapper.RentalCharge != null){
        				insertQuote.Rental_Charge__c =Double.valueOf(fullQWrapper.RentalCharge);	
        			}
        			
        			//insertQuote.Fuel_Surcharge__c = fullQWrapper.fuelSurchargeInShipping;
        			if(fullQWrapper.DeliveryInInvoicing != null && fullQWrapper.DeliveryInInvoicing != ''){
        				insertQuote.Delivery__c = Decimal.valueOf(fullQWrapper.DeliveryInInvoicing);
        			}
        			if(fullQWrapper.LLWTotal != null && fullQWrapper.LLWTotal != ''){
        				insertQuote.LLW__c = Decimal.valueOf(fullQWrapper.LLWTotal);
        			}
        			if(fullQWrapper.pickupCharge != null && fullQWrapper.pickupCharge != ''){
        				insertQuote.Pickup__c = Decimal.valueof(fullQWrapper.pickupCharge);
        			}
        			if(fullQWrapper.otherInInvoicing != null && fullQWrapper.otherInInvoicing != ''){
        				insertQuote.Other__c = Decimal.valueof(fullQWrapper.otherInInvoicing);
        			}
        			if(fullQWrapper.Accessories != null && fullQWrapper.Accessories != ''){
        				insertQuote.Accessories__c = Decimal.valueof(fullQWrapper.Accessories);
        			}
        			if(fullQWrapper.CODAmount != null && fullQWrapper.CODAmount != ''){
        				insertQuote.COD_Amount__c = Decimal.valueof(fullQWrapper.CODAmount);
        			}
        			if(fullQWrapper.TotalCODAmount != null && fullQWrapper.TotalCODAmount != ''){
        				insertQuote.Total_COD_Amount__c = Decimal.valueof(fullQWrapper.TotalCODAmount);
        			}
        			if(fullQWrapper.TaxTotal != null && fullQWrapper.TaxTotal != ''){
        				insertQuote.Tax__c = Decimal.valueof(fullQWrapper.TaxTotal);
        			}
        			if(fullQWrapper.PPETotal != null){
        				insertQuote.PPE_Total__c = Double.valueOf(fullQWrapper.PPETotal);	
        			}
        			insertQuote.Terms__c = fullQWrapper.Terms;
        			insertQuote.Terms_Code__c = fullQWrapper.TermsCode;
        			insertQuote.Longitude__c =  selectedShipAddr.longitude;
        			insertQuote.Latitude__c =  selectedShipAddr.latitude;
        			insertQuote.Tax_id__c = selectedTaxRecInBillingid;
        			insertQuote.Shipping_Tax_id__c = selectedTaxRecInShippingid;
					insertQuote.Item_Image_Url__c = fullQWrapper.ImageUrlForPDF;
					insertQuote.Special_Instruction__c = fullQWrapper.SpecialInstructions;  // TFS 3505
					//-----FOR FQ FROM JP--------------------------------------------
					if(fullQWrapper.jobProfileId != null && fullQWrapper.jobProfileId != ''){
						insertQuote.Job_Profile__c = fullQWrapper.jobProfileId;
					}
					//-----FOR FQ FROM JP--------------------------------------------
                   oppID=FullQuoteDAO.insertFullQuote(insertQuote);
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteMainService insertFullQuoteRecord:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteMainService : insertFullQuoteRecord()'+oppID);
        
        return oppID+'_'+insertQuote.Id;
    }
    
    /*********************************************************************
    Purpose     : To insert Full quote record
    Parameters  :MMI_Full_Quotes__c objct
                 
    Returns     : Opportunity id
    **********************************************************************/
    public Boolean updateFullQuoteRecord(MMI_Full_Quotes__c updateQuote,String mobilization ,String documentId,Date POExpires,Date startDate,Date expDate ,Date scheduledDelivery,Date loadedMoveIn,String opportunityID,FullQuoteWrapper fullQWrapper,string selectedTaxRecInBillingid,string selectedTaxRecInShippingid,FullQuoteWrapper.DescarteInnerClass selectedShipAddr , String productName){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteMainService :insertFullQuoteRecord');
        String oppID=null;
        Boolean isSuccess=false;
        try{
            if(updateQuote!=null ){
                	if(fullQWrapper.selectedFullQUote == 'rental'){
                    	fullQWrapper.selectedFullQUote = 'Rental';
                    }
                    updateQuote.Name = fullQWrapper.selectedFullQUote;
        			updateQuote.Quote_Id__c =documentId;
        		
        			updateQuote.Mobilization__c = mobilization;
        			if(fullQWrapper.unitPriceInvoice != null){
        				updateQuote.Unit_Price__c = double.valueOf(fullQWrapper.unitPriceInvoice);	
        			}
        			updateQuote.product__c= productName;
        			updateQuote.Transaction_Type__c = fullQWrapper.TransactionType;
        			updateQuote.Write_Up_Rep_Id__c = fullQWrapper.WriteUpRep;
        			updateQuote.Write_Up_Rep_Name__c = fullQWrapper.WriteUpRepName;
        			updateQuote.Assisting_Rep_Id__c = fullQWrapper.AssistingRep;
        			updateQuote.Assisting_Rep_Name__c = fullQWrapper.AssistingRepName;
        			updateQuote.Account_Id__c = fullQWrapper.AccountId;
        			updateQuote.Account_Name__c = fullQWrapper.AccountName;        			
        			updateQuote.Address_Id__c = fullQWrapper.ID;
        			updateQuote.Billing_Address__c = fullQWrapper.Address;
        			updateQuote.Tax_Exempt__c = fullQWrapper.TaxExempt;
        			updateQuote.Invoiced_Balance__c = fullQWrapper.InvoicedBalance;
        			updateQuote.YTD_Sales__c = fullQWrapper.YTDSales;
        			updateQuote.Last_Invoice__c = fullQWrapper.LastInvoice;
        			updateQuote.Status__c = fullQWrapper.QouteStatus;
        			
        			updateQuote.Credit_Status__c = fullQWrapper.Status;
        			updateQuote.No_Reservation__c = fullQWrapper.noReservation;
        			
        			
        			updateQuote.Billing_City__c = fullQWrapper.City;
        			updateQuote.Billing_County__c = fullQWrapper.County;
        			updateQuote.Billing_State__c = fullQWrapper.State;
        			updateQuote.Billing_Country__c = fullQWrapper.Country;
        			updateQuote.Billing_Zip_Code__c = fullQWrapper.ZipCode;
        			updateQuote.Billing_Contact_Id__c = fullQWrapper.BillingContactID;
        			updateQuote.Billing_Contact_Name__c = fullQWrapper.Name;
        			updateQuote.Billing_Contact_Tel__c = fullQWrapper.telePhone;
        			updateQuote.Billing_Contact_Fax__c = fullQWrapper.Fax;
        			updateQuote.Billing_Contact_Email__c = fullQWrapper.Email;
        			updateQuote.PO_Contact__c = fullQWrapper.POContact;
        			if(POExpires!=null){
        				updateQuote.PO_Expires__c = POExpires;
        			}
        			
        			updateQuote.Credit_Approval__c = fullQWrapper.CreditApproval;
        			updateQuote.Tax_Exempt_Authorization__c = fullQWrapper.TaxExemptAuthorization;
        			updateQuote.Quote_Total__c = fullQWrapper.QuoteTotal; 
        			updateQuote.Fulfilling_Branch_Id__c = fullQWrapper.fulFillingBranchInBilling;  
        			updateQuote.Job_or_Location__c = fullQWrapper.JoborLocation;    
        			updateQuote.COD_Instructions__c = fullQWrapper.CODInstructions;
        			
        			// Shipping screen
        			
        			updateQuote.Start_Date__c = startDate;
        			updateQuote.Quote_expires__c = expDate;
        			updateQuote.Rental_Length__c = fullQWrapper.rentalLength;
        			updateQuote.Shipping_Id__c = fullQWrapper.shippingId;
        			updateQuote.Shipping_Address__c = fullQWrapper.AddressInShippingDates;   			
        			updateQuote.Shipping_City__c = fullQWrapper.cityInShippingDates;
        			updateQuote.Shipping_County__c = fullQWrapper.countyInShippingDates;
        			updateQuote.Shipping_State__c = fullQWrapper.stateInShippingDates;
        			updateQuote.Shipping_Country__c = fullQWrapper.countryInShippingDates;
        			updateQuote.Shipping_Zip_Code__c = fullQWrapper.ZipCodeInShipping; 
        			updateQuote.Shipping_Fulfilling_Branch_Id__c = fullQWrapper.fulFillingBranchInShippingDates;
        			updateQuote.Shipping_Fulfilling_Branch_Name__c = fullQWrapper.fulFillingBranchNameInShippingDates;
        			updateQuote.Shipping_Cross_Street1__c = fullQWrapper.crossStreetInShippingDates;
        			updateQuote.Shipping_Cross_Street2__c = fullQWrapper.crossStreet2InShippingDates;
        			updateQuote.Delivery_Contact_Id__c = fullQWrapper.deliveryContactId;
        			updateQuote.Delivery_Contact_Name__c = fullQWrapper.NameInShippingDates1;
        			updateQuote.Delivery_Contact_Tel__c = fullQWrapper.telInShippingDates;
        			updateQuote.Delivery_Contact_Fax__c = fullQWrapper.faxInShippingDates;
        			updateQuote.Delivery_Contact_Email__c = fullQWrapper.emailInShippingDates;
        			updateQuote.Scheduled_Delivery__c = scheduledDelivery;
        			updateQuote.Loaded_Move_In__c = loadedMoveIn;
        			updateQuote.Delivery_Slot__c = fullQWrapper.deliverySlot;
        			updateQuote.Delivery_Zone__c = fullQWrapper.deliveryZoneInShipping;
        			if(!(fullQWrapper.distFromBranch == '' || fullQWrapper.distFromBranch == null))
        			{	
        				updateQuote.Distance_from_Branch__c = Decimal.valueOf(fullQWrapper.distFromBranch).setScale(2);
        			}
        			
        			// Invoicing screen
        			
        			if(fullQWrapper.RentalCharge != null){
        				updateQuote.Rental_Charge__c =Double.valueOf(fullQWrapper.RentalCharge);	
        			}
        			//updateQuote.Fuel_Surcharge__c = fullQWrapper.fuelSurchargeInShipping;
        			if(fullQWrapper.DeliveryInInvoicing != '' && fullQWrapper.DeliveryInInvoicing != null){
        				updateQuote.Delivery__c = Decimal.valueOf(fullQWrapper.DeliveryInInvoicing);
        			}
        			if(fullQWrapper.LLWTotal != '' && fullQWrapper.LLWTotal != null){
        				updateQuote.LLW__c = Decimal.valueOf(fullQWrapper.LLWTotal);
        			}
        			if(fullQWrapper.pickupCharge != '' && fullQWrapper.pickupCharge != null){
        				updateQuote.Pickup__c = Decimal.valueOf(fullQWrapper.pickupCharge);
        			}
        			if(fullQWrapper.otherInInvoicing != '' && fullQWrapper.otherInInvoicing != null){
        				updateQuote.Other__c = Decimal.valueOf(fullQWrapper.otherInInvoicing);
        			}
        			if(fullQWrapper.Accessories != '' && fullQWrapper.Accessories != null){
        				updateQuote.Accessories__c = Decimal.valueof(fullQWrapper.Accessories);
        			}
        			if(fullQWrapper.CODAmount != '' && fullQWrapper.CODAmount != null){
        				updateQuote.COD_Amount__c = Decimal.valueOf(fullQWrapper.CODAmount);
        			}
        			if(fullQWrapper.TotalCODAmount != '' && fullQWrapper.TotalCODAmount != null){
        				updateQuote.Total_COD_Amount__c = Decimal.valueOf(fullQWrapper.TotalCODAmount);
        			}
        			if(fullQWrapper.TaxTotal != '' && fullQWrapper.TaxTotal != null){
        				updateQuote.Tax__c = Decimal.valueOf(fullQWrapper.TaxTotal);
        			}
        			
        			if(fullQWrapper.PPETotal != null){
        				updateQuote.PPE_Total__c = Double.valueOf(fullQWrapper.PPETotal);	
        			}
        			
        			updateQuote.Special_Instruction__c = fullQWrapper.SpecialInstructions;  // TFS 3505 
        			updateQuote.Terms__c = fullQWrapper.Terms;
        			updateQuote.Terms_Code__c = fullQWrapper.TermsCode;
        			updateQuote.Longitude__c =  selectedShipAddr.longitude;
        			updateQuote.Latitude__c =  selectedShipAddr.latitude; 
        			updateQuote.Tax_id__c = selectedTaxRecInBillingid;
        			updateQuote.Shipping_Tax_id__c = selectedTaxRecInShippingid;
					updateQuote.Item_Image_Url__c = fullQWrapper.ImageUrlForPDF;
                   oppID=FullQuoteDAO.updateFullQuote(updateQuote);
                   if(oppID!=null){
                   	isSuccess=true;
                   }
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteMainService insertFullQuoteRecord:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteMainService : insertFullQuoteRecord()'+isSuccess);
        
        return isSuccess;
    }
     
     /*********************************************************************
    Purpose     : To get Full Quote record
    Parameters  : Full Quote Doc Id 
    Returns     : MMI_Full_Quotes__c records
    **********************************************************************/
    public MMI_Full_Quotes__c getFullQuote(String docID){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteMainService :getFullQuote');
        MMI_Full_Quotes__c fullQRec=null;
        try{
            if(docID!=null){
                 fullQRec=FullQuoteDAO.getFullQuoteRecord(docID);
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteMainService getFullQuote:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteMainService : getFullQuote()'+fullQRec);
        
        return fullQRec;
    }
    
    
    /*********************************************************************
    Purpose     : To get Lead info
    Parameters  : lead id 
    Returns     :list of  Lead object
    **********************************************************************/
    public Boolean getAccessoryInfo(String accessoryId){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteMainService :getAccessoryInfo');
       List<accessories__c> accessoryRec=null;
       Boolean isAccessory=false;
        try{
            if(accessoryId!=null){
                accessoryRec=FullQuoteDAO.getAccessory(accessoryId);
                if(accessoryRec.size() > 0){
                	isAccessory=true;
                }
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteMainService getAccessoryInfo:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteMainService : getAccessoryInfo()'+accessoryRec+isAccessory);
        
        return isAccessory;
    }
    
    
         /*********************************************************************
    Purpose     : To get Modification Option records
    Parameters  : Item code id 
    Returns     : List of modification option record
    **********************************************************************/
    public  List<Modification_Option_Transactional__c> getModificationOption(string quoteId){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteMainService :getModificationOption');
        List<Modification_Option_Transactional__c> modifOptionRec=null;
        try{
            if(quoteId!=null){
            	
            	modifOptionRec=FullQuoteDAO.getModificationOption(quoteId);
               }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteMainService getModificationOption:'+e.getMessage());
        }
         system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteMainService : getModificationOption()'+modifOptionRec);
        
        return modifOptionRec;
    }
    
  /********************************************************************* 
    Purpose     : To insert FullQuote record for Approval Process
    Parameters  : MMI_Full_Quotes__c object type
    Returns     : id
    **********************************************************************/ 
    public String insertFullQuoteApprovalProcess(Full_Quote_Transactional__c insertQuote,List<HomeBaseBeans.quoteLine> summaryLineList,
                                          List<HomeBaseBeans.AnalysisSetHeaders> analysisSetHeaderResponseList,
                                          List<HomeBaseBeans.AnalysisSetHeaders> analysisSetHeaderResponseShippingList,
                                          List<HomeBaseBeans.extras> ProductExtrasList,
                                          FullQuoteWrapper.DescarteInnerClass selectedVAddressInShipping,
                                          FullQuoteWrapper.DescarteInnerClass selectedVAddressInBilling,Date POExpires,Date startDate , Date expDate ,Date scheduledDelivery,Date loadedMoveIn,FullQuoteWrapper fullQWrapper,string selectedTaxRecInBillingid,string selectedTaxRecInShippingid,Boolean isMoboSeco, Boolean isMainProductAdded,String DocumentId,String mobilization,String modifiedTimeStamp){ 
        
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteMainService :insertFullQuoteApprovalProcess'+fullQWrapper.TaxExempt);
        String quoteID=null; 
        try{
            if(insertQuote!=null){
            insertQuote.Image_previewQuote__c = fullQWrapper.imageNameForPreivewQuote;
            	insertQuote.Name='Full Quote Transactional';
            insertQuote.accessories__c=fullQWrapper.Accessories;
            if(fullQWrapper.rentalLengthInProduct != null && fullQWrapper.rentalLengthInProduct != ''){
            	insertQuote.rentalLengthInProduct__c = Decimal.valueof(fullQWrapper.rentalLengthInProduct);
            }
            insertQuote.accountId__c=fullQWrapper.AccountId;
            insertQuote.account_Name__c = fullQWrapper.AccountName;
            insertQuote.isAddressValidated__c = fullQWrapper.enableProductadd;
            insertQuote.isMainProductAdded__c = isMainProductAdded;
           	insertQuote.plannedCollectionDate__c=String.valueof(loadedMoveIn);		 	
	 		insertQuote.poExpires__c=String.valueof(POExpires);
	 		insertQuote.quoteExpires__c	=String.valueof(expDate);
	 		insertQuote.startDate__c=String.valueof(startDate);
	 		insertQuote.shippingDate__c	=String.valueof(scheduledDelivery);	 	
	 		//insertQuote.alreadyRegistered__c=fullQWrapper.		 	
	 		insertQuote.billingAddress_address1__c	=fullQWrapper.Address;	 	
	 		insertQuote.billingAddress_address2__c =selectedVAddressInBilling.address2;	 	
	 		insertQuote.billingAddress_address3__c	=fullQWrapper.City;
	 		insertQuote.billingAddress_address4__c	=selectedVAddressInBilling.address4;	 	
	 		//insertQuote.billingAddress_cityZone__c		 	
	 		insertQuote.billingAddress_countryId__c	=fullQWrapper.Country ;	 		 	
	 		//insertQuote.billingAddress_crossStreet1__c		 	
	 		//insertQuote.billingAddress_crossStreet2__c		 	
	 		insertQuote.billingAddress_deliveryZone__c=selectedVAddressInBilling.deliveryZone;		 	
	 		//insertQuote.billingAddress_distanceBranch__c=
	 		insertQuote.billingAddress_distanceFromBranch__c=selectedVAddressInBilling.distanceFromBranch;		 	
	 		insertQuote.billingAddress_fulfillingBranchId__c=selectedVAddressInBilling.fulfillingBranch;		 	
	 		insertQuote.billingAddress_fulfillingBranchName__c=selectedVAddressInBilling.fulfillingBranchName;		 	
	 		insertQuote.billingAddress_latitude__c=selectedVAddressInBilling.latitude;		 	
	 		insertQuote.billingAddress_longitude__c	=selectedVAddressInBilling.longitude;	 	
	 		insertQuote.billingAddress_name__c=fullQWrapper.Name;		 	
	 		insertQuote.billingAddress_oldPostalCode__c=selectedVAddressInBilling.oldPostalCode;		 	
	 		insertQuote.billingAddress_state__c	=fullQWrapper.State;	 	
	 		insertQuote.billingAddress_taxId__c	=selectedTaxRecInBillingid;	 	
	 		insertQuote.billingAddress_zipCode__c=fullQWrapper.ZipCode;		 	
	 		insertQuote.billingAddress_zoneWarning__c=selectedVAddressInBilling.zoneWarning;		 	
	 		insertQuote.billingAddressId__c	=fullQWrapper.ID;	 	
	 		insertQuote.BillingContactDetails_email__c=	fullQWrapper.Email;	 	
	 		insertQuote.BillingContactDetails_fax__c=fullQWrapper.Fax;	 	
	 		insertQuote.BillingContactDetails_id__c	=fullQWrapper.BillingContactID;	 	
	 		//insertQuote.BillingContactDetails_mobile__c		 	
	 		insertQuote.BillingContactDetails_name__c=fullQWrapper.Name;		 	
	 		insertQuote.BillingContactDetails_tel__c=fullQWrapper.telePhone;
	 				 	
	 		insertQuote.branchId__c	=fullQWrapper.userBranchId;	 	
	 		insertQuote.certificateOfInsurance__c=fullQWrapper.CertofInsurance;		 	
	 		insertQuote.codAmount__c=fullQWrapper.CODAmount;		 	
	 		insertQuote.companyId__c='1';		 	
	 		insertQuote.creditApproval__c=fullQWrapper.CreditApproval;		 	
	 		insertQuote.creditStatus__c	=fullQWrapper.Status;	 	
	 		//insertQuote.customerText1__c		 	
	 		insertQuote.delivery__c=fullQWrapper.DeliveryInInvoicing;		 	
	 		if(DocumentId!=null && DocumentId!=''){
	 			insertQuote.documentId__c=DocumentId;	
	 		} 	
	 			 	
	 		//insertQuote.emailPortalLink__c		 	
	 		insertQuote.hireTerms__c=fullQWrapper.Terms;		 	
	 		//insertQuote.homeOwner__c		 	
	 		insertQuote.instructionText__c=fullQWrapper.CODInstructions;		 	
	 		insertQuote.invoicedBalance__c=fullQWrapper.InvoicedBalance;		 	
	 		insertQuote.lastInvoiceDate__c=fullQWrapper.LastInvoice;		 	
	 		insertQuote.llw__c=fullQWrapper.LLWTotal;		 	
	 		//insertQuote.messageDetails__c		 	
	 		insertQuote.mobilization__c	=mobilization; 	
	 		insertQuote.modifiedTimestamp__c= modifiedTimeStamp;		 	
	 		insertQuote.narrative1__c=fullQWrapper.JoborLocation;		 	
	 		//insertQuote.narrative2__c		 	
	 		//insertQuote.nscRepCommission__c		 	
	 		insertQuote.other__c=fullQWrapper.otherInInvoicing;		 	
	 		insertQuote.pickUp__c=fullQWrapper.pickupCharge;	
	 			 	
	 			 	
	 		//insertQuote.poRequired__c		 	
	 		//insertQuote.portalContact__c		 	
	 		//insertQuote.portalContactEmail__c		 	
	 				 	
	 		insertQuote.quoteTotal__c=fullQWrapper.QuoteTotal;		 	
	 		insertQuote.reference__c=fullQWrapper.POContact;		 	
	 		insertQuote.rentalCharge__c	=fullQWrapper.RentalCharge;	 	
	 		insertQuote.rentalLength__c	=fullQWrapper.rentalLength;	 	
	 		//
	 	//	insertQuote.reservationId__c		 	
	 		insertQuote.salesRep1__c=fullQWrapper.WriteUpRep;		 	
	 		insertQuote.salesRep1Name__c=fullQWrapper.WriteUpRepName;		 	
	 		insertQuote.salesRep2__c=fullQWrapper.AssistingRep;		 	
	 		insertQuote.salesRep2Name__c=fullQWrapper.AssistingRepName;		 	
	 		insertQuote.shippingAddress_address1__c	=fullQWrapper.AddressInShippingDates;	 	
	 		insertQuote.shippingAddress_address2__c	=selectedVAddressInShipping.address2;	 	
	 		insertQuote.shippingAddress_address3__c	=fullQWrapper.cityInShippingDates;	 	
	 		insertQuote.shippingAddress_address4__c	=selectedVAddressInShipping.address4; 	
	 		//insertQuote.shippingAddress_cityZone__c		 	
	 		insertQuote.shippingAddress_countryId__c=fullQWrapper.countryInShippingDates;		 	
	 		insertQuote.shippingAddress_crossStreet1__c	=fullQWrapper.crossStreetInShippingDates;	 	
	 		insertQuote.shippingAddress_crossStreet2__c	=fullQWrapper.crossStreet2InShippingDates;	 	
	 		insertQuote.shippingAddress_deliveryZone__c	=fullQWrapper.deliveryZoneInShipping;	 	
	 		//insertQuote.shippingAddress_distanceBranch__c		 	
	 		insertQuote.shippingAddress_distanceFromBranch__c=fullQWrapper.distFromBranch;		 	
	 		insertQuote.shippingAddress_fulfillingBranchId__c=selectedVAddressInShipping.fulfillingBranch;		 	
	 		insertQuote.shippingAddress_fulfillingBranchName__c=selectedVAddressInShipping.fulfillingBranchName;		 	
	 		insertQuote.shippingAddress_latitude__c	=selectedVAddressInShipping.latitude;	 	
	 		insertQuote.shippingAddress_longitude__c=selectedVAddressInShipping.longitude;		 	
	 		insertQuote.shippingAddress_name__c	=fullQWrapper.NameInShippingDates;	 	
	 		insertQuote.shippingAddress_oldPostalCode__c=selectedVAddressInShipping.oldPostalCode;		 	
	 		insertQuote.shippingAddress_state__c= fullQWrapper.stateInShippingDates;		 	
	 		insertQuote.shippingAddress_taxId__c= fullQWrapper.SelectedShipingTaxId;		 	
	 		insertQuote.shippingAddress_zipCode__c=fullQWrapper.ZipCodeInShipping;		 	
	 		insertQuote.shippingAddress_zoneWarning__c=selectedVAddressInShipping.zoneWarning;		 	
	 		insertQuote.shippingAddressId__c=fullQWrapper.shippingId;		 	
	 		insertQuote.ShippingContactDetails_email__c	=fullQWrapper.emailInShippingDates;	 	
	 		insertQuote.ShippingContactDetails_fax__c=fullQWrapper.faxInShippingDates;		 	
	 		insertQuote.ShippingContactDetails_id__c=fullQWrapper.deliveryContactId;		 	
	 		//insertQuote.ShippingContactDetails_mobile__c		 	
	 		insertQuote.ShippingContactDetails_name__c=fullQWrapper.NameInShippingDates1;		 	
	 		insertQuote.ShippingContactDetails_tel__c=	fullQWrapper.telInShippingDates;		 	
	 		 	
	 		insertQuote.shippingInstructions__c=fullQWrapper.deliveryInstructions;		 	
	 				 	
	 		//insertQuote.status__c		 	
	 		if(fullQWrapper.TaxTotal != null && fullQWrapper.TaxTotal != ''){
	 		insertQuote.tax__c=fullQWrapper.TaxTotal;	
	 		}else{
	 			insertQuote.tax__c=fullQWrapper.taxInvoice;
	 		}		 	
	 			
	 		if(fullQWrapper.TaxExempt!=null){
	 		insertQuote.taxExempt__c=fullQWrapper.TaxExempt;		 	
	 		}else{
                             insertQuote.taxExempt__c=false;
                        }	
	 				 	
	 		insertQuote.taxExemptAuthorisation__c=fullQWrapper.TaxExemptAuthorization;		 	
	 		insertQuote.termsCode__c=fullQWrapper.TermsCode;		 	
	 		insertQuote.totalCodAmount__c=fullQWrapper.TotalCODAmount;		 	
	 		insertQuote.transactionId__c= fullQWrapper.TransactionType;		 	
	 		if(fullQWrapper.selectedFullQUote == 'rental'){
	 			fullQWrapper.selectedFullQUote = 'Rental';
	 		}
	 		insertQuote.type__c= fullQWrapper.selectedFullQUote;
	 				 	
	 		//insertQuote.viewDocumentIn__c		 	
	 		//insertQuote.writeUpRepCommission__c		 	
	 		insertQuote.ytdSales__c=fullQWrapper.YTDSales;			
	 		insertQuote.SourceId__c=fullQWrapper.sourceId;		
            insertQuote.documentId__c=DocumentId;	
            insertQuote.User_sign__c = fullQWrapper.ImageUrlForPDF;
            insertQuote.Modification_Comments__c = 	fullQWrapper.ModificationComments;
            insertQuote.Approver_Comments__c = 	fullQWrapper.ApproverComments;
            insertQuote.Contact__c = fullQWrapper.contactId; 	
            	  //insert full quote
                 quoteID=FullQuoteDAO.insertFullQuoteApprovalProcess(insertQuote);
                 
                 //insert summury line
                 insertSummuryLIne(summaryLineList,quoteID);
                 //insert product  extras
                 insertProductExtras(ProductExtrasList,quoteID);	
                 //insert analysis set
                 insertAnalysisSet(analysisSetHeaderResponseList,quoteID);
                 //insert additional analysis set
                 insertAdditionalAnalysisSet(analysisSetHeaderResponseShippingList,quoteID);
                 
                 
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteMainService insertFullQuoteApprovalProcess:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteMainService : insertFullQuoteApprovalProcess()'+quoteID);
        
        return quoteID;
    }
    
    
    /*********************************************************************
    Purpose     : To insert FullQuote record for Approval Process
    Parameters  : MMI_Full_Quotes__c object type
    Returns     : id
    **********************************************************************/
   /* public static String updateFullQuoteApprovalProcess(Full_Quote_Transactional__c fullQuote){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteDAO :updateFullQuoteApprovalProcess');
        String quoteID=null;
        try{
            if(fullQuote!=null){
                 insert fullQuote;
                 quoteID=fullQuote.Id;
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteDAO updateFullQuoteApprovalProcess:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteDAO : updateFullQuoteApprovalProcess()'+quoteID);
        
        return quoteID;
    }*/
    
     /*********************************************************************
    Purpose     : To insert Modification Option records
    Parameters  : Modification_Option_Transactional__c
    Returns     : boolean 
    **********************************************************************/
    public  boolean insertModificationOption(List<FullQuoteWrapper.stdModification> moTrans,String quoteId,String ApproversEmail){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteMainService :insertModificationOption');
        Boolean recId=false;
        List<Modification_Option_Transactional__c> motOption=null;
        try{
        	motOption=new  List<Modification_Option_Transactional__c>();
        	User current_user=[SELECT Email FROM User WHERE Id= :UserInfo.getUserId()] ;
            if(moTrans!=null && !moTrans.isEmpty()){
            	 integer i=1;
            	 for(FullQuoteWrapper.stdModification stdM : moTrans){
            	 	if(stdM.isSelected){
	            	   Modification_Option_Transactional__c mot=new Modification_Option_Transactional__c();
	            	   mot.IsApproved__c = false;
	            	   mot.Is_Submitted__c = true;
	            	   mot.Is_Rejected__c = false;
	            	   mot.Submit_Or_Reject_Or_Approved_Time__c = system.now();
	            	   mot.Submitter_User__c = userInfo.getUserId();
	            	   mot.IsModificationCompleted__c=false;
	            	   mot.IsSelected__c=stdM.isSelected;
	            	   mot.Quantity__c=Double.valueOf(stdM.Quantity);
	            	   mot.Sale_Price__c=Decimal.valueOf(stdM.price);
	            	   mot.SandForApproval__c=true;
	            	   mot.ModId__c=stdM.modId;
	            	   mot.ModificationOptionDesc__c=stdM.modificationOption;
	            	   mot.Standard_Modification__c=FullQuoteDAO.getStamdardModification(stdM.modId);
	            	   mot.Full_Quote_Transactional__c=quoteId;
	            	   mot.SenderEmail__c=current_user.Email;
	            	   mot.SourceID__c=stdM.sourceID;
	            	   mot.ApproverEmail__c=ApproversEmail;
	            	   mot.Sequence__c=i;
	            	   motOption.add(mot);
	            	   i++;
	            	 }
            	 }
            	 
                 recId=FullQuoteDAO.insertModificationOption(motOption);
                 
             }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteMainService insertModificationOption:'+e.getMessage());
        }
         system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteMainService : insertModificationOption()'+recId);
        
        return recId;
    }
    
      /*********************************************************************
    Purpose     : To insert Modification Option records
    Parameters  : Modification_Option_Transactional__c
    Returns     : boolean 
    **********************************************************************/
    public Boolean updateModificationOption(List<FullQuoteWrapper.stdModification> moTrans,String quoteId,String Action){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteMainService :updateModificationOption'+moTrans+'-----'+quoteId);
         Boolean recId=false;
        try{
            if(moTrans!=null && !moTrans.isEmpty()){
            	 //  to update modification option
            	 List<Modification_Option_Transactional__c> modificationOptionLst=FullQuoteDAO.getModificationOption(quoteId);
            	 system.debug('**************'+modificationOptionLst);
            	 
                for(FullQuoteWrapper.stdModification mOptionwrap:moTrans){
            
            	    for(Modification_Option_Transactional__c mOption:modificationOptionLst){
            	    	 if(mOptionwrap.sequence==Integer.valueOf(mOption.Sequence__c)){
            	 	       if(Action == 'Approved'){
            	 	       	 if(mOptionwrap.isSelected){
            	 	       	 	 mOption.IsApproved__c = true;
            	 	       	     mOption.Is_Submitted__c = false;
            	 	       	     mOption.Is_Rejected__c = false;
            	 	       	     mOption.IsSelected__c = mOptionwrap.isSelected;
            	 	       	 }else{
            	 	       	 	 mOption.IsSelected__c =false;
	            	 	       	 mOption.Quantity__c = 1;
			        			 mOption.Sale_Price__c = 0;
	            	 	       	 mOption.Is_Rejected__c = true;
	            	 	       	 mOption.IsApproved__c = false;
	            	 	       	 mOption.Is_Submitted__c = false;
            	 	       	 }
            	 	       }else if(Action == 'Rejected'){
            	 	       	 mOption.IsSelected__c =false;
            	 	       	 mOption.Quantity__c = 1;
		        			 mOption.Sale_Price__c = 0;
            	 	       	 mOption.Is_Rejected__c = true;
            	 	       	 mOption.IsApproved__c = false;
            	 	       	 mOption.Is_Submitted__c = false;
            	 	       }
            	 	       mOption.Approver_User__c = userInfo.getUserId();
            	 	       mOption.Submit_Or_Reject_Or_Approved_Time__c = system.now();
            	 	       mOption.IsModificationCompleted__c=false;
		            	   //mOption.IsSelected__c=mOptionwrap.isSelected;
		            	   mOption.Quantity__c=Double.valueOf(mOptionwrap.Quantity);
		            	   mOption.Sale_Price__c=Decimal.valueOf(mOptionwrap.price);
		            	   mOption.SandForApproval__c=true;
            	    	 }
	            	 	
            	     }
  
            	 }
                 recId=FullQuoteDAO.updateModificationOption(modificationOptionLst);
             }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteMainService updateModificationOption:'+e.getMessage());
        }
         system.debug(LoggingLevel.DEBUG,'Exiting to  FullQuoteMainService : updateModificationOption()'+recId);
        
        return recId;
    }
    
    
     public  boolean insertSummuryLIne(List<HomeBaseBeans.quoteLine> summaryLineList,String quoteId){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteMainService :insertSummuryLIne');
        Boolean recId=false;
        List<Summary_Line__c> summuryLineItemList=null;
        try{
        	summuryLineItemList=new  List<Summary_Line__c>();
            if(summaryLineList!=null && !summaryLineList.isEmpty()){
            	 
            	 for(HomeBaseBeans.quoteLine summuryLineItem : summaryLineList){
            	 	 
            	 	 if(summuryLineItem.invoiceDiscountApplicable==null){
            	 	 	summuryLineItem.invoiceDiscountApplicable=false;
            	 	 }
            	 	 
            	 	 if(summuryLineItem.lockItemCode==null ){
            	 	 	summuryLineItem.lockItemCode='';
            	 	 }
            	 	  if(summuryLineItem.netBookValue==null){
            	 	 	summuryLineItem.netBookValue=0.0;
            	 	 }
            	 	  if(summuryLineItem.ecode==null ){
            	 	 	summuryLineItem.ecode='';
            	 	 }
            	 	
	            	   Summary_Line__c slItem=new Summary_Line__c();
	            	   slItem.Full_Quote_Transactional__c=quoteId;
	            	   slItem.description__c=summuryLineItem.description;
	            	   slItem.ecode__c=summuryLineItem.ecode;
	            	  // slItem.internetCoupon__c=summuryLineItem.internetCoupon;
	            	   slItem.invoiceDiscountApplicable__c=summuryLineItem.invoiceDiscountApplicable;
	            	   slItem.itemId__c=summuryLineItem.itemId;
	            	   if(summuryLineItem.lineId!=null && summuryLineItem.lineId!=''){
	            	   slItem.lineId__c=summuryLineItem.lineId;
	            	   }
	            	  if(summuryLineItem.itemId=='CG1'|| summuryLineItem.itemId=='CG2'|| summuryLineItem.itemId=='DL1' || summuryLineItem.itemId=='DL2' ){
	            	      slItem.lineValue__c=String.valueOf(decimal.valueOf(summuryLineItem.lineValue));
	            	  }else{
	            	  	 slItem.lineValue__c=summuryLineItem.lineValue;
	            	  }
	            	  slItem.quantity__c=String.valueOf(Integer.valueOf(summuryLineItem.quantity));
	            	  slItem.price__c=String.valueOf(summuryLineItem.price);
	            	  slItem.lockItemCode__c=summuryLineItem.lockItemCode;
	            	  slItem.NetBookValue__c=String.valueOf(summuryLineItem.netBookValue);
	            	  slItem.Sequence__c=double.valueOf(summuryLineItem.lineCount);
	            	//  slItem.lineId__c=summuryLineItem.lineId;
	            	  
	            	   summuryLineItemList.add(slItem);
	            
            	 }
            	 
                 recId=FullQuoteDAO.insertSummuryLine(summuryLineItemList);
                 
             }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteMainService insertSummuryLIne:'+e.getMessage());
        }
         system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteMainService : insertSummuryLIne()'+recId);
        
        return recId;
    }
    
    
      public  boolean insertProductExtras(List<HomeBaseBeans.extras> productExtrasList,String quoteId){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteMainService :insertProductExtras');
        Boolean isRateInserted=false;
        List<Product_Extras__c> productExtraItemList=null;
        List<Rate__c> rateList=null;
        String recId=null;
        try{
        	productExtraItemList=new  List<Product_Extras__c>();
        	rateList=new List<Rate__c>();
            if(productExtrasList!=null && !productExtrasList.isEmpty()){
            	 integer i=1;
            	 for(HomeBaseBeans.extras productextItem : productExtrasList){
            	 	   
	            	   Product_Extras__c peItem=new Product_Extras__c();
	            	   peItem.Sequence__c=i;
	            	   peItem.description__c=productextItem.description;
	            	   peItem.Full_Quote_Transactional__c=quoteId;
	            	   peItem.id__c=productextItem.id;
	            	   peItem.include__c=productextItem.include;
	            	   peItem.mandatory__c=productextItem.mandatory;
	            	   peItem.price__c=productextItem.price;
	            	   peItem.priceEditable__c=productextItem.priceEditable;
	            	   peItem.quantity__c=String.valueOf(Integer.valueOf(productextItem.quantity));
	            	   peItem.quantityEditable__c=productextItem.quantityEditable;
	            	   peItem.quantityRequired__c=productextItem.quantityRequired;
	            	   peItem.total__c=productextItem.total;
	            	   
	            	   
	            	   recId=FullQuoteDAO.insertProductExtra(peItem);
	            	   //insert peItem;
	            	   
	            	   Rate__c r1=new Rate__c();
	            	   r1.description__c=productextItem.rate1.description;
	            	   r1.rate__c=productextItem.rate1.rate;
	            	   r1.editable__c=productextItem.rate1.editable;
	            	   r1.Sequence__c=1;
	            	   r1.Product_Extras__c=recId;
	            	   
	            	   rateList.add(r1);
	            	   
	            	   
	            	   Rate__c r2=new Rate__c();
	            	   r2.description__c=productextItem.rate2.description;
	            	   r2.rate__c=productextItem.rate2.rate;
	            	   r2.editable__c=productextItem.rate2.editable;
	            	   r2.Sequence__c=2;
	            	   r2.Product_Extras__c=recId;
	            	   
	            	   rateList.add(r2);
	            	   
	            	   Rate__c r3=new Rate__c();
	            	   r3.description__c=productextItem.rate3.description;
	            	   r3.rate__c=productextItem.rate3.rate;
	            	   r3.editable__c=productextItem.rate3.editable;
	            	   r3.Sequence__c=3;
	            	   r3.Product_Extras__c=recId;
	            	   
	            	   rateList.add(r3);
	            	   
	            	    Rate__c r4=new Rate__c();
	            	   r4.description__c=productextItem.rate4.description;
	            	   r4.rate__c=productextItem.rate4.rate;
	            	   r4.editable__c=productextItem.rate4.editable;
	            	   r4.Sequence__c=4;
	            	   r4.Product_Extras__c=recId;
	            	   
	            	   rateList.add(r4);
	            	   
	            	    Rate__c r5=new Rate__c();
	            	   r5.description__c=productextItem.rate5.description;
	            	   r5.rate__c=productextItem.rate5.rate;
	            	   r5.editable__c=productextItem.rate5.editable;
	            	   r5.Sequence__c=5;
	            	   r5.Product_Extras__c=recId;
	            	   
	            	   
	            	   rateList.add(r5);
	            	   
	            	    Rate__c r6=new Rate__c();
	            	   r6.description__c=productextItem.rate6.description;
	            	   r6.rate__c=productextItem.rate6.rate;
	            	   r6.editable__c=productextItem.rate6.editable;
	            	   r6.Sequence__c=6;
	            	   r6.Product_Extras__c=recId;
	            	   
	            	   rateList.add(r6);
	            	   
	            	    Rate__c r7=new Rate__c();
	            	   r7.description__c=productextItem.rate7.description;
	            	   r7.rate__c=productextItem.rate7.rate;
	            	   r7.editable__c=productextItem.rate7.editable;
	            	   r7.Sequence__c=7;
	            	   r7.Product_Extras__c=recId;
	            	   
	            	   rateList.add(r7);
	            	   
	            	    Rate__c r8=new Rate__c();
	            	   r8.description__c=productextItem.rate8.description;
	            	   r8.rate__c=productextItem.rate8.rate;
	            	   r8.editable__c=productextItem.rate8.editable;
	            	   r8.Sequence__c=8;
	            	   r8.Product_Extras__c=recId;
	            	   
	            	   
	            	   rateList.add(r8);
	            	   
	            	  // productExtraItemList.add(peItem);
	            	   i++;
	            
            	 }
            	 
                 isRateInserted=FullQuoteDAO.insertRates(rateList);
                 
             }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteMainService insertProductExtras:'+e.getMessage());
        }
         system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteMainService : insertProductExtras()'+recId);
        
        return isRateInserted;
    }
    
    
     public  boolean insertAnalysisSet(List<HomeBaseBeans.AnalysisSetHeaders> analysisSetHeaderResponseList,String quoteId){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteMainService :insertAnalysisSet'+analysisSetHeaderResponseList);
        Boolean recId=false;
        List<AnalysisSet__c> analysisList=null;
        try{
        	analysisList=new  List<AnalysisSet__c>();
            if(analysisSetHeaderResponseList!=null && !analysisSetHeaderResponseList.isEmpty()){
            	 integer i=1;
            	 for(HomeBaseBeans.AnalysisSetHeaders analysisSet : analysisSetHeaderResponseList){
	            	  
	            	  AnalysisSet__c analysis =new AnalysisSet__c();
	            	  analysis.Name='Analysis Set';
	            	  analysis.Header_id__c=analysisSet.id;
	            	  analysis.Header_description__c=analysisSet.description;
	            	  analysis.Selection_id__c=analysisSet.selectedId;
	            	  analysis.Selection_description__c=analysisSet.selectedDescription;
	            	  analysis.Full_Quote_Transactional__c=quoteId;
	            	  analysis.Sequence__c=i;
	            	  
	            	  analysisList.add(analysis);
	            	  i++;
            	 }
            	 
                 recId=FullQuoteDAO.insertAnalysisSet(analysisList);
                 
             }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteMainService insertAnalysisSet:'+e.getMessage());
        }
         system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteMainService : insertAnalysisSet()'+recId);
        
        return recId;
    }
    
    
    
     public  boolean insertAdditionalAnalysisSet(List<HomeBaseBeans.AnalysisSetHeaders> analysisSetHeaderResponseList,String quoteId){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteMainService :insertAnalysisSet'+analysisSetHeaderResponseList);
        Boolean recId=false;
        List<AdditionalAnalysisSet__c> addAnalysisList=null;
        try{
        	addAnalysisList=new  List<AdditionalAnalysisSet__c>();
            if(analysisSetHeaderResponseList!=null && !analysisSetHeaderResponseList.isEmpty()){
            	 integer i=1;
            	 for(HomeBaseBeans.AnalysisSetHeaders analysisSet : analysisSetHeaderResponseList){
	            	  
	            	  AdditionalAnalysisSet__c analysis =new AdditionalAnalysisSet__c();
	            	  analysis.Name='Additional Analysis Set';
	            	  analysis.Header_id__c=analysisSet.id;
	            	  analysis.Header_description__c=analysisSet.description;
	            	  analysis.Selection_id__c=analysisSet.selectedId;
	            	  analysis.Selection_description__c=analysisSet.selectedDescription;
	            	  analysis.Full_Quote_Transactional__c=quoteId;
	            	  analysis.Sequence__c=i;
	            	  
	            	  addAnalysisList.add(analysis);
	            	  i++;
            	 }
            	 
                 recId=FullQuoteDAO.insertAdditionalAnalysisSet(addAnalysisList);
                 
             }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteMainService insertAnalysisSet:'+e.getMessage());
        }
         system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteMainService : insertAnalysisSet()'+recId);
        
        return recId;
    } 
    
    
     public List<Modification_Approver_List__c> getApproverList(String branchId){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteMainService :getApproverList');
        List<Modification_Approver_List__c> recList=null;
        try{
            if(branchId!=null){
            	recList=FullQuoteDAO.getApproverList(branchId);
            	 
            	}
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteMainService getApproverList:'+e.getMessage());
        }
         system.debug(LoggingLevel.DEBUG,'Exiting to  FullQuoteMainService : getApproverList()'+recList);
        
        return recList;
    }
    
    public List<Standard_Modification__c> getStandardModificationList(){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteMainService :getStandardModificationList');
       List<Standard_Modification__c> modifOptionRec=null;
        try{
            
            modifOptionRec = FullQuoteDAO.getStandardModificationList();
           
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteMainService getStandardModificationList:'+e.getMessage());
        }
         system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteMainService : getStandardModificationList()'+modifOptionRec);
        
        return modifOptionRec;
    }
     
    public List<HB_Sales_Inventory__c> getSalesInventories(String branchId){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteMainService :getSalesInventories');
       List<HB_Sales_Inventory__c> salesInventoryRec=null;
        try{
            
            salesInventoryRec = FullQuoteDAO.getSalesInventoryList(branchId);
           
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteMainService getSalesInventories:'+e.getMessage());
        }
         system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteMainService : getSalesInventories()'+salesInventoryRec);
        
        return salesInventoryRec;
    }
     
    
    public List<HB_Sales_Inventory__c> getSalesInventoriesSearch(String branchId,String searchStr){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteMainService :getSalesInventoriesSearch');
       List<HB_Sales_Inventory__c> salesInventoryRec=null;
        try{
            
            salesInventoryRec = FullQuoteDAO.searcSalesInventoryList(branchId, searchStr);
           
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteMainService getSalesInventoriesSearch:'+e.getMessage());
        }
         system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteMainService : getSalesInventoriesSearch()'+salesInventoryRec);
        
        return salesInventoryRec;
    }
    
     public List<HB_Sales_Inventory__c> getSpecificSalesInventories(String productId,String branchId){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteMainService :getSpecificSalesInventories');
       List<HB_Sales_Inventory__c> salesInventoryRec=null;
        try{
             
            salesInventoryRec = FullQuoteDAO.getSpecificSalesInventoryList2(productId,branchId);
           
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteMainService getSpecificSalesInventories:'+e.getMessage());
        }
         system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteMainService : getSpecificSalesInventories()'+salesInventoryRec);
        
        return salesInventoryRec;
    }
    
    public List<accessories__c> searchAccessories(String searchStr){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteMainService :searchAccessories');
       List<accessories__c> accessoryRec=null;
        try{
            
            accessoryRec = FullQuoteDAO.searchAccessories(searchStr);
           
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteMainService searchAccessories:'+e.getMessage());
        }
         system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteMainService : searchAccessories()'+accessoryRec);
        
        return accessoryRec;
    }
    
    public static String getDayOfTheDate(String inputDate){
		Date startDate = date.newInstance(0001, 1, 1);
		Date selectedDate = date.newInstance(Integer.valueOf(inputDate.substring(0,4)), Integer.valueOf(inputDate.substring(5,7)), Integer.valueOf(inputDate.substring(8,10)));
		List<String> listDay = new List<String>{'Sat' , 'Sun' , 'Mon' , 'Tue' , 'Wed' , 'Thu' , 'Fri'}; 
		Integer remainder = Math.mod(startDate.daysBetween(selectedDate) , 7); 
		String dayValue = listDay.get(remainder);
		return dayValue;
	}
	
	public static String getDateInFormat(String inputDate){
		String Year = inputDate.substring(0,4);
		String Month = inputDate.substring(5,7);
		String Day = inputDate.substring(8,10);
		String MonthPart = '';
		if(Integer.valueOf(Month) == 1){
			MonthPart = 'JAN';
		}
		if(Integer.valueOf(Month) == 2){
			MonthPart = 'FEB';
		}
		if(Integer.valueOf(Month) == 3){
			MonthPart = 'MAR';
		}
		if(Integer.valueOf(Month) == 4){
			MonthPart = 'APR';
		}
		if(Integer.valueOf(Month) == 5){
			MonthPart = 'MAY';
		} 
		if(Integer.valueOf(Month) == 6){
			MonthPart = 'JUN';
		}
		if(Integer.valueOf(Month) == 7){
			MonthPart = 'JUL';
		}
		if(Integer.valueOf(Month) == 8){
			MonthPart = 'AUG';
		}
		if(Integer.valueOf(Month) == 9){
			MonthPart = 'SEP';
		}
		if(Integer.valueOf(Month) == 10){
			MonthPart = 'OCT';
		}
		if(Integer.valueOf(Month) == 11){
			MonthPart = 'NOV';
		}
		if(Integer.valueOf(Month) == 12){
			MonthPart = 'DEC';
		}
		String fullDateFormat = getDayOfTheDate(inputDate) + ', '+Day+' '+MonthPart+' '+Year+' 00:01:01 MST';
		return fullDateFormat;
		
	}
	 /*********************************************************************
    Purpose     : To get Branch_Lookup__c info
    Parameters  : Zip code 
    Returns     :list of  Branch_Lookup__c object
    **********************************************************************/
    public Branch_Lookup__c getBranchLookupinfo(String zipCode){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainService :Branch_Lookup__c'+zipCode);
        Branch_Lookup__c BranchLookupList=null;
        try{
            if(zipCode!=null){
                BranchLookupList = FullQuoteDAO.getBranchLookUpRecord(zipCode);
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainService BranchLookupList:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  QuickQuoteMainService : BranchLookupList()'+BranchLookupList);
        
        return BranchLookupList;
    }
}