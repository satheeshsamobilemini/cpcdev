trigger JobProfileDuplicateCheck on Job_Profile__c (before insert, before update) {

if(TriggerSwitch.isTriggerExecutionFlagDisabled('Job_Profile__c','JobProfileDuplicateCheck')){
        return;
    }

    /*
    
        Searches for an existing Job profile with the same  Project ID
        
        Will Update Job_Profile_status__c to "Created" if a duplicate is NOT found
        
        Test Class in: TESTJobProfileDuplicateCheck.cls
    
    */
    //Error Messages for Duplicate Job Profiles
    static final string DUPLICATE_JOB_PROFILE_DODGE_PROJECT = 'A Job Profile for this Dodge Project already exists';
    static final string DUPLICATE_JOB_PROFILE_GLENIGAN_PROJECT = 'A Job Profile for this Glenigan Project already exists';
    Set <ID> projectIDs = New Set <ID>();
    Map <ID, ID> mapJobProfiletoProject = New Map <ID, ID>();
    
    map<ID,Job_Profile__c>  mapIDjb = new map<ID,Job_Profile__c>();                                             // TFS-2221
    
    //Creating set of ProjectID's
    if(trigger.isInsert){                                                                                   // TFS-2221
    for (Job_Profile__c jp : Trigger.New){
    
        if (jp.Dodge_Project__c != NULL) ProjectIDs.Add(jp.Dodge_Project__c);
        if (jp.Glenigan_Project__c != NULL) ProjectIDs.Add(jp.Glenigan_Project__c);
    
    }
    
    List <Dodge_Project__c> newDodgeProjects = New List <Dodge_Project__c>();
    List <Glenigan_Project__c> newGleniganProjects = New List <Glenigan_Project__c>();
    if (projectIDs.size() > 0){
    
        //Query to find all duplicate dodge project Id's and Glenigan project Id'd
        Job_Profile__c[] duplicateJobProfiles = [Select Id, Dodge_Project__c, Glenigan_Project__c  From Job_Profile__c 
                                                    WHERE Dodge_Project__c IN :ProjectIDs OR Glenigan_Project__c IN: projectIDs];
        
        //creating Map of all object Id's to be looked for Job Profiles
        for (Job_Profile__c djp : duplicateJobProfiles){

            if (djp.Dodge_Project__c != NULL && !mapJobProfiletoProject.containsKey(djp.Dodge_Project__c)){
                mapJobProfiletoProject.put(djp.Dodge_Project__c, djp.Dodge_Project__c);
            }
            if (djp.Glenigan_Project__c != NULL && !mapJobProfiletoProject.containsKey(djp.Glenigan_Project__c)){
                mapJobProfiletoProject.put(djp.Glenigan_Project__c, djp.Glenigan_Project__c);
            }
        }
        
        //Checking for duplicate JOB PROFILE Id
        for (Job_Profile__c jp : Trigger.New){
            if(jp.Dodge_Project__c != NULL){
                if (mapJobProfiletoProject.containsKey(jp.Dodge_Project__c)){
                    //Add error if job profile found for Dodge Project 
                    jp.addError(DUPLICATE_JOB_PROFILE_DODGE_PROJECT);
                }
                else{
                    //Adding Dodge_Project__c record to list to update Dodge_Project__c.Job_Profile_Status__c 
                    newDodgeProjects.add(new Dodge_Project__c(Id = jp.Dodge_Project__c, Job_Profile_Status__c = 'Created'));
                }
            mapIDjb.put(jp.Dodge_Project__c,jp);                                                                // TFS-2221
                
            }
            
            if(jp.Glenigan_Project__c != NULL){
                if (mapJobProfiletoProject.containsKey(jp.Glenigan_Project__c)){
                    //Add error if job profile found for Glenigan Project
                    jp.addError(DUPLICATE_JOB_PROFILE_GLENIGAN_PROJECT);
                }
                else{
                    ////Adding Dodge_Project__c record to list to update Glenigan_Project__c.Job_Profile_Status__c
                    newGleniganProjects.add(new Glenigan_Project__c(Id = jp.Glenigan_Project__c, Job_Profile_Status__c = 'Created'));
                }            
            }
        }
        //update Dodge_Project__c List   
        update newDodgeProjects;
        //update Glenigan_Project__c List 
        update newGleniganProjects;
    }
  }  
    if(trigger.isUpdate)
    {  for(integer i =0; i< trigger.new.size(); i++)
        {  if((trigger.new[i].Dodge_Project__c <> trigger.old[i].Dodge_Project__c) && trigger.new[i].Dodge_Project__c <> null)
            mapIDjb.put(trigger.new[i].Dodge_Project__c,trigger.new[i]); 
        }    
    }
     
     //TFS-2221
    for(Dodge_Project__c dp : [select Id,Action_Stage__c,Target_Start_Date__c,Bid_Date__c from Dodge_Project__c where ID IN: mapIDjb.keyset()])
     {   Job_Profile__c j = mapIDjb.get(dp.Id);
         j.Bid_Date__c = dp.Bid_Date__c;
         j.Target_Start_Date__c = dp.Target_Start_Date__c;
     }  
    
     List<string> RSID = new List<string> ();
     string CV;
     string UI;
     string PPTNN = '';
     integer i = 0;
     for(Job_Profile__c jp :Trigger.new) {
        if( jp.Primary_Project_Type__c == 'Communication Building'|| jp.Primary_Project_Type__c == 'Convention & Exhibit Center'|| jp.Primary_Project_Type__c == 'Runway/Taxiway'|| jp.Primary_Project_Type__c == 'Museum'|| jp.Primary_Project_Type__c == 'Passenger Terminal (Other)'|| jp.Primary_Project_Type__c == 'Warehouse (Refrigerated)'|| jp.Primary_Project_Type__c == 'Aircraft Sales/Service'|| jp.Primary_Project_Type__c == 'Vocational School'|| jp.Primary_Project_Type__c == 'Heating/Cooling Plant'|| jp.Primary_Project_Type__c == 'Electric Substation'|| jp.Primary_Project_Type__c == 'Swimming Pool'|| jp.Primary_Project_Type__c == 'Freight Terminal'|| jp.Primary_Project_Type__c == 'Gas/Chemical Plant'|| jp.Primary_Project_Type__c == 'Casino'|| jp.Primary_Project_Type__c == 'Indoor Arena'|| jp.Primary_Project_Type__c == 'Kindergarten'|| jp.Primary_Project_Type__c == 'Funeral/Interment Facility'|| jp.Primary_Project_Type__c == 'Sale/Spec Homes'|| jp.Primary_Project_Type__c == 'Railroad'|| jp.Primary_Project_Type__c == 'Sidewalk/Parking Lot'|| jp.Primary_Project_Type__c == 'Landscaping'|| jp.Primary_Project_Type__c == 'Storm Sewer'|| jp.Primary_Project_Type__c == 'Dry Waste Treatment Plant'|| jp.Primary_Project_Type__c == 'Water Line'|| jp.Primary_Project_Type__c == 'Beach/Marina Facility'|| jp.Primary_Project_Type__c == 'Athletic Lighting'|| jp.Primary_Project_Type__c == 'Dock/Pier'|| jp.Primary_Project_Type__c == 'Bowling Alley'|| jp.Primary_Project_Type__c == 'Space Facility'|| jp.Primary_Project_Type__c == 'Sanitary Sewer'|| jp.Primary_Project_Type__c == 'Hazardous Waste Disposal'|| jp.Primary_Project_Type__c == 'Flood Control'|| jp.Primary_Project_Type__c == 'Refinery'|| jp.Primary_Project_Type__c == 'Tower/Signal System'|| jp.Primary_Project_Type__c == 'Cogeneration Plant'|| jp.Primary_Project_Type__c == 'Storage Tank (Other)'|| jp.Primary_Project_Type__c == 'Dredging'|| jp.Primary_Project_Type__c == 'Shoreline Maintenance'|| jp.Primary_Project_Type__c == 'Custom Homes'|| jp.Primary_Project_Type__c == 'Water Tank'|| jp.Primary_Project_Type__c == 'Guidance Detection Tracking System'|| jp.Primary_Project_Type__c == 'Hydroelectric Plant'|| jp.Primary_Project_Type__c == 'Fuel/Chemical Line'|| jp.Primary_Project_Type__c == 'Vehicle Tunnel'|| jp.Primary_Project_Type__c == 'Roadway Lighting'|| jp.Primary_Project_Type__c == 'Air Pollution Control'|| jp.Primary_Project_Type__c == 'Nuclear Power Plant'|| jp.Primary_Project_Type__c == 'Industrial Waste Disposal'|| jp.Primary_Project_Type__c == 'Water Supply'|| jp.Primary_Project_Type__c == 'Hydroelectric'|| jp.Primary_Project_Type__c == 'Utility Tunnel'|| jp.Primary_Project_Type__c == 'Power Lines'|| jp.Primary_Project_Type__c == 'Highway Signs/Guardrails'|| jp.Primary_Project_Type__c == 'Airport Lighting'|| jp.Primary_Project_Type__c == 'Post Office'|| jp.Primary_Project_Type__c == 'Pedestrian Tunnel')
        {
            jp.Primary_Project_Type_New__c = 'Other';
            PPTNN = 'Other';
        }
        else
        {
            jp.Primary_Project_Type_New__c = jp.Primary_Project_Type__c;
            PPTNN = jp.Primary_Project_Type__c;
        }
        string UniqueID = jp.Market_Segment_New__c + ':' + jp.Ownership_Type__c + ':' + PPTNN + ':' + jp.Dodge_Project_Type_of_Work_New__c+ ':' + jp.Value_Bucket__c;
        CV = UniqueID.touppercase();
        RSID.add(CV);
        i++;
    }     

    
    Map<string,id> clmap = new Map<string,id>();
    for(Potential_Rule_Set__c PRS : [select id, Unique_Id__c from Potential_Rule_Set__c where Unique_Id__c IN : RSID])
    { 
        UI = PRS.Unique_Id__c.touppercase();
        clmap.put(UI,PRS.id);
    }
     string PPTNNN = '';
     double Final1 = 0;
     
     for(Job_Profile__c abcd :Trigger.new)
    {
       if( abcd.Primary_Project_Type__c == 'Communication Building'|| abcd.Primary_Project_Type__c == 'Convention & Exhibit Center'|| abcd.Primary_Project_Type__c == 'Runway/Taxiway'|| abcd.Primary_Project_Type__c == 'Museum'|| abcd.Primary_Project_Type__c == 'Passenger Terminal (Other)'|| abcd.Primary_Project_Type__c == 'Warehouse (Refrigerated)'|| abcd.Primary_Project_Type__c == 'Aircraft Sales/Service'|| abcd.Primary_Project_Type__c == 'Vocational School'|| abcd.Primary_Project_Type__c == 'Heating/Cooling Plant'|| abcd.Primary_Project_Type__c == 'Electric Substation'|| abcd.Primary_Project_Type__c == 'Swimming Pool'|| abcd.Primary_Project_Type__c == 'Freight Terminal'|| abcd.Primary_Project_Type__c == 'Gas/Chemical Plant'|| abcd.Primary_Project_Type__c == 'Casino'|| abcd.Primary_Project_Type__c == 'Indoor Arena'|| abcd.Primary_Project_Type__c == 'Kindergarten'|| abcd.Primary_Project_Type__c == 'Funeral/Interment Facility'|| abcd.Primary_Project_Type__c == 'Sale/Spec Homes'|| abcd.Primary_Project_Type__c == 'Railroad'|| abcd.Primary_Project_Type__c == 'Sidewalk/Parking Lot'|| abcd.Primary_Project_Type__c == 'Landscaping'|| abcd.Primary_Project_Type__c == 'Storm Sewer'|| abcd.Primary_Project_Type__c == 'Dry Waste Treatment Plant'|| abcd.Primary_Project_Type__c == 'Water Line'|| abcd.Primary_Project_Type__c == 'Beach/Marina Facility'|| abcd.Primary_Project_Type__c == 'Athletic Lighting'|| abcd.Primary_Project_Type__c == 'Dock/Pier'|| abcd.Primary_Project_Type__c == 'Bowling Alley'|| abcd.Primary_Project_Type__c == 'Space Facility'|| abcd.Primary_Project_Type__c == 'Sanitary Sewer'|| abcd.Primary_Project_Type__c == 'Hazardous Waste Disposal'|| abcd.Primary_Project_Type__c == 'Flood Control'|| abcd.Primary_Project_Type__c == 'Refinery'|| abcd.Primary_Project_Type__c == 'Tower/Signal System'|| abcd.Primary_Project_Type__c == 'Cogeneration Plant'|| abcd.Primary_Project_Type__c == 'Storage Tank (Other)'|| abcd.Primary_Project_Type__c == 'Dredging'|| abcd.Primary_Project_Type__c == 'Shoreline Maintenance'|| abcd.Primary_Project_Type__c == 'Custom Homes'|| abcd.Primary_Project_Type__c == 'Water Tank'|| abcd.Primary_Project_Type__c == 'Guidance Detection Tracking System'|| abcd.Primary_Project_Type__c == 'Hydroelectric Plant'|| abcd.Primary_Project_Type__c == 'Fuel/Chemical Line'|| abcd.Primary_Project_Type__c == 'Vehicle Tunnel'|| abcd.Primary_Project_Type__c == 'Roadway Lighting'|| abcd.Primary_Project_Type__c == 'Air Pollution Control'|| abcd.Primary_Project_Type__c == 'Nuclear Power Plant'|| abcd.Primary_Project_Type__c == 'Industrial Waste Disposal'|| abcd.Primary_Project_Type__c == 'Water Supply'|| abcd.Primary_Project_Type__c == 'Hydroelectric'|| abcd.Primary_Project_Type__c == 'Utility Tunnel'|| abcd.Primary_Project_Type__c == 'Power Lines'|| abcd.Primary_Project_Type__c == 'Highway Signs/Guardrails'|| abcd.Primary_Project_Type__c == 'Airport Lighting'|| abcd.Primary_Project_Type__c == 'Post Office'|| abcd.Primary_Project_Type__c == 'Pedestrian Tunnel')
        {
            PPTNNN = 'Other';
        }
        else
        {
            PPTNNN = abcd.Primary_Project_Type__c;
        }
  
       string Unique = abcd.Market_Segment_New__c + ':' + abcd.Ownership_Type__c + ':' + PPTNNN + ':' + abcd.Dodge_Project_Type_of_Work_New__c+ ':' + abcd.Value_Bucket__c;
        string det = Unique.toUpperCase();
        
        
            if(clmap.containsKey(det))
             {
             abcd.Potential_Rule_Set__c= clmap.get(det);
             }
             else
             {
             abcd.Potential_Rule_Set__c = null;
             } 
             
             if(abcd.Cluster_Value__c == 0 || abcd.Cluster_Value__c == null)
             {
                 abcd.Cluster_Final__c = abcd.Cluster_New__c;
                 Final1 = abcd.Cluster_New__c;
             }    
             else
             {
                 abcd.Cluster_Final__c = abcd.Cluster_Value__c;
                 Final1 = abcd.Cluster_Value__c;
             }  
             i++;

if(abcd.Value_Bucket__c == 'very low' && Final1 != null  && abcd.Project_Quarter__c!='' && abcd.Project_Quarter__c!=null)
{
    abcd.Potential_Value__c = '1';
}
else if(abcd.Value_Bucket__c == 'very low')
{
    abcd.Potential_Value__c = '';
}
 
 else if(Final1 == 1)
{
    if(abcd.Project_Quarter__c =='Q1')
    {
        abcd.Potential_Value__c = '3';
    } 
    else if(abcd.Project_Quarter__c =='Q2' || abcd.Project_Quarter__c =='Q3' || abcd.Project_Quarter__c =='Q4')
    {
        abcd.Potential_Value__c = '4';
    }
    else 
    {
        abcd.Potential_Value__c = '';
    }
}
else if(Final1 == 2)
{
    if(abcd.Project_Quarter__c =='Q1')
    {
        abcd.Potential_Value__c = '4';
    }
    else if(abcd.Project_Quarter__c =='Q2')
    {
        abcd.Potential_Value__c = '6';
    }
    else if(abcd.Project_Quarter__c =='Q3' || abcd.Project_Quarter__c =='Q4')
    {
        abcd.Potential_Value__c = '7';
    }
    else
    {
        abcd.Potential_Value__c = '';
    }
}
else if(Final1 == 3)
{
    if(abcd.Project_Quarter__c =='Q1')
    {
        abcd.Potential_Value__c = '5';
    }
    else if(abcd.Project_Quarter__c =='Q2')
    {
        abcd.Potential_Value__c = '8';
    }
    else if(abcd.Project_Quarter__c =='Q3')
    {
        abcd.Potential_Value__c = '9';
    }
    else if(abcd.Project_Quarter__c =='Q4')
    {
        abcd.Potential_Value__c = '10';
    }
    else
    {
        abcd.Potential_Value__c = '';
    }
}
else if(Final1 == 4)
{
    if(abcd.Project_Quarter__c =='Q1')
        {
            abcd.Potential_Value__c = '4';
        }
        else if(abcd.Project_Quarter__c =='Q2')
        {
            abcd.Potential_Value__c = '6';
        }
        else if(abcd.Project_Quarter__c =='Q3')
        {
            abcd.Potential_Value__c = '7';
        }
        else if(abcd.Project_Quarter__c =='Q4')
        {
            abcd.Potential_Value__c = '8';
        }
         else
        {
            abcd.Potential_Value__c = '';
        }
}
else
{
    abcd.Potential_Value__c = '';
}
//**********Created by Tredence on 22th November 2016 to calculate current activation potential******************** 
if(abcd.Value_Bucket__c == 'very low' && Final1 != null  && abcd.Project_Quarter__c!='' && abcd.Project_Quarter__c!=null)
{
    abcd.Potential_Current__c = '1';
}
else if(abcd.Value_Bucket__c == 'very low')
{
    abcd.Potential_Current__c = '';
}
 
 else if(Final1 == 1)
{
    if(abcd.Project_Quarter__c =='Q1')
    {
        abcd.Potential_Current__c = '3';
    } 
    else if(abcd.Project_Quarter__c =='Q2')
    {
        abcd.Potential_Current__c = '1';
    }
    else if(abcd.Project_Quarter__c =='Q3' || abcd.Project_Quarter__c =='Q4')
    {
        abcd.Potential_Current__c = '0';
    }
    else 
    {
        abcd.Potential_Current__c = '';
    }
}
else if(Final1 == 2)
{
    if(abcd.Project_Quarter__c =='Q1')
    {
        abcd.Potential_Current__c = '4';
    }
    else if(abcd.Project_Quarter__c =='Q2')
    {
        abcd.Potential_Current__c = '2';
    }
    else if(abcd.Project_Quarter__c =='Q3')
    {
        abcd.Potential_Current__c = '1';
    }
     else if(abcd.Project_Quarter__c =='Q4')
    {
        abcd.Potential_Current__c = '0';
    }
    else
    {
        abcd.Potential_Current__c = '';
    }
}
else if(Final1 == 3)
{
    if(abcd.Project_Quarter__c =='Q1')
    {
        abcd.Potential_Current__c = '4';
    }
    else if(abcd.Project_Quarter__c =='Q2')
    {
        abcd.Potential_Current__c = '2';
    }
    else if(abcd.Project_Quarter__c =='Q3')
    {
        abcd.Potential_Current__c = '1';
    }
    else if(abcd.Project_Quarter__c =='Q4')
    {
        abcd.Potential_Current__c = '1';
    }
    else
    {
        abcd.Potential_Current__c = '';
    }
}
else if(Final1 == 4)
{
    if(abcd.Project_Quarter__c =='Q1')
        {
            abcd.Potential_Current__c = '5';
        }
        else if(abcd.Project_Quarter__c =='Q2')
        {
            abcd.Potential_Current__c = '3';
        }
        else if(abcd.Project_Quarter__c =='Q3')
        {
            abcd.Potential_Current__c = '1';
        }
        else if(abcd.Project_Quarter__c =='Q4')
        {
            abcd.Potential_Current__c = '1';
        }
         else
        {
            abcd.Potential_Current__c = '';
        }
}
else
{
    abcd.Potential_Current__c = '';
}
//****************************************************************************************************************************************************
    }
}

