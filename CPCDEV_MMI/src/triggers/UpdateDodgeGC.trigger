/**
*  Name               :       UpdateDodgeGC
* Created Date        :       20th September, 2013 @ 12:02
* Created By          :       Akanksha for Story S-140427
* Purpose             :       logic for update of Dodge Project related to Company Object
* Update By           :       TEK Developer
* Updated Date        :       6th June 2015 
*
**/
//Created by Akanksha for Story S-140427
trigger UpdateDodgeGC on Company__c (after insert, after Update) {   
    List<Dodge_Project__c> dpToUpdate = new List<Dodge_Project__c>();
    Set<id> dpid = new Set<id>(); 
    
    // TFS 4430 .. Sales Restructure 2015
    set<string> ckmsSet = new set<string>(); 
    set<Id> DodgeIDset = new set<Id>();      
    set<String> BranchIDset = new set<string>(); 
    map<string,Account> ckmsbrnchAccountMap = new map<string,Account>();
    map<string,Dodge_Project__c> reportNumDodgeMap = new map<string,Dodge_Project__c>();
    map<string,Dodge_Project__c> reportNumDodgeUpdateMap = new map<string,Dodge_Project__c>();   
    list<Messaging.SingleEmailMessage> mailList = new list<Messaging.SingleEmailMessage>(); // Sales Restructure 2015
    list<Company__c> companyList = new list<Company__c>();  
    Boolean addCKMS;
          
  if(!trigger.isDelete) {  
    for(Company__c  cmp : trigger.new)
    {
        if('Construction Manager'.equalsIgnoreCase(cmp.Factor_Type__c))
        {
            dpid.add(cmp.Dodge_Project__c);
        }
        
     // TFS 4430.. 
     if(trigger.isInsert) // Sales Restructure 2015
      { DodgeIDset.add(cmp.Dodge_Project__c); }  
    }
   } 
    for(id dp : dpid)
    {
        Dodge_Project__c dpdata = new Dodge_Project__c(id = dp, GC_Awarded__c = true);
        dpToUpdate.add(dpdata);
    }
    if(dpToUpdate != null && dpToUpdate.size() >0)
    {    
        upsert dpToUpdate;
    }
    
    // TFS 4430 --> Sales Restructure 2015
   
   // Dodge Project related to Company
   for(Dodge_Project__c d : [select Id,Dodge_Report_Number__c,Zip__c,Country__c,Branch_ID__c,GC_Awarded__c, Sales_Rep__c,BM_Approver__c,ISM_Approver__c,
                            isRepActive__c,isBMactive__c,isISMactive__c from Dodge_Project__c where Id =: DodgeIDset]){
      reportNumDodgeMap.put(d.Dodge_Report_Number__c,d); 
      BranchIDset.add(d.Branch_ID__C);      
    } 
      
   if(trigger.isInsert)
    { for(integer i = 0; i < trigger.new.size(); i++)
       {  addCKMS = false;
          if(DodgeMcGrawHillDataWS.IsGeneralContractor(trigger.new[i],null) || DodgeMcGrawHillDataWS.IsConstructionManager(trigger.new[i],null))
           { companyList.add(trigger.new[i]); 
             addCKMS = true;
              if(reportNumDodgeMap.containskey(trigger.new[i].Dodge_Report_Number__c))
              { reportNumDodgeMap.get(trigger.new[i].Dodge_Report_Number__c).GC_Awarded__c = true;
                reportNumDodgeUpdateMap.put(trigger.new[i].Dodge_Report_Number__c,reportNumDodgeMap.get(trigger.new[i].Dodge_Report_Number__c));
              }
             
           }
          else if(DodgeMcGrawHillDataWS.IsHighBidder(trigger.new[i],null,null)) 
           { companyList.add(trigger.new[i]);  
             addCKMS = true;
           }
         if((trigger.new[i].CKMS__c <> null) && addCKMS && !CKMSSet.contains(trigger.new[i].CKMS__c))
          { ckmsSet.add(trigger.new[i].CKMS__c); }   
       }     
    } 
    
  // Creation of Dodge Leads with Hot/Warm Rating.. --> Sales Restructure 2015 
   if(companyList.size() > 0){
       for(Account a : [select Id, Name, FactorKey__c, CKMS__c, Branch__c, ownerId, Owner.IsActive,CreatedDate,isSPOC_Account__c from Account 
                        where CKMS__c in :ckmsSet AND Branch__c in : BranchIDset AND Owner.IsActive = True ORDER BY CreatedDate DESC])   
        { ckmsbrnchAccountMap.put(a.CKMS__c + ':' + a.Branch__c,a);} 
        
       
       for(Company__c cm : companyList){
         string branch;
         Account acc = null;
         Dodge_Project__c dp = null;
         Id uId = null;
                
          if(reportNumDodgeMap.containskey(cm.Dodge_Report_Number__c)){
            dp = reportNumDodgeMap.get(cm.Dodge_Report_Number__c);
            branch = reportNumDodgeMap.get(cm.Dodge_Report_Number__c).Branch_ID__c;
          }
           
          if(branch!=null && ckmsbrnchAccountMap.containskey(cm.CKMS__c + ':' + branch)){  // account related to Company/Dodge
           acc = ckmsbrnchAccountMap.get(cm.CKMS__c + ':' + branch); 
          } 
          
          if(acc!=null && acc.isSPOC_Account__c){
           uId = acc.ownerId;   
          }else if(dp.Sales_Rep__c!=null && dp.isRepActive__c){
           uId = dp.Sales_Rep__c;   
          }else if(dp.BM_Approver__c!=null && dp.isBMactive__c){
           uId = dp.BM_Approver__c;     
          }else if(dp.ISM_Approver__c!=null && dp.isISMactive__c){
           uId = dp.ISM_Approver__c; 
          } 
         
          if(uId!=null){
           string sub = 'New Sub Contractor Added';
           string body = 'Hi,<br/><br/></n></n>A new subcontractor has been added to a Dodge Project in your territory. Please review the Dodge Project and Subcontractor<br/><br/></n></n>'+ System.URL.getSalesforceBaseUrl().toExternalForm()+'/'+dp.Id;
           Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
           mail.setSubject(sub);
           mail.setHTMLBody(body);
           mail.setTargetObjectId(uId);
           mail.setSaveAsActivity(false);
           mailLIst.add(mail);  
          }
      }
  } 
  
   if(mailList.size() > 0){
    Messaging.sendEmail(mailList); // send mail notification to user
   }
    
   if(reportNumDodgeUpdateMap.values().size() > 0)    // update of Dodge Project        
    { update reportNumDodgeUpdateMap.values(); }   
     
}