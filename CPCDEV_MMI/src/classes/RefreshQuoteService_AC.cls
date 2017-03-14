public with sharing class RefreshQuoteService_AC {
	
	public String quoteRefreshResponse {get;set;}
	
	public FullQuoteRefreshParser_AC callRefreshQuoteService(String payLoad,String branchId ,String selesrepId, String QuoteType)
	{
		FullQuoteRefreshParser_AC fullQuoteRefreshResponse=null;
		FullQuoteRefreshParser_AC f=null;
		try
		{
		ServiceProxy servicePro = new ServiceProxy();
		if(!Test.isRunningTest()){
		quoteRefreshResponse = servicePro.callRestService('rest/api/v1/companies/1/quotes/refresh?type='+QuoteType.toLowerCase()+'&branch_id='+branchId+'&rep='+selesrepId ,'POST',payLoad);
		}
		
		System.debug('Res **** '+quoteRefreshResponse);
		if(quoteRefreshResponse!=null && !quoteRefreshResponse.contains('"errorCode"'))
			{
				 f = new FullQuoteRefreshParser_AC();
        		 fullQuoteRefreshResponse = f.parseRefreshResponse(quoteRefreshResponse);
        		  return fullQuoteRefreshResponse;
			}
			else
			{
				f = new FullQuoteRefreshParser_AC();
				//fullQuoteRefreshResponse = f.parseRefreshResponse(quoteRefreshResponse);
				
				String errorMessage = QuickQuoteErrorHandler.handleError(quoteRefreshResponse);
				system.debug('------errorMessage------'+errorMessage);
		        f.errorMessage=errorMessage; 
				return f;
			}

		//quoteRefreshResponse = quoteRefreshResponse.replace('', '');
		
		/*	
			String[] quoteRefreshResponseList = quoteRefreshResponse.split('billingContactDetails');
			String s2 = quoteRefreshResponseList[1];
			String partialResponse = '{"rentalQuote": {"billingContactDetails'+ s2;		
			
			quoteRefreshResponseList = partialResponse.split('lines');
			String[] quoteRefreshResponseList1 = partialResponse.split('"reference');
			
			partialResponse = quoteRefreshResponseList1[0]+'"lines'+ quoteRefreshResponseList[1];
			
			
			quoteRefreshResponseList = partialResponse.split('certificateOfInsurance');
			quoteRefreshResponseList1 = partialResponse.split('"shippingDate');
			
			partialResponse = quoteRefreshResponseList[0]+'shippingDate'+ quoteRefreshResponseList1[1];
			
			System.debug('****** refresh quote response '+partialResponse);
			
				
			   HomeBaseBeans.rentalQuote refreshQuoteRes = (HomeBaseBeans.rentalQuote)JSON.deserialize(staticRes(), HomeBaseBeans.rentalQuote.class);
				System.debug('****** refresh quote response deserialize '+refreshQuoteRes);
		 */				
			
		}
		catch(Exception e)
		{
			System.debug('****** refresh quote error '+e);
			return null;
		}
		
	}	
	
			
		
}