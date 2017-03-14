/**************************************************************************
Name:  QuickQuoteMainDAO()
Copyright ? 2013  MMI
----------------------------------------------------------------------
Purpose:
This class contains the methods for DML operations and database queries
-----------------------------------------------------------------------
History:

VERSION  AUTHOR                 DATE        DETAIL              
1.0  -  TEKsystems             11/2/2013   INITIAL DEVELOPMENT  
**************************************************************************/
public with sharing class QuickQuoteMainDAO {
    
    /*********************************************************************
    Purpose     : To get Lead records
    Parameters  : lead id 
    Returns     : List of Lead records
    **********************************************************************/
    public static List<Lead> getLeadRecord(String leadRecID){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainDAO :getLeadRecord');
        List<Lead> leadRec=null;
        try{
            if(leadRecID!=null){
                leadRec = [Select Id, Name, City, Country, State, Street, PostalCode, Company ,Delivery_City__c,Delivery_Country__c,Delivery_State__c,Delivery_Street__c,Delivery_Postal_Code__c,Branch__c,Servicing_Branch_Id__c,View_Branch_Snapshot__c, FirstName, LastName, Phone, MobilePhone, Email from Lead where Id =: leadRecId limit 1];
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainDAO getLeadRecord:'+e.getMessage());
        }
         system.debug(LoggingLevel.DEBUG,'Entring to  QuickQuoteMainDAO : getLeadRecord()'+leadRec);
        
        return leadRec;
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
    
    
    
    /*********************************************************************
    Purpose     : To get User Branch info
    Parameters  : none
    Returns     : running user record
    **********************************************************************/
    public static User getUserBranchDetails(){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainDAO :getUserDetails');
        User UserRecord=null;
        try{
            
            UserRecord = [select Branch_Id__c, Branch__c,Sales_Rep_Id__c from user where id=: UserInfo.getUserId()];
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainDAO getUserDetails:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  QuickQuoteMainDAO : getUserDetails()'+UserRecord);
        
        return UserRecord;
    }
    
    public static User UserDetails(String userId){
    	return [Select Id,LastName,Branch_Id__c,FirstName,MobilePhone,Country,City,Street,UserRole.Name, UserRoleId, State, PostalCode,Email,Fax,Phone,Extension__c, Name, Sales_Rep_Id__c from User where Id = :userId];
    }
    
    /*********************************************************************
    Purpose     : To get opportunity related to the Lead 
    Parameters  : lead id 
    Returns     : List of opportunity records
    **********************************************************************/
    public static List<Opportunity> getOppRecord(String leadRecID){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainDAO :getOppRecord');
        List<Opportunity> oppRec=null;
        try{
            if(leadRecID!=null){
                 oppRec = [Select Id,Account.Name, name, AccountId, Valid_Address_Id__c,Delivery_City__c,Delivery_Country__c,Delivery_State_Province__c,Delivery_Street__c, Delivery_Zip_Postal_Code__c,Branch__c,Servicing_Branch__c,View_Branch_Snapshot__c,Why_do_you_need_storage__c,
                                When_will_you_need_your_unit__c,
                                What_will_you_be_storing__c,
                                How_often_will_you_need_to_access__c,
                                How_long_will_you_need_your_unit__c,
                                Contact_Name__c,
                                Contact_Phone__c,
                                Contact_Last_Name__c,
                                Next_Activity_Date__c,
                                Who_is_going_to_be_accessing_your_unit__c, Why_do_you_need_storage_Picklist__c, Delivery_Zone__c, of_Units__c, Quote_Comments__c from Opportunity where Id =: leadRecID limit 1];
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainDAO getOppRecord:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  QuickQuoteMainDAO : getOppRecord()'+oppRec);
        
        return oppRec;
    }
    
    /*********************************************************************
    Purpose     : To get Account records
    Parameters  : Account id 
    Returns     : Account records
    **********************************************************************/
    public static Account getAccRecord(String accID){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainDAO :getAccRecord');
        Account accRec=null;
        try{
            if(accID!=null){
                accRec = [Select Id, ShippingCity, ShippingCountry, ShippingPostalCode, ShippingState, ShippingStreet, BillingCity, BillingCountry, BillingPostalCode, BillingState, BillingStreet,Branch__c,Servicing_Branch_Id__c,OwnerId from Account where Id =: accID limit 1 ];
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainDAO getAccRecord:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  QuickQuoteMainDAO : getAccRecord()'+accRec);
        
        return accRec;
    }
    
    /*********************************************************************
    Purpose     : To get Lead Status
    Parameters  : none
    Returns     : Lead status
    **********************************************************************/
    public static LeadStatus getLeadStatus(){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainDAO :getLeadStatus');
        LeadStatus convertStatus=null;
        try{
            
            convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
        
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainDAO getLeadStatus:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  QuickQuoteMainDAO : getLeadStatus()'+convertStatus);
        
        return convertStatus;
    }
    
    /*********************************************************************
    Purpose     : To insert quick quote record
    Parameters  : MMI_Quotes__c object type
    Returns     : opportunity id
    **********************************************************************/
    public static String insertQuickQuote(MMI_Quotes__c quickQuote){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainDAO :insertQuickQuote');
        String oppID=null;
        try{
            if(quickQuote!=null){
                 insert quickQuote;
                 oppID=quickQuote.Opportunity__c;
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainDAO insertQuickQuote:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  QuickQuoteMainDAO : insertQuickQuote()'+oppID);
        
        return oppID;
    }
    
    /*********************************************************************
    Purpose     : To convert lead 
    Parameters  : lead id and owner id 
    Returns     : Database lead conversion result
    **********************************************************************/
    public static Database.LeadConvertResult convertLead(String leadId , String ownerId, QuickQuoteWrapper qqwrapper){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainDAO :convertLead'+ leadId +'--'+ownerId);
        Database.LeadConvertResult leadConverResult=null;
        Database.LeadConvert lc=null;
      
        try{
             
            if(leadId!=null && ownerId!=null){
                Lead leadRec = [Select LeadSource,Id,FirstName,LastName, Name,Industry, City, Country, State, Street, PostalCode, Company ,Delivery_City__c,Delivery_Country__c,Delivery_State__c,Delivery_Street__c,Delivery_Postal_Code__c,Branch__c,Servicing_Branch_Id__c,Email,Phone from Lead where Id =: leadId limit 1];
                lc = new database.LeadConvert();
                lc.setLeadId(leadId);
                lc.setownerId(ownerId);
                account account;
                if(leadRec.Delivery_Country__c!=null){
                    if(leadRec.Company!=null){
                      account = new account(Name=leadRec.Company ,Lead_Source__c = leadRec.LeadSource, Industry = leadRec.Industry, BillingCountry=leadRec.Delivery_Country__c ,Servicing_Branch_Id__c=leadRec.Servicing_Branch_Id__c);
                    }else{
                        account = new account(FirstName=leadRec.FirstName, Lead_Source__c = leadRec.LeadSource, Industry = leadRec.Industry, LastName= leadRec.LastName, BillingCountry=leadRec.Delivery_Country__c,Servicing_Branch_Id__c=leadRec.Servicing_Branch_Id__c);
                    }
                }else if(leadRec.Country!=null){
                    if(leadRec.Company!=null){
                        account = new account(Name=leadRec.Company , Lead_Source__c = leadRec.LeadSource, Industry = leadRec.Industry,  BillingCountry=leadRec.Country,Servicing_Branch_Id__c=leadRec.Servicing_Branch_Id__c);
                    }else{
                        account = new account(FirstName=leadRec.FirstName,LastName= leadRec.LastName , Lead_Source__c = leadRec.LeadSource, Industry = leadRec.Industry, BillingCountry=leadRec.Country,Servicing_Branch_Id__c=leadRec.Servicing_Branch_Id__c);
                    }
                }else{
                    if(leadRec.Company!=null){
                      account = new account(Name=leadRec.Company , BillingCountry='USA',Lead_Source__c = leadRec.LeadSource, Industry = leadRec.Industry, Servicing_Branch_Id__c=leadRec.Servicing_Branch_Id__c);
                    }else{
                        account = new account(FirstName=leadRec.FirstName,LastName= leadRec.LastName,Lead_Source__c = leadRec.LeadSource, Industry = leadRec.Industry,  BillingCountry='USA',Servicing_Branch_Id__c=leadRec.Servicing_Branch_Id__c);
                    }
                }
                if(leadRec.Company == null || leadRec.Company == ''){
                    account.PersonAssistantName = qqwrapper.oppContactName + ' ' + qqwrapper.oppContactLastName;
                    account.PersonAssistantPhone = qqWrapper.oppContactPhone;
                }
                insert account;
                lc.setAccountId(account.id);
                if(!leadRec.Industry.contains('Homeowner')){
                contact contact = new contact(FirstName = qqwrapper.oppContactName, LastName = qqwrapper.oppContactLastName, accountid=account.id,Phone = qqWrapper.oppContactPhone ,Email = leadRec.Email );
                insert contact;
                lc.setContactId(contact.id);
                }
                
                LeadStatus convertStatus =getLeadStatus();
                lc.setConvertedStatus(convertStatus.MasterLabel);
                leadConverResult = Database.convertLead(lc);
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainDAO convertLead:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  QuickQuoteMainDAO : convertLead()'+leadConverResult);
        
        return leadConverResult;
    }
    
    /*********************************************************************
    Purpose     : To get Quick Quote record
    Parameters  : Quick Quote Id 
    Returns     : MMI_Quotes__c records
    **********************************************************************/
    public static MMI_Quotes__c getQuickQuoteRecord(String qqRecID){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainDAO :getQuickQuoteRecord');
        MMI_Quotes__c qqRec=null;
        
        try{
            if(qqRecID!=null){
                qqRec = [Select Zip_Code__c,
                                Transport_Costs__c,
                                Transaction_Type__c,
                                Tax_id__c,
                                Tax__c,
                                Tax_Total__c,
                                SystemModstamp,
                                Suggested_Price__c,
                                Status__c,
                                State__c,
                                Start_Date__c,
                                Selling_Price__c,
                                Reoccurring_Monthly_Charges__c,
                                Rental_Rate__c,
                                Rental_PP_E__c,
                                Rental_PP_E_Total__c,
                                Quote_Id__c,
                                Quick_Quote__c,
                                Quick_Quote_Total__c,
                                Qty__c,
                                QQ_Type__c,
                                Product__c,
                                Pick_Up__c,
                                Pick_Up_Total__c,
                                Opportunity__c,
                                Name,
                                Modification_Charge__c,
                                Minimum_Price__c,
                                Locks__c,
                                Locks_Total__c,
                                Locks_N__c,
                                LastModifiedDate,
                                LastModifiedById,
                                LastActivityDate,
                                LLW__c,
                                LLW_Total__c,
                                IsDeleted,
                                Include_LLW__c,
                                Id,
                                Fulfilling_Branch__c,
                                Fuel_surcharge__c,
                                Fuel_Surcharge_Total__c,
                                Fuel_Surcharge_N__c,
                                Ecode__c,
                                Duration__c,
                                Distance_from_branch__c,
                                Delivery__c,
                                Delivery_Total__c,
                                                                DeliveryZone__c,
                                Date_From__c,
                                CurrencyIsoCode,
                                Cross_Streets__c,
                                CreatedDate,
                                CreatedById,
                                Country__c,
                                City__c,
                                COD__c,
                                COD_Total__c,
                                Branch_id__c,
                                Opportunity__r.Name,
                                Opportunity__r.id,
                                Opportunity__r.Why_do_you_need_storage__c,
                                Opportunity__r.When_will_you_need_your_unit__c,
                                Opportunity__r.What_will_you_be_storing__c,
                                Opportunity__r.How_often_will_you_need_to_access__c,
                                Opportunity__r.How_long_will_you_need_your_unit__c,
                                Opportunity__r.Who_is_going_to_be_accessing_your_unit__c,
                                Opportunity__r.Quote_Comments__c,
                                Opportunity__r.CloseDate,
                                Opportunity__r.On_The_Go__c,
                                Opportunity__r.Contact_Name__c,
                                Opportunity__r.Contact_Phone__c,
                                Opportunity__r.Contact_Last_Name__c,
                                Opportunity__r.Contact__c,
                                Opportunity__r.Why_do_you_need_storage_Picklist__c,
                                Opportunity__r.Unit_Type__c,
                                Opportunity__r.Delivery_Zone__c,
                                
                                Opportunity__r.Servicing_Branch__c,
                                Opportunity__r.Branch__c,
                                When_will_you_need_your_unit__c,
                                Close_Date__c,
                                Longitude__c,
                                Latitude__c,
                                Product_description__c,
                                Security_Deposit__c,
                                Opportunity__r.Opportunity_Contact_Name_LookUpFilter__c,
                                Opportunity__r.of_Units__c,
                                Unit_Type__c,
                                Address__c from MMI_Quotes__c where id =: qqRecID
                                limit 1];
                 
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainDAO getQuickQuoteRecord:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  QuickQuoteMainDAO : getQuickQuoteRecord()'+qqRec);
        
        return qqRec;
    }
    
    
    /*********************************************************************
    Purpose     : To update quick quote record
    Parameters  : MMI_Quotes__c object type
    Returns     :boolean type
    **********************************************************************/
    public static Boolean updateQuickQuotes(MMI_Quotes__c quickQuote){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainDAO :updateQuickQuotes');
        Boolean isUpdated=false;
        try{
            if(quickQuote!=null){
                 update quickQuote;
                 isUpdated=true;
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainDAO updateQuickQuotes:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  QuickQuoteMainDAO : updateQuickQuotes()'+isUpdated);
        return isUpdated;
    }
    
    /*********************************************************************
    Purpose     : To get opportunity after insert quick quote  
    Parameters  : id 
    Returns     : opportunity records
    **********************************************************************/
    public static Opportunity getOppToUpdate(String oppId){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainDAO :getOppToUpdate');
        Opportunity oppRec=null;
        try{
            if(oppId!=null){
                 oppRec = [Select Quote_type__c,Id, name,AccountId,Account.IsPersonAccount, Account.Name,Product_Type__c,Unit_Type__c,Transaction_Type__c,of_Units__c,Type_of_Quote_Given__c,
                 Delivery_Rate_Incl_Fuel__c,Pick_up_Rate_Incl_Fuel__c,Quote_Comments__c,StageName,Why_do_you_need_storage__c,Base_Price__c,
                 When_will_you_need_your_unit__c,CloseDate,What_will_you_be_storing__c,How_often_will_you_need_to_access__c,
                 How_long_will_you_need_your_unit__c,Who_is_going_to_be_accessing_your_unit__c,On_The_Go__c,
                LLW__c,PPE__c,Contact__c, Contact_Mobile__c, Contact_Email__c,Opportunity_Contact_Name_LookUpFilter__c,Opportunity_Contact_Name_LookUpFilter__r.Phone, Primary_Contact_Number__c, Why_do_you_need_storage_Picklist__c, Delivery_Zone__c from Opportunity where Id = :oppId limit 1];
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainDAO getOppToUpdate:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  QuickQuoteMainDAO : getOppToUpdate()'+oppRec);
        
        return oppRec;
    }
    
    /*********************************************************************
    Purpose     : To get opportunity after insert quick quote  
    Parameters  : id 
    Returns     : opportunity records
    **********************************************************************/
    public static String updateOppName(Opportunity opp){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainDAO :updateOppName');
        try{
            if(opp!=null){
                 update opp;
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainDAO updateOppName:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  QuickQuoteMainDAO : updateOppName()'+opp.Id);
        
        return opp.Id;
    }
    
    
    /*********************************************************************
    Purpose     : To get opportunity related to the Lead 
    Parameters  : lead id 
    Returns     : List of opportunity records
    **********************************************************************/
    public static List<Account> getAccountList(String leadRecID){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainDAO :getAccountList');
        List<Account> accRec=null;
        try{
            if(leadRecID!=null){
                 accRec = [Select Result_Id__c,Id,Name, ShippingCity, ShippingCountry, ShippingPostalCode, ShippingState, ShippingStreet, BillingCity, BillingCountry, BillingPostalCode, BillingState, BillingStreet,Branch__c,Servicing_Branch_Id__c,OwnerId from Account where Id =: leadRecID limit 1];
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainDAO getAccountList:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  QuickQuoteMainDAO : getAccountList()'+accRec);
        
        return accRec;
    }
    
    
    /*********************************************************************
    Purpose     : To Insert opportunity  
    Parameters  : id 
    Returns     : opportunity records
    **********************************************************************/
    public static String insertOpportunity(Opportunity opp){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainDAO :insertOpportunity');
        try{
            if(opp!=null){
                 insert opp;
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainDAO insertOpportunity:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Entring to  QuickQuoteMainDAO : insertOpportunity()'+opp.Id);
        
        return opp.Id;
    }
    
    /*********************************************************************
    Purpose     : create capacity lookup payload  
    Parameters  :  
    Returns     : HomeBaseBeans.capacityLookupRequest
    **********************************************************************/
    public static HomeBaseBeans.capacityLookupRequest createCapLkupPayload(String latitudeForCapLukp, String longitudeForCapLukp, QuickQuoteWrapper qqWrapper, String leadRecId, DateTime delvDate, String selectedProdDescForCapLkup){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainDAO :createCapLkupPayload');
        HomeBaseBeans.capacityLookupRequest clr = null;
        try{
            if(longitudeForCapLukp != null && latitudeForCapLukp != null){
                clr = new HomeBaseBeans.capacityLookupRequest();
                clr.addressLine1 = qqWrapper.Address;
                clr.City = qqWrapper.City;
                clr.countryCode = qqWrapper.Country;
                clr.postalCode = qqWrapper.ZipCode;
                clr.stateCode = qqWrapper.State;
                clr.sellingStoreNumber = qqWrapper.FulfillingBranch;
                clr.longitude = longitudeForCapLukp;
                clr.latitude = latitudeForCapLukp; 
                clr.BranchId = FullQuoteDAO.getBranchId(qqWrapper.FulfillingBranch, leadRecId);
                DateTime ScheduleDelvDate = system.now();
                if(delvDate != null){
                    ScheduleDelvDate = delvDate;
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
                    /*if(selectedProdDescForCapLkup == null || selectedProdDescForCapLkup == ''){
                        clr.itemName = '';
                        clr.itemDescription = '';
                    }*/
                }
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainDAO insertOpportunity:'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'Exiting from  QuickQuoteMainDAO : createCapLkupPayload'+clr);
        return clr;
    }
    
     //--------------methodes for qq from JP----------------------------------------
    /*********************************************************************
    Purpose     : To get Contact records
    Parameters  : Contact id 
    Returns     : Contact Obj rec records
    **********************************************************************/
    public static Contact getContactRecord(String RecID){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainDAO :getContactRecord');
        Contact ContactRec = null;
        try{
            if(RecID != null){
                ContactRec = [Select Id, FirstName, LastName,Phone, AccountId,MobilePhone,Email,Result_Id__c from Contact where Id = :RecID];
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainDAO getContactRecord:'+e.getMessage());
        }
         system.debug(LoggingLevel.DEBUG,'Entring to  QuickQuoteMainDAO : getContactRecord()'+ContactRec);
        
        return ContactRec;
    }
    
    
    /*********************************************************************
    Purpose     : To get Job_Profile__c records
    Parameters  : Job_Profile__c id 
    Returns     : Job_Profile__c Obj rec records
    **********************************************************************/
    public static Job_Profile__c getJobProfRecord(String RecID){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainDAO :getJobProfRecord');
        Job_Profile__c jpRec = null;
        try{
            if(RecID != null){
                jpRec = [Select j.Name, j.Job_Site_Zip__c, j.Job_Site_State__c, j.Job_Site_County__c, j.Job_Site_Country__c, j.Job_Site_City__c, j.Job_Site_Address__c, j.Job_Profile_Name__c, j.Id From Job_Profile__c j where Id = :RecID];
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainDAO getJobProfRecord:'+e.getMessage());
        }
         system.debug(LoggingLevel.DEBUG,'Entring to  QuickQuoteMainDAO : getJobProfRecord()'+jpRec);
        
        return jpRec;
    }
    
    /*********************************************************************
    Purpose     : To get Sub_Contractor__c records
    Parameters  : Sub_Contractor__c id 
    Returns     : Sub_Contractor__c Obj rec records
    **********************************************************************/
    public static Sub_Contractor__c getSCRecord(String RecID){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainDAO :getSCRecord');
        Sub_Contractor__c scRec = null;
        try{
            if(RecID != null){
                scRec = [Select s.Role__c, s.Name, s.Id, s.Account__c, s.Account_Name__c From Sub_Contractor__c s where Id = :RecID];
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainDAO getSCRecord:'+e.getMessage());
        }
         system.debug(LoggingLevel.DEBUG,'Entring to  QuickQuoteMainDAO : getSCRecord()'+scRec);
        
        return scRec;
    }
    
    /*********************************************************************
    Purpose     : To create a task
    Parameters  : Job_Profile__c id 
    Returns     : None
    **********************************************************************/
    public static void createTaskForQQCreatedFromJP(String jpRecID, String QuoteName){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainDAO :createTaskForQQCreatedFromJP');
        try{
            Task taskObj = new Task();
            taskObj.OwnerId = UserInfo.getUserId();
            if(QuoteName == 'qq'){
                taskObj.Subject = 'Quick Quote';
            }
            if(QuoteName == 'fq'){
                taskObj.Subject = 'Full Quote';
            }
            taskObj.ActivityDate = system.today();
            taskObj.Call_Type__c = 'Email';
            taskObj.Call_Result__c = '';
            taskObj.Description = '';
            taskObj.Status = 'Completed';
            taskObj.Priority = 'Normal'; 
            taskObj.WhatId = jpRecID;
            insert taskObj;
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainDAO createTaskForQQCreatedFromJP:'+e.getMessage());
        }
    }
    
    /*********************************************************************
    Purpose     : To create a task after QQ is saved
    Parameters  : WhatId,QuoteName,followup date, WhoId
    Returns     : None
    **********************************************************************/
    public static void createTaskAfterQQCreationForFollowUpCall(String RelatedRecID, String QuoteName, Date followUp, String ContactId, QuickQuoteWrapper qqwrapper){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainDAO :createTaskAfterQQCreationForFollowUpCall');
        try{
            Task taskObj = new Task();
            taskObj.OwnerId = UserInfo.getUserId();
            if(QuoteName == 'qq'){
                taskObj.Subject = 'Follow Up on Quick Quote';
            }
            if(QuoteName == 'fq'){
                taskObj.Subject = 'Follow Up on Full Quote';
            }
            taskObj.ActivityDate = followUp;
            taskObj.Call_Type__c = 'OB - Sales & Marketing'; // TFS 3944
            taskObj.Call_Result__c = '';
            taskObj.Description = qqwrapper.followUpTaskComments;
            taskObj.Status = 'Not Started';
            taskObj.Priority = 'Normal'; 
            taskObj.WhatId = RelatedRecID;
            taskObj.WhoId = ContactId;
            insert taskObj;
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainDAO createTaskAfterQQCreationForFollowUpCall:'+e.getMessage());
        }
    }
    
    /*********************************************************************
    Purpose     : To check wheather a follow up task is already present or not
    Parameters  : Opportunity Id
    Returns     : Boolean (true / false)
    **********************************************************************/
    public static Boolean isFollowUptaskPresent(String RelatedRecID){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainDAO :isFollowUptaskPresent');
        Boolean isPresent  = false;
        try{
            if(RelatedRecID != null && RelatedRecID != ''){
            		list<Task> taskRecordList = [Select t.Subject, t.Id From Task t where t.WhatId = :RelatedRecID and t.Status != 'Completed' and (t.Subject = 'Follow Up on Quick Quote' or t.Subject = 'Follow Up on Full Quote')];
            		if(taskRecordList != null && !taskRecordList.isEmpty()){
            			isPresent = true;
            		}
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainDAO :isFollowUptaskPresent:'+e.getMessage());
        }
        return isPresent;
    }
    
    /*********************************************************************
    Purpose     : To get the dispatcher email id
    Parameters  : branch id
    Returns     : Email id
    **********************************************************************/
    public static string getDispatcherEmailId(String branchId){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainDAO :getDispatcherEmailId');
        String EmailId = '';
        try{
        	if(branchId != null && branchId != ''){
        		Email_dispatcher_Map__c edmObj = null;
        		list<Email_dispatcher_Map__c> edmObjList = [select Id, Name, Dispatcher_Email__c from Email_dispatcher_Map__c where Name = :branchId ];
        		if(!edmObjList.isEmpty() && edmObjList.size() > 0){
        			EmailId = edmObjList[0].Dispatcher_Email__c;
        		}else{
        			EmailId = branchId+'_Dispatch@mobilemini.com';
        		}
        	}
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainDAO getDispatcherEmailId:'+e.getMessage());
        }
        return EmailId;
    }
    
    /*********************************************************************
    Purpose     : Send the mail to Dispatcher branch
    Parameters  : Email body related data
    Returns     : email sending result (success / error)
    **********************************************************************/
    
    public static string SendEmailToBranch(HomeBaseBeans.knowZoneRatesEmailParam paramObj){
    	//get dispatcher email from custom Setting
        String associated = '';
        if(paramObj.fulfillingBranchId != null && paramObj.fulfillingBranchId != ''){
        	/*String branchId = paramObj.fulfillingBranchId;
	        List<Email_Dispatcher__c> emailDispatcherList = null;
	        map<String,String> mapBranchEmail = new map<String,String>();
	        emailDispatcherList = Email_Dispatcher__c.getAll().Values();
	        if(emailDispatcherList != null && !emailDispatcherList.isEmpty()){
	              String branchEmailList = emailDispatcherList.get(0).Branch_Email_Combination__c;
	              list<String> lstBranchEmailList = branchEmailList.split(',');
	              for(String s : lstBranchEmailList){
	                    list<String> branchEmail = s.split('_');
	                    mapBranchEmail.put(branchEmail[0],branchEmail[1]);
	              }
	     	 }
	        if(mapBranchEmail.containsKey(branchId)){
	        	associated  = mapBranchEmail.get(branchId) +'_Dispatch@mobilemini.com';
	        }else{
	        	associated  = branchId +'_Dispatch@mobilemini.com';
	        }*/
	        associated = getDispatcherEmailId(paramObj.fulfillingBranchId);
	        system.debug('----------------associated------------------'+associated);
	        String sfdcBaseUrl = URL.getSalesforceBaseUrl().toExternalForm();
	        if(sfdcBaseUrl.startsWith('https://cs')){
	        	associated = 'cranade@mobilemini.com';
	        }
	        //associated = 'maity.it@gmail.com';
	        if(associated != null && associated != ''){
	            String Mailbody = '';
	            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
	            String[] toAddresses = new String[] {associated}; 
	            list<String> ccAddresses = new list<String>();
	            if(paramObj.loggedInUserEmail != null && paramObj.loggedInUserEmail != ''){
	            	ccAddresses.add(paramObj.loggedInUserEmail);
	            }
	            
	            if(paramObj.sfdcAccOwnerEmail != null && paramObj.sfdcAccOwnerEmail != ''){
	            	ccAddresses.add(paramObj.sfdcAccOwnerEmail);
	            }
	            mail.setToAddresses(toAddresses);
	            system.debug('--------------ccAddresses----------------------'+ccAddresses);
	            system.debug('--------------toAddresses----------------------'+toAddresses);
	            if(sfdcBaseUrl.startsWith('https://cs')){
		        	ccAddresses = new list<String>();
		        }
	            if(!ccAddresses.isEmpty() && ccAddresses.size() > 0){
	            	mail.setCcAddresses(ccAddresses);
	            }
	            
	            Mailbody = ' Please provide the Delivery and Pick Up charges to Quote for Shipping Address <br/><br/>';
	            if(paramObj.oppId != null && paramObj.oppId != '' && paramObj.quoteType == 'qq'){
	            	Mailbody += 'Opportunity : '+URL.getSalesforceBaseUrl().toExternalForm() + '/' + paramObj.oppId +'<br/><br/>';
	            }
	            Mailbody += 'Shipping Address : <br/><br/>';
	            if(paramObj.quoteType == 'qq'){
		            Mailbody += 'Address : '+paramObj.qqWrapper.Address+'<br/>';
		            Mailbody += 'City : '+paramObj.qqWrapper.City+'<br/>';
		            Mailbody += 'State : '+paramObj.qqWrapper.State+'<br/>';
		            Mailbody += 'Country : '+paramObj.qqWrapper.Country+'<br/>';
		            Mailbody += 'Zip : '+paramObj.qqWrapper.ZipCode+'<br/><br/>';
		            Mailbody += 'Item Code : '+paramObj.itemCode+'<br/>';
		            if(paramObj.qqWrapper.Duration != null && paramObj.qqWrapper.Duration != '' && paramObj.qqWrapper.Duration != '0' ){
		            	Mailbody += 'Rental Duration : '+paramObj.qqWrapper.Duration+'<br/>';
		            }
	            }
	            if(paramObj.quoteType == 'fq'){
		            /*Mailbody += 'Account Number : '+paramObj.fullQWrapper.AccountId+'<br/>';
		            Mailbody += 'Account Name : '+paramObj.fullQWrapper.AccountName+'<br/>';*/
		            if(paramObj.fullQWrapper.AccountId != null && paramObj.fullQWrapper.AccountId != ''){
			            Mailbody += 'Account # : '+paramObj.fullQWrapper.AccountId+'<br/>';
		            }
		            if(paramObj.fullQWrapper.AccountName != null && paramObj.fullQWrapper.AccountName != ''){
			            Mailbody += 'Account Name : '+paramObj.fullQWrapper.AccountName+'<br/>';
		            }
		            if(paramObj.oppId != null && paramObj.oppId != ''){
		            	Mailbody += 'Opportunity : '+URL.getSalesforceBaseUrl().toExternalForm() + '/' + paramObj.oppId +'<br/>';
		            }
		            Mailbody += 'Address : '+paramObj.fullQWrapper.AddressInShippingDates+'<br/>';
		            Mailbody += 'City : '+paramObj.fullQWrapper.cityInShippingDates+'<br/>';
		            Mailbody += 'State : '+paramObj.fullQWrapper.stateInShippingDates+'<br/>';
		            Mailbody += 'Country : '+paramObj.fullQWrapper.countryInShippingDates+'<br/>';
		            Mailbody += 'Zip : '+paramObj.fullQWrapper.ZipCodeInShipping+'<br/><br/>';
		            Mailbody += 'Item Code : '+paramObj.itemCode+'<br/><br/>';
		            if(paramObj.fullQWrapper.rentalLengthInProduct != null && paramObj.fullQWrapper.rentalLengthInProduct != '' && paramObj.fullQWrapper.rentalLengthInProduct != '0' && paramObj.fullQWrapper.selectedFullQUote != 'sales'){
		            	Mailbody += 'Rental Duration : '+paramObj.fullQWrapper.rentalLengthInProduct+'<br/><br/>';
		            }
		            
	            }
	            Mailbody += '<br/>Thank you';
	            mail.setHtmlBody(Mailbody);
	            mail.setSubject('Delivery and Pick-Up Charges Needed ['+paramObj.itemCode+']');
	            if(!test.isRunningTest()){
	            	List<Messaging.SendEmailResult> emailResults = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
	            	if (!emailResults.get(0).isSuccess()) {
					    //System.StatusCode statusCode = emailResults.get(0).getErrors()[0].getStatusCode();
					    String errorMessage = emailResults.get(0).getErrors()[0].getMessage();
					    return errorMessage;
					}else{
						return 'Mail has been sent successfully!';
					}
	            }   
	         }else{
	         	return 'No dispatcher Email Id found!';
	         }
        }else{
        	return 'Mail sending failed. No Fullfilling Branch Id found!';
        }
        return null;
    }
    
    /*********************************************************************
    Purpose     : To get Product Def Code
    Parameters  : Item Code
    Returns     : List of Product and def code records
    **********************************************************************/
    public static List<Product_And_Def_Code__c> getLstProductAndDefCode(String itemCode){
        system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteMainDAO :getLstProductAndDefCode');
        List<Product_And_Def_Code__c> ProductAndDefCodeRec = null;
        try{
            if(itemCode != null){
                ProductAndDefCodeRec = [Select Id, Name, Def_Code__c, Description__c from Product_And_Def_Code__c where Name = :itemCode];
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteMainDAO getLstProductAndDefCode:'+e.getMessage());
        }
         system.debug(LoggingLevel.DEBUG,'Exiting to  QuickQuoteMainDAO : getLstProductAndDefCode()'+ProductAndDefCodeRec);
        
        return ProductAndDefCodeRec;
    }
}