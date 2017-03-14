/************************************************************************************************************
* Name          : ActivityManagement
* Created By    : Appirio Offshore(Hemant)
* Created Date  : 16th Jan 2013
* Description   : Management class for Tasks and Events. Called from their triggers.
* Modified On       : 2013/2/15 [Case # 00039472 Added debug logs to track root casue for not updating 1st activity and response time on lead]
                                : 2013/2/22 [Case # 00039472 Added logic to update 1st activity and response time on lead when completed task is linked to lead from other object]
************************************************************************************************************/

public class ActivityManagement {
    
  private static final String SUBJECT_CALL = 'CALL';
  private static final String STATUS_COMPLETED = 'Completed';
  private static final Integer MILLISECONDS_TO_MINUTE = 60000;
  
  /*****************************************************************************************
  This method populates the first activity date time and Lead Response Time whenever the task
  of Call Type is Completed and first activity is null
  *******************************************************************************************/
  public static void setLeadFields(List<Task> taskList, Map<ID, Task> oldActivityMap, Boolean isInsert){ 
    
    Map<Id,Task> leadTaskMap = new Map<Id,Task>();
    
    for(Task task: taskList){
      if(isAcceptanceCriteriaMet(task, oldActivityMap, isInsert)){
        system.debug('***************1- isAcceptanceCriteriaMet ***************' + (Id)task.get('WhoId'));
        system.debug('***************2- task ***************' + task);
        leadTaskMap.put((Id)task.get('WhoId'),task);   
      }
      system.debug('***************3- task isAcceptanceCriteriaMet NOT met for Task = ***************' + isAcceptanceCriteriaMet(task, oldActivityMap, isInsert));
    }
    
    system.debug('***************4- leadTaskMap size ***************' + leadTaskMap.size());
    system.debug('***************5- leadTaskMap ***************' + leadTaskMap);
    if(leadTaskMap.size() > 0){
      List<Lead> leadsToUpdate = new List<Lead>();
      
      //Case # 00039928 [adding check for isconverted to avoid lead update if lead is converted]
      //Map<Id,Lead> leadMap = new Map<Id,Lead>([select id, CreatedDate, First_Activity_DateTime__c from Lead where Id IN: leadTaskMap.keySet() AND First_Activity_DateTime__c = null]);
      Map<Id,Lead> leadMap = new Map<Id,Lead>([select id, CreatedDate, First_Activity_DateTime__c,Branch__c,leadSource,Country from Lead where Id IN: leadTaskMap.keySet() AND First_Activity_DateTime__c = null AND isConverted = false]);
      
      system.debug('***************6- leadMap size ***************' + leadMap.size());
        system.debug('***************7- leadMap ***************' + leadMap);
      List<BusinessHours> bhList = [SELECT Id FROM BusinessHours WHERE IsDefault=true];
       List<BusinessHours> bh268List = [SELECT Id FROM BusinessHours WHERE name = 'Branch 298'];//Added by Akanksha for story S-143271 
      List<BusinessHours> bhUKList = [SELECT Id FROM BusinessHours WHERE name = 'UK Business Hours'];    // TFS-1310
     
      if(bhList != null && bhList.size() > 0){
        //BusinessHours bh = bhList[0];      
          
          for(Id leadId: leadMap.keyset()){
            
            Lead lead = leadMap.get(leadId);
            DateTime currentTime = System.now();
            lead.First_Activity_DateTime__c = currentTime ;
            system.debug('***************9-lead.Branch__c***************' + lead.Branch__c);
            //Added by Akanksha for story S-143271 
            BusinessHours bh;
            if(lead.Branch__c == '298')
            {
                 bh = bh268List[0];  
            }
            else if(isUKlead(lead))
            {
                 bh = bhUKList[0];  
            }
            else
            {
                 bh = bhList[0];  
            }
             system.debug('***************8- bhList ***************' + bh);
            //End by Akanksha for story S-143271
            Long timeSinceLastStatus = BusinessHours.diff(bh.id, lead.createdDate, currentTime)/MILLISECONDS_TO_MINUTE;
            system.debug('***************10- timeSinceLastStatus ***************' + timeSinceLastStatus);
            lead.Response_Time__c = timeSinceLastStatus;
            leadsToUpdate.add(lead);
            system.debug('***************11- leadToupdate ***************' + lead);
          }   
      }
      system.debug('***************12- leadsToUpdate size ***************' + leadsToUpdate.size());
        system.debug('***************13- leadsToUpdate ***************' + leadsToUpdate);
      if(leadsToUpdate.size() > 0){
        try{
            update leadsToUpdate;
        }catch(Exception e){    
            system.debug('***************14- Exception occurs in lead update .. Error Message = ***************:' + e.getMessage());
        }
      }
    }
  }
  
