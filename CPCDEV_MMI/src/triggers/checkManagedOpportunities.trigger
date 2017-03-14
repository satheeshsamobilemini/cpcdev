/*
This Trigger is to enforce a constraint that everytime someone deactivates a user, then it should be restricted to
do so if there are any Branch Lookups where this user is present as a a Sales Manager or National Account Manager.
*/
trigger checkManagedOpportunities on User (before update) {
integer i = 0;
for(User usr : Trigger.New){
System.debug('Trigger.new[i].IsActive :'+Trigger.new[i].IsActive);
if( Trigger.new[i].IsActive != Trigger.old[i].IsActive && Trigger.new[i].IsActive == false){
    String str = usr.Id;
    // We dont want to truncate this since the user id is stored with 18 characters
    // str = str.substring(0,15);
    System.debug('User Id:'+usr.Id + '    String :'+str);
    List<Branch_Lookup__c> branchList = [select id, Sales_Manager_ID__c, National_Account_Manager_ID__c from Branch_Lookup__c where Sales_Manager_ID__c =: usr.Id or Sales_Manager_ID__c =: str or National_Account_Manager_ID__c =: str or National_Account_Manager_ID__c=: usr.Id limit 1];
    System.debug('branchList :'+branchList);  
     if(branchList.size()>0){
        Trigger.new[i].IsActive.addError('Action denied. You cannot deactivate this user as there are associated Branches with this User as National Account Manager or Sales Manager. ');
    }
 }
 i++;
}
}