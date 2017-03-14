global class BatchApexToUpdateAccount implements Database.Batchable<sObject>{
     
         global BatchApexToUpdateAccount(){
                   // Batch Constructor
        }
        
           // Start Method
         global Database.QueryLocator start(Database.BatchableContext BC){
         	String query = 	'select Id,Company_Metaphone_Key__c,Street_Address_Metaphone_Key__c,Last_Name_Metaphone_Key__c,First_Name_Meta_Phone_Key__c,Name,FirstName,LastName,BillingState,BillingStreet,Is_Metaphone_Updated__c,IsPersonAccount from Account where Is_Metaphone_Updated__c = false';
            return Database.getQueryLocator(query);
         }
       
       // Execute Logic
         global void execute(Database.BatchableContext BC, List<sObject> scope){
                // Logic to be Executed batch wise      
     			list<Account> ldToUpdate = new list<Account>();
				Metaphone mp = new Metaphone();
				for (Sobject s : scope){
					Account l = (Account)s;
				    if(l.IsPersonAccount){
						l.Company_Metaphone_Key__c = mp.getMetaphone(l.FirstName+ ' ' +l.LastName);
				    }else{
				        l.Company_Metaphone_Key__c = mp.getMetaphone(l.Name);
				    }
					l.Street_Address_Metaphone_Key__c = mp.getMetaphone(l.BillingStreet);
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