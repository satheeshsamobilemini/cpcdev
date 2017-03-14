@isTest
public class TestBatchAccountSICCode {
    @isTest static void testSubAccountSicc(){
        Sic_Code_Lookup__c objSic = new Sic_Code_Lookup__c();
         objSic.Name = 'test';
         objSic.Industry__c = 'test';
         objSic.Description__c = 'test description';
        Insert objSic;
        
        Account objAcc = new Account();
          objAcc.Name = 'testAcc';
          objAcc.Type = 'Prospect - National Account';
          objAcc.IsChecked__c = false;
          objAcc.Sic_Code__c = objSic.Id;
        Insert objAcc;
        
        BatchAccountSICCode BA = new BatchAccountSICCode();
           Database.executeBatch(BA);
    }
}