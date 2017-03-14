/*************************************************************************************
Name : updateOptout 
Created By : Mohit (Appirio Offshore)
Created Date : Sept 07, 2013
Description : This trigger is used to update the Email Opt out field of associted contact.
***************************************************************************************/


trigger updateOptout on iContactforSF__iContact_Message_Statistic__c (after insert) {
    
    List<Contact> lstContact = new List<Contact>();
    Set<Id> contactIds = new Set<Id>();
    for(iContactforSF__iContact_Message_Statistic__c iContactData : Trigger.new){
        if(iContactData.iContactforSF__Unsubscribed__c != null){
             Id ids  = iContactData.iContactforSF__Contact__c;
             contactIds.add(ids);
        }
    }
    for(Contact contactData : [Select Id, name, HasOptedOutOfEmail from Contact where id in :contactIds ]){
        contactData.HasOptedOutOfEmail  = true;
        lstContact.add(contactData);
    }
    
    if(lstContact.size() > 0){
        update lstContact;
    }
}