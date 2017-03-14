/**
* (c) 2015 TEKsystems Global Services
*
* Name           : ViewMoreController 
* Created Date   : 29, Sep 2015 
* Created By     : Vivek (TEKSystems)
* Purpose        : This is class to convert a Lead from the new quote button(Lead detail page).
* Last Updated By: Ankur Goyal (TEKSystems)
* Last Updated Date: 18-Jan-2016
**/

global class ConvertLeadForCPQ{

    webservice static String convertlead(ID Idd, String FirstName, String company, String LastName, String zip,Id owner,String city,String state,String country,string street, string billingzip,string billingcity, string billingstate, string billingcountry, string billingstreet)
    {
    
        Account newAccount = new Account();
        Opportunity newOpportunity = new Opportunity();
        Contact Con = new Contact ();
        String salesOrgID;
        String cpqURL;
        String portalURL;
        String contactId;
        String branchID;
        Database.LeadConvert lc = new Database.LeadConvert();
        boolean isETS = false;

        String recId = [select id,name,recordtypeid from Lead where id =:Idd].recordtypeid;
        //String recName = [select id,name from RecordType where id =: recId].name;
        String recName = Schema.SObjectType.Lead.getRecordTypeInfosById().get(recId).getName();
        
        //String etsID = [select id,name from RecordType where name = 'ETS/WMI'].ID;
        String etsID = Schema.SObjectType.Account.getRecordTypeInfosByName().get('ETS/WMI').getRecordTypeId();
        //String busID = [select id,name from RecordType where name = 'Business Account'].ID;
        String busID = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Business Account').getRecordTypeId();
        //String busUKID = [select id,name from RecordType where name = 'Business Account - UK'].ID;
        String busUKID = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Business Account - UK').getRecordTypeId();
        //String resID = [select id,name from RecordType where name = 'Residential Account'].ID;
        String resID = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Residential Account').getRecordTypeId();
        //String resUKID = [select id,name from RecordType where name = 'Residential Account - UK'].ID;
        String resUKID = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Residential Account - UK').getRecordTypeId();
        //String etsRentalOppID = [select id,name from RecordType where name = 'ETS Rental'].ID;
        String etsRentalOppID = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('ETS Rental').getRecordTypeId();
        if(string.valueof(recName).containsIgnorecase('ETS')){
              newAccount.recordtypeid = etsID;   //'ETS_WMI';
              isETS = true; 
        }
        
        newAccount.shippingstreet = street;
        newAccount.shippingcity = city;
        newAccount.shippingstate = state;
        newAccount.shippingcountry = country;
        newAccount.shippingpostalcode = zip;
        
        newAccount.billingstreet = billingstreet;
        newAccount.billingcity = billingcity;
        newAccount.billingstate = billingstate;
        newAccount.billingcountry = billingcountry;
        newAccount.billingpostalcode = billingzip;
         
        if(String.isblank(company)){
          newAccount.FirstName = FirstName;
          newAccount.LastName = LastName;
          
          if(string.valueof(recName).containsIgnorecase('Glenigan')){
              newAccount.recordtypeid = resUKID;   // 'Residential_Account_UK';
          }
          
          if(string.valueof(recName).containsIgnorecase('Profile')){
              newAccount.recordtypeid = resID;   // 'ResidentialAccount';
          }
          
          if(string.valueof(recName).containsIgnorecase('UK')){
              newAccount.recordtypeid = resUKID;   // 'Residential_Account_UK';
          }
          
          if(string.valueof(recName).containsIgnorecase('Web')){
              newAccount.recordtypeid = resID;   // 'ResidentialAccount';
          }
          
          if(string.valueof(recName).containsIgnorecase('PEC')){
              newAccount.recordtypeid = resID;   // 'ResidentialAccount';
          }
          
          if(string.valueof(recName).containsIgnorecase('Standard')){
              newAccount.recordtypeid = resID;   // 'ResidentialAccount';
          }
          
          insert newAccount;
                    
          //newOpportunity.name = FirstName + LastName;
          //newOpportunity.AccountId = newAccount.id;
          lc.setOpportunityName(FirstName + LastName);
          contactId = [select PersonContactID from account where id = :newAccount.ID].PersonContactID;
        }
        else{
        
          newAccount.name = company;
          
          if(string.valueof(recName).containsIgnorecase('Glenigan')){
              newAccount.recordtypeid = busUKID;   // 'Business_Account_UK';
          }
          
          if(string.valueof(recName).containsIgnorecase('Profile')){
              newAccount.recordtypeid = busID;   // 'Business_Account';
          }
          
          if(string.valueof(recName).containsIgnorecase('UK')){
              newAccount.recordtypeid = busUKID;   // 'Business_Account_UK';
          }
          
          if(string.valueof(recName).containsIgnorecase('Web')){
              newAccount.recordtypeid = busID;   // 'Business_Account';
          }
          
          if(string.valueof(recName).containsIgnorecase('PEC')){
              newAccount.recordtypeid = busID;   // 'Business_Account';
          }
          
          if(string.valueof(recName).containsIgnorecase('Standard')){
              newAccount.recordtypeid = busID;   // 'Business_Account';
          }
          
          insert newAccount;
          
          //newOpportunity.name = company;
          //newOpportunity.AccountId = newAccount.id;
          lc.setOpportunityName(company);
          
          Con.AccountId = newAccount.id;
          Con.FirstName = FirstName;
          Con.LastName = LastName;
          insert Con;              
          contactId = Con.Id;
        }
        
        
        
        Account a = [select Sales_Org__c from Account where ID= :newAccount.Id];
        if(a != null)
        {
          salesOrgID = a.Sales_Org__c;
        }
        else{
          salesOrgID = '' ;
        }
        
        lc.setLeadId(Idd);
        lc.setAccountId(newAccount.id);
        if(!String.isblank(company))
        lc.setContactId(Con.id);
        lc.setConvertedStatus('Qualified');
        
        if(string.valueOf(owner).startsWith('00G'))
        {
          lc.setOwnerId(UserInfo.getUserId());
        }
        
        Database.LeadConvertResult lcr = Database.convertLead(lc);
        
        String oppId = lcr.getOpportunityId();
        Opportunity op = [select id,name,recordtypeid from opportunity where id=: oppId];
        //String stUKID = [select id,name from RecordType where name = 'Standard Opportunity - UK'].ID;
        String stUKID = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity - UK').getRecordTypeId();
        //String stID = [select id,name from RecordType where name = 'Standard Opportunity'].ID;
        String stID = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity').getRecordTypeId();
        op.Opportunity_Contact_Name_LookUpFilter__c = contactId;
        op.StageName = 'Quoted - No Decision';
        op.Opportunity_Rating__c = 'Hot (Probably Order)';
        op.CloseDate = date.today() + 21;
        op.From_New_Quote__c = True;
        if(string.valueof(recName).containsIgnorecase('Glenigan') || string.valueof(recName).containsIgnorecase('UK')){
            op.recordtypeid = stUKID;
        }
        else if (string.valueof(recName).containsIgnorecase('ETS')){
            op.recordtypeid = etsRentalOppID;    
        }
        else{
            op.recordtypeid = stID;
        }
        update op;
        
        Shipto__c sh = new Shipto__c();
        sh.Zip__c = zip;
        sh.Account__c = newAccount.id;
        sh.City__c = city;
        sh.State__c = state;
        sh.Country__c = country;
        sh.Address__c = street;
        insert sh;
        
        String uid = UserInfo.getUserID();
        String uemail = UserInfo.getUserEmail();
        cpqURL = '';
        portalURL = '';
        String curHost = System.URL.getSalesforceBaseUrl().getHost();
        for(CPQActiveURL__c cu: CPQActiveURL__c.getAll().values()){
            if(curHost.containsignorecase(cu.Environment__c)){
                cpqURL = cu.CPQ_URL__c;
                portalURL = cu.Portal_URL__c;
            }
        }
        
        if(salesOrgID == '1500' || salesOrgID == '1501')
        {
            branchID = [select id,name,ETS_WMI_Branch_ID__c,Branch_Id__c from User where Id = :UserInfo.getUserId()].ETS_WMI_Branch_ID__c;
        }
                
        //return String.valueOf( new PageReference('/'+</span>Case.Id<span>).getUrl());
        //return String.valueOf( new PageReference(cpqURL+'?cpq=true&'+'account='+newAccount.id+'&'+'uid='+uid+'&'+'contact='+Con.id+'&'+'Opportunity='+lcr.getOpportunityId()+'&'+'mode=create'+'&'+'salesorg='+salesOrgID).getUrl());
          if(salesOrgID == '1500' || salesOrgID == '1501')
              return String.valueOf( new PageReference(cpqURL+'/discovery?accountId='+newAccount.id+'&'+'uid='+uid+'&'+'contactId='+contactId+'&'+'Opportunity='+lcr.getOpportunityId()+'&'+'sales_org='+salesOrgID+'&branchId='+branchID+'&emailId='+uemail).getUrl());    
          else    
              return String.valueOf( new PageReference(cpqURL+'/discovery?accountId='+newAccount.id+'&'+'uid='+uid+'&'+'contactId='+contactId+'&'+'Opportunity='+lcr.getOpportunityId()+'&'+'sales_org='+salesOrgID+'&emailId='+uemail).getUrl());
        //return String.valueOf( new PageReference(cpqURL+'/discovery?accountId='+newAccount.id+'&contactId='+Con.id+'&sales_org='+salesOrgID).getUrl());
    }
}