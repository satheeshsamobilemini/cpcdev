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
private class TESTDodgeProjectUpdatePostalCode {

    /*
    
        Test cases for: DodgeProjectUpdatePostalCode.trigger
    
    */

    static testMethod void myUnitTest() {
        
        DodgeProject_ActionStages__c dp_1 = new DodgeProject_ActionStages__c(Name = 'Test Name');
        dp_1.StageName__c  = 'Bid Results;GC Bidding-Invitation';
        insert dp_1;           
        
        test.startTest();
        
        system.RunAs(new User(Id = UserInfo.getUserId())){
             
        Dodge_Project__c dp = New Dodge_Project__c(Project_Name__c = 'Test', Zip__c = '90210-4444', Country__c = 'United States');
        dp.Action_Stage_Grouping__c='Bidding/Negotiating';
        dp.Action_Stage__c='GC Bidding-Invitation';
        dp.Approval_Status__c = 'Submitted';
        insert dp;
        
        system.debug('$$$$$ --> New Dodge Project: ' + dp);
        
        Dodge_Project__c dpAfterInsert = [Select id, Branch_Id__c, Zip__c From Dodge_Project__c Where id = :dp.Id];
        
        system.debug('$$$$$ --> New Dodge Project (After Insert): ' + dpAfterInsert);
        
            Branch_Lookup__c  objbranch = new Branch_Lookup__c();
              objbranch.Zip__c = '90210';
              objbranch.Branch_Code__c = '258';
            insert objbranch; 
            
        Branch_Lookup__c bl = [Select Id, Branch_Code__c from Branch_Lookup__c where Zip__c = '90210']; 
        
        system.assertequals(dpAfterInsert.Id, dp.Id);
        //system.assertequals(bl.Branch_Code__c, dpAfterInsert.Branch_Id__c);
        
        Dodge_Project__c dp2 = New Dodge_Project__c(Project_Name__c = 'Test', Zip__c = '80000-4444', Country__c = 'United States');
        dp2.Approval_Status__c = 'Submitted';
        dp2.Action_Stage_Grouping__c='Operation';
        dp2.Action_Stage__c = 'Retrofit';
        insert dp2;
        
        Job_Profile__c jb = new Job_Profile__c(Name = 'JB Test',Dodge_Project__c = dp2.Id,Referral_Source__c='Dodge');
        insert jb;  
        
        dp.Approval_Status__c = 'Approved';
        update dp;                  
      }
      test.stopTest();        
    }
    
    static testMethod void myUnitTest2(){
              
     test.startTest();     
      Ruleset__c[] rsList = new List<Ruleset__c>();
      Dodge_Project__c[] dpList = new List<Dodge_Project__c>();      
      
      Ruleset__c rs1 = new Ruleset__c(Project_Attribute__c='2- Low-New Project-Military-Multi Residential',Quad__c='HC_HR'); 
      rsList.add(rs1);
      Ruleset__c rs2 = new Ruleset__c(Project_Attribute__c='1- Very Low Project-Military-WORSHIP',Quad__c='LC_LR');
      rsList.add(rs2);
      Ruleset__c rs3 = new Ruleset__c(Project_Attribute__c='3- Medium-Additions-Military-Others',Quad__c='LC_HR');
      rsList.add(rs3);
      Ruleset__c rs4 = new Ruleset__c(Project_Attribute__c='4- High-Additions-Private-Multi Residential',Quad__c='HC_LR');
      rsList.add(rs4);
      
      insert rsList;
      
      Dodge_Project__c dp1 = new Dodge_Project__c(Project_Valuation_High__c=500000,Project_Valuation_Low__c=5500000,Market_Segment__c='Multi-residential',Type_Of_Work__c='Additions');
      dpList.add(dp1);
      Dodge_Project__c dp2 = new Dodge_Project__c(Project_Valuation_High__c= 10000000,Ownership_Type__c='Military',Type_Of_Work__c='Alterations');
      dpList.add(dp2);
      Dodge_Project__c dp3 = new Dodge_Project__c(Project_Valuation_Low__c= 40000000,Market_Segment__c= 'WORSHIP',Type_Of_Work__c='Interiors');
      dpList.add(dp3);
      Dodge_Project__c dp4 = new Dodge_Project__c(Project_Valuation_High__c= 100000000,Project_Valuation_Low__c= 100000000,Market_Segment__c='Others',Type_Of_Work__c='New Project');
      dpList.add(dp4);
      
      insert dpList;       
     
     test.stopTest(); 
    }
    
    static testMethod void unitTest3(){
      DodgeProject_ActionStages__c dp_3 = new DodgeProject_ActionStages__c(Name = 'Test Name');
        dp_3.StageName__c  = 'Bid Results;GC Bidding-Invitation';
        insert dp_3;           
        
        test.startTest();
        system.RunAs(new User(Id=UserInfo.getUserId())){
             
          Dodge_Project__c dp2 = New Dodge_Project__c(Project_Name__c = 'Test Dodge', Zip__c = '80000-4444', Country__c = 'United States');
          dp2.Approval_Status__c = 'Submitted';
          dp2.Action_Stage_Grouping__c='Operation';
          dp2.Action_Stage__c = 'Retrofit';
          insert dp2;
        
          dp2.Zip__c = '';
          dp2.Approval_Status__c = 'Rejected';
          dp2.Target_Start_Date__c = system.today();
          dp2.Bid_Date__c = system.today() + 2;
          dp2.Action_Stage_Grouping__c='Bidding/Negotiating';
          dp2.Action_Stage__c='Bid Results';
          update dp2;
        
          dp2.Zip__c = '10000-4444';
          dp2.IsChecked__c = true;
          update dp2; 
          
        }         
        Test.stopTest();
    }
    
}