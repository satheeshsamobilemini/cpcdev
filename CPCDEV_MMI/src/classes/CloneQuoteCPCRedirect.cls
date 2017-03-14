public class CloneQuoteCPCRedirect{
    
    public String cpqURL{get;set;}
    public String oppID{get;set;}
    public String quoteID{get;set;}
    public String contractId{get;set;}
    public String caname{get;set;}
    public String caid{get;set;}
    public String casorg{get;set;}
    public string conID{get;set;}
    public boolean redirectCPC{get;set;}
    public boolean isFromQuote{get;set;}
    
    public CloneQuoteCPCRedirect(){
        
        isFromQuote = false;
        caname = ApexPages.currentPage().getParameters().get('caname');
        caid = ApexPages.currentPage().getParameters().get('caid');
        casorg = ApexPages.currentPage().getParameters().get('casorg');
        quoteid = ApexPages.currentPage().getParameters().get('quoteid');
        contractId = ApexPages.currentPage().getParameters().get('contractID');
        redirectCPC = false; 
        
        if(quoteid != 'NA'){
            Quote_header__c qh = [select id,Account__r.ID,contact__r.id from quote_header__c where id= :quoteid];           
            caid = qh.Account__r.ID;
            conID = qh.contact__r.id;
            isFromQuote = true;
        }
        cpqURL = '';
        String curHost = System.URL.getSalesforceBaseUrl().getHost();
        for(CPQActiveURL__c cu: CPQActiveURL__c.getAll().values()){
            if(curHost.containsignorecase(cu.Environment__c))
                cpqURL = cu.CPQ_URL__c;
        } 
               
    }
    
    public void createOpportunity()
    {
        Opportunity newOpp = new Opportunity();
        newOpp.name = caname;
        newOpp.AccountId = caid;
        newOpp.StageName = 'Not Quoted';
        newOpp.CloseDate = date.today() + 21;
        
        if(isFromQuote )
            newOpp.Opportunity_Contact_Name_LookUpFilter__c = conID;
         
        if(casorg == '1200' )
            newOpp.recordTypeID = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity - UK').getRecordTypeId();
        else if(casorg == '1000' || casorg == '1100')
            newOpp.recordTypeID = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity').getRecordTypeId();
        else    
            newOpp.recordTypeID = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('ETS Rental').getRecordTypeId();    
        
        insert newOpp;  
        redirectCPC = true;  
        oppID = newOpp.ID;
    }

}