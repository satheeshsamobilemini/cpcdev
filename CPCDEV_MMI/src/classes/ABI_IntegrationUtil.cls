/*************************************************************************
Name    : ABI_IntegrationUtil
Author  : Megha
Date    : 
Usage   : Class used to create ABI Project and ABI Bidder

Modifield By : Megha Agarwal
Modified Date : July 18,2010
Comments : load record type through RecordTypeInfo instead of query and loaded existing ABI project and bider realted lead through sub-query.

Modifield By : Megha Agarwal
Modified Date : July 31,2010
Comments : Field mapped in constructor instead of individual mapping.

Modified By : Megha Agarwal
Modified Date : December 09, 2010 
Comments : Assign lead to account where ABI coompany id of account contains company Id.

Modified By : Megha Agarwal
Modified Date : Jan 06 , 2011
Comments : If there are same company in different projects then save it in all projects.

Modified By : Megha Agarwal
Modified Date : Feb 01 , 2011
Comments : Changed Rating as Hot -> Hot (Probably Order) and Warm -> Warm (Possibly Order)

Modified By : Najma ATeeq
Story       :S-139090
Comments : To avoid null pointer exception

*************************************************************************/
public class ABI_IntegrationUtil {
    
     //changed 01-02-2011 (PR-07971)
    public static final String HOT_RATING = 'Hot (Probably Order)';
     public static final String WARM_RATING = 'Warm (Possibly Order)';

    public static Map<Double,ABI_Project__c> abiProjectsMap;
    public static Map<Double,Map<Double,ABI_Bidder__c>> abiProjectBidderMap; 
    public static Map<Double,ABI_Project__c> existingProjectMap;
    public static Map<String,ABI__c> abiMap;
    public static Map<Double,boolean> isContractorMap = new Map<Double,boolean>();
    
    public static Set<String> abiProjectIDSet;
    public static Set<Double> errorProjectNumberSet;
    public static Set<Double> errorBidderSet;
    public static Set<String> leadToBeDeleteBidderId;
    public static Set<String> leadToBeDeletedProjectId;
    
    public static List<String> hotLeadBidders = new List<String>();
    public static List<String> warmLeadBidders = new List<String>();
    public static List<Lead> newLeadList;
    
    //changed 09-12-2010 (PR-07410)
    
    public static Map<String, Account> existingCyNoAccount = new Map<String, Account>();
    public static Set<String> cyNoSet = new Set<String>();
    
