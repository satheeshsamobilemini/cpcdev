/*
* (c) 2015 TEKsystems Global Services
*
* Name           : RoutingLogic
* Created Date   : 07 Oct, 2015 @ 0130
* Created By     : Shankar Rao
* Purpose        : Test class to cover RoutingLogic class.
* 
*/
@isTest
private class RoutingLogicTest {
    
    //Shankar - Set up test data
    @testSetup
    static void setup(){
        List<Branch_Lookup__c> branchList = new List<Branch_Lookup__c>(); 
            
            branchList.add(new Branch_Lookup__c(Territory__c='128-03', Selling_Region__c=6, Zip__c='30315', 
                                                Branch_Name__c='128 - Atlanta GA', Branch_Code__c='128', 
                                                Country__c='USA', NSC_Team_Live__c=true, Time_Zone__c='East'));
            
            branchList.add(new Branch_Lookup__c(Territory__c='167-01', Selling_Region__c=7, Zip__c='31527', 
                                                Branch_Name__c='167 - Charleston SC', Branch_Code__c='167', 
                                                Country__c='USA', NSC_Team_Live__c=true, Time_Zone__c='East'));
        insert branchList;
        
        Id leadRecordTypeId = Schema.SObjectType.Lead.RecordTypeInfosByName.get('Standard Lead').RecordTypeId;
        Lead newLead = new Lead(FirstName='Shankar', LastName='Rao', Status='Open', Company='Allegis Inc', Phone='30705055', 
                                LeadSource='Direct Mail', Delivery_Postal_Code__c='31527', Delivery_Country__c='USA');
        insert newLead;
        system.debug('New Lead: '+newLead);
        
        Task t1 = new Task(WhoId = newLead.Id,Status='Inbound Call');
        insert t1;
                      
        Id accRecordTypeId = Schema.SObjectType.Account.RecordTypeInfosByName.get('Business Account').RecordTypeId;
        List<Account> newAccList = new List<Account>();
                      newAccList.add(new Account(Name='Allegis Inc', CurrencyIsoCode='USD', 
                                     Type='Prospect - Branch Business Account', BillingStreet='1826 W MCDOWELL', 
                                     BillingCity='PHOENIX', BillingState='AZ', BillingPostalCode='31527', BillingCountry='USA',
                                     RecordTypeId=accRecordTypeId));
                      newAccList.add(new Account(Name='TEKsystems', CurrencyIsoCode='USD', 
                                     Type='Prospect - Branch Business Account', BillingStreet='1826 W MCDOWELL', 
                                     BillingCity='PHOENIX', BillingState='AZ', BillingPostalCode='30315', BillingCountry='USA',
                                     RecordTypeId=accRecordTypeId));
        insert newAccList;
        system.debug('New Account: '+newAccList);
        
        Contact newCnt = new Contact(AccountId=newAccList[0].Id, FirstName=newLead.FirstName, LastName=newLead.LastName, 
                                     CurrencyIsoCode='USD', Decision_Maker__c='Yes', Phone=newLead.Phone);
        insert newCnt;
        system.debug('New Contact: '+newCnt);
        
        Task t = new Task(Status='Inbound Call',WhatId=newAccList[0].Id);
        insert t;
        
        Id oppRecordTypeId = Schema.SObjectType.Opportunity.RecordTypeInfosByName.get('Standard Opportunity').RecordTypeId;
        List<Opportunity> newOpp = new List<Opportunity>();
                
            newOpp.add(new Opportunity(AccountId=newAccList[0].Id, RecordTypeId=oppRecordTypeId, Name=newAccList[0].Name, 
                       CurrencyIsoCode=newAccList[0].CurrencyIsoCode, CloseDate=System.today().addDays(10), 
                       StageName='Quoted - No Decision', Opportunity_Rating__c='Warm (Possibly Order)',
                       Opportunity_Contact_Name_LookUpFilter__c=newCnt.Id, 
                       Billing_Street__c=newAccList[0].BillingStreet, Billing_City__c=newAccList[0].BillingCity, 
                       Billing_State_Province__c=newAccList[0].BillingState, 
                       Billing_Zip_Postal_Code__c=newAccList[0].BillingPostalCode, 
                       Billing_Country__c=newAccList[0].BillingCountry, Delivery_Street__c=newAccList[0].BillingStreet, 
                       Delivery_City__c=newAccList[0].BillingCity, Delivery_State_Province__c=newAccList[0].BillingState, 
                       Delivery_Zip_Postal_Code__c=newAccList[0].BillingPostalCode, Delivery_Country__c=newAccList[0].BillingCountry));
            
            newOpp.add(new Opportunity(AccountId=newAccList[0].Id, RecordTypeId=oppRecordTypeId, Name='TEKsystems', 
                       CurrencyIsoCode=newAccList[0].CurrencyIsoCode, CloseDate=System.today().addDays(10), 
                       StageName='Quoted - No Decision', Opportunity_Rating__c='Warm (Possibly Order)',
                       Opportunity_Contact_Name_LookUpFilter__c=newCnt.Id, 
                       Billing_Street__c=newAccList[0].BillingStreet, Billing_City__c=newAccList[0].BillingCity, 
                       Billing_State_Province__c=newAccList[0].BillingState, 
                       Billing_Zip_Postal_Code__c=newAccList[0].BillingPostalCode, 
                       Billing_Country__c=newAccList[0].BillingCountry, Delivery_Street__c=newAccList[0].BillingStreet, 
                       Delivery_City__c=newAccList[0].BillingCity, Delivery_State_Province__c=newAccList[0].BillingState, 
                       Delivery_Zip_Postal_Code__c='11111', Delivery_Country__c=newAccList[0].BillingCountry, 
                       Shipping_Territory__c='167', Servicing_Branch__c='000'));
        insert newOpp;
        system.debug('New Opportunity: '+newOpp);
    }
    
