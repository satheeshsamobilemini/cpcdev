trigger BeforeUpdateAfterInsertOnLeadToSetUnreadByOwner on Lead (before insert, before update) {
  
  if(TriggerSwitch.isTriggerExecutionFlagDisabled('Lead','BeforeUpdateAfterInsertOnLeadToSetUnreadByOwner')){ return; }
       
    //list<Lead> lstLead = new list<Lead>();
    for(Lead l : trigger.new){
        if(trigger.isInsert){
            if(l.IsUnreadByOwner == true){ l.Unread_by_Owner__c = 'Yes'; }
            
            else{
                l.Unread_by_Owner__c = 'No';
                //lstLead.add(l);
            }
        }
        /*if(trigger.isUpdate){
            if(l.IsUnreadByOwner == true){
                l.Unread_by_Owner__c = 'Yes';
            }else{
                l.Unread_by_Owner__c = 'No';
            }
        }*/
    }
    /*if(lstLead.size() > 0){
        update lstLead;
    }*/
  
}