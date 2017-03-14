public with sharing class opportunityClosedWonDateTimeStamp {

	public Static VOID timeStampclosedWonLostOpportunities(List<Opportunity> closedWonLostOpportunities){
	
		for (integer i=0;i<closedWonLostOpportunities.size();i++){
			
			closedWonLostOpportunities[i].Opportunity_Closed_Date_Time__c = system.now();
			
		}
	
	}
	
	static testMethod void myUnitTest() {
	
		Account acct = New Account(Name='Apex Test Account');
		insert Acct;
		
		Opportunity oppty = New Opportunity(Name = 'Apex Test Opportunity', AccountId = acct.Id, StageName = 'Quoted - No Decision', CloseDate = system.today());
		insert oppty;
		
		oppty.StageName = 'Quoted - Won';
		oppty.Result_Rental_Sale_Doc__c = '944444444';
		update oppty;
		
		Opportunity updatedOppty = [Select Opportunity_Closed_Date_Time__c from Opportunity where id = :oppty.Id];
		//system.assertEquals(updatedOppty.Opportunity_Closed_Date_Time__c, oppty.Opportunity_Closed_Date_Time__c);
		
		oppty.StageName = 'Quoted - Pending Decision';
		update oppty;
		
		updatedOppty = [Select Opportunity_Closed_Date_Time__c from Opportunity where id = :oppty.Id];
		//system.assertEquals(updatedOppty.Opportunity_Closed_Date_Time__c, oppty.Opportunity_Closed_Date_Time__c);
		
		delete oppty;
		delete acct;	
	
	}

}