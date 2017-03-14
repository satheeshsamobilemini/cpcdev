@isTest
private class QqFromJpControllerTest{
    @isTest static void QqFromJpController(){
    
        Job_Profile__c Jp = new Job_Profile__c();
        Jp.Name = 'Test job';
        Jp.Branch_ID__c = '101';
        Jp.Job_Site_Zip__c = '560037';
        Jp.Job_Site_Country__c = 'INDIA';
        insert Jp;
        
        Account acc = New Account();
        acc.Name='Test Account';
        insert acc;
        
        Sub_Contractor__c sc = new Sub_Contractor__c();
        sc.Account__c = acc.Id;
        sc.Job_Profile__c = Jp.Id;
        sc.Role__c = 'Painting';
        insert sc;
        
        Apexpages.currentPage().getParameters().put('id',Jp.Id);
        QqFromJpController QFJC = new QqFromJpController();
        QFJC.selectedSc = '';
        QFJC.next();
        QFJC.selectedSc = sc.Id;
        QFJC.Operation = 'qq';
        QFJC.next();
        QFJC.Operation = 'fq';
        QFJC.next();
        QFJC.findContacts();
        
    }
}