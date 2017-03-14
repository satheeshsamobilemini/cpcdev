global class BatchApexToUpdateContact implements Database.Batchable<sObject>{
     
         global BatchApexToUpdateContact(){
                   // Batch Constructor
        }
        
           // Start Method
         global Database.QueryLocator start(Database.BatchableContext BC){
         	String query = 	'select Id,Company_Metaphone_Key__c,Street_Address_Metaphone_Key__c,Last_Name_Metaphone_Key__c,First_Name_Meta_Phone_Key__c,Name,FirstName,LastName,MailingState,MailingStreet,Is_Metaphone_Updated__c from Contact where Is_Metaphone_Updated__c = false';
          return Database.getQueryLocator(query);
         }
       
       // Execute Logic
         global void execute(Database.BatchableContext BC, List<sObject> scope){
                // Logic to be Executed batch wise      
     			list<Contact> ldToUpdate = new list<Contact>();
				Metaphone mp = new Metaphone();
				for (Sobject s : scope){
					Contact l = (Contact)s;
				    l.Company_Metaphone_Key__c = mp.getMetaphone(l.Name);
					l.Street_Address_Metaphone_Key__c = mp.getMetaphone(l.MailingStreet);
				    l.First_Name_Meta_Phone_Key__c = mp.getMetaphone(l.FirstName);
					l.Last_Name_Metaphone_Key__c = mp.getMetaphone(l.LastName);
				    l.Is_Metaphone_Updated__c = true;	
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