/************************************************************************************************
Name : setJobProfileURLOnDodge
Created By : Appirio Offshore
Created Date : 7 April , 2010
Usage : This trigger set the Job Profile URL field on dodge Project from Job Profile
*************************************************************************************************/
trigger setJobProfileURLOnDodge on Job_Profile__c (after insert, after update) {
   
   if(TriggerSwitch.isTriggerExecutionFlagDisabled('Job_Profile__c','setJobProfileURLOnDodge')){
        return;
    }


   Map<ID,ID> dodgeProjectWithJobProfile = new Map<ID,ID>();
   List<Dodge_Project__c> dodgeProjectToBeUpdate = new List<Dodge_Project__c>();
   String organizationURL = System.Label.Organization_URL;
   String sub ='Job Profile Assigned'; // Sales Restructure 2015
   String body = ''; // Sales Restructure 2015
   Id tId;
   List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>(); // Sales Restructure 2015
   if(Trigger.isInsert){
       for(Job_Profile__c jobProfile : Trigger.New){
        // If dodge Project id is not null then set Job profile URL in dodge Project
           if(jobProfile.Dodge_Project__c != null){
               dodgeProjectToBeUpdate.add(new Dodge_Project__c(id = jobProfile.Dodge_Project__c , Job_Profile_URL__c = organizationURL +jobProfile.id));                
           }   
        // Sales Restructure 2015   
        if(jobProfile.isEmailNotify__c || jobProfile.isEmailNotify_Owner__c){ 
         body = 'Hi,<br/><br/></n></n>A new job profile "' + jobProfile.Name + '" has been assigned to you. Please click on the following link to view in salesforce : <br/><br/></n></n>';
         body += '<a href="'+URL.getSalesforceBaseUrl().toExternalForm()+'/'+ jobProfile.Id+'">'+ URL.getSalesforceBaseUrl().toExternalForm()+'/'+ jobProfile.Id+'</a>';
         Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
         tId = jobProfile.isEmailNotify__c ? jobProfile.JP_TerritoryOwner__c : jobProfile.OwnerId;
         mail.setTargetObjectId(tID);
         mail.setSubject(sub);
         mail.setHTMLBody(body);
         mail.setSaveAsActivity(false);
         emailList.add(mail);
        }        
      }
   }
   
   if(Trigger.isUpdate){
       for(Job_Profile__c jobProfile : Trigger.New){
        // If dodge Project id is not null and changed then set Job profile URL in dodge Project
           if(jobProfile.Dodge_Project__c != null){
            /*LSLEVIN 9.23.2013 Case 53015 START */
                if(jobProfile.Dodge_Project__c != null && Trigger.oldMap.get(jobProfile.id).Dodge_Project__c == null ){
                    dodgeProjectToBeUpdate.add(new Dodge_Project__c(id = jobProfile.Dodge_Project__c , Job_Profile_URL__c = organizationURL +jobProfile.id));                    
                }
            /*LSLEVIN 9.23.2013 Case 53015 END */   
               if(Trigger.oldMap.get(jobProfile.id).Dodge_Project__c != null && jobProfile.Dodge_Project__c != Trigger.oldMap.get(jobProfile.id).Dodge_Project__c){
                    dodgeProjectToBeUpdate.add(new Dodge_Project__c(id = Trigger.oldMap.get(jobProfile.id).Dodge_Project__c , Job_Profile_URL__c = ''));
                 }
           }
                   
       }
   }
   if(dodgeProjectToBeUpdate.size() > 0){
       update dodgeProjectToBeUpdate;
   }
   
     if(!emailList.isEmpty()){
      Messaging.sendEmail(emailList); 
   }
}