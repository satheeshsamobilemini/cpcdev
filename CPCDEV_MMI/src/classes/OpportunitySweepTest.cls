/*
* (c) 2015 TEKsystems Global Services
*
* Name           : RoutingLogic
* Created Date   : 07 Oct, 2015 @ 0130
* Created By     : Shankar Rao
* Purpose        : Test class to cover OpportunitySweepLogicBatchableClass_1hr, OpportunitySweepLogicBatchableClass_24hr,
*           OpportunitySweepValidation, OpportunitySweepMainLogic classes.
* 
*/
@isTest
private class OpportunitySweepTest {
  
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
        
        Id accRecordTypeId = Schema.SObjectType.Account.RecordTypeInfosByName.get('Business Account').RecordTypeId;
        Id accCompRecordTypeId = Schema.SObjectType.Account.RecordTypeInfosByName.get('Competitor').RecordTypeId;
        List<Account> newAcc = new List<Account>();
          newAcc.add(new Account(Name='Allegis Inc', CurrencyIsoCode='USD', Type='Prospect - Branch Business Account', 
                                   BillingStreet='1826 W MCDOWELL', BillingCity='PHOENIX', BillingState='AZ', 
                                   BillingPostalCode='31527', BillingCountry='USA', RecordTypeId=accRecordTypeId));
          newAcc.add(new Account(Name='TEKsystems', CurrencyIsoCode='USD', Type='Prospect - Branch Business Account', 
                                   BillingStreet='1826 W MCDOWELL', BillingCity='PHOENIX', BillingState='AZ', 
                                   BillingPostalCode='30315', BillingCountry='USA', RecordTypeId=accRecordTypeId));
          newAcc.add(new Account(Name='UNKNOWN', CurrencyIsoCode='USD', Type='Competitor', 
                                   RecordTypeId=accCompRecordTypeId));
          newAcc.add(new Account(Name='TEKsystems GS', CurrencyIsoCode='USD', Type='Prospect - Branch Business Account', 
                                   BillingStreet='1826 W MCDOWELL', BillingCity='PHOENIX', BillingState='AZ', 
                                   BillingCountry='USA', RecordTypeId=accRecordTypeId));
          newAcc.add(new Account(Name='Mobile Mini Inc', CurrencyIsoCode='USD', Type='Prospect - Branch Business Account', 
                                   BillingStreet='1826 W MCDOWELL', BillingCity='PHOENIX', BillingState='AZ', 
                                   BillingPostalCode='11111', BillingCountry='USA', RecordTypeId=accRecordTypeId));
        newAcc.add(new Account(Name='Mobile Mini Inc2', CurrencyIsoCode='USD', Type='Prospect - Branch Business Account', 
                                   BillingStreet='1824 W MCDOWELL', BillingCity='PHOENIX', BillingState='AZ', 
                                   BillingPostalCode='11111', BillingCountry='USA', RecordTypeId=accRecordTypeId,isSPOC_Account__c = true));
        insert newAcc;
        system.debug('New Account: '+newAcc);
        
        Contact newCnt = new Contact(AccountId=newAcc[0].Id, FirstName='Shankar', LastName='Rao', 
                                     CurrencyIsoCode='USD', Decision_Maker__c='Yes', Phone='30705055');
        insert newCnt;
        system.debug('New Contact: '+newCnt);
        
