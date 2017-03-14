/**
*
 */
@isTest
private class CompetitorInlineReportController_Test {

    static testMethod void myUnitTest() {
        // TO DO: implement unit test
        List<Competitor__c> lst = new List<Competitor__c>();
        Weekly_Snapshot_Branch_Report__c report = new Weekly_Snapshot_Branch_Report__c();
        //report.Name = 'Test';
        insert report;
        Competitor__c comp = new Competitor__c();
        comp.Name = 'Test';
        comp.Weekly_Snapshot_Branch_Report__c = report.id;
        insert comp;
        lst.add(comp);
        ApexPages.StandardController sc = new ApexPages.StandardController(comp);
        CompetitorInlineReportController compExtn = new CompetitorInlineReportController(sc);
        compExtn.competitors = lst;
        compExtn.editPage();
        compExtn.cancel();
        compExtn.addRow();
        compExtn.saveRecords();
        
        
    }
}