@isTest
private class SubContractorManageOpportunityTest{
    @isTest static void testSubContractorManageOpportunity(){
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        User u = new User();
        u.Alias = 'standt';
        u.Email='standarduser@testorg.com'; 
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US'; 
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles'; 
        u.UserName='standarduser@test1org.com';
        insert u;
        system.debug('User Inserted===========>>>>>>>>'+u);
        
        User Usr = [SELECT Phone, Id FROM User WHERE Id = : UserInfo.getUserId()];
        system.debug('User2 Information===========>>>>>>>>'+Usr);
        
        Job_Profile__c Jp = new Job_Profile__c();
        Jp.Name = 'Test job';
        Jp.Branch_ID__c = '101';
        Jp.Job_Site_Zip__c = '560037';
        Jp.Job_Site_Country__c = 'INDIA';
        insert Jp;
        system.debug('Job_Profile__c===========>>>>>>>>'+Jp);
        
        Account Acc = new Account();
        Acc.Name = 'Test Account';
        Acc.OwnerId__c = Usr.Id;
        Acc.OwnerId = Usr.Id;
        insert Acc;
        system.debug('Account Inserted===========>>>>>>>>'+Acc.OwnerId);
        
        Sub_Contractor__c Sc = new Sub_Contractor__c();
        Sc.Account__c = Acc.Id;
        Sc.Job_Profile__c = Jp.Id;
        Sc.Role__c = 'Carpentry / Framing Contractor';
        insert Sc;
        
        Task task = new Task();
        task.Lead_Rating__c = 'Hot (Probably Order)';
        task.Subject = 'Sub Contractor Awarded Bid';
        task.ActivityDate = date.newInstance(2008, 12, 1);
        task.WhatId = Acc.Id;
        task.Call_Type__c = 'Job Profile Follow Up';
        task.Job_Profile_Id__c = Jp.Id;
        insert task; 
        task.OwnerId = Acc.OwnerId__c;
        
        Sub_Contractor__c Sc1 = new Sub_Contractor__c();
        Sc1.Account__c = Acc.Id;
        Sc1.Job_Profile__c = Jp.Id;
        Sc1.Role__c = 'Carpentry / Framing Contractor';
        insert Sc1;
        Sub_Contractor__c objSc =[Select id,Account_Owner__c,Job_Profile__c,Account__c from Sub_Contractor__c where id=:Sc.id];
        
        
        system.debug('AccountOwner======>>>>>>>>>'+Sc.Account__c);
        system.debug('AccountOwner1======>>>>>>>>>'+objSc);
        system.debug('AccountOwner1======>>>>>>>>>'+objSc.Account_Owner__c);
        List<Sub_Contractor__c> subConList = new List<Sub_Contractor__c>();
        subConList.add(objSc);
        SubContractorManageOpportunity.ProcessSubContractors(subConList);
        
        system.debug('Sub_Contractor__c===========>>>>>>>>'+Sc);
        
    }
}