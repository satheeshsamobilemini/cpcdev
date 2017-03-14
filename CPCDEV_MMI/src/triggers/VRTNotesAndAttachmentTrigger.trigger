/*************************************************************************
Name : VRTNotesAndAttachmentTrigger 
Created By : Mohit (Appirio Offshore)
Created Date : May 17th, 2013
Description : For Story S-116140 : Attach File with Notes on the VRT object.
              This trigger is used to Update & Delete the standard Note & Attachment on the basis of VRT_Attachment__c.
              
**************************************************************************/
trigger VRTNotesAndAttachmentTrigger on VRT_Attachment__c (after update, before delete) {
    
    if(Trigger.isUpdate){
        set<Id> vrtParentId = new set<Id>();
        // Create a set of Parent Object "Vehicle Registration Tracking"
        for(VRT_Attachment__c vrtAttachment : Trigger.New){
            vrtParentId.add(vrtAttachment.Vehicle_Registration_Tracking__c);
        }
        Map<Id,Attachment> mapAttachment = new Map<Id,Attachment>([Select Id, IsDeleted, ParentId, Name, IsPrivate, ContentType, BodyLength, Body, OwnerId, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, Description From Attachment where parentId in : vrtParentId order by CreatedDate Desc]);
        Map<Id,Note> mapNote = new Map<Id,Note>([Select Id, IsDeleted, ParentId, Title, IsPrivate, Body, OwnerId, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp From Note where parentid in : vrtParentId order by CreatedDate Desc]);
        for(VRT_Attachment__c vrtAttachment : Trigger.new){
            if(mapAttachment.size()>0 && mapAttachment.containsKey(vrtAttachment.AttachmentId__c)){
                mapAttachment.get(vrtAttachment.AttachmentId__c).Description =  vrtAttachment.Description__c;
                mapAttachment.get(vrtAttachment.AttachmentId__c).Name = vrtAttachment.Name;
                mapAttachment.get(vrtAttachment.AttachmentId__c).IsPrivate = vrtAttachment.IsPrivate__c;
            }else if(mapNote.size()>0 && mapNote.containsKey(vrtAttachment.AttachmentId__c)){
                mapNote.get(vrtAttachment.AttachmentId__c).Title = vrtAttachment.Name;
                mapNote.get(vrtAttachment.AttachmentId__c).Body = vrtAttachment.Description__c;
                mapNote.get(vrtAttachment.AttachmentId__c).IsPrivate = vrtAttachment.IsPrivate__c;
            }
        }
        if(mapAttachment.values().size() > 0){
            update mapAttachment.values();
        }
        if(mapNote.values().size() > 0){
            update mapNote.values();
        }
    }
    
    if(Trigger.isDelete){
        set<Id> vrtParentId = new set<Id>();
        set<Id> vrtAttachmentId = new set<Id>();
        for(VRT_Attachment__c vrtAttachment : Trigger.old){
            vrtParentId.add(vrtAttachment.Vehicle_Registration_Tracking__c);
        }
        
        Map<Id,Attachment> mapAttachment = new Map<Id,Attachment>([Select Id, IsDeleted, ParentId, Name, IsPrivate, ContentType, BodyLength, Body, OwnerId, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, Description From Attachment where parentId in : vrtParentId order by CreatedDate Desc]);
        Map<Id,Note> mapNote = new Map<Id,Note>([Select Id, IsDeleted, ParentId, Title, IsPrivate, Body, OwnerId, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp From Note where parentid in : vrtParentId order by CreatedDate Desc]);
        List<Attachment> lstDeleteAttachment =  new List<Attachment>();
        List<Note> lstDeleteNote =  new List<Note>();
        for(VRT_Attachment__c vrtAttachment : Trigger.old){
            if(mapAttachment.size()>0 && mapAttachment.containsKey(vrtAttachment.AttachmentId__c)){
                lstDeleteAttachment.add(mapAttachment.get(vrtAttachment.AttachmentId__c));
            }else if(mapNote.size()>0 && mapNote.containsKey(vrtAttachment.AttachmentId__c)){
                lstDeleteNote.add(mapNote.get(vrtAttachment.AttachmentId__c));
            }
        }
        if(lstDeleteAttachment.size() > 0){
            delete lstDeleteAttachment;
        }
        if(lstDeleteNote.size() > 0){
            delete lstDeleteNote;
        }
    }
}