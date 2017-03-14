//*****************************************************************************************
// Name : SendSafetyAttachmentReminder
// Created By : -
// Created Date : 11/14/2011
// 
// Modified By : Alka Taneja
// Modified Date : 27 May 2013
// Story : S-120107
// Description : adding flags into the query for 30, 35, 90 and 95 days reminder 
//*****************************************************************************************/
trigger SendSafetyAttachmentReminder on Safety_Topic__c (after update) {

    Set<Id> safetyTopicIds = new Set<Id>();
    Boolean is15DaysReminder = false;
    
    for(Safety_Topic__c safetyTopic : Trigger.New){
        if((safetyTopic.No_Attachment_after_10_days__c && !Trigger.oldMap.get(safetyTopic.id).No_Attachment_after_10_days__c) || 
        		(safetyTopic.No_Attachment_after_15_days__c && !Trigger.oldMap.get(safetyTopic.id).No_Attachment_after_15_days__c) ||
        		(safetyTopic.No_Attachment_after_30_days__c && !Trigger.oldMap.get(safetyTopic.id).No_Attachment_after_30_days__c)  ||
        		(safetyTopic.No_Attachment_after_35_days__c && !Trigger.oldMap.get(safetyTopic.id).No_Attachment_after_35_days__c) ||
        		(safetyTopic.No_Attachment_after_90_days__c && !Trigger.oldMap.get(safetyTopic.id).No_Attachment_after_90_days__c) || 
        		(safetyTopic.No_Attachment_after_95_days__c && !Trigger.oldMap.get(safetyTopic.id).No_Attachment_after_95_days__c) ) {
        			
                if(safetyTopic.No_Attachment_after_15_days__c && !is15DaysReminder){
                    is15DaysReminder = true;
                }
                safetyTopicIds.add(safetyTopic.id);
        }
        
    } 
    if(safetyTopicIds.size() > 0){
        SafetyAttachmentReminderBatchProcess batch = new SafetyAttachmentReminderBatchProcess(safetyTopicIds,is15DaysReminder);    
        Database.executeBatch(batch, 20);
    } 
}