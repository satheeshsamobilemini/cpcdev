@isTest
public class openOppSelectionCntrlTest{

  static testMethod void TestOppSelection_1(){
    Account acc = new Account(name='Trialed CNC');
    acc.BillingStreet = 'Church Park Strt';
    acc.BillingCity = 'Phoenix';
    acc.BillingState = 'AZ';
    acc.BillingCountry = 'USA';
    acc.BillingPostalCode = '73071-00';
    acc.ShippingPostalCode = '73071-00';
    insert acc;
    
    Contact con = new Contact(FirstName='Mark',LastName='Lesse',AccountId=acc.Id,Phone='4352431523');
    insert con;
    
    Opportunity opp = new Opportunity(Name='Trialed Opp',AccountId=acc.Id,StageName = 'Not Quoted',CloseDate=system.today());
    opp.Delivery_City__c = 'Phoenix';
    opp.Delivery_State_Province__c = 'AZ';
    opp.Opportunity_Contact_Name_LookUpFilter__c = con.Id;
    insert opp;
    
    ApexPages.currentPage().getParameters().put('id',acc.Id);
    ApexPages.currentPage().getParameters().put('Sales_Org','1000');
    ApexPages.currentPage().getParameters().put('opportunityid',opp.Id);
    ApexPages.currentPage().getParameters().put('opptyId',opp.Id);
    
    Test.startTest();
     openOppSelectionCntrl openOppSel = new openOppSelectionCntrl();
     openOppSel.loadPage();
     openOppSel.setVisible();
     openOppSel.Next();     
    Test.stopTest();
  }
  
  static testMethod void TestOppSelection_2(){
    Account acc = new Account(name='Trials MNC');
    acc.BillingStreet = 'Church Rd';
    acc.BillingCity = 'Phoenix';
    acc.BillingState = 'AZ';
    acc.BillingCountry = 'USA';
    acc.BillingPostalCode = '73171-01';
    acc.ShippingPostalCode = '73171-01';
    insert acc;
    
    ApexPages.currentPage().getParameters().put('id',acc.Id); 
    
    Test.startTest();
     openOppSelectionCntrl openOppSel = new openOppSelectionCntrl();
     openOppSel.loadPage();
     openOppSel.setVisible();
     openOppSel.Next();     
    Test.stopTest();
  }
}