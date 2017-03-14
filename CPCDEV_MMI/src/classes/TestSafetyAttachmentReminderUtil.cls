/**
 * Test Class for SafetyAttachmentReminderUtil
 */
@isTest
private class TestSafetyAttachmentReminderUtil {

    static testMethod void TestSendEmail() {
        Safety_Topic__c safetyTopic = new Safety_Topic__c(Date__c = Date.Today().addDays(5).toStartOfWeek().addDays(1),Description__c = 'Test Safety', Name = 'Test Safety',Status__c = 'Submitted');
        insert safetyTopic;
        
        safetyTopic.No_Attachment_after_10_days__c = true;
        update safetyTopic;
    }
}