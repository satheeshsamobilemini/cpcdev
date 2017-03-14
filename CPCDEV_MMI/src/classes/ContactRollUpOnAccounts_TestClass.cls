@isTest

private class ContactRollUpOnAccounts_TestClass{

    public static testMethod void validateContactRollUpOnAccounts() {

        //Create Account
        Account ac = new Account(
            Name='Test Account',
            Type='Customer - Branch Business Account'
            );
        insert ac;

        //Create Account 2
        Account ac2 = new Account(
            Name='Test Account 2',
            Type='Customer - Branch Business Account'
            );
        insert ac2;

        //Create Contact 1
        Contact ct1 = new Contact(
                LastName='Test Contact 1',
                Email='testcontact1@email.com',
                AccountID= ac.ID
                );
        insert ct1;

        // Verify
        ac = [SELECT ID, Contact_Count__c FROM Account WHERE ID = :ac.id];
        System.assertEquals(1,ac.Contact_Count__c);

        //Create Contact 2
        Contact ct2 = new Contact(
                LastName='Test Contact 2',
                Email='testcontact2@email.com',
                AccountID= ac.ID
                );
        insert ct2;

        // Verify
        ac = [SELECT ID, Contact_Count__c FROM Account WHERE ID = :ac.id];
        System.assertEquals(2,ac.Contact_Count__c);

        //Delete Contact 1
        delete ct1;

        // Verify
        ac = [SELECT ID, Contact_Count__c FROM Account WHERE ID = :ac.id];
        System.assertEquals(1,ac.Contact_Count__c);

        //Remove Contact 2
        ct2.AccountID = ac2.ID;
        update ct2;

        // Verify
        ac = [SELECT ID, Contact_Count__c FROM Account WHERE ID = :ac.id];
        System.assertEquals(null,ac.Contact_Count__c);
        ac2 = [SELECT ID, Contact_Count__c FROM Account WHERE ID = :ac2.id];
        System.assertEquals(1,ac2.Contact_Count__c);


        //Attach Contact 2
        ct2.AccountID = ac.ID;
        update ct2;

        // Verify
        ac = [SELECT ID, Contact_Count__c FROM Account WHERE ID = :ac.id];
        System.assertEquals(1,ac.Contact_Count__c);
        ac2 = [SELECT ID, Contact_Count__c FROM Account WHERE ID = :ac2.id];
        System.assertEquals(null,ac2.Contact_Count__c);
    }
}