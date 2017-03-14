public with sharing class AnalysisSetCodesService_AC 
{
	public String analysisResponse {get;set;}
	
	public List<HomeBaseBeans.analysisSetCodes> listActiveTransactions(String analysisId)
	{
		ServiceProxy servicePro = new ServiceProxy();
		/*		
		if(!Test.isRunningTest())
		analysisResponse = servicePro.callRestService('rest/api/v1/analysis_sets/'+analysisId+'?company_id=1','GET','');
		System.debug('********analysisResponse*******'+analysisResponse); // Debug log
		try
		{	
			if(!analysisResponse.contains('"errorCode"'))
			{
				AnalysisParentClass allHeaders = (AnalysisParentClass)JSON.deserialize(analysisResponse, AnalysisParentClass.class);
				System.debug('***************'+allHeaders.analysisSetCodes); // Debug log
				return allHeaders.analysisSetCodes;
			}
			else
			{ 
				List<HomeBaseBeans.analysisSetCodes> HBList = new List<HomeBaseBeans.analysisSetCodes>();
				HomeBaseBeans.analysisSetCodes h = new HomeBaseBeans.analysisSetCodes();
				String errorMessage = QuickQuoteErrorHandler.handleError(analysisResponse);
				
				h.errorMessage = errorMessage; 
				
				HBList.add(h);
				
				return HBList;
	        }
		}
		catch(Exception e)
		{
			String errorMessage = 'Internal Server Error';
			
			List<HomeBaseBeans.analysisSetCodes> HBList = new List<HomeBaseBeans.analysisSetCodes>();
			HomeBaseBeans.analysisSetCodes h = new HomeBaseBeans.analysisSetCodes();
			h.errorMessage = errorMessage;
			
			HBList.add(h);
			
			return HBList;
		}*/
		list<HomeBaseBeans.analysisSetCodes> lstASC = new list<HomeBaseBeans.analysisSetCodes>();
	    list<Analysis_set_code__c> lsrAc = [select Id,Id__c,Description__c,Long_description__c from Analysis_set_code__c where Analysis_set_header__r.Id__c = :analysisId order by Id__c desc];
	    
	    if(!lsrAc.isEmpty()){
	    	for(Analysis_set_code__c a : lsrAc){
	    		HomeBaseBeans.analysisSetCodes hac = new HomeBaseBeans.analysisSetCodes();
	    		hac.id = a.Id__c;
	    		hac.description = a.Description__c;
	    		hac.Longdescription = a.Long_description__c;
	    		lstASC.add(hac);
	    	}
	    }
	     system.debug('--------------------------lstASC-------------------------'+lstASC);
	    return lstASC;
	}
	
	public class AnalysisParentClass
	{
		public HomeBaseBeans.analysisSetCodes[] analysisSetCodes;
		public AnalysisParentClass()
		{
			analysisSetCodes = new List<HomeBaseBeans.analysisSetCodes>();
		}
	}
	
}