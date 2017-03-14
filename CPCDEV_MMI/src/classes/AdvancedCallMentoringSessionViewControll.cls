/***********************************************************************************************************
Created Date : 25th Feb 2011
Cretaed By : Vinod Kumar(Appirio OffShore)

Usage :Override the functionality of view standard button for 'NSC Call Mentoring Session' record type

***********************************************************************************************************/
public class AdvancedCallMentoringSessionViewControll {
public Call_Mentoring_Session__c callMentoringSession{get;set;}
    public list<My_Calls__c> allCalls{get;set;}
    public Boolean isEdit{get;set;}
    public Integer maxSalesPersonRating{get;set;}
    public Integer maxEffectiveness{get;set;}
    public Integer salesPersonRating{get;set;}
    public Integer effectiveRating{get;set;} 
    String recordId;
    public AdvancedCallMentoringSessionViewControll(ApexPages.StandardController stdController){
        recordId = stdController.getId();
        allCalls = new list<My_Calls__c>();
        if(recordId != null){
           // TFS 3528
         /* 
           for(Call_Mentoring_Session__c cms : [Select c.what_they_would_be_storing__c, c.what_they_would_be_storing_CFlag__c, c.set_MM_apart_from_other_storage__c, c.set_MM_apart_from_other_storage_CFlag__c, c.set_MMI_Products_apart_from_other__c, c.set_MMI_Products_apart_from_other_CFlag__c, c.questions_were_designed_to_needs_CFlag__c, c.questions_were_designed_to_create_needs__c, 
                 c.Validate_Learning_with_customer_CFlag__c, c.Validate_Learning_with_Customer__c, c.Validate_Customers_Specific_Needs__c, c.Validate_Customers_Specific_Needs_CFlag__c, c.Type_of_Customer__c, c.Type_of_Coach__c, c.Type_of_Call__c, c.Transaction_Type__c, c.Transaction_Type_Other__c, c.The_call_was_handled__c, c.The_call_was_handled_CFlag__c, c.SystemModstamp, c.Salesperson_s_Star_Rating_of_CS__c, c.Salesperson_s_Notes_and_or_Action_Plan__c, c.Sales_Rep__c, c.Sales_Rep_Name__c, c.Sales_Rep_Id__c, c.Sales_Rep_Extension__c, c.Sales_Rep_Branch_Id__c, c.Questions_to_Coach_if_any__c, c.Purpose_of_Call__c, c.Purpose_of_Call_Other__c, c.Product_Need__c, c.Product_Need_Other__c, c.OwnerId, c.Overall_Effectiveness_of_Call__c, c.Other_Comments_Relevant_Options__c, c.Other_Comments_Preparation__c, c.Other_Comments_Discovery__c, c.Other_Comments_Customer_Needs__c, c.Other_Comments_Consultative_call__c, c.Other_Comments_Commitment_to_the_NS__c, c.Other_Comment_Negotiate__c, c.Name, c.My_smile_come_through_the_phone__c, c.My_smile_come_through_the_phone_CFlag__c, c.My_call_opening_was_effective__c, c.My_Call_Opening_Was_Effective_CFlag__c, c.Mentor__c, c.Mentor__r.Name, c.LastActivityDate,c.If_customer_did_not_agree_to_commitment__c, c.If_customer_did_not_agree_CFlag__c, c.Id, c.I_was_respectful_of_their_time__c, c.I_was_respectful_of_their_time_CFlag__c, c.I_was_in_mood_of_wonder__c, c.I_was_in_mood_of_wonder_CFlag__c, c.I_was_actively_participate_in_the_call__c, c.I_was_actively_participate_in_call_CFlag__c, c.I_validated_my_knowledge_CFlag__c, c.I_validated_OUR_commitment_to_customer__c, c.I_validated_OUR_commitment_CFlag__c, c.I_researched_the_customer__c, c.I_researched_the_customer_CFlag__c, c.I_referenced_previous_conversation__c, c.I_referenced_previous_conversation_CFlag__c, c.I_re_validated_the_value__c, c.I_re_validated_the_value_CFlag__c, c.I_offer_appropriate_options_and_pricing__c, c.I_offer_appropriate_options_CFlag__c, c.I_made_a_connection__c, c.I_made_a_connection_CFlag__c, c.I_knew_what_other_companies__c, c.I_knew_what_other_companies_CFlag__c, c.I_had_good_control_of_the_discussion__c, c.I_had_good_control_of_discussion_CFlag__c, c.I_got_customer_talking__c, c.I_got_customer_talking_CFlag__c, c.I_explain_the_reason_for_recommendation__c, c.I_explain_reason_for_recommendation_CFlg__c, c.I_established_relationship_CFlag__c, c.I_established_and_developed_relationship__c, c.I_effectively_validated_my_Knowledge__c, c.I_effectively_obtained_the_PM__c, c.I_effectively_obtained_the_PM_CFlag__c, c.I_believe_the_customer_believes__c, c.I_believe_the_customer_believes_CFlag__c, c.I_believe_options_recommendations__c, c.I_believe_options_recommendations_CFlag__c, c.I_attempted_to_resolve_issues__c, c.I_attempted_to_resolve_issues_CFlag__c, c.I_asked_the_customer_about_commitment__c, c.I_asked_customer_wht_I_have_nt_done_CFlg__c, c.I_asked_customer_what_I_have_not_done__c, c.I_asked_customer_for_commitment_to_next__c, c.I_asked_customer_for_commitment_CFlag__c, c.I_asked_customer_about_commitment_CFlg__c, c.I_able_to_determine_Previous_Exp__c, c.I_able_to_determine_Previous_Exp_CFlag__c, c.Experience_with_MMI__c, c.Existing_or_New_Customer__c, c.Determine_Previous_Experience__c, 
                 //c.Date_Time_of_Coaching_Session__c, 
                 c.Date_Time_of_Call__c,c.Comments_feedback_about_your_session__c, c.Call_was_personalized_and_not_scripted__c, c.Call_was_personalized_CFlag__c, c.Call_was_organized__c, c.Call_was_organized_CFlag__c, c.Call_was_conversation_friendly_and_warm__c, c.Call_was_conversation_friendly_CFlag__c, c.Call_matched_my_purpose_intent__c, c.Call_matched_my_purpose_intent_CFlag__c, c.Call_Title__c,Rep_Name__c,Rep_Name__r.Name,Rep_Date__c,Objective_Purpose_for_coaching_session__c,Specific_Area_Of_Coaching__c,Area_Of_Strength__c,Area_of_Opportunity_Focus__c,Root_Cause_of_Opportunity__c,Action_Plan_Measurement_And_Goal__c,Rep_Questions_Comments__c,Manager_Comments_And_Expectations__c,Next_Coaching_Session_Date__c
                ,Rep_Pre_Call_Prep_Planning__c,Manager_Pre_Call_Prep_Planning__c ,Rep_Pre_Call_Comment__c,Manager_Pre_Call_Comment__c,Rep_Call_Opening_Gate_keeper__c,Manager_Call_Opening_Gate_keeper__c
                ,Rep_Call_Opening_Prospect__c,Manager_Call_Opening_Prospect__c,Rep_Discovery_Asked_Appropriate_Question__c,Manager_Discovery_Asked_Appropriate_Ques__c,Rep_Discovery_Container_Question__c,Manager_Discovery_Container_Question__c,Rep_Discovery_Connected_MMI__c,Manager_Discovery_Connected_MMI__c
                ,Rep_Recommends_A_Product__c,Manager_Recommends_A_Product__c,Rep_Recommends_Explains_Reasoning__c,Manager_Recommends_Explains_Reasoning__c
                ,Rep_Close_Commitment_Effectively_Asked__c,Manager_Close_Commitment_Effectively_Ask__c,Rep_Close_Commitment_Order_Sale_Processe__c,Manager_Close_Commitment_Order_Sale_Proc__c
                ,Rep_Follow_Up_Directly_Asks__c,Manager_Follow_Up_Directly_Asks__c,Rep_Follow_Up_Schedules_Phone_Appointmen__c,Manager_Follow_Up_Schedules_Phone_Appoin__c,
                 Best_Of_the_Best__c, Best_Of_the_Best_Category__c, Best_Of_the_Best_Comments__c,
                (Select Id,Subject, Description, Activity_Code__c From OpenActivities order by ActivityDate ASC, LastModifiedDate DESC limit 100),
                (Select WhoId, WhatId, Subject, IsTask, ActivityDate, Status, Call_Type__c, Branch__c, Task_Completed_Date_Time__c From ActivityHistories) ,
                (Select ParentId,id, Title, CreatedDate, LastModifiedDate From NotesAndAttachments) 
                From Call_Mentoring_Session__c c where c.id = : recordId limit 1])  
         */
                
           for(Call_Mentoring_Session__c cms : [Select   
                   c.Type_of_Customer__c, c.Type_of_Coach__c, c.Type_of_Call__c, c.Transaction_Type__c, c.Transaction_Type_Other__c,  c.SystemModstamp, c.Salesperson_s_Star_Rating_of_CS__c, c.Salesperson_s_Notes_and_or_Action_Plan__c, c.Sales_Rep__c, c.Sales_Rep_Name__c, c.Sales_Rep_Id__c, c.Sales_Rep_Extension__c, c.Sales_Rep_Branch_Id__c, c.Questions_to_Coach_if_any__c, c.Purpose_of_Call__c, c.Purpose_of_Call_Other__c, c.Product_Need__c, c.Product_Need_Other__c, c.OwnerId, c.Overall_Effectiveness_of_Call__c,  c.Other_Comments_Commitment_to_the_NS__c,  c.Name, c.Mentor__c, c.Mentor__r.Name, c.LastActivityDate,c.Id, c.I_asked_the_customer_about_commitment__c, c.I_asked_customer_for_commitment_CFlag__c,  c.Experience_with_MMI__c, c.Existing_or_New_Customer__c, 
                 //c.Date_Time_of_Coaching_Session__c, 
                 c.Rep_Pre_Call_Comment__c, c.Date_Time_of_Call__c,c.Comments_feedback_about_your_session__c, c.Call_matched_my_purpose_intent__c, Rep_Name__c,Rep_Name__r.Name,Rep_Date__c,Objective_Purpose_for_coaching_session__c,Specific_Area_Of_Coaching__c,Area_Of_Strength__c,Area_of_Opportunity_Focus__c,Root_Cause_of_Opportunity__c,Action_Plan_Measurement_And_Goal__c,Rep_Questions_Comments__c,Manager_Comments_And_Expectations__c,Next_Coaching_Session_Date__c
                ,Rep_Pre_Call_Prep_Planning__c,Manager_Pre_Call_Prep_Planning__c ,Manager_Pre_Call_Comment__c,Rep_Call_Opening_Gate_keeper__c,Manager_Call_Opening_Gate_keeper__c
                ,Rep_Call_Opening_Prospect__c,Manager_Call_Opening_Prospect__c,Rep_Discovery_Asked_Appropriate_Question__c,Manager_Discovery_Asked_Appropriate_Ques__c,Rep_Discovery_Container_Question__c,Manager_Discovery_Container_Question__c,Rep_Discovery_Connected_MMI__c,Manager_Discovery_Connected_MMI__c
                ,Rep_Recommends_A_Product__c,Manager_Recommends_A_Product__c,Rep_Recommends_Explains_Reasoning__c,Manager_Recommends_Explains_Reasoning__c
                ,Rep_Close_Commitment_Effectively_Asked__c,Manager_Close_Commitment_Effectively_Ask__c,Rep_Close_Commitment_Order_Sale_Processe__c,Manager_Close_Commitment_Order_Sale_Proc__c
                ,Rep_Follow_Up_Directly_Asks__c,Manager_Follow_Up_Directly_Asks__c,Rep_Follow_Up_Schedules_Phone_Appointmen__c,Manager_Follow_Up_Schedules_Phone_Appoin__c,
                 Best_Of_the_Best__c, Best_Of_the_Best_Category__c, Best_Of_the_Best_Comments__c,
                (Select Id,Subject, Description, Activity_Code__c From OpenActivities order by ActivityDate ASC, LastModifiedDate DESC limit 100),
                (Select WhoId, WhatId, Subject, IsTask, ActivityDate, Status, Call_Type__c, Branch__c, Task_Completed_Date_Time__c From ActivityHistories) ,
                (Select ParentId,id, Title, CreatedDate, LastModifiedDate From NotesAndAttachments) 
                From Call_Mentoring_Session__c c where c.id = : recordId limit 1])     
               
            {
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
        pageRef = new PageReference('/apex/AdvancedCallMentoringSession?id='+callMentoringSession.id);
        return pageRef;
    }
    public PageReference cloneData(){
        PageReference pageRef = new PageReference('/apex/AdvancedCallMentoringSession?id='+callMentoringSession.id+'&clone=1');
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
        string mycallUrl = '/'+myCallPrefix+'/e?'+callMentoringSessionFldId+'='+callMentoringSession.Name+'&'+CMSLookupId+'='+recordId+'&retURL=/apex/CallMentoringSessionView?id='+recordId;
        if(callMentoringSession.Rep_Name__c != null){
            String salesRepFldId = System.Label.Sales_Rep_Field_Id;
            mycallUrl += '&'+salesRepFldId+'='+callMentoringSession.Rep_Name__r.Name+'&'+salesRepFldId+'_lkid='+callMentoringSession.Rep_Name__c;
        }
        if(CallMentoringSession.Mentor__c != null){
            String mentorFldId = System.Label.Mentor_Field_Id;
            mycallUrl += '&'+mentorFldId+'='+callMentoringSession.Mentor__r.Name+'&'+mentorFldId+'_lkid='+callMentoringSession.Mentor__c;
            
        }
        return new PageReference(mycallUrl);
    }
    /*public PageReference cancel(){
        PageReference pageRef = null;
        String callMentoringKeyfix = Schema.getGlobalDescribe().get('Call_Mentoring_Session__c').getDescribe().getKeyprefix();
        pageRef = new PageReference('/'+callMentoringKeyfix+'/o');
        return pageRef;
    }*/
    
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