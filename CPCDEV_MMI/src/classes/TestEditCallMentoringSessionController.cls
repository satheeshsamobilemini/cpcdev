/**
 * Test class for EditCallMentoringSessionController
 */
@isTest
private class TestEditCallMentoringSessionController {
	
	static testMethod void testBranchSaveNew() {
       List<RecordType> rtps = [Select r.Name, r.Id From RecordType r where Name in ('Branch Coaching Session','Personal Coaching Session')];	
       ApexPages.currentPage().getParameters().put('Edit','1');
	   ApexPages.currentPage().getParameters().put('clone','0');
	   ApexPages.currentPage().getParameters().put('retURL','/home/home.jsp');
	   if(rtps != null && rtps.size() > 0){
	   	ApexPages.currentPage().getParameters().put('RecordType',rtps.get(0).id);
	   }
	   Call_Mentoring_Session__c cms = new Call_Mentoring_Session__c();
	   insert cms;
	   EditCallMentoringSessionController editCallMentoring = new EditCallMentoringSessionController(new ApexPages.Standardcontroller(cms));
	   PageReference resultPage = editCallMentoring.CallEditPage();
	   Apexpages.currentPage().getParameters().put('ID',resultPage.getParameters().get('ID'));
	   
	   CallMentoringSessionController nextController = new CallMentoringSessionController(new ApexPages.Standardcontroller(cms));
	   nextController.callMentoringSession.Area_Of_Strength__c = 'test';
	   nextController.callMentoringSession.Type_of_Call__c = 'IB';
	   nextController.saveDataNew();
	   List<Call_Mentoring_Session__c> cmsList = [select Id, Type_of_Call__c,Area_Of_Strength__c from  Call_Mentoring_Session__c where id =: nextController.callMentoringSession.id];
		if(cmsList.size() > 0){
			System.assertEquals(cmsList.get(0).Area_Of_Strength__c, 'test');
		}
		//test case for Edit page of Personal Coaching Session
	   if(rtps != null && rtps.size() > 1){
	   	ApexPages.currentPage().getParameters().put('RecordType',rtps.get(1).id);
	    cms = new Call_Mentoring_Session__c();
	    editCallMentoring = new EditCallMentoringSessionController(new ApexPages.Standardcontroller(cms));
	    resultPage = editCallMentoring.CallEditPage();
	   }
	   
    }
    
    static testMethod void testPersonalSaveNew() {
       List<RecordType> rtps = [Select r.Name, r.Id From RecordType r where Name in ('Branch Coaching Session','Personal Coaching Session')];	
       ApexPages.currentPage().getParameters().put('Edit','1');
	   ApexPages.currentPage().getParameters().put('clone','0');
	   ApexPages.currentPage().getParameters().put('retURL','/home/home.jsp');
	   if(rtps != null && rtps.size() > 0){
	   	ApexPages.currentPage().getParameters().put('RecordType',rtps.get(1).id);
	   }
	   Call_Mentoring_Session__c cms = new Call_Mentoring_Session__c();
	   insert cms;
	   EditCallMentoringSessionController editCallMentoring = new EditCallMentoringSessionController(new ApexPages.Standardcontroller(cms));
	   PageReference resultPage = editCallMentoring.CallEditPage();
       Apexpages.currentPage().getParameters().put('ID',resultPage.getParameters().get('ID'));
	   
	   PersonalCallMentoringSessionController nextController = new PersonalCallMentoringSessionController(new ApexPages.Standardcontroller(cms));
	   nextController.callMentoringSession.Type_of_Training_Mentoring__c = 'Action Plan';
	   nextController.saveDataNew();
       PageReference saveMethod = nextController.saveData();
       PageReference cancelMethod = nextController.cancelEdit();
       PageReference nullMethod = nextController.nullAction();
	   List<Call_Mentoring_Session__c> cmsList = [select Id, Type_of_Call__c,Type_of_Training_Mentoring__c from  Call_Mentoring_Session__c where id =: nextController.callMentoringSession.id];
	  if(cmsList.size() > 0){
			System.assertEquals(cmsList.get(0).Type_of_Training_Mentoring__c, 'Action Plan');
		}
		
	   
	   
    }
     
    static testMethod void testCancelEdit() {
       List<RecordType> rtps = [Select r.Name, r.Id From RecordType r where Name = 'Branch Call Mentoring Session'];	
       ApexPages.currentPage().getParameters().put('Edit','1');
	   ApexPages.currentPage().getParameters().put('clone','0');
	   ApexPages.currentPage().getParameters().put('retURL','/home/home.jsp');
	   if(rtps != null && rtps.size() > 0){
	   	ApexPages.currentPage().getParameters().put('RecordType',rtps.get(0).id);
	   }
	   Call_Mentoring_Session__c cms = new Call_Mentoring_Session__c();
	   insert cms;
	   EditCallMentoringSessionController editCallMentoring = new EditCallMentoringSessionController(new ApexPages.Standardcontroller(cms));
	   PageReference resultPage = editCallMentoring.CallEditPage();
	   Apexpages.currentPage().getParameters().put('ID',resultPage.getParameters().get('ID'));
	   
	   AdvancedCallMentoringSessionController nextController = new AdvancedCallMentoringSessionController(new ApexPages.Standardcontroller(cms));
	   nextController.callMentoringSession.Area_Of_Strength__c = 'test';
	   nextController.callMentoringSession.Type_of_Call__c = 'IB';
	   nextController.CancelEdit();
	   
	   
    }
}