public class PersonalCallMentoringSessionController {

    public Call_Mentoring_Session__c callMentoringSession{get;set;}
    public Boolean isEdit{get;set;}
    public Integer maxSalesPersonRating{get;set;}
    public Integer maxEffectiveness{get;set;}
    public Integer salesPersonRating{get;set;}
    public Integer effectiveRating{get;set;}
    public String bestOfBestCategory{get;set;}
    private String retURL; 
    private ID recordTypeID;
    public PersonalCallMentoringSessionController(ApexPages.StandardController stdController){
        String recordId = stdController.getId();
        String edit = ApexPages.currentPage().getParameters().get('Edit');
        String clone = ApexPages.currentPage().getParameters().get('clone');
        retURL = ApexPages.currentPage().getParameters().get('retURL');
        recordTypeID = (ID) ApexPages.currentPage().getParameters().get('RecordType');
        
        if(recordId != null){ 
         // TFS 3528
         /*   
            for(Call_Mentoring_Session__c cms : [Select c.RecordTypeId, c.Type_of_Customer__c, c.Type_of_Coach__c, c.Type_of_Call__c, c.Transaction_Type__c, c.Transaction_Type_Other__c,
                                                c.SystemModstamp, c.Salesperson_s_Star_Rating_of_CS__c, c.Salesperson_s_Notes_and_or_Action_Plan__c, c.Sales_Rep__c, 
                                                c.Sales_Rep_Name__c, c.Sales_Rep_Id__c, c.Sales_Rep_Extension__c, c.Sales_Rep_Branch_Id__c, c.Questions_to_Coach_if_any__c, 
                                                c.Purpose_of_Call__c, c.Purpose_of_Call_Other__c, c.Product_Need__c, c.Product_Need_Other__c, c.OwnerId, c.Overall_Effectiveness_of_Call__c,
                                                c.Other_Comments_Customer_Needs__c, c.Name,c.Mentor__c, c.LastActivityDate, c.Id,
                                                c.Experience_with_MMI__c, c.Existing_or_New_Customer__c, c.Determine_Previous_Experience__c,c.Comments_feedback_about_your_session__c,
                                                c.Best_Of_the_Best__c, c.Best_Of_the_Best_Category__c, c.Best_Of_the_Best_Comments__c,c.Date_Time_of_Call__c,c.Rep_Comments_Goal__c,
                                                c.coaching_Topic_1__c,c.coach_Comments_1__c,c.coaching_Topic_2__c,c.coach_Comments_2__c,c.coaching_Topic_3__c,c.coach_Comments_3__c,
                                                c.Rep_Name__c, c.Type_of_Training_Mentoring__c , c.Rep_Date__c,   
                                                c.Call_Title__c,c.Employee_Name__c, c.Employee_Type__c From Call_Mentoring_Session__c c where c.id = : recordId ]){    
         */
            for(Call_Mentoring_Session__c cms : [Select c.RecordTypeId, c.Type_of_Customer__c, c.Type_of_Coach__c, c.Type_of_Call__c, c.Transaction_Type__c, c.Transaction_Type_Other__c,
                                                c.SystemModstamp, c.Salesperson_s_Star_Rating_of_CS__c, c.Salesperson_s_Notes_and_or_Action_Plan__c, c.Sales_Rep__c, 
                                                c.Sales_Rep_Name__c, c.Sales_Rep_Id__c, c.Sales_Rep_Extension__c, c.Sales_Rep_Branch_Id__c, c.Questions_to_Coach_if_any__c, 
                                                c.Purpose_of_Call__c, c.Purpose_of_Call_Other__c, c.Product_Need__c, c.Product_Need_Other__c, c.OwnerId, c.Overall_Effectiveness_of_Call__c,
                                                c.Name,c.Mentor__c, c.LastActivityDate, c.Id,
                                                c.Experience_with_MMI__c, c.Existing_or_New_Customer__c, c.Comments_feedback_about_your_session__c,
                                                c.Best_Of_the_Best__c, c.Best_Of_the_Best_Category__c, c.Best_Of_the_Best_Comments__c,c.Date_Time_of_Call__c,c.Rep_Comments_Goal__c,
                                                c.coaching_Topic_1__c,c.coach_Comments_1__c,c.coaching_Topic_2__c,c.coach_Comments_2__c,c.coaching_Topic_3__c,c.coach_Comments_3__c,
                                                c.Rep_Name__c, c.Type_of_Training_Mentoring__c , c.Rep_Date__c,   
                                                c.Employee_Name__c, c.Employee_Type__c From Call_Mentoring_Session__c c where c.id = : recordId ]){    
                                          
                callMentoringSession = cms;
                bestOfBestCategory= cms.Best_of_the_best_Category__c;
            }
        }
        if(callMentoringSession == null){
            callMentoringSession = new Call_Mentoring_Session__c();
            callMentoringSession.Salesperson_s_Star_Rating_of_CS__c = '0';
            callMentoringSession.Overall_Effectiveness_of_Call__c = '0';
            callMentoringSession.RecordTypeId = recordTypeID;
            bestOfBestCategory = '';
            
        }
        if(clone != null && clone == '1'){
            Call_Mentoring_Session__c cmsClone = callMentoringSession.clone(false,true);
            callMentoringSession = cmsClone;
        }
        salesPersonRating = callMentoringSession.Salesperson_s_Star_Rating_of_CS__c !=null?Integer.valueOf(callMentoringSession.Salesperson_s_Star_Rating_of_CS__c):0;
        effectiveRating = callMentoringSession.Overall_Effectiveness_of_Call__c != null? Integer.valueOf(callMentoringSession.Overall_Effectiveness_of_Call__c):0;
        maxEffectiveness = 5;
        maxSalesPersonRating = 5;
    }
    
    public PageReference saveData(){
        PageReference pageRef = null;
        try{
            saveCMS();
            pageRef = new PageReference('/apex/PersonalCallMentoringSessionView?id='+callMentoringSession.id);
        }catch(Exception ex){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage()));
        }
        return pageRef;
    }
    
    public PageReference saveDataNew(){
        PageReference pageRef = null;
        try{
            saveCMS();
            pageRef = new PageReference('/apex/PersonalCallMentoringSession?RecordType='+callMentoringSession.RecordTypeId);
        }catch(Exception ex){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage()));
        }
        return pageRef;
    }
    
    public void saveCMS(){
        if(recordTypeID != null)
            callMentoringSession.RecordTypeId = recordTypeID;
        callMentoringSession.Best_of_the_Best_Category__c = bestOfBestCategory;
        callMentoringSession.Salesperson_s_Star_Rating_of_CS__c = String.valueOf(salesPersonRating);
        callMentoringSession.Overall_Effectiveness_of_Call__c  = String.valueOf(effectiveRating);
        upsert callMentoringSession; 
    }
    
    public PageReference cancelEdit(){
        PageReference pageRef = null;
        System.debug('--retURL--'+retURL);
        if(retURL != null && retURL.length()>0){
            pageRef = new PageReference('/'+retURL);
        }
        else if(callMentoringSession.id != null){
         pageRef = new PageReference('/apex/PersonalcallMentoringSessionView?id='+callMentoringSession.id);
        }else{
         String callMentoringKeyfix = Schema.getGlobalDescribe().get('Call_Mentoring_Session__c').getDescribe().getKeyprefix();
         pageRef = new PageReference('/'+callMentoringKeyfix+'/o');
        }
        return pageRef;
    }
    
     public PageReference nullAction(){
         return null;
    }
    
    
    
}