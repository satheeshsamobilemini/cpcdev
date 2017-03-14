public with sharing class LeadDuplicateMetaPhone {
    private final Apexpages.StandardController stdController;
    private string ppcKeywordParam;
    public string saveparameters{get ;set ;}
    public boolean isValidSearch{ get ;set ;}
    
    public string CompanyName { get ;set ;}
    public string FirstName { get ;set ;}
    public string LastName { get ;set ;}
    public string StreetAddress { get ;set ;}
    public string ZipCode { get ;set ;}
    public string PhoneNo { get ;set ;}
    
    public list<Lead> listLead { get; set;}
    public Integer countLead {get;set;}
    public list<Account> listAccount { get; set;}
    public Integer countAccount {get;set;}
    public list<Contact> listContact { get; set;}
    public Integer countContact {get;set;}
    
    public LeadDuplicateMetaPhone(Apexpages.StandardController controller){
        if(!test.isRunningTest()){
            saveparameters = ApexPages.currentPage().getUrl().replace('/apex/LeadDuplicateMetaPhonePage?','');
        }
        isValidSearch = false ;
    }
    
    public pageReference CreateNewLead(){
        string params = '' ;
        if( hasMorethanTwoCharacter( encodeChars(CompanyName)) ){
            params += ('&lea3=' +  encodeChars(CompanyName));
        }
        if( hasMorethanTwoCharacter( FirstName) ){
            params +=('&name_firstlea2=' + encodeChars(FirstName));
        }
        if( hasMorethanTwoCharacter( LastName) ){
            params += ('&name_lastlea2=' + encodeChars(LastName));
        }
        if( hasMorethanTwoCharacter( StreetAddress) ){
            params += ('&lea16street=' + encodeChars(StreetAddress));
        }
        if( hasMorethanTwoCharacter( ZipCode) ){
            params += ('&lea16zip=' + encodeChars(ZipCode));
        }
        if( hasMorethanTwoCharacter( PhoneNo) ){
            params += ('&lea8=' +  encodeChars(PhoneNo));
        }
        
        ppcKeywordParam = getppcKeywordParam();
        if(ppcKeywordParam != null && ppcKeywordParam.length() > 0){
            params += ('&'+ppcKeywordParam);
        }
        return new PageReference('/00Q/e?nooverride=1'+ params+'&FwdURL='+EncodingUtil.urlEncode(saveparameters,'UTF-8') ) ;
    }
    
    public pageReference Cancel(){
      return new PageReference('/00Q/o') ;
    }
    
    public void DuplicateLeadSearch(){
        if(CompanyName == '' || CompanyName == null){
            system.debug('-----------iF-----1------');
            if((FirstName == '' || FirstName == null )&& (LastName == '' || LastName == null)){
                system.debug('-----------iF---1.1---------');
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Company Name is Required. Else provide First Name and Last Name.'));
            }
            if((FirstName != '' && FirstName != null) && (LastName == '' || LastName == null)){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'First Name and Last Name is Required!'));
            }
            if((FirstName == '' || FirstName == null) && (LastName != '' && LastName != null)){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'First Name and Last Name is Required!'));
            }
            if(PhoneNo == '' || PhoneNo == null){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Phone Number is Required!'));
            }
        }
        if(PhoneNo == '' || PhoneNo == null){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Phone Number is Required!'));
        }else{
            system.debug('-----------else-----------');
            String ActualPhone = '';
            String LeadQuertStr = 'Select l.Id, l.Title, l.Street, l.Status, l.Servicing_Branch_Id__c, l.Phone, l.Owner.Name, l.OwnerId, l.Name, l.Email, l.Company, l.Branch__c from Lead l ';
            String whereCondition = ' Where ( ';
            Metaphone mp = new Metaphone();
            if(CompanyName != null && CompanyName != ''){
                system.debug('-----------mp.getMetaphone(CompanyName)-------------------'+mp.getMetaphone(CompanyName));
                if(whereCondition == ' Where ( '){
                    whereCondition += ' Company_Metaphone_Key__c like \''+mp.getMetaphone(CompanyName)+'%\'';   
                }
                else{
                    whereCondition += ' or Company_Metaphone_Key__c like \''+mp.getMetaphone(CompanyName)+'%\'';    
                }           
            }
            
            if(FirstName != null && FirstName != '' && LastName != null && LastName != ''){
                if(whereCondition == ' Where ( '){
                    whereCondition += ' ( First_Name_Meta_Phone_Key__c like \''+mp.getMetaphone(FirstName)+'%\'';
                    whereCondition += ' and Last_Name_Metaphone_Key__c like \''+mp.getMetaphone(LastName)+'%\' )';
                }else{
                    whereCondition += ' or ( First_Name_Meta_Phone_Key__c like \''+mp.getMetaphone(FirstName)+'%\'';
                    whereCondition += ' and Last_Name_Metaphone_Key__c like \''+mp.getMetaphone(LastName)+'%\' )';
                }
            }else if(FirstName != null && FirstName != ''){
                if(whereCondition == ' Where ( '){
                    whereCondition += ' First_Name_Meta_Phone_Key__c like \''+mp.getMetaphone(FirstName)+'%\''; 
                }
                else{
                    whereCondition += ' or First_Name_Meta_Phone_Key__c like \''+mp.getMetaphone(FirstName)+'%\'';  
                }           
            }else if(LastName != null && LastName != ''){
                if(whereCondition == ' Where ( '){
                    whereCondition += ' Last_Name_Metaphone_Key__c like \''+mp.getMetaphone(LastName)+'%\'';    
                }
                else{
                    whereCondition += ' or Last_Name_Metaphone_Key__c like \''+mp.getMetaphone(LastName)+'%\''; 
                }           
            }
            
            if(StreetAddress != null && StreetAddress != ''){
                if(whereCondition == ' Where ( '){
                    whereCondition += ' Street_Address_Metaphone_Key__c like \''+mp.getMetaphone(StreetAddress)+'%\' )';    
                }
                else{
                    whereCondition += ' or Street_Address_Metaphone_Key__c like \''+mp.getMetaphone(StreetAddress)+'%\' )'; 
                }           
            }else{
                if(whereCondition == ' Where ( '){
                    whereCondition = ' Where '; 
                }else{
                    whereCondition += ' ) ';
                }
            }
            if(ZipCode != null && ZipCode != ''){
                if(whereCondition == ' Where '){
                    whereCondition += ' PostalCode = \''+ZipCode+'\'';
                }
                else{
                    whereCondition += ' and PostalCode = \''+ZipCode+'\'';
                }           
            }
            if(PhoneNo != null && PhoneNo != ''){
                ActualPhone = PhoneNo;
                PhoneNo = PhoneNo.replace('(', '');
                PhoneNo = PhoneNo.replace(')', '');
                PhoneNo = PhoneNo.replace('-', '');
                PhoneNo = PhoneNo.replace(',', '');
                PhoneNo = PhoneNo.replace('.', '');
                PhoneNo = PhoneNo.replace(' ', '');
                if(whereCondition == ' Where '){
                    whereCondition += ' Phone_With_Out_Special_Character__c = \''+PhoneNo+'\'';
                }
                else{
                    whereCondition += ' and Phone_With_Out_Special_Character__c = \''+PhoneNo+'\'';
                }           
            }
            system.debug('-------------whereCondition---------------'+whereCondition);
            if(whereCondition != ' where '){
                LeadQuertStr += whereCondition;
                system.debug('-------------LeadQuertStr---------------'+LeadQuertStr);
                listLead = database.query(LeadQuertStr);        
            }else{
                listLead = new list<Lead>();
            }
            countLead = listLead.size();
            
            //-------------------------------------for account--------------------------------------------------------------
            String AccountQuertStr = 'Select a.Id, a.Servicing_Branch_Id__pc, a.Servicing_Branch_Id__c, a.Result_Id__c, a.Phone, a.Owner.Name, a.OwnerId, a.LastName, a.IsPersonAccount, a.FirstName,a.Name, a.Branch__c, a.BillingStreet, a.BillingState, a.BillingPostalCode, a.BillingCity From Account a ';
            String whereConditionForAccount = ' Where ( ';
            if(CompanyName != null && CompanyName != ''){
                system.debug('-----------mp.getMetaphone(CompanyName)-------------------'+mp.getMetaphone(CompanyName));
                if(whereConditionForAccount == ' Where ( '){
                    whereConditionForAccount += ' Company_Metaphone_Key__c like \''+mp.getMetaphone(CompanyName)+'%\''; 
                }
                else{
                    whereConditionForAccount += ' or Company_Metaphone_Key__c like \''+mp.getMetaphone(CompanyName)+'%\'';  
                }           
            }
            
            if(FirstName != null && FirstName != '' && LastName != null && LastName != ''){
                if(whereConditionForAccount == ' Where ( '){
                    whereConditionForAccount += ' ( First_Name_Meta_Phone_Key__c like \''+mp.getMetaphone(FirstName)+'%\'';
                    whereConditionForAccount += ' and Last_Name_Metaphone_Key__c like \''+mp.getMetaphone(LastName)+'%\' )';
                }else{
                    whereConditionForAccount += ' or ( First_Name_Meta_Phone_Key__c like \''+mp.getMetaphone(FirstName)+'%\'';
                    whereConditionForAccount += ' and Last_Name_Metaphone_Key__c like \''+mp.getMetaphone(LastName)+'%\' )';
                }
            }else if(FirstName != null && FirstName != ''){
                if(whereConditionForAccount == ' Where ( '){
                    whereConditionForAccount += ' First_Name_Meta_Phone_Key__c like \''+mp.getMetaphone(FirstName)+'%\'';   
                }
                else{
                    whereConditionForAccount += ' or First_Name_Meta_Phone_Key__c like \''+mp.getMetaphone(FirstName)+'%\'';    
                }           
            }else if(LastName != null && LastName != ''){
                if(whereConditionForAccount == ' Where ( '){
                    whereConditionForAccount += ' Last_Name_Metaphone_Key__c like \''+mp.getMetaphone(LastName)+'%\'';  
                }
                else{
                    whereConditionForAccount += ' or Last_Name_Metaphone_Key__c like \''+mp.getMetaphone(LastName)+'%\'';   
                }           
            }
            
            if(StreetAddress != null && StreetAddress != ''){
                if(whereConditionForAccount == ' Where ( '){
                    whereConditionForAccount += ' Street_Address_Metaphone_Key__c like \''+mp.getMetaphone(StreetAddress)+'%\' )';  
                }
                else{
                    whereConditionForAccount += ' or Street_Address_Metaphone_Key__c like \''+mp.getMetaphone(StreetAddress)+'%\' )';   
                }           
            }else{
                if(whereConditionForAccount == ' Where ( '){
                    whereConditionForAccount = ' Where ';   
                }else{
                    whereConditionForAccount += ' ) ';
                }
            }
            if(ZipCode != null && ZipCode != ''){
                if(whereConditionForAccount == ' Where '){
                    whereConditionForAccount += ' BillingPostalCode = \''+ZipCode+'\'';
                }
                else{
                    whereConditionForAccount += ' and BillingPostalCode = \''+ZipCode+'\'';
                }           
            }
            if(PhoneNo != null && PhoneNo != ''){
                if(whereConditionForAccount == ' Where '){
                    whereConditionForAccount += ' Phone_With_Out_Special_Character__c = \''+PhoneNo+'\'';
                }
                else{
                    whereConditionForAccount += ' and Phone_With_Out_Special_Character__c = \''+PhoneNo+'\'';
                }           
            }
            
            system.debug('-------------whereConditionForAccount---------------'+whereConditionForAccount);
            if(whereConditionForAccount != ' where '){
                AccountQuertStr += whereConditionForAccount;
                system.debug('-------------AccountQuertStr---------------'+AccountQuertStr);
                listAccount = database.query(AccountQuertStr);      
            }else{
                listAccount = new list<Account>();
            }
            countAccount = listAccount.size();
            
            //-------------------------------------for Contact--------------------------------------------------------------
            String ContactQuertStr = 'Select c.Id, c.Servicing_Branch_Id__c, c.Phone, c.Owner.Name, c.OwnerId, c.Name, c.MailingStreet, c.MailingPostalCode, c.LastName, c.FirstName, c.Email, c.Branch__c, c.Account.Name, c.AccountId From Contact c ';
            String whereConditionForContact = ' Where ( ';
            if(CompanyName != null && CompanyName != ''){
                system.debug('-----------mp.getMetaphone(CompanyName)-------------------'+mp.getMetaphone(CompanyName));
                if(whereConditionForContact == ' Where ( '){
                    whereConditionForContact += ' Company_Metaphone_Key__c like \''+mp.getMetaphone(CompanyName)+'%\''; 
                }
                else{
                    whereConditionForContact += ' or Company_Metaphone_Key__c like \''+mp.getMetaphone(CompanyName)+'%\'';  
                }           
            }
            
            if(FirstName != null && FirstName != '' && LastName != null && LastName != ''){
                if(whereConditionForContact == ' Where ( '){
                    whereConditionForContact += ' ( First_Name_Meta_Phone_Key__c like \''+mp.getMetaphone(FirstName)+'%\'';
                    whereConditionForContact += ' and Last_Name_Metaphone_Key__c like \''+mp.getMetaphone(LastName)+'%\' )';
                }else{
                    whereConditionForContact += ' or ( First_Name_Meta_Phone_Key__c like \''+mp.getMetaphone(FirstName)+'%\'';
                    whereConditionForContact += ' and Last_Name_Metaphone_Key__c like \''+mp.getMetaphone(LastName)+'%\' )';
                }
            }else if(FirstName != null && FirstName != ''){
                if(whereConditionForContact == ' Where ( '){
                    whereConditionForContact += ' First_Name_Meta_Phone_Key__c like \''+mp.getMetaphone(FirstName)+'%\'';   
                }
                else{
                    whereConditionForContact += ' or First_Name_Meta_Phone_Key__c like \''+mp.getMetaphone(FirstName)+'%\'';    
                }           
            }else if(LastName != null && LastName != ''){
                if(whereConditionForContact == ' Where ( '){
                    whereConditionForContact += ' Last_Name_Metaphone_Key__c like \''+mp.getMetaphone(LastName)+'%\'';  
                }
                else{
                    whereConditionForContact += ' or Last_Name_Metaphone_Key__c like \''+mp.getMetaphone(LastName)+'%\'';   
                }           
            }
            
            if(StreetAddress != null && StreetAddress != ''){
                if(whereConditionForContact == ' Where ( '){
                    whereConditionForContact += ' Street_Address_Metaphone_Key__c like \''+mp.getMetaphone(StreetAddress)+'%\' )';  
                }
                else{
                    whereConditionForContact += ' or Street_Address_Metaphone_Key__c like \''+mp.getMetaphone(StreetAddress)+'%\' )';   
                }           
            }else{
                if(whereConditionForContact == ' Where ( '){
                    whereConditionForContact = ' Where ';   
                }else{
                    whereConditionForContact += ' ) ';
                }
            }
            if(ZipCode != null && ZipCode != ''){
                if(whereConditionForContact == ' Where '){
                    whereConditionForContact += ' MailingPostalCode = \''+ZipCode+'\'';
                }
                else{
                    whereConditionForContact += ' and MailingPostalCode = \''+ZipCode+'\'';
                }           
            }
            if(PhoneNo != null && PhoneNo != ''){
                if(whereConditionForContact == ' Where '){
                    whereConditionForContact += ' Phone_With_Out_Special_Character__c = \''+PhoneNo+'\'';
                }
                else{
                    whereConditionForContact += ' and Phone_With_Out_Special_Character__c = \''+PhoneNo+'\'';
                }           
            }
            system.debug('-------------whereConditionForContact---------------'+whereConditionForContact);
            if(whereConditionForContact != ' where '){
                ContactQuertStr += whereConditionForContact;
                system.debug('-------------ContactQuertStr---------------'+ContactQuertStr);
                listContact = database.query(ContactQuertStr);      
            }else{
                listContact = new list<Contact>();
            }
            countContact = listContact.size();
            isValidSearch = true ;
            PhoneNo = ActualPhone;
        }
    }
    
    
    public boolean hasMorethanTwoCharacter( string fieldValue ){
       if (  fieldValue.Length() < 2    )
          return false ;
       else 
          return true ;
    }
    
    public String encodeChars(String param){
    
        param = param.replaceAll('&', '%26');
        //param = param.replaceAll('+', '%2B');
        param = param.replaceAll('#', '%23');
        param = param.replaceAll(',', '%2C');
        //param = param.replaceAll('$', '%24');
        param = param.replaceAll(':', '%3A');
        param = param.replaceAll(';', '%3B');
        param = param.replaceAll('=', '%3D');
        //param = param.replaceAll('?', '%3F');
        param = param.replaceAll('@', '%40');
        param = param.replaceAll('<', '%3C');
        param = param.replaceAll('>', '%3E');
        //param = param.replaceAll('%', '%25');
        param = param.replaceAll(' ', '%20');
        
        return param;
    
    }
    
    public String getppcKeywordParam(){
        String ppcParam = '';
        if(saveparameters.length() > 0 && saveparameters.contains('00N800000042rYJ')){
            String[] splitSaveParams = saveparameters.split('&');
            if(splitSaveParams.size() > 1){
                for(String param : splitSaveParams){
                    if(param.startsWith('00N800000042rYJ')){
                        ppcParam = param;
                        saveparameters = saveparameters.replace(param,'');
                        break;
                    }
                }
            }else if(splitSaveParams.size() == 1){
                ppcParam = splitSaveParams[0];
                saveparameters = saveparameters.replace(ppcParam,'');
            }
        } 
        return ppcParam;
    }
    
    static testMethod void LeadDuplicateMetaPhoneTestMethods() {
        Manage_Triggers__c manageTrigCustomSetting = new Manage_Triggers__c();
        manageTrigCustomSetting.Name = 'SendDeadLeadTo360IntegrationService';
        manageTrigCustomSetting.Active__c = true;
        //insert manageTrigCustomSetting;
        
        Lead ldObj1 = new Lead();
        ldObj1.FirstName = 'testFn';
        ldObj1.LastName = 'testLn';
        ldObj1.Company = 'testCompany';
        ldObj1.Phone = '9741857587';
        ldObj1.Status = 'Open';
        ldObj1.Rating = 'Hot (Probably Order)';
        ldObj1.RecordTypeId = '012800000007Ium';
        ldObj1.Decision_Maker__c = 'No';
        ldObj1.Primary_Contact_Method__c = 'Phone';
        ldObj1.LeadSource = 'ABI';
        ldObj1.Industry ='8-Mining';
        insert ldObj1;
        
        Lead ldObj2 = new Lead();
        ldObj2.FirstName = 'testFn1';
        ldObj2.LastName = 'testLn';
        ldObj2.Company = 'testCompany';
        ldObj2.Phone = '9741857587';
        ldObj2.Status = 'Open';
        ldObj2.Rating = 'Hot (Probably Order)';
        ldObj2.RecordTypeId = '012800000007Ium';
        ldObj2.Decision_Maker__c = 'No';
        ldObj2.Primary_Contact_Method__c = 'Phone';
        ldObj2.LeadSource = 'ABI';
        ldObj2.Industry ='8-Mining';
        insert ldObj2;
        
        Account acc = new Account();
        acc.Name = 'Test account';
        //acc.CurrencyIsoCode = 'USD - U.S. Dollar';
        acc.Type = 'Other';
        insert acc;
        
        Contact con = new Contact();
        con.FirstName = 'testFn';
        con.LastName = 'testLn';
        con.AccountId = acc.Id;
        con.Decision_Maker__c = 'Yes';
        insert con;
        
        //test.setCurrentPage('/apex/LeadDuplicateMetaPhonePage?');
        ApexPages.StandardController QController = new ApexPages.StandardController(ldObj2);
        LeadDuplicateMetaPhone LeadDup = new LeadDuplicateMetaPhone(QController);
        LeadDup.FirstName = 'tes';
        LeadDup.LastName = 'te';
        LeadDup.CompanyName = 'te';
        LeadDup.StreetAddress = 'btm';
        LeadDup.ZipCode = '23432';
        LeadDup.PhoneNo = '343124';
        LeadDup.saveparameters = '00N800000042rYJ&asdasda&sdgsgs';
        LeadDup.DuplicateLeadSearch();
        LeadDup.CreateNewLead();
        LeadDup.Cancel();
        LeadDup.hasMorethanTwoCharacter('sdf');
        LeadDup.getppcKeywordParam();
        LeadDup.saveparameters = '00N800000042rYJ';
        LeadDup.getppcKeywordParam();
        
        LeadDup.FirstName = '';
        LeadDup.LastName = 'te';
        LeadDup.DuplicateLeadSearch();
        LeadDup.FirstName = '';
        LeadDup.LastName = '';
        LeadDup.CompanyName = 'te';
        LeadDup.DuplicateLeadSearch();
        LeadDup.FirstName = '';
        LeadDup.LastName = '';
        LeadDup.CompanyName = '';
        LeadDup.StreetAddress = 'btm';
        LeadDup.DuplicateLeadSearch();
        LeadDup.FirstName = '';
        LeadDup.LastName = '';
        LeadDup.CompanyName = '';
        LeadDup.StreetAddress = '';
        LeadDup.ZipCode = '23432';
        LeadDup.DuplicateLeadSearch();
        LeadDup.FirstName = '';
        LeadDup.LastName = '';
        LeadDup.CompanyName = '';
        LeadDup.StreetAddress = '';
        LeadDup.ZipCode = '';
        LeadDup.PhoneNo = '343124';
        LeadDup.DuplicateLeadSearch();
        
    }
    
}