trigger populateOwnerAndNSCManagers on Opportunity (before insert, before update) {
    /*If custom setting holds logged in user's ID then trigger will not fire.
    This is done by Reena for 140256 to avoid firing trigger of opportunity during data update of opps.
    If user want to perform data update on Opps but want to avoid firing of trigger then
    Set user's salesforce ID in SkipTrigger custom setting and then perform update.*/    
    
   /* for(SkipTrigger__c skipTrg : SkipTrigger__c.getAll().values()){
        if(skipTrg.name == userinfo.getUserID().subString(0,15)){
            return;
        }
    }
    
    List<Id> oppIdList = new List<Id>();
    for(Opportunity opp: Trigger.new){
        oppIdList.add(opp.Id);
    }
    if(oppIdList.size()>0){
         List<Opportunity> oppList = [select Id, Owner.Manager.Id, Owner.Email from Opportunity where Id IN:oppIdList];   
         for(Opportunity opp: oppList){
             for(Opportunity opp2: Trigger.new){
                 if(opp2.Id == opp.Id){
                     if(opp.Owner.Manager.Id !=null){
                         opp2.Owner_Manager__c = opp.Owner.ManagerId;
                    System.debug('Setting lookup fields for :'+opp.Id);
                    System.debug('Owner Manager Email : '+opp.Owner.ManagerId);
                     }
                 }
             }
         }

    }*/
}