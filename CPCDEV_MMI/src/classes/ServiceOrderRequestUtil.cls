/******************************************************************************************
Name        : ServiceOrderRequestUtil
Created on  : 29th feb,2012
Description : Utility class for trigger 'SetDispatcherAndBMOnServiceOrderRequest'
*******************************************************************************************/

public class ServiceOrderRequestUtil {
        
    public static map<String , id> branchManagerMap = new map<String , id>();
    public static map<String , id> dispatcherMap = new map<String , id>();
    public static map<String , id> areaManagerMap = new map<String , id>();
    static map<String , ServiceOrderRequestBM__c> mapServiceOrderToBranchManager = ServiceOrderRequestBM__c.getAll();
    static map<String , String> mapServiceOrderBManager = new map<String,String>();
    //Added by rajib for MSM 68
    //public static List<Email_Dispatcher__c> emailDispatcherList = null;
    //static map<String,String> mapBranchIdStartsWith9 = new map<String,String>();
    
    static map<String , Id> officeManagerMap = new map<string , Id>();
    static map<String , Id> regionalManagerMap = new map<string, Id>();
    
    // 3 char branch....
    public static map<String , id> branchManagerMap2 = new map<String , id>();
    public static map<String , id> dispatcherMap2 = new map<String , id>();
    public static map<String , id> areaManagerMap2 = new map<String , id>();
    static map<String , Id> officeManagerMap2 = new map<string , Id>();
    
    static{     
        String officeManagerProfileName = '%' + System.Label.Office_Manager_Profile + '%';
        String usrSellingRegion;
        
        for(User usr :[Select id, Branch_Id__c , name , profile.name , UserRole.Name , Plant_Code__c 
                        From User where isActive = true AND ((Plant_Code__c != null AND
                        (UserRole.Name like 'Branch Manager%' OR UserRole.Name like 'Area Manager - ETS%' OR Profile.Name like :officeManagerProfileName OR
                        (UserRole.Name like 'Branch Operations%' and Profile.Name like 'Dispatch%'))) OR (Branch_Id__c != null AND
                        (UserRole.Name like 'Branch Manager%' OR UserRole.Name like 'Area Manager - ETS%' OR Profile.Name like :officeManagerProfileName OR
                        (UserRole.Name like 'Branch Operations%' and Profile.Name like 'Dispatch%')))
                        OR (UserRole.Name like 'Regional Manager%'))]){
                        
            if(usr.profile.name.contains(System.Label.Office_Manager_Profile)){
                officeManagerMap.put(usr.Plant_Code__c , usr.Id);
                officeManagerMap2.put(usr.Branch_Id__c , usr.Id);
                
            }
            else if(usr.UserRole != null && usr.UserRole.Name.Contains('Branch Manager')){
                branchManagerMap.put(usr.Plant_Code__c , usr.Id);
                branchManagerMap2.put(usr.Branch_Id__c , usr.Id);
                
            }//added for I-28912
            else if(usr.UserRole != null && usr.UserRole.Name.Contains('Area Manager - ETS')){
                areaManagerMap.put(usr.Plant_Code__c , usr.Id);
                areaManagerMap2.put(usr.Branch_Id__c , usr.Id);
                
            }//added for credit memo 
            else if(usr.UserRoleId != null && usr.UserRole.Name.startsWith('Branch Operations')){
                dispatcherMap.put(usr.Plant_Code__c,usr.id);
                dispatcherMap2.put(usr.Branch_Id__c,usr.id);
            }else if(usr.UserRoleId != null && usr.UserRole.Name.startsWith('Regional Manager') && !usr.UserRole.Name.contains('UK')){
                usrSellingRegion = usr.UserRole.Name.remove(' ').substringAfterLast('Region');
                  usrSellingRegion = usrSellingRegion.length() == 3 ? usrSellingRegion.substring(0,1) : usrSellingRegion.substring(0,2);  
                regionalManagerMap.put(usrSellingRegion,usr.id); 
            }
        }
        for(ServiceOrderRequestBM__c SToBM : mapServiceOrderToBranchManager.values() ){
            mapServiceOrderBManager.put(sToBM.Servicing_Branch_Id__c , SToBM.Branch_Manager__c );
        }
        //Added by rajib for MSM 68
        //get dispatcher email from custom Setting
        /*emailDispatcherList = Email_Dispatcher__c.getAll().Values();
        if(emailDispatcherList != null && !emailDispatcherList.isEmpty()){
              String branchEmailList = emailDispatcherList.get(0).Branch_Email_Combination__c;
              list<String> lstBranchEmailList = branchEmailList.split(',');
              for(String s : lstBranchEmailList){
                    list<String> branchEmail = s.split('_');
                    mapBranchIdStartsWith9.put(branchEmail[0],branchEmail[1]);
              }
         } */ 
    }
    
