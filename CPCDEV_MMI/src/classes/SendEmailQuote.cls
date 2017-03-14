/**
* (c) 2015 TEKsystems Global Services
*
* Name           : SendEmailQuote 
* Created Date   : 24 Nov, 2015 @ 1130
* Created By     : Ankur Goyal (TEKSystems)
* Purpose        : Controller class used by 'SendEmailQuote' VF page.
* Last Updated By: Ankur Goyal (TEKSystems)
* Last Updated Date: 18-Jan-2016
**/

public with sharing class SendEmailQuote {
    
    public String isEnableAction {get; set;}
    public string prodctname{get;set;}
    public List<Attachment> attachmentList {get;set;}
    public set<String> toAddressSet {get;set;}
    //public set<String> ccAddressSet {get;set;}
    //public set<String> bccAddressSet {get;set;}
    public String toAddress {get;set;}
    public String toAddress1 {get;set;}
    //public String ccAddress {get;set;}
    //public String bccAddress {get;set;}
    public String subject {get;set;}
    public String mailBody {get;set;}
    public String usMailFooter1{get;set;}
    public String usMailFooter2{get;set;}
    public String repName{get;set;}
    
    public String mailBody1 {get;set;}
    public String quoteID {get;set;}
    public list<ConWrapper> lstConWrapper {get;set;}
    public Quote_Header__c qqData {get;set;}
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
    public Boolean isUK{get;set;}
    public String salesOrgID{get;set;}
    public String salesRepMail{get;set;}
    public String contactMail{get;set;}
    public String pdfType{get;set;}
    public Boolean validParams{get;set;}
    public Boolean brochureChecked{get;set;}
    public Boolean unitChecked{get;set;}
    public Boolean shafChecked{get;set;}
    public Boolean hireGuide{get;set;}
    public Boolean newAccForm{get;set;}
    public boolean isMailSentUK{get;set;}
    public boolean isMailSent{get;set;}
    Map<String,String> mapProdTypetoUnitInfo;
    Map<String,String> mapProdTypetoBrochure;
    Map<String,String> mapProdTypetoSHAF;
    Map<String,String> mapProdTypetoWaiver;
    Map<String,String> mapProdTypetoApplication;
    public String quoteProduct;
    //public List<Quote_Item_Level__c> quoteProds{get;set;}
    //public Set<String> prods{get;set;}
    public Boolean Accomodation_Brochure_UK{get;set;}
    public Boolean STORAGE_UK{get;set;}
    public Boolean Welfare_Unit_Product_Card_A4{get;set;}
    public Boolean Storage_Container_Product_Card_A4_pdf{get;set;}
    public boolean Accommodation_Product_Card_A4{get;set;}
    public boolean Anti_Vandal_Toilet_Units_Product_Card_A4_pdf{get;set;}
    public string lastName{get;set;}
    public string firstName{get;set;}
    public string fullName{get;set;}
    public string quoteType{get;set;}
    public string Quotepdftype{get;set;}
    public String selectedPDF { get; set; }
    public String selectedTOC { get; set; }
    public List<SelectOption> PDFtypeNE{get;set;}
    public List<SelectOption> termOfCont{get;set;}
    public boolean renderButtons{get;set;}
    
    public string ukMailHeader{get;set;}
    public string ukMailFooter{get;set;}
    public string ukMAilBody{get;set;}
    
    public List<SelectOption> WMIAccessories{get;set;}
    public String selectedAccOpt{ get; set; }
    
    public List<SelectOption> LumpSum{get;set;}
    public String selectedLumpSum{ get; set; }
          
    public SendEmailQuote(){
        selectedAccOpt = 'No';
        selectedLumpSum = 'No';
        isEnableAction = 'Start';
        
        toAddressSet = new set<String>();
        //ccAddressSet = new set<String>();
        //bccAddressSet = new set<String>();
        lstConWrapper = new list<ConWrapper>();
        
        //List of email template folders
        list<Folder> lstFolder = [Select f.Type, f.Name, f.Id From Folder f where f.Type = 'Email' and Name in('HomeBase Templates','NSC Templates')];
        lstFldr = new list<SelectOption>();
        PDFtypeNE = new list<SelectOption>();
        PDFtypeNE.add(new SelectOption('Select','-- Select --'));
        PDFtypeNE.add(new SelectOption('Normal','Normal'));
        PDFtypeNE.add(new SelectOption('Extended','Extended'));
        
        termOfCont = new list<SelectOption>();
        termOfCont.add(new SelectOption('No','No'));
        termOfCont.add(new SelectOption('Yes','Yes'));
        
        WMIAccessories = new list<SelectOption>();
        WMIAccessories.add(new SelectOption('No','No'));
        WMIAccessories.add(new SelectOption('Yes','Yes'));
        
        LumpSum = new list<SelectOption>();
        LumpSum.add(new SelectOption('No','No'));
        LumpSum.add(new SelectOption('Yes','Yes'));
        
        lstFldr.add(new SelectOption('','--None--'));
        if(lstFolder.size() > 0){
            for(Folder f : lstFolder){
                lstFldr.add(new SelectOption(f.Id,f.Name));
            }
        }
        
        quoteID = ApexPages.currentPage().getParameters().get('quoteID');
        salesOrgID = ApexPages.currentPage().getParameters().get('salesorg');
        pdfType = ApexPages.currentPage().getParameters().get('type');
        toAddress = '';
        contactMail = '';
        salesRepMail = '';
        contactRecordId = '';
        //Check if the appropriate parameter values are passed in the URL
        if(quoteID != '' && quoteID != null && salesOrgID != '' && salesOrgID != null && pdfType != '' && pdfType != null )
        {
            if( pdfType.equalsIgnoreCase('sales') || pdfType.equalsIgnoreCase('rental') ){
                validParams = true;
            }
            else{
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Invalid value for parameter type. Valid values for type are sales or rental');
                ApexPages.addMessage(msg);    
            }    
        }
        else
        {
            validParams = false; 
            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Please make sure appropriate values are passed for parameters quoteID, salesorg, type!');
            ApexPages.addMessage(msg);   
        }
        
        //Based on salesorg value email landing page is displayed(UK or US)
        if(salesOrgID == '1200'){
            isUK  = true;
                          
        }    
        else{
            isUK = false;
                
        }
        if(salesOrgID == '1000' || salesOrgID == '1100')
            renderButtons = false; 
        else
            renderButtons = true;     
                
        isThereATemplate = false;
        isContactPresent = true;
        loginUserRec = [Select Id,Email,Fax,Phone,Extension,Extension__c, Name,Title, Sales_Rep_Id__c,UserRole.Name,Street,City,State,PostalCode,MobilePhone from User where Id = :UserInfo.getUserId()];
        repName = loginUserRec.Name;
        repName = repName.replace('\'','');
        
        if(quoteID !=null && quoteID != ''){
        //query contact, account, opportunity and sales rep details from quote header
          List<Quote_Header__c> qt = [Select q.name,q.Account__c,q.Opportunity__r.AccountId,q.contact__c,q.contact__r.name,q.SalesRep_Email__c, q.Opportunity__c, q.Id,type__c From Quote_Header__c q where Id = :quoteID]; 
          if(qt.size() > 0){
             qqData = qt[0];
             quoteType = qqData.Type__c;
             subject = 'Quote Review and Approval - ' +qqData.name;
          if(qqData != null){
            oppRecordId =  qqData.Opportunity__c;
            if(qqData.contact__c != null){
                contactRecordId = qqData.contact__c;
                Contact con = [select id,email,Name,lastName,firstName from contact where id= :contactRecordId];
                contactMail = String.valueof(con.email);
                lastName = con.lastName;
                firstName = con.firstName;
                if(lastName != '' && lastName != null)
                    lastName = lastName.replace('\'',''); 
                if(firstName != '' && firstName != null)
                    firstName = firstName.replace('\'','');
                 system.debug('-------Name-------'+firstName);    
                fullName = con.Name;
                system.debug('-------Name-------'+fullName);
            }
            if(contactMail != null && contactMail != ''){
                toAddress = contactMail ; //+ '[' + firstName + ' ' + lastName +']'; 
                toAddress1 = contactMail;   
            }
            else{
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'No email present for the contact '+qqData.contact__r.name);
                ApexPages.addMessage(msg);    
            }
            generateEmailBody();    
            salesRepMail = qqData.SalesRep_Email__c;
            List<User> u = [select id,Name,Email from user where Email =:qqData.SalesRep_Email__c];
            
            if(isUK){
                //if(salesRepMail != null && salesRepMail != '' && contactMail != null && contactMail != '' )
                //    toAddress = contactMail + ';' + salesRepMail;
                //if(salesRepMail != null && salesRepMail != '' && (contactMail == null || contactMail == '' ))
                //    toAddress = salesRepMail ;  
                //if( (salesRepMail == null || salesRepMail == '' ) && contactMail != null && contactMail != '' )
                //    toAddress = contactMail;
                //if(u.size() < 1)    
                toAddress = contactMail;
                ukMailHeader = 'Dear ' + fullName + ',\n\n';
                ukMailFooter = '\n\nKind regards,\n' + loginUserRec.Name + '\n' + loginUserRec.Title + '\n' + loginUserRec.Street + ' ' + loginUserRec.City + ', ' + loginUserRec.State + ' ' + loginUserRec.PostalCode + '\nO: ' + loginUserRec.Phone + ' x ' + loginUserRec.Extension + '\nM: ' + loginUserRec.MobilePhone + '\n' + loginUserRec.Email + '\nwww.mobilemini.co.uk';
                //ukMailBody = ukMailHeader + 'Thank you for your recent business and allowing me the opportunity to service your storage needs. I greatly appreciate your business and the confidence you have placed in Mobile Mini, Inc.\n\nWe look forward to making your storage or office solution hassle-free, with many convenient services from beginning to end. With our patented security features and all-steel containers, your stored items will always stay safe.\n\nPlease contact me whenever I can be of further assistance. I look forward to working with you again.';        
                ukMailBody = ukMailHeader + 'Thank you for your enquiry.\n\nPlease find attached your quote as discussed.\n\nIf you have any questions, please do not hesitate to contact me on the details below.'; 
                subject = 'Quote Review and Approval - ' + qqData.name;
           }
           //if(toAddress.length() > 0) 
           //    toAddress = toAddress.deletewhitespace(); 
          }
          }else{
              validParams = false;
              ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Invalid quote ID');
              ApexPages.addMessage(msg);
             // return null;    
          }
          
        }
    
        if(qqData != null && qqData.Account__c != null){
            Account accRec = [Select a.IsPersonAccount, a.Id,a.OwnerId From Account a where Id = :qqData.Account__c];
            if(accRec != null){
                accOwnerOfQQId = accRec.OwnerId;
                accRecordId = accRec.Id;
            }
            if(accRec != null && accRec.IsPersonAccount){
                accRec = [Select a.PersonEmail, a.LastName, a.IsPersonAccount, a.Id, a.FirstName From Account a where Id = :qqData.Account__c and IsPersonAccount != null];
                if(accRec != null){
                    lstConWrapper = new list<ConWrapper>();
                    ConWrapper wrapObj = new ConWrapper();
                    wrapObj.isChecked = false;
                    ContactList conRec = new ContactList();
                    conRec.contactName = accRec.FirstName + ' ' +accRec.LastName;
                    conRec.contactEmail = accRec.PersonEmail;
                    wrapObj.conObj = conRec;
                    lstConWrapper.add(wrapObj);
                }
            }else{
                list<Contact> qqConData = new list<Contact>();
                qqConData = [Select c.Name, c.Id, c.Email, c.AccountId From Contact c where c.Email != null And c.AccountId = :qqData.Account__c];
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
        
        isMailSentUK = false;
        isMailSent = false;
        Accomodation_Brochure_UK=false;
        STORAGE_UK=false;
        Welfare_Unit_Product_Card_A4=false;
        Storage_Container_Product_Card_A4_pdf=false;
        Accommodation_Product_Card_A4=false;
        Anti_Vandal_Toilet_Units_Product_Card_A4_pdf=false;
        
        mapProdTypetoUnitInfo = new Map<String,String>();
        mapProdTypetoBrochure = new Map<String,String>();
        mapProdTypetoSHAF = new Map<String,String>();
        mapProdTypetoWaiver = new Map<String,String>();
        mapProdTypetoApplication = new Map<String,String>();
        
       //Prodcuct type,UnitInfo, Brochure and SHAF mapping from custom setting ProdTypeDocMapping__c 
       /*
       for(ProdTypeDocMapping__c prodMap : ProdTypeDocMapping__c.getAll().values())
       {
          mapProdTypetoUnitInfo.put(prodMap.Product_Type__c,prodMap.UnitInfo_Document_Name__c);
          mapProdTypetoBrochure.put(prodMap.Product_Type__c,prodMap.Brochure_Document_Name__c);
          mapProdTypetoSHAF.put(prodMap.Product_Type__c,prodMap.SHAF_Document_Name__c);
          mapProdTypetoWaiver.put(prodMap.Product_Type__c,prodMap.Damage_Waiver_DocName__c);
          mapProdTypetoApplication.put(prodMap.Product_Type__c,prodMap.Account_Application_DocName__c);
       }
       quoteProduct = 'Canteen';
       quoteProds = [select id,Unit_Type__c from Quote_Item_Level__c where Quote_Header__c =:quoteID];
       prods = new set<String>();
       for(Quote_Item_Level__c q:quoteProds ){
           if(q.Unit_Type__c != null && q.Unit_Type__c != ''){
               prods.add(String.valueof(q.Unit_Type__c));
           }    
       } */
       
    } //end of constructor
    
    /*public void getPDFtypeNE(){
        PDFtypeNE.add(new selectoption('Normal','Normal'));
        PDFtypeNE.add(new selectoption('Extended','Normal'));
        //return PDFtypeNE;
    }
    
    public void checkSelectedPDF(){      
         enableAttachPDF = true;  
    
        system.debug('Selected value is: ' + selectedPDF);        
    } */
    
    public void attachPDFtoQuoteHeader(){
        
        if(salesOrgID == '1200'){ 
         /*   isUK  = true;
            String pdfName = pdfType+'PDF.pdf';
            List<Attachment> attList = [select ID,parentid,name from attachment where parentid =:quoteID and name in('salesPDF.pdf','rentalPDF.pdf','SalesPDF.pdf','RentalPDF.pdf')];
            if(!attList.isEmpty()){
                delete attList;
            }
            blob attachmentPdf = null;
            Pagereference pdfcont  = new PageReference('/apex/QuotePDF_UK?id='+quoteID+'&salorg='+salesOrgID);
            pdfcont.setRedirect(false);
            attachmentPdf = pdfcont.getContent(); 
            
            Attachment attach = new Attachment();
            Blob body;
            if(!test.isRunningTest()){
                body = attachmentPdf;  //.getContent();
            }else{
                body=blob.valueOf('TestString');
            }
            attach.Body = body;
            attach.Name = pdfName;
            attach.IsPrivate = false;
            attach.ParentId = quoteID; 
            attach.Description = 'Quote PDF';   
            insert attach; 
            renderButtons = true; 
           */ 
        }    
        if(salesOrgID == '1500' || salesOrgID == '1501'){
            isUK = false;
            String pdfName = pdfType+'PDF.pdf';
            
            List<Attachment> attList = [select ID,parentid,name from attachment where parentid =:quoteID and name in('rentalNormalPDF.pdf','RentalNormalPDF.pdf','salesNormalPDF.pdf','SalesNormalPDF.pdf','rentalExtendedPDF.pdf','RentalExtendedPDF.pdf','salesExtendedPDF.pdf','SalesExtendedPDF.pdf','RentalPDF.pdf','rentalPDF.pdf','salesPDF.pdf','SalesPDF.pdf')]; //= :pdfName ];
            if(!attList.isEmpty()){
                delete attList;
            }
            blob attachmentPdf = null;
           
                Pagereference pdfcont1  = new PageReference('/apex/QuotePDF_ETS?quoteid='+quoteID+'&type='+pdfType+'&salorg='+salesOrgID+'&accflag='+selectedAccOpt+'&lumpSum='+selectedLumpSum);
                pdfcont1.setRedirect(false);
           
            //attachmentPdf = pdfcont1.getContent(); 
            
            Attachment attach = new Attachment();
            Blob body;
            if(!test.isRunningTest()){
                attachmentPdf = pdfcont1.getContent();
                body = attachmentPdf;  //.getContent();
            }else{
                body=blob.valueOf('TestString');
            }
            attach.Body = body;
            attach.Name = pdfName;
            attach.IsPrivate = false;
            attach.ParentId = quoteID; 
            attach.Description = 'Quote PDF';   
            insert attach;
            renderButtons = true;
        } 
        if( (salesOrgID == '1000' || salesOrgID == '1100') ) {  // && (selectedPDF == 'Extended' || selectedPDF == 'Normal') ){
            
            isUK = false;
            String pdfName = pdfType +selectedPDF+'PDF.pdf';
            List<Attachment> attList = [select ID,parentid,name from attachment where parentid =:quoteID and name in('rentalNormalPDF.pdf','RentalNormalPDF.pdf','salesNormalPDF.pdf','SalesNormalPDF.pdf','rentalExtendedPDF.pdf','RentalExtendedPDF.pdf','salesExtendedPDF.pdf','SalesExtendedPDF.pdf','RentalPDF.pdf','rentalPDF.pdf','salesPDF.pdf','SalesPDF.pdf')];  //= :pdfName ];
            if(!attList.isEmpty()){
                delete attList;
            }
            if(selectedPDF == 'Normal'){
                blob attachmentPdf = null;
                Pagereference pdfcont1  = new PageReference('/apex/QuotePDF_US?quoteid='+quoteID+'&type='+pdfType+'&salorg='+salesOrgID+'&pdftype=Normal&toc='+selectedTOC);
                pdfcont1.setRedirect(false);
             //   attachmentPdf = pdfcont1.getContent(); 
                
                Attachment attach = new Attachment();
                Blob body;
                if(!test.isRunningTest()){
                    attachmentPdf = pdfcont1.getContent(); 
                    body = attachmentPdf;  //.getContent();
                   
                }else{
                    body=blob.valueOf('TestString');
                }
                attach.Body = body;
                attach.Name = pdfName;
                attach.IsPrivate = false;
                attach.ParentId = quoteID; 
                attach.Description = 'Quote PDF';   
                insert attach;
                
                renderButtons = true;
                
            }
            else if(selectedPDF  == 'Extended'){
                
                blob attachmentPdf = null;
                Pagereference pdfcont1  = new PageReference('/apex/QuotePDF_US?quoteid='+quoteID+'&type='+pdfType+'&salorg='+salesOrgID+'&pdftype=Extended&toc='+selectedTOC);
                pdfcont1.setRedirect(false);
             //   attachmentPdf = pdfcont1.getContent(); 
                
                Attachment attach = new Attachment();
                Blob body;
                if(!test.isRunningTest()){
                    attachmentPdf = pdfcont1.getContent(); 
                    body = attachmentPdf;  //.getContent();
                   
                }else{
                    body=blob.valueOf('TestString');
                }
                attach.Body = body;
                attach.Name = pdfName;
                attach.IsPrivate = false;
                attach.ParentId = quoteID; 
                attach.Description = 'Quote PDF';   
                insert attach;
                
                renderButtons = true;
                
            }
        }
    
    }
    
    public void previewQuote(){
    
    }
        
    //Fill 'TO' email address separated by comma contactName 
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
                string conDetail = w.conObj.contactEmail + '[' + w.conObj.contactName +']'; 
                toAddressSet.add(conDetail);
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
    
    public void removeTo(){
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
                string conDetail = w.conObj.contactEmail + '[' + w.conObj.contactName +']'; 
                toAddressSet.remove(conDetail);
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
    
    //Fill 'CC' email address separated by comma
    /*
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
    */
    
    //Fill 'BCC' email address separated by comma
    /*
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
    */
    
    //Email UK PDF to salesrep and contact person
    public PageReference sendMailUK(){ 
    
        blob AttachmentPdf = null;
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        list<Messaging.EmailFileAttachment> attachList = new List<Messaging.EmailFileAttachment>(); 

        system.debug('-----------toAddress------'+toAddress);
        list<string> toAddresses = new list<string>();
        toAddresses = toAddress.split(';');
        toAddresses = trimAddress(toAddresses);
        //toAddresses.add('agoyal@teksystems.com');
        system.debug('-----------toAddresses------'+toAddresses);
        for(String s : toAddresses ){
            if(!checkEmailAddress(s)){
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Invalid email '+ s + ' Make sure each email ID is separated by semicolon(;) ');
                ApexPages.addMessage(msg);
                brochureChecked = false;
                unitChecked = false;
                shafChecked = false;
                hireGuide = false;
                newAccForm = false;
                isMailSentUK = false; 
                Accomodation_Brochure_UK=false;
                STORAGE_UK=false;
                Welfare_Unit_Product_Card_A4=false;
                Storage_Container_Product_Card_A4_pdf=false;
                Accommodation_Product_Card_A4=false;
                Anti_Vandal_Toilet_Units_Product_Card_A4_pdf=false;
                return null;
            }
        }
        mail.setToAddresses(toAddresses);
        /* list<string> ccEmail = new list<string>();
        if(accOwnerOfQQId != null && accOwnerOfQQId != ''){
                User accOwnerOfQQRecord = FullQuoteDAO.getUserDetails(accOwnerOfQQId);
                system.debug('------------accOwnerOfQQRecord.EMail-----------'+accOwnerOfQQRecord.EMail);
                if(accOwnerOfQQRecord.EMail != null && accOwnerOfQQRecord.Email != ''){
                    //ccEmail.add(accOwnerOfQQRecord.EMail);
                    ccEmail.add('agoyal@teksystems.com');
                }
            }
        mail.setCcAddresses(ccEmail);
        */
        
        if(toAddresses.size() < 1)
        {
            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'No contact/Sales Rep email found to send the email');
            ApexPages.addMessage(msg);
            return null;
        }
        mail.setToAddresses(toAddresses);
                        
        //attachments
        
        List<Attachment> attachmentlist = new List<Attachment>();
        if(quoteID != null && quoteID != ''){
            attachmentlist = [Select a.ParentId ,a.Name ,a.Body From Attachment a where parentid = :quoteID];  
        }                 
                
        if(!attachmentlist.isEmpty()){ 
            for(Attachment  aa : attachmentlist){
                Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment(); 
                efa.setFileName(aa.Name); 
                efa.setBody(aa.Body); 
                attachList.add(efa);
            }
        }
        
        Pagereference pdfcont  = new PageReference('/apex/QuotePDF_UK?id='+quoteID+'&salorg='+salesOrgID);
        pdfcont.setRedirect(false);
        if(!test.isRunningTest()){
            AttachmentPdf = pdfcont.getContent();
        }
        else 
            AttachmentPdf = blob.valueOf('TestString');
        Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
        attach.setContentType('application/pdf');
        attach.setFileName('Quotation.pdf');   
        attach.setInline(false);
        
        if(AttachmentPdf != null){
            attach.Body = AttachmentPdf;
        }
        attachList.add(attach);
        
        List<String> setDocumentNames = new List<String>();
        
        //Uncomment below code once product types are configured in custom setting
        /*for(String s: prods){
            if(unitChecked)
                setDocumentNames.add(mapProdTypetoUnitInfo.get(s));
                
            if(brochureChecked)
                setDocumentNames.add(mapProdTypetoBrochure.get(s));
            
            if(shafChecked)
                setDocumentNames.add(mapProdTypetoSHAF.get(s));
            
            setDocumentNames.add(mapProdTypetoWaiver.get(s));
            setDocumentNames.add(mapProdTypetoApplication.get(s)); 
                              
         //   setDocumentNames.add(ProdTypeDocMapping__c.getInstance(s).Damage_Waiver_DocName__c);
         //   setDocumentNames.add(ProdTypeDocMapping__c.getInstance(s).Account_Application_DocName__c);
        } //////put here
       */ 
        //documents to be sent as part of the email
        
        //setDocumentNames.add('Damage_Waiver_DocName_c');
        //setDocumentNames.add('Account_Application_DocName_c');
        
        if(brochureChecked)
            setDocumentNames.add('Accommodation_UK');
        if(unitChecked){
            setDocumentNames.add('Accomodation_Brochure_UK');
            setDocumentNames.add('STORAGE_UK');
        }    
        if(shafChecked)
            setDocumentNames.add('SHAF_UK');
        if(hireGuide)
            setDocumentNames.add('Hire_Guidelines');
        if(newAccForm)
            setDocumentNames.add('Account_Application_Form');
        setDocumentNames.add('T_Cs');            
        
        List<Document> listDocumnets = [SELECT Id, name, DeveloperName, ContentType, Type, Body, Description FROM Document where DeveloperName in :setDocumentNames];
           
        for(Document doc : listDocumnets){
        
            Messaging.EmailFileAttachment att = new Messaging.EmailFileAttachment();
            att.setContentType(doc.contentType);
            att.setFileName(doc.name+'.'+doc.type);
            att.setInline(false);
            att.Body = doc.Body;
            attachList.add(att);
        }
                
        mail.setUseSignature(false);
        mail.setSenderDisplayName('Mobile Mini UK LTD.');
        mail.setReplyTo(salesRepMail);
        //generateEmailBody();
        //mail.setplainTextBody(mailBody);
        mail.setSubject(subject);
        //mailBody = 'test email....please ignore!!';
        mailBody = ukMailBody + ukMailFooter; //ukMailHeader +
        if(mailBody != null && mailBody != ''){
            mailBody = mailBody.replace('\n','<br/>');
        }
        mail.setHtmlBody(mailBody); 
       //EmailTemplate emailTemplateForCustomer = [SELECT Id, Name, DeveloperName, FolderId FROM EmailTemplate where DeveloperName = 'ConvertToOrderUKCustomerConfirmation'];
       // mail.setTemplateId(emailTemplateForCustomer.Id);
        //String sub = 'Your Mobile Mini Order Confirmation : Quote# ' +qqData.name;
        //mail.setTargetObjectId(contactRecordId); 
        mail.setFileAttachments(attachList);
        
        List<Messaging.SendEmailResult> emailResults = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        system.debug('----------emailResults-------'+emailResults);
        if (!emailResults.get(0).isSuccess()) {
            //System.StatusCode statusCode = emailResults.get(0).getErrors()[0].getStatusCode();
            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.ERROR, emailResults.get(0).getErrors()[0].getMessage());
            ApexPages.addMessage(msg);
        }else{
            //if(oppRecordId != null && oppRecordId != ''){
                //Pagereference oppPage  = new PageReference('/'+oppRecordId);
                //return oppPage;
                isMailSentUK = true;
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.CONFIRM, 'Mail has been sent successfully!');
                ApexPages.addMessage(msg);
           /* }
            else{
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.CONFIRM, 'No Opportunity found for this quote. Mail has been sent successfully!');
                ApexPages.addMessage(msg);
                brochureChecked = false;
                unitChecked = false;
                shafChecked = false;
                hireGuide = false;
                newAccForm = false;
                isMailSentUK = true;
            } */
        } 
        return null;
    }
    
    public void resetMailUK(){
        brochureChecked = false;
        unitChecked = false;
        shafChecked = false;
        hireGuide = false;
        newAccForm = false;
        isMailSentUK = false; 
        Accomodation_Brochure_UK=false;
        STORAGE_UK=false;
        Welfare_Unit_Product_Card_A4=false;
        Storage_Container_Product_Card_A4_pdf=false;
        Accommodation_Product_Card_A4=false;
        Anti_Vandal_Toilet_Units_Product_Card_A4_pdf=false;
        ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.info, 'Mail already sent...You are attempting to resend the mail!');
        ApexPages.addMessage(msg);
           
    }
    
    public void toggleDocs(){
       // if(!brochureChecked)    {
            Accomodation_Brochure_UK=false;
            STORAGE_UK=false;
      //  }
    }
    
    public void toggleUnitDocs(){
      //  if(!unitChecked ){
            Welfare_Unit_Product_Card_A4=false;
            Storage_Container_Product_Card_A4_pdf=false;
            Accommodation_Product_Card_A4=false;
            Anti_Vandal_Toilet_Units_Product_Card_A4_pdf=false;
      //  }
    }
    
    public void resetMail(){
      //  toAddress = '';
      //  ccAddress = '';
      //  bccAddress = '';
      //  subject = '';
     //   mailBody = ''; 
     //   subject1 = '';
     //   mailBody1 = '';
        isMailSent = false; 
        //lstEmailTemplate = new list<EmailTemplate>();
    //    isThereATemplate = false;
    //    selectedFolder = '';
        ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.info, 'Mail already sent...You are attempting to resend the mail!');
        ApexPages.addMessage(msg);
           
    }
    //Email US PDF
    public PageReference sendMail(){
    
      if(toAddress != null && toAddress != ''){
        if(mailBody != null && mailBody != ''){      
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
            /* 
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
            } */
            //If mail needs to be sent to record owner
           /* system.debug('------------accOwnerOfQQId-----------'+accOwnerOfQQId);
            if(accOwnerOfQQId != null && accOwnerOfQQId != ''){
                User accOwnerOfQQRecord = FullQuoteDAO.getUserDetails(accOwnerOfQQId);
                system.debug('------------accOwnerOfQQRecord.EMail-----------'+accOwnerOfQQRecord.EMail);
                if(accOwnerOfQQRecord.EMail != null && accOwnerOfQQRecord.Email != ''){
                    ccEmail.add(accOwnerOfQQRecord.EMail);
                }
            }  */
            ccEmail.add(loginUserRec.Email);
            system.debug('------------ccEmail-----------'+ccEmail);
            mail.setCcAddresses(ccEmail);
            /*
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
            */
            if(!test.isRunningTest()){
                if(quoteID != null && quoteID != ''){
                    if( (!isUK) && (pdfType == 'sales' || pdfType == 'rental' )){                    
                 /*       Pagereference pdfcont  = new PageReference('/apex/QuotePDF_US?quoteid='+quoteID+'&type='+pdfType+'&salorg='+salesOrgID);
                        pdfcont.setRedirect(false);
                        AttachmentPdf = pdfcont.getContent();
                        
                        Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
                            attach.setContentType('application/pdf');
                            if(pdfType == 'rental'){
                                attach.setFileName('RentalQuotePreview.pdf');   
                            }else{
                                attach.setFileName('SalesQuotePreview.pdf');
                            } 
                            attach.setInline(false);
                            if(AttachmentPdf != null){
                                attach.Body = AttachmentPdf;
                            }
                            attachList.add(attach); */
                    }
                        
                }else{
                  
                } 
            }
                
                
            
            List<Document> docuemnt;
              docuemnt = new List<Document>();
              Quote_Header__c qqDataobj = new Quote_Header__c();
        if(quoteID != null && quoteID != ''){
                qqDataobj = [Select m.Account__c, m.Opportunity__c, m.Id From Quote_Header__c m where Id = :quoteID];          
        }              

        //    prodctname = qqDataobj.Product__c;
                         
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
        if(quoteID != null && quoteID != ''){
          attachmentlist = [Select a.ParentId ,a.Name ,a.Body From Attachment a where parentid = :quoteID];  
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
                //mail.setplainTextBody(mailBody);
                mail.setUseSignature(false);
                mail.setSubject(subject);
                String emailBody = mailBody + '\n' + usMailFooter1 + usMailFooter2;
                if(emailBody != null && emailBody != ''){
                    emailBody = emailBody.replace('\n','<br/>');
                }
                mail.setHtmlBody(emailBody);  
             //   selectedEmailTemplateId = System.currentPageReference().getParameters().get('hiddenSelectedEmailTemplate');
             //   mail.setTemplateId(selectedEmailTemplateId);
              //  mail.setTargetObjectId(contactRecordId);
        
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
                    isMailSent =true;
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
                //delete attachmentlist;
                
            } 
            if(!isUK){
             //   toAddress = '';
            }
           // ccAddress = '';
           // bccAddress = '';
           // subject = '';
           // mailBody = '';
           // subject1 = '';
           // mailBody1 = '';
          //  isThereATemplate = false;
          //  selectedFolder = '';
            return null;
        }else{
            //subject1 = '';
            //mailBody1 = '';
            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Please select an email Template!');
            ApexPages.addMessage(msg);
            return null;
        }
      } //end of if blank to address
      
      else{
          ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Please select To Address!');
          ApexPages.addMessage(msg);
          return null;    
      }
    }
    
    public PageReference cancelMailUK(){
        PageReference pr = new PageReference('/'+quoteID);
        pr.setRedirect(true);
        return pr;
    }
    
    public PageReference cancelMail(){
        delete attachmentlist = [Select a.ParentId ,a.Name ,a.Body From Attachment a where parentid = :quoteID];
        PageReference pr = new PageReference('/'+quoteID);
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
        String emailRegex = '^[a-zA-Z0-9._|\\\\%#~`\'=?&/$^*!}{+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,4}$'; // source: http://www.regular-expressions.info/email.html
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
      attachmentList =  [Select a.ParentId ,a.Name From Attachment a where ParentId =:quoteID ];
      //attachIDSet.clear();
      //Attachment att =  [select a.ParentId ,a.Name From Attachment a where parentid =:quoteID and id =:attachedPDFID ];
      //attachmentList.add(att);
    }
    
    public void deleteAttachach(){
        String attachDeleId= Apexpages.currentPage().getParameters().get('attachId');
        List<Attachment> att =  [Select a.ParentId ,a.Name From Attachment a where id = :attachDeleId];
        if(att.size() > 0){
          delete att;  
        }
          attachmentList =  [Select a.ParentId ,a.Name From Attachment a where ParentId = :quoteID];
    }
    /*  
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
    */  
    public void showEmailTemplate(){
        lstEmailTemplate = new list<EmailTemplate>();
        lstEmailTemplate = [Select e.Name, e.Id, e.FolderId From EmailTemplate e where e.FolderId = :selectedFolder and e.TemplateType = 'Text' and e.Name in('Mobile Mini Quote Followup','Order Confirmation to Customer','Thank You','Followup to Quote','Email Quote') order by e.Name];
        system.debug('------------lstEmailTemplate---------------'+lstEmailTemplate);
        if(lstEmailTemplate.size() > 0){
            isThereATemplate = true;
        }else{
            isThereATemplate = false;
        }
    }
      
    public PageReference generateEmailBody(){
        //selectedEmailTemplateId = System.currentPageReference().getParameters().get('hiddenSelectedEmailTemplate');
        if(salesOrgID != '1501')
            selectedEmailTemplateId = [Select Name, Id, FolderId From EmailTemplate where TemplateType = 'Text' and Name in('CPC Quote Template NA') limit 1].ID;
        else
            selectedEmailTemplateId = [Select Name, Id, FolderId From EmailTemplate where TemplateType = 'Text' and Name in('CPC Quote Template WMI') limit 1].ID;
        //if(isUK)
        //{
        //    EmailTemplate emailTemplateForCustomer = [SELECT Id, Name, DeveloperName, FolderId FROM EmailTemplate where DeveloperName = 'ConvertToOrderUKCustomerConfirmation'];
        //    selectedEmailTemplateId = emailTemplateForCustomer.id;
        //}
        //
        system.debug('------------quoteID---------------'+quoteID);
        system.debug('------------oppRecordId---------------'+oppRecordId);
        system.debug('------------accRecordId---------------'+accRecordId);
        system.debug('------------contactRecordId---------------'+contactRecordId);
        if(selectedEmailTemplateId != null && selectedEmailTemplateId != ''){
            generatedMailBody = USEmailTempalteBodyGeneraterUtil.generateEmailBody(quoteID,oppRecordId,accRecordId,contactRecordId,'qq',selectedEmailTemplateId);
            system.debug('------------generatedMailBody---------------'+generatedMailBody);
            mailBody = generatedMailBody;
            List<String> splitedMailBody = generatedMailBody.split('Splithere');
            mailBody = splitedMailBody.get(0);
            usMailFooter1 = splitedMailBody.get(1);
            usMailFooter2 = splitedMailBody.get(2);
            mailBody1 = mailBody; 
            
            // + '\n<img src="https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcR6Qy0S7Z0X3RbRUuOBRHgXMl_EBq3UKo8iUVX_s_rysFaEHA5Jdg" />'; 
            /* EmailTemplate emailTemplateObj = [Select e.TemplateType, e.TemplateStyle, e.Subject, e.Name, e.IsActive, e.Id, e.Folder.Name, e.Folder.Id, e.FolderId, e.DeveloperName, e.Description, e.Body,e.HtmlValue From EmailTemplate e where e.Id = :selectedEmailTemplateId];
            if(emailTemplateObj != null){
                System.debug('emailTemplateObj........'+emailTemplateObj);
                String subjectWithMergeFld = emailTemplateObj.Subject;
                
                if(subjectWithMergeFld != null && subjectWithMergeFld != '' && contactRecordId != null && subjectWithMergeFld.contains('{!Contact.')){
                    subjectWithMergeFld = USEmailTempalteBodyGeneraterUtil.mergeContactFields(subjectWithMergeFld, contactRecordId); // get all Contact Field Merged
                }
                if(subjectWithMergeFld != null && subjectWithMergeFld != '' && accRecordId != null && subjectWithMergeFld.contains('{!Account.')){
                    subjectWithMergeFld = USEmailTempalteBodyGeneraterUtil.mergeAccountFields(subjectWithMergeFld, accRecordId); // get all Account Field Merged
                }
                if(subjectWithMergeFld != null && subjectWithMergeFld != '' && oppRecordId != null && subjectWithMergeFld.contains('{!Opportunity.')){
                    subjectWithMergeFld = USEmailTempalteBodyGeneraterUtil.mergeOpportunityFields(subjectWithMergeFld, oppRecordId); // get all Opportunity Field Merged
                }
                if(subjectWithMergeFld != null && subjectWithMergeFld != '' && quoteID != null && subjectWithMergeFld.contains('{!Quote_Header__c.')){
                    subjectWithMergeFld = USEmailTempalteBodyGeneraterUtil.mergeQQFields(subjectWithMergeFld, quoteID); // get all QQ Field Merged
                }
                if(subjectWithMergeFld != null && subjectWithMergeFld != '' && subjectWithMergeFld.contains('{!User.')){
                    subjectWithMergeFld = USEmailTempalteBodyGeneraterUtil.mergeUserFields(subjectWithMergeFld, UserInfo.getUserId()); // get all User Field Merged
                }
                if(subjectWithMergeFld != null && subjectWithMergeFld != '' && accOwnerOfQQId != null && subjectWithMergeFld.contains('{!Account.Owner')){
                    subjectWithMergeFld = USEmailTempalteBodyGeneraterUtil.mergeAccountOwnerUserFields(subjectWithMergeFld, accOwnerOfQQId); // get all Account Owner Field Merged
                }
                
                subject = subjectWithMergeFld;
                subject1 = subject;
            } */
        }
        else{
            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.ERROR, 'Please select an email Template!');
            ApexPages.addMessage(msg);
            return null;
        } 
        return null;
    }

}