    //Shankar - Send to ISR lead button coverage.
    static testmethod void leadSendToISRButton(){
        Lead leadRecord = [SELECT Id FROM Lead where Company='Allegis Inc'];
        system.debug('Lead Record = '+leadRecord);
        
        Test.startTest();
            String result = RoutingLogic.leadSendToISRButton(leadRecord.Id);    
        Test.stopTest();
            system.assert(result.contains('Lead successfully assigned'));
    }
    
    //Shankar - Send to ISR lead button coverage.
    static testmethod void accSendToISRButton(){
        Account accRecord = [SELECT Id FROM Account WHERE Name='Allegis Inc'];
        Account accRecordNoOpp = [SELECT Id FROM Account WHERE Name='TEKsystems'];
        system.debug('Account Record = '+accRecord);
        
        Test.startTest();
            String response1 = RoutingLogic.accSendToISRButton(accRecord.Id);
            String response2 = RoutingLogic.accSendToISRButton(accRecord.Id);
            String response3 = RoutingLogic.accSendToISRButton(accRecordNoOpp.Id);
        Test.stopTest();
            system.debug('Response 1: '+response1);
            system.debug('Response 2: '+response2);
            system.assert(response1.contains('Account successfully assigned'));
            //system.assert(response2.contains('Current Account owner is the only available user'));
    }
    
    //Shankar - Send to ISR lead button coverage.
    static testmethod void oppSendToISRButton(){
        Opportunity oppRecord = [SELECT Id, Shipping_Territory__c FROM Opportunity WHERE Name='Allegis Inc'];
        Opportunity oppRecordInvalidBranch = [SELECT Id, Shipping_Territory__c FROM Opportunity WHERE Name='TEKsystems'];
        system.debug('Opportunity Record = '+oppRecord);
        Set<String> delTerritory = new Set<String>();
        delTerritory.add(oppRecord.Shipping_Territory__c);  
        
        Test.startTest();
            //String result = RoutingLogic.opportunitySendToISRButton(oppRecord.Id);
            //String result2 = RoutingLogic.opportunitySendToISRButton(oppRecordInvalidBranch.Id);
            String result = RoutingLogic.opportunitySendToISRButton(oppRecord);
            String result2 = RoutingLogic.opportunitySendToISRButton(oppRecordInvalidBranch);
            if(!delTerritory.isEmpty()){
                RoutingLogic.getOpportunityTerritoryOwner(delTerritory);    
            }
        Test.stopTest();
            //System.assert(result.contains('Opportunity successfully assigned'));
            //System.assert(result2.contains('Invalid Branch Code'));
    }
}