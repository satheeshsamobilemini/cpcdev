public with sharing class FullQuoteDAO {
   
    
    public static Full_Quote_Transactional__c getFullQuoteTransactional(String fqtId){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteDAO :getFullQuoteTransactional');
        Full_Quote_Transactional__c FullQuoteTran =null;
        try{
//			FullQuoteTran = [Select f.ytdSales__c, f.writeUpRepCommission__c, f.viewDocumentIn__c, f.type__c, f.transactionId__c, f.totalCodAmount__c, f.termsCode__c, f.tax__c, f.taxExempt__c, f.taxExemptAuthorisation__c, f.status__c, f.startDate__c, f.shippingInstructions__c, f.shippingDate__c, f.shippingAddress_zoneWarning__c, f.shippingAddress_zipCode__c, f.shippingAddress_taxId__c, f.shippingAddress_state__c, f.shippingAddress_oldPostalCode__c, f.shippingAddress_name__c, f.shippingAddress_longitude__c, f.shippingAddress_latitude__c, f.shippingAddress_fulfillingBranchName__c, f.shippingAddress_fulfillingBranchId__c, f.shippingAddress_distanceFromBranch__c, f.shippingAddress_distanceBranch__c, f.shippingAddress_deliveryZone__c, f.shippingAddress_crossStreet2__c, f.shippingAddress_crossStreet1__c, f.shippingAddress_countryId__c, f.shippingAddress_cityZone__c, f.shippingAddress_address4__c, f.shippingAddress_address3__c, f.shippingAddress_address2__c, f.shippingAddress_address1__c, f.shippingAddressId__c, f.salesRep2__c, f.salesRep2Name__c, f.salesRep1__c, f.salesRep1Name__c, f.reservationId__c, f.rentalLength__c, f.rentalCharge__c, f.reference__c, f.quoteTotal__c, f.quoteExpires__c, f.portalContact__c, f.portalContactEmail__c, f.poRequired__c, f.poExpires__c, f.plannedCollectionDate__c, f.pickUp__c, f.other__c, f.nscRepCommission__c, f.narrative2__c, f.narrative1__c, f.modifiedTimestamp__c, f.mobilization__c, f.messageDetails__c, f.llw__c, f.invoicedBalance__c, f.instructionText__c, f.homeOwner__c, f.hireTerms__c, f.emailPortalLink__c, f.documentId__c, f.delivery__c, f.customerText1__c, f.creditStatus__c, f.creditApproval__c, f.companyId__c, f.codAmount__c, f.certificateOfInsurance__c, f.branchId__c, f.billingAddress_zoneWarning__c, f.billingAddress_zipCode__c, f.billingAddress_taxId__c, f.billingAddress_state__c, f.billingAddress_oldPostalCode__c, f.billingAddress_name__c, f.billingAddress_longitude__c, f.billingAddress_latitude__c, f.billingAddress_fulfillingBranchName__c, f.billingAddress_fulfillingBranchId__c, f.billingAddress_distanceFromBranch__c, f.billingAddress_distanceBranch__c, f.billingAddress_deliveryZone__c, f.billingAddress_crossStreet2__c, f.billingAddress_crossStreet1__c, f.billingAddress_countryId__c, f.billingAddress_cityZone__c, f.billingAddress_address4__c, f.billingAddress_address3__c, f.billingAddress_address2__c, f.billingAddress_address1__c, f.billingAddressId__c, f.alreadyRegistered__c, f.accountId__c, f.accessories__c, f.SystemModstamp, f.ShippingContactDetails_tel__c, f.ShippingContactDetails_name__c, f.ShippingContactDetails_mobile__c, f.ShippingContactDetails_id__c, f.ShippingContactDetails_fax__c, f.ShippingContactDetails_email__c, f.OwnerId, f.Name, f.LastModifiedDate, f.LastModifiedById, f.IsDeleted, f.Id, f.CurrencyIsoCode, f.CreatedDate, f.CreatedById, f.BillingContactDetails_tel__c, f.BillingContactDetails_name__c, f.BillingContactDetails_mobile__c, f.BillingContactDetails_id__c, f.BillingContactDetails_fax__c, f.BillingContactDetails_email__c, (Select Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, Full_Quote_Transactional__c, ChargeCode_active__c, ChargeCode_description__c, ChargeCode_id__c, Sequence__c, commission1__c, commission2__c, commission3__c, commission4__c, description__c, ecode__c, internetCoupon__c, invoiceDiscountApplicable__c, itemId__c, lineId__c, lineValue__c, lockItemCode__c, price__c, quantity__c, rate1__c, rate2__c, rate3__c, rate4__c, rate5__c, rate6__c, rate7__c, rate8__c, reference__c From Summary_Lines__r), (Select Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, Full_Quote_Transactional__c, Sequence__c, description__c, id__c, include__c, mandatory__c, priceEditable__c, price__c, quantityEditable__c, quantityRequired__c, quantity__c, rate1__c, rate2__c, rate3__c, rate4__c, rate5__c, rate6__c, rate7__c, rate8__c, total__c From Product_Extras__r), (Select Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, MMI_Full_Quotes__c, Standard_Modification__c, Quantity__c, Sale_Price__c, IsSelected__c, SandForApproval__c, IsApproved__c, IsModificationCompleted__c, Full_Quote_Transactional__c, SenderEmail__c, ApproverEmail__c From Modification_Option_Transactional__r), (Select Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, Full_Quote_Transactional__c, Header_description__c, Header_id__c, Selection_description__c, Selection_id__c, Sequence__c From AnalysisSets__r), (Select Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, Full_Quote_Transactional__c, Header_description__c, Header_id__c, Selection_description__c, Selection_id__c, Sequence__c From AdditionalAnalysisSets__r) From Full_Quote_Transactional__c f limit 1];
			FullQuoteTran = [Select f.ytdSales__c,
									f.rentalLengthInProduct__c,
			                         f.SourceId__c,
									f.writeUpRepCommission__c, 
									f.viewDocumentIn__c, 
									f.type__c, 
									f.transactionId__c,
									f.totalCodAmount__c,
									f.termsCode__c, 
									f.User_sign__c, 
									f.lastInvoiceDate__c,
									f.tax__c,  
									f.taxExempt__c, 
									f.taxExemptAuthorisation__c,
									f.status__c, 
									f.startDate__c, 
									f.shippingInstructions__c,
									f.shippingDate__c, 
									f.shippingAddress_zoneWarning__c,
									f.shippingAddress_zipCode__c, 
									f.shippingAddress_taxId__c,
									f.shippingAddress_state__c, 
									f.shippingAddress_oldPostalCode__c,
									f.shippingAddress_name__c, 
									f.shippingAddress_longitude__c,
									f.shippingAddress_latitude__c,
									f.shippingAddress_fulfillingBranchName__c,
									f.shippingAddress_fulfillingBranchId__c,
									f.shippingAddress_distanceFromBranch__c,
									f.shippingAddress_distanceBranch__c, 
									f.shippingAddress_deliveryZone__c,
									f.shippingAddress_crossStreet2__c, 
									f.shippingAddress_crossStreet1__c,
									f.shippingAddress_countryId__c, 
									f.shippingAddress_cityZone__c,
									f.shippingAddress_address4__c, 
									f.shippingAddress_address3__c,
									f.shippingAddress_address2__c, 
									f.shippingAddress_address1__c,
									f.shippingAddressId__c, 
									f.salesRep2__c, 
									f.salesRep2Name__c,
									f.salesRep1__c, 
									f.salesRep1Name__c, 
									f.reservationId__c,
									f.rentalLength__c, 
									f.rentalCharge__c, 
									f.reference__c, 
									f.quoteTotal__c,
									f.quoteExpires__c, 
									f.portalContact__c, 
									f.portalContactEmail__c,
									f.poRequired__c, 
									f.poExpires__c, 
									f.plannedCollectionDate__c,
									f.pickUp__c, 
									f.other__c, 
									f.nscRepCommission__c, 
									f.narrative2__c,
									f.narrative1__c, 
									f.modifiedTimestamp__c, 
									f.mobilization__c,
									f.messageDetails__c, 
									f.llw__c, 
									f.invoicedBalance__c,
									f.instructionText__c, 
									f.homeOwner__c, 
									f.hireTerms__c,
									f.emailPortalLink__c, 
									f.documentId__c, 
									f.delivery__c,
									f.customerText1__c, 
									f.creditStatus__c, 
									f.creditApproval__c,
									f.companyId__c, 
									f.codAmount__c, 
									f.certificateOfInsurance__c,
									f.branchId__c, 
									f.billingAddress_zoneWarning__c,
									f.billingAddress_zipCode__c, 
									f.billingAddress_taxId__c,
									f.billingAddress_state__c, 
									f.billingAddress_oldPostalCode__c,
									f.billingAddress_name__c, 
									f.billingAddress_longitude__c,
									f.billingAddress_latitude__c, 
									f.billingAddress_fulfillingBranchName__c,
									f.billingAddress_fulfillingBranchId__c,
									f.billingAddress_distanceFromBranch__c,
									f.billingAddress_distanceBranch__c, 
									f.billingAddress_deliveryZone__c,
									f.billingAddress_crossStreet2__c, 
									f.billingAddress_crossStreet1__c,
									f.billingAddress_countryId__c, 
									f.billingAddress_cityZone__c,
									f.billingAddress_address4__c, 
									f.billingAddress_address3__c,
									f.billingAddress_address2__c, 
									f.billingAddress_address1__c,
									f.billingAddressId__c, 
									f.alreadyRegistered__c, 
									f.accountId__c,
									f.account_Name__c,
									f.accessories__c, 
									f.SystemModstamp, 
									f.ShippingContactDetails_tel__c,
									f.ShippingContactDetails_name__c, 
									f.ShippingContactDetails_mobile__c,
									f.ShippingContactDetails_id__c, 
									f.ShippingContactDetails_fax__c,
									f.ShippingContactDetails_email__c, 
									f.OwnerId, 
									f.Name,
									f.LastModifiedDate, 
									f.LastModifiedById, 
									f.IsDeleted, 
									f.Id,
									f.CurrencyIsoCode, 
									f.CreatedDate, 
									f.CreatedById,
									f.BillingContactDetails_tel__c, 
									f.BillingContactDetails_name__c,
									f.BillingContactDetails_mobile__c, 
									f.BillingContactDetails_id__c,
									f.BillingContactDetails_fax__c, 
									f.BillingContactDetails_email__c,
									f.isAddressValidated__c,
									f.isMainProductAdded__c,
									f.Main_Product_Description__c,
									f.Approver_Comments__c,
									f.Modification_Comments__c,
									f.Contact__c,
									(Select Id, 
										IsDeleted, 
										Name, 
										CurrencyIsoCode, 
										CreatedDate, 
										CreatedById,
										LastModifiedDate, 
										LastModifiedById, 
										SystemModstamp,
										Full_Quote_Transactional__c, 
										ChargeCode_active__c,
										ChargeCode_description__c, 
										ChargeCode_id__c, 
										Sequence__c,
										commission1__c, 
										commission2__c, 
										commission3__c, 
										commission4__c,
										description__c, 
										ecode__c, 
										internetCoupon__c,
										invoiceDiscountApplicable__c, 
										itemId__c, 
										lineId__c, 
										lineValue__c,
										lockItemCode__c, 
										price__c, 
										quantity__c, 
										rate1__c, 
										rate2__c, 
										rate3__c,
										rate4__c, 
										rate5__c, 
										rate6__c, 
										rate7__c, 
										rate8__c,
										NetBookValue__c, 
										reference__c From
										Summary_Lines__r order by Sequence__c asc ), 
									(Select Id, 
										IsDeleted, 
										Name, 
										CurrencyIsoCode,
										CreatedDate, 
										CreatedById, 
										LastModifiedDate, 
										LastModifiedById,
										SystemModstamp, 
										Full_Quote_Transactional__c, 
										Sequence__c,
										description__c, 
										id__c, 
										include__c, 
										mandatory__c, 
										priceEditable__c,
										price__c, 
										quantityEditable__c, 
										quantityRequired__c, 
										quantity__c,
										rate1__c, 
										rate2__c, 
										rate3__c, 
										rate4__c, 
										rate5__c, 
										rate6__c, 
										rate7__c,
										rate8__c, 
										total__c From Product_Extras__r order by Sequence__c asc),
									(Select Id,
										IsDeleted, 
										Name,
										CurrencyIsoCode, 
										CreatedDate, 
										CreatedById, 
										LastModifiedDate,
										LastModifiedById, 
										SystemModstamp, 
										Standard_Modification__c, 
										Quantity__c, 
										Sale_Price__c, 
										IsSelected__c,
										SandForApproval__c, 
										IsApproved__c, 
										IsModificationCompleted__c,
										Full_Quote_Transactional__c, 
										SenderEmail__c, 
										ApproverEmail__c From
										Modification_Option_Transactional__r order by Sequence__c asc), 
									(Select Id, 
										IsDeleted, 
										Name,
										CurrencyIsoCode, 
										CreatedDate, 
										CreatedById, 
										LastModifiedDate,
										LastModifiedById, 
										SystemModstamp, 
										Full_Quote_Transactional__c,
										Header_description__c, 
										Header_id__c, 
										Selection_description__c,
										Selection_id__c, 
										Sequence__c From AnalysisSets__r order by Sequence__c asc),
									(Select Id,
										IsDeleted, 
										Name, 
										CurrencyIsoCode, 
										CreatedDate, 
										CreatedById,
										LastModifiedDate, 
										LastModifiedById, 
										SystemModstamp,
										Full_Quote_Transactional__c, 
										Header_description__c, 
										Header_id__c,
										Selection_description__c, 
										Selection_id__c, 
										Sequence__c From
										AdditionalAnalysisSets__r order by Sequence__c asc) 
								From Full_Quote_Transactional__c f where f.Id=:fqtId limit 1];
			
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteDAO getFullQuoteTransactional:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteDAO : getFullQuoteTransactional()'+FullQuoteTran);
        
        return FullQuoteTran;
    }
    
    public static List<Rate__c> getRateRecord(set<id> productId){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteDAO :getLeadRecord'+productId);
        List<Rate__c> rateRecoed=null;
        try{
            if(productId!=null){
                rateRecoed = [Select Id, rate__c, editable__c, description__c, Sequence__c, Product_Extras__c, Name From Rate__c  where Product_Extras__c IN :productId order by Sequence__c asc];
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteDAO getLeadRecord:'+e.getMessage());
        }
         system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteDAO : getLeadRecord()'+rateRecoed);
        
        return rateRecoed;
    }
    
   /*********************************************************************
    Purpose     : To insert FullQuote record
    Parameters  : MMI_Full_Quotes__c object type
    Returns     : opportunity id
    **********************************************************************/
    public static String insertFullQuote(MMI_Full_Quotes__c fullQuote){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteDAO :insertFullQuote');
        String oppID=null;
        try{
            if(fullQuote!=null){
                 insert fullQuote;
                 oppID=fullQuote.Opportunity__c;
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteDAO insertFullQuote:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteDAO : insertFullQuote()'+oppID);
        
        return oppID;
    }
     /*********************************************************************
    Purpose     : To update FullQuote record
    Parameters  : MMI_Full_Quotes__c object type
    Returns     : opportunity id
    **********************************************************************/
    public static String updateFullQuote(MMI_Full_Quotes__c fullQuote){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteDAO :updateFullQuote');
        String oppID=null;
        try{
            if(fullQuote!=null){
                 update fullQuote;
                 oppID=fullQuote.Opportunity__c;
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteDAO updateFullQuote:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteDAO : updateFullQuote()'+oppID);
        
        return oppID;
    }
    
    /*********************************************************************
    Purpose     : To get Lead records
    Parameters  : lead id 
    Returns     : List of Lead records
    **********************************************************************/
    public static List<Lead> getLeadRecord(String leadRecID){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteDAO :getLeadRecord');
        List<Lead> leadRec=null;
        try{
            if(leadRecID!=null){ 
                leadRec = [Select Id,FirstName,LastName, Email, MobilePhone, Phone,Name,LeadSource,Industry, City, Country, State, Street, PostalCode, Company ,Delivery_City__c,Delivery_Country__c,Delivery_State__c,Delivery_Street__c,Delivery_Postal_Code__c,Branch__c,Servicing_Branch_Id__c,View_Branch_Snapshot__c from Lead where Id =: leadRecId limit 1];
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteDAO getLeadRecord:'+e.getMessage());
        }
         system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteDAO : getLeadRecord()'+leadRec);
        
        return leadRec;
    }
    
    /*********************************************************************
    Purpose     : To get Lead records
    Parameters  : lead id 
    Returns     : List of Lead records
    **********************************************************************/
    public static List<Lead> getLeadIndustry(String oppIdisCon){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteDAO :getLeadRecord');
        List<Lead> leadRec=null;
        try{
            if(oppIdisCon!=null){
                leadRec = [Select Id, Name,FirstName,LastName,phone,LeadSource,Industry,ConvertedOpportunityId ,City, Country, State, Street, PostalCode, Company ,Delivery_City__c,Delivery_Country__c,Delivery_State__c,Delivery_Street__c,Delivery_Postal_Code__c,Branch__c,Servicing_Branch_Id__c,View_Branch_Snapshot__c from Lead where ConvertedOpportunityId  =: oppIdisCon limit 1];
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteDAO getLeadRecord:'+e.getMessage());
        }
         system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteDAO : getLeadRecord()'+leadRec);
        
        return leadRec;
    }
    
    /*********************************************************************
    Purpose     : To get Account records
    Parameters  : RR result Account id 
    Returns     : List of Account records
    **********************************************************************/
    public static List<Account> getAccountRecord(String accountId){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteDAO :getAccountRecord');
        List<Account> accountList=null;
        system.debug('-----accountId-------'+accountId);
        try{
            if(accountId!=null){
                accountList = [Select a.Result_Id__c, a.LastName, a.Id, a.FirstName, a.ABI_Company_Id__c, (Select AccountId, LastName, FirstName, Email From Contacts) From Account a where Result_Id__c =: accountId];
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteDAO getAccountRecord:'+e.getMessage());
        }
         system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteDAO : getAccountRecord()'+accountList);
        
        return accountList;
    }
    
    /*********************************************************************
    Purpose     : To get BranchId info for Product Webservices
    Parameters  : none
    Returns     : BranchId
    **********************************************************************/
    public static String getBranchId(String FulFillingBranchId, String RecordId){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteDAO :getBranchId');
        String bId ='';
        if(FulFillingBranchId == '' || FulFillingBranchId == null){
        	list<Lead> ld = [select Servicing_Branch_Id__c,Branch__c from Lead where Id = :RecordId];
        	list<Opportunity> opp = [select Servicing_Branch__c,Branch__c from Opportunity where Id = :RecordId];
        	list<Account> acc = [select Servicing_Branch_Id__c,Branch__c from Account where Id = :RecordId];
        	User UserRecord = [select Name, Branch_Id__c, Branch__c,Sales_Rep_Id__c from user where id=: UserInfo.getUserId()];
        	if(!ld.isEmpty() && ld.size() > 0){
        		if(ld[0].Servicing_Branch_Id__c != null){
        			bId = ld[0].Servicing_Branch_Id__c;
        		}else if(ld[0].Branch__c != null){
        			bId = ld[0].Branch__c;
        		}else{
        			bId = UserRecord.Branch_Id__c;
        		}
        	}
        	if(!opp.isEmpty() && opp.size() > 0){
        		if(opp[0].Servicing_Branch__c != null){
        			bId = opp[0].Servicing_Branch__c;
        		}else if(opp[0].Branch__c != null){
        			bId = opp[0].Branch__c;
        		}else{
        			bId = UserRecord.Branch_Id__c;
        		}
        	}
        	if(!acc.isEmpty() && acc.size() > 0){
        		if(acc[0].Servicing_Branch_Id__c != null){
        			bId = acc[0].Servicing_Branch_Id__c;
        		}else if(acc[0].Branch__c != null){
        			bId = acc[0].Branch__c;
        		}else{
        			bId = UserRecord.Branch_Id__c;
        		}
        	}
        	if((bId == null || bId == '') && UserRecord != null && UserRecord.Branch_Id__c != null){
        		bId = UserRecord.Branch_Id__c;
        	}
        }else{
        	bId = FulFillingBranchId; 
        }
        return bId;
    }
    
    public static Weekly_Snapshot_Branch_Report__c getWeeklySnapShortBranchReport(String branchId){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteDAO :getBranchId');
        system.debug('-----------fullQWrapper.userBranchId------------week--'+branchId);
        Weekly_Snapshot_Branch_Report__c weeklySnapShrt = null;
        String fullfillingBranch = '';
        try{
	        if(branchId != '' || branchId != null){
	        	fullfillingBranch = '%'+branchId+'%';
	        	weeklySnapShrt = [Select w.Zipcode__c, w.Yard_Team__c, w.X5_days_Weather_Forecast__c, w.Weekly__c, w.Weekly_Sales__c, w.Weekly_Rentals__c, w.Warehouse_of_drivers__c, w.Warehouse_availabilty_of_containers__c, w.Warehouse_Zip_Code__c, w.Warehouse_Street__c, w.Warehouse_State__c, w.Warehouse_Other__c, w.Warehouse_Manager__c, w.Warehouse_Delivery_Printer__c, w.Warehouse_City__c, w.View__c, w.Tiltbed_Equiment__c, w.TSM__c, w.TSM_User__c, w.SystemModstamp, w.Street__c, w.Storage_Center__c, w.State__c, w.Sporting_Events_Teams__c, w.Spiff_Contests__c, w.Speacial_Events_Sunday_Paper_Style__c, w.Servicing_Branch__c, w.Result_Printer_for_Pick_up__c, w.Result_Printer_for_Deliveries__c, w.Re_market_Opporunities__c, w.Rate_Adjustments__c, w.Product_Discounts_sales__c, w.OwnerId, w.Other_Sellable_Inventory__c, w.Office_Manager__c, w.OSH_Rates__c, w.OSH_Priority_Capacity__c, w.Name, w.NSC_Market_Campaigns__c, w.NPS__c, w.Monthly_Branch_Goals__c, w.Modification_Info__c, w.Market_Value_Range_40__c, w.Market_Value_Range_40ZS__c, w.Market_Value_Range_40S__c, w.Market_Value_Range_20__c, w.Market_Value_Range_20ZS__c, w.Market_Value_Range_20S__c, w.Link_to_Local_Newspaper_2__c, w.Link_to_Local_Newspaper_1__c, w.LastModifiedDate, w.LastModifiedById, w.LastActivityDate, w.Large_Project_Commitments__c, w.Landolls_Equipment__c, w.IsDeleted, w.Inventory_Surplus__c, w.Inventory_Shortage__c, w.Inventory_Availability__c, w.Image_Id__c, w.Id, w.ISR__c, w.Fun_Facts_about_local_branch_team__c, w.Driver_Totals__c, w.Dispatcher__c, w.Delivery_Info__c, w.Customer_Pickup_Requests__c, w.Custom_Work_Options__c, w.Current_Days_to_get_Security_Office__c, w.CurrencyIsoCode, w.CreatedDate, w.CreatedById, w.County__c, w.Country__c, w.Climate_Controlled__c, w.Climate_Control_Info__c, w.City__c, w.Call_To_Action__c, w.Branch_Picture__c, w.Branch_Phone__c, w.Branch_Market_Campaigns__c, w.Branch_Manager__c, w.Branch_Manager_Notes__c, w.Avg_days_to_get_Security_Office_Ready__c, w.Average_Driver_Moves__c From Weekly_Snapshot_Branch_Report__c w where Servicing_Branch__c like : fullfillingBranch limit 1];
	    	}
	    }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteDAO getUserDetails:'+e.getMessage());
        }
    	return weeklySnapShrt;
    }
    
    /*********************************************************************
    Purpose     : To get User Branch info
    Parameters  : none
    Returns     : running user record
    **********************************************************************/
    public static User getUserBranchDetails(){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteDAO :getUserDetails');
        User UserRecord=null;
        try{
            
            UserRecord = [select Name, Branch_Id__c, Branch__c,Sales_Rep_Id__c,NSC_Rep__c from user where id=: UserInfo.getUserId()];
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteDAO getUserDetails:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteDAO : getUserDetails()'+UserRecord);
        
        return UserRecord;
    }
    
    /*********************************************************************
    Purpose     : To get User Name info
    Parameters  : User Id
    Returns     : running user record
    **********************************************************************/
    public static User getUserDetails(String UserId){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteDAO :getUserDetails');
        User UserRecord=null;
        try{
            
            UserRecord = [select Name,email, Branch_Id__c, Branch__c,Sales_Rep_Id__c from user where id= :UserId];
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteDAO getUserDetails:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteDAO : getUserDetails()'+UserRecord);
        
        return UserRecord;
    }
    
    /*********************************************************************
    Purpose     : To get opportunity related to the Lead 
    Parameters  : lead id 
    Returns     : List of opportunity records
    **********************************************************************/
    public static List<Opportunity> getOppRecord(String leadRecID){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteDAO :getOppRecord');
        List<Opportunity> oppRec=null;
        try{
            if(leadRecID!=null){
                  oppRec = [Select of_Units__c,Quote_type__c,LeadSource,Item_Code__c,Id,StageName,name,Job_Profile__c,Job_Profile__r.Name, Job_Profile__r.Job_Site_Zip__c, Job_Profile__r.Job_Site_State__c, Job_Profile__r.Job_Site_County__c, Job_Profile__r.Job_Site_Country__c, Job_Profile__r.Job_Site_City__c, Job_Profile__r.Job_Site_Address__c, Job_Profile__r.Job_Profile_ID__c,Account.Name, AccountId,Account.Result_Id__c, Valid_Address_Id__c,Delivery_City__c,Delivery_Country__c,Delivery_State_Province__c,	Delivery_Street__c, Delivery_Zip_Postal_Code__c,Branch__c,Servicing_Branch__c,View_Branch_Snapshot__c,Result_Rental_Sale_Doc__c,Account.ShippingCountry, Account.ShippingPostalCode, Account.ShippingState, Account.ShippingCity, Account.ShippingStreet, Account.BillingCountry, Account.BillingPostalCode, Account.BillingState, Account.BillingCity, Account.BillingStreet,Contact_Name__c,Contact_Phone__c,Account.IsPersonAccount,Sub_Contractor_Role__c,Contact_Last_Name__c,Contact_Mobile__c,Contact_Email__c,Opportunity_Contact_Name_LookUpFilter__c,Quote_Comments__c, Account.OwnerId, Unit_Type__c, Delivery_Zone__c,Who_Reserved_Capacity__c, Why_do_you_need_storage_Picklist__c from Opportunity where Id =: leadRecID limit 1];

            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteDAO getOppRecord:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteDAO : getOppRecord()'+oppRec);
        
        return oppRec;
    }
    
    
    /*********************************************************************
    Purpose     : To get opportunity related to the Lead 
    Parameters  : lead id 
    Returns     : List of opportunity records
    **********************************************************************/
    public static List<Account> getAccountList(String leadRecID){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteDAO :getOppRecord');
        List<Account> accRec=null;
        try{
            if(leadRecID!=null){
            	/*Account AccRecord = [Select a.IsPersonAccount From Account a where Id = :leadRecID];
	            if(AccRecord != null){
	            	if(AccRecord.IsPersonAccount){
	            		accRec = [Select Lead_Source__c,Result_Id__c,Id,FirstName,LastName, ShippingCity, ShippingCountry, ShippingPostalCode, ShippingState, ShippingStreet, BillingCity, BillingCountry, BillingPostalCode, BillingState, BillingStreet,Branch__c,Servicing_Branch_Id__c from Account where Id =: leadRecID limit 1];
	            	}else{*/
	            		
					accRec = [Select Industry,LastName,IsPersonAccount,FirstName,Lead_Source__c,Result_Id__c,Id,Name, ShippingCity, ShippingCountry, ShippingPostalCode, ShippingState, ShippingStreet, BillingCity, BillingCountry, BillingPostalCode, BillingState, BillingStreet,Branch__c,Servicing_Branch_Id__c , OwnerId, (Select Phone,FirstName,LastName,Name From Contacts)from Account where Id =: leadRecID limit 1];
	            	//}
	            //}
                 //accRec = [Select Lead_Source__c,Result_Id__c,Id,Name,FirstName,LastName, ShippingCity, ShippingCountry, ShippingPostalCode, ShippingState, ShippingStreet, BillingCity, BillingCountry, BillingPostalCode, BillingState, BillingStreet,Branch__c,Servicing_Branch_Id__c from Account where Id =: leadRecID limit 1];
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteDAO getOppRecord:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteDAO : getOppRecord()'+accRec);
        
        return accRec;
    }
    
    
    /*********************************************************************
    Purpose     : To get Account records
    Parameters  : Account id 
    Returns     : Account records
    **********************************************************************/
    public static Account getAccRecord(String accID){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteDAO :getAccRecord');
        Account accRec=null;
        try{
            if(accID!=null){
                accRec = [Select Id, ShippingCity, ShippingCountry, ShippingPostalCode, ShippingState, ShippingStreet, BillingCity, BillingCountry, BillingPostalCode, BillingState, BillingStreet,Branch__c,Servicing_Branch_Id__c,OwnerId from Account where Id =: accID limit 1 ];
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteDAO getAccRecord:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteDAO : getAccRecord()'+accRec);
        
        return accRec;
    }
    
    /*********************************************************************
    Purpose     : To get Lead Status
    Parameters  : none
    Returns     : Lead status
    **********************************************************************/
    public static LeadStatus getLeadStatus(){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteDAO :getLeadStatus');
        LeadStatus convertStatus=null;
        try{
            
            convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
        
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteDAO getLeadStatus:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteDAO : getLeadStatus()'+convertStatus);
        
        return convertStatus;
    }
    
    
    /*********************************************************************
    Purpose     : To convert lead 
    Parameters  : lead id and owner id 
    Returns     : Database lead conversion result
    **********************************************************************/
    public static Database.LeadConvertResult convertLead(String leadId , String ownerId){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteDAO :convertLead'+ leadId +'--'+ownerId);
        Database.LeadConvertResult leadConverResult=null;
        Database.LeadConvert lc=null;
      
        try{
            if(leadId!=null && ownerId!=null){ 
            	Lead leadRec = [Select Id,FirstName,LastName,LeadSource, Name,Industry, City, Country, State, Street, PostalCode, Company ,Delivery_City__c,Delivery_Country__c,Delivery_State__c,Delivery_Street__c,Delivery_Postal_Code__c,Branch__c,Servicing_Branch_Id__c from Lead where Id =: leadId limit 1];
                lc = new database.LeadConvert();
                lc.setLeadId(leadId);
                lc.setownerId(ownerId);
                account account;
                if(leadRec.Delivery_Country__c!=null){
                	if(leadRec.Company!=null){
                	  account = new account(Name=leadRec.Company ,Lead_Source__c = leadRec.LeadSource, Industry = leadRec.Industry, BillingCountry=leadRec.Delivery_Country__c);
                	}else{
                		account = new account(FirstName=leadRec.FirstName, Lead_Source__c = leadRec.LeadSource, Industry = leadRec.Industry, LastName= leadRec.LastName, BillingCountry=leadRec.Delivery_Country__c);
                	}
                }else if(leadRec.Country!=null){
                	if(leadRec.Company!=null){
                        account = new account(Name=leadRec.Company , Lead_Source__c = leadRec.LeadSource, Industry = leadRec.Industry, BillingCountry=leadRec.Country);
                	}else{
                		account = new account(FirstName=leadRec.FirstName,LastName= leadRec.LastName ,Lead_Source__c = leadRec.LeadSource, Industry = leadRec.Industry, BillingCountry=leadRec.Country);
                	}
                }else{
                	if(leadRec.Company!=null){
                	  account = new account(Name=leadRec.Company , Lead_Source__c = leadRec.LeadSource, Industry = leadRec.Industry, BillingCountry='');
                	}else{
                		account = new account(FirstName=leadRec.FirstName,LastName= leadRec.LastName, Lead_Source__c = leadRec.LeadSource, Industry = leadRec.Industry, BillingCountry='');
                	}
                }
                
                insert account;
                lc.setAccountId(account.id);
                if(!leadRec.Industry.contains('Homeowner')){
                contact contact = new contact(firstname=leadRec.FirstName, lastname=leadRec.LastName,accountid=account.id);
                insert contact;
                lc.setContactId(contact.id);
                }
                
                LeadStatus convertStatus =getLeadStatus();
                lc.setConvertedStatus(convertStatus.MasterLabel);
                leadConverResult = Database.convertLead(lc);
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteDAO convertLead:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteDAO : convertLead()'+leadConverResult);
        
        return leadConverResult;
    }
    
    
    /*********************************************************************
    Purpose     : To convert lead 
    Parameters  : lead id and owner id 
    Returns     : Database lead conversion result
    **********************************************************************/
    public static Database.LeadConvertResult convertLeadWithResultId(String leadId , String ownerId , String resultId, String AccObjId, FullQuoteWrapper fullQWrapper){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteDAO :convertLead'+ leadId +'--'+ownerId+'-----'+resultId);
        Database.LeadConvertResult leadConverResult=null;
        Database.LeadConvert lc=null;
        String AccountIdDuringLc = '';
        try{
            if(leadId!=null && ownerId!=null){
            	Lead leadRec = [Select Id,phone,FirstName,LastName,LeadSource, Name,Industry, City, Country, State, Street, PostalCode, Company ,Delivery_City__c,Delivery_Country__c,Delivery_State__c,Delivery_Street__c,Delivery_Postal_Code__c,Branch__c,Servicing_Branch_Id__c from Lead where Id =: leadId limit 1];
                lc = new database.LeadConvert();
                lc.setLeadId(leadId);
                lc.setownerId(ownerId);
                account account;
                if(AccObjId != null && AccObjId != ''){
                	lc.setAccountId(AccObjId);
                	AccountIdDuringLc = AccObjId;
                }else{
	                if(leadRec.Delivery_Country__c!=null){
	                	if(leadRec.Company!=null){
	                		account = new account(Name=leadRec.Company , Lead_Source__c = leadRec.LeadSource, Industry = leadRec.Industry, BillingCountry=leadRec.Delivery_Country__c);
	                	}else{
	                		account = new account(FirstName=leadRec.FirstName,Lead_Source__c = leadRec.LeadSource, Industry = leadRec.Industry, LastName= leadRec.LastName, BillingCountry=leadRec.Delivery_Country__c);
	                	}
	                }else if(leadRec.Country!=null){
	                	if(leadRec.Company!=null){
	                        account = new account(Name=leadRec.Company , Lead_Source__c = leadRec.LeadSource, Industry = leadRec.Industry, BillingCountry=leadRec.Country);
	                	}else{
	                		account = new account(FirstName=leadRec.FirstName, Lead_Source__c = leadRec.LeadSource, Industry = leadRec.Industry, LastName= leadRec.LastName , BillingCountry=leadRec.Country);
	                	}
	                }else{
	                	if(leadRec.Company!=null){
	                	  	account = new account(Name=leadRec.Company , Lead_Source__c = leadRec.LeadSource, Industry = leadRec.Industry, BillingCountry='');
	                	}else{
	                		account = new account(FirstName=leadRec.FirstName, Lead_Source__c = leadRec.LeadSource, Industry = leadRec.Industry, LastName= leadRec.LastName, BillingCountry='');
	                	}
	                }
	                if(leadRec.Company == null || leadRec.Company == ''){
	                	account.PersonAssistantName = fullQWrapper.Name;
	                	account.PersonAssistantPhone = fullQWrapper.telePhone;
	                }
                	insert account;
                	lc.setAccountId(account.id);
                	AccountIdDuringLc = account.id;
                }
                 system.debug('-------fullQWrapper.selectedOrPgContId---------'+fullQWrapper.selectedOrPgContId);
                if(AccObjId != null && AccObjId != ''){
                	//--commented for-----issue 1271------------
                	/*Contact ConObjCreatedDuringPgAccountCreation = [select id from Contact where AccountId = :AccObjId limit 1];
                	if(ConObjCreatedDuringPgAccountCreation != null){
                		lc.setContactId(ConObjCreatedDuringPgAccountCreation.id);
                	}*/
                	if(fullQWrapper.selectedOrPgContId != null && fullQWrapper.selectedOrPgContId != ''){
                		lc.setContactId(fullQWrapper.selectedOrPgContId);
                	}
                }else{
                	if(!leadRec.Industry.contains('Homeowner')){
		                contact contact = new contact(FirstName = fullQWrapper.Name, LastName = fullQWrapper.LastName, Phone = fullQWrapper.telePhone, Accountid = AccountIdDuringLc, Result_Id__c = fullQWrapper.BillingContactID);
		                insert contact;
		                lc.setContactId(contact.id);
	                }
                }
                system.debug('--------lc.getAccountId'+lc.getAccountId());
                
                LeadStatus convertStatus =getLeadStatus();
                lc.setConvertedStatus(convertStatus.MasterLabel);
                leadConverResult = Database.convertLead(lc);
                //update result id of account
                String AccountIdFromLeadConversion = leadConverResult.getAccountId();
                Account AccountObj = [select Id,IsPersonAccount,Result_Id__c from Account where Id = :AccountIdFromLeadConversion];
                //---------prepending first name before account name issue fix........starts.............
                /*if(AccountObj.IsPersonAccount && AccObjId != null && AccObjId != ''){
                	AccountObj = [select Id,IsPersonAccount,FirstName,LastName,Result_Id__c from Account where Id = :AccountIdFromLeadConversion];
                	if(AccountObj != null){
                		AccountObj.FirstName = '';
                		update AccountObj;
                	}
                }*/
                //---------prepending first name before account name issue fix........ends.............
                if(AccountObj != null && resultId != null && (AccObjId == null || AccObjId == '')){
                	AccountObj.Result_Id__c = resultId;
                	update AccountObj;
                } 
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteDAO convertLead:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteDAO : convertLead()'+leadConverResult);
        
        return leadConverResult;
    }
    public static void getOppStageUpdate(String oppId){
    	system.debug('-------oppId---------'+oppId);
    	Opportunity oppupdate = null;
    	 oppupdate = [select id,StageName from Opportunity where id = :oppId];
    	if(oppupdate != null){
    		oppupdate.StageName = 'Quoted - Lost Business';
    		//update oppupdate; 
    	}
    	system.debug('-------oppId---------'+oppId);
    	system.debug('-------oppupdate---------'+oppupdate);
    }
    
    
    
    /*********************************************************************
    Purpose     : To get Quick Quote record
    Parameters  : Quick Quote Id 
    Returns     : MMI_Quotes__c records
    **********************************************************************/
    public static MMI_Full_Quotes__c getFullQuoteRecord(String DocID){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteDAO :getFullQuoteRecord');
        MMI_Full_Quotes__c FullQRec=null;
        
        try{
            if(DocID!=null){
            	FullQRec = [Select id ,
            	    Name,
                    Opportunity__c,
                    No_Reservation__c,
        			Document_Id__c , 
        			Quote_Id__c, 
        			Last_Invoice__c,
        			Mobilization__c ,
        			Transaction_Type__c ,
        			Write_Up_Rep_Id__c ,
        			Write_Up_Rep_Name__c ,
        			Assisting_Rep_Id__c,
        			Assisting_Rep_Name__c ,
        			Account_Id__c,
        			Account_Name__c ,
        			Address_Id__c ,
        			Billing_Address__c ,
        			Tax_Exempt__c ,
        			Status__c , 
        			Billing_City__c ,
        			Billing_County__c ,
        			Billing_State__c ,
        			Billing_Country__c ,
        			Billing_Zip_Code__c ,
        			Billing_Contact_Id__c ,
        			Billing_Contact_Name__c ,
        			Billing_Contact_Tel__c ,
        			Billing_Contact_Fax__c ,
        			Billing_Contact_Email__c ,
        			PO_Contact__c,
        			PO_Expires__c ,
        			Credit_Approval__c ,
        			Tax_Exempt_Authorization__c,
        			Quote_Total__c,
        			Fulfilling_Branch_Id__c ,
        			Job_or_Location__c ,
        			COD_Instructions__c ,
        			Start_Date__c,
        			Quote_expires__c ,
        			Rental_Length__c,
        			Shipping_Id__c ,
        			Shipping_Address__c ,		
        			Shipping_City__c ,
        			Shipping_County__c ,
        			Shipping_State__c ,
        			Shipping_Country__c ,
        			Shipping_Zip_Code__c,
        			Shipping_Fulfilling_Branch_Id__c ,
        			Shipping_Fulfilling_Branch_Name__c,
        			Shipping_Cross_Street1__c ,
        			Shipping_Cross_Street2__c,
        			Delivery_Contact_Id__c ,
        			Delivery_Contact_Name__c,
        			Delivery_Contact_Tel__c,
        			Delivery_Contact_Fax__c ,
        			Delivery_Contact_Email__c ,
        			Scheduled_Delivery__c ,
        			Loaded_Move_In__c,
        			Delivery_Slot__c ,
        			Delivery_Zone__c ,
        			Distance_from_Branch__c ,
        			Rental_Charge__c ,
        			Fuel_Surcharge__c,
        			Delivery__c ,
        			LLW__c ,
        			Pickup__c ,
        			Other__c ,
        			Accessories__c ,
        			COD_Amount__c ,
        			Total_COD_Amount__c ,
        			Tax__c ,
        			PPE_Total__c ,
        			Terms__c ,
        			Terms_Code__c ,
        			Tax_id__c ,
        			Shipping_Tax_id__c,
        			Item_Image_Url__c,
        			Reservation_ID__c,
        			Longitude__c,
        			Latitude__c,
        			Account__c,
        			Opportunity__r.StageName,
        			Opportunity__r.Result_Rental_Sale_Doc__c,
        			Opportunity__r.AccountId,
        			Opportunity__r.Account.OwnerId,
        			Opportunity__r.Contact__c,
        			Opportunity__r.Opportunity_Contact_Name_LookUpFilter__c,
        			Opportunity__r.Quote_Comments__c,
        			Opportunity__r.Unit_Type__c,
        			Unit_Type__c,
        			Opportunity__r.of_Units__c,
        			User_who_created_capacity__c,
        			Special_Instruction__c,
        			Opportunity__r.Why_do_you_need_storage_Picklist__c
        			
            	                   from MMI_Full_Quotes__c where Quote_Id__c =: DocID
								limit 1];
					system.debug('--------FullQRec----------'+FullQRec);
                 
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteDAO getFullQuoteRecord:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteDAO : getFullQuoteRecord()'+FullQRec);
        
        return FullQRec;
    }
    
    
    
    /*********************************************************************
    Purpose     : To get product item records
    Parameters  : Item code id 
    Returns     : List of accessory record
    **********************************************************************/
    public static List<accessories__c> getAccessory(string itemCode){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteDAO :getAccessory');
        List<accessories__c> accessoryRec=null;
        try{
            if(itemCode!=null){
                accessoryRec = [Select Id, Name from accessories__c where Name =: itemCode limit 1];
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteDAO getAccessory:'+e.getMessage());
        }
         system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteDAO : getAccessory()'+accessoryRec);
        
        return accessoryRec;
    }
    
    /*********************************************************************
    Purpose     : To get Modification Option records
    Parameters  : Item code id 
    Returns     : List of modification option record
    **********************************************************************/
    public static List<Modification_Option_Transactional__c> getModificationOption(string quoteId){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteDAO :getModificationOption');
        List<Modification_Option_Transactional__c> modifOptionRec=null;
        try{
            if(quoteId!=null){
                modifOptionRec = [Select Id,SourceID__c,ModId__c,ModificationOptionDesc__c,Sequence__c, IsApproved__c,IsModificationCompleted__c,IsSelected__c,Quantity__c,Sale_Price__c,SenderEmail__c,ApproverEmail__c,Full_Quote_Transactional__c,SandForApproval__c,Standard_Modification__c,Approver_User__c,Is_Rejected__c,Is_Submitted__c,Submitter_User__c,Submit_Or_Reject_Or_Approved_Time__c from Modification_Option_Transactional__c where Full_Quote_Transactional__c =: quoteId order by Sequence__c asc];
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteDAO getModificationOption:'+e.getMessage());
        }
         system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteDAO : getModificationOption()'+modifOptionRec);
        
        return modifOptionRec;
    }
    
    /*********************************************************************
    Purpose     : To get Modification Option records
    Parameters  : Item code id 
    Returns     : List of modification option record
    **********************************************************************/
    public static String getStamdardModification(string searchString){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteDAO :getModificationOption');
        Standard_Modification__c modifOptionRec=null;
        try{
            if(searchString!=null){
                modifOptionRec = [Select Id,ModId__c,Modification_Option__c from Standard_Modification__c where ModId__c =: searchString limit 1];
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteDAO getModificationOption:'+e.getMessage());
        }
         system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteDAO : getModificationOption()'+modifOptionRec);
        
        return modifOptionRec.Id;
    }
    
    /*********************************************************************
    Purpose     : To insert FullQuote record for Approval Process
    Parameters  : MMI_Full_Quotes__c object type
    Returns     : id
    **********************************************************************/
    public static String insertFullQuoteApprovalProcess(Full_Quote_Transactional__c fullQuote){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteDAO :insertFullQuoteApprovalProcess');
        String quoteID=null;
        try{
            if(fullQuote!=null){
                 insert fullQuote;
                 quoteID=fullQuote.Id;
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteDAO insertFullQuoteApprovalProcess:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteDAO : insertFullQuoteApprovalProcess()'+quoteID);
        
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
    public static boolean insertModificationOption(List<Modification_Option_Transactional__c> moTrans){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteDAO :insertModificationOption');
        Boolean recId=false;
        try{
            if(moTrans!=null && !moTrans.isEmpty()){
            	 insert moTrans;
                 recId=true;
             }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteDAO insertModificationOption:'+e.getMessage());
        }
         system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteDAO : insertModificationOption()'+recId);
        
        return recId;
    }
    
      /*********************************************************************
    Purpose     : To insert Modification Option records
    Parameters  : Modification_Option_Transactional__c
    Returns     : boolean 
    **********************************************************************/
    public static Boolean updateModificationOption(List<Modification_Option_Transactional__c> moTrans){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteDAO :updateModificationOption');
         Boolean recId=false;
        try{
            if(moTrans!=null && !moTrans.isEmpty()){
            	 update moTrans;
                 recId=true;
             }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteDAO updateModificationOption:'+e.getMessage());
        }
         system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteDAO : updateModificationOption()'+recId);
        
        return recId;
    }
    
    /*********************************************************************
    Purpose     : To insert inserrt summury line 
    Parameters  : Summary_Line__c
    Returns     : boolean 
    **********************************************************************/
    public static boolean insertSummuryLine(List<Summary_Line__c> summuryLineItemList){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteDAO :insertSummuryLine');
        Boolean recId=false;
        try{
            if(summuryLineItemList!=null && !summuryLineItemList.isEmpty()){
            	 insert summuryLineItemList;
                 recId=true;
             }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteDAO insertSummuryLine:'+e.getMessage());
        }
         system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteDAO : insertSummuryLine()'+recId);
        
        return recId;
    }
    
    /*********************************************************************
    Purpose     : To insert insertProductExtra
    Parameters  : Product_Extras__c
    Returns     : boolean 
    **********************************************************************/
    public static String insertProductExtra(Product_Extras__c productExtraItemList){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteDAO :insertProductExtra');
        String recId=null;
        try{
            if(productExtraItemList!=null){
            	 insert productExtraItemList;
                 recId =productExtraItemList.id;
             }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteDAO insertProductExtra:'+e.getMessage());
        }
         system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteDAO : insertProductExtra()'+recId);
        
        return recId;
    }
    
    
     /*********************************************************************
    Purpose     : To insert insertAnalysisSet
    Parameters  : AnalysisSet__c
    Returns     : boolean 
    **********************************************************************/
    public static boolean insertAnalysisSet(List<AnalysisSet__c> analysisListt){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteDAO :insertAnalysisSet');
        Boolean recId=false;
        try{
            if(analysisListt!=null && !analysisListt.isEmpty()){
            	 insert analysisListt;
                 recId=true;
             }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteDAO insertAnalysisSet:'+e.getMessage());
        }
         system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteDAO : insertAnalysisSet()'+recId);
        
        return recId;
    }
    
    
    /*********************************************************************
    Purpose     : To insert insertAdditionalAnalysisSet
    Parameters  : AdditionalAnalysisSet__c
    Returns     : boolean 
    **********************************************************************/
    public static boolean insertAdditionalAnalysisSet(List<AdditionalAnalysisSet__c> analysisListt){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteDAO :insertAdditionalAnalysisSet');
        Boolean recId=false;
        try{
            if(analysisListt!=null && !analysisListt.isEmpty()){
            	 insert analysisListt;
                 recId=true;
             }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteDAO insertAdditionalAnalysisSet:'+e.getMessage());
        }
         system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteDAO : insertAdditionalAnalysisSet()'+recId);
        
        return recId;
    }
    
    
    
     /*********************************************************************
    Purpose     : To insert insertRates
    Parameters  : Rate__c
    Returns     : boolean 
    **********************************************************************/
    public static boolean insertRates(List<Rate__c> rateList){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteDAO :insertRates');
        Boolean recId=false;
        try{
            if(rateList!=null && !rateList.isEmpty()){
            	 insert rateList;
                 recId=true;
             }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteDAO insertRates:'+e.getMessage());
        }
         system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteDAO : insertRates()'+recId);
        
        return recId;
    }
    
    public static List<Modification_Approver_List__c> getApproverList(String branchId){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteDAO :getApproverList');
        List<Modification_Approver_List__c> recList=null;
        try{
            if(branchId!=null){
            	recList=[select id,Approver_EmailId__c,Approver_Name__c,Fulfiling_Branch__c from Modification_Approver_List__c where Fulfiling_Branch__c =: branchId];
             }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteDAO getApproverList:'+e.getMessage());
        }
         system.debug(LoggingLevel.DEBUG,'Exiting to  FullQuoteDAO : getApproverList()'+recList);
         
        return recList;
    }
    
    
     /*********************************************************************
    Purpose     : To get Modification Option records
    Parameters  : Item code id 
    Returns     : List of modification option record
    **********************************************************************/
    public static List<Standard_Modification__c> getStandardModificationList(){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteDAO :getStandardModificationList');
       List<Standard_Modification__c> modifOptionRec=null;
        try{
            
            modifOptionRec = [Select Id,ModId__c,Modification_Option__c,sequence__c from Standard_Modification__c order by sequence__c asc];
           
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteDAO getStandardModificationList:'+e.getMessage());
        }
         system.debug(LoggingLevel.DEBUG,'Entring to  FullQuoteDAO : getStandardModificationList()'+modifOptionRec);
        
        return modifOptionRec;
    }
     
    
     /*********************************************************************
    Purpose     : To Sales Inventory records
    Parameters  : 
    Returns     : List of Sales Inventory record
    **********************************************************************/
     public static List<HB_Sales_Inventory__c> getSalesInventoryList(String branchId){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteDAO :getSalesInventoryList');
        List<HB_Sales_Inventory__c> recList=null;
        try{
           
            	recList=[select id,Area__c,Blowout__c,CompanyId__c,Display_Picture__c,E_Code__c,Fulfilling_Branch_Code__c,Grade_Code__c,Grade_Description__c,Item_Reference__c,Line_Item_ID__c,Minimum_Price__c,NBV__c,Notes__c,Reason_Code__c,Status__c,Suggested_Price__c, (select Id,Display_Picture__c,HB_Sales_Inventory__c from SalesInventoryImages__r) from HB_Sales_Inventory__c Where Fulfilling_Branch_Code__c=:branchId];
            
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteDAO getSalesInventoryList:'+e.getMessage());
        }
         system.debug(LoggingLevel.DEBUG,'Exiting to  FullQuoteDAO : getSalesInventoryList()'+recList);
        
        return recList; 
    }
    
     /*********************************************************************
    Purpose     : To get specific Sales Inventory records
    Parameters  : ItemCode and Ecode
    Returns     : Object of Sales Inventory record
    **********************************************************************/
     public static HB_Sales_Inventory__c getSpecificSalesInventoryList(String ItemCode, String ecode){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteDAO :getSpecificSalesInventoryList');
        HB_Sales_Inventory__c InventoryRec=null;
        try{
           
            	InventoryRec = [select id,Area__c,Blowout__c,CompanyId__c,Display_Picture__c,E_Code__c,Fulfilling_Branch_Code__c,Grade_Code__c,Grade_Description__c,Item_Reference__c,Line_Item_ID__c,Minimum_Price__c,NBV__c,Notes__c,Reason_Code__c,Status__c,Suggested_Price__c, (select Id,Display_Picture__c,HB_Sales_Inventory__c from SalesInventoryImages__r) from HB_Sales_Inventory__c Where Line_Item_ID__c = :ItemCode and E_Code__c = :ecode limit 1];
            
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteDAO getSalesInventoryList:'+e.getMessage());
        }
         system.debug(LoggingLevel.DEBUG,'Exiting to  FullQuoteDAO : getSpecificSalesInventoryList()'+InventoryRec);
        
        return InventoryRec; 
    }
    
    /*********************************************************************
    Purpose     : To Sales Inventory records search
    Parameters  : 
    Returns     : List of Sales Inventory record
    **********************************************************************/
     public static List<HB_Sales_Inventory__c> searcSalesInventoryList(String branchId,String searchStr){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteDAO :searcSalesInventoryList');
        List<HB_Sales_Inventory__c> recList=null;
        String queryStr;
        List<HB_Sales_Inventory__c> refineProduct=null;
        try{
        	
        	 if(searchStr != null && searchStr != ''){
	        	if(searchStr.contains('\\')){
	        		searchStr = searchStr.replace('\\', '\\\\');
	        	}
	        	if(searchStr.contains('\'')){
	        		searchStr = searchStr.replace('\'', '\\\'');
	        	}
	        	
	        	queryStr='select id,Area__c,Blowout__c,CompanyId__c,Display_Picture__c,E_Code__c,Fulfilling_Branch_Code__c,Grade_Code__c,Grade_Description__c,Item_Reference__c,Line_Item_ID__c,Minimum_Price__c,NBV__c,Notes__c,Reason_Code__c,Status__c,Suggested_Price__c,(select Id,Display_Picture__c,HB_Sales_Inventory__c from SalesInventoryImages__r) from HB_Sales_Inventory__c Where Fulfilling_Branch_Code__c=\''+branchId+'\'';
                queryStr += ' and ';
                queryStr += '(E_Code__c like '+'\''+searchStr+'%\'';
                queryStr += 'or Fulfilling_Branch_Code__c like '+'\''+searchStr+'%\'';
                queryStr += 'or Area__c like '+'\''+searchStr+'%\'';
                queryStr += 'or Item_Reference__c like '+'\''+searchStr+'%\''; 
                queryStr += 'or Line_Item_ID__c like '+'\''+searchStr+'%\'';
                queryStr += 'or Area__c like '+'\''+searchStr+'%\'';
                queryStr += 'or CompanyId__c like '+'\''+searchStr+'%\'';
                queryStr += 'or Grade_Code__c like '+'\''+searchStr+'%\'';
                queryStr += 'or Reason_Code__c like '+'\''+searchStr+'%\'';
                queryStr += 'or Status__c like '+'\''+searchStr+'%\')';
                    
                refineProduct = Database.query(queryStr);   
	        	
             }
            
            	 
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteDAO searcSalesInventoryList:'+e.getMessage());
        }
         system.debug(LoggingLevel.DEBUG,'Exiting to  FullQuoteDAO : searcSalesInventoryList()'+refineProduct);
        
        return refineProduct; 
    }
    
    
     /*********************************************************************
    Purpose     : To Sales Inventory records
    Parameters  : 
    Returns     : List of Sales Inventory record
    **********************************************************************/
     public static List<HB_Sales_Inventory__c> getSpecificSalesInventoryList2(String productId, String branchId){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteDAO :getSalesInventoryList');
        List<HB_Sales_Inventory__c> recList=null;
        try{
                if(productId!=null && productId!=''){
            	    recList=[select id,Area__c,Blowout__c,CompanyId__c,Display_Picture__c,E_Code__c,Fulfilling_Branch_Code__c,Grade_Code__c,Grade_Description__c,Item_Reference__c,Line_Item_ID__c,Minimum_Price__c,NBV__c,Notes__c,Reason_Code__c,Status__c,Suggested_Price__c,(select Id,Display_Picture__c,HB_Sales_Inventory__c from SalesInventoryImages__r) from HB_Sales_Inventory__c Where Fulfilling_Branch_Code__c=:branchId and Line_Item_ID__c=:productId];
                }
            
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteDAO getSpecificSalesInventoryList:'+e.getMessage());
        }
         system.debug(LoggingLevel.DEBUG,'Exiting to  FullQuoteDAO : getSpecificSalesInventoryList()'+recList);
        
        return recList; 
    }
    
    

    /*********************************************************************
    Purpose     : To Accessories records search
    Parameters  : 
    Returns     : List of Accessories record 
    **********************************************************************/
     public static List<accessories__c>searchAccessories(String searchStr){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteDAO :searchAccessories');
        List<accessories__c> accessoryRec=null; 
        String queryStr;
       // List<HB_Sales_Inventory__c> refineProduct=null;
        try{   
        	
        	 if(searchStr != null && searchStr != ''){
	        	if(searchStr.contains('\\')){
	        		searchStr = searchStr.replace('\\', '\\\\');
	        	}
	        	if(searchStr.contains('\'')){
	        		searchStr = searchStr.replace('\'', '\\\'');
	        	}
	        	
	        	queryStr='select id,Name,Definition_Code__c,Item_Description__c from accessories__c Where Name like '+'\''+searchStr+'%\'';
                queryStr += 'or Definition_Code__c like '+'\''+searchStr+'%\'';
                queryStr += 'or Item_Description__c like '+'\''+searchStr+'%\'';
                    
                accessoryRec = Database.query(queryStr);   
	        	
             }
           
            	
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteDAO searchAccessories:'+e.getMessage());
        }
         system.debug(LoggingLevel.DEBUG,'Exiting to  FullQuoteDAO : searchAccessories()'+accessoryRec);
        
        return accessoryRec; 
    }
    
    /*********************************************************************
    Purpose     : Check whether we have multiple FQ of a Same PG Account
    Parameters  : String QuoteId
    Returns     : String
    **********************************************************************/
    public static String CheckMultiplleFqOFSamePgAcc(String QuoteId){
        system.debug(LoggingLevel.DEBUG,'Entering FullQuoteDAO :CheckMultiplleFqOFSamePgAcc');
        String isMultipleFQ = 'false'; 
        String ResId = '';
        try{
            MMI_Full_Quotes__c FqObj = [select Id, Opportunity__r.AccountId from MMI_Full_Quotes__c where Quote_Id__c = :QuoteId];
            if(FqObj != null){
            	Account AccRec = [select Id, Result_Id__c, (Select Id, Account_Id__c From MMI_Full_Quotes__r) from Account where Id = :FqObj.Opportunity__r.AccountId];
            	if(AccRec != null && !AccRec.Result_Id__c.startsWith('G') && !AccRec.Result_Id__c.startsWith('P') && AccRec.Result_Id__c != '2'){
            		ResId = AccRec.Result_Id__c;
            		if(AccRec.MMI_Full_Quotes__r.size() > 0){
            			Integer Count = 0;
            			for(MMI_Full_Quotes__c fq : AccRec.MMI_Full_Quotes__r){
            				if(fq.Account_Id__c.startsWith('G') || fq.Account_Id__c.startsWith('p')){
            					Count ++;
            				}
            			}
            			if(Count >= 1){
            				isMultipleFQ = 'true';
            			}
            		}
            	}
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteDAO insertFullQuote:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Exiting from  FullQuoteDAO : CheckMultiplleFqOFSamePgAcc'+isMultipleFQ);
        
        return isMultipleFQ+'_'+ResId;
    }
    
    public static void createTaskBeforeLoad(){
    	//------Create Task before lead Convert---------------------
    	/*Task taskObj = new Task();
        taskObj.OwnerId = UserInfo.getUserId();
        User UserBranchId = FullQuoteDAO.getUserBranchDetails();
        taskObj.Subject = 'Full Quote';
        taskObj.ActivityDate = system.today();
        taskObj.Call_Type__c = 'Email';
        taskObj.Call_Result__c = '';
        taskObj.Description = '';
        taskObj.Status = 'Completed';
        taskObj.Priority = 'Normal';
        insert taskObj;*/
    }
    @future
    public static void createTaskBeforeSavingFQ(String OppId, String FullOrQuickQuote){
    	//------Create Task before lead Convert---------------------
    	Task taskObj = new Task();
        taskObj.OwnerId = UserInfo.getUserId();
        User UserBranchId = FullQuoteDAO.getUserBranchDetails();
        taskObj.Subject = FullOrQuickQuote;
        taskObj.ActivityDate = system.today();
        taskObj.Call_Type__c = 'Email';
        taskObj.Call_Result__c = '';
        taskObj.Description = '';
        taskObj.Status = 'Completed';
        taskObj.Priority = 'Normal'; 
        taskObj.WhatId = OppId;
        //taskObj.WhoId = leadId;
        insert taskObj;
    }
    /*********************************************************************
    Purpose     : To get Lead records
    Parameters  : lead id 
    Returns     : List of Lead records
    **********************************************************************/
    public static Branch_Lookup__c getBranchLookUpRecord(String zipCode){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainDAO :BranchLookupRec'+zipCode);
        Branch_Lookup__c BranchLookupRec=null;
        try{
            if(zipCode!=null){
                String queryString = 'Select b.Zip__c, b.US_NSC_Sales_Manager_ID__c,  b.Sales_Manager_ID__c, b.OwnerId, b.National_Account_Manager_ID__c, b.Name, b.NSC_Team__c, b.NSC_Team_Live__c, b.Id, b.CurrencyIsoCode,  b.Country__c, b.Branch_Title__c, b.Branch_Name__c, b.Branch_Code__c,b.County__c,b.City__c,b.Time_Zone__c,b.Drop_Yard__c,b.State__c From Branch_Lookup__c b where zip__c like \'' + zipCode +'\' ';
                system.debug('----queryString-----'+queryString);
                BranchLookupRec = Database.query(queryString);
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainDAO BranchLookupRec:'+e.getMessage());
        }
         system.debug(LoggingLevel.DEBUG,'Entring to  QuickQuoteMainDAO : BranchLookupRec()'+BranchLookupRec);
         return BranchLookupRec;
    }
    
}