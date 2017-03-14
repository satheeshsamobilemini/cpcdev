trigger BeforeInsertBeforeUpdateOnContactMetaPhoneKey on Contact (before insert, before update) {
	for (Contact l : trigger.new){
	    Metaphone mp = new Metaphone();
	    l.Company_Metaphone_Key__c = mp.getMetaphone(l.FirstName + '' +l.LastName);
		l.Street_Address_Metaphone_Key__c = mp.getMetaphone(l.MailingStreet);
	    l.First_Name_Meta_Phone_Key__c = mp.getMetaphone(l.FirstName);
		l.Last_Name_Metaphone_Key__c = mp.getMetaphone(l.LastName);
	    l.Is_Metaphone_Updated__c = true;	
	}
}