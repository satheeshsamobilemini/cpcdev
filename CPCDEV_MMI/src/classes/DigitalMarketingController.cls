/************************************************************************************************************
* Name          : DigitalMarketingController
* Created Date  : 19 April 2013
* Created By    : Appirio Offshore (Hemant)
* Description   : Controller Class for VF Page: DigitalMarketing [To display the Digital Lead Summary]
* Related Story : S-111001  
************************************************************************************************************/

public class DigitalMarketingController{

		//Constansts
		private static final String ERROR_MESSAGE = 'There are large number of records queried that cannot be shown on the page. Please apply the filters to refine your search criteria.';
		private static final String DATE_FILTER_RANGE_TODAY = 'Today';
		private static final String DATE_FILTER_RANGE_THIS_WEEK = 'This_Week';
		private static final String DATE_FILTER_RANGE_THIS_MONTH = 'This_Month';
		private static final String DATE_FILTER_RANGE_THIS_YEAR = 'This_Year';
		private static final String DATE_FILTER_RANGE_LAST_WEEK = 'Last_Week';
		private static final String DATE_FILTER_RANGE_LAST_MONTH = 'Last_Month';
		private static final String DATE_FILTER_RANGE_LAST_YEAR = 'Last_Year';
		private static final String DATE_FILTER_RANGE_CUSTOM = 'Custom';
		
		private static final String NAME_INTEGRATION_USER = 'Integration User';
		private static final String RECORDTYPE_MMI_WEB = 'MMI Web Lead';
		private static final String LEADSOURCE_MMI_US_WEBSITE = 'MMI US Website';
		private static final String LEADSOURCE_MMI_STORAGE_WEBSITE = 'Mobile Storage Website';
		
		//constants for Digital Lead Summary
		private static final String LEAD_STORAGE_CATEGORY_RESIDENTIAL = 'Residential';
		private static final String LEAD_STATUS_OPEN = 'Open';
		private static final String LEAD_STATUS_DEAD = 'Dead Lead';
		private static final String CONVERTED_OPP_STAGE_NOT_QUOTED = 'Not Quoted';
		private static final String CONVERTED_OPP_STAGE_QUOTED_NO_DECISION = 'Quoted - No Decision';
		private static final String CONVERTED_OPP_STAGE_QUOTED_WON = 'Quoted - Won';
		private static final String CONVERTED_OPP_STAGE_QUOTED_LOST = 'Quoted - Lost Business';
		
		private static final string PICKLIST_OPTION_NONE = '--None--';
		private static final string GA_DATA_TYPE_GA_CONTENT = 'GA Content';
		private static final string GA_DATA_TYPE_GA_TERM = 'GA Term';
    
    private static final Integer LIMIT_CODE_STATEMENTS_MAX = 190000;
        
    public Map<String,WrapperGAContent> wrpGAContMap{get;set;}
    
    public List<WrapperGAContent> wrpGAContLst {get;set;}
    public List<WrapperGATerm> wrpGATermLstForCSV {get;set;}
        
    // Lead instance used to show report filter 
    public Lead leadFrom{get;set;}
    public Lead leadTo{get;set;}
    public boolean showData{get;set;}
    private List<Lead> ldLst;
    private Map<Integer,String> monthNumNameMap;
    private Map<Integer,String> dayNumNameMap;
    
    private Date fromCreatedDate;
    private Date toCreatedDate;
    private String ldCity;
    private String ldGATerm;
    private Integer limitCount;
    private String createdDateFilter;
    
    //For Storage Category
    public List<String> selectedStorageCategory{get;set;}  
    public List<SelectOption> StorageCategoryList{get;set;}
    
    //For GAContent
    public List<String> selectedGAContent{get;set;}  
    public List<SelectOption> GAContentList{get;set;}
    
    //For GACampaign
    public String selectedGACampaign{get;set;}  
    public List<SelectOption> GACampaignList{get;set;}
    
    //For GA Medium
    public String selectedGAMedium{get;set;}  
    public List<SelectOption> GAMediumList{get;set;}
    
