/*************************************************************************
Name   : TestJobProfileReportController
Usage  : Test class to test JobProfileReportController apex class.
Author : Bharti
Date   : July 05, 2012
*************************************************************************/
@isTest
private class TestJobProfileReportController {

    static testMethod void myUnitTest() { 
      
     CreateData();
      Test.startTest(); 
      JobProfileReportController.PAGESIZE = 10;  
        JobProfileReportController controller = new JobProfileReportController();
        controller.selectedBranch = '113';
        controller.selectedSellingRegion = '3';                                               // TFS 4320
        controller.selectedBidDate = 'Today and Prior';                                     // TFS 4320
        
        controller.search();
        
        controller.selectedBidDate = 'All';                                            // TFS 4320
        controller.selectedKeySub = '1';
        controller.search();
        
        controller.selectedBidDate = 'This Week';                                     // TFS 4320
        controller.selectedUserName = 'First_TEST TEST_LAST_NAME';
        controller.search();
        
        controller.selectedBidDate = 'This Month';                                     // TFS 4320
        controller.selectedOpenAct = 'Call';
        controller.search();
        
        controller.selectedBidDate = 'This Quarter';                                     // TFS 4320
        controller.search();
        
        String[] a = controller.getCharList();                                         // TFS 4320
        controller.sortSearchResultGC();                                        
        controller.sortSearchResultElectrical();
        controller.sortSearchResultPlumbing();
        controller.sortSearchResultHVAC();
        
        // verify assert
        System.assert(55>=controller.totalResults);
        System.assertEquals(1,controller.showingFrom);
        System.assertEquals(6,controller.totalPage);
        System.assertEquals(true,controller.hasNext);
        System.assertEquals(false,controller.hasPrevious);
        
         controller.searchContractor();
        
        // verify assert for contractors
        System.assert(55>=controller.totalResults);
        System.assertEquals(1,controller.showingFrom);
        System.assertEquals(6,controller.totalPage);
        System.assertEquals(true,controller.hasNext);
        System.assertEquals(false,controller.hasPrevious);
        
        controller.nextPage();
        controller.previousPage();
        controller.firstPage();
        controller.lastPage();
        controller.sortField = 'GC';
        controller.doSort();
        controller.sortField = 'Electrical';
        controller.doSort();
        controller.sortField = 'Plumbing';
        controller.doSort();
        controller.sortField = 'HVAC';
        controller.doSort();
        controller.sortField = 'FireSprinkler';
        controller.doSort();
        controller.sortField = 'Drywall';
        controller.doSort();
        controller.sortField = 'Painting';
        controller.doSort();
        controller.sortField = 'Landscape';
        controller.doSort();
        controller.doSort();
        controller.showsubcontractor = false;
        controller.exportToExcel();                       // TFS 4320
        
        Test.stopTest();
    }
  
    static void CreateData() {
    
      User userObj = MMIFullquoteTestDataProvider.getUser();
       insert userObj;
        system.runAs(userObj){  
         list<Job_Profile__c> jobProfileList = new list<Job_Profile__c>();
          for(Integer i=0;i<55;i++) {
           Job_Profile__c jobProfile = new Job_Profile__c();
           jobProfile.Name = '00TestProfile' + i;
           jobProfile.Branch_ID__c = '113';
           jobProfile.Selling_Region__c = '3';                         // TFS 4320
           jobProfile.Project_Stage_Status__c = 'Awarded';            // TFS 4320
           jobProfile.Bid_Date__c = system.today();                  // TFS 4320
           
           
           //jobProfile.Project_Stage_Status__c = 'Completed';
           
           jobProfileList.add(jobProfile);
       }
       
       insert jobProfileList;
       
       // TFS 4581 ..
       BatchUpdateJobProfileTerritory jb = new BatchUpdateJobProfileTerritory();
       Id BatchJobId = Database.executeBatch(jb);
       
       Account acc = new Account();
                acc.Name = 'test';
                acc.Industry = '0-Non-classified/Unknown';
                acc.Type = 'Prospect - National Account';
                acc.Territory__c = '158-01';
                acc.BillingCountry = 'USA';
                acc.BillingPostalCode='85282';
                insert acc;
                            
       list<Task> taskList = new list<Task>(); 
       List<Sub_Contractor__c> sclist = new List<Sub_Contractor__c>();    // TFS 4320
       
       for(Job_Profile__c jobProfile : jobProfileList){
         Task task = new Task(Job_Profile_ID__c = jobProfile.id);
         taskList.add(task);
                  
        Sub_Contractor__c sc = new Sub_Contractor__c(Account__c = acc.Id, Job_Profile__c = jobProfile.Id,Role__c = 'Electrical Contractor');
        sclist.add(sc);  
       }
       
       taskList[1].Status = 'Completed';
       
       insert taskList;
       insert sclist;
       
       sclist[1].Role__c = 'General Contractor';
       sclist[2].Role__c = 'Plumbing Contractor';
       sclist[3].Role__c = 'HVAC Contractor';  
             
       update sclist; 
             
    }
  }
}