@isTest
public class TestABIManagementController{
    static testmethod void testaccountctrl() {
        
        ABI_Project__c objABIProject = new ABI_Project__c();
           objABIProject.ptTitle__c = 'test Project';
           objABIProject.Ptno__c = 15289;
           objABIProject.Stage__c = 'Tentative';
           objABIProject.Devtype__c = 'New Build';
           //objABIProject.Pttitle__c = 'test title';
           //objABIProject.ptTitle__c = 'test title';
           objABIProject.Ptsite1__c = 'testproject';
           objABIProject.Ptsite2__c = 'testproject';
           objABIProject.Ptsite3__c = 'testproject';
           objABIProject.Ptsite4__c = 'testproject';
           objABIProject.Ptpcode__c = 'Code';
           objABIProject.Stage__c  = 'Tentative';
           objABIProject.Value__c  = 1258;
        Insert objABIProject;  
        List<ABI_Project__c>  abiProjectslst = new List<ABI_Project__c>();
        abiProjectslst.add(objABIProject);
        
        User usr = [select id,Branch_Id__c from User where Branch__c Like '7%' limit 1];
        system.debug('usr======>>>>>>>>'+usr);
        ApexPages.StandardController sc = new ApexPages.StandardController(objABIProject);
        ApexPages.currentPage().getParameters().put('selectedBranch','test');
        ABIManagementController  ABIM = new ABIManagementController();
        
        ABIM.getHeaderChars();
        ABIM.loadBranches();
        ABIM.doSearch();
        ABIM.sortOn = objABIProject.Pttitle__c;
        ABIM.sortOrder = 'ASC';
        ABIM.doSortedSearch();
        ABIM.sortOn = objABIProject.Pttitle__c;
        ABIM.sortOrder = 'DESC';
        ABIM.doSortedSearch();
        ABIM.selectedChar = 'Test';
        ABIM.doHeaderSearch();
        ABIM.selectedChar = 'Other';
        ABIM.doHeaderSearch();
        ABIM.abiProjects = abiProjectslst;
        system.debug('abiProjectslst===========>>>>>>>>>'+abiProjectslst);
        //pageReference prf = ABIM.openCreateLinkURL(); 
        
        ApexPages.currentPage().getParameters().put('selectedBranch','null');
        ApexPages.currentPage().getParameters().put('selectedBranch','');
        ABIManagementController  ABIM2 = new ABIManagementController();
        ABIM2.currentABIProjId = objABIProject.Id;
        ABIM2.abiProjects = abiProjectslst;
        ABIM2.abiStdSetCntrl = null;
        //PageReference openCreateLinkURL = ABIM2.openCreateLinkURL();
        
        
    }
}