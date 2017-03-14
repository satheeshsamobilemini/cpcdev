/*****************************************************************************
 * Name             	: TestSendDeadLeadTo360IntegrationService.cls
 * Created By       	: Bharti Bhandari(Appirio Offshore)
 * Last Modified Date : 15 March, 2012.
 * Description        : Test class for SendDeadLeadTo360IntegrationService.Trigger
 *****************************************************************************/
@isTest
private class TestSendDeadLeadTo360IntegrationService {
		//Test method to check the Quality of code
  	static testMethod void myUnitTest() {
  		//Start Testing
			Test.startTest();
				//Create a lead record to fire a trigger on Insert event
				Lead lead = createLead(true);
				//Update lead to fire a trigger on update event.
				lead.Reason_Lead_Dead__c = 'Other';
				update lead;
            
        	IntegrationServiceInterface.IntegrationServiceSoap   intService = new IntegrationServiceInterface.IntegrationServiceSoap();
            IntegrationServiceInterface.HelloWorld_element helement = new IntegrationServiceInterface.HelloWorld_element();
            IntegrationServiceInterface.ImportResponse_element  ire = new IntegrationServiceInterface.ImportResponse_element();
            IntegrationServiceInterface.HelloWorldResponse_element  hre = new IntegrationServiceInterface.HelloWorldResponse_element();
            
        
			Test.stopTest();
    }
    //A method that is used to create a lead record
    static Lead createLead(Boolean isInsert){
    	Lead lead = new Lead();
			lead.Auto_Assign_Lead__c = false;
			lead.Branch__c = '101';
			lead.currencyisocode = 'USD';
			lead.Decision_Maker__c = 'No';
			lead.DoNotCall = false;
			lead.email = 'test@test.com';
			lead.Existing_Account_Owned_By_Branch__c = false;
			lead.Existing_Account_Owned_By_Rep__c = false;
			lead.HasOptedOutOfEmail = false;
			lead.HasOptedOutOfFax = false;
			lead.Industry = '1-Homeowner/Misc. Storage';
			lead.Lead_ID_Opportunity__c = null;
			lead.Lead_Reminder_Time__c = DateTime.now();
			lead.Lead_Status_Workflow__c = 'Dead Lead';
			lead.Status = 'Dead Lead';
			lead.LeadSource = 'MMI US Website';
			lead.Mess_Units__c = false;
			lead.Mobile_Offices__c = true;
			lead.NumericPhone__c = '6314232220';
			lead.FirstName = 'David';
			lead.LastName = 'Test';
			lead.Office_Containers__c = true;
			lead.phone = '631-423-2220';
			lead.Portable_Accommodation__c = false;
			lead.Primary_Contact_Method__c = 'phone';
			lead.Reason_Lead_Dead__c = 'Cartage';
			lead.Reason_Lead_Dead_Comments__c = 'Blank';
    	//Insert lead if isInsert true
    	if(isInsert)
    		insert lead;
    	return lead;
    }
}