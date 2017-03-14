public with sharing class FullQuoteEdit_AC 
{
	String fullQuoteId = '';
	MMI_Full_Quotes__c MMIFQ = new MMI_Full_Quotes__c();
	public FullQuoteEdit_AC(ApexPages.StandardController controller)
	{
		MMIFQ = (MMI_Full_Quotes__c)controller.getRecord();
		fullQuoteId = [select Quote_Id__c from MMI_Full_Quotes__c where id=: MMIFQ.id limit 1].Quote_Id__c;
		
		
	}  
	
	public pageReference gotoEdit()
	{
		pageReference pf = new pageReference('/apex/FullQuoteForm_VF?fullQUoteId='+fullQuoteId);
		return pf;
	}
	public pageReference gotoClone()
	{
		pageReference pf = new pageReference('/apex/FullQuoteForm_VF?fullQUoteId='+fullQuoteId+'&clone=true');
		return pf;
	} 
}