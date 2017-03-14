public with sharing class FullQuoteEmailQuote {
	
	public String mmiQuoteid{get;set;}
	public Full_Quote_Transactional__c FullQuoteTransList{get;set;}
	public List<Summary_Line__c> SummList{get;set;}
	public List<Product_Extras__c> prodExtList{get;set;}  
	public Weekly_Snapshot_Branch_Report__c weeklyBranchSnop{get;set;}
	public Decimal totalRentalCharat{get;set;}
	public Decimal totalOneTimeCharges{get;set;}
	public Decimal totalInitialCharges{get;set;}
	public String salesTotal{get;set;}
	public User loginUserRec{get;set;}	
	public Boolean isSalesType{get;set;}
	public Date StartDate{get;set;}
	public Date QuoteExpire{get;set;}
	public Decimal totalSalesCharat{get;set;}
	public Decimal llwValue{get;set;}
	public Decimal ppeValue{get;set;}
        
	public FullQuoteEmailQuote(){
		mmiQuoteid = ApexPages.currentPage().getParameters().get('quoteid');
		isSalesType = false;
	}
	public Pagereference GetPDFcontent(){
		mmiQuoteid = ApexPages.currentPage().getParameters().get('quoteid');

		totalRentalCharat = 0.00;
		totalOneTimeCharges = 0.00;
		totalInitialCharges = 0.00;
		totalSalesCharat = 0.00;
		llwValue = 0.00;
		ppeValue = 0.00;
    	FullQuoteMainService fqService=null;
    	fqService=new FullQuoteMainService();		
		if(mmiQuoteid != null){
			FullQuoteTransList = [Select f.rentalLengthInProduct__c,f.Image_previewQuote__c,f.User_sign__c,f.account_Name__c,f.ytdSales__c,f.Transaction_Name__c, f.writeUpRepCommission__c, f.viewDocumentIn__c, f.type__c, f.transactionId__c, f.totalCodAmount__c, f.termsCode__c, f.tax__c, f.taxExempt__c, f.taxExemptAuthorisation__c, f.status__c, f.startDate__c, f.shippingInstructions__c, f.shippingDate__c, f.shippingAddress_zoneWarning__c, f.shippingAddress_zipCode__c, f.shippingAddress_taxId__c, f.shippingAddress_state__c, f.shippingAddress_oldPostalCode__c, f.shippingAddress_name__c, f.shippingAddress_longitude__c, f.shippingAddress_latitude__c, f.shippingAddress_fulfillingBranchName__c, f.shippingAddress_fulfillingBranchId__c, f.shippingAddress_distanceFromBranch__c, f.shippingAddress_distanceBranch__c, f.shippingAddress_deliveryZone__c, f.shippingAddress_crossStreet2__c, f.shippingAddress_crossStreet1__c, f.shippingAddress_countryId__c, f.shippingAddress_cityZone__c, f.shippingAddress_address4__c, f.shippingAddress_address3__c, f.shippingAddress_address2__c, f.shippingAddress_address1__c, f.shippingAddressId__c, f.salesRep2__c, f.salesRep2Name__c, f.salesRep1__c, f.salesRep1Name__c, f.reservationId__c, f.rentalLength__c, f.rentalCharge__c, f.reference__c, f.quoteTotal__c, f.quoteExpires__c, f.portalContact__c, f.portalContactEmail__c, f.poRequired__c, f.poExpires__c, f.plannedCollectionDate__c, f.pickUp__c, f.other__c, f.nscRepCommission__c, f.narrative2__c, f.narrative1__c, f.modifiedTimestamp__c, f.mobilization__c, f.messageDetails__c, f.llw__c, f.lastInvoiceDate__c, f.invoicedBalance__c, f.instructionText__c, f.homeOwner__c, f.hireTerms__c, f.emailPortalLink__c, f.documentId__c, f.delivery__c, f.customerText1__c, f.creditStatus__c, f.creditApproval__c, f.companyId__c, f.codAmount__c, f.certificateOfInsurance__c, f.branchId__c, f.billingAddress_zoneWarning__c, f.billingAddress_zipCode__c, f.billingAddress_taxId__c, f.billingAddress_state__c, f.billingAddress_oldPostalCode__c, f.billingAddress_name__c, f.billingAddress_longitude__c, f.billingAddress_latitude__c, f.billingAddress_fulfillingBranchName__c, f.billingAddress_fulfillingBranchId__c, f.billingAddress_distanceFromBranch__c, f.billingAddress_distanceBranch__c, f.billingAddress_deliveryZone__c, f.billingAddress_crossStreet2__c, f.billingAddress_crossStreet1__c, f.billingAddress_countryId__c, f.billingAddress_cityZone__c, f.billingAddress_address4__c, f.billingAddress_address3__c, f.billingAddress_address2__c, f.billingAddress_address1__c, f.billingAddressId__c, f.alreadyRegistered__c, f.accountId__c, f.accessories__c, f.SystemModstamp, f.ShippingContactDetails_tel__c, f.ShippingContactDetails_name__c, f.ShippingContactDetails_mobile__c, f.ShippingContactDetails_id__c, f.ShippingContactDetails_fax__c, f.ShippingContactDetails_email__c, f.OwnerId, f.Name, f.LastModifiedDate, f.LastModifiedById, f.IsDeleted, f.Id, f.CurrencyIsoCode, f.CreatedDate, f.CreatedById, f.BillingContactDetails_tel__c, f.BillingContactDetails_name__c, f.BillingContactDetails_mobile__c, f.BillingContactDetails_id__c, f.BillingContactDetails_fax__c, f.BillingContactDetails_email__c, (Select Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, itemId__c, ecode__c, reference__c, description__c, lineValue__c, quantity__c, price__c, invoiceDiscountApplicable__c, lockItemCode__c, ChargeCode_description__c, ChargeCode_active__c, rate1__c, rate2__c, rate3__c, rate4__c, rate5__c, rate7__c, rate8__c, commission1__c, commission2__c, Sequence__c,totalperPeriodvalue__c, Full_Quote_Transactional__c From Summary_Lines__r order by Sequence__c asc), (Select Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, id__c, description__c, quantity__c, price__c, total__c, rate1__c, rate2__c, rate3__c, rate4__c, rate5__c, rate7__c, rate8__c, mandatory__c, priceEditable__c, quantityEditable__c, quantityRequired__c, Full_Quote_Transactional__c, Sequence__c From Product_Extras__r order by Sequence__c asc) From Full_Quote_Transactional__c f where id=: mmiQuoteid limit 1];
			if(FullQuoteTransList.startDate__c != null){
				StartDate = date.valueOf(FullQuoteTransList.startDate__c);	
			}
			if(FullQuoteTransList.quoteExpires__c != null){
				QuoteExpire = date.valueOf(FullQuoteTransList.quoteExpires__c);	
			}
			loginUserRec = [Select Id,Email,Fax,Phone,Extension__c, Name, Sales_Rep_Id__c from User where Id =: UserInfo.getUserId()];
			 
			if(FullQuoteTransList.type__c == 'sales'){	
				isSalesType = true;
	    	}else{
	    		isSalesType = false;
	    	}

			SummList = FullQuoteTransList.Summary_Lines__r;
			prodExtList = FullQuoteTransList.Product_Extras__r;
			if(SummList.size() > 0){
			String productCode = SummList[0].itemId__c; 
			} 
			
			List<HomeBaseBeans.transactions> transactionResponse;
	    	TransactionListService_AC transactionService=null;
	    	
		    	transactionService = new TransactionListService_AC();
			    String bId = fqService.getuserBranchInfo();
		    	transactionResponse = transactionService.listActiveTransactions(bId);
		    if(FullQuoteTransList.transactionId__c != null){
		    	for(HomeBaseBeans.transactions TT : transactionResponse){
					if(FullQuoteTransList.transactionId__c == TT.id){
						FullQuoteTransList.Transaction_Name__c = TT.description;
					}
		  		}	
		    }	
			salesTotal = FullQuoteTransList.tax__c;
			if(SummList.size() > 0){
				for(Summary_Line__c sl : SummList){
				if(isSalesType == true){
					if(totalSalesCharat == null ){
    					totalSalesCharat = Decimal.valueOf(sl.lineValue__c);
    				}else{
    					totalSalesCharat = totalSalesCharat + Decimal.valueOf(sl.lineValue__c);
    				}
    				sl.totalperPeriodvalue__c = String.valueOf(sl.lineValue__c);
    			}else{
					if(sl.itemId__c != 'CG1' && sl.itemId__c != 'CG2' && sl.itemId__c != 'DL1' && sl.itemId__c != 'DL2'){
						system.debug('--sl.itemId__c-if--'+sl.itemId__c);
						if(totalRentalCharat == null ){
							if(FullQuoteTransList.quoteTotal__c == 'CT'){
								Boolean accessoryRes = false;
                				accessoryRes = fqService.getAccessoryInfo(sl.itemId__c);
                				system.debug('-------------accessoryRes-------------------'+accessoryRes);
                				if(accessoryRes){
                					totalRentalCharat = Decimal.valueOf(sl.lineValue__c);
                				}else{
                					totalRentalCharat = Decimal.valueOf(sl.lineValue__c) * Decimal.valueOf(sl.quantity__c);
                				}
							}else{
								totalRentalCharat = Decimal.valueOf(sl.price__c) * Decimal.valueOf(sl.quantity__c);
							}
						}else{
							if(FullQuoteTransList.quoteTotal__c == 'CT'){
								Boolean accessoryRes = false;
                				accessoryRes = fqService.getAccessoryInfo(sl.itemId__c);
                				system.debug('-------------accessoryRes-------------------'+accessoryRes);
                				if(accessoryRes){
                					totalRentalCharat = totalRentalCharat + Decimal.valueOf(sl.lineValue__c);
                				}else{
                					totalRentalCharat = totalRentalCharat + Decimal.valueOf(sl.lineValue__c) * Decimal.valueOf(sl.quantity__c);
                				}
							}else{
								totalRentalCharat = totalRentalCharat + Decimal.valueOf(sl.price__c) * Decimal.valueOf(sl.quantity__c);
							}
						}
						if(FullQuoteTransList.quoteTotal__c == 'CT'){
							Boolean accessoryRes = false;
            				accessoryRes = fqService.getAccessoryInfo(sl.itemId__c);
            				system.debug('-------------accessoryRes-------------------'+accessoryRes);
            				if(accessoryRes){
            					sl.totalperPeriodvalue__c = String.valueOf(Decimal.valueOf(sl.lineValue__c));
            				}else{
            					sl.totalperPeriodvalue__c = String.valueOf(Decimal.valueOf(sl.lineValue__c) * Decimal.valueOf(sl.quantity__c));
            				}
						}else{
							sl.totalperPeriodvalue__c = String.valueOf(Decimal.valueOf(sl.price__c) * Decimal.valueOf(sl.quantity__c));
						}
					}else{
						if(totalOneTimeCharges == null ){
							totalOneTimeCharges = Decimal.valueOf(sl.lineValue__c);
						}else{
							totalOneTimeCharges = totalOneTimeCharges + Decimal.valueOf(sl.lineValue__c);
						}
						sl.totalperPeriodvalue__c = sl.lineValue__c;
					}
				}
	    			
			}
			}
			
			if(prodExtList.size() > 0){
			for(Product_Extras__c HB : prodExtList){
				if(isSalesType == true){
					if(totalSalesCharat == null ){
    					totalSalesCharat = Decimal.valueOf(HB.total__c);
    				}else{
    					totalSalesCharat = totalSalesCharat + Decimal.valueOf(HB.total__c);
    				}
				}else{
	    				if(HB.description__c.startsWith('Delivery'))
		    			{
		    				if(totalOneTimeCharges == null){
		    					totalOneTimeCharges = Decimal.valueOf(HB.total__c);
		    				}else{
		    					totalOneTimeCharges = totalOneTimeCharges + Decimal.valueOf(HB.total__c);
		    				}
		    			}
		    			if(HB.description__c.startsWith('PickUp'))
		    			{
		    				if(totalOneTimeCharges == null){
		    					totalOneTimeCharges = Decimal.valueOf(HB.total__c);
		    				}else{
		    					totalOneTimeCharges = totalOneTimeCharges + Decimal.valueOf(HB.total__c);
		    				} 
		    			}
		    			if(HB.description__c.startsWith('Pick Up'))
		    			{
		    				if(totalOneTimeCharges == null){
		    					totalOneTimeCharges = Decimal.valueOf(HB.total__c);
		    				}else{
		    					totalOneTimeCharges = totalOneTimeCharges + Decimal.valueOf(HB.total__c);
		    				} 
		    			}
		    			if(HB.description__c.contains('Personal Property Expense'))
		    			{
		    				ppeValue = Decimal.valueOf(HB.total__c) / FullQuoteTransList.rentalLengthInProduct__c;
		    				if(FullQuoteTransList.quoteTotal__c == 'CT'){
	                        	ppeValue = Decimal.valueOf(HB.total__c);
	                        }
		    				ppeValue = ppeValue.setScale(2);
		    				if(totalRentalCharat == null){
		    					totalRentalCharat = ppeValue; 
		    				}else{
		    					totalRentalCharat = totalRentalCharat + ppeValue;
		    				}
		    				 
		    			}
		    			if(HB.description__c.contains('Loss Limitation Waiver'))
		    			{
		    				llwValue = Decimal.valueOf(HB.total__c) / FullQuoteTransList.rentalLengthInProduct__c;
			    			if(FullQuoteTransList.quoteTotal__c == 'CT'){
	                        	llwValue = Decimal.valueOf(HB.total__c);
	                        }
		    				llwValue = llwValue.setScale(2);
		    				if(totalRentalCharat == null){
		    					totalRentalCharat = llwValue;
		    				}else{
		    					totalRentalCharat = totalRentalCharat + llwValue;
		    				}
	    				
		    			}
		    			if(HB.description__c.startsWith('Fuel Surcharge'))
		    			{
		    				if(totalOneTimeCharges == null){
		    					totalOneTimeCharges = Decimal.valueOf(HB.total__c);
		    				}else{
		    					totalOneTimeCharges = totalOneTimeCharges + Decimal.valueOf(HB.total__c);
		    				}
		    			}
		    			if(HB.description__c.contains('Security Deposit'))
		    			{
		    				if(totalOneTimeCharges == null){
		    					totalOneTimeCharges = Decimal.valueOf(HB.total__c);
		    				}else{
		    					totalOneTimeCharges = totalOneTimeCharges + Decimal.valueOf(HB.total__c);
		    				}
		    			}
	    	 		}
			}
			}
			
	    	if(isSalesType == true){
	 			if(totalInitialCharges == null ){
 					totalInitialCharges = totalSalesCharat + Decimal.valueOf(salesTotal);
				}else{
					totalInitialCharges = totalInitialCharges + totalSalesCharat + Decimal.valueOf(salesTotal);
				}
	 		}else{
	 			if(totalInitialCharges == null ){
 					totalInitialCharges = totalRentalCharat + totalOneTimeCharges + Decimal.valueOf(salesTotal);
				}else{
					totalInitialCharges = totalInitialCharges + totalRentalCharat + totalOneTimeCharges + Decimal.valueOf(salesTotal);
				} 
	 		}
	    	 
				String fullfillingBranch = '';
		        if(FullQuoteTransList.shippingAddress_fulfillingBranchId__c != '' || FullQuoteTransList.shippingAddress_fulfillingBranchId__c != null){
		        	fullfillingBranch = '%'+FullQuoteTransList.shippingAddress_fulfillingBranchId__c+'%';
		        }else if(FullQuoteTransList.branchId__c != null && FullQuoteTransList.branchId__c != ''){
		        	fullfillingBranch = '%'+FullQuoteTransList.branchId__c+'%';
		    	}
		    	
		    	List<Weekly_Snapshot_Branch_Report__c> weekTempList = [Select w.Zipcode__c, w.Yard_Team__c, w.X5_days_Weather_Forecast__c, w.Weekly__c, w.Weekly_Sales__c, w.Weekly_Rentals__c, w.Warehouse_of_drivers__c, w.Warehouse_availabilty_of_containers__c, w.Warehouse_Zip_Code__c, w.Warehouse_Street__c, w.Warehouse_State__c, w.Warehouse_Other__c, w.Warehouse_Manager__c, w.Warehouse_Delivery_Printer__c, w.Warehouse_City__c, w.View__c, w.Tiltbed_Equiment__c, w.TSM__c, w.TSM_User__c, w.SystemModstamp, w.Street__c, w.Storage_Center__c, w.State__c, w.Sporting_Events_Teams__c, w.Spiff_Contests__c, w.Speacial_Events_Sunday_Paper_Style__c, w.Servicing_Branch__c, w.Result_Printer_for_Pick_up__c, w.Result_Printer_for_Deliveries__c, w.Re_market_Opporunities__c, w.Rate_Adjustments__c, w.Product_Discounts_sales__c, w.OwnerId, w.Other_Sellable_Inventory__c, w.Office_Manager__c, w.OSH_Rates__c, w.OSH_Priority_Capacity__c, w.Name, w.NSC_Market_Campaigns__c, w.NPS__c, w.Monthly_Branch_Goals__c, w.Modification_Info__c, w.Market_Value_Range_40__c, w.Market_Value_Range_40ZS__c, w.Market_Value_Range_40S__c, w.Market_Value_Range_20__c, w.Market_Value_Range_20ZS__c, w.Market_Value_Range_20S__c, w.Link_to_Local_Newspaper_2__c, w.Link_to_Local_Newspaper_1__c, w.LastModifiedDate, w.LastModifiedById, w.LastActivityDate, w.Large_Project_Commitments__c, w.Landolls_Equipment__c, w.IsDeleted, w.Inventory_Surplus__c, w.Inventory_Shortage__c, w.Inventory_Availability__c, w.Image_Id__c, w.Id, w.ISR__c, w.Fun_Facts_about_local_branch_team__c, w.Driver_Totals__c, w.Dispatcher__c, w.Delivery_Info__c, w.Customer_Pickup_Requests__c, w.Custom_Work_Options__c, w.Current_Days_to_get_Security_Office__c, w.CurrencyIsoCode, w.CreatedDate, w.CreatedById, w.County__c, w.Country__c, w.Climate_Controlled__c, w.Climate_Control_Info__c, w.City__c, w.Call_To_Action__c, w.Branch_Picture__c, w.Branch_Phone__c, w.Branch_Market_Campaigns__c, w.Branch_Manager__c, w.Branch_Manager_Notes__c, w.Avg_days_to_get_Security_Office_Ready__c, w.Average_Driver_Moves__c From Weekly_Snapshot_Branch_Report__c w where Servicing_Branch__c like : fullfillingBranch limit 1];
		    	if(weekTempList.size() > 0){
		    		weeklyBranchSnop = weekTempList[0]; 	
		    	}
		    	 
		}else{
			
		}
		return null;			
	}
	public Pagereference deleteQuoutId(String quoutid){
		system.debug('--quoutid-----'+quoutid);
		
		List<Full_Quote_Transactional__c> FullQuoteTransList = [Select id From Full_Quote_Transactional__c f where id=: quoutid limit 1];
		if(FullQuoteTransList.size() > 0 ){
			delete FullQuoteTransList;
		}
		return null;
	}
	public class wrapperSummaryLine{
		public Summary_Line__c summary{get;set;}
		public String totalperPeriodvalue {get;set;}
	}
}