    //For Date Filter
    public String selectedDateFilter{get;set;}  
    public List<SelectOption> dateFilterList{get;set;}
    
    //constructor
    public DigitalMarketingController(){
        init();
    }
    
    //initialization method
    private void init(){
        
        leadFrom = new Lead();
        leadTo = new Lead();
        wrpGAContLst = new List<WrapperGAContent>();
        showData = false;
        
        //load the Filter options
        loadFilterOptions();
        dateFilterList = getDateFilterOptions();
        selectedGAContent = new List<String>();
        selectedStorageCategory = new List<String>();
        ldLst = new List<Lead>();
        graphDataLst = new List<GraphData>();
    }
    
    
    //loading Filters Picklist values
    private void loadFilterOptions(){
        GAContentList = new List<SelectOption>();
        GACampaignList = new List<SelectOption>{new SelectOption('', PICKLIST_OPTION_NONE)};
        GAMediumList = new List<SelectOption>{new SelectOption('', PICKLIST_OPTION_NONE)};
        StorageCategoryList = new List<SelectOption>();
        
        //using custom setting DigitalMarketing_Filters__c
        Map<String, DigitalMarketing_Filters__c> digMrkFiltersMap = DigitalMarketing_Filters__c.getAll();
        
        for(DigitalMarketing_Filters__c dmF : DigitalMarketing_Filters__c.getAll().values()){
            //loading GA Content Picklist values
            if(dmF.GA_Content_Picklist__c != null){
                for(String GACont : dmF.GA_Content_Picklist__c.split(';')){
                		if(GACont == 'Null'){
                			GAContentList.add(new SelectOption('', GACont));
                			continue;
                		}
                    GAContentList.add(new SelectOption(GACont, GACont));
                }               
            }
            //loading GA Campaign Picklist values
            if(dmF.GA_Campaign_Picklist__c != null){
                    for(String GACamp : dmF.GA_Campaign_Picklist__c.split(';')){
                    GACampaignList.add(new SelectOption(GACamp, GACamp));
                }               
            }
            //loading GA Medium Picklist values
            if(dmF.GA_Medium_Picklist__c != null){
                for(String gam : dmF.GA_Medium_Picklist__c.split(';')){
                    GAMediumList.add(new SelectOption(gam, gam));
                }               
            }
        }
        
        //loading Storage Category Picklist values
        List<Schema.PicklistEntry> ple = Lead.Storage_Category__c.getDescribe().getPicklistValues();
       	for( Schema.PicklistEntry f : ple){
           StorageCategoryList.add(new SelectOption(f.getLabel(), f.getValue()));
       	} 
    }
    
    //loading Date filter options
    private List<SelectOption> getDateFilterOptions(){
        List<SelectOption> options = new List<SelectOption>();
      options.add(new SelectOption('', 'Select'));
      options.add(new SelectOption(DATE_FILTER_RANGE_TODAY, 'Today'));
      options.add(new SelectOption(DATE_FILTER_RANGE_THIS_WEEK, 'This Week'));
      options.add(new SelectOption(DATE_FILTER_RANGE_LAST_WEEK, 'Last Week'));
      options.add(new SelectOption(DATE_FILTER_RANGE_THIS_MONTH, 'This Month'));
      options.add(new SelectOption(DATE_FILTER_RANGE_LAST_MONTH, 'Last Month'));
      options.add(new SelectOption(DATE_FILTER_RANGE_THIS_YEAR, 'This Year'));
      options.add(new SelectOption(DATE_FILTER_RANGE_LAST_YEAR, 'Last Year'));
      options.add(new SelectOption(DATE_FILTER_RANGE_CUSTOM, DATE_FILTER_RANGE_CUSTOM));
        return options;
    }
    
