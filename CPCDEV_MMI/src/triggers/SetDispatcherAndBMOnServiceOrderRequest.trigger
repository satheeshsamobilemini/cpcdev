trigger SetDispatcherAndBMOnServiceOrderRequest on Service_Order_Request__c (before insert, before update, after insert,after update) {
    
  
      List<Service_Order_Request__c> setApproverList = new List<Service_Order_Request__c>(); // TFS 7538
    map<Id,string> mapServiceOrderRecTypeIdName = new map<Id,string>();
    List<RecordType> RecordTypeList = [select Id,name from RecordType where name in('Service Order Request (MMI) 1000','Service Order Request (ETS) 1500','Service Order Request (WMI) 1501','Credits (MMI) 1000','Credits (ETS) 1500','Credits (WMI) 1501','SAP Credit Memo (MMI) 1000','SAP Credit Memo (ETS) 1500','SAP Credit Memo (WMI) 1501','Account Issues - (MMI UK) 1200','Account Issues L - (MMI UK) 1200','Service Order Request - (MMI UK) 1200') and sObjectType='Service_Order_Request__c' and isActive = true];   //(name like 'Service Order%' OR name like 'Credit%')
      for(RecordType r : RecordTypeList)
       {  mapServiceOrderRecTypeIdName.put(r.Id,r.Name); }
    
    String branchEmailList;
    list<String> lstBranchEmailList = new list<String>();
    List<Email_Dispatcher__c> emailDispatcherList = null;
    map<String,String> mapBranchIdStartsWith9 = new map<String,String>();
    
     //get dispatcher email from custom Setting
        emailDispatcherList = Email_Dispatcher__c.getAll().Values();
        if(emailDispatcherList != null && !emailDispatcherList.isEmpty()){
          for(integer i=0; i<emailDispatcherList.size(); i++){ 
              branchEmailList = emailDispatcherList.get(i).Branch_Email_Combination__c;
              lstBranchEmailList.addAll(branchEmailList.split(','));
            } 
          for(String s : lstBranchEmailList){
                    list<String> branchEmail = s.split('_');
                    mapBranchIdStartsWith9.put(branchEmail[0],branchEmail[1]);
              }
         }
    
       
     //lslevin 7/2/2013 Story S-126181 START
    If(Trigger.isBefore){
    //lslevin 7/2/2013 Story S-126181 END
    Set<Id> accountIdSet = new Set<Id>();
    List<Service_Order_Request__c> updatedServiceOrderRequests = new List<Service_Order_Request__c>();
    set<string> sorUKbranchset = new set<string>();
    set<string> sorUSbranchset = new set<string>();
    set<string> sorUSbranchset2 = new set<string>();
    List<Service_Order_Request__c> sorUkList = new List<Service_Order_Request__c>();
    for(Service_Order_Request__c serviceOrderRequest : Trigger.New){
     if(mapServiceOrderRecTypeIdName.containskey(serviceOrderRequest.RecordTypeId) && (mapServiceOrderRecTypeIdName.get(serviceOrderRequest.RecordTypeId).contains('1000')  || mapServiceOrderRecTypeIdName.get(serviceOrderRequest.RecordTypeId).contains('1500') || mapServiceOrderRecTypeIdName.get(serviceOrderRequest.RecordTypeId).contains('1501'))){
        if(serviceOrderRequest.account_Name__c != null && (ServiceOrderRequest.id != null ? serviceOrderRequest.account_Name__c != Trigger.oldMap.get(serviceOrderRequest.id).account_Name__c : true)){         
            updatedServiceOrderRequests.add(serviceOrderRequest);               
        }
        accountIdSet.add(serviceOrderRequest.account_Name__c);
      } 
     
     
     if(trigger.isInsert && mapServiceOrderRecTypeIdName.containskey(serviceOrderRequest.RecordTypeId) && mapServiceOrderRecTypeIdName.get(serviceOrderRequest.RecordTypeId).contains('1200')){
       if(serviceOrderRequest.Branch_Id__c!='' && serviceOrderRequest.Branch_Id__c!=null){
         system.debug('------- SOR Branch --------' + serviceOrderRequest.Branch_Id__c );
         system.debug('------- SOR Branch --------' + serviceOrderRequest.Branch_Id__c.substring(0,4) );
         sorUKbranchset.add(serviceOrderRequest.Branch_Id__c.substring(0,4));
         sorUkList.add(serviceOrderRequest);   
      }
     } 
     
     if(trigger.isUpdate && mapServiceOrderRecTypeIdName.containskey(serviceOrderRequest.RecordTypeId) && mapServiceOrderRecTypeIdName.get(serviceOrderRequest.RecordTypeId).contains('1200')){
       system.debug('------------Branch User UK -------------'+serviceOrderRequest.Branch_User_UK__c );
       system.debug('------------Current Status -------------'+serviceOrderRequest.status__c );
       system.debug('------------ Old Status -------------'+ trigger.oldMap.get(serviceOrderRequest.Id).status__c );
       if(serviceOrderRequest.status__c == 'Approved' && trigger.oldMap.get(serviceOrderRequest.Id).status__c == 'Awaiting Approval' && serviceOrderRequest.Branch_User_UK__c != null) 
        serviceOrderRequest.OwnerId = serviceOrderRequest.Branch_User_UK__c;
       if(serviceOrderRequest.status__c == 'Approved' && trigger.oldMap.get(serviceOrderRequest.Id).status__c == 'Submitted' && serviceOrderRequest.Branch_User_UK__c != null && trigger.OldMap.get(serviceOrderRequest.Id).isUKOtherAccounts__c == false && serviceOrderRequest.isUKOtherAccounts__c) 
         serviceOrderRequest.OwnerId = serviceOrderRequest.Branch_User_UK__c;  
      }  
   }
    // commented by rajib for replacing Branch Id picklist
    //Map<Id,String> accountServicingIdMap = new Map<Id,String>();
    //Map<Id,String> dispatchEmailIdMap = new Map<Id,String>();
    // commented by rajib for replacing Branch Id picklist
    /*for(Account account : [select Id, Servicing_Branch_Id__c from Account where id in : accountIdSet]){
        if(account.servicing_Branch_Id__c != null){
            String servicingBranchId = account.servicing_Branch_Id__c;
            if(servicingBranchId.startsWith('9')){
                servicingBranchId = '1'  +servicingBranchId.subString(1,servicingBranchId.length());
                
            }
            dispatchEmailIdMap.put(account.id,servicingBranchId+'_ServiceRequest@mobilemini.com');
            accountServicingIdMap.put(account.id,account.servicing_Branch_Id__c);
        }
    }*/    
        
    for(Service_Order_Request__c sor : updatedServiceOrderRequests){
        
        String servicingBranchId = sor.Branch_ID__c;
         // TFS 7538 fix
          if(servicingBranchId!=null && servicingBranchId.length() > 4)
           { servicingBranchId = servicingBranchId.subString(0,4); }
        String dispatcherEmail = '';
        String dispatcherServicingBranchId = servicingBranchId;
        if(servicingBranchId != null && servicingBranchId != '' && mapBranchIdStartsWith9.containskey(servicingBranchId)){
            //dispatcherServicingBranchId = ServiceOrderRequestUtil.getConvertedBranchIdStratsWith9(servicingBranchId);
            dispatcherServicingBranchId = mapBranchIdStartsWith9.get(servicingBranchId); 
        }
        if(dispatcherServicingBranchId != null && dispatcherServicingBranchId != ''){
           sor.Interim_Value__c =  dispatcherServicingBranchId;
            if(dispatcherServicingBranchId.length() == 4)
               sorUSbranchset.add(dispatcherServicingBranchId);
            else if(dispatcherServicingBranchId.length() == 3) 
               sorUSbranchset2.add(dispatcherServicingBranchId); 
        }
        
        if(servicingBranchId != null && servicingBranchId != ''){
            sor.branch_Manager__c = ServiceOrderRequestUtil.getbranchManagerId(servicingBranchId);  
            //added for I-28912 
            sor.Dispatcher__c = ServiceOrderRequestUtil.getDispatcherId(servicingBranchId);
            //added for credit memo
            sor.Area_Manager__c = ServiceOrderRequestUtil.getAreaManagerId(servicingBranchId);         
        }
        
        // commented by rajib for replacing Branch Id picklist
        /*if(dispatchEmailIdMap.containsKey(sor.account_Name__c)){
            sor.Dispatcher_Email__c = dispatchEmailIdMap.get(sor.account_Name__c);
        }*/
      
    }
    
    map<string,string> mapBranchEmailUS = new map<string,string>(); 
    if(sorUSbranchset.size() > 0 || sorUSbranchset2.size() > 0){
        string soql = 'select Id,Plant_Code__c,Sales_Org__c,Dispatch_Email__c from Branch_Detail_US__c where ';
        string str='';
        
        if(sorUSbranchset.size() > 0)
          soql += 'Plant_Code__c =: sorUSbranchset ';
        
        if(sorUSbranchset.size() == 0 && sorUSbranchset2.size() > 0){
          for(string s : sorUSbranchset2){
           str = '%' + s + '%';
           soql += 'Dispatch_Email__c like: str';
          }           
        }
        
        if(sorUSbranchset.size() > 0 && sorUSbranchset2.size() > 0){
          for(string s : sorUSbranchset2){
           str = '%' + s + '%';
           soql += 'OR Dispatch_Email__c like: str';
          } 
        }  
       
       system.debug('--------- soql ------------' + soql);
            
       List<Branch_Detail_US__c> BdetailList = Database.query(soql);
          for(Branch_Detail_US__c bd : BdetailList){
             if(sorUSbranchset.contains(bd.Plant_Code__c))
               mapBranchEmailUS.put(bd.Plant_Code__c,bd.Dispatch_Email__c);
             
             if(sorUSbranchset2.contains(string.valueOf(bd.Dispatch_Email__c).substring(0,3)))  
               mapBranchEmailUS.put(string.valueOf(bd.Dispatch_Email__c).substring(0,3),bd.Dispatch_Email__c);
          }
    }
    
     for(Service_Order_Request__c sor : updatedServiceOrderRequests){
       string dispatcherEmail = '';
       if(sor.Interim_Value__c != null && sor.Interim_Value__c != ''){
          dispatcherEmail = mapBranchEmailUS.containskey(sor.Interim_Value__c) ? mapBranchEmailUS.get(sor.Interim_Value__c) : null;
          sor.Dispatcher_Email__c = dispatcherEmail;
        }
     }
  
    if(sorUkList.size() > 0){
      map<string,id> mapBranchUId = new map<string,Id>(); 
      map<string,string> mapBrCodeBrName = new map<string,string>();
      list<string> bList = new list<string>();
      List<UKBranchUsers__c> ukList = UKBranchUsers__c.getAll().values();
       
       if(ukList.size() > 0){
        for(integer i=0;i<ukList.size(); i++){
          bList.addAll(ukList[i].BranchName__c.split('_'));
          mapBranchUId.put(bList[0],bList[1]);
          bList.clear();
        } 
       }
       
      List<User> uList = [select Id,Branch_id__c,Plant_Code__c from User where Plant_Code__c in: sorUKbranchset and UserRole.Name like 'Branch Operations%' and IsUKCaseUser__c = true and isActive = true];
      
      List<Branch_Detail__c> brList = [select Id,Branch_Email__c,Branch_Code__c,Plant_Code__c from Branch_Detail__c where Plant_Code__c in: sorUKbranchset];
      
       if(uList.size() > 0){ 
        for(User u : uList){
           mapBranchUId.put(u.Plant_Code__c,u.Id);
           system.debug('-----------------User Branch ---------' + u.Plant_Code__c);
           system.debug('-----------------User Id ---------' + u.Id);
          } 
         }
        
        if(brList.size() > 0){
         for(Branch_Detail__c b : brList){
          mapBrCodeBrName.put(b.Plant_Code__c,b.Branch_Email__c);
          system.debug('-----------------Branch Code---------' + b.Plant_Code__c);
          system.debug('-----------------Branch Name---------' + b.Branch_Email__c);
         }
        } 
         
        for(Service_Order_Request__c sor : sorUkList){
         if(mapBranchUId.containskey(sor.Branch_Id__c.substring(0,4)))
          sor.Branch_User_UK__c = mapBranchUId.get(sor.Branch_Id__c.substring(0,4)); 
         if(mapBrCodeBrName.containskey(sor.Branch_Id__c.substring(0,4)))
          sor.Branch_Email_UK__c = mapBrCodeBrName.get(sor.Branch_Id__c.substring(0,4));  
        }  
    }
 // populate customer request selling region ..   
   map<Id,string> mapIdPostal = new map<Id,string>();
   map<string,string> mapPostalSR = new map<string,string>();
    if(accountIdSet.size() > 0){       
       Account[] acclist = [select BillingPostalCode,BillingCountry from account where id in: accountIdSet];
        for(account acc : acclist)
         mapIdPostal.put(acc.Id,AssignmentRules.getZipCodeConversion(acc.BillingPostalCode,acc.BillingCountry));
       if(mapIdPostal.keyset().size() > 0){
        Branch_Lookup__c[] bList = [select Selling_Region__c,zip__c from Branch_LookUp__c where zip__c in: mapIdPostal.values()];
          for(Branch_Lookup__c branch : bList)
           mapPostalSR.put(branch.zip__c,string.valueOf(Integer.valueOf(branch.Selling_Region__c)));  
       }             
   }   
      
   for(Service_Order_Request__c sor : trigger.new){
     if(mapServiceOrderRecTypeIdName.containskey(sor.RecordTypeId) && (mapServiceOrderRecTypeIdName.get(sor.RecordTypeId).contains('1000')|| mapServiceOrderRecTypeIdName.get(sor.RecordTypeId).contains('1500') || mapServiceOrderRecTypeIdName.get(sor.RecordTypeId).contains('1501'))) 
      { if(sor.account_Name__c != null && mapIdPostal.containskey(sor.account_Name__c) && mapPostalSR.containskey(mapIdPostal.get(sor.account_Name__c)))
           sor.Selling_Region_apr__c = mapPostalSR.get(mapIdPostal.get(sor.account_Name__c));
        setApproverList.add(sor); 
      } 
    }   
    // Modified by rajib for replacing Branch Id picklist
    ServiceOrderRequestUtil.setApprover(setApproverList);
    //lslevin 7/2/2013 Story S-126181 START
   }
    
    If(Trigger.isAfter){
     Boolean reqApproval = false;
     string recTypeName;
     List<Id> sorIdList = new List<Id>();
     User currUser = [select Id,Name,Alias from User where Id =: UserInfo.getUserId() LIMIT 1];
      
        For(Service_Order_Request__c s : trigger.new){
         if(mapServiceOrderRecTypeIdName.containskey(s.RecordTypeId)){
           recTypeName = mapServiceOrderRecTypeIdName.get(s.RecordTypeId);
           system.debug('------recTypeName --------' + recTypeName);
           
           if(Trigger.isInsert && (recTypeName.contains('Service Order Request (MMI) 1000') || recTypeName.contains('Service Order Request (ETS) 1500') || recTypeName.contains('Service Order Request (WMI) 1501') || recTypeName.contains('Credits (MMI) 1000') || recTypeName.contains('Credits (ETS) 1500') || recTypeName.contains('Credits (WMI) 1501')))
              reqApproval = true;
           
           /*if(Trigger.isUpdate && recTypeName.contains('Credits (MMI) 1000') && ((s.Status__c == 'In Process'  && Trigger.OldMap.get(s.Id).Status__c != 'In Process')||(s.Status__c == 'Pending BM Approval'  && Trigger.OldMap.get(s.Id).Status__c != 'Pending BM Approval') )){
              reqApproval = true;
              sorIdList.add(s.Id);   
            }*/
            
             if(Trigger.isUpdate && (recTypeName.contains('SAP Credit Memo (MMI) 1000') || recTypeName.contains('SAP Credit Memo (ETS) 1500') || recTypeName.contains('SAP Credit Memo (WMI) 1501')) && s.Status__c == 'SAP Credit Process'  && Trigger.OldMap.get(s.Id).Status__c != 'SAP Credit Process'){
              reqApproval = true;
              sorIdList.add(s.Id);  
            }
            
            if(Trigger.isUpdate && (recTypeName.contains('SAP Credit Memo (MMI) 1000') || recTypeName.contains('SAP Credit Memo (ETS) 1500') || recTypeName.contains('SAP Credit Memo (WMI) 1501')) && s.Status__c == 'Submitted'  && Trigger.OldMap.get(s.Id).Status__c != 'Submitted' && s.Amount_Of_Credit_Rollup__c > 200.00){
              
              sorIdList.add(s.Id);   
            }
               
         
           else if(Trigger.isInsert && recTypeName.contains('Account') && (s.Account__c=='716447' || s.Account__c=='80116218') && currUser.alias!='hhug' && currUser.alias!='dwill' && s.Branch_Id__c!=null && s.Branch_Id__c!='')
              reqApproval = true;
           else if(Trigger.isInsert && recTypeName.contains('Account') && s.Account__c=='710677' && currUser.alias!='akell' && currUser.alias!='eroic'&& s.Branch_Id__c!=null && s.Branch_Id__c!='')
              reqApproval = true;
           else if(Trigger.isInsert && recTypeName.contains('1200') && s.Account_Owner_Profile_UK__c=='National Accounts Manager/Coordinator - UK' && s.Requester_Profile_Name_UK__c!='National Accounts Manager/Coordinator - UK' && s.Branch_Id__c!=null && s.Branch_Id__c!='')  
              reqApproval = true;
           else if(Trigger.isInsert && recTypeName.contains('1200') && s.Account_Owner_Profile_UK__c=='Strategic Account Manager – UK' && s.Requester_Profile_Name_UK__c!='National Accounts Manager/Coordinator - UK' && s.Requester_Profile_Name_UK__c!='Strategic Account Manager – UK' && s.Branch_Id__c!=null && s.Branch_Id__c!='')  
              reqApproval = true;
           else if(Trigger.isInsert && recTypeName.contains('1200') && s.Branch_Id__c!=null && s.Branch_Id__c!='' && s.Branch_User_UK__c != null)
              reqApproval = true;
                
                      
         if(reqApproval ){ 
            Approval.Processsubmitrequest app = new Approval.Processsubmitrequest();
            app.setObjectId(s.id);
            Approval.Processresult result = Approval.process(app);
         } 
       }  
     }
     if(sorIdList.size() > 0) 
       CreditMemoReqResp.sendReq(sorIdList);
      
    }
    //lslevin 7/2/2013 Story S-126181 END
  
  
  
  
  
  
  
  //------- OLDER CODE BEFORE CREDIT MEMO -------
  
   /* List<Service_Order_Request__c> setApproverList = new List<Service_Order_Request__c>(); // TFS 7538
    Set<Id> serviceOrderRecTypeIdset = new Set<Id>();
    List<RecordType> RecordTypeList = [select Id,name from RecordType where name in('Service Order Request (MMI) 1000','Credits (MMI) 1000','Service Order Request - (MMI UK) 1200') and sObjectType='Service_Order_Request__c'];   //(name like 'Service Order%' OR name like 'Credit%')
      for(RecordType r : RecordTypeList)
       {  serviceOrderRecTypeIdset.add(r.Id); }
       
     //lslevin 7/2/2013 Story S-126181 START
    If(Trigger.isBefore){
    //lslevin 7/2/2013 Story S-126181 END
    Set<Id> accountIdSet = new Set<Id>();
    List<Service_Order_Request__c> updatedServiceOrderRequests = new List<Service_Order_Request__c>();
    for(Service_Order_Request__c serviceOrderRequest : Trigger.New){
     if(serviceOrderRecTypeIdset.contains(serviceOrderRequest.RecordTypeId)){
        if(serviceOrderRequest.account_Name__c != null && (ServiceOrderRequest.id != null ? serviceOrderRequest.account_Name__c != Trigger.oldMap.get(serviceOrderRequest.id).account_Name__c : true)){         
            updatedServiceOrderRequests.add(serviceOrderRequest);
        }
        accountIdSet.add(serviceOrderRequest.account_Name__c);
      } 
    }*/
    // commented by rajib for replacing Branch Id picklist
    //Map<Id,String> accountServicingIdMap = new Map<Id,String>();
    //Map<Id,String> dispatchEmailIdMap = new Map<Id,String>();
    // commented by rajib for replacing Branch Id picklist
    /*for(Account account : [select Id, Servicing_Branch_Id__c from Account where id in : accountIdSet]){
        if(account.servicing_Branch_Id__c != null){
            String servicingBranchId = account.servicing_Branch_Id__c;
            if(servicingBranchId.startsWith('9')){
                servicingBranchId = '1'  +servicingBranchId.subString(1,servicingBranchId.length());
                
            }
            dispatchEmailIdMap.put(account.id,servicingBranchId+'_ServiceRequest@mobilemini.com');
            accountServicingIdMap.put(account.id,account.servicing_Branch_Id__c);
        }
    }*/
        
   /* for(Service_Order_Request__c sor : updatedServiceOrderRequests){
        
        String servicingBranchId = sor.Branch_ID__c;
         // TFS 7538 fix
          if(servicingBranchId!=null && servicingBranchId.length() > 3)
           { servicingBranchId = servicingBranchId.subString(0,3); }
        String dispatcherEmail = '';
        String dispatcherServicingBranchId = servicingBranchId;
        if(servicingBranchId != null && servicingBranchId != '' && servicingBranchId.startsWith('9')){
            dispatcherServicingBranchId = ServiceOrderRequestUtil.getConvertedBranchIdStratsWith9(servicingBranchId);
        }
        if(dispatcherServicingBranchId != null && dispatcherServicingBranchId != ''){
            dispatcherEmail = dispatcherServicingBranchId+'_ServiceRequest@mobilemini.com';
            sor.Dispatcher_Email__c = dispatcherEmail;
        }
        
        if(servicingBranchId != null && servicingBranchId != ''){
            sor.branch_Manager__c = ServiceOrderRequestUtil.getbranchManagerId(servicingBranchId);  
            //added for I-28912 
            sor.Dispatcher__c = ServiceOrderRequestUtil.getDispatcherId(servicingBranchId);         
        }*/
        
        // commented by rajib for replacing Branch Id picklist
        /*if(dispatchEmailIdMap.containsKey(sor.account_Name__c)){
            sor.Dispatcher_Email__c = dispatchEmailIdMap.get(sor.account_Name__c);
        }*/
      
   // }
    
   /*for(Service_Order_Request__c sor : trigger.new){
     if(serviceOrderRecTypeIdset.contains(sor.RecordTypeId)) 
      { setApproverList.add(sor); } 
    }   
    // Modified by rajib for replacing Branch Id picklist
    ServiceOrderRequestUtil.setApprover(setApproverList);
    //lslevin 7/2/2013 Story S-126181 START
   }
    
    If(Trigger.isAfter){
        For(Service_Order_Request__c s : trigger.new){
          if(serviceOrderRecTypeIdset.contains(s.RecordTypeId)){  
            Approval.Processsubmitrequest app = new Approval.Processsubmitrequest();
            app.setObjectId(s.id);
            Approval.Processresult result = Approval.process(app);
          }  
        }
    }*/
    //lslevin 7/2/2013 Story S-126181 END
    
  
    
}