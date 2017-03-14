/************************************************************************************************************
* Name          : MarketingLeadersReportUK                                                                    *
* Created By    : Cloud Challenger (Cloud Spokes Submission)                                                *
* Created Date  : 28th Nov 2012                                                                              *    
* Modified By   : G Simpson                                                                 *
* Description   : This class is used to show marketing leaders the monthly leads                            *
************************************************************************************************************/

public class MarketingLeadersReportUK{
    
    //Constansts
    private static final String ERROR_MESSAGE = 'There are large number of records queried that cannot be shown on the page. Please apply the filters to refine your search criteria.';
    
    private static final String DATE_FILTER_RANGE_TODAY = 'Todays_Leads';
    private static final String DATE_FILTER_RANGE_THIS_WEEK = 'This_Weeks_Leads';
    private static final String DATE_FILTER_RANGE_THIS_MONTH = 'This_Months_Leads';
    private static final String DATE_FILTER_RANGE_CUSTOM = 'Custom';
    private static final String TEAM_FILTER_MY_TEAM = 'Leaders';
    private static final String TEAM_FILTER_ALL = 'Stragglers';
    
    private static final String NAME_INTEGRATION_USER = 'Integration User';
    private static final string DEFAULT_SORT_FIELD = 'Name';
    
    private static final Integer DEFAULT_NUM_REP_TO_DISPLAY = 20;
    
    // Lead instance used to show report filter 
    public Lead leadFrom{get;set;}
    public Lead leadTo{get;set;}
    
    private Set<Id> myTeamUserIdSet;
    private DateTime fromCreatedDate;
    private DateTime toCreatedDate;
    private Integer limitCount;
    private String createdDateFilter;
    
    //For branch
    public String selectedBranch{get;set;}  
    public List<SelectOption> branchList{get;set;}
    
    //For Date Filter
    public String selectedDateFilter{get;set;}  
    public List<SelectOption> dateFilterList{get;set;}
    
    //For Team Filter
    public String selectedTeamFilter{get;set;}  
    public List<SelectOption> teamFilterList{get;set;}
    
    /**
    * Map of user id and its information 
    */
    public Map<Id,user> userMap{get;set;}
    
    /**
    * List of ReportData to be shown on page
    */
    public List<ReportData> resultReportData{get;set;}
    
    /**
    * Constructor
    */    
    public MarketingLeadersReportUK(){
        
        init();
        retriveReportData();
    }
    
    //initialization method
    private void init(){
      
      leadFrom = new Lead();
      leadTo = new Lead();
      
      //load the Filter options

      dateFilterList = getDateFilterOptions();
      teamFilterList = getTeamFilterOptions();
      
     // selectedDateFilter = DATE_FILTER_RANGE_THIS_MONTH;
     // setDateFilterRange();
    }
    

    
    //loading Date filter options
    private List<SelectOption> getDateFilterOptions(){
      List<SelectOption> options = new List<SelectOption>();
      options.add(new SelectOption('', 'Select'));
      options.add(new SelectOption(DATE_FILTER_RANGE_TODAY, 'Today’s Leads'));
      options.add(new SelectOption(DATE_FILTER_RANGE_THIS_WEEK, 'This Week’s Leads'));
      options.add(new SelectOption(DATE_FILTER_RANGE_THIS_MONTH, 'This Month’s Leads'));
      options.add(new SelectOption(DATE_FILTER_RANGE_CUSTOM, DATE_FILTER_RANGE_CUSTOM));
      return options;
    }
    
    //loading Team filter options
    private List<SelectOption> getTeamFilterOptions(){
      List<SelectOption> options = new List<SelectOption>();
    
      options.add(new SelectOption(TEAM_FILTER_MY_TEAM,TEAM_FILTER_MY_TEAM));
      options.add(new SelectOption(TEAM_FILTER_ALL,TEAM_FILTER_ALL));
      return options;
    }
    
