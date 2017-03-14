/**************************************************************
Name : TestBatchUpdateOppsNextSchActivityDate 
Created By : Reena Acharya
Created Date : 6th Sept, 2013
Description : Test Coverage of BatchUpdateOppsNextSchActivityDate 
**************************************************************/

@isTest
private class TestBatchUpdateOppsNextSchActivityDate {
//Test activity date of task should be assigned to Opportunity's Next scheduled activity field.
    static testMethod void insertTaskOnOpportunity() {
        
        Opportunity opp = getOpportunity();
        if(opp.Id!=null) {
            Task newTask;
            Test.startTest();
            newTask = new Task(whatid= opp.Id,Subject = 'Call test', ActivityDate = date.today().AddDays(2));
            insert newTask;
            
            Event evt = new Event(whatid = opp.id , subject = 'Call Evt' , StartDatetime = date.today().Adddays(3),DurationInMinutes =1 );
            insert evt;
            
            
            BatchUpdateOppsNextSchActivityDate batch = new BatchUpdateOppsNextSchActivityDate ();
            batch.query  = 'SELECT Id, Next_Scheduled_Activity__c, (Select id,StartDateTime FROM Events order by StartDateTime limit 1), (Select id,ActivityDate from Tasks where IsClosed = False order by ActivityDate asc limit 1) FROM Opportunity WHERE Id = \''+opp.id + '\' ';
            database.executeBatch(batch,100);
            
            Test.stopTest();
            //Now check the results
            opp = [SELECT Id, Next_Scheduled_Activity__c FROM Opportunity WHERE Id = :opp.Id];            
            system.assertEquals(newTask.ActivityDate , opp.Next_Scheduled_Activity__c );
            
        }
    }
    
    //Added by Reena for S-140256
    //Insert opportunity
    static Opportunity getOpportunity(){
        Account myAcct = New Account (Name='Test Account - TESTAccountNextActivityDate');        insert myAcct;
        opportunity opp = new Opportunity(Name= 'testOpportunity',stageName='Working',closeDate = Date.Today().addDays(10), accountId = myAcct.id);
        insert opp;
        return opp;
    }
}