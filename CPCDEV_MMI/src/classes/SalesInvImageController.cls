public with sharing class SalesInvImageController {
	
	public transient String ImageUrl{get;set;}
	
	public  SalesInvImageController(){
		String imageId=System.currentPageReference().getParameters().get('recId') ; 
		system.debug('#########1'+imageId); 
		List<SalesInventoryImages__c> salesInv= [select Id,Display_Picture__c,HB_Sales_Inventory__c from SalesInventoryImages__c where Id=:imageId];
		system.debug('#########2'+salesInv); 
		SaleInventoryImageService  si=new SaleInventoryImageService();
		String saleImage=salesInv[0].Display_Picture__c;
		system.debug('#########3'+saleImage);
	    		if(saleImage!=null && saleImage!=''){
		    			   
		    			   String uuid=saleImage.substring(saleImage.indexOf('uuid=')+5);
		    			   String SecToken=saleImage.substring(saleImage.indexOf('securitytoken=')+14);
		    			   system.debug('####uuid#####'+uuid); 
		    			   system.debug('#####SecToken####'+SecToken); 
		    			   //uuid = '91b6ca16-a5f2-40ec-8786-7e72568e57c9';
		    			   //SecToken = '1377706785492';
		    			   blob img=si.callEditWEbservice(uuid,SecToken);//fullQWrapper.ImageUrl = s1.displayPicture;
		    			   ImageUrl = EncodingUtil.base64Encode(img);
		    			   system.debug('#########'+ImageUrl); 
	     }
		
	}
	

}