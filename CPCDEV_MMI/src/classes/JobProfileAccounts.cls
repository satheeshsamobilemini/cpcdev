public without sharing class JobProfileAccounts {
  
  public List<Sub_Contractor__c> jobProfileAccountList{get; set;}
  String jobProfileId {get;set;}
  String nextStep {get;set;}
  public String url {get;set;}
  String recordType{get;set;}
  
  public String selectedAccount {get;set;}
  public Map<String,Sub_Contractor__c> mapSub_Contractor;
  
  
  public JobProfileAccounts() {
    url='null';
    jobProfileAccountList = new List<Sub_Contractor__c>();
    if(Apexpages.currentPage().getParameters().containsKey('jobProfileId')) {
      jobProfileId = Apexpages.currentPage().getParameters().get('jobProfileId');
      getAccountsforJobProfile();
    } 
    else{
      return;
    }
    
    nextStep = 'newOppty' ;
    if(Apexpages.currentPage().getParameters().containsKey('nextStep')) {
      nextStep = Apexpages.currentPage().getParameters().get('nextStep');
    }
    recordType = 'US';
    if(Apexpages.currentPage().getParameters().containsKey('recordType')) {
      recordType = Apexpages.currentPage().getParameters().get('recordType');
    }
    
        
  }
  
  public void getAccountsforJobProfile() {
    //Added address parameters of job parameters in query for getting Job Profiles address for story :S-110846 by Reena Acharya
    jobProfileAccountList = [Select id, Account__c, Account__r.Name, Job_Profile__c ,Job_Profile__r.Job_Site_Address__c,Job_Profile__r.Job_Site_City__c,Job_Profile__r.Job_Site_State__c,Job_Profile__r.Job_Site_Zip__c,Job_Profile__r.Job_Site_Country__c,Job_Profile__r.Name,Account_Name__c,Job_Profile_Name__c,Job_Profile__r.Job_Profile_Name__c,
                                Role__c
                            from Sub_Contractor__c where Job_Profile__c = :jobProfileId];
    mapSub_Contractor = new Map<String,Sub_Contractor__c>();
    for(Sub_Contractor__c contractor: jobProfileAccountList){
        mapSub_Contractor.put(contractor.Id,contractor);
        
    }
  }
  
  
  public List<SelectOption> accounts{
    get{
        List<SelectOption> options = new List<SelectOption>();
        
        for(Sub_Contractor__c contractor: jobProfileAccountList){
            if(contractor.Account_Name__c != null){
                options.add(new SelectOption(contractor.Id ,contractor.Account_Name__c));
            }
            
        }
        return options;
    }
    set;
  }
  
  public Pagereference next(){
    if(selectedAccount == null){
        
        ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Please select a Subcontractor');
        ApexPages.addMessage(msg);
        return null;
    }
    Sub_Contractor__c contractor  = mapSub_Contractor.get(selectedAccount);
    Map<String,Id> recordTypeIdMap = new Map<String,Id>();    
    for(RecordType rt : [Select r.SobjectType, r.Name, r.Id, r.DeveloperName From RecordType r where SobjectType = 'Task' and Name in ('Standard Task','Field Visit - UK','Outside Form')]){
        recordTypeIdMap.put(rt.Name,rt.Id);
    }
    if(nextStep == 'newOppty' ){
       List<RecordType> opptyRecordType = [Select r.SobjectType, r.Name, r.Id From RecordType r where SobjectType='Opportunity' and Name='Standard Opportunity'];
       url='/006/e?' +
            'retURL='+ jobProfileId  +
            '&saveURL='+ jobProfileId  +
            '&RecordType=' + opptyRecordType.get(0).id +
            '&ent=Opportunity' +
            '&opp3=' + EncodingUtil.urlEncode(contractor.Account_Name__c + ' - ' + contractor.Job_Profile_Name__c, 'UTF-8')  +          
            //'&opp4=' + contractor.Account__r.Name +
            '&opp4_lkid=' + String.valueOf(contractor.Account__c).substring(0,15)  +
            //'&opp4_lkold=' +  contractor.Account__r.Name +            
            '&CF00N80000004bpoa=' +  EncodingUtil.urlEncode(contractor.Job_Profile_Name__c, 'UTF-8')  +
            '&CF00N80000004bpoa_lkid=' + contractor.Job_Profile__c +
            '&CF00N80000004bpoa_lkold=' +  EncodingUtil.urlEncode(contractor.Job_Profile_Name__c, 'UTF-8')   +          
            '&00N80000004bpob=' + contractor.Role__c +
            //Added address parameters for setting Job Profiles address on opportunity for story :S-110846 by Reena
            '&00N80000004mxlk=' +  EncodingUtil.urlEncode(contractor.Job_Profile__r.Job_Site_Address__c== null ?'':contractor.Job_Profile__r.Job_Site_Address__c, 'UTF-8')  +
            '&00N80000004mxlp=' +  EncodingUtil.urlEncode(contractor.Job_Profile__r.Job_Site_City__c == null ? '' : contractor.Job_Profile__r.Job_Site_City__c, 'UTF-8')  +
            '&00N80000004mxlu=' +  EncodingUtil.urlEncode(contractor.Job_Profile__r.Job_Site_State__c == null ? '' : contractor.Job_Profile__r.Job_Site_State__c, 'UTF-8')  +
            '&00N80000004mxm9=' +  EncodingUtil.urlEncode(contractor.Job_Profile__r.Job_Site_Zip__c == null ? '':contractor.Job_Profile__r.Job_Site_Zip__c, 'UTF-8')  +
            '&00N80000004mxmJ=' +  EncodingUtil.urlEncode(contractor.Job_Profile__r.Job_Site_Country__c == null ? '' : contractor.Job_Profile__r.Job_Site_Country__c, 'UTF-8')  +
            //End of adding address parameters.
            '&opp6=Job Profile' ;
    }
    else if(nextStep == 'newTask'){                       // TFS 2237
         url = '/00T/e?track=yesnooveride=1&' +
             'tsk3=' + EncodingUtil.urlEncode(contractor.Account__r.Name, 'UTF-8') +
             '&tsk3_lkid=' + String.valueOf(contractor.Account__c).substring(0,15)  +
            // '&tsk3_mlktp=Account' +
             '&tsk5=Job Profile Follow Up' + 
             '&00N80000003YR1o=Job Profile Follow Up' +  
             '&tsk13=Normal' + 
             //'&tsk4={!Job_Profile__c.Bid_Date__c}' + 
             '&00N80000004c842=' + jobProfileId.subString(0,15)  +
             '&IsReminderSet=0' + 
             '&retURL=' + jobProfileId+ '?00N80000004c842=' + jobProfileId.subString(0,15);
            if(recordTypeIdMap.containsKey('Task')){
                url += '&RecordType='+recordTypeIdMap.get('Standard Task');
            }
           
    }
    else if(nextStep == 'subFieldVisit'){
        url = '/00T/e?' +
             'tsk3=' + EncodingUtil.urlEncode(contractor.Account__r.Name, 'UTF-8') +
             '&tsk3_lkid=' + String.valueOf(contractor.Account__c).substring(0,15)  +
             //'&tsk3_mlktp= Job Profile' +
             '&tsk5=Field Visit' + 
             '&00N80000003YR1o=Field Visit' +  
             '&tsk13=Normal' + 
             //'&tsk4={!Job_Profile__c.Bid_Date__c}' + 
             '&00N80000004c842=' + jobProfileId.subString(0,15)  +
             '&IsReminderSet=0' + 
             '&retURL=' + jobProfileId + '?00N80000004c842=' + jobProfileId.subString(0,15);
             if(recordType == 'US' && recordTypeIdMap.containsKey('Outside Form')){
                url += '&RecordType='+recordTypeIdMap.get('Outside Form');
            }else if(recordType == 'UK' && recordTypeIdMap.containsKey('Field Visit - UK')){
                url += '&RecordType='+recordTypeIdMap.get('Field Visit - UK');
            }
    }
    return null;
        
    
  }
    
}