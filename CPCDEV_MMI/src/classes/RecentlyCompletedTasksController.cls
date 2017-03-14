/*************************************************************************
Name          : RecentlyCompletedTasksController
Usage         : Controller class for RecentlyCompletedTasks Page.
Created By    : Parth Tamhaney
Created Date  : July 14, 2009

Modified By   : Aashish Mathur
Modified Date : Nov 30, 2009
Comments      : Implemented changes requested in PR-03245
*************************************************************************/

public class RecentlyCompletedTasksController {
    public List<Task> relatedTask {get; set;}
    public String orderBy {get; set;}
    public String imgSrc {get; private set;}
    
    private String previousOrderBy;
    private String descAsc;
    
    private Map<String, List<Task>> subjectToTasksMap;
    private Map<Date, List<Task>> activityDateToTasksMap;
    private Map<String, List<Task>> contactNameToTasksMap;
    private List<String> subjectList;
    private List<Date> activityDateList;
    private List<String> contactNameList;
    
    public RecentlyCompletedTasksController(ApexPages.StandardController sc) {
        previousOrderBy = orderBy = 'ActivityDate';
        descAsc = 'desc';
        imgSrc = '/img/sort_desc_arrow.gif';
        
        subjectToTasksMap = new Map<String, List<Task>>();
        activityDateToTasksMap = new Map<Date, List<Task>>();
        contactNameToTasksMap = new Map<String, List<Task>>();
        subjectList = new List<String>();
        activityDateList = new List<Date>();
        contactNameList = new List<String>();
        
        relatedTask = [SELECT Subject, ActivityDate, Who.Name, Description From Task
                WHERE Status = 'Completed' AND
                AccountId = :sc.getId() AND
                OwnerId = :UserInfo.getUserId()
                Order by ActivityDate desc LIMIT 10];
        
        List<Task> taskList;
        for (Task t : relatedTask) {
            taskList = subjectToTasksMap.get(t.Subject);
            if (taskList == null) {
                taskList = new List<Task>();
                subjectToTasksMap.put(t.Subject, taskList);
            }
            taskList.add(t);
            
            taskList = activityDateToTasksMap.get(t.ActivityDate);
            if (taskList == null) {
                taskList = new List<Task>();
                activityDateToTasksMap.put(t.ActivityDate, taskList);
            }
            taskList.add(t);
            
            taskList = contactNameToTasksMap.get(t.Who.Name);
            if (taskList == null) {
                taskList = new List<Task>();
                contactNameToTasksMap.put(t.Who.Name, taskList);
            }
            taskList.add(t);
        }
        
        subjectList.addAll(subjectToTasksMap.keySet());
        activityDateList.addAll(activityDateToTasksMap.keySet());
        contactNameList.addAll(contactNameToTasksMap.keySet());
        
        subjectList.sort();
        activityDateList.sort();
        contactNameList.sort();
    }
    
    public void sortData() {
        relatedTask = new List<Task>();
        
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
                    relatedTask.addAll(subjectToTasksMap.get(subjectList[index]));
                }
            } else {
                for (Integer index = (subjectList.size() - 1); index >= 0; index--) {
                    relatedTask.addAll(subjectToTasksMap.get(subjectList[index]));
                }
            }
        } else if (orderBy == 'ActivityDate') {
            if (descAsc == 'desc') {
                for (Integer index = 0; index < activityDateList.size(); index++) {
                    relatedTask.addAll(activityDateToTasksMap.get(activityDateList[index]));
                }
            } else {
                for (Integer index = (activityDateList.size() - 1); index >= 0; index--) {
                    relatedTask.addAll(activityDateToTasksMap.get(activityDateList[index]));
                }
            }
        } else if (orderBy == 'Who.Name') {
            if (descAsc == 'desc') {
                for (Integer index = 0; index < contactNameList.size(); index++) {
                    relatedTask.addAll(contactNameToTasksMap.get(contactNameList[index]));
                }
            } else {
                for (Integer index = (contactNameList.size() - 1); index >= 0; index--) {
                    relatedTask.addAll(contactNameToTasksMap.get(contactNameList[index]));
                }
            }
        }
        
        previousOrderBy = orderBy;
    }
}