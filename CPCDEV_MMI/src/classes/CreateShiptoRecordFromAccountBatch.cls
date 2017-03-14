/*
*
*    (c) 2015 TEKsystems Global Services
*    
*    Name                : CreateShiptoRecordFromAccountBatch
*    Created Date        : 24 Sept, 2015 
*    Created By          : Ankur Goyal (TEKSystems)
*    Purpose             : Create ShipTo record for existing Account records. 
*                          This batch class will process the Account records and create a corresponding shipto record.
*                          Since this a one time activity hence schedule class is not implemented. 
*                          Batch will be triggered in data/Prod box by runnung below code in developer console:
*                          
*                          CreateShiptoRecordFromAccountBatch crtShptoRec = new CreateShiptoRecordFromAccountBatch();
*                          ID batchprocessid = Database.executeBatch(crtShptoRec,2000);
*  
*    Last Updated By     : Ankur Goyal (TEKSystems)
*    Last Updated Date   : 14-Jan-2016
*  
*/


global class CreateShiptoRecordFromAccountBatch implements Database.Batchable<sObject>,Database.Stateful{

   Double failedUpdates{get; set;}
   
   public CreateShiptoRecordFromAccountBatch(){
       failedUpdates = 0;    
   }
        
   global Database.QueryLocator start(Database.BatchableContext BC){
      return Database.getQueryLocator([SELECT id,BillingStreet,BillingCity,BillingCountry,Servicing_Branch_Id__c,phone,
                                       BillingState,BillingPostalCode,CurrencyIsoCode FROM Account]);
   }

   global void execute(Database.BatchableContext BC, List<sObject> scope){
       List<Account> accountList = (List<Account>)scope;
       List<Shipto__c> insertShiptoRecsList = new List<Shipto__c>();
       for(Integer i = 0; i < accountList.size(); i++){
           Shipto__c newShipToRecord = new Shipto__c();     
           newShipToRecord.Account__c                  = accountList[i].ID;
           newShipToRecord.Address__c                  = accountList[i].BillingStreet;
           newShipToRecord.City__c                     = accountList[i].BillingCity;
           newShipToRecord.Country__c                  = accountList[i].BillingCountry;
           newShipToRecord.Fulfilling_Branch__c        = accountList[i].Servicing_Branch_Id__c;
           newShipToRecord.Phone__c                    = accountList[i].Phone;
           newShipToRecord.State__c                    = accountList[i].BillingState;
           newShipToRecord.Zip__c                      = accountList[i].BillingPostalCode;
           newShipToRecord.CurrencyIsoCode             = accountList[i].CurrencyIsoCode;
           insertShiptoRecsList.add(newShipToRecord);  
       }
           
       List<Database.SaveResult> dsrs = Database.insert(insertShiptoRecsList, false);
       for(Database.SaveResult dsr : dsrs){
           if(!dsr.isSuccess()){
              failedUpdates+= 1;
           }
       } 
       
       System.debug('=============total shipto records=============' +insertShiptoRecsList.size());   
       System.debug('=============total failures=============' +failedUpdates);   
   }

   global void finish(Database.BatchableContext BC){
       AsyncApexJob jobDetails = [SELECT id, ApexClassId,JobItemsProcessed,TotalJobItems,NumberOfErrors,CreatedBy.Email 
                                  FROM AsyncApexJob WHERE id = :bc.getJobId()];
        
       String emailMessage = 'Your batch job '
             + 'CreateShiptoRecordFromAccount '
             + 'has finished.  It executed ' + jobDetails.totalJobItems + ' batches. Of which, ' + jobDetails.jobitemsprocessed 
             + ' processed without any exceptions thrown and ' + jobDetails.numberOfErrors + ' batches threw unhandled exceptions.'
             + ' Of the batches that executed without error, ' + failedUpdates + ' records were not inserted successfully.';
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[]{jobDetails.createdBy.email};
        mail.setToAddresses(toAddresses);
        mail.setReplyTo('noreply@salesforce.com');
        mail.setSenderDisplayName('Batch Job Summary');
        mail.setSubject('Batch job CreateShiptoRecordFromAccount status');
        mail.setPlainTextBody(emailMessage);
        mail.setHtmlBody(emailMessage);
        //Messaging.sendEmail(new Messaging.SingleEmailMessage[]{ mail });    
   
   }
} //end of class