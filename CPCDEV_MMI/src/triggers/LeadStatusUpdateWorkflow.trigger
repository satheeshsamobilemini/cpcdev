trigger LeadStatusUpdateWorkflow on Lead (before insert, before update) {
  
  if(TriggerSwitch.isTriggerExecutionFlagDisabled('Lead','LeadStatusUpdateWorkflow')){ 
    return;
  }   
    if (trigger.isInsert){
    
        
        //for (integer i=0;i<trigger.new.size();i++){
        for(Lead newLead : trigger.new){
            //trigger.New[i].Lead_Status_Workflow__c = trigger.New[i].Status;
            newLead.Lead_Status_Workflow__c = newLead.Status;
            //trigger.New[i].Lead_ID_Opportunity__c = trigger.New[i].Id;
                
        }
        
    }
    
    else if(trigger.isUpdate){
    
        //for (integer i=0;i<trigger.New.size();i++){
        for(Lead newLead : trigger.new){
            newLead.Lead_Status_Workflow__c = newLead.Status;
            newLead.Lead_ID_Opportunity__c = newLead.Id;
            
            /*if (newLead.Status != trigger.Oldmap.get(newLead.Id).Status){
                newLead.Lead_Status_Workflow__c = newLead.Status;
            }*/
            
            
            /*if ( (trigger.Oldmap.get(newLead.Id).Lead_ID_Opportunity__c == '') || ((trigger.Oldmap.get(newLead.Id).Lead_ID_Opportunity__c == NULL)) ){
                newLead.Lead_ID_Opportunity__c = newLead.Id;
            }*/
            
        }

    } 
}