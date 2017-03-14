public with sharing class dodgeProcessUtil {
    /*=====================================================================================================
    Name    : dodgeProcessUtil
    Author  : TEK Developer
    Usage   : This Class is used to change the owner of the Job Profile and notify them via mail
    =========================================================================================================*/
    
    //-----------variables---------------------------------------------------
    private Static map<String,Branch_Lookup__c> mapZipAndBranchLookup = new map<String,Branch_Lookup__c>();
    private Static map<String,String> mapZipAndTerritory = new map<String,String>();
    private Static list<User> lstAllActiveUser = new list<User>();
    private Static map<String,User> mapTerritoryAndUser = new map<String,User>();
    private Static map<String,User> mapUsrIdAndUser = new map<String,User>();
    private Static map<String,String> mapEmailAndUser = new map<String,String>();
    private Static map<String,Job_Profile__c> mapScIdAndJp = new map<String,Job_Profile__c>();
    private Static map<String,String> mapJpIDAndGcId = new map<String,String>();
    //private Static map<String,Account> mapScIdAndAcc = new map<String,Account>();
    //private Static map<String,String> mapAccIDAndGcId = new map<String,String>();
    private Static set<ID> JBrelatedSCset =  new set<ID>();   // MSM 79  Job Profile Sweep Logic ..
    private Static list <Sub_Contractor__c> SClist = New list<Sub_Contractor__c>();           // MSM 79  Job Profile Sweep Logic ..
    private static map<ID,String> mapJpIDAndJpName = new map<ID,String>();                   // TFS 3631
      
     static{
        getAllUsers();
     }
    
    //---------------Methodes------------------------------------------------------
    /*********************************************************************
    Purpose     : This method will iniatialize all the necessary info like user, role, branch lookup obj
    Parameters  : List of Sub_Contractor__c
    Returns     : null
    **********************************************************************/
    private static void  initialize(list<Sub_Contractor__c> lstSc){
      // list and map needed to assign Job Profile Owner ..
      mapZipAndBranchLookup = new map<String,Branch_Lookup__c>();
        mapZipAndTerritory = new map<String,String>();
        mapScIdAndJp = new map<String,Job_Profile__c>();
        mapJpIDAndGcId = new map<String,String>();
      
        set<String> zipSet = new set<String>();
        set<String> jpIdSet = new set<String>();
        set<String> accIdSet = new set<String>();
        
        for(Sub_Contractor__c sc : lstSc){
            if(sc.Account_billing_zip_code__c != null){
                zipSet.add(getZipCode(sc));
            }
            jpIdSet.add(sc.Job_Profile__c);
            mapJpIDAndGcId.put(sc.Job_Profile__c,sc.Id);
            accIdSet.add(sc.Account__c);
            //mapAccIDAndGcId.put(sc.Account__c, sc.Id);
        }
        if(zipSet.size() > 0 ){
            getZipBranchLookupMap(zipSet);
        }
        getAllJp(jpIdSet);
        //getAllAccount(accIdSet);
    }
    
    /*********************************************************************
    Purpose     : This method will get the zip code from Account`s billing address
    Parameters  : Sub_Contractor__c object type
    Returns     : zip code from Account
    **********************************************************************/
    private static string getZipCode(Sub_Contractor__c sc){
        system.debug('----------------dodgeProcessUtil.getZipCode----------Starts-----------');
        string billingZip = '';
        if(sc.Account_billing_zip_code__c != null && sc.Account_billing_zip_code__c != ''){
            if(sc.Account_billing_zip_code__c.length() > 5){
                billingZip = sc.Account_billing_zip_code__c.subString(0,5);
            }else{
                billingZip = sc.Account_billing_zip_code__c;
            }
        }
        system.debug('----------------billingZip----------'+billingZip);
        system.debug('----------------dodgeProcessUtil.getZipCode----------ends-----------');
        return billingZip;
    }
    
    /*********************************************************************
    Purpose     : This method will set the public var mapZipAndBranchLookup and mapZipAndTerritory
    Parameters  : null
    Returns     : 
    **********************************************************************/
    private static void getZipBranchLookupMap(set<String> zipSet){
        system.debug('----------------dodgeProcessUtil.getZipBranchLookupMap----------Starts-----------');
        list<Branch_Lookup__c> lstBL = [Select b.Zip__c, b.Territory__c, b.Selling_Region__c, b.NSC_Team_Live__c, b.Id, b.Country__c, b.Branch_Code__c From Branch_Lookup__c b where b.Zip__c in :zipSet];
        if(lstBL.size() > 0){
            for(Branch_Lookup__c bl : lstBL){
                mapZipAndBranchLookup.put(bl.Zip__c, bl);
                if(bl.Territory__c !=  null){
                    mapZipAndTerritory.put(bl.Zip__c, bl.Territory__c);
                }
            }
        }
        system.debug('----------------dodgeProcessUtil.getZipBranchLookupMap----------ends-----------');
    }
    
    /*********************************************************************
    Purpose     : this method will set the public var mapEmailAndUser,mapUsrIdAndUser and mapTerritoryAndUser
    Parameters  : Sub_Contractor__c object type
    Returns     : null
    **********************************************************************/
    private static void getAllUsers(){
        system.debug('----------------dodgeProcessUtil.getAllUsers----------Starts-----------');
        list<User> lstUser = [Select u.Territory__c, u.Selling_Region__c, u.Name, u.ManagerId, u.LastName, u.IsActive, u.Id, u.FirstName, u.Email, u.Branch__c, u.Branch_Id__c, u.Available_For_Leads__c From User u where u.IsActive = true];
        if(lstUser.size() > 0){
            for(User u : lstUser){
                if(u.Territory__c != null){
                    mapTerritoryAndUser.put(u.Territory__c,u);
                }
                if(u.Email != null){
                    mapEmailAndUser.put(u.Id,u.Email);
                }
                mapUsrIdAndUser.put(String.valueOf(u.Id).subString(0,15),u);
            }
        }
        system.debug('----------------dodgeProcessUtil.getAllUsers----------ends-----------');
    }
    
    /*********************************************************************
    Purpose     : this method will set the public var mapScIdAndJp
    Parameters  : set of Job Profile Id
    Returns     : null
    **********************************************************************/
    private static void getAllJp(set<String> jpIdSet){
        system.debug('----------------dodgeProcessUtil.getAllJp----------Starts-----------');
        list<Job_Profile__c> lstJp = [Select j.OwnerId, j.Id, j.Project_Stage_Status__c, j.Name From Job_Profile__c j where j.Id in : jpIdSet];
        if(lstJp.size() > 0){
            for(Job_Profile__c jp : lstJp){
                if(mapJpIDAndGcId.containsKey(jp.Id)){
                    mapScIdAndJp.put(mapJpIDAndGcId.get(jp.Id),jp);
                }
              mapJpIDAndJpName.put(jp.ID,jp.Name);                                // TFS 3631
            }
        }
        system.debug('----------------dodgeProcessUtil.getAllJp----------ends-----------');
    }
    
    /*********************************************************************
    Purpose     : this method will set the public var mapScIdAndAcc
    Parameters  : set of Account Id
    Returns     : null
    **********************************************************************/
    /*private static void getAllAccount(set<String> accIdSet){
        system.debug('----------------dodgeProcessUtil.getAllAccount----------Starts-----------');
        list<Account> lstAcct = [Select a.OwnerId, a.Id From Account a where a.Id in : accIdSet];
        if(lstAcct.size() > 0){
            for(Account a : lstAcct){
                if(mapAccIDAndGcId.containsKey(a.Id)){
                    mapScIdAndAcc.put(mapAccIDAndGcId.get(a.Id),a);
                }
            }
        }
        system.debug('----------------dodgeProcessUtil.getAllAccount----------ends-----------');
    }*/
    
    /*********************************************************************
    Purpose     : To check whether the role is a GC or not.
    Parameters  : Sub_Contractor__c object type
    Returns     : true / false
    **********************************************************************/
    private static Boolean isGeneralContractor(Sub_Contractor__c sc){
        system.debug('----------------dodgeProcessUtil.isGeneralContractor----------Starts-----------');
        Boolean isGC = false;
        if(sc.Role__c == 'General Contractor'){
            isGC = true;
        }
        system.debug('----------------dodgeProcessUtil.isGeneralContractor----------ends-----------');
        return isGC;
    }
    
     /*********************************************************************
    Purpose     : To check whether the role is a CM or not.
    Parameters  : Sub_Contractor__c object type
    Returns     : true / false
    **********************************************************************/
    private static Boolean isConstructionManager(Sub_Contractor__c sc){
        system.debug('----------------dodgeProcessUtil.isConstructionManager----------Starts-----------');
        Boolean isCM = false;
        if(sc.Role__c == 'Construction Manager'){
            isCM = true;
        }
        system.debug('----------------dodgeProcessUtil.isConstructionManager----------ends-----------');
        return isCM;
    }
    
    /*********************************************************************
    Purpose     : To check the owner of SC.
    Parameters  : Sub_Contractor__c object type
    Returns     : true / false
    **********************************************************************/
    private static Boolean isBranchAccount(Sub_Contractor__c sc){
        system.debug('----------------dodgeProcessUtil.isBranchAccount----------Starts-----------');
        Boolean isBA = false;
        if(sc.Is_Account_owner_Branch_Account__c){
            isBA = true;
        }
        system.debug('----------------dodgeProcessUtil.isBranchAccount----------ends-----------');
        return isBA;
    }
    
    /*********************************************************************
    Purpose     : To check if GC is already added.
    Parameters  : Sub_Contractor__c object type
    Returns     : true / false
    **********************************************************************/
    private static Boolean isGcAlreadyAddedToJp(Sub_Contractor__c sc){
        system.debug('----------------dodgeProcessUtil.isGcAlreadyAddedToJp----------Starts-----------');
        Boolean isGcAlreadyAdded = false;
               
        Job_Profile__c jp = [Select j.Id, (Select Id,Role__c From Job_Profile_Sub_Contractor__r) From Job_Profile__c j where Id = :sc.Job_Profile__c];
        if(jp <> null){
             for(Sub_Contractor__c subCon : jp.Job_Profile_Sub_Contractor__r){
                    if(subCon.Role__c == 'General Contractor' && subCon.Id <> sc.Id){
                        isGcAlreadyAdded = true;
                        break;
                    }
                }
          }
        system.debug('----------------dodgeProcessUtil.isGcAlreadyAddedToJp----------ends-----------');
        return isGcAlreadyAdded;
    }
    
    /*********************************************************************
    Purpose     : To check if CM is already added.
    Parameters  : Sub_Contractor__c object type
    Returns     : true / false
    **********************************************************************/
    private static Boolean isCmAlreadyAddedToJp(Sub_Contractor__c sc){
        system.debug('----------------dodgeProcessUtil.isCmAlreadyAddedToJp----------Starts-----------');
        Boolean isCmAlreadyAdded = false;
               
        Job_Profile__c jp = [Select j.Id, (Select Id,Role__c From Job_Profile_Sub_Contractor__r) From Job_Profile__c j where Id = :sc.Job_Profile__c];
        if(jp <> null){
            for(Sub_Contractor__c subCon : jp.Job_Profile_Sub_Contractor__r){
                    if(subCon.Role__c == 'Construction Manager' && subCon.Id <> sc.Id){
                        isCmAlreadyAdded = true;
                        break;
                    }
           }
        }
        system.debug('----------------dodgeProcessUtil.isCmAlreadyAddedToJp----------ends-----------');
        return isCmAlreadyAdded;
    }
    
    /*********************************************************************
    Purpose     : To assign the owner of Job profile
    Parameters  : List of Sub_Contractor__c object type
    Returns     : null
    **********************************************************************/
    private static void AssignOwner(list<Sub_Contractor__c> cmplistSC){
      
         // MSM 79  Job Profile Sweep Logic ..
        JBrelatedSCset =  new set<ID>();   
      SClist = New list<Sub_Contractor__c>();  
    
        //----------for GC-------------------
        list<Sub_Contractor__c> lstGcBA = new list<Sub_Contractor__c>();
        list<Sub_Contractor__c> lstGcNotBA = new list<Sub_Contractor__c>();
        list<Sub_Contractor__c> lstNewGc = new list<Sub_Contractor__c>();
        //----------for SC-------------------
        list<Sub_Contractor__c> lstScBA = new list<Sub_Contractor__c>();
        list<Sub_Contractor__c> lstScNotBA = new list<Sub_Contractor__c>();
        //--------for Non GC ----------------
        list<Sub_Contractor__c> lstScNonGCBA = new list<Sub_Contractor__c>();
        list<Sub_Contractor__c> lstScNonGCNotBA = new list<Sub_Contractor__c>();
        
        // MSM 79 Job Profile Sweep Logic..
        List<Sub_Contractor__c> listSC = GetscRelatedToActiveJB(cmplistSC);
        system.debug('---------- listSC --------------------' + listSC);
        system.debug('---------- listSC.size() --------------------' + listSC.size());
        initialize(listSC);
        system.debug('---------- listSC --------------------' + listSC);
        system.debug('---------- listSC.size() --------------------' + listSC.size());
        for(Sub_Contractor__c sc : listSC){
          
          system.debug('---------- sc.Is_Account_owner_Branch_Account__c --------------------' + sc.Is_Account_owner_Branch_Account__c );
          
          system.debug('---------- sc.id --------------------' + sc.id);
          
            //----------for GC-------------------
            if(isGeneralContractor(sc) && isBranchAccount(sc)){
                lstGcBA.add(sc);
            }
            if(isGeneralContractor(sc) && !isBranchAccount(sc)){
                lstGcNotBA.add(sc);
            }
            //----------for SC-------------------
            if(!isGeneralContractor(sc) && !isConstructionManager(sc) &&  isBranchAccount(sc)){
                lstScBA.add(sc);
            }
            if(!isGeneralContractor(sc) && !isConstructionManager(sc) && !isBranchAccount(sc)){
                lstScNotBA.add(sc);
            }
            //----------- for Non GC ---------------
            if(isConstructionManager(sc) && !isGcAlreadyAddedToJp(sc) && !isCmAlreadyAddedToJp(sc) && isBranchAccount(sc)){
                lstScNonGCBA.add(sc);
            }
            if(isConstructionManager(sc) && !isGcAlreadyAddedToJp(sc) && !isCmAlreadyAddedToJp(sc) && !isBranchAccount(sc)){
                lstScNonGCNotBA.add(sc);
            }
            
        }
        //----------for GC-------------------
        if(lstGcBA.size() > 0 ){
            processGcCmBranchAccount(lstGcBA);
        }
        if(lstGcNotBA.size() > 0 ){
            processGcCmNonBranchAccount(lstGcNotBA);
        }
        //----------for SC-------------------
        if(lstScBA.size() > 0 ){
            notifyScBasedOnTerritory(lstScBA);
        }
        if(lstScNotBA.size() > 0 ){
            notifyScBasedOnTerritory(lstScNotBA);
        }
        // ---------- for Non GC------------------
        if(lstScNonGCBA.size() > 0 ){
          system.debug('---------- cm --------------------');
            processGcCmBranchAccount(lstScNonGCBA);
        }
        if(lstScNonGCNotBA.size() > 0 ){
            system.debug('---------- cm --------------------');
            processGcCmNonBranchAccount(lstScNonGCNotBA);
        }
        
    }
    
    /*********************************************************************
    Purpose     : To process GC/CM if account is a BranchAccount
    Parameters  : List of Sub_Contractor__c object type
    Returns     : null
    **********************************************************************/
    public static void processGcCmBranchAccount(list<Sub_Contractor__c> listSC){
        system.debug('----------------dodgeProcessUtil.processGcCmBranchAccount----------Starts-----------');
        list<Job_Profile__c> lstJpToUpdate = new list<Job_Profile__c>();
        //initialize(listSC);
        String Zip = '';
        List<Messaging.Singleemailmessage> emails = new List<Messaging.Singleemailmessage>();
        for(Sub_Contractor__c sc : listSC){
          system.debug('---------- sc.id during process --------------------' + sc.id);
             if(sc.Account_billing_zip_code__c != null){
                Zip = getZipCode(sc);
                Branch_Lookup__c bl = null;
                if(mapZipAndBranchLookup.containsKey(Zip)){
                    bl = mapZipAndBranchLookup.get(Zip);
                    User u = null;
                    if(bl.Territory__c != null && mapTerritoryAndUser.containsKey(bl.Territory__c)){
                        u = mapTerritoryAndUser.get(bl.Territory__c);
                        Job_Profile__c jp = null;
                        if(mapScIdAndJp.containsKey(sc.Id)){
                            jp = mapScIdAndJp.get(sc.Id);
                            jp.OwnerId = u.Id;
                            lstJpToUpdate.add(jp);
                            if(u.Email != null){
                                system.debug('---------------u--------'+u);
                                Messaging.Singleemailmessage  mail = sendEmail(u,sc.Account__c, sc.Job_Profile__c, sc.Role__c);              // TFS 3631
                                emails.add(mail);
                            }
                        }
                    }
                }
            }
        }
        updateJp(lstJpToUpdate);
        notifyTheUser(emails);
        system.debug('----------------dodgeProcessUtil.processGcCmBranchAccount----------ends-----------');
    }
    
    /*********************************************************************
    Purpose     : To process GC/CM if account is not a BranchAccount
    Parameters  : List of Sub_Contractor__c object type
    Returns     : null
    **********************************************************************/
    public static void processGcCmNonBranchAccount(list<Sub_Contractor__c> listSC){
        system.debug('----------------dodgeProcessUtil.processGcCmNonBranchAccount----------Starts-----------');
        list<Job_Profile__c> lstJpToUpdate = new list<Job_Profile__c>();
        List<Messaging.Singleemailmessage> emails = new List<Messaging.Singleemailmessage>();
        for(Sub_Contractor__c sc : listSC){
            system.debug('---------- sc.id  during process --------------------' + sc.id);
            system.debug('----------------mapUsrIdAndUser----'+mapUsrIdAndUser);
            system.debug('----------------sc.Account_Owner__c--------'+sc.Account_Owner__c);
            User u = mapUsrIdAndUser.get(sc.Account_Owner__c);
            system.debug('---------------u--------'+u);
            Job_Profile__c jp = null;
            if(mapScIdAndJp.containsKey(sc.Id)){
                jp = mapScIdAndJp.get(sc.Id);
                jp.OwnerId = u.Id;
                lstJpToUpdate.add(jp);
                if(u.Email != null){
                    system.debug('---------------u--------'+u);
                    Messaging.Singleemailmessage  mail = sendEmail(u,sc.Account__c, sc.Job_Profile__c, sc.Role__c);            // TFS 3631
                    emails.add(mail);
                }
            }
        }
        updateJp(lstJpToUpdate);
        notifyTheUser(emails);
        system.debug('----------------dodgeProcessUtil.processGcCmNonBranchAccount----------ends-----------');    
    }
    
    /*********************************************************************
    Purpose     : To process new GC
    Parameters  : List of Sub_Contractor__c object type
    Returns     : null
    **********************************************************************/
    public static void processNewGc(list<Sub_Contractor__c> listSC){
        system.debug('----------------dodgeProcessUtil.processNewGc----------Starts-----------');
        system.debug('----------------dodgeProcessUtil.processNewGc----------ends-----------'); 
    }
    
    /*********************************************************************
    Purpose     : To notify SC user according to territory
    Parameters  : List of Sub_Contractor__c object type
    Returns     : null
    **********************************************************************/
    public static void notifyScBasedOnTerritory(list<Sub_Contractor__c> listSC){
        system.debug('----------------dodgeProcessUtil.notifyScBasedOnTerritory----------Starts-----------');
        List<Messaging.Singleemailmessage> emails = new List<Messaging.Singleemailmessage>();
        String Zip = ''; 
        for(Sub_Contractor__c sc : listSC){
         system.debug('---------- sc.id during notify --------------------' + sc.id);  
            if(sc.Account_billing_zip_code__c != null){
                Zip = getZipCode(sc);
                Branch_Lookup__c bl = null;
                if(mapZipAndBranchLookup.containsKey(Zip)){
                    bl = mapZipAndBranchLookup.get(Zip);
                    User u = null;
                    if(bl.Territory__c != null && mapTerritoryAndUser.containsKey(bl.Territory__c)){
                        u = mapTerritoryAndUser.get(bl.Territory__c);
                        if(u.Email != null){
                            system.debug('---------------u--------'+u);
                            Messaging.Singleemailmessage  mail = sendEmail(u,sc.Account__c, sc.Job_Profile__c, sc.Role__c);          // TFS 3631
                            emails.add(mail);
                        }
                    }
                }
            }
        }
        notifyTheUser(emails);
        system.debug('----------------dodgeProcessUtil.notifyScBasedOnTerritory----------ends-----------'); 
    }
    
    /*********************************************************************
    Purpose     : To notify SC Account owner
    Parameters  : List of Sub_Contractor__c object type
    Returns     : null
    **********************************************************************/
    /*public static void notifyScAccountOwner(list<Sub_Contractor__c> listSC){
        system.debug('----------------dodgeProcessUtil.notifyScAccountOwner----------Starts-----------');
        List<Messaging.Singleemailmessage> emails = new List<Messaging.Singleemailmessage>();
        String Zip = ''; 
        for(Sub_Contractor__c sc : listSC){
            User u = mapUsrIdAndUser.get(sc.Account_Owner__c);
            if(u != null && u.Email != null){
                system.debug('---------------u--------'+u);
                Messaging.Singleemailmessage  mail = sendEmail(u,sc.Account__c, sc.Job_Profile__c);
                emails.add(mail);
            }
        }
        notifyTheUser(emails);
        system.debug('----------------dodgeProcessUtil.notifyScAccountOwner----------ends-----------'); 
    }*/
    
    /*********************************************************************
    Purpose     : To update Job Profile with new ownerId
    Parameters  : List of Job Profile object type
    Returns     : null
    **********************************************************************/
    public static void updateJp(list<Job_Profile__c> lstJpToUpdate){
        system.debug('----------------dodgeProcessUtil.updateJp----------Starts-----------');
        if(lstJpToUpdate.size() > 0){
            system.debug('----------------lstJpToUpdate--------------------'+lstJpToUpdate);
            update lstJpToUpdate;
        }
        system.debug('----------------dodgeProcessUtil.updateJp----------ends-----------'); 
    }
    
    /*********************************************************************
    Purpose     : To notify new owner of Job Profile 
    Parameters  : List of Single email message
    Returns     : null
    **********************************************************************/
    public static void notifyTheUser(List<Messaging.Singleemailmessage> emails){
        system.debug('----------------dodgeProcessUtil.updateJp----------Starts-----------');
        if(emails.size() > 0){
            system.debug('---------------emails--------'+emails);
            Messaging.sendEmail(emails);
        }
        system.debug('----------------dodgeProcessUtil.updateJp----------ends-----------'); 
    }
    
    /*********************************************************************
    Purpose     : To compose the mail with To address, body etc.
    Parameters  : User Object, Account Id, Job Profile Id
    Returns     : Messaging.SingleEmailMessage
    **********************************************************************/
    private static Messaging.SingleEmailMessage sendEmail(User usr, String accountId, String jpId, String Role){
        String Mailbody = '';
        String JpName = mapJpIDAndJpName.containskey(jpId) ? mapJpIDAndJpName.get(jpId) : '';  // TFS 3631
        String MailSubj = '';                                                                  // TFS 3631
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setTargetObjectId(usr.Id);                 // MSM 92
        mail.setSaveAsActivity(false);
        // String[] toAddresses = new String[] {usr.Email}; 
        //String[] ccAddresses = new String[] {'rmaity@teksystems.com'};
        //mail.setToAddresses(toAddresses);
        //mail.setCcAddresses(ccAddresses);
         if(Role == 'Bidder')                                                        // TFS 3631                 
            { Mailsubj = 'Sub Contractor Bidder Added to Job Profile'; }
         else 
            { Mailsubj = 'New Job Profile added in your territory'; } 
        Mailbody = 'Hello '+usr.Name+',<br/><br/></n>A new Job profile is added to your territory.<br/><br/></n>Job Profile Name  :  '+JpName+'<br/><br/></n>Click on following links to view in Salesforce. <br/><br/>Account: '+URL.getSalesforceBaseUrl().toExternalForm()+'/'+accountId+'<br/><br/>Job Profile: '+URL.getSalesforceBaseUrl().toExternalForm()+'/'+jpId+'<br/><br/>';
        Mailbody += '\n\n\n\n\n\nIf using Sales Console, click on these links to view newly added Job profile in Console. <br/><br/>Account: '+URL.getSalesforceBaseUrl().toExternalForm()+'/'+System.Label.Console_URL+accountId+'<br/><br/>Job Profile: '+URL.getSalesforceBaseUrl().toExternalForm()+'/'+System.Label.Console_URL+jpId+'<br/><br/>';
        mail.setHtmlBody(Mailbody);
        mail.setSubject(Mailsubj);                                                 // TFS 3631
        //Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        return mail;
    }
    
    /*********************************************************************
    Purpose     : To create Tasks 
    Parameters  : List of Sub Contractors related to Branch Account Users
    Returns     : void
    **********************************************************************/
    public static void CreateTasksBAsubContractors(List<Sub_Contractor__c> BASubContractorList){
      List<Task> newTasks = new List<Task>();
      String jobProfileID = '';
      String OwnerUserID = '';
      
      initialize(BASubContractorList);  
      
       for(Sub_Contractor__c subc  : BASubContractorList){
         if(subc.Account_billing_zip_code__c <> NULL && mapZipAndTerritory.containskey(getZipCode(subc)))
          {  if(mapTerritoryAndUser.containskey(mapZipAndTerritory.get(getZipCode(subc))))  
            {   User u = mapTerritoryAndUser.get(mapZipAndTerritory.get(getZipCode(subc)));
              
              date opptyCloseDate = date.today();
              jobProfileID = subc.Job_Profile__c;
              OwnerUserID = u.ID;
              
              newTasks.add(new Task( Lead_Rating__c = 'Hot (Probably Order)', Subject = 'Sub Contractor Awarded Bid', ActivityDate = opptyCloseDate, WhatId = subc.Account__c, Call_Type__c = 'Job Profile Follow Up', Job_Profile_Id__c = jobProfileID.subString(0,15), OwnerId = OwnerUserID.subString(0,15)));
          }
         }
      }
      if(newTasks.size() > 0 )
     { insert newTasks; }
   }
    
    /*********************************************************************
    Purpose     : To filter SC of Job Profile Status other than Completed & Abandoned  
    Parameters  : Complete List of Sub Contractors 
    Returns     : Filtered List of Sub Contractors
    **********************************************************************/
    private static List<Sub_Contractor__c> GetscRelatedToActiveJB(List<Sub_Contractor__c> cmplistSC){
     system.debug('---------- cmplistSC --------------------' + cmplistSC);
     system.debug('---------- cmplistSC.size() --------------------' + cmplistSC.size());
     if(cmplistSC.size() > 0){
     for(Sub_Contractor__c s : cmplistSC)
       {  JBrelatedSCset.add(s.Job_Profile__c); }
       
    for(Job_Profile__c jb : [Select j.OwnerId, j.Id, j.Project_Stage_Status__c From Job_Profile__c j where j.Id in : JBrelatedSCset and j.Project_Stage_Status__c!= 'Completed' and j.Project_Stage_Status__c!= 'Abandoned'])
        {      
          for(integer i =0; i< cmplistSC.size(); i++)
            {  if(jb.id == cmplistSC[i].Job_Profile__c)
                  SClist.add(cmplistSC[i]); 
            }
        }      
    }  
  return SClist;
  }
  
  /*********************************************************************
    Purpose     : To create Sub Contractor list as per Role   
    Parameters  : Complete List of Sub Contractors 
    Returns     : Filtered List of Sub Contractors
    **********************************************************************/
    public static void processSCListasperRole(List<Sub_Contractor__c> allListSC, Boolean isprocess){
     system.debug('---------- allListSC --------------------' + allListSC);
     system.debug('---------- allListSC.size() --------------------' + allListSC.size());
     
     List<Sub_Contractor__c> SCrelatedGCList = new List<Sub_Contractor__c>();
     List<Sub_Contractor__c> SCrelatedCMList = new List<Sub_Contractor__c>();
     List<Sub_Contractor__c> SCrelatedOthersList = new List<Sub_Contractor__c>();

     for(Sub_Contractor__c sc : allListSC){
       
       if(isGeneralContractor(sc))
        { SCrelatedGCList.add(sc);   }
        
       if(isConstructionManager(sc))
        { SCrelatedCMList.add(sc);   }
       
       if(!isGeneralContractor(sc) && !isConstructionManager(sc))
        { SCrelatedOthersList.add(sc); } 
     }
 
   // call method to process all list ..
   
     if(SCrelatedGCList.size() > 0)
       {   AssignOwner(SCrelatedGCList);  } 
    
     if(SCrelatedCMList.size() > 0)
       {   AssignOwner(SCrelatedCMList);  }
        
     if((SCrelatedOthersList.size() > 0) && isprocess)
      {   AssignOwner(SCrelatedOthersList);  }

  }
    
}