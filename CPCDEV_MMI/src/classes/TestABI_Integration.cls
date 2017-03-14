/**
 * 
 */
@isTest
private class TestABI_Integration {
        
     static testMethod void testABIIntegration() {
        List<ABI__c> abiList = new List<ABI__c>();
        
        /* Test Case 1 - There are 2 projects and 7 bidders.
        project-1 contains 4 bidders. All are non-contractor and two has role bidder.
        project-2 conatins 3 bidders. two is contractor and General Contractor and other one are non contractor
        project -3 contains 2 bidders. one is contructor and other two are non contractor 
        */
        AssignmentRules.isTest = true;
        ABI__c abi = setABIData(11111111,'Bidder',null,null,'Test','ABI 1','8745897459',null,'Travelodge UK Limited','Head Office','Sleepy Hollow',
                    'Aylesbury Road','Thame','Oxfordshire', 'OX9 3AT','01844 358500',null,'www.travelodge.co.uk',
                    1111111,Date.parse('05/11/2010'),'SHOPS/HOTEL','Former Newbury Filling Station, Star Gar',
                    '49 London Road','Newbury','Berkshire','UK');
        abi.Ptpcode__c = 'RG14 1JN';
        abi.value__c = 4500000;
        abi.stage__c = 'Tender';
        abi.devtype__c = 'New Build';
        abi.Tenderclose__c = null;
        abi.contracttype__c = 'General contract';
        abi.Startdate__c = 'late June 2010';
        abi.Finish__c ='late June 2011';
        abi.Period__c = 12;
        abiList.add(abi);
    
        ABI__c abi1 = setABIData(22222222,'Bidder','Mr','Commercial Manager','Robert','Price',null,
                      'develop@tafisher.co.uk','TA Fisher (Holdings) Limited',null,'Windmill House, Victoria Road',
                      'Mortimer','Reading','Berkshire','RG7 3DF','0118 933 3500',null,'www.tafisher.co.uk',1111111,
                      Date.parse('05/11/2010'),'SHOPS/HOTEL','Former Newbury Filling Station, Star Gar','49 London Road','Newbury',
                      'Berkshire','Ireland');
        abi1.Ptpcode__c = 'RG14 1JN';
        abi1.Value__c= 4500000;
        abi1.Stage__c='Tender';
        abi1.Devtype__c ='New Build';
        abi1.Contracttype__c='General contract';
        abi1.Startdate__c ='late June 2010';
        abi1.Finish__c = 'late June 2011';
        abi1.Period__c =12;
        abiList.add(abi1);
            
        ABI__c abi2 = setABIData(33333333,'Architect','Mr','Director','Gary','Watson',null,'gary.watson@prc-group.com',
                     'PRC Architects Limited',null,'32 Victoria Road',null,'Surbiton','Surrey','KT6 4JT','020 8399 5188',
                     '020 8399 3863 (FPS)','www.prc-group.com',1111111,Date.parse('05/11/2010'),'SHOPS/HOTEL','Former Newbury Filling Station, Star Gar',
                     '49 London Road','Newbury','Berkshire',null);
        abi2.ptpCode__c ='RG14 1JN';
        abi2.value__c =4500000;
        abi2.stage__c ='Tender';
        abi2.devtype__c ='New Build';
        abi2.contracttype__c='General contract';
        abi2.startdate__c ='late June 2010';
        abi2.finish__c ='late June 2011';
        abi2.period__c = 12;
        abiList.add(abi2);
        
        ABI__c abi3 = setABIData(44444444,'Structural engineer',null,null,'Test ','ABI2',null,null,'Upton McGougan Limited','(Head Office)',
                      'IAC House','Moorside Road','Winchester','Hampshire','SO23 7RX','01962 834400','01962 834411',
                      'www.uptonmcgougan',1111111,Date.parse('05/11/2010'),'SHOPS/HOTEL','Former Newbury Filling Station, Star Gar',
                      '49 London Road','Newbury','Berkshire','UK');
        abi3.ptpCode__c = 'RG14 1JN';
        abi3.value__c =4500000;
        abi3.stage__c ='Tender';
        abi3.devtype__c ='New Build';
        abi3.contracttype__c ='General contract';
        abi3.startdate__c ='late June 2010';
        abi3.finish__c ='late June 2011';
        abi3.period__c = 12;
        abiList.add(abi3);
    
  
        ABI__c abi4 = setABIData(55555555,'Client','Dr','Client','Hemantha','Kumar',null,null,'Bharani Care' ,'UK Limited',
                    '28c Grangewood','Wexham','Slough','Berkshire','SL3 6LP','0844 4778682',null,null,2222222,Date.parse('05/11/2010'),'CARE HOME',
                    '32 Burlington Avenue and 95-97 The Cresc','Chalvey','Slough','Berkshire','UK');
                    
        abi4.ptpCode__c = 'SL1 2LD';
        abi4.value__c =2500000;
        abi4.stage__c ='Tender';
        abi4.devtype__c ='New Build'; 
        abi4.contracttype__c ='General contract';
        abi4.startdate__c ='October 2010';
        abi4.finish__c ='October 2011';
        abi4.period__c = 12;
        abiList.add(abi4);
      
        ABI__c abi5 = setABIData(66666666,'Contractor','Mr','Director','Brian','Poole',null,'brianpoole@adamspoole.com','Adams Poole Architects',
                    null,'Porters Lodge','HM Naval Base','Portsmouth','Hampshire','PO1 3LJ','0845 130 3316',null,null,2222222,Date.parse('05/11/2010'),'CARE HOME',
                    '32 Burlington Avenue and 95-97 The Cresc','Chalvey','Slough','Berkshire','UK');
        abi5.ptpCode__c = 'SL1 2LD';
        abi5.value__c =2500000;
        abi5.stage__c ='Tender';
        abi5.devtype__c ='New Build';
        abi5.contracttype__c ='General contract';
        abi5.startdate__c ='October 2010';
        abi5.finish__c ='October 2011';
        abi5.period__c = 12;
        abiList.add(abi5);
      
        //changed Quantity surveyor to contructor(28 July 2010) 
        ABI__c abi6 = setABIData(77777777,'General Contractor',null,null,'Test ','ABI 3',null,null,'Stuart Silvey Partnership',null,'The Old Court House',
                    'London Road','Ascot','Berkshire','SL5 7EN','01344 623214 (TPS)',null,null,2222222,Date.parse('05/11/2010'),'CARE HOME',
                    '32 Burlington Avenue and 95-97 The Cresc','Chalvey','Slough','Berkshire','UK');
                    
        abi6.ptpCode__c = 'SL1 2LD';
        abi6.value__c =2500000;
        abi6.stage__c ='Tender';
        abi6.devtype__c ='New Build';
        abi6.contracttype__c ='General contract';
        abi6.startdate__c ='October 2010';
        abi6.finish__c ='October 2011';
        abi6.period__c = 12;
    
        abiList.add(abi6);
        
        //add new abi records 
        
        ABI__c abi7 = setABIData(888888881,'Client',null,null,'Test','ABI -3',null,null,'Primark Stores Limited','Head Office',
                     'Primark House','41 West Street','Reading','Berkshire','RG1 1TZ','0118 960 6300',null,'www.primark.co.uk',
                     3333333,Date.parse('05/11/2010'),'SHOP - PRIMARK STORE','Thurrock Lakeside Shopping Centre',
                     'West Thurrock','Grays','Essex','UK');
        abi7.ptpCode__c = 'RM20 2ZJ';
        abi7.value__c =1800000;
        abi7.stage__c ='Tender';
        abi7.devtype__c ='Extn';
        abi7.startdate__c ='July 2010';
        abi7.finish__c ='January 2011';
        abi7.period__c = 6;
    
        abiList.add(abi7);
        
        ABI__c abi8 = setABIData(99999999,'Contractor','Miss',null,'Sarah','Davis',null,'sarah.davis@3darchitects.co.uk','3D Architects',null,
                      'Whitsundoles','Broughton Road','Milton Keynes','Buckinghamshire','MK17 8BU','01908 325230',null,
                      null,3333333,Date.parse('05/11/2010'),'SHOP - PRIMARK STORE','Thurrock Lakeside Shopping Centre',
                      'West Thurrock','Grays','Essex','UK');
        abi8.ptpCode__c = 'RM20 2ZJ';
        abi8.value__c =1800000;
        abi8.stage__c ='Tender';
        abi8.devtype__c ='Extn';
        abi8.startdate__c ='July 2010';
        abi8.finish__c ='January 2011';
        abi8.period__c = 6;
        
        abiList.add(abi8);
        
        ABI__c abi9 = setABIData(00000000,'Bidder','Mr','Techinical Director','Nigel','Adams','029 2081 5117',null,
                      'WSP Group',null,'Fairway House','Paramount Business Park, St Mellon','Cardiff','South Glamorgan',
                      'CF3 0LW','029 2036 6300','029 2036 6399','www.wspgroup.com',3333333,Date.parse('05/11/2010'),
                      'SHOP - PRIMARK STORE','Thurrock Lakeside Shopping Centre','West Thurrock','Grays','Essex','UK');
        abi9.ptpCode__c = 'RM20 2ZJ';
        abi9.value__c =1800000;
        abi9.stage__c ='Tender';
        abi9.devtype__c ='Extn';
        abi9.startdate__c ='July 2010';
        abi9.finish__c ='January 2011';
        abi9.period__c = 6;
        
        abiList.add(abi9);
    
        
        insert abiList;
        
        List<ABI_Project__c> abiProjectList = new List<ABI_Project__c>();
        Set<double> ptnoSet = new Set<Double>();
        Integer hotLeadCount = 0;
        Integer warmLeadCount =0;
        Integer bidderCount = 0;
        ptnoSet.add(1111111);
        ptnoSet.add(2222222);
        ptnoSet.add(3333333);
        for(ABI_Project__c abiProject : [select Id,Name,ptno__c ,(select id,Name,cyno__c from ABI_Bidders__r),(Select id,Name,rating,FirstName from Leads__r) from ABI_Project__c where ptno__c in : ptnoSet]){
            abiProjectList.add(abiProject);
            System.debug('-------ABi Project ----'+abiproject.Ptno__c);
            for(Lead l : abiProject.Leads__r){
                if(l.Rating!=null && l.Rating.equals(ABI_IntegrationUtil.HOT_RATING)){
                    System.debug('-------hot Lead for-----'+abiproject.Ptno__c+'--'+l.FirstName);
                    hotLeadCount += 1;
                }
                if(l.Rating!=null && l.Rating.equals(ABI_IntegrationUtil.WARM_RATING)){
                    warmLeadCount += 1;
                }
            }
            bidderCount = bidderCount + abiProject.ABI_Bidders__r.size();
        }
        
        //System.assertEquals(abiProjectList.size(),3);
        //System.assertEquals(hotLeadCount,3);  
        //System.assertEquals(warmLeadCount,2);
        //System.assertEquals(bidderCount,10);
    
        abiList.clear();
        
        /* Test Case 2 - There are 3 existing projects , 1 new project and 5 existing bidders and 5 new bidders.
            project-1 contains 4 bidders. 2 bidders are non-contractor, 1 contructor bidder (remove one non - contructor bidder)
            project-2 conatins 3 bidders. two is contractor and other one is non contractor.(remove one non -contructor bidder and add 1 new bidder).
            project -3 contains 1 bidder one existing non contrator bidder(remove one non-contructor or one contructor bidder)
            Project - 4 new project with 2 non - contractor bidders. */
        
        
        
        abi = setABIData(11111111,'Client',null,null,'Test','ABI 1',null,null,'Travelodge UK Limited','Head Office','Sleepy Hollow',
                    'Aylesbury Road','Thame','Oxfordshire', 'OX9 3AT','01844 358500',null,'www.travelodge.co.uk',
                    1111111,Date.parse('05/11/2010'),'SHOPS/HOTEL','Former Newbury Filling Station, Star Gar',
                    '49 London Road','Newbury','Berkshire','UK');
        abi.Ptpcode__c = 'RG14 1JN';
        abi.value__c = 4500000;
        abi.stage__c = 'Tender';
        abi.devtype__c = 'New Build';
        abi.Tenderclose__c = null;
        abi.contracttype__c = 'General contract';
        abi.Startdate__c = 'late June 2010';
        abi.Finish__c ='late June 2011';
        abi.Period__c = 12;
        abiList.add(abi);
    
        abi1 = setABIData(22222222,'Contractor','Mr','Commercial Manager','Robert','Price',null,
                      'develop@tafisher.co.uk','TA Fisher (Holdings) Limited',null,'Windmill House, Victoria Road',
                      'Mortimer','Reading','Berkshire','RG7 3DF','0118 933 3500',null,'www.tafisher.co.uk',1111111,
                      Date.parse('05/11/2010'),'SHOPS/HOTEL','Former Newbury Filling Station, Star Gar','49 London Road','Newbury',
                      'Berkshire','Ireland');
        abi1.Ptpcode__c = 'RG14 1JN';
        abi1.Value__c= 4500000;
        abi1.Stage__c='Tender';
        abi1.Devtype__c ='New Build';
        abi1.Contracttype__c='General contract';
        abi1.Startdate__c ='late June 2010';
        abi1.Finish__c = 'late June 2011';
        abi1.Period__c =12;
        abiList.add(abi1);
            
        abi2 = setABIData(33333333,'Architect','Mr','Director','Gary','Watson',null,'gary.watson@prc-group.com',
                     'PRC Architects Limited',null,'32 Victoria Road',null,'Surbiton','Surrey','KT6 4JT','020 8399 5188',
                     '020 8399 3863 (FPS)','www.prc-group.com',1111111,Date.parse('05/11/2010'),'SHOPS/HOTEL','Former Newbury Filling Station, Star Gar',
                     '49 London Road','Newbury','Berkshire','UK');
        abi2.ptpCode__c ='RG14 1JN';
        abi2.value__c =4500000;
        abi2.stage__c ='Tender';
        abi2.devtype__c ='New Build';
        abi2.contracttype__c='General contract';
        abi2.startdate__c ='late June 2010';
        abi2.finish__c ='late June 2011';
        abi2.period__c = 12;
        abiList.add(abi2);
        
        
        abi4 = setABIData(55555555,'Contractor','Dr','Client','Hemantha','Kumar',null,null,'Bharani Care' ,'UK Limited',
                    '28c Grangewood','Wexham','Slough','Berkshire','SL3 6LP','0844 4778682',null,null,2222222,Date.parse('05/11/2010'),'CARE HOME',
                    '32 Burlington Avenue and 95-97 The Cresc','Chalvey','Slough','Berkshire','UK');
                    
        abi4.ptpCode__c = 'SL1 2LD';
        abi4.value__c =2500000;
        abi4.stage__c ='Tender';
        abi4.devtype__c ='New Build'; 
        abi4.contracttype__c ='General contract';
        abi4.startdate__c ='October 2010';
        abi4.finish__c ='October 2011';
        abi4.period__c = 12;
        abiList.add(abi4);
      
        abi5 = setABIData(66666666,'Contractor','Mr','Director','Brian','Poole',null,'brianpoole@adamspoole.com','Adams Poole Architects',
                    null,'Porters Lodge','HM Naval Base','Portsmouth','Hampshire','PO1 3LJ','0845 130 3316',null,null,2222222,Date.parse('05/11/2010'),'CARE HOME',
                    '32 Burlington Avenue and 95-97 The Cresc','Chalvey','Slough','Berkshire','UK');
        abi5.ptpCode__c = 'SL1 2LD';
        abi5.value__c =2500000;
        abi5.stage__c ='Tender';
        abi5.devtype__c ='New Build';
        abi5.contracttype__c ='General contract';
        abi5.startdate__c ='October 2010';
        abi5.finish__c ='October 2011';
        abi5.period__c = 12;
        abiList.add(abi5);
      
        abi6 = setABIData(77777788,'Structural Engineering',null,null,'Test-p2 ','ABI -p2',null,null,'Stuart Silvey Partnership',null,'The Old Court House',
                    'London Road','Ascot','Berkshire','SL5 7EM','01344 623234 (TPS)',null,null,2222222,Date.parse('05/11/2010'),'CARE HOME',
                    '32 Burlington Avenue and 95-97 The Cresc','Chalvey','Slough','Berkshire','UK');
                    
        abi6.ptpCode__c = 'SL1 2LE';
        abi6.value__c =2500000;
        abi6.stage__c ='Tender';
        abi6.devtype__c ='New Build';
        abi6.contracttype__c ='General contract';
        abi6.startdate__c ='October 2010';
        abi6.finish__c ='October 2011';
        abi6.period__c = 12;
    
        abiList.add(abi6);
        
        abi7 = setABIData(888888881,'Bidder',null,null,'Test','ABI -3',null,null,'Primark Stores Limited','Head Office',
                     'Primark House','41 West Street','Reading','Berkshire','RG1 1TZ','0118 960 6300',null,'www.primark.co.uk',
                     3333333,Date.parse('05/11/2010'),'SHOP - PRIMARK STORE','Thurrock Lakeside Shopping Centre',
                     'West Thurrock','Grays','Essex','UK');
        abi7.ptpCode__c = 'RM20 2ZJ';
        abi7.value__c =1800000;
        abi7.stage__c ='Tender';
        abi7.devtype__c ='Extn';
        abi7.startdate__c ='July 2010';
        abi7.finish__c ='January 2011';
        abi7.period__c = 6;
    
        abiList.add(abi7);
        
        abi8 = setABIData(121212121,'Client',null,null,'Test','ABI -3',null,null,'Primark Stores','Head Office',
                     'Primark Road','41 West','Reading','Berkshire','RG1 1TY','0118 960 6301',null,'www.primark.co.uk',
                     4444444,Date.parse('05/11/2010'),'SHOP - PRIMARK STORE','Thurrock Lakeside Shopping Centre',
                     'West Thurrock','Grays','Essex','UK');
        abi8.ptpCode__c = 'RM20 2YJ';
        abi8.value__c =1800000;
        abi8.stage__c ='Tender';
        abi8.devtype__c ='Extn';
        abi8.startdate__c ='July 2010';
        abi8.finish__c ='January 2011';
        abi8.period__c = 6;
    
        abiList.add(abi8);
        
        abi9 = setABIData(131313131,'Structural Engineering',null,null,'Test - p4','ABI -p4',null,null,'Primark Stores -p4','Head Office',
                     'Primark Road','41 West p4','Reading','Berkshire','RG1 1YT','0118 960 6302',null,'www.primark.co.uk',
                     4444444,Date.parse('05/11/2010'),'SHOP - PRIMARK STORE','Thurrock Lakeside Shopping Centre',
                     'West Thurrock','Grays','Essex','UK');
        abi9.ptpCode__c = 'RM20 2ZK';
        abi9.value__c =1800000;
        abi9.stage__c ='Tender';
        abi9.devtype__c ='Extn';
        abi9.startdate__c ='July 2010';
        abi9.finish__c ='January 2011';
        abi9.period__c = 6;
    
        abiList.add(abi9);
        
        insert abiList;    
        ptnoSet.add(4444444);
        hotLeadCount = 0;
        warmLeadCount =0;
        bidderCount = 0;
        
        abiProjectList.clear();
        for(ABI_Project__c abiProject : [select Id,Name,ptno__c ,(select id,Name,cyno__c from ABI_Bidders__r),(Select id,Name,rating,ABI_Bidder__c from Leads__r) from ABI_Project__c where ptno__c in : ptnoSet]){
            abiProjectList.add(abiProject);
            System.DEbug('ID for ------'+abiProject.Id+'--'+abiProject.ptno__c+'--'+abiProject.ABI_Bidders__r+'--'+abiProject.Leads__r);
            for(Lead l : abiProject.Leads__r){
                if(l.Rating!=null && l.Rating.equals(ABI_IntegrationUtil.HOT_RATING)){
                    System.Debug('---Lead Id from'+ abiProject.ptno__c+'----'+l.id+'---with bidder ---'+l.ABI_Bidder__c);
                    hotLeadCount += 1;
                }
                if(l.Rating!=null && l.Rating.equals(ABI_IntegrationUtil.WARM_RATING)){
                    warmLeadCount += 1;
                }
            }
            bidderCount = bidderCount + abiProject.ABI_Bidders__r.size();
        }
        
        //System.assertEquals(abiProjectList.size(),4);  
        //System.assertEquals(hotLeadCount,3); 
        //System.assertEquals(warmLeadCount,1);
        //System.assertEquals(bidderCount,9); 
        
        abiList.clear();
        
        /* Test case - 3 There are 2 projects and 5 bidders (2 existing projects and 6 existing bidders)
            Project - 1  existing project and have 2 bidders (remove one contructor bidder).
            Project - 2 existing project and have 3 bidders (remove one contractor bidder and add 1 new contructor bidder).
                
        */
        
            abi = setABIData(11111111,'Client',null,null,'Test','ABI 1',null,null,'Travelodge UK Limited','Head Office','Sleepy Hollow',
                    'Aylesbury Road','Thame','Oxfordshire', 'OX9 3AT','01844 358500',null,'www.travelodge.co.uk',
                    1111111,Date.parse('05/11/2010'),'SHOPS/HOTEL','Former Newbury Filling Station, Star Gar',
                    '49 London Road','Newbury','Berkshire','UK');
        abi.Ptpcode__c = 'RG14 1JN';
        abi.value__c = 4500000;
        abi.stage__c = 'Tender';
        abi.devtype__c = 'New Build';
        abi.Tenderclose__c = null;
        abi.contracttype__c = 'General contract';
        abi.Startdate__c = 'late June 2010';
        abi.Finish__c ='late June 2011';
        abi.Period__c = 12;
        abiList.add(abi);
    
        /*abi1 = setABIData(22222222,'Contractor','Mr','Commercial Manager','Robert','Price',null,
                      'develop@tafisher.co.uk','TA Fisher (Holdings) Limited',null,'Windmill House, Victoria Road',
                      'Mortimer','Reading','Berkshire','RG7 3DF','0118 933 3500',null,'www.tafisher.co.uk',1111111,
                      Date.parse('05/11/2010'),'SHOPS/HOTEL','Former Newbury Filling Station, Star Gar','49 London Road','Newbury',
                      'Berkshire');
        abi1.Ptpcode__c = 'RG14 1JN';
        abi1.Value__c= 4500000;
        abi1.Stage__c='Tender';
        abi1.Devtype__c ='New Build';
        abi1.Contracttype__c='General contract';
        abi1.Startdate__c ='late June 2010';
        abi1.Finish__c = 'late June 2011';
        abi1.Period__c =12;
        abiList.add(abi1);*/
            
        abi2 = setABIData(33333333,'Bidder','Mr','Director','Gary','Watson',null,'gary.watson@prc-group.com',
                     'PRC Architects Limited',null,'32 Victoria Road',null,'Surbiton','Surrey','KT6 4JT','020 8399 5188',
                     '020 8399 3863 (FPS)','www.prc-group.com',1111111,Date.parse('05/11/2010'),'SHOPS/HOTEL','Former Newbury Filling Station, Star Gar',
                     '49 London Road','Newbury','Berkshire','UK');
        abi2.ptpCode__c ='RG14 1JN';
        abi2.value__c =4500000;
        abi2.stage__c ='Tender';
        abi2.devtype__c ='New Build';
        abi2.contracttype__c='General contract';
        abi2.startdate__c ='late June 2010';
        abi2.finish__c ='late June 2011';
        abi2.period__c = 12;
        abiList.add(abi2);
        
        
        abi4 = setABIData(55555555,'Contractor','Dr','Client','Hemantha','Kumar',null,null,'Bharani Care' ,'UK Limited',
                    '28c Grangewood','Wexham','Slough','Berkshire','SL3 6LP','0844 4778682',null,null,2222222,Date.parse('05/11/2010'),'CARE HOME',
                    '32 Burlington Avenue and 95-97 The Cresc','Chalvey','Slough','Berkshire','UK');
                    
        abi4.ptpCode__c = 'SL1 2LD';
        abi4.value__c =2500000;
        abi4.stage__c ='Tender';
        abi4.devtype__c ='New Build'; 
        abi4.contracttype__c ='General contract';
        abi4.startdate__c ='October 2010';
        abi4.finish__c ='October 2011';
        abi4.period__c = 12;
        abiList.add(abi4);
      
        abi5 = setABIData(66666622,'General Contractor','Mr','Director','Brian-p2','Poole-p2',null,'brianpoole@adamspoole.com','Adams Poole Architects',
                    null,'Porters Lodge','HM Naval Base','Portsmouth','Hampshire','PO1 3LT','0845 130 3316',null,null,2222222,Date.parse('05/11/2010'),'CARE HOME',
                    '32 Burlington Avenue and 95-97 The Cresc','Chalvey','Slough','Berkshire','UK');
        abi5.ptpCode__c = 'SL1 2LE';
        abi5.value__c =2500000;
        abi5.stage__c ='Tender';
        abi5.devtype__c ='New Build';
        abi5.contracttype__c ='General contract';
        abi5.startdate__c ='October 2010';
        abi5.finish__c ='October 2011';
        abi5.period__c = 12;
        abiList.add(abi5);
      
        abi6 = setABIData(77777788,'Structural Engineering',null,null,'Test-p2 ','ABI -p2',null,null,'Stuart Silvey Partnership',null,'The Old Court House',
                    'London Road','Ascot','Berkshire','SL5 7EM','01344 623234 (TPS)',null,null,2222222,Date.parse('05/11/2010'),'CARE HOME',
                    '32 Burlington Avenue and 95-97 The Cresc','Chalvey','Slough','Berkshire','UK');
                    
        abi6.ptpCode__c = 'SL1 2LE';
        abi6.value__c =2500000;
        abi6.stage__c ='Tender';
        abi6.devtype__c ='New Build';
        abi6.contracttype__c ='General contract';
        abi6.startdate__c ='October 2010';
        abi6.finish__c ='October 2011';
        abi6.period__c = 12;
    
        abiList.add(abi6);
    
        
        //Test.startTest();
        insert abiList;  
        
        hotLeadCount = 0;
        warmLeadCount =0;
        bidderCount = 0;
        
        abiProjectList.clear();
        
        for(ABI_Project__c abiProject : [select Id,Name,ptno__c ,(select id,Name,cyno__c from ABI_Bidders__r),(Select id,Name,rating,ABI_Bidder__c from Leads__r) from ABI_Project__c where ptno__c in : ptnoSet]){
            abiProjectList.add(abiProject);
            System.DEbug('ID for ------'+abiProject.Id+'--'+abiProject.ptno__c);
            for(Lead l : abiProject.Leads__r){
                if(l.Rating!=null && l.Rating.equals(ABI_IntegrationUtil.HOT_RATING)){
                    System.Debug('---Lead Id from'+ abiProject.ptno__c+'----'+l.id+'---with bidder ---'+l.ABI_Bidder__c);
                    hotLeadCount += 1;
                }
                if(l.Rating!=null && l.Rating.equals(ABI_IntegrationUtil.WARM_RATING)){
                    warmLeadCount += 1;
                }
            }
            bidderCount = bidderCount + abiProject.ABI_Bidders__r.size();
        }
        
        //System.assertEquals(abiProjectList.size(),4);
        //System.assertEquals(hotLeadCount,2);
        //System.assertEquals(warmLeadCount,2);
        //System.assertEquals(bidderCount,8);
        //Test.stopTest();
         
   }
   
   
    static testMethod void testABICynoMatchingAccount() {
        List<ABI__c> abiList = new List<ABI__c>();
        User testUser = createUser();
        List<Account> accounts = createAccounts(3,testUser.id);
        
        /* Test Case 1 - There are 2 projects and 7 bidders.
        project-1 contains 4 bidders. All are non-contractor and two has role bidder.
        project-2 conatins 3 bidders. two is contractor and General Contractor and other one are non contractor
        project -3 contains 2 bidders. one is contructor and other two are non contractor 
        */
        AssignmentRules.isTest = true;
        ABI__c abi = setABIData(11111111,'Bidder',null,null,'Test','ABI 1','8745897459',null,'Travelodge UK Limited','Head Office','Sleepy Hollow',
                    'Aylesbury Road','Thame','Oxfordshire', 'OX9 3AT','01844 358500',null,'www.travelodge.co.uk',
                    1111111,Date.parse('05/11/2010'),'SHOPS/HOTEL','Former Newbury Filling Station, Star Gar',
                    '49 London Road','Newbury','Berkshire','UK');
        abi.Ptpcode__c = 'RG14 1JN';
        abi.value__c = 4500000;
        abi.stage__c = 'Tender';
        abi.devtype__c = 'New Build';
        abi.Tenderclose__c = null;
        abi.contracttype__c = 'General contract';
        abi.Startdate__c = 'late June 2010';
        abi.Finish__c ='late June 2011';
        abi.Period__c = 12;
        abiList.add(abi);
    
        ABI__c abi1 = setABIData(22222222,'Bidder','Mr','Commercial Manager','Robert','Price',null,
                      'develop@tafisher.co.uk','TA Fisher (Holdings) Limited',null,'Windmill House, Victoria Road',
                      'Mortimer','Reading','Berkshire','RG7 3DF','0118 933 3500',null,'www.tafisher.co.uk',1111111,
                      Date.parse('05/11/2010'),'SHOPS/HOTEL','Former Newbury Filling Station, Star Gar','49 London Road','Newbury',
                      'Berkshire','Ireland');
        abi1.Ptpcode__c = 'RG14 1JN';
        abi1.Value__c= 4500000;
        abi1.Stage__c='Tender';
        abi1.Devtype__c ='New Build';
        abi1.Contracttype__c='General contract';
        abi1.Startdate__c ='late June 2010';
        abi1.Finish__c = 'late June 2011';
        abi1.Period__c =12;
        abiList.add(abi1);
            
        ABI__c abi2 = setABIData(33333333,'Architect','Mr','Director','Gary','Watson',null,'gary.watson@prc-group.com',
                     'PRC Architects Limited',null,'32 Victoria Road',null,'Surbiton','Surrey','KT6 4JT','020 8399 5188',
                     '020 8399 3863 (FPS)','www.prc-group.com',1111111,Date.parse('05/11/2010'),'SHOPS/HOTEL','Former Newbury Filling Station, Star Gar',
                     '49 London Road','Newbury','Berkshire',null);
        abi2.ptpCode__c ='RG14 1JN';
        abi2.value__c =4500000;
        abi2.stage__c ='Tender';
        abi2.devtype__c ='New Build';
        abi2.contracttype__c='General contract';
        abi2.startdate__c ='late June 2010';
        abi2.finish__c ='late June 2011';
        abi2.period__c = 12;
        abiList.add(abi2);
        
        ABI__c abi3 = setABIData(44444444,'Structural engineer',null,null,'Test ','ABI2',null,null,'Upton McGougan Limited','(Head Office)',
                      'IAC House','Moorside Road','Winchester','Hampshire','SO23 7RX','01962 834400','01962 834411',
                      'www.uptonmcgougan',1111111,Date.parse('05/11/2010'),'SHOPS/HOTEL','Former Newbury Filling Station, Star Gar',
                      '49 London Road','Newbury','Berkshire','UK');
        abi3.ptpCode__c = 'RG14 1JN';
        abi3.value__c =4500000;
        abi3.stage__c ='Tender';
        abi3.devtype__c ='New Build';
        abi3.contracttype__c ='General contract';
        abi3.startdate__c ='late June 2010';
        abi3.finish__c ='late June 2011';
        abi3.period__c = 12;
        abiList.add(abi3);
    
  
        ABI__c abi4 = setABIData(55555555,'Client','Dr','Client','Hemantha','Kumar',null,null,'Bharani Care' ,'UK Limited',
                    '28c Grangewood','Wexham','Slough','Berkshire','SL3 6LP','0844 4778682',null,null,2222222,Date.parse('05/11/2010'),'CARE HOME',
                    '32 Burlington Avenue and 95-97 The Cresc','Chalvey','Slough','Berkshire','UK');
                    
        abi4.ptpCode__c = 'SL1 2LD';
        abi4.value__c =2500000;
        abi4.stage__c ='Tender';
        abi4.devtype__c ='New Build'; 
        abi4.contracttype__c ='General contract';
        abi4.startdate__c ='October 2010';
        abi4.finish__c ='October 2011';
        abi4.period__c = 12;
        abiList.add(abi4);
      
        ABI__c abi5 = setABIData(66666666,'Contractor','Mr','Director','Brian','Poole',null,'brianpoole@adamspoole.com','Adams Poole Architects',
                    null,'Porters Lodge','HM Naval Base','Portsmouth','Hampshire','PO1 3LJ','0845 130 3316',null,null,2222222,Date.parse('05/11/2010'),'CARE HOME',
                    '32 Burlington Avenue and 95-97 The Cresc','Chalvey','Slough','Berkshire','UK');
        abi5.ptpCode__c = 'SL1 2LD';
        abi5.value__c =2500000;
        abi5.stage__c ='Tender';
        abi5.devtype__c ='New Build';
        abi5.contracttype__c ='General contract';
        abi5.startdate__c ='October 2010';
        abi5.finish__c ='October 2011';
        abi5.period__c = 12;
        abiList.add(abi5);
      
        //changed Quantity surveyor to contructor(28 July 2010) 
        ABI__c abi6 = setABIData(77777777,'General Contractor',null,null,'Test ','ABI 3',null,null,'Stuart Silvey Partnership',null,'The Old Court House',
                    'London Road','Ascot','Berkshire','SL5 7EN','01344 623214 (TPS)',null,null,2222222,Date.parse('05/11/2010'),'CARE HOME',
                    '32 Burlington Avenue and 95-97 The Cresc','Chalvey','Slough','Berkshire','UK');
                    
        abi6.ptpCode__c = 'SL1 2LD';
        abi6.value__c =2500000;
        abi6.stage__c ='Tender';
        abi6.devtype__c ='New Build';
        abi6.contracttype__c ='General contract';
        abi6.startdate__c ='October 2010';
        abi6.finish__c ='October 2011';
        abi6.period__c = 12;
    
        abiList.add(abi6);
        
        //add new abi records 
        
        ABI__c abi7 = setABIData(888888881,'Client',null,null,'Test','ABI -3',null,null,'Primark Stores Limited','Head Office',
                     'Primark House','41 West Street','Reading','Berkshire','RG1 1TZ','0118 960 6300',null,'www.primark.co.uk',
                     3333333,Date.parse('05/11/2010'),'SHOP - PRIMARK STORE','Thurrock Lakeside Shopping Centre',
                     'West Thurrock','Grays','Essex','UK');
        abi7.ptpCode__c = 'RM20 2ZJ';
        abi7.value__c =1800000;
        abi7.stage__c ='Tender';
        abi7.devtype__c ='Extn';
        abi7.startdate__c ='July 2010';
        abi7.finish__c ='January 2011';
        abi7.period__c = 6;
    
        abiList.add(abi7);
        
        ABI__c abi8 = setABIData(99999999,'Contractor','Miss',null,'Sarah','Davis',null,'sarah.davis@3darchitects.co.uk','3D Architects',null,
                      'Whitsundoles','Broughton Road','Milton Keynes','Buckinghamshire','MK17 8BU','01908 325230',null,
                      null,3333333,Date.parse('05/11/2010'),'SHOP - PRIMARK STORE','Thurrock Lakeside Shopping Centre',
                      'West Thurrock','Grays','Essex','UK');
        abi8.ptpCode__c = 'RM20 2ZJ';
        abi8.value__c =1800000;
        abi8.stage__c ='Tender';
        abi8.devtype__c ='Extn';
        abi8.startdate__c ='July 2010';
        abi8.finish__c ='January 2011';
        abi8.period__c = 6;
        
        abiList.add(abi8);
        
        insert abiList;
        for(Lead lead : [select Id, Name, ownerId,ABI_Bidder__r.cyno__c from Lead where ABI_Bidder__r.cyno__c in (11111111,22222222,33333333,44444444,55555555,66666666,77777777,888888881,99999999)]){
            if(lead.ABI_Bidder__r.cyno__c == 11111111 ||lead.ABI_Bidder__r.cyno__c == 22222222){
                //System.assertEquals(lead.ownerId,UserInfo.getUserId());
            }else if(lead.ABI_Bidder__r.cyno__c == 66666666||lead.ABI_Bidder__r.cyno__c == 77777777){
                //System.assertEquals(lead.ownerId,testUser.Id);
            }
        }
         
   }
    static ABI__c setABIData(Double cyno,String role,String design, String title,String fname,String lname,String phone,String emailId,String cyname,String cyname2,String cyaddr1, 
        String cyaddr2,String cyaddr3,String cyaddr4,String cycode,String cyphone,String cyfax,String cyurl,Double ptno,Date reportdate
        ,String pttitle,String ptsite1,String ptsite2,String ptsite3,String ptsite4,String location){
        ABI__c abi = new ABI__c();
        abi.Cyno__c = cyno;
        abi.design__c = design;
        abi.title__c = title;
        abi.Role__c = role;
        abi.Fname__c = fname;
        abi.Lname__c =  lname;
        abi.pnphone__c = phone;
        abi.email__c =  emailId;
        abi.cyname__c = cyname;
        abi.cyname2__c = cyname2;
        abi.cyaddr1__c = cyaddr1;
        abi.cyaddr2__c = cyaddr2;
        abi.cyaddr3__c = cyaddr3;
        abi.cyaddr4__c = cyaddr4;
        abi.cypcode__c = cycode;
        abi.cyphone__c = cyphone;
        abi.cyfax__c = cyfax;
        abi.cyurl__c = cyurl;
        abi.ptno__c = ptno;
        abi.reportdate__c = reportdate;
        abi.pttitle__c = pttitle;
        abi.ptsite1__c = ptsite1;
        abi.ptsite2__c = ptsite2;
        abi.ptsite3__c = ptsite3;
        abi.ptsite4__c= ptsite4;
        abi.Location__c = location;
        return abi;
    }
    
