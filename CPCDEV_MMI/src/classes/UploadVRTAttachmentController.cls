/* 
*	Description : 	This class is used to upload the attachment
*
*   Revision History:
*
*	Version				Author				Date
*
*   1.0            		Mohit Batwada    	May 10, 2013
*/

public with sharing class UploadVRTAttachmentController {
	public VRT_Attachment__c vrtAttachment{get;set;}
	public boolean isSaved{get;set;}
	public String attachmentName{get;set;}
	 
	public Id recId{get;set;}
	public UploadVRTAttachmentController(ApexPages.StandardController ctlr){  
        recId = ctlr.getRecord().Id;
        isSaved = false; 
    }
	public Attachment attachment {
	  	get {
	      if (attachment == null)
	        attachment = new Attachment();
	      return attachment;
	    }
	  	set;
  	}
  	public void attachFile(){
    	try{
			if(attachment.name == null ||  attachment.body == null){
	   			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please Select a file'));
	   		}else{     	  
		   		isSaved = true;
		   		attachmentName = attachment.name;
		   		attachment.ParentId = recId;
		   		insert attachment;
		   		vrtAttachment = new VRT_Attachment__c(Vehicle_Registration_Tracking__c = recId, name = attachment.name);
		   		vrtAttachment.AttachmentId__c = attachment.Id;
			}	
		}catch(Exception ex){
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage()));
		}finally{
			// To avoid the view state problem from VF Page,we have to create a new Attachment 
			attachment = new Attachment();	
		}	
    }
 
  public PageReference upload() {
 	PageReference pageReference = null;
    Attachment attach;
    try {
    	if(vrtAttachment != null){
	    	insert vrtAttachment;
	      	attach = new Attachment(Id=vrtAttachment.AttachmentId__c);
	      	attach.Description = vrtAttachment.Description__c;
	      	update attach;
	      	pageReference = new PageReference('/'+recId+'?nooverride=1');
    	}else{
    		pageReference = new PageReference('/'+recId+'?nooverride=1');
    	}
    	  	
    }catch (DMLException e) {
      	ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment'));
      	return null;
    }
    pageReference.setRedirect(true);
    return pageReference;
  }
}