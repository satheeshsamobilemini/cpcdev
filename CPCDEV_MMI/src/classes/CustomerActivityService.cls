public with sharing class CustomerActivityService {
	
	
     public CustomerActivityParser callEditWEbservice(String accountId,String salesRep, String Branchid){
		ServiceProxy servicePro =null;
		CustomerActivityParser r = new CustomerActivityParser();  
		servicePro = new ServiceProxy();
        return r.parse(servicePro.callRestService('rest/api/v1/companies/1/quotes?rep='+salesRep+'&branch_id='+Branchid+'&account_id='+accountId ,'GET',''));
		
	}
	 
	 
	  public CustomerActivityParser callCAOrderService(String accountId){
		ServiceProxy servicePro =null;
		CustomerActivityParser r = new CustomerActivityParser(); 
		servicePro = new ServiceProxy();
        return r.parse(servicePro.callRestService('rest/api/v1/companies/1/orders?account_id='+accountId+'&limit=300&status=all' ,'GET',''));
		
	}
	
}