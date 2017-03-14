/********************************************************************************************
Name           : MapInboundData
Usage          : 
Created By     : Aashish Mathur
Created Date   : May 26, 2009

Modified By 	 : Alka Taneja
Case 					 : 00050530
Modified Date  : 22 July, 2013
********************************************************************************************/

global class MapInboundData {
    private  XmlStreamReader xmlStrReader;
    private List<LeadClass> leadList;
    public List<LeadClass> getLeadList()
    {
        return leadList;
    }
    private  LeadClass lead;
    
    private static final System.XmlTag START_ELEMENT = XmlTag.START_ELEMENT;
    private static final System.XmlTag END_ELEMENT = XmlTag.END_ELEMENT;
    private static final System.XmlTag CHARACTERS = XmlTag.CHARACTERS;
    
    public List<LeadClass> mapInboundXmlData(String xmlData) {
    	
        xmlStrReader = new XmlStreamReader(xmlData);
       
        // Added for Case: 00050530, Alka Taneja
        xmlStrReader.setCoalescing(true);
        
        leadList = new List<LeadClass>();
        
        while (xmlStrReader.hasNext()) {
            if (xmlStrReader.getLocalName() == 'quoteList'
                    && xmlStrReader.getEventType() == START_ELEMENT) {
                processQuoteList();
            }
            
            xmlStrReader.next();
        }
        
        return  leadList;
    }
    
    // Added for Case: 00050530, Alka Taneja
    public static String handleSpecialChar(String xmlString) {
    	
    	// Handle CDATA tag 
    	xmlString = xmlString.replace('<![CDATA[','');
    	xmlString = xmlString.replace(']]', '');
    	
      return xmlString;
    }
    
    
    // WSDL and handler for leads (360 Partners)
    webservice static String mapInboundXmlData360Partners(String xmlData) {
        try {
            Map<String, LeadCategoryFrom360__c> leadCategoryIdDescription = LeadCategoryFrom360__c.getAll();
            
           	xmlData = handleSpecialChar(xmlData);
            
            MapInboundData mapInboundData = new MapInboundData();
            List<LeadClass> leadList = mapInboundData.mapInboundXmlData(xmlData);
            LeadClass newLeadClass = leadList[0];
            
            Lead newLead = new Lead();
            newLead.Lead_ID__c = newLeadClass.quoteId;
            newLead.Product_Interest__c = newLeadClass.categoryId;
            if(leadCategoryIdDescription.ContainsKey(newLeadClass.leadCategoryId)){
                newLead.Lead_Category__c = leadCategoryIdDescription.get(newLeadClass.leadCategoryId).Description__c;
            }
            
            // new changes by TEK team..
            newLead.I_want_to__c = newLeadClass.IwantTo != null ?  newLeadClass.IwantTo : null;        
            newLead.How_long_will_you_need_your_unit__c =  newLeadClass.HowLongUnitNeeded != null ? newLeadClass.HowLongUnitNeeded : null;  
            
            newLead.Company = newLeadClass.quoter.businessInfo[0];
            newLead.Title = newLeadClass.quoter.businessInfo[1];
            newLead.Number_of_Employees__c = newLeadClass.quoter.businessInfo[3];
            newLead.Industry = newLeadClass.quoter.businessInfo[2];
            newLead.LastName = newLeadClass.quoter.personalInfo[0];
            newLead.FirstName = newLeadClass.quoter.personalInfo[1];
            newLead.Phone = newLeadClass.quoter.contInfo.addr.phone[1];
            newLead.Email = newLeadClass.quoter.contInfo.email;
            newLead.Street = newLeadClass.quoter.contInfo.addr.street;
            newLead.Street += '\n' + newLeadClass.quoter.contInfo.addr.street2;
            newLead.City = newLeadClass.quoter.contInfo.addr.city;
            newLead.PostalCode = newLeadClass.quoter.contInfo.addr.zip;
            newLead.State = newLeadClass.quoter.contInfo.addr.state[1];
            newLead.Fax = newLeadClass.quoter.contInfo.addr.phone[2];
            newLead.LeadSource = '360 Mobile Office';
            newLead.Rating = 'Hot (Probably Order)';
            newLead.On_The_Go__c = newleadClass.onTheGo != null ? Boolean.valueOf(newleadClass.onTheGo) : null;
            newLead.Auto_Assign_Lead__c = true;

            // Case: 00050530, Alka Taneja
            newLead.Delivery_Postal_Code__c = newLeadClass.quoter.businessInfo[4];      
          
           // Commented for Case: 00050530, Alka Taneja  
            /* if (newLeadClass.quesWithAnsList.size() > 0) {
               newLead.Description = 'Q: ' + newLeadClass.quesWithAnsList[0].question;
               newLead.Description += '\nA: ' + newLeadClass.quesWithAnsList[0].answer;
            }
            
            for (Integer index = 1; index < newLeadClass.quesWithAnsList.size(); index++) {
                if (newLeadClass.quesWithAnsList[index].question != ''
                       || newLeadClass.quesWithAnsList[index].answer != '') {
                   newLead.Description += '\n\nQ: ' + newLeadClass.quesWithAnsList[index].question;
                   newLead.Description += '\nA: ' + newLeadClass.quesWithAnsList[index].answer;
                }
            }
             // added for T - 5419 and get text in requestDetails
            if(newLeadClass.requestDetails != null && newLeadClass.requestDetails.length() >0){
                newLead.Description += '\n\nNotes: '+newLeadClass.requestDetails;
            }   */
            
            // Case: 00050530, Alka Taneja #START
            String desTemp = '';
            
            if (newLeadClass.quesWithAnsList.size() > 0) {
               desTemp = 'Q: ' + newLeadClass.quesWithAnsList[0].question;
               desTemp += '\nA: ' + newLeadClass.quesWithAnsList[0].answer;
            }
            
            for (Integer index = 1; index < newLeadClass.quesWithAnsList.size(); index++) {
                if (newLeadClass.quesWithAnsList[index].question != ''
                       || newLeadClass.quesWithAnsList[index].answer != '') {
                   desTemp += '\n\nQ: ' + newLeadClass.quesWithAnsList[index].question;
                   desTemp += '\nA: ' + newLeadClass.quesWithAnsList[index].answer;
                }
            }
             // added for T - 5419 and get text in requestDetails
            if(newLeadClass.requestDetails != null && newLeadClass.requestDetails.length() >0){
                desTemp += '\n\nNotes: '+newLeadClass.requestDetails;
            }  
            
            newLead.Description = desTemp;
            // Case: 00050530, Alka Taneja #END
                    
            insert newLead;
            system.debug('========new lead=========='+newLead.id);
            system.debug('======lead category======'+newLead.Lead_Category__c);
            return 'Lead created successfully with Id: ' + newLead.id;
        } catch (Exception ex) {
            return ex.getMessage();
        }
    }
    
    private  String getText() {
        String text = '';
        System.XmlTag eventType;
        
        while (xmlStrReader.hasNext()) {
            eventType = xmlStrReader.getEventType();
            if (eventType == END_ELEMENT)
                break;
            
            else if (eventType == CHARACTERS) {
            	// Case: 00050530, Alka Taneja #START
            	// Handle special charachter
            	if(xmlStrReader.getText() != null)
            		text = xmlStrReader.getText().replaceAll('&amp;', '&').replaceAll('&apos;', '\'');            	        			
        			
        			// Case: 00050530, Alka Taneja #END
            }
            
            xmlStrReader.next();
        }
        
        return text;
    }
    
    private  void processQuoteList() {
        String localName;
        System.XmlTag eventType;
        
        while(xmlStrReader.hasNext()) {
            localName = xmlStrReader.getLocalName();
            eventType = xmlStrReader.getEventType();
            
            if (localName == 'quoteList' && eventType == END_ELEMENT)
                break;
            
            if (localName == 'quote' && eventType == START_ELEMENT)
                processQuote();
            
            xmlStrReader.next();
        }
    }
    
    private  void processQuote() {
        String localName;
        System.XmlTag eventType;
        lead = new LeadClass();
        
        while(xmlStrReader.hasNext()) {
            localName = xmlStrReader.getLocalName();
            eventType = xmlStrReader.getEventType();
            
            if (localName == 'quote' && eventType == END_ELEMENT)
                break;
            
            if (localName == 'quoteId' && eventType == START_ELEMENT)
                lead.quoteId = getText();
            
            if (localName == 'categoryName' && eventType == START_ELEMENT)
                lead.categoryName = getText();
            
            if (localName == 'categoryId' && eventType == START_ELEMENT)
                lead.categoryId = getText();
                
            if (localName == 'Lead_Category__c' && eventType == START_ELEMENT)
            	lead.leadCategoryId = getText();     
            
            if (localName == 'On_The_Go__c' && eventType == START_ELEMENT)
                lead.onTheGo = getText();   
                
            if (localName == 'I_want_to__c' && eventType == START_ELEMENT)                                  // new changes by Tek team..
                lead.IwantTo = getText();
                
            if (localName == 'How_long_will_you_need_your_unit__c' && eventType == START_ELEMENT)          // new changes by Tek team..
                lead.HowLongUnitNeeded = getText();    
                    	
            
            if (localName == 'quoter' && eventType == START_ELEMENT)
                processQuoter();
            
            if (localName == 'requestDetails' && eventType == START_ELEMENT)
                
                processRequestDetails();               

            xmlStrReader.next();
        }
        
        leadList.add(lead);
        System.debug('PArth***'+lead.quoteId);
    }
    
    private  void processQuoter() {
        String localName;
        System.XmlTag eventType;
        
        while(xmlStrReader.hasNext()) {
            localName = xmlStrReader.getLocalName();
            eventType = xmlStrReader.getEventType();
            
            if (localName == 'quoter' && eventType == END_ELEMENT)
                break;
            
            if (localName == 'contactInfo' && eventType == START_ELEMENT)
                processContactInfo();
            
            if (localName == 'personalInfo' && eventType == START_ELEMENT)
                processPersonalInfo();
            
            if (localName == 'businessInfo' && eventType == START_ELEMENT)
                processBusinessInfo();
            
            xmlStrReader.next();
        }
    }
    
    private  void processContactInfo() {
        String localName;
        System.XmlTag eventType;
        
        while(xmlStrReader.hasNext()) {
            localName = xmlStrReader.getLocalName();
            eventType = xmlStrReader.getEventType();
            
            if (localName == 'contactInfo' && eventType == END_ELEMENT)
                break;
            
            if (localName == 'address' && eventType == START_ELEMENT)
                processAddress();
            
            if (localName == 'phoneFreeText' && eventType == START_ELEMENT)
                lead.quoter.contInfo.addr.phone[0] = getText();
            
            if (localName == 'numericPhone' && eventType == START_ELEMENT)
                lead.quoter.contInfo.addr.phone[1] = getText();
            
            if (localName == 'fax' && eventType == START_ELEMENT)
                lead.quoter.contInfo.addr.phone[2] = getText();
            
            if (localName == 'emailAddress' && eventType == START_ELEMENT)
                lead.quoter.contInfo.email = getText();
            
            xmlStrReader.next();
        }
    }
    
    private  void processAddress() {
        String localName;
        System.XmlTag eventType;
        
        while(xmlStrReader.hasNext()) {
            localName = xmlStrReader.getLocalName();
            eventType = xmlStrReader.getEventType();
            
            if (localName == 'address' && eventType == END_ELEMENT)
                break;
            
            if (localName == 'street' && eventType == START_ELEMENT)
                lead.quoter.contInfo.addr.street = getText();
            
            if (localName == 'street2' && eventType == START_ELEMENT)
                lead.quoter.contInfo.addr.street2 = getText();
            
            if (localName == 'city' && eventType == START_ELEMENT)
                lead.quoter.contInfo.addr.city = getText();
            
            if (localName == 'zip' && eventType == START_ELEMENT)
                lead.quoter.contInfo.addr.zip = getText();
            
            if (localName == 'stateName' && eventType == START_ELEMENT)
                lead.quoter.contInfo.addr.state[0] = getText();
            
            if (localName == 'stateAbbreviation' && eventType == START_ELEMENT)
                lead.quoter.contInfo.addr.state[1] = getText();
            
            xmlStrReader.next();
        }
    }
    
    private  void processPersonalInfo() {
        String localName;
        System.XmlTag eventType;
        
        while(xmlStrReader.hasNext()) {
            localName = xmlStrReader.getLocalName();
            eventType = xmlStrReader.getEventType();
            
            if (localName == 'personalInfo' && eventType == END_ELEMENT)
                break;
            
            if (localName == 'lastName' && eventType == START_ELEMENT)
                lead.quoter.personalInfo[0] = getText();
            
            if (localName == 'firstName' && eventType == START_ELEMENT)
               lead.quoter.personalInfo[1] = getText();
            
            if (localName == 'fullName' && eventType == START_ELEMENT)
                lead.quoter.personalInfo[2] = getText();
            
            xmlStrReader.next();
        }
    }
    
    private  void processBusinessInfo() {
        String localName;
        System.XmlTag eventType;
        
        while(xmlStrReader.hasNext()) {
            localName = xmlStrReader.getLocalName();
            eventType = xmlStrReader.getEventType();
            
            if (localName == 'businessInfo' && eventType == END_ELEMENT)
                break;
            if (localName != null && localName.equalsIgnoreCase('companyName') && eventType == START_ELEMENT)
                lead.quoter.businessInfo[0] = getText();
            
            if (localName == 'title' && eventType == START_ELEMENT)
               lead.quoter.businessInfo[1] = getText();
            
            if (localName == 'industry' && eventType == START_ELEMENT)
                lead.quoter.businessInfo[2] = getText();
            
            if (localName == 'companySize' && eventType == START_ELEMENT)
                lead.quoter.businessInfo[3] = getText();
            
            // Case: 00050530, Alka Taneja
            if (localName == 'Delivery_Postal_Code__c' && eventType == START_ELEMENT)
                lead.quoter.businessInfo[4] = getText();
            
            xmlStrReader.next();
        }
    }
    
    private  void processRequestDetails() {
        String localName;
        System.XmlTag eventType;
        
        while(xmlStrReader.hasNext()) {
            localName = xmlStrReader.getLocalName();
            eventType = xmlStrReader.getEventType();
            
            if (localName == 'requestDetails' && eventType == END_ELEMENT)
                break;
            
            if (localName == 'questionWithAnswers' && eventType == START_ELEMENT)
                processQuestionWithAnswers();
            // added for T - 5419 and get text in requestDetails
            if (eventType == CHARACTERS)
                lead.requestDetails = xmlStrReader.getText();
            xmlStrReader.next();
        }
    }
    
    private  void processQuestionWithAnswers() {
        String localName;
        System.XmlTag eventType;
        QuestionWithAnswers quesWithAns = new QuestionWithAnswers();
        
        while(xmlStrReader.hasNext()) {
            localName = xmlStrReader.getLocalName();
            eventType = xmlStrReader.getEventType();
            
            if (localName == 'questionWithAnswers' && eventType == END_ELEMENT)            
                break;
            
            if (localName == 'question' && eventType == START_ELEMENT)
                quesWithAns.question = getText();
            
            if (localName == 'answer' && eventType == START_ELEMENT)
                quesWithAns.answer = getText();
            
            if (localName == 'priorityLevel' && eventType == START_ELEMENT)
                quesWithAns.priorityLevel = getText();
            
            xmlStrReader.next();
        }
        
        lead.quesWithAnsList.add(quesWithAns);

    }
    
    public class LeadClass {
        public String quoteId;
        public String categoryName;
        public String categoryId;
        public String leadCategoryId;
        public String onTheGo;
        public String IwantTo;                 // new changes by Tek System
        public String HowLongUnitNeeded;      // new changes by Tek System    
        public Quoter quoter = new Quoter();
        public String requestDetails; // added for T - 5419 and get text in requestDetails
        public List<QuestionWithAnswers> quesWithAnsList = new List<QuestionWithAnswers>();
    }
    
    public class Quoter {
        public ContactInfo contInfo = new ContactInfo();
        public String[] personalInfo = new String[3];
        public String[] businessInfo = new String[5]; // increased the array size from 4 to 5 for the Case: 00050530, Alka Taneja
    }
    
    public class QuestionWithAnswers {
        public String question;
        public String answer;
        public String priorityLevel;
    }
    
    public class ContactInfo {
        public String email;
        public Address addr = new Address();
    }
    
    public class Address {
        public String street;
        public String street2;
        public String city;
        public String zip;
        public String[] state = new String[2];
        public String[] phone = new String[3];
    }
}