@isTest
private class TestGleniganProjectUpdateBranchID {
	/*
	
		Test cases for: GleniganProjectUpdateBranchID.trigger
	
	*/

    static testMethod void myUnitTest() {
                
        test.startTest();
        
      	Glenigan_Project__c geniganP = New Glenigan_Project__c(Pttitle__c = 'Test', Ptpcode__c = 'YO95111');
      	insert geniganP;
      	
      	Branch_Lookup__c bl = new Branch_Lookup__c(Zip__c = 'YO951');
      	//Branch_Lookup__c bl = [Select Id, Branch_Code__c from Branch_Lookup__c where Zip__c = 'YO951'];
      	insert bl;
      	
      	system.debug('$$$$$ --> New Genigan Project: ' + geniganP);
      	
      	Glenigan_Project__c geniganPAfterInsert = [Select id, Branch_Id__c, Ptpcode__c From Glenigan_Project__c Where id = :geniganP.Id];
      	
      	system.debug('$$$$$ --> New Genigan Project (After Insert): ' + geniganPAfterInsert);
      	
      	system.assertequals(GeniganPAfterInsert.Id, geniganP.Id);
      	system.assertequals(bl.Branch_Code__c, geniganPAfterInsert.Branch_Id__c);
        
        
        geniganPAfterInsert.Ptpcode__c = 'YO95112';
        update geniganPAfterInsert;
        
        geniganPAfterInsert = [Select id, Branch_Id__c, Ptpcode__c From Glenigan_Project__c Where id = :geniganP.Id];
        system.assertequals(bl.Branch_Code__c, geniganPAfterInsert.Branch_Id__c);
        
        test.stopTest();
        
    }
}