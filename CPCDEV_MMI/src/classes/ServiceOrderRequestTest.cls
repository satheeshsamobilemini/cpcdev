@isTest

public class ServiceOrderRequestTest{

static testMethod void TestMethod1(){
  
  Id uRoleId = [select Id from UserRole where Name like'%Branch Manager%' LIMIT 1].Id;
  
  Id uProfileId = [select Id from Profile where Name like '%System Admin%' LIMIT 1].Id;
  
  User BMuser = new User(FirstName='Sam',LastName='Klener',Email='sKlener@mm.com',Username='sKlener@mm.com.data',ProfileId=uProfileId,UserRoleId=uRoleId);
  BMuser.Plant_Code__c = '1117';
  BMuser.Alias = 'sKlene';
  BMuser.TimeZoneSidKey = 'America/Los_Angeles';
  BMuser.LocaleSidKey = 'en_US';
  BMuser.EmailEncodingKey = 'ISO-8859-1';
  BMuser.LanguageLocaleKey = 'en_US';
  insert BMuser;
  
  system.runAs(new user(Id=UserInfo.getUserId())){
  Test.startTest();   
  List<Service_Order_Request__c> sorlist = new List<Service_Order_Request__c>();
  
  Account acc = new Account();
  acc.name='test account';
  acc.Revenue_Q1__c=100.00;
  acc.Revenue_Q2__c=200.00;
  acc.Revenue_Q3__c=100.00;
  acc.Revenue_Q4__c=222.00;
  acc.Revenue_Q5__c=565.00;
  acc.Revenue_Q6__c=5656.00;
  acc.Revenue_Q7__c=56.00;
  acc.Revenue_QC__c=566.00;
  acc.BillingState = 'AZ';
  acc.BillingCountry = 'US';
  acc.recordtypeid =  [select id,name from RecordType where name = 'Business Account - UK'].ID;
  insert acc;
            
  UKBranchUsers__c UK_Branch_1 = new UKBranchUsers__c(name = 'UK Branch user 1');
  UK_Branch_1.BranchName__c = '711_00580000003pWFv';
  insert UK_Branch_1; 
  
  Branch_Detail__c bDetail = new Branch_Detail__c(Branch_Name__c = 'London DartFord',Branch_Country__c = 'UK', Branch_Code__c = '718', Plant_Code__c = '1718', Branch_Email__c = 'TestLondon@testmobilemini.com');
  insert bDetail;  
  
  Service_Order_Request__c sor1=new Service_Order_Request__c();
  sor1.Account_Name__c=acc.id;
  sor1.Status__c='Submitted';
  sor1.Branch_Id__c = '718 - Sunderland';
  sor1.Account__c = '716447';
  sor1.RecordtypeId = [select Id from RecordType where sObjectType = 'Service_Order_Request__c' and name = 'Service Order Request - (MMI UK) 1200'].id;
  sorlist.add(sor1);
  
  Service_Order_Request__c sor2=new Service_Order_Request__c();
  sor2.Account_Name__c=acc.id;
  sor2.Status__c='Submitted';
  sor2.Branch_Id__c = '1987';
  sor2.RecordtypeId = [select Id from RecordType where sObjectType = 'Service_Order_Request__c' and name = 'Credits (MMI) 1000'].id;
  sorlist.add(sor2);
  
  Service_Order_Request__c sor3=new Service_Order_Request__c();
  sor3.Account_Name__c=acc.id;
  sor3.Status__c='SAP Credit Process';
  //sor3.Branch_Id__c = '117';
  sor3.Branch_Id__c = '1117';
  sor3.RecordtypeId = [select Id from RecordType where sObjectType = 'Service_Order_Request__c' and name = 'Service Order Request (MMI) 1000'].id;
  sorlist.add(sor3);
  
  insert sorlist;
  
  ServiceOrderRequestBM__c sbm1 = new ServiceOrderRequestBM__c(name='test 1 servicing branch');
  sbm1.Branch_Manager__c='987';
  sbm1.Servicing_Branch_Id__c='117';
  insert sbm1; 
  
  Email_Dispatcher__c em = new Email_Dispatcher__c(name = 'Branch List');
  //em.Branch_Email_Combination__c = '987_117,912_112';
  em.Branch_Email_Combination__c = '1987_1117,1912_1112';
  insert em;
  
  Branch_Detail_US__c bDetail_US = new Branch_Detail_US__c(Dispatch_Email__c='test2@test.com',Plant_Code__c='117',Sales_Org__c='1000');
  insert bDetail_US;
  
  sorlist[1].status__c = 'Approved';
  update sorlist[1];
  
  Id TestId_1 = ServiceOrderRequestUtil.getOfficeManagerId('117');
  map<Id,string> testMap = new map<Id,string>{acc.Id =>'test'};
  Id TestId_2 = ServiceOrderRequestUtil.getOfficeManager(acc.Id,testMap);
  string testStr = ServiceOrderRequestUtil.getConvertedBranchIdStratsWith9('117');
  Test.stopTest();
 }
}
            
}