/*********************************************************************
/* Name					: BranchSnapShotReminderUtil
/* Created Date	: 
/* Description	: BranchSnapShot Reminder class
/* 
/* Modified Date: 28 Aug, 2013
/* Modified By	: Alka Taneja
/* Case					: 00052304
/* Description	: Branch 145 and 945 managers should not recieve any emails relating to the weekly branch snapshots.
/********************************************************************/
public with sharing class BranchSnapShotReminderUtil {
    
    private static final String REPLY_TO_USER = 'Paul Widner';
    private static final String MANAGER_REMINDER_DAY = 'Tue';
    
    public static void sendMail(List<Weekly_Snapshot_Branch_Report__c> branchSnapShots,DateTime currentTime){
        String replyTo = loadReplyToEmail();
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage mail;
        Map<Id,User> ownerMap = new Map<Id,User>();
        Boolean isManagerReminderDay = false;
        if(currentTime.format('EEE') == MANAGER_REMINDER_DAY){
            ownerMap = loadOwnerDetails(branchSnapShots);
            isManagerReminderDay = true;
        }
        
        // Added for case 00052304 (Alka Taneja)
        //create map for all users having branch id 145 and 945
        Map<id, User> mapBranchUser = new Map<Id,User>([select id, Branch_Id__c from user where Branch_Id__c='145' or Branch_Id__c='945']);
        
        for(Weekly_Snapshot_Branch_Report__c branchShot : branchSnapShots){
        	
        	// Added for case 00052304 (Alka Taneja)
         	// Branch 145 and 945 managers should not recieve any emails relating to the weekly branch snapshots.
        	if(!mapBranchUser.containsKey(branchShot.ownerId)){
        			emails.add(generateMailInstance(branchShot.ownerId,replyTo,branchShot.id));
        			if(isManagerReminderDay && ownerMap.containsKey(branchShot.ownerId) && !mapBranchUser.containsKey(ownerMap.get(branchShot.ownerId).ManagerId)){
        				emails.add(generateMailInstance(ownerMap.get(branchShot.ownerId).ManagerId,replyTo,branchShot.id));
        			}
        	}
        	
        	// Commented for case 00052304 (Alka Taneja) 
	        /*emails.add(generateMailInstance(branchShot.ownerId,replyTo,branchShot.id));
	        if(isManagerReminderDay && ownerMap.containsKey(branchShot.ownerId)){
	            emails.add(generateMailInstance(ownerMap.get(branchShot.ownerId).ManagerId,replyTo,branchShot.id));
	        }*/
        }
        if(emails.size() > 0){
        	Messaging.sendEmail(emails);
       }
    }
    
    private static String loadReplyToEmail(){
        String replyTo;
        for(User usr : [select id, email from User where Name = : REPLY_TO_USER limit 1]){
            replyTo = usr.email;
        }
        return replyTo;
    }
    
    private static Map<Id,User> loadOwnerDetails(List<Weekly_Snapshot_Branch_Report__c> branchSnapShots){
        set<Id> ownerIds = new Set<Id>(); 
        for(Weekly_Snapshot_Branch_Report__c branchShot : branchSnapShots){
           ownerIds.add(branchShot.ownerId);
        }
        Map<Id,User> ownerMap = new Map<Id,User>([select id , ManagerId from User where managerId != null and id = : ownerIds]);
        return ownerMap;
    }
    
    private static Messaging.SingleEmailMessage generateMailInstance(Id userId,String replyTo,Id branchSnapshotId){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String url = System.Label.Organization_URL + branchSnapshotId;
        mail.setHtmlBody('Please update your branch snap shot :  <a href="'+ url + '" > ' + url +  '</a>');
        mail.setSaveAsActivity(false);
        mail.setSubject('Branch Snap Shot Reminder');
        mail.setTargetObjectId(userId); 
        mail.setReplyTo(replyTo);
        mail.setSenderDisplayName(REPLY_TO_USER);
        // mail.setToAddresses(new String[]{'jvelonis@mobilemini.com','megha.agarwal@appirio.com','vidya@appirio.com'});  MSM 89..
        return mail;
    }
}