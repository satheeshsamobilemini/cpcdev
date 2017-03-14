@isTest
public class TestLivePersonLeadCreation {
    @isTest static void livePersonCreation(){
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        Messaging.InboundEmail.BinaryAttachment inAtt = new Messaging.InboundEmail.BinaryAttachment();
        
        email.subject = 'test';
        env.fromAddress = 'user@acme.com';
        
        // set the body of the attachment
        inAtt.body = blob.valueOf('tesBJJKHBJFGBJKFJHFGGGt');
        inAtt.fileName = 'my attachment name';
        inAtt.mimeTypeSubType = 'plain/txt';
        email.plainTextBody = 'gbj  [From Name:] fgnbvjh  \r\n [From e-mail address:test@gmail.com ] hghj  \r\n [Phone Number:] \r\n hgjf[Message/Comments:] kdhg fd \n';
        email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] {inAtt }; 
           Lead objLead = new Lead();
              objLead.FirstName = 'test1';
              objLead.LastName = 'test2';
              objLead.Company = 'tek';
              objLead.Phone ='96235698547';
              objLead.Email = 'test@tesk.com';
           insert objLead;
        LivePersonLeadCreation LPC = new LivePersonLeadCreation();
        LPC.handleInboundEmail(email, env);
    }
}