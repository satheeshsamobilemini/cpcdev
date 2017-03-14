@isTest
public class TestUserHistoryProcessor {

    static testmethod void processorTest(){
     
        List<User> usrList = new List<User>();
       	usrList = createUsers();
        List<id> usrIdLst = new List<Id>();
        for(User usrVar : usrList)
            usrIdLst.add(usrVar.id);
        UserHistoryProcessor.updateUserHistories(usrIdLst);
        UserHistoryProcessor.updateUserHistory(usrIdLst);
    } 
    
    public static List<User> createUsers(){
        List<User> usrListToInsert = new List<User>();
        //List<User> usrListToUpdate = new List<User>();
        Id profileId = userinfo.getProfileId();
        User user1 = new User(
            Username = 'john123456789@acme.com',
            Email = 'john@acme.com',
            LastName = 'vhir',
            Alias = 'sv',
            ProfileID = profileId,
            LocaleSidKey = 'en_US',
            LanguageLocaleKey = 'en_US',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey='UTF-8',
            Territory__c = 'tst-terr'
        );
        
         User user2 = new User(
            Username = 'jane123456789@acme.com',
            Email = 'jane@acme.com',
            LastName = 'vpphir',
            Alias = 'jv',
            ProfileID = profileId,
            LocaleSidKey = 'en_US',
            LanguageLocaleKey = 'en_US',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey='UTF-8'
            );
       usrListToInsert.add(user1);
       usrListToInsert.add(user2);
        if(usrListToInsert != NULL)
            INSERT usrListToInsert;
       user usrVar = [select Id,Territory__c,(select Id,Name,End_Date__c,Start_Date__c,Territory__c,User_Name__c,isActive__c from User_Histories__r) from User where territory__c = 'tst-terr']; 
       User_History__c uh = usrVar.User_Histories__r;
       uh.Start_Date__c= System.today() -2;
       usrVar.Territory__c = 'territory2';
       update usrVar;
        
        return usrListToInsert;
    }    
}