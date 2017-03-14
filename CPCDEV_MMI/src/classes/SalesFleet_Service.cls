public with sharing class SalesFleet_Service {
	
	
    public String salesFleetResponse {get;set;}
    public String AllocationEcodeResponse {get;set;}
    /*********************************************************************
    Purpose     : To get the sales fleet web service
    Parameters  : user product id
    Returns     : 
    **********************************************************************/    
    public List<HomeBaseBeans.SalesFleets> getSalesFleet(String productId ,String branchId){
    	system.debug(LoggingLevel.DEBUG,'Entering SalesFleet_Service:getSalesFleet:'+productId +branchId);
        ServiceProxy serviceProxy = null;
        HomeBaseBeans.SalesFleets HBFleet=null;
        List<HomeBaseBeans.SalesFleets> HBFleetList=null;
        SalesFleet salesFleet=null;
        try{
        	if(branchId!=null){ 
        		 HBFleet=new HomeBaseBeans.SalesFleets ();
                 serviceProxy = new ServiceProxy(); 
		        if(!Test.isRunningTest()){ 
		            salesFleetResponse = serviceProxy.callRestService('rest/api/v1/sales_fleet?company_id=1&branch_id='+branchId+'&product_id='+productId,'GET','');
		             system.debug('@@@@@@@@1'+salesFleetResponse);
		        }
		
		        if( salesFleetResponse!=null && !salesFleetResponse.contains('"errorCode"'))
				{
			        salesFleet = (SalesFleet)JSON.deserialize(salesFleetResponse, SalesFleet_Service.SalesFleet.class);
			        system.debug('@@@@@@@@2'+salesFleet.salesFleets);
				}else{
				
					HomeBaseBeans.SalesFleets h = new HomeBaseBeans.SalesFleets();
					String errorMessage = QuickQuoteErrorHandler.handleError(salesFleetResponse);
					h.errorMessage = errorMessage;
					HBFleet=h;
			    }
	        }
        } catch(Exception e){
	    	String errorMessage = e.getMessage();
			HomeBaseBeans.SalesFleets h = new HomeBaseBeans.SalesFleets();
			h.errorMessage = errorMessage;
			HBFleet=h;
	    }
	    if(HBFleet.errorMessage!=null){
	    	HBFleetList=new List<HomeBaseBeans.SalesFleets>();
	    	HBFleetList.add(HBFleet);
	    	system.debug(LoggingLevel.DEBUG,'Exiting SalesFleet'+HBFleet);
	        return HBFleetList;
	    }else{
	    	system.debug(LoggingLevel.DEBUG,'Exiting SalesFleet_Service:getSalesFleet:'+salesFleet.salesFleets);
	        return salesFleet.salesFleets;
	    }
	    
    }
    
    /*********************************************************************
    Purpose     : To get all Ecode allocation
    Parameters  : 
    Returns     : 
    **********************************************************************/    
    public List<HomeBaseBeans.allocations> listEcodeList(String ecodeIdSearch, String BranchId, String TransId,date fromdate, String AccountId, String Ecodes){
    	system.debug(LoggingLevel.DEBUG,'Entering SalesFleet_Service:getSalesFleet:'+ecodeIdSearch);
        ServiceProxy serviceProxy = null;
        HomeBaseBeans.allocations HBFleet=null;
        List<HomeBaseBeans.allocations> EodeAllocList = null;
        Allocation EodeAlloc=null;
        String FromDateString = '';
        if(fromdate != null){
        	FromDateString = String.valueOf(fromdate.year());
        	if(String.valueOf(fromdate.month()).length() < 2){
        		FromDateString += '-0'+fromdate.month();
        	}else{
        		FromDateString += '-'+fromdate.month();
        	}
        	if(String.valueOf(fromdate.day()).length() < 2){
        		FromDateString += '-0'+fromdate.day();
        	}else{
        		FromDateString += '-'+fromdate.day();
        	}
        }
        
        try{
        	if(BranchId!=null){ 
        		 HBFleet=new HomeBaseBeans.allocations ();
                 serviceProxy = new ServiceProxy(); 
		        if(!Test.isRunningTest()){
		        	if(Ecodes != '' && Ecodes != null){
		        		AllocationEcodeResponse = serviceProxy.callRestService('rest/api/v1/allocations?company_id=1&duration=0&branch_id='+BranchId+'&account_id='+AccountId+'&from_date='+FromDateString+'&transaction_id='+TransId+'&product_id='+ecodeIdSearch+'&ecodes='+Ecodes,'GET','');
		        	}else{
		        		AllocationEcodeResponse = serviceProxy.callRestService('rest/api/v1/allocations?company_id=1&duration=0&branch_id='+BranchId+'&account_id='+AccountId+'&from_date='+FromDateString+'&transaction_id='+TransId+'&product_id='+ecodeIdSearch,'GET','');
		        	} 
		            
		             system.debug('@@@@AllocationEcodeResponse@@@'+AllocationEcodeResponse);
		        }
		
		        if( AllocationEcodeResponse!=null && !AllocationEcodeResponse.contains('"errorCode"'))
				{
			        EodeAlloc = (Allocation)JSON.deserialize(AllocationEcodeResponse, SalesFleet_Service.Allocation.class);
			        system.debug('@@@@@@@@2'+EodeAlloc.allocations);
				}else{
				
					HomeBaseBeans.allocations h = new HomeBaseBeans.allocations();
					String errorMessage = QuickQuoteErrorHandler.handleError(AllocationEcodeResponse);
					h.errorMessage = errorMessage;
					HBFleet=h;
			    }
	        }
        } catch(Exception e){
	    	String errorMessage = e.getMessage();
			HomeBaseBeans.allocations h = new HomeBaseBeans.allocations();
			h.errorMessage = errorMessage;
			HBFleet=h;
	    }
	    if(HBFleet.errorMessage!=null){
	    	EodeAllocList=new List<HomeBaseBeans.allocations>();
	    	EodeAllocList.add(HBFleet);
	    	system.debug(LoggingLevel.DEBUG,'Exiting SalesFleet'+HBFleet);
	        return EodeAllocList;
	    }else{
	    	system.debug(LoggingLevel.DEBUG,'Exiting SalesFleet_Service:getSalesFleet:'+EodeAlloc.allocations);
	        return EodeAlloc.allocations;
	    }
	    
    }
    
     public class SalesFleet {
    	  public HomeBaseBeans.SalesFleets[] salesFleets; 
    	  public SalesFleet() {
                this.salesFleets = new List<HomeBaseBeans.SalesFleets>();
        }
    }
    
    public class Allocation{
    	  public HomeBaseBeans.allocations[] allocations; 
    	  public Allocation() {
                this.allocations = new List<HomeBaseBeans.allocations>();
        }
    }

}