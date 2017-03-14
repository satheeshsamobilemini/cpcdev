/* 
*   Description :   This class is used to compare the attachment records with the VRT Attachment
*
*   Revision History:
*
*   Version             Author              Date
*
*   1.0                 Mohit Batwada    05/27/2013
*/

global class ViewNoteAndAttachment {
    
    ViewNoteAndAttachment(){
    }
    
    webservice static String viewAttachment(Id vrtParentId){
        
        set<Id> vrtAttachmentSet = new set<Id>();
        // Create a set of Parent Object "Vehicle Registration Tracking"
        for(VRT_Attachment__c vrtAttachment : [select id,name,Vehicle_Registration_Tracking__c,AttachmentId__c from VRT_Attachment__c where Vehicle_Registration_Tracking__c =: vrtParentId ]){
            vrtAttachmentSet.add(vrtAttachment.AttachmentId__c);
        }

        String message = 'success';
        List<Attachment> lstDeleteAttachment =  new List<Attachment>(); 
        for(Attachment attachment : [Select Id, IsDeleted, ParentId, Name, IsPrivate, ContentType, BodyLength, Body, OwnerId, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, Description From Attachment where parentId =: vrtParentId order by CreatedDate Desc]){
            //if(vrtAttachmentSet.size()>0 && (! vrtAttachmentSet.contains(attachment.Id))){
            if(! vrtAttachmentSet.contains(attachment.Id)){
                lstDeleteAttachment.add(attachment);    
            } 
        }
        if(lstDeleteAttachment.size() > 0){
        	try {
            	delete lstDeleteAttachment;
            	return message;
        	}catch(Exception ex){
				ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage()));
			}	
        }
        return message;
    }   
}