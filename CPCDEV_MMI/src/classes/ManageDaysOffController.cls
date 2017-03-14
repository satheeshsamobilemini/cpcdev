/********************************************************************************************************
Name   : ManageDaysOffController
Usage  : Controller class of ManageDaysOff VF page which is used to track the number of days subordinate
         sales reps are out of the office (sick/vacation, government work, and field visits).
Author : Aashish Mathur
Date   : September 2, 2009

Modified Date : October 05 ,2009
Author : Kirtesh Jain
Comment : removed code related to Goverment work and field visits.
********************************************************************************************************/

public with sharing class ManageDaysOffController {
    // Variable used for time period input
    public Days_Off_Tracker__c dotForTimePeriodInput {get; private set;}
    public Boolean hasSubordinateUsers {get; private set;}
    public Integer currentPage {get; private set;}
    
    // Number of users to be shown per page
    private final Integer RESULTS_PER_PAGE;
    // List containing all Days_Off_Tracker__c
    private List<DaysOffTracker> allDaysOffTrackers;
    // List containing List of Days_Off_Tracker__c by page number
    private List<List<DaysOffTracker>> daysOffTrackersByPageNumber;
    private final Integer DAYS_TO_ADD_FOR_FRIDAY;
    private List<User> subordinateUsers;
    private Set<ID> subordinateUserIds;
    private Map<ID, Set<ID>> roleIdToChildrenRoleIdsMap;
    public String currentUserRoleName;
    
    public Integer noOfSubordinateUsers {
        get {
            return subordinateUsers.size();
        }
    }
    public Integer totalPage {
        get {
            return daysOffTrackersByPageNumber.size();
        }
    }
    public Boolean hasPreviousPage {
        get {
            return (currentPage > 1);
        }
    }
    public Boolean hasNextPage {
        get {
            return (currentPage < daysOffTrackersByPageNumber.size());
        }
    }
    public Integer showingFrom {
        get {
            return (((currentPage - 1) * RESULTS_PER_PAGE) + 1);
        }
    }
    public Integer showingTo {
        get {
            if (currentPage == totalPage)
                return subordinateUsers.size();
            else
                return (currentPage * RESULTS_PER_PAGE);
        }
    }
    
    /*
     * Constructor
     */
    public ManageDaysOffController() {
        try {
            RESULTS_PER_PAGE = 10;
            dotForTimePeriodInput = new Days_Off_Tracker__c();
            currentPage = 0;
             //Initialize daysOffTrackersByPageNumber 
            daysOffTrackersByPageNumber = new List<List<DaysOffTracker>>();
            //added for T-17958
            for(User usr : [select id , Name , UserRole.Name from User where id = : userInfo.getUserId()]){
				currentUserRoleName = usr.UserRole.Name;	  	 	
  			}
            // Prepare UserRoleId to Set of children UserRoleIds Map
            roleIdToChildrenRoleIdsMap = new Map<ID, Set<ID>>();
            for (UserRole userRole : [Select Id, ParentRoleId from UserRole]) {
                if (userRole.ParentRoleId == null)
                    continue;
                
                if (roleIdToChildrenRoleIdsMap.get(userRole.ParentRoleId) == null)
                    roleIdToChildrenRoleIdsMap.put(userRole.ParentRoleId, new Set<ID>());
                
                roleIdToChildrenRoleIdsMap.get(userRole.ParentRoleId).add(userRole.Id);
            }
            
            // Get subordinate users' role ids of logged in user
            //Added for T-17958
            Set<ID> subordinateRoleIds = loadSubordinateRoleIds(UserInfo.getUserRoleId());
            subordinateUsers = [Select Id, Name, Extension from User where isActive = true
                    and UserRoleId in :subordinateRoleIds order by Name];
            
            // If there is not any subordinate user then return
            if (subordinateUsers.size() == 0) {
                hasSubordinateUsers = false;
                return;
            }
            
            hasSubordinateUsers = true;
            subordinateUserIds = new Set<ID>();
            for (User user : subordinateUsers)
                subordinateUserIds.add(user.id);
            
            // Generally depending on the context user's locale
            // start day of Week may be Sun, Mon or Sat
            Date startOfWeek = Date.today().toStartOfWeek();
            String startDayOfWeek = DateTime.newInstance(startOfWeek.year(), startOfWeek.month(),
                    startOfWeek.day()).format('E');
            System.debug('startDayOfWeek ---->');
            System.debug(startDayOfWeek );           
            if (startDayOfWeek == 'Sun')
                DAYS_TO_ADD_FOR_FRIDAY = 5;
            else if (startDayOfWeek == 'Mon')
                DAYS_TO_ADD_FOR_FRIDAY = 4;
            else if (startDayOfWeek == 'Tue')
                DAYS_TO_ADD_FOR_FRIDAY = 3;
            else if (startDayOfWeek == 'Wed')
                DAYS_TO_ADD_FOR_FRIDAY = 2;
            else if (startDayOfWeek == 'Thu')
                DAYS_TO_ADD_FOR_FRIDAY = 1;
            else if (startDayOfWeek == 'Fri')
                DAYS_TO_ADD_FOR_FRIDAY = 0;
            else if (startDayOfWeek == 'Sat')
                DAYS_TO_ADD_FOR_FRIDAY = 6;
            System.debug('DAYS_TO_ADD_FOR_FRIDAY---->');
            System.debug(DAYS_TO_ADD_FOR_FRIDAY);    
        } catch(Exception ex) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, ex.getMessage()));
        }
    }
    
    private Set<ID> loadSubordinateRoleIds(Id currentUserRoleId){
    	Set<ID> subRoleIds = new Set<ID>();
  	    if(currentUserRoleName != null){
  			List<Manage_Sales_Rep_Settings__c> manageSalesRepSettings = [select Name, Key__c , Role_Name__c from Manage_Sales_Rep_Settings__c where Role_Name__c = : currentUserRoleName];
  			if(manageSalesRepSettings.size() > 0){
  				String filterCriteria = manageSalesRepSettings.get(0).key__c+'%';
  				
  				for(UserRole usrRole : [select id from UserRole where Name like : filterCriteria ]){
 					subRoleIds.addAll(getSubordinateRoleIds(usrRole.Id)); 					
  				}
  			}else{
  				subRoleIds = getSubordinateRoleIds(currentUserRoleId);
  			}
  	    }else if(currentUserRoleId != null){
  	    	subRoleIds = getSubordinateRoleIds(currentUserRoleId);
  	    } 
  	    return subRoleIds;
    }
    /*
     * Save entered Days_Off_Tracker__c
     */
    public void saveDaysOffTrackers() {
        try {
            List<Days_Off_Tracker__c> daysOffTrackerToInsert = new List<Days_Off_Tracker__c>();
            List<Days_Off_Tracker__c> daysOffTrackerToUpdate = new List<Days_Off_Tracker__c>();
            List<Days_Off_Tracker__c> daysOffTrackerToDelete = new List<Days_Off_Tracker__c>();
            
            // Go through all Days_Off_Tracker__c
            for (DaysOffTracker daysOffTrackerInstance : allDaysOffTrackers) {
                Days_Off_Tracker__c daysOffTracker = daysOffTrackerInstance.daysOffTracker;
                
                if (daysOffTracker.id != null) {
                    // If Days_Off_Tracker__c has non null Sick_Days__c 
                    // then it is to be updated
                    if (daysOffTracker.Sick_Days__c != null)
                        daysOffTrackerToUpdate.add(daysOffTracker);
                    // If all fields are null then it is to be deleted
                    else
                        daysOffTrackerToDelete.add(daysOffTracker);
                // If any field is non null but id is null then Days_Off_Tracker__c is to be inserted
                } else if (daysOffTracker.Sick_Days__c != null ) {
                        daysOffTrackerToInsert.add(daysOffTracker);
                }
            }
            
            insert daysOffTrackerToInsert;
            update daysOffTrackerToUpdate;
            delete daysOffTrackerToDelete;
            
            // Reprepare List daysOffTrackersByPageNumber
            Integer originalCurrentPage = currentPage;
            prepareDaysOffTrackersByPageNumber();
            currentPage = originalCurrentPage;
            
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.INFO,
                    'Entered trackers have been saved.'));
        } catch(Exception ex) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, ex.getMessage()));
        }
    }
    
    public void goToPreviousWeek() {
        dotForTimePeriodInput.Time_Period__c = dotForTimePeriodInput.Time_Period__c.addDays(-7);
        // Reprepare List daysOffTrackersByPageNumber
        prepareDaysOffTrackersByPageNumber();
    }
    
    public void goToNextWeek() {
        dotForTimePeriodInput.Time_Period__c = dotForTimePeriodInput.Time_Period__c.addDays(7);
        // Reprepare List daysOffTrackersByPageNumber
        prepareDaysOffTrackersByPageNumber();
    }
    
    public void setWeek() {
        System.debug('DAYS_TO_ADD_FOR_FRIDAY---->');
        System.debug(DAYS_TO_ADD_FOR_FRIDAY);
        System.debug('before--->');
        System.debug(dotForTimePeriodInput.Time_Period__c);
        System.debug(dotForTimePeriodInput.Time_Period__c.toStartOfWeek());
        dotForTimePeriodInput.Time_Period__c = dotForTimePeriodInput.Time_Period__c
                .toStartOfWeek().addDays(DAYS_TO_ADD_FOR_FRIDAY);
        System.debug('After--->'); 
        System.debug(dotForTimePeriodInput.Time_Period__c);
        System.debug(dotForTimePeriodInput.Time_Period__c.toStartOfWeek());       
        // Reprepare List daysOffTrackersByPageNumber
        prepareDaysOffTrackersByPageNumber();
    }
    
    /*
     * @return List of DaysOffTracker according to currentPage
     */
    public List<DaysOffTracker> getSubordinatesDaysOffTrackers() {
        // List indexing is zero based so has to substract 1 from currentPage
        if (hasSubordinateUsers == true && daysOffTrackersByPageNumber != null && currentPage != 0)
            return daysOffTrackersByPageNumber.get(currentPage - 1);
        else
            return null;
    }
    
    public void goToNextPage() {
        currentPage++;
    }
    
    public void goToPreviousPage() {
        currentPage--;
    }
    
    /*
     * Prepare List daysOffTrackersByPageNumber
     */
    private void prepareDaysOffTrackersByPageNumber() {
        try {
            currentPage = 1;
            allDaysOffTrackers = new List<DaysOffTracker>();
            daysOffTrackersByPageNumber = new List<List<DaysOffTracker>>();
            
            // Get existing Days_Off_Tracker__c
            List<Days_Off_Tracker__c> subordinatesExistingDaysOffTrackers = [Select Id, Sales_Rep__c,
                    Sales_Rep__r.Name, Sick_Days__c
                    from Days_Off_Tracker__c where Sales_Rep__c in :subordinateUserIds
                    and Time_Period__c = :dotForTimePeriodInput.Time_Period__c];
            
            Map<ID, Days_Off_Tracker__c> userIdToDaysOffTrackerMap = new Map<ID, Days_Off_Tracker__c>();
            for (Days_Off_Tracker__c existingDaysOffTracker : subordinatesExistingDaysOffTrackers)
                userIdToDaysOffTrackerMap.put(existingDaysOffTracker.Sales_Rep__c, existingDaysOffTracker);
            
            // Go through every subordinate user
            for (User user : subordinateUsers) {
                Days_Off_Tracker__c existingDaysOffTracker = userIdToDaysOffTrackerMap.get(user.id);
                
                // If current subordinate has an existing Days_Off_Tracker__c then use it
                if (existingDaysOffTracker != null) {
                    allDaysOffTrackers.add(new DaysOffTracker(user.Name, user.Extension, 
                            existingDaysOffTracker));
                // Else use a new blank Days_Off_Tracker__c
                } else {
                    allDaysOffTrackers.add(new DaysOffTracker(user.Name, user.Extension, 
                            new Days_Off_Tracker__c(Sales_Rep__c = user.id,
                            Time_Period__c = dotForTimePeriodInput.Time_Period__c)));
                }
            }
            
            // Preparation of List daysOffTrackersByPageNumber starts
            List<DaysOffTracker> trackersList = new List<DaysOffTracker>();
            for (DaysOffTracker tracker : allDaysOffTrackers) {
                if (trackersList.size() == RESULTS_PER_PAGE) {
                    daysOffTrackersByPageNumber.add(trackersList);
                    trackersList = new List<DaysOffTracker>();
                }
                
                trackersList.add(tracker);
            }
            if (trackersList.size() > 0)
                daysOffTrackersByPageNumber.add(trackersList);
            // Preparation of List daysOffTrackersByPageNumber completed
        } catch(Exception ex) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, ex.getMessage()));
        }
    }
    
    /*
     * Used to get subordinates' role ids of given role id
     * @param parentId: Given role id
     * @return Set of subordinates' role ids
     */
    private Set<ID> getSubordinateRoleIds(ID parentId) {
        Set<ID> subordinateRoleIds = new Set<ID>();
        
        Set<ID> childrenRoleIds = roleIdToChildrenRoleIdsMap.get(parentId);
        if (childrenRoleIds == null)
            return subordinateRoleIds;
        
        subordinateRoleIds.addAll(childrenRoleIds);
        
        // Get subordinates' role ids of every child role id
        for (ID childrenRoleId : childrenRoleIds)
            subordinateRoleIds.addAll(getSubordinateRoleIds(childrenRoleId));
        
        return subordinateRoleIds;
    }
    
    // Need a private class to represent a Days_Off_Tracker__c
    // because for a blank Days_Off_Tracker__c we were not able to show user name
    private class DaysOffTracker {
        public String userName {get; private set;}
        public String Extension {get; private set;}
        public Days_Off_Tracker__c daysOffTracker {get; private set;}
        
        private DaysOffTracker(String userName, String Extension, Days_Off_Tracker__c daysOffTracker) {
            this.userName = userName;
            this.Extension = Extension;
            this.daysOffTracker = daysOffTracker;
        }
    }
}