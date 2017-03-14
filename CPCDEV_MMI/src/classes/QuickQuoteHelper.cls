/**************************************************************************
Name:  QuickQuoteHelper()
Copyright © 2013  MMI
----------------------------------------------------------------------
Purpose:
This is the helper class for the Quick Quote Controller
-----------------------------------------------------------------------
History:

VERSION  AUTHOR                 DATE        DETAIL              
1.0  -  TEKsystems             12/3/2013   INITIAL DEVELOPMENT  
**************************************************************************/
public with sharing class QuickQuoteHelper {
	
    /*******************************************************************
    Purpose     : To Calulate the Quick Quote Total
    Parameters  : None
    Returns     : None
    ********************************************************************/
    public void calculateTotal(QuickQuoteWrapper qqWrapper){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteHelper :calculateTotal'+ qqWrapper);

        try{
            if(qqWrapper!=null){
                
                if(qqWrapper.Rental_PP_E!=null&& qqWrapper.Quantity!=null&& qqWrapper.Rental_PP_E!='')
                {
                    qqWrapper.Rental_PP_E_Total = String.valueOf(Double.valueOf(qqWrapper.Rental_PP_E) * qqWrapper.Quantity);
                }
                if(qqWrapper.LLW!=null&& qqWrapper.Quantity!=null&& qqWrapper.LLW!='')
                {
                    qqWrapper.LLWTotal = String.valueOf(Double.valueOf(qqWrapper.LLW) * qqWrapper.Quantity);
                }
                if(qqWrapper.LocksAmount!=null&& qqWrapper.Quantity!=null&& qqWrapper.LocksAmount!='')
                {
                    qqWrapper.LocksAmountTotal = String.valueOf(Double.valueOf(qqWrapper.LocksAmount) * qqWrapper.Quantity);
                }
                if(qqWrapper.Tax!=null&& qqWrapper.Quantity!=null&& qqWrapper.Tax!='')
                {
                    qqWrapper.TaxTotal = String.valueOf(Double.valueOf(qqWrapper.Tax) * qqWrapper.Quantity);
                }
                if(qqWrapper.COD!=null&& qqWrapper.Quantity!=null&& qqWrapper.COD!='')
                {
                    qqWrapper.CODTotal = String.valueOf(Double.valueOf(qqWrapper.COD) * qqWrapper.Quantity);
                }
                if(qqWrapper.QuickQuote!=null&& qqWrapper.Quantity!=null&& qqWrapper.QuickQuote!='')
                {
                    qqWrapper.QuickQuoteTotal = String.valueOf(Double.valueOf(qqWrapper.QuickQuote) * qqWrapper.Quantity);
                }  
                if(qqWrapper.FuelSurcharge!=null&& qqWrapper.Quantity!=null&& qqWrapper.FuelSurcharge!='')
                {
                    qqWrapper.FuelSurchargeTotal = String.valueOf(Double.valueOf(qqWrapper.FuelSurcharge) * qqWrapper.Quantity);
                }
                
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteHelper calculateTotal:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Exiting to  QuickQuoteHelper : calculateTotal()'+qqWrapper);
       
    }
    
    /*******************************************************************
    Purpose     : To Calulate the Quick Quote Total after Refresh
    Parameters  : None
    Returns     : None
    ********************************************************************/
    public void calculateTotalAfterRefresh(HomeBaseBeans.quickQuoteRefresh d,QuickQuoteWrapper qqWrapper){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteHelper :calculateTotalAfterRefresh'+d+'------'+ qqWrapper);

        try{
            if(qqWrapper!=null && d!=null){
                 if(d.rentalPPETotal!=null)
                {
                        qqWrapper.Rental_PP_E = d.rentalPPETotal;
                       
                }
                if(d.llwTotal!=null)
                {
                        qqWrapper.LLW = d.llwTotal;
                       
                }
                if(d.locksTotal!=null)
                {
                        qqWrapper.LocksAmount = d.locksTotal;
                      
                }
                if(d.taxTotal!=null)
                {
                        qqWrapper.Tax = d.taxTotal;
                      
                }
                if(d.codAmount!=null)
                {
                      //  qqWrapper.COD = d.codAmount;
                      qqWrapper.COD=d.quickQuoteTotal;
                      
                }
                if(d.quickQuoteTotal!=null)
                {
                        qqWrapper.QuickQuote = d.quickQuoteTotal;
                      
                }  
                if(d.transport !=null)
                {
                        qqWrapper.transport = d.transport;
 
                }
                if(d.transportSurchargeTotal != null)
                {
                        qqWrapper.delFuelSurcharge = d.transportSurchargeTotal;
                        qqwrapper.FuelSurcharge=d.transportSurchargeTotal;
                     
                }
                if(d.pickupSurchargeTotal != null)
                {
                   qqWrapper.pickupFuelSurcharge = d.pickupSurchargeTotal;
                     
                }
                if(d.rate != null) 
                {
                        qqWrapper.rate = d.rate;
                }
                if(d.pickUpTotal != null && d.pickupSurchargeTotal != null)
                {   
                        qqWrapper.PickUp = String.valueOf(Double.valueOf(d.pickUpTotal)); 
                        qqWrapper.PickUpTotal = String.valueOf(Double.valueOf(d.pickUpTotal)+Double.valueOf(d.pickupSurchargeTotal));    
                }
                 if(d.reoccurringCharge!= null)
                {   
                        qqWrapper.RecurringMonthlyCharges = d.reoccurringCharge;    
                }
                qqWrapper.Delivery=String.valueOf(Double.valueOf(qqWrapper.transport));
                qqWrapper.DeliveryTotal=String.valueOf(Double.valueOf(qqWrapper.transport)+Double.valueOf(qqWrapper.delFuelSurcharge));
                
                
                String modificaitoncalc = '';
                if(qqWrapper.modificationTotal == null || qqWrapper.modificationTotal == ''){
                	modificaitoncalc = '0.00';
                }else{
                	modificaitoncalc = qqWrapper.modificationTotal;
                }
                
                if(qqWrapper.sellingPrice == null || qqWrapper.sellingPrice == ''){
                	qqWrapper.sellingPrice = '0.00';
                }
                
                qqWrapper.totalCost = String.valueOf(Decimal.valueOf(Double.valueOf(qqWrapper.Delivery)+Double.valueOf(modificaitoncalc) + Double.valueOf(qqWrapper.Tax) + Double.valueOf(qqWrapper.sellingPrice) +Double.valueOf(qqWrapper.LocksAmount)).setScale(2));
                
                // qqWrapper.DeliveryFuel = String.valueOf(Double.valueOf(qqWrapper.Delivery)+Double.valueOf(qqWrapper.FuelSurcharge));
                
                // qqWrapper.ReturnFuel = String.valueOf(Double.valueOf(qqWrapper.PickUp)+Double.valueOf(qqWrapper.FuelSurcharge));
              
                //  qqWrapper.RecurringMonthlyCharges = String.valueOf((Decimal.valueOf(qqWrapper.Rental_PP_E)/Decimal.valueOf(qqWrapper.Duration)).setScale(2) + Double.valueOf(qqWrapper.LLW) + Double.valueOf(qqWrapper.Tax));
                 
                //  Decimal recurringCharge=Decimal.valueOf(qqWrapper.RecurringMonthlyCharges).setScale(2);
                 
                // qqWrapper.OneTimeCharges = String.valueOf(Double.valueOf(qqWrapper.DeliveryFuel) + (Double.valueOf(qqWrapper.ReturnFuel)+Double.valueOf(qqWrapper.LocksAmount)));
                
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteHelper calculateTotalAfterRefresh:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Exiting to  QuickQuoteHelper : calculateTotalAfterRefresh()'+qqWrapper);
       
    }
    
    /*******************************************************************
    Purpose     : To Refresh the quick quote values 
    Parameters  : QuickQuoteWrapper,BranchId,validAddressId,reportdate
    Returns     : HomeBaseBeans.QuickQuoteRefreshFormat
    ********************************************************************/
    public HomeBaseBeans.QuickQuoteRefreshFormat refreshQQwrapper(QuickQuoteWrapper qqWrapper ,string BranchId, string validAddressId ,Date reportdate){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteHelper :refreshQQwrapper'+ qqWrapper);
        HomeBaseBeans.QuickQuoteRefreshFormat QQRF =null;
        try{
            if(qqWrapper!=null){
            	system.debug('-------qqWrapper.Address---------'+qqWrapper.Address);
            	qqWrapper.Address = removeSpecialCharacters(qqWrapper.Address);
            	system.debug('-------qqWrapper.Address---------'+qqWrapper.Address);
            	
                qqwrapper.DisplayErrorPopUp=false;
                 QQRF= new HomeBaseBeans.QuickQuoteRefreshFormat();                     
                 QQRF.Duration = Integer.valueOf(qqWrapper.Duration);
                 QQRF.Address = qqWrapper.Address;
                 QQRF.Delivery = qqWrapper.Delivery;
                 QQRF.tyleofQuoute = qqWrapper.tyleofQuoute; 
                 system.debug('-------QQRF.Delivery----'+QQRF.Delivery);
                 QQRF.TaxTotal = qqWrapper.TaxTotal;
                 QQRF.BranchId = BranchId;
                 QQRF.City = qqWrapper.City;
                 QQRF.State = qqWrapper.State;
                 QQRF.country = qqWrapper.country;
                 QQRF.Devzone = qqWrapper.DeveloperZone;
                 QQRF.FulfillingBranch = qqWrapper.FulfillingBranch;
                 QQRF.isFuelSurcharge= qqWrapper.isFuelSurcharge;
                 QQRF.isIncludeLLW = qqWrapper.isIncludeLLW;
                 QQRF.LeadOppName = qqWrapper.LeadOppName;
                 QQRF.Locks = qqWrapper.Locks;
                 QQRF.PrDate = reportdate;
                 QQRF.Product = qqWrapper.Product;
                 QQRF.Qty = qqWrapper.Quantity;
                 
                 if(qqWrapper.tyleofQuoute=='Rental'){
                   QQRF.Rate = qqWrapper.Rate;
                 }else{
                 	QQRF.Rate=qqWrapper.sellingPrice;
                 }
                 QQRF.State = qqWrapper.State;
                 QQRF.TaxId = validAddressId;
                 QQRF.TransactionType = qqWrapper.TransactionType;
                 QQRF.Transport = qqWrapper.Transport;
                 QQRF.zipcode = qqWrapper.zipcode;
                 //for sales quick quote
                 //QQRF.ecode=qqWrapper.ecode;
                 QQRF.ecode = '';
                 QQRF.modificationCharge=qqWrapper.modificationTotal;
            }
           
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteHelper refreshQQwrapper:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Exiting to  QuickQuoteHelper : refreshQQwrapper()'+QQRF);
        return QQRF;
    }
    
    /*******************************************************************
    Purpose     : To empty quick qoute wrapper
    Parameters  : QuickQuoteWrapper
    Returns     : None
    ********************************************************************/
    public void emptyQQWrapper(QuickQuoteWrapper qqWrapper){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteHelper :emptyQQWrapper'+ qqWrapper);
        try{
            if(qqWrapper!=null){
                qqWrapper.Rental_PP_E = '';qqWrapper.Rental_PP_E_Total='';qqWrapper.LLW='';qqWrapper.LLWTotal='';
                qqWrapper.LocksAmount='';qqWrapper.LocksAmountTotal='';qqWrapper.Tax='';qqWrapper.TaxTotal='';
                qqWrapper.COD='';qqWrapper.CODTotal='';qqWrapper.QuickQuote='';qqWrapper.QuickQuoteTotal='';
                qqWrapper.FuelSurcharge='';qqWrapper.FuelSurchargeTotal='';qqWrapper.DeliveryTotal='';qqWrapper.Delivery='';
                qqWrapper.transport = '';
                qqWrapper.DeliveryFuel = '';
                qqWrapper.DeliveryFuelTotal = '';
                
                qqWrapper.ReturnFuel = '';
                qqWrapper.ReturnFuelTotal = '';
                
                qqWrapper.RecurringMonthlyCharges = '';
                qqWrapper.RecurringMonthlyChargesTotal = '';
                
                qqWrapper.OneTimeCharges = '';
                qqWrapper.OneTimeChargesTotal = ''; 
                qqWrapper.PickUp = '';
                qqWrapper.PickUpTotal = '';
                qqWrapper.delFuelSurcharge='';
                qqWrapper.pickupFuelSurcharge='';
                qqWrapper.netBookValue='';
                qqWrapper.marketValue='';
                qqWrapper.modificationTotal='';
                qqWrapper.branchGross='';
                qqWrapper.totalCost='';
                qqWrapper.sellingPrice='';
                
              
            }
           
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteHelper emptyQQWrapper:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Exiting to  QuickQuoteHelper : emptyQQWrapper()');
    }
    
    /*******************************************************************
    Purpose     : To assign LoadWBs Edit  quick qoute wrapper
    Parameters  : QuickQuoteWrapper ,MMI_Quotes__c object
    Returns     : None
    ********************************************************************/
    public void assignValuesLoadWBsEditQuote(QuickQuoteWrapper qqWrapper,MMI_Quotes__c MMIRef ,MMI_Quotes__c proRef ,string validAddressId){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteHelper :assignValuesLoadWBsEditQuote'+ qqWrapper+''+MMIRef);
        try{
            if(qqWrapper!=null && MMIRef!=null){	
                qqWrapper.BranchId = MMIRef.Branch_id__c;
				qqWrapper.City = MMIRef.City__c ;
				proRef.Date_From__c = MMIRef.Date_From__c ;
				proRef.QQ_Type__c = MMIRef.QQ_Type__c ;
				qqWrapper.Product = MMIRef.Product__c ;
				qqWrapper.ZipCode = MMIRef.Zip_Code__c ;
				qqWrapper.Address = MMIRef.Address__c ;
				qqWrapper.State = MMIRef.State__c;
				qqWrapper.Country = MMIRef.Country__c;
				qqWrapper.COD = String.valueOf(MMIRef.COD__c); 
				qqWrapper.CODTotal = String.valueOf(MMIRef.COD_Total__c); 
				qqWrapper.Delivery = String.valueOf(MMIRef.Delivery__c); 
				qqWrapper.DeliveryTotal = String.valueOf(MMIRef.Delivery_Total__c); 
                                qqWrapper.DeveloperZone=MMIRef.DeliveryZone__c;
				qqWrapper.Duration= String.valueOf(MMIRef.Duration__c); 
				qqWrapper.isFuelSurcharge= MMIRef.Fuel_surcharge__c ; 
				qqWrapper.delFuelSurcharge= String.valueOf(MMIRef.Fuel_Surcharge_N__c); 
				qqWrapper.pickupFuelSurcharge= String.valueOf(MMIRef.Fuel_Surcharge_Total__c); 
				qqWrapper.FulfillingBranch = MMIRef.Fulfilling_Branch__c ; 
				qqWrapper.isIncludeLLW= MMIRef.Include_LLW__c ; 
				qqWrapper.LLW = String.valueOf(MMIRef.LLW__c); 
				qqWrapper.LLWTotal = String.valueOf(MMIRef.LLW_Total__c); 
				qqWrapper.Locks= Integer.valueOf(MMIRef.Locks__c) ; 
				qqWrapper.LocksAmount = String.valueOf(MMIRef.Locks_N__c); 
				qqWrapper.LocksAmountTotal = String.valueOf(MMIRef.Locks_Total__c); 
				qqWrapper.PickUp = String.valueOf(MMIRef.Pick_Up__c); 
				qqWrapper.PickUpTotal = String.valueOf(MMIRef.Pick_Up_Total__c); 
				qqWrapper.Quantity= Integer.valueOf(MMIRef.Qty__c) ; 
				qqWrapper.QuickQuote = String.valueOf(MMIRef.Quick_Quote__c); 
				qqWrapper.QuickQuoteTotal = String.valueOf(MMIRef.Quick_Quote_Total__c);
				qqWrapper.Rental_PP_E = String.valueOf(MMIRef.Rental_PP_E__c); 
				qqWrapper.Rental_PP_E_Total = String.valueOf(MMIRef.Rental_PP_E_Total__c); 
				qqWrapper.Rate = String.valueOf(MMIRef.Rental_Rate__c); 
				qqWrapper.Tax = String.valueOf(MMIRef.Tax__c);
				validAddressId= MMIRef.Tax_id__c ;
				//qqWrapper.TaxTotal = String.valueOf(MMIRef.Tax_Total__c); 
				qqwrapper.totalTax = String.valueOf(MMIRef.Tax_Total__c);
				qqWrapper.Transport = String.valueOf(MMIRef.Transport_Costs__c); 
				qqWrapper.TransactionType= MMIRef.Transaction_Type__c ;
				
				qqWrapper.RecurringMonthlyCharges = String.valueOf(MMIRef.Reoccurring_Monthly_Charges__c);
		        qqWrapper.CrossStreets = MMIRef.Cross_Streets__c;
		        qqWrapper.distanceFromBranch = MMIRef.Distance_from_branch__c;
		        
		        qqWrapper.suggestedPrice = String.valueOf(MMIRef.Suggested_Price__c);
		        qqWrapper.sellingPrice = String.valueOf(MMIRef.Selling_Price__c);
		        qqWrapper.ecode =MMIRef.Ecode__c;
		        qqWrapper.modificationTotal = String.valueOf(MMIRef.Modification_Charge__c);
     	        qqWrapper.sellingPrice = String.valueOf(MMIRef.Selling_Price__c);
     	        qqWrapper.totalCost = String.valueOf(MMIRef.Quick_Quote_Total__c);
     	        qqWrapper.minimumPrice = String.valueOf(MMIRef.Minimum_Price__c);
            }
           
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteHelper assignValuesLoadWBsEditQuote:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Exiting to  QuickQuoteHelper : assignValuesLoadWBsEditQuote()'+qqWrapper);
    }
    
    /*******************************************************************
    Purpose     : To get the rate for All duration
    Parameters  : None
    Returns     : None
    ********************************************************************/
    public void assignSelectedProdRate(QuickQuoteWrapper qqWrapper ,QuickQuoteMainController_AC.InnerProductClass productDetail){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteHelper :assignSelectedProdRate'+qqWrapper +'--'+productDetail);
        integer duration=0;
        try{
        	if(qqWrapper!=null && productDetail!=null){
	           qqWrapper.Product = productDetail.PID;
	           
	            qqWrapper.Rate1 = productDetail.PRate1;
	          
	           	qqWrapper.Rate2 = productDetail.PRate2;
	         
	           	qqWrapper.Rate3 = productDetail.PRate3;
	          
	           	qqWrapper.Rate4 = productDetail.PRate4;
	           	qqWrapper.Rate5 = productDetail.PRate5;
	           	qqWrapper.Rate7 = productDetail.PRate7;
	         
        	} 
          
          
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteHelper assignSelectedProdRate:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Exiting to  QuickQuoteHelper : assignSelectedProdRate()'+qqWrapper);
       
    }
    /*******************************************************************
    Purpose     : To get the rate for perticuler duration
    Parameters  : None
    Returns     : None
    ********************************************************************/
    public void getDurationRate(QuickQuoteWrapper qqWrapper){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteHelper :getDurationRate'+qqWrapper);
        integer duration=0;
        try{
        	if(qqWrapper.Duration==null){
        		qqWrapper.Duration='1';
        	}
        	if(qqWrapper!=null && qqWrapper.Product!=null && qqWrapper.Product!=''&& qqWrapper.Duration!=null ){
	           duration=integer.valueOf(qqWrapper.Duration);
	           if(qqWrapper.TransactionType != 'MOBO' && qqWrapper.TransactionType != 'SECO'){
	           if(duration==1){
	            qqWrapper.Rate=qqWrapper.Rate1;
	           }else if(duration>=2 && duration <=6){
	           qqWrapper.Rate=qqWrapper.Rate2;
	           }else if(duration>=7 && duration <=12){
	            qqWrapper.Rate=qqWrapper.Rate3;
	           }else{
	           	 qqWrapper.Rate=qqWrapper.Rate4;
	           }
	           }else{
	           		if(duration>=2 && duration <=6){
		         		qqWrapper.Rate=qqWrapper.Rate1;
		           	}else if(duration>=7 && duration <=12){
		           		qqWrapper.Rate=qqWrapper.Rate2;
		           	}else if(duration>=13 && duration <=24){
		           		qqWrapper.Rate=qqWrapper.Rate3;
		           	}else{
						qqWrapper.Rate=qqWrapper.Rate4;
		           }
	           }
        	} 

        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteHelper getDurationRate:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Exiting to  QuickQuoteHelper : getDurationRate()'+qqWrapper);
       
    }
     /*******************************************************************
    Purpose     : To get the rate for All duration
    Parameters  : None
    Returns     : None
    ********************************************************************/
    public void assignSelectedProdRateEdit(QuickQuoteWrapper qqWrapper ,QuickQuoteForm_Edit_AC.InnerProductClass productDetail){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteHelper :assignSelectedProdRateEdit'+qqWrapper +'--'+productDetail);
        integer duration=0;
        try{
        	if(qqWrapper!=null && productDetail!=null){
	           qqWrapper.Product = productDetail.PID;
	           
	            qqWrapper.Rate1=productDetail.PRate1;
	          
	           	qqWrapper.Rate2=productDetail.PRate2;
	         
	           	qqWrapper.Rate3=productDetail.PRate3;
	          
	           	qqWrapper.Rate4 = productDetail.PRate4;
	           	qqWrapper.Rate5 = productDetail.PRate5;
	           	qqWrapper.Rate7 = productDetail.PRate7;
	         
        	} 
          
          
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteHelper assignSelectedProdRateEdit:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Exiting to  QuickQuoteHelper : assignSelectedProdRateEdit()'+qqWrapper);
       
    }
    /*******************************************************************
    Purpose     : To get the rate for All duration
    Parameters  : None
    Returns     : None
    ********************************************************************/
    public void assignSelectedProdRateSales(QuickQuoteWrapper qqWrapper ,QuickQuoteWrapper.InnerProductClass productDetail){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteHelper :assignSelectedProdRateSales'+qqWrapper +'--'+productDetail);
        integer duration=0;
        try{
        	if(qqWrapper!=null && productDetail!=null){
	           qqWrapper.Product = productDetail.PID;
	           
	            qqWrapper.Rate1=productDetail.PRate1;
	          
	           	qqWrapper.Rate2=productDetail.PRate2;
	         
	           	qqWrapper.Rate3=productDetail.PRate3;
	          
	           	qqWrapper.Rate4=productDetail.PRate4;
	         
        	} 
          
          
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteHelper assignSelectedProdRateSales:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Exiting to  QuickQuoteHelper : assignSelectedProdRateSales()'+qqWrapper);
       
    }
     /*******************************************************************
    Purpose     : To get the rate for All duration for sales edit 
    Parameters  : None
    Returns     : None
    ********************************************************************/
   public void assignSelectedProdRatesalesEdit(QuickQuoteWrapper qqWrapper ,QuickQuoteSales_Edit.InnerProductClass productDetail){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteHelper :assignSelectedProdRateEdit'+qqWrapper +'--'+productDetail);
        integer duration=0;
        try{
        	if(qqWrapper!=null && productDetail!=null){
	           qqWrapper.Product = productDetail.PID;
	           
	            qqWrapper.Rate1=productDetail.PRate1;
	          
	           	qqWrapper.Rate2=productDetail.PRate2;
	         
	           	qqWrapper.Rate3=productDetail.PRate3;
	          
	           	qqWrapper.Rate4=productDetail.PRate4;
	         
        	} 
          
          
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteHelper assignSelectedProdRateEdit:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Exiting to  QuickQuoteHelper : assignSelectedProdRateEdit()'+qqWrapper);
       
    }
    
    
    /*******************************************************************
    Purpose     : To assign LoadWBs Edit  quick qoute wrapper
    Parameters  : QuickQuoteWrapper ,MMI_Quotes__c object
    Returns     : None
    ********************************************************************/
    public void assignValuesLoadWBsEditSalesQuote(QuickQuoteWrapper qqWrapper,MMI_Quotes__c MMIRef ,MMI_Quotes__c proRef ,string validAddressId,EditSalesQuickQuoteWrap quickQuoteWrap){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteHelper :assignValuesLoadWBsEditSalesQuote'+ qqWrapper+''+quickQuoteWrap);
        try{
        	
        
            if(qqWrapper!=null && quickQuoteWrap!=null){	
                qqWrapper.BranchId = quickQuoteWrap.branchId;
				qqWrapper.City = quickQuoteWrap.shippingAddress3.address3;
				//
				proRef.Date_From__c = MMIRef.Date_From__c ;
				proRef.QQ_Type__c = MMIRef.QQ_Type__c ;
				
				qqWrapper.Product = quickQuoteWrap.productId;

				qqWrapper.ZipCode = quickQuoteWrap.shippingAddress3.zipCode;
				qqWrapper.Address = quickQuoteWrap.shippingAddress3.address1;
				qqWrapper.State = quickQuoteWrap.shippingAddress3.state;
				qqWrapper.Country = quickQuoteWrap.shippingAddress3.countryId;
				qqWrapper.FulfillingBranch = quickQuoteWrap.shippingAddress3.fulfillingBranchId;
				qqWrapper.CrossStreets =quickQuoteWrap.shippingAddress3.crossStreet1;
				if(MMIRef.DeliveryZone__c != null && MMIRef.DeliveryZone__c != ''){
					qqWrapper.DeveloperZone= MMIRef.DeliveryZone__c;	
				}
		        if(MMIRef.Distance_from_branch__c != null && MMIRef.Distance_from_branch__c != ''){
					qqWrapper.distanceFromBranch= MMIRef.Distance_from_branch__c;	
				}
			    qqWrapper.ecode =quickQuoteWrap.ecode;
				qqWrapper.COD = quickQuoteWrap.codAmount;
				qqWrapper.CODTotal = quickQuoteWrap.codAmount;
				qqWrapper.Delivery =  String.valueOf(decimal.valueOf(quickQuoteWrap.transport)+decimal.valueOf(quickQuoteWrap.transportSurchargeTotal));
				qqWrapper.DeliveryTotal = String.valueOf(decimal.valueOf(quickQuoteWrap.transport)+decimal.valueOf(quickQuoteWrap.transportSurchargeTotal)); 
				qqWrapper.Duration= quickQuoteWrap.duration;
				qqWrapper.isFuelSurcharge= quickQuoteWrap.fuelSurcharge;
				qqWrapper.delFuelSurcharge= quickQuoteWrap.transportSurchargeTotal;
				qqwrapper.FuelSurcharge=quickQuoteWrap.transportSurchargeTotal;
				qqWrapper.pickupFuelSurcharge= quickQuoteWrap.pickupSurchargeTotal;
				
				qqWrapper.isIncludeLLW=quickQuoteWrap.includeLLW;
				qqWrapper.LLW = quickQuoteWrap.llwTotal;
				qqWrapper.LLWTotal = quickQuoteWrap.llwTotal;
				qqWrapper.Locks= Integer.valueOf(quickQuoteWrap.locksQty) ; 
				qqWrapper.LocksAmount = quickQuoteWrap.locksTotal; 
				qqWrapper.LocksAmountTotal = quickQuoteWrap.locksTotal;
				 
				qqWrapper.PickUp = quickQuoteWrap.pickUpTotal;
				qqWrapper.PickUpTotal = quickQuoteWrap.pickUpTotal;
				qqWrapper.Quantity= Integer.valueOf(MMIRef.Qty__c) ; 
				
				qqWrapper.QuickQuote = quickQuoteWrap.quickQuoteTotal;
				qqWrapper.QuickQuoteTotal = quickQuoteWrap.quickQuoteTotal;
				
				qqWrapper.Rental_PP_E = quickQuoteWrap.rentalPPETotal;
				qqWrapper.Rental_PP_E_Total = quickQuoteWrap.rentalPPETotal;
				
				qqWrapper.Rate = quickQuoteWrap.rate;
				qqWrapper.Tax = quickQuoteWrap.taxTotal;
				
				validAddressId= quickQuoteWrap.shippingAddress3.taxId;
				qqwrapper.TaxId =quickQuoteWrap.shippingAddress3.taxId;
				//qqWrapper.TaxTotal = String.valueOf(MMIRef.Tax_Total__c); 
				qqwrapper.totalTax = quickQuoteWrap.taxTotal;
				
				qqWrapper.Transport = quickQuoteWrap.transport;
				qqWrapper.TransactionType= quickQuoteWrap.transactionId;
				//qqWrapper.RecurringMonthlyCharges = String.valueOf(MMIRef.Reoccurring_Monthly_Charges__c);
		    
		        
		        qqWrapper.suggestedPrice = String.valueOf(MMIRef.Suggested_Price__c);
		        qqWrapper.minimumPrice = String.valueOf(MMIRef.Minimum_Price__c);
		        
		        
		        qqWrapper.sellingPrice = quickQuoteWrap.rate;
		        qqWrapper.modificationTotal = quickQuoteWrap.modificationCharge;
     	        qqWrapper.totalCost = quickQuoteWrap.quickQuoteTotal;
     	        
            }
           
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteHelper assignValuesLoadWBsEditSalesQuote:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Exiting to  QuickQuoteHelper : assignValuesLoadWBsEditSalesQuote()'+qqWrapper);
    }
	public String removeSpecialCharacters(String InputString){
     		if(InputString != null || InputString == ''){
	     		InputString = InputString.trim();
	     		InputString = InputString.replace('"', '\\"');
	     		InputString = InputString.replace('\n', ' ');
	     		InputString = InputString.replace('<br/>', ' ');
	     		InputString = InputString.replace('\r', ' ');
    
	     		return InputString;
     		}else{
     			return '';
     		}
     	}    
    
}