/**
 * (c) 2015 TEKsystems Global Services
 *
 * Name           : InvoiceHistoryCtrl
 * Created Date   : 10 September 2015
 * Created By     : Jailabdin S (TEKSystems)
 * Purpose        : Controller class used by 'InvoiceHistory' VF page.
 * Last Updated By: Ankur Goyal (TEKSystems)
 * Last Updated Date: 14-Jan-2016
 **/

public with sharing class InvoiceHistoryCtrl
{
    public Boolean isInvoiceStatusSelected{get; set;}
    public Boolean showSubmitButton{get; set;}
    public String invoiceStatus{get;set;}
    public string accid{get; set;}
    public Account currentaccount{get;set;}
    public String portalURL{get;set;}
    public String cpqURL{get;set;}
   
    public InvoiceHistoryCtrl()
    {
        showSubmitButton=false;
        isInvoiceStatusSelected = false;
        invoiceStatus ='';
        accid=apexpages.currentpage().getparameters().get('id');
        currentaccount=[select id,name,SAP_Bill_To__c,Sales_Org__c from Account where id=:accid];
        
        //fetch cpq and portal url from custom setting
        cpqURL = '';
        portalURL = '';
        String curHost = System.URL.getSalesforceBaseUrl().getHost();
        for(CPQActiveURL__c cu: CPQActiveURL__c.getAll().values()){
            if(curHost.containsignorecase(cu.Environment__c)){
                cpqURL = cu.CPQ_URL__c;
                portalURL = cu.Portal_URL__c;
            }
        }
    } //end of InvoiceHistoryCtrl
    
    public void change(){
        if(isInvoiceStatusSelected=true){
            showSubmitButton=true;
         }
         else{
             showSubmitButton=false;
         }
    }
} // end of class InvoiceHistoryCtrl