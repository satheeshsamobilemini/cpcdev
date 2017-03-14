/**************************************************************************
Name:  QuickQuoteErrorHandler()
Copyright © 2013  MMI
----------------------------------------------------------------------
Purpose:
This class contains the methods for Quick Quote web service error message
parsing 
-----------------------------------------------------------------------
History:

VERSION  AUTHOR                 DATE        DETAIL              
1.0  -  TEKsystems             11/2/2013   INITIAL DEVELOPMENT  
**************************************************************************/
public with sharing class QuickQuoteErrorHandler {
    
    /*********************************************************************
    Purpose     : To get the error messages
    Parameters  : none
    Returns     : string 
    **********************************************************************/
    public static String handleError(String err){   
            
        system.debug(LoggingLevel.DEBUG,'Entering QQuoteParseError_AC:parseErrorMessage:'+err);
        parseErr d;
        try{
            if(err!=null){  
                d = (parseErr)JSON.deserialize(err, parseErr.class);
                system.debug('-----------d------------'+d);
            }
        }
        catch(Exception e)
        {   return e.getMessage();
        	system.debug('--------e.getMessage()-------------'+e.getMessage());
            //return 'Error Occurred. Please check all the necessary fields are filled out';
        }
        if(d != null && d.userErrorMessage!=null){
            system.debug(LoggingLevel.DEBUG,'Exiting QQuoteParseError_AC:parseErrorMessage:'+d.userErrorMessage);
            if(d.developerErrorMessage != null && d.developerErrorMessage.contains('Could not access HTTP invoker remote service at')){
            	d.userErrorMessage = 'Could not able to connect Rental Result Server';
            }
            if((d.developerErrorMessage != null && d.developerErrorMessage.contains('Unable to tunnel through proxy')) || (d.userErrorMessage != null && d.userErrorMessage.contains('Unable to tunnel through proxy')) ){
            	d.userErrorMessage = 'Rental Result Server is down';
            }
            if((d.developerErrorMessage != null && d.developerErrorMessage.contains('failed Error executing')) || (d.userErrorMessage != null && d.userErrorMessage.contains('failed Error executing')) ){
            	d.userErrorMessage = 'Rental Result Server is down';
            }
            if(d.developerErrorMessage != null && d.developerErrorMessage.contains('No tax areas have been found for this address')){
            	d.userErrorMessage = 'No tax areas have been found for this address';
            }
            if(d.userErrorMessage != null && d.userErrorMessage.contains('There has been a problem on the server')){
            	d.userErrorMessage = 'Rental Result Server is down';
            }
            if(d.userErrorMessage != null && d.userErrorMessage.contains('failed Read timed out')){
            	d.userErrorMessage = 'Request timeout. Please try again';
            }
            return d.userErrorMessage;
        }else if(d != null && d.developerErrorMessage!=null ){
            system.debug(LoggingLevel.DEBUG,'Exiting QQuoteParseError_AC:parseErrorMessage:'+d.developerErrorMessage);
            if(d.developerErrorMessage != null && d.developerErrorMessage.contains('Could not access HTTP invoker remote service at')){
            	d.developerErrorMessage = 'Could not able to connect Rental Result Server';
            }
            if((d.developerErrorMessage != null && d.developerErrorMessage.contains('Unable to tunnel through proxy')) || (d.userErrorMessage != null && d.userErrorMessage.contains('Unable to tunnel through proxy')) ){
            	d.developerErrorMessage = 'Rental Result Server is down';
            }
            if((d.developerErrorMessage != null && d.developerErrorMessage.contains('failed Error executing')) || (d.userErrorMessage != null && d.userErrorMessage.contains('failed Error executing')) ){
            	d.developerErrorMessage = 'Rental Result Server is down';
            }
            if(d.developerErrorMessage != null && d.developerErrorMessage.contains('No tax areas have been found for this address')){
            	d.developerErrorMessage = 'No tax areas have been found for this address';
            }
            if(d.userErrorMessage != null && d.userErrorMessage.contains('There has been a problem on the server')){
            	d.developerErrorMessage = 'Rental Result Server is down';
            }
            if(d.userErrorMessage != null && d.userErrorMessage.contains('failed Read timed out')){
            	d.developerErrorMessage = 'Request timeout. Please try again';
            }
            return d.developerErrorMessage;
        }else{
            system.debug(LoggingLevel.DEBUG,'Exiting QQuoteParseError_AC:parseErrorMessage:');
            return 'Error Occurred. Please check all the necessary fields are filled out';
        }
    }
    
    /*********************************************************************
    Purpose     : This is inner class to initializing and holding after 
                  JSON parsing
    Parameters  : none
    Returns     : none
    **********************************************************************/
    public class parseErr
    {
        public String userErrorMessage{get;set;}
        public String developerErrorMessage{get;set;}
        public String errorCode{get;set;}
    }
    
    
}