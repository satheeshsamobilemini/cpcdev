/************************************************************************************************************
* Name          : LeadLeaderboardMetricControllerTest                                                       *
* Created By    : Cloud Challenger (Cloud Spokes submission)                                                * 
* Created Date  : : 31st Dec 2012                                                                           *                                                                             *
* Modified By   : Appirio Offshore (Hemant)                                                                 *
* Description   : Tests LeadLeaderboardMetricController functionality                                       *
************************************************************************************************************/

@isTest
public class LeadLeaderboardMetricControllerTest{
    
    static Lead l;
    static User integrationUser;
    
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
        
        l = new Lead();
        l.Status = 'Open';
        l.Rating = 'Hot (Probably Order)';
        l.LastName = 'Test';
        l.Company = 'Test Company';
        l.Branch__c = '102';
        
        if(integrationUser != null){
    			System.runAs(integrationUser){
    				insert l;	
    			}
    		}else{
    			insert l;
    		}
    }
    
    /**
    * Test retriveLeadReportDataNew functionality
    */
    public static TestMethod void testretriveLeadReportDataNew(){
        createSetupData();
        LeadLeaderboardMetricController leadController = new LeadLeaderboardMetricController();
        Test.startTest();
        leadController.retriveLeadReportDataNew();
        Test.stopTest();
    }
    
    /**
    * Test drillDownLeads functionality
    */
    public static TestMethod void testDrillDownLeadsWithLongestNotCalled(){
        createSetupData();
        LeadLeaderboardMetricController leadController = new LeadLeaderboardMetricController();
        leadController.retriveLeadReportDataNew();
        leadController.selectedOwnerId = userinfo.getUserId();
        ApexPages.currentPage().getParameters().put('isNotCalled5','false');
        Test.startTest();
        leadController.drillDownLeads();
        Test.stopTest();
    }
    
    /**
    * Test drillDownLeads functionality
    */
    public static TestMethod void testDrillDownLeadsWithNotCalled(){
        createSetupData();
        LeadLeaderboardMetricController leadController = new LeadLeaderboardMetricController();
        leadController.retriveLeadReportDataNew();
        leadController.selectedOwnerId = userinfo.getUserId();
        ApexPages.currentPage().getParameters().put('isNotCalled5','true');
        Test.startTest();
        leadController.drillDownLeads();
        Test.stopTest();
    }
    
    /**
    * Test retriveLeadReportDataNew functionality with error
    */
    public static TestMethod void testretriveLeadReportDataNewError(){
        createSetupData();
        LeadLeaderboardMetricController leadController = new LeadLeaderboardMetricController();
        Test.startTest();
        leadController.retriveLeadReportDataNew();
        Test.stopTest();
    }
    
    /**
    * Test goBack functionality with error
    */
    public static TestMethod void testGoBack(){
        createSetupData();
        LeadLeaderboardMetricController leadController = new LeadLeaderboardMetricController();
        Test.startTest();
        leadController.goBack();
        Test.stopTest();
    }
    
    /**
    * Test Other methods
    */
    public static TestMethod void testOtherMethods(){
        createSetupData();
        LeadLeaderboardMetricController leadController = new LeadLeaderboardMetricController();
        Test.startTest();
        leadController.retriveLeadReportDataNew();
        Boolean hsNxt = leadController.hasNext;
        hsNxt = leadController.hasPrevious;
        Integer pgSz = leadController.pageNumber;
        leadController.previous();
        leadController.next();
        leadController.last();
        leadController.first();
        leadController.getSortedData();
        leadController.getdlSortedData();
        
        String DATE_FILTER_RANGE_TODAY = 'Todays_Leads';
 				String DATE_FILTER_RANGE_THIS_WEEK = 'This_Weeks_Leads';
 				String DATE_FILTER_RANGE_THIS_MONTH = 'This_Months_Leads';
 				String DATE_FILTER_RANGE_CUSTOM = 'Custom';
        
        leadController.selectedDateFilter = DATE_FILTER_RANGE_TODAY;
        leadController.setDateFilterRange();
        
        leadController.selectedDateFilter = DATE_FILTER_RANGE_THIS_MONTH;
        leadController.setDateFilterRange();
        
        leadController.selectedDateFilter = DATE_FILTER_RANGE_CUSTOM;
        leadController.setDateFilterRange();
        
        leadController.selectedDateFilter = DATE_FILTER_RANGE_THIS_WEEK;
        leadController.setDateFilterRange();
        
        leadController.selectedDateFilter = DATE_FILTER_RANGE_THIS_WEEK;
        
        leadController.selectedTeamFilter = 'My Team';
        
        leadController.selectedBranch = '102'; 
        
        leadController.sortField = 'Leads_not_Called';
        leadController.retriveLeadReportDataNew();
        
        leadController.sortField = 'Leads_not_Called_Greater_Than_X';
        leadController.doSort();
        
        leadController.sortField = 'Longest_not_Called';
        leadController.doSort();
        
        Test.stopTest();
    }
}