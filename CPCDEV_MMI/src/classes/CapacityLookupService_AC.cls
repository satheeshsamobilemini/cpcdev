public with sharing class CapacityLookupService_AC 
{
	

	public String callWebservice(HomeBaseBeans.capacityLookupRequest clr)
	{
		String endPointUrl = '';
		String CapUserName = '';
        String passwordHashKey = '';
        String orgKey = '';
        String hostName = '';
        List<MMI_Webservices_Config__c> mmiConfigList=null;
        if(MMI_Webservices_Config__c.getAll()!=null){
			mmiConfigList=MMI_Webservices_Config__c.getAll().Values();
			if(mmiConfigList!=null && !mmiConfigList.isEmpty()){
				endPointUrl = mmiConfigList.get(0).CapacityLookupEndPoint__c;
				CapUserName = mmiConfigList.get(0).CapacityUserName__c;
				passwordHashKey = 	mmiConfigList.get(0).CapacityPasswordHashKey__c;
				orgKey = mmiConfigList.get(0).CapacityOrgKey__c;
				hostName = mmiConfigList.get(0).CapacityHostName__c;
		     }
        }
		
		String payload = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:cap="http://capacity.services.operation.cuberoute.com">'+
   '<soapenv:Header/>'+
   '<soapenv:Body>'+
      '<cap:capacity>'+
         '<!--Zero or more repetitions:-->'+
         '<request>'+
            '<operationCode>Lookup</operationCode>'+

            '<address>'+
               '<addressLine1>'+clr.addressLine1+'</addressLine1>'+
               '<city>'+clr.city+'</city>'+
               '<countryCode>'+clr.countryCode+'</countryCode>'+
               '<latitude>'+clr.latitude+'</latitude>'+
               '<longitude>'+clr.longitude+'</longitude>'+
               '<postalCode>'+clr.postalCode+'</postalCode>'+
               '<stateCode>'+clr.stateCode+'</stateCode>'+
               '<crossStreet1></crossStreet1>'+
               '<crossStreet2></crossStreet2>'+
            '</address>'+
    
           '<capacityReservationID xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"/>'+
           
           '<customerID></customerID>'+
           '<invoiceCustom></invoiceCustom>'+
			'<itemDescription>'+clr.itemDescription+'</itemDescription>'+
            '<itemName>'+clr.itemName+'</itemName>'+
            '<numberOfDays xsi:nil="1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"/>'+
            '<pieceCount>1</pieceCount>';
            if(clr.itemName != null && clr.itemName != ''){
            	payload = payload + '<volume>'+clr.itemName.substring(0,2)+'</volume>';
            }else{
            	payload = payload +'<volume></volume>';
            }
			payload = payload +'<weight xsi:nil="1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"/>'+
            '<quantity1 xsi:nil="1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"/>'+
            '<quantity2 xsi:nil="1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"/>'+
            '<quantity3 xsi:nil="1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"/>'+
            '<quantity4 xsi:nil="1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"/>'+
            '<quantity5 xsi:nil="1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"/>'+
            '<quantity6 xsi:nil="1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"/>'+
            '<quantity7 xsi:nil="1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"/>'+
            '<quantity8 xsi:nil="1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"/>'+
            '<quantity9 xsi:nil="1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"/>'+
            '<quantity10 xsi:nil="1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"/>'+
            '<shipmentType>CustomerDelivery</shipmentType>'+
            '<scheduledDeliveryDate>'+clr.DeliveryDateTime+'</scheduledDeliveryDate>'+
            '<sellingStoreNumber>'+clr.BranchId+'</sellingStoreNumber>'+
            '<serviceRadius xsi:nil="1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"/>'+
            '<timeLimit xsi:nil="1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"/>'+
            '<timeWindow>'+
               '<start>1969-12-31T12:00:00.000Z</start>'+
               '<end>1969-12-31T16:59:00.000Z</end>'+
            '</timeWindow>'+
            '<username>'+CapUserName+'</username>'+
            '<passwordHash>'+passwordHashKey+'</passwordHash>'+
            '<organizationKey>'+orgKey+'</organizationKey>'+
         '</request>'+
      '</cap:capacity>'+
   '</soapenv:Body>'+
'</soapenv:Envelope>';


		Http h=new Http(); 
        HttpRequest req= new HttpRequest();
        HttpResponse res = new HttpResponse();
        //req.setEndpoint('http://qa.cuberoute.com:80/axis2/services/CapacityService');
        req.setEndpoint(endPointUrl);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'text/xml;charset=UTF-8');
        req.setHeader('SOAPAction', 'urn:capacity');
        //req.setHeader('Content-Length', '2501');
        req.setHeader('Host', hostName); //qa.cuberoute.com:80
        req.setHeader('Connection', 'Keep-Alive');
        req.setHeader('User-Agent', 'Apache-HttpClient/4.1.1');
        System.debug('**********payload*******'+payload);
         req.setBody(payload);
         
         try {
	             if(!Test.isRunningTest())                
	             {
	              res = h.send(req);
	              System.debug('++++++++++++++++++++++'+res.getBody());
	             }
	              //------------------error handling-------------------------------------
	              Integer wsStatusCode = res.getStatusCode();
       		      if(wsStatusCode != 200 && !WSErrorHandler.isConstructerLoading){
       		      	WebServiceError__c wse = new WebServiceError__c();
       		      	String responseBody = res.getBody();
					if(endPointUrl != null){
						wse.End_Point_URL__c = endPointUrl;
					}
					wse.HTTP_Status_Code__c = String.valueOf(wsStatusCode);
					if(Payload != null && Payload != ''){
						wse.Payload__c = Payload;
					}
					wse.Response_Body__c = responseBody;
					wse.Time_of_WS_Response__c = system.now();
					insert wse;
       		      }
       		      //------------------error handling-------------------------------------
	              return res.getBody();
         	}
          catch(Exception e)
         {
            System.debug('*****************'+e);
            //------------------error handling-------------------------------------
            if(!WSErrorHandler.isConstructerLoading){
	            WebServiceError__c wse = new WebServiceError__c();
	            wse.Exception_Error_Line__c = String.valueOf(e.getLineNumber());
				wse.Exception_Error_Message__c = e.getMessage();
				wse.Exception_Stack_Trace__c = e.getStackTraceString();
				insert wse;
            }
			//------------------error handling-------------------------------------
            return null;
         }
	}
}