//*****************************************************************************************
// Name : SafetyAttachmentReminderUtil
// Created By : -
// Created Date : 11/14/2011
// 
// Modified By : Alka Taneja
// Modified Date : 21 May 2013
// Story : S-120107 

// Modified By : Alka Taneja
// Modified Date : 12 Aug 2013
// Story : S-135378 
//*****************************************************************************************/
public class SafetyAttachmentReminderUtil { 
	
	//Nick Sharp 10-23-13 Case00053493 Start
	//private static final String REPLY_TO_USER = 'Don Morrison';
	private static final String REPLY_TO_USER = 'Sean Kriloff';
	//Nick Sharp 10-23-13 Case00053493 End
	private static String BM = 'Branch Manager Safety Inspection';
	private static String RM = 'Regional Manager Safety Inspection';
	public static Map<String, ID> mapRecordType = new Map<String, Id>();
	public static List<Safety_Topic__c> lstBMSafetyTopic = new List<Safety_Topic__c>();
	public static List<Safety_Topic__c> lstRMSafetyTopic = new List<Safety_Topic__c>();
	
	// S-135378, Alka Taneja (12 Aug, 2013)
	public static List<Messaging.SingleEmailMessage> conEmails = new List<Messaging.SingleEmailMessage>();
	
	//=========================================================
	// Method to send mails
	//=========================================================
	public static void sendMail(List<Safety_Topic__c> safetyTopics,Boolean is15DayReminder) {
		
		//load record type id
		for(RecordType rt :  [select id, Name from RecordType where Name =:BM OR Name = :RM ]) {
			mapRecordType.put(rt.Name, rt.Id);
		}
		
		//Set<String> branches = getBranches(safetyTopics);
		Set<String> branchSet = loadBranches();
		Map<String,Set<Id>> userIdMap = loadUserIds(branchSet);
		Set<Id> userIds;
		    
		Map<String,Set<Id>> seniorVPMap = loadSeniorVPs(branchSet);
		String replyTo = loadReplyToEmail();
		
		List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
		Messaging.SingleEmailMessage mail;
		
		Set<String> branchesSet = new Set<String>();
		
		for(safety_Topic__c safetyTopic : safetyTopics) {
			
			// if Safety Topic is of Branch_Manager_Safety_Inspection record type
			if(safetyTopic.RecordTypeId == mapRecordType.get(BM)) {
				lstBMSafetyTopic.add(safetyTopic);
			
			// if Safety Topic is of Regional_Manager_Safety_Inspection record type
			} else if(safetyTopic.RecordTypeId == mapRecordType.get(RM)) {
				lstRMSafetyTopic.add(safetyTopic);
				
			} else {
				
				branchesSet.addAll(userIdMap.keySet());
	    	emails.addAll(generateMailToNotSubmitAttachments(branchesSet, userIdMap, safetyTopic,replyTo));
	    	
	    	if(safetyTopic.No_Attachment_after_15_days__c){
					branchesSet = new Set<String>();
					branchesSet.addAll(userIdMap.keySet());
					emails.addAll(generateMailToNotSubmitAttachments(branchesSet, seniorVPMap, safetyTopic,replyTo));
	    	}
			}
		}
	
		// If Branch_Manager_Safety_Inspection list is not Empty
		if(!lstBMSafetyTopic.isEmpty()) {
			
			//Create branch set for Branch_Manager_Safety_Inspection record type
			Set<String> branchesBM;
			
			for(safety_Topic__c st : lstBMSafetyTopic) {
				
				//get branches for Branch Mangers and Regional Managers (should be manager on Branch Manager’s user profile.)
				branchesBM = new Set<String>();
				branchesBM.addAll(userIdMap.keySet());
				
				// If Safety Topic record has been created before 30 days but not created before 35 days then
				//Reminder goes to Branch Manger and Regional Manager (should be manager on Branch Manager’s user profile.)
		    emails.addAll(generateMailToNotSubmitAttachments(branchesBM, userIdMap, st, replyTo));
				
				// If Safety Topic record has been created before 35 days	
				if(st.No_Attachment_after_30_days__c && st.No_Attachment_after_35_days__c) {
					
					branchesBM = new Set<String>();
					branchesBM.addAll(seniorVPMap.keySet());
					
					//Reminder goes to SVP also
					emails.addAll(generateMailToNotSubmitAttachments(branchesBM, seniorVPMap, st, replyTo));
				}
			}
		}
		
		// If Regional_Manager_Safety_Inspection list is not Empty
		if(!lstRMSafetyTopic.isEmpty()) {
			
			//Create branch set for Regional_Manager_Safety_Inspection record type
			Set<String> branchesRM;
			
			//get Regional Managers
			Map<String,Set<Id>> mapRM = getRM(branchSet);
			
			for(safety_Topic__c st : lstRMSafetyTopic) {
				
				//get branches for Regional Managers 
				branchesRM = new Set<String>();
				branchesRM.addAll(mapRM.keySet());
				
				// If Safety Topic record has been created before 90 days but not created before 95 days then
				// Reminder goes to Regional Manager 
		    emails.addAll(generateMailToNotSubmitAttachments(branchesRM, mapRM, st, replyTo));
				
				// If Safety Topic record has been created before 95 days
				if(st.No_Attachment_after_90_days__c && st.No_Attachment_after_95_days__c) {
					
					branchesRM = new Set<String>();
					branchesRM.addAll(seniorVPMap.keySet());
					
					//Reminder goes to SVP also (should be the manager on the user profile)
					emails.addAll(generateMailToNotSubmitAttachments(branchesRM, seniorVPMap, st, replyTo));
				}
			}
		}
		
		// S-135378, Alka Taneja (12 Aug, 2013)
		conEmails = consolidateEmail(emails);
		if(conEmails.size() > 0){
			Messaging.sendEmail(conEmails);
		}
	}
	
