Public class SelectQuoteToCloneCntrl{
    
    Public string quoteNum{get;set;}
    public boolean showQuoteDetails{get;set;}
    public Quote_Header__c quote{get;set;}
    public boolean showProceed{get;set;}
    public boolean showDetailsPanel{get;set;}
    
    public string accountID{get;set;}
    public string salesOrg{get;set;}
    public string quoteID{get;set;}
        
    public SelectQuoteToCloneCntrl(){
        
        accountID = ApexPages.currentPage().getParameters().get('id');
        salesOrg = ApexPages.currentPage().getParameters().get('salesOrg');
        quoteID = '';
        showQuoteDetails = false;
        showProceed = true;
        showDetailsPanel = true;
        quoteNum = '';
    }


    public PageReference fetchQuoteDetails(){
        
        quoteNum = quoteNum.replace(' ','');
        //quoteNum = quoteNum.replace('+','');
        boolean junkValues = false;
        
        if( quoteNum.contains('!') || quoteNum.contains('+') || quoteNum.contains('-')  || quoteNum.contains('@') || quoteNum.contains('#') || quoteNum.contains('$') || quoteNum.contains('&')  )        
            junkValues = true;
        if(quoteNum.length() < 10 || junkValues){
            ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.Error,'Please remove any special characters and make sure to enter a 10 digit quote number');
            ApexPages.addMessage(errMsg);
            showQuoteDetails = false;
            showProceed = false;
            showDetailsPanel = false;
            return null;
        }
        else{
            showQuoteDetails = true;
            quote = new Quote_Header__c();
            List<Quote_Header__c> quoteList = new List<Quote_Header__c>();
            string likeName = '%'+quoteNum+'';
            quoteList = [select ID,name,status__c,plant__c,Total_Initial_Charges__c,Delivery_Date__c,Delivery_City__c,Shipto_State__c,Transaction_Type__c from quote_header__c where name like :likeName];
            if(quoteList.size() > 0){
                quote = quoteList[0];
                quoteID = quoteList[0].id;
                showProceed = true;
                showDetailsPanel = true;
            }
            else{
                showProceed = false;
                showDetailsPanel = false;
            }
        }      
        return null;
    }

}