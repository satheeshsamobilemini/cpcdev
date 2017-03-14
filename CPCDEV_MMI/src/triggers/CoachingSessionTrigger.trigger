/*************************************************************************
Name   : CoachingSessionTrigger
sage  : Test class to test CoachingSessionTrigger apex trigger.
Author : Bharti
Date   : Sept 28, 2012
*************************************************************************/

trigger CoachingSessionTrigger on Call_Mentoring_Session__c (after insert) {
    
    if(Trigger.isAfter && Trigger.isInsert){
        CoachingSessionManagement.updateVisibilities(Trigger.new);  
    }
}