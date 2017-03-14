public class TaskUtility {

  @future 
  public static void updateTask(Set<String> contactIdSet){
    List<Task> taskList = new List<Task>();
    Map<String,String> contactAccountMap = new Map<String,String>();
    System.Debug('>>>>>>'+contactIdSet);
    List<Contact> contacts = [select Id,Name,AccountId from contact where id in : contactIdSet];
    system.debug('----contacts---' + contacts);
    for(Contact con : [select Id,Name,AccountId from contact where id in : contactIdSet]){
      contactAccountMap.put(con.Id,con.AccountId);
    }
    
    for(Task task : [select Id,whatId,whoId from Task where whoId in : contactIdSet]){
      if(task.whatId == Null){
        task.whatId = contactAccountMap.get(task.whoId);
      }
      task.whoId = null;
      taskList.add(task); 
      if(taskList.size()==199){
        update taskList;
        taskList.clear();   
      }  
    }
    if(taskList.size()>0){
      update taskList;
      taskList.clear();
    }
    
  }
  
  Public static String idsTo18(String initialVal) {
  		 if (initialVal.length() != 15) return initialVal;
  		 ID convertToLong = initialVal;
         String longId = convertToLong;
         return longId;
  }  
  
  public static void updateTaskJobFileName(Set<Id> jobProfileIdSet, List<Task> taskList){
    Map<Id,Job_Profile__c> jobProfileMap = new Map<Id,Job_Profile__c>([select Id,Name from job_Profile__c where id in : jobProfileIdSet]);
    List<Task> taskToBeUpdated = new List<Task>();
    for(Task t : taskList){
      if(t.Job_Profile_ID__c != null && (t.Job_Profile_Id__c.length() == 15 || t.Job_Profile_Id__c.length() == 18) && jobProfileMap.containsKey(t.Job_Profile_ID__c)){ // Added check for Job Profile custom field length by Najma Ateeq for #00051948 on 19 August 2013
        t.Job_Profile_Name__c = jobProfileMap.get(t.Job_Profile_ID__c).Name;
      }
    }
  }
  
}