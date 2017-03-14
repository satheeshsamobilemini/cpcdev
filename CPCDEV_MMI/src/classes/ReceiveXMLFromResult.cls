global class ReceiveXMLFromResult {

    Global Class ResultMessage{
    
        webservice string jobId;
    
        webservice string BranchID;
        webservice string ProspectResultID;
        webservice string SalesResultID;
        webservice string SalesforceID;
        
        webservice date QuoteDate;
        webservice string TransactionCode;
        webservice string Reference;
        webservice string ResultID;
        
    }
    
    Webservice static String ReceiveXMLFromResult(ResultMessage Result){
    
        String returnCode = '';
    
        // Grab jobId and see what operation we need to perform
        if (Result.jobId == 'prospectToSales'){

            // Find a match for the Account being sent to us
            List<Account> existingAccount = New List<Account>();
            
            //change done by Reena on 05/01/2010. Reading account id.
            if(Result.SalesforceID != null && Result.SalesforceID != '') {
                existingAccount = [Select id, Result_Id__c, Type from Account where id =: Result.SalesforceID];
            }
        	//change end
            
            if(existingAccount.size()== 0){
                existingAccount = [Select id, Result_Id__c, Type from Account where ( (Branch__c = :Result.BranchID) AND (Result_Id__c = :Result.ProspectResultID) ) LIMIT 1];
            }
            
            if (existingAccount.size() > 0){
            
                existingAccount[0].Result_Id__c = Result.SalesResultID;
                
                if (existingAccount[0].Type == 'Prospect - National Account') existingAccount[0].Type = 'Customer - VIP National Account';
                else if (existingAccount[0].Type == 'Prospect - Branch Business Account') existingAccount[0].Type = 'Customer - Branch Business Account';
                else if (existingAccount[0].Type == 'Prospect - Residential Account') existingAccount[0].Type = 'Customer - Residential Account';
                else if (existingAccount[0].Type == 'Prospect - Government') existingAccount[0].Type = 'Customer - Government';
                
                update existingAccount;
                
                returnCode = 'Success';
            
            }
            else{
            
                returnCode = 'Error: An account matching ProspectResultID ' + Result.ProspectResultID + ' could not be found (Result Account: ' + Result.SalesResultID + ')';
            
            }
            
        }
        
        else if(Result.jobId == 'quotation'){

            try {

                String PGResultID = 'PG' + Result.ResultID;
                String SResultID = 'S' + Result.ResultID;

                List<Account> acct = New List<Account>();
                
                //change done by Reena on 05/01/2010. Reading account id.
                if(Result.SalesforceID != null && Result.SalesforceID != '') {
                    acct = [Select id, Result_Id__c, Type from Account where id =: Result.SalesforceID];
                }
                //change end
                
                if(acct.size()== 0){
                    acct = [Select id from Account where ( (Branch__c = :Result.BranchID) AND ( (Result_Id__c = :Result.ResultID) OR (Result_Id__c = :PGResultID) OR (Result_Id__c = :SResultID) ) ) LIMIT 1 ];
                }                

                if(acct.size() > 0) {
                
                    RecordType standardRecordTypeID = [Select Id from RecordType where name = 'Standard Task'];
                
                    Task t = new Task();
                    t.RecordTypeID = standardRecordTypeID.Id;
                    t.WhatId = acct[0].Id;
                    t.ActivityDate = Result.QuoteDate;   
                    t.Description = Result.TransactionCode + '\n' + Result.Reference;
                    t.Status = 'Completed';
                    t.Subject = 'Quotation';
                    t.Priority = 'Low';
                    t.Call_Result__c = 'Spoke with Customer/Prospect';
                    t.Call_Type__c = 'Result Quotation';
                    
                    List<User> users = new List<User>([Select id from User where Name ='Integration User']);

                    if(users.size() > 0)
                        t.OwnerId = users.get(0).id;
                    else
                        t.OwnerId = Userinfo.getUserId();
                        
                    insert t;
                    
                    returnCode = 'Success';
              
                }
                
                else{
                
                    returnCode = 'Error: An account matching ResultID ' + Result.ResultID + ' could not be found';
                
                }
                
            }catch(Exception e) {
                System.debug(e.getMessage());   
                
                returnCode = 'Error creating Task: ' + e.getMessage();
            }
        
        }
        
        else{
        
            returnCode = 'Error: jobId not recognized';
        
        }
    
        return returnCode; 
    }
    
}