/*************************************************************************
Name    : ProcessOnLeadsByEmailServiceBlueBook
Author  : Kirtesh Jain 
Date    : June 10th,2009
Usage   : It handles CSV file attachments from Email Service and Create Leads.
          It is for BlueBook.

Modified By   : Aashish Mathur
Modified Date : June 15, 2009 
*************************************************************************/

global class ProcessOnLeadsByEmailServiceBlueBook implements Messaging.InboundEmailHandler {
  
  global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {

    Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
    //Handling of Binary Attachments
	  Messaging.InboundEmail.BinaryAttachment[] bAttachments = email.binaryAttachments;
    if( bAttachments != null ){     
      for( Messaging.InboundEmail.BinaryAttachment  binaryAttachment  : bAttachments ){   
           string wholeString =  binaryAttachment.body.tostring();  
           processAttachment( wholeString );
      }
    }
    //Handling of Text Attachments
    Messaging.InboundEmail.TextAttachment[] tAttachments = email.textAttachments;
     
    if( tAttachments != null ){     
      for( Messaging.InboundEmail.TextAttachment  txtAttachment  : tAttachments ){   
          string wholeString = String.valueOf(txtAttachment.body);  
          processAttachment( wholeString );
      }
    }
    
    return result;
  }
  
  public void processAttachment( string wholeString ){
    
    List<String> lst = new List<String>() ;
    boolean isFirst = true ;
    
    // process csv body here 
    //START_WHILE
    while(WholeString.trim() != ''){   
      Integer j = WholeString.indexOf('\n');
        system.debug('j=======>>>>>>>'+j);
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
          
      if(lst.size()>=120){  
        //Create actual leads from this function
        system.debug('200 Rows - Process and insert');
        uploadLeads(lst);
        lst = new List<String>();
      } 
    }
    //END_4 WHILE
    
    if(lst.size()>0){
      //Create actual leads from this function
      system.debug('Process and insert - Outside Loop');
      uploadLeads(lst);
    }
  }
   
  
  //Insert Leads..
  @Future
  public static void uploadLeads(List<String> leadList){
    List<Lead> listLead = new List<Lead>(); 

		Boolean insideQuotes = false;
		String currentChar = '';
	  // Find the RecordID for Blue Book Leads
	  Id bbRecordTypeId;
	  for(RecordType recordType : [Select r.Id from RecordType r where r.name = 'The Blue Book Lead']){
	  	bbRecordTypeId = recordType.id;
	  }
           
    for (String nextLead :leadList){
      nextLead = nextLead.substring(0, nextLead.length() - 1);
      insideQuotes = false;
      
      // Go trough each line char by char -- if a comma is between two double quotes, replace it with a semicolon
	  if (nextLead.Contains('"')){
	      for (integer i=0;i<nextLead.length() - 1;i++){
			      currentChar = nextLead.subString(i, i+1);
	          if (currentChar.Contains('"')){
									insideQuotes = !insideQuotes ? true: false;
				      /* if (insideQuotes == false){
					         insideQuotes = true; 
				       }
				       else{
					         insideQuotes = false;
				       } */

			      }
			   
			      if ((currentChar.contains(',')) && (insideQuotes == true)){
							String tempNextLead = nextLead.subString(0, i-1);
				       if(nextLead.substring(i-1,i) != '"'){
					         tempNextLead += nextLead.substring(i-1,i);
				       }
							 nextLead = tempNextLead + ';' + nextLead.subString(i+1);
			      }
			   
	      }

	  }
	  
	  system.debug('nextLead: ' + nextLead);
       
      // Split the string by comma 
      string[] columnArray = nextLead.split(',');
     
      // Make sure we have more than 1 column -- should be 12?
      if (columnArray.size() == 1)
        continue;
      
      for( integer i = 0 ; i < columnArray.size() ; i++ ){
         if( columnArray[i].Startswith('"') && columnArray[i].endswith('"') ){
            columnArray[i] =  columnArray[i].replaceAll('"','') ;
         }
      }
      
      Lead objLead = new Lead(Project_Name__c = columnArray[0],City = columnArray[1],State=columnArray[2], postalCode = columnArray[3],
      												Company = columnArray[8],Phone = columnArray[9],Fax = columnArray[10],Blue_Book_Type__c = columnArray[11],
      												Rating = 'Warm (Possibly Order)',Country = 'USA',LeadSource = 'The Blue Book' ,Auto_Assign_Lead__c = true );
       
      //Start Field Mapping from CSV Rows
       
      //Project Title
     // objLead.Project_Name__c = columnArray[0] ;
      system.debug('------> Project Name - ' + objLead.Project_Name__c);
      //Project City
     // objLead.City = columnArray[1] ;
      //Project State
    // objLead.State = columnArray[2];
      //Project Zip 
    //  objLead.PostalCode = columnArray[3];
      //Blue Book URL for Details
      objLead.Details_URL__c =  columnArray[5] != null && columnArray[5].length() >0 ? columnArray[5].replaceAll(';',','):columnArray[5];
      
      //Bids Due Date Start
      if(columnArray[6].trim() != ''){

        // We do not always receive a valid date
        String fChar = columnArray[6].trim().subString(0,1);
        if ((fChar == '0') || (fChar == '1') || (fChar == '2') || (fChar == '3') || (fChar == '4') || (fChar == '5') || (fChar == '6') || (fChar == '7') || (fChar == '8') || (fChar == '9')){
        
	        string dateString = columnArray[6];
	        string[] dateArray =  dateString.split('/');
	        string month = dateArray[0];
	        string day = dateArray[1];
	        string year = dateArray[2] ; 
	        if (year.length() == 1)
	            year = '200' + year;
	        else if (year.length() == 2)
	            year = '20' + year;
	        
	        string stringDate = year + '-' + month+ '-' + day ;
	        system.debug('--------> stringDate = ' + stringDate);
	       	objLead.Date_Required__c = Date.valueOf(stringDate);
        
        }
        
      }
      //Bids Due Date End
       
      //Start Contact Name
      string leadFullName = columnArray[7].trim() ;
      if(leadFullName.trim() != ''){
         
        String[] leadnameArray = leadFullName.split(' ', 2);
         
        if(leadnameArray.size()== 2){
           objLead.FirstName = leadnameArray[0] ; 
           objLead.LastName = leadnameArray[1];
        }else if(leadnameArray.size()== 1){
           objLead.LastName = leadnameArray[0];
        }
      }else{
         objLead.LastName = 'None' ;
      } 
      //End Contact Name
       
      //Contact Company/Agency
     // objLead.Company = columnArray[8];
      //Contact Phone
      //objLead.Phone = columnArray[9];
      //Contact Fax
   //  objLead.Fax = columnArray[10];

	  // Fax data sometimes comes in as "0" - we need to filter this
	  if (objLead.Fax == '0'){
	  	objLead.Fax = '';
	  }
	  
      //Lead/Type
      //objLead.Blue_Book_Type__c = columnArray[11] ;
       
      //End Field Mapping from CSV Rows
      
      // Find the RecordID for Blue Book Leads
     // RecordType bbRecordTypeId = [Select r.Id from RecordType r where r.name = 'The Blue Book Lead'];
     if(bbRecordTypeId != null)
      	 objLead.RecordTypeId = bbRecordTypeId;
      
      // Determine Primary Contact Method
      objLead.Primary_Contact_Method__c = 'Phone';
      
      if (objLead.Fax != null){
      	objLead.Primary_Contact_Method__c = 'Fax';
      }
      
     /* objLead.Rating = 'Warm (Possibly Order)'; 
      objLead.Country = 'USA';
      objLead.LeadSource = 'The Blue Book' ;
      objLead.Auto_Assign_Lead__c = true ;*/
      
      listLead.add(objLead);
    }
    
  try{
      Database.SaveResult[] MySaveResult = Database.insert(listLead, false);
  } catch(Exception ex){
    System.debug('Ex'+ex);
  }
    
 }
}