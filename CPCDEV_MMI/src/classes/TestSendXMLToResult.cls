@isTest
private class TestSendXMLToResult {

    static testMethod void checkSendXML() {
        Account acc = new Account(name ='Test');
        acc.BillingStreet = 'B-23 \n Himmel Street  ';
        acc.BillingCity = 'Molching';
        acc.BillingCountry = 'Germany';
        acc.BillingPostalCode = '123456';
        acc.Phone = '6263473034 123';
        
        insert acc;
        
        Contact con = new Contact();
        con.LastName = 'TestContact';
        con.AccountId = acc.id;
        con.MailingCity = 'Munich';
        con.MailingCountry = 'Germany';
        insert con;
        
        System.debug('Parth********');
        
        String response = SendXMLToResult.sendToResult(acc.id, con.Id);
        System.debug('Parth********response=' + response);
        SendXMLToResult.XMLResult result = new SendXMLToResult.XMLResult();
        String xml = '<Result><Success>true</Success><ResultID>12131241</ResultID><ErrorCode>555</ErrorCode><ErrorMessage>Test Msg</ErrorMessage></Result>';
        SendXMLToResult.readXML(xml, result);
        System.debug('Deepesh '+ response);
        
        Account acc1 = new Account(name ='Test');
        acc1.BillingStreet = 'B-23 Himmel Street  ';
        acc1.Phone = '6263473034';
        
        insert acc1;
        
         Contact con1 = new Contact();
         con1.LastName = 'TestContact';
         con1.AccountId = acc1.id;
         con1.MobilePhone = '626 347 3034';
         con1.HomePhone = '626 123 3333';
         con1.Email = 'test@testing.com';
         insert con1;
         response = SendXMLToResult.sendToResult(acc1.id, con1.Id);
         
         
    }
}