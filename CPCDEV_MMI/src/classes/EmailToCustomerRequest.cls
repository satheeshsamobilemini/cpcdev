global class EmailToCustomerRequest implements Messaging.InboundEmailHandler{
  
  global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.Inboundenvelope envelope){
    
    Service_Order_Request__c sor = new Service_Order_Request__c();
    map<String,String> mapEmailRQId = new map<String,String>(); 
    List<String> keyValueList = new List<String>();
    List<String> recordTypeQueueList = new List<String>();
    List<String> toAddrss = new List<String>();
    List<String> ccAddrss = new List<String>();
    List<String> tempAddrss = new List<String>();
    String crRecordTypeName='';
    String crOwnerName='';
    Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
    
     for(integer i=0; i<email.toAddresses.size(); i++)
      { tempAddrss = email.toAddresses[i].split('@');
        toAddrss.add(tempAddrss.get(0)); 
        tempAddrss.clear(); 
      }
    
     if(email.ccAddresses != null){
      for(integer i=0; i<email.ccAddresses.size(); i++) 
       { tempAddrss = email.ccAddresses[i].split('@');
         ccAddrss.add(tempAddrss.get(0));
         tempAddrss.clear();
       }
      } 
          
     try{
         
         // set the subject and description fields of record ...
         sor.Subject__c = (email.subject != null) ? email.subject : null;
         sor.Description__c = (email.PlainTextBody != null) ? email.PlainTextBody : null;
         
         List <EmailToCustomerRequest__c> emailList = EmailToCustomerRequest__c.getAll().values();
         String customerEmailAddress = email.fromAddress;    // TFS-7944 ..
         
         // map of email with record type and queue name ...  
          for(integer i=0;i<emailList.size(); i++)
           {  keyValueList = emailList[i].Email_RecordType_QueueId__c.split('#');
              mapEmailRQId.put(keyValueList[0],keyValueList[1]); 
              keyValueList.clear();
           }
          
         // find appropriate record type and queue name for the record...
           for(integer i=0;i<toAddrss.size();i++){
             if(mapEmailRQId.containskey(toAddrss.get(i)))
              { recordTypeQueueList = mapEmailRQId.get(toAddrss.get(i)).split(';');  }
            }
          
           if(recordTypeQueueList.isEmpty() && ccAddrss.size() > 0){ 
             for(integer i=0;i<ccAddrss.size();i++){
              if(mapEmailRQId.containskey(ccAddrss.get(i)))
               { recordTypeQueueList = mapEmailRQId.get(ccAddrss.get(i)).split(';');  }
             }
            } 
            
          if(recordTypeQueueList.size() > 0){ 
           crRecordTypeName = recordTypeQueueList.get(0);
           crOwnerName = recordTypeQueueList.get(1); 
          }   
          
         // if record type available, then query and assign record type...  
          if(crRecordTypeName != ''){
           RecordType[] crRecordType = [select Id,Name from RecordType where Name=:crRecordTypeName and sObjectType='Service_Order_Request__c' and isActive = true];
            if(crRecordType.size() > 0){ // TFS 8320 fix..
             sor.RecordTypeId = crRecordType[0].Id;
            }
          }
         
         // if queue available, then query and queue as owner...
          if(crOwnerName != ''){ 
           QueueSobject[] crOwnerQueue = [select Id,QueueId from QueueSobject where Queue.Name=:crOwnerName and SobjectType = 'Service_Order_Request__c'];
            if(crOwnerQueue.size() > 0){
             sor.OwnerId = crOwnerQueue[0].QueueId;
            }
          }
        
        // TFS 7944..
         if(customerEmailAddress != ''){
          User[] userObj = [select Id from User where isActive=true and Email=:customerEmailAddress];
           if(userObj.size() > 0)
            { sor.Actual_Created_By__c = userObj[0].Id;  // TFS 8320..
              //sor.CreatedbyId = userObj[0].Id; 
            } 
         }
        
        // TFS 8736..
        string sor_Name = '';        
        list<Service_Order_Request__c> sor_List = new list<Service_Order_Request__c>();
        string subj_sc = sor.Subject__c;
         if(subj_sc.contains('Case# ')){
           integer pos;
           pos = subj_sc.indexOf('Case# ');
           sor_Name = 'SOR-' + subj_sc.substring(pos+6,pos+12);
           sor_Name = sor_Name.replace(' ','');
           sor_List = [select Id,Name,Description__c from Service_Order_Request__c where Name =: sor_Name LIMIT 1];
        }

        if(!sor_List.isEmpty()){
         sor.Id = sor_List[0].Id;
         sor.Description__c = sor.Description__c + '\n\n\n*********************** Previous Issue Details *************************\n\n\n' + sor_List[0].Description__c;
         update sor;
        }else{ 
         insert sor;
         
        if(sor.Id != null && customerEmailAddress != ''){
           Service_Order_Request__c sor_inserted = [select Id,Name,RecordType.Name,Subject__c,Description__c from Service_Order_Request__c where Id =: sor.Id LIMIT 1];
            if(sor_inserted.recordType.Name.contains('Insurance') || Test.isRunningTest()){
             string url_link = URL.getSalesforceBaseUrl().toExternalForm();
              if(url_link.startsWith('http'))
                url_link = url_link.replaceFirst('http','https');
             string sub = 'Case# ' + string.valueOf(sor_inserted.Name).substring(4,sor_inserted.Name.length()) + ' created';
             
             string body = '<font>Hi<br/><br/>A new case has been recently created. ';
             body += 'Please click on below link to view more details in salesforce :<br/><br/>';
             body += '<a href ="' + url_link + '/' +sor.Id+ '">' + url_link + '/' +sor.Id+'</a></font><br/><br/><br/>';
             body += '<p style="color: green;font-size : 82%"><b>NOTE : PLEASE RETAIN "Case# ' +string.valueOf(sor_inserted.Name).substring(4,sor_inserted.Name.length())+ '" AS PART OF SUBJECT FOR FURTHER CONVERSATIONS ON THIS ISSUE.</b></p>';
             
             Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
             mail.setSubject(sub);
             mail.setToAddresses(new list<string>{customerEmailAddress});
             mail.setHTMLBody(body);
             mail.setSaveAsActivity(false);
              if(customerEmailAddress != null)
               Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{mail});
            } 
          }        
      }  
        system.debug('---Service Order Request---' + sor);
        
        system.debug('---Text Attachments---'+email.TextAttachments);
        system.debug('---Binary Attachments---'+email.binaryAttachments);
                  
        // insert text attachments (if any)... 
         if(email.TextAttachments != null){
          for(Messaging.InboundEmail.TextAttachment tAttachment : email.TextAttachments){
            Attachment attchment = new Attachment();
            attchment.Name = tAttachment.fileName;
            attchment.Body = Blob.valueOf(tAttachment.Body); 
            attchment.ParentId = sor.id;
            insert attchment;
           }
         } 
         
        // insert binary attachments (if any) ...
         if(email.BinaryAttachments != null){ 
          for(Messaging.InboundEmail.BinaryAttachment bAttachment : email.BinaryAttachments){
            Attachment attchment = new Attachment();
            attchment.Name =  bAttachment.fileName;
            attchment.Body = bAttachment.Body;
            attchment.ParentId = sor.id;
            insert attchment;     
           }
         }   
      
        result.success = true;
     
     }catch(Exception e){
       result.success = false;
       result.message = 'Could not complete the operation';
     }
    
    return result;
  }

}