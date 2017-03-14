@isTest
global class TestCreditMemoReqResp {
    static testmethod void saveCreditTest(){
       Test.startTest();
        Account acc = new Account();
            acc.name='test accounthart';
            acc.SAP_Bill_To__c = '0000800015';
            acc.SAP_Sold_To__c = '0000800015';
            
            acc.BillingState = 'AZ';
            acc.BillingCountry = 'US';
            acc.recordtypeid =  [select id,name from RecordType where name = 'Business Account'].ID;
            insert acc;
        
            Contact con = new Contact(LastName='TestHSundara');
        con.AccountId = acc.Id;
            con.Email = 'hsundara@teksystems.com';
            insert con;
        
        Service_Order_Request__c SORVar = new Service_Order_Request__c();
            SORVar.Account_Name__c = acc.Id;
            //SORVar.Account_ID__c = acc.Id;
            SorVar.Customer_Contact__c = con.Id;
            SORVar.Invoice_Number__c = '0090000040';     
            SORVar.Document_Category__c = 'M';
            SORVar.Invoice_Currency__c = 'USD';
            SORVar.Distribution_Channel__c = 10;
            SORVar.Document__c = '0000000077';
            RecordType CredMMIRecType = [SELECT id,Name, DeveloperName FROM RecordType WHERE isActive = true AND (sObjectType = 'Service_Order_Request__c' AND DeveloperName = 'Credits_MMI')];
            SORVar.RecordTypeId = CredMMIRecType.Id;
            SORVar.Date__c = Date.today();
            SORVar.Description__c = 'test desc';
            SORVar.Reason_for_Credit__c = 'Branch Error';
            SORVar.Branch_ID__c = '101';
            insert SORVar;
        Customer_Request_Invoice__c custReqInvVarToInsert = new Customer_Request_Invoice__c();
                                custReqInvVarToInsert.Condition_Type__c = 'ZP00';
                                custReqInvVarToInsert.Invoice_Currency__c = SORVar.Invoice_Currency__c;
                                custReqInvVarToInsert.Amount__c = 1691.4;
                                custReqInvVarToInsert.Conditional_Value__c = 10.00;
                                custReqInvVarToInsert.Item_Number__c = '000010';  
                                custReqInvVarToInsert.Customer_Request__c = SORVar.Id;
                                custReqInvVarToInsert.Contract_Number__c = SORVar.Document__c;    
                                  custReqInvVarToInsert.Description__c = SORVar.Description__c;
                                  custReqInvVarToInsert.Material__c = '40ZK';
                                  custReqInvVarToInsert.Plant__c = '1101';
                                  custReqInvVarToInsert.Quantity__c = 1;
                                  custReqInvVarToInsert.Unit_of_Measure__c = 'EA';
                                  custReqInvVarToInsert.Invoice_Number__c = '0090000040'; 
                                insert custReqInvVarToInsert;
        List<Id> idList = new List<Id>();
        idList.add(SORVar.Id);
        // SORVar.Status__c = 'In Process';
       // update SORVar;
        Test.setMock(WebServiceMock.class, new MockCreditMemoWebservice());
        CreditMemoReqResp.sendReq(idList);
        
    }
}