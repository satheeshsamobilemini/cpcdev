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
private class TestAddContactCardAch {

    static testMethod void myUnitTestAddContact() {
        // TO DO: implement unit test
        User userObj = MMIFullquoteTestDataProvider.getUser();
        System.runAs(userObj){
	        test.startTest();
	        AccContactService ac = new AccContactService();
	        ac.listContacts('102','50737');
	        ac.SpecificContacts('2','50737');
	        ac.AddContacts('102','50737','sdfdsfdsfsd','add');
	        ac.AddContacts('102','50737','sdfdsfdsfsd','update');
	        test.stopTest();
		}
    }
    
    static testMethod void myUnitTestAddCardAndAch() {
        // TO DO: implement unit test
        User userObj = MMIFullquoteTestDataProvider.getUser();
        System.runAs(userObj){
	        test.startTest();
	        
	        AddCardServices ac = new AddCardServices();
	        ac.listCards('2', '50737');
	        ac.SpecificCards('23423423','254252435','234234324');
	        ac.AddCard('result', 'adsfsd sdf sdf sgfsdg s');
	        ac.UpdateCard('result', 'adsfsd sdf sdf sgfsdg s');
	        ac.AddAutoCheck('result','adsfsd sdf sdf sgfsdg s');
	        ac.UpdateAutoCheck('result','adsfsd sdf sdf sgfsdg s');
	        //ac.AddCardWithQuote('result','adsfsd sdf sdf sgfsdg s');
	        
	        test.stopTest();
		}
    }
}