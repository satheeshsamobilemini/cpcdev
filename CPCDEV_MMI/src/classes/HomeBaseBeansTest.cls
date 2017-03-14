@isTest
public class HomeBaseBeansTest {
  private static testMethod void  UnitTestHomebase() {
         HomeBaseBeans hBase = new HomeBaseBeans();
              HomeBaseBeans.AddressBean hm = new HomeBaseBeans.AddressBean();
              HomeBaseBeans.ProductSearch  ps = new HomeBaseBeans.ProductSearch();
              HomeBaseBeans.Branches  pb = new HomeBaseBeans.Branches();
              HomeBaseBeans.QuickQuoteRefreshFormat qq = new HomeBaseBeans.QuickQuoteRefreshFormat();
              HomeBaseBeans.QuickQuoteRefreshFormat  qqr =new HomeBaseBeans.QuickQuoteRefreshFormat();
              HomeBaseBeans.rates  rate = new HomeBaseBeans.rates('test','testDescription');
              HomeBaseBeans.QuickQuoteRefreshFormat  qqrf = new HomeBaseBeans.QuickQuoteRefreshFormat();
              HomeBaseBeans.States state = new HomeBaseBeans.States('cmyId','cuntryId','Id','name');
              HomeBaseBeans.countries  count = new HomeBaseBeans.countries('test1','test');
              HomeBaseBeans.transactions  trans = new HomeBaseBeans.transactions('id','description');
              HomeBaseBeans.webAddresses web = new HomeBaseBeans.webAddresses('cmyId','branchId','addr1', 'addr2','addr3','addr4',
                                                    'state', 'zipCode','countryId','cStreet1','cStreet2','taxId',
                                                     'distanceFromBranch','deliveryZone','zoneWarning','latitude','longitude',
                                                     'distanceBranch','fulfillingBranchId','fulfillingBranchName', 'oldPostalCode');
        
              HomeBaseBeans.TaxIds  tax = new HomeBaseBeans.TaxIds('Id','tas','country','CouDesc','country1','state','stateDesc','city');
              HomeBaseBeans.Products prod = new HomeBaseBeans.Products('Id','des','qtyavail','qFree','qWip','qReserved',
                                         'qTotal','cmm1','cmm2','cmm3','cmm4','llw','ppe','mainFeature');
              HomeBaseBeans.product  prd = new HomeBaseBeans.product('id','description',true,'qtyAvail','qtyFree','qtyWip',
                        'qtyReserved','qtyTotal','chargeCode','commission1','commission2',
                        'commission3','commission4');
              //HomeBaseBeans.payment  pay = new HomeBaseBeans.payment(10,11);
              HomeBaseBeans.quickQuoteRefresh  quick = new HomeBaseBeans.quickQuoteRefresh();
              HomeBaseBeans.shippingAddress2  shp = new HomeBaseBeans.shippingAddress2();
              HomeBaseBeans.CreateQuickQuoteRequest quick1 = new HomeBaseBeans.CreateQuickQuoteRequest();
              HomeBaseBeans.CreateQuoteResponse  cqr = new HomeBaseBeans.CreateQuoteResponse();
              HomeBaseBeans.contactSummaryList   csl = new HomeBaseBeans.contactSummaryList('surname',
                                       'contactId',
                                       'emailId',
                                      'forename');
              HomeBaseBeans.contact con = new HomeBaseBeans.contact('surname',
                           'position',
                           'email',
                           'contactId',
                            'forename',
                           'telNumber',
                           'telMobile');
             HomeBaseBeans.AnalysisSetHeaders  ana = new HomeBaseBeans.AnalysisSetHeaders();
             HomeBaseBeans.analysisSetCodes setcode = new HomeBaseBeans.analysisSetCodes();
             HomeBaseBeans.addresses add = new HomeBaseBeans.addresses();
           
            HomeBaseBeans.analysisDtls dtls = new HomeBaseBeans.analysisDtls(); 
            HomeBaseBeans.QuickQuoteRefreshFormat   qqrf1 = new HomeBaseBeans.QuickQuoteRefreshFormat();
            //HomeBaseBeans.payment pay = new   HomeBaseBeans.payment(10,Date.parse('05/11/2010'));
            HomeBaseBeans.quickQuoteRefresh   refresh = new HomeBaseBeans.quickQuoteRefresh();
            
          HomeBaseBeans.CreateQuickQuoteRequest  quickRequest = new HomeBaseBeans.CreateQuickQuoteRequest();
          HomeBaseBeans.CreateQuoteResponse   res = new HomeBaseBeans.CreateQuoteResponse();
          HomeBaseBeans.account acc = new HomeBaseBeans.account('name', 
                           'id',
                           10.12,
                           'lastInvoiceDate',
                           'salesTerms',
                           'termsCode',
                           10.45,
                           'rentalTerms',
                           'taxExemptionCertificate',
                           true,
                           'creditStatus',
                           'certificateOfInsurance');
          HomeBaseBeans.AddCardResponse   cResponse = new  HomeBaseBeans.AddCardResponse();
          HomeBaseBeans.AutocheckResponse   autoResponse = new  HomeBaseBeans.AutocheckResponse();           
    }
}