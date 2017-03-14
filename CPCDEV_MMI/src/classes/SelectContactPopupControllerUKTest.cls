/**
 * (c) 2015 TEKsystems Global Services
 *
 * Name           : SelectContactPopupControllerUKTest
 * Created Date   : 20 March 2015
 * Created By     : Sreenivas M (TEK)
 * Purpose        : Test class for SelectContactPopupControllerUK
 *
 **/
 @isTest
 public class SelectContactPopupControllerUKTest
 {
  static testMethod void fromBusinessAccount() 
  {
    Account objBussinessAcc= MMIFullquoteTestDataProvider.getBusinessAccount();
    objBussinessAcc.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Business Account - UK').getRecordTypeId();
    objBussinessAcc.Result_Id__c = 'P2557879';
    objBussinessAcc.BillingState = 'AZ';
    objBussinessAcc.BillingCountry = 'US';
    insert objBussinessAcc;
     
      CPQActiveURL__c ca =new CPQActiveURL__c(Name='test2');
        //ca.URL_Active__c=true;
        ca.CPQ_URL__c='http://cpq-devweb/CPQ'; 
        ca.Environment__c = 'cs42';
        ca.Portal_URL__c = 'http://cpq-devweb.mobilemini.com/CPQ';
        insert ca;
     Job_Profile__c jp = new Job_Profile__c(name='test');
     jp.Job_Site_Zip__c='800010';
     insert jp;   
    
     Apexpages.currentPage().getParameters().put('id',objBussinessAcc.Id);
     Apexpages.currentPage().getParameters().put('FromAccount','true');
     Apexpages.currentPage().getParameters().put('fromProfile','true');     
     Apexpages.currentPage().getParameters().put('accDashboard','true');        
     Apexpages.currentPage().getParameters().put('jobprofileid',jp.id);
     Apexpages.currentPage().getParameters().put('conrole','Contractor');
    
     
     SelectContactPopupControllerUK selConPopCtrl = new SelectContactPopupControllerUK();
     selConPopCtrl.conFn = 'mobile';
     selConPopCtrl.conLn = 'mini-xyz';
     selConPopCtrl.conPh = '7477474777';
     selConPopCtrl.conEmail = 'msr@gmail.com';
     selConPopCtrl.conMob = '6366363663';     
     selConPopCtrl.CreateContact();
          
     Contact conObj = new Contact();
     conObj.AccountId = objBussinessAcc.Id;
     conObj.FirstName = 'duplicte';
     conObj.LastName = 'contact';
     insert conObj;
     Apexpages.currentPage().getParameters().put('hiddenContact',conObj.id);
     selConPopCtrl.next();
     
     Account newAccount = new Account( Salutation='Mr.', FirstName='Joe', LastName='Schmoe',BillingState = 'AZ',BillingCountry = 'US');
     newAccount.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Residential Account - UK').getRecordTypeId();
     insert newAccount;
     
     Apexpages.currentPage().getParameters().put('id',newAccount.Id);
     Apexpages.currentPage().getParameters().put('FromAccount','true');
      
     SelectContactPopupControllerUK selConPopCtrl1 = new SelectContactPopupControllerUK();
     selConPopCtrl1.accId = objBussinessAcc.id;
     selConPopCtrl1.getContactRecord();
     selConPopCtrl1.CreateContact();
     selConPopCtrl1.isPersonalAcc('123');
     list<contact> listAcc;
     selConPopCtrl1.isContactAvailable(listAcc);
     selConPopCtrl1.Createopportunity();
     //selConPopCtrl1.updateOppContact();
     selConPopCtrl1.createShipToRecord();
     
     Apexpages.currentPage().getParameters().put('repID','123');
      SelectContactPopupControllerUK selConPopCtrl3= new SelectContactPopupControllerUK();
  }
 }