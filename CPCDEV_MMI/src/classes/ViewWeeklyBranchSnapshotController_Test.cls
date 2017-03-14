/**
 *
Created by Najma Ateeq

 */
@isTest
private class ViewWeeklyBranchSnapshotController_Test {

    static testMethod void myUnitTest() {
        Weekly_Snapshot_Branch_Report__c report = new Weekly_Snapshot_Branch_Report__c();
        report.Servicing_Branch__c  = '00';
        insert report;
        ApexPages.currentPage().getParameters().put('servicingBranch','00');
        ViewWeeklyBranchSnapshotController cntrl = new ViewWeeklyBranchSnapshotController();
        cntrl.back();
        
    }
}