@isTest
private class TestUpdateZipAndBranchIdBatch{
    @isTest static void UpdateZipAndBranchIdBatchTest(){
        Test.StartTest();
        
        Dodge_Project__c Dp = new Dodge_Project__c();
        Dp.Project_Name__c = 'Test2';
        Dp.Removed_By__c = UserInfo.getUserId();
        Dp.City__c = 'Oaks';
        Dp.State__c = 'PA';
        Dp.County__c = 'UK';
        Dp.zip__c = '19456';
        Insert Dp;
        
        Dodge_Project__c Dp2 = new Dodge_Project__c();
        Dp2.Project_Name__c = 'Test2';
        Dp2.Removed_By__c = UserInfo.getUserId();
        Dp2.City__c = 'Oaks';
        Dp2.State__c = 'PA';
        Dp2.County__c = 'UKcounty';
        Dp2.zip__c = '19456';
        Insert Dp2;
        
        Dodge_Project__c Dp3 = new Dodge_Project__c();
        Dp3.Project_Name__c = 'Test2';
        Dp3.Removed_By__c = UserInfo.getUserId();
        Dp3.City__c = 'Oaks';
        Dp3.State__c = 'PA';
        Dp3.County__c = 'parish';
        Dp3.zip__c = '19456';
        Insert Dp3;
        
        Dodge_Project__c Dp4 = new Dodge_Project__c();
        Dp4.Project_Name__c = 'Test2';
        Dp4.Removed_By__c = UserInfo.getUserId();
        Dp4.City__c = 'Oaks';
        Dp4.State__c = 'PA';
        Dp4.County__c = 'USA';
        Dp4.zip__c = '19456';
        Insert Dp4;
        
        Branch_Lookup__c Bl = new Branch_Lookup__c();
        Bl.Zip__c = '19456';
        Bl.City__c = 'Oaks';
        Bl.State__c = 'PA';
        Bl.County__c = 'USA';
        Bl.Branch_Code__c = '44';
        insert Bl;
        
        UpdateZipAndBranchIdBatch UZABI = new UpdateZipAndBranchIdBatch();
        List<Dodge_Project__c> dodgeProjects = new List<Dodge_Project__c>();
        dodgeProjects = [select id, Zip__c,Branch_ID__c, state__c,county__c,city__c from Dodge_Project__c where (Zip__c = '' or Branch_ID__c = '') and  LastModifiedDate >= YESTERDAY];
        Database.executebatch(UZABI,50);
        Database.BatchableContext info;
        
        Set<String> countySet = new Set<String>();
        string countyB = (Bl.County__c).toLowerCase();
        countySet.add(countyB);
        
        
        UZABI.execute(info,dodgeProjects);
        UZABI.finish(info);
        Test.stopTest();
    }
}