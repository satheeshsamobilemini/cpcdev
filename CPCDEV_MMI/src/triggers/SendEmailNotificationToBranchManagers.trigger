trigger SendEmailNotificationToBranchManagers on Opportunity (after insert, after update,before update) {
    
    /*If custom setting holds logged in user's ID then trigger will not fire.
    This is done by Reena for 140256 to avoid firing trigger of opportunity during data update of opps.
    If user want to perform data update on Opps but want to avoid firing of trigger then
    Set user's salesforce ID in SkipTrigger custom setting and then perform update.*/    
    
    if(TriggerSwitch.isTriggerExecutionFlagDisabled('Opportunity','SendEmailNotificationToBranchManagers')){ return; }
    
    for(SkipTrigger__c skipTrg : SkipTrigger__c.getAll().values()){
        
        if(skipTrg.name == userinfo.getUserID().subString(0,15)){ return; }
    }
    
    Set<Id> oppIdSet = new Set<Id>();
    Set<String> servicingIdSet = new Set<String>();
    Set<Id> OppUpdateSet = new Set<Id>();                          // MSM 87..
    List<Messaging.SingleEmailMessage> mailList = new List<Messaging.SingleEmailMessage>(); // TFS 6058 - Opportunity   
    
    if(Trigger.isInsert){
        for(Opportunity opp: Trigger.new){
            if(OpportunityManagement.isNSCOwnedOpportunity(opp) && OpportunityManagement.isLostOpportunity(opp,null)){ 
                servicingIdSet.add(opp.Servicing_Branch__c);
                oppIdSet.add(opp.id);
            }
          
           // Sales Restructure - 2015 (TFS 6058 - Opportunity) 
           if(opp.notify_CreatedUser__c == true)
            { mailList.add(OpportunityManagement.sendMailNotificationCreatedUser(opp.Id,opp.CreatedById,opp.CreatedByUserName__c)); 
            }   
        }
    }
    ID oppID;
    
    if(Trigger.isUpdate && Trigger.isBefore){
        
        Boolean isStatusChanged = false;
        for(Opportunity opt: Trigger.new){
            if(opt.Quote_Status_Changed__c){
                isStatusChanged = true;    
                opt.Quote_Status_Changed__c = false;
            }    
        }
        
        if(isStatusChanged) {
        Map<String,Integer> oppOpenMultiQuotes = new Map<String,Integer>();
        Map<String,Integer> oppWonMultiQuotes = new Map<String,Integer>();
        Map<String,Integer> oppLostMultiQuotes = new Map<String,Integer>();
        
        List<AggregateResult> allQuotesForCurOpps = [select Opportunity__c,count(ID) totalQuotes,status__c FROM Quote_header__c where Opportunity__c in:trigger.newMap.keySet() group by opportunity__c,status__c];
        for(AggregateResult oppQuote : allQuotesForCurOpps){
            if(oppQuote.get('status__c') == 'Open')
                oppOpenMultiQuotes.put(String.valueof(oppQuote.get('Opportunity__c')),Integer.valueof(oppQuote.get('totalQuotes')));    
            
            if(oppQuote.get('status__c') == 'Lost')
                oppLostMultiQuotes.put(String.valueof(oppQuote.get('Opportunity__c')),Integer.valueof(oppQuote.get('totalQuotes')));    
        
            if(oppQuote.get('status__c') == 'Won')
                oppWonMultiQuotes.put(String.valueof(oppQuote.get('Opportunity__c')),Integer.valueof(oppQuote.get('totalQuotes')));    
        
        }
        
        /*
        for(AggregateResult oq : [select Opportunity__c,count(ID) totalQuotes FROM Quote_header__c where status__c ='Open' and Opportunity__c in:trigger.newMap.keySet() group by Opportunity__c])
        {
            oppOpenMultiQuotes.put(String.valueof(oq.get('Opportunity__c')),Integer.valueof(oq.get('totalQuotes')));
        }
        
        for(AggregateResult oq : [select Opportunity__c,count(ID) totalQuotes FROM Quote_header__c where status__c ='Won' and Opportunity__c in:trigger.newMap.keySet() group by Opportunity__c])
        {
            oppWonMultiQuotes.put(String.valueof(oq.get('Opportunity__c')),Integer.valueof(oq.get('totalQuotes')));
        }
        
        for(AggregateResult oq : [select Opportunity__c,count(ID) totalQuotes FROM Quote_header__c where status__c ='Lost' and Opportunity__c in:trigger.newMap.keySet() group by Opportunity__c])
        {
            oppLostMultiQuotes.put(String.valueof(oq.get('Opportunity__c')),Integer.valueof(oq.get('totalQuotes')));
        }
        */
        for(Opportunity opp: Trigger.new){
            if(oppLostMultiQuotes.containsKey(opp.ID))
                opp.Lost_Quotes__c = oppLostMultiQuotes.get(opp.ID);
            else
                opp.Lost_Quotes__c = 0;        
            if(oppOpenMultiQuotes.containsKey(opp.ID))
                opp.Open_Quotes__c = oppOpenMultiQuotes.get(opp.ID);
            else
                opp.Open_Quotes__c = 0;    
            if(oppWonMultiQuotes.containsKey(opp.ID))
                opp.Won_Quotes__c  = oppWonMultiQuotes.get(opp.ID);
            else
                opp.Won_Quotes__c = 0;
            
            if(opp.Open_Quotes__c > 0)
                opp.StageName = 'Quoted - No Decision';
            else if(opp.Won_Quotes__c > 0)   opp.StageName='Quoted - Won';
            else if(opp.Lost_Quotes__c > 0)  opp.StageName='Quoted - Lost Business';
         }
        }
    }
    
    if(Trigger.isUpdate && trigger.isAfter){
               
        for(Opportunity opp: Trigger.new){
            oppID = opp.ID;
            OppUpdateSet.add(opp.id);        // MSM 87 ..
            if(OpportunityManagement.isNSCOwnedOpportunity(opp) && OpportunityManagement.isLostOpportunity(opp,Trigger.oldMap.get(opp.id))){ 
                servicingIdSet.add(opp.Servicing_Branch__c);
                oppIdSet.add(opp.id);
            }
        }
    }
    // send email Notification branch Manager 
    if(RecursiveTriggerUtility.isSendEMailNotificationToBrnachManagar == false){ 
    if(servicingIdSet.size() > 0)
     {OpportunityManagement.sendEmailNotification(oppIdSet,servicingIdSet); }
    if(test.isRunningTest())
    {
        OppUpdateSet.add(oppID);    
    }
    if(OppUpdateSet.size() > 0)                                   // MSM 87..
     {  
         List<Task> TaskUpdates = new List<Task>();
           
        //List<Opportunity> OppUpdateList = 
        
        for(Opportunity oppUpdatelist :[select Id , Name , Branch__c, Servicing_Branch__c, ownerId, Owner.Name,Account.Name,Transaction_Type__c,Quote_Comments__c,Opportunity_Lost_Category__c,Opportunity_Lost_Reason__c,
                                     (select id,Branch__c,Lead_Rating__c,Subject,Status,ActivityDate,WhatId,Call_Type__c,Job_Profile_Id__c,OwnerId,Owner.Name from Tasks Where Status != 'Completed' order by ActivityDate ASC, LastModifiedDate DESC limit 1000)
                                       from opportunity where id in : OppUpdateSet]) //;
        
                //for(integer i =0;i< oppUpdatelist.size(); i++)
                 {  List<Task> oppTasks = oppUpdatelist.Tasks;
                    for(Task t : oppTasks)
                    {  if(t.OwnerID == oppUpdatelist.OwnerID && oppUpdatelist.Owner.Name <> 'Branch Account' && t.Branch__c <> oppUpdatelist.Branch__c )
                        {  
                            TaskUpdates.add(t);
                              
                        }
                    }
                }
                
        if(TaskUpdates.size() > 0) update TaskUpdates;
                                                     
     }
     
    // Sales Restructure - 2015 (TFS 6058 - Opportunity) 
    if(mailList.size() > 0) { Messaging.sendEmail(mailList); }
               
      RecursiveTriggerUtility.isSendEMailNotificationToBrnachManagar = true;
 }  

}