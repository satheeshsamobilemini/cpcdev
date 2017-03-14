/********************************************************************************************
Name   : TestTriggerNumericPhoneUpdation
Usage  : test class for Trigger NumericphoneupdationOnAccount,  NumericphoneupdationOnLead,
         NumericphoneupdationOnContact.
Author : Kirtesh Jain
Date   : Oct 01, 2009
********************************************************************************************/

@isTest
private class TestTriggerNumericPhoneUpdation {

    static testMethod void TestTriggerNumericphoneUpdation() {
    	
    	Contact contact = new Contact();
    	contact.lastName = 'lastName';
    	contact.phone = '(123)111-1111' ;
    	insert contact ;
    	System.assertEquals([Select Numericphone__c from Contact Where ID = :contact.Id ].Numericphone__c ,'1231111111') ;
        
        contact.phone = null ;
        update contact ;
        System.assertEquals([Select Numericphone__c from Contact Where ID = :contact.Id ].Numericphone__c , null ) ;
       
        Lead lead = new Lead() ;
        lead.phone = '(111)111-4567';
        lead.lastname = 'APEX Test Lead';
        insert lead ;
        System.assertEquals([Select Numericphone__c from Lead  Where ID = :lead.Id ].Numericphone__c ,'1111114567') ;
        
        lead.phone = '(111)111-2222';
        update lead ;
        System.assertEquals([Select Numericphone__c from Lead  Where ID = :lead.Id ].Numericphone__c ,'1111112222') ;
        
        lead.phone = null ;
        update lead ;
        System.assertEquals([Select Numericphone__c from Lead  Where ID = :lead.Id ].Numericphone__c ,null) ;
        
        Account account = new Account( Name = 'Account' , Phone = '(123)111-1111');
        insert account ;
       // System.assertEquals( [Select Numericphone__c from Account Where ID =: account.Id ].Numericphone__c ,'1231111111' );
   
        account.phone = null;
        update account;
       // System.assertEquals( [Select Numericphone__c from Account Where ID =: account.Id ].Numericphone__c , null );
        
    }
}