    //method to set the date filter range
    public void setDateFilterRange(){
      
      if(selectedDateFilter != null && selectedDateFilter == DATE_FILTER_RANGE_TODAY){
        leadFrom.Date_Required__c = leadTo.Date_Required__c = Date.today();
        createdDateFilter = 'TODAY';
      }else if(selectedDateFilter != null && selectedDateFilter == DATE_FILTER_RANGE_THIS_WEEK){
        leadFrom.Date_Required__c = date.today().toStartofWeek();
        leadTo.Date_Required__c = Date.today().toStartofWeek().addDays(6);
        createdDateFilter = 'THIS_WEEK';
      }else if(selectedDateFilter != null && selectedDateFilter == DATE_FILTER_RANGE_THIS_MONTH){
        leadFrom.Date_Required__c = date.today().toStartOfMonth();
        Integer daysInCurrentMonth = date.daysInMonth(date.today().year(), date.today().month());
        createdDateFilter = 'THIS_MONTH';
        leadTo.Date_Required__c = Date.today().toStartOfMonth().addDays(daysInCurrentMonth-1);
      }else if(selectedDateFilter != null && selectedDateFilter == DATE_FILTER_RANGE_CUSTOM){
        leadFrom.Date_Required__c = leadTo.Date_Required__c = NULL;
      }
    }
    
