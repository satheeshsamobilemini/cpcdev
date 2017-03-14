/*************************************************************************
Name          : childAccountTaskSummaryController
Usage         : Controller class for childAccountTaskSummary Page.
Created By    : Megha Agarwal(Appirio Offshore)
Created Date  : May 25, 2010
*************************************************************************/
public class childAccountTaskSummaryController {

	public List<Task> taskSummaryList{get;set;}
	public String orderBy {get; set;}
    public String imgSrc {get; private set;}
    
    private Map<String, List<String>> subjectToTaskIdsMap;
    private Map<Date, List<String>> activityDateToTaskIdsMap;
    private Map<String, List<String>> contactNameToTaskIdsMap;
    private Map<String,List<String>> accountNameToTaskIdsMap;
    private Map<String,List<String>> callTypeToTaskIdsMap;
    private Map<String,Task> taskMap;
    private List<String> subjectList;
    private List<Date> activityDateList;
    private List<String> contactNameList;
    private List<String> accountNameList;
    private List<String> callTypeList;
    
    private String previousOrderBy;
    private String descAsc;
    
	public childAccountTaskSummaryController(ApexPages.StandardController controller){
		
		String accId = controller.getId();
		previousOrderBy = orderBy = 'ActivityDate';
        descAsc = 'desc';
        imgSrc = '/img/sort_desc_arrow.gif';
        
        subjectToTaskIdsMap = new Map<String,List<String>>();
    	activityDateToTaskIdsMap= new Map<Date, List<String>>() ;
    	contactNameToTaskIdsMap = new Map<String, List<String>>();
    	accountNameToTaskIdsMap = new Map<String,List<String>>();
    	callTypeToTaskIdsMap = new Map<String,List<String>>();
    	
        taskMap = new Map<String,Task>();
        
        subjectList = new List<String>();
        activityDateList = new List<Date>();
    	contactNameList = new List<String>();
        accountNameList = new List<String>();
        callTypeList = new List<String>();
        
		Set<String> childAccountIds = new Set<String>();
		for(Account acc : [select Id,Name from Account where ParentId =:accId ]){
			childAccountIds.add(acc.Id);
		}	
		taskSummaryList = new List<Task>();
		if(childAccountIds != null && childAccountIds.size()>0){
			taskSummaryList = [SELECT Id,Subject,Call_Type__c,ActivityDate, Who.Id ,Who.Name,What.Id ,What.Name,isClosed,Description From Task
                WHERE ( (AccountId in :childAccountIds) AND ( ((isClosed = TRUE) AND (ActivityDate >= :Date.today().addDays(-30))) OR (isClosed = FALSE) ) ) 
                Order by ActivityDate desc];
			/*
			taskSummaryList = [SELECT Id,Subject, ActivityDate, Who.Id ,Who.Name,What.Id ,What.Name,isClosed,Description From Task
                WHERE AccountId in :childAccountIds and ActivityDate >= :Date.today().addDays(-10) and ActivityDate <=:Date.today() 
                Order by ActivityDate desc LIMIT 20];
            */    
            List<String> taskIdList;
        	for (Task t : taskSummaryList) {
        		taskMap.put(t.Id,t);
            	taskIdList = subjectToTaskIdsMap.get(t.Subject);
            	if (taskIdList == null) {
            	    taskIdList = new List<String>();
                	subjectToTaskIdsMap.put(t.Subject,taskIdList);
            	}
            	taskIdList.add(t.id);
            
            	taskIdList = activityDateToTaskIdsMap.get(t.ActivityDate);
            	if (taskIdList == null) {
                	taskIdList = new List<String>();
                	activityDateToTaskIdsMap.put(t.ActivityDate, taskIdList);
            	}
            	taskIdList.add(t.id);
            	
            	taskIdList = contactNameToTaskIdsMap.get(t.Who.Name);
    	        if (taskIdList == null) {
        	        taskIdList = new List<String>();
            	    contactNameToTaskIdsMap.put(t.Who.Name, taskIdList);
            	}
            	taskIdList.add(t.id);
            
            	taskIdList = accountNameToTaskIdsMap.get(t.what.Name);
            	if (taskIdList == null) {
                	taskIdList = new List<String>();
                	accountNameToTaskIdsMap.put(t.What.Name, taskIdList);
            	}
            	taskIdList.add(t.id); 
            	
            	taskIdList = callTypeToTaskIdsMap.get(t.Call_Type__c);
            	if (taskIdList == null) {
                	taskIdList = new List<String>();
                	callTypeToTaskIdsMap.put(t.Call_Type__c, taskIdList);
            	}
            	taskIdList.add(t.id);
        	}
        
        	subjectList.addAll(subjectToTaskIDsMap.keySet());
        	activityDateList.addAll(activityDateToTaskIdsMap.keySet());
        	contactNameList.addAll(contactNameToTaskIdsMap.keySet());
        	accountNameList.addAll(accountNameToTaskIdsMap.keySet());
        	callTypeList.addAll(callTypeToTaskIdsMap.keySet());
        	
        	subjectList.sort();
        	activityDateList.sort();
        	contactNameList.sort();
        	accountNameList.sort();
        	callTypeList.sort();
		}
	}
	
