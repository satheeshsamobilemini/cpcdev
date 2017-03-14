@isTest
private class Test_VRTNotesAndAttachmentTrigger{
    @isTest
    static void testVRTNotesAndAttachmentTrigger(){
        Vehicle_Registration_Tracking__c vrt = new Vehicle_Registration_Tracking__c();
        insert vrt;
        system.assertNotEquals(vrt.Id , null);
        
        /*Note nt = new Note(ParentId = vrt.id , Title = 'test');        
        insert nt;
        system.assertNotEquals(nt.Id , null);*/
        Attachment att1 = new Attachment(Name ='Test File', Body=Blob.valueOf('Test Attachment Body'), ParentId=vrt.id);
        insert att1;
        system.assertNotEquals(att1.Id , null);
        VRT_Attachment__c vrtAttachment = new VRT_Attachment__c(Vehicle_Registration_Tracking__c = vrt.id, name = 'Test attachment', AttachmentId__c = att1.id);
        insert vrtAttachment;
        
        List<VRT_Attachment__c> vrts = [Select id from VRT_Attachment__c where Vehicle_Registration_Tracking__c  =: vrt.ID]; 
        system.assertEquals(vrts.Size() , 1);
        
        delete vrts.get(0);
        vrts = [Select id from VRT_Attachment__c where Vehicle_Registration_Tracking__c  =: vrt.ID]; 
        system.assertEquals(vrts.Size() , 0);
        
    }
}