public with sharing class NewCustomerAccountService {


     public NewCustomerAccountParser callNewCustAccount(String name, String address,String city,String state,String zip ,String phone){
        ServiceProxy servicePro =null;
        String jsonBody;
        NewCustomerAccountParser r = new NewCustomerAccountParser(); 
        servicePro = new ServiceProxy();
        jsonBody=getRequest(name, address, city, state, zip, phone);
        
        String responseJSON=servicePro.callRestService('rest/api/v1/validate_account','POST',jsonBody);
        
        if(responseJSON!=null && !responseJSON.contains('"errorCode"')){
             return r.parse(responseJSON);
        }else{
            String errorMessage = QuickQuoteErrorHandler.handleError(responseJSON);
            r.errorMessage=errorMessage;
            return r;
        }
        
       
        
    }
    
    public ParseCreateNewResponse createNewCustAccount(String name, String address,String state,String contry,String zip ,String telephone, String branch, String salesRep, String newAccountId, String County, String City){
        ServiceProxy servicePro =null;
        String jsonBody;
        ParseCreateNewResponse r = new ParseCreateNewResponse(); 
        servicePro = new ServiceProxy();
        jsonBody = getNewAccRequest(name, address, state, contry, zip, telephone, branch, salesRep, newAccountId,County,City);
        //jsonBody = '{"account":{"salesForceID":"001Q000000hUUQz","branch":"113","companyId":1,"accountType":"C","ledger":"S","addressType":"B","status":"A","name":"MRC Park Avenue Inc", "address1":"45 Park Avenue","state":"NY","addressCountryCode":"USA","zipCode":"10016","telephone":"07855522255","taxCountryCode":"USA","currency":"USD", "daysInPeriod":"28","salesRep":"113425 ", "includeHfc":"N","hfcstatus":"AUC-UT","analysisSets":["VEMPLY","YES","3MOS","BOTH",null,null,null,null,null]}}';
        String responseJSON = servicePro.callRestService('rest/api/v1/accounts/1?login_id=result&login_branch='+branch,'POST',jsonBody);
        system.debug('####responseJSON#####'+responseJSON);
        if(responseJSON!=null && !responseJSON.contains('"errorCode"')){
             //return r.parse(responseJSON);
             return (ParseCreateNewResponse) System.JSON.deserialize(responseJSON, NewCustomerAccountService.ParseCreateNewResponse.class);
        }else{
            if(responseJSON != null && responseJSON != ''){
                String errorMessage = QuickQuoteErrorHandler.handleError(responseJSON);
                r.errorMessage = errorMessage;
            }else{
                r.errorMessage = 'Read timed out.';
            }
            return r;
        }
    }
    
    
    public String getRequest(String name, String address,String city,String state,String zip ,String phone){
        NewCustAccRequest newAcc=new NewCustAccRequest();
        newAcc.accountType='both';
        newAcc.addressLine1=address;
        newAcc.addressType='both';
        newAcc.city=city;
        newAcc.name=name;
        newAcc.state=state;
        newAcc.telephone=phone;
        newAcc.zipCode=zip;
        
         String JSONString = JSON.serialize(newAcc);
         system.debug('#########'+JSONString);
         
        return JSONString;
        
    }
    
    public class NewCustAccRequest {
        String accountType;
        String addressType;
        String name;
        String addressLine1;
        String zipCode;
        String city;
        String state;
        String telephone;
    }
    
    public String getNewAccRequest(String name, String address,String state,String contry,String zip ,String telephone, String branch, String salesRep, String newAccountId, String County, String City ){
        CreateNewCustAccRequest createNewAcc=new CreateNewCustAccRequest();
        createNewAcc.name = name;
        createNewAcc.address1 = address;
        createNewAcc.state = state;
        createNewAcc.addressCountryCode = contry;
        createNewAcc.zipCode = zip;
        createNewAcc.telephone = telephone;
        createNewAcc.branch = branch; 
        createNewAcc.salesRep = salesRep; //'298997'; //salesRep; // '113425'; //salesRep; to be mapped with salesRep
        createNewAcc.salesForceID = newAccountId;
        //============Hard coded value===========================
        createNewAcc.defaultFromAccountId = '2';
        createNewAcc.companyId = '1';
        createNewAcc.accountType = 'A';
        createNewAcc.ledger = 'S';
        createNewAcc.addressType = 'B';
        createNewAcc.status = 'A';
        createNewAcc.taxCountryCode = 'USA';
        //createNewAcc.currency = 'USD';
        createNewAcc.daysInPeriod = '28';
        createNewAcc.includeHfc = 'Y';
        createNewAcc.hfcstatus = 'NORM';
        createNewAcc.isServiceCharges = 'Y';
        createNewAcc.customInvoice = 'D';
        //createNewAcc.analysisSets = '["~","~","~","~",null,null,null,null,null]';
        
        String JsonReqString = JSON.serialize(createNewAcc);
        system.debug('####JsonReqString###B##'+JsonReqString);
        JsonReqString = JsonReqString.substring(0, JsonReqString.length() - 1);
        //JsonReqString += ',"currency":"USD"}';
        if(County != '' && County != null){
            JsonReqString += ',"county":"'+County+'"';
        }
        if(City != '' && City != null){
            JsonReqString += ',"city":"'+City+'"';
        }
        JsonReqString += ',"analysisSets":["~","~","~","~",null,null,null,null,null], "currency":"USD"}';
        JsonReqString = '{"account":'+JsonReqString+'}';
        system.debug('####JsonReqString###A##'+JsonReqString);
        return JsonReqString;
    }
    
    public class CreateNewCustAccRequest {
        String name;
        String address1;
        String state;
        String addressCountryCode;
        String zipCode;
        String telephone;
        String branch;
        String salesRep;
        String salesForceID;
        //============Hard coded Params====================
        String defaultFromAccountId;
        String companyId;
        String accountType;
        String ledger;
        String addressType;
        String status;
        String taxCountryCode;
       //public String currency {get;set;}
        String daysInPeriod;
        String includeHfc;
        String hfcstatus;
        //String analysisSets;
        String isServiceCharges;
        String customInvoice;
    }
    
    
    public class ParseCreateNewResponse {
        public String errorMessage {get;set;}
        public String newAccountId {get;set;}
    }

}