public with sharing class AnalysisSetsService_AC 
{
	public String analysisResponse {get;set;}
	
	public List<HomeBaseBeans.AnalysisSetHeaders> listActiveTransactions(String url)
	{
		/*ServiceProxy servicePro = new ServiceProxy();
				
		if(!Test.isRunningTest()) 
		analysisResponse = servicePro.callRestService(url,'GET','');
		try
		{	
			if(!analysisResponse.contains('"errorCode"'))
			{
				AnalysisParentClass allHeaders = (AnalysisParentClass)JSON.deserialize(analysisResponse, AnalysisParentClass.class);
				System.debug('***************'+allHeaders.AnalysisSetHeaders); // Debug log
				return allHeaders.AnalysisSetHeaders;
			}
			else
			{ 
				List<HomeBaseBeans.AnalysisSetHeaders> HBList = new List<HomeBaseBeans.AnalysisSetHeaders>();
				HomeBaseBeans.AnalysisSetHeaders h = new HomeBaseBeans.AnalysisSetHeaders();
				String errorMessage = QuickQuoteErrorHandler.handleError(analysisResponse);
				
				h.errorMessage = errorMessage; 
				
				HBList.add(h);
				
				return HBList;
	        }
		}
		catch(Exception e)
		{
			String errorMessage = 'Internal Server Error';
			
			List<HomeBaseBeans.AnalysisSetHeaders> HBList = new List<HomeBaseBeans.AnalysisSetHeaders>();
			HomeBaseBeans.AnalysisSetHeaders h = new HomeBaseBeans.AnalysisSetHeaders();
			h.errorMessage = errorMessage;
			
			HBList.add(h);
			
			return HBList;
		}*/
		system.debug('-------------------url--------------------'+url);
		list<HomeBaseBeans.AnalysisSetHeaders> orderedASH = new list<HomeBaseBeans.AnalysisSetHeaders>();
		list<HomeBaseBeans.AnalysisSetHeaders> lstASH = new list<HomeBaseBeans.AnalysisSetHeaders>();
		if(url != null && url != '' ){
			list<String> lstSrt = url.split('_');
			String TransactionType = lstSrt[0];
			
			map<String,String> ttOrder = new map<String,String>();
			ttOrder.put('OFF','102_103_110_142');
			ttOrder.put('CART','102_103_110_142');
			ttOrder.put('CNST','102_103_110_142');
			ttOrder.put('MOBO','102_103_110_142');
			ttOrder.put('ON','102_103_110');
			ttOrder.put('SECO','102_103_110_142');
			ttOrder.put('VANT','102_103_110_142');
			ttOrder.put('OFFX','102_103_110_142');
			
			ttOrder.put('SOFL','102_103_7_3_142');
			ttOrder.put('SOMA','102_103_7_3_142');
			ttOrder.put('SOWD','102_103_7_3_142');
			
			if(lstSrt.size() > 1){
				set<String> setExraAnalysisSet = new set<String>();
				// get extra analysis set header from custom setting
				list<ExtraAnalysisSet__c> extraAshList = null;
				if(ExtraAnalysisSet__c.getAll() != null){
					extraAshList = ExtraAnalysisSet__c.getAll().Values();
					if(extraAshList != null && !extraAshList.isEmpty()){
						String allExtraAsh = extraAshList.get(0).Analysis_set_header__c;
						if(allExtraAsh != null && allExtraAsh != ''){
							list<String> lstEASH = allExtraAsh.split(',');
							for(String s: lstEASH){
								setExraAnalysisSet.add(s);
							}
						}
				     }
                 }
                 if(test.isRunningTest()){
                 	set<String> lstString = new set<String>();
                 	lstString.add('111');
                 	lstString.add('112');
                 	lstString.add('113');
                 	lstString.add('114');
                 	setExraAnalysisSet = lstString;
                 }
                 system.debug('-------------------setExraAnalysisSet--------------------'+setExraAnalysisSet);
                 if(!setExraAnalysisSet.isEmpty()){
                 	list<Analysis_set_header__c> lsrAh = [select Id,Id__c,Description__c from Analysis_set_header__c where Id__c in :setExraAnalysisSet];
                 	if(!lsrAh.isEmpty()){
				    	for(Analysis_set_header__c a : lsrAh){
				    		HomeBaseBeans.AnalysisSetHeaders hah = new HomeBaseBeans.AnalysisSetHeaders();
				    		hah.id = a.Id__c;
				    		hah.description = a.Description__c;
				    		lstASH.add(hah);
				    	}
				    }
                }
                
                orderedASH = lstASH;
                 
			}else{
			    list<Analysis_set_header__c> lsrAh = [select Id,Id__c,Description__c from Analysis_set_header__c where Transaction_Type__r.Name = :url ];
			    system.debug('--------------------------lsrAh-------------------------'+lsrAh);
			    if(!lsrAh.isEmpty()){
			    	for(Analysis_set_header__c a : lsrAh){
			    		HomeBaseBeans.AnalysisSetHeaders hah = new HomeBaseBeans.AnalysisSetHeaders();
			    		hah.id = a.Id__c;
			    		hah.description = a.Description__c;
			    		lstASH.add(hah);
			    	}
			    }
			    
			    //Ordering the analysis set header
				system.debug('--------------------------lstASH-------------------------'+lstASH);
				String lstAnalysisSetCode = ttOrder.get(TransactionType);
				if(lstAnalysisSetCode != null && lstAnalysisSetCode != ''){
					for(String s : lstAnalysisSetCode.split('_')){
						for(HomeBaseBeans.AnalysisSetHeaders h : lstASH){
							if(h.id == s){
								orderedASH.add(h);
							} 
						}
					}
				}
			}
			
			
		}
		 system.debug('--------------------------orderedASH-------------------------'+orderedASH);
	    return orderedASH;
	   
	}
	
	public class AnalysisParentClass
	{
		public HomeBaseBeans.AnalysisSetHeaders[] AnalysisSetHeaders;
		public AnalysisParentClass()
		{
			AnalysisSetHeaders = new List<HomeBaseBeans.AnalysisSetHeaders>();
		}
	}
}