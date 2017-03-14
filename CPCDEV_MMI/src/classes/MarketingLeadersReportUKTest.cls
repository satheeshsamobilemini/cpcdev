/************************************************************************************************************
* Name          : MarketingLeadersReportUKTest                                                                        
                                                            
* Description   : Tests MarketingLeadersReportUK functionality                                                       
************************************************************************************************************/

@isTest
public class MarketingLeadersReportUKTest{
    
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
        l.Response_Time__c = 25;
        l.First_Activity_DateTime__c = DateTime.now().addMinutes(-25);
        l.Original_Owner__c = UserInfo.getUserId();
        
        if(integrationUser != null){
          System.runAs(integrationUser){
            insert l;  
          }
        }else{
          insert l;
        }
    }
    
    /**
    * Test retriveReportData method
    */
    public static TestMethod void testRetriveReportData(){
        
        createSetupData();
        
        MarketingLeadersReportUK controller = new MarketingLeadersReportUK();
        System.Test.startTest();
        controller.retriveReportData();
        System.Test.stopTest();
    }
    
    /**
    * Test Other methods
    */
    public static TestMethod void testOtherMethods(){
        createSetupData();
        
        MarketingLeadersReportUK UKLeadReport = new MarketingLeadersReportUK();

        String DATE_FILTER_RANGE_TODAY = 'Todays_Leads';
        String DATE_FILTER_RANGE_THIS_WEEK = 'This_Weeks_Leads';
        String DATE_FILTER_RANGE_THIS_MONTH = 'This_Months_Leads';
        String DATE_FILTER_RANGE_CUSTOM = 'Custom';
        String TEAM_FILTER_MY_TEAM = 'Leaders';
        String TEAM_FILTER_ALL = 'Stragglers';
        Integer totalLdCount = 0;
        Decimal avgResponseTime = 0;
        
        System.Test.startTest();
        UKLeadReport.selectedTeamFilter = TEAM_FILTER_MY_TEAM ;
        UKLeadReport.retriveReportData();
        
        UKLeadReport.selectedTeamFilter = TEAM_FILTER_MY_TEAM ;
        UKLeadReport.selectedDateFilter = DATE_FILTER_RANGE_TODAY;
        UKLeadReport.setDateFilterRange();
        
        UKLeadReport.selectedTeamFilter = TEAM_FILTER_MY_TEAM ;
        UKLeadReport.selectedDateFilter = DATE_FILTER_RANGE_THIS_MONTH;
        UKLeadReport.setDateFilterRange();
        
        UKLeadReport.selectedTeamFilter = TEAM_FILTER_MY_TEAM ;
        UKLeadReport.selectedDateFilter = DATE_FILTER_RANGE_THIS_WEEK;
        UKLeadReport.setDateFilterRange();
        UKLeadReport.retriveReportData();
        
        UKLeadReport.selectedDateFilter = DATE_FILTER_RANGE_TODAY ;
        UKLeadReport.setDateFilterRange();
        UKLeadReport.leadFrom.Date_Required__c = Date.today();
        UKLeadReport.leadTo.Date_Required__c = Date.today();
        UKLeadReport.selectedTeamFilter = TEAM_FILTER_MY_TEAM ;
        UKLeadReport.retriveReportData();
        
        UKLeadReport.selectedDateFilter = DATE_FILTER_RANGE_CUSTOM;
        UKLeadReport.setDateFilterRange();
        UKLeadReport.leadFrom.Date_Required__c =Date.today();
        UKLeadReport.leadTo.Date_Required__c =Date.today().addDays(1);
        UKLeadReport.selectedTeamFilter = TEAM_FILTER_MY_TEAM ;
        UKLeadReport.retriveReportData();
        
        UKLeadReport.selectedDateFilter = DATE_FILTER_RANGE_CUSTOM;
        UKLeadReport.setDateFilterRange();
        UKLeadReport.leadFrom.Date_Required__c =Date.today();
        UKLeadReport.leadTo.Date_Required__c =Date.today().addDays(1);
        UKLeadReport.selectedTeamFilter = TEAM_FILTER_ALL;
        UKLeadReport.retriveReportData();
        
        
        MarketingLeadersReportUK.ReportData wrap = new MarketingLeadersReportUK.ReportData();
        System.Test.stopTest();
    }
}