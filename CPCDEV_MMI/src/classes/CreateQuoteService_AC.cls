public with sharing class CreateQuoteService_AC {
	
	public String quoteResponse {get;set;}
	
	public HomeBaseBeans.CreateFullQuoteResponse CreateQuote(String payLoad, String repId, String quoteType)
	{
		ServiceProxy servicePro = new ServiceProxy();
		if(!Test.isRunningTest()){
		quoteResponse = servicePro.callRestService('rest/api/v1/companies/1/quotes?type='+quoteType.toLowerCase()+'&rep='+repId,'POST',payLoad);
		}
		System.debug('****** create quote response '+quoteResponse);
		try
		{	
			if(!quoteResponse.contains('"errorCode"'))
			{	
				HomeBaseBeans.CreateFullQuoteResponse fullQuoteResponse = (HomeBaseBeans.CreateFullQuoteResponse)JSON.deserialize(quoteResponse, HomeBaseBeans.CreateFullQuoteResponse.class);
				return fullQuoteResponse;
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
	}
}