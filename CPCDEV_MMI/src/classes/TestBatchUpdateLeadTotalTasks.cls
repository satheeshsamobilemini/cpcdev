@isTest
private class TestBatchUpdateLeadTotalTasks {
    
  static testmethod void TestMethod1()
    {  
      Test.startTest();
        
          Lead ld = MMIFullquoteTestDataProvider.getLeadWithDeliveryAdd();
          insert ld;
          
          Task task1 = new Task(whoId = ld.id,status ='Completed', ActivityDate = system.today());
          insert task1;
       
          Task task2 = new Task(whoId = ld.id,status ='In Progress', ActivityDate = system.today());
          insert task2;
       
          task2.Status = 'Completed';
          update task2;
       
          task1.Status = 'In Progress';
          update task1;
       
         String query = 'select id,Total_Tasks__c,(select id,status,ActivityDate,isTask from OpenActivities where isTask = true LIMIT 2) from Lead where Id = \''+ld.id + '\' ';
         BatchUpdateLeadTotalTasks bc1 = new BatchUpdateLeadTotalTasks(query,True);  
         BatchUpdateLeadTotalTasks bc2 = new BatchUpdateLeadTotalTasks(query,false); 
         Database.executeBatch(bc1,10);  
         Database.executeBatch(bc2,10);
       
      Test.StopTest();
       
       
    
    }

}