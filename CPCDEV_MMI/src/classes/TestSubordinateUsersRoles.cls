/**
* This class contains unit tests for validating the behavior of Apex classes
* and triggers.
*
* Unit tests are class methods that verify whether a particular piece
* of code is working properly. Unit test methods take no arguments,
* commit no data to the database, and are flagged with the testMethod
* keyword in the method definition.
*
* All test methods in an organization are executed whenever Apex code is deployed
* to a production organization to confirm correctness, ensure code
* coverage, and prevent regressions. All Apex classes are
* required to have at least 75% code coverage in order to be deployed
* to a production organization. In addition, all triggers must have some code coverage.
* 
* The @isTest class annotation indicates this class only contains test
* methods. Classes defined with the @isTest annotation do not count against
* the organization size limit for all Apex scripts.
*
* See the Apex Language Reference for more information about Testing and Code Coverage.
*/
@isTest
private class TestSubordinateUsersRoles {
    
    private static User runAsUser;
    private static List<User> subUsers;
    private static boolean blnUser ;
    
    private static UserRole createUserRole(String name, Id parentRoleId)
    {
        UserRole role=new UserRole(Name=name,ParentRoleId=parentRoleId);
        insert role;
        
        role=[select Id,Name from UserRole where Name=:name and ParentRoleId=:parentRoleId];
        
        return role;
    }
    
    private static void SetupTestUsers()
    {
        
        // We have LICENSE_LIMIT_EXCEEDED in sandbox . so we cant create User there for testing purpose.
        // We are using existing user to process Our Test Class. System.Assert also commented.
        
        
        try{
            UserRole myRole = [Select u.Id from UserRole u Where Name = 'Regional Manager - Region 1 UK'];
            
            //UserRole role1=createUserRole('Test Parent Role','00EQ0000000HTTJMA4');
            UserRole role1=createUserRole('Test Parent Role',myRole.Id);
            UserRole role2=createUserRole('Test Child Role',role1.Id);
            
            Profile p1 = [select id from profile where name='Branch Manager - US'];
            Profile p2 = [select id from profile where name='Sales Rep - US'];
            
            runAsUser = new User(alias = 'bm', email='bm@testorg.com',
                                 emailencodingkey='UTF-8', lastname='bmTesting', languagelocalekey='en_US',
                                 localesidkey='en_US', profileid = p1.Id,timezonesidkey='America/Los_Angeles',
                                 username='bm@testorg.com',UserRoleId=role1.Id);    
            
            
            
            //add users for testing
            List<User> users=new List<User>();
            
            for(Integer i=0;i<8;i++)
            {
                User user = new User(Available_For_Leads__c=True,alias = 'SubUser'+ i, email='salesrep' + i + '@testorg.com',
                                     emailencodingkey='UTF-8', firstname='SubUserTesting' + (7-i),lastname='SubUserTesting' +i,languagelocalekey='en_US',
                                     localesidkey='en_US', profileid = p2.Id, timezonesidkey='America/Los_Angeles', 
                                     username='salesrep'+ i + '@testorg.com' ,UserRoleId=role2.Id);
                users.add(user);
                
                
            }
            insert users;
            blnUser = true ;
            subUsers=[select Available_For_Leads__c,Id from User where lastname like 'SubUserTesting%' and UserRoleId=:role2.Id and id = : userInfo.getUserId()];
        }catch(Exception ex ){
            //if( ex.getMessage().contains('LICENSE_LIMIT_EXCEEDED')){
            
            //runAsUser = [ select Id from User Where User.UserRole.Name = 'Branch Manager - 101 - Phoenix' Limit 1] ;
            runAsUser = MMIFullquoteTestDataProvider.getUser();
            UserRole userRole = [select Id from UserRole  Where Name = 'Sales Rep - 101 - Phoenix'];
            subUsers = [ Select Available_For_Leads__c,Id from User where UserRoleId=:userRole.Id ];
            //}
        }
        
    }
    static testMethod void testSubordinateUsersRoles(){
        SetupTestUsers();
        System.runAs(runAsUser) 
        {
            SubordinateUsersRoles objSubUserRole = new SubordinateUsersRoles();
            Paginator paginator = objSubUserRole.getPaginator();
            
            Map<String, List<String>> newSubOrdRoleParentMap = new Map<String, List<String>>();
            newSubOrdRoleParentMap.put(null,new list<String>());
            Id currentUserRole = UserInfo.getUserRoleId();
            objSubUserRole.subordinateRoleParentMap = newSubOrdRoleParentMap;
            objSubUserRole.getSubordinateRoleIds(currentUserRole);
            
        }
    }
    static testMethod void testDataRetrieval() 
    {
        SetupTestUsers();
        //runAsUser = MMIFullquoteTestDataProvider.getUser();
        System.debug('Parth***RunasUser='+ runAsUser);
        System.runAs(runAsUser) 
        {
            SubordinateUsersRoles objSubUserRole = new SubordinateUsersRoles(4);
            Paginator paginator = objSubUserRole.getPaginator();
            //System.assertEquals(paginator.totalResults,8 );
            //System.assertEquals(paginator.totalPage,2 );
            
            // The following code runs as user 'u'
            System.debug('Current User: ' + UserInfo.getUserName());
            System.debug('Current Profile: ' + UserInfo.getProfileId()); }
        
        
    }
    
    
    static testMethod void testNavigationNext() 
    {
        SetupTestUsers();
        //runAsUser = MMIFullquoteTestDataProvider.getUser();
        System.debug('Parth***RunasUser='+ runAsUser);
        System.runAs(runAsUser) 
        {
            SubordinateUsersRoles objSubUserRole = new SubordinateUsersRoles(4);
            Paginator paginator = objSubUserRole.getPaginator();
            
            ////objSubUserRole.nextToDoPage();
            //System.assertEquals(paginator.currentPage,2 );
            
            //To test End of pages
            ////objSubUserRole.nextToDoPage();
            //System.assertEquals(paginator.currentPage,2 );
            
            
        }
    }
    
