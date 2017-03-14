@isTest
public class openJobProfileAccountsTest{
  public static testMethod void Test1(){
    Account acc = new Account();
     acc.Name = 'test Name';
     acc.BillingStreet = 'Marotn str';
     acc.BillingCity = 'Phoenix';
     acc.BillingState = 'AZ';
     acc.BillingCountry = 'US';
     acc.BillingPostalCode = '20779-0000';
     acc.ShippingPostalCode = '20779-0000'; 
     acc.RecordTypeId = [select Id from RecordType where sObjectType = 'Account' and Name = 'Business Account' LIMIT 1].Id;
     insert acc;
    
    Job_Profile__c jb = new Job_Profile__c();
     jb.Name = 'Test Job Profile';
     jb.Project_Stage_Status__c = 'Bid Results';
     insert jb;
    
    Sub_Contractor__c sc = new Sub_Contractor__c();
    sc.Role__c = 'Electrical Contractor';
    sc.Job_Profile__c = jb.Id;
    sc.Account__c = acc.Id;
    insert sc;
    
    ApexPages.CurrentPage().getParameters().put('acc',acc.Id);
    
    Test.StartTest();
    openJobProfileAccounts opJBacc = new openJobProfileAccounts();
    opJBacc.selectedJB = jb.Id;
    opJBacc.Next();
    opJbacc.dispSubConRole();  
    
    openJobProfileAccounts_Intial opJBacc_in_1 = new openJobProfileAccounts_Intial(); 
    PageReference pg1 = opJBacc_in_1.openJobProfileAccountsPage(); 
    Test.stopTest();
        
  }
  
  public static testMethod void Test2(){
    Account acc1 = new Account();
     acc1.Name = 'Sec Test Name';
     acc1.BillingStreet = 'Bretotn str';
     acc1.BillingCity = 'Phoenix';
     acc1.BillingState = 'AZ';
     acc1.BillingCountry = 'US';
     acc1.BillingPostalCode = '64116';
     acc1.ShippingPostalCode = '64116';
     acc1.ShippingCity = 'Phoenix';
     acc1.ShippingCountry = 'USA'; 
     acc1.Servicing_Branch_Id__c = '121';
     acc1.RecordTypeId = [select Id from RecordType where sObjectType = 'Account' and Name = 'Business Account' LIMIT 1].Id;
     insert acc1;
          
     system.debug('-------- acc1.Servicing_Branch_Id__c ----------' + acc1.Servicing_Branch_Id__c);
     system.debug('-------- acc1 ----------' + acc1.Sales_Org__c);
     system.debug('-------- acc1.RecordTypeId ----------' + acc1.RecordTypeId);
    
    Job_Profile__c jb1 = new Job_Profile__c();
     jb1.Name = 'Test Job Profile';
     jb1.Project_Stage_Status__c = 'Bidding';
     jb1.Job_Site_Zip__c = '20279-0000';
     jb1.Job_Site_City__c = 'Phoenix';
     jb1.Job_Site_State__c = 'AZ';
     insert jb1;
    
    Sub_Contractor__c sc1 = new Sub_Contractor__c();
    sc1.Role__c = 'General Contractor';
    sc1.Job_Profile__c = jb1.Id;
    sc1.Account__c = acc1.Id;
    insert sc1;
    
    ApexPages.CurrentPage().getParameters().put('id',acc1.Id);
    ApexPages.CurrentPage().getParameters().put('Sales_Org',acc1.Sales_Org__c);
    ApexPages.CurrentPage().getParameters().put('opportunityid','');
        
    Test.StartTest();
    openJobProfileAccounts opJBacc = new openJobProfileAccounts();
    opJBacc.selectedJB = jb1.Id;
    opJBacc.selSubRole = sc1.Role__c;
    opJBacc.Next();
    opJbacc.dispSubConRole(); 
    
    Sub_Contractor__c sc2 = new Sub_Contractor__c();
    sc2.Role__c = 'Plumbing';
    sc2.Job_Profile__c = jb1.Id;
    sc2.Account__c = acc1.Id;
    insert sc2;   
    
    openJobProfileAccounts opJBacc1 = new openJobProfileAccounts();
    opJBacc1.selectedJB = jb1.Id;
    opJBacc1.selSubRole = sc2.Role__c;
    opJBacc1.Next();
    opJbacc1.dispSubConRole();
    
    openJobProfileAccounts_Intial opJBacc_in_2 = new openJobProfileAccounts_Intial();
    PageReference pg2 = opJBacc_in_2.openJobProfileAccountsPage(); 
    Test.stopTest();
        
  }
  
  public static testMethod void Test3(){
    Account acc2 = new Account();
     acc2.Name = 'Quoad Test Name';
     acc2.BillingStreet = 'Bretotn str';
     acc2.BillingCity = 'Phoenix';
     acc2.BillingState = 'AZ';
     acc2.BillingCountry = 'US';
     acc2.BillingPostalCode = '64116';
     acc2.ShippingPostalCode = '64116';
     acc2.ShippingCity = 'Phoenix';
     acc2.ShippingCountry = 'USA'; 
     acc2.Servicing_Branch_Id__c = '121';
     acc2.RecordTypeId = [select Id from RecordType where sObjectType = 'Account' and Name = 'Business Account' LIMIT 1].Id;
     insert acc2;
          
     system.debug('-------- acc2.Servicing_Branch_Id__c ----------' + acc2.Servicing_Branch_Id__c);
     system.debug('-------- acc2 ----------' + acc2.Sales_Org__c);
     system.debug('-------- acc2.RecordTypeId ----------' + acc2.RecordTypeId);
    
    ApexPages.CurrentPage().getParameters().put('id',acc2.Id);
    ApexPages.CurrentPage().getParameters().put('Sales_Org',acc2.Sales_Org__c);
    ApexPages.CurrentPage().getParameters().put('opportunityid','');
        
    Test.StartTest();
    openJobProfileAccounts_Intial opJBacc_in_3 = new openJobProfileAccounts_Intial();
    PageReference pg3 = opJBacc_in_3.openJobProfileAccountsPage(); 
    Test.stopTest();        
  }
  
  public static testMethod void Test4(){
    Account acc3 = new Account();
     acc3.Name = 'Terin Test Name';
     acc3.BillingStreet = 'Bretotn str';
     acc3.BillingCity = 'Phoenix';
     acc3.BillingState = 'AZ';
     acc3.BillingCountry = 'US';
     acc3.BillingPostalCode = '64116';
     acc3.ShippingPostalCode = '64116';
     acc3.ShippingCity = 'Phoenix';
     acc3.ShippingCountry = 'USA'; 
     acc3.Servicing_Branch_Id__c = '121';
     acc3.RecordTypeId = [select Id from RecordType where sObjectType = 'Account' and Name = 'Business Account' LIMIT 1].Id;
     insert acc3;
              
    ApexPages.CurrentPage().getParameters().put('acc',acc3.Id);
        
    Test.StartTest();
    openJobProfileAccounts_Intial opJBacc_in_4 = new openJobProfileAccounts_Intial();
    PageReference pg4 = opJBacc_in_4.openJobProfileAccountsPage(); 
    Test.stopTest();
        
  }
}