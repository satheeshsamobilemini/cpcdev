@isTest
private class TestQuickQuoteErrorHandler{
    @isTest static void testQuickQuoteErrorHandler(){
        Test.startTest();
        //System.assert(QuickQuoteErrorHandler.handleError(MMITestDataProvider.getMMIErrorResponse())!=null);
        //System.assert(QuickQuoteErrorHandler.handleError(MMITestDataProvider.getMMIExceptionResponse())!=null);
        QuickQuoteErrorHandler.parseErr innrClass = new QuickQuoteErrorHandler.parseErr();

        Test.stopTest();
        
    }
}