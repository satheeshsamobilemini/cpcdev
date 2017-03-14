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
private class TestCreateProspectAccount_AC {

    static testMethod void myUnitTest() {
		User u=MMIFullquoteTestDataProvider.getUser();
		System.runAs(u) {
			Test.startTest();
			HomeBaseBeans.ProspectAccountParam prose = MMIFullquoteTestDataProvider.getHomeBaseBeansProspectAccountParam();
			
			CreateProspectAccount_AC createProsAc = new CreateProspectAccount_AC();
			createProsAc.ProspectAcct(prose);
            String xmlString = '<?xml version="1.0"?>'+'<goldmineImporter><Company>test</Company>'+'<SalesforceID>123</SalesforceID>'+'<Contact>123</Contact>'+'<Address1>test</Address1><Address2></Address2>'+'<Address3></Address3>'+'<City>tesc</City>'+'<State>az</State>'+'<Zip>123</Zip><Country>usa</Country>'+'<Phone1>123</Phone1><Phone2></Phone2><Phone3></Phone3>'+'<FAX></FAX><Email></Email>'+'<RepCode>1234</RepCode>'+'<BranchCode>34</BranchCode><WebSite></WebSite>'+'<JobTitle></JobTitle><Ext1></Ext1><Salutation></Salutation>'+'<ResultParent></ResultParent><ResultID></ResultID>'+'</goldmineImporter>';
            XmlStreamReader reader = new XmlStreamReader(xmlString); 
            createProsAc.getTextValue(reader);
			CreateProspectAccount_AC.ResponseObj innerRespo = new CreateProspectAccount_AC.ResponseObj();
			createProsAc.parseResponse('<?xml version="1.0"?>'+'<goldmineImporter><Company>test</Company>'+'<SalesforceID>123</SalesforceID>'+'<Contact>123</Contact>'+'<Address1>test</Address1><Address2></Address2>'+'<Address3></Address3>'+'<City>tesc</City>'+'<State>az</State>'+'<Zip>123</Zip><Country>usa</Country>'+'<Phone1>123</Phone1><Phone2></Phone2><Phone3></Phone3>'+'<FAX></FAX><Email></Email>'+'<RepCode>1234</RepCode>'+'<BranchCode>34</BranchCode><WebSite></WebSite>'+'<JobTitle></JobTitle><Ext1></Ext1><Salutation></Salutation>'+'<ResultParent></ResultParent><ResultID></ResultID>'+'</goldmineImporter>');
			CreateProspectAccount_AC.ResponseObj innerrclass = new CreateProspectAccount_AC.ResponseObj();
			Test.stopTest();
		}
	}  // TO DO: implement unit test
}