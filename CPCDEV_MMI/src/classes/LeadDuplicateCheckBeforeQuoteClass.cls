/*********************************************************************
Name  : LeadDuplicateCheckBeforeQuoteClass
Author: Rajib(TEK)
Date  : JUN 23, 2015
Usage : Used as controller class for LeadDuplicate
*********************************************************************/

public class LeadDuplicateCheckBeforeQuoteClass {
    
    public boolean chkboxFirstName{ get ;set ;}
    public boolean chkboxLastName{ get ;set ;}
    public boolean chkboxphone { get ;set ;}
    public boolean chkboxCompany{ get ;set ;}
    
    
    public string FirstName{ get ;set ;}
    public string LastName{ get ;set ;}
    public string Phone { get ;set ;}
    public string Company{ get ;set ;}
    public string leadId{ get ;set ;}
    public string qType{ get ;set ;}
    
     //Case 36634
    public string address1{ get; set; }
    public string address2{ get; set; }
    public string city{ get; set; }
    public string state{ get; set; }
    public string zip{ get; set; }
    public string country{ get; set; }
    public string dnis {get;set;}
    
    public List<Lead> listLead{ get; set;}
    public List<Contact> listContact{ get ;set ;}
    public List<Account> listAccount{ get ;set ;}
    
    public integer countAccount{ get ;set;}
    public integer countContact{ get ;set;}
    public integer countLead{ get ;set;}
    
    public string saveparameters{get ;set ;}
    public string jobProfileparameter{get ;set ;}    //  MSM 35
    public boolean isValidSearch{ get ;set ;}
    
    public string companyId ;
    public Company__c currentCompany;
    
    private string ppcKeywordParam;
    
    private final Apexpages.StandardController stdController;   
    
    Boolean isETSuser = false;   // TFS 4599
    //set<String> ETSprofileSet = AssignmentRules.getETSnWMIprofileNames();  // TFS 4599
    
