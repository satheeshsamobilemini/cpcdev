trigger CampaignCutomRollupsO on Opportunity (after delete, after insert, after undelete, after update) {
 
 if(TriggerSwitch.isTriggerExecutionFlagDisabled('Opportunity','CampaignCutomRollupsO')){ 
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
    // Check each record and see if it was created from a Lead Conversion
    // A custom field (formula) on Lead copies the value if LeadID
    // This field is mapped to Opportunity.Lead_ID__c and is populated during Lead Conversion
    // Opportunity.Lead_ID__c will only be populated if the Opportunity was created from a Lead

    List <ID> listLeadIds = New List <ID>();
    Map <ID, String> MapLeadIdToOpptyStage = New Map <ID, String>();

    if ( (trigger.isInsert) || (trigger.isUpdate) ){

        // Iterate through our records to see if we have any Oppty created from lead Conversion
        for (integer i=0;i<trigger.New.size();i++){
        
            if (trigger.New[i].Lead_ID__c != NULL){
                if ( (trigger.IsUpdate) &&  trigger.New[i].StageName != trigger.Old[i].StageName){
                    listLeadIds.add(trigger.New[i].Lead_ID__c);
                    MapLeadIdToOpptyStage.put(trigger.New[i].Lead_ID__c, trigger.New[i].StageName);
                }
                else if (trigger.isInsert){
                    listLeadIds.add(trigger.New[i].Lead_ID__c);
                    MapLeadIdToOpptyStage.put(trigger.New[i].Lead_ID__c, trigger.New[i].StageName);
                }
            }
        
        }
        
        // Do we have any Opportunities to update in our Campaigns?
        if (listLeadIds.size() > 0){
            
            CampaignMemberManager.UpdateCampaignMembersOppty(listLeadIds, MapLeadIdToOpptyStage);
            
        }
        
    }
    
    if (trigger.isDelete){

        // Iterate through our records to see if we have any Oppty created from lead Conversion
        for (integer i=0;i<trigger.Old.size();i++){
        
            if (trigger.Old[i].Lead_ID__c != NULL && trigger.Old[i].Lead_ID__c != ''){
        
                listLeadIds.add(trigger.Old[i].Lead_ID__c);
                MapLeadIdToOpptyStage.put(trigger.Old[i].Lead_ID__c, NULL);

            }       
            
        }
                
        // Do we have any Opportunities to update in our Campaigns?
        if (listLeadIds != NULL && listLeadIds.size() > 0){
            
            CampaignMemberManager.UpdateCampaignMembersOppty(listLeadIds, MapLeadIdToOpptyStage);
            
        }
        
    }   

    /*

    List <ID> listRelatedLeads = New List <ID>();

    if ( (trigger.isInsert) || (trigger.isUpdate) ){

        // Iterate through our records to see if we have any Oppty created from lead Conversion
        for (integer i=0;i<trigger.New.size();i++){
        
            if (trigger.New[i].Lead_ID__c != NULL){
                listRelatedLeads.Add(trigger.New[i].Lead_ID__c);
            }
        
        }
        
    }

    if (trigger.isDelete){

        // Iterate through our records to see if we have any Oppty created from lead Conversion
        for (integer i=0;i<trigger.Old.size();i++){
        
            if (trigger.Old[i].Lead_ID__c != NULL){
                listRelatedLeads.Add(trigger.Old[i].Lead_ID__c);
            }
        
        }
        
    }

    // Get a list of Campaign Members that are in our batch of Leads    
    
    List <CampaignMember> cm = [select ID from CampaignMember where LeadID in :listRelatedLeads];
    
    // system.debug('$$$$ --> cm.size() = ' + cm.size());
    
    if (cm.size() != 0){

        update cm;
            
    }   
    
    */
    
}