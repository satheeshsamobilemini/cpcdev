/********************************************************************************************
Name   : VehicleRegistrationTrackingExtension
Author : Jyoti Singh
Date   : Jan 1, 2013
Usage  : Used in VehicleRegistrationTracking Page.
********************************************************************************************/  
public class VehicleRegistrationTrackingExtension{
    
    private static final string DEFAULT_SORT_FIELD_NAME = 'Name';
    private static final String OPERATING_STATUS_DOWN = 'Down';
    private static final String USAGE_INACTIVE = 'Inactive';
    private static final Set<String> TYPE_SET = new Set<String>{'Truck','Trailer (Delivery)','Tractor','Forklift','Service Truck'};
    
     //---------------------------------------------------------------------------//
    //Page properties and variables
    //---------------------------------------------------------------------------// 
    public String currentRecId { get; set; } 
    public boolean isAsc{set; get;}
    public string sortField{set;get;} 
    public String sortString {
        get{
            String sortOrder = isAsc ? ' ASC ' : ' DESC ';
            return sortField + sortOrder; 
        }
    }
    String previousSortField;
    
    public List<Vehicle_Registration_Tracking__c> vchlRegTrac;
    
    private List<Vehicle_Registration_Tracking__c> vchlRegTracOLD;
    
    Map<Id, Vehicle_Registration_Tracking__c> prevMapVRT;
    
    public User user;
    
    public VehicleRegistrationTrackingExtension(){
        isAsc = true;
        previousSortField = sortField = DEFAULT_SORT_FIELD_NAME;
        vchlRegTrac = new List<Vehicle_Registration_Tracking__c>();
        user = [Select Id ,Branch_Id__c, UserRole.Name from User where Id =: UserInfo.getUserId()]; 
        getVRTRecords();
        
        prevMapVRT = new Map<Id, Vehicle_Registration_Tracking__c>(vchlRegTracOLD);
    }
    
    //sort list
    public PageReference doSort(){
        isAsc = previousSortField.equals(sortField)? !isAsc : true;        
        previousSortField = sortField; 
        getVRTRecords(); 
        return null;
    }
    
    public List<Vehicle_Registration_Tracking__c> getVchlRegTrac() {
        return vchlRegTrac ;
    }
    
    public void saveRec() {
        
        Map<Id, Vehicle_Registration_Tracking__c> mapVR = new Map<Id, Vehicle_Registration_Tracking__c>(vchlRegTrac);
        if( mapVR.containsKey(currentRecId) ) {
            Vehicle_Registration_Tracking__c newVrt = mapVR.get(currentRecId);
            if(prevMapVRT.containsKey(currentRecId)){
                Vehicle_Registration_Tracking__c oldVrt = prevMapVRT.get(currentRecId);
                                 
                if(oldVrt.Usage__c != newVrt.Usage__c || oldVrt.Operating_Status__c != newVrt.Operating_Status__c || oldVrt.Type__c != newVrt.Type__c 
                    || oldVrt.Hour_or_Mileage_Reading__c != newVrt.Hour_or_Mileage_Reading__c || oldVrt.Next_PM_Due_Miles_Hours__c != newVrt.Next_PM_Due_Miles_Hours__c 
                    || oldVrt.Next_PM_Due_Date__c != newVrt.Next_PM_Due_Date__c || oldVrt.DOT_Annual_Inspection_Due_Date__c != newVrt.DOT_Annual_Inspection_Due_Date__c
                    || oldVrt.Reason_Unit_is_Down_Needs_Repairs__c != newVrt.Reason_Unit_is_Down_Needs_Repairs__c || oldVrt.Weekly_Report_Card_Comments__c != newVrt.Weekly_Report_Card_Comments__c){
                    system.debug('******update***');
                    update newVrt;
                }   
            }            
            
        }
        getVRTRecords();
    }
    
    public void getVRTRecords(){
        Map<String,String> BrandIDsMap=new Map<String,String>();
        
        for(UserRoleBranchId__c mcs :UserRoleBranchId__c.getall().values()){
            BrandIDsMap.put(mcs.Role_Name__c,mcs.Branch_Id__c);
        }
        
        List<String> BranchIDList=new List<String>();
        if(BrandIDsMap.get(user.UserRole.Name)!=null && BrandIDsMap.get(user.UserRole.Name)!='')
            BranchIDList=BrandIDsMap.get(user.UserRole.Name).split(',');

        if(user.Branch_Id__c!=null)
            BranchIDList.add(user.Branch_Id__c);
        String userId = user.Id;
        Date modifiedDate = System.today().addDays(-30);  
        String qryStr = 'Select Year__c, VIN__c, Usage__c, Type_of_Registration__c, Type__c, Weekly_Report_Card_Comments__c,  Total_Fuel_Cap_In_Gallons__c, Title_State__c, SystemModstamp, State_of_Manufacture__c, State_Reg__c, State_Approval__c, Renewed_On__c, Renewal_Notice_Received_On__c, Registered_Weight_in_lbs__c, RecordTypeId, Reason_Unit_is_Down_Needs_Repairs__c, Purchase_Price__c, Plate_Tag__c, OwnerId, Operating_Status__c, Next_PM_Due_Miles_Hours__c, Next_PM_Due_Date__c, Net_Book_Value__c, Name, Model__c, Make__c, Lease_Expiration_Date__c, LastModifiedDate, LastModifiedById, LastActivityDate, Keep_or_Sell__c, Item_Code__c, IsDeleted, Insured__c, Id, ISO__c, IFTA_Decal__c, Hour_or_Mileage_Reading__c, Have_Title__c, Expiration_Date__c, Equipment__c, Equipment_Options__c, Description__c, DOT_Annual_Inspection_Due_Date__c, CurrencyIsoCode, CreatedDate, CreatedById, Corporate_Comments__c, Branch_Manager__c, Branch_ID__c From Vehicle_Registration_Tracking__c where Type__c in :TYPE_SET and Usage__c != :USAGE_INACTIVE and Operating_Status__c != :OPERATING_STATUS_DOWN and Branch_ID__c in: BranchIDList and ((LastModifiedById !=: userId) or (LastModifiedById =: userId and LastModifiedDate <=:  modifiedDate)) order by ' + sortString;
        
        if( vchlRegTrac != null )
        {
            vchlRegTrac.clear();
        }
        
        if( vchlRegTracOLD != null )
        {
            vchlRegTracOLD.clear();
        }
        
        vchlRegTrac = Database.query(qryStr); 
        vchlRegTracOLD = Database.query(qryStr); 
    }    
}