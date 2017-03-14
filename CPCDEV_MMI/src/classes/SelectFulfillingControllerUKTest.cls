/**
 * (c) 2015 TEKsystems Global Services
 *
 * Name           : SelectContactPopupControllerUKTest
 * Created Date   : 20 March 2015
 * Created By     : Vivek (TEK)
 * Purpose        : Test class for SelectContactPopupControllerUK
 *
 **/
 @isTest
 public class SelectFulfillingControllerUKTest{
 Static TestMethod void ForSelectFulfillingDepotPopupControllerUK(){
 
 Branch_Detail__c branchDetail = new Branch_Detail__c();
 branchDetail.Branch_Address__c = 'TestAddress';
 branchDetail.Branch_Code__c = 'ABC';
 branchDetail.Branch_Mobile__c = '1234567890';
 branchDetail.Branch_Phone__c = '1234567890';
 branchDetail.Branch_Name__c = 'TestServiceBranch';
 insert branchDetail;
 
 Post_Code_Rate__c postCodeRate = new Post_Code_Rate__c();
 postCodeRate.Service_Branch__c = 'TestServiceBranch';
 insert postCodeRate;
 
 Apexpages.currentPage().getParameters().put('fulfildep', 'TestAddressId'); 
 
 SelectFulfillingDepotPopupControllerUK selectFulfillingInstance =  new SelectFulfillingDepotPopupControllerUK();
 //selectFulfillingInstance.fulfildepot = 'TestAddressId';
 
 }
 }