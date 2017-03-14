/***********************************************************************************************************
Created Date : 25th Feb 2011
Cretaed By : Vinod Kumar(Appirio OffShore)

Usage :Override the functionality of view standard button 

***********************************************************************************************************/
public class ViewCallMentoringController {
	String recordId;
	String retURL;
  	public ViewCallMentoringController(ApexPages.StandardController stdController){
		recordId = stdController.getId();
		retURL = ApexPages.currentPage().getParameters().get('retURL');
		if(retURL == null){
			retURL = '/home/home.jsp';  
		}
  	} 
  	public PageReference CallViewPage(){
  		Call_Mentoring_Session__c cms;
  		for(Call_Mentoring_Session__c cmsTemp : [Select c.RecordType.Name, c.RecordTypeId, c.Id From Call_Mentoring_Session__c c where c.id = : recordId ]){
			cms = cmsTemp;
		}
		String url= '';
		System.debug('---view---');
		if(cms != null){
			System.debug('---cms.RecordType.Name---'+cms.RecordType.Name);
			if(cms.RecordType.Name =='Branch Coaching Session'){
				// redirect to CallMentoringSessionView page					 			
				url  = '/apex/callMentoringSessionView?id='+cms.ID;
			}else if(cms.RecordType.Name == 'Personal Coaching Session') {
				// redirect to 	PersonalCallMentoringSession page
				url  = '/apex/PersonalCallMentoringSessionView?id='+cms.ID;
			}
			else if(cms.RecordType.Name == 'NSC Coaching Session'){
				// redirect to 	AdvancedCallMentoringSession page
				url  = '/apex/AdvancedCallMentoringSessionView?id='+cms.ID;
			}else if(cms.RecordType.Name == 'Inbound Coaching Session' ||cms.RecordType.Name == 'Outbound Coaching Session' || cms.RecordType.Name == 'Customer Care Coaching Session'){
				url = '/'+cms.ID + '?nooverride=1&retURL='+ retURL;
				
			}else{
				url = '/'+cms.ID + '?nooverride=1&retURL='+ retURL;
			}
			
		}
		else{
			url  = '/'+retURL;			
		}
		
		 return new PageReference(url);
	 }	
}