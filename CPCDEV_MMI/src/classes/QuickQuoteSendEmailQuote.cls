public with sharing class QuickQuoteSendEmailQuote {
  public String isEnableAction {get; set;}
  public string prodctname{get;set;}
  public List<Attachment> attachmentList {get;set;}
	public set<String> toAddressSet {get;set;}
	public set<String> ccAddressSet {get;set;}
	public set<String> bccAddressSet {get;set;}
	public String toAddress {get;set;}
	public String ccAddress {get;set;}
	public String bccAddress {get;set;}
	public String subject {get;set;}
	public String mailBody {get;set;}
	public String qqId {get;set;}
	public list<ConWrapper> lstConWrapper {get;set;}
	public MMI_Quotes__c qqData {get;set;}
	public Boolean isContactPresent {get;set;}
	public User loginUserRec {get;set;}
	public String accOwnerOfQQId {get;set;}
	
	public list<SelectOption> lstFldr {get;set;}
	public String selectedFolder {get;set;}
	public list<EmailTemplate> lstEmailTemplate {get;set;}
	public String selectedEmailTemplateId {get;set;}
	public String generatedMailBody {get;set;}
	public Boolean isThereATemplate {get;set;}
	
	public String accRecordId {get;set;}
	public String oppRecordId {get;set;}
	public String contactRecordId {get;set;}
	
	public QuickQuoteSendEmailQuote(){
    	isEnableAction = 'Start';
		toAddressSet = new set<String>();
		ccAddressSet = new set<String>();
		bccAddressSet = new set<String>();
		lstConWrapper = new list<ConWrapper>();
		list<Folder> lstFolder = [Select f.Type, f.Name, f.Id From Folder f where f.Type = 'Email'];
		lstFldr = new list<SelectOption>();
		lstFldr.add(new SelectOption('','--None--'));
		if(lstFolder.size() > 0){
			for(Folder f : lstFolder){
				lstFldr.add(new SelectOption(f.Id,f.Name));
			}
		}
		
		isThereATemplate = false;
		isContactPresent = true;
		loginUserRec = [Select Id,Email,Fax,Phone,Extension__c, Name, Sales_Rep_Id__c,UserRole.Name,Street,City,State,PostalCode,MobilePhone from User where Id = :UserInfo.getUserId()];
		qqId = Apexpages.currentPage().getParameters().get('recId');
	    if(qqId !=null && qqId != ''){
	      qqData = [Select m.Product__c, m.Opportunity__r.AccountId,Opportunity__r.Opportunity_Contact_Name_LookUpFilter__c, m.Opportunity__c, m.Id, m.QQ_Type__c From MMI_Quotes__c m where Id = :qqId]; 
	      if(qqData != null){
	      	oppRecordId =  qqData.Opportunity__c;
	      	if(qqData.Opportunity__r != null && qqData.Opportunity__r.Opportunity_Contact_Name_LookUpFilter__c != null){
	      		contactRecordId = qqData.Opportunity__r.Opportunity_Contact_Name_LookUpFilter__c;
	      	}
	      }
	    }
    
		if(qqData != null && qqData.Opportunity__r.AccountId != null){
			Account accRec = [Select a.IsPersonAccount, a.Id,a.OwnerId From Account a where Id = :qqData.Opportunity__r.AccountId];
			if(accRec != null){
				accOwnerOfQQId = accRec.OwnerId;
				accRecordId = accRec.Id;
			}
			if(accRec != null && accRec.IsPersonAccount){
				accRec = [Select a.PersonEmail, a.LastName, a.IsPersonAccount, a.Id, a.FirstName From Account a where Id = :qqData.Opportunity__r.AccountId and IsPersonAccount != null];
				if(accRec != null){
					lstConWrapper = new list<ConWrapper>();
					ConWrapper wrapObj = new ConWrapper();
					wrapObj.isChecked = false;
					ContactList conRec = new ContactList();
					conRec.contactName = accRec.FirstName + '' +accRec.LastName;
					conRec.contactEmail = accRec.PersonEmail;
					wrapObj.conObj = conRec;
					lstConWrapper.add(wrapObj);
				}
			}else{
				list<Contact> qqConData = new list<Contact>();
				qqConData = [Select c.Name, c.Id, c.Email, c.AccountId From Contact c where c.Email != null And c.AccountId = :qqData.Opportunity__r.AccountId];
				if(qqConData != null && !qqConData.isEmpty()){
					lstConWrapper = new list<ConWrapper>();
					for(Contact c : qqConData){
						ConWrapper wrapObj = new ConWrapper();
						wrapObj.isChecked = false;
						ContactList conRec = new ContactList();
						conRec.contactName = c.Name;
						conRec.contactEmail = c.Email;
						wrapObj.conObj = conRec;
						lstConWrapper.add(wrapObj);
					}
				}
			}
			
		}
		if(lstConWrapper.size() < 1){
			isContactPresent = false;
		}
	}
	
	public void fillTo(){
		system.debug('------------toAddress-----------'+toAddress);
		if(toAddress.length() > 0){
			list<String> toAddressLst = toAddress.split(';');
			if(toAddressLst.size() > 0){
				toAddressSet = new set<String>();
				for(String s : toAddressLst){
					toAddressSet.add(s);
				}
			}
		}else{
			toAddressSet = new set<String>();
		}
		for(ConWrapper w : lstConWrapper){
			if(w.isChecked){
				toAddressSet.add(w.conObj.contactEmail);
				w.isChecked = false;
			}
		}
		if(toAddressSet.size() > 0){
			toAddress = '';
			for(String s : toAddressSet){
				toAddress = toAddress + s + ';';
			}
			if(toAddress.length() > 0){
				toAddress = toAddress.substring(0,toAddress.length() - 1 );
			}
		}
		
	}
	
	public void fillCC(){
		if(ccAddress.length() > 0){
			list<String> ccAddressLst = ccAddress.split(';');
			if(ccAddressLst.size() > 0){
				ccAddressSet = new set<String>();
				for(String s : ccAddressLst){
					ccAddressSet.add(s);
				}
			}
		}else{
			ccAddressSet = new set<String>();
		}
		for(ConWrapper w : lstConWrapper){
			if(w.isChecked){
				ccAddressSet.add(w.conObj.contactEmail);
				w.isChecked = false;
			}
		}
		if(ccAddressSet.size() > 0){
			ccAddress = '';
			for(String s : ccAddressSet){
				ccAddress = ccAddress + s + ';';
			}
			if(ccAddress.length() > 0){
				ccAddress = ccAddress.substring(0,ccAddress.length() - 1 );
			}
		}
	}
	
	public void fillBCC(){
		if(bccAddress.length() > 0){
			list<String> bccAddressLst = bccAddress.split(';');
			if(bccAddressLst.size() > 0){
				bccAddressSet = new set<String>();
				for(String s : bccAddressLst){
					bccAddressSet.add(s);
				}
			}
		}else{
			bccAddressSet = new set<String>();
		}
		for(ConWrapper w : lstConWrapper){
			if(w.isChecked){
				bccAddressSet.add(w.conObj.contactEmail);
				w.isChecked = false;
			}
		}
		if(bccAddressSet.size() > 0){
			bccAddress = '';
			for(String s : bccAddressSet){
				bccAddress = bccAddress+ s + ';';
			}
			if(bccAddress.length() > 0){
				bccAddress = bccAddress.substring(0,bccAddress.length() - 1 );
			}
		}
	}
	
	public PageReference sendMail(){
		if(toAddress != null && toAddress != ''){
			blob AttachmentPdf = null;
			Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
	        list<Messaging.EmailFileAttachment> attachList = new List<Messaging.EmailFileAttachment>();
	        
			system.debug('-----------toAddress------'+toAddress);
			list<string> toAddresses = new list<string>();
	        toAddresses = toAddress.split(';');
	        toAddresses = trimAddress(toAddresses);
	        system.debug('-----------toAddresses------'+toAddresses);
	        for(String s : toAddresses ){
				if(!checkEmailAddress(s)){
					ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'To email adress \''+s+'\' is invalid!');
		        	ApexPages.addMessage(msg);
		        	return null;
				}
			}
	        mail.setToAddresses(toAddresses);
	        list<string> ccEmail = new list<string>(); 
	        if(ccAddress != null && ccAddress != ''){
	        	ccEmail = ccAddress.split(';');
	        	if(!ccEmail.isEmpty()){
	        		ccEmail = trimAddress(ccEmail);
	        		for(String s : ccEmail ){
						if(!checkEmailAddress(s)){
							ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'CC email adress \''+s+'\' is invalid!');
				        	ApexPages.addMessage(msg);
				        	return null;
						}
					}
	            	//mail.setCcAddresses(ccEmail);
	        	}  
	        }
	        //-----------------TFS 2710-----------------------
	        system.debug('------------accOwnerOfQQId-----------'+accOwnerOfQQId);
	        if(accOwnerOfQQId != null && accOwnerOfQQId != ''){
	        	User accOwnerOfQQRecord = FullQuoteDAO.getUserDetails(accOwnerOfQQId);
	        	system.debug('------------accOwnerOfQQRecord.EMail-----------'+accOwnerOfQQRecord.EMail);
            	if(accOwnerOfQQRecord.EMail != null && accOwnerOfQQRecord.Email != ''){
            		ccEmail.add(accOwnerOfQQRecord.EMail);
            	}
	        }
	        ccEmail.add(loginUserRec.Email);
	        system.debug('------------ccEmail-----------'+ccEmail);
	        mail.setCcAddresses(ccEmail);
	        if(bccAddress != null && bccAddress != ''){
	        	list<string> bccEmail = bccAddress.split(';');
	        	if(!bccEmail.isEmpty()){
	        		for(String s : bccEmail ){
	        			bccEmail = trimAddress(bccEmail);
						if(!checkEmailAddress(s)){
							ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'BCC email adress \''+s+'\' is invalid!');
				        	ApexPages.addMessage(msg);
				        	return null;
						}
					}
	            	mail.setBccAddresses(bccEmail);
	        	}  
	        }
	        if(!test.isRunningTest()){
            if(qqId != null && qqId != ''){
		        Pagereference pdfcont  = new PageReference('/apex/QuickQuoteEmailQuote?recId='+qqId);
		        pdfcont.setRedirect(false);
		        AttachmentPdf = pdfcont.getContent();
            }else{
              system.debug('');
            }
          }
		        Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
		        attach.setContentType('application/pdf');
		        if(qqData.QQ_Type__c == 'Rental'){
		        	attach.setFileName('RentalQuickQuotePreview.pdf');   
		        }else{
		            attach.setFileName('SalesQuickQuotePreview.pdf');
		        }
		        attach.setInline(false);
		        if(AttachmentPdf != null){
		    		attach.Body = AttachmentPdf;
		        }
		        attachList.add(attach);
		        
            // Akash added
            List<Document> docuemnt;
              docuemnt = new List<Document>();
              MMI_Quotes__c qqDataobj = new MMI_Quotes__c();
        if(qqId != null && qqId != ''){
                qqDataobj = [Select m.Product__c, m.Opportunity__r.AccountId, m.Opportunity__c, m.Id, m.QQ_Type__c From MMI_Quotes__c m where Id = :qqId];          
        }              

            
            prodctname = qqDataobj.Product__c;
            system.debug('-prodctname--'+prodctname);
             
            List<Product_Brochures_Lookup__c> produBrochList = [Select p.Product_Image__c, p.Product_Id__c, p.Product_Document_Brochures_Name__c, p.Name, p.Id From Product_Brochures_Lookup__c p where Product_Id__c = :prodctname limit 1];
            
                if(!produBrochList.isEmpty()){
                    docuemnt = [Select d.Url, d.Type, d.SystemModstamp, d.NamespacePrefix, d.Name, d.LastModifiedDate, d.LastModifiedById, d.Keywords, d.IsPublic, d.IsInternalUseOnly, d.IsDeleted, d.IsBodySearchable, d.Id, d.FolderId, d.DeveloperName, d.Description, d.CreatedDate, d.CreatedById, d.ContentType, d.BodyLength, d.Body, d.AuthorId From Document d where Name =:produBrochList[0].Product_Document_Brochures_Name__c limit 1];
                }
                
                if(!docuemnt.isEmpty()){
                Messaging.EmailFileAttachment docattach = new Messaging.EmailFileAttachment();
                docattach.setContentType('application/pdf');
                docattach.setFileName(docuemnt[0].Name+'.pdf');
                docattach.setInline(false);
                docattach.Body = docuemnt[0].Body;
                attachList.add(docattach);
                }
                List<Attachment> attachmentlist = new List<Attachment>();
        if(qqId != null && qqId != ''){
          attachmentlist = [Select a.ParentId ,a.Name ,a.Body From Attachment a where parentid = :qqId];  
        }                 
            
        
                if(!attachmentlist.isEmpty()){ 
            for(Attachment  aa : attachmentlist){
            Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment(); 
               efa.setFileName(aa.Name); 
              efa.setBody(aa.Body); 
              attachList.add(efa);
          }
        }
                //String UserSign = '<br/><br/><br/><table align="left"><tr><td><b>'+loginUserRec.Name+'</b></td></tr><tr><td>'+loginUserRec.UserRole.Name+'</td></tr><tr><td>'+loginUserRec.Street+'|'+loginUserRec.City+''+loginUserRec.State+''+loginUserRec.PostalCode+'</td></tr><tr><td>o:'+loginUserRec.Phone+','+loginUserRec.Extension__c+'</td></tr><tr><td>m:'+loginUserRec.MobilePhone+'</td></tr><tr><td>'+loginUserRec.Email+'</td></tr><tr><td><img src="https://c.na6.content.force.com/servlet/servlet.ImageServer?id=01580000001rJ2A&oid=00D80000000azTL" /></td></tr></table>';
		        //String UserSign = generateSignature(loginUserRec);
		        //mailBody = mailBody + UserSign;
		        mail.setUseSignature(false);
		        mail.setSubject(subject);
		        //mail.setplainTextBody(mailBody);
		        if(mailBody != null && mailBody != ''){
		        	mailBody = mailBody.replace('\n','<br/>');
		        }
		        mail.setHtmlBody(mailBody);
		        mail.setFileAttachments(attachList);
	        system.debug('-----------mail------'+mail);
	        if(!test.isRunningTest()){
	        	List<Messaging.SendEmailResult> emailResults = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
	        	system.debug('----------emailResults-------'+emailResults);
	        	if (!emailResults.get(0).isSuccess()) {
				    //System.StatusCode statusCode = emailResults.get(0).getErrors()[0].getStatusCode();
				    ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.ERROR, emailResults.get(0).getErrors()[0].getMessage());
        			ApexPages.addMessage(msg);
				}else{
					ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.CONFIRM, 'Mail has been sent successfully!');
	        		ApexPages.addMessage(msg);
	        		//------------TFS 2708----------------------
	                Task taskObj1 = new Task();
	                taskObj1.OwnerId = UserInfo.getUserId();
	                taskObj1.Subject = 'Send Quote';
	                taskObj1.ActivityDate = system.today();
	                taskObj1.Call_Type__c = 'OB-Email';
	                taskObj1.Call_Result__c = '';
	                taskObj1.Description = '';
	                taskObj1.Status = 'Completed';
	                taskObj1.Priority = 'Normal';
	                if(!toAddresses.IsEmpty() && toAddresses.size() > 0){
	                	taskObj1.Customer_Email__c = toAddresses[0];
	                }
	                system.debug('------------qqData.Opportunity__c-------------------'+qqData.Opportunity__c);
	                if(qqData != null && qqData.Opportunity__c != null){
	                	taskObj1.WhatId = qqData.Opportunity__c;
	                }
	                insert taskObj1;
                	//------------TFS 2708----------------------
				}
            	delete attachmentlist;
	        	
	        } 
	        toAddress = '';
	        ccAddress = '';
	        bccAddress = '';
	        subject = '';
	        mailBody = '';
			return null;
		}else{
	        ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.INFO, 'Please select To Address!');
	        ApexPages.addMessage(msg);
	        return null;
		}
	}
	public PageReference cancelMail(){
    delete attachmentlist = [Select a.ParentId ,a.Name ,a.Body From Attachment a where parentid = :qqId];
		PageReference pr = new PageReference('/'+qqId);
		pr.setRedirect(true);
		return pr;
	}
	
	public class ConWrapper{
		public Boolean isChecked {get;set;}
		public ContactList conObj {get;set;}
	}
	
	public class ContactList{
		public String contactName {get;set;}
		public String contactEmail {get;set;}
	}
	
	public Boolean checkEmailAddress(String Email){
		Boolean res = true;
		String emailRegex = '^[a-zA-Z0-9._|\\\\%#~`=?&/$^*!}{+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,4}$'; // source: http://www.regular-expressions.info/email.html
		Pattern MyPattern = Pattern.compile(emailRegex);
		Matcher MyMatcher = MyPattern.matcher(email);
		if (!MyMatcher.matches()){ 
	    	res = false;
		}
		return res;
	}
	
	public list<String> trimAddress(list<String> lstStr){
		system.debug('-----------lstStr--before----'+lstStr);
		list<String> lstTrimmedString = new list<String>();
		for(String s : lstStr){
			s = s.trim();
			lstTrimmedString.add(s);
		}
		system.debug('-----------lstStr-after-----'+lstStr);
		return lstTrimmedString;
		
	}
  public void attachmentListViewMethod(){
      attachmentList =  [Select a.ParentId ,a.Name From Attachment a where ParentId = :qqId];
    }
     public void deleteAttachach(){
        String attachDeleId= Apexpages.currentPage().getParameters().get('attachId');
        List<Attachment> att =  [Select a.ParentId ,a.Name From Attachment a where id = :attachDeleId];
        if(att.size() > 0){
          delete att;  
        }
          attachmentList =  [Select a.ParentId ,a.Name From Attachment a where ParentId = :qqId];
    
        //attachId  
      }
      
      public string generateSignature(User uRec){
      	String UserSign = '';
      	UserSign += '<br/><br/><br/><table align="left"><tr><td><b>'+uRec.Name+'</b></td></tr><tr><td>'+uRec.UserRole.Name+'</td></tr><tr><td>';
      	if(uRec.Street != null && uRec.Street != ''){
      		UserSign += uRec.Street+'|';
      	}
      	if(uRec.City != null && uRec.City != ''){
      		UserSign += uRec.City+' ';
      	}
      	if(uRec.State != null && uRec.State != ''){
      		UserSign += uRec.State+' ';
      	}
      	if(uRec.PostalCode != null && uRec.PostalCode != ''){
      		UserSign += uRec.PostalCode+' ';
      	}
      	UserSign += '</td></tr><tr><td>o:';
      	if(uRec.Phone != null && uRec.Phone != ''){
      		UserSign += uRec.Phone+','+uRec.Extension__c;
      	}
      	UserSign += '</td></tr><tr><td>m:';
      	if(uRec.MobilePhone != null && uRec.MobilePhone != ''){
      		UserSign += uRec.MobilePhone;
      	}
      	UserSign += '</td></tr><tr><td>';
      	if(uRec.Email != null && uRec.Email != ''){
      		UserSign += uRec.Email;
      	}
      	UserSign += '</td></tr><tr><td><img src="https://c.na6.content.force.com/servlet/servlet.ImageServer?id=01580000001rJ2A&oid=00D80000000azTL" /></td></tr></table>';
      	return UserSign;
      } 
      
      public void showEmailTemplate(){
      	lstEmailTemplate = new list<EmailTemplate>();
      	lstEmailTemplate = [Select e.Name, e.Id, e.FolderId From EmailTemplate e where e.FolderId = :selectedFolder and e.TemplateType = 'Text' order by e.Name];
      	system.debug('------------lstEmailTemplate---------------'+lstEmailTemplate);
      	if(lstEmailTemplate.size() > 0){
      		isThereATemplate = true;
      	}else{
      		isThereATemplate = false;
      	}
      }
      
      public PageReference generateEmailBody(){
      	selectedEmailTemplateId = System.currentPageReference().getParameters().get('hiddenSelectedEmailTemplate');
      	system.debug('------------qqId---------------'+qqId);
      	system.debug('------------oppRecordId---------------'+oppRecordId);
      	system.debug('------------accRecordId---------------'+accRecordId);
      	system.debug('------------contactRecordId---------------'+contactRecordId);
      	if(selectedEmailTemplateId != null && selectedEmailTemplateId != ''){
      		generatedMailBody = EmailTempalteBodyGeneraterUtil.generateEmailBody(qqId,oppRecordId,accRecordId,contactRecordId,'qq',selectedEmailTemplateId);
	      	system.debug('------------generatedMailBody---------------'+generatedMailBody);
	      	mailBody = generatedMailBody;
	      	EmailTemplate emailTemplateObj = [Select e.TemplateType, e.TemplateStyle, e.Subject, e.Name, e.IsActive, e.Id, e.Folder.Name, e.Folder.Id, e.FolderId, e.DeveloperName, e.Description, e.Body,e.HtmlValue From EmailTemplate e where e.Id = :selectedEmailTemplateId];
	      	if(emailTemplateObj != null){
	      		String subjectWithMergeFld = emailTemplateObj.Subject;
	      		if(subjectWithMergeFld != null && subjectWithMergeFld != '' && contactRecordId != null && subjectWithMergeFld.contains('{!Contact.')){
	      			subjectWithMergeFld = EmailTempalteBodyGeneraterUtil.mergeContactFields(subjectWithMergeFld, contactRecordId); // get all Contact Field Merged
	      		}
	      		if(subjectWithMergeFld != null && subjectWithMergeFld != '' && accRecordId != null && subjectWithMergeFld.contains('{!Account.')){
	      			subjectWithMergeFld = EmailTempalteBodyGeneraterUtil.mergeAccountFields(subjectWithMergeFld, accRecordId); // get all Account Field Merged
	      		}
	      		if(subjectWithMergeFld != null && subjectWithMergeFld != '' && oppRecordId != null && subjectWithMergeFld.contains('{!Opportunity.')){
	      			subjectWithMergeFld = EmailTempalteBodyGeneraterUtil.mergeOpportunityFields(subjectWithMergeFld, oppRecordId); // get all Opportunity Field Merged
	      		}
	      		if(subjectWithMergeFld != null && subjectWithMergeFld != '' && qqId != null && subjectWithMergeFld.contains('{!MMI_Quotes__c.')){
	      			subjectWithMergeFld = EmailTempalteBodyGeneraterUtil.mergeQQFields(subjectWithMergeFld, qqId); // get all QQ Field Merged
	      		}
	      		if(subjectWithMergeFld != null && subjectWithMergeFld != '' && subjectWithMergeFld.contains('{!User.')){
	      			subjectWithMergeFld = EmailTempalteBodyGeneraterUtil.mergeUserFields(subjectWithMergeFld, UserInfo.getUserId()); // get all User Field Merged
	      		}
	      		if(subjectWithMergeFld != null && subjectWithMergeFld != '' && accOwnerOfQQId != null && subjectWithMergeFld.contains('{!Account.Owner')){
	      			subjectWithMergeFld = EmailTempalteBodyGeneraterUtil.mergeAccountOwnerUserFields(subjectWithMergeFld, accOwnerOfQQId); // get all Account Owner Field Merged
	      		}
	      		subject = subjectWithMergeFld;
	      	}
      	}else{
      		ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.ERROR, 'Please select an email Template!');
	        ApexPages.addMessage(msg);
	        return null;
      	}
      	return null;
      }

}