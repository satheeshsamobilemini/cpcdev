global class SendXMLToResult {
  webservice static String sendToResult(String accountId, String contactId) {
    try {
      
      // Practice = Practice
      // Workshop = Sandbox
      // UAT = UAT
      // Live = Production
      
      String ResultEndpoint = '';
      
      // String to toggle test/development mode
      String ResultOrg = 'Live';
      
      //String ResultUSLiveEndPoint = 'http://216.3.172.109:9102/goldmine/GoldmineImporter'; // commented for TFS 3456
      String ResultUSLiveEndPoint = '';
      //String ResultUSLiveEndPoint = 'http://65.156.231.2:9102/goldmine/GoldmineImporter';           Data Center Test
      //String ResultUKLiveEndPoint = 'http://212.42.4.20:9102/goldmine/GoldmineImporter';  // commented for TFS 3456
	  String ResultUKLiveEndPoint = '';
      //String ResultUSWorkshopEndPoint = 'http://216.3.172.110:9106/goldmine/GoldmineImporter';// commented for TFS 3456
      String ResultUSWorkshopEndPoint = '';
      //String ResultUKWorkshopEndPoint = 'http://212.42.4.20:8002/goldmine/GoldmineImporter';// commented for TFS 3456
      String ResultUKWorkshopEndPoint = '';
      //String ResultUKUATEndPoint = 'http://212.42.4.20:9108/goldmine/GoldmineImporter';  // commented for TFS 3456
      String ResultUKUATEndPoint = '';
      //String ResultUSPracticeEndpoint = 'http://216.3.172.110:9020/goldmine/GoldmineImporter';// commented for TFS 3456
      String ResultUSPracticeEndpoint = '';
      //-------------------TFS 3456------Starts--------------------------------------------------------
      AllThirdPartyEndPoints__c AllThirdPartyEndPointUrl = AllThirdPartyEndPoints__c.getInstance('ThirdPartyEndPoints');
	  ResultUSLiveEndPoint = AllThirdPartyEndPointUrl.ResultUSLiveEndPoint__c;
	  ResultUKLiveEndPoint = AllThirdPartyEndPointUrl.ResultUKLiveEndPoint__c;
	  ResultUSWorkshopEndPoint = AllThirdPartyEndPointUrl.ResultUSWorkshopEndPoint__c;
	  ResultUKWorkshopEndPoint = AllThirdPartyEndPointUrl.ResultUKWorkshopEndPoint__c;
	  ResultUKUATEndPoint = AllThirdPartyEndPointUrl.ResultUKUATEndPoint__c;
	  ResultUSPracticeEndpoint = AllThirdPartyEndPointUrl.ResultUSPracticeEndpoint__c;
	  system.debug('----------ResultUSLiveEndPoint----------------'+ResultUSLiveEndPoint);
	  system.debug('----------ResultUKLiveEndPoint----------------'+ResultUKLiveEndPoint);
	  system.debug('----------ResultUSWorkshopEndPoint----------------'+ResultUSWorkshopEndPoint);
	  system.debug('----------ResultUKWorkshopEndPoint----------------'+ResultUKWorkshopEndPoint);
	  system.debug('----------ResultUKUATEndPoint----------------'+ResultUKUATEndPoint);
	  system.debug('----------ResultUSPracticeEndpoint----------------'+ResultUSPracticeEndpoint);
	 //-------------------TFS 3456-----Ends---------------------------------------------------------
      List<Account> accounts = new List<Account>() ;
      
      if(contactId.trim() != '') {
         accounts = new List<Account>([Select id, Name, BillingStreet, BillingCity, BillingState, BillingPostalCode , BillingCountry,
                                Website, Branch__c, Owner.Sales_Rep_Id__c, Result_Id__c, Phone, Fax, PersonContactId,NumericPhone__c
                                from Account where Id = :accountId.trim()]);
      
      }else{
        //Person Account 
         accounts = new List<Account>([Select id, BillingStreet, BillingCity, BillingState, BillingPostalCode , BillingCountry,
                                Website, Branch__c, Owner.Sales_Rep_Id__c, Result_Id__c, Phone, Fax, PersonContactId,NumericPhone__c
                                from Account where Id = :accountId.trim()]);
      
       }
      
      
      if(accounts.size() < 1)
        return 'Error: No Account with this id exists. ' + accountId;
      
      XmlStreamWriter writer = new XmlStreamWriter();
      writer.writeStartDocument(null, '1.0');
      //////////
      //writer.writeStartElement(null, 'Contact', null);  
      Contact c = new Contact();
      
      
      if(contactId.trim() != '') {
        List<Contact> contacts = new List<Contact>([Select Name, Title, MailingCountry, Phone, MobilePhone, HomePhone, Salutation, Email 
                                    from Contact where Id = :contactId.trim() ]);
        if(contacts.size() < 1)
          return 'Error: No Contact with this id exists. ' + contactId;  
        c = contacts.get(0);
      }
      else { //person account
         List<Contact> contacts = new List<Contact>([Select Name, Title, MailingCountry, Phone, MobilePhone, HomePhone, Salutation, Email 
                                    from Contact where Id = :accounts.get(0).PersonContactId]);
        if(contacts.size() < 1)
          return 'Error: No Contact with this id exists. ' + contactId;  
        c = contacts.get(0);
        
      }  

      // Determine what endpoint we need to hit
      // Branches beginning with '7' are UK Branches and need to go to UK Result
      
      if (accounts.get(0).Branch__c.startsWith('7')){
        // See if we need to go to Live or Workshop
        if (ResultOrg == 'Live'){
            ResultEndpoint = ResultUKLiveEndPoint;
        }
        else if (ResultOrg == 'UAT'){
            ResultEndpoint = ResultUKUATEndPoint;
        }       
        else{
            ResultEndpoint = ResultUKWorkshopEndPoint;
        }
      }
      else{
        if (ResultOrg == 'Live'){
            ResultEndpoint = ResultUSLiveEndPoint;
        }
        else if(ResultOrg == 'Workshop'){
            ResultEndpoint = ResultUSWorkshopEndPoint;
        }       
        else{
            ResultEndpoint = ResultUSPracticeEndpoint;
        }
      }
     
      writer.writeStartElement(null, 'goldmineImporter', null);
      
      //Kirtesh --Start modified for PersonAccount
      if( accounts.get(0).PersonContactId != null  ) {
        //Person Account 
        writeElement('Company', c.Name , writer);
      }else{
        writeElement('Company', accounts[0].Name, writer);
      }
      //Kirtesh--End modification
     
      writeElement('SalesforceID', accounts.get(0).Id, writer);
      // For testing - result should not accept a Salesforce ID > 18 chars
      //writeElement('SalesforceID', '123456789012345678901', writer);
     
      writeElement('Contact', c.Name, writer);
      
      List<String> addresses = splitAddress(accounts.get(0).BillingStreet);
      
      if(addresses.size() == 1)
        writeElement('Address1', accounts.get(0).BillingStreet, writer);
      else
        writeElement('Address1', addresses.get(0), writer);
      if(addresses.size() > 1)
        writeElement('Address2', addresses.get(1), writer);
      else
        writeElement('Address2', '', writer);
      if(addresses.size() > 2)
        writeElement('Address3', addresses.get(2), writer);
      else
        writeElement('Address3', '', writer);
        
      writeElement('City', accounts.get(0).BillingCity, writer);
 
      // Do not pass the State/Province if Country = GB
      if (accounts.get(0).Branch__c.startsWith('7')){
      
        writeElement('State', '', writer);
      
      }

      else{

        // Convert States to 2 Letter Abbr
        String resultFriendlyState = stateAbrieviation(accounts.get(0).BillingState);
        writeElement('State', resultFriendlyState, writer);
      
      }
      
      if(accounts.get(0).BillingPostalCode == null)
        writeElement('Zip', '', writer);
      else
        writeElement('Zip', String.valueOf(accounts.get(0).BillingPostalCode), writer);
      
      // Make sure the country code is GB, USA, or CAN before writing the value
      // Return a message to the user if it is not
      
      // Convert Country to a Result friendly value
      String resultFriendlyCountry = translateCountry(accounts.get(0).BillingCountry);

      if ((resultFriendlyCountry <> 'GB') && (resultFriendlyCountry <> 'USA') && (resultFriendlyCountry <> 'CAN')){
      
        return 'Please enter a valid country code.  Valid options are: GB, USA, CAN';
      
      }
      else{

          writeElement('Country', resultFriendlyCountry, writer);
      
      }
      
      List<String> phoneNumber = new List<string>();
      List<String> faxNumber = new List<string>();
      List<String> mobileNumber = new List<string>();
      List<String> homeNumber = new List<string>();
      
      if(accounts.get(0).Phone == null){
        writeElement('Phone1', '', writer);
      } 
      else if(accounts.get(0).Branch__c.startsWith('7')){
        if(resultFriendlyCountry != null && resultFriendlyCountry == 'GB'){
            writeElement('Phone1', generateNumericPhone(accounts.get(0)), writer);
        }else{
            writeElement('Phone1', String.valueOf(accounts.get(0).Phone), writer);
        }
      } 
      else {
          if(resultFriendlyCountry != null && resultFriendlyCountry == 'GB'){
            writeElement('Phone1', generateNumericPhone(accounts.get(0)), writer);
          }else{
            phoneNumber = splitPhoneNumber(String.valueOf(accounts.get(0).Phone));
            writeElement('Phone1', phoneNumber.get(0), writer);
         }
          
         //writeElement('Phone1', String.valueOf(accounts.get(0).Phone), writer);
      }
      
      if(c.MobilePhone == null){
        writeElement('Phone2', '', writer);
      }
      else if(accounts.get(0).Branch__c.startsWith('7')){
        writeElement('Phone2', String.valueOf(c.MobilePhone), writer);
      }
      else{
        mobileNumber = splitPhoneNumber(String.valueOf(c.MobilePhone));
        writeElement('Phone2', mobileNumber.get(0), writer);

      }
            
      if(c.HomePhone == null){
        writeElement('Phone3', '', writer);
      }
      else if(accounts.get(0).Branch__c.startsWith('7')){
            if(resultFriendlyCountry != null && resultFriendlyCountry == 'GB'){
                writeElement('Phone3', Utils.processNumericPhone(c.HomePhone), writer);
            }else{
                writeElement('Phone3', String.valueOf(c.HomePhone), writer);
            }
        //writeElement('Phone3', String.valueOf(c.HomePhone), writer);
      }
      else{
            if(resultFriendlyCountry != null && resultFriendlyCountry == 'GB'){
                writeElement('Phone3', Utils.processNumericPhone(c.HomePhone), writer);
            }else{
                homeNumber = splitPhoneNumber(String.valueOf(c.HomePhone));
                writeElement('Phone3', String.valueOf(c.HomePhone), writer);
            }
            //writeElement('Phone3', homeNumber.get(0), writer);      
      }
            
      if(accounts.get(0).Fax == null){
        writeElement('FAX', '', writer);
      } 
      else if(accounts.get(0).Branch__c.startsWith('7')){
            if(resultFriendlyCountry != null && resultFriendlyCountry == 'GB'){
                writeElement('FAX', Utils.processNumericPhone(accounts.get(0).Fax), writer);
            }else{
                writeElement('FAX', String.valueOf(accounts.get(0).Fax), writer);
            }
      } 
      else{
            if(resultFriendlyCountry != null && resultFriendlyCountry == 'GB'){
                writeElement('FAX', Utils.processNumericPhone(accounts.get(0).Fax), writer);
            }else{
                faxNumber = splitPhoneNumber(String.valueOf(accounts.get(0).Fax));
                writeElement('FAX', String.valueOf(accounts.get(0).Fax), writer);
            }
        //faxNumber = splitPhoneNumber(String.valueOf(accounts.get(0).Fax));
        //writeElement('FAX', faxNumber.get(0), writer);
        //writeElement('FAX', String.valueOf(accounts.get(0).Fax), writer);
      }
      
      if(c.Email == null)
        writeElement('Email', '', writer);
      else
        writeElement('Email', String.valueOf(c.Email), writer);
      
      writeElement('RepCode', accounts.get(0).Owner.Sales_Rep_Id__c, writer);
      
      writeElement('BranchCode', accounts.get(0).Branch__c, writer);
      
      if(accounts.get(0).Website == null)
        writeElement('WebSite', '', writer);
      else
        writeElement('WebSite', String.valueOf(accounts.get(0).Website), writer);
      
      writeElement('JobTitle',c.Title, writer);
      
      if(phoneNumber.size() > 1)
        writeElement('Ext1', phoneNumber.get(1), writer);
      else
        writeElement('Ext1', '', writer);
        
      //testKirtesh
      //string phh =  'ph:'+phoneNumber.get(0)+'Ext'+ phoneNumber.get(1);
      //return phh ;
      
      writeElement('Salutation', c.Salutation, writer);
      writeElement('ResultParent','', writer);
      writeElement('ResultID','', writer);
      
      writer.writeEndElement();//ending goldmineImporter tag
      
      Http h = new Http();
      
      Httprequest request = new Httprequest();
      request.setMethod('POST');
      request.setHeader('Content-Type', 'text/xml');
      request.setTimeout(60000); // timeout in milliseconds
      
      //For Soap Request*****
          //request.setHeader('SOAPAction', '\'\'');
          //String body='<se:Envelope xmlns:se="http://schemas.xmlsoap.org/soap/envelope/"><se:Header xmlns:sfns="http://soap.sforce.com/schemas/class/TestWebService"><sfns:SessionHeader><sessionId>'+ UserInfo.getSessionId()+ '</sessionId></sfns:SessionHeader></se:Header><se:Body><testWebMethod xmlns="http://soap.sforce.com/schemas/class/TestWebService"><xml>goldmineImporter</xml>  </testWebMethod></se:Body></se:Envelope>';
          //request.setHeader('Content-Length', body.length().format());
          //request.setBody(body);
          //request.setEndpoint('https://cs3-api.salesforce.com/services/Soap/class/TestWebService');
          
     // String body='xml=testHTTPLeadBody';
     // request.setBody(body);
     // request.setEndpoint('https://cs3.salesforce.com/visualforce/session?url=https://c.cs3.visual.force.com/apex/uploadxml?xml=testHTTPLead');

      
      //request.setBody('<goldmineImporter><Company>testcompany</Company><Contact>MKI Schultz</Contact><Address1>2066 Stratford Ave</Address1><Address2></Address2><Address3></Address3><City>South Pasadena</City><State>CA</State><Zip>91030</Zip><Country>USA</Country><Phone1>6267107191</Phone1><Phone2></Phone2><Phone3></Phone3><FAX></FAX><Email></Email><RepCode>101047</RepCode><BranchCode>101</BranchCode><WebSite></WebSite><JobTitle></JobTitle><Ext1></Ext1><Salutation></Salutation><ResultParent></ResultParent><ResultID></ResultID></goldmineImporter>');
      request.setBody(writer.getXMLString());
      
      request.setEndpoint(ResultEndpoint);
      
      //request.setEndpoint('http://208.35.40.104:9106/goldmine/GoldmineImporter');
      
      
      //String mks = request.getBody();
      //return mks;
            
      //Send the request, and return a response
      System.debug('Parth********I SendXMLToResult ');
      
      //return request.getBody();
      
      system.debug('$$$$$$$$$$$$ request.getBody = ' + request.getBody());
      
      Httpresponse res = h.send(request);
      //return res.getBody();
      XMLResult result = new XMLResult();
      
      if((res.getBody() == null) || (res.getBody() == '')){
        return '(Endpoint - ' + ResultEndpoint + ')\n\nError: Blank response from Result\n\n' + 'Message Sent to Result:\n\n' + request.getBody() + '\n\nResponse Received from Result:\n\n' + res.getBody();
        //return 'Blank response from Result.';
      }
      if(res.getBody().contains('<html>')){
        return '(Endpoint - ' + ResultEndpoint + ')\n\nError: ' + result.errorCode + result.errorMsg + '\n\n' + 'Message Sent to Result:\n\n' + request.getBody() + '\n\nResponse Received from Result:\n\n' + res.getBody();
      }
              
      Boolean validXML = readXML(res.getBody(), result);
      if(!validXML)
        //return 'Received invalid response from Result.';
        return '(Endpoint - ' + ResultEndpoint + ')\n\nError: ' + result.errorCode + result.errorMsg + '\n\n' + 'Message Sent to Result:\n\n' + request.getBody() + '\n\nResponse Received from Result:\n\n' + res.getBody();
        
        
      if(result.success.equalsIgnoreCase('true')) {
        accounts.get(0).Result_Id__c = result.resultId;
        update accounts.get(0);
        return 'Information sent to Result successfully';
      }
      else {
        return '(Endpoint - ' + ResultEndpoint + ')\n\nError: ' + result.errorCode + result.errorMsg + '\n\n' + 'Message Sent to Result:\n\n' + request.getBody() + '\n\nResponse Received from Result:\n\n' + res.getBody();
      }
      
      
    }
    catch(Exception e) {
        return 'Exception: ' + e.getMessage();
    }
    
  }
  
  
  
  public static void writeElement(String elementName, String elementValue, Xmlstreamwriter writer) {
   writer.writeStartElement(null, elementName, null);
     if(elementValue != null)
       writer.writeCharacters(elementValue);
     else
       writer.writeCharacters('');
   writer.writeEndElement(); //end of tag
  }
  
  private static List<String> splitAddress(String streetAddress) {
    List<String> addresses;
    if(streetAddress != null && streetAddress != '') {
      addresses = streetAddress.split('\n'); 
      
    }
    else {
      addresses = new List<String>();
      addresses.add(streetAddress);
    }
    
    // We need to strip out the \n after we split the string.  This is causing an error in Result
    for (integer i=0;i<addresses.size();i++){
    
        addresses[i] = addresses[i].replaceAll('\n', '');
        addresses[i] = addresses[i].trim();
    
    }
    
    return addresses;
  }
  
  /*
  private static List<String> splitPhoneNumber(String phone) {
    phone = phone.trim();
    phone = phone.replaceAll(' ', '');
    List<String> phoneNumber = new List<String>();
    if(phone.length() > 10) {
      phoneNumber.add(phone.substring(0, 11));
      phoneNumber.add(phone.substring(11));
      
    }
    else {
      phoneNumber.add(phone);
      phoneNumber.add('');
    }
    return phoneNumber;
  }
  */
  
  public static void splitPhone(String phone){
    System.debug('---Phone--'+splitPhoneNumber(phone));
  } 
  private static List<String> splitPhoneNumber(String phone) {
    
    
    phone = phone.trim();
    phone = phone.replaceAll(' ', '');
    
    List<string> phoneNumberwithExt = new List<String>() ;
    string numValue = '0123456789';
    string ph = '';
    string ext = '';
    string newPhoneNumberwithNumOnly = '';
    
    for(integer i=0 ; i < phone.length(); i++){
       
        String str = phone.subString(i,i+1);
        if(numValue.indexOf(str)>=0){
          newPhoneNumberwithNumOnly+= phone.subString(i,i+1);
        }
        
    }
   
    if(newPhoneNumberwithNumOnly.subString(0,1) == '1'){
      newPhoneNumberwithNumOnly = newPhoneNumberwithNumOnly.substring(1);
    }
    
    if(newPhoneNumberwithNumOnly.length()>10){
        ext = newPhoneNumberwithNumOnly.subString(10);
        newPhoneNumberwithNumOnly =  newPhoneNumberwithNumOnly.subString(0,10);
    }
    
    phoneNumberwithExt.add(newPhoneNumberwithNumOnly);
    phoneNumberwithExt.add(ext);
    
    return phoneNumberwithExt ;
  }
  
  
  public static boolean readXML(String xml, XMLResult res) {
    Xmlstreamreader reader = new Xmlstreamreader(xml);
    
    Boolean validResultXML = false;
    
    while(reader.hasNext()) {
      if (reader.getEventType() == XmlTag.START_ELEMENT){
        string localName=reader.getLocalName();
        if(localName.equalsIgnoreCase('result')) {
            //return false;
            validResultXML = true;
        }
        if(localName.equalsIgnoreCase('success')) {
          res.success = getText(reader);
        }
        if(localName.equalsIgnoreCase('errorcode')) {
          res.errorCode = getText(reader);
        }
        if(localName.equalsIgnoreCase('ErrorMessage')) {
          res.errorMsg = getText(reader);
        }
        if(localName.equalsIgnoreCase('ResultID')) {
          res.resultId = getText(reader);
        }
        
      }//If ends
      reader.next();
    }//Result object is filled.
    return validResultXML;
  }
  
  public class XMLResult {
    String success;
    String errorCode;
    String errorMsg;
    String resultId;
  }
  
  public static String getText(XmlStreamReader reader)
    {
        String res1='';
        while(reader.hasNext())
        {
            if (reader.getEventType() == XmlTag.END_ELEMENT)
                break;
            else
              if(reader.getEventType() == XmlTag.CHARACTERS)
                res1 = reader.getText();
                reader.next();
        }
        return res1;
    }
    
    // We recently discovered that Result requires the Billing Country to be in a certain format
    // So we dont disturb the users, we will handle these exceptions on the back end
    Public Static String translateCountry(String billingCountry){
        if ((billingCountry == 'UK') || (billingCountry == 'United Kingdom') || (billingCountry == 'Great Britain') || (billingCountry == 'England') || (billingCountry == 'Eng')){
            return 'GB';
        }
        else if ((billingCountry == 'US') || (billingCountry == 'United States') || (billingCountry == 'United States of America')){
            return 'USA';
        }   
        else if ((billingCountry == 'CA') || (billingCountry == 'Canada')){
            return 'CAN';
        }       
        else{
            return billingCountry;
        }
        
    }    

    // We recently discovered that Result requires the US State to be a 2 letter abbr
    // So we dont disturb the users, we will handle these exceptions on the back end
    Public Static String stateAbrieviation(String billingState){
    
        Map<String, String> stateMap = New Map<String, String>();
        String stateAbr = '';
        
        stateMap.put('Alabama', 'AL');
        stateMap.put('Alaska', 'AK');
        stateMap.put('Arizona', 'AZ');
        stateMap.put('Arkansas', 'AR');
        stateMap.put('California', 'CA');
        stateMap.put('Colorado', 'CO');
        stateMap.put('Connecticut', 'CT');
        stateMap.put('Delaware', 'DE');
        stateMap.put('Florida', 'FL');
        stateMap.put('Georgia', 'GA');
        stateMap.put('Hawaii', 'HI');
        stateMap.put('Idaho', 'ID');
        stateMap.put('Illinois', 'IL');
        stateMap.put('Indiana', 'IN');
        stateMap.put('Iowa', 'IA');
        stateMap.put('Kansas', 'KS');
        stateMap.put('Kentucky', 'KY');
        stateMap.put('Louisiana', 'LA');
        stateMap.put('Maine', 'ME');
        stateMap.put('Maryland', 'MD');
        stateMap.put('Massachusetts', 'MA');
        stateMap.put('Michigan', 'MI');
        stateMap.put('Minnesota', 'MN');
        stateMap.put('Mississippi', 'MS');
        stateMap.put('Missouri', 'MO');
        stateMap.put('Montana', 'MT');
        stateMap.put('Nebraska', 'NE');
        stateMap.put('Nevada', 'NV');
        stateMap.put('New Hampshire', 'NH');
        stateMap.put('New Jersey', 'NJ');
        stateMap.put('New Mexico', 'NM');
        stateMap.put('New York', 'NY');
        stateMap.put('North Carolina', 'NC');
        stateMap.put('North Dakota', 'ND');
        stateMap.put('Ohio', 'OH');
        stateMap.put('Oklahoma', 'OK');
        stateMap.put('Oregon', 'OR');
        stateMap.put('Pennsylvania', 'PA');
        stateMap.put('Rhode Island', 'RI');
        stateMap.put('South Carolina', 'SC');
        stateMap.put('South Dakota', 'SD');
        stateMap.put('Tennessee', 'TN');
        stateMap.put('Texas', 'TX');
        stateMap.put('Utah', 'UT');
        stateMap.put('Vermont', 'VT');
        stateMap.put('Virginia', 'VA');
        stateMap.put('Washington', 'WA');
        stateMap.put('West Virginia', 'WV');
        stateMap.put('Wisconsin', 'WI');
        stateMap.put('Wyoming', 'WY');
        
        stateAbr = stateMap.get(billingState);
        
        if ((stateAbr == NULL) || (stateAbr == '')){
            return billingState;
        } 
        else{
            return stateAbr;
        }
        
         
    
    }
    public static String generateNumericPhone(Account account){
        String numericPhone  = '';
        if(account.NumericPhone__c != null){
           numericPhone =  account.NumericPhone__c;
        }else{
           numericPhone = Utils.processNumericPhone(account.Phone);
        }
        return numericPhone;
    }
}