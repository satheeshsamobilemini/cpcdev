/*************************************************************************
Name          : SubordinateUsersRoles 
Usage         : Controller class for SubordinateUsers Page.
Created By    : Kirtesh Jain
Created Date  : May 19, 2009
*************************************************************************/

public class SubordinateUsersRoles {
  public integer searchCount{get ;set ;}
  
  public integer resultspp = 10;
  
  public List<User> results = new List<User>(); 
  
  public List<User> getResults(){
    return results;
  }
  
  public void setResults(List<User> listUser){
    results = listUser;
  }
  
 
  public List<String> subRoleIds { get; set ;}
  public String currentUserRoleName;
  
  private Paginator paginator;
  
  public  Paginator getPaginator(){
    return paginator;
  }
  
  //Constructer
  public SubordinateUsersRoles() {
  	 this.isAscending = true ;
  	 this.sortField = 'Name';
  	 this.previousSortField = this.sortField;
  	 for(User usr : [select id , Name , UserRole.Name from User where id = : userInfo.getUserId()]){
		currentUserRoleName = usr.UserRole.Name;	  	 	
  	 }
     doSearchQuery(getQuery( this.sortField ,'ASC'));
  }
  
  public SubordinateUsersRoles(Integer resultsPerPage) {
  	 this.resultspp=resultsPerPage;
  	 this.isAscending = true ;
  	 this.sortField = 'Name';
  	 this.previousSortField = this.sortField;
     doSearchQuery(getQuery( this.sortField ,'ASC'));
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
  
  private String getQuery(string fieldSort, string orderSort){
    String currentUser = UserInfo.getUserId();
    String currentUserRole = UserInfo.getUserRoleId();
    System.debug('currentUserRole'+currentUserRole);
    loadSubordinateRoleIds(currentUserRole);
    
    System.debug('Kirtesh*******Dquery**********subRoleIds'+subRoleIds);
    
    string userQuery   = 'Select Name,FirstName, Id, LastName, UserRole.Id, UserRole.Name ,Available_For_Leads__c from User u Where isActive = true and UserRoleId In : subRoleIds ';
            
    String dynamicQueryString = userQuery+ ' order by ' + fieldSort+'  '+orderSort ;
     
    System.debug('Kirtesh*******Dquery**********'+dynamicQueryString);
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
  
  private void loadSubordinateRoleIds(Id currentUserRoleId){
  	    if(currentUserRoleName != null){
  	    	subRoleIds = new List<String>();
  			List<Manage_Sales_Rep_Settings__c> manageSalesRepSettings = [select Name, Key__c , Role_Name__c from Manage_Sales_Rep_Settings__c where Role_Name__c = : currentUserRoleName];
  			if(manageSalesRepSettings.size() > 0){
  				String filterCriteria = manageSalesRepSettings.get(0).key__c+'%';
  				
  				for(UserRole usrRole : [select id from UserRole where Name like : filterCriteria ]){
 					subRoleIds.addAll(getSubordinateRoleIds(usrRole.Id)); 					
  				}
  			}else{
  				subRoleIds = getSubordinateRoleIds(currentUserRoleId);
  			}
  	    }else if(currentUserRoleId != null){
  	    	subRoleIds = getSubordinateRoleIds(currentUserRoleId);
  	    } 
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
    System.debug(':::::::userRoleIds::::::::'+userRoleIds);
    return userRoleIds;
  }
  
  public pageReference updateUsers(){
    /*
    List<String> lstSelectedIDs = new List<string>();
    List<String> lstUnselectedIDs = new List<String>();
    
    if(selectedID != '' ){
     lstSelectedIDs = selectedID.split(';');
    }
    if( unselectedID != ''){
     lstUnselectedIDs = unselectedID.split(';');
    } 
    System.debug( 'Kirtesh****************lstSelectedIDs' +lstSelectedIDs);
    System.debug( 'Kirtesh****************lstunSelectedIDs' +lstunSelectedIDs);
     
    string queryUserstoUpdate  = 'Select Id , Available_For_Leads__c From User Where ';
    
    if( lstSelectedIDs.size() > 0 && lstUnSelectedIDs.size() > 0 ){
    
     queryUserstoUpdate = queryUserstoUpdate+ 'Id IN : lstSelectedIDs OR Id IN  : lstUnselectedIDs' ;
    
    }else if (lstSelectedIDs.size() > 0){
    
      queryUserstoUpdate = queryUserstoUpdate+ 'Id IN : lstSelectedIDs' ;
    
    }else if(lstUnSelectedIDs.size() > 0 ){
      queryUserstoUpdate = queryUserstoUpdate+ 'Id IN : lstUnSelectedIDs' ;
    }
    
    List<User> dbUsers = Database.query(queryUserstoUpdate);
    Map<Id , User> mapUsertoUpdate = New Map<Id,User>(dbUsers);
    
      
    System.debug(    'Kirtesh*************mapUsertoUpdate'    +  mapUsertoUpdate  );
   
   if(lstSelectedIDs.size() > 0){
    for( Id userId : mapUsertoUpdate.keySet() ){
        for( string selectedId : lstSelectedIDs ){
              
           if( userId == selectedId){
              User instantuser = mapUsertoUpdate.get(userId);
              System.debug('Kirtesh**********instantuser'+instantuser );
              instantuser.Available_For_Leads__c = true ;
              System.debug('Kirtesh**********instantuser'+instantuser.Available_For_Leads__c );
              mapUsertoUpdate.put( userId , instantuser) ;
           }
        
        }
     }
   }
   
   if(lstunSelectedIDs.size() > 0) {                               
     for( Id  userId : mapUsertoUpdate.keySet() ){
         
         for( string unselectedId : lstunSelectedIDs ){
          
          if(userId == unselectedId){
              User instantuser = mapUsertoUpdate.get(userId);
              instantuser.Available_For_Leads__c = false ;
              mapUsertoUpdate.put(userId , instantuser) ;
           }
        
        }
      }
   }
     
     System.debug(    'Kirtesh*******After*************mapUsertoUpdate'    +  mapUsertoUpdate  );
     List<User> listUsertoUpdate = new List<User>();
      
     for(string  userId : mapUsertoUpdate.keySet() ){
       User user = mapUsertoUpdate.get(userId);
       listUsertoUpdate.add(user) ;
     }
      
     System.debug( 'Kirtesh*************************listUsertoUpdate'+listUsertoUpdate);
    
     if( listUsertoUpdate.size()> 0 ){
       update listUsertoUpdate ;
     }
     */
     
     update paginator.getAllUsers();
     ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.INFO, 'Users have been updated.'));
     
     /*
     Integer currentPage = paginator.currentPage;
     String sortOrder = this.isAscending ? ' ASC ' : ' DESC ';
     doSearchQuery(getQuery(sortField, sortOrder));
     paginator.currentPage = currentPage - 1;
     results = paginator.getNextPage();
     
     PageReference newPageRef = new PageReference('/apex/SubordinateUsers');
     newPageRef.setRedirect(true);
     return newPageRef;
     */
     
     return null;
  }
  
 ////////////////////////////////////////

    Boolean isAscending;
   
    public string sortField{get ;set;}
    public string previousSortField{get;set;}
    
    public Boolean getIsAsc() {
       return this.isAscending;
    }
     
    public void setIsAsc(Boolean value) {
       this.isAscending = value;
    }
     
   public PageReference nextToDoPage(){
    results = paginator.getNextPage();
    return null;
  }
   
   public PageReference previousToDoPage(){
    results = paginator.getPreviousPage();    
    return null;
  }  

}