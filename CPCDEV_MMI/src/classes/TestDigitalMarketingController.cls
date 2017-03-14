/************************************************************************************************************
* Name          : TestDigitalMarketingController
* Created By    : Appirio Offshore (Hemant)
* Created Date  : 28th May 2013
* Description   : Test class for DigitalMarketingController class
************************************************************************************************************/

@isTest
private class TestDigitalMarketingController{
    
    static Lead l;
    static User integrationUser;
    private static final String RECORDTYPE_MMI_WEB = 'MMI Web Lead';
    private static final String LEADSOURCE_MMI_US_WEBSITE = 'MMI US Website';
    
    /**
    * Create test data
    */
    
    static{
        for(User usr : [Select id from User where Name = 'Integration User' limit 1]){
            integrationUser = usr;
        }
    }
    
    static void createSetupData(){
        
        Manage_Triggers__c triggerCustomSetting = new Manage_Triggers__c(Name = 'SendDeadLeadTo360IntegrationService');
        insert triggerCustomSetting;
        
        Id RecordTypeId_MMI_WEB;
                for(RecordType rt: [Select Id, Name, SobjectType from RecordType Where SobjectType = 'Contact' And Name =: RECORDTYPE_MMI_WEB And IsActive = true order By Name limit 1]){
                RecordTypeId_MMI_WEB = rt.Id;   
            }
        
        l = new Lead();
        l.Status = 'Open';
        l.Rating = 'Hot (Probably Order)';
        l.LastName = 'Test';
        l.Company = 'Test Company';
        l.Branch__c = '102';
        l.LeadSource = LEADSOURCE_MMI_US_WEBSITE;
        l.Storage_Category__c = 'Residential';
        l.cloudamp__GA_Term__c = 'test_GA_term';
        l.cloudamp__GA_Content__c = 'selfstorage';
        l.cloudamp__GA_Campaign__c = 'Brand';
        l.cloudamp__GA_Medium__c = 'cpc';
             
        if(RecordTypeId_MMI_WEB != null){
            l.RecordTypeId = RecordTypeId_MMI_WEB;
        }
        
        if(integrationUser != null){
                System.runAs(integrationUser){
                    insert l;   
                }
            }else{
                insert l;
            }
            System.assertNotEquals(l.Id, null);
         DigitalMarketingController DMController = new DigitalMarketingController();
         DMController.retriveLeadData();
        
            DigitalMarketing_Filters__c dmf = new DigitalMarketing_Filters__c(Name = 'DigitalMarketing_Filters_1', GA_Content_Picklist__c = 'selfstorage;Null', GA_Campaign_Picklist__c = 'Brand', GA_Medium_Picklist__c = 'cpc');
            insert dmf;
            System.assertNotEquals(dmf.Id, null);
    }
    
    /**
    * Test testretriveLeadData functionality
    */
    static TestMethod void testretriveLeadData(){
        createSetupData();
        DigitalMarketingController DMController = new DigitalMarketingController();
        Test.startTest();
        
        DMController.selectedStorageCategory = new List<String>{'Residential'};
        DMController.leadFrom.cloudamp__GA_Term__c = 'test_GA_term';
        DMController.selectedGAContent = new List<String>{'selfstorage'};
        DMController.selectedGACampaign = 'Brand';
        DMController.selectedGAMedium = 'cpc';
                
                String DATE_FILTER_RANGE_TODAY = 'Today';
                String DATE_FILTER_RANGE_THIS_WEEK = 'This_Week';
                String DATE_FILTER_RANGE_THIS_MONTH = 'This_Month';
                String DATE_FILTER_RANGE_THIS_YEAR = 'This_Year';
                String DATE_FILTER_RANGE_LAST_WEEK = 'Last_Week';
                String DATE_FILTER_RANGE_LAST_MONTH = 'Last_Month';
                String DATE_FILTER_RANGE_LAST_YEAR = 'Last_Year';
                String DATE_FILTER_RANGE_CUSTOM = 'Custom';
                
                DMController.selectedDateFilter = DATE_FILTER_RANGE_CUSTOM;
        DMController.leadFrom.Date_Required__c = Date.today().addDays(-1);
        DMController.leadTo.Date_Required__c = Date.today().addDays(5);
        
        DMController.retriveLeadData();
        
        DMController.exportCSV();
        DMController.showGraphData();
        
        DigitalMarketingController.WrapperGATerm  dwrapper = new DigitalMarketingController.WrapperGATerm();
        
        testDtFltrsWithGrph(DMController, DATE_FILTER_RANGE_TODAY);
        testDtFltrsWithGrph(DMController, DATE_FILTER_RANGE_THIS_WEEK);
        testDtFltrsWithGrph(DMController, DATE_FILTER_RANGE_THIS_MONTH);
        testDtFltrsWithGrph(DMController, DATE_FILTER_RANGE_THIS_YEAR);
        testDtFltrsWithGrph(DMController, DATE_FILTER_RANGE_LAST_WEEK);
        testDtFltrsWithGrph(DMController, DATE_FILTER_RANGE_LAST_YEAR);
        testDtFltrsWithGrph(DMController, DATE_FILTER_RANGE_LAST_MONTH);
        Test.stopTest();
    }
    
    //method to test the data for the date range along with Graph data
    private static void testDtFltrsWithGrph(DigitalMarketingController DMController, String DateFilterRange){
        DMController.selectedDateFilter = DateFilterRange;
      DMController.setDateFilterRange();
      DMController.showGraphData();
    }
}