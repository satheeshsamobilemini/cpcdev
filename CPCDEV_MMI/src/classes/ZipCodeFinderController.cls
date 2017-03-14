public class ZipCodeFinderController {
    
    public String zipCode{get;set;}
    public Boolean isSearch{get;set;}
    public List<BranchCodeWrapper> branchCodeWrappers{get{
        if(branchLookupStdSetCntrl != null){
            List<BranchCodeWrapper>  tempBranchCodeWrappers = loadBranchLookups();
            return (List<BranchCodeWrapper>)tempBranchCodeWrappers;
        }else{
            return new List<BranchCodeWrapper>();
        }
    }
        set;}
    /*public List<Branch_Lookup__c> branchLookups{get{
        
    }set;}*/
    public ApexPages.StandardSetController branchLookupStdSetCntrl { get; set; }
    public ZipCodeFinderController(){
        zipCode = '';
        isSearch = false;
    }
    
    public PageReference searchZipCode(){
        try{
            zipCode = zipCode != null ? zipCode.trim(): zipCode;
             if(zipCode.length() > 5)
                zipCode = zipCode.substring(0,5); 
            String queryString = 'Select b.Zip__c, b.US_NSC_Sales_Manager_ID__c,  b.Sales_Manager_ID__c, b.OwnerId, b.National_Account_Manager_ID__c, b.Name, b.NSC_Team__c, b.NSC_Team_Live__c, b.Id, b.CurrencyIsoCode,  b.Country__c, b.Branch_Title__c, b.Branch_Name__c, b.Branch_Code__c,b.County__c,b.City__c,b.Time_Zone__c,b.Drop_Yard__c,b.State__c,b.Selling_Region__c,b.Territory__c From Branch_Lookup__c b where zip__c like \'' + zipCode +'\' ';
            branchLookupStdSetCntrl = new ApexPages.StandardSetController(Database.getQueryLocator(queryString));
            branchLookupStdSetCntrl.setPageSize(10);   
            isSearch = true;    
        }catch(Exception ex){
            System.debug('Exception:'+ex.getMessage());
        }
        return null; 
    }
    
    public List<BranchCodeWrapper> loadBranchLookups(){
        Set<Id> NSCManagerIds = new Set<Id>();
        Set<String> branchNames = new Set<String>();
        Set<String> branchCodes = new Set<String>();
        Set<String> branchTerritory = new Set<String>();
        
        List<BranchCodeWrapper>  tempBranchCodeWrappers  = new List<BranchCodeWrapper>();
        List<Branch_Lookup__c> branchLookups = (List<Branch_Lookup__c>)branchLookupStdSetCntrl.getRecords();
        
        
        for(Branch_Lookup__c bl : branchLookups){
            if(bl.US_NSC_Sales_Manager_ID__c != null){
                NSCManagerIds.add(bl.US_NSC_Sales_Manager_ID__c);
            }               
            if(bl.Branch_Name__c != null)
                branchNames.add(bl.Branch_Name__c);
                
            if(bl.Branch_Code__c != null)
                branchCodes.add(bl.Branch_Code__c);
                
            if(bl.Territory__c != null)   
            branchTerritory.add(bl.Territory__c);
        }
        
        Map<String,Weekly_Snapshot_Branch_Report__c> mapWeekSnapShotBranchReports = getWeekSnapShotBranchReports(branchCodes);
        Map<String,User> mapISRusers = getISRusers(branchTerritory);
        Map<Id,User> NSCSalesManagers = new Map<Id,User>([select Id, Name from User where id in : NSCManagerIds]);
        
        for(Branch_Lookup__c bl : branchLookups){
            String brachLookupKey = getBranchLookupKey(bl,null);
            String TerritoryLookUpKey = bl.Territory__c != Null ? bl.Territory__c.trim() : bl.Territory__c;
            
            if((bl.US_NSC_Sales_Manager_ID__c != null && NSCSalesManagers.containsKey(bl.US_NSC_Sales_Manager_ID__c)) ){            
                tempBranchCodeWrappers.add(new BranchCodeWrapper(bl,NSCSalesManagers.get(bl.US_NSC_Sales_Manager_ID__c).Name,mapISRusers.get(TerritoryLookUpKey),mapWeekSnapShotBranchReports.get(brachLookupKey)));
            }else{
                tempBranchCodeWrappers.add(new BranchCodeWrapper(bl,'',mapISRusers.get(TerritoryLookUpKey),mapWeekSnapShotBranchReports.get(brachLookupKey)));
            }
        }
        return tempBranchCodeWrappers;
    }
    
    private Map<String,User> getISRusers(Set<String> branchTerritory){
    Map<String,User> mapISRusers = new Map<String,User>();
    boolean dupicateuser = false; // for more then one user mapping with territory
        if(branchTerritory.size() == 0)
            return mapISRusers;
        
        String soql1 = 'Select Id,Name,UserRole.Name,Profile.Name,Territory__c From User Where ';
        
        for(String Territory: branchTerritory){
            soql1 += 'Territory__c like \'%' + Territory + '%\' OR ';            
        }
        
        soql1 = soql1.substring(0 , soql1.lastIndexOf('OR') - 1);
        
        for(User user1 : database.query(soql1)){
            system.debug('-----------user1.id-----------'+user1.id);
           if(dupicateuser <> false)
           {  if( user1.Profile.Name.containsIgnoreCase('Territory Sales Mgr - US') && user1.UserRole.Name.startswith('Territory Sales Mgr -'))
                {  
                    system.debug('-----------user1.UserRole.Name-------' + user1.UserRole.Name);
                    system.debug('-----------user1.id-------' + user1.id);
                    return mapISRusers;
                }
           }
            mapISRusers.put(user1.Territory__c, user1);   
            dupicateuser = true;         
        }
        return mapISRusers;
    }
    

    
    //pull all weekly report records and prepare map
    private Map<String,Weekly_Snapshot_Branch_Report__c> getWeekSnapShotBranchReports(Set<String> branchCodes){
        Map<String,Weekly_Snapshot_Branch_Report__c> mapWeekSnapShotBranchReports = new Map<String,Weekly_Snapshot_Branch_Report__c>();
        if(branchCodes.size() == 0)
            return mapWeekSnapShotBranchReports;
        
        String soql = 'Select Id ,Zipcode__c ,Servicing_Branch__c From Weekly_Snapshot_Branch_Report__c Where ';
        
        for(String branchCode : branchCodes){
            soql += 'Servicing_Branch__c like \'%' + branchCode + '%\' OR ';            
        }
        
        soql = soql.substring(0 , soql.lastIndexOf('OR') - 1);
        
        for(Weekly_Snapshot_Branch_Report__c weeklyBranchReport : database.query(soql)){
            mapWeekSnapShotBranchReports.put(getBranchLookupKey(null,weeklyBranchReport), weeklyBranchReport);                                                                  
        }
        return mapWeekSnapShotBranchReports;
    }
    
    //combine zip and branch name to make a key to identify weekly report
    private String getBranchLookupKey(Branch_Lookup__c branchLookup , Weekly_Snapshot_Branch_Report__c weeklyBranchReport){
        if(branchLookup != null)
            return branchLookup.Branch_Code__c;//return branchLookup.Branch_Name__c;
        return weeklyBranchReport.Servicing_Branch__c != null && weeklyBranchReport.Servicing_Branch__c.indexOf('-') >= 0?
               weeklyBranchReport.Servicing_Branch__c.split(' - ')[0] : weeklyBranchReport.Servicing_Branch__c;
    }
    
    public class BranchCodeWrapper{
        public Branch_Lookup__c branchLookup{get;set;}      
        public Weekly_Snapshot_Branch_Report__c weeklyBranchReport{get;set;}
        public User ISRuser{get;set;}
        public String NSCManager{get;set;}
        
        public BranchCodeWrapper(Branch_Lookup__c branchLookup,String NSCManager,User ISRuser,Weekly_Snapshot_Branch_Report__c weeklyBranchReport){
            this.branchLookup = branchLookup;
            this.NSCManager = NSCManager;   
            this.weeklyBranchReport = weeklyBranchReport;
            this.ISRuser = ISRuser;
        }
            
    }

}