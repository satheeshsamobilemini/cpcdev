/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class TESTJobProfileDuplicateCheck {

    /*
    
        Test Cases for JobProfileDuplicateCheck.trigger
    
    */

    static testMethod void jobProfileDuplicateTest() {
    
        test.startTest();
        
        RecursiveTriggerUtility.isJBcreationCalled = true ;
        
        // creating Dodge_Project__c object record
        Dodge_Project__c dp = New Dodge_Project__c(Project_Name__c = 'Test',Country__c = 'US');
        insert dp;
        
        // TFS 8791 - creating Dodge_Project__c object record
        Dodge_Project__c dp2 = New Dodge_Project__c(Project_Name__c = 'Test Project',Country__c = 'US',Market_Segment__c='Worship',Ownership_Type__c='Local Gov',
        Primary_Project_Type__c = 'Communication Building',Type_Of_Work__c='New Project',Project_Valuation_High__c=100000000,Project_Valuation_Low__c=100000000,
        Zip__c = '879541',Target_Start_Date__c=Date.NewInstance(2015,07,15));
        insert dp2;
                
        Dodge_Project__c dp2_insert = [select Project_Valuation_High__c,Project_Valuation_Low__c from Dodge_Project__c where id =: dp2.Id]; 
        system.debug('----- dp2_insert.Project_Valuation_High__c ----------' +dp2_insert.Project_Valuation_High__c);
        system.debug('----- dp2_insert.Project_Valuation_Low__c ----------' +dp2_insert.Project_Valuation_Low__c);
        
        // TFS 8791 - creating Potential_Rule_Set__c object record
        Potential_Rule_Set__c prs = New Potential_Rule_Set__c(Market_Segment__c='OTHER',Ownership_Type__c='LOCAL GOV',Project_Type__c='OTHER',
        Type_of_work__c='NEW PROJECT',value_bucket__c='VERY LOW',cluster__c=4);
        insert prs;
        
        Potential_Rule_Set__c prs_inserted = [select Unique_Id__c from Potential_Rule_Set__c where id =: prs.Id]; 
        system.debug('-------- prs_inserted.Unique_Id__c ---------------' + prs_inserted.Unique_Id__c);
             
        // creating Glenigan_Project__c object record
        Glenigan_Project__c gleniganProj = new Glenigan_Project__c();
        insert gleniganProj;
        
        // creating Job_Profile__c object record
        Job_Profile__c jp1 = New Job_Profile__c(Project_Valuation_High__c = 400000,Project_Valuation_Low__c = 200000,Name = dp.Project_Name__c, Dodge_Project__c = dp.Id, Glenigan_Project__c = gleniganProj.Id, Job_Site_Zip__c = dp.Zip__c, Job_Site_Country__c = dp.Country__c);          
        double Final1 = 1;
        insert jp1;
     
             
        
        Dodge_Project__c dpAfterInsert = [Select id, Job_Profile_Status__c From Dodge_Project__c Where id = :dp.Id];
        Glenigan_Project__c gleniganProjAfterInsert = [Select id, Job_Profile_Status__c From Glenigan_Project__c Where id = :gleniganProj.Id];
        
        //system.assertequals('Created', dpAfterInsert.Job_Profile_Status__c);
        system.assertequals('Created', gleniganProjAfterInsert.Job_Profile_Status__c);
        
        try{
        
            Job_Profile__c jp2 = New Job_Profile__c(Name = dp.Project_Name__c, Dodge_Project__c = dp.Id, Job_Site_Zip__c = dp.Zip__c, Job_Site_Country__c = dp.Country__c,Target_Start_Date__c=Date.NewInstance(2016,10,05));         
            insert jp2;  
        }
        
        catch(exception e){
        
            // We are expecting an error here
        }
        
        try{
            Job_Profile__c jp3 = New Job_Profile__c(Name = gleniganProj.Name, Glenigan_Project__c = gleniganProj.Id, Job_Site_Zip__c = dp.Zip__c, Job_Site_Country__c = dp.Country__c);         
            insert jp3;   
        }
        
        catch(exception e){
        
            // We are expecting an error here
        
        }
        
        // TFS 8791..
        try{
            Job_Profile__c jp4 = New Job_Profile__c(Name = dp2.Project_Name__c,Job_Site_Zip__c = 'dp2.Zip__c',Dodge_Project__c = dp2.Id,Job_Site_Country__c = dp2.Country__c,
            Project_Valuation_High__c=1000000,Project_Valuation_Low__c=1000000,Target_Start_Date__c=Date.NewInstance(2016,01,05));
            insert jp4;
            
            Job_Profile__c jp4_in = [select Market_Segment_New__c,Ownership_Type__c,Primary_Project_Type_New__c,Dodge_Project_Type_of_Work_New__c,Value_Bucket__c from Job_Profile__c where id =: jp4.id];
                 
            string UniqueID1 = jp4_in.Market_Segment_New__c + ':' + jp4_in.Ownership_Type__c + ':' + jp4_in.Primary_Project_Type_New__c + ':' + jp4_in.Dodge_Project_Type_of_Work_New__c+ ':' + jp4_in.Value_Bucket__c;
            string CV1 = UniqueID1.touppercase();
            
            system.debug('--------------- jp4_in.Value_Bucket__c -------------' + jp4_in.Value_Bucket__c);          
            system.debug('----- UniqueID1 ------------'+ UniqueID1);
            system.debug('----- CV1 ------------'+ CV1); 
            
            jp4.Dodge_Project__c = dp.Id;
            update jp4;
            
            Job_Profile__c jp4_up = [select Market_Segment_New__c,Ownership_Type__c,Primary_Project_Type_New__c,Dodge_Project_Type_of_Work_New__c,Value_Bucket__c from Job_Profile__c where id =: jp4.id];
            
            string UniqueID2 = jp4_up.Market_Segment_New__c + ':' + jp4_up.Ownership_Type__c + ':' + jp4_up.Primary_Project_Type_New__c + ':' + jp4_up.Dodge_Project_Type_of_Work_New__c+ ':' + jp4_up.Value_Bucket__c;
            string CV2 = UniqueID2.touppercase();
            
            system.debug('----- UniqueID2 ------------'+ UniqueID2);
            system.debug('----- CV2 ------------'+ CV2); 
        }
        
        catch(exception e){
          
          // We are expecting an error here
          
        }
                
        test.stopTest();    
    
    }
   static testMethod void jobProfileDuplicateTest_2() {
     Test.startTest();
       
       Potential_Rule_Set__c objPotential = new Potential_Rule_Set__c();
          objPotential.Name = 'tet';
          objPotential.cluster__c = 2;
       insert objPotential;
       
       Potential_Rule_Set__c objPotential3 = new Potential_Rule_Set__c();
          objPotential3.Name = 'tet';
          objPotential3.cluster__c = 3;
       insert objPotential3;
       
       RecursiveTriggerUtility.isJBcreationCalled = true ;
       Dodge_Project__c dpj = new Dodge_Project__c(Project_Name__c='Tester Proj',Country__c='US',Primary_Project_Type__c='BANK',Market_Segment__c='MEDICAL',
       Ownership_Type__c='MILITARY',Type_Of_Work__c='INTERIORS',Project_Valuation_High__c=20000000,Project_Valuation_Low__c=20000000,Target_Start_Date__c =Date.NewInstance(2016,09,05));
       insert dpj;
       
       Job_profile__c jb = new Job_Profile__c(Name = dpj.Project_Name__c,Potential_Rule_Set__c = objPotential3.id,Dodge_Project__c = dpj.Id,Job_Site_Country__c = dpj.Country__c,
       Project_Valuation_High__c=2000000,Project_Valuation_Low__c=2000000,Target_Start_Date__c=Date.NewInstance(2016,09,05));
       insert jb;
       
       Dodge_Project__c dpj1 = new Dodge_Project__c(Project_Name__c='Tester Proj',Country__c='US',Primary_Project_Type__c='BANK',Market_Segment__c='MEDICAL',
       Ownership_Type__c='MILITARY',Type_Of_Work__c='INTERIORS',Project_Valuation_High__c=2000000,Project_Valuation_Low__c=2000000);
       insert dpj1;
       
       Job_profile__c jb1 = new Job_Profile__c(Name = dpj.Project_Name__c,Potential_Rule_Set__c = objPotential.id,Dodge_Project__c = dpj1.Id,Job_Site_Country__c = dpj.Country__c,
       Project_Valuation_High__c=300000000,Project_Valuation_Low__c=700000000,Target_Start_Date__c=Date.NewInstance(2016,09,05));
       insert jb1;
       
       Potential_Rule_Set__c objPotential4 = new Potential_Rule_Set__c();
          objPotential4.Name = 'tet';
          objPotential4.cluster__c = 4;
       insert objPotential4;
       
       Job_profile__c jb4 = new Job_Profile__c(Name = dpj.Project_Name__c,Potential_Rule_Set__c = objPotential4.id,Job_Site_Country__c = dpj.Country__c,
       Project_Valuation_High__c=300000000,Project_Valuation_Low__c=700000000,Target_Start_Date__c=Date.NewInstance(2016,09,05));
       insert jb4;
       
       Potential_Rule_Set__c prs_1 = New Potential_Rule_Set__c(Market_Segment__c='MEDICAL',Ownership_Type__c='MILITARY',Project_Type__c='BANK',
       Type_of_work__c='INTERIORS',value_bucket__c='MEDIUM',cluster__c=2);
       insert prs_1;
       
     Test.stopTest();
   }  
}

