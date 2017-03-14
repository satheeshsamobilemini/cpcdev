/*
Modified by : Akansha Bhatia
Story : S-135929
*/
public class NewJobProfileController {
    
    public Job_Profile__c jobProfile{get;set;}
    public Dodge_Project__c dodgeProject{get;set;}
    public String selectedBranch{set;get;}
    public String dodgeProjectId{set;get;}
    public String dodgeProjectName{set;get;}
    public String dodgeProjectNm{set;get;}
    public String selectePageNumber {get;set;}
    //New Glenigan related variable 
    public String GleniganProjectId{set;get;}
    public String GleniganProjectName{set;get;}
    public String GleniganProjectNm{set;get;}
    
    public String projectType{set;get;}
    
    public NewJobProfileController(ApexPages.StandardController controller){
        selectedBranch = ApexPages.currentPage().getParameters().get('selectedBranch');
        jobProfile = setJobProfile();
        projectType = Apexpages.currentPage().getParameters().get('ReferralSource');
        system.debug('-Megha-debug-'+projectType);
        
        if(projectType != null && projectType.equals('Glenigan')){
            GleniganProjectId = ApexPages.currentPage().getParameters().get('GleniganProjectId');
            GleniganProjectName = ApexPages.currentPage().getParameters().get('GleniganProjectName');
            GleniganProjectNm = ApexPages.currentPage().getParameters().get('GleniganProject');
            
        }
        else if(projectType != null && projectType.equals('Dodge')){
            dodgeProjectId = ApexPages.currentPage().getParameters().get('dodgeProjectId');
            dodgeProjectName = ApexPages.currentPage().getParameters().get('dodgeProjectName');
            dodgeProjectNm = ApexPages.currentPage().getParameters().get('dodgeProject');
            selectePageNumber = ApexPages.currentPage().getParameters().get('pageNumber');
        }
        System.Debug('Selected Branch '+selectedBranch);
    }
    public PageReference saveJobProfile(){
        try{
            //jobProfile.Dodge_Project__c = dodgeProjectId;
            RecordType recordType;
            if(projectType != null && projectType.equalsIgnoreCase('dodge')){
              for(RecordType rt :[select Id, Name from RecordType where Name = 'Job Profile - US/CAN' and sObjectType ='Job_Profile__c' limit 1] ){
                recordType = rt;
              } 
            }else if (projectType != null && projectType.equalsIgnoreCase('Glenigan')){
              for(RecordType rt :[select Id, Name from RecordType where Name = 'Job Profile - UK' and sObjectType ='Job_Profile__c' limit 1] ){
                recordType = rt;
              } 
            }
            if(recordType != null){
                jobProfile.RecordTypeId = recordType.id;
            }
            insert jobProfile;  
        }catch(Exception ex){}
        PageReference pageRef = null;
        if(projectType != null && projectType.equalsIgnoreCase('Glenigan')){
            pageRef = new PageReference('/apex/GleniganManagementView?selectedBranch='+selectedBranch);
        }else if(projectType != null && projectType.equalsIgnoreCase('Dodge') && jobProfile.Id != null){
            //pageRef = new PageReference('/apex/DodgeManagementView?selectedBranch='+selectedBranch+'&pageNumber='+selectePageNumber);
            pageRef = new PageReference('/' + jobProfile.Id); // TFS 7442    
        }
        return pageRef;
    }
    public PageReference saveAndNewJobProfile(){
        try{
            //jobProfile.Dodge_Project__c = dodgeProjectId;
            insert jobProfile;
            jobProfile = setJobProfile();
        }catch(Exception ex){}
        Date targetStartDate = jobProfile.Target_Start_Date__c;
        Date bidDate = jobProfile.Bid_Date__c;
        Date targetEndDate = jobProfile.Expected_Completion_Date__c;
        String targetStartDateStr = '';
        String targetEndDateStr = '';
        String bidDateStr = '';
        if(targetStartDate != null){
            targetStartDateStr = targetStartDate.format();
        }
        if(targetEndDateStr != null && targetEndDate != null){                // MSM 102
            targetEndDateStr = targetEndDate.format();
        }
        if(bidDate != null){
            bidDateStr = bidDate.format();
        }
        PageReference pageRef;
        String url;
        if(projectType != null && projectType.equals('Glenigan')){
            url = generateGleniganURL(targetStartDateStr,targetEndDateStr,bidDateStr);
        }else if(projectType != null && projectType.equals('Dodge')){
            url = generateDodgeURL(targetStartDateStr,bidDateStr);
        }
        if(url != null){
            pageRef = new PageReference(url);
        }
        /*PageReference pageRef = new PageReference('/apex/NewJobProfile?name=' + 
                            checkNullAndEncode(ApexPages.currentPage().getParameters().get('name')) +
                            '&dodgeProjectId=' +
                            checkNullAndEncode(ApexPages.currentPage().getParameters().get('dodgeProjectId')) +
                            '&dodgeProject=' +
                            checkNullAndEncode(ApexPages.currentPage().getParameters().get('dodgeProjectId')) + 
                            '&TargetSD=' +
                            checkNullAndEncode(targetStartDateStr) + 
                            '&BidDate=' + 
                            checkNullAndEncode(bidDateStr) +
                            '&JSAddress=' +
                            checkNullAndEncode(ApexPages.currentPage().getParameters().get('JSAddress')) +
                            '&JSCity=' + 
                            checkNullAndEncode(ApexPages.currentPage().getParameters().get('JSCity')) + 
                            '&JSState=' +
                            checkNullAndEncode(ApexPages.currentPage().getParameters().get('JSState')) + 
                            '&JSZip=' +
                            checkNullAndEncode(ApexPages.currentPage().getParameters().get('JSZip')) + 
                            '&JSCounty=' + 
                            checkNullAndEncode(ApexPages.currentPage().getParameters().get('JSCounty')) + 
                            '&projectStatus=' +
                            checkNullAndEncode(ApexPages.currentPage().getParameters().get('projectStatus')) + 
                            '&ReferralSource=Dodge&ValuationHigh=' +
                            checkNullAndEncode('ValuationHigh') +
                            '&ValuationLow=' +
                            checkNullAndEncode('ValuationLow') +
                            '&JSCountry=' +
                            checkNullAndEncode(ApexPages.currentPage().getParameters().get('JSCountry')) +
                            '&selectedBranch='+selectedBranch);*/
        return pageRef;
    }
    
