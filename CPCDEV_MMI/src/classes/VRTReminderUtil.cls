/********************************************************************************************
Name   : VRTReminderUtil
Author : Jyoti Singh
Date   : Feb 15, 2013
Usage  : Used in VRTReminderBatchProcess batch class to send Email.
********************************************************************************************/  

public with sharing class VRTReminderUtil{
    
    public static DateTime currentTime;
    
    public static List<String> sendMail(List<Vehicle_Registration_Tracking__c> vrtList){
        
        Set<String> emailSet = new Set<String>();
        
        for(Vehicle_Registration_Tracking__c vrt:vrtList){
            if(vrt.Branch_ID__c == vrt.LastModifiedBy.Branch_Id__c){
                emailSet.add(vrt.LastModifiedBy.Email);
            }       
        }
        system.debug('***************************'+emailSet);
        List<String> emailList = new List<String>();
        emailList.addAll(emailSet);
        return emailList;
    }
    
    public static void sendfinalEmail(List<String> emailList){             
        if(emailList.size()> 0){
            system.debug('***************************'+emailList);
            if(test.isRunningTest()){
                emailList = new List<String>();
                emailList.add('jyoti.singh@appirio.com');           
            }
            /*
            emailList = new List<String>();
            emailList.add('jyoti.singh@appirio.com'); 
            emailList.add('chall@appirio.com');
            */             
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        
            //Sets the paramaters of the email
            email.setSubject(getSubject());
            email.setToAddresses(emailList);
            email.setHTMLBody(getBody());
            Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email}); 
        }
    }
    
    //Method to get the subject for the email
    private static String getSubject(){
        String subj = 'VRT Report Card';
        return subj;
    }
    
    //Method to get the Body for the email
    private static String getBody(){
        
    String HTMLBOdy = 'Please find the following link and update the key fields on the Branch vehicles:  <br/><br/>';
    
    //To get the salesforce serverURl
    String serverUrl = URL.getSalesforceBaseUrl().toExternalForm();
    HTMLBOdy += ' Page Link: ' + serverUrl + '/apex/VehicleRegistrationTracking'; 
        
        return HTMLBOdy;
    }
}