@isTest
private class ProcessOnLeadsByEmailServiceBlueBookTest{
    @isTest static void testProcessOnLeadsByEmailServiceBlueBook(){
        
        // Create a new email, envelope object and an Attachment
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
        email.subject = 'Test Job Applicant';
        email.fromname = 'FirstName LastName';
        env.fromAddress = 'someaddress@email.com';
        
        
        // set the binary attachment
        Messaging.InboundEmail.BinaryAttachment inboundAttachment = new Messaging.InboundEmail.BinaryAttachment();
        inboundAttachment.body = blob.valueOf('test');
        inboundAttachment.fileName = 'Email_Attachment.txt';
        inboundAttachment.mimeTypeSubType = 'text/plain';
        email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { inboundAttachment }; 
        
        // add an Text atatchment
        Messaging.InboundEmail.TextAttachment attachmenttext = new Messaging.InboundEmail.TextAttachment();
        attachmenttext.body = 'my attachment text';
        attachmenttext.fileName = 'textfiletwo3.txt';
        attachmenttext.mimeTypeSubType = 'texttwo/plain';
        email.textAttachments =   new Messaging.inboundEmail.TextAttachment[] { attachmenttext };
        
        // add an Text atatchment for j string 0
        Messaging.InboundEmail.TextAttachment attachmenttext2 = new Messaging.InboundEmail.TextAttachment();
        attachmenttext2.body = 'my attachment text\n';
        attachmenttext2.fileName = 'textfiletwo3.txt';
        attachmenttext2.mimeTypeSubType = 'texttwo/plain';
        email.textAttachments =   new Messaging.inboundEmail.TextAttachment[] { attachmenttext2 };
       
        Test.startTest();
        // create an instance of the EmailToSalesForce class and test it with the data in the testMethod
        ProcessOnLeadsByEmailServiceBlueBook emailServiceObj = new ProcessOnLeadsByEmailServiceBlueBook();
        emailServiceObj.handleInboundEmail(email, env );  
        emailServiceObj.processAttachment(attachmenttext.body);
        emailServiceObj.processAttachment(attachmenttext2.body);
        ProcessOnLeadsByEmailServiceBuyerzone POLBESBZ = new ProcessOnLeadsByEmailServiceBuyerzone();
        POLBESBZ.handleInboundEmail(email, env);
        Test.stopTest();
    }
    
}