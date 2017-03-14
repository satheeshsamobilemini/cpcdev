/*************************************************************************
Name   : CoachingSessionManagement 
Usage  : Managemet Class for CoachingSessionTrigger 
Author : Bharti
Date   : Sept 28, 2012
*************************************************************************/

public without sharing class CoachingSessionManagement {
    private static Map<String, Schema.RecordTypeInfo> recordTypeMap = Schema.SObjectType.Call_Mentoring_Session__c.getRecordTypeInfosByName();
    
    
    
    //creates shring records for the following use cases
    /*  
    Branch records :
    Use case 1 - BM coaches ISR - BM can see(read only) it and RM can see(read only) it.
    Use case 2 - RM coaches ISR - RM can see(read only) it but BM cannot. All the BMs and RMs (regardless of their branches or ISR’s branch) should be able to see that record. 
    Use case 3 - RM coaches for BM - No other BM can see that record but RM who created and BM for whom it is created - only those two will be able to see it.  
    Use case 4 - RM coaches for BO - No other BO can see that record but RM who created, BO for whom it is created and BM of that particular BO - only those three will be able to see it.  
    Use Case 5 – RM coaches TSM - RM can see(read only) it but BM cannot. All the BMs and RMs (regardless of their branches or TSM’s branch) should be able to see that record.
    
    NSC records :
    Use Case 1 - NSC manager coaches NSC rep, all BMs and all RMs should see it (read only)
    */
    public static void updateVisibilities(List<Call_Mentoring_Session__c> coachingSessions){
            Set<Id> branchRecordTypeIds = new Set<Id>{recordTypeMap.get('Branch Coaching Session').getRecordTypeId(),recordTypeMap.get('Personal Coaching Session').getRecordTypeId()};
            // Set<Id> NSCRecordTypeIds = new Set<Id>{recordTypeMap.get('NSC Coaching Session').getRecordTypeId()};    TFS 5310..
            
            Set<Id> userIds = new Set<Id>();
            for(Call_Mentoring_Session__c cms : coachingSessions){
                // if(branchRecordTypeIds.contains(cms.RecordTypeId) || NSCRecordTypeIds.contains(cms.RecordTypeId)){ TFS 5310..
                if(branchRecordTypeIds.contains(cms.RecordTypeId)){
                    if(cms.Rep_Name__c != null || cms.Sales_Rep__c != null)
                        userIds.add(cms.Rep_Name__c != null? cms.Rep_Name__c : cms.Sales_Rep__c);                   
                    userIds.add(cms.OwnerId);
                }
            }
            Map<Id, User> mapReps = new Map<Id, User>([Select Id, UserRole.Name, ManagerId ,UserRoleId, Branch__c, Branch_Id__c 
                                                                                             From User Where Id IN : userIds]);
                                                                                             
            Group bscPublicGroup = [Select Name, Id From Group where Name = : 'BranchCoachingSessionShared'];
            
            List<Call_Mentoring_Session__Share> csSharelstToInsert = new List<Call_Mentoring_Session__Share>();
            
            for(Call_Mentoring_Session__c cms : coachingSessions){
                Id repName;
                if(cms.Rep_Name__c != null || cms.Sales_Rep__c != null)
                        repName = cms.Rep_Name__c != null? cms.Rep_Name__c : cms.Sales_Rep__c;
                //for branch coaching sessions
                if(branchRecordTypeIds.contains(cms.RecordTypeId) && mapReps.containsKey(cms.OwnerId) && mapReps.containsKey(repName)){
                    if(mapReps.get(cms.OwnerId).UserRole.Name.contains('Regional Manager')){
                        if(mapReps.get(repName).UserRole.Name.contains('Sales Rep') || mapReps.get(repName).UserRole.Name.contains('Territory Sales Mgr')){
                            csSharelstToInsert.add(createShareRecord(cms.Id, bscPublicGroup.Id));
                        }else if(mapReps.get(repName).UserRole.Name.contains('Branch Operations') || mapReps.get(repName).UserRole.Name.contains('Branch Manager')){
                            
                            csSharelstToInsert.add(createShareRecord(cms.Id, mapReps.get(repName).Id));
                        }
                    }
                }//for NSC coaching sessions   --- now for TFS 5310 --- 
                /* else if(NSCRecordTypeIds.contains(cms.RecordTypeId) && mapReps.containsKey(cms.OwnerId) && mapReps.containsKey(repName)){
                    if(mapReps.get(cms.OwnerId).UserRole.Name.contains('Business Development Team Manager')){
                        if(mapReps.get(repName).UserRole.Name.contains('Business Development Specialist')){
                            csSharelstToInsert.add(createShareRecord(cms.Id, bscPublicGroup.Id));
                        }
                    }
                } */
            }
            
            system.debug('---- csSharelstToInsert ---- ' + csSharelstToInsert);
            //insert Call_Mentoring_Session__Share records
            insert csSharelstToInsert;
    }
    
    //creates sharing records
    private static Call_Mentoring_Session__Share createShareRecord(Id coachingSessionId, Id managerId){
        Call_Mentoring_Session__Share sharingRecord = new Call_Mentoring_Session__Share();
        sharingRecord.ParentId = coachingSessionId;
        sharingRecord.AccessLevel = 'Read';
        //sharingRecord.RowCause = 'Manual Sharing(default)';
        sharingRecord.UserOrGroupId = managerId;
        return sharingRecord;
    }
}