/**
 * Test Class for SafetyAttachmentReminderBatchProcess
 */
@isTest
private class TestSafetyAttachmentReminderBatchProcess {

    static testMethod void testExcute() {
        Safety_Topic__c safetyTopic = new Safety_Topic__c(Date__c = Date.Today().addDays(5).toStartOfWeek().addDays(1),Description__c = 'Test Safety', Name = 'Test Safety',Status__c = 'Submitted',No_Attachment_after_15_days__c = true);
        insert safetyTopic;
        Test.startTest();
        Set<Id> safetyTopicIds = new set<Id>();
        safetyTopicIds.add(safetyTopic.id);
        SafetyAttachmentReminderBatchProcess batch = new SafetyAttachmentReminderBatchProcess(safetyTopicIds);  
        Database.executeBatch(batch, 100);
        Test.stopTest();
    }
    static testMethod void testExcute1() {
        Safety_Topic__c safetyTopic1 = new Safety_Topic__c(Date__c = Date.Today().addDays(5).toStartOfWeek().addDays(1),Description__c = 'Test Safety', Name = 'Test Safety',No_Attachment_after_30_days__c = true,No_Attachment_after_35_days__c = true,Status__c = 'Submitted',RecordTypeId = Schema.SObjectType.Safety_Topic__c.getRecordTypeInfosByName().get('Branch Manager Safety Inspection').getRecordTypeId());
        insert safetyTopic1;
        Test.startTest();
        Set<Id> safetyTopicIds = new set<Id>();
        safetyTopicIds.add(safetyTopic1.id);
        SafetyAttachmentReminderBatchProcess batch = new SafetyAttachmentReminderBatchProcess(safetyTopicIds);  
        Database.executeBatch(batch, 100);
        Test.stopTest();
    }
    static testMethod void testExcute2() {
        Safety_Topic__c safetyTopic2 = new Safety_Topic__c(Date__c = Date.Today().addDays(5).toStartOfWeek().addDays(1),Description__c = 'Test Safety', Name = 'Test Safety',No_Attachment_after_90_days__c = true,No_Attachment_after_95_days__c = true,Status__c = 'Submitted',RecordTypeId = Schema.SObjectType.Safety_Topic__c.getRecordTypeInfosByName().get('Regional Manager Safety Inspection').getRecordTypeId());
        insert safetyTopic2;
        Test.startTest();
        Set<Id> safetyTopicIds = new set<Id>();
        safetyTopicIds.add(safetyTopic2.id);
        SafetyAttachmentReminderBatchProcess batch = new SafetyAttachmentReminderBatchProcess(safetyTopicIds);  
        Database.executeBatch(batch, 100);
        Test.stopTest();
    }
}