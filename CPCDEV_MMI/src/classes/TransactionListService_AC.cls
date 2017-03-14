/**************************************************************************
Name:  TransactionListService_AC()
Copyright © 2013  MMI
----------------------------------------------------------------------
Purpose:
This class contains the methods for Transaction List Service HTTP Rest 
web service Callouts 
-----------------------------------------------------------------------
History:

VERSION  AUTHOR                 DATE        DETAIL              
1.0  -  TEKsystems             11/2/2013   INITIAL DEVELOPMENT  
**************************************************************************/
public with sharing class TransactionListService_AC {

    public String transactionResponse {get;set;}
    /*********************************************************************
    Purpose     : To get the list of Active Transactions
    Parameters  : none
    Returns     : List of HomeBaseBeans.transactions
    **********************************************************************/
	public List<HomeBaseBeans.transactions> listActiveTransactions(String branchId)
	{
		/*system.debug(LoggingLevel.DEBUG,'Entering TransactionListService_AC:listActiveTransactions:'+branchId);
    	ServiceProxy servicePro =null;
    	List<HomeBaseBeans.transactions> HBList=null;
    	TransactionClass allTransactions;
        try{ 
        	if(branchId!=null){
		        servicePro = new ServiceProxy();
			    if(!Test.isRunningTest()){
				    transactionResponse = servicePro.callRestService('rest/api/v1/companies/1/transactions?type=goods_out&rental=true&sales=true&login_id=result&branch_id='+branchId+'&active_only=true','GET','');
			    }
				if(transactionResponse!=null && !transactionResponse.contains('"errorCode"')){
					allTransactions = (TransactionClass)JSON.deserialize(transactionResponse, TransactionClass.class);
					
				}else{ 
					HBList = new List<HomeBaseBeans.transactions>();
					HomeBaseBeans.transactions h = new HomeBaseBeans.transactions();
					String errorMessage = QuickQuoteErrorHandler.handleError(transactionResponse);				
					h.errorMessage = errorMessage;
					HBList.add(h);
		        }
        	}
		}catch(Exception e){
			HBList = new List<HomeBaseBeans.transactions>();
			HomeBaseBeans.transactions h = new HomeBaseBeans.transactions();
			String errorMessage = e.getMessage();			
			h.errorMessage = errorMessage;
			HBList.add(h);
			
			return HBList;
		}
		if(HBList!=null && !HBList.isEmpty()){
	    	system.debug(LoggingLevel.DEBUG,'Exiting CountryService_AC:listCountry:'+HBList);
	        return HBList;
	    }else{
	    	system.debug(LoggingLevel.DEBUG,'Exiting CountryService_AC:listCountry:'+allTransactions.transactions);
	    	return allTransactions.transactions;
	    }*/
	    List<HomeBaseBeans.transactions> lstTransType = new List<HomeBaseBeans.transactions>();
	    
	    list<Transaction_Type__c> lstTrans = [select Id,Name,Description__c from Transaction_Type__c];
	    if(!lstTrans.isEmpty()){
	    	for(Transaction_Type__c t : lstTrans){
	    		HomeBaseBeans.transactions tr = new HomeBaseBeans.transactions();
		    	tr.Id = t.Name;
		    	tr.description = t.Description__c;
		    	lstTransType.add(tr);
	    	}
	    }
	    
	    return lstTransType;
	    
	}
	
	/*********************************************************************
    Purpose     : This is inner class to initializing and holding after 
                  JSON parsing
    Parameters  : none
    Returns     : none
    **********************************************************************/
	public class TransactionClass
       {
            public HomeBaseBeans.transactions[] transactions;
            public TransactionClass()
            {
               this.transactions = new List<HomeBaseBeans.transactions>();  
            }
       }
       
}