/*************************************************************************
Name   : LeadAssignmentToSalesRep
Usage  : Controller class for LeadAssignmentToSalesRep.page 
Author : Kirtesh jain
Date   : July 14, 2009
Modified By : kirtesh Jain
Modified Date : July 29 ,2009
*************************************************************************/

public class LeadAssignmentToSalesRep {
 
  public integer searchCount{get ;set ;} 
  public integer searchCount_form2{get ;set ;} 
 
  public integer resultspp=10;
  
  public String selectedID {get;set;}
  public String selectedID_form2 {get;set;}
  
  public List<User> results = new List<User>(); 
  public List<User> results_form2 = new List<User>(); 
  
  public List<User> getResults(){
    return results;
  }
  
  public List<User> getResults_form2(){
    return results_form2 ;
  }
 
  public void setResults(List<User> listUser){
    results = listUser;
  }
  
  public void setResults_form2(List<User> listUser){
    results_form2 = listUser;
  }
   
 
  public List<String> subRoleIds { get; set ;}
  
  private Paginator paginator;
  private Paginator paginator_form2;
  
  public  Paginator getPaginator(){
    return paginator;
  }
  
  public  Paginator getPaginator_form2(){
    return paginator_form2 ;
  }
  
  public integer rowlimit{ get; set;}
  //Constructer
  public LeadAssignmentToSalesRep() {
     
     rowlimit =  Limits.getLimitQueryRows();
     this.isAscending = true ;
     this.isAscending_form2 = true ;
     
     this.sortField = 'LastLeadAllocation__c';
     this.sortField_form2 = 'LastLeadAllocation__c'; 
     
     this.previousSortField = this.sortField;
     this.previousSortField_form2 = this.sortField_form2;
     
     doSearchQuery(getQuery( this.sortField ,'ASC'));
     doSearchQuery_form2(getQuery_form2( this.sortField_form2 ,'ASC'));
  }
  
  
  
   
  
  private void doSearchQuery(String queryString){
    results = new List<User>();
    try{
      // Class to paginated results
      System.debug('queryString'+queryString);
      paginator = new Paginator( resultspp, queryString , subRoleIds );
      results =  paginator.getFirstPage();
      System.debug('results'+results);
      searchCount = paginator.totalResults;
    }catch(Exception e){
      searchCount = 0;
      system.debug('Error while searching -->'+e);
    }  
  }
  
  
  private void doSearchQuery_form2(String queryString){
    results_form2 = new List<User>();
    try{
      // Class to paginated results
      System.debug('queryString'+queryString);
      paginator_form2 = new Paginator( resultspp, queryString , subRoleIds );
      results_form2 =  paginator_form2.getFirstPage();
      System.debug('results'+results);
      searchCount_form2 = paginator_form2.totalResults;
    }catch(Exception e){
      searchCount_form2 = 0;
      system.debug('Error while searching -->'+e);
    }  
  }
  
  private String getQuery(string fieldSort, string orderSort){
    String currentUser = UserInfo.getUserId();
    String currentUserRole = UserInfo.getUserRoleId();
    System.debug('currentUserRole'+currentUserRole);
     subRoleIds = getSubordinateRoleIds(currentUserRole);
     System.debug('Kirtesh*******Dquery**********subRoleIds'+subRoleIds);
     string userQuery   = 'Select Name,FirstName, Id, LastName, Extension, UserRole.Id, UserRole.Name ,Available_For_Leads__c,LastLeadAllocation__c from User u Where UserRoleId In : subRoleIds and Available_For_Leads__c = true AND IsActive = true ';
            
     String dynamicQueryString = userQuery+ ' order by ' + fieldSort+'  '+orderSort ;
     
     dynamicQueryString = dynamicQueryString + ' limit ' + ((rowlimit-Limits.getQueryRows() < 0)? 0 : rowlimit-Limits.getQueryRows()) ;
     
     System.debug('Kirtesh*******Dquery**********'+dynamicQueryString);
     return dynamicQueryString;
  }
  
  private String getQuery_form2(string fieldSort, string orderSort){
     string userQuery   = 'Select Name,FirstName, Id, LastName, Extension, UserRole.Id, UserRole.Name ,Available_For_Leads__c,LastLeadAllocation__c from User u Where UserRoleId In : subRoleIds and Available_For_Leads__c = false AND IsActive = true  ';
     String dynamicQueryString = userQuery+ ' order by ' + fieldSort+'  '+orderSort ;
     dynamicQueryString = dynamicQueryString + ' limit ' + ((rowlimit-Limits.getQueryRows() < 0)? 0 : rowlimit-Limits.getQueryRows()) ;
     return dynamicQueryString;
  }
  
