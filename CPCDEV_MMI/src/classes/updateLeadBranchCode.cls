public with sharing class updateLeadBranchCode {

	public static Map<String,Branch_Lookup__c> zipBranches = new Map<String,Branch_Lookup__c>();
	Public Static VOID updateBranchCodesOnLead(Set<ID> ownerIds, List<Lead> leadsToUpdate){
	
		Map<ID, String> userToBranchCodeMap = New Map<ID, String>();
		
		User[] u = [Select Id,IsActive,Branch_Id__c from User where IsActive = True and ID in :ownerIds];
		
		// Build the user map
		for (integer i=0;i<u.size();i++){
	
			// See if we already have this key (User ID)
			Boolean contains = userToBranchCodeMap.containsKey(u[i].Id);
			if (contains == false){
				userToBranchCodeMap.put(u[i].Id, u[i].Branch_Id__c);
			}

		}
		
		// Update the contacts
		for (integer i=0;i<leadsToUpdate.size();i++){
			leadsToUpdate[i].branch__c = userToBranchCodeMap.get(leadsToUpdate[i].OwnerId);
		}
	
	}
	
	public static void updateServiceBranchId(List<Lead> leadsToUpdate, Set<String> postalCodes){
		for(Branch_Lookup__c branch:[Select b.Zip__c, b.Branch_Name__c, b.Branch_Code__c ,b.Country__c, 
        						    b.NSC_Team__c, b.NSC_Team_Live__c,b.Sales_Manager_ID__c,b.National_Account_Manager_ID__c  From Branch_Lookup__c b
                                    where b.Zip__c in : postalCodes]){
           zipBranches.put(branch.zip__c,branch);
        }
        for(Lead newLead:leadsToUpdate){
       		String zipCode = AssignmentRules.getZipCode(newLead);
       		String branchCode=getBranchCode(zipCode);
       		if(branchCode!=''){
         		 newLead.Servicing_Branch_Id__c = branchCode;
          		System.debug('------Service Branch Id -------'+newLead.Servicing_Branch_Id__c);
           }
      }	
	}
	
	private static String getBranchCode(String zipCode)
    {
	   String branchCode='';
	   Branch_Lookup__c branch = getBranchLookup(zipCode);
	   if(branch!=null){
	    	branchCode = branch.Branch_Code__c;
	   }
       return branchCode;
        
    }
    private static Branch_Lookup__c getBranchLookup(String zipCode)
    {
       Branch_Lookup__c branch;
       if (zipCode != null){
         zipCode = zipCode.toUpperCase();
       }
       if(zipBranches.containsKey(zipCode)){   
         branch = zipBranches.get(zipCode);
      }
      return branch;
        
    }
	static testMethod void myUnitTest() {
	
		User salesRep1 = [Select Id, Branch_Id__c from User where Branch_id__c = '101' and isActive = true LIMIT 1];

		User salesRep2 = [Select Id, Branch_Id__c from User where Branch_id__c = '102' and isActive = true LIMIT 1];
	
		Lead newLead = New Lead(LastName = 'Test APEX Contact', Company = 'Apex Test Company', OwnerID = salesRep1.Id);
		
		insert newLead;

		newLead.ownerid = salesRep2.Id;
		
		update newLead;

		Lead queryNewLead = [Select Id, Branch__c from Lead where Id = :newLead.Id];
		system.assertEquals(queryNewLead.Branch__c, salesRep2.Branch_Id__c);

		delete newLead;
	
	}

}