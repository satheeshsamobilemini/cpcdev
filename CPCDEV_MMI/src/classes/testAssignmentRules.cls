/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
 @isTest
private class testAssignmentRules {
  
  static testMethod void UnitTest2(){
   User u = MMIFullquoteTestDataProvider.getUser();
    system.runAs(u){
     List<Lead> ldList = new List<Lead>();
     Set<Id> accSetId = new set<Id>();
     
     User[] salesRep = [select id,Branch__c,Territory__c,Email,Available_For_Leads__c,UserRole.Id from User where isActive=true and UserRole.Id != null and UserRole.Name like 'Sales Rep%' LIMIT 2];
     salesRep[0].Branch__c = '101';
     salesRep[0].Available_For_Leads__c=true;
     salesRep[0].Territory__c='101-04';
     update salesRep[0];
     
     salesRep[1].Branch__c = '101';
     salesRep[1].Available_For_Leads__c=true;
     salesRep[1].Territory__c='101-03';
     update salesRep[1];
     
     User InboundUser = [select id,Branch__c,Territory__c,Email,Available_For_Leads__c,isHomeOwnerRep__c,Selling_Region__c,UserRole.Id from User where isActive=true and UserRole.Id != null and 
                         UserRole.Name like 'Inbound Sales%' LIMIT 1]; 
     InboundUser.Branch__c = '102';
     InboundUser.Territory__c='102-04';
     InboundUser.Available_For_Leads__c = true;
     InboundUser.isHomeOwnerRep__c = true;
     InboundUser.Selling_Region__c = '2';
     update InboundUser;
     
     User BMuser = [select Id,Branch__c,Email,UserRole.Id from User where isActive = true and UserRole.Id != null and UserRole.Name like 'Branch Manager%' LIMIT 1];
     BMuser.Branch__c = '101';
     update BMuser;
     
     User ISMuser = [select Id,Selling_Region__c,Email,UserRole.Id from User where isActive = true and UserRole.Id != null and UserRole.Name like 'Inside Sales/Outside Sales%' LIMIT 1];
     ISMuser.Selling_Region__c='1';
     update ISMuser;
     
     //User InboundSalesuser = [select Id,Selling_Region__c,Email,UserRole.Id from User where isActive = true and UserRole.Id != null and UserRole.Name like 'Inbound Sales Manager' LIMIT 1];
     //InboundSalesuser.Selling_Region__c='1';
     
     Branch_LookUp__c bl1 = new Branch_LookUp__c(Sales_Manager_ID__c=ISMuser.id,National_Account_Manager_ID__c='00580000008OIUHGH4',NSC_Team_Live__c=true,
                            Branch_Code__c='101',Territory__c='101-04',Selling_Region__c=1.00,Plant_Code__c='1101',Rollup_Plant__c='1101',Country__c='US',Zip__c='32034'); 
     insert bl1;
     
     Branch_LookUp__c bl2 = new Branch_LookUp__c(Sales_Manager_ID__c='00580000008RPXHHH4',National_Account_Manager_ID__c='00580000008OPOHGH4',NSC_Team_Live__c=true,
                            Branch_Code__c='102',Territory__c='102-04',Selling_Region__c=2.00,Plant_Code__c='1101',Rollup_Plant__c='1101',Country__c='US',Zip__c='32134'); 
     insert bl2;
     
     Account pAcc = new Account(Name = 'KPYC Company',Numericphone__c='9741857587',BillingPostalCode='32034',BillingCountry='USA',Territory__c='101-04',BillingState='AZ',
                     ShippingPostalCode='3204',Servicing_Branch_Id__c='101');
     insert pAcc;                      
     
     Account acc = new Account(Name='Tester Company 1',Parent= pAcc,BillingPostalCode='32034',BillingState='AZ',BillingCountry='USA',ShippingPostalCode='32034',Territory__c='123-02',Numericphone__c='9741857587',
                    Servicing_Branch_Id__c='123',ParentId =pAcc.id,isSPOC_Account__c=true);
     insert acc;
     
     accSetId.add(pAcc.Id);
     accSetId.add(acc.Id);
     
     Account selAcc = [select id,isSPOC_Account__c,OwnerId,Owner.LastLeadAllocation__c,Owner.Name from Account where Id=: acc.id];
     
     Contact c1 = new Contact(FirstName='Test Name 1',LastName='Tester 1',MailingPostalCode='32034',AccountId = pAcc.id);
     insert c1;
     
     Contact c2 = new Contact(FirstName='Test Name 1',LastName='Tester 1',MailingPostalCode='32034',AccountId = acc.id);
     insert c2;
     
     Opportunity op1 = new Opportunity(Name='Tester Opportunity',StageName='Not Quoted',Billing_Country__c='USA',AccountId = acc.id,CloseDate=Date.TODAY().addDays(5),Billing_Zip_Postal_Code__c = '85226',Delivery_Zip_Postal_Code__c= '85226',Delivery_Country__c='USA');
     insert op1;      
     
     Glenigan_Project__c gp = new Glenigan_Project__c(value__c=5300000.00);
     insert gp;
     
     NSC_Team_Settings__c nsc1 = new NSC_Team_Settings__c(name='Test NSC 1',Branch_Code__c='101',Team_Name__c='Test Team #1');
     insert nsc1;
     
     NSC_Team_Settings__c nsc2 = new NSC_Team_Settings__c(name='Test NSC 2',Branch_Code__c='102',Team_Name__c='Test Team #2');
     insert nsc2;
     
     Selling_Region_Branch__c sr = new Selling_Region_Branch__c(Name='101',Selling_Region__c='1');
     insert sr;
     
     Lead_Source__c ls = new Lead_Source__c(DNIS__c='8765409129');
     insert ls;
     
     UKrepLeadsDisable__c UKrep1 = new UKrepLeadsDisable__c(Name='UserDayCombn1',UserDay__c='00580000004SdaxAAC_Friday');
     insert UKrep1;
     
     UKrepLeadsDisable__c UKrep2 = new UKrepLeadsDisable__c(Name='UserDayCombn2',UserDay__c='00580000008QkAzAAK_Wednesday');
     insert UKrep2;
     
     ETSnWMIrectype__c  etsWmiR = new ETSnWMIrectype__c(Name='EtsWmiList',ObjRecType__c='Account_01280000000M47d,Lead_01280000000M47e,OpportunitySale_01280000000M49N');
     insert etswmiR;
     
     ETS_WMI_ProfileNames__c etsWmip1 = new ETS_WMI_ProfileNames__c(Name='EtsWmiPr1',ProfileList__c='Area Manager - ETS');
     insert etsWmip1;
     
     ETS_WMI_ProfileNames__c etsWmip2 = new ETS_WMI_ProfileNames__c(Name='EtsWmiPr2',ProfileList__c='Executive Mangement - WMI');
     insert etsWmip2; 
     
     Lead ld1 = new Lead(FirstName='Test Name 1',LastName='Tester 1',Company='Tester Company 1',Phone='9741857587',PostalCode='32034',Delivery_Postal_Code__c='32034',
                Delivery_Country__c='USA',state='CA',Country='USA',Auto_Assign_Lead__c=true,RecordTypeId='012800000007Ium',LeadSource='360 Mobile Office');
     ldList.add(ld1);     
     
     Lead ld2 = new Lead(FirstName='Test Name 2',LastName='Tester 2',Company='Tester Company 2',Phone='9741857587',PostalCode='32034112',Delivery_Postal_Code__c='32034',
                Delivery_Country__c='CA',state='ON',Country='CA',Auto_Assign_Lead__c=true,RecordTypeId='012800000007Ium',LeadSource='NDS Leads',Email='kert@26.gov');     
     ldList.add(ld2);
     
     Lead ld3 = new Lead(FirstName='Test Name 3',LastName='Tester 3',Company='Tester Company 3',Phone='9741097587',PostalCode='32034',Delivery_Postal_Code__c='32034',
                Delivery_Country__c='Ireland',state='IL',Country='UK',Auto_Assign_Lead__c=true,RecordTypeId='012800000007Ium',LeadSource='Glenigan Lead',Glenigan_Project__c=gp.id,
                Bidder_Postal_Code__c='TN210');
     ldList.add(ld3);           
     
     Lead ld4 = new Lead(FirstName='Test Name 4',LastName='Tester 4',Company='Tester Company 4',Phone='9741157587',PostalCode='32134',Delivery_Postal_Code__c='32134',
                Delivery_Country__c='CA',state='MS',Country='USA',Auto_Assign_Lead__c=true,RecordTypeId='012800000007Ium',LeadSource='OB Campaign',Go_To_NSC_Rep__c=true,On_The_Go__c=true);
     ldList.add(ld4);             
               
     Lead ld5 = new Lead(FirstName='Test Name 5',LastName='Tester 5',Company='Tester Company 5',Phone='9741097587',PostalCode='32034',Delivery_Postal_Code__c='32034',
                Delivery_Country__c='UK',state='IN',Country = 'UK',Auto_Assign_Lead__c=true,RecordTypeId='01280000000M55J',LeadSource='MMI UK Website',isUKwebLead__c=true,On_The_Go__c=true,
                Bidder_Postal_Code__c='TN210');                    
     ldList.add(ld5);
     
     Lead ld6 = new Lead(FirstName='Test Name 6',LastName='Tester 6',Company='Construction Company',Phone='9741157580',PostalCode='32034',Delivery_Postal_Code__c='32034',
                Delivery_Country__c='USA',state='AZ',Country='USA',Auto_Assign_Lead__c=false,RecordTypeId='012800000007Ium',PPC_Keywords_URL__c='8765409129');
     ldList.add(ld6);
     
     Lead ld7 = new Lead(FirstName='Test Name 7',LastName='Tester 7',Company='Tester Company 7',Phone='9749057587',PostalCode='32034',Delivery_Postal_Code__c='32034',
                Delivery_Country__c='USA',state='TX',Country='USA',Auto_Assign_Lead__c=true,RecordTypeId='012800000007Ium',LeadSource='360 Mobile Office',Purchase__c=true,I_want_to__c='Buy it',Transaction_Type__c='Sale');
     ldList.add(ld7);
     
     Lead ld8 = new Lead(FirstName='Test Name 8',LastName='Tester 8',Company='Residential Company',Phone='9788857587',PostalCode='32134',Delivery_Postal_Code__c='32134',
                Delivery_Country__c='US',state='KY',Country='US',Auto_Assign_Lead__c=true,RecordTypeId='012800000007Ium',LeadSource='360 Mobile Office');
     ldList.add(ld8); 
     
     Lead ld9 = new Lead(OwnerId='00G80000001eDXS',FirstName='Test Name 8',LastName='Tester 8',Company='Residential Company',Phone='9788857587',PostalCode='32134',Delivery_Postal_Code__c='32134',
                Delivery_Country__c='US',state='KY',Country='US',Auto_Assign_Lead__c=true,RecordTypeId='012800000007Ium',LeadSource='360 Mobile Office');
     ldList.add(ld9);
     
       Lead ld10 = new Lead(OwnerId='00G80000001eDXS',FirstName='Test Name 8',LastName='Tester 8',Company='Residential Company',Phone='9788857587',PostalCode='',Delivery_Postal_Code__c='',
                Delivery_Country__c='US',state='KY',Country='US',Auto_Assign_Lead__c=true,RecordTypeId='012800000007Ium',LeadSource='360 Mobile Office');
     ldList.add(ld10);     
             
     Test.startTest();
     AssignmentRules.isTest=true;
     insert ldList;
     Lead selLead = [select Id,Owner.name from Lead where Id=: ldList[0].Id LIMIT 1];
     AssignmentRules.getZipCodeBasedOnBillingZipShippingCountry(ld1);
     AssignmentRules.runAssignmentAlgoForLead(ld3.id,true);
     AssignmentRules.runAssignmentAlgoForLeadNSC(ld5,false);
     AssignmentRules.getAvailableSellingRegionInboundUser(bl2); 
     AssignmentRules.getAvailableSalesRep('101',bl1,'360 Mobile Office','US','5-Constructions',ld7);
     AssignmentRules.AssignParentAccountOwner(ld2,selAcc,null,'nsc');
     AssignmentRules.AssignParentAccountOwner(ld2,pAcc,null,'nsc');
     AssignmentRules.getZipCodeFromAccount(acc);
     AssignmentRules.RouteToOtherIsr('101');
     AssignmentRules.RoutetoIBTeamOrExceptionQueue(ld8,true,'nsc');
     AssignmentRules.RouteToIsrOrItsManager(ld7);
     AssignmentRules.getConvertedZipCode('TGERSS','GB');
     AssignmentRules.getConvertedZipCode('432132422','USA');
     AssignmentRules.getAvailableSellingRegionInboundUser(bl1);
     AssignmentRules.getInboundUserOfSellingRegion(bl1,true);
     AssignmentRules.runAssignmentAlgoForAccount(acc.id,false);
     AssignmentRules.RouteToSPOCterritoryOwner('29572','USA',ld1 );
     AssignmentRules.GetAvailableSellingRegionUser(bl2);
     AssignmentRules.assignDuplicateLead(ldList,ldList);
     AssignmentRules.RemoveDuplicateLeadfromBatch(ldList); 
     AssignmentRules.getParentAccounts(accSetId);
     AssignmentRules.getParentAccount(acc); 
     AssignmentRules.isHouseAccount(selAcc);  
     AssignmentRules.isLeadOwnerBranchAccount(selLead); 
     AssignmentRules.isPurchaseLead(ld7);   
     AssignmentRules.isMobileOfficeLead(ld8);
     AssignmentRules.isHomeOwner(ld9);
     Test.StopTest();
   } 
 }   
}