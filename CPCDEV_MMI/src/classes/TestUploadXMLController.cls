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
private class TestUploadXMLController {

    static testMethod void testUploadXML() 
    {
        PageReference pageRef = Page.UploadXML;
	    Test.setCurrentPage(pageRef);
	    //String xml='<?xml version="1.0" encoding="UTF-8"?><quoteList><quote><quoteId>3781432</quoteId><categoryName>Office Trailers</categoryName><categoryId>798</categoryId><quoter><contactInfo><address><street>225</street><street2/><city>Waltham</city><state><stateName>Massachusetts</stateName><stateAbbreviation>MA</stateAbbreviation></state><zip>02452</zip></address><phone><phoneFreeText>1-617-987-9876 ex 102</phoneFreeText><numericPhone>6179879876102</numericPhone></phone><email><emailAddress>testbuyerzone@gmail.com</emailAddress></email></contactInfo><personalInfo><lastName>Buyerzone</lastName><firstName>testingUpload</firstName><fullName>testingUpload Buyerzone</fullName></personalInfo><businessInfo><companyName>Buyerzone</companyName><title>CEO/President/Owner</title><industry>Biotech/Pharmaceuticals</industry><companySize>500-999</companySize></businessInfo></quoter><requestDetails><questionWithAnswers><answer>Sales office</answer><question>Primary use for the office trailer:</question><priorityLevel>0</priorityLevel></questionWithAnswers><questionWithAnswers><answer>3</answer><question>Number of office trailers buyer is interested in:</question><priorityLevel>0</priorityLevel></questionWithAnswers><questionWithAnswers><answer/><question>If buyer indicated 4+ exact number interested in:</question><priorityLevel>0</priorityLevel></questionWithAnswers><questionWithAnswers><answer>11-24</answer><question>Number of people office trailer will need to accomodate:</question><priorityLevel>0</priorityLevel></questionWithAnswers><questionWithAnswers><answer>More than 800 square feet</answer><question>Square footage required for office trailer:</question><priorityLevel>0</priorityLevel></questionWithAnswers><questionWithAnswers><answer>12 to 24 months</answer><question>Number of months buyer expects to need the office trailer:</question><priorityLevel>0</priorityLevel></questionWithAnswers><questionWithAnswers><answer>Purchase</answer><question>Buyer \'s preferred method of finance:</question><priorityLevel>0</priorityLevel></questionWithAnswers><questionWithAnswers><answer>In two months</answer><question>When buyer would like office trailers delivered:</question><priorityLevel>0</priorityLevel></questionWithAnswers><questionWithAnswers><answer>02452</answer><question>Desired location for office trailer:</question><priorityLevel>0</priorityLevel></questionWithAnswers><questionWithAnswers><answer>1</answer><question>Number of half baths needed (if applicable):</question><priorityLevel>0</priorityLevel></questionWithAnswers><questionWithAnswers><answer>1</answer><question>Number of private offices needed (if applicable):</question><priorityLevel>0</priorityLevel></questionWithAnswers><questionWithAnswers><answer>test</answer><question>Additional requirements:</question><priorityLevel>0</priorityLevel></questionWithAnswers></requestDetails></quote></quoteList>';
	    
	    String leadName = 'testLead';
	    Integer count = 0;
	    
	    while(true) {
	       String name = leadName + count;
	       List<Lead> leadList = [Select Id from Lead where FirstName = :name and LastName = :name];
	       if (leadList.size() == 0)
	           break;
	       
	       count++;
	    }
	    
	    String xml = leadName + count;
	    ApexPages.currentPage().getParameters().put('xml',xml );
	    
	    uploadXMLController cont = new  uploadXMLController();
	    cont.createLead();
	    
	    // System.assert( cont.lstLeads.size()>0);
	    
	    /*
	    List<Lead> leads=[Select id,FirstName,LastName,Lead_ID__c,Product_Interest__c,Company,Title,Number_of_Employees__c,
                        Industry,Phone,Email,Street,City,PostalCode,State,Fax,LeadSource,Auto_Assign_Lead__c,
                        Status,CurrencyIsoCode
                         from Lead where firstName='testingUpload' and lastName='Buyerzone'];
	    */
	    
	    List<Lead> leads=[Select Id
	    				 from Lead where FirstName = :xml and LastName = :xml];
    
    	System.assert(leads.size() == 1);
    	/*
    	System.assertEquals( leads[0].FirstName,'testingUpload');
    	System.assertEquals( leads[0].LastName,'Buyerzone');
    	System.assertEquals( leads[0].Lead_ID__c,'3781432');
    	
    	System.assertEquals( leads[0].Product_Interest__c,'798');
    	System.assertEquals( leads[0].Company,'Buyerzone');
    	System.assertEquals( leads[0].Title,'CEO/President/Owner');
    	System.assertEquals( leads[0].Number_of_Employees__c,'500-999');
    	System.assertEquals( leads[0].Industry,'Biotech/Pharmaceuticals');
    	System.assertEquals( leads[0].Phone,'1-617-987-9876 ex 102');
    	System.assertEquals( leads[0].Email,'testbuyerzone@gmail.com');
    	System.assertEquals( leads[0].Street,'225');
    	System.assertEquals( leads[0].City,'Waltham');
    	System.assertEquals( leads[0].PostalCode,'02452');
    	System.assertEquals( leads[0].State,'MA');
    	System.assertEquals( leads[0].Fax,null);
    	System.assertEquals( leads[0].LeadSource,'BuyerZone');
    	System.assertEquals( leads[0].Auto_Assign_Lead__c,true);
    	System.assertEquals( leads[0].Status,'Open');
    	System.assertEquals( leads[0].CurrencyIsoCode,'USD');
    	*/
    }
}