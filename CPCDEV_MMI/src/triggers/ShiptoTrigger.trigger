/**
* (c) 2016 TEKsystems Global Services
*
* Name              : ShiptoTrigger 
* Purpose           : Trigger to update Quote header ShiptoAddress.
* Created Date      : 8,Mar,2016 
* Created By        : Jailabdin shaik
* Last Updated Date : 8,Mar,2016  
* Last Updated By   : Jailabdin shaik
* 
**/
trigger ShiptoTrigger on Shipto__c (after update) {

    if(trigger.isUpdate && trigger.isAfter)
    {
        Set<ID> updatedShiptoIDs     = new Set<ID>();
        Map<ID,String> shiptoCity    = new Map<ID,String>();
        Map<ID,String> shiptoState   = new Map<ID,String>();
        Map<ID,String> shiptoCountry = new Map<ID,String>();
        Map<ID,String> shiptoZip     = new Map<ID,String>();
        Map<ID,String> shiptoAddress = new Map<ID,String>();
        Map<ID,String> shiptoPhone   = new Map<ID,String>();
        Map<ID,String> shiptoMobile  = new Map<ID,String>();
        
        List<Quote_Header__c> quoteHeadersList = new List<Quote_Header__c>();
        List<Quote_Header__c> quoteHeadersToUpdate = new List<Quote_Header__c>();
        
        for(Shipto__c sht: trigger.new)
        {
            updatedShiptoIDs.add(sht.ID);
            shiptoCity.put(sht.ID,sht.City__c);
            shiptoState.put(sht.ID,sht.State__c);
            shiptoCountry.put(sht.ID,sht.Country__c);
            shiptoZip.put(sht.ID,sht.Zip__c);
            shiptoAddress.put(sht.ID,sht.Address__c);
            shiptoPhone.put(sht.ID,sht.Phone__c);
            shiptoMobile.put(sht.ID,sht.Site_Contact1_Phone__c);    
        }
        
        quoteHeadersList = [select ID,Account_Shipto__c,Shipto_City__c,Shipto_address__c,Shipto_Country__c,Shipto_Mobile__c,
                            Shipto_Phone__c,Shipto_State__c,Shipto_Zip__c From Quote_Header__c where Account_Shipto__c in:updatedShiptoIDs];
        
        for(Quote_Header__c qh : quoteHeadersList)
        {
            if(shiptoCity.containsKey(qh.Account_Shipto__c))
                qh.Shipto_City__c = shiptoCity.get(qh.Account_Shipto__c);
            
            if(shiptoState.containsKey(qh.Account_Shipto__c))
                qh.Shipto_State__c = shiptoState.get(qh.Account_Shipto__c);
                
            if(shiptoCountry.containsKey(qh.Account_Shipto__c))
                qh.Shipto_Country__c = shiptoCountry.get(qh.Account_Shipto__c);
                
            if(shiptoZip.containsKey(qh.Account_Shipto__c))
                qh.Shipto_Zip__c = shiptoZip.get(qh.Account_Shipto__c);
                
            if(shiptoAddress.containsKey(qh.Account_Shipto__c))
                qh.Shipto_address__c = shiptoAddress.get(qh.Account_Shipto__c);            
            
            if(shiptoPhone.containsKey(qh.Account_Shipto__c))
                qh.Shipto_Phone__c = shiptoPhone.get(qh.Account_Shipto__c);
                
            if(shiptoMobile.containsKey(qh.Account_Shipto__c))
                qh.Shipto_Mobile__c = shiptoMobile.get(qh.Account_Shipto__c);
               
            quoteHeadersToUpdate.add(qh);
                                   
        }
        
        if(!quoteHeadersToUpdate.isEmpty())
            update quoteHeadersToUpdate; 
    }
}