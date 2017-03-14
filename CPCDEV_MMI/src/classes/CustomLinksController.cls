/*************************************************************
Name          : CustomLinksController
Usage         : Controller class for custom_Links Page.
Created By    : Kirtesh Jain
Created Date  : July 15, 2009
**************************************************************/

public class CustomLinksController {
    public Integer myOpenHotLeads {get;set;}
    public Integer myOpenWarmDodgeLeads {get;set;}
    public Integer myOpenLeads {get;set;}
    public Integer MyOpenCampaignLeads {get;set;}                    // MSM 31
    public Integer MyCoreAccounts {get;set;}                         // MSM 31
    public Integer MyPotentialAccounts {get;set;}                    // MSM 31 
    public Integer myAccounts {get;set;}
    public Integer myContacts {get;set;}
    public Integer myOpenOpportunities{get;set;}
    public Integer myOverdueTasks{get;set;}
    public Integer myAccountsWithNoCallbacks{get;set;}
    public string currentUser{get;set;}
    public string currentUsersTerritoryId {get;set;}
    public string currentUsersBranchId{get;set;}
    public Integer myCreatedOppByInbound{get;set;}
     
    
    public Integer myOpenOpps{get;set;}               // MSM 82..
    public Integer myOpenjbCoverage{get;set;}
    public Integer totalKeySubs{get;set;}
    public Integer HotLeadsNotCalled{get;set;}
    public Integer SweptOppsNotCalled{get;set;}
    public Integer JPsPassedCompletionDate{get;set;}
    public Integer AccountsNotContacted{get;set;} 
    
    
    
    public Integer myOpenHotABILeads {get;set;}
    
