/******************************************************************************* 
Class                   :   TestGleniganManagementController
Related Class           :   GleniganManagementController
Created By              :   Bharti Mehta(Appirio Offshore)
Created On              :   Nov 12, 2012
Description             :   Test Class for GleniganManagementController. 
********************************************************************************/ 
@isTest
private class TestGleniganManagementController {

	@isTest
    public static void testContoller() {
    try{
    	makeData();
			GleniganManagementController controller = new GleniganManagementController();
			//test View button functionality
			controller.selectedbranch = '754';
			controller.doSearch();
			
			//test column sorting functioanlity
			controller.sortOn = 'Pttitle__c';
			controller.sortOrder = 'ASC';
			controller.doSortedSearch();
			
			//test Create button functionality
			controller.currentGleniganProjId = controller.gleniganProjects.get(0).Id;
			controller.openCreateLinkURL();
			
			//test Header charactor functionality
			controller.getHeaderChars();
			controller.selectedChar = 'T';
			controller.doHeaderSearch(); 
			System.AssertEquals(controller.GleniganStdSetCntrl.getResultSize(),20);
			controller.selectedChar = 'Other';
			controller.doHeaderSearch(); 
			System.AssertEquals(controller.GleniganStdSetCntrl.getResultSize(),1);
				        
        } catch (Exception ex) {
        	System.debug('Exception in test class ' + ex);
        }
    }
    
    private static void makeData(){
    	List<Glenigan_Project__c> gleniganProjects = new List<Glenigan_Project__c>();
    	
    	for(integer count = 1; count <= 20 ; count++) {
    		Glenigan_Project__c gleniganProj = new Glenigan_Project__c(pttitle__c='Test Glenigan Project ' + count, Branch_ID__c='754');
    		gleniganProjects.add(gleniganProj); 
    	}
    	Glenigan_Project__c gleniganProj1 = new Glenigan_Project__c(pttitle__c='(Test Glenigan Project )', Branch_ID__c='754');
    	gleniganProjects.add(gleniganProj1);
    	insert gleniganProjects;
    	System.debug('--test size---'+gleniganProjects+'--'+gleniganProjects.size());
    }
}