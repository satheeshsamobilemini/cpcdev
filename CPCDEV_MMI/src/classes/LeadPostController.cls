/*************************************************************************
Name          : LeadPostController
Usage         : Controller class for LeadPost Page.
Created By    : Dan Guggenheim
Created Date  : Jun 12, 2009
*************************************************************************/

public class LeadPostController {
  public string xml{get;set ;}
   
  public  LeadPostController() {
    xml = System.currentPageReference().getParameters().get('xml');
    if (xml == null) {
      xml = '';
    }       
  }
  
  public Pagereference  insertLeads() {
    
    // TODO: Parse the xml body and convert to an array of leads.
    //       For this demonstration, we simply create a dummy lead
    if (xml.length() > 0) {  
      Lead l = new Lead (LastName = xml, Company = xml);
      insert l;
    }
    return null;
  }
  
  public String getPageURL() {
    return '/apex/LeadPost';
  }
  
  
  
  

  
}