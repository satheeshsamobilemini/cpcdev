public class UpdateAcctShippingAddr {

    //Update the Shipping address on the Account with the Delivery Address from the lead
    Public Static VOID processConvertedLeads(List<Lead> matchingLeadList, List<ID> convertedAccountsIDs){
    
        List<Account> convertedAccounts = [select id, ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode, ShippingCountry from Account where ID in :convertedAccountsIDs];
        
        // Create a map -- Lead to Account
        Map<ID, Lead> matchingLeadMap = new Map<ID, Lead>();
    
        // Loop through the Lead list and build the map
        for (integer i=0;i<matchingLeadList.size();i++){
        
            matchingLeadMap.put(convertedAccountsIDs[i], matchingLeadList[i]);
        
        }
        
        Lead l = New Lead();
        
        // Loop through the Accounts and update the Shipping Addr
        for (integer i=0;i<convertedAccounts.size();i++){
    
            l = matchingLeadMap.get(convertedAccounts[i].Id);
            
            if (l != NULL){
            
                convertedAccounts[i].ShippingStreet = l.Delivery_Street__c;
                convertedAccounts[i].ShippingCity = l.Delivery_City__c;
                convertedAccounts[i].ShippingState = l.Delivery_State__c;
                convertedAccounts[i].ShippingPostalCode = l.Delivery_Postal_Code__c;
                convertedAccounts[i].ShippingCountry = l.Delivery_Country__c;
            
            }
    
        }
        
        update convertedAccounts;
        
        //copy accounts SB to Opportunity SB
        Map<Id,Account> mapConvertedAccounts = new Map<Id,Account>([Select Id,Servicing_Branch_Id__c From Account Where Id IN : convertedAccountsIDs]);
        List<Opportunity> convertedOpportunities = new List<Opportunity>();
        for(Lead matchingLead : matchingLeadList){
            if(matchingLead.convertedOpportunityId != null){
                convertedOpportunities.add(new Opportunity(Id = matchingLead.convertedOpportunityId , 
                                                           Servicing_Branch__c = mapConvertedAccounts.get(matchingLead.convertedAccountId).Servicing_Branch_Id__c));
                                                           
            }           
        }
        update convertedOpportunities;
        
    
    }
    
    static testMethod void myUnitTest() {
    
        String SalesUserID = '';    
        //User salesAccountUserID = [Select Id from User where name = 'Mark Schultz'];
        SalesUserID = UserInfo.getUserId();//salesAccountUserID.Id;    
    	//4.5.2013-Case40559-LSLEVIN Industry added to creation of lead below-START
        Lead myLead = new Lead(lastname = 'Apex', company='Apex Test Lead', ownerid = SalesUserID, delivery_city__c = 'Pine City', Industry='4-Institutional');
        //END
        insert myLead;
        system.debug('Lead  ID -->' + myLead.id);

        mylead.Delivery_Street__c = '1234 Pine Street';
        
        update myLead;

        //mylead.Delivery_Postal_Code__c = '1234 Pine Street';        
        mylead.Delivery_Postal_Code__c = '1234';
        mylead.Delivery_Country__c = 'USA';
        
        update myLead;
        
        Database.LeadConvert lc = new database.LeadConvert();
        lc.setLeadId(myLead.id);
        
        LeadStatus convertStatus = [Select Id, MasterLabel from LeadStatus where IsConverted=true
        limit 1];
        
        lc.setConvertedStatus(convertStatus.MasterLabel);
        
        Database.LeadConvertResult lcr = Database.convertLead(lc);
        System.assert(lcr.isSuccess());

        system.debug('LCR Account ID = ' + lcr.getAccountID()); 

        Account convertedAccount = [select id, ShippingCountry FROM Account where Id = :lcr.getAccountID()];

        system.AssertEquals(mylead.Delivery_Country__c, convertedAccount.ShippingCountry);

        Lead myLead2 = new Lead(lastname = 'Apex', company='Apex Test Lead', ownerid = SalesUserID, delivery_city__c = 'Pine City');
        insert myLead2;
        system.debug('Lead  ID -->' + myLead.id);

        mylead2.company = 'Apex Test Lead 2';
        
        update myLead2;
        
        system.AssertEquals(mylead2.Delivery_Street__c, NULL);
        
        delete myLead2;


        //delete lcr.getAccountID();
        //delete lcr.getContactID();
        //delete lcr.getOpportunityid();
        //delete lcr.getLeadid();

    }

}