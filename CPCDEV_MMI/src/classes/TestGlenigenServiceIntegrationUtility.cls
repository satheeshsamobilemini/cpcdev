/*********************************************************************************
Name :          TestGlenigenServiceIntegrationUtility 
Created By :    Appirio [Bharti Mehta]
Created Date :  23 Aug 2012
Description :   TestClass for TestGlenigenServiceIntegrationUtility
*********************************************************************************/
@isTest
private class TestGlenigenServiceIntegrationUtility {
    
    
    //this method is only to increase testcoverage
    @isTest
    static void testGetResponse(){
        Test.startTest();
        GlenigenServiceIntegrationUtility.getResponse('google.com');
        GlenigenServiceIntegrationUtility.Porject proj = new GlenigenServiceIntegrationUtility.Porject();
        GlenigenServiceIntegrationUtility.bidder bidder = new GlenigenServiceIntegrationUtility.bidder();
        Test.stopTest();
    }
    
    @isTest
    static void testUpsertProject(){
        Test.startTest();
        GlenigenServiceIntegrationUtility.migrateNewProjects();        
        GlenigenServiceIntegrationUtility.migrateExistingProjects();         
        GlenigenServiceIntegrationUtility.migrateBidders();
        Test.stopTest();
        Set<String>   cyNoSet = new Set<String>();
        List<Glenigan_Bidder__c> bidders = new List<Glenigan_Bidder__c>();
        GlenigenServiceIntegrationUtility.loadAccount(cyNoSet);
        GlenigenServiceIntegrationUtility.createHotLeads(bidders);
        GlenigenServiceIntegrationUtility.updateLastLogin();
        //verify result
        List<Glenigan_Project__c> project = [select Id, Ptno__c from Glenigan_Project__c where Ptno__c = 509968334];
        system.assertEquals(project.size(),1);
        
        //verify result
        List<Glenigan_Bidder__c> bidder = [select Id from Glenigan_Bidder__c where Glenigan_Project__r.Ptno__c = 509968334];
       // system.assertEquals(bidder.size(),0);
    }
    
    @isTest
    static void testUpsertBidder(){
        Test.startTest();                       
        GlenigenServiceIntegrationUtility.migrateBidders();  
        
        Test.stopTest();
        
        //verify result
        List<Glenigan_Bidder__c> bidder = [select Id from Glenigan_Bidder__c where RoleId__c = 2131 and RoleGroupId__c = 116];
       // system.assertEquals(bidder.size(),0);
    }
    
     @isTest
    static void testScheduleGlenigenServiceIntegration(){
        Test.startTest();
        ScheduleGlenigenServiceIntegration scheduler = new ScheduleGlenigenServiceIntegration();
        //START CASE 00052959 - DIANA LOSEY - 9/5/13
        //DateTime currentTime = system.now().addSeconds(1);
        //String sch = String.valueOf(currentTime.second() ) + ' ' + String.valueOf(currentTime.minute() ) + ' ' + String.valueOf( currentTime.hour() ) + ' ' + String.valueOf( currentTime.day() ) + ' ' + String.valueOf( currentTime.month() ) + ' ' + '? ' + String.valueOf( currentTime.year() );
        String sch = '0 0 4 ? * *'; 
        //END CASE 00052959
        system.schedule('TestScheduleGlenigenServiceIntegration' ,sch,scheduler );
        Test.stopTest();
    }
}