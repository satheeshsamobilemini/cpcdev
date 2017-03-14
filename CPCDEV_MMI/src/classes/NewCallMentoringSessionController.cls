/***********************************************************************************************************
Created Date : 24th Feb 2011
Cretaed By : Vinod Kumar(Appirio OffShore)

Usage :Override the functionality of new standard button 

***********************************************************************************************************/
public with sharing class NewCallMentoringSessionController {
    String recordId ;
    String edit ;
    String clone ;
    String retURL ;
    String recordTypeID ;
    public NewCallMentoringSessionController(ApexPages.StandardController stdController){       
         recordId = stdController.getId();
         edit = ApexPages.currentPage().getParameters().get('Edit');
         clone = ApexPages.currentPage().getParameters().get('clone');
         retURL = ApexPages.currentPage().getParameters().get('retURL');
         recordTypeID = ApexPages.currentPage().getParameters().get('RecordType');
    }
    
     public PageReference CallMentoringSessionPage(){
        RecordType rtp;
        String keyPrefix = Schema.getGlobalDescribe().get('Call_Mentoring_Session__c').getDescribe().getKeyPrefix();
        if(recordTypeID != null){       
            for(RecordType rtpTemp : [Select r.Name, r.Id From RecordType r where id = :recordTypeID limit 1]){
                rtp = rtpTemp;
            }
        }
        String url= '';
        if(rtp != null){
            if(rtp.name =='Branch Coaching Session'){
                // redirect to CallMentoringSession page                
                url  = '/apex/CallMentoringSession?retURL='+ retURL+'&RecordType='+recordTypeID;
            }
            else if(rtp.Name == 'Personal Coaching Session') {
                // redirect to  AdvancedCallMentoringSession page
                url  = '/apex/PersonalCallMentoringSession?retURL='+ retURL+'&RecordType='+recordTypeID;
            }
            else if(rtp.Name == 'NSC Coaching Session'){
                // redirect to  AdvancedCallMentoringSession page
                url  = '/apex/AdvancedCallMentoringSession?retURL='+ retURL+'&RecordType='+recordTypeID;
            }
            else{
              url = '/'+keyPrefix + '/e?nooverride=1&retURL='+ retURL+'&RecordType='+recordTypeID;
            }
            /*else if(rtp.Name == 'Inbound Coaching Session' || rtp.Name == 'Outbound Coaching Session' || rtp.Name == 'Customer Care Coaching Session' || rtp.Name == 'IB QA Form'){
                url = '/'+keyPrefix + '/e?nooverride=1&retURL='+ retURL+'&RecordType='+recordTypeID;
                
            }else{
                url = '/'+keyPrefix + '/e?nooverride=1&retURL='+ retURL;
            }*/
        }
        else{
            url  = '/'+retURL;          
        }
         return new PageReference(url);
     }  
     
}