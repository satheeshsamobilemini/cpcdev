/**
 * Test Class for SafetyTopicViewController
 */
@isTest
private class TestSafetyTopicViewController {
    @isTest
    static void testView() {
        Safety_Topic__c safetyTopic = new Safety_Topic__c(Date__c = Date.Today().addDays(5).toStartOfWeek().addDays(1),Description__c = 'Test Safety', Name = 'Test Safety');
        insert safetyTopic;
        
        Safety_Attachment__c safetyAtachment = new Safety_Attachment__c(Name = 'Test SA' ,safety_Topic__c = safetyTopic.id );//branch__c = '105' 
        insert safetyAtachment;
        
        Blob  txtBlob = Blob.ValueOf('test txt');
        Attachment a = new Attachment(parentId = safetyAtachment.id , name='Test PDF' + '.txt', body = txtBlob);
        insert a;
        
        SafetyTopicViewController safetyTopicView = new SafetyTopicViewController(new ApexPages.Standardcontroller(safetyTopic));
        safetyTopicView.attachFile();
    }
}