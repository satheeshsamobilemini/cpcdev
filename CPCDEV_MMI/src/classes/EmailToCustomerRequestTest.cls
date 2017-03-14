@isTest private class EmailToCustomerRequestTest{
 
 static testmethod void myTestClass(){
   Messaging.InboundEmail mail = new Messaging.InboundEmail();
   Messaging.InboundEmail mail2 = new Messaging.InboundEmail();
   Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
   List<String> mailAddressList = new List<String>{'billingres@test.com'};
   List<String> ccmailAddressList = new List<String>{'ccbllngsty@test.com'};  // TFS 7944..
   
   Messaging.InboundEmail.TextAttachment tAttch = new Messaging.InboundEmail.TextAttachment();
   tAttch.fileName = 'Test Text Attchment';
   tAttch.Body = 'Text Email Attachment Content';
   List<Messaging.InboundEmail.TextAttachment> mailTextAttchList = new List<Messaging.InboundEmail.TextAttachment>{tAttch}; 
   
   Messaging.InboundEmail.BinaryAttachment bAttch = new Messaging.InboundEmail.BinaryAttachment();
   bAttch.fileName = 'Test Binary Attachment';
   bAttch.Body = Blob.valueOf('Binary Email Attachment Content');
   List<Messaging.InboundEmail.BinaryAttachment> mailBinAttchList = new List<Messaging.InboundEmail.BinaryAttachment>{bAttch};
   
   mail.ToAddresses = mailAddressList;
   mail.ccAddresses = ccmailAddressList;   // TFS 7944..
   mail.PlainTextBody = 'Hi, This is a test mail..';
   mail.subject = 'Test Email To Customer Request';
   mail.TextAttachments = mailTextAttchList;
   mail.BinaryAttachments = mailBinAttchList;
      
   mail2.ToAddresses = mailAddressList;
   mail2.ccAddresses = ccmailAddressList;   // TFS 7944..
   mail2.PlainTextBody = 'Hi, This is a test mail..';
   mail2.subject = 'Test Email To Customer Request [ref : a0d8A0000005kSKQAY]';
      
   EmailToCustomerRequest__c ecr = new EmailToCustomerRequest__c(Name='TestEmailCustomerRequest');
   //ecr.Email_RecordType_QueueId__c  = 'billingres#Billing Terms (MMI) 1000;Billing Resolution Queue;';
   ecr.Email_RecordType_QueueId__c  = 'ct#Insurance Forms (MMI) 1000;Billing Resolution Queue';
   insert ecr; 
   
   EmailToCustomerRequest emc = new EmailToCustomerRequest();
   
   Test.startTest();
    Messaging.InboundEmailResult res = emc.handleInboundEmail(mail,envelope);
    Messaging.InboundEmailResult res2 = emc.handleInboundEmail(mail2,envelope);
   Test.stopTest();
 }
 
}