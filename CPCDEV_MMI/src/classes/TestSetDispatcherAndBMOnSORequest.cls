/*
	Test Class for SetDispatcherAndBMOnServiceOrderRequest
*/
@isTest
private class TestSetDispatcherAndBMOnSORequest {

    static testMethod void testBranchManager() {
       Account myAcct = New Account (Name='Test Account - TESTCreditCollector', credit_Collector__c = '200111');
	   insert myAcct;
	   
	   Service_Order_Request__c sor = new Service_Order_Request__c(Caller_s_Name__c = 'Test123',Caller_s_Phone__c = '124',Item_Type__c='IT-1',	Serial__c='S-1',Service_Issue_comment_section__c='service issue',Site_Name_Landmark__c='SNL',Site_Hours__c='12',Site_Address__c='SA', account_Name__c= myAcct.id);
	   insert sor;
    }
}