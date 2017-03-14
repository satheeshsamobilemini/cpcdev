/********************************************************************************************
Name   : DodgeManagementController
Usage  : Controller class of DodgeManagementView VF page.
Author : Vipin Gupta
Date   : Mar 26, 2010

Modified By : Megha Agarwal(Appirio Offshore)
Modified Date : May 27, 2010
purpose : Add A-Z Header functionality (PR-04845)

Modified By     : Alka Taneja(Appirio Offshore)
Modified Date   : 10 May, 2013 
purpose         : Save filters during the search of DodgeManagementView page
Story           : S-116139

Modified by : Akanksha Bhatia
Case : 00051606
********************************************************************************************/
public class DodgeManagementController {
    private final static String SEARCH_CRITERIA = ' AND ';
    //Query String 
    public static String caseQry = 'Select d.Id, d.Project_Name__c, d.Target_Start_Date__c, d.Address_1__c, ' +
                                    'd.Address_2__c, d.Project_Valuation_String__c, d.Project_Valuation_Low__c, Notes__c, ' +
                                    'd.Project_Valuation_High__c, d.City__c, d.State__c, d.GC_Awarded__c, d.County__c, d.Action_Stage__c, ' +
                                    'd.Type_Of_Work__c, d.Name, d.Branch_ID__c, d.Territory__c,d.Bid_Date__c, d.Request_Status__c, d.Zip__c, d.Value_Quadrant__c, d.Country__c ' +
                                    'From Dodge_Project__c d where d.Job_Profile_Status__c not in (\'Removed\', \'Created\') ';
    public User currUser { get; set; }
    
    public String sortOn { get; set; }
    public String sortOrder { get; set; }
   
    public String currProjId { get; set; }  
    public ApexPages.StandardSetController prLst { get; set; } 
    public List<Dodge_Project__c> tempProjList { get; set; }
    public String selectedChar{get;set;}
    
    public List<Dodge_Project__c> projList { 
            get{
                    tempProjList = (List<Dodge_Project__c>) prLst.getRecords();
                    return tempProjList;
            } 
            set;
    }
    