	public void sortData() {
        taskSummaryList = new List<Task>();
        
        if (previousOrderBy == orderBy && descAsc == 'desc') {
            descAsc = 'asc';
            imgSrc = '/img/sort_asc_arrow.gif';
        } else {
            descAsc = 'desc';
            imgSrc = '/img/sort_desc_arrow.gif';
        }
        
        if (orderBy == 'Subject') {
            if (descAsc == 'desc') {
                for (Integer index = 0; index < subjectList.size(); index++) {
                	for(String taskId : subjectToTaskIdsMap.get(subjectList[index])){
                		taskSummaryList.add(taskMap.get(taskId));	
                	}
                    
                }
            } else {
                for (Integer index = (subjectList.size() - 1); index >= 0; index--) {
                	for(String taskId : subjectToTaskIdsMap.get(subjectList[index])){
                		taskSummaryList.add(taskMap.get(taskId));	
                	}
                }
            }
        } else if (orderBy == 'ActivityDate') {
            if (descAsc == 'desc') {
                for (Integer index = 0; index < activityDateList.size(); index++) {
                	for(String taskId : activityDateToTaskIdsMap.get(activityDateList[index])){
                		taskSummaryList.add(taskMap.get(taskId));	
                	}
                }
            } else {
                for (Integer index = (activityDateList.size() - 1); index >= 0; index--) {
                    for(String taskId : activityDateToTaskIdsMap.get(activityDateList[index])){
                		taskSummaryList.add(taskMap.get(taskId));	
                	}
                }
            }
        } else if (orderBy == 'Who.Name') {
            if (descAsc == 'desc') {
            	
                for (Integer index = 0; index < contactNameList.size(); index++) {
                	for(String taskId : contactNameToTaskIdsMap.get(contactNameList[index])){
                		taskSummaryList.add(taskMap.get(taskId));	
                	}
               }
            } else {
                for (Integer index = (contactNameList.size() - 1); index >= 0; index--) {
                    for(String taskId : contactNameToTaskIdsMap.get(contactNameList[index])){
                		taskSummaryList.add(taskMap.get(taskId));	
                	}
                }
            }
        }
        else if (orderBy == 'What.Name') {
            if (descAsc == 'desc') {
            	
                for (Integer index = 0; index < accountNameList.size(); index++) {
                	for(String taskId : accountNameToTaskIdsMap.get(accountNameList[index])){
                		taskSummaryList.add(taskMap.get(taskId));	
                	}
               }
            } else {
                for (Integer index = (accountNameList.size() - 1); index >= 0; index--) {
                    for(String taskId : accountNameToTaskIdsMap.get(accountNameList[index])){
                		taskSummaryList.add(taskMap.get(taskId));	
                	}
                }
            }
        }
        else if (orderBy == 'CallType') {
            if (descAsc == 'desc') {
            	
                for (Integer index = 0; index < callTypeList.size(); index++) {
                	for(String taskId : callTypeToTaskIdsMap.get(callTypeList[index])){
                		taskSummaryList.add(taskMap.get(taskId));	
                	}
               }
            } else {
                for (Integer index = (callTypeList.size() - 1); index >= 0; index--) {
                    for(String taskId : callTypeToTaskIdsMap.get(callTypeList[index])){
                		taskSummaryList.add(taskMap.get(taskId));	
                	}
                }
            }
        }
        previousOrderBy = orderBy;
    }
}