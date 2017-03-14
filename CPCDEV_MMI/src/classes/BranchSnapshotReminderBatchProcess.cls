global class BranchSnapshotReminderBatchProcess implements Database.Batchable<sobject>{
    global Id branchSnapshotId;
    global Boolean isTest;
    global DateTime currentTime;
    
    global BranchSnapshotReminderBatchProcess(Id branchSnapshotId, DateTime currentTime){
        this.branchSnapshotId = branchSnapshotId;
        this.currentTime = currentTime;
        this.isTest = false;
    } 
    
    global Database.QueryLocator start(Database.batchableContext bc){
        String branchSnapshotQuery = 'select id , Name , OwnerId  from Weekly_Snapshot_Branch_Report__c ';
        DateTime filterDate = currentTime;
        if(filterDate != null ){
            if(filterDate.format('EEE') =='Mon')
                filterDate =  filterDate.addDays(-4);
            else if(filterDate.format('EEE') =='Tue')
                filterDate = filterDate.addDays(-5);
        }
        if(!isTest){
            branchSnapshotQuery += ' where LastModifiedDate < : filterDate ';
        }else if(branchSnapshotId != null){
            branchSnapshotQuery += ' where id  = : branchSnapshotId ';
        }
        return Database.getQueryLocator(branchSnapshotQuery);
    }
    
    global void execute(Database.batchableContext bc, List<sobject> scope){
        BranchSnapShotReminderUtil.sendMail(scope,DateTime.now());
    }
    
    global void finish(Database.batchableContext bc){}

}