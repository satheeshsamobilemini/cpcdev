@isTest
public class TestCreateUpdateTaskonQuote {
    static testMethod void testTaskCreateUpdate()
   {
     Account acc = new Account();
            acc.name='test account';
            acc.BillingState = 'AZ';
            acc.BillingCountry = 'US';
            insert acc;
        
        Contact con = new Contact(LastName='Test');
        insert con;
       List<Opportunity> oppList = new List<Opportunity>();
       for(integer i=0;i<5;i++){ 
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
        //opp.recordtypeid =  [select id,name from RecordType where name = 'Standard Opportunity - UK'].ID;
        opp.recordtypeid =  Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity - UK').getRecordTypeId();
           oppList.add(opp);
       } 
        insert oppList;    
            
        List<Quote_Header__c> QHList=new List<Quote_Header__c>();
       for(integer i=0;i<5;i++){
          Quote_Header__c QH=new Quote_Header__c();
          QH.status__C='Open';
            QH.Account__C=acc.id;
            QH.Contact__c=con.id;
            //QH.Actual_Createdby__c='sjailabd@teksystems.com';
            QH.Opportunity__c = oppList.get(i).ID;
            QH.Start_Date__c=Date.Today();
            QH.Delivery_Date__c=date.newinstance(2016, 4, 17);
            QH.How_long_do_you_need_your_unit_weeks__c=date.newinstance(2016, 8, 17);
            QH.Delivery_City__c = 'Test City';
            QH.Branch__c='101';
            QH.Billing_Zip__c='85022'; 
           Integer remainder = Math.mod(i,2);
           System.debug('remainder......'+remainder);
           if( remainder == 0)
           {
               QH.Create_Followup_Task__c = true;
               QH.Update_Followup_Task__c = false;
           }
           else
           {
               QH.Update_Followup_Task__c = true;
                QH.Create_Followup_Task__c = false;
           }
               QHList.add(QH);
       }
        insert QHList;
       CrtUpdateTaskOnQuoteCrtUpdate createUpdateTaskVar = new CrtUpdateTaskOnQuoteCrtUpdate();
        ID batchprocessid = Database.executeBatch(createUpdateTaskVar,2000);
   }
}