    public static void loadABIProjects(List<ABI__c> abiObjectList){
        Map<String,ABI_Bidder__c> existingBidderMap = new Map<String,ABI_Bidder__c>();
        Map<String,ABI_Bidder__c> existingProjectNewBidderMap = new Map<String,ABI_Bidder__c>();
        Map<Double,Map<Double,ABI_Bidder__c>> existingProjectBidderMap = new Map<Double,Map<Double,ABI_Bidder__c>>();
        Set<String> bidderToBeDelete = new Set<String>();
        leadToBeDeleteBidderId = new Set<String>();
        List<ABI_Bidder__c> existingProjectRemoveBidders = new List<ABI_Bidder__c>();
        
        hotLeadBidders = new List<String>();
        warmLeadBidders = new List<String>();
        newLeadList = new List<Lead>();
        
        
        abiProjectsMap = new Map<Double,ABI_Project__c>();
        abiProjectBidderMap = new Map<Double,Map<Double,ABI_Bidder__c>>();
        existingProjectMap = new Map<Double,ABI_Project__c>();
        abiMap = new Map<String,ABI__c>();
        abiProjectIDSet = new Set<String>();
        errorProjectNumberSet = new Set<Double>();
        errorBidderSet = new Set<Double>();
        leadToBeDeletedProjectId = new Set<String>();
        //change the flat data in relational data
        for(ABI__c abiObject : abiObjectList){
            if(!abiProjectsMap.containsKey(abiObject.ptno__c)){
                ABI_Project__c abiProject = getABIProject(abiObject);
                abiProjectsMap.put(abiProject.ptno__c,abiProject);
            }
            Map<Double,ABI_Bidder__c> tempProjectBidderMap =  abiProjectBidderMap.get(abiObject.ptno__c);
            if(tempProjectBidderMap == null){
                tempProjectBidderMap = new Map<Double,ABI_Bidder__c>();
                isContractorMap.put(abiObject.ptno__c,false);
            }
            ABI_Bidder__c abiBidder = getABIBidder(abiObject);
            tempProjectBidderMap.put(abiObject.cyno__c,abiBidder);
            abiProjectBidderMap.put(abiObject.ptno__c,tempProjectBidderMap);
            //check for one or more contructor in project
            if(abiObject.Role__c != null && (abiObject.Role__c.equals('Contractor') || abiObject.Role__c.equals('General Contractor'))){
                isContractorMap.put(abiObject.ptno__c,true);        
            }
            abiMap.put(abiObject.cyno__c.intValue()+'-'+abiObject.Ptno__c.intValue(),abiObject);
            //chnaged on 28-01-2011 and format the cyno ( Eg 2094869 as 2,094,869)
            cyNoSet.add(abiObject.cyno__c.intValue().format());
        }
        Map<String,Lead> leadToBeDeletedMap = new Map<String,Lead>();
        //changed 01-02-2011 Hot -> Hot (Probably Order) and Warm -> Warm (Possibly Order) (PR-07971) 
        for(ABI_Project__c existingABIProject : [Select ID,Name,ptno__c,(Select Id,Name,rating from Leads__r where status='Open' AND (Rating in (:HOT_RATING,:WARM_RATING))) from ABI_Project__c where ptno__c in : abiProjectsMap.keySet() ]){
            //update details of existing project
            existingABIProject = updateABIProjectDetails(abiProjectsMap.get(existingABIProject.ptno__c),existingABIProject);
            if(isContractorMap.get(existingABIProject.ptno__c)){
                for(Lead lead : existingABIProject.Leads__r){
                    if(lead.Rating != null && lead.Rating.equals(WARM_RATING)){
                        leadToBeDeletedMap.put(lead.id,lead);
                    }
                    if(leadToBeDeletedMap.size()==199){
                        deleteLeads(leadToBeDeletedMap.values());
                        leadToBeDeletedMap.clear();
                    }
                }
            }else {
                for(Lead lead : existingABIProject.Leads__r){
                    if(lead.Rating != null && lead.Rating.equals(HOT_RATING)){
                        leadToBeDeletedMap.put(lead.id,lead);
                    }
                    if(leadToBeDeletedMap.size()==199){
                        deleteLeads(leadToBeDeletedMap.values());
                        leadToBeDeletedMap.clear();
                    }
                }
            }  
            existingProjectMap.put(existingABIProject.ptno__c,existingABIProject);
            abiProjectsMap.remove(existingABIProject.ptno__c);
        }
        //change due to resolve 'Too Many Query' Exception - PR-05890
        Schema.DescribeSObjectResult leadDescribe = Schema.SObjectType.Lead;
        Map<String,Schema.RecordTypeInfo> leadRTByName = leadDescribe.getRecordTypeInfosByName();
        Schema.RecordTypeInfo leadABIRecordTypeInfo = leadRTByName.get('ABI Lead');
        String abiRecordTypeId = null;
        if(leadABIRecordTypeInfo != null)//Added Null check to resolve the deployment issue for S-139090 by Najma Ateeq
        abiRecordTypeId = leadABIRecordTypeInfo.getRecordTypeId();
        
        //Logic for new one ABI Project 
        saveABIProjects(abiProjectsMap.values());
        List<ABI_Bidder__c> bidderList = new List<ABI_Bidder__c>();
        for(ABI_Project__c abiProject : abiProjectsMap.values()){
            if(!errorProjectNumberSet.contains(abiProject.ptno__c)){
                Map<Double,ABI_Bidder__c> projectBidderMap = abiProjectBidderMap.get(abiProject.ptno__c);
                System.debug('---------project Bidder Map for --'+abiProject.ptno__c+'---'+projectBidderMap.size());
                String projectId = abiProject.Id;
                for(ABI_Bidder__c abiBidder : projectBidderMap.values()){
                    abiBidder.ABI_Project__c = projectId;
                    //create lead 
                    SetLeadProjectMapsData(abiBidder,null,abiProject);
                }
                bidderList.addAll(projectBidderMap.values());
                if(bidderList.size()>161){
                    List<ABI_Bidder__c> newbidderList = new List<ABI_Bidder__c>();
                    for(Integer i=bidderList.size()-1;i>=161;i--){
                        newBidderList.add(bidderList.get(i));
                        bidderList.remove(i);
                    }
                    //insert new bidders 
                    saveBidders(bidderList);
                    bidderList.clear();
                    bidderList.addAll(newbidderList);
                }
            }
        } 
        if(bidderList.size()>0){
            saveBidders(bidderList);
        }
        //logic for existing project 
        updateABIProjects(existingProjectMap.values());
        
        List<Lead> leadToBeDeleted = new List<Lead>();
        //exiting bidder 
        //changed 01-02-2011 Hot -> Hot (Probably Order) and Warm -> Warm (Possibly Order) (PR-07971) 
        for(ABI_Bidder__c abiBidder : [select Id,Name,ABI_Project__c,ABI_Project__r.ptno__c,cyno__c,Role__c,(Select Id,Name,rating from Leads__r where status='Open' AND (Rating in (:HOT_RATING,:WARM_RATING))) from ABI_Bidder__c where ABI_Project__r.ptno__c in :existingProjectMap.keySet() ]){
            Map<Double,ABI_Bidder__c> tempBidderMap = existingProjectBidderMap.get(abiBidder.ABI_Project__r.ptno__c);
            Map<Double,ABI_Bidder__c> newBidderMap =  abiProjectBidderMap.get(abiBidder.ABI_Project__r.ptno__c);
            if(tempBidderMap== null){
                tempBidderMap = new Map<Double,ABI_Bidder__c>();
            }
            if(newBidderMap.containsKey(abiBidder.cyno__c)){
                //create lead 
                SetLeadProjectMapsData(newBidderMap.get(abiBidder.cyno__c), abiBidder,abiBidder.ABI_Project__r);
                abiBidder = updateABIBidderDetails(newBidderMap.get(abiBidder.cyno__c),abiBidder);
                
                tempBidderMap.put(abiBidder.cyno__c,abiBidder);
                existingProjectBidderMap.put(abiBidder.ABI_Project__r.ptno__c,tempBidderMap);
                existingBidderMap.put(abiBidder.cyno__c.intValue()+'-'+abiBidder.ABI_Project__r.ptno__c.intValue(),abiBidder);
            }else{
                existingProjectRemoveBidders.add(abiBidder);
                bidderToBeDelete.add(abiBidder.Id);
                leadToBeDeletedMap.putAll(abiBidder.Leads__r);
                if(leadToBeDeletedMap.size()==199){
                    deleteLeads(leadToBeDeletedMap.values());
                    leadToBeDeletedMap.clear();
                }
                //System.Debug('---deleted Bidder ID '+abiBidder.Id+'and cyno--'+abiBidder.cyno__c);
                if(existingProjectRemoveBidders.size()==199){
                    deleteBidders(existingProjectRemoveBidders);
                    existingProjectRemoveBidders.clear();
                }
            }
            
        }
        updateBidders(existingBidderMap.values());
        
        //new bidder in existing Project
        for(Double ptno : existingProjectMap.keySet()){
            Map<Double,ABI_Bidder__c> tempBidderMap =  existingProjectBidderMap.get(ptno);
            Map<Double,ABI_Bidder__c> tempNewBidderMap  =  abiProjectBidderMap.get(ptno);
            if(tempBidderMap== null){
                tempBidderMap = new Map<Double,ABI_Bidder__c>();
            }
            String projectID = existingProjectMap.get(ptno).id;
            for(Double cyno : tempNewBidderMap.keySet()){
                if(!tempBidderMap.containskey(cyno)){
                    ABI_Bidder__c tempBidder = tempNewBidderMap.get(cyno);
                    tempBidder.ABI_Project__c = projectID;
                    existingProjectNewBidderMap.put(cyno.intValue()+'-'+ptno.intValue(),tempBidder);
                    //set lead for new bidder
                    SetLeadProjectMapsData(tempBidder, null,existingProjectMap.get(ptno));
                }
            }
        }
        
        if(existingProjectNewBidderMap.size()>0){
            saveBidders(existingProjectNewBidderMap.values());
        }
        
        //delete lead for existing non contractor bidder.
        if(leadToBeDeletedMap.size()>0){
            deleteLeads(leadToBeDeletedMap.values());
        }
        
        if(existingProjectRemoveBidders.size()>0){
            deleteBidders(existingProjectRemoveBidders);
        }
        
        // get existing cyno Accounts
        if(cyNoSet.size() > 0){
            existingCyNoAccount = loadAccount();
        }
        
        //create new Hot Lead
        for(String bidderKey : hotLeadBidders){
            //changed 01-02-2011 Hot -> Hot (Probably Order) (PR-07971) 
            if(abiMap.containsKey(bidderKey)){
                ABI__c abiObject = abiMap.get(bidderKey);
                if(existingProjectMap.containsKey(abiObject.ptno__c)){
                    if(existingProjectBidderMap.containsKey(abiObject.ptno__c) && existingBidderMap.containsKey(abiObject.cyno__c.intValue()+'-'+abiObject.Ptno__c.intValue())){
                        createLead(existingProjectMap.get(abiObject.ptno__c),existingBidderMap.get(abiObject.cyno__c.intValue()+'-'+abiObject.Ptno__c.intValue()),HOT_RATING,abiRecordTypeId);
                    
                    }else if(existingProjectNewBidderMap.containsKey(abiObject.cyno__c.intValue()+'-'+abiObject.Ptno__c.intValue())){
                        createLead(existingProjectMap.get(abiObject.ptno__c),existingProjectNewBidderMap.get(abiObject.cyno__c.intValue()+'-'+abiObject.Ptno__c.intValue()),HOT_RATING,abiRecordTypeId);
                    }
                }else if (abiProjectsMap.containsKey(abiObject.ptno__c) && abiProjectBidderMap.containskey(abiObject.ptno__c) && abiProjectBidderMap.get(abiObject.ptno__c).containsKey(abiObject.cyno__c)){
                    createLead(abiProjectsMap.get(abiObject.ptno__c),abiProjectBidderMap.get(abiObject.ptno__c).get(abiObject.cyno__c),HOT_RATING,abiRecordTypeId);
                }
            }
        }
        //create new warm Lead
        
        for(String bidderKey : warmLeadBidders){
            //changed 01-02-2011 Warm -> Warm (Possibly Order) (PR-07971) 
            if(abiMap.containsKey(bidderKey)){
                ABI__c abiObject = abiMap.get(bidderKey);
                if(existingProjectMap.containsKey(abiObject.ptno__c)){
                    if(existingProjectBidderMap.containsKey(abiObject.ptno__c) && existingBidderMap.containsKey(abiObject.cyno__c.intValue()+'-'+abiObject.Ptno__c.intValue())){
                        createLead(existingProjectMap.get(abiObject.ptno__c),existingBidderMap.get(abiObject.cyno__c.intValue()+'-'+abiObject.Ptno__c.intValue()),WARM_RATING,abiRecordTypeId);
                    }else if(existingProjectNewBidderMap.containsKey(abiObject.cyno__c.intValue()+'-'+abiObject.Ptno__c.intValue())){
                        createLead(existingProjectMap.get(abiObject.ptno__c),existingProjectNewBidderMap.get(abiObject.cyno__c.intValue()+'-'+abiObject.Ptno__c.intValue()),WARM_RATING,abiRecordTypeId);
                    }
                }else if (abiProjectsMap.containsKey(abiObject.ptno__c) && abiProjectBidderMap.containskey(abiObject.ptno__c) && abiProjectBidderMap.get(abiObject.ptno__c).containsKey(abiObject.cyno__c)){
                    createLead(abiProjectsMap.get(abiObject.ptno__c),abiProjectBidderMap.get(abiObject.ptno__c).get(abiObject.cyno__c),WARM_RATING,abiRecordTypeId);
                
                }
            }
        }
        if(newLeadList.size()>0){
            saveLeads(newLeadList);
        }
    }
    
