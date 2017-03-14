@isTest
private class TestUpdateQuickQuoteService{
    @isTest static void test_UpdateQuickQuoteService(){
        User u=MMITestDataProvider.getUser();
        System.runAs(u) {
            Test.startTest();
            
            UpdateQuickQuoteService updateqq = new UpdateQuickQuoteService();
            updateqq.updateQuoteResponse = MMITestDataProvider.getMMIErrorResponse();
            system.assert(updateqq.updateQuickQuote('q1234','test')!=null);
            updateqq.updateQuoteResponse = MMITestDataProvider.getMMIExceptionResponse();
            //system.assert(updateqq.updateQuickQuote('q1234','test')!=null);
    
            
            
            Test.stopTest();
        }
    }
}