		//=========================================================
		// Method to consolidate Emails for S-135378, Alka Taneja (12 Aug, 2013)
		//=========================================================
		public static List<Messaging.SingleEmailMessage> consolidateEmail(List<Messaging.SingleEmailMessage> emails) {
			
			Map<Id,List<Messaging.SingleEmailMessage>> mapEmails = new Map<Id,List<Messaging.SingleEmailMessage>>();
			
			//Create Map for Target object id vs. List of SingleEmailMessage
			for(Messaging.SingleEmailMessage email : emails) {
				if(mapEmails.containsKey(email.getTargetObjectId())) {
					mapEmails.get(email.getTargetObjectId()).add(email);
				} else {
					mapEmails.put(email.getTargetObjectId(), new List<Messaging.SingleEmailMessage>{email});
				}
			}
			
			// Consolidate List of Emails into Single Email
			for(List<Messaging.SingleEmailMessage> lstEmail : mapEmails.values()) {
				
				//Create Single Email from list of emails for same targetObjectId
				Messaging.SingleEmailMessage singleEmail = new Messaging.SingleEmailMessage();
				singleEmail.setSenderDisplayName(lstEmail[0].getSenderDisplayName());  
				singleEmail.setReplyTo(lstEmail[0].getReplyTo());
				singleEmail.setTargetObjectId(lstEmail[0].getTargetObjectId());
				singleEmail.setSubject(lstEmail[0].getSubject());
				singleEmail.setSaveAsActivity(lstEmail[0].getSaveAsActivity());
				
				//Consolidate message body from list of email to single email
				Integer i = 1;
				String body = 'Please attach the scanned signed copy for below Safety Topics : <br/><br/>';
				for(Messaging.SingleEmailMessage email : lstEmail) {
					body += i++ + ') ';
					body += email.getHtmlBody();
					body += '<br/> <br/>';
				}
				singleEmail.setHtmlBody(body);
				conEmails.add(singleEmail);
			}
			
			return conEmails;
		}

		//=========================================================
		// Method to get Regional Managers
		//=========================================================
		public static Map<String,Set<Id>> getRM(Set<String> branchSet) {
			
				Map<String,Set<Id>> userIdMap = new Map<String,Set<Id>>();
				
				// get list of Branch Managers
				List<User> lstBM = [select Id, Branch_Id__c, ManagerId from User where ( userRole.Name like 'Regional Manager%') and Branch_Id__c in :branchSet and isActive = true];
				
				// create map for the branch id vs. userid 
		  for(User usr : lstBM){
		  	if(!userIdMap.containsKey(usr.Branch_Id__c)){
		    	userIdMap.put(usr.Branch_Id__c , new Set<ID>());
		    }
		    userIdMap.get(usr.Branch_Id__c).add(usr.id);
		   }
		   return userIdMap;
		}
     
    //=========================================================
    // Method to load all the branches from Safety_Attachment__c
    //=========================================================
    public static set<String> loadBranches(){
        set<String> branches = new set<String>();
        Schema.DescribeFieldResult brancheFieldValues = Safety_Attachment__c.Branch__c.getDescribe();
        List<Schema.PicklistEntry> brancheValues = brancheFieldValues.getPicklistValues();
        for(Schema.PicklistEntry branchValue : brancheValues){
         branches.add(branchValue.getValue());
     }   
     return branches; 
    }
    
    //=========================================================
    // Method to get user ids of all BM and RM
    //=========================================================
    public static Map<String,Set<Id>> loadUserIds(Set<String> branchSet){
        Map<String,Set<Id>> userIdMap = new Map<String,Set<Id>>();
        for(User usr : [select Id, Branch_Id__c from User where (( userRole.Name like 'Branch Manager%' or  userRole.Name like 'Regional Manager%') and Branch_Id__c in : branchSet and isActive = true)]){
            if(!userIdMap.containsKey(usr.Branch_Id__c)){
                userIdMap.put(usr.Branch_Id__c , new Set<ID>());
            }
            userIdMap.get(usr.Branch_Id__c).add(usr.id);
        }
        return userIdMap;
    }
    
