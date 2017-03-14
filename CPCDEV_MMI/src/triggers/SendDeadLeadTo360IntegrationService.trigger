/*****************************************************************************
 * Name                 : SendDeadLeadTo360IntegrationService.Trigger
 * Created By           : Bharti Bhandari(Appirio Offshore)
 * Last Modified Date : 6 March, 2012.
 * Description        : Lead Sharing logic (Trigger fire on insert or update for the specific criteria) Used to send the dead lead to 360 Integration service.
 *****************************************************************************/
trigger SendDeadLeadTo360IntegrationService on Lead (after insert, after update) {
  
  if(TriggerSwitch.isTriggerExecutionFlagDisabled('Lead','SendDeadLeadTo360IntegrationService')){
    return;
  }   
    Manage_Triggers__c triggerCustomSetting = Manage_Triggers__c.getValues('SendDeadLeadTo360IntegrationService');
   if(triggerCustomSetting != null){
    if(triggerCustomSetting.Active__c){
        //Set of lead Ids those will be shared
        Set<Id> leadIdsToBeSharedWith360 = new Set<Id>();
        //Iterate for all updated or inserted leads
        for(Lead lead : Trigger.New){
                //if lead pass following criteria ,it's will be shared with 360 
            if(!lead.Self_Storage_Facilities__c && lead.Status != null && lead.Status.equalsIgnoreCase('Dead Lead') 
            && lead.Reason_Lead_Dead__c != null && XMLGeneratorUtility.deadLeadReasons.contains(lead.Reason_Lead_Dead__c.toLowercase())
            && lead.LeadSource != null && XMLGeneratorUtility.leadSources.contains(lead.LeadSource)){
                leadIdsToBeSharedWith360.add(lead.Id);
            }
        }
        //Check that leadIdsToBeSharedWith360 set have at least 1 lead id
        if(leadIdsToBeSharedWith360.size() > 0 && !IntegrationServiceInterfaceHandler.isImportInProgress){
            //future method Call
            IntegrationServiceInterfaceHandler.serviceImport(leadIdsToBeSharedWith360);
        }
    } 
   }  
}