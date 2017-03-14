/**
* (c) 2016 TEKsystems Global Services
*
* Name           : TestSendEmailQuote
* Created Date   : 21 Mar, 2016
* Created By     : Harthi 
* Purpose        : Test class for SendEmailQuote class.
* 
**/
@isTest
public class TestSendEmailQuote {
    static testMethod void Test1()
    {
       /* User u = new User();
        //u.Name = 'TestUser';
        u.Email = 'testuser@salesrep.com';
        insert u;*/
        List<User> u = createUsers(1);
        Account acc = new Account();
            acc.name='test account';
            //acc.recordtypeid =  [select id,name from RecordType where name = 'Business Account'].ID;
            acc.recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Business Account').getRecordTypeId();
            acc.BillingState = 'AZ';
            acc.BillingCountry = 'US';
            insert acc;
        
        Account acc1 = new Account();
            acc1.lastname='test account';
        //acc1.IsPersonAccount = true;
            //acc.recordtypeid =  [select id,name from RecordType where name = 'Business Account'].ID;
            acc1.Decision_Maker__pc = 'Yes';
            acc1.CurrencyIsoCode = 'USD';
            acc1.recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Residential Account').getRecordTypeId();
            acc1.BillingState = 'AZ';
            acc1.BillingCountry = 'US';
            insert acc1;
        
        Contact con = new Contact(LastName='Test');
        con.FirstName = 'Test';
        con.Email = 'abc@abc.com';
        con.AccountId = acc.id;
        insert con;
        
        Opportunity opp = new Opportunity(name='Test Opp');
        opp.CloseDate = date.today();
        opp.StageName = 'Not Quoted';
        opp.Opportunity_Rating__c = 'Warm (Possibly Order)';
        //opp.Opportunity_Contact_Name_LookUpFilter__c = con.id;
        opp.Account = acc;
        opp.Billing_Zip_Postal_Code__c = '85226';
        opp.Delivery_Zip_Postal_Code__c = '85226';
        opp.Why_do_you_need_storage_Picklist__c = 'Retail';
        opp.How_long_will_you_need_your_unit_UK__c = 2;
        //opp.recordtypeid =  [select id,name from RecordType where name = 'Standard Opportunity'].ID;
        opp.recordtypeid = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity').getRecordTypeId();
        insert opp;
        
        Opportunity opp1 = new Opportunity(name='Test Opp1');
        opp1.CloseDate = date.today();
        opp1.StageName = 'Not Quoted';
        opp1.Opportunity_Rating__c = 'Warm (Possibly Order)';
        //opp1.Opportunity_Contact_Name_LookUpFilter__c = con.id;
        opp1.Account = acc;
        opp1.Billing_Zip_Postal_Code__c = '85226';
        opp1.Delivery_Zip_Postal_Code__c = '85226';
        opp1.Why_do_you_need_storage_Picklist__c = 'Retail';
        opp1.How_long_will_you_need_your_unit_UK__c = 2;
        //opp.recordtypeid =  [select id,name from RecordType where name = 'Standard Opportunity'].ID;
        opp1.recordtypeid = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity').getRecordTypeId();
        insert opp1;
      
            
        List<Quote_Header__c> recentQuotes = new List<Quote_Header__c>();
        Quote_Header__c QH1=new Quote_Header__c();
            QH1.status__C='Open';
            QH1.Opportunity__c = opp.id;
            QH1.SalesRep_Email__c = 'testuser@salesrep.com';
            QH1.Account__c=acc.id;
            QH1.Start_Date__c=Date.Today();
            QH1.Delivery_Date__c=Date.Today();
            QH1.Delivery_City__c = 'Test City';
            QH1.contact__c = con.id;
            QH1.type__c = 'ZREN';
            recentQuotes.add(QH1);
        
        Quote_Header__c QH2=new Quote_Header__c();
            QH2.status__C='Open';
            QH2.Opportunity__c = opp1.id;
            QH2.SalesRep_Email__c = 'testuser@salesrep.com';
            QH2.Account__c=acc1.id;
            QH2.Start_Date__c=Date.Today();
            QH2.Delivery_Date__c=Date.Today();
            QH2.Delivery_City__c = 'Test City';
            QH2.contact__c = con.id;
            QH2.type__c = 'ZSLS';
            recentQuotes.add(QH2);
        insert recentQuotes;
        
        List<Quote_Item_Level__c > recentQuotes2 = new List<Quote_Item_Level__c >();
        Quote_Item_Level__c QL1 =new Quote_Item_Level__c();
            QL1.Quote_Header__c=QH1.id;
            QL1.Item_Code__c='TESTCODE';
            QL1.Actual_Amount__c=25.00;
            QL1.Description__c = 'DELIVERY';
            recentQuotes2.add(QL1);
       
          //  insert recentQuotes2;
       
        
        //createEmailTemplate();
     Test.startTest()  ; 
         ApexPages.currentPage().getParameters().put('quoteID',QH1.id);
         ApexPages.currentPage().getParameters().put('salesorg','1000');
         ApexPages.currentPage().getParameters().put('type','sales');
         SendEmailQuote seq = new SendEmailQuote();
         seq.selectedPDF = 'Normal';
        seq.attachPDFtoQuoteHeader();
        seq.fillTo();
        SendEmailQuote.ConWrapper SEQCW = new  SendEmailQuote.ConWrapper();
        SEQCW.isChecked = true;
        seq.removeTo();
        //seq.bccAddress ='textbc1@mobilemini.com;textbc2@mobilemini.com';
        //seq.fillBCC();
        //seq.ccAddress ='textbcc1@mobilemini.com;textbcc2@mobilemini.com';
        //seq.fillCC();
        seq.resetMailUK();
        seq.toggleDocs();
        seq.toggleUnitDocs();
        seq.resetMail();
        seq.sendMail();
        seq.cancelMail();
        seq.cancelMailUK();
        seq.attachmentListViewMethod();
        seq.deleteAttachach();
        seq.showEmailTemplate();
        //seq.generateSignature(u[0]);
        seq.sendMailUK();
        seq.previewQuote();
         
        ApexPages.currentPage().getParameters().put('quoteID',QH1.id);
        ApexPages.currentPage().getParameters().put('salesorg','1501');
        ApexPages.currentPage().getParameters().put('type','');
         SendEmailQuote seq2 = new SendEmailQuote();
        seq2.attachPDFtoQuoteHeader();
        
        ApexPages.currentPage().getParameters().put('quoteID',QH1.id);
        ApexPages.currentPage().getParameters().put('salesorg','1200');
        ApexPages.currentPage().getParameters().put('type','');
         SendEmailQuote seq3 = new SendEmailQuote();
        seq3.attachPDFtoQuoteHeader();
        
        ApexPages.currentPage().getParameters().put('quoteID','invalidquoteid');
        ApexPages.currentPage().getParameters().put('salesorg','1200');
        ApexPages.currentPage().getParameters().put('type','invalidtype');
        SendEmailQuote seq4 = new SendEmailQuote();
        seq4.attachPDFtoQuoteHeader();
        
        ApexPages.currentPage().getParameters().put('quoteID',QH2.id);
        ApexPages.currentPage().getParameters().put('salesorg','1100');
        ApexPages.currentPage().getParameters().put('type','rental');
        SendEmailQuote seq5 = new SendEmailQuote();
        seq5.selectedPDF = 'Extended';
        seq5.attachPDFtoQuoteHeader();
     Test.stopTest();   
    }
    
