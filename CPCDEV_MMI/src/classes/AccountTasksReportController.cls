/*************************************************************************
Name          : AccountTasksReportController
Usage         : Controller class for "Accounts without a Scheduled Callback" Report.
Created By    : Parth Tamhaney
Created Date  : July 15, 2009

Modified By : Kirtesh Jain
Modified Date : July 29,2009

Modified By		: Alka Taneja
Modified Date	: 26 Aug, 2013
Story					: S-133219
Description		: Prevention from SOQL injection into the generateQuery() method
*************************************************************************/

public class AccountTasksReportController {

  private integer rowlimit;
  private integer pageSize;
  public integer totalPage{get ;set;}
  public String branchId{get; set;}
  public String message{get; set;}
  public List<Account> accountList{get; set;}
  public integer index{get; set;}
  public integer recordCount{get; set;}
  public integer startIndex{get; set;}
  public integer endIndex{get; set;}
    
  //Holds all Accounts
  public List<List<Account>> accounts= new List<List<Account>>();
  //Holds One page of data
  private List<Account> lstAcc=new List<Account>();
  private String userId;
  private String userRoleId;
  private UserRole userRole ;
  private boolean isSalesRep ;

  private String csvRoleids;
  Boolean isAscending;
   
  public string sortField{get ;set;}
  public string previousSortField{get;set;}
    
  //Constructor
  public AccountTasksReportController(){
    
    rowlimit = Limits.getLimitQueryRows() ;
    pageSize = 200;
    sortField = 'Account.Name';
    previousSortField = sortField ;
    this.isAscending = true;
    refreshData();
  }
 
 //Constructor for Testing purpose
 /*
  public AccountTasksReportController(integer testLimit,integer testPagesize){
    //rowlimit = testLimit;
    rowlimit =  Limits.getLimitQueryRows();
    pageSize = testPagesize;
    sortField = 'Account.Name';
    previousSortField = sortField ;
    this.isAscending = true;
    refreshData();
  }
  */
  
  public Boolean getIsAsc() {
     return this.isAscending;
  }
     

  public PageReference sortData(){
    if (previousSortField.equals(sortField)){
       this.isAscending = !isAscending;  
    }else{
       this.isAscending = true;
    }   
    
    previousSortField = sortField;
    System.debug('this.isAscending'+this.isAscending);
    
    refreshData();
    return null;    
  }  
  
  private void refreshData(){
    userId= System.Userinfo.getUserId();
    userRoleId = System.Userinfo.getUserRoleId();
    if(rowlimit-Limits.getQueryRows() <= 0 )
     return ;
     
    UserRole userRole = [Select Name, Id From UserRole where Id = :userRoleId Limit 1 ];
    if(userRole.Name.contains('Sales Rep')== true ){
        isSalesRep = true;
    }
    else{
        isSalesRep = false;
        csvRoleids = '\'' + userRoleId + '\'';
        
        Set<Id> parentIds = new Set<Id>();
        parentIds.add(userRoleId);
        List<UserRole> lstChildRoles = new List<UserRole>([Select id from UserRole where ParentRoleId in :parentIds  Limit :((rowlimit-Limits.getQueryRows() < 0)? 0 : rowlimit-Limits.getQueryRows())]);
        while(lstChildRoles.size() > 0){
            parentIds = new Set<Id>();
            for(UserRole role : lstChildRoles ){
                csvRoleids = csvRoleids + ',\'' + role.id + '\'';
                parentIds.add(role.id);
            }
            lstChildRoles = new List<UserRole>([Select id from UserRole where ParentRoleId in :parentIds Limit :((rowlimit-Limits.getQueryRows() < 0)? 0 : rowlimit-Limits.getQueryRows())]);
            
        }
    }
    index = 0;
    fillAccountsList();
    accountList = accounts.get(index);
  }
  
  
    
  
  
  
  
