trigger BeforeInsertBeforeUpdateOnAccoundMetaPhoneKey on Account (before insert, before update) {
	for (Account l : trigger.new){
	    Metaphone mp = new Metaphone();
	    if(l.IsPersonAccount){
			l.Company_Metaphone_Key__c = mp.getMetaphone(l.FirstName+ ' ' +l.LastName);
	    }else{
	        l.Company_Metaphone_Key__c = mp.getMetaphone(l.Name);
	    }
		l.Street_Address_Metaphone_Key__c = mp.getMetaphone(l.BillingStreet);
	    l.First_Name_Meta_Phone_Key__c = mp.getMetaphone(l.FirstName);
		l.Last_Name_Metaphone_Key__c = mp.getMetaphone(l.LastName);
	    l.Is_Metaphone_Updated__c = true;	
	}
}