trigger Account_Revenue_Flag on Sub_Contractor__c (before insert, before update) {
    //Update the indicator
    //1 = if the revenue of last 8 quarters is > 0
    //0 = if the revenue of last 8 quarters is <= 0
    for(Sub_Contractor__c sc : Trigger.New){
        if(sc.Account_Revenue_Indicator_Formula__c > 0){
            sc.Account_Revenue_Indicator__c = 1;
        } else {
            sc.Account_Revenue_Indicator__c = 0;
        }
    }
}