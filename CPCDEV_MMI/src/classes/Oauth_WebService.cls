/**************************************************************************
Name:  Oauth_WebService()
Copyright © 2013  MMI
----------------------------------------------------------------------
Purpose:
This class contains the methods for oauth2.0 Web service Security Implementation
For Quick Quote functionality.
-----------------------------------------------------------------------
History:

VERSION  AUTHOR                 DATE        DETAIL              
1.0  -  TEKsystems             15/5/2013   INITIAL DEVELOPMENT  
**************************************************************************/
public with sharing class Oauth_WebService {

	/*********************************************************************
    Purpose     : To make asynchronous Callout for oauth2.0
    Parameters  : none 
    Returns     : none
    **********************************************************************/
   // @future (callout=true)
   public static string accessToken;
   public static void TestCallout(){
        Bearer responseBr;
	    String endPointinit=null;
	    integer retry=0;
	    Integer numberOfRetries=0;
	    Boolean isSuccess=false;
	    Boolean isUpdated=false;
	    String brResponse ;
        List<MMI_Webservices_Config__c> mmiConfigList=null;
        String clientId =null;
        String clientSecret = null;
	    try{
	    	if(MMI_Webservices_Config__c.getAll()!=null){
				mmiConfigList=MMI_Webservices_Config__c.getAll().Values();
				if(mmiConfigList!=null && !mmiConfigList.isEmpty()){
					endPointinit=mmiConfigList.get(0).MMI_End_Point__c;	
					clientId=mmiConfigList.get(0).ClientId__c;	
					clientSecret=mmiConfigList.get(0).SecretId__c;
					retry=Integer.valueOf(mmiConfigList.get(0).Retry__c);
					
					//if(!endPointinit.contains('25443')){
						 while(numberOfRetries<retry){
				        	brResponse=oauthCall(endPointinit,clientId,clientSecret);
				        	if(brResponse!=null&& !brResponse.contains('error') && !brResponse.contains('errorCode') && !brResponse.contains('<html><body>')){
						       //Response obtained
						       isSuccess=true;
						       responseBr = (Bearer)JSON.deserialize(brResponse, Bearer.class);
				               system.debug('XXXXXXXXX'+responseBr);
						       break;
						    } 
				        	numberOfRetries++;
			    	     }
					     
					    if(isSuccess){
					    	system.debug('XXXXXXXXXisSuccess'+isSuccess);
					    	mmiConfigList.get(0).Authorization_Header__c='Bearer'+' '+responseBr.access_token;
					    	//update mmiConfigList;
					    	accessToken=responseBr.access_token;
					    	isUpdated=true;
					    
					    }
						
					//}
					
	            }
            }
            
           
		    
	    }catch(Exception e){
	    	system.debug(LoggingLevel.ERROR,'Error while calling Oauth_WebService TestCallout:'+e.getMessage());
	    	
	    }
	   
   }
   
   	/*********************************************************************
    Purpose     : To make HTTP callout
    Parameters  :String endpoint ,String clientId ,String clientSecret
    Returns     :String in JSON format
    **********************************************************************/
   private static string oauthCall(String endpointInit,String clientId,String clientSecret){
   	    Long timeStamp=0;
	    String assertion=null;
	    String endPoint=null;
    	timeStamp=generateTimeStamp();
  
	    assertion=createJtw(clientSecret,clientId,timeStamp);
	    system.debug('@@@@@@@Assertion : '+assertion);
	    endPoint=endpointInit+'/rest/api/oauth/token?grant_type=jwt-bearer&assertion='+EncodingUtil.urlEncode(assertion,'UTF-8');
   	    Http h = new Http();
	    HttpRequest req = new HttpRequest();
	    req.setMethod('POST');
	    req.setEndpoint(endPoint);
	    req.setHeader('Content-Type','application/x-www-form-urlencoded');
	    req.setHeader('SOAPAction',endPoint);
	    
	    if(Test.isRunningTest()){ 
               return  '{"access_token":"9b67dbee-dba5-4dcb-aa69-60f20fc1bf9d","token_type":"bearer","expires_in":3599,"scope":"read write"}';
        }else{
        	 HttpResponse res = h.send(req);
	         system.debug('--------'+res.getBody());
     	   return res.getBody();
	    }
   }
    /*********************************************************************
    Purpose     : To generate time stamp
    Parameters  :none
    Returns     :none
    **********************************************************************/
    private static long generateTimeStamp(){
       //long millis = (long) System.currentTimeMillis() ;
       //long sysTime = (long) (millis / 1000)+300;
       long sysTime = 1;
       return sysTime;
    }

    /*********************************************************************
    Purpose     : To generate Mac Signature for oauth Callout
    Parameters  :String secret,String clientId,long expiry
    Returns     :string
    **********************************************************************/
    private static String createJtw( String secret, String clientId, long expiry )
	{

      String auHeader='{'+'"'+'alg'+'"'+':'+'"'+'HS256'+'"'+'}';
	  String jsonClaims = '{'+'"'+'iss'+'"'+':'+clientId+','+'"'+'exp'+'"'+':'+expiry+'}';
	  Blob au=Blob.valueOf(auHeader);
	  String encodedAUHeader = EncodingUtil.base64Encode(au);
	  
	  system.debug('@@@@@@@@Header : '+encodedAUHeader);
	  
      Blob jClaim=Blob.valueOf(jsonClaims);
      String jClaimb=EncodingUtil.base64Encode(jClaim);
      system.debug('@@@@@@@@ json claim : '+jClaimb);
      
      String sec=EncodingUtil.base64Encode(Blob.valueOf(secret));
      Blob signc=Blob.valueOf(encodedAUHeader+'.'+jClaimb);
      
	  Blob mac = Crypto.generateMac('hmacSHA256',signc,Blob.valueOf(secret));

      system.debug('@@@@@@@@@ Base64Mac : '+EncodingUtil.base64Encode(mac));
       
      String macUrl =encodedAUHeader+'.'+jClaimb+'.'+EncodingUtil.base64Encode(mac);
          
      return macUrl;
       
       
	}
	
	public class Bearer{
		public String access_token;
		public String token_type;
		public String expires_in;
		public String scope;
		public String error;
		public String error_description;
		
	}

}