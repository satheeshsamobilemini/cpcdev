/*************************************************************************
Name          : OpportunitySweepLogic
Author        : Tek systems (Mitul)
Date          : 10th March 2014 
Usage         : Class used to Assign Owner for opportunity 
Modified By   : Tek Systems (Modified Logic and included sweep for 24 hours) 
Modified Date : 9th September 2014
*/

public with sharing class OpportunitySweepLogic {
  public static map<String,User> mapTerritoryUser = new map<String,User>();
  public static map<String,User> mapSellingRegionUser = new map<String,User>();
  public static map<ID,Opportunity> OpportunityMapforUpdate = new map<ID,Opportunity>();
  public static map<ID,Account> AccountMapforUpdate = new map<ID,Account>();
  public static map<ID,Task> TasksUpdateonSweep = new map<ID,Task>();
  
  private static map<ID,list<Contact>> ContactRelatedAccountMap = new map<ID,list<Contact>>();
  private static List<Task> NewTasks = new List<Task>();
  private static Set<ID> OpportunityAccountSweepISM24hrsset = new Set<ID>();
  private static map<ID,Boolean> OppCheckEmailNotify = new map<ID,Boolean>();                            // TFS 3655
  private static Id TaskDefaultrecordTypeId = Task.SObjectType.getDescribe().getRecordTypeInfosByName().get('Standard Task').getRecordTypeId();
  private static List<Messaging.SingleEmailMessage> notificationEmails = new List<Messaging.SingleEmailMessage>();
  
  private static Boolean isIBrep = false;
  private static Boolean isISRrep = false;
  public static Boolean isRunningTest = false;
  public static Boolean isIBrepTest = false;
  public static Boolean isISRrepTest = false;
  
    public OpportunitySweepLogic(){} 
    public static void processOpportunities(List<Opportunity> OppList,Boolean is24hrsSweep)  
    { try
         { initialize(OppList);
            for(Opportunity opp : OppList)
             {  // Boolean variable declaration..
                Boolean isCreatedOppManagerActive = opp.CreatedBy.ManagerId <> null ? ((opp.CreatedBy.Manager.isActive) ? true : false) : false; 
                Boolean isOpportunityIBCreated = isIBrepTest ? True : (opp.CreatedBy.UserRole.Name.containsIgnoreCase('Inbound Sales Specialist') ? true : false);
                Boolean isOpportunityTerritory = opp.Territory__c <> null ? (opp.Territory__c <> '' ? true : false) : false;
                Boolean isOpportunityBillingZipCode = opp.Billing_Zip_Postal_Code__c <> null ? (opp.Billing_Zip_Postal_Code__c <> '' ? true : false ) : false;
                Boolean isOpportunityISRCreated = isISRrepTest ? True : (opp.CreatedBy.UserRole.Name.containsIgnoreCase('Sales Rep') ? ((opp.CreatedBy.Territory__c != opp.Account.Territory__c) ? true : false ) : false);
                Boolean isOpportunityLost = opp.StageName == 'Quoted - Lost Business' ? true : ((opp.StageName == 'Quoted – Lost') ? true : false);
                
                system.debug('-------- OpID----------'+ opp.Id);
                
                if(isUKopportunity(opp) || isTerritoryNullOpportunity(opp) || isHomeOwnerAccount(opp) || (is24hrsSweep && isAcctExceptionTempAssignment(opp)))
                         { /* Do Nothing .. */}
                else if(isBillingZipTerritoryNullOpportunity(opp) && isCreatedOppManagerActive && is24hrsSweep)
                         {  SweepOpportunityCreatedManager(opp); }
                else if(isOpportunityIBCreated && isOpportunityTerritory && isOpportunityBillingZipCode)
                         {  SweepIBOpportunity(opp,is24hrsSweep); }
                else if(isOpportunityISRCreated && isOpportunityTerritory && isOpportunityBillingZipCode && !isOpportunityLost && is24hrsSweep)
                         { SweepISROpportunity(opp); } 
                           
             }
          SweepExistingTasks(OppList);   
          UpdateChanges();  
        }
      catch(Exception e)
      { system.debug('----------- e ------------------' + e);  }
       
  }
    
 // initialize sets and map..
   private static void initialize(List<Opportunity> olist)
    {
         Set<String> TerritorySet = getTerritory(oList);
         Set<String> SellingRegionSet = getSellingRegion(olist);
         getISRorInboundOutboundManagerUsers(TerritorySet,'ISR');
         getISRorInboundOutboundManagerUsers(SellingRegionSet,'Inbound/Outbound');
    }

 // method to create Set of Territory..    
   private static Set<String> getTerritory(List<Opportunity> opplist)
    {    Set<String> tSet = new Set<String>(); 
          for(Opportunity o : opplist)
          { system.debug('------- isRunningTest --------' + isRunningTest);
            if(o.Account.Territory__c <> null && o.Account.Territory__c <> '')
              { tSet.add(o.Account.Territory__c); }
            else if(isRunningTest)
              {tSet.add(o.Territory__c);}   
          } 
        return tSet;   
    }
    
 // method to create Set of Selling Region..    
   private static Set<String> getSellingRegion(List<Opportunity> opplist)
    {    Set<String> SRset = new Set<String>(); 
          for(Opportunity o : opplist)
          { if(o.StageName == 'Quoted - No Decision' || o.StageName == 'Not Quoted')           // TFS 3655
              { OppCheckEmailNotify.put(o.ID,o.Account.isEmailNotify__c);  }              
            if(o.Selling_Region__c <> null && o.Selling_Region__c <> '')
              { SRset.add(o.Selling_Region__c);       }
          } 
        return SRset;   
    }   
 
 // method to create map of ISR/Inbound or Outbound Sales Manager Region user with their Territory/Selling Region..  
   private static void getISRorInboundOutboundManagerUsers(Set<String> StrngSet, String UserType)
    { if(StrngSet.size() > 0)
       {  String qString = 'select id,IsActive,UserRole.Name,Profile.Name,ManagerId,Manager.isActive,Name,Available_For_Leads__c,Territory__c,Selling_Region__c from User where IsActive = True and'; 
           if(UserType == 'ISR')
            {  qString += ' UserRole.Name like \'Sales Rep -%\' and Territory__c IN : StrngSet';
               system.debug('-------------- UserType ---------------' + qString);
               system.debug('-------------- qString ---------------' + qString);
               for(User u : Database.query(qString))
                { mapTerritoryUser.put(u.Territory__c,u);}  
            }
           else
             { qString += ' UserRole.Name like \'Inside Sales/Outside Sales Manager Region%\' and Selling_Region__c IN : StrngSet';}
               system.debug('-------------- UserType ---------------' + qString);
               system.debug('-------------- qString ---------------' + qString);
                for(User u : Database.query(qString))
                 { mapSellingRegionUser.put(u.Selling_Region__c,u);}
             }
    }
    
 // method to check UK Opportunity ...
   private static Boolean isUKopportunity(Opportunity opp)
    { Boolean IsUKopp = false;   
      List <RecordType> rctypeList = [SELECT Id,Name,SobjectType FROM RecordType WHERE SobjectType = 'Opportunity' AND (Name = 'Government Opportunity - UK' OR Name = 'National Account Opportunity - UK' OR Name = 'Standard Opportunity - UK')];
       for(integer i=0;i<rctypeList.size();i++){
         system.debug('-------- rctypeList[i].Id ------------'+ rctypeList[i].Id); 
        if(opp.RecordTypeId == rctypeList[i].Id || (opp.Branch__c <> null && opp.Branch__c <> '' && (opp.Branch__c.startswith('7') || opp.Billing_Country__c.toUpperCase() == 'UK' || opp.Billing_Country__c.toUpperCase() == 'UNITED KINGDOM' || opp.Billing_Country__c.toUpperCase() == 'GB' || opp.Billing_Country__c.toUpperCase() == 'GREAT BRITAIN' || opp.Billing_Country__c.toUpperCase() == 'ENG' || opp.Billing_Country__c.toUpperCase() == 'ENGLAND')))
         { system.debug('------------ IsUKOpportunity ---------------------');
           IsUKopp = true;
         }
       }  
     return IsUKopp; 
    }
   
 // method to check if opp Territory and Stage ..
   private static Boolean isTerritoryNullOpportunity(Opportunity opp)
    {  if((opp.Territory__c == null || opp.Territory__c == '') && (opp.Billing_Zip_Postal_Code__c  <> null) && (opp.Billing_Zip_Postal_Code__c <> '') && (opp.StageName <> 'Quoted – Lost') && (opp.StageName <> 'Quoted - Lost Business'))
          return true;
       else   
          return false;             
    } 
    
 // method to check Opp Account is HomeOwner Account..
  private static Boolean isHomeOwnerAccount(Opportunity opp)
   {  Boolean IsHomeOwner = false;
       if(!isRunningTest && (opp.Account.industry == '1-Homeowner/Misc. Storage' ||  opp.Account.industry == '1.1-Homeowner/Between Homes' || opp.Account.name == null || opp.Account.name.containsIgnoreCase('Homeowner') || opp.Account.name.containsIgnoreCase('homeowner') || opp.Account.name.containsIgnoreCase('home owner') || opp.Account.name.containsIgnoreCase('Home owner') ||opp.Account.name.containsIgnoreCase('residential') || opp.Account.name.containsIgnoreCase('personal') || opp.Account.name.containsIgnoreCase('none')))
         { isHomeOwner = true;  } 
      return isHomeOwner; 
   } 
   
 // method to check if Account Exception or Temporary Assignment type ..
  private static Boolean isAcctExceptionTempAssignment(Opportunity opp)
   {  if(opp.account.Account_Exception__c == True || (opp.account.Temporary_Assignment__c <> NULL && opp.account.Temporary_Assignment__c <> ''))
         return true;
      else
         return false;   
   }
  
 // method to check if opp Billing ZipCode and Stage.. 
  private static Boolean isBillingZipTerritoryNullOpportunity(Opportunity opp)
   {  if(((opp.Territory__c == null) || (opp.Territory__c == '') || (opp.Billing_Zip_Postal_Code__c  == null) || (opp.Billing_Zip_Postal_Code__c == '')) && ((opp.StageName == 'Quoted - No Decision') || (opp.StageName == 'Quoted - Won') || (opp.StageName == 'Not Quoted')))
         return true;
      else 
         return false;   
   } 
     
 // method to Sweep Opportunity to Created Manager..
  private static void SweepOpportunityCreatedManager(Opportunity opp)
   { sweepUpdateOpportunityAccount(opp.Id,opp.CreatedBy.ManagerId,opp.AccountId,opp.CreatedBy.ManagerId,true,opp); }
   
 // method that sweeps IB Opportunity ..
  private static void SweepIBOpportunity(Opportunity opp,Boolean is24hrsSweep)
   { isIBrep = true;
     Boolean iscreateTask = OppCheckEmailNotify.containskey(opp.ID) ? (OppCheckEmailNotify.get(opp.ID) ? false : true) : true ;    // TFS 3452,3655
      if(opp.StageName == 'Quoted - Won')  // opp no sweep,account sweep to ISR.. 
       { if(mapTerritoryUser.containskey(opp.Account.Territory__c) && (opp.Account.Owner.Name == 'Branch Account' || opp.Account.Owner.UserRole.Name.containsIgnoreCase('Inbound Sales Specialist') || (!is24hrsSweep && !isAcctExceptionTempAssignment(opp)))) 
          { User u = mapTerritoryUser.get(opp.Account.Territory__c);
               if(u.Available_For_Leads__c)
                 { sweepUpdateOpportunityAccount(opp.Id,null,opp.AccountId,u.Id,true,opp);  }           
               else
               {  if(u.ManagerId != null && u.Manager.isActive == True)
                    { sweepUpdateOpportunityAccount(opp.ID,null,opp.AccountId,u.ManagerId,true,opp);  }
                  else
                    {  sweepUpdateOpportunityAccount(opp.ID,null,opp.AccountId,u.Id,true,opp);    } 
               } 
          }
         else if(!mapTerritoryUser.containskey(opp.Account.Territory__c) && mapSellingRegionUser.containskey(opp.Selling_Region__c) && is24hrsSweep)
           { User us = mapSellingRegionUser.get(opp.Selling_Region__c);
             sweepUpdateOpportunityAccount(opp.ID,null,opp.AccountId,us.Id,true,opp);
             OpportunityAccountSweepISM24hrsset.add(opp.AccountId);
           } 
         else if(!is24hrsSweep && isAcctExceptionTempAssignment(opp)) // 1 hr Sweep
         {sweepUpdateOpportunityAccount(opp.Id,null,null,null,true,opp); }     // TFS 3452
       }
    
     else if(opp.StageName == 'Quoted - No Decision' || opp.StageName == 'Not Quoted') // opp and acc sweep to ISR..
           { if(mapTerritoryUser.containskey(opp.Account.Territory__c) && (opp.Account.Owner.Name == 'Branch Account' || opp.Account.Owner.UserRole.Name.containsIgnoreCase('Inbound Sales Specialist') || (!is24hrsSweep && !isAcctExceptionTempAssignment(opp))))
              {  User u = mapTerritoryUser.get(opp.Account.Territory__c);
                  if(u.Available_For_Leads__c)
                     { sweepUpdateOpportunityAccount(opp.Id,u.Id,opp.AccountId,u.Id,iscreateTask,opp);  }
                  else
                   { if(u.ManagerId != null && u.Manager.isActive == True)
                       { sweepUpdateOpportunityAccount(opp.Id,u.ManagerId,opp.AccountId,u.ManagerId,iscreateTask,opp); }
                     else
                       { sweepUpdateOpportunityAccount(opp.Id,u.Id,opp.AccountId,u.Id,iscreateTask,opp);    } 
                   }
               }
              else if(opp.Account.Owner.Name <> 'Branch Account' && is24hrsSweep)
                { sweepUpdateOpportunityAccount(opp.Id,opp.Account.OwnerId,null,null,false,opp);      } 
              else if(mapSellingRegionUser.containskey(opp.Selling_Region__c) && is24hrsSweep)
                { User us = mapSellingRegionUser.get(opp.Selling_Region__c);
                  sweepUpdateOpportunityAccount(opp.Id,us.Id,opp.AccountId,us.Id,true,opp); 
                  OpportunityAccountSweepISM24hrsset.add(opp.Id);
                  OpportunityAccountSweepISM24hrsset.add(opp.AccountId);
                }
              else if(!is24hrsSweep && isAcctExceptionTempAssignment(opp))
              { sweepUpdateOpportunityAccount(opp.Id,opp.Account.OwnerId,null,null,iscreateTask,opp);      // TFS 3452
                OpportunityAccountSweepISM24hrsset.add(opp.Id);
              }  
            }
             
     else if(opp.StageName == 'Quoted – Lost' || opp.StageName == 'Quoted - Lost Business')  // opp no sweep, account sweep to Branch Account..
            { if(opp.Account.Owner.UserRole.Name <> '' && opp.Account.Owner.UserRole.Name <> null && opp.Account.Owner.UserRole.Name.containsIgnoreCase('Inbound Sales Specialist'))  
              { ID BranchUserID ;  
                List<Branch_Account_User_id__c> BranchAccountIdList = null;
                BranchAccountIdList = Branch_Account_User_id__c.getAll().Values();
                  if(BranchAccountIdList != null && !BranchAccountIdList.isEmpty())
                     { BranchUserID = BranchAccountIdList.get(0).User_Id__c;}
                sweepUpdateOpportunityAccount(null,null,opp.AccountId,BranchUserID,false,opp);                
              }     
            }
   }
   
 // method that sweeps ISR Opportunity..
  private static void SweepISROpportunity(Opportunity opp)
   { isISRrep = true;
     Boolean iscreateTask = OppCheckEmailNotify.containskey(opp.ID) ? (OppCheckEmailNotify.get(opp.ID) ? false : true) : true ;    // TFS 3452,3655
     if(opp.StageName == 'Quoted - Won')
      {  if(mapTerritoryUser.containskey(opp.Account.Territory__c))
          { User u = mapTerritoryUser.get(opp.Account.Territory__c);
              if(u.Available_For_Leads__c)
                { sweepUpdateOpportunityAccount(opp.Id,null,opp.AccountId,u.Id,true,opp);   }
              else
               {  if(u.ManagerId != null && u.Manager.isActive == True)
                    { sweepUpdateOpportunityAccount(opp.Id,null,opp.AccountId,u.ManagerId,true,opp);  }
                  else
                    {  sweepUpdateOpportunityAccount(opp.Id,null,opp.AccountId,u.Id,true,opp);    } 
               } 
           }
      }
     else if(opp.StageName == 'Quoted - No Decision' || opp.StageName == 'Not Quoted')
      {  if(mapTerritoryUser.containskey(opp.Account.Territory__c))
         {  User u = mapTerritoryUser.get(opp.Account.Territory__c);
             if(u.Available_For_Leads__c)
               { sweepUpdateOpportunityAccount(opp.Id,u.Id,opp.AccountId,u.Id,iscreateTask,opp);  }
             else
                {  if(u.ManagerId != null && u.Manager.isActive == True)
                     { sweepUpdateOpportunityAccount(opp.Id,u.ManagerId,opp.AccountId,u.ManagerId,iscreateTask,opp);  }
                   else
                     { sweepUpdateOpportunityAccount(opp.Id,u.Id,opp.AccountId,u.Id,iscreateTask,opp);  } 
                }
         }
      }  
  }
  
 // method to update Opportunity map, Account map..
 private static void SweepUpdateOpportunityAccount(ID oID,ID oOwnerID,ID aID,ID aOwnerID,Boolean iscreateTask,Opportunity opp)
 {  if(oID <> null && oOwnerID == null )
     { OpportunityMapforUpdate.put(oID,new Opportunity(ID = oID,isOpportunitySweep__c = true,is_NSC_Processed__c = true));  }
    else if(oID <> null && oOwnerID == null && aID == null && aOwnerID == null)
     {OpportunityMapforUpdate.put(oID,new Opportunity(ID = oID,isOpportunitySweep__c = true,is_NSC_Processed__c = true));}
    else if(oOwnerID <> null)
     { OpportunityMapforUpdate.put(oID,new Opportunity(ID = oID,isOpportunitySweep__c = true,is_NSC_Processed__c = true,OwnerID = oOwnerID));  } 
    
    if(aOwnerID <> null &&  (isIBrep || isISRrep) && OppCheckEmailNotify.containskey(opp.ID))   // TFS 3655
    { AccountMapforUpdate.put(aID,new Account(ID = aID,OwnerID = aOwnerID,isEmailNotify__c = false));}
    else if(aOwnerID <> null)
     {AccountMapforUpdate.put(aID,new Account(ID = aID,OwnerID = aOwnerID)); }
     
    if(iscreateTask == true)
    { createTasks(opp);  }
    
    isIBrep = false; isISRrep = false;              // TFS 3655
 } 
  
 // method to sweep Task to new Owner after Sweep..
  private static void SweepExistingTasks(List<Opportunity> oList)
  { if(OpportunityMapforUpdate.size() > 0)                    // sweep Task related to Opportunity.. 
     { for(Opportunity opp : oList)
        {  system.debug('---------------opp.id--------'+ opp.id );
           system.debug('------------ opp.tasks.size() ------------' + opp.tasks.size());
            if(!opp.isClosed && opp.tasks.size() > 0 && OpportunityMapforUpdate.containskey(opp.id) && !OpportunityAccountSweepISM24hrsset.contains(opp.id))
               {  Opportunity Oppr = OpportunityMapforUpdate.get(opp.id);
                   for(Task t : opp.tasks)
                    { if(t.Status <> 'Completed' && (t.ownerId == opp.ownerId) && !TasksUpdateonSweep.containskey(t.id))
                        { t.ownerId = oppr.ownerId;
                          TasksUpdateonSweep.put(t.id,t);
                        }
                    }
               }    
           }     
      }
    // sweep Task related to Account..
    if(AccountMapforUpdate.size() > 0)
     {  List<Account> accList = [select id,ownerid,(select id,Status,ownerId from tasks where status != 'Completed') from Account where id IN: AccountMapforUpdate.keyset()];
         for(Account acc : accList)
         { system.debug('--------------- acc.Id --------'+ acc.Id );
           system.debug('------------ acc.tasks.size() ------------' + acc.tasks.size()); 
            if(acc.tasks.size() > 0 && AccountMapforUpdate.containskey(acc.id) && !OpportunityAccountSweepISM24hrsset.contains(acc.id))
            {  Account acct = AccountMapforUpdate.get(acc.Id);
                for(Task t : acc.tasks)
                {  if(t.Status <> 'Completed' && (t.ownerId == acc.ownerId) && !TasksUpdateonSweep.containskey(t.id))
                    {  t.ownerId = acct.ownerId;
                        TasksUpdateonSweep.put(t.id,t);
                    }
                }   
            }   
         }
     }
  }
   
 // method to update all changes and insert task..
  private static void UpdateChanges()
   {  if(OpportunityMapforUpdate.size() > 0)
       {  system.debug('-- update on opp--');
          update OpportunityMapforUpdate.values();
       }
      if(AccountMapforUpdate.size() > 0)
       { system.debug('-- update on acc --');
         update AccountMapforUpdate.values();
          
         for(Contact c : [select id,name,OwnerId,AccountId,Account.name,Account.OwnerId from contact where AccountId in : accountMapforUpdate.keySet()])
          { if(!ContactRelatedAccountMap.containskey(c.AccountId))
             { ContactRelatedAccountMap.put(c.AccountId, new List<Contact>()); }
            ContactRelatedAccountMap.get(c.AccountId).add(new Contact(Id = c.Id,ownerId = c.Account.OwnerId));
          }
       }
      if(ContactRelatedAccountMap.size() > 0)
       { List<Contact> allContactsList = new List<Contact>();
          for(Id accId : ContactRelatedAccountMap.keySet())
           {  allContactsList.addAll(ContactRelatedAccountMap.get(accId)); }
         system.debug('-- update on contact--');
         update allContactsList; 
       } 
      if(TasksUpdateonSweep.size() > 0)
       { system.debug('-- update on task --');
         update TasksUpdateonSweep.values();
       }
      if(NewTasks.size() > 0)
      { system.debug('-- create task--');
        insert NewTasks;
      }   
   }
  
 // method to create Task..
  private static void createTasks(Opportunity opp)
  { String mailBody = '';
    Id ownerId;
    
    Opportunity oppty = !isRunningTest ? (OpportunityMapforUpdate.containskey(opp.Id) ? OpportunityMapforUpdate.get(opp.Id) : null) : opp;
    Account accnt = !isRunningTest ? (AccountMapforUpdate.containskey(opp.Account.Id) ? AccountMapforUpdate.get(opp.Account.Id) : null) : opp.account;
      
    String whID = oppty <> null ? oppty.Id : opp.Id;
    String owID = accnt <> null ? accnt.ownerId : opp.Account.ownerId;
    
    system.debug('------- opp.isClosed ------------' + opp.isClosed);
    system.debug('------- opp.StageName ------------' + opp.StageName);

     if(opp.Billing_Zip_Postal_Code__c == null || opp.Billing_Zip_Postal_Code__c == '')
        { system.debug('-------- Billing Zip Code not found ----------' );
          Task tsk = new Task();
               tsk.Subject = 'Opportunity was created on an account where the zip code cannot be found in the branch lookup table';
               tsk.Call_Type__c = 'OB - Sales/Customer Service';
               tsk.RecordTypeId = TaskDefaultrecordTypeId;
               tsk.WhatId =  whID;   
               tsk.OwnerId = owID;
               tsk.Priority  =  'High';
                if (opp.NSC_Sweep_Date__c != null ) 
                { tsk.ActivityDate = date.newinstance(opp.NSC_Sweep_Date__c.year(), opp.NSC_Sweep_Date__c.month(), opp.NSC_Sweep_Date__c.day()); }
               NewTasks.add(tsk); 
               mailBody += 'This Opportunity is assigned to you. Click the following link to view this Opportunity in Salesforce:\n';
               mailBody += System.Label.Organization_URL + whID + '\n';
               ownerId = owID;
        }
     else if(opp.isClosed) 
           { system.debug('--------------- Won Opportunity From IB – Call for more business---------------');
             Task task1 = new Task();
                 task1.Subject = 'Won Opportunity From IB – Call for more business';
                 task1.Call_Type__c = 'OB - Sales/Customer Service';
                 task1.RecordTypeId = TaskDefaultrecordTypeId;
                 system.debug('*********** whID ***********' + whID);
                 system.debug('*********** owID ***********' + owID);
                 task1.WhatId =  whID;   
                 task1.OwnerId = owID;
                 task1.priority  =  'Normal';
                  // Case 00040379 by Hemlata                
                 task1.ActivityDate = System.today();                  
                 NewTasks.add(task1);
                 mailBody += 'Won Opportunity From IB – Call for more business. Click the following link to view this Opportunity in Salesforce:\n';
                 mailBody += System.Label.Organization_URL + whID + '\n';
                 ownerId = owID;
          }
     else if(!opp.IsClosed)
          { system.debug('-------- Review Opportunity moved from Inbound ----------' ); 
            Task task2 = new Task();
                 task2.Subject = 'Review Opportunity moved from Inbound';
                 task2.Call_Type__c = 'OB - Sales/Customer Service';
                 task2.RecordTypeId = TaskDefaultrecordTypeId;
                 task2.WhatId =  whID;  
                 task2.OwnerId = owID;
                 task2.Priority  =  'High';
                  // Case 00040379 by Hemlata
                 if (opp.NSC_Sweep_Date__c != null ) 
                 { task2.ActivityDate = date.newinstance(opp.NSC_Sweep_Date__c.year(), opp.NSC_Sweep_Date__c.month(), opp.NSC_Sweep_Date__c.day()); }
                 NewTasks.add(task2);   
                 mailBody += 'This Opportunity is assigned to you. Click the following link to view this Opportunity in Salesforce:\n';
                 mailBody += System.Label.Organization_URL + whID + '\n';
                 ownerId = owID;                           
          }     
    
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    mail.setTargetObjectId(ownerId);
    mail.setSubject('Record Moved');
    mail.setPlainTextBody(mailBody);      
    mail.setSaveAsActivity(false);  
    notificationEmails.add(mail);
 } 
}