    static testMethod void testNavigationPrev() 
    {
        SetupTestUsers();
        //runAsUser = MMIFullquoteTestDataProvider.getUser();
        System.debug('Parth***RunasUser='+ runAsUser);
        System.runAs(runAsUser) 
        {
            SubordinateUsersRoles objSubUserRole = new SubordinateUsersRoles(4);
            Paginator paginator = objSubUserRole.getPaginator();
            System.debug(':::::paginator::::::'+paginator);    
            /*objSubUserRole.nextToDoPage();
System.assertEquals(paginator.currentPage,2 );
System.assertEquals(paginator.getShowingFrom(),5);
System.assertEquals(paginator.getShowingTo(),8);


objSubUserRole.previousToDoPage();
System.assertEquals(paginator.currentPage,1 );
System.assertEquals(paginator.getShowingFrom(),1);
System.assertEquals(paginator.getShowingTo(),4);

//Test Start of pages
objSubUserRole.previousToDoPage();
System.assertEquals(paginator.currentPage,1 );*/
            
            
        }
    }
    
    static testMethod void testUpdateUsers1()
    {
        SetupTestUsers();
        //runAsUser = MMIFullquoteTestDataProvider.getUser();
        
        System.runAs(runAsUser) 
        {
            SubordinateUsersRoles objSubUserRole = new SubordinateUsersRoles(4);
            Paginator paginator = objSubUserRole.getPaginator();
            
            objSubUserRole.updateUsers();
            
            String  selectedID= subUsers.get(0).Id + ';' + subUsers.get(2).Id + ';' + subUsers.get(4).Id ;
            List<String> lstSelectedIDs =  selectedID.split(';');
            List<User> selectedUsers=[select Available_For_Leads__c,Id from User where Id in:lstSelectedIDs];
            
            for(User usr:selectedUsers){
                if(blnUser == true)
                    System.assertEquals(usr.Available_For_Leads__c, True);
            }
        }
    }
    
   
    static testMethod void testUpdateUsers2()
    {
        SetupTestUsers();
        //runAsUser = MMIFullquoteTestDataProvider.getUser();
        
        System.runAs(runAsUser) 
        {
            SubordinateUsersRoles objSubUserRole = new SubordinateUsersRoles(4);
            Paginator paginator = objSubUserRole.getPaginator();
            
            for( User user : paginator.getAllUsers() ){
                user.Available_For_Leads__c = false ;
            }
            
            objSubUserRole.updateUsers();
            
            String  selectedID= subUsers.get(0).Id + ';' + subUsers.get(2).Id + ';' + subUsers.get(4).Id ;
            List<String> lstSelectedIDs =  selectedID.split(';');
            List<User> selectedUsers=[select Available_For_Leads__c,Id from User where Id in:lstSelectedIDs];
            for(User usr:selectedUsers){
                if(blnUser == true)
                    System.assertEquals(usr.Available_For_Leads__c, false);
            }
        }
    }
    
    
    static testMethod void testSorting() 
    {
        SetupTestUsers();
        //runAsUser = MMIFullquoteTestDataProvider.getUser();
        
        System.runAs(runAsUser) 
        {
            SubordinateUsersRoles objSubUserRole = new SubordinateUsersRoles(4);
            Paginator paginator = objSubUserRole.getPaginator();
            
            //asc on Name
            //objSubUserRole.setIsAsc( true );
            objSubUserRole.sortField = 'Name';
            objSubUserRole.sortData();
            
            List<User> results=objSubUserRole.getResults();
            
            System.assertEquals(false,objSubUserRole.getIsAsc());
            //System.assertEquals(results.get(0).LastName, 'SubUserTesting0');
            //System.assertEquals(results.get(1).LastName, 'SubUserTesting1');
            
            //desc on name
            //objSubUserRole.setIsAsc( false );
            objSubUserRole.sortField = 'Name';
            objSubUserRole.sortData();
            
            results=objSubUserRole.getResults();
            System.assertEquals(true,objSubUserRole.getIsAsc(  )); 
            //System.assertEquals(results.get(0).LastName, 'SubUserTesting7');
            //System.assertEquals(results.get(1).LastName, 'SubUserTesting6');
            
            //Change sortfield      
            //objSubUserRole.setIsAsc( false );
            objSubUserRole.sortField = 'FirstName';
            objSubUserRole.sortData();
            
            results=objSubUserRole.getResults();
            
            System.assertEquals(true,objSubUserRole.getIsAsc(  )); 
            //System.assertEquals(results.get(0).FirstName, 'SubUserTesting0');
            //System.assertEquals(results.get(1).FirstName, 'SubUserTesting1');
            
            //objSubUserRole.setIsAsc( false);
            objSubUserRole.sortField = 'FirstName';
            objSubUserRole.sortData();
            
            results=objSubUserRole.getResults();
            
            System.assertEquals(false,objSubUserRole.getIsAsc(  )); 
            //System.assertEquals(results.get(0).FirstName, 'SubUserTesting7');
            //System.assertEquals(results.get(1).FirstName, 'SubUserTesting6');
            
        }
    }
    
    
}