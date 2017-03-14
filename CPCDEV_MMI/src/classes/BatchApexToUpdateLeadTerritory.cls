global class BatchApexToUpdateLeadTerritory implements Database.Batchable<sObject>{
	global BatchApexToUpdateLeadTerritory(){
                   // Batch Constructor
   }
	// Start Method
	global Database.QueryLocator start(Database.BatchableContext BC){
 		String query = 	'Select l.IsConverted,l.Territory__c, l.Shipping_Territory__c, l.Selling_Region__c, l.PostalCode, l.Id, l.Delivery_Postal_Code__c,l.is_Territory_update__c From Lead l where l.is_Territory_update__c = false and (l.PostalCode != null or l.Shipping_Territory__c != null) and l.IsConverted = false';
    	return Database.getQueryLocator(query);
	}
   // Execute Logic
    global void execute(Database.BatchableContext BC, List<sObject> scope){
            // Logic to be Executed batch wise      
 			list<Lead> ldToUpdate = new list<Lead>();
			for (Sobject s : scope){
				Lead l = (Lead)s;
				l.is_Territory_update__c = true;
			    ldToUpdate.add(l);
			}
			if(ldToUpdate.size() > 0){
				update ldToUpdate;
			}
     }
   global void finish(Database.BatchableContext BC){
         // Logic to be Executed at finish
   }
}