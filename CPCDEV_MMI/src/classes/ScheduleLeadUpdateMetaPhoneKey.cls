public with sharing class ScheduleLeadUpdateMetaPhoneKey {
		
	public void UpdateLeadMetaphone(){
		list<Lead> lstLd =[select Id,Company_Metaphone_Key__c,Street_Address_Metaphone_Key__c, Company, Street,FirstName,LastName from Lead where Status != 'Dead Lead' and IsConverted = false and (Company_Metaphone_Key__c = null or Street_Address_Metaphone_Key__c = null or First_Name_Meta_Phone_Key__c = null or Last_Name_Metaphone_Key__c = null or LastModifiedDate >= :system.now().addHours(-2))];
		list<Lead> ldToUpdate = new list<Lead>();
		Metaphone mp = new Metaphone();
		for (Lead l : lstLd){ 
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
	
}