//commented by bharti on date 2/16/2013
//backup of old code for reference

/*
    @isTest
private class TESTJobProfileDuplicateCheck {

  
    static testMethod void myUnitTest() {
    
        test.startTest();
        
        Dodge_Project__c dp = New Dodge_Project__c(Project_Name__c = 'Test', Zip__c = '90210-4444', Country__c = 'United States');
        insert dp;

    Job_Profile__c jp1 = New Job_Profile__c(Name = dp.Project_Name__c, Dodge_Project__c = dp.Id, Job_Site_Zip__c = dp.Zip__c, Job_Site_Country__c = dp.Country__c);        
        insert jp1;

        Dodge_Project__c dpAfterInsert = [Select id, Job_Profile_Status__c From Dodge_Project__c Where id = :dp.Id];
        
        system.debug('$$$$$$$$ --> dpAfterInsert.Job_Profile_Status__c = ' + dpAfterInsert.Job_Profile_Status__c);
        system.assertequals('Created', dpAfterInsert.Job_Profile_Status__c);
        
        try{
        
      Job_Profile__c jp2 = New Job_Profile__c(Name = dp.Project_Name__c, Dodge_Project__c = dp.Id, Job_Site_Zip__c = dp.Zip__c, Job_Site_Country__c = dp.Country__c);        
          insert jp2;        

    }
    
    catch(exception e){
    
      // We are expecting an error here
    
    }
        
        test.stopTest();    
    
    }
} */