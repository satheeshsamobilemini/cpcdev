trigger updateLeadperTotalOpenandClicks on iContactforSF__iContact_Message_Statistic__c (before update) {
 
 Set<ID> LeadIDSet = new Set<ID>();  // to update Lead Territory Owner..
 Set<ID> ClickLeadSetID = new Set<ID>();  // for TotalClicks for Lead Rating..
 List<Lead> UpdatedLeadList = new List<Lead>();
 
 
 if(trigger.isUpdate){
  for(integer i =0;i< trigger.new.size() ; i++){
	  	if(trigger.new[i].iContactforSF__Lead__c <> null ){
		   // To update Lead related to Contact Message Statistic as per TotalOpens field.. 
		   if(trigger.new[i].iContactforSF__Opens__c <> trigger.old[i].iContactforSF__Opens__c && trigger.new[i].iContactforSF__Opens__c > 0)
		    {  LeadIDSet.add(trigger.new[i].iContactforSF__Lead__c);    }
		   
		   // To update Lead related to Contact Message Statistic as per TotalClicks field.. 
		   if(trigger.new[i].iContactforSF__Clicks__c <> trigger.old[i].iContactforSF__Clicks__c && trigger.new[i].iContactforSF__Clicks__c > 0){
		     LeadIDSet.add(trigger.new[i].iContactforSF__Lead__c);
		     ClickLeadSetID.add(trigger.new[i].iContactforSF__Lead__c);
		   }
	   }
  }
}

if(LeadIDSet.size() > 0)
{ 
  Set<String> SetTerritory = new Set<String>(); 
  Map<String,User> mapTerritoryUser = new Map<String,User>();   
    
  List<Lead> LeadsToUpdate = [select Id,OwnerId,Rating,Territory__c from Lead where id =: LeadIDSet and Territory__c <> '' and Territory__c <> null];
  
  for(Lead l : LeadsToUpdate)
  { SetTerritory.add(l.Territory__c);  }
  
  for(User u : [Select id,isActive,Territory__c from User where isActive = True and Territory__c =: SetTerritory])
  { mapTerritoryUser.put(u.Territory__c,u);   }
  
  system.debug('-----mapTerritoryUser-----------'+mapTerritoryUser);
  
  for(integer i = 0;i<LeadsToUpdate.size(); i++)
  {  if(mapTerritoryUser.containskey(LeadsToUpdate[i].Territory__c))
  	{  LeadsToUpdate[i].OwnerId  =  mapTerritoryUser.get(LeadsToUpdate[i].Territory__c).ID;
  		 if(ClickLeadSetID.contains(LeadsToUpdate[i].id))
  		   { LeadsToUpdate[i].Rating = 'Hot (Probably Order)'; }
  	   UpdatedLeadList.add(LeadsToUpdate[i]);	
    }
  }
}

  if(UpdatedLeadList.size() > 0 )
  { update UpdatedLeadList;}
}