    public LeadDuplicateCheckBeforeQuoteClass(){
    	
    	leadId = ApexPages.currentPage().getParameters().get('ldId');
    	qType = ApexPages.currentPage().getParameters().get('qType');
    	system.debug('---------leadId-----'+leadId);
    	if(leadId != null && leadId != ''){
	    	list<Lead> lstLead = [select Id, FirstName, LastName, Phone, Company from Lead where Id = :leadId];
	    	if(lstLead.size() > 0){
		    	FirstName = lstLead[0].FirstName;
		    	LastName = lstLead[0].LastName;
		    	Phone = lstLead[0].Phone;
		    	Company = lstLead[0].Company;
	    	}
    	}
        system.debug('---------FirstName-----'+FirstName);
        system.debug('---------LastName-----'+LastName);
        system.debug('---------Phone-----'+Phone);
        system.debug('---------Company-----'+Company);
        if(FirstName != null && FirstName != ''){
        	chkboxFirstName = true ;
        }
        if(LastName != null && LastName != ''){
        	chkboxLastName = true ;
        }
        if(Phone != null && Phone != ''){
        	chkboxphone = true ;
        }
        if(Company != null && Company != ''){
        	chkboxCompany = true ;
        }
        
        countAccount = 0 ;
        countContact = 0 ;
        listLead= new List<Lead>() ;
        listContact = new  List<Contact> ();
        listAccount  = new List<Account> () ;
        isValidSearch = false ;
        string saveparam;     // MSM 35
        
        //Case 36634
        companyId = ApexPages.currentPage().getParameters().get('CF00N80000004bVA6_lkid');
        
        //fix for PR-07971
        //Phone = ApexPages.currentPage().getParameters().get('lea8') != null ? ApexPages.currentPage().getParameters().get('lea8') : '';
        //dnis = ApexPages.currentPage().getParameters().get('dnisId');
         // MSM 35 starts..
         
        saveparam = '&' + ApexPages.currentPage().getUrl().replace('/apex/LeadDuplicate?','');
        system.debug('---saveparam--'+saveparam);
        saveparameters = saveparam.replace('&save_new=1&sfdc.override=1','');
        System.debug('---Save Paremeters--'+saveparameters);
        jobProfileparameter = ApexPages.currentPage().getUrl().replace('/apex/LeadDuplicate?RecordType=01280000000LynJAAS&retURL=https%3A%2F%2Fna6.salesforce.com%2F',''); 
        
       system.debug('----------------jobProfileparameter--------------'+ jobProfileparameter);
        
        // MSM 35 ends.. 
        
        // TFS 4599..
        /*String userProfileName = [select Profile.Name from User where Id =: Userinfo.getUserId()].Profile.Name;
         if(ETSprofileSet.contains(userProfileName))
          { isETSuser = true; }*/
        
        //case 36634
        if (companyID != null)
        {
            setFields();
        }
        
     }
    
    
    /*public pageReference createNewLead(){
        //Standard Lead
        //String params='&RecordType=012800000007Iul';
        
        string params = '' ;
        
        if( chkboxFirstName == true || chkboxLastName == true  || chkboxphone == true || chkboxCompany == true){
            if(chkboxFirstName == true){
                if( hasMorethanTwoCharacter( FirstName) ){
                    params +=('&name_firstlea2=' + encodeChars(FirstName));
                }
            }
            if(chkboxLastName == true){
                if( hasMorethanTwoCharacter( LastName) ){
                    params += ('&name_lastlea2=' + encodeChars(LastName));
                }
            }
            
            if(chkboxphone == true){
                if( hasMorethanTwoCharacter( Phone) ){
                    params += ('&lea8=' +  encodeChars(Phone));
                }
            }
            if(chkboxCompany == true){
                if( hasMorethanTwoCharacter( encodeChars(Company)) ){
                    params += ('&lea3=' +  encodeChars(Company));
                }
            }
           
           //Case 36634
           if(address1 != null && address1.length() > 0){
               if (address2 != null && address2.length() > 0){
                    params += ('&lea16street=' + encodeChars(address1 + ' ' + address2)); 
               }
           
               else{
                   params += ('&lea16street=' + encodeChars(address1));
               }
           }
       
           if(city != null && city.length() > 0){
                params += ('&lea16city=' + encodeChars(city)); 
           }
       
           if(state != null && state.length() > 0){
                params += ('&lea16state=' + encodeChars(state)); 
           }
       
           if(zip != null && zip.length() > 0){
                params += ('&lea16zip=' + encodeChars(zip)); 
           }
       
           if(country != null && country.length() > 0){
                params += ('&lea16country=' + encodeChars(country)); 
           }
           //end Case 36634
       
            ppcKeywordParam = getppcKeywordParam();
            if(ppcKeywordParam != null && ppcKeywordParam.length() > 0){
                params += ('&'+ppcKeywordParam);
            }
            
        }
        if(dnis != null && dnis != ''){
             params += ('&00N800000042rYJ=' + encodeChars(dnis));
        }
       
       if(jobProfileparameter.length() >1 && jobProfileparameter.startswith('a0T') )
         {  
            Job_Profile__c jb = [select id, name from Job_Profile__c where id = : jobProfileparameter ]; 
              system.debug('--------------jb------------'+jb.name); 
            
            params += ('&00N80000003Md4O=1&CF00N800000057Ocu='+ encodeChars(jb.name));      
         } 
       return new PageReference('/00Q/e?nooverride=1'+ params+'&FwdURL='+saveparameters) ;
    }*/
    
    
    public pageReference redirectToQuote(){
    
    	if(qType == 'fq'){
    		return new PageReference('/apex/FullQuoteForm_VF?id='+leadId);
    	}
    	if(qType == 'qq'){
    		return new PageReference('/apex/QuickQuoteMain_VF?recId='+leadId);
    	}
    	return null;
    }
    
