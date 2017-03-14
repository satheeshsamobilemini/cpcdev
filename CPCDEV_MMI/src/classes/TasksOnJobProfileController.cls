public class TasksOnJobProfileController {
	
	public List<Task> taskList{get;set;}
	public String orderBy {get; set;}
    public String imgSrc {get; private set;}
    
    private String jobProfileId;
    private String previousOrderBy;
    private String descAsc;
    
    public Static String taskQuery = 'SELECT Id,Subject,Call_Type__c,ActivityDate, Who.Id ,Who.Name,What.Id ,What.Name,isClosed,Description,OwnerId,Owner.Name From Task '; 
    
	public TasksOnJobProfileController(ApexPages.StandardController controller){
		jobProfileId =  controller.getId();
		previousOrderBy = orderBy = 'ActivityDate';
        descAsc = 'desc';
        imgSrc = '/img/sort_desc_arrow.gif';
        loadData();
		
	}
	
	public void sortData() {
        taskList = new List<Task>();
        if (previousOrderBy == orderBy && descAsc == 'desc') {
            descAsc = 'asc';
            imgSrc = '/img/sort_asc_arrow.gif';
        } else {
            descAsc = 'desc';
            imgSrc = '/img/sort_desc_arrow.gif';
        }
        loadData();
        previousOrderBy = orderBy;
    }
    
	public void loadData(){
		taskList = new List<Task>();
		String tempQuery = makeQuery();
		System.debug('--query--'+tempQuery);
		try{
	    	taskList = Database.query(tempQuery);
		}catch(Exception ex){
			System.debug('--$$ Exception --'+ex);
		}
	}

	public String makeQuery(){
		String tempQuery = taskQuery;
		//tempQuery += ' WHERE what.Id = \'' + jobProfileId.subString(0,15) + '\' OR Job_Profile_ID__c = \'' + jobProfileId.subString(0,15) + '\''+' order by ' + orderBy + ' ' + descAsc +' limit 50';
		tempQuery += ' WHERE Job_Profile_ID__c = \'' + TaskUtility.idsTo18(jobProfileId.subString(0,15)) + '\''+' order by ' + orderBy + ' ' + descAsc +' limit 100';
		return tempQuery;
    }
}