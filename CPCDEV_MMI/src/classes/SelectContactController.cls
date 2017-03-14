public with sharing class SelectContactController {
    
    public String accOrOppId {get;set;}
    public String Operation {get;set;}
    public String url {get;set;}
    public list<Contact> lstContact {get;set;}
    public Boolean IsContactPresent {get;set;}
    public String AccId {get;set;}
    public String conFn {get;set;}
    public String conLn {get;set;}
    public String conPh {get;set;}
    public String conMob {get;set;}
    public String conEmail {get;set;}
    public String selectedConId {get;set;}
    public String selectedPh {get;set;}
    public String Source {get;set;}
    public Boolean isPrsnAcc {get;set;}
    public String fullQuoteId {get;set;}
    public String newConId {get;set;}
    public Boolean isFromNewContact {get;set;}
    
    public String jpId {get;set;}
    public String scId {get;set;}
    
    public SelectContactController(){
        jpId = Apexpages.currentPage().getParameters().get('jpId');
        scId = Apexpages.currentPage().getParameters().get('scId');
        
        accOrOppId = Apexpages.currentPage().getParameters().get('id');
        Operation = Apexpages.currentPage().getParameters().get('operation');
        fullQuoteId = Apexpages.currentPage().getParameters().get('fqId');
        IsContactPresent = false;
        isPrsnAcc = false;
        isFromNewContact = false;
        lstContact = new list<Contact>();
        AccId = getAccountId(accOrOppId);
        isPrsnAcc = isPersonalAcc(AccId);
        if(isPrsnAcc){
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.WARNING, 'You cannot create a contact for Person Account! Please select the contact and click Next button.');
            ApexPages.addMessage(msg);
        }
        getContactRecord();
    }
    public void getContactRecord(){
        try{
            if(AccId != ''){
                lstContact = [select Id, Name,Phone, MobilePhone, Email from Contact where AccountId = :AccId];
                isContactAvailable(lstContact);
            }
        }catch(Exception e){
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage());
            ApexPages.addMessage(msg);
        }
    }
    
    public void CreateContact(){
        try{
            Contact con = new Contact();
            String Error = 'no';
            if(conFn == ''){
            	ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Please provide first name!');
            	ApexPages.addMessage(msg);
            	Error = 'yes';
            }
            if(conLn == ''){
            	ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Please provide last name!');
            	ApexPages.addMessage(msg);
            	Error = 'yes';
            }
            if(Error == 'no'){
	            con.FirstName = conFn;
	            con.LastName = conLn;
	            con.Phone = conPh;
	            con.Email = conEmail;
	            con.MobilePhone = conMob;
	            system.debug('----AccId-----'+AccId);
	            con.AccountId = Id.valueOf(AccId);
	            insert con;
	            isFromNewContact = true;
	            conFn = '';
	            conLn = '';
	            conPh = '';
	            conMob = '';
	            conEmail = '';
	            getContactRecord();
	            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.CONFIRM, 'New Contact has been created successfully!');
	            ApexPages.addMessage(msg);
	            newConId = con.Id;
	            selectedPh = 'Phone';
	            String hiddenPrimaryContactPhFieldValue = System.currentPageReference().getParameters().get('hiddenPrimaryContactPhField');
	            if(hiddenPrimaryContactPhFieldValue != null && hiddenPrimaryContactPhFieldValue != ''){
	            	selectedPh = hiddenPrimaryContactPhFieldValue;
	            }
	            next();
            }
        }catch(Exception e){
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage());
            ApexPages.addMessage(msg);
        }
       
    }
    
    public Pagereference next(){
        try{
            selectedConId = System.currentPageReference().getParameters().get('hiddenContact');
            if(selectedConId == null || selectedConId == ''){
            	selectedConId = newConId;
            }
            if(selectedConId == null || selectedConId == ''){
                ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Please select a contact to create a Quote!');
                ApexPages.addMessage(msg);
                return null;
            }
            String hiddenContactPhFieldValue = System.currentPageReference().getParameters().get('hiddenContactPhField');
            if(!isFromNewContact){
            	selectedPh = hiddenContactPhFieldValue;
            	if(selectedPh == null || selectedPh == ''){
            		ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Please select either phone # or Mobile # as primary contact!');
	                ApexPages.addMessage(msg);
	                return null;
            	}
            	String hiddenContactPhValue = System.currentPageReference().getParameters().get('hiddenContactPh');
            	if(hiddenContactPhValue == null || hiddenContactPhValue == ''){
            		ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, 'The selected primary contact does not have any value!');
	                ApexPages.addMessage(msg);
	                return null;
            	}
            }
            if(jpId != null && jpId != ''){
            	if(Operation == 'qq'){
					url = '/apex/QuickQuoteMain_VF?recId='+jpId+'&scId='+scId+'&conId='+selectedConId+'&accId='+AccId+'&source=jp&conPh='+selectedPh;
			    }else{
			    	url = '/apex/FullQuoteForm_VF?id='+jpId+'&scId='+scId+'&conId='+selectedConId+'&accId='+AccId+'&source=jp&conPh='+selectedPh;
			    }
            }else{
            	if(Operation == 'qq'){
	                if(Source == 'account'){
	                    url = '/apex/QuickQuoteMain_VF?recId='+AccId+'&conId='+selectedConId+'&conPh='+selectedPh;
	                }
	                if(Source == 'Opportunity'){
	                    url = '/apex/QuickQuoteMain_VF?recId='+accOrOppId+'&conId='+selectedConId+'&conPh='+selectedPh;
	                }
	            }else if(Operation == 'fq'){
	                if(Source == 'account'){
	                    url = '/apex/FullQuoteForm_VF?id='+AccId+'&conId='+selectedConId+'&conPh='+selectedPh;
	                }
	                if(Source == 'Opportunity'){
	                    url = '/apex/FullQuoteForm_VF?id='+accOrOppId+'&conId='+selectedConId+'&conPh='+selectedPh;
	                }
	            }else if(Operation == 'qqToFq'){
	                url = '/apex/FullQuoteForm_VF?QuickQuoteId='+accOrOppId+'&conId='+selectedConId+'&conPh='+selectedPh;
	                
	            }else if(Operation == 'clone'){
	                url = '/apex/FullQuoteForm_VF?fullQUoteId='+fullQuoteId+'&clone=true&conId='+selectedConId+'&conPh='+selectedPh;
	                
	            }
            }
            
        }catch(Exception e){
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage());
            ApexPages.addMessage(msg);
        }
        return null;
    }
    
    public void isContactAvailable(list<Contact> listCon){
        try{
            if(!listCon.isEmpty()){
                IsContactPresent = true;
            }else{
                ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, 'No Contacts found!');
                ApexPages.addMessage(msg);
                IsContactPresent = false;
            }
        }catch(Exception e){
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage());
            ApexPages.addMessage(msg);
        }
    }
    
    public String getAccountId(String accOrOpId){
        try{
            String AccountId = '';
            if(accOrOpId != null && accOrOpId != '' && accOrOpId.startsWith('001')){
                AccountId = accOrOpId;
                Source = 'account';
            }
            if(accOrOpId != null && accOrOpId != '' && accOrOpId.startsWith('006')){
                Opportunity oppRec = [select id, AccountId from Opportunity where Id = :accOrOpId];
                if(oppRec != null){
                    AccountId = oppRec.AccountId;
                    Source = 'Opportunity';
                }
            }
            if(accOrOpId != null && accOrOpId != '' && Operation == 'qqToFq'){
                MMI_Quotes__c qqObj = [select Id, Opportunity__c from MMI_Quotes__c where Id = :accOrOpId];
                if(qqObj != null && qqObj.Opportunity__c != null){
                    Opportunity oppRec = [select id, AccountId from Opportunity where Id = :qqObj.Opportunity__c];
                    if(oppRec != null){
                        AccountId = oppRec.AccountId;
                        Source = 'qq';
                    }
                }else{
                    ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, 'This Quick Quote does not have any Opportunity!');
                    ApexPages.addMessage(msg);
                }
            }
            return AccountId;
        }catch(Exception e){
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage());
            ApexPages.addMessage(msg);
            return null;
        }
    }
    public Boolean isPersonalAcc(String AccId){
        try{
            Account acc = [select id, isPersonAccount from Account where Id = :AccId];
            if(acc != null && acc.IsPersonAccount){
                return true;
            }else{
                return false;
            }
        }catch(Exception e){
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage());
            ApexPages.addMessage(msg);
            return null;
        }
    }

}