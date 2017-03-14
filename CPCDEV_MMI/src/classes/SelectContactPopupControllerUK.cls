/**
 * (c) 2015 TEKsystems Global Services
 *
 * Name           : SelectContactPopupControllerUK
 * Created Date   : 20 March 2015
 * Created By     : Sreenivas M (TEKSystems)
 * Purpose        : Controller class used by 'SelectConatctPopup' VF page.
 * Last Updated By: Ankur Goyal (TEKSystems)
 * Last Updated Date: 19-Jan-2016
 **/
public with sharing class SelectContactPopupControllerUK {

    public String contactId { get; set; }
    public String oppId{get;set;}
    public String url {get;set;}
    public list<Contact> lstContact {get;set;}
    public Boolean IsContactPresent {get;set;}
    public String accId {get;set;}
    public String conFn {get;set;}
    public String conLn {get;set;}
    public String conPh {get;set;}
    public String conMob {get;set;}
    public String conEmail {get;set;}
    public String conFax{get;set;}
    public String selectedConId {get;set;}
    public Boolean isPrsnAcc {get;set;}
    public Boolean isFromNewContact {get;set;}
    public Boolean isFromAccount{get;set;}
    public Boolean isFromAccountDashboard{get; set;}
    public list<User> lstReps{get;set;}
    public Boolean renderRep{get;set;}
    public String titleString{get;set;}
    public String salesOrgID{get;set;}
    public Account acc1{get;set;}
    public Boolean oppCreated{get;set;}
    public String cpqURL{get;set;}
    public String portalURL{get;set;}
    public Boolean isFromJobProfile{get;set;}
    public string jobProfileID;
    public string jobProfileName;
    public string contractorRole;
    public Job_Profile__c jobProfileRec{get;set;}
    public user currentUser{get;set;}
    public List<SelectOption> contactRolesList{get;set;}
    public string conRole{get;set;}
    
    public string contractID{get;set;}
    public string quoteID{get;set;}
    public string cloneContract{get;set;}
    public string cloneQuote{get;set;}
    public boolean isExternalClone{get;set;}
    
    public SelectContactPopupControllerUK() {
        titleString = 'Please create or select a Contact';
        lstReps = new list < User > ();
        set<id> userOrGroupIdset  = new set<id>();
        set<id> relatedIdset = new set<id>();
        isFromAccountDashboard = false;
                
        //Fetch cpq and portal url from custom setting for current logged in environment        
        cpqURL = '';
        portalURL = '';
        String curHost = System.URL.getSalesforceBaseUrl().getHost();
        for(CPQActiveURL__c cu: CPQActiveURL__c.getAll().values()){
            if(curHost.containsignorecase(cu.Environment__c)){
                cpqURL = cu.CPQ_URL__c;
                portalURL = cu.Portal_URL__c;
            }
        }
        for(GroupMember eachGroupMember :  [SELECT UserOrGroupId FROM GroupMember where GroupId =: [SELECT Id FROM Group where DeveloperName = 'Profile_and_Roles_List_UK'][0].id]) 
            userOrGroupIdset.add(eachGroupMember.UserOrGroupId);
        for(Group eachGroup : [SELECT RelatedId FROM Group where Id IN: userOrGroupIdset])
            relatedIdset.add(eachGroup.RelatedId);
        for(User eachUser : [SELECT Id, Name, Sales_Rep_Id__c,Sales_Org__c, Phone FROM User where UserRoleId IN: relatedIdset and isactive = true ORDER BY Name]){
            if(!String.isBlank(eachUser.Sales_Rep_Id__c)){
                if(Pattern.matches('^[0-9]*$',eachUser.Sales_Rep_Id__c))
                    lstReps.add(eachUser);
            }
        }
        
        currentUser = [select id,name,ETS_WMI_Branch_ID__c,Branch_Id__c from User where Id = :UserInfo.getUserId()];
        
        cloneContract = 'No';
        cloneQuote = 'No';
        
        selectedConId = System.currentPageReference().getParameters().get('hiddenContact');
        accId = Apexpages.currentPage().getParameters().get('id');
        string fromAccount = Apexpages.currentPage().getParameters().get('FromAccount');
        String salesRepId = Apexpages.currentPage().getParameters().get('repID');
        string fromAccDash = Apexpages.currentPage().getParameters().get('accDashboard');
        string fromJProfile = Apexpages.currentPage().getParameters().get('fromProfile');
        contractorRole=Apexpages.currentPage().getParameters().get('conrole');
        String extClone = ApexPages.currentPage().getParameters().get('externalClone');

        //external clone
        if(extClone != null && extClone != '')
            isExternalClone = Boolean.valueOf(extClone);        
        //contract number to be cloned
        contractID=Apexpages.currentPage().getParameters().get('contractid');
        if(contractID != null && contractID != '')
            cloneContract = 'Yes';
        
        //Quote id to be cloned
        quoteID =Apexpages.currentPage().getParameters().get('quoteid');
        if(quoteID != null && quoteID != '')
            cloneQuote = 'Yes';
        
        if(fromAccDash != null && fromAccDash == 'true'){
            isFromAccountDashboard = true;
        }
        isFromJobProfile = false;
        if(fromJProfile != null && fromJProfile == 'true'){
            isFromJobProfile = true;
            jobProfileID = Apexpages.currentPage().getParameters().get('jobprofileid');
            jobProfileRec = new Job_Profile__c();
            jobProfileRec = [select id,Name,Job_Site_Address__c,Job_Site_City__c,Job_Site_Country__c,Territory__c,Job_Site_County__c,Job_Site_State__c,Job_Site_Zip__c from Job_Profile__c where ID =:jobProfileID ];
            jobProfileName = jobProfileRec.Name;
            //Apexpages.currentPage().getParameters().get('jobprofilename');
        }
        
        oppCreated = false;
        
        if(accId != null && accId != ''){  // TFS 8421..
         acc1 = [select id, Name,Sales_Org__c from Account where Id = : accId];
         salesOrgID = acc1.Sales_Org__c ;
        }
        
        String oppId1 = Apexpages.currentPage().getParameters().get('opportunityid');
        if(oppId1 != null && oppId1 != '' ){
            oppId = oppId1;
        }
        else
            oppId = '';
                       
        if (salesRepId != null && salesRepId != '') {
            renderRep = true;
            titleString = 'Please select a Sales Rep';
        }
        if (fromAccount != null && fromAccount != '') {
            isFromAccount = Boolean.valueOf(fromAccount);
        }
        IsContactPresent = false;
        isPrsnAcc = false;
        isFromNewContact = false;
        if (salesRepId == null || salesRepId == '') {
            lstContact = new list < Contact > ();
            isPrsnAcc = isPersonalAcc(accId);
            if (isPrsnAcc) {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.WARNING, 'You cannot create a contact for Person Account! Please select the contact and click Next button.');
                ApexPages.addMessage(msg);
            }
            getContactRecord();
        }
        
        contactRolesList= new list<SelectOption>();
        contactRolesList.add(new SelectOption('Select','-- Select --'));
        contactRolesList.add(new SelectOption('Decision maker','Decision maker'));
        contactRolesList.add(new SelectOption('Influencer','Influencer'));
        contactRolesList.add(new SelectOption('Approver','Approver'));
        contactRolesList.add(new SelectOption('recommender','recommender'));
        contactRolesList.add(new SelectOption('User','User'));
        contactRolesList.add(new SelectOption('Order placer','Order placer'));
        contactRolesList.add(new SelectOption('Unknown','Unknown'));
        
    } //end of constructor SelectContactPopupControllerUK
    
    //get contacts corresponding to current account. These contacts will be displayed on 
    //'selectContact' Page. Selected contact ID is passed to CPC
    public void getContactRecord() {
        
        try {
            if (accId != '') {
                lstContact = [select Id, Name, firstname, lastname, Phone, MobilePhone, Email, Fax from Contact where AccountId = : accId];
                isContactAvailable(lstContact);
            }
        } catch (Exception e) {
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage());
            ApexPages.addMessage(msg);
        }
    } //end of getContactRecord

    //create new contact on 'SelectContact' page and add it to available contacts on the page
    public void CreateContact() {
        try {
            Contact con = new Contact();
            con.FirstName = conFn;
            con.LastName = conLn;
            con.Phone = conPh;
            con.Email = conEmail;
            con.MobilePhone = conMob;
            con.Fax = conFax;
            if(salesOrgID == '1200')    
                con.Role__c = conRole;
            con.AccountId = Id.valueOf(accId);
            insert con;
            isFromNewContact = true;
            conFn = '';
            conLn = '';
            conPh = '';
            conMob = '';
            conEmail = '';
            conFax = '';
            conRole = 'Select';
            getContactRecord();
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.CONFIRM, 'New Contact has been created successfully!');
            ApexPages.addMessage(msg);
            selectedConId = con.id; 
        }
        catch (Exception e) {
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage());
            ApexPages.addMessage(msg);
        }
    } //end of CreateContact

    public Pagereference next() {
        system.debug('hiddenContact'+System.currentPageReference().getParameters().get('hiddenContact'));
        selectedConId = System.currentPageReference().getParameters().get('hiddenContact');
        url = 'apex/FullQuoteFormUK_VF?id=' + accId + '&conId=' + selectedConId;
        system.debug('url===='+url);
        return null;
    } //end of next

    public void isContactAvailable(list < Contact > listCon) {
        try {
            if (!listCon.isEmpty()) {
                IsContactPresent = true;
            } else {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, 'No Contacts found!');
                ApexPages.addMessage(msg);
                IsContactPresent = false;
            }
        } catch (Exception e) {
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage());
            ApexPages.addMessage(msg);
        }
    } //end of isContactAvailable

   
    public Boolean isPersonalAcc(String accId) {
        try {
            Account acc = [select id, isPersonAccount from Account where Id = : accId];
            if (acc != null && acc.IsPersonAccount) {
                return true;
            } else {
                return false;
            }
        } catch (Exception e) {
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage());
            ApexPages.addMessage(msg);
            return null;
        }
    } //end of isPersonalAcc

   
   public void Createopportunity(){
        Opportunity opp = new Opportunity();
        if(isFromJobProfile){
            String city = ' ';
            String state = ' ';
            if(jobProfileRec.Job_Site_City__c != null && jobProfileRec.Job_Site_City__c != '')
                city = ' ' + jobProfileRec.Job_Site_City__c + ', ';   
            if(jobProfileRec.Job_Site_State__c != null && jobProfileRec.Job_Site_State__c != '')
                state = jobProfileRec.Job_Site_State__c;
            opp.name = acc1.Name + ' - ' + jobProfileName +' -' + city + state;
            opp.Job_Profile__c = jobProfileID;
            opp.Sub_Contractor_Role__c = contractorRole;
            opp.Delivery_City__c = jobProfileRec.Job_Site_City__c;
            opp.Delivery_Country__c = jobProfileRec.Job_Site_Country__c;
            opp.Delivery_State_Province__c = jobProfileRec.Job_Site_State__c;
            opp.Delivery_Street__c = jobProfileRec.Job_Site_Address__c;
            //opp.Shipping_Territory__c = jobProfileRec.Territory__c;
            opp.Delivery_Zip_Postal_Code__c = jobProfileRec.Job_Site_Zip__c;
            
            createShipToRecord();
        }
        else{
            opp.name = acc1.Name;
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
        opp.Opportunity_Contact_Name_LookUpFilter__c = contactId;
        opp.CloseDate = date.today() + 21;
        if(salesOrgID == '1500' || salesOrgID == '1501')
        {
            String etsRentalOppID = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('ETS Rental').getRecordTypeId();
            opp.recordTypeID = etsRentalOppID;
        }
        
        if(cloneQuote == 'Yes' && quoteId != '')
        {
            List<Quote_Header__c> qhList = [select id,opportunity__r.Job_Profile__c from quote_header__c where id=: quoteId];
            Quote_header__c qh = new Quote_header__c();
            if(qhList.size() > 0){
                qh = qhList[0];
                opp.Job_Profile__c = qh.opportunity__r.Job_Profile__c;
            }
        }
        insert opp;
        oppId = String.valueOf(opp.id);
        oppCreated = true;
        
        /*PageReference qemail = new pagereference('http://google.com');
        qemail.setRedirect(true);
        return null;*/
    } //end of Createopportunity
    
    public void createShipToRecord(){
        Shipto__c sto = new Shipto__c(); 
        Job_Profile__c jp = new Job_Profile__c();
        jp = [select ID,Job_Site_Address__c,Job_Site_City__c,Job_Site_Country__c,Job_Site_State__c,Job_Site_Zip__c,
              CurrencyIsoCode,Branch_ID__c,Contact_Phone__c from Job_Profile__c where ID =:jobProfileID];    
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
} //end of class SelectContactPopupControllerUK