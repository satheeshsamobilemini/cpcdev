public class openJobProfileAccounts{
Id accId;
Account acc;
Boolean isFromQuote;
string salesOrgID{get;set;}
string oppId{get;set;}
public Id selectedJB{get;set;}
public string url{get;set;}
public string selSubRole{get;set;}
public List<selectOption> subRoleListOptions{get;set;}
public list<string> subRoleList{get;set;}
public Boolean showSel1{get;set;}
public Boolean showSel2{get;set;}
public Boolean showSel3{get;set;}
List<Job_Profile__c> jbList;
set<Id> jbIdSet = new set<Id>();
map<Id,string> mapjbIdName = new map<Id,string>(); 
map<Id,list<string>> mapjbIdsubRole = new map<Id,list<string>>();

 public openJobProfileAccounts(){
   url = 'null';
   isFromQuote = false;
   showSel1 = false;showSel2 = false;showSel3 = false;
   jbList = new List<Job_Profile__c>();
   string oId;   
   if(Apexpages.currentPage().getParameters().containskey('acc'))
     accId = Apexpages.currentPage().getParameters().get('acc');
   else if(ApexPages.currentPage().getParameters().containskey('id')){
     accId = ApexPages.currentPage().getParameters().get('id');
      if(ApexPages.currentPage().getParameters().containskey('Sales_Org'))
        salesOrgID = ApexPages.currentPage().getParameters().get('Sales_Org');
      if(ApexPages.currentPage().getParameters().containskey('opportunityid'))
        oId = ApexPages.currentPage().getParameters().get('opportunityid');
      oppId = oId == '' ? '' : oId;  
     isFromQuote = true;   
   }  
   system.debug('-------------- accId ------------' + accId);
   if(accId != null)
     getopenJobProfiles(accId);  
 }


 private void getopenJobProfiles(Id accId){
   acc  = [select Id,Name,BillingStreet,BillingCity,BillingState,BillingPostalCode,BillingCountry,Servicing_Branch_Id__c,(select Id,Job_Profile__c,JobProfile_Status_Completed__c,Job_Profile_Name__c,Role__c from Job_Profile_Sub_Contractor__r where Job_Profile_Name__c != null  and Job_Profile_Name__c!= '' and JobProfile_Status_Completed__c = false) from account where Id =: accId LIMIT 1];
   system.debug('-------------- acc.Job_Profile_Sub_Contractor__r.size() ------------' + acc.Job_Profile_Sub_Contractor__r.size());
    if(acc.Job_Profile_Sub_Contractor__r.size() > 0){
      for(Sub_Contractor__c sc : acc.Job_Profile_Sub_Contractor__r){
       jbIdSet.add(sc.Job_Profile__c);
       system.debug('-------------- sc.Job_Profile__c ------------' + sc.Job_Profile__c);
       system.debug('-------------- sc.Role__c ------------' + sc.Role__c);
       system.debug('-------------- sc.Id ------------' + sc.Id);
       mapjbIdName.put(sc.Job_Profile__c,sc.Job_Profile_Name__c);
       if(!mapjbIdsubRole.containskey(sc.Job_Profile__c) && sc.Role__c != null)
         mapjbIdsubRole.put(sc.Job_Profile__c,new list<string>{sc.Role__c});
       else if(sc.Role__c != null)
         mapjbIdsubRole.get(sc.Job_Profile__c).add(sc.Role__c);
       system.debug('-------------- mapjbIdsubRole ------------' + mapjbIdsubRole);    
      }  
    }
 } 
 
 public List<SelectOption> jobProfiles{
   get{
    List<SelectOption> options = new List<SelectOption>();
    options.add(new SelectOption('','None'));
     for(Id jbId : jbIdSet){
       if(mapjbIdName.containskey(jbId))
        options.add(new selectOption(jbId,mapjbIdName.get(jbId)));   
     }   
    return options;      
   }
   set;
 }
 
 public PageReference Next(){
  system.debug('----------- selectedJB --------' + selectedJB); 
  //system.debug('----------- selectedJB 2 --------' + string.valueOf(selectedJB).substring(0,15));
  Boolean isFromJobProfile=false;
  if(acc != null ){
    if(!isFromQuote){ 
       url = '/006/e?retURL='+ accId;
       string sRole = (selSubRole != '' && selSubRole != null) ? selSubRole : '';
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
         if(selectedJB != null && mapjbIdName.containskey(selectedJB)) 
           url += '&CF00N80000004bpoa_lkid=' + selectedJB + '&CF00N80000004bpoa=' + mapjbIdName.get(selectedJB);
           url += '&00N80000004bpob=' + sRole;
       system.debug('----------- url --------' + url);
    }else{
       if(selectedJB != null && mapjbIdName.containskey(selectedJB))
         isFromJobProfile=true;         
       Createopportunity(isFromJobProfile);
       url  = '/apex/SelectConatctPopup?id='+acc.Id+'&FromAccount=true&accDashboard=true&Sales_Org=';
        if(salesOrgID != null && salesOrgID != '')
          url += salesOrgID+'&opportunityid='+oppId;
    }        
  } 
  return null;
 } 
 
 public void dispSubConRole(){
  subRoleListOptions = new list<selectOption>();
  subRoleList = new list<string>();
   if(selectedJB != null && mapjbIdsubRole.keyset().size() > 0 && mapjbIdsubRole.containskey(selectedJB))
    subRoleList.addAll(mapjbIdsubRole.get(selectedJB));
  system.debug('-------------- subRoleList ------------' + subRoleList); 
   if(subRoleList.size() == 0){
     showSel1 = false;
     showSel2 = false; 
   }else if(subRoleList.size() == 1){ 
     showSel1 = false;
     showSel2 = true;  
   }else if(subRoleList.size() > 1){
     for(string s : subRoleList){
       subRoleListOptions.add(new selectOption(s,s));
     }
     showSel1 = true;
     showSel2 = false; 
   } 
 }
 
 private void Createopportunity(Boolean isFromJobProfile){
  Opportunity opp = new Opportunity();
         if(isFromJobProfile){
            string jobProfileID = selectedJB;
            Job_Profile__c jobProfileRec = [select ID,Name,Job_Site_Address__c,Job_Site_City__c,Job_Site_Country__c,Job_Site_State__c,Job_Site_Zip__c,
              CurrencyIsoCode,Branch_ID__c,Contact_Phone__c from Job_Profile__c where ID =:jobProfileID];
            String city = ' ';
            String state = ' ';
            string jobProfileName = '';
            if(jobProfileRec.Job_Site_City__c != null && jobProfileRec.Job_Site_City__c != '')
                city = ' ' + jobProfileRec.Job_Site_City__c + ', ';   
            if(jobProfileRec.Job_Site_State__c != null && jobProfileRec.Job_Site_State__c != '')
                state = jobProfileRec.Job_Site_State__c;
            if(jobProfileRec.Name != null && jobProfileRec.Name != '')
                jobProfileName = jobProfileRec.Name;    
            opp.name = acc.Name + ' - ' + jobProfileName +' -' + city + state;
            opp.Job_Profile__c = jobProfileRec.Id;
            opp.Sub_Contractor_Role__c = (selSubRole != '' && selSubRole != null) ? selSubRole : subRoleList[0];
            opp.Delivery_City__c = jobProfileRec.Job_Site_City__c;
            opp.Delivery_Country__c = jobProfileRec.Job_Site_Country__c;
            opp.Delivery_State_Province__c = jobProfileRec.Job_Site_State__c;
            opp.Delivery_Street__c = jobProfileRec.Job_Site_Address__c;
            //opp.Shipping_Territory__c = jobProfileRec.Territory__c;
            opp.Delivery_Zip_Postal_Code__c = jobProfileRec.Job_Site_Zip__c;
            
            createShipToRecord(jobProfileRec);
        }
        else{
            opp.name = acc.Name;
        }
        
        List<Account> accs = [select id,recordtypeid from account where id=:accId];
        String stUKID = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity - UK').getRecordTypeId();
        String stID = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity').getRecordTypeId();
        if(accs.size() > 0)
        {    
            String recName = Schema.SObjectType.Account.getRecordTypeInfosById().get(accs[0].recordtypeid).getName();     
                if(recName.containsIgnorecase('UK'))
                    opp.recordtypeid = stUKID;
                else
                    opp.recordtypeid = stID;    
        }
        opp.From_New_Quote__c = true;
        opp.AccountId = accId ;
        opp.StageName = 'Not Quoted';
        //opp.Opportunity_Rating__c = 'Hot (Probably Order)';
        // for now --> opp.Opportunity_Contact_Name_LookUpFilter__c = contactId;
        opp.CloseDate = date.today() + 21;
        if(salesOrgID == '1500' || salesOrgID == '1501')
        {
            String etsRentalOppID = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('ETS Rental').getRecordTypeId();
            opp.recordTypeID = etsRentalOppID;
        }
        insert opp;
        oppId = String.valueOf(opp.id);
        
    } //end of Createopportunity
    
    private void createShipToRecord(Job_Profile__c jp){
        Shipto__c sto = new Shipto__c(); 
        
        if(jp != null){    
        sto.Account__c = accId ;
        sto.Address__c = jp.Job_Site_Address__c;
        sto.City__c    = jp.Job_Site_City__c;
        sto.Country__c = jp.Job_Site_Country__c;
        sto.Fulfilling_Branch__c = jp.Branch_ID__c;
        sto.Phone__c   = jp.Contact_Phone__c;
        sto.State__c   = jp.Job_Site_State__c;
        sto.Zip__c     = jp.Job_Site_Zip__c;
        sto.CurrencyIsoCode = jp.CurrencyIsoCode;
        insert sto;
       } 
    } 
}