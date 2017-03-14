/*************************************************************************
Name : NoteInVRTAttachment 
Created By : Mohit (Appirio Offshore)
Created Date : May 16th, 2013
Description : For Story S-116140 : Attach File with Notes on the VRT object.
              This Trigger is used to Add a Note in VRT Attachment Related List.
              
Modified By 		: Alka Taneja [Appirio]
Modified Date		: 18 June 2013
Case 						: 00049333 (To resolve the trigger error on insert of VRT_Attachment__c record)
**************************************************************************/
trigger NoteInVRTAttachment on Note (after insert) {
	
    public VRT_Attachment__c vrtAttachment{get;set;}
    
    //Schema.DescribeSObjectResult descSobject = Schema.SObjectType.Vehicle_Registration_Tracking__c;
    //String keyPreFix = descSobject.getKeyPrefix();
    
    Map<Id, String> mapNoteVsKeyprefix = new Map<Id, String>();
    
    // Gettting all Notes
    for(Note note : Trigger.New){
    	
    	//Getting Note's Parent Id
			String noteParentId = (String) note.ParentId;
			
			//Getting first 3 char of Note's Parent Id (Keyprefix)
			String keyPreFix = noteParentId.substring(0, 3);
			
			//Putting the Note's Parent Keyprefix in map
			if( mapNoteVsKeyprefix != null && !mapNoteVsKeyprefix.containsKey(note.id)) {
			 	mapNoteVsKeyprefix.put(note.id, keyPreFix);
			}
    }
    
   // if(keyPreFix == Label.VRTKeyPrefix){
    	
    Map<Id,Note> noteDetails = new Map<Id,Note>();
    Map<ID , VRT_Attachment__c> noteWithVRT = new Map<ID , VRT_Attachment__c>();
    
    for(Note note : Trigger.New) {
    	
    	// Verify that Notes Parent Id has prefix 'a0K', which proves that the parent from the Vehicle_Registration_Tracking__c Object
    	if( mapNoteVsKeyprefix != null && mapNoteVsKeyprefix.containsKey(Note.id) && mapNoteVsKeyprefix.get(note.id).equals(Label.VRTKeyPrefix)) {
    		vrtAttachment = new VRT_Attachment__c(Vehicle_Registration_Tracking__c = note.parentId,Name = note.Title);
				noteDetails.put(note.Id,note);
				noteWithVRT.put(note.Id,vrtAttachment); 
    	}
    }
    
    if(noteWithVRT.values().size() > 0){
        insert noteWithVRT.values();
    }
    
    for(Id id : noteDetails.keySet()){
        noteWithVRT.get(id).AttachmentId__c = noteDetails.get(Id).Id;
        noteWithVRT.get(id).Description__c = noteDetails.get(Id).Body;
    }
    
    if(noteWithVRT.values().size() > 0){
        update noteWithVRT.values();
    }
   // }   
}