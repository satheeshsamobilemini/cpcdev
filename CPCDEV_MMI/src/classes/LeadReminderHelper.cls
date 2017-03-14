/**************************************
Created Date : 06 Mar 2010
Cretaed By : Megha Agarwal(Appirio OffShore)

Usage :This helper class calculate hours difference between lead inserted date and next business hours.

*************************************/
public class LeadReminderHelper{
	
	public LeadReminderHelper(){}
	
//set reminder time in bussiness hours
   public static DateTime setReminderTime(DateTime leadCreatedDate,String timeZone){
   	    DateTime leadReminderTime;
   	    Integer hrDifference = calculateHrsDifference(leadCreatedDate,timeZone);
   	    if(hrDifference > 0){
   	    	 leadReminderTime = leadCreatedDate.addHours(hrDifference);
        	 Integer mins =  - leadReminderTime.minute();
        	 leadReminderTime = leadReminderTime .addMinutes(mins);
   	    }else{
   	    	leadReminderTime = leadCreatedDate;
   	    }
        return leadReminderTime;
   }
   
   
   public static Integer calculateHrsDifference(DateTime dateTZ,String timeZone){
        String userTimeZoneDateStr = dateTZ.format('yyyy-MM-dd HH:mm:ss',timeZone); 
        Integer yearInUserTZ =  dateSubStringInInteger(userTimeZoneDateStr,0, 4);
        Integer monthInUserTZ = dateSubStringInInteger(userTimeZoneDateStr,5, 7);
        Integer dayInUserTZ =  dateSubStringInInteger(userTimeZoneDateStr,8, 10);
        Integer hoursInUserTZ = dateSubStringInInteger(userTimeZoneDateStr,11, 13);
        Integer minsInUserTZ = dateSubStringInInteger(userTimeZoneDateStr,14, 16);
        Integer secsInUserTZ = dateSubStringInInteger(userTimeZoneDateStr,17, 19);
        Integer hrDifference = hrsDifference(yearInUserTZ,monthInUserTZ,dayInUserTZ,hoursInUserTZ,minsInUserTZ,secsInUserTZ);
        return hrDifference;
  	}
    
    
  	public static Integer hrsDifference(Integer yearInUserTZ,Integer monthInUserTZ,Integer dayInUserTZ,Integer hoursInUserTZ,Integer minsInUserTZ,Integer secsInUserTZ){
        DateTime userTZLeadCreatedDate = DateTime.newInstance(yearInUserTZ  , monthInUserTZ , dayInUserTZ , 0, 0, 0);
        Integer hoursDifference = 0 ;
    	if(userTZLeadCreatedDate.format('E')=='Sat'){
        	hoursDifference = (24 - hoursInUserTZ)+ 24 + 8;
        }else if(userTZLeadCreatedDate.format('E')=='Sun'){
        	hoursDifference = (24 - hoursInUserTZ) + 8;
        }else if(userTZLeadCreatedDate.format('E')=='Fri' && hoursInUserTZ > 16){
        	hoursDifference = (24 - hoursInUserTZ) + 48 + 8;
        }else if(hoursInUserTZ > 16){
        	hoursDifference = (24 - hoursInUserTZ) +  8;
        }else if(hoursInUserTZ < 8){
        	hoursDifference = 8 - hoursInUserTZ;
        }else{
        	hoursDifference = 0;
        }
    	return hoursDifference;
  }

   public static Integer dateSubStringInInteger(String userTimeZoneDateStr,Integer startIndex,Integer lastIndex){
   	    Integer dateInInteger =  Integer.valueOf(userTimeZoneDateStr.substring(startIndex,lastIndex));
   	    return dateInInteger;
   }
   
   
   //Set Lead Reminder Time on the basis of lead created date and owner's TimeZone
	public static Lead setLeadReminderTime(Lead newLead,String timeZone){
   	    if(newLead.CreatedDate != null && timeZone != null){
   	    	newLead.Lead_Reminder_Time__c = setReminderTime(newLead.createdDate,timeZone);
   	    }
   	    return newLead;
    }
   
   //update Lead Reminder Time on the basis of lead last Modified Date and owner's TimeZone.
   	public static Lead updateLeadReminderTime(Lead leadToUpdate,String timeZone){
   	    if(leadToUpdate.LastModifiedDate != null && timeZone != null){
   	    	leadToUpdate.Lead_Reminder_Time__c = setReminderTime(leadToUpdate.LastModifiedDate,timeZone);
   	    }
   	    return leadToUpdate;
   	}  
}