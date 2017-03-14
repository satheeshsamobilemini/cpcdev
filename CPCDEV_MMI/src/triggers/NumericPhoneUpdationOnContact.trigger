/********************************************************************************************
Name   : NumericPhoneUpdationOnContact
Usage  : used to update Numericphone field of Contact
Author : Kirtesh Jain
Date   : Oct 01, 2009
********************************************************************************************/

trigger NumericPhoneUpdationOnContact on Contact (before insert, before update) {
   for( Contact cContact : trigger.new){
	  if( cContact.phone != null)
	    cContact.NumericPhone__c = Utils.processNumericPhone(cContact.phone);
	  else 
	   cContact.NumericPhone__c = null;
	}
}