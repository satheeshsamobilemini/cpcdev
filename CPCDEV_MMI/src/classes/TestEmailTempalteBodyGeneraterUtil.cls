@isTest
public class TestEmailTempalteBodyGeneraterUtil {
   public static testMethod void testContoller() {
        EmailTempalteBodyGeneraterUtil ETBG = new EmailTempalteBodyGeneraterUtil();
         Account objAcc = new Account();
            objAcc.Name = 'testAccount';
            objAcc.Type= 'test';
         insert objAcc;
         Contact objCon = new Contact();
           objCon.FirstName = 'testfirst';
           objCon.LastName = 'testLast';
           objCon.Email = 'test@tek.com';
         insert objCon;
         Opportunity objOppty =  new Opportunity();
          objOppty.Name = 'testOppty';
          objOppty.AccountID = objAcc.id;
          objOppty.CloseDate = Date.parse('05/11/2017');
          objOppty.StageName = 'Not Quoted';
          objOppty.Opportunity_Rating__c = 'Cold';
          objOppty.Billing_Zip_Postal_Code__c = '12456';
          objOppty.Delivery_Zip_Postal_Code__c = '12456';
          objOppty.Why_do_you_need_storage_Picklist__c = 'test';
          objOppty.of_Units__c = 10;
         insert objOppty;  
        EmailTemplate objEmailTemp =  new EmailTemplate();
           System.runAs ( new User(Id = UserInfo.getUserId()) ) { 
           
                objEmailTemp.Subject = 'test email';
                objEmailTemp.Name = 'test';
                objEmailTemp.IsActive = True;
                objEmailTemp.Body = 'test';
                objEmailTemp.TemplateType = 'text';
                objEmailTemp.developerName  = 'test';
                objEmailTemp.FolderId = UserInfo.getUserId();
             insert objEmailTemp;
           }
         Quote  objQuote = new Quote();
           objQuote.Name = 'testQuote';
           objQuote.OpportunityId = objOppty.id;  
         insert objQuote;
       
         MMI_Quotes__c  objMMIQuote = new MMI_Quotes__c();
           objMMIQuote.Name = 'testMMI Quote';
           objMMIQuote.Opportunity__c = objOppty.id;  
         insert objMMIQuote;
         
         MMI_Full_Quotes__c objMMIFullQuote = new MMI_Full_Quotes__c();
            objMMIFullQuote.Name = 'test full quote';
            objMMIFullQuote.Opportunity__c = objOppty.id;
         insert objMMIFullQuote;
       
         Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
         User u = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='user@tekTestUser.com');
         insert u;
         
          map<String,String> stringMap = new map<String,String>();
          stringMap.put('cf','DOUBLE');
         EmailTempalteBodyGeneraterUtil.generateEmailBody(objMMIQuote.id,objOppty.Id,objAcc.id,objCon.id,'test',objEmailTemp.id);
         EmailTempalteBodyGeneraterUtil.mergeContactFields('test body',objCon.id);
         EmailTempalteBodyGeneraterUtil.mergeAccountFields('test Body',objAcc.id);
         EmailTempalteBodyGeneraterUtil.mergeOpportunityFields('test Body',objOppty.Id);
         EmailTempalteBodyGeneraterUtil.mergeQQFields('testbody',objMMIQuote.id);
         EmailTempalteBodyGeneraterUtil.mergeFQFields('testbody',objMMIFullQuote.id);
         EmailTempalteBodyGeneraterUtil.mergeAccountOwnerUserFields('testbody',u.id);
         EmailTempalteBodyGeneraterUtil.mergeUserFields('testbody',u.id);
         EmailTempalteBodyGeneraterUtil.typeConversion('test body','Account.Owner',objCon, 'Email',stringMap);
         EmailTempalteBodyGeneraterUtil.sendEmail('test Body');
   }
}