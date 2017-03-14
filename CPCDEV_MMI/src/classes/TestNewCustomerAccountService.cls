/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class TestNewCustomerAccountService {

    static testMethod void myUnitTest() {
    	User u=MMIFullquoteTestDataProvider.getUser();
		System.runAs(u) {
			Test.startTest();
			NewCustomerAccountService newAccountSer = new NewCustomerAccountService();
	        newAccountSer.callNewCustAccount('test', 'test','tesco', 'AZ', '58958', '58986586');
	        newAccountSer.createNewCustAccount('test','test','AZ', 'USA', '58968','2342323', '102','98765','50737','USA', 'TESCO');
	        newAccountSer.getRequest('test','test','TESCO','AZ','85685','986589865');
	        newAccountSer.getNewAccRequest('test', 'test', 'AZ','USA','856856','585685685','102', '987654','2342','USA','TESCO');
	        NewCustomerAccountService.NewCustAccRequest newAcc = new NewCustomerAccountService.NewCustAccRequest();
	        NewCustomerAccountService.CreateNewCustAccRequest creatNEwAcc =new NewCustomerAccountService.CreateNewCustAccRequest();
	        NewCustomerAccountService.ParseCreateNewResponse parseCreat = new NewCustomerAccountService.ParseCreateNewResponse();
			Test.stopTest();
		}
    }
}