    //method to set the date filter range
    public void setDateFilterRange(){
        
        if(selectedDateFilter != null && selectedDateFilter == DATE_FILTER_RANGE_TODAY){
            leadFrom.Date_Required__c = leadTo.Date_Required__c = Date.today();
            createdDateFilter = 'TODAY';
        }
        else if(selectedDateFilter != null && selectedDateFilter == DATE_FILTER_RANGE_THIS_WEEK){
            leadFrom.Date_Required__c = date.today().toStartofWeek();
            leadTo.Date_Required__c = Date.today().toStartofWeek().addDays(6);
            createdDateFilter = 'THIS_WEEK';
        }
        else if(selectedDateFilter != null && selectedDateFilter == DATE_FILTER_RANGE_LAST_WEEK){
            leadFrom.Date_Required__c = date.today().toStartofWeek().addDays(-7);
            leadTo.Date_Required__c = leadFrom.Date_Required__c.addDays(6);
            createdDateFilter = 'LAST_WEEK';
        }
        else if(selectedDateFilter != null && selectedDateFilter == DATE_FILTER_RANGE_THIS_MONTH){
            leadFrom.Date_Required__c = date.today().toStartOfMonth();
            Integer daysInCurrentMonth = date.daysInMonth(date.today().year(), date.today().month());
            leadTo.Date_Required__c = Date.today().toStartOfMonth().addDays(daysInCurrentMonth-1);
            createdDateFilter = 'THIS_MONTH';
        }
        else if(selectedDateFilter != null && selectedDateFilter == DATE_FILTER_RANGE_LAST_MONTH){
            leadFrom.Date_Required__c = date.today().toStartOfMonth().addMonths(-1);
            Integer daysInCurrentMonth = date.daysInMonth(leadFrom.Date_Required__c.year(), leadFrom.Date_Required__c.month());
            leadTo.Date_Required__c = leadFrom.Date_Required__c.addDays(daysInCurrentMonth-1);
            createdDateFilter = 'LAST_MONTH';
        }
        else if(selectedDateFilter != null && selectedDateFilter == DATE_FILTER_RANGE_THIS_YEAR){
            leadFrom.Date_Required__c = date.newInstance(date.today().year(), 1, 1);
            leadTo.Date_Required__c = date.newInstance(date.today().year(), 12, 31);
            createdDateFilter = 'THIS_YEAR';
        }
        else if(selectedDateFilter != null && selectedDateFilter == DATE_FILTER_RANGE_LAST_YEAR){
            leadFrom.Date_Required__c = date.newInstance(date.today().year()-1, 1, 1);
            leadTo.Date_Required__c = date.newInstance(date.today().year()-1, 12, 31);
            createdDateFilter = 'LAST_YEAR';
        }
    }
    
