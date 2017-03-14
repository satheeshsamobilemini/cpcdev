/**
 * Test Class for ViewCallMentoringController 
 */
@isTest
private class TestViewCallMentoringController {

    static testMethod void testViewCallMentoring() {
       Call_Mentoring_Session__c cms = new Call_Mentoring_Session__c();
	   insert cms;
	   ViewCallMentoringController viewCall = new ViewCallMentoringController(new ApexPages.Standardcontroller(cms));
	   PageReference resultPage = viewCall.CallViewPage();
	   Apexpages.currentPage().getParameters().put('id',resultPage.getParameters().get('id'));
	   //AdvancedCallMentoringSessionViewControll nextController = new AdvancedCallMentoringSessionViewControll(new ApexPages.Standardcontroller(cms));
	   //nextController.editData();
    }
    
    static testMethod void testViewPersonalCallMentoring() {
      List<RecordType> rtps = [Select r.Name, r.Id From RecordType r where Name in ('Personal Coaching Session')];
       Call_Mentoring_Session__c cms = new Call_Mentoring_Session__c();
       if(rtps != null && rtps.size() > 0){
	   	cms.RecordTypeId = rtps.get(0).id;
	   }
	   insert cms;
	   ViewCallMentoringController viewCall = new ViewCallMentoringController(new ApexPages.Standardcontroller(cms));
	   PageReference resultPage = viewCall.CallViewPage();
	   Apexpages.currentPage().getParameters().put('id',resultPage.getParameters().get('id'));
	   PersonalCallMentoringSessionViewCtrl nextController = new PersonalCallMentoringSessionViewCtrl(new ApexPages.Standardcontroller(cms));
	   nextController.editData();
	   nextController.cloneData();
	   nextController.newMyCall();
	   nextController.newTask();
	   nextController.deleteData();
    }
    
    static testMethod void testDeleteCallMentoring() {
       Call_Mentoring_Session__c cms = new Call_Mentoring_Session__c();
	   insert cms;
	   ViewCallMentoringController viewCall = new ViewCallMentoringController(new ApexPages.Standardcontroller(cms));
	   PageReference resultPage = viewCall.CallViewPage();
	   Apexpages.currentPage().getParameters().put('id',resultPage.getParameters().get('id'));
	   AdvancedCallMentoringSessionViewControll nextController = new AdvancedCallMentoringSessionViewControll(new ApexPages.Standardcontroller(cms));
	   nextController.editData();
	   nextController.cloneData();
	   nextController.newMyCall();
	   nextController.newTask();
	   nextController.deleteData();
	   
	}
    
}