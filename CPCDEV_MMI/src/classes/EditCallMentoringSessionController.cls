/***********************************************************************************************************
Created Date : 25th Feb 2011
Cretaed By : Vinod Kumar(Appirio OffShore)

Usage :Override the functionality of edit standard button 

***********************************************************************************************************/
public with sharing class EditCallMentoringSessionController {
	String recordId;
	String retURL;
  	public EditCallMentoringSessionController(ApexPages.StandardController stdController){
		recordId = stdController.getId();
		retURL = ApexPages.currentPage().getParameters().get('retURL');
  	} 
  	public PageReference CallEditPage(){
  		Call_Mentoring_Session__c cms;
  		for(Call_Mentoring_Session__c  cmsTemp :[Select c.RecordType.Name, c.RecordTypeId, c.Id From Call_Mentoring_Session__c c where c.id = : recordId]){
  				cms = cmsTemp;
  		} 	
		String url= '';
		String keyPrefix = Schema.getGlobalDescribe().get('Call_Mentoring_Session__c').getDescribe().getKeyPrefix();
	 	
		if(cms != null){
			if(cms.RecordType.Name =='Branch Coaching Session'){
				// redirect to CallMentoringSession page				
				url  = '/apex/CallMentoringSession?retURL='+ retURL+'&ID='+cms.ID;
			}
			else if(cms.RecordType.Name == 'Personal Coaching Session') {
				// redirect to 	AdvancedCallMentoringSession page
				url  = '/apex/PersonalCallMentoringSession?retURL='+ retURL+'&ID='+cms.ID;
			}
			else if(cms.RecordType.Name == 'NSC Coaching Session'){
				// redirect to 	AdvancedCallMentoringSession page
				url  = '/apex/AdvancedCallMentoringSession?retURL='+ retURL+'&ID='+cms.ID;
			}else if(cms.RecordType.Name == 'Inbound Coaching Session' ||cms.RecordType.Name == 'Outbound Coaching Session' || cms.RecordType.Name == 'Customer Care Coaching Session'){
				url = '/'+keyPrefix + '/e?nooverride=1&retURL='+ retURL+'&id='+cms.ID+'&RecordType='+cms.RecordTypeId;
				
			}else{
				url = '/'+keyPrefix + '/e?nooverride=1&retURL='+ retURL+'&id='+cms.ID;
			}
		}
		else{
			url  = '/'+retURL;			
		}
		
		 return new PageReference(url);
	 }	
}