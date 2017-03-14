public class openJobProfileAccounts_Intial{

public openJobProfileAccounts_Intial(){
}

public PageReference openJobProfileAccountsPage(){
 Boolean noJB; Boolean isFromQuote;
 Id accId; string salesOrgID;
 string oppId;string oId; 
 Account acc; string url = '';
 
  if(Apexpages.currentPage().getParameters().containskey('acc')){
    accId = Apexpages.currentPage().getParameters().get('acc');
    isFromQuote = false; 
  }else if(ApexPages.currentPage().getParameters().containskey('id')){
     accId = ApexPages.currentPage().getParameters().get('id');
      if(ApexPages.currentPage().getParameters().containskey('Sales_Org'))
        salesOrgID = ApexPages.currentPage().getParameters().get('Sales_Org');
      if(ApexPages.currentPage().getParameters().containskey('opportunityid'))
        oppId = ApexPages.currentPage().getParameters().get('opportunityid');
     isFromQuote = true;   
  }  
  
   acc = [select Id,Name,BillingStreet,BillingCity,BillingState,BillingPostalCode,BillingCountry,Servicing_Branch_Id__c,(select Id,Job_Profile__c,JobProfile_Status_Completed__c,Job_Profile_Name__c,Role__c from Job_Profile_Sub_Contractor__r where Job_Profile_Name__c != null  and Job_Profile_Name__c!= '' and JobProfile_Status_Completed__c = false) from account where Id =: accId LIMIT 1];
   system.debug('-------------- acc.Job_Profile_Sub_Contractor__r.size() ------------' + acc.Job_Profile_Sub_Contractor__r.size());
   noJB = (acc.Job_Profile_Sub_Contractor__r.size() == 0) ? true : false;
     
    if(!noJB && !isFromQuote)
     url += '/apex/openJobProfileAccounts?acc='+accId;
    else if(!noJB && isFromQuote)
     url += '/apex/openJobProfileAccounts?id='+accId+'&FromAccount=true&accDashboard=true&Sales_Org='+salesOrgID+'&opportunityid='+oppId;
    else if(noJB && !isFromQuote){
     url = '/006/e?retURL='+ accId;
      if(acc.Servicing_Branch_Id__c != '' && acc.Servicing_Branch_Id__c != null)
        url += '&00N80000004blSQ=' + acc.Servicing_Branch_Id__c;
        url += '&ent=Opportunity&accid=' + accId;
      if(acc.BillingStreet != '' && acc.BillingStreet != null)
        url += '&00N800000057LBK=' + acc.BillingStreet;
      if(acc.BillingCity != '' && acc.BillingCity != null)
        url += '&00N800000057LBH=' + acc.BillingCity;      
      if(acc.BillingState != '' && acc.BillingState != null)
        url += '&00N800000057LBJ=' + acc.BillingState;
      if(acc.BillingPostalCode != '' && acc.BillingPostalCode != null)
        url += '&00N800000057LBL=' + acc.BillingPostalCode;
      if(acc.BillingCountry != '' && acc.BillingCountry != null)
        url += '&00N800000057LBI=' + acc.BillingCountry;
      system.debug('----------- url --------' + url);  
    }else if(noJB && isFromQuote){
      oId = oppId == '' ? '' : oppId;  
      url  = '/apex/SelectConatctPopup?id='+acc.Id+'&FromAccount=true&accDashboard=true&Sales_Org=';
       if(salesOrgID != null && salesOrgID != '')
        url += salesOrgID+'&opportunityid='+oId;
    }      
 PageReference pg = new PageReference(url);
 pg.setRedirect(true);
 return pg;
}


}