    //Method to get service branch Id and return related branch Id 
    public static Id getbranchManagerId(String serviceBranchId){
        if(branchManagerMap.containsKey(serviceBranchId)){      
            return branchManagerMap.get(serviceBranchId);
        }
        
        if(branchManagerMap2.containsKey(serviceBranchId)){      
            return branchManagerMap2.get(serviceBranchId);
        }
        
        if(mapServiceOrderBManager.containsKey(serviceBranchId)){
            return getbranchManagerId(mapServiceOrderBManager.get(serviceBranchId));
        }                   
        return null;            
    }
    
    
    //added for I-28912 
    //Method to get service branch Id and return related branch Id 
    public static Id getDispatcherId(String serviceBranchId){
        if(dispatcherMap.containsKey(serviceBranchId)){     
            return dispatcherMap.get(serviceBranchId);
        }
        if(dispatcherMap2.containsKey(serviceBranchId)){     
            return dispatcherMap2.get(serviceBranchId);
        }       
        return null;            
    }
    
    //added for creditmemo
    //Method to get service branch Id and return related area manager Id 
    public static Id getAreaManagerId(String serviceBranchId){
        if(areaManagerMap.containsKey(serviceBranchId)){     
            return areaManagerMap.get(serviceBranchId);
        }
        if(areaManagerMap2.containsKey(serviceBranchId)){     
            return areaManagerMap2.get(serviceBranchId);
        }       
        return null;            
    }
    
    //Method to get Dispatcher email..
    /*public static string getDispatcherEmail(string serviceBranchId){
       string soql = 'select Id,Plant_Code__c,Sales_Org__c,Dispatch_Email__c from Branch_Detail_US__c where ';
        
        if(serviceBranchId.length() == 4)
          soql += 'Plant_Code__c =: serviceBranchId';
        else if(serviceBranchId.length() == 3)
          soql += 'Dispatch_Email__c like \'%serviceBranchId%\'';
            
       List<Branch_Detail_US__c> BdetailList = Database.query(soql);
       
       if(BdetailList.size() > 0) 
         return BdetailList[0].Dispatch_Email__c; 
         
       return null;    
    }*/
    
    //Method to set Approver 
    // Modified by rajib for replacing Branch Id picklist
    public static void setApprover(list<Service_Order_Request__c> sorList){
       Id recordIdETS = Schema.sObjectType.Service_Order_Request__c.getRecordTypeInfosByName().get('SAP Credit Memo (ETS) 1500').getRecordTypeId();
       for(Service_Order_Request__c sor : sorList){       
           if(recordIdETS != sor.recordTypeId){ 
            sor.Approver__c = (sor.Branch_Manager__c != null)? sor.Branch_Manager__c : 
                              (sor.dispatcher__c != null) ? sor.dispatcher__c : 
                              getBranchManagerUserId(sor.Branch_ID__c);
            sor.Approver__c = (sor.Approver__c != null) ? sor.Approver__c : 
                              regionalManagerMap.containskey(sor.Selling_Region_apr__c)?regionalManagerMap.get(sor.Selling_Region_apr__c):
                              null;
           }else{
            sor.Approver__c = (sor.Branch_Manager__c != null)? sor.Branch_Manager__c : 
                              (sor.Area_Manager__c != null)? sor.Area_Manager__c : 
                              regionalManagerMap.containskey(sor.Selling_Region_apr__c)?regionalManagerMap.get(sor.Selling_Region_apr__c):
                              null;
            
           }                   
        }
    }
   
    public static Id getOfficeManager(Id accountId , Map<Id,String> mapIdAccount){
        return mapIdAccount.ContainsKey(accountId)&& 
               officeManagerMap.ContainsKey(mapIdAccount.get(accountId))? 
               officeManagerMap.get(mapIdAccount.get(accountId)) : null;                         
    }
    
    // Added by rajib for replacing Branch Id picklist
    public static Id getOfficeManagerId(String branchId){
        String servicingBranchId = branchId;
        /*if(servicingBranchId != null && servicingBranchId != '' && servicingBranchId.startsWith('9') && mapBranchIdStartsWith9.ContainsKey(servicingBranchId)){
            servicingBranchId = mapBranchIdStartsWith9.get(servicingBranchId);
        }*/
        if(officeManagerMap.ContainsKey(servicingBranchId)){
            return officeManagerMap.get(servicingBranchId);
        }else{
            return null;
        }
    } 
    // Added by rajib for replacing Branch Id picklist
    private static Id getBranchManagerUserId(String branchId){
        String servicingBranchId = branchId;
        /*if(servicingBranchId != null && servicingBranchId != '' && servicingBranchId.startsWith('9') && mapBranchIdStartsWith9.ContainsKey(servicingBranchId)){
            servicingBranchId = mapBranchIdStartsWith9.get(servicingBranchId);
        }*/
        if(branchManagerMap.ContainsKey(servicingBranchId)){
            return branchManagerMap.get(servicingBranchId);
        }else if(branchManagerMap2.ContainsKey(servicingBranchId)){
            return branchManagerMap2.get(servicingBranchId);             
        }else if(officeManagerMap2.ContainsKey(servicingBranchId)){
            return  officeManagerMap2.get(servicingBranchId);
        }else{
            return officeManagerMap.get(servicingBranchId);
        }
    } 
    // Added by rajib for MSM68
    public static String getConvertedBranchIdStratsWith9(String branchId){
        String servicingBranchId = branchId;
        /*if(servicingBranchId != null && servicingBranchId != '' && servicingBranchId.startsWith('9') && mapBranchIdStartsWith9.ContainsKey(servicingBranchId)){
            servicingBranchId = mapBranchIdStartsWith9.get(servicingBranchId);
        }*/
        return servicingBranchId;
    } 
}