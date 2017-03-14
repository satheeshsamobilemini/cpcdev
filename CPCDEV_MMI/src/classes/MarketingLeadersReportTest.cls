/************************************************************************************************************
* Name          : MarketingLeadersReportTest                                                       					*
* Created By    : Cloud Challenger (Cloud Spokes submission)                                                * 
* Created Date  : : 31st Dec 2012                                                                           *
* Modified By   : Appirio Offshore (Hemant)                                                                 *
* Description   : Tests MarketingLeadersReport functionality                                       					*
************************************************************************************************************/

@isTest
public class MarketingLeadersReportTest{
    
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
        MarketingLeadersReport controller = new MarketingLeadersReport();
        System.Test.startTest();
        controller.retriveReportData();
        System.Test.stopTest();
    }
    
    /**
    * Test Other methods
    */
    public static TestMethod void testOtherMethods(){
        createSetupData();
        MarketingLeadersReport leadController = new MarketingLeadersReport();
        System.Test.startTest();
        leadController.retriveReportData();
        
        String DATE_FILTER_RANGE_TODAY = 'Todays_Leads';
         String DATE_FILTER_RANGE_THIS_WEEK = 'This_Weeks_Leads';
         String DATE_FILTER_RANGE_THIS_MONTH = 'This_Months_Leads';
         String DATE_FILTER_RANGE_CUSTOM = 'Custom';
        
        leadController.selectedDateFilter = DATE_FILTER_RANGE_TODAY;
        leadController.setDateFilterRange();
        
        leadController.selectedDateFilter = DATE_FILTER_RANGE_THIS_MONTH;
        leadController.setDateFilterRange();
        
        leadController.selectedDateFilter = DATE_FILTER_RANGE_THIS_WEEK;
        leadController.setDateFilterRange();
        
        leadController.selectedDateFilter = DATE_FILTER_RANGE_THIS_WEEK;
        
        leadController.selectedTeamFilter = 'My Team';
        
        leadController.selectedBranch = '102'; 
        leadController.retriveReportData();
        
        leadController.selectedDateFilter = DATE_FILTER_RANGE_CUSTOM;
        leadController.setDateFilterRange();
				leadController.leadFrom.Date_Required__c = Date.today();
        leadController.leadTo.Date_Required__c = Date.today().addDays(5);
        leadController.retriveReportData();
        
        System.Test.stopTest();
    }
}