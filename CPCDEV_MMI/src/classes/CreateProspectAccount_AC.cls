public with sharing class CreateProspectAccount_AC {
    
    public String ProspectAcct(HomeBaseBeans.ProspectAccountParam payloadObj){
        String Payload = '<?xml version="1.0"?>'+
                        '<goldmineImporter><Company>'+payloadObj.companyName+'</Company>'+
                        '<SalesforceID>'+payloadObj.salesforceID+'</SalesforceID>'+
                        '<Contact>'+payloadObj.contactName+'</Contact>'+
                        '<Address1>'+payloadObj.address1+'</Address1><Address2></Address2>'+
                        '<Address3></Address3>'+
                        '<City>'+payloadObj.city+'</City>'+
                        '<State>'+payloadObj.state+'</State>'+
                        '<Zip>'+payloadObj.zip+'</Zip><Country>'+payloadObj.Country+'</Country>'+
                        '<Phone1>'+payloadObj.phone1+'</Phone1><Phone2></Phone2><Phone3></Phone3>'+
                        '<FAX></FAX><Email></Email>'+
                        '<RepCode>'+payloadObj.repCode+'</RepCode>'+
                        '<BranchCode>'+payloadObj.branchCode+'</BranchCode><WebSite></WebSite>'+
                        '<JobTitle></JobTitle><Ext1></Ext1><Salutation></Salutation>'+
                        '<ResultParent></ResultParent><ResultID></ResultID>'+
                        '</goldmineImporter>';
        Http h=new Http(); 
        HttpRequest req= new HttpRequest();
        HttpResponse res = new HttpResponse();
        String EndPointUrl = '';
        String HostName = '';
        List<MMI_Webservices_Config__c> mmiConfigList=null;
        if(MMI_Webservices_Config__c.getAll()!=null){
            mmiConfigList=MMI_Webservices_Config__c.getAll().Values();
            if(mmiConfigList!=null && !mmiConfigList.isEmpty()){
                EndPointUrl = mmiConfigList.get(0).ProspectAccountEndPoint__c;
                HostName =  mmiConfigList.get(0).ProspectAccountHost__c;
             }
        }
        
        req.setEndpoint(EndPointUrl);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'text/xml;charset=UTF-8');
        req.setHeader('SOAPAction', '');
        //req.setHeader('Content-Length', '2501');
        req.setHeader('Host', HostName);
        req.setHeader('Connection', 'Keep-Alive');
        req.setHeader('User-Agent', 'Apache-HttpClient/4.1.1');
        System.debug('**********Payload*******'+Payload);
        req.setBody(payload);
        try {
                 if(!Test.isRunningTest())                
                 {
                  res = h.send(req);
                  System.debug('++++++++++++++++++++++'+res.getBody());
                 }
                  return res.getBody();
            }catch(Exception e){
                System.debug('*****************'+e);
                return null;
          }
    }
    
    public ResponseObj parseResponse(String response){
        ResponseObj ro = null;
        XmlStreamReader reader = new XmlStreamReader(response);
        if(reader!=null){
            ro = new ResponseObj();
            /*while(reader.hasNext()) {
                if (reader.getEventType() == XmlTag.START_ELEMENT) {
                    if (reader.getLocalName() == 'Success') {
                        System.debug('-------value---------'+reader.getLocalName());
                        ro.isSuccess = getTextValue(reader);
                    }
                    if (reader.getLocalName() == 'ErrorMessage') {
                        System.debug('-------value---------'+reader.getLocalName());
                        ro.errorMsg = getTextValue(reader);
                    }
                    if (reader.getLocalName() == 'ResultId') {
                        System.debug('-------value---------'+reader.getLocalName());
                        ro.ResultId = getTextValue(reader);
                    }
                    
                }
                reader.next();
            } */
            String lastElementOccured = '';
            while(reader.hasNext()) {
                if (reader.getEventType() == XmlTag.START_ELEMENT ) {
                    System.debug('---------reader.getLocalName()-------- '+reader.getLocalName());
                    lastElementOccured = reader.getLocalName();
                    
                }
                if(reader.getEventType() == XmlTag.CHARACTERS) {
                   System.debug('------reader.getText()------------- '+reader.getText());
                   if(lastElementOccured == 'Success'){
                        ro.isSuccess = reader.getText();
                   }
                   if(lastElementOccured == 'ErrorMessage'){
                        ro.errorMsg = reader.getText();
                   }
                   if(lastElementOccured == 'ResultId'){
                        ro.ResultId = reader.getText();
                   }
                }
                
                
                /*if (reader.getEventType() == XmlTag.START_ELEMENT && reader.getLocalName() == 'ErrorMessage') {
                    System.debug('---------reader.getLocalName()-------- '+reader.getLocalName());
                    if(reader.getEventType() == XmlTag.CHARACTERS) {
                           System.debug('------reader.getText()------------- '+reader.getText());
                           ro.errorMsg = reader.getText();
                    }
                }
                if (reader.getEventType() == XmlTag.START_ELEMENT && reader.getLocalName() == 'ResultId') {
                    System.debug('---------reader.getLocalName()-------- '+reader.getLocalName());
                    if(reader.getEventType() == XmlTag.CHARACTERS) {
                           System.debug('------reader.getText()------------- '+reader.getText());
                           ro.ResultId = reader.getText();
                     }
                }*/
                   
                reader.next();
            }
        }
        return ro;
    }
    
    public String getTextValue(XmlStreamReader reader){
        String TextValue = '';
        if (reader.getEventType() == XmlTag.CHARACTERS) {
           TextValue = reader.getText();
           System.debug('-------TextValue--------------'+TextValue);
        }
        return TextValue;
    }
    
    public class ResponseObj{
        public String isSuccess {get;set;}
        public String errorMsg {get;set;}
        public String ResultId {get;set;}
    }
	
}