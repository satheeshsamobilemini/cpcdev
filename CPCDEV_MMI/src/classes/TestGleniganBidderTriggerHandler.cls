/******************************************************************************* 
Class                   :   TestGleniganBidderTriggerHandler
Related Class           :   GleniganBidderTriggerHandler
Created By              :   Bharti Mehta(Appirio Offshore)
Created On              :   Feb 20, 2013
Description             :   Test Class for GleniganBidderTriggerHandler. 
********************************************************************************/
@isTest
private class TestGleniganBidderTriggerHandler {
	
	static Glenigan_Bidder__c bidder;
	static String HOT_RATING = 'Hot (Probably Order)';    
	static String WARM_RATING = 'Warm (Possibly Order)';
	static String GLENIGAN_DEFAULT_LEAD_INDUSTRY = '5-Construction';
	
	static testMethod void myUnitTest() {
		createTestData();
				
		Test.startTest();
		
		// Insert bidder and then check that new lead has been inserted.
		insert bidder;		
		List<Lead> leadList = [SELECT Id, Glenigan_Bidder__c, Glenigan_Project__c, 
																	Rating, Industry
													 FROM Lead 
													 WHERE Glenigan_Bidder__c = :bidder.Id ];
		System.assertEquals( 1, leadList.size() );
		System.assertEquals( bidder.Glenigan_Project__c, leadList.get(0).Glenigan_Project__c );
		System.assertEquals( WARM_RATING, leadList.get(0).Rating );
		System.assertEquals( GLENIGAN_DEFAULT_LEAD_INDUSTRY, leadList.get(0).Industry );
		
		// Update bidder.Awarded__c and check that lead.Rating has been updated.		
  	bidder.Awarded__c = true;
		update bidder;		
		leadList = [SELECT Id, Glenigan_Bidder__c, Rating
								FROM Lead 
								WHERE Glenigan_Bidder__c = :bidder.Id ];
		System.assertEquals( HOT_RATING, leadList.get(0).Rating );													 
		
		Test.stopTest();
	}
  
  private static void createTestData() {
  	
  	Manage_Triggers__c triggerCustomSetting = new Manage_Triggers__c(Name = 'SendDeadLeadTo360IntegrationService');
    insert triggerCustomSetting;
        
  	Glenigan_Project__c gleniganProj = new Glenigan_Project__c();
  	gleniganProj.pttitle__c = 'Test Glenigan Project';
  	gleniganProj.Branch_ID__c = '754';
  	insert gleniganProj;
  	
  	bidder = new Glenigan_Bidder__c();
  	bidder.Glenigan_Project__c = gleniganProj.Id;
  	bidder.Fname__c = 'Fname';
  	bidder.Lname__c = 'Lname';
  	bidder.Email__c = 'test@abc.com';
  	bidder.Cyname__c = 'test cyname';
  	bidder.Cyno__c = 00000000;  	  	
  }  
}