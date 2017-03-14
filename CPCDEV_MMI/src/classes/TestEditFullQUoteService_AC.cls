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
private class TestEditFullQUoteService_AC {

    static testMethod void myUnitTest() {
    
    	String jsontest =  Json.serialize(MMIFullquoteTestDataProvider.getEditFullQuoteData());
		
		
		EditFullQUoteService_AC editQuoteSer = new EditFullQUoteService_AC();
		editQuoteSer.parse(jsontest);
		EditFullQUoteService_AC.BillingContactDetails billinbCon = new EditFullQUoteService_AC.BillingContactDetails();
		EditFullQUoteService_AC.Rate1 rete = new  EditFullQUoteService_AC.Rate1();
		EditFullQUoteService_AC.RentalQuote rentalQuote = new EditFullQUoteService_AC.RentalQuote();
		EditFullQUoteService_AC.Lines  line= new  EditFullQUoteService_AC.Lines();
		EditFullQUoteService_AC.Extras  extras= new EditFullQUoteService_AC.Extras();
		EditFullQUoteService_AC.BillingAddress  billingAdd= new EditFullQUoteService_AC.BillingAddress();
		EditFullQUoteService_AC.ShippingContactDetails  Shippingcont= new EditFullQUoteService_AC.ShippingContactDetails();
		EditFullQUoteService_AC.ChargeCode  chargcode= new EditFullQUoteService_AC.ChargeCode();
		EditFullQUoteService_AC.Header header= new EditFullQUoteService_AC.Header();
		EditFullQUoteService_AC.ShippingAddress  shipingAd = new EditFullQUoteService_AC.ShippingAddress();
		EditFullQUoteService_AC.AnalysisSet1  analyset = new EditFullQUoteService_AC.AnalysisSet1();
		EditFullQUoteService_AC.Rate1_Z  ratelZ = new EditFullQUoteService_AC.Rate1_Z();
		EditFullQUoteService_AC.Selection  selection = new EditFullQUoteService_AC.Selection();
		
		System.assert(editQuoteSer != null);
		 
    }
}