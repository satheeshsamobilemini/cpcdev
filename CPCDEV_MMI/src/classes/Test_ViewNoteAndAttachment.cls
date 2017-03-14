@isTest
private class Test_ViewNoteAndAttachment {

    static testMethod void testViewNoteAndAttachment() {
        
        Vehicle_Registration_Tracking__c vrt = new Vehicle_Registration_Tracking__c();
        insert vrt;
        system.assertNotEquals(vrt.Id , null);
        
        Attachment att1 = new Attachment(Name ='Test File', Body=Blob.valueOf('Test Attachment Body'), ParentId=vrt.id);
        insert att1;
        Attachment att2 = new Attachment(Name ='Test File', Body=Blob.valueOf('Test Attachment Body'), ParentId=vrt.id);
        insert att2;
        
       VRT_Attachment__c vrtAttachment = new VRT_Attachment__c(Vehicle_Registration_Tracking__c = vrt.id, name = 'Test attachment', AttachmentId__c = att2.id);
       insert vrtAttachment;
       
       System.assertEquals('success',ViewNoteAndAttachment.viewAttachment(vrt.Id));
       
    }
}