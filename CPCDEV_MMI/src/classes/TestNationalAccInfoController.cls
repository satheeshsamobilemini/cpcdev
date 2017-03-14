/********************************************************************************************
Name   : TestNationalAccInfoController
Usage  : Unit tests for testing NationalAccInfoController apex class.
Author : Aashish Mathur
Date   : November 19, 2009
********************************************************************************************/

@isTest
private class TestNationalAccInfoController {
    @isTest
    static void testController() {
        // Test Account
        Account testAccount = new Account();
        testAccount.Name = 'testAccount';
        insert testAccount;
        
        ApexPages.StandardController stdCont = new ApexPages.StandardController(testAccount);
        
        // Make instance of controller without any page parameter
        NationalAccInfoController controller = new NationalAccInfoController(stdCont);
        System.assertEquals(controller.editMode, false);
        
        // Make instance of controller with page parameter
        ApexPages.currentPage().getParameters().put('editMode', 'true');
        controller = new NationalAccInfoController(stdCont);
        System.assertEquals(controller.editMode, true);
        
        PageReference pageRef = controller.editAcc();
        String pageRefUrl = pageRef.getUrl();
        Map<String, String> parameters = pageRef.getParameters();
        
        System.assertEquals(pageRefUrl.substring(0, pageRefUrl.indexOf('?')), '/apex/NationalAccInfo');
        System.assertEquals(parameters.get('id'), testAccount.Id);
        System.assertEquals(parameters.get('editMode'), 'true');
        
        pageRef = controller.saveAcc();
        pageRefUrl = pageRef.getUrl();
        parameters = pageRef.getParameters();
        
        System.assertEquals(pageRefUrl.substring(0, pageRefUrl.indexOf('?')), '/apex/NationalAccInfo');
        System.assertEquals(parameters.get('id'), testAccount.Id);
        System.assertEquals(parameters.get('editMode'), 'false');
    }
}