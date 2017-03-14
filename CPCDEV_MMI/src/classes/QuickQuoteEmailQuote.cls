public with sharing class QuickQuoteEmailQuote {
    public Boolean isSalesType {get;set;}
    public MMI_Quotes__c qqData {get;set;}
    public MMI_Quotes__c qqAcctData {get;set;}
    public Account accData {get;set;}
    public Weekly_Snapshot_Branch_Report__c weeklyBranchSnop{get;set;}
    public User loginUserRec{get;set;}
    public String recId {get;set;}
    public String transactionTypeName {get;set;}
    private map<String,String> mapTransIdAndName {get;set;}
    public Decimal delPlusFuel {get;set;}
    public Decimal puPlusFuel {get;set;}
    public Decimal totalRentalCharge {get;set;}
    public Decimal totalOneTimeCharge {get;set;}
    public Decimal totalinitialCharge {get;set;}
    public Decimal totalCharge {get;set;}
    public Boolean isLockPresent {get;set;}
    public Date ExpDate {get;set;}
    public Decimal productPrice {get;set;}
    public Decimal securityCharge {get;set;}
    
    
    public QuickQuoteEmailQuote(){
        isLockPresent = false;
        recId = Apexpages.currentPage().getParameters().get('recId');
        loginUserRec = [Select Id,Email,Fax,Phone,Extension__c, Name, Sales_Rep_Id__c from User where Id = :UserInfo.getUserId()];
        qqData = [Select m.Zip_Code__c, m.When_will_you_need_your_unit__c, m.Transport_Costs__c, m.Transaction_Type__c, m.Tax_id__c, m.Tax__c, m.Tax_Total__c, m.SystemModstamp, m.Suggested_Price__c, m.Status__c, m.State__c, m.Start_Date__c, m.Selling_Price__c, m.Reoccurring_Monthly_Charges__c, m.Rental_Rate__c, m.Rental_PP_E__c, m.Rental_PP_E_Total__c, m.Quote_Id__c, m.Quick_Quote__c, m.Quick_Quote_Total__c, m.Qty__c, m.QQ_Type__c, m.Product_description__c, m.Product__c, m.Pick_Up__c, m.Pick_Up_Total__c, m.Opportunity__c, m.Name, m.Modification_Charge__c, m.Minimum_Price__c, m.Longitude__c, m.Locks__c, m.Locks_Total__c, m.Locks_N__c, m.Latitude__c, m.LastModifiedDate, m.LastModifiedById, m.LastActivityDate, m.LLW__c, m.LLW_Total__c, m.IsDeleted, m.Include_LLW__c, m.Id, m.Fulfilling_Branch__c, m.Fuel_surcharge__c, m.Fuel_Surcharge_Total__c, m.Fuel_Surcharge_N__c, m.Ecode__c, m.Duration__c, m.Distance_from_branch__c, m.Delivery__c, m.Delivery_Total__c, m.DeliveryZone__c, m.Date_From__c, m.CurrencyIsoCode, m.Cross_Streets__c, m.CreatedDate, m.CreatedById, m.Create_Date__c, m.Country__c, m.Close_Date__c, m.City__c, m.COD__c, m.COD_Total__c, m.Branch_id__c, m.Address__c,m.Security_Deposit__c From MMI_Quotes__c m where Id = :recId];
        if(qqData!= null){
            mapTransIdAndName = new map<String,String>();
            mapTransIdAndName.put('CART','Rental Cartage');
            mapTransIdAndName.put('CNST','Rental Offsite Construction');
            mapTransIdAndName.put('MOBO','Rental Mobile Offices');
            mapTransIdAndName.put('OFF','Rental Offsite Standard');
            mapTransIdAndName.put('ON','Rental On Site');
            mapTransIdAndName.put('SECO','Rental Security Offices');
            mapTransIdAndName.put('VANT','Rental Van Trailer');
            mapTransIdAndName.put('SOFL','Sales Order Fleet Sales');
            mapTransIdAndName.put('SOMA','Sales Order MFG/Accessories');
            mapTransIdAndName.put('SOWD','Sales Order Wholesale Direct');
            if(mapTransIdAndName.containsKey(qqData.Transaction_Type__c)){
                transactionTypeName = mapTransIdAndName.get(qqData.Transaction_Type__c);
            }else{
                transactionTypeName = qqData.Transaction_Type__c;
            }
            if(qqData.QQ_Type__c == 'Rental'){
                isSalesType = false;
            }else{
                isSalesType = true;
            }
            if(qqData.Locks_Total__c != null && qqData.Locks_Total__c > 0){
                isLockPresent = true;
            }
            if(qqData.CreatedDate != null){
                ExpDate = Date.valueOf((qqData.CreatedDate).addDays(30));
            }
            if(qqData.Fulfilling_Branch__c != null && qqData.Fulfilling_Branch__c != ''){
                system.debug('---------qqData.Fulfilling_Branch__c-------'+qqData.Fulfilling_Branch__c);
                list<Weekly_Snapshot_Branch_Report__c> weekTempList = [Select w.Zipcode__c, w.Yard_Team__c, w.X5_days_Weather_Forecast__c, w.Weekly__c, w.Weekly_Sales__c, w.Weekly_Rentals__c, w.Warehouse_of_drivers__c, w.Warehouse_availabilty_of_containers__c, w.Warehouse_Zip_Code__c, w.Warehouse_Street__c, w.Warehouse_State__c, w.Warehouse_Other__c, w.Warehouse_Manager__c, w.Warehouse_Delivery_Printer__c, w.Warehouse_City__c, w.View__c, w.Tiltbed_Equiment__c, w.TSM__c, w.TSM_User__c, w.SystemModstamp, w.Street__c, w.Storage_Center__c, w.State__c, w.Sporting_Events_Teams__c, w.Spiff_Contests__c, w.Speacial_Events_Sunday_Paper_Style__c, w.Servicing_Branch__c, w.Result_Printer_for_Pick_up__c, w.Result_Printer_for_Deliveries__c, w.Re_market_Opporunities__c, w.Rate_Adjustments__c, w.Product_Discounts_sales__c, w.OwnerId, w.Other_Sellable_Inventory__c, w.Office_Manager__c, w.OSH_Rates__c, w.OSH_Priority_Capacity__c, w.Name, w.NSC_Market_Campaigns__c, w.NPS__c, w.Monthly_Branch_Goals__c, w.Modification_Info__c, w.Market_Value_Range_40__c, w.Market_Value_Range_40ZS__c, w.Market_Value_Range_40S__c, w.Market_Value_Range_20__c, w.Market_Value_Range_20ZS__c, w.Market_Value_Range_20S__c, w.Link_to_Local_Newspaper_2__c, w.Link_to_Local_Newspaper_1__c, w.LastModifiedDate, w.LastModifiedById, w.LastActivityDate, w.Large_Project_Commitments__c, w.Landolls_Equipment__c, w.IsDeleted, w.Inventory_Surplus__c, w.Inventory_Shortage__c, w.Inventory_Availability__c, w.Image_Id__c, w.Id, w.ISR__c, w.Fun_Facts_about_local_branch_team__c, w.Driver_Totals__c, w.Dispatcher__c, w.Delivery_Info__c, w.Customer_Pickup_Requests__c, w.Custom_Work_Options__c, w.Current_Days_to_get_Security_Office__c, w.CurrencyIsoCode, w.CreatedDate, w.CreatedById, w.County__c, w.Country__c, w.Climate_Controlled__c, w.Climate_Control_Info__c, w.City__c, w.Call_To_Action__c, w.Branch_Picture__c, w.Branch_Phone__c, w.Branch_Market_Campaigns__c, w.Branch_Manager__c, w.Branch_Manager_Notes__c, w.Avg_days_to_get_Security_Office_Ready__c, w.Average_Driver_Moves__c From Weekly_Snapshot_Branch_Report__c w where BranchId__c = :qqData.Fulfilling_Branch__c limit 1];
                if(weekTempList.size() > 0){
                    weeklyBranchSnop = weekTempList[0];     
                }
            }
            
            qqAcctData = [Select m.Opportunity__r.AccountId,m.Opportunity__c From MMI_Quotes__c m where Id = :recId];
            if(qqAcctData != null){
                accData = [Select a.Id,a.Name,a.BillingStreet, a.BillingState, a.BillingPostalCode, a.BillingCountry, a.BillingCity From Account a where Id = :qqAcctData.Opportunity__r.AccountId];
            }
            system.debug('---------accData-----'+accData);
            
            delPlusFuel = qqData.Delivery_Total__c;
            puPlusFuel = qqData.Pick_Up_Total__c;
            
            if(qqData.Transaction_Type__c == 'SECO'){
            	securityCharge = qqData.Security_Deposit__c;
            }else{
            	securityCharge = 0.00;
            }
            productPrice = qqData.Rental_Rate__c;
            totalRentalCharge = productPrice + qqData.Rental_PP_E_Total__c +qqData.LLW_Total__c;
            totalOneTimeCharge = delPlusFuel + puPlusFuel + qqData.Locks_Total__c + securityCharge;
            totalinitialCharge = totalRentalCharge + totalOneTimeCharge + qqData.Tax_Total__c;
            totalCharge = productPrice + securityCharge + qqData.Locks_Total__c + qqData.Fuel_Surcharge_N__c + qqData.Transport_Costs__c + qqData.Tax_Total__c;
            
        }
        
        
    }
    
    public Pagereference GetPDFcontent(){
        
        return null;
    }

}