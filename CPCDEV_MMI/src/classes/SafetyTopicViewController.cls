public with sharing class SafetyTopicViewController {
    
    public Safety_Topic__c safetyTopic{get;set;}
    public Id safetyId;
    public List<SafetyAttachment> safetyAttachments{get;set;}
    public String sortOn { get; set; }
    public String sortOrder { get; set; }
    
    public SafetyTopicViewController(ApexPages.StandardController stdController){
        safetyId =  stdController.getId();
        sortOn = 'Name';
        sortOrder = 'ASC';
        safetyAttachments = loadSafetyAttachmentWrappers();
    }
    
    public class SafetyAttachment{
        public Safety_Attachment__c safetyAttachmnt{get;set;}
        public Attachment attachment{get;set;}
        
        public SafetyAttachment(Safety_Attachment__c safetyAttachmnt,Attachment attachment){
            this.safetyAttachmnt = safetyAttachmnt;
            this.attachment = attachment;
        }
    }
    
    public List<SafetyAttachment> loadSafetyAttachmentWrappers(){
        List<SafetyAttachment> tempAttachments = new List<SafetyAttachment>();
        List<Safety_Attachment__c> tempSAttachments = loadSafetyAttachments();
        for(Safety_Attachment__c safetyAt : tempSAttachments){
            if(safetyAt.attachments.size() > 0){
                tempAttachments.add(new SafetyAttachment(safetyAt,safetyAt.attachments.get(0)));
            }
        }
        return tempAttachments;
    }
    
    public List<Safety_Attachment__c> loadSafetyAttachments(){
    	String safetyAttachmentQuery = 'select id,Branch__c, Safety_Topic__c,(select id,Name, CreatedDate, LastModifiedDate, CreatedById , CreatedBy.Name from Attachments) from Safety_Attachment__c where Safety_Topic__c =: safetyId order by ' + sortOn + ' ' + sortOrder;
    	List<Safety_Attachment__c> safetyAttachments = Database.query(safetyAttachmentQuery);
    	return safetyAttachments;
    }
    
   	public void doSortedSearch(){
   		if(sortOn != null && sortOrder == 'ASC') {
            sortOrder = 'DESC';
        } else  if(sortOn != null && sortOrder == 'DESC') {
            sortOrder = 'ASC';
        }
        safetyAttachments = loadSafetyAttachmentWrappers();
   	}
   
    public PageReference attachFile(){
        //Safety_Attachment__c safetyAttachmnt = new Safety_Attachment__c(Name='Test',safety_Record__c = safetyId);
        //insert safetyAttachmnt ;
       // https://ap1.salesforce.com/a0L90000001wPam&parentname=T-3&retURL=%2Fa0L90000001wPam
        //p/attach/NoteAttach?pid=a0L90000001wPam&parentname=T-3&retURL=%2Fa0L90000001wPam
        return new pageReference('/apex/CustomAttachFile?pid='+safetyId);
         
    }
    
}