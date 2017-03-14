//*****************************************************************************************
// Name : SafetyAttachmentReminderBatchProcess
// Created By : -
// Created Date : 11/14/2011
// 
// Modified By : Alka Taneja
// Modified Date : 21 May 2013
// Story : S-120107
// Description : adding flags into the query for 30, 35, 90 and 95 days reminder
//*****************************************************************************************/
global class SafetyAttachmentReminderBatchProcess implements Database.Batchable<sobject>{
    global Set<Id> safetyTopicIds;
    global Boolean is15DaysReminder;
    
    global SafetyAttachmentReminderBatchProcess(Set<Id> safetyTopicIds){
        this(safetyTopicIds,false);
    } 
    
    global SafetyAttachmentReminderBatchProcess(Set<Id> safetyTopicIds,Boolean is15DaysReminder){
        this.safetyTopicIds = safetyTopicIds;
        this.is15DaysReminder = is15DaysReminder;
    } 
    global Database.QueryLocator start(Database.batchableContext bc){
        String safetyTopicQuery = 'select id , Name ,No_Attachment_after_10_days__c ,No_Attachment_after_15_days__c ,  Date__c, ' +
        													 'Total_Attachments__c,(select Id, Branch__c from Safety_Attachments__r), ' +
        													 'No_Attachment_after_30_days__c, No_Attachment_after_35_days__c, ' +
        													 'No_Attachment_after_90_days__c, No_Attachment_after_95_days__c, RecordTypeId from Safety_Topic__c ' +
        													 'where  status__c = \'Submitted\' ';
        if(safetyTopicIds!= null){
            safetyTopicQuery += ' and id  in : safetyTopicIds';
        }
        return Database.getQueryLocator(safetyTopicQuery);
    }
    
    global void execute(Database.batchableContext bc, List<sobject> scope){
        SafetyAttachmentReminderUtil.sendMail(scope,is15DaysReminder);
    }
    
    global void finish(Database.batchableContext bc){}
    
}