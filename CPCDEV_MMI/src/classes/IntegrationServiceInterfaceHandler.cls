/*****************************************************************************
 * Name             	: IntegrationServiceInterfaceHandler.cls
 * Created By       	: Bharti Bhandari(Appirio Offshore)
 * Last Modified Date : 15 March, 2012.
 * Description        : Lead Sharing logic (Interface Handler) used to send the dead lead to 360 Integration service
 *****************************************************************************/
public without sharing class IntegrationServiceInterfaceHandler {
    //Future method 
    public static Boolean isImportInProgress = false;
    @future(callout = true)
    public static void serviceImport(Set<Id> leadIds){
    	isImportInProgress = true;
		//Get all the Attachments provided leads (using the utility class XMLGeneratorUtility)
        List<Attachment> attachments = XMLGeneratorUtility.getXMLDocuments(loadLeads(leadIds));
        List<Lead> notSentTo360Leads = new List<Lead>();
        //insert attachments;
        //Iterate for recevied all attachments
        for(Attachment attach : attachments){
            String response = null;
            //Prepare a request
            IntegrationServiceInterface.IntegrationServiceSoap request = new IntegrationServiceInterface.IntegrationServiceSoap();
            //String body = '<Lead><email>test@test.com</email><company>Test Abc Co.</company><street>124 Main St</street><state>NJ</state><mobile_offices>true</mobile_offices><self_storage_facilities>true</self_storage_facilities><deliveryzip>07047</deliveryzip><city>TestCity</city><postalcode>07836</postalcode></Lead>';
            String body = attach.body.toString();    
            System.debug('========body==========' + body);
            try{
            		//append the xml with request
                response = request.Import(body);    
                System.debug('======Success========' + response);           
            }catch(Exception exp){
            		notSentTo360Leads.add(new Lead(Id = attach.ParentId,Rejected_By_360__c = true));
            	  System.debug('===========exp========' + exp.getMessage());
            }
        }
        update notSentTo360Leads;
        isImportInProgress = false;
    }
    //Retrieve leads of provided Ids 
    public static List<Lead> loadLeads(Set<Id> leadIds){            
        //Prepare soql Query
        String soqlQuery = 'Select ';
        //Map of all field defined in custom setting
        Map<String,Lead_XML_Field_Settings__c> xmlFieldSettingMap;
        xmlFieldSettingMap = Lead_XML_Field_Settings__c.getAll();
				//Set of all fields to be retrieved
        Set<String> fieldsToQuery = new Set<String> ();
        for(String fieldName: xmlFieldSettingMap.keySet()){
        	fieldsToQuery.add(fieldName.trim().toLowerCase());
        }
        
        for(String fieldName : fieldsToQuery) {
          soqlQuery += fieldName + ' ,';
        }
        soqlQuery = soqlQuery.substring(0,soqlQuery.length()-1);
        soqlQuery += ' From Lead where Id in : leadIds ';
        return database.query(soqlQuery);
    }
}