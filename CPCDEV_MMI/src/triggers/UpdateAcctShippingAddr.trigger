trigger UpdateAcctShippingAddr on Lead (after update) {
  
  if(TriggerSwitch.isTriggerExecutionFlagDisabled('Lead','UpdateAcctShippingAddr')){ return; }
    List<Lead> convertedLeadsWithDeliveryAddr = New List<Lead>();
    List<ID> AccountIDs = New List<ID>();
    
    for (integer i=0;i<trigger.New.size();i++){
    
        // Only process if Lead.ConvertedAccountID != NULL and it was NULL previously
        if ((trigger.New[i].ConvertedAccountID != NULL) && (trigger.Old[i].ConvertedAccountID == NULL) && (trigger.new[i].Delivery_Postal_Code__c != NULL)){
        
            convertedLeadsWithDeliveryAddr.add(trigger.New[i]); AccountIDs.add(trigger.New[i].ConvertedAccountID);
        
        }
    
    }
    
    if (convertedLeadsWithDeliveryAddr.size() > 0){ UpdateAcctShippingAddr.processConvertedLeads(convertedLeadsWithDeliveryAddr, AccountIDs); }

}