/*************************************************************************
Name   : TestLeadAssignmentToSalesRep
Usage  : Test class to test LeadAssignmentToSalesRep apex class.
Author : Kirtesh jain
Date   : July 14, 2009

Modified Date : kirtesh Jain
Modified Date : July 29 ,2009
*************************************************************************/

public class TestLeadAssignmentToSalesRep {

@isTest
public static void Test_LeadAssignmentToSalesRep(){
  Profile p2 = [select id from profile limit 1];
  
  UserRole role1 = new UserRole();
  role1.Name = 'Parent Manager';
  //insert role1;
 
  UserRole role2 = new UserRole() ;
  role2.Name = 'child SalesRep';
  role2.ParentRoleID = role1.Id ;
  //nsert role2 ;
  
  List<User> listUser = new List<User>();
  
  
  for( integer i = 0 ; i  < 60 ;  i++ ){
    Boolean bln = false ;
    if(i < 15)
      bln  = true ;
    
    User user = new User( Available_For_Leads__c = bln ,alias = 'Sub'+ i, email='salesrep' + i + '@testorg.com',
                          emailencodingkey='UTF-8', firstname='SubUserTesting' + (7-i),lastname='SubUserTesting' +i,languagelocalekey='en_US',
                          localesidkey='en_US', profileid = p2.Id, timezonesidkey='America/Los_Angeles', 
                          username='salesrephere'+i+'@testorg.com' ,ISActive = true );
    listUser.add(user);
  }
  integer i=98;
  User userParent = new User( Available_For_Leads__c = true ,alias = 'SubM', email='salesManage@testorg.com',
                              emailencodingkey='UTF-8', firstname='SubUserTestingr',lastname='SubUserTesting',languagelocalekey='en_US',
                              localesidkey='en_US', profileid = p2.Id, timezonesidkey='America/Los_Angeles', 
                              username='salesrephere'+i+'@testorg.com' ,  ISActive = true);
  
  
   
  listUser.add(userParent);
  insert listUser;
  
  User user = [Select ID from User Where userNAme = 'salesrephere98@testorg.com']; 
  
  Test.startTest();
  
  System.runAs(user){
    LeadAssignmentToSalesRep testObj = new LeadAssignmentToSalesRep();
    testObj.getResults();
    testObj.getResults_form2();
    testObj.sortData();
    testObj.sortData_form2();
    testObj.getIsAsc_form2();
    testObj.getIsAsc();
    testObj.setIsAsc(true);
    testObj.setIsAsc_form2(true);
    testObj.previousToDoPage();
    testObj.previousToDoPage_form2();
    testObj.selectedId = user.Id;
    testObj.updateUsers();
    User testUser=[select id,LastLeadAllocation__c from User where Id=:user.Id];
    String assTime=String.ValueOf(DateTime.Now());
    assTime= assTime.SubString(0,15);
    String assTime1=String.ValueOf(testUser.LastLeadAllocation__c);
    assTime1= assTime1.SubString(0,15);
    System.assertEquals(assTime ,assTime1);
    testObj.setResults(new List<User>());
    testObj.setResults_form2(new List<User>());
    testObj.getPaginator();
    testObj.getPaginator_form2();
    testObj.nextToDoPage();
    testObj.nextToDoPage_form2();
  }
 
  Test.stopTest();
}

}