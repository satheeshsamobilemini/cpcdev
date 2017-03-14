@isTest
public class TestAttachmentAndNotesTransferBatch {
    
    @isTest static void testVehicleRegTrackExt(){
        Database.BatchableContext BC;
        List<SObject> scope = new List<SObject>();
        
        AttachmentAndNotesTransferBatch Attach = new AttachmentAndNotesTransferBatch();
        Database.executeBatch(Attach);
        Attach.execute(bc,scope);
    }
}