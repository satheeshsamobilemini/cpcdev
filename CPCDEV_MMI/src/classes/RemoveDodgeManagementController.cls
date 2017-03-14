/********************************************************************************************
Name                : RemoveDodgeManagementController
Usage               : Controller class of RemoveDodgeManagement VF page.
Author              : 
Date                :  4/2/2010  

Modified By     : Alka Taneja(Appirio Offshore)
Modified Date : 10 May, 2013 
purpose             : Save filters during the search of DodgeManagementView page
Story                   : S-116139

Modified by : Akanksha Bhatia
Story : S-135929
********************************************************************************************/
public class RemoveDodgeManagementController{
    public dodge_Project__c dodgeProject{set;get;}
    public String selectedBranch{get;set;}
    public String selectedDate{get;set;}
    public String selectedActionStages{get;set;}
    public String sortOrder{get;set;}
    public String sortOn{get;set;}
    public String s {get;set;}
    public String selectedPageNumber {get;set;}
    public Boolean isDisplay {get;set;} // Sales Restructure 2015
    public Boolean disableInput {get;set;}  // Sales Restructure 2015
    //-----------------------------------------------------------------------------
    // Method for RemoveDodgeManagementController Constructor
    //-----------------------------------------------------------------------------
    public RemoveDodgeManagementController(){
        dodgeProject = [select Id,BM_Approver__c,isBMactive__c,ISM_Approver__c,isISMactive__c,Approver_mail__c,Removed_By__c,Reason_Why_Project_Removed__c,Reason_Removed_Comments__c,Job_Profile_Status__c 
                        from Dodge_Project__c where id=: ApexPages.currentPage().getParameters().get('id') LIMIT 1]; // Sales Restructure 2015
        dodgeProject.Removed_By__c = UserInfo.getUserId();             // Sales Restructure 2015
        isDisplay = false ; // Sales Restructure 2015
        disableInput = false; // Sales Restructure 2015
        selectedBranch = ApexPages.currentPage().getParameters().get('SelectedBranch');
        selectedDate = ApexPages.currentPage().getParameters().get('selectedDate');
        selectedActionStages = ApexPages.currentPage().getParameters().get('selectedActionStages');
        // To maintain the sort order after remove the record (S-116139)
        sortOn = ApexPages.currentPage().getParameters().get('sortOn');
        sortOrder = ApexPages.currentPage().getParameters().get('sortOrder');
        selectedPageNumber = ApexPages.currentPage().getParameters().get('pageNumber');
        makeStages();
    }
    //-----------------------------------------------------------------------------
    // Method for updateDodgeProject (Save) button
    //-----------------------------------------------------------------------------
    public PageReference updateDodgeProject(){
      system.debug('------------ dodgeProject.Job_Profile_Status__c ---------------' + dodgeProject.Job_Profile_Status__c);
      system.debug('------------ dodgeProject.Reason_Why_Project_Removed__c ---------------' + dodgeProject.Reason_Why_Project_Removed__c);
      system.debug('------------ dodgeProject.Reason_Removed_Comments__c ---------------' + dodgeProject.Reason_Removed_Comments__c);
        if(dodgeProject.Reason_Why_Project_Removed__c == null || dodgeProject.Reason_Why_Project_Removed__c == '')
          {  ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Please enter Reason for Removal.');
             ApexPages.addMessage(msg);
              return null;
          }
         
       if((dodgeProject.Reason_Why_Project_Removed__c == 'Other') && (dodgeProject.Reason_Removed_Comments__c == null || dodgeProject.Reason_Removed_Comments__c == '' ))
          { ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR,'Please provide comments.');
            ApexPages.addMessage(msg);
            return null;
          }
        
        map<String,String> userRoleEmailmap = new map<String,String>(); // Sales Restructure 2015
        User[] ulist = [select Id,UserRole.name,Email from User where Id=:userInfo.getUserId() or Id=:dodgeProject.BM_Approver__c or Id=:dodgeProject.ISM_Approver__c]; 
        User u;
        string msgInfo ='';
        
        for(integer i =0; i<ulist.size(); i++){
          if(ulist[i].Id==UserInfo.getUserId())
             u = ulist[i];
          else if(dodgeProject.BM_Approver__c <> null && ulist[i].Id== dodgeProject.BM_Approver__c)
            { userRoleEmailmap.put('BM',ulist[i].Email); }
          else if(dodgeProject.ISM_Approver__c <> null && ulist[i].Id==dodgeProject.ISM_Approver__c)
          { userRoleEmailmap.put('ISM',ulist[i].Email); }         
        }
        
        if(!u.UserRole.Name.contains('Sales Rep')){
          dodgeProject.Job_Profile_Status__c = 'Removed';   
          update dodgeProject;
          PageReference pageRef = new PageReference('/apex/DodgeManagementView?selectedBranch='+selectedBranch+'&pageNumber='+selectedPageNumber+'&selectedDate='+selectedDate+'&selectedActionStages='+s+'&sortOn='+sortOn+'&sortOrder='+sortOrder);
          return pageRef;
        } else{
        
          if(dodgeProject.BM_Approver__c<>null && dodgeProject.isBMactive__c)
              { dodgeProject.Approver_mail__c = userRoleEmailmap.get('BM'); }
          else if(dodgeProject.ISM_Approver__c<>null && dodgeProject.isISMactive__c) 
              { dodgeProject.Approver_mail__c = userRoleEmailmap.get('ISM');}  
          else { dodgeProject.Approver_mail__c = ''; } 
        
          dodgeProject.Requester_Email__c = u.Email;
          update dodgeProject;
          
          Approval.ProcessSubmitRequest ap = new Approval.ProcessSubmitRequest();
          ap.setComments('Dodge Approval Process');
          ap.setObjectId(dodgeProject.Id);
          Approval.ProcessResult ares = Approval.Process(ap); 
          
          
          if(ares.isSuccess()){
            isDisplay = true;
            disableInput = true;
          
           if((dodgeProject.BM_Approver__c == null || !dodgeProject.isBMactive__c) && (dodgeProject.ISM_Approver__c == null || !dodgeProject.isISMactive__c)){
              msgInfo = 'No active Branch Manager or Inside Sales Manager to approve this request';
             }else { msgInfo = 'Record sent for Approval !!'; }
            
           ApexPages.Message msg = new ApexPages.Message(ApexPages.SEVERITY.INFO,msgInfo);
           ApexPages.addMessage(msg);
           return null;
          }
        }
      return null;  
    }
    //-----------------------------------------------------------------------------
    // Method for cancel button
    //-----------------------------------------------------------------------------
    public PageReference cancel(){
        PageReference pageRef = new PageReference('/apex/DodgeManagementView?selectedBranch='+selectedBranch+'&pageNumber='+selectedPageNumber+'&selectedDate='+selectedDate+'&selectedActionStages='+s+'&sortOn='+sortOn+'&sortOrder='+sortOrder);
        return pageRef;
    }
    //-----------------------------------------------------------------------------
    // Method to prepare the comma seperated Strings of get stages
    //-----------------------------------------------------------------------------
    public void makeStages() {
        
    List<String> ss = new List<String>();
    if(selectedActionStages != null) {
        selectedActionStages = selectedActionStages.replace('[','').replace(']' , '');
        ss = selectedActionStages.split(',');
    }
        
    s = '';
    for(String str : ss ){
        s +=  str.trim() + ',';
    }
    if(s != '') { 
        s = s.substring(0,s.length()-1);
    }
    // Encode String before passing
    s = EncodingUtil.urlEncode(s, 'UTF-8');
    }
}