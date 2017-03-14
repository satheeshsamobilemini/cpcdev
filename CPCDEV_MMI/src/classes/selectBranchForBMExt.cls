/*****************************************************************************
 * Name             : selectBranchForBMExt 
 * Created By       : Hemant(Appirio Offshore)
 * Purpose          : Controller for VF page "selectBranchForBM" 
*****************************************************************************/
public class selectBranchForBMExt {
				
		static final String USERROLE_BRANCH_MANAGER = 'Branch Manager';
		
		public Account acc{get;set;}
		public List<SelectOption> branchList{get;set;}
		public String selectedBranch{get;set;}
		
    public selectBranchForBMExt(ApexPages.StandardController controller) {
    	acc = (Account)controller.getRecord();
			//load the Branch options
    	branchList = getBranchOptions();
    }
    
    
    
    //loading branches
    private List<SelectOption> getBranchOptions(){
    	List<SelectOption> options = new List<SelectOption>();
    	User currentUser;
    	for(User usr : [Select UserRole.Name,Branch_Id__c,Name From User Where Id = : UserInfo.getUserId()]){
    		currentUser = usr;
    	}
    	
    	if(currentUser != null && currentUser.UserRoleId != null && currentUser.UserRole.Name.contains(USERROLE_BRANCH_MANAGER)){

    			//to find the find the Branch for BM to select the alternative branch while cloning a account record.
    			Map<String, BranchMgrWithMultipleBranches__c> mulipleBrnchForBMMap = new Map<String, BranchMgrWithMultipleBranches__c>(BranchMgrWithMultipleBranches__c.getAll());
    		
    			if(mulipleBrnchForBMMap.containsKey(currentUser.Name)){
    				String branches = mulipleBrnchForBMMap.get(currentUser.Name).Branches_for_BM__c;
    				if(branches != null && branches != ''){
    					for(String br : branches.split(',')){
    						options.add(new SelectOption(br,br));
    					}		
    				}
	    		}
  		}
  		return options;
    }
    
    //method to clone the account record and redirect to new cloned acc
    public PageReference redirect(){
    	system.debug('----------'+selectedBranch);
    	Id clonedAccId = AccountCloner.createClone(acc.Id, selectedBranch);
    	PageReference pg = new PageReference('/'+clonedAccId+'/e?retURL=%2F'+clonedAccId);
    	pg.setRedirect(true);
    	return pg;
    	//return null;
    	
    }
}