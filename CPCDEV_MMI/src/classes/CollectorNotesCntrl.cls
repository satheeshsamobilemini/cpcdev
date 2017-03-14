Public class CollectorNotesCntrl{
    
    public string sinceDate{get;set;}
    public string salesOrg{get;set;}
    public string sapBillTo{get;set;}
    public string recType{get;set;}
    public string filterDate{get;set;}
        
    public static List<WrapperCollectorNotes> collectorNotesData{get;set;}

    Public CollectorNotesCntrl(){
        
        date curDate = date.today();
        date noteFromDate = curDate.addMonths(-3);
        string ntfromDate = string.valueof(noteFromDate);
        ntfromDate = ntfromDate.replace('-','/');
        
        filterDate = ntfromDate; //'2011/01/01';
        salesOrg = ApexPages.currentPage().getParameters().get('salesOrg');
        sapBillTo = ApexPages.currentPage().getParameters().get('sapBillTo');
        string fromDate = ApexPages.currentPage().getParameters().get('sinceDate');
        recType = ApexPages.currentPage().getParameters().get('recType');
        
        if(fromDate == '' || fromDate == null)
            fromDate = ntfromDate; //'20110101'; 
        
        if(fromDate != '' && fromDate != null ){
            if(fromDate.contains('/'))
                filterDate = fromDate;
        }
               
        if(fromDate != '' && fromDate != null)
            sinceDate = fromDate.replace('/','');
        sinceDate = sinceDate + '000000';
        collectorNotesData = new List<WrapperCollectorNotes>();
        collectorNotesData = DataForContracts.getCollectorNotesData(sapBillTo,salesOrg,sinceDate,recType);        
        
        System.debug('===no of notes======'+collectorNotesData.size());
    }

    public static String getAllNotes(){
        return JSON.serialize(collectorNotesData);
    }
    
    public class WrapperCollectorNotes{
    
        public String CCT_GUID{get;set;}
        public String CUSTOMER{get;set;}
        public String COLL_SEGMENT{get;set;}
        public String CCT_ID{get;set;}
        public String COLL_SPECIALIST{get;set;}
        public String COLL_SPECIALIST_NAME{get;set;}
        public String CONTACT_KEY{get;set;}
        public String CCT_NAME{get;set;}
        public String CCT_EMAIL{get;set;}
        public String CCT_PHONE{get;set;}
        public String CCT_FAX{get;set;}
        public String CCT_FAXC{get;set;}
        public String CCT_DIRECTION{get;set;}
        public String CCT_TYPE{get;set;}
        public String CCT_TYPE_TEXT{get;set;}
        public String CCT_RESULT{get;set;}
        public String CCT_RESULT_TXT{get;set;}
        public String CCT_TIME{get;set;}
        public String CCT_DURATION{get;set;}
        public String CREATED_BY{get;set;}
        public String CREATED_BY_NAME{get;set;}
        public String CREATED_AT{get;set;}
        public String CHANGED_BY{get;set;}
        public String CHANGED_BY_NAME{get;set;}
        public String CHANGED_AT{get;set;}
        public String CCT_ATTCH_COUNT{get;set;}
        public List<WrapperCollectorNotesItems> collNotesItems{get;set;}    
        
        public WrapperCollectorNotes(String CCT_GUID,String CUSTOMER,String COLL_SEGMENT,String CCT_ID,String COLL_SPECIALIST,String COLL_SPECIALIST_NAME,
                            String CONTACT_KEY,String CCT_NAME,String CCT_EMAIL,String CCT_PHONE,String CCT_FAX,String CCT_FAXC,String CCT_DIRECTION,
                            String CCT_TYPE,String CCT_TYPE_TEXT,String CCT_RESULT,String CCT_RESULT_TXT,String CCT_TIME,String CCT_DURATION,String CREATED_BY,
                            String CREATED_BY_NAME,String CREATED_AT,String CHANGED_BY,String CHANGED_BY_NAME,String CHANGED_AT,String CCT_ATTCH_COUNT,
                            List<WrapperCollectorNotesItems> collNotesItems,String recType){
        
            this.CCT_GUID = CCT_GUID;
            this.CUSTOMER = CUSTOMER;
            this.COLL_SEGMENT = COLL_SEGMENT;
            this.CCT_ID = CCT_ID;
            this.COLL_SPECIALIST = COLL_SPECIALIST;
            this.COLL_SPECIALIST_NAME = COLL_SPECIALIST_NAME;
            this.CONTACT_KEY = CONTACT_KEY;
            this.CCT_NAME = CCT_NAME.tolowercase();
            this.CCT_EMAIL = CCT_EMAIL.tolowercase();
            this.CCT_PHONE = CCT_PHONE;
            this.CCT_FAX = CCT_FAX;
            this.CCT_FAXC = CCT_FAXC;
            this.CCT_DIRECTION = CCT_DIRECTION;
            this.CCT_TYPE = CCT_TYPE;
            this.CCT_TYPE_TEXT = CCT_TYPE_TEXT; //CollectorNotesCntrl.getContactTypeText(CCT_DIRECTION,CCT_TYPE); 
            this.CCT_RESULT = CCT_RESULT;
            this.CCT_RESULT_TXT = CCT_RESULT_TXT; //CollectorNotesCntrl.getResultTypeText(CCT_RESULT);
            this.CCT_TIME = CCT_TIME;
            
            if(CCT_TIME != '' && CCT_TIME.length() == 14 && CCT_TIME != '00000000000000'){
                DateTime contactDateTime = DateTime.newInstance(Integer.valueOf(CCT_TIME.substring(0,4)),Integer.valueOf(CCT_TIME.substring(4,6)),Integer.valueOf(CCT_TIME.substring(6,8)),Integer.valueOf(CCT_TIME.substring(8,10)), Integer.valueOf(CCT_TIME.substring(10,12)),Integer.valueOf(CCT_TIME.substring(12,14)));   
                String userTimeZone = String.valueOf(UserInfo.getTimeZone());
                String tempDate = recType.containsIgnoreCase('UK')?contactDateTime.format('dd/MM/yyyy HH:mm:ss',userTimeZone):contactDateTime.format('MM/dd/yyyy HH:mm:ss',userTimeZone);
                String cdate = tempDate.split(' ')[0];
                cdate = cdate + ' ' + Integer.valueOf(CCT_TIME.substring(8,10)) + ':' + Integer.valueOf(CCT_TIME.substring(10,12)) + ':' + Integer.valueOf(CCT_TIME.substring(12,14));
                this.CCT_TIME  =string.valueOf(cdate); 
                this.CCT_TIME = this.CCT_TIME.replace('-','/');
                //enDate = enDate.replace('/','-');
                //this.CCT_TIME = String.valueOf(startDateTime); //Date.valueof(enDate);
            }
            
            this.CCT_DURATION = CCT_DURATION;
            this.CREATED_BY = CREATED_BY;
            this.CREATED_BY_NAME = CREATED_BY_NAME;
            this.CREATED_AT = CREATED_AT;
            this.CHANGED_BY = CHANGED_BY;
            this.CHANGED_BY_NAME = CHANGED_BY_NAME;
            this.CHANGED_AT = CHANGED_AT;
            this.CCT_ATTCH_COUNT = CCT_ATTCH_COUNT;
            this.collNotesItems = collNotesItems;
        }
    }
    
    public class WrapperCollectorNotesItems{
        
        public String CASE_GUID{get;set;}
        public String FORMAT_COL{get;set;}
        public String TEXT_LINE{get;set;}
        
        public WrapperCollectorNotesItems(String CASE_GUID,String FORMAT_COL,String TEXT_LINE){
            this.CASE_GUID = CASE_GUID;
            this.FORMAT_COL = FORMAT_COL;
            this.TEXT_LINE = TEXT_LINE;
        }
        
    }
    

}