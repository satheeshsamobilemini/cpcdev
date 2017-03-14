/**
* (c) 2015 TEKsystems Global Services
*
* Purpose        : Trigger to handle Quote History record creation and Billing/Delivery contacts updation
* Name           : MMIFullQuoteUKTriggerHandler
* Created Date   : 30 April, 2015 @ 1130
* Created By     : Sreenivas M
* Test ClassName : AllFullQuoteUKClassesTriggersTest
* 
**/
Trigger MMIFullQuoteUKTrigger on MMI_Full_Quotes_UK__c (before update, before insert,after insert,after update) {

  if(Trigger.isBefore && MMIFullQuoteUKTriggerHandler.runBefTrigger){
        
        MMIFullQuoteUKTriggerHandler.runBefTrigger = false;
        Set<Id> quoteSet = new Set<Id>();
        Set<Id> AccountIds = new Set<Id>();
        for(MMI_Full_Quotes_UK__c fullQuote :  Trigger.new){
            AccountIds.add(fullQuote.Account__c);
        }
        map<Id,Account> IsPersonAccountId = new map<Id,Account>([Select Id, IsPersonAccount from Account where id IN: AccountIds]);
        map<Id, List<contact>> MapofAccountwithcontact = new map<Id, List<contact>>();
        List<contact> contactlist = new List<contact>();

        // Create or update a conatct details whenever changes has happen in billing/delivery tab

        List<Account> accnt = [ select id, name, (select id, email, AccountId, MobilePhone, Phone from contacts) from account where id IN :AccountIds];

        for(Account accn : accnt){
            if(!accn.contacts.isEmpty()){
                MapofAccountwithcontact.put(accn.id,new list<contact>(accn.contacts));
            }   
        }
        system.debug('MapofAccountwithcontact'+MapofAccountwithcontact); 
        Boolean contBill = true;
        Boolean contDel = true;
        Contact cnctBill;
        Contact cnctDel;
        
        for(MMI_Full_Quotes_UK__c fullQuote :  Trigger.new){
          system.debug('trigger'+fullQuote.Opportunity__c);
          if(String.isNotBlank(fullQuote.Opportunity__c)){
              if(MapofAccountwithcontact.containsKey(fullQuote.Account__c)){
					for(contact c : MapofAccountwithcontact.get(fullQuote.Account__c)){
					  system.debug('inside contact loop'); 
					  if(c.email== fullQuote.Billing_Email__c && c.MobilePhone == fullQuote.Billing_Mobile__c && c.Phone == fullQuote.Billing_Phone__c){
						  contBill = false;
						  cnctBill = c;
					  }
					  if(c.email== fullQuote.Delivery_Email__c && c.MobilePhone == fullQuote.Delivery_Mobile__c && c.Phone == fullQuote.Delivery_Phone__c){
						  contDel = false;
						  cnctDel = c;
					  }
					}
				}
          system.debug('billing'+contBill+cnctBill);
          system.debug('delivery'+contDel+cnctDel);
          system.debug('phone..'+fullQuote.Account__r.Phone); 
          system.debug('lookup'+IsPersonAccountId.get(fullQuote.Account__c).IsPersonAccount);
         
          if(contBill && !IsPersonAccountId.get(fullQuote.Account__c).IsPersonAccount){
              Contact con = new Contact ();
              con.AccountId = fullQuote.Account__c;
              //con.Title = selectedLead.title;
              con.Phone = fullQuote.Billing_Phone__c;
              con.FirstName = fullQuote.Billing_First_Name__c;
              con.LastName = fullQuote.Billing_Last_Name__c;
              con.mobilePhone = fullQuote.Billing_Mobile__c;
              con.Email = fullQuote.Billing_Email__c;
              con.Fax = fullQuote.Billing_Fax__c;
              //con.LeadSource = selectedLead.LeadSource;
              insert con;
              
              fullQuote.BillingContact_RecId__c = con.id;
             // fullQuote.Opportunity__r.Opportunity_Contact_Name_LookUpFilter__c = con.id;
              
              }
           else{
              system.debug('inside else bill'+contBill);
              if(IsPersonAccountId.get(fullQuote.Account__c).IsPersonAccount){
              Account acc = new Account(id = fullQuote.Account__c, FirstName = fullQuote.Billing_First_Name__c, LastName = fullQuote.Billing_Last_Name__c, PersonEmail = fullQuote.Billing_Email__c, PersonMobilePhone = fullQuote.Billing_Mobile__c, Phone = fullQuote.Billing_Phone__c);
              update acc;
              //cont.email = fullQuote.Billing_Email__c;
              //cont.MobilePhone = fullQuote.Billing_Mobile__c;
              //cont.Phone = fullQuote.Billing_Phone__c;
              }
              if (!contBill && !IsPersonAccountId.get(fullQuote.Account__c).IsPersonAccount){
              Contact cont=cnctBill;
              cont.LastName = fullQuote.Billing_Last_Name__c;
              cont.FirstName = fullQuote.Billing_First_Name__c;
              update cont;
             // fullQuote.Opportunity__r.Opportunity_Contact_Name_LookUpFilter__c = cont.id;
              }
              }
            
            if(!IsPersonAccountId.get(fullQuote.Account__c).IsPersonAccount){          
            if(contDel){
              if(String.isnotBlank(fullQuote.Delivery_Last_Name__c) || String.isnotBlank(fullQuote.Delivery_First_Name__c)){
              Contact con = new Contact ();
              con.AccountId = fullQuote.Account__c;
              //con.Title = selectedLead.title;
              con.Phone = fullQuote.Delivery_Phone__c;
              con.FirstName = fullQuote.Delivery_First_Name__c;
              if(String.isBlank(fullQuote.Delivery_Last_Name__c))
              con.LastName = fullQuote.Delivery_First_Name__c;
              else
              con.LastName = fullQuote.Delivery_Last_Name__c;
              con.mobilePhone = fullQuote.Delivery_Mobile__c;
              con.Email = fullQuote.Delivery_Email__c;
              con.Fax = fullQuote.Delivery_Fax__c;
              //con.LeadSource = selectedLead.LeadSource;
              insert con;
              fullQuote.DeliveryContact_RecID__c= con.id;
              }
              }
            else{
              system.debug('inside else dell'+contBill);
              if (!contDel){
              if(String.isnotBlank(fullQuote.Delivery_Last_Name__c) || String.isnotBlank(fullQuote.Delivery_First_Name__c)){
              Contact cont=cnctDel;
              if(String.isBlank(fullQuote.Delivery_Last_Name__c))
              cont.LastName = fullQuote.Delivery_First_Name__c;
              else
              cont.LastName = fullQuote.Delivery_Last_Name__c;
              cont.FirstName = fullQuote.Delivery_First_Name__c;
              update cont;
              }
              }
              }
              }
           }
  
       }
  }

 //Sreenivas -Creation of new quote history record whenever quote inserted/updated.
  if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate) && MMIFullQuoteUKTriggerHandler.runAftTrigger){
        
        MMIFullQuoteUKTriggerHandler.runAftTrigger = false;
        MMIFullQuoteUKTriggerHandler.createMMIFullQuoeUKHistory(Trigger.new);
    
    }
  
}