/*************************************************************************
Name : AttachmentAndNotesTransferBatch 
Created By : Mohit (Appirio Offshore)
Created Date : May 15th, 2013
Description : For Story S-116140 : Attach File with Notes on the VRT object.
              This batch class is used to move Notes & Attachment from standard list to 
              VRT Attachment List.
**************************************************************************/

global class AttachmentAndNotesTransferBatch implements Database.Batchable<SObject>{
	//global final String Query;
	public set<string> selectedRecords = new set<String>();
	
	global Database.QueryLocator start(Database.BatchableContext BC){
			
		String query1 = 'select id, name from Vehicle_Registration_Tracking__c';
		if(selectedRecords.size() > 0) {
			query1 += ' where id in : selectedRecords' ;
		}
		return Database.getQueryLocator(query1);
	}

	global void execute(Database.BatchableContext BC,List<SObject> scope){
		List <Vehicle_Registration_Tracking__c> lstVRT = (List<Vehicle_Registration_Tracking__c>)scope;
		List<VRT_Attachment__c> lstVRTAttachment = new List<VRT_Attachment__c>();
		// Check that wheather the VRT record have the attachment or not 
		for(Attachment attachment : [Select a.ParentId, a.Name, a.Id, a.Body From Attachment a where a.parentId in :lstVRT]){
			VRT_Attachment__c vrtAttachment = new VRT_Attachment__c(Name = attachment.name, Vehicle_Registration_Tracking__c = attachment.ParentId,AttachmentId__c=attachment.Id);
			lstVRTAttachment.add(vrtAttachment);
		}
		if(lstVRTAttachment.size() > 0){
			insert lstVRTAttachment;
		}
	
		// Related to the Attachment
		List<VRT_Attachment__c> lstVRTNote = new List<VRT_Attachment__c>(); 
		
		// Check that wheather the VRT record have the note or not 
		for(Note note : [Select n.ParentId, n.Title, n.Id, n.Body From Note n where n.parentId in :lstVRT]){
			VRT_Attachment__c vrtNote = new VRT_Attachment__c(Name = note.Title, Vehicle_Registration_Tracking__c = note.ParentId,AttachmentId__c=note.Id);
			lstVRTNote.add(vrtNote);
		}
		if(lstVRTNote.size() > 0){
			insert lstVRTNote;
		}
	}	
	
	global void finish(Database.BatchableContext BC){
                
	}
}