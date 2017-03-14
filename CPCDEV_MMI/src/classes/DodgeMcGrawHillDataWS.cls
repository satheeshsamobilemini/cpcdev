/***********************************************************************************************************
Created Date : 27th Jan 2010
Cretaed By : Megha Agarwal(Appirio OffShore)

Usage :This web service class insert Dodge Project from the external webservice xml and also add/remove companies for the dodge Project.

Updated: 2/15/2010 - Mark Schultz

Force country to USA
Added parameter "ExistingAccountOwnedByRep" to Method "newLeadDetails"
Conditionally Add Dodge_Project__C.Zip__c to Delivery_Postal_code__c

Updated: 3/3/2010

Updated logic to Create/Delete Leads on Action Stage "GC Bidding", "Subcontract Award", "Bid Results", and "Permit"

Updated: 3/4/2010

Change logic to match Company to Accounts using FactorKey to using CKMS and Branch ID
Fixed bug where Leads were not deleted when a company was removed from the bidder list

Updated: 3/16/2010

Change logic to not send leads on GC Bidding

Updated: 3/24/2020

Add new field: Country for Projects and Companies

Modified on : 3/25/2010  : by - Appirio Offshore (Prafull Gupta)
Updated logic as mentioned in the request PR-04137

***********************************************************************************************************/
global class DodgeMcGrawHillDataWS{
  global static Map<String,Map<String,Company__c>> companiesMap;
  global static Set<String> errorProjectReportNumberSet;
  global static set<String> errorCompanyFactorKeySet;
  global static Set<String> factoryKeySet = new Set<String>();
  global static Set<String> CKMSSet = new Set<String>();
  global static List<Map<String,Account>> accounts = new List<Map<String,Account>>();
  global static List<Lead> newLeadList;
  global static Boolean dodgeProjectErrorFlag;
  global static List<String> errorStringList;
  global static String debugString;
  
  global static Map<String, String> dodgeReportNumtoZip = new Map<String, String>();
  global static List<String> zipList = New List<String>();
  global static Map<String, String> ZipToBranch = new Map<String, String>();
  global static Map<String, String> servicingBranches = new Map<String, String>();
  
  global static Map<String, String> countryMap = new Map <String, String>();
  global static List<Company__c> hotLeadsCompanies = new List<Company__c>();
  global static List<Company__c> warmLeadsCompanies = new List<Company__c>();
  global static Map<String,Dodge_Project__c> lstDodgeProjectsToUpdate = new Map<String,Dodge_Project__c>();
  
  webservice static String loadProjects(String xml){
    countryMap.put('United States', 'USA');
    countryMap.put('USA', 'USA');
    countryMap.put('US', 'USA');
    countryMap.put('Canada', 'CA');
    countryMap.put('Can', 'CA');
    countryMap.put('CA', 'CA');
    
    // List of Leads to create after company creation/updation
    List<Lead> leadsToInsert = new List<Lead>();
    List<Dodge_Project__c> lstExistingProjects = new List<Dodge_Project__c>();
    List<Dodge_Project__c> lstNewProjects = new List<Dodge_Project__c>();
    Map<String,Map<String,Company__c>> existingCompanyMap = new Map<String,Map<String,Company__c>>();
    Set<String> existingDeletedFactorKeySet=new Set<String>();
    Set<String> existingDeletedCOmpanyProjectIdSet = new Set<String>();
    Set<String> existingDeletedCompanyIdSet = new Set<String>();
    List<Set<Id>> companyIdSetForLead = new List<Set<Id>>();
    Set<String> dodgeReportNumberSet = new Set<String>();
    Set<String> statusChangedIdSet = new Set<String>();
    Set<String> existingCompanySet = new Set<String>();
    Set<String> newCompanySet = new Set<String>();
    Map<String,Company__c> newCompanyMap = new Map<String,Company__c>(); 
    String resultString = '';
    Boolean existCompanyFlag;
    Map<String,Dodge_Project__c> newExistingProjectMap = new Map<String,Dodge_Project__c>();
    Map<String,Dodge_Project__c> oldExistingProjectMap = new Map<String,Dodge_Project__c>();
    
    String projectId;
    List<Company__c> companiesList = new List<Company__c>();
    Map<String,Company__c> projectComaniesMap = new  Map<String,Company__c>();
    companiesMap = new Map<String,Map<String,Company__c>>();
    errorProjectReportNumberSet = new Set<String>();
    errorCompanyFactorKeySet = new Set<String>();
    newLeadList = new List<Lead>();
    Savepoint dodgeProjectSavePoint;
    //Boolean addCKMS = false;
    
    list<DodgeFeed__c> df = DodgeFeed__c.getAll().values();  // TFS 4430 - new Dodge Feed process 
    Boolean flagvalue = df[0].Flagvalue_Set__c;
    
    try {
       
       // TFS 4430 - new Dodge Feed process 
      if(flagvalue) {    
    
      // Get Record Type for Lead (Dodge Lead)
      List<RecordType> dodgeRTLst = [select Id ,Name from RecordType where Name ='Dodge Lead' and SobjectType ='Lead'];
      RecordType dodgeRT;
      if(dodgeRTLst!=null && dodgeRTLst.size()>0){
        dodgeRT = dodgeRTLst.get(0);
      }
      //
      //Parse XML and get List of projects 
      Map<String,Dodge_Project__c> parsedProjectMap = parseXML(xml);
      System.Debug('project List '+parsedProjectMap);
      
      // build a map of Zip code to servicing branch
      Branch_Lookup__c[] bl = [Select id, zip__c, Branch_Code__c from Branch_lookup__c where zip__c in :zipList];
      for(Branch_Lookup__c blRecord : bl){
        if(!ZipToBranch.containsKey(blRecord.Zip__c)){
          ZipToBranch.put(blRecord.Zip__c, blRecord.Branch_Code__c);
        }
        if (!servicingBranches.containsKey(blRecord.Branch_Code__c)){
          servicingBranches.put(blRecord.Branch_Code__c, blRecord.Branch_Code__c);
        }
      }
      
      dodgeProjectErrorFlag = true;
      errorStringList = new List<String>();
      //set save point for transaction
      dodgeProjectSavePoint = Database.setSavepoint();
      
      // Get Existing Project from database
      for(Dodge_project__c existingProj : [select Id,Name,Action_Stage__c,Dodge_Report_Number__c,Job_Profile_Status__c from Dodge_project__c where Dodge_Report_Number__c in :parsedProjectMap.keySet()]){
        Dodge_Project__c dodgeProject = new Dodge_Project__c();
        dodgeProject.Action_Stage__c = existingProj.Action_Stage__c !=  NULL ? existingProj.Action_Stage__c : NULL ;
        dodgeProject.Dodge_Report_Number__c = existingProj.Dodge_Report_Number__c;
        oldExistingProjectMap.put(dodgeProject.Dodge_Report_Number__c,dodgeProject);
        Dodge_project__c updatedDodgeProj = parsedProjectMap.get(existingProj.Dodge_Report_Number__c);
        //System.Debug('status : '+existingProj.Action_Stage__c+ 'Dodge Number before '+existingProj.Dodge_Report_Number__c);
        // if(updatedDodgeProj.Action_Stage__c!=existingProj.Action_Stage__c  && ((updatedDodgeProj.Action_Stage__c.contains('Bid Results') && existingProj.Action_Stage__c.equals('Bidding'))||(updatedDodgeProj.Action_Stage__c.contains('Bidding') && existingProj.Action_Stage__c.equals('Bid Results')))){
        //if(updatedDodgeProj.Action_Stage__c!=existingProj.Action_Stage__c  && ( (updatedDodgeProj.Action_Stage__c.contains('Bid Results') && (existingProj.Action_Stage__c.equals('Bidding') || existingProj.Action_Stage__c.equals('GC Bidding') || existingProj.Action_Stage__c.equals('Subcontract Award')) ) || (updatedDodgeProj.Action_Stage__c.contains('Subcontract Award') && (existingProj.Action_Stage__c.equals('Bidding') || existingProj.Action_Stage__c.equals('GC Bidding') || existingProj.Action_Stage__c.equals('Bid Results')) ) || (updatedDodgeProj.Action_Stage__c.contains('GC Bidding') && (existingProj.Action_Stage__c.equals('Bidding') || existingProj.Action_Stage__c.equals('Subcontract Award') || existingProj.Action_Stage__c.equals('Bid Results')))) ){
        //if( updatedDodgeProj.Action_Stage__c!=existingProj.Action_Stage__c  && ( updatedDodgeProj.Action_Stage__c.contains('Bid Results') || updatedDodgeProj.Action_Stage__c.contains('Subcontract Award') || updatedDodgeProj.Action_Stage__c.contains('GC Bidding')) ){
        if( updatedDodgeProj.Action_Stage__c!=existingProj.Action_Stage__c  && ( updatedDodgeProj.Action_Stage__c.contains('Bid Results') || updatedDodgeProj.Action_Stage__c.contains('Subcontract Award')) ){
          statusChangedIdSet.add(existingProj.Id);
        }
        existingProj = updateDodgeDetails(updatedDodgeProj,existingProj);
        newExistingProjectMap.put(existingProj.Dodge_Report_Number__c,existingProj);
        
        parsedProjectMap.remove(existingProj.Dodge_Report_Number__c);
      }
      
      //Save New projects . parsedProjectMap contains new prjs only
      String res = saveProjects(parsedProjectMap.values());
      resultString = resultString + res ;
      //System.Debug('Result String after New Projects are inserted :'+resultString);
      //Save companies of new Projects
      String mailBody = '';
      debugString ='';
      for(Dodge_project__c dodgeProj : parsedProjectMap.values()){
        if(!errorProjectReportNumberSet.contains(dodgeProj.Dodge_Report_Number__c)){
          projectComaniesMap = companiesMap.get(dodgeProj.Dodge_Report_Number__c);
          //System.Debug('New Id'+ dodgeProj.Id);
          projectId = dodgeProj.Id;
          for(Company__c company : projectComaniesMap.values()){
            company.Dodge_Project__c = projectId;
            // create lead/project details to create/update
            SetLeadProjectMapsData(company, null, null, parsedProjectMap);
          }
          
          companiesList.addAll(projectComaniesMap.values());
          //System.Debug('CompaniesList Size before while '+companiesList.size());
          if(companiesList.size()>161){
            // insert companiesList;
            debugString = debugString+'\nIn while loop';
            List<Company__c> newCompList = new List<Company__c>();
            for(Integer i=companiesList.size()-1;i>=161;i--){
              newCompList.add(companiesList.get(i));
              companiesList.remove(i);
            }
            String resComp = saveCompanies(companiesList);
            resultString = resultString + resComp;
            companiesList.clear();
            companiesList.addAll(newCompList);
          }
        }
      }
      
      if(companiesList.size()>0){
        String resComp = saveCompanies(companiesList);
        resultString = resultString + resComp;
        //System.Debug('Result String after new companies for New Projects are inserted :'+resultString);
      }
      
      // existing project code
      //System.Debug('Existing Project List'+lstExistingProjects.size());
      //update existing projects
      String resUpdateProj= updateProjects(newExistingProjectMap.values());
      resultString = resultString + resUpdateProj;
      //System.Debug('Result String after existing Projects are updated :'+resultString);
      Map<String,Company__c> existingCompMap = new Map<String,Company__c>();
      Map<String,Company__c> existingProjectNewCompanyMap = new Map<String,Company__c>();
      Map<String,Company__c> existingProjectNewCompanyUpdatedMap = new Map<String,Company__c>();
      List<Company__c> existingProjectRemoveCompanyList = new List<Company__c>();
      
      //Get existing companies of existing Dodge Projects
      Set<id> LeadsToDeleteCompId = new Set<id> ();
      Set<id> LeadsToDeleteDodgeId = new Set<id> ();
      String oldFactorType = '';
      String oldRank = '';
      for(Company__c company : [select Id,Name,Dodge_Project__c,Dodge_project__r.Name,Dodge_Project__r.Dodge_Report_Number__c,Dodge_Report_Number__c,Factor_Type__c,FactorKey__c,CKMS__c,Company_URL__c,Company_Name__c,Zip__c,Rank__c,Bid_Amount__c from Company__c where dodge_Project__c in : newExistingProjectMap.values()]){
        Map<String,Company__c> compMap = existingCompanyMap.get(company.Dodge_Project__r.Dodge_Report_Number__c);
        Map<String,Company__c> newCompMap = companiesMap.get(company.Dodge_Project__r.Dodge_Report_Number__c);
        if(compMap == null){
          compMap = new Map<String,Company__c>();
        }
        
        if(!newCompMap.containsKey(company.FactorKey__c)){
          //System.Debug('Remove Company : '+company.FactorKey__c);
          existingProjectRemoveCompanyList.add(company);
          LeadsToDeleteCompId.add(company.Id);
          LeadsToDeleteDodgeId.add(company.Dodge_Project__c);
          if(LeadsToDeleteCompId.size()==161){
            List<Lead> lstLead = [Select Id ,Name from Lead where status='Open' and CompanyId__c in :LeadsToDeleteCompId AND Dodge_Project__c in :LeadsToDeleteDodgeId ];
            String deleteLeadRes = deleteLeads(lstLead); 
            resultString = resultString + deleteLeadRes;
            LeadsToDeleteCompId.clear();
          }
          if(existingProjectRemoveCompanyList.size()==161){
            String deleteRes = deleteCompanies(existingProjectRemoveCompanyList);
            resultString = resultString + deleteRes;
            existingProjectRemoveCompanyList.clear();
          }
        }else{
          oldFactorType = company.Factor_Type__c;
          oldRank = company.Rank__c;
          compMap.put(company.FactorKey__c,company);
          existingCompanyMap.put(company.Dodge_Project__r.Dodge_Report_Number__c,compMap);
          
          // Put update Company to the existingCompMap (March 25, 2010)
          existingCompMap.put(company.FactorKey__c, UpdateCompanyDetails(newCompMap.get(company.FactorKey__c), company));
          
          
          // create lead/project details to create/update
          SetLeadProjectMapsData(company, oldFactorType, oldRank, newExistingProjectMap);
          
          // check if the lead associated with this company needs to be deleted
          if(IsFactorTypeChanged(newCompMap.get(company.FactorKey__c).Factor_Type__c, company.Factor_Type__c)){
            LeadsToDeleteCompId.add(company.Id);
            LeadsToDeleteDodgeId.add(company.Dodge_Project__c);
          }
          //
        }
      }
      
      // Update Existing Companies (March 25, 2010)
      String resUpdateCompanies = updateCompanies(existingCompMap.values()); 
      resultString = resultString + resUpdateCompanies;
      
      //System.Debug('Lead To be deleted for'+LeadsToDeleteCompId);
      if(LeadsToDeleteCompId.size()>0){
        List<Lead> lstLead = [Select Id ,Name from Lead where status='Open' and CompanyId__c in : LeadsToDeleteCompId AND Dodge_Project__c in :LeadsToDeleteDodgeId];
        String deleteLeadRes = deleteLeads(lstLead); 
        //System.Debug('Leads are deleted');
        resultString = resultString + deleteLeadRes;
      }
      
      /*
      //delete all leads if dodgeProject status is changed
      List<Lead> lstLead = [Select Id ,Name from Lead where status='Open' and dodge_Project__c in : statusChangedIdSet];
      system.debug('$$$$ --> lstLead: ' + lstLead);
      if(lstLead.size()>0){
        String deleteLeadRes1 = deleteLeads(lstLead); 
        resultString = resultString + deleteLeadRes1;
      }
      */
      
      //System.Debug('Deleted Company List'+existingProjectRemoveCompanyList);
      //delete the companies 
      if(existingProjectRemoveCompanyList.size()>0){
        String deleteRes = deleteCompanies(existingProjectRemoveCompanyList);
        resultString = resultString +deleteRes;
      }
      
      for(String dodgeReportNumber :existingCompanyMap.keySet()){
        if(!errorProjectReportNumberSet.contains(dodgeReportNumber)){
          Map<String,Company__c> compMap = existingCompanyMap.get(dodgeReportNumber);
          Map<String,Company__c> newCompMap = companiesMap.get(dodgeReportNumber);
          for(Company__c newComp : newCompMap.values()){
            if(!compMap.containsKey(newComp.FactorKey__c)){
              newComp.Dodge_Project__c = newExistingProjectMap.get(dodgeReportNumber).id;
              newCompanySet.add(newComp.factorKey__c);
              //System.Debug('New Company'+newComp.Id);
              existingProjectNewCompanyMap.put(newComp.factorKey__c,newComp);
            }else{
              existingCompanySet.add(newComp.FactorKey__c);
            }
            if(existingProjectNewCompanyMap.size()==161){
              String resNewComp = saveCompanies(existingProjectNewCompanyMap.values());
              resultString = resultString + resNewComp;
              //System.Debug('Result String after new companies for existing Projects are inserted :'+resultString);
              existingProjectNewCompanyUpdatedMap.putAll(existingProjectNewCompanyMap);
              existingProjectNewCompanyMap.clear();
            }
          }
        }
      }
      
      //System.Debug('New Company List'+existingProjectNewCompanyMap.values());
      if(existingProjectNewCompanyMap.size()>0){
        // save new Companies of existing dodge project
        String resNewComp = saveCompanies(existingProjectNewCompanyMap.values());
        resultString = resultString+ resNewComp;
        existingProjectNewCompanyUpdatedMap.putAll(existingProjectNewCompanyMap);
        //System.Debug('Result String after new companies for existing Projects are inserted :'+resultString);
      }
      
      
      //
      for(Company__c company : existingProjectNewCompanyUpdatedMap.values()){
        // create lead/project details to create/update
        SetLeadProjectMapsData(company, null, null, newExistingProjectMap);
      }
      
      
      // Update Dodge Project to indicate that GC has identified. 
      System.Debug('---List to project update---'+lstDodgeProjectsToUpdate.values());
      String updateProjs = updateProjects(lstDodgeProjectsToUpdate.values());
      resultString = resultString + updateProjs;
      //
      
      //Compare Accounts to Company
      
      User branchAccountUser;
      List<User> userList = [select Id,Name from User where Name ='Branch Account'];
      if(userList!=null && userList.size()>0){
        branchAccountUser = userList.get(0);
      }
      
      //Get accounts 
      
      /*
      
      // Matches Accounts with FactorKeys
      // this is now replaced with matching accounts by CKMS and Branch ID
      
      accounts = new List<Map<String,Account>>();
      Map<String,Account> accountMap=  new Map<String,Account>();
      for(Account account :[select Id,Name,FactorKey__c,ownerId from Account where FactorKey__c in :factoryKeySet]){
        accountMap.put(account.FactorKey__c,account);
        //System.Debug('Account FactorKey '+account.FactorKey__c);
        if(accountMap.size() == 999){
        accounts.add(accountMap);
          accountMap=  new Map<String,Account>();
        }
      }
      if(accountMap.size()>0){
        accounts.add(accountMap);
      }
      
      */
      /*
      system.debug('$$$$$ --> CKMSSet: ' + CKMSSet);
      system.debug('$$$$$ --> servicingBranches: ' + servicingBranches);
      accounts = new List<Map<String,Account>>();
      Map<String,Account> accountMap=  new Map<String,Account>();
      for(Account account :[select Id,Name,FactorKey__c,CKMS__c,Branch__c,ownerId,Parent_Account_Type__c from Account where CKMS__c in :CKMSSet AND Branch__c in :servicingBranches.keySet()]){
        accountMap.put(account.CKMS__c + ':' + account.Branch__c,account);
        //System.Debug('Account FactorKey '+account.FactorKey__c);
        if(accountMap.size() == 999){
          accounts.add(accountMap);
          accountMap = new Map<String,Account>();
        }
      }
      if(accountMap.size()>0){
        accounts.add(accountMap);
      }
      */
      // Get Accounts (Only for the companies identified as GC/Low Bidder having )
      system.debug('$$$$$ --> CKMSSet: ' + CKMSSet);
      system.debug('$$$$$ --> Postal Codes (Branch Codes): ' + ZipToBranch);
      accounts = new List<Map<String,Account>>();
      Map<String,Account> accountMap=  new Map<String,Account>();
      List<Account> QueryAccountList = new List<Account>(); 
      Set<ID> QueryAccountSet = new Set<ID>();
      for(Account account :[select Id, Name, FactorKey__c, CKMS__c, Branch__c, ownerId, Parent_Account_Type__c, Owner.IsActive,CreatedDate from Account where CKMS__c in :CKMSSet AND Branch__c in :ZipToBranch.values() AND Owner.IsActive = True ORDER BY CreatedDate DESC LIMIT 49000]){
        accountMap.put(account.CKMS__c + ':' + account.Branch__c, account);
        //System.Debug('Account FactorKey '+account.FactorKey__c);
        if(accountMap.size() == 49000){
          accounts.add(accountMap); 
          QueryAccountList.addAll(accountMap.values());
          accountMap = new Map<String,Account>();
           
          for(Account a : QueryAccountList)
          {  QueryAccountSet.add(a.id); 
          }
           
         for(Account a : [select Id, Name, FactorKey__c, CKMS__c, Branch__c, ownerId, Parent_Account_Type__c, Owner.IsActive,CreatedDate from Account where CKMS__c in :CKMSSet AND Branch__c in :ZipToBranch.values() AND Owner.IsActive = True AND Id NOT IN : QueryAccountSet ORDER BY CreatedDate DESC LIMIT 49000]){   
            accountMap.put(account.CKMS__c + ':' + account.Branch__c, account);
            //System.Debug('Account FactorKey '+account.FactorKey__c);
        }
      } 
    }
      if(accountMap.size()>0){
        accounts.add(accountMap);
      }
      system.debug('$$$$$ --> accountMap.keySet: ' + accountMap.keySet());
      
      //Lead to company 
      //Loop over Companies companiesMap
      
      // common code for both existing or new code
      /*Map<String,Dodge_Project__c> CompanyFactoryKeyMap = new Map<String,Dodge_Project__c>();
      for(String dodgeReportNumber : companiesMap.keySet()){
        if(!errorProjectReportNumberSet.contains(dodgeReportNumber)){
          Dodge_Project__c dodgeProject = oldExistingProjectMap.get(dodgeReportNumber);
          //Existing Project comparison for Account Found
          if(dodgeProject!=null){
            //if Project status is changed
            //System.Debug(' old Project Status'+dodgeProject.Action_Stage__c);
            //System.Debug('New Project Staus'+newExistingProjectMap.get(dodgeReportNumber).Action_Stage__c);
            if(newExistingProjectMap.get(dodgeReportNumber) != null && dodgeProject.Action_Stage__c!=newExistingProjectMap.get(dodgeReportNumber).Action_Stage__c){
              //if new status is 'Bid Results' or 'Subcontract Award'
              //if(newExistingProjectMap.get(dodgeReportNumber).Action_Stage__c.equals('GC Bidding') || newExistingProjectMap.get(dodgeReportNumber).Action_Stage__c.equals('Subcontract Award') || newExistingProjectMap.get(dodgeReportNumber).Action_Stage__c.equals('Bid Results')){
              if(newExistingProjectMap.get(dodgeReportNumber).Action_Stage__c.equals('Subcontract Award') || newExistingProjectMap.get(dodgeReportNumber).Action_Stage__c.equals('Bid Results')){
                //System.Debug('Status True'+ newExistingProjectMap.get(dodgeReportNumber).Action_Stage__c);        
                for(Company__c comp : companiesMap.get(dodgeReportNumber).values()){
                  if(!errorCompanyFactorKeySet.contains(comp.factorKey__c)){
                    //CompanyFactoryKeyMap.put(comp.factorKey__c,newExistingProjectMap.get(dodgeReportNumber));
                    
                    // Check to see if Status != "Bid Results" 
                    // OR if Status = "Bid Results" AND Company.FactorType contains Contractor, General Contractor, or GC
                    if ( !newExistingProjectMap.get(dodgeReportNumber).Action_Stage__c.equals('Bid Results') || ( newExistingProjectMap.get(dodgeReportNumber).Action_Stage__c.equals('Bid Results') && ( (comp.Factor_Type__c.contains('General Contractor')) || (comp.Factor_Type__c.contains('GC')) || (comp.Factor_Type__c.contains('Contractor')) ) ) ){
                      resultString = resultString +  CreateLead( comp.factorKey__c,  branchAccountUser,newExistingProjectMap.get(dodgeReportNumber), comp, dodgeRT);
                    }
                  }
                }
              }
            }
            // New companies bidding on existing project
            //If old status is 'Bid Results' or 'Subcontract Award'
            //else if(dodgeProject.Action_Stage__c=='Bid Results' || dodgeProject.Action_Stage__c=='GC Bidding' || dodgeProject.Action_Stage__c=='Subcontract Award'){
            else if(dodgeProject.Action_Stage__c=='Bid Results' || dodgeProject.Action_Stage__c=='Subcontract Award'){
              for(Company__c comp : companiesMap.get(dodgeReportNumber).values()){
                if(newCompanySet.contains(comp.FactorKey__c) && !(errorCompanyFactorKeySet.contains(comp.factorKey__c))){
                  // Check to see if Status != "Bid Results" 
                  // OR if Status = "Bid Results" AND Company.FactorType contains Contractor, General Contractor, or GC
                  if ( !newExistingProjectMap.get(dodgeReportNumber).Action_Stage__c.equals('Bid Results') || ( newExistingProjectMap.get(dodgeReportNumber).Action_Stage__c.equals('Bid Results') && ( (comp.Factor_Type__c.contains('General Contractor')) || (comp.Factor_Type__c.contains('GC')) || (comp.Factor_Type__c.contains('Contractor')) ) ) ){
                    resultString = resultString +  CreateLead( comp.factorKey__c,  branchAccountUser,newExistingProjectMap.get(dodgeReportNumber), comp, dodgeRT);
                  }
                }
              }
            }
          }else{
            dodgeProject = parsedProjectMap.get(dodgeReportNumber);
            //System.Debug('New Project Staus'+allProjectMap.get(dodgeReportNumber).Action_Stage__c);
            //if(dodgeProject!=null && (dodgeProject.Action_Stage__c=='Bid Results' || dodgeProject.Action_Stage__c=='GC Bidding' || dodgeProject.Action_Stage__c=='Subcontract Award' || dodgeProject.Action_Stage__c=='Permit')){
            if(dodgeProject!=null && (dodgeProject.Action_Stage__c=='Bid Results' || dodgeProject.Action_Stage__c=='Subcontract Award' || dodgeProject.Action_Stage__c=='Permit')){
              system.debug(companiesMap.get(dodgeReportNumber).values());
              for(Company__c comp : companiesMap.get(dodgeReportNumber).values()){
                if(parsedProjectMap.get(dodgeReportNumber)!=null && !(errorCompanyFactorKeySet.contains(comp.factorKey__c))){
                  //System.Debug('All Not NULL'+parsedProjectMap.get(dodgeReportNumber).id);
                  
                  // Check to see if Status != "Bid Results" 
                  // OR if Status = "Bid Results" AND Company.FactorType contains Contractor, General Contractor, or GC
                  //if ( !newExistingProjectMap.get(dodgeReportNumber).Action_Stage__c.equals('Bid Results') || ( newExistingProjectMap.get(dodgeReportNumber).Action_Stage__c.equals('Bid Results') && ( (comp.Factor_Type__c.contains('General Contractor')) || (comp.Factor_Type__c.contains('GC')) || (comp.Factor_Type__c.contains('Contractor')) ) ) ){
                  if ( !dodgeProject.Action_Stage__c.equals('Bid Results') || ( dodgeProject.Action_Stage__c.equals('Bid Results') && ( (comp.Factor_Type__c.contains('General Contractor')) || (comp.Factor_Type__c.contains('GC')) || (comp.Factor_Type__c.contains('Contractor')) ) ) ){
                    resultString = resultString +  CreateLead( comp.factorKey__c,  branchAccountUser, dodgeProject, comp, dodgeRT);
                  }
                }
              }
            }
          }
        }
      }*/
      for(Company__c hotLeadComp  : hotLeadsCompanies ) {
        if(newExistingProjectMap.containsKey(hotLeadComp.dodge_Report_Number__c)){
            CreateLead(hotLeadComp.factorKey__c, branchAccountUser,newExistingProjectMap.get(hotLeadComp.dodge_Report_Number__c), hotLeadComp, dodgeRT,'Hot (Probably Order)'); 
            }
        else
            CreateLead(hotLeadComp.factorKey__c, branchAccountUser,parsedProjectMap.get(hotLeadComp.dodge_Report_Number__c), hotLeadComp, dodgeRT,'Hot (Probably Order)'); 
      }
      
      for(Company__c warmLeadComp  : warmLeadsCompanies ) {
        if(newExistingProjectMap.containsKey(warmLeadComp.dodge_Report_Number__c)){
             CreateLead(warmLeadComp.factorKey__c, branchAccountUser,newExistingProjectMap.get(warmLeadComp.dodge_Report_Number__c), warmLeadComp, dodgeRT,'Warm (Possibly Order)'); 
         }
        else
            CreateLead(warmLeadComp.factorKey__c, branchAccountUser,parsedProjectMap.get(warmLeadComp.dodge_Report_Number__c), warmLeadComp, dodgeRT,'Warm (Possibly Order)');
      }
      
      //System.Debug('Company Factor Map >>'+CompanyFactoryKeyMap);
      System.debug('Newly created lead list '+newLeadList);
      if(newLeadList.size()>0){
        //emailLeads(newLeadList,'megha.agarwal@metacube.com','Body');
        debugString =debugString + 'Mail Detail >>>>>>>>>> mail sent :'+newLeadList.size();
        String leadString = saveLeads(newLeadList);
        resultString = resultString + leadString;
        
        //System.Debug('after Lead inserted string'+resultString);
      }
      
      //Account list of the all companies
      
      //System.Debug('At Last Result String '+resultString);
      if(!dodgeProjectErrorFlag){
        Database.rollback(dodgeProjectSavePoint);
        resultString ='Debug String :'+ debugString + '\n';
        for(String errorString : errorStringList){
          resultString = resultString +'\n'+ errorString;
        }
        resultString = resultString +'\n'+'There are some errors in this chunk. So it is not loaded. Please reload it separately.';
      }else{
        Integer successProjectNumber = newExistingProjectMap.values().size()+ parsedProjectMap.values().size(); 
        resultString = resultString + '\n\n\t' + successProjectNumber +' Dodge Projects are inserted or updated successfully.';
      }
      //resultString = resultString+'\n'+companiesMap.values().size() + ' Companies are inserted or updated successfully';
     } 
   }
    catch(Exception e) {
      if(dodgeProjectSavePoint != null){
        Database.rollback(dodgeProjectSavePoint);
      }
      resultString = 'Debug String :'+ debugString + e.getMessage() + '\n' + e.getLineNumber() + '\n' +  e.getStackTraceString();
    }
    
    return resultString;
  }
  
  /*
  public static Account getAccount(String factorKey){
    Account acc ;
    for(Map<string,Account> accMap : accounts){
      //System.Debug('Factor Key in Account Map'+factorKey);
      //System.Debug('Account Factor keys'+accMap.keySet());
      if(accMap.containsKey(factorKey)){
        acc = accMap.get(factorKey);
        break;
      }
    }
    return acc;
  }
  */
  
  public static Account getAccount(String CKMSBranchId){
    Account acc ;
    for(Map<string,Account> accMap : accounts){
      //System.Debug('Factor Key in Account Map'+factorKey);
      //System.Debug('Account Factor keys'+accMap.keySet());
      if(accMap.containsKey(CKMSBranchId)){
        acc = accMap.get(CKMSBranchId);
        break;
      }
    }
    return acc;
  }
  
  public static String CreateLead(String factorKey, User branchAccountUser,Dodge_Project__c dodgeProject, Company__c dodgeCompany, RecordType dodgeRT,String rating){
    String leadString='';
    String CKMSBranchId = '';
    
    CKMSBranchId = dodgeCompany.CKMS__c + ':';
    if (ZipToBranch.containsKey(dodgeReportNumtoZip.get(dodgeProject.Dodge_Report_Number__c))){
      CKMSBranchId = CKMSBranchId + ZipToBranch.get(dodgeReportNumtoZip.get(dodgeProject.Dodge_Report_Number__c));
    }
    
    Account acc = getAccount(CKMSBranchId);
    if(acc <> null){
      system.debug('$$$$$$$$$$ --> CKMSBranchId: ' + CKMSBranchId + ' - ' + acc);
      //Lead Creation in case of Account is not 'Branch Account'
      if(branchAccountUser != null && acc.ownerId != branchAccountUser.Id){
        Lead newLead = newLeadDetails(dodgeProject, dodgeCompany, dodgeRT, false, false, true, rating);
        // replace the line below so that newLead.OwnerId = the what is returned by the method checkNationalAccount
        // the account user may be inactive... add check for it
     if(newLead <> null){   
        if(acc.Owner.IsActive) {
          newLead.OwnerId = acc.ownerId;
        }else {
          newLead.Auto_Assign_Lead__c = true;
        }
      newLeadList.add(newLead); 
     } 
      }//Lead Creation in case of Account is 'Branch Account'
      else{
        Lead newLead = newLeadDetails(dodgeProject, dodgeCompany, dodgeRT, true, true, false, rating);
        //System.Debug('newLead >> 2'+newLead);
        if(newLead <> null)
     {  newLeadList.add(newLead);  }
      }
    }//Lead Creation in case of Account not found
    else{
      Lead newLead = newLeadDetails(dodgeProject, dodgeCompany, dodgeRT, false, true, false, rating);
      if(newLead <> null)
         { newLeadList.add(newLead);}
    }
    //System.Debug('newLeadList >>'+newLeadList);
    if(newLeadList.size() == 161){
      debugString = debugString + 'new Lead List ' + newLeadList.size();
      //emailLeads(newLeadList,'megh.agar@gmail.com','Body');
      leadString = saveLeads(newLeadList);
      newLeadList.clear();
    }
    return leadString;
  }
  
  public static String checkNationalAccount(Account acct){
    Integer pipePos = 0;
    if (acct.Parent_Account_Type__c != NULL && acct.Parent_Account_Type__c.contains('Platinum')){
      // Find the owner id
      pipePos = acct.Parent_Account_Type__c.indexOf('|');
      return acct.Parent_Account_Type__c.substring(pipePos + 1, acct.Parent_Account_Type__c.length());
    }
    else{
      return acct.ownerId;
    }
  }
  
  public static Map<String,Dodge_Project__c> parseXML(String xml){
    Map<String,Dodge_Project__c> projects = new  Map<String,Dodge_Project__c>();
    XmlStreamReader reader = new XmlStreamReader(xml);
    try {
      while(reader.hasNext()) {
        XmlTag eventType = reader.getEventType();
        string localName = reader.getLocalName();
        if (eventType == XmlTag.START_ELEMENT && localName != '' && localName.equalsIgnoreCase('project')) {
          Dodge_Project__c project = fillProjectDetails(reader);
          projects.put(project.Dodge_Report_Number__c,project);
        }else if(eventType == XmlTag.END_ELEMENT && localName != '' && localName.equalsIgnoreCase('projects')) {
          //System.Debug('projects xml'+projects);
          return projects;
        }
        reader.next();
      }
    }
    catch(Exception e) {
      //System.Debug(e);
    }
    return projects;
  }
  
  public static String getText(XmlStreamReader reader) {
    String attributeRes='';
    while(reader.hasNext()) {
      XmlTag eventType = reader.getEventType();
      
      if (eventType == XmlTag.END_ELEMENT){
        break;
      }
      else if(eventType == XmlTag.CHARACTERS){
        attributeRes += reader.getText();
      }
      reader.next();
    }
    return attributeRes;
  }
  
  public static Dodge_Project__c fillProjectDetails(XmlStreamReader reader){
    Dodge_Project__c prj = new Dodge_Project__c();
    Project proj = new Project();
    String convertedZip = '';
    reader.next();
    while(reader.hasNext()) {
      XmlTag eventType = reader.getEventType();
      string localName = reader.getLocalName();
      if (eventType == XmlTag.START_ELEMENT && localName!='' && localName.equalsIgnoreCase('Companies')) {
        //System.Debug('------Comapnies------');
        //
        if (proj.Properties.get('ZipCode') != NULL && proj.Properties.get('ZipCode') != '' && proj.Properties.get('Country') != NULL && proj.Properties.get('Country') != ''){
            convertedZip = AssignmentRules.getConvertedZipCode(proj.Properties.get('ZipCode'), proj.Properties.get('Country'));
            dodgeReportNumtoZip.put(proj.Properties.get('DodgeReportNumber'), convertedZip);
            zipList.add(convertedZip);
        }
        
        companiesMap.put(proj.Properties.get('DodgeReportNumber'),fillCompaniesMap(reader));
        
        System.debug('$$$$ --> companiesMap.keySet: ' + companiesMap.keySet());
        
      }else if (eventType == XmlTag.START_ELEMENT && localName!='' ){
        proj.Properties.put(localName,getText(reader));
        
      } else if (eventType == XmlTag.END_ELEMENT && localName != '' && localName.equalsIgnoreCase('project')) {
        prj = getDodgeProject(proj);
        return prj;
      }
      reader.next();
    }
    return prj;
  }
  
  public static Dodge_Project__c getDodgeProject(Project proj){
    Dodge_Project__c prj = new Dodge_Project__c();
    prj.Project_Name__c = proj.Properties.get('ProjectName');
    prj.Project_URL__c = proj.Properties.get('ProjectURL');
    prj.Dodge_Report_Number__c = proj.Properties.get('DodgeReportNumber');
    prj.Dodge_Report_Date__c = XMLstringToDate(proj.Properties.get('DodgeReportDate'));
    prj.Action_Stage__c = proj.Properties.get('ActionStage');
    prj.Market_Segment__c = proj.Properties.get('MarketSegment');
    prj.Primary_Project_Type__c = proj.Properties.get('PrimaryProjectType');
    prj.Bid_Date__c = XMLstringToDate(proj.Properties.get('BidDate'));
    prj.Project_Valuation_String__c = proj.Properties.get('ProjectValuation');
    prj.Secondary_Project_Types__c = proj.Properties.get('SecondaryProjectTypes');
    prj.Spec_Alerts__c = proj.Properties.get('SpecAlerts');
    prj.Status_Text__c = proj.Properties.get('StatusText');
    prj.Address_1__c = proj.Properties.get('Address1');
    prj.Address_2__c = proj.Properties.get('Address2');
    prj.City__c = proj.Properties.get('CityName');
    prj.County__c = proj.Properties.get('CountyName');
    prj.State__c = proj.Properties.get('StateAbbr');
    prj.Zip__c = proj.Properties.get('ZipCode');
    
    if (countryMap.containsKey(proj.Properties.get('Country'))){
      prj.Country__c = countryMap.get(proj.Properties.get('Country'));
    }
    else{
      prj.Country__c = proj.Properties.get('Country');
    }
    
    prj.Target_Start_Date__c = XMLstringToDate(proj.Properties.get('TargetStartDate'));
    prj.Ownership_Type__c = proj.Properties.get('OwnershipType');
    prj.Type_Of_Work__c = proj.Properties.get('TypeOfWork');
    prj.Number_of_Buildings__c = proj.Properties.get('NumberOfBuildings');
    prj.Sq_Ft__c = proj.Properties.get('SqFt');
    prj.Version__c = proj.Properties.get('Version');
    
    // split project evaluation into Low/High Evaluation
    String[] splitProjEvaluation = prj.Project_Valuation_String__c.replace('$', '').replace(',', '').split('-');
    if(splitProjEvaluation.size() == 2){
      prj.Project_Valuation_Low__c = Double.valueOf(splitProjEvaluation[0]);
      prj.Project_Valuation_High__c = Double.valueOf(splitProjEvaluation[1]);
    }else{
      prj.Project_Valuation_Low__c = prj.Project_Valuation_High__c = Double.valueOf(splitProjEvaluation[0] == '' ? '0': splitProjEvaluation[0]);
    }
    
    return prj;
  }
  
  public static Map<String,Company__c> fillCompaniesMap(XmlStreamReader reader){
    Map<String,Company__c> Companies = new Map<String,Company__c>();
    reader.next();
    while(reader.hasNext()) {
      XmlTag eventType = reader.getEventType();
      string localName=reader.getLocalName();
      if (eventType == XmlTag.START_ELEMENT && localName != '' && localName.equalsIgnoreCase('Company')) {
        Company__c comp = fillCompanyDetails(reader);
        Companies.put(comp.factorKey__c,comp);
        factoryKeySet.add(comp.factorKey__c);
        /*
        // Create a CKMS keySet
        if (CKMSSet.contains(comp.CKMS__c) == false){
          system.debug('$$$$$ --> Added ' + comp.CKMS__c + ' to CKMSSet');
          CKMSSet.add(comp.CKMS__c);
        }
        */
      }else if (eventType == XmlTag.END_ELEMENT && localName != '' && localName.equalsIgnoreCase('Companies')) {
        return Companies;                
      }
      
      reader.next();
    }
    return Companies;
  }
  
  public static Company__c fillCompanyDetails(XmlStreamReader reader){
    Company__c company = new Company__c();
    Company comp = new Company();
    reader.next();
    while(reader.hasNext()) {
      XmlTag eventType = reader.getEventType();
      string localName=reader.getLocalName();
      if (eventType  == XmlTag.START_ELEMENT && !localName.equalsIgnoreCase('TrackingLists') && !localName.equalsIgnoreCase('TrackingList') && !localName.equalsIgnoreCase('User')) {
        comp.properties.put(localName,getText(reader));
      }else if (eventType  == XmlTag.END_ELEMENT && localName != '' && localName.equalsIgnoreCase('Company')) {
        company = getCompany(comp);
        return company;
      }
      reader.next();
    }
    return company;
  }
  
  public static Company__c getCompany(Company comp){
    Company__c company = new Company__c();
    company.Dodge_Report_Number__c = comp.properties.get('DodgeReportNumber');
    company.Factor_Type__c = comp.properties.get('FactorType');
    company.FactorKey__c = comp.properties.get('FactorKey');
    company.CKMS__c = comp.properties.get('CKMS');
    company.Company_URL__c = comp.properties.get('CompanyURL');
    company.Company_Name__c = comp.properties.get('CompanyName');
    company.Phone__c = comp.properties.get('PhoneNumber');
    company.Fax__c = comp.properties.get('FaxNumber');
    company.Address_1__c = comp.properties.get('Address1');        
    company.Address_2__c = comp.properties.get('Address2');
    company.City__c = comp.properties.get('CityName');
    company.County__c =comp.properties.get('CountryName');
    company.State__c = comp.properties.get('StateAbbr');
    company.Zip__c = comp.properties.get('ZipCode');
    if (countryMap.containsKey(comp.properties.get('Country'))){
      company.Country__c = countryMap.get(comp.properties.get('Country'));
    }
    else{
      company.Country__c = comp.properties.get('Country');
    }
    company.Rank__c = comp.properties.get('Rank');
    company.Bid_Amount__c = Decimal.valueOf(comp.properties.get('BidAmount'));
    String[] contact = comp.properties.get('ContactName').split(' ');
    if(contact.size()>2){
      company.First_Name__c = contact[0] + contact[1] ;
      company.Last_Name__c = contact[2];
    }else if(contact.size()==2){
      company.First_Name__c = contact[0];
      company.Last_Name__c = contact[1];
    }else if(contact.size()==1){
      company.First_Name__c = contact[0];
    }
    company.Title__c = comp.properties.get('ContactTitle');
    company.SIC_Code__c = comp.properties.get('SICCode');
    return company;            
  }
  
  /////
  public class Project {
    public Map<String,String> properties;
    public List<Company> Companies;
    Project(){
      properties= new Map<String,String>();
      Companies = new List<Company> (); 
    }   
  }
  
  public class Company {
    public Map<String,String> properties;
    Company(){
      properties = new Map<String,String>();
    }
  }
  
  private static Dodge_Project__c updateDodgeDetails(Dodge_Project__c newDodgeProject,Dodge_Project__c oldDodgeProject){
    oldDodgeProject.Project_Name__c = newDodgeProject.Project_Name__c ;
    oldDodgeProject.Project_URL__c =newDodgeProject.Project_URL__c; 
    oldDodgeProject.Dodge_Report_Date__c = newDodgeProject.Dodge_Report_Date__c; 
    oldDodgeProject.Action_Stage__c =newDodgeProject.Action_Stage__c; 
    oldDodgeProject.Market_Segment__c = newDodgeProject.Market_Segment__c; 
    oldDodgeProject.Primary_Project_Type__c =newDodgeProject.Primary_Project_Type__c; 
    oldDodgeProject.Bid_Date__c = newDodgeProject.Bid_Date__c; 
    oldDodgeProject.Project_Valuation_String__c = newDodgeProject.Project_Valuation_String__c; 
    oldDodgeProject.Secondary_Project_Types__c = newDodgeProject.Secondary_Project_Types__c; 
    oldDodgeProject.Spec_Alerts__c = newDodgeProject.Spec_Alerts__c; 
    oldDodgeProject.Status_Text__c = newDodgeProject.Status_Text__c; 
    oldDodgeProject.Address_1__c = newDodgeProject.Address_1__c ;
    oldDodgeProject.Address_2__c = newDodgeProject.Address_2__c; 
    oldDodgeProject.City__c = newDodgeProject .City__c;
    oldDodgeProject.County__c =newDodgeProject.County__c; 
    oldDodgeProject.State__c = newDodgeProject.State__c; 
    oldDodgeProject.Zip__c = newDodgeProject.Zip__c; 
    
    if (countryMap.containsKey(newDodgeProject.Country__c)){
      oldDodgeProject.Country__c = countryMap.get(newDodgeProject.Country__c);
    }
    else{
      oldDodgeProject.Country__c = newDodgeProject.Country__c;
    }             
    
    oldDodgeProject.Target_Start_Date__c = newDodgeProject.Target_Start_Date__c;
    oldDodgeProject.Ownership_Type__c = newDodgeProject.Ownership_Type__c;
    oldDodgeProject.Type_Of_Work__c = newDodgeProject.Type_Of_Work__c;
    oldDodgeProject.Number_of_Buildings__c = newDodgeProject.Number_of_Buildings__c; 
    oldDodgeProject.Sq_Ft__c = newDodgeProject.Sq_Ft__c ; 
    oldDodgeProject.Version__c =newDodgeProject.Version__c;
    
    // split project evaluation into Low/High Evaluation
    String[] splitProjEvaluation = oldDodgeProject.Project_Valuation_String__c.replace('$', '').replace(',', '').split('-');
    if(splitProjEvaluation.size() == 2){
      oldDodgeProject.Project_Valuation_Low__c = Double.valueOf(splitProjEvaluation[0]);
      oldDodgeProject.Project_Valuation_High__c = Double.valueOf(splitProjEvaluation[1]);
    }else{
      oldDodgeProject.Project_Valuation_Low__c = oldDodgeProject.Project_Valuation_High__c = Double.valueOf(splitProjEvaluation[0] == '' ? '0': splitProjEvaluation[0]);
    }
    
    return oldDodgeProject;          
  }
  
  public static Lead newLeadDetails(Dodge_Project__c  dodgeProject,Company__c dodgeCompany,RecordType recordType,Boolean ExistingAccountOwnedByBranch,Boolean AutoAssignLead,Boolean ExistingAccountOwnedByRep,String rating){
    Lead newLead = new Lead();
    
    if(dodgeProject!=null){
      newLead.Dodge_Project__c = dodgeProject.Id;
      // trim Action Stage to 20 characters only
      // We are having field "Dodge_Action_Stage__c" as Text(20)
      newLead.Dodge_Action_Stage__c = (dodgeProject.Action_Stage__c.length() > 20) ? dodgeProject.Action_Stage__c.subString(0, 20) : dodgeProject.Action_Stage__c;
      
      if (dodgeProject.zip__c!=null && dodgeProject.zip__c!=''){
        newLead.Delivery_Postal_Code__c= dodgeProject.zip__c;
        newLead.Delivery_Country__c = dodgeProject.Country__c;
        
        // Add leading zeros to Delivery Postal Code -- I'm not sure why they are missing
        Integer numMissingDigits = 5 - newLead.Delivery_Postal_Code__c.length();
        
        for (integer i=0;i<numMissingDigits;i++){
          //system.debug('$$$$$$$$ --> Added 0 to: ' + newLead.Delivery_Postal_Code__c);
          newLead.Delivery_Postal_Code__c = '0' + newLead.Delivery_Postal_Code__c;
        }
      }
      
     /* if (dodgeProject.Action_Stage__c == 'Bid Results' || dodgeProject.Action_Stage__c == 'Subcontract Award' || dodgeProject.Action_Stage__c == 'Permit'){
        newLead.Rating = 'Hot (Probably Order)';
      }
      else{
        newLead.Rating = 'Warm (Possibly Order)';
      }*/
      newLead.Rating = rating;
      
    }
    
    if(dodgeCompany!=null){
      newLead.factorKey__c = dodgeCompany.FactorKey__c;
      newLead.CompanyId__c = dodgeCompany.Id;
      newLead.Company = dodgeCompany.Company_Name__c;
      newLead.Phone = dodgeCompany.Phone__c;
      newLead.Fax = dodgeCompany.Fax__c;
      newLead.City = dodgeCompany.City__c;
      newLead.State = dodgeCompany.State__c;
      newLead.PostalCode = dodgeCompany.Zip__c;
      newLead.CKMS__c = dodgeCompany.CKMS__c;
      
      //Address
      if(dodgeCompany.Address_1__c!=null && dodgeCompany.Address_1__c != ''){
        newLead.Street = dodgeCompany.Address_1__c;
      }
      
      if(dodgeCompany.Address_2__c!=null && dodgeCompany.Address_2__c != ''){
        if(newLead.Street != null && newLead.Street !=''){
          newLead.Street = newLead.Street  + ', ' + dodgeCompany.Address_2__c ;
        }
        else{
          newLead.Street = dodgeCompany.Address_2__c ;
        }
      }
      
      if(dodgeCompany.County__c!=null && dodgeCompany.County__c != ''){
        if(newLead.Street != null && newLead.Street !=''){
          newLead.Street = newLead.Street  + ', ' + dodgeCompany.County__c;
        }
        else{
          newLead.Street = dodgeCompany.County__c;
        }
      }
      
      //Name
      if(dodgeCompany.First_Name__c != null ){
        newLead.FirstName = dodgeCompany.First_Name__c;
      }
      else{
        newLead.FirstName ='Lead-' + dodgeCompany.FactorKey__c;
      }
      if(dodgeCompany.Last_Name__c != null && dodgeCompany.Last_Name__c != ''){
        newLead.LastName = dodgeCompany.Last_Name__c;
      }else {
        newLead.LastName='Lead-' + dodgeCompany.FactorKey__c;
      }
      /*
      if(dodgeCompany.Name != null && dodgeCompany.Name != ''){
        List<String> lstName = dodgeCompany.Name.split(' ',2);
        newLead.FirstName = lstName[0];
        if(lstName.size() > 1)
          newLead.LastName = lstName[1];
        else
          newLead.LastName= 'N/A';
      }else{
        newLead.LastName= 'N/A';
      }
      */
    }
    if(recordType!=null){
      newLead.RecordTypeId = recordType.id;
    }
    newLead.Country = dodgeProject.Country__c;
    newLead.status = 'Open'; 
    newLead.LeadSource = 'Dodge';
    newLead.Existing_Account_Owned_By_Branch__c = ExistingAccountOwnedByBranch;
    newLead.Existing_Account_Owned_By_Rep__c = ExistingAccountOwnedByRep;
    newLead.Auto_Assign_Lead__c = AutoAssignLead;
    
    //System.Debug('newLead >> 2'+newLead);
    
    if(dodgeProject.Job_Profile_Status__c  !=  NULL && dodgeProject.Job_Profile_Status__c == 'Removed')
     { return null; }
    
    return newLead; 
  }
    
  public static Date XMLstringToDate(String s){
    //XML Date String is in the format mm/dd/yyyy
    String[] stringDate = s.split('/');
    Date dateFormat = null;
    
    if(stringDate != null && stringDate.size()==3){
      dateFormat =  date.newInstance(Integer.valueOf(stringDate[2]),Integer.valueOf(stringDate[0]),Integer.valueOf(stringDate[1]));
    }else if(StringDate!=null && stringDate.Size()==2){
      dateFormat = date.newInstance(Integer.valueOf(stringDate[1]),Integer.valueOf(stringDate[0]),1);
    }
    return dateFormat;
  }
  
  public static String saveProjects(List<Dodge_Project__c> projectList){
    String resultString ='';
    Database.Saveresult[] newProjectSaveResults = Database.insert(projectList,false);
    Integer projectErrorIndex = 0;
    for(Database.SaveResult newProjSV : newProjectSaveResults){
      if(!newProjSV.isSuccess()){
        Database.Error err = newProjSV.getErrors()[0];
        dodgeProjectErrorFlag = false;
        
        if(projectList.size()>projectErrorIndex && projectList.get(projectErrorIndex)!=null){
          errorStringList.add('\n\tError : '+projectList.get(projectErrorIndex).Dodge_Report_Number__c+ 'Project is not inserted :'+err.getMessage());
          resultString = resultString+'\n\tError : '+projectList.get(projectErrorIndex).Dodge_Report_Number__c+ 'Project is not inserted :'+err.getMessage();
          errorProjectReportNumberSet.add(projectList.get(projectErrorIndex).Dodge_Report_Number__c);
        }
      }else{
        resultString = resultString +'\n\t'+projectList.get(projectErrorIndex).Dodge_Report_Number__c+' project is inserted. ';
        //System.Debug('Save Project Result String with: '+projectErrorIndex+'>>'+resultString);
      }
      projectErrorIndex++;
    }
    return resultString;
  }

  public static String saveCompanies(List<Company__c> companiesList){
    String resultString ='';
    Database.Saveresult[] newCompanySaveResults = Database.insert(companiesList,false);
    Integer companyErrorIndex = 0;
    for(Database.SaveResult newCompSV : newCompanySaveResults){
      if(!newCompSV.isSuccess()){
        Database.Error err = newCompSV.getErrors()[0];
        dodgeProjectErrorFlag = false;
        if(companiesList.size()>companyErrorIndex && companiesList.get(companyErrorIndex)!=null){
          errorStringList.add('\n\tError : '+err.getMessage()+':'+'Company Factor key : '+companiesList.get(companyErrorIndex).factorKey__c);
          resultString = resultString+'\n\tError : '+err.getMessage()+':'+'Company Factor key : '+companiesList.get(companyErrorIndex).factorKey__c;
          errorCompanyFactorKeySet.add(companiesList.get(companyErrorIndex).factorKey__c);
        }
      }else{
        resultString = resultString +'\n\t'+companiesList.get(companyErrorIndex).factorKey__c+' company is inserted for '+companiesList.get(companyErrorIndex).dodge_Report_Number__c+' dodge Project';
        //System.Debug('Save Company Result String with: '+companyErrorIndex+'>>'+resultString);
      }
      companyErrorIndex++;
    }
    return resultString;
  }
  
  public static String updateProjects(List<Dodge_Project__c> projectList){
    String resultString ='';
    Database.Saveresult[] existingProjectSaveResults = Database.update(projectList,false);
    Integer existingProjectErrorIndex = 0;
    for(Database.SaveResult existingProjSV : existingProjectSaveResults){
      if(!existingProjSV.isSuccess()){
        Database.Error err = existingProjSV.getErrors()[0];
        dodgeProjectErrorFlag = false;
        if(projectList.size()>existingProjectErrorIndex && projectList.get(existingProjectErrorIndex)!=null){
          errorStringList.add('\n\tError : '+projectList.get(existingProjectErrorIndex).Dodge_Report_Number__c+ 'Project is not updated :'+err.getMessage());
          resultString = resultString+'\n\tError : '+projectList.get(existingProjectErrorIndex).Dodge_Report_Number__c+ 'Project is not updated :'+err.getMessage();
          errorProjectReportNumberSet.add(projectList.get(existingProjectErrorIndex).Dodge_Report_Number__c);
        }
      }else{
        resultString = resultString +'\n\t'+projectList.get(existingProjectErrorIndex).Dodge_Report_Number__c+' project is updated. ';
        //System.Debug('Updated project Result String with: '+existingProjectErrorIndex+'>>'+resultString);
      }
      existingProjectErrorIndex++;
    }
    return resultString;
  }
  
  public static String saveLeads(List<Lead> leadList){
    // Remove this line!
    //  return 'lead insertion turned off';
    
    //emailLeads(newLeadList, 'megh.agar@gmail.com','');
    // return '';
    String resultString='';
    Database.Saveresult[] leadSaveResults = Database.insert(leadList,false);
    Integer leadErrorIndex = 0;
    for(Database.SaveResult leadSR : leadSaveResults){
      if(!leadSR.isSuccess()){
        Database.Error err = leadSR.getErrors()[0];
        dodgeProjectErrorFlag = false;
        if(leadList.size()>leadErrorIndex && leadList.get(leadErrorIndex)!=null){
          errorStringList.add('\n\tError : Lead is not inserted for for Company Factor Key'+leadList.get(leadErrorIndex).FactorKey__c +':'+ err.getMessage());
          resultString = resultString+'\n\tError : Lead is not inserted for for Company Factor Key'+leadList.get(leadErrorIndex).FactorKey__c +':'+ err.getMessage();
        }
      }else{    
        resultString = resultString +'\n\tLead is inserted for Company Factor Key  '+leadList.get(leadErrorIndex).FactorKey__c;
        //System.Debug('Save Lead Result String with: '+leadErrorIndex+'>>'+resultString);
      }
      leadErrorIndex++;
    }
    return resultString;
  }
  
  public static String deleteCompanies(List<Company__c> companyList){ 
    String resultString='';
    Database.DeleteResult[] companyDeletedResult = Database.delete(companyList,false);
    Integer companyErrorIndex = 0;
    for(Database.DeleteResult companyDR : companyDeletedResult){
      if(!companyDR.isSuccess()){
        Database.Error err = companyDR.getErrors()[0];
        dodgeProjectErrorFlag = false;
        if(companyList.size()>companyErrorIndex && companyList.get(companyErrorIndex)!=null){
          errorStringList.add('\n\tError : Company Factor Key'+companyList.get(companyErrorIndex).FactorKey__c +'is not deleted :'+ err.getMessage());
          resultString = resultString+'\n\tError :Company Factor Key'+companyList.get(companyErrorIndex).FactorKey__c +'is not deleted :'+ err.getMessage();
        }
      }else{
        resultString = resultString +'\n\tCompany and Lead of Factor Key - '+companyList.get(companyErrorIndex).FactorKey__c +' are deleted ';
        //System.Debug('Deleted Company Result String with: '+companyErrorIndex+'>>'+resultString);
      }
      companyErrorIndex++;
    }
    return resultString;
  }
  
  public static String deleteLeads(List<Lead> leadList){
    String resultString='';
    List<Lead> tempLeadList = new List<Lead>();
    tempLeadList.addAll(leadList);
    Database.DeleteResult[] leadDeleteResults = Database.delete(leadList,false);
    Integer leadErrorIndex = 0;
    for(Database.DeleteResult leadDR : leadDeleteResults){
      if(!leadDR.isSuccess()){
        Database.Error err = leadDR.getErrors()[0];
        dodgeProjectErrorFlag = false;
        if(leadList.size()>leadErrorIndex && leadList.get(leadErrorIndex)!=null){
          errorStringList.add('\n\tError : Lead Company Factor Key '+leadList.get(leadErrorIndex).FactorKey__c +' is not deleted :'+ err.getMessage());
          resultString = resultString+'\n\tError : Lead Company Factor Key '+leadList.get(leadErrorIndex).FactorKey__c +' is not deleted :'+ err.getMessage();
        }
      }else if(leadList.size()>leadErrorIndex && leadList.get(leadErrorIndex)!=null){
        //System.Debug('In Lead successfuly deleted cond');
        resultString = resultString+'\n\t Lead is deleted';
        //System.Debug('Lead Lead Result String with: '+leadErrorIndex+'>>'+resultString);
      }
      leadErrorIndex++;
    }
    return resultString;
  }
  
  public static void emailLeads(List<Lead> leadList,String emailId,String body){
    // public static void emailLeads(String emailId,String body){
    /////////////////////
    Set<String> companyNames = new Set<String>();
    Set<String> firstNames = new Set<String>();
    Set<String> postalCodes = new Set<String>();
    Set<String> phones = new Set<String>();
    Set<String> lastNames = new Set<String>();
    String HouseAccountUserName = 'Branch Account';
    String contacts;
    debugString =debugString + '\n IN Mail Method';
    for(Lead l: leadList){
      /*postalCodes  += l.PostalCode + ',';
      companyNames+= l.Company  + ',';
      phones += l.Phone  + ',';
      lastNames += l.LastName +',';
      firstNames += l.FirstName +',';*/
      
      postalCodes.add(l.PostalCode);
      companyNames.add(l.Company );
      phones.add(l.Phone); 
      lastNames.add(l.LastName); 
      firstNames.add( l.FirstName);        
    }
    String queryString = 'Select c.Owner.Name,c.OwnerId,c.MailingStreet, c.MailingPostalCode, '
                              + ' c.LastName, c.FirstName, c.Account.OwnerId,c.Account.Owner.Name, c.Account.BillingPostalCode,' 
                              + ' c.Account.ParentId, c.Account.Type, c.AccountId,c.Account.Owner.LastLeadAllocation__c,c.Account.Owner.Available_For_Leads__c From Contact c'
                              + ' Where c.FirstName in :firstNames'
                              + ' And c.LastName in :lastNames'
                              + ' And c.MailingPostalCode in :postalCodes'
                              + ' AND c.Account.Owner.Name <> :HouseAccountUserName';
    //if (isTest == true)
    //     queryString += ' limit 1';
    
    for(List<Contact> contacts1 : Database.query(queryString)){
      contacts = contacts +'Contacts : '+contacts1;
    }
    debugString =debugString + '\n IN Mail after itration';
    // Create a new single email message object
    // that will send out a single email to the addresses in the To, CC & BCC list.
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    // Strings to hold the email addresses to which you are sending the email.
    String[] toAddresses = new String[] {emailId};
    String[] ccAddresses = new String[] {emailId};
    // Assign the addresses for the To and CC lists to the mail object.
    mail.setToAddresses(toAddresses);
    //mail.setCcAddresses(ccAddresses);
    // Specify the address used when the recipients reply to the email.
    mail.setReplyTo(emailId);
    // Specify the name used as the display name.
    mail.setSenderDisplayName('Assignment rules Log');
    // Specify the subject line for your email address.
    mail.setSubject('Assignment rules Log');
    // Set to True if you want to BCC yourself on the email.
    mail.setBccSender(false); 
    // Optionally append the salesforce.com email signature to the email.
    // The email address of the user executing the Apex Code will be used.
    mail.setUseSignature(false);
    // Specify the text content of the email. 
    mail.setPlainTextBody('');
    mail.setHtmlBody('debug-phones-' + phones + ' <br/> companyNames-' + companyNames + '<br/> postalCodes-' + postalCodes + '<br/> firstNames-' + firstNames + '<br/> lastNames-' + lastNames+'<br/> conatcts :'+contacts);
    //mail.setHtmlBody('Original Body \n'+ body);
    // Send the email you have created.
    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    debugString =debugString + '\n IN Mail after mail sent';
    // return 'Success';   
    ///////////////////// 
  }
   
  /**
   * Update Company Details
   * Copy all data from new company to the existing company (March 25, 2010)
   **/
  private static Company__c UpdateCompanyDetails(Company__c newCompany, Company__c oldCompany) {
    oldCompany.Dodge_Report_Number__c = newCompany.Dodge_Report_Number__c;
    oldCompany.Factor_Type__c = newCompany.Factor_Type__c;
    oldCompany.FactorKey__c = newCompany.FactorKey__c;
    oldCompany.CKMS__c = newCompany.CKMS__c;
    oldCompany.Company_URL__c = newCompany.Company_URL__c;
    oldCompany.Company_Name__c = newCompany.Company_Name__c;
    oldCompany.Phone__c = newCompany.Phone__c;
    oldCompany.Fax__c = newCompany.Fax__c;
    oldCompany.Address_1__c = newCompany.Address_1__c;        
    oldCompany.Address_2__c = newCompany.Address_2__c;
    oldCompany.City__c = newCompany.City__c;
    oldCompany.County__c = newCompany.County__c;
    oldCompany.State__c = newCompany.State__c;
    oldCompany.Zip__c = newCompany.Zip__c;
    oldCompany.Country__c = newCompany.Country__c;
    oldCompany.Rank__c = newCompany.Rank__c;
    oldCompany.Bid_Amount__c = newCompany.Bid_Amount__c;
    oldCompany.First_Name__c = newCompany.First_Name__c;
    oldCompany.Last_Name__c = newCompany.Last_Name__c;
    oldCompany.Title__c = newCompany.Title__c;
    oldCompany.SIC_Code__c = newCompany.SIC_Code__c;
    
    return oldCompany;
  }
      
  /**
   * Update Companies
   * (March 25, 2010)
   **/
  public static String updateCompanies(List<Company__c> companiesList){
    String resultString ='';
    Database.Saveresult[] newCompanySaveResults = Database.update(companiesList, false);
    Integer companyErrorIndex = 0;
    for(Database.SaveResult newCompSV : newCompanySaveResults){
      if(!newCompSV.isSuccess()){
        Database.Error err = newCompSV.getErrors()[0];
        dodgeProjectErrorFlag = false;
        if(companiesList.size()>companyErrorIndex && companiesList.get(companyErrorIndex)!=null){
          errorStringList.add('\n\tError : '+err.getMessage()+':'+'Company Factor key : '+companiesList.get(companyErrorIndex).factorKey__c);
          resultString = resultString+'\n\tError : '+err.getMessage()+':'+'Company Factor key : '+companiesList.get(companyErrorIndex).factorKey__c;
          errorCompanyFactorKeySet.add(companiesList.get(companyErrorIndex).factorKey__c);
        }
        }else{
          resultString = resultString +'\n\t'+companiesList.get(companyErrorIndex).factorKey__c+' company is updated for '+companiesList.get(companyErrorIndex).dodge_Report_Number__c+' dodge Project';
          //System.Debug('Save Company Result String with: '+companyErrorIndex+'>>'+resultString);
        }
        companyErrorIndex++;
      }
    return resultString;
  }
    
  /**
   * Check for General Contractor
   **/
  // TFS 4430 (private to public) 
  public static Boolean IsGeneralContractor(Company__c company, String oldFactorType){
    Boolean isGC = false;
    System.Debug('------Megha debug before --'+company.factor_type__c + '--'+isGC+'--'+oldFactorType);
    if((company.Factor_Type__c.contains('General Contractor')) || (company.Factor_Type__c.contains('GC')) || (company.Factor_Type__c.contains('Contractor'))) {
      isGC = true;
      System.Debug('------Megha debug in true --'+company.factor_type__c + '--'+isGC+'--'+oldFactorType);
    }
    if(oldFactorType != null && (oldFactorType.contains('General Contractor') || oldFactorType.contains('GC') || oldFactorType.contains('Contractor'))) {
      isGC = false;
      System.Debug('------Megha debug in false --'+company.factor_type__c + '--'+isGC);
    }
    System.Debug('------Megha debug after--'+company.factor_type__c + '--'+isGC);
    return isGC;
  }
  
  /**
   * Check for Construction Manager
   **/
  // TFS 4430 (private to public) 
  public static Boolean IsConstructionManager(Company__c company, String oldFactorType){
    Boolean isCM = false;
    System.Debug('------Megha debug before --'+company.factor_type__c + '--'+isCM+'--'+oldFactorType);
    if(company.Factor_Type__c.contains('Construction Manager')) {
      isCM = true;
      System.Debug('------Megha debug in true --'+company.factor_type__c + '--'+isCM+'--'+oldFactorType);
    }
    if(oldFactorType != null && (oldFactorType.contains('Construction Manager'))) {
      isCM = false;
      System.Debug('------Megha debug in false --'+company.factor_type__c + '--'+isCM);
    }
    System.Debug('------Megha debug after--'+company.factor_type__c + '--'+isCM);
    return isCM;
  }
  
  /**
   * Check for Low Bidder
   **/
  // TFS 4430 (private to public) 
  public static Boolean IsHighBidder(Company__c company, String oldFactorType, string oldRank){
    Boolean isHB = false;
    if((company.Factor_Type__c.contains('Low Bidder')) && (company.Rank__c != NULL) && ((company.Rank__c == '1') || (company.Rank__c == '2') || (company.Rank__c == '3'))) {
      isHB = true;
    }
    if((oldFactorType != null && oldFactorType.contains('Low Bidder')) && (oldRank != NULL) && (oldRank == '1' || oldRank == '2' || oldRank == '3')) {
      isHB = false;
    }
    return isHB;
  }
  
  /**
   * Check if the Company's Factor Type Changes
   **/
  // TFS 4430 (private to public) 
  public static Boolean IsFactorTypeChanged(String newFactorType, String oldFactorType) {
    Boolean isChanged = false;
    
    if(oldFactorType.contains('Low Bidder') ||(oldFactorType.contains('General Contractor') || oldFactorType.contains('GC') || oldFactorType.contains('Contractor'))){
      isChanged = true;
    }
    
    return isChanged;
  }
  
  /**
   * Create Data Set for Project needs to be updated
   * Track what type of lead need to be created for which company
   **/
  private static void SetLeadProjectMapsData(Company__c company, String oldFactorType, String oldRank, Map<String,Dodge_Project__c> projectMap) {
    Boolean addCKMS = false;
    System.Debug('-----Megha debug--Company factor key & factor Type --'+company.factorkey__c+'---'+company.factor_type__c);
    //Added by Akanksha for Story S-140427
    if(company.factor_type__c != NULL && company.factor_type__c == 'Construction Manager')
    {
        projectMap.get(company.Dodge_Report_Number__c).GC_Awarded__c = true;
    }//End by Akanksha for Story S-140427
    if(IsGeneralContractor(company, oldFactorType) || IsConstructionManager(company, oldFactorType)){
      // add hot lead
      hotLeadsCompanies.add(company);
      addCKMS = true;
      // Add project to update for GC
      if(projectMap.containsKey(company.Dodge_Report_Number__c) && projectMap.get(company.Dodge_Report_Number__c) != null) {
        System.Debug('--GC found ---'+company.Dodge_Report_Number__c+'--'+company.FactorKey__c);
        projectMap.get(company.Dodge_Report_Number__c).GC_Awarded__c = true;
        lstDodgeProjectsToUpdate.put(company.Dodge_Report_Number__c, projectMap.get(company.Dodge_Report_Number__c));
      }
    }
    else if(IsHighBidder(company, oldFactorType, oldRank)){
      // add warm lead
      warmLeadsCompanies.add(company);
      addCKMS = true;
    }
    if(addCKMS && CKMSSet.contains(company.CKMS__c) == false){
      CKMSSet.add(company.CKMS__c);
    }
  }
}