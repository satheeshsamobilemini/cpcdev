public class AccountNewButtonProfiles
{  public Boolean allowProfile{get;set;}

    public AccountNewButtonProfiles(ApexPages.StandardController controller) {
     Set<String> profileSet = AssignmentRules.getETSnWMIprofileNames();
     profileSet.add('System Administrator');
     allowProfile = false;
     
     String uProfileName = [select Profile.Name from User where Id =: Userinfo.getUserId()].Profile.Name;
          
     if(profileSet.contains(uProfileName))
     { allowProfile = true;}      

    }

}