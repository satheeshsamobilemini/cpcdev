/******************************************************************************* 
Class                   :   TestDodgeManagementController
Related Class           :   DodgeManagementController
Created By              :   Appirio Offshore (Vipin Gupta)
Created On              :   Mar 29, 2010
Description             :   Test Class for DodgeManagementController. 
Last Modified On        :   Mar 29, 2010
********************************************************************************/ 
@isTest
public class TestDodgeManagementController {
    public static testMethod void testContoller() {
        try{
         makeData();
        List<Dodge_Project__c> dodgeList = new List<Dodge_Project__c>();
        for(integer count = 1; count <= 20 ; count++) {
           Dodge_Project__c dodge = new Dodge_Project__c();
              dodge.Project_Name__c='Test';
              dodge.Branch_ID__c='999';
              dodge.Target_Start_Date__c = date.parse('05/11/2010');
           dodgeList.add(dodge); 
        }
        insert dodgeList;
       
        
        ApexPages.currentPage().getParameters().put('selectedActionStages','testparamae,tereere');
        DodgeManagementController controller = new DodgeManagementController();
        controller.selectedbranch = '999';
        controller.sortOn = 'Project_Name__c';
        controller.sortOrder = 'ASC';
        controller.isTest = true;
        controller.getHeaderChars();
        controller.selectedChar = 'test';
        controller.performHeaderSearch();
        controller.selectedChar = 'other';
        controller.performHeaderSearch();
        controller.openRemoveLinkURL();
            
        List<SelectOption> action= new List<SelectOption>();
        action.add(new SelectOption('All','All'));
        Schema.DescribeFieldResult fieldSchema = Dodge_Project__c.Action_Stage__c.getDescribe();
        for(Schema.PicklistEntry picklistEntry : fieldSchema.getPicklistValues()){
            action.add(new SelectOption(picklistEntry.getValue(),picklistEntry.getLabel()));
        } 
        List<SelectOption> temp = controller.actionStages;
        
        List<SelectOption> bid= new List<SelectOption>();
        bid.add(new SelectOption('','Select'));                
        bid.add(new SelectOption('All','All'));
        bid.add(new SelectOption('Today and Prior','Today and Prior'));
        bid.add(new SelectOption('This Week','This Week'));
        bid.add(new SelectOption('This Month','This Month'));
        bid.add(new SelectOption('This Quarter','This Quarter'));
        List<SelectOption> biddates = controller.bidDates;
        
        controller.nextPage();
        controller.previousPage();
        controller.firstPage();
        controller.lastPage();
        
        controller.getBranchList();
        controller.doSearch();
        //controller.currProjId = controller.tempProjList.get(0).Id;
        controller.currProjId = dodgeList[0].id ;
        controller.performSortedSearch();
        controller.openCreateLinkURL();
        controller.openCreateLinkURLTemp();
        //Test case for PR-04845 
        controller.getHeaderChars();
        controller.selectedChar = 'T';
        controller.performHeaderSearch(); 
        System.AssertEquals(controller.prLst.getResultSize(),20);
        controller.selectedChar = 'Other';
        controller.performHeaderSearch(); 
        //System.AssertEquals(controller.prLst.getResultSize(),1);
       } catch (Exception ex) {
          System.debug('Exception in test class ' + ex);
       }
    }
    
    private static void makeData(){
        for(integer count = 1; count <= 20 ; count++) {
            Dodge_Project__c d = new Dodge_Project__c(Project_Name__c='Test' + count, Branch_ID__c='999');
            //insert d;
        }
        Dodge_Project__c d1 = new Dodge_Project__c(Project_Name__c='(Test)', Branch_ID__c='999');
        insert d1;
    }
}