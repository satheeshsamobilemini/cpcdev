trigger QuoteItemLevelTrigger on Quote_Item_Level__c (Before insert,Before update,Before delete,After insert,After delete, after update)
 {  
    
    Set<id> Qhset = new Set<id>();
    Map<id,List<Quote_Item_Level__c>> QuoteItemlevelMap1 = new Map<id,List<Quote_Item_Level__c>>();
    Set<Id> oppIdset = new Set<Id>();
    if((Trigger.isBefore && Trigger.isInsert) || (Trigger.isAfter && (Trigger.isUpdate || Trigger.isInsert)))
    {
        for(Quote_Item_Level__c QIL: trigger.new){
           Qhset.add(QIL.Quote_Header__c);
           if(QuoteItemlevelMap1.containsKey(QIL.Quote_Header__c)){
              QuoteItemlevelMap1.get(QIL.Quote_Header__c).add(QIL);
            }
           else{
               QuoteItemlevelMap1.put(QIL.Quote_Header__c,new List<Quote_Item_Level__c>());
               QuoteItemlevelMap1.get(QIL.Quote_Header__c).add(QIL);
              }
           /*if(trigger.isAfter && trigger.isUpdate && QIL.Quantity__c <> trigger.oldMap.get(QIL.Id).Quantity__c){
             Opportunity opp = new Opportunity(Id=QIL.Related_Opportunity__c,of_Units__c=QIL.Quantity__c);
             oppIdset.add(QIL.Related_Opportunity__c); 
           }  */  
          }
    }
    
    if((Trigger.isBefore && (Trigger.isUpdate || Trigger.isDelete)) || (Trigger.isAfter && Trigger.isDelete))
    {
        for(Quote_Item_Level__c QIL: trigger.old){
           Qhset.add(QIL.Quote_Header__c);
           if(QuoteItemlevelMap1.containsKey(QIL.Quote_Header__c)){
              QuoteItemlevelMap1.get(QIL.Quote_Header__c).add(QIL);
            }
           else{
               QuoteItemlevelMap1.put(QIL.Quote_Header__c,new List<Quote_Item_Level__c>());
               QuoteItemlevelMap1.get(QIL.Quote_Header__c).add(QIL);
              }
         }
    }
    
    list<Quote_Header__c> Qhlist; //=[select id,name,Shipto_City__c,Shipto_State__c,Total_Rental_Charges__c,
                                 //Delivery_Charge__c,Opportunity__c,
                                 //(select id,name,Item_Code__c,Quantity__c,Unit_Type__c,Contract_Number__c from Quote_Item_Levels__r) from Quote_Header__c where id in:Qhset];
    
    if(Trigger.isBefore)
    {
     
        //if(Trigger.isInsert)
        //    updateQHStatusplusTotal(Qhlist,true,false);
    
        //else 
        Qhlist=[select id,name,Shipto_City__c,Shipto_State__c,Total_Rental_Charges__c,
                                 Delivery_Charge__c,Opportunity__c
                                 from Quote_Header__c where id in:Qhset];
       
        if(Trigger.isDelete)
        {
            //QuoteHEaderTriggerHelper.isQILUpdate = TRUE; 
            //updateQHStatusplusTotal(Qhlist,QuoteItemlevelMap1,true,false);
            
            delete([select id from Quote_Sub_Item_Level__c where Quote_Item_level_ID__c in:trigger.oldmap.keyset()]);
        } 
        
        If(Trigger.isUpdate)
        {
            //updateQHStatusplusTotal(Qhlist,true,false);
            updateContractOnQuoteItemLevel();
        }       
     
    }
    
    //All After Trigger logic -- removed 'else' part as this is not required as the triggering point is CPC and none of the following events occur there
   /* else
    {
        Qhlist=[select id,name,Shipto_City__c,Shipto_State__c,Total_Rental_Charges__c,
                                 Delivery_Charge__c,Opportunity__c
                                  from Quote_Header__c where id in:Qhset];
  
       /* if(Trigger.isInsert)
        {
            updateQHStatusplusTotal(Qhlist,true,false);
        }
            
         if(Trigger.isUpdate && QuoteHEaderTriggerHelper.isQILUpdate == false)
        {
         QuoteHEaderTriggerHelper.isQILUpdate = true; 
         updateQHStatusplusTotal(Qhlist,QuoteItemlevelMap1,true,true);
        }
        
        else if(Trigger.isDelete && QuoteHEaderTriggerHelper.isQILUpdate == FALSE)
        {
          QuoteHEaderTriggerHelper.isQILUpdate = TRUE; 
          updateQHStatusplusTotal(Qhlist,QuoteItemlevelMap1,false,true);
          
        } 
    }  */

  /* public void updateQHStatusplusTotal(list<Quote_Header__c> Qhlists,Map<Id,List<Quote_Item_Level__c>> qItemLevelMap, Boolean updateStatus,Boolean updateTotal)
    {
        Set<Quote_Header__c> setHeaderstoUpdate = new Set<Quote_Header__c>();
        for(Quote_Header__c QH :Qhlists)  {
            
            //Boolean allFilledLineItmes = false;
            integer totalLI = 0;
            system.debug('---------+---------'+qItemLevelMap.get(QH.id).size());
            totalLI = qItemLevelMap.get(QH.id).size();
           // for(Quote_Item_Level__c lineitem : QH.Quote_Item_Levels__r)
            //{
              //if( lineitem.Contract_Number__c != null && lineitem.Contract_Number__c!= '')
              //{
              //    allFilledLineItmes = true;
              //}
              //totalLI= totalLI+1;
            //}
            
            /*if(updateStatus)
            {
             if(allFilledLineItmes)
                 QH.Status__c = 'Won';
             else
                 QH.Status__c = 'Open';
         //   }
            
            if(updateTotal)
                QH.Total_Quote_Items__c = totalLI;
             
            setHeaderstoUpdate.add(QH); 
        }
    
       if(!setHeaderstoUpdate.isEmpty())   
        update new List<Quote_Header__c>(setHeaderstoUpdate);
    } */
    
    public void updateContractOnQuoteItemLevel()
    { 
        Map<Id,Quote_Header__c> mapQHIdtoQH = new Map<Id,Quote_Header__c>();
        Set<Quote_Header__c> qhSets = new Set<Quote_Header__c>();
        for(Quote_Item_Level__c QIL: trigger.new)
        {
            if(QIL.Contract_Number__c!=null){
                Quote_Header__c qh = new Quote_Header__c();
                string Testcontractstring = QIL.Contract_Number__c;
                qh.id = QIL.Quote_Header__c;
                qh.Contract_Number__c = Testcontractstring.substring(0,10);
                //qhSets.add(qh);
                mapQHIdtoQH.put(qh.id,qh);
                system.debug('size is ...............'+Testcontractstring.length());
                
                if(Testcontractstring.length()>1011){
                    QIL.Test_Contract_1__c= Testcontractstring.substring(0,252);
                    QIL.Test_Contract_2__c= Testcontractstring.substring(253,505);
                    QIL.Test_Contract_3__c= Testcontractstring.substring(506,758);
                    QIL.Test_Contract_4__c= Testcontractstring.substring(759,1011);
                }
                
                else if(Testcontractstring.length()>758 ){
                    QIL.Test_Contract_1__c= Testcontractstring.substring(0,252);
                    QIL.Test_Contract_2__c= Testcontractstring.substring(253,505);
                    QIL.Test_Contract_3__c= Testcontractstring.substring(506,758);
                    QIL.Test_Contract_4__c= Testcontractstring.substring(759);
                }
                
                else if(Testcontractstring.length()>505){
                    QIL.Test_Contract_1__c= Testcontractstring.substring(0,252);
                    QIL.Test_Contract_2__c= Testcontractstring.substring(253,505);
                    QIL.Test_Contract_3__c= Testcontractstring.substring(506);
                    QIL.Test_Contract_4__c= ' ';
                }
                
                else if(Testcontractstring.length()>255){
                    QIL.Test_Contract_1__c= Testcontractstring.substring(0,252);
                    QIL.Test_Contract_2__c= Testcontractstring.substring(253);
                    QIL.Test_Contract_3__c= ' ';
                    QIL.Test_Contract_4__c= ' ';
                }
                
                else{
                    QIL.Test_Contract_1__c= Testcontractstring.substring(0);
                    QIL.Test_Contract_2__c= ' ';
                    QIL.Test_Contract_3__c= ' ';
                    QIL.Test_Contract_4__c= ' ';
                }
            }
        }
                     
        //if(!mapQHIdtoQH.values().isEmpty())
        //    update mapQHIdtoQH.values();
    
    }
    
 }