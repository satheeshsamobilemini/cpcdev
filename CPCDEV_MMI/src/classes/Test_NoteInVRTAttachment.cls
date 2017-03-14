@isTest
private class Test_NoteInVRTAttachment{
    @isTest
    static void testNoteInVRTAttachment(){
        Vehicle_Registration_Tracking__c vrt = new Vehicle_Registration_Tracking__c();
        insert vrt;
        system.assertNotEquals(vrt.Id , null);
        
        Note nt = new Note(ParentId = vrt.id , Title = 'test');        
        insert nt;
        system.assertNotEquals(nt.Id , null);
    }
}