public with sharing class taskCompletedTimeDateStamp {
    
    private static final Integer MILLISECONDS_TO_MINUTE = 60000;//Added by Akanksha for story S-143271 
    public Static VOID timeStampCompletedTasks(List<Task> completedTasks){
        //Added by Akanksha for story S-143271 
        List<BusinessHours> bhList = [SELECT Id FROM BusinessHours WHERE IsDefault=true];
        List<BusinessHours> bh268List = [SELECT Id FROM BusinessHours WHERE name = 'Branch 298'];
        //End by Akanksha for story S-143271 
        for (integer i=0;i<completedTasks.size();i++){
            
            completedTasks[i].Task_Completed_Date_Time__c = system.now();
            //Added by Akanksha for story S-143271 
            BusinessHours bh;
            if(completedTasks[i].Branch__c == '298')
            {
                 bh = bh268List[0];  
            }
            else
            {
                 bh = bhList[0];  
            }
            Long timeSinceLastStatus;
            if(completedTasks[i].createdDate != null)
            {
                timeSinceLastStatus = BusinessHours.diff(bh.id, completedTasks[i].createdDate, completedTasks[i].Task_Completed_Date_Time__c)/MILLISECONDS_TO_MINUTE;
            }
            else
            {
                timeSinceLastStatus = 0;
                
            }
            completedTasks[i].Business_Task_Age__c = timeSinceLastStatus;
            //End by Akanksha for story S-143271 
        }
    
    }

    static testMethod void myUnitTest() {
    
        Task newTask = New Task(Subject = 'Apex Test Task', Status = 'Not Started', Call_Result__c = 'Spoke with Customer/Prospect', Branch__c ='268');
        
        insert newTask;
        
        newTask.Status = 'Completed';
        
        update newTask;
        
        //delete newTask;   
    
    }
    

}