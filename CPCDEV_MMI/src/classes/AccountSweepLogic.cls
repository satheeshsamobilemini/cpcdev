/*************************************************************************
Name        : AccountSweepLogic
Author      : Tek systems 
Date        : 21st May 2014 
Usage       : Class used to Assign Owner for account 
*/

public with sharing class AccountSweepLogic {
  public static Set <String> AccountTerritorySet = new Set<String>();	
  public static Boolean isTest = false;
  public static Map<String,User> ISRusers = new Map<String,User>();
  public static Map<Id,Account> AccountMapUpdate = new Map<Id,Account>(); 
  public static Map<Id,Account> AccountMapTaskUpdate = new Map<Id,Account>();
  private static Map<Id,List<Contact>> ContactsRelatedToAccount = new Map<Id,List<Contact>>();
  private static list<Task> newTasks = new list<Task>();
  private static List<Task> SweepAccountTaskOwner = new List<Task>();
  private static Id TaskDefaultrecordTypeId = Task.SObjectType.getDescribe().getRecordTypeInfosByName().get('Standard Task').getRecordTypeId();
  private static List<Messaging.SingleEmailMessage> notificationEmails = new List<Messaging.SingleEmailMessage>();
  public AccountSweepLogic(){}
  public static void processAccounts(List<Account> accounts)
 { try {  initialize(accounts); 
 	       // sweep accounts based on conditions ..
 	     for(account acc : accounts)
 	      { system.debug('-------------- acc.id ------------------' + acc.id); 
 	      	system.debug('-------------- acc.Territory__c ------------------' + acc.Territory__c);
 	      	if(IsHomeOwnerAndOtherAccounts(acc) || IsUKaccount(acc))
 	            { /* Do Nothing */ }
 	         else if(IsAccountTerritoryNull(acc))
 	                  { SweepAccountCreatedManager(acc);  }
 	              else { SweepAccountISR(acc);    }  
 	   
 	         AccountTaskSweepOwner(acc);
	      }
     } catch(Exception e)
     {  system.debug('------------------------ e--------------------' + e);}    
    
    UpdateInsertChanges();
 }
 
 private static void initialize(List<Account> accounts)
 { Set<String> AccountTerritoryValue = getAccountsTerritory(accounts);
    getISRusers(AccountTerritoryValue);	
 }
 private static Set<String> getAccountsTerritory(List<Account> accounts)
 {
 	// list Territory for Accounts that undergo sweep.. 
 	for(Account acc : accounts)
 	{ if(acc.Territory__c <> NULL && acc.Territory__c <> '' )
 		{ 	AccountTerritorySet.add(acc.Territory__c); } 
 	}
   return AccountTerritorySet ;	
 }
  
  private static void getISRusers(Set<String> AccountTerritoryValue){
    String QueryString = 'select id,IsActive,UserRole.Name,Profile.Name,ManagerId,Name,Available_For_Leads__c,Territory__c from User where UserRole.Name like \'Sales Rep -%\' and IsActive = True and Territory__c IN : AccountTerritoryValue';
 	system.debug('-------------- QueryString -------------------' + QueryString); 
 	 for(User u : Database.query(QueryString)){
 	 	ISRusers.put(u.Territory__c,u);
 	 }	
 	 system.debug('---- ISRusers.size()-----' +  ISRusers.size());
 	 system.debug('---- ISRusers-----' +  ISRusers);	
  }
  
  private static Boolean IsHomeOwnerAndOtherAccounts(Account acct)
  {   
  	if(acct.Industry == '1-Homeowner/Misc. Storage' || acct.Industry == '1.1-Homeowner/Between Homes' || acct.name.containsIgnoreCase('Homeowner')|| acct.name.containsIgnoreCase('Home owner')|| acct.name.containsIgnoreCase('home owner') || acct.name.containsIgnoreCase('residential') || acct.name.containsIgnoreCase('personal')||  acct.name == null  || acct.name.containsIgnoreCase('none') || acct.name.containsIgnoreCase('self') || acct.Account_Exception__c == True || (acct.Temporary_Assignment__c <> NULL && acct.Temporary_Assignment__c <> ''))
       {   
       	system.debug('------------ IsHomeOwnerAndOtherAccounts---------------------');
       	return True;  }
    else
       { return False;  }  
  }
  
  private static Boolean IsUKaccount(Account acct)
  {  Boolean IsUKaccount = false;   
  	 RecordType rctype = [SELECT Id,Name,SobjectType FROM RecordType WHERE SobjectType = 'Account' AND Name = 'Business Account - UK'];
  	 system.debug('---------------- rctype.Name ----------------------' + rctype.Name);
  	if((acct.RecordTypeId == rctype.id) || (acct.Branch__c <> null && acct.Branch__c <> '' && (acct.Branch__c.startswith('7') || acct.Branch__c.startswith('9') || acct.BillingCountry.toUpperCase() == 'UK' || acct.BillingCountry.toUpperCase() == 'UNITED KINGDOM' || acct.BillingCountry.toUpperCase() == 'GB' || acct.BillingCountry.toUpperCase() == 'GREAT BRITAIN' || acct.BillingCountry.toUpperCase() == 'ENG' || acct.BillingCountry.toUpperCase() == 'ENGLAND')))
       {   
       	system.debug('------------ IsUKAccount---------------------');
       	 IsUKaccount = true;
       }
    return IsUKaccount; 
  }

private static Boolean IsAccountTerritoryNull(Account acct){
	if(acct.Territory__c == NUll || acct.Territory__c == '')
	  { 
	  	system.debug('------------ Account Territory NULL ------------------');
	  	return True;  }
	else 
	  {  return False;	}
	}  
	
private static void SweepAccountCreatedManager(Account acct)
{ if(acct.CreatedBy.ManagerId <> NULL && acct.CreatedBy.Manager.isActive == True)
	 {  system.debug('------------- Account Sweep to Created User Manager -----------------');
	 	AccountMapUpdate.put(acct.id,new Account(id=acct.id, OwnerId = acct.CreatedBy.ManagerId,isAccountSweep__c = True));
	    AccountMapTaskUpdate.put(acct.id,new Account(id=acct.id, OwnerId = acct.CreatedBy.ManagerId,isAccountSweep__c = True));
	    createTasks(acct);
	 }   
}

private static void SweepAccountISR(Account acct){
	 if(acct.Territory__c <> NULL && acct.Territory__c <> acct.CreatedBy.Territory__c && (isTest == True ? True : (acct.CreatedBy.UserRole.Name.containsIgnoreCase('Sales Rep'))) ) {
 	    system.debug('----------- ISR Created Account ------------------');
 	 if(ISRusers.size() > 0 && ISRusers.containskey(acct.Territory__c))
 	  {  User u = ISRusers.get(acct.Territory__c);
 	  	 system.debug('---------------- Account Sweep to ISR rep ---------------');
 	     AccountMapUpdate.put(acct.id,new Account(id=acct.id, OwnerId = u.Id,isAccountSweep__c = True));
	     AccountMapTaskUpdate.put(acct.id,new Account(id=acct.id, OwnerId = u.Id,isAccountSweep__c = True));
	     createTasks(acct);   
 	  }
  }     
}	
    
private static void AccountTaskSweepOwner(Account acct){
   if(AccountMapTaskUpdate.size() > 0){ // sweep Task to new Account Owner..
     if(acct.tasks.size() > 0){
    	  	if(AccountMapTaskUpdate.containskey(acct.id)){
    	  	  Account acc = AccountMapTaskUpdate.get(acct.id);	
    		for(Task t : acct.tasks){
    		  if(t.Status <> 'Completed' && t.OwnerId == acct.OwnerId) 
    		 { t.OwnerId = acc.OwnerId;
    		 	SweepAccountTaskOwner.add(t);
    		 }
    		}
    	system.debug('----------- SweepAccountTaskOwner.size() ------------' + SweepAccountTaskOwner.size());	
       }
    }	
  }
}
 
private static void UpdateinsertChanges(){    
   // update accounts and task list and create Tasks..  
	if(newTasks.size() >0)  // Task..
	{ system.debug('------------- Task Insert ------------');
	  insert newTasks;
	}
   
    if(SweepAccountTaskOwner.size() > 0 )
    { system.debug('-------------- Sweep Task Owner ------------');
      update SweepAccountTaskOwner; 
    } 
    
        if(AccountMapUpdate.size() > 0)  // Accounts to Sweep..
    { system.debug('---------- Account Sweep Update-------------');
      update AccountMapUpdate.values();	
      
        for( Contact con : [select id, name ,OwnerId, AccountId, Account.name , Account.OwnerId,Account.Industry from contact where AccountId in : AccountMapUpdate.keyset()] )
        { if(!ContactsRelatedToAccount.containskey(con.AccountId)){
        	  ContactsRelatedToAccount.put(con.AccountId,new  List<Contact>());
           }
           ContactsRelatedToAccount.get(con.AccountId).add(new Contact(id = con.id, OwnerId = con.Account.OwnerId));
        }
    }  
    
    if(ContactsRelatedToAccount.size() > 0){
    	List<Contact> contacts = new List<Contact>();
         for(Id accId : ContactsRelatedToAccount.keyset()){
         	contacts.addAll(ContactsRelatedToAccount.get(accId));
          }
       system.debug('------------ Updates to Account Related Conatct --------------');
       update contacts;   
    }
}    
public static void createTasks(Account acct){
  String mailBody = '';
  Id ownerId;
   if(acct != null){
     // Account acc = new Account();
      // Need to include Test Code into this..
         if(AccountMapUpdate.size() > 0 && AccountMapUpdate.containskey(acct.id))
           {  Account acc = AccountMapUpdate.get(acct.id); 
           	  system.debug('-------------- Account Sweep --------------------');
              Task task1 = new Task();
                 task1.Subject = 'Account Sweep';
                 task1.Call_Type__c = 'OB - Sales/Customer Service';
                 task1.RecordTypeId = TaskDefaultrecordTypeId;
                 task1.WhatId =  acc.Id;   
                 task1.OwnerId = acc.ownerId;
                 task1.priority  =  'Normal';
                 task1.ActivityDate = System.today();                  
                 newTasks.add(task1);
                 mailBody += 'This account is assigned to you. Click the following link to view this Account in Salesforce:\n';
                 mailBody += System.Label.Organization_URL + acc.Id + '\n';
                 ownerId = acc.ownerId;
        } 
   Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
   mail.setTargetObjectId(ownerId);
   mail.setSubject('Record Moved');
   mail.setPlainTextBody(mailBody);      
   mail.setSaveAsActivity(false);  
   notificationEmails.add(mail);               
}    
}
}