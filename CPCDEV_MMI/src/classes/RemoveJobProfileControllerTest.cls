@isTest
private class RemoveJobProfileControllerTest{
    @isTest static void testRemoveJobProfileController(){
        //Dodge_Project__c dodgeProject = new Dodge_Project__c(Id = ApexPages.currentPage().getParameters().put('id'),Removed_By__c=UserInfo.getUserId());
        Dodge_Project__c Dp = new Dodge_Project__c();
        Dp.Project_Name__c = 'Test2';
        Dp.Removed_By__c = UserInfo.getUserId();
        Insert Dp;
        
        
        Job_Profile__c Jp = new Job_Profile__c();
        Jp.Name = 'Test job';
        Jp.Branch_ID__c = '101';
        Jp.Job_Site_Zip__c = '560037';
        Jp.Job_Site_Country__c = 'INDIA';
        //Jp.dodge_Project__c = Dp.Id;
        insert Jp;
        
        ApexPages.currentPage().getParameters().put('Id',Dp.Id);
        RemoveJobProfileController RJPC = new RemoveJobProfileController();
        RJPC.jobProfile = Jp;
        RJPC.updateDodgeProject();
        RJPC.getJobProfile();
    }
    
}