    /**
    * This method is used to retrive leads meeting the filter criteria
    */
    public void retriveLeadData(){
	    try{
	    	showData = true;
	    	wrpGAContMap = new Map<String,WrapperGAContent>();
	    	ldLst = (List<Lead>)Database.query(getLeadQuery());
    	
	    	for(Lead ld : ldLst){
	    		
	    		if(Limits.getScriptStatements() >= LIMIT_CODE_STATEMENTS_MAX){
	    			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Warning,ERROR_MESSAGE));
	      		return;
	    		}
	    		
	    		String gaCont = (ld.cloudamp__GA_Content__c != null ? ld.cloudamp__GA_Content__c : '--');
	    		String gaTerm = (ld.cloudamp__GA_Term__c != null ? ld.cloudamp__GA_Term__c : '--');
	    		
	    		if(!wrpGAContMap.keySet().contains(gaCont.toUpperCase())){
	    			wrpGAContMap.put(gaCont.toUpperCase(), new WrapperGAContent(gaCont));
	    		}
	    		
	    		if(!wrpGAContMap.get(gaCont.toUpperCase()).GATermMap.keySet().contains(gaTerm.toUpperCase())){
	    			wrpGAContMap.get(gaCont.toUpperCase()).GATermMap.put(gaTerm.toUpperCase(), new WrapperGATerm(gaTerm,GA_DATA_TYPE_GA_TERM));
	    		}
	    		
	    		/*******  Calculating Columns of Digital Lead Summary Start ***************************/
	    		//Calculating total Lead count (Total Leads received - created by integration user, record GA Medium = MMI Web lead, Lead Source = MMI US Website, Mobile Storage Website) in Digital Lead Summary	    		
	    		wrpGAContMap.get(gaCont.toUpperCase()).GATermMap.get(gaTerm.toUpperCase()).totalLdCount += 1;
	    		
	    		//Calculating % Residential (# of leads where storage category = residential / total leads   (%)) in Digital Lead Summary
	    		if(ld.Storage_Category__c == LEAD_STORAGE_CATEGORY_RESIDENTIAL){
	    			wrpGAContMap.get(gaCont.toUpperCase()).GATermMap.get(gaTerm.toUpperCase()).residentialLdCount += 1;
	    		}
	    		
	    		//Calculating Open (Lead Status = Open) in Digital Lead Summary
	    		if(ld.Status == LEAD_STATUS_OPEN){
	    			wrpGAContMap.get(gaCont.toUpperCase()).GATermMap.get(gaTerm.toUpperCase()).openLdCount += 1;
	    		}
	    		
	    		//Calculating Converted (Isconverted = True (converted to an Account)) in Digital Lead Summary
	    		if(ld.Isconverted){
	    			wrpGAContMap.get(gaCont.toUpperCase()).GATermMap.get(gaTerm.toUpperCase()).convertedLdCount += 1;
	    		}
	    		
	    		//Calculating Dead (Lead Status = Dead) in Digital Lead Summary
	    		if(ld.Status == LEAD_STATUS_DEAD){
	    			wrpGAContMap.get(gaCont.toUpperCase()).GATermMap.get(gaTerm.toUpperCase()).deadLdCount += 1;
	    		}
	    		
	    		//Calculating Opps Created (# of Opps created from the leads) in Digital Lead Summary
	    		if(ld.ConvertedOpportunityId != null){
	    			wrpGAContMap.get(gaCont.toUpperCase()).GATermMap.get(gaTerm.toUpperCase()).oppsCreatedLdCount += 1;
	    			
	    			//Calculating Open (# of open opps from the leads . Stage = Not Quoted, Quoted - No Decision) in Digital Lead Summary
		    		if(ld.ConvertedOpportunity.StageName == CONVERTED_OPP_STAGE_NOT_QUOTED || ld.ConvertedOpportunity.StageName == CONVERTED_OPP_STAGE_QUOTED_NO_DECISION){
		    			wrpGAContMap.get(gaCont.toUpperCase()).GATermMap.get(gaTerm.toUpperCase()).openOppsCreatedLdCount += 1;
		    		}
		    		
		    		//Calculating Won	(# of opps won from the leads. Stage = Quoted - Won) in Digital Lead Summary
		    		if(ld.ConvertedOpportunity.StageName == CONVERTED_OPP_STAGE_QUOTED_WON){
		    			wrpGAContMap.get(gaCont.toUpperCase()).GATermMap.get(gaTerm.toUpperCase()).wonLdCount += 1;
		    		}
		    		
		    		//Calculating Lost (# of opps lost from the leads. Stage = Quoted - Lost) in Digital Lead Summary
		    		if(ld.ConvertedOpportunity.StageName == CONVERTED_OPP_STAGE_QUOTED_LOST){
		    			wrpGAContMap.get(gaCont.toUpperCase()).GATermMap.get(gaTerm.toUpperCase()).lostLdCount += 1;
		    		}
	    		}
	    		
	    		/*******  Calculating Columns of Digital Lead Summary End ***************************/
	    		
	    		wrpGAContMap.get(gaCont.toUpperCase()).GATermMap = wrpGAContMap.get(gaCont.toUpperCase()).GATermMap;
	    		wrpGAContMap.get(gaCont.toUpperCase()).GAContentCount += 1;
	    		//system.debug('******************196: '+ wrpGAContMap);
	    		
	    	}
	    	
	    	wrpGAContLst = wrpGAContMap.values();
	    	
