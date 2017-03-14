/**************************************************************************
Name:  QuickQuoteMainService()
Copyright © 2013  MMI
----------------------------------------------------------------------
Purpose:
This class is service layer between controller and database 
-----------------------------------------------------------------------
History:

VERSION  AUTHOR                 DATE        DETAIL              
1.0  -  TEKsystems             11/2/2013   INITIAL DEVELOPMENT  
**************************************************************************/
public with sharing class QuickQuoteMainService {
    
    /*********************************************************************
    Purpose     : To get Users Branch info   
    Parameters  : none 
    Returns     : Branch id 
    **********************************************************************/
    public string getuserBranchInfo(){
        system.debug(LoggingLevel.DEBUG,'Entring to  QuickQuoteMainService : getuserInfo'); 
        User userInfo=null;
        try{
            //invoke DAO mathod to get profile detail
             userInfo=QuickQuoteMainDAO.getUserBranchDetails();
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting QuickQuoteMainService  getuserInfo:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to   QuickQuoteMainService : getuserInfo()'+userInfo);
        return userInfo.Branch_Id__c;
    
    }
    /*********************************************************************
    Purpose     : To get Users Branch info
    Parameters  : none 
    Returns     : Branch id 
    **********************************************************************/
    public string getuserSalesRepId(){
        system.debug(LoggingLevel.DEBUG,'Entring to  QuickQuoteMainService : getuserSalesRepId'); 
        User userInfo=null;
        try{
            //invoke DAO mathod to get profile detail
             userInfo=QuickQuoteMainDAO.getUserBranchDetails();
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting QuickQuoteMainService  getuserSalesRepId:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to   QuickQuoteMainService : getuserSalesRepId()'+userInfo);
        return userInfo.Sales_Rep_Id__c;
    
    }
    
    /*********************************************************************
    Purpose     : To get Lead info
    Parameters  : lead id 
    Returns     :list of  Lead object
    **********************************************************************/
    public List<Lead> getLeadinfo(String leadRecID){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainService :getLeadinfo');
        List<Lead> leadRec=null;
        try{
            if(leadRecID!=null){
                leadRec=QuickQuoteMainDAO.getLeadRecord(leadRecID);
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainService getLeadinfo:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  QuickQuoteMainService : getLeadinfo()'+leadRec);
        
        return leadRec;
    }
    
    /*********************************************************************
    Purpose     : To get opportunity info
    Parameters  : lead id 
    Returns     : list of Opportunity object
    **********************************************************************/
    public List<Opportunity> getOppInfo(String leadRecID){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainService :getOppInfo');
        List<Opportunity> oppRec=null;
        try{
            if(leadRecID!=null){
                oppRec=QuickQuoteMainDAO.getOppRecord(leadRecID);
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainService getOppInfo:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  QuickQuoteMainService : getOppInfo()'+oppRec);
        
        return oppRec;
    }
    
    /*********************************************************************
    Purpose     : To get Account info
    Parameters  : Account Id 
    Returns     : Account object
    **********************************************************************/
    public Account getAccInfo(String accID){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainService :getAccInfo');
        Account accRec=null;
        try{
            if(accID!=null){
                accRec=QuickQuoteMainDAO.getAccRecord(accID);
                
            }   
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainService getAccInfo:'+e.getMessage());
        }
         system.debug(LoggingLevel.DEBUG,'Entring to  QuickQuoteMainService : getAccInfo()'+accRec);
        
        return accRec;
    }
   
    /*********************************************************************
    Purpose     : To get convert the existing lead
    Parameters  : lead id and owner id 
    Returns     : Lead conversion result
    **********************************************************************/
    public Database.LeadConvertResult getConvertLeadResult(String leadId , String ownerId, QuickQuoteWrapper qqwrapper){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainService :getConvertLeadResult'+leadId + ownerId);
        Database.LeadConvertResult leadConverResult=null;
        try{
            if(leadId!=null && ownerId!=null){
                leadConverResult=QuickQuoteMainDAO.convertLead(leadId, ownerId, qqwrapper);
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainService getConvertLeadResult:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  QuickQuoteMainService : getConvertLeadResult()'+leadConverResult);
        
        return leadConverResult;
    }
    
    /*********************************************************************
    Purpose     : To insert quick quote record
    Parameters  :MMI_Quotes__c objct, branch id,report date,validate address id,opportunity id
                 quote id,QuickQuoteWrapper
    Returns     : Opportunity id
    **********************************************************************/
    public String insertQuickQuoteRecord(MMI_Quotes__c insertQuote, String branchId ,Date reportDate ,String validAddressId,String opportunityID, String quoteID, QuickQuoteWrapper qqwrapper,String accountID){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainService :insertQuickQuoteRecord');
        String oppID=null;
        try{
            if(insertQuote!=null && branchId!=null && reportDate!=null && opportunityID!=null && quoteID!=null && qqwrapper!=null && accountID!=null){
                
                insertQuote.Account__c=accountID;
                insertQuote.Branch_id__c = branchId;
                insertQuote.City__c = qqwrapper.City;
                insertQuote.Name = 'Rental';
                insertQuote.Date_From__c = reportDate;
                insertQuote.Create_Date__c=system.today();
                insertQuote.Start_Date__c=reportDate;
                insertQuote.Opportunity__c = opportunityID;
                insertQuote.Product__c = qqwrapper.Product;
                insertQuote.Quote_Id__c = quoteID;
                insertQuote.State__c = qqwrapper.State;
                insertQuote.Status__c = 'Active';
                insertQuote.Zip_Code__c = qqwrapper.ZipCode;
                insertQuote.Address__c = qqwrapper.Address;
                insertQuote.Country__c = qqwrapper.Country;
                insertQuote.Branch_id__c = branchId;
                insertQUote.COD__c = Double.valueOf(qqwrapper.COD);
                insertQuote.COD_Total__c = Double.valueOf(qqwrapper.COD);
                insertQuote.Delivery__c = Double.valueOf(qqwrapper.DeliveryTotal) - Double.valueOf(qqWrapper.delFuelSurcharge);
                insertQUote.Delivery_Total__c = Double.valueOf(qqwrapper.DeliveryTotal);
                insertQUote.DeliveryZone__c=qqwrapper.DeveloperZone;
                insertQuote.Duration__c = qqwrapper.Duration;
                insertQuote.Fuel_surcharge__c = qqwrapper.isFuelSurcharge;
                insertQUote.Fuel_Surcharge_N__c = Double.valueOf(qqWrapper.delFuelSurcharge);
                insertQUote.Fuel_Surcharge_Total__c = Double.valueOf(qqWrapper.pickupFuelSurcharge);
                insertQuote.Fulfilling_Branch__c = branchId;
                insertQuote.Include_LLW__c = qqwrapper.isIncludeLLW;
                insertQuote.LLW__c = Double.valueOf(qqwrapper.LLW);
                insertQuote.LLW_Total__c = Double.valueOf(qqwrapper.LLW);
                insertQuote.Locks__c = qqwrapper.Locks;
                insertQuote.Locks_N__c = Double.valueOf(qqwrapper.LocksAmount);
                insertQuote.Locks_Total__c = Double.valueOf(qqwrapper.LocksAmount);
                insertQuote.Pick_Up__c = Double.valueOf(qqwrapper.PickUpTotal) - Double.valueOf(qqwrapper.pickupFuelSurcharge);
                insertQUote.Pick_Up_Total__c = Double.valueOf(qqwrapper.PickUpTotal);
                insertQuote.Qty__c = qqwrapper.Quantity;
                
                /*if(qqWrapper.TransactionType == 'SECO'){
	                insertQuote.Quick_Quote__c = Double.valueOf(qqwrapper.QuickQuote) + decimal.valueOf(qqWrapper.securityDeposit);
	                insertQuote.Quick_Quote_Total__c = Double.valueOf(qqwrapper.QuickQuote) + decimal.valueOf(qqWrapper.securityDeposit);
                }else{*/
                	insertQuote.Quick_Quote__c = Double.valueOf(qqwrapper.COD);
                	insertQuote.Quick_Quote_Total__c = Double.valueOf(qqwrapper.COD);
                //}
                
                
                insertQuote.Rental_PP_E__c = Double.valueOf(qqwrapper.Rental_PP_E);
                insertQuote.Rental_PP_E_Total__c = Double.valueOf(qqwrapper.Rental_PP_E);
                insertQuote.Rental_Rate__c = Double.valueOf(qqwrapper.Rate);
                insertQuote.Tax__c = Double.valueOf(qqwrapper.Tax); 
                insertQuote.Tax_id__c = validAddressId;
                insertQuote.Tax_Total__c = Double.valueOf(qqwrapper.Tax);
                insertQuote.Transport_Costs__c = Double.valueOf(qqwrapper.Transport);
                insertQuote.Transaction_Type__c = qqwrapper.TransactionType;
                insertQuote.Reoccurring_Monthly_Charges__c = Double.valueOf(qqwrapper.RecurringMonthlyCharges);
                insertQuote.Cross_Streets__c = qqwrapper.CrossStreets;
                insertQuote.Distance_from_branch__c = qqwrapper.distanceFromBranch;
                insertQuote.QQ_Type__c = 'Rental';
                //---FOR CAPACITY LOOKUP----
                insertQuote.Longitude__c = qqwrapper.longitudeToInsert;
                insertQuote.Latitude__c = qqwrapper.latitudeToInsert;
                insertQuote.Product_description__c = qqwrapper.productDescToInsert;
        		//-----FOR QQ FROM JP--------------------------------------------
        		system.debug('------qqwrapper.jobProfileId-------'+qqwrapper.jobProfileId);
        		insertQuote.Job_Profile__c = qqwrapper.jobProfileId;
        		system.debug('------insertQuote.Job_Profile__c--------'+insertQuote.Job_Profile__c);
        		if(qqWrapper.TransactionType == 'SECO'){
        			insertQuote.Security_Deposit__c = Decimal.valueOf(qqwrapper.securityDeposit);
        		}else{
        			insertQuote.Security_Deposit__c = 00.00;
        		}
        		
        		insertQuote.Recurring_Tax__c = Decimal.valueOf(qqWrapper.ExtraRecurringTax);
        		insertQuote.Unit_Type__c = qqWrapper.unitType;
        		
                oppID=QuickQuoteMainDAO.insertQuickQuote(insertQuote);
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainService insertQuickQuoteRecord:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  QuickQuoteMainService : insertQuickQuoteRecord()'+oppID);
        
        return oppID;
    }
     
     
       /*********************************************************************
    Purpose     : To insert quick quote sales record
    Parameters  :MMI_Quotes__c objct, branch id,report date,validate address id,opportunity id
                 quote id,QuickQuoteWrapper
    Returns     : Opportunity id
    **********************************************************************/
    public String insertQuickQuoteSalesRecord(MMI_Quotes__c insertQuote, String branchId ,Date reportDate ,String validAddressId,String opportunityID, String quoteID, QuickQuoteWrapper qqwrapper,String accountID){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainService :insertQuickQuoteSalesRecord');
        String oppID=null;
        try{ 
            if(insertQuote!=null && branchId!=null && reportDate!=null && opportunityID!=null && quoteID!=null && qqwrapper!=null && accountID!=null){
                
                insertQuote.Account__c=accountID;
                insertQuote.City__c = qqwrapper.City;
                insertQuote.Name = 'Sales';
                insertQuote.DeliveryZone__c=qqwrapper.DeveloperZone;
                insertQuote.Date_From__c = reportDate;
                insertQuote.Create_Date__c=system.today();
                insertQuote.Start_Date__c=reportDate;
                insertQuote.Opportunity__c = opportunityID;
                insertQuote.Product__c = qqwrapper.Product;
                insertQuote.Quote_Id__c = quoteID;
                insertQuote.State__c = qqwrapper.State;
                insertQuote.Status__c = 'Active';
                insertQuote.Zip_Code__c = qqwrapper.ZipCode;
                insertQuote.Address__c = qqwrapper.Address;
                insertQuote.Country__c = qqwrapper.Country;
                insertQuote.Branch_id__c = branchId;
                insertQuote.Delivery__c = Double.valueOf(qqwrapper.Delivery);
                insertQUote.Delivery_Total__c = Double.valueOf(qqwrapper.DeliveryTotal);
                insertQuote.Duration__c = qqWrapper.Duration;
                insertQuote.Fuel_surcharge__c = qqwrapper.isFuelSurcharge;
                insertQUote.Fuel_Surcharge_N__c = Double.valueOf(qqWrapper.delFuelSurcharge);
                insertQUote.Fuel_Surcharge_Total__c = Double.valueOf(qqWrapper.pickupFuelSurcharge);
                insertQuote.Fulfilling_Branch__c = branchId;
                insertQuote.Include_LLW__c = qqwrapper.isIncludeLLW;
                insertQuote.LLW__c = Double.valueOf(qqwrapper.LLW);
                insertQuote.LLW_Total__c = Double.valueOf(qqwrapper.LLW);
                insertQuote.Locks__c = qqwrapper.Locks;
                insertQuote.Locks_N__c = Double.valueOf(qqwrapper.LocksAmount);
                insertQuote.Locks_Total__c = Double.valueOf(qqwrapper.LocksAmount);
                insertQuote.Pick_Up__c = Double.valueOf(qqwrapper.PickUp);
                insertQUote.Pick_Up_Total__c = Double.valueOf(qqwrapper.PickUpTotal);
                insertQuote.Qty__c = qqwrapper.Quantity;
                insertQuote.Quick_Quote__c = Double.valueOf(qqwrapper.QuickQuote);
                insertQuote.Rental_PP_E__c = Double.valueOf(qqwrapper.Rental_PP_E);
                insertQuote.Rental_PP_E_Total__c = Double.valueOf(qqwrapper.Rental_PP_E);
                insertQuote.Rental_Rate__c = Double.valueOf(qqwrapper.Rate);
                insertQuote.Tax__c = Double.valueOf(qqwrapper.Tax); 
                insertQuote.Tax_id__c = validAddressId;
                insertQuote.Transport_Costs__c = Double.valueOf(qqwrapper.Transport);
                insertQuote.Transaction_Type__c = qqwrapper.TransactionType;
                //insertQuote.Reoccurring_Monthly_Charges__c = Double.valueOf(qqwrapper.RecurringMonthlyCharges);
                insertQuote.Cross_Streets__c = qqwrapper.CrossStreets;
                insertQuote.Distance_from_branch__c = qqwrapper.distanceFromBranch;
                
                if(qqwrapper.Tax != null && qqwrapper.Tax != ''){
                	insertQuote.Tax_Total__c = Double.valueOf(qqwrapper.Tax);
                }
                if(qqwrapper.suggestedPrice != null && qqwrapper.suggestedPrice != ''){
                	insertQuote.Suggested_Price__c = Double.valueOf(qqwrapper.suggestedPrice);
                }
                if(qqwrapper.minimumPrice != null && qqwrapper.minimumPrice != ''){
                	insertQuote.Minimum_Price__c = Double.valueOf(qqwrapper.minimumPrice);
                }
                if(qqwrapper.modificationTotal == null || qqwrapper.modificationTotal == ''){
                	qqwrapper.modificationTotal = '0.00';
                }
                if(qqwrapper.modificationTotal != null && qqwrapper.modificationTotal != ''){
                	insertQuote.Modification_Charge__c = Double.valueOf(qqwrapper.modificationTotal);
                }
                if(qqwrapper.sellingPrice != null && qqwrapper.sellingPrice != ''){
               		 insertQuote.Selling_Price__c = Double.valueOf(qqwrapper.sellingPrice);
                }
                if(qqWrapper.totalCost != null && qqWrapper.totalCost != ''){
                	insertQuote.Quick_Quote_Total__c = Double.valueOf(qqwrapper.totalCost);
                }
                insertQuote.Ecode__c = qqwrapper.ecode; 
                insertQuote.QQ_Type__c = 'Sales';
                //---FOR CAPACITY LOOKUP----
                insertQuote.Longitude__c = qqwrapper.longitudeToInsert;
                insertQuote.Latitude__c = qqwrapper.latitudeToInsert;
                insertQuote.Product_description__c = qqwrapper.productDescToInsert;
                //-----FOR QQ FROM JP--------------------------------------------
                insertQuote.Unit_Type__c = qqWrapper.unitType;
        		system.debug('------qqwrapper.jobProfileId-------'+qqwrapper.jobProfileId);
        		insertQuote.Job_Profile__c = qqwrapper.jobProfileId;
        		system.debug('------insertQuote.Job_Profile__c--------'+insertQuote.Job_Profile__c);
                oppID=QuickQuoteMainDAO.insertQuickQuote(insertQuote);
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainService insertQuickQuoteRecord:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  QuickQuoteMainService : insertQuickQuoteRecord()'+oppID);
        
        return oppID;
    }
     
    
     /*********************************************************************
    Purpose     : To get Quick Quote record
    Parameters  : Quick Quote Id 
    Returns     : MMI_Quotes__c records
    **********************************************************************/
    public MMI_Quotes__c getQuickQuote(String qqRecID){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainService :getQuickQuote');
        MMI_Quotes__c qqRec=null;
        try{
            if(qqRecID!=null){
                 qqRec =QuickQuoteMainDAO.getQuickQuoteRecord(qqRecID);
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainService getQuickQuote:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  QuickQuoteMainService : getQuickQuote()'+qqRec);
        
        return qqRec;
    }
    
    
    /*********************************************************************
    Purpose     : To Update quick quote record
    Parameters  :MMI_Quotes__c objct, branch id,report date,validate address id,opportunity id
                 quote id,QuickQuoteWrapper
    Returns     : Opportunity id
    **********************************************************************/
    public Boolean updateQuickQuoteRecord(MMI_Quotes__c updateQuote, String branchId ,Date reportDate ,String validAddressId, QuickQuoteWrapper qqwrapper){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainService :updateQuickQuoteRecord');
        Boolean isUpdated=false;
        try{
            if(updateQuote!=null && branchId!=null && reportDate!=null && qqwrapper!=null && validAddressId!=null){
                system.debug('---------------------qqwrapper----------------------'+qqwrapper);
                updateQuote.Branch_id__c = branchId;
                updateQuote.City__c = qqwrapper.City;
                updateQuote.Name = 'Rental';
                updateQuote.Date_From__c = reportDate;
                updateQuote.Start_Date__c=reportDate;
                updateQuote.Product__c = qqwrapper.Product;
                updateQuote.State__c = qqwrapper.State;
                updateQuote.Status__c = 'Active';
                updateQuote.Zip_Code__c = qqwrapper.ZipCode;
                updateQuote.Address__c = qqwrapper.Address;
                updateQuote.Country__c = qqwrapper.Country;
                updateQuote.Branch_id__c = qqwrapper.BranchId;
                updateQuote.COD__c = Double.valueOf(qqwrapper.COD);
                updateQuote.COD_Total__c = Double.valueOf(qqwrapper.COD);
                updateQuote.Delivery__c = Double.valueOf(qqwrapper.DeliveryTotal) - Double.valueOf(qqwrapper.delFuelSurcharge);
                updateQuote.Delivery_Total__c = Double.valueOf(qqwrapper.DeliveryTotal);
                updateQuote.DeliveryZone__c=qqwrapper.DeveloperZone;
                updateQuote.Duration__c = qqwrapper.Duration;
                updateQuote.Fuel_surcharge__c = qqwrapper.isFuelSurcharge;
                updateQuote.Fuel_Surcharge_N__c = Double.valueOf(qqWrapper.delFuelSurcharge);
                updateQuote.Fuel_Surcharge_Total__c = Double.valueOf(qqWrapper.pickupFuelSurcharge);
                updateQuote.Fulfilling_Branch__c = branchId;
                updateQuote.Include_LLW__c = qqwrapper.isIncludeLLW;
                updateQuote.LLW__c = Double.valueOf(qqwrapper.LLW);
                updateQuote.LLW_Total__c = Double.valueOf(qqwrapper.LLW);
                updateQuote.Locks__c = qqwrapper.Locks;
                updateQuote.Locks_N__c = Double.valueOf(qqwrapper.LocksAmount);
                updateQuote.Locks_Total__c = Double.valueOf(qqwrapper.LocksAmount);
                updateQuote.Pick_Up__c = Double.valueOf(qqwrapper.PickUpTotal) - Double.valueOf(qqwrapper.pickupFuelSurcharge);
                updateQuote.Pick_Up_Total__c = Double.valueOf(qqwrapper.PickUpTotal);
                updateQuote.Qty__c = qqwrapper.Quantity;
                
                 /*if(qqWrapper.TransactionType == 'SECO'){
                 	updateQuote.Security_Deposit__c = decimal.valueOf(qqWrapper.securityDeposit);
	                updateQuote.Quick_Quote__c = Double.valueOf(qqwrapper.QuickQuote) + decimal.valueOf(qqWrapper.securityDeposit);
                	updateQuote.Quick_Quote_Total__c = Double.valueOf(qqwrapper.QuickQuote) + decimal.valueOf(qqWrapper.securityDeposit);
                }else{*/
                	updateQuote.Quick_Quote__c = Double.valueOf(qqwrapper.COD);
                	updateQuote.Quick_Quote_Total__c = Double.valueOf(qqwrapper.COD);
                //}
                if(qqWrapper.ExtraRecurringTax != null){
                	updateQuote.Recurring_Tax__c = Decimal.valueOf(qqWrapper.ExtraRecurringTax);
                }else{
                	updateQuote.Recurring_Tax__c = 0.00;
                }
                
                updateQuote.Rental_PP_E__c = Double.valueOf(qqwrapper.Rental_PP_E);
                updateQuote.Rental_PP_E_Total__c = Double.valueOf(qqwrapper.Rental_PP_E);
                updateQuote.Rental_Rate__c = Double.valueOf(qqwrapper.Rate);
                updateQuote.Tax__c = Double.valueOf(qqwrapper.Tax); 
                updateQuote.Tax_id__c = validAddressId;
                updateQuote.Tax_Total__c = Double.valueOf(qqwrapper.Tax);
                updateQuote.Transport_Costs__c = Double.valueOf(qqwrapper.Transport);
                updateQuote.Transaction_Type__c = qqwrapper.TransactionType;
                updateQuote.Reoccurring_Monthly_Charges__c = Double.valueOf(qqwrapper.RecurringMonthlyCharges);
                updateQuote.Cross_Streets__c = qqwrapper.CrossStreets;
                updateQuote.Distance_from_branch__c = qqwrapper.distanceFromBranch;
                
                if(qqwrapper.totalTax == null || qqwrapper.totalTax == ''){
                	qqwrapper.totalTax = '0.00';
                }
                if(qqWrapper.totalCost == null || qqWrapper.totalCost == ''){
                	qqWrapper.totalCost = '0.00';
                }
				if(qqwrapper.totalTax != null && qqwrapper.totalTax != ''){
                	updateQuote.Tax_Total__c = Double.valueOf(qqwrapper.totalTax);
                }       
                if(qqwrapper.suggestedPrice != null && qqwrapper.suggestedPrice != ''){
                	updateQuote.Suggested_Price__c = Double.valueOf(qqwrapper.suggestedPrice);
                }
                if(qqwrapper.minimumPrice != null && qqwrapper.minimumPrice != ''){
                	updateQuote.Minimum_Price__c = Double.valueOf(qqwrapper.minimumPrice);
                }
                if(qqwrapper.modificationTotal == null || qqwrapper.modificationTotal == ''){
                	qqwrapper.modificationTotal = '0.00';
                }
                if(qqwrapper.modificationTotal != null && qqwrapper.modificationTotal != ''){
                	updateQuote.Modification_Charge__c = Double.valueOf(qqwrapper.modificationTotal);
                }
                if(qqwrapper.sellingPrice != null && qqwrapper.sellingPrice != ''){
               		 updateQuote.Selling_Price__c = Double.valueOf(qqwrapper.sellingPrice);
                }
                /*if(qqWrapper.totalCost != null && qqWrapper.totalCost != ''){
                	updateQuote.Quick_Quote_Total__c = Double.valueOf(qqwrapper.totalCost);
                }*/
                 if(qqWrapper.ecode != null && qqWrapper.ecode != ''){
                	updateQuote.Ecode__c = qqwrapper.ecode; 
                }
                updateQuote.Unit_Type__c = qqWrapper.unitType;
                updateQuote.QQ_Type__c = 'Rental';
                //---FOR CAPACITY LOOKUP----
                updateQuote.Longitude__c = qqWrapper.longitudeToInsert;
                updateQuote.Latitude__c = qqWrapper.latitudeToInsert;
                updateQuote.Product_description__c = qqWrapper.productDescToInsert;
                system.debug('---------------------updateQuote----------------------'+updateQuote);
                isUpdated=QuickQuoteMainDAO.updateQuickQuotes(updateQuote);
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainService updateQuickQuoteRecord:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  QuickQuoteMainService : updateQuickQuoteRecord()'+isUpdated);
        
        return isUpdated;
    }
    
    
     /*********************************************************************
    Purpose     : To Update quick quote sales record
    Parameters  :MMI_Quotes__c objct, branch id,report date,validate address id,opportunity id
                 quote id,QuickQuoteWrapper
    Returns     : Opportunity id
    **********************************************************************/
    public Boolean updateQuickQuoteSalesRecord(MMI_Quotes__c updateQuote, String branchId ,Date reportDate ,String validAddressId, QuickQuoteWrapper qqwrapper){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainService :updateQuickQuoteRecord');
        Boolean isUpdated=false;
        try{
            if(updateQuote!=null && branchId!=null && reportDate!=null && qqwrapper!=null && validAddressId!=null){
                
				updateQuote.DeliveryZone__c=qqwrapper.DeveloperZone;
                updateQuote.Branch_id__c = branchId;
                updateQuote.City__c = qqwrapper.City;
                updateQuote.Name = 'Sales';
                updateQuote.Date_From__c = reportDate;
                  updateQuote.Start_Date__c=reportDate;
                updateQuote.Product__c = qqwrapper.Product;
                updateQuote.State__c = qqwrapper.State;
                updateQuote.Status__c = 'Active';
                updateQuote.Zip_Code__c = qqwrapper.ZipCode;
                updateQuote.Address__c = qqwrapper.Address;
                updateQuote.Country__c = qqwrapper.Country;
                updateQuote.Branch_id__c = qqwrapper.BranchId;
                updateQuote.Delivery__c = Double.valueOf(qqwrapper.Delivery);
                updateQuote.Delivery_Total__c = Double.valueOf(qqwrapper.DeliveryTotal);
                updateQuote.Duration__c = qqwrapper.Duration;
                updateQuote.Fuel_surcharge__c = qqwrapper.isFuelSurcharge;
                updateQuote.Fuel_Surcharge_N__c = Double.valueOf(qqWrapper.delFuelSurcharge);
                updateQuote.Fuel_Surcharge_Total__c = Double.valueOf(qqWrapper.pickupFuelSurcharge);
                updateQuote.Fulfilling_Branch__c = branchId;
                updateQuote.Include_LLW__c = qqwrapper.isIncludeLLW;
                updateQuote.LLW__c = Double.valueOf(qqwrapper.LLW);
                updateQuote.LLW_Total__c = Double.valueOf(qqwrapper.LLW);
                updateQuote.Locks__c = qqwrapper.Locks;
                updateQuote.Locks_N__c = Double.valueOf(qqwrapper.LocksAmount);
                updateQuote.Locks_Total__c = Double.valueOf(qqwrapper.LocksAmount);
                updateQuote.Pick_Up__c = Double.valueOf(qqwrapper.PickUp);
                updateQuote.Pick_Up_Total__c = Double.valueOf(qqwrapper.PickUp);
                updateQuote.Qty__c = qqwrapper.Quantity;
                updateQuote.Quick_Quote__c = Double.valueOf(qqwrapper.QuickQuote);
                updateQuote.Quick_Quote_Total__c = Double.valueOf(qqwrapper.QuickQuote);
                updateQuote.Rental_PP_E__c = Double.valueOf(qqwrapper.Rental_PP_E);
                updateQuote.Rental_PP_E_Total__c = Double.valueOf(qqwrapper.Rental_PP_E);
                updateQuote.Rental_Rate__c = Double.valueOf(qqwrapper.Rate);
                updateQuote.Tax__c = Double.valueOf(qqwrapper.Tax); 
                updateQuote.Tax_id__c = validAddressId;
                updateQuote.Transport_Costs__c = Double.valueOf(qqwrapper.Transport);
                updateQuote.Transaction_Type__c = qqwrapper.TransactionType;
                //updateQuote.Reoccurring_Monthly_Charges__c = Double.valueOf(qqwrapper.RecurringMonthlyCharges);
                updateQuote.Cross_Streets__c = qqwrapper.CrossStreets;
                updateQuote.Distance_from_branch__c = qqwrapper.distanceFromBranch;
				
				if(qqwrapper.totalTax == null || qqwrapper.totalTax == ''){
                	qqwrapper.totalTax = '0.00';
                }
                if(qqWrapper.totalCost == null || qqWrapper.totalCost == ''){
                	qqWrapper.totalCost = '0.00';
                }
				if(qqwrapper.totalTax != null && qqwrapper.totalTax != ''){
                	updateQuote.Tax_Total__c = Double.valueOf(qqwrapper.totalTax);
                }       
                if(qqwrapper.suggestedPrice != null && qqwrapper.suggestedPrice != ''){
                	updateQuote.Suggested_Price__c = Double.valueOf(qqwrapper.suggestedPrice);
                }
                if(qqwrapper.minimumPrice != null && qqwrapper.minimumPrice != ''){
                	updateQuote.Minimum_Price__c = Double.valueOf(qqwrapper.minimumPrice);
                }
                if(qqwrapper.modificationTotal == null || qqwrapper.modificationTotal == ''){
                	qqwrapper.modificationTotal = '0.00';
                }
                if(qqwrapper.modificationTotal != null && qqwrapper.modificationTotal != ''){
                	updateQuote.Modification_Charge__c = Double.valueOf(qqwrapper.modificationTotal);
                }
                if(qqwrapper.sellingPrice != null && qqwrapper.sellingPrice != ''){
               		 updateQuote.Selling_Price__c = Double.valueOf(qqwrapper.sellingPrice);
                }
                if(qqWrapper.totalCost != null && qqWrapper.totalCost != ''){
                	updateQuote.Quick_Quote_Total__c = Double.valueOf(qqwrapper.totalCost);
                }
                updateQuote.Ecode__c = qqwrapper.ecode; 
                updateQuote.QQ_Type__c = 'Sales';
                //---FOR CAPACITY LOOKUP----
                updateQuote.Longitude__c = qqwrapper.longitudeToInsert;
                updateQuote.Latitude__c = qqwrapper.latitudeToInsert;
                updateQuote.Product_description__c = qqwrapper.productDescToInsert;
                updateQuote.Unit_Type__c = qqWrapper.unitType;
                isUpdated=QuickQuoteMainDAO.updateQuickQuotes(updateQuote);
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainService updateQuickQuoteRecord:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  QuickQuoteMainService : updateQuickQuoteRecord()'+isUpdated);
        
        return isUpdated;
    }
    
    
    /*********************************************************************
    Purpose     : To update opportunity for Sales
    Parameters  : id 
    Returns     : Opportunity object
    **********************************************************************/
    public String updateOppNameSales(String oppID ,QuickQuoteWrapper qqwrapper, Date closeDate , Date Whenwillyouneedyourunit, String leadServiceBranchId){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainService :getOppInfo');
        Opportunity oppRec=null;
        String oppIdAfterUpdate;
        try{
            system.debug('--------qqwrapper------'+qqwrapper);
              system.debug('--------qqwrapper.oppContactPhone------'+qqwrapper.oppContactPhone);
            if(oppID!=null && qqwrapper!=null){
              oppRec=QuickQuoteMainDAO.getOppToUpdate(oppId);
                Integer oppFullQuotecountCount = [select id from MMI_Full_Quotes__c where Opportunity__c = :oppRec.id].size();
				Integer oppQuickQuotecountCount = [Select Id From MMI_Quotes__c where Opportunity__c = : oppRec.id].size();
				
				system.debug('----oppFullQuotecountCount----'+oppFullQuotecountCount);
				system.debug('----oppQuickQuotecountCount----'+oppQuickQuotecountCount);
				Integer oppcountCount=0;
				if(oppFullQuotecountCount != null && oppQuickQuotecountCount != null){
					oppcountCount = oppFullQuotecountCount + oppQuickQuotecountCount; 
				}else{
					if(oppFullQuotecountCount != null){
						oppcountCount = oppFullQuotecountCount;	
					}else{
						oppcountCount =  oppQuickQuotecountCount;
						}
				}
				system.debug('--------oppQuickQuotecountCount------'+oppQuickQuotecountCount);
				// commented because of issue 1253
				/*if(oppQuickQuotecountCount == 1){
					system.debug('--------oppQuickQuotecountCount------'+oppQuickQuotecountCount);
					system.debug('-------oppRec.Quote_Comments__c------'+oppRec.Quote_Comments__c); //7
					if(oppRec.Quote_Comments__c == null || oppRec.Quote_Comments__c == ''){
						system.debug('-------oppRec.Quote_Comments__c------'+oppRec.Quote_Comments__c);
						if(qqwrapper.QuoteComments != null && qqwrapper.QuoteComments != ''){
	                 		oppRec.Quote_Comments__c = qqwrapper.QuoteComments;
	             		}else{
	              			oppRec.Quote_Comments__c = '';
	             		}	
					}
										
				}*/
				if(oppcountCount > 1){
					oppRec.Name = oppRec.Account.Name+ '/Mult Quotes';
				}else{
					oppRec.Name='('+qqwrapper.Quantity+')'+''+qqwrapper.Product+'/'+ Decimal.valueOf(qqwrapper.Rate)+'/'+Integer.valueOf(qqwrapper.DeliveryTotal)+'/'+Integer.valueOf(qqwrapper.PickUpTotal);
				      
				      	if(leadServiceBranchId!=null && leadServiceBranchId!=''){
				      		oppRec.Servicing_Branch__c=leadServiceBranchId;
				      	}else if(qqwrapper.FulfillingBranch!=null && qqwrapper.FulfillingBranch!=''){
				      		oppRec.Servicing_Branch__c=qqwrapper.FulfillingBranch;
				      	}
				}
         	 if(closeDate != null){
              	oppRec.CloseDate = closeDate; 
              }
              /*if(oppRec.Why_do_you_need_storage__c == null && qqwrapper.Whydoyouneedstorage != null){   //----Commented for--- TFS 2719--------------
             	oppRec.Why_do_you_need_storage__c = qqwrapper.Whydoyouneedstorage; //1
              }*/
              oppRec.Why_do_you_need_storage_Picklist__c = qqwrapper.Whydoyouneedstorage; //------- TFS 2719--------------
              if(oppRec.When_will_you_need_your_unit__c == null && Whenwillyouneedyourunit != null){
              	oppRec.When_will_you_need_your_unit__c = Whenwillyouneedyourunit;	 //4
              }
              if(oppRec.What_will_you_be_storing__c == null && qqwrapper.Whatwillyoubestoring != null){
              	oppRec.What_will_you_be_storing__c = qqwrapper.Whatwillyoubestoring;  //2
              }
              if((oppRec.How_often_will_you_need_to_access__c == null || oppRec.How_often_will_you_need_to_access__c == '--None--') && (qqwrapper.Howoftenwillyouneedtoaccess != null && qqwrapper.Howoftenwillyouneedtoaccess != '--None--')){
              	oppRec.How_often_will_you_need_to_access__c = qqwrapper.Howoftenwillyouneedtoaccess;  //5
              }
              // commented Added for TFS 2854
              //if((oppRec.How_long_will_you_need_your_unit__c == null || oppRec.How_long_will_you_need_your_unit__c == '--None--')  && (qqwrapper.Howlongwillyouneedyourunit != null && qqwrapper.Howlongwillyouneedyourunit != '--None--' )){
              	oppRec.How_long_will_you_need_your_unit__c = qqwrapper.Howlongwillyouneedyourunit;  //3
              //}
              // commented Added for TFS 2854
              /*if(qqWrapper.Duration != null && qqWrapper.Duration != '' && qqWrapper.Duration != '0'){
              	if(Integer.valueOf(qqWrapper.Duration) > 12){
              		oppRec.How_long_will_you_need_your_unit__c = '13+ Months';
              	}else{
              		if(Integer.valueOf(qqWrapper.Duration) == 1){
              			oppRec.How_long_will_you_need_your_unit__c = qqWrapper.Duration + ' Month';
              		}else{
              			oppRec.How_long_will_you_need_your_unit__c = qqWrapper.Duration + ' Months';
              		}
              	}
              }*/
              //-------------TFS 2854 ends------------------------------
              if(oppRec.Who_is_going_to_be_accessing_your_unit__c == null && qqwrapper.Whoisgoingtobeaccessingyourunit != null){
              	oppRec.Who_is_going_to_be_accessing_your_unit__c = qqwrapper.Whoisgoingtobeaccessingyourunit; //6
              }
              //if(oppRec.Quote_Comments__c == null && qqwrapper.QuoteComments != null){
              	oppRec.Quote_Comments__c = qqwrapper.QuoteComments; //6
              //}
              oppRec.On_The_Go__c = qqwrapper.ResidentialOnSite;
              oppRec.Item_Code__c=qqwrapper.Product;
              oppRec.Product_Type__c = qqwrapper.ProductType;
              //------TFS 2719------------
              if(qqWrapper.tyleofQuoute=='Rental'){
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
              oppRec.Unit_Type__c = qqWrapper.unitType;
              //------TFS 2719------------
              //-------TFS 2728-----------------------
              if(qqWrapper.DeveloperZone == null || qqWrapper.DeveloperZone == '' || qqWrapper.DeveloperZone == 'null'){
              	oppRec.Delivery_Zone__c = 'Null'; 
              }else{
              	oppRec.Delivery_Zone__c = qqWrapper.DeveloperZone; 
              }
              //-------TFS 2728-----------------------
              oppRec.Transaction_Type__c = qqwrapper.TransactionType+ '-' +qqWrapper.tyleofQuoute;
              oppRec.of_Units__c = qqwrapper.Quantity;
              oppRec.Type_of_Quote_Given__c = 'Salesforce Quick Quote';
              oppRec.Delivery_Rate_Incl_Fuel__c = Double.valueOf(qqwrapper.DeliveryTotal);
              oppRec.Pick_up_Rate_Incl_Fuel__c = Double.valueOf(qqwrapper.PickUpTotal);
              oppRec.StageName = 'Quoted- No Decision';
               
			  oppRec.Quote_type__c = qqWrapper.tyleofQuoute;
              if(qqWrapper.tyleofQuoute=='Rental'){
              	if(qqwrapper.Rate != null){
              		oppRec.Base_Price__c=double.valueOf(qqwrapper.Rate);
              		system.debug('------------oppRec.Base_Price__c--------------'+oppRec.Base_Price__c);
              	}
              }else{
              	if(qqwrapper.sellingPrice != null){
              		oppRec.Base_Price__c=double.valueOf(qqwrapper.sellingPrice);
              	}
              }
              
              oppRec.Delivery_City__c=qqwrapper.City;
              oppRec.Delivery_Country__c=qqwrapper.Country;
              oppRec.Delivery_State_Province__c=qqwrapper.State;
              oppRec.Delivery_Street__c=qqwrapper.Address;
              oppRec.Delivery_Zip_Postal_Code__c=qqwrapper.ZipCode;
              //Issue 1238----------------------- 
              oppRec.Contact_Name__c = qqwrapper.oppContactName;
              oppRec.Contact_Phone__c = qqwrapper.oppContactPhone;
              oppRec.Contact_Last_Name__c = qqwrapper.oppContactLastName;
              oppRec.Contact_Mobile__c = qqwrapper.oppContactMob;
              oppRec.Contact_Email__c = qqwrapper.oppContactEmail;
              
              //--------issue 1180---------------------------------------------
              if(qqWrapper.jobProfileId != null && qqWrapper.jobProfileId != '' && qqWrapper.accountId != null && qqWrapper.accountId != '' && (qqWrapper.contactId == null || qqWrapper.contactId == '')){
	             Contact contactRec = new Contact(FirstName = qqwrapper.oppContactName, LastName = qqwrapper.oppContactLastName, AccountId = qqWrapper.accountId,Phone = qqwrapper.oppContactPhone, MobilePhone = qqwrapper.oppContactMob,Email = qqwrapper.oppContactEmail);
	             insert contactRec;
	             //oppRec.Contact__c = contactRec.Id;
	             oppRec.Opportunity_Contact_Name_LookUpFilter__c = contactRec.Id;
              }else if(qqWrapper.jobProfileId != null && qqWrapper.jobProfileId != '' && qqWrapper.accountId != null && qqWrapper.accountId != '' && qqWrapper.contactId != null && qqWrapper.contactId != ''){
	             Contact conObj = QuickQuoteMainDAO.getContactRecord(qqWrapper.contactId);
	             if(conObj != null){
	              	 conObj.FirstName = qqwrapper.oppContactName;
	          		 conObj.LastName = qqwrapper.oppContactLastName;
	          		 conObj.Phone = qqwrapper.oppContactPhone;
	          		 conObj.MobilePhone = qqwrapper.oppContactMob;
	          		 conObj.Email = qqwrapper.oppContactEmail;
	          		 update conObj;
	          		 //oppRec.Contact__c = conObj.Id;
	          		 oppRec.Opportunity_Contact_Name_LookUpFilter__c = conObj.Id;
              	 }
              }
              //-----------------------------------------------------------------
              if(qqWrapper.jobProfileId == null || qqWrapper.jobProfileId == ''){
          			if(qqwrapper.SourceOfQQ == 'account' || qqwrapper.SourceOfQQ == 'lead' || qqwrapper.SourceOfQQ == 'opportunity'){
	          			// no nedd to update Contact for QQ created from lead, because thay are created by lead conversion.
	          			//if(qqwrapper.SourceOfQQ == 'account' || qqwrapper.SourceOfQQ == 'opportunity'){
		          			Contact ConObjToUpdate = [select Id,FirstName,LastName,Phone,MobilePhone,Email from Contact where Id = :qqwrapper.selectedOrConvertedContactId];
			              	if(ConObjToUpdate != null){
			              		ConObjToUpdate.FirstName = qqwrapper.oppContactName;
			              		ConObjToUpdate.LastName = qqwrapper.oppContactLastName;
			              		ConObjToUpdate.Phone = qqwrapper.oppContactPhone;
			              		ConObjToUpdate.MobilePhone = qqwrapper.oppContactMob;
			              		ConObjToUpdate.Email = qqwrapper.oppContactEmail;
			              		update ConObjToUpdate;
			              	}
	          			//}
	          			//oppRec.Contact__c = qqwrapper.selectedOrConvertedContactId;
	          			oppRec.Opportunity_Contact_Name_LookUpFilter__c = qqwrapper.selectedOrConvertedContactId;
          			}
	              /*if(oppRec != null && !oppRec.Account.IsPersonAccount){
	              	Contact ConObjToUpdate = [select Id,FirstName,LastName,Phone from Contact where AccountId = :oppRec.AccountId limit 1];
	              	if(ConObjToUpdate != null){
	              		ConObjToUpdate.FirstName = qqwrapper.oppContactName;
	              		ConObjToUpdate.LastName = qqwrapper.oppContactLastName;
	              		ConObjToUpdate.Phone = qqwrapper.oppContactPhone;
	              		update ConObjToUpdate;
	              	}
	              }else if(oppRec != null && oppRec.Account.IsPersonAccount){
	              	Account AccObjToUpdate = [select Id, PersonAssistantName,PersonAssistantPhone from Account where Id = :oppRec.AccountId ];
	              	if(AccObjToUpdate != null){
	              		AccObjToUpdate.PersonAssistantName = qqwrapper.oppContactName + ' ' + qqwrapper.oppContactLastName;
	              		AccObjToUpdate.PersonAssistantPhone = qqWrapper.oppContactPhone;
	              		update AccObjToUpdate;
	              	}
	              }*/
              }
              //Issue 1238----------------------- 
              
              //----------Issue 1180----------------------------
              
              //-------------set primary contact----------------------------------
              if(qqwrapper.primaryContactNo != null && qqwrapper.primaryContactNo != ''){
              		if(qqwrapper.primaryContactNo == 'Phone'){
              			if(oppRec.Opportunity_Contact_Name_LookUpFilter__c!= null){
              				oppRec.Primary_Contact_Number__c = qqwrapper.oppContactPhone;
              			}
              		}
              		if(qqwrapper.primaryContactNo == 'MobilePhone'){
              			if(oppRec.Opportunity_Contact_Name_LookUpFilter__c!= null){
              				oppRec.Primary_Contact_Number__c = qqwrapper.oppContactMob;
              			}
              		}
              }else{
              		if(oppRec.Opportunity_Contact_Name_LookUpFilter__c!= null){
              			oppRec.Primary_Contact_Number__c = qqwrapper.oppContactPhone;
              		}
              }
              //-------------set primary contact----------------------------------
              //------------issue 1268-----------------------------
              if(qqWrapper.SourceOfQQ == 'lead'){
              		oppRec.Type = 'New Business';
              		oppRec.Opportunity_Rating__c = 'Warm (Possibly Order)';
              }else{
              		oppRec.Type = 'Existing Business';
              		oppRec.Opportunity_Rating__c = 'Warm (Possibly Order)';
              }
              
              //------------issue 1268-----------------------------
              if(qqWrapper.jobProfileId != null && qqWrapper.jobProfileId != ''){
              		oppRec.Job_Profile__c = qqWrapper.jobProfileId;
              		oppRec.LeadSource = 'Job Profile';
              		if(qqWrapper.subContId != null && qqWrapper.subContId != ''){
              			Sub_Contractor__c scRec = QuickQuoteMainDAO.getSCRecord(qqWrapper.subContId);
              			if(scRec != null && scRec.Role__c != null){
              				oppRec.Sub_Contractor_Role__c = scRec.Role__c;
              			}
              		}
              }
              
              //----------Issue 1180---------------------------- 
              system.debug('------------oppRec.Base_Price__c--------------'+oppRec.Base_Price__c);
              oppIdAfterUpdate=QuickQuoteMainDAO.updateOppName(oppRec);
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainService getOppInfo:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  QuickQuoteMainService : getOppInfo()'+oppRec+oppIdAfterUpdate);
        
        return oppIdAfterUpdate;
    }
    
    /*********************************************************************
    Purpose     : To update opportunity
    Parameters  : id 
    Returns     : Opportunity object
    **********************************************************************/
    public String updateOppName(String oppID ,QuickQuoteWrapper qqwrapper){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainService :getOppInfo');
        Opportunity oppRec=null;
        String oppIdAfterUpdate;
        try{
            if(oppID!=null && qqwrapper!=null){
              oppRec=QuickQuoteMainDAO.getOppToUpdate(oppId);
              oppRec.Name='('+qqwrapper.Quantity+')'+''+qqwrapper.Product+'/'+ Integer.valueOf(qqwrapper.Rate)+'/'+Integer.valueOf(qqwrapper.DeliveryTotal)+'/'+Integer.valueOf(qqwrapper.PickUpTotal);
              oppRec.Product_Type__c = qqwrapper.ProductType;
              //------TFS 2719------------
              if(qqWrapper.tyleofQuoute=='Rental'){
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
              }else{
              	  oppRec.Unit_Type__c = qqWrapper.unitType;
              }
              //------TFS 2719------------
              //-------TFS 2728-----------------------
              if(qqWrapper.DeveloperZone == null || qqWrapper.DeveloperZone == '' || qqWrapper.DeveloperZone == 'null'){
              	oppRec.Delivery_Zone__c = 'Null'; 
              }else{
              	oppRec.Delivery_Zone__c = qqWrapper.DeveloperZone; 
              }
              //-------TFS 2728-----------------------
              oppRec.Transaction_Type__c = qqwrapper.TransactionType+ '-' +qqWrapper.tyleofQuoute;
              oppRec.of_Units__c = qqwrapper.Quantity;
              oppRec.Type_of_Quote_Given__c = 'Salesforce Quick Quote';
              oppRec.Delivery_Rate_Incl_Fuel__c = Double.valueOf(qqwrapper.Delivery) + Double.valueOf(qqwrapper.delFuelSurcharge);
              oppRec.Pick_up_Rate_Incl_Fuel__c = Double.valueOf(qqwrapper.PickUp) + Double.valueOf(qqwrapper.pickupFuelSurcharge);
              //oppRec.Quote_Comments__c = 'N/A';
              oppRec.StageName = 'Quoted- No Decision';
              //oppRec.Why_do_you_need_storage__c = qqwrapper.Whydoyouneedstorage;
              oppRec.Why_do_you_need_storage_Picklist__c = qqwrapper.Whydoyouneedstorage; //------- TFS 2719--------------
               if(qqWrapper.tyleofQuoute=='Rental'){
              oppRec.Base_Price__c=double.valueOf(qqwrapper.Rate);
              }else{
              	 oppRec.Base_Price__c=double.valueOf(qqwrapper.sellingPrice);
              }
             /* if(Whenwillyouneedyourunit != null){
              	oppRec.When_will_you_need_your_unit__c = Whenwillyouneedyourunit;	
              }
              if(closeDate != null){
              	oppRec.CloseDate = closeDate; 
              }
              oppRec.What_will_you_be_storing__c = qqwrapper.Whatwillyoubestoring;
              oppRec.How_often_will_you_need_to_access__c = qqwrapper.Howoftenwillyouneedtoaccess;
              oppRec.How_long_will_you_need_your_unit__c = qqwrapper.Howlongwillyouneedyourunit;
              oppRec.Who_is_going_to_be_accessing_your_unit__c = qqwrapper.Whoisgoingtobeaccessingyourunit;
              oppRec.On_The_Go__c = qqwrapper.ResidentialOnSite;
              oppRec.Quote_Comments__c =qqwrapper.QuoteComments; 
               */
               
              oppIdAfterUpdate=QuickQuoteMainDAO.updateOppName(oppRec);
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainService getOppInfo:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  QuickQuoteMainService : getOppInfo()'+oppRec+oppIdAfterUpdate);
        
        return oppIdAfterUpdate;
    }
    
     public List<Account> getAccounListInfo(String AccountRedId){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainService :getAccounListInfo');
        List<Account> accRec=null;
        try{
            if(AccountRedId!=null){
                accRec=QuickQuoteMainDAO.getAccountList(AccountRedId); 
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainService getAccounListInfo:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  QuickQuoteMainService : getAccounListInfo()'+accRec);
        
        return accRec;
    }
    
    
    
     public String insertOpportunity(Account acc){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainService :insertOpportunity');
        Opportunity opp=null;
        String oppId;
        try{
            if(acc!=null ){
                    opp = new Opportunity();
            		opp.AccountId = acc.id; 
            		opp.Branch__c = acc.Branch__c;
            		opp.Servicing_Branch__c = acc.Servicing_Branch_Id__c;
            		opp.Name = acc.Name;
            		opp.Delivery_Street__c = acc.ShippingStreet;
            		opp.Delivery_City__c = acc.ShippingCity;
            		opp.Delivery_Country__c = acc.ShippingCountry;
            		opp.Delivery_State_Province__c = acc.ShippingState;
            		opp.Delivery_Zip_Postal_Code__c = acc.ShippingPostalCode;
            		opp.StageName = 'Quoted- No Decision';
            		opp.CloseDate = system.today();
            		
            		oppId=QuickQuoteMainDAO.insertOpportunity(opp);
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainService insertOpportunity:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  QuickQuoteMainService : insertOpportunity()'+oppId);
        
        return oppId;
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
                BranchLookupList = QuickQuoteMainDAO.getBranchLookUpRecord(zipCode);
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainService BranchLookupList:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  QuickQuoteMainService : BranchLookupList()'+BranchLookupList);
        
        return BranchLookupList;
    }
    
    
    
}