    public pageReference customSearch(){
      listLead = new list<Lead>();
      listContact = new  List<Contact> ();
      listAccount  = new List<Account> () ;
      boolean isFirst = false ;
      Id leadRectype = AssignmentRules.getETSWMIrectypeID('Lead');   // TFS 4599..
      Id accRectype = AssignmentRules.getETSWMIrectypeID('Account');   // TFS 4599..
      
      //Case # 00044212 Start
      String unEscapedLastName = LastName;
      String unEscapedFirstName = FirstName;
      String unEscapedPhone = Phone;
      if(LastName != null && LastName != ''){
      	LastName = String.escapeSingleQuotes(LastName);
      }
      if(FirstName != null && FirstName != ''){
      	FirstName = String.escapeSingleQuotes(FirstName);
      }
      if(Phone != null && Phone != ''){
      	Phone = String.escapeSingleQuotes(Phone);
      }
      //Case # 00044212 End
      
      //Lead Query 
      String leadQuery = 'Select Id , Name , Branch__c, title, phone, company , Email ,Status, RecordTypeId, Owner.Name, OwnerId From Lead Where ';
      
      //Contact Query
      string contactQuery = 'Select Id , Name ,Branch__c, AccountId, Account.Name , Fax, Phone, Email , Account.RecordTypeId, OwnerId, Owner.Name from Contact Where ';
      
      //Account Query 
      string accountQuery = 'Select Id , Name , Branch__c,  billingcity , billingstate, Parent.Name , parentId ,  Phone , RecordTypeId, OwnerId, Owner.Name , Result_Id__c from Account Where ';
      
      if( chkboxFirstName == true || chkboxLastName == true  || chkboxphone == true || chkboxCompany == true){
      
         if( chkboxFirstName == true){
             
             if( ! hasMorethanTwoCharacter( FirstName) ){
                
                errorMessage( 'First Name should have  minimum 2 character' );
                return null ;
             }
             
             isFirst = true ;
             leadQuery = leadQuery+'  FirstName  like \'' + FirstName + '%\'  ' ;
             contactQuery = contactQuery+'  FirstName  like \'' + FirstName + '%\'  ' ;
             accountQuery = accountQuery+'  FirstName  like \'' + FirstName + '%\'  ' ;
         }
                 
         if( chkboxLastName == true){
            
            if( ! hasMorethanTwoCharacter( LastName)){
              
              errorMessage( 'Last Name should have minimum 2 character' );
              return null ;
            }
            
            if( isFirst == false){
              isFirst = true ;
              leadQuery = leadQuery+'  LastName like \'' + LastName + '%\'  ' ;
              contactQuery = contactQuery+'  LastName like \'' + LastName + '%\'  ' ;
              accountQuery = accountQuery+'  LastName like \'' + LastName + '%\'  ' ;
            }else{
              leadQuery = leadQuery+' AND LastName like \'' + LastName + '%\'  ' ;
              contactQuery = contactQuery+' AND LastName like \'' + LastName + '%\'  ' ;
              accountQuery = accountQuery+' AND  LastName like \'' + LastName + '%\'  ' ;
            }
         
         }
      
         if(chkboxCompany == true ){
             
            if( ! hasMorethanTwoCharacter(Company)){
               errorMessage( 'Company should have minimum 2 character');
               return null ;
            } 
            
            string qCompany  = Company.replaceAll('\'','\\\\\'');
            
            if(isFirst == false){
                isFirst = true ;
                leadQuery = leadQuery+'  Company like \'' + qCompany + '%\'  ';
                contactQuery = contactQuery+'  Account.Name like \'' + qCompany + '%\'  ';
                accountQuery = accountQuery+'  Name like \'' + qCompany+ '%\'  ' ;
            }else{
               leadQuery = leadQuery+' AND Company like \'' + qCompany + '%\'  ';
               contactQuery = contactQuery+' AND Account.Name like \'' + qCompany + '%\'  ';
               accountQuery = accountQuery+' AND  Name like \'' + qCompany+ '%\'  ' ;
            }
         }
        
         if( chkboxphone == true){
             
            if( ! hasMorethanTwoCharacter(Phone)){
              errorMessage( 'Phone should have minimum 2 character' );
              return null ;
            } 
            
             /*
             if(isFirst == false){
               isFirst = true ;
               string duplicatephone = makeDuplicatePhone(phone);
               if( duplicatephone == ''){
                 leadQuery = leadQuery+'  Phone like \'' + Phone+ '%\'  ' ;
                 contactQuery = contactQuery+'  Phone like \'' + Phone+ '%\'  ' ;
                 accountQuery = accountQuery+'  Phone like \'' + Phone+ '%\'  ' ;
               }else{
                 leadQuery = leadQuery+'  Phone like \'' + Phone+ '%\'  OR  Phone like \'' + duplicatephone+'%\' ' ;
                 contactQuery = contactQuery+'  Phone like \'' + Phone+ '%\'   OR  Phone like \'' + duplicatephone+'%\' ' ;
                 accountQuery = accountQuery+'  Phone like \'' + Phone+ '%\'  OR  Phone like \'' + duplicatephone+'%\' ' ;
               }
             }else{
               string duplicatephone = makeDuplicatePhone(phone);
               
               if( duplicatephone == ''){
                 leadQuery = leadQuery+' AND Phone like \'' + Phone + '%\'  ' ;
                 contactQuery = contactQuery+' AND Phone like \'' + Phone + '%\'  ' ;
                 accountQuery = accountQuery+' AND Phone like \'' + Phone+ '%\'  ' ;
               }else{
                 leadQuery = leadQuery+' AND ( Phone like \'' + Phone+ '%\'  OR  Phone like \'' + duplicatephone+'%\' )' ;
                 contactQuery = contactQuery+'  AND ( Phone like \'' + Phone+ '%\'   OR  Phone like \'' + duplicatephone+'%\') ' ;
                 accountQuery = accountQuery+' AND ( Phone like \'' + Phone+ '%\'  OR  Phone like \'' + duplicatephone+'%\' )' ;
               
               }
             }
              */
              
            if(isFirst == false){
               isFirst = true ;
               string duplicatephone = utils.processNumericPhone(phone);
               if( duplicatephone == ''){
                 leadQuery = leadQuery+'  Phone like \'' + Phone+ '%\'  ' ;
                 contactQuery = contactQuery+'  Phone like \'' + Phone+ '%\'  ' ;
                 accountQuery = accountQuery+'  Phone like \'' + Phone+ '%\'  ' ;
               }else{
                 leadQuery = leadQuery+'  Phone like \'' + Phone+ '%\'  OR  Numericphone__c like \'' + duplicatephone+'%\' ' ;
                 contactQuery = contactQuery+'  Phone like \'' + Phone+ '%\'   OR  Numericphone__c like \'' + duplicatephone+'%\' ' ;
                 accountQuery = accountQuery+'  Phone like \'' + Phone+ '%\'  OR  Numericphone__c like \'' + duplicatephone+'%\' ' ;
               }
             }else{
               string duplicatephone = utils.processNumericPhone(phone);
               
               if( duplicatephone == ''){
                 leadQuery = leadQuery+' AND Phone like \'' + Phone + '%\'  ' ;
                 contactQuery = contactQuery+' AND Phone like \'' + Phone + '%\'  ' ;
                 accountQuery = accountQuery+' AND Phone like \'' + Phone+ '%\'  ' ;
               }else{
                 leadQuery = leadQuery+' AND ( Phone like \'' + Phone+ '%\'  OR  Numericphone__c like \'' + duplicatephone+'%\' )' ;
                 contactQuery = contactQuery+'  AND ( Phone like \'' + Phone+ '%\'   OR  Numericphone__c like \'' + duplicatephone+'%\') ' ;
                 accountQuery = accountQuery+' AND ( Phone like \'' + Phone+ '%\'  OR  Numericphone__c like \'' + duplicatephone+'%\' )' ;
               
               }
             }
          
          }
         
         // TFS 4599..
         if(isETSuser)
         {  leadQuery = leadQuery+' AND RecordTypeId =: leadrectype';
            //contactQuery = contactQuery+' AND Account.RecordTypeId =: accRectype';
            accountQuery = accountQuery+' AND RecordTypeId =: accRectype'; 
         }
         
         
         leadQuery = leadQuery+'  Limit 999' ;
         contactQuery = contactQuery+ ' Limit 999' ;
         accountQuery = accountQuery+ ' Limit 999' ;
         System.debug('Kirtesh:Debug:leadQuery***************************'+leadQuery);
         System.debug('Kirtesh:Debug:contactQuery***************************'+contactQuery);
         System.debug('Kirtesh:Debug: accountQuery ***************************'+ accountQuery );
         
         listLead = Database.Query(leadQuery);
         listContact = Database.Query(contactQuery);
         listAccount = Database.Query(accountQuery); 
         
         isValidSearch  = true ;          
      }
      
      
      
      
      countLead = listLead.size() ;
      countContact = listContact.size();
      countAccount = listAccount.size();
      
      //Case # 00044212 Start assigning back the values entered in text box as it is
      LastName = unEscapedLastName;
      FirstName = unEscapedFirstName;
      Phone = unEscapedPhone;
      //Case # 00044212 End
      
      return null ;
    }
    
    
    public pageReference Cancel(){
      
      return new PageReference('/'+leadId) ;
    }
    
    
    public boolean hasMorethanTwoCharacter( string fieldValue ){
       if (  fieldValue.Length() < 2    )
          return false ;
       else 
          return true ;
    }
    
