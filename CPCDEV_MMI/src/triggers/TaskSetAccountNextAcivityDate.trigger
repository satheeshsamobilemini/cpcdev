trigger TaskSetAccountNextAcivityDate on Task (after insert, after update, after delete) {
  
  if(TriggerSwitch.isTriggerExecutionFlagDisabled('Task','TaskSetAccountNextAcivityDate')){ return;  } 
    List <Id> acctIds = New List <Id>();
    List <Id> opptyIds = New List <Id>();

    Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe(); 
    Map<String,String> keyPrefixMap = new Map<String,String>{};
    Set<String> keyPrefixSet = gd.keySet();
    for(String sObj : keyPrefixSet){
        Schema.DescribeSObjectResult r =  gd.get(sObj).getDescribe();
        String tempName = r.getName();
        String tempPrefix = r.getKeyPrefix();
        System.debug('Processing Object['+tempName + '] with Prefix ['+ tempPrefix+']');
        keyPrefixMap.put(tempPrefix,tempName);
    }
    
    if (trigger.IsInsert){
    
        for(Task t: Trigger.new){
            if(t.WhatId!=null){
                String tPrefix = t.WhatId;
                tPrefix = tPrefix.subString(0,3);
                System.debug('Task Id[' + t.id + '] is associated to Object of Type: ' + keyPrefixMap.get(tPrefix));
    
                if (keyPrefixMap.get(tPrefix) == 'Opportunity'){
                    opptyIds.Add(t.WhatId);
                }
                else if(keyPrefixMap.get(tPrefix) == 'Account'){
                    acctIds.Add(t.WhatId);
                }
        
            }   
        }

    }
    
    if (trigger.IsUpdate){

        for(integer i=0;i<trigger.new.size();i++){
            system.debug('$$$$$$ --> accountId ' + trigger.new[i].WhatId);
            if(trigger.new[i].WhatId!=null){
                String tPrefix = trigger.new[i].WhatId;
                tPrefix = tPrefix.subString(0,3);
                System.debug('Task Id[' + trigger.new[i].id + '] is associated to Object of Type: ' + keyPrefixMap.get(tPrefix));
    
                if ( (keyPrefixMap.get(tPrefix) == 'Opportunity') && ((trigger.new[i].Status != trigger.old[i].Status) || (trigger.new[i].WhatId != trigger.old[i].WhatId) || (trigger.new[i].ActivityDate != trigger.old[i].ActivityDate))){
                    opptyIds.Add(trigger.new[i].WhatId);
                    if(trigger.old[i].WhatId != null)
                    opptyIds.Add(trigger.old[i].WhatId);
                }
                else if( (keyPrefixMap.get(tPrefix) == 'Account') && ((trigger.new[i].Status != trigger.old[i].Status) || (trigger.new[i].WhatId != trigger.old[i].WhatId) || (trigger.new[i].ActivityDate != trigger.old[i].ActivityDate))){
                    acctIds.Add(trigger.new[i].WhatId);
                    if(trigger.old[i].WhatId != null)
                        acctIds.Add(trigger.old[i].WhatId);
                }
        
            }   
        }
    
    }
    
    if (trigger.IsDelete){

        for(integer i=0;i<trigger.old.size();i++){
            if(trigger.old[i].WhatId!=null){
                String tPrefix = trigger.old[i].WhatId;
                tPrefix = tPrefix.subString(0,3);
                System.debug('Task Id[' + trigger.old[i].id + '] is associated to Object of Type: ' + keyPrefixMap.get(tPrefix));
    
                if (keyPrefixMap.get(tPrefix) == 'Opportunity' && trigger.old[i].WhatId != null){
                    opptyIds.Add(trigger.old[i].WhatId);
                }
                else if(keyPrefixMap.get(tPrefix) == 'Account' && trigger.old[i].WhatId != null){
                    acctIds.Add(trigger.old[i].WhatId);
                }
        
            }   
        }
    
    }
    
    system.debug('$$$$$$ --> ' + opptyIds);
    system.debug('$$$$$$ --> ' + acctIds);

    // See if we need to process
    if (opptyIds.size() > 0 || acctIds.size() > 0){
        System.debug('$$$$ --> Class called '+acctIds);
        AccountNextActivityDate.GetNextActivityDate(acctIds, opptyIds);
    } 
}