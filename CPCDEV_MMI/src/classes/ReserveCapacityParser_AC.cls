public with sharing class ReserveCapacityParser_AC 
{
	String reserveCapacityResponse{get;set;}
	public String callReserveCapacity(Date shippingDate, String movementSlot, String documentId, String CompanyId, String Mobilization, string QuoteType)
	{
		ServiceProxy servicePro=null;
		try{
			servicePro = new ServiceProxy();
			String DateStr = String.valueOf(shippingDate.day());
			if(DateStr.length() < 2){
				DateStr = '0'+DateStr;
			}
			String MonthStr = String.valueOf(shippingDate.Month());
			if(MonthStr.length() < 2){
				MonthStr = '0'+MonthStr;
			}
			String dateString = shippingDate.year()+'-'+MonthStr+'-'+DateStr;   //US format
			//String dateString = shippingDate.year()+'-'+DateStr+'-'+MonthStr; // changed on 21 Oct 2013 (RR throwing error)
			reserveCapacityResponse = servicePro.callRestService('/rest/api/v1/reserve_capacity?shipping_date='+dateString+'&movement_slot='+movementSlot+'&quote=true&document_id='+documentId+'&company_id=1&mobilization='+Mobilization+'&type='+QuoteType.toLowerCase(),'POST','');
			System.debug('******************* reserve capacity is '+reserveCapacityResponse); 
			return reserveCapacityResponse;
		}
		catch(Exception e)
		{
			System.debug('*******************'+e); 
			return null;
		} 
	}
}