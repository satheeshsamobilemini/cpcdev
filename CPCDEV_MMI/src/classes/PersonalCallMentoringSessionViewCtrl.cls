public  class PersonalCallMentoringSessionViewCtrl {

    public Call_Mentoring_Session__c callMentoringSession{get;set;}
    public list<My_Calls__c> allCalls{get;set;}
    public Boolean isEdit{get;set;}
    public Integer maxSalesPersonRating{get;set;}
    public Integer maxEffectiveness{get;set;}
    public Integer salesPersonRating{get;set;}
    public Integer effectiveRating{get;set;} 
    String recordId;
    public PersonalCallMentoringSessionViewCtrl(ApexPages.StandardController stdController){
        recordId = stdController.getId();
        allCalls = new list<My_Calls__c>(); 
        if(recordId != null){
          // TFS 3528
          /*
            for(Call_Mentoring_Session__c cms : [Select c.questions_were_designed_to_needs_CFlag__c, c.questions_were_designed_to_create_needs__c,
                                                 c.Type_of_Customer__c,  c.Type_of_Coach__c, c.Type_of_Call__c, c.Transaction_Type__c, c.Transaction_Type_Other__c,
                                                 c.SystemModstamp, c.Salesperson_s_Star_Rating_of_CS__c,
                                                 c.Salesperson_s_Notes_and_or_Action_Plan__c, c.Sales_Rep__c,c.Sales_Rep__r.Name, c.Sales_Rep_Name__c, c.Sales_Rep_Id__c, c.Sales_Rep_Extension__c, c.Sales_Rep_Branch_Id__c, c.Questions_to_Coach_if_any__c, 
                                                 c.Purpose_of_Call__c, c.Purpose_of_Call_Other__c, c.Product_Need__c, c.Product_Need_Other__c, c.OwnerId, c.Overall_Effectiveness_of_Call__c, 
                                                 c.Other_Comments_Customer_Needs__c, c.Name,c.Id, c.Mentor__c, c.Mentor__r.Name, c.LastActivityDate,
                                                 c.Experience_with_MMI__c, c.Existing_or_New_Customer__c, c.Determine_Previous_Experience__c,c.Date_Time_of_Call__c,c.Comments_feedback_about_your_session__c,
                                                 c.Call_Title__c,c.Best_Of_the_Best__c, c.Best_Of_the_Best_Category__c, c.Best_Of_the_Best_Comments__c, c.Rep_Comments_Goal__c,
                                                 c.coaching_Topic_1__c,c.coach_Comments_1__c,c.coaching_Topic_2__c,c.coach_Comments_2__c,c.coaching_Topic_3__c,c.coach_Comments_3__c,
                                                 c.Rep_Name__c, c.Rep_Name__r.Name, c.Type_of_Training_Mentoring__c,Rep_Date__c,c.Employee_Type__c,c.Employee_Name__c,
                                                (Select Id,Subject, Description, Activity_Code__c From OpenActivities order by ActivityDate ASC, LastModifiedDate DESC limit 100),
                                                (Select WhoId, WhatId, Subject, IsTask, ActivityDate, Status, Call_Type__c, Branch__c, Task_Completed_Date_Time__c From ActivityHistories),
                                                (Select ParentId,id, Title, CreatedDate, LastModifiedDate From NotesAndAttachments) 
                                                From Call_Mentoring_Session__c c where c.id = : recordId limit 1]){    
          */
                                                
            for(Call_Mentoring_Session__c cms : [Select 
                                                 c.Type_of_Customer__c,  c.Type_of_Coach__c, c.Type_of_Call__c, c.Transaction_Type__c, c.Transaction_Type_Other__c,
                                                 c.SystemModstamp, c.Salesperson_s_Star_Rating_of_CS__c,
                                                 c.Salesperson_s_Notes_and_or_Action_Plan__c, c.Sales_Rep__c,c.Sales_Rep__r.Name, c.Sales_Rep_Name__c, c.Sales_Rep_Id__c, c.Sales_Rep_Extension__c, c.Sales_Rep_Branch_Id__c, c.Questions_to_Coach_if_any__c, 
                                                 c.Purpose_of_Call__c, c.Purpose_of_Call_Other__c, c.Product_Need__c, c.Product_Need_Other__c, c.OwnerId, c.Overall_Effectiveness_of_Call__c, 
                                                 c.Name,c.Id, c.Mentor__c, c.Mentor__r.Name, c.LastActivityDate,
                                                 c.Experience_with_MMI__c, c.Existing_or_New_Customer__c, c.Date_Time_of_Call__c,c.Comments_feedback_about_your_session__c,
                                                 c.Best_Of_the_Best__c, c.Best_Of_the_Best_Category__c, c.Best_Of_the_Best_Comments__c, c.Rep_Comments_Goal__c,
                                                 c.coaching_Topic_1__c,c.coach_Comments_1__c,c.coaching_Topic_2__c,c.coach_Comments_2__c,c.coaching_Topic_3__c,c.coach_Comments_3__c,
                                                 c.Rep_Name__c, c.Rep_Name__r.Name, c.Type_of_Training_Mentoring__c,Rep_Date__c,c.Employee_Type__c,c.Employee_Name__c,
                                                (Select Id,Subject, Description, Activity_Code__c From OpenActivities order by ActivityDate ASC, LastModifiedDate DESC limit 100),
                                                (Select WhoId, WhatId, Subject, IsTask, ActivityDate, Status, Call_Type__c, Branch__c, Task_Completed_Date_Time__c From ActivityHistories),
                                                (Select ParentId,id, Title, CreatedDate, LastModifiedDate From NotesAndAttachments) 
                                                From Call_Mentoring_Session__c c where c.id = : recordId limit 1]){                                    
                                            
                 callMentoringSession = cms;
                
                 salesPersonRating = callMentoringSession.Salesperson_s_Star_Rating_of_CS__c != null ?Integer.valueOf(callMentoringSession.Salesperson_s_Star_Rating_of_CS__c):0;
                 effectiveRating = callMentoringSession.Overall_Effectiveness_of_Call__c != null ? Integer.valueOf(callMentoringSession.Overall_Effectiveness_of_Call__c):0;
                
            }
            // get all Calls
            //allCalls = [Select m.Id, m.Type_of_Call__c,m.Call_Title_Keywords__c, m.Name, m.Date_Time_of_Call__c, m.Call_Mentoring_Session__c From My_Calls__c m where m.Call_Mentoring_Session__c = :recordId ];
        }
        maxEffectiveness = 5;
        maxSalesPersonRating = 5;
        
    }
    
    public PageReference editData(){
        PageReference pageRef = null;
        if(callMentoringSession.id != null)
         //pageRef = new PageReference('/'+callMentoringSession.id+'/e');
        pageRef = new PageReference('/apex/PersonalcallMentoringSession?id='+callMentoringSession.id);
        return pageRef;
    }
    public PageReference cloneData(){
        PageReference pageRef = new PageReference('/apex/PersonalcallMentoringSession?id='+callMentoringSession.id+'&clone=1');
        return pageRef;
        
    }
    
    public PageReference deleteData(){
        PageReference pageRef = null;
        String callMentoringKeyfix;
        try{
            delete callMentoringSession;
            callMentoringKeyfix = Schema.getGlobalDescribe().get('Call_Mentoring_Session__c').getDescribe().getKeyprefix();
            pageRef = new PageReference('/'+callMentoringKeyfix+'/o');
        }catch(Exception ex){}
        return pageRef;
    } 
    public PageReference newMyCall(){
        String myCallPrefix = Schema.getGlobalDescribe().get('My_Calls__c').getDescribe().getKeyPrefix();
        String callMentoringSessionFldId = System.Label.Call_Mentoring_Session_ID;
        
        String CMSLookupId = callMentoringSessionFldId +'_lkid';
        String mycallUrl = '/'+myCallPrefix+'/e?'+callMentoringSessionFldId+'='+callMentoringSession.Name+'&'+CMSLookupId+'='+recordId+'&retURL=/apex/CallMentoringSessionView?id='+recordId;
        System.debug('---callMentoringSession.Sales_Rep__c--'+callMentoringSession.Sales_Rep__c);
        if(callMentoringSession.Sales_Rep__c != null){
            System.debug('---in loop callMentoringSession.Sales_Rep__c--'+callMentoringSession.Sales_Rep__c);
            String salesRepFldId = System.Label.Sales_Rep_Field_Id;
            mycallUrl += '&'+salesRepFldId+'='+callMentoringSession.Sales_Rep__r.Name+'&'+salesRepFldId+'_lkid='+callMentoringSession.Sales_Rep__c;
        }
        if(CallMentoringSession.Mentor__c != null){
            String mentorFldId = System.Label.Mentor_Field_Id;
            mycallUrl += '&'+mentorFldId+'='+callMentoringSession.Mentor__r.Name+'&'+mentorFldId+'_lkid='+callMentoringSession.Mentor__c;
            
        }
        return new PageReference(mycallUrl);
    }
    
    public PageReference newData(){
        PageReference pageRef = new PageReference('/apex/PersonalCallMentoringSession?RecordType='+callMentoringSession.RecordTypeId);
        return pageRef;
    }
    
    public PageReference newTask(){
        String recordTypeId;
        ///00T/e
        String url = '/setup/ui/recordtypeselect.jsp?what_id='+callMentoringSession.id+'&ent=Task&nooverride=1&retURL='+callMentoringSession.id+'&save_new_url=00T%2Fe%3FretURL='+callMentoringSession.id;
        for(RecordType rtpTemp : [Select r.Name, r.Id From RecordType r where Name = 'Coaching Session Task' and r.SobjectType ='Task' limit 1]){
            recordTypeId = rtpTemp.id;  
        }
        if(recordTypeId != null){
            url += '&p3='+recordTypeId.substring(0,15);
        }
        return new PageReference(url);
        
        
    }
}