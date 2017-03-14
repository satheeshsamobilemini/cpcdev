@isTest
public class TestJobProfileAccounts {
    public static testMethod void testContoller() {
         
        Account objAcc = new Account();
            objAcc.Name = 'testAccount';
            objAcc.Type= 'test';
         insert objAcc;
        
        Job_Profile__c objJobProfile = new Job_Profile__c();
          objJobProfile.Branch_ID__c = '145';
          objJobProfile.Name = 'test';
          objJobProfile.Job_Site_Zip__c = '25896';    
          objJobProfile.Job_Site_Country__c = 'USA';
          objJobProfile.Job_Site_Address__c = 'test address';
          objJobProfile.Job_Site_City__c = 'Bangalore';
          objJobProfile.Job_Site_State__c = 'KA';
           
        Insert  objJobProfile;     
        
        List<Sub_Contractor__c> subContractorList = new List<Sub_Contractor__c>();
        
        
        Sub_Contractor__c subContr = new Sub_Contractor__c();
           subContr.Account__c = objAcc.id;
           subContr.Job_Profile__c = objJobProfile.id;
        insert subContr;
        subContractorList.add(subContr); 
        
          Apexpages.currentPage().getParameters().put('nextStep','subFieldVisit');
          Apexpages.currentPage().getParameters().put('recordType','US');
          Apexpages.currentPage().getParameters().put('jobProfileId',objJobProfile.id);
          JobProfileAccounts  JPA = new JobProfileAccounts();
           jpa.getAccountsforJobProfile();
           jpa.selectedAccount = subContr.id;
           jpa.next();
        
        
          Apexpages.currentPage().getParameters().put('nextStep','newTask');
          Apexpages.currentPage().getParameters().put('recordType','US');
          Apexpages.currentPage().getParameters().put('jobProfileId',objJobProfile.id);
          JobProfileAccounts  JPA1 = new JobProfileAccounts();
           jpa1.getAccountsforJobProfile();
           jpa1.selectedAccount = subContr.id;
           jpa1.next();
        
          Apexpages.currentPage().getParameters().put('nextStep','newOppty');
          Apexpages.currentPage().getParameters().put('recordType','US');
          Apexpages.currentPage().getParameters().put('jobProfileId',objJobProfile.id);
          JobProfileAccounts  JPA2 = new JobProfileAccounts();
           jpa2.getAccountsforJobProfile();
           jpa2.selectedAccount = subContr.id;
           jpa2.next();
        
           Apexpages.currentPage().getParameters().put('nextStep','newOppty');
           Apexpages.currentPage().getParameters().put('recordType','US');
           Apexpages.currentPage().getParameters().put('jobProfileId',objJobProfile.id);
           JobProfileAccounts  JPA3 = new JobProfileAccounts();
           jpa3.getAccountsforJobProfile();
           jpa3.next();
    }
}