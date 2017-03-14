/**
 * (c) 2015 TEKsystems Global Services
 *
 * Name           : UserHistoryProcessor
 * Created Date   : 15 April 2015
 * Created By     : Sreenivas M (TEKSystems)
 * Purpose        : Class used by process builder to create a user history records
 *
 **/
public class UserHistoryProcessor
{
   @InvocableMethod 
  public static void updateUserHistory(List<Id> userIds)
  {
    UserHistoryProcessor.updateUserHistories(userIds);
  }
  
  @future
  public static void updateUserHistories(List<Id> listuserIds)
   {
        List<User> userList = new List<User>();
        List<User_History__c> userUpsertList = new List<User_History__c>();

        userList = [select Id,Territory__c,(select Id,Name,End_Date__c,Start_Date__c,Territory__c,User_Name__c,isActive__c from User_Histories__r) from User where id in :listuserIds]; 

        for(User u : userList)
        {
            for(User_History__c uh : u.User_Histories__r)
            {
                //Logic to update today created records
                if(uh.Start_Date__c==System.today() && uh.End_Date__c==null)
                {
                 uh.End_Date__c = System.today();
                 uh.isActive__c = String.isBlank(u.Territory__c)?true:false;
                }

                //Logic to update not created today

                if(uh.Start_Date__c<System.today() && uh.End_Date__c==null)
                {
                 uh.End_Date__c = System.today()-1;
                 uh.isActive__c = true;
                }
                userUpsertList.add(uh);
                        
            }
            
            if(!String.isBlank(u.Territory__c))
            {
                User_History__c  objUH = new User_History__c();
                objUH.Start_Date__c = System.today();
                objUH.Territory__c = u.Territory__c;
                objUH.User_Name__c = u.id;
                objUH.isActive__c = true;
                userUpsertList.add(objUH);
            }
             
        }
        if(!userUpsertList.isEmpty())
            upsert userUpsertList;
   }
}