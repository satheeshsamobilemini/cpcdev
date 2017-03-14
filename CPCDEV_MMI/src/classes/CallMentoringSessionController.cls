public class CallMentoringSessionController {

    public Call_Mentoring_Session__c callMentoringSession{get;set;}
    public Boolean isEdit{get;set;}
    public Integer maxSalesPersonRating{get;set;}
    public Integer maxEffectiveness{get;set;}
    public Integer salesPersonRating{get;set;}
    public Integer effectiveRating{get;set;}
    private String retURL; 
    private ID recordTypeID;
    public CallMentoringSessionController(ApexPages.StandardController stdController){
        String recordId = stdController.getId();
        String edit = ApexPages.currentPage().getParameters().get('Edit');
        String clone = ApexPages.currentPage().getParameters().get('clone');
        retURL = ApexPages.currentPage().getParameters().get('retURL');
        recordTypeID = (ID) ApexPages.currentPage().getParameters().get('RecordType');
        
        if(recordId != null){ 
          // TFS 3528
           /*
            for(Call_Mentoring_Session__c cms : [Select c.Type_of_Customer__c, c.Type_of_Coach__c, c.Type_of_Call__c, c.Transaction_Type__c, c.Transaction_Type_Other__c,
                                                c.SystemModstamp, c.Salesperson_s_Star_Rating_of_CS__c, c.Salesperson_s_Notes_and_or_Action_Plan__c, c.Sales_Rep__c, 
                                                c.Sales_Rep_Name__c, c.Sales_Rep_Id__c, c.Sales_Rep_Extension__c, c.Sales_Rep_Branch_Id__c, c.Questions_to_Coach_if_any__c, 
                                                c.Purpose_of_Call__c, c.Purpose_of_Call_Other__c, c.Product_Need__c, c.Product_Need_Other__c, c.OwnerId, c.Overall_Effectiveness_of_Call__c,
                                                c.Other_Comments_Customer_Needs__c, c.Name,c.Mentor__c, c.LastActivityDate, c.Id,c.Next_Coaching_Session_Date__c,c.Rep_Name__c,
                                                c.Experience_with_MMI__c, c.Existing_or_New_Customer__c, c.Determine_Previous_Experience__c,c.Comments_feedback_about_your_session__c,
                                                c.Best_Of_the_Best__c, c.Best_Of_the_Best_Category__c, c.Best_Of_the_Best_Comments__c,c.Date_Time_of_Call__c,c.Rep_Comments_Goal__c,
                                                c.coaching_Topic_1__c,c.coach_Comments_1__c,c.coaching_Topic_2__c,c.coach_Comments_2__c,c.coaching_Topic_3__c,c.coach_Comments_3__c, c.Rep_Date__c,    
                                                
                                                //c.what_they_would_be_storing__c, c.what_they_would_be_storing_CFlag__c, c.set_MM_apart_from_other_storage__c, c.set_MM_apart_from_other_storage_CFlag__c,
                                                // c.set_MMI_Products_apart_from_other__c, c.set_MMI_Products_apart_from_other_CFlag__c,
                                                // c.questions_were_designed_to_needs_CFlag__c,c.questions_were_designed_to_create_needs__c,
                                                //c.Validate_Learning_with_customer_CFlag__c, c.Validate_Learning_with_Customer__c, 
                                                //c.Validate_Customers_Specific_Needs__c, c.Validate_Customers_Specific_Needs_CFlag__c, 
                                                
                                                 //c.The_call_was_handled__c, c.The_call_was_handled_CFlag__c,  
                                                   
                                                //c.Other_Comments_Preparation__c,c.Other_Comments_Discovery__c, c.Other_Comments_Relevant_Options__c,c.Other_Comments_Commitment_to_the_NS__c, c.Other_Comment_Negotiate__c,
                                                 
                                                 //c.Other_Comments_Consultative_call__c,  
                                                 //c.My_smile_come_through_the_phone__c, c.My_smile_come_through_the_phone_CFlag__c, 
                                                //c.My_call_opening_was_effective__c, c.My_Call_Opening_Was_Effective_CFlag__c,
                                                 
                                                 //c.If_customer_did_not_agree_to_commitment__c, c.If_customer_did_not_agree_CFlag__c, 
                                                
                                                 //c.I_was_respectful_of_their_time__c, c.I_was_respectful_of_their_time_CFlag__c,
                                                 // c.I_was_in_mood_of_wonder__c, c.I_was_in_mood_of_wonder_CFlag__c, 
                                                 //c.I_was_actively_participate_in_the_call__c, c.I_was_actively_participate_in_call_CFlag__c,  
                                                 //c.I_validated_OUR_commitment_to_customer__c, c.I_validated_OUR_commitment_CFlag__c, 
                                                 //c.I_researched_the_customer__c, c.I_researched_the_customer_CFlag__c,c.I_referenced_previous_conversation__c, c.I_referenced_previous_conversation_CFlag__c, 
                                                 //c.I_re_validated_the_value__c, c.I_re_validated_the_value_CFlag__c, 
                                                 //c.I_offer_appropriate_options_and_pricing__c, c.I_offer_appropriate_options_CFlag__c, 
                                                 //c.I_made_a_connection__c, c.I_made_a_connection_CFlag__c, 
                                                 //c.I_knew_what_other_companies__c, c.I_knew_what_other_companies_CFlag__c, 
                                                //c.I_had_good_control_of_the_discussion__c, c.I_had_good_control_of_discussion_CFlag__c, 
                                                 //c.I_got_customer_talking__c, c.I_got_customer_talking_CFlag__c, 
                                                 //c.I_explain_the_reason_for_recommendation__c, c.I_explain_reason_for_recommendation_CFlg__c,
                                                 // c.I_established_relationship_CFlag__c, c.I_established_and_developed_relationship__c,
                                                 // c.I_effectively_validated_my_Knowledge__c, c.I_validated_my_knowledge_CFlag__c,
                                                 //c.I_effectively_obtained_the_PM__c, c.I_effectively_obtained_the_PM_CFlag__c, 
                                                 //c.I_believe_the_customer_believes__c, c.I_believe_the_customer_believes_CFlag__c,
                                                 //c.I_believe_options_recommendations__c, c.I_believe_options_recommendations_CFlag__c,c.I_asked_customer_about_commitment_CFlg__c, 
                                                  //c.I_attempted_to_resolve_issues__c, c.I_attempted_to_resolve_issues_CFlag__c, 
                                                  //c.I_asked_the_customer_about_commitment__c, 
                                                  //c.I_asked_customer_wht_I_have_nt_done_CFlg__c, c.I_asked_customer_what_I_have_not_done__c, 
                                                  //c.I_asked_customer_for_commitment_to_next__c, c.I_asked_customer_for_commitment_CFlag__c, 
                                                  
                                                 //c.I_able_to_determine_Previous_Exp__c, c.I_able_to_determine_Previous_Exp_CFlag__c, 
                                                  
                                                //c.Date_Time_of_Coaching_Session__c,
                                                 
                                                //c.Call_was_personalized_and_not_scripted__c, c.Call_was_personalized_CFlag__c, 
                                                //c.Call_was_organized__c, c.Call_was_organized_CFlag__c, 
                                                //c.Call_was_conversation_friendly_and_warm__c, c.Call_was_conversation_friendly_CFlag__c, 
                                                //c.Call_matched_my_purpose_intent__c, c.Call_matched_my_purpose_intent_CFlag__c, 
            c.Call_Title__c From Call_Mentoring_Session__c c where c.id = : recordId ]){                                   
*/
            
         for(Call_Mentoring_Session__c cms : [Select c.Type_of_Customer__c, c.Type_of_Coach__c, c.Type_of_Call__c, c.Transaction_Type__c, c.Transaction_Type_Other__c,
                                                c.SystemModstamp, c.Salesperson_s_Star_Rating_of_CS__c, c.Salesperson_s_Notes_and_or_Action_Plan__c, c.Sales_Rep__c, 
                                                c.Sales_Rep_Name__c, c.Sales_Rep_Id__c, c.Sales_Rep_Extension__c, c.Sales_Rep_Branch_Id__c, c.Questions_to_Coach_if_any__c, 
                                                c.Purpose_of_Call__c, c.Purpose_of_Call_Other__c, c.Product_Need__c, c.Product_Need_Other__c, c.OwnerId, c.Overall_Effectiveness_of_Call__c,
                                                c.Name,c.Mentor__c, c.LastActivityDate, c.Id,c.Next_Coaching_Session_Date__c,c.Rep_Name__c,
                                                c.Experience_with_MMI__c, c.Existing_or_New_Customer__c, c.Comments_feedback_about_your_session__c,
                                                c.Best_Of_the_Best__c, c.Best_Of_the_Best_Category__c, c.Best_Of_the_Best_Comments__c,c.Date_Time_of_Call__c,c.Rep_Comments_Goal__c,
                                                c.coaching_Topic_1__c,c.coach_Comments_1__c,c.coaching_Topic_2__c,c.coach_Comments_2__c,c.coaching_Topic_3__c,c.coach_Comments_3__c, c.Rep_Date__c   
                                                
                                                //c.what_they_would_be_storing__c, c.what_they_would_be_storing_CFlag__c, c.set_MM_apart_from_other_storage__c, c.set_MM_apart_from_other_storage_CFlag__c,
                                                // c.set_MMI_Products_apart_from_other__c, c.set_MMI_Products_apart_from_other_CFlag__c,
                                                // c.questions_were_designed_to_needs_CFlag__c,c.questions_were_designed_to_create_needs__c,
                                                //c.Validate_Learning_with_customer_CFlag__c, c.Validate_Learning_with_Customer__c, 
                                                //c.Validate_Customers_Specific_Needs__c, c.Validate_Customers_Specific_Needs_CFlag__c, 
                                                //c.The_call_was_handled__c, c.The_call_was_handled_CFlag__c,  
                                                //c.Other_Comments_Preparation__c,c.Other_Comments_Discovery__c, c.Other_Comments_Relevant_Options__c,c.Other_Comments_Commitment_to_the_NS__c, c.Other_Comment_Negotiate__c,
                                                //c.Other_Comments_Consultative_call__c,  
                                                 //c.My_smile_come_through_the_phone__c, c.My_smile_come_through_the_phone_CFlag__c, 
                                                //c.My_call_opening_was_effective__c, c.My_Call_Opening_Was_Effective_CFlag__c,
                                                //c.If_customer_did_not_agree_to_commitment__c, c.If_customer_did_not_agree_CFlag__c, 
                                                //c.I_was_respectful_of_their_time__c, c.I_was_respectful_of_their_time_CFlag__c,
                                                 // c.I_was_in_mood_of_wonder__c, c.I_was_in_mood_of_wonder_CFlag__c, 
                                                 //c.I_was_actively_participate_in_the_call__c, c.I_was_actively_participate_in_call_CFlag__c,  
                                                 //c.I_validated_OUR_commitment_to_customer__c, c.I_validated_OUR_commitment_CFlag__c, 
                                                 //c.I_researched_the_customer__c, c.I_researched_the_customer_CFlag__c,c.I_referenced_previous_conversation__c, c.I_referenced_previous_conversation_CFlag__c, 
                                                 //c.I_re_validated_the_value__c, c.I_re_validated_the_value_CFlag__c, 
                                                 //c.I_offer_appropriate_options_and_pricing__c, c.I_offer_appropriate_options_CFlag__c, 
                                                 //c.I_made_a_connection__c, c.I_made_a_connection_CFlag__c, 
                                                 //c.I_knew_what_other_companies__c, c.I_knew_what_other_companies_CFlag__c, 
                                                //c.I_had_good_control_of_the_discussion__c, c.I_had_good_control_of_discussion_CFlag__c, 
                                                 //c.I_got_customer_talking__c, c.I_got_customer_talking_CFlag__c, 
                                                 //c.I_explain_the_reason_for_recommendation__c, c.I_explain_reason_for_recommendation_CFlg__c,
                                                 // c.I_established_relationship_CFlag__c, c.I_established_and_developed_relationship__c,
                                                 // c.I_effectively_validated_my_Knowledge__c, c.I_validated_my_knowledge_CFlag__c,
                                                 //c.I_effectively_obtained_the_PM__c, c.I_effectively_obtained_the_PM_CFlag__c, 
                                                 //c.I_believe_the_customer_believes__c, c.I_believe_the_customer_believes_CFlag__c,
                                                 //c.I_believe_options_recommendations__c, c.I_believe_options_recommendations_CFlag__c,c.I_asked_customer_about_commitment_CFlg__c, 
                                                  //c.I_attempted_to_resolve_issues__c, c.I_attempted_to_resolve_issues_CFlag__c, 
                                                  //c.I_asked_the_customer_about_commitment__c, 
                                                  //c.I_asked_customer_wht_I_have_nt_done_CFlg__c, c.I_asked_customer_what_I_have_not_done__c, 
                                                  //c.I_asked_customer_for_commitment_to_next__c, c.I_asked_customer_for_commitment_CFlag__c, 
                                                  //c.I_able_to_determine_Previous_Exp__c, c.I_able_to_determine_Previous_Exp_CFlag__c, 
                                                  //c.Date_Time_of_Coaching_Session__c,
                                                 //c.Call_was_personalized_and_not_scripted__c, c.Call_was_personalized_CFlag__c, 
                                                //c.Call_was_organized__c, c.Call_was_organized_CFlag__c, 
                                                //c.Call_was_conversation_friendly_and_warm__c, c.Call_was_conversation_friendly_CFlag__c, 
                                                //c.Call_matched_my_purpose_intent__c, c.Call_matched_my_purpose_intent_CFlag__c, 
            From Call_Mentoring_Session__c c where c.id = : recordId ]){  
            
                callMentoringSession = cms;
            }
        }
        if(callMentoringSession == null){
            callMentoringSession = new Call_Mentoring_Session__c();
            callMentoringSession.Salesperson_s_Star_Rating_of_CS__c = '0';
            callMentoringSession.Overall_Effectiveness_of_Call__c = '0';
            
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
            pageRef = new PageReference('/apex/CallMentoringSessionView?id='+callMentoringSession.id);
        }catch(Exception ex){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage()));
        }
        return pageRef;
    }
    
    public PageReference saveDataNew(){
        PageReference pageRef = null;
        try{
            saveCMS();
            pageRef = new PageReference('/apex/callMentoringSession?RecordType='+callMentoringSession.RecordTypeId);
        }catch(Exception ex){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage()));
        }
        return pageRef;
    }
    
    public void saveCMS(){
        if(recordTypeID != null)
            callMentoringSession.RecordTypeId = recordTypeID;
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
         pageRef = new PageReference('/apex/callMentoringSessionView?id='+callMentoringSession.id);
        }else{
         String callMentoringKeyfix = Schema.getGlobalDescribe().get('Call_Mentoring_Session__c').getDescribe().getKeyprefix();
         pageRef = new PageReference('/'+callMentoringKeyfix+'/o');
        }
        return pageRef;
    }
    
    
}