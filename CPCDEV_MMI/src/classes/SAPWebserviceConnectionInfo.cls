Public class SAPWebserviceConnectionInfo{
    
    public static string endPoint{get;set;}
    public static string userName{get;set;}
    public static string password{get;set;}
    
    public SAPWebserviceConnectionInfo(){
    
        /*String curEnvironment = String.valueof(System.URL.getSalesforceBaseUrl().getHost());
        
        List<SAP_Webservice_Connection_Info__mdt> webserviceDetails = [select Endpoint_URL__c,Environment__c,Password__c,Username__c from SAP_Webservice_Connection_Info__mdt];
    
        for(SAP_Webservice_Connection_Info__mdt wsd : webserviceDetails ){
        
            if(curEnvironment.containsignorecase(wsd.Environment__c)){
                endPoint = wsd.Endpoint_URL__c;
                userName = wsd.Username__c;
                password = wsd.Password__c;
            }        
        }
        */
    } 
    
    Public static void getWebserviceDetails(){
        String curEnvironment = String.valueof(System.URL.getSalesforceBaseUrl().getHost());
        
        List<SAP_Webservice_Connection_Info__mdt> webserviceDetails = [select Endpoint_URL__c,Environment__c,Password__c,Username__c from SAP_Webservice_Connection_Info__mdt];
    
        for(SAP_Webservice_Connection_Info__mdt wsd : webserviceDetails ){
        
            if(curEnvironment.containsignorecase(wsd.Environment__c)){ endPoint = wsd.Endpoint_URL__c; userName = wsd.Username__c; password = wsd.Password__c; }        
        }    
    }
       
}