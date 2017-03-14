trigger opportunityClosedWonDateTimeStamp on Opportunity (before insert, before update) {
  
  if(TriggerSwitch.isTriggerExecutionFlagDisabled('Opportunity','opportunityClosedWonDateTimeStamp')){ 
    return;
   }  
  
    /*If custom setting holds logged in user's ID then trigger will not fire.
    This is done by Reena for 140256 to avoid firing trigger of opportunity during data update of opps.
    If user want to perform data update on Opps but want to avoid firing of trigger then
    Set user's salesforce ID in SkipTrigger custom setting and then perform update.*/    
    
    for(SkipTrigger__c skipTrg : SkipTrigger__c.getAll().values()){
        if(skipTrg.name == userinfo.getUserID().subString(0,15)){
            return;
        }
    }
    List<Opportunity> closedWonLostOpportunities = New List<Opportunity>(); 

    if (trigger.isInsert){

        for (integer i=0;i<trigger.new.size();i++){
        
            // Only process if status = Completed
            if ((trigger.new[i].StageName == 'Quoted - Won') || (trigger.new[i].StageName == 'Quoted - Lost Business')){
                // Add the Task to the list 
                closedWonLostOpportunities.add(trigger.new[i]);
            }
        
        }

    }
    
    if (trigger.isUpdate){
    
        for (integer i=0;i<trigger.new.size();i++){
        
            // Only process if Stage changes to Won/Lost and it was not previously
            // AND 
            // there is not a current time stamp
            if ((trigger.old[i].Opportunity_Closed_Date_Time__c == null) && ((trigger.new[i].StageName == 'Quoted - Won') || (trigger.new[i].StageName == 'Quoted - Lost Business'))){
                // Add the Task to the list 
                closedWonLostOpportunities.add(trigger.new[i]);
            }
        
        }

    }
    
    // See if we have any Opportunities to process
    if (closedWonLostOpportunities.Size() > 0){
        opportunityClosedWonDateTimeStamp.timeStampclosedWonLostOpportunities(closedWonLostOpportunities);
    }
  
}