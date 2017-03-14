trigger CampaignCustomRollupsL on Lead (after insert, after update, after delete) {
 
 if(TriggerSwitch.isTriggerExecutionFlagDisabled('Lead','CampaignCustomRollupsL')){
    return;
  } 
    if (trigger.isInsert){

        Set<String> keysSet = new Set<String>();
        
        for (Lead newLead : Trigger.new) {
        
        system.debug('----- Lead -------------------'+ newLead);                     // UK Web To Lead
        system.debug('----- Lead.OwnerId ---------------'+ newLead.OwnerId);         // UK Web To Lead 
        
            if (newLead.PPC_Keywords_URL__c != null && newLead.PPC_Keywords_URL__c != '') {
                keysSet.add(newLead.PPC_Keywords_URL__c);
            } else if (newLead.LeadSource != null && newLead.LeadSource != '') {
                keysSet.add(newLead.LeadSource);
            }
        }
        List<Campaign> campaignList = [SELECT Id, Lead_Source__c, PPC_Keywords_URL__c FROM Campaign
                WHERE Status = 'In Progress' AND (Lead_Source__c IN :keysSet OR PPC_Keywords_URL__c IN :keysSet)];
        
        Map<String, ID> keyToCampaignIdMap = new Map<String, ID>();
        
        for (Campaign camp : campaignList) {
            String key = '';
            
            if (camp.PPC_Keywords_URL__c != null && camp.PPC_Keywords_URL__c != '') {
                key = camp.PPC_Keywords_URL__c;
            } else if (camp.Lead_Source__c != null && camp.Lead_Source__c != '') {
                key = camp.Lead_Source__c;
            }
            
            if (key == '' || keyToCampaignIdMap.containsKey(key))
                continue;
            
            keyToCampaignIdMap.put(key, camp.Id);
        }
        
        if (keyToCampaignIdMap.size() == 0)
            return;
        
        List<Lead> listLeads = new List<Lead>();
        List<ID> campaignsIdList = new List<ID>();
        
        for (Lead newLead : Trigger.new) {
            String key = '';
            
            if (newLead.PPC_Keywords_URL__c != null && newLead.PPC_Keywords_URL__c != '') {
                key = newLead.PPC_Keywords_URL__c;
            } else if (newLead.LeadSource != null && newLead.LeadSource != '') {
                key = newLead.LeadSource;
            }
            
            if (key == '' || !(keyToCampaignIdMap.containsKey(key)))
                continue;
            
            listLeads.add(newLead);
            campaignsIdList.add(keyToCampaignIdMap.get(key));
        }
        
        if (listLeads.size() > 0)
            CampaignMemberManager.AddCampaignMembers(listLeads, campaignsIdList);
            
    }
    
    if (trigger.isUpdate){
    
        List <Lead> listLeads = New List <Lead>();
    
        // only process if Status or IsUnread has changed
        for (integer i=0;i<trigger.new.size();i++){
        
            if ( (trigger.new[i].isUnreadByOwner != trigger.old[i].isUnreadByOwner) || (trigger.new[i].Status != trigger.old[i].Status) ){
                listLeads.add(trigger.new[i]);
                system.debug('$$$$$ --> Added Updated Lead');
            }
        
        }
        
        // Do we have any Leads to update in our Campaigns?
        if (listLeads.size() > 0){
            
            CampaignMemberManager.UpdateCampaignMembersLead(listLeads);
            
        }
    
    }   
    
    if (trigger.isDelete){
    
        // Records in CampaignMember are NOT removed when a Lead is deleted
        // This is throwing our metrics off as test leads are being inserted then deleted
    
        List<ID> deletedLeadIds = New List<ID>();
    
        for (integer i=0;i<trigger.old.size();i++){
        
            deletedLeadIds.add(trigger.old[i].Id);
        
        }
        
        CampaignMember[] cm = [Select Id from CampaignMember where LeadID in :deletedLeadIds];
        
        if (cm.size() > 0){
            system.debug('$$$$$ --> Deleting Campaign Member record for deleted lead');
            delete cm;
        }
    
    }       

    /*

    if (trigger.isInsert){

        Set<String> keysSet = new Set<String>();
        
        for (Lead newLead : Trigger.new) {
            if (newLead.PPC_Keywords_URL__c != null && newLead.PPC_Keywords_URL__c != '') {
                keysSet.add(newLead.PPC_Keywords_URL__c);
            } else if (newLead.LeadSource != null && newLead.LeadSource != '') {
                keysSet.add(newLead.LeadSource);
            }
        }
        
        List<Campaign> campaignList = [SELECT Id, Lead_Source__c, PPC_Keywords_URL__c FROM Campaign
                WHERE Status = 'In Progress' AND (Lead_Source__c IN :keysSet OR PPC_Keywords_URL__c IN :keysSet)];
        
        Map<String, ID> keyToCampaignIdMap = new Map<String, ID>();
        
        for (Campaign camp : campaignList) {
            String key = '';
            
            if (camp.PPC_Keywords_URL__c != null && camp.PPC_Keywords_URL__c != '') {
                key = camp.PPC_Keywords_URL__c;
            } else if (camp.Lead_Source__c != null && camp.Lead_Source__c != '') {
                key = camp.Lead_Source__c;
            }
            
            if (key == '' || keyToCampaignIdMap.containsKey(key))
                continue;
            
            keyToCampaignIdMap.put(key, camp.Id);
        }
        
        if (keyToCampaignIdMap.size() == 0)
            return;
        
        List<ID> leadsIdList = new List<ID>();
        List<ID> campaignsIdList = new List<ID>();
        
        for (Lead newLead : Trigger.new) {
            String key = '';
            
            if (newLead.PPC_Keywords_URL__c != null && newLead.PPC_Keywords_URL__c != '') {
                key = newLead.PPC_Keywords_URL__c;
            } else if (newLead.LeadSource != null && newLead.LeadSource != '') {
                key = newLead.LeadSource;
            }
            
            if (key == '' || !(keyToCampaignIdMap.containsKey(key)))
                continue;
            
            leadsIdList.add(newLead.Id);
            campaignsIdList.add(keyToCampaignIdMap.get(key));
        }
        
        if (leadsIdList.size() > 0)
            CampaignMemberManager.AddCampaignMembers(leadsIdList, campaignsIdList);
            
    }
    
    if (trigger.isUpdate){
    
        List <Lead> listLeads = New List <Lead>();
    
        // only process if Status or IsUnread has changed
        for (integer i=0;i<trigger.new.size();i++){
        
            if ( (trigger.new[i].isUnreadByOwner != trigger.old[i].isUnreadByOwner) || (trigger.new[i].Status != trigger.old[i].Status) ){
                listLeads.add(trigger.new[i]);
                system.debug('$$$$$ --> Added Updated Lead');
            }
        
        }
        
        // Do we have any Leads to update in our Campaigns?
        if (listLeads.size() > 0){
            
            CampaignMemberManager.UpdateCampaignMembers(listLeads);
            
        }
    
    }
    
    if (trigger.isDelete){
    
        // Records in CampaignMember are NOT removed when a Lead is deleted
        // This is throwing our metrics off as test leads are being inserted then deleted
    
        List<ID> deletedLeadIds = New List<ID>();
    
        for (integer i=0;i<trigger.old.size();i++){
        
            deletedLeadIds.add(trigger.old[i].Id);
        
        }
        
        CampaignMember[] cm = [Select Id from CampaignMember where LeadID in :deletedLeadIds];
        
        if (cm.size() > 0){
            system.debug('$$$$$ --> Deleting Campaign Member record for deleted lead');
            delete cm;
        }
    
    }        
    
    */ 
    
}