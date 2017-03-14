global class BatchDodgeProjectUpdate implements Database.Batchable<sObject>{

  global Database.queryLocator start(Database.BatchableContext bc){
    return Database.getQueryLocator([select d.Zip__c,d.Territory__c,d.Country__c,d.Branch_ID__c,d.isDodgeUpdate__c,d.Approval_Status__c,d.Approver_mail__c,
                                     d.BM_Approver__c,d.isBMactive__c,d.isISMactive__c,d.ISM_Approver__c,d.isRepActive__c,d.Job_Profile_Status__c,
                                     d.Reason_Removed_Comments__c,d.Reason_Why_Project_Removed__c,d.Removed_By__c,d.Requester_Email__c,d.Request_Status__c,d.Sales_Rep__c,
                                     d.Selling_Region__c from Dodge_Project__c d where d.Zip__c <> null and d.Zip__c <> '' and d.isDodgeUpdate__c = false]);
  }
  
  global void execute(Database.BatchableContext bc, List<sObject> scope){
   List<Dodge_Project__c> DpList = (List<Dodge_Project__c>)scope;
   system.debug(' ----- Dodge Project List size ---'+ DpList.size());
   
    for(integer i = 0; i< DpList.size(); i++){
      DpList[i].isDodgeUpdate__c = true;
    }
   List<Database.SaveResult> DpResults = Database.update(DpList,false);
  }
  
  global void finish(Database.BatchableContext bc){
  }
  
}