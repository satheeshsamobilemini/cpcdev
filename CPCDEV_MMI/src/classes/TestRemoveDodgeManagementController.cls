/******************************************************************************* 
Class                   :   TestRemoveDodgeManagementController
Related Class           :   RemoveDodgeManagementController
Created By              :   Appirio Offshore (Megha Agarwal)
Created On              :   Mar 29, 2010
Description             :   Test Class for RemoveDodgeManagementController. 
Last Modified On        :   Mar 29, 2010
********************************************************************************/ 
@isTest
public class TestRemoveDodgeManagementController {

    static testmethod void testContoller1() {
        try{
            dodge_Project__c  dodge = createDodgeProject();
            ApexPages.currentPage().getParameters().put('id',dodge.id);
            ApexPages.currentPage().getParameters().put('SelectedBranch','890');
            
            Test.startTest();
             RemoveDodgeManagementController controller = new RemoveDodgeManagementController();
             controller.updateDodgeProject();
             controller.cancel();
            
             dodge.Approval_Status__c = 'Approved';
             update dodge;  
            Test.stopTest();
            
        } catch (Exception e) {
          System.debug('Exception in test class : ' + e);
        }
    }
    
    static testmethod void testContoller2() {
        try{
            User salesUser = [select Id,Email from User where isActive = true and UserRole.Name like 'Sales Rep%' LIMIT 1];
            dodge_Project__c  dodge = createDodgeProject();
            ApexPages.currentPage().getParameters().put('id',dodge.id);
            ApexPages.currentPage().getParameters().put('SelectedBranch','890');
            system.runAs(salesUser){
             
             Test.startTest();
              RemoveDodgeManagementController controller1 = new RemoveDodgeManagementController();
              controller1.updateDodgeProject();
              controller1.cancel();
             
              dodge.BM_Approver__c = null;
              update dodge;
              RemoveDodgeManagementController controller2 = new RemoveDodgeManagementController();
              controller2.updateDodgeProject();
             Test.stopTest();
                        
           }
           
             
        } catch (Exception e) {
          System.debug('Exception in test class : ' + e);
        }
    }
    
    static testmethod void testContoller3() {
        try{
            dodge_Project__c  dodge = createDodgeProject();
            dodge.Reason_Why_Project_Removed__c = 'Other';
            dodge.Reason_Removed_Comments__c = '';
            update dodge;
            ApexPages.currentPage().getParameters().put('id',dodge.id);
            ApexPages.currentPage().getParameters().put('SelectedBranch','890');
            ApexPages.currentPage().getParameters().put('selectedActionStages','Bid,Results');
            
            Test.startTest();
             RemoveDodgeManagementController controller1 = new RemoveDodgeManagementController();
             controller1.updateDodgeProject();
            
             dodge.Reason_Why_Project_Removed__c = '';
             update dodge;
             RemoveDodgeManagementController controller2 = new RemoveDodgeManagementController();
             controller2.updateDodgeProject();
            Test.stopTest();
            
        } catch (Exception e) {
          System.debug('Exception in test class : ' + e);
        }
    }
    
    static testmethod void testContoller4() {
        try{
            User salesUser = [select Id,Email from User where isActive = true and UserRole.Name like 'Sales Rep%' LIMIT 1];
            dodge_Project__c  dodge = createDodgeProject();
            dodge.BM_Approver__c = null;
            dodge.ISM_Approver__c = null;
            update dodge;
            ApexPages.currentPage().getParameters().put('id',dodge.id);
            ApexPages.currentPage().getParameters().put('SelectedBranch','890');
            
            system.runAs(salesUser){
            
            Test.startTest();
             RemoveDodgeManagementController controller = new RemoveDodgeManagementController();
             controller.updateDodgeProject();
             controller.cancel();
            Test.stopTest();
            
            }
           
           dodge.Approval_Status__c = 'Rejected';
           update dodge;
          } catch (Exception e) {
          System.debug('Exception in test class : ' + e);
        }
    }
    
    public static Dodge_Project__c createDodgeProject(){
      
      User repUser = [select Id,Branch__c,Territory__c,Email from User where isActive = true and UserRole.Name like 'Sales Rep%' LIMIT 1];
      repUser.Branch__c = '890';
      repUser.Territory__c = '890-01';
      update repUser; 
      
      User BMuser = [select Id,Branch__c,Email from User where isActive = true and UserRole.Name like 'Branch Manager%' LIMIT 1];
      BMuser.Branch__c = '890';
      update BMuser;
      
      User ISMuser = [select Id,Selling_Region__c,Email from User where isActive = true and UserRole.Name like 'Inside Sales/Outside Sales%' LIMIT 1];
      ISMuser.Selling_Region__c = '3';
      update ISMuser;
            
      Branch_LookUp__c bl = new Branch_LookUp__c(Zip__c='9807',Country__c='USA',Territory__c='890-01',Branch_Code__c='890',Selling_Region__c=3.0);
      insert bl;
      
      Dodge_Project__c dodge = new Dodge_Project__c(Project_Name__c='Test Dodge Project' ,Branch_ID__c='890',Reason_Removed_Comments__c='Test',Reason_Why_Project_Removed__c='Project Canceled',
                                                    Zip__c='9807',Country__c='USA',Approval_Status__c = 'Submitted',Dodge_Report_Number__c = '13324');
      insert dodge ;
      return dodge;
    }
}