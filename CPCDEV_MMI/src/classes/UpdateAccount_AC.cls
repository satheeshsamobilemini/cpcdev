public with sharing class UpdateAccount_AC {
	public String responseJSON{get;set;}
	public parseChangeAccResponse changeAccountNo(String QuoteNo, String newAccId, String LoggedInUserId){
		ServiceProxy servicePro = new ServiceProxy();
		String Payload = '{"customerQuote":{"companyNo":1,"quoteNo":'+QuoteNo+',"accountId":"'+newAccId+'","recalculatePrices":true,"overrideAddresses":false}}';
		if(!Test.isRunningTest()){
		responseJSON = servicePro.callRestService('rest/api/v1/companies/1/quotes?login_id='+LoggedInUserId,'POST',Payload);
		}
		
		if(responseJSON != null && !responseJSON.contains('"errorCode"')){
			 parseChangeAccResponse AccUpdateResponse = new parseChangeAccResponse();
			 if(!Test.isRunningTest()){
			 AccUpdateResponse = (parseChangeAccResponse)JSON.deserialize(responseJSON, UpdateAccount_AC.parseChangeAccResponse.class);
			 }
			 return AccUpdateResponse;
		}else{
			String errorMessage = QuickQuoteErrorHandler.handleError(responseJSON);
			parseChangeAccResponse AccUpdateResponseError = new parseChangeAccResponse();
			AccUpdateResponseError.errorMessage = errorMessage;
			return AccUpdateResponseError;
		}
	}
	
	public class parseChangeAccResponse{
		public String errorMessage {get;set;}
        public String responseMessage {get;set;}
	}
	
}