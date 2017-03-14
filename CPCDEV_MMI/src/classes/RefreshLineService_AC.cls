public with sharing class RefreshLineService_AC {
	
	public String refreshLineResponse {get;set;}
	
	public List<HomeBaseBeans.quoteLine> refreshLine(HomeBaseBeans.quoteLine quoteLineLoad, String tranId, String branchId, String selectedFullQUote)
	{
		ServiceProxy serviceProxy = new ServiceProxy();
		if(selectedFullQUote != 'sales'){		
			if(quoteLineLoad.chargeCode.Id == null || quoteLineLoad.chargeCode.Id == '')
			{
				quoteLineLoad.chargeCode.Id = 'monthly';
			}
		}
		
		if(quoteLineLoad.lockItemCode == null || quoteLineLoad.lockItemCode == '')
		{
			quoteLineLoad.lockItemCode = '';
		}
	    String payLoad = '';
	    String RateNo = '';  // need to be dynamic according to quoteLineLoad.SelectedPeriod value
	    String RateVal = '100.00'; // need to be dynamic according to quoteLineLoad.SelectedPeriod value
	    if(tranId == 'CNST'){
	    	if(quoteLineLoad.itemId != 'CG1' && quoteLineLoad.itemId != 'CG2' && quoteLineLoad.itemId != 'DL1' && quoteLineLoad.itemId != 'DL2'){
		    	RateNo = 'rate5';
			    RateVal = quoteLineLoad.rate5.rate;
	    	}
	    }else{
	    	if(tranId == 'MOBO' || tranId == 'SECO'){
	    		if(Integer.valueOf(quoteLineLoad.SelectedPeriod) >= 2 && Integer.valueOf(quoteLineLoad.SelectedPeriod) <= 6){
			    	if(quoteLineLoad.itemType == 'Accessories Item'){
			    		RateNo = 'rate2';
			    	}else{
			    		RateNo = 'rate1';
			    	}
			    	RateVal = quoteLineLoad.SelectedRate1;
			    }else if(Integer.valueOf(quoteLineLoad.SelectedPeriod) >= 7 && Integer.valueOf(quoteLineLoad.SelectedPeriod) <= 12){
			    	if(quoteLineLoad.itemType == 'Accessories Item'){
			    		RateNo = 'rate3';
			    	}else{
			    		RateNo = 'rate2';
			    	}
			    	RateVal = quoteLineLoad.SelectedRate2;
			    }else if(Integer.valueOf(quoteLineLoad.SelectedPeriod) >= 13 && Integer.valueOf(quoteLineLoad.SelectedPeriod) <= 24){
			    	if(quoteLineLoad.itemType == 'Accessories Item'){
			    		RateNo = 'rate4';
			    	}else{
			    		RateNo = 'rate3';
			    	}
			    	RateVal = quoteLineLoad.SelectedRate3;
			    }else if(Integer.valueOf(quoteLineLoad.SelectedPeriod) >= 25){
			    	if(quoteLineLoad.itemType == 'Accessories Item'){
			    		RateNo = 'rate5';
			    	}else{
			    		RateNo = 'rate4';
			    	}
			    	RateVal = quoteLineLoad.SelectedRate4;
			    }	
	    	}else{
			    if(Integer.valueOf(quoteLineLoad.SelectedPeriod) == 1){
			    	RateNo = 'rate1';
			    	RateVal = quoteLineLoad.SelectedRate1;
			    }else if(Integer.valueOf(quoteLineLoad.SelectedPeriod) >= 2 && Integer.valueOf(quoteLineLoad.SelectedPeriod) <= 6){
			    	RateNo = 'rate2';
			    	RateVal = quoteLineLoad.SelectedRate2;
			    }else if(Integer.valueOf(quoteLineLoad.SelectedPeriod) >= 7 && Integer.valueOf(quoteLineLoad.SelectedPeriod) <= 12){
			    	RateNo = 'rate3';
			    	RateVal = quoteLineLoad.SelectedRate3;
			    }else if(Integer.valueOf(quoteLineLoad.SelectedPeriod) >= 13){
			    	RateNo = 'rate4';
			    	RateVal = quoteLineLoad.SelectedRate4;
			    }
	    	}
	    	
	    }
	   if(selectedFullQUote != 'sales'){
			if(quoteLineLoad.itemId != 'CG1' && quoteLineLoad.itemId != 'CG2' && quoteLineLoad.itemId != 'DL1' && quoteLineLoad.itemId != 'DL2'){
				//if(!quoteLineLoad.isAccessories){
					payLoad = '{"quoteLine":{"itemId":"'+quoteLineLoad.itemId+'","quantity":'+quoteLineLoad.quantity+',"ecode":"","internetCoupon":"","chargeCode":{"id":"'+quoteLineLoad.chargeCode.Id+'"}, "'+RateNo+'":{"rate":"'+RateVal+'"}, "lockItemCode":""}}';
				/*}else{
					payLoad = '{"quoteLine":{"itemId":"'+quoteLineLoad.itemId+'","quantity":'+quoteLineLoad.quantity+',"ecode":"","internetCoupon":"","chargeCode":{"id":"'+quoteLineLoad.chargeCode.Id+'"}, "price":"'+RateVal+'", "lockItemCode":""}}';
				}*/
			}else{
				if(quoteLineLoad.price != null){
					payLoad = '{"quoteLine":{"itemId":"'+quoteLineLoad.itemId+'","quantity":'+quoteLineLoad.quantity+',"price":"'+quoteLineLoad.price+'","ecode":"","internetCoupon":"","lockItemCode":""}}';
				}else{
					payLoad = '{"quoteLine":{"itemId":"'+quoteLineLoad.itemId+'","quantity":'+quoteLineLoad.quantity+',"price":"","ecode":"","internetCoupon":"","lockItemCode":""}}';
				}
					
			}
	    }else{
	    	payLoad = '{"quoteLine":{"itemId":"'+quoteLineLoad.itemId+'","ecode":"'+quoteLineLoad.ecode+'","quantity":'+quoteLineLoad.quantity+',"reference":"", ';
	    	if(quoteLineLoad.price != null){
	    		payLoad += '"price":"'+quoteLineLoad.price+'",';
	    	}else{
	    		payLoad += '"price":null,';
	    	}
	    	if(quoteLineLoad.modificationCharge != null){
	    		payLoad += '"modificationCharge":"'+quoteLineLoad.modificationCharge+'",';
	    	}
	    	if(quoteLineLoad.estimatedCost != null){
	    		payLoad += '"modificationCharge":"'+quoteLineLoad.estimatedCost+'",';
	    	}
	    	if(quoteLineLoad.netBookValue != null){
	    		payLoad += '"netBookValue":"'+quoteLineLoad.netBookValue+'",';
	    	}
	   		payLoad += '"lockItemCode":"'+quoteLineLoad.lockItemCode+'"}}';
	    }	
		
		try
		{
			if(!Test.isRunningTest())
			refreshLineResponse =  serviceProxy.callRestService('rest/api/v1/companies/1/quotes/lines/refresh?type='+selectedFullQUote.toLowerCase()+'&branch_id='+branchId+'&transaction_id='+tranId+'&account_id='+quoteLineLoad.SelectedAccountId+'&duration='+quoteLineLoad.SelectedPeriod+'&from_date='+quoteLineLoad.SelectedFromDate,'POST',payLoad);
													
			if(!refreshLineResponse.contains('"errorCode"') || !refreshLineResponse.contains('"userErrorMessage"'))
			{	
				if(selectedFullQUote != 'sales'){
					refreshLineClass refreshLineList = (refreshLineClass)JSON.deserialize(refreshLineResponse, RefreshLineService_AC.refreshLineClass.class); 
					System.debug('******refreshLineList***** '+refreshLineList);
					System.debug('******refreshLineList.quoteLine***** '+refreshLineList.quoteLine);
					return refreshLineList.quoteLine;
				}else{
					refreshLineForSalesClass refreshLineList = (refreshLineForSalesClass)JSON.deserialize(refreshLineResponse, RefreshLineService_AC.refreshLineForSalesClass.class);
					System.debug('******refreshLineList***** '+refreshLineList);
					System.debug('******refreshLineList.quoteLine***** '+refreshLineList.quoteLines);
					return refreshLineList.quoteLines;
				}
			}
			else
			{
				List<HomeBaseBeans.quoteLine> HBList = new List<HomeBaseBeans.quoteLine>();
				HomeBaseBeans.quoteLine h = new HomeBaseBeans.quoteLine();
				
				String errorMessage = QuickQuoteErrorHandler.handleError(refreshLineResponse);				
				h.errorMessage = errorMessage;
				
				HBList.add(h);
				
				return HBList;
			}
		}
		catch(Exception e)
		{
			String errorMessage = e.getMessage();
			List<HomeBaseBeans.quoteLine> HBList = new List<HomeBaseBeans.quoteLine>();
			HomeBaseBeans.quoteLine h = new HomeBaseBeans.quoteLine();
			h.errorMessage = errorMessage;
			
			HBList.add(h);
			
			return HBList;
		}
	}
	
	public class refreshLineClass
	{
		public HomeBaseBeans.quoteLine[] quoteLine;
		public refreshLineClass()
		{
			quoteLine = new List<HomeBaseBeans.quoteLine>();
		}
	}
	
	public class refreshLineForSalesClass
	{
		public HomeBaseBeans.quoteLine[] quoteLines;
		public refreshLineForSalesClass()
		{
			quoteLines = new List<HomeBaseBeans.quoteLine>();
		}
	}
	
}