trigger BeforeInsertBeforeUpdateOnLeadForSoundex on Lead (before insert, before update) {
	for (Lead l : Trigger.New){
		//l.Company_Name_Soundex_key__c = Soundex.toSoundex(l.Company);
		//l.Street_Address_Soundex_key__c = Soundex.toSoundex(l.Street);
		Metaphone mp = new Metaphone();
		l.Company_Metaphone_Key__c = mp.getMetaphone(l.Company);
		l.Street_Address_Metaphone_Key__c = mp.getMetaphone(l.Street);
		l.First_Name_Meta_Phone_Key__c = mp.getMetaphone(l.FirstName);
		l.Last_Name_Metaphone_Key__c = mp.getMetaphone(l.LastName);
		l.Soundex_updated__c = true;
		//list<Lead> lstLead = [select Id, FirstName, LastName, Company, Street from Lead where Company_Name_Soundex_key__c = :Soundex.toSoundex(l.Company) or Street_Address_Soundex_key__c = :Soundex.toSoundex(l.Street) or PostalCode = :l.PostalCode or Phone = :l.Phone ];
	}
}