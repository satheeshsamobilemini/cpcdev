/*
*
*    (c) 2015 TEKsystems Global Services
*    
*    Name                : DefaultAccountCurrency
*    Created Date        : 08 Dec, 2015 @ 13:45
*    Created By          : Ankur Goyal (TEKSystems)
*    Purpose             : Default the account currency on account object based on record type. 
*                          This batch class will process the existing Account records and default the currency to USD/GBP based on record type. 
*                          Batch will be triggered in data/Prod box by runnung below code in developer console:
*                          
*                          DefaultAccountCurrency defAccCur = new DefaultAccountCurrency();
*                          ID batchprocessid = Database.executeBatch(defAccCur,2000);
*
*    Last Updated By     : Ankur Goyal (TEKSystems)
*    Last Updated Date   : 14-Jan-2016
*    
*/

global class DefaultAccountCurrency implements Database.Batchable<sObject>,Database.Stateful{

   Double failedUpdates{get; set;}
   List<Database.SaveResult> dsrs{get;set;}
   String err;
   
   public DefaultAccountCurrency(){
       failedUpdates = 0;   
       dsrs = new List<Database.SaveResult>();
       err='';
   }
        
   global Database.QueryLocator start(Database.BatchableContext BC){
      return Database.getQueryLocator([SELECT id,recordtype.name,CurrencyIsoCode,Sales_Org__c FROM Account]);
   }

   global void execute(Database.BatchableContext BC, List<sObject> scope){
       List<Account> accs = (List<Account>)scope;
       
        for(Account acc :accs)
        {
            
            if(acc.Sales_Org__c == '1000' || acc.Sales_Org__c == '1500' || acc.Sales_Org__c == '1501')         
                acc.CurrencyIsoCode = 'USD';
            if(acc.Sales_Org__c == '1200')
                acc.CurrencyIsoCode = 'GBP';
            if(acc.Sales_Org__c == '1100')
                acc.CurrencyIsoCode = 'CAD';    
        }    
       dsrs = Database.update(accs, false);
       for(Database.SaveResult dsr : dsrs){
           if(!dsr.isSuccess()){
              failedUpdates+= 1;
              err = err + '=======' + dsr.getErrors();
           }
       } 
       
       System.debug('=============total records=============' +accs.size());   
       System.debug('=============total failures=============' +failedUpdates);   
   }

   global void finish(Database.BatchableContext BC){
       AsyncApexJob jobDetails = [SELECT id, ApexClassId,JobItemsProcessed,TotalJobItems,NumberOfErrors,CreatedBy.Email 
                                  FROM AsyncApexJob WHERE id = :bc.getJobId()];
        
       String emailMessage = 'Your batch job '
             + 'CreateShiptoRecordFromAccount '
             + 'has finished.  It executed ' + jobDetails.totalJobItems + ' batches. Of which, ' + jobDetails.jobitemsprocessed 
             + ' processed without any exceptions thrown and ' + jobDetails.numberOfErrors + ' batches threw unhandled exceptions.'
             + ' Of the batches that executed without error, ' + failedUpdates + ' records were not updated.';
        
       Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
       String[] toAddresses = new String[]{jobDetails.createdBy.email ,'agoyal@teksystems.com','mholekad@teksystems.com'};
       mail.setToAddresses(toAddresses);
       mail.setReplyTo('noreply@salesforce.com');
       mail.setSenderDisplayName('Batch Job Summary');
       mail.setSubject('Batch job DefaultAccountCurrency status');
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