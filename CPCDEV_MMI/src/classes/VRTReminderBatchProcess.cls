/********************************************************************************************
Name   : VRTReminderBatchProcess
Author : Jyoti Singh
Date   : Feb 15, 2013
Usage  : Used to send Email.
********************************************************************************************/  
global class VRTReminderBatchProcess implements Database.Batchable<sobject>{
    
    Static final String OPERATING_STATUS_DOWN = 'Down';
    Static final String USAGE_INACTIVE = 'Inactive';
    Static final Set<String> TYPE_SET = new Set<String>{'Truck','Trailer (Delivery)','Tractor','Forklift','Service Truck'};
    
    global DateTime filterDate;
    global String lastModifiedByQry = '';
    global List<String> finalEmailList;
    
    global VRTReminderBatchProcess(){
        finalEmailList = new List<String>();
    }
     
    global Database.QueryLocator start(Database.batchableContext bc){
        filterDate = DateTime.now();
        
        if(filterDate != null ){
            if(filterDate.format('EEE') =='Mon'){
                filterDate =  filterDate.addDays(-30);
                lastModifiedByQry = ' AND (LastModifiedBy.userRole.Name like \'Branch Manager%\' OR LastModifiedBy.userRole.Name like \'Branch Operations%\')';
            }
            if(filterDate.format('EEE') =='Wed'){
                filterDate =  filterDate.addDays(-37);
                lastModifiedByQry = ' AND (LastModifiedBy.userRole.Name like \'Branch Manager%\' OR LastModifiedBy.userRole.Name like \'Branch Operations%\' OR LastModifiedBy.userRole.Name like \'Regional Manager%\')';
            }
            if(filterDate.format('EEE') =='Fri'){
                filterDate =  filterDate.addDays(-44);
                lastModifiedByQry = ' AND (LastModifiedBy.userRole.Name like \'Branch Manager%\' OR LastModifiedBy.userRole.Name like \'Branch Operations%\' OR LastModifiedBy.userRole.Name like \'Regional Manager%\' OR LastModifiedBy.userRole.Name like \'SVP Sales - Western Division US%\' OR LastModifiedBy.userRole.Name like \'SVP Sales - Eastern Division US%\')';
            }
        }
        String vrtQuery;
        if(test.isRunningTest() )  {  
            vrtQuery = 'Select Year__c, VIN__c, Usage__c, Type_of_Registration__c, Type__c, Weekly_Report_Card_Comments__c,  Total_Fuel_Cap_In_Gallons__c, Title_State__c, SystemModstamp, State_of_Manufacture__c, State_Reg__c, State_Approval__c, Renewed_On__c, Renewal_Notice_Received_On__c, Registered_Weight_in_lbs__c, RecordTypeId, Reason_Unit_is_Down_Needs_Repairs__c, Purchase_Price__c, Plate_Tag__c, OwnerId, Operating_Status__c, Next_PM_Due_Miles_Hours__c, Next_PM_Due_Date__c, Net_Book_Value__c, Name, Model__c, Make__c, Lease_Expiration_Date__c, LastModifiedDate, LastActivityDate, Keep_or_Sell__c, Item_Code__c, IsDeleted, Insured__c, Id, ISO__c, IFTA_Decal__c, Hour_or_Mileage_Reading__c, Have_Title__c, Expiration_Date__c, Equipment__c, Equipment_Options__c, Description__c, DOT_Annual_Inspection_Due_Date__c, CurrencyIsoCode, CreatedDate, CreatedById, Corporate_Comments__c, Branch_Manager__c, Branch_ID__c, LastModifiedBy.Branch_Id__c, LastModifiedBy.UserRole.Name, LastModifiedBy.Email, LastModifiedById From Vehicle_Registration_Tracking__c where Type__c in :TYPE_SET and Usage__c != :USAGE_INACTIVE and LastModifiedDate <=: filterDate and LastModifiedBy.isActive = true and Operating_Status__c != :OPERATING_STATUS_DOWN ' + lastModifiedByQry ;
            }
        else 
            vrtQuery = 'Select Year__c, VIN__c, Usage__c, Type_of_Registration__c, Type__c, Weekly_Report_Card_Comments__c,  Total_Fuel_Cap_In_Gallons__c, Title_State__c, SystemModstamp, State_of_Manufacture__c, State_Reg__c, State_Approval__c, Renewed_On__c, Renewal_Notice_Received_On__c, Registered_Weight_in_lbs__c, RecordTypeId, Reason_Unit_is_Down_Needs_Repairs__c, Purchase_Price__c, Plate_Tag__c, OwnerId, Operating_Status__c, Next_PM_Due_Miles_Hours__c, Next_PM_Due_Date__c, Net_Book_Value__c, Name, Model__c, Make__c, Lease_Expiration_Date__c, LastModifiedDate, LastActivityDate, Keep_or_Sell__c, Item_Code__c, IsDeleted, Insured__c, Id, ISO__c, IFTA_Decal__c, Hour_or_Mileage_Reading__c, Have_Title__c, Expiration_Date__c, Equipment__c, Equipment_Options__c, Description__c, DOT_Annual_Inspection_Due_Date__c, CurrencyIsoCode, CreatedDate, CreatedById, Corporate_Comments__c, Branch_Manager__c, Branch_ID__c, LastModifiedBy.Branch_Id__c, LastModifiedBy.UserRole.Name, LastModifiedBy.Email, LastModifiedById From Vehicle_Registration_Tracking__c where Type__c in :TYPE_SET and Usage__c != :USAGE_INACTIVE and LastModifiedDate <=: filterDate and LastModifiedBy.isActive = true and Operating_Status__c != :OPERATING_STATUS_DOWN ' + lastModifiedByQry + ' order by Branch_ID__c ';
        if(test.isRunningTest()){
            vrtQuery += ' Limit 10';
        }
        system.debug('****vrtQuery****'+vrtQuery);
        return Database.getQueryLocator(vrtQuery);
    }
    
    global void execute(Database.batchableContext bc, List<sobject> scope){
        system.debug('****scope****'+scope);
        finalEmailList.addAll(VRTReminderUtil.sendMail(scope));
        VRTReminderUtil.sendfinalEmail(finalEmailList);
    }
    
    global void finish(Database.batchableContext bc){
        
    }
    @isTest(SeeAllData = true)
   
    public static void batchTest(){
       VRTReminderBatchProcess batch = new VRTReminderBatchProcess ();                
       Test.startTest();
       Database.executeBatch(batch , 200);
       Test.stopTest();
   }
    
}