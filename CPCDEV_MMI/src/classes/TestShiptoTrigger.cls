@isTest
public class TestShiptoTrigger {
    
    static testmethod void shiptoTest(){
        Account acc = new Account(Name = 'testacc');
            acc.recordtypeid =  [select id,name from RecordType where name = 'Business Account'].ID;
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
        opp.recordtypeid =  [select id,name from RecordType where name = 'Standard Opportunity - UK'].ID;
        insert opp;
        
         Shipto__c shp = new Shipto__c();
        shp.Account__c = acc.id;
        shp.Address__c = 'tst add';
        shp.City__c = 'tst cty';
        shp.Country__c = 'tst cntry';
        shp.Distance_From_Branch__c = 12.00;
        shp.Email__c ='tst@tst.tst';
        shp.Zip__c = '342522';
        shp.Phone__c = '1234565655';
        insert shp;
        
        List<Quote_Header__c> recentQuotes = new List<Quote_Header__c>();
        Quote_Header__c QH1=new Quote_Header__c();
            QH1.status__C='Open';
            QH1.Account_Shipto__c = String.valueOf(shp.Id);
            QH1.Opportunity__c = opp.id;
            QH1.Account__c=acc.id;
            QH1.Start_Date__c=Date.Today();
            QH1.Delivery_Date__c=Date.Today();
            QH1.Delivery_City__c = 'Test City';
            recentQuotes.add(QH1);
       
        insert recentQuotes;
        
       
        
        shp.Distance_From_Branch__c = 11.00;
        update shp;
        
    }

}