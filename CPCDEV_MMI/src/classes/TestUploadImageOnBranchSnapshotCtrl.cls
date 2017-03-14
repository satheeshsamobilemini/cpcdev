/**
 * Test Class for UploadImageOnBranchSnapshotController 
 */
@isTest
private class TestUploadImageOnBranchSnapshotCtrl  {
    @isTest
    static void testAttachFile() {
        Weekly_Snapshot_Branch_Report__c branchSnapshot = new Weekly_Snapshot_Branch_Report__c(Servicing_Branch__c = '101 - Phoenix');
        insert branchSnapshot;
        ApexPages.currentPage().getParameters().put('id',branchSnapshot.id);
        UploadImageOnBranchSnapshotController  uploadImageCtrl = new UploadImageOnBranchSnapshotController(new ApexPages.Standardcontroller(branchSnapshot));
        uploadImageCtrl.imageAttachment.body  = Blob.valueOf('Test txt');
        uploadImageCtrl.imageAttachment.Name = 'test.txt';
        uploadImageCtrl.upload();
        System.assert(uploadImageCtrl.imageAttachment.id != null);
        
        UploadImageOnBranchSnapshotController  uploadImageCtrl1 = new UploadImageOnBranchSnapshotController(new ApexPages.Standardcontroller(branchSnapshot));
        uploadImageCtrl1.imageAttachment.body  = Blob.valueOf('');
        uploadImageCtrl1.upload();
        uploadImageCtrl1.cancel();
    }
}