  //Generate Query        
  private String generateQuery(){
    
    System.debug('Parth*******rowlimit= '+ rowlimit);
    
    
    String query = 'Select Id, Type, Result_Id__c, Owner.Name, OwnerId, Name, LastActivityDate, Branch__c From Account  where (Number_of_Open_Tasks__c=0 or Number_of_Open_Tasks__c=null) and IsDeleted=false and Owner.Name<>\'Branch Account\' and Type <> \'Competitor\' and Type <> \'Partner\' ' ;
    
    if(branchId <> null && branchId <> ''){
    	
    	// Added for Story S-133219 
    	branchId = String.escapeSingleQuotes(branchId);
    	
      query = query + ' and Branch__c =\'' + branchId + '\' ' ;
    }
    
    if(isSalesRep == true){
    	
    	// Added for Story S-133219 
    	userId = String.escapeSingleQuotes(userId);
    	
      query = query + ' and OwnerId = \'' + userId + '\' ' ;
    }
    else if(csvRoleids != ''){
        query = query + ' and Owner.UserRoleId in (' + csvRoleids + ') ' ;
    }
    
    string sortOrder = this.isAscending ? ' ASC ' : ' DESC ';
    query = query +  ' Order by ' + sortField + ' ' + sortOrder;
    
    query = query + ' limit ' + ((rowlimit-Limits.getQueryRows() < 0)? 0 : rowlimit-Limits.getQueryRows()) ;

    return query;
  }
  
  
  
  private void fillAccountsList(){
    accounts= new List<List<Account>>();
    lstAcc=new List<Account>();
    accounts.add(lstAcc);
    
    // Added try catch only for Story S-133219 
    try {
    	
	   	System.debug('Parth*******rowlimit= '+ rowlimit);
	    String query = generateQuery(); 
	    System.debug('Query*********************'+ query);
	    
	    recordCount = 0;
	    startIndex = 0;
	    endIndex = 0;
	    
	    for(List<Account> accBatch : Database.query(query)){
	      addAccounts(accBatch);        
	      System.debug('Parth*******lstAcc= '+ lstAcc.size());
	    }
	    
	    if(accounts.get(accounts.size()-1).size() > 0){
	        totalPage  = accounts.size() ; 
	    }
	    else{
	        totalPage  = accounts.size() - 1;
	    }
	    updateNavigationStatus(); 
    	
    } catch( Exception e) {
    	ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, e.getMessage()));
    }
  } 
  
  private void addAccounts(List<Account> accBatch){
    for(Account acc : accBatch){
      lstAcc.add(acc);
       recordCount++;
       if(lstAcc.size() == pageSize ){
          lstAcc = new List<Account>();
          accounts.add(lstAcc);
         }  
      /*List<OpenActivity> opAct = acc.OpenActivities;
      
      if(opAct.size() == 0){
        lstAcc.add(acc);
        recordCount++;
        
        if(lstAcc.size() == pageSize ){
          lstAcc = new List<Account>();
          accounts.add(lstAcc);
         }  
      }*/
    } 
  } 
  
  public boolean  isNextPageAvailable{get ;set ;}
  public boolean  isPreviousPageAvailable{get ;set ;}
  
  public Pagereference applyBranchFilter(){
     sortField = 'Account.Name';
    previousSortField = sortField ;
    this.isAscending = true;
    refreshData();
    return null;
  }
  
  public Pagereference getNextAccounts(){
    if(index < accounts.size()-1){
      index = index + 1 ;
    }
    accountList = accounts.get(index);
    updateNavigationStatus();
    return null;
  }
  
  public Pagereference getPrevAccounts(){
    if(index > 0){
      index = index - 1 ;
    }
    accountList = accounts.get(index);
    updateNavigationStatus();
    return null;
  }
  
  public void updateNavigationStatus(){
    if (totalPage >1){
      isNextPageAvailable = index+1 < totalPage ? true : false;
      isPreviousPageAvailable = index > 0 ? true : false;
    }else{
      isNextPageAvailable = false;
      isPreviousPageAvailable = false;
    }
    startIndex = (index * pageSize) + 1;
    endIndex = startIndex + pageSize - 1;
    if(endIndex > recordCount){
        endIndex = recordCount ;
    }
  }  

     
}