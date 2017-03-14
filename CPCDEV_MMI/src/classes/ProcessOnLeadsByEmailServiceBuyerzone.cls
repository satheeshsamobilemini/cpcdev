/*
Last Modified by Najma Ateeq to avoid  "List has no rows for assignment to SObject" error for #S-139090
*/
global class ProcessOnLeadsByEmailServiceBuyerzone implements Messaging.InboundEmailHandler {
  
  global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
  
    System.debug('EMAIL RECIEVED: '+email.subject);
    Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
    //Handling of Binary Attachments
    Messaging.InboundEmail.BinaryAttachment[] bAttachments = email.binaryAttachments;
    if( bAttachments != null ){     
      for( Messaging.InboundEmail.BinaryAttachment  binaryAttachment  : bAttachments ){   
           string wholeString =  binaryAttachment.body.tostring();  
           processAttachment( wholeString, email.subject );
      }
    }
    //Handling of Text Attachments
    Messaging.InboundEmail.TextAttachment[] tAttachments = email.textAttachments;
    if( tAttachments != null ){     
      for( Messaging.InboundEmail.TextAttachment  txtAttachment  : tAttachments ){   
          string wholeString = String.valueOf(txtAttachment.body);  
          processAttachment( wholeString, email.subject );
      }
    }
    
    return result;
  }
  
  public void processAttachment( string wholeString, string emailSubject ){

    List<String> lst = new List<String>() ;
    boolean isFirst = true ;
    
    if (emailSubject == null){
        emailSubject = 'Storage Containers';
    }
    
    Integer inString = -1;
    String leadType = '';

    // What type of lead is this?
    inString = emailSubject.indexOf('Storage Containers', 0);
    if (inString != -1){
        leadType = 'Storage Containers';
    }

    inString = emailSubject.indexOf('Residential Storage Containers', 0);
    if(inString != -1){
        leadType = 'Residential';
    } 

    inString = emailSubject.indexOf('Modular Buildings', 0);
    if(inString != -1){
        leadType = 'Modular Buildings';
    }
    
    inString = emailSubject.indexOf('Office Trailers', 0);
    if(inString != -1){
        leadType = 'Office Trailers';
    }


    
    
    // process csv body here 
    //START_WHILE
    while(WholeString.trim() != ''){   
      Integer j = WholeString.indexOf('\n');
      string currentLine;
      if(j == -1){   
         currentLine = WholeString;
         WholeString = '';
         isFirst = true ;
      }else{  
         currentLine = WholeString.substring(0,j);
         if(WholeString.length()>j+1)
           WholeString = WholeString.substring(j+1);
         else
           WholeString ='';
         
         if(isFirst == true){
             //string[] fieldArray = currentLine.split('","');
             currentLine  = '' ;
             isFirst = false ;
         }
      }
          
      if(currentLine.trim()!=''){
        lst.add(currentLine.trim());
      }
          
      if(lst.size()>=20){  
        //Create actual leads from this function
     
        
        if (leadType == 'Residential'){
            uploadResidential(lst);
        }
        else if (leadType == 'Storage Containers'){
            uploadLeadsContainers(lst);
        }
        else if (leadType == 'Modular Buildings'){
            uploadLeadsBuildings(lst);
        }
        else if (leadType == 'Office Trailers'){
            uploadLeadsOffices(lst);
        }
        
        lst = new List<String>();

      } 
    }
    //END_4 WHILE
    
    if(lst.size()>0){
      //Create actual leads from this function
      
        
        if (leadType == 'Residential'){
            uploadResidential(lst);
        }
        else if (leadType == 'Storage Containers'){
            uploadLeadsContainers(lst);
        }
        else if (leadType == 'Modular Buildings'){
            uploadLeadsBuildings(lst);
        }
        else if (leadType == 'Office Trailers'){
            uploadLeadsOffices(lst);
        }
        
        lst = new List<String>();

    }
  }
  
  // Insert Residential Leads
  @Future public static void uploadResidential(List <String> leadList){
  
      /*
    
        // Residential Lead 
        
        0 RFQ Number
        1 RFQ Date
        2 Name
        3 Street
        4 City
        5 State
        6 Zip
        7 Phone
        8 Alternate Phone
        9 Email
        10 Residential or Commercial:
        11 Usage:
        12 Number needed:
        13 Length storage container:
        14 Financing method:
        15 Timeframe:
        16 ZIPCode
        17 If moving, destination ZIP code:
        18 Email address:  --> THIS FIELD IS NOT MAPPED ANYWHERE AS OF NOW SINCE IT LOOKS DUPLICATE OF Email (9)
    19 Additional requirements:
    
    
    */

    List<Lead> listLead = new List<Lead>();

    Boolean insideQuotes = false;
    String currentChar = '';
    String fChar = ''; 
        
    for (String nextLead :leadList){
      //nextLead = nextLead.substring(0, nextLead.length() - 1);
      nextLead = nextLead.substring(0, nextLead.length());  
      
  
             
      // Split the string by TAB 
      string[] columnArray = nextLead.split(',');

      //
      

      
      //
     
      // Make sure we have more than 1 column -- should be 20?
      if (columnArray.size() == 1)
        continue;
      
      for( integer i = 0 ; i < columnArray.size() ; i++ ){
         if( columnArray[i].Startswith('"') && columnArray[i].endswith('"') ){
            columnArray[i] =  columnArray[i].replaceAll('"','') ;
         }
      }
      
      Lead objLead = new Lead();
       
      //Start Field Mapping from CSV Rows
      
      // Dealer
      // objLead.Buyerzone_Dealer__c = columnArray[0].trim();
      
      // Category
      // objLead.Buyerzone_Category__c = columnArray[1].trim();
      
      // 0 RFQ Number
      objLead.RFQ_Number__c = columnArray[0].trim();
      
      // 1 RFQ Date
      if(columnArray[1].trim() != ''){

        // We do not always receive a valid date
        fChar = columnArray[1].trim().subString(0,1);
        if ((fChar == '0') || (fChar == '1') || (fChar == '2') || (fChar == '3') || (fChar == '4') || (fChar == '5') || (fChar == '6') || (fChar == '7') || (fChar == '8') || (fChar == '9')){
        
            string dateString = columnArray[1];
            
            // In the production data feed Buyerzone is sending, this is now a date/time field
            // Here is an example of the format:  11/5/10 9:25 AM
            // Lets parse out the time
            
            Integer atPosition = dateString.indexOf(' ');
            if (atPosition > -1){
                dateString = dateString.subString(0, atPosition);
            }
            
            // Continue with parsing the date now
                        
            string[] dateArray =  dateString.split('/');
            string month = dateArray[0];
            string day = dateArray[1];
            string year = dateArray[2] ; 
            if (year.length() == 1)
                year = '200' + year;
            else if (year.length() == 2)
                year = '20' + year;
            
            string stringDate = year + '-' + month+ '-' + day ;
     
            objLead.RFQ_Date__c = Date.valueOf(stringDate);
        
        }
        
      }      
      
      // 2 Name
      String leadName = columnArray[2].trim();

      if(leadName.trim() != ''){
     
        String[] leadnameArray = leadName.split(' ', 2);
     
        if(leadnameArray.size()== 2){
            objLead.FirstName = leadnameArray[0] ; 
            objLead.LastName = leadnameArray[1];
        }else if(leadnameArray.size()== 1){
            objLead.LastName = leadnameArray[0];
        }
      }else{
        objLead.LastName = 'None' ;
      } 
      
      // 3 Street
      objLead.Street = columnArray[3].trim();
      
      // 4 City 
      objLead.City = columnArray[4].trim();
      
      // 5 State
      objLead.State = columnArray[5].trim();
      
      // 6 Zip 
      objLead.PostalCode = columnArray[6].trim();
      
      // 7 Phone
      objLead.Phone = columnArray[7].trim();
      
      // 8 Alternate Phone
      objLead.Description = '\nAlternate Phone: ' + columnArray[8].trim();
            
      // 9 Email
      objLead.Email = columnArray[9].trim();
      
      // 10 Residential or Commercial:
      objLead.Description += '\nResidential/Commercial: ' + columnArray[10].trim();
      
      // 11 Usage:
      objLead.Description += '\nUseage: ' + columnArray[11].trim();
      
      // 12 Number needed: 
      objLead.Description += '\nNumber needed: ' + columnArray[12].trim();
      
      // 13 Length storage container:
      objLead.Description += '\nLength storage container: ' + columnArray[13].trim();

      // 14 Financing method: 
      objLead.Description += '\nFinancing method:  ' + columnArray[14].trim();
      
      // 15 Timeframe: 
      objLead.Description += '\nTimeframe: ' + columnArray[15].trim();
      
      // 16 ZIP where container will be delivered:
      if (columnArray[16].trim() != ''){
          fChar = columnArray[16].trim().subString(0,1);
          if ((fChar == '0') || (fChar == '1') || (fChar == '2') || (fChar == '3') || (fChar == '4') || (fChar == '5') || (fChar == '6') || (fChar == '7') || (fChar == '8') || (fChar == '9')){
      
            objLead.Delivery_Postal_Code__c = columnArray[16].trim();
            
            if (objLead.Delivery_Postal_Code__c.length() < 5){
                objLead.Delivery_Postal_Code__c = objLead.PostalCode;
            }
                    
            objLead.Delivery_Country__c = 'USA';
      
          }
      }
            
      // 17 If moving, destination ZIP code: 
      if (columnArray.size() >= 18){
        if (columnArray[17].trim() != ''){
          fChar = columnArray[17].trim().subString(0,1);
          if ((fChar == '0') || (fChar == '1') || (fChar == '2') || (fChar == '3') || (fChar == '4') || (fChar == '5') || (fChar == '6') || (fChar == '7') || (fChar == '8') || (fChar == '9')){
    
            objLead.Description += '\nIf moving, destination ZIP code:' +  columnArray[17].trim();
      
          }
        }
      }
          
      // 19 Additional requirements: 
      // For some reason, all the trailing tabs are not always filled in.  Check to see of the array has enough indexes first 
      if (columnArray.size() == 20){
        objLead.Description += '\n\nAdditional Requirements:\n\n' +  columnArray[19].trim();
      }
      
      //End Field Mapping from CSV Rows
      
      // Find the RecordID for Buyerzone Leads
      List<RecordType> bbRecordTypeId = new List<RecordType>([Select r.Id from RecordType r where r.name = 'Buyerzone Lead']);//Added list for S-139090 by Najma Ateeq
      if(bbRecordTypeId != null && bbRecordTypeId.size() >0)
      objLead.RecordTypeId = bbRecordTypeId.get(0).Id;
      
      // Determine Primary Contact Method
      objLead.Primary_Contact_Method__c = 'Phone';
      
      if (objLead.Fax != null){
        objLead.Primary_Contact_Method__c = 'Fax';
      }
      
      objLead.Rating = 'Hot (Probably Order)'; 
      objLead.Country = 'USA';
      objLead.LeadSource = 'Buyerzone' ;
      objLead.Auto_Assign_Lead__c = true ;
      
      listLead.add(objLead);
    }
    
    try{
        Database.SaveResult[] MySaveResult = Database.insert(listLead, false);
    } 
    
    catch(Exception ex){
        System.debug('Ex'+ex);
    }
    
    for(integer i = 0 ; i < listLead.size() ; i++ ){
    }  
  
  }  
  
  //Insert Leads..
  @Future public static void uploadLeadsContainers(List<String> leadList){
  
    /*

        0  RFQ Number
        1  RFQ Date
        2  Name
        3  Title
        4  Company
        5  Company Size
        6  Industry Type
        7  Street
        8  City
        9  State
        10 Zip
        11 Phone
        12 Email
        13 Residential/Commercial:
        14 Industry used in:
        15 Number of containers needed:
        16 Customized features desired:     
        17 Desired length of container:
        18 Desired width of container:
        19 Door type preferred for container:
        20 Surface container will be placed on:
        21 Preferred finance method:
        22 Buying timeframe:
        23 ZIPCode
        24 Email address  --> THIS FIELD IS NOT MAPPED ANYWHERE AS OF NOW SINCE IT LOOKS DUPLICATE OF Email (12)
        25 Additional requirements:     
    
    */
      
    List<Lead> listLead = new List<Lead>();

    Boolean insideQuotes = false;
    String currentChar = '';
    String fChar = ''; 
        
    for (String nextLead :leadList){
      nextLead = nextLead.substring(0, nextLead.length() - 1);
      
      
      
      insideQuotes = false;
      
      // Go trough each line char by char -- if a comma is between two double quotes, replace it with a semicolon
      if (nextLead.Contains('"')){
          for (integer i=0;i<nextLead.length() - 1;i++){
            currentChar = nextLead.subString(i, i+1);
            
            if (currentChar.Contains('"')){

                if (insideQuotes == false){
                    insideQuotes = true;
                }
                else{
                    insideQuotes = false;
                }

            }
            
            if ((currentChar.contains(',')) && (insideQuotes == true)){
                nextLead = nextLead.subString(0, i) + ';' + nextLead.subString(i+1);
            }
                  
          }

      }
      
       
      // Split the string by TAB 
      string[] columnArray = nextLead.split(',');
     
      // Make sure we have more than 1 column -- should be 25?
      if (columnArray.size() == 1)
        continue;
      
      for( integer i = 0 ; i < columnArray.size() ; i++ ){
         if( columnArray[i].Startswith('"') && columnArray[i].endswith('"') ){
            columnArray[i] =  columnArray[i].replaceAll('"','') ;
         }
   
      }
      
      Lead objLead = new Lead();
      
      //Start Field Mapping from CSV Rows

      // Dealer
      // objLead.Buyerzone_Dealer__c = columnArray[0].trim();
      
      // Category
      // objLead.Buyerzone_Category__c = columnArray[1].trim();
      
      // 0  RFQ Number
      objLead.RFQ_Number__c = columnArray[0].trim();
      
      // 1  RFQ Date
      if(columnArray[1].trim() != ''){

        // We do not always receive a valid date
        fChar = columnArray[1].trim().subString(0,1);
        if ((fChar == '0') || (fChar == '1') || (fChar == '2') || (fChar == '3') || (fChar == '4') || (fChar == '5') || (fChar == '6') || (fChar == '7') || (fChar == '8') || (fChar == '9')){
        
            string dateString = columnArray[1];
            
            // In the production data feed Buyerzone is sending, this is now a date/time field
            // Here is an example of the format:  11/5/10 9:25 AM
            // Lets parse out the time
            
            Integer atPosition = dateString.indexOf(' ');
            if (atPosition > -1){
                dateString = dateString.subString(0, atPosition);
            }
            
            // Continue with parsing the date now
                        
            string[] dateArray =  dateString.split('/');
            string month = dateArray[0];
            string day = dateArray[1];
            string year = dateArray[2] ; 
            if (year.length() == 1)
                year = '200' + year;
            else if (year.length() == 2)
                year = '20' + year;
            
            string stringDate = year + '-' + month+ '-' + day ;
   
            objLead.RFQ_Date__c = Date.valueOf(stringDate);
        
        }
        
      }      
      
      // 2  Name
      String leadName = columnArray[2].trim();

      if(leadName.trim() != ''){
     
        String[] leadnameArray = leadName.split(' ', 2);
     
        if(leadnameArray.size()== 2){
            objLead.FirstName = leadnameArray[0] ; 
            objLead.LastName = leadnameArray[1];
        }else if(leadnameArray.size()== 1){
            objLead.LastName = leadnameArray[0];
        }
      }else{
        objLead.LastName = 'None' ;
      } 
      
      // 3  Title
      objLead.Title = columnArray[3].trim();
      
      // 4  Company
      objLead.Company = columnArray[4].trim();
      
      // 5  Company Size
      // Ignore
      
      // 6  Industry Type
      objLead.Description = 'Industry: ' + columnArray[6].trim();
      
      // 7  Street
      objLead.Street = columnArray[7].trim();
      
      // 8  City
      objLead.City = columnArray[8].trim();
      
      // 9  State
      objLead.State = columnArray[9].trim();
      
      // 10 Zip
      objLead.PostalCode = columnArray[10].trim();
      
      // 11 Phone
      objLead.Phone = columnArray[11].trim();
      
      // 12 Email
      //Fix related to PR-05631
      objLead.Email = columnArray[12].trim();
      //objLead.Email = columnArray[14].trim();
      
      
      // 13 Residential/Commercial:
      objLead.Description = '\nResidential/Commercial: ' + columnArray[13].trim();
      
      // 14 Industry used in:
      objLead.Description += '\nIndustry used in: ' + columnArray[14].trim();
      
      // 15 Number of containers needed:
      objLead.Description += '\nNumber of containers needed: ' + columnArray[15].trim();
      
      // 16 Customized features desired:           
      // For some reason, all the trailing tabs are not always filled in.  Check to see of the array has enough indexes first      
      if (columnArray.size() >= 17) {
        objLead.Description += '\nCustomized features desired: ' + columnArray[16].trim().replace(';',',');
      }
      
      // 17 Desired length of container:
      objLead.Description += '\nDesired length of container: ' + columnArray[17].trim();
      
      // 18 Desired width of container:
      objLead.Description += '\nDesired width of container: ' + columnArray[18].trim();
      
      // 19 Door type preferred for container:
      objLead.Description += '\nDoor type preferred for container: ' + columnArray[19].trim();
      
      // 20 Surface container will be placed on:
      objLead.Description += '\nSurface container will be placed on: ' + columnArray[20].trim();
      
      // 21 Preferred finance method:
      objLead.Description += '\n\nPreferred finance method: ' + columnArray[21].trim();
      
      // 22 Buying timeframe:
      objLead.Description += '\n\nBuying timeframe: ' + columnArray[22].trim();
      
      // 23 ZIP where container will be delivered:
      if (columnArray.size() >= 24){
        if (columnArray[23].trim() != ''){
          fChar = columnArray[23].trim().subString(0,1);
          if ((fChar == '0') || (fChar == '1') || (fChar == '2') || (fChar == '3') || (fChar == '4') || (fChar == '5') || (fChar == '6') || (fChar == '7') || (fChar == '8') || (fChar == '9')){
      
            objLead.Delivery_Postal_Code__c = columnArray[23].trim();
            
            if (objLead.Delivery_Postal_Code__c.length() < 5){
                objLead.Delivery_Postal_Code__c = objLead.PostalCode;
            }
                    
            objLead.Delivery_Country__c = 'USA';
      
         }
       }
      }


      // 25 Additional requirements: 
      // For some reason, all the trailing tabs are not always filled in.  Check to see of the array has enough indexes first 
      if (columnArray.size() >= 26){
        objLead.Description += '\n\nAdditional Requirements:\n\n' +  columnArray[25].trim();
      }
      
      //End Field Mapping from CSV Rows
      
      // Find the RecordID for Buyerzone Leads
      List<RecordType> bbRecordTypeId = new List<RecordType>([Select r.Id from RecordType r where r.name = 'Buyerzone Lead']);//Added by Najma
      if(bbRecordTypeId  != null && bbRecordTypeId.size() >0)
      objLead.RecordTypeId = bbRecordTypeId.get(0).Id;
      
      // Determine Primary Contact Method
      objLead.Primary_Contact_Method__c = 'Phone';
      
      if (objLead.Fax != null){
        objLead.Primary_Contact_Method__c = 'Fax';
      }
      
      objLead.Rating = 'Hot (Probably Order)'; 
      objLead.Country = 'USA';
      objLead.LeadSource = 'Buyerzone' ;
      objLead.Auto_Assign_Lead__c = true ;
      
      listLead.add(objLead);
    }
    
  try{
      Database.SaveResult[] MySaveResult = Database.insert(listLead, false);
 
      
  } catch(Exception ex){

  }
    

    
  }

  //Insert Leads..
  @Future public static void uploadLeadsBuildings(List<String> leadList){
    /*
    
        0  RFQ Number
        1  RFQ Date
        2  Name
        3  Title
        4  Company
        5  Company Size
        6  Industry Type
        7  Street
        8  City
        9  State
        10 Zip
        11 Phone
        12 Email
        13 Office trailer or mobile office:
    14 Square footage requirements for building:
    15 Primary use of your building:
        16 Single or multi-story building desired:
        17 Style of contruction desired:
        18 Preferred finance method:
        19 Timeframe building is needed for:
        20 Number of half baths needed (if applicable):     
        21 Number of ADA restrooms (if applicable):      
        22 Number of private offices (if applicable):
        23 Number of conference rooms/classrooms (if applicable):
        24 Delivery timeframe:
        25 Zip Code
        26 Email Address
    27 Additional requirements:
    
    */
  
    List<Lead> listLead = new List<Lead>();

    Boolean insideQuotes = false;
    String currentChar = '';
    String fChar = ''; 
        
    for (String nextLead :leadList){
      nextLead = nextLead.substring(0, nextLead.length() - 1);
      
      
      
      insideQuotes = false;
      
      // Go trough each line char by char -- if a comma is between two double quotes, replace it with a semicolon
      if (nextLead.Contains('"')){
          for (integer i=0;i<nextLead.length() - 1;i++){
            currentChar = nextLead.subString(i, i+1);
            
            if (currentChar.Contains('"')){

                if (insideQuotes == false){
                    insideQuotes = true;
                }
                else{
                    insideQuotes = false;
                }

            }
            
            if ((currentChar.contains(',')) && (insideQuotes == true)){
                nextLead = nextLead.subString(0, i) + ';' + nextLead.subString(i+1);
            }
                  
          }

      }
      
      
      // Split the string by TAB 
      string[] columnArray = nextLead.split(',');
     
      // Make sure we have more than 1 column -- should be 25?
      if (columnArray.size() == 1)
        continue;
      
      for( integer i = 0 ; i < columnArray.size() ; i++ ){
         if( columnArray[i].Startswith('"') && columnArray[i].endswith('"') ){
            columnArray[i] =  columnArray[i].replaceAll('"','') ;
         }
      }
      
      Lead objLead = new Lead();
       
      //Start Field Mapping from CSV Rows
      
      // 0  RFQ Number
      objLead.RFQ_Number__c = columnArray[0].trim();
      
      // 1  RFQ Date
      if(columnArray[1].trim() != ''){

        // We do not always receive a valid date
        fChar = columnArray[1].trim().subString(0,1);
        if ((fChar == '0') || (fChar == '1') || (fChar == '2') || (fChar == '3') || (fChar == '4') || (fChar == '5') || (fChar == '6') || (fChar == '7') || (fChar == '8') || (fChar == '9')){
        
            string dateString = columnArray[1];
            
            // In the production data feed Buyerzone is sending, this is now a date/time field
            // Here is an example of the format:  08/18/09 19:14
            // Lets parse out the time
            
            Integer atPosition = dateString.indexOf(' ');
            if (atPosition > -1){
                dateString = dateString.subString(0, atPosition);
            }
            
            // Continue with parsing the date now
                        
            string[] dateArray =  dateString.split('/');
            string month = dateArray[0];
            string day = dateArray[1];
            string year = dateArray[2] ; 
            if (year.length() == 1)
                year = '200' + year;
            else if (year.length() == 2)
                year = '20' + year;
            
            string stringDate = year + '-' + month+ '-' + day ;
     
            objLead.RFQ_Date__c = Date.valueOf(stringDate);
        
        }
        
      }      
      
      // 2  Name
      String leadName = columnArray[2].trim();

      if(leadName.trim() != ''){
     
        String[] leadnameArray = leadName.split(' ', 2);
     
        if(leadnameArray.size()== 2){
            objLead.FirstName = leadnameArray[0] ; 
            objLead.LastName = leadnameArray[1];
        }else if(leadnameArray.size()== 1){
            objLead.LastName = leadnameArray[0];
        }
      }else{
        objLead.LastName = 'None' ;
      } 
      
      // 3  Title
      objLead.Title = columnArray[3].trim();
      
      // 4  Company
      objLead.Company = columnArray[4].trim();
      
      // 5  Company Size
      // Ignore
      
      // 6  Industry Type
      objLead.Description = 'Industry: ' + columnArray[6].trim();
      
      // 7  Street
      objLead.Street = columnArray[7].trim();
      
      // 8  City
      objLead.City = columnArray[8].trim();
      
      // 9  State
      objLead.State = columnArray[9].trim();
      
      // 10 Zip
      fChar = columnArray[10].trim().subString(0,1);
      if ((fChar == '0') || (fChar == '1') || (fChar == '2') || (fChar == '3') || (fChar == '4') || (fChar == '5') || (fChar == '6') || (fChar == '7') || (fChar == '8') || (fChar == '9')){
  
        objLead.PostalCode = columnArray[10].trim();
  
      }
      
      // 11 Phone
      objLead.Phone = columnArray[11].trim();
      
      // 12 Email
      objLead.Email = columnArray[12].trim();

      // 13 Office trailer or mobile office:
      objLead.Description = '\nOffice trailer or mobile office: ' + columnArray[13].trim();
      
      // 14 Square footage requirements for building:
      objLead.Description += '\nSquare footage requirements for building: ' + columnArray[14].trim().replace(';',',');
      
      // 15 Primary use of your building:
      objLead.Description += '\nPrimary use of your building: ' + columnArray[15].trim();

      // 16 Single or multi-story building desired:
      objLead.Description += '\nSingle or multi-story building desired: ' + columnArray[16].trim();
      
      // 17 Style of contruction desired:
      objLead.Description += '\nStyle of contruction desired: ' + columnArray[17].trim();

      // 18 Preferred finance method:
      objLead.Description += '\nPreferred finance method: ' + columnArray[18].trim();
      
      // 19 Timeframe building is needed for:
      objLead.Description += '\nTimeframe building is needed for: ' + columnArray[19].trim();
                  
      // 20 Number of half baths needed (if applicable):
      if (columnArray.size() >= 21){
        objLead.Description += '\n\nNumber of half baths needed (if applicable): ' + columnArray[20].trim();
      }
      
      // 21 Number of ADA restrooms (if applicable):
      if (columnArray.size() >= 22) {
        objLead.Description += '\n\nNumber of ADA restrooms (if applicable): ' + columnArray[21].trim();
      }
      
      // 22 Number of private offices (if applicable):
      if (columnArray.size() >= 23){
        objLead.Description += '\n\nNumber of private offices (if applicable): ' + columnArray[22].trim();
      }
      
      // 23 Number of conference rooms/classrooms (if applicable):       
      // For some reason, all the trailing tabs are not always filled in.  Check to see of the array has enough indexes first      
      if (columnArray.size() >= 24){
        objLead.Description += '\nNumber of conference rooms/classrooms (if applicable) ' + columnArray[23].trim();
      }
      
      // 24 Delivery timeframe:
      if (columnArray.size() >= 25){
    objLead.Description += '\nDelivery timeframe: ' + columnArray[24].trim();
      }

      // 27 Additional requirements: 
      // For some reason, all the trailing tabs are not always filled in.  Check to see of the array has enough indexes first 
      if (columnArray.size() >= 28){
        objLead.Description += '\n\nAdditional Requirements:\n\n' +  columnArray[27].trim();
      }
      
      //End Field Mapping from CSV Rows
      
      // Find the RecordID for Buyerzone Leads
      List<RecordType> bbRecordTypeId = new List<RecordType>([Select r.Id from RecordType r where r.name = 'Buyerzone Lead']);//Added List by Najma Ateeq for S-139090
      if(bbRecordTypeId != null && bbRecordTypeId.size() >0)
      objLead.RecordTypeId = bbRecordTypeId.get(0).Id;
      
      // Determine Primary Contact Method
      objLead.Primary_Contact_Method__c = 'Phone';
      
      if (objLead.Fax != null){
        objLead.Primary_Contact_Method__c = 'Fax';
      }
      
      objLead.Rating = 'Hot (Probably Order)'; 
      objLead.Country = 'USA';
      objLead.LeadSource = 'Buyerzone' ;
      objLead.Auto_Assign_Lead__c = true ;
      
      listLead.add(objLead);
    }
    
  try{
      Database.SaveResult[] MySaveResult = Database.insert(listLead, false);
   
  } catch(Exception ex){
    System.debug('Ex'+ex);
  }
    
    for(integer i = 0 ; i < listLead.size() ; i++ ){
    }
  }  
  
  //Insert Leads..
  @Future public static void uploadLeadsOffices(List<String> leadList){
  
    /*
    
        0  RFQ Number
        1  RFQ Date
        2  Name
        3  Title
        4  Company
        5  Company Size
        6  Industry Type
        7  Street
        8 City
        9 State
        10 Zip
        11 Phone
        12 Email
        13 Primary use for the office trailer:
        14 Number of office trailers buyer is interested in:
        15 Number of people office trailer will need to accomodate:
        16 Square footage required for office trailer:
        17 Number of months buyer expects to need the office trailer:
        18 Buyer's preferred method of finance:
    19 Delivery Timeframe:
        20 Number of half baths needed (if applicable):
        21 Number of private offices needed (if applicable):
        22 Additional requirements:     
    
    */
  
    List<Lead> listLead = new List<Lead>();

    Boolean insideQuotes = false;
    String currentChar = '';
    String fChar = ''; 
        
    for (String nextLead :leadList){
      nextLead = nextLead.substring(0, nextLead.length() - 1);
      
      /*
      
      insideQuotes = false;
      
      // Go trough each line char by char -- if a comma is between two double quotes, replace it with a semicolon
      if (nextLead.Contains('"')){
          for (integer i=0;i<nextLead.length() - 1;i++){
            currentChar = nextLead.subString(i, i+1);
            
            if (currentChar.Contains('"')){

                if (insideQuotes == false){
                    insideQuotes = true;
                }
                else{
                    insideQuotes = false;
                }

            }
            
            if ((currentChar.contains(',')) && (insideQuotes == true)){
                nextLead = nextLead.subString(0, i-1) + ';' + nextLead.subString(i+1);
            }
                  
          }

      }
      
      */

      // Split the string by TAB 
      string[] columnArray = nextLead.split(',');
     
      // Make sure we have more than 1 column -- should be 25?
      if (columnArray.size() == 1)
        continue;
      
      for( integer i = 0 ; i < columnArray.size() ; i++ ){
         if( columnArray[i].Startswith('"') && columnArray[i].endswith('"') ){
            columnArray[i] =  columnArray[i].replaceAll('"','') ;
         }
      }
      
      Lead objLead = new Lead();
       
      //Start Field Mapping from CSV Rows

      // Dealer
      // objLead.Buyerzone_Dealer__c = columnArray[0].trim();
      
      // Category
      // objLead.Buyerzone_Category__c = columnArray[1].trim();
      
      // 0  RFQ Number
      objLead.RFQ_Number__c = columnArray[0].trim();
      
      // 1  RFQ Date
      if(columnArray[1].trim() != ''){

        // We do not always receive a valid date
        fChar = columnArray[1].trim().subString(0,1);
        if ((fChar == '0') || (fChar == '1') || (fChar == '2') || (fChar == '3') || (fChar == '4') || (fChar == '5') || (fChar == '6') || (fChar == '7') || (fChar == '8') || (fChar == '9')){
        
            string dateString = columnArray[1];
            
            // In the production data feed Buyerzone is sending, this is now a date/time field
            // Here is an example of the format:  08/18/09 19:14
            // Lets parse out the time
            
            Integer atPosition = dateString.indexOf(' ');
            if (atPosition > -1){
                dateString = dateString.subString(0, atPosition);
            }
            
            // Continue with parsing the date now
                        
            string[] dateArray =  dateString.split('/');
            string month = dateArray[0];
            string day = dateArray[1];
            string year = dateArray[2] ; 
            if (year.length() == 1)
                year = '200' + year;
            else if (year.length() == 2)
                year = '20' + year;
            
            string stringDate = year + '-' + month+ '-' + day ;

            objLead.RFQ_Date__c = Date.valueOf(stringDate);
        
        }
        
      }      
      
      // 2  Name
      String leadName = columnArray[2].trim();

      if(leadName.trim() != ''){
     
        String[] leadnameArray = leadName.split(' ', 2);
     
        if(leadnameArray.size()== 2){
            objLead.FirstName = leadnameArray[0] ; 
            objLead.LastName = leadnameArray[1];
        }else if(leadnameArray.size()== 1){
            objLead.LastName = leadnameArray[0];
        }
      }else{
        objLead.LastName = 'None' ;
      } 
      
      // 3  Title
      objLead.Title = columnArray[3].trim();
      
      // 4  Company
      objLead.Company = columnArray[4].trim();
      
      // 5  Company Size
      // Ignore
      
      // 6  Industry Type
      objLead.Description = 'Industry: ' + columnArray[6].trim();
      
      // 7  Street
      objLead.Street = columnArray[7].trim();
      
      // 8  City
      objLead.City = columnArray[8].trim();
      
      // 9  State
      objLead.State = columnArray[9].trim();
      
      // 10 Zip
      fChar = columnArray[10].trim().subString(0,1);
      if ((fChar == '0') || (fChar == '1') || (fChar == '2') || (fChar == '3') || (fChar == '4') || (fChar == '5') || (fChar == '6') || (fChar == '7') || (fChar == '8') || (fChar == '9')){
  
        objLead.PostalCode = columnArray[10].trim();
  
      }
      
      // 11 Phone
      objLead.Phone = columnArray[11].trim();
      
      // 12 Email
      objLead.Email = columnArray[12].trim();

      // 13 Primary use for the office trailer:
      objLead.Description = '\nPrimary use for the office trailer: ' + columnArray[13].trim();
      
      // 14 Number of office trailers buyer is interested in:
      objLead.Description += '\nNumber of office trailers buyer is interested in: ' + columnArray[14].trim();
            
      // 15 Number of people office trailer will need to accomodate:
      objLead.Description += '\nNumber of people office trailer will need to accomodate: ' + columnArray[15].trim();

      // 16 Square footage required for office trailer:
      objLead.Description += '\nSquare footage required for office trailer: ' + columnArray[16].trim();
      
      // 17 Number of months buyer expects to need the office trailer:
      objLead.Description += '\nNumber of months buyer expects to need the office trailer: ' + columnArray[17].trim();
      
      // 18 Buyer's preferred method of finance:
      objLead.Description += '\nBuyer\'s preferred method of finance: ' + columnArray[18].trim();

      // 19 Delivery timeframe
      objLead.Description += '\nDelivery Timeframe: ' + columnArray[19].trim();


      // 20 Number of half baths needed (if applicable):
      // For some reason, all the trailing tabs are not always filled in.  Check to see of the array has enough indexes first 
      if (columnArray.size() >= 21){
          objLead.Description += '\n\nNumber of half baths needed (if applicable): ' + columnArray[20].trim();
      }
        
      // 21 Number of private offices needed (if applicable):
      // For some reason, all the trailing tabs are not always filled in.  Check to see of the array has enough indexes first 
      if (columnArray.size() >= 22){
          objLead.Description += '\n\nNumber of private offices needed (if applicable): ' + columnArray[21].trim();
      }
        
      // 22 Additional requirements:
      // For some reason, all the trailing tabs are not always filled in.  Check to see of the array has enough indexes first 
      if (columnArray.size() >= 23){
        objLead.Description += '\n\nAdditional Requirements:\n\n' +  columnArray[22].trim();
      }
      
      //End Field Mapping from CSV Rows
      
      // Find the RecordID for Buyerzone Leads
      List<RecordType> bbRecordTypeId = new List<RecordType>([Select r.Id from RecordType r where r.name = 'Buyerzone Lead']);//Added List by Najma Ateeq for #S-139090
      if(bbRecordTypeId != null && bbRecordTypeId.size()>0)
      objLead.RecordTypeId = bbRecordTypeId.get(0).Id;
      
      // Determine Primary Contact Method
      objLead.Primary_Contact_Method__c = 'Phone';
      
      if (objLead.Fax != null){
        objLead.Primary_Contact_Method__c = 'Fax';
      }
      
      objLead.Rating = 'Hot (Probably Order)'; 
      objLead.Country = 'USA';
      objLead.LeadSource = 'Buyerzone' ;
      objLead.Auto_Assign_Lead__c = true ;
      
      listLead.add(objLead);
    }
    
  try{
      Database.SaveResult[] MySaveResult = Database.insert(listLead, false);
   
  } catch(Exception ex){
    
  }
    
 
    
  }  
 
  
