/*************************************************************************
Name          : uploadXMLController
Usage         : Controller class for UploadXML Page.
Created By    : Parth Tamhaney
Created Date  : May 29, 2009
*************************************************************************/

public class uploadXMLController {
  
  public string message{get;set ;}
 
  public  uploadXMLController(){
    String strXml = System.currentPageReference().getParameters().get('xml');
       
    System.debug('Parth*********xml=' + strXml);
    //SendXMLToResult.sendToResult( strAccountId, selectedContactId ) ;
  }
  
  public Pagereference createLead(){
  	String strXml = System.currentPageReference().getParameters().get('xml');
    
    message=strXml;
    Lead newLead=new Lead();
        newLead.FirstName=strXml;
        newLead.LastName=strXml;
        newLead.Street='TestWebservice';
        newLead.PostalCode='12345';
        newLead.Country='USA';
        newLead.CurrencyIsoCode='USD';
        newLead.Company='aaa';
        newLead.Status='Open';
        newLead.Auto_Assign_Lead__c=False;
        insert newLead;
        
        return null;
    
  }
 
  
}