    public void errorMessage( string messagefordisplay){
       ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.ERROR, messagefordisplay );
       ApexPages.addMessage(msg);
    }
    
    public String encodeChars(String param){
    
        param = param.replaceAll('&', '%26');
        //param = param.replaceAll('+', '%2B');
        param = param.replaceAll('#', '%23');
        param = param.replaceAll(',', '%2C');
        //param = param.replaceAll('$', '%24');
        param = param.replaceAll(':', '%3A');
        param = param.replaceAll(';', '%3B');
        param = param.replaceAll('=', '%3D');
        //param = param.replaceAll('?', '%3F');
        param = param.replaceAll('@', '%40');
        param = param.replaceAll('<', '%3C');
        param = param.replaceAll('>', '%3E');
        //param = param.replaceAll('%', '%25');
        param = param.replaceAll(' ', '%20');
        
        return param;
    
    }
    
    public String getppcKeywordParam(){
        String ppcParam = '';
        if(saveparameters.length() > 0 && saveparameters.contains('00N800000042rYJ')){
            String[] splitSaveParams = saveparameters.split('&');
            if(splitSaveParams.size() > 1){
                for(String param : splitSaveParams){
                    if(param.startsWith('00N800000042rYJ')){
                        ppcParam = param;
                        saveparameters = saveparameters.replace(param,'');
                        break;
                    }
                }
            }else if(splitSaveParams.size() == 1){
                ppcParam = splitSaveParams[0];
                saveparameters = saveparameters.replace(ppcParam,'');
            }
        } 
        return ppcParam;
    }
    
    //Case 36634
    public void setFields()
    {
        currentCompany = [SELECT Company_Name__c, First_Name__c, Last_Name__c, Phone__c, Address_1__c, Address_2__c, City__c, State__c, Zip__c, Country__c FROM Company__c WHERE Id =:companyId];
        FirstName = currentCompany.First_Name__c;
        LastName = currentCompany.Last_Name__c;
        Phone = currentCompany.Phone__c;
        Company = currentCompany.Company_Name__c;
        address1 = currentCompany.Address_1__c;
        address2 = currentCompany.Address_2__c;
        city = currentCompany.City__c;
        state = currentCompany.State__c;
        zip = currentCompany.Zip__c;
        country = currentCompany.Country__c;
    }
    
    /*
    public string makeDuplicatePhone(string tphone){
      string localPhone = tphone.trim();
      string duplicatePhone = '' ;
      
      if(localPhone.contains('(') && localPhone.contains(')') && localPhone.contains('-')){
        
        for( integer i = 0 ; i < localPhone.length() ; i++){
          if( localPhone.substring(i, i+1) != '(' &&  localPhone.substring(i, i+1) != ')' && localPhone.substring(i, i+1) != '-' 
              && localPhone.substring(i, i+1) != (' ')){
             duplicatePhone = duplicatePhone+localPhone.substring(i, i+1);
          }
        }
        return duplicatePhone ;
      
      }else if( localPhone.length() == 10 &&  
                ( !(localPhone.contains('(') || localPhone.contains(')') || localPhone.contains('-') ))
              ){
         for( integer i = 0 ; i < localPhone.length() ; i++){
             
             if( i == 0)
               duplicatePhone = '('+localPhone.substring(i, i+1);
             else if( i == 2)
               duplicatePhone = duplicatePhone+localPhone.substring(i, i+1)+') ';
             else if( i == 5)
               duplicatePhone =  duplicatePhone+localPhone.substring(i, i+1)+'-';
             else
               duplicatePhone  = duplicatePhone+localPhone.substring(i, i+1) ; 
         } 
        
         return duplicatePhone ;
      }
      
       return duplicatePhone ;
   }
   */
   
}