trigger deleteSafetyAttachments on Attachment (after delete) {
	Set<Id> safetyAttachmentIds = new Set<Id>(); 
    String safetyAttachmentPrefix = Schema.getGlobalDescribe().get('Safety_Attachment__c').getDescribe().getKeyPrefix();
    for(Attachment attach : Trigger.old){
        if(attach.parentId != null && String.ValueOf(attach.parentId).startsWith(safetyAttachmentPrefix)){
            safetyAttachmentIds.add(attach.parentId);
        }
    }
    if(safetyAttachmentIds.size() > 0){
    	List<Safety_Attachment__c> safetyAttachments = [select Id from Safety_Attachment__c where id in : safetyAttachmentIds];
        delete safetyAttachments;
    }
}