/**
* (c) 2015 TEKsystems Global Services
*
* Name           : LostOppReasonClass
* Created Date   : 09 October, 2015 
* Created By     : Sreenivas M (TEKSystems)
* Purpose        : Controller class used by 'LostOppReason' VF page.
* Last Updated By: Ankur Goyal (TEKSystems)
* Last Updated Date: 14-Jan-2016
**/

public class LostOppReasonClass{
    public Opportunity currentOpportunity{get; set;}
    public Quote_Header__c currentQuote{get; set;}
    public Id oppId;
    public Id quoteId;
    public integer quoteNOofdates{get;set;}
    
    public LostOppReasonClass(ApexPages.StandardController stdController){
        currentOpportunity = new Opportunity();
        this.currentOpportunity = (Opportunity)stdController.getRecord();
        oppId =  ApexPages.currentPage().getParameters().get('id');
        quoteId = ApexPages.currentPage().getParameters().get('quoteid');
        currentOpportunity = [select Contact__r.salutation,Account.name,Account.isPersonAccount,Contact_Name__c,Contact_Last_Name__c,Contact_Mobile__c,of_Units__c,Opportunity_Lost_Category__c, Lost_Opportunity_Reason_New__c, Lost_Business_Additional_Comments__c, Lost_Business_To__c, Lost_Business_ToUK__c,StageName from opportunity where id =: currentOpportunity.id];
        
        currentQuote = [select Account__r.name,Account__r.Sales_Org__c,status__c,contact__r.firstname,contact__r.lastname,contact__r.Salutation,contact__r.MobilePhone,Start_Date__c,How_long_do_you_need_your_unit_weeks__c,Industry__c,Branch__c from quote_header__c where id=: quoteId ];
    
        if(currentQuote.Start_Date__c !=null && currentQuote.How_long_do_you_need_your_unit_weeks__c!= null){
            quoteNOofdates =  currentQuote.Start_Date__c.daysBetween(currentQuote.How_long_do_you_need_your_unit_weeks__c)+1;
        }
    }

    public pagereference Save() {
                
        currentOpportunity.StageName = 'Quoted - Lost Business';
        if(currentQuote.Account__r.Sales_Org__c == '1200'){
            currentOpportunity.Contact_Name__c = currentQuote.contact__r.firstname;
            currentOpportunity.Contact_Last_Name__c = currentQuote.contact__r.lastname;
            currentOpportunity.Contact_Mobile__c = currentQuote.contact__r.MobilePhone;
            currentOpportunity.Industry__c = currentQuote.Industry__c;
            currentOpportunity.Servicing_Branch__c = currentQuote.Branch__c;
        }
        update currentOpportunity;
        
        Quote_Header__c quoteHeader = new Quote_Header__c();
        quoteHeader.id = quoteid;
        quoteHeader.Status__c = 'Lost';
        update quoteHeader;
        
        PageReference newocp = new PageReference('/'+currentOpportunity.id);
        return newocp;
    }
} //end of class LostOppReasonClass