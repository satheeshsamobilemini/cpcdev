/*************************************************************************
Name   : TestManageDaysOffController
Usage  : Unit tests for testing ManageDaysOffController apex class.
Author : Aashish Mathur
Date   : September 2, 2009
*************************************************************************/

@isTest 
private with sharing class TestManageDaysOffController {
    private static User runAsUser;
    private static List<User> subUsers;
    
    @isTest static void testController1(){
        ManageDaysOffController MDOC = new ManageDaysOffController();
        MDOC.saveDaysOffTrackers();
        //MDOC.goToPreviousWeek();
        //MDOC.goToNextWeek();
        //MDOC.setWeek();
        MDOC.getSubordinatesDaysOffTrackers();
        MDOC.goToNextPage();
        MDOC.goToPreviousPage();
    }
    
    @isTest
    public static void testManageDaysOffController1() {
        //setupTestUsers();
        runAsUser = MMIFullquoteTestDataProvider.getUser();
        if (runAsUser != null) {
            System.runAs(runAsUser) {
                ManageDaysOffController testObj = new ManageDaysOffController();
                if (testObj.hasSubordinateUsers == false)
                    return;
                
                testObj.getSubordinatesDaysOffTrackers();
                testObj.dotForTimePeriodInput.Time_Period__c = Date.today();
                testObj.setWeek();
                testObj.goToPreviousWeek();
                testObj.goToNextWeek();
                Integer totalPages = testObj.totalPage;
                Integer noOfSubordinateUsers = testObj.noOfSubordinateUsers;
                Boolean isPrevPage = testObj.hasPreviousPage;
                Boolean isNextPage = testObj.hasNextPage;
                Integer showingFrom = testObj.showingFrom;
                Integer showingTo = testObj.showingTo;
                testObj.getSubordinatesDaysOffTrackers();
                testObj.saveDaysOffTrackers();
                testObj.goToNextPage();
                testObj.goToPreviousPage();
            }
        }
    }
    
    @isTest
    public static void testManageDaysOffController2() {
        //setupTestUsers();
        runAsUser = MMIFullquoteTestDataProvider.getUser();
        if (runAsUser != null) {
            System.runAs(runAsUser) {
                ManageDaysOffController testObj = new ManageDaysOffController();
                if (testObj.hasSubordinateUsers == false)
                    return;
                
                testObj.dotForTimePeriodInput.Time_Period__c = Date.newInstance(2009, 08, 03);
                testObj.setWeek();
                for (Integer index = 0; index < testObj.getSubordinatesDaysOffTrackers().size(); index++) {
                    testObj.getSubordinatesDaysOffTrackers()[index].daysOffTracker.Sick_Days__c = 3;
                }
                
                testObj.saveDaysOffTrackers();
                
                for (Integer index = 0; index < testObj.getSubordinatesDaysOffTrackers().size(); index++) {
                    Days_Off_Tracker__c updatedDaysOffTracker = [Select Sick_Days__c
                            From Days_Off_Tracker__c
                            where Id =:testObj.getSubordinatesDaysOffTrackers()[index].daysOffTracker.Id];
                    System.assertEquals(updatedDaysOffTracker.Sick_Days__c, 3.0);
                }
                
                if (testObj.getSubordinatesDaysOffTrackers().size() > 0) {
                    testObj.getSubordinatesDaysOffTrackers()[0].daysOffTracker.Sick_Days__c = 1;
                }
                
                Id idOfTracker;
                if (testObj.getSubordinatesDaysOffTrackers().size() > 1) {
                    idOfTracker = testObj.getSubordinatesDaysOffTrackers()[1].daysOffTracker.Id;
                    testObj.getSubordinatesDaysOffTrackers()[1].daysOffTracker.Sick_Days__c = null;
                }
                
                testObj.saveDaysOffTrackers();
                
                if (testObj.getSubordinatesDaysOffTrackers().size() > 0) {
                    Days_Off_Tracker__c updatedDaysOffTracker = [Select Sick_Days__c
                              From Days_Off_Tracker__c
                            where Id =:testObj.getSubordinatesDaysOffTrackers()[0].daysOffTracker.Id];
                    System.assertEquals(updatedDaysOffTracker.Sick_Days__c, 1.0);
                }
                
                if (testObj.getSubordinatesDaysOffTrackers().size() > 1) {
                  System.assertEquals([Select Id From Days_Off_Tracker__c where Id =:idOfTracker].size(), 0);
                }
            }
        }
    }
    
    @isTest
    public static void testManageDaysOffController3() {
        //setupTestUsers();
        User runAsUser1 = MMIFullquoteTestDataProvider.getUser();
        if (runAsUser1 != null) {
            System.runAs(runAsUser1) {
                ManageDaysOffController testObj = new ManageDaysOffController();
            }
        }
    }
    
    private static UserRole createUserRole(String name, Id parentRoleId) {
        UserRole role = new UserRole(Name = name, ParentRoleId = parentRoleId);
        insert role;
        return role;
    }
    
    private static void setupTestUsers() {
        try {
            UserRole myRole = createUserRole('Top Parent Role', null);
            UserRole role1 = createUserRole('Test Parent Role', myRole.Id);
            UserRole role2 = createUserRole('Test Child Role', role1.Id);
            
            Profile p1 = [Select Id From profile where name = 'System Administrator'];
            runAsUser = new User(alias = 'bm', email = 'bm@testorg.com',
                    emailencodingkey = 'UTF-8', lastname = 'bmTesting', languagelocalekey = 'en_US',
                    localesidkey = 'en_US', profileid = p1.Id, timezonesidkey = 'America/Los_Angeles',
                    username = 'bm@testorg.com', UserRoleId = myRole.Id);
            
            // Add users for testing
            List<User> users = new List<User>();
            for (Integer i = 0; i < 3; i++) {
                User user = new User(Available_For_Leads__c = True, alias = 'SubUser' + i,
                        email = 'salesrep' + i + '@testorg.com', emailencodingkey = 'UTF-8',
                        firstname = 'SubUserTesting' + (7-i), lastname = 'SubUserTesting' + i,
                        languagelocalekey = 'en_US', localesidkey = 'en_US', profileid = p1.Id,
                        timezonesidkey = 'America/Los_Angeles', username = 'salesrep' + i + '@testorg.com',
                        UserRoleId = role2.Id);
                users.add(user);
            }
            
            insert users;
            
            subUsers = [Select Available_For_Leads__c, Id From User
                    where LastName like 'SubUserTesting%' and UserRoleId = :role2.Id];
        } catch(Exception ex) {
            // If there is LICENSE_LIMIT_EXCEEDED then we cannot create Users for testing purpose.
            // So getting existing users to process Our Test Class.
            List<User> userList = [Select Id From User
                    where UserRole.Name = 'Branch Manager - 101 - Phoenix' limit 1];
            if (userList.size() > 0)
                runAsUser = userList[0];
            
            UserRole userRole = [Select Id From UserRole where Name = 'Sales Rep - 101 - Phoenix'];
            subUsers = [Select Id, Available_For_Leads__c From User where UserRoleId = :userRole.Id];
        }
    }
}