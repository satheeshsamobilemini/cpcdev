/**
* (c) 2015 TEKsystems Global Services
*
* Name           : TestViewMoreController
* Created Date   : 17 August, 2015 @ 1130
* Created By     : Vivek
* Purpose        : Test class for ViewMoreController class.
* 
**/

@isTest
public class TestDataForcontracts{
    static testmethod void testdataCntrct() {
        doCallOut();
        doUORCallOut();
        doFinCallOut( );
        DataForcontracts.getCollectorNotesData('customer','segment','sinceDate','recType');
    }

 private static void doCallOut( ){
        date dt=date.today();
        date stdt = dt.addMonths(-12);
        string CON_ST_DAT=String.valueOf(dt);
        string CON_EN_DAT=String.valueOf(stdt);
        Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
        sapComDocumentSapRfcFunctions.ZSD_CONTRACT_SEARCH_Response_element contractsList= DataForcontracts.fetchContractsFromResponse('800015','100',CON_ST_DAT,CON_ST_DAT,'','','');
       //List<AccountDashboardCntrl.Wrapperforcontracts> contractsList = AccountDashboardCntrl.getContracts('800015','Business Account - UK','100',CON_ST_DAT,CON_EN_DAT,'','',''); 
    }
    
    private static void doUORCallOut( ){
        date dt=date.today();
        date stdt = dt.addMonths(-12);
        string CON_ST_DAT=String.valueOf(dt);
        string CON_EN_DAT=String.valueOf(stdt);
        Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
        Integer i =DataForcontracts.fetchUORsFromResponse('800015','100',CON_ST_DAT,CON_ST_DAT,'','','');
       
    }
    
   
    private static void doFinCallOut( ){
        Test.setMock(WebServiceMock.class, new WebServiceFinMockImpl());
        sapComDocumentSapRfcFunctionsFin.ZFIF_FINANCIAL_SUMMARY_Response_element finSum = DataForcontracts.fetchFinancialSummaryFromCPQResponse('800015','1000');
        //AccountDashboardCntrl.FinancialSummaryWrapper finSum = AccountDashboardCntrl.getFinSumData('800015','1000'); 
    }
}