    /**
    * This method is used to retrive leads of the current month group 
    * by Original_Owner__c(owner) then with status
    */
    public void retriveReportData(){
        
        resultReportData = new List<ReportData>();
        Set<Id> usrIdSet = new Set<Id>(); 
        Map<Id,ReportData> resultReportDataMap = new Map<Id,ReportData>();
        
        String aggQry = 'select count(id) cnt, avg(Response_Time__c) avgRsTime, Original_Owner__c own From Lead';
       aggQry += ' WHERE (CreatedBy.Name = \'Integration User\' OR CreatedBy.Name = \'Glenigan Integration User\')';
       aggQry += ' AND Branch__c LIKE \'7%\'';
       aggQry += ' AND (Owner.UserRole.Name LIKE \'NSC Team Member - UK%\' OR Owner.UserRole.Name LIKE \'Sales Rep - 7%\') AND Owner.Name != \'Chris Gorman\'';
        aggQry += ' AND Branch__c LIKE \'7%\'';
        aggQry += ' AND Original_Owner__r.Branch__c LIKE \'7%\'';
        aggQry += ' AND Original_Owner__r.Name != \'Holding Accounts 777\'';
        aggQry += ' AND (Original_Owner__r.UserRole.Name LIKE \'NSC Team Member - UK%\' OR Original_Owner__r.UserRole.Name LIKE \'Sales Rep - 7%\') AND Original_Owner__r.Name != \'Chris Gorman\'';
         aggQry += ' AND Owner.IsActive = TRUE';
        aggQry += ' AND Original_Owner__r.IsActive = TRUE';
        
        aggQry += getSOQLQuery_WhereCondition();
     
     if(selectedTeamFilter == null || selectedTeamFilter == '' || selectedTeamFilter == TEAM_FILTER_MY_TEAM){
        aggQry += ' GROUP BY Original_Owner__c Order By avg(Response_Time__c) asc Limit ' + String.valueOf(DEFAULT_NUM_REP_TO_DISPLAY);
        }
        
        if(selectedTeamFilter != null && selectedTeamFilter != '' && selectedTeamFilter == TEAM_FILTER_ALL){
        aggQry += ' GROUP BY Original_Owner__c Order By avg(Response_Time__c) desc Limit ' + String.valueOf(DEFAULT_NUM_REP_TO_DISPLAY);
        }
        
        List<AggregateResult> resultList = new List<AggregateResult>((List<AggregateResult>)Database.query(aggQry));
                
        if(resultList == null || resultList.size() == 0){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.info,'No Leads'));
            return;
        }
        
        ReportData rptData;
        System.debug('**************1-resultList******************'+resultList);
        for(AggregateResult result: resultList){
            
            String ownerId = (String)result.get('own');
            if(ownerId.startsWith('00G')){
              continue;
            }
            
            rptData = new ReportData();
            
            //Set UserId for the Rep            
            rptData.userId = ownerId;
            usrIdSet.add(ownerId);
            
            //Set total lead count for the Rep
            rptData.totalLdCount = (Integer)result.get('cnt');
            
            //Set Average Response Time for the Rep
            System.debug('**************2-result.get(avgRsTime)******************'+result.get('avgRsTime'));
            System.debug('**************3-aggQry******************'+aggQry);
            
            if(result.get('avgRsTime') != null){
              rptData.avgResponseTime = ((Decimal)result.get('avgRsTime')).setScale(2);  
            }
            resultReportData.add(rptData);
        }
        System.debug('**************12-resultReportData******************'+resultReportData);   
        
        /**
        * Retrive all the user information
        */
        
         userMap = new map<Id,User>([select FullPhotoUrl,Name from User where Id IN: usrIdSet]); 
        
        /* userMap = new map<Id,User>([select FullPhotoUrl,Name from User where Id IN: usrIdSet AND ProfileId = '00e800000017uuIAAQ']); */
        
    }
    
    
    
    
    
    // method to get the where condition query after applying the filters
    private String getSOQLQuery_WhereCondition(){
       String soqlQry_Where = ' AND First_Activity_DateTime__c != null AND Original_Owner__c != null';

       
       
       /* soqlQry_Where += ' AND Owner.Branch__c LIKE \'7%\''; */
       /* soqlQry_Where += ' AND (Owner.UserRole LIKE \'Sales Rep - 7%\' OR Owner.UserRole LIKE \'NSC Team Member - UK%\')';  */
       

       
       if(selectedDateFilter != null && selectedDateFilter != '' && leadFrom.Date_Required__c != null && leadTo.Date_Required__c != null){
          if(selectedDateFilter == DATE_FILTER_RANGE_CUSTOM){       
           fromCreatedDate = Datetime.newInstance(leadFrom.Date_Required__c.year(), leadFrom.Date_Required__c.month(), leadFrom.Date_Required__c.day());
            toCreatedDate = Datetime.newInstance(leadTo.Date_Required__c.addDays(1).year(), leadTo.Date_Required__c.addDays(1).month(), leadTo.Date_Required__c.addDays(1).day());
            //toCreatedDate = leadTo.Date_Required__c.addDays(1);
            System.debug('**************4-soqlQry_Where IN CUSTOM******************'+soqlQry_Where);
            System.debug('**************5-fromCreatedDate******************'+fromCreatedDate);
            System.debug('**************6-toCreatedDate******************'+toCreatedDate);
            System.debug('**************7-leadFrom.Date_Required__c******************'+leadFrom.Date_Required__c);
            System.debug('**************8-leadTo.Date_Required__c******************'+leadTo.Date_Required__c);
            
           soqlQry_Where += ' AND (CreatedDate >= : fromCreatedDate AND CreatedDate <: toCreatedDate)';      
         }else{
             System.debug('**************9-soqlQry_Where WITHOUT CUSTOM******************'+soqlQry_Where);
             System.debug('**************10-createdDateFilter******************'+createdDateFilter);
            soqlQry_Where += ' AND (CreatedDate = ' + createdDateFilter + ')';
         }
       }
       System.debug('**************11-soqlQry_Where******************'+soqlQry_Where);
       return soqlQry_Where; 
    }
    
    
    //Method to get the Users in the current looged in user's team based on Role Hierachy 
    public Set<ID> getRoleSubordinateUsers(Id userId) {
 
      // get requested user's role
      Id roleId = [select UserRoleId from User where Id = :userId].UserRoleId;
      // get all of the roles underneath the user
      Set<Id> allSubRoleIds = getAllSubRoleIds(new Set<ID>{roleId});
      // get all of the ids for the users in those roles
      Map<Id,User> users = new Map<Id, User>([Select Id, Name From User where 
        UserRoleId IN :allSubRoleIds]);
      // return the ids as a set so you can do what you want with them
      return users.keySet();
 
  }
 
  //Method to get all the child roles for the roleIds passed as parameter
  private Set<ID> getAllSubRoleIds(Set<ID> roleIds) {
 
    Set<ID> currentRoleIds = new Set<ID>();
 
    // get all of the roles underneath the passed roles
    for(UserRole userRole :[select Id from UserRole where ParentRoleId 
      IN :roleIds AND ParentRoleID != null])
    currentRoleIds.add(userRole.Id);
 
    // go fetch some more rolls!
    if(currentRoleIds.size() > 0)
      currentRoleIds.addAll(getAllSubRoleIds(currentRoleIds));
 
    return currentRoleIds;
 
  }
    
    /**
    * Wrapper class to show report data
    */
    public class ReportData{
        
        /**
        * totalLdCount number of leads assigned to user
        */
        public Integer totalLdCount{get;set;}
        
        /**
        * Number of avgResponseTime leads assigned to user
        */
        public Decimal avgResponseTime{get;set;}
        
        /**
        * Original_Owner__c (Owner)
        */
        public string userId{get;set;}
        
        /**
        * Set default value of totalLdCount, avgResponseTime and converted count to 0
        */
        public ReportData(){
            totalLdCount = 0;
            avgResponseTime = 0;
        }
    }
}