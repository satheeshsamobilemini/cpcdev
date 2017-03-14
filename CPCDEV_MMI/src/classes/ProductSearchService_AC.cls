/**************************************************************************
Name:  ProductSearchService_AC()
Copyright © 2013  MMI
----------------------------------------------------------------------
Purpose:
This class contains the methods for Product List and search Service HTTP Rest 
web service Callouts 
-----------------------------------------------------------------------
History:

VERSION  AUTHOR                 DATE        DETAIL              
1.0  -  TEKsystems             11/2/2013   INITIAL DEVELOPMENT  
**************************************************************************/
public with sharing class ProductSearchService_AC
{ 
	public String primaryProductResponse {get;set;}
	public String searchProductsResponse {get;set;}
	public String singleProductResponse {get;set;}
	
    /*********************************************************************
    Purpose     : To get the list of Primary Products
    Parameters  : user branch id 
    Returns     : List of HomeBaseBeans.Products
    **********************************************************************/    
    public List<HomeBaseBeans.Products> listPrimaryProducts(String branchId){
    	system.debug(LoggingLevel.DEBUG,'Entering ProductSearchService_AC:listPrimaryProducts:'+branchId);
        ServiceProxy serviceProxy = null;
        List<HomeBaseBeans.Products> HBList=null;
        PrimaryProducts primaryProducts=null;
        try{
        	if(branchId!=null){ 
                 serviceProxy = new ServiceProxy(); 
		        if(!Test.isRunningTest()){ 
		            primaryProductResponse = serviceProxy.callRestService('rest/api/v1/companies/1/products?branch_id='+branchId+'&primary_only=true&limit=300','GET','');
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
	    	system.debug(LoggingLevel.DEBUG,'Exiting ProductSearchService_AC:listPrimaryProducts:'+HBList);
	        return HBList;
	    }else{
	    	system.debug(LoggingLevel.DEBUG,'Exiting ProductSearchService_AC:listPrimaryProducts:'+primaryProducts.products);
	    	return primaryProducts.products;
	    }
    }
    
    
    /*********************************************************************
    Purpose     : To get the list of Products based on transaction type
    Parameters  : user branch id 
    Returns     : List of HomeBaseBeans.Products
    **********************************************************************/    
    public List<HomeBaseBeans.Products> listProductsBasedOnTransactionType(String branchId, String TransactionType, String QuoteType){
    	system.debug(LoggingLevel.DEBUG,'Entering ProductSearchService_AC:listPrimaryProducts:'+branchId);
        ServiceProxy serviceProxy = null;
        List<HomeBaseBeans.Products> HBList=null;
        PrimaryProducts primaryProducts=null;
        try{
        	if(branchId!=null){ 
                 serviceProxy = new ServiceProxy(); 
		        if(!Test.isRunningTest()){
		        	if(TransactionType != '' && TransactionType != null){
		        		if(QuoteType == 'sales'){
		        			primaryProductResponse = serviceProxy.callRestService('rest/api/v1/companies/1/products?branch_id='+branchId+'&transaction_id='+TransactionType+'&primary_only=true&sale_only=true&limit=300','GET','');
		        		}else{
		        			primaryProductResponse = serviceProxy.callRestService('rest/api/v1/companies/1/products?branch_id='+branchId+'&transaction_id='+TransactionType+'&primary_only=true&rental_only=true&limit=300','GET','');	
		        		}
		        	}else{ 
		            	if(QuoteType == 'sales'){
		        			primaryProductResponse = serviceProxy.callRestService('rest/api/v1/companies/1/products?branch_id='+branchId+'&primary_only=true&sale_only=true&limit=300','GET','');
		        		}else{
		        			primaryProductResponse = serviceProxy.callRestService('rest/api/v1/companies/1/products?branch_id='+branchId+'&primary_only=true&rental_only=true&limit=300','GET','');
		        		} 
		        	}
		        }
		
		        if( primaryProductResponse!=null && !primaryProductResponse.contains('"errorCode"'))
				{
			        primaryProducts = (PrimaryProducts)JSON.deserialize(primaryProductResponse, ProductSearchService_AC.PrimaryProducts.class);
			        if(primaryProducts.products != null){
				        for(HomeBaseBeans.Products p : primaryProducts.products){
				        	if(p.qtyWip1 != null && p.qtyWip1 != '' && p.qtyWip5 != null && p.qtyWip5 != '' &&  p.qtyWip2 != null && p.qtyWip2 != '' && p.qtyWip7 != null && p.qtyWip7 != ''){
				        		p.HILRM = String.valueOf(Decimal.valueOf(p.qtyWip1)+ Decimal.valueOf(p.qtyWip5));
				        		if(Decimal.valueOf(p.qtyTotal) > 0){
				           			Decimal UtilPercentInDecimal =  (Decimal.valueOf(p.qtyRented) / Decimal.valueOf(p.qtyTotal)) * 100;
					           		p.UtilPercent = String.valueOf(UtilPercentInDecimal.round(System.RoundingMode.HALF_EVEN));
				           		}else{
				           			p.UtilPercent = '';
				           		}
				           		if(p.Id == '20W' || p.Id == '20w'){
			        				system.debug('-------------p.qtyRented--------------------------'+p.qtyRented);
			        				system.debug('-------------p.qtyTotal--------------------------'+p.qtyTotal);
			        				system.debug('-------------p.UtilPercent--------------------------'+p.UtilPercent);
			        			}	
				        	}
					   		
					   }
			       }
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
	    	system.debug(LoggingLevel.DEBUG,'Exiting ProductSearchService_AC:listPrimaryProducts:'+HBList);
	        return HBList;
	    }else{
	    	system.debug(LoggingLevel.DEBUG,'Exiting ProductSearchService_AC:listPrimaryProducts:'+primaryProducts.products);
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
    	system.debug(LoggingLevel.DEBUG,'Entering ProductSearchService_AC:searchProduct:'+branchId+'--' + searchProduct);
    	List<HomeBaseBeans.Products> HBList=null;
        ServiceProxy serviceProxy = null;
        PrimaryProducts searchProducts =null;
        
        try{ 
        	serviceProxy = new ServiceProxy();
	        	String rentalOrSalesOnly = '';
		          if(searchProduct.QuoteType == 'sales'){
		           //rentalOrSalesOnly = '&sale_only=true';
		          }else{
		           rentalOrSalesOnly = '&rental_only=true';
		          }
		          String RequestUrl = 'rest/api/v1/companies/1/products?branch_id='+branchId;
		          if((searchProduct.pattern == '' || searchProduct.pattern == null) && searchProduct.primaryOnly == false){
		           	RequestUrl += '&primary_only=true';
		          }else if((searchProduct.pattern == '' || searchProduct.pattern == null) && searchProduct.primaryOnly == true){
		          	RequestUrl += '&primary_only=true';
		          }
		          else if(searchProduct.pattern != '' && searchProduct.pattern != null && searchProduct.primaryOnly == false){
		          	RequestUrl += '&pattern='+searchProduct.pattern;
		          }
		          else if(searchProduct.pattern != '' && searchProduct.pattern != null && searchProduct.primaryOnly == true){
		          	RequestUrl += '&primary_only=true';
		          	RequestUrl += '&pattern='+searchProduct.pattern;
		          }
		          
		          if(searchProduct.defId!='' && searchProduct.defId!=null){
		           RequestUrl += '&definition_id='+searchProduct.defId;
		          }
		          /*if(searchProduct.primaryOnly){
		          	if(searchProduct.QuoteType != 'sales' && searchProduct.pattern!='' && searchProduct.pattern!=null){
		           		RequestUrl += '&primary_only='+searchProduct.primaryOnly;
		          	}
		          }*/
		          if(searchProduct.minsize > 0){
		           RequestUrl += '&min_size='+searchProduct.minsize;
		          }
		          if(searchProduct.maxsize > 0){
		           RequestUrl += '&max_size='+searchProduct.maxsize;
		          }
		          
		          RequestUrl += rentalOrSalesOnly+'&limit=300';
		          
	        if(!Test.isRunningTest()) {
	        	
		          searchProductsResponse = serviceProxy.callRestService(RequestUrl,'GET','');
	        }
	        if(searchProductsResponse !=null && !searchProductsResponse.contains('"errorCode"'))
			{
		        searchProducts = (PrimaryProducts)JSON.deserialize(searchProductsResponse, ProductSearchService_AC.PrimaryProducts.class);
				system.debug('--------------searchProducts----------------'+searchProducts);
				if(searchProducts.products == null){
					return searchProducts.products;
				}else{
					for(HomeBaseBeans.Products p : searchProducts.products){
				   		p.HILRM = String.valueOf(Decimal.valueOf(p.qtyWip1)+ Decimal.valueOf(p.qtyWip5));
				   		if(Decimal.valueOf(p.qtyTotal) > 0){
				           	Decimal UtilPercentInDecimal =  (Decimal.valueOf(p.qtyRented) / Decimal.valueOf(p.qtyTotal)) * 100;
			           		p.UtilPercent = String.valueOf(UtilPercentInDecimal.round(System.RoundingMode.HALF_EVEN));
			           }else{
			           		p.UtilPercent = '';
			           }
				   }
				}
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
	    	system.debug(LoggingLevel.DEBUG,'Exiting ProductSearchService_AC:searchProduct:'+HBList);
	        return HBList;
	    }else{
	    	system.debug(LoggingLevel.DEBUG,'Exiting ProductSearchService_AC:searchProduct:'+searchProducts.products);
	    	 return searchProducts.products;
	    }
    }
    
    /*********************************************************************
    Purpose     : To get the list of  Products from search result
    Parameters  : user branch id and HomeBaseBeans.ProductSearch wrapper
    Returns     : List of HomeBaseBeans.Products
    **********************************************************************/   
    public List<HomeBaseBeans.Products> searchProductForFQ(HomeBaseBeans.ProductSearch searchProduct , String branchId, String deliverySetUp, String returnTeardown)
    {
    	system.debug(LoggingLevel.DEBUG,'Entering ProductSearchService_AC:searchProductForFQ:'+branchId+'--' + searchProduct);
    	List<HomeBaseBeans.Products> HBList=null;
        ServiceProxy serviceProxy = null;
        PrimaryProducts searchProducts =null;
        
        try{ 
        	serviceProxy = new ServiceProxy();
		          String RequestUrl = 'rest/api/v1/companies/1/products?branch_id='+branchId;
		          if((searchProduct.pattern == '' || searchProduct.pattern == null) && searchProduct.primaryOnly == false){
		           	RequestUrl += '&primary_only=true';
		          }else if((searchProduct.pattern == '' || searchProduct.pattern == null) && searchProduct.primaryOnly == true){
		          	RequestUrl += '&primary_only=true';
		          }
		          else if(searchProduct.pattern != '' && searchProduct.pattern != null && searchProduct.primaryOnly == false){
		          	RequestUrl += '&pattern='+searchProduct.pattern;
		          }
		          else if(searchProduct.pattern != '' && searchProduct.pattern != null && searchProduct.primaryOnly == true){
		          	RequestUrl += '&primary_only=true';
		          	RequestUrl += '&pattern='+searchProduct.pattern;
		          }
		          
		          if(searchProduct.defId!='' && searchProduct.defId!=null){
		           RequestUrl += '&definition_id='+searchProduct.defId;
		          }
		          /*if(searchProduct.primaryOnly){
		          	if(searchProduct.QuoteType != 'sales' && searchProduct.pattern!='' && searchProduct.pattern!=null){
		           		RequestUrl += '&primary_only='+searchProduct.primaryOnly;
		          	}
		          }*/
		          if(searchProduct.minsize > 0){
		           RequestUrl += '&min_size='+searchProduct.minsize;
		          }
		          if(searchProduct.maxsize > 0){
		           RequestUrl += '&max_size='+searchProduct.maxsize;
		          }
		          
		          if(deliverySetUp != null && deliverySetUp != ''){
		          	RequestUrl += '&extra_criteria_1='+deliverySetUp;
		          }else if(returnTeardown != null && returnTeardown != ''){
		          	RequestUrl += '&extra_criteria_1='+returnTeardown;
		          }
		          
		          RequestUrl += '&limit=300';
		          
	        if(!Test.isRunningTest()) {
	        	
		          searchProductsResponse = serviceProxy.callRestService(RequestUrl,'GET','');
	        }
	        if(searchProductsResponse !=null && !searchProductsResponse.contains('"errorCode"'))
			{
		        searchProducts = (PrimaryProducts)JSON.deserialize(searchProductsResponse, ProductSearchService_AC.PrimaryProducts.class);
				system.debug('--------------searchProducts----------------'+searchProducts);
				if(searchProducts.products == null){
					return searchProducts.products;
				}else{
					for(HomeBaseBeans.Products p : searchProducts.products){
				   		p.HILRM = String.valueOf(Decimal.valueOf(p.qtyWip1)+ Decimal.valueOf(p.qtyWip5));
				   		if(Decimal.valueOf(p.qtyTotal) > 0){
				           	Decimal UtilPercentInDecimal =  (Decimal.valueOf(p.qtyRented) / Decimal.valueOf(p.qtyTotal)) * 100;
			           		p.UtilPercent = String.valueOf(UtilPercentInDecimal.round(System.RoundingMode.HALF_EVEN));
			           }else{
			           		p.UtilPercent = '';
			           }
				   }
				}
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
	    	system.debug(LoggingLevel.DEBUG,'Exiting ProductSearchService_AC:searchProductForFQ:'+HBList);
	        return HBList;
	    }else{
	    	system.debug(LoggingLevel.DEBUG,'Exiting ProductSearchService_AC:searchProductForFQ:'+searchProducts.products);
	    	 return searchProducts.products;
	    }
    }
    
   
     /*********************************************************************
    Purpose     : To get the single Products
    Parameters  : user branch id 
    Returns     : List of HomeBaseBeans.Products
    **********************************************************************/    
    public HomeBaseBeans.Products getSpecificProducts(String productId,String branchId){
    	system.debug(LoggingLevel.DEBUG,'Entering ProductSearchService_AC:getSpecificProducts:'+productId+branchId);
        ServiceProxy serviceProxy = null;
        HomeBaseBeans.Products HBproduct=null;
        SpecificProduct specificProducts=null;
        try{
        	if(branchId!=null){ 
                 serviceProxy = new ServiceProxy(); 
		        if(!Test.isRunningTest()){ 
		            singleProductResponse = serviceProxy.callRestService('rest/api/v1/companies/1/products/'+productId+'?branch_id='+branchId+'&primary_only=true&limit=300','GET','');
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
	    	system.debug(LoggingLevel.DEBUG,'Exiting ProductSearchService_AC:getSpecificProducts:'+HBproduct);
	        return HBproduct;
	    }else{
	    	system.debug(LoggingLevel.DEBUG,'Exiting ProductSearchService_AC:getSpecificProducts:'+specificProducts.product);
	        return specificProducts.product;
	    }
	    
    }
    
    
     /*********************************************************************
    Purpose     : To get the list of Primary Products
    Parameters  : user branch id 
    Returns     : List of HomeBaseBeans.Products
    **********************************************************************/    
    public List<HomeBaseBeans.Products> listSalesProducts(String branchId){
    	system.debug(LoggingLevel.DEBUG,'Entering ProductSearchServiceSalesQQ:listSalesProducts:'+branchId);
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
	    	system.debug(LoggingLevel.DEBUG,'Exiting ProductSearchServiceSalesQQ:listSalesProducts:'+HBList);
	        return HBList;
	    }else{
	    	system.debug(LoggingLevel.DEBUG,'Exiting ProductSearchServiceSalesQQ:listSalesProducts:'+primaryProducts.products);
	    	return primaryProducts.products;
	    }
    }
    
    
    
     /*********************************************************************
    Purpose     : To get the list of  Products from search result
    Parameters  : user branch id and HomeBaseBeans.ProductSearch wrapper
    Returns     : List of HomeBaseBeans.Products
    **********************************************************************/   
    public List<HomeBaseBeans.Products> searchSalesProduct(HomeBaseBeans.ProductSearch searchProduct , String branchId)
    {
    	system.debug(LoggingLevel.DEBUG,'Entering ProductSearchService_AC:searchSalesProduct:'+branchId+'--' + searchProduct);
    	List<HomeBaseBeans.Products> HBList=null;
        ServiceProxy serviceProxy = null;
        PrimaryProducts searchProducts =null;
        
        try{ 
        	serviceProxy = new ServiceProxy();
	        if(!Test.isRunningTest()) {
		        if(searchProduct.pattern!='' && searchProduct.pattern!=null && searchProduct.defId != null && searchProduct.minsize !=null && searchProduct.maxsize !=null)
		        {  
		            searchProductsResponse = serviceProxy.callRestService('rest/api/v1/companies/1/products?branch_id='+branchId+'&pattern='+searchProduct.pattern+'&definition_id='+searchProduct.defId+'&primary_only='+searchProduct.primaryOnly+'&min_size='+searchProduct.minsize+'&max_size='+searchProduct.maxsize+'&sale_only=true&limit=300','GET','');
		        }
		        else if(searchProduct.pattern=='' && searchProduct.defId != null && searchProduct.minsize !=null && searchProduct.maxsize !=null)
		        {  
		            searchProductsResponse = serviceProxy.callRestService('rest/api/v1/companies/1/products?branch_id='+branchId+'&definition_id='+searchProduct.defId+'&primary_only='+searchProduct.primaryOnly+'&min_size='+searchProduct.minsize+'&max_size='+searchProduct.maxsize+'&sale_only=true&limit=300','GET','');
		        }else if(searchProduct.pattern=='' && searchProduct.defId != null && searchProduct.maxsize ==null && searchProduct.minsize !=null){
		        	searchProductsResponse = serviceProxy.callRestService('rest/api/v1/companies/1/products?branch_id='+branchId+'&definition_id='+searchProduct.defId+'&primary_only='+searchProduct.primaryOnly+'&min_size='+searchProduct.minsize+'&sale_only=true&limit=300','GET','');
		        }
		        else if(searchProduct.pattern=='' && searchProduct.defId == null && searchProduct.minsize !=null && searchProduct.maxsize !=null)
		        {  
		            searchProductsResponse = serviceProxy.callRestService('rest/api/v1/companies/1/products?branch_id='+branchId+'&primary_only='+searchProduct.primaryOnly+'&min_size='+searchProduct.minsize+'&max_size='+searchProduct.maxsize+'&sale_only=true&limit=300','GET','');
		        }else if(searchProduct.pattern=='' && searchProduct.defId == null && searchProduct.maxsize ==null && searchProduct.minsize !=null){
		        	searchProductsResponse = serviceProxy.callRestService('rest/api/v1/companies/1/products?branch_id='+branchId+'&primary_only='+searchProduct.primaryOnly+'&min_size='+searchProduct.minsize+'&sale_only=true&limit=300','GET','');
		        } else if(searchProduct.pattern=='' && searchProduct.defId != null &&  searchProduct.maxsize ==null && searchProduct.minsize ==null){
		        	searchProductsResponse = serviceProxy.callRestService('rest/api/v1/companies/1/products?branch_id='+branchId+'&definition_id='+searchProduct.defId+'&primary_only='+searchProduct.primaryOnly+'&sale_only=true&limit=300','GET','');
		        } 
		        else
		        {
		            searchProductsResponse = serviceProxy.callRestService('rest/api/v1/companies/1/products?branch_id='+branchId+'&pattern='+searchProduct.pattern+'&primary_only='+searchProduct.primaryOnly,'GET','');
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
	    	system.debug(LoggingLevel.DEBUG,'Exiting ProductSearchService_AC:searchSalesProduct:'+HBList);
	        return HBList;
	    }else{
	    	system.debug(LoggingLevel.DEBUG,'Exiting ProductSearchService_AC:searchSalesProduct:'+searchProducts.products);
	    	 return searchProducts.products;
	    }
    }
    
    /*********************************************************************
    Purpose     : To get the single Products
    Parameters  : user branch id 
    Returns     : List of HomeBaseBeans.Products
    **********************************************************************/    
    public HomeBaseBeans.Products getSpecificSalesProducts(String productId,String branchId){
    	system.debug(LoggingLevel.DEBUG,'Entering ProductSearchService_AC:getSpecificSalesProducts:'+productId+branchId);
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
	    	system.debug(LoggingLevel.DEBUG,'Exiting ProductSearchService_AC:getSpecificSalesProducts:'+HBproduct);
	        return HBproduct;
	    }else{
	    	system.debug(LoggingLevel.DEBUG,'Exiting ProductSearchService_AC:getSpecificSalesProducts:'+specificProducts.product);
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