    private String generateDodgeURL(String targetStartDateStr,String bidDateStr){
        String dodgeURL =   '/apex/NewJobProfile?name=' + 
                            checkNullAndEncode(ApexPages.currentPage().getParameters().get('name')) +
                            '&dodgeProjectId=' +
                            checkNullAndEncode(ApexPages.currentPage().getParameters().get('dodgeProjectId')) +
                            '&dodgeProject=' +
                            checkNullAndEncode(ApexPages.currentPage().getParameters().get('dodgeProjectId')) + 
                            '&TargetSD=' +
                            checkNullAndEncode(targetStartDateStr) +
                            '&BidDate=' + 
                            checkNullAndEncode(bidDateStr) +
                            '&JSAddress=' +
                            checkNullAndEncode(ApexPages.currentPage().getParameters().get('JSAddress')) +
                            '&JSCity=' + 
                            checkNullAndEncode(ApexPages.currentPage().getParameters().get('JSCity')) + 
                            '&JSState=' +
                            checkNullAndEncode(ApexPages.currentPage().getParameters().get('JSState')) + 
                            '&JSZip=' +
                            checkNullAndEncode(ApexPages.currentPage().getParameters().get('JSZip')) + 
                            '&JSCounty=' + 
                            checkNullAndEncode(ApexPages.currentPage().getParameters().get('JSCounty')) + 
                            '&projectStatus=' +
                            checkNullAndEncode(ApexPages.currentPage().getParameters().get('projectStatus')) + 
                            '&ReferralSource=Dodge&ValuationHigh=' +
                            checkNullAndEncode('ValuationHigh') +
                            '&ValuationLow=' +
                            checkNullAndEncode('ValuationLow') +
                            '&JSCountry=' +
                            checkNullAndEncode(ApexPages.currentPage().getParameters().get('JSCountry')) +
                            '&selectedBranch='+selectedBranch;
                            
     return dodgeURL;
        
    } 
    
    private String generateGleniganURL(String targetStartDateStr,String targetEndDateStr,String bidDateStr){
        String GleniganURL = '/apex/NewJobProfile?name=' + 
                            checkNullAndEncode(ApexPages.currentPage().getParameters().get('name')) +
                            '&GleniganProjectId=' +
                            checkNullAndEncode(ApexPages.currentPage().getParameters().get('GleniganProjectId')) +
                            '&GleniganProject=' +
                            checkNullAndEncode(ApexPages.currentPage().getParameters().get('GleniganProjectId')) + 
                            '&TargetSD=' +
                            checkNullAndEncode(targetStartDateStr) +
                            '&TargetED=' +
                            checkNullAndEncode(targetEndDateStr) +  
                            '&BidDate=' + 
                            checkNullAndEncode(bidDateStr) +
                            '&JSAddressLine1=' +
                            checkNullAndEncode(ApexPages.currentPage().getParameters().get('JSAddress')) +
                            '&JSAddressLine2=' + 
                            checkNullAndEncode(ApexPages.currentPage().getParameters().get('JSAddressLine2')) + 
                            '&JSAddressLine3=' +
                            checkNullAndEncode(ApexPages.currentPage().getParameters().get('JSAddressLine3')) + 
                            '&JSAddressLine4=' +
                            checkNullAndEncode(ApexPages.currentPage().getParameters().get('JSAddressLine4')) + 
                            '&JSPostal=' + 
                            checkNullAndEncode(ApexPages.currentPage().getParameters().get('JSPostal')) +
                            '&JSGleniganCountry=UK'+ 
                            '&projectStatus=' +
                            checkNullAndEncode(ApexPages.currentPage().getParameters().get('projectStatus')) + 
                            '&ReferralSource=Glenigan'+
                            '&GleniganValue=' +
                            checkNullAndEncode('GleniganValue')+
                            '&selectedBranch='+selectedBranch;
                            
     return GleniganURL;
        
    } 
    public PageReference cancel(){
        PageReference pageRef;
        if(projectType != null && projectType.equalsIgnoreCase('Glenigan')){
            pageRef = new PageReference('/apex/GleniganManagementView?selectedBranch='+selectedBranch);
        }else if(projectType != null && projectType.equalsIgnoreCase('Dodge')){
            pageRef = new PageReference('/apex/DodgeManagementView?selectedBranch='+selectedBranch+'&pageNumber='+selectePageNumber);
        }
        return pageRef;
    }
    
