public with sharing class ScheduleContactUpdateMetaPhoneKey {
		
	public void UpdateContactMetaphone(){
		list<Contact> lstcon =[select Id,Company_Metaphone_Key__c,Street_Address_Metaphone_Key__c,Last_Name_Metaphone_Key__c,First_Name_Meta_Phone_Key__c,Name,FirstName,LastName,MailingState,MailingStreet,Is_Metaphone_Updated__c from Contact where Company_Metaphone_Key__c = null or Street_Address_Metaphone_Key__c = null or First_Name_Meta_Phone_Key__c = null or Last_Name_Metaphone_Key__c = null or LastModifiedDate >= :system.now().addHours(-2)];
		list<Contact> conToUpdate = new list<Contact>();
		Metaphone mp = new Metaphone(); 
		for (Contact c : lstcon){
			c.Company_Metaphone_Key__c = mp.getMetaphone(c.FirstName + ' ' +c.LastName);
			c.Street_Address_Metaphone_Key__c = mp.getMetaphone(c.MailingStreet);
		    c.First_Name_Meta_Phone_Key__c = mp.getMetaphone(c.FirstName);
			c.Last_Name_Metaphone_Key__c = mp.getMetaphone(c.LastName);
		    c.Is_Metaphone_Updated__c = true;		
		    conToUpdate.add(c);
		}
		if(conToUpdate.size() > 0){
			update conToUpdate;
		}
		
	}
	
}