    public static ABI_Project__c getABIProject(ABI__c abiObject){
        ABI_Project__c abiProject;
        if(abiObject != null){
            abiProject = new ABI_Project__c(Contracttype__c = abiObject.Contracttype__c,
                             Ptsite4__c = abiObject.Ptsite4__c,
                             Ptpcode__c = abiObject.Ptpcode__c,
                             Stage__c = abiObject.Stage__c,
                             Devtype__c = abiObject.Devtype__c,
                             Tenderclose__c = abiObject.Tenderclose__c,
                             Period__c = abiObject.Period__c,
                             Ptsite1__c = abiObject.Ptsite1__c,
                             Finish__c = abiObject.Finish__c,
                             Ptsite2__c = abiObject.Ptsite2__c,
                             Ptno__c = abiObject.Ptno__c,
                             Reportdate__c = abiObject.Reportdate__c,
                             Startdate__c = abiObject.Startdate__c,
                             Value__c = abiObject.Value__c,
                             Ptsite3__c = abiObject.Ptsite3__c,
                             Pttitle__c = abiObject.Pttitle__c);
        }else{
            abiProject = new ABI_Project__c();
        }
        return abiProject;
    }
    
    public static ABI_Bidder__c getABIBidder(ABI__c abiObject){
        ABI_Bidder__c abiBidder;
        if(abiObject != null){
            abiBidder = new ABI_Bidder__c(Cyname__c = abiObject.Cyname__c,
                        Cyfax__c = abiObject.Cyfax__c,  
                        Cyno__c =   abiObject.Cyno__c,  
                        Cypcode__c = abiObject.Cypcode__c,  
                        Cyurl__c = abiObject.Cyurl__c,  
                        Role__c =   abiObject.Role__c,  
                        Pnphone__c = abiObject.Pnphone__c,  
                        Fname__c = abiObject.Fname__c,
                        Cyname2__c = abiObject.Cyname2__c,  
                        Cyphone__c = abiObject.Cyphone__c,  
                        Email__c    = abiObject.Email__c,   
                        Cyaddr4__c = abiObject.Cyaddr4__c,  
                        Cyaddr3__c = abiObject.Cyaddr3__c,  
                        Lname__c = abiObject.Lname__c,  
                        Design__c   = abiObject.Design__c,  
                        Title__c    = abiObject.Title__c,   
                        Cyaddr2__c = abiObject.Cyaddr2__c,  
                        Cyaddr1__c = abiObject.Cyaddr1__c);
                
        }else{
            abiBidder = new ABI_Bidder__c();
        }
        return abiBidder;
    }
    
