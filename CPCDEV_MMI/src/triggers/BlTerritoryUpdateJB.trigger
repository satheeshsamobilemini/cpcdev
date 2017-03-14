trigger BlTerritoryUpdateJB on Branch_Lookup__c (before update) {
  
  if(TriggerSwitch.isTriggerExecutionFlagDisabled('Branch_Lookup__c','BlTerritoryUpdateJB')){  
   return;
  } 
  
  if(trigger.isUpdate){
   for(integer i=0;i<trigger.new.size(); i++){
   
    if((trigger.new[i].Zip__c == trigger.old[i].Zip__c) && ((trigger.new[i].Branch_Code__c != trigger.old[i].Branch_Code__c) || 
    (trigger.new[i].Territory__c != trigger.old[i].Territory__c) ||(trigger.new[i].Plant_Code__c != trigger.old[i].Plant_Code__c) ||
    (trigger.new[i].Rollup_Plant__c != trigger.old[i].Rollup_Plant__c)))
      trigger.new[i].isPlantBrnchTerrChange__c =true;
   }       
 }
}