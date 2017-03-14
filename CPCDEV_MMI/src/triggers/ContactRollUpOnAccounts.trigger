trigger ContactRollUpOnAccounts on Contact (after delete, after insert, after update) {

    set<ID> AccountIds = new set<ID>();
    set<ID> conIDs = new Set<ID>();
    Set<Id> OldAId = new Set<Id>();

    if(trigger.isInsert){ 
        for(Contact c : trigger.new){
            if(c.AccountId!=null)
            AccountIds.add(c.AccountId);
        }
    }

    if(Trigger.isUpdate){   
        for(Contact opp : Trigger.new){        
            if(opp.AccountId != Trigger.oldMap.get(opp.id).AccountId){
                AccountIds.add(opp.AccountId);
                OldAId.add(Trigger.oldMap.get(opp.id).AccountId);
            }
        }
    }

    if(trigger.isDelete){
        for(Contact c : trigger.old){
            if(c.AccountId!=null)
            AccountIds.add(c.AccountId);
        }
    }

    /* for new Account Contacts */
    if(AccountIds!=Null){
    List<AggregateResult> aggs = [select AccountId, count(ID) ContactCount from Contact where AccountId in : AccountIds Group By AccountId];
    Map<Id,Integer> conCountMap = new Map<Id,Integer>();
    for (AggregateResult agg : aggs) {
            conCountMap.put(string.valueOf(agg.get('AccountId')),Integer.valueOf(agg.get('ContactCount')));
    }

    List<Account> AccountsToUpdate = new  List<Account>();
    if(AccountIds != null){
            for(Id acctId : AccountIds ){
            Account newAcct = new Account(id=acctId);
            newAcct.Contact_Count__c = conCountMap.get(acctId); 
            AccountsToUpdate.add(newAcct);
        }
    }
    update AccountsToUpdate;
 }  

    /* for old Account Contacts */
    if(OldAId!=Null){
    List<AggregateResult> aggsOld = [select AccountId, count(ID) ContactCount from Contact where AccountId in : OldAId Group By AccountId];
    Map<Id,Integer> conCountMap = new Map<Id,Integer>();
    for (AggregateResult agg : aggsOld) {
        conCountMap.put(string.valueOf(agg.get('AccountId')),Integer.valueOf(agg.get('ContactCount')));
    }
    List<Account> AccountsToUpdateOld = new  List<Account>();

    if(OldAId!= null){
        for(Id acctId : OldAId){
            Account newAcct = new Account(id=acctId);
            newAcct.Contact_Count__c = conCountMap.get(acctId); 
            AccountsToUpdateOld.add(newAcct);
        }
    }

    update AccountsToUpdateOld;

    } 
}