    private static ABI_Project__c updateABIProjectDetails(ABI_Project__c newABIProjectdetails,ABI_Project__c oldABIProjectDetails){
        if(newABIProjectdetails != null && oldABIProjectDetails != null){
            oldABIProjectDetails.Contracttype__c = newABIProjectDetails.Contracttype__c;
            oldABIProjectDetails.Ptsite4__c = newABIProjectDetails.Ptsite4__c;
            oldABIProjectDetails.Ptpcode__c = newABIProjectDetails.Ptpcode__c;
            oldABIProjectDetails.Stage__c = newABIProjectDetails.Stage__c;
            oldABIProjectDetails.Devtype__c = newABIProjectDetails.Devtype__c;
            oldABIProjectDetails.Tenderclose__c = newABIProjectDetails.Tenderclose__c;
            oldABIProjectDetails.Period__c = newABIProjectDetails.Period__c;
            oldABIProjectDetails.Ptsite1__c = newABIProjectDetails.Ptsite1__c;
            oldABIProjectDetails.Finish__c = newABIProjectDetails.Finish__c;
            oldABIProjectDetails.Ptsite2__c = newABIProjectDetails.Ptsite2__c;
            oldABIProjectDetails.Reportdate__c = newABIProjectDetails.Reportdate__c;
            oldABIProjectDetails.Startdate__c = newABIProjectDetails.Startdate__c;
            oldABIProjectDetails.Value__c = newABIProjectDetails.Value__c;
            oldABIProjectDetails.Ptsite3__c = newABIProjectDetails.Ptsite3__c;
            oldABIProjectDetails.Pttitle__c = newABIProjectDetails.Pttitle__c;
        }
        return oldABIProjectDetails;
    }
    
