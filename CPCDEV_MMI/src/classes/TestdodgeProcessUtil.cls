/**************************************************************************
Name: TestdodgeProcessUtil
----------------------------------------------------------------------
Purpose: This class is created for Job Profile Sweep Logic process 
Created by TEKsystem Development team
----------------------------------------------------------------------
**************************************************************************/

@isTest

private with sharing class TestdodgeProcessUtil {
    
    static testMethod void myUnitTestMethod1(){
    
    Profile p1 = [select id from profile WHERE Name='System Administrator'];
    
    User usrObj = new user(Alias='TESTUSER',Email='TEST.USER@TEST.TEST',
            EmailEncodingKey='UTF-8',FirstName='First_TEST',LastName='TEST_LAST_NAME', LanguageLocaleKey='en_US',
            LocaleSidKey='en_GB',timezonesidkey='Europe/London',Title='TEST TITLE',
            username='TEST.USER@TEST.TEST',Branch__c='101-Phoenix',Territory__c = '987-06',ProfileId = p1.Id);

         insert usrObj;   
         
      system.runAs(usrObj){
        
        Account acc = MMIFullquoteTestDataProvider.getBusinessAccount();
           acc.OwnerID = usrObj.id;
           acc.BillingPostalCode = '19031';
           insert acc;
 
       
        Job_Profile__c jp = MMIFullquoteTestDataProvider.getJobProfile();
                insert jp;
        
        Job_Profile__c jpCM = new Job_Profile__c(Name='test jpCM', Expected_Completion_Date__c=system.today(), Job_Site_Zip__c='85282',
                                    Job_Site_Country__c='USA' ) ;
                insert jpCM; 
                
        Branch_Lookup__c branch = new Branch_Lookup__c(Zip__c = '85282', County__c = 'USA',Territory__c = '987-06');
               insert branch;   
          
         // sc with Role GC ..        
        Sub_Contractor__c scGC = new Sub_Contractor__c();
            scGC.Account__c = acc.Id;
          	scGC.Account__r = acc;
            scGC.Job_Profile__c = jp.Id;
            scGC.Role__c = 'General Contractor';
            insert scGC;
            system.debug('scGC.Account__r.BillingPostalCode===============>>>>>>>>>'+scGC.Account__r.BillingPostalCode);
        // sc with Role CM ..         
        Sub_Contractor__c scCM = new Sub_Contractor__c();
            scCM.Account__c = acc.Id;
          	scCM.Account__r = acc;
            scCM.Job_Profile__c = jpCM.Id;
            scCM.Role__c = 'Construction Manager';
            insert scCM;
            
         // adding sc with Role CM again ..     
        Sub_Contractor__c scCM2 = new Sub_Contractor__c();
            scCM2.Account__c = acc.Id;
          	scCM2.Account__r = acc;
            scCM2.Job_Profile__c = jpCM.Id;
            scCM2.Role__c = 'Construction Manager';
            insert scCM2;
            
        // adding sc with Role other than GC and CM  ..         
        Sub_Contractor__c scOthers = new Sub_Contractor__c();
            scOthers.Account__c = acc.Id;
            scOthers.Job_Profile__c = jp.Id;
            scOthers.Role__c = 'Electrical Contractor';
          //insert scOthers;    
        
        List<Sub_Contractor__c> scList = new List<Sub_Contractor__c>();
        scList.add(scGC);
        
        List<Job_Profile__c>  jobProfileList = new List<Job_Profile__c>();  
        jobProfileList.add(jpCM);
        
        dodgeProcessUtil.processNewGc(scList);
        dodgeProcessUtil.processGcCmBranchAccount(scList);  
        dodgeProcessUtil.processGcCmNonBranchAccount(scList); 
        dodgeProcessUtil.notifyScBasedOnTerritory(scList);
        dodgeProcessUtil.updateJp(jobProfileList);
        dodgeProcessUtil.CreateTasksBAsubContractors(scList);
       // dodgeProcessUtil.processSCListasperRole(scList,false);
       
       }     
    }
}