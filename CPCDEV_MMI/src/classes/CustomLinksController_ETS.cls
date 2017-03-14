/**********************************************
 Name      :   CustomLinksController_ETS
 Usage     :   Controller class for customLinks_ETS page
*/

public Class CustomLinksController_ETS
{  public Integer myOpenActivity{get;set;}
   public Integer myOpenOpps{get;set;}
   public Integer myAccountWithNoCallBack{get;set;}
   public Integer myAccountNotContacted{get;set;}
   public Integer myAccount{get;set;}
   //public Integer OppPipelineReport{get;set;}
   public Integer myCompletedActivities{get;set;} 
   public Integer myLunchnLearn{get;set;}
   public Integer myTownShow{get;set;}
   
   public CustomLinksController_ETS()
   {  String currentUserID = UserInfo.getUserId();
      //String currentUserRole = UserInfo.getUserRoleId();
      
      Date nxtDate = date.today().addDays(29);
      Date startDate = date.today().toStartOfWeek();
      Date endDate = startDate.addDays(6);
      
      DateTime currentTime = system.now();
      DateTime nxtDateTime = system.now().addDays(29);
      DateTime startDateTime = DateTime.newInstance(startDate.year(),startDate.month(),startDate.day());
      DateTime endDateTime = DateTime.newinstance(endDate.year(),endDate.month(),endDate.day());
      
      system.debug('--- nxtDate ----' + nxtDate);
      system.debug('--- startDate ---' + startDate);
      system.debug('--- endDate ---' + endDate);
      system.debug('--- currentTime ---' + currentTime);
      system.debug('--- nxtDateTime ----' + nxtDateTime);
      system.debug('--- startDateTime ---' + startDateTime);
      system.debug('--- endDateTime ---' + endDateTime);
            
      Integer myOpenTasks = [select count() from Task t where t.RecordType.Name = 'ETS/WMI Task' and t.IsClosed = false and t.OwnerID =: currentUserID LIMIT 2000];
      
      Integer myOpenEvents = [select count() from Event e where e.RecordType.Name = 'ETS/WMI Event Record Type' and e.ActivityDateTime <> null and e.ActivityDateTime >=: currentTime and e.OwnerID =: currentUserID LIMIT 2000];
      
      myOpenActivity = myOpenTasks + myOpenEvents ; 
       
      myOpenOpps = [select count() from Opportunity o where o.RecordType.Name IN ('ETS Sale','ETS Rental','WMI Opportunity') and o.StageName NOT IN ('Quoted - Won','Quoted – Lost','Closed Won','Closed Lost','Won Bid','Lost Bid','Won','Lost','Quoted - Lost Business') and o.OwnerID =: currentUserID LIMIT 2000];
      
      myAccountWithNoCallBack = [select count() from Account a where a.RecordType.Name = 'ETS/WMI' and (a.Number_of_Open_Tasks__c < 1 or a.Number_of_Open_Tasks__c = null) and a.Owner.Name <> 'Branch Account' and a.Type NOT IN ('Competitor','Partner') and a.OwnerID = : currentUserID LIMIT 2000];
      
      myAccountNotContacted = 0;
      for(Account acc : [select a.LastActivityDate from Account a where a.RecordType.Name = 'ETS/WMI' and a.LastActivityDate <> null and a.OwnerID =: currentUserID LIMIT 2000])
      { if(acc.LastActivityDate.daysBetween(date.today()) > 30)
         { myAccountNotContacted++; }
      }
      system.debug('----- myAccountNotContacted -----' + myAccountNotContacted);
      
      myAccount = [select count() from Account a where a.RecordType.Name = 'ETS/WMI' and a.OwnerID =: currentUserID LIMIT 2000];
      
      Integer myCompletedTasks = [select count() from task t where t.isClosed = true and  t.ActivityDate <> null and t.ActivityDate >=: startDate and t.ActivityDate <=: endDate and t.ownerID =: currentUserID LIMIT 2000];
      
      Integer myCompletedEvents = [select count() from Event e where e.ActivityDateTime<> null and e.ActivityDateTime <: currentTime and e.ActivityDateTime >=: startDateTime and e.ActivityDateTime <=: endDateTime and e.ownerID =: currentUserID LIMIT 2000];
      
      myCompletedActivities = myCompletedTasks + myCompletedEvents ;
      
      Integer myLunchnLearnTask =  [select count() from task t where t.isClosed = true and  t.ActivityDate <> null and t.ActivityDate >= TODAY and t.ActivityDate <=: nxtDate and t.Activity_Code__c = 'Lunch & learn' and t.OwnerID =: currentUSerID LIMIT 2000];
      
      Integer myLunchnLearnEvent = [select count() from Event e where e.ActivityDateTime <> null and e.ActivityDateTime <: currentTime and  e.ActivityDate <> null and e.ActivityDate >= TODAY and e.ActivityDate <=: nxtDate and e.Activity_Code__c = 'Lunch & learn' and e.OwnerID =: currentUSerID LIMIT 2000];
      
      myLunchnLearn = myLunchnLearnTask + myLunchnLearnEvent;
      
      Integer myTownShowTask = [select count() from task t where t.isClosed = true and  t.ActivityDate <> null and t.ActivityDate >= TODAY and t.ActivityDate <=: nxtDate and t.Activity_Code__c = 'Tow & Show' and t.OwnerID =: currentUserID LIMIT 2000];
      
      Integer myTownShowEvent = [select count() from Event e where e.ActivityDateTime <> null and e.ActivityDateTime <: currentTime and  e.ActivityDate <> null and e.ActivityDate >= TODAY and e.ActivityDate <=: nxtDate and e.Activity_Code__c = 'Tow & Show' and e.OwnerID =: currentUserID LIMIT 2000];
      
      myTownShow = myTownShowTask + myTownShowEvent; 
   }  
}