    public static List<Account> createAccounts(Integer size, Id ownerId){
     List<Account> accounts = new List<Account>();
     for(Integer i = 0;i < size ;i++){  
        Account acc = new Account() ;
        acc.Name = 'Test Acccount - '+i;
        acc.shippingPostalCode =  '1233'+i ;
        acc.shippingcountry = 'USA' ;
        acc.phone = '12356'+i;
        accounts.add(acc);
     }   
     
     if(accounts.size() > 0){
        accounts.get(0).ABI_Company_ID__c = '11,111,111;22,222,222;33,333,333;44,444,444;45,454;42,423,424;';
     }
      if(accounts.size() > 1){
        accounts.get(1).ABI_Company_ID__c = '55,555,555;66,666,666;77,777,777;4,353,455;46,456;';
        accounts.get(1).ownerId = ownerId;
     }
      insert accounts ;
      return accounts;
   }
  
  public static User createUser(){
    User testUser = new User();
    testUser.firstName = 'test_26072010';
    testUser.LastName = 'test_26072010';
    testUser.Alias = '12';
    testUser.Email = 'test'+Date.Today().day()+Date.Today().month()+Date.Today().Year()+'@user.com';
    testUser.UserName='test'+Date.Today().day()+Date.Today().month()+Date.Today().Year()+'@user.com';
    testUser.CommunityNickname = testUser.firstname+'_'+testUser.lastName;
    testUser.EmailEncodingKey ='ISO-8859-1';
    testUser.LanguageLocaleKey = 'en_US';
     //  Modified by Yeturu
    //testUser.TimeZoneSidKey ='America/Indianapolis';
    testUser.TimeZoneSidKey ='America/Los_Angeles';
    testUser.LocaleSidKey = 'en_US';
    testUser.Country = 'TestIndia';
    for(Profile prfile : [select Id from Profile where name ='System Administrator' limit 1]){
        testUser.ProfileId = prfile.id;
        insert testUser;
    }
    
    return testUser;
  }   
}