        User salesRep = [SELECT Id From User WHERE UserRole.Name like '%Sales Rep - %' 
                                    AND isActive = true 
                                    AND Branch_Id__c <> null
                                    AND Territory__c <> null LIMIT 1];
        system.runAs(salesRep){
          Id oppRecordTypeId = Schema.SObjectType.Opportunity.RecordTypeInfosByName.get('Standard Opportunity').RecordTypeId;
            List<Opportunity> newOpp = new List<Opportunity>();
                
              newOpp.add(new Opportunity(AccountId=newAcc[0].Id, RecordTypeId=oppRecordTypeId, Name=newAcc[0].Name, 
                                           CurrencyIsoCode=newAcc[0].CurrencyIsoCode, CloseDate=System.today().addDays(10), 
                                           StageName='Quoted - No Decision', Opportunity_Rating__c='Warm (Possibly Order)',
                                            
                                           Billing_Street__c=newAcc[0].BillingStreet, Billing_City__c=newAcc[0].BillingCity, 
                                           Billing_State_Province__c=newAcc[0].BillingState, 
                                           Billing_Zip_Postal_Code__c=newAcc[0].BillingPostalCode, 
                                           Billing_Country__c=newAcc[0].BillingCountry, Delivery_Street__c=newAcc[0].BillingStreet, 
                                           Delivery_City__c=newAcc[0].BillingCity, Delivery_State_Province__c=newAcc[0].BillingState, 
                                           Delivery_Zip_Postal_Code__c=newAcc[0].BillingPostalCode, Delivery_Country__c=newAcc[0].BillingCountry));
              
              newOpp.add(new Opportunity(AccountId=newAcc[3].Id, RecordTypeId=oppRecordTypeId, Name=newAcc[3].Name, 
                                           CurrencyIsoCode=newAcc[3].CurrencyIsoCode, CloseDate=System.today().addDays(10), 
                                           StageName='Quoted - Won', Result_Rental_Sale_Doc__c='123456789', 
                                           Opportunity_Rating__c='Warm (Possibly Order)',
                                           
                                           Billing_Street__c=newAcc[3].BillingStreet, Billing_City__c=newAcc[3].BillingCity, 
                                           Billing_State_Province__c=newAcc[3].BillingState, 
                                           Billing_Zip_Postal_Code__c=newAcc[3].BillingPostalCode, 
                                           Billing_Country__c=newAcc[3].BillingCountry, Delivery_Street__c=newAcc[3].BillingStreet, 
                                           Delivery_City__c=newAcc[3].BillingCity, Delivery_State_Province__c=newAcc[3].BillingState, 
                                           Delivery_Zip_Postal_Code__c='87113',Servicing_Branch__c='000', 
                                            Delivery_Country__c=newAcc[0].BillingCountry));
              
              newOpp.add(new Opportunity(AccountId=newAcc[0].Id, RecordTypeId=oppRecordTypeId, Name=newAcc[3].Name, 
                                           CurrencyIsoCode=newAcc[3].CurrencyIsoCode, CloseDate=System.today().addDays(10), 
                                           StageName='Quoted - Won', Result_Rental_Sale_Doc__c='123456789', 
                                           Opportunity_Rating__c='Warm (Possibly Order)',
                                          
                                           Billing_Street__c=newAcc[3].BillingStreet, Billing_City__c=newAcc[3].BillingCity, 
                                           Billing_State_Province__c=newAcc[3].BillingState, 
                                           Billing_Zip_Postal_Code__c=newAcc[3].BillingPostalCode, 
                                           Billing_Country__c=newAcc[3].BillingCountry, Delivery_Street__c=newAcc[3].BillingStreet, 
                                           Delivery_City__c=newAcc[3].BillingCity, Delivery_State_Province__c=newAcc[3].BillingState, 
                                           Delivery_Zip_Postal_Code__c='87113',Servicing_Branch__c='000', 
                                            Delivery_Country__c=newAcc[0].BillingCountry));
            
              newOpp.add(new Opportunity(AccountId=newAcc[0].Id, RecordTypeId=oppRecordTypeId, Name=newAcc[0].Name, 
                                          CurrencyIsoCode=newAcc[0].CurrencyIsoCode, CloseDate=System.today().addDays(10), 
                                          StageName='Quoted - Won', Result_Rental_Sale_Doc__c='123456789', 
                                          Opportunity_Rating__c='Warm (Possibly Order)',
                                         
                                          Billing_Street__c=newAcc[0].BillingStreet, Billing_City__c=newAcc[0].BillingCity, 
                                          Billing_State_Province__c=newAcc[0].BillingState, 
                                          Billing_Zip_Postal_Code__c=newAcc[0].BillingPostalCode, 
                                          Billing_Country__c=newAcc[0].BillingCountry, Delivery_Street__c=newAcc[0].BillingStreet, 
                                          Delivery_City__c=newAcc[0].BillingCity, Delivery_State_Province__c=newAcc[0].BillingState, 
                                          Delivery_Zip_Postal_Code__c=newAcc[0].BillingPostalCode, Delivery_Country__c=newAcc[0].BillingCountry));
              
              newOpp.add(new Opportunity(AccountId=newAcc[1].Id, RecordTypeId=oppRecordTypeId, Name=newAcc[1].Name, 
                                          CurrencyIsoCode=newAcc[1].CurrencyIsoCode, CloseDate=System.today().addDays(10), 
                                          StageName='Quoted - Won', Result_Rental_Sale_Doc__c='123456789', 
                                          Opportunity_Rating__c='Warm (Possibly Order)',
                                         
                                          Billing_Street__c=newAcc[1].BillingStreet, Billing_City__c=newAcc[1].BillingCity, 
                                          Billing_State_Province__c=newAcc[1].BillingState, 
                                          Billing_Zip_Postal_Code__c=newAcc[1].BillingPostalCode, 
                                          Billing_Country__c=newAcc[1].BillingCountry, Delivery_Street__c=newAcc[1].BillingStreet, 
                                          Delivery_City__c=newAcc[1].BillingCity, Delivery_State_Province__c=newAcc[1].BillingState, 
                                          Delivery_Zip_Postal_Code__c=newAcc[1].BillingPostalCode, Delivery_Country__c=newAcc[1].BillingCountry));
            
              newOpp.add(new Opportunity(AccountId=newAcc[0].Id, RecordTypeId=oppRecordTypeId, Name=newAcc[0].Name, 
                                          CurrencyIsoCode=newAcc[0].CurrencyIsoCode, CloseDate=System.today().addDays(10), 
                                          StageName='Quoted - Lost Business', Lost_Business_To__c=newAcc[2].Id, 
                                          Lost_Opportunity_Reason_New__c='Product Condition Not to Cust Liking', Opportunity_Rating__c='Warm (Possibly Order)',
                                          
                                          Billing_Street__c=newAcc[0].BillingStreet, Billing_City__c=newAcc[0].BillingCity, 
                                          Billing_State_Province__c=newAcc[0].BillingState, 
                                          Billing_Zip_Postal_Code__c=newAcc[0].BillingPostalCode, 
                                          Billing_Country__c=newAcc[0].BillingCountry, Delivery_Street__c=newAcc[0].BillingStreet, 
                                          Delivery_City__c=newAcc[0].BillingCity, Delivery_State_Province__c=newAcc[0].BillingState, 
                                          Delivery_Zip_Postal_Code__c=newAcc[0].BillingPostalCode, Delivery_Country__c=newAcc[0].BillingCountry));
              
              newOpp.add(new Opportunity(AccountId=newAcc[4].Id, RecordTypeId=oppRecordTypeId, Name=newAcc[0].Name, 
                                          CurrencyIsoCode=newAcc[0].CurrencyIsoCode, CloseDate=System.today().addDays(10), 
                                          StageName='Quoted - Lost Business', Lost_Business_To__c=newAcc[2].Id, 
                                          Opportunity_Rating__c='Warm (Possibly Order)',
                                          
                                          Billing_Street__c=newAcc[0].BillingStreet, Billing_City__c=newAcc[0].BillingCity, 
                                          Billing_State_Province__c=newAcc[0].BillingState, 
                                          Billing_Zip_Postal_Code__c=newAcc[0].BillingPostalCode, 
                                          Billing_Country__c=newAcc[0].BillingCountry, Delivery_Street__c=newAcc[0].BillingStreet, 
                                          Delivery_City__c=newAcc[0].BillingCity, Delivery_State_Province__c=newAcc[0].BillingState, 
                                          Delivery_Zip_Postal_Code__c=newAcc[0].BillingPostalCode, Delivery_Country__c=newAcc[0].BillingCountry));
            
              newOpp.add(new Opportunity(AccountId=newAcc[0].Id, RecordTypeId=oppRecordTypeId, Name=newAcc[4].Name, 
                                           CurrencyIsoCode=newAcc[4].CurrencyIsoCode, CloseDate=System.today().addDays(10), 
                                           StageName='Quoted - No Decision', Opportunity_Rating__c='Warm (Possibly Order)',
                                           
                                           Billing_Street__c=newAcc[4].BillingStreet, Billing_City__c=newAcc[4].BillingCity, 
                                           Billing_State_Province__c=newAcc[4].BillingState, 
                                           Billing_Zip_Postal_Code__c=newAcc[4].BillingPostalCode, 
                                           Billing_Country__c=newAcc[4].BillingCountry, Delivery_Street__c=newAcc[4].BillingStreet, 
                                           Delivery_City__c=newAcc[4].BillingCity, Delivery_State_Province__c=newAcc[4].BillingState, 
                                           Delivery_Zip_Postal_Code__c='11111', Delivery_Country__c=newAcc[4].BillingCountry, 
                                           Shipping_Territory__c='127', Servicing_Branch__c='110'));
            
              newOpp.add(new Opportunity(AccountId=newAcc[5].Id, RecordTypeId=oppRecordTypeId, Name=newAcc[5].Name, 
                                           CurrencyIsoCode=newAcc[5].CurrencyIsoCode, CloseDate=System.today().addDays(10), 
                                           StageName='Quoted - No Decision', Opportunity_Rating__c='Warm (Possibly Order)',
                                          
                                           Billing_Street__c=newAcc[5].BillingStreet, Billing_City__c=newAcc[4].BillingCity, 
                                           Billing_State_Province__c=newAcc[5].BillingState, 
                                           Billing_Zip_Postal_Code__c=newAcc[5].BillingPostalCode, 
                                           Billing_Country__c=newAcc[5].BillingCountry, Delivery_Street__c=newAcc[5].BillingStreet, 
                                           Delivery_City__c=newAcc[5].BillingCity, Delivery_State_Province__c=newAcc[5].BillingState, 
                                           Delivery_Zip_Postal_Code__c='11111', Delivery_Country__c=newAcc[5].BillingCountry, 
                                           Shipping_Territory__c='127', Servicing_Branch__c='110'));
            //insert newOpp;
            system.debug('New Opportunities: '+newOpp);   
             RoutingLogic.opportunitySendToISRButton(newOpp[5]);
        }
        
    }
    
    //Shankar - Test 1hr opportunity sweep process.
    static testmethod void test1HrOppSweepProcess(){
      Test.startTest();
            OpportunitySweepLogicBatchableClass_1hr optySweep1hr = new OpportunitySweepLogicBatchableClass_1hr(null, DateTime.now().addDays(1));
            Database.executeBatch(optySweep1hr, 10);
        //User u = OpportunitySweepMainLogic.getNewAccountOwner('57702');
        User u = OpportunitySweepMainLogic.getNewAccountOwner('31527');
        Test.stopTest();
    }
    
    static testMethod void test1HrOppSweepSchedule(){
     Test.startTest();
       string test_srn = '0 0 0 15 3 ? 2022';
       OpportunitiesSweepSchedule opp_sch = new OpportunitiesSweepSchedule();
       system.schedule('Test Opp Schedule',test_srn,opp_sch); 
     Test.stopTest();
    }
    
    //Shankar - Test 24hr opportunity sweep process.
    /*static testmethod void test24HrOppSweepProcess(){
      Test.startTest();
            OpportunitySweepLogicBatchableClass_24hr optySweep24hr = new OpportunitySweepLogicBatchableClass_24hr(null, DateTime.now().addDays(2));
      Database.executeBatch(optySweep24hr, 10);
        Test.stopTest();    
    }*/
}