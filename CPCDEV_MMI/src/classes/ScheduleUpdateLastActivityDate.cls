/*
Class : ScheduleUpdateLastActivityDate 
Description :  Scheduler and batch class to update all accounts/contacts/opportunity record for lastAcitivityDate
Developed by : Bharti(offshore)
Created Date : July 24, 2012
*/
global class ScheduleUpdateLastActivityDate implements Schedulable,Database.Batchable<SObject>{
	
	    //--------------------------------------------------------------------
	    // Scheduler code
	    //--------------------------------------------------------------------
        global ScheduleUpdateLastActivityDate(){
        	
        }
        
        global void execute(SchedulableContext SC) {
            Database.executeBatch(new ScheduleUpdateLastActivityDate('Account',null));
            Database.executeBatch(new ScheduleUpdateLastActivityDate('Contact',null));
            Database.executeBatch(new ScheduleUpdateLastActivityDate('Opportunity',null));
        }
        
        
	    //--------------------------------------------------------------------
	    // batch code
	    //--------------------------------------------------------------------
	    
        String objectName;
        Set<Id> recordIds;
        
        global ScheduleUpdateLastActivityDate(String objectName,Set<Id> recordIds){
        	this.objectName = objectName;   
        	this.recordIds = recordIds;     	
        }
        
        global Database.QueryLocator start(Database.BatchableContext BC){
        	String soql = 'Select Id , Last_Activity_Datetime__c , (Select Id,CreatedDate From Tasks order by createdDate DESC limit 1) ';
        	
        	if(objectName != 'Account'){
        		soql += ', AccountId ';
        	}
        	soql += ' From ' + objectName ;
        	
        	if(recordIds != null ){
        		soql += ' where id IN : recordIds ';
        	}
        	
            return Database.getQueryLocator(soql);    
        }
        
        global void execute(Database.BatchableContext BC,List<sObject> scope){
        	
        	List<sObject> modifiedObjects = new List<sObject>();
        	Map<Id,DateTime> mapAccountWithLastAcitvityDateTime = new Map<Id,DateTime>();
        	
            for(sObject obj : scope){
            	List<Task> tasks = (List<Task>)obj.getSObjects('Tasks');
            	if(tasks != null && tasks.size() > 0){            		
            		if(objectName == 'Contact'){
	            		modifiedObjects.add(new Contact(Id = obj.Id , Last_Activity_Datetime__c = tasks.get(0).createdDate));
	            	} else{
	            		obj.put('Last_Activity_Datetime__c',tasks.get(0).createdDate);
            			modifiedObjects.add(obj);
	            	}
	            	
	            	if(objectName != 'Account' && obj.get('AccountId') != null){
	            		mapAccountWithLastAcitvityDateTime.put((Id)obj.get('AccountId'),(DateTime)tasks.get(0).createdDate);
	            	}            	
            	}
            }
            
            //this would run only if the batch is not running for account
            if(mapAccountWithLastAcitvityDateTime.size() > 0){
            	List<Account> modifiedAccounts = new List<Account>();
            	for(Account acc : [Select Last_Activity_Datetime__c From Account Where Id IN : mapAccountWithLastAcitvityDateTime.keyset()]){
            		if(acc.Last_Activity_Datetime__c < mapAccountWithLastAcitvityDateTime.get(acc.Id)){
            			acc.Last_Activity_Datetime__c = mapAccountWithLastAcitvityDateTime.get(acc.Id);
            			modifiedAccounts.add(acc);
            		}
            	}
            	update modifiedAccounts;
            }
            
            update modifiedObjects;
        }
        
        global void finish(Database.BatchableContext BC){}
        
        
	    //--------------------------------------------------------------------
	    // test code
	    //--------------------------------------------------------------------
	    @isTest
	    private static void checkSchedulerCode(){
	    	Test.startTest();
	    		ScheduleUpdateLastActivityDate scheduler = new ScheduleUpdateLastActivityDate();
	    		DateTime currentTime = system.now().addSeconds(1);
       			String sch = String.valueOf(currentTime.second() ) + ' ' + String.valueOf(currentTime.minute()+1 ) + ' ' + String.valueOf( currentTime.hour() ) + ' ' + String.valueOf( currentTime.day() ) + ' ' + String.valueOf( currentTime.month() ) + ' ' + '? ' + String.valueOf( currentTime.year() );
	    		system.schedule('test' ,sch,scheduler );
	    	Test.stopTest();	    	
	    }
	    
	    @isTest
	    private static void checkBatchCode(){
	    	//prepare testdata start
	    	Account testAccount = new Account(LastName = 'TestAccount31072012');
	    	insert testAccount;
	    	
	    	Contact testContact;
	    	for(Contact contact : [Select Id From Contact Where AccountId = : testAccount.Id limit 1]){
	    		testContact = contact;
	    	}
	    	
	    	if(testContact == null){
	    		 testContact = new Contact(LastName = 'TestContact31072012', AccountId = testAccount.id);
	    		 insert testContact;
	    	}
	    	
	    	List<Task> tasks = new List<Task>();
	    	tasks.add(new task(WhatId = testAccount.Id));
	    	tasks.add(new task(WhoId = testContact.Id));
	    	insert tasks;
	    	//prepare testdata end
	    	
	    	Test.startTest();
	    		ScheduleUpdateLastActivityDate batchClass = new ScheduleUpdateLastActivityDate('Contact',new Set<Id>{testContact.Id});
	    		Database.executeBatch(batchClass);
	    		
	    		batchClass = new ScheduleUpdateLastActivityDate('Account',new Set<Id>{testAccount.Id});
	    		Database.executeBatch(batchClass);
	    	Test.stopTest();	    	
	    }
        
}