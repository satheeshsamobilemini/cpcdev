/*********************************************************************************

Name : Service800CSVfileByEmail
Created By : Kirtesh Jain
Created Date : 24 September 2009

Usage : used to Process CSV file attached with Mail and Insert Data in 
        Net_Promoter_Score__c object and Linked to Account on Basis of 
        ResultId and Branch Match

Modified By : kirtesh Jain
Modified Date : October 01 ,2009
Comment : Now we are assigning 'Net Promoter Scores' Account to Account__c field of 
          Records if there is no match for ResultId and Branch.
          
**********************************************************************************/
global class Service800CSVfileByEmail implements Messaging.InboundEmailHandler {

    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
      Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
      
      //Handling of Text Attachments
      Messaging.InboundEmail.TextAttachment[] tAttachments = email.textAttachments;
    
      if( tAttachments != null ){     
        for( Messaging.InboundEmail.TextAttachment  txtAttachment  : tAttachments ){ 
          //System.debug('Debug:Kirtesh..........textAttachment');  
          string wholeString = String.valueOf(txtAttachment.body);  
          processAttachment( wholeString );
        }
      }
      
      //Handling of Binary Attachments
      Messaging.InboundEmail.BinaryAttachment[] bAttachments = email.binaryAttachments;
      Integer attachmentCount = 0;
      if( bAttachments != null ){     
         for( Messaging.InboundEmail.BinaryAttachment  binaryAttachment  : bAttachments ){   
             //System.debug('Debug:Kirtesh..........BinaryAttachment');
             attachmentCount++;
             string wholeString =  binaryAttachment.body.tostring();  
             processAttachment( wholeString );
         }
         System.debug('******attachmentCount: ' + attachmentCount);
      }      
      return result;
    }
    
    
    public void processAttachment( string wholeString ){
      List<String> lst = new List<String>() ;
      
      while(WholeString.trim() != ''){  
          Integer j = WholeString.indexOf('\n');
          string currentLine;
          if(j == -1){   
            currentLine = WholeString;
            WholeString = '';
          }else{
            currentLine = WholeString.substring(0,j);
            if(WholeString.length()>j+1)
               WholeString = WholeString.substring(j+1);
            else
               WholeString ='';
          }
          
          if(currentLine.trim()!=''){
           lst.add(currentLine.trim());
          }
         
         
         if(lst.size() == 1000 ){  
            System.debug('*****List size 1000 ******');
            uploadNetPromoterScore(lst);
            lst = new List<String>();
         } 
      }
      
      if(lst.size()>0){
         System.debug('***** List.size():  ' + lst.size());
         uploadNetPromoterScore(lst);
      }
    }
    
    public void uploadNetPromoterScore( List<String> listRow){
      System.debug('Debug:Kirtesh****************WholeListRow'+listRow);
       if(!Test.isRunningTest())  // TFS 8 fix..
       { String rmvHeaderRow = listRow.remove(0); } 
      System.debug('Debug:Kirtesh2****************WholeListRow'+listRow);
      
      Set<String> SetSAPBillToId = new Set<String>() ;
      Set<String> setBranchIds = new Set<String> () ;
      Set<String> setCallDataIds = new Set<String>(); // TFS 7999..
      Net_Promoter_Score__c npsObj;  // TFS 7999,8491 fix..
      List<Net_Promoter_Score__c> listNetPromoterScore = new List<Net_Promoter_Score__c>() ;
      List<Net_Promoter_Score__c> nlistNetPromoterScore = new list<Net_Promoter_Score__c>(); // TFS 7999..
      map<String,Net_Promoter_Score__c> mapCallDataIdNPS = new map<String,Net_Promoter_Score__c>(); // TFS 7999..
      Map<string , string>  mapResultIdtoAccountId = new Map<string , string>() ;
      
      //Map<string , string>  mapAccountIdtoNPSScore = new Map<string , string>() ; TFS 5491
      Boolean noErrors = true;
      Boolean noErrors2 = true;
      set<Id> AccountIdset = new set<Id>();
      set<Id> NPSIdset = new set<Id>();
      set<Id> NPSIdset2 = new set<Id>();
      string txtstring ='';
      //try{
      for( String instantRow : listRow ){
        System.debug('Debug:Kirtesh****************instantRow'+instantRow);
        Net_Promoter_Score__c instantNetPromoter = new   Net_Promoter_Score__c(); 
        string[]  columnArray =  instantRow.split('\\|');
        //for(integer i = 0 ; i< columnArray.size() ; i++){
        if (columnArray.size() > 0){
            
          // column 1 - CallDataID
           txtstring = columnArray[0];
           txtstring = (txtstring != null && txtstring!= '')? (txtstring.substring(0,1) == '"' ? txtstring.substring(1,txtstring.length()) : txtstring) : null;
           instantNetPromoter.CallDataID__c =  txtstring;
          //include in Set for CallDataIds
           setCallDataIds.add(instantNetPromoter.CallDataID__c);
          //column 2 - ProjCode
           instantNetPromoter.ProjCode__c =  processStringData(columnArray[1]);
          //column 3 -  Price and Terms # --> Order_Number
           instantNetPromoter.Price_and_Terms__c = processStringData(columnArray[2]);   
          //column 4 - SAP Bill To#
           instantNetPromoter.SAP_Bill_To__c = processStringData(columnArray[3]);
          // include in Set for SAP Bill To#
           if(instantNetPromoter.SAP_Bill_To__c != null && instantNetPromoter.SAP_Bill_To__c != '')
             SetSAPBillToId.add(instantNetPromoter.SAP_Bill_To__c ); 
          //column 5 - SAP Sold To#
           instantNetPromoter.SAP_Sold_To__c = processStringData(columnArray[4]);
          // column 6 - company Name --> Customer_Name
           instantNetPromoter.Company_Name__c = processStringData(columnArray[5]);
          //column 7 - Person Ordering P/U or Delivery
           if(columnArray.size() > 6)
               instantNetPromoter.Person_Ordering_P_U_or_Delivery__c =  processStringData(columnArray[6]);
             else{
               listNetPromoterScore.add(instantNetPromoter);
               continue;
           }
          //column 8 -Ordering Persons Phone Number --> Telephone_Sold_To
           if(columnArray.size() > 7)
               instantNetPromoter.Ordering_Persons_Phone_Number__c = processStringData(columnArray[7]);
           else{
               listNetPromoterScore.add(instantNetPromoter);
               continue;
           }
           //column 9 - service Date
            if (columnArray.size() > 8){
               string strDate =  processStringData(columnArray[8]);
               if( strDate != null )
                 instantNetPromoter.Service_Date__c = ConvertToDateTime(columnArray[8]); //DatefromString(strDate);
            }
            else{
               listNetPromoterScore.add(instantNetPromoter);
               continue;
            }      
           // column 10 - Salesperson Number
            if (columnArray.size() > 9)
              instantNetPromoter.Sales_Rep_Id__c = processStringData(columnArray[9]);
            else{
               listNetPromoterScore.add(instantNetPromoter);
               continue;
            }
           // column 11 - Emp_Role
            if (columnArray.size() > 10)
              instantNetPromoter.Emp_Role__c = processStringData(columnArray[10]);
            else{
               listNetPromoterScore.add(instantNetPromoter);
               continue;
            }  
           // column 12 - Delivery_Pickup_City
            if (columnArray.size() > 11)
              instantNetPromoter.Delivery_Pickup_City__c = processStringData(columnArray[11]);
            else{
               listNetPromoterScore.add(instantNetPromoter);
               continue;
            }
           //column 13 - Delivery/Pick Up City  State
            if(columnArray.size() > 12)
               instantNetPromoter.Delivery_Pick_Up_City_State__c = processStringData(columnArray[12]);
            else{
               listNetPromoterScore.add(instantNetPromoter);
               continue;
            }
           //column 14 - Postal_Cd_Ship
            if(columnArray.size() > 13)
               instantNetPromoter.Postal_Cd_Ship__c = processStringData(columnArray[13]);
            else{
               listNetPromoterScore.add(instantNetPromoter);
               continue;
            }
           //column 15 - Job Name
            if(columnArray.size() > 14)
               instantNetPromoter.Job_Name__c = processStringData(columnArray[14]);
            else{
               listNetPromoterScore.add(instantNetPromoter);
               continue;
            }
           //column 16 - PickList-Start //column 12 - Type of Service --> Delivery_Type
            if(columnArray.size() > 15)
               instantNetPromoter.Type_of_Service__c = processStringData(columnArray[15]);
            else{
               listNetPromoterScore.add(instantNetPromoter);
               continue;
            }
           //column 17 - Type of Product --> Profit_Center
            if(columnArray.size() > 16)
               instantNetPromoter.Type_of_Product__c = processStringData(columnArray[16]);
             else{
               listNetPromoterScore.add(instantNetPromoter);
               continue;
             }
           //column 18 - Type of Customer --> Customer_Group_Desc_Sold
            if(columnArray.size() > 17)
              instantNetPromoter.Type_of_Customer__c = processStringData(columnArray[17]);
             else{
               listNetPromoterScore.add(instantNetPromoter);
               continue;
            }
           //column  19 -    Country  
            if(columnArray.size() > 18)    
               instantNetPromoter.Country__c = processStringData(columnArray[18]);
            else{
               listNetPromoterScore.add(instantNetPromoter);
               continue;    
            }
           //column 20 - Brach  --> Plant_Code
           if(columnArray.size() > 19) 
               instantNetPromoter.Branch_ID__c = processStringData(columnArray[19]);
             else{
               listNetPromoterScore.add(instantNetPromoter);
               continue;
             }
           //Include in Set of Branch_Ids
            if( instantNetPromoter.Branch_ID__c != null ){
           
             if (instantNetPromoter.Branch_ID__c == '103'){
                instantNetPromoter.Branch_ID__c = '903';
             }
             else if (instantNetPromoter.Branch_ID__c == '104'){
                instantNetPromoter.Branch_ID__c = '904';
             }
             
             else if (instantNetPromoter.Branch_ID__c == '109'){
                instantNetPromoter.Branch_ID__c = '909';
             }
             
             else if (instantNetPromoter.Branch_ID__c == '112'){
                instantNetPromoter.Branch_ID__c = '912';
             }
             
             else if (instantNetPromoter.Branch_ID__c == '114'){
                instantNetPromoter.Branch_ID__c = '914';
             }

             else if (instantNetPromoter.Branch_ID__c == '141'){
                instantNetPromoter.Branch_ID__c = '941';
             }
             
             else if (instantNetPromoter.Branch_ID__c == '145'){
                instantNetPromoter.Branch_ID__c = '945';
             }
             
             else if (instantNetPromoter.Branch_ID__c == '155'){
                instantNetPromoter.Branch_ID__c = '955';
             }
             
             else if (instantNetPromoter.Branch_ID__c == '156'){
                instantNetPromoter.Branch_ID__c = '956';
             }
             
             else if (instantNetPromoter.Branch_ID__c == '163'){
                instantNetPromoter.Branch_ID__c = '963';
             }
             
             else if (instantNetPromoter.Branch_ID__c == '168'){
                instantNetPromoter.Branch_ID__c = '968';
             }
             
             else if (instantNetPromoter.Branch_ID__c == '177'){
                instantNetPromoter.Branch_ID__c = '977';
             }               
           
             setBranchIds.add(instantNetPromoter.Branch_ID__c); 
           
           }
          // column 21 -  Plant_Name 
           if (columnArray.size() > 20)
               instantNetPromoter.Plant_Name__c = processStringData(columnArray[20]);
             else{
               listNetPromoterScore.add(instantNetPromoter);
               continue;
             }
          //column 22 - Region --> Plant_Region_Name
           if(columnArray.size() > 21)
               instantNetPromoter.Region__c = processStringData(columnArray[21]);
           else{
               listNetPromoterScore.add(instantNetPromoter);
               continue;
             }
          //column 23 - Division --> Plant_Division_Name 
           if(columnArray.size() > 22)
               instantNetPromoter.Division__c = processStringData(columnArray[22]);
           else{
               listNetPromoterScore.add(instantNetPromoter);
               continue;
             }
          // column 24 - Customer Industry Classification --> Customer_Industry_Name_Sold
           if(columnArray.size() > 23)
               instantNetPromoter.Customer_Industry_Classification__c =  processStringData(columnArray[23]);
           else{
               listNetPromoterScore.add(instantNetPromoter);
               continue;
             }
          // column 25 - Model Number --> Manufact_Model_Number  
           if(columnArray.size() > 24)
               instantNetPromoter.Model_Number__c =   processStringData(columnArray[24]);
           else{
               listNetPromoterScore.add(instantNetPromoter);
               continue;
           }
          // column 26 -  Site Contact Name 
           if (columnArray.size() > 25)
               instantNetPromoter.Site_Contact_Name__c = processStringData(columnArray[25]);
             else{
               listNetPromoterScore.add(instantNetPromoter);
               continue;
           }
          //column 27 - Site Contact Tel
           if (columnArray.size() > 26)
               instantNetPromoter.Site_Contact_Tel__c = processStringData(columnArray[26]) ;
           else{
               listNetPromoterScore.add(instantNetPromoter);
               continue;
           }
          //column 28 - Site Contact Cell
           if(columnArray.size() > 27)
               instantNetPromoter.Site_Contact_Cell__c = processStringData(columnArray[27]);
           else{
               listNetPromoterScore.add(instantNetPromoter);
               continue;
           }
          // changed ternary operator in if-else (PR-09093)
          
          //column 29 - Transaction
          //column 30 - HFC Status  --> Risk_Category_Sold
          
        if(instantNetPromoter.ProjCode__c != '' && instantNetPromoter.ProjCode__c != null && instantNetPromoter.ProjCode__c != '3M'){
         // TFS 5166 - added new fields to NPS 
         // column 31 - Customer Effort Score  --> Personal Effort Score
          if(columnArray.size() > 30){ 
          if(columnArray[30] != null && columnArray[30] != ''){
            instantNetPromoter.Customer_Effort_Score__c = Double.valueof(columnArray[30]); }
           }else{
             listNetPromoterScore.add(instantNetPromoter);
             continue;        
          }
         // TFS 5166 - added new fields to NPS 
         //column 32 - CES – May I ask why  --> Personal Effort - May I ask why?
          if(columnArray.size() > 31)
            instantNetPromoter.CES_May_I_ask_why__c = processStringData(columnArray[31]);
          else{
           listNetPromoterScore.add(instantNetPromoter);
           continue; 
          }
         //TFS 5166 - new fields added to NPS
        // column 33 - CES – Comment Category
         if(columnArray.size() > 32)
          instantNetPromoter.CES_Comment_Category__c = processStringData(columnArray[32]);
         else{
            listNetPromoterScore.add(instantNetPromoter);
            continue;
         }
        // TFS - NPS Field mapping
        //need to change here for PR-09677
        //column 34 - Professionalism and Knowledge of salesperson --> Delivery - Professionalism and knowledge
         if(columnArray.size() > 33){
           if(columnArray[33]!= null && columnArray[33]!= ''){
             instantNetPromoter.Professionalism_of_salesperson__c = Double.valueof(columnArray[33]);//columnArray[27]
            }
          }
           else{
             listNetPromoterScore.add(instantNetPromoter);
             continue;
          }
        //Column 35 - Timeliness of our delivery --> Delivery - Timeliness of delivery
         if(columnArray.size() > 34 ){
           if(columnArray[34]!= null && columnArray[34]!= ''){
             //System.debug('--columnArray[30]--'+columnArray[30]);
             String column34 = columnArray[34].substring(0,1) == '"' ? ( ColumnArray[34].substring(1, ColumnArray[34].length()-1) ): columnArray[34];
             if(column34 != null && column34 != ''){
            instantNetPromoter.Timeliness_of_our_delivery__c =  Double.valueof(column34); // columnArray[29]             
             }
               
           }
         }else{
           listNetPromoterScore.add(instantNetPromoter);
               continue;
         }
        //Column 36 - Professionalism of our driver - Delivery  --> Delivery - Professionalism of driver
         if(columnArray.size() > 35){    
           if(columnArray[35]!= null && columnArray[35]!= ''){
             //System.debug('--columnArray[31]--'+columnArray[31]);
                 instantNetPromoter.Professionalism_of_our_driver_Delivery__c =  Double.valueof(columnArray[35]);//columnArray[30]
           }
         }else{
           listNetPromoterScore.add(instantNetPromoter);
               continue;
         }
        //need to be change here for PR-09677
        //column 37 - Quality/Appearance of our product --> Delivery - Quality and appearance of product
         if(columnArray.size() > 36){
           if(columnArray[36]!= null && columnArray[36]!= ''){
                 instantNetPromoter.Quality_Appearance_of_our_product__c =  Double.valueof(columnArray[36]);//columnArray[31]
                 system.debug('============ columnArray.size() ===============' + columnArray.size()); 
           }
         }else{
           listNetPromoterScore.add(instantNetPromoter);
               continue;  
         }      
        //column 38 - Professionalism of person regarding pick-up --> Return - Professionalism of scheduling person
         if(columnArray.size() > 37){      
               system.debug('--I am inside first----');  
               if(columnArray[37]!= null && columnArray[37]!= ''){
                 instantNetPromoter.Professionalism_of_dispatcher__c =  Double.valueof(columnArray[37]);// columnArray[33]
                 system.debug('--I am inside second----');  
           }
          }else{  system.debug('----I am inside else condition---------');
           listNetPromoterScore.add(instantNetPromoter);
               continue;
          }
        //column 39 - Timeliness of our pickup  --> Return - Timeliness of pickup
         if(columnArray.size() > 38){
           system.debug('--I am inside column array 39----');
           if(columnArray[38]!= null && columnArray[38]!= ''){
                 instantNetPromoter.Timeliness_of_our_pickup__c =  Double.valueof(columnArray[38]); // columnArray[34]
           }
          }else{
           listNetPromoterScore.add(instantNetPromoter);
               continue;
          }
        //column 40 - Professionalism of our driver - Pickup  --> Return - Professionalism of driver
         if(columnArray.size() > 39){
           system.debug('--I am inside column array 40----');
           if(columnArray[39]!= null && columnArray[39]!= ''){
                 instantNetPromoter.Professionalism_of_our_driver_Pickup__c =  Double.valueof(columnArray[39]);// columnArray[35]
           }
         }else{
           listNetPromoterScore.add(instantNetPromoter);
               continue;
         }
        // column 41 - Satisfaction with quality of our product --> Return - Quality of our product
         if(columnArray.size() > 40){
              system.debug('--I am inside column array 41----');
               if(columnArray[40]!= null && columnArray[40]!= ''){
                 instantNetPromoter.Quality_of_our_product__c =  Double.valueof(columnArray[40]); // columnArray[36]
           }
         }else{
           listNetPromoterScore.add(instantNetPromoter);
               continue;
         }
        // column 42 - Satisfaction with our billing process : uncommented  --> Return - Our billing process
         if(columnArray.size() > 41){
           if(columnArray[41]!= null && columnArray[41]!= ''){
               system.debug('--I am inside column array 42----');
               instantNetPromoter.Satisfaction_with_billing_invoice_svcs__c =  Double.valueof(columnArray[41]);
            }   
         }else{
           listNetPromoterScore.add(instantNetPromoter);
               continue;
         }
        //column 43 -  Did driver answer all of your questions regarding operation of equipment
        //column 44 - Did we work in a safe manner and properly follow all of your safety requirements
        //column 45 - Would you recommend us?
         if(columnArray.size() > 44){
           system.debug('--I am inside column array 45----');
           if( columnArray[44]!= null && columnArray[44]!= ''){
                 instantNetPromoter.Would_you_recommend_us__c =  Double.valueof(columnArray[44]);// columnArray[40]
           }
         }else{
           listNetPromoterScore.add(instantNetPromoter);
               continue;
         }
        //column 46 - What would increase likelihood to recommend us?
        if(columnArray.size() > 45){
              system.debug('--I am inside column array 46----');
              instantNetPromoter.What_would_increase_likelihood_to_recomm__c =  processStringData(columnArray[45]); // columnArray[41]
        }else{
            listNetPromoterScore.add(instantNetPromoter);
               continue;
        }
        
       }else if(instantNetPromoter.ProjCode__c == '3M'){ 
        // TFS - NPS Field mapping
        //need to change here for PR-09677
        //column 31 - Professionalism and Knowledge of salesperson 
         if(columnArray.size() > 30){
           if(columnArray[30]!= null && columnArray[30]!= ''){
             instantNetPromoter.Professionalism_of_salesperson__c = Double.valueof(columnArray[30]);//columnArray[27]
            }
          }
           else{
             listNetPromoterScore.add(instantNetPromoter);
             continue;
          }
        //Column 32 - Timeliness of our delivery 
         if(columnArray.size() > 31 ){
           if(columnArray[31]!= null && columnArray[31]!= ''){
             //System.debug('--columnArray[30]--'+columnArray[30]);
             String column31 = columnArray[31].substring(0,1) == '"' ? ( ColumnArray[31].substring(1, ColumnArray[31].length()-1) ): columnArray[31];
             if(column31 != null && column31 != ''){
            instantNetPromoter.Timeliness_of_our_delivery__c =  Double.valueof(column31); // columnArray[29]             
             }
               
           }
         }else{
           listNetPromoterScore.add(instantNetPromoter);
               continue;
         }
        //Column 33 - Professionalism of our driver - Delivery  
         if(columnArray.size() > 32){    
           if(columnArray[32]!= null && columnArray[32]!= ''){
             //System.debug('--columnArray[31]--'+columnArray[31]);
                 instantNetPromoter.Professionalism_of_our_driver_Delivery__c =  Double.valueof(columnArray[32]);//columnArray[30]
           }
         }else{
           listNetPromoterScore.add(instantNetPromoter);
               continue;
         }
        //need to be change here for PR-09677  
        //need to be change here for PR-09677
        //column 34 - Quality/Appearance of our product 
         if(columnArray.size() > 33){
           if(columnArray[33]!= null && columnArray[33]!= ''){
                 instantNetPromoter.Quality_Appearance_of_our_product__c =  Double.valueof(columnArray[33]);//columnArray[31]
           }
         }else{
           listNetPromoterScore.add(instantNetPromoter);
               continue;  
         }      
        //column 35 - Professionalism of person regarding pick-up --> Professionalism of scheduling person
         if(columnArray.size() > 34){        
               if(columnArray[34]!= null && columnArray[34]!= ''){
                 instantNetPromoter.Professionalism_of_dispatcher__c =  Double.valueof(columnArray[34]);// columnArray[33]
           }
          }else{
           listNetPromoterScore.add(instantNetPromoter);
               continue;
          }
        //column 36 - Timeliness of our pickup 
         if(columnArray.size() > 35){
           if(columnArray[35]!= null && columnArray[35]!= ''){
                 instantNetPromoter.Timeliness_of_our_pickup__c =  Double.valueof(columnArray[35]); // columnArray[34]
           }
          }else{
           listNetPromoterScore.add(instantNetPromoter);
               continue;
          }
        //column 37 - Professionalism of our driver - Pickup  
         if(columnArray.size() > 36){
           if(columnArray[36]!= null && columnArray[36]!= ''){
                 instantNetPromoter.Professionalism_of_our_driver_Pickup__c =  Double.valueof(columnArray[36]);// columnArray[35]
           }
         }else{
           listNetPromoterScore.add(instantNetPromoter);
               continue;
         }
        // column 38 - Satisfaction with quality of our product -->  Quality of our product
         if(columnArray.size() > 37){
               if(columnArray[37]!= null && columnArray[37]!= ''){
                 instantNetPromoter.Quality_of_our_product__c =  Double.valueof(columnArray[37]); // columnArray[36]
           }
         }else{
           listNetPromoterScore.add(instantNetPromoter);
               continue;
         }
        // column 39 - Satisfaction with our billing process : uncommented
         if(columnArray.size() > 38){ 
            if(columnArray[38]!= null && columnArray[38]!= ''){
               instantNetPromoter.Satisfaction_with_billing_invoice_svcs__c =  Double.valueof(columnArray[38]);
            }    
         }else{
           listNetPromoterScore.add(instantNetPromoter);
               continue;
         }
        //column 40 - Would you recommend us?
         if(columnArray.size() > 39){
           if( columnArray[39]!= null && columnArray[39]!= ''){
                 instantNetPromoter.Would_you_recommend_us__c =  Double.valueof(columnArray[39]);// columnArray[40]
           }
         }else{
           listNetPromoterScore.add(instantNetPromoter);
               continue;
         } 
       //column 41 - What would increase likelihood to recommend us?
        if(columnArray.size() > 40)
              instantNetPromoter.What_would_increase_likelihood_to_recomm__c =  processStringData(columnArray[40]); // columnArray[41]
        else{
            listNetPromoterScore.add(instantNetPromoter);
               continue;
        }
       // TFS 5166 - added new fields to NPS 
         // column 42 - Customer Effort Score  
          if(columnArray.size() > 41){ 
          if(columnArray[41] != null && columnArray[41] != ''){
            instantNetPromoter.Customer_Effort_Score__c = Double.valueof(columnArray[41]); }
           }else{
             listNetPromoterScore.add(instantNetPromoter);
             continue;        
          }
         // TFS 5166 - added new fields to NPS 
         //column 43 - CES – May I ask why  
          if(columnArray.size() > 42)
            instantNetPromoter.CES_May_I_ask_why__c = processStringData(columnArray[42]);
          else{
           listNetPromoterScore.add(instantNetPromoter);
           continue; 
          }
         //TFS 5166 - new fields added to NPS
        // column 44 - CES – Comment Category
         if(columnArray.size() > 43)
          instantNetPromoter.CES_Comment_Category__c = processStringData(columnArray[43]);
         else{
            listNetPromoterScore.add(instantNetPromoter);
            continue;
         }
        // TFS - NPS Field mapping 
       }
       
       integer i = instantNetPromoter.ProjCode__c == '3M' ? 44 : 46;
      
      // column 45/47 - Is there anything else that would make Mobile Mini a better vendor or partner?
       if(columnArray.size() > i){
          system.debug('--I am inside column array----'+ i);
          instantNetPromoter.Make_MobileMini_better_Partner_or_Vendor__c = processStringData(columnArray[i]);
          i++;
       }else{
          listNetPromoterScore.add(instantNetPromoter);
          continue;
       }
      // changed ternary operator in if-else (PR-09093)
      //column 46/48 - Alert Manager?
         if(columnArray.size() >i){
            system.debug('--I am inside column array----'+ i);
            if(columnArray[i]!= null && columnArray[i]!= ''){
             instantNetPromoter.Alert_a_Manager__c =  Double.valueof(columnArray[i]);// columnArray[47]
           } i++;
         }else{
           listNetPromoterScore.add(instantNetPromoter);
               continue;
        }
      //column 47/49 - Caller Reported Hot
       if(columnArray.size() > i){
           system.debug('--I am inside column array----'+ i);
           if(columnArray[i]!= null && columnArray[i]!= ''){
             instantNetPromoter.Caller_Reported_Hot__c =  Double.valueof(columnArray[i]);// columnArray[48]
           } i++;
       }else{
           listNetPromoterScore.add(instantNetPromoter);
               continue;
       }       
       //column 48/50 - Automatic Hot
        if(columnArray.size() > i){
           system.debug('--I am inside column array----'+ i);
           instantNetPromoter.Automatic_Hot__c  = processStringData(columnArray[i]);// columnArray[49]
           i++;
        }else{
           listNetPromoterScore.add(instantNetPromoter);
               continue;
        }
       //column 49/51 - Hot Sheet Generated  
        if(columnArray.size() > i){
           system.debug('--I am inside column array----'+ i);
           instantNetPromoter.Hot_Sheet_Generated__c  = processStringData(columnArray[i]);// columnArray[50]
           i++;
        }else{
           listNetPromoterScore.add(instantNetPromoter);
           continue;
        }
       //column 50/52 - Interview Date  
       if(columnArray.size() > i){
               system.debug('--I am inside column array----'+ i);                      
               instantNetPromoter.Interview_Date__c =  ConvertToDateTime(columnArray[i]); // columnArray[51]
               i++; 
        }else{
           listNetPromoterScore.add(instantNetPromoter);
               continue;
       }
      //column 51/53 - Unable to complete comments
      //One field  will be Added later (Red in Google Sheet) 52th column of CSV file
        if(columnArray.size() > i){
            system.debug('--I am inside column array----'+ i);
                instantNetPromoter.Unable_To_Complete_Comments__c =  columnArray[i]; // columnArray[51]
            i++;
         }else{
           listNetPromoterScore.add(instantNetPromoter);
           continue;
       }
      // changed ternary operator in if-else (PR-09093)
      //column 52/54 - Report Month
         if(columnArray.size() > i){
          system.debug('--I am inside column array----'+ i);
          if(columnArray[i]!= null && columnArray[i]!= ''){
            instantNetPromoter.Report_Month__c =  Double.valueof(columnArray[i]); // columnArray[53]
          } i++;
         }else{
                listNetPromoterScore.add(instantNetPromoter);
                continue;
         }
       //column 53/55 - Report Year
       if(columnArray.size() > i){
         system.debug('--I am inside column array----'+ i);
         if(columnArray[i]!= null && columnArray[i]!= ''){
            instantNetPromoter.Report_Year__c =  Double.valueof(columnArray[i]); //columnArray[54]
          } i++;     
       }else{
              listNetPromoterScore.add(instantNetPromoter);
              continue;
       }
       //column 54/56 - Post-Survey Comment #1
          if(columnArray.size() > i){
               system.debug('--I am inside column array----'+ i);
               instantNetPromoter.Post_Survey_Comments__c = processStringData(columnArray[i]);//columnArray[56]
               i++;
          }else{
           listNetPromoterScore.add(instantNetPromoter);
               continue;
       }
       // column 55/57 - Post-Survey Comment Last Updated On
        if(columnArray.size() > i){
             system.debug('--I am inside column array----'+ i);
             instantNetPromoter.Post_Survey_Comment_Last_Updated_On__c = ConvertToDateTime(columnArray[i]);
             i++;
        }else{
            listNetPromoterScore.add(instantNetPromoter);
              continue; 
        }
       //column 56/58 - Post-Survey Category1 
         if(columnArray.size() > i){
            system.debug('--I am inside column array----'+ i);
            instantNetPromoter.Post_Survey_Category__c = processStringData(columnArray[i]);//columnArray[57]
            i++;
         }else{
           listNetPromoterScore.add(instantNetPromoter);
               continue;
       }
      //column 57/59 - Post-Survey Category Last Updated On
         if(columnArray.size() > i){
           system.debug('--I am inside column array----'+ i);
           instantNetPromoter.Post_Survey_Category_Last_Updated_On__c = ConvertToDateTime(columnArray[i]);
           i++;
         }else{
            listNetPromoterScore.add(instantNetPromoter);
              continue;    
         }  
       //column 58/60 - Do you feel this customer will use us again in the future?
           if(columnArray.size() > i){
               system.debug('--I am inside column array----'+ i);
               instantNetPromoter.Do_you_feel_this_cust_will_use_us_again__c = processStringData(columnArray[i]); //columnArray[58]
               i++;
           }else{
           listNetPromoterScore.add(instantNetPromoter);
               continue;
         }  
       // column 59/61 - Use Again Last Updated On
           if(columnArray.size() > i){
              system.debug('--I am inside column array----'+ i);
              instantNetPromoter.Use_Again_Last_Updated_On__c = ConvertToDateTime(columnArray[i]);
              i++;
           }else{
              listNetPromoterScore.add(instantNetPromoter);
                continue;                   
           }
          
        /*     
           //column 4 - Result Id
           instantNetPromoter.Result_Id__c =  processStringData(columnArray[4]);
           // include in Set for ResultIds
           if(instantNetPromoter.Result_Id__c != null)
             SetResultId.add(instantNetPromoter.Result_Id__c );
                 
           //column 15 - New or Repeat Customer
           if(columnArray.size() > 15)
           instantNetPromoter.New_or_Repeat_Customer__c = processStringData(columnArray[15]);
           else{
               listNetPromoterScore.add(instantNetPromoter);
               continue;
             }
           
           //column 16 - Est or Actual Rental Term 
           if(columnArray.size() > 17){
               system.debug('-------------------columnArray[17]-------------'+ columnArray[17]);
              if(columnArray[17]!= null && columnArray[17]!= '')
              { instantNetPromoter.Est_or_Actual_Rental_Term__c = Double.valueof(columnArray[17]);} 
              // instantNetPromoter.Est_or_Actual_Rental_Term__c = Double.valueof(columnArray[16].substring(0,1) == '"' ? ( ColumnArray[16].substring(1, ColumnArray[16].length()-1) ): columnArray[16]);
           }else{
               listNetPromoterScore.add(instantNetPromoter);
               continue;
             }
            //column 18 - Language
           if(columnArray.size() > 18)        
               instantNetPromoter.Language__c =  processStringData(columnArray[18]);
           else{
               listNetPromoterScore.add(instantNetPromoter);
               continue;
             }
              
       //column 24 - Advertising Source          HFC Status  
       if(columnArray.size() > 24)    
               instantNetPromoter.Advertising_Source__c =  processStringData(columnArray[24]);
           else{
               listNetPromoterScore.add(instantNetPromoter);
               continue;
             }
      
           //column 28 - Account Type  
           if(columnArray.size() > 28)
               instantNetPromoter.Account_Type__c = processStringData(columnArray[28]);
           else{
           listNetPromoterScore.add(instantNetPromoter);
               continue;
             } 

           //column 29 - Account Group
           if(columnArray.size() > 29)
               instantNetPromoter.Account_Group__c = processStringData(columnArray[29]);
             else{
           listNetPromoterScore.add(instantNetPromoter);
               continue;
             }
       //TFS 8491     
      */       
             //comment out :(The knowledge of the salesperson? Remove    
       /*if(columnArray[28]!= null && columnArray[28]!= ''){
               instantNetPromoter.Knowledge_of_salesperson__c =  Double.valueof(columnArray[28]);
       }*/
       
       
       
       //comment out : combine with above : (1)The appearance of our product? ___ remove
      /* if(columnArray[37]!= null && columnArray[37]!= ''){
               instantNetPromoter.Appearance_of_our_product__c =  Double.valueof(columnArray[37]);
       }*/
       //need to chnage here PR-09677
       //comment out : (1)Your satisfaction with the value of our products and services? ___  (remove)
       
       
       //need to chnage here PR-09677
       //comment out : (1)If you had future needs, how likely is it that you will rent [product type(1)] from us again? ___ (remove)
       /*if(columnArray[39]!= null && columnArray[39]!= ''){
               instantNetPromoter.How_likely_you_will_rent_from_us_again__c =  Double.valueof(columnArray[39]);
       }*/
      
            /*
           
                Service 800 has left a series of blank columns inbetween the fields 
                Do you Feel this customer will use us again?
                
                and
                
                Account Type and Account Group
                
                This is to make it "easier" if a new field is added to feed
           
           */
           //column56 - Post-Survey Category3  --> column 59
           
           //column 57 - Post-Survey Category4  --> column 60
           //column 58 - Post-Survey Category5  --> column 61 
           
           //column 59 - Post-Survey #2 Last Updated On  --> column 62
           //column 60 - Post-Survey Comment #2          --> column 63  
           //column 61 - Post-Survey #3 Last Updated On  P  --> column 64
           //column 62 - Post-Survey Comment #3             --> column 65  
                             
    
     /* NPS New Feed Mapping  
       //column 34 - Value of products/services
       if(columnArray.size() > 33){
           if(columnArray[33]!= null && columnArray[33]!= ''){
                 instantNetPromoter.Value_of_products_services__c =  Double.valueof(columnArray[33]); // columnArray[32]
           }
       }else{
           listNetPromoterScore.add(instantNetPromoter);
               continue;
       }

           //column 41 - What is the most important reason?
           if(columnArray.size() > 40)
               instantNetPromoter.What_is_the_most_important_reason__c = processStringData(columnArray[40]);// columnArray[42]
           else{
           listNetPromoterScore.add(instantNetPromoter);
               continue;
       }
           // column 42 - What is the most important reason? Other comments
           if(columnArray.size() > 41)
               instantNetPromoter.What_is_the_most_important_reason_Other__c = processStringData(columnArray[41]);// columnArray[43]
           else{
           listNetPromoterScore.add(instantNetPromoter);
               continue;
       }
      //need to change here PR-09677
      // comment out : How did you hear about us? (Read list and check only one) 
          // instantNetPromoter.How_did_you_hear_about_us__c = processStringData(columnArray[44]);
        
           //instantNetPromoter.How_did_you_hear_about_us_Other_comment__c = processStringData(columnArray[40]); // columnArray[45]
           
           //column 43 - Anything else we can help you with?
           if(columnArray.size() > 42)
               instantNetPromoter.Anything_else_we_can_help_you_with__c =  processStringData(columnArray[42]);// columnArray[46]
           else{
           listNetPromoterScore.add(instantNetPromoter);
               continue;
       }
   
       //column 55 - Post-Survey #1 Last updated on
       if(columnArray.size() > 54)
               instantNetPromoter.Post_Survey_Last_Updated_On__c = ConvertToDateTime(columnArray[54]); //columnArray[55]
           else{
           listNetPromoterScore.add(instantNetPromoter);
               continue;
       }
   */
                     
        }
        System.debug('Debug:Kirtesh****************'+SetSAPBillToId);
        
        listNetPromoterScore.add(instantNetPromoter);
        System.debug('******listNetPromoterScore.size(): ' + listNetPromoterScore.size());
      }
      
      System.debug('Debug:Kirtesh****************'+listNetPromoterScore);
      
      System.debug('Debug:Kirtesh******* Results *********'+SetSAPBillToId);
     // changes for MSM 30 
     List<Account> listAccount = [Select Id ,Branch__c, SAP_Bill_To__c, Servicing_Branch_Id__c, NPS_Status__c from Account Where SAP_Bill_To__c IN : SetSAPBillToId];
      
      Account accountNetPromoter =  [ Select Id from Account Where Name = 'Net Promoter Scores' Limit 1];
      
      for( Account instantaccount : listAccount  ){
      
        //string kKey = instantaccount.Result_ID__c;  // changes for MSM 30
        string kKey = instantaccount.SAP_Bill_To__c;  // changes for MSM 30 
        system.debug('------------- kKey --------------------' + kKey);
        if( ! mapResultIdtoAccountId.containsKey(kKey))
          mapResultIdtoAccountId.put( kKey,instantaccount.Id );
      }
      system.debug('Kirtesh************************mapResultIdtoAccountId'+mapResultIdtoAccountId );
      for( Net_Promoter_Score__c  instantNetPromoter : listNetPromoterScore ){
        // string pKey =  instantNetPromoter.Result_Id__c+'|'+instantNetPromoter.Branch_Id__c ;
        //string pKey =  instantNetPromoter.Result_Id__c;
        string pKey =  instantNetPromoter.SAP_Bill_To__c;
        
        if( mapResultIdtoAccountId.get(pKey) != null  ){
             instantNetPromoter.Account__c = mapResultIdtoAccountId.get(pKey) ;

         /*  if ( ((instantNetPromoter.Hot_Sheet_Generated__c != NULL) && (instantNetPromoter.Hot_Sheet_Generated__c.equalsIgnoreCase('YES'))) || ((instantNetPromoter.Would_you_recommend_us__c != NULL) && (instantNetPromoter.Would_you_recommend_us__c <= 6)) ){
                mapAccountIdtoNPSScore.put(mapResultIdtoAccountId.get(pKey), 'Red');             
             } TFS 5491 */
             //added for T-9062
       //    if((instantNetPromoter.Would_you_recommend_us__c != NULL) && (instantNetPromoter.Would_you_recommend_us__c == 9 || instantNetPromoter.Would_you_recommend_us__c == 10)){
       //  mapAccountIdtoNPSScore.put(mapResultIdtoAccountId.get(pKey), 'Green'); 
      //       }    TFS 5491
             
        }else{
            if( accountNetPromoter.id != null )
              instantNetPromoter.Account__c = accountNetPromoter.Id ;
        }
        
      }
      
      System.debug('Kirtesh************************last'+listNetPromoterScore);
      System.debug('Kirtesh************************Size'+listNetPromoterScore.size());
      // TFS - 7999 : NPS Field mapping - update on NPS
       if(listNetPromoterScore.size() > 0 && setCallDataIds.size() > 0){ 
        
        List<Net_Promoter_Score__c> elistNetPromoterScore = [select Id,CallDataID__c,Post_Survey_Category__c,Post_Survey_Comments__c,Do_you_feel_this_cust_will_use_us_again__c from Net_Promoter_Score__c where CallDataID__c in : setCallDataIds];
        
         if(elistNetPromoterScore.size() > 0){
           List<Net_Promoter_Score__c> tlistNetPromoterScore = new List<Net_Promoter_Score__c>();
           tlistNetPromoterScore.addAll(listNetPromoterScore);
           listNetPromoterScore.clear();    
            
            for(Net_Promoter_Score__c nps : elistNetPromoterScore){
               if(nps.CallDataID__c != null) 
                 mapCallDataIdNPS.put(nps.CallDataID__c,nps);
            }
            
            for(integer i=0; i< tlistNetPromoterScore.size(); i++){
               if(mapCallDataIdNPS.containskey(tlistNetPromoterScore[i].CallDataID__c)){
                  npsObj = mapCallDataIdNPS.get(tlistNetPromoterScore[i].CallDataID__c);
                  tlistNetPromoterScore[i].Id = npsObj.Id;
                  // TFS 8491 ..
                  if(npsObj.Post_Survey_Category__c != null && npsObj.Post_Survey_Category__c != '' && (tlistNetPromoterScore[i].Post_Survey_Category__c == null || tlistNetPromoterScore[i].Post_Survey_Category__c == ''))
                      tlistNetPromoterScore[i].Post_Survey_Category__c = npsObj.Post_Survey_Category__c;
                  if(npsObj.Post_Survey_Comments__c != null && npsObj.Post_Survey_Comments__c != '' && (tlistNetPromoterScore[i].Post_Survey_Comments__c == null || tlistNetPromoterScore[i].Post_Survey_Comments__c == ''))
                      tlistNetPromoterScore[i].Post_Survey_Comments__c = npsObj.Post_Survey_Comments__c;
                  if(npsObj.Do_you_feel_this_cust_will_use_us_again__c != null && npsObj.Do_you_feel_this_cust_will_use_us_again__c != '' && (tlistNetPromoterScore[i].Do_you_feel_this_cust_will_use_us_again__c == null || tlistNetPromoterScore[i].Do_you_feel_this_cust_will_use_us_again__c == ''))
                      tlistNetPromoterScore[i].Do_you_feel_this_cust_will_use_us_again__c = npsObj.Do_you_feel_this_cust_will_use_us_again__c;
                      
                  nlistNetPromoterScore.add(tlistNetPromoterScore[i]);   // for update..
               }else { listNetPromoterScore.add(tlistNetPromoterScore[i]); }     // for insert..
            } 
        }       
      }
     //try{
       
        Database.SaveResult[] srList = Database.Insert(listNetPromoterScore,false);
        
        for(Database.SaveResult sr : srlist)
         { system.debug('Is it successful : ' + sr.isSuccess());
           system.debug('Id of inserted record :' +sr.getId()); 
           system.debug('Insert results error :' + sr.getErrors());
            if(sr.isSuccess() && (sr.getId() != null))  // TFS - 5491
             { NPSIdset.add(sr.getId()); }
            else { noErrors = false; }           
         }
        
        // TFS 7999.. 
        if(nlistNetPromoterScore.size() > 0){
         Database.SaveResult[] nsrList = Database.update(nlistNetPromoterScore,false);
            
         for(Database.SaveResult nsr : nsrList)
          { system.debug('Is it successful : ' + nsr.isSuccess());
            system.debug('Id of updated record :' + nsr.getId());
            system.debug('Update results error :' + nsr.getErrors()); 
              if(nsr.isSuccess() && (nsr.getId() != null))
                NPSIdset2.add(nsr.getId());
              else { noErrors2 = false; }       
          }     
        } 
         
      //}catch(Exception ex){
       
        //System.debug('Kirtesh***********************InsertResult'+ex.getMessage());
      //}
      
      for (integer i=0;i<listAccount.size();i++){
         AccountIdset.add(listAccount[i].Id);
        /*if (mapAccountIdtoNPSScore.get(listAccount[i].Id) != NULL){
            listAccount[i].NPS_Status__c = 'Red';
        }*/
      /*if (mapAccountIdtoNPSScore.get(listAccount[i].Id) != NULL){
      listAccount[i].NPS_Status__c = mapAccountIdtoNPSScore.get(listAccount[i].Id);
        } TFS 5491 */ 
       
      }
     if(noErrors = true)  
     { NPSaccountUpdate(SetSAPBillToId,AccountIdset,NPSIdset); }
     
     // TFS 7999...
      if(noErrors2 == true) 
       { NPSaccountUpdate(SetSAPBillToId,AccountIdset,NPSIdset2); }    
      //update listAccount;    TFS-5491
      //}catch(Exception ex){
      //  System.debug('--------Exception-----'+ex);
     // }
      
  }
    
 /* public Date DatefromString(string strDate){
    if( strDate != null && strDate != ''){
      String[] dateArray = strDate.split('/');
      string stringDate = DateArray[2] + '-' + ( Integer.valueof(DateArray[0]) <10 ? '0'+DateArray[0] : DateArray[0] ) + '-' +(Integer.valueof(DateArray[1]) <10 ? '0'+DateArray[1] : DateArray[1] );
      return Date.valueof(stringDate);
    }
    return null ;
  }*/
  
   // TFS 5491 fix ..
  @future
  public static void NPSaccountUpdate(set<string> SetSAPBillToId,set<Id> AccountIdset,set<Id> NPSIdset)
  { map<String,String> mapAccountIdtoNPSScore = new map<String,String>();
    List<Net_Promoter_Score__c> NpsList = [select Id,Hot_Sheet_Generated__c,Would_you_recommend_us__c,Account__c,SAP_Bill_To__c from Net_Promoter_Score__c where Id =: NPSIdset and Account__c =: AccountIdset and SAP_Bill_To__c =: SetSAPBillToId ];
      
      for(Net_Promoter_Score__c nps : NpsList)
      { if ( ((nps.Hot_Sheet_Generated__c != NULL) && (nps.Hot_Sheet_Generated__c.equalsIgnoreCase('YES'))) || ((nps.Would_you_recommend_us__c != NULL) && (nps.Would_you_recommend_us__c <= 6)) ){
                mapAccountIdtoNPSScore.put(nps.Account__c, 'Red');             
             }
             
             if((nps.Would_you_recommend_us__c != NULL) && (nps.Would_you_recommend_us__c == 9 || nps.Would_you_recommend_us__c == 10)){
                mapAccountIdtoNPSScore.put(nps.Account__c, 'Green'); 
             }
      }
      
    list<account> accList = [select Id,NPS_Status__c from Account where Id IN: mapAccountIdtoNPSScore.keyset()];  
     for(account acc : acclist) 
     {  acc.NPS_Status__c = mapAccountIdtoNPSScore.get(acc.Id); }  
     
     update acclist;
    
 }  
  
  public DateTime ConvertToDateTime(  string strDateTime ){
    System.debug( 'Kirtesh*****************StrDate'+strDateTime);
    
    Integer DD = 0;
    Integer MM = 0;
    Integer Year = 0;
    Integer HH = 0;
    Integer MiM = 0;
    Integer SS = 0;
    
    if( strDateTime != null && strDateTime != '' && strDateTime != '"'){
      string[] stringDateTimeParts = strDateTime.split(' ');
       if( StringDateTimeParts.size() > 0 && StringDateTimeParts[0] != null ){
           string[] DateArray =   stringDateTimeParts[0].split('/');
            if(DateArray.size() == 3){ 
              DD =  Integer.valueOf( Integer.valueof(DateArray[1])< 10 ? '0'+DateArray[1] : DateArray[1] );
              MM =  Integer.valueOf( Integer.valueof(DateArray[0])< 10 ? '0'+DateArray[0] : DateArray[0] );
              year = Integer.valueof(DateArray[2]);
            } 
       }
       
       if( StringDateTimeParts.size() > 1 && StringDateTimeParts[1] != null  ){
          string[] TimeArray =   stringDateTimeParts[1].split(':');
        
        if( StringDateTimeParts.size() > 2 && StringDateTimeParts[2] != null  ){  
          if(StringDateTimeParts[2]== 'AM' ){
              HH  =  Integer.valueOf( TimeArray[0] );
          }else{
              HH  =  Integer.valueOf( TimeArray[0] )+12;
          }
             
          MiM =  Integer.valueOf( TimeArray[1] );
          SS =  Integer.valueOf( TimeArray[2] );
       
        }
       }
       
       return datetime.newInstance(Year, MM , DD , HH , MiM, SS);
    }
    
    return null ;
  }
  
  public string ProcessStringData( string textstring){
        
     string txt = ( textstring!= null && textstring!= '' )?(textstring.substring(0,1) == '"' ? ( textstring.substring(1, textstring.length()-1) ): textstring ):null;
     return txt;
  }
}