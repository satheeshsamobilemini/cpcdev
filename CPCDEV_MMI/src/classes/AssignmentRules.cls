global class AssignmentRules{
    //check current running process.
    //if isNSCSweepRunning = true it means NSC Sweep process is running else lead assignment
    public static Boolean isNSCSweepRunning = false;
    
    // Used in test cases
    public static Boolean isTest = false;
  
    //public static String mailString;
  
    public static String HouseAccountUserName='Branch Account';
    public static String nscAccountUserName = 'NSC Account';
    //Added by Rajib
    public static String InboundSalesManager = 'Inbound Sales Manager';
    public static Map<String,User> mapInboundSalesManagers = new Map<String,User>();
    
    //Added by Akanksha for Story S-115147
    public static String userBrettPhillips = 'Brett Phillips';                   // TFS-2673
    public static String userSteveHaylett = 'Steve Haylett';
     //End by Akanksha for Story S-115147
     //Added by Akanksha for Story S-133210
     public static String userMartinBrown = 'Martin Brown';
     //End by Akanksha for Story S-133210
    public static String UKRole = 'NSC Team Leader -';
    public static Id HouseAccountUserId=null;
    public static map<String,String> mapMMIUKRoles = new map<String,String>();       // TFS-2673
    public static map <String,QueueSobject> mapUKleadQueues = new map<String,QueueSobject>();           // TFS-2673
   
    public static List<List<Contact>> allContacts=new List<List<Contact>>();
   
    
  public static Map<String,Branch_Lookup__c> allBranches= new Map<String,Branch_Lookup__c>();
  public static List<List<User>>allUsers=new List<List<User>>();
    
  
  public static List<Map<String,QueueSobject>> allLeadQueues= new List<Map<String,QueueSobject>> ();
    
  //These sets are used to filter contacts
  public static Set<String> firstNames = new Set<String>();
  public static Set<String> lastNames = new Set<String>();
  public static Set<String> postalCodes = new Set<String>();
  public static Set<String> streetNames = new Set<String>();
  public static Set<String> companyNames = new Set<String>();
  //public static Set<String> phones = new Set<String>();
  public static Set<String> projectIdSet = new Set<String>();
  public static Set<String> bidderPostalCOdes = new Set<String>();
 
  //This set add for PR-05697
  public static Set<String> numericPhones = new Set<String>();
  //Added by Najma for 39238
  public static Set<String> emailIds = new Set<String>();
    
   //This set add for 
   public static Set<String> postalCodesLeads = new Set<String>();
   public static Set<String> servicingBranchIds = new Set<String>();
   
   
   public static Set<String> setTerritories = new Set<String>();
   public static map<String, String> mapTerritories = new map<String, String>();
   public static map<String,String> mapBranches = new map<String,String>(); // Sales Restructure - 2015
   public static map<String,String> mapShippingSellingRegions = new map<String,String>(); // Sales Restructure - 2015
   public static map<String, User> mapTerritoryAndUser = new map<String, User>();
   public static map<String,User> mapBranchAndBMuser = new map<String,User>(); // Sales Restructure - 2015
   public static map<String,User> mapSellingRegionAndISMuser = new map<String,User>(); // Sales Restructure - 2015
   public static map<String,List<User>> mapBranchAndTerritoryUsers = new map<String,List<User>>(); // Sales Restructure - 2015
   public static map<String,String> mapLeadRecordType = new map<String,String>();
   public static map<String,User> mapAccTerritoryAndUser = new map<String,User>(); // Lead Routing --> SPOC Account
   
  //This set add for PR-05727
  public static Set<String> inActiveSalesAndNationalManagers = new Set<String>();
  public static Set<String> salesAndNationalManagerIdSet = new Set<String>();
  public static Set<String> activeSalesNationalManagerIdSet = new Set<String>();
  
  //commented for T-83472
  //T-33094
  //public static Set<String> timeZones = new Set<String>();
 // public static Map<String,List<User>> mapTimeZoneUsers = new Map<String,List<User>>();
  
  //T-79604
  public static Map<String,String> mapSellingRegions = new Map<String,String>();
  public static Map<String,List<User>> mapSellingRegionUsers = new Map<String,List<User>>();
  public static Map<String,List<User>> mapSellingRegionInboundUsers = new Map<String,List<User>>();
  public static List<User> HomeOwnerReps = new List<User>();       // TFS - New Lead Routing process
  
  public static Set<Id> leftParentAccountIds = new Set<Id>();
  public static Map<Id, Account> allAccounts=new Map<Id, Account>();
  
  public static List<Set<Id>> parentAccountIds= new List<Set<Id>>();
  public static Map<String,Account> accountNamesMap = new Map<String,Account>();
  public static Map<String , Account > accountNameforPhoneMap = new Map<String,Account>();
  public static Map<String , Account > accountNameforTerritoryMap = new Map<String,Account>();
  public static Map<Id , Account > PersonAccountsMap= new Map<Id,Account>();
  public static MAp<String,Glenigan_Project__c> allGleniganProjects = new Map<String,Glenigan_Project__c>();
  //private static List<User> UserUpdateList=new List<User>();
  private static Map<Id,User> UserUpdateList=new Map<Id,User> ();
  private static Map<Id, Account> AccountUpdateList = new Map<Id, Account>();
  private static List<Opportunity> OpportunityTaskList = new List<Opportunity>();
  
  private static Map<String,String> CountryBranchCodeMap = new Map<String,String>();
  private static Map<String,String> CountryTeamName = new Map<String,String>();
  
  private static Set<String> userRoleNameSet = new Set<String>();
  
  public static List<Lead> listLeadDuplicatesInBatch =  new List<Lead>();
  
  
  //Nikita 13th march
   public static list<Lead> leadConvertedToNSC = new list<Lead>();
   public static User NSCuser = new User();
   //Added by Akanksha for Story S-115147
   public static User userBP = new User();
   public static User userHS = new User();
   //End by Akanksha for Story S-115147
   //Added by Akanksha for Story S-133210
     public static User userMB = new User();
     //End by Akanksha for Story S-133210
   //Done for case # 00035523
   public static User integrationUser = new User();
   public static String INTERGRATION_USER = 'Integration User';
  public static Id queuid; //TFS 6866 
      
   
   
   
   static{
       /*
       for(User u : [Select id from User where name = :nscAccountUserName ]){
           NSCuser = u;
       }
       */
       //TFS 6866- returns queueid with name 'Lead Queue - 777 - NSC - UK'
       queuid=[Select Id, SobjectType, QueueId, Queue.Name From QueueSobject where Queue.Name='Lead Queue - 777 - NSC - UK' AND SobjectType='Lead'].QueueId;
       
       for(User u : [Select id, name from User where name = :nscAccountUserName OR name =: INTERGRATION_USER]){
           if(u.name == INTERGRATION_USER){
             integrationUser = u;   
             System.debug('@@@@@@integrationUser@@@@@@'+integrationUser);
           }else{
             NSCuser = u; 
             System.debug('@@@@@@NSCuser @@@@@@'+NSCuser );  
           }
       }    
        //Modified by Rajib to reduce SOQL query call.
       List<User> ListOfUser = [select id,name,isActive from User where isActive = True AND (name =: userBrettPhillips OR Name = :userSteveHaylett Or Name = :userMartinBrown)];
       for(User us : ListOfUser){
                  if(us.Name == userBrettPhillips){
                        userBP = us;
                  }
                 if(us.Name == userSteveHaylett){
                        userHS = us;
                  }
                  if(us.Name == userMartinBrown){
                        userMB = us;
                  }
                  
            
       }
        //Added by Akanksha for Story S-115147
       /*userCG = [select id,name from User where name =: userCallumGordon limit 1];  
       userHS = [select id,name from User where name =: userSteveHaylett limit 1];  
       //End by Akanksha for Story S-115147
       //Added by Akanksha for Story S-133210
       userMB = [select id,name from User where name =: userMartinBrown limit 1]; 
        //End by Akanksha for Story S-133210*/

        

   }
   
 // List of assignment logs
    private static List<LeadAssignmentHistory__c> assignmentLogsList;
    
    private static ID currentUserId;
    private static DateTime now;
    
    public static void FillCountryBranchTeamCodeMap(){
        system.debug('------AssignmentRules.FillCountryBranchTeamCodeMap-----Starts---------------');
        List<NSC_Team_Settings__c> nscTeamSettings = NSC_Team_Settings__c.getAll().Values(); 
        CountryBranchCodeMap = new Map<String,String>();
        CountryTeamName = new Map<String,String>();
        userRoleNameSet = new Set<String>();
        for(NSC_Team_Settings__c nscTeamSetting : nscTeamSettings){
            if(nscTeamSetting.Branch_Code__c != null){
                CountryBranchCodeMap.put(nscTeamSetting.Name,nscTeamSetting.Branch_Code__c);
            }
            if(nscTeamSetting.Team_Name__c != null){
                CountryTeamName.put(nscTeamSetting.Name,nscTeamSetting.Team_Name__c+' ');
                List<String> splitRoleNames =  nscTeamSetting.Team_Name__c.split('#');
                for(String rm : splitRoleNames){
                    userRoleNameSet.add(rm.replace('-', '').trim());
                } 
            }
        }
        System.debug(':::CountryBranchCodeMap::'+CountryBranchCodeMap);
        System.debug(':::CountryTeamName::'+CountryTeamName);
        System.debug(':::userRoleNameSet::'+userRoleNameSet);
        /*CountryBranchCodeMap.put('US','298');
        CountryBranchCodeMap.put('USA','298');
        CountryBranchCodeMap.put('CAN','298');
        CountryBranchCodeMap.put('CA','298');
        CountryBranchCodeMap.put('CANADA','298');
        CountryBranchCodeMap.put('UK','777');
        CountryBranchCodeMap.put('GB','777');
        CountryBranchCodeMap.put('UNITED KINGDOM','777');  
        CountryBranchCodeMap.put('GREAT BRITAIN','777');
        CountryBranchCodeMap.put('ENGLAND','777');
        CountryBranchCodeMap.put('ENG','777');
        CountryBranchCodeMap.put('IRELAND','709');*/
        
        //CountryTeamName = new Map<String,String>();
        /*CountryTeamName.put('US','Customer Sales Specialist - ');
        CountryTeamName.put('USA','Customer Sales Specialist - ');
        CountryTeamName.put('CA','Customer Sales Specialist - ');
        CountryTeamName.put('CAN','Customer Sales Specialist - ');
        CountryTeamName.put('CANADA','Customer Sales Specialist - ');
        CountryTeamName.put('UK','NSC Team Member - #NSC Team Leader - ');
        CountryTeamName.put('GB','NSC Team Member - #NSC Team Leader - ');
        CountryTeamName.put('UNITED KINGDOM','NSC Team Member - #NSC Team Leader - ');  
        CountryTeamName.put('GREAT BRITAIN','NSC Team Member - #NSC Team Leader - ');
        CountryTeamName.put('ENGLAND','NSC Team Member - #NSC Team Leader - ');
        CountryTeamName.put('ENG','NSC Team Member - #NSC Team Leader - ');
        CountryTeamName.put('IRELAND','NSC Team Member - #NSC Team Leader - ');*/
        
    }

    //Initialize the static Collections 
    private static List<Lead>  initialize(List<Lead> leadList)
    { 
      system.debug('------AssignmentRules.initialize(List<Lead> leadList)-----Starts---------------');
      
      addAllSetValues(leadList);
      //new added code for new logic in PR-06235
      allBranches = GetAllBranchLookups();
      //added for new lead routing requirement
      GetAllLeadRecordType();
      Set<String > branchCodes = new Set<String>{'298','777'};
      if(projectIdSet != null && projectIdSet.size() >0){
        branchCodes.add('709');
      }
      
      // Lead Routing .. for SPOC 
      if(leadList.size() > 0){ 
        FillCountryBranchTeamCodeMap();
        GetMatchingAccountsForLeads();
        allContacts = GetAllContacts();
        
        if(leftParentAccountIds!= null && leftParentAccountIds.size()>0){
            allAccounts = GetParentAccounts(leftParentAccountIds);
        }
        System.Debug('------allAccounts--------'+allAccounts);
      } 
      
         /////////////////////
      for(Lead newLead:leadList){
       // modified by Rajib For new new sales structure April 2014 release. 
       String zipCodeShipping = getZipCode(newLead);
       Branch_Lookup__c branchLookupObj = getBranchLookup(zipCodeShipping);
       if(branchLookupObj != null){
            newLead.Servicing_Branch_Id__c = branchLookupObj.Branch_Code__c;
            servicingBranchIds.add(newLead.Servicing_Branch_Id__c);
       }
        
       //String zipCode = getZipCodeFromBillingAddress(newLead); //Added according to new lead routing requirement
       String zipCode = getZipCodeFromShipping(newLead); // Sales Restructure - 2015
       //T-33094 prepare timezone set
       //String branchCode=getBranchCode(zipCode);
       //if(branchCode!=''){
       Branch_Lookup__c branchLookup = getBranchLookup(zipCode);
       system.Debug('******branchLookup*************'+branchLookup);
       if(branchLookup != null){
          /*newLead.Servicing_Branch_Id__c = branchLookup.Branch_Code__c;
          servicingBranchIds.add(newLead.Servicing_Branch_Id__c);*/
          //newLead.Territory__c = branchLookup.Territory__c;
          //newLead.Selling_Region__c = branchLookup.Selling_Region__c;
          setTerritories.add(branchLookup.Territory__c);
          mapTerritories.put(zipCode,branchLookup.Territory__c);
          branchCodes.add(branchLookup.Branch_Code__c);
          mapBranches.put(zipCode,branchLookup.Branch_Code__c); // Sales Restructure - 2015
          mapShippingSellingRegions.put(zipCode,String.valueOf(Integer.valueOf(branchLookup.Selling_Region__c))); // Sales Restructure - 2015
          //Commented for T-83472
          //timeZones.add(branchLookup.Time_Zone__c);
       }
      } 
      
      // Lead Routing -- for SPOC account
      if(allAccounts.keyset().size() > 0){
        string accZip = '';
        Branch_LookUp__c bLookUp = null; 
         for(account acc : allAccounts.values()){
             accZip = getZipCodeFromAccount(acc);
             bLookUp = getBranchLookup(accZip);
              if(bLookUp != null)
                setTerritories.add(bLookUp.territory__c); 
          }
      }
      
      //List<Lead> unassignedleadList = checkDupLead(leadList);   Sales Restructure 2015
      
      System.Debug('leadList*************'+   leadList );
      //System.Debug('leadList*************'+   unassignedleadList );
     
      //if(unassignedleadList.size() > 0){
      if(leadList.size() > 0){ 
       
        // TFS 2673 - UK new Lead Routing..
        mapMMIUKRoles.put('715','Middlesbourgh');
        mapMMIUKRoles.put('713','Immingham');
        mapMMIUKRoles.put('711','Carlisle');
        
        /////////////////////
        GetAllSellingRegions(branchCodes);
        allUsers = GetAllUsers(branchCodes);
        allLeadQueues=GetAllLeadQueues();
        HouseAccountUserId= getUserId(HouseAccountUserName);
        if(projectIdSet != null && projectIdSet.size()>0){
            allGleniganProjects = getProjectValues();
        } 

         }
    //return unassignedleadList;
    return leadList;
    }
    

    private static void initialize(String zipCode,String Country,String servicingBranchId){
       system.debug('------AssignmentRules.initialize(String zipCode,String Country,String servicingBranchId)----Starts---------------');
       FillCountryBranchTeamCodeMap();  
       allBranches=GetAllBranchLookups();
       
       if ((Country == null) || (Country == '')){
        Country = ' ';
       }
       
       /*zipCode = (zipCode == null ? '' : zipCode.trim());
       zipCode = getConvertedZipCode(zipCode, Country);*/
         
       String branchCode=getBranchCode(zipCode);
       Set<String > branchCodes = new Set<String>{'298','777'};
       if(branchCode!='')
       {
        branchCodes.add(branchCode);
       }
       //T-49647 Change method to pull users related to servicing branch Id also
       if(servicingBranchId != null && servicingBranchId != ''){
        branchCodes.add(servicingBranchId);
       }
       
       //Added by Rajib
       system.debug('----zipCode---------------'+zipCode);
       Branch_Lookup__c branchLookup = getBranchLookup(zipCode);
       system.debug('------branchLookup---------------'+branchLookup);
       if(branchLookup != null){
            setTerritories.add(branchLookup.Territory__c);
            mapTerritories.put(zipCode,branchLookup.Territory__c);
       }
       system.debug('------setTerritories---------------'+setTerritories);
       system.debug('------mapTerritories---------------'+mapTerritories);
       //Case 37207 Start
       
       GetAllSellingRegions(branchCodes);
       
       //Case 37207 End
       allUsers=GetAllUsers(branchCodes);
       HouseAccountUserId=getUserId(HouseAccountUserName);
    }
    
    public static void runAssignmentAlgo(List<Lead> objNewList, List<Lead> objOldList)
    {
      system.debug('------AssignmentRules.runAssignmentAlgo----Starts---------------');
      List<Lead> unassignedleadList = initialize(objNewList);
      assignmentLogsList = new List<LeadAssignmentHistory__c>();
      Boolean isHoliday = CheckHoliday();  // Sales Restructure - 2015
      String Businesshrs = isWithinBusinesshrs(isHoliday);   // Sales Restructure - 2015
      currentUserId = UserInfo.getUserId();
      now = DateTime.now();
      System.debug('------Line 290 ARcls -------' + unassignedleadList);       
      for(Lead newLead : unassignedleadList) 
      { 
        
        if(CheckLead(newLead)){
            applyAssignmentAlgoForLead(newLead,Businesshrs);
        }else{
            //Nikita 15March  
            if(isNSCLead(newLead)){
                System.debug('------Line 295 ARcls -------');           
                newLead = AssignmentRules.runAssignmentAlgoForLeadNSC(newLead,false);
            }else{
                System.debug('------Line 298 ARcls -------');           
                applyAssignmentAlgoForLead(newLead,Businesshrs);
            }
        }
      }
            
      //email('megh.agar@gmail.com','lead list >>>'+unassignedleadList);
      //update objNewList;
      system.debug('-----Line 306----'+assignmentLogsList.size());
      system.debug('-----Line 307----'+AccountUpdateList.values().size());
      system.debug('-----Line 308----'+UserUpdateList.values().size());
      
       if(AccountUpdateList.size() > 0)
         { update AccountUpdateList.values();   } 
      
       if(UserUpdateList.size() > 0)
         {  update UserUpdateList.values();     } 
         
      if(assignmentLogsList.size() > 0) 
         { insert assignmentLogsList;         } 
    }
    
     //This runs the Assignment algorithm for one lead
    private static void applyAssignmentAlgoForLead(Lead newLead, String Businesshrs)
    {
      system.debug('------AssignmentRules.runAssignmentAlgo----Starts---------------');
       if(newLead.Govt_Lead__c == true)     // TFS 5576
        { addLeadToLeadExceptionQueue(newLead,'Government',null,'');
          system.debug('GGGG lead' + newLead.OwnerID);
          return;
        }
       system.debug('----- Lead Owner Id -----------' + newLead.ownerId); 
       system.debug('----- Lead Owner Name -----------' + newLead.owner.Name); 
       if(newLead.ownerId == '00G80000001eDXS'){
           if(newLead.Delivery_Postal_Code__c != NULL){
               RouteToIsrOrItsManager(newLead);
               return;
            }
           else{
           addLeadToLead298ExceptionQueue(newLead,'298',null,'');
           return;
           }
        }
      //Boolean Assigned = false;              Sales Restructure 2015 
      Contact existingContact=SearchContacts(newLead);
      if(existingContact <> null){
          //if(isHouseAccount(existingContact.Account) || isNSCAccount(existingContact.Account)){
          /*if(isHouseAccount(existingContact.Account)){   // Sales Restructure 2015
             // assignLeadOwner(newLead,existingContact);
             newLead.Existing_Account_Owned_By_Branch__c = true;
          } 
          else{
            newLead.Existing_Account_Owned_By_Rep__c = true;
          }TFS-8960  --> doesnt require house account check*/
            if(existingContact.Account.isSPOC_Account__c){
                //RouteToIsrOrItsManager(newLead);
                //RouteToSPOCterritoryOwner(existingContact.Account.BillingPostalCode,existingContact.Account.BillingCountry,newLead);
                newLead.OwnerId = existingContact.Account.OwnerId;
                newLead.Assignment_Cause__c = populateLdOwnerInfo('445', null, null, existingContact, 'Assigned to the Territory Owner of SPOC Account');
                return;
            }
            
            else{
                addLeadToLead298ExceptionQueue(newLead,'298',null,'');
                return;
            }
                
            //AssignParentAccountOwner(newLead,existingContact.Account,existingContact,Businesshrs); // Sales Restructure 2015
            
            // Assignment log for current Custom Assignment
           /* 
            if(String.valueOf(newLead.OwnerId).startswith('005')) {
            assignmentLogsList.add(new LeadAssignmentHistory__c(AssignedBy__c=currentUserId,
                AssignedSalesRep__c=newLead.OwnerId, Assignment_Method__c='Round Robin',
                AssignmentTime__c=now, Lead_Source__c=newLead.LeadSource));
            }
          } 
            Assigned = true; */
        }
        else{
          
            Account acc = SearchAccount(newLead);
            system.debug('-----searched-acc--------------'+acc);
            if(acc <> null){
               /* if(isHouseAccount(acc)){
                  newLead.Existing_Account_Owned_By_Branch__c = true;   
                }else{
                  newLead.Existing_Account_Owned_By_Rep__c = true;  
                }TFS-8960  --> doesnt require house account check*/
                if(acc.isSPOC_Account__c ){
                //RouteToIsrOrItsManager(newLead);
                //RouteToSPOCterritoryOwner(acc.BillingPostalCode,acc.BillingCountry,newLead);
                newLead.OwnerId = acc.OwnerId;
                newLead.Assignment_Cause__c = populateLdOwnerInfo('480', null, acc, null, 'Assigned to the Territory Owner of SPOC Account');
                return; 
            }
            
            else{
                addLeadToLead298ExceptionQueue(newLead,'298',null,'');
                return;
            }
                
               //AssignParentAccountOwner(newLead,acc,null,Businesshrs);    // Sales Restructure 2015
              
              // Assignment log for current Custom Assignment
              /*
              if(String.valueOf(newLead.OwnerId).startswith('005')) {
                assignmentLogsList.add(new LeadAssignmentHistory__c(AssignedBy__c=currentUserId,
                AssignedSalesRep__c=newLead.OwnerId, Assignment_Method__c='Round Robin',
                AssignmentTime__c=now, Lead_Source__c=newLead.LeadSource));
                Assigned = true;  
              }  */           
            }else{ //Added for New Lead Routing April 1 2014 release
            system.debug('--New Lead--');
                if(CheckLead(newLead)){
                    NewLeadRoutingLogic(newLead,Businesshrs);
                    //Assigned = true;      Sales Restructure 2015
                }
            }
        }
        /*if(!Assigned){
           assignLeadOwner(newLead,existingContact);
        } */
      
    }
  /*  
    private static void assignLeadOwner(Lead newLead,Contact existingContact){
        system.debug('------AssignmentRules.assignLeadOwner----Starts---------------');
        system.debug('------ newlead.LastName---------------' + newlead.LastName);
        //changed on 01-02-2011 1 M -> 5M(PR-07971)  
        if(newLead.LeadSource != null && newLead.LeadSource.contains('Glenigan') && allGleniganProjects.containsKey(newLead.Glenigan_Project__c)){
             //assignSalesManager(newLead);//Added by Akanksha for Story S-115147
            assignLeadOwnerGlenigan(newLead, existingContact);
            //End by Akanksha for Story S-115147
        }else{ 
               if(newLead.leadSource <> null && newLead.LeadSource.contains('MMI UK Website'))
                { assignMMIukLeadOwner(newLead,existingContact); }     
               else 
               {  AssignSalesRep(newLead,existingContact); }
        }
    }
      //Added by Akanksha for Story S-115147 and then for Story S-133210      
      private static void assignLeadOwnerGlenigan(Lead newLead,Contact existingContact){
        system.debug('------AssignmentRules.assignLeadOwnerGlenigan----Starts---------------');
        String leadzipcode = getZipCodeFromBillingAddress(newLead);                             
        Branch_Lookup__c LeadBranch = getBranchLookup(leadzipcode);
         system.debug('------- leadBranch ----------' + LeadBranch);
         
        if(LeadBranch!=null){
        if(newLead.LeadSource != null && newLead.LeadSource.contains('Glenigan') && allGleniganProjects.containsKey(newLead.Glenigan_Project__c))
        {
            if(allGleniganProjects.get(newLead.Glenigan_Project__c).value__c <= 2000000)
            {  //system.debug('----------- userBP ------------' + userBP);
                //if(userBP != null)
              //    newLead.OwnerId = userBP.id;
                
                   AssignSalesRep(newLead,existingContact); 
            }
            else if(allGleniganProjects.get(newLead.Glenigan_Project__c).value__c > 2000000 && allGleniganProjects.get(newLead.Glenigan_Project__c).value__c <= 20000000)
            {
                 AssignSalesRep(newLead,existingContact);
            }
            else if(allGleniganProjects.get(newLead.Glenigan_Project__c).value__c > 20000000 && allGleniganProjects.get(newLead.Glenigan_Project__c).value__c <= 75000000)
            {
                assignSalesManager(newLead);
            }
            else if(allGleniganProjects.get(newLead.Glenigan_Project__c).value__c > 75000000)
            {
                if(newLead.Servicing_Branch_Id__c == '709' && userMB != null)
                {
                    newLead.OwnerId = userMB.id;
                }
                else
                {
                    assignSalesManager(newLead);
                }
            }
        }
     }else {   addLeadToLeadExceptionQueue(newLead,'700',null,'');
               return;
           }   
    }
   // for new UK Lead Routing for MMI UK Leads.. TFS-2673 issue    
   private static void assignMMIukLeadOwner(Lead newLead,Contact existingContact)
   { system.debug('------AssignmentRules.assignMMIukLeadOwner----Starts---------------');
     system.debug('------newLead---------'+newLead);
     
     String MMIukLeadzipcode = getZipCodeFromBillingAddress(newLead);
     system.debug('------zipCode----MMI-----'+ MMIukLeadzipcode);
     String MMIukLeaduserRole = '';
     String MMIukLeadbranchCode ='';
     
     Branch_Lookup__c MMIukLeadbranch = getBranchLookup(MMIukLeadzipcode);
     if(MMIukLeadbranch!=null){
        //MMIukLeaduserRole = 'Sales Rep - ';
        MMIukLeadbranchCode = MMIukLeadbranch.Branch_Code__c;
        system.debug('-------- Branch Code --------' + MMIukLeadbranchCode);
         if(mapMMIUKRoles.containskey(MMIukLeadbranchCode))
          { MMIukLeaduserRole = 'Sales Rep - ' + MMIukLeadbranchCode + ' - ' + mapMMIUKRoles.get(MMIukLeadbranchCode);
         system.debug('--- MMI lead UserRole ---' + MMIukLeaduserRole);
          }
         else { AssignSalesRep(newLead,existingContact);
                return; 
              }   
     } else{
        addLeadToLeadExceptionQueue(newLead,'700',null,'');
        return;
     } 
     
     User MMIselectedUser = selectSalesRep(MMIukLeadbranchCode,MMIukLeaduserRole,newLead.Country,newLead.leadSource);
     
     if(MMIselectedUser == null)
     {
         addLeadToLeadExceptionQueue(newLead,MMIukLeadbranchCode,MMIukLeadbranch,newLead.LeadSource);
     }
     else{
        newLead.OwnerID =  MMIselectedUser.ID;
        newLead.Assignment_Cause__c = populateLdOwnerInfo('545', null, null, null, 'Assigned SalesRep = '+ String.valueOf(MMIselectedUser));  //Existing Contact made null
        MMIselectedUser.LastLeadAllocation__c=Datetime.now();
         if(!UserUpdateList.containsKey(MMIselectedUser.ID))
          {
            UserUpdateList.put(MMIselectedUser.ID,MMIselectedUser);
          }
        //if(String.valueOf(newLead.OwnerId).startswith('005')) {
       //   assignmentLogsList.add(new LeadAssignmentHistory__c(AssignedBy__c=currentUserId,
      //    AssignedSalesRep__c=newLead.OwnerId, Assignment_Method__c='Round Robin',
     //     AssignmentTime__c=now, Lead_Source__c=newLead.LeadSource));
   // } 
         
     }   
   }   -- commented out as not used -- */
    //End Changes By Akanksha for Story S-115147 and then for Story S-133210
    //Megha
    public static List<List<Contact>> GetAllContacts(){
        system.debug('------AssignmentRules.GetAllContacts----Starts---------------');
        allContacts=new List<List<Contact>>();
       //parentAccountIds=new List<Set<Id>>();
       //comment this because matching account parent id is already added in this so copy this code in 'GetMatchingAccountsForLead()         
      
       Set<Id> accIds=new Set<Id>();
       Set<Id> processedAccIds = new Set<Id>(); 
       Set<Id> leftOverParentIds = new Set<Id>(); 
       
       String queryString = 'Select c.Owner.Name,c.OwnerId,c.MailingStreet, c.MailingPostalCode,' 
                                   + ' c.LastName, c.FirstName, c.Account.OwnerId,c.Account.Owner.Name,c.Account.IsPersonAccount,c.Account.isSPOC_Account__c,c.Account.MAR__c,c.Account.BillingPostalCode,'
                   + ' c.Account.ParentId, c.Account.Type,c.AccountId,c.Account.Owner.LastLeadAllocation__c,c.Account.Owner.Available_For_Leads__c,'
                   + ' c.Account.Name,Account.BillingCountry,  c.Account.phone, c.Account.NumericPhone__c,c.Account.Parent.ParentId, '
                   + ' c.Account.Parent.IsPersonAccount,c.Account.Parent.Name, c.Account.Parent.BillingPostalCode,' 
                   + ' c.Account.Parent.BillingCountry, c.Account.Parent.Owner.LastLeadAllocation__c, c.Account.Parent.Owner.Available_For_Leads__c,' 
                   + ' c.Account.Parent.OwnerId, c.Account.Parent.Type, c.Account.Parent.phone, c.Account.Parent.NumericPhone__c,c.Account.Parent.Servicing_Branch_Id__c, c.Account.Parent.Owner.Name,'
                   
                   + ' c.Account.Parent.Parent.ParentId, c.Account.Parent.Parent.IsPersonAccount, c.Account.Parent.Parent.Name,'
                   + ' c.Account.Parent.Parent.BillingPostalCode, c.Account.Parent.Parent.BillingCountry, '
                   + ' c.Account.Parent.Parent.Owner.LastLeadAllocation__c, c.Account.Parent.Parent.Owner.Available_For_Leads__c,'
                   + ' c.Account.Parent.Parent.OwnerId, c.Account.Parent.Parent.Type, c.Account.Parent.Parent.phone,'
                   + ' c.Account.Parent.Parent.NumericPhone__c,c.Account.Parent.Parent.Servicing_Branch_Id__c, c.Account.Parent.Parent.Owner.Name,c.Account.Parent.Parent.Parent.ParentId, '
                   
                   + ' c.Account.Parent.Parent.Parent.IsPersonAccount, c.Account.Parent.Parent.Parent.Name,' 
                   + ' c.Account.Parent.Parent.Parent.BillingPostalCode, c.Account.Parent.Parent.Parent.BillingCountry, '
                   + ' c.Account.Parent.Parent.Parent.Owner.LastLeadAllocation__c, c.Account.Parent.Parent.Parent.Owner.Available_For_Leads__c, '
                   + ' c.Account.Parent.Parent.Parent.OwnerId, c.Account.Parent.Parent.Parent.Type, c.Account.Parent.Parent.Parent.phone,' 
                   + ' c.Account.Parent.Parent.Parent.NumericPhone__c, c.Account.Parent.Parent.Parent.Servicing_Branch_Id__c, c.Account.Parent.Parent.Parent.Owner.Name,'
                   
                   + ' Account.Parent.Parent.Parent.Parent.ParentId, Account.Parent.Parent.Parent.Parent.IsPersonAccount, '
                   + ' Account.Parent.Parent.Parent.Parent.Name, Account.Parent.Parent.Parent.Parent.BillingPostalCode, '
                   + ' Account.Parent.Parent.Parent.Parent.BillingCountry, Account.Parent.Parent.Parent.Parent.Owner.LastLeadAllocation__c,'
                   + ' Account.Parent.Parent.Parent.Parent.NumericPhone__c,Account.Parent.Parent.Parent.Parent.Servicing_Branch_Id__c,' 
                   + ' Account.Parent.Parent.Parent.Parent.Owner.Available_For_Leads__c'
                   + ' from contact c'                                      
                   + ' Where c.FirstName in :firstNames'
                   + ' And c.LastName in :lastNames'
                   + ' And c.MailingPostalCode in :postalCodes'
                   + ' AND ( c.Account.Owner.Name <> :HouseAccountUserName AND c.Account.Owner.Name <> : nscAccountUserName ) AND c.Account.owner.isActive = true';
        if (isTest == true)
            queryString += ' limit 1';
        
        for(List<Contact> contacts : Database.query(queryString))
        {
          //Add First Level Accounts
          Map<Id,Account> mapAcc=new Map<Id,Account>();
          for(Contact con :contacts)
          {
            Account acc;
            if(con.Account !=null)
            {
              if(con.Account.Name <> HouseAccountUserName){
                Integer level=1; 
                mapAcc.put(con.AccountId,con.Account);
                acc = con.Account;     
                while(level<4 && acc != null && acc.parentid <> null && !processedAccIds.contains(acc.ParentId)){
                  if(acc.Parent != null && acc.Parent.Owner.Name <> HouseAccountUserName){  
                    mapAcc.put(acc.ParentId,acc.Parent);
                  }
                  acc = acc.Parent;
                  if(leftOverParentIds.contains(acc.parentid)){
                      leftOverParentIds.remove(acc.parentid);
                  }
                  level++;
                }   
                if(level == 4 && acc != null && acc.ParentId != null && (!processedAccIds.contains(acc.ParentId)) && (!leftOverParentIds.contains(acc.ParentId))){
                    leftOverParentIds.add(acc.ParentId);
                }
                if(mapAcc.size() > 200){
                    allAccounts.putAll(mapAcc);
                    mapAcc = new Map<Id,Account>();
                }    
           
              } 
           }
          }
          if(mapAcc.size() >0){
            allAccounts.putAll(mapAcc);
            mapAcc = new Map<Id,Account>();
          }
          allContacts.add(contacts);
        }
        if(leftOverParentIds.size()>0){   
            leftParentAccountIds.addAll(leftOverParentIds);
        }
        return allcontacts;
    }
     
    //get Matching Accounts
     public static void GetMatchingAccountsForLeads(){ 
      system.debug('------AssignmentRules.GetMatchingAccountsForLeads----Starts---------------');
      accountNamesMap = new Map<String,Account>(); 
      allAccounts=new Map<Id, Account>();
      leftParentAccountIds = new Set<Id>();
      Set<Id> processedAccIds = new Set<Id>(); 
      Set<Id> leftOverParentIds = new Set<Id>(); 
      Map<Id,Account> mapAcc=new Map<Id,Account>();
      system.debug('-----numericPhones---------'+numericPhones);
      system.debug('-----servicingBranchIds-----------'+servicingBranchIds);
      for(List<Account> accounts:[select Id , ParentId, IsPersonAccount,MAR__c, Name, BillingPostalCode, BillingCountry, isSPOC_Account__c, 
                                        Owner.LastLeadAllocation__c, Owner.Available_For_Leads__c, OwnerId, Type, phone, NumericPhone__c,Servicing_Branch_Id__c, Owner.Name,Territory__c,

                                        Parent.ParentId, Parent.IsPersonAccount, Parent.Name, Parent.BillingPostalCode, Parent.BillingCountry, 
                                        Parent.Owner.LastLeadAllocation__c, Parent.Owner.Available_For_Leads__c, Parent.OwnerId, Parent.Type, 
                                        Parent.phone, Parent.NumericPhone__c,Parent.Servicing_Branch_Id__c, Parent.Owner.Name,Parent.Territory__c,

                                        Parent.Parent.ParentId, Parent.Parent.IsPersonAccount, Parent.Parent.Name, Parent.Parent.BillingPostalCode, 
                                        Parent.Parent.BillingCountry, Parent.Parent.Owner.LastLeadAllocation__c, Parent.Parent.Owner.Available_For_Leads__c, 
                                        Parent.Parent.OwnerId, Parent.Parent.Type, Parent.Parent.phone, Parent.Parent.NumericPhone__c,Parent.Parent.Servicing_Branch_Id__c, Parent.Parent.Owner.Name,Parent.Parent.Territory__c,

                                        Parent.Parent.Parent.ParentId, Parent.Parent.Parent.IsPersonAccount, Parent.Parent.Parent.Name,
                                        Parent.Parent.Parent.BillingPostalCode, Parent.Parent.Parent.BillingCountry, 
                                        Parent.Parent.Parent.Owner.LastLeadAllocation__c, Parent.Parent.Parent.Owner.Available_For_Leads__c,
                                        Parent.Parent.Parent.OwnerId, Parent.Parent.Parent.Type, Parent.Parent.Parent.phone,
                                        Parent.Parent.Parent.NumericPhone__c, Parent.Parent.Parent.Servicing_Branch_Id__c,Parent.Parent.Parent.Owner.Name,Parent.Parent.Parent.Territory__c,

                                        Parent.Parent.Parent.Parent.ParentId, Parent.Parent.Parent.Parent.IsPersonAccount, Parent.Parent.Parent.Parent.Name, 
                                        Parent.Parent.Parent.Parent.BillingPostalCode, Parent.Parent.Parent.Parent.BillingCountry, 
                                        Parent.Parent.Parent.Parent.Owner.LastLeadAllocation__c, Parent.Parent.Parent.Parent.Owner.Available_For_Leads__c, 
                                        Parent.Parent.Parent.Parent.OwnerId, Parent.Parent.Parent.Parent.Type, Parent.Parent.Parent.Parent.phone, 
                                        Parent.Parent.Parent.Parent.NumericPhone__c,Parent.Parent.Parent.Parent.Servicing_Branch_Id__c, Parent.Parent.Parent.Parent.Owner.Name,Parent.Parent.Parent.Parent.Territory__c,

                                        Parent.Parent.Parent.Parent.Parent.ParentId, Parent.Parent.Parent.Parent.Parent.IsPersonAccount, 
                                        Parent.Parent.Parent.Parent.Parent.Name, Parent.Parent.Parent.Parent.Parent.BillingPostalCode, 
                                        Parent.Parent.Parent.Parent.Parent.BillingCountry, Parent.Parent.Parent.Parent.Parent.Owner.LastLeadAllocation__c, 
                                        Parent.Parent.Parent.Parent.Parent.Owner.Available_For_Leads__c, Parent.Parent.Parent.Parent.Parent.OwnerId, 
                                        Parent.Parent.Parent.Parent.Parent.Type, Parent.Parent.Parent.Parent.Parent.phone, 
                                        Parent.Parent.Parent.Parent.Parent.NumericPhone__c, Parent.Parent.Parent.Parent.Parent.Servicing_Branch_Id__c, Parent.Parent.Parent.Parent.Parent.Owner.Name,Parent.Parent.Parent.Parent.Parent.Territory__c

                                        
                                  from Account where owner.isActive = true and ((Account.Numericphone__c in :numericPhones and Account.Servicing_Branch_Id__c in : servicingBranchIds) 
                                  or (Name in :companyNames and BillingPostalCode in :postalCodes))]){          
        
        for(Account acc:accounts){
          // new lead routing logic
          if(acc != null && acc.Owner != null && acc.Owner.Name == HouseAccountUserName){
            if(acc.Territory__c != null){
                accountNameforTerritoryMap.put(acc.Territory__c, acc);
            }
          }
          if(acc.Owner.Name <> HouseAccountUserName && acc.Owner.Name <> nscAccountUserName){
        
                if(!processedAccIds.contains(acc.id )){
                      processedAccIds.add(acc.id);
                      PersonAccountsMap.put(acc.Id, acc);
                      acc = ProcessAccount(acc);
                      if(leftOverParentIds.contains(acc.id)){
                        leftOverParentIds.remove(acc.id);
                      }
                }
                Integer level=0;           
                while(level<5 && acc != null && acc.parentid <> null && !processedAccIds.contains(acc.ParentId )){
                      processedAccIds.add(acc.parentid);
                      if(acc.Parent != null && acc.Parent.Owner.Name <> HouseAccountUserName && acc.Owner.Name <> nscAccountUserName){
                        mapAcc.put(acc.parentid, acc.parent);
                      }
                      acc = ProcessAccount(acc.Parent);
                      //System.debug('---parent ----'+level+'---'+acc+'--'+leftOverParentIds);
                      if(acc != null && acc.parentid != null && leftOverParentIds.contains(acc.parentid)){
                        leftOverParentIds.remove(acc.parentid);
                      }
                      level++;
                }   
                if(mapAcc.size() > 200){
                    allAccounts.putAll(mapAcc);
                    mapAcc = new Map<Id,Account>();
                }
               if(level == 5 && acc.ParentId != null && (!processedAccIds.contains(acc.ParentId)) && (!leftOverParentIds.contains(acc.ParentId))){
                    leftOverParentIds.add(acc.ParentId);
               }
              
           
          }         
        }
      }
      if(mapAcc.size() > 0){
         allAccounts.putAll(mapAcc);
         System.debug('-------'+mapAcc);
         mapAcc = new Map<Id,Account>();
     }
     
      if(leftOverParentIds.size()>0){   
        leftParentAccountIds.addAll(leftOverParentIds);
      }   
    }
    
    private static Account processAccount(Account acc){
        system.debug('------AssignmentRules.processAccount----Starts---------------');
        if(acc != null && acc.Owner != null && acc.Owner.Name <> HouseAccountUserName){
            String zipCode = (acc.BillingPostalCode == null ? '' : acc.BillingPostalCode.trim());
            String country = (acc.BillingCountry == null ? '' : acc.BillingCountry.trim());
            String accName = acc.Name;
            String Key = accName.trim() + '|' + getConvertedZipCode(zipCode, country) ;
            accountNamesMap.put(Key , acc);             
            //Added by kirtesh
            //changed by Megha phone to NumericPhone for PR-05697
            String key2 = setKeyForAccountMatching(acc.NumericPhone__c,acc.servicing_Branch_Id__c);
            accountNameforPhoneMap.put(Key2, acc);
            
            return acc;
          } 
         
         return null;
    }
    
    private static string setKeyForAccountMatching(String numericPhone,String servicingBranch){
        system.debug('------AssignmentRules.setKeyForAccountMatching----Starts---------------');
        String key2 = '';
        if(numericPhone != null && numericPhone != ''){
           key2 = numericPhone;
        }if(servicingBranch != null && servicingBranch != ''){
            Key2 += '|' + servicingBranch;
        }
        return key2;
    } 
    //Fills the Accounts Collection - Megha
     @TestVisible
        private static Map<Id, Account> GetParentAccounts(Set<Id> ParentIds)
    {
        
      system.debug('------AssignmentRules.GetParentAccounts----Starts---------------');
        for(List<Account> accounts:[select  Id, Owner.LastLeadAllocation__c, Owner.Available_For_Leads__c, OwnerId, ParentId, Type, phone,NumericPhone__c from Account
         Where Id in :ParentIds and Owner.Name <> :HouseAccountUserName])
      {
         Map<Id, Account> accMap = new Map<Id, Account>();
         for(Account acc:accounts)
         {
            accMap.put(acc.Id, acc);
         }
         allAccounts.putAll(accMap);
             
       } 
       return allAccounts;
       
    }
    
    //Added by Rajib to update Territory and Selling region
    
    public static Map<String,Branch_Lookup__c> GetAllBranchLookupData(set<String> allPostalCodes)
    {       
        system.debug('------AssignmentRules.GetAllBranchLookupData----Starts---------------');
        Map<String,Branch_Lookup__c> allBrancheData =  new Map<String,Branch_Lookup__c>();
        if(allPostalCodes.size() > 0){  
            String dynamisBranchLookupQueryString = 'SELECT b.Plant_Code__c,b.Rollup_Plant__c,b.Territory__c,b.Selling_Region__c,b.Zip__c, b.Branch_Name__c, b.Branch_Code__c ,b.Country__c,'+
                                   ' b.NSC_Team__c, b.NSC_Team_Live__c,b.Sales_Manager_ID__c,b.National_Account_Manager_ID__c,b.Time_Zone__c  '+
                                   ' FROM Branch_Lookup__c b WHERE  b.Zip__c in : allPostalCodes ';
           System.debug('---Query----'+dynamisBranchLookupQueryString);      
           for(Branch_Lookup__c branch:Database.query(dynamisBranchLookupQueryString)){
                allBrancheData.put(branch.Zip__c, branch);
           }
        }
        return allBrancheData;
    }
    
    //Fills the Branch Lookup Collection
    private static Map<String,Branch_Lookup__c> GetAllBranchLookups()
    {       
        system.debug('------AssignmentRules.GetAllBranchLookups----Starts---------------');
        //Added for PR-05727
        salesAndNationalManagerIdSet = new Set<String>();            
        allBranches =  new Map<String,Branch_Lookup__c>();
        //new change by Megha
        Set<String> allPostalCodes = new Set<String>();
        allPostalCodes.addAll(postalCodes);   
        allPostalCodes.addAll(bidderPostalCodes);
           
        List<List<Branch_Lookup__c>> branchList=new List<List<Branch_Lookup__c>>();
        if(allPostalCodes.size() > 0){  
            String dynamisBranchLookupQueryString = 'SELECT b.Territory__c,b.Selling_Region__c,b.Zip__c, b.Branch_Name__c, b.Branch_Code__c ,b.Country__c,'+
                                   ' b.NSC_Team__c, b.NSC_Team_Live__c,b.Sales_Manager_ID__c,b.National_Account_Manager_ID__c,b.Time_Zone__c  '+
                                   ' FROM Branch_Lookup__c b WHERE  b.Zip__c in : allPostalCodes ';
            /*for(String postalCode : allPostalCodes){
              dynamisBranchLookupQueryString = dynamisBranchLookupQueryString +  ' b.Zip__c LIKE \''+ postalCode + '%\' OR ';
            }*/
           // dynamisBranchLookupQueryString = dynamisBranchLookupQueryString != '' ? dynamisBranchLookupQueryString.subString(0, dynamisBranchLookupQueryString.lastIndexOf('OR')) : dynamisBranchLookupQueryString;
             System.debug('---Query----'+dynamisBranchLookupQueryString);      
           for(Branch_Lookup__c branch:Database.query(dynamisBranchLookupQueryString)){
                allBranches.put(branch.Zip__c, branch);
                /*for(String postalCode : allPostalCodes){
                  if(currentZipCode.indexOf(postalCode) == 0){
                     if(!allBranches.containsKey(postalCode)){
                        allBranches.put(postalCode,branch);
                        allPostalCodes.remove(postalCode);
                        break;
                    }
                  } 
                }*/
                //subMap.put(branch.Zip__c, branch);
                if(branch.Sales_Manager_ID__c != null){
                    salesAndNationalManagerIdSet.add(branch.Sales_Manager_ID__c);
                    
                }
                if(branch.National_Account_Manager_ID__c != null){
                   salesAndNationalManagerIdSet.add(branch.National_Account_Manager_ID__c);
                }
               System.Debug('+++++ salesAndNationalManagerIdSet++++'+salesAndNationalManagerIdSet);
           }
        }
        System.debug('---------PR-07809--------'+allBranches);
        //added for PR-05727 and get all the user which is inactive sales and national manager
        return allBranches;
    }
    
    public static void GetAllSellingRegions(Set<String> branchCodes){       
        system.debug('------AssignmentRules.GetAllSellingRegions----Starts---------------');
        for(Selling_Region_Branch__c sellingRegionBranch : [Select Name , Selling_Region__c From Selling_Region_Branch__c Where Name IN : branchCodes]){
         mapSellingRegions.put(sellingRegionBranch.Name, sellingRegionBranch.Selling_Region__c);
       }
    }
     
    // Added for new lead routing
    public static void GetAllLeadRecordType(){       
        system.debug('------AssignmentRules.GetAllLeadRecordType----Starts---------------');
        for(RecordType rt : [Select r.SobjectType, r.Name, r.Id From RecordType r where r.SobjectType = 'Lead']){
          mapLeadRecordType.put(rt.Id,rt.Name);
       }
       system.debug('-----mapLeadRecordType---------------'+mapLeadRecordType);
    }
    
    
    //Fills the Users Collection
    public static List<List<User>> GetAllUsers(Set<String >branchCodes)
    {     
        system.debug('------AssignmentRules.GetAllUsers----Starts---------------');
        allUsers= new List<List<User>>();
        
        //T-33094
        Set<String> roles = new Set<String>();
        roles.addAll(Label.Lead_Send_to_NSC_User_Roles.split(','));
        
        //T-57803
        Set<String> inboundRoles = new Set<String>();
        inboundRoles.addAll(Label.Lead_Send_to_IB_User_Roles.split('#'));
        
        List<String> sellingRegions = mapSellingRegions.values();
        List<String> shippingSellingRegions = mapShippingSellingRegions.values(); // Sales Restructure - 2015
        
        String filterQuery = generateFilterQuery();
        System.debug(':::HouseAccountUserName:::'+HouseAccountUserName);
        System.debug(':::branchCodes:::'+branchCodes);
        System.debug(':::setTerritories:::'+setTerritories);
        //T-79604 modified query to include users for selling region
        String queryString = 'Select u.Id,u.Name, u.UserRole.Name,u.Branch_Id__c,u.Branch__c, u.LastLeadAllocation__c,u.LastOpptyAlocation__c,u.Available_For_Leads__c, u.isActive,u.NSC_TimeZone__c,u.Selling_Region__c,u.Territory__c,u.ManagerId,u.Manager.isActive,u.isHomeOwnerRep__c From User u'
                        + ' Where (' + filterQuery + ' and u.isActive=true and u.Branch_Id__c in :branchCodes) '
                        //+ ' or ( u.Available_For_Leads__c = true and u.isActive=true and u.userrole.Name in : roles and u.NSC_TimeZone__c IN : timeZones)'    
                        + ' or u.Name=:HouseAccountUserName or (id in : salesAndNationalManagerIdSet and isActive = true ) '
                        //T-57803
                        + ' or ( u.Available_For_Leads__c = true and u.isActive=true and u.userrole.Name in : inboundRoles)'
                        //New Lead Routing Logic
                        + ' or ( u.Territory__c in : setTerritories)'
                        + ' or (u.Selling_Region__c in : shippingSellingRegions and u.UserRole.Name like \'Inside Sales/Outside Sales%\')' // Sales Restructure 2015
                        + ' or ( u.UserRole.Name like \'Inbound Sales Manager%\')'
                         //T-79604
                         + ' or ( u.UserRole.Name like \'Sales Rep - %\')'
                        + ' or ( u.Available_For_Leads__c = true and u.isActive=true and u.Selling_Region__c IN : sellingRegions and user.userRole.Name IN : roles)' ;
        
        queryString += isNSCSweepRunning? ' order by LastOpptyAlocation__c ASC ' : ' order by LastLeadAllocation__c ASC ';
        if (isTest == true)
           queryString += ' limit 10';
        System.debug(':::::::query:::::::'+queryString); 
        for(List<User> users:Database.query(queryString))
        {
         
          allUsers.add(users);
         
          //add for resolve Too Many query exception 
          for(user u : users){
            //---create a map of territory and user for new lead routing logic
            System.debug('::::u:::'+u);
            if(u.isActive == true && u.UserRoleId != null && u.UserRole.Name != null && u.UserRole.Name.startsWith('Sales Rep -') && u.Territory__c != null && u.Available_For_Leads__c == true ){
                mapTerritoryAndUser.put(u.Territory__c,u);
            // Sales Restructure - 2015   
            if(u.Branch_Id__c != null){
               if(!mapBranchAndTerritoryUsers.containskey(u.Branch_Id__c)) 
                { mapBranchAndTerritoryUsers.put(u.Branch_Id__c,new List<User>{u}); }
               else { mapBranchAndTerritoryUsers.get(u.Branch_Id__c).add(u) ;} 
              }     
            }
            System.debug(':::::::mapTerritoryAndUser:::'+mapTerritoryAndUser);
             
            if(u.UserRole.Name != null && u.UserRole.Name.startsWith(InboundSalesManager)){
                mapInboundSalesManagers.put(u.Selling_Region__c,u);
            }
            System.debug('-----------mapInboundSalesManagers--------'+mapInboundSalesManagers); 
          // string salesUserId = String.valueOf(u.Id).subString(0,15);
           // Modified for MSM - 6
           string salesUserId = String.valueOf(u.Id);
           System.debug(':::::::salesUserId:::'+salesUserId); 
            if(salesAndNationalManagerIdSet.contains(salesUserId) && u.isActive){
              activeSalesNationalManagerIdSet.add(salesUserId);
            }
            
             //commented for T-83472
            /*//T-33094 prepare timezoneusermap
            if(u.Available_For_Leads__c == true && u.isActive == true && u.UserRoleId != null && roles.contains(u.UserRole.Name) && u.NSC_TimeZone__c != null){
                if(!mapTimeZoneUsers.containsKey(u.NSC_TimeZone__c))
                    mapTimeZoneUsers.put(u.NSC_TimeZone__c,new List<User>());
                mapTimeZoneUsers.get(u.NSC_TimeZone__c).add(u);
            }*/
            
            //T-79604 prepare sellingregionusermap
            if(u.Available_For_Leads__c == true && u.isActive == true && u.UserRoleId != null && roles.contains(u.UserRole.Name) && u.Selling_Region__c != null){
                if(!mapSellingRegionUsers.containsKey(u.Selling_Region__c))
                    mapSellingRegionUsers.put(u.Selling_Region__c,new List<User>());
                mapSellingRegionUsers.get(u.Selling_Region__c).add(u);
            }
            
            //MSM-2 prepare sellingregionusermap for Inbound team -- reused for HomeOwner lead routing logic - Sales Restructure 2015
            if(u.Available_For_Leads__c == true && u.isActive == true && u.UserRoleId != null && u.UserRole.Name != null && inboundRoles.contains(u.UserRole.Name) && u.Selling_Region__c != null){
                System.debug(':::::::Inbound :::::inboundRoles---------------::'+inboundRoles); 
                if(!mapSellingRegionInboundUsers.containsKey(u.Selling_Region__c))
                    mapSellingRegionInboundUsers.put(u.Selling_Region__c,new List<User>());
                mapSellingRegionInboundUsers.get(u.Selling_Region__c).add(u);
                System.debug(':::::::Inbound :::::mapSellingRegionInboundUsers---------------::'+mapSellingRegionInboundUsers);
            }
            
            // TFS - New Lead Routing Process -- logic to be removed for Sales Restructure 2015
            if(u.Available_For_Leads__c == true && u.isActive == true && u.isHomeOwnerRep__c)
            { HomeOwnerReps.add(u);   } 
            
            // Sales Restructure - 2015 -- BM users
            if(u.isActive == true && u.UserRoleId != null && u.UserRole.Name != null && u.UserRole.Name != '' && u.UserRole.Name.startsWith('Branch Manager -') && u.Branch_Id__c != null)
             { mapBranchAndBMuser.put(u.Branch_Id__c,u); }
             
            // Sales Restructure - 2015 -- ISM users
            if(u.isActive == true && u.UserRoleId != null && u.UserRole.Name != null && u.UserRole.Name != '' && u.UserRole.Name.startsWith('Inside Sales/Outside Sales') && u.Selling_Region__c != null)
             { mapSellingRegionAndISMuser.put(u.Selling_Region__c,u); } 
             
              // Lead Routing --> SPOC account 
           system.debug('----territory-------' + u.territory__c + u.isActive + u.UserRole.Name);
           if( u.Territory__c != NULL ){
           if(u.isActive && u.UserRole.Name.startsWith('Sales Rep -') && setTerritories.contains(u.Territory__c))
           { mapAccTerritoryAndUser.put(u.Territory__c,u); }
          }
          }     
        }
        System.debug(':::All User:::'+allUsers);
        return allUsers;
    }
    
    private static String generateFilterQuery(){
        system.debug('------AssignmentRules.generateFilterQuery----Starts---------------');
        String filterQuery = '( (u.UserRole.Name like \'Sales Rep%\') OR (u.UserRole.Name like \'Branch Manager%\')' ;
        for(String roleName : userRoleNameSet){
            filterQuery += ' OR (u.UserRole.Name like   \''+roleName+'%\')';
        }
        filterQuery += ' )';
        return filterQuery;
    }
    private static Id getUserId(String UserName)
    {
      system.debug('------AssignmentRules.getUserId----Starts---------------');
      Id UserId=null;
      for(List<User> users:allUsers)  
      {
        if(UserId==null)
        {
          for(User user:users)
          {
            if(user.Name==UserName)
            {
              UserId=user.Id;
              break;
            }
          }
        }
      }
      if(UserName == 'Branch Account' && UserId == null){
            for(User u : [select id from User where Name = : UserName limit 1]){
                UserId = u.id; 
            }
      }
      return UserId;
    }
    
     
    private static List<Map<String, QueueSobject>> GetAllLeadQueues()
    {       
        system.debug('------AssignmentRules.GetAllLeadQueues----Starts---------------');
        allLeadQueues= new List<Map<String, QueueSobject>>();
               
        String queryString = 'Select q.Queue.Name, q.QueueId, q.Id From QueueSobject q'
                        + ' Where q.Queue.Name like \'Lead%\' or q.Queue.Name like \'Government%\'';
        
        if (isTest)
          {   queryString += ' limit 1';  } 
        else  
          {   queryString += ' limit 50000';   }
        
        system.debug('------------------ queryString ---------------------' + queryString);
        
        for(List<QueueSobject> queues:Database.query(queryString))
        {
          Map<String, QueueSobject> queMap = new Map<String, QueueSobject>();
          for(QueueSobject que:queues)
          {
            if(que.Queue.Name.startswith('Lead'))  
            {   
              String[] arrStr=que.Queue.Name.split('-');
            
              queMap.put(arrStr[1].trim() , que);
            } 
           
            if(que.Queue.Name.startswith('Government')) 
            { 
                String[] arrStr2=que.Queue.Name.split(' ');
                queMap.put(arrStr2[0].trim() , que);  
            }
          }  
          allLeadQueues.add(queMap);
       }
    
                    
        return allLeadQueues;
    }
    
    
    //returns the Contact that matches the Lead Name and Address
    private static Contact SearchContacts(Lead newLead)
    {       
        system.debug('------AssignmentRules.SearchContacts----Starts---------------');
        Contact existingContact= null;
        Integer matchCount=0;
        String postalCode = '';
        for(List<Contact> contacts:allcontacts)
        {
          if (newLead.Delivery_Postal_Code__c != NULL){
            postalCode = newLead.Delivery_Postal_Code__c;
          }
          else{
            postalCode = newLead.PostalCode;
          }
          if(matchCount <= 1)
          {
            for(Contact contact:contacts)
            {
                //Changed by MKS - 2010.10.04
                //MMI Requested that we match Project Postal Code first (if available)
                //if(contact.FirstName == newLead.FirstName && contact.LastName == newLead.LastName && contact.MailingPostalCode == newLead.PostalCode)
                if(contact.FirstName == newLead.FirstName && contact.LastName == newLead.LastName && contact.MailingPostalCode == postalCode)
                {
                    existingContact=contact;
                    matchCount++;
                    if(matchCount > 1)
                    {
                        existingContact=null;
                        break;
                    }
                }
            }
          }
        }
        
        if(matchCount > 1)
        {
            //Also Compare with Street
            matchCount = 0;
            
            for(List<Contact> contacts : allcontacts)
            {
           
              if (newLead.Delivery_Postal_Code__c != NULL){
                postalCode = newLead.Delivery_Postal_Code__c;
              }
              else{
                postalCode = newLead.PostalCode;
              }           
           
              if(matchCount <= 1)
                {
                  for(Contact contact : contacts)
                    {
                        //Changed by MKS - 2010.10.04
                        //MMI Requested that we match Project Postal Code first (if available)
                        //if(contact.FirstName == newLead.FirstName && contact.LastName== newLead.LastName && contact.MailingPostalCode==newLead.PostalCode && contact.MailingStreet == newLead.Street )
                        if(contact.FirstName == newLead.FirstName && contact.LastName== newLead.LastName && contact.MailingPostalCode==PostalCode && contact.MailingStreet == newLead.Street )
                        {
                            existingContact = contact;
                            matchCount++;
                            if(matchCount > 1)
                            {
                                existingContact = null;
                                break;
                            }
                        }
                    }
                }
            }
        }
        
        return existingContact;
    }
    
    //Returns the BranchCode related to the Zip code
    private static String getBranchCode(String zipCode)
    {
          system.debug('------AssignmentRules.getBranchCode----Starts---------------');
          String branchCode='';
          Branch_Lookup__c branch = getBranchLookup( zipCode);
          if(branch!=null){
            branchCode = branch.Branch_Code__c;
          }
        // Added as a temporary fix to transition these branches -- will need to update assignment logic and zip lookup object at a later date.
        // 101, 102, 110, 121, 912, 914, 117, 903, 941, 955
        // 977, 956, 963, 968, 904, 120, 149, 909
        // We want any non-construction lead (Dodge, 360 Partners, Blue Book) that goes to any of the above branch to be routes to the NSC - Branch 298
        /*if ( ( (branchCode == '101') || (branchCode == '102') || (branchCode == '110') || (branchCode == '121') || (branchCode == '912') || (branchCode == '914') || (branchCode == '117') || (branchCode == '903') || (branchCode == '941') || (branchCode == '955') || (branchCode == '977') || (branchCode == '956') || (branchCode == '963') || (branchCode == '968') || (branchCode == '904') || (branchCode == '120') || (branchCode == '149') || (branchCode == '909') ) && ((leadSource != 'Dodge') && (leadSource != '360MobileOffice') && (leadSource != 'The Blue Book')) ) {
        
            branchCode = '298';
        
        }*/
        
        //System.debug('branchCode*********'+branchCode);
        return branchCode;
          
    }
    private static Branch_Lookup__c getBranchLookup(String zipCode)    
    {
         system.debug('------AssignmentRules.getBranchLookup----Starts---------------');
system.debug('@@@Mark@@@ Checking 1 zipCode Button' + zipCode);          
      Branch_Lookup__c branch;
      if (zipCode != null){
        zipCode = zipCode.toUpperCase();
        if(allBranches.containsKey(zipCode)){
           branch = allBranches.get(zipCode);
system.debug('@@@Mark@@@ Checking 2 zipCode Button' + branch);           
        }
   
      }
      System.debug('---Branch Code----'+zipCode+ '----'+branch);
      return branch;
        
    }
    
    @TestVisible
    private static Account getParentAccount(Account account)
    {
          system.debug('------AssignmentRules.getParentAccount----Starts---------------');
          Account acc=null;
          Id parentId = account.ParentId;
          while(parentId != null){
              if(allAccounts.containsKey(parentId)){
                 acc = allAccounts.get(parentId);
                 parentId = acc.ParentId;
                 system.debug('acc*********'+acc );
              }else{ 
                 break;
              }  
         }
         return acc;
     
    }
    
    //Retrieves the Owner of the Topmost Account in the Account Hierarchy and assigns it to the Lead Owner   
    public static void AssignParentAccountOwner(Lead newLead,Account Acc, Contact existingContact,String Businesshrs)
    {
        system.debug('------AssignmentRules.AssignParentAccountOwner----Starts---------------');
        //Account Acc= existingContact.Account;
        Account relatedAcc = Acc;
        Contact relatedContact = existingContact;
         if(relatedContact <> null){
           relatedAcc = null;   
         }
        /*if(!isHouseAccount(Acc)){ //condition added because of new lead routing doc April 1 2014 release
            //If account by a rep, route to that account
            if((isVIP_GOLD_PlatinumAccount(Acc)==True) && Acc.ParentId!=null)
            {
            
                Account parentAcc = getParentAccount(Acc);
                    system.debug('====parentAcc==='+parentAcc);
                if(parentAcc!=null)
                {
                  Acc = parentAcc;
                }
                
            } */
          if(Acc.isSPOC_Account__c || Acc.MAR__c){   // Sales Restructure 2015  
                system.debug('===newLead==='+newLead);
            newLead.OwnerId = Acc.OwnerId;
            //Case # 00037243 Start
            //newLead.Assignment_Cause__c = populateLdOwnerInfo('913', null, Acc, null, 'Assigned to Owner of the Topmost Account in the Account Hierarchy and assigns it to the Lead Owner');
            //Case # 00037243 End
            newLead.Assignment_Cause__c = populateLdOwnerInfo('1279', null, relatedAcc, relatedContact, 'Assigned to the Owner of SPOC Account');
            Acc.Owner.LastLeadAllocation__c=Datetime.now();
            if(!AccountUpdateList.containsKey(Acc.Id)) {
              AccountUpdateList.put(Acc.id, Acc); 
            }
        }else{
            //condition added because of new lead routing doc April 1 2014 release
            if(CheckLead(newLead)){
                NewLeadRoutingLogic(newLead,Businesshrs);
            }
        }
    }
    
    //Method added because of new lead routing doc April 1 2014 release
    public static void NewLeadRoutingLogic(Lead newLead, String Businesshrs){
        system.debug('------AssignmentRules.NewLeadRoutingLogic----Starts---------------');
        //Check if the lead is mobile office lead
        //String zipCode = getZipCodeFromBillingAddress(newLead);
        String zipCode = getZipCodeFromShipping(newLead);  // Sales Restructure - 2015
        Branch_Lookup__c branch = getBranchLookup(zipCode);
         /*if(branch == null || (branch != null && branch.Territory__c == null) ){
                addLeadToLead000ExceptionQueue(newLead,'000',branch,'');*/
         if(branch == null || (branch != null && branch.Territory__c == null) || (branch != null && (branch.Zip__c == null || branch.Zip__c == ''))){
                addLeadToLead298ExceptionQueue(newLead,'298',null,'');       
                
         }else if(branch != null){
         system.debug('---------------entered------------');
            if(isPurchaseLead(newLead)){ //change to Purchase Lead - TFS 5576,removed : isDodgeLead(newLead) - Sales Restructure 2015 
                //If it is a Purchase Lead, route to ISR based on Territory
                RouteToIsrOrItsManager(newLead);
            }else if(Businesshrs == 'nsc'){
                        addLeadToLead298ExceptionQueue(newLead,'298',null,''); 
                        }
                     else{ 
                        //After business hours logic
                        system.debug('----After NSC Business Hours---');
                        // Route to ISR or Its Owner
                        RouteToIsrOrItsManager(newLead);
                      }   
                    
                    
                    /* TFS-8960 -->HomeOwner not required , logic for nsc hours changed
                       if(isHomeOwner(newLead)){
                            //Route to IB team or Exception Queue
                            RouteToIbTeamOrExceptionQueue(newLead,true,BusinessHrs);              // TFS - 3654 : Sales Restructure 2015
                            //RouteToHomeownerReps(newLead);                             // TFS - New Lead Routing Process
                                    
                         }else{
                            if(Businesshrs == 'nsc'){                           if(Businesshrs == 'nsc'){
                                addLeadToLead298ExceptionQueue(newLead,'298',null,'');                              //within business hours logic
                                        // TFS -3654 : Sales Restructure 2015 [false to true]                               system.debug('----During NSC Business Hours---');
                            }else if(Businesshrs != 'weekend' || Businesshrs != 'nsc'){                             //Route to IB team or Exception Queue
                                RouteToIsrOrItsManager(newLead,null);                               RouteToIbTeamOrExceptionQueue(newLead,true,Businesshrs);         // TFS -3654 : Sales Restructure 2015 [false to true]
                            }else{
                                if(Businesshrs == 'weekend')
                                 { addLeadToLead298ExceptionQueue(newLead,'298',null,''); }
                                else{ 
                                //After business hours logic
                                system.debug('----After NSC Business Hours---');
                                // Route to ISR or Its Owner
                                RouteToIsrOrItsManager(newLead);
                              }  
                            }} }TFS-8960 -->HomeOwner not required , logic for nsc hours changed*/
                    
                    }
                }
       
      // Sales Restructure - 2015     
    
    
    //Method added because of new lead routing doc April 1 2014 release
    public static void RouteToIsrOrItsManager(Lead newLead){
        system.debug('------AssignmentRules.RouteToIsrOrItsManager----Starts---------------');
        //String zipCode = getZipCodeFromBillingAddress(newLead);
        String zipCode = getZipCodeFromShipping(newLead); // Sales Restructure - 2015
        
        String territoryOfLead = mapTerritories.get(zipCode);
        String branchOfLead = mapBranches.get(zipcode);    // Sales Restructure - 2015
        String SellingRegionOfLead = mapShippingSellingRegions.get(zipcode); // Sales Restructure - 2015
        
        system.debug('------mapTerritoryAndUser--------------'+mapTerritoryAndUser);
        User userObj = mapTerritoryAndUser.get(territoryOfLead);
        User BMuserObj = mapBranchAndBMuser.get(branchOfLead);
        User ISMuserObj = mapSellingRegionAndISMuser.get(SellingRegionOfLead);
        User selUser = null;
         
        system.debug('------userObj--------------'+userObj);
        if(userObj != null && userObj.isActive && userObj.Available_For_Leads__c){  
              selUser = userObj;  // Shipping Territory Owner
           }else{
               userObj = RouteToOtherIsr(branchOfLead);  // route to user in same branch but different Territory Owner                     
               //selUser = (userObj != null) ? userObj : ((BMuserObj != null) ? BMuserObj : ((ISMuserObj != null) ? ISMuserObj : null));
               selUser = (userObj != null) ? userObj : ((ISMuserObj != null) ? ISMuserObj : ((BMuserObj != null) ? BMuserObj : null)); //TFS 8435..
           }
      // assign owner to lead  
       if(selUser != null){
          newLead.OwnerId = selUser.Id; // assign lead to selected user
          newLead.Assignment_Cause__c = populateLdOwnerInfo('1343', null, null, null, 'Assigned Rep = '+ String.valueOf(selUser));
       }else{ addLeadToLeadExceptionQueue(newLead,'000',null,''); // Sales Restructure 2015
           /*if(assign000queue)
             { addLeadToLeadExceptionQueue(newLead,'000',null,''); }
           else{ addLeadToLead298ExceptionQueue(newLead,'298',null,'');   }   */
       } 
    }
    
    //Methos added for Lead Routing --> SPOC Territory Owner
    public static void RouteToSPOCterritoryOwner(string accZip, string accCountry, Lead newLead){
      system.debug('------AssignmentRules.RouteToSPOCterritoryOwner----Starts---------------');
        string accZipCode = getZipCodeConversion(accZip,accCountry);
        Branch_LookUp__c accBranch = getBranchLookup(accZipCode);
         if(accBranch != null && mapAccTerritoryAndUser.containskey(accBranch.Territory__c))
           newLead.OwnerId = mapAccTerritoryAndUser.get(accBranch.Territory__c).Id;        
    }
        
    //Method added because of new lead routing doc April 1 2014 release
    public static void RouteToIbTeamOrExceptionQueue(Lead newLead, Boolean isHomeOwnerLd, String BusinessHrs){
        system.debug('------AssignmentRules.RouteToIbTeamOrExceptionQueue----Starts---------------');
        //String zipCode = getZipCodeFromBillingAddress(newLead);
        String zipCode = getZipCodeFromShipping(newLead); // Sales Restructure - 2015    
        Branch_Lookup__c branch = getBranchLookup(zipCode);
        String branchCode = '';
        /*if(branch!=null){
            branchCode = branch.Branch_Code__c;
        }
        if(newLead.Delivery_Country__c != null && newLead.Delivery_Country__c.equalsIgnoreCase('Ireland')){
            branchCode = '709';
        } */
        //if(branchCode == ''){
        if(branch != null && branch.Selling_Region__c == null){
            //Add to Exception
            addLeadToLead000ExceptionQueue(newLead,'000',branch,''); // Sales Restructure 2015
        }else if(Businesshrs == 'weekend'){ // Sales Restructure 2015
           //Add to Exception
            addLeadToLead298ExceptionQueue(newLead,'298',null,'');
        }else{
            System.debug('::::::::::::IB::::::::');
            User salesRep = getInboundUserOfSellingRegion(branch, isHomeOwnerLd);             // TFS 3654
            if(salesRep != null){
                newLead.OwnerId=salesRep.Id;
                //Case # 00037243 Start
                newLead.Assignment_Cause__c = populateLdOwnerInfo('1794', null, null, null, 'Assigned SalesRep = '+ String.valueOf(salesRep));
                //Case # 00037243 End
                salesRep.LastLeadAllocation__c=Datetime.now();
                //update(newLead);
                //update salesRep;
                if(!UserUpdateList.containsKey(salesRep.Id))
                {
                    UserUpdateList.put(salesRep.Id,salesRep);
                }
                // Assignment log for current Custom Assignment
                
                if(String.valueOf(newLead.OwnerId).startswith('005')) {
                assignmentLogsList.add(new LeadAssignmentHistory__c(AssignedBy__c=currentUserId,
                AssignedSalesRep__c=newLead.OwnerId, Assignment_Method__c='Round Robin',
                AssignmentTime__c=now, Lead_Source__c=newLead.LeadSource));
               }    
            }else{
                //Add to Exception
                addLeadToLead298ExceptionQueue(newLead,branchCode,branch,'');
            }
        }
    }
   
   // Assign lead to HomeOwners 
   /*private static void RouteToHomeownerReps(Lead newLead)       
    {   
        User selUser = null;
        Datetime minDateTime=Datetime.now();     
        String lastAllocationFieldName = isNSCSweepRunning? 'LastOpptyAlocation__c' : 'LastLeadAllocation__c';  
        for(User user : HomeOwnerReps)
        { 
            if(minDateTime != null && user.Name != HouseAccountUserName && (user.get(lastAllocationFieldName) == null || minDateTime > (DateTime)user.get(lastAllocationFieldName))) {
                minDateTime = (DateTime)user.get(lastAllocationFieldName);
                selUser = user;
                 
            }
        }
       system.debug('----- selected HomeOwner rep -----' + selUser); 
        
       if(selUser != null)
        {   newLead.OwnerId = selUser.Id;
            newLead.Assignment_Cause__c = populateLdOwnerInfo('1368', null, null, null, 'Assigned SalesRep = '+ String.valueOf(selUser));
            selUser.LastLeadAllocation__c = Datetime.now();
            
            if(!UserUpdateList.containsKey(selUser.Id))
                {
                    UserUpdateList.put(selUser.Id,selUser);
                }
                // Assignment log for current Custom Assignment
                
                if(String.valueOf(newLead.OwnerId).startswith('005')) {
                assignmentLogsList.add(new LeadAssignmentHistory__c(AssignedBy__c=currentUserId,
                AssignedSalesRep__c=newLead.OwnerId, Assignment_Method__c='Round Robin',
                AssignmentTime__c=now, Lead_Source__c=newLead.LeadSource));
                }
        }else{
                 //Add to Exception
               addLeadToLead298ExceptionQueue(newLead,'298',null,'');
             }  
                
    } Sales Restructure 2015*/
    
    // Assign to Shipping Territory Owner in the same branch
    public static User RouteToOtherIsr(String branchOfLead){
      List<User> territoryUsers = mapBranchAndTerritoryUsers.get(branchOfLead);
      DateTime minDatetime = system.now();
      String lastAllocationFieldName = isNSCSweepRunning? 'LastOpptyAlocation__c' : 'LastLeadAllocation__c';
      User selectedUser = null;
      
       if(territoryUsers != null){ 
        for(User usr : territoryUsers)  
         {  if(usr != null && usr.isActive && usr.Available_For_Leads__c && (minDateTime > (DateTime)usr.get(lastAllocationFieldName) || (DateTime)usr.get(lastAllocationFieldName) == null))
              { minDateTime = (DateTime)usr.get(lastAllocationFieldName);
                selectedUser = usr;
              }
         }
        } 
        if(selectedUser != null)
          { selectedUser.LastLeadAllocation__c = DateTime.now();
               if(!UserUpdateList.containskey(selectedUser.Id))
               { UserUpdateList.put(selectedUser.Id,selectedUser); }
          }
          
      return selectedUser; 
     }    
    
    //Assign Sales rep to the Lead 
  /*private static void AssignSalesRep(Lead newLead,Contact existingContact)
    {
      system.debug('------AssignmentRules.AssignSalesRep----Starts---------------');
      system.debug('------newLead---------'+newLead);
      system.debug('------existingContact---------'+existingContact);
      String branchCode ='';
      String zipCode = ''; */
      /*if(newLead.Glenigan_Project__c != null && allGleniganProjects.get(newLead.Glenigan_Project__c).value__c > 2000000 && allGleniganProjects.get(newLead.Glenigan_Project__c).value__c <= 20000000){
         zipCode = getZipCodeBasedOnBillingZipShippingCountry(newLead);
         system.debug('------zipCode----UK-----'+zipCode);
      }else{*/
          //String zipCode=getZipCode(newLead); // Commented according to new lead routing Logic
      /*  zipCode = getZipCodeFromBillingAddress(newLead); // Added according to new lead routing Logic
          system.debug('------zipCode----US-----'+zipCode);
      //}
      Branch_Lookup__c branch = getBranchLookup(zipCode);
      if(branch!=null){
         branchCode = branch.Branch_Code__c;
      }
      if(newLead.Delivery_Country__c != null && newLead.Delivery_Country__c.equalsIgnoreCase('Ireland')){
        branchCode = '709';
      }
      if( branchCode == '' && !isMovingAndStorageLead(branch,newLead) )
      {
         //Add to Exception
          if(existingContact!=null)
          {
            existingContact.Account.OwnerId=HouseAccountUserId;
             if(!AccountUpdateList.containsKey(existingContact.Account.id)) {
                AccountUpdateList.put(existingContact.Account.id , existingContact.Account);  
             }              
              
          }
          
            addLeadToLeadExceptionQueue(newLead,'000',null,'');
           
        }
        else
        {
            User salesRep = getAvailableSalesRep(branchCode,branch,newLead.LeadSource,newLead.Country,newLead.industry,newLead);
            if(salesRep==null)
            {
                //Add to Exception
                if(existingContact!=null)
                {
                  existingContact.Account.Branch__c=branchCode;
                  existingContact.Account.OwnerId=HouseAccountUserId;
                  if(!AccountUpdateList.containsKey(existingContact.Account.id)) {
                    AccountUpdateList.put(existingContact.Account.id , existingContact.Account);  
                  }              
              
                }
                system.debug('---------newLead---------'+newLead);
                system.debug('---------branchCode---------'+branchCode);
                system.debug('---------branch---------'+branch);
                system.debug('---------newLead.LeadSource---------'+newLead.LeadSource);
                
                addLeadToLeadExceptionQueue(newLead,branchCode,branch,newLead.LeadSource);
                //update(newLead);
            }
            else
            {
                system.debug('====Test===345');
                newLead.OwnerId=salesRep.Id;
                //Case # 00037243 Start
                        newLead.Assignment_Cause__c = populateLdOwnerInfo('972', null, null, existingContact, 'Assigned SalesRep = '+ String.valueOf(salesRep));
                        //Case # 00037243 End
                salesRep.LastLeadAllocation__c=Datetime.now();
                //update(newLead);
                //update salesRep;
                if(!UserUpdateList.containsKey(salesRep.Id))
                {
                  UserUpdateList.put(salesRep.Id,salesRep);
                }
                // Assignment log for current Custom Assignment
                
                if(String.valueOf(newLead.OwnerId).startswith('005')) {
                assignmentLogsList.add(new LeadAssignmentHistory__c(AssignedBy__c=currentUserId,
                AssignedSalesRep__c=newLead.OwnerId, Assignment_Method__c='Round Robin',
                AssignmentTime__c=now, Lead_Source__c=newLead.LeadSource));
            }
        }
    }
    }  -- commented out as not used -- */
    
    //Searches for available sales Rep (changes related to NSC Lead Routing )
    public static User getAvailableSalesRep(String branchCode,Branch_Lookup__c branch,String leadSource,String leadCountry,String leadIndustry,Lead lead)
    {
      
        system.debug('------AssignmentRules.getAvailableSalesRep----Starts---------------');
        if(allUsers.isEmpty()|| allUsers.size()==0)
        {
            return null;
        }
        else
        {
          if(allUsers.get(0).isEmpty()|| allUsers.get(0).size()==0)
          {
            return null;
          }
        }
        User selectedUser=null;
        String userRoleName ='Sales Rep - '+ branchCode + ' - ';
        
        //T-57803        
        if(isMovingAndStorageLead(branch,lead)){
            userRoleName = Label.Lead_Send_to_IB_User_Roles;
        }else
        //Story # S-106421 Start
        //if(((leadSource != 'Dodge') && (leadSource != '360MobileOffice') && (leadSource != 'The Blue Book') && (leadSource != 'Glenigan')
        if(((leadSource != 'OB Campaign') && (leadSource != 'Dodge') && (leadSource != '360MobileOffice') && (leadSource != 'The Blue Book') && (leadSource != 'Glenigan')
        //Story # S-106421 End
           && (branch!=null) && (branch.NSC_Team_Live__c==true)) || (AssignmentRules.isNSCSweepRunning && leadCountry != '')){            
            
            String country = branch == null ? leadCountry.toUpperCase() : branch.Country__c.toUpperCase();
            
            System.debug(':::::::in UserRole Change'+leadSource);
            userRoleName = CountryTeamName.get(country)  ;//+ branch.NSC_Team__c;
            System.debug(':::::::leadIndustry::::::::'+leadIndustry);
             if(userRoleName != null && userRoleName.indexOf('#') > 0){//Added null check by  Najma Ateeq for #00051948
                String[] roles = userRoleName.split('#');
                userRoleName = '';
                System.debug(':::::::leadIndustry::::::::'+leadIndustry);
                if(country == 'US' || country == 'USA' || country == 'CA' || country == 'CAN' || country == 'CANADA'){
                    if((leadIndustry != null && !leadIndustry.startsWith('5') && !leadIndustry.startsWith('13')) || (leadIndustry == null)){
                        for(String userRoleNameStart : roles ){
                            userRoleName = userRoleName + userRoleNameStart + '#';
                        }
                        userRoleName = userRoleName.substring(0,userRoleName.length()-1);
                    }else{
                        userRoleName ='Sales Rep - '+ branchCode + ' - ';
                    }               
                }else
                  //T-57651 : modified UK check to include Purchase and Rent field of lead
                // (uk-changes) if( (lead != null && lead.Purchase__c == true && lead.Rent__c == false) && (country == 'UK' || country == 'IRELAND' || country== 'UNITED KINGDOM' || country == 'ENG' || country == 'ENGLAND' || country == 'GB' || country == 'GREAT BRITAIN' )){
               if(lead.LeadSource <> null && lead.LeadSource.contains('MMI UK Website') && ((lead.Purchase__c == true && lead.Rent__c == false) || lead.On_The_Go__c == True) && (country == 'UK' || country == 'IRELAND' || country== 'UNITED KINGDOM' || country == 'ENG' || country == 'ENGLAND' || country == 'GB' || country == 'GREAT BRITAIN' )){
                     userRoleName ='Sales Rep - '+ branchCode + ' - ';
                                     
                 }else {
                    for(String userRoleNameStart : roles ){
                        userRoleName = userRoleName + userRoleNameStart + branch.NSC_Team__c + '#';
                        
                    }
                    userRoleName = userRoleName.substring(0,userRoleName.length()-1);
                 }
            }
            else
            //T-57651 : modified UK check to include Purchase and Rent field of lead
            if( !(lead != null && lead.Purchase__c == true && lead.Rent__c == false) && (country == 'UK' || country == 'IRELAND' || country== 'UNITED KINGDOM' || country == 'ENG' || country == 'ENGLAND' || country == 'GB' || country == 'GREAT BRITAIN' )){
                 userRoleName = CountryTeamName.get(country)  + branch.NSC_Team__c;
                 if((lead != null && lead.Purchase__c == true && lead.Rent__c == false)){
                    userRoleName ='Sales Rep - '+ branchCode + ' - ';
                 }
                 
            }else if(country == 'US' || country == 'USA' || country== 'CA' || country == 'CAN' || country == 'CANADA'){
                if((leadIndustry != null && (leadIndustry.startsWith('5') || leadIndustry.startsWith('13')))){
                  userRoleName ='Sales Rep - '+ branchCode + ' - ';
                }
            } 
        } 
        System.debug(':::::::userRoleName'+userRoleName);
        /*if (branch.branch_Code__c == '777'){
            userRoleName = 'NSC Team Member - UK';
            
        }*/
        
        
        selectedUser = selectSalesRep(branchCode,userRoleName,leadCountry,leadSource);

        return selectedUser;
    }
    
    private static User selectSalesRep(String branchCode,String userRoleNames,String country,String leadSource){
        system.debug('------AssignmentRules.selectSalesRep----Starts---------------');
        User selectedUser=null;
        Datetime minDateTime=Datetime.now();
        System.debug('::::::::userRoleNames:::'+userRoleNames);
        String lastAllocationFieldName = isNSCSweepRunning? 'LastOpptyAlocation__c' : 'LastLeadAllocation__c';
        String[] roles = userRoleNames.split('#');
        
        Boolean notAssignLead = false;   // TFS 5345
        map<String,String> mapUsernWeekDay = getUserWeekDaydetails();  // TFS 5345
        
        for(List<User> users:allUsers)
        {
          for(User user : users)
          {  notAssignLead = false;       
             if(mapUsernWeekDay.containskey(user.Id))         // TFS 5345
             {  String dayOff = mapUsernWeekDay.get(user.Id);
                notAssignLead = checkUKrepDayOff(dayOff);
             }
             
             for(String userRoleNameStart : roles ){
                System.debug('::::::::roles:::'+roles);
                System.debug('::::::::user.UserRole.Name:::'+user.UserRole.Name);
                System.debug(':::lastAllocationFieldName::'+lastAllocationFieldName);
                system.debug('--- User Last Allocation Field Name ---'+ user.get(lastAllocationFieldName));
                system.debug('--- minDateTime ---'+minDateTime);
                system.debug('-- MMI UK Role' + !mapMMIUKRoles.containskey(branchCode));
                system.debug('-- Not Assigned Variable --'+ !notAssignLead);
                system.debug('-- user.Available_For_Leads__c --'+ user.Available_For_Leads__c);
                system.debug('-- User Name --' + user.Name);
                 if(user.UserRoleId != null)
                 { system.debug('-- Boolean user role name--'+ user.UserRole.Name.startsWith(userRoleNameStart)); }
                if(!mapMMIUKRoles.containskey(branchCode) && user.UserRoleId != null && user.UserRole.Name.startsWith(userRoleNameStart) && user.Available_For_Leads__c == True && user.Name != HouseAccountUserName && user.IsActive == true && minDateTime != null && !notAssignLead && (selectedUser == null || user.get(lastAllocationFieldName) == null || minDateTime > (DateTime)user.get(lastAllocationFieldName)))               // TFS-2673
               {
                 System.debug(':::IF::');
                 //if(user.get(lastAllocationFieldName) <> null){
                 minDateTime = (DateTime)user.get(lastAllocationFieldName);
                 //}
                 selectedUser=user;
                 break;
               }
               // new UK Lead 
               else if(mapMMIUKRoles.containskey(branchCode) && user.UserRoleId != null && user.UserRole.Name.startswith(userRoleNameStart) && user.Available_For_Leads__c == True && user.Name != HouseAccountUserName && user.IsActive == true && !notAssignLead)
                      {   selectedUser=user;
                           break;
                      }
               }
           }
          /*if(selectedUser<>null){
              break;
          }*/
        }
        if(selectedUser == null){
                 System.debug('Debug--selectSalesRep--------selectedUser=NULL');
        }else{
            System.debug('Debug--selectSalesRep--------selectedUser.Name' + selectedUser.Name );
        }
        return selectedUser;
    }
    
    //Checks if the Account is a house Account
    @TestVisible
    private static Boolean isHouseAccount(Account account) {
      system.debug('------AssignmentRules.isHouseAccount----Starts---------------');
      Boolean isHouseAccount=False;
        
      if(account.Owner.Name==HouseAccountUserName) {
        isHouseAccount=True;
      }
      return isHouseAccount;
    }
    
    //Method added because of new lead routing doc April 1 2014 release
    //Checks if the Lead owner is Branch Account    
    @TestVisible
    private static Boolean isLeadOwnerBranchAccount(Lead leadObj) {
      system.debug('------AssignmentRules.isLeadOwnerBranchAccount----Starts---------------');
      Boolean isBranchAccount = false;
        
      if(leadObj.Owner.Name == HouseAccountUserName) {
        isBranchAccount = true;
      }
      return isBranchAccount;
    }
    
    //Checks if the Account is a NSC Account
    /*private static Boolean isNSCAccount(Account account) {
      system.debug('------AssignmentRules.isNSCAccount----Starts---------------');
      Boolean isNSCAccount = False;
      if(account.Owner.Name == nscAccountUserName) {
        isNSCAccount = True;
      }
      return isNSCAccount;
    } Sales Restructure 2015*/
     
    //Checks if the Account is VIP/GOLD/Platinum account
    /*private static Boolean isVIP_GOLD_PlatinumAccount(Account acc) {
      system.debug('------AssignmentRules.isVIP_GOLD_PlatinumAccount----Starts---------------');
      system.debug('------acc------------'+acc);
      Boolean isVIP_GOLD_Platinum=False;
      
     if(acc.Type=='Customer - VIP+' ||acc.Type=='Customer - Gold+ National Account' ||acc.Type=='Customer - Platinum National Account')
        {
            isVIP_GOLD_Platinum = True;
        }
        
        return isVIP_GOLD_Platinum;
    } Sales Restructure 2015*/
    
     //Method added for TFS 5605 - New Lead Routing process
    @TestVisible
    private static Boolean isPurchaseLead(Lead leadObj) {
      system.debug('------AssignmentRules.isPurchaseLead----Starts---------------');
      boolean isPurchaseLead = false;
        
      //if(((leadObj.I_want_to__c !=null && leadObj.I_want_to__c == 'Buy It') || leadObj.Purchase__c == true) || ((leadObj.Lead_Category__c != null && leadObj.Lead_Category__c.containsIgnoreCase('Mobile offices')) || (leadObj.Storage_Category__c != null && leadObj.Storage_Category__c == 'Mobile Offices'))){
      //if(((leadObj.I_want_to__c !=null && leadObj.I_want_to__c == 'Buy It') || leadObj.Purchase__c == true) || ((leadObj.Lead_Category__c != null && (leadObj.Lead_Category__c.containsIgnoreCase('Mobile offices') || leadObj.Lead_Category__c.containsIgnoreCase('Mobile office'))) || (leadObj.Storage_Category__c != null && (leadObj.Storage_Category__c == 'Mobile Offices' || leadObj.Storage_Category__c == 'Office')) || leadObj.Mobile_Offices__c)){
        if((leadObj.I_want_to__c !=null && leadObj.I_want_to__c == 'Buy It') || leadObj.Purchase__c == true || leadObj.Transaction_Type__c == 'Sale'){ 
          isPurchaseLead = true;
      }
      system.debug('----isPurchaseLead---------'+isPurchaseLead);
      return isPurchaseLead;
    }
    
    //Method added because of new lead routing doc April 1 2014 release
    @TestVisible
    private static Boolean isMobileOfficeLead(Lead leadObj) {
      system.debug('------AssignmentRules.isMobileOfficeLead----Starts---------------');
      boolean isMobileOffLead = false;
        
      //if((leadObj.LeadSource == 'MMI US Website' && (leadObj.Storage_Category__c == 'Office' || leadObj.Mobile_Offices__c)) || (leadObj.LeadSource == '360MobileOffice' && leadObj.Lead_Category__c != null && leadObj.Lead_Category__c.containsIgnoreCase('Mobile office'))){
      if((leadObj.Lead_Category__c != null && (leadObj.Lead_Category__c.containsIgnoreCase('Mobile offices') || leadObj.Lead_Category__c.containsIgnoreCase('Mobile office'))) || (leadObj.Storage_Category__c != null && (leadObj.Storage_Category__c == 'Mobile Offices' || leadObj.Storage_Category__c == 'Office')) || leadObj.Mobile_Offices__c){  
        isMobileOffLead = true;
      }
      system.debug('----isMobileOffLead---------'+isMobileOffLead);
      return isMobileOffLead;
    } //Sales Restructure 2015
    
    //Method added because of new lead routing doc April 1 2014 release
    @TestVisible
    private static Boolean isHomeOwner(Lead leadObj) {
      system.debug('------AssignmentRules.isHomeOwner----Starts---------------');
      boolean isHomeOwnerLead = false;
        
      if((leadObj.Company == '' || leadObj.Company == null) || ( (leadObj.Company != '' && leadObj.Company != null) && (leadObj.Company.containsIgnoreCase('Personal') || leadObj.Company.containsIgnoreCase('Residential') || leadObj.Company.containsIgnoreCase('Homeowner') || leadObj.Company.containsIgnoreCase('Home owner') || leadObj.Company.containsIgnoreCase('None') || leadObj.Company.containsIgnoreCase('Self') )) ) {
        isHomeOwnerLead = true;
      }
      return isHomeOwnerLead;
    }
    
    //Method added because of new lead routing doc April 1 2014 release
    @TestVisible
    private static Boolean isDodgeLead(Lead leadObj) {
      system.debug('------AssignmentRules.isDodgeLead----Starts---------------');
      boolean isDodge = false;
       system.debug('----mapLeadRecordType---------'+mapLeadRecordType);
       system.debug('----leadObj.RecordTypeId---------'+leadObj.RecordTypeId); 
      if(leadObj.LeadSource == 'Dodge Report' || (mapLeadRecordType.containsKey(leadObj.RecordTypeId) && mapLeadRecordType.get(leadObj.RecordTypeId) == 'Dodge Lead')) {
        isDodge = true;
      }
      system.debug('----isDodge---------'+isDodge);
      return isDodge;
    }
    
    //Method added by Rajib for glenigen lead routing
    private static Boolean isGlenigenLead(Lead leadObj) {
       system.debug('------AssignmentRules.isGlenigenLead----Starts---------------');
       boolean isGlenigen = false;
       if(leadObj.LeadSource != null && leadObj.LeadSource.contains('Glenigan') && allGleniganProjects.containsKey(leadObj.Glenigan_Project__c)){
            isGlenigen = true;
       }
       system.debug('----isGlenigen---------'+isGlenigen);
       return isGlenigen;
    }
    
    //Method added for MMI UK Web Leads
    private static Boolean isMMIukWebLead(Lead newlead) {
       system.debug('------AssignmentRules.isMMIukWebLead----Starts---------------');
       boolean isMMIuk = false;
       if(newlead.LeadSource <> null && newLead.LeadSource.contains('MMI UK Website') && (newlead.Country == null || newLead.Country == '')){
            isMMIuk = true;
       }
       system.debug('----isMMIukWebLead---------'+isMMIuk);
       return isMMIuk;
    }
            
    private static void addLeadToLeadExceptionQueue(Lead lead,String branchCode,Branch_Lookup__c branch,String leadSource )
    {
        system.debug('------AssignmentRules.addLeadToLeadExceptionQueue----Starts---------------');
        system.debug('------branchCode--------'+branchCode);
       
        if((leadSource != 'Dodge') && (leadSource != '360MobileOffice') && (leadSource != 'The Blue Book')
            && (branch!=null) && (branch.NSC_Team_Live__c==true))
        {
            branchCode = CountryBranchCodeMap.get(branch.Country__c.toUpperCase());
        }
        //assign lead to Lead Exception-No SalesRep Queue
        Id queId=null;
        system.debug('------allLeadQueues--------'+allLeadQueues);
        system.debug('-------- Exact Branch Code ----------' + branchCode);
      
       for(Map<String,QueueSobject > qMap:allLeadQueues)
       {
        if(qmap.containsKey(BranchCode))
        { 
          queId=qmap.get(BranchCode).QueueId;  
           lead.OwnerId = queId;        
           //Case # 00037243 Start
             lead.Assignment_Cause__c = populateLdOwnerInfo('1700', null, null, null, 'Assigned Queue = '+String.valueOf(queId) + ' ,---Branch Code : '+BranchCode);
             //Case # 00037243 End    
          break;
        }
          
       }
      
      /*if(queId!=null) 
        {
          lead.OwnerId = queId;
        }   */     
 
    }
    
    //Added for new lead routing requirement april 1 2014 release
     private static void addLeadToLead298ExceptionQueue(Lead lead,String branchCode,Branch_Lookup__c branch,String leadSource )
    {
        system.debug('------AssignmentRules.addLeadToLead298ExceptionQueue----Starts---------------');
        branchCode = '298';
        Id queId = null;
        system.debug('------allLeadQueues--------'+allLeadQueues);
        for(Map<String,QueueSobject > qMap:allLeadQueues){
            system.debug('------qMap--------'+qMap);
            if(qmap.containsKey(BranchCode)){
                queId = qmap.get(BranchCode).QueueId;
                system.debug('------queId--------'+queId);
                lead.OwnerId = queId;
                system.debug('------lead.OwnerId--------'+lead.OwnerId);
                //Case # 00037243 Start
                lead.Assignment_Cause__c = populateLdOwnerInfo('1152', null, null, null, 'Assigned Queue = '+String.valueOf(queId) + ' ,---Branch Code : '+BranchCode);
                //Case # 00037243 End    
                break;
            }
          
        }
    }
    
    //Added for new lead routing requirement april 1 2014 release
     private static void addLeadToLead000ExceptionQueue(Lead lead,String branchCode,Branch_Lookup__c branch,String leadSource )
    {
        system.debug('------AssignmentRules.addLeadToLead000ExceptionQueue----Starts---------------');
        branchCode = '000';
        Id queId = null;
        system.debug('------allLeadQueues--------'+allLeadQueues);
        for(Map<String,QueueSobject > qMap:allLeadQueues){
            system.debug('------qMap--------'+qMap);
            if(qmap.containsKey(BranchCode)){
                queId = qmap.get(BranchCode).QueueId;
                system.debug('------queId--------'+queId);
                lead.OwnerId = queId;
                system.debug('------lead.OwnerId--------'+lead.OwnerId);
                //Case # 00037243 Start
                lead.Assignment_Cause__c = populateLdOwnerInfo('1152', null, null, null, 'Assigned Queue = '+String.valueOf(queId) + ' ,---Branch Code : '+BranchCode);
                //Case # 00037243 End    
                break;
            }
          
        }
    }
    
    
    //Methods of Account Assignment
    //Runs the Assignment algorithm for account
    webservice static Account runAssignmentAlgoForAccount(Id accountId, Boolean isSendToBranch)
    {
      system.debug('------AssignmentRules.runAssignmentAlgoForAccount----Starts---------------');
      system.debug('------accountId------'+accountId);
      Account account=[select Id, Owner.LastLeadAllocation__c, Owner.Available_For_Leads__c,Servicing_Branch_Id__c,  
              OwnerId,Owner.Name, IsPersonAccount, BillingPostalCode,BillingCountry,ParentId, Type ,ShippingCountry,
              ShippingPostalCode, phone , NumericPhone__c
              from Account
                Where Id =:accountId ];
        
        postalCodes=new Set<String>();
        String zipCode ='';
        String country = '';
        //update the code for PR-08906
        /*if(account.ShippingPostalCode != null && account.ShippingPostalCode.length() > 0){
            zipCode = getConvertedZipCode(account.shippingPostalCode, account.ShippingCountry);
            country = account.ShippingCountry;
            postalCodes.add(zipCode);
      //  }else if(account.billingPostalCode != null && account.BillingCountry.length() > 0){
        }else if(account.billingPostalCode != null && (account.BillingCountry != null && account.BillingCountry.length() > 0)){
            
            zipCode = getConvertedZipCode(account.billingPostalCode, account.BillingCountry);
            country = account.BillingCountry;
            postalCodes.add(zipCode);
        }*/
        
        //ramya changes
         /*if(account.billingPostalCode != null && (account.BillingCountry != null && account.BillingCountry.length() > 0)){
            
            zipCode = getConvertedZipCode(account.billingPostalCode, account.BillingCountry);
            country = account.BillingCountry;
            postalCodes.add(zipCode);
      //  }else if(account.billingPostalCode != null && account.BillingCountry.length() > 0){
        }else if(account.ShippingPostalCode != null && account.ShippingPostalCode.length() > 0){
            zipCode = getConvertedZipCode(account.shippingPostalCode, account.ShippingCountry);
            country = account.ShippingCountry;
            postalCodes.add(zipCode);
        }*/
        // Added by rajib
        zipCode = getZipCodeFromAccount(account);
        postalCodes.add(zipCode);
        if(account.BillingCountry != null && account.BillingCountry.length() > 0){
            country = account.BillingCountry;
        }
        //T-49647 Change method to pull users related to servicing branch Id also
        initialize(zipCode,country,account.Servicing_Branch_Id__c);             
                         
      List<List<Contact>> Contacts=GetContactsOfAccount(account.Id);
      //List<List<Opportunity>> opportunities=GetOpportunitiesOfAccount(account.Id); T-9340
      List<List<Opportunity>> opportunities = new List<List<Opportunity>>();
    //  if(isSendToBranch){ //T-21290
        opportunities = GetOpportunitiesOfAccount(account.Id); 
   //   }
      System.debug(':::opportunities::::'+opportunities);
      List<List<Task>> Tasks = GetTasksOfAccount(account.Id);
        
        //if( isHouseAccount(account))
        //{
            AssignSalesRepToAccount(account,Contacts,opportunities,Tasks,isSendToBranch);
            //AssignSalesRepToAccount(account,null,null);
            return account;
        //}
        
                
    }
    
    private static List<List<Contact>> GetContactsOfAccount(Id accountId)
    {       
        system.debug('------AssignmentRules.GetContactsOfAccount----Starts---------------');
        List<List<Contact>> contacts=new List<List<Contact>>();
                  
        for(List<Contact> lstContacts : [Select c.Owner.Name,c.OwnerId, c.AccountId From Contact c
                                      Where c.AccountId =:accountId]) {
        contacts.add(lstContacts);
      }
        return contacts;
    }
    
    //Methods of Account Assignment
    private static List<List<Opportunity>> GetOpportunitiesOfAccount(Id accountId)
    {       
        system.debug('------AssignmentRules.GetOpportunitiesOfAccount----Starts---------------');
        List<List<Opportunity>> allOpps=new List<List<Opportunity>>();
                  
        for(List<Opportunity> opps : [Select o.OwnerId, o.AccountId From Opportunity o
                                      Where o.AccountId = :accountId and stageName in ('Quoted - No Decision','Not Quoted')])
          {
            allOpps.add(opps);
          }
      
        return allOpps;
    }
    
    //Methods of Account Assignment
    private static List<List<Task>> GetTasksOfAccount(Id accountId)
    {       
        system.debug('------AssignmentRules.GetTasksOfAccount----Starts---------------');
        List<List<Task>> allTasks=new List<List<Task>>();
                  
        for(List<Task> relTasks : [Select Id, OwnerId, WhatId from Task Where ((Status != 'Completed') and (WhatId = :accountId))])
          {
            allTasks.add(relTasks);
          }
          
        for(List<Opportunity> opps : [Select o.OwnerId, o.AccountId From Opportunity o Where o.AccountId = :accountId])
          {
            for(List<Task> relTasks : [Select Id, OwnerId, WhatId from Task Where ((Status != 'Completed') and (WhatId in :opps))])
            {
              allTasks.add(relTasks);
            }
          }         
      
        return allTasks;
    }
    
     private static void AssignSalesRepToAccount(Account account,List<List<Contact>>contacts, List<List<Opportunity>> Opps, List<List<Task>> Tasks, Boolean isSendToBranch)
    {
      system.debug('------AssignmentRules.AssignSalesRepToAccount----Starts---------------');
      //String zipCode = (account.ShippingPostalCode == null ? (account.billingPostalCode == null ? '' :account.billingPostalCode.trim()): account.ShippingPostalCode.trim()); // commented by rajib
      String zipCode = (account.billingPostalCode == null ? (account.ShippingPostalCode == null ? '' :account.ShippingPostalCode.trim()): account.billingPostalCode.trim());
      //String shippingCountry = (account.ShippingCountry == null ? (account.billingCountry == null ? '' :account.billingCountry.trim()) : account.ShippingCountry.trim());
      String shippingCountry = (account.billingCountry == null ? (account.ShippingCountry == null ? '' :account.ShippingCountry.trim()) : account.billingCountry.trim());
      
        zipCode = getConvertedZipCode(zipCode, shippingCountry);
        //do Branch lookup and Assign SalesRep
//Case 37207 Start
//      String branchCode=getBranchCode(zipCode);         
        String branchCode;
        system.debug('------zipCode------------'+zipCode);
        Branch_Lookup__c branch = getBranchLookup(zipCode);
        system.debug('------branch------------'+branch);
        if(branch!=null){
        branchCode = branch.Branch_Code__c;
        }
//Case 37207 End    
        
        if(branchCode == '' && !isSendToBranch) {
            //Assign House Account
            account.OwnerId=HouseAccountUserId;
            update(account);                       
        }

        else
        {            
            User salesRep;
            // Updated T-15279 ( Send To NSC changes)
            if(isSendToBranch) {
                //T-49647 start
                //commented by rajib                
                /*if(branchCode != '') {
                    salesRep = getAvailableSalesRep(branchCode,null,'','','',null);                                   
                } else {
                    branchCode = account.Servicing_Branch_Id__c;
                }                
                if(salesRep == null && branchCode != null){
                    String userRoleName = 'Branch Manager - ' + branchCode;
                    //salesRep = selectSalesRep(branchCode,userRoleName,'',''); // commented by rajib
                 }*/  
                if(branch != null && branch.Territory__c != null){
                    salesRep = mapTerritoryAndUser.get(branch.Territory__c); // Added by rajib
                }
                if(salesRep == null){
                    throw new CustomException('No rep or manager is available at this location, please see your supervisor.');
                }
                //T-49647 end
//Case 37207 Start                            
              }else{            
                /*NSC_Team_Settings__c nscTeamSetting = NSC_Team_Settings__c.getInstance('US'); 
                if(nscTeamSetting != null && nscTeamSetting.Team_Name__c != null){
                    userRoleName =  nscTeamSetting.Team_Name__c + ' ';
                }*/   
               
                //salesRep = getAvailableSellingRegionUser(branch); // commented by rajib
                salesRep = getInboundUserOfSellingRegion(branch, false); // Added by rajib
                
//Case 37207 End      
            }            
            System.debug(':::::salesRep::::'+salesRep +'::::HouseAccountUserId::::'+HouseAccountUserId);
            if(salesRep==null)
            {
                //Assign House Account
                // commented by rajib
                /*account.Branch__c=branchCode;
                account.OwnerId=HouseAccountUserId;*/
                //Added by Rajib
                // Assign to IB Sales Manager Role
                System.debug('----------branch-------'+branch);
                System.debug('-------mapInboundSalesManagers----'+mapInboundSalesManagers);
                if(branch != null && mapInboundSalesManagers.containsKey(String.valueOf(branch.Selling_Region__c))){
                    User newOwner = mapInboundSalesManagers.get(String.valueOf(branch.Selling_Region__c));
                    account.OwnerId = newOwner.Id;
                    account.Branch__c = newOwner.Branch_Id__c;
                    update(account);
                }
                
            }
            else
            {
              //assignAccount,contacts and Opportunities to Sales rep
                
                // Added by Rajib
                //check user availability
                if(salesRep.Available_For_Leads__c){
                    //Assign to user
                    account.OwnerId = salesRep.Id;
                    account.Branch__c = salesRep.Branch_Id__c;
                }else{
                    if(salesRep.ManagerId != null && salesRep.Manager.isActive){
                        //Assign to user`s Manager
                        account.OwnerId= salesRep.ManagerId;
                        account.Branch__c = salesRep.Branch_Id__c;
                    }else{
                        account.OwnerId = salesRep.Id;
                        account.Branch__c = salesRep.Branch_Id__c;
                    }
                } 
                //account.OwnerId=salesRep.Id; // commented by rajib
                salesRep.LastLeadAllocation__c=Datetime.now();
                
                if(account.IsPersonAccount==False)
                {
                      for(List<Contact> lstContacts:contacts)
                      {
                        for(Contact contact:lstContacts)
                        {
                          contact.OwnerId=salesRep.Id;
                          
                        }
                        update(lstContacts);
                      }

                }

                for(List<Opportunity> lstOpps:Opps)
                {
                  for(Opportunity opp:lstOpps)
                  {
                    opp.OwnerId=salesRep.Id;
                    
                    // Create a new task to notify Sales Rep of this new Opportunity
                    OpportunityTaskList.add(opp);
                    
                  }
                  update(lstOpps);
                }

                for(List<Task> lstTasks:Tasks)
                {
                  for(Task tsk:lstTasks)
                  {
                    tsk.OwnerId=salesRep.Id;
                    
                  }
                  update(lstTasks);
                }
                
                account.isEmailNotify__c = True;  // TFS 3655..
                System.debug('------account------'+account);  
                update(account);
                update(salesRep);
                
                //Comment this out for now - the existing task created on Lead conversion will be owned by the new Account owner
                //LeadAssignTasks.processOpportunities(OpportunityTaskList);
                               
            }
        }
        
        // Assignment log for Custom Assignment
        
        if(String.valueOf(account.OwnerId).startswith('005')) {
       insert new LeadAssignmentHistory__c(AssignedBy__c=UserInfo.getUserId(),
                AssignedSalesRep__c=account.OwnerId, Assignment_Method__c='Round Robin',
                AssignmentTime__c=DateTime.now(), Lead_Source__c='Live Chat');
    }
    }
    
    
    /*When a new Lead is created, this method checks if the Lead.NumericPhone__c number matches an 
    existing Lead record or Lead.LastName and Lead.PostalCode match an existing record. 
    If a match is found, assign the new Lead to the owner of the matching lead
    Leads which aren't assigned are returned*/
    
    /*
    
        Updated the logic below to NOT try and match unknown and n/a
        We have been receiving a lot of Non-Selective query errors
    
    */
 /* Sales Restructure 2015   
    private static List<Lead> checkDupLead(List<Lead> leads) {
      system.debug('------AssignmentRules.checkDupLead----Starts---------------');
      system.debug('-----leads--------'+leads);
      System.debug('----Megha -debug---checkDupLead-numericPhones'+ numericPhones);
      System.debug('----Megha -debug---checkDupLead-lastNames'+ lastNames);
      System.debug('----Megha -debug---checkDupLead-postalCodesLeads'+ postalCodesLeads);
      System.debug('----Megha -debug---checkDupLead-servicingBranchIds'+ servicingBranchIds);
      
      System.debug('----Najma -debug---checkDupLead-emailIds'+ emailIds);
       HouseAccountUserId=getUserId(HouseAccountUserName);
      //Case # 00037243 Start on Apr 16, 2013 [no NSC Rep (Role names containing Business Development Specialist or Inbound Sale Specialist) or Branch Account user gets the Dodge Lead Source, regardless if it is a "Duplicate".]
      Set<String> NSCroles = new Set<String>();
      NSCroles.addAll(Label.Lead_Send_to_NSC_User_Roles.split(',')); // adding Business Development Specialist roles
      NSCroles.addAll(Label.Lead_Send_to_IB_User_Roles.split('#')); // adding Inbound Sale Specialist roles
      //Case # 00037243 End on Apr 16, 2013
      
      //Changed by Najma Ateeq for #00039238
       //Start of case  #00039238 by Najma Ateeq on 04/03
        List<Lead> matchingLeads = new List<Lead>(); -- SR */
        //Case # 00037243 Start on Apr 16, 2013
        //for(Lead matchLead : [Select id, Servicing_Branch_Id__c, lead_category__c ,OwnerId ,Email, phone ,NumericPhone__c,PostalCode , Auto_assign_Lead__c,LeadSource,LastName ,Company, Delivery_Postal_code__c,Country,Delivery_Country__c,On_The_Go__c  from Lead where isDeleted = false and IsConverted = false and Lead.Status != 'Dead Lead' and ((NumericPhone__c in :numericPhones And Servicing_Branch_Id__c in : servicingBranchIds ) or 
        // commentede by rajib
        /*for(Lead matchLead : [Select id, Industry, RecordTypeId ,Storage_Category__c , Servicing_Branch_Id__c, lead_category__c ,OwnerId ,Email, phone ,NumericPhone__c,PostalCode , Auto_assign_Lead__c,LeadSource,LastName ,Company, Delivery_Postal_code__c,Country,Delivery_Country__c,On_The_Go__c,Go_To_NSC_Rep__c from Lead where isDeleted = false and IsConverted = false and Lead.Status != 'Dead Lead' and ((NumericPhone__c in :numericPhones And Servicing_Branch_Id__c in : servicingBranchIds ) or
                                //(LastName in :lastNames and PostalCode in :postalCodesLeads and Email IN :emailIds)) and owner.isActive = true and Name!='']){
                                (LastName in :lastNames and PostalCode in :postalCodesLeads and Email IN :emailIds)) and (LeadSource != 'Dodge' OR owner.UserRole.Name NOT IN : NSCroles OR Owner.Name <> :HouseAccountUserName) and owner.isActive = true and Name!='' and OwnerId <> :HouseAccountUserId]){
                                //Case # 00037243 End on Apr 16, 2013   
                       matchingLeads.add(matchLead);            
          }*/
          // Added new lead duplicate check logic by Rajib
          /*-- SR for(Lead matchLead : [Select id, Industry, RecordTypeId ,Storage_Category__c , Servicing_Branch_Id__c, lead_category__c ,OwnerId ,Email, phone ,NumericPhone__c,PostalCode , Auto_assign_Lead__c,LeadSource,LastName ,Company, Delivery_Postal_code__c,Country,Delivery_Country__c,On_The_Go__c,Go_To_NSC_Rep__c,Glenigan_Project__c from Lead where isDeleted = false and IsConverted = false and Lead.Status != 'Dead Lead' and ((NumericPhone__c in :numericPhones AND PostalCode in :postalCodesLeads) OR (LastName in :lastNames AND Email IN :emailIds)) and (LeadSource != 'Dodge' OR owner.UserRole.Name NOT IN : NSCroles OR Owner.Name <> :HouseAccountUserName) and owner.isActive = true and Name!='' and OwnerId <> :HouseAccountUserId]){
                       matchingLeads.add(matchLead);            
          }
          //End of case  #00039238 by Najma Ateeq on 04/03
     system.debug('====Line 1388===='+ matchingLeads.size());
     if(matchingLeads.size() < 1){
        system.debug('-----no matching leads return-----'+leads);
      return leads;
     } 
     List<Lead> assignableLeads = new List<Lead>();                          
      for(Lead l : leads) {
        system.debug('---------- l.LastName ----------------'+ l.LastName);
        boolean foundMatch=false;
        boolean isNSCLead = isNSCLead(l); //T-33094
        for(Lead ml : matchingLeads) {  
        -- SR */
          /*
          
                NumericPhone, l.id <> ml.id, Servicing Branch Id
                
                OR
                
                Email, l.id <> ml.id, Servicing Branch Id
          
          */        
        
          //if((l.NumericPhone__c == ml.NumericPhone__c && l.id <> ml.Id && l.Delivery_Postal_code__c == ml.Delivery_Postal_code__c)|| (l.LastName == ml.LastName && l.PostalCode == ml.PostalCode && l.id <> ml.Id && l.Delivery_Postal_code__c == ml.Delivery_Postal_code__c)) { //found an exact match, assign the matching lead's owner to new lead.
          //T-33094 ( added NSC lead check )
            /* -- SR if(isNSCLead == isNSCLead(ml) && ((l.NumericPhone__c == ml.NumericPhone__c && l.id <> ml.Id && l.servicing_Branch_Id__c == ml.servicing_Branch_Id__c) || (l.Email != null && l.Email == ml.Email && l.servicing_Branch_Id__c == ml.servicing_Branch_Id__c &&  l.id <> ml.Id ))){
            system.debug('====Test====456');
            system.debug('---------- l.LastName ----------------'+ l.LastName);
            if(!isLeadOwnerBranchAccount(l)){ //condition added because of new lead routing doc April 1 2014 release
             l.OwnerId = ml.OwnerId;
             //Case # 00037243 Start
                         l.Assignment_Cause__c = populateLdOwnerInfo('1434', ml, null, null, 'Assigned through Duplicate lead');
                         //Case # 00037243 End 
            }else{
                if(CheckLead(l)){
                    NewLeadRoutingLogic(l);
                }
            }
             //remove lead lastname from set
             lastNames.remove(l.lastName);
             if(l.FirstName != null){
               firstNames.remove(l.FirstName);// firstNames.add(l.FirstName);
             }
             if(l.Company != null){
               companyNames.remove(l.Company);
             } 
             -- SR */
             /*String zipCode = getZipCode(l);
            
             if (zipCode != ''){ 
                postalCodes.remove(zipCode);
             }*/
             /* -- SR if (l.Street != ''){
                streetNames.remove(l.Street);
             }
             if (l.phone != null ){
                //phones.remove(l.Phone);
                numericPhones.remove(l.NumericPhone__c);
             }
             foundMatch = true;
             break;
          }
                               
        }
    
        if(foundMatch == false){
            
            assignableLeads.add(l);
        }
      } 
      //if(updatedList.size() > 0)
        //update updatedList;
       system.debug('-----last return-----'+leads);   
       system.debug('-----assignableLeads.size()-----'+ assignableLeads.size());   
       system.debug('-----assignableLeads-----'+ assignableLeads); 
      return assignableLeads; 
    } Sales Restructure 2015 */
  
    public static Boolean CheckLead(Lead newLead){
        system.debug('------AssignmentRules.CheckLead----Starts---------------');
        system.debug('-----mapLeadRecordType------------'+mapLeadRecordType);
        system.debug('------newLead.RecordTypeId--------------'+newLead.RecordTypeId);
        Boolean isMmiWebLead = false;
        //if(newLead.LeadSource == 'MMI US Website' || newLead.LeadSource == 'NDS Leads' || newLead.LeadSource == '360MobileOffice' || newLead.LeadSource == 'Dodge Report' || (mapLeadRecordType.containsKey(newLead.RecordTypeId) && mapLeadRecordType.get(newLead.RecordTypeId) == 'Dodge Lead')){
        if(newLead.LeadSource == 'MMI US Website' || newLead.LeadSource == 'NDS Leads' || newLead.LeadSource == '360MobileOffice' || newLead.LeadSource.contains('360')){
            isMmiWebLead = true;
        }
        return isMmiWebLead;
    }
  
  public static String getZipCode(Lead newLead){
    system.debug('------AssignmentRules.getZipCode----Starts---------------');
    system.debug('-----newLead------------'+newLead);
    system.debug('-----newLead.PostalCode------------'+newLead.PostalCode);
    system.debug('-----newLead.Delivery_Postal_Code__c------------'+newLead.Delivery_Postal_Code__c);
    String zipCode = (newLead.PostalCode == null ? '' : newLead.PostalCode.trim()) ;
    String Country = (newLead.Country == null ? '' : newLead.Country.trim());
      
    if(newLead.Delivery_Postal_Code__c != null){
      zipCode = newLead.Delivery_Postal_Code__c.trim(); 
    }

    if (newLead.Delivery_Country__c != null){
      Country = newLead.Delivery_Country__c.trim(); 
    }
    zipCode = getConvertedZipCode(zipCode, Country);
    return zipCode;
  }
  
  //Added by Rajib for glenigen routing
  public static String getZipCodeBasedOnBillingZipShippingCountry(Lead newLead){
    system.debug('------AssignmentRules.getZipCodeBasedOnBillingZipShippingCountry----Starts---------------');
    String zipCode = (newLead.Delivery_Postal_Code__c == null ? '' : newLead.Delivery_Postal_Code__c.trim()) ;
    String Country = (newLead.Country == null ? '' : newLead.Country.trim());
      
    if(newLead.PostalCode != null){
      zipCode = newLead.PostalCode.trim(); 
    }

    if (newLead.Delivery_Country__c != null){
      Country = newLead.Delivery_Country__c.trim(); 
    }
    zipCode = getConvertedZipCode(zipCode, Country);
    return zipCode;
  }
  
  // added by mitul for zipcode conversion according to country
  
   public static String getZipCodeConversion(String billingZip ,String country){
    system.debug('------AssignmentRules.getZipCode----Starts---------------');
    String zipCode = (billingZip == null ? '' : billingZip.trim()) ;
    String billingCountry = (country == null ? '' : country.trim());
     
    zipCode = getConvertedZipCode(zipCode, billingCountry);
    return zipCode;
  }
  
  
  // Added by Rajib
  public static String getZipCodeFromBillingAddress(Lead newLead){
    system.debug('------AssignmentRules.getZipCodeFromBillingAddress----Starts---------------');
    String zipCode = '';
    String Country = '';
    if(newLead.Delivery_Postal_Code__c != null){
      zipCode = newLead.Delivery_Postal_Code__c.trim(); 
    }

    if (newLead.Delivery_Country__c != null){
      Country = newLead.Delivery_Country__c.trim(); 
    }
    
    zipCode = (newLead.PostalCode == null ? '' : newLead.PostalCode.trim()) ;
    Country = (newLead.Country == null ? '' : newLead.Country.trim());
    if(isGlenigenLead(newLead) || isMMIukWebLead(newLead)){
        Country = 'UK';
    }
    zipCode = getConvertedZipCode(zipCode, Country);
    return zipCode;
  }
  
  // get zipcode for Delivery postal - Sales Restructure - 2015
  public static String getZipCodeFromShipping(Lead newLead){
    system.debug('------AssignmentRules.getZipCodeFromShippping----Starts---------------');
    String zipCode = '';
    String Country = '';
    
    if(newLead.Delivery_Postal_Code__c != null){ 
        zipCode = newLead.Delivery_Postal_Code__c.trim(); 
     }
     
    if(newLead.Delivery_Country__c != null){
       Country = newLead.Delivery_Country__c.trim();        
    } 
    
    zipCode = getConvertedZipCode(zipCode, Country); // fetch correct zipcode with country
    
    return zipCode; 
  }
   
  // Added by Rajib  
  public static String getZipCodeFromAccount(Account accObj){
    system.debug('------AssignmentRules.getZipCodeFromAccount----Starts---------------');
    String zipCode = (accObj.BillingPostalCode == null ? '' : accObj.BillingPostalCode.trim()) ;
    String Country = (accObj.BillingCountry == null ? '' : accObj.BillingCountry.trim());
    zipCode = getConvertedZipCode(zipCode, Country);
    return zipCode;
  }
  
  public static String getConvertedZipCode(String zip, String Country){
    system.debug('------AssignmentRules.getConvertedZipCode----Starts---------------');
    system.debug('------AssignmentRules.Country----Starts---------------'+Country);
    system.debug('------AssignmentRules.zip----Starts---------------'+zip);
    
    String zipCode = (zip == null ? '' : zip.trim()) ;
    String originalZip = '';
      
        
    if (zipCode != ''){ 
      if(Country!= null &&((Country.toUpperCase() =='CANADA') || (Country.toUpperCase() =='CA') || (Country.toUpperCase() =='CAN')|| (Country.StartsWith('c')) || (Country.StartsWith('C'))))
      {
        zipCode=zipCode.toUpperCase().subString(0,3);
      }
      else if (Country!= null && ((Country.toUpperCase() == 'GB') || (Country.toUpperCase() == 'UK') || (Country.toUpperCase() == 'UNITED KINGDOM') || (Country.toUpperCase() == 'GREAT BRITAIN') || (Country.toUpperCase() == 'ENGLAND') || (Country.toUpperCase() == 'ENG'))){
        
        //Remove White Space
        zipCode = zipCode.replace(' ', '');
        // new logic PR-07809
        originalZip = zipCode;
        while(zipCode.trim().length() > 0){
             if(zipCode.endsWith('0') || zipCode.endsWith('1') || zipCode.endsWith('2') || zipCode.endsWith('3') || zipCode.endsWith('4') || zipCode.endsWith('5') || zipCode.endsWith('6') || zipCode.endsWith('7') || zipCode.endsWith('8') || zipCode.endsWith('9')){
              break;
            }else{
              zipCode = zipCode.substring(0, (zipCode.length() - 1));
            }
        }
        
        // This line ensures that we use some part of the zip code if we received something
        if (zipCode.length() == 0 && originalZip.length() > 0){
            zipCode = originalZip;
        }
        
        /*if(zipCode.trim().length()>1){
            //zipCode = zipCode.subString(0, 4);
            
            // Trim the last 2 Chars
            zipCode = zipCode.substring(0, (zipCode.length() - 2));

        }*/
                
      } 
      
      // If a US Zip code, trim the +4 if it exists
      if (zipCode.length() > 5){
        zipCode = zipCode.subString(0, 5);
      }
      
    }
    System.debug('--PR-07809 zip code---'+zipCode);
    return zipCode;
  }
  
  //returns the Account that matches the Lead Name and Address
    private static Account SearchAccount(Lead newLead)
    {       
        system.debug('------AssignmentRules.SearchAccount----Starts---------------');
        Account existingAccount = null;
        //Added by Kirtesh
        //changed phone to NumericPhone__c for PR-05697
        
        string Key2 = setKeyForAccountMatching(newLead.NumericPhone__c,newLead.Servicing_Branch_Id__c);
        
        System.debug('--Key2--'+Key2);
        System.debug('--accountNameforTerritoryMap---'+accountNameforTerritoryMap);
        System.debug('--accountNameforPhoneMap---'+accountNameforPhoneMap);
        System.debug('--PersonAccountsMap---'+PersonAccountsMap);
        System.debug('--accountNamesMap---'+accountNamesMap);
        
        if( accountNameforPhoneMap.containsKey(Key2)){
           existingAccount = accountNameforPhoneMap.get(Key2); 
        }
        //Added according to new lead routing logic
        if(newLead.Territory__c != null && accountNameforTerritoryMap.containsKey(newLead.Territory__c)){
           existingAccount = accountNameforTerritoryMap.get(newLead.Territory__c); 
        }
        
        if(existingAccount <> null ){
            
            if(PersonAccountsMap.containsKey(existingAccount.Id)){
                existingAccount = PersonAccountsMap.get(existingAccount.Id);
            }

            return existingAccount;
            
            
        }
        
        if(newLead.Company <> null && newLead.Company <> ''){
            //String zipCode = getZipCode(newLead); // Commented according to new lead routing logic
            String zipCode = getZipCodeFromBillingAddress(newLead); // Added according to new lead routing logic

            String Key = newLead.Company.trim() + '|' + zipCode;

            system.debug('============= lead key =============' + key);
            system.debug('============= account key =============' + accountNamesMap.keyset());
            
            system.debug('============= Boolean check =============' + accountNamesMap.containsKey(Key));
            
            if(accountNamesMap.containsKey(Key)){
              
              existingAccount = accountNamesMap.get(Key); 

            }
  
        }
        
        if(existingAccount <> null){
            if(PersonAccountsMap.containsKey(existingAccount.Id)){
                existingAccount = PersonAccountsMap.get(existingAccount.Id);
            }
        }
        return existingAccount; //null
    
        
    }
    
    
    //Used to remove Duplicate Leads from Batch file 
     public  static List<Lead> RemoveDuplicateLeadfromBatch(List<Lead> newlistLead){
        system.debug('------AssignmentRules.RemoveDuplicateLeadfromBatch----Starts---------------');
        Set<String> keySet = new Set<String>();
        List<Lead> listLeadwithoutDuplicate = new List<Lead>();
        String keyPhone;
        String keyNameAndPostal;
        for (Lead instantLead : newListLead) {
        
            /*
                Match on:
                
                    NumericPhone
                    
                    OR
                    
                    LastName and Servicing Branch
          
            */
                    
            //keyPhone = '' + instantLead.phone;
            keyPhone = ''+instantLead.NumericPhone__c;
            keyNameAndPostal = '' + instantLead.LastName + instantLead.PostalCode;
            if (keySet.contains(keyPhone) || keySet.contains(keyNameAndPostal)){
                // Add to new list called: listLeadDuplicatesInBatch
                listLeadDuplicatesInBatch.add(instantLead); 
                continue;
            }   
           
            listLeadwithoutDuplicate.add(instantLead);
            keySet.add(keyPhone);
            keySet.add(keyNameAndPostal);
        }
        return listLeadwithoutDuplicate;
     }
     
      //new Logic for Glenigan updated by Akanksha for Story S-133210
 
     private static void assignSalesManager(Lead newLead){
      system.debug('------AssignmentRules.assignSalesManager----Starts---------------');
      system.debug('------newLead-------------'+newLead);
      String branchCode ='';
      // Commented for MSM 69
      /*newLead.Delivery_Postal_Code__c = newLead.Bidder_Postal_Code__c;
      newLead.Auto_Assign_Lead__c = false;*/
      // Modified by Rajib for new sales structure release April 2014
      String zipCodeShipping = getZipCode(newLead);
      system.debug('------zipCodeShipping--------------'+zipCodeShipping);
      Branch_Lookup__c branchObj = getBranchLookup(zipCodeShipping);
      if(branchObj!=null){
        newLead.Servicing_Branch_Id__c = branchObj.Branch_Code__c;
      }
      String zipCode = getZipCodeFromBillingAddress(newLead); // Added According to new lead routing logic
      system.debug('------zipCode--------------'+zipCode);
      Branch_Lookup__c branch = getBranchLookup(zipCodeShipping);
      system.debug('------branch--------------'+branch);
      if(branch!=null){
        //newLead.Servicing_Branch_Id__c = branch.Branch_Code__c;
        if(allGleniganProjects.containsKey(newLead.Glenigan_Project__c)){
            //changed on 01-02-2011 1M -> 5M, 5M -> 30M (PR-07971)
            if(allGleniganProjects.get(newLead.Glenigan_Project__c).value__c >=20000000 && allGleniganProjects.get(newLead.Glenigan_Project__c).value__c <= 75000000){
                if(branch.Sales_Manager_ID__c!=null && activeSalesNationalManagerIdSet.contains(branch.Sales_Manager_ID__c)){
                    system.debug('====Test===990');
                    newLead.OwnerId = branch.Sales_Manager_ID__c;
                    //Case # 00037243 Start
                    newLead.Assignment_Cause__c = populateLdOwnerInfo('1638', null, null, null, 'Assigned to SalesManager = '+String.valueOf(branch.Sales_Manager_ID__c) + ' ,---Branch LookUp : '+String.valueOf(branch));
                    //Case # 00037243 End
                }else{
                  system.debug('====Sales Manager Exception ======');
                    addLeadToLeadExceptionQueue(newLead,branch.Branch_Code__c,branch,newLead.LeadSource);
                }
            }else if (allGleniganProjects.get(newLead.Glenigan_Project__c).value__c >75000000){
                if( branch.National_Account_Manager_ID__c != null && !inActiveSalesAndNationalManagers.contains(branch.National_Account_Manager_ID__c)){
                    system.debug('====Test===4356');
                    newLead.OwnerId = branch.National_Account_Manager_ID__c;
                    //Case # 00037243 Start
                    newLead.Assignment_Cause__c = populateLdOwnerInfo('1638', null, null, null, 'Assigned to National_Account_Manager_ID__c = '+String.valueOf(branch.National_Account_Manager_ID__c) + ' ,---Branch LookUp : '+String.valueOf(branch));
                    //Case # 00037243 End
                }else{
                    addLeadToLeadExceptionQueue(newLead,branch.Branch_Code__c,branch,newLead.LeadSource);
                }
            }
        }
      }else {
        if(newLead.Delivery_Country__c != null && newLead.Delivery_Country__c.equalsIgnoreCase('Ireland')){
            addLeadToLeadExceptionQueue(newLead,'709',branch,newLead.LeadSource);
        }else{
            addLeadToLeadExceptionQueue(newLead,'000',null,'');
        }
     }
   }
  //End by Akanksha for Story S-133210
   
   
   private static Map<String,Glenigan_Project__c> getProjectValues(){ 
      system.debug('------AssignmentRules.getProjectValues----Starts---------------');
      Map<String,Glenigan_Project__c> tempProjectsMap=new Map<String,Glenigan_Project__c>();
      String queryString = 'Select Id,value__c,Ptpcode__c from Glenigan_Project__c where id in : projectIdSet ';
      if (isTest == true)
          queryString += ' limit 2';
      for(Glenigan_Project__c GleniganProj  : Database.query(queryString)){
         tempProjectsMap.put(GleniganProj.id,GleniganProj);
         
        }
        return tempProjectsMap;
   }
   private static void addAllSetValues(List<Lead> leads){
        system.debug('------AssignmentRules.addAllSetValues----Starts---------------');
        for(Lead l : leads) {
        //changed for PR-05697
            if(l.NumericPhone__c != null && l.NumericPhone__c != ''){
            //phones.add(l.Phone);
                 numericPhones.add(l.NumericPhone__c);
            }
            if(l.LastName != null && l.LastName != '' && l.LastName.toLowerCase() != 'unknown' && l.LastName.toLowerCase() != 'n/a'){
                 lastNames.add(l.LastName);
            }
            if(l.PostalCode != null && l.PostalCode != ''){
                postalCodesLeads.add(l.PostalCode);
            } 
             //Added by Najma Ateeq for 39238
            system.debug('-========Email Ids======'+l.Email);
            if(l.Email != null && l.Email != ''){
                emailIds.add(l.Email);
            }
            if(l.FirstName != null && l.FirstName != '' && l.FirstName.toLowerCase() != 'unknown' && l.FirstName.toLowerCase() != 'n/a'){
                firstNames.add(l.FirstName);
            }
            if(l.Company != null && l.Company != '' && l.Company.toLowerCase() != 'unknown' && l.Company.toLowerCase() != 'n/a'){
                companyNames.add(l.Company); 
            }
        
            //String zipCode = getZipCode(l); // commented according to new lead routing requirement
            String zipCode = getZipCodeFromBillingAddress(l); // Added according to new lead routing requirement
            if (zipCode != ''){ 
                postalCodes.add(zipCode);
            }
            //MSM 69
            String delZipCode = getZipCode(l);
            if (delZipCode != ''){ 
                postalCodes.add(delZipCode);
            }
            
            System.debug('---postalCodes---'+postalCodes);
            if (l.Street != '' && l.Street != ''){
                streetNames.add(l.Street);
            }
            if(l.leadSource != null &&  l.leadSource.contains('Glenigan') && l.Glenigan_Project__c != null){
                projectIdSet.add(l.Glenigan_Project__c);
                String zipCode1 = getConvertedZipCode(l.Bidder_Postal_Code__c,l.Delivery_Country__c);
            if (zipCode1 != ''){ 
                bidderPostalCodes.add(zipCode1);
            }
        }
      }
      
      // Lead Routing --> SPOC account 
      if(allAccounts.keyset().size() > 0){
        string accZipCode = ''; 
         for(account accObj : allAccounts.values()){
            accZipCode = getZipCodeFromAccount(accObj);
            postalCodes.add(accZipCode);     
         }
      } 
      
   }
   
   //Methods of Account Assignment
    //Runs the Assignment algorithm for Lead
    //added 24-02-2011
    webservice static Lead runAssignmentAlgoForLead(Id leadId,Boolean isSendToBranch)
    {
      system.debug('------AssignmentRules.runAssignmentAlgoForLead----Starts---------------');
      Lead  lead = [Select Name,NumericPhone__c, lead_category__c , OwnerId, LastName, FirstName, Company,Street, PostalCode, LeadSource, Id, Servicing_Branch_Id__c,Delivery_Postal_Code__c, Delivery_Country__c, 
                      Country, City, Branch__c, Glenigan_Project_Value__c, Glenigan_Company_ID__c, Glenigan_Project__c,Bidder_Postal_Code__c, Glenigan_Bidder__c,Email, Territory__c,Industry From Lead 
                Where Id =:leadId ];
        
      initialize(lead); 
      currentUserId = UserInfo.getUserId();  
                
      assignLeadToBranch(lead,isSendToBranch);
      System.debug('---Send To Lead Owner---'+lead.OwnerId);
      update lead;
      update AccountUpdateList.values();
      update UserUpdateList.values();
      insert assignmentLogsList;
      return lead;
                 
    }
    
    //Method to set owner of lead
    //when lead_category is storage containers or Portable storage containers
    //added 16-02-2012
     webservice static Lead runAssignmentAlgoForLeadNSC(Lead lead,Boolean isSendToBranch){
        assignLeadToBranch(lead,isSendToBranch);
        return lead;
     }
     
     
     
    /* Assign a lead to Branch */
    private static void assignLeadToBranch(Lead newLead,Boolean isSendToBranch){
      system.debug('------AssignmentRules.assignLeadToBranch----Starts---------------');
      String branchCode ='';
      //String zipCode=getZipCode(newLead); // commented according to new lead routing requirement
      String zipCode = getZipCodeFromBillingAddress(newLead); // Added according to new lead routing requirement
      
      Branch_Lookup__c branch = getBranchLookup(zipCode);
      if(branch!=null){
         branchCode = branch.Branch_Code__c;
      }
      if(newLead.Delivery_Country__c != null && newLead.Delivery_Country__c.equalsIgnoreCase('Ireland')){
        branchCode = '709';
      }
      if( branchCode == '')
      {
        //Add to Exception
        addLeadToLeadExceptionQueue(newLead,'000',null,'');
      }
      else{
            String userRoleName = '';
            User salesRep ;
            if(isSendToBranch){
                userRoleName = 'Sales Rep - '+ branchCode + ' - ';
                //salesRep = loadAvailableSalesRep(branchCode,branch,newLead.Country,userRoleName);
                if(branch.Territory__c != null && mapTerritoryAndUser.containsKey(branch.Territory__c)){
                    salesRep = mapTerritoryAndUser.get(branch.Territory__c);
                }
            }else{
                /*if((newLead.LeadSource != 'Dodge Report' && newLead.LeadSource != 'Glenigan'
                    && newLead.LeadSource != 'UK Online Order' && newLead.LeadSource != 'UK Web Inc Call'
                    && newLead.LeadSource != 'MMI UK Website' && newLead.LeadSource != 'Const Data Comp') &&
                    (newLead.Company == '' || newLead.Company == null) ||
                    ((newLead.Company != '' && newLead.Company != null) && (newLead.Company.containsIgnoreCase('Residential') || newLead.Company.containsIgnoreCase('Homeowner'))))
                {*/
                    salesRep = getInboundUserOfSellingRegion(branch, false);
                     /*if(CheckLead(newLead)){
                        if(isHomeOwner(newLead)){
                            System.debug('::::::::::::IB::::::::');
                            salesRep = getInboundUserOfSellingRegion(branch);
                        }else{
                            if(isWithinBusinesshrs()){
                                System.debug('::::::::::::IB::::::::');
                                salesRep = getInboundUserOfSellingRegion(branch);
                             }else{
                                System.debug('::::::ISR:::::');
                                //salesRep = getAvailableSellingRegionUser(branch); // commented by Rajib
                                salesRep = mapTerritoryAndUser.get(branch.Territory__c);
                            }
                        }
                     }*/
                    
                /*}else if((newLead.LeadSource != 'Dodge Report' && newLead.LeadSource != 'Glenigan'
                        && newLead.LeadSource != 'UK Online Order' && newLead.LeadSource != 'UK Web Inc Call'
                        && newLead.LeadSource != 'MMI UK Website' && newLead.LeadSource != 'Const Data Comp')  &&
                        ((newLead.Company != '' && newLead.Company != null) && !(newLead.Company.containsIgnoreCase('Residential') || newLead.Company.containsIgnoreCase('Homeowner'))))
                {
                    System.debug('::::::::::::OB::::::::');
                    salesRep = getAvailableSellingRegionUser(branch);   
                }*/
            }
            System.debug('-----------salesRep-------------'+salesRep);            
            if(salesRep == null)
            {
                
                //addLeadToLeadExceptionQueue(newLead,branchCode,branch,'');
                if(!isSendToBranch){
                    //Add to Exception
                    addLeadToLead298ExceptionQueue(newLead,branchCode,branch,'');
                }
                //update(newLead);
            }
            else
            {
                system.debug('----Test----123');
                //check user availability
                if(salesRep.Available_For_Leads__c){
                    //Assign to user
                    newLead.OwnerId = salesRep.Id;
                }else{
                    if(salesRep.ManagerId != null){
                        //Assign to user`s Manager
                        newLead.OwnerId= salesRep.ManagerId;
                    }else{
                        newLead.OwnerId = salesRep.Id;
                    }
                }
                //newLead.OwnerId=salesRep.Id;
                //Case # 00037243 Start
                 newLead.Assignment_Cause__c = populateLdOwnerInfo('1794', null, null, null, 'Assigned SalesRep = '+ String.valueOf(salesRep));
                //Case # 00037243 End
                salesRep.LastLeadAllocation__c=Datetime.now();
                //update(newLead);
                //update salesRep;
                if(!UserUpdateList.containsKey(salesRep.Id))
                {
                  UserUpdateList.put(salesRep.Id,salesRep);
                }
                // Assignment log for current Custom Assignment
                
                if(String.valueOf(newLead.OwnerId).startswith('005')) {
                assignmentLogsList.add(new LeadAssignmentHistory__c(AssignedBy__c=currentUserId,
                AssignedSalesRep__c=newLead.OwnerId, Assignment_Method__c='Round Robin',
                AssignmentTime__c=now, Lead_Source__c=newLead.LeadSource));
            }
        }
    }
    }
    
    
     //Searches for available sales Rep
    private static User loadAvailableSalesRep(String branchCode,Branch_Lookup__c branch,String leadCountry,String userRoleName)
    {
      
        system.debug('------AssignmentRules.loadAvailableSalesRep----Starts---------------');
        if(allUsers.isEmpty()|| allUsers.size()==0)
        {
            return null;
        }
        else
        {
          if(allUsers.get(0).isEmpty()|| allUsers.get(0).size()==0)
          {
            return null;
          }
        }
        User selectedUser=null;
        //String userRoleName ='Sales Rep - '+ branchCode + ' - ';
        /*if((leadSource != 'Dodge') && (leadSource != '360MobileOffice') && (leadSource != 'The Blue Book') && (leadSource != 'Glenigan')
            && (branch!=null) && (branch.NSC_Team_Live__c==true))
        {
            userRoleName = CountryTeamName.get(branch.Country__c.toUpperCase())  ;//+ branch.NSC_Team__c;
            if(userRoleName.indexOf('#') > 0){
                String[] roles = userRoleName.split('#');
                userRoleName = '';
                for(String userRoleNameStart : roles ){
                    userRoleName = userRoleName + userRoleNameStart + branch.NSC_Team__c + '#';
                    
                }
                userRoleName = userRoleName.substring(0,userRoleName.length()-1);
            }
            else{
                userRoleName = CountryTeamName.get(branch.Country__c.toUpperCase())  + branch.NSC_Team__c;
            }
            
            
        }*/
        
        /*if (branch.branch_Code__c == '777'){
            userRoleName = 'NSC Team Member - UK';
            
        }*/
        
        selectedUser = selectSalesRep(branchCode,userRoleName,leadCountry,'');

        return selectedUser;
    }
    private static void initialize(Lead lead)
    { 
      system.debug('------AssignmentRules.initialize(Lead lead)----Starts---------------');
      List<Lead> leadList = new List<Lead>();
      leadList.add(lead);   
      addAllSetValues(leadList);
      allBranches = GetAllBranchLookups();
      assignmentLogsList = new List<LeadAssignmentHistory__c>();
      Set<String > branchCodes = new Set<String>{'298','777'};
      if(projectIdSet != null && projectIdSet.size() >0){
        branchCodes.add('709');
      }
        /////////////////////
      for(Lead newLead:leadList){
       //String zipCode = getZipCode(newLead); // commented according to new lead routing requirement
       String zipCode = getZipCodeFromBillingAddress(newLead); // Added according to new lead routing requirement
       
       //T-33094 prepare timezone set
       //String branchCode=getBranchCode(zipCode);
       //if(branchCode!=''){
       Branch_Lookup__c branchLookup = getBranchLookup(zipCode);
       if(branchLookup != null){
          servicingBranchIds.add(lead.Servicing_Branch_Id__c);
          branchCodes.add(branchLookup.Branch_Code__c);
          // Added by rajib
          setTerritories.add(branchLookup.Territory__c);
          
           //commented for T-83472
          //timeZones.add(branchLookup.Time_Zone__c);
       }
      } 
      FillCountryBranchTeamCodeMap();
      /*GetMatchingAccountsForLeads();
      allContacts = GetAllContacts();
      if(leftParentAccountIds!= null && leftParentAccountIds.size()>0){
         allAccounts = GetParentAccounts(leftParentAccountIds);
      }*/
      /////////////////////
      GetAllSellingRegions(branchCodes);
      allUsers = GetAllUsers(branchCodes);
      allLeadQueues=GetAllLeadQueues();
      HouseAccountUserId= getUserId(HouseAccountUserName);
      if(projectIdSet != null && projectIdSet.size()>0){
         allGleniganProjects = getProjectValues();
      }
    }
    
    public static void assignDuplicateLead(List<Lead> leads, List<Lead> dupLeads){
        system.debug('------AssignmentRules.assignDuplicateLead---Starts---------------');
        List<Lead> tempLeads = new List<Lead>();
        tempLeads.addAll(leads);
        for(Lead dupLead : dupLeads){
            for(Lead l : leads){
                if(dupLead.NumericPhone__c == l.NumericPhone__c || (dupLead.LastName ==l.LastName &&  dupLead.PostalCode == l.PostalCode)){
                    dupLead.ownerId = l.ownerId;
                    //Case # 00037243 Start
                                dupLead.Assignment_Cause__c = populateLdOwnerInfo('1907', l, null, null, 'Assigned through duplicate lead');
                                //Case # 00037243 End
                    break;
                }
            }
        }
        
    }
    
   //method to check if the lead is to be NSC processed 
    public static boolean isNSCLead(Lead lead){    
      system.debug('------AssignmentRules.isNSCLead---Starts---------------');
      system.debug('-----lead---------'+lead);
      //String zipCode=getZipCode(lead); // commented according to new lead routing requirement
      String zipCode = getZipCodeFromBillingAddress(lead); // Added according to new lead routing requirement
      Branch_Lookup__c branch = getBranchLookup(zipCode);
      
      //T-57803 
      if(isMovingAndStorageLead(branch,lead)){
        return false;
      }
     
      system.debug(lead.Company+'@@@@@@'+lead.LeadSource+'@@@@@@@@@@@@@');
      //Added logic for MSM-2 
      if((lead.Company !=null && lead.Company !='') && (lead.Company.containsIgnoreCase('Construction') || 
        lead.Company.containsIgnoreCase('Contractor') || lead.Company.containsIgnoreCase('Electric') ||
        lead.Company.containsIgnoreCase('Plumbing') || lead.Company.containsIgnoreCase('HVAC') || lead.Company.containsIgnoreCase('Landscaping') ||
        lead.Company.containsIgnoreCase('Building') || lead.Company.containsIgnoreCase('Builder') 
        || lead.Company.containsIgnoreCase('Const.') || lead.Company.containsIgnoreCase('Const') || lead.Company.containsIgnoreCase('Cstrn')
        || lead.Company.containsIgnoreCase('Cst')) && ( lead.LeadSource =='360MobileOffice'))
      {
        system.debug(lead.Company+'@@@inside@@@'+lead.LeadSource+'@@@@@@@@@@@@@');
          return false;
      }
     
      //Story # S-106421 Start [lead will go to NSC Rep if lead source = "OB Campaign" and new Field "Go To NSC Rep" = TRUE
      if(lead.LeadSource == 'OB Campaign'){
              return lead.Go_To_NSC_Rep__c;
      }
      //Story # S-106421 End
      //removed 360MobileOffice for MSM-2
      if((lead.LeadSource != 'Dodge') && (lead.LeadSource != 'The Blue Book') && (branch!=null) && (branch.NSC_Team_Live__c==true)
        && !(branch.Country__c.toUpperCase() == 'UK' || branch.Country__c.toUpperCase() == 'IRELAND' || branch.Country__c.toUpperCase()== 'UNITED KINGDOM' || branch.Country__c.toUpperCase() == 'ENG' 
              || branch.Country__c.toUpperCase() == 'ENGLAND' || branch.Country__c.toUpperCase() == 'GB' || branch.Country__c.toUpperCase() == 'GREAT BRITAIN' )) {                
           System.debug(':::::::Country brnach code map:::::::::::'+CountryBranchCodeMap.keyset());
           System.debug(':::::::Country:::::::::::'+branch.Country__c);
           return CountryBranchCodeMap.containsKey(branch.Country__c.toUpperCase());
          
      }               
      return false;
              
    }
    
    //T-57803
    public static Boolean isMovingAndStorageLead(Branch_Lookup__c branch,Lead lead){      
        if(lead == null && branch == null) return false;
      
        String country = branch == null ? (lead.Country == null ? null : lead.Country.toUpperCase()) 
                                        : branch.Country__c.toUpperCase();
        
        if((country == 'US' || country == 'USA') && lead.On_The_Go__c == true)
            return true;
        return false;
    }
    
    // TFS 3873 - method that returns record type ID of type ETS/WMI for an Object Name    
    public static ID getETSWMIrectypeID(String ObjName)
    {   
        map<String,ID> mapObjNameRecTypeID = new map<String,ID>();
        List<String> splitObjReclist = new List<String>();
        List<String> ObjReclist = new List<String>();
        
        List<ETSnWMIrectype__c> ecs = ETSnWMIrectype__c.getall().values();
        
         if(ecs.size() > 0){
             String ObjRec = String.valueof(ecs[0].ObjRecType__c);
             ObjReclist = ObjRec.split(',');
            }
        
         for(integer i =0; i<ObjReclist.size(); i++)
           {   splitObjReclist = ObjReclist[i].split('_');
               mapObjNameRecTypeID.put(splitObjReclist[0],splitObjReclist[1]);
           }
           
           
        if(mapObjNameRecTypeID.containskey(ObjName))
         { return mapObjNameRecTypeID.get(ObjName); }
       
        return null;     
    }
    
    //TFS 6866- Method returns Glenigan RecordType ID
    public static ID gleniganRecTypeID(){
        Id devRecordTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Glenigan Lead').getRecordTypeId();
        return devRecordTypeId;
    }
    
    // TFS 4220, 4275 - method that returns a set of ETS and WMI profile Names
    public static Set<String> getETSnWMIprofileNames()
    {  List<String> ETSprofileList = new List<String>();
       Set<String> ETSprofileSet = new Set<String>();
       List<ETS_WMI_ProfileNames__c> profileList = ETS_WMI_ProfileNames__c.getAll().values();
        for(integer i =0; i< profileList.size() ; i++ )
         {  ETSprofileList.add(String.valueOf(profileList[i].ProfileList__c));         }
       ETSprofileSet.addAll(ETSprofileList);  
       return ETSprofileSet;  
    }
        
    //commented for T-83472
    //T-33094
    /*public static User getAvailableTimeZoneUser(Branch_Lookup__c branch){
        User selectedUser=null;
        Datetime minDateTime=Datetime.now();     
        String lastAllocationFieldName = isNSCSweepRunning? 'LastOpptyAlocation__c' : 'LastLeadAllocation__c';
           
        if(mapTimeZoneUsers.containsKey(branch.Time_Zone__c)) {
          for(User user : mapTimeZoneUsers.get(branch.Time_Zone__c)) {
               if(minDateTime != null && (user.get(lastAllocationFieldName) == null || minDateTime > (DateTime)user.get(lastAllocationFieldName))) {
                 // if(user.get(lastAllocationFieldName) <> null){
                     minDateTime = (DateTime)user.get(lastAllocationFieldName);
                 //}        
                 selectedUser=user;
               }
          }
        }        
        if(selectedUser == null){
                 System.debug('Debug--selectSalesRep--------selectedUser=NULL');
        }else{
            System.debug('Debug--selectSalesRep--------selectedUser.Name' + selectedUser.Name );
        }
        return selectedUser;
    }*/
    
    //T-79604
    public static User getAvailableSellingRegionUser(Branch_Lookup__c branch){
        system.debug('------AssignmentRules.getAvailableSellingRegionUser---Starts---------------');
        system.debug('-----branch---------'+branch);
        User selectedUser=null;
        if(branch != null) {
        Datetime minDateTime=Datetime.now();     
        String lastAllocationFieldName = isNSCSweepRunning? 'LastOpptyAlocation__c' : 'LastLeadAllocation__c';
        String sellingRegion = mapSellingRegions.get(branch.Branch_Code__c); 
        system.debug('====bharti==' + mapSellingRegionUsers.get(sellingRegion));
        if(mapSellingRegionUsers.containsKey(sellingRegion)) {
          for(User user : mapSellingRegionUsers.get(sellingRegion)) {
               if(minDateTime != null && (user.get(lastAllocationFieldName) == null || minDateTime > (DateTime)user.get(lastAllocationFieldName))) {
                 // if(user.get(lastAllocationFieldName) <> null){
                     minDateTime = (DateTime)user.get(lastAllocationFieldName);
                 //}
                 selectedUser=user;
               }
          }
        }        
        if(selectedUser == null){
            System.debug('Debug--selectSalesRep--------selectedUser=NULL');
        }else{
            System.debug('Debug--selectSalesRep--------selectedUser.Name' + selectedUser.Name );
        }
        } return selectedUser; 
    }
    
     //T-79604
    public static User getAvailableSellingRegionInboundUser(Branch_Lookup__c branch){       
        system.debug('------AssignmentRules.getAvailableSellingRegionInboundUser---Starts---------------');
        system.debug('------branch-------------'+branch);
        User selectedUser=null;
        if(branch != null) {
          Datetime minDateTime=Datetime.now();     
          String lastAllocationFieldName = isNSCSweepRunning? 'LastOpptyAlocation__c' : 'LastLeadAllocation__c';
          
          system.debug('------lastAllocationFieldName-------------'+lastAllocationFieldName);
          system.debug('------mapSellingRegions-------------'+mapSellingRegions);
          
          String sellingRegion = mapSellingRegions.get(branch.Branch_Code__c); 
          if(mapSellingRegionInboundUsers.containsKey(sellingRegion)) {
            for(User user : mapSellingRegionInboundUsers.get(sellingRegion)) {
              if(minDateTime != null && (user.get(lastAllocationFieldName) == null || minDateTime > (DateTime)user.get(lastAllocationFieldName))) {
                minDateTime = (DateTime)user.get(lastAllocationFieldName);
                    selectedUser = user;
                 }
            }
          }      
        } 
        system.debug('------selectedUser-------------'+selectedUser);
        return selectedUser; 
    }
    
    // added for new lead routing April 1 2014 release
    public static User getInboundUserOfSellingRegion(Branch_Lookup__c branch, Boolean isHomeOwnerLd){       
        system.debug('------AssignmentRules.getInboundUserOfSellingRegion---Starts---------------');
        system.debug('------branch-------------'+branch);
        User selectedUser=null;
        if(branch != null) {
          Datetime minDateTime=Datetime.now();     
          String lastAllocationFieldName = isNSCSweepRunning? 'LastOpptyAlocation__c' : 'LastLeadAllocation__c';
          
          system.debug('------lastAllocationFieldName-------------'+lastAllocationFieldName);
          system.debug('------mapSellingRegionInboundUsers-------------'+mapSellingRegionInboundUsers);
          if(branch.Selling_Region__c != null){
             String sellingRegion = String.valueOf(branch.Selling_Region__c);
              if(mapSellingRegionInboundUsers.containsKey(sellingRegion)) {
                for(User user : mapSellingRegionInboundUsers.get(sellingRegion)) {
                  if(minDateTime != null && !isHomeOwnerLd && (user.get(lastAllocationFieldName) == null || minDateTime > (DateTime)user.get(lastAllocationFieldName))) {
                    minDateTime = (DateTime)user.get(lastAllocationFieldName);
                      selectedUser = user;                                                    
                   }
                 // TFS 3654  
                 if(minDateTime != null && isHomeOwnerLd && user.isHomeOwnerRep__c && (user.get(lastAllocationFieldName) == null || minDateTime > (DateTime)user.get(lastAllocationFieldName))) {
                    minDateTime = (DateTime)user.get(lastAllocationFieldName);
                      selectedUser = user;                                                    
                   }  
                }
              }
          }      
        } 
        system.debug('------selectedUser-------------'+selectedUser);
        return selectedUser; 
    }
        
    //Done for Case # 00035523
    //Method to populate the OriginalOwner on lead to the valid User (1st sales rep the lead was routed to [Not Integration User/Any Queue])
    public static void populateOriginalOwner(List<Lead> ldList){
        system.debug('------AssignmentRules.populateOriginalOwner---Starts---------------');
         for(Lead ld : ldList){
         
            system.debug('Lead' + ld);
            system.debug('Lead Owner ID' + ld.OwnerId);
            system.debug('Lead Original Owner field' + ld.Original_Owner__c);
            system.debug('Integration User ID' + integrationUser.Id);
            //system.debug(' Another condition check : ' + String.valueOf(ld.OwnerId).startsWith('00G'));
            
            if(ld.Original_Owner__c == null && ld.OwnerId != null && ld.OwnerId != integrationUser.Id && !String.valueOf(ld.OwnerId).startsWith('00G')){
                ld.Original_Owner__c = ld.OwnerId;
            }
        }
    }
    //End Case # 00035523
    
    //Jailabdin -New UKWebLead and GleniganLead retouing TFS:6866
    Public static void updateowner(List<Lead> listLead){
        Map<Integer,User> mapNumtoOwnerId = new Map<Integer,User>();
        List<user> usrlist = [select id,name from user where Profile.name='NSC Coordinator IB – UK' and IsActive=true and Available_For_Leads__c=true Order by LastLeadAllocation__c Asc];
        set<user> userupdateset= new set<user>();
        List<user> listUsertoUpdate = new List<user>();
        Map<user,datetime> userupdatemap = new Map<user,datetime>();
        
        Integer j =0;       
        for(User u : usrlist)
        {
          mapNumtoOwnerId.put(j,u);
          j++;  
        }   
        integer i=0;
        for(Lead ld :listLead){
            if(usrlist.size()>0){
                if(mapNumtoOwnerId.get(i)!=null && mapNumtoOwnerId.containsKey(i)){
                    ld.ownerId= mapNumtoOwnerId.get(i).id;
                    User u =  mapNumtoOwnerId.get(i);
                    userupdatemap.put(u,Datetime.now());
                    //u.LastLeadAllocation__c = Datetime.now();
                    //userupdateset.add(u);
                    
                }
                else if(mapNumtoOwnerId.get(i)==null ){
                    i=0;
                    ld.ownerId= mapNumtoOwnerId.get(i).id;
                    User u =  mapNumtoOwnerId.get(i);
                    userupdatemap.put(u,Datetime.now());
                    //u.LastLeadAllocation__c = Datetime.now();
                    //userupdateset.add(u);
                    
                }
                i++;
            }        
            else{
                ld.ownerId = queuid;
            }
            
        }
        
        for(User userupdatemapvar:userupdatemap.keySet()){
                        userupdatemapvar.LastLeadAllocation__c = userupdatemap.get(userupdatemapvar);
                        listUsertoUpdate.add(userupdatemapvar);
        }
        //listUsertoUpdate.addAll(userupdateset);
        update listUsertoUpdate;
        
        
        /*
        Integer i =0;       
        for(User u : usrlist)
        {
          mapNumtoOwnerId.put(i,u);
          i++;  
        }        
        List<User> listUsertoUpdate = new List<User>();
        Integer j=0;
        for(Lead ld :listLead)
        {
            if(mapNumtoOwnerId.containsKey(j))
            {
                ld.ownerId = mapNumtoOwnerId.get(j).id;
                User u =  mapNumtoOwnerId.get(j);
                u.LastLeadAllocation__c = Datetime.now();
                listUsertoUpdate.add(u);
                j++;
            }
            else{
                ld.ownerId = queuid;
                j++;         
                
            }
        }
        
        update listUsertoUpdate;
         */
    }
    
    // TFS 5345 - Disable leads for some UK Reps..
    private static map<String,String> getUserWeekDaydetails(){
       map<String,String> mapUserDay = new map<String,String>();
       list<String> fdList = new list<String>();    // Custom Setting - Custom fields
       list<UKrepLeadsDisable__c> ukReplist = UKrepLeadsDisable__c.getAll().values(); // Custom Settings
                
        for(integer i = 0; i< ukRepList.size(); i++)
          { fdList = String.valueOf(ukReplist[i].UserDay__c).split('_');
            mapUserDay.put(fdList[0],fdList[1]); 
          }
          
        return mapUserDay;  
    }
    
    // TFS 5345 - Disable leads for some UK Reps..
    private static Boolean checkUKrepDayOff(String dayOff){
      Boolean notAssign = false;
      DateTime tdate = system.now();
      String wkday = tdate.format('EEEE');
        if(wkday == dayoff)
         { notAssign = true;}
      return notAssign;     
    }    
    
    //Case # 00037243 Start
    //Method to log the information related to Lead Owner assignment
    public static String populateLdOwnerInfo(String lineNum, Lead relatedLd, Account relatedAcct, Contact relatedCont, String extraInfo){
        system.debug('------AssignmentRules.populateLdOwnerInfo---Starts---------------');
        string infoLog = '';
        infoLog = '******************************************\n';
        infoLog += 'Line # : ' + lineNum + '\n';
        infoLog += 'Assignment Time : ' + String.valueOf(System.now()) + '\n';
        infoLog += 'Related Lead(Lead from which current lead is assigned) Info : ' + relatedLd + '\n';
        infoLog += 'Related Account(Account from which current lead is assigned) Info : ' + relatedAcct + '\n';
        infoLog += 'Related Contact(Contact from which current lead is assigned) Info : ' + relatedCont + '\n';
        infoLog += 'Additional Info : ' + extraInfo;
        
        return infoLog;
    }
    //Case # 00037243 End
    
    //T-49647
    public class CustomException extends Exception{}  
    
    //MSM - 5 Added Business hours
     public static String isWithinBusinesshrs(Boolean isHoliday){       
        system.debug('------AssignmentRules.isWithinBusinesshrs---Starts---------------');          
        BusinessHours b =[select id,Name,IsActive,IsDefault,FridayEndTime,FridayStartTime,MondayEndTime,MondayStartTime,SaturdayEndTime,SaturdayStartTime,
            SundayEndTime,SundayStartTime,ThursdayEndTime,ThursdayStartTime,TimeZoneSidKey,TuesdayEndTime,TuesdayStartTime,
            WednesdayEndTime,WednesdayStartTime from  BusinessHours where IsActive = true and Name = 'Branch 298'];
        Datetime nowTime = Datetime.now();
        //String DateStr = String.valueOf(nowTime.date());
        //String timeStr = String.valueOf(nowTime.time());
        String day = nowTime.format('EEEE');
        boolean isWithInHrs = false;
        String businessHrs = 'outside nsc';
        System.debug('---------------day--------'+day );  
        System.debug('------------nowTime.time()-----'+nowTime.time() );  
        System.debug('-----------b.MondayStartTime------'+b.MondayStartTime );  
        System.debug('--------------b.MondayEndTime--------'+b.MondayEndTime );  
        System.debug('--------------CheckHoliday()------'+CheckHoliday() );  
        // As per org start and end hours are same, here taken whole for the same week.
        /*if((day == 'Monday' || day == 'Tuesday' ||  day == 'Wednesday' || day == 'Thursday' || day == 'Friday') 
            &&  (nowTime.time() > b.MondayStartTime && nowTime.time() < b.MondayEndTime &&  CheckHoliday() == false)){
             System.debug('::: true::::' );
            return  true;
        }*/
        if((( day == 'Monday' && nowTime.time() > b.MondayStartTime && nowTime.time() < b.MondayEndTime ) ||
            ( day == 'Tuesday' && nowTime.time() > b.TuesdayStartTime && nowTime.time() < b.TuesdayEndTime ) ||
            ( day == 'Wednesday' && nowTime.time() > b.WednesdayStartTime && nowTime.time() < b.WednesdayEndTime ) ||
            ( day == 'Thursday' && nowTime.time() > b.ThursdayStartTime && nowTime.time() < b.ThursdayEndTime ) ||
            ( day == 'Friday' && nowTime.time() > b.FridayStartTime && nowTime.time() < b.FridayEndTime )) &&
            (isHoliday == false)){
                System.debug('----true--within nsc--------' );
                businessHrs = 'nsc';
        }else if((day == 'Friday' && nowTime.time() > b.FridayEndTime) || day == 'Saturday' || day == 'Sunday'){
            System.debug('----False---after nsc------' );
            //return  true; // for testing
            businessHrs = 'weekend';
        }
       return businessHrs; 
    }
    public static boolean CheckHoliday(){
        system.debug('------AssignmentRules.CheckHoliday---Starts---------------');
        Holiday[] h=  [select ActivityDate,Description,EndTimeInMinutes,IsAllDay,IsRecurrence,Name,RecurrenceDayOfMonth,
            RecurrenceEndDateOnly,RecurrenceInstance,RecurrenceInterval,RecurrenceMonthOfYear,
            RecurrenceStartDate,StartTimeInMinutes from Holiday where IsRecurrence = true]; 
            
        Boolean isholiday = false;
        Datetime nowTime = Datetime.now();
        
        for(integer i =1 ; i<h.size() ; i++){           
            DateTime hdate = h[i].ActivityDate;
            
            if(nowTime.day() == hdate.day() && nowTime.month() == hdate.month()){
                isholiday = true ;
            }
        }
        System.debug('::: return is Holiday::::'+ isholiday);
        return isholiday;
    }
  
 }