    private String checkNullAndEncode(String strToCheck) {
        if(strToCheck != null) {
            return EncodingUtil.urlEncode(strToCheck, 'UTF-8');
        }
        return '';
    }
    
    private Job_Profile__c setJobProfile(){
        Job_Profile__c tempJobProfile = new Job_Profile__c();
        tempJobProfile.Name=ApexPages.currentPage().getParameters().get('name'); 
        //tempJobProfile.Dodge_Project__c=ApexPages.currentPage().getParameters().get('dodgeProjectId');
        tempJobProfile.OwnerId=UserInfo.getUserId();
        tempJobProfile.Job_Site_Address__c=ApexPages.currentPage().getParameters().get('JSAddress');
        tempJobProfile.Job_Site_City__c=ApexPages.currentPage().getParameters().get('JSCity');
        tempJobProfile.Job_Site_State__c=ApexPages.currentPage().getParameters().get('JSState');
        tempJobProfile.Job_Site_Zip__c=ApexPages.currentPage().getParameters().get('JSZip');
        tempJobProfile.Job_Site_County__c=ApexPages.currentPage().getParameters().get('JSCounty');
        tempJobProfile.Job_Site_Country__c=ApexPages.currentPage().getParameters().get('JSCountry');
        tempJobProfile.Project_Stage_Status__c=ApexPages.currentPage().getParameters().get('projectStatus');
        tempJobProfile.Referral_Source__c=ApexPages.currentPage().getParameters().get('ReferralSource');
        tempJobProfile.Glenigan_Value__c = ApexPages.currentPage().getParameters().get('GleniganValue');
        tempJobProfile.Site_Address__c = ApexPages.currentPage().getParameters().get('JSAddressLine1'); 
        tempJobProfile.Address_Line_2__c = ApexPages.currentPage().getParameters().get('JSAddressLine2');   
        tempJobProfile.Address_Line_3__c = ApexPages.currentPage().getParameters().get('JSAddressLine3');   
        tempJobProfile.Address_Line_4__c = ApexPages.currentPage().getParameters().get('JSAddressLine4');   
        tempJobProfile.Site_Postcode__c = ApexPages.currentPage().getParameters().get('JSPostal');
        tempJobProfile.Site_Country__c = ApexPages.currentPage().getParameters().get('JSGleniganCountry'); 
        
        //MSM - 28 (start)..
        if(ApexPages.currentPage().getParameters().get('ValuationLow') != null && ApexPages.currentPage().getParameters().get('ValuationLow').length()> 0){
            tempJobProfile.Project_Valuation_Low__c = Double.valueof(ApexPages.currentPage().getParameters().get('ValuationLow'));
        }
        if(ApexPages.currentPage().getParameters().get('ValuationHigh') != null && ApexPages.currentPage().getParameters().get('ValuationHigh').length()> 0){   
            tempJobProfile.Project_Valuation_High__c = Double.valueof(ApexPages.currentPage().getParameters().get('ValuationHigh'));    
        }
       // MSM - 28 (end)....  
              
        if(ApexPages.currentPage().getParameters().get('TargetSD')!=null && ApexPages.currentPage().getParameters().get('TargetSD').length()>0)
            tempJobProfile.Target_Start_Date__c =Date.parse(ApexPages.currentPage().getParameters().get('TargetSD'));
         if(ApexPages.currentPage().getParameters().get('TargetED')!=null && ApexPages.currentPage().getParameters().get('TargetED').length()>0)
            tempJobProfile.Expected_Completion_Date__c = Date.parse(ApexPages.currentPage().getParameters().get('TargetED'));
        if(ApexPages.currentPage().getParameters().get('BidDate')!=null && ApexPages.currentPage().getParameters().get('BidDate').length()>0)
            tempJobProfile.Bid_Date__c =Date.parse(ApexPages.currentPage().getParameters().get('BidDate'));
        return tempJobProfile;  
    }
    

}