Public class TriggerSwitch{

    Public static Boolean isTriggerExecutionFlagDisabled(String objectName, String triggerName){
        Boolean objectFlag = false;
        Boolean triggerFlag = false;
        
        for(Trigger_Handler__mdt thr : [select Type__c,Deactivate_Trigger__c,Object_s_Trigger_s__c from Trigger_Handler__mdt]){
            
            if(thr.Type__c == 'All' && thr.Deactivate_Trigger__c)
                return true;
            if(thr.Object_s_Trigger_s__c != '' && thr.Object_s_Trigger_s__c != null){
                if(thr.Type__c == 'Object' && thr.Object_s_Trigger_s__c.containsIgnoreCase(objectName))
                    objectFlag = thr.Deactivate_Trigger__c;
                    
                if(thr.Type__c == 'Trigger' && thr.Object_s_Trigger_s__c.containsIgnoreCase(triggerName))
                    triggerFlag = thr.Deactivate_Trigger__c;   
            }
        }    
        
        if(objectFlag == true || triggerFlag == true)
            return true;
        else    
            return false;
    }

}