    //=========================================================
    // Method to load SVPs
    //=========================================================
    public static Map<String,Set<Id>> loadSeniorVPs( Set<String> branchSet){
        Map<String,Set<Id>> userIdMap = new Map<String,Set<Id>>();
        for(User usr : [select Id, Branch_Id__c from User where (( userRole.Name like 'SVP Sales - Western Division US%' or  userRole.Name like 'SVP Sales - Eastern Division US%') and Branch_Id__c in : branchSet  and isActive = true)]){
            if(!userIdMap.containsKey(usr.Branch_Id__c)){
                userIdMap.put(usr.Branch_Id__c , new Set<ID>());
            }
            userIdMap.get(usr.Branch_Id__c).add(usr.id);
        }
        return userIdMap;
    }
    
    //=========================================================
    // Method to get replyTo user
    //=========================================================
    private static String loadReplyToEmail(){
        String replyTo;
        for(User usr : [select id, email from User where Name = : REPLY_TO_USER limit 1]){
            replyTo = usr.email;
        }
        return replyTo;
    }
    
    //=========================================================
    // Method to mail body
    //=========================================================
    private static String generateBody(Safety_Topic__c safetyTopic){
        String body = 'Please attach the scanned signed copy for Safety Topic: '+safetyTopic.Name +'<br/>'+System.Label.Organization_URL +safetyTopic.id;
        return body;
    }
    
    //=========================================================
    // Method to generate mail
    //=========================================================
    private static Messaging.SingleEmailMessage generateSingleMailInstance(Safety_Topic__c safetyTopic,Id usrId,String replyTo){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setHtmlBody(generateBody(safetyTopic));
        mail.setSaveAsActivity(false);
        mail.setSubject('Reminder for attachment on Safety Topic');
        if(usrId != null)
            mail.setTargetObjectId(usrId);
        mail.setReplyTo(replyTo);
        mail.setSenderDisplayName(REPLY_TO_USER);  
        return mail;        
    }
    
    //=========================================================
    // Method to generate mail
    //=========================================================
    private static List<Messaging.SingleEmailMessage> generateMailToNotSubmitAttachments(Set<String> branchesSet,Map<String, Set<Id>> userIdMap, Safety_Topic__c safetyTopic,String replyTo){
    	
    	Set<String> branchesSetForST = branchesSet.clone(); 
    	
			List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
			Messaging.SingleEmailMessage mail;
			for(Safety_Attachment__c sa : safetyTopic.Safety_Attachments__r){
			   if(sa.branch__c != null && branchesSetForST.contains(sa.branch__c)){
			        branchesSetForST.remove(sa.branch__c);
			    }
			}
			
			List<String> lst= new List<String>();
			for(String branch : branchesSetForST){
			    if(userIdMap.containsKey(branch) && userIdMap.get(branch)!= null){
			        for(Id usrId : userIdMap.get(branch)){
			            emails.add(generateSingleMailInstance(safetyTopic , usrId, replyTo));
			        }
			    }
			}
			return emails;
    }
    
        /*private static Set<String> getBranches(List<Safety_Topic__c> safetyTopics){
        Set<String> branches = new Set<String>();
        for(Safety_Topic__c safetyTopic : safetyTopics){
            if(safetyTopic.Branch__c != null){
                branches.add(safetyTopic.Branch__c);
            }
        }
        return branches;
    }*/
    
    /* public static Set<Id> loadUserIds(){
        Set<Id> userRoleIds = new Set<Id>();
        Set<Id> groupIds = new Set<Id>();
        Set<Id> userIds = new Set<Id>();
        String userPrefix = Schema.getGlobalDescribe().get('User').getDescribe().getKeyPrefix();
        String groupPrefix = Schema.getGlobalDescribe().get('Group').getDescribe().getKeyPrefix();
        
        List<GroupMember> groupMembers = [select Id, UserOrGroupId, GroupId from GroupMember where group.Name = : System.Label.Safety_Topic_Submit_Group ];// 'Branch Manager US - 1'];
        for(GroupMember gm : groupMembers){
            if(String.ValueOf(gm.UserOrGroupId).startsWith(groupPrefix)){
                groupIds.add(gm.UserOrGroupId);
            }else if(String.ValueOf(gm.UserOrGroupId).startsWith(userPrefix)){
                userIds.add(gm.UserOrGroupId);
            }
        }
        for(Group grp : [Select g.Type, g.SystemModstamp, g.RelatedId, g.OwnerId, g.Name, g.LastModifiedDate, g.LastModifiedById, g.Id, g.Email, g.DoesSendEmailToMembers, g.DoesIncludeBosses, g.CreatedDate, g.CreatedById From Group g where id in : groupIds]){
            if(grp.RelatedId != null){
                userRoleIds.add(grp.RelatedId);
            }
        }
        Map<Id,User> userMap = new Map<Id,User>([select Id, UserRoleId from User where isActive = true and userRoleId in  : userRoleIds ]);
        userIds.addAll(userMap.keySet());
        return userIds;
    }*/
    
    
}