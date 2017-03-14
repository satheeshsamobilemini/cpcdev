/*************************************************************************
Name          : sendXMLtoResultController
Usage         : Controller class for SendXMLToResult Page.
Created By    : Kirtesh Jain
Created Date  : May 15, 2009
*************************************************************************/

public class sendXMLtoResultController {
  public List<Contact> listContact{ get ;set ;}
  public Account account{get ;set;}
 
  public string selectedContactName{get ;set ;}
  public string selectedContactId{get ;set ;}
  public string message{get;set ;}
  public string strAccountId{get ;set ;}
  public string strBillingStreet{ get; set ;}
  public string strName{ get; set ;}
 
  public  sendXMLtoResultController(){
    strAccountId = System.currentPageReference().getParameters().get('AccountId');
    if(strAccountId != null && strAccountId != ''){
       account  = [Select id, Name, BillingStreet , BillingCity, BillingState, BillingPostalCode , 
                  BillingCountry,Branch__c,
                  Website, Owner.Branch_Id__c, Owner.Sales_Rep_Id__c, Result_Id__c, Phone, Fax
                  from Account 
                  where Id = :strAccountId.trim()];
    
       
       if (account.BillingStreet != null)
         strBillingStreet = account.BillingStreet.replaceAll('"', '\\\\"');
       else
         strBillingStreet = '';
       
       if (account.Name != null)
         strName = account.Name.replaceAll('"', '\\\\"');
       else
         strName = '';
       
       strBillingStreet =  strBillingStreet.replaceAll('\n' , '').replaceAll('\r','') ;
       strName =  strName.replaceAll('\n' , '').replaceAll('\r','') ;
       
       listContact = [Select Id , Name from Contact Where accountId = : strAccountId ];
    }
  }
 
 public  pagereference  setContact(){
    this.selectedContactName = '' ;
    if( this.selectedContactId != null && this.selectedContactId != '' ){
      Contact contact  = [Select Id , Name 
                          from Contact 
                          Where Id =: this.selectedContactId ];
      this.selectedContactName = contact.Name ;
    }
    return null ;
  }
 
  public pagereference submit(){
    message = SendXMLToResult.sendToResult( strAccountId, selectedContactId ) ;
    return null ;
  }
}