/**************************************************************************
Name:  ServiceProxy()
Copyright © 2013  MMI
----------------------------------------------------------------------
Purpose:
This class contains the methods for HTTP Rest web service Callouts 
-----------------------------------------------------------------------
History:

VERSION  AUTHOR                 DATE        DETAIL              
1.0  -  TEKsystems             11/2/2013   INITIAL DEVELOPMENT  
**************************************************************************/
public with sharing class ServiceProxy 
{

		
	/*********************************************************************
    Purpose     : To initiate the the HTTP request 
    Parameters  : endPoint- Target endpoint of the service
                  methodName- HTTP method to be used 
                  requestBody - JSON Body to be sent in request
    Returns     : String in JSON format containing the response from
                  the HTTP service
    **********************************************************************/
	public string callRestService(String endPointURL, String methodName, String requestBody){
		system.debug(LoggingLevel.DEBUG,'Entering ServiceProxy:callRestService:'+requestBody);
		String response=null;
        List<MMI_Webservices_Config__c> mmiConfigList=null;
    
        Integer retry=0;
        Integer numberOfRetries=0;

		try { 
			if(endPointURL!=null && methodName!=null){
                if(MMI_Webservices_Config__c.getAll()!=null){
					mmiConfigList=MMI_Webservices_Config__c.getAll().Values();
					if(mmiConfigList!=null && !mmiConfigList.isEmpty()){
						retry=Integer.valueOf(mmiConfigList.get(0).Retry__c);	
				     }
                 }
                 response=initiateHTTPCall(endPointURL,methodName,requestBody);
                 system.debug('-----------response-------------------'+response); 
	      		 if(response!=null && response.contains('invalid_token')){
	      		 	Oauth_WebService.TestCallout();
	      		 	response=initiateHTTPCall(endPointURL,methodName,requestBody);
	      		 /*	while(numberOfRetries<retry){
                       response=initiateHTTPCall(endPointURL,methodName,requestBody);
	        	       if(response!=null&& !response.contains('invalid_token')){
			              break;
			           } 
	        	       numberOfRetries++;
    	            }*/
	      		 }
			}       		
		}catch(Exception e) {
            system.debug(LoggingLevel.ERROR,'Error when initiating the http Request in callRestService():'+e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG,'ServiceProxy:callRestService'+response);
        return response;    
	}
	
	private string initiateHTTPCall(String endPointURL, String methodName, String requestBody){

		system.debug(LoggingLevel.DEBUG,'Entering ServiceProxy:initiateHTTPCall:');
		String response=null;
		Http httpConnection=null;
        HttpRequest httpRequest=null; 
        HttpResponse httpResponse=null;
        List<MMI_Webservices_Config__c> mmiConfigList=null;
        Integer timeOut;
        String endPoint;
        String contentType;
        String authorizationHeader;
		try { 
			if(Test.isRunningTest()){
	      			response=MMITestDataProvider.getMMIInvalidTokenResponse();
	      		}
			if(endPointURL!=null && methodName!=null){
                if(MMI_Webservices_Config__c.getAll()!=null){
					mmiConfigList=MMI_Webservices_Config__c.getAll().Values();
					if(mmiConfigList!=null && !mmiConfigList.isEmpty()){
			            timeOut=Integer.valueOf(mmiConfigList.get(0).Time_Out__c);
						contentType=mmiConfigList.get(0).Content_Type__c;
						//authorizationHeader=mmiConfigList.get(0).Authorization_Header__c;
						endPoint=mmiConfigList.get(0).MMI_End_Point__c;
						//if(!endPoint.contains('25443')){
                	        authorizationHeader='Bearer'+' '+Oauth_WebService.accessToken;
                        /*}else{
                	        authorizationHeader=mmiConfigList.get(0).Authorization_Header__c;
                        }*/ 
		            }
                }
                
                //authorizationHeader='Bearer'+' '+Oauth_WebService.accessToken;
                system.debug('timeout'+timeOut+'  '+'contanttype'+contentType+'  '+'authorizationHeader'+authorizationHeader+'  '+'endPoint'+endPoint);
                if(!test.isRunningTest()){
					httpConnection=new Http();
				    httpResponse = new HttpResponse();
				    httpRequest= new HttpRequest();
				    httpRequest.setEndpoint(endPoint+endPointURL);
				    httpRequest.setMethod(methodName);
				    httpRequest.setTimeout(timeOut);
				    httpRequest.setHeader('Authorization', authorizationHeader);
			        httpRequest.setHeader('Content-Type',contentType);
				   // httpRequest = SecurityHeader.getHeader(httpRequest); // Request with all the headers
				    if(requestBody !='' && requestBody!=null)
				    {
				    	httpRequest.setBody(requestBody);
				    }
				            		
		      		httpResponse = httpConnection.send(httpRequest);
			    }
	      		if(httpResponse!=null){            		
	       		    response=httpResponse.getBody();
	       		    System.debug('web service response: '+response);
	       		    Integer wsStatusCode = httpResponse.getStatusCode();
	       		    if(wsStatusCode != 200 && !response.contains('invalid_token') && !response.contains('Invalid transaction Id -None-')){
	       		    	String FinalEndPoint = endPoint+endPointURL;
	       		    	createErrorHistory(FinalEndPoint,methodName, requestBody, response, wsStatusCode, null, null, null);
	       		    }
	      		}
			}       		
		}catch(Exception e) {
            system.debug(LoggingLevel.ERROR,'Error when initiating the http Request in initiateHTTPCall():'+e.getMessage());
             ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,e.getMessage());
             if(!(e.getMessage()).contains('You have uncommitted work pending')){
             	ApexPages.addMessage(msg);
             	system.debug('-------e.getMessage()--------------'+e.getMessage());
             	createErrorHistory(endPoint+endPointURL,null, null, null, null, e.getMessage(), e.getStackTraceString(), e.getLineNumber());
             	if(e.getMessage().contains('Unable to tunnel through proxy')){
             		system.debug('-------if-------------');
             		response = '{"userErrorMessage":"Rental Result Server is down.","errorCode":"401"}';
             		return response;  
             	}
             }
        }
        system.debug(LoggingLevel.DEBUG,'ServiceProxy:initiateHTTPCall'+response);
        return response;    
		
	}
	
	//@future
	public void createErrorHistory(String Endpoint, String wsMethod, String Payload, String responseBody, Integer wsStatusCode, String ErrorMsg, String ErrorStackTrace, Integer ErrorLine){
		WebServiceError__c wse = new WebServiceError__c();
			//String responseBody = wsRes.getBody();
			//wse.Application_Name__c = 
			//wse.Developer_Error_Message__c
			if(Endpoint != null){
				wse.End_Point_URL__c = Endpoint;
			}
			//Integer wsStatusCode = wsRes.getStatusCode();
			if(wsStatusCode != null){
				wse.HTTP_Status_Code__c = String.valueOf(wsStatusCode);
			}
			if(Payload != null && Payload != ''){
				wse.Payload__c = Payload;
			}
			if(responseBody != null && responseBody != ''){
				wse.Response_Body__c = responseBody;
			}
			//wse.Response_Header__c = wsRes.getHeader(pString);
			wse.Time_of_WS_Response__c = system.now();
			//wse.User_Error_Message__c
			//wse.WS_Call_Name__c
			if(wsMethod != null && wsMethod != ''){
				wse.WS_Method_Name__c = wsMethod;
			}
			
			if(ErrorMsg != null && ErrorMsg != ''){
				wse.Exception_Error_Message__c = ErrorMsg;
			}
			if(ErrorStackTrace != null && ErrorStackTrace != ''){
				wse.Exception_Stack_Trace__c = ErrorStackTrace;
			}
			if(ErrorLine != null){
				wse.Exception_Error_Line__c = String.valueOf(ErrorLine);
			}
			system.debug('-----------wse--------------'+wse);
			insert wse;
		
	}
	
}