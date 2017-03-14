public with sharing class AccContactService {
	
	public String ContactListResponse {get;set;}
	public String SpecificContactResponse {get;set;}
	public String AddContactResponse {get;set;}
	public String UpdateContactResponse {get;set;}
	
	public List<HomeBaseBeans.ListContact> listContacts(String branchId, String AccountNo)
	{
		ServiceProxy servicePro =null; 
    	List<HomeBaseBeans.ListContact> contList = null;
		
		try{	
			servicePro = new ServiceProxy();
			if(!test.isRunningTest()){
				//ContactListResponse = servicePro.callRestService('rest/api/v1/accounts/'+AccountNo+'/contacts?company_id=1&branch_id='+branchId,'GET','');
				ContactListResponse = servicePro.callRestService('rest/api/v1/accounts/'+AccountNo+'/contacts?company_id=1','GET','');
			}else{
				ContactListResponse = '{"contactSummaryList":[{"contactId":"7","forename":"Matt","surname":"Smith"},{"contactId":"8","forename":"DON","surname":"Brown"}{"contactId":"9","forename":"Matt","surname":"Smith"},{"contactId":"10","forename":"DON","surname":"Brown"}]}';
			}
			System.debug('******ContactListResponse************'+ContactListResponse);
			if(!ContactListResponse.contains('"errorCode"'))
			{				
				DeserializeContList contactDataList = (DeserializeContList)JSON.deserialize(ContactListResponse, DeserializeContList.class);
				System.debug('---------------contactSummaryList-------------------'+contactDataList.contactSummaryList);
				
				return contactDataList.contactSummaryList;
			}
			else
			{ 
				contList = new List<HomeBaseBeans.ListContact>();
				HomeBaseBeans.ListContact h = new HomeBaseBeans.ListContact();
				String errorMessage = QuickQuoteErrorHandler.handleError(ContactListResponse);
				h.errorMessage = errorMessage;
				contList.add(h); 
				return contList;
	        }
			
		}
		catch(Exception e)
		{
			System.debug('***** response error '+e);
			String errorMessage = e.getMessage();
			contList = new List<HomeBaseBeans.ListContact>();
			HomeBaseBeans.ListContact h = new HomeBaseBeans.ListContact();
			h.errorMessage = errorMessage;
			contList.add(h); 
			return contList;
		}
		
				
	}
	
	 public class DeserializeContList
    {
    	public List<HomeBaseBeans.ListContact> contactSummaryList;
    	
    	public DeserializeContList()
    	{
    		contactSummaryList = new List<HomeBaseBeans.ListContact>();
    	}
    }
    
    public List<HomeBaseBeans.SpecificContact> SpecificContacts(String contactId, String AccountNo)
	{
		ServiceProxy servicePro = null; 
    	List<HomeBaseBeans.SpecificContact> specCont = null;
		
		try{	
			servicePro = new ServiceProxy();
			if(!test.isRunningTest()){
				SpecificContactResponse = servicePro.callRestService('rest/api/v1/accounts/'+AccountNo+'/contacts/'+contactId+'?company_id=1','GET','');
			}else{
				SpecificContactResponse = '{"contact":{"contactId":"18","salutation":"","forename":"Matt","surname":"Smith","phoneNumber":"2053284000","email":"mike.clark@rentalresult.com","position":"","cellMobile":"","contactStatus":"A","contactStatusDescription":"ACTIVE","contactTypeId":"unknown","contactTypeDescription":"unknown","mainContact":false,"phoneExtension":"","faxNumber":"205450515","companyNumber":1,"companyName":"Mobile MiniUSA","salesPersonId":"","salesPersonName":"","branchId":"","branchName":""}}';
			}
			System.debug('******SpecificContactResponse************'+SpecificContactResponse);
			if(!SpecificContactResponse.contains('"errorCode"'))
			{				
				DeserializeSpecificContact SpecificContactData = (DeserializeSpecificContact)JSON.deserialize(SpecificContactResponse, DeserializeSpecificContact.class);
				System.debug('---------------contact-------------------'+SpecificContactData.contact);
				specCont = new List<HomeBaseBeans.SpecificContact>();
				specCont.add(SpecificContactData.contact);
				return specCont;
			}
			else
			{ 
				specCont = new List<HomeBaseBeans.SpecificContact>();
				HomeBaseBeans.SpecificContact h = new HomeBaseBeans.SpecificContact();
				String errorMessage = QuickQuoteErrorHandler.handleError(SpecificContactResponse);
				h.errorMessage = errorMessage;
				specCont.add(h); 
				return specCont;
	        }
			
		}
		catch(Exception e)
		{
			System.debug('***** response error '+e);
			String errorMessage = e.getMessage();
			specCont = new List<HomeBaseBeans.SpecificContact>();
			HomeBaseBeans.SpecificContact h = new HomeBaseBeans.SpecificContact();
			h.errorMessage = errorMessage;
			specCont.add(h); 
			return specCont;
		}
		
				
	}
	
	 public class DeserializeSpecificContact
    {
    	public HomeBaseBeans.SpecificContact contact;
    	
    	public DeserializeSpecificContact()
    	{
    		contact = new HomeBaseBeans.SpecificContact();
    	}
    }
    
    public List<HomeBaseBeans.AddContact> AddContacts(String branchId, String AccountNo, String Payload, String Operation)
	{
		ServiceProxy servicePro = null; 
    	List<HomeBaseBeans.AddContact> newCont = null;
		
		try{	
			servicePro = new ServiceProxy();
			if(Operation == 'add'){
				if(!test.isRunningTest()){
					AddContactResponse = servicePro.callRestService('rest/api/v1/accounts/'+AccountNo+'/contacts?company_id=1&login_id=result&login_branch='+branchId,'POST',Payload);
				}else{
					AddContactResponse = '{"newContactId":"32"}';
				}
			}
			if(Operation == 'update'){
				if(!test.isRunningTest()){
				AddContactResponse = servicePro.callRestService('rest/api/v1/accounts/'+AccountNo+'/contacts?company_id=1&login_id=result&login_branch='+branchId,'PUT',Payload);
				}else{
					AddContactResponse = '{"newContactId":"Updated"}';
				}
			}
			System.debug('******AddContactResponse************'+AddContactResponse);
			if(!AddContactResponse.contains('"errorCode"'))
			{				
				DeserializeNewContact newContactData = (DeserializeNewContact)JSON.deserialize(AddContactResponse, DeserializeNewContact.class);
				System.debug('---------------newContactId-------------------'+newContactData.newContactId);
				
				newCont = new List<HomeBaseBeans.AddContact>();
				HomeBaseBeans.AddContact nc = new HomeBaseBeans.AddContact();
				nc.newContactId = newContactData.newContactId;
				newCont.add(nc); 
				return newCont;
			}
			else
			{ 
				newCont = new List<HomeBaseBeans.AddContact>();
				HomeBaseBeans.AddContact h = new HomeBaseBeans.AddContact();
				String errorMessage = QuickQuoteErrorHandler.handleError(AddContactResponse);
				h.errorMessage = errorMessage;
				newCont.add(h); 
				return newCont;
	        }
			
		}
		catch(Exception e)
		{
			System.debug('***** response error '+e);
			String errorMessage = e.getMessage();
			newCont = new List<HomeBaseBeans.AddContact>();
			HomeBaseBeans.AddContact h = new HomeBaseBeans.AddContact();
			h.errorMessage = errorMessage;
			newCont.add(h); 
			return newCont;
		}
	}
    
    public class DeserializeNewContact
    {
    	public String newContactId {get;set;}
    	
    }
    
}