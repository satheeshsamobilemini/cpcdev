/**************************************************************************
Name:  FulfillingBranchService_AC()
Copyright © 2013  MMI
----------------------------------------------------------------------
Purpose:
This class contains the methods for fulfiling branch Service HTTP Rest 
web service Callouts 
-----------------------------------------------------------------------
History:

VERSION  AUTHOR                 DATE        DETAIL              
1.0  -  TEKsystems             11/2/2013   INITIAL DEVELOPMENT  
**************************************************************************/
public with sharing class FulfillingBranchService_AC implements IBranchService{
	
    public String branchesResponse {get;set;}
    
    /*********************************************************************
    Purpose     : To get the list of branches from fulfiling branch service
    Parameters  : none
    Returns     : List of HomeBaseBeans.branches
    **********************************************************************/
    public List<HomeBaseBeans.branches> listBranches(){
		system.debug(LoggingLevel.DEBUG,'Entering FulfillingBranchService_AC:listBranches:');
    	ServiceProxy servicePro =null;
    	List<HomeBaseBeans.branches> HBList =null;
    	BranchAddresses allBranches ;
    	try{	
            servicePro = new ServiceProxy();
			if(!Test.isRunningTest()){
			    branchesResponse = servicePro.callRestService('rest/api/v1/companies/1/branches','GET','');
			}
			if(!branchesResponse.contains('"errorCode"'))
			{
				allBranches = (BranchAddresses)JSON.deserialize(branchesResponse, BranchAddresses.class);
			}
			else
			{
				HBList = new List<HomeBaseBeans.branches>();
				HomeBaseBeans.branches h = new HomeBaseBeans.branches();
				String errorMessage = QuickQuoteErrorHandler.handleError(branchesResponse);				
				h.errorMessage = errorMessage;				
				HBList.add(h);
	        }
		}
		catch(Exception e)
		{
			String errorMessage = 'Internal Server Error';
			HBList = new List<HomeBaseBeans.branches>();
			HomeBaseBeans.branches h = new HomeBaseBeans.branches();
			h.errorMessage = errorMessage;
			HBList.add(h);
			return HBList;
		}
		if(HBList!=null && !HBList.isEmpty()){
	    	system.debug(LoggingLevel.DEBUG,'Exiting FulfillingBranchService_AC:listBranches:'+HBList);
	        return HBList;
	    }else{
	    	system.debug(LoggingLevel.DEBUG,'Exiting FulfillingBranchService_AC:listBranches:'+allBranches.branches);
	    	return allBranches.branches;
	    }
    }
    
    /*********************************************************************
    Purpose     : This is inner class to initializing and holding after 
                  JSON parsing
    Parameters  : none
    Returns     : none
    **********************************************************************/
    public class BranchAddresses
    {
        public HomeBaseBeans.branches[] branches;
        public BranchAddresses()
        {
                branches = new List<HomeBaseBeans.branches>();
        }
    }
    
}