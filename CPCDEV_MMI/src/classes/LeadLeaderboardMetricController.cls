/************************************************************************************************************
* Name          : LeadLeaderboardMetricController                                                           *
* Created By    : Cloud Challenger (Cloud Spokes submission)                                                *
* Created Date  : 31st Dec 2012                                                                             *
* Modified By   : Appirio Offshore (Hemant)                                                                 *
* Description   : This class is used to show response report by rep                                         *
* Related VF Page: LeadLeaderboardMetric                                                                                                                                                                                                                                                                                *       
************************************************************************************************************/
@isTest(SeeAllData=true)
public class LeadLeaderboardMetricController{

                //Constansts
                private static final String ERROR_MESSAGE = 'There are large number of records queried that cannot be shown on the page. Please apply the filters to refine your search criteria.';
                private static final String DATE_FILTER_RANGE_TODAY = 'Todays_Leads';
                private static final String DATE_FILTER_RANGE_THIS_WEEK = 'This_Weeks_Leads';
                private static final String DATE_FILTER_RANGE_THIS_MONTH = 'This_Months_Leads';
                private static final String DATE_FILTER_RANGE_CUSTOM = 'Custom';
                private static final String TEAM_FILTER_MY_TEAM = 'My Team';
                private static final String TEAM_FILTER_ALL = 'All';
                private static final String TEAM_FILTER_US = 'US';         // MSM 90..
                private static final String TEAM_FILTER_UK = 'UK';        // MSM 90..
                private static final String LEAD_SOURCE_GLENIGAN = 'Glenigan'; // MSM 90..
                private static final String LEAD_RECORDTYPE_GLENIGAN = 'Glenigan_Lead'; // MSM 90..
                
                private static final String LEAD_RATING_HOT_PROBABLY_ORDER = 'Hot (Probably Order)';
                private static final String NAME_INTEGRATION_USER = 'Integration User';
                private static final String LEAD_SATUS_OPEN = 'Open';
                private static final String LEAD_SATUS_QUALIFIED = 'Qualified';
                private static final string DEFAULT_SORT_FIELD = 'Name';
                
                private static final Integer PAGE_SIZE = 50;
                private static final Integer THRESHOLD_RESPONSE_MINUTES = 20;
                
    // Lead instance used to show report filter 
    public Lead leadFrom{get;set;}
    public Lead leadTo{get;set;}
    public string sortField{set;get;}   
        public boolean isAsc{set; get;}
        private String previousSortField;
        
        //For Drill Down Lead data
        public string drilledUserName{get;set;}
        public string dlsortField{set;get;}   
        public boolean dlisAsc{set; get;}
        private String dlpreviousSortField;
        private String isNotCalled5;
        
        private DateTime thresholdDateTime;
    private Set<Id> myTeamUserIdSet;
    private Set<ID> USuserIdSet;    // MSM 90..
    private Set<ID> UKuserIdSet;    // MSM 90..
    private Date fromCreatedDate;
    private Date toCreatedDate;
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
    
    public Integer responseTimeThreshold{get;set;}
    
    /**
    * List of LeadNotCalledCount which is to be shown on page
    */
    public List<LeadNotCalledCount> reportResult{get;set;}
    public List<LeadNotCalledCount> reportResultMain{get;set;}
    private Map<Id,LeadNotCalledCount> resultMap;
    
    /**
    * List of leads to be shown on drilled page
    */
    public List<Lead> drillLeads{get;set;}
    
    /**
    * Boolean to show drilled leads panel
    */
    public boolean showDrilledLeads{get;set;}
    
    /**
    * Owner Id whose leads to be drilled
    */
    public String selectedOwnerId {get;set;}
    
    private Set<ID> ownerIDs;
     private BusinessHours bh;
     private BusinessHours bh298;
    private List<Lead> leadLst;
    public LeadNotCalledCount totalLdNotCount{get;set;}
    
    //constructor
    public LeadLeaderboardMetricController(){
        
        responseTimeThreshold = THRESHOLD_RESPONSE_MINUTES;
        reportResult = new List<LeadNotCalledCount>();
        reportResultMain = new List<LeadNotCalledCount>();
        drillLeads = new List<Lead>();
        showDrilledLeads = false;
        totalLdNotCount = new LeadNotCalledCount();
        init();
        
    }
    
