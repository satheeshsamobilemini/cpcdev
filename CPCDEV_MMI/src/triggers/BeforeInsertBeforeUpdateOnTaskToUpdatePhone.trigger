trigger BeforeInsertBeforeUpdateOnTaskToUpdatePhone on Task (before insert, before update) {

  if(TriggerSwitch.isTriggerExecutionFlagDisabled('Task','BeforeInsertBeforeUpdateOnTaskToUpdatePhone')){ return; }  
    list<Id> lstConId = new list<Id>();
    list<Id> lstLeadId = new list<Id>();
    map<Id,Boolean> mapTaskId = new map<Id,Boolean>();                          // TFS-2220
    map<Id,Lead> mapLeadtoUpdate = new map<Id,Lead>();                         // TFS-2220
    list<Contact> lstConPhone = new list<Contact>();
    list<Lead> lstLeadPhone = new list<Lead>();
    for(Task t : trigger.new){
        if(t.WhoId != null && ((String.valueOf(t.WhoId)).subString(0,3) == '003')){
            lstConId.add(t.WhoId);
        }
        if(t.WhoId != null && ((String.valueOf(t.WhoId)).subString(0,3) == '00Q')){
            lstLeadId.add(t.WhoId);
        }
    }
    if(lstConId.size() > 0){
        lstConPhone = [select Id,Phone from Contact where Id in :lstConId and Phone != null];
    }
    if(lstLeadId.size() > 0){
        lstLeadPhone = [select Id,Phone from Lead where Id in :lstLeadId and Phone != null];
    }
    for(Task t : trigger.new){
        if(t.WhoId != null && ((String.valueOf(t.WhoId)).subString(0,3) == '003')){
            for(Contact c : lstConPhone){
                if(c.Id == t.WhoId){
                    t.Who_Id_Phone__c = c.Phone;
                    break;
                }
            }
        }
        if(t.WhoId != null && ((String.valueOf(t.WhoId)).subString(0,3) == '00Q')){
            for(Lead l : lstLeadPhone){
                if(l.Id == t.WhoId){
                    t.Who_Id_Phone__c = l.Phone;
                    break;
                }
            }
        }
    }
 
  // TFS-2220 
  if(trigger.isInsert)
  { for(integer i =0; i<trigger.new.size(); i++)
     {  if(trigger.new[i].WhoId != null && ((String.valueOf(trigger.new[i].WhoId)).subString(0,3) == '00Q') && trigger.new[i].Status == 'Completed')
          mapTaskId.put(trigger.new[i].WhoId,true);  
     }
  }
  
  if(trigger.isUpdate)
  { for(integer i =0; i<trigger.new.size(); i++)
     { if(trigger.new[i].WhoId != null && ((String.valueOf(trigger.new[i].WhoId)).subString(0,3) == '00Q'))
        { if(trigger.old[i].Status <> 'Completed' && trigger.new[i].Status == 'Completed')
            { mapTaskId.put(trigger.new[i].WhoId,true);  } 
          else if(trigger.old[i].Status == 'Completed' && trigger.new[i].Status <> 'Completed') 
            { mapTaskId.put(trigger.new[i].WhoId,false);  }
        }  
     }
  }       
  
  for(Lead l : [select ID,Total_Tasks__c from Lead where ID IN:mapTaskId.keyset()])
  { if(mapTaskId.get(l.Id))
     {  if(mapLeadtoUpdate.containskey(l.Id))
          {  Lead ld = mapLeadtoUpdate.get(l.Id);
             ld.Total_Tasks__c = ld.Total_Tasks__c + 1;
             mapLeadtoUpdate.put(ld.Id,ld);
          }
        else{  if(l.Total_Tasks__c == null)
                { l.Total_Tasks__c = 1;  }
               else if(l.Total_Tasks__c <> null)
                { l.Total_Tasks__c = l.Total_Tasks__c + 1; }    
               mapLeadtoUpdate.put(l.Id,l);
            }
      }
    else{  if(mapLeadtoUpdate.containskey(l.Id))
           { Lead ld = mapLeadtoUpdate.get(l.Id);
             ld.Total_Tasks__c = ld.Total_Tasks__c - 1;
             mapLeadtoUpdate.put(ld.Id,ld);
           }
           else { if(l.Total_Tasks__c <> null)
                  l.Total_Tasks__c = l.Total_Tasks__c - 1;
                  mapLeadtoUpdate.put(l.Id,l);
                } 
       } 
  } 

  if(mapLeadtoUpdate.size() >0)
  { update mapLeadtoUpdate.values();}  
}