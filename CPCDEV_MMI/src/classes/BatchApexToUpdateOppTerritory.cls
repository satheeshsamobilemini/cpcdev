global class BatchApexToUpdateOppTerritory implements Database.Batchable<sObject>{
	global BatchApexToUpdateOppTerritory(){
                   // Batch Constructor
   }
	// Start Method
	global Database.QueryLocator start(Database.BatchableContext BC){
 		String query = 	'Select o.Territory__c, o.Territory_Owner__c, o.Shipping_Territory__c, o.Servicing_Branch__c, o.Selling_Region__c, o.Id, o.Delivery_Zip_Postal_Code__c, o.Billing_Zip_Postal_Code__c,o.is_Territory_update__c From Opportunity o where o.is_Territory_update__c = false and (o.Delivery_Zip_Postal_Code__c != null or o.Billing_Zip_Postal_Code__c != null)';
    	return Database.getQueryLocator(query);
	}
   // Execute Logic
    global void execute(Database.BatchableContext BC, List<sObject> scope){
            // Logic to be Executed batch wise      
 			list<Opportunity> oppToUpdate = new list<Opportunity>();
			for (Sobject s : scope){
				Opportunity a = (Opportunity)s;
				a.is_Territory_update__c = true;
			    oppToUpdate.add(a);
			}
			if(oppToUpdate.size() > 0){
				update oppToUpdate;
			}
     }
   global void finish(Database.BatchableContext BC){
         // Logic to be Executed at finish
   }
}