    //initialization method
    private void init(){
        
        leadFrom = new Lead();
            leadTo = new Lead();
            previousSortField = '';
            sortField = DEFAULT_SORT_FIELD;
            isAsc = true;
            dlpreviousSortField = '';
            dlsortField = DEFAULT_SORT_FIELD;
            dlisAsc = true;
        
        //load the Filter options
        branchList = getBranchOptions();
        dateFilterList = getDateFilterOptions();
        teamFilterList = getTeamFilterOptions();
        leadLst = new List<Lead>();
        
        retriveLeadReportDataNew();
        
    }
    
    //loading brnaches
    private List<SelectOption> getBranchOptions(){
        List<SelectOption> options = new List<SelectOption>();
      options.add(new SelectOption('', 'Select'));        
            
            Schema.DescribeFieldResult F = User.Branch__c.getDescribe();
            List<Schema.PicklistEntry> P = F.getPicklistValues();    
            for (Schema.PicklistEntry pe : p){
              options.add(new SelectOption(pe.getValue().substring(0,3), pe.getValue().substring(0,3)));
            }
            return options;
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
      options.add(new SelectOption('', 'Select'));
      options.add(new SelectOption(TEAM_FILTER_MY_TEAM,TEAM_FILTER_MY_TEAM));
      options.add(new SelectOption(TEAM_FILTER_ALL,TEAM_FILTER_ALL));
      options.add(new SelectOption(TEAM_FILTER_US,TEAM_FILTER_US));   // MSM 90..  
      options.add(new SelectOption(TEAM_FILTER_UK,TEAM_FILTER_UK));   // MSM 90..
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
    
    //Instantiate the StandardSetController  
    public ApexPages.StandardSetController con{get; set;}
    
    //Boolean to check if there are more records after the present displaying records  
    public Boolean hasNext  
    {  
        get  
        {  
            return con.getHasNext();  
        }  
        set;  
    }  
   
    //Boolean to check if there are more records before the present displaying records  
    public Boolean hasPrevious  
    {  
        get  
        {  
            return con.getHasPrevious();  
        }  
        set;  
    }  
   
    //Page number of the current displaying records  
    public Integer pageNumber  
    {  
        get  
        {  
            return con.getPageNumber();  
        }  
        set;  
    }  
  
    //Returns the previous page of records  
    public void previous()  
    {  
        con.previous();
        selectDataList();
    }  
   
    //Returns the next page of records  
    public void next()  
    {  
        con.next();
        selectDataList(); 
    }  
    
    //Returns the last page of records
    public void last()
    {
        con.last();
        selectDataList();
    }
    
    //Returns the first page of records
    public void first()
    {
        con.first();
        selectDataList();
    }
    
    //method to select the data list
    private void selectDataList(){
        if(showDrilledLeads){
            populateDrillLeadsData();
        }else{
            populateLeadOwnerData();
        }
    }
      
    //sort list
    public PageReference doSort(){
        Map<String,LeadNotCalledCount> resultMapToSort = new Map<String,LeadNotCalledCount>(); 
        list<String> fieldName = new list<String>();
        List<Long> toSortLst = new List<Long>(); 
        Map<Long,List<LeadNotCalledCount>> mapToSort = new Map<Long,List<LeadNotCalledCount>>(); 
        
        if(sortField.equalsIgnoreCase('Name')){
           for(LeadNotCalledCount lc : reportResultMain){
                        fieldName.add(lc.userName + '#' + lc.userId);
                        resultMapToSort.put(lc.userName + '#' + lc.userId, lc); 
                }
        }
        
        else if(sortField.equalsIgnoreCase('Leads_not_Called')){
           for(LeadNotCalledCount lc : reportResultMain){
                        
                        if(!mapToSort.containsKey(lc.totalNotCalled)){
                                mapToSort.put(lc.totalNotCalled, new List<LeadNotCalledCount>{lc});
                                toSortLst.add(lc.totalNotCalled);
                        }else{
                                mapToSort.get(lc.totalNotCalled).add(lc);
                        }
                        
                }
        }
        else if(sortField.equalsIgnoreCase('Leads_not_Called_Greater_Than_X')){
           for(LeadNotCalledCount lc : reportResultMain){
                        
                        if(!mapToSort.containsKey(lc.greaterThan5)){
                                mapToSort.put(lc.greaterThan5, new List<LeadNotCalledCount>{lc});
                                toSortLst.add(lc.greaterThan5);
                        }else{
                                mapToSort.get(lc.greaterThan5).add(lc);
                        }
                        
                }
        }
        else if(sortField.equalsIgnoreCase('Longest_not_Called')){
           for(LeadNotCalledCount lc : reportResultMain){
                
                if(!mapToSort.containsKey(lc.longestNoResponse)){
                                mapToSort.put(lc.longestNoResponse, new List<LeadNotCalledCount>{lc});
                                toSortLst.add(lc.longestNoResponse);
                        }else{
                                mapToSort.get(lc.longestNoResponse).add(lc);
                        }
                }
        }
        
        leadLst = new List<Lead>();
        
        if(sortField.equalsIgnoreCase('Name')){
                fieldName.sort();
                if(isAsc){
                    for(String fName : fieldName){
                        leadLst.add(resultMapToSort.get(fName).leadOwner);
                    }
                }else{
                    for(Integer i = fieldName.size()-1; i>=0; i--){
                        leadLst.add(resultMapToSort.get(fieldName[i]).leadOwner);
                    }
                }
        }else{
                toSortLst.sort();
                
                if(isAsc){
                    for(Long fName : toSortLst){
                        for(LeadNotCalledCount lc : mapToSort.get(fName)){
                                leadLst.add(lc.leadOwner);      
                        }
                    }
                }else{
                    for(Integer i = toSortLst.size()-1; i>=0; i--){
                        for(LeadNotCalledCount lc : mapToSort.get(toSortLst[i])){
                                leadLst.add(lc.leadOwner);
                        }
                    }
                }
                
        }
        
        con = new ApexPages.StandardSetController(leadLst);
        con.setPageSize(PAGE_SIZE);
        
        return null;
    }
    
    //method to populate the data to be shown in current page
    private void populateLeadOwnerData(){
                reportResult = new List<LeadNotCalledCount>();
        for(Lead ld : (List<Lead>)con.getRecords()){
                reportResult.add(resultMap.get(ld.OwnerId));
        } 
    }
    
    //method called when Column Sorting arrow is clicked 
    public void getSortedData(){
        isAsc = previousSortField.equals(sortField)? !isAsc : true;
        doSort();
        previousSortField = sortField;
                        populateLeadOwnerData();
    }
    
    //method called when Column Sorting arrow is clicked 
    public void getDLSortedData(){
        dlisAsc = dlpreviousSortField.equals(dlsortField)? !dlisAsc : true;       
        setDrillDownLeadsData(isNotCalled5);
        dlpreviousSortField = dlsortField;
    }
    
    /**
    * This method is used to retrive leads whose First_Activity_DateTime__c is null
    * and increment count of leads which are not called and longest no response time
    */
  public void retriveLeadReportDataNew(){
            showDrilledLeads = false;
        try{
           //Updated by Akanksha for story S-143271  
            List<BusinessHours> bhList = [SELECT Id FROM BusinessHours WHERE IsDefault=true Limit 1];
            List<BusinessHours> bh298List = [SELECT Id FROM BusinessHours WHERE name = 'Branch 298'];//Added by Akanksha for story S-143271 
            if(bhList != null && bhList.size() > 0){
                bh = bhList[0];    
                bh298 = bh298List[0];                   
                ownerIDs = new Set<ID>();
                String aggQry = 'SELECT OwnerId FROM Lead';
                aggQry += getSOQLQuery_WhereCondition();
     
                                                    aggQry += ' GROUP BY OwnerId';
                                                    
                                                    aggQry += getSOQLQuery_LimitCondition();
                
                system.debug('----------- aggQry ---------' + aggQry);
                for(AggregateResult ar : Database.query(aggQry)){
                    ownerIDs.add((Id)ar.get('OwnerId'));
                }
                //End by Akanksha for story S-143271 
                populateLeadOwnerDataInit(bh,bh298);
                doSort();
                selectDataList();
                
            }
        }
        catch(Exception ex){
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,ex.getMessage()));
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,ERROR_MESSAGE));
          return;
        }
    }
    
        //method to populate the data in leadownerlist and Updated by Akanksha for story S-143271 
    private void populateLeadOwnerDataInit(BusinessHours bh,BusinessHours bh298 ){
        reportResultMain = new List<LeadNotCalledCount>();
        resultMap = new Map<Id,LeadNotCalledCount>();
        leadNotCalledCount leadCount;
        totalLdNotCount = new LeadNotCalledCount();
        
        for(Lead l: Database.query(getLeadQuery())){
           
           if(resultMap.containsKey(l.OwnerId)){
               leadCount =  resultMap.get(l.OwnerId);
           }
           else{
                         leadCount = new LeadNotCalledCount();
                         
               leadCount.userId = l.OwnerId;
               leadCount.UserName = l.Owner.Name;
               leadCount.leadOwner = l;
           }
           // leads not called
           if(l.First_Activity_DateTime__c == null){
                leadCount.totalNotCalled += 1;
                totalLdNotCount.totalNotCalled += 1;
                
                /**
                * Calculate notRespondedTime based on business hours
                */  
                //Added by Akanksha for story S-143271  
                Long notRepondedTime;
                if(l.Branch__c == '298')
                {
                        notRepondedTime = BusinessHours.diff(bh298.id, l.createdDate, Datetime.now())/1000/60;
                }
                else
                {
                        notRepondedTime = BusinessHours.diff(bh.id, l.createdDate, Datetime.now())/1000/60;
                }
                //End by Akanksha for story S-143271 
               
                /**
                * Calculate the longest no response time
                */
                if(notRepondedTime > leadCount.longestNoResponse){
                        leadCount.longestNoResponse = notRepondedTime;
                }
                
                //To find the average for the Total Leads Not called Time
                totalLdNotCount.longestNoResponse += notRepondedTime;
                
                /**
                * if notRepondedTime greater than threshold then increment threshold count   
                */
                if(notRepondedTime > responseTimeThreshold){
                    leadCount.greaterThan5 += 1;
                    totalLdNotCount.greaterThan5 += 1;
                }
           }
           
           if(!resultMap.containsKey(l.OwnerId)){
               resultMap.put(l.OwnerId,leadCount);
           }
        }
        
        //Calculate the average no response time for all leads
              if(totalLdNotCount.totalNotCalled != 0){
                totalLdNotCount.longestNoResponse = totalLdNotCount.longestNoResponse/totalLdNotCount.totalNotCalled;   
              }
        
        reportResultMain = resultMap.values();
                
    }
   
   //method to get the leads query 
   private String getLeadQuery(){
     String soqlQry = 'select OwnerId ,Original_Owner__c,Original_Owner__r.Name, Id,First_Activity_DateTime__c, Response_Time__c, CreatedDate, Owner.Name,Branch__c From Lead';
        
     String soqlQry_Where = getSOQLQuery_WhereCondition();
     
     soqlQry_Where += ' AND OwnerId IN: ownerIDs';
     
     soqlQry += soqlQry_Where + getSOQLQuery_LimitCondition();
     system.debug('*********soqlQry**********' + soqlQry);
     return soqlQry; 
    }
    
    // method to get the where condition query after applying the filters
    private String getSOQLQuery_WhereCondition(){
     String soqlQry_Where = ' Where First_Activity_DateTime__c = null';
     soqlQry_Where += ' AND Rating =: LEAD_RATING_HOT_PROBABLY_ORDER';
     soqlQry_Where += ' AND CreatedBy.Name = :NAME_INTEGRATION_USER';
     soqlQry_Where += ' AND (Status =: LEAD_SATUS_OPEN OR (Status =: LEAD_SATUS_QUALIFIED AND IsConverted = false))';
     soqlQry_Where += ' AND LeadSource !=: LEAD_SOURCE_GLENIGAN';  // MSM 90..
     soqlQry_Where += ' AND RecordType.Name !=: LEAD_RECORDTYPE_GLENIGAN';  // MSM 90..
     soqlQry_Where += ' AND Owner.Type = \'User\'';       // MSM 90..
     
     if(selectedBranch != null && selectedBranch != ''){
       soqlQry_Where += ' AND Branch__c = : selectedBranch';
     }
    
     if(selectedTeamFilter != null && selectedTeamFilter != '' && selectedTeamFilter == TEAM_FILTER_MY_TEAM){
         myTeamUserIdSet = new Set<Id>(getRoleSubordinateUsers(UserInfo.getUserId()));
         //Adding the Id for the logged in user in addition to its Role Subordinate Users
         myTeamUserIdSet.add(UserInfo.getUserId());
       soqlQry_Where += ' AND OwnerId IN: myTeamUserIdSet';
     }
     
     // MSM 90 .. US users
     if(selectedTeamFilter != null && selectedTeamFilter != '' && selectedTeamFilter == TEAM_FILTER_US){
         USuserIdSet = new Set<Id>(getUsers('US'));
       soqlQry_Where += ' AND OwnerId IN: USuserIdSet';
     }
     
     // MSM 90 .. UK users
     if(selectedTeamFilter != null && selectedTeamFilter != '' && selectedTeamFilter == TEAM_FILTER_UK){
       UKuserIdSet = new Set<Id>(getUsers('UK'));
       soqlQry_Where += ' AND OwnerId IN: UKuserIdSet';
     }
     
     if(selectedDateFilter != null && selectedDateFilter != '' && leadFrom.Date_Required__c != null && leadTo.Date_Required__c != null){
                         if(selectedDateFilter == DATE_FILTER_RANGE_CUSTOM){            
                           fromCreatedDate = leadFrom.Date_Required__c;
                 toCreatedDate = leadTo.Date_Required__c.addDays(1);
                 system.debug('*********fromCreatedDate**********' + fromCreatedDate + '********toCreatedDate**********'+toCreatedDate);
               soqlQry_Where += ' AND (CreatedDate >= : fromCreatedDate AND CreatedDate <: toCreatedDate)';                       
                         }else{
         soqlQry_Where += ' AND (CreatedDate = ' + createdDateFilter + ')';
                         }
         
     }
     
     return soqlQry_Where; 
      
    }
    
    // method to get the limit condition query 
    private String getSOQLQuery_LimitCondition(){
        limitCount = Limits.getLimitQueryRows() - Limits.getQueryRows();
      return ' Limit ' + String.valueOf(limitCount);
      
    }
    
    /**
    * This method is used to show drilled down leads when clicked on count
    */
    public PageReference drillDownLeads(){
                
        showDrilledLeads = true;
        drillLeads = new List<Lead>();
        isNotCalled5 = ApexPages.currentPage().getParameters().get('isNotCalled5');
        
        if(selectedOwnerId != null && isNotCalled5 != null){
                        List<User> userList = [select name from User where id =: selectedOwnerID limit 1];
            if(userList != null && userList.size() > 0){
                drilledUserName = userList[0].Name;
            }
            setDrillDownLeadsData(isNotCalled5);
        }
        return null;
    }
    
    private void setDrillDownLeadsData(String isNotCalled5){
        String dlQry = getDrillLdQry(isNotCalled5);
            // Initiating the con
            con = new ApexPages.StandardSetController(Database.getQueryLocator(dlQry));
            con.setPageSize(PAGE_SIZE);
            selectDataList();
    }
    
    //method to get the Query for the drilled leads
    private String getDrillLdQry(String isNotCalled5){
        
        String soqlQry = '';
        
        List<Schema.FieldSetMember> fieldSetFields = Schema.SObjectType.Lead.fieldSets.DrilledLeadsFields.getFields();
            List<String> fieldsNameLst = new List<String>();
            for(Schema.FieldSetMember  member : fieldSetFields){
                fieldsNameLst.add(member.getFieldPath());
            }
      soqlQry += 'select '+String.join(fieldsNameLst,',')+' from Lead';
     
        String soqlQry_Where = getSOQLQuery_WhereCondition();
     
        soqlQry_Where += ' AND OwnerId =: selectedOwnerId';
     
      if(isNotCalled5 != 'false'){
                thresholdDateTime = System.now().addMinutes(-responseTimeThreshold);
                soqlQry_Where += ' AND createdDate <: thresholdDateTime';    
      }
                        
                        String dlsortString = ' Order by ' + dlsortField + (dlisAsc ? ' ASC' : ' DESC');
                             
      soqlQry += soqlQry_Where + dlsortString + getSOQLQuery_LimitCondition();
        
     return soqlQry;
    }
    
    //method to populate the drillLeads data drillLeads List
    private void populateDrillLeadsData(){
        
        drillLeads = (List<Lead>)con.getRecords();
    }
    
    /**
    * goBack action to show first page of report
    */
    public void goBack(){
        showDrilledLeads = false;
        retriveLeadReportDataNew();
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
  
  //MSM 90 : Method to get UK and US users based on arguments sent as parameters.. 
   private Set<ID> getUsers(String usr) {
            Set<ID> UserSetID = new Set<ID>();
            String qry = 'select id,Branch_Id__c from User where '; // form query String..
              if(usr == 'US')  // check if US user
               { qry += 'Branch_Id__c like \'1%\' or Branch_Id__c like \'2%\' or Branch_Id__c like \'8%\' or Branch_Id__c like \'9%\'';
               } 
               
               if(usr == 'UK')  // check if UK user
               {  qry += 'Branch_Id__c like \'7%\'';
               } 
         system.debug('------ qry ---------' + qry);      
            for(User u : Database.query(qry))  // set of users id..
             {  UserSetID.add(u.id);
             }
             
            return UserSetID; // return set..
 
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
 
  //wrapper class to show the data
  public class LeadNotCalledCount{
        public Integer totalNotCalled{get;set;}
        public Integer greaterThan5{get;set;}
        public Long longestNoResponse{get;set;}
        public Lead leadOwner{get;set;}
        public Id userId{get;set;}
        public String userName{get;set;}
        
        public LeadNotCalledCount(){
            totalNotCalled = 0;
            greaterThan5 = 0;
            longestNoResponse = 0;
        }
    }   
}