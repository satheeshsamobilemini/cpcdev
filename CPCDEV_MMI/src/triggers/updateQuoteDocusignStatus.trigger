/**
 * (c) 2015 TEKsystems Global Services
 *
 * Name           : updateQuoteDocusignStatus 
 * Created Date   : 13 July 2016
 * Created By     : Ankur Goyal (TEKSystems)
 * Purpose        : Trigger to update the Any Signer status on Quote HEader when any of the recipient takes action on the document.
 * Last Updated By: Ankur Goyal (TEKSystems)
 * Last Updated Date: 18-Jul-2016
 **/

trigger updateQuoteDocusignStatus on dsfs__DocuSign_Recipient_Status__c (before update,after update) {

    Set<string> quoteIDsSet = new Set<string>();
    Set<string> dsParentIDsSet = new Set<string>();
    Set<string> dsrIDsSet = new Set<string>();
    
    Set<string> quoteDeclinedIDsSet = new Set<string>();
    Set<string> dsParentDeclinedIDsSet = new Set<string>();
    Set<string> dsrDeclinedIDsSet = new Set<string>();
     
    for(dsfs__DocuSign_Recipient_Status__c drs : trigger.new){
        if('completed'.equalsIgnoreCase(drs.dsfs__Recipient_Status__c) ){
            dsrIDsSet.add(drs.ID); 
            //quoteIDsSet.add(drs.dsfs__Parent_Status_Record__r.Quote_Header__c);           
        }
        if( 'Declined'.equalsIgnoreCase(drs.dsfs__Recipient_Status__c) )
            dsrDeclinedIDsSet.add(drs.ID); 
    }
    system.debug('dsr list IDs======'+dsrIDsSet);
    for(dsfs__DocuSign_Recipient_Status__c dr :[select id,dsfs__Parent_Status_Record__c from dsfs__DocuSign_Recipient_Status__c where id in :dsrIDsSet]){
        dsParentIDsSet.add(dr.dsfs__Parent_Status_Record__c);
    }         
           
    for(dsfs__DocuSign_Status__c dsp : [select id,Quote_Header__c from dsfs__DocuSign_Status__c where ID IN :dsParentIDsSet]){
        quoteIDsSet.add(dsp.Quote_Header__c)    ;
    }
    
    List<Quote_Header__c> quotesToUpdate = new List<Quote_Header__c>();
    
    for(Quote_Header__c qh : [select id,Docusign_Status__c,Any_Signer_Status__c from Quote_Header__c where ID IN :quoteIDsSet ]){
        Quote_Header__c q = new Quote_Header__c();
        q.id = qh.id;
        q.Any_Signer_Status__c = 'Completed';
        quotesToUpdate.add(q);
    }
    
    
    for(dsfs__DocuSign_Recipient_Status__c dr :[select id,dsfs__Parent_Status_Record__c from dsfs__DocuSign_Recipient_Status__c where id in :dsrDeclinedIDsSet]){
        dsParentDeclinedIDsSet.add(dr.dsfs__Parent_Status_Record__c);
    }         
           
    for(dsfs__DocuSign_Status__c dsp : [select id,Quote_Header__c from dsfs__DocuSign_Status__c where ID IN :dsParentDeclinedIDsSet]){
        quoteDeclinedIDsSet.add(dsp.Quote_Header__c)    ;
    }
    
    //List<Quote_Header__c> quotesToUpdate = new List<Quote_Header__c>();
    
    for(Quote_Header__c qh : [select id,Docusign_Status__c,Any_Signer_Status__c from Quote_Header__c where ID IN :quoteDeclinedIDsSet ]){
        Quote_Header__c q = new Quote_Header__c();
        q.id = qh.id;
        q.Any_Signer_Status__c = 'Declined';
        quotesToUpdate.add(q);
    }
    

    if(!quotesToUpdate.isEmpty())
        update quotesToUpdate ;

}