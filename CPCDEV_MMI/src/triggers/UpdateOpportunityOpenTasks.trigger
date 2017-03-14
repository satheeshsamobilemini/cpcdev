trigger UpdateOpportunityOpenTasks on Task (after delete, after insert, after update) {
  
  if(TriggerSwitch.isTriggerExecutionFlagDisabled('Task','UpdateOpportunityOpenTasks')){ return; }
  
    public set<Id> OpportunityIDs = new Set<Id>();
    public set<Id> OpportunityIDsOld = new Set<Id>();
    public list<Opportunity> OpportunitiesToUpdate = new List<Opportunity>();
    public list<Opportunity> OpportunitiesToNewToUpdate = new List<Opportunity>();
    
    if(trigger.isUpdate){
        if(RecursiveTriggerUtility.isUpdateOpportunityOpenTasks == false){
        for(Task t: Trigger.old){
            system.debug('a1a'+t.whatId);
            if(t.WhatId != null){
                if(string.valueOf(t.WhatId).startsWith('006')){
                    OpportunityIDsOld.add(t.WhatId);
                    System.debug('WhatId = ' + t.WhatId);
                }
            }
        }
        for(Task t: Trigger.new){
            if(t.WhatId != null){
                if(string.valueOf(t.WhatId).startsWith('006')){
                    OpportunityIDs.add(t.WhatId);
                    System.debug('WhatId = ' + t.WhatId);
                }
            }
        }
        
        for(Opportunity l: [Select l.Id, l.CreatedDate, l.Open_Tasks__c,(Select Id From Tasks where IsClosed = False) From Opportunity l where Id in :OpportunityIDs]){
            for(Id opp : OpportunityIDs){
                if(opp == l.Id){
                    if(date.valueOf(l.CreatedDate) > date.newinstance(2012, 02, 08)){
                        OpportunitiesToNewToUpdate.add(new Opportunity(Id=l.Id, Open_Tasks__c = l.Tasks.size()));
                    }
                }
            }
        }
        if(OpportunitiesToNewToUpdate.size() > 0 ){
            update OpportunitiesToNewToUpdate;
        }
        
        for(Opportunity l: [Select l.Id, l.CreatedDate, l.Open_Tasks__c,(Select Id From Tasks where IsClosed = False) From Opportunity l where Id in :OpportunityIDsOld]){
            for(Id opp : OpportunityIDsOld){
                if(opp == l.Id){
                    if(date.valueOf(l.CreatedDate) > date.newinstance(2012, 02, 08)){
                        OpportunitiesToUpdate.add(new Opportunity(Id=l.Id, Open_Tasks__c = l.Tasks.size()));
                    }
                }
            }
        }
        
        if(OpportunitiesToUpdate.size() > 0 ){
            update OpportunitiesToUpdate;
        }  
            RecursiveTriggerUtility.isUpdateOpportunityOpenTasks = true;
        }  
        
    }else{
        if(trigger.isDelete){
            for(Task t: Trigger.old){
                if(t.WhatId != null){
                    if(string.valueOf(t.WhatId).startsWith('006')){
                        OpportunityIDs.add(t.WhatId);
                        System.debug('WhatId = ' + t.WhatId);
                    }
                }
            }
        }else{
            for(Task t: Trigger.new){
                if(t.WhatId != null){
                    if(string.valueOf(t.WhatId).startsWith('006')){
                        OpportunityIDs.add(t.WhatId);
                        System.debug('WhatId = ' + t.WhatId);
                    }
                }
            }
        }
        if(OpportunityIDs.size()>0){
            if(RecursiveTriggerUtility.isUpdateOpportunityOpenTasks == false){
            for(Opportunity l: [Select l.Id, l.CreatedDate,l.Open_Tasks__c, 
                (Select Id From Tasks where IsClosed = False) 
                From Opportunity l where Id in :OpportunityIDs]){
                    for(Id opp : OpportunityIDs){
                        if(opp == l.Id){
                            if(date.valueOf(l.CreatedDate) > date.newinstance(2012, 02, 08)){
                                OpportunitiesToUpdate.add(new Opportunity(Id=l.Id, Open_Tasks__c = l.Tasks.size()));
                            }
                        }
                    }
                }
            }
            if(OpportunitiesToUpdate.size() > 0 ){
                update OpportunitiesToUpdate;
            }     
        }
        RecursiveTriggerUtility.isUpdateOpportunityOpenTasks = true;
    }
 }