trigger copy on MMI_Quotes__c (before insert,after delete){
  set<ID> OppIds = New set<ID>();
  if(trigger.isDelete){
  	 for(MMI_Quotes__c  o : Trigger.old){
	    if(o.Opportunity__c != null){
	      OppIds.add(o.Opportunity__c);
	    }
	  }	
  }else{
  	for(MMI_Quotes__c  o : Trigger.new){
	    if(o.Opportunity__c != null){
	      OppIds.add(o.Opportunity__c);
	    }
	  }
  }
  if(trigger.isDelete){
  		List<Opportunity> lstOpportunity = [Select o.Id, o.Field__c, (Select Id From MMI_Quotes__r) From Opportunity o WHERE id in :OppIds];
	    if(lstOpportunity.size() > 0){
		    for(Opportunity opp : lstOpportunity){
		    	if(opp.MMI_Quotes__r.isEmpty()){
		    		opp.Field__c = '';
		    	}
		    }
		    update lstOpportunity;
	    }
  }else{
  	  List<Opportunity> oppList = [SELECT id,Field__c FROM Opportunity WHERE id in :OppIds];
	  for(integer i = 0 ; i < oppList.size(); i++){
	    oppList[i].Field__c = 'true';
	  }
	  update oppList;
  }
}