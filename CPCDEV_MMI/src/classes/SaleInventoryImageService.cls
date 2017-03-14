public with sharing class SaleInventoryImageService {


 public blob callEditWEbservice(String uuid,String SecToken){
		//ServiceProxy servicePro = new ServiceProxy();
       // servicePro.callRestService('rest/api/v1/companies/1/external_documents/79d06061-bb4b-4ee1-a19c-6e28f595e06a','GET','');
        /*
             Http httpConnection=new Http(); 
			  HttpResponse  httpResponse = new HttpResponse();
			   HttpRequest httpRequest= new HttpRequest();
			    httpRequest.setEndpoint('https://rrrest.mobilemini.com:25443/rest/api/v1/companies/1/external_documents/'+uuid);
			    httpRequest.setMethod('GET');
			    httpRequest.setTimeout(30000);
			    httpRequest.setHeader('Authorization', 'Basic YXBpdXNlcjp0ZXN0');
		      //  httpRequest.setHeader('Content-Type',contentType);
			   // httpRequest = SecurityHeader.getHeader(httpRequest); // Request with all the headers
			
			            		
	      		httpResponse = httpConnection.send(httpRequest);

	      		          		
	          	Blob response=httpResponse.GetBodyAsBlob();
	       		 
	      		system.debug('%%%%%%%'+EncodingUtil.base64Encode(response));
	      		//EncodingUtil.base64decode(response);
	      		
	      		
	      		return response;*/
	      		
	      		
        List<MMI_Webservices_Config__c> mmiConfigList=null;
        Integer retry=0;
        Integer numberOfRetries=0;
        Blob response;
        HttpResponse httpResponse=null;

		try { 
                if(MMI_Webservices_Config__c.getAll()!=null){
					mmiConfigList=MMI_Webservices_Config__c.getAll().Values();
					if(mmiConfigList!=null && !mmiConfigList.isEmpty()){
						retry=Integer.valueOf(mmiConfigList.get(0).Retry__c);	
				     }
                 }
                  httpResponse = new HttpResponse();
	      		 Oauth_WebService.TestCallout();
	      		 httpResponse=initiateHTTPCall('docrep/repository?securitytoken='+SecToken+'&uuid='+uuid+'&job=get','GET');
	      		response= httpResponse.GetBodyAsBlob();	
		}catch(Exception e) {
            system.debug(LoggingLevel.ERROR,'Error when initiating the http Request in SaleInventoryImageService():'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'SaleInventoryImageService:callRestService'+response);
	      		return response;
	}
	
	
	private HttpResponse initiateHTTPCall(String endPointURL, String methodName){

		system.debug(LoggingLevel.DEBUG,'Entering SaleInventoryImageService:initiateHTTPCall:');
		String response=null;
		Http httpConnection=null;
        HttpRequest httpRequest=null; 
        HttpResponse httpResponse=null;
        List<MMI_Webservices_Config__c> mmiConfigList=null;
        Integer timeOut;
        String endPoint;
        String authorizationHeader;
		try { 
			httpConnection=new Http();
		    httpResponse = new HttpResponse();
		    httpRequest= new HttpRequest();
			if(Test.isRunningTest()){
	      			httpResponse=MMIFullquoteTestDataProvider.getHttpResponse();
	      		}
			if(endPointURL!=null && methodName!=null){
                if(MMI_Webservices_Config__c.getAll()!=null){
					mmiConfigList=MMI_Webservices_Config__c.getAll().Values();
					if(mmiConfigList!=null && !mmiConfigList.isEmpty()){
			            timeOut=Integer.valueOf(mmiConfigList.get(0).Time_Out__c);
						endPoint=mmiConfigList.get(0).SalableFleetEndPoint__c;
						if(!endPoint.contains('25443')){
                	        authorizationHeader='Bearer'+' '+Oauth_WebService.accessToken;
                        }else{
                	        authorizationHeader=mmiConfigList.get(0).Authorization_Header__c;
                        } 
		            }
                }

				
			    httpRequest.setEndpoint(endPoint+endPointURL);
			    httpRequest.setMethod(methodName);
			    httpRequest.setTimeout(timeOut);
			    httpRequest.setHeader('Authorization', authorizationHeader);
		     
	      		httpResponse = httpConnection.send(httpRequest);
			}       		
		}catch(Exception e) {
            system.debug(LoggingLevel.ERROR,'Error when initiating the http Request in initiateHTTPCall():'+e.getMessage());
             ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,e.getMessage());
             ApexPages.addMessage(msg);
        }
        system.debug(LoggingLevel.DEBUG,'SaleInventoryImageService:initiateHTTPCall'+httpResponse.getBody());
        return httpResponse;    
		
	}
	


}