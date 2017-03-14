@isTest
private Class VehicleRegistrationTrackingExtensionTest{
    @isTest static void testVehicleRegTrackExt(){
        Vehicle_Registration_Tracking__c VRT = new Vehicle_Registration_Tracking__c();
        VRT.Name = 'Test Reg';
        VRT.Usage__c = 'Primary';
        VRT.Branch_ID__c = '1100';
        VRT.Equipment__c = 'test';
        VRT.VIN__c = 'test VIN';
        VRT.Operating_Status__c = 'Up';
        VRT.Type_of_Registration__c = 'yearly';
        VRT.Type__c = 'Loader';
        VRT.Hour_or_Mileage_Reading__c = 'test hour';
        VRT.Make__c = 'test make';
        VRT.Model__c = '2010';
        VRT.Year__c = '2012';
        insert VRT;
        list<Vehicle_Registration_Tracking__c> vrtList = new list<Vehicle_Registration_Tracking__c>();
        vrtList.add(VRT);
        VehicleRegistrationTrackingExtension VRTE = new VehicleRegistrationTrackingExtension();
        VRTE.doSort();
        VRTE.getVchlRegTrac();
        Map<Id, Vehicle_Registration_Tracking__c> mapVR = new Map<Id, Vehicle_Registration_Tracking__c>(vrtList);
        VRTE.saveRec();
        system.assertEquals(true, mapVR.containsKey(VRT.Id));
        
    }
}