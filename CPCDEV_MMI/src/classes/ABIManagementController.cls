/********************************************************************************************
Name   : ABIManagementController
Created Date : August 11,2010
Created By : Megha Agarwal
purpose : Controller class of ABIManagementView VF page.

********************************************************************************************/
public class ABIManagementController {
	//Delare a string
	public static String abiQuery = 'Select a.Value__c,a.Name,a.Pttitle__c, a.Ptsite4__c, a.Ptsite3__c, a.Ptsite2__c,'
	                                +'a.Ptsite1__c,a.Stage__c, a.Ptno__c,a.Job_Profile_Status__c,a.Devtype__c,a.Ptpcode__c,a.Id, a.GC_Awarded__c From ABI_Project__c a where a.Job_Profile_Status__c not in (\'Removed\', \'Created\')';
	    
    public String selectedbranch{get;set;}
    public ApexPages.StandardSetController abiStdSetCntrl { get; set; }
    
    public String sortOn { get; set; }
    public String sortOrder { get; set; }
    public String selectedChar{get;set;}
    public String currentABIProjId { get; set; }
    public List<SelectOption> branches{get;set;}
    
    public List<ABI_Project__c> abiProjects{
		get{
			if(abiStdSetCntrl != null){
				return (List<ABI_Project__c>) abiStdSetCntrl.getRecords();
			}else{
				return new List<ABI_Project__c>();
			}
		}
		set; 
	}        
	                       
    public ABIManagementController(){
   		selectedbranch = ApexPages.currentPage().getParameters().get('selectedBranch');
   		sortOrder = 'ASC';  
   		if(selectedbranch != null && selectedbranch != '') {
            performSearch(makeQuery());
        } else {
        	User currUser;
        	for(User usr :[Select Id, Branch_Id__c from User where ID = : UserInfo.getUserId() limit 1]){
            	currUser = usr;
        	}
            abiStdSetCntrl = new ApexPages.StandardSetController(new List<ABI_Project__c>());
            abiStdSetCntrl.setPageSize(20);   
            if(currUser.Branch_Id__c != null && currUser.Branch_Id__c.substring(0,1) == '7'){
               selectedbranch = currUser.Branch_Id__c;
               performSearch(makeQuery());
            }
        }
        branches = loadBranches();
        selectedChar= 'All';
   }
   	
   public String[] getHeaderChars(){
    	String[] headerStr = new String[]{'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','Other','All'};
    	return headerStr;
   }
   
   public List<SelectOption> loadBranches(){
       List<SelectOption> BranchOptions = new List<SelectOption>();
       BranchOptions.add(new SelectOption('', 'Select'));
       Schema.DescribeFieldResult userBranches = User.Branch__c.getDescribe();
	   List<Schema.PicklistEntry> userBranchValues = userBranches.getPicklistValues();
	   for(Schema.PicklistEntry userBranchValue : userBranchValues){
	   	 if(userBranchValue.getValue().substring(0,1) == '7'){
				BranchOptions.add(new SelectOption(userBranchValue.getValue().substring(0,3), userBranchValue.getValue().substring(0,3)));
		 }
	   }
	   return BranchOptions;  
   }
   
   public PageReference doSearch() {       
        String qry = makeQuery() + ' order by GC_Awarded__c DESC';
        performSearch(qry);
        ApexPages.currentPage().getParameters().put('selectedBranch',selectedbranch);
        selectedChar = 'All';
        return null;
   }
   
   public void doSortedSearch(){
   	    System.debug('--Megha -debug --'+sortOn+'--'+sortOrder); 
        String query = makeQuery();
        query += ' order by ' + sortOn + ' ' + sortOrder;
        performSearch(query);
        if(sortOn != null && sortOrder == 'ASC') {
            sortOrder = 'DESC';
        } else  if(sortOn != null && sortOrder == 'DESC') {
            sortOrder = 'ASC';
        }
        selectedChar = 'All';
   }
   
