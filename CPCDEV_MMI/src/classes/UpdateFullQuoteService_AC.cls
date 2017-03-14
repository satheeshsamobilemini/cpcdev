public with sharing class UpdateFullQuoteService_AC {
	public String quoteResponse {get;set;}
	
	public String updateQuote(String payLoad, String docId, String mobilization,String branchId,String salesRep, String QuoteType, FullQuoteWrapper fullQWrapper)
	{
		string updateMsg=null;	
		ServiceProxy servicePro = new ServiceProxy();
		if(fullQWrapper.isCapacityReservedDurinEdit != null && fullQWrapper.isCapacityReservedDurinEdit){
			quoteResponse = servicePro.callRestService('/rest/api/v1/companies/1/quotes/'+docId+'?overwrite_quote=true&rep='+salesRep+'&branch_id='+branchId+'&type='+QuoteType.toLowerCase()+'&mobilization='+mobilization,'PUT',payLoad);
		}else{
			if(fullQWrapper.isQuoteUpdatedOnce != null && fullQWrapper.isQuoteUpdatedOnce){
				quoteResponse = servicePro.callRestService('/rest/api/v1/companies/1/quotes/'+docId+'?overwrite_quote=true&rep='+salesRep+'&branch_id='+branchId+'&type='+QuoteType.toLowerCase()+'&mobilization='+mobilization,'PUT',payLoad);
			}else{
				quoteResponse = servicePro.callRestService('/rest/api/v1/companies/1/quotes/'+docId+'?rep='+salesRep+'&branch_id='+branchId+'&type='+QuoteType.toLowerCase()+'&mobilization='+mobilization,'PUT',payLoad);
			}
			
		}
		
		if(!quoteResponse.contains('"errorCode"'))
		{	
		    updateMsg='success';
		}else{
		    updateMsg = QuickQuoteErrorHandler.handleError(quoteResponse);	
		}
		System.debug('****** create quote response '+quoteResponse);
		
		return updateMsg;
	}
	
}