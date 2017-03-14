/**
* (c) 2015 TEKsystems Global Services
*
* Name           : TestCollectorNotesCntrl
* Created Date   : 14 Sept, 2016
* Created By     : Ankur Goyal
* Purpose        : Test class for CollectorNotesCntrl controller.
* 
**/

@isTest
public class TestCollectorNotesCntrl{
    static testmethod void testcollectorctrl() {
        
        Account acc = new Account();
        acc.name='test account';
        acc.Revenue_Q1__c=100.00;
        acc.Revenue_Q2__c=200.00;
        acc.Revenue_Q3__c=100.00;
        acc.Revenue_Q4__c=222.00;
        acc.Revenue_Q5__c=565.00;
        acc.Revenue_Q6__c=5656.00;
        acc.Revenue_Q7__c=56.00;
        acc.Revenue_QC__c=566.00;
        acc.BillingState = 'AZ';
        acc.BillingCountry = 'US';
        acc.recordtypeid =  [select id,name from RecordType where name = 'Business Account - UK'].ID;
        insert acc;
        
        ApexPages.currentPage().getParameters().put('salesOrg','1000');
        ApexPages.currentPage().getParameters().put('sapBillTo','0000800015');
        ApexPages.currentPage().getParameters().put('sinceDate','20110101');
        ApexPages.currentPage().getParameters().put('recType','Business Account');
        
        CollectorNotesCntrl colCntrl = new CollectorNotesCntrl();
        
        CollectorNotesCntrl.WrapperCollectorNotes colNotesWrapper= new CollectorNotesCntrl.WrapperCollectorNotes('CCT_GUID','0000800015','1000','CCT_ID','COLL_SPECIALIST',
                            'COLL_SPECIALIST_NAME','CONTACT_KEY','CCT_NAME','CCT_EMAIL','CCT_PHONE','CCT_FAX','CCT_FAXC','DIR',
                            'TYP','CCT_TYPE_TEXT','RES','CCT_RESULT_TXT','20110101000000','12','CREATED_BY','CREATED_BY_NAME',
                            '20110101000000','CHANGED_BY','CHANGED_BY_NAME','20110101000000','5',null,'recType');
        
        CollectorNotesCntrl.WrapperCollectorNotesItems colNotesItemWrapper = new CollectorNotesCntrl.WrapperCollectorNotesItems('CCT_GUID','FORMAT_COL','TEXT_LINE');
        doCallOut(); 
    }
    
     private static void doCallOut( ){
        date dt=date.today();
        date stdt = dt.addMonths(-12);
        string CON_ST_DAT=String.valueOf(dt);
        string CON_EN_DAT=String.valueOf(stdt);
        Test.setMock(WebServiceMock.class, new WebServiceMockImplCollNotes());
        List<CollectorNotesCntrl.WrapperCollectorNotes> notesList = DataForcontracts.getCollectorNotesData('0000800015','1000','20110101000000','Business Account - UK'); 
    }
    
}