  //Method to check for lead update criteria
  //case # 0039472 [Added logic to update 1st activity and response time on lead when completed task is linked to lead from other object]
  private static boolean isAcceptanceCriteriaMet(Task task, Map<ID, Task> oldActivityMap, Boolean isInsert){
    system.debug('***************15- IN isAcceptanceCriteriaMet task***************' + task);
    system.debug('***************16- IN isAcceptanceCriteriaMet oldActivityMap***************' + oldActivityMap);
    system.debug('***************17- IN isAcceptanceCriteriaMet isInsert***************' + isInsert);
    if(task.WhoId != null && task.WhoId.getSobjectType() == Lead.getSobjectType() && task.Subject != null 
        && String.valueOf(task.Subject).toUpperCase().startsWith(SUBJECT_CALL) && task.Status != null && task.Status == STATUS_COMPLETED
        && (isInsert || (!isInsert && (oldActivityMap.get(task.Id).Status != STATUS_COMPLETED || oldActivityMap.get(task.Id).WhoId != task.WhoId)))){
            system.debug('***************18- IN isAcceptanceCriteriaMet TRUE***************');
            return true;
    }
    system.debug('***************19- IN isAcceptanceCriteriaMet FALSE***************');
    return false;
  }
  
   //TFS 1310 : Method to check if Lead belongs to UK.. 
   private static Boolean isUKlead(Lead l) {
   
   system.debug('--------- l.LeadSource ------------' + l.LeadSource); 
    if(l.Branch__c <> null && l.Branch__c <> '' && l.LeadSource <> null && l.LeadSource <> '' && l.Country <> null && l.Country <> '' && (l.Branch__c.startswith('7') || l.LeadSource.contains('MMI UK Website') || l.country == 'GB'|| l.country == 'GREAT BRITAIN'|| l.country == 'ENG' || l.country == 'ENGLAND' || l.country == 'UK'|| l.country== 'UNITED KINGDOM'))
     { 
        system.debug('----- isUKlead-------------'); 
        return true;  
     }   
    else 
      return false;
   }
   
  //Added by Reena for story : S-140256
  public static Map<Id, Opportunity> updateNextActivityOnOpportunity(List<Task> tasks ,List<Event> events,  Map<Id, Opportunity> oppsToUpdate){
    //Create a set of Ids of opportunity from task or event.
    Set<ID> opptyIds = new Set<ID>();
    if(tasks != null){
        for(Task tsk : tasks){
             String str = tsk.WhatId;
             if(str != null && str.substring(0,3)== '006'){
                opptyIds.Add(str);
             }
         }
     }
     else{
         for(Event evt : events){
             String str = evt.WhatId;
             if(str != null && str.substring(0,3)== '006'){
                opptyIds.Add(str);
             }
         }
     }
    //Populate Next Activity Date field with the date of the next activity that is in the opportunity.
    if(opptyIds.size() > 0){
        //Get Opportunity with coming Task only.
        List<Opportunity> opportunities = new List<Opportunity>([Select Id, Next_Scheduled_Activity__c,(SELECT id,StartDateTime FROM Events where StartDateTime >=: datetime.Now() order by StartDateTime limit 1), (Select id,ActivityDate from Tasks where IsClosed = False order by ActivityDate asc limit 1) from Opportunity where Id in :opptyIds]);
        oppsToUpdate = doCalculationForNextActivity(opportunities ,oppsToUpdate);
      }
      return oppsToUpdate;
  }
  
    //Added by Reena for story : S-140256  
  public static Map<Id, Opportunity> doCalculationForNextActivity(List<Opportunity> opportunities , Map<Id, Opportunity> oppsToUpdate){  
        //Iterate Opportunities
        for(Opportunity opp : opportunities){            
            Opportunity oppObj;
            if(oppsToUpdate.containsKey(opp.id))
                oppObj = oppsToUpdate.get(opp.id);        
            else
                oppObj = opp;        
            
            Date nextActivitySchedule = null ;
            if(opp.Tasks != null && opp.Tasks.size() > 0){
                if(opp.Events != null && opp.Events.size() > 0){
                    if(opp.Events.get(0).StartDateTime < opp.Tasks.get(0).ActivityDate){
                        nextActivitySchedule = opp.Events.get(0).StartDateTime.date();
                    }
                    else{
                        nextActivitySchedule = opp.Tasks.get(0).ActivityDate;
                    }
                }
                else{
                    nextActivitySchedule = opp.Tasks.get(0).ActivityDate;
                }
            }
            else if(opp.Events != null && opp.Events.size() > 0){
                nextActivitySchedule = opp.Events.get(0).StartDateTime.date();
            }
        
                   
           if(oppObj.Next_Scheduled_Activity__c != nextActivitySchedule ){
                    oppObj.Next_Scheduled_Activity__c = nextActivitySchedule ;
                    oppsToUpdate.put(oppObj.Id ,oppObj);
           }           
        }  
        return oppsToUpdate;
  }
  //End of Reena's chagnes for story : S-140256
  
