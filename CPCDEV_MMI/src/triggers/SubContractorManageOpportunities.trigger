trigger SubContractorManageOpportunities on Sub_Contractor__c (after insert){

 List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();

 // check conditions to sent mail notification..   
  for(integer i=0; i<trigger.new.size(); i++){
   Id accId = null;
   String subj = '';
   String body = '';
    
   if(trigger.new[i].Account_isSPOC__c){
      accId = trigger.new[i].Account_Owner__c;
      subj = 'Job Profile Assigned';
      body = 'Hi,<br/><br/></n></n>An account assigned to you :  <a href="'+URL.getSalesforceBaseURL().toExternalForm()+'/'+trigger.new[i].Account__c+'">' + URL.getSalesforceBaseURL().toExternalForm()+'/'+trigger.new[i].Account__c+'</a>,';
      body += ' has been assigned to a job profile : <a href="'+URL.getSalesforceBaseURL().toExternalForm()+'/'+trigger.new[i].Job_Profile__c+'">'+ URL.getSalesforceBaseURL().toExternalForm()+'/'+trigger.new[i].Job_Profile__c+'</a>.';
      body += '<br/><br/></n></n></n>Please review the account and job profile.';
         
    } 
   else if(trigger.new[i].JobProfileOwnerId__c <> null && trigger.new[i].CreatedById <> trigger.new[i].JobProfileOwnerId__c){
      accId = trigger.new[i].JobProfileOwnerId__c;
      subj = 'New SubContractor Added';
      body = 'Hi,<br/><br/></n></n>A new sub Contractor has been added to your territory for account : <a href="'+URL.getSalesforceBaseUrl().toExternalForm()+'/'+trigger.new[i].Account__c+'">'+ URL.getSalesforceBaseUrl().toExternalForm()+'/'+trigger.new[i].Account__c+'</a>,';
      body += ' related to job profile : <a href="'+URL.getSalesforceBaseUrl().toExternalForm()+'/'+trigger.new[i].Job_Profile__c+'">'+ URL.getSalesforceBaseUrl().toExternalForm()+'/'+trigger.new[i].Job_Profile__c+'</a>.';
      body += '<br/><br/></n></n></n>Please review the account and job profile.';
    } 
    
    if(accId != null){
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    mail.setTargetObjectId(accId); 
    mail.setSubject(subj);
    mail.setHTMLBody(body);
    mail.setSaveAsActivity(false);
    emailList.add(mail);
   } 
    
 }  
  
 if(!emailList.isEmpty()){
   Messaging.sendEmail(emailList);
 }
    
}