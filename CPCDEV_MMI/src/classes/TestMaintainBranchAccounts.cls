/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class TestMaintainBranchAccounts {

    static testMethod void myUnitTest() {
        // TO DO: implement unit test
                
         // Single Account   
        String BranchUserID = '';   
        User branchAccountUserID = [Select Id from User where name = 'Branch Account' Limit 1];
        BranchUserID = branchAccountUserID.Id;

        String SalesUserID = '';    
        User MarkUserID = new User(Id = UserInfo.getUserId());//[Select Id from User where name = 'Mark Schultz' Limit 1];
        SalesUserID = MarkUserID.Id;

        String SalesUserID2 = '';   
        User PaulUserID = [Select Id from User where name = 'Paul Widner' Limit 1];
        SalesUserID2 = PaulUserID.Id;
 
    
        System.RunAs(PaulUserID){
    
            Account newAccount = New Account(Name='Test Account', Branch__c='101',BillingCountry ='USA', ownerid=SalesUserID2);
    
            insert newAccount;
            
            newAccount.ownerid = SalesUserID2;
            
            update newAccount;
            
            newAccount.Branch__c = '102';            
            update newAccount;            
            newAccount.ownerid = SalesUserID;            
            update newAccount;    
            delete newAccount;
            
            Account newAccount2 = New Account(Name='Test Account 2', Branch__c='102',BillingCountry ='USA', ownerid=BranchUserID);
            insert newAccount2;
          
            newAccount2.ownerid = BranchUserID;
            Opportunity opp = new Opportunity(AccountId=newAccount2.Id,Name=newAccount2.Name,CloseDate=System.today().addDays(10), 
                               StageName='Quoted - No Decision', Opportunity_Rating__c='Warm (Possibly Order)',Billing_Street__c=newAccount2.BillingStreet,
                               Billing_City__c=newAccount.BillingCity,Billing_State_Province__c=newAccount.BillingState,Billing_Zip_Postal_Code__c=newAccount.BillingPostalCode, 
                               Billing_Country__c=newAccount2.BillingCountry, Delivery_Street__c=newAccount2.BillingStreet,Delivery_City__c=newAccount2.BillingCity, 
                               Delivery_State_Province__c=newAccount2.BillingState,Delivery_Zip_Postal_Code__c=newAccount2.BillingPostalCode,
                               Delivery_Country__c=newAccount2.BillingCountry);
            insert opp;
            
            newAccount2.Branch__c = '105';
            newAccount2.BillingStreet = 'Street Park';
            newAccount2.BillingCity = 'Phoenix';
            newAccount2.BillingCountry = 'USA';
            newAccount2.BillingPostalCode = '6544132';
            newAccount2.BillingState = 'AZ';
            
            update newAccount2;
            
       }
      
      Test.startTest();  
        //Batch Accounts
        List<Account> batchAccounts = New List<Account>();
        
        for(integer i=0;i<10;i++){
            batchAccounts.add(New Account(Name='Test Account', BillingCountry ='USA', Branch__c='101', ownerid=SalesUserID2));

        }
        insert batchAccounts;
        for(integer i=0;i<batchAccounts.size();i++){
            system.assertequals(batchAccounts[i].Branch__c, '101');
            batchAccounts[i].ownerid = BranchUserID;
        }
        update batchAccounts;
        for(integer i=0;i<batchAccounts.size();i++){
            batchAccounts[i].ownerid = SalesUserID;
        }
        update batchAccounts;
        delete batchAccounts;    
        
        // Account Trigger - populateOSRTopPotential and TFS 3872
        RecordType aRec = [select Id from RecordType where SObjectType = 'Account' and Name = 'ETS/WMI' LIMIT 1];
        Account acc = new Account(Name='New Account',BillingCountry ='USA',Branch__c='105',ownerid=BranchUserID,RecordTypeId = String.valueOf(aRec.Id));
        acc.Branch_Account_Approval_Status__c = 'Submitted';
        insert acc;
        
        Account acc2 = new Account(Name='New Account2', BillingCountry ='USA', Branch__c='106', ownerid=SalesUserID2,RecordTypeId = String.valueOf(aRec.Id));
        acc2.Branch_Account_Approval_Status__c = 'Submitted';
        insert acc2;
        
        Contact c = new Contact(LastName = 'newContact', ownerid =BranchUserID, AccountId = acc.Id);
        insert c;
        
        String fieldvalue = 'Account_' + String.valueOf(aRec.Id);
        ETSnWMIrectype__c ets = new ETSnWMIrectype__c(Name = 'Account RecType', ObjRecType__c = fieldvalue);
        insert ets;
        
        acc.TSM_Top_Potential_ID__c = string.valueOf(branchAccountUserID.Id);
        acc.Branch_Account_Approval_Status__c = 'Approved';
        acc.ApprovalRequester_ETS__c = PaulUserID.Id;
        update acc;
        
        acc2.Branch_Account_Approval_Status__c = 'Approved';
        update acc2;
        
        // TFS 4275
        ETS_WMI_ProfileNames__c etsprofiles = new ETS_WMI_ProfileNames__c(Name = 'ETS profile',ProfileList__c = 'Sales Manager - ETS'); 
        insert etsprofiles;
                
        ApexPages.StandardController con = new ApexPages.StandardController(acc);
        AccountNewButtonProfiles accnewbttn = new AccountNewButtonProfiles(con);
       
       Test.stopTest(); 
    }
}