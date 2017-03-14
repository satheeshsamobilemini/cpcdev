/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 */
@isTest
private class TestLeadReminderController {

    static testMethod void testLeadReminderTime() {
    	
    	LeadReminderHelper leadReminderHepler = new LeadReminderHelper();
    	List<Lead> leadList = new List<Lead>();
    	Set<Id> leadIds = new Set<Id>();
    	Set<Id> ownerIds = new Set<Id>();
    	
    	//Insert Leads
    	
    	Lead lead = new Lead();
    	lead.status = 'Open';
    	lead.FirstName = 'Test';
    	lead.lastName = 'Lead -1';
    	lead.Company = 'MQ';
    	lead.OwnerId = UserInfo.getUserId();
    	leadList.add(lead);
    	
    	Lead lead2 = new Lead();
    	lead2.status = 'Open';
    	lead2.FirstName = 'Test';
    	lead2.lastName = 'Lead -2';
    	lead2.Company = 'MQ';
    	leadList.add(lead2);
    	
    	Lead lead3 = new Lead();
    	lead3.status = 'Open';
    	lead3.FirstName = 'Test';
    	lead3.lastName = 'Lead - 3';
    	lead3.Company = 'MQ';
    	leadList.add(lead3);
    
    	Lead lead4 = new Lead();
    	lead4.status = 'Open';
    	lead4.FirstName = 'Test';
    	lead4.lastName = 'Lead - 4';
    	lead4.Company = 'MQ';
    	leadList.add(lead4);
    	
    	Lead lead5 = new Lead();
    	lead5.status = 'Open';
    	lead5.FirstName = 'Test';
    	lead5.lastName = 'Lead - 5';
    	lead5.Company = 'MQ';
    	leadList.add(lead5);
    	
    	insert leadList;
    	
    	leadIds.add(lead.id);
    	leadIds.add(lead2.id);
    	leadIds.add(lead3.id);
    	leadIds.add(lead4.id);
    	leadIds.add(lead5.id);
    	
    	// get new Lead details
    	List<Lead> newLeadList = [select Id,Name,CreatedDate,LastModifiedDate,OwnerId from lead where id in : leadIds];
    	for(Lead l : newLeadList){
    		//leadIds.add(l.id);
    		ownerIds.add(l.ownerId);
    	}
    	
    	System.debug('Owner Ids  >>'+ownerIds);
    	//get details of lead owner
    	List<User> users = [select Id,Name,TimeZoneSidKey from User where id  in : ownerIds];
    	Map<Id,User> usersMap = new Map<Id,User>();
    	for(User usr : users){
    		usersMap.put(usr.Id,usr);
    	}
    	System.debug('User Map  >>'+usersMap);
        // set lead Reminder Time   
    	for(Lead l : newLeadList){
    		System.Debug('Lead Created Date : >> '+l.CreatedDate + 'OwnerId : >>'+l.ownerId + 'User Map >>> '+usersMap.containsKey(l.ownerId));
    		if(l.CreatedDate!=null && usersMap.containsKey(l.ownerId) && usersMap.get(l.ownerId).TimeZoneSidKey !=null){
    			l = LeadReminderHelper.setLeadReminderTime(l , usersMap.get(l.ownerId).TimeZoneSidKey);
    		}
    	}
    	update newLeadList;
    	
    	for(Lead l : newLeadList){
    		System.Debug('Lead Reminder Time  >> '+l.Lead_Reminder_Time__c+' of  : '+l.Name);
        }
        
        //get logged in user details
        
        User[] loggedInUserLst = [Select Id,Name,TimeZoneSidKey from User where id = : UserInfo.getUserId()];
        User loggedInUser;
        String loggedInUserTimeZone;
        if(loggedInUserLst.size()>0){
        	loggedInUser = loggedInUserLst.get(0);
        }
        
        if(loggedInUser != null){
        	loggedInUserTimeZone = loggedInUser.TimeZoneSidKey;
        }
        
        // set Reminder Time for lead is inserted on 3/1/2010 (Monday) at 4:00 PM
          
        DateTime createdDate  = DateTime.newInstance(2010,03,01,16,0,0);
        DateTime reminderDate = LeadReminderHelper.setReminderTime(createdDate ,loggedInUserTimeZone);
        String reminderDateString = reminderDate.format('yyyy-MM-dd HH:mm:ss',loggedInUserTimeZone);
        System.assertEquals(reminderDateString, '2010-03-01 16:00:00');
        
        //set Reminder Time for lead is inserted on 3/3/2010 (Wednesday) at 7:45 AM 
        createdDate  = DateTime.newInstance(2010,03,03,19,45,0);
        reminderDate = LeadReminderHelper.setReminderTime(createdDate ,loggedInUserTimeZone);
        reminderDateString = reminderDate.format('yyyy-MM-dd HH:mm:ss',loggedInUserTimeZone);
        System.assertEquals(reminderDateString, '2010-03-04 08:00:00');
        
        //set Reminder Time for lead is inserted on 3/4/2010 (Thursday) at 6:15 PM
        createdDate  = DateTime.newInstance(2010,03,04,6,15,0);
        reminderDate = LeadReminderHelper.setReminderTime(createdDate ,loggedInUserTimeZone);
        reminderDateString = reminderDate.format('yyyy-MM-dd HH:mm:ss',loggedInUserTimeZone);
        System.assertEquals(reminderDateString, '2010-03-04 08:00:00');
        
        //set Reminder Time for lead is inserted on 3/5/2010 (Friday) at 8:00 PM 
        createdDate  = DateTime.newInstance(2010,03,05,18,15,0);
        reminderDate = LeadReminderHelper.setReminderTime(createdDate ,loggedInUserTimeZone);
        reminderDateString = reminderDate.format('yyyy-MM-dd HH:mm:ss',loggedInUserTimeZone);
        System.assertEquals(reminderDateString, '2010-03-08 08:00:00');
        
        //set Reminder Time for lead is inserted on 3/6/2010 (Saturday) at 16:00 AM  
        createdDate  = DateTime.newInstance(2010,03,06,16,0,0);
        reminderDate = LeadReminderHelper.setReminderTime(createdDate ,loggedInUserTimeZone);
        reminderDateString = reminderDate.format('yyyy-MM-dd HH:mm:ss',loggedInUserTimeZone);
        System.assertEquals(reminderDateString, '2010-03-08 08:00:00');
        
        //set Reminder Time for lead is inserted on 02/28/2010 (Sunday) at 05:00 AM
        createdDate  = DateTime.newInstance(2010,02,28,5,0,0);
        reminderDate = LeadReminderHelper.setReminderTime(createdDate ,loggedInUserTimeZone);
        reminderDateString = reminderDate.format('yyyy-MM-dd HH:mm:ss',loggedInUserTimeZone);
        System.assertEquals(reminderDateString, '2010-03-01 08:00:00');
      }
 }