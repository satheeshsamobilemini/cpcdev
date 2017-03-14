public class AccountHistoryProcessor
{
   @InvocableMethod 
  public static void updateAccountHistory(List<Id> acctIds)
  {
    system.debug(acctIds);  
   updateAccountHistories(acctIds);
  }
  
  @future
  public static void updateAccountHistories(List<Id> listacctIds)
   {
       system.debug(listacctIds);
        List<Account> acctList = new List<Account>();
        List<Account_History__c> accountUpsertList = new List<Account_History__c>();

        acctList = [select Id,OwnerId,SAP_Bill_To__c,SAP_Sold_To__c,Result_Id__c,MAR__c,NAM__c,OSR__c,ISR_AH__c,isSPOC_Account__c,(select Id,End_Date__c,Start_Date__c,isActive__c,SAP_Bill_To__c,SAP_Sold_To__c from Account_Histories__r) from Account where id in :listacctIds]; 

        for(Account u : acctList)
        {
            for(Account_History__c uh : u.Account_Histories__r)
            {
                //Logic to update today created records
                if(uh.Start_Date__c==System.today() && uh.End_Date__c==null)
                {
                 uh.End_Date__c = System.today(); 
                 uh.isActive__c = false;
                }

                //Logic to update not created today

                if(uh.Start_Date__c<System.today() && uh.End_Date__c==null)
                {
                 uh.End_Date__c = System.today()-1;
                 uh.isActive__c = true;
                }
                
                accountUpsertList.add(uh);
                        
            }
         
                if(u.SAP_Bill_To__c != null){
                Account_History__c  objUH = new Account_History__c();
                objUH.Start_Date__c = System.today();
                objUH.SAP_Bill_To__c = u.SAP_Bill_To__c;
                objUH.SAP_Sold_To__c = u.SAP_Sold_To__c;
                objUH.Result_Id__c = u.Result_Id__c;
                objUH.Account__c = u.id;
                objUH.MAR__c = u.MAR__c;
                objUH.NAM__c = u.NAM__c;
                objUH.OSR__c = u.OSR__c;
                objUH.ISR__c = u.ISR_AH__c;
                objUH.isSPOC_Account__c = u.isSPOC_Account__c;
                objUH.OwnerId__c = u.OwnerId;
                objUH.isActive__c = true;
                accountUpsertList.add(objUH);
                }
       
        }
        if(!accountUpsertList.isEmpty())
            upsert accountUpsertList;
   }
}