global class BatchApexToUpdateAccountTerritory implements Database.Batchable<sObject>{
	global BatchApexToUpdateAccountTerritory(){
                   // Batch Constructor
   }
	// Start Method
	global Database.QueryLocator start(Database.BatchableContext BC){
 		String query = 	'Select a.Territory__c, a.BillingPostalCode, a.BillingCountry,a.Sic_Code__c,a.is_Territory_update__c,a.is_Branch_account_updated__c,a.Owner.Name From Account a  where is_Branch_account_updated__c = false and BillingPostalCode != null and Owner.Name = \'Branch Account\'';
    	return Database.getQueryLocator(query);
	}
   // Execute Logic
    global void execute(Database.BatchableContext BC, List<sObject> scope){
            // Logic to be Executed batch wise      
 			list<Account> accToUpdate = new list<Account>();
			for (Sobject s : scope){
				Account a = (Account)s;
				a.is_Branch_account_updated__c = true;
			    accToUpdate.add(a);
			}
			if(accToUpdate.size() > 0){
				update accToUpdate;
			}
     }
   global void finish(Database.BatchableContext BC){
         // Logic to be Executed at finish
   }
}