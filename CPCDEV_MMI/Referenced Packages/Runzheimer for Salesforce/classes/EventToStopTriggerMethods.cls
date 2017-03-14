/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class EventToStopTriggerMethods {
    global static String errorMessage {
        get;
    }
    global static Boolean EventTriggerRunning;
    global static String recordType {
        get;
    }
    global static Boolean StopTriggerRunning;
    global EventToStopTriggerMethods() {

    }
    global static void addStops(Map<Id,Event> newMap) {

    }
    global static rzm__Stop__c applyAccountDataToStop(rzm__Stop__c stopRecord, Account accountRecord) {
        return null;
    }
    global static rzm__Stop__c applyContactDataToStop(rzm__Stop__c stopRecord, Contact contactRecord) {
        return null;
    }
    global static rzm__Stop__c applyEventDataToStop(rzm__Stop__c stopRecord, Event eventRecord) {
        return null;
    }
    global static rzm__Stop__c applyLeadDataToStop(rzm__Stop__c stopRecord, Lead leadRecord) {
        return null;
    }
    global static rzm__Stop__c applyOppDataToStop(rzm__Stop__c stopRecord, Opportunity oppRecord) {
        return null;
    }
    global static List<rzm__Itinerary__c> assignAndUpdateItineraries(List<rzm__Itinerary__c> existingItinerary, Map<Id,Event> newMap) {
        return null;
    }
    global static Map<Id,rzm__Stop__c> changeStopsToAccountParents(Map<Id,Event> events, Set<Id> accounts) {
        return null;
    }
    global static Map<Id,rzm__Stop__c> changeStopsToContactParents(Map<Id,Event> events, Set<Id> contacts) {
        return null;
    }
    global static Map<Id,rzm__Stop__c> changeStopsToLeadParents(Map<Id,Event> events, Set<Id> leads) {
        return null;
    }
    global static Map<Id,rzm__Stop__c> changeStopsToOppParents(Map<Id,Event> events, Set<Id> opps) {
        return null;
    }
    global static Map<Id,Boolean> confirmValidAccountAddress(Set<Id> accounts) {
        return null;
    }
    global static Map<Id,Boolean> confirmValidContactAddress(Set<Id> contacts) {
        return null;
    }
    global static Map<Id,Boolean> confirmValidLeadAddress(Set<Id> leads) {
        return null;
    }
    global static Map<Id,Boolean> confirmValidOppAddress(Set<Id> opps) {
        return null;
    }
    global static Boolean confirmValidRecordType(Event eventRecord) {
        return null;
    }
    global static Boolean confirmValidStopData(rzm__Stop__c stopRecord) {
        return null;
    }
    global static void createOrUpdateEventID(Map<Id,rzm__Stop__c> newMap) {

    }
    global static rzm__Stop__c createStopFromAccount(Event eventRecord, Account accountRecord, List<rzm__Itinerary__c> allItineraries) {
        return null;
    }
    global static rzm__Stop__c createStopFromContact(Event eventRecord, Contact contactRecord, List<rzm__Itinerary__c> allItineraries) {
        return null;
    }
    global static rzm__Stop__c createStopFromLead(Event eventRecord, Lead leadRecord, List<rzm__Itinerary__c> allItineraries) {
        return null;
    }
    global static rzm__Stop__c createStopFromOpp(Event eventRecord, Opportunity oppRecord, List<rzm__Itinerary__c> allItineraries) {
        return null;
    }
    global static void removeCalendarEvents(Set<Id> stopsToChangeEvents) {

    }
    global static void removePlannedStops(Set<Id> eventsToChangeStops) {

    }
    global static Map<Id,Account> retrieveAccountRecords(Set<Id> accounts) {
        return null;
    }
    global static Map<Id,Contact> retrieveContactRecords(Set<Id> contacts) {
        return null;
    }
    global static List<rzm__Itinerary__c> retrieveItinerarysFromEventOwners(Set<Id> eventOwnerIDs, Set<Date> eventOwnerDates) {
        return null;
    }
    global static Map<Id,Lead> retrieveLeadRecords(Set<Id> leads) {
        return null;
    }
    global static Map<Id,Opportunity> retrieveOppRecords(Set<Id> opps) {
        return null;
    }
    global static void updateEventsFromStopRecords(Map<Id,rzm__Stop__c> newMap) {

    }
    global static void updateStopRecordsFromEvents(Map<Id,Event> newMap, Map<Id,Event> oldMap) {

    }
    global static void updateStopsWithNewEventIDs(Map<Id,Event> newMap) {

    }
}
