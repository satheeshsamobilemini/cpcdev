/*
Class : JobProfileReportController 
Description :  To view job profiles with open / closed activity counts and open/won/lost opportunity count
Developed by : Bharti(offshore)
Created Date : July 07, 2012
*/
public without sharing class JobProfileReportController {
  public static Integer PAGESIZE = Label.JobProfileReportPageSize != null ? Integer.valueOf(Label.JobProfileReportPageSize) : 10;
  private static final string DEFAULT_SORT_FIELD = 'Name';
  private static final string DEFAULT_SORT_FIELD_SUBCONTRACTOR = 'Project_Valuation_High__c';
  
  //---------------------------------------------------------------------------//
    //Page properties and variables
    //---------------------------------------------------------------------------// 
  public String selectedBranch{get;set;}  
  public List<SelectOption> branchList{get;set;}  
  public String selectedUser {get;set;}
  public List<SelectOption> userList{ get;set;}    
  public List<JobProfileWrapper> jobProfiles {get;set;}  
  public List<JPSubcontractorWrapper> JPSubcontractor {get;set;}
  public List<SelectOption> SellingRegionList{get; set;}   // MSM 73
  public String selectedSellingRegion{get; set;}          // MSM 73
  public List<SelectOption> keySubsList{get; set;}
  public String selectedKeySub{get; set;}
  public List<SelectOption> openActivitiesList{get; set;}
  public String selectedOpenAct{get; set;}
  public string sortField{set;get;}   
  public boolean isAsc{set; get;}
  public string currentChar{get;set;}
  public String sortString {
    get{
        String sortOrder = isAsc ? ' ASC ' : ' DESC ';
        return sortField + sortOrder; 
    }
  }
  public String selectedUserName{get; set;}
  public boolean showsubcontractor{get; set;}
   public String lstSelectedActionStages{get;set;}
  String previousSortField;
  ApexPages.StandardSetController result;
  Decimal keySubValue;
  
  //---------------------------------------------------------------------------//
    //Constructor
    //---------------------------------------------------------------------------//
  
  
  public JobProfileReportController(){
    jobProfiles = new List<JobProfileWrapper>();
    JPSubcontractor = new List<JPSubcontractorWrapper>();
  
    init();    
  }
  
  //Added by Akanksha for Story S-140421
      public String[] selectedActionStages{get;set;}
      private final static String SEARCH_CRITERIA = ' AND ';
    public List<SelectOption> actionStages{
        get{
            if(actionStages == null){
                actionStages = new List<SelectOption>();
                actionStages.add(new SelectOption('All','All'));
                Schema.DescribeFieldResult fieldSchema = Job_Profile__c.Project_Stage_Status__c.getDescribe();
                for(Schema.PicklistEntry picklistEntry : fieldSchema.getPicklistValues()){
                    actionStages.add(new SelectOption(picklistEntry.getValue(),picklistEntry.getLabel()));
                }
            }
            return actionStages;
        }  
        private set;
    }
    
    public String selectedBidDate{get;set;}
    public List<SelectOption> bidDates{
        get{
            if(bidDates == null){
                bidDates = new List<SelectOption>();
                bidDates.add(new SelectOption('','Select'));                
                bidDates.add(new SelectOption('All','All'));
                bidDates.add(new SelectOption('Today and Prior','Today and Prior'));
                bidDates.add(new SelectOption('This Week','This Week'));
                bidDates.add(new SelectOption('This Month','This Month'));
                bidDates.add(new SelectOption('This Quarter','This Quarter'));
            } 
            return bidDates;
        }  
        private set;
    }
     Date bidStartDate, bidEndDate;
     //End by Akanksha for Story S-140421
  //---------------------------------------------------------------------------//
    //page Methods
    //---------------------------------------------------------------------------//
  
  public PageReference search(){
     /*  if(selectedBranch == null){
          ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Please select Branch.');
           ApexPages.addMessage(msg);
      return null;
    } */
    previousSortField = sortField = DEFAULT_SORT_FIELD;
    isAsc = true;
    initSSC();
    showsubcontractor = false;
    return null;   
  }
  
  public PageReference searchContractor(){
  showsubcontractor = true;
   /*  if(selectedBranch == null){
         ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Please select Branch.');
         ApexPages.addMessage(msg);
      return null;
    } */
    previousSortField = sortField = DEFAULT_SORT_FIELD_SUBCONTRACTOR;
    isAsc = false;
    initSSC();
  return null;
  }
  
  //sort list
    public PageReference doSort(){
        
        isAsc = previousSortField.equals(sortField)? !isAsc : true;       
        currentChar = previousSortField.equals(sortField)? currentChar : 'All';           
        if(sortField == 'GC')
        {
            sortSearchResultGC();
        }
        else if(sortField == 'Electrical')
        {
            sortSearchResultElectrical();
        }
        else if(sortField == 'Plumbing')
        {
            sortSearchResultPlumbing();
        } 
        else if(sortField == 'HVAC')
        {
            sortSearchResultHVAC();
        }
         else if(sortField == 'FireSprinkler')
        {
            sortSearchResultFireSprinkler();
        }
         else if(sortField == 'Drywall')
        {
            sortSearchResultDrywall();
        }
        else if(sortField == 'Painting')
        {
            sortSearchResultPainting();
        }
        else if(sortField == 'Landscape')
        {
            sortSearchResultLandscape();
        }
        else
        {
            initSSC();
        }       
        previousSortField = sortField;
        return null;
    }
  
  //do export records as excel
  public PageReference exportToExcel(){
  /*    if(selectedBranch == null){
       ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Please select Branch.');
       ApexPages.addMessage(msg);
      return null;
    } */
 
    if(showsubcontractor != null && showsubcontractor)
    { 
        previousSortField = sortField = DEFAULT_SORT_FIELD_SUBCONTRACTOR;
        isAsc = false;
    }
    else
    {
        previousSortField = sortField = DEFAULT_SORT_FIELD;
        isAsc = true;
    }
    
    
    
    updateCurrentPage(true, buildQuery());
    PageReference pagRef;
    if(showsubcontractor != null && showsubcontractor)
    { 
          pagRef = new Pagereference('/apex/JobProfileSubContractorReportExport');
    }
    else 
    {
         pagRef = new Pagereference('/apex/JobProfileReportExport');
    }
    pagRef.setRedirect(false);
    return pagRef;
  }
  //---------------------------------------------------------------------------//
    //Private helper methods
    //---------------------------------------------------------------------------//
  private void init(){
    currentChar = 'All';
    String [] profiles = new String[]{'Sales Rep - US',
                      'Branch Manager - US',
                      'Regional Manager - US',
                      'Territory Sales Mgr - US'};
    //loading users 
    List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('', 'Select'));   
      for(User usr : [select Id,Name, Branch_Id__c from User 
            where ( Profile.Name IN : profiles) and IsActive = true order by Name]){
      options.add(new SelectOption(usr.id, usr.Name));
    }
    userList = options;
    
    //loading brnaches
        options = new List<SelectOption>();
        options.add(new SelectOption('', 'Select'));        
    Schema.DescribeFieldResult F = User.Branch__c.getDescribe();
    List<Schema.PicklistEntry> P = F.getPicklistValues();    
    for (Schema.PicklistEntry pe : p){
      options.add(new SelectOption(pe.getValue().substring(0,3), pe.getValue().substring(0,3)));
    }
    branchList = options;
    
    //loading Selling Region (MSM - 73)
    options = new List<SelectOption>();
    options.add(new SelectOption('', 'Select'));
    for(Integer i=1; i<= 9; i++){
      options.add(new SelectOption('' + i, '' + i));  
    }
    SellingRegionList = options;
    
    //loading key subs
    options = new List<SelectOption>();
    options.add(new SelectOption('', 'Select'));
    for(Integer i=0; i<= 4; i++){
      options.add(new SelectOption('' + i, '' + i));  
    }
    options.add(new SelectOption('>4', '>4'));
    keySubsList = options;
    
    //loading open activities
    options = new List<SelectOption>();
    options.add(new SelectOption('', 'Select'));
    options.add(new SelectOption('0', '0'));
    openActivitiesList = options;
    
  }
  
  
  private void initSSC(){
    result = new ApexPages.StandardSetController(Database.getquerylocator(buildQuery()));
    result.setPageSize(PAGESIZE);
    updateCurrentPage(false, null);  
  }
    
  private String buildQuery(){
     String soql = 'Select Name, Job_Profile_Name__c,Target_Start_Date__c ,Project_Valuation_High__c,Bid_Date__c,Project_Stage_Status__c,' 
            + 'Branch_ID__c ,Territory__c,General_Contractors__c,Number_of_Key_Sub__c,Selling_Region__c,Sub_Contractors_All__c,OwnerId,Owner.name, Job_Site_City__c,Stage_Flag__c,Value_Quadrant__c, '
            + '(Select Id, IsClosed, IsWon, of_Units__c From Opportunities__r) '
            + 'From Job_Profile__c Where Project_Stage_Status__c NOT IN (\'Completed\', \'Abandoned\')';
     
     if(selectedBranch != null){
       soql += ' and Branch_ID__c = : selectedBranch ';
     }
     
     if(selectedUser != null){
       soql += ' and OwnerId = : selectedUser ';
     }
      //Added by Akanksha for Story S-140421
      
        lstSelectedActionStages = ApexPages.currentPage().getParameters().get('selectedActionStages');
    if (lstSelectedActionStages != null && lstSelectedActionStages != '' && selectedActionStages == null ) {
            lstSelectedActionStages = EncodingUtil.urlDecode(lstSelectedActionStages, 'UTF-8');
                selectedActionStages = lstSelectedActionStages.split(',');
                if(selectedActionStages.size() == 0){
                    selectedActionStages.add('All');
                }
        }
        
         if(selectedActionStages != null && selectedActionStages.size() > 0) {
            Boolean flag = false;
            for(String stage : selectedActionStages){
                if(stage == 'All'){
                    flag = true;break;
                }
            }
            if(!flag){
                soql += soql == '' ? '' : SEARCH_CRITERIA ;
                soql += ' Project_Stage_Status__c IN : selectedActionStages ';
            }
        }
     if(selectedBidDate != null && selectedBidDate != 'All') {
            bidStartDate = bidEndDate = null; 
            if(selectedBidDate ==  'Today and Prior'){
                bidEndDate = System.today();
            }else if(selectedBidDate ==  'This Week'){
                bidStartDate = System.today().toStartOfWeek();
                bidEndDate = bidStartDate.addDays(6);
            }else if(selectedBidDate ==  'This Month'){
                bidStartDate = System.today().toStartOfMonth();
                bidEndDate = bidStartDate.addMonths(1).addDays(-1);
            }else if(selectedBidDate ==  'This Quarter'){                               
                Integer qtr = Math.round((System.today().month()+1.0)/3.0);
                bidStartDate = Date.newInstance(System.today().year(), (qtr - 1)*3 + 1, 1);
                bidEndDate = bidStartDate.addMonths(3).addDays(-1);
            }            
            soql += soql == '' ? '' : SEARCH_CRITERIA;
            soql += bidStartDate != null ? ' (Bid_Date__c >= : bidStartDate and Bid_Date__c <= : bidEndDate )'
                                                : ' (Bid_Date__c <= : bidEndDate )';
     }
     
     /* MSM 73 issue .. */
     if(selectedSellingRegion != null){
       soql += ' and Selling_Region__c = : selectedSellingRegion ';
     }
     
      //End by Akanksha for Story S-140421
     if(selectedKeySub != null){
         if(selectedKeySub != '>4'){
           keySubValue = decimal.valueOf(selectedKeySub);
           soql += ' and Number_of_Key_Sub__c = : keySubValue';  
         }else{
           soql += ' and Number_of_Key_Sub__c >  4.0';
         }
     }
     
     /*if(selectedOpenAct != null){
       soql += ' and Id NOT IN (Select Job_Profile_ID__c From Task Where isClosed = false)';
     }*/
     
     if(currentChar != 'All' && currentChar != ''){
         if(currentChar != 'Other'){
          
             soql = soql +' AND ' + sortField + ' Like \'' + currentChar +'%\' ';
         }else{
             soql = soql +' AND ' + getOtherCondition(sortField);
         }
     }
       
     soql += ' Order by ' + sortString  + 'NULLS LAST limit 10000';
      system.debug('@@@@@'+soql);
     return soql;
    
  }
  
  //for filtering
    private string getOtherCondition(string fld){
      
        String [] l =new  String []{'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'};
        string soql ='';
        for(string s : l){
          
            string s1=' (NOT(' + fld + ' LIKE \'' + s +'%\')) ';
            if(soql=='')
                soql+= s1;
            else
                soql+= ' AND ' + s1;
        }
        return '(' + soql +')';
    }
    
  private void updateCurrentPage(Boolean isExport, String soql){
    jobProfiles = new List<JobProfileWrapper>();
    JPSubcontractor = new List<JPSubcontractorWrapper>();
    
    List<Job_Profile__c> tempList = isExport ? database.query(soql) : (List<Job_Profile__c>)result.getRecords();
    Set<String> jobProfileIds = new Set<String>();
    for(Job_Profile__c jobProfile : tempList){
      jobProfileIds.add(jobProfile.id);
    }
    
    //closed activities
    Map<String,Integer> mapClosedActivityCount = new Map<String,Integer>();
    Map<String,DateTime> mapLastActivityDate = new Map<String,DateTime>();
    /*for(AggregateResult result : [Select Count(Id) cnt,Job_Profile_ID__c From Task Where Job_Profile_ID__c IN :jobProfileIds and isClosed=true Group by Job_Profile_ID__c]){
      mapClosedActivityCount.put((String)result.get('Job_Profile_ID__c'),(Integer)result.get('cnt'));
    }*/
    
    for(Task task : [Select Job_Profile_ID__c, ActivityDate From Task Where Job_Profile_ID__c IN :jobProfileIds and isClosed=true order by Job_Profile_ID__c, ActivityDate desc ]){
      Integer cnt = mapClosedActivityCount.containsKey(task.Job_Profile_ID__c)? mapClosedActivityCount.get(task.Job_Profile_ID__c) : 0 ;
      mapClosedActivityCount.put(task.Job_Profile_ID__c,cnt + 1);
      
      if(!mapLastActivityDate.containsKey(task.Job_Profile_ID__c)){
        mapLastActivityDate.put(task.Job_Profile_ID__c,task.ActivityDate);
      }
    }
    
    //open activities
    Map<String,Integer> mapOpenActivityCount = new Map<String,Integer>();
    for(AggregateResult result : [Select Count(Id) cnt, Job_Profile_ID__c From Task Where Job_Profile_ID__c IN :jobProfileIds and isClosed=false Group by Job_Profile_ID__c]){
      mapOpenActivityCount.put((String)result.get('Job_Profile_ID__c'),(Integer)result.get('cnt'));
    }
    //Added by Akanksha for Story S-127228
    Map<id,List<Sub_Contractor__c>> JPAndSubContactor = new Map<id,List<Sub_Contractor__c>>();
    List<id> AccountId = new List<id>();
    for(Sub_Contractor__c subcon : [select id,Container_Not_Needed__c, Account__c,Account__r.name,Job_Profile__r.id,Account__r.id,Role__c from Sub_Contractor__c where Job_Profile__r.id IN :jobProfileIds])
    {
        if(!JPAndSubContactor.containsKey(subcon.Job_Profile__r.id))
        {
            List<Sub_Contractor__c> sub = new List<Sub_Contractor__c>();
            sub.add(subcon);
            JPAndSubContactor.put(subcon.Job_Profile__r.id ,sub);
        }
        else
        {
            JPAndSubContactor.get(subcon.Job_Profile__r.id).add(subcon);
        }
        AccountId.add(subcon.Account__r.id);
    } 
    Map<String, List<Opportunity>> AccIdAndOpportunity = new Map<String, List<Opportunity>>();
    for(Opportunity opp : [select id,StageName,accountid,Sub_Contractor_Role__c,job_profile__c,isClosed,isWon from opportunity where accountid in :AccountId and job_profile__c in :jobProfileIds])
    {
        String accAndJPId = opp.accountid+''+opp.Job_Profile__c;
        if(!AccIdAndOpportunity.containsKey(accAndJPId))
        {
            List<Opportunity> oppList = new List<Opportunity>();
            oppList.add(opp);
            AccIdAndOpportunity.put(accAndJPId ,oppList);
        }
        else
        {
            AccIdAndOpportunity.get(accAndJPId).add(opp);
        }
    }
    Map<String, List<Task>> AccIdAndTask = new Map<String, List<Task>>();
    for(Task taskdata : [select id,Status,AccountId,Job_Profile_ID__c,IsClosed from Task where accountid in :AccountId and Job_Profile_ID__c in :jobProfileIds])
    {
        String accAndJPId = taskdata.AccountId+''+taskdata.Job_Profile_ID__c;
        if(!AccIdAndTask.containsKey(accAndJPId))
        {
            List<Task> taskList = new List<Task>();
            taskList.add(taskdata);
            AccIdAndTask.put(accAndJPId ,taskList);
        }
        else
        {
            AccIdAndTask.get(accAndJPId).add(taskdata);
        }
    }
    
    //End by Akanksha for Story S-127228
    for(Job_Profile__c jobProfile : tempList){
      if(selectedUser != null && jobProfile.OwnerId == selectedUser)
        selectedUserName = jobProfile.Owner.Name;
 
      jobProfiles.add(new JobProfileWrapper(jobProfile,mapOpenActivityCount.get(jobProfile.Id),mapClosedActivityCount.get(jobProfile.Id), mapLastActivityDate.get(jobProfile.Id)));
      //Added by Akanksha for Story S-127228
      JPSubcontractor.add(new JPSubcontractorWrapper(jobProfile, JPAndSubContactor, AccIdAndOpportunity, AccIdAndTask));
      //End by Akanksha for Story S-127228
    }
  }
  
    //---------------------------------------------------------------------------//
    //Methods/Properties related to page navigation
    //---------------------------------------------------------------------------// 
     public String [] getCharList(){
        String [] l =new  String []{'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','Other', 'All'};
        return l;
    }
    
     public Boolean hasNext {
        get 
        {
            return result.getHasNext();
        }
        set;
    }
    public Boolean hasPrevious {
        get {
            return result.getHasPrevious();
        }
        set; 
    }
    public Integer pageNumber {
        get {
            return result.getPageNumber();
        }
        set;
    }
    
    public Integer totalPage {
        get {
            integer pagecount = result.getResultSize() / result.getPageSize();
            return Math.mod(result.getResultSize(),result.getPageSize()) > 0 ? pagecount + 1 : pagecount;
        }
        set;
    }
    
    public Integer totalResults {
        get {
            return result.getResultSize();
        }
        set;
    }
    
    public Integer showingFrom {
        get {
            return (result.getPageNumber() - 1) * result.getPageSize() + 1;
        }
        set;
    }
    
    public Integer showingTo {
        get {
            
            return pageNumber == totalPage ?  totalResults:  pageNumber * result.getPageSize();
        }
        set;
    }
    
    
    //move to next page
    public PageReference nextPage(){
        result.next();
        updateCurrentPage(false, null);
        return null;
    }
    
    //move to previous page
    public PageReference previousPage(){
          result.previous();
          updateCurrentPage(false, null);
    return null;
    }
    
    //move to next page
    public PageReference firstPage(){
        result.first();
        updateCurrentPage(false, null);
        return null;
    }
    
    //move to next page
    public PageReference lastPage(){
        result.last();
        updateCurrentPage(false, null);
        return null;
    }
    
  //---------------------------------------------------------------------------//
    //JobProfile Wrapper Class
    //Added by Akanksha for Story S-127228
    //---------------------------------------------------------------------------// 
  public class JobProfileWrapper{
    public Job_Profile__c jobProfile {get;set;}    
    public Integer openOpp {get;set;}
    public Integer wonOpp {get;set;}
    public Integer lostOpp {get;set;}
    public Decimal numOfUnits {get;set;}
    public Integer openActivities {get;set;}
    public Integer closedActivities {get;set;}
    public DateTime LastActivityDate {get;set;}
    
    public JobProfileWrapper(Job_Profile__c jobProfile,Integer openActivities,Integer closedActivities, DateTime lastActivityDate){
      this.jobProfile = jobProfile;
      this.openActivities = openActivities != null ? openActivities : 0;
      this.closedActivities = closedActivities != null ? closedActivities : 0;
      this.LastActivityDate = lastActivityDate;
      
      Integer closedOpp = 0;
      openOpp = wonOpp = lostOpp = 0;
      numOfUnits = 0;
      for(Opportunity opp : jobProfile.Opportunities__r){
        if(opp.isClosed){
          if(opp.isWon){
            wonOpp++;
            numOfUnits += opp.of_Units__c != null? opp.of_Units__c : 0;
          }
          closedOpp++;
        }
      }
      
      openOpp = jobProfile.Opportunities__r.size() - closedOpp;
      lostOpp = closedOpp - wonOpp;
    }
    
  }
    //---------------------------------------------------------------------------//
    //JobProfile Wrapper Class
    //---------------------------------------------------------------------------// 
    public class JPSubcontractorWrapper{
    public Job_Profile__c jobProfile {get;set;}    
    public Integer openOpp {get;set;}
    public Integer wonOpp {get;set;}
    public Integer lostOpp {get;set;}
    public SubcontractorWrapper General {get;set;}
    public SubcontractorWrapper Electrical {get;set;}
    public SubcontractorWrapper Plumbing {get;set;}
    public SubcontractorWrapper HVAC {get;set;}
    public SubcontractorWrapper FireSprinkler {get;set;}
    public SubcontractorWrapper Drywall {get;set;}
    public SubcontractorWrapper Painting {get;set;}
    public SubcontractorWrapper Landscape {get;set;}

    //START Case 00050686 - Diana Losey - 7/25/13
    /*public JPSubcontractorWrapper(Job_Profile__c jobProfile,  Map<id,List<Sub_Contractor__c>>JPAndSubContactor, Map<String, List<Opportunity>> AccIdAndOpportunity){
      this.jobProfile = jobProfile;  
      List<Sub_Contractor__c> subcontractors = JPAndSubContactor.get(jobProfile.id);
      Map<id, String> accounts = new Map<id, String>();
      Map<id, String> accountRole = new Map<id, String>();
      if(subcontractors != null && subcontractors.size() > 0)
      {
      for(Sub_Contractor__c subContractor: subcontractors)
      {
            accounts.put(subContractor.account__r.id , subContractor.account__r.name);
            accountRole.put(subContractor.account__r.id , subContractor.Role__c);
      }
      for(id accountId : accounts.keySet())
      {
        String accAndJobId = accountId+''+jobProfile.id;
        List<Opportunity> opportunities = AccIdAndOpportunity.get(accAndJobId);
        if(opportunities != null && opportunities.size() !=0)
        {
            boolean foundWonOpp = false;
            boolean foundOpenOpp = false;
            for(opportunity opportunity : opportunities)
            {
                if(opportunity.IsWon)
                {
                    foundWonOpp = true;
                }
                else if(!opportunity.IsClosed)
                {
                    foundOpenOpp = true;
                }
            }
            String color = '';
            for(opportunity opportunity : opportunities)
            {
                if(foundWonOpp) color = 'blue';
                else if(foundOpenOpp)color = 'green';
                else if(opportunity.IsClosed && !opportunity.IsWon)color = 'red';
                if(opportunity.Sub_Contractor_Role__c == 'General Contractor')
                {
                    General = new SubcontractorWrapper(accounts.get(accountId), color);
                }
                else if(opportunity.Sub_Contractor_Role__c == 'Electrical Contractor')
                {
                     Electrical = new SubcontractorWrapper(accounts.get(accountId), color);
                }
                else if(opportunity.Sub_Contractor_Role__c == 'Plumbing Contractor')
                {
                    Plumbing = new SubcontractorWrapper(accounts.get(accountId), color);
                }
                else if(opportunity.Sub_Contractor_Role__c == 'HVAC Contractor')
                {
                    HVAC = new SubcontractorWrapper(accounts.get(accountId), color);
                }
                else if(opportunity.Sub_Contractor_Role__c == 'Fire Sprinkler Contractor')
                {
                    FireSprinkler = new SubcontractorWrapper(accounts.get(accountId), color);
                }
                else if(opportunity.Sub_Contractor_Role__c == 'Drywall Contractor')
                {
                    Drywall = new SubcontractorWrapper(accounts.get(accountId), color);
                }
                else if(opportunity.Sub_Contractor_Role__c == 'Painting')
                {
                    Painting = new SubcontractorWrapper(accounts.get(accountId), color);
                }
                else if(opportunity.Sub_Contractor_Role__c == 'Landscape Contractor')
                {
                    Landscape = new SubcontractorWrapper(accounts.get(accountId), color);
                }
            }
      }
      else
      {
                String color ='yellow';
                String rolename = accountRole.get(accountId);
                if(rolename == 'General Contractor')
                {
                    General = new SubcontractorWrapper(accounts.get(accountId), color);
                }
                else if(rolename == 'Electrical Contractor')
                {
                     Electrical = new SubcontractorWrapper(accounts.get(accountId), color);
                }
                else if(rolename == 'Plumbing Contractor')
                {
                    Plumbing = new SubcontractorWrapper(accounts.get(accountId), color);
                }
                else if(rolename == 'HVAC Contractor')
                {
                    HVAC = new SubcontractorWrapper(accounts.get(accountId), color);
                }
                else if(rolename == 'Fire Sprinkler Contractor')
                {
                    FireSprinkler = new SubcontractorWrapper(accounts.get(accountId), color);
                }
                else if(rolename == 'Drywall Contractor')
                {
                    Drywall = new SubcontractorWrapper(accounts.get(accountId), color);
                }
                else if(rolename == 'Painting')
                {
                    Painting = new SubcontractorWrapper(accounts.get(accountId), color);
                }
                else if(rolename == 'Landscape Contractor')
                {
                    Landscape = new SubcontractorWrapper(accounts.get(accountId), color);
                }
      }
      }
    }
  }
  }*/
  
  public JPSubcontractorWrapper(Job_Profile__c jobProfile,  Map<id,List<Sub_Contractor__c>>JPAndSubContactor, Map<String, List<Opportunity>> AccIdAndOpportunity, Map<String, List<Task>> AccIdAndTask){
  this.jobProfile = jobProfile;  
  List<Sub_Contractor__c> subcontractors = JPAndSubContactor.get(jobProfile.id); //gets list of subs for this job profile only

  if(subcontractors != null && subcontractors.size() > 0)  {
    for(Sub_Contractor__c subContractor: subcontractors) {
      String color = ''; //default if we have no opp
      //now overide the color if there is an opp for this account/role combo
      String accAndJobId = subContractor.account__r.id+''+jobProfile.id;
      List<Opportunity> opportunities = AccIdAndOpportunity.get(accAndJobId);//gets list of opps for this account only
      List<Task> tasks = AccIdAndTask.get(accAndJobId);
      //Added by Akanksha 
        boolean foundOpenTask = false;
        boolean foundCompleteTask = false;
        if(tasks != null && tasks.size() !=0)
        {
            for(Task taskData : tasks)
            {
                if(!foundOpenTask)foundOpenTask = !(taskData.IsClosed);
                if(!foundCompleteTask)foundCompleteTask = taskData.IsClosed; 
            }
        }
      //End by Akanksha
        boolean foundWonOpp = false;
        boolean foundOpenOpp = false;
        boolean foundLostOpp = false;
      if(opportunities != null && opportunities.size() !=0) {
  
        for(opportunity opportunity : opportunities) {
          if (opportunity.Sub_Contractor_Role__c  == subContractor.Role__c) {

            if(opportunity.IsWon) {
              foundWonOpp = true;
            } else if(!opportunity.IsClosed) {
              foundOpenOpp = true;
            }
            if((!opportunity.IsWon) && opportunity.IsClosed)
            {
                foundLostOpp = true;
            }
           
          }
        }
        }          
        
            system.debug('@@subContractor.Container_Not_Needed__c'+subContractor.Container_Not_Needed__c);
            if((opportunities == null || opportunities.size() ==0) && foundOpenTask && foundCompleteTask)
            {
                system.debug('@@@color '+color );           
                color = 'yellow';
            }
            else if(foundLostOpp || subContractor.Container_Not_Needed__c != null)
            {
                color = 'red';
            }
            else if(foundWonOpp)color = 'blue';
            else if(foundOpenOpp)color = 'green';
      if(subContractor.Role__c == 'General Contractor') {
        General = new SubcontractorWrapper(subContractor.account__r.name, color);
      } else if(subContractor.Role__c == 'Electrical Contractor') {
        Electrical = new SubcontractorWrapper(subContractor.account__r.name, color);
      } else if(subContractor.Role__c == 'Plumbing Contractor')  {
        Plumbing = new SubcontractorWrapper(subContractor.account__r.name, color);
      } else if(subContractor.Role__c == 'HVAC Contractor') {
        HVAC = new SubcontractorWrapper(subContractor.account__r.name, color);
      } else if(subContractor.Role__c == 'Fire Sprinkler Contractor') {
        FireSprinkler = new SubcontractorWrapper(subContractor.account__r.name, color);
      } else if(subContractor.Role__c == 'Drywall Contractor') {
        Drywall = new SubcontractorWrapper(subContractor.account__r.name, color);
      } else if(subContractor.Role__c == 'Painting') {
        Painting = new SubcontractorWrapper(subContractor.account__r.name, color);
      } else if(subContractor.Role__c == 'Landscape Contractor') {
        Landscape = new SubcontractorWrapper(subContractor.account__r.name, color);
      }
    }
  }
}
} 
//END Case 00050686 - Diana Losey 7/25/13  
  
   public class SubcontractorWrapper{
     public String Name {get;set;}
     public String ColorCode {get;set;}
     
     public SubcontractorWrapper(String name, String Color){
        this.Name = name;
        this.ColorCode = Color;
    }
   }
   
   public PageReference back()
   {
        showsubcontractor = false;
        previousSortField = sortField = DEFAULT_SORT_FIELD;
        isAsc = true;
        init();
        return null;
   }
   //Start for GC
   public void sortSearchResultGC(){
        if(JPSubcontractor.size() ==0 )return;
        
        for(Integer index =0 ;index<JPSubcontractor.size();index++){
        for(Integer nextIndex = index+1; nextIndex < JPSubcontractor.size();nextIndex++){
        if(isAsc){
        if((JPSubcontractor[index].General != null && JPSubcontractor[nextIndex].General != null) && JPSubcontractor[index].General.name > JPSubcontractor[nextIndex].General.name){
        JPSubcontractorWrapper tmp = JPSubcontractor[index];
        JPSubcontractor.set(index,JPSubcontractor[nextIndex]);
        JPSubcontractor.set(nextIndex,tmp);
        }
        }else{
        if((JPSubcontractor[index].General != null && JPSubcontractor[nextIndex].General != null) && JPSubcontractor[index].General.name < JPSubcontractor[nextIndex].General.name){
        JPSubcontractorWrapper tmp = JPSubcontractor[index];
        JPSubcontractor.set(index,JPSubcontractor[nextIndex]);
        JPSubcontractor.set(nextIndex,tmp);
        }
       } 
     }
     }
     }
     //End for GC
     //Start for Electrical
     public void sortSearchResultElectrical(){
        if(JPSubcontractor.size() ==0 )return;
        
        for(Integer index =0 ;index<JPSubcontractor.size();index++){
        for(Integer nextIndex = index+1; nextIndex < JPSubcontractor.size();nextIndex++){
        if(isAsc){
        if((JPSubcontractor[index].Electrical != null && JPSubcontractor[nextIndex].Electrical != null) && JPSubcontractor[index].Electrical.name > JPSubcontractor[nextIndex].Electrical.name){
        JPSubcontractorWrapper tmp = JPSubcontractor[index];
        JPSubcontractor.set(index,JPSubcontractor[nextIndex]);
        JPSubcontractor.set(nextIndex,tmp);
        }
        }else{
        if((JPSubcontractor[index].Electrical != null && JPSubcontractor[nextIndex].Electrical!= null) && JPSubcontractor[index].Electrical.name < JPSubcontractor[nextIndex].Electrical.name){
        JPSubcontractorWrapper tmp = JPSubcontractor[index];
        JPSubcontractor.set(index,JPSubcontractor[nextIndex]);
        JPSubcontractor.set(nextIndex,tmp);
        }
       } 
     }
     }
     }
     //End for Electrical
    //Start for Plumbing
     public void sortSearchResultPlumbing(){
        if(JPSubcontractor.size() ==0 )return;
        
        for(Integer index =0 ;index<JPSubcontractor.size();index++){
        for(Integer nextIndex = index+1; nextIndex < JPSubcontractor.size();nextIndex++){
        if(isAsc){
        if((JPSubcontractor[index].Plumbing != null && JPSubcontractor[nextIndex].Plumbing != null) && JPSubcontractor[index].Plumbing.name > JPSubcontractor[nextIndex].Plumbing.name){
        JPSubcontractorWrapper tmp = JPSubcontractor[index];
        JPSubcontractor.set(index,JPSubcontractor[nextIndex]);
        JPSubcontractor.set(nextIndex,tmp);
        }
        }else{
        if((JPSubcontractor[index].Plumbing != null && JPSubcontractor[nextIndex].Plumbing != null) && JPSubcontractor[index].Plumbing.name < JPSubcontractor[nextIndex].Plumbing.name){
        JPSubcontractorWrapper tmp = JPSubcontractor[index];
        JPSubcontractor.set(index,JPSubcontractor[nextIndex]);
        JPSubcontractor.set(nextIndex,tmp);
        }
       } 
     }
     }
     }
     //End for Plumbing 
     //Start for HVAC
     public void sortSearchResultHVAC(){
        if(JPSubcontractor.size() ==0 )return;
        
        for(Integer index =0 ;index<JPSubcontractor.size();index++){
        for(Integer nextIndex = index+1; nextIndex < JPSubcontractor.size();nextIndex++){
        if(isAsc){
        if((JPSubcontractor[index].HVAC != null && JPSubcontractor[nextIndex].HVAC != null) && JPSubcontractor[index].HVAC.name > JPSubcontractor[nextIndex].HVAC.name){
        JPSubcontractorWrapper tmp = JPSubcontractor[index];
        JPSubcontractor.set(index,JPSubcontractor[nextIndex]);
        JPSubcontractor.set(nextIndex,tmp);
        }
        }else{
        if((JPSubcontractor[index].HVAC != null && JPSubcontractor[nextIndex].HVAC != null) && JPSubcontractor[index].HVAC.name < JPSubcontractor[nextIndex].HVAC.name){
        JPSubcontractorWrapper tmp = JPSubcontractor[index];
        JPSubcontractor.set(index,JPSubcontractor[nextIndex]);
        JPSubcontractor.set(nextIndex,tmp);
        }
       } 
     }
     }
     }
     //End for HVAC  
     //Start for FireSprinkler 
     public void sortSearchResultFireSprinkler(){
        if(JPSubcontractor.size() ==0 )return;
        
        for(Integer index =0 ;index<JPSubcontractor.size();index++){
        for(Integer nextIndex = index+1; nextIndex < JPSubcontractor.size();nextIndex++){
        if(isAsc){
        if((JPSubcontractor[index].FireSprinkler != null && JPSubcontractor[nextIndex].FireSprinkler != null) && JPSubcontractor[index].FireSprinkler.name > JPSubcontractor[nextIndex].FireSprinkler.name){
        JPSubcontractorWrapper tmp = JPSubcontractor[index];
        JPSubcontractor.set(index,JPSubcontractor[nextIndex]);
        JPSubcontractor.set(nextIndex,tmp);
        }
        }else{
        if((JPSubcontractor[index].FireSprinkler != null && JPSubcontractor[nextIndex].FireSprinkler != null) && JPSubcontractor[index].FireSprinkler.name < JPSubcontractor[nextIndex].FireSprinkler.name){
        JPSubcontractorWrapper tmp = JPSubcontractor[index];
        JPSubcontractor.set(index,JPSubcontractor[nextIndex]);
        JPSubcontractor.set(nextIndex,tmp);
        }
       } 
     }
     }
     }
     //End for FireSprinkler 
     
     //Start for Drywall
     public void sortSearchResultDrywall(){
        if(JPSubcontractor.size() ==0 )return;
        
        for(Integer index =0 ;index<JPSubcontractor.size();index++){
        for(Integer nextIndex = index+1; nextIndex < JPSubcontractor.size();nextIndex++){
        if(isAsc){
        if((JPSubcontractor[index].Drywall != null && JPSubcontractor[nextIndex].Drywall != null) && JPSubcontractor[index].Drywall.name > JPSubcontractor[nextIndex].Drywall.name){
        JPSubcontractorWrapper tmp = JPSubcontractor[index];
        JPSubcontractor.set(index,JPSubcontractor[nextIndex]);
        JPSubcontractor.set(nextIndex,tmp);
        }
        }else{
        if((JPSubcontractor[index].Drywall != null && JPSubcontractor[nextIndex].Drywall != null) && JPSubcontractor[index].Drywall.name < JPSubcontractor[nextIndex].Drywall.name){
        JPSubcontractorWrapper tmp = JPSubcontractor[index];
        JPSubcontractor.set(index,JPSubcontractor[nextIndex]);
        JPSubcontractor.set(nextIndex,tmp);
        }
       } 
     }
     }
     }
     //End for Drywall
     //Start for Painting 
     public void sortSearchResultPainting(){
        if(JPSubcontractor.size() ==0 )return;
        
        for(Integer index =0 ;index<JPSubcontractor.size();index++){
        for(Integer nextIndex = index+1; nextIndex < JPSubcontractor.size();nextIndex++){
        if(isAsc){
        if((JPSubcontractor[index].Painting != null && JPSubcontractor[nextIndex].Painting != null) && JPSubcontractor[index].Painting.name > JPSubcontractor[nextIndex].Painting.name){
        JPSubcontractorWrapper tmp = JPSubcontractor[index];
        JPSubcontractor.set(index,JPSubcontractor[nextIndex]);
        JPSubcontractor.set(nextIndex,tmp);
        }
        }else{
        if((JPSubcontractor[index].Painting != null && JPSubcontractor[nextIndex].Painting != null) && JPSubcontractor[index].Painting.name < JPSubcontractor[nextIndex].Painting.name){
        JPSubcontractorWrapper tmp = JPSubcontractor[index];
        JPSubcontractor.set(index,JPSubcontractor[nextIndex]);
        JPSubcontractor.set(nextIndex,tmp);
        }
       } 
     }
     }
     }
     //End for Painting 
     //Start for Landscape
     public void sortSearchResultLandscape(){
        if(JPSubcontractor.size() ==0 )return;
        
        for(Integer index =0 ;index<JPSubcontractor.size();index++){
        for(Integer nextIndex = index+1; nextIndex < JPSubcontractor.size();nextIndex++){
        if(isAsc){
        if((JPSubcontractor[index].Landscape != null && JPSubcontractor[nextIndex].Landscape != null) && JPSubcontractor[index].Landscape.name > JPSubcontractor[nextIndex].Landscape.name){
        JPSubcontractorWrapper tmp = JPSubcontractor[index];
        JPSubcontractor.set(index,JPSubcontractor[nextIndex]);
        JPSubcontractor.set(nextIndex,tmp);
        }
        }else{
        if((JPSubcontractor[index].Landscape != null && JPSubcontractor[nextIndex].Landscape != null) && JPSubcontractor[index].Landscape.name < JPSubcontractor[nextIndex].Landscape.name){
        JPSubcontractorWrapper tmp = JPSubcontractor[index];
        JPSubcontractor.set(index,JPSubcontractor[nextIndex]);
        JPSubcontractor.set(nextIndex,tmp);
        }
       } 
     }
     }
     }
     //End for Landscape
   //End by Akanksha for Story S-127228
}