/*
* (c) 2015 TEKsystems Global Services
*
* Name           : RoutingLogic
* Created Date   : 31 August, 2015 @ 0130
* Created By     : Shankar Rao
* Edited Date    : 8 September, 2016 @ 0455
* Edited By      : Harthi Sundaramurthy
* Purpose        : Handler class to perform owner change and notification operations, webservice methods being 
*                  called from JS detail page button.
* 
*/
global class RoutingLogic{
    
   //Shankar - Assign opportunity to territory specific Sales Rep based on Shipping postal Code.
    webService static String opportunitySendToISRButton(Opportunity opportunityVar){
        Id oppId = opportunityVar.Id;
        List<Opportunity> currentOptyList = new List<Opportunity>();
         List<Opportunity> optyAfterSweepList = new List<Opportunity>();
        currentOptyList.add(opportunityVar);
        String result = '';
        try{
                OpportunitySweepValidation sweepValVar = new OpportunitySweepValidation ();
                sweepValVar.validateOpportunities(currentOptyList);
                optyAfterSweepList = [Select Id,Assignment_Cause__c from Opportunity where id =: oppId];
                result = optyAfterSweepList[0].Assignment_Cause__c ;
                return result;
        } catch(Exception e){
            system.debug('RoutingLogic Excpetion : '+ e.getMessage());
            result = e.getMessage(); return result;
        }
        
    }
    
    //Shankar - Assign Lead to territory specific Sales Rep based on Shipping postal Code.
    webService static String leadSendToISRButton(id leadId){
        Lead currentLead = [SELECT Id, Shipping_Territory__c, Servicing_Branch_Id__c, Delivery_Postal_Code__c,
                                   OwnerId FROM Lead where id=:leadId];
        String result = '';
        try{
            User territoryUser = getNewLeadOwner(currentLead.Shipping_Territory__c, currentLead.Servicing_Branch_Id__c);
            
            if(territoryUser.Id == null){
                result = 'No Sales Rep, Branch Manager, Regional Inside Sales/Outside Sales Manager found for the shipping Zip/Postal code.';
            }
            else{
                List<Task> relatedOpenTasks = getUpdateRequiredRelatedTasks(currentLead.Id, currentLead.OwnerId, territoryUser.Id);
                currentLead.OwnerId = territoryUser.Id;
                Database.DMLOptions option = new Database.DMLOptions(); 
                option.EmailHeader.triggerUserEmail = true;
                Database.update(currentLead, option);
                String userRole = territoryUser.UserRole.Name==null||territoryUser.UserRole.Name==''?'.':' - '+territoryUser.UserRole.Name+'.';
                result = 'Lead successfully assigned to '+territoryUser.Name+userRole;
                if(!relatedOpenTasks.isEmpty()){
                    update relatedOpenTasks;
                    result += '\n\n';
                    result += 'Related open Tasks are also reassigned to the new Owner.';
                }
            }
            return result;
        } catch(Exception e){
            system.debug('RoutingLogic Excpetion : '+ e.getMessage());
            return e.getMessage();
        } 
    }
    
    //Shankar - Assign Account to territory specific Sales Rep based on Billing postal Code.
    webService static String accSendToISRButton(id accountId){
        Account currentAccount = [SELECT Id, BillingPostalCode, BillingCountry, OwnerId FROM Account where id=:accountId];
        String result = '';
        try{
            String convertedZip = AssignmentRules.getConvertedZipCode(currentAccount.BillingPostalCode, currentAccount.BillingCountry);
            User territoryUser = OpportunitySweepMainLogic.getNewAccountOwner(convertedZip);
            
            if(currentAccount.OwnerId == territoryUser.Id){
                result = 'Current Account owner is the only available user for assingment.';    
            }
            else{
                List<Opportunity> oppList = [SELECT Id, Name, Shipping_Territory__c, Servicing_Branch__c, isOpportunitySweep__c, 
                                             is_NSC_Processed__c, Assignment_Cause__c, Account.isSPOC_Account__c, Account.OwnerId, Account.BillingPostalCode, OwnerId, 
                                             Account.BillingCountry FROM Opportunity 
                                                                    WHERE AccountId =:currentAccount.Id
                                                                    AND (StageName LIKE '%Quoted - No Decision%' 
                                                                         OR StageName LIKE '%Not Quoted%') 
                                                                    AND isOpportunitySweep__c = FALSE
                                                                    AND is_NSC_Processed__c = FALSE
                                                                    AND On_The_Go__c = FALSE];    
                if(oppList.isEmpty()){
                    List<Task> relatedOpenTasks = getUpdateRequiredRelatedTasks(currentAccount.Id, 
                                                                                currentAccount.OwnerId, 
                                                                                territoryUser.Id);
                    currentAccount.OwnerId = territoryUser.Id;
                    update currentAccount;
                    String userRole = territoryUser.UserRole.Name==null||territoryUser.UserRole.Name==''?'.':' - '+territoryUser.UserRole.Name+'.';
                    result = 'Account successfully assigned to '+territoryUser.Name+userRole;
                    
                    List<Contact> updateContactList = getUpdateRequiredRelatedContacts(currentAccount.Id, currentAccount.OwnerId);
                    if(!updateContactList.isEmpty()){
                        update updateContactList;
                        result += '\n\n';
                        result += 'Related Contacts are also swept successfully.';
                    }
                    if(!relatedOpenTasks.isEmpty()){
                        update relatedOpenTasks;
                        result += '\n\n';
                        result += 'Related open Tasks are also reassigned to the new Owner.';
                    }
                }
                else{
                    System.debug('Old Account OwnerId: '+currentAccount.OwnerId);
                    List<Task> relatedOpenTasks = getUpdateRequiredRelatedTasks(currentAccount.Id, 
                                                                                currentAccount.OwnerId, 
                                                                                null);
                                                                                
                    List<Opportunity> spocRelatedOppList = new List<Opportunity>();
                    List<Opportunity> nonSpocOppList = new List<Opportunity>();
                     for(Opportunity opp : oppList){
                       if(opp.Account.isSPOC_Account__c)
                         spocRelatedOppList.add(opp);
                       else 
                         nonSpocOppList.add(opp);
                     }
                    //OpportunitySweepMainLogic.processQuotedNoDecisionOpty(oppList);
                     if(spocRelatedOppList.size() > 0)
                       OpportunitySweepMainLogic.processSPOCDSSOpty(spocRelatedOppList);
                     if(nonSpocOppList.size() > 0) 
                      OpportunitySweepMainLogic.processOptySweepLogic(nonSpocOppList);
                      
                    String userRole = territoryUser.UserRole.Name==null||territoryUser.UserRole.Name==''?'.':' - '+territoryUser.UserRole.Name+'.';
                    result = 'Account successfully assigned to '+territoryUser.Name+userRole;
                    
                    currentAccount = [SELECT Id, BillingPostalCode, BillingCountry, OwnerId FROM Account where id=:accountId];
                    System.debug('New Account OwnerId: '+currentAccount.OwnerId);
                    List<Contact> updateContactList = getUpdateRequiredRelatedContacts(currentAccount.Id, currentAccount.OwnerId);
                    if(!updateContactList.isEmpty()){ update updateContactList;  result += '\n\n';
                        result += 'Related Opportunities & Contacts are also swept successfully.';
                    }
                    else{
                        result += '\n\n'; result += 'Related Opportunities are also swept successfully.';    
                    }
                    
                    if(!relatedOpenTasks.isEmpty()){
                        for(INTEGER i=0; i<relatedOpenTasks.size(); i++){
                            relatedOpenTasks[i].OwnerId = currentAccount.OwnerId;  
                        }
                        update relatedOpenTasks;
                        result += '\n\n';
                        result += 'Related open Tasks are also reassigned to the new Owner.';
                    }
                }
            }
            return result;
        } catch(Exception e){
            system.debug('RoutingLogic Excpetion : '+ e.getMessage());
            return e.getMessage();
        } 
    }
    
     //Shankar - Look for the territory specific active user.
    public static Map<String, User> getNewOpportunityOwner(Set<String> delTerritory_BranchCodeSet){
        Map<String, User> delTerritoryUserMap = new Map<String, User>();
        for(String delTerritory_BranchCode : delTerritory_BranchCodeSet){
            String delShippingTerritory = delTerritory_BranchCode.split('_')[0];
            String delBranchCode = delTerritory_BranchCode.split('_')[1];
              String territoryBranchManager = 'Branch Manager%'+delBranchCode+'%';
             String regionalSalesManager = 'Inside Sales/Outside Sales%';
            List<User> territoryUser = new List<User>();
            territoryUser = [SELECT Id, Name, Territory__c, UserRole.Name FROM USER 
                                                     WHERE Territory__c =:delShippingTerritory 
                                                     AND isActive = true 
                                                     And UserRole.Name LIKE 'Sales Rep%'];
            
            
            //If territory Sales rep is not found assign to ISM.
            if(territoryUser.isEmpty()){
                Branch_Lookup__c branchLookup = [SELECT Id, Branch_Code__c, Territory__c, Selling_Region__c,Zip__c FROM Branch_Lookup__c Where Branch_Code__c =: delBranchCode LIMIT 1];
                 regionalSalesManager += branchLookup.Selling_Region__c;
                territoryUser = [SELECT Id, Name, Territory__c, UserRole.Name FROM USER WHERE isActive = true And UserRole.Name LIKE :regionalSalesManager];    
            }
            //If ISM is not found assign to Branch Manager.
            if(territoryUser.isEmpty()){  territoryUser = [SELECT Id, Name, Territory__c, UserRole.Name FROM USER WHERE isActive = true And UserRole.Name LIKE :territoryBranchManager];
            }
            if(territoryUser.isEmpty()){  delTerritoryUserMap.put(delTerritory_BranchCode, new User()); 
            }else{
                delTerritoryUserMap.put(delTerritory_BranchCode, territoryUser[0]);    
            }
        }
        return delTerritoryUserMap;  
    }
    
    //Shankar - Get new lead owner based on the shipping territory or branch code.
    public static User getNewLeadOwner(string delTerritory, string delBranchCode){
        List<User> usrList = new List<User>();
        if(String.isNotBlank(delTerritory)){
            usrList = [SELECT Id, Name, Territory__c, UserRole.Name FROM USER 
                                                                    WHERE Territory__c =:delTerritory
                                                                    AND isActive = true
                                                                    AND UserRole.Name LIKE 'Sales Rep%' LIMIT 1];    
        }
        if(usrList.isEmpty()){
            usrList = [SELECT Id, Name, Territory__c, UserRole.Name FROM USER 
                                                                    WHERE isActive = true
                                                                    AND Branch_Id__c = :delBranchCode 
                                                                    AND UserRole.Name LIKE 'Sales Rep%' LIMIT 1];
            if(usrList.isEmpty()){
                String territoryBranchManager = 'Branch Manager%'+delBranchCode+'%';
                usrList = [SELECT Id, Name, Territory__c, UserRole.Name FROM USER 
                                                                        WHERE isActive = true
                                                                        AND UserRole.Name LIKE :territoryBranchManager LIMIT 1];    
            }
            if(usrList.isEmpty()){
                List<Branch_Lookup__c> branchLookup = [SELECT Id, Branch_Code__c, Territory__c, Selling_Region__c, 
                                                        Zip__c FROM Branch_Lookup__c 
                                                               Where Branch_Code__c =: delBranchCode LIMIT 1];
                if(branchLookup.isEmpty()){
                    throw new MyException('Invalid Branch Code, no branch lookup record not found for code: '+delBranchCode);    
                }
                else{
                    String regionalSalesManager = 'Inside Sales/Outside Sales%'+branchLookup[0].Selling_Region__c;
                    usrList = [SELECT Id, Name, Territory__c, UserRole.Name FROM USER 
                                                                            WHERE isActive = true
                                                                            And UserRole.Name LIKE :regionalSalesManager LIMIT 1];    
                }    
            }
        }
        if(usrList.isEmpty()){  return new User();
        }
        else{
            return usrList[0];
        }
    }
    
    //Shankar - Look for active sales rep for the given territories.
    public static Map<String, User> getOpportunityTerritoryOwner(Set<String> delTerritorySet){
        Map<String, User> delTerritoryUserMap = new Map<String, User>();
        
        for(User territoryUser : [SELECT Id, Name, Email, Territory__c, UserRole.Name FROM USER 
                                                                                      WHERE Territory__c IN :delTerritorySet
                                                                                      AND isActive = true
                                                                                      And UserRole.Name LIKE 'Sales Rep%']){
            delTerritoryUserMap.put(territoryUser.Territory__c, territoryUser);
        }
        return delTerritoryUserMap;
    }
    
    //Shankar - Get all contacts for an Account.
    public static List<Contact> getUpdateRequiredRelatedContacts(Id accId, Id ownerId){
        List<Contact> cntList = new List<Contact>();
        for(Contact cnt:[SELECT Id, OwnerId, AccountId From Contact WHERE AccountId=:accId AND OwnerId <>:ownerId]){  cnt.OwnerId = ownerId; cntList.add(cnt);       
        }
        return cntList;
    }
    
    //Shankar - Ownership change of all realted open tasks
    public static List<Task> getUpdateRequiredRelatedTasks(Id recordId, Id oldOwnerId, Id newOwnerId){
        List<Task> taskList = new List<Task>();
        if(String.isBlank(newOwnerId)){
            taskList = [SELECT Id, WhatId, WhoId, OwnerId FROM Task WHERE (WhatId =:recordId OR WhoId =:recordId) 
                                                                    AND OwnerId =:oldOwnerId 
                                                                    AND IsClosed = FALSE];    
        }
        else{
            for(Task tsk : [SELECT Id, WhatId, WhoId, OwnerId FROM Task WHERE (WhatId =:recordId OR WhoId =:recordId)
                                                                        AND OwnerId =:oldOwnerId 
                                                                        AND IsClosed = FALSE]){
                tsk.OwnerId = newOwnerId;
                taskList.add(tsk);
            }
        }
        return taskList;
    }
}