    //When no records are found
    public boolean renderLabel { get; set; }
    public boolean renderTable { get; set; }    
    public boolean isTest { get; set; }
    //Added by Akanksha for story S-140427  
    public boolean renderRemove { get; set; }
    //End by Akanksha for story S-140427  
    //Selected branch to search on
    public String selectedbranch  { get; set; }
    public String lstSelectedActionStages{get;set;}
    public String pageNumbertemp{get;set;}
    public String[] selectedActionStages{get;set;}
    public List<SelectOption> actionStages{
        get{
            if(actionStages == null){
                actionStages = new List<SelectOption>();
                actionStages.add(new SelectOption('All','All'));
                Schema.DescribeFieldResult fieldSchema = Dodge_Project__c.Action_Stage__c.getDescribe();
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
    public DodgeManagementController(){
        isTest = false;
        sortOrder = 'ASC';
        selectedbranch = ApexPages.currentPage().getParameters().get('selectedBranch');
        selectedBidDate = ApexPages.currentPage().getParameters().get('selectedDate');
        lstSelectedActionStages = ApexPages.currentPage().getParameters().get('selectedActionStages');
        pageNumbertemp = ApexPages.currentPage().getParameters().get('pageNumber');
        // To maintain the sort order after remove the record (S-116139)
        sortOrder = (ApexPages.currentPage().getParameters().get('sortOrder')!= null)  ? ApexPages.currentPage().getParameters().get('sortOrder') : 'ASC';
        sortOn = (ApexPages.currentPage().getParameters().get('sortOn')!= null ) ? ApexPages.currentPage().getParameters().get('sortOn') : 'GC_Awarded__c DESC, Target_Start_Date__c';
        
        // S-116139 (Get the Selected Action Stages from the Parameter)
        if (lstSelectedActionStages != null && lstSelectedActionStages != '' && selectedActionStages == null ) {
            lstSelectedActionStages = EncodingUtil.urlDecode(lstSelectedActionStages, 'UTF-8');
                selectedActionStages = lstSelectedActionStages.split(',');
                if(selectedActionStages.size() == 0){
                    selectedActionStages.add('All');
                }
        }
        
        String query = '';
        if(selectedbranch != null && selectedbranch != '') {
           query = makeQuery();
            // To maintain the sort order after remove the record (S-116139)
            if(sortOn != null && sortOn != '' && sortOrder != null && sortOrder != '') {
                query += ' order by ' + sortOn + ' ' + sortOrder;
            }
            performSearch(query);
        } else {
            currUser = [Select Id, Branch_Id__c from User where ID = : UserInfo.getUserId()];
            prLst = new ApexPages.StandardSetController(new List<Dodge_Project__c> ());
            prLst.setPageSize(20);
               
            renderLabel = true;
            renderTable = false;
            if(currUser.Branch_Id__c != null){
                selectedbranch = currUser.Branch_Id__c;
                performSearch(makeQuery());
            }
        }
                
        if(selectedBidDate == null || selectedBidDate == '') {
            selectedBidDate = 'All';
        }
        
        selectedChar = 'All';
        if(pageNumbertemp != null && pageNumbertemp != '')
            prLst.setPageNumber(Integer.ValueOf(pageNumbertemp));  
            
    //Added by Akanksha for story S-140427  
         checkUserProfile();
         //End By Akanksha for story S-140427 
    }
    
     //Added by Akanksha for story S-140427  
    public void checkUserProfile()
    {
        List<String> profileName = new List<String>();
        profileName.add('System Administrator');
        profileName.add('Branch Manager - UK');
        profileName.add('Branch Manager - US');
        profileName.add('Regional Manager - UK');
        profileName.add('Regional Manager - US');
        profileName.add('Sales Rep - US'); // Sales Restructuring 2015
        renderRemove = false;
        for(Profile p:[select id,name from Profile where name in:profileName])
        {
            if(p.id == UserInfo.getProfileId())
            {
                renderRemove = true;
            }
            
        }
        
        
        // MSM -9 added user roles
        List<String> RoleName = new List<String>();
        RoleName.add('National Sales Center VP - US');
        RoleName.add('Outbound Sales Manager');
        RoleName.add('Business Development Supervisor (OB) T1');
        RoleName.add('Business Development Supervisor (OB) T2');
        RoleName.add('Business Development Supervisor (OB) T3');
        RoleName.add('Inside Sales/Outside Sales Manager Region 1');
        RoleName.add('Inside Sales/Outside Sales Manager Region 2');
        RoleName.add('Inside Sales/Outside Sales Manager Region 3');
        RoleName.add('Inside Sales/Outside Sales Manager Region 4');
        RoleName.add('Inside Sales/Outside Sales Manager Region 5');
        RoleName.add('Inside Sales/Outside Sales Manager Region 6');
        RoleName.add('Inside Sales/Outside Sales Manager Region 7');
        RoleName.add('Inside Sales/Outside Sales Manager Region 8');

        
        for(UserRole r:[SELECT Id, Name FROM UserRole where name in:RoleName])
        {
            if(r.id == UserInfo.getUserRoleId())
            {
                renderRemove = true;
            }
            
        }
        
    }
     //End By Akanksha for story S-140427 

    public PageReference doSearch() {       
        String qry = makeQuery() + ' order by GC_Awarded__c DESC, Target_Start_Date__c ASC limit 10000';
        performSearch(qry);
        ApexPages.currentPage().getParameters().put('selectedBranch',selectedbranch);
        selectedChar = 'All';
        return null;
    }
    
    // perform the actual search on the query passed. 
    private void performSearch(String qry) {        
        System.debug('Query recieved for searching [' + qry + ']');
        try {
            
            prLst = new ApexPages.StandardSetController(Database.getQueryLocator(qry));
            prLst.setPageSize(20);
            
        } catch (Exception e ) {
            System.debug(e.getMessage());
        }
        if(projList != null && projList.size() > 0 ) {           
            renderLabel = false;
            renderTable = true;
        } else {
            renderLabel = true;
            renderTable = false;
        } 
    }

    // Used to prepare the query that would be used to fetch records.
    private String makeQuery() {
        String query = caseQry ;
        String whereClause = '';
        if(selectedbranch != null && selectedbranch.length() > 0) {
            whereClause += ' d.Branch_ID__c = \'' + selectedbranch + '\'';
        }else{
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Please select Branch.');
            ApexPages.addMessage(msg);
            return null;
        } 
        
        if(selectedActionStages != null && selectedActionStages.size() > 0) {
            Boolean flag = false;
            for(String stage : selectedActionStages){
                if(stage == 'All'){
                    flag = true;break;
                }
            }
            if(!flag){
                whereClause += whereClause == '' ? '' : SEARCH_CRITERIA ;
                whereClause += ' d.Action_Stage__c IN : selectedActionStages ';
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
            whereClause += whereClause == '' ? '' : SEARCH_CRITERIA;
            whereClause += bidStartDate != null ? ' (d.Bid_Date__c >= : bidStartDate and d.Bid_Date__c <= : bidEndDate )'
                                                : ' (d.Bid_Date__c <= : bidEndDate )';
        }
        
        if(whereClause != ''){
            query += 'and (' + whereClause + ')';
        }
        
        system.debug('===============' +  query);
        system.debug('===============' +  bidStartDate + '======' + bidEndDate);
        
        return query; 
    }
    
    //to be used when sorting on a given column is to be done.
    public void performSortedSearch(){
        System.debug('sortOn -- [' + sortOn + '] :: sortOrder - [' + sortOrder + ']'); 
        String qry = makeQuery();
        if(sortOn != null && sortOrder == 'ASC') {
            sortOrder = 'DESC';
        } else  if(sortOn != null && sortOrder == 'DESC') {
            sortOrder = 'ASC';
        }
        qry += ' order by ' + sortOn + ' ' + sortOrder;
        performSearch(qry);
        selectedChar = 'All';
    }
   
    // Fetch the list of all the branches
    public List<SelectOption> getBranchList() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('', 'Select'));
        
        /*
        
        // this does not work - too many queries in Production
        
        List <Dodge_Project__c> aLst;
        if(isTest) {
            aLst = [Select Id, Branch_Id__c from Dodge_Project__c order by Branch_Id__c limit 10];
        } else {
            aLst = [Select Id, Branch_Id__c from Dodge_Project__c order by Branch_Id__c];
        }
        Set<String> idSet = new Set<String>();
        for(Dodge_Project__c a : aLst){
            if(a.Branch_Id__c != null){
                if(!idSet.contains(a.Branch_Id__c) ) {
                    idSet.add(a.Branch_Id__c);
                    options.add(new SelectOption(a.Branch_Id__c, a.Branch_Id__c));
                }
            }
        }
        
        */
        
        Schema.DescribeFieldResult F = User.Branch__c.getDescribe();
        List<Schema.PicklistEntry> P = F.getPicklistValues();
        
        for (Schema.PicklistEntry pe : p){
            // Dont include any branch starting with a '7' since the UK does not use Dodge
            if (pe.getValue().substring(0,1) != '7'){
                options.add(new SelectOption(pe.getValue().substring(0,3), pe.getValue().substring(0,3)));
            }
        }        
        
        return options;
    }
    
    public PageReference openCreateLinkURL(){
        Dodge_Project__c proj;
        for( Dodge_Project__c pr : tempProjList){
            if(pr.Id == currProjId) {
                proj = pr;
            }
        }
        Date targetStartDate = proj.Target_Start_Date__c;
        String targetStartDateStr = '';
        if(targetStartDate != null){
            targetStartDateStr = targetStartDate.format();
        }
        String retUrl = ApexPages.currentPage().getUrl();
        if(retUrl != null){
            retUrl = retUrl.substring(0, retUrl.indexOf('?'));
        }
        String url = '/a0S/e?Name=' + 
                            checkNullAndEncode(proj.Project_Name__c) +
                            '&CF00NS0000000YqKf_lkid=' +
                            checkNullAndEncode(proj.Id) +
                            '&CF00NS0000000YqKf=' +
                            checkNullAndEncode(proj.Project_Name__c) + 
                            '&00NS0000000hufA=' +
                            checkNullAndEncode(targetStartDateStr) + 
                            '&00NS0000000YqIV=' +
                            checkNullAndEncode(proj.Address_1__c) + ' ' + checkNullAndEncode(proj.Address_2__c) +
                            '&00NS0000000YqUL=' + 
                            checkNullAndEncode(proj.City__c) + 
                            '&00NS0000000YqUQ=' +
                            checkNullAndEncode(proj.State__c) + 
                            '&00NS0000000YqUV=' +
                            checkNullAndEncode(proj.Zip__c) + 
                            '&00NS0000000YqUa=' + 
                            checkNullAndEncode(proj.County__c) + 
                            '&00NS0000000i6ls=' +
                            checkNullAndEncode(proj.Action_Stage__c) + 
                            '&00NS0000000i6ln=Dodge&00NS0000000i6lx=' +
                            checkNullAndEncode(proj.Project_Valuation_String__c) +
                            '&00NS0000000YqUW=' +
                            checkNullAndEncode(proj.Country__c) +
                            '&retURL=' +
                            checkNullAndEncode(retUrl)+
                            '&pageNumber='+prLst.getPageNumber();
            PageReference page = new PageReference(url);
            page.setRedirect(true);
            return page;                            
    }
    
    public PageReference openCreateLinkURLTemp(){
        Dodge_Project__c proj;
        for( Dodge_Project__c pr : tempProjList){
            if(pr.Id == currProjId) {
                proj = pr;
            }
        }
        System.Debug('In Dodge Management >>>>>>');
        Date targetStartDate = proj.Target_Start_Date__c;
        Date bidDate = proj.Bid_Date__c;
        String targetStartDateStr = '';
        String bidDateStr = '';
        if(targetStartDate != null){
            targetStartDateStr = targetStartDate.format();
        }
        if(bidDate != NULL){
            bidDateStr = bidDate.format();
        }
        System.Debug('In Dodge Management >>>>>> 1');
        String url = '/apex/NewJobProfile?name=' + 
                            checkNullAndEncode(proj.Project_Name__c) +
                            '&dodgeProjectId=' +
                            checkNullAndEncode(proj.Id) +
                            '&dodgeProject='+
                            checkNullAndEncode(proj.Name) +
                            '&dodgeProjectName=' +
                            checkNullAndEncode(proj.Project_Name__c) + 
                            '&TargetSD=' +
                            checkNullAndEncode(targetStartDateStr) + 
                            '&BidDate=' +
                            checkNullAndEncode(bidDateStr) + 
                            '&JSAddress=' +
                            checkNullAndEncode(proj.Address_1__c) + ' ' + checkNullAndEncode(proj.Address_2__c) +
                            '&JSCity=' + 
                            checkNullAndEncode(proj.City__c) + 
                            '&JSState=' +
                            checkNullAndEncode(proj.State__c) + 
                            '&JSZip=' +
                            checkNullAndEncode(proj.Zip__c) + 
                            '&JSCounty=' + 
                            checkNullAndEncode(proj.County__c) + 
                            '&projectStatus=' +
                            checkNullAndEncode(proj.Action_Stage__c) + 
                            '&ReferralSource=Dodge&ValuationHigh=' +
                            checkNullAndEncode(String.ValueOf(proj.Project_Valuation_High__c)) +
                            '&ValuationLow=' +
                            checkNullAndEncode(String.ValueOf(proj.Project_Valuation_Low__c)) +
                            '&JSCountry=' +
                            checkNullAndEncode(proj.Country__c) +
                            '&retURL=' +
                            checkNullAndEncode(proj.Id) +
                            '&selectedBranch='+selectedbranch +
                            '&pageNumber='+prLst.getPageNumber();
        PageReference page = new PageReference(url);
        System.Debug('In Dodge Management >>>>>> 2');
        page.setRedirect(true);
        return page;                            
    }
    public PageReference openRemoveLinkURL(){
     String projectID = Apexpages.currentPage().getParameters().get('firstParam1');
     String selectionActionStageP = '';
     
      if(selectedActionStages.size() == 1){
          selectionActionStageP = selectedActionStages.get(0);
       }else if(selectedActionStages.size() > 1) { 
          selectionActionStageP = String.join(selectedActionStages,',');
       }
          
     String url = '/apex/RemoveDodgeManagement?id='+projectID+
                  '&pageNumber='+prLst.getPageNumber()+
                  '&selectedBranch='+selectedbranch+
                  '&selectedDate='+selectedBidDate+
                  '&selectedActionStages='+selectionActionStageP+
                  '&sortOn='+EncodingUtil.urlDecode(sortOn,'UTF-8')+
                  '&sortOrder='+sortOrder;
     PageReference pgRef = new PageReference(url);
     pgRef.setRedirect(true);
     return pgRef;     
    }
    private String checkNullAndEncode(String strToCheck) {
        if(strToCheck != null) {
            return EncodingUtil.urlEncode(strToCheck, 'UTF-8');
        }
        return '';
    }
    
    public String[] getHeaderChars(){
        String[] headerStr = new String[]{'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','Other','All'};
        return headerStr;
    }
    
     //to be used when clicking on any charactor of A-Z header (PR-04845) 
   public void performHeaderSearch(){
        String query = makeQuery();
        if(selectedChar != 'ALL' && selectedChar != 'Other' && selectedChar !=''){
            query +=' AND Project_Name__c Like \'' + selectedChar +'%\' ';
        }else if(selectedChar=='Other'){
            query += 'AND '+getOtherCondition();
        }
        performSearch(query);
   }
   
   private String getOtherCondition(){
     String [] charArray =new  String []{'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'};
        string qry ='';
        for(string chr : charArray)
        {
            string str=' (NOT(Project_Name__c LIKE \''+ chr +'%\')) ';
            if(qry=='')
                qry+= str;
            else
                qry+= ' AND ' + str;
        }
        return '(' + qry +')';
   }
    //Added by Akanksha for case  00051606
 
         public Boolean hasNext {
        get 
        {
            return prLst.getHasNext();
        }
        set;
    }
    public Boolean hasPrevious {
        get {
            return prLst.getHasPrevious();
        }
        set; 
    }
    public Integer pageNumber {
        get {
            return prLst.getPageNumber();
        }
        set;
    }
    
    public Integer totalPage {
        get {
            integer pagecount = prLst.getResultSize() / prLst.getPageSize();
            return Math.mod(prLst.getResultSize(),prLst.getPageSize()) > 0 ? pagecount + 1 : pagecount;
        }
        set;
    }
    
    public Integer totalResults {
        get {
            return prLst.getResultSize();
        }
        set;
    }
    
    public Integer showingFrom {
        get {
            return (prLst.getPageNumber() - 1) * prLst.getPageSize() + 1;
        }
        set;
    }
    
    public Integer showingTo {
        get {
            
            return pageNumber == totalPage ?  totalResults:  pageNumber * prLst.getPageSize();
        }
        set;
    }
      //move to next page
    public PageReference nextPage(){
        prLst.next();
        //updateCurrentPage(false, null);
        return null;
    }
    
    //move to previous page
    public PageReference previousPage(){
          prLst.previous();
          //updateCurrentPage(false, null);
    return null;
    }
    
    //move to next page
    public PageReference firstPage(){
        prLst.first();
        //updateCurrentPage(false, null);
        return null;
    }
    
    //move to next page
    public PageReference lastPage(){
        prLst.last();
        //updateCurrentPage(false, null);
        return null;
    }
    
    //End by Akanksha  for case  00051606
}