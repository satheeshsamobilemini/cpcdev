/**
 * @Author :Vivek
 * @Date: 29-Sep-2015
 * @Description: This is class to populate the list of accounts. 
 */
 
global class JobProfileListAccount{
    public String oppId{get;set;}
    public Map<Id,List<String>> accIdRolesMap{get;set;}
    public List<Account> AccList{get;set;}
    public List<String> subContactorList{get;set;}
    public List<Id> accountIds{get;set;}
    //public List<Sub_Contractor__c> subContractorList{get;set;}
    public String enteredText1{get;set;}
    public String enteredText2{get;set;}
    public String salesOrgID{get;set;}  
    public Id accId{get;set;}
    public boolean isAccSelected{get;set;}
    public string selectedContactID{get;set;}
    public string subConRole{get;set;}
    public boolean isSingleRole{get;set;}
    public Integer flag{get;set;}
    /**
    * @Purpose: This constructor populate the AccList.
    */
    public JobProfileListAccount(){   
        accountIds = new List<Id>();
        AccList = new List<Account>();
        subContactorList = new List<String>();
        isAccSelected = false;
        accIdRolesMap = new Map<Id,List<String>>();
        isSingleRole = false;
        flag=0;
        for(Job_Profile__c job : [select id, name, (select id, Role__c,Account__c,Owner_s_Role__c from Job_Profile_Sub_Contractor__r) from Job_Profile__c where id =: ApexPages.currentPage().getParameters().get('ProfileId')]){
          for(Sub_Contractor__c sub : job.Job_Profile_Sub_Contractor__r){
              accountIds.add(sub.Account__c);
              //subContractorIdList.add(sub.Id);
              if(accIdRolesMap.containskey(sub.Account__c)){
                List<String> tempRoleList = accIdRolesMap.get(sub.Account__c);
                tempRoleList.add(String.valueOf(sub.Role__c));
                accIdRolesMap.put(sub.Account__c,tempRoleList);
              }
              else{
                List<String> tempRoleList = new List<String>();
                tempRoleList.add(String.valueOf(sub.Role__c));
                accIdRolesMap.put(sub.Account__c,tempRoleList);
              } 
          }
        }
        AccList = [select id, name, Phone,Sales_Org__c, Fax, BillingPostalCode,BillingState from account where id =: accountIds];
        for(account acc : AccList)
        {
            acc.name = acc.name.replace('\'','');   
        }
        //toDate = toDate.replace('\'','/');  
        //subContactorList = [select id,Owner_s_Role__c from Sub_Contractor__c where id =: subContractorIdList];
        salesOrgID  = Apexpages.currentPage().getParameters().get('Sales_Org');
        //Id idd=Apexpages.currentPage().getParameters().get('firstParam');
        //subContactorList = accIdRolesMap.get(idd);
    } //end of constructor  
   
    public void ContractorRoles(){
        accId=Apexpages.currentPage().getParameters().get('firstParam');
        //accId = System.currentPageReference().getParameters().get('hiddenconID');
        //System.debug('accId.......'+accId);
        isAccSelected = true;
                
        subContactorList = accIdRolesMap.get(accId);
        if(subContactorList.size() > 1)
            isSingleRole = false;
        else{ 
            isSingleRole = true;
            subConRole = subContactorList[0];
        }
       
    }
    public List<SelectOption> getContractorRole(){
       
        accId = System.currentPageReference().getParameters().get('hiddenconID');
        subContactorList = accIdRolesMap.get(accId);
        if(subContactorList.size() == 1){
            subConRole = subContactorList[0];
            isSingleRole = true;
        } 
        else
            isSingleRole = false;       
        System.debug('accIdRolesMap.......'+accIdRolesMap);
        System.debug('subContactorList.......'+subContactorList);
        List<SelectOption> rolesList = new List<SelectOption>();
        for(String contractorRole : subContactorList){
            rolesList.add(new selectOption(contractorRole,contractorRole));
            
        }
        
       return rolesList;
    }
    //Ankur: Create opportunity record and set the oppId to be passed to CPC
    public void Createopportunity(){
        //Id idd  = Apexpages.currentPage().getParameters().get('node');
        Id idd=Apexpages.currentPage().getParameters().get('firstParam');
        String accountName=Apexpages.currentPage().getParameters().get('secondParam');
        system.debug('parameters'+accountName+'$'+idd);
        Opportunity opp = new Opportunity();
        //if(currentAccount.IsPersonAccount)
        opp.name = 'enteredText2';
        opp.AccountId = idd;
        opp.StageName = 'Not Quoted';
        opp.CloseDate = date.today() + 15;
        insert opp;
        oppId =String.valueOf(opp.id);
        system.debug('oppId'+oppId);
    } //end of Createopportunity
 } //end of class JobProfileListAccount