    public static List<User> createUsers(integer size){
        List<User> users = new List<User>();
        Id profileId;
        List<Profile> profiles = [select id from profile where name = 'Customer Sales Specialist - NSC - US' limit 1];
        if(profiles.size() > 0){
            profileId= profiles.get(0).id;
        }else{
            Profile p2 = [select id from profile where name='System Administrator'];
            profileId = p2.id;
        }
        
        for(Integer i=0;i < size ;i++){
            User user = new User(Available_For_Leads__c=True,alias = 'SubUser', email='salesrep@testorg.com',
                 emailencodingkey='UTF-8', firstname='SubUserTesting' + DateTime.now()+'--'+i,lastname='SubUserTesting' +DateTime.now()+'-'+i,languagelocalekey='en_US',
                 localesidkey='en_US', profileid = profileId, timezonesidkey='America/Los_Angeles', 
                 username='salesrep@testorg.com'+i ,Branch__c ='101',Street='testStreet',city='testcity',state='teststate',PostalCode='123456',phone='1290000');
            users.add(user);
        }
        insert users;
        return users;
    }
    
    /*@future
    public static void createEmailTemplate(){
        Id folderId = UserInfo.getUserId();
         EmailTemplate e = new EmailTemplate (developerName = 'test',FolderId=folderId, subject='test subject {!Contact.', TemplateType= 'Text', Name = 'test'); // plus any other fields that you want to set
        insert e;
        
    }*/
}