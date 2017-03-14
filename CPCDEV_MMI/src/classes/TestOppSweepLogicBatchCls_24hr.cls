@isTest
private class TestOppSweepLogicBatchCls_24hr{
    static testmethod void test24HrOppSweepProcess(){
        Test.startTest();
        
        Account acc = New Account();
        acc.Name='Test Account';
        //acc.ownerid=salesRep1.Id;
        insert acc;
        
        Opportunity Opp = New Opportunity();
        Opp.Name = 'Test APEX Opportunity'; 
        Opp.AccountID = acc.Id;
        Opp.StageName = 'Quoted - No Decision'; 
        Opp.CloseDate = Date.newInstance(2009,07,30);
        insert Opp;
        
        list<Opportunity> lstoppty = new list<Opportunity>();
        lstoppty.add(Opp);
        OpportunitySweepLogicBatchableClass_24hr optySweep24hr = new OpportunitySweepLogicBatchableClass_24hr(null, DateTime.now().addDays(2));
        Database.batchableContext bc;
        optySweep24hr.execute(bc,lstoppty);
        Database.executeBatch(optySweep24hr, 10);
        Test.stopTest();
    }
}