static testMethod void testAll(){
    String str = '12345,11/5/10 9:25 AM,"John and Jane Doe","Accounting/Finance","Acme Co","20 to 49","Advertising/Marketing/PR","30 Main Street","Anchorage","AK","99501","617-512-1212",johnandjanedoe@example.com,Construction office,2,3-5,400-800 square feet,6 to 12 months,Lease,In one month,1,0,This is a test lead from BuyerZone for the new system being launched on 12/1/2010. You will NOT be charged for this test lead.,99501,johnandjanedoe@example.com';
    List<String> lst = new List<String>();
    lst.add(str);
    uploadLeadsOffices(lst);

    str = '12346,11/5/10 1:29 PM,"JohnandJane Doe","Accounting/Finance","Acme Co","1 to 9","Advertising/Marketing/PR","30 Main Street","Anchorage","AK","99501","617-555-1212",johnandjane5@example.com,No,"5,000 - 9,999 square feet",Educational facility,Single-story (1 floor),Standard,Purchase,Permanently,1,1,1,1,In more than six months,99501,johnandjane5@example.com,This is a test lead from BuyerZone for the new system being launched on 12/1/2010. You will NOT be charged for this test lead.';
    lst = new List<String>();
    lst.add(str);
    uploadLeadsBuildings(lst);

    str = '123410,11/5/10 1:35 PM,"JohnandJane Doe","Accounting/Finance","Acme Co","1 to 9","Advertising/Marketing/PR","30 Main Street","Anchorage","AK","99501","617-555-1212",johnandjane5@example.com,Business/Non-Profit Organization/Etc,Retail,2-4,"Extra doors, Locks",10 ft.,8 ft. (standard),Swing door (standard),Gravel,Rent/lease,Immediately,99501,johnandjane5@example.com,This is a test lead from BuyerZone for the new system being launched on 12/1/2010. You will NOT be charged for this test lead.';
    lst = new List<String>();
    lst.add(str);
    uploadLeadsContainers(lst);

    str = '12348,11/5/10 1:33 PM,"JohnandJane Doe","30 Main Street","Anchorage","AK","99501","617-555-1212",,johnandjane5@example.com,Home/Personal Use,Storage at my property,1,10 ft.,Purchase,ASAP,99501,,johnandjane5@example.com,This is a test lead from BuyerZone for the new system being launched on 12/1/2010. You will NOT be charged for this test lead.';
    lst = new List<String>();
    lst.add(str);
    uploadResidential(lst);
    

}

}