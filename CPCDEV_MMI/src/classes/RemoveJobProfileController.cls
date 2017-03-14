public class RemoveJobProfileController{

public dodge_Project__c dodgeProject{set;get;}
public Job_Profile__c jobProfile{set;get;}

public RemoveJobProfileController(){
    dodgeProject = new Dodge_Project__c(Id = ApexPages.currentPage().getParameters().get('id'),Removed_By__c=UserInfo.getUserId());
}

public PageReference updateDodgeProject(){
    //jobProfile = getJobProfile();
    //if(jobProfile !=null){
       // delete jobProfile;
        update dodgeProject;
    //}
    PageReference pageRef = new PageReference('/apex/DodgeManagementView');
    return pageRef;
}

public Job_Profile__c getJobProfile(){
 Job_Profile__c[] jobProfiles = [select Id,Name from Job_Profile__c where dodge_Project__c =:dodgeProject.id];
 Job_Profile__c tempJobProfile;
 if(jobProfiles.size()>0){
     tempJobProfile= jobProfiles[0];
 }
 return tempJobProfile;
}
}