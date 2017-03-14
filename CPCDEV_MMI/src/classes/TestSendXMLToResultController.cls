/*************************************************************************
Name          : TestSendXMLToResultController
Usage         : Test class for class SendXMLToResultController .
Created By    : Kirtesh Jain
Created Date  : May 27, 2009
*************************************************************************/

@isTest
private class TestSendXMLToResultController {
  
  private static string setupAccountandContact(){
    Account account = new Account(Name= 'testAccount',shippingcountry='USA' ,shippingPostalCode='83527');
    insert account ;
    
    List<Contact> listContact = new List<Contact>();
    for(integer i = 0 ; i < 4 ; i++ ){
      Contact contact = new Contact();
      contact.accountId = account.Id ;
      contact.firstName = 'firstName'+i;
      contact.LastName = 'LastName'+i ;
      listContact.add(contact);
    }
    insert listContact ; 
  
    return account.Id ;
  }
  
  static testMethod void Test_SendXMLToResultController() {
    
    string accountId = setupAccountandContact();
    PageReference pageRef = Page.sendXMLtoResult;
    Test.setCurrentPage(pageRef);
    ApexPages.currentPage().getParameters().put('AccountId',accountId );
    
    sendXMLtoResultController sendXmltoResult = new  sendXMLtoResultController();
    System.assertEquals( sendXmltoResult.listContact.size() , 4 );
    sendXmltoResult.selectedContactId = sendXmltoResult.listContact[2].Id ;
    sendXmltoResult.SetContact();
    sendXmltoResult.Submit() ;
  }
}