	    	//Preparing data for GA Content rows
	    	for(WrapperGAContent wrpGACont : wrpGAContLst){
	    		WrapperGATerm GACont_WrapperGATerm = new WrapperGATerm(wrpGACont.GAContent, GA_DATA_TYPE_GA_CONTENT); 
	    		
	    		for(WrapperGATerm wrpGATerm : wrpGACont.GATermMap.values()){
	    			
	    			GACont_WrapperGATerm.totalLdCount += wrpGATerm.totalLdCount;
	    			GACont_WrapperGATerm.residentialLdCount += wrpGATerm.residentialLdCount;
	    			GACont_WrapperGATerm.openLdCount += wrpGATerm.openLdCount;
	    			GACont_WrapperGATerm.convertedLdCount += wrpGATerm.convertedLdCount;
	    			GACont_WrapperGATerm.deadLdCount += wrpGATerm.deadLdCount;
	    			GACont_WrapperGATerm.oppsCreatedLdCount += wrpGATerm.oppsCreatedLdCount;
	    			GACont_WrapperGATerm.openOppsCreatedLdCount += wrpGATerm.openOppsCreatedLdCount;
	    			GACont_WrapperGATerm.wonLdCount += wrpGATerm.wonLdCount;
	    			GACont_WrapperGATerm.lostLdCount += wrpGATerm.lostLdCount;
	    		}
	    		wrpGACont.GA_Cont_GATermLst.add(GACont_WrapperGATerm);
	    	}
	    	//system.debug('******************199: '+ wrpGAContLst);
	    	
