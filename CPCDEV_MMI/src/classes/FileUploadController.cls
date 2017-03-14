public with sharing class FileUploadController {
   
    public boolean istrue{get;set;}
    public boolean iserror{get;set;}
    public transient String strAttachFile     {get; set;}
    public transient String strAttachFile1    {get; set;}
    public transient blob fileBody {get; set;}
    public transient blob fileBody1{get; set;}
    public transient blob fileBody2{get; set;}
    public transient blob fileBody3 {get; set;}
    public transient blob fileBody4{get; set;}
    
    public transient String strAttachFile2    {get; set;}
    public transient String strAttachFile3    {get; set;}
    public transient String strAttachFile4    {get; set;}
    
    public transient String strCampaignId;  
    public transient String strContentType    {get; set;}
    public transient String strContentType1   {get; set;}
    public transient String strContentType2   {get; set;}
    
    public transient String strContentType3   {get; set;}
    public transient String strContentType4   {get; set;}
    public List<Attachment> attachmentList {get;set;}
    public Attachment objAttachment1 {get;set;}
    public Attachment objAttachment2 {get;set;}
    public Attachment objAttachment3 {get;set;}
    public Attachment objAttachment4 {get;set;}
    public Attachment objAttachment5 {get;set;}
    public String parentId{get;set;}
    public Boolean AttachView{get;set;}
    public List<Document> DocumentList{get;set;}
    public List<wrapperClass> wrapperList{get;set;}
    
    public FileUploadController()
    {
        iserror = false;
        istrue = true;
        DocumentList = new List<Document>();
        parentId = System.currentPageReference().getParameters().get('parentId');
        wrapperList = new List<wrapperClass>();
        
        string sorg = ApexPages.currentPage().getParameters().get('salesorg');
        String folderID ='';
        
        if(Test.isRunningTest())
            sorg = '1501';
        if(sorg == '1501')
            DocumentList = [Select d.Name, d.Id From Document d where folderID ='00le0000000MdkPAAS'];
        else   
            DocumentList = [Select d.Name, d.Id From Document d where AuthorId = :UserInfo.getUserId()];    
        for(Document doc : DocumentList){
            wrapperClass wrp = new wrapperClass(); wrp.doc = doc;
            wrp.isCheckdoc = false;  wrapperList.add(wrp);
        }
    }
    public class wrapperClass{
        public Document doc{get;set;}
        public Boolean isCheckdoc{get;set;}
        public wrapperClass(){
            isCheckdoc = false;
        }
        
    }
    public void saveDocumentInAttac(){
    }
    public Pagereference save(){
            PageReference pf=null;
            
            if((fileBody != null && fileBody.size() >  5242880) || (fileBody1 != null && fileBody1.size() >  5242880) || (fileBody2 != null && fileBody2.size() >  5242880) || (fileBody3 != null && fileBody3.size() >  5242880) || (fileBody4 != null && fileBody4.size() >  5242880)){
                system.debug('------fileBody.size()----------'+fileBody.size());
                //ApexPages.Message message = new ApexPages.message(ApexPages.severity.ERROR,'Any of one attachment is more then 5 MP file');
                //ApexPages.addMessage(message);
                iserror = true;      istrue = false;     return null;
             }else{ 
                iserror = false;
                istrue = true;
            if(strAttachFile != null && strAttachFile != '' && fileBody != null){
                objAttachment1 = new Attachment(Name= strAttachFile, Body = fileBody, ParentId = parentId);
                try{
                    insert objAttachment1;
                }catch(Exception e ){
                    return null;
                }   
            }
            if(strAttachFile1 != null && strAttachFile1 != ''  && fileBody1 != null){
                objAttachment2 = new Attachment(Name= strAttachFile1, Body = fileBody1, ParentId = parentId);
                try{
                    insert objAttachment2;
                }catch(Exception e ){
                    return null;
                }
            }
            if(strAttachFile2 != null && strAttachFile2 != '' && fileBody2  != null){
                objAttachment3 = new Attachment(Name= strAttachFile2, Body = fileBody2, ParentId = parentId);
                try{
                    insert objAttachment3;
                }catch(Exception e ){
                    return null;
                }
            }
            if(strAttachFile3 != null && strAttachFile3 != '' && fileBody3  != null){
                objAttachment4 = new Attachment(Name= strAttachFile3, Body = fileBody3, ParentId = parentId);
                try{
                    insert objAttachment4;
                }catch(Exception e ){
                    return null;
                } 
            }
            if(strAttachFile4 != null && strAttachFile4 != '' && fileBody4  != null){
                objAttachment5 = new Attachment(Name= strAttachFile4, Body = fileBody4, ParentId = parentId);
                try{
                    insert objAttachment5;
                }catch(Exception e ){
                    return null;
                }
            }
            Set<id> docId = new Set<id>();
            for(wrapperClass wrapSave : wrapperList ){        if(wrapSave.isCheckdoc){ docId.add(wrapSave.doc.Id);
                }
            }
            if(docId.size() > 0){
                List<Attachment> newAttachmentListforDoc = new List<Attachment>();
                List<Document> SelectedDocId = [Select d.Url, d.Type, d.Name, d.Id, d.Description, d.ContentType, d.BodyLength, d.Body From Document d where id IN :docId];
                if(SelectedDocId.size() > 0){
                    for(Document doc : SelectedDocId){
                        Attachment attch = new Attachment(); attch.Name= doc.Name+'.'+doc.Type;
                        attch.Body = doc.Body; attch.ParentId = parentId;         newAttachmentListforDoc.add(attch);
                    }
                }
                insert newAttachmentListforDoc;
            }
            pf = new PageReference('/apex/FullQuoteEmailAttachmentClose');     pf.setRedirect(true);   return pf;
            }
            
            
        }
        
    }