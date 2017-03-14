/*****************************************************************************
 * Name             : AccountCloner
 * Created By       : Bharti(Appirio Offshore)
 * Created Date     : 3rd March, 2012.
 * Purpose          : Webserivce to Clone account
 * Modified On      : 8th Feb 2013(Hemant), Allow Branch manager to select Branch if BM have multiple branches      
*****************************************************************************/
global class AccountCloner {
  static Set<String> userRoleNSC;
  static Set<String> userRoleBranch;
  static User currentUser;
  static final String USERROLE_BRANCH_MANAGER = 'Branch Manager'; 
  
  static{
    userRoleNSC = new Set<String>();
    for(NSCUserRole__c role : NSCUserRole__c.getAll().values()){
      userRoleNSC.add(role.RoleName__c);
    }    
    
    userRoleBranch = new Set<String>();
    for(BranchUserRole__c role : BranchUserRole__c.getAll().values()){
      userRoleBranch.add(role.RoleName__c);
    }
    
    for(User usr : [Select UserRole.Name,Branch_Id__c,Name From User Where Id = : UserInfo.getUserId()]){
        currentUser = usr;
      }
  }
  
   // TFS-3108 
   webservice static Boolean isNSCBranchUserRole()
    {  if(currentUser.UserRoleId != null && (userRoleNSC.contains(currentUser.UserRole.Name) || userRoleBranch.contains(currentUser.UserRole.Name)))
        { return true;   }
      else 
         return false;
    }   
    
    webservice static Id createClone(ID accountId, String branchForBM){      
        Account clonedAccount = null;
        /* for(Account account : [Select mass_email__pc, forCountUpdate__c, duplicate__c,
                           YTD_Revenue__c, When_To_Call__c, Website, 
                           View_Branch_Snapshot__c, Vendor_Status__c, 
                           Vendor_Number__c, Vendor_Comments__c, 
                           Van_Trailers_UOR_Last_12_Months__c, 
                           Van_Trailers_Percent_Change__c, 
                           Van_Trailers_On_Rent_Last_Year_Same_WK__c, 
                           User_Type__c, Usage__c, Type_of_Government_Department__c, 
                           Type, Trucking_Discount__c, Total_Units_on_Rent__c, 
                           Total_Units_on_Rent_YoY_Change__c, Total_Units_on_Rent_79__c, 
                           Total_Units_on_Rent_46__c, Total_Units_on_Rent_1012__c, 
                           Total_Units_on_Rent_03__c, Total_Units_on_Hire__c, 
                           Total_Units_on_Hire_YoY_Change__c, Total_Units_on_Hire_79_Months__c, 
                           Total_Units_on_Hire_46_Months__c, Total_Units_on_Hire_1012_Months__c, 
                           Total_Units_on_Hire_03_Months__c, Total_UOR_End_of_Last_4_Quarters__c, 
                           Total_Revenue_YTD_Prior_Year__c, Total_Revenue_YTD_Current_Year__c, 
                           Total_Revenue_Last_12_Months__c, Total_Revenue_Change_YTD__c, 
                           Total_Revenue_Change_Last_12_Months__c, Temp__c, TSM_Top_Potential__c, 
                           TSM_Top_Potential_Role__c, TSM_Top_Potential_ID__c, TSM_Initial_Submitter_ID__c, 
                           SystemModstamp, Summary_balance_current__c, Summary_balance_90_days__c, 
                           Summary_balance_60_days__c, Summary_balance_30_days__c, Summary_balance_120_days__c, 
                           Summary_A_R_balance_Data__c, Special_Instructions__c, Size_of_Business_Number_of_Locations__c, 
                           Sic_Code__c, Sic_Code_Description__c, ShippingStreet, ShippingState, ShippingPostalCode, 
                           ShippingCountry, ShippingCity, Servicing_Branch_Id__c, Security_Offices_UOR_Last_12_Months__c, 
                           Security_Offices_Percent_Change__c, Sec_Offices_On_Rent_Last_Year_Same_WK__c, 
                           Seasonal_User_Marketed_by_Branch__c, Salutation, Sales_Revenue_YTD_Prior_Year__c, 
                           Sales_Revenue_YTD_Percent_Change__c, Sales_Revenue_YTD_Current_Year__c, 
                           Sales_Revenue_Pct_Chng_Last_12_Months__c, Sales_Revenue_Last_79_Months__c, 
                           Sales_Revenue_Last_46_Months__c, Sales_Revenue_Last_12_Months__c, 
                           Sales_Revenue_Last_1012_Months__c, Sales_Revenue_Last_03_Months__c, 
                           Sale_Revenue_Last_Year_Same_Qtr__c, Sale_Revenue_Last_Year_Next_Qtr__c, 
                           Result_Id__c, Rental_Use_Comments__c, Rental_Units_Covered_By__c, 
                           Rental_Discount__c, Rental_Ancillary_Revenue_YTD_Cur_Yr__c, 
                           Rental_Ancillary_Revenue_Last_12_Mos__c, Rental_Ancillary_Rev_YTD_Prior_Year__c, 
                           Rental_Ancillary_Rev_YTD_Change__c, Rental_Ancillary_Rev_Pct_Chng_12_m__c, 
                           RecordTypeId, Purchases_Via_Co_op__c, Product_Interest__c, 
                           Primary_Contact_Method__pc, Phone, Personality_Style__pc, PersonTitle, 
                           PersonOtherStreet, PersonOtherState, PersonOtherPostalCode, PersonOtherPhone, 
                           PersonOtherCountry, PersonOtherCity, PersonMobilePhone, PersonMailingStreet, 
                           PersonMailingState, PersonMailingPostalCode, PersonMailingCountry, 
                           PersonMailingCity, PersonLeadSource, PersonLastCUUpdateDate, 
                           PersonLastCURequestDate, PersonHomePhone, PersonHasOptedOutOfFax, 
                           PersonHasOptedOutOfEmail, PersonEmailBouncedReason, PersonEmailBouncedDate, 
                           PersonEmail, PersonDoNotCall, PersonDepartment, PersonContactId, PersonBirthdate, 
                           PersonAssistantPhone, PersonAssistantName, Percent_UOR_with_LLW_Last_6_Months__c, 
                           Percent_UOR_with_LLW_Last_3_Months__c, Percent_UOR_with_LLW_All__c, 
                           Percent_UOR_with_DW_Last_6_Months__c, Percent_UOR_with_DW_Last_3_Months__c, 
                           Percent_UOR_with_DW_All__c, Pending_P_U_s_that_will_be_Overages__c, 
                           Pending_P_U_s_that_will_be_Charge_Backs__c, Parent__c, Parent_Account_Type__c, 
                           Parent_Account_Icon__c, ParentId, Owner_s_Role__c, OwnerId__c, 
                           Owned_for_bonus_purposes__c, Other_UOR_Last_12_Months__c, Other_Percent_Change__c, 
                           Other_On_Rent_Last_Year_Same_Week__c, Ordered_in_Last_6_Months__c, 
                           Ordered_in_Last_12_Months__c, ORNPU_Num_Units_Over_30_Days__c, 
                           ORNPU_Num_Units_Less_Than_15_Days__c, ORNPU_Num_Units_15_to_30_Days__c, 
                           NumericPhone__pc, NumericPhone__c, Number_of_Opportunities__c, 
                           Number_of_Open_Tasks__c, Number_of_Contracts__c, NumberOfEmployees, 
                           Num_of_Van_Trailers_On_Rent__c, Num_of_Van_Trailers_On_Rent_YoY_Change__c, 
                           Num_of_Van_Trailers_On_Rent_79__c, Num_of_Van_Trailers_On_Rent_46__c, 
                           Num_of_Van_Trailers_On_Rent_1012__c, Num_of_Van_Trailers_On_Rent_03__c, 
                           Num_of_Storage_Containers_On_Rent__c, Num_of_Storage_Containers_On_Rent_79__c, 
                           Num_of_Storage_Containers_On_Rent_46__c, Num_of_Storage_Containers_On_Rent_1012__c, 
                           Num_of_Storage_Containers_On_Rent_03__c, Num_of_Storage_Cont_On_Rent_YoY_Chng__c, 
                           Num_of_Security_Offices_On_Rent__c, Num_of_Security_Offices_On_Rent_79__c, 
                           Num_of_Security_Offices_On_Rent_46__c, Num_of_Security_Offices_On_Rent_1012__c, 
                           Num_of_Security_Offices_On_Rent_03__c, Num_of_Security_Off_On_Rent_YoY_Change__c, 
                           Num_of_Other_On_Hire__c, Num_of_Other_On_Hire_YoY_Change__c, Num_of_Other_On_Hire_79_Months__c, 
                           Num_of_Other_On_Hire_46_Months__c, Num_of_Other_On_Hire_1012_Months__c, 
                           Num_of_Other_On_Hire_03_Months__c, Num_of_Mobiles_On_Rent_YoY_Change__c, 
                           Num_of_Mobile_Offices_On_Rent__c, Num_of_Mobile_Offices_On_Rent_79__c, 
                           Num_of_Mobile_Offices_On_Rent_46__c, Num_of_Mobile_Offices_On_Rent_1012__c, 
                           Num_of_Mobile_Offices_On_Rent_03__c, Num_of_Containers_On_Hire__c, 
                           Num_of_Containers_On_Hire_YoY_Chng__c, Num_of_Containers_On_Hire_79_Months__c, 
                           Num_of_Containers_On_Hire_46_Months__c, Num_of_Containers_On_Hire_1012_Months__c, 
                           Num_of_Containers_On_Hire_03_Months__c, Num_of_Accommodations_On_Hire__c, 
                           Num_of_Accommodations_On_Hire_YoY_Chng__c, Num_of_Accommodations_On_Hire_79_Months__c, 
                           Num_of_Accommodations_On_Hire_46_Months__c, Num_of_Accommodations_On_Hire_1012_Month__c, 
                           Num_of_Accommodations_On_Hire_03_Months__c, Next_Activity_Date__c, 
                           New_rentals_all_Last_Year_Same_Qtr__c, New_rentals_all_Last_Year_Next_Qtr__c, 
                           New_rentals_all_Last_79_Months__c, New_rentals_all_Last_46_Months__c, 
                           New_rentals_all_Last_1012_Months__c, New_rentals_all_Last_03_Months__c, 
                           New_Rentals_Van_Last_Yr_Same_Q__c, New_Rentals_Van_Last_Yr_Next_Q__c, 
                           New_Rentals_Van_79_Months__c, New_Rentals_Van_46_Months__c, New_Rentals_Van_1012_Months__c, 
                           New_Rentals_Van_03_Months__c, New_Rentals_Storage_Last_Year_Same_Q__c, 
                           New_Rentals_Storage_Last_Year_Next_Q__c, New_Rentals_Storage_Last_79_Months__c, 
                           New_Rentals_Storage_Last_46_Months__c, New_Rentals_Storage_Last_1012_Months__c, 
                           New_Rentals_Storage_Last_03_Months__c, New_Rentals_Security_Last_Yr_Same_Q__c, 
                           New_Rentals_Security_Last_Yr_Next_Q__c, New_Rentals_Security_Last_79_Months__c, 
                           New_Rentals_Security_Last_46_Months__c, New_Rentals_Security_Last_1012_M__c, 
                           New_Rentals_Security_Last_03_Months__c, New_Rentals_Office_Last_Year_Same_Q__c, 
                           New_Rentals_Mobile_Last_Year_Same_Q__c, New_Rentals_Mobile_Last_Year_Next_Q__c, 
                           New_Rentals_Mobile_Last_79_Months__c, New_Rentals_Mobile_Last_46_Months__c, 
                           New_Rentals_Mobile_Last_1012_Months__c, New_Rentals_Mobile_Last_03_Months__c, 
                           New_Hires_all_Last_79_Months__c, New_Hires_all_Last_46_Months__c, 
                           New_Hires_all_Last_1012_Months__c, New_Hires_all_Last_03_Months__c, 
                           New_Hires_Other_Last_Yr_Same_Q__c, New_Hires_Other_Last_Yr_Next_Q__c, 
                           New_Hires_Other_Last_79_Months__c, New_Hires_Other_Last_46_Months__c, 
                           New_Hires_Other_Last_1012_Months__c, New_Hires_Other_Last_03_Months__c, 
                           New_Hires_Container_Last_Year_Same_Q__c, New_Hires_Container_Last_Year_Next_Q__c, 
                           New_Hires_Container_Last_79_Months__c, New_Hires_Container_Last_46_Months__c, 
                           New_Hires_Container_Last_1012_Month__c, New_Hires_Container_Last_03_Months__c, 
                           New_Hires_All_Last_Year_Same_Qtr__c, New_Hires_All_Last_Year_Next_Qtr__c, 
                           New_Hires_Accomm_Last_Year_Same_Q__c, New_Hires_Accomm_Last_Year_Next_Q__c, 
                           New_Hires_Accomm_Last_79_Months__c, New_Hires_Accomm_Last_46_Months__c, 
                           New_Hires_Accomm_Last_1012_Months__c, New_Hires_Accomm_Last_03_Months__c, 
                           National_Account_Start_Date__c, National_Account_Pricing__c, National_Account_Pricing_From_Result__c, 
                           Name, NPS_Status__c, NPS_Status_Icon__c, NATCode__c, Mobile_Offices_UOR_Last_12_Months__c, 
                           Mobile_Offices_Percent_Change__c, Mobile_Off_On_Rent_Last_Year_Same_WK__c, MasterRecordId, Manta_URL__c, 
                           Locations__c, Legacy_Salesforce_Id__pc,Lease_Revenue_Last_79_Months__c, 
                           Lease_Revenue_Last_46_Months__c, Lease_Revenue_Last_1012_Months__c, Lease_Revenue_Last_03_Months__c, 
                           Lead_Source__c, Lead_Existing_Account_Owned_by_Rep__c, Lead_Existing_Account_Owned_By_Branch__c, 
                           Lead_Created_Date_Time__c, Lead_Conversion_New_Account_Created__c, Lead_Conversion_Flag__c, 
                           Last_Renewal_Date__c, Last_Modified_Date_Time__pc, Last_Modified_Date_Time__c, Last_Invoice_Date__c, 
                           Last_Date_of_Rental_Storage__c, Last_Date_of_Rental_Mobile__c, Last_Date_of_Rental_All__c, 
                           Last_Date_of_Hire_Container__c, Last_Date_of_Hire_All__c, Last_Date_of_Hire_Accommodations__c, 
                           Last_Activity_Datetime__pc, Last_Activity_Datetime__c, LastName, LastModifiedDate, LastModifiedById, 
                           LastActivityDate, IsPersonAccount, IsDeleted, IsConvertedAccount__c, IsCloneInProgress__c, 
                           Insurance_Cert_Exp__c, Industry_Icon__c, Industry,FirstName, Find_Zip_Code__c, Fax, Family_Code__c, 
                           Expiration_Date__c, Eligible_For_Rebate__c, Dodge_Projects__c, Description, 
                           Department_Name__c, Decision_Maker__pc, Date_of_Last_Rental_Sale__c, Date_of_Last_New_Rental_Van__c, 
                           Date_of_Last_New_Rental_Security__c, Date_of_Last_New_Hire_Other__c, Date_Vendor_Approved__c, 
                           Damage_Waiver_Expires__c, CurrencyIsoCode, Credit_Status__c, Credit_Status_Formula__c, Credit_Collector__c, 
                           Credit_Collector_Name__c, Created_Date_Time__pc, Created_Date_Time__c, CreatedDate, CreatedById, 
                           Contacted_in_Last_90_Days__c, Contacted_in_Last_30_Days__c, Contact_Owner_Extension__pc, Co_op__c, 
                           Co_op_Name__c, Classification__c, Classification_Notes__c, Classification_Complete__c, CKMS__c, 
                           Buyer_Type__c, Branch__pc, Branch__c, Book_Of_Business__c, BillingStreet, BillingState, 
                           BillingPostalCode, BillingCountry, BillingCity, BM_Plan_for_Account__c, AnnualRevenue, Acquisition_Name__c, 
                           Acquisition_Account_Code__c, Account_Icon__c, Account_Anniversary_Date__c, AccountNumber, 
                           Accomm_UOR_Last_12_Months__c, Accomm_Percent_Change__c, Accomm_On_Hire_Last_Year_Same_Week__c, 
                           ABI_Company_Id__c 
                           From Account 
                           where Id =: accountId]){
            */  
            // TFS -- 2291
             for(Account account : [Select mass_email__pc, forCountUpdate__c, duplicate__c,
                           When_To_Call__c, Website, View_Branch_Snapshot__c, Vendor_Status__c, 
                           Vendor_Number__c, Vendor_Comments__c, User_Type__c, Usage__c, Type_of_Government_Department__c, 
                           Type, Trucking_Discount__c, Total_Revenue_YTD_Prior_Year__c, Total_Revenue_YTD_Current_Year__c, 
                           Temp__c, TSM_Top_Potential__c, TSM_Top_Potential_Role__c, TSM_Top_Potential_ID__c, TSM_Initial_Submitter_ID__c, 
                           SystemModstamp, Summary_balance_current__c, Summary_balance_90_days__c, 
                           Summary_balance_60_days__c, Summary_balance_30_days__c, Summary_balance_120_days__c, 
                           Summary_A_R_balance_Data__c, Special_Instructions__c, Size_of_Business_Number_of_Locations__c, 
                           Sic_Code__c, Sic_Code_Description__c, ShippingStreet, ShippingState, ShippingPostalCode, 
                           ShippingCountry, ShippingCity, Servicing_Branch_Id__c, Seasonal_User_Marketed_by_Branch__c, Salutation,  
                           Result_Id__c, Rental_Use_Comments__c, Rental_Units_Covered_By__c, 
                           Rental_Discount__c, RecordTypeId, Purchases_Via_Co_op__c, Product_Interest__c, 
                           Primary_Contact_Method__pc, Phone, Personality_Style__pc, PersonTitle, 
                           PersonOtherStreet, PersonOtherState, PersonOtherPostalCode, PersonOtherPhone, 
                           PersonOtherCountry, PersonOtherCity, PersonMobilePhone, PersonMailingStreet, 
                           PersonMailingState, PersonMailingPostalCode, PersonMailingCountry, 
                           PersonMailingCity, PersonLeadSource, PersonLastCUUpdateDate, 
                           PersonLastCURequestDate, PersonHomePhone, PersonHasOptedOutOfFax, 
                           PersonHasOptedOutOfEmail, PersonEmailBouncedReason, PersonEmailBouncedDate, 
                           PersonEmail, PersonDoNotCall, PersonDepartment, PersonContactId, PersonBirthdate, 
                           PersonAssistantPhone, PersonAssistantName, Pending_P_U_s_that_will_be_Overages__c, 
                           Pending_P_U_s_that_will_be_Charge_Backs__c, Parent__c, Parent_Account_Type__c, 
                           Parent_Account_Icon__c, ParentId, Owner_s_Role__c, OwnerId__c, 
                           Owned_for_bonus_purposes__c, Ordered_in_Last_6_Months__c, 
                           Ordered_in_Last_12_Months__c, NumericPhone__pc, NumericPhone__c, Number_of_Opportunities__c, 
                           Number_of_Open_Tasks__c, Number_of_Contracts__c, NumberOfEmployees, 
                           Next_Activity_Date__c, National_Account_Start_Date__c, National_Account_Pricing__c, National_Account_Pricing_From_Result__c, 
                           Name, NPS_Status__c, NPS_Status_Icon__c, NATCode__c, MasterRecordId, Manta_URL__c, 
                           Locations__c, Legacy_Salesforce_Id__pc, Lead_Source__c, Lead_Existing_Account_Owned_by_Rep__c, Lead_Existing_Account_Owned_By_Branch__c, Lead_Created_Date_Time__c, Lead_Conversion_New_Account_Created__c, Lead_Conversion_Flag__c, 
                           Last_Renewal_Date__c, Last_Modified_Date_Time__pc, Last_Modified_Date_Time__c, Last_Invoice_Date__c, 
                           Last_Activity_Datetime__pc, Last_Activity_Datetime__c, LastName, LastModifiedDate, LastModifiedById, 
                           LastActivityDate, IsPersonAccount, IsDeleted, IsConvertedAccount__c, IsCloneInProgress__c, 
                           Insurance_Cert_Exp__c, Industry_Icon__c, Industry,FirstName, Find_Zip_Code__c, Fax, Family_Code__c, 
                           Expiration_Date__c, Eligible_For_Rebate__c, Dodge_Projects__c, Description, Department_Name__c, 
                           Decision_Maker__pc, Date_Vendor_Approved__c, Damage_Waiver_Expires__c, CurrencyIsoCode, Credit_Status__c, 
                           Credit_Status_Formula__c, Credit_Collector__c, Credit_Collector_Name__c, Created_Date_Time__pc, 
                           Created_Date_Time__c, CreatedDate, CreatedById, Contacted_in_Last_90_Days__c, Contacted_in_Last_30_Days__c, Contact_Owner_Extension__pc, Co_op__c, Co_op_Name__c, Classification__c, Classification_Notes__c, 
                           Classification_Complete__c, CKMS__c, Buyer_Type__c, Branch__pc, Branch__c, Book_Of_Business__c, BillingStreet, BillingState, 
                           BillingPostalCode, BillingCountry, BillingCity, BM_Plan_for_Account__c, AnnualRevenue, Acquisition_Name__c, 
                           Acquisition_Account_Code__c, Account_Icon__c, Account_Anniversary_Date__c, AccountNumber, ABI_Company_Id__c 
                           From Account 
                           where Id =: accountId]){               
            clonedAccount = account.clone(false);
            clonedAccount.IsCloneInProgress__c = true;
            
            /*- When Branch Rep clones account, blank out shipping address and fill in Servicing Branch id on cloned account will be based on user who owns cloned account (from User record).
        - When NSC clones account, blank out shipping address and user will manually enter zip code in Shipping address so that Servicing Branch Id will be populated based on Zip code of Shipping address. (Branch Id for NSC is always 298 so nothing to do on Branch Id or Servicing Branch id in this case)
      */
            if(currentUser.UserRoleId != null && (userRoleNSC.contains(currentUser.UserRole.Name) || userRoleBranch.contains(currentUser.UserRole.Name))){
              clonedAccount.ShippingCity = '';
              clonedAccount.ShippingCountry = '';
              clonedAccount.ShippingPostalCode = '';
              clonedAccount.ShippingState = '';
              clonedAccount.ShippingStreet = '';
              clonedAccount.Servicing_Branch_Id__c = null;
            }
            
            //added for case # 00039090
            clonedAccount.ShadowBranch__c = null;
            if(branchForBM != null && branchForBM != ''){
              clonedAccount.ShadowBranch__c = branchForBM;
            }
        }
        insert clonedAccount;
        return clonedAccount.Id;
    }
    
    //Method to check if the logged in BM has multiple branches
    webservice static Boolean isBMHasMultipleBranches(Id accId){ 
      String usrRoleName = currentUser.UserRole.Name;
      if(usrRoleName.contains(USERROLE_BRANCH_MANAGER)){
        //to find the find the Branch for BM to select the alternative branch while cloning a account record.
        Map<String, BranchMgrWithMultipleBranches__c> mulipleBrnchForBMMap = new Map<String, BranchMgrWithMultipleBranches__c>(BranchMgrWithMultipleBranches__c.getAll());
        
        if(mulipleBrnchForBMMap.containsKey(currentUser.Name)){
          return true;
        }
      }
      
      return false;
    }
    
}