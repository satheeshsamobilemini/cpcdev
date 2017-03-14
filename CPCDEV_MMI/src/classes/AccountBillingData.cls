/**
* (c) 2015 TEKsystems Global Services
*
* Name           : AccountBillingData
* Created Date   : 03 December, 2015 
* Created By     : Ankur Goyal (TEKSystems)
* Purpose        : Web service exposed to third parties to get SFDC Billing data and update based on SAP_Bill_To__c
* Last Updated By: Ankur Goyal (TEKSystems)
* Last Updated Date: 14-Jan-2016
**/

global class AccountBillingData {
    
    webService static WebServiceResponse updateAccountBillingDetails(String SAPBillToId, String BillingStreet, String BillingCity, String Fax,
                                                              String BillingState, String BillingMobile, String BillingEmail,
                                                              String BillingPostalCode, String Name, String Type, String SAPSoldToId) {
        WebServiceResponse webSvcResponse = new WebServiceResponse();
        
        try{
            if(SAPBillToId != null && SAPBillToId != '' ){
                List<Account> accToUpdateList = new List<Account>();
                accToUpdateList = [select ID,BillingStreet,BillingCity,BillingPostalCode,BillingState,Fax,Billing_Mobile__c,Billing_Email__c,
                               Name,Type,SAP_Bill_To__c,SAP_Sold_To__c from account where SAP_Bill_To__c =:SAPBillToId];
                
                if(accToUpdateList != null){
                    for(Account acc :accToUpdateList){
                        if(BillingStreet != null && BillingStreet != '')
                            acc.BillingStreet = BillingStreet;
                            
                        if(BillingCity != null && BillingCity != '')
                            acc.BillingCity = BillingCity;
                            
                        if(BillingPostalCode != null && BillingPostalCode != '')
                            acc.BillingPostalCode = BillingPostalCode;
                            
                        if(BillingState != null && BillingState != '')
                            acc.BillingState = BillingState;
                            
                        if(Fax != null && Fax != '')
                            acc.Fax = Fax;
                        if(BillingMobile != null && BillingMobile != '')
                            acc.Billing_Mobile__c = BillingMobile;
                            
                        if(BillingEmail != null && BillingEmail != '')
                            acc.Billing_Email__c = BillingEmail;
                            
                        if(Name != null && Name != '')
                            acc.Name = Name;
                            
                        if(Type != null && Type != '')
                            acc.Type = Type;
                            
                        if(SAPSoldToId != null && SAPSoldToId != '')
                            acc.SAP_Sold_To__c = SAPSoldToId;
                    }
                update accToUpdateList;
                webSvcResponse.wsResponse = accToUpdateList.size() +' Accounts updated successfully!';   
                webSvcResponse.ststusCode = '200';
                }
            }
            else{
                webSvcResponse.errorMsg = 'Invalid Bill To ID.';    
                webSvcResponse.ststusCode = '500';
            }
        }
        catch(Exception e){
            webSvcResponse.errorMsg = e.getMessage();
            webSvcResponse.ststusCode = '500';
        } 
        return webSvcResponse;           
    }    
    
    global class WebServiceResponse{
       webService String errorMsg;
       webService String ststusCode;
       webService String wsResponse;
    }
    
 } //end of webservice class