    public CustomLinksController(){
      currentUser= UserInfo.getUserId();
      String currentUserRoleId = UserInfo.getUserRoleId();
      
      User u = [Select Branch_Id__c,Territory__c from User where Id = :currentUser];
      
      currentUsersBranchId = u.Branch_Id__c;
      currentUsersTerritoryId = u.Territory__c;

      myOpenHotABILeads = [Select count() 
                        From Lead l 
                        where l.Rating = 'Hot (Probably Order)' and  l.Status = 'Open' and l.LeadSource <> 'Dodge'
                              and l.RecordType.Name = 'ABI Lead' and l.OwnerId =: currentUser Limit 1000];

      myOpenHotLeads = [Select count() 
                        From Lead l 
                        where l.Rating = 'Hot (Probably Order)' and  l.Status = 'Open' and l.LeadSource <> 'Dodge'
                              and l.OwnerId =: currentUser Limit 1000];

      myOpenWarmDodgeLeads = [Select count() 
                        From Lead l 
                        where l.isConverted=False and l.Rating = 'Warm (Possibly Order)' and  l.Status = 'Open' and l.LeadSource = 'Dodge Report' and l.RecordType.Name = 'Dodge Lead'
                              and l.OwnerId =: currentUser Limit 1000];
     
      myOpenLeads = [ Select count() 
                      From Lead l 
                      where  l.Status ='Open' and l.OwnerId=: currentUser limit 2000]; 
      
      /*                
        // MSM 82 ..
       myOpenOpps = [ Select count() 
                      From Opportunity o 
                      where  o.CloseDate <= TODAY  and o.StageName <> 'Quoted - Won' and o.StageName <> 'Quoted - Lost Business' and o.OwnerId=: currentUser limit 2000]; 
      */
      
      // TFS : 2253
      myOpenOpps = [ Select count() 
                      From Opportunity o 
                      where  o.CloseDate <= TODAY  and o.StageName NOT IN ('Quoted - Won','Quoted – Lost','Closed Won','Closed Lost','Won Bid','Lost Bid','Won','Lost','Quoted - Lost Business') and o.OwnerId=: currentUser limit 2000]; 
      
                      
      List<Job_Profile__c> myJBcoverageList  = [ Select ID,Number_of_Key_Sub__c 
                      From Job_Profile__c j  
                      where  (j.Project_Stage_Status__c = 'Start' or j.Project_Stage_Status__c = 'Construction' or (j.Dodge_Project__r.GC_Awarded__c = True and j.Project_Stage_Status__c <> 'Completed' and j.Project_Stage_Status__c <> 'Abandoned')) and j.OwnerId=: currentUser limit 2000];                
      
      myOpenjbCoverage = 0; 
      totalKeySubs = 0;
       
      system.debug('------------ myJBcoverageList.size() ------------' + myJBcoverageList.size());
      
       for(Job_Profile__c myJBcoverage : myJBcoverageList)
        {  totalKeySubs +=  Integer.Valueof(myJBcoverage.Number_of_Key_Sub__c); }
      
      system.debug('------------ totalKeySubs ------------' + totalKeySubs);
         
      myOpenjbCoverage = ((myJBcoverageList.size() * 4) - totalKeySubs);   
            
      system.debug('------------ myOpenjbCoverage ------------' + myOpenjbCoverage);
                      
      HotLeadsNotCalled = [ Select count() 
                      From Lead l 
                      where  (l.Rating ='Hot (Awaiting Contact)' or l.Rating = 'Hot (Probably Order)') and l.Status <> 'Dead Lead' and l.First_Activity_DateTime__c = null and l.isConverted=False and l.OwnerId=: currentUser limit 2000];                
                      
      SweptOppsNotCalled = [ Select count()
                            FROM Task t
                            Where t.Subject = 'Review Opportunity moved from Inbound' AND t.Owner.UserRole.Name like 'Sales%' AND t.isClosed = false AND t.Owner.isActive = True AND t.CreatedBy.Name IN ('Appirio Cloud Mgmt', 'TEK Developer') AND t.OwnerId=:currentUser];  
                      
     JPsPassedCompletionDate = [ Select count()
                      From Job_Profile__c j  
                      where  j.Project_Stage_Status__c <> 'Abandoned' and j.Project_Stage_Status__c <> 'Completed' and Expected_Completion_Date__c < TODAY and j.OwnerId=: currentUser limit 2000];                              
     
     AccountsNotContacted = 0;
    for(Account a : [Select a.LastActivityDate From Account a where a.OwnerId =: currentUser and a.LastActivityDate <> null])
         { 
          if(a.LastActivityDate.daysBetween(date.today()) > 90)
          AccountsNotContacted ++ ;
         }   
         
         system.debug('------------ AccountsNotContacted ----------------' + AccountsNotContacted);     
                    
    // MSM 31 starts..
      MyOpenCampaignLeads = [Select count() 
                        From Lead l 
                        where (NOT(l.Status like '%Dead%')) and l.LeadSource like '%OB Campaign%'
                              and IsConverted=False and l.OwnerId =: currentUser Limit 5000];

      MyCoreAccounts = [Select count() 
                        From Account a 
                        where a.Account_Classification__c = 'Core' and a.OwnerId =: currentUser Limit 5000];
                        
      MyPotentialAccounts = [Select count() 
                        From Account a 
                        where a.Account_Classification__c = 'Potential' and a.OwnerId =: currentUser Limit 5000];                       
    // ends..
      
      myAccounts = [ Select count()
                     From  Account
                     where OwnerId=:currentUser ];  
      
      myContacts = [ Select count() 
                     From Contact 
                     where OwnerId=:currentUser ];
      
      myOpenOpportunities = [ Select count()  
                           From Opportunity 
                           where IsClosed = FALSE and OwnerId=:currentUser ];
      
      myOverdueTasks = [ Select count()
                            FROM Task
                            Where ActivityDate < TODAY AND isclosed = false AND OwnerId=:currentUser ];
      
      myAccountsWithNoCallbacks = 0;
      
      myAccountsWithNoCallbacks = [Select count() From Account Where ( ((Number_of_Open_Tasks__c < 1) OR (Number_of_Open_Tasks__c = NULL)) AND ( ((Type != 'Competitor') AND (Type != 'Partner')) ) AND (OwnerId = :currentUser))];
     
      //Date selectedDate = Date.Today().addDays(-(Integer.valueOf(system.label.edit_date)));
      //integer inte = Integer.valueOf(system.label.edit_date) ;
       
      // Count Opportunity History record (We have implemented it in this way because Reference field are created two entry in OpportunityFieldHistory and in report it show as single entry.)
      //Integer opportunityHistoryReferenceFieldCount = [Select count() From OpportunityFieldHistory o where o.Opportunity.OwnerId = : UserInfo.getUserId() and o.createdDate > :selectedDate AND o.Opportunity.IsClosed = FALSE and o.CreatedBy.Name = 'Michael Floyd' AND o.field = 'Owner'];
      //opportunityHistoryReferenceFieldCount = opportunityHistoryReferenceFieldCount > 0 ? ( opportunityHistoryReferenceFieldCount / 2 ) : 0;
      //Integer opportunityHistoryGeneralFieldCount = [Select count() From OpportunityFieldHistory o where o.Opportunity.OwnerId = : UserInfo.getUserId() and o.createdDate > :selectedDate AND o.Opportunity.IsClosed = FALSE and o.CreatedBy.Name = 'Michael Floyd' AND o.field != 'Owner'];
      
      Integer opportunityHistoryReferenceFieldCount = 0 ;
      //for(OpportunityFieldHistory opp : [Select createdDate From OpportunityFieldHistory o where o.Opportunity.OwnerId = : UserInfo.getUserId()  AND o.Opportunity.IsClosed = FALSE and o.CreatedBy.Name = 'Michael Floyd' AND o.field = 'Owner'] ){
      for(OpportunityFieldHistory opp : [Select createdDate From OpportunityFieldHistory o where o.Opportunity.OwnerId = : UserInfo.getUserId()  AND o.Opportunity.IsClosed = FALSE and o.CreatedBy.Name in ('Michael Floyd','Appirio Developer') AND o.field = 'Owner'] ){
        if(opp.createdDate.date().daysBetween(date.today()) < (Integer.valueOf(system.label.edit_date))){            
            opportunityHistoryReferenceFieldCount ++ ;
        }
      }
      opportunityHistoryReferenceFieldCount = opportunityHistoryReferenceFieldCount > 0 ? ( opportunityHistoryReferenceFieldCount / 2 ) : 0;
          
      Integer opportunityHistoryGeneralFieldCount = 0 ;
     // for(OpportunityFieldHistory opp : [Select createdDate From OpportunityFieldHistory o where o.Opportunity.OwnerId = : UserInfo.getUserId()  AND o.Opportunity.IsClosed = FALSE and o.CreatedBy.Name = 'Michael Floyd' AND o.field != 'Owner'] ){
      for(OpportunityFieldHistory opp : [Select createdDate From OpportunityFieldHistory o where o.Opportunity.OwnerId = : UserInfo.getUserId()  AND o.Opportunity.IsClosed = FALSE and o.CreatedBy.Name in ('Michael Floyd','Appirio Developer') AND o.field != 'Owner'] ){
        if(opp.createdDate.date().daysBetween(date.today()) < (Integer.valueOf(system.label.edit_date))){           
            opportunityHistoryGeneralFieldCount ++ ;
        }
      }
      
      
      myCreatedOppByInbound = opportunityHistoryReferenceFieldCount;// + opportunityHistoryGeneralFieldCount;
      
      system.debug('========opportunityHistoryReferenceFieldCount====='+opportunityHistoryReferenceFieldCount);
      system.debug('========opportunityHistoryGeneralFieldCount====='+opportunityHistoryGeneralFieldCount);
      system.debug('========myCreatedOppByInbound====='+myCreatedOppByInbound);
      
      //[ Select count() From OpportunityFieldHistory o where o.Opportunity.OwnerId = : UserInfo.getUserId() and o.createdDate = TODAY AND o.Opportunity.IsClosed = FALSE and o.CreatedBy.Name = 'Michael Floyd'];
      //Select count() From OpportunityHistory where OwnerId = : UserInfo.getUserId() AND LastModifiedDate = TODAY AND IsClosed = FALSE]; //createdDate = LAST_N_DAYS:30 AND 
      /* 
      List<Sum_Accounts_Without_Callbacks__c> sumRow = new List< Sum_Accounts_Without_Callbacks__c>([Select ownCount__c from Sum_Accounts_Without_Callbacks__c where UserId__c = :currentUser]) ;
      if(sumRow.size() > 0){
          myAccountsWithNoCallbacks = sumRow.get(0).ownCount__c.intValue() ;
      }
      */
      
      
      /*UserRole userRole = [Select Name, Id ,ParentRoleId From UserRole where Id = :UserInfo.getUserRoleId() Limit :(Limits.getLimitQueryRows() - Limits.getQueryRows())];
      if(userRole.Name.contains('Sales Rep')== true ){
          List<Sum_Accounts_Without_Callbacks__c> sumRow = new List< Sum_Accounts_Without_Callbacks__c>([Select ownCount__c from Sum_Accounts_Without_Callbacks__c where UserId__c = :currentUser]) ;
          if(sumRow.size() > 0){
              myAccountsWithNoCallbacks = sumRow.get(0).ownCount__c.intValue() ;
          }
          
      }
      else
      {
         List< Sum_Accounts_Without_Callbacks__c > sumRows = new List< Sum_Accounts_Without_Callbacks__c >([Select ownCount__c, Count__c from Sum_Accounts_Without_Callbacks__c  where RoleId__c =: currentUserRoleId ]);
         for(Sum_Accounts_Without_Callbacks__c  row : sumRows ){
               myAccountsWithNoCallbacks += (row.Count__c.intValue() + row.ownCount__c.intValue());
               
           }
           
         
      }*/
                
    }

}