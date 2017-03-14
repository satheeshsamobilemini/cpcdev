/**
 * Test Class for CallMentoringSessionViewController
 */
@isTest
private class TestCallMentoringSessionViewController {
	
	static testMethod void testCallMentoringSessionView() {
		Call_Mentoring_Session__c cms = new Call_Mentoring_Session__c();
		cms.Type_of_Call__c = 'IB';
		insert cms;
		CallMentoringSessionViewController cmsvController = new CallMentoringSessionViewController(new ApexPages.Standardcontroller(cms));
		System.assertEquals(cmsvController.callMentoringSession.Type_of_Call__c,'IB');
		
		PageReference resultPage = cmsvController.editData();
	    Apexpages.currentPage().getParameters().put('RecordType',resultPage.getParameters().get('RecordType'));
	   
	    CallMentoringSessionController nextController = new CallMentoringSessionController(new ApexPages.Standardcontroller(cms));
	    nextController.callMentoringSession.Area_Of_Strength__c = 'test';
	    nextController.saveData();
		List<Call_Mentoring_Session__c> cmsList = [select Id, Type_of_Call__c,Area_Of_Strength__c from  Call_Mentoring_Session__c where id =: cms.id];
		if(cmsList.size() > 0){
			System.assertEquals(cmsList.get(0).Area_Of_Strength__c, 'test');
		}
		cmsvController.cloneData();
		cmsvController.deleteData();
        cmsvController.newMyCall();
        cmsvController.newTask();
	}
	
	static testMethod void testCallMentoringSessionClone() {
		Call_Mentoring_Session__c cms = new Call_Mentoring_Session__c();
		cms.Type_of_Call__c = 'IB';
		insert cms;
		CallMentoringSessionViewController cmsvController = new CallMentoringSessionViewController(new ApexPages.Standardcontroller(cms));
		System.assertEquals(cmsvController.callMentoringSession.Type_of_Call__c,'IB');
		cmsvController.cloneData();
		cmsvController.deleteData();
	}
	
	static testMethod void testNewMyCall() {
		Call_Mentoring_Session__c cms = new Call_Mentoring_Session__c();
		cms.Type_of_Call__c = 'IB';
		insert cms;
		CallMentoringSessionViewController cmsvController = new CallMentoringSessionViewController(new ApexPages.Standardcontroller(cms));
		cmsvController.newMyCall();
	}
}