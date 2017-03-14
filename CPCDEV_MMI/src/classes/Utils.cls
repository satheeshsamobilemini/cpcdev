public with sharing class Utils {
	
	public static string processNumericPhone(String tPhone){
	  //string duplicatephone = '';
	  if( tPhone != null && tPhone != ''){
	     
	   //tPhone = tPhone.trim().replace('-','').replace(' ','').replace('(','').replace(')','').replace('[','');
	  	return tPhone.replaceAll('\\D','');
	    
	   /* for( integer i = 0 ; i < localPhone.length() ; i++){          
	  	  
	      
	      if(  localPhone.substring(i, i+1) == '0' 
	            || localPhone.substring(i, i+1) == '1' 
	            || localPhone.substring(i, i+1) == '2' 
                || localPhone.substring(i, i+1) == '3'
                || localPhone.substring(i, i+1) == '4' 
                || localPhone.substring(i, i+1) == '5' 
                || localPhone.substring(i, i+1) == '6'
                || localPhone.substring(i, i+1) == '7'
                || localPhone.substring(i, i+1) == '8'
                || localPhone.substring(i, i+1) == '9'){
              
            duplicatephone =  duplicatephone+localPhone.substring(i, i+1);
          }
	    }*/
	  }
	  return tPhone ;//duplicatephone ;
	}

}