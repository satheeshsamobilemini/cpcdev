public with sharing class ViewWeeklyBranchSnapshotController {
    
    public Id weeklyBranchSnapshotId{get;set;}
    public String servicingBranch{get;set;}
    public String messages{get;set;}
    private String retURL{get;set;}
    public ViewWeeklyBranchSnapshotController(){
        servicingBranch = ApexPages.currentPage().getParameters().get('servicingBranch');
        retURL = ApexPages.currentPage().getParameters().get('retURL');
        if(servicingBranch != null && servicingBranch.length() > 0){
            String filterCon = '%'+servicingBranch+'%';
            for(Weekly_Snapshot_Branch_Report__c weeklySB : [select id from Weekly_Snapshot_Branch_Report__c where Servicing_Branch__c like : filterCon]){
                weeklyBranchSnapshotId = weeklySB.id;
            }
        } 
    }
    
    public PageReference back(){
        if(retURL != null)
            return new PageReference(retURL);
        else{
            return null;
        }
    }

}