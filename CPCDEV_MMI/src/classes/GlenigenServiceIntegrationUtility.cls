/*********************************************************************************
Name :          GlenigenServiceIntegrationUtility 
Created By :    Appirio [Bharti Mehta]
Created Date :  12 Aug 2012
Description :   Utility class to Glenigan Info integration
*********************************************************************************/
public without sharing class GlenigenServiceIntegrationUtility  {


    public enum DataType {PROJECT,BIDDER,UPDATELASTLOGIN}    
    public static final String HOT_RATING = 'Hot (Probably Order)';
    public static final String UK_CURRENCY = 'GBP';
    
    public static Id gleniganRecordTypeId;
     
     static{
        Schema.DescribeSObjectResult leadDescribe = Schema.SObjectType.Lead;
        Map<String,Schema.RecordTypeInfo> leadRTByName = leadDescribe.getRecordTypeInfosByName();
        Schema.RecordTypeInfo leadGleniganRecordTypeInfo = leadRTByName.get('Glenigan Lead');
        gleniganRecordTypeId = leadGleniganRecordTypeInfo.getRecordTypeId();
     }       
    
    //------------------------------------------------------------------
    // Static variables
    //------------------------------------------------------------------
    public static String authToken{
     get{
        if(authToken == null){authToken = getAuthenticationToken();}
        return authToken;
     }  
     set;}
     
    
        
    //------------------------------------------------------------------
    // Future call to pull and insert all new Glenigan Projects
    //------------------------------------------------------------------
   @future(callout = true)
    public static void migrateNewProjects(){
    	//-------------------TFS 3456------Starts--------------------------------------------------------
      	AllThirdPartyEndPoints__c AllThirdPartyEndPointUrl = AllThirdPartyEndPoints__c.getInstance('ThirdPartyEndPoints');
      	String endPoint = '';
      	if(AllThirdPartyEndPointUrl != null){
      		endPoint = AllThirdPartyEndPointUrl.GleniganApiNewProjects__c;
      	}
        //String endPoint = 'http://www.gleniganapi.com/InsightApi/Projects?$format=json&projectType=NewProjects';// Commented for TFS 3456
        //-------------------TFS 3456------Ends--------------------------------------------------------
        migrateProjects(endPoint);     
    }
    
    //------------------------------------------------------------------
    // Future call to pull and update all exsiting Glenigan Projects
    //------------------------------------------------------------------
    @future(callout = true)
    public static void migrateExistingProjects(){
    	//-------------------TFS 3456------Starts--------------------------------------------------------
      	AllThirdPartyEndPoints__c AllThirdPartyEndPointUrl = AllThirdPartyEndPoints__c.getInstance('ThirdPartyEndPoints');
      	String endPoint = '';
      	if(AllThirdPartyEndPointUrl != null){
      		endPoint = AllThirdPartyEndPointUrl.GleniganApiExistingProjects__c;
      	}
        //String endPoint = 'http://www.gleniganapi.com/InsightApi/Projects?$format=json&projectType=UpdatedProjects';// Commented for TFS 3456
        //-------------------TFS 3456------Ends--------------------------------------------------------
        migrateProjects(endPoint);   
    }
    
    //------------------------------------------------------------------
    // Future call to pull and unsert all Glenigan bidders
    //------------------------------------------------------------------
    @future(callout = true)
    public static void migrateBidders(){
        //String endPoint = 'http://www.gleniganapi.com/InsightApi/Projects?$format=json&projectType=UpdatedProjects';
        //-------------------TFS 3456------Starts--------------------------------------------------------
      	AllThirdPartyEndPoints__c AllThirdPartyEndPointUrl = AllThirdPartyEndPoints__c.getInstance('ThirdPartyEndPoints');
      	String endPoint = '';
      	if(AllThirdPartyEndPointUrl != null){
      		endPoint = AllThirdPartyEndPointUrl.GleniganApiMigrateBidders__c;
      	}
        //String endPoint = 'http://www.gleniganapi.com/InsightApi/CompaniesInProjectRole?$format=json&$filter=RoleDescription%20eq%20\'Bidder\' ';// Commented for TFS 3456
        //-------------------TFS 3456------Ends-------------------------------------------------------- 
        migrateBidder(endPoint);        
    }
    
    //------------------------------------------------------------------
    // Future call to update last login
    // Added By : Barkha Jain
    //------------------------------------------------------------------
    @future(callout = true)
    public static void updateLastLogin(){
    	//-------------------TFS 3456------Starts--------------------------------------------------------
      	AllThirdPartyEndPoints__c AllThirdPartyEndPointUrl = AllThirdPartyEndPoints__c.getInstance('ThirdPartyEndPoints');
      	String endPoint = '';
      	if(AllThirdPartyEndPointUrl != null){
      		endPoint = AllThirdPartyEndPointUrl.GleniganApiUpdateLastLogin__c;
      	}
        //String endPoint = 'http://www.gleniganapi.com/InsightAPI/UpdateLastLogin?$format=json';// Commented for TFS 3456
        //-------------------TFS 3456------Ends--------------------------------------------------------
        String jasonReponse = getResponse(endPoint);    
    }
    
    
    public static void createHotLeads(List<Glenigan_Bidder__c> bidders){
        List<Lead> hotLeads = new List<Lead>();
        Set<Id> projectIds = new Set<Id>();        
        Set<String> cyNoSet = new Set<String>();
        
        for(Glenigan_Bidder__c bidder : bidders){
            projectIds.add(bidder.Glenigan_Project__c);
            if(bidder.cyno__c != null){
                system.debug('====bidder.cyno__c=== ' + bidder.cyno__c);
                cyNoSet.add(bidder.cyno__c.intValue().format().replaceAll(',',''));
            }
        }
        
        Map<Id,Glenigan_Project__c> mapProjects = new Map<Id,Glenigan_Project__c>([Select Id,Ptpcode__c,Ptsite1__c,Ptsite2__c,Ptsite3__c,Ptsite4__c,Site_Country__c
                                                                                    From Glenigan_Project__c Where Id IN : projectIds]);
        Map<String, Account> existingCyNoAccount = loadAccount(cyNoSet);
        
        for(Glenigan_Bidder__c bidder : bidders){
            hotLeads.add(createLead(bidder,mapProjects.get(bidder.Glenigan_Project__c),bidder.Cyno__c != null ? existingCyNoAccount.get(bidder.cyno__c.intValue().format().replaceAll(',','')) : null));
        }
        
        insert hotLeads;
    }
    
    private static Lead createLead(Glenigan_Bidder__c bidder ,Glenigan_Project__c project,Account existingCyNoAccount){
        Lead hotLead = new Lead();
        hotLead.Glenigan_Bidder__c = bidder.id;
        hotLead.Salutation = bidder.Design__c;
        hotLead.FirstName = bidder.Fname__c;
        hotLead.LastName = (bidder.Lname__c == NULL || bidder.Lname__c == '')? 'Unknown':bidder.Lname__c;       
        hotLead.Company = bidder.Cyname__c;
        hotLead.Email = bidder.Email__c;
        hotLead.Phone = (bidder.PnPhone__c != NULL && bidder.PnPhone__c != '')? bidder.PnPhone__c :bidder.Cyphone__c;
        hotLead.Street = (bidder.Cyaddr1__c != null ? bidder.Cyaddr1__c : '')  + (bidder.Cyaddr2__c != null ? bidder.Cyaddr2__c : '') ;
        hotLead.City    = bidder.Cyaddr4__c;
        hotLead.State = (bidder.Cyaddr3__c!= null && bidder.Cyaddr3__c.length() > 20)?bidder.Cyaddr3__c.substring(0, 20):bidder.Cyaddr3__c;
        hotLead.PostalCode = bidder.Cypcode__c;     
        hotLead.Bidder_Postal_Code__c = bidder.Cypcode__c;
        hotLead.Primary_Contact_Method__c = bidder.PnPhone__c!= null ? 'Phone' : (bidder.Email__c != null? 'Email' : hotLead.Primary_Contact_Method__c);        
        hotLead.Glenigan_Project__c = bidder.Glenigan_Project__c;
        hotLead.CurrencyISOCode = UK_CURRENCY;
        
        if(project != null){
            hotLead.Delivery_Postal_Code__c = project.Ptpcode__c;
            hotLead.Delivery_City__c = project.Ptsite4__c;
            //hotLead.Delivery_State__c = project.Ptsite3__c;
            hotLead.Delivery_Country__c = project.Site_Country__c;
            hotLead.Delivery_Street__c = (project.Ptsite2__c != null || project.Ptsite3__c != null) ? (project.Ptsite2__c + project.Ptsite3__c) : '';
        }else{
            hotLead.Country = 'UK';
        }
  
        
        hotLead.Auto_Assign_Lead__c = true;
        hotLead.Status =    'Open';
        hotLead.Rating = HOT_RATING;
        hotLead.LeadSource = 'Glenigan';        
        hotLead.RecordTypeId = gleniganRecordTypeId;
        if(existingCyNoAccount != null ){
            hotLead.OwnerId = existingCyNoAccount.OwnerId;
            hotLead.Auto_Assign_Lead__c = false;
         }
        
        return hotLead;     
    }
    
    
    public static Map<String, Account> loadAccount(Set<String> cyNoSet){
        String query = ' Select Id , Glenigan_Company_Id__c, OwnerId from Account'; 
        Map<String, Account>  accountMap = new Map<String, Account>();
        Boolean isWhere = false;
        String dynamicQuery = '';
        for(String cyn : cyNoSet){
            if(isWhere){
                dynamicQuery += ' or ';
            }else{
                dynamicQuery += ' Where ';
                isWhere = true;
            }
            dynamicQuery += ' Glenigan_Company_Id__c like \'%'+ cyn +';%\'';
        }
        
        system.debug('=================' + dynamicQuery );
        if(dynamicQuery.length() > 0){
            String mainQuery = query + dynamicQuery;
            system.debug('=================' + mainQuery );
            //system.debug('=================' + Database.query(mainQuery) );
            for(Account acc : Database.query(mainQuery)){
                List<String> abiCompanies = acc.Glenigan_Company_Id__c.split(';');
                for(String abiCom : abiCompanies){
                    accountMap.put(abiCom,acc);
                }
            }
        }
        System.debug('--Account Map--'+accountMap);
        return accountMap;
      }   
      
    //------------------------------------------------------------------
    // Private helper methods
    //------------------------------------------------------------------
    
    //Calls webservice for the Endpoint and return response
    public static String getResponse(String endPoint){
         try{
             // Create a new http object to send the request object 
             HttpRequest req = new HttpRequest();
             //req.setEndpoint('http://www.gleniganapi.com/InsightApi/ProjectDetail(11140)?$format=json&$expand=GroupProjectRoles/ProjectRoles/CompaniesInProjectRole');
             req.setEndpoint(endPoint);
             req.setMethod('GET');               
             //set auth token to cookies
             req.setHeader('Cookie','.ASPXAUTH=' + authToken);
           
            
             // A response object is generated as a result of the request           
          
             Http http = new Http();
             HTTPResponse res = http.send(req);
             return res.getBody();
         }catch(Exception e){}
         return '';
    }
    
    // pulls and inserts all new Glenigan Projects
    public static String getAuthenticationToken(){       
        HttpRequest req = new HttpRequest();
          //authorization token for Username SarahL_7621 and password SarahL4761.
          //-------------------TFS 3456------Starts--------------------------------------------------------
      	AllThirdPartyEndPoints__c AllThirdPartyEndPointUrl = AllThirdPartyEndPoints__c.getInstance('ThirdPartyEndPoints');
      	req.setEndpoint(AllThirdPartyEndPointUrl.GleniganApiGetAuthenticationToken__c);
        //req.setEndpoint('http://www.gleniganapi.com/InsightApi/AuthenticationToken?$format=json&u=SarahL_7621&p=SarahL4761');// Commented for TFS 3456
        //-------------------TFS 3456------Ends--------------------------------------------------------
         req.setMethod('GET');
         Http http = new Http();
         HTTPResponse res = http.send(req);
         String jasonReponse = res.getBody();
         System.JSONParser jasonParser = System.Json.createParser(jasonReponse);
         
         while(jasonParser.nexttoken() != null){
            if(jasonParser.getText() == 'Token'){
                jasonParser.nexttoken();
                return jasonParser.getText();
                break;
            }           
         }
         return null;
    }
    
     // pulls and upserts all new Glenigan Projects
    private static void migrateProjects(String endPoint){
        String jasonReponse = Test.isRunningTest()? createDummyResponse(DataType.PROJECT) : getResponse(endPoint);
        
        //System.debug('jasonReponse=============' + jasonReponse );
        
        System.JSONParser jasonParser = System.Json.createParser(jasonReponse.replaceAll('__',''));
        
        //System.debug('=============' + jasonParser );
        List<Glenigan_Project__c> gleniganProjects = new List<Glenigan_Project__c>();
        
        while(jasonParser.nexttoken() != null){
            if(jasonParser.getText() == 'results')break;            
        }
        
        while(jasonParser.nexttoken() != null){         
            if (jasonParser.getCurrentToken() == JSONToken.START_OBJECT) {
                Glenigan_Project__c project = createProject(jasonParser);
                gleniganProjects.add(project);
            }
        }
        
       upsert gleniganProjects Ptno__c;         
        System.debug('=============' + gleniganProjects );
    }
    
    // pulls and upsert all new Glenigan bidders
    private static void migrateBidder(String endPoint){
        String jasonReponse = Test.isRunningTest()? createDummyResponse(DataType.BIDDER) : getResponse(endPoint);
        
        //System.debug('jasonReponse=============' + jasonReponse );
        
        System.JSONParser jasonParser = System.Json.createParser(jasonReponse.replaceAll('__',''));
        
        //System.debug('=============' + jasonParser );
        List<Glenigan_Bidder__c> gleniganBidders = new List<Glenigan_Bidder__c>();
        
        while(jasonParser.nexttoken() != null){
            if(jasonParser.getText() == 'results')break;            
        }
        
        while(jasonParser.nexttoken() != null){         
            if (jasonParser.getCurrentToken() == JSONToken.START_OBJECT) {
                Glenigan_Bidder__c bidder = createBidder(jasonParser);
                if(bidder != null)
                    gleniganBidders.add(bidder);
            }
        }
        
      system.debug('=============' + gleniganBidders);
      // upsert gleniganBidders Cyno__c;    
      Integer i = 0;
      List<Glenigan_Bidder__c> failedgleniganBidders = new List<Glenigan_Bidder__c>();
      try {
       
      for(Database.Upsertresult result : Database.upsert(gleniganBidders,Glenigan_Bidder__c.Fields.ExternalId__c,false)){
            if(!result.isCreated()){                
                //system.debug('===========' + result);
                for(Database.Error error : result.getErrors()){                     
                    String errMsg = error.getMessage();
                    system.debug('====' + errMsg);
                    if(errMsg.contains('Glenigan_Project__c')){
                        Glenigan_Bidder__c gemBidder = gleniganBidders.get(i);
                        gemBidder.Glenigan_Project__r = null;
                        failedgleniganBidders.add(gemBidder);  
                        break;
                    } 
                }
                
            }
            i++;
      } 
      
      system.debug('failedgleniganBidders---------------'+failedgleniganBidders);      
      Database.upsert(failedgleniganBidders,Glenigan_Bidder__c.Fields.ExternalId__c,false);  
      
      }catch(Exception e){
        system.debug('failedgleniganBidders---------------'+e.getmessage());
      }
      //System.debug('=============' + gleniganBidders );
    }
            
    private static Glenigan_Project__c createProject(System.JSONParser jasonParser){
        Glenigan_Project__c project = new Glenigan_Project__c();
        Porject proj = (Porject)jasonParser.readValueAs(Porject.class);
        jasonParser.skipChildren();
        project = proj.getProject();
        return project;
    }
    private static Glenigan_Bidder__c createBidder(System.JSONParser jasonParser){
        Glenigan_Bidder__c bidders = new Glenigan_Bidder__c();
        bidder bid = (bidder)jasonParser.readValueAs(bidder.class);
        jasonParser.skipChildren();
        bidders = bid.getBidder();
        return bidders;
    }
    
    //------------------------------------------------------------------
    // Wrapper classes
    //------------------------------------------------------------------    
    public class Porject{
        public String SiteAddressLine1;
        public String SiteAddressLine2;
        public String SiteAddressLine3;
        public String DisplayAddress;
        public String Postcode;
        public String PlanningStageDescription;
        public Integer projectId;
        public String Value;
        public String Heading;
        public String DevelopmentTypeDescription;
        public String Updated;
        public String SiteAddress;
        public String ConstructionPeriodDescription;
        public String ConstructionPeriodStart;
        public String ConstructionPeriodEnd;
        
        public Glenigan_Project__c getProject(){
            Glenigan_Project__c project = new Glenigan_Project__c();
            
            project.Ptsite1__c = this.DisplayAddress;
            project.Ptpcode__c = this.Postcode; 
            project.Stage__c = this.PlanningStageDescription;
            project.Ptno__c = this.projectId;
            project.Ptsite2__c = this.SiteAddressLine1;
            project.Ptsite3__c = this.SiteAddressLine2;
            project.Ptsite4__c = this.SiteAddressLine3;
            project.Value__c = this.Value != null ? (Decimal.valueOf(this.Value) * 1000000) : null;
            project.Pttitle__c = this.Heading;
            project.Devtype__c = DevelopmentTypeDescription;
            project.Reportdate__c = Updated != null ? datetime.newInstance(long.valueOf(Updated.subString(updated.indexOf('(') + 1, Updated.indexOf(')')))).date(): null;
            project.Startdate__c = this.ConstructionPeriodStart;
            project.Finish__c = this.ConstructionPeriodEnd;
            project.Period__c = this.ConstructionPeriodDescription;
            project.CurrencyISOCode = UK_CURRENCY;
            return project;
        }
    }
    
    public Class bidder {
        public Integer projectId;
        public String RoleDescription;
        public String OfficeName;
        public Integer OfficeId;
        public String OfficeUrl;
        public String FaxNumber;
        public String Email;
        public String Postcode;
        public String AddressLine1;
        public String AddressLine2;
        public String AddressLine3;
        public String PhoneNumber; 
        public Integer RoleId;
        public Integer RoleGroupId;
        public Glenigan_Bidder__c getBidder(){
            if(this.OfficeId == null)
                return null;
            
            Glenigan_Project__c proj = new Glenigan_Project__c(Ptno__c = projectId);
            Glenigan_Bidder__c bidder = new Glenigan_Bidder__c();
            bidder.Glenigan_Project__r = proj;
            bidder.Role__c = this.RoleDescription;
            bidder.Cyname__c = this.OfficeName;
            bidder.Cyno__c = this.OfficeId != null ? Decimal.valueOf(this.OfficeId):null;
            bidder.Cyurl__c = this.OfficeUrl;
            bidder.Cyfax__c = this.FaxNumber;
            bidder.Email__c = this.Email;
            bidder.Cypcode__c = this.Postcode; 
            bidder.Cyaddr2__c = this.AddressLine1;
            bidder.Cyaddr3__c = this.AddressLine2; 
            bidder.Cyaddr4__c = this.AddressLine3;
            bidder.Cyphone__c = this.PhoneNumber; 
            bidder.RoleId__c = this.RoleId != null ? Decimal.valueOf(this.RoleId):null;
            bidder.RoleGroupId__c = this.RoleGroupId != null ? Decimal.valueOf(this.RoleGroupId):null;
            String externalId = projectId + '~' + bidder.Cyno__c + '~' + bidder.RoleId__c + '~' + bidder.RoleGroupId__c;
            bidder.externalId__c = externalId;
            bidder.CurrencyISOCode = UK_CURRENCY;
            return bidder;
        }
        
        
         
    }
    
    public static String createDummyResponse(DataType dataType1){
        if(dataType1 == DataType.PROJECT)
            return '{"d" : {"results": [{"__metadata": {"uri": "http://www.gleniganapi.com/InsightApi/Projects(509968334)", "type": "InsightInfrastructure.Poco.Project"}, "ProjectId": 509968334, "ProjectMaterialCategories": {"__deferred": {"uri": "http://www.gleniganapi.com/InsightApi/Projects(5099683)/ProjectMaterialCategories"}}, "DisplayDescription": "Scheme comprises construction of 10 holiday chalets, plus ancillary office and caretakers flat, with environmental city garden. The associated works include access roads, enabling, infrastructure, landscaping and sewer systems.", "DisplayAddress": "Former Timber Yard, 162A Woolwich Road, Charlton, SE7 7.", "Sectors": {"__deferred": {"uri": "http://www.gleniganapi.com/InsightApi/Projects(5099683)/Sectors"}}, "OfficeDetails": {"__deferred": {"uri": "http://www.gleniganapi.com/InsightApi/Projects(5099683)/OfficeDetails"}}, "Funding": {"__deferred": {"uri": "http://www.gleniganapi.com/InsightApi/Projects(5099683)/Funding"}}, "Distance": null, "Lat": "51.48668409", "Long": "0.02148760", "SchemeDescription": "Scheme comprises construction of 10 holiday chalets, plus ancillary office and caretakers flat, with environmental city garden. The associated works include access roads, enabling, infrastructure, landscaping and sewer systems.", "PlanningDescription": "An application (ref: 12/1539/F) for detailed planning permission was submitted to Greenwich L.B.", "CivilDescription": null, "DemolitionDescription": null, "LatestInformation": "Detailed plans submitted.", "TenderInformation": null, "ProjectName": null, "DevelopmentTypeId": 1, "DevelopmentTypeDescription": "New", "ProjectStatusId": "IP", "ProjectStatusDescription": "In Progress", "IsArchived": false, "Heading": "10 Holiday Chalets & 1 Flat", "PlanningAlert": "/Date(1343119798000)/", "FirstPublished": "/Date(1343347200000)/", "Updated": "/Date(1343347200000)/", "Value": "1.100", "RegionId": 1, "BoroughId": 1019, "CountyId": null, "SiteAddress": "Former Timber Yard, 162A Woolwich Road, Charlton", "SiteAddressLine1": "Former Timber Yard", "SiteAddressLine2": "162A Woolwich Road", "SiteAddressLine3": "Charlton", "SiteName": null, "SiteStreetName": "Woolwich Road", "TownName": null, "TownId": null, "Postcode": "SE7 7    ", "PlanningStageId": 8, "PlanningStageDescription": "Detailed Plans Submitted", "ContractStageId": 30, "ContractStageDescription": "Pre-Tender", "OfficeId": 21899710, "Small": false}], "__next": "http://www.gleniganapi.com/InsightApi/Projects?$skiptoken=12147886"}}';
        
        if(dataType1 == DataType.Bidder)
            return '{ "d": {  "results": [{ "__metadata": {  "uri": "http://www.gleniganapi.com/InsightApi/CompaniesInProjectRole(ProjectId=509968334,RoleGroupId=116,RoleId=2131)",  "type": "InsightInfrastructure.Poco.CompanyInProjectRole" }, "ProjectRole": {  "__deferred": {"uri": "http://www.gleniganapi.com/InsightApi/CompaniesInProjectRole(ProjectId=34747,RoleGroupId=116,RoleId=2131)/ProjectRole"  } }, "ContactsInCompanyInProjectRole": {"__deferred":{"uri":"http://www.gleniganapi.com/InsightApi/CompaniesInProjectRole(ProjectId=34747,RoleGroupId=116,RoleId=2131)/ContactsInCompanyInProjectRole"  } }, "ProjectId": 509968334, "RoleGroupId": 116, "RoleId": 2131, "OfficeId": 906628, "CompanyInformationWithheld": 0, "RoleDescription": "Bidder", "AddressLine1": "Maple Cross House", "AddressLine2": "Denham Way", "AddressLine3": "Maple Cross", "CareOfOfficeName": null, "CompanyId": 20258254, "Email": "skanska@skanska.co.uk", "FaxNumber": "01923 423900", "NumberOfStaff": 65, "OfficeName": "Skanska Construction (UK) Ltd", "OfficeUrl": "www.skanska.co.uk", "PhoneNumber": "01923 776666", "Postcode": "WD3 9SW", "PostcodeOutboundId": 117, "PostcodeDistrictId": 2873, "PostcodeSectorId": 10776, "TownId": 1715, "TPS": null, "TPSPhoneNumber": "01923 776666"}  ], "__next":"http://www.gleniganapi.com/InsightApi/CompaniesInProjectRole?$filter=RoleDescription%20eq%20\'Bidder\'&$skiptoken=309004,116,2131" }}';
        return '';
    } 
    
    
     
}