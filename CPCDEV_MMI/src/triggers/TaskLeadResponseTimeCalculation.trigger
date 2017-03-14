/************************************************************************************************************
* Name          : TaskLeadResponseTimeCalculation                                                           *
* Created By    : Cloud Challenger                                                                          *
* Created Date  : 28th Nov 2012                                                                             *
* Related Case  : 00035523 
* Description   : This trigger populated the first activity date time and Lead Response Time                                *
                                    whenever the task of Call Type is Completed and first activity is null                    *
************************************************************************************************************/

trigger TaskLeadResponseTimeCalculation on Task (after insert, after update) {
    
   if(TriggerSwitch.isTriggerExecutionFlagDisabled('Task','TaskLeadResponseTimeCalculation')){return;  }
         
    if(RecursiveTriggerUtility.isTaskLeadResponseTimeCalculation == false){
    if(Trigger.isInsert){
        ActivityManagement.setLeadFields(Trigger.new, null, true);
        ActivityManagement.setAccountField(Trigger.new,null,true);      // TFS 4849
    }else if(Trigger.isUpdate){
        ActivityManagement.setLeadFields(Trigger.new, Trigger.oldMap, false);
        ActivityManagement.setAccountField(Trigger.new,Trigger.oldMap,false);     // TFS 4849 
    } 
        RecursiveTriggerUtility.isTaskLeadResponseTimeCalculation = true;
    }       
}