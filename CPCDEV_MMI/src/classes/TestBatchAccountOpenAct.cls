@isTest
private class TestBatchAccountOpenAct {
    
    static testMethod void myUnitTest() {
        // TO DO: implement unit test
        List <Account> Aps = new List<Account  >();
        for(integer i = 0; i<10; i++){
            Account  a = new Account ();
            a.Name='Test'+i;
            Aps.add(a);
        }    
        insert Aps;  
        
        BatchAccountOpenAct batchObj = new BatchAccountOpenAct ();
        Database.BatchableContext bc;
        
        batchObj.start(bc);
        batchObj.execute(bc,Aps);
        batchObj.finish(bc);     
        
    }
}