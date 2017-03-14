/*****************************************************************************
 * Name             	: XMLGeneratorUtility.cls
 * Created By       	: Bharti Bhandari(Appirio Offshore)
 * Last Modified Date : 15 March, 2012.
 * Description        : Lead Sharing logic (Utility class to generate a XML of lead record)
 *****************************************************************************/
public without sharing class XMLGeneratorUtility {
		//A map of all Lead fields
    public static Map<String,Schema.SObjectField> allFields;
    //A map for all values of custom setting Lead_XML_Field_Settings__c those have all field tags
    public static Map<String,Lead_XML_Field_Settings__c> xmlFieldSettingMap;
    //Set of Dead Lead reasons
    public static Set<String> deadLeadReasons;
    //Set of lead sources
    public static Set<String> leadSources;
    public static Set<String> overwriteFields;
    static{
        //allFields = Schema.SObjectType.Lead.fields.getMap();
        xmlFieldSettingMap = Lead_XML_Field_Settings__c.getAll();
        //Populate all needed dead lead reason from custom label
        deadLeadReasons = new Set<String>();
        for(String deadLeadReason :Label.DeadLeadReasonForXML.split(',',-2)){
            deadLeadReasons.add(deadLeadReason.toLowerCase().trim());
        }
        //Populate all needed lead sources from custom label
        leadSources = new Set<String>();
        for(String leadSource :Label.LeadSourceForXML.split(',',-2)){
            leadSources.add(leadSource);
        }     
        /*
        overwriteFields = new Set<String>();
        for(Lead_XML_Field_Settings__c fieldSetting : xmlFieldSettingMap.values()){
            overwriteFields.add(fieldSetting.tag_Name__c);
        } */
            
    }
    //A method that return list of all Attachments of provided leads
    public static List<Attachment> getXMLDocuments(List<sObject> leadsList){
        List<Attachment> listOfAttachments = new List<Attachment>();
        for(sObject leadRecord : leadsList){
         listOfAttachments.add(getXMLDocument(leadRecord));
        }
        return listOfAttachments;
    }
    //A method is used to generate XML document of provided lead record
    private static Attachment getXMLDocument(sObject leadRecord){
        //Schema.DescribeSObjectResult allFields = Lead.sObjectType.getDescribe();
        XmlStreamWriter writer = new XmlStreamWriter();
        writer.writeStartDocument('UTF-8', '1.0'); 
        writer.writeStartElement(null, 'Lead', null);
        //Iterate for all fields those name are in custom seting.
        for(String fieldName : xmlFieldSettingMap.keySet()){
            System.debug('::FieldName:::' + fieldName + ':::Field Value:::'+leadRecord.get(fieldName));
            String tagName = String.valueOf(xmlFieldSettingMap.get(fieldName).Tag_Name__c);
            System.debug('::TagName:::' + tagName);
            
            /*if(!overwriteFields.contains(fieldName.replaceAll('__c',''))){
                String tagName = xmlFieldSettingMap.containsKey(fieldName.replaceAll('__c','')) ? xmlFieldSettingMap.get(fieldName.replaceAll('__c','')).tag_Name__c : fieldName.replaceAll('__c','');
            
                if(leadRecord.get(fieldName) != null){
                    addTextElement(tagName,String.ValueOf(leadRecord.get(fieldName)),writer);
                }
            }*/
            
            //if(leadRecord.get(fieldName) != null)
                {
                addTextElement(tagName,String.ValueOf(leadRecord.get(fieldName)),writer);
                }
        }
        writer.writeEndElement();
        writer.writeEndDocument();
        //Prepare the attachment object of XML document     
        Attachment attach = new Attachment();
        attach.Body = Blob.valueOf(writer.getXmlString());
        attach.Name = leadRecord.get('firstname') + ' ' + leadRecord.get('lastname') + '.xml';
        attach.ParentId = (Id)leadRecord.get('Id');
        return attach;
    }
    //A method that add an element to XML
    private static void addTextElement(String tagName,String characters,XmlStreamWriter writer){   
        writer.writeStartElement(null, tagName, null);        
        if(characters!=null && characters != '' && characters != 'null'){
             writer.writeCharacters(characters);
        }else
            writer.writeCharacters('');
            writer.writeEndElement();
   }
}