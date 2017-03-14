@isTest
private class TESTVehicleReg_UpdateBranchMGR {

    static testMethod void myUnitTest() {

		Date expDate = Date.Newinstance(2025, 01, 01);
		
		Vehicle_Registration_Tracking__c truck01 = New Vehicle_Registration_Tracking__c (Name = '12345xxxx', Branch_Manager__c = null, usage__c = 'Primary', Branch_ID__c = '101', Equipment__c = '12345xxxx', Operating_Status__c = 'Up', Hour_or_Mileage_Reading__c = '12345', Type_of_Registration__c = 'Yearly', Expiration_Date__c = expDate, VIN__c = '12345xxxxx', Year__c = '2010', Type__c = 'Truck (Tilt Bed)', Description__c = '20\' - 21\' (Bed Length)', Equipment_Options__c = 'Automatic');
		
		insert truck01;
		
		update truck01;
		
		system.debug('Branch Manager = ' + truck01.Branch_Manager__c);
		
		Vehicle_Registration_Tracking__c truck02 = [Select ID, Branch_Manager__c from Vehicle_Registration_Tracking__c where ID = :truck01.id];
		
		system.assertequals(truck01.Branch_Manager__c, truck02.Branch_Manager__c);
		
		truck01.branch_id__c = '102';
		
		update truck01;
		
		Vehicle_Registration_Tracking__c truck03 = [Select ID, Branch_Manager__c from Vehicle_Registration_Tracking__c where ID = :truck01.id];
		
		//system.assertnotequals(truck02.Branch_Manager__c, truck03.Branch_Manager__c);
		
		delete truck01;	

    }
}