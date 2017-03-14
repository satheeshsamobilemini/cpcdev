/**************************************************************************
Name:  StateService_AC()
Copyright © 2013  MMI
----------------------------------------------------------------------
Purpose:
This class contains the methods for State Service HTTP Rest 
web service Callouts 
-----------------------------------------------------------------------
History:

VERSION  AUTHOR                 DATE        DETAIL              
1.0  -  TEKsystems             11/2/2013   INITIAL DEVELOPMENT  
**************************************************************************/
public with sharing class StateService_AC implements IStateService {
	
    public String branchesResponse {get;set;}
    /*********************************************************************
    Purpose     : To get the list of states from state service
    Parameters  : none
    Returns     : List of HomeBaseBeans.States
    **********************************************************************/
    public List<HomeBaseBeans.States> listStates(String countryCode){
    	system.debug(LoggingLevel.DEBUG,'Entering StateService_AC:listStates:'+countryCode);
    	/*ServiceProxy servicePro =null;
    	List<HomeBaseBeans.States> HBList=null;
    	stateListClass allStates;
    	try{
    		if(countryCode!=null){	
		        servicePro = new ServiceProxy(); 
		        if(!Test.isRunningTest()){
				    branchesResponse = servicePro.callRestService('rest/api/v1/companies/1/countries/'+countryCode+'/states','GET','');
		        }
				
				if(!branchesResponse.contains('"errorCode"'))
				{
					allStates = (stateListClass)JSON.deserialize(branchesResponse, stateListClass.class);
				}
				else
				{
					HBList = new List<HomeBaseBeans.States>();
					HomeBaseBeans.States h = new HomeBaseBeans.States();
					String errorMessage = QuickQuoteErrorHandler.handleError(branchesResponse);				
					h.errorMessage = errorMessage;
					HBList.add(h);
				}
    		}
		}catch(Exception e){
			String errorMessage = e.getMessage();
			HBList = new List<HomeBaseBeans.States>();
			HomeBaseBeans.States h = new HomeBaseBeans.States();
			h.errorMessage = errorMessage;
			HBList.add(h);
			return HBList;
		}
		if(HBList!=null && !HBList.isEmpty()){
	    	system.debug(LoggingLevel.DEBUG,'Exiting StateService_AC:listStates:'+HBList);
	        return HBList;
	    }else{
	    	system.debug(LoggingLevel.DEBUG,'Exiting StateService_AC:listStates:'+allStates.states);
	    	return allStates.states;
	    }*/
	    
	    if(countryCode == 'CAN' || countryCode == 'Canada'){
	    	countryCode = 'CA';
	    }
	    if(countryCode == 'USA'){
	    	countryCode = 'US';
	    }
	    list<HomeBaseBeans.States> HBList = new list<HomeBaseBeans.States>();
	    list<Country_and_State__c> lsrCountryState = [select Id,Name,State__c from Country_and_State__c where Name = :countryCode order by State__c ASC ];
	    
	    if(!lsrCountryState.isEmpty()){
	    	for(Country_and_State__c c : lsrCountryState){
	    		HomeBaseBeans.States hs = new HomeBaseBeans.States();
	    		hs.id = c.State__c;
	    		HBList.add(hs);
	    	}
	    }
	    return HBList;
    }
    
    /*********************************************************************
    Purpose     : This is inner class to initializing and holding after 
                  JSON parsing
    Parameters  : none
    Returns     : none
    **********************************************************************/
    public class stateListClass
    {
         public HomeBaseBeans.States[] states;
         public stateListClass()
            {
                this.states = new List<HomeBaseBeans.States>();
            }
    }
	
}