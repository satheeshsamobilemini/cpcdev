public with sharing class FullQuoteEditResponseService_AC 
{
	public EditFullQUoteService_AC callEditWEbservice(String docId,String salesRep, String Branchid, String QuoteType){
		ServiceProxy servicePro =null;
		EditFullQUoteService_AC r = new EditFullQUoteService_AC(); 
		servicePro = new ServiceProxy();
        return r.parse(servicePro.callRestService('rest/api/v1/companies/1/quotes/'+docId+'?rep='+salesRep+'&branch_id='+Branchid+'&mobilization=1&type='+QuoteType.toLowerCase(),'GET',''));
		
	}
}