public with sharing class QqFromJpController {
	public list<SelectOption> lstScOption {get;set;}
	public String selectedSc {get;set;}
	//public String url {get;set;}
	public String jpId {get;set;}
	public String Operation {get;set;}
	//public list<Contact> conLst {get;set;}
	public Boolean IsContactPresent {get;set;}
	//public String selectedConId {get;set;}
	//public String accId {get;set;}
	
	public QqFromJpController(){
		IsContactPresent = false;
		jpId = Apexpages.currentPage().getParameters().get('id');
		Operation = Apexpages.currentPage().getParameters().get('operation');
    	list<Sub_Contractor__c> lstSC = [Select s.Name, s.Id, s.Account_Name__c,s.Account__c From Sub_Contractor__c s where s.Job_Profile__c = :jpId];
		lstScOption = new list<SelectOption>();
		
		for(Sub_Contractor__c sc : lstSC){
      		if(sc.Account_Name__c != null){
        		lstScOption.add(new SelectOption(sc.Id,sc.Account_Name__c));
			}
		}
	}
	
	public Pagereference next(){
		if(selectedSc == null || selectedSc == ''){
	        ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Please select a Subcontractor');
	        ApexPages.addMessage(msg);
	        return null;
	    }
	    Sub_Contractor__c SubCont = [Select s.Account__c From Sub_Contractor__c s where id = :selectedSc];
	    Pagereference pr = null;
	    if(Operation == 'qq'){
	    	pr = new Pagereference('/apex/selectcontact?id='+SubCont.Account__c+'&operation=qq&jpId='+jpId+'&scId='+selectedSc);
	    }
	    if(Operation == 'fq'){
	    	pr = new Pagereference('/apex/selectcontact?id='+SubCont.Account__c+'&operation=fq&jpId='+jpId+'&scId='+selectedSc);
	    }
	    pr.setRedirect(true);
	    return pr;
	    /*String selectedConId = System.currentPageReference().getParameters().get('hiddenContact');
	    system.debug('----selectedConId--'+selectedConId);
	    if(selectedConId == null || selectedConId == ''){
	    	selectedConId = '';
	    }
	    if(Operation == 'qq'){
			url = '/apex/QuickQuoteMain_VF?recId='+jpId+'&scId='+selectedSc+'&conId='+selectedConId+'&accId='+accId+'&source=jp';
	    }else{
	    	url = '/apex/FullQuoteForm_VF?id='+jpId+'&scId='+selectedSc+'&conId='+selectedConId+'&accId='+accId+'&source=jp';
	    }
		return null;*/
	}
	
	public void findContacts(){
		/*selectedConId = '';
		Sub_Contractor__c SubCont = [Select s.Account__c From Sub_Contractor__c s where id = :selectedSc];
		if(SubCont != null && SubCont.Account__c != null){
			accId = SubCont.Account__c;
			conLst = [select Id, Name from Contact where AccountId = :SubCont.Account__c ];
			if(conLst.size() > 0){
				IsContactPresent = true;
			
			}else{
				IsContactPresent = false;
				ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.WARNING, 'No Contact found!');
	         	ApexPages.addMessage(msg);
			}
		}else{
			 ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, 'No Contact found!');
	         ApexPages.addMessage(msg);
		}*/
	}

}