global class LeadMethods {
    /* This method assign account to sales manager and send a mail to sales manager */
    
    webservice static String sendToNSC(String leadId){
        Lead lead;
        String message = '';
        Savepoint savePoint = Database.setSavepoint();
        try{
            for(Lead l : [select Id, OwnerId, Name, Branch__c,Territory__c from lead where id = : leadId limit 1]){
                lead = l;
            }
            
            // MSM 65 ... Send Lead to NSC even if Branch ID is null... 
            if(lead != null && (lead.Branch__c == null || lead.Branch__c == '') && lead.Territory__c <> null && lead.Territory__c <> '')
            { lead.Branch__c = lead.Territory__c.substring(0,3); }
            
            if(lead != null && lead.Branch__c != null){
                lead = loadNewOwnerId(lead);
                if(lead.ownerId != null){
                    if(String.ValueOf(lead.OwnerId).startsWith('005')){
                        SendNotificationMail(lead,lead.ownerId,false); 
                    } 
                    message = 'Lead was successfully sent to NSC';              
                }else{
                    message = 'There is no sales Manager related to lead \'s branch Id';
                }
            
            }
        }catch(Exception ex){
            Database.rollback(savePoint);
            message = 'Lead was not sent to NSC . Due to : '+ex.getMessage();
        }
        System.debug('---Message---'+message);
        return message;
    }
    
    webservice static String sendToBranch(Id leadId){
        Savepoint savePoint = Database.setSavepoint();
        String message = '';
        try{
            Lead lead;
            lead = AssignmentRules.runAssignmentAlgoForLead(leadId,true);
            /*for(Lead l : [select Id, OwnerId, Name, Branch__c from lead where id = : leadId limit 1]){
                lead = l;
            }*/
            if(lead != null && lead.OwnerId != null && String.ValueOf(lead.OwnerId).startsWith('005')){
                SendNotificationMail(lead,lead.OwnerId,false);
            }  
            message = 'Lead was successfully sent to Branch'; 
        }catch(Exception ex){
            Database.rollback(savePoint);
            message = 'Lead was not sent to Branch . Due to : '+ex.getMessage();
        }
        return message;
    }
    
    private static void SendNotificationMail(Lead lead,Id newOwnerId, Boolean isNSC){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setTargetObjectId(newOwnerId);
        //mail.setToAddresses(new String []{'megh.agar@gmail.com'});
        mail.setSubject('Lead Notification');
        mail.setPlainTextBody(loadBody(lead,isNSC));
        mail.setSaveAsActivity(false);
        Messaging.sendEmail(new Messaging.SingleEmailMessage [] {mail});
    }
    public static Lead loadNewOwnerId(lead lead){
        Id ownerId;
        for(Branch_Lookup__c branch : [select Id, Name, zip__c,Country__c, Branch_Code__c,Sales_Manager_ID__c,US_NSC_Sales_Manager_ID__c from Branch_Lookup__c  where Branch_Code__c = : lead.Branch__c and (((country__c = 'UK') AND (Sales_Manager_ID__c != null or Sales_Manager_ID__c != '')) or (Country__c ='US' or Country__c ='USA' or Country__c ='us' or Country__c ='usa' )) limit 1 ]){
            if(branch.Country__c != null && branch.Country__c.equals('UK')){
                lead.ownerId = branch.Sales_Manager_ID__c;
                update lead;
            }else if (branch.Country__c.equals('US') || branch.Country__c.equals('USA') || branch.Country__c.equals('us') || branch.Country__c.equals('usa')){
                lead = AssignmentRules.runAssignmentAlgoForLead(lead.Id,false);
           }
        }
        return lead;
    }
    /* This method used to generate email body */
    public static String loadBody(Lead lead,Boolean isNSC){
        String body = '';
        body += 'This lead is assigned to you. Click the following link to view this lead in Salesforce:\n';
        body += System.Label.Organization_URL+lead.id+'\n';
        /*if(isNSC){
            body += '\nClick the following link to assign this Lead to any of the sales rep :\n';
            body += System.Label.Organization_URL + 'apex/NSCOwnerChange?id='+lead.id+'&recordType=Lead\n';
        }*/
        body += '\nLead Details'+'\n';
        body += '-----------------------------------------------------------------------\n';
        body += 'Lead Name: '+ lead.Name+'\n';
        body += 'Branch Id: '+ lead.Branch__c+'\n';
        return body;
    }
    
    /*Method added to send leads to NSC when lead_category__c field of lead is 
      Storage Containers' or 'Portable Storage Containers'
      T-32716 point#4
    
    
    webservice static string sendLeadsToNSC(list<Lead> leadList){    
        set<String> branchSet = new set<String>();
        for(Lead ld : leadList){
            branchSet.add(ld.branch__c);
        }   
        Map<String , Branch_Lookup__c> branchMap = new Map<String , Branch_Lookup__c>();
        for(Branch_Lookup__c branch : [Select id , Branch_Code__c , Sales_Manager_ID__c , Country__c from Branch_Lookup__c where branch_code__c in :branchSet AND ( ((country__c = 'UK') AND (Sales_Manager_ID__c != null or Sales_Manager_ID__c != '')) or (Country__c ='US') ) ]){
            branchMap.put(branch.Branch_Code__c , branch);
        }
        
        for(Lead l : leadList){
           if(l.Branch__c != null || l.Branch__c != ''){
                if(branchMap.ContainsKey(l.Branch__c) && branchMap.get(l.Branch__c).Country__c == 'UK'){
                    l.ownerId = branchMap.get(l.Branch__c).Sales_Manager_ID__c;                                     
                }else if(branchMap.ContainsKey(l.Branch__c) && branchMap.get(l.Branch__c).Country__c == 'US'){
                    l = AssignmentRules.runAssignmentAlgoForLeadNSC(l,false);
                }
           }
        }                       
        return 'sucess';
    }
    */
   
    
    static testMethod void testSendToNSC() {
        List<User> usrs  = [select Id from User where Branch_Id__c !='298' and isActive =true limit 1];
        Lead newLead=new Lead(FirstName = 'Test First', LastName ='Last ', Street='Street1', postalCode='BT28 1J' ,Country = 'UK',company='Test Company',Status='Open', phone='1234', leadSource ='Hot',Auto_Assign_Lead__c = false);
        if(usrs.size() > 0){
            newLead.OwnerId = usrs.get(0).Id;
        }
        
        insert newLead;
        LeadMethods.sendToNSC(newLead.Id);
        delete newLead;
        
    } 
    
    static testMethod void testSendToBranch() {
        List<User> usrs  = [select Id from User where Branch_Id__c ='298' and isActive =true limit 1];
        Lead newLead=new Lead(FirstName = 'Test First', LastName ='Last ', Street='Street1', postalCode='BT28 1J' ,Country = 'UK',company='Test Company',Status='Open', phone='1234', leadSource ='Hot',Auto_Assign_Lead__c = false);
        if(usrs.size() > 0){
            newLead.OwnerId = usrs.get(0).Id;
        }
        
        insert newLead;
        LeadMethods.sendToBranch(newLead.Id);
        delete newLead;
        
    }
}