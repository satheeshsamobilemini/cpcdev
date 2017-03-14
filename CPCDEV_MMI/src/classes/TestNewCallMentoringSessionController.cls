/**
 * Test class for NewCallMentoringSessionController
 */
@isTest
private class TestNewCallMentoringSessionController {

    static testMethod void testNewCallMentoringSession() {
       List<RecordType> rtps = [Select r.Name, r.Id From RecordType r where Name in ('Branch Coaching Session','Personal Coaching Session')];	
       ApexPages.currentPage().getParameters().put('Edit','0');
	   ApexPages.currentPage().getParameters().put('clone','0');
	   ApexPages.currentPage().getParameters().put('retURL','/home/home.jsp');
	   //test case for New page of Branch Coaching Session
	   if(rtps != null && rtps.size() > 0){
	   	ApexPages.currentPage().getParameters().put('RecordType',rtps.get(0).id);
	   }
	   Call_Mentoring_Session__c cms = new Call_Mentoring_Session__c();
	   NewCallMentoringSessionController newCallMentoring = new NewCallMentoringSessionController(new ApexPages.Standardcontroller(cms));
	   PageReference resultPage = newCallMentoring.CallMentoringSessionPage();
	   Apexpages.currentPage().getParameters().put('RecordType',resultPage.getParameters().get('RecordType'));
	   
	   AdvancedCallMentoringSessionController nextController = new AdvancedCallMentoringSessionController(new ApexPages.Standardcontroller(cms));
	   nextController.callMentoringSession.Area_Of_Strength__c = 'test';
	   nextController.callMentoringSession.Type_of_Call__c = 'IB';
	   nextController.saveData();
	   System.assert(nextController.callMentoringSession.id != null);
	   //test case for New page of Personal Coaching Session
	   if(rtps != null && rtps.size() > 1){
	   	ApexPages.currentPage().getParameters().put('RecordType',rtps.get(1).id);
	    cms = new Call_Mentoring_Session__c();
	    newCallMentoring = new NewCallMentoringSessionController(new ApexPages.Standardcontroller(cms));
	    resultPage = newCallMentoring.CallMentoringSessionPage();
	    Apexpages.currentPage().getParameters().put('RecordType',resultPage.getParameters().get('RecordType'));	
	   	
	   }
	   
	   
    }
}