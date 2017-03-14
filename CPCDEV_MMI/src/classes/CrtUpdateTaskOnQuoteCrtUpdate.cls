/*
*
*    (c) 2015 TEKsystems Global Services
*    
*    Name                : CrtUpdateTaskOnQuoteCrtUpdate 
*    Created Date        : 16 May, 2016 
*    Created By          : Ankur Goyal (TEKSystems)
*    Purpose             : Create or update the follow up task on Quote Header create/update event. 
*                          This batch class will process the Quote Header records and create/update follow up task record based on flag at quote header level. 
*                          Batch will be scheduled to run every hour on all days of the week.
*                          
*    Last Updated By     : Ankur Goyal (TEKSystems)
*    Last Updated Date   : 16-May-2016
*    
*/

global class CrtUpdateTaskOnQuoteCrtUpdate implements Database.Batchable<sObject>,Database.Stateful{

   Double failedUpdates{get; set;}
   Double failedCreates{get; set;}
   List<Database.SaveResult> dsrs{get;set;}
   String err;
   String createError ;
   List<String> errorsList;
   public static Boolean isFromBatch{get;set;}
   public CrtUpdateTaskOnQuoteCrtUpdate(){
       failedUpdates = 0;
       failedCreates = 0;   
       dsrs = new List<Database.SaveResult>();
       err='';
       createError = '';
       errorsList = new List<string>();
       isFromBatch = true;
   }
        
   global Database.QueryLocator start(Database.BatchableContext BC){
      return Database.getQueryLocator([SELECT id,name,Create_Followup_Task__c,Update_Followup_Task__c,Task_Comments__c,Branch__c,Followup_Task_Date__c,ownerid,opportunity__r.ownerid,opportunity__c,account__r.ownerid,account__c from quote_header__c where Update_Followup_Task__c = true]);
   }

   global void execute(Database.BatchableContext BC, List<sObject> scope){
        List<Quote_Header__c> quotesList = (List<Quote_Header__c>)scope;
        List<Task> tasksToUpdateList = new List<Task>();
        List<Task> tasksToCreateList = new List<Task>();
        Map<ID,ID> oppOwnerIDMap = new Map<ID,ID>();
        Map<ID,ID> accOwnerIDMap = new Map<ID,ID>();
        Boolean updtaeTasks = false;
        Task followupTask;
        Map<String,String> taskNameCommentsMap = new Map<String,String>();
        Map<String,Date> taskNameDateMap = new Map<String,Date>();
        Map<String,String> taskNameBranchMap = new Map<String,String>();
        string taskSubject;
        List<Quote_Header__c> updateQuotesList = new List<Quote_Header__c>();
        Quote_Header__c qheader;
        for(Quote_Header__c qh :quotesList)
        {
            /*if(qh.Create_Followup_Task__c){
                oppOwnerIDMap.put(qh.opportunity__c , qh.opportunity__r.ownerid); 
                accOwnerIDMap.put(qh.account__c , qh.account__r.ownerid); 
            
                followupTask = new Task();
                if(oppOwnerIDMap.containskey(qh.Opportunity__c))
                  followupTask.OwnerId = oppOwnerIDMap.get(qh.Opportunity__c);          //Assigned to - opp owner
                followupTask.Subject = 'Follow Up on Quote '+qh.name;             //task subject
                followupTask.ActivityDate = qh.Followup_Task_Date__c;    //system.today().addDays(7);   //Due date
                followupTask.Call_Type__c = 'OB - 4 Hour Callback';      //MMI Call Type 
                followupTask.Status = 'Not Started';                     //Task status - 'Not Started'
                followupTask.Priority = 'Normal';                        //Task priority - Normal
                followupTask.WhatId = qh.Opportunity__c;                 //Related to - Opportunity - opp
                followupTask.Branch__c = qh.Branch__c;                   //branch id 
                followupTask.Description = qh.Task_Comments__c;          //task comments
                //followupTask.Reminder__c = system.today().addDays(2);
                tasksToCreateList.add(followupTask);
                //qheader = new Quote_Header__c();
                //qheader.id = qh.id;
                //qheader.Create_Followup_Task__c = false;
                //updateQuotesList.add(qheader);
            } */
            if(qh.Update_Followup_Task__c){
                updtaeTasks = true;
                taskSubject = 'Follow Up on Quote '+qh.name;
                taskNameCommentsMap.put(taskSubject,qh.Task_Comments__c);
                taskNameDateMap.put(taskSubject,qh.Followup_Task_Date__c);
                taskNameBranchMap.put(taskSubject,qh.Branch__c);        
                
            }
                qheader = new Quote_Header__c();
                qheader.id = qh.id;
                qheader.Update_Followup_Task__c = false;
                qheader.Create_Followup_Task__c = false;
                updateQuotesList.add(qheader);
        }
        
        if(updtaeTasks) {
            List<Task> allTasksList = [select ID,Subject,ActivityDate,Branch__c,Description from Task where Subject in :taskNameCommentsMap.keyset()];
            Task tsk;
            for(Task t: allTasksList){
                tsk = new Task();
                tsk.id = t.id;
                tsk.ActivityDate = taskNameDateMap.get(t.Subject);
                tsk.Description = taskNameCommentsMap.get(t.Subject);
                tsk.Branch__c = taskNameBranchMap.get(t.Subject);
                tasksToUpdateList.add(tsk);
            }
        }   
        /*dsrs = Database.insert(tasksToCreateList, false);
        for(integer i=0; i<tasksToCreateList.size(); i++ ){
            String msg = '';
            if(!dsrs[i].isSuccess()) {
                msg += tasksToCreateList[i].Description + ' not created. \nError: ';
                for(Database.Error err: dsrs[i].getErrors())
                    msg += err.getmessage() + '\n';
            }
            
            if(msg!='')
                errorsList.add(msg);
        }*/
        
        
        /*for(Database.SaveResult dsr : dsrs){
            if(!dsr.isSuccess()){
              failedCreates+= 1;
              createError = createError + '=======' + dsr.getErrors();
            }
        } */
        dsrs = Database.update(updateQuotesList , false);
        dsrs = Database.update(tasksToUpdateList, false);
        for(integer i=0; i<tasksToUpdateList.size(); i++ ){
            String msg = '';
            if(!dsrs[i].isSuccess()) {
                msg += tasksToUpdateList[i].Description + ' not updated. Task ID ' + tasksToUpdateList[i].ID + ' \nError: ';
                for(Database.Error err: dsrs[i].getErrors())
                    msg += err.getmessage() + '\n';
            }
            
            if(msg!='')
                errorsList.add(msg);
        } 
        /*for(Database.SaveResult dsr : dsrs){
            if(!dsr.isSuccess()){
              failedUpdates+= 1;
              err = err + '=======' + dsr.getErrors();
            }
        }*/
        
        
       
        System.debug('=============total records=============' +tasksToCreateList.size());   
        System.debug('=============total failures=============' +failedUpdates);   
    }

   global void finish(Database.BatchableContext BC){
       AsyncApexJob jobDetails = [SELECT id, ApexClassId,JobItemsProcessed,TotalJobItems,NumberOfErrors,CreatedBy.Email 
                                  FROM AsyncApexJob WHERE id = :bc.getJobId()];
        
       String emailMessage = 'Your batch job '
             + 'CreateUpdateTaskOnQuoteCreateUpdate '
             + 'has finished.  It executed ' + jobDetails.totalJobItems + ' batches. Of which, ' + jobDetails.jobitemsprocessed 
             + ' processed without any exceptions thrown and ' + jobDetails.numberOfErrors + ' batches threw unhandled exceptions.'
             + ' \n\nOf the batches that executed without error, ' + failedUpdates + ' tasks are not updated.' 
             + ' \n\nPlease find the below errors: ';
             //and ' + failedCreates + ' tasks are not created.'
       
       //for(String str : errorsList)
       //    emailMessage += str;    
        
       Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
       String[] toAddresses = new String[]{'skommineni@mobilemini.com'};
       mail.setToAddresses(toAddresses);
       mail.setReplyTo('noreply@salesforce.com');
       mail.setSenderDisplayName('Batch Job Summary');
       mail.setSubject('Batch job CreateUpdateTaskOnQuoteCreateUpdate status');
       mail.setPlainTextBody(emailMessage);
      //  mail.setHtmlBody(emailMessage);
       List<Messaging.SendEmailResult> emailResults = Messaging.sendEmail(new Messaging.SingleEmailMessage[]{ mail });    
        
       if (!emailResults.get(0).isSuccess()) {
           System.debug('Mail sent successfully!!');
       }
       else{
           System.debug(emailResults.get(0).getErrors());
       }
   }

}