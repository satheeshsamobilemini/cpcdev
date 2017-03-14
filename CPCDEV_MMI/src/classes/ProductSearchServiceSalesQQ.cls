/**************************************************************************
Name:  ProductSearchServiceSalesQQ()
Copyright © 2013  MMI
----------------------------------------------------------------------
Purpose:
This class contains the methods for sales Product List and search Service HTTP Rest 
web service Callouts 
-----------------------------------------------------------------------
History:

VERSION  AUTHOR                 DATE        DETAIL              
1.0  -  TEKsystems             11/2/2013   INITIAL DEVELOPMENT  
**************************************************************************/
public with sharing class ProductSearchServiceSalesQQ
{ 
	public String primaryProductResponse {get;set;}
	public String searchProductsResponse {get;set;}
	public String singleProductResponse {get;set;}
	
    public String salesProductResponse {get;set;}
	public String searchSalesProductsResponse {get;set;}
	public String singleSalesProductResponse {get;set;}
	
    /*********************************************************************
    Purpose     : To get the list of Primary Products
    Parameters  : user branch id 
    Returns     : List of HomeBaseBeans.Products
    **********************************************************************/    
    public List<HomeBaseBeans.Products> listPrimaryProducts(String branchId){
    	system.debug(LoggingLevel.DEBUG,'Entering ProductSearchServiceSalesQQ:listPrimaryProducts:'+branchId);
        ServiceProxy serviceProxy = null;
        List<HomeBaseBeans.Products> HBList=null;
        PrimaryProducts primaryProducts=null;
        try{
        	if(branchId!=null){ 
                 serviceProxy = new ServiceProxy(); 
		        if(!Test.isRunningTest()){ 
		            primaryProductResponse = serviceProxy.callRestService('rest/api/v1/companies/1/products?branch_id='+branchId+'&primary_only=true&sale_only=true&limit=300','GET','');
		        }
		
		        if( primaryProductResponse!=null && !primaryProductResponse.contains('"errorCode"'))
				{
			        primaryProducts = (PrimaryProducts)JSON.deserialize(primaryProductResponse, ProductSearchService_AC.PrimaryProducts.class);
				}else{
					HBList = new List<HomeBaseBeans.Products>();
					HomeBaseBeans.Products h = new HomeBaseBeans.Products();
					String errorMessage = QuickQuoteErrorHandler.handleError(primaryProductResponse);
					h.errorMessage = errorMessage;
					HBList.add(h);
			    }
	        }
        } catch(Exception e){
	    	String errorMessage = e.getMessage();
			HBList = new List<HomeBaseBeans.Products>();
			HomeBaseBeans.Products h = new HomeBaseBeans.Products();
			h.errorMessage = errorMessage;
			HBList.add(h);
			return HBList;
	    }
	    if(HBList!=null && !HBList.isEmpty()){
	    	system.debug(LoggingLevel.DEBUG,'Exiting ProductSearchServiceSalesQQ:listPrimaryProducts:'+HBList);
	        return HBList;
	    }else{
	    	system.debug(LoggingLevel.DEBUG,'Exiting ProductSearchServiceSalesQQ:listPrimaryProducts:'+primaryProducts.products);
	    	return primaryProducts.products;
	    }
    }
    
    
    /*********************************************************************
    Purpose     : To get the list of  Products from search result
    Parameters  : user branch id and HomeBaseBeans.ProductSearch wrapper
    Returns     : List of HomeBaseBeans.Products
    **********************************************************************/   
    public List<HomeBaseBeans.Products> searchProduct(HomeBaseBeans.ProductSearch searchProduct , String branchId)
    {
    	system.debug(LoggingLevel.DEBUG,'Entering ProductSearchServiceSalesQQ:searchProduct:'+branchId+'--' + searchProduct);
    	List<HomeBaseBeans.Products> HBList=null;
        ServiceProxy serviceProxy = null;
        PrimaryProducts searchProducts =null;
        
        try{ 
        	serviceProxy = new ServiceProxy();
	        if(!Test.isRunningTest()) {
		        if(searchProduct.defId != '-None-' && searchProduct.minsize !=null && searchProduct.maxsize !=null)
		        {  
		            searchProductsResponse = serviceProxy.callRestService('rest/api/v1/companies/1/products?branch_id='+branchId+'&pattern='+searchProduct.pattern+'&definition_id='+searchProduct.defId+'&primary_only='+searchProduct.primaryOnly+'&min_size='+searchProduct.minsize+'&max_size='+searchProduct.maxsize+'&sale_only=true&limit=300','GET','');
		        }else if(searchProduct.maxsize ==null){
		        	searchProductsResponse = serviceProxy.callRestService('rest/api/v1/companies/1/products?branch_id='+branchId+'&pattern='+searchProduct.pattern+'&definition_id='+searchProduct.defId+'&primary_only='+searchProduct.primaryOnly+'&min_size='+searchProduct.minsize+'&sale_only=true&limit=300','GET','');
		        }
		        else
		        {
		            searchProductsResponse = serviceProxy.callRestService('rest/api/v1/companies/1/products?branch_id='+branchId+'&pattern='+searchProduct.pattern+'&sale_only=true&primary_only='+searchProduct.primaryOnly,'GET','');
		        }
	        }
	        if(searchProductsResponse !=null && !searchProductsResponse.contains('"errorCode"'))
			{
		       searchProducts = (PrimaryProducts)JSON.deserialize(searchProductsResponse, ProductSearchService_AC.PrimaryProducts.class);

			}else{
				HBList = new List<HomeBaseBeans.Products>();
				HomeBaseBeans.Products h = new HomeBaseBeans.Products();
				String errorMessage = QuickQuoteErrorHandler.handleError(searchProductsResponse);				
				h.errorMessage = errorMessage;
				HBList.add(h);
		    }
        }
        catch(Exception e)
        {
        	HBList = new List<HomeBaseBeans.Products>();
			HomeBaseBeans.Products h = new HomeBaseBeans.Products();
			h.errorMessage = 'Internal Server Error';
			HBList.add(h);
			return HBList;
        }
        if(HBList!=null && !HBList.isEmpty()){
	    	system.debug(LoggingLevel.DEBUG,'Exiting ProductSearchServiceSalesQQ:searchProduct:'+HBList);
	        return HBList;
	    }else{
	    	system.debug(LoggingLevel.DEBUG,'Exiting ProductSearchServiceSalesQQ:searchProduct:'+searchProducts.products);
	    	 return searchProducts.products;
	    }
    }
    
   
     /*********************************************************************
    Purpose     : To get the single Products
    Parameters  : user branch id 
    Returns     : List of HomeBaseBeans.Products
    **********************************************************************/    
    public HomeBaseBeans.Products getSpecificProducts(String productId,String branchId){
    	system.debug(LoggingLevel.DEBUG,'Entering ProductSearchServiceSalesQQ:getSpecificProducts:'+productId+branchId);
        ServiceProxy serviceProxy = null;
        HomeBaseBeans.Products HBproduct=null;
        SpecificProduct specificProducts=null;
        try{
        	if(branchId!=null){ 
                 serviceProxy = new ServiceProxy(); 
		        if(!Test.isRunningTest()){ 
		            singleProductResponse = serviceProxy.callRestService('rest/api/v1/companies/1/products/'+productId+'?branch_id='+branchId+'&primary_only=true&sale_only=true&limit=300','GET','');
		        }
		
		        if( singleProductResponse!=null && !singleProductResponse.contains('"errorCode"'))
				{
			        specificProducts = (SpecificProduct)JSON.deserialize(singleProductResponse, ProductSearchService_AC.SpecificProduct.class);
			        system.debug('##########'+specificProducts);
				}else{
				
					HomeBaseBeans.Products h = new HomeBaseBeans.Products();
					String errorMessage = QuickQuoteErrorHandler.handleError(singleProductResponse);
					h.errorMessage = errorMessage;
					HBproduct=h;
			    }
	        }
        } catch(Exception e){
	    	String errorMessage = e.getMessage();
			HomeBaseBeans.Products h = new HomeBaseBeans.Products();
			h.errorMessage = errorMessage;
			HBproduct=h;
	    }
	    if(HBproduct!=null){
	    	system.debug(LoggingLevel.DEBUG,'Exiting ProductSearchServiceSalesQQ:getSpecificProducts:'+HBproduct);
	        return HBproduct;
	    }else{
	    	system.debug(LoggingLevel.DEBUG,'Exiting ProductSearchServiceSalesQQ:getSpecificProducts:'+specificProducts.product);
	        return specificProducts.product;
	    }
	    
    }
    

    /*********************************************************************
    Purpose     : This is inner class to initializing and holding after 
                  JSON parsing of Primary products
    Parameters  : none
    Returns     : none
    **********************************************************************/
     public class PrimaryProducts {
        
        public String totalResults ;
        public String nextLink ;
        public String prevLink ;
        public String firstLink ;
        public String lastLink ;
        public HomeBaseBeans.Products[] products ;
        public PrimaryProducts(String tr, String nl,String pl, String fl,String ll) {
                
                this.totalResults = tr;
                this.nextLink = nl;
                this.prevLink = pl;
                this.firstLink = fl;
                this.lastLink = ll;
                this.products = new List<HomeBaseBeans.Products>();
        }
    } 
    
    public class SpecificProduct {
    	 public HomeBaseBeans.Products product{get;set;} 
    }
    
    
}