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
private class TestFullQuoteWrapper {

    static testMethod void myUnitTest() {
		FullQuoteWrapper fw = new FullQuoteWrapper();
		FullQuoteWrapper.lockTypesAndQuantity locktype = new FullQuoteWrapper.lockTypesAndQuantity();
		FullQuoteWrapper.stateInnerClass stateinner = new FullQuoteWrapper.stateInnerClass();
		FullQuoteWrapper.AddressInnerClass addressInnder = new FullQuoteWrapper.AddressInnerClass();
		FullQuoteWrapper.DescarteInnerClass desarteinn = new FullQuoteWrapper.DescarteInnerClass();
		FullQuoteWrapper.stdModification stdmodi = new FullQuoteWrapper.stdModification();
		FullQuoteWrapper.ApproverList apporlist = new FullQuoteWrapper.ApproverList();
		FullQuoteWrapper.quote quo = new FullQuoteWrapper.quote();
		FullQuoteWrapper.ProductSales productst = new FullQuoteWrapper.ProductSales();
		FullQuoteWrapper.SalesImages salesImag = new FullQuoteWrapper.SalesImages();
		FullQuoteWrapper.NewCustomerAccount newcust = new FullQuoteWrapper.NewCustomerAccount();
		FullQuoteWrapper.ContactEmailId contactEmai = new FullQuoteWrapper.ContactEmailId();
		FullQuoteWrapper.productTypes productty = new FullQuoteWrapper.productTypes();
		FullQuoteWrapper.productSizes productsie = new FullQuoteWrapper.productSizes(); 
	}	

}