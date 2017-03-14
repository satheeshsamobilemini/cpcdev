public with sharing class CompetitorInlineReportController {
    
    private Id weeklySnapshotBranchReportId ;
    public List<Competitor__c> competitors{get;set;}
    public Boolean isEdit{get;set;}
    public CompetitorInlineReportController(ApexPages.StandardController stdController){
        weeklySnapshotBranchReportId = stdController.getId();
        competitors = loadCompetitors();
        isEdit = false;
        
    }
    
    public List<Competitor__c> loadCompetitors(){
        List<Competitor__c> tempCompetitors = [select id ,Name,Competitor_Website__c, X10__c,X10_OB__c, X20__c, X20_Combo__c,X20_OB__c,X20_TT__c,X40__c,X40_Combo__c,X40_OB__c,X40_TT__c,color__c, how_To_Sell_against__c ,Locking_System__c , Comments__c , Weekly_Snapshot_Branch_Report__c from Competitor__c where Weekly_Snapshot_Branch_Report__c = : weeklySnapshotBranchReportId order by createdDate] ;
        return tempCompetitors;
    }
    
    public PageReference editPage(){
        isEdit = true;
        return null;
    }
    
    public PageReference cancel(){
        isEdit = false;
        return null;
    }
    
    public PageReference addRow(){
        competitors.add(new Competitor__c(Weekly_Snapshot_Branch_Report__c = weeklySnapshotBranchReportId));
        return null;
    }
    public PageReference saveRecords(){
        List<Competitor__c> tempCompetitors = new List<Competitor__c>();
        try{
            for(Competitor__c com : competitors){
                if(com.Name != null)
                    tempCompetitors.add(com);
            }
            if(tempCompetitors.size() < 3){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please add at least 3 competitors'));
            }else{
                upsert tempCompetitors;
                competitors = loadCompetitors();
                isEdit = false;
            }
        }catch(Exception ex){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage()));
        }
        return null;
    }

}