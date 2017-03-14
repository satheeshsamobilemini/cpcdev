/**
Created by Najma on 5/17/2013
To cover CampaignCustomRollups
 */
@isTest
private class CampaignCustomRollups_Test {

    static testMethod void myUnitTest() {
    	List<Id> lstId = new List<Id>();
        Campaign camp = new Campaign();
        camp.Name = 'Test';
        insert camp;
        Campaign childCamp = new Campaign();
        childCamp.Name = 'Test1';
        childCamp.ParentId = camp.id;
        insert childCamp;
        lstId.add(camp.id);
        lstId.add(childCamp.id);
        CampaignCustomRollups.initCampaignRollupHierarchy(lstId);
    }
}