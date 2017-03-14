@isTest
global class WebServiceMockImplCollNotes implements WebServiceMock {
   global void doInvoke(
           Object stub,
           Object request,
           Map<string, object> response,
           String endpoint,
           String soapAction,
           String requestName,
           String responseNS,
           String responseName,
           String responseType) {
       
       sapComDocumentCustomercontacts.ZSD_GET_COLLECTION_NOTES_Response_element colNotesFullResEle = new sapComDocumentCustomercontacts.ZSD_GET_COLLECTION_NOTES_Response_element();
       //sapComDocumentCustomercontacts.IT_CCT_GUID_element colNotesResEle = new sapComDocumentCustomercontacts.IT_CCT_GUID_element();
       
       sapComDocumentCustomercontacts.BDM_CCT fs = new sapComDocumentCustomercontacts.BDM_CCT();
        fs.CCT_GUID = 'CCT_GUID';
        fs.CUSTOMER = '0000800015';
        fs.COLL_SEGMENT = '1000';
        fs.CCT_ID = 'CCT_ID';
        fs.COLL_SPECIALIST = 'COLL_SPECIALIST';
        fs.COLL_SPECIALIST_NAME = 'COLL_SPECIALIST_NAME';
        fs.CONTACT_KEY = 'CONTACT_KEY';
        fs.CCT_NAME = 'CCT_NAME';
        fs.CCT_EMAIL = 'CCT_EMAIL';
        fs.CCT_PHONE = 'CCT_PHONE';
        fs.CCT_FAX = 'CCT_FAX';
        fs.CCT_FAXC = 'CCT_FAXC';
        fs.CCT_DIRECTION = 'CCT_DIRECTION';
        fs.CCT_TYPE = 'CCT_TYPE';
        fs.CCT_TYPE_TEXT = 'CCT_TYPE_TEXT'; //CollectorNotesCntrl.getContactTypeText(CCT_DIRECTION,CCT_TYPE); 
        fs.CCT_RESULT = 'CCT_RESULT';
        fs.CCT_RESULT_TXT = 'CCT_RESULT_TXT'; //CollectorNotesCntrl.getResultTypeText(CCT_RESULT);
        fs.CCT_TIME = '20150101101010';
        fs.CCT_DURATION = '12';
        fs.CREATED_BY = 'CREATED_BY';
        fs.CREATED_BY_NAME = 'CREATED_BY_NAME';
        fs.CREATED_AT = '20150101101010';
        fs.CHANGED_BY = 'CHANGED_BY';
        fs.CHANGED_BY_NAME = 'CHANGED_BY_NAME';
        fs.CHANGED_AT = '20150101101010';
        fs.CCT_ATTCH_COUNT = 'CCT_ATTCH_COUNT';
        fs.collNotesItems = null; //collNotesItems;
            
       sapComDocumentCustomercontacts.BDM_CCT fs1 = new sapComDocumentCustomercontacts.BDM_CCT();
        fs1.CCT_GUID = 'CCT_GUID1';
        fs1.CUSTOMER = '0000800015';
        fs1.COLL_SEGMENT = '1000';
        fs1.CCT_ID = 'CCT_ID';
        fs1.COLL_SPECIALIST = 'COLL_SPECIALIST';
        fs1.COLL_SPECIALIST_NAME = 'COLL_SPECIALIST_NAME';
        fs1.CONTACT_KEY = 'CONTACT_KEY';
        fs1.CCT_NAME = 'CCT_NAME';
        fs1.CCT_EMAIL = 'CCT_EMAIL';
        fs1.CCT_PHONE = 'CCT_PHONE';
        fs1.CCT_FAX = 'CCT_FAX';
        fs1.CCT_FAXC = 'CCT_FAXC';
        fs1.CCT_DIRECTION = 'CCT_DIRECTION';
        fs1.CCT_TYPE = 'CCT_TYPE';
        fs1.CCT_TYPE_TEXT = 'CCT_TYPE_TEXT'; //CollectorNotesCntrl.getContactTypeText(CCT_DIRECTION,CCT_TYPE); 
        fs1.CCT_RESULT = 'CCT_RESULT';
        fs1.CCT_RESULT_TXT = 'CCT_RESULT_TXT'; //CollectorNotesCntrl.getResultTypeText(CCT_RESULT);
        fs1.CCT_TIME = '20150101101010';
        fs1.CCT_DURATION = '12';
        fs1.CREATED_BY = 'CREATED_BY';
        fs1.CREATED_BY_NAME = 'CREATED_BY_NAME';
        fs1.CREATED_AT = '20150101101010';
        fs1.CHANGED_BY = 'CHANGED_BY';
        fs1.CHANGED_BY_NAME = 'CHANGED_BY_NAME';
        fs1.CHANGED_AT = '20150101101010';
        fs1.CCT_ATTCH_COUNT = 'CCT_ATTCH_COUNT';
        fs1.collNotesItems = null; //collNotesItems;
              
       List<sapComDocumentCustomercontacts.BDM_CCT> tempCollectorNotesDataList = new List<sapComDocumentCustomercontacts.BDM_CCT>();
       tempCollectorNotesDataList.add(fs);
       tempCollectorNotesDataList.add(fs1);       
                    
       sapComDocumentCustomercontacts.ET_CCT_ATTR_element  fse = new sapComDocumentCustomercontacts.ET_CCT_ATTR_element();
       fse.item = tempCollectorNotesDataList;
       
       sapComDocumentCustomercontacts.BAPIRET2 rei = new sapComDocumentCustomercontacts.BAPIRET2();
       rei.TYPE_x = '' ;
       rei.ID = '' ;
       rei.NUMBER_x = '' ;
       rei.MESSAGE = '' ;
       rei.LOG_NO = '000' ;
       rei.LOG_MSG_NO = '000' ;
       rei.MESSAGE_V1 = '' ;
       rei.MESSAGE_V2 = '' ;
       rei.MESSAGE_V3 = '' ;
       rei.MESSAGE_V4 = '' ;
       rei.PARAMETER  = '';
       rei.ROW = 0;
       rei.FIELD = '';
       rei.SYSTEM_x = '';
       
       sapComDocumentCustomercontacts.BAPI_DISPUTE_SPLIT_NOTES noteEle = new sapComDocumentCustomercontacts.BAPI_DISPUTE_SPLIT_NOTES();
       noteEle.CASE_GUID = 'CCT_GUID';
       noteEle.FORMAT_COL = 'FORMAT_COL';
       noteEle.TEXT_LINE = 'TEXT_LINE'; 
       
       sapComDocumentCustomercontacts.BAPI_DISPUTE_SPLIT_NOTES noteEle1 = new sapComDocumentCustomercontacts.BAPI_DISPUTE_SPLIT_NOTES();
       noteEle1.CASE_GUID = 'CCT_GUID1';
       noteEle1.FORMAT_COL = 'FORMAT_COL';
       noteEle1.TEXT_LINE = 'TEXT_LINE'; 
       
       List<sapComDocumentCustomercontacts.BAPI_DISPUTE_SPLIT_NOTES> noteEleList = new List<sapComDocumentCustomercontacts.BAPI_DISPUTE_SPLIT_NOTES>();
       noteEleList.add(noteEle);
       noteEleList.add(noteEle1); 
       
       sapComDocumentCustomercontacts.ET_NOTES_element etNEle = new sapComDocumentCustomercontacts.ET_NOTES_element();
       etNEle.item = noteEleList;
       
       sapComDocumentCustomercontacts.BDM_CCT_REL relEle = new sapComDocumentCustomercontacts.BDM_CCT_REL();
       relEle.CCT_GUID = 'CCT_GUID';
       relEle.CCT_OBJ_GUID = 'CCT_OBJ_GUID';
       relEle.CCT_OBJ_TYPE = 'CCT_OBJ_TYPE';
       
       List<sapComDocumentCustomercontacts.BDM_CCT_REL> relEleList = new List<sapComDocumentCustomercontacts.BDM_CCT_REL>();
       relEleList.add(relEle);
       
       sapComDocumentCustomercontacts.ET_RELATIONS_element etrelEle = new sapComDocumentCustomercontacts.ET_RELATIONS_element();
       etrelEle.item = relEleList;
       
       colNotesFullResEle.ES_RETURN = rei;
       colNotesFullResEle.ET_CCT_ATTR = fse;
       colNotesFullResEle.ET_NOTES = etNEle;
       colNotesFullResEle.ET_RELATIONS = etrelEle;
       
       response.put('response_x', colNotesFullResEle); 
   }
}