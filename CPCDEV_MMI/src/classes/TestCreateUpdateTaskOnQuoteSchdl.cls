@isTest
public class TestCreateUpdateTaskOnQuoteSchdl {
      static testmethod void testCreateUpdateQuoteSchdl() {
           Test.startTest();
        
              String jobId = System.schedule('test Followup Task Create Update on Quote hourly','0 0 * * * ?',new CrtUpdateTaskOnQuoteCrtUpdateSchdl() );
        
           Test.stopTest();
    
      } 
}