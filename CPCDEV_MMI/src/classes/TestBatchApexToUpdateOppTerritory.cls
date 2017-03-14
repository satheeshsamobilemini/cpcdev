@isTest
public class TestBatchApexToUpdateOppTerritory {
    static testMethod void Test1(){
        Database.BatchableContext BC;
        List<sObject> scope =  new List<sObject>();
        BatchApexToUpdateOppTerritory  BAUT = new BatchApexToUpdateOppTerritory();
        BAUT.execute(BC,scope);
        Database.executeBatch(BAUT);
    }
}