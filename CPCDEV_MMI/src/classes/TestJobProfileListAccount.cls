/**
 * @Author :Vivek
 * @Date: 29-Sep-2015
 * @Description: This is test class for JobProfileListAccount. 
 */

@isTest
public class TestJobProfileListAccount{

static testMethod void JobProfileMethod1() {
Account acc = new Account();
acc.name = 'Test';
acc.BillingState = 'KS';
acc.BillingCountry = 'USA';
insert acc;

Job_Profile__c jp = new Job_Profile__c();
jp.name = 'Test';
insert jp;

Sub_Contractor__c sc = new Sub_Contractor__c();
sc.Account__c = acc.id;
sc.Job_Profile__c= jp.id;
sc.Role__c = 'Electrical';
insert sc;

ApexPages.currentPage().getParameters().put('ProfileId',jp.id);
ApexPages.currentPage().getParameters().put('firstParam',acc.Id);
System.currentPageReference().getParameters().put('hiddenconID',acc.Id);
JobProfileListAccount jpa = new JobProfileListAccount();
jpa.Createopportunity();
jpa.ContractorRoles();
List<SelectOption> opList = jpa.getContractorRole();
    
}
}