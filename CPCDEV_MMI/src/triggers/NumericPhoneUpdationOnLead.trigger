/********************************************************************************************
Name   : NumericPhoneUpdationOnLead
Usage  : used to update Numericphone field of Lead
Author : Kirtesh Jain
Date   : Oct 01, 2009
********************************************************************************************/

trigger NumericPhoneUpdationOnLead on Lead (before insert, before update) {
/* for( Lead lLead : trigger.new){
	  if( lLead.phone != null)
	    lLead.NumericPhone__c = Utils.processNumericPhone(lLead.phone);
	  else 
	    lLead.NumericPhone__c = null;
  }*/
}