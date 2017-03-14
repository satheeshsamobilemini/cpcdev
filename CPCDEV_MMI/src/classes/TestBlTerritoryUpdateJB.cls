@isTest
public class TestBlTerritoryUpdateJB{
  static testmethod void testCheck1(){
    Branch_LookUp__c bl = new Branch_LookUp__c(zip__c = '112321',Branch_Code__c = '117',Territory__c = '117-01');
    bl.Plant_Code__c = '1117';
    bl.Rollup_Plant__c='1117';
    insert bl;  
  
    bl.Rollup_Plant__c = '1118';
    update bl;
 } 
}