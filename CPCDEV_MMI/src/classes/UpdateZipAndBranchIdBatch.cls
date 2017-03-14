global class UpdateZipAndBranchIdBatch implements Database.Batchable<sObject>{
    
    public String projectsQuery;
    
    global UpdateZipAndBranchIdBatch() {
         projectsQuery = 'select id, Zip__c,Branch_ID__c, state__c,county__c,city__c from Dodge_Project__c where (Zip__c = \'\' or Branch_ID__c = \'\') and  LastModifiedDate >= YESTERDAY';
        }

    global Database.QueryLocator start(Database.BatchableContext info){
         if(test.isRunningTest()){
            projectsQuery += 'LIMIT 1' ;
        }
        return Database.getQueryLocator(projectsQuery);
    }
    
    global void execute(Database.BatchableContext info, List<Dodge_Project__c> dodgeProjects){
    
    Set<String> city = new Set<String>();
    Set<String> state = new Set<String>();
    Set<String> county = new Set<String>();
    Map<String , String> allZipMap = new Map<String , String>();
    Map<String , String> stateCountyZipMap = new Map<String , String>();
    Map<String , String> statecityZipMap = new Map<String , String>();
    Map<String , String> allBranchIdMap = new Map<String , String>();
    Map<String , String> stateCountyBranchIdMap = new Map<String , String>();
    Map<String , String> statecityBranchIdMap = new Map<String , String>();
    Set<String> countySet = new Set<String>();
    Set<String> citySet = new Set<String>();
    Set<String> postalCodes = New Set<String>();
    Map<String, String> postalCodetoBranchCodeMap = new Map<String, String>();
    Set<Dodge_Project__c> projectToUpdate = new Set<Dodge_Project__c>();
    
    // Get a list of Postal Codes and Dodge Projects we need to update
    
        for (Dodge_Project__c dp : dodgeProjects){
            if(dp.City__c!= null)
            {
                city.add((dp.City__c).toLowerCase());
            }
            if(dp.State__c != null)
            {
                state.add((dp.State__c).toLowerCase());
            }
            if(dp.County__c != null)
            {
                county.add((dp.County__c).toLowerCase());
            }
            if(dp.zip__c != null && dp.zip__c != '')
            {
                postalCodes.add(dp.zip__c);
            }
        }

    
    // Create a map of Postal Code to Branch ID
    for (Branch_Lookup__c bl :[Select Zip__c, Branch_Code__c, City__c, State__c, County__c from Branch_Lookup__c  Where Zip__C in :postalCodes or City__c = :city or State__c = : state or county__c = :county]){
        if(city.contains((bl.city__c).toLowerCase()) || state.contains((bl.state__c).toLowerCase()) || county.contains((bl.county__c).toLowerCase()))
        {
                String cityB = '';
                String stateB = '';
                String countyB = '';
                if(bl.City__c != null) cityB = (bl.City__c).toLowerCase();
                if(bl.State__c != null) stateB = (bl.State__c).toLowerCase();
                if(bl.County__c != null) countyB = (bl.County__c).toLowerCase();
                
                if(!allZipMap.containsKey((cityB+stateB+countyB)))
                allZipMap.put((cityB+stateB+countyB), (bl.zip__c));
                allBranchIdMap.put((cityB+stateB+countyB), (bl.Branch_Code__c));
                
                if(!stateCountyZipMap.containsKey((stateB+countyB)))
                stateCountyZipMap.put((stateB+countyB), (bl.zip__c));
                stateCountyBranchIdMap.put((stateB+countyB), (bl.Branch_Code__c));
                
                if(!statecityZipMap.containsKey((cityB+stateB)))
                statecityZipMap.put((cityB+stateB), (bl.Zip__c));
                statecityBranchIdMap.put((cityB+stateB), (bl.Branch_Code__c));
                
                countySet.add(countyB);
                citySet.add(cityB);
        }
                
        if(bl.Zip__c != null && bl.Zip__c != '')
        {
            postalCodetoBranchCodeMap.put((bl.Zip__c).toLowerCase(), (bl.Branch_Code__c).toLowerCase());
        }
    }   
                for (Dodge_Project__c dp : dodgeProjects)
                {
                String countyString ='';
                if(dp.County__c != null && !countySet.contains((dp.County__c).toLowerCase()))
                {
                    if((dp.County__c).containsIgnoreCase('county'))
                    {
                    countyString = (dp.County__c).removeEndIgnoreCase('county').trim();
                    }
                    else if((dp.County__c).containsIgnoreCase('parish'))
                    {
                        countyString = (dp.County__c).removeEndIgnoreCase('parish').trim();
                    }
                    else 
                    {
                    countyString = (dp.County__c.trim()).toLowerCase();
                    }
                }
                else
                {
                    if((dp.County__c) != null)countyString = (dp.County__c).toLowerCase();
                }
                String cityString ='';
                for(String correctCity : citySet)
                {
                    if(correctCity != null && dp.city__c != null && correctCity.containsIgnoreCase(dp.city__c) && cityString == '')
                    {
                        cityString = (correctCity).toLowerCase();
                        break;
                    }
                }
                if(cityString =='' && (dp.city__c) != null)
                {
                    cityString = (dp.city__c).toLowerCase();
                }   
                    if(dp.Zip__c == null || dp.Zip__c == '' || dp.Branch_ID__c == null || dp.Branch_ID__c == '')
                    {
                        String dpState ='';
                        if(countyString != null)countyString = countyString.toLowerCase();
                        if(cityString != null)cityString = cityString.toLowerCase();
                        if((dp.State__c)  != null)dpState = dp.State__c.toLowerCase();
                        system.debug('@@countyString'+countyString);
                        
                        if(allZipMap.containsKey(cityString+dpState+countyString))
                        {
                            system.debug('@@if if allZipMap'+allZipMap);
                            if(dp.Zip__c == null || dp.Zip__c == '')dp.zip__c = allZipMap.get(cityString+dpState+countyString);
                            system.debug('@@if if dp.Zip__c '+dp.Zip__c );
                            system.debug('@@if if postalCodetoBranchCodeMap.get(dp.zip__c) '+postalCodetoBranchCodeMap.get(dp.zip__c));
                            if(postalCodetoBranchCodeMap.get(dp.zip__c) == null || postalCodetoBranchCodeMap.get(dp.zip__c) == '')
                            {
                                system.debug('@@if else allBranchIdMap.get(cityString+dpState+countyString)'+allBranchIdMap.get(cityString+dpState+countyString));
                                dp.Branch_ID__c = allBranchIdMap.get(cityString+dpState+countyString);
                            }
                            else
                            {
                                dp.Branch_ID__c = postalCodetoBranchCodeMap.get(dp.zip__c);
                            }
                            projectToUpdate.add(dp);
                        }
                    
                        else if(stateCountyZipMap.containsKey(dpState+countyString))
                        {
                            system.debug('@@if if stateCountyZipMap'+stateCountyZipMap);
                            if(dp.Zip__c == null || dp.Zip__c == '')dp.zip__c = stateCountyZipMap.get(dpState+countyString);
                            if(postalCodetoBranchCodeMap.get(dp.zip__c) == null || postalCodetoBranchCodeMap.get(dp.zip__c) == '')
                            {
                                dp.Branch_ID__c = stateCountyBranchIdMap.get(dpState+countyString);
                            }
                            else
                            {
                                system.debug('@@if else stateCountyBranchIdMap.get(dpState+countyString)'+stateCountyBranchIdMap.get(dpState+countyString));    
                                dp.Branch_ID__c = postalCodetoBranchCodeMap.get(dp.zip__c);
                            }
                            projectToUpdate.add(dp);
                        }
                        else if(statecityZipMap.containsKey(cityString+dpState))
                        {
                            if(dp.Zip__c == null || dp.Zip__c == '')dp.zip__c = statecityZipMap.get(cityString+dpState);
                            if(postalCodetoBranchCodeMap.get(dp.zip__c) == null || postalCodetoBranchCodeMap.get(dp.zip__c) == '')
                            {
                                dp.Branch_ID__c = statecityBranchIdMap.get(cityString+dpState);
                            }
                            else
                            {
                                dp.Branch_ID__c = postalCodetoBranchCodeMap.get(dp.zip__c);
                            }
                            projectToUpdate.add(dp);
                        }           
                    }
                    else if(dp.Zip__c != null && dp.Zip__c != '' && (dp.Branch_ID__c == '' || dp.Branch_ID__c == null) )
                    {
                            dp.Branch_ID__c = postalCodetoBranchCodeMap.get(dp.zip__c);
                            projectToUpdate.add(dp);
                    }
                }
                if(projectToUpdate != null && projectToUpdate.size() >0)
                {
                    List<Dodge_Project__c> projectList = new List<Dodge_Project__c>();
                    projectList.addAll(projectToUpdate);
                    system.debug('@@projectList'+projectList);
                    update projectList;
                }
    }
   
    
    
    global void finish(Database.BatchableContext info){
        
    }
    
    @isTest
    public static void UpdateZipAndBranchIdBatchTest(){
       UpdateZipAndBranchIdBatch dodgeProjectbatch = new UpdateZipAndBranchIdBatch();
       //donationbatch.donationQuery += ' limit 10';
       Test.startTest();
       Database.executeBatch(dodgeProjectbatch, 1);
       Test.stopTest();
   }

}