//commented by bharti on date 2/16/2013
//backup of old code for reference


/*  List <ID> dodgeProjectIDs = New List <ID>();
    List <ID> newDodgeProjectIDs = New List <ID>();
    Map <ID, ID> mapJobProfiletoDodgeProject = New Map <ID, ID>();
    
    for (Job_Profile__c jp : Trigger.New){
    
        if (jp.Dodge_Project__c != NULL) dodgeProjectIDs.Add(jp.Dodge_Project__c);
    
    }
    
    if (dodgeProjectIDs.size() > 0){
    
        Job_Profile__c[] duplicateJobProfiles = [Select Id, Dodge_Project__c From Job_Profile__c WHERE Dodge_Project__c in :dodgeProjectIDs];
        
        for (Job_Profile__c djp : duplicateJobProfiles){
        
            if (djp.Dodge_Project__c != NULL && mapJobProfiletoDodgeProject.containsKey(djp.Dodge_Project__c) == FALSE){
                mapJobProfiletoDodgeProject.put(djp.Dodge_Project__c, djp.Dodge_Project__c);
            }
        }
        
        for (Job_Profile__c jp : Trigger.New){
        
            if (jp.Dodge_Project__c != NULL && mapJobProfiletoDodgeProject.containsKey(jp.Dodge_Project__c) == TRUE){
                jp.addError('A Job Profile for this Dodge Project already exists');
            }
            else{
                newDodgeProjectIDs.Add(jp.Dodge_Project__c);
            }
        
        }   
        
        if (newDodgeProjectIDs.size() > 0){
        
            Dodge_Project__c[] dodgeproj = [Select Id, Job_Profile_Status__c from Dodge_Project__c Where Id in :newDodgeProjectIDs];
            
            for (Dodge_Project__c dp : dodgeproj){
            
                dp.Job_Profile_Status__c = 'Created';
            
            }
            
            update dodgeproj;
    
        }   

    }   */