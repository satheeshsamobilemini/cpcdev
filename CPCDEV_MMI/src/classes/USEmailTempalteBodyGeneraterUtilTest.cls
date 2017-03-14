@isTest
private class USEmailTempalteBodyGeneraterUtilTest{
     @isTest static void testUSEmailTempBodyGen(){
        
        string cf2;
        User testUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()]; 
        /*User u = new User();
        u.Name = 'TestUser';
        u.Email = 'testuser@salesrep.com';
        insert u; */
        System.runAs (testUser) {

        Account acc = new Account();
        acc.name='test account';
        acc.recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Business Account').getRecordTypeId();
        acc.BillingState = 'AZ';
        acc.BillingCountry = 'US';
        insert acc;
        
        Contact con = new Contact();
        con.LastName='Test';
        con.FirstName = 'Test';
        con.Email = 'abc@abc.com';
        con.AccountId = acc.id;
        insert con;
        
        Opportunity opp = new Opportunity();
        opp.name='Test Opp';
        opp.CloseDate = date.today();
        opp.StageName = 'Not Quoted';
        opp.Opportunity_Rating__c = 'Warm (Possibly Order)';
        opp.Account = acc;
        opp.Billing_Zip_Postal_Code__c = '85226';
        opp.Delivery_Zip_Postal_Code__c = '85226';
        opp.Why_do_you_need_storage_Picklist__c = 'Retail';
        opp.How_long_will_you_need_your_unit_UK__c = 2;
        opp.recordtypeid = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity').getRecordTypeId();
        insert opp;
        
        Quote_Header__c QH=new Quote_Header__c();
        QH.status__C='Open';
        QH.Opportunity__c = opp.id;
        QH.SalesRep_Email__c = 'testuser@salesrep.com';
        QH.Account__c=acc.id;
        QH.Start_Date__c=Date.Today();
        QH.Delivery_Date__c=Date.Today();
        QH.Delivery_City__c = 'Test City';
        QH.contact__c = con.id;
        QH.type__c = 'ZREN';
        insert QH;
        
        
        Id folderId = UserInfo.getUserId();
        EmailTemplate ET = new EmailTemplate ();
        ET.TemplateType= 'Text';
        ET.TemplateStyle= 'formalLetter';
        ET.subject='test subject {!Contact.';
        ET.Name = 'test';
        ET.developerName = 'test';
        ET.FolderId=folderId;
        ET.Body = 'test body {!Contact.';
        insert ET;
        
        EmailTemplate ET1 = new EmailTemplate ();
        ET1.TemplateType= 'Text';
        ET1.TemplateStyle= 'formalLetter';
        ET1.subject='test subject {!Contact.';
        ET1.Name = 'test';
        ET1.developerName = 'DeveloperTest';
        ET1.FolderId=folderId;
        ET1.Body = 'test body {!User.';
        insert ET1;
        
        Map<String, Schema.SObjectField> schemaFieldMapCon = Schema.SObjectType.Contact.fields.getMap();
        map<String,String> fildAndTyp = new map<String,String>();
        fildAndTyp = USEmailTempalteBodyGeneraterUtil.generateFldTypeMap(schemaFieldMapCon);
        
        String contactQuery = 'Select ';
        for (String fieldName: schemaFieldMapCon.keySet()) {
            contactQuery += fieldName + ',';
        }
        
        contactQuery = contactQuery.substring(0,contactQuery.length() - 1);
        contactQuery += ' from Contact where Id =\''+con.Id+'\'';
        
        Contact conObject = database.query(contactQuery);
        Map<String, Object> queriedConFieldValues = (Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(conObject));
        set<String> setConFlds = new set<String>();
        for(String s: queriedConFieldValues.keySet()){
            setConFlds.add(s);
        }
        system.debug('------setConFlds----------'+setConFlds);
        for(String cf : setConFlds){
            cf2 = cf;
        }
        
        EmailTemplate ET2 = new EmailTemplate ();
        ET2.TemplateType= 'Text';
        ET2.TemplateStyle= 'formalLetter';
        ET2.subject='test subject {!Contact.';
        ET2.Name = 'test';
        ET2.developerName = 'DeveloperTest1';
        ET2.FolderId=folderId;
        ET2.Body = '{!Contact.'+cf2+'}';
        insert ET2;
        
       
        Test.startTest();
        USEmailTempalteBodyGeneraterUtil USEmailTBGU = new USEmailTempalteBodyGeneraterUtil();
        USEmailTempalteBodyGeneraterUtil.generateEmailBody(QH.Id,opp.Id,acc.Id,con.Id,QH.type__c,ET.Id);
        USEmailTempalteBodyGeneraterUtil.generateEmailBody(QH.Id,opp.Id,acc.Id,con.Id,QH.type__c,ET1.Id);
        USEmailTempalteBodyGeneraterUtil.generateEmailBody(QH.Id,opp.Id,acc.Id,con.Id,QH.type__c,ET2.Id);
         
            
        Test.stopTest();
        }
    }
    @isTest static void testUSEmailTempBodyGen2(){
        User testUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()]; 
        system.runAs(testUser){
            Account acc = new Account();
            acc.name='test account';
            acc.recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Business Account').getRecordTypeId();
            acc.BillingState = 'AZ';
            acc.BillingCountry = 'US';
            insert acc;
            
            Contact con = new Contact();
            con.LastName='Test';
            con.FirstName = 'Test';
            con.Email = 'abc@abc.com';
            con.AccountId = acc.id;
            insert con;
            
            Id folderId = UserInfo.getUserId();
            EmailTemplate ET = new EmailTemplate ();
            ET.TemplateType= 'Text';
            ET.TemplateStyle= 'formalLetter';
            ET.subject='test subject {!Contact.';
            ET.Name = 'test';
            ET.developerName = 'test';
            ET.FolderId=folderId;
            ET.Body = 'test body {!Contact.';
            insert ET;
            
            map<String,String> fildAndTyp = new map<String,String>();
            fildAndTyp.put('ErrorComment__c','DOUBLE');
            fildAndTyp.put('ErrorComment__c','DATETIME');
            fildAndTyp.put('ErrorComment__c','DATE');
            
            USEmailTempalteBodyGeneraterUtil.typeConversion(ET.Body,'Account.Owner',con,'ErrorComment__c',fildAndTyp);
            
        }
    }
}