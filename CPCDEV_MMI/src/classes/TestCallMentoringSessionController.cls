/**
 * Test class for CallMentoringSessionController
 */
@isTest
private class TestCallMentoringSessionController {

    static testMethod void testCallMentoringSession() {
        Call_Mentoring_Session__c cms = new Call_Mentoring_Session__c();
        /* test save functionality */
        CallMentoringSessionController cmsController = new CallMentoringSessionController(new ApexPages.Standardcontroller(cms));
        cmsController.callMentoringSession.Type_of_Call__c ='IB';
        cmsController.effectiveRating = 2;
        cmsController.salesPersonRating = 3;
        cmsController.saveData();
        System.assert(cmsController.callMentoringSession.id != null);
        /* test cancel functionality */
        //cmsController = new CallMentoringSessionController(new ApexPages.Standardcontroller(cms));
        //cmsController.cancelEdit();
        /* test save and New */ 
        cmsController = new CallMentoringSessionController(new ApexPages.Standardcontroller(cms));
        cmsController.callMentoringSession.Type_of_Call__c ='IB';
        // cmsController.callMentoringSession.I_able_to_determine_Previous_Exp__c ='N/A';           TFS - 3528
        cmsController.saveDataNew();
        cmsController.cancelEdit();
        
        /*test clone */
        cms.Type_of_Call__c = 'IB';
        // cms.I_able_to_determine_Previous_Exp_CFlag__c = true;                      TFS - 3528
        insert cms;
        
        ApexPages.currentPage().getParameters().put('clone','1');
        cmsController = new CallMentoringSessionController(new ApexPages.Standardcontroller(cms));
        
         
    }
}