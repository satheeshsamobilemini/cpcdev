/**
* (c) 2015 TEKsystems Global Services
*
* Name           : SelectSORRecordTypeCntrl
* Created Date   : 5 Nov, 2015 
* Created By     : Nagalakshmi (TEKSystems)
* Purpose        : Controller class used by 'SelectSORRecordType' VF page.
* Last Updated By: Ankur Goyal (TEKSystems)
* Last Updated Date: 14-Jan-2016
**/

public with sharing class SelectSORRecordTypeCntrl{

    Public List<RecordType> RecList{get; set;}
    public Id recordTypes1{get;set;}
    public string AcName{get; set;}
    public string AcId{get; set;}
    public string salesorg;
    public string selection{get;set;}    // TFS 7538
    public String CreditId{get;set;}
    
    public SelectSORRecordTypeCntrl() {
        RecList =new List<RecordType>();
        AcName = ApexPages.currentPage().getParameters().get('Name');
        AcId = ApexPages.currentPage().getParameters().get('id');
        selection = ApexPages.currentPage().getParameters().get('selected');
        //Fetch the sales org for current account
        salesorg= [SELECT id,Name,Sales_Org__c FROM Account where id =:AcId].Sales_Org__c;
         if(salesorg != null && salesorg != '' && salesorg == '1100') // TFS 7891..  CAN-1100
           { salesorg = '1000'; }  
        //iterate through cases & SOR record types and add the recordtypes related to salesorg in RecList. 
        //This list is displayed on SelectSORRecordType page to allow the users to select an appropriate record type to create SOR/case record.
        for(RecordType p:[SELECT id,Name, DeveloperName FROM RecordType  WHERE isActive = true AND (sObjectType='Service_Order_Request__c')]){
            if(salesorg != null && salesorg !='') {
                if(p.name.endswith(salesorg)){   //&& !(p.name.startsWith('Service'))){
                    RecList.add(p);
                }
            } 
        }
        System.debug('RecList....'+RecList);
        
    } //end of SelectSORRecordTypeCntrl
    
    String[] ps= new String[]{};
    public String[] getrecordTypes() {
        return ps;
    }
    
    public void setrecordTypes(String[] ps) {
        this.ps = ps;
    }
    
    
    public List<SelectOption> getItems() {
        List<SelectOption> op = new List<SelectOption>();
        RecList = new List<RecordType>();
        CreditId = '';
        //iterate through cases & SOR record types and add the recordtypes related to salesorg in select option list. 
        //This list is displayed on SelectSORRecordType page to allow the users to select an appropriate record type to create SOR/case record.
        for(RecordType p : [SELECT id,Name, DeveloperName FROM RecordType WHERE isActive = true AND (sObjectType = 'Service_Order_Request__c' )AND isActive = true]){
            if(salesorg != null && salesorg !='') {
                if(p.name.endswith(salesorg))  {   //&& !(p.name.startsWith('Service'))){
                    op.add(new SelectOption(p.Id, p.Name));
                   
                    //if(p.name == 'Credits (MMI) 1000' || p.name == 'General Credits (MMI) 1000')
                    if(p.name == 'SAP Credit Memo (MMI) 1000' || p.name == 'SAP Credit Memo (ETS) 1500' || p.name == 'SAP Credit Memo (WMI) 1501')
                    {
                         
                        CreditId += p.id+p.Name;
                       
                    }
                }
            }
        }
        return op;
    } //end of getItems
    
    
    public Pagereference navigate(){
        Pagereference  p;
        System.debug('CreditId........'+CreditId);
        if(recordTypes1 != null && !CreditId.contains(String.valueOf(recordTypes1))){
         p = new Pagereference('/a0d/e?retURL=%2Fa0d%2Fo&ent=01I80000000lLBL&RecordType='+recordTypes1+'&CF00N80000004mJY7='+AcName+'&CF00N80000004mJY7_lkid='+AcId);
         if(selection == 'NonDashboard') // TFS 7538
          { p = new Pagereference('/a0d/e?retURL='+AcId+'&RecordType='+recordTypes1+'&CF00N80000004mJY7='+AcName+'&CF00N80000004mJY7_lkid='+AcId); 
            p.setRedirect(true);
          }
        
        }
        else if(recordTypes1 != null && CreditId.contains(String.valueOf(recordTypes1))){
           p = new Pagereference('/apex/InvoiceSearch?accId='+AcId+'&accName='+AcName+'&RecordType='+recordTypes1);
           p.setRedirect(true);
        }
        
        return p;
    } //end of navigate
    
    public Pagereference NavBack(){
        Pagereference  b = new Pagereference('/apex/AccountDashboard?id='+AcId);
        if(selection == 'NonDashboard') // TFS 7538
        { b = new Pagereference('/'+AcId); }   
        b.setRedirect(true);
        return b;
    } //end of NavBack
} //end of class SelectSORRecordTypeCntrl