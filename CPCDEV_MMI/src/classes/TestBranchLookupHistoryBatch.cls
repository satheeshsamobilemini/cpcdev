@isTest
public class TestBranchLookupHistoryBatch {
    static testMethod void lookupHistoryTest(){
      List<Branch_Lookup__c> brLukUpList = new List<Branch_Lookup__c>();
        Integer testZip =100;
        //String testTerritory = 
        for(integer i=0;i<100;i++){
            Branch_Lookup__c blkUpVar = new Branch_Lookup__c();
            
            blkUpVar.Zip__c = '0'+Testzip;
            Testzip++;
            blkUpVar.Territory__c = '0199-09';
            
            brLukUpList.add(blkUpVar);
        }  
        Test.startTest();
        	insert brLukUpList;
        	BranchLookupHistoryBatch bLukUpHstrybtchVar = new BranchLookupHistoryBatch();
        	Database.executeBatch(bLukUpHstrybtchVar, 2000);
            
        Test.stopTest();
        
    }
}