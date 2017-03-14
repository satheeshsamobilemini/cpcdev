public with sharing class ProductExtrasService_AC 
{
	 public String productExtrasResponse {get;set;}
	public List<HomeBaseBeans.extras> listExtras(List<HomeBaseBeans.Products> payLoadList, String tranId, String deliveryZone, String branchId, String AccountNo, String RentalLength, String FromDate, String QuoteType)
	{
		ServiceProxy servicePro =null; 
    	List<HomeBaseBeans.extras> extrasList =null;
    	Productextras allExtras ;
    	
    	//String dataPayload = '{"extrasRefresh":{"lines":[{"itemId":"20s","lineValue":87,"quantity":1},{"itemId":"CG1","lineValue":19.95,"quantity":1.00}]}}';
		
		String dataPayload;
		
		if(payLoadList.size() > 0)
		{	
			System.debug('******payLoadList*****before ws call*******'+payLoadList);
			dataPayload = '';
			for(HomeBaseBeans.Products pl : payLoadList){
				dataPayload += '{"itemId":"'+pl.Id+'","lineValue":'+pl.lineValue+',"quantity":'+pl.quantity+'},';
			}
			if(dataPayload != ''){
				dataPayload = dataPayload.substring(0, (dataPayload.length() - 1));
				dataPayload = '{"extrasRefresh":{"lines":['+dataPayload+']}}';
			}
			System.debug('******dataPayload*****before ws call*******'+dataPayload);
			//dataPayload = '{"extrasRefresh":{"lines":[{"itemId":"'+payLoadList[0].Id+'","lineValue":'+payLoadList[0].lineValue+',"quantity":1},{"itemId":"'+payLoadList[1].Id+'","lineValue":'+payLoadList[1].lineValue+',"quantity":1.00}]}}';
		}
		
		try{	
            servicePro = new ServiceProxy();
				if(QuoteType == 'sales'){
					RentalLength = '0';
				}
				if(deliveryZone == '' || deliveryZone == null){
					if(!test.isRunningTest()){
					productExtrasResponse = servicePro.callRestService('rest/api/v1/companies/1/quotes/extras/refresh?account_id='+AccountNo+'&company_id=1&branch_id='+branchId+'&transaction_id='+tranId+'&duration='+RentalLength+'&from_date='+FromDate+'&type='+QuoteType.toLowerCase(),'POST',dataPayload);
					}
				}else{
					if(tranId == 'MOBO'){
						if(!test.isRunningTest()){
						productExtrasResponse = servicePro.callRestService('rest/api/v1/companies/1/quotes/extras/refresh?account_id='+AccountNo+'&company_id=1&branch_id='+branchId+'&transaction_id='+tranId+'&duration='+RentalLength+'&from_date='+FromDate+'&type='+QuoteType.toLowerCase(),'POST',dataPayload);
						}
					}else{
						if(!test.isRunningTest()){
						productExtrasResponse = servicePro.callRestService('rest/api/v1/companies/1/quotes/extras/refresh?account_id='+AccountNo+'&company_id=1&branch_id='+branchId+'&transaction_id='+tranId+'&duration='+RentalLength+'&from_date='+FromDate+'&delivery_zone='+deliveryZone+'&type='+QuoteType.toLowerCase(),'POST',dataPayload);	
					}
					}
			    	
				}
			    
			    System.debug('******productExtrasResponse************'+productExtrasResponse);
			    productExtrasResponse = productExtrasResponse.replaceAll('extras','Extras2');
			    System.debug('***productExtrasResponse after change *****'+productExtrasResponse); 
			if(!productExtrasResponse.contains('"errorCode"'))
			{				
				Productextras productExtrasList = (Productextras)JSON.deserialize(productExtrasResponse, Productextras.class);
				System.debug('***** response List '+productExtrasList.Extras2);
				
				return productExtrasList.Extras2;
			}
			else
			{ 
				extrasList = new List<HomeBaseBeans.extras>();
				HomeBaseBeans.extras h = new HomeBaseBeans.extras();
				String errorMessage = QuickQuoteErrorHandler.handleError(productExtrasResponse);
				h.errorMessage = errorMessage;
				extrasList.add(h); 
				return extrasList;
	        }
			
		}
		catch(Exception e)
		{
			System.debug('***** response error '+e);
			String errorMessage = 'Internal Server Error';
			extrasList = new List<HomeBaseBeans.extras>();
			HomeBaseBeans.extras h = new HomeBaseBeans.extras();
			h.errorMessage = errorMessage;
			extrasList.add(h); 
			return extrasList;
		}
		
				
	}
	
	 public class Productextras
    {
    	List<HomeBaseBeans.extras> Extras2;
    	
    	public Productextras()
    	{
    		Extras2 = new List<HomeBaseBeans.extras>();
    	}
    }
}