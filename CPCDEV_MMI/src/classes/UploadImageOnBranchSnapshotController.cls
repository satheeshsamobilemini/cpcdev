public with sharing class UploadImageOnBranchSnapshotController {
	public Attachment imageAttachment{get;set;}
	public Weekly_Snapshot_Branch_Report__c branchSnapshot{get;set;}
	
	public UploadImageOnBranchSnapshotController(ApexPages.StandardController stdController){
		Id branchSnapshotId = stdController.getId();
		if(branchSnapshotId != null){
			for(Weekly_Snapshot_Branch_Report__c branchss : [select Id, image_Id__c from Weekly_Snapshot_Branch_Report__c where id = : branchSnapshotId limit 1]){
				branchSnapshot = branchss;
			}
			imageAttachment = new Attachment(parentId = branchSnapshot.id);
		}else{
			imageAttachment = new Attachment();
		}
	}
	
	public PageReference upload(){
		Savepoint branchSnapshotSavePoint = Database.setSavepoint();
		PageReference pageRef = null;
		try{
			
			if(imageAttachment.body == null || imageAttachment.name == null){
				 Apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.INFO,'Please be sure to upload your image.'));
				 return null;
			}else{
				insert imageAttachment;
				branchSnapshot.Image_Id__c = imageAttachment.id;
				update branchSnapshot;
			}
			pageRef = new PageReference('/'+branchSnapshot.id);
		}catch(Exception ex){
			Database.rollback(branchSnapshotSavePoint);
			ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR,ex.getMessage()));
		}
		return pageRef;
	}
	
	public PageReference cancel(){
		if(branchSnapshot != null){
			return new PageReference('/'+branchSnapshot.id);
		}else{
			return new PageReference('/home/home.jsp');
		}
	}

}