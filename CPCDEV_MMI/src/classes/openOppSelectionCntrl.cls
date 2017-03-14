public class openOppSelectionCntrl {
  Id accountId;
  string salesOrg;
  string oppId;
  Boolean isFromQuote;
  public Boolean buttonVisible{get;set;}
  public List<Opportunity> Opplist{get;set;}
  
  public openOppSelectionCntrl(){
   buttonVisible = false;
  }
  
  public pageReference loadPage(){
    oppId = ''; isFromQuote = false;
    oppList = new List<Opportunity>();
         
   if(ApexPages.currentPage().getParameters().containskey('acc'))
     accountId = ApexPages.currentPage().getParameters().get('acc');     
   else if(ApexPages.currentPage().getParameters().containskey('id')){  
     accountId = ApexPages.currentPage().getParameters().get('id');
     isFromQuote = true;
   }  
   
   if(ApexPages.currentPage().getParameters().containskey('Sales_Org'))
     salesOrg = ApexPages.currentPage().getParameters().get('Sales_Org');
   if(ApexPages.currentPage().getParameters().containskey('opportunityid'))
     oppId = ApexPages.currentPage().getParameters().get('opportunityid'); 
   
   if(accountId != null){
    //Account acc = [select Id,(select Id,Name,Delivery_City__c,Delivery_State_Province__c,Shipping_Territory__c from Opportunities where StageName NOT IN ('Closed - Won','Closed - Lost Business')) from Account where Id =: accountId LIMIT 1]; 
     Account acc = [select Id,(select Id,Name,Delivery_City__c,Delivery_State_Province__c,Shipping_Territory__c from Opportunities where StageName IN ('Not Quoted','Quoted - No Decision')) from Account where Id =: accountId LIMIT 1];
     if(acc.Opportunities.size() > 0){
       for(Opportunity opp : acc.Opportunities)
        oppList.add(opp);
     return null;     
    }else{
      PageReference pg;
        if(isFromQuote && salesOrg != '' && salesOrg != null && (salesOrg == '1000' || salesOrg == '1100'))
          pg = new PageReference('/apex/openJobProfileAccounts_Intial?id='+accountId+'&FromAccount=true&accDashboard=true&Sales_Org='+salesOrg+'&opportunityid='+oppId);
        else if(isFromQuote && salesOrg != '' && salesOrg != null && (salesOrg == '1500' || salesOrg == '1501'))
          pg = new PageReference('/apex/SelectConatctPopup?id='+accountId+'&FromAccount=true&accDashboard=true&Sales_Org='+salesOrg+'&opportunityid='+oppId);
        else
          pg = new PageReference('/apex/openJobProfileAccounts_Intial?acc='+accountId);
      pg.setRedirect(true);
      return pg;         
    }
   }      
    return null;         
  }
  
  public void setVisible(){
    buttonVisible = true;
  }
  
  public PageReference Next(){
    string selectedOppId = System.currentPageReference().getParameters().get('opptyId');
    system.debug('=========================='+selectedOppId);
    oppId = (selectedOppId == '' || selectedOppId == null) ? '' : selectedOppId; 
    PageReference pg_1;      
      if(isFromQuote && salesOrg != '' && salesOrg != null && (salesOrg == '1000' || salesOrg == '1100')) 
        pg_1 = new PageReference('/apex/openJobProfileAccounts_Intial?id='+accountId+'&FromAccount=true&accDashboard=true&Sales_Org='+salesOrg+'&opportunityid='+oppId);
      else if(isFromQuote && salesOrg != '' && salesOrg != null && (salesOrg == '1500' || salesOrg == '1501'))
        pg_1 = new PageReference('/apex/SelectConatctPopup?id='+accountId+'&FromAccount=true&accDashboard=true&Sales_Org='+salesOrg+'&opportunityid='+oppId);
      else{ 
        if(oppId != null && oppId != '') 
          pg_1 = new PageReference('/apex/openJobProfileAccounts_Intial?acc='+accountId+'&opportunityid='+oppId); 
        else
          pg_1 = new PageReference('/apex/openJobProfileAccounts_Intial?acc='+accountId);
        }       
    pg_1.setRedirect(true);
    return pg_1;      
  }
     
}