   public void doHeaderSearch(){
  		String query = makeQuery();
  		if(selectedChar != 'ALL' && selectedChar != 'Other' && selectedChar !=''){
  			query +=' AND pttitle__c Like \'' + selectedChar +'%\' ';
        }else if(selectedChar=='Other'){
        	query += 'AND '+getOtherCondition();
        }
        performSearch(query);
   }
   
   public PageReference openCreateLinkURL(){
        System.debug('-----Megha -debug -1--');
        ABI_Project__c proj;
        for(ABI_Project__c abiPr : abiProjects){
            if(abiPr.Id == currentABIProjId) {
                proj = abiPr;
                break;
            }
        }
        System.debug('-----Megha -debug -2--');
        /*Date targetStartDate = proj.Target_Start_Date__c;
        Date bidDate = proj.Bid_Date__c;
        String targetStartDateStr = '';
        String bidDateStr = '';
        if(targetStartDate != null){
            targetStartDateStr = targetStartDate.format();
        }
        if(bidDate != NULL){
        	bidDateStr = bidDate.format();
        }*/ 
        System.Debug('----ABI before URL 1');
        String url = '/apex/NewJobProfile?name=' + 
                            checkNullAndEncode(proj.ptTitle__c) +
                            '&abiProjectId=' +
                            checkNullAndEncode(proj.Id) +
                            '&abiProject='+
                            checkNullAndEncode(proj.Name) +
                            '&abiProjectName=' +
                            checkNullAndEncode(proj.ptTitle__c) + 
                            '&JSAddressLine1=' +
                            checkNullAndEncode(proj.Ptsite1__c) + 
                            '&JSAddressLine2=' + 
                            checkNullAndEncode(proj.Ptsite2__c) + 
                            '&JSAddressLine3=' +
                            checkNullAndEncode(proj.Ptsite3__c) +
                            '&JSAddressLine4=' +
                            checkNullAndEncode(proj.Ptsite4__c) + 
                            '&JSPostal=' +
                            checkNullAndEncode(proj.Ptpcode__c) + 
                            '&JSABICountry=UK'+
                            '&projectStatus=' +
                            checkNullAndEncode(proj.Stage__c) + 
                            '&ReferralSource=ABI&ValuationHigh=' +
                            checkNullAndEncode(String.ValueOf(proj.Value__c)) +
                            '&ValuationLow=' +
                            checkNullAndEncode(String.ValueOf(proj.Value__c)) +
                            '&selectedBranch='+selectedbranch;
        PageReference page = new PageReference(url);
        System.Debug('=======In ABI ======'+url);
        page.setRedirect(true);
        return page;                            
    }
   private void performSearch(String qry) {        
      try {
        System.debug('---Megha-debug query---' + qry);
        abiStdSetCntrl = new ApexPages.StandardSetController(Database.getQueryLocator(qry));
        abiStdSetCntrl.setPageSize(20);
      } catch (Exception e ) {
        System.debug(e.getMessage());
     }
        
   }
   
   private String makeQuery() {
        boolean flag = false;
        String query = '';
        if(selectedbranch != null && selectedbranch.length() > 0) {
            query += abiQuery + ' and a.Branch_ID__c = \'' + selectedbranch + '\'';
        } 
        return query;
   }  
   
   
   private String getOtherCondition(){
   	 String [] charArray =new  String []{'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'};
        string qry ='';
        for(string chr : charArray)
        {
            string str=' (NOT(pttitle__c LIKE \''+ chr +'%\')) ';
            if(qry=='')
                qry+= str;
            else
                qry+= ' AND ' + str;
        }
        return '(' + qry +')';
   }  
   
   private String checkNullAndEncode(String strToCheck) {
        if(strToCheck != null) {
            return EncodingUtil.urlEncode(strToCheck, 'UTF-8');
        }
        return '';
   }
                                 

}
