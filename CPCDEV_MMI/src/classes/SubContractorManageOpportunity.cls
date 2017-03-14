public without sharing class SubContractorManageOpportunity {

	public static VOID ProcessSubContractors(List<Sub_Contractor__c> newSubcontractors){
	    List<Opportunity> newOpportunities = New List<Opportunity>();
		List<Task> newTasks = New List<Task>();
		List<ID> acctNewIds = New List<ID>();
		String jobProfileID = '';

       /*  List<RecordType> opportunityRTLst = [select Id ,Name from RecordType where Name ='Standard Opportunity' and SobjectType ='Opportunity'];
        RecordType stdOpportunityRecordId;
        if(opportunityRTLst!=null && opportunityRTLst.size()>0){
            stdOpportunityRecordId = opportunityRTLst.get(0);
        }	*/
	
		date opptyCloseDate = date.today();
		system.debug('newSubcontractors=====>>>>>>>>'+newSubcontractors);
		String opptyName = ''; 
		// Loop
		for (Sub_Contractor__c subc : newSubcontractors){
             //opptyName = subc.Account_Name__c + ' - ' + subc.Job_Profile_Name__c;
			//if (opptyName.length() > 120) opptyName = opptyName.subString(0,120); 
            jobProfileID = subc.Job_Profile__c;
            system.debug('Owner=====>>>>>>>>'+subc.Account_Owner__c);
			//newOpportunities.add(new Opportunity(RecordType = stdOpportunityRecordId, OwnerId = subc.Account_Owner__c, Name = opptyName, AccountID = subc.Account__c, Job_Profile__c = subc.Job_Profile__c, StageName = 'Not Quoted', CloseDate = opptyCloseDate, Sub_Contractor_Role__c = subc.Role__c, Type = 'Existing Business', Opportunity_Rating__c = 'Hot (Probably Order)', LeadSource = 'Job Profile', Servicing_Branch__c = subc.Job_Profile_Branch_ID__c));
			newTasks.add(new Task( Lead_Rating__c = 'Hot (Probably Order)', Subject = 'Sub Contractor Awarded Bid', ActivityDate = opptyCloseDate, WhatId = subc.Account__c, Call_Type__c = 'Job Profile Follow Up', Job_Profile_Id__c = jobProfileID.subString(0,15), OwnerId = subc.Account_Owner__c ));

		}

		// Insert New Tasks
		if (newTasks.size()>0){
			try{
				/*insert newOpportunities;
				for(Opportunity opp : newOpportunities){
					newTasks.add(new Task( Lead_Rating__c = 'Hot (Probably Order)', Subject = 'Sub Contractor Awarded Bid', ActivityDate = opptyCloseDate, WhatId = opp.Id, Call_Type__c = 'Job Profile Follow Up', Job_Profile_Id__c = opp.Job_Profile__c, OwnerId = opp.OwnerId ));
				}*/
				insert newTasks;
			}catch(exception e){
				system.debug('$$$$ --> An Exception Occurred: ' + e);
				throw e;
			}
		}
	}

}