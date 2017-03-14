@isTest
Class TestNextTaskInfoLead {
    static testmethod void unittest1(){
        Account acc = new Account();
        acc.name='test account';
        acc.recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Business Account').getRecordTypeId();
        acc.BillingState = 'AZ';
        acc.BillingCountry = 'US';
        insert acc;
        
        Lead ld  = new Lead();
        ld.LastName = 'test';
        ld.Phone = '5133145134';
        insert ld;
        
        Contact con = new Contact(LastName='Test');
        con.FirstName = 'Test';
        con.Email = 'abc@abc.com';
        con.AccountId = acc.id;
        con.Phone = '5133145134';
        insert con;
        
        Campaign cmp = new Campaign();
        cmp.Name = 'Meeting';
        insert cmp;
        
        Test.startTest();
            List<Task> taskinsertList = new List<Task>();
            Task t1 = new Task(Status = 'In Progress',WhoId = ld.Id, Who_Id_Phone__c = '5133145134');
        	Task t2 = new Task(Status = 'Completed',WhoId = ld.Id);
            Task t3 = new Task(Status = 'In Progress',WhoId = con.Id, Who_Id_Phone__c = '5133145134');
        	Task t4 = new Task(Status = 'In Progress',WhatId = acc.Id);
        	Task t5 = new Task(Status = 'In Progress',WhatId = cmp.Id);
            taskinsertList.add(t1);
            taskinsertList.add(t2);
        	taskinsertList.add(t3);
        	taskinsertList.add(t4);
        	taskinsertList.add(t5);
            insert taskinsertList;
            t1.Status = 'Completed';
            update ld;
        	update t1;
        Test.stopTest();
    }    
}