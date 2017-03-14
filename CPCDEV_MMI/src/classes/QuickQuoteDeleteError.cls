public with sharing class QuickQuoteDeleteError {
	public Boolean isError{get;set;}
	public Boolean isNoError{get;set;}
	public String quoteid{get;set;}
	public QuickQuoteDeleteError(ApexPages.StandardController stdController){
	}
	public void deleteQuote(){
		isError = false;
		isNoError = false;
		String profileId = UserInfo.getProfileId();
		Profile profileName = [Select Name from Profile where Id = :profileId limit 1];
		quoteid = System.currentPageReference().getParameters().get('id');
		MMI_Quotes__c fullQuote = [Select id From MMI_Quotes__c  where id = :quoteid limit 1];
		if(profileName.Name == 'System Administrator'){
			isError = true;
			isNoError = false;
			delete fullQuote;
			//pageReference pf = new pageReference('/006/o');
			//return pf;
		}else{
			isNoError = true;
			isError = false;
		}
		
	}

}