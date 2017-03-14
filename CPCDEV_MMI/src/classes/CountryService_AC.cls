/**************************************************************************
Name:  CountryService_AC()
Copyright © 2013  MMI
----------------------------------------------------------------------
Purpose:
This class contains the methods for Country Service HTTP Rest web service Callouts 
-----------------------------------------------------------------------
History:

VERSION  AUTHOR                 DATE        DETAIL              
1.0  -  TEKsystems             11/2/2013   INITIAL DEVELOPMENT  
**************************************************************************/
public with sharing class CountryService_AC implements ICountryService{
	
    public String countryResponse {get;set;}
   /*********************************************************************
    Purpose     : To get the list of countries
    Parameters  : none
    Returns     : List of HomeBaseBeans.countries
    **********************************************************************/
    public List<HomeBaseBeans.countries> listCountry(){
    	system.debug(LoggingLevel.DEBUG,'Entering CountryService_AC:listCountry:');
    	/*ServiceProxy servicePro =null;
    	List<HomeBaseBeans.countries> HBList=null;
    	countryListClass allCountries;
        try{ 
            servicePro = new ServiceProxy();
            if(!Test.isRunningTest()){        
            countryResponse = servicePro.callRestService('rest/api/v1/countries','GET','');
            }
	        if(countryResponse!=null && !countryResponse.contains('"errorCode"')){
		        allCountries = (countryListClass)JSON.deserialize(countryResponse, countryListClass.class);
		        
			}else{
				HBList = new List<HomeBaseBeans.countries>();
				HomeBaseBeans.countries h = new HomeBaseBeans.countries();
				String errorMessage = QuickQuoteErrorHandler.handleError(countryResponse);
				h.errorMessage = errorMessage;
				HBList.add(h);
			}
	    }
	    catch(Exception e)
	    {
	    	system.debug(LoggingLevel.ERROR,'Error when list of countries:'+e.getMessage());	
	    	String errorMessage = e.getMessage();
	        HBList = new List<HomeBaseBeans.countries>();
			HomeBaseBeans.countries h = new HomeBaseBeans.countries();
			h.errorMessage = errorMessage;
			HBList.add(h);
			return HBList;
	    }
	    
	    if(HBList!=null && !HBList.isEmpty()){
	    	system.debug(LoggingLevel.DEBUG,'Exiting CountryService_AC:listCountry:'+HBList);
	        return HBList;
	    }else{
	    	system.debug(LoggingLevel.DEBUG,'Exiting CountryService_AC:listCountry:'+allCountries.countries);
	    	return allCountries.countries;
	    }*/
	    List<HomeBaseBeans.countries> lstCountry = new List<HomeBaseBeans.countries>();
	    
	    list<FQ_County_Setting__c> fqCountries = null;
		if(FQ_County_Setting__c.getAll() != null){
			fqCountries = FQ_County_Setting__c.getAll().Values();
			if(fqCountries != null && !fqCountries.isEmpty()){
				String allCountries = fqCountries.get(0).Country__c;
				if(allCountries != null && allCountries != ''){
					list<String> lstAllCountries = allCountries.split(',');
					for(String s: lstAllCountries){
						list<String> listCountry = s.split('_');
						HomeBaseBeans.countries cnty = new HomeBaseBeans.countries();
					    cnty.id = listCountry[0];
					    cnty.Name = listCountry[1];
					    lstCountry.add(cnty);
					}
				}
		     }
         }
	    
	    /*HomeBaseBeans.countries c1 = new HomeBaseBeans.countries();
	    c1.id = 'CAN';
	    c1.Name = 'Canada';
	    lstCountry.add(c1);
	    HomeBaseBeans.countries c2 = new HomeBaseBeans.countries();
	    c2.id = 'GB';
	    c2.Name = 'Great Britain';
	    lstCountry.add(c2);
	    HomeBaseBeans.countries c3 = new HomeBaseBeans.countries();
	    c3.id = 'OTH';
	    c3.Name = 'Other Non-US';
	    lstCountry.add(c3);
	    HomeBaseBeans.countries c4 = new HomeBaseBeans.countries();
	    c4.id = 'SA';
	    c4.Name = 'South Africa';
	    lstCountry.add(c4);
	    HomeBaseBeans.countries c5 = new HomeBaseBeans.countries();
	    c5.id = 'USA';
	    c5.Name = 'USA';
	    lstCountry.add(c5);*/
	    
	    return lstCountry;
	    
	    
    }
    
    /*********************************************************************
    Purpose     : This is inner class to initializing and holding after 
                  JSON parsing
    Parameters  : none
    Returns     : none
    **********************************************************************/
    public class countryListClass
    {
        public HomeBaseBeans.countries[] countries;
        public countryListClass()
        {
             this.countries = new List<HomeBaseBeans.countries>();
        }
    }
        
        
    /*******************************************************************
                    TESTS
    ********************************************************************/

	        
}