@isTest
private class ReceiveXMLFromResultTest{
    @isTest static void testReceiveXMLFromResult(){
        Account Acc = new Account();
        Acc.Name = 'Test';
        insert Acc;
        
        ReceiveXMLFromResult.ResultMessage RXFRRM = new ReceiveXMLFromResult.ResultMessage();
        RXFRRM.jobId = 'prospectToSales';
        RXFRRM.SalesforceID = Acc.Id;
        ReceiveXMLFromResult.ReceiveXMLFromResult(RXFRRM);
        RXFRRM.SalesforceID = '';
        ReceiveXMLFromResult.ReceiveXMLFromResult(RXFRRM);
        RXFRRM.jobId = 'quotation';
        RXFRRM.SalesforceID = Acc.Id;
        ReceiveXMLFromResult.ReceiveXMLFromResult(RXFRRM);
        RXFRRM.SalesforceID = '';
        ReceiveXMLFromResult.ReceiveXMLFromResult(RXFRRM);
    }
}