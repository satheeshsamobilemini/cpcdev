global class BatchApexToUpdateLead implements Database.Batchable<sObject>{
     
         global BatchApexToUpdateLead(){
                   // Batch Constructor
        }
        
           // Start Method
         global Database.QueryLocator start(Database.BatchableContext BC){
         	String query = 	'select Id,Company_Metaphone_Key__c,Street_Address_Metaphone_Key__c, Company, Street,FirstName,LastName from Lead where IsConverted = false and Soundex_updated__c = false and Status != \'Dead Lead\'';
          	return Database.getQueryLocator(query);
         }
       
       // Execute Logic
         global void execute(Database.BatchableContext BC, List<sObject> scope){
                // Logic to be Executed batch wise      
     			list<Lead> ldToUpdate = new list<Lead>();
				Metaphone mp = new Metaphone();
				for (Sobject s : scope){
					Lead l = (Lead)s;
				    l.Company_Metaphone_Key__c = mp.getMetaphone(l.Company);
					l.Street_Address_Metaphone_Key__c = mp.getMetaphone(l.Street);
					l.First_Name_Meta_Phone_Key__c = mp.getMetaphone(l.FirstName);
					l.Last_Name_Metaphone_Key__c = mp.getMetaphone(l.LastName);
					l.Soundex_updated__c = true;
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