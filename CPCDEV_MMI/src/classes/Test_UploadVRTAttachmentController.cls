@isTest
private class Test_UploadVRTAttachmentController {
	
	@isTest
    static void testUploadVRTAttachmentController(){
    	
        Vehicle_Registration_Tracking__c vrt = new Vehicle_Registration_Tracking__c();
        insert vrt;
        system.assertNotEquals(vrt.Id , null);
        
        PageReference pageRef = Page.uploadVRTAttachment;
    		Test.setCurrentPageReference(pageRef);
    		ApexPages.currentPage().getParameters().put('Id',vrt.Id);    		
    		ApexPages.StandardController sc = new ApexPages.StandardController(vrt);
    		UploadVRTAttachmentController ctrl =
                                     new UploadVRTAttachmentController(sc);  
        ctrl.attachFile();
        System.assert(String.valueOf(Apexpages.getMessages()[0]).contains('Please Select a file'));                                     

        ctrl.attachment = new Attachment(Name ='Test File', Body=Blob.valueOf('Test Attachment Body'));
        ctrl.attachFile();
        
        System.assertNotEquals(null, [Select ParentId from Attachment where ParentId = :vrt.id].get(0));
        ctrl.upload();                                     
    		
    		System.assertNotEquals(null, [Select Vehicle_Registration_Tracking__c from VRT_Attachment__c where Vehicle_Registration_Tracking__c =: vrt.id].get(0));
    		
      
        
    }
	
}