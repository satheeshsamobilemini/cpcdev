@isTest
private class TasksOnJobProfileControllerTest{
    @isTest static void testTasksOnJobProfileController(){
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User u = new User();
        u.Alias = 'standt';
        u.Email='standarduser@testorg.com'; 
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US'; 
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles'; 
        u.UserName='standarduser@test1org.com';
        insert u;
        System.runAs(u){
        TasksOnJobProfileController Controller=new TasksOnJobProfileController( new ApexPages.StandardController(p));
        Controller.orderBy = 'Subject';
        Controller.sortData();
        System.assertEquals(Controller.imgSrc, '/img/sort_desc_arrow.gif');
        Controller.sortData();
        System.assertEquals(Controller.imgSrc, '/img/sort_asc_arrow.gif');
        }
    }
}