/********************************************************************************************
Name   : CurrencyupdateonQuoteHeader 
Author : Jailabdin shaik
Date   : 23rd Nov 2015
Usage  : Used  to upadte currency value in QuoteHeader while inserting and updating
         Used to update discovery section fields in opportunity

********************************************************************************************/
trigger QuoteHeaderTrigger on Quote_Header__c (before insert, before update, after update,after insert) {
    
  if(!TriggerSwitch.isTriggerExecutionFlagDisabled('Quote_Header__c','QuoteHeaderTrigger')){ 
    //updating currency value as account currency while inserting & updating
    List<Quote_Header__c> qhListAsync = new List<Quote_Header__c>();
    List<id> QuoteitemlevelIdList = new List<id>();  
    List<Quote_Item_Level__c> UpdateQuoteItemList = new List<Quote_Item_Level__c>();
    Set<Quote_Item_Level__c>    itemLevel = new Set<Quote_Item_Level__c>();
    List<Quote_Item_Level__c>    itemLevelList = new List<Quote_Item_Level__c>();
    Map<Id,List<Quote_Item_Level__c>> QuoteItemlevelMap =new Map<Id,List<Quote_Item_Level__c>>();
    itemLevelList = [select id,Contract_Number__c,Description__c,name,Item_Code__c,Quantity__c,Unit_Type__c,Quote_Item_Higher_Level__c from Quote_Item_Level__c where Quote_Header__c in :Trigger.new order by Quote_Item_Number__c asc ];
    Map<Id,Quote_Item_Level__c> QuoteItemMap =new Map<Id,Quote_Item_Level__c>();
   
    if(Trigger.isBefore && Trigger.isInsert){       
        set<id> Qhset = new set<id>();
        Map<Id,String> mapAccIdCurrency = new Map<Id,String>();
        
        //String terSalesMgrUSProfileID = [SELECT Id, Name FROM Profile WHERE Name ='Territory Sales Mgr - US' LIMIT 1].Id;                
        for(Quote_Header__c qh:trigger.new){
            system.debug('trigger.new contains.......'+trigger.new);
            system.debug('Recurring Charges'+qh.Recurring_charges__c);
            Qhset.add(qh.Account__c);
            system.debug('Qhset.......'+Qhset);
            Date d = qh.Start_Date__c;          
            qh.Quote_Status_Changed__c = true;
            qh.Expiry_Date__c = (date.today()).addDays(30);
            if(qh.Distance_from_Branch__c != null)
                qh.Distance_from_Branch__c = Decimal.valueOf(qh.Distance_from_Branch__c.round());
            //String userProfileID;
            //if(!Test.isRunningTest()) userProfileID = [SELECT ProfileId, Name FROM user WHERE Id=:qh.Actual_Createdby__c LIMIT 1].ProfileId; //qh.Opportunity__r.createdby
            
            //if( userProfileID == terSalesMgrUSProfileID )
            //    qh.OSR__c = qh.Actual_Createdby__c; 
           
        }
               
      
    }
    //Create Quote Followup Task and assign to related opportunity owner
    
    if(Trigger.isAfter && Trigger.isInsert){
              
        Map<ID,ID> oppOwnerIDMap = new Map<ID,ID>();
        Map<ID,ID> accOwnerIDMap = new Map<ID,ID>();
        List<Opportunity> oppUpdateList = new List<Opportunity>();
        Opportunity opp;
        List<Quote_Header__c> qhList = [select ID,ownerid,opportunity__r.ownerid,opportunity__c,account__r.ownerid,account__c from quote_header__c where id in: Trigger.newMap.keySet() ];
        for(Quote_Header__c qh:qhList )
        {
            oppOwnerIDMap.put(qh.opportunity__c , qh.opportunity__r.ownerid); 
            accOwnerIDMap.put(qh.account__c , qh.account__r.ownerid);     
        }       
        List<Task> followupTaskList = new List<Task>();                
        for(Quote_Header__c qh:trigger.new){
            Task followupTask = new Task();
            if(oppOwnerIDMap.containskey(qh.Opportunity__c))
              followupTask.OwnerId = oppOwnerIDMap.get(qh.Opportunity__c);          //Assigned to - opp owner
            followupTask.Subject = 'Follow Up on Quote '+qh.name;             //task subject
            followupTask.ActivityDate = qh.Followup_Task_Date__c;    //system.today().addDays(7);   //Due date
            followupTask.Call_Type__c = 'OB - 4 Hour Callback';      //MMI Call Type 
            followupTask.Status = 'Not Started';                     //Task status - 'Not Started'
            followupTask.Priority = 'Normal';                        //Task priority - Normal
            followupTask.WhatId = qh.Opportunity__c;                 //Related to - Opportunity - opp
            followupTask.Branch__c = qh.Branch__c;                   //branch id 
            followupTask.Description = qh.Task_Comments__c;          //task comments
            //followupTask.Reminder__c = system.today().addDays(2);
            followupTaskList.add(followupTask);

            opp = new Opportunity();
            opp.id = qh.Opportunity__c;
            if(qh.Type__c == 'ZSLS' )
                opp.Transaction_Type__c = 'Sale';
            else
                opp.Transaction_Type__c = 'Lease';
            if(qh.sales_organization__c == '1200'){
                opp.Servicing_Branch_UK__c = qh.Fulfilling_Branch_Name__c;
                opp.Delivery_Date_UK__c = qh.Delivery_Date__c;
                opp.Delivery_Zip_Postal_Code__c = qh.Shipto_Zip__c;            
            }    
            oppUpdateList.add(opp);
                
        }
        
        if(!followupTaskList.isEmpty())
            insert followupTaskList; 
        if(!oppUpdateList.isEmpty())
            update oppUpdateList;

    }
    
    if(Trigger.isBefore && Trigger.isUpdate){
        //List<Opportunity> oppsToUpdate = new List<Opportunity>();
        //Opportunity opp;
        //List<Task> tasksToUpdateList = new List<Task>();
        //Task tsk;
        //Map<String,String> taskNameCommentsMap = new Map<String,String>();
        //Map<String,Date> taskNameDateMap = new Map<String,Date>();
        //Map<String,String> taskNameBranchMap = new Map<String,String>();
        //List<AggregateResult> lineItemResults;
        //lineItemResults = [SELECT COUNT(Id) count1 FROM QUOTE_ITEM_LEVEL__c where Quote_Header__c in: Trigger.new GROUP BY Quote_Header__c];
        Map<id,Quote_Header__c> mapQH =new Map<id,Quote_Header__c>([select id,Actual_Modifiedby__r.Email,account__r.name,(select id,Contract_Number__c from Quote_Item_Levels__r order by Quote_Item_Number__c asc) from Quote_Header__c where id in:Trigger.new]);
        
        map<string,string> branchCodeToEmailMap = new Map<string,string>();
        
        for(Branch_Detail__c br : [select Branch_Code__c,Branch_Email__c from Branch_Detail__c]){
            branchCodeToEmailMap.put(br.Branch_Code__c,br.Branch_Email__c);
        }
        
        for(Quote_Header__c quoteHeader : Trigger.new){
            
            for(Quote_Item_Level__c il: itemLevelList){
                
                if(QuoteItemlevelMap.containsKey(quoteHeader.id)){
                    QuoteItemlevelMap.get(quoteHeader.id).add(il);
                }
                else{
                    QuoteItemlevelMap.put(quoteHeader.id,new List<Quote_Item_Level__c>());
                    QuoteItemlevelMap.get(quoteHeader.id).add(il);
                }
                
            }
            
            Quote_Header__c qhOld = Trigger.oldMap.get(quoteHeader.id);
            if(quoteHeader.Status__c != qhOld.Status__c)
                quoteHeader.Quote_Status_Changed__c = true;
            //else
            //    quoteHeader.Quote_Status_Changed__c = false;    
            String branchEmail;
            String actModEmail;
            datetime futureTime = datetime.newInstanceGMT(2999,01,01,00,00,00);  // Used for blanking out follow-up-date and opp'ty close date based on update on CPC
            if(quoteHeader.Opportunity_Close_Date__c == futureTime)
                quoteHeader.Opportunity_Close_Date__c = null;           
            if( (quoteHeader.Task_Comments__c != Trigger.oldMap.get(quoteHeader.id).Task_Comments__c ) || ( quoteHeader.Followup_Task_Date__c != Trigger.oldMap.get(quoteHeader.id).Followup_Task_Date__c ) ){
                if(quoteHeader.Followup_Task_Date__c == futureTime)
                    quoteHeader.Followup_Task_Date__c = null;
                else
                    quoteHeader.Update_Followup_Task__c = true;                 
            }
                
            
            if(quoteHeader.Sales_Organization__c == '1200' ){
                
                if(branchCodeToEmailMap.containsKey(quoteHeader.Branch__c)){
                    quoteHeader.Branch_Email__c = branchCodeToEmailMap.get(quoteHeader.Branch__c);
                    branchEmail =   branchCodeToEmailMap.get(quoteHeader.Branch__c); 
                }
                if(quoteHeader.status__c == 'Won' && quoteHeader.Notification_Sent__c == false) {   
                    actModEmail = mapQH.get(quoteHeader.id).Actual_Modifiedby__r.Email;
                    String accName = mapQH.get(quoteHeader.id).Account__r.Name;
                    String conNum = mapQH.get(quoteHeader.id).Quote_Item_Levels__r[0].Contract_Number__c;
                    String quoteURL = URL.getSalesforceBaseUrl().toExternalForm() +'/' +quoteHeader.id;
                    String accURL = URL.getSalesforceBaseUrl().toExternalForm() +'/' +quoteHeader.account__c;
                    String emailMessage = 'Quote ' + quoteHeader.name + ' is Won, Contract ' + conNum + ' is created.\n\n Account Name - ' + accName  + '\nRelated Shipto/Postal Code - ' + quoteHeader.Shipto_Zip__c +'\n\nUse this link to access the Account:  ' + accURL +  '\n\n Use this link to access the Quote:  '+quoteURL;
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    String[] toAddresses = new String[]{};
                    if(actModEmail != null && actModEmail != '')
                        toAddresses.add(actModEmail);
                    //if(branchEmail != null && branchEmail != '')
                    //    toAddresses.add(branchEmail);
                    if(Test.isRunningTest())    
                        toAddresses.add('agoyal@teksystems.com');    
                    mail.setToAddresses(toAddresses);
                    mail.setReplyTo('noreply@salesforce.com');
                    mail.setSenderDisplayName('Quote Won');
                    string sub = 'Quote ' + quoteHeader.name + ' is Won for Account "' +accName +'"';
                    mail.setSubject(sub);
                    mail.setPlainTextBody(emailMessage);
                    //  mail.setHtmlBody(emailMessage);
                    List<Messaging.SendEmailResult> emailResults = Messaging.sendEmail(new Messaging.SingleEmailMessage[]{ mail });    
                    
                    if (!emailResults.get(0).isSuccess()) {
                        System.debug('Mail sent successfully!!');
                    }
                    else{
                        System.debug(emailResults.get(0).getErrors());
                    } 
                    quoteHeader.Notification_Sent__c = true; 
                }
            }
              
              system.debug('a1a'+Trigger.new[0].Account_Merge__c);
              system.debug('a1b'+Trigger.old[0].Account_Merge__c);
              If(Trigger.new[0].Account_Merge__c <> Trigger.old[0].Account_Merge__c && Trigger.new[0].Account_Merge__c == true){
                QuoteHEaderTriggerHelper.accountMerge = true;
                Trigger.new[0].Account_Merge__c = false;
              }
            /*IF(quoteHeader.Create_Followup_Task__c)
                quoteHeader.Update_Followup_Task__c = false;
            IF(quoteHeader.Update_From_Batch__c)
                quoteHeader.Update_Followup_Task__c = false;
            quoteHeader.Update_From_Batch__c = false; */  
            ///string taskSubject = 'Follow Up on Quote ' + quoteHeader.name;
            //taskNameCommentsMap.put(taskSubject,quoteHeader.Task_Comments__c);
            //taskNameDateMap.put(taskSubject,quoteHeader.Followup_Task_Date__c);
            //taskNameBranchMap.put(taskSubject,quoteHeader.Branch__c);
            /*if(quoteHeader.Task_ID__c != '' && quoteHeader.Task_ID__c != null){
                tsk = new Task();
                tsk.id = quoteHeader.Task_ID__c;
                tsk.ActivityDate = quoteHeader.Followup_Task_Date__c;
                tsk.Description = quoteHeader.Task_Comments__c;
                tsk.Branch__c = quoteHeader.Branch__c;
                tasksToUpdateList.add(tsk);
            }*/
            //opp = new Opportunity();
            //opp.id = quoteHeader.opportunity__c;
            //if(quoteHeader.Opportunity_Close_Date__c != null)
            //    Opp.CloseDate =  quoteHeader.Opportunity_Close_Date__c;
            //oppsToUpdate.add(opp);
            
            if(quoteHeader.Distance_from_Branch__c != null)
                quoteHeader.Distance_from_Branch__c = Decimal.valueOf(quoteHeader.Distance_from_Branch__c.round());
            if(!(QuoteItemlevelMap).isEmpty() && QuoteItemlevelMap.containsKey(quoteHeader.id))   
                quoteHeader.Total_Quote_Items__c =QuoteItemlevelMap.get(quoteHeader.id).isEmpty()?0:QuoteItemlevelMap.get(quoteHeader.id).size(); 
                //quoteHeader.Total_Quote_Items__c = (decimal) (lineItemResults[0].get('count1'));
                //system.debug('---++------'+(decimal) (lineItemResults[0].get('count1')));
               // mapQH.get(quoteHeader.id).Quote_Item_Levels__r.isEmpty()?0:mapQH.get(quoteHeader.id).Quote_Item_Levels__r.size();
            
        }
        
          
        /*List<Task> allTasksList = [select ID,Subject,ActivityDate,Branch__c,Description from Task where Subject in :taskNameCommentsMap.keyset() ];
        List<Task> tasksToUpdateList = new List<Task>();
        Task tsk;
        for(Task t: allTasksList){
            tsk = new Task();
            tsk.id = t.id;
            tsk.ActivityDate = taskNameDateMap.get(t.Subject);
            tsk.Description = taskNameCommentsMap.get(t.Subject);
            tsk.Branch__c = taskNameBranchMap.get(t.Subject);
            tasksToUpdateList.add(tsk);
        }
        */
        //Set<Opportunity> oppsToUpdate1 = new set<Opportunity>(oppsToUpdate);
        //List<Opportunity> oppsToUpdate2 = new List<Opportunity>(oppsToUpdate1);
        //if(!oppsToUpdate2.isEmpty())  
        //    update oppsToUpdate2;
        //if(!tasksToUpdateList.isEmpty())  
        //    update tasksToUpdateList;
    }
     
    if(trigger.isAfter && trigger.isUpdate)
    {
        set<id> QHIDset = new set<id>();
        Set<Id> listIds = new Set<Id>();
        set<string> quoteHeaderNoSet = new set<string>();
        String stUKID = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity - UK').getRecordTypeId();
        List<Quote_Header__c> qhs; 
        Map<ID, Opportunity> parentOpps = new Map<ID, Opportunity>(); 
        String oppName = '';
        Map<Id,Opportunity> mapOppIdtoOppty = new Map<Id,Opportunity>(); 
        List<Opportunity> oppsToUpdate = new List<Opportunity>();
        Opportunity opp;
        
        for(Quote_Header__c qh:trigger.new){
        
           for(Quote_Item_Level__c il: itemLevelList){
                
                if(QuoteItemlevelMap.containsKey(qh.id)){
                    QuoteItemlevelMap.get(qh.id).add(il);
                }
                else{
                    QuoteItemlevelMap.put(qh.id,new List<Quote_Item_Level__c>());
                    QuoteItemlevelMap.get(qh.id).add(il);
                }
                
            }
            QHIDset.add(qh.id);
            Quote_Header__c qhOld = Trigger.oldMap.get(qh.id);
            if(qh.Status__c != qhOld.Status__c){
                
                opportunity oppty = new opportunity();
                oppty.id = qh.opportunity__c;
                oppty.Quote_Status_Changed__c = true;
                mapOppIdtoOppty.put(oppty.id,oppty);
                
            }    
               
            listIds.add(qh.Opportunity__c);
            if(qh.Any_Signer_Status__c == 'Completed' && qh.Status__c == 'Won'){  //Docusign_Status__c 
                quoteHeaderNoSet.add(qh.name);
            }    
        }
        
        if(!(QuoteHEaderTriggerHelper.isExecuted) && !System.isBatch()){
            QuoteHEaderTriggerHelper.docusignStatusUpdateCallout(quoteHeaderNoSet);
        }    
        
        qhs = [select id,name,Account__r.name,Contact__c,Shipto_City__c,Quote_Comments__c ,Opportunity_Close_Date__c ,Shipto_State__c,Shipto_Zip__c,Total_Rental_Charges__c,Delivery_Charge__c,Status__c,
                Quote_Status_Changed__c ,Store_What__c,Who_Going_To_Access__c,Sales_Organization__c ,Shipto_address__c,Shipto_Country__c ,Storage_Use__c,How_Often_Access__c,
                Total_One_Time_Charges__c,Total_Initial_Charges__c,Other_Charges__c,Sales_Tax_or_Other_Charges__c,Recurring_Charges__c,Billing_Plan_Type__c,
                opportunity__r.recordtypeid,opportunity__c,opportunity__r.name,opportunity__r.Who_is_going_to_be_accessing_your_unit__c,
                opportunity__r.What_will_you_be_storing__c,opportunity__r.Why_do_you_need_storage_Picklist__c,
                opportunity__r.Total_Rental_Charges__c,opportunity__r.Total_One_Time_Charges__c,opportunity__r.Delivery_Charge__c,opportunity__r.Total1__c,opportunity__r.Other_Charges__c,
                opportunity__r.Sales_Tax_or_Other_Charges__c,opportunity__r.Recurring_Charges__c,opportunity__r.Billing_Plan_Type__c,
                opportunity__r.How_often_will_you_need_to_access__c,Transaction_Type__c, Type__c,Fulfilling_Branch_Name__c,Delivery_Date__c,
                (select id,Description__c,name,Item_Code__c,Quantity__c,Unit_Type__c,Quote_Item_Higher_Level__c 
                from Quote_Item_Levels__r) from Quote_Header__c where id in:QHIDset];
        
        Map<String,Integer> oppWithMultiQuotes = new Map<String,Integer>();
        //Map<String,Integer> oppWonMultiQuotes = new Map<String,Integer>();
        //Map<String,Integer> oppLostMultiQuotes = new Map<String,Integer>();
        Map<String,Integer> subItemCharges = new Map<String,Integer>();
                
        for(AggregateResult oq : [select Opportunity__c,count(ID) totalQuotes FROM Quote_header__c where opportunity__c in:listIds group by Opportunity__c having count(ID) > 1])
        {
            oppWithMultiQuotes.put(String.valueof(oq.get('Opportunity__c')),Integer.valueof(oq.get('totalQuotes')));
        }
        
        for(Quote_Sub_Item_Level__c sil : [select Id,Quote_Header__c,Quote_Item_Number__c,Quote_Item_Higher_Level__c,ADJ_COND_TYPE__c,Actual_Amount__c,Amount__c,Base_Amount__c,Entered_Amount__c,Quote_Item_level_ID__c 
            FROM Quote_Sub_Item_Level__c where ADJ_COND_TYPE__c in ('ZTOT','TOT1') and Quote_Header__c in:QHIDset])
        {
            subItemCharges.put(String.valueof(sil.get('Quote_Item_level_ID__c')),Integer.valueof(sil.get('Actual_Amount__c')));
            if(sil.Quote_Item_Number__c == '999999'){
                subItemCharges.put( 'rental',Integer.valueof(sil.get('Actual_Amount__c')) );    
            }
        }
        
        Map<string,String> quoteItemDescMap = new Map<string,String>();
        String lineItemsDesc = '';
        String qhdr = '';
        for(AggregateResult qil : [select sum(quantity__c) totalqty,Description__c,quote_header__c from quote_item_level__c where Recurring__c = 'X' and Accessory__c <> 'X' and Quote_Header__c in:Trigger.new group by Description__c,quote_header__c])
        {
            if(qhdr == '')
                qhdr = String.valueOf(qil.get('quote_header__c'));
            if(qhdr == String.valueOf(qil.get('quote_header__c')) ){
                lineItemsDesc =  lineItemsDesc + qil.get('totalqty') + 'no. - ' + qil.get('Description__c') + ', ';
                system.debug('===========' + String.valueOf(qil.get('quote_header__c')) + '========' + lineItemsDesc);
                quoteItemDescMap.put(String.valueOf(qil.get('quote_header__c')),lineItemsDesc);    
            }    
            else{
                system.debug('===========' + String.valueOf(qil.get('quote_header__c')) + '========' + lineItemsDesc);
                quoteItemDescMap.put(String.valueOf(qil.get('quote_header__c')),lineItemsDesc);
                lineItemsDesc = '';
                qhdr = String.valueOf(qil.get('quote_header__c'));
                lineItemsDesc =  lineItemsDesc  + qil.get('totalqty') + 'no. - ' + qil.get('Description__c') + ', ';
            }    
        }
         
        for(Quote_Header__c q:qhs)
        {
            System.debug('qhs.............'+q); 
            Set<ID> qli = new set<ID>();
            String unitType = '';
            Integer quantity = 0;
            Integer totalQty = 0;
            System.debug('q.Quote_Item_Levels__r..............'+QuoteItemlevelMap.get(q.id));
            if(QuoteItemlevelMap.containskey(q.id) && QuoteItemlevelMap.get(q.id).size() > 0){
            System.debug('q.Quote_Item_Levels__r..............'+QuoteItemlevelMap.get(q.id));
            for(Quote_Item_Level__c lineitem : QuoteItemlevelMap.get(q.id))
            {
                
                if(lineitem.Quote_Item_Higher_Level__c != null && lineitem.Quote_Item_Higher_Level__c != ''){
                    if(Integer.valueof(lineitem.Quote_Item_Higher_Level__c) == 0){
                        totalQty = totalQty + Integer.valueof(lineitem.Quantity__c);
                    }
                }
            }
            }
            if(q.opportunity__r.recordtypeid == stUKID)
            {
                if(oppWithMultiQuotes.containsKey(String.valueof(q.opportunity__c))){
                    oppName = q.Account__r.name+'/'+'Multi Quotes';                
                }
                else{
                    oppName = q.Account__r.name+'/'+q.name +'/';
                    if(q.Shipto_Zip__c != null && q.Shipto_Zip__c != '')
                        oppName = oppName  + q.Shipto_Zip__c;    
                }
                opp = new Opportunity();
                opp.id = q.opportunity__c;
                opp.name = oppName;
                opp.Total_Rental_Charges__c= q.Total_Rental_Charges__c;
                opp.Total_One_Time_Charges__c=q.Total_One_Time_Charges__c;
                opp.Delivery_Charge__c=q.Delivery_Charge__c;
                opp.Total1__c=q.Total_Initial_Charges__c;
                opp.Other_Charges__c=q.Other_Charges__c;
                opp.Sales_Tax_or_Other_Charges__c=q.Sales_Tax_or_Other_Charges__c;
                opp.Recurring_Charges__c=q.Recurring_Charges__c;
                opp.Billing_Plan_Type__c=q.Billing_Plan_Type__c; 
                opp.Opportunity_Contact_Name_LookUpFilter__c = q.contact__c;
                if(q.Quote_Status_Changed__c)
                    opp.Quote_Status_Changed__c = true;
                opp.of_Units__c = totalQty;
                if(q.Status__c=='Open'){
                    opp.StageName = 'Quoted - No Decision';
                    opp.Opportunity_Rating__c = 'Hot (Probably Order)';
                } 
                if(q.Status__c=='Won'){
                    opp.StageName='Quoted - Won';
                    opp.Opportunity_Rating__c = '';
                }
                if(q.Opportunity_Close_Date__c != null)
                    Opp.CloseDate =  q.Opportunity_Close_Date__c;   
                opp.Quote_Comments__c = q.Quote_Comments__c;
                if(q.sales_organization__c == '1200'){
                    opp.Servicing_Branch_UK__c = q.Fulfilling_Branch_Name__c;
                    opp.Delivery_Date_UK__c = q.Delivery_Date__c;
                    opp.Delivery_Zip_Postal_Code__c = q.Shipto_Zip__c;            
                }
                
                if(quoteItemDescMap.containsKey(String.valueOf(q.ID)))
                    opp.Quote_Items_Description__c = quoteItemDescMap.get(String.valueOf(q.ID));
                mapOppIdtoOppty.put(opp.id,opp);
            }
            else{
                if(oppWithMultiQuotes.containsKey(String.valueof(q.opportunity__c))){
                    oppName = q.Account__r.name+'/'+'Multi Quotes';                
                }
            
                else{ 
                    Integer delc = 0;
                    Integer puc = 0;
                    Integer rentalc = 0;  
                    Integer units = 0; 
                    if(QuoteItemlevelMap.containskey(q.id) && QuoteItemlevelMap.get(q.id).size() > 0){              
                    for(Quote_Item_Level__c lineitem : QuoteItemlevelMap.get(q.id))
                    {
                        
                        if(lineitem.Quote_Item_Higher_Level__c != null && lineitem.Quote_Item_Higher_Level__c != ''){
                            if(Integer.valueof(lineitem.Quote_Item_Higher_Level__c) == 0){
                                qli.add(lineitem.id);
                                units = units + 1;
                                quantity = Integer.valueof(lineitem.Quantity__c);
                                unitType = lineitem.Item_Code__c;
                            }
                        }
                        
                        if(lineitem.Description__c.containsIgnoreCase('DELIVERY'))
                        {
                            delc = subItemCharges.get(lineitem.id);
                        }
                        if(lineitem.Description__c.containsIgnoreCase('PICKUP'))
                        {
                            puc = subItemCharges.get(lineitem.id);
                        }
                        rentalc = subItemCharges.get('rental');
                        
                    }
                    }
                    if(unitType == null)
                        unitType = '';
                    if(quantity == null)
                        quantity =0;
                    if(delc == null)
                        delc = 0;
                    if(puc == null)
                        puc =0;
                    if(rentalc == null)
                        rentalc =0;
                        
                    String city = '';
                    if(q.Shipto_City__c != null && q.Shipto_City__c != '')    
                        city = q.Shipto_City__c;
                    
                    string state =  '';
                    if(q.Shipto_State__c != null && q.Shipto_State__c != '')
                        state = q.Shipto_State__c;
                    
                    Decimal rental = 0;
                    if(q.Total_Rental_Charges__c > 0 && q.Total_Rental_Charges__c != null)    
                        rental = q.Total_Rental_Charges__c ;
                    
                    Decimal delivery = 0;
                    if(q.Delivery_Charge__c > 0 && q.Delivery_Charge__c != null) 
                        delivery = q.Delivery_Charge__c;
                    
                    if(quantity > 1 || units > 1){
                        oppName = 'Multi Unit / ' + city + ', ' + state ;  //+ ' /' + q.Total_Rental_Charges__c + '/' + q.Delivery_Charge__c + '/' + q.Delivery_Charge__c;
                    }
                    else if(quantity == 1){
                        
                        oppName = '(' + quantity + ') ' + unitType + ' / ' +  city + ', ' + state + ' /' + rentalc + '/' + delc + '/ ' + puc;       
                    }
                    else{
                        oppName = unitType + ' / ' +  city + ', ' + state + ' /' + rentalc + '/' + delc + '/ ' + puc;       
                    }
                }
                opp = new Opportunity();
                if(q.Quote_Status_Changed__c)
                    opp.Quote_Status_Changed__c = true;
                opp.id = q.opportunity__c;
                if(q.Sales_Organization__c != '1500' && q.Sales_Organization__c != '1501')
                opp.name = oppName;
                opp.Total_Rental_Charges__c= q.Total_Rental_Charges__c;
                opp.Total_One_Time_Charges__c=q.Total_One_Time_Charges__c;
                opp.Delivery_Charge__c=q.Delivery_Charge__c;
                opp.Total1__c=q.Total_Initial_Charges__c;
                opp.Other_Charges__c=q.Other_Charges__c;
                opp.Sales_Tax_or_Other_Charges__c=q.Sales_Tax_or_Other_Charges__c;
                opp.Recurring_Charges__c=q.Recurring_Charges__c;
                opp.Billing_Plan_Type__c=q.Billing_Plan_Type__c; 
                opp.of_Units__c = totalQty;
                opp.What_will_you_be_storing__c=q.Store_What__c;     
                opp.quote_transaction_type__c = q.transaction_type__c; 
             
                 if(q.Opportunity_Close_Date__c != null)
                    Opp.CloseDate =  q.Opportunity_Close_Date__c;   
                 opp.Quote_Comments__c = q.Quote_Comments__c;
                 opp.Who_is_going_to_be_accessing_your_unit__c=q.Who_Going_To_Access__c;
                 opp.Why_do_you_need_storage_Picklist__c=q.Storage_Use__c;
                 opp.How_often_will_you_need_to_access__c=q.How_Often_Access__c;
                 opp.Delivery_City__c = q.Shipto_City__c;
                 opp.Delivery_Street__c = q.Shipto_address__c;
                 opp.Delivery_State_Province__c = q.Shipto_State__c;
                 opp.Delivery_Country__c = q.Shipto_Country__c;
                 opp.Delivery_Zip_Postal_Code__c = q.Shipto_Zip__c;
                 opp.Opportunity_Contact_Name_LookUpFilter__c = q.contact__c;
                 if(q.Status__c=='Open'){
                    opp.StageName =  'Quoted - No Decision';
                    opp.Opportunity_Rating__c = 'Hot (Probably Order)';
                 }                          
                
             if( (q.Sales_Organization__c == '1500' || q.Sales_Organization__c == '1501')  )    
             {
                     if(q.Sales_Organization__c == '1501')
                     {
                         String wmiOppID = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('WMI Opportunity').getRecordTypeId();
                         opp.recordTypeID = wmiOppID ;
                         opp.StageName = 'Proposal/Quote';
                        //opp.Total_Code_Update__c = true;
                     }
                     if(q.Sales_Organization__c == '1500')
                     {
                        opp.StageName = 'Proposal/Quote';
                        //opp.Total_Code_Update__c = true;
                     }
                     if( q.Type__c == 'ZSLS' && q.Sales_Organization__c == '1500' )
                     {    
                         //String etsSalesID = [select id,name from RecordType where name = 'ETS Sale'].ID;
                         String etsSalesID = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('ETS Sale').getRecordTypeId();
                         opp.recordTypeID = etsSalesID;
                     }
                     if( q.Type__c == 'ZREN' && q.Sales_Organization__c == '1500' ) {
                         //String etsRentalID = [select id,name from RecordType where name = 'ETS Rental'].ID;
                         String etsRentalID = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('ETS Rental').getRecordTypeId();
                         opp.recordTypeID = etsRentalID;
                     }
                       
             }
             if(q.Status__c=='Won'){
                 opp.StageName='Quoted - Won';
                 opp.Opportunity_Rating__c = '';
             }
             
             if(quoteItemDescMap.containsKey(String.valueOf(q.ID)))
                    opp.Quote_Items_Description__c = quoteItemDescMap.get(String.valueOf(q.ID));
               
                mapOppIdtoOppty.put(opp.id,opp);
            }  
        }
        oppsToUpdate.addAll(mapOppIdtoOppty.values());        
     
        if(!oppsToUpdate.isEmpty())  //&& Trigger.isAfter && Trigger.isInsert
            update oppsToUpdate; 
      
    
      //Chaitanya - Account merge
      List<Quote_Header__c> qhList1 = [select ID, Account_bill_to__c,Opportunity__r.Account.SAP_Sold_To__c, Account__r.recordTypeID,Account_ID__c,Opportunity__r.Account.Id,Opportunity__r.Account.recordTypeID,Account__r.Sales_Org__c,Opportunity__r.Account.Sales_Org__c, Account__r.SAP_Bill_To__c,opportunity__r.Account.SAP_Bill_To__c,opportunity__c,account__r.ownerid,account__c from quote_header__c where id in: Trigger.newMap.keySet() ];
      system.debug('-------acctmerge------'+QuoteHEaderTriggerHelper.accountMerge);
      for(Quote_Header__c qh:qhList1 ){
          if(qh.Account__r.recordTypeID == qh.Opportunity__r.Account.recordTypeID && qh.Account__r.Sales_Org__c == qh.Opportunity__r.Account.Sales_Org__c && QuoteHEaderTriggerHelper.accountMerge == true ){
              Account acc1 = new Account();
              Account acc2 = new Account();
              acc1.id = qh.Account_ID__c;
              acc2.id = qh.Opportunity__r.Account.Id;
              merge acc1 acc2;
              }
          }
         /*=====Added by Chaitanya========*/
      qhListAsync = [SELECT id,(select id,Recurring__c from Quote_Item_Levels__r), (select id,Recurring__c,Quote_Item_level_ID__c from Quote_sub_item_levels__r) FROM Quote_Header__c WHERE id in:Trigger.new];
      for(Quote_Header__c qh1: qhListAsync){
          for(Quote_sub_item_level__c qsil:qh1.Quote_sub_item_levels__r ){
              if(qsil.recurring__c != null){
                  QuoteitemlevelIdList.add(qsil.Quote_Item_level_ID__c);
              }
          }
        
      }
      system.debug('-------------test-------'+qhListAsync);
      QuoteItemMap =new Map<Id,Quote_Item_Level__c>([select id,name,Recurring__c,(select id,name,Recurring__c,Quote_Item_level_ID__c from Quote_Sub_Item_Levels__r) from Quote_Item_Level__c where Id In:QuoteitemlevelIdList]);
        
      for(Quote_Header__c qh1: qhListAsync){
          for(Quote_sub_item_level__c qsil:qh1.Quote_sub_item_levels__r ){
              if(qsil.recurring__c != null){
                  Quote_Item_Level__c Qil = QuoteItemMap.get(qsil.Quote_Item_level_ID__c);
                  if(Qil <> NULL){
                      Qil.Recurring__c=qsil.Recurring__c;
                      itemLevel.addAll(UpdateQuoteItemList);
                      if(!itemLevel.contains(QIL)){
                        UpdateQuoteItemList.add(QIL);
                      }
                  }
              }
          }
      }    
      //QuoteHEaderTriggerHelper.isQILUpdate = TRUE;
      update UpdateQuoteItemList;
      
      //=====================================================    
                  
      }       
  }  
}