  public PageReference sortData(){
    if (previousSortField.equals(sortField)){
       this.isAscending = !isAscending;  
    }else{
       this.isAscending = true;
    }   
    string sortOrder = this.isAscending ? ' ASC ' : ' DESC ';
    previousSortField = sortField;
    System.debug('this.isAscending'+this.isAscending);
    doSearchQuery(getQuery(sortField, sortOrder));
    return null;    
  }
  
  
   public PageReference sortData_form2(){
    if (previousSortField_form2.equals(sortField_form2)){
       this.isAscending_form2 = !isAscending_form2;  
    }else{
       this.isAscending_form2 = true;
    }   
    string sortOrder = this.isAscending_form2 ? ' ASC ' : ' DESC ';
    previousSortField_form2 = sortField_form2;
    System.debug('this.isAscending'+this.isAscending_form2);
    doSearchQuery_form2(getQuery_form2(sortField_form2, sortOrder));
    return null;    
  }
  
  
  // Map for the parent to suboridate roles
  //  ParentRoleId  ->  List < Subordinate Role Ids >
  public Map<String, List<String>> subordinateRoleParentMap {
    get {
       if (subordinateRoleParentMap == null){
           subordinateRoleParentMap = new Map<String, List<String>>();
           for (UserRole eachUserRole: [ Select u.ParentRoleId, u.Id From UserRole u ]) {
               if (eachUserRole.ParentRoleId != null) {
                 
                 // does the parent role already exist in the map
                 if (subordinateRoleParentMap.containsKey(eachUserRole.ParentRoleId) ) {
                    List<String> subordinateRoleList = subordinateRoleParentMap.get(eachUserRole.ParentRoleId);
                    subordinateRoleList.add(eachUserRole.Id);
                    subordinateRoleParentMap.put  (eachUserRole.ParentRoleId, subordinateRoleList);                           
                 } else {
                    // this is the first entry for this parent role
                    List<String> subordinateRoleList = new List<String>();
                    subordinateRoleList.add(eachUserRole.Id);
                    subordinateRoleParentMap.put  (eachUserRole.ParentRoleId, subordinateRoleList);                           
                 }
               }
           }            
       }
      return subordinateRoleParentMap ;
    }
    set;
  }    
  
  public List<String> getSubordinateRoleIds (String currentUserRoleId) {
    List<String> userRoleIds = new List<String>();
    if (subordinateRoleParentMap.containsKey (currentUserRoleId)) {
        List<String> subordinateRoleIdList = subordinateRoleParentMap.get(currentUserRoleId);
         for (String eachUserRoleId: subordinateRoleIdList ) {
             userRoleIds.add(eachUserRoleId);
             List<String> subUserRoleIds = getSubordinateRoleIds(eachUserRoleId);
             for(String eachSubUserId : subUserRoleIds ) {
               userRoleIds.add(eachSubUserId);
             }
         }
    }
    return userRoleIds;
  }
  
  public pageReference updateUsers(){
     if(selectedID != null && selectedID != ''){
         System.debug( 'Kirtesh****************SelectedID' +selectedID);
         
         User subUserObj = [ Select Id ,Name,LastLeadAllocation__c From User Where Id =: selectedID ]; 
         subUserObj.LastLeadAllocation__c = DateTime.Now();
         update subUserObj; 
         
         LeadAssignmentHistory__c history = new LeadAssignmentHistory__c();
         history.AssignedSalesRep__c = subUserObj.Id ;
         history.AssignedBy__c = UserInfo.getUserId() ;
         history.AssignmentTime__c = DateTime.Now() ;
         history.Assignment_Method__c = 'Assign Call to Sales Rep Tab' ;
         history.Lead_Source__c = 'Incoming Call' ;
         insert history ;
                 
         PageReference newPageRef = new PageReference('/apex/LeadAssignmentToSalesRep');
         newPageRef.setRedirect(true);
         return newPageRef ;
     }
     else{
          return null;
     }
     
  }
  
 
 
 ////////////////////////////////////////

    Boolean isAscending;
    Boolean isAscending_form2;
   
    public string sortField{get ;set;}
    public string sortField_form2{get ;set;}
    
    public string previousSortField{get;set;}
    public string previousSortField_form2{get;set;}
    
    public Boolean getIsAsc() {
       return this.isAscending;
    }
    
    public Boolean getIsAsc_form2() {
       return this.isAscending_form2;
    }
     
    public void setIsAsc(Boolean value) {
       this.isAscending = value;
    }
    
    public void setIsAsc_form2(Boolean value) {
       this.isAscending_form2 = value;
    }
     
   public PageReference nextToDoPage(){
    results = paginator.getNextPage();
    return null;
   }
  
  public PageReference nextToDoPage_form2(){
    results_form2 = paginator_form2.getNextPage();
    return null;
  }
  
   public PageReference previousToDoPage(){
    results = paginator.getPreviousPage();    
    return null;
  }  
   
   public PageReference previousToDoPage_form2(){
    results_form2 = paginator_form2.getPreviousPage();    
    return null;
  }  
}