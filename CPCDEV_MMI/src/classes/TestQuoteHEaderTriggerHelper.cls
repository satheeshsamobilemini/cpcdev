@isTest
public class TestQuoteHEaderTriggerHelper {
  
    static testmethod void testQuoteHeader() {
     
         Account acc = new Account();
            acc.name='test account';
            acc.Revenue_Q1__c=100.00;
            acc.Revenue_Q2__c=200.00;
            acc.Revenue_Q3__c=100.00;
            acc.Revenue_Q4__c=222.00;
            acc.Revenue_Q5__c=565.00;
            acc.Revenue_Q6__c=5656.00;
            acc.Revenue_Q7__c=56.00;
            acc.Revenue_QC__c=566.00;
           // acc.recordtypeid =  [select id,name from RecordType where name = 'Business Account - UK'].ID;
            acc.recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Business Account - UK').getRecordTypeId();       
             insert acc;
        
        Contact con = new Contact(LastName='Test');
        insert con;
        
        Opportunity opp = new Opportunity(name='Test Opp');
        opp.CloseDate = date.today();
        opp.StageName = 'Not Quoted';
        opp.Opportunity_Rating__c = 'Warm (Possibly Order)';
        opp.Opportunity_Contact_Name_LookUpFilter__c = con.id;
        opp.Account = acc;
        opp.Billing_Zip_Postal_Code__c = '85226';
        opp.Delivery_Zip_Postal_Code__c = '85226';
        opp.Why_do_you_need_storage_Picklist__c = 'Retail';
        opp.How_long_will_you_need_your_unit_UK__c = 2;
       // opp.recordtypeid =  [select id,name from RecordType where name = 'Standard Opportunity - UK'].ID;
        opp.recordtypeid = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity - UK').getRecordTypeId();
        insert opp;
        
        List<Quote_Header__c> recentQuotes = new List<Quote_Header__c>();
         Quote_Header__c QH1=new Quote_Header__c();
            QH1.status__C='Won';
            QH1.Docusign_Status__c='Completed';
            QH1.Opportunity__c = opp.id;
            QH1.Account__c=acc.id;
            QH1.Start_Date__c=Date.Today();
            QH1.Delivery_Date__c=Date.Today();
            QH1.Delivery_City__c = 'Test City';
         recentQuotes.add(QH1);
     
     //insert recentQuotes;
     insert QH1;
     
    
 
     system.debug('------recentQuotes------' + recentQuotes);
     
      Set<String> quoteHdrSet = new Set<String>();
      Quote_Header__c q = [select id,name,SAP_Error_Log__c,Docusign_Status__c,Contract_Number__c from Quote_Header__c where id =: QH1.id];
       quoteHdrSet.add(String.valueOf(q.Name));
       //quoteHdrSet.add(String.valueOf(recentQuotes[0].Name)); 
       doCallOut(quoteHdrSet);
         
            
    }
    
  
    private static void doCallOut(Set<String> quoteHdrSet ){
        Set<String> quoteHdrIdSet = quoteHdrSet; 
        Test.setMock(WebServiceMock.class, new OrderChangeWebServiceMock());
        QuoteHEaderTriggerHelper.docusignStatusUpdateCallout(quoteHdrIdSet);
    }
    
   

}