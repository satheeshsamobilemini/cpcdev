public with sharing class chargeCodesService_AC {
	
	public String chargeCodeResponse {get;set;}
	
	public List<HomeBaseBeans.chargeCodes> getChargeCodeList(String productId)
	{
		ServiceProxy servicePro = new ServiceProxy();		
		
		if(!Test.isRunningTest())
		chargeCodeResponse = servicePro.callRestService('rest/api/v1/charge_codes?company_id=1&product_id='+productId,'GET','');
		try
		{	
			if(!chargeCodeResponse.contains('"errorCode"'))
			{	
				ChargeCodesClass chrgeCodeResponseList = (ChargeCodesClass)JSON.deserialize(chargeCodeResponse, chargeCodesService_AC.ChargeCodesClass.class);
				System.debug('************* '+chrgeCodeResponseList);
				return chrgeCodeResponseList.chargeCodes;
			}
			else
			{
				String errorMessage = QuickQuoteErrorHandler.handleError(chargeCodeResponse);
				List<HomeBaseBeans.chargeCodes> HBList = new List<HomeBaseBeans.chargeCodes>();
				HomeBaseBeans.chargeCodes h = new HomeBaseBeans.chargeCodes();
				h.errorMessage = errorMessage; 
				
				HBList.add(h);
				
				return HBList;
			}
		}
		catch(Exception e)
		{
				String errorMessage = 'Internal Server Error';
				List<HomeBaseBeans.chargeCodes> HBList = new List<HomeBaseBeans.chargeCodes>();
				HomeBaseBeans.chargeCodes h = new HomeBaseBeans.chargeCodes();
				h.errorMessage = errorMessage; 
				
				HBList.add(h);
				
				return HBList;
		}
	}
	
	public class ChargeCodesClass
	{
		public HomeBaseBeans.chargeCodes[] chargeCodes;
		public ChargeCodesClass()
		{
			chargeCodes = new List<HomeBaseBeans.chargeCodes>();
		}
	}
	
}