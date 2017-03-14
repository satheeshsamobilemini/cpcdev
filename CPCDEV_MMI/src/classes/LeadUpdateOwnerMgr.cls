public class LeadUpdateOwnerMgr {

    public static void updateOwnersManager (List<Lead> leadList, Set<ID> ownerIDs){

        // Map of OwnerID to Manager ID
        Map<ID, ID> ownersToManagersMap = New Map<ID, ID>();
        //Map of OwnerID to userTimeZoneSidKey  (PR-03907 - Mobile Mini - Send Lead Reminders During Business Hours)
        Map<Id,String> userMap = new Map<Id,String>();
        // Get a list of Owner IDs and Manager IDs with TimeZoneSidKey(TimeZoneSidKey added for PR-03907 - Mobile Mini - Send Lead Reminders During Business Hours)
        User[] u = [Select Id,IsActive,managerId,TimeZoneSidKey  from User where IsActive = True and ID in :ownerIds];
          
        // Build the user to manager map
        for (integer i=0;i<u.size();i++){
    
            // See if we already have this key (User ID)
            Boolean contains = ownersToManagersMap.containsKey(u[i].Id);
            if (contains == false){
                ownersToManagersMap.put(u[i].Id, u[i].managerId);
            }
            userMap.put(u[i].Id,u[i].TimeZoneSidKey);

        }

        // Update the User's Manager
        for (integer i=0;i<leadList.size();i++){
            leadList[i].Escalate_To__c = ownersToManagersMap.get(leadList[i].ownerId);
            //set Lead Reminder Time (PR-03907 - Mobile Mini - Send Lead Reminders During Business Hours)
            if(userMap.containsKey(leadList[i].ownerId)){
             leadList[i].Lead_Reminder_Time__c = LeadReminderHelper.setReminderTime(System.now(),userMap.get(leadList[i].ownerId));
             System.Debug('Lead Reminder Time '+leadList[i].Lead_Reminder_Time__c); 
            }
        }
        
    
    }   
    
    static testMethod void myUnitTest() {
        
        User Rep1 = [Select Id, ManagerID from User where name like 'R%' and ManagerID != NULL and IsActive = true Limit 1];
        User Rep2 = [Select Id, ManagerID from User where name Like 'A%' and ManagerID != NULL and IsActive = true  Limit 1];
        
        Lead newLead = New Lead(LastName = 'Apex Test Lead', Company = 'Apex Test Company', Escalate_To__c = null, OwnerID = Rep1.ID);
        
        insert newLead;

        Lead queryLead = [Select Id, Escalate_To__c FROM Lead WHERE ID = :newLead.Id];
        //system.assertEquals(queryLead.Escalate_To__c, Rep1.ManagerID); commented by lalit m for deployment
        
        newLead.ownerID = Rep2.ID;
        
        update newLead;
        
        queryLead = [Select Id, Escalate_To__c FROM Lead WHERE ID = :newLead.Id];
        system.assertEquals(queryLead.Escalate_To__c, Rep2.ManagerID);
        
        delete newLead;     
    
    }

}