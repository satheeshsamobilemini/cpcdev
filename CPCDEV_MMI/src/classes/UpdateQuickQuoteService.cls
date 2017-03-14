/**************************************************************************
Name:  UpdateQuickQuoteService()
Copyright © 2013  MMI
----------------------------------------------------------------------
Purpose:
This class contains the methods for Update Quick Quote HTTP Rest web service Callouts 
-----------------------------------------------------------------------
History:

VERSION  AUTHOR                 DATE        DETAIL              
1.0  -  TEKsystems             15/3/2013   INITIAL DEVELOPMENT  
**************************************************************************/
public with sharing class UpdateQuickQuoteService {
	
    public String updateQuoteResponse {get;set;}
    
	/*********************************************************************
    Purpose     : to call the update quick quote service 
    Parameters  : QuoteId,QQCR
    Returns     : boolean 
    **********************************************************************/
	public string updateQuickQuote(String QuoteId, String QQCR)
	{
		system.debug(LoggingLevel.DEBUG,'Entering UpdateQuickQuoteService:updateQuickQuote:'+QuoteId +'--'+QQCR);
		ServiceProxy servicePro=null;
		string updateMsg=null;	
		try{
		    servicePro = new ServiceProxy();		
		    if(!Test.isRunningTest()){
		        updateQuoteResponse = servicePro.callRestService('rest/api/v1/quick_quotes/'+QuoteId,'PUT',QQCR);
		    }
			if(!updateQuoteResponse.contains('"errorCode"'))
			{	
				updateMsg='success';
			}else{
			  updateMsg = QuickQuoteErrorHandler.handleError(updateQuoteResponse);	
			}
		}
		catch(Exception e){ 
           system.debug(LoggingLevel.ERROR,'Error when initiating the UpdateQuickQuoteService:updateQuickQuote():'+e.getMessage());
		}
		system.debug(LoggingLevel.DEBUG,'Exiting UpdateQuickQuoteService:updateQuickQuote:'+updateMsg);
		return updateMsg;
	}

		    
}