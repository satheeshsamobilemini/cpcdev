/**
 * Test Class for SetJobProfileURLOnDodge
 */
@isTest
private class TestSetJobProfileURLOnDodge {

    static testMethod void testJobProfileURL() {
        List<Dodge_Project__c> dodgeProjects = makeDodgeData(1);
        Job_Profile__c jp = New Job_Profile__c(Name = 'test Job profile'+DateTime.now(), Job_Site_Zip__c = '90210-4444', Job_Site_Country__c = 'USA');
        insert jp;
        List<Dodge_Project__c> resultDodgeProjects = [select Id, Job_Profile_URL__c from Dodge_Project__c where id = : dodgeProjects.get(0).id ];
        
    }
    
    static testMethod void testJobProfileURLUpdate() {
        List<Dodge_Project__c> dodgeProjects = makeDodgeData(2);
        Job_Profile__c jp = New Job_Profile__c(Name = 'test Job profile'+DateTime.now(), Job_Site_Zip__c = '90210-4444', Job_Site_Country__c = 'USA');
        insert jp;
        List<Dodge_Project__c> resultDodgeProjects = [select Id, Job_Profile_URL__c from Dodge_Project__c where id = : dodgeProjects.get(0).id ];
        
        jp.Dodge_Project__c = dodgeProjects.get(1).id;
        update jp;
        
        resultDodgeProjects = [select Id, Job_Profile_URL__c from Dodge_Project__c where id = : dodgeProjects.get(1).id ];
        
        resultDodgeProjects = [select Id, Job_Profile_URL__c from Dodge_Project__c where id = : dodgeProjects.get(0).id ];
       
    }
    
    /*LSLEVIN 9.23.2013 Case 53015 START*/
    static testMethod void testJobProfileURLUpdateNull() {
    	List<Dodge_Project__c> dodgeProjects = makeDodgeData(2);
    	Job_Profile__c jp = New Job_Profile__c(Name = 'test Job profile'+DateTime.now(), Job_Site_Zip__c = '90210-4444', Job_Site_Country__c = 'USA');
        insert jp;
        
         List<Dodge_Project__c> resultDodgeProjects = [select Id, Job_Profile_URL__c from Dodge_Project__c where id = : dodgeProjects.get(0).id ];
        
        jp.Dodge_Project__c = dodgeProjects.get(0).id;
        update jp;
        
       	resultDodgeProjects = [select Id, Job_Profile_URL__c from Dodge_Project__c where id = : dodgeProjects.get(0).id ];
        if(resultDodgeProjects.size() > 0){
        	System.assertEquals(resultDodgeProjects.get(0).Job_Profile_URL__c, System.Label.Organization_URL + jp.id);
        }      
    }
    /*LSLEVIN 9.23.2013 Case 53015 END*/
    
    private static List<Dodge_Project__c> makeDodgeData(Integer size){
         List<Dodge_Project__c> lstDodge = new List<Dodge_Project__c>();
        for(integer count = 1; count <= size; count++) {
            Dodge_Project__c d = new Dodge_Project__c(Project_Name__c='Test' + count, Branch_ID__c='999');
            lstDodge.add(d);
        }
        insert lstDodge;
        return lstDodge;
    }   
       
}