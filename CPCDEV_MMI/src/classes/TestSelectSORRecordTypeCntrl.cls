/**
* (c) 2015 TEKsystems Global Services
*
* Name           : TestSelectSORRecordTypeCntrl
* Created Date   : 6 Nov, 2015 
* Created By     : Nagalakshmi
* Purpose        : Test class for SelectSORRecordTypeCntrl class.
* 
**/
@isTest
private class TestSelectSORRecordTypeCntrl{

static testMethod void Test1()
{
    Account a = new Account(name = 'test');
    insert a;
    Test.setCurrentPageReference(new PageReference('Page.NavBack')); 
    System.currentPageReference().getParameters().put('id', a.id);
    System.currentPageReference().getParameters().put('name', a.name);
    Test.StartTest();
    SelectSORRecordTypeCntrl cont = new SelectSORRecordTypeCntrl();
    cont.getItems();
    cont.navigate();
    cont.NavBack();
    System.assertNotEquals(cont.getrecordTypes(),null);
    cont.setrecordTypes(null);
    System.assertEquals(cont.getrecordTypes(),null);
    Test.StopTest();    
}


}