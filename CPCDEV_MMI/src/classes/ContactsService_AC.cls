/*
* @author : TekSystems
* @date : 02/19/2013
* @developed by : Chiranjeevi
* @description  : get all contacts
*/

public with sharing class ContactsService_AC {
	
	public String contactsResponse {get;set;}
	
	public List<HomeBaseBeans.contactSummaryList> listContacts (String accountId)
	{
		system.debug('------accountId--------'+accountId);
		ServiceProxy servicePro = new ServiceProxy();
				
		if(!Test.isRunningTest())
		contactsResponse = servicePro.callRestService('rest/api/v1/accounts/'+accountId+'/contacts?company_id=1','GET','');
		
		try
		{
			if(contactsResponse != null && !contactsResponse.contains('"errorCode"'))
			{	
				countryListClass allContacts = (countryListClass)JSON.deserialize(contactsResponse, countryListClass.class);
				system.debug('---allContacts.contactSummaryList----'+allContacts.contactSummaryList);
				return allContacts.contactSummaryList;
				
			}
			else
			{
				List<HomeBaseBeans.contactSummaryList> HBList = new List<HomeBaseBeans.contactSummaryList>();
				HomeBaseBeans.contactSummaryList h = new HomeBaseBeans.contactSummaryList();
				
				String errorMessage = QuickQuoteErrorHandler.handleError(contactsResponse);
				h.errorMessage = errorMessage;				
				HBList.add(h);
				system.debug('--HBList----'+HBList);
				
				return HBList;
				}	
		}
		catch(Exception e)
		{
			String errorMessage = e.getMessage();
			List<HomeBaseBeans.contactSummaryList> HBList = new List<HomeBaseBeans.contactSummaryList>();
			HomeBaseBeans.contactSummaryList h = new HomeBaseBeans.contactSummaryList();
			h.errorMessage = errorMessage;
			
			HBList.add(h);
			system.debug('--HBList----'+HBList);
			return HBList;
		}
	}
	
	public class countryListClass
	{
		public HomeBaseBeans.contactSummaryList[] contactSummaryList;
		public countryListClass()
		{
			this.contactSummaryList = new List<HomeBaseBeans.contactSummaryList>();
		}
	}
	
	// Test method
	
	
}