    private static ABI_Bidder__c updateABIBidderDetails(ABI_Bidder__c newABIBidderdetails,ABI_Bidder__c oldABIBidderDetails){
        if(newABIBidderdetails != null && oldABIBidderDetails != null){
            oldABIBidderDetails.Cyname__c = newABIBidderdetails.Cyname__c;
            oldABIBidderDetails.Cyfax__c = newABIBidderdetails.Cyfax__c;    
            oldABIBidderDetails.Cypcode__c = newABIBidderdetails.Cypcode__c;    
            oldABIBidderDetails.Cyurl__c = newABIBidderdetails.Cyurl__c;    
            oldABIBidderDetails.Role__c =   newABIBidderdetails.Role__c;    
            oldABIBidderDetails.Pnphone__c = newABIBidderdetails.Pnphone__c;    
            oldABIBidderDetails.Fname__c = newABIBidderdetails.Fname__c;
            oldABIBidderDetails.Cyname2__c = newABIBidderdetails.Cyname2__c;    
            oldABIBidderDetails.Cyphone__c = newABIBidderdetails.Cyphone__c;    
            oldABIBidderDetails.Email__c    = newABIBidderdetails.Email__c; 
            oldABIBidderDetails.Cyaddr4__c = newABIBidderdetails.Cyaddr4__c;    
            oldABIBidderDetails.Cyaddr3__c = newABIBidderdetails.Cyaddr3__c;    
            oldABIBidderDetails.Lname__c = newABIBidderdetails.Lname__c;    
            oldABIBidderDetails.Design__c   = newABIBidderdetails.Design__c;    
            oldABIBidderDetails.Title__c    = newABIBidderdetails.Title__c; 
            oldABIBidderDetails.Cyaddr2__c = newABIBidderdetails.Cyaddr2__c;    
            oldABIBidderDetails.Cyaddr1__c = newABIBidderdetails.Cyaddr1__c;    
        }
        return oldABIBidderDetails;
    }
    
