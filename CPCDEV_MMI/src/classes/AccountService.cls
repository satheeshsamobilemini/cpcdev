public with sharing class AccountService {
	
	public string accountResponse {get;set;}
	public HomeBaseBeans.Account listAccounts(String accountId, String TransactionTypeId ,string stertDate){
		ServiceProxy servicePro = new ServiceProxy();
		
		system.debug('-------accountId-------'+accountId);
		system.debug('--------TransactionTypeId------'+TransactionTypeId);
		system.debug('-------stertDate-------'+stertDate);
		
		if(!Test.isRunningTest()) 
		accountResponse = servicePro.callRestService('rest/api/v1/accounts/'+accountId+'?company_id=1&transaction_id='+TransactionTypeId+'&start_date='+stertDate,'GET','');
		system.debug('------accountResponse---'+accountResponse);
		try
		{
			if(!accountResponse.contains('"errorCode"'))
			{
				AccountClass accountResponseList = (AccountClass)JSON.deserialize(accountResponse, AccountClass.class);
				System.debug('*************** account'+accountResponseList.account); // Debug log
				return accountResponseList.account;
			}
			else
			{ 
				HomeBaseBeans.Account h = new HomeBaseBeans.Account();
				String errorMessage = QuickQuoteErrorHandler.handleError(accountResponse);
				h.errorMessage = errorMessage;
				system.debug('----h.errorMessage----'+h.errorMessage);
				//ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,h.errorMessage);
                //ApexPages.addMessage(msg);
				
				return h;
	        }
		}
		catch(Exception e)
		{
			    System.debug('*********'+e);
			    String errorMessage = e.getMessage();
			    
				HomeBaseBeans.Account h = new HomeBaseBeans.Account(); 
				h.errorMessage = errorMessage;
				
				return h;
		}
	}
	
	public List<HomeBaseBeans.Account> listAccountsSearchPattern(String patternSearch,String tpyId,String startDate){
		system.debug('-------patternSearch---'+patternSearch);
		system.debug('-------tpyId---'+tpyId);
		system.debug('-------startDate---'+startDate);
		
		ServiceProxy serviceProxy = null;
		List<HomeBaseBeans.account> HBAccountList=null;
		AccountListpattern accountListpattern=null;
		
		try{
        	if(patternSearch!=null){ 
                 serviceProxy = new ServiceProxy(); 
                 	if(!Test.isRunningTest()){ 
						accountResponse = serviceProxy.callRestService('/rest/api/v1/accounts?pattern='+patternSearch+'&start_date='+startDate+'&transaction_id='+tpyId+'&company_id=1&limit=300','GET','');
						system.debug('-------accountResponse---'+accountResponse);
                 	}
		
					if( accountResponse!=null && !accountResponse.contains('"errorCode"'))
					{
				        accountListpattern = (AccountListpattern)JSON.deserialize(accountResponse, AccountService.AccountListpattern.class);
				        system.debug('--------accountListpattern-------'+accountListpattern);
		
					}else{
						HBAccountList = new List<HomeBaseBeans.account>();
						HomeBaseBeans.account h = new HomeBaseBeans.account();
				String errorMessage = QuickQuoteErrorHandler.handleError(accountResponse);
				h.errorMessage = errorMessage;
						HBAccountList.add(h);
	        }
		}
		}catch(Exception e){
			    String errorMessage = e.getMessage();
			HBAccountList = new List<HomeBaseBeans.account>();
			HomeBaseBeans.account h = new HomeBaseBeans.account();
				h.errorMessage = errorMessage;
			HBAccountList.add(h);
			return HBAccountList;
	    }
		if(HBAccountList!=null && !HBAccountList.isEmpty()){
	    	system.debug(LoggingLevel.DEBUG,'Exiting AccountService.AccountListpattern:'+HBAccountList);
	        return HBAccountList;
	    }else{
	    	system.debug(LoggingLevel.DEBUG,'Exiting AccountService.AccountListpattern:'+AccountListpattern.accounts);
	    	return AccountListpattern.accounts;
		}
	}
	
	
	public class AccountClass
	{
		public HomeBaseBeans.account account; 
		
		public AccountClass()
		{
			account = new HomeBaseBeans.account();
		}
	}
	
	 public class AccountListpattern {
        public String totalResults ;
        public HomeBaseBeans.account[] accounts ;
        
    } 
    
}