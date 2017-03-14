@isTest
public class TestNewJobProfileController {
    public static testMethod void testContoller() {  
        Job_Profile__c jp = new Job_Profile__c();
        ApexPages.StandardController sc = new ApexPages.StandardController(jp);
           Apexpages.currentPage().getParameters().put('ReferralSource','Dodge');    
        NewJobProfileController NJPC = NEW NewJobProfileController(sc);
        NJPC.saveJobProfile();
        NJPC.saveAndNewJobProfile();
        NJPC.cancel();
        
        ApexPages.StandardController sc1 = new ApexPages.StandardController(jp);
        Apexpages.currentPage().getParameters().put('ReferralSource','Glenigan');
        NewJobProfileController NJPC1 = NEW NewJobProfileController(sc1);
        NJPC1.saveJobProfile();
        NJPC1.saveAndNewJobProfile();
        NJPC1.cancel();
    }
}