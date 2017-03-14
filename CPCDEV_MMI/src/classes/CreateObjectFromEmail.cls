global class CreateObjectFromEmail implements Messaging.InboundEmailHandler {
    
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.inboundEmail email, Messaging.InboundEnvelope env) {
 
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        
        // Try and extract the object name from the subject
        String subject = email.subject.trim().toLowerCase();
        if (subject.startsWith('new '))
            subject = subject.substring(4).trim();
        
        sObject[] newObjects = new sObject[0];
        sObject newObject;
        
        // See if we can find the new object type
        sObjectType sot;
        Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
        for (String objectName : gd.keyset()){
            if(objectName.toLowerCase() == subject){
                sot = gd.get(objectName);
                newObject = sot.newSObject();
                newObjects.add(newObject);
                break;
            }
        }
        
        // If not found, exit
        if (newObject == null) {
            result.message = 'Could not find the object name in the email subject';
            result.success = false;
            return result;
        }
        
        Schema.DescribeSObjectResult sotd = sot.getDescribe();
        Map<String, Schema.sObjectField> M = sotd.fields.getMap();

        // Populate default fields
        Map<String, ObjectFromEmailDefaultFields__c> defs = ObjectFromEmailDefaultFields__c.getAll();
        for (ObjectFromEmailDefaultFields__c def : defs.values()) {
            if (def.Object_Name__c.toLowerCase() == subject) {
                string fieldName = def.Field_Name__c;
                // Try to set it
                Schema.DescribeFieldResult F = M.get(fieldName).getDescribe();
                string typename = F.getType().name().toLowerCase();
                if (typename == 'integer' || typename == 'double' || typename == 'percent' || typename == 'currency') {
                    newObject.put(fieldName, def.Default_Value_Number__c);
                } else if (typename == 'boolean') {
                    newObject.put(fieldName, def.Default_Value_Checkbox__c);
                } else if (typename == 'date') {
                    newObject.put(fieldName, def.Default_Value_Date__c);
                } else if (typename == 'datetime') {
                    newObject.put(fieldName, def.Default_Value_DateTime__c);
                } else {
                    newObject.put(fieldName, def.Default_Value_Text__c);
                }
            }
        }

        Map<String, ObjectFromEmailAcceptedFields__c> allowed = ObjectFromEmailAcceptedFields__c.getAll();
        Map<String, ObjectFromEmailAcceptedFields__c> allowed2 = new Map<String, ObjectFromEmailAcceptedFields__c>();
        for (ObjectFromEmailAcceptedFields__c all : allowed.values())
            allowed2.put(all.Object_Name__c.toLowerCase() + '|' + all.Field_Name__c.toLowerCase(), all);

        // Search [...]={...} strings in the email body using regex
        Matcher myMatcher = Pattern.compile('\\[[^\\]]*\\]=\\{[^\\}]*\\}').matcher(email.plainTextBody);
        while (myMatcher.find()) {
            String myMatch = myMatcher.group(0);
            // Get the field name
            string fieldName = myMatch.substring(1);
            fieldName = fieldName.substring(0, fieldName.indexOf(']'));
            // Skip if is not allowed
            if (allowed2.get(subject.toLowerCase() + '|' + fieldName.toLowerCase()) == null)
                continue;
            // Get the field value
            string fieldValue = myMatch.substring(myMatch.indexOf('{') + 1);
            fieldValue = fieldValue.substring(0, fieldValue.indexOf('}'));
            // Try to set it
            Schema.DescribeFieldResult F = M.get(fieldName).getDescribe();
            string typename = F.getType().name().toLowerCase();
            if (typename == 'integer' || typename == 'double' || typename == 'percent' || typename == 'currency') {
                newObject.put(fieldName, Double.valueOf(fieldValue));
            } else if (typename == 'boolean') {
                newObject.put(fieldName, Boolean.valueOf(fieldValue));
            } else if (typename == 'date') {
                newObject.put(fieldName, Date.valueOf(fieldValue));
            } else if (typename == 'datetime') {
                newObject.put(fieldName, DateTime.valueOf(fieldValue));
            } else {
                newObject.put(fieldName, fieldValue);
            }
        }
        
        // Try and insert the new object
        try {
            insert newObjects;
        }
        catch (Exception ex) {
            result.message = 'Insert problem: ' + ex;
            result.success = false;
            return result;
        }

        result.success = true;
        return result;
     
    }
    
    static testMethod void testHandleInboundEmail() {

        List<ObjectFromEmailDefaultFields__c> ds = new List<ObjectFromEmailDefaultFields__c>();
        ObjectFromEmailDefaultFields__c d1 = new ObjectFromEmailDefaultFields__c();
        d1.Name = 'd1';
        d1.Object_Name__c = 'Contact';
        d1.Field_Name__c = 'Email';
        d1.Default_Value_Text__c = 'lucian@vertiba.com';
        ds.add(d1);
        ObjectFromEmailDefaultFields__c d2 = new ObjectFromEmailDefaultFields__c();
        d2.Name = 'd2';
        d2.Object_Name__c = 'Contact';
        d2.Field_Name__c = 'DoNotCall';
        d2.Default_Value_Checkbox__c = true;
        ds.add(d2);
        ObjectFromEmailDefaultFields__c d3 = new ObjectFromEmailDefaultFields__c();
        d3.Name = 'd3';
        d3.Object_Name__c = 'Contact';
        d3.Field_Name__c = 'Birthdate';
        d3.Default_Value_Date__c = Date.newInstance(2010, 10, 11);
        ds.add(d3);
        insert ds;

        List<ObjectFromEmailAcceptedFields__c> acs = new List<ObjectFromEmailAcceptedFields__c>();
        ObjectFromEmailAcceptedFields__c ac1 = new ObjectFromEmailAcceptedFields__c();
        ac1.Name = 'ac1';
        ac1.Object_Name__c = 'Contact';
        ac1.Field_Name__c = 'Department';
        acs.add(ac1);
        ObjectFromEmailAcceptedFields__c ac2 = new ObjectFromEmailAcceptedFields__c();
        ac2.Name = 'ac2';
        ac2.Object_Name__c = 'Contact';
        ac2.Field_Name__c = 'FirstName';
        acs.add(ac2);
        ObjectFromEmailAcceptedFields__c ac3 = new ObjectFromEmailAcceptedFields__c();
        ac3.Name = 'ac3';
        ac3.Object_Name__c = 'Contact';
        ac3.Field_Name__c = 'LastName';
        acs.add(ac3);
        insert acs;
  
        Messaging.inboundEmail email = new Messaging.inboundEmail();
        email.subject = 'New Contact';
        String tempSubj = 'Lucian ' + DateTime.now().format() + ' - 1';
        email.plainTextBody = '[Department]={' + tempSubj + '}';
        email.plainTextBody += ', [HomePhone]={MyHomePhone}';
        email.plainTextBody += ', [FirstName]={MyFName}';
        email.plainTextBody += ', [LastName]={MyLName}';
        System.Debug('Text body: ' + email.plainTextBody);
      
        CreateObjectFromEmail csee = new CreateObjectFromEmail();
      
        test.startTest();
        
        Messaging.InboundEmailResult result = csee.handleInboundEmail(email, null);
        
        test.stopTest();
      
        System.assert(result.success);
        
        Contact newCnt = [SELECT Id, Email, DoNotCall, Birthdate, Department, HomePhone FROM Contact WHERE Department = :tempSubj];
        
        System.assertEquals('lucian@vertiba.com', newCnt.Email);
        System.assertEquals(true, newCnt.DoNotCall);
        System.assertEquals(Date.newInstance(2010, 10, 11), newCnt.Birthdate);
        System.assertEquals(null, newCnt.HomePhone);
        System.assertEquals(tempSubj, newCnt.Department);
    }
    
}