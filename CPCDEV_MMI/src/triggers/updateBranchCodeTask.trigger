trigger updateBranchCodeTask on Task (before insert, before update) {
    
   if(TriggerSwitch.isTriggerExecutionFlagDisabled('Task','updateBranchCodeTask')){return;} 
  
    // Creates a map between User ID and the User's branch code
    Map<ID, String> userBranchCode = New Map<ID, String>();
    List<ID> ownerIds = New List<ID>();
    List<Task> tasksToUpdate = New List<Task>();

    //new variable added for PR-06139
    Set<Id> jobProfileIdSet = new Set<Id>();
    List<Task> jobProfileTaskList = new List<Task>();
    Private String BranchUserID = '';   
    String jobProfileKeyPrefix = Schema.getGlobalDescribe().get('Job_Profile__c').getDescribe().getKeyPrefix();

    List<Branch_Account_User_id__c> BranchAccountIdList = null;
    
    BranchAccountIdList = Branch_Account_User_id__c.getAll().Values();
    
    if(test.isRunningTest()){
        User branchAccountUserID = [Select Id from User where name = 'Branch Account'];
        BranchUserID = branchAccountUserID.Id;
    }else{
        if(BranchAccountIdList != null && !BranchAccountIdList.isEmpty()){
            BranchUserID = BranchAccountIdList.get(0).User_Id__c;   
    }
    }   

    if (trigger.isInsert){
    
        for (integer i=0;i<trigger.new.size();i++){
            // only process if the owner is not "Branch Account"
            if (trigger.new[i].ownerId != BranchUserID){
                ownerIds.add(trigger.new[i].OwnerId);
                tasksToUpdate.add(trigger.new[i]);
            }
            // Added on 25-02-2011 (PR-08448)
            //  set Job Profile id if what id contains Job Profile Id
            if(trigger.new[i].WhatId != null && (String.ValueOf(trigger.new[i].WhatId)).startsWith(jobProfileKeyPrefix) && (trigger.new[i].Job_Profile_Id__c == null || trigger.new[i].Job_Profile_Id__c != '')){
                trigger.new[i].Job_Profile_Id__c = trigger.new[i].WhatId;
            }
            // 2010.08.04 - MKS
            // Added to maintain a unique 18 character Job Profile ID
            if (trigger.new[i].Job_Profile_Id__c != NULL && trigger.new[i].Job_Profile_Id__c != '' ){
                if(trigger.new[i].Job_Profile_Id__c.length() == 15)
                {
                 trigger.new[i].Job_Profile_Id__c = TaskUtility.idsTo18(trigger.new[i].Job_Profile_Id__c);
                }
                //code for mapping Job profile Name field 
                jobProfileIdSet.add(trigger.new[i].Job_Profile_Id__c);
                jobProfileTaskList.add(trigger.new[i]);
            }
            
        }
    
    }

    if (trigger.isUpdate){
    
        for (integer i=0;i<trigger.new.size();i++){
            // only process if the owner has changed AND the owner is not "Branch Account"
            if (((trigger.new[i].ownerId != trigger.old[i].ownerId) && trigger.new[i].ownerId != BranchUserID) || ((trigger.old[i].Branch__c == '') || (trigger.old[i].Branch__c == null))){
                ownerIds.add(trigger.new[i].OwnerId);
                tasksToUpdate.add(trigger.new[i]);
            }
            
            // for MSM 87 issue..
            if (trigger.new[i].ownerId == trigger.old[i].ownerId && trigger.new[i].ownerId != BranchUserID){
                ownerIds.add(trigger.new[i].OwnerId);
                tasksToUpdate.add(trigger.new[i]);
            }
            
            
            // 2010.08.04 - MKS
            // Added to maintain a unique 18 character Job Profile ID
            if (trigger.new[i].Job_Profile_Id__c != NULL && trigger.new[i].Job_Profile_Id__c != ''){
                if(trigger.new[i].Job_Profile_Id__c.length() == 15){
                    trigger.new[i].Job_Profile_Id__c = TaskUtility.idsTo18(trigger.new[i].Job_Profile_Id__c);       
                }
                System.debug('--Megha -debug ---'+trigger.new[i].Job_Profile_Id__c+'--'+trigger.oldMap.get(trigger.new[i].id).Job_Profile_Id__c);
                //code for mapping Job profile Name field 
                if(trigger.new[i].Job_Profile_Id__c != trigger.oldMap.get(trigger.new[i].id).Job_Profile_Id__c){
                    if(trigger.new[i].Job_Profile_Id__c.length() == 15 || trigger.new[i].Job_Profile_Id__c.length() == 18) // Added check for Job Profile custom field length by Najma Ateeq for #00051948 on 19 August 2013
                    jobProfileIdSet.add(trigger.new[i].Job_Profile_Id__c);
                    jobProfileTaskList.add(trigger.new[i]);
                }   
            }
                
        }
            
    }
    // Do we need to process any leads?
    if (tasksToUpdate.size()>0){
        updateTaskBranchCode.updateBranchCodesOnTask(ownerIds, tasksToUpdate);
    }
    if(jobProfileIdSet.size() > 0 || jobProfileTaskList.size() >0){
        TaskUtility.updateTaskJobFileName(jobProfileIdSet,jobProfileTaskList);
    }
}