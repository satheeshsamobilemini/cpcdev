/************************************************
Name : TaskEditController
Created By : Reena Acharya(Appirio Offshore)
Created Date : 7th March , 2013
Description : Intermediate page to override Task Edit
              Send an extra parameter of fieldID JOBProfile ID
************************************************/
public class TaskEditController {
   
    public TaskEditController(ApexPages.StandardController controller) {
    }
    
    //Action function on page
    //Get the URL and add JOB Profile ID in URL and send that to standard layout back.
    public PageReference redirect(){
        PageReference pg;
        if(ApexPages.currentPage().getParameters().get('id') != null){
            String taskID = ApexPages.currentPage().getParameters().get('id');
            //4.18.2013-CASE 45814 - LSLEVIN - START EDITED Query to add and IsDeleted=false ALL ROWS//
            // Done by Appirio Offshore (Hemant) 4/23/2013 start
            //Task taskObj = [Select id , Job_Profile_ID__c from task where id =: taskID and IsDeleted=false ALL ROWS];
            //END
            String retURL = ApexPages.currentPage().getParameters().get('retURL');
            
            Task taskObj;
            List<Task> taskObjLst = [Select id , Job_Profile_ID__c from task where id =: taskID and IsDeleted=false ALL ROWS];
            if(taskObjLst.size() > 0){
            	taskObj = taskObjLst[0];  
            	retURL = retURL +'?00N80000004c842='+ taskObj.Job_Profile_ID__c;
            	pg = new PageReference('/'+taskObj.Id +'/e?nooverride=1&retURL='+ retURL );
            }else{
            	pg = new PageReference('/'+taskID +'/e?nooverride=1&retURL='+ retURL );
            }
            // Done by Appirio Offshore (Hemant) 4/23/2013 end
            pg.setRedirect(true);
            
        }
        return pg;
    }

   //Test method
    @isTest
    static void testData(){
        Task tsk = new Task(Subject = 'sub');
        insert tsk;
        system.assertNotEquals(tsk.id , null);
        
        ApexPages.currentPage().getParameters().put('id' , tsk.id);
        TaskEditController tec = new TaskEditController(new ApexPages.StandardController(tsk));
        tec.redirect();
        
    }
}