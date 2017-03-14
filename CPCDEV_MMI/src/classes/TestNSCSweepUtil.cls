/*****************************************************************************
* Name             : TestNSCSweepUtil
* Created By       : Bharti(Appirio Offshore)
* Created Date     : 16th April, 2012.
* Purpose          : Test Converage of 
1)NSCSweepUtil
2)scheduleNSCSweepOpportunities
3)ProcessConstructionBatchProcessor
4)ProcessNonConstructionBatchProcessor
*****************************************************************************/

@isTest
private class TestNSCSweepUtil {
    
    static Id opportunityId;
    static testMethod void testSchedulerCall(){
        
        DateTime currentTime = system.now().addSeconds(60);
        String sch = String.valueOf(currentTime.second() ) + ' ' + String.valueOf(currentTime.minute() ) + ' ' + String.valueOf( currentTime.hour()) + ' ' + String.valueOf( currentTime.day() ) + ' ' + String.valueOf( currentTime.month() ) + ' ' + '? ' + String.valueOf( currentTime.year() );
        
        
        Test.startTest();        
        scheduleNSCSweepOpportunities  scheduleNSC = new scheduleNSCSweepOpportunities();
        system.schedule('Schedule NSC sweep '+ String.valueof(currentTime) ,sch,scheduleNSC );
        Test.stopTest();
    }
    
    @isTest static void testNSCSSweepUtil(){
        Test.startTest(); 
        
        /*UserRole Usrrole = new UserRole(name = 'Inbound Sales Manager');
            insert Usrrole;
            
            Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
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
            //u.userroleid = Usrrole.Id;
            insert u;
            
            Branch_Lookup__c Bl = new Branch_Lookup__c();
            Bl.Zip__c = '19456';
            Bl.City__c = 'Oaks';
            Bl.State__c = 'PA';
            Bl.County__c = 'USA';
            Bl.Branch_Code__c = '44';
            insert Bl;
            
            Account acc = New Account();
            acc.Name='Test Account';
            //acc.ownerid=salesRep1.Id;
            insert acc;
            
            Opportunity Opp = New Opportunity();
            Opp.Name = 'Test APEX Opportunity'; 
            Opp.AccountID = acc.Id;
            Opp.StageName = 'Quoted - No Decision'; 
            Opp.CloseDate = Date.newInstance(2009,07,30);
            insert Opp;
            
            List<Opportunity> lstOpp = new List<Opportunity>();
            lstOpp.add(Opp); 
        */
        NSCSweepUtil NS = new NSCSweepUtil();
        //NSCSweepUtil.initialize(lstOpp,true);
        
        
        Test.stopTest();
    }
    
    static testMethod void testConstructionProcess() {
        
        User user = new User(Id = UserInfo.getUserId());
        for(User u : [select id from user where (UserRole.Name like '%Inbound%' OR profile.Name like '%Inbound%') and isActive = true]){
            user = u ;
        }
        
        
        Test.startTest();
        ProcessConstructionBatchProcessor batchClass = new ProcessConstructionBatchProcessor(new Set<Id>{opportunityId},system.now().addHours(2));
        Database.executeBatch(batchClass , 100);
        
        Test.stopTest();
    }
    
    static testMethod void testNonConstructionProcess() {
        
        User user = new User(Id = UserInfo.getUserId());
        for(User u : [select id from user where (UserRole.Name like '%Inbound%' OR profile.Name like '%Inbound%') and isActive = true]){
            user = u ;
        }
        
        Test.startTest();   
        ProcessNonConstructionBatchProcessor batchClass = new ProcessNonConstructionBatchProcessor(new Set<Id>{opportunityId},system.now().addHours(2));
        Database.executeBatch(batchClass , 100);
        Test.stopTest(); 
    }
    
    static void prepareTestdata(String accountName){        
        Account acc = new Account();
        acc.name = accountName;
        acc.BillingCountry  = 'sassadsad';
        insert acc;
        
        Contact contct = new Contact (AccountId = acc.Id,LastName = 'test contact');
        insert contct;
        
        Opportunity opp = new opportunity();
        opp.name = 'test';
        opp.stageName = 'stage';
        opp.CloseDate = date.today().addDays(7);
        opp.AccountId = acc.Id;  
        insert opp;
        opportunityId = opp.Id;
        
        Task tsk = new Task();
        tsk.WhatId = opp.Id; 
        //tsk.ownerID = u2.id;
        //insert tsk;
        
        List<Opportunity>  opptyList = new List<Opportunity>();
        opptyList.add(opp);
        NSCSweepUtil ns = new NSCSweepUtil();
        NSCSweepUtil.processNonConstructionOpportunities(opptyList);
        NSCSweepUtil.processConstructionOpportunities(opptyList);
        
    }
    
}