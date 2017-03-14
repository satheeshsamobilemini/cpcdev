@isTest
private class TestMyProfilePageController{
     @isTest static void  myProfilePageControllerTest(){
        
        Account acc = New Account();
		acc.Name='Test Account';
		//acc.ownerid=salesRep1.Id;
		insert acc;
	
		Contact con = new Contact();
		con.LastName='Test';
		con.FirstName = 'Test';
		con.Email = 'abc@abc.com';
		con.AccountId = acc.id;
		insert con;  
         
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
        //u.usertype = 'GUEST';
        //u.ContactId = con.Id;
        insert u;
        
        //User usr = [select id,Name from User where usertype =: 'GUEST'];
        
     	MyProfilePageController MPPC = new MyProfilePageController();
        MPPC.getUser();
        MPPC.getIsEdit();
        MPPC.edit();
        MPPC.save();
        MPPC.changePassword();
        MPPC.cancel();
        MyProfilePageController.setContactFields(con,u);
     }
}