	    	//initialize the graph whenever the data is loaded
	    	graphDataLst = new List<GraphData>();
	    }
	    catch(Exception ex){
	        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Warning,ERROR_MESSAGE));
	      return;
	    }
    }
    
   
   //method to get the leads query 
   private String getLeadQuery(){
     String soqlQry = 'select Id, CreatedDate, OwnerId ,LeadSource, cloudamp__GA_Term__c, cloudamp__GA_Content__c, cloudamp__GA_Campaign__c, Storage_Category__c, Status, Isconverted, ConvertedOpportunityId, ConvertedOpportunity.StageName From Lead';
        
     String soqlQry_Where = getSOQLQuery_WhereCondition();
     
     soqlQry += soqlQry_Where + getSOQLQuery_LimitCondition();
     system.debug('*********soqlQry**********' + soqlQry);
     return soqlQry; 
    }
    
    // method to get the where condition query after applying the filters
    private String getSOQLQuery_WhereCondition(){
      String soqlQry_Where = ' Where CreatedBy.Name = :NAME_INTEGRATION_USER';
      soqlQry_Where += ' AND RecordType.Name =: RECORDTYPE_MMI_WEB';
      soqlQry_Where += ' AND (LeadSource =: LEADSOURCE_MMI_US_WEBSITE OR LeadSource =: LEADSOURCE_MMI_STORAGE_WEBSITE)';
     
     //for multiselect Storage_Category__c
     if(selectedStorageCategory != null && selectedStorageCategory.size() > 0){
       soqlQry_Where += ' AND Storage_Category__c IN : selectedStorageCategory';
     }
     
     if(leadFrom.City != null && leadFrom.City != ''){
     	 ldCity = leadFrom.City;
       soqlQry_Where += ' AND cloudamp__GA_Campaign__c Like \'%' + ldCity + '%\'';
     }
     
     if(leadFrom.cloudamp__GA_Term__c != null && leadFrom.cloudamp__GA_Term__c != ''){
     	 ldGATerm = leadFrom.cloudamp__GA_Term__c;
       soqlQry_Where += ' AND cloudamp__GA_Term__c Like \'%' + ldGATerm + '%\'';
     }
     
     //for multiselect cloudamp__GA_Content__c
     if(selectedGAContent != null && selectedGAContent.size() > 0){
       soqlQry_Where += ' AND cloudamp__GA_Content__c IN : selectedGAContent';
     }
     
     if(selectedGACampaign != null && selectedGACampaign != ''){
       soqlQry_Where += ' AND cloudamp__GA_Campaign__c =: selectedGACampaign';
     }
     
     if(selectedGAMedium != null && selectedGAMedium != ''){
		    soqlQry_Where += ' AND cloudamp__GA_Medium__c =: selectedGAMedium';
     }
     
     if(selectedDateFilter != null && selectedDateFilter != '' && leadFrom.Date_Required__c != null && leadTo.Date_Required__c != null){
         if(selectedDateFilter == DATE_FILTER_RANGE_CUSTOM){        
           fromCreatedDate = leadFrom.Date_Required__c;
         	 toCreatedDate = leadTo.Date_Required__c.addDays(1);
           soqlQry_Where += ' AND (CreatedDate >= : fromCreatedDate AND CreatedDate <: toCreatedDate)';         
         }else{
         	 soqlQry_Where += ' AND (CreatedDate = ' + createdDateFilter + ')';
         }
     }
     
     return soqlQry_Where; 
    }
    
    // method to get the limit condition query 
    private String getSOQLQuery_LimitCondition(){
        limitCount = Limits.getLimitQueryRows() - Limits.getQueryRows();
      return ' Limit ' + String.valueOf(limitCount);
      
    }
    
    // method to redirect the user to Export file 
    public PageReference exportCSV(){
    	createCSVFileData();
      PageReference pg = new PageReference('/apex/DigitalLeadSummary');
      return pg; 
    }
    
    //method to create the data for the csv file to be exported
    private void createCSVFileData(){
    	
    	wrpGATermLstForCSV = new List<WrapperGATerm>();
    	
    	//Preparing data for csv file rows
    	for(WrapperGAContent wrpGACont : wrpGAContLst){
    		
    		//Adding the row for GA Content
    		wrpGATermLstForCSV.add(wrpGACont.GA_Cont_GATermLst.get(0));
    		
    		//Adding the rows for GA Terms cfor above master GA Content row
    		wrpGATermLstForCSV.addAll(wrpGACont.GATermMap.values());
    		
    		//Adding BLANK row in csv
    		wrpGATermLstForCSV.add(new WrapperGATerm());
    	}	
    }
    
  //wrapper class to maintain the data for GA content
  public class WrapperGAContent{
  	
  	public String GAContent{get;set;}
  	public Integer GAContentCount{get;set;}
  	public Map<String,WrapperGATerm> GATermMap {get;set;}
  	public List<WrapperGATerm> GA_Cont_GATermLst {get;set;}
    
    public WrapperGAContent(String contName){
    	GAContent = contName;
    	GAContentCount = 0;
    	GATermMap = new Map<String,WrapperGATerm>();
    	GA_Cont_GATermLst = new List<WrapperGATerm>();
    }
  }
  
  //wrapper class to maintain the data for GA Term
  public class WrapperGATerm{
        
        public String GADataType{get;set;}
        public String GATermName{get;set;}
        public Integer totalLdCount{get;set;}
        public Integer residentialLdCount{get;set;}
        public Integer convertedLdCount{get;set;}
        public Integer deadLdCount{get;set;}
        public Integer oppsCreatedLdCount{get;set;}
        public Integer openOppsCreatedLdCount{get;set;}
        public Integer openLdCount{get;set;}
        public Integer wonLdCount{get;set;}
        public Integer lostLdCount{get;set;}
        
        public WrapperGATerm(String termName, String dataType){
            totalLdCount = 0;
            residentialLdCount = 0;
            openLdCount = 0;
            convertedLdCount = 0;
            deadLdCount = 0;
            oppsCreatedLdCount = 0;
            openOppsCreatedLdCount = 0;
            wonLdCount = 0;
            lostLdCount = 0;
            GATermName = termName;
            GADataType = dataType;
        }
        
        public WrapperGATerm(){
        	
        }
  }
  
  /************************************** Trend Graph Start**************************************************/
  // The actual chart data to be shown on the graph
    public void showGraphData() {
    	monthNumNameMap = new Map<Integer,String>{1 => 'Jan', 2 => 'Feb', 3 => 'Mar', 4 => 'Apr', 5 => 'May', 6 => 'Jun', 7 => 'Jul', 8 => 'Aug', 9 => 'Sep', 10 => 'Oct', 11 => 'Nov', 12 => 'Dec'};
    	
    	if(!graphDataLst.Isempty()){
    		graphDataLst.clear();
    	}
    	Map<Date,GraphData> dateGrpDtaMap = new Map<Date,GraphData>();
    	List<Date> sortedDtLst = new List<Date>(); 
    	 
	    		if(selectedDateFilter != null && selectedDateFilter == DATE_FILTER_RANGE_TODAY){
	    				Date weekStart = Date.today().toStartOfWeek();
	    				for(integer i = 0; i<7 ; i++){
	    					dateGrpDtaMap.put(weekStart.addDays(i), new GraphData(weekStart.addDays(i).format(), 0, 0, 0));
	    					sortedDtLst.add(weekStart.addDays(i));
	    				}
	        }
	        else if(selectedDateFilter != null && selectedDateFilter == DATE_FILTER_RANGE_THIS_WEEK){
	            Date weekStart = Date.today().toStartOfWeek();
	            for(integer i = 0; i<7 ; i++){
	    					dateGrpDtaMap.put(weekStart.addDays(i), new GraphData(weekStart.addDays(i).format(), 0, 0, 0));
	    					sortedDtLst.add(weekStart.addDays(i));
	    				}
	        }
	        else if(selectedDateFilter != null && selectedDateFilter == DATE_FILTER_RANGE_LAST_WEEK){
	            Date weekStart = Date.today().toStartofWeek().addDays(-7);
	            for(integer i = 0; i<7 ; i++){
	    					dateGrpDtaMap.put(weekStart.addDays(i), new GraphData(weekStart.addDays(i).format(), 0, 0, 0));
	    					sortedDtLst.add(weekStart.addDays(i));
	    				}
	        }
	        else if(selectedDateFilter != null && selectedDateFilter == DATE_FILTER_RANGE_THIS_MONTH){
	            Integer daysInCurrentMonth = date.daysInMonth(date.today().year(), date.today().month());
	            
	            Date weekStart = Date.today().toStartOfMonth();
	            for(integer i = 0; i<daysInCurrentMonth ; i++){
	    					dateGrpDtaMap.put(weekStart.addDays(i), new GraphData(weekStart.addDays(i).format(), 0, 0, 0));
	    					sortedDtLst.add(weekStart.addDays(i));
	    				}
	        }
	        else if(selectedDateFilter != null && selectedDateFilter == DATE_FILTER_RANGE_LAST_MONTH){
	            Integer daysInCurrentMonth = date.daysInMonth(date.today().toStartOfMonth().addMonths(-1).year(), date.today().toStartOfMonth().addMonths(-1).month());
	            
	            Date weekStart = Date.today().toStartOfMonth().addMonths(-1);
	            for(integer i = 0; i<daysInCurrentMonth ; i++){
	    					dateGrpDtaMap.put(weekStart.addDays(i), new GraphData(weekStart.addDays(i).format(), 0, 0, 0));
	    					sortedDtLst.add(weekStart.addDays(i));
	    				}
	        }
	        else if(selectedDateFilter != null && selectedDateFilter == DATE_FILTER_RANGE_THIS_YEAR){
	            Date weekStart = date.newInstance(date.today().year(), 1, 1);
	            for(integer i = 0; i<12 ; i++){
	    					dateGrpDtaMap.put(weekStart.addMonths(i), new GraphData(monthNumNameMap.get(weekStart.addMonths(i).Month()), 0, 0, 0));
	    					sortedDtLst.add(weekStart.addMonths(i));
	    				}
	        }
	        else if(selectedDateFilter != null && selectedDateFilter == DATE_FILTER_RANGE_LAST_YEAR){
	            Date weekStart = date.newInstance(date.today().year()-1, 1, 1);
	            for(integer i = 0; i<12 ; i++){
	    					dateGrpDtaMap.put(weekStart.addMonths(i), new GraphData(monthNumNameMap.get(weekStart.addMonths(i).Month()), 0, 0, 0));
	    					sortedDtLst.add(weekStart.addMonths(i));
	    				}
	        }else if(selectedDateFilter != null && selectedDateFilter == DATE_FILTER_RANGE_CUSTOM && fromCreatedDate != null && toCreatedDate != null){
	            for(Date dt = fromCreatedDate.toStartOfWeek(); dt < toCreatedDate.toStartOfWeek().addDays(7); dt = dt.addDays(7)){
	    					dateGrpDtaMap.put(dt, new GraphData(dt.format() + ' - ' + dt.addDays(6).format(), 0, 0, 0));
	    					sortedDtLst.add(dt);
	    				}
	        }
	    	
	    	for(Lead ld : ldLst){
	    		
	    		if(Limits.getScriptStatements() >= LIMIT_CODE_STATEMENTS_MAX){
	    			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Warning,ERROR_MESSAGE));
	      		return;
	    		}
	    		
	    		Date createdDt = ld.CreatedDate.Date();
	    		if(selectedDateFilter != null && (selectedDateFilter == DATE_FILTER_RANGE_THIS_YEAR || selectedDateFilter == DATE_FILTER_RANGE_LAST_YEAR)){
	    			createdDt = createdDt.toStartOfMonth();
	        }else if(selectedDateFilter != null && selectedDateFilter == DATE_FILTER_RANGE_CUSTOM){
	    			createdDt = createdDt.toStartOfWeek();
	        }
	        
	    		system.debug('******createdDt*****'+createdDt);
	    		if(dateGrpDtaMap.keySet().contains(createdDt)){
	    			
	    			//Calculating total count
	    			dateGrpDtaMap.get(createdDt).totalLdCount += 1;
	    			
		    		//Calculating Converted count
		    		if(ld.Isconverted){
		    			dateGrpDtaMap.get(createdDt).convertedLdCount += 1;
		    		}
		    		
		    		//Calculating Won	count 
		    		if(ld.ConvertedOpportunityId != null && ld.ConvertedOpportunity.StageName == CONVERTED_OPP_STAGE_QUOTED_WON){
			    			dateGrpDtaMap.get(createdDt).wonLdCount += 1;
		    		}
	    		}
	    	}
	    	
	    	for(Date dt : sortedDtLst){
	    		if(dateGrpDtaMap.get(dt).convertedLdCount != 0){
	    			dateGrpDtaMap.get(dt).convertedLdCount = ((dateGrpDtaMap.get(dt).convertedLdCount * 100) / dateGrpDtaMap.get(dt).totalLdCount).setScale(2);
	    		}
	    		
	    		if(dateGrpDtaMap.get(dt).wonLdCount != 0){
	    			dateGrpDtaMap.get(dt).wonLdCount = ((dateGrpDtaMap.get(dt).wonLdCount * 100) / dateGrpDtaMap.get(dt).totalLdCount).setScale(2);	
	    		}
	    		graphDataLst.add(dateGrpDtaMap.get(dt));
	    	}
	    	system.debug('******graphDataLst***********'+graphDataLst);
    }
    
    // Wrapper class
    public class GraphData {
        public String name { get; set; }
        public Integer totalLdCount { get; set; }
        public Decimal convertedLdCount { get; set; }
        public Decimal wonLdCount { get; set; }
        public GraphData(String name, Integer totalLdCount, Decimal convertedLdCount, Decimal wonLdCount) {
            this.name = name;
            this.totalLdCount = totalLdCount;
            this.convertedLdCount = convertedLdCount;
            this.wonLdCount = wonLdCount;
        }
    }
    // Return a list of data points for a chart
    public List<GraphData> graphDataLst{get;set;}
    /************************************** Trend Graph End**************************************************/   
}