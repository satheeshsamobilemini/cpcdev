/*********************************************************************************
Name         :  GleniganBidderTriggerHandler 
Created By   :  Appirio [Bharti Mehta]
Created Date :  Feb 20, 2013
Description  :  Handler class for GleniganBidderTrigger
*********************************************************************************/
public without sharing class GleniganBidderTriggerHandler {
	
	public static final String HOT_RATING = 'Hot (Probably Order)';    
	public static final String WARM_RATING = 'Warm (Possibly Order)';
	public static final String GLENIGAN_DEFAULT_LEAD_INDUSTRY = '5-Construction'; 
	public static final String UK_CURRENCY = 'GBP'; 	
	
	public static Id gleniganRecordTypeId;
	
	static{
    Schema.DescribeSObjectResult leadDescribe = Schema.SObjectType.Lead;
    Map<String,Schema.RecordTypeInfo> leadRTByName = leadDescribe.getRecordTypeInfosByName();
    Schema.RecordTypeInfo leadGleniganRecordTypeInfo = leadRTByName.get('Glenigan Lead');
    gleniganRecordTypeId = leadGleniganRecordTypeInfo.getRecordTypeId();
  }  
  
  /***************************************************************************
  * Method called on After Insert
  ***************************************************************************/
  public static void afterInsert(List<Glenigan_Bidder__c> newList) {
  	createNewLeads(newList);
  }
  
  /***************************************************************************
  * Method called on After Update
  ***************************************************************************/
  public static void afterUpdate(Map<Id, Glenigan_Bidder__c> newMap, 
  															 Map<Id, Glenigan_Bidder__c> oldMap) {
  	updateLeads(newMap, oldMap);
  }
  
     
	public static void createNewLeads(List<Glenigan_Bidder__c> newList){
    List<Lead> newLeads = new List<Lead>();
    Set<Id> projectIds = new Set<Id>();        
    Set<String> cyNoSet = new Set<String>();
    
    for(Glenigan_Bidder__c bidder : newList){
	    projectIds.add(bidder.Glenigan_Project__c);
	    if(bidder.cyno__c != null){
	        cyNoSet.add(bidder.cyno__c.intValue().format().replaceAll(',',''));
	    }
    }
    
    Map<Id,Glenigan_Project__c> mapProjects = new Map<Id,Glenigan_Project__c>([Select Id,Ptpcode__c,Ptsite1__c,Ptsite2__c,Ptsite3__c,Ptsite4__c,Site_Country__c
                                                                                From Glenigan_Project__c Where Id IN : projectIds]);
    Map<String, Account> existingCyNoAccount = loadAccount(cyNoSet);
    system.debug('===' + existingCyNoAccount);
    for(Glenigan_Bidder__c bidder : newList){
    	system.debug('@@@@@bidder.Cyno__c' + bidder.Cyno__c);
    	newLeads.add(createLead(bidder,mapProjects.get(bidder.Glenigan_Project__c),bidder.Cyno__c != null ? existingCyNoAccount.get(bidder.cyno__c.intValue().format().replaceAll(',','')) : null));
    }
        
    insert newLeads;
	}
    
	private static Lead createLead(Glenigan_Bidder__c bidder ,Glenigan_Project__c project,Account existingCyNoAccount){
    Lead lead = new Lead(
						    Glenigan_Bidder__c = bidder.id,
						    Salutation = bidder.Design__c,
						    FirstName = bidder.Fname__c,
						    LastName = (bidder.Lname__c == NULL || bidder.Lname__c == '')? 'Unknown':bidder.Lname__c,       
						    Company = bidder.Cyname__c,
						    Email = bidder.Email__c,
						    Phone = (bidder.PnPhone__c != NULL && bidder.PnPhone__c != '')? bidder.PnPhone__c :bidder.Cyphone__c,
						    Street = (bidder.Cyaddr1__c != null ? bidder.Cyaddr1__c : '')  + (bidder.Cyaddr2__c != null ? bidder.Cyaddr2__c : '') ,
						    City    = bidder.Cyaddr4__c,
						    State = (bidder.Cyaddr3__c!= null && bidder.Cyaddr3__c.length() > 20)?bidder.Cyaddr3__c.substring(0, 20):bidder.Cyaddr3__c,
						    PostalCode = bidder.Cypcode__c,     
						    Bidder_Postal_Code__c = bidder.Cypcode__c,
						    Primary_Contact_Method__c = bidder.PnPhone__c!= null ? 'Phone' : (bidder.Email__c != null? 'Email' : ''),        
						    Glenigan_Project__c = bidder.Glenigan_Project__c,
						    CurrencyISOCode = UK_CURRENCY,
						    Auto_Assign_Lead__c = true,       
						    Status =    'Open',		
						    LeadSource = 'Glenigan',        
						    RecordTypeId = gleniganRecordTypeId,
						    Rating = bidder.Awarded__c ? HOT_RATING : WARM_RATING,
						    Industry = GLENIGAN_DEFAULT_LEAD_INDUSTRY
    );
    
    if(project != null){
	    lead.Delivery_Postal_Code__c = project.Ptpcode__c;
	    lead.Delivery_City__c = project.Ptsite4__c;
	    //lead.Delivery_State__c = project.Ptsite3__c;
	    lead.Delivery_Country__c = project.Site_Country__c;
	    lead.Delivery_Street__c = (project.Ptsite2__c != null || project.Ptsite3__c != null) ? (project.Ptsite2__c + project.Ptsite3__c) : '';
    }else{
    	lead.Country = 'UK';
    }

    if(existingCyNoAccount != null ){
	    lead.OwnerId = existingCyNoAccount.OwnerId;
	    lead.Auto_Assign_Lead__c = false;
    } 
     	
    return lead;     
	}    
    
	public static Map<String, Account> loadAccount(Set<String> cyNoSet){
    String query = ' Select Id , Glenigan_Company_Id__c, OwnerId from Account where Owner.isActive = true '; 
    Map<String, Account>  accountMap = new Map<String, Account>();
    Boolean isWhere = false;
    String dynamicQuery = '';
    for(String cyn : cyNoSet){
    	 dynamicQuery += ' Glenigan_Company_Id__c like \'%'+ cyn +';%\'  or ';
    }
        
    if(dynamicQuery.length() > 0){
    	dynamicQuery = dynamicQuery.substring(0,dynamicQuery.lastIndexOf('or'));
	    String mainQuery = query + ' and ( ' + dynamicQuery + ') ';
	    for(Account acc : Database.query(mainQuery)){
	        List<String> abiCompanies = acc.Glenigan_Company_Id__c.split(';');
	        for(String abiCom : abiCompanies){
	        	accountMap.put(abiCom,acc);
	        }
	    }
    }
    return accountMap;
	} 
	
	public static void updateLeads( Map<Id, Glenigan_Bidder__c> newMap, Map<Id, Glenigan_Bidder__c> oldMap) {
		Set<Id> updatedBidderIds = new Set<Id>();
        
	    for(Glenigan_Bidder__c bidder : newMap.Values()){
		    if((oldMap.get(bidder.Id).Glenigan_Project__c == null && bidder.Glenigan_Project__c != null ) || 
		       (oldMap.get(bidder.Id).Awarded__c != bidder.Awarded__c)) {
		    	updatedBidderIds.add(bidder.Id);
		    }            
	    }
        
	    if(updatedBidderIds.size() > 0){
	      List<Lead> leadsToUpdate = [SELECT Id, Glenigan_Bidder__c, Glenigan_Project__c, Rating,isConverted 
		                                FROM Lead 
		                                WHERE Glenigan_Bidder__c IN : updatedBidderIds and IsConverted = false and Lead.Status != 'Dead Lead' ];
		   
		    for(Lead lead : leadsToUpdate){  
		    	lead.Glenigan_Project__c = newMap.get(lead.Glenigan_Bidder__c).Glenigan_Project__c; 
		    	lead.Rating = newMap.get(lead.Glenigan_Bidder__c).Awarded__c ? HOT_RATING : WARM_RATING; 
		    }
		            
		    if(leadsToUpdate.size() > 0)
		    	update leadsToUpdate;
			}
		}	  
}