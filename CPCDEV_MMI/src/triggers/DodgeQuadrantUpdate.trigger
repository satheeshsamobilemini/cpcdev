trigger DodgeQuadrantUpdate on Dodge_Project__c (before insert, before update) {
  
  if(TriggerSwitch.isTriggerExecutionFlagDisabled('Dodge_Project__c','DodgeQuadrantUpdate')){  
   return;
  }   
    List<String> projectAttrList = new List<String>();
    Map<String, String> ruleSetMap = new Map<String, String>();
    
    for(Dodge_Project__c dp : Trigger.new){
        
        //Create the project value based on the high and low valuation of Dodge
        Decimal projValue=0;
        if(dp.Project_Valuation_High__c != null && dp.Project_Valuation_Low__c != null) {
        projValue = (dp.Project_Valuation_High__c + dp.Project_Valuation_Low__c) / 2;
        } else if(dp.Project_Valuation_High__c != null){
        projValue = dp.Project_Valuation_High__c;
        } else if(dp.Project_Valuation_Low__c != null){
        projValue = dp.Project_Valuation_Low__c;
        } else {
        projValue = 0;
        }
        
        //Bucket the project value into 5 buckets
        String projValueBucket;
        if (projValue == NULL){projValueBucket = '1- Very Low';}
        else if(projValue < 1000000) { projValueBucket = '1- Very Low'; }
        else if(projValue < 5000000) { projValueBucket = '2- Low'; }
        else if(projValue < 20000000) { projValueBucket = '3- Medium'; }
        else if(projValue < 100000000) { projValueBucket = '4- High'; }
        else { projValueBucket = '5- Very High'; }
        
        //Bucket the owner type into 2 buckets
        String owner_type;
        if(dp.Ownership_Type__c == NULL) { owner_type ='NONE';} 
        else {owner_type = dp.Ownership_Type__c;}
        
        //Bucket the market segment of project
        string mkt_seg;
        if (dp.Market_Segment__c == NULL) {mkt_seg = 'NONE';}
        else if (((dp.Market_Segment__c.toUpperCase()) == 'FUNERAL') || 
                 ((dp.Market_Segment__c.toUpperCase()) == 'ANIMAL/PLANT') || 
                 ((dp.Market_Segment__c.toUpperCase()) == 'PUBLIC') || 
                 ((dp.Market_Segment__c.toUpperCase()) == 'WORSHIP') || 
                 ((dp.Market_Segment__c.toUpperCase()) == 'TRANSPORT') || 
                 ((dp.Market_Segment__c.toUpperCase()) == 'HOUSES')) {mkt_seg = 'Others';}
        else if (dp.Market_Segment__c.startsWith('Multi')) {mkt_seg = 'Multi Residential';}
        else {mkt_seg = dp.Market_Segment__c;}
        
        //Bucket the work type into 5 buckets
        string work_type;
        if (dp.Type_Of_Work__c == NULL) {work_type = 'NONE';}
        else if (dp.Type_Of_Work__c.startsWith('Addit')){work_type = 'Additions';}
        else if (dp.Type_Of_Work__c.startsWith('Inter')){work_type = 'Interiors';}
        else if (dp.Type_Of_Work__c.startsWith('Alter')){work_type = 'Alterations';}
        else if (dp.Type_Of_Work__c.startsWith('New P')){work_type = 'New Project';}
        else (work_type = 'NONE');
        
        //Get a final concatenated string of the relevant variables
        string project_attr;
        project_attr = projValueBucket+'-'+work_type+'-'+owner_type+'-'+mkt_seg;
        
        //Add the concatenated string to a list containing all strings related to projects that were updated now
        projectAttrList.add(project_attr);
    }
    
    //Get the rulesets for all the strings in the list above
    for(Ruleset__c r : [select Project_Attribute__c, Quad__c from Ruleset__c where Project_Attribute__c in : projectAttrList]) {
        ruleSetMap.put(r.Project_Attribute__c, r.Quad__c);
    }
    
    //Recreate the concatenated string similar to the above logic
    //Get the ruleset equivalent and put the value into the Quadrant__c field
    for(Dodge_Project__c dp : Trigger.new){
        //dp.Quadrant__c = String.valueOf(ruleSetMap.size());
        
        Decimal projValue=0;
        if(dp.Project_Valuation_High__c != null && dp.Project_Valuation_Low__c != null) {
        projValue = (dp.Project_Valuation_High__c + dp.Project_Valuation_Low__c) / 2;
        } else if(dp.Project_Valuation_High__c != null){
        projValue = dp.Project_Valuation_High__c;
        } else if(dp.Project_Valuation_Low__c != null){
        projValue = dp.Project_Valuation_Low__c;
        } else {
        projValue = 0;
        }
        String projValueBucket;
        if (projValue == NULL){projValueBucket = '1- Very Low';}
        else if(projValue < 1000000) { projValueBucket = '1- Very Low'; }
        else if(projValue < 5000000) { projValueBucket = '2- Low'; }
        else if(projValue < 20000000) { projValueBucket = '3- Medium'; }
        else if(projValue < 100000000) { projValueBucket = '4- High'; }
        else { projValueBucket = '5- Very High'; }
        
        String owner_type;
        if(dp.Ownership_Type__c == NULL) { owner_type ='NONE';} 
        else {owner_type = dp.Ownership_Type__c;}
        
        string mkt_seg;
        if (dp.Market_Segment__c == NULL) {mkt_seg = 'NONE';}
        else if (((dp.Market_Segment__c.toUpperCase()) == 'FUNERAL') || 
                 ((dp.Market_Segment__c.toUpperCase()) == 'ANIMAL/PLANT') || 
                 ((dp.Market_Segment__c.toUpperCase()) == 'PUBLIC') || 
                 ((dp.Market_Segment__c.toUpperCase()) == 'WORSHIP') || 
                 ((dp.Market_Segment__c.toUpperCase()) == 'TRANSPORT') || 
                 ((dp.Market_Segment__c.toUpperCase()) == 'HOUSES')) {mkt_seg = 'Others';}
        else if (dp.Market_Segment__c.startsWith('Multi')) {mkt_seg = 'Multi Residential';}
        else {mkt_seg = dp.Market_Segment__c;}
        
        string work_type;
        if (dp.Type_Of_Work__c == NULL) {work_type = 'NONE';}
        else if (dp.Type_Of_Work__c.startsWith('Addit')){work_type = 'Additions';}
        else if (dp.Type_Of_Work__c.startsWith('Inter')){work_type = 'Interiors';}
        else if (dp.Type_Of_Work__c.startsWith('Alter')){work_type = 'Alterations';}
        else if (dp.Type_Of_Work__c.startsWith('New P')){work_type = 'New Project';}
        else (work_type = 'NONE');
        
        string project_attr;
        project_attr = projValueBucket+'-'+work_type+'-'+owner_type+'-'+mkt_seg;
        
        dp.Quadrant__c = ruleSetMap.get(project_attr);
        //dp.Quadrant__c = project_attr;
    }
    string CMS = '';
    for(Dodge_Project__c aa : Trigger.new)
    {
        if(aa.Census_Ownership_Type__c == 'Private Construction')
        {
            if(aa.Market_Segment__c == 'Commercial')
            {
                aa.Census_Market_Segment__c = 'Commercial';
            }
            else if(aa.Market_Segment__c == 'Multi-residential')
            {
                aa.Census_Market_Segment__c = 'Multi family construction';
            }
            else if(aa.Market_Segment__c == 'Medical')
            {
                aa.Census_Market_Segment__c = 'Medical';
            }
            else if(aa.Market_Segment__c == 'Industrial')
            {
                aa.Census_Market_Segment__c = 'Manufacturing';
            }
            else if(aa.Market_Segment__c == 'Leisure')
            {
                aa.Census_Market_Segment__c = 'Amusement and Recreation';
            }
            else if(aa.Market_Segment__c == 'School')
            {
                aa.Census_Market_Segment__c = 'Educational';
            }
            else if(aa.Market_Segment__c == 'Transport' || aa.Market_Segment__c == 'Utilities'|| aa.Market_Segment__c == 'Engineering'|| aa.Market_Segment__c == 'Animal/Plant' || aa.Market_Segment__c == 'Public'|| aa.Market_Segment__c == 'Funeral'|| aa.Market_Segment__c == 'All projects')
            {
                aa.Census_Market_Segment__c = 'All projects';
            }
            else if(aa.Market_Segment__c == 'Worship')
            {
                aa.Census_Market_Segment__c = 'Religious';
            }
            else if(aa.Market_Segment__c == 'Houses')
            {
                aa.Census_Market_Segment__c = 'Multi family construction';
            }
        }
        else if(aa.Census_Ownership_Type__c == 'State and local construction')
        {
            if(aa.Market_Segment__c == 'School')
            {
                aa.Census_Market_Segment__c = 'Educational';
            }
            else if(aa.Market_Segment__c == 'Leisure')
            {
                aa.Census_Market_Segment__c = 'Amusement and Recreation';
            }
            else if(aa.Market_Segment__c == 'Public')
            {
                aa.Census_Market_Segment__c = 'Public safety';
            }
            else if(aa.Market_Segment__c == 'Utilities')
            {
                aa.Census_Market_Segment__c = 'Sewage and water disposal';
            }
            else if(aa.Market_Segment__c == 'Transport')
            {
                aa.Census_Market_Segment__c = 'Transportation';
            }
            else if(aa.Market_Segment__c == 'Engineering' || aa.Market_Segment__c == 'Medical' || aa.Market_Segment__c == 'Multi-residential' || aa.Market_Segment__c == 'Commercial' || aa.Market_Segment__c == 'Industrial'|| aa.Market_Segment__c == 'Animal/Plant' || aa.Market_Segment__c == 'Houses' || aa.Market_Segment__c == 'Funeral' || aa.Market_Segment__c == 'Worship')
            {
                aa.Census_Market_Segment__c = 'All projects';
            }
        }
        CMS = aa.Census_Market_Segment__c;
    } 
   List<string> RSID = new List<string> ();
   string abcdf;
   string abcde;
   string UniqueId = '';

    for(Dodge_Project__c abc :Trigger.new)
    {
        UniqueId = abc.Census_Ownership_Type__c + ':' + CMS + ':' + abc.Segment_Project_Value__c;
        abcdf = UniqueId.touppercase();
        RSID.add(abcdf);
    }
    
    Map<string,id> clmap = new Map<string,id>();
    for(End_Date_Ruleset__c PRS : [select id, Unique_Key__c from End_Date_Ruleset__c where Unique_Key__c IN : RSID])
    { 
        abcde = PRS.Unique_Key__c.touppercase();
        clmap.put(abcde,PRS.id);
    }
    
     for(Dodge_Project__c abcd :Trigger.new)
    {
        string unique = abcd.Census_Ownership_Type__c + ':' + CMS + ':' + abcd.Segment_Project_Value__c;
        string det = unique.toUpperCase();
        
            if(clmap.containsKey(det))
             {
             abcd.End_Date_Ruleset__c = clmap.get(det);
             }     
    }         
}