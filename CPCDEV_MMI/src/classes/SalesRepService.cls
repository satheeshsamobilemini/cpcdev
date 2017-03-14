public with sharing class SalesRepService 
{
	public String salesRepResponse {get;set;}
	public String branchId = '';
	
	public List<HomeBaseBeans.salesReps> listSalesReps()
    {
        ServiceProxy servicePro = new ServiceProxy();         
        User UserObj = FullQuoteDAO.getUserBranchDetails();
        String branch = branchId;
        if(branch == null || branch == ''){
     		branch = UserObj.Branch_Id__c;
        }
     	
        if(!Test.isRunningTest())
        salesRepResponse = servicePro.callRestService('rest/api/v1/companies/1/sales_reps?branch_id='+branch,'GET','');
	    	    	    
	    try
	    {    
	        if(!salesRepResponse.contains('"errorCode"'))
			{
		        salesRepListClass allSalesReps = (salesRepListClass)JSON.deserialize(salesRepResponse, salesRepListClass.class);
		        System.debug('***************'+allSalesReps.salesReps);
		        return allSalesReps.salesReps;
			}
			else
			{
				List<HomeBaseBeans.salesReps> HBList = new List<HomeBaseBeans.salesReps>();
				HomeBaseBeans.salesReps h = new HomeBaseBeans.salesReps();
				String errorMessage = QuickQuoteErrorHandler.handleError(salesRepResponse);				
				h.errorMessage = errorMessage;
				
				HBList.add(h);
				
				return HBList;
			}
	    }
	    catch(Exception e)
	    {
	    	String errorMessage = e.getMessage();
	    	List<HomeBaseBeans.salesReps> HBList = new List<HomeBaseBeans.salesReps>();
			HomeBaseBeans.salesReps h = new HomeBaseBeans.salesReps();
			h.errorMessage = errorMessage;
			
			HBList.add(h);
			
			return HBList;
	    }
    }
    
    /*public List<HomeBaseBeans.salesReps> listSalesRepsOfBranch(String BranchId)
    {
        ServiceProxy servicePro = new ServiceProxy();         
     	
        if(!Test.isRunningTest())
        String salesRepResponse = servicePro.callRestService('rest/api/v1/companies/1/sales_reps','GET','');
	    	    	    
	    try
	    {    
	        if(!salesRepResponse.contains('"errorCode"'))
			{
		        salesRepListClass allSalesReps = (salesRepListClass)JSON.deserialize(salesRepResponse, salesRepListClass.class);
		        System.debug('***************'+allSalesReps.salesReps);
		        return allSalesReps.salesReps;
			}
			else
			{
				List<HomeBaseBeans.salesReps> HBList = new List<HomeBaseBeans.salesReps>();
				HomeBaseBeans.salesReps h = new HomeBaseBeans.salesReps();
				String errorMessage = QuickQuoteErrorHandler.handleError(salesRepResponse);				
				h.errorMessage = errorMessage;
				
				HBList.add(h);
				
				return HBList;
			}
	    }
	    catch(Exception e)
	    {
	    	String errorMessage = e.getMessage();
	    	List<HomeBaseBeans.salesReps> HBList = new List<HomeBaseBeans.salesReps>();
			HomeBaseBeans.salesReps h = new HomeBaseBeans.salesReps();
			h.errorMessage = errorMessage;
			
			HBList.add(h);
			
			return HBList;
	    }
    }*/
    
    public HomeBaseBeans.salesRepsId SalesReps(String writeup)
    {
        ServiceProxy servicePro = new ServiceProxy();         
        SalesRepRes allSalesReps;
        if(writeup != null && writeup != ''){
        	if(!Test.isRunningTest())
	        	salesRepResponse = servicePro.callRestService('rest/api/v1/companies/1/sales_reps/'+writeup,'GET','');
		    	    	    
		    try
		    {    
		        if(!salesRepResponse.contains('"errorCode"'))
				{
			        allSalesReps = (SalesRepRes)JSON.deserialize(salesRepResponse, SalesRepService.SalesRepRes.class);
			         return allSalesReps.salesRep;
				}
				else
				{
					HomeBaseBeans.salesRepsId HBList = new HomeBaseBeans.salesRepsId();
					HomeBaseBeans.salesRepsId h = new HomeBaseBeans.salesRepsId();
					String errorMessage = QuickQuoteErrorHandler.handleError(salesRepResponse);				
					h.errorMessage = errorMessage;
					HBList=h;
					return HBList;
				}
		    }
		    catch(Exception e)
		    {
		    	String errorMessage = e.getMessage();
		    	HomeBaseBeans.salesRepsId HBList = new HomeBaseBeans.salesRepsId();
				HomeBaseBeans.salesRepsId h = new HomeBaseBeans.salesRepsId();
				return HBList;
		    }
        }else{
        	return null;
        }
    }
    public class salesRepListClass
    {
        public HomeBaseBeans.salesReps[] salesReps;
        public salesRepListClass()
        {
                this.salesReps = new List<HomeBaseBeans.salesReps>();
        }
    }
         
     public class SalesRepRes {
	      public HomeBaseBeans.salesRepsId salesRep{get;set;} 
      }	
        
}