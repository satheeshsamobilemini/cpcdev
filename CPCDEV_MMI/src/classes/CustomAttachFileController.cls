//****************************************************************
// Name           : CustomAttachFileController
// Creator         : 
// Task           : S-105646
// Created Date   : 14 Nov, 2011
// Note            : 
// Modified By    : Alka Taneja
// Modified Date   : 29 April, 2013
// Case/Story     : 00049016
//****************************************************************/
public with sharing class CustomAttachFileController{
    
  public Attachment attachment{get;set;}
  public Safety_Attachment__c safetyAttachment{get;set;}
  public Id safetyTopicId{get;set;}
  public Boolean isFile{get;set;}
  public List<SelectOption> branches{get;set;}
  public Id safetyTopicRecordType{get;set;}
  // Getting all branch managers associated with multiple branch ids          
  //public Map<String, BranchMgrWithMultipleBranches__c> mulipleBrnchForBMMap;
  // Getting all regional managers associated with multiple branch ids          
  //public Map<String, RegionalMgrWithMultipleBranches__c> mulipleBrnchForRMMap;
  
  //static variable
  //public static String BM = 'Branch Manager';
  //public static String RM = 'Regional Manager';
  //public static String BO = 'Branch Operations';
  public static Integer attachmentAllowedCount = 2;
  
  //--------------------------------------------------------------------------
  // Controller of the class
  //-------------------------------------------------------------------------
  public CustomAttachFileController(ApexPages.StandardController stdController){ 
    
    safetyTopicId = ApexPages.currentPage().getParameters().get('pid');
    attachment = new Attachment();
    safetyAttachment = new Safety_Attachment__c(Safety_Topic__c = safetyTopicId);
    safetyTopicRecordType = getRecordType();
    //mulipleBrnchForBMMap = new Map<String, BranchMgrWithMultipleBranches__c>(BranchMgrWithMultipleBranches__c.getAll());
    //mulipleBrnchForRMMap = new Map<String, RegionalMgrWithMultipleBranches__c>(RegionalMgrWithMultipleBranches__c.getAll());
    branches = loadBranches();
  }   
   
  //--------------------------------------------------------------------------
  // Method to Save the Attachment
  //------------------------------------------------------------------------- 
  public PageReference save() {
    
    Savepoint sp = Database.setSavepoint();
    
    try{ 
      
      if(safetyAttachment.Branch__c == null || safetyAttachment.Branch__c == ''){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.BranchErrorMsg));
        return null;
        
      } else if(attachment.Name == null ||  attachment.body == null){
           ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.FileErrorMsg));
           return null;
           
      }else{
        //Case #00049016       
        List<Safety_Attachment__c> lstSafetyAttachment = new List<Safety_Attachment__c>([select Branch__c from Safety_Attachment__c where Safety_Topic__c = :safetyTopicId and Branch__c = :safetyAttachment.Branch__c limit :attachmentAllowedCount]);
        if(lstSafetyAttachment.size() >= attachmentAllowedCount){
          ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.AllowedAttachmentErrMsg));
           return null;
        }
        
        safetyAttachment.Name = attachment.Name;
        insert safetyAttachment;
        attachment.parentId = safetyAttachment.id;
        insert attachment;
      }
    } catch(Exception ex){ 
        Database.rollback(sp);
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage()));
    } finally {
      // To avoid the view state problem from the VF Page,we have to create a new Attachment. 
      attachment = new Attachment();  
    }
    return new PageReference('/'+safetyTopicId);
  }
  
//--------------------------------------------------------------------------
  // Method to Save the Attachment
  //------------------------------------------------------------------------- 
  public List<SelectOption> loadBranches(){
      
    /*List<String> lstBranchOptions = new List<String>();
    List<SelectOption> BranchOptions = new List<SelectOption>();
    User currentUser;
    
    // Get the current user
    for(User usr : [Select UserRole.Name,Branch_Id__c,Name From User Where Id = : UserInfo.getUserId()]){
      currentUser = usr;
    }
    
    // Add branch id associated with the user detail by defalut
    if(currentUser.Branch_Id__c != null && currentUser.Branch_Id__c != '') {
      lstBranchOptions.add(currentUser.Branch_Id__c);
    }
      
    if(currentUser != null && currentUser.UserRoleId != null && (currentUser.UserRole.Name.contains(BM) || currentUser.UserRole.Name.contains(BO))) {
      
      //If branch managers associated with multiple branch ids 
      if(mulipleBrnchForBMMap.containsKey(currentUser.Name)) {
          
        String branches = mulipleBrnchForBMMap.get(currentUser.Name).Branches_for_BM__c;
        
        if(branches != null && branches != '') {
          for(String br : branches.split(',')){
            lstBranchOptions.add(br);
          }    
        }
       } 
    } else if(currentUser != null && currentUser.UserRoleId != null && currentUser.UserRole.Name.contains(RM)) {
      
      //If Regional managers associated with multiple branch ids 
      if(mulipleBrnchForRMMap.containsKey(currentUser.Name)) {
          
        String branches = mulipleBrnchForRMMap.get(currentUser.Name).Branches_for_RM__c;
        
        if(branches != null && branches != '') {
          for(String br : branches.split(',')){
            lstBranchOptions.add(br);
          }    
        }
       } 
    }else {
      
      lstBranchOptions.clear();
       lstBranchOptions.add('Select');
       Schema.DescribeFieldResult userBranches = Safety_Attachment__c.Branch__c.getDescribe(); 
       List<Schema.PicklistEntry> userBranchValues = userBranches.getPicklistValues();
       for(Schema.PicklistEntry userBranchValue : userBranchValues){
        lstBranchOptions.add(userBranchValue.getValue().substring(0,3));
       }   
    }
    
    if(lstBranchOptions.size() > 0) {
      
      // sort the list
       lstBranchOptions.sort();
       
       //remove duplicate values
       Set<String> setBranchOptions = new Set<String>();
       for(String str : lstBranchOptions) {
         setBranchOptions.add(str.trim());
       }
     
       // create option list after sortning
      for(String branchOp : setBranchOptions ) {
        BranchOptions.add(new SelectOption(branchOp,branchOp));
      } 
    }
    
    return BranchOptions;  */
    
    //Case #00049016 and Case #00049428 (Give all users the full list of branches and let them choose)
    List<SelectOption> lstBranchOptions = new List<SelectOption>();
    lstBranchOptions.clear();
     lstBranchOptions.add(new SelectOption('Select', 'Select'));
     Schema.DescribeFieldResult userBranches = Safety_Attachment__c.Branch__c.getDescribe(); 
     List<Schema.PicklistEntry> userBranchValues = userBranches.getPicklistValues();
     for(Schema.PicklistEntry userBranchValue : userBranchValues){
           /* TFS 5138 fix 
      lstBranchOptions.add(new SelectOption(userBranchValue.getValue().substring(0,3),userBranchValue.getValue().substring(0,3)));
           */
          lstBranchOptions.add(new SelectOption(userBranchValue.getValue(),userBranchValue.getValue()));  
     } 
   
    return lstBranchOptions;  
  }  
  
  //--------------------------------------------------------------------------
  // Method to get record type of the given Safety Topic
  //------------------------------------------------------------------------- 
   public Id getRecordType() {
     
     Safety_Topic__c sf = [select id, RecordTypeId from Safety_Topic__c where id = :safetyTopicId];
     return sf.RecordTypeId;
   }
  }