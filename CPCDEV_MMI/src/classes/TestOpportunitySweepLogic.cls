/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class TestOpportunitySweepLogic {

static testMethod void myUnitTest() {
            
            //User usISR = [select id,UserRoleId,ManagerId,UserRole.Name,Name,Available_For_Leads__c,Territory__c from User where UserRole.Name like '%Inbound Sales Specialist%' limit 1];
            User userObj = MMIFullquoteTestDataProvider.getUser();
            
            Profile p = [select id from profile WHERE Name='Sales Rep - US' LIMIT 1];
             
            UserRole IBuserRole =[SELECT Id,Name FROM UserRole WHERE Name like 'Inbound Sales Specialist%' LIMIT 1];
            UserRole ISMuserRole =[SELECT Id,Name FROM UserRole WHERE Name = 'Inside Sales/Outside Sales Manager Region 4' LIMIT 1];
            UserRole ISRuserRole =[SELECT Id,Name FROM UserRole WHERE Name = 'Sales Rep - 121 - El Paso' LIMIT 1];
            
            RecordType OppStdRecordType = [SELECT Id,Name,SobjectType FROM RecordType WHERE SobjectType = 'Opportunity' and Name = 'Standard Opportunity'];
            
            User ISRuser = new User(Alias='TSTUSR2',Email='TEST.USER@TEST.TEST',EmailEncodingKey='UTF-8',FirstName='AccountTerritory_TEST',LastName='TEST_LAST_NAME2', 
                                                     LanguageLocaleKey='en_US',LocaleSidKey='en_GB',timezonesidkey='Europe/London',Title='TEST TITLE',username='TEST1.USER@TEST1.TEST1',
                                                     Branch__c='101-Phoenix',Territory__c = '158-01',IsActive = True,ProfileId = p.Id,UserRoleId = ISRuserRole.Id);
            
            User ISMuser = new User(Alias='TSTUSR3',Email='TEST.USER@TEST.TEST',EmailEncodingKey='UTF-8',FirstName='AccountTerritory_TEST',LastName='TEST_LAST_NAME3', 
                                                     LanguageLocaleKey='en_US',LocaleSidKey='en_GB',timezonesidkey='Europe/London',Title='TEST TITLE',username='TEST2.USR@TEST2.TEST2',
                                                     Branch__c='101-Phoenix',Territory__c = '158-01',IsActive = True,Selling_Region__c='4',ProfileId = p.Id,UserRoleId = ISMuserRole.Id);
            
            userObj.UserRoleId = IBuserRole.Id;
            
            System.runAs(userObj) {
                Test.startTest();
                
                   // ISR territory owner..               
                 insert ISRuser; 
                
                   // ISM Selling Region owner..
                 insert ISMuser; 
                 
                 Account acc = new Account();
                 acc.Name = 'Test Acct';
                 acc.Industry = '0-Non-classified/Unknown';
                 acc.Type = 'Prospect - National Account';
                 acc.Territory__c = '158-01';
                 acc.BillingCountry = 'USA';
                 insert acc;
                
                 Opportunity opp = new Opportunity();
                 opp.AccountId = acc.id;
                 opp.Branch__c = '158';
                 opp.Territory__c = '158-01';
                 opp.CloseDate = system.today();
                 opp.Name = 'Test Opp';
                 opp.StageName = 'Quoted - No Decision';
                 opp.Type = 'Existing Business';
                 opp.LeadSource = 'Dodge Report';
                 opp.Opportunity_Rating__c = 'Cold (Probably Not)';
                 opp.Type_of_Quote_Given__c = 'Verbal Quote';
                 opp.Quote_Comments__c = 'hjjjhkk ';
                 opp.Billing_Country__c = 'US';
                 opp.RecordTypeId = OppStdRecordType.ID;
                 opp.Billing_Zip_Postal_Code__c = '852821';
                 opp.Delivery_Zip_Postal_Code__c = '852821';
                 opp.Servicing_Branch__c = '298';
                 opp.On_The_Go__c = false;
                 opp.isOpportunitySweep__c = false;
                 opp.Selling_Region__c = '4';
                
                 insert opp; 
                
                List<Opportunity> oppList = new List<Opportunity>();
                oppList.add(opp);
                
                // MSM 98/TFS 1311 
                OpportunitySweepLogic oppsweep = new OpportunitySweepLogic();
                OpportunitySweepLogic.isRunningTest = true;
                OpportunitySweepLogic.isIBrepTest = true;
                OpportunitySweepLogic.isISRrepTest = true;
                OpportunitySweepLogic.processOpportunities(oppList,true);
                                                   
                Test.stopTest();
            }
    }
 
 static testMethod void myUnitTest2() {
            
            //User usISR = [select id,UserRoleId,ManagerId,UserRole.Name,Name,Available_For_Leads__c,Territory__c from User where UserRole.Name like '%Inbound Sales Specialist%' limit 1];
            User userObj = MMIFullquoteTestDataProvider.getUser();
            
            Profile p = [select id from profile WHERE Name='Sales Rep - US' LIMIT 1];
             
            UserRole IBuserRole =[SELECT Id,Name FROM UserRole WHERE Name like 'Inbound Sales Specialist%' LIMIT 1];
            UserRole ISMuserRole =[SELECT Id,Name FROM UserRole WHERE Name = 'Inside Sales/Outside Sales Manager Region 4' LIMIT 1];
            UserRole ISRuserRole =[SELECT Id,Name FROM UserRole WHERE Name = 'Sales Rep - 121 - El Paso' LIMIT 1];
            
            RecordType OppStdRecordType = [SELECT Id,Name,SobjectType FROM RecordType WHERE SobjectType = 'Opportunity' and Name = 'Standard Opportunity'];
            
            User ISRuser = new User(Alias='TSTUSR2',Email='TEST.USER@TEST.TEST',EmailEncodingKey='UTF-8',FirstName='AccountTerritory_TEST',LastName='TEST_LAST_NAME2', 
                                                     LanguageLocaleKey='en_US',LocaleSidKey='en_GB',timezonesidkey='Europe/London',Title='TEST TITLE',username='TEST1.USER@TEST1.TEST1',
                                                     Branch__c='101-Phoenix',Territory__c = '158-01',IsActive = True,ProfileId = p.Id,UserRoleId = ISRuserRole.Id);
            
            User ISMuser = new User(Alias='TSTUSR3',Email='TEST.USER@TEST.TEST',EmailEncodingKey='UTF-8',FirstName='AccountTerritory_TEST',LastName='TEST_LAST_NAME3', 
                                                     LanguageLocaleKey='en_US',LocaleSidKey='en_GB',timezonesidkey='Europe/London',Title='TEST TITLE',username='TEST2.USR@TEST2.TEST2',
                                                     Branch__c='101-Phoenix',Territory__c = '158-01',IsActive = True,Selling_Region__c='4',ProfileId = p.Id,UserRoleId = ISMuserRole.Id);
            
            userObj.UserRoleId = IBuserRole.Id;
            
            System.runAs(userObj) {
                Test.startTest();
                
                   // ISR territory owner..               
                 insert ISRuser; 
                
                   // ISM Selling Region owner..
                 insert ISMuser; 
                 
                 Account acc = new Account();
                 acc.Name = 'Test Acct';
                 acc.Industry = '0-Non-classified/Unknown';
                 acc.Type = 'Prospect - National Account';
                 acc.Territory__c = '158-01';
                 acc.BillingCountry = 'USA';
                 insert acc;
                
                 Opportunity opp = new Opportunity();
                 opp.AccountId = acc.id;
                 opp.Branch__c = '158';
                 opp.Territory__c = '158-01';
                 opp.CloseDate = system.today();
                 opp.Name = 'Test Opp';
                 opp.StageName = 'Quoted - Won';
                 opp.Type = 'Existing Business';
                 opp.LeadSource = 'Dodge Report';
                 opp.Opportunity_Rating__c = 'Cold (Probably Not)';
                 opp.Type_of_Quote_Given__c = 'Verbal Quote';
                 opp.Quote_Comments__c = 'hjjjhkk ';
                 opp.Billing_Country__c = 'US';
                 opp.RecordTypeId = OppStdRecordType.ID;
                 opp.Billing_Zip_Postal_Code__c = '852821';
                 opp.Delivery_Zip_Postal_Code__c = '852821';
                 opp.Servicing_Branch__c = '298';
                 opp.On_The_Go__c = false;
                 opp.isOpportunitySweep__c = false;
                 opp.Selling_Region__c = '4';
                 
                 Opportunity opp1 = new Opportunity();
                 opp1.AccountId = acc.id;
                 opp1.Branch__c = '158';
                 opp1.CloseDate = system.today();
                 opp1.Name = 'Test Opp';
                 opp1.StageName = 'Quoted - Won';
                 opp1.Type = 'Existing Business';
                 opp1.LeadSource = 'Dodge Report';
                 opp1.Opportunity_Rating__c = 'Cold (Probably Not)';
                 opp1.Type_of_Quote_Given__c = 'Verbal Quote';
                 opp1.Quote_Comments__c = 'hjjjhkk ';
                 opp1.Billing_Country__c = 'US';
                 opp1.RecordTypeId = OppStdRecordType.ID;
                 opp1.Billing_Zip_Postal_Code__c = '852821';
                 opp1.Delivery_Zip_Postal_Code__c = '852821';
                 opp1.Servicing_Branch__c = '298';
                 opp1.On_The_Go__c = false;
                 opp1.isOpportunitySweep__c = false;
                 opp1.Selling_Region__c = '4';

                
                 insert opp1; 
                 
                List<Opportunity> oppList = new List<Opportunity>();
                oppList.add(opp);
                oppList.add(opp1);
                               
                // MSM 98/TFS 1311 
                OpportunitySweepLogic oppsweep = new OpportunitySweepLogic();
                OpportunitySweepLogic.isRunningTest = true;
                OpportunitySweepLogic.isIBrepTest = true;
                OpportunitySweepLogic.isISRrepTest = true;
                OpportunitySweepLogic.processOpportunities(oppList,true);
                                                   
                Test.stopTest();
            }
    }
 
    
 static testMethod void myUnitTest3() {
            
            //User usISR = [select id,UserRoleId,ManagerId,UserRole.Name,Name,Available_For_Leads__c,Territory__c from User where UserRole.Name like '%Inbound Sales Specialist%' limit 1];
            User userObj = MMIFullquoteTestDataProvider.getUser();
            
            Profile p = [select id from profile WHERE Name='Sales Rep - US' LIMIT 1];
             
            UserRole IBuserRole =[SELECT Id,Name FROM UserRole WHERE Name like 'Inbound Sales Specialist%' LIMIT 1];
            UserRole ISMuserRole =[SELECT Id,Name FROM UserRole WHERE Name = 'Inside Sales/Outside Sales Manager Region 4' LIMIT 1];
            UserRole ISRuserRole =[SELECT Id,Name FROM UserRole WHERE Name = 'Sales Rep - 121 - El Paso' LIMIT 1];
            
            RecordType OppStdRecordType = [SELECT Id,Name,SobjectType FROM RecordType WHERE SobjectType = 'Opportunity' and Name = 'Government Opportunity - UK'];
            
            User ISRuser = new User(Alias='TSTUSR2',Email='TEST.USER@TEST.TEST',EmailEncodingKey='UTF-8',FirstName='AccountTerritory_TEST',LastName='TEST_LAST_NAME2', 
                                                     LanguageLocaleKey='en_US',LocaleSidKey='en_GB',timezonesidkey='Europe/London',Title='TEST TITLE',username='TEST1.USER@TEST1.TEST1',
                                                     Branch__c='101-Phoenix',Territory__c = '158-01',IsActive = True,ProfileId = p.Id,UserRoleId = ISRuserRole.Id);
            
            User ISMuser = new User(Alias='TSTUSR3',Email='TEST.USER@TEST.TEST',EmailEncodingKey='UTF-8',FirstName='AccountTerritory_TEST',LastName='TEST_LAST_NAME3', 
                                                     LanguageLocaleKey='en_US',LocaleSidKey='en_GB',timezonesidkey='Europe/London',Title='TEST TITLE',username='TEST2.USR@TEST2.TEST2',
                                                     Branch__c='101-Phoenix',Territory__c = '158-01',IsActive = True,Selling_Region__c='4',ProfileId = p.Id,UserRoleId = ISMuserRole.Id);
            
            userObj.UserRoleId = IBuserRole.Id;
            
            System.runAs(userObj) {
                Test.startTest();
                
                   // ISR territory owner..               
                 insert ISRuser; 
                
                   // ISM Selling Region owner..
                 insert ISMuser; 
                 
                 Account acc = new Account();
                 acc.Name = 'Test Acct';
                 acc.Industry = '0-Non-classified/Unknown';
                 acc.Type = 'Prospect - National Account';
                 acc.Territory__c = '158-01';
                 acc.BillingCountry = 'USA';
                 insert acc;
                
                 Opportunity opp = new Opportunity();
                 opp.AccountId = acc.id;
                 opp.Branch__c = '707';
                 opp.CloseDate = system.today();
                 opp.Name = 'Test Opp';
                 opp.StageName = 'Quoted - Won';
                 opp.Type = 'Existing Business';
                 opp.LeadSource = 'Dodge Report';
                 opp.Opportunity_Rating__c = 'Cold (Probably Not)';
                 opp.Type_of_Quote_Given__c = 'Verbal Quote';
                 opp.Quote_Comments__c = 'hjjjhkk ';
                 opp.Billing_Country__c = 'US';
                 opp.RecordTypeId = OppStdRecordType.ID;
                 opp.Billing_Zip_Postal_Code__c = '852821';
                 opp.Delivery_Zip_Postal_Code__c = '852821';
                 opp.Servicing_Branch__c = '298';
                 opp.On_The_Go__c = false;
                 opp.isOpportunitySweep__c = false;
                 opp.Selling_Region__c = '4';
                
                 insert opp; 
                
                List<Opportunity> oppList = new List<Opportunity>();
                oppList.add(opp);
                
                // MSM 98/TFS 1311 
                OpportunitySweepLogic oppsweep = new OpportunitySweepLogic();
                OpportunitySweepLogic.isIBrepTest = true;
                OpportunitySweepLogic.isISRrepTest = true;
                OpportunitySweepLogic.processOpportunities(oppList,true);
                                                   
                Test.stopTest();
            }
    }
    
}