/******************************************************************************* 
Trigger                 :   AssociateActivityHistoryToAccount
Created By              :   Appirio Offshore (Megha Agarwal)
Created On              :   June 03,2010   
Description             :   1.)Check to see if there are any open or completed activities associated to the Contact. 
                              If there are, set the What.Id of the Task/Event to the Account ID in Contact.AccountId 
                            2.)Check to see if Contact.Goldmine_Notes__c is not NULL. If it is not NULL, create a new Task  

********************************************************************************/ 
trigger AssociateActivityHistoryToAccount on Contact (before delete) {
    
    Set<String> contactIdSet = new Set<String>();
    Map<String,Contact> goldMineContactMap = new Map<String,Contact>();
    Map<String,String> contactAccountMap = new Map<String,String>();
    List<Task> taskList = new List<Task>();
    List<Event> eventList = new List<Event>();
    for(Contact con : Trigger.old){
        contactIdSet.add(con.Id);
        contactAccountMap.put(con.Id,con.AccountId);    
       /* if(con.Goldmine_Notes__c != null){
            goldMineContactMap.put(con.Id,con);
        }*/
    }
    Map<ID , Contact> contacts = new Map<ID , Contact>();
    /*if(goldMineContactMap.size() > 0)
        contacts = new Map<ID , Contact>([Select id , ownerId  , owner.isActive , AccountID , Account.Owner.IsActive , Account.ownerID from contact where id in : goldMineContactMap.keySet()]);
      */  
    for(Task task : [select Id,whatId,whoId from Task where whoId in : contactIdSet]){
            if(task.whatId == Null){
                task.whatId = contactAccountMap.get(task.whoId);
            }
            task.whoId = null;
            taskList.add(task);
            if(taskList.size()==199){
                update taskList;
                taskList.clear();   
            }    
    }
    if(taskList.size()>0){
        update taskList;
        taskList.clear();
    }
        
    for(Event event : [select Id,whatId,whoId from Event where whoId in : contactIdSet]){
        if(event.whatId == Null){
            event.whatId = contactAccountMap.get(event.whoId);
        }
        event.whoId = null;
        eventList.add(event);
        if(eventList.size()==199){
            update eventList;
            eventList.clear();
        }
    }
    if(eventList.size()>0){
        update eventList;
        eventList.clear();
    }
    Contact tempContact;
    String recordTypeId;
    for(RecordType rt : [select Id,Name from RecordType where sobjectType='Task' and Name='Standard Task' limit 1]){
        recordTypeId = rt.id;
    }
   /* for(String contactId : goldMineContactMap.keySet()){
        tempContact = goldMineContactMap.get(contactId);
        Task newTask = new Task();
        newTask.recordTypeId = recordTypeId;
        newTask.WhatId = tempContact.AccountId;
        newTask.Subject = 'Goldmine Notes';
        newTask.ActivityDate = Date.parse('06/01/2009');
        //Added by Reena Acharya (Appirio Offshore) for ownerID logic for Case # 00035439
        //when contact's owern is inactive then we should assign related account's OwnerID to the task.
        if(contacts.containskey(contactId)){
            if(contacts.get(contactId).owner.isActive){
                newTask.OwnerId = contacts.get(contactId).ownerID;
            }
            else if(contacts.get(contactId).Account.owner.isActive){
                newTask.OwnerId = contacts.get(contactId).Account.ownerID;
            }
        }
        newTask.Description = tempContact.Goldmine_Notes__c;
        newTask.Call_Type__c = 'Goldmine Notes';
        newTask.Call_Result__c = 'Spoke With Customer/Prospect';
        newTask.Status = 'Completed';
        taskList.add(newTask);
        if(taskList.size()==199){ 
            insert taskList;
            taskList.clear();
        }
    }
    if(taskList.size()>0){
        insert taskList;
    }*/
    
    
    
    
}