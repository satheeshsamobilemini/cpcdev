/**************************************************************************
Name:  QuickQuoteEditService_AC()
Copyright © 2013  MMI
----------------------------------------------------------------------
Purpose:
This class contains the methods for Edit Quick Quote Service HTTP Rest 
web service Callouts 
-----------------------------------------------------------------------
History:

VERSION  AUTHOR                 DATE        DETAIL              
1.0  -  TEKsystems             11/2/2013   INITIAL DEVELOPMENT  
**************************************************************************/
public with sharing class QuickQuoteEditService_AC 
{   

	public static String qqEditResponse {get;set;}
	
	/*********************************************************************
    Purpose     : To get the quick quote info to edit
    Parameters  : user quote id 
    Returns     : JSON string type
    **********************************************************************/   
	public static string getQuickQuoteDetails(String quoteId)
		{
		system.debug(LoggingLevel.DEBUG,'Entering QuickQuoteEditService_AC:getQuickQuoteDetails:'+quoteId);
    	ServiceProxy serviceProxy=null;
    	QuickQuoteMainService qqMainService=null; 
    	List<HomeBaseBeans.webAddresses> HBList=null;
    	
    	//String qqEditResponse=null;
    	
    	try{   
	    	if(quoteId!=null){
		        serviceProxy = new ServiceProxy(); 
		        qqMainService=new QuickQuoteMainService();
		        if(!Test.isRunningTest()){
		        
		        	  qqEditResponse = serviceProxy.callRestService('rest/api/v1/quick_quotes/'+quoteId, 'GET', null);
		        		
		        	} 
		        }
		        if(!qqEditResponse.contains('"errorCode"'))
				{
			              String ss = qqEditResponse.substring(1, qqEditResponse.length()-1);
			              ss = ss.replace('shippingAddress', 'shippingAddress3');
			              qqEditResponse = ss.replace('"quickQuote":', '');      
				}
				else
				{
					String errorMessage = QuickQuoteErrorHandler.handleError(qqEditResponse);
					ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,errorMessage);
                    ApexPages.addMessage(msg);
					return null;		
				}
	    	
	    }catch(Exception e){
			system.debug(LoggingLevel.ERROR,'Error while getting values from QuickQuoteEditService_AC:getQuickQuoteDetails'+e.getMessage());
			return null;
	    }
	   
	    	system.debug(LoggingLevel.DEBUG,'Exiting QuickQuoteEditService_AC:getQuickQuoteDetails'+qqEditResponse);
	        return qqEditResponse;
	 
		}
		
}