/**
 * Test Class for CustomAttachFileController
 */
@isTest
private class TestDeleteSafetyAttachments {
    @isTest
    static void testDeleteAttachment() {
        Safety_Topic__c safetyTopic = new Safety_Topic__c(Date__c = Date.Today().addDays(5).toStartOfWeek().addDays(1),Description__c = 'Test Safety', Name = 'Test Safety');
        insert safetyTopic;
        ApexPages.currentPage().getParameters().put('pid',safetyTopic.id);
        CustomAttachFileController  customAttachFile = new CustomAttachFileController(new ApexPages.Standardcontroller(new Attachment()));
	    customAttachFile.loadBranches();
	    customAttachFile.safetyAttachment.Branch__c = '105'; 
	    customAttachFile.attachment.body = Blob.valueOf('Test txt');
	    customAttachFile.attachment.Name = 'test.txt';
	    customAttachFile.save();
	    System.assert(customAttachFile.safetyAttachment.id != null);
	    //System.assert(customAttachFile.attachment.id != null);
	    //delete customAttachFile.attachment;
    }
}