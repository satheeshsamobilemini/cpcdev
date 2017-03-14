/**************************************************************************
Name:  CreateQuickQuoteService_AC()
Copyright © 2013  MMI
----------------------------------------------------------------------
Purpose:
This class contains the methods for Create Quick Quote Service HTTP Rest 
web service Callouts 
-----------------------------------------------------------------------
History:

VERSION  AUTHOR                 DATE        DETAIL              
1.0  -  TEKsystems             11/2/2013   INITIAL DEVELOPMENT  
**************************************************************************/
public with sharing class CreateQuickQuoteService_AC 
{
	public String createQuoteResponse {get;set;}
	/*********************************************************************
    Purpose     : To Create Quick quote using web services callout
    Parameters  : String of Paylod in json format
    Returns     : HomeBaseBeans.CreateQuoteResponse
    **********************************************************************/
	public HomeBaseBeans.CreateQuoteResponse createQuickQuote(String QQCR)
	{
		ServiceProxy servicePro = new ServiceProxy();		
		
		if(!Test.isRunningTest()){
		system.debug('---------QQCR--------------------'+QQCR);
		createQuoteResponse = servicePro.callRestService('rest/api/v1/quick_quotes','POST',QQCR);
		system.debug('--------createQuoteResponse-------------------'+createQuoteResponse);
		}
		
		try
		{	
			if(!createQuoteResponse.contains('"errorCode"'))
			{	
				HomeBaseBeans.CreateQuoteResponse documentId = (HomeBaseBeans.CreateQuoteResponse)JSON.deserialize(createQuoteResponse, HomeBaseBeans.CreateQuoteResponse.class);
				return documentId;
			}
			else
			{
				HomeBaseBeans.CreateQuoteResponse h = new HomeBaseBeans.CreateQuoteResponse();
				String errorMessage = QuickQuoteErrorHandler.handleError(createQuoteResponse);			
				
				h.errorMessage = errorMessage;			
				return h;
			}
		}
		catch(Exception e)
		{
			String errorMessage = e.getMessage();			
			HomeBaseBeans.CreateQuoteResponse h = new HomeBaseBeans.CreateQuoteResponse();
			h.errorMessage = errorMessage;			
			return h;
		}
	}
	
	public String getCreateRequestRequest(HomeBaseBeans.CreateQuickQuoteRequest QQCR)
	{
		String savePayload = '{"quickQuote":{"duration":'+QQCR.Duration+',"lead":"'+QQCR.LeadOppName+'","transport":"'+QQCR.Transport+'","transactionId":"'+QQCR.transactionId+'","rate":"'+QQCR.Rate+'","rentalPPETotal":"'+QQCR.rentalPPETotal+'","quickQuoteTotal":"'+QQCR.quickQuoteTotal+'","dateFrom":'+QQCR.dateFrom+',"shippingAddress":{"state":"'+QQCR.State+'","countryId":"'+QQCR.countryId+'","address1":"'+QQCR.address1+'","address2":"","address3":"'+QQCR.address3+'","address4":"","zipCode":"'+QQCR.zipcode+'", "taxId": "'+QQCR.taxId+'","fulfillingBranchId": "'+QQCR.fulfillingBranchId+'"},"accountId":"'+QQCR.accountId+'","productId":"'+QQCR.productId+'","branchId":"'+QQCR.branchId+'","llwTotal":"'+QQCR.llwTotal+'","locksTotal":"'+QQCR.locksTotal+'","taxTotal":"'+QQCR.taxTotal+'","codAmount":"'+QQCR.codAmount+'","includeLLW":'+QQCR.includeLLW+',"fuelSurcharge":'+QQCR.fuelSurcharge+',"locksQty":'+QQCR.locksQty+',"companyId": '+QQCR.companyId+', "operatorId" : "'+QQCR.operatorId+'", "salesRep": "'+QQCR.salesRep+'", "status":"'+QQCR.status+'" }}';
		 
		return savePayload;
	}
	
	
}