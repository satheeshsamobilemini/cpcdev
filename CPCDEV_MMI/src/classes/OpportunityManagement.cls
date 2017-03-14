/********************************************************************************************
Name   : OpportunityManagement
Usage  : used to set branch Manager in opportunity
Author : Appirio Offshore (Megha)
Date   : Jan 28,2011
********************************************************************************************/

public class OpportunityManagement {
    
    public static Boolean isTest = false;
    
    /* This method send the email notification to all branch Manager when a NSC owned opportunity is lost. */
    public static void sendEmailNotification(Set<Id> oppIdSet, Set<String> servicingIdSet){
        //load users
        Map<String,List<User>> allUsers = loadAllUsers(servicingIdSet);
        Id templateId;
        try{
            List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
            Messaging.SingleEmailMessage mail;
            // check if user exist with the servicing branch and opportunity is owned by NSC then set Branch Manager field of opportunity.
            for(Opportunity opp : [select Id , Name , Branch__c, Servicing_Branch__c, ownerId, Owner.Name,Account.Name,Transaction_Type__c,Quote_Comments__c,Opportunity_Lost_Category__c,Opportunity_Lost_Reason__c from opportunity where id in : oppIdSet]){
                if(isNSCOwnedOpportunity(opp) && opp.Servicing_Branch__c != null && allUsers.containsKey(opp.Servicing_Branch__c)){
                    for(User user : allUsers.get(opp.Servicing_Branch__c)){
                         mail = new Messaging.SingleEmailMessage();
                         mail.setToAddresses(new String [] {user.Email});
                         //mail.setToAddresses(new String [] {'megh.agar@gmail.com'});
                         mail.setSubject('Lost Opportunity Notification');
                         mail.setPlainTextBody(loadBody(opp));
                         mail.setSaveAsActivity(false);
                         emails.add(mail);   
                    }
                }
            }
            Messaging.sendEmail(emails);
            
        }catch(Exception ex){
            System.debug('---Exception--'+ex.getMessage());
        }
        
    }
    /* load branch Managers and NSC owners */
    public static Map<String,List<User>> loadAllUsers(Set<String> servicingIdSet){
        Map<String,List<User>> userMap = new Map<String,List<User>>();
        String UserQuery = 'Select u.Id, u.Email, u.Name, u.UserRole.Name,u.Branch_Id__c,u.Branch__c, isActive From User u'
                        + ' Where (u.UserRole.Name like \'Branch Manager%\' and Branch_Id__c in : servicingIdSet) and isActive = true order by Branch_Id__c ASC';
        
        if (isTest == true)
           UserQuery += ' limit 10'; 
        System.debug('---query String---'+UserQuery);
        for(User user : Database.query(UserQuery)){
            if(user.UserRole.Name.startsWith('Branch Manager')){
                if(user.Branch_Id__c != null && servicingIdSet.contains(user.Branch_Id__c)){
                    if(!userMap.containsKey(user.Branch_Id__c)){
                        List<User> users = new List<User>();
                        users.add(user);
                        userMap.put(user.Branch_ID__c , users);
                    }else{
                        userMap.get(user.Branch_ID__c).add(user);
                    }
                }               
            }
       }
       system.debug('--User Map--'+userMap);
       return userMap;  
    }
    
    /* This method is checked opportunity is a lost or not*/
    public static Boolean isLostOpportunity(Opportunity newOpp, Opportunity oldOpp){
        Boolean isLost = false;
        if(newOpp.Opportunity_Lost_Category__c != null && ((newOpp.Opportunity_Lost_Category__c.equals('Price') || newOpp.Opportunity_Lost_Category__c.equals('Product')) || (newOpp.Opportunity_Lost_Reason__c != null && newOpp.Opportunity_Lost_Reason__c.contains('Delivery - Could Not Meet Timing') && newOpp.Opportunity_Lost_Category__c.equals('Service')))){
            isLost = true;
        }
        if(oldOpp != null && oldOpp.Opportunity_Lost_Category__c != null && ((oldOpp.Opportunity_Lost_Category__c.equals('Price') || oldOpp.Opportunity_Lost_Category__c.equals('Product')) || (oldOpp.Opportunity_Lost_Reason__c != null && oldOpp.Opportunity_Lost_Reason__c.contains('Delivery - Could Not Meet Timing') && oldOpp.Opportunity_Lost_Category__c.equals('Service')))){
            isLost = false;
        }
        return isLost;
    }
    
    /* This method is checked  NSC owned opportunity */
    public static Boolean isNSCOwnedOpportunity(Opportunity newOpp){
        Boolean isNSCOwned = false;
        if(newOpp.Branch__c != null && (newOpp.Branch__c.equals('298')|| newOpp.Branch__c.equals('777'))){
            isNSCOwned = true;
        }
        return isNSCOwned;
    }
    /* This method used to generate email body */
    public static String loadBody(Opportunity opp){
        String body = '';
        body += 'Click the following link to view this Opportunity in Salesforce:\n';
        body += System.Label.Organization_URL+opp.id+'\n\n';
        body += 'Opportunity Details'+'\n';
        body += '-----------------------------------------------------------------------\n';
        body += 'Opportunity Owner Name: '+opp.Owner.Name+'\n';
        body += 'Account Name: '+ opp.Account.Name+'\n';
        body += 'Opportunity Name: '+opp.Name+'\n';
        
        body += opp.Transaction_Type__c != null ? 'Transaction Type: '+ opp.Transaction_Type__c+'\n': '';
        body += opp.Quote_Comments__c != null ? 'Quote Comments: '+opp.Quote_Comments__c+'\n': '';
        body += 'Opportunity Lost Category: '+ opp.Opportunity_Lost_Category__c+'\n';
        body += opp.Opportunity_Lost_Reason__c != null ? 'Opportunity Lost Reason(s): '+ opp.Opportunity_Lost_Reason__c+'\n': '';
        return body;
    }
    
    public static void updateServicingBranchId(Set<Id> accountIds, List<Opportunity> opportunities){
        Map<Id,Account> accountMap = new Map<Id,Account>([select Id, servicing_Branch_Id__c from Account where id in : accountIds]);
        for(Opportunity opp : opportunities){
            if(accountMap.containsKey(opp.accountId) &&  accountMap.get(opp.accountId).servicing_Branch_id__c != NULL ){
                opp.Servicing_Branch__c = accountMap.get(opp.accountId).servicing_Branch_id__c; 
            }
        }
    }
   
    // Sales Restructure - 2015 (TFS 6058 - Opportunity)
      public static Messaging.singleEmailMessage sendMailNotificationCreatedUser(Id oppId,Id usrId, String usrname){
        String subj = 'Created Opportunity not related to open Job Profile';
        String body = 'Hi ' + usrname + ',<br/><br/></n>You created an opportunity on an account that has open job profiles, but did not relate the opportunity to a job profile.</n></n> Please review the opportunity and link it to a job profile if required. <br/><br/></n></n>Link :  <a href="'+URL.getSalesforceBaseurl().toExternalForm()+'/'+oppId+'">' + URL.getSalesforceBaseurl().toExternalForm() + '/' + oppId +'</a>';
        Messaging.singleEmailMessage mail = new Messaging.singleEmailMessage();
        mail.setSaveAsActivity(false);
        mail.setSubject(subj);
        mail.sethtmlBody(body);
        mail.setTargetObjectId(usrId);
         return mail;
      }
}