/**************************************************************************
Name:  ValidateAddressService_AC()
Copyright © 2013  MMI
----------------------------------------------------------------------
Purpose:
This class contains the methods for validate descarte Service HTTP Rest 
web service Callouts 
-----------------------------------------------------------------------
History:

VERSION  AUTHOR                 DATE        DETAIL              
1.0  -  TEKsystems             11/2/2013   INITIAL DEVELOPMENT  
**************************************************************************/
public with sharing class ValidateAddressService_AC implements IValidateAddressService
{
   
    public String addressResponse {get;set;}
    public String validateAddressResponse {get;set;}
    
    /*********************************************************************
    Purpose     : To get the list of web address returning from descarte service
    Parameters  : HomeBaseBeans.AddressBean
    Returns     : List of HomeBaseBeans.webAddresses
    **********************************************************************/
    // Invoking descartesAddressLookup webservice.
    public List<HomeBaseBeans.webAddresses> descartesLookup(HomeBaseBeans.AddressBean address){   
    	system.debug(LoggingLevel.DEBUG,'Entering ValidateAddressService_AC:descartesLookup:'+address);
    	String branchId =null; 
    	String reqaddress =null;
    	ServiceProxy serviceProxy=null;
    	QuickQuoteMainService qqMainService=null; 
    	DescartesAddress descartesAddresses ;
    	List<HomeBaseBeans.webAddresses> HBList=null;
    	try{   
	    	if(address!=null){
		        reqaddress = prepareDescartesLookupRequest(address);        
		        system.debug('-------reqaddress--------'+reqaddress);        
		        serviceProxy = new ServiceProxy(); 
		        qqMainService=new QuickQuoteMainService();
		        //branchId=qqMainService.getuserBranchInfo();
		        branchId = address.branchId;
		        if(!Test.isRunningTest()){
		        	if(branchId!=null && reqaddress!=null){
		        		if(address.transactionType!=null && address.transactionType!=''){
		        			system.debug('--------address.transactionType------'+address.transactionType);
		        	       addressResponse = serviceProxy.callRestService('/rest/api/v1/lookup_address?company_id=1&branch_id='+ branchId +'&transaction_id='+address.transactionType,'POST',reqaddress);
		        		}else{
		        			 addressResponse = serviceProxy.callRestService('/rest/api/v1/lookup_address?company_id=1&branch_id='+ branchId +'&transaction_id=OFF','POST',reqaddress);
		        		}
		        	}
		        }
		        if(!addressResponse.contains('"errorCode"'))
				{
			       descartesAddresses = (DescartesAddress)JSON.deserialize(addressResponse, DescartesAddress.class);		        
				}
				else
				{
					HBList = new List<HomeBaseBeans.webAddresses>();
					HomeBaseBeans.webAddresses h = new HomeBaseBeans.webAddresses();
					String errorMessage = QuickQuoteErrorHandler.handleError(addressResponse);
					h.errorMessage = errorMessage;
					HBList.add(h);
					
				}
	    	}
	    }catch(Exception e){
    		String errorMessage = e.getMessage();
			HBList = new List<HomeBaseBeans.webAddresses>();
			HomeBaseBeans.webAddresses h = new HomeBaseBeans.webAddresses();
			h.errorMessage = errorMessage;
			HBList.add(h);
			system.debug(LoggingLevel.ERROR,'Error while getting values from ValidateAddressService_AC descartesLookup'+e.getMessage());
			return HBList;
	    }
	    if(HBList!=null && !HBList.isEmpty()){
	    	system.debug(LoggingLevel.DEBUG,'Exiting ValidateAddressService_AC:descartesLookup:'+HBList);
	        return HBList;
	    }else{
	    	system.debug(LoggingLevel.DEBUG,'Exiting ValidateAddressService_AC:descartesLookup:'+descartesAddresses.webAddresses);
	    	return descartesAddresses.webAddresses;
	    }
    }
     
    
     
     public List<HomeBaseBeans.webAddresses> descartesLookupFullQuote(HomeBaseBeans.AddressBean address){   
    	system.debug(LoggingLevel.DEBUG,'Entering ValidateAddressService_AC:descartesLookup:'+address);
    	String branchId =null; 
    	String reqaddress =null;
    	ServiceProxy serviceProxy=null;
    	QuickQuoteMainService qqMainService=null; 
    	DescartesAddress descartesAddresses ;
    	List<HomeBaseBeans.webAddresses> HBList=null;
    	try{   
	    	if(address!=null){
		        reqaddress = prepareDescartesLookupRequestFullQuote(address);
		        system.debug('-------reqaddress--------'+reqaddress);        
		        serviceProxy = new ServiceProxy(); 
		        qqMainService=new QuickQuoteMainService();
		        //branchId=qqMainService.getuserBranchInfo();
		        branchId = address.branchId;
		        if(!Test.isRunningTest()){
		        	if(branchId!=null && reqaddress!=null){
		        		if(address.transactionType!=null && address.transactionType!=''){
		        			system.debug('--------address.transactionType------'+address.transactionType);
		        	       addressResponse = serviceProxy.callRestService('/rest/api/v1/lookup_address?company_id=1&branch_id='+ branchId +'&transaction_id='+address.transactionType,'POST',reqaddress);
		        		}else{
		        			 addressResponse = serviceProxy.callRestService('/rest/api/v1/lookup_address?company_id=1&branch_id='+ branchId +'&transaction_id=OFF','POST',reqaddress);
		        		}
		        	}
		        }
		        if(!addressResponse.contains('"errorCode"'))
				{
			       descartesAddresses = (DescartesAddress)JSON.deserialize(addressResponse, DescartesAddress.class);		        
				}
				else
				{
					HBList = new List<HomeBaseBeans.webAddresses>();
					HomeBaseBeans.webAddresses h = new HomeBaseBeans.webAddresses();
					String errorMessage = QuickQuoteErrorHandler.handleError(addressResponse);
					h.errorMessage = errorMessage;
					HBList.add(h);
					
				}
	    	}
	    }catch(Exception e){
    		String errorMessage = e.getMessage();
			HBList = new List<HomeBaseBeans.webAddresses>();
			HomeBaseBeans.webAddresses h = new HomeBaseBeans.webAddresses();
			h.errorMessage = errorMessage;
			HBList.add(h);
			system.debug(LoggingLevel.ERROR,'Error while getting values from ValidateAddressService_AC descartesLookup'+e.getMessage());
			return HBList;
	    }
	    if(HBList!=null && !HBList.isEmpty()){
	    	system.debug(LoggingLevel.DEBUG,'Exiting ValidateAddressService_AC:descartesLookup:'+HBList);
	        return HBList;
	    }else{
	    	system.debug(LoggingLevel.DEBUG,'Exiting ValidateAddressService_AC:descartesLookup:'+descartesAddresses.webAddresses);
	    	return descartesAddresses.webAddresses;
	    }
    }
    
    /*********************************************************************
    Purpose     : To get the list of tax ids returning from descarte service
    Parameters  : HomeBaseBeans.AddressBean
    Returns     : List of HomeBaseBeans.TaxIds
    **********************************************************************/    
    // Invoking validate address webservice.
    public List<HomeBaseBeans.TaxIds> taxIdLookup(HomeBaseBeans.AddressBean address){
    	system.debug(LoggingLevel.DEBUG,'Entering ValidateAddressService_AC:taxIdLookup:'+address);
    	system.debug('---address.state----'+address.state);
    	
    	/*if(address.state == ){
    		
    	}*/
    	String reqAddress=null;
    	ServiceProxy serviceProxy=null;
    	TaxClass taxIds;
    	List<HomeBaseBeans.TaxIds> HBList=null; 
        try{  
            reqAddress = prepareTaxIdLookupRequest(address);
            serviceProxy = new ServiceProxy();
               
	        if(!Test.isRunningTest()){        
	            validateAddressResponse = serviceProxy.callRestService('rest/api/v1/validate_address?company_id=1','POST',reqAddress);
	            //validateAddressResponse  = '{"taxIds": [{"taxAreaStatus": "NORMAL","country": "USA","countryDescription": "UNITED STATES","county": null,"state": "DC","stateDescription": "DISTRICT OF COLUMBIA","city": "WASHINGTON","id": "90010010"}]}';
	        }
	        if(validateAddressResponse!=null && !validateAddressResponse.contains('"errorCode"'))
			{
		        taxIds = (TaxClass)JSON.deserialize(validateAddressResponse, TaxClass.class);		        
			}
			else
			{
				HBList = new List<HomeBaseBeans.TaxIds>();
				HomeBaseBeans.TaxIds h = new HomeBaseBeans.TaxIds();
				String errorMessage = QuickQuoteErrorHandler.handleError(validateAddressResponse);				
				h.errorMessage = errorMessage;
				HBList.add(h);
			}
	    }
	    catch(Exception e)
	    {
	    	String errorMessage = e.getMessage();
			HBList = new List<HomeBaseBeans.TaxIds>();
			HomeBaseBeans.TaxIds h = new HomeBaseBeans.TaxIds();
			h.errorMessage = errorMessage;
			HBList.add(h);
			system.debug(LoggingLevel.ERROR,'Error while getting values from ValidateAddressService_AC taxIdLookup'+e.getMessage());
			return HBList;
	    }
	     if(HBList!=null && !HBList.isEmpty()){
	    	system.debug(LoggingLevel.DEBUG,'Exiting ValidateAddressService_AC:taxIdLookup:'+HBList);
	        return HBList;
	    }else{
	    	system.debug(LoggingLevel.DEBUG,'Exiting ValidateAddressService_AC:taxIdLookup:'+taxIds.TaxIds);
	    	return taxIds.TaxIds;
	    }
    }
    
    /*********************************************************************
    Purpose     : private mathod to create descarte webservice request
    Parameters  : HomeBaseBeans.AddressBean
    Returns     : string in  JSON format
    **********************************************************************/ 
    private String prepareDescartesLookupRequest(HomeBaseBeans.AddressBean address){ 
		     
		     if(address.county==null){
		     	address.county='';
		     }
		     if(address.fulfillingId == null){
		     	address.fulfillingId = '';
		     }
		     NewAddressPayLoad addVali =  new NewAddressPayLoad();
		     
		    if(address.street != null && address.street != ''){
		    	addVali.address1 = address.street;
		    }else{
		    	addVali.address1 = '';
		    }
		    
		    if(address.city != null && address.city != ''){
		    	addVali.address3 = address.city;
		    }else{
		    	addVali.address3 = '';
		    }
		    
		    if(address.county != null && address.county != ''){
		    	addVali.address4 = address.county;
		    }else{
		    	addVali.address4 = '';
		    }
		    if(address.state != null && address.state != ''){
		    	addVali.state = address.state;
		    }else{
		    	addVali.state = '';
		    }
		    if(address.crossStreet != null && address.crossStreet != ''){
		    	addVali.crossStreet1 = address.crossStreet;
		    }else{
		    	addVali.crossStreet1 = '';
		    }
		    if(address.zip != null && address.zip != ''){
		    	addVali.zipCode = address.zip;
		    }else{
		    	addVali.zipCode = '';
		    }
		    if(address.country != null && address.country != ''){
		    	addVali.countryId = address.country;
		    }else{
		    	addVali.countryId = '';
		    }
		    
		    if(address.fulfillingId != null && address.fulfillingId != ''){
		    	addVali.fulfillingBranchId = address.fulfillingId;
		    }else{
		    	addVali.fulfillingBranchId = '';
		    }
		    
        	return JSON.serialize(addVali); 
        return '{"address1": "'+address.street+'", "address2": "", "address3": "'+ address.city +'", "address4": "'+address.county+'","state": "'+address.state+'", "crossStreet1": "'+address.crossStreet+'", "fulfillingBranchId": "'+address.fulfillingId+'", "zipCode": "'+address.zip+'", "countryId": "'+address.country+'"}';
                    
    }
    
     private String prepareDescartesLookupRequestFullQuote(HomeBaseBeans.AddressBean address){
		     
		     if(address.county==null){
		     	address.county='';
		     }
		     if(address.fulfillingId == null){
		     	address.fulfillingId = '';
		     	address.fulfillingName = '';
		     }
		     
		      NewAddressPayLoad addVali =  new NewAddressPayLoad();
		    
		    if(address.street != null && address.street != ''){
		    	addVali.address1 = address.street;
		    }else{
		    	addVali.address1 = '';
		    }
		    
		    if(address.city != null && address.city != ''){
		    	addVali.address3 = address.city;
		    }else{
		    	addVali.address3 = '';
		    }
		    
		    if(address.county != null && address.county != ''){
		    	addVali.address4 = address.county;
		    }else{
		    	addVali.address4 = '';
		    }
		    if(address.state != null && address.state != ''){
		    	addVali.state = address.state;
		    }else{
		    	addVali.state = '';
		    }
		    if(address.crossStreet != null && address.crossStreet != ''){
		    	addVali.crossStreet1 = address.crossStreet;
		    }else{
		    	addVali.crossStreet1 = '';
		    }
		    if(address.zip != null && address.zip != ''){
		    	addVali.zipCode = address.zip;
		    }else{
		    	addVali.zipCode = '';
		    }
		    if(address.country != null && address.country != ''){
		    	addVali.countryId = address.country;
		    }else{
		    	addVali.countryId = '';
		    }
		    
		    if(address.fulfillingId != null && address.fulfillingId != ''){
		    	addVali.fulfillingBranchId = address.fulfillingId;
		    }else{
		    	addVali.fulfillingBranchId = '';
		    }
		    
		    if(address.fulfillingName != null && address.fulfillingName != ''){
		    	addVali.fulfillingBranchName = address.fulfillingName;
		    }else{
		    	addVali.fulfillingBranchName = '';
		    }
		    
		    return JSON.serialize(addVali); 
		     
       // return '{"address1": "'+address.street+'", "address2": "", "address3": "'+ address.city +'", "address4": "'+address.county+'","state": "'+address.state+'", "crossStreet1": "'+address.crossStreet+'", "fulfillingBranchId": "'+address.fulfillingId+'","fulfillingBranchName": "'+address.fulfillingName+'", "zipCode": "'+address.zip+'", "countryId": "'+address.country+'"}';
        //return '{"address1": "'+address.street+'", "address2": "", "address3": "'+ address.city +'", "address4": "'+address.county+'","state": "'+address.state+'", "crossStreet1": "'+address.crossStreet+'", "zipCode": "'+address.zip+'", "countryId": "'+address.country+'"}';
                    
    }
    /*********************************************************************
    Purpose     : private mathod to create Tax id webservice request
    Parameters  : HomeBaseBeans.AddressBean
    Returns     : string in  JSON format
    **********************************************************************/ 
    private String prepareTaxIdLookupRequest(HomeBaseBeans.AddressBean address){
    	
    	
    	


			if(address.county==null){
		     	address.county='';
		     }
		     if(address.fulfillingId == null){
		     	address.fulfillingId = '';
		     }
		     NewAddressPayLoad addVali =  new NewAddressPayLoad();
		    
		    if(address.street != null && address.street != ''){
		    	addVali.address1 = address.street;
		    }else{
		    	addVali.address1 = '';
		    }
		    
		    if(address.city != null && address.city != ''){
		    	addVali.address3 = address.city;
		    }else{
		    	addVali.address3 = '';
		    }
		    
		    if(address.county != null && address.county != ''){
		    	addVali.address4 = address.county;
		    }else{
		    	addVali.address4 = '';
		    }
		    if(address.state != null && address.state != ''){
		    	addVali.state = address.state;
		    }else{
		    	addVali.state = '';
		    }
		    if(address.crossStreet != null && address.crossStreet != ''){
		    	addVali.crossStreet1 = address.crossStreet;
		    }else{
		    	addVali.crossStreet1 = '';
		    }
		    if(address.zip != null && address.zip != ''){
		    	addVali.zipCode = address.zip;
		    }else{
		    	addVali.zipCode = '';
		    }
		    if(address.country != null && address.country != ''){
		    	addVali.countryId = address.country;
		    }else{
		    	addVali.countryId = '';
		    }
		    
		    if(address.fulfillingId != null && address.fulfillingId != ''){
		    	addVali.fulfillingBranchId = address.fulfillingId;
		    }else{
		    	addVali.fulfillingBranchId = '';
		    }
		    
		    return JSON.serialize(addVali); 
     	/*if(address.county != null){
     		return '{"address1": "'+address.street+'", "address2": "", "address3": "'+ address.city +'", "address4": "'+address.county+'", "state": "'+address.state+'", "zipCode": "'+address.zip+'", "countryId": "'+address.country+'"}';		
     	}else{
     		return '{"address1": "'+address.street+'", "address2": "", "address3": "'+ address.city +'", "address4": "", "state": "'+address.state+'", "zipCode": "'+address.zip+'", "countryId": "'+address.country+'"}';	
     	}*/
        
    } 
    public class NewAddressPayLoad {
        String address1;
		String address2;
		String address3;
		String address4;
		String state;
		String crossStreet1;
		String fulfillingBranchId;
		String fulfillingBranchName;
		String zipCode;
		String countryId;
     	}
        
    /*********************************************************************
    Purpose     : This is inner class to initializing and holding after 
                  JSON parsing
    Parameters  : none
    Returns     : none
    **********************************************************************/
    public class TaxClass
    {
         public HomeBaseBeans.TaxIds[] TaxIds;
         public TaxClass()
         {
             this.TaxIds = new List<HomeBaseBeans.TaxIds>();
         }
    }
    /*********************************************************************
    Purpose     : This is inner class to initializing and holding after 
                  JSON parsing
    Parameters  : none
    Returns     : none
    **********************************************************************/
    public class DescartesAddress
    {
        public HomeBaseBeans.webAddresses[] webAddresses; 
        public DescartesAddress()
        {
            webAddresses = new List<HomeBaseBeans.webAddresses>();
        }
    } 
        
}