    public static void saveABIProjects(List<ABI_Project__c> projectList){
        Database.Saveresult[] newProjectSaveResults = Database.insert(projectList,true);
        Integer projectErrorIndex = 0;
        for(Database.SaveResult newProjSV : newProjectSaveResults){ 
            if(!newProjSV.isSuccess()){
                 Database.Error err = newProjSV.getErrors()[0];
                if(projectList.size()>projectErrorIndex && projectList.get(projectErrorIndex)!=null){
                    errorProjectNumberSet.add(projectList.get(projectErrorIndex).ptno__c);
                }
            }
            projectErrorIndex++;
        }
    }
    
    public static void saveBidders(List<ABI_Bidder__c> biddersList){
        Database.Saveresult[] newBidderSaveResults = Database.insert(biddersList,true);
        Integer BidderErrorIndex = 0;
        for(Database.SaveResult newBidderSV : newBidderSaveResults){
            if(!newBidderSV.isSuccess()){
                Database.Error err = newBidderSV.getErrors()[0];
                if(biddersList.size()>BidderErrorIndex && biddersList.get(BidderErrorIndex)!=null){
                    errorBidderSet.add(biddersList.get(BidderErrorIndex).cyno__c);
                }
            }
            BidderErrorIndex++;
        }
   } 
   
   public static void deleteBidders(List<ABI_Bidder__c> biddersList){
        Database.DeleteResult[] deletedBiddersSaveResults = Database.Delete(biddersList,true);
        Integer BidderErrorIndex = 0;
        for(Database.DeleteResult deletedBidderSV : deletedBiddersSaveResults){
            if(!deletedBidderSV.isSuccess()){
                Database.Error err = deletedBidderSV.getErrors()[0];
            }
            BidderErrorIndex++;
        }
   } 
   
