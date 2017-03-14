public with sharing class BonusPurposeAndTSMController{

Account acc;
Account accObj;

String usrId;
User usr;

public String requestVal{get;set;} 
public String requestValTSM{get;set;} 
public Boolean showBPMessage {get;set;}
public Boolean showTSMMessage {get;set;}
public Boolean showErrorMessage {get;set;}

public BonusPurposeAndTSMController(ApexPages.StandardController cntlr){
    acc = (Account) cntlr.getRecord();
    accObj = [select Id, Name, Owned_for_bonus_purposes__c, Branch__c, OwnerId,TSM_Top_Potential__c, TSM_Top_Potential_ID__c 
            from Account where Id =:acc.Id];

    //Get the logged in user details
    usr = [select Id, Branch_Id__c, Profile.Name from User where Id=: UserInfo.getUserId()];
    usrId = usr.Id;
    if(usrId.length()==18){
        usrId = usrId.subString(0,15);
    }
    
    System.debug('User Obj; '+usr);
    System.debug('Account Obj; '+accObj);


}

public PageReference submitForBonusApproval() {
    showErrorMessage = false;
    showBPMessage = false;

    if(requestVal == 'ADD'){
        /*
        Same as Approval Process Entry Criteria for Adding a Bonus Purpose Account
        AND($User.Id = OwnerId,  NOT(Owned_for_bonus_purposes__c), $User.Branch_Id__c=Branch__c, $Profile.Name != 'Territory Sales Mgr - US') 
        */
        if(usrId == accObj.OwnerId && (!accObj.Owned_for_bonus_purposes__c) && 
            (!usr.Profile.Name.equalsIgnoreCase('Territory Sales Mgr - US')) &&
             usr.Branch_Id__c == accObj.Branch__c ){

            System.debug('All conditions satisfied for ADD: Submitting for Approval');
            boolean flag = submitForApproval();
            if(flag){
                return goBack();
            }

        }else{
            System.debug('Entry Criteria doesnt match for ADD');
            showBPMessage = true;
        }
    
    }else if(requestVal == 'REMOVE'){
        /*
        Same as Approval Process Entry Criteria for Removing a Bonus Purpose Account
        AND(Owned_for_bonus_purposes__c, $User.Id = OwnerId, $User.Branch_Id__c=Branch__c, $Profile.Name != 'Territory Sales Mgr - US')
        */
        if(usrId == accObj.OwnerId && accObj.Owned_for_bonus_purposes__c && 
            (!usr.Profile.Name.equalsIgnoreCase('Territory Sales Mgr - US')) &&
             usr.Branch_Id__c == accObj.Branch__c ){

            System.debug('All conditions satisfied for REMOVE: Submitting for Approval');
            boolean flag = submitForApproval();
            if(flag){
                return goBack();
            }

        }else{
            System.debug('Entry Criteria doesnt match for REMOVE');
            showBPMessage = true;
        }

    }
    return null;
    }

public PageReference submitForTSMApproval() {
    showErrorMessage = false;
    showTSMMessage = false;

    if(requestValTSM == 'ADD'){
        /*
        Same as Approval Process Entry Criteria for Adding a Top Potential Account
        AND(OR(ISNULL(TSM_Top_Potential_ID__c),ISBLANK(TSM_Top_Potential_ID__c)) , $Profile.Name = 'Territory Sales Mgr - US')
        */

        System.debug('accObj.TSM_Top_Potential_ID__c :'+accObj.TSM_Top_Potential_ID__c+'    Profile: '+usr.Profile.Name);
        
        //01/09/2011-Vidya commented code below for Approval process issue.
        /*if((accObj.TSM_Top_Potential__c ==null || accObj.TSM_Top_Potential__c =='') &&  
            usr.Profile.Name.equalsIgnoreCase('Territory Sales Mgr - US')){*/
        
        if((accObj.TSM_Top_Potential__c ==null) &&  
            usr.Profile.Name.equalsIgnoreCase('Territory Sales Mgr - US')){

            System.debug('All conditions satisfied for ADD: Submitting for Approval');
            boolean flag = submitForApproval();
            if(flag){
                return goBack();
            }

        }else{
            System.debug('Entry Criteria doesnt match for ADD');
            showTSMMessage = true;
        }
    
    }else if(requestValTSM == 'REMOVE'){
        /*
        Same as Approval Process Entry Criteria for Removing a Top Potential Account
        AND(TSM_Top_Potential_ID__c = $User.Id, $Profile.Name = 'Territory Sales Mgr - US')
        */

        String tsmId = accObj.TSM_Top_Potential_ID__c;
        if(tsmId!=null && tsmId.length()==18){
            tsmId = tsmId.subString(0,15);
        }
        
          //01/09/2011-Vidya commented code below for Approval process issue.
        //if(usrId == tsmId && usr.Profile.Name.equalsIgnoreCase('Territory Sales Mgr - US')){
        if(usr.Id == accObj.TSM_Top_Potential__c && usr.Profile.Name.equalsIgnoreCase('Territory Sales Mgr - US')){
         
            System.debug('All conditions satisfied for REMOVE: Submitting for Approval');
            boolean flag = submitForApproval();
            if(flag){
                return goBack();
            }

        }else{
            System.debug('Entry Criteria doesnt match for REMOVE');
            showTSMMessage = true;
        }

    }
    return null;
    }




    public PageReference goBack() {
        return new PageReference('/'+acc.Id);
    }
                
    public List<SelectOption> getBonusItems() {
        List<SelectOption> options = new List<SelectOption>(); 
        options.add(new SelectOption('ADD','Add for Bonus Purposes')); 
        options.add(new SelectOption('REMOVE','Remove for Bonus Purposes')); 
          return options; 
    }

    public List<SelectOption> getTSMItems() {
        List<SelectOption> options = new List<SelectOption>(); 
        options.add(new SelectOption('ADD','Add for Top Potential')); 
        options.add(new SelectOption('REMOVE','Remove for Top Potential')); 
          return options; 
    }
           
    public boolean submitForApproval(){
    try{
     System.debug('Approval Process Launched for '+accObj.Id);

        // Create an approval request for the account
        Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
        req1.setComments('Submitting request for approval.');
        req1.setObjectId(accObj.Id);

        // Submit the approval request for the account
        Approval.ProcessResult result = Approval.process(req1);
        
        // Verify the result
        System.debug('Approval Process Submission Result:'+result);
        
        return true;
    }catch(Exception e){
        System.debug(e);
        showErrorMessage = true;
    }
    return false;
    }

    public String getRequestVal() {
        return requestVal;
    }
                    
    public void setRequestVal(String requestVal) { this.requestVal= requestVal; }
    public void setRequestValTSM(String requestValTSM) { this.requestValTSM= requestValTSM; }
}