  // TFS 4849..
  public static void setAccountField(list<Task> newTasklist, map<Id,Task> oldTaskMap, Boolean isInsert)
  { map<Id,Id> mapObjTask = new map<Id,Id>();
    set<Id> objIdset = new set<Id>();
    set<Id> oppset = new set<Id>();
    set<Id> qset = new set<Id>();
    set<Id> conset = new set<Id>();
    list<Account> acclist = new list<Account>();
        
     for(Task t : newTasklist)
      { if(t.WhatId != null  && t.IsClosed && t.Status == 'Completed' && (isInsert || (!isInsert && oldTaskMap.get(t.Id).Status != 'Completed'))){ 
      
         if(t.WhatId.getSobjectType() == Account.getSobjectType() && string.valueOf(t.WhatId).startswith('001'))
           { mapObjTask.put(t.WhatId,t.OwnerId); }
         
         if(t.WhatId.getSobjectType() == Opportunity.getSobjectType() && string.valueOf(t.WhatId).startsWith('006'))  
           { mapObjTask.put(t.WhatId,t.OwnerId); }
         
         if(t.WhatId.getSobjectType() == MMI_Full_Quotes_UK__c.getSobjectType() && !t.Subject.startsWith('Email: Mobile'))  
           {  mapObjTask.put(t.WhatId,t.OwnerId); }
       }
       else if(t.WhoId != null && t.IsClosed && t.Status == 'Completed' && (isInsert || (!isInsert && oldTaskMap.get(t.Id).Status != 'Completed'))){
         if(t.WhoId.getSobjectType() == Contact.getSobjectType() && string.valueOf(t.WhoId).startsWith('003'))
           {  mapObjTask.put(t.WhoId,t.OwnerId); } 
       }    
      }
      
     if(mapObjTask.keyset().size() > 0){
      objIdset.addAll(mapObjTask.keyset());
       for(Id oId : objIdset){
        if(string.valueOf(oId).startsWith('006'))
         oppset.add(oId);
        else if(string.valueOf(oId).startsWith('003'))
         conset.add(oId);
        else if(!string.valueOf(oId).startsWith('001'))
         qset.add(oId);        
      }
      objIdset.clear();
     } 
         
     if(oppset.size() > 0){
      List<Opportunity> oppList = [select Id,AccountId from Opportunity where id =: oppset];
       for(Opportunity op : oppList){
         mapObjTask.put(op.AccountId,mapObjTask.get(op.Id));
         objIdset.add(mapObjTask.remove(op.Id));
       } 
     }
     
     if(qset.size() > 0){
      List<MMI_Full_Quotes_UK__c> qList = [select Id,Account__c from MMI_Full_Quotes_UK__c where id =: qset];
       for(MMI_Full_Quotes_UK__c q : qList){
         mapObjTask.put(q.Account__c,mapObjTask.get(q.Id));
         objIdset.add(mapObjTask.remove(q.Id));
       }
     } 
     
     if(conset.size() > 0){
      List<Contact> conList = [select Id,AccountId from Contact where Id =: conset];
       for(Contact c : conList){
         mapObjTask.put(c.AccountId,mapObjTask.get(c.Id));
         objIdset.add(mapObjTask.remove(c.Id));
       }
     }
            
    if(mapObjTask.keyset().size() > 0){      
     List<Account> aList = [select id,ownerId,Name,owner.Name,RecordTypeId,BillingCountry,Branch__c,Task_Completed_Date__c from Account where id =: mapObjTask.keyset()];
      for(Account acc : aList)
       { if(isUKaccount(acc) && (acc.Owner.Name != 'Branch Account') && (acc.OwnerId == mapObjTask.get(acc.id)))
             {  acc.Task_Completed_Date__c = system.now();
                acclist.add(acc);
             }
       }
    }
              
   if(acclist.size() > 0)
     { update acclist; } 
  }
  
 // TFS 4849.. 
  public static Boolean isUKaccount(Account a)
  { Boolean isUKacc = false;
    List<UKrecordTypes__c> recTypes = UKrecordTypes__c.getAll().values();
     if(recTypes.size() > 0)
     { String accRecTypeId = recTypes[0].RecTypeId__c.split('_')[1];
       if(a.Branch__c <> null && a.Branch__c <> '' && a.BillingCountry <> null && a.BillingCountry <> '' && (a.RecordTypeId == accRecTypeId) && (a.Branch__c.startswith('7') || a.BillingCountry == 'GB'|| a.BillingCountry == 'GREAT BRITAIN'|| a.BillingCountry == 'ENG' || a.BillingCountry == 'ENGLAND' || a.BillingCountry == 'UK'|| a.BillingCountry == 'UNITED KINGDOM'))
       { isUKacc = true; }
     }  
    return isUKacc;  
  } 
}