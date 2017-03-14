public with sharing class QuoteToOrderService_AC 
{
	
	public String quoteToOrderResponse {get;set;}
	
	public QuoteToOrderParser_AC callQuoteToOrder(String docId,String mobilization,String salesRep,String QuoteType)
	{
		system.debug(LoggingLevel.DEBUG,'Entering QuoteToOrderService_AC :callQuoteToOrder' );
		ServiceProxy servicePro=null;
		QuoteToOrderParser_AC QTOResonse=null;
		
		try{
			servicePro = new ServiceProxy();
			QTOResonse = new QuoteToOrderParser_AC();
			if(!Test.isRunningTest()){
			quoteToOrderResponse = servicePro.callRestService('/rest/api/v1/companies/1/quotes/convert_to_order?type='+QuoteType.toLowerCase()+'&rep='+salesRep+'&quoteId='+docId+'&mobilization='+mobilization,'POST','');
			}
			if(quoteToOrderResponse!=null && !quoteToOrderResponse.contains('"errorCode"'))
			{
			    QTOResonse = QTOResonse.parseResponse(quoteToOrderResponse); 
			}
			else
			{
				
				 String errorMessage = QuickQuoteErrorHandler.handleError(quoteToOrderResponse);
			     System.debug('****** quote to order error response '+errorMessage);
			     QTOResonse.orderErrorMsg=errorMessage;
			}
			
				
			System.debug(QTOResonse+'****** create quote response '+quoteToOrderResponse);
			
		
		}catch(Exception e){
			system.debug(LoggingLevel.ERROR,'Error while getting values from QuoteToOrderService_AC callQuoteToOrder'+e.getMessage());
		}
		system.debug(LoggingLevel.DEBUG,'Exiting QuoteToOrderService_AC :callQuoteToOrder'+QTOResonse);
		return QTOResonse;
	}
	
}