   public static void updateBidders(List<ABI_Bidder__c> biddersList){
        Database.Saveresult[] newBidderSaveResults = Database.update(biddersList,true);
        Integer BidderErrorIndex = 0;
        for(Database.SaveResult newBidderSV : newBidderSaveResults){
            if(!newBidderSV.isSuccess()){
                Database.Error err = newBidderSV.getErrors()[0];
                if(biddersList.size()>BidderErrorIndex && biddersList.get(BidderErrorIndex)!=null){
                    errorBidderSet.add(biddersList.get(BidderErrorIndex).cyno__c);
                }
            }
            BidderErrorIndex++;
        }
   } 
   public static void updateABIProjects(List<ABI_Project__c> projectList){
    Database.Saveresult[] existingProjectSaveResults = Database.update(projectList,true);
    Integer existingProjectErrorIndex = 0;
    for(Database.SaveResult existingProjSV : existingProjectSaveResults){
      if(!existingProjSV.isSuccess()){
        Database.Error err = existingProjSV.getErrors()[0];
        if(projectList.size()>existingProjectErrorIndex && projectList.get(existingProjectErrorIndex)!=null){
          errorProjectNumberSet.add(projectList.get(existingProjectErrorIndex).ptno__c);
        }
      }
      existingProjectErrorIndex++;
    }
    
  }
  
  private static void deleteLeads(List<Lead> leadList){
    Database.DeleteResult[] leadDeleteResults = Database.delete(leadList,true);
    Integer leadErrorIndex = 0;
    for(Database.DeleteResult leadDR : leadDeleteResults){
      if(!leadDR.isSuccess()){
        Database.Error err = leadDR.getErrors()[0];
      }
      leadErrorIndex++;
    }
  } 
  
   private static void saveLeads(List<Lead> leadList){
    Database.SaveResult[] leadSaveResults = Database.insert(leadList,true);
    Integer leadErrorIndex = 0;
    for(Database.SaveResult leadSR : leadSaveResults){
      if(!leadSR.isSuccess()){
        Database.Error err = leadSR.getErrors()[0];
      }
      leadErrorIndex++;
    }
  } 
  
  private static void SetLeadProjectMapsData(ABI_Bidder__c bidder, ABI_Bidder__c oldBidder,ABI_Project__c project){
    String bidderKey = bidder.Cyno__c.intValue() +'-'+project.Ptno__c.intValue();
    if(isContractorMap.get(project.ptno__c)){
        if(IsContractor(bidder,oldBidder)){
            hotLeadBidders.add(bidderKey);
            leadToBeDeletedProjectId.Add(project.id);
        }
    }else if(bidder.Role__c != null && bidder.Role__c.equals('Bidder')){
        if(oldBidder == null){
            warmLeadBidders.add(bidderKey);
            //changed 01-02-2011 Hot -> Hot (Probably Order)(PR-07971) 
        }else if (oldBidder.Leads__r != null && (oldBidder.Leads__r.size()==0 || (oldBidder.Leads__r.get(0).rating!=null && oldBidder.Leads__r.get(0).rating.equals(HOT_RATING)))){
            warmLeadBidders.add(bidderKey); 
            leadToBeDeleteBidderId.Add(oldBidder.id);
        }
    }
  }
   
  private static Boolean IsContractor(ABI_Bidder__c abiBidder, ABI_Bidder__c oldBidder){
    Boolean isCon = false;
    if(abiBidder.role__c != null && (abiBidder.role__c.contains('Contractor') || abiBidder.role__c.contains('General Contractor'))) {
      isCon = true;
    }
    if(oldBidder!= null && oldBidder.Role__c != null && (oldBidder.Role__c.contains('Contractor')|| oldBidder.Role__c.contains('Genereal Contractor'))){
      isCon = false;
      //chnaged on 28-01-2011 and format the cyno ( Eg 2094869 as 2,094,869)
      cyNoSet.remove(abiBidder.cyno__c.intValue().format());
      
    }
    return isCon;
  }
  
