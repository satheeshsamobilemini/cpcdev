public class TaskOnOpportunityController {
	public List<Task> taskList{get;set;}
	public String orderBy {get; set;}
    public String imgSrc {get; private set;}
    
    private String opportunityId;
    private String previousOrderBy;
    private String descAsc;
    
    public Static String taskQuery = 'SELECT Id,Subject,Call_Type__c,ActivityDate, Who.Id ,Who.Name,What.Id ,What.Name,isClosed,Description,OwnerId,Owner.Name From Task '; 
    
	public TaskOnOpportunityController(ApexPages.StandardController controller){
		opportunityId =  controller.getId();
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
		
		tempQuery += ' WHERE whatId = \'' + TaskUtility.idsTo18(opportunityId.subString(0,15)) + '\''+' order by ' + orderBy + ' ' + descAsc +' limit 100';
		return tempQuery;
    }

}