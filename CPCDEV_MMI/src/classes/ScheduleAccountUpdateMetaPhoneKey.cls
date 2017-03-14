public with sharing class ScheduleAccountUpdateMetaPhoneKey {
		
	public void UpdateAccountMetaphone(){
		list<Account> lstAcc = [select Id,Company_Metaphone_Key__c,Street_Address_Metaphone_Key__c,Last_Name_Metaphone_Key__c,First_Name_Meta_Phone_Key__c,Name,FirstName,LastName,BillingState,BillingStreet,Is_Metaphone_Updated__c,IsPersonAccount from Account where Company_Metaphone_Key__c = null or Street_Address_Metaphone_Key__c = null or First_Name_Meta_Phone_Key__c = null or Last_Name_Metaphone_Key__c = null or LastModifiedDate >= :system.now().addHours(-2)]; 
		//list<Lead> lstLd =[select Id,Company_Metaphone_Key__c,Street_Address_Metaphone_Key__c, Company, Street,FirstName,LastName from Lead where IsConverted = false and (Company_Metaphone_Key__c = null or Street_Address_Metaphone_Key__c = null or First_Name_Meta_Phone_Key__c = null or Last_Name_Metaphone_Key__c = null or LastModifiedDate >= :system.now().addHours(-2))];
		list<Account> AccToUpdate = new list<Account>();
		Metaphone mp = new Metaphone(); 
		for (Account a : lstAcc){
			if(a.IsPersonAccount){
				a.Company_Metaphone_Key__c = mp.getMetaphone(a.FirstName+ ' ' +a.LastName);
		    }else{
		        a.Company_Metaphone_Key__c = mp.getMetaphone(a.Name);
		    }
			a.Street_Address_Metaphone_Key__c = mp.getMetaphone(a.BillingStreet);
		    a.First_Name_Meta_Phone_Key__c = mp.getMetaphone(a.FirstName);
			a.Last_Name_Metaphone_Key__c = mp.getMetaphone(a.LastName);
		    a.Is_Metaphone_Updated__c = true;	
		    AccToUpdate.add(a);
		}
		if(AccToUpdate.size() > 0){
			update AccToUpdate;
		}
	}
}