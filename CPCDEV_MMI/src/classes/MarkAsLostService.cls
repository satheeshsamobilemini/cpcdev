public with sharing class MarkAsLostService {
	
	
	public String quoteResponse {get;set;}
	
	public HomeBaseBeans.CreateFullQuoteResponse CreateQuote(String quotetype , String payLoad, String repId,String branchId)
	{
		
		MarkAsLostQuote markAsLost=null;
		
		quotetype = quotetype.toLowerCase();
		ServiceProxy servicePro = new ServiceProxy();
		if(!Test.isRunningTest()){
		quoteResponse = servicePro.callRestService('rest/api/v1/companies/1/quotes/no_sale?type='+quotetype+'&branch_id='+branchId+'&rep='+repId+'&overwrite_quote=true','POST',payLoad);
		}
		System.debug('****** Mark As Lost Quote response '+quoteResponse);
		try
		{	
			if(!quoteResponse.contains('"errorCode"'))
			{	
				markAsLost = (MarkAsLostQuote)JSON.deserialize(quoteResponse, MarkAsLostService.MarkAsLostQuote.class);
				//return fullQuoteResponse;
			}
			else
			{
				HomeBaseBeans.CreateFullQuoteResponse h = new HomeBaseBeans.CreateFullQuoteResponse();
				String errorMessage = QuickQuoteErrorHandler.handleError(quoteResponse);			
				h.errorMessage = errorMessage;			
				return h;
			}
		}
		catch(Exception e)
		{
			HomeBaseBeans.CreateFullQuoteResponse h = new HomeBaseBeans.CreateFullQuoteResponse();
			String errorMessage = 'Internal Server Error';				
			
			h.errorMessage = errorMessage;			
			return h;
		}
		return markAsLost.quotePK;
	}
	
	    public class MarkAsLostQuote {
        
        public String message {get;set;} 
        public HomeBaseBeans.CreateFullQuoteResponse quotePK {get;set;} 
       
    }
	
}