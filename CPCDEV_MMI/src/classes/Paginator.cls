/*************************************************************************
Name    : Paginator
Author  : Kirtesh Jain
Date    : May 19th, 2009
Usage   : An Paginator which return db result page by page

Modified By : kirtesh Jain
Modified Date : July 29 , 2009
*************************************************************************/

public class Paginator{

  private static final Integer DEFAULT_RESULTS_PER_PAGE = 10;
  private final Integer RESULTS_PER_PAGE;
  private final String QUERY;

  private List<List<User>> allResults = new List<List<User>>();
  private List<User> allUsers = new List<User>();
  
  private List<String> subRoleIds{get ;set ;}
  
  public Paginator(Integer ppResults, String queryS , List<String> subroleIds ){
  	//This is used in Dynamic Query ,So we need to Pick it from SubOrdinateUsers Class.
    subRoleIds = subroleIds ;
    isOkey = false;
    RESULTS_PER_PAGE = ppResults > 0 && ppResults <= 100 ? ppResults : DEFAULT_RESULTS_PER_PAGE;
    QUERY = queryS;
    totalResults = 0;

    try{
      for (List<User> recordBatch:Database.query(QUERY))
      {
      	for (User u : recordBatch)
      	  allUsers.add(u);
      	
        allResults.add(recordBatch);
        totalResults = totalResults + recordBatch.size();
      }
      init();
      isOkey = true;
    }catch(exception e){
      isOkey = false;
    }
   
  }
  
  public List<User> getAllUsers() {
    return allUsers;
  }
  
  //method created to use paging with list also
  /*
  public Paginator(Integer ppResults, List<User> lstUser){
    isOkey = false;
    RESULTS_PER_PAGE = ppResults > 0 && ppResults <= 100 ? ppResults : DEFAULT_RESULTS_PER_PAGE;
    totalResults = 0;
    try{
      allResults.add(lstUser);
      totalResults = totalResults + lstUser.size();
      init();
      isOkey = true;
    }catch(exception e){
      isOkey = false;
    }
   
  }
  */
  
  private boolean isOkey;
  public boolean isOkey(){ return isOkey;}
  public integer totalResults {set; get;}
  public Integer currentPage {set; get;}
  public Integer totalPage {set; get;}
  private Integer showingFrom ;
  
  public Integer getShowingFrom(){
    showingFrom = (currentPage  - 1) *  RESULTS_PER_PAGE +1;
    return showingFrom;
  }
  private Integer showingTo;
  
  public Integer getShowingTo(){
    showingTo = currentPage * RESULTS_PER_PAGE ;
    if (totalResults < showingTo){
      showingTo = totalResults;
    }
    return showingTo;
  }
  
  
  
  public List<User> getPage(Integer pageNo){
    User[] selectedResult = new User[RESULTS_PER_PAGE];
    Integer endTo = RESULTS_PER_PAGE * pageNo;
    Integer startFrom = endTo - RESULTS_PER_PAGE;
    Integer currentRecordNo = 0;
    Integer resultIndex = 0;
    Integer recordIndex = -1;
    for (User[] recordBatch:allResults){
      currentRecordNo = currentRecordNo + recordBatch.size();
      if (currentRecordNo >= startFrom ){
        for (User record:recordBatch){
          recordIndex++;
          if (recordIndex >= startFrom && recordIndex <= endTo && resultIndex<RESULTS_PER_PAGE){
            selectedResult[resultIndex] = record ;
            resultIndex++ ;
          }else if (resultIndex == RESULTS_PER_PAGE){
            break;
          }
          
        }
      }else{
        recordIndex += recordBatch.size(); 
        if (resultIndex == RESULTS_PER_PAGE){
          break;
        }
      }
    }
    
    return selectedResult;
  } 
  
  private void init(){
    currentPage = 1;
    totalPage = totalResults / RESULTS_PER_PAGE ;
    if (totalPage*RESULTS_PER_PAGE < totalResults){
      totalPage++;
    }
    isNextPageAvailable = currentPage < totalPage ?  true : false;
    isPreviousPageAvailable = false;
  }
  
  public List<User> getFirstPage(){
    return getPage(1);
  }
  
  public List<User> getLastPage(){
    return getPage(totalPage);
  }
  
  public void updateNavigationStatus(){
    if (totalPage >1){
      isNextPageAvailable = currentPage < totalPage ? true : false;
      isPreviousPageAvailable = currentPage > 1 ? true : false;
    }else{
      isNextPageAvailable = false;
      isPreviousPageAvailable = false;
    }
  }  
  
  public boolean isNextPageAvailable {set; get;}
  public List<User> getNextPage(){
    updateNavigationStatus();
    if (isNextPageAvailable){
      currentPage ++;
    }
    updateNavigationStatus();
    return getPage(currentPage);
  }
  
  public boolean isPreviousPageAvailable {set; get;}
  
  public List<User> getPreviousPage(){
    updateNavigationStatus();
    if (isPreviousPageAvailable){
      currentPage --;
    }
    updateNavigationStatus();
    
    return getPage(currentPage);
  }
  
}