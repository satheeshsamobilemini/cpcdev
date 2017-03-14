trigger SetLeadReminderTime on Lead (after insert, after update) {
    
    if(Trigger.isInsert){
        Set<Id> owneId = new Set<ID>();
        Map<Id,Lead> leadMap = new Map<Id,Lead>();
        Map<Id,Id> leadOwnerMap = new Map<Id,Id>();
        Map<Id,User> userMap = new Map<Id,User>();
        List<Lead> leadlist = new List<Lead>();
        String mailString ='';
        for(Lead lead : [select Id, Name, CreatedDate, ownerId from Lead where id in : Trigger.NewMap.keySet()]){
            leadMap.put(lead.Id,lead);
            leadOwnerMap.put(lead.Id,lead.OwnerId);
        }
    
        for(User usr : [select Id,TimeZoneSidKey,Name from User where id in : leadOwnerMap.values()]){
            userMap.put(usr.Id,usr);
        }
    
        for( Id leadId : leadMap.keySet()){
            Lead lead = leadMap.get(leadId );
            if(leadOwnerMap.containsKey(leadId) && userMap.containsKey(leadOwnerMap.get(leadId))){
                User usr =  userMap.get(leadOwnerMap.get(leadId));
                mailString= mailString +'\nLead Created Date Time '+lead.createdDate ;
                lead = LeadReminderHelper.setLeadReminderTime(lead,usr.TimeZoneSidKey);
                mailString= mailString +'\nNew Date Reminder : 2 :'+lead.Lead_Reminder_Time__c ;
                leadlist.add(lead);

            }
        }
        update leadlist;
     }

}