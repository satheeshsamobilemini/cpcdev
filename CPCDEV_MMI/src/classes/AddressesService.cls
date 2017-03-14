public with sharing class AddressesService 
{
	public String addressResponse {get;set;}
	
	public List<HomeBaseBeans.Addresses> listAddresses(String accountId)
	{
		system.debug('-----accountId----'+accountId);
		ServiceProxy servicePro = new ServiceProxy();
		//String addressResponse = servicePro.callRestService('rest/api/v1/accounts/'+accountId+'/addresses?company_id=1&include_shipping_addresses=1','GET','');
				
		if(!Test.isRunningTest()) 
		addressResponse = servicePro.callRestService('rest/api/v1/accounts/'+accountId+'/addresses?company_id=1&include_invoice_addresses=1&include_shipping_addresses=1','GET','');
		try
		{	
			if(!addressResponse.contains('"errorCode"'))
			{
				AddressesClass allTransactions = (AddressesClass)JSON.deserialize(addressResponse, AddressesClass.class);
				System.debug('***************'+allTransactions.Addresses); // Debug log
				return allTransactions.Addresses;
			}
			else
			{ 
				List<HomeBaseBeans.Addresses> HBList = new List<HomeBaseBeans.Addresses>();
				HomeBaseBeans.Addresses h = new HomeBaseBeans.Addresses();
				
				String errorMessage = QuickQuoteErrorHandler.handleError(addressResponse);				
				h.errorMessage = errorMessage;
				
				HBList.add(h);
				
				return HBList;
	        }
		}
		catch(Exception e)
		{
			String errorMessage = e.getMessage();
			
			List<HomeBaseBeans.Addresses> HBList = new List<HomeBaseBeans.Addresses>();
			HomeBaseBeans.Addresses h = new HomeBaseBeans.Addresses();
			h.errorMessage = errorMessage;
			
			HBList.add(h);
			
			return HBList;
		}
	}
	
	public class AddressesClass
    {
    	 public HomeBaseBeans.Addresses[] Addresses;
                public AddressesClass()
                {
                   this.Addresses = new List<HomeBaseBeans.Addresses>();  
                }    	
    }
}