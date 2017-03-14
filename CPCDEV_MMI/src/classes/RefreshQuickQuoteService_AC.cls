/**************************************************************************
Name:  RefreshQuickQuoteService_AC()
Copyright © 2013  MMI
----------------------------------------------------------------------
Purpose:
This class contains the methods for Refresh Quick Quote Service HTTP Rest 
web service Callouts 
-----------------------------------------------------------------------
History:

VERSION  AUTHOR                 DATE        DETAIL              
1.0  -  TEKsystems             11/2/2013   INITIAL DEVELOPMENT  
**************************************************************************/
public with sharing class RefreshQuickQuoteService_AC {
	
	public String quickQuoteRefreshResponse {get;set;}
	
	/*********************************************************************
    Purpose     : To get the Refreshed values from Refresh Quick  Quote service
    Parameters  : HomeBaseBeans.QuickQuoteRefreshFormat
    Returns     : HomeBaseBeans.quickQuoteRefresh
    **********************************************************************/
	public HomeBaseBeans.quickQuoteRefresh refreshQuickQuote(HomeBaseBeans.QuickQuoteRefreshFormat QQRF){
		
		system.debug(LoggingLevel.DEBUG,'Entering RefreshQuickQuoteService_AC :refreshQuickQuote'+QQRF );
		ServiceProxy servicePro=null;
		HomeBaseBeans.quickQuoteRefresh h=null;
		HomeBaseBeans.quickQuoteRefresh quickQuoteList;
		try{
			servicePro = new ServiceProxy();
	
			if(!Test.isRunningTest()){
				quickQuoteRefreshResponse = servicePro.callRestService('rest/api/v1/quick_quotes/refresh','POST',getQuickQuoteRefreshRequest(QQRF));
			}
			System.debug('refreshQuickQuoteResponse---'+quickQuoteRefreshResponse);
				
			if(quickQuoteRefreshResponse!=null && !quickQuoteRefreshResponse.contains('"errorCode"'))
			{
				String ss = quickQuoteRefreshResponse.substring(1, quickQuoteRefreshResponse.length()-1);
		        ss = ss.replace('"quickQuote":', '');
		        ss = ss.replace('shippingAddress', 'shippingAddress2');
				quickQuoteList = (HomeBaseBeans.quickQuoteRefresh)JSON.deserialize(ss, HomeBaseBeans.quickQuoteRefresh.class);
			}
			else
			{
				h = new HomeBaseBeans.quickQuoteRefresh();
				String errorMessage = QuickQuoteErrorHandler.handleError(quickQuoteRefreshResponse);
				h.errorMessage = errorMessage;
			}
		}
		catch(Exception e)
		{
			String errorMessage = e.getMessage();
			h = new HomeBaseBeans.quickQuoteRefresh();
			h.errorMessage = errorMessage;
			system.debug(LoggingLevel.ERROR,'Error while getting values from RefreshQuickQuoteService_AC refreshQuickQuote'+e.getMessage());
			return h;
		}
		if(h!=null){
	    	system.debug(LoggingLevel.DEBUG,'Exiting RefreshQuickQuoteService_AC:refreshQuickQuote:'+h);
	        return h;
	    }else{
	    	system.debug(LoggingLevel.DEBUG,'Exiting RefreshQuickQuoteService_AC:refreshQuickQuote:'+quickQuoteList);
	    	return quickQuoteList;
	    }
		
	}
	/*********************************************************************
    Purpose     : Private method to create JSON requset for refresh Quote Service
    Parameters  : HomeBaseBeans.QuickQuoteRefreshFormat
    Returns     : JSON string
    **********************************************************************/
	public String getQuickQuoteRefreshRequest(HomeBaseBeans.QuickQuoteRefreshFormat QQRF){
		system.debug(LoggingLevel.DEBUG,'Entering RefreshQuickQuoteService_AC :getQuickQuoteRefreshRequest'+QQRF );
		string branchId=null;
		String reqaddress='{}';
		//QuickQuoteMainService qqMainService=null; 
		if(QQRF!=null){
			//qqMainService=new QuickQuoteMainService();
		     //branchId=qqMainService.getuserBranchInfo(); 
			
			String branch='', branchname=''; 
			system.debug('-------QQRF.Transport-------'+QQRF.Transport);
			//if(QQRF.tyleofQuoute == 'Sales'){
		        //if(QQRF.Transport==null||QQRF.Transport=='' || QQRF.Transport == '0.00'){
				//	system.debug('-------QQRF.Transport-------'+QQRF.Transport);
				//	QQRF.Transport = '';
				//}	
				if(QQRF.Transport==null){
				system.debug('-------QQRF.Transport-------'+QQRF.Transport);
					QQRF.Transport = '';
				}	
			//} 
			//if(QQRF.Transport==null||QQRF.Transport==''){
			//	QQRF.Transport = '0.00';
			//}
				
			if(QQRF.Rate==null||QQRF.Rate=='')
			QQRF.Rate = '0.00';
			
			if(QQRF.state==null || QQRF.state=='null')
			{
				QQRF.state = '';
			}
			 if(QQRF.modificationCharge==null ){
                           QQRF.modificationCharge='';
			}
			if(QQRF.ecode == '' || QQRF.ecode == '--None--'){
				QQRF.ecode = null;
			}
			
			branch = QQRF.BranchId;
			String dateval = '';
			if(QQRF.Devzone==null)
			QQRF.Devzone='';
			
			if(QQRF.PrDate!=null)
			{
				dateval = QQRF.prdate.year()+'-'+QQRF.prdate.month()+'-'+QQRF.prdate.day();
			}
			
			/*reqaddress	= '{'+
					    '"quickQuote": {'+
					        '"duration": '+QQRF.Duration+','+
					        '"lead": "'+QQRF.LeadOppName+'",'+
					       '"transport": "'+QQRF.Transport+'",'+
					        '"transactionId": "'+QQRF.TransactionType+'",'+
					        '"rate": '+QQRF.Rate+','+
					        '"modificationCharge": "'+QQRF.modificationCharge+'",'+
					       '"dateFrom": '+dateval+','+
					        '"shippingAddress": {'+
					            '"state": "'+QQRF.State+'",'+
					            '"countryId": "'+QQRF.Country+'",'+
					            '"address1": "'+QQRF.Address+'",'+
					            '"address2": "",'+
					            '"address3": "'+QQRF.City+'",'+
					            '"address4": "",'+
					            '"zipCode": "'+QQRF.zipcode+'",'+
					            '"taxId": "'+QQRF.TaxId+'",'+
					          '"deliveryZone": "'+QQRF.Devzone+'",'+
					            '"fulfillingBranchId": "'+QQRF.FulfillingBranch+'",'+
					            '"fulfillingBranchName": "'+branchname+'"'+
					           '},'+
					       // '"accountId": "G101251",'+
					        '"productId": "'+QQRF.Product+'",'+
					        '"ecode": '+QQRF.ecode+','+
					        '"branchId": '+branch+','+
					        '"includeLLW": '+QQRF.isIncludeLLW+','+
					        '"fuelSurcharge": '+QQRF.isFuelSurcharge+','+
					        '"locksQty": '+QQRF.Locks+','+
					      '"companyId": 1,'+
					        '"operatorId": "result",'+
					    //  '"salesRep": "'+QuickQuoteMainDAO.getUserBranchDetails().Sales_Rep_Id__c+'"'+
					       '"salesRep": "101984"'+
					    '}'+
					'}';*/	
					
					RefreshQQRequest RQrequest=new RefreshQQRequest();
					
					QuickQuoteWrap qqWrap=new QuickQuoteWrap();
					
					qqWrap.duration=QQRF.Duration;
					qqWrap.lead=QQRF.LeadOppName;
					qqWrap.transport=QQRF.Transport;
					qqWrap.transactionId=QQRF.TransactionType;
					qqWrap.rate=QQRF.Rate;
					qqWrap.modificationCharge=QQRF.modificationCharge;
					qqWrap.dateFrom=dateval;
					qqWrap.productId=QQRF.Product;
					qqWrap.ecode=QQRF.ecode;
					qqWrap.branchId=branch;
					qqWrap.includeLLW=QQRF.isIncludeLLW;
					qqWrap.fuelSurcharge=QQRF.isFuelSurcharge;
					qqWrap.locksQty=QQRF.Locks;
					qqWrap.companyId='1';
					qqWrap.operatorId='result';
					qqWrap.salesRep=QuickQuoteMainDAO.getUserBranchDetails().Sales_Rep_Id__c;
					
					Address address=new Address();
					address.state=QQRF.State;
					address.countryId=QQRF.Country;
					address.address1=QQRF.Address;
					address.address2='';
					address.address3=QQRF.City;
					address.address4='';
					address.zipCode=QQRF.zipcode;
					address.taxId=QQRF.TaxId;
					address.deliveryZone=QQRF.Devzone;
					address.fulfillingBranchId=QQRF.FulfillingBranch;
					address.fulfillingBranchName=branchname;
					
					qqWrap.shippingAddress=address;
					
					RQrequest.quickQuote=qqWrap;
	
				 reqaddress = JSON.serialize(RQrequest);
					
		}
			system.debug(LoggingLevel.DEBUG,'Exiting RefreshQuickQuoteService_AC :getQuickQuoteRefreshRequest'+reqaddress);
			
			return reqaddress;
	}

	
	
	
	public class RefreshQQRequest {
       public QuickQuoteWrap quickQuote;
	}
	
	public class QuickQuoteWrap {
		    public Integer duration;
			public String lead;
			public String transport;
			public String transactionId;
			public String rate;
			public String modificationCharge;
			public String dateFrom;
			public Address shippingAddress;
			public String productId;
			public String ecode;
			public String branchId;
			public boolean includeLLW;
			public boolean fuelSurcharge;
			public Integer locksQty;
			public String companyId;
			public String operatorId;
			public String salesRep;
			
	    }
	
	public class Address {
		    public String state;
			public String countryId;
			public String address1;
			public String address2;
			public String address3;
			public String address4;
			public String zipCode;
			public String taxId;
			public String deliveryZone;
			public String fulfillingBranchId;
			public String fulfillingBranchName;
	    }

	// Test method
}