  private static void createLead(ABI_Project__c project,ABI_Bidder__c bidder,String rating,String ABILeadRTId){
    Lead newLead = new Lead(Salutation = bidder.Design__c,
                   FirstName = bidder.Fname__c,
                   Company  = bidder.Cyname__c,
                   Rating = rating,
                   Email = bidder.Email__c,
                   Street = bidder.Cyaddr1__c + bidder.Cyaddr2__c,
                   City = bidder.Cyaddr4__c,
                 // PostalCode = bidder.Cypcode__c,
                   ABI_Project__c = bidder.ABI_Project__c,
                   Delivery_Postal_Code__c = project.Ptpcode__c,
                   Bidder_Postal_Code__c = bidder.Cypcode__c,
                   Auto_Assign_Lead__c = true,
                   Status = 'Open',
                   Delivery_City__c = project.Ptsite4__c,
                  // Delivery_State__c = project.Ptsite3__c,
                   LeadSource = 'ABI',
                   ABI_Bidder__c = bidder.id);
    String bidderKey = bidder.cyno__c.intValue() +'-'+project.ptno__c.intValue();
    newLead.LastName = (bidder.Lname__c == NULL || bidder.Lname__c == '')? 'Unknown':bidder.Lname__c;              
    newLead.Phone = (bidder.PnPhone__c != NULL && bidder.PnPhone__c != '')? bidder.PnPhone__c :bidder.Cyphone__c;
    newLead.State = (bidder.Cyaddr3__c!= null && bidder.Cyaddr3__c.length() > 20)?bidder.Cyaddr3__c.substring(0, 20):bidder.Cyaddr3__c;
    newLead.Delivery_Street__c = (project.Ptsite1__c != null || project.Ptsite2__c != null) ? (project.Ptsite1__c + project.Ptsite2__c) : '';
    if(abiMap.containsKey(bidderKey) != null && abiMap.get(bidderKey).Location__c != null){
        newLead.Country = abiMap.get(bidderKey).Location__c;
        //newLead.Delivery_Country__c = abiMap.get(bidderKey).Location__c;
    }else{
        newLead.Country = 'UK';
        newLead.Delivery_Country__c = 'UK';     
    }
    
    newLead.Servicing_Branch_Id__c = (abiMap.containsKey(bidderKey) && abiMap.get(bidderKey).Location__c != null && abiMap.get(bidderKey).Location__c.equalsIgnoreCase('Ireland'))? '709': null;
    if(bidder.PnPhone__c!= null)
        newLead.Primary_Contact_Method__c   = 'Phone';
    else if(bidder.Email__c != null){
        newLead.Primary_Contact_Method__c   = 'Email';
    }
    if(ABILeadRTId != null)
        newLead.RecordTypeId = ABILeadRTId; 
    //added on 09-12-2010       
    //chnaged on 28-01-2011 and format the cyno ( Eg 2094869 as 2,094,869)
     if(existingCyNoAccount.containsKey(bidder.cyno__c.intValue().format())){
        newLead.OwnerId = existingCyNoAccount.get(bidder.cyno__c.intValue().format()).OwnerId;
        newLead.Auto_Assign_Lead__c = false;
     }
     newLeadList.add(newLead);
    
     if(newLeadList.size()==161){
        saveLeads(newLeadList);
        newLeadList.clear();
     }
   }
  
    public static Map<String, Account> loadAccount(){
    String query = ' Select Id , ABI_Company_Id__c, OwnerId from Account'; 
    Map<String, Account>  accountMap = new Map<String, Account>();
    
    if(Test.isRunningTest()){ return accountMap;}
    
    Boolean isWhere = false;
    String dynamicQuery = '';
    for(String cyn : cyNoSet){
        if(isWhere){
            dynamicQuery += ' or ';
        }else{
            dynamicQuery += ' Where ';
            isWhere = true;
        }
        dynamicQuery += ' ABI_Company_Id__c like \'%'+ cyn +';%\'';
    }
    if(dynamicQuery.length() > 0){
        String mainQuery = query + dynamicQuery;
        for(Account acc : Database.query(mainQuery)){
            List<String> abiCompanies = acc.ABI_Company_Id__c.split(';');
            for(String abiCom : abiCompanies){
                accountMap.put(abiCom,acc);
            }
        }
    }
    
    System.debug('--Account Map--'+accountMap);
    return accountMap;
  }
}