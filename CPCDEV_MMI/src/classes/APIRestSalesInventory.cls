@RestResource(urlMapping='/SalesInventory/*')
global with sharing class APIRestSalesInventory {

     /*******************************************************************
    Purpose     : Post the request parameters to the webservice API 
    Parameters  :  
    Returns     : String 
    ********************************************************************/
    @HttpPost
   
    global static void doPost(String token ,String action,String companyNo,String subType, String fulfillingBranch , String itemCode ,String ecode, String referenceNo,String gradeCode,
                               String gradeDescription,String suggestedPrice ,String minimumPrice,String nbv, String area , String reasonCode,
                               Boolean blowOut, String notes, String status, Boolean populated, String[] dislayPictures) {
        system.debug(LoggingLevel.DEBUG,'Entring APIRestSalesInventory:doPost:');
        if(!test.isRunningTest()){
        RestContext.request.addHeader('Content-Type', 'application/json');
        RestContext.response.addHeader('Content-Type', 'application/json');
        }
        
        //String operation = RestContext.request.requestURI.substring( RestContext.request.requestURI.lastIndexOf('/')+1);
        system.debug('@@@@@@@@@token='+token+' companyNo='+companyNo+' subType='+subType+' fulfillingBranch='+fulfillingBranch+ ' itemCode='+itemCode+ ' ecode='+ ecode +' referenceNo='+referenceNo
                      +' gradeCode='+gradeCode+' gradeDescription='+gradeDescription+' suggestedPrice='+suggestedPrice+' minimumPrice='+minimumPrice+' nbv='+nbv+' area='+area+' reasonCode='+reasonCode
                      +' blowOut='+blowOut+' notes='+notes+' status='+status+' populated='+populated+' dislayPictures='+dislayPictures);
        
        List<String> responseList=new List<String> ();
        String response=null;
        Boolean isMatch=false;
        HB_Sales_Inventory__c hbInventory=null;
        List<HB_Sales_Inventory__c> hbInventoryToUpdate=null;
        //multiple images insertion
        List<SalesInventoryImages__c> salesInvLst=null;
        List<SalesInventoryImages__c> salesInvLstDelete=null;
        
        try {
               isMatch= validateTokenValue(token);
               if(isMatch){
                
                  if(action.equalsIgnoreCase('new')){
                  	
                  	System.debug('inserting new record');
                       List<HB_Sales_Inventory__c> hbInventoryUpdate=[select Id ,Name,Fulfilling_Branch_Code__c,Line_Item_ID__c,E_Code__c,Item_Reference__c,
                                                                   Grade_Code__c,Grade_Description__c,Suggested_Price__c,Minimum_Price__c,NBV__c,Area__c,
                                                                    Reason_Code__c,Blowout__c,Notes__c,Status__c,Populated__c,CompanyId__c,Display_Picture__c, (select Id,Display_Picture__c,HB_Sales_Inventory__c from SalesInventoryImages__r) From HB_Sales_Inventory__c where E_Code__c=:ecode ];  //and Display_Picture__c=:displayPic
                       
                        //List<SalesInventoryImages__c> displyImageList = hbInventoryUpdate[0].SalesInventoryImages__r;
                        
                    if(hbInventoryUpdate.isEmpty()){  
                        hbInventory=new HB_Sales_Inventory__c();
                        hbInventory.Fulfilling_Branch_Code__c=fulfillingBranch;
                        hbInventory.Line_Item_ID__c=itemCode;
                        hbInventory.E_Code__c=ecode;
                        hbInventory.Item_Reference__c=referenceNo;
                        hbInventory.Grade_Code__c=gradeCode; 
                        hbInventory.Grade_Description__c=gradeDescription;
                        if(suggestedPrice!='null' && suggestedPrice!=''){
                         hbInventory.Suggested_Price__c=Double.valueOf(suggestedPrice);
                        }else if(suggestedPrice.equalsIgnoreCase('null')){
                            hbInventory.Suggested_Price__c= decimal.valueOf('0');
                        }
                        if(minimumPrice!='null' && minimumPrice!=''){
                            hbInventory.Minimum_Price__c=Double.valueOf(minimumPrice);
                        }else if(minimumPrice == 'null'){
                            hbInventory.Minimum_Price__c = decimal.valueOf('0');
                        }
                        if(nbv!='null' && nbv!=''){
                            hbInventory.NBV__c=Double.valueOf(nbv);
                        }else if(nbv == 'null'){
                            hbInventory.NBV__c = decimal.valueOf('0');
                        }
                        
                        hbInventory.Area__c=area;
                        hbInventory.Reason_Code__c=reasonCode;
                        hbInventory.Blowout__c=blowOut;
                        hbInventory.Notes__c=notes;
                        hbInventory.Status__c=status;
                        hbInventory.Populated__c = populated;
                        hbInventory.CompanyId__c=companyNo;
                        //hbInventory.Display_Picture__c=dislayPictures;
    					system.debug('-----------hbInventoryToUpdate---------------'+hbInventory);
                        insert hbInventory;
                        
                        if(hbInventory.id!=null){
                        	 salesInvLst =new List<SalesInventoryImages__c>();
                        	 if(!dislayPictures.isEmpty()){
                        	 	for(String image:dislayPictures){
                        	 	 SalesInventoryImages__c sImage=new SalesInventoryImages__c();
                        	 	 sImage.Display_Picture__c=image;
                        	 	 sImage.HB_Sales_Inventory__c=hbInventory.id;
                        	 	 if(image!=null && image!=''){
                        	 	 salesInvLst.add(sImage);
                        	    }
                        	    }
                        	    
                        	    insert salesInvLst;
                        	 }
                        	 
                        }
                        

                        if(hbInventory.id!=null){
                            responseList.add('Your response is: success');
                        }else{
                             responseList.add('E0000');
                             responseList.add('Unable to insert Inventory in the system');
                        }
                    
                    }else{
                           responseList.add('E0003');
                           responseList.add('Inventory already exist');
                    }
                    
                  }else if(action.equalsIgnoreCase('update')){
                  	   System.debug('updating  record');
                      List<HB_Sales_Inventory__c> hbInventoryUpdateList=[select Id ,Name,Fulfilling_Branch_Code__c,Line_Item_ID__c,E_Code__c,Item_Reference__c,
                                                                   Grade_Code__c,Grade_Description__c,Suggested_Price__c,Minimum_Price__c,NBV__c,Area__c,
                                                                    Reason_Code__c,Blowout__c,Notes__c,Status__c,Populated__c,CompanyId__c,Display_Picture__c, (select Id,Display_Picture__c,HB_Sales_Inventory__c from SalesInventoryImages__r) From HB_Sales_Inventory__c where E_Code__c=:ecode ];
                       
                        //List<SalesInventoryImages__c> displyImageList = hbInventoryUpdateList[0].SalesInventoryImages__r;
                        List<SalesInventoryImages__c> displyImageListUpdt=new List<SalesInventoryImages__c> ();
                         salesInvLst =new List<SalesInventoryImages__c>();
                         salesInvLstDelete =new List<SalesInventoryImages__c>();
                         
                        if(!hbInventoryUpdateList.isEmpty()){
                           hbInventoryToUpdate=new List<HB_Sales_Inventory__c>();
                           for(HB_Sales_Inventory__c hbInventory1: hbInventoryUpdateList){
                                hbInventory1.Fulfilling_Branch_Code__c=fulfillingBranch;
                                hbInventory1.Line_Item_ID__c=itemCode;
                                hbInventory1.E_Code__c=ecode;
                                hbInventory1.Item_Reference__c=referenceNo;
                                hbInventory1.Grade_Code__c=gradeCode; 
                                hbInventory1.Grade_Description__c=gradeDescription;
                                system.debug('------------suggestedPrice----------'+suggestedPrice);
                                if(suggestedPrice!='null' && suggestedPrice!=''){
                                    hbInventory1.Suggested_Price__c=Double.valueOf(suggestedPrice);
                                }else if(suggestedPrice.equalsIgnoreCase('null')){
                                    hbInventory1.Suggested_Price__c = decimal.valueOf('0');
                                }
                                if(minimumPrice!='null' && minimumPrice!=''){
                                    hbInventory1.Minimum_Price__c=Double.valueOf(minimumPrice);
                                }else if(minimumPrice == 'null'){
                                    hbInventory1.Minimum_Price__c = decimal.valueOf('0');
                                }
                                if(nbv!='null' && nbv!=''){
                                    hbInventory1.NBV__c=Double.valueOf(nbv);
                                }else if(nbv == 'null'){
                                    hbInventory1.NBV__c = decimal.valueOf('0');
                                }
                                
                                hbInventory1.Area__c=area;
                                hbInventory1.Reason_Code__c=reasonCode;
                                hbInventory1.Blowout__c=blowOut;
                                hbInventory1.Notes__c=notes;
                                hbInventory1.Status__c=status;
                                hbInventory1.Populated__c = populated;
                                hbInventory1.CompanyId__c=companyNo;
                                //hbInventory.Display_Picture__c=dislayPictures;
                                      
                               
                                 displyImageListUpdt = hbInventory1.SalesInventoryImages__r;
                                
                                 system.debug('-----------displyImageListUpdt---------------'+displyImageListUpdt);
                                
                               // salesInvLstDelete.addAll(displyImageList);
                             // List<SalesInventoryImages__c> salesInvLstDelete =new List<SalesInventoryImages__c>();
                               salesInvLstDelete.addAll(displyImageListUpdt);
  
                             /*   if(!displyImageList.isEmpty()){
	                                for(integer i =0; i<displyImageList.size();i++){
	                                	if(!dislayPictures.isEmpty()){
			                        	 	 for(integer x =0; x<dislayPictures.size();x++){
			                        	 	 	if(i==x){
			                        	 	 		displyImageList[i].Display_Picture__c=dislayPictures[x];
			                        	 	 	}
			                        	 	 }
	 
	                        	       }
	                                	
	                                }
                                  displyImageListUpdt.addAll(displyImageList);
                                }*/
                                
                              
		                        	 if(!dislayPictures.isEmpty()){
		                        	 	for(String image:dislayPictures){
		                        	 	 SalesInventoryImages__c sImage=new SalesInventoryImages__c();
		                        	 	 sImage.Display_Picture__c=image;
		                        	 	 sImage.HB_Sales_Inventory__c=hbInventory1.id;
		                        	 	 if(image!=null && image!=''){
                        	 	           salesInvLst.add(sImage);
                        	 	         }
		                        	 	 
		                        	    }
		   
		                        	 }
                             
                                      
                                hbInventoryToUpdate.add(hbInventory1);
                         }
                         system.debug('-----------hbInventoryToUpdate---------------'+hbInventoryToUpdate);
                         
                         delete salesInvLstDelete;
                         update hbInventoryToUpdate;
                         insert salesInvLst;
                         
                         
                         responseList.add('Your response is: success');
                        }else{
                             responseList.add('E0004');
                             responseList.add('Inventory Not Found');
                        }
                      
                  }else if(action.equalsIgnoreCase('delete')){
                  	
                  	  System.debug('deleting  record');
                       List<HB_Sales_Inventory__c> hbInventoryDeleteList=[select Id ,Name,Fulfilling_Branch_Code__c,Line_Item_ID__c,E_Code__c,Item_Reference__c,
                                                                   Grade_Code__c,Grade_Description__c,Suggested_Price__c,Minimum_Price__c,NBV__c,Area__c,
                                                                    Reason_Code__c,Blowout__c,Notes__c,Status__c,Populated__c,CompanyId__c,Display_Picture__c, (select Id,Display_Picture__c,HB_Sales_Inventory__c from SalesInventoryImages__r) From HB_Sales_Inventory__c where E_Code__c=:ecode ];
                     
                       if(!hbInventoryDeleteList.isEmpty()){
                          delete hbInventoryDeleteList;
                          responseList.add('Your response is: success');
                        }else{
                             responseList.add('E0004');
                             responseList.add('Inventory Not Found');
                        }
                     
                    
                  }else{
                    responseList.add('E0002');
                    responseList.add('Unknown action');
                  }
               }else{
                    responseList.add('E0001');
                    responseList.add('Invalid Token provided');
               }
         } catch (Exception e) {
        
            system.debug(LoggingLevel.ERROR,'Error when Calling Invemtory Rest API:'+e.getMessage());
            responseList.add('E0000');
          
            responseList.add(e.getMessage());
            RestContext.response.statusCode = 500;
            
            response=  '{"response":'+
                        '{"status":"error",'+
                        '"errCode": "'+responseList.get(0)+'",'+
                        '"errmsg": "'+responseList.get(1)+'" }}';

                    
            RestContext.response.responseBody = Blob.valueOf(response);
        }
        
        if(!responseList.get(0).equalsIgnoreCase('Your response is: success')){
            system.debug(LoggingLevel.DEBUG,'Exiting APIRestSalesInventory:doPost:');
           if(!test.isRunningTest()){
            if(responseList.get(0)!='E0000'){
                RestContext.response.statusCode = 401;
            }else{
                RestContext.response.statusCode = 500;
            }
           }
             response='{"response":'+
                        '{"status":"error",'+
                        '"errCode": "'+responseList.get(0)+'",'+
                       '"errmsg": "'+responseList.get(1)+'"}}';
            if(!test.isRunningTest()){
            RestContext.response.responseBody = Blob.valueOf(response);
        }
            
        }
        else{
            system.debug(LoggingLevel.DEBUG,'Exiting APIRestSalesInventory:doPost:');
            response= '{"response":'+
                        '{"status":"Success"}}';
             if(!test.isRunningTest()){           
            RestContext.response.responseBody = Blob.valueOf(response);
             }

        }
        
    }
    
  /*   @HttpDelete
     
     global static void doDelete() {
        system.debug(LoggingLevel.DEBUG,'Entring APIRestSalesInventory:doPost:');
        RestContext.request.addHeader('Content-Type', 'application/json');
        RestContext.response.addHeader('Content-Type', 'application/json');
       // String operation = RestContext.request.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
       String operation = RestContext.request.requestURI.substring( RestContext.request.requestURI.lastIndexOf('/')+1);
        String token = RestContext.request.params.get('token');
        String eCode = RestContext.request.params.get('eCode');
        List<String> responseList=new List<String> ();
        String response=null;
        Boolean isMatch=false;
        HB_Sales_Inventory__c hbInventory=null;
        try {
              
               isMatch= validateTokenValue(token);
               if(isMatch){
                   if(operation.equalsIgnoreCase('delete')){
                       
                       List<HB_Sales_Inventory__c> hbInventoryUpdate=[select Id ,E_Code__c From HB_Sales_Inventory__c where E_Code__c=:eCode];
                        if(!hbInventoryUpdate.isEmpty()){
                    
                          delete hbInventoryUpdate;
                          responseList.add('Your response is: success');
                        }else{
                             responseList.add('E0004');
                             responseList.add('E-Code Not Found');
                        }
                      
                   }else{
                      responseList.add('E0002');
                      responseList.add('URL Not Found');
                   }
               }else{
                    responseList.add('E0001');
                    responseList.add('Invalid Token provided');
               }
         } catch (Exception e) {
            system.debug(LoggingLevel.ERROR,'Error when Calling Invemtory Rest API:'+e.getMessage());
            responseList.add('E0000');
            responseList.add('Unable to delete Inventory in the system');
            RestContext.response.statusCode = 500;
            
            response=  '{"response":'+
                        '{"status":"error",'+
                        '"errCode": "'+responseList.get(0)+'",'+
                        '"errmsg": "'+responseList.get(1)+'" }}';

                    
            RestContext.response.responseBody = Blob.valueOf(response);
        }
        
        if(!responseList.get(0).equalsIgnoreCase('Your response is: success')){
            system.debug(LoggingLevel.DEBUG,'Exiting APIRestSalesInventory:doPost:');
            if(responseList.get(0)!='E0000'){
                RestContext.response.statusCode = 401;
            }else{
                RestContext.response.statusCode = 500;
            }
             response='{"response":'+
                        '{"status":"error",'+
                        '"errCode": "'+responseList.get(0)+'",'+
                       '"errmsg": "'+responseList.get(1)+'"}}';
            RestContext.response.responseBody = Blob.valueOf(response);
        }
        else{
            system.debug(LoggingLevel.DEBUG,'Exiting APIRestSalesInventory:doPost:');
            response= '{"response":'+
                        '{"status":"Success"}}';
                        
            RestContext.response.responseBody = Blob.valueOf(response);

        }
        
    }
    
    */
    
    
    public static Boolean validateTokenValue(String requestTokenValue){
        system.debug(LoggingLevel.DEBUG,'Entering APIRestSalesInventory:validateTokenValue'+requestTokenValue);
        String preorderTokenValue='XZaY69470Dzsejl3859hty!Te';
        Boolean isTokenMatch=false;
        try{
            
            if(requestTokenValue!=null && requestTokenValue.equals(preorderTokenValue)){
                isTokenMatch=true;
            }
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error when validating token value:'+e.getMessage()); 
        }
        system.debug(LoggingLevel.DEBUG,'Exiting APIRestSalesInventory:validateTokenValue:'+isTokenMatch);
        return isTokenMatch;
    }
    
    
    global class displayPicClass {
        String pic;
    }
    

}