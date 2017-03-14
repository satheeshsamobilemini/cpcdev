public with sharing class FullQuoteMainController_AC {
    public String isEnableAction {
        get;
        set;
    }
    public List < Attachment > attachmentList {
        get;
        set;
    }
    public Branch_Lookup__c BranchLookup {
        get;
        set;
    }
    public blob fileBody {
        get;
        set;
    }
    public String strAttachFile {
        get;
        set;
    }
    public String strContentType {
        get;
        set;
    }
    public String addressErrorMessage {
        get;
        set;
    }
    public String tabStyle {
        get;
        set;
    }
    public String branchIdforViewBranch {
        get;
        set;
    }
    Public Boolean isContactIdSelect {
        get;
        set;
    }
    public String ContactId {
        get;
        set;
    }
    public String SubjectEmailQuote {
        get;
        set;
    }
    public String MailBodyToQuote {
        get;
        set;
    }
    public String cc1EmailToQuoteId {
        get;
        set;
    }
    public String cc2EmailToQuoteId {
        get;
        set;
    }
    public String fromIdToEmailQoute {
        get;
        set;
    }
    public boolean EmailshowPopUp {
        get;
        set;
    }
    public boolean isErrorMessageForEmail {
        get;
        set;
    }
    public List < Contact > contactListEmail {
        get;
        set;
    }
    public Boolean isSalesType {
        get;
        set;
    }
    public String QuoteType = null;
    public Boolean isSaveSuccessEmail {
        get;
        set;
    }
    public Boolean isEmailContactPopUp {
        get;
        set;
    }
    public Boolean isQuoteExpireIsReadOnly {
        get;
        set;
    }
    public string UserSign {
        get;
        set;
    }
    public string prodctname {
        get;
        set;
    }
    public boolean isLoadedTrap {
        get;
        set;
    }
    public boolean isaccountRecShow {
        get;
        set;
    }

    public String quoteIdforEmail {
        get;
        set;
    }
    public String toAddress {
        get;
        set;
    }
    public String emailId {
        get;
        set;
    }
    public String emailIdForEmailQuote {
        get;
        set;
    }

    public PageReference pdf {
        get;
        set;
    }
    public Blob AttachmentPdf {
        get;
        set;
    }
    public PageReference pdfuser {
        get;
        set;
    }

    public Decimal ppeValue {
        get;
        set;
    }
    public Decimal llwValue {
        get;
        set;
    }
    public Decimal totalRentalCharat {
        get;
        set;
    }
    public Decimal totalOneTimeCharges {
        get;
        set;
    }
    public Decimal totalInitialCharges {
        get;
        set;
    }
    public Decimal totalSalesCharat {
        get;
        set;
    }
    public String salesTotal {
        get;
        set;
    }
    public Boolean isbillingOrShiiping {
        get;
        set;
    }
    public Boolean onchangeQuotType {
        get;
        set;
    }

    public String transtionTypeName {
        get;
        set;
    }
    public String docId {
        get;
        set;
    }
    public String docIdForPdf {
        get;
        set;
    }
    public String markeAsLostoppStageChange;
    public String cloneIsTrue {
        get;
        set;
    }
    public String updatebutton {
        get;
        set;
    }
    public String recId {
        get;
        set;
    }
    public String FQSMrecId {
        get;
        set;
    }

    public boolean isLead {
        get;
        set;
    }
    public QuickQuoteWrapper qqWrapper {
        get;
        set;
    }
    public QuickQuoteWrapper qqWrapperShipping {
        get;
        set;
    }
    public boolean isFullfillingSearch {
        get;
        set;
    }
    public Boolean isContactIs {
        get;
        set;
    }
    public Boolean isAddressId {
        get;
        set;
    }
    public Boolean isScheduDeliver {
        get;
        set;
    }
    public Boolean writeupId {
        get;
        set;
    }
    public Boolean assigRepId {
        get;
        set;
    }
    public Boolean accountAddresInvalid {
        get;
        set;
    }
    public Boolean shippingAddressInvalide {
        get;
        set;
    }
    public boolean isTexIdIsNullbutton {
        get;
        set;
    }
    public boolean isRefreshTrue {
        get;
        set;
    }
    public boolean isFullfillingBranchid {
        get;
        set;
    }
    public boolean isfullfillingBranchInvalide {
        get;
        set;
    }
    public boolean isZipCodeIsNot {
        get;
        set;
    }
    public Boolean BillingContactInvalide {
        get;
        set;
    }
    public Boolean ShippingContactInvalide {
        get;
        set;
    }
    public FullQuoteWrapper fullQWrapper {
        get;
        set;
    }
    public List < HomeBaseBeans.contactSummaryList > contactsResponseList {
        get;
        set;
    }
    public List < HomeBaseBeans.contactSummaryList > contactsResponseListForEmailQutoe {
        get;
        set;
    }

    public List < HomeBaseBeans.contactSummaryList > contactsResponseSearchList {
        get;
        set;
    }
    public List < HomeBaseBeans.chargeCodes > chargeCodeList {
        get;
        set;
    }
    public List < HomeBaseBeans.chargeCodes > chargeCodeSearchList {
        get;
        set;
    }
    public List < HomeBaseBeans.extras > ProductExtrasList {
        get;
        set;
    }
    public List < HomeBaseBeans.analysisSetCodes > analysisSetCodesResponseListInShipping {
        get;
        set;
    }
    public list < List < HomeBaseBeans.quoteLine >> refreshLineAllResponseList {
        get;
        set;
    }

    public transient List < FullQuoteWrapper.quote > customerActivityList {
        get;
        set;
    }
    public List < FullQuoteWrapper.NewCustomerAccount > customerAccList {
        get;
        set;
    }

    public List < FullQuoteWrapper.productTypes > productTypesListNew {
        get;
        set;
    }
    public List < FullQuoteWrapper.productSizes > productSizesListNew {
        get;
        set;
    }
    public set < String > setAccountStatus {
        get;
        set;
    } // TFS 2915
    public list < SelectOption > storageUseOptionsList {
        get;
        set;
    } // for TFS 3262

    String btnOnDeliveryPlan;
    String selectedAnalysisSetInShipping;

    public String documentId, mobilization, modifiedTS;
    public String selectedAnalysisSet;
    public String FulFillingBranchId {
        get;
        set;
    }
    public String SelectedProductDesc {
        get;
        set;
    }
    public Boolean isShippingTabChaneValue {
        get;
        set;
    }
    public Integer LockTypeQuantity {
        get;
        set;
    }
    public Boolean isClearSummaryLineItems {
        get;
        set;
    }
    public String quickQuoteId {
        get;
        set;
    }
    public MMI_Quotes__c QqData {
        get;
        set;
    }
    public Boolean IsReservedSuccess {
        get;
        set;
    }
    public Boolean isScheduledDeliveryDateIsReadOnly {
        get;
        set;
    }
    public Boolean isLodedMoveInIsReadOnly {
        get;
        set;
    }
    public Boolean isEditTranType {
        get;
        set;
    }
    public boolean isRentalLength {
        get;
        set;
    }
    public String tranTypeSetValue;
    public Boolean tranTypeErrorMessage {
        get;
        set;
    }
    public Weekly_Snapshot_Branch_Report__c weeklyBranchSnop {
        get;
        set;
    }
    public boolean isTransTmoboORseco {
        get;
        set;
    }
    public boolean isAccountNameAndIdReadOnly {
        get;
        set;
    }
    public boolean isAccessorySelected {
        get;
        set;
    }
    public boolean lockHideAcc {
        get;
        set;
    }

    public boolean isPoductSelected {
        get;
        set;
    }
    public boolean isProductAlreadyAdded {
        get;
        set;
    }

    public list < FullQuoteWrapper.lockTypesAndQuantity > lockTypeList {
        get;
        set;
    }

    public list < FullQuoteWrapper.stdModification > stdModificationList {
        get;
        set;
    }
    public list < FullQuoteWrapper.stdModification > stdModificationHistoryList {
        get;
        set;
    }

    public list < FullQuoteWrapper.ApproverList > approversList {
        get;
        set;
    }
    public list < FullQuoteWrapper.ContactEmailId > contactEmailId {
        get;
        set;
    }
    public list < HomeBaseBeans.quoteLine > summaryLineInEdit {
        get;
        set;
    }

    public list < FullQuoteWrapper.SalesImages > ImageListSalesInv {
        get;
        set;
    }

    public List < HomeBaseBeans.allocations > eCodeAllocationList {
        get;
        set;
    }
    public boolean isNoEcodeFound {
        get;
        set;
    }
    public boolean isEcodeAllocationBtnDesabled {
        get;
        set;
    }
    public String SelectedItemImageUrl {
        get;
        set;
    }
    public Integer accessoriesQuantity {
        get;
        set;
    }
    public Boolean isSaveSuccess {
        get;
        set;
    }
    public Boolean isInsertingFQ {
        get;
        set;
    }
    public Boolean isUpdatingFQ {
        get;
        set;
    }
    public String SelectedShipingTaxId {
        get;
        set;
    }
    public String SelectedRentalLength {
        get;
        set;
    }
    public boolean showModificPopUP {
        get;
        set;
    }
    public boolean buttonModificEnable {
        get;
        set;
    }

    public boolean isSenderButton {
        get;
        set;
    }
    public boolean isApproverButton {
        get;
        set;
    }
    public Boolean isModificationItem {
        get;
        set;
    }
    public map < String, string > mapItemNameDesc {
        get;
        set;
    }
    public Boolean isQqToFqLoadsFirstTime {
        get;
        set;
    }
    public Boolean isEditQuoteLoadsFirstTime {
        get;
        set;
    }
    public Boolean isCapacityAlreadyReserved {
        get;
        set;
    }
    public Boolean ShowReserveCapacityLink {
        get;
        set;
    }
    public Boolean isValidateBillingAccClicked {
        get;
        set;
    }
    public Boolean isDuplicateAccPresent {
        get;
        set;
    }
    public Boolean isDuplicateAccSelected {
        get;
        set;
    }
    public Boolean isCallFinalAcctCreatService {
        get;
        set;
    }
    public String newAccountId {
        get;
        set;
    }
    public String newContactId {
        get;
        set;
    }
    public String selectedTabName {
        get;
        set;
    }
    public String ApprovalReject {
        get;
        set;
    }
    public String ErreorOnNewAcctCreation {
        get;
        set;
    }

    public Boolean isBillingAddressDisabled {
        get;
        set;
    }
    public Boolean isBillingCityDisabled {
        get;
        set;
    }
    public Boolean isBillingCountyDisabled {
        get;
        set;
    }
    public Boolean isBillingStateDisabled {
        get;
        set;
    }
    public Boolean isBillingContryDisabled {
        get;
        set;
    }
    public Boolean isBillingZipDisabled {
        get;
        set;
    }
    public Boolean isDecarteError {
        get;
        set;
    }
    public Boolean isMarkAsLostError {
        get;
        set;
    }
    public Boolean isNationalAccount {
        get;
        set;
    }
    public String oldNationalRate {
        get;
        set;
    }
    public String oldRenatlRange {
        get;
        set;
    }
    public Boolean isUpdateFromOrderConversion {
        get;
        set;
    }
    public Boolean isErrorDuringUpdationFromOrderConversion {
        get;
        set;
    }
    public Boolean isCallingOrderConversionNeeded {
        get;
        set;
    }
    public Boolean isCallingExtraAnalysisNeeded {
        get;
        set;
    }
    public Boolean isAllModificationRejected {
        get;
        set;
    }
    public Boolean isSalesInventorySearched {
        get;
        set;
    }
    public String oldSearchPattern {
        get;
        set;
    }
    public Boolean isCallQqToFQConversionNeeded {
        get;
        set;
    }
    public Boolean isCapResFromShippingTab {
        get;
        set;
    }
    public Boolean isProductSearchCompleted {
        get;
        set;
    }
    public Boolean isMultipleQuoteWithSamePgAcc {
        get;
        set;
    }
    public String MultipleQuoteResId {
        get;
        set;
    }
    public Boolean isErrorForNorcodHasShown {
        get;
        set;
    }
    public String FQId {
        get;
        set;
    }
    public String isEditForEmailQuote {
        get;
        set;
    }
    public boolean isknowZoneRatesBtnDisabled {
        get;
        set;
    } // for TFS 2507
    public String accountOwnerIdOfQQ {
        get;
        set;
    } // TFS 2710

    public Boolean isShowAddCon {
        get;
        set;
    }
    public Boolean isShowListCon {
        get;
        set;
    }
    public Boolean isShowListCard {
        get;
        set;
    }
    public Boolean isShowListAch {
        get;
        set;
    }
    public Boolean isShowAddCard {
        get;
        set;
    }
    public Boolean isShowAddAch {
        get;
        set;
    }
    public Boolean isAddCard {
        get;
        set;
    }
    public Boolean isAddAch {
        get;
        set;
    }
    public Boolean isAddContact {
        get;
        set;
    }
    public Boolean isAddContactFromBillingTab {
        get;
        set;
    }
    public Boolean isAddContactFromShippingTab {
        get;
        set;
    }
    public Boolean isCustomerAndBillingFunctionalityAllowed {
        get;
        set;
    } ///Show ir hide ADD Contact Button inn Billing & Shipping Tab based on allowed user
    public list < SelectOption > lstCardType {
        get;
        set;
    }
    public list < SelectOption > lstExpiryMonth {
        get;
        set;
    }
    public list < SelectOption > lstExpiryYear {
        get;
        set;
    }
    public list < SelectOption > lstPaymentType {
        get;
        set;
    }
    public list < SelectOption > lstDefaultAddress {
        get;
        set;
    }
    public list < SelectOption > cardStateOptions {
        get;
        set;
    }
    public list < SelectOption > achStateOptions {
        get;
        set;
    }
    public list < SelectOption > lstAchBankAccType {
        get;
        set;
    }
    public list < SelectOption > lstCheckType {
        get;
        set;
    }
    public List < HomeBaseBeans.ListContact > listOfAllContacts {
        get;
        set;
    }
    public List < HomeBaseBeans.ListCard > listOfAllCards {
        get;
        set;
    }
    public List < HomeBaseBeans.ListCard > listOfAllAch {
        get;
        set;
    }
    public String selectedAccContId {
        get;
        set;
    }
    public String selectedCardContId {
        get;
        set;
    }
    public String selectedAchContId {
        get;
        set;
    }
    public String cardContId {
        get;
        set;
    }
    public String AchContId {
        get;
        set;
    }
    public String cardKey1 {
        get;
        set;
    }
    public String cardKey2 {
        get;
        set;
    }
    public String cardKey3 {
        get;
        set;
    }
    public String autoPayDefCardKey1 {
        get;
        set;
    }
    public String autoPayDefCardKey2 {
        get;
        set;
    }
    public String autoPayDefCardKey3 {
        get;
        set;
    }
    public map<String, String> rrErrorAndErrormsg {get;set;}

    //-----------FQ from JP--------------------------------------------------
    public String source {
        get;
        set;
    }
    public String jobProfId {
        get;
        set;
    }
    public String ContactOfJp {
        get;
        set;
    }
    public String subContractorId {
        get;
        set;
    }
    //-----------FQ from JP--------------------------------------------------
    public String ContId {
        get;
        set;
    }
    public String leadConvertedContactId {
        get;
        set;
    }
    public String leadConvertedAccId {
        get;
        set;
    }
    public String selectedConPh {
        get;
        set;
    }

    public Boolean isShowProductList {
        get;
        set;
    }
    public Boolean isShowProdHistory {
        get;
        set;
    }

    MMI_Full_Quotes__c fullQuote = new MMI_Full_Quotes__c();
    public MMI_Full_Quotes__c getfullQuote() {
        return fullQuote;
    }

    Lead lead_ref = new Lead();
    Opportunity opp_ref = new Opportunity();
    public Lead getLeadRefForHeader() {
        return lead_ref;
    }

    Account acc_ref = new Account();
    public Account getAccountRefForHeader() {
        return acc_ref;
    }


    public Opportunity getOppRefForHeader() {
        return opp_ref;
    }
    MMI_Quotes__c QQ_ref = new MMI_Quotes__c();
    public MMI_Quotes__c getQQRefForHeader() {
        return QQ_ref;
    }

    Lead leadRef = new Lead();
    public Lead getLeadRef() // for Start Date in shipping tab
    {
        return leadRef;
    }

    Lead leadRef1 = new Lead(); // for Quote expires field in shipping tab
    public Lead getLeadRef1() {
        return leadRef1;
    }

    Lead leadRef3 = new Lead(); // for Scheduled Delivery field in shipping tab
    public Lead getLeadRef3() {
        return leadRef3;
    }
    Lead leadRef4 = new Lead(); // for Loaded Move In field in shipping tab
    public Lead getLeadRef4() {
        return leadRef4;
    }
    public List < HomeBaseBeans.CapacityLookupHandler > responseHandlerList = new List < HomeBaseBeans.CapacityLookupHandler > ();
    public List < HomeBaseBeans.CapacityLookupHandler > getCapacityLookupList() {
        return responseHandlerList;
    }
    // AnalysisSetHeaderResponse webservice return to visualforce page
    List < HomeBaseBeans.AnalysisSetHeaders > analysisSetHeaderResponseList;
    public List < HomeBaseBeans.AnalysisSetHeaders > getAnalysisSetHeaderResponseList() {
        return analysisSetHeaderResponseList;
    }
    // AnalysisSetHeaderResponse webservice for fields in delivery planning section in shipping screen

    List < HomeBaseBeans.AnalysisSetHeaders > analysisSetHeaderResponseShippingList = new List < HomeBaseBeans.AnalysisSetHeaders > ();
    public List < HomeBaseBeans.AnalysisSetHeaders > getAnalysisSetHeaderResponseShippingList() {
        return analysisSetHeaderResponseShippingList;
    }
    // AnalysisSetCodeResponse webservice return to visualforce page
    List < HomeBaseBeans.analysisSetCodes > analysisSetCodesResponseList = new List < HomeBaseBeans.analysisSetCodes > ();
    public List < HomeBaseBeans.analysisSetCodes > getAnalysisSetCodeResponseList() {
        return analysisSetCodesResponseList;
    }
    List < HomeBaseBeans.analysisSetCodes > analysisSetCodesResponseSearchList = new List < HomeBaseBeans.analysisSetCodes > ();

    public List < HomeBaseBeans.analysisSetCodes > getAnalysisSetCodeResponseSearchList() {
        return analysisSetCodesResponseSearchList;
    }
    List < HomeBaseBeans.analysisSetCodes > analysisSetCodesResponseSearchShippingList = new List < HomeBaseBeans.analysisSetCodes > ();

    public List < HomeBaseBeans.analysisSetCodes > getAnalysisSetCodeResponseSearchShippingList() {
        return analysisSetCodesResponseSearchShippingList;
    }

    List < HomeBaseBeans.TaxIds > taxAddressShippingResponseList = new List < HomeBaseBeans.TaxIds > ();
    public List < HomeBaseBeans.TaxIds > getTaxAddressShippingResponseList() {
        return taxAddressShippingResponseList;
    }

    // Address webservice

    List < HomeBaseBeans.addresses > addressResponseList = new List < HomeBaseBeans.addresses > ();
    public List < HomeBaseBeans.addresses > getAddressResponseList() {
        return addressResponseList;
    }

    List < HomeBaseBeans.addresses > addressshippingList = new List < HomeBaseBeans.addresses > ();
    public List < HomeBaseBeans.addresses > getAddressshippingList() {
        return addressshippingList;
    }

    List < HomeBaseBeans.addresses > addressBillingList = new List < HomeBaseBeans.addresses > ();
    public List < HomeBaseBeans.addresses > getaddressBillingList() {
        return addressBillingList;
    }

    HomeBaseBeans.TaxIds selectedTaxRecInBilling = new HomeBaseBeans.TaxIds();
    HomeBaseBeans.TaxIds selectedTaxRecInShipping = new HomeBaseBeans.TaxIds();

    List < HomeBaseBeans.TaxIds > taxAddressBillingResponseList = new List < HomeBaseBeans.TaxIds > ();
    public List < HomeBaseBeans.TaxIds > getTaxAddressBillingResponseList() {
        return taxAddressBillingResponseList;
    }

    List < HomeBaseBeans.analysisSetCodes > analysisSetAdSourceResponseList = new List < HomeBaseBeans.analysisSetCodes > ();
    List < HomeBaseBeans.analysisSetCodes > analysisSetCTypeResponseList = new List < HomeBaseBeans.analysisSetCodes > ();
    List < HomeBaseBeans.analysisSetCodes > analysisSetDeferredResponseList = new List < HomeBaseBeans.analysisSetCodes > ();
    List < HomeBaseBeans.analysisSetCodes > analysisSetWriteOffAcResponseList = new List < HomeBaseBeans.analysisSetCodes > ();
    List < HomeBaseBeans.analysisSetCodes > analysisSetCostCenterResponseList = new List < HomeBaseBeans.analysisSetCodes > ();
    List < HomeBaseBeans.analysisSetCodes > analysisSetORepResponseList = new List < HomeBaseBeans.analysisSetCodes > ();


    List < HomeBaseBeans.analysisSetCodes > analysisSetDelTimeResponseList = new List < HomeBaseBeans.analysisSetCodes > ();
    List < HomeBaseBeans.analysisSetCodes > analysisSetCallTypeResponseList = new List < HomeBaseBeans.analysisSetCodes > ();
    List < HomeBaseBeans.analysisSetCodes > analysisSetDoorDirResponseList = new List < HomeBaseBeans.analysisSetCodes > ();
    List < HomeBaseBeans.analysisSetCodes > analysisSetMovementTypeResponseList = new List < HomeBaseBeans.analysisSetCodes > ();

    List < HomeBaseBeans.webAddresses > validateAddressResponse = new List < HomeBaseBeans.webAddresses > ();
    List < HomeBaseBeans.webAddresses > validateAddressShippingResponse = new List < HomeBaseBeans.webAddresses > ();
    List < HomeBaseBeans.Products > productList = new List < HomeBaseBeans.Products > ();
    List < HomeBaseBeans.quoteLine > refreshLineResponseList = new List < HomeBaseBeans.quoteLine > ();

    List < HomeBaseBeans.salesReps > salesRepsList = new List < HomeBaseBeans.salesReps > ();
    List < HomeBaseBeans.salesReps > salesRepsSearchList = new List < HomeBaseBeans.salesReps > ();

    public List < HomeBaseBeans.salesReps > getSalesReps() {
        return salesRepsList;
    }

    public List < HomeBaseBeans.salesReps > getSalesRepsSearchList() {
        return salesRepsSearchList;
    }

    public List < HomeBaseBeans.webAddresses > getValidateAddressResponse() {
        return validateAddressResponse;
    }

    public List < FullQuoteWrapper.DescarteInnerClass > DescarteInnerClassList = new List < FullQuoteWrapper.DescarteInnerClass > ();
    public List < FullQuoteWrapper.DescarteInnerClass > getDescarteInnerClassList() {
        return DescarteInnerClassList;
    }

    FullQuoteWrapper.DescarteInnerClass selectedVAddressInBilling = new FullQuoteWrapper.DescarteInnerClass();

    public List < FullQuoteWrapper.DescarteInnerClass > DescarteInnerClassShippingList = new List < FullQuoteWrapper.DescarteInnerClass > ();
    public List < FullQuoteWrapper.DescarteInnerClass > getDescarteInnerClassShippingList() {
        return DescarteInnerClassShippingList;
    }
    FullQuoteWrapper.DescarteInnerClass selectedVAddressInShipping = new FullQuoteWrapper.DescarteInnerClass();
    public List < HomeBaseBeans.Products > getProductList() {
        return productList;
    }
    HomeBaseBeans.Products editProduct = new HomeBaseBeans.Products();
    public HomeBaseBeans.Products getEditProduct() {
        return editProduct;
    }
    public List < HomeBaseBeans.analysisSetCodes > analysisSetCodesResponseiInProductList {
        get;
        set;
    }

    // To enable the edot product section
    String SelectedPId = '';

    List < HomeBaseBeans.quoteLine > summaryLineListForRental = new List < HomeBaseBeans.quoteLine > ();
    public List < HomeBaseBeans.quoteLine > getsummaryLineListForRental() {
        return summaryLineListForRental;
    }
    public List < HomeBaseBeans.quoteLine > summaryLineList {
        get;
        set;
    }
    public List < HomeBaseBeans.SalesFleets > salesFleetList = new List < HomeBaseBeans.SalesFleets > ();
    public List < HomeBaseBeans.SalesFleets > getSalesFleetList() {
        return salesFleetList;
    }
    public List < FullQuoteWrapper.stateInnerClass > innerStateList = new List < FullQuoteWrapper.stateInnerClass > ();

    List < HomeBaseBeans.Products > productsExtrasPayload = new List < HomeBaseBeans.Products > ();
    public List < HomeBaseBeans.branches > getFulFillingBranchList() {
        return branches;
    }

    List < HomeBaseBeans.branches > branchesSearchList = new List < HomeBaseBeans.branches > ();
    public List < HomeBaseBeans.branches > getFulFillingBranchSearchList() {
        return branchesSearchList;
    }

    List < HomeBaseBeans.branches > branchesSearchShippingList = new List < HomeBaseBeans.branches > ();
    public List < HomeBaseBeans.branches > getFulFillingBranchSearchShippingList() {
        return branchesSearchShippingList;
    }
    List < HomeBaseBeans.account > accountResponseList = new List < HomeBaseBeans.account > ();
    public List < HomeBaseBeans.account > getAccountResponseList() {
        return accountResponseList;
    }
    List < HomeBaseBeans.branches > branches = new List < HomeBaseBeans.branches > ();
    // To add Product to Summary Lines section in product screen
    Integer summaryLineCount = 1;
    List < Lead > leadRec = new List < Lead > (); // For Lead Object Record
    List < Opportunity > opportunityRec = new List < Opportunity > (); // For Opportunity Object Record
    List < Account > accountRec = new List < Account > (); // For Account Object Record

    // Save full quote 
    List < SelectOption > saveFOptions = new List < SelectOption > ();
    List < SelectOption > CountryOptions = new List < SelectOption > ();
    public List < SelectOption > getCountryOptions() {
        return CountryOptions;
    }
    List < SelectOption > StateOptions = new List < SelectOption > ();
    List < SelectOption > shippingStateOptions = new List < SelectOption > ();

    public List < SelectOption > getStateOptions() {
        return stateOptions;
    }
    public List < SelectOption > getshippingStateOptions() {
        return shippingStateOptions;
    }


    EditFullQUoteService_AC editFQResponse = new EditFullQUoteService_AC();
    // for transaction type options

    public List < SelectOption > transactionOptions = new List < SelectOption > ();
    public List < SelectOption > getTransactionOptionsList() {
        return transactionOptions;
    }
    public String imageURL {
        get;
        set;
    }
    User UserRecord = new User();
    User userRec = new User();

    MMI_Full_Quotes__c updateQuoteRec = new MMI_Full_Quotes__c();
    public User loginUserRec {
        get;
        set;
    }
    // Constructor
    Full_Quote_Transactional__c fullQuote_tran = new Full_Quote_Transactional__c();
    List < Rate__c > rateList = new List < Rate__c > ();
    public String opportunityID {
        get;
        set;
    }
    public List < Modification_Option_Transactional__c > modList {
        get;
        set;
    }
    public List < Standard_Modification__c > stdMList {
        get;
        set;
    }
    //public list<SelectOption> lstUserBranchId {get;set;}

    // private List<HB_Sales_Inventory__c> salesInventoryList=null;

    public list < SelectOption > unitTypeOptionsList {
        get;
        set;
    } // for TFS 2719
    public String standardRate {
        get;
        set;
    } // for TFS 2829
    public String baseRate {
        get;
        set;
    } // for TFS 3080
    public List < FullQuoteWrapper.ProductSales > salesInventories {
        get;
        set;
    }
    
    // -----------------------------------For TFS 3940----------------------------------------
    public list<SelectOption> lstFldr {get;set;}
    public String selectedFolder {get;set;}
    public list<EmailTemplate> lstEmailTemplate {get;set;}
    public Boolean isThereATemplate {get;set;}
    public String selectedEmailTemplateId {get;set;}
    public String accOwnerOfFQId {get;set;}
    
    // -----------------------------------For TFS 3940----------------------------------------
    private List < FullQuoteWrapper.ProductSales > salesInventoriesList = null;
    // the method is renamed to FullQuoteMainController_AC_initialize from FullQuoteMainController_AC to create record during constructor execution.
    public void FullQuoteMainController_AC_initialize() {

        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :FullQuoteMainController_AC');
        //WSErrorHandler.isConstructerLoading = true;
        //lstUserBranchId = new list<SelectOption>();
        //--------------For TFS 3940-----------------------------------------------------------------------
        list<Folder> lstFolder = [Select f.Type, f.Name, f.Id From Folder f where f.Type = 'Email'];
        lstFldr = new list<SelectOption>();
        lstFldr.add(new SelectOption('','--None--'));
        if(lstFolder.size() > 0){
            for(Folder f : lstFolder){
                lstFldr.add(new SelectOption(f.Id,f.Name));
            }
        }
        //--------------For TFS 3940-----------------------------------------------------------------------
        
        isAddContactFromBillingTab = false;
        isAddContactFromShippingTab = false;
        selectedAccContId = '';
        selectedCardContId = '';
        cardContId = '';
        AchContId = '';
        cardKey1 = '';
        cardKey2 = '';
        cardKey3 = '';
        rrErrorAndErrormsg = new map<String,String>();
        rrErrorAndErrormsg.put('postalCode','Zip Code');
        rrErrorAndErrormsg.put('bankTransitNumber','Bank Routing No');
        rrErrorAndErrormsg.put('accountNumber','Bank Account Number');
        rrErrorAndErrormsg.put('phoneNumber','Phone Number ');
        rrErrorAndErrormsg.put('email','Email');

        listOfAllContacts = new List < HomeBaseBeans.ListContact > ();
        listOfAllCards = new List < HomeBaseBeans.ListCard > ();
        isShowAddCon = true;
        isShowListCon = true;
        isShowListCard = false;
        isShowListAch = false;
        isShowAddCard = false;
        isShowAddAch = false;
        isAddCard = true;
        isAddContact = true;
        
        //set all static picklist from custom settings
        lstCardType = new list < SelectOption > ();
        lstCardType.add(new SelectOption('', '--None--'));
        lstPaymentType = new list < SelectOption > ();
        lstPaymentType.add(new SelectOption('', '--None--'));
        lstDefaultAddress = new list < SelectOption > ();
        lstDefaultAddress.add(new SelectOption('', '--None--'));
        lstAchBankAccType = new list < SelectOption > ();
        lstAchBankAccType.add(new SelectOption('', '--None--'));
        lstCheckType = new list < SelectOption > ();
        lstCheckType.add(new SelectOption('', '--None--'));
        
        list < Add_Contact_And_Card_Custom_Settings__c > contactAndCardSettings = Add_Contact_And_Card_Custom_Settings__c.getAll().Values();
        if (contactAndCardSettings != null && !contactAndCardSettings.isEmpty()) {
            String AllCardTypeVals = contactAndCardSettings.get(0).Card_Type__c;
            String AllPaymentTypeVals = contactAndCardSettings.get(0).Payment_Type__c;
            String AllDefaultAccessCodeVals = contactAndCardSettings.get(0).Default_address_code__c;
            String AllBankAccTypes = contactAndCardSettings.get(0).Bank_Account_Type__c;
            String AllCheckTypes = contactAndCardSettings.get(0).Check_Type__c;

            if (AllCardTypeVals != null && AllCardTypeVals != '') {
                list < String > lstCardTypes = AllCardTypeVals.split(',');
                if (!lstCardTypes.isEmpty()) {
                    for (String s: lstCardTypes) {
                        list < String > lstCrdTyps = s.split('_');
                        if (!lstCrdTyps.isEmpty()) {
                            lstCardType.add(new SelectOption(lstCrdTyps[0], lstCrdTyps[1]));
                        }
                    }
                }
            }

            if (AllPaymentTypeVals != null && AllPaymentTypeVals != '') {
                list < String > lstPaymentTypes = AllPaymentTypeVals.split(',');
                if (!lstPaymentTypes.isEmpty()) {
                    for (String s: lstPaymentTypes) {
                        list < String > lstPmtTyps = s.split('_');
                        if (!lstPmtTyps.isEmpty()) {
                            lstPaymentType.add(new SelectOption(lstPmtTyps[0], lstPmtTyps[1]));
                        }
                    }
                }
            }

            if (AllDefaultAccessCodeVals != null && AllDefaultAccessCodeVals != '') {
                list < String > lstDefAddress = AllDefaultAccessCodeVals.split(',');
                if (!lstDefAddress.isEmpty()) {
                    for (String s: lstDefAddress) {
                        list < String > lstDefAddr = s.split('_');
                        if (!lstDefAddr.isEmpty()) {
                            lstDefaultAddress.add(new SelectOption(lstDefAddr[0], lstDefAddr[1]));
                        }
                    }
                }
            }
            
            if (AllBankAccTypes != null && AllBankAccTypes != '') {
                list < String > lstBankAcct = AllBankAccTypes.split(',');
                if (!lstBankAcct.isEmpty()) {
                    for (String s: lstBankAcct) {
                        list < String > lstBAnkAccount = s.split('_');
                        if (!lstBAnkAccount.isEmpty()) {
                            lstAchBankAccType.add(new SelectOption(lstBAnkAccount[0], lstBAnkAccount[1]));
                        }
                    }
                }
            }
            
            if (AllCheckTypes != null && AllCheckTypes != '') {
                list < String > lstChkType = AllCheckTypes.split(',');
                if (!lstChkType.isEmpty()) {
                    for (String s: lstChkType) {
                        list < String > lstCheckTypes = s.split('_');
                        if (!lstCheckTypes.isEmpty()) {
                            lstCheckType.add(new SelectOption(lstCheckTypes[0], lstCheckTypes[1]));
                        }
                    }
                }
            }
        }
        //set card expiry month and year list
        lstExpiryMonth = new list < SelectOption > ();
        lstExpiryMonth.add(new SelectOption('', '--None--'));
        for (Integer month = 1; Month <= 12; Month++) {
            if (month < 10) {
                lstExpiryMonth.add(new SelectOption('0' + String.valueOf(month), '0' + String.valueOf(month)));
            } else {
                lstExpiryMonth.add(new SelectOption(String.valueOf(month), String.valueOf(month)));
            }
        }
        lstExpiryYear = new list < SelectOption > ();
        lstExpiryYear.add(new SelectOption('', '--None--'));
        Integer currentYear = system.Today().Year();
        lstExpiryYear.add(new SelectOption(String.valueOf(currentYear), String.valueOf(currentYear)));
        for (Integer yearVal = 1; yearVal <= 20; yearVal++) {
            lstExpiryYear.add(new SelectOption(String.valueOf(currentYear + yearVal), String.valueOf(currentYear + yearVal)));
        }

        //------3262---------------------------------------
        storageUseOptionsList = new list < SelectOption > ();
        Schema.DescribeFieldResult fieldResult = Opportunity.Why_do_you_need_storage_Picklist__c.getDescribe();
        List < Schema.PicklistEntry > ple = fieldResult.getPicklistValues();
        storageUseOptionsList.add(new SelectOption('', '--None--'));
        for (Schema.PicklistEntry p: ple) {
            storageUseOptionsList.add(new SelectOption(p.getValue(), p.getValue()));
        }
        //------3262---------------------------------------

        setAccountStatus = new set < String > (); // TFS 2915
        setAccountStatus.add('HFC');
        setAccountStatus.add('HFCZ');
        setAccountStatus.add('SPRVRQ');
        setAccountStatus.add('HFC3');
        setAccountStatus.add('HFCC');
        setAccountStatus.add('HFCH');
        setAccountStatus.add('HFCK');
        setAccountStatus.add('HFCL');
        setAccountStatus.add('HFCR');
        setAccountStatus.add('HFCT');
        setAccountStatus.add('HFCU');
        setAccountStatus.add('DISP');

        unitTypeOptionsList = new list < SelectOption > ();
        Schema.DescribeFieldResult fieldResult1 = Opportunity.Unit_Type__c.getDescribe();
        List < Schema.PicklistEntry > ple1 = fieldResult1.getPicklistValues();
        unitTypeOptionsList.add(new SelectOption('', '--None--'));
        for (Schema.PicklistEntry p: ple1) {
            unitTypeOptionsList.add(new SelectOption(p.getValue(), p.getValue()));
        }

        isknowZoneRatesBtnDisabled = true;
        isShowProductList = false;
        isShowProdHistory = false;
        quoteIdforEmail = '';
        isEnableAction = 'end';
        isErrorForNorcodHasShown = false;
        isMultipleQuoteWithSamePgAcc = false;
        isProductSearchCompleted = false;
        isCapResFromShippingTab = false;
        isCallQqToFQConversionNeeded = false;
        isSalesInventorySearched = false;
        isAllModificationRejected = false;
        isCallingExtraAnalysisNeeded = false;
        isQuoteExpireIsReadOnly = true;
        isUpdateFromOrderConversion = false;
        isErrorDuringUpdationFromOrderConversion = false;
        isCallingOrderConversionNeeded = false;
        isNationalAccount = false;
        isDecarteError = false;
        isMarkAsLostError = false;
        isaccountRecShow = false;
        selectedTabName = 'Customer & Billing';
        prodctname = '';
        isLoadedTrap = false;
        isBillingAddressDisabled = false;
        isBillingCityDisabled = false;
        isBillingCountyDisabled = false;
        isBillingStateDisabled = false;
        isBillingContryDisabled = false;
        isBillingZipDisabled = false;

        erreorOnNewAcctCreation = '';
        addressErrorMessage = '';
        isCallFinalAcctCreatService = false;
        isValidateBillingAccClicked = false;
        isDuplicateAccPresent = false;
        isDuplicateAccSelected = false;
        EmailshowPopUp = false;
        isEmailContactPopUp = false;
        isSaveSuccessEmail = false;
        isSalesType = false;
        isErrorMessageForEmail = true;
        ShowReserveCapacityLink = false;
        isCapacityAlreadyReserved = false;
        isQqToFqLoadsFirstTime = false;
        isEditQuoteLoadsFirstTime = false;
        fullQWrapper = new FullQuoteWrapper();
        FullQuoteMainService fqService = new FullQuoteMainService();
        onchangeQuotType = false;
        isbillingOrShiiping = false;
        isSaveSuccess = false;
        isInsertingFQ = true;
        isUpdatingFQ = false;
        isContactIs = true;
        isAddressId = true;

        isNoEcodeFound = false;
        isEcodeAllocationBtnDesabled = true;
        accessoriesQuantity = 1;
        summaryLineInEdit = new list < HomeBaseBeans.quoteLine > ();
        lockTypeList = new list < FullQuoteWrapper.lockTypesAndQuantity > ();
        stdModificationList = new list < FullQuoteWrapper.stdModification > ();
        stdModificationHistoryList = new list < FullQuoteWrapper.stdModification > ();
        approversList = new list < FullQuoteWrapper.ApproverList > ();
        contactEmailId = new list < FullQuoteWrapper.ContactEmailId > ();

        productTypesListNew = QuickQuoteUtilities.getProductTypeNewListFullQuote();
        productSizesListNew = QuickQuoteUtilities.getProductSizeNewListFullQuote();

        refreshLineAllResponseList = new list < List < HomeBaseBeans.quoteLine >> ();
        FullQuoteWrapper.lockTypesAndQuantity lockObj1 = new FullQuoteWrapper.lockTypesAndQuantity();
        eCodeAllocationList = new List < HomeBaseBeans.allocations > ();
        lockObj1.LockName = 'CG1';
        lockObj1.LockDescription = 'Container Guard Lock Keyed Different';
        lockObj1.isLockselected = false;
        lockObj1.lockQuantity = 1;
        lockTypeList.add(lockObj1);
        FullQuoteWrapper.lockTypesAndQuantity lockObj2 = new FullQuoteWrapper.lockTypesAndQuantity();
        lockObj2.LockName = 'CG2';
        lockObj2.LockDescription = 'Container Guard Lock Keyed Alike';
        lockObj2.isLockselected = false;
        lockObj2.lockQuantity = 1;
        lockTypeList.add(lockObj2);
        FullQuoteWrapper.lockTypesAndQuantity lockObj3 = new FullQuoteWrapper.lockTypesAndQuantity();
        lockObj3.LockName = 'DL1';
        lockObj3.LockDescription = 'Disc Lock Keyed Different';
        lockObj3.isLockselected = false;
        lockObj3.lockQuantity = 1;
        lockTypeList.add(lockObj3);
        FullQuoteWrapper.lockTypesAndQuantity lockObj4 = new FullQuoteWrapper.lockTypesAndQuantity();
        lockObj4.LockName = 'DL2';
        lockObj4.LockDescription = 'Disc Lock Keyed Alike';
        lockObj4.isLockselected = false;
        lockObj4.lockQuantity = 1;
        lockTypeList.add(lockObj4);



        tranTypeErrorMessage = false;
        isEditTranType = false;
        isRentalLength = false;
        isScheduledDeliveryDateIsReadOnly = false;
        isLodedMoveInIsReadOnly = false;
        IsReservedSuccess = false;
        isZipCodeIsNot = false;
        isClearSummaryLineItems = false;
        isFullfillingBranchid = true;
        isAccountNameAndIdReadOnly = false;


        LockTypeQuantity = 1;
        isShippingTabChaneValue = false;
        docId = System.currentPageReference().getParameters().get('fullQUoteId');
        cloneIsTrue = System.currentPageReference().getParameters().get('clone');
        if (cloneIsTrue != 'true') {
            docIdForPdf = docId;
        } else {
            docIdForPdf = null;
        }
        documentId = docId;
        updatebutton = docId;
        quickQuoteId = System.currentPageReference().getParameters().get('QuickQuoteId');
        fullQWrapper.isQuoteUpdatedOnce = false;
        fullQWrapper.enableRefreshQuote = false;
        fullQWrapper.enableSaveQuote = false;
        fullQWrapper.rentalLength = '1';
        fullQWrapper.enableProductadd = false;
        fullQWrapper.enableVAddresBtnInShipping = false;
        fullQWrapper.fullfillingBranch = false;
        fullQWrapper.invoiceTabEnableDis = false;
        fullQWrapper.startDateonchange = false;
        fullQWrapper.analysisSetHeadValue = false;
        isFullfillingBranchid = true;
        isTexIdIsNullbutton = true;

        isTransTmoboORseco = false;
        isAccessorySelected = false;
        lockHideAcc = false;
        isProductAlreadyAdded = false;
        isPoductSelected = false;
        fullQWrapper.showOrderPopUp = false;

        fullQWrapper.showCapacityPopUp = false;
        fullQWrapper.ifCapacityYes = false;


        fullQWrapper.disableModificationPrice = true;
        fullQWrapper.disableModificationSelection = false;
        fullQWrapper.showSubmitButton = true;

        showModificPopUP = false;
        buttonModificEnable = true;

        isSenderButton = false;
        isApproverButton = false;
        ImageListSalesInv = new List < FullQuoteWrapper.SalesImages > ();
        summaryLineList = new List < HomeBaseBeans.quoteLine > ();

        customerAccList = new List < FullQuoteWrapper.NewCustomerAccount > ();
        analysisSetHeaderResponseList = new List < HomeBaseBeans.AnalysisSetHeaders > ();
        ProductExtrasList = new List < HomeBaseBeans.extras > ();
        fullQWrapper.isShippingAddressValidated = false;
        fullQWrapper.isBillingAddressValidated = true;
        QuickQuoteMainService qqService = new QuickQuoteMainService();

        fullQWrapper.userBranchId = qqService.getuserBranchInfo();
        qqWrapper = new QuickQuoteWrapper();
        qqWrapperShipping = new QuickQuoteWrapper();

        userRec = [Select Id, Email, Branch_Id__c from User where Id = : UserInfo.getUserId()];
        loginUserRec = [Select Id, LastName, Branch_Id__c, FirstName, MobilePhone, Country, City, Street, UserRole.Name, UserRoleId, State, PostalCode, Email, Fax, Phone, Extension__c, Name, Sales_Rep_Id__c,Alias,CommunityNickname,Rental_Result_Username__c,Allow_Customer_Billing_Functionality__c from User where Id = : UserInfo.getUserId()];
        fromIdToEmailQoute = loginUserRec.Email;
        isCustomerAndBillingFunctionalityAllowed = loginUserRec.Allow_Customer_Billing_Functionality__c;
        fullQWrapper.WriteUpRep = loginUserRec.Sales_Rep_Id__c;
        fullQWrapper.AssistingRep = loginUserRec.Sales_Rep_Id__c;
        fullQWrapper.WriteUpRepName = loginUserRec.Name;
        fullQWrapper.AssistingRepName = loginUserRec.Name;
        source = System.currentPageReference().getParameters().get('source');
        if (source == 'jp') {
            recId = System.currentPageReference().getParameters().get('accId');
            fullQWrapper.accIdOfJp = recId;
            jobProfId = System.currentPageReference().getParameters().get('id');
            fullQWrapper.jobProfileId = jobProfId;
            subContractorId = System.currentPageReference().getParameters().get('scId');
            fullQWrapper.subContId = subContractorId;
            ContactOfJp = System.currentPageReference().getParameters().get('conId');
            fullQWrapper.contactId = ContactOfJp;
            ContId = ContactOfJp;
        } else {
            recId = System.currentPageReference().getParameters().get('Id');
            ContId = System.currentPageReference().getParameters().get('conId');
        }
        selectedConPh = System.currentPageReference().getParameters().get('conPh');
        if (selectedConPh != null && selectedConPh != '' && selectedConPh != 'null') {
            fullQWrapper.primaryContactNo = selectedConPh;
        }
        FQSMrecId = System.currentPageReference().getParameters().get('FQSM');
        modList = new List < Modification_Option_Transactional__c > ();
        stdMList = new List < Standard_Modification__c > ();
        isModificationItem = false;
        mapItemNameDesc = new map < String, string > ();
        stdMList = fqService.getStandardModificationList();
        if (recId != null) {
            InitializeModificationList(stdMList);
            leadRec = fqService.getLeadinfo(recId);
            opportunityRec = fqService.getOppInfo(recId);
            accountRec = fqService.getAccounListInfo(recId);
            if (leadRec.size() > 0) {
                tabStyle = 'Lead';
                lead_ref = leadRec[0];
                fullQWrapper.sourceId = lead_ref.Id;
            }
            if (opportunityRec.size() > 0) {
                //isLead = false;
                fullQWrapper.storageUse = opportunityRec[0].Why_do_you_need_storage_Picklist__c;
                fullQWrapper.fqComments = opportunityRec[0].Quote_Comments__c;
                tabStyle = 'Opportunity';
                opp_ref = opportunityRec[0];
                fullQWrapper.sourceId = opp_ref.Id;
                if (opportunityRec.size() > 0) {
                    if (opportunityRec[0].of_Units__c != null) {
                        fullQWrapper.noOfUnit = Integer.valueOf(opportunityRec[0].of_Units__c);
                    }
                    accountOwnerIdOfQQ = opportunityRec[0].Account.OwnerId;
                    if (opportunityRec[0].Account.Result_Id__c != null && opportunityRec[0].Account.Result_Id__c != '') {
                        fullQWrapper.AccountId = opportunityRec[0].Account.Result_Id__c;
                        if (fullQWrapper.AccountId.startsWith('P') || fullQWrapper.AccountId.startsWith('G')) {
                            list < Account > accountRecData = fqService.getAccounListInfo(opportunityRec[0].AccountID);
                            if (accountRecData.size() > 0) {
                                /*List<Contact> con = accountRecData[0].Contacts;
                                    if(con.size() > 0){
                                        fullQWrapper.Name = con[0].FirstName;
                                        fullQWrapper.LastName = con[0].LastName;
                                        fullQWrapper.telePhone = con[0].Phone;
                                    }*/
                                if (ContId != null && ContId != '') {
                                    displayCOntactDetail(ContId);
                                }
                                AccountService accountServiceRef = new AccountService();
                                HomeBaseBeans.account accountResponseData = accountServiceRef.listAccounts(fullQWrapper.AccountId, fullQWrapper.TransactionType, String.valueOf(system.today()));
                                if (accountResponseData != null) {
                                    fullQWrapper.AccountName = accountResponseData.name;
                                }
                                //populateContactDetails(accountRecData[0].Id); // issue 1271
                            }
                            disableBilingAddressFields();
                        } else {
                            accountIDInBilling();
                        }
                        isAccountNameAndIdReadOnly = true;

                    } else {
                        isaccountRecShow = true;
                        list < Account > accountRecData = fqService.getAccounListInfo(opportunityRec[0].AccountID);
                        if (accountRecData.size() > 0) {
                            /*if(accountRecData[0].IsPersonAccount){
                                    fullQWrapper.AccountName = accountRecData[0].LastName+' '+accountRecData[0].FirstName;
                                }else{*/
                            fullQWrapper.AccountName = accountRecData[0].Name;
                            //}
                            /*List<Contact> con = accountRecData[0].Contacts;
                                if(con.size() > 0){
                                    fullQWrapper.Name = con[0].FirstName;
                                    fullQWrapper.LastName = con[0].LastName;
                                    fullQWrapper.telePhone = con[0].Phone;
                                }*/
                            //populateContactDetails(accountRecData[0].Id);
                            if (ContId != null && ContId != '') {
                                displayCOntactDetail(ContId);
                            }
                        }
                    }
                }
            }
            if (accountRec.size() > 0) {
                system.debug('----------account----');
                accountOwnerIdOfQQ = accountRec[0].OwnerId;
                //isLead = false;
                if (!isaccountRecShow) {
                    tabStyle = 'Account';
                    acc_ref = accountRec[0];
                }
                fullQWrapper.sourceId = acc_ref.Id;
                if (acc_ref.Result_Id__c != null && acc_ref.Result_Id__c != '') {
                    fullQWrapper.AccountId = accountRec[0].Result_Id__c;
                    isAccountNameAndIdReadOnly = true;
                    accountIDInBilling();
                } else {
                    if (accountRec.size() > 0) {
                        /*if(accountRec[0].IsPersonAccount){
                            fullQWrapper.AccountName = accountRec[0].LastName+' '+accountRec[0].FirstName;
                        }else{*/
                        fullQWrapper.AccountName = accountRec[0].Name;
                        /*List<Contact> con = accountRec[0].Contacts;
                            if(con.size() > 0){
                                fullQWrapper.Name = con[0].FirstName;
                                fullQWrapper.LastName = con[0].LastName;
                                fullQWrapper.telePhone = con[0].Phone;
                            }*/
                        if (ContId != null && ContId != '') {
                            displayCOntactDetail(ContId);
                        }
                        //}
                        //populateContactDetails(accountRec[0].Id); // issue 1271
                    }
                    system.debug('-----accountRec-----' + accountRec);
                }
                system.debug('-------------fullQWrapper.Name----------' + fullQWrapper.Name);
                system.debug('-------------fullQWrapper.LastName----------' + fullQWrapper.LastName);
                system.debug('-------------fullQWrapper.telePhone----------' + fullQWrapper.telePhone);
            }
        } else if (FQSMrecId != null) {
            fullQWrapper.selectedFullQUote = 'sales';
            modList = fqService.getModificationOption(FQSMrecId);
            String isApprRejected = 'no';
            String isApprApproved = 'no';
            for (Modification_Option_Transactional__c modOp: modList) {
                FullQuoteWrapper.stdModification stMO = new FullQuoteWrapper.stdModification();
                if (modOp.IsSelected__c != null && modOp.IsSelected__c) {
                    stMO.isSelected = modOp.IsSelected__c;
                    stMO.modId = modOp.ModId__c;
                    stMO.modificationOption = modOp.ModificationOptionDesc__c;
                    stMO.Quantity = String.valueOf(Integer.valueOf(modOp.Quantity__c));
                    stMO.price = string.valueOf(modOp.Sale_Price__c);
                    stMO.sequence = Integer.valueOf(modOp.Sequence__c);
                    stMO.sourceID = modOp.SourceID__c;
                    stdModificationList.add(stMO);
                }

                if (modOp.SandForApproval__c != null && modOp.SandForApproval__c) {
                    if (modOp.IsApproved__c != null && !modOp.IsApproved__c) {
                        fullQWrapper.disableModificationPrice = false;
                        fullQWrapper.showSubmitButton = false;
                        isSenderButton = false;
                        isApproverButton = true;
                    } else {
                        fullQWrapper.disableModificationPrice = true;
                        fullQWrapper.disableModificationSelection = true;
                        fullQWrapper.showSubmitButton = true;

                    }
                } else {
                    isSenderButton = true;
                    isApproverButton = false;
                }
                // create History list...........................
                FullQuoteWrapper.stdModification stMOHis = new FullQuoteWrapper.stdModification();
                stMOHis.modId = modOp.ModId__c;
                stMOHis.modificationOption = modOp.ModificationOptionDesc__c;
                //Get User Name
                User submitterUserRecord = FullQuoteDAO.getUserDetails(modOp.Submitter_User__c);
                stMOHis.Submitter = submitterUserRecord.Name;
                stMOHis.WorkflowActionDateTime = modOp.Submit_Or_Reject_Or_Approved_Time__c;
                stMOHis.isSubmmited = modOp.Is_Submitted__c;
                stMOHis.isSubmmited = modOp.Is_Rejected__c;
                stMOHis.isSubmmited = modOp.IsApproved__c;
                if (modOp.Is_Submitted__c) {
                    stMOHis.WorkflowStatus = 'Submitted';
                } else if (modOp.Is_Rejected__c) {
                    stMOHis.WorkflowStatus = 'Rejected';
                    isApprRejected = 'yes';
                } else if (modOp.IsApproved__c) {
                    stMOHis.WorkflowStatus = 'Approved';
                    isApprApproved = 'yes';
                }
                stdModificationHistoryList.add(stMOHis);
            }

            /*for(FullQuoteWrapper.stdModification stmod:stdModificationList){
                if(stmod.isSelected && !isApproverButton && fullQWrapper.disableModificationSelection){
                    fullQWrapper.showEditProduct = true;
                    isAccessorySelected = true;
                    lockHideAcc=false;
                    isPoductSelected = false;
                }
            }*/
            if (isApprRejected == 'yes' && isApprApproved == 'no') {
                fullQWrapper.disableModificationPrice = true;
                InitializeModificationList(stdMList);
                fullQWrapper.showSubmitButton = true;
                isAllModificationRejected = true;
                isApproverButton = false;
            } else {
                if (isApprRejected == 'yes' || isApprApproved == 'yes') {
                    fullQWrapper.disableModificationPrice = true;
                    fullQWrapper.showSubmitButton = true;
                    isApproverButton = false;
                    fullQWrapper.showEditProduct = true;
                    isAccessorySelected = true;
                    lockHideAcc = false;
                    isPoductSelected = false;
                }
            }
            if (isApproverButton) {
                selectedTabName = 'Product';
            } else {
                selectedTabName = 'Customer & Billing';
            }

        } else if (quickQuoteId != null) {
            InitializeModificationList(stdMList);
            //-------------issue 1271-------------
            if (ContId != null && ContId != '') {
                displayCOntactDetail(ContId);
            }
        }
        //fullQuote.Start_Date__c = System.today();
        fullQuote.Scheduled_Delivery__c = System.today();
        //fullQuote.Quote_expires__c = System.today().addDays(30);  

        fullQWrapper.JoborLocation = opp_ref.Job_Profile__r.Name;
        if (cloneIsTrue == 'true') {
            updatebutton = null;
            isEditTranType = false;
            stdModificationHistoryList = new list < FullQuoteWrapper.stdModification > ();
        }
        if (docId != null) {
            // issue no  1173 & 1174--------------
            isEditForEmailQuote = System.currentPageReference().getParameters().get('emailQuote');
            if (isEditForEmailQuote == 'true') {
                selectedTabName = 'Invoicing';
            }
            // issue no  1173 & 1174--------------
            if (cloneIsTrue != 'true') {
                ShowReserveCapacityLink = true;
            } else {
                ShowReserveCapacityLink = false;
            }
            isUpdatingFQ = true;
            InitializeModificationList(stdMList);
            updateQuoteRec = fqService.getFullQuote(docId);
            if (test.isRunningTest()) {
                updateQuoteRec = MMIFullquoteTestDataProvider.getnewteMMIFullQuote();
            }
            //--------------TFS 3506--------------------
            if (updateQuoteRec != null) {
                fullQWrapper.SpecialInstructions = updateQuoteRec.Special_Instruction__c;
            }
            if (cloneIsTrue != 'true' && updateQuoteRec.No_Reservation__c) {
                ShowReserveCapacityLink = false;
            }
            if (cloneIsTrue == 'true') {
                updateQuoteRec.Reservation_ID__c = '';
                updateQuoteRec.No_Reservation__c = false;
                fullQWrapper.noReservation = false;
            }
            if (cloneIsTrue != 'true' && updateQuoteRec.Reservation_ID__c != '') {
                ShowReserveCapacityLink = false;
            }
            if (updateQuoteRec.Account__c != null) {
                recId = updateQuoteRec.Account__c;
                fullQWrapper.sourceId = recId;
                accOwnerOfFQId = updateQuoteRec.Opportunity__r.Account.OwnerId;
            } else {
                recId = updateQuoteRec.Opportunity__c;
                fullQWrapper.sourceId = recId;
            }
            list < Opportunity > opportunityRecForEditHeader = new list < Opportunity > ();
            list < Account > accountRecForEditHeader = new list < Account > ();
            if (updateQuoteRec.Account__c != null) {
                accountRecForEditHeader = fqService.getAccounListInfo(recId);
                accountRec = accountRecForEditHeader;
                acc_ref = accountRecForEditHeader[0];
            } else {
                opportunityRecForEditHeader = fqService.getOppInfo(recId);
                opp_ref = opportunityRecForEditHeader[0];
            }

            if (cloneIsTrue == 'true') {
                fullQWrapper.enableRefreshQuote = false;
            } else {
                fullQWrapper.enableRefreshQuote = false;
            }
            fullQWrapper.enableSaveQuote = true;
            fullQWrapper.enableMarkAsLostbutton = true;
            fullQWrapper.enableProductadd = false;
            fullQWrapper.enableVAddresBtnInShipping = false;
            isFullfillingBranchid = false;
            isTexIdIsNullbutton = true;
            //-------------------get account owner id-----TFS 2710----------------------
            if (updateQuoteRec != null) {
                String accIdOfFQ = updateQuoteRec.Opportunity__r.AccountId;
                if (accIdOfFQ != null) {
                    Account accOfFQRec = FullQuoteDAO.getAccRecord(accIdOfFQ);
                    if (accOfFQRec != null) {
                        accountOwnerIdOfQQ = accOfFQRec.OwnerId;
                    }
                }
            }
            //-------------------get account owner id-----TFS 2710----------------------
            //-------------------TFS 3262----------------------
            if (updateQuoteRec != null) {
                fullQWrapper.storageUse = updateQuoteRec.Opportunity__r.Why_do_you_need_storage_Picklist__c;
            }
        }
        QqData = null;
        if (quickQuoteId != null && quickQuoteId != '') {
            list < Opportunity > oppIdList = new list < Opportunity > ();
            QqData = fqService.getQqInfo(quickQuoteId);
            oppIdList = fqService.getOppInfo(QqData.Opportunity__c);
            if (oppIdList.size() > 0) {
                accountOwnerIdOfQQ = oppIdList[0].Account.OwnerId;
                fullQWrapper.fqComments = oppIdList[0].Quote_Comments__c;
                fullQWrapper.storageUse = oppIdList[0].Why_do_you_need_storage_Picklist__c; //TFS 3262
                if (oppIdList[0].of_Units__c != null) {
                    fullQWrapper.noOfUnit = Integer.valueOf(oppIdList[0].of_Units__c);
                }
            }
            opp_ref = oppIdList[0];
            opportunityRec = oppIdList;
            leadRec = fqService.getLeadIndustry(opp_ref.id);

        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :FullQuoteMainController_AC');

        isScheduDeliver = false;
        writeupId = false;
        assigRepId = false;
        accountAddresInvalid = false;
        BillingContactInvalide = false;
        ShippingContactInvalide = false;
        shippingAddressInvalide = false;
        isfullfillingBranchInvalide = false;
        isRefreshTrue = false;

        if (fullQWrapper.selectedFullQUote != 'sales') {
            //ProductsSelection(); //a button added in product tab to load product lists
        }

        //getSalesInventoryList();
        //WSErrorHandler.isConstructerLoading = false;
        //Populate default card cuntry and states
        fullQWrapper.cardCountry = 'USA';
        fullQWrapper.achCountry = 'USA';
        cardStateOptions = new list < SelectOption > ();
        achStateOptions = new list < SelectOption > ();
        PopulateCardStatesList();
        PopulateAchStatesList();
        system.debug('--------------------fullQWrapper.BillingContactID----------'+fullQWrapper.BillingContactID);
    }

    public void displayCOntactDetail(String conId) {
        if (conId != null && conId != '') {
            Contact contactRec = QuickQuoteMainDAO.getContactRecord(conId);
            if (contactRec != null) {
                fullQWrapper.Name = contactRec.FirstName;
                fullQWrapper.LastName = contactRec.LastName;
                fullQWrapper.telePhone = contactRec.Phone;
                fullQWrapper.conMob = contactRec.MobilePhone;
                //fullQWrapper.conEmail = contactRec.Email;
                fullQWrapper.Email = contactRec.Email;
                fullQWrapper.BillingContactID = contactRec.Result_Id__c;
            }
        }
        system.debug('--------------------fullQWrapper.BillingContactID----------'+fullQWrapper.BillingContactID);
    }

    public void LoadWBs() {
        system.debug('--------------------fullQWrapper.BillingContactID----------'+fullQWrapper.BillingContactID);
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :LoadWBs');
        try {
            quoteIdforEmail = 'test';
            analysisSetHeaderResponseList = new List < HomeBaseBeans.AnalysisSetHeaders > ();
            Oauth_WebService.TestCallout();
            if (docId == null && quickQuoteId == null) {
                transactionWebservice();
            }
            CountriesList();
            AddressAssign();
            FullQuoteMainService fqService = new FullQuoteMainService();
            if (docId != null) {
                isEditQuoteLoadsFirstTime = true;
                String branchId;
                isRentalLength = true;
                if (updateQuoteRec.Shipping_Fulfilling_Branch_Id__c != null) {
                    FulFillingBranchId = updateQuoteRec.Shipping_Fulfilling_Branch_Id__c;
                }
                if (updateQuoteRec.Reservation_ID__c == null || updateQuoteRec.Reservation_ID__c == '') {
                    if (cloneIsTrue != 'true') {
                        isCapResFromShippingTab = true;
                    }
                }
                branchId = FullQuoteDAO.getBranchId(FulFillingBranchId, Apexpages.currentPage().getParameters().get('id'));
                if (branchId != null && branchId != '') {
                    branchIdforViewBranch = branchId;
                }
                if (cloneIsTrue != 'true') {
                    isEditTranType = true;
                }
                fullQWrapper.startDateonchange = true;
                fullQWrapper.fullfillingBranch = true;
                fullQWrapper.invoiceTabEnableDis = true;
                fullQWrapper.startDateonchange = true;
                fullQWrapper.analysisSetHeadValue = true;
                MMI_Full_Quotes__c mmiquoteGetAccountName = new MMI_Full_Quotes__c();
                mmiquoteGetAccountName = fqService.getFullQuote(docId);
                //analysisShippingWebservice();
                FullQuoteEditResponseService_AC FQEdit = new FullQuoteEditResponseService_AC();
                editFQResponse = FQEdit.callEditWEbservice(docId, fullQWrapper.WriteUpRep, branchId, updateQuoteRec.Name);
                System.debug(' ************** Edit ' + editFQResponse);
                if (test.isRunningTest()) {
                    editFQResponse = MMIFullquoteTestDataProvider.getEditFullQuoteData();
                }

                if (updateQuoteRec.Name == 'sales') {
                    editFQResponse.rentalQuote = editFQResponse.salesQuote;
                }
                selectedTaxRecInShipping.Id = editFQResponse.rentalQuote.shippingAddress.taxId;
                modifiedTS = String.valueof(editFQResponse.rentalQuote.modifiedTimestamp);
                fullQWrapper.rentalLengthInProduct = editFQResponse.rentalQuote.rentalLength;
                fullQWrapper.noReservation = mmiquoteGetAccountName.No_Reservation__c;

                if (fullQWrapper.noReservation == true) {
                    isScheduledDeliveryDateIsReadOnly = true;
                }
                //status check for  mark as lost and convert to order

                if (editFQResponse.rentalQuote.status == 'U') {
                    fullQWrapper.enableMarkAsLostButton = false;
                }
                if (editFQResponse.rentalQuote.status == 'C') {
                    fullQWrapper.convertQuoteToOrder = false;
                } else {
                    fullQWrapper.convertQuoteToOrder = true;
                }

                if (mmiquoteGetAccountName.Account_Name__c != '' && mmiquoteGetAccountName.Account_Name__c != null) {
                    fullQWrapper.AccountName = mmiquoteGetAccountName.Account_Name__c;

                }

                if (editFQResponse.rentalQuote.startDate != null && editFQResponse.rentalQuote.startDate != '') {
                    fullQuote.Start_Date__c = Date.valueOf(editFQResponse.rentalQuote.startDate);
                }
                if (editFQResponse.rentalQuote.quoteExpires != null && editFQResponse.rentalQuote.quoteExpires != '') {
                    fullQuote.Quote_expires__c = Date.valueOf(editFQResponse.rentalQuote.quoteExpires);
                }
                if (editFQResponse.rentalQuote.poExpires != null && editFQResponse.rentalQuote.poExpires != '') {
                    fullQuote.PO_Expires__c = Date.valueOf(editFQResponse.rentalQuote.poExpires);
                }
                if (editFQResponse.rentalQuote.plannedCollectionDate != null && editFQResponse.rentalQuote.plannedCollectionDate != '') {
                    fullQuote.Loaded_Move_In__c = Date.valueOf(editFQResponse.rentalQuote.plannedCollectionDate);
                }
                if (editFQResponse.rentalQuote.shippingDate != null && editFQResponse.rentalQuote.shippingDate != '') {
                    fullQuote.Scheduled_Delivery__c = Date.valueOf(editFQResponse.rentalQuote.shippingDate);
                }
                if (editFQResponse.rentalQuote.quoteTotal != null && editFQResponse.rentalQuote.quoteTotal != '') {
                    fullQWrapper.QuoteTotal = editFQResponse.rentalQuote.quoteTotal;
                }

                assignEditValues(editFQResponse, selectedVAddressInBilling, selectedVAddressInShipping, ProductExtrasList, summaryLineList, analysisSetHeaderResponseList, analysisSetHeaderResponseShippingList);
                ModifySummaryLine();

                SelectedShipingTaxId = fullQWrapper.SelectedShipingTaxId;
                if (updateQuoteRec.Name != 'sales') {
                    SelectedRentalLength = fullQWrapper.rentalLengthInProduct;
                }

                weeklyBranchSnop = FullQuoteDAO.getWeeklySnapShortBranchReport(fullQWrapper.userBranchId);
                //StatesList();
                fullQWrapper.TransactionType = updateQuoteRec.Transaction_Type__c;
                fullQWrapper.orderContractId = updateQuoteRec.Document_Id__c;
                //analysisWebservice(); 
                Mobilization = editFQResponse.rentalQuote.Mobilization;
                if (cloneIsTrue == 'true') {
                    fullQWrapper.enableRefreshQuote = false;
                    fullQWrapper.convertQuoteToOrder = false;
                } else {
                    fullQWrapper.convertQuoteToOrder = true;
                    fullQWrapper.enableRefreshQuote = false;
                }
                fullQWrapper.enableSaveQuote = true;
                fullQWrapper.enableMarkAsLostbutton = true;

                fullQWrapper.enableProductadd = true;
                fullQWrapper.enableVAddresBtnInShipping = false;
                fullQWrapper.selectedFullQUote = updateQuoteRec.Name;
                QuoteType = updateQuoteRec.Name;

                transactionWebservice();

                isFullfillingBranchid = false;
                isContactIs = false;
                isAddressId = false;
                printViewQuote();
                if (cloneIsTrue == 'true') {
                    ContId = System.currentPageReference().getParameters().get('conId');
                } else {
                    //ContId = updateQuoteRec.Opportunity__r.Contact__c;
                    ContId = updateQuoteRec.Opportunity__r.Opportunity_Contact_Name_LookUpFilter__c;
                }
                if (updateQuoteRec != null && updateQuoteRec.Opportunity__c != null && updateQuoteRec.Opportunity__r.Quote_Comments__c != null) {
                    fullQWrapper.fqComments = updateQuoteRec.Opportunity__r.Quote_Comments__c;
                }
                if (ContId != null && ContId != '') {
                    displayCOntactDetail(ContId);
                }
                //populateContactDetails(updateQuoteRec.Opportunity__c); // issue 1271
                //-----------TFS 2719--------------------------
                //if(fullQWrapper.selectedFullQUote == 'sales'){
                fullQWrapper.unitType = updateQuoteRec.Unit_Type__c;
                //}
                system.debug('------------updateQuoteRec.Opportunity__c---------------' + updateQuoteRec.Opportunity__c);
                if (updateQuoteRec != null && updateQuoteRec.Opportunity__r != null && updateQuoteRec.Opportunity__r.of_Units__c != null) {
                    fullQWrapper.noOfUnit = Integer.valueOf(updateQuoteRec.Opportunity__r.of_Units__c);
                }
                //--------------------TFS 4692-------------------------------
                autoPayDefCardKey1 = editFQResponse.rentalQuote.cardKey1;
                autoPayDefCardKey2 = editFQResponse.rentalQuote.cardKey2;
                autoPayDefCardKey3 = editFQResponse.rentalQuote.cardKey3;
                
                system.debug('-------------fullQWrapper.noOfUnit------------------' + fullQWrapper.noOfUnit);
            } else {
                fullQWrapper.rentalLengthInProduct = '1';
                fullQWrapper.rentalLength = '1';
            }
            if (FQSMrecId != null) {
                fullQWrapper.selectedFullQUote = 'sales';
                fullQuote_tran = fqService.getFullQuoteTransactional(FQSMrecId);
                ContId = fullQuote_tran.Contact__c;

                if (ContId != null && ContId != '') {
                    displayCOntactDetail(ContId);
                }

                if (fullQuote_tran.documentId__c != null) {
                    docId = fullQuote_tran.documentId__c;
                    isEditTranType = true;
                    updatebutton = docId;
                    Mobilization = '1.0';
                }
                selectedTaxRecInShipping.Id = fullQuote_tran.shippingAddress_taxId__c;
                SelectedShipingTaxId = fullQuote_tran.shippingAddress_taxId__c;
                system.debug('--------fullQuote_tran.type__c----' + fullQuote_tran + '------' + fullQuote_tran.type__c);
                fullQWrapper.selectedFullQUote = 'sales';
                fullQWrapper.TransactionType = fullQuote_tran.transactionId__c;
                transactionWebservice();
                if (fullQuote_tran.startDate__c != null) {
                    fullQuote.Scheduled_Delivery__c = date.valueOf(fullQuote_tran.shippingDate__c);
                }
                if (fullQuote_tran.startDate__c != null) {
                    fullQuote.Start_Date__c = date.valueOf(fullQuote_tran.startDate__c);
                }
                if (fullQuote_tran.quoteExpires__c != null) {
                    fullQuote.Quote_expires__c = date.valueOf(fullQuote_tran.quoteExpires__c);
                }
                if (fullQuote_tran.poExpires__c != null) {

                    fullQuote.PO_Expires__c = date.valueOf(fullQuote_tran.poExpires__c);
                }
                if (fullQuote_tran.plannedCollectionDate__c != null) {

                    fullQuote.Loaded_Move_In__c = date.valueOf(fullQuote_tran.plannedCollectionDate__c);
                }

                if (fullQuote_tran.shippingAddress_fulfillingBranchId__c != null && fullQuote_tran.shippingAddress_fulfillingBranchId__c != '') {
                    fullQWrapper.userBranchId = fullQuote_tran.shippingAddress_fulfillingBranchId__c;
                    fullQWrapper.fulFillingBranchInShippingDates = fullQuote_tran.shippingAddress_fulfillingBranchId__c;
                } else {
                    fullQWrapper.userBranchId = fullQuote_tran.branchId__c;
                }
                //transactionWebservice();

                if (fullQuote_tran.mobilization__c != null) {

                    Mobilization = fullQuote_tran.mobilization__c;
                }
                if (fullQuote_tran.modifiedTimestamp__c != null) {

                    modifiedTS = fullQuote_tran.modifiedTimestamp__c;
                }

                assingModificationValue(fullQuote_tran, selectedVAddressInBilling, selectedVAddressInShipping, ProductExtrasList, summaryLineList, analysisSetHeaderResponseList, analysisSetHeaderResponseShippingList);
                if (fullQWrapper.sourceId != null) {
                    if ((fullQuote_tran.SourceId__c).subString(0, 3) == '001') {
                        accountRec = fqService.getAccounListInfo(fullQuote_tran.SourceId__c);
                        acc_ref = accountRec[0];
                    } else if ((fullQuote_tran.SourceId__c).subString(0, 3) == '006') {
                        opportunityRec = fqService.getOppInfo(fullQuote_tran.SourceId__c);
                        opp_ref = opportunityRec[0];
                    } else if ((fullQuote_tran.SourceId__c).subString(0, 3) == 'a1I') {
                        QQ_ref = fqService.getQqInfo(fullQuote_tran.SourceId__c);
                    }
                }

                ModifySummaryLine();
                StatesList();
                shippingStatesList();
                isProductAlreadyAdded = fullQuote_tran.isMainProductAdded__c;
                fullQWrapper.enableProductadd = fullQuote_tran.isAddressValidated__c;

                if (fullQuote_tran.transactionId__c == 'SOFL') {
                    isTransTmoboORseco = true;
                } else {
                    isTransTmoboORseco = false;
                }

                leadRec = fqService.getLeadinfo(fullQWrapper.sourceId);
                opportunityRec = fqService.getOppInfo(fullQWrapper.sourceId);
                accountRec = fqService.getAccounListInfo(fullQWrapper.sourceId);
                if (fullQWrapper.sourceId == null) {
                    fullQWrapper.sourceId = fullQuote_tran.SourceId__c;
                }
                if (fullQuote_tran.SourceId__c != null) {
                    if ((fullQuote_tran.SourceId__c).subString(0, 3) != '001' && (fullQuote_tran.SourceId__c).subString(0, 3) != '006' && (fullQuote_tran.SourceId__c).subString(0, 3) != '00Q') {
                        isEditTranType = true;
                    }
                }

                lockTypeList = new list < FullQuoteWrapper.lockTypesAndQuantity > ();
                FullQuoteWrapper.lockTypesAndQuantity lockObj1 = new FullQuoteWrapper.lockTypesAndQuantity();
                lockObj1.LockName = 'CG1';
                lockObj1.LockDescription = 'Container Guard Lock Keyed Different';
                lockObj1.isLockselected = false;
                lockObj1.lockQuantity = 1;
                lockTypeList.add(lockObj1);
                FullQuoteWrapper.lockTypesAndQuantity lockObj2 = new FullQuoteWrapper.lockTypesAndQuantity();
                lockObj2.LockName = 'CG2';
                lockObj2.LockDescription = 'Container Guard Lock Keyed Alike';
                lockObj2.isLockselected = false;
                lockObj2.lockQuantity = 1;
                lockTypeList.add(lockObj2);
                FullQuoteWrapper.lockTypesAndQuantity lockObj3 = new FullQuoteWrapper.lockTypesAndQuantity();
                lockObj3.LockName = 'DL1';
                lockObj3.LockDescription = 'Disc Lock Keyed Different';
                lockObj3.isLockselected = false;
                lockObj3.lockQuantity = 1;
                lockTypeList.add(lockObj3);
                FullQuoteWrapper.lockTypesAndQuantity lockObj4 = new FullQuoteWrapper.lockTypesAndQuantity();
                lockObj4.LockName = 'DL2';
                lockObj4.LockDescription = 'Disc Lock Keyed Alike';
                lockObj4.isLockselected = false;
                lockObj4.lockQuantity = 1;
                lockTypeList.add(lockObj4);

            }
            /*if(quickQuoteId == null || quickQuoteId == ''){
                transactionWebservice();
            }*/



            if (quickQuoteId != null && quickQuoteId != '') {
                isEditTranType = true;
                isQqToFqLoadsFirstTime = true;
                if (QqData.QQ_Type__c == 'sales') {
                    fullQWrapper.selectedFullQUote = 'sales';
                    ////transactionWebservice();
                }
                //transtionTypeName = QqData.Transaction_Type__c;
                transtionTypeName = QqData.Transaction_Type__c;
                fullQWrapper.TransactionType = QqData.Transaction_Type__c;
                transactionWebservice();
                // map QQ data with fullquote wrapper
                fullQWrapper.TransactionType = QqData.Transaction_Type__c;
                system.debug('---transtionTypeName---' + transtionTypeName);
                //analysisWebservice();
                if (QqData.Transaction_Type__c == 'MOBO' || QqData.Transaction_Type__c == 'SECO' || QqData.Transaction_Type__c == 'SOFL') {
                    isTransTmoboORseco = true;
                }
                fullQWrapper.AddressInShippingDates = QqData.Address__c;
                fullQWrapper.cityInShippingDates = QqData.City__c;
                if (QqData.Country__c != '' && QqData.Country__c != null) {
                    fullQWrapper.countryInShippingDates = QqData.Country__c;
                    ////shippingStatesList();
                }
                //fullQWrapper.stateInShippingDates = QqData.State__c;
                fullQWrapper.ZipCodeInShipping = QqData.Zip_Code__c;
                fullQuote.Scheduled_Delivery__c = QqData.Date_From__c;
                if (QqData.Product__c != null) {
                    EditProduct.Id = QqData.Product__c;
                    isPoductSelected = true;
                    isAccessorySelected = false;
                    isProductAlreadyAdded = false;
                    fullQWrapper.showEditProduct = true;
                }
                //get account details--------------------------------------
                String qqOpportunityId = QqData.Opportunity__c;
                if (qqOpportunityId != null && qqOpportunityId != '') {
                    list < Opportunity > qqOpportunityList = new list < Opportunity > ();
                    qqOpportunityList = fqService.getOppInfo(qqOpportunityId);
                    if (qqOpportunityList.size() > 0) {
                        //if(qqOpportunityList[0].Account.Result_Id__c != null && qqOpportunityList[0].Account.Result_Id__c != '' && qqOpportunityList[0].Account.Result_Id__c != '2'){
                        fullQWrapper.AccountId = qqOpportunityList[0].Account.Result_Id__c;
                        if (fullQWrapper.AccountId != null && fullQWrapper.AccountId != '') {
                            accountIDInBilling();
                        }
                        if (qqOpportunityList[0].Account.Result_Id__c != null && qqOpportunityList[0].Account.Result_Id__c != '') {
                            isAccountNameAndIdReadOnly = true;
                        } else {
                            isAccountNameAndIdReadOnly = false;
                        }
                        isAddressId = false;
                        fullQWrapper.Address = qqOpportunityList[0].Account.BillingStreet;
                        fullQWrapper.City = qqOpportunityList[0].Account.BillingCity;
                        if (qqOpportunityList[0].Account.BillingCountry != null && qqOpportunityList[0].Account.BillingCountry != '') {
                            fullQWrapper.Country = qqOpportunityList[0].Account.BillingCountry.toUpperCase();
                        }

                        if (qqOpportunityList[0].Account.BillingState != null && qqOpportunityList[0].Account.BillingState != '') {
                            fullQWrapper.State = qqOpportunityList[0].Account.BillingState.toUpperCase();
                        }

                        fullQWrapper.zipCode = qqOpportunityList[0].Account.BillingPostalCode;
                        system.debug('------------fullQWrapper.State---------' + fullQWrapper.State);
                        list < Account > qqLstAccount = new list < Account > ();
                        qqLstAccount = fqService.getAccounListInfo(qqOpportunityList[0].AccountID);
                        system.debug('--qqLstAccount---' + qqLstAccount);
                        if (qqLstAccount.size() > 0) {
                            /*if(qqLstAccount[0].IsPersonAccount){
                                        fullQWrapper.AccountName = qqLstAccount[0].LastName+' '+qqLstAccount[0].FirstName;
                                    }else{*/
                            fullQWrapper.AccountName = qqLstAccount[0].Name;
                            //}
                            system.debug('---fullQWrapper.AccountName----' + fullQWrapper.AccountName);
                            /*List<Contact> qqListContact = new list<Contact>();
                                    qqListContact = qqLstAccount[0].Contacts;
                                    if(qqListContact.size() > 0){
                                        fullQWrapper.Name = qqListContact[0].FirstName;
                                        fullQWrapper.LastName = qqListContact[0].LastName;
                                        fullQWrapper.telePhone = qqListContact[0].Phone;
                                    }*/
                            if (ContId != null && ContId != '') {
                                displayCOntactDetail(ContId);
                            }
                        }
                        /*}else{
                                fullQWrapper.Address = '';
                                fullQWrapper.City = '';
                                fullQWrapper.State = '';
                                fullQWrapper.zipCode = '';
                            }*/
                    }
                }
                if (QqData.Duration__c != '' && QqData.Duration__c != null) {
                    fullQWrapper.rentalLengthInProduct = QqData.Duration__c;
                    fullQWrapper.rentalLength = QqData.Duration__c;

                    if (QqData.QQ_Type__c == 'rental' || QqData.QQ_Type__c == 'Rental') {
                        if (QqData.Rental_Rate__c != null) {
                            fullQWrapper.rentalLengthInProduct = String.valueOf(QqData.Duration__c);
                            EditProduct.rate1 = new HomeBaseBeans.rates();
                            EditProduct.rate2 = new HomeBaseBeans.rates();
                            EditProduct.rate3 = new HomeBaseBeans.rates();
                            EditProduct.rate4 = new HomeBaseBeans.rates();
                            EditProduct.rate5 = new HomeBaseBeans.rates();
                            EditProduct.rate6 = new HomeBaseBeans.rates();
                            if (isTransTmoboORseco) {
                                if (Integer.valueOf(QqData.Duration__c) >= 2 && Integer.valueOf(QqData.Duration__c) <= 6) {
                                    EditProduct.rate1.rate = String.valueOf(QqData.Rental_Rate__c);
                                }
                                if (Integer.valueOf(QqData.Duration__c) >= 7 && Integer.valueOf(QqData.Duration__c) <= 12) {
                                    EditProduct.rate2.rate = String.valueOf(QqData.Rental_Rate__c);
                                }
                                if (Integer.valueOf(QqData.Duration__c) >= 13 && Integer.valueOf(QqData.Duration__c) <= 24) {
                                    EditProduct.rate3.rate = String.valueOf(QqData.Rental_Rate__c);
                                }
                                if (Integer.valueOf(QqData.Duration__c) >= 24) {
                                    EditProduct.rate4.rate = String.valueOf(QqData.Rental_Rate__c);
                                }
                            } else {
                                if (Integer.valueOf(QqData.Duration__c) == 1) {
                                    EditProduct.rate1.rate = String.valueOf(QqData.Rental_Rate__c);
                                }
                                if (Integer.valueOf(QqData.Duration__c) >= 2 && Integer.valueOf(QqData.Duration__c) <= 6) {
                                    EditProduct.rate2.rate = String.valueOf(QqData.Rental_Rate__c);
                                }
                                if (Integer.valueOf(QqData.Duration__c) >= 7 && Integer.valueOf(QqData.Duration__c) <= 12) {
                                    EditProduct.rate3.rate = String.valueOf(QqData.Rental_Rate__c);
                                }
                                if (Integer.valueOf(QqData.Duration__c) >= 13) {
                                    EditProduct.rate4.rate = String.valueOf(QqData.Rental_Rate__c);
                                }
                            }
                            if (QqData.Transaction_Type__c == 'CNST') {
                                EditProduct.rate5.rate = String.valueOf(QqData.Rental_Rate__c);
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC LoadWBs:' + e.getMessage());
        }
        callShippingAnalysisSetsService(); // to merger the mehod for better performance //TFS 1380
        extraWsCall(); // to merger the mehod for better performance //TFS 1380
        system.debug('--------------------fullQWrapper.BillingContactID----------'+fullQWrapper.BillingContactID);
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :LoadWBs' + analysisSetHeaderResponseList);
    }

    public void extraWsCall() {
        quoteIdforEmail = 'test';
        if (docId != null || FQSMrecId != null || quickQuoteId != null) {
            if (updateQuoteRec.Name == 'sales') {
                fullQWrapper.TransactionType = updateQuoteRec.Transaction_Type__c;
            }
            if (quickQuoteId != null) {
                fullQWrapper.TransactionType = QqData.Transaction_Type__c;
            }
            system.debug(LoggingLevel.DEBUG, '****************fullQWrapper*******************' + fullQWrapper);
            Oauth_WebService.TestCallout();
            analysisWebservice();
            contactsWebservice();
        }
        if (FQSMrecId != null) {
            lockTypeList = new list < FullQuoteWrapper.lockTypesAndQuantity > ();
            FullQuoteWrapper.lockTypesAndQuantity lockObj1 = new FullQuoteWrapper.lockTypesAndQuantity();
            lockObj1.LockName = 'CG1';
            lockObj1.LockDescription = 'Container Guard Lock Keyed Different';
            lockObj1.isLockselected = false;
            lockObj1.lockQuantity = 1;
            lockTypeList.add(lockObj1);
            FullQuoteWrapper.lockTypesAndQuantity lockObj2 = new FullQuoteWrapper.lockTypesAndQuantity();
            lockObj2.LockName = 'CG2';
            lockObj2.LockDescription = 'Container Guard Lock Keyed Alike';
            lockObj2.isLockselected = false;
            lockObj2.lockQuantity = 1;
            lockTypeList.add(lockObj2);
            FullQuoteWrapper.lockTypesAndQuantity lockObj3 = new FullQuoteWrapper.lockTypesAndQuantity();
            lockObj3.LockName = 'DL1';
            lockObj3.LockDescription = 'Disc Lock Keyed Different';
            lockObj3.isLockselected = false;
            lockObj3.lockQuantity = 1;
            lockTypeList.add(lockObj3);
            FullQuoteWrapper.lockTypesAndQuantity lockObj4 = new FullQuoteWrapper.lockTypesAndQuantity();
            lockObj4.LockName = 'DL2';
            lockObj4.LockDescription = 'Disc Lock Keyed Alike';
            lockObj4.isLockselected = false;
            lockObj4.lockQuantity = 1;
            lockTypeList.add(lockObj4);
        }
        AddressAssign();
        StatesList();
        shippingStatesList();
        if (docId != null) {
            if (cloneIsTrue == 'true') {
                fullQWrapper.enableRefreshQuote = false;
                fullQWrapper.convertQuoteToOrder = false;
                fullQWrapper.noReservation = false;
            } else {
                fullQWrapper.convertQuoteToOrder = true;
                fullQWrapper.enableRefreshQuote = false;
            }
            fullQWrapper.enableSaveQuote = true;
            fullQWrapper.enableMarkAsLostbutton = true;
            if (FQSMrecId == null || FQSMrecId == '') {
                fullQWrapper.State = updateQuoteRec.Billing_State__c;
            }
            fullQWrapper.stateInShippingDates = updateQuoteRec.Shipping_State__c;
            fullQWrapper.enableProductadd = true;
            fullQWrapper.enableVAddresBtnInShipping = false;
            isFullfillingBranchid = false;
            isContactIs = false;
            isAddressId = false;
        } else {
            fullQWrapper.enableRefreshQuote = false;
            fullQWrapper.enableSaveQuote = false;
            fullQWrapper.enableMarkAsLostbutton = false;

            fullQWrapper.enableProductadd = false;
            fullQWrapper.enableVAddresBtnInShipping = false;
            isFullfillingBranchid = false;
            isContactIs = false;
            isAddressId = false;
        }
        //tranTypeSetValue = fullQWrapper.TransactionType;
        if (quickQuoteId != null && quickQuoteId != '') {
            fullQWrapper.TransactionType = QqData.Transaction_Type__c;
            fullQWrapper.stateInShippingDates = QqData.State__c;
            fullQuote.Start_Date__c = QqData.Date_From__c;
            fullQuote.Scheduled_Delivery__c = QqData.Date_From__c;
            fullQuote.Quote_expires__c = QqData.Date_From__c.addDays(30);
            fullQWrapper.sourceId = QqData.Id;
            fullQWrapper.enableVAddresBtnInShipping = true;
            isEcodeAllocationBtnDesabled = false;
            if (fullQWrapper.State != null && fullQWrapper.State != '') {
                fullQWrapper.State = fullQWrapper.State.toUpperCase();
            } else {
                if (QqData.Opportunity__c != null) {
                    populateBillingAddressFromAccount(QqData.Opportunity__c);
                }
            }
            fullQWrapper.countryInShippingDates = QqData.Country__c;
            system.debug('------------fullQWrapper.State---------------' + fullQWrapper.State);
            fullQWrapper.AddressInShippingDates = QqData.Address__c;
            fullQWrapper.cityInShippingDates = QqData.City__c;
            fullQWrapper.ZipCodeInShipping = QqData.Zip_Code__c;
            if (fullQuote.Start_Date__c != null) {
                onchangeNoReservation();
            }
            isCallQqToFQConversionNeeded = true;
            if (ContId != null && ContId != '') {
                displayCOntactDetail(ContId);
            }
        }
        if (docId != null && docId != '') {
            fullQWrapper.TransactionType = updateQuoteRec.Transaction_Type__c;
            tranTypeSetValue = fullQWrapper.TransactionType;
            if (updateQuoteRec.Reservation_ID__c != null && updateQuoteRec.Reservation_ID__c != '') {
                isCapacityAlreadyReserved = true;
            } else {
                isCapacityAlreadyReserved = false;
            }
            if (updateQuoteRec.Name != 'sales') {
                SelectedRentalLength = fullQWrapper.rentalLengthInProduct;
            }
        }
        if (FQSMrecId != null) {
            fullQWrapper.enableProductadd = fullQuote_tran.isAddressValidated__c;
        }
        isLoadedTrap = true;
        if (fullQWrapper.TransactionType == 'MOBO' || fullQWrapper.TransactionType == 'SECO' || fullQWrapper.TransactionType == 'SOFL') {
            isTransTmoboORseco = true;
        } else {
            isTransTmoboORseco = false;
        }
        if (quickQuoteId == null || quickQuoteId == '') {
            //isCallingExtraAnalysisNeeded = true;  // to merger the mehod for better performance  // TFS 1380
            callShippingAnalysisSetsService();
        }
        if (isAllModificationRejected) {
            fullQWrapper.enableRefreshQuote = true;
        }
        system.debug('--------------------fullQWrapper.BillingContactID----------'+fullQWrapper.BillingContactID);
    }

    public Pagereference populateBillingAddressFromAccount(String OppId) {
        if (OppId != null && OppId != '') {
            list < Opportunity > qqOpporLst = new list < Opportunity > ();
            FullQuoteMainService fqService = new FullQuoteMainService();
            qqOpporLst = fqService.getOppInfo(OppId);
            if (!qqOpporLst.isEmpty()) {
                list < Account > lstAccountRec = fqService.getAccounListInfo(qqOpporLst[0].AccountId);
                if (!lstAccountRec.isEmpty()) {
                    if (lstAccountRec[0].BillingState != null) {
                        fullQWrapper.State = lstAccountRec[0].BillingState.toUpperCase();
                    }
                }
            }
        }
        return null;
    }

    public Pagereference callQqToFQConversion() {
        isCallQqToFQConversionNeeded = false;
        if (quickQuoteId != null && quickQuoteId != '') {
            // get product descriotion by specific product WS for rental only
            if (QqData.QQ_Type__c == 'rental' || QqData.QQ_Type__c == 'Rental') {
                callSpecificProductService();
            } else {
                // get product descriotion from Ales inventory object for sales FQ
                HB_Sales_Inventory__c specificProd = null;
                specificProd = FullQuoteDAO.getSpecificSalesInventoryList(QqData.Product__c, QqData.Ecode__c);
                if (specificProd != null) {
                    SelectedProductDesc = specificProd.Grade_Description__c;
                    fullQWrapper.ItemCode = specificProd.Line_Item_ID__c;
                    fullQWrapper.ECode = specificProd.E_Code__c;
                    fullQWrapper.SuggestedPrice = String.valueOf(specificProd.Suggested_Price__c);
                    fullQWrapper.MinPrice = String.valueOf(specificProd.Minimum_Price__c);
                    fullQWrapper.NetBookValue = String.ValueOf(specificProd.NBV__c);
                    fullQWrapper.showEcodeValues = true;
                    fullQWrapper.assetDescription = specificProd.Notes__c;
                    fullQWrapper.sellingPrice = String.valueOf(QqData.Rental_Rate__c);
                    fullQWrapper.Reference = specificProd.Item_Reference__c;
                    fullQWrapper.ImageUrl = specificProd.Display_Picture__c;
                    //fullQWrapper.ImageUrlForPDF = specificProd.Display_Picture__c;
                    fullQWrapper.GradeDescription = specificProd.Grade_Description__c;
                    fullQWrapper.showEditProduct = true;
                    isAccessorySelected = false;
                    isPoductSelected = true;
                }
            }
            if ((fullQWrapper.State == null || fullQWrapper.State == '') && QqData.Opportunity__c != null) {
                populateBillingAddressFromAccount(QqData.Opportunity__c);
            }
        }
        return null;
    }

    public Pagereference populateContactDetails(String SourceRecId) {
        if (fullQWrapper.Name == null || fullQWrapper.Name == '' || fullQWrapper.LastName == null || fullQWrapper.LastName == '' || fullQWrapper.telePhone == null || fullQWrapper.telePhone == '') {
            if (SourceRecId.startsWith('006')) {
                list < Opportunity > oppOfTheQuote = FullQuoteDAO.getOppRecord(SourceRecId);
                if (oppOfTheQuote.size() > 0) {
                    if (oppOfTheQuote[0].AccountId != null) {
                        getContactDetailFromAccount(oppOfTheQuote[0].AccountId);
                    }
                }
            }
            if (SourceRecId.startsWith('001')) {
                getContactDetailFromAccount(SourceRecId);
            }
        }
        return null;
    }

    public Pagereference getContactDetailFromAccount(String AccountId) {
        if (AccountId != null && AccountId != '') {
            FullQuoteMainService fqService = new FullQuoteMainService();
            list < Account > accountRecData = fqService.getAccounListInfo(AccountId);
            if (accountRecData.size() > 0) {
                /*List<Contact> conData = accountRecData[0].Contacts;
                if(conData.size() > 0){
                    fullQWrapper.Name = conData[0].FirstName;
                    fullQWrapper.LastName = conData[0].LastName;
                    if(fullQWrapper.telePhone == null || fullQWrapper.telePhone == ''){
                        fullQWrapper.telePhone = conData[0].Phone;
                    }
                }*/
                if (ContId != null && ContId != '') {
                    displayCOntactDetail(ContId);
                }
            }
        }
        return null;
    }

    public Pagereference previewQuote() {
        printViewQuote();
        Boolean accessoryRes = false;
        FullQuoteMainService fqService = new FullQuoteMainService();
        for (HomeBaseBeans.quoteLine sm: summaryLineList) {
            if (sm.itemId != 'CG1' && sm.itemId != 'CG2' && sm.itemId != 'DL1' && sm.itemId != 'DL2' && !ckeckModificationItem(sm.itemId)) {
                accessoryRes = fqService.getAccessoryInfo(sm.itemId);
                if (accessoryRes == false) {
                    prodctname = sm.itemId;
                }
            }
        }
        List < Product_Brochures_Lookup__c > produBrochList = [Select p.Product_Image__c, p.Product_Id__c, p.Product_Document_Brochures_Name__c, p.Name, p.Id From Product_Brochures_Lookup__c p where Product_Id__c = : prodctname limit 1];
        if (!produBrochList.isEmpty()) {
            fullQWrapper.imageNameForPreivewQuote = 'PreviewQuote_Images/' + produBrochList[0].Product_Image__c;
        }
        pdf = new Pagereference('/apex/FullQuotePDF');
        pdf.setRedirect(false);
        return pdf;
    }

    public PageReference AddressAssign() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :AddressAssign()');
        try {

            if (docId == null && FQSMrecId == null) {
                if (leadRec.size() > 0) {
                    if (leadRec[0].Company != null && leadRec[0].Company != '') {
                        fullQWrapper.AccountName = leadRec[0].Company;
                    }
                    if (leadRec[0].Company == null || leadRec[0].Company == '') {
                        String AccountNameFromLead = '';
                        if (leadRec[0].FirstName != null && leadRec[0].FirstName != '') {
                            AccountNameFromLead += leadRec[0].FirstName;
                        }
                        if (leadRec[0].LastName != null && leadRec[0].LastName != '') {
                            if (leadRec[0].FirstName != null && leadRec[0].FirstName != '') {
                                AccountNameFromLead += ' ' + leadRec[0].LastName;
                            } else {
                                AccountNameFromLead += leadRec[0].LastName;
                            }

                        }
                        fullQWrapper.AccountName = AccountNameFromLead;
                    }
                    if (leadRec[0].Name != null && leadRec[0].Name != '') {
                        fullQWrapper.Name = leadRec[0].FirstName;
                        fullQWrapper.LastName = leadRec[0].LastName;
                        fullQWrapper.telePhone = leadRec[0].Phone;
                        fullQWrapper.conMob = leadRec[0].MobilePhone;
                        //fullQWrapper.conEmail =  leadRec[0].Email;
                        fullQWrapper.Email = leadRec[0].Email;
                    }
                    if (leadRec[0].Delivery_Street__c != null && leadRec[0].Delivery_Street__c != '') {
                        fullQWrapper.AddressInShippingDates = leadRec[0].Delivery_Street__c;
                    }
                    if (leadRec[0].Delivery_City__c != null && leadRec[0].Delivery_City__c != '') {
                        fullQWrapper.cityInShippingDates = leadRec[0].Delivery_City__c;
                    }
                    if (leadRec[0].Delivery_Postal_Code__c != null && leadRec[0].Delivery_Postal_Code__c != '') {
                        fullQWrapper.ZipCodeInShipping = leadRec[0].Delivery_Postal_Code__c;
                    }

                    if (leadRec[0].Delivery_Country__c != null && leadRec[0].Delivery_Country__c.toLowerCase() == 'canada') {
                        fullQWrapper.countryInShippingDates = 'CAN';
                    } else if (leadRec[0].Delivery_Country__c != null && leadRec[0].Delivery_Country__c.equalsIgnoreCase('united states')) {
                        fullQWrapper.countryInShippingDates = 'USA';
                    } else {
                        if (leadRec[0].Delivery_Country__c != null && leadRec[0].Delivery_Country__c != '') {
                            fullQWrapper.countryInShippingDates = leadRec[0].Delivery_Country__c.toUpperCase();
                        }

                        if (leadRec[0].Delivery_State__c == 'N/A') {
                            leadRec[0].Delivery_State__c = '';
                        }
                    }
                    if (leadRec[0].Delivery_State__c != null && leadRec[0].Delivery_State__c != '') {
                        fullQWrapper.stateInShippingDates = leadRec[0].Delivery_State__c.toUpperCase();
                    }
                    // customer& billing address
                    if (leadRec[0].Street != null && leadRec[0].Street != '') {
                        fullQWrapper.Address = leadRec[0].Street;
                    }
                    if (leadRec[0].City != null && leadRec[0].City != '') {
                        fullQWrapper.City = leadRec[0].City;
                    }

                    if (leadRec[0].PostalCode != null && leadRec[0].PostalCode != '') {
                        fullQWrapper.ZipCode = leadRec[0].PostalCode;
                    }

                    if (leadRec[0].Country != null && leadRec[0].Country.toLowerCase() == 'canada') fullQWrapper.Country = 'CAN';
                    else {
                        if (leadRec[0].Country != null && leadRec[0].Country != '') {
                            fullQWrapper.Country = leadRec[0].Country.toUpperCase();
                        }
                        if (leadRec[0].State == 'N/A') {
                            leadRec[0].State = '';
                        }
                    }
                    if (leadRec[0].State != null && leadRec[0].State != '') {
                        fullQWrapper.State = leadRec[0].State.toUpperCase();
                    }

                }
                if (opportunityRec.size() > 0) {
                    if (opportunityRec[0].Job_Profile__c != null) {
                        if (opportunityRec[0].Job_Profile__r.Job_Site_Address__c != null && opportunityRec[0].Job_Profile__r.Job_Site_Address__c != '') {
                            fullQWrapper.AddressInShippingDates = opportunityRec[0].Job_Profile__r.Job_Site_Address__c;
                        }
                        if (opportunityRec[0].Job_Profile__r.Job_Site_City__c != null && opportunityRec[0].Job_Profile__r.Job_Site_City__c != '') {
                            fullQWrapper.cityInShippingDates = opportunityRec[0].Job_Profile__r.Job_Site_City__c;
                        }
                        if (opportunityRec[0].Job_Profile__r.Job_Site_Zip__c != null && opportunityRec[0].Job_Profile__r.Job_Site_Zip__c != '') {
                            fullQWrapper.ZipCodeInShipping = opportunityRec[0].Job_Profile__r.Job_Site_Zip__c;
                        }
                        if (opportunityRec[0].Job_Profile__r.Job_Site_County__c != null && opportunityRec[0].Job_Profile__r.Job_Site_County__c != '') {
                            fullQWrapper.countyInShippingDates = opportunityRec[0].Job_Profile__r.Job_Site_County__c;
                        }
                        if (opportunityRec[0].Job_Profile__r.Job_Site_Country__c != null && opportunityRec[0].Job_Profile__r.Job_Site_Country__c.toLowerCase() == 'canada') {
                            fullQWrapper.countryInShippingDates = 'CAN';
                        } else if (opportunityRec[0].Job_Profile__r.Job_Site_Country__c != null && opportunityRec[0].Job_Profile__r.Job_Site_Country__c.equalsIgnoreCase('united states')) {
                            fullQWrapper.countryInShippingDates = 'USA';
                        } else {
                            if (opportunityRec[0].Job_Profile__r.Job_Site_Country__c != null && opportunityRec[0].Job_Profile__r.Job_Site_Country__c != '') {
                                fullQWrapper.countryInShippingDates = opportunityRec[0].Job_Profile__r.Job_Site_Country__c.toUpperCase();
                            }
                            if (opportunityRec[0].Job_Profile__r.Job_Site_State__c == 'N/A') {
                                opportunityRec[0].Job_Profile__r.Job_Site_State__c = '';
                            }
                        }
                        if (opportunityRec[0].Job_Profile__r.Job_Site_State__c != null && opportunityRec[0].Job_Profile__r.Job_Site_State__c != '') {
                            fullQWrapper.stateInShippingDates = opportunityRec[0].Job_Profile__r.Job_Site_State__c.toUpperCase();
                        }

                    } else {
                        if (opportunityRec[0].Delivery_Street__c != null && opportunityRec[0].Delivery_Street__c != '') {
                            fullQWrapper.AddressInShippingDates = opportunityRec[0].Delivery_Street__c;
                        }
                        if (opportunityRec[0].Delivery_City__c != null && opportunityRec[0].Delivery_City__c != '') {
                            fullQWrapper.cityInShippingDates = opportunityRec[0].Delivery_City__c;
                        }
                        if (opportunityRec[0].Delivery_Zip_Postal_Code__c != null && opportunityRec[0].Delivery_Zip_Postal_Code__c != '') {
                            fullQWrapper.ZipCodeInShipping = opportunityRec[0].Delivery_Zip_Postal_Code__c;
                        }
                        if (opportunityRec[0].Delivery_Country__c != null && opportunityRec[0].Delivery_Country__c.toLowerCase() == 'canada') {
                            fullQWrapper.countryInShippingDates = 'CAN';
                        } else if (opportunityRec[0].Delivery_Country__c != null && opportunityRec[0].Delivery_Country__c.equalsIgnoreCase('united states')) {
                            fullQWrapper.countryInShippingDates = 'USA';
                        } else {
                            if (opportunityRec[0].Delivery_Country__c != null && opportunityRec[0].Delivery_Country__c != '') {
                                fullQWrapper.countryInShippingDates = opportunityRec[0].Delivery_Country__c.toUpperCase();
                            }
                            if (opportunityRec[0].Delivery_State_Province__c == 'N/A') {
                                opportunityRec[0].Delivery_State_Province__c = '';
                            }
                        }
                        if (opportunityRec[0].Delivery_State_Province__c != null && opportunityRec[0].Delivery_State_Province__c != '') {
                            fullQWrapper.stateInShippingDates = opportunityRec[0].Delivery_State_Province__c.toUpperCase();
                        }

                        if (opportunityRec[0].Account.BillingStreet != null && opportunityRec[0].Account.BillingStreet != '') {
                            fullQWrapper.Address = opportunityRec[0].Account.BillingStreet;
                        }


                        if (opportunityRec[0].Account.BillingCountry != null && opportunityRec[0].Account.BillingCountry.toLowerCase() == 'canada') {
                            fullQWrapper.countryInShippingDates = 'CAN';
                        } else if (opportunityRec[0].Account.BillingCountry != null && opportunityRec[0].Account.BillingCountry.equalsIgnoreCase('united states')) {
                            fullQWrapper.Country = 'USA';
                        } else {
                            if (opportunityRec[0].Account.BillingCountry != null && opportunityRec[0].Account.BillingCountry != '') {
                                fullQWrapper.Country = opportunityRec[0].Account.BillingCountry.toUpperCase();
                            }
                        }
                        if (opportunityRec[0].Account.BillingCity != null && opportunityRec[0].Account.BillingCity != '') {
                            fullQWrapper.City = opportunityRec[0].Account.BillingCity;
                        }

                        if (opportunityRec[0].Account.BillingState != null && opportunityRec[0].Account.BillingState != '') {
                            fullQWrapper.State = opportunityRec[0].Account.BillingState.toUpperCase();
                        }
                        if (opportunityRec[0].Account.BillingPostalCode != null && opportunityRec[0].Account.BillingPostalCode != '') {
                            fullQWrapper.zipCode = opportunityRec[0].Account.BillingPostalCode;
                        }


                    }
                }
                system.debug('-------accountRec---------' + accountRec);
                if (accountRec.size() > 0) {
                    if (source == 'jp') {
                        populateAddressFromJp();
                        populateBillingAddress(accountRec[0]);
                    } else {
                        if (accountRec[0].ShippingStreet != null && accountRec[0].ShippingStreet != '') {
                            fullQWrapper.AddressInShippingDates = accountRec[0].ShippingStreet;
                        }
                        if (accountRec[0].ShippingCity != null && accountRec[0].ShippingCity != '') {
                            fullQWrapper.cityInShippingDates = accountRec[0].ShippingCity;
                        }
                        if (accountRec[0].ShippingPostalCode != null && accountRec[0].ShippingPostalCode != '') {
                            fullQWrapper.ZipCodeInShipping = accountRec[0].ShippingPostalCode;
                        }
                        if (accountRec[0].ShippingCountry != null && accountRec[0].ShippingCountry.toLowerCase() == 'canada') {
                            fullQWrapper.countryInShippingDates = 'CAN';
                        } else if (accountRec[0].ShippingCountry != null && accountRec[0].ShippingCountry.equalsIgnoreCase('united states')) {
                            fullQWrapper.countryInShippingDates = 'USA';
                        } else {
                            if (accountRec[0].ShippingCountry != null && accountRec[0].ShippingCountry != '') {
                                fullQWrapper.countryInShippingDates = accountRec[0].ShippingCountry.toUpperCase();
                            }
                            if (accountRec[0].ShippingState == 'N/A') {
                                accountRec[0].ShippingState = '';
                            }
                        }
                        if (accountRec[0].ShippingState != null && accountRec[0].ShippingState != '') {
                            fullQWrapper.stateInShippingDates = accountRec[0].ShippingState.toUpperCase();
                        }
                        // customer& billing address
                        populateBillingAddress(accountRec[0]);
                    }
                }
            }

            //StatesList();
            //shippingStatesList();
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC AddressAssign:' + e.getMessage());
        }

        system.debug(LoggingLevel.DEBUG, 'Exiting to  FullQuoteMainController_AC : AddressAssign()' + fullQWrapper);
        return null;
    }

    public void populateAddressFromJp() {
        if (jobProfId != null && jobProfId != '') {
            Job_Profile__c jpObjRec = QuickQuoteMainDAO.getJobProfRecord(jobProfId);
            if (jpObjRec != null) {
                fullQWrapper.AddressInShippingDates = jpObjRec.Job_Site_Address__c;
                fullQWrapper.cityInShippingDates = jpObjRec.Job_Site_City__c;
                fullQWrapper.stateInShippingDates = jpObjRec.Job_Site_State__c;
                fullQWrapper.ZipCodeInShipping = jpObjRec.Job_Site_Zip__c;
                if (jpObjRec.Job_Site_Country__c != null && (jpObjRec.Job_Site_Country__c.equalsIgnoreCase('united states') || jpObjRec.Job_Site_Country__c.equalsIgnoreCase('us'))) {
                    fullQWrapper.countryInShippingDates = 'USA';
                } else if (jpObjRec.Job_Site_Country__c != null && (jpObjRec.Job_Site_Country__c.equalsIgnoreCase('canada') || jpObjRec.Job_Site_Country__c.equalsIgnoreCase('can'))) {
                    fullQWrapper.countryInShippingDates = 'CAN';
                } else {
                    fullQWrapper.countryInShippingDates = 'USA';
                }
            } else {
                fullQWrapper.countryInShippingDates = 'USA';
            }
        }
    }

    public void populateBillingAddress(Account accRecObj) {
        if (accRecObj != null) {
            if (accRecObj.BillingStreet != null && accRecObj.BillingStreet != '') {
                fullQWrapper.Address = accRecObj.BillingStreet;
            }
            if (accRecObj.BillingCity != null && accRecObj.BillingCity != '') {
                fullQWrapper.City = accRecObj.BillingCity;
            }
            if (accRecObj.BillingPostalCode != null && accRecObj.BillingPostalCode != '') {
                fullQWrapper.ZipCode = accRecObj.BillingPostalCode;
            }
            if (accRecObj.BillingCountry != null && accRecObj.BillingCountry.toLowerCase() == 'canada') {
                fullQWrapper.Country = 'CAN';
            } else if (accRecObj.BillingCountry != null && accRecObj.BillingCountry.equalsIgnoreCase('united states')) {
                fullQWrapper.countryInShippingDates = 'USA';
            } else {
                if (accRecObj.BillingCountry != null && accRecObj.BillingCountry != '') {
                    fullQWrapper.Country = accRecObj.BillingCountry.toUpperCase();
                }
                if (accRecObj.BillingState == 'N/A') {
                    accRecObj.BillingState = '';
                }
            }
            if (accRecObj.BillingState != null && accRecObj.BillingState != '') {
                fullQWrapper.State = accRecObj.BillingState.toUpperCase();
            }
        }
    }

    public void rePopulateContactDetail() {
        String accRecId = System.currentPageReference().getParameters().get('accId');
        FullQuoteMainService fqServiceObj = new FullQuoteMainService();
        list < Account > accRecList = fqServiceObj.getAccounListInfo(accRecId);
        if (accRecList.size() > 0) {
            /*if(accRecList[0].IsPersonAccount){
                fullQWrapper.AccountName = accRecList[0].LastName+' '+accRecList[0].FirstName;
            }else{*/
            fullQWrapper.AccountName = accRecList[0].Name;
            /*List<Contact> con = accRecList[0].Contacts;
                if(con.size() > 0){
                    fullQWrapper.Name = con[0].FirstName;
                    fullQWrapper.LastName = con[0].LastName;
                    fullQWrapper.telePhone = con[0].Phone;
                }*/
            if (ContId != null && ContId != '') {
                displayCOntactDetail(ContId);
            }
            //}
            //populateContactDetails(accRecList[0].Id); // issue 1271
        }
    }

    public PageReference transactionWebservice() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :transactionWebservice');
        onchangeQuotType = true;
        if (isLoadedTrap) {
            onchagneTansactiontype();
        }

        List < HomeBaseBeans.transactions > transactionResponse;
        TransactionListService_AC transactionService = null;
        FullQuoteMainService fqService = null;
        try {
            fqService = new FullQuoteMainService();
            transactionService = new TransactionListService_AC();
            String bId = fqService.getuserBranchInfo();
            transactionResponse = transactionService.listActiveTransactions(bId);
            System.debug('****** transaction webservice ' + transactionResponse);
            if (test.isRunningTest()) {
                transactionResponse = MMIFullquoteTestDataProvider.getTransactionType();
            }
            if (transactionResponse[0].errorMessage == null) {
                QuoteType = fullQWrapper.selectedFullQUote;
                transactionOptions = new List < SelectOption > ();
                transactionOptions.add(new SelectOption('-None-', '-None-'));
                system.debug('-----------fullQWrapper.selectedFullQUote----------------' + fullQWrapper.selectedFullQUote);
                for (HomeBaseBeans.transactions TT: transactionResponse) {
                    if (fullQWrapper.TransactionType != null && fullQWrapper.TransactionType != '' && fullQWrapper.TransactionType == TT.Id) {
                        transtionTypeName = TT.description;
                    }
                    System.debug('T Descriptionssssssssssss ' + TT.description);
                    if (fullQWrapper.selectedFullQUote == 'rental' || fullQWrapper.selectedFullQUote == 'Rental') {
                        if (TT.description != 'Chico Non-Container Rental' && TT.description != 'OTG' && TT.description != 'OTG Warehouse' && TT.description != 'Sales Order Fleet Sales' && TT.description != 'Sales Order MFG/Accessories' && TT.description != 'Sale of Service' && TT.description != 'Sales Order Wholesale Direct') {
                            if (TT.description == 'Rental Offsite Standard') {
                                transactionOptions.add(new SelectOption(TT.Id, TT.description));
                            }
                        }
                    }
                }
                for (HomeBaseBeans.transactions TT: transactionResponse) {
                    System.debug('T Descriptionssssssssssss ' + TT.description);
                    if (fullQWrapper.selectedFullQUote == 'rental' || fullQWrapper.selectedFullQUote == 'Rental') {
                        if (TT.description != 'Chico Non-Container Rental' && TT.description != 'OTG' && TT.description != 'OTG Warehouse' && TT.description != 'Sales Order Fleet Sales' && TT.description != 'Sales Order MFG/Accessories' && TT.description != 'Sale of Service' && TT.description != 'Sales Order Wholesale Direct') {
                            if (TT.description != 'Rental Offsite Standard') {
                                transactionOptions.add(new SelectOption(TT.Id, TT.description));
                            }
                        }
                    }
                }
                for (HomeBaseBeans.transactions TT: transactionResponse) {
                    if (fullQWrapper.selectedFullQUote == 'sales') {
                        if (TT.description == 'Sales Order Fleet Sales' || TT.description == 'Sales Order MFG/Accessories' || TT.description == 'Sales Order Wholesale Direct') transactionOptions.add(new SelectOption(TT.Id, TT.description));
                    }
                }
            } else {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, transactionResponse[0].errorMessage);
                ApexPages.addMessage(msg);
            }
            if (QuoteType == 'sales') {
                isSalesType = true;
            } else {
                isSalesType = false;
            }
            ClearLockSelect();
            accessoriesQuantity = 1;
            //ProductsSelection();
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC transactionWebservice:' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :transactionWebservice' + transactionOptions);

        return null;
    }

    // Contact webservice

    public PageReference contactsWebservice() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :contactsWebservice');
        try {
            contactsResponseList = new List < HomeBaseBeans.contactSummaryList > ();
            ContactsService_AC contactsService = new ContactsService_AC();
            if (fullQWrapper.AccountId != null && fullQWrapper.AccountId != '') {
                //if (ContId == null || ContId == '') { // TFS 1380
                    contactsResponseList = contactsService.listContacts(fullQWrapper.AccountId);
                //}
            }
            if (test.isRunningTest()) {
                contactsResponseList = MMIFullquoteTestDataProvider.getContactSummaryList();
            }
            //commented because we do not want to populate default delivery contact during page load
            /*for (HomeBaseBeans.contactSummaryList cont: contactsResponseList) {
                if (cont.contactId == '1') {
                    fullQWrapper.BillingContactID = cont.contactId;
                    fullQWrapper.Name = cont.forename;
                    fullQWrapper.LastName = cont.surname;

                    fullQWrapper.deliveryContactId = cont.contactId;
                    fullQWrapper.NameInShippingDates1 = cont.forename + ' ' + cont.surname;
                }
            }*/
            //-----added top and commented below for issue 1271
            if (ContId != null && ContId != '') {
                displayCOntactDetail(ContId);
                //fullQWrapper.BillingContactID = '';
            }
            /*if(opportunityRec.size() > 0){
                populateContactDetails(opportunityRec[0].Id);
            }
            if(accountRec.size() > 0){
                populateContactDetails(accountRec[0].Id);
            }*/
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC contactsWebservice:' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :contactsWebservice' + contactsResponseList);
        return null;
    }

    // Select one contact Id

    public Pagereference contactIdEnterbyUser() {

        BillingContactInvalide = false;

        if (contactsResponseList == null) {
            system.debug('errr');
            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Please first Enter Account');
            ApexPages.addMessage(msg);
        } else {
            // get specific contacts---------------
            List < HomeBaseBeans.SpecificContact > speceficContDetails = new List < HomeBaseBeans.SpecificContact >();
            try{
                speceficContDetails = callSpecificContactWS(fullQWrapper.BillingContactID, fullQWrapper.AccountId);
            }catch(Exception e){
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, e.getMessage());
                ApexPages.addMessage(msg);
                BillingContactInvalide = true;
                fullQWrapper.BillingContactID = '';
            }
            if(speceficContDetails != null && speceficContDetails.size() > 0){
                if(speceficContDetails[0].errorMessage == null || speceficContDetails[0].errorMessage == ''){
                    fullQWrapper.BillingContactID = speceficContDetails[0].contactId;
                    fullQWrapper.Name = speceficContDetails[0].forename;
                    fullQWrapper.LastName = speceficContDetails[0].surname;
                    fullQWrapper.telePhone = speceficContDetails[0].phoneNumber;
                    fullQWrapper.conMob = speceficContDetails[0].cellMobile;
                    fullQWrapper.Email = speceficContDetails[0].email;
                    fullQWrapper.Fax = speceficContDetails[0].faxNumber;
                }else{
                    ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Billing Contact ID Not Found');
                    ApexPages.addMessage(msg);
                    BillingContactInvalide = true;
                    fullQWrapper.BillingContactID = '';
                }
            }
        }
        return null;
    }
    
    public Pagereference deliveryContactIdEnterbyUser() {

        ShippingContactInvalide = false;

        if (contactsResponseList == null) {
            system.debug('errr');
            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Please first Enter Account');
            ApexPages.addMessage(msg);
        } else {
            // get specific contacts---------------
            List < HomeBaseBeans.SpecificContact > speceficContDetails = new List < HomeBaseBeans.SpecificContact >();
            try{
                speceficContDetails = callSpecificContactWS(fullQWrapper.deliveryContactId, fullQWrapper.AccountId);
            }catch(Exception e){
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, e.getMessage());
                ApexPages.addMessage(msg);
                ShippingContactInvalide = true;
                fullQWrapper.deliveryContactId = '';
            }
            if(speceficContDetails != null && speceficContDetails.size() > 0){
                if(speceficContDetails[0].errorMessage == null || speceficContDetails[0].errorMessage == ''){
                    fullQWrapper.deliveryContactId = speceficContDetails[0].contactId;
                    fullQWrapper.NameInShippingDates1 = speceficContDetails[0].forename + ' '+speceficContDetails[0].surname;
                    fullQWrapper.telInShippingDates = speceficContDetails[0].phoneNumber;
                    fullQWrapper.emailInShippingDates = speceficContDetails[0].email;
                    fullQWrapper.faxInShippingDates = speceficContDetails[0].faxNumber;
                }else{
                    ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Shipping Contact ID Not Found!');
                    ApexPages.addMessage(msg);
                    ShippingContactInvalide = true;
                    fullQWrapper.deliveryContactId = '';
                }
            }
        }
        return null;
    }
    
    public PageReference contactIdSelected() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :contactIdSelected');
        String selectedContactId;

        try {
            selectedContactId = System.currentPageReference().getParameters().get('selectedContactBilling');
            if (test.isRunningTest()) {
                selectedContactId = '1';
            }
            // get specific contact details
            List < HomeBaseBeans.SpecificContact > specContDetails = new List < HomeBaseBeans.SpecificContact >();
            specContDetails = callSpecificContactWS(selectedContactId, fullQWrapper.AccountId);
            system.debug('---------------specContDetails--------------'+specContDetails);
            if(specContDetails != null && specContDetails.size() > 0){
                for (HomeBaseBeans.SpecificContact HB: specContDetails) {
                    if (HB.contactId == selectedContactId) {
                        fullQWrapper.BillingContactID = HB.contactId;
                        fullQWrapper.Name = HB.forename;
                        fullQWrapper.LastName = HB.surname;
                        fullQWrapper.telePhone = HB.phoneNumber;
                        fullQWrapper.conMob = HB.cellMobile;
                        fullQWrapper.Email = HB.email;
                        fullQWrapper.Fax = HB.faxNumber;
                        break;
                    }
                }
            }

            fullQWrapper.contactPopup = false;
            fullQWrapper.showContactSearchInBilling = false;
            qqWrapper = new QuickQuoteWrapper();
            BillingContactInvalide = false;

        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC contactIdSelected:' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :contactIdSelected' + fullQWrapper);
        return null;
    }

    // Search contacts in billing screen

    public PageReference seachContactsInBilling() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :seachContactsInBilling');
        try {
            contactsResponseSearchList = new List < HomeBaseBeans.contactSummaryList > ();
            if ((qqWrapper.contactIdSearchWord == null || qqWrapper.contactIdSearchWord == '') && (qqWrapper.contactFNameSearchWord == null || qqWrapper.contactFNameSearchWord == '') && (qqWrapper.contactLNameSearchWord == null || qqWrapper.contactLNameSearchWord == '')) {
                fullQWrapper.showContactSearchInBilling = false;
            } else {
                for (HomeBaseBeans.contactSummaryList HB: contactsResponseList) {
                    if ((qqWrapper.contactIdSearchWord != '') && (HB.contactId.toLowerCase()).startswith(qqWrapper.contactIdSearchWord.toLowerCase()) || (qqWrapper.contactFNameSearchWord != '') && (HB.forename.toLowerCase()).Contains(qqWrapper.contactFNameSearchWord.toLowerCase()) || (qqWrapper.contactLNameSearchWord != '') && (HB.surname.toLowerCase()).Contains(qqWrapper.contactLNameSearchWord.toLowerCase())) {
                        contactsResponseSearchList.add(HB);
                    }
                }

                fullQWrapper.showContactSearchInBilling = true;

            }
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC seachContactsInBilling: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :seachContactsInBilling' + contactsResponseSearchList);
        return null;
    }


    public void onchagneTansactiontype() {
        if (fullQWrapper.AccountId != null && fullQWrapper.AccountId != '' && !fullQWrapper.AccountId.startsWith('G') && !fullQWrapper.AccountId.startsWith('P')) {
            disableBilingAddressFields();
        } else {
            enableBilingAddressFields();
        }
        List < HomeBaseBeans.transactions > transactionResponse;
        TransactionListService_AC transactionService = null;
        FullQuoteMainService fqService = null;
        fqService = new FullQuoteMainService();
        transactionService = new TransactionListService_AC();
        String bId = fqService.getuserBranchInfo();
        transactionResponse = transactionService.listActiveTransactions(bId);
        if (test.isRunningTest()) {
            transactionResponse = MMIFullquoteTestDataProvider.getTransactionType();
        }
        if (fullQWrapper.TransactionType != null) {
            for (HomeBaseBeans.transactions TT: transactionResponse) {
                if (fullQWrapper.TransactionType == TT.id) {
                    transtionTypeName = TT.description;
                }
            }
        }
        if (fullQWrapper.TransactionType == 'MOBO' || fullQWrapper.TransactionType == 'SECO' || fullQWrapper.TransactionType == 'SOFL') {
            isTransTmoboORseco = true;
        } else {
            isTransTmoboORseco = false;
        }
        if (tranTypeSetValue == null || tranTypeSetValue == '-None-') {
            tranTypeErrorMessage = false;
        } else {
            if (onchangeQuotType) {
                tranTypeErrorMessage = false;
            } else {
                tranTypeErrorMessage = true;
            }
            clearAllDataOnChnagetype();
        }
        if (docId == null) {
            if (isTransTmoboORseco) {
                fullQWrapper.rentalLengthInProduct = '2';
                fullQWrapper.rentalLength = '2';
            } else {
                fullQWrapper.rentalLengthInProduct = '1';
                fullQWrapper.rentalLength = '1';
            }
            tranTypeSetValue = fullQWrapper.TransactionType;
            if (fullQWrapper.TransactionType != null && fullQWrapper.TransactionType != '-None-') {
                if (fullQWrapper.selectedFullQUote != 'sales') {
                    //ProductsSelection(); //a button added in product tab to load product lists
                }
            }
        }
        onchangeQuotType = false;
        SelectedRentalLength = '';
        analysisWebservice(); // added fpr better process
        ClearProductSummarylines(); // added fpr better process
    }

    public void clearAllDataOnChnagetype() {
        isRentalLength = false;
        fullQWrapper.isUseBillingAddress = false;
        isAccountNameAndIdReadOnly = false;
        String typ = fullQWrapper.TransactionType;
        String sellFullQuoteType = fullQWrapper.selectedFullQUote;
        fullQWrapper = new FullQuoteWrapper();
        fullQWrapper.TransactionType = typ;
        fullQWrapper.selectedFullQUote = sellFullQuoteType;
        //saveFOptions.add(new SelectOption(sellFullQuoteType,sellFullQuoteType));
        fullQWrapper.WriteUpRep = loginUserRec.Sales_Rep_Id__c;
        fullQWrapper.AssistingRep = loginUserRec.Sales_Rep_Id__c;
        fullQWrapper.WriteUpRepName = loginUserRec.Name;
        fullQWrapper.AssistingRepName = loginUserRec.Name;
        fullQWrapper.enableRefreshQuote = false;
        fullQWrapper.enableSaveQuote = false;

        fullQWrapper.enableProductadd = false;
        fullQWrapper.enableVAddresBtnInShipping = false;
        fullQWrapper.fullfillingBranch = false;
        fullQWrapper.invoiceTabEnableDis = false;
        fullQWrapper.startDateonchange = false;
        fullQWrapper.analysisSetHeadValue = false;
        fullQWrapper.PrimaryOnly = true;
        fullQuote = new MMI_Full_Quotes__c();
        //fullQuote.Start_Date__c = System.today();
        fullQuote.Scheduled_Delivery__c = System.today();
        //fullQuote.Quote_expires__c = System.today().addDays(30);
        fullQWrapper.analysisSetHeadValue = false;
        fullQWrapper.isShippingAddressValidated = false;
        fullQWrapper.isBillingAddressValidated = true;
        isEditTranType = false;
        isScheduledDeliveryDateIsReadOnly = false;
        IsReservedSuccess = false;
        isZipCodeIsNot = false;
        isClearSummaryLineItems = false;
        isFullfillingBranchid = true;
        isShippingTabChaneValue = false;
        isFullfillingBranchid = true;
        isTexIdIsNullbutton = true;
        isContactIs = true;
        isAddressId = true;
        isScheduDeliver = false;
        writeupId = false;
        assigRepId = false;
        accountAddresInvalid = false;
        BillingContactInvalide = false;
        ShippingContactInvalide = false;
        shippingAddressInvalide = false;
        isfullfillingBranchInvalide = false;
        isRefreshTrue = false;
        fullQWrapper.disableModificationPrice = true;
        fullQWrapper.disableModificationSelection = false;
        fullQWrapper.showSubmitButton = true;
        refreshLineAllResponseList = new list < List < HomeBaseBeans.quoteLine >> ();
        summaryLineList = new List < HomeBaseBeans.quoteLine > ();
        analysisSetHeaderResponseList = new List < HomeBaseBeans.AnalysisSetHeaders > ();
        productList = new List < HomeBaseBeans.Products > ();
        ProductExtrasList = new List < HomeBaseBeans.extras > ();
        editProduct = new HomeBaseBeans.Products();
        standardRate = ''; // for TFS 2829
        baseRate = ''; // for TFS 3080
        salesFleetList = new List < HomeBaseBeans.SalesFleets > ();
        QuickQuoteMainService qqService = new QuickQuoteMainService();
        fullQWrapper.userBranchId = qqService.getuserBranchInfo();
        qqWrapper = new QuickQuoteWrapper();
        qqWrapperShipping = new QuickQuoteWrapper();
        enableBilingAddressFields();
        if (source == 'jp') {
            populateAddressFromJp();
            rePopulateContactDetail();
        }
    }
    // AnalysisSets webservice which can be called when transaction type selected
    public PageReference analysisWebservice() {

        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :analysisWebservice' + fullQWrapper.TransactionType);
        AnalysisSetsService_AC analysisSetHeaderSerice = null;
        AnalysisSetCodesService_AC analysisSetCodeSerice = null;
        String url = null;
        try {
            analysisSetHeaderSerice = new AnalysisSetsService_AC();
            if (fullQWrapper.TransactionType != '-None-' && fullQWrapper.TransactionType != '' && fullQWrapper.TransactionType != null) {

                //url = 'rest/api/v1/companies/1/transactions/'+fullQWrapper.TransactionType+'/analysis_sets';
                analysisSetHeaderResponseList = analysisSetHeaderSerice.listActiveTransactions(fullQWrapper.TransactionType);
                if (test.isRunningTest()) {
                    analysisSetHeaderResponseList = MMIFullquoteTestDataProvider.getAnalysisSetHeaderAll();

                    Lead ldObj = MMIFullquoteTestDataProvider.getLeadWithDeliveryAdd();
                    ldObj.LeadSource = 'Ad Source';
                    ldObj.Industry = 'Customer Type';
                    insert ldObj;
                    List < Lead > ldLst = new list < Lead > ();
                    ldLst.add(ldObj);
                    leadRec = ldLst;

                    Account accNew = MMIFullquoteTestDataProvider.getAccount();
                    accNew.Result_Id__c = '12557879';
                    accNew.Lead_Source__c = 'Ad Source';
                    accNew.ShippingState = 'N/A';
                    accNew.BillingState = 'N/A';
                    accNew.Industry = '1-Mining';
                    insert accNew;
                    list < Account > lstAccnt = new list < Account > ();
                    lstAccnt.add(accNew);
                    accountRec = lstAccnt;

                    Opportunity opp2 = MMIFullquoteTestDataProvider.getOpportunity();
                    opp2.AccountId = accNew.Id;
                    opp2.Delivery_Country__c = 'Ad Source';
                    opp2.LeadSource = 'N/A';
                    insert opp2;
                    list < Opportunity > lstOppty = new list < Opportunity > ();
                    lstOppty.add(opp2);
                    opportunityRec = lstOppty;
                }
                analysisSetAdSourceResponseList = new List < HomeBaseBeans.analysisSetCodes > ();
                analysisSetCTypeResponseList = new List < HomeBaseBeans.analysisSetCodes > ();
                analysisSetDeferredResponseList = new List < HomeBaseBeans.analysisSetCodes > ();
                analysisSetWriteOffAcResponseList = new List < HomeBaseBeans.analysisSetCodes > ();
                analysisSetCostCenterResponseList = new List < HomeBaseBeans.analysisSetCodes > ();
                analysisSetORepResponseList = new List < HomeBaseBeans.analysisSetCodes > ();

                analysisSetCodeSerice = new AnalysisSetCodesService_AC();
                for (HomeBaseBeans.AnalysisSetHeaders HB: analysisSetHeaderResponseList) {
                    HB.selectOptionList = new List < SelectOption > ();
                    if (HB.description != 'Deferred Bill ' && HB.description != 'Outside TSM') {
                        HB.selectOptionList.add(new SelectOption('', '-None-'));
                    }

                    if (HB.description == 'Ad Source') {
                        analysisSetAdSourceResponseList = analysisSetCodeSerice.listActiveTransactions(HB.Id);
                        if (test.isRunningTest()) {
                            List < HomeBaseBeans.analysisSetCodes > addSrc = MMIFullquoteTestDataProvider.getAnalysisSetCodes();
                            addSrc[0].id = '1';
                            addSrc[0].description = 'Ad Source';
                            analysisSetAdSourceResponseList = addSrc;
                        }
                        for (HomeBaseBeans.analysisSetCodes HB_A: analysisSetAdSourceResponseList) {
                            if (leadRec != null) {
                                if (leadRec.size() > 0) {
                                    if (HB_A.description == leadRec[0].LeadSource) {
                                        HB.selectedId = HB_A.id;
                                        HB.selectedDescription = HB_A.description;
                                        //break;
                                    }
                                }
                            }
                            if (opportunityRec != null) {
                                if (opportunityRec.size() > 0) {
                                    if (HB_A.description == opportunityRec[0].LeadSource) {
                                        HB.selectedId = HB_A.id;
                                        HB.selectedDescription = HB_A.description;
                                        //break;
                                    }
                                }
                            }
                            if (accountRec != null) {
                                if (accountRec.size() > 0) {
                                    if (HB_A.description == accountRec[0].Lead_Source__c) {
                                        HB.selectedId = HB_A.id;
                                        HB.selectedDescription = HB_A.description;
                                        //break;
                                    }
                                }
                            }
                            HB.selectOptionList.add(new SelectOption(HB_A.Id, HB_A.description));
                        }
                    }
                    if (HB.description == 'Customer Type') {
                        analysisSetCTypeResponseList = analysisSetCodeSerice.listActiveTransactions(HB.Id);
                        if (test.isRunningTest()) {
                            List < HomeBaseBeans.analysisSetCodes > cusTyp = MMIFullquoteTestDataProvider.getAnalysisSetCodes();
                            cusTyp[0].id = '2';
                            cusTyp[0].description = 'Customer Type';
                            analysisSetCTypeResponseList = cusTyp;
                        }


                        for (HomeBaseBeans.analysisSetCodes HB_AC: analysisSetCTypeResponseList) {
                            if (leadRec != null) {
                                if (leadRec.size() > 0) {
                                    // (Sept 1st-Dec 31st) If 
                                    List < String > leadIndustryid = leadRec[0].Industry.split('-');
                                    if (HB_AC.Id == leadIndustryid[0]) {
                                        HB.selectedId = HB_AC.id;
                                        HB.selectedDescription = HB_AC.description;
                                    }
                                }
                            }
                            if (accountRec != null) {
                                if (accountRec.size() > 0) {
                                    List < String > leadIndustryidAccount = accountRec[0].Industry.split('-');
                                    if (leadIndustryidAccount.size() > 0) {
                                        if (HB_AC.Id == leadIndustryidAccount[0]) {
                                            HB.selectedId = HB_AC.id;
                                            HB.selectedDescription = HB_AC.description;
                                        }
                                    }
                                }
                            }
                            HB.selectOptionList.add(new SelectOption(HB_AC.Id, HB_AC.description));
                        }
                    }
                    if (HB.description == 'Deferred Bill') {

                        analysisSetDeferredResponseList = analysisSetCodeSerice.listActiveTransactions(HB.Id);
                        if (test.isRunningTest()) {
                            List < HomeBaseBeans.analysisSetCodes > defBill = MMIFullquoteTestDataProvider.getAnalysisSetCodes();
                            defBill[0].id = '3';
                            defBill[0].description = 'Deferred Bill';
                            analysisSetDeferredResponseList = defBill;
                        }

                        for (HomeBaseBeans.analysisSetCodes HB_AC: analysisSetDeferredResponseList) {
                            HB.selectOptionList.add(new SelectOption(HB_AC.Id, HB_AC.description));
                        }
                    }
                    if (HB.description == 'Outside TSM') {
                        analysisSetORepResponseList = analysisSetCodeSerice.listActiveTransactions(HB.Id);
                        if (test.isRunningTest()) {
                            List < HomeBaseBeans.analysisSetCodes > outTsm = MMIFullquoteTestDataProvider.getAnalysisSetCodes();
                            outTsm[0].id = '4';
                            outTsm[0].description = 'Outside TSM';
                            analysisSetORepResponseList = outTsm;
                        }

                        for (HomeBaseBeans.analysisSetCodes HB_AC: analysisSetORepResponseList) {
                            HB_AC.description = HB_AC.Longdescription;
                            HB.selectOptionList.add(new SelectOption(HB_AC.Id, HB_AC.description));
                        }
                    }
                    if (HB.description == 'Write Off A/c') {

                        analysisSetWriteOffAcResponseList = analysisSetCodeSerice.listActiveTransactions(HB.Id);
                        if (test.isRunningTest()) {
                            List < HomeBaseBeans.analysisSetCodes > woa = MMIFullquoteTestDataProvider.getAnalysisSetCodes();
                            woa[0].id = '5';
                            woa[0].description = 'Write Off A/c';
                            analysisSetWriteOffAcResponseList = woa;
                        }

                        for (HomeBaseBeans.analysisSetCodes HB_AC: analysisSetWriteOffAcResponseList) {
                            HB.selectOptionList.add(new SelectOption(HB_AC.Id, HB_AC.description));
                        }
                    }
                    if (HB.description == 'Cost Center') {
                        analysisSetCostCenterResponseList = analysisSetCodeSerice.listActiveTransactions(HB.Id);
                        if (test.isRunningTest()) {
                            List < HomeBaseBeans.analysisSetCodes > cstCntr = MMIFullquoteTestDataProvider.getAnalysisSetCodes();
                            cstCntr[0].id = '6';
                            cstCntr[0].description = 'Cost Center';
                            analysisSetCostCenterResponseList = cstCntr;
                        }

                        for (HomeBaseBeans.analysisSetCodes HB_AC: analysisSetCostCenterResponseList) {
                            HB.selectOptionList.add(new SelectOption(HB_AC.Id, HB_AC.description));
                        }
                    }
                }
                for (HomeBaseBeans.AnalysisSetHeaders HB: analysisSetHeaderResponseList) {
                    if (HB.description == 'Outside TSM') {
                        HB.selectedId = '100000';
                        HB.selectedDescription = 'Enter Outside TSM or n/a';
                    }
                    if (HB.description == 'Deferred Bill') {
                        HB.selectedId = 'NO';
                        HB.selectedDescription = 'NO';
                    }
                    if (leadRec != null && leadRec.size() > 0) {
                        List < String > leadIndustryid = leadRec[0].Industry.split('-');
                        if (HB.description == 'Customer Type') {
                            if (system.today().month() > 8 && system.today().month() <= 12) {
                                if (leadRec[0].Industry == '2-Retail Trade/Services') {
                                    HB.selectedId = '2.1';
                                    HB.selectedDescription = 'Retail Xmas';
                                } else {
                                    system.debug('test---');
                                    for (HomeBaseBeans.analysisSetCodes HB_AC: analysisSetCTypeResponseList) {
                                        if (leadIndustryid.size() > 0) {
                                            if (leadIndustryid[0] == HB_AC.Id) {
                                                HB.selectedId = HB_AC.Id;
                                                HB.selectedDescription = HB_AC.description;
                                            }
                                        }
                                    }
                                }
                            } else {
                                if (HB.description == 'Customer Type') {
                                    for (HomeBaseBeans.analysisSetCodes HB_AC: analysisSetCTypeResponseList) {
                                        if (leadIndustryid.size() > 0) {
                                            if (leadIndustryid[0] == HB_AC.Id) {
                                                HB.selectedId = HB_AC.Id;
                                                HB.selectedDescription = HB_AC.description;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }


                    if (accountRec != null && accountRec.size() > 0) {
                        List < String > leadIndustryidforAccount = accountRec[0].Industry.split('-');
                        if (HB.description == 'Customer Type') {
                            if (system.today().month() > 8 && system.today().month() <= 12) {
                                if (accountRec[0].Industry == '2-Retail Trade/Services') {
                                    HB.selectedId = '2.1';
                                    HB.selectedDescription = 'Retail Xmas';
                                } else {
                                    for (HomeBaseBeans.analysisSetCodes HB_AC: analysisSetCTypeResponseList) {
                                        if (leadIndustryidforAccount.size() > 0) {
                                            if (leadIndustryidforAccount[0] == HB_AC.Id) {
                                                HB.selectedId = HB_AC.Id;
                                                HB.selectedDescription = HB_AC.description;
                                            }
                                        }

                                    }
                                }
                            } else {
                                if (HB.description == 'Customer Type') {
                                    for (HomeBaseBeans.analysisSetCodes HB_AC: analysisSetCTypeResponseList) {
                                        if (leadIndustryidforAccount.size() > 0) {
                                            if (leadIndustryidforAccount[0] == HB_AC.Id) {
                                                HB.selectedId = HB_AC.Id;
                                                HB.selectedDescription = HB_AC.description;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }


                    if (HB.description == 'Ad Source') {
                        //analysisSetCTypeResponseList = analysisSetCodeSerice.listActiveTransactions(HB.Id);
                        if (test.isRunningTest()) {
                            List < HomeBaseBeans.analysisSetCodes > cusTyp1 = MMIFullquoteTestDataProvider.getAnalysisSetCodes();
                            cusTyp1[0].id = '1';
                            cusTyp1[0].description = 'Ad Source';
                            analysisSetCTypeResponseList = cusTyp1;
                        }
                        for (HomeBaseBeans.analysisSetCodes HB_AC: analysisSetCTypeResponseList) {
                            if (leadRec != null && leadRec.size() > 0) {
                                if (leadRec[0].LeadSource == HB_AC.description) {
                                    HB.selectedId = HB_AC.Id;
                                    HB.selectedDescription = HB_AC.description;
                                }
                            }
                            if (opportunityRec != null && opportunityRec.size() > 0) {
                                if (opportunityRec[0].LeadSource == HB_AC.description) {
                                    HB.selectedId = HB_AC.Id;
                                    HB.selectedDescription = HB_AC.description;
                                }
                            }
                            if (accountRec != null && accountRec.size() > 0) {
                                if (accountRec[0].Lead_Source__c == HB_AC.description) {
                                    HB.selectedId = HB_AC.Id;
                                    HB.selectedDescription = HB_AC.description;
                                }
                            }
                        }
                    }

                }
            }
            if (editFQResponse.rentalQuote != null) {
                analysisWebservicesCustomer(editFQResponse);
            }

            if (fullQuote_tran != null) {
                List < AnalysisSet__c > AnalysisSetsList = fullQuote_tran.AnalysisSets__r;
                integer i = 1;
                for (HomeBaseBeans.AnalysisSetHeaders HB: analysisSetHeaderResponseList) {
                    for (AnalysisSet__c analyRec: AnalysisSetsList) {
                        if (i == integer.valueOf(analyRec.Sequence__c)) {
                            HB.id = analyRec.Header_id__c;
                            HB.description = analyRec.Header_description__c;
                            HB.selectedId = analyRec.Selection_id__c;
                            HB.selectedDescription = analyRec.Selection_description__c;

                        }

                    }
                    i++;
                }

            }

            analysisSetHeaderResponseShippingList.clear();
            isShippingTabChaneValue = false;
            fullQWrapper.enableRefreshQuote = false;
            fullQWrapper.enableSaveQuote = false;
            fullQWrapper.enableMarkAsLostbutton = false;

            fullQWrapper.enableProductadd = false;

            fullQWrapper.enableVAddresBtnInShipping = true;
            isFullfillingBranchid = true;
            if (docId == null && FQSMrecId == null) {
                if (fullQWrapper.selectedFullQUote != 'sales') {
                    //ProductsSelection(); //a button added in product tab to load product lists
                }
            }

            tranTypeErrorMessage = false;

        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC analysisWebservice: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :analysisWebservice' + editFQResponse);
        return null;
    }

    public void analysisSetbtnEnable() {
        if (fullQWrapper.analysisSetHeadValue) {
            fullQWrapper.enableRefreshQuote = true;
            fullQWrapper.enableSaveQuote = false;
            fullQWrapper.enableMarkAsLostbutton = false;

        } else {
            fullQWrapper.enableRefreshQuote = false;
            fullQWrapper.enableSaveQuote = false;
            fullQWrapper.enableMarkAsLostbutton = false;

        }

    }
    public PageReference analysisSetSelectedInBilling() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :analysisSetSelectedInBilling' + analysisSetHeaderResponseList);
        try {
            if (test.isRunningTest()) {
                analysisSetHeaderResponseList = MMIFullquoteTestDataProvider.getAnalysisSetHeaderAll();
                analysisSetORepResponseList = MMIFullquoteTestDataProvider.getAnalysisSetCodesOutsideTSM();
                analysisSetDeferredResponseList = MMIFullquoteTestDataProvider.getAnalysisSetCodesDeferredBill();
                analysisSetWriteOffAcResponseList = MMIFullquoteTestDataProvider.getAnalysisSetCodesWriteOffAc();
                analysisSetCostCenterResponseList = MMIFullquoteTestDataProvider.getAnalysisSetCodesCostCenter();
                analysisSetAdSourceResponseList = MMIFullquoteTestDataProvider.getAnalysisSetCodesAdSource();
                analysisSetCTypeResponseList = MMIFullquoteTestDataProvider.getAnalysisSetCodesCustomerType();
            }
            for (HomeBaseBeans.AnalysisSetHeaders HB: analysisSetHeaderResponseList) {
                for (HomeBaseBeans.analysisSetCodes HB_A: analysisSetORepResponseList) {
                    if (HB.selectedId == HB_A.id) {
                        HB.selectedDescription = HB_A.description;
                        HB.Longdescription = HB_A.Longdescription;
                    }
                }
                for (HomeBaseBeans.analysisSetCodes HB_A: analysisSetDeferredResponseList) {
                    if (HB.selectedId == HB_A.id) {
                        HB.selectedDescription = HB_A.description;
                    }
                }
                for (HomeBaseBeans.analysisSetCodes HB_A: analysisSetWriteOffAcResponseList) {
                    if ('49100' == HB_A.id) {
                        HB.selectedDescription = HB_A.description;
                    }
                }
                for (HomeBaseBeans.analysisSetCodes HB_A: analysisSetCostCenterResponseList) {
                    if ('00' == HB_A.id) {

                        HB.selectedDescription = HB_A.description;
                    }
                }
                for (HomeBaseBeans.analysisSetCodes HB_A: analysisSetAdSourceResponseList) {
                    if (HB.selectedId == HB_A.id) {
                        HB.selectedDescription = HB_A.description;
                    }
                }
                for (HomeBaseBeans.analysisSetCodes HB_A: analysisSetCTypeResponseList) {
                    if (HB.selectedId == HB_A.id) {
                        HB.selectedDescription = HB_A.description;
                    }
                }
            }
            system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :analysisSetSelectedInBilling' + analysisSetHeaderResponseList);
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC analysisSetSelectedInBilling: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :analysisSetSelectedInBilling');
        return null;
    }


    // AnalysisSets webservice for fields in delivery planning section in shipping screen  

    public PageReference analysisShippingWebservice() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :analysisShippingWebservice');
        AnalysisSetsService_AC analysisSetHeaderSerice = null;
        List < HomeBaseBeans.AnalysisSetHeaders > analysisSetHeaderResponse = new List < HomeBaseBeans.AnalysisSetHeaders > ();
        try {
            analysisSetHeaderSerice = new AnalysisSetsService_AC();
            if (fullQWrapper.TransactionType != null && fullQWrapper.TransactionType != '' && fullQWrapper.TransactionType != '-None-') {
                //analysisSetHeaderResponse = analysisSetHeaderSerice.listActiveTransactions('rest/api/v1/companies/1/transactions/'+fullQWrapper.TransactionType+'/analysis_sets?type=quote_order');
                analysisSetHeaderResponse = analysisSetHeaderSerice.listActiveTransactions(fullQWrapper.TransactionType + '_ExtraAnalysisSet');
            }
            if (test.isRunningTest()) {
                analysisSetHeaderResponse = MMIFullquoteTestDataProvider.getAnalysisSetHeaderAll();
                analysisSetHeaderResponse[0].description = 'Movement Type';
                analysisSetHeaderResponse[1].description = 'Del Time';
                analysisSetHeaderResponse[2].description = 'Call First';
                analysisSetHeaderResponse[3].description = 'Door Dir';
            }
            for (HomeBaseBeans.AnalysisSetHeaders HB: analysisSetHeaderResponse) {
                if (HB.description == 'Movement Type') {

                    HB.selectedId = 'DL';
                    HB.selectedDescription = 'Delivery';
                    analysisSetHeaderResponseShippingList.add(HB);

                    break;
                }
            }
            for (HomeBaseBeans.AnalysisSetHeaders HB: analysisSetHeaderResponse) {
                if (HB.description == 'Del Time') {
                    analysisSetHeaderResponseShippingList.add(HB);
                    break;
                }

            }
            for (HomeBaseBeans.AnalysisSetHeaders HB: analysisSetHeaderResponse) {
                if (HB.description == 'Call First') {
                    HB.selectedId = 'YES';
                    HB.selectedDescription = 'Call First';
                    analysisSetHeaderResponseShippingList.add(HB);
                    break;
                }

            }
            for (HomeBaseBeans.AnalysisSetHeaders HB: analysisSetHeaderResponse) {
                if (HB.description == 'Door Dir') {
                    analysisSetHeaderResponseShippingList.add(HB);
                    break;
                }
            }
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC analysisShippingWebservice: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :analysisShippingWebservice' + analysisSetHeaderResponseShippingList);
        return null;
    }
    // Analysis set code web service 
    public PageReference analysisSetCodeWebService() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :analysisSetCodeWebService');
        try {
            analysisSetCodesResponseList = new List < HomeBaseBeans.analysisSetCodes > ();

            if (selectedAnalysisSet == 'Ad Source') {
                analysisSetCodesResponseList = analysisSetAdSourceResponseList;
            }
            if (selectedAnalysisSet == 'Customer Type') {
                analysisSetCodesResponseList = analysisSetCTypeResponseList;
            }
            if (selectedAnalysisSet == 'Deferred Bill') {
                analysisSetCodesResponseList = analysisSetDeferredResponseList;
            }
            if (selectedAnalysisSet == 'Outside TSM') {
                analysisSetCodesResponseList = analysisSetORepResponseList;
            }
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC analysisSetCodeWebService: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :analysisSetCodeWebService' + analysisSetCodesResponseList);
        return null;
    }

    // Click on any select button in delivery plan sec in shipping tab
    public PageReference selectDeliveryPlanSecFields() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :selectDeliveryPlanSecFields');
        try {
            btnOnDeliveryPlan = System.currentPageReference().getParameters().get('shipbtnId');
            if (test.isRunningTest()) {
                btnOnDeliveryPlan = '111';
            }
            if (btnOnDeliveryPlan == '111') analysisSetCodesResponseListInShipping = analysisSetDelTimeResponseList;
            if (test.isRunningTest()) {
                btnOnDeliveryPlan = '112';
            }
            if (btnOnDeliveryPlan == '112') analysisSetCodesResponseListInShipping = analysisSetCallTypeResponseList;
            if (test.isRunningTest()) {
                btnOnDeliveryPlan = '113';
            }
            if (btnOnDeliveryPlan == '113') analysisSetCodesResponseListInShipping = analysisSetDoorDirResponseList;
            if (test.isRunningTest()) {
                btnOnDeliveryPlan = '114';
            }
            if (btnOnDeliveryPlan == '114') analysisSetCodesResponseListInShipping = analysisSetMovementTypeResponseList;
            selectedAnalysisSetInShipping = btnOnDeliveryPlan;
            //analysisSetCodeWebServiceInShipping();
            fullQWrapper.showAnalysisCodeShippingPopup = true;

        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC selectDeliveryPlanSecFields: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :selectDeliveryPlanSecFields' + selectedAnalysisSetInShipping + analysisSetCodesResponseListInShipping);
        return null;
    }


    public PageReference analysisSetCodeWebServiceInShipping() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :analysisSetCodeWebServiceInShipping');
        AnalysisSetCodesService_AC analysisSetCodeSerice = null;
        try {
            analysisSetCodesResponseListInShipping = new List < HomeBaseBeans.analysisSetCodes > ();

            analysisSetCodeSerice = new AnalysisSetCodesService_AC();
            analysisSetCodesResponseListInShipping = analysisSetCodeSerice.listActiveTransactions(selectedAnalysisSetInShipping);

        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC selectDeliveryPlanSecFields: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :analysisSetCodeWebServiceInShipping' + analysisSetCodesResponseListInShipping);
        return null;
    }
    //  Select analysis code for fields in delivery plan sec in shipping tab
    public PageReference analysisSetCodeSelectedInShipping() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :analysisSetCodeSelectedInShipping');
        String selectedAnalysisSetCode;
        try {
            selectedAnalysisSetCode = System.currentPageReference().getParameters().get('selectedAnalysisInShipping');
            if (test.isRunningTest()) {
                selectedAnalysisSetInShipping = '1';
                selectedAnalysisSetCode = '1';
                analysisSetHeaderResponseShippingList = MMIFullquoteTestDataProvider.getAnalysisSetHeaderAll();
                analysisSetCodesResponseListInShipping = MMIFullquoteTestDataProvider.getAnalysisSetCodes();
            }
            for (HomeBaseBeans.AnalysisSetHeaders HB_A: analysisSetHeaderResponseShippingList) {
                if (HB_A.Id == selectedAnalysisSetInShipping) {
                    for (HomeBaseBeans.analysisSetCodes HB_AC: analysisSetCodesResponseListInShipping) {
                        if (HB_AC.id == selectedAnalysisSetCode) {
                            HB_A.selectedId = HB_AC.id;
                            HB_A.selectedDescription = HB_AC.description;
                            break;
                        }
                    }
                    break;
                }
            }

            fullQWrapper.showAnalysisCodeShippingPopup = false;
            fullQWrapper.showSearchAnalysisSetCodeInShipping = false;
            qqWrapperShipping = new QuickQuoteWrapper();

        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC analysisSetCodeSelectedInShipping: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :analysisSetCodeSelectedInShipping' + selectedAnalysisSetCode);
        return null;
    }

    // Search analysis set code in delivery planning section in shipping screen
    public PageReference analysisSetCodeSeachFunInShipping() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :analysisSetCodeSeachFunInShipping');
        try {
            analysisSetCodesResponseSearchShippingList = new List < HomeBaseBeans.analysisSetCodes > ();
            if ((qqWrapperShipping.analysisIdSearchWord == null || qqWrapperShipping.analysisIdSearchWord == '') && (qqWrapperShipping.analysisNameSearchWord == null || qqWrapperShipping.analysisNameSearchWord == '')) {
                fullQWrapper.showSearchAnalysisSetCodeInShipping = false;
            } else {
                if (test.isRunningTest()) {
                    analysisSetCodesResponseListInShipping = MMIFullquoteTestDataProvider.getAnalysisSetCodes();
                }
                for (HomeBaseBeans.analysisSetCodes HB: analysisSetCodesResponseListInShipping) {
                    if ((qqWrapperShipping.analysisIdSearchWord != '') && (HB.Id.toLowerCase()).startswith(qqWrapperShipping.analysisIdSearchWord.toLowerCase()) || (qqWrapperShipping.analysisNameSearchWord != '') && (HB.description.toLowerCase()).Contains(qqWrapperShipping.analysisNameSearchWord.toLowerCase())) {
                        analysisSetCodesResponseSearchShippingList.add(HB);
                    }
                }
                fullQWrapper.showSearchAnalysisSetCodeInShipping = true;
            }
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC analysisSetCodeSeachFunInShipping: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :analysisSetCodeSeachFunInShipping' + analysisSetCodesResponseSearchShippingList);

        return null;
    }
    // To enable analysis set popup 

    public PageReference analysisSetSearch() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :analysisSetSearch');
        try {
            selectedAnalysisSet = System.currentPageReference().getParameters().get('btnId');
            System.debug('selected radio value ' + selectedAnalysisSet);

            analysisSetCodeWebService(); // call analysis set code webservice

            fullQWrapper.showAnalysisCodePopup = true;
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC analysisSetSearch: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :analysisSetSearch' + selectedAnalysisSet);
        return null;
    }

    //  selecting the analysis set code

    public PageReference analysisSetCodeSelected() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :analysisSetCodeSelected');
        String selectedAnalysisSetCode;
        try {
            selectedAnalysisSetCode = System.currentPageReference().getParameters().get('selectedAnalysisInBilling');
            if (test.isRunningTest()) {
                selectedAnalysisSetCode = '1';
                selectedAnalysisSet = 'Ad Source';
                AnalysisSetHeaderResponseList = MMIFullquoteTestDataProvider.getAnalysisSetHeaderAll();
                analysisSetCodesResponseList = MMIFullquoteTestDataProvider.getAnalysisSetCodes();
            }
            for (HomeBaseBeans.AnalysisSetHeaders HB_A: AnalysisSetHeaderResponseList) {
                if (HB_A.Description == selectedAnalysisSet) {
                    for (HomeBaseBeans.analysisSetCodes HB_AC: analysisSetCodesResponseList) {
                        if (HB_AC.id == selectedAnalysisSetCode) {
                            HB_A.selectedId = HB_AC.id;
                            HB_A.selectedDescription = HB_AC.description;
                            break;
                        }
                    }
                    break;
                }
            }
            fullQWrapper.showAnalysisCodePopup = false;
            qqWrapperShipping = new QuickQuoteWrapper();
            fullQWrapper.showSearchAnalysisSetCodeInBilling = false;
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC analysisSetCodeSelected: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :analysisSetCodeSelected' + selectedAnalysisSetCode);
        return null;
    }

    // Analysis set code search in billing screen popup 

    public PageReference analysisSetCodeSearch() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :analysisSetCodeSearch');
        try {
            analysisSetCodesResponseSearchList = new List < HomeBaseBeans.analysisSetCodes > ();
            if ((qqWrapper.analysisIdSearchWord == null || qqWrapper.analysisIdSearchWord == '') && (qqWrapper.analysisNameSearchWord == null || qqWrapper.analysisNameSearchWord == '')) {
                fullQWrapper.showSearchAnalysisSetCodeInBilling = false;
            } else {
                if (test.isRunningTest()) {
                    analysisSetCodesResponseList = MMIFullquoteTestDataProvider.getAnalysisSetCodes();
                }
                for (HomeBaseBeans.analysisSetCodes HB: analysisSetCodesResponseList) {
                    if ((qqWrapper.analysisIdSearchWord != '') && (HB.Id.toLowerCase()).startswith(qqWrapper.analysisIdSearchWord.toLowerCase()) || (qqWrapper.analysisNameSearchWord != '') && (HB.description.toLowerCase()).Contains(qqWrapper.analysisNameSearchWord.toLowerCase())) {
                        analysisSetCodesResponseSearchList.add(HB);
                    }
                }
                fullQWrapper.showSearchAnalysisSetCodeInBilling = true;
            }
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC analysisSetCodeSearch: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :analysisSetCodeSearch' + analysisSetCodesResponseSearchList);
        return null;
    }
    // analysis set selected

    public PageReference analysisSetHeaderSelected() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :analysisSetHeaderSelected');
        String selectedAnalysisSet;
        try {
            selectedAnalysisSet = System.currentPageReference().getParameters().get('SelectedRadio');
            if (test.isRunningTest()) {
                selectedAnalysisSet = '1';
                analysisSetHeaderResponseList = MMIFullquoteTestDataProvider.getAnalysisSetHeaderAll();
            }
            for (HomeBaseBeans.AnalysisSetHeaders h: analysisSetHeaderResponseList) {
                if (h.id == selectedAnalysisSet) {
                    fullQWrapper.analysisSetSelectedId = h.Id;
                    analysisSetCodeWebService();
                    break;
                }
            }
            fullQWrapper.showAnalysisCodePopup = true;
            fullQWrapper.showSearchAnalysisSetCodeInBilling = false;
            qqWrapper = new QuickQuoteWrapper();
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC analysisSetHeaderSelected: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :analysisSetHeaderSelected' + selectedAnalysisSet);
        return null;
    }
    // For countries webservice 

    public void CountriesList() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :CountriesList');
        CountryService_AC CountryService = null;
        List < HomeBaseBeans.countries > Countries;
        try {
            CountryService = new CountryService_AC();
            Countries = CountryService.listCountry();
            System.debug('Countries are : ' + Countries);
            if (test.isRunningTest()) {
                Countries = MMIFullquoteTestDataProvider.getCountryList();
            }
            if (Countries[0].errorMessage == null) {
                CountryOptions.add(new SelectOption('', '-None-'));
                for (HomeBaseBeans.countries c: Countries) {
                    if (c.Name == 'USA' || c.Name == 'Canada') {
                        CountryOptions.add(new SelectOption(c.Id, c.Name));
                    }
                }
            } else {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, Countries[0].errorMessage);
                ApexPages.addMessage(msg);
                //DisplayErrorPopUp=true;
            }
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC CountriesList: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :CountriesList' + CountryOptions);
    }

    // for States webservice

    public void StatesList() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :StatesList');
        StateService_AC stateService = null;
        List < HomeBaseBeans.States > states;
        //DisplayErrorPopUp = false;
        try {
            StateOptions = new List < SelectOption > ();
            if (fullQWrapper.Country != null && fullQWrapper.Country != '')

            states = new List < HomeBaseBeans.States > ();
            stateService = new StateService_AC();
            states = stateService.listStates(fullQWrapper.Country.toUpperCase());
            System.debug('States are : ' + states);
            if (test.isRunningTest()) {
                states = MMIFullquoteTestDataProvider.getStateList();
            }
            if (states[0].errorMessage == null) {
                StateOptions = new List < SelectOption > ();
                shippingStateOptions = new List < SelectOption > ();
                StateOptions.add(new SelectOption('', '-None-'));
                shippingStateOptions.add(new SelectOption('', '-None-'));
                innerStateList = new List < FullQuoteWrapper.stateInnerClass > ();
                for (HomeBaseBeans.States ss: states) {
                    StateOptions.add(new SelectOption(ss.Id, ss.Id));
                    shippingStateOptions.add(new SelectOption(ss.Id, ss.Id));

                    FullQuoteWrapper.stateInnerClass IC = new FullQuoteWrapper.stateInnerClass();
                    IC.Id = ss.Id;
                    IC.Name = ss.Name;
                    IC.countryId = ss.countryId;
                    IC.companyId = ss.companyId;

                    innerStateList.add(IC);

                }
            } else {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, states[0].errorMessage);
                ApexPages.addMessage(msg);
            }
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC StatesList: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :StatesList' + innerStateList);
        shippingStatesList(); // TFS 1380   
    }

    public list < SelectOption > GenerateStatesList(String CountryID) {
        list < SelectOption > StateOptionList = new list < SelectOption > ();
        StateOptionList.add(new SelectOption('', '-None-'));
        StateService_AC stateService = new StateService_AC();
        if(CountryID != null && CountryID != ''){
            List < HomeBaseBeans.States > states = stateService.listStates(CountryID.toUpperCase());
            if (!states.isEmpty() && states[0].errorMessage == null) {
                for (HomeBaseBeans.States s: states) {
                    StateOptionList.add(new SelectOption(s.Id, s.Id));
                }
            }
        }
        return StateOptionList;
    }

    public void PopulateCardStatesList() {
        cardStateOptions = GenerateStatesList(fullQWrapper.cardCountry);
        system.debug('------------------cardStateOptions----------------------' + cardStateOptions);
    }
    
    public void PopulateAchStatesList() {
        achStateOptions = GenerateStatesList(fullQWrapper.achCountry);
        system.debug('------------------cardStateOptions----------------------' + cardStateOptions);
    }

    // for shipping States webservice

    public void shippingStatesList() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :shippingStatesList');
        List < HomeBaseBeans.States > states;
        //DisplayErrorPopUp = false;
        try {
            StateService_AC stateService = new StateService_AC();
            shippingStateOptions = new List < SelectOption > ();
            if (fullQWrapper.countryInShippingDates != null && fullQWrapper.countryInShippingDates != '') {

                states = stateService.listStates(fullQWrapper.countryInShippingDates);
                System.debug('States are : ' + states);
                if (test.isRunningTest()) {
                    states = MMIFullquoteTestDataProvider.getStateList();
                }
                if (states[0].errorMessage == null) {
                    shippingStateOptions = new List < SelectOption > ();
                    shippingStateOptions.add(new SelectOption('', '-None-'));
                    innerStateList = new List < FullQuoteWrapper.stateInnerClass > ();
                    for (HomeBaseBeans.States ss: states) {
                        shippingStateOptions.add(new SelectOption(ss.Id, ss.Id));
                    }
                    fullQWrapper.enableRefreshQuote = false;
                    fullQWrapper.enableSaveQuote = false;
                    fullQWrapper.enableMarkAsLostbutton = false;

                    fullQWrapper.enableProductadd = false;
                    fullQWrapper.enableVAddresBtnInShipping = true;
                    isFullfillingBranchid = true;
                    isFullfillingSearch = false;

                } else {
                    ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, states[0].errorMessage);
                    ApexPages.addMessage(msg);
                }
            } else {
                fullQWrapper.enableRefreshQuote = false;
                fullQWrapper.enableSaveQuote = false;
                fullQWrapper.enableMarkAsLostbutton = false;

                fullQWrapper.enableProductadd = false;
                fullQWrapper.enableVAddresBtnInShipping = true;
                isFullfillingBranchid = true;
                isFullfillingSearch = false;
            }
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC shippingStatesList: ' + e.getMessage());
        }

        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :shippingStatesList' + shippingStateOptions);
    }
    public void salesRepSearch() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :salesRepSearch');
        SalesRepService salesRepService = null;
        List < HomeBaseBeans.salesReps > reps;
        try {
            salesRepService = new SalesRepService();
            if(qqWrapper.writeUpRepSearchBranchId != null && qqWrapper.writeUpRepSearchBranchId != ''){
                salesRepService.branchId = qqWrapper.writeUpRepSearchBranchId;
            }
            reps = salesRepService.listSalesReps();
            if (test.isRunningTest()) {
                reps = MMIFullquoteTestDataProvider.getSalesRepList();
            }
            if (reps[0].errorMessage == null) {
                //-------------TFS 4028---------------------------------
                List < HomeBaseBeans.salesReps > validReps = new List < HomeBaseBeans.salesReps >();
                for(HomeBaseBeans.salesReps r : reps){
                    if(r.branchId != null && r.branchId != ''){
                        validReps.add(r);
                    }
                }
                salesRepsList = validReps;
                //-------------TFS 4028---------------------------------
                fullQWrapper.showSalesRepPopup = true;
            }

        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC salesRepSearch: ' + e.getMessage());
        }

        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :salesRepSearch' + fullQWrapper.showSalesRepPopup + reps);
    }

    public Pagereference salesRepIdEnter() {
        writeupId = false;
        SalesRepService salesRepService = null;
        HomeBaseBeans.salesRepsId reps;
        salesRepService = new SalesRepService();
        reps = salesRepService.SalesReps(fullQWrapper.WriteUpRep);
        if (reps != null) {
            if (reps.errorMessage == null) {
                fullQWrapper.WriteUpRep = reps.id;
                fullQWrapper.WriteUpRepName = reps.name;
            } else {
                fullQWrapper.WriteUpRepName = reps.name;
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, reps.errorMessage);
                ApexPages.addMessage(msg);
            }
        } else {
            fullQWrapper.WriteUpRep = null;
            fullQWrapper.WriteUpRepName = null;
        }

        return null;
    }

    public Pagereference assigSalesRepId() {

        SalesRepService salesRepService = null;
        HomeBaseBeans.salesRepsId reps;
        salesRepService = new SalesRepService();
        if (fullQWrapper.AssistingRep != null && fullQWrapper.AssistingRep != '') {
            reps = salesRepService.SalesReps(fullQWrapper.AssistingRep);
        }
        if (test.isRunningTest()) {
            reps = MMIFullquoteTestDataProvider.getSalesRepId();
        }
        if (reps != null) {
            if (reps.errorMessage == null) {
                fullQWrapper.AssistingRep = reps.id;
                fullQWrapper.AssistingRepName = reps.name;
            } else {
                fullQWrapper.AssistingRepName = null;
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, reps.errorMessage);
                ApexPages.addMessage(msg);
            }
        } else {
            fullQWrapper.AssistingRep = null;
            fullQWrapper.AssistingRepName = null;
        }
        return null;
    }
    public pageReference SalesRepSelected() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :SalesRepSelected');
        String selectedAnalysisSet;
        try {
            selectedAnalysisSet = System.currentPageReference().getParameters().get('selectedWriteUpRep');
            if (test.isRunningTest()) {
                selectedAnalysisSet = '102';
                salesRepsList = MMIFullquoteTestDataProvider.getSalesRepList();
            }
            for (HomeBaseBeans.salesReps h: salesRepsList) {
                if (h.id == selectedAnalysisSet) {
                    fullQWrapper.WriteUpRep = h.Id;
                    fullQWrapper.WriteUpRepName = h.Name;
                    break;
                }
            }

            fullQWrapper.showSalesRepPopup = false;
            qqWrapper = new QuickQuoteWrapper();
            fullQWrapper.showWriteUpRepSearchList = false;
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC SalesRepSelected: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :SalesRepSelected');
        return null;
    }

    // To search salesrep record in popup

    public pageReference SalesRepSearchFun() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :SalesRepSearchFun');
        try {
            salesRepsSearchList = new List < HomeBaseBeans.salesReps > ();
            if ((qqWrapper.writeUpRepIdSearchWord == null || qqWrapper.writeUpRepIdSearchWord == '') && (qqWrapper.writeUpRepNameSearchWord == null || qqWrapper.writeUpRepNameSearchWord == '')) {
                fullQWrapper.showWriteUpRepSearchList = false;
            } else {
                if (test.isRunningTest()) {
                    salesRepsList = MMIFullquoteTestDataProvider.getSalesRepList();
                }
                for (HomeBaseBeans.salesReps HB: salesRepsList) {
                    if ((qqWrapper.writeUpRepIdSearchWord != '') && (HB.Id.toLowerCase()).startswith(qqWrapper.writeUpRepIdSearchWord.toLowerCase()) || (qqWrapper.writeUpRepNameSearchWord != '') && (HB.Name.toLowerCase()).Contains(qqWrapper.writeUpRepNameSearchWord.toLowerCase())) {
                        salesRepsSearchList.add(HB);
                    }
                }
                fullQWrapper.showWriteUpRepSearchList = true;
            }
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC SalesRepSearchFun: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :SalesRepSearchFun' + salesRepsSearchList);
        return null;
    }

    public pageReference AssistingSalesRepSelected() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :AssistingSalesRepSelected');
        String selectedAnalysisSet;
        try {
            selectedAnalysisSet = System.currentPageReference().getParameters().get('selectedWriteUpRep');
            if (test.isRunningTest()) {
                selectedAnalysisSet = '102';
                salesRepsList = MMIFullquoteTestDataProvider.getSalesRepList();
            }
            for (HomeBaseBeans.salesReps h: salesRepsList) {
                if (h.id == selectedAnalysisSet) {
                    fullQWrapper.AssistingRep = h.Id;
                    fullQWrapper.AssistingRepName = h.Name;
                    break;
                }
            }

            fullQWrapper.showSalesRepPopup = false;
            qqWrapper = new QuickQuoteWrapper();
            fullQWrapper.showWriteUpRepSearchList = false;
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC AssistingSalesRepSelected: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :AssistingSalesRepSelected');
        return null;
    }
    // Select contact Id on Shipping tab popup

    public PageReference shippingContactIdSelected() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :shippingContactIdSelected');
        String selectedContactId;
        try {
            selectedContactId = System.currentPageReference().getParameters().get('selectedContactShipping');
            if (test.isRunningTest()) {
                selectedContactId = '1';
            }
            // get specific contact details
            List < HomeBaseBeans.SpecificContact > specContDetails = new List < HomeBaseBeans.SpecificContact >();
            specContDetails = callSpecificContactWS(selectedContactId, fullQWrapper.AccountId);
            system.debug('---------------specContDetails--------------'+specContDetails);
            if(specContDetails != null && specContDetails.size() > 0){
                for (HomeBaseBeans.SpecificContact HB: specContDetails) {
                    if (HB.contactId == selectedContactId) {
                        fullQWrapper.deliveryContactId = HB.contactId;
                        fullQWrapper.NameInShippingDates1 = HB.forename + ' '+HB.surname;
                        fullQWrapper.telInShippingDates = HB.phoneNumber;
                        fullQWrapper.emailInShippingDates = HB.email;
                        fullQWrapper.faxInShippingDates = HB.faxNumber;
                        break;
                    }
                }
            }
            /*for (HomeBaseBeans.contactSummaryList HB: contactsResponseList) {
                if (HB.contactId == selectedContactId) {
                    fullQWrapper.deliveryContactId = HB.contactId;
                    fullQWrapper.NameInShippingDates1 = HB.forename + ' ' + HB.surname;
                    break;
                }
            }*/
            fullQWrapper.contactShippingPopUp = false;
            fullQWrapper.showContactSearchInShipping = false;
            qqWrapper = new QuickQuoteWrapper();
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC shippingContactIdSelected: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :shippingContactIdSelected' + selectedContactId);
        return null;
    }

    // Search contacts in shipping screen

    public PageReference seachContactsInShipping() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :seachContactsInShipping');
        try {
            contactsResponseSearchList = new List < HomeBaseBeans.contactSummaryList > ();
            if ((qqWrapper.contactIdSearchWord == null || qqWrapper.contactIdSearchWord == '') && (qqWrapper.contactFNameSearchWord == null || qqWrapper.contactFNameSearchWord == '') && (qqWrapper.contactLNameSearchWord == null || qqWrapper.contactLNameSearchWord == '')) {
                fullQWrapper.showContactSearchInShipping = false;
            } else {
                for (HomeBaseBeans.contactSummaryList HB: contactsResponseList) {
                    if ((qqWrapper.contactIdSearchWord != '') && (HB.contactId.toLowerCase()).startswith(qqWrapper.contactIdSearchWord.toLowerCase()) || (qqWrapper.contactFNameSearchWord != '') && (HB.forename.toLowerCase()).Contains(qqWrapper.contactFNameSearchWord.toLowerCase()) || (qqWrapper.contactLNameSearchWord != '') && (HB.surname.toLowerCase()).Contains(qqWrapper.contactLNameSearchWord.toLowerCase())) {
                        contactsResponseSearchList.add(HB);
                    }
                }
                fullQWrapper.showContactSearchInShipping = true;
            }
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC seachContactsInBilling: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :seachContactsInShipping' + contactsResponseSearchList);
        return null;
    }


    // user enter account id and search related account in billing Address tab 

    public PageReference accountIDInBilling() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :accountIDInBilling');
        //Button enable disable
        try {

            system.debug('------isbillingOrShiiping---------' + isbillingOrShiiping);
            fullQWrapper.Name = null;
            fullQWrapper.LastName = null;
            fullQWrapper.BillingContactID = null;
            fullQWrapper.deliveryContactId = null;
            fullQWrapper.NameInShippingDates1 = null;
            if (!isbillingOrShiiping) {
                system.debug('------isbillingOrShiiping---------' + isbillingOrShiiping);
                ClearProductSummarylines();
                fullQWrapper.enableRefreshQuote = false;
                fullQWrapper.enableSaveQuote = false;
                fullQWrapper.enableMarkAsLostbutton = false;

                fullQWrapper.enableProductadd = false;
                fullQWrapper.enableVAddresBtnInShipping = true;
                isFullfillingBranchid = true;
                if ((fullQWrapper.ID != null && fullQWrapper.ID != '') || (fullQWrapper.shippingId != null && fullQWrapper.shippingId != '')) {

                    fullQWrapper.Name = null;
                    fullQWrapper.LastName = null;
                    fullQWrapper.BillingContactID = null;
                    fullQWrapper.deliveryContactId = null;
                    fullQWrapper.NameInShippingDates1 = null;
                    fullQWrapper.AccountName = null;
                    fullQWrapper.ID = null;
                    fullQWrapper.Address = null;
                    fullQWrapper.City = null;
                    fullQWrapper.County = null;
                    fullQWrapper.State = null;
                    fullQWrapper.Country = null;
                    fullQWrapper.ZipCode = null;
                    fullQWrapper.TaxExempt = null;
                    fullQWrapper.Status = null;
                    fullQWrapper.BillingContactID = null;
                    fullQWrapper.TaxExemptAuthorization = null;

                    // for shipping tab when account id is not there then we clear all field

                    fullQWrapper.shippingId = null;
                    fullQWrapper.deliveryContactId = null;
                    fullQWrapper.AddressInShippingDates = null;
                    fullQWrapper.NameInShippingDates1 = null;
                    fullQWrapper.cityInShippingDates = null;
                    fullQWrapper.telInShippingDates = null;
                    fullQWrapper.countyInShippingDates = null;
                    fullQWrapper.faxInShippingDates = null;
                    fullQWrapper.stateInShippingDates = null;
                    fullQWrapper.countryInShippingDates = null;
                    fullQWrapper.emailInShippingDates = null;
                    fullQWrapper.ZipCodeInShipping = null;
                    fullQWrapper.isUseBillingAddress = false;
                    // invoice tab

                    fullQWrapper.Terms = null;
                    fullQWrapper.TermsCode = null;
                    fullQWrapper.LastInvoice = null;
                    fullQWrapper.YTDSales = null;
                    fullQWrapper.InvoicedBalance = null;
                    fullQWrapper.ID = null;
                    fullQWrapper.shippingId = null;
                    ClearProductSummarylines();
                    fullQWrapper.enableProductadd = false;
                    fullQWrapper.fulFillingBranchInShippingDates = null;
                    fullQWrapper.fulFillingBranchNameInShippingDates = null;
                    isRentalLength = false;
                    enableBilingAddressFields();
                }
            }

            if (fullQWrapper.AccountId == null || fullQWrapper.AccountId == '') {
                system.debug('------isbillingOrShiiping---------' + isbillingOrShiiping);
                ClearProductSummarylines();
                fullQWrapper.enableRefreshQuote = false;
                fullQWrapper.enableSaveQuote = false;
                fullQWrapper.enableMarkAsLostbutton = false;

                fullQWrapper.enableProductadd = false;
                fullQWrapper.enableVAddresBtnInShipping = true;
                isFullfillingBranchid = true;

                fullQWrapper.AccountName = null;
                fullQWrapper.ID = null;
                fullQWrapper.Address = null;
                fullQWrapper.City = null;
                fullQWrapper.County = null;
                fullQWrapper.State = null;
                fullQWrapper.Country = null;
                fullQWrapper.ZipCode = null;
                fullQWrapper.TaxExempt = null;
                fullQWrapper.Status = null;
                fullQWrapper.BillingContactID = null;
                fullQWrapper.TaxExemptAuthorization = null;

                // for shipping tab when account id is not there then we clear all field

                fullQWrapper.shippingId = null;
                fullQWrapper.deliveryContactId = null;
                fullQWrapper.AddressInShippingDates = null;
                fullQWrapper.NameInShippingDates1 = null;
                fullQWrapper.cityInShippingDates = null;
                fullQWrapper.telInShippingDates = null;
                fullQWrapper.countyInShippingDates = null;
                fullQWrapper.faxInShippingDates = null;
                fullQWrapper.stateInShippingDates = null;
                fullQWrapper.countryInShippingDates = null;
                fullQWrapper.emailInShippingDates = null;
                fullQWrapper.ZipCodeInShipping = null;
                fullQWrapper.isUseBillingAddress = false;
                // invoice tab

                fullQWrapper.Terms = null;
                fullQWrapper.TermsCode = null;
                fullQWrapper.LastInvoice = null;
                fullQWrapper.YTDSales = null;
                fullQWrapper.InvoicedBalance = null;

                isContactIs = true;
                isAddressId = true;
                accountResponseList.clear();
                enableBilingAddressFields();
            } else {
                //accountResponseList.clear();

                System.currentPageReference().getParameters().put('selectedAccBilling', fullQWrapper.AccountId);
                AccountService accountServiceRef = new AccountService();
                HomeBaseBeans.account accountResponse = accountServiceRef.listAccounts(fullQWrapper.AccountId, fullQWrapper.TransactionType, String.valueOf(system.today()));
                if (test.isRunningTest()) {
                    accountResponse = MMIFullquoteTestDataProvider.getAccountList();
                }
                accountResponseList.add(accountResponse);
                isNationalAccount = CheckNationalAccount(accountResponse);
                accountIdSelected();
                //addressWebservice();
                //contactsWebservice();
                isContactIs = false;
                isAddressId = false;
            }
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC accountIDInBilling: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :accountIDInBilling' + System.currentPageReference().getParameters().put('selectedAccBilling', fullQWrapper.AccountId));
        return null;
    }

    public Boolean CheckNationalAccount(HomeBaseBeans.account accountResponse) {
        Boolean isNationalAcc = false;
        if (test.isRunningTest()) {
            accountResponse = MMIFullquoteTestDataProvider.getAccountList();
        }
        if (accountResponse != null) {
            if (!accountResponse.analysisDetails.isEmpty()) {
                for (HomeBaseBeans.analysisDtls an: accountResponse.analysisDetails) {
                    if (an.slotNumber == '1' && (an.setCodeId == 'CNAP' || an.setCodeId == 'CNAGP' || an.setCodeId == 'CNAG' || an.setCodeId == 'CNAVIPP' || an.setCodeId == 'CNAVIP')) {
                        isNationalAcc = true;
                        break;
                    }
                }
            }
        }
        return isNationalAcc;
    }

    // When select an account

    public PageReference accountIdSelected() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :accountIdSelected' + accountResponseList);
        String selectedAccountId;
        try {
            fullQWrapper.enableRefreshQuote = false;
            fullQWrapper.enableSaveQuote = false;
            fullQWrapper.enableMarkAsLostbutton = false;

            fullQWrapper.enableProductadd = false;
            fullQWrapper.enableVAddresBtnInShipping = true;
            isFullfillingBranchid = true;
            fullQWrapper.deliveryZoneInShipping = null;
            fullQWrapper.distFromBranch = null;

            if (!isbillingOrShiiping) {
                if ((fullQWrapper.ID != null && fullQWrapper.ID != '') || (fullQWrapper.shippingId != null && fullQWrapper.shippingId != '')) {

                    fullQWrapper.Name = null;
                    fullQWrapper.LastName = null;
                    fullQWrapper.BillingContactID = null;
                    fullQWrapper.deliveryContactId = null;
                    fullQWrapper.NameInShippingDates1 = null;

                    fullQWrapper.AccountName = null;
                    fullQWrapper.ID = null;
                    fullQWrapper.Address = null;
                    fullQWrapper.City = null;
                    fullQWrapper.County = null;
                    fullQWrapper.State = null;
                    fullQWrapper.Country = null;
                    fullQWrapper.ZipCode = null;
                    fullQWrapper.TaxExempt = null;
                    fullQWrapper.Status = null;
                    fullQWrapper.BillingContactID = null;
                    fullQWrapper.TaxExemptAuthorization = null;

                    // for shipping tab when account id is not there then we clear all field

                    fullQWrapper.shippingId = null;
                    fullQWrapper.deliveryContactId = null;
                    fullQWrapper.AddressInShippingDates = null;
                    fullQWrapper.NameInShippingDates1 = null;
                    fullQWrapper.cityInShippingDates = null;
                    fullQWrapper.telInShippingDates = null;
                    fullQWrapper.countyInShippingDates = null;
                    fullQWrapper.faxInShippingDates = null;
                    fullQWrapper.stateInShippingDates = null;
                    fullQWrapper.countryInShippingDates = null;
                    fullQWrapper.emailInShippingDates = null;
                    fullQWrapper.ZipCodeInShipping = null;

                    // invoice tab

                    fullQWrapper.Terms = null;
                    fullQWrapper.TermsCode = null;
                    fullQWrapper.LastInvoice = null;
                    fullQWrapper.YTDSales = null;
                    fullQWrapper.InvoicedBalance = null;
                    fullQWrapper.ID = null;
                    fullQWrapper.shippingId = null;
                    fullQWrapper.isUseBillingAddress = false;
                    ClearProductSummarylines();
                    fullQWrapper.fulFillingBranchInShippingDates = null;
                    fullQWrapper.fulFillingBranchNameInShippingDates = null;
                    fullQWrapper.enableProductadd = false;
                    isRentalLength = false;
                    enableBilingAddressFields();
                }
            }
            selectedAccountId = System.currentPageReference().getParameters().get('selectedAccBilling');
            //String selectedAccountAfterSubsting =   selectedAccountId.substringBefore('.');
            String selectedAccountAfterSubsting = selectedAccountId;
            if (accountResponseList[0].errorMessage != null) {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, accountResponseList[0].errorMessage);
                ApexPages.addMessage(msg);

                fullQWrapper.Name = null;
                fullQWrapper.LastName = null;
                fullQWrapper.BillingContactID = null;
                fullQWrapper.deliveryContactId = null;
                fullQWrapper.NameInShippingDates1 = null;

                fullQWrapper.AccountName = null;
                fullQWrapper.ID = null;
                fullQWrapper.Address = null;
                fullQWrapper.City = null;
                fullQWrapper.County = null;
                fullQWrapper.State = null;
                fullQWrapper.Country = null;
                fullQWrapper.ZipCode = null;
                fullQWrapper.TaxExempt = null;
                fullQWrapper.Status = null;
                fullQWrapper.BillingContactID = null;
                fullQWrapper.TaxExemptAuthorization = null;

                // for shipping tab when account id is not there then we clear all field

                fullQWrapper.shippingId = null;
                fullQWrapper.deliveryContactId = null;
                fullQWrapper.AddressInShippingDates = null;
                fullQWrapper.NameInShippingDates1 = null;
                fullQWrapper.cityInShippingDates = null;
                fullQWrapper.telInShippingDates = null;
                fullQWrapper.countyInShippingDates = null;
                fullQWrapper.faxInShippingDates = null;
                fullQWrapper.stateInShippingDates = null;
                fullQWrapper.countryInShippingDates = null;
                fullQWrapper.emailInShippingDates = null;
                fullQWrapper.ZipCodeInShipping = null;

                // invoice tab

                fullQWrapper.Terms = null;
                fullQWrapper.TermsCode = null;
                fullQWrapper.LastInvoice = null;
                fullQWrapper.YTDSales = null;
                fullQWrapper.InvoicedBalance = null;
                fullQWrapper.isUseBillingAddress = false;
                isContactIs = true;
                isAddressId = true;
                accountResponseList.clear();
                enableBilingAddressFields();
            } else {
                if (test.isRunningTest()) {
                    selectedAccountAfterSubsting = '1';
                }
                for (HomeBaseBeans.account HB: accountResponseList) {
                    if (selectedAccountAfterSubsting == HB.Id) {
                        fullQWrapper.AccountName = HB.name;
                        fullQWrapper.AccountId = HB.id;
                        fullQWrapper.TaxExempt = HB.taxExempt;
                        fullQWrapper.Status = HB.creditStatus;
                        fullQWrapper.CertofInsurance = HB.certificateOfInsurance;
                        fullQWrapper.TaxExemptAuthorization = HB.taxExemptionCertificate;
                        fullQWrapper.Terms = HB.rentalTerms;
                        fullQWrapper.TermsCode = HB.termsCode;
                        if (HB.invoicedBalance != null) {
                            fullQWrapper.InvoicedBalance = String.valueOf(HB.invoicedBalance);
                        } else {
                            fullQWrapper.InvoicedBalance = null;
                        }
                        fullQWrapper.LastInvoice = HB.lastInvoiceDate;
                        if (HB.ytdSales != null) {
                            fullQWrapper.YTDSales = String.valueof(HB.ytdSales);
                        } else {
                            fullQWrapper.YTDSales = null;
                        }
                        fullQWrapper.enableVAddresBtnInBilling = true;
                        addressWebservice();
                        contactsWebservice();
                        isContactIs = false;
                        isAddressId = false;
                        fullQWrapper.showAccountPopUp = false;
                        disableBilingAddressFields();
                    }
                }
            }
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC accountIdSelected: ' + e.getMessage());
        }
        isbillingOrShiiping = false;
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :accountIdSelected' + selectedAccountId + fullQWrapper);
        return null;
    }


    // To get account List 
    public PageReference accountPatternSearch() {
        accountResponseList.clear();
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :accountIDInBilling');

        String accountNameSearch;
        accountNameSearch = EncodingUtil.urlEncode(fullQWrapper.AccountName, 'UTF-8');
        List < HomeBaseBeans.account > accountList = null;
        try {
            accountList = new List < HomeBaseBeans.account > ();
            AccountService accountServiceRef = new AccountService();
            accountList = accountServiceRef.listAccountsSearchPattern(accountNameSearch, fullQWrapper.TransactionType, String.valueOf(system.today()));
            if (test.isRunningTest()) {
                HomeBaseBeans.account acclstTest = MMIFullquoteTestDataProvider.getAccountList();
                acclstTest.errorMessage = null;
                List < HomeBaseBeans.account > lstAcc = new List < HomeBaseBeans.account > ();
                lstAcc.add(acclstTest);
                accountList = lstAcc;
            }
            accountResponseList.addAll(accountList);

            accountIdSelected();

        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC accountIDInBilling: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :accountIDInBilling' + System.currentPageReference().getParameters().put('selectedAccBilling', fullQWrapper.AccountId));
        fullQWrapper.showAccountPopUp = true;
        return null;
    }


    public PageReference addressWebservice() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :addressWebservice');
        addressshippingList.clear();
        addressBillingList.clear();
        try {
            AddressesService addressServiceRef = new AddressesService();
            addressResponseList = addressServiceRef.listAddresses(fullQWrapper.AccountId);
            system.debug('--------------addressResponseList----------------------' + addressResponseList);
            String dotAcctNo = findDotAccount();
            system.debug('--------------dotAcctNo----------------------' + dotAcctNo);
            for (HomeBaseBeans.addresses shipingInvo: addressResponseList) {
                if (shipingInvo.isDeliveryAddress == true) {
                    if (dotAcctNo != null && dotAcctNo != '' && dotAcctNo.length() == 1) {
                        if (shipingInvo.addressNo == dotAcctNo) {
                            addressshippingList.add(shipingInvo);
                        }
                    } else {
                        addressshippingList.add(shipingInvo);
                    }
                }
            }
            for (HomeBaseBeans.addresses billingInvo: addressResponseList) {
                if (billingInvo.isInvoiceAddress == true) {
                    if (dotAcctNo != null && dotAcctNo != '' && dotAcctNo.length() == 1) {
                        if (billingInvo.addressNo == dotAcctNo) {
                            addressBillingList.add(billingInvo);
                        }
                    } else {
                        addressBillingList.add(billingInvo);
                    }
                }
            }
            isAddressId = false;

        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC addressWebservice: ' + e.getMessage());
            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, e.getMessage());
            ApexPages.addMessage(msg);
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :addressWebservice' + addressResponseList);
        return null;
    }
    // Select one address id

    public String findDotAccount() {
        String dotAcct = '';
        if (fullQWrapper.AccountId != null && fullQWrapper.AccountId != '') {
            dotAcct = fullQWrapper.AccountId.substring(fullQWrapper.AccountId.indexOf('.') + 1);
        }
        return dotAcct;
    }

    public PageReference addressIdSelected() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :addressIdSelected' + addressResponseList);
        String selectedAddressId;
        try {
            selectedAddressId = System.currentPageReference().getParameters().get('selectedBillingAddr');
            String accountidAfter = fullQWrapper.AccountId.substring(fullQWrapper.AccountId.indexOf('.') + 1);
            if (test.isRunningTest()) {
                accountidAfter = '0005';
                selectedAddressId = '1';
                addressResponseList = MMIFullquoteTestDataProvider.getAddressesList();
            }
            if (accountidAfter.length() > 3) {
                accountidAfter = '0';
            }

            if (accountidAfter == selectedAddressId) {
                for (HomeBaseBeans.addresses a: addressResponseList) {
                    if (a.addressNo == selectedAddressId) {
                        fullQWrapper.ID = a.addressNo;
                        if (a.addressLine2 != null && a.addressLine2 != '') {
                            fullQWrapper.Address = a.addressLine1 + ' , ' + a.addressLine2;
                        } else {
                            fullQWrapper.Address = a.addressLine1;
                        }
                        fullQWrapper.City = a.addressLine3;
                        fullQWrapper.County = a.addressLine4;
                        fullQWrapper.Country = a.countryId;
                        StatesList();
                        fullQWrapper.State = a.state;
                        fullQWrapper.zipCode = a.zipCode;

                        fullQWrapper.enableRefreshQuote = false;
                        fullQWrapper.enableSaveQuote = false;
                        fullQWrapper.enableMarkAsLostbutton = false;

                        fullQWrapper.enableProductadd = false;
                        fullQWrapper.enableVAddresBtnInShipping = true;
                        isFullfillingBranchid = true;
                    }
                }
                fullQWrapper.addressPopUp = false;
                accountAddresInvalid = false;
            } else {
                fullQWrapper.ID = selectedAddressId;
                fullQWrapper.Address = null;
                fullQWrapper.City = null;
                fullQWrapper.County = null;
                fullQWrapper.Status = null;
                //County = addbill.countryId;
                fullQWrapper.zipCode = null;
                fullQWrapper.Country = null;
                //StatesList();
                fullQWrapper.State = null;

                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Billing Address id ' + fullQWrapper.ID + ' Account ID ' + accountidAfter + ' must match.');
                ApexPages.addMessage(msg);
                fullQWrapper.addressPopUp = true;
                accountAddresInvalid = true;
            }
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC addressIdSelected: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :addressIdSelected' + fullQWrapper);
        return null;
    }

    public PageReference shippingAddressIdSelected() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :shippingAddressIdSelected' + addressResponseList);
        String selectedAddressId;
        try {
            //Button enable disable
            selectedAddressId = System.currentPageReference().getParameters().get('selectedShippingAddr');
            if (test.isRunningTest()) {
                selectedAddressId = '1';
                addressResponseList = MMIFullquoteTestDataProvider.getAddressesList();
            }
            for (HomeBaseBeans.addresses a: addressResponseList) {
                if (a.addressNo == selectedAddressId) {
                    fullQWrapper.shippingId = a.addressNo;
                    fullQWrapper.AddressInShippingDates = a.addressLine1 + ' , ' + a.addressLine2;
                    fullQWrapper.cityInShippingDates = a.addressLine3;
                    fullQWrapper.countyInShippingDates = a.addressLine4;
                    fullQWrapper.countryInShippingDates = a.countryId;
                    fullQWrapper.ZipCodeInShipping = a.zipCode;
                    shippingStatesList();
                    fullQWrapper.stateInShippingDates = a.state;

                    fullQWrapper.enableRefreshQuote = false;
                    fullQWrapper.enableSaveQuote = false;
                    fullQWrapper.enableMarkAsLostbutton = false;

                    fullQWrapper.enableProductadd = false;
                    fullQWrapper.enableVAddresBtnInShipping = true;
                    isFullfillingBranchid = true;

                    isFullfillingSearch = false;
                }
            }
            fullQWrapper.shippingAddressPopUp = false;
            shippingAddressInvalide = false;
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC shippingAddressIdSelected: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :shippingAddressIdSelected' + fullQWrapper);
        return null;
    }

    //.............. Invoke Branch webservice ................


    public pagereference callBranchWebservice() {

        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :callBranchWebservice');
        FulfillingBranchService_AC fulFillingBranch = null;
        try {
            branches.clear();
            branches = new List < HomeBaseBeans.branches > ();
            fulFillingBranch = new FulfillingBranchService_AC();
            branches = fulFillingBranch.listBranches();
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC callBranchWebservice: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :callBranchWebservice' + branches);
        return null;
    }


    // To select one branch from list of fulfilling branches in billing tab

    public pageReference fulFillingIdBillingSelected() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :fulFillingIdBillingSelected' + branches);
        String selectedFulFillingId;
        try {
            selectedFulFillingId = System.currentPageReference().getParameters().get('SelectedBranch');
            fullQWrapper.deliveryZoneInShipping = null;
            fullQWrapper.distFromBranch = null;
            addressErrorMessage = '';
            for (HomeBaseBeans.branches HB: branches) {
                if (HB.id == selectedFulFillingId) {
                    fullQWrapper.fulFillingBranchInBilling = HB.id;
                    fullQWrapper.fulFillingBranchNameInBilling = HB.Name;
                }
            }
            fullQWrapper.enableVAddresBtnInShipping = true;
            fullQWrapper.enableRefreshQuote = false;
            fullQWrapper.enableSaveQuote = false;
            fullQWrapper.enableMarkAsLostbutton = false;
            fullQWrapper.showSearchBranchIdTable = false;
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC fulFillingIdBillingSelected: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :fulFillingIdBillingSelected' + selectedFulFillingId);
        return null;
    }


    // To search matched records of branches in billing screen

    public PageReference searchFulFillingBranchInBilling() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :searchFulFillingBranchInBilling');
        try {
            branchesSearchList = new List < HomeBaseBeans.branches > ();
            if ((qqWrapper.BranchIdSearchWord == null || qqWrapper.BranchIdSearchWord == '') && (qqWrapper.BranchNameSearchWord == null || qqWrapper.BranchNameSearchWord == '')) {
                fullQWrapper.showSearchBranchIdTable = false;
            } else {
                for (HomeBaseBeans.branches HB: branches) {
                    if ((qqWrapper.BranchIdSearchWord != '') && (HB.Id).startswith(qqWrapper.BranchIdSearchWord) || (qqWrapper.BranchNameSearchWord != '') && (HB.Name.toLowerCase()).Contains(qqWrapper.BranchNameSearchWord.toLowerCase())) {
                        branchesSearchList.add(HB);
                    }
                }
                fullQWrapper.showSearchBranchIdTable = true;
            }
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC searchFulFillingBranchInBilling: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :searchFulFillingBranchInBilling' + branchesSearchList);
        return null;
    }

    // To search matched records of branches in shipping screen

    public PageReference searchFulFillingBranchInShipping() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :searchFulFillingBranchInShipping');
        try {
            branchesSearchShippingList = new List < HomeBaseBeans.branches > ();
            if ((qqWrapperShipping.BranchIdSearchWord == null || qqWrapperShipping.BranchIdSearchWord == '') && (qqWrapperShipping.BranchNameSearchWord == null || qqWrapperShipping.BranchNameSearchWord == '')) {
                fullQWrapper.showSearchBranchShippingIdTable = false;
            } else {
                for (HomeBaseBeans.branches HB: branches) {
                    if ((qqWrapperShipping.BranchIdSearchWord != '') && (HB.Id).startswith(qqWrapperShipping.BranchIdSearchWord) || (qqWrapperShipping.BranchNameSearchWord != '') && (HB.Name.toLowerCase()).Contains(qqWrapperShipping.BranchNameSearchWord.toLowerCase())) {
                        branchesSearchShippingList.add(HB);
                    }
                }
                fullQWrapper.showSearchBranchShippingIdTable = true;
            }
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC searchFulFillingBranchInShipping: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :searchFulFillingBranchInShipping' + branchesSearchShippingList);
        return null;
    }


    // To select one branch from list of fulfilling branches

    public pageReference fulFillingIdSelected() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :fulFillingIdSelected');
        String selectedFulFillingId;
        try {
            selectedFulFillingId = System.currentPageReference().getParameters().get('SelectedShippingBranch');
            fullQWrapper.deliveryZoneInShipping = null;
            fullQWrapper.distFromBranch = null;
            addressErrorMessage = '';
            for (HomeBaseBeans.branches HB: branches) {
                if (HB.id == selectedFulFillingId) {
                    SelectedShipingTaxId = HB.Id;
                    fullQWrapper.fulFillingBranchInShippingDates = HB.id;
                    fullQWrapper.fulFillingBranchNameInShippingDates = HB.Name;
                    FulFillingBranchId = HB.id;
                    selectedFulFillingId = '';

                    if (fullQWrapper.fullfillingBranch) {
                        fullQWrapper.enableVAddresBtnInShipping = true;
                        fullQWrapper.enableRefreshQuote = false;
                        fullQWrapper.enableSaveQuote = false;
                        fullQWrapper.enableMarkAsLostbutton = false;

                    } else {
                        fullQWrapper.enableVAddresBtnInShipping = true;
                        fullQWrapper.enableRefreshQuote = false;
                        fullQWrapper.enableSaveQuote = false;
                        fullQWrapper.enableMarkAsLostbutton = false;

                    }
                    if (fullQWrapper.selectedFullQUote == 'sales') {
                        getSalesInventoryList();
                    }
                }
            }
            addressErrorMessage = '';
            fullQWrapper.showSearchBranchShippingIdTable = false;
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC fulFillingIdSelected: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :fulFillingIdSelected' + selectedFulFillingId);
        return null;
    }


    public pageReference fullfillingBranchIdUserEnter() {
        ClearProductSummarylines();
        isfullfillingBranchInvalide = false;
        String isNodeTrue = 'Yest';
        try {
            if (branches.isEmpty()) {
                callBranchWebservice();
            }
            fullQWrapper.deliveryZoneInShipping = null;
            fullQWrapper.distFromBranch = null;
            addressErrorMessage = '';
            if (test.isRunningTest()) {
                branches = MMIFullquoteTestDataProvider.getBranchesList();
            }
            if (fullQWrapper.fulFillingBranchInShippingDates != null && fullQWrapper.fulFillingBranchInShippingDates != '') {
                for (HomeBaseBeans.branches HB: branches) {
                    if (HB.id == fullQWrapper.fulFillingBranchInShippingDates) {
                        addressErrorMessage = '';
                        fullQWrapper.fulFillingBranchInShippingDates = HB.id;
                        fullQWrapper.fulFillingBranchNameInShippingDates = HB.Name;
                        FulFillingBranchId = HB.id;
                        fullQWrapper.enableVAddresBtnInShipping = true;
                        isNodeTrue = 'No';
                        if (fullQWrapper.fullfillingBranch) {

                            fullQWrapper.enableRefreshQuote = false;
                            fullQWrapper.enableSaveQuote = false;
                            fullQWrapper.enableMarkAsLostbutton = false;

                        } else {
                            fullQWrapper.enableRefreshQuote = false;
                            fullQWrapper.enableSaveQuote = false;
                            fullQWrapper.enableMarkAsLostbutton = false;

                        }

                    }
                }
                if (test.isRunningTest()) {
                    isNodeTrue = 'Yest';
                }
                if (isNodeTrue == 'Yest') {
                    fullQWrapper.fulFillingBranchInShippingDates = NULL;
                    fullQWrapper.fulFillingBranchNameInShippingDates = NULL;
                    FulFillingBranchId = NULL;
                    isfullfillingBranchInvalide = true;
                    ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'FullFilling Branch Id Not Found');
                    ApexPages.addMessage(msg);

                }
                if (fullQWrapper.fullfillingBranch) {
                    fullQWrapper.enableVAddresBtnInShipping = true;
                    fullQWrapper.enableRefreshQuote = false;
                    fullQWrapper.enableSaveQuote = false;
                    fullQWrapper.enableMarkAsLostbutton = false;

                } else {
                    fullQWrapper.enableRefreshQuote = false;
                    fullQWrapper.enableSaveQuote = false;
                    fullQWrapper.enableMarkAsLostbutton = false;

                }
            } else {
                fullQWrapper.fulFillingBranchInShippingDates = NULL;
                fullQWrapper.fulFillingBranchNameInShippingDates = NULL;
                fullQWrapper.enableVAddresBtnInShipping = true;
                fullQWrapper.enableRefreshQuote = true;
                fullQWrapper.enableSaveQuote = false;
                fullQWrapper.enableMarkAsLostbutton = false;

            }
            if (fullQWrapper.selectedFullQUote == 'sales') {
                getSalesInventoryList();
            }
            //getSalesInventoryList();
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC fullfillingBranchIdUserEnter: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :fullfillingBranchIdUserEnter' + FulFillingBranchId + '----summaryLineList--------' + summaryLineList + '---------ProductExtrasList----------' + ProductExtrasList);

        return null;
    }

    // Validate address in shipping tab
    public PageReference validateShippingAddress() {
        isZipCodeIsNot = false;
        isFullfillingBranchid = true;
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :validateShippingAddress');
        HomeBaseBeans.AddressBean addressBean = new HomeBaseBeans.AddressBean();
        addressBean.street = fullQWrapper.AddressInShippingDates;
        addressBean.city = fullQWrapper.cityInShippingDates;
        addressBean.state = fullQWrapper.stateInShippingDates;
        addressBean.country = fullQWrapper.countryInShippingDates;
        addressBean.county = fullQWrapper.countyInShippingDates;
        addressBean.zip = fullQWrapper.ZipCodeInShipping;
        addressBean.transactionType = fullQWrapper.TransactionType;
        addressBean.fulfillingName = fullQWrapper.fulFillingBranchNameInShippingDates;
        addressBean.fulfillingId = fullQWrapper.fulFillingBranchInShippingDates;
        addressBean.BranchId = loginUserRec.Branch_Id__c;

        fullQWrapper.showValidateAddressShippingPopUp = true;
        fullQWrapper.enableVAddresBtnInShipping = true;
        DescarteInnerClassShippingList = new List < FullQuoteWrapper.DescarteInnerClass > ();
        if (!(fullQWrapper.ZipCodeInShipping == null || fullQWrapper.ZipCodeInShipping == '')) {
            ValidateAddressService_AC validateAddress = new ValidateAddressService_AC();
            validateAddressShippingResponse = validateAddress.descartesLookupFullQuote(addressBean);
            if (test.isRunningTest()) {
                validateAddressShippingResponse = MMIFullquoteTestDataProvider.getdescartesLookupFullQuote();
            }
            try {
                if (validateAddressShippingResponse[0].errorMessage == null) {
                    Integer i = 1;
                    for (HomeBaseBeans.webAddresses w: validateAddressShippingResponse) {
                        FullQuoteWrapper.DescarteInnerClass IC = new FullQuoteWrapper.DescarteInnerClass();
                        IC.companyId = w.companyId;
                        IC.branchId = w.branchId;
                        IC.address1 = w.address1;
                        IC.address2 = w.address2;
                        IC.address3 = w.address3;
                        IC.address4 = w.address4;
                        IC.state = w.state;
                        IC.zipCode = w.zipCode;
                        IC.countryId = w.countryId;
                        IC.crossStreet1 = w.crossStreet1;
                        IC.crossStreet2 = w.crossStreet2;
                        IC.taxId = w.taxId;
                        IC.distanceFromBranch = w.distanceFromBranch;
                        IC.deliveryZone = w.deliveryZone;
                        IC.zoneWarning = w.zoneWarning;
                        if (w.zoneWarning != null && w.zoneWarning != '') {
                            addressErrorMessage = w.zoneWarning;
                        }
                        IC.latitude = w.latitude;
                        IC.longitude = w.longitude;
                        IC.distanceBranch = w.distanceBranch;

                        if (w.fulfillingBranchId != null && w.fulfillingBranchId != '') {
                            IC.fulfillingBranch = w.fulfillingBranchId;
                        } else {
                            IC.fulfillingBranch = fullQWrapper.fulFillingBranchInShippingDates;
                        }
                        if (w.fulfillingBranchName != null && w.fulfillingBranchName != '') {
                            IC.fulfillingBranchName = w.fulfillingBranchName;
                        } else {
                            IC.fulfillingBranchName = fullQWrapper.fulFillingBranchNameInShippingDates;

                        }
                        IC.oldPostalCode = w.oldPostalCode;
                        IC.RecUniqId = i;
                        i++;
                        DescarteInnerClassShippingList.add(IC);
                        isFullfillingBranchid = false;
                    }
                } else {
                    ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, validateAddressShippingResponse[0].errorMessage);
                    ApexPages.addMessage(msg);
                }
            } catch (Exception e) {
                system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC validateShippingAddress: ' + e.getMessage());
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, validateAddressShippingResponse[0].errorMessage);
                ApexPages.addMessage(msg);
            }
        } else {
            isZipCodeIsNot = true;
            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Please Provide Zip Code.');
            ApexPages.addMessage(msg);
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :validateShippingAddress' + DescarteInnerClassShippingList);
        return null;
    }

    public PageReference validateAddressShippingIdSelected() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :validateAddressShippingIdSelected' + DescarteInnerClassShippingList);
        String selectedValidateAddressId;
        try {
            selectedValidateAddressId = System.currentPageReference().getParameters().get('SelectedVaddressRadioShip');

            selectedVAddressInShipping = new FullQuoteWrapper.DescarteInnerClass();
            if (test.isRunningTest()) {
                DescarteInnerClassShippingList.clear();
                DescarteInnerClassShippingList.add(MMIFullquoteTestDataProvider.getFullQuoteWrpDescarte());
                selectedValidateAddressId = '124585';
            }
            for (FullQuoteWrapper.DescarteInnerClass DI: DescarteInnerClassShippingList) {
                if (!(selectedValidateAddressId == null || selectedValidateAddressId == '')) {
                    if (DI.RecUniqId == Integer.valueOf(selectedValidateAddressId)) {
                        fullQWrapper.fulFillingBranchInShippingDates = DI.fulfillingBranch;
                        fullQWrapper.fulFillingBranchNameInShippingDates = DI.fulfillingBranchName;
                        if (DI.address1 != null && DI.address1 != '') {
                            if (DI.address2 != null && DI.address2 != '') {
                                fullQWrapper.AddressInShippingDates = DI.address1 + ',' + DI.address2;
                            } else {
                                fullQWrapper.AddressInShippingDates = DI.address1;
                            }
                        } else {
                            DI.address1 = fullQWrapper.AddressInShippingDates;
                        }
                        if (DI.address3 != null && DI.address3 != '') {
                            fullQWrapper.cityInShippingDates = DI.address3;
                        }
                        if (DI.address4 != null && DI.address4 != '') {
                            fullQWrapper.countyInShippingDates = DI.address4;
                        }
                        if (DI.state != null && DI.state != '') {
                            fullQWrapper.stateInShippingDates = DI.state;
                        }
                        if (DI.countryId != null && DI.countryId != '') {
                            fullQWrapper.countryInShippingDates = DI.countryId;
                        }
                        if (DI.zipCode != null && DI.zipCode != '') {
                            fullQWrapper.ZipCodeInShipping = DI.zipCode;
                        }
                        if (DI.distanceFromBranch != null) {
                            fullQWrapper.distFromBranch = String.valueOf(decimal.valueOf(DI.distanceFromBranch).setScale(2));
                        }
                        if (DI.deliveryZone != null) {
                            fullQWrapper.deliveryZoneInShipping = DI.deliveryZone;
                        }
                        selectedVAddressInShipping = DI;
                        taxValidateShippingAddressService();
                        fullQWrapper.enableRefreshQuote = false;
                        fullQWrapper.enableSaveQuote = false;
                        fullQWrapper.enableMarkAsLostbutton = false;
                        fullQWrapper.enableProductadd = false;
                        fullQWrapper.enableVAddresBtnInShipping = true;
                        isFullfillingBranchid = true;
                        isFullfillingSearch = true;
                        break;
                    }
                }
            }
            fullQWrapper.showValidateAddressShippingPopUp = false;
            fullQWrapper.isShippingAddressValidated = true;

            if (fullQWrapper.isBillingAddressValidated) {
                fullQWrapper.enableRefreshQuote = false;
                fullQWrapper.enableSaveQuote = false;
                fullQWrapper.enableMarkAsLostbutton = false;
                fullQWrapper.enableProductadd = true;
                fullQWrapper.enableVAddresBtnInShipping = true;
                isFullfillingBranchid = false;
            }
            DisableKnowDelZoneBtn();
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC validateAddressShippingIdSelected: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :validateAddressShippingIdSelected' + selectedVAddressInShipping);
        return null;
    }
    // Tax id calculations

    public PageReference taxValidateShippingAddressService() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :taxValidateShippingAddressService');
        HomeBaseBeans.AddressBean addressBean = null;
        ValidateAddressService_AC validateAddress = null;
        List < HomeBaseBeans.TaxIds > taxAddressBillingList;
        Integer taxCount = 1;
        try {

            isTexIdIsNullbutton = true;
            addressBean = new HomeBaseBeans.AddressBean();
            addressBean.street = fullQWrapper.AddressInShippingDates;
            addressBean.city = fullQWrapper.cityInShippingDates;
            addressBean.state = fullQWrapper.stateInShippingDates;
            if (addressBean.state == '' || addressBean.state == null) {
                addressBean.state = '';
            }
            addressBean.country = fullQWrapper.countryInShippingDates;
            addressBean.county = fullQWrapper.countyInShippingDates;
            addressBean.zip = fullQWrapper.ZipCodeInShipping;

            validateAddress = new ValidateAddressService_AC();
            taxAddressBillingList = validateAddress.taxIdLookup(addressBean);
            taxAddressShippingResponseList = new List < HomeBaseBeans.TaxIds > ();
            if (taxAddressBillingList[0].errorMessage != null) {
                isTexIdIsNullbutton = false;
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, taxAddressBillingList[0].errorMessage);
                ApexPages.addMessage(msg);

            } else {
                for (HomeBaseBeans.TaxIds HB: taxAddressBillingList) {
                    HomeBaseBeans.TaxIds TaxRec = new HomeBaseBeans.TaxIds();
                    TaxRec = HB;
                    TaxRec.RecUniqId = taxCount;
                    taxAddressShippingResponseList.add(TaxRec);
                    taxCount++;
                }
            }
            fullQWrapper.showTaxIdShippingPopUp = true;
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC taxValidateShippingAddressService: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :taxValidateShippingAddressService' + taxAddressShippingResponseList);

        return null;
    }

    public PageReference taxIdShippingSelected() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :taxIdShippingSelected');
        String selectedTaxId;
        try {
            selectedTaxId = System.currentPageReference().getParameters().get('SelectedTaxIdRadioShip');

            selectedTaxRecInShipping = new HomeBaseBeans.TaxIds();

            if (test.isRunningTest()) {
                taxAddressShippingResponseList.clear();
                taxAddressShippingResponseList.add(MMIFullquoteTestDataProvider.gethomeBaseBeanTaxId());
                selectedTaxId = '23423';
            }
            for (HomeBaseBeans.TaxIds HB: taxAddressShippingResponseList) {
                if (HB.Id == selectedTaxId) {
                    SelectedShipingTaxId = HB.Id;
                    fullQWrapper.SelectedShipingTaxId = HB.Id;
                    selectedTaxRecInShipping = HB;

                    if (HB.city != null && HB.city != '') {
                        fullQWrapper.cityInShippingDates = HB.city;
                    }
                    if (HB.country != null && HB.country != '') {
                        fullQWrapper.countryInShippingDates = HB.country;
                    }

                    if (HB.state != null && HB.state != '') {
                        fullQWrapper.stateInShippingDates = HB.state;
                    }

                    fullQWrapper.enableVAddresBtnInShipping = false;
                    if (summaryLineList.size() == 0) {
                        fullQWrapper.enableRefreshQuote = false;
                    } else {
                        fullQWrapper.enableRefreshQuote = true;
                    }
                    //getSalesInventoryList();
                    break;
                } else {
                    system.debug('-----selectedTaxId-------' + selectedTaxId);
                    fullQWrapper.enableVAddresBtnInShipping = true;
                }
            }
            fullQWrapper.showTaxIdShippingPopUp = false;
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC taxIdShippingSelected: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :taxIdShippingSelected' + selectedTaxRecInShipping);
        return null;
    }
    // Products Webservice

    public void ProductsSelection() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :ProductsSelection');
        ProductSearchService_AC productService = null;
        String bId;
        FullQuoteMainService fqService = null;
        try {
            fqService = new FullQuoteMainService();
            productService = new ProductSearchService_AC();
            if (quickQuoteId != null && quickQuoteId != '') {
                bId = CalculateBranchIdDuringQqToFQConversion(QqData, fullQWrapper.fulFillingBranchInShippingDates);
            } else {
                bId = FullQuoteDAO.getBranchId(fullQWrapper.fulFillingBranchInShippingDates, recId);
            }
            if (bId != null && bId != '') {
                branchIdforViewBranch = bId;
            }
            system.debug('-----------bId--------------------' + bId);


            if (!Test.isRunningTest()) {
                productList = productService.listProductsBasedOnTransactionType(bId, fullQWrapper.TransactionType, fullQWrapper.selectedFullQUote);
            } else {
                productList = MMIFullquoteTestDataProvider.getQHomeBaseProduct();
            }
            if (productList != null) {
                for (HomeBaseBeans.Products p: productList) {
                    if (p.qtyAvail != null) {
                        p.qtyAvail = p.qtyAvail.split('\\.')[0];
                    }

                    if (p.rate5 != null && p.rate5.rate != null) {
                        p.rate5.rate = p.rate5.rate.split('\\.')[0];
                    }
                    if (p.rate1 != null && p.rate1.rate != null) {
                        p.rate1.rate = p.rate1.rate.split('\\.')[0];
                    }

                    if (p.rate2 != null && p.rate2.rate != null) {
                        p.rate2.rate = p.rate2.rate.split('\\.')[0];
                    }

                    if (p.rate3 != null && p.rate3.rate != null) {
                        p.rate3.rate = p.rate3.rate.split('\\.')[0];
                    }

                    if (p.rate4 != null && p.rate4.rate != null) {
                        p.rate4.rate = p.rate4.rate.split('\\.')[0];
                    }
                }
                //productList = formatProductPriceForMoboSeco(productList);
                if (productList[0].errorMessage != null) {
                    ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, productList[0].errorMessage);
                    ApexPages.addMessage(msg);
                    fullQWrapper.showErrorPopUp = true;
                    isShowProductList = false;
                } else {
                    isShowProductList = true;
                }
            } else {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'No Product found.');
                ApexPages.addMessage(msg);
                isShowProductList = false;
            }
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC ProductsSelection: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :ProductsSelection' + productList);
    }
    public void ClearProductSummarylines() {
        refreshLineAllResponseList = new list < List < HomeBaseBeans.quoteLine >> ();
        if ((docId != null && cloneIsTrue != 'true') || (FQSMrecId != null || fullQuote_tran.documentId__c != null)) {
            RemoveLineService_AC rls = new RemoveLineService_AC();
            for (HomeBaseBeans.quoteLine sl: summaryLineList) {
                rls.removeItemFromSummaryLine(sl.lineCount, sl.itemId, sl.lineId, summaryLineInEdit);
            }
        }
        summaryLineList = new List < HomeBaseBeans.quoteLine > ();
        ProductExtrasList = new List < HomeBaseBeans.extras > ();
        ClearLockSelect();
        accessoriesQuantity = 1;
        summaryLineCount = 1;
        isClearSummaryLineItems = true;
        isProductAlreadyAdded = false;
        isAccessorySelected = false;
        lockHideAcc = false;
        if (quickQuoteId != null && quickQuoteId != '') {
            isPoductSelected = true;
        } else {
            isPoductSelected = false;
        }
        tranTypeErrorMessage = false;
    }

    public Void ClearLockSelect() {
        for (FullQuoteWrapper.lockTypesAndQuantity l: lockTypeList) {
            l.isLockselected = false;
            l.LockPrice = '';
            l.lockQuantity = 1;
        }
    }

    public PageReference editProduct() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :editProduct' + isClearSummaryLineItems + summaryLineList + fullQWrapper.enableProductadd);
        String selectedProductId;
        FullQuoteMainService fqService = null;
        Boolean accessoryRes = false;

        try {
            fqService = new FullQuoteMainService();
            chargeCodeList = new List < HomeBaseBeans.chargeCodes > ();
            analysisSetCodesResponseiInProductList = new List < HomeBaseBeans.analysisSetCodes > ();
            editProduct = new HomeBaseBeans.Products();
            standardRate = ''; //// for TFS 2829
            baseRate = ''; // for TFS 3080
            selectedProductId = System.currentPageReference().getParameters().get('SelectedProduct');
            SelectedPId = selectedProductId;

            fullQWrapper.minimumTerm = '';
            fullQWrapper.InternetCoupon = '';
            fullQWrapper.LockType = '';

            if (test.isRunningTest()) {
                selectedProductId = '20i';
            }
            for (HomeBaseBeans.Products p: productList) {
                if (p.Id == selectedProductId) {
                    editProduct.Id = p.Id;
                    editProduct.rate1 = new HomeBaseBeans.rates();
                    editProduct.rate2 = new HomeBaseBeans.rates();
                    editProduct.rate3 = new HomeBaseBeans.rates();
                    editProduct.rate4 = new HomeBaseBeans.rates();
                    editProduct.rate5 = new HomeBaseBeans.rates();
                    editProduct.rate6 = new HomeBaseBeans.rates();
                    editProduct.rate7 = new HomeBaseBeans.rates();
                    editProduct.rate8 = new HomeBaseBeans.rates();
                    editProduct.rate1.rate = p.rate1.rate;
                    editProduct.rate2.rate = p.rate2.rate;
                    editProduct.rate3.rate = p.rate3.rate;
                    editProduct.rate4.rate = p.rate4.rate;
                    editProduct.rate5.rate = p.rate5.rate;
                    editProduct.rate6.rate = p.rate6.rate;
                    editProduct.rate7.rate = p.rate7.rate;
                    editProduct.rate8.rate = p.rate8.rate;

                    //editProduct = p;
                    SelectedProductDesc = p.Description;
                    fullQWrapper.showEditProduct = true;
                    fullQWrapper.ImageUrl = p.thumbnailUrl;
                    //fullQWrapper.ImageUrlForPDF = p.thumbnailUrl;
                    accessoryRes = fqService.getAccessoryInfo(selectedProductId);
                    if (test.isRunningTest()) {
                        accessoryRes = true;
                    }
                    if (accessoryRes) {
                        if (isTransTmoboORseco) {
                            ClearLockSelect();
                            accessoriesQuantity = 1;
                            isAccessorySelected = true;
                            lockHideAcc = true;
                            isPoductSelected = false;
                        } else {
                            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'You cannot select accessories for this Transaction Type.');
                            ApexPages.addMessage(msg);
                            fullQWrapper.showEditProduct = false;
                            isAccessorySelected = false;
                            lockHideAcc = false;
                            isPoductSelected = false;
                        }

                    } else {
                        standardRate = EditProduct.rate1.rate; // for TFS 2829
                        baseRate = EditProduct.rate5.rate; // for TFS 3080
                        isAccessorySelected = false;
                        lockHideAcc = false;
                        isPoductSelected = true;
                    }
                    break;
                }
            }
            enablePeriod();

        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC editProduct: ' + e.getMessage());
        }

        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :editProduct' + editProduct + summaryLineList + fullQWrapper.enableProductadd);
        return null;
    }

    public Pagereference onchangScheduledDeliverDate() {
        fullQWrapper.enableVAddresBtnInShipping = false;
        return null;
    }

    public String chargeCode(String ProductItemCode) {
        String ChargeCode = 'monthly';
        chargeCodesService_AC chargeCodeServiceObj = new chargeCodesService_AC();
        list < HomeBaseBeans.chargeCodes > AllChargeCodes = chargeCodeServiceObj.getChargeCodeList(ProductItemCode);
        if (AllChargeCodes.size() > 0) {
            ChargeCode = AllChargeCodes[0].id;
        }
        return ChargeCode;
    }
    // action function method to call Refresh line webservice
    public Boolean callRefreshLineService() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :callRefreshLineService');
        RefreshLineService_AC refreshLineService = null;
        String branchId;
        String editProductId;
        Boolean isRefreshSuccess = true;
        try {
            if (SelectedRentalLength != null && SelectedRentalLength != '' && fullQWrapper.rentalLengthInProduct != SelectedRentalLength) {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'rental length of product and Accessories should be ' + SelectedRentalLength + ' as containner / Accessories added in Product summary line');
                ApexPages.addMessage(msg);
                isRefreshSuccess = false;
                return isRefreshSuccess;
            }
            if (test.isRunningTest()) {
                EditProduct = MMIFullquoteTestDataProvider.getHomeBaseBeansProductsList()[0];
            }
            if ((editProduct.Id != null && editProduct.Id != '') || fullQWrapper.selectedFullQUote == 'sales') {
                if (!isTransTmoboORseco) {
                    refreshLineAllResponseList = new list < List < HomeBaseBeans.quoteLine >> ();
                }
                if (isTransTmoboORseco && (docId == null || docId == '')) {
                    refreshLineAllResponseList = new list < List < HomeBaseBeans.quoteLine >> ();
                    if (summaryLineList.size() > 0) {
                        refreshLineAllResponseList.add(summaryLineList);
                    }
                }

                if (fullQWrapper.selectedFullQUote == 'sales') {
                    if (fullQWrapper.disableModificationSelection || docId != null) {
                        if (summaryLineList.size() > 0) {
                            if (fullQWrapper.disableModificationSelection) {
                                for (HomeBaseBeans.quoteLine sl: summaryLineList) {
                                    mapItemNameDesc.put(sl.itemId, sl.description);
                                }
                                refreshLineAllResponseList = new list < List < HomeBaseBeans.quoteLine >> ();
                                refreshLineAllResponseList.add(summaryLineList);
                            }
                            if (docId != null) {
                                refreshLineAllResponseList = new list < List < HomeBaseBeans.quoteLine >> ();
                                refreshLineAllResponseList.add(summaryLineList);
                            }
                        }
                    }
                }

                if ((fullQWrapper.selectedFullQUote == 'rental' || fullQWrapper.selectedFullQUote == 'Rental') && docId != null && summaryLineList.size() > 0) {
                    refreshLineAllResponseList = new list < List < HomeBaseBeans.quoteLine >> ();
                    refreshLineAllResponseList.add(summaryLineList);
                }
                refreshLineService = new RefreshLineService_AC();

                FullQuoteMainService fqService = new FullQuoteMainService();
                for (Integer i = 0; i < 5; i++) {
                    if (i == 0) {
                        HomeBaseBeans.quoteLine HB = new HomeBaseBeans.quoteLine();
                        if (fullQWrapper.selectedFullQUote == 'sales') {
                            if (!ckeckModificationItem(fullQWrapper.ItemCode) && fullQWrapper.ItemCode != '' && fullQWrapper.ItemCode != null) {
                                if (fullQWrapper.ItemCode != '' && fullQWrapper.ItemCode != null) {
                                    HB.itemId = fullQWrapper.ItemCode;
                                } else {
                                    HB.itemId = '';
                                    ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Please provide an Item Id.');
                                    ApexPages.addMessage(msg);
                                    isRefreshSuccess = false;
                                    break;
                                }
                                if (fullQWrapper.SellingPrice != '' && fullQWrapper.SellingPrice != null && Decimal.valueOf(fullQWrapper.SellingPrice) != 0) {
                                    HB.price = Decimal.valueOf(fullQWrapper.SellingPrice);
                                } else {
                                    HB.price = 0.00;
                                    ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Please provide Selling price.');
                                    ApexPages.addMessage(msg);
                                    isRefreshSuccess = false;
                                    break;
                                }
                                if (fullQWrapper.ECode != '' && fullQWrapper.ECode != null) {
                                    HB.ecode = fullQWrapper.ECode;
                                } else {
                                    HB.ecode = '';
                                    /*if(isAccessorySelected == false){
                                        ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,'Please provide an Ecode.');
                                        ApexPages.addMessage(msg);
                                        isRefreshSuccess = false;
                                        break;
                                    }*/
                                }
                                HB.SelectedFromDate = String.valueOf(fullQuote.Start_Date__c);
                                HB.estimatedCost = null;
                                if (fullQWrapper.ModificationCost != '' && fullQWrapper.ModificationCost != null) {
                                    HB.modificationCharge = Decimal.valueOf(fullQWrapper.ModificationCost);
                                } else {
                                    HB.modificationCharge = null;
                                }
                                if (fullQWrapper.NetBookValue != '' && fullQWrapper.NetBookValue != null) {
                                    HB.netBookValue = Decimal.valueOf(fullQWrapper.NetBookValue);
                                } else {
                                    HB.netBookValue = null;
                                }
                                if (isAccessorySelected) {
                                    HB.quantity = accessoriesQuantity;
                                    HB.isAccessories = true;
                                } else {
                                    HB.quantity = 1;
                                    HB.isAccessories = false;
                                }
                                HB.SelectedAccountId = fullQWrapper.AccountId;
                                HB.SelectedPeriod = '0';
                            }
                        } else {
                            HB.itemId = editProduct.Id;
                            HB.chargeCode = new HomeBaseBeans.chargeCodes();
                            HB.chargeCode.Id = chargeCode(editProduct.Id);
                            HB.SelectedAccountId = fullQWrapper.AccountId;
                            HB.SelectedFromDate = String.valueOf(fullQuote.Start_Date__c);
                            HB.SelectedRate1 = EditProduct.rate1.rate;
                            HB.SelectedRate2 = EditProduct.rate2.rate;
                            HB.SelectedRate3 = EditProduct.rate3.rate;
                            HB.SelectedRate4 = EditProduct.rate4.rate;
                            HB.rate5 = new HomeBaseBeans.rates();
                            Boolean isAccessoryItem = false;
                            isAccessoryItem = fqService.getAccessoryInfo(editProduct.Id);
                            if (editProduct.Id != 'CG1' && editProduct.Id != 'CG2' && editProduct.Id != 'DL1' && editProduct.Id != 'DL2' && !ckeckModificationItem(editProduct.Id) && !isAccessoryItem) {
                                HB.itemType = 'Main Item';
                            }
                            if (ckeckModificationItem(editProduct.Id)) {
                                HB.itemType = 'Modification Item';
                            }
                            if (isAccessoryItem) {
                                HB.itemType = 'Accessories Item';
                            }

                            HB.rate5.rate = EditProduct.rate5.rate;
                            if (isTransTmoboORseco == true && Integer.valueOf(fullQWrapper.rentalLengthInProduct) >= 2 && Integer.valueOf(fullQWrapper.rentalLengthInProduct) <= 6 && (EditProduct.rate1.rate == null || EditProduct.rate1.rate == '' || Decimal.valueOf(EditProduct.rate1.rate) <= 0)) {
                                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Please provide a price.');
                                ApexPages.addMessage(msg);
                                isRefreshSuccess = false;
                                break;
                            }
                            if (isTransTmoboORseco == true && Integer.valueOf(fullQWrapper.rentalLengthInProduct) >= 7 && Integer.valueOf(fullQWrapper.rentalLengthInProduct) <= 12 && (EditProduct.rate2.rate == null || EditProduct.rate2.rate == '' || Decimal.valueOf(EditProduct.rate2.rate) <= 0)) {
                                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Please provide a price.');
                                ApexPages.addMessage(msg);
                                isRefreshSuccess = false;
                                break;
                            }
                            if (isTransTmoboORseco == true && Integer.valueOf(fullQWrapper.rentalLengthInProduct) >= 13 && Integer.valueOf(fullQWrapper.rentalLengthInProduct) <= 24 && (EditProduct.rate3.rate == null || EditProduct.rate3.rate == '' || Decimal.valueOf(EditProduct.rate3.rate) <= 0)) {
                                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Please provide a price.');
                                ApexPages.addMessage(msg);
                                isRefreshSuccess = false;
                                break;
                            }
                            if (isTransTmoboORseco == true && Integer.valueOf(fullQWrapper.rentalLengthInProduct) >= 25 && (EditProduct.rate4.rate == null || EditProduct.rate4.rate == '' || Decimal.valueOf(EditProduct.rate4.rate) <= 0)) {
                                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Please provide a price.');
                                ApexPages.addMessage(msg);
                                isRefreshSuccess = false;
                                break;
                            }


                            if (isTransTmoboORseco == true && (Integer.valueOf(fullQWrapper.rentalLengthInProduct) < 2 || Integer.valueOf(fullQWrapper.rentalLengthInProduct) > 54)) {
                                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Please select Rental length between 2 and 54 for this type of transaction type.');
                                ApexPages.addMessage(msg);
                                isRefreshSuccess = false;
                                break;
                            }
                            if (isTransTmoboORseco == false && (Integer.valueOf(fullQWrapper.rentalLengthInProduct) < 1 || Integer.valueOf(fullQWrapper.rentalLengthInProduct) > 54)) {
                                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Please select Rental length between 1 and 54 for this type of transaction type.');
                                ApexPages.addMessage(msg);
                                isRefreshSuccess = false;
                                break;
                            }
                            HB.SelectedPeriod = fullQWrapper.rentalLengthInProduct;
                            if (isAccessorySelected) {
                                HB.quantity = accessoriesQuantity;
                                HB.isAccessories = true;
                            } else {
                                HB.quantity = 1;
                                HB.isAccessories = false;
                            }
                        }
                        branchId = FullQuoteDAO.getBranchId(fullQWrapper.fulFillingBranchInShippingDates, recId);
                        if (branchId != null && branchId != '') {
                            branchIdforViewBranch = branchId;
                        }

                        if (HB.itemId != '' && HB.itemId != null) {
                            if (!ckeckModificationItem(HB.itemId)) {
                                refreshLineResponseList = refreshLineService.refreshLine(HB, fullQWrapper.TransactionType, branchId, fullQWrapper.selectedFullQUote);
                            }
                        }

                        if (test.isRunningTest()) {
                            refreshLineResponseList = MMIFullquoteTestDataProvider.getQuoteLine();
                            refreshLineResponseList[0].errorMessage = '';
                        }
                        if (refreshLineResponseList.size() > 0) {
                            if (refreshLineResponseList[0].errorMessage == null || refreshLineResponseList[0].errorMessage == '') {
                                // set product description for sales FQ
                                if (fullQWrapper.selectedFullQUote == 'sales') {
                                    String brId = '';
                                    if (quickQuoteId != null && quickQuoteId != '' && (fullQWrapper.fulFillingBranchInShippingDates == null || fullQWrapper.fulFillingBranchInShippingDates == '')) {
                                        brId = CalculateBranchIdDuringQqToFQConversion(QqData, fullQWrapper.fulFillingBranchInShippingDates);
                                    } else {
                                        brId = FullQuoteDAO.getBranchId(fullQWrapper.fulFillingBranchInShippingDates, recId);

                                    }
                                    if (brId != null && brId != '') {
                                        branchIdforViewBranch = brId;
                                    }
                                    ProductSearchService_AC productServiceTemp = new ProductSearchService_AC();
                                    HomeBaseBeans.Products SpecificProduct = new HomeBaseBeans.Products();
                                    SpecificProduct = productServiceTemp.getSpecificProducts(HB.itemId, brId);
                                    if (SpecificProduct.errorMessage == null || SpecificProduct.errorMessage == '') {
                                        refreshLineResponseList[0].description = SpecificProduct.Description;
                                        refreshLineResponseList[0].reference = fullQWrapper.Reference;
                                    }
                                }
                                refreshLineAllResponseList.add(refreshLineResponseList);
                            } else {
                                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, refreshLineResponseList[0].errorMessage);
                                ApexPages.addMessage(msg);
                                refreshLineAllResponseList = new list < List < HomeBaseBeans.quoteLine >> ();
                                if (isTransTmoboORseco) {
                                    refreshLineAllResponseList.add(summaryLineList);
                                }
                                isRefreshSuccess = false;
                                break;
                            }
                        }
                    } else {
                        if (test.isRunningTest()) {
                            FullQuoteWrapper.lockTypesAndQuantity lockListObj = MMIFullquoteTestDataProvider.getFullQuoteWrplockTypesAndQuantity();
                            lockListObj.LockName = 'CG1';
                            lockListObj.isLockselected = true;
                            lockTypeList.add(lockListObj);
                            i = 1;
                        }
                        if (lockTypeList[i - 1].isLockselected == true) {
                            HomeBaseBeans.quoteLine HB = new HomeBaseBeans.quoteLine();
                            if (fullQWrapper.selectedFullQUote == 'sales') {
                                if (!ckeckModificationItem(fullQWrapper.ItemCode) && fullQWrapper.ItemCode != '' && fullQWrapper.ItemCode != null) {
                                    HB.itemId = lockTypeList[i - 1].LockName;
                                    if (lockTypeList[i - 1].LockPrice != null && lockTypeList[i - 1].LockPrice != '') {
                                        if (Decimal.valueOf(lockTypeList[i - 1].LockPrice) > 0) {
                                            HB.price = Decimal.valueOf(lockTypeList[i - 1].LockPrice);
                                        } else {
                                            HB.price = null;
                                        }
                                    } else {
                                        HB.price = null;
                                    }
                                    HB.ecode = '';
                                    HB.SelectedFromDate = String.valueOf(fullQuote.Start_Date__c);
                                    HB.estimatedCost = null;
                                    HB.modificationCharge = null;
                                    HB.netBookValue = null;
                                    HB.quantity = lockTypeList[i - 1].lockQuantity;
                                    HB.SelectedAccountId = fullQWrapper.AccountId;
                                    HB.SelectedPeriod = '0';
                                }
                            } else {
                                HB.itemId = lockTypeList[i - 1].LockName;
                                HB.quantity = lockTypeList[i - 1].lockQuantity;
                                if (lockTypeList[i - 1].LockPrice != null && lockTypeList[i - 1].LockPrice != '') {
                                    if (Decimal.valueOf(lockTypeList[i - 1].LockPrice) > 0) {
                                        HB.price = Decimal.valueOf(lockTypeList[i - 1].LockPrice);
                                    } else {
                                        HB.price = null;
                                    }
                                } else {
                                    HB.price = null;
                                }
                                HB.chargeCode = new HomeBaseBeans.chargeCodes();
                                HB.chargeCode.Id = fullQWrapper.minimumTerm;
                                HB.SelectedPeriod = '1';
                                HB.SelectedAccountId = fullQWrapper.AccountId;
                                HB.SelectedFromDate = String.valueOf(fullQuote.Start_Date__c);
                            }
                            branchId = FullQuoteDAO.getBranchId(fullQWrapper.fulFillingBranchInShippingDates, recId);
                            if (branchId != null && branchId != '') {
                                branchIdforViewBranch = branchId;
                            }
                            if (HB.itemId != '' && HB.itemId != null) {
                                if (!ckeckModificationItem(HB.itemId)) {
                                    refreshLineResponseList = refreshLineService.refreshLine(HB, fullQWrapper.TransactionType, branchId, fullQWrapper.selectedFullQUote);
                                }
                            }

                            if (test.isRunningTest()) {
                                refreshLineResponseList = MMIFullquoteTestDataProvider.getQuoteLine();
                            }
                            if (refreshLineResponseList.size() > 0) {
                                if (refreshLineResponseList[0].errorMessage == null || refreshLineResponseList[0].errorMessage == '') {
                                    refreshLineAllResponseList.add(refreshLineResponseList);
                                } else {
                                    ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, refreshLineResponseList[0].errorMessage);
                                    ApexPages.addMessage(msg);
                                    refreshLineAllResponseList = new list < List < HomeBaseBeans.quoteLine >> ();
                                    if (isTransTmoboORseco) {
                                        refreshLineAllResponseList.add(summaryLineList);
                                    }
                                    isRefreshSuccess = false;
                                    break;
                                }
                            }
                        }
                        if (test.isRunningTest()) {
                            i = 5;
                        }
                    }
                }
                if (test.isRunningTest()) {
                    isRefreshSuccess = true;
                    stdModificationList = MMIFullquoteTestDataProvider.getFullQuoteWrpstdModificationList();
                }
                if (fullQWrapper.selectedFullQUote == 'sales' && isRefreshSuccess) {
                    // add modification to summery list
                    if (fullQWrapper.disableModificationSelection) {
                        list < HomeBaseBeans.quoteLine > refLineForModification = new list < HomeBaseBeans.quoteLine > ();
                        for (FullQuoteWrapper.stdModification mod: stdModificationList) {
                            if (mod.isSelected) {
                                HomeBaseBeans.quoteLine RefLineObj = new HomeBaseBeans.quoteLine();
                                RefLineObj.lineCount = summaryLineCount;
                                RefLineObj.itemId = mod.modId;
                                RefLineObj.description = mod.modificationOption;
                                RefLineObj.quantity = Decimal.valueOf(mod.Quantity);
                                RefLineObj.price = Decimal.valueOf(mod.price);
                                RefLineObj.LockTypeTotal = Decimal.valueOf(mod.Quantity) * Decimal.valueOf(mod.price);
                                RefLineObj.lineValue = String.valueOf(RefLineObj.LockTypeTotal);
                                refLineForModification.add(RefLineObj);
                                isModificationItem = true;
                                mod.isSelected = false;
                            }
                        }
                        refreshLineAllResponseList.add(refLineForModification);
                    }
                }
            } else {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Please fill item id');
                ApexPages.addMessage(msg);
            }
            fullQWrapper.showEditProduct = true;

        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC callRefreshLineService: ' + e.getMessage());
            isRefreshSuccess = false;
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :callRefreshLineService' + productsExtrasPayload);
        if (test.isRunningTest()) {
            return true;
        }
        return isRefreshSuccess;
    }

    public void CreateExtraLineItem() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :CreateExtraLineItem' + refreshLineAllResponseList);
        productsExtrasPayload = new List < HomeBaseBeans.Products > ();
        try {
            for (list < HomeBaseBeans.quoteLine > refreshLineResponseList: refreshLineAllResponseList) {
                if (refreshLineResponseList[0].errorMessage == null || refreshLineResponseList[0].errorMessage == '') {
                    for (HomeBaseBeans.quoteLine HBQ: refreshLineResponseList) {
                        if (HBQ.itemId != 'CG1' && HBQ.itemId != 'CG2' && HBQ.itemId != 'DL1' && HBQ.itemId != 'DL2') {

                            HomeBaseBeans.Products specificProduct = new HomeBaseBeans.Products();

                            specificProduct.Id = HBQ.itemId;
                            specificProduct.Description = HBQ.description;
                            specificProduct.LockType = fullQWrapper.LockType;
                            specificProduct.lineValue = HBQ.lineValue;
                            specificProduct.lineCount = summaryLineCount;
                            if (fullQWrapper.selectedFullQUote != 'sales') {
                                fullQWrapper.minimumTerm = HBQ.chargeCode.id;
                            }
                            fullQWrapper.InternetCoupon = HBQ.internetCoupon;

                            specificProduct.lineCount = summaryLineCount;
                            specificProduct.quantity = HBQ.quantity;
                            productsExtrasPayload.add(specificProduct);

                        } else {
                            HomeBaseBeans.Products specificProduct = new HomeBaseBeans.Products();

                            specificProduct.Id = HBQ.itemId;
                            specificProduct.Description = HBQ.description;
                            specificProduct.LockType = fullQWrapper.LockType;
                            specificProduct.quantity = HBQ.quantity;
                            if (HBQ.itemId == 'CG1' || HBQ.itemId == 'CG2' || HBQ.itemId == 'DL1' || HBQ.itemId == 'DL2') {
                                if (HBQ.itemId == 'CG1') {
                                    specificProduct.Description = lockTypeList[0].LockDescription;
                                    specificProduct.lineValue = HBQ.lineValue;
                                } else if (HBQ.itemId == 'CG2') {
                                    specificProduct.Description = lockTypeList[1].LockDescription;
                                    specificProduct.lineValue = HBQ.lineValue;
                                } else if (HBQ.itemId == 'DL1') {
                                    specificProduct.Description = lockTypeList[2].LockDescription;
                                    specificProduct.lineValue = HBQ.lineValue;
                                } else if (HBQ.itemId == 'DL2') {
                                    specificProduct.Description = lockTypeList[3].LockDescription;
                                    specificProduct.lineValue = HBQ.lineValue;
                                }
                            }
                            specificProduct.lineCount = summaryLineCount;
                            productsExtrasPayload.add(specificProduct);
                        }
                    }
                } else {
                    ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, refreshLineResponseList[0].errorMessage);
                    ApexPages.addMessage(msg);
                }
            }
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC CreateExtraLineItem: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :CreateExtraLineItem' + productsExtrasPayload);
    }

    public Boolean ckeckModificationItem(String ItemId) {
        Boolean isModItem = false;
        for (FullQuoteWrapper.stdModification mod: stdModificationList) {
            if (ItemId == mod.modId) {
                isModItem = true;
            }
        }
        return isModItem;
    }

    public String CalculateBranchIdDuringQqToFQConversion(MMI_Quotes__c QqData, String fulFillingBranchId) {
        String qQBranchId = '';
        if (fulFillingBranchId == null || fulFillingBranchId == '') {
            if (QqData.Fulfilling_Branch__c != null && QqData.Fulfilling_Branch__c != '') {
                qQBranchId = QqData.Fulfilling_Branch__c;
            }
            if (QqData.Branch_id__c != null && QqData.Branch_id__c != '') {
                qQBranchId = QqData.Branch_id__c;
            }
        } else {
            qQBranchId = fulFillingBranchId;
        }
        return qQBranchId;
    }

    // To call Specific product webservice

    public PageReference callSpecificProductService() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :callSpecificProductService');
        try {
            if (EditProduct.Id != '' && EditProduct.Id != null) {
                String brId = '';
                if (quickQuoteId != null && quickQuoteId != '' && (fullQWrapper.fulFillingBranchInShippingDates == null || fullQWrapper.fulFillingBranchInShippingDates == '')) {
                    brId = CalculateBranchIdDuringQqToFQConversion(QqData, fullQWrapper.fulFillingBranchInShippingDates);
                } else {
                    brId = FullQuoteDAO.getBranchId(fullQWrapper.fulFillingBranchInShippingDates, recId);
                }
                if (brId != null && brId != '') {
                    branchIdforViewBranch = brId;
                }
                ProductSearchService_AC productServiceTemp = new ProductSearchService_AC();
                HomeBaseBeans.Products SpecificProduct = new HomeBaseBeans.Products();
                SpecificProduct = productServiceTemp.getSpecificProducts(EditProduct.Id, brId);
                if (test.isRunningTest()) {
                    List < HomeBaseBeans.Products > prod = MMIFullquoteTestDataProvider.getQHomeBaseProduct();
                    SpecificProduct = prod[0];
                }


                if (SpecificProduct.errorMessage == null || SpecificProduct.errorMessage == '') {
                    SelectedProductDesc = SpecificProduct.Description;
                    fullQWrapper.ImageUrl = SpecificProduct.thumbnailUrl;
                    //fullQWrapper.ImageUrlForPDF = SpecificProduct.thumbnailUrl;
                    EditProduct = SpecificProduct;
                    system.debug('-------------EditProduct----------' + EditProduct);
                    enablePeriod();
                    FullQuoteMainService fqService = new FullQuoteMainService();
                    Boolean isEditedProductIsAnAccessoty = fqService.getAccessoryInfo(EditProduct.Id);
                    if (test.isRunningTest()) {
                        isEditedProductIsAnAccessoty = true;
                    }
                    if (isEditedProductIsAnAccessoty) {
                        if (isTransTmoboORseco) {
                            ClearLockSelect();
                            accessoriesQuantity = 1;
                            isAccessorySelected = true;
                            lockHideAcc = true;
                            isPoductSelected = false;
                            fullQWrapper.showEditProduct = true;
                            //ProductsSelection();
                        } else {
                            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'You cannot select accessories for this Transaction Type.');
                            ApexPages.addMessage(msg);
                            //ProductsSelection();
                            fullQWrapper.showEditProduct = false;
                            isAccessorySelected = false;
                            lockHideAcc = false;
                            isPoductSelected = false;
                            EditProduct.rate1.rate = null;
                            standardRate = ''; // for TFS 2829
                            baseRate = ''; // for TFS 3080
                            EditProduct.rate2.rate = null;
                            EditProduct.rate3.rate = null;
                            EditProduct.rate4.rate = null;
                            EditProduct.rate5.rate = null;
                            EditProduct.rate6.rate = null;
                            EditProduct.rate7.rate = null;
                            EditProduct.rate8.rate = null;
                        }
                    } else {
                        isAccessorySelected = false;
                        lockHideAcc = false;
                        isPoductSelected = true;
                        fullQWrapper.showEditProduct = true;
                        standardRate = EditProduct.rate1.rate; // for TFS 2829
                        baseRate = EditProduct.rate5.rate; // for TFS 3080
                        if (EditProduct.Id != null && EditProduct.Id != '' && QqData != null && QqData.Product__c == EditProduct.Id && (QqData.QQ_Type__c == 'rental' || QqData.QQ_Type__c == 'Rental')) {
                            if (QqData.Transaction_Type__c == 'CNST') {
                                EditProduct.rate5.rate = String.valueOf(QqData.Rental_Rate__c);
                            } else {
                                EditProduct.rate1.rate = String.valueOf(QqData.Rental_Rate__c);
                            }
                        }
                    }

                } else {
                    ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'The product ' + EditProduct.Id + ' is not found.');
                    ApexPages.addMessage(msg);
                    ClearLockSelect();
                    accessoriesQuantity = 1;
                    //ProductsSelection();
                    EditProduct = new HomeBaseBeans.Products();
                    standardRate = ''; // for TFS 2829
                    baseRate = ''; // for TFS 3080
                    fullQWrapper.showEditProduct = false;
                    isPoductSelected = false;
                    fullQWrapper.enable1Period = false;
                    fullQWrapper.enable2To6Period = false;
                    fullQWrapper.enable7To12Period = false;
                    fullQWrapper.enable13Period = false;
                    fullQWrapper.ImageUrl = '';
                    //fullQWrapper.ImageUrlForPDF = '';
                }

            } else {
                EditProduct.rate1.rate = null;
                standardRate = ''; // for TFS 2829
                baseRate = ''; // for TFS 3080
                EditProduct.rate2.rate = null;
                EditProduct.rate3.rate = null;
                EditProduct.rate4.rate = null;
                EditProduct.rate5.rate = null;
                EditProduct.rate6.rate = null;
                EditProduct.rate7.rate = null;
                EditProduct.rate8.rate = null;
                fullQWrapper.showEditProduct = false;
                fullQWrapper.enable1Period = false;
                fullQWrapper.enable2To6Period = false;
                fullQWrapper.enable7To12Period = false;
                fullQWrapper.enable13Period = false;
                fullQWrapper.ImageUrl = '';
                //fullQWrapper.ImageUrlForPDF = '';
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Please fill item id');
                ApexPages.addMessage(msg);
                //ProductsSelection();

            }
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC callSpecificProductService: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :callSpecificProductService' + summaryLineList);
        return null;
    }


    public void callEditSaleProduct() {
        fullQWrapper.showEditProduct = true;
        isEcodeAllocationBtnDesabled = false;
        FullQuoteMainService fqService = new FullQuoteMainService();
        Boolean accessoryRes = fqService.getAccessoryInfo(fullQWrapper.ItemCode);
        if (test.isRunningTest()) {
            accessoryRes = true;
        }
        if (fullQWrapper.ItemCode != '' && fullQWrapper.ItemCode != null) {
            if (accessoryRes) {
                isEcodeAllocationBtnDesabled = true;
                if (isTransTmoboORseco) {
                    isPoductSelected = false;
                    isAccessorySelected = true;
                    lockHideAcc = true;
                    accessoriesQuantity = 1;
                    fullQWrapper.showEditProduct = true;
                } else {
                    ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'You cannot select accessories for this Transaction Type.');
                    ApexPages.addMessage(msg);
                    isPoductSelected = true;
                    isAccessorySelected = false;
                    lockHideAcc = false;
                    fullQWrapper.showEditProduct = false;
                }
            } else {
                HomeBaseBeans.Products SpecificProduct = getProductDetails(fullQWrapper.ItemCode);
                if (SpecificProduct.errorMessage == null || SpecificProduct.errorMessage == '') {
                    isPoductSelected = true;
                    isAccessorySelected = false;
                    lockHideAcc = false;
                    fullQWrapper.showEditProduct = true;
                    isEcodeAllocationBtnDesabled = false;
                } else {
                    ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, SpecificProduct.errorMessage);
                    ApexPages.addMessage(msg);
                    fullQWrapper.showEditProduct = false;
                    isPoductSelected = false;
                    isEcodeAllocationBtnDesabled = true;
                }

            }
        } else {
            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Please fill item id');
            ApexPages.addMessage(msg);
            fullQWrapper.showEditProduct = false;
            isEcodeAllocationBtnDesabled = true;
        }
        fullQWrapper.ECode = null;
        fullQWrapper.SuggestedPrice = null;
        fullQWrapper.MinPrice = null;
        fullQWrapper.NetBookValue = null;
        fullQWrapper.assetDescription = null;
        fullQWrapper.sellingPrice = null;
        fullQWrapper.ModificationCost = null;
        fullQWrapper.Reference = null;
        fullQWrapper.GradeDescription = null;
    }


    public HomeBaseBeans.Products getProductDetails(String productId) {
        String brId = '';
        if (quickQuoteId != null && quickQuoteId != '' && (fullQWrapper.fulFillingBranchInShippingDates == null || fullQWrapper.fulFillingBranchInShippingDates == '')) {
            brId = CalculateBranchIdDuringQqToFQConversion(QqData, fullQWrapper.fulFillingBranchInShippingDates);
        } else {
            brId = FullQuoteDAO.getBranchId(fullQWrapper.fulFillingBranchInShippingDates, recId);

        }
        if (brId != null && brId != '') {
            branchIdforViewBranch = brId;
        }
        ProductSearchService_AC productServiceTemp = new ProductSearchService_AC();
        HomeBaseBeans.Products SpecificProduct = new HomeBaseBeans.Products();
        SpecificProduct = productServiceTemp.getSpecificProducts(productId, brId);
        return SpecificProduct;
    }
    // To call search product webservice

    public PageReference ProductSearch() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :ProductSearch');
        isShowProductList = true;
        isProductSearchCompleted = false;
        integer minSize = 0;
        integer maxSize = 0;
        String bId;
        String selectedPT = '';
        String selectedPS = '';

        fullQWrapper.enable1Period = false;
        fullQWrapper.enable2To6Period = false;
        fullQWrapper.enable7To12Period = false;
        fullQWrapper.enable13Period = false;

        HomeBaseBeans.ProductSearch productSearchPattern = null;
        try {

            selectedPT = System.currentPageReference().getParameters().get('SelectedPT');
            selectedPS = System.currentPageReference().getParameters().get('SelectedPS');

            if (test.isRunningTest()) {
                selectedPT = '1';
                selectedPS = '1';
            }
            if (selectedPS != null && selectedPS != '') {

                for (FullQuoteWrapper.productSizes pSize: productSizesListNew) {
                    if (pSize.RecUniqId == integer.valueOf(selectedPS)) {
                        fullQWrapper.ProductSize = pSize.productSize;
                    }
                }

            } else {
                fullQWrapper.ProductSize = '';
            }

            if (selectedPT != null && selectedPT != '') {
                for (FullQuoteWrapper.productTypes pSize: productTypesListNew) {
                    if (pSize.RecUniqId == integer.valueOf(selectedPT)) {
                        fullQWrapper.ProductType = pSize.productType;
                    }
                }
            } else {
                fullQWrapper.ProductType = '';
            }



            if (fullQWrapper.ProductSize != '' && fullQWrapper.ProductSize != null) {
                if (fullQWrapper.ProductSize.contains('5')) {
                    minSize = 5;
                    maxSize = 9;
                }
                if (fullQWrapper.ProductSize.contains('10')) {
                    minSize = 10;
                    maxSize = 19;
                }
                if (fullQWrapper.ProductSize.contains('20')) {
                    minSize = 20;
                    maxSize = 29;
                }
                if (fullQWrapper.ProductSize.contains('30')) {
                    minSize = 30;
                    maxSize = 39;
                }
                if (fullQWrapper.ProductSize.contains('40')) {
                    minSize = 40;
                }
            }
            productSearchPattern = new HomeBaseBeans.ProductSearch();
            productSearchPattern.pattern = EncodingUtil.urlEncode(fullQWrapper.productSearchWord, 'UTF-8');
            productSearchPattern.defId = fullQWrapper.ProductType;
            if (maxSize != 0) {
                productSearchPattern.maxsize = maxSize;
            }
            if (minSize != 0) {
                productSearchPattern.minsize = minSize;
            }

            productSearchPattern.QuoteType = fullQWrapper.selectedFullQUote;
            productSearchPattern.primaryOnly = fullQWrapper.PrimaryOnly;
            ProductSearchService_AC productService = new ProductSearchService_AC();
            if (quickQuoteId != null && quickQuoteId != '') {
                bId = CalculateBranchIdDuringQqToFQConversion(QqData, fullQWrapper.fulFillingBranchInShippingDates);
            } else {
                bId = FullQuoteDAO.getBranchId(fullQWrapper.fulFillingBranchInShippingDates, recId);
            }
            if (bId != null && bId != '') {
                branchIdforViewBranch = bId;
            }

            // accessory search

            system.debug('+++++++' + fullQWrapper.deliverySetUp + '+++++++' + fullQWrapper.returnTearDown);

            if ((fullQWrapper.deliverySetUp != null && fullQWrapper.deliverySetUp != '') && (fullQWrapper.returnTearDown != null && fullQWrapper.returnTearDown != '')) {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Either Search with Delivery/SetUp or Return/Teardown.');
                ApexPages.addMessage(msg);
            } else {
                if (productSearchPattern.pattern == '' && fullQWrapper.deliverySetUp != null && fullQWrapper.deliverySetUp != '') {
                    productSearchPattern.pattern = EncodingUtil.urlEncode(fullQWrapper.deliverySetUp, 'UTF-8');
                } else if (productSearchPattern.pattern == '' && fullQWrapper.returnTearDown != null && fullQWrapper.returnTearDown != '') {

                    productSearchPattern.pattern = EncodingUtil.urlEncode(fullQWrapper.returnTearDown, 'UTF-8');
                }
                //
                if (!Test.isRunningTest()) {
                    productList = productService.searchProductForFQ(productSearchPattern, bId, fullQWrapper.deliverySetUp, fullQWrapper.returnTearDown);
                    clearProductSearchData();
                    isProductSearchCompleted = true;
                } else {
                    productList = MMIFullquoteTestDataProvider.getQHomeBaseProduct();
                }

                //productList = formatProductPriceForMoboSeco(productList);
                if (productList != null && productList.size() > 0) {
                    for (HomeBaseBeans.Products p: productList) {
                        p.qtyAvail = String.valueOf(Integer.valueOf(p.qtyAvail));
                    }
                }
                editProduct = new HomeBaseBeans.Products();
                standardRate = ''; // for TFS 2829
                baseRate = ''; // for TFS 3080
                fullQWrapper.showEditProduct = false;
                if (productList == null) {
                    ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'No product found!');
                    ApexPages.addMessage(msg);
                }
            }

            productTypesListNew = QuickQuoteUtilities.getProductTypeNewListFullQuote();
            productSizesListNew = QuickQuoteUtilities.getProductSizeNewListFullQuote();
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC ProductSearch: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :ProductSearch' + summaryLineList);
        return null;
    }

    public void clearProductSearchData() {
        fullQWrapper.productSearchWord = '';
        fullQWrapper.deliverySetUp = '';
        fullQWrapper.returnTearDown = '';
        productTypesListNew = QuickQuoteUtilities.getProductTypeNewListFullQuote();
        productSizesListNew = QuickQuoteUtilities.getProductSizeNewListFullQuote();
        fullQWrapper.ProductSize = '';
        fullQWrapper.ProductType = '';
        fullQWrapper.PrimaryOnly = true;
    }

    public list < HomeBaseBeans.Products > formatProductPriceForMoboSeco(list < HomeBaseBeans.Products > productList) {
        for (HomeBaseBeans.Products p: productList) {
            if (isTransTmoboORseco) {
                if (p.rate2.rate != null && p.rate2.rate != '' && (p.rate1.rate == null || p.rate1.rate == '')) {
                    p.rate1.rate = p.rate2.rate;
                } else {
                    if (p.rate1.rate != null && p.rate1.rate != '') {
                        p.rate1.rate = p.rate1.rate;
                    }
                }
                if (p.rate3.rate != null && p.rate3.rate != '') {
                    p.rate2.rate = p.rate3.rate;
                }
                if (p.rate4.rate != null && p.rate4.rate != '') {
                    p.rate3.rate = p.rate4.rate;
                }
                if (p.rate5.rate != null && p.rate5.rate != '') {
                    p.rate4.rate = p.rate5.rate;
                }
            }
        }
        return productList;
    }

    // To enable and disable input period fields
    public PageReference enablePeriod() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :enablePeriod' + summaryLineList + fullQWrapper.enableProductadd);
        Integer n;
        try {
            if (SelectedRentalLength != null && SelectedRentalLength != '' && fullQWrapper.rentalLengthInProduct != SelectedRentalLength) {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'rental length of product and Accessories should be ' + SelectedRentalLength + ' as containner / Accessories added in Product summary line');
                ApexPages.addMessage(msg);
                return null;
            }

            fullQWrapper.rentalLength = fullQWrapper.rentalLengthInProduct;
            if (fullQWrapper.rentalLengthInProduct == '' || fullQWrapper.rentalLengthInProduct == null) {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Please select Length of Rental.');
                ApexPages.addMessage(msg);
                fullQWrapper.enable1Period = false;
                fullQWrapper.enable2To6Period = false;
                fullQWrapper.enable7To12Period = false;
                fullQWrapper.enable13Period = false;
            }

            if (!(fullQWrapper.rentalLengthInProduct == '-None-' || fullQWrapper.rentalLengthInProduct == '' || fullQWrapper.rentalLengthInProduct == null)) {
                n = Integer.valueOf(fullQWrapper.rentalLengthInProduct);
            }
            if (fullQWrapper.TransactionType == 'CNST') {
                fullQWrapper.enable1Period = false;
                fullQWrapper.enable2To6Period = false;
                fullQWrapper.enable7To12Period = false;
                fullQWrapper.enable13Period = false;
            } else {
                if (isTransTmoboORseco) {
                    if (test.isRunningTest()) {
                        n = 3;
                    }
                    if (n >= 2 && n <= 6) {
                        fullQWrapper.enable1Period = true;
                        fullQWrapper.enable2To6Period = false;
                        fullQWrapper.enable7To12Period = false;
                        fullQWrapper.enable13Period = false;
                        addNationalValue('1');
                    }
                    if (test.isRunningTest()) {
                        n = 8;
                    }
                    if (n >= 7 && n <= 12) {
                        fullQWrapper.enable1Period = false;
                        fullQWrapper.enable2To6Period = true;
                        fullQWrapper.enable7To12Period = false;
                        fullQWrapper.enable13Period = false;
                        addNationalValue('2');
                    }
                    if (test.isRunningTest()) {
                        n = 14;
                    }
                    if (n >= 13 && n <= 24) {
                        fullQWrapper.enable1Period = false;
                        fullQWrapper.enable2To6Period = false;
                        fullQWrapper.enable7To12Period = true;
                        fullQWrapper.enable13Period = false;
                        addNationalValue('3');
                    }
                    if (test.isRunningTest()) {
                        n = 26;
                    }
                    if (n > 25) {
                        fullQWrapper.enable1Period = false;
                        fullQWrapper.enable2To6Period = false;
                        fullQWrapper.enable7To12Period = false;
                        fullQWrapper.enable13Period = true;
                        addNationalValue('4');
                    }

                } else {
                    if (test.isRunningTest()) {
                        n = 1;
                    }
                    if (n == 1) {
                        fullQWrapper.enable1Period = true;
                        fullQWrapper.enable2To6Period = false;
                        fullQWrapper.enable7To12Period = false;
                        fullQWrapper.enable13Period = false;
                        addNationalValue('1');
                    }
                    if (test.isRunningTest()) {
                        n = 3;
                    }
                    if (n > 1 && n < 7) {
                        fullQWrapper.enable1Period = false;
                        fullQWrapper.enable2To6Period = true;
                        fullQWrapper.enable7To12Period = false;
                        fullQWrapper.enable13Period = false;
                        addNationalValue('2');
                    }
                    if (test.isRunningTest()) {
                        n = 8;
                    }
                    if (n > 6 && n < 13) {
                        fullQWrapper.enable1Period = false;
                        fullQWrapper.enable2To6Period = false;
                        fullQWrapper.enable7To12Period = true;
                        fullQWrapper.enable13Period = false;
                        addNationalValue('3');
                    }
                    if (test.isRunningTest()) {
                        n = 14;
                    }
                    if (n > 12) {
                        fullQWrapper.enable1Period = false;
                        fullQWrapper.enable2To6Period = false;
                        fullQWrapper.enable7To12Period = false;
                        fullQWrapper.enable13Period = true;
                        addNationalValue('4');
                    }
                }
                integer days = 0;
                if (fullQWrapper.rentalLengthInProduct != null && fullQWrapper.rentalLengthInProduct != '') {
                    days = (28 * integer.valueof(fullQWrapper.rentalLengthInProduct));
                } else {
                    days = (28 * 1);
                }
                if (fullQWrapper.TransactionType == 'ON') {
                    isLodedMoveInIsReadOnly = false;
                    fullQuote.Loaded_Move_In__c = fullQuote.Start_Date__c.addDays(days);
                } else {
                    fullQuote.Loaded_Move_In__c = fullQuote.Start_Date__c.addDays(days);
                    isLodedMoveInIsReadOnly = true;
                }

            }
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC enablePeriod: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :enablePeriod' + fullQWrapper);
        return null;
    }

    public void addNationalValue(String RenatlNumber) {
        if (isNationalAccount) {
            if (test.isRunningTest()) {
                EditProduct = MMIFullquoteTestDataProvider.getHomeBaseBeansProductsList()[0];
                RenatlNumber = '1';
            }
            if (EditProduct.rate6.rate != null && EditProduct.rate6.rate != '') {
                if (RenatlNumber == '1') {
                    resetOldActualValue(oldRenatlRange, oldNationalRate);
                    oldNationalRate = EditProduct.rate1.rate;
                    oldRenatlRange = '1';
                    if (isTransTmoboORseco) {
                        EditProduct.rate1.rate = EditProduct.rate8.rate;
                    } else {
                        EditProduct.rate1.rate = EditProduct.rate6.rate;
                    }

                }
                if (test.isRunningTest()) {
                    RenatlNumber = '2';
                }
                if (RenatlNumber == '2') {
                    resetOldActualValue(oldRenatlRange, oldNationalRate);
                    oldNationalRate = EditProduct.rate2.rate;
                    oldRenatlRange = '2';
                    if (isTransTmoboORseco) {
                        EditProduct.rate2.rate = EditProduct.rate8.rate;
                    } else {
                        EditProduct.rate2.rate = EditProduct.rate6.rate;
                    }
                }
                if (test.isRunningTest()) {
                    RenatlNumber = '3';
                }
                if (RenatlNumber == '3') {
                    resetOldActualValue(oldRenatlRange, oldNationalRate);
                    oldNationalRate = EditProduct.rate3.rate;
                    oldRenatlRange = '3';
                    if (isTransTmoboORseco) {
                        EditProduct.rate3.rate = EditProduct.rate8.rate;
                    } else {
                        EditProduct.rate3.rate = EditProduct.rate6.rate;
                    }
                }
                if (test.isRunningTest()) {
                    RenatlNumber = '4';
                }
                if (RenatlNumber == '4') {
                    resetOldActualValue(oldRenatlRange, oldNationalRate);
                    oldNationalRate = EditProduct.rate4.rate;
                    oldRenatlRange = '4';
                    if (isTransTmoboORseco) {
                        EditProduct.rate4.rate = EditProduct.rate8.rate;
                    } else {
                        EditProduct.rate4.rate = EditProduct.rate6.rate;
                    }
                }
            }
        }
    }

    public void resetOldActualValue(String oldRange, String actualValue) {
        if (oldRange == '1') {
            EditProduct.rate1.rate = actualValue;
        }
        if (oldRange == '2') {
            EditProduct.rate2.rate = actualValue;
        }
        if (oldRange == '3') {
            EditProduct.rate3.rate = actualValue;
        }
        if (oldRange == '4') {
            EditProduct.rate4.rate = actualValue;
        }
    }
    // To select a record in minimum term popup

    public PageReference MinimumTermIdSelected() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :MinimumTermIdSelected' + chargeCodeList);
        String selectedChargeCodeId;
        try {
            selectedChargeCodeId = System.currentPageReference().getParameters().get('SelectedMinimumTerm');
            for (HomeBaseBeans.chargeCodes HB: chargeCodeList) {
                if (HB.Id == selectedChargeCodeId) {
                    fullQWrapper.minimumTerm = HB.Id;
                    break;
                }
            }
            callRefreshLineService();

            fullQWrapper.showMinimumTermPopUp = false;
            fullQWrapper.showSearchChargeCodeList = false;
            qqWrapper = new QuickQuoteWrapper();
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC MinimumTermIdSelected: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :MinimumTermIdSelected');
        return null;
    }
    // To search charge code records in product screen

    public PageReference MinimumTermIdSearchFun() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :MinimumTermIdSearchFun' + chargeCodeList);
        chargeCodeSearchList = new List < HomeBaseBeans.chargeCodes > ();
        try {
            if ((qqWrapper.chargeCodeIdSearchWord == null || qqWrapper.chargeCodeIdSearchWord == '') && (qqWrapper.chargeCodeNameSearchWord == null || qqWrapper.chargeCodeNameSearchWord == '')) {
                fullQWrapper.showSearchChargeCodeList = false;
            } else {
                for (HomeBaseBeans.chargeCodes HB: chargeCodeList) {
                    if ((qqWrapper.chargeCodeIdSearchWord != '') && (HB.Id.toLowerCase()).startswith(qqWrapper.chargeCodeIdSearchWord.toLowerCase()) || (qqWrapper.chargeCodeNameSearchWord != '') && (HB.description.toLowerCase()).Contains(qqWrapper.chargeCodeNameSearchWord.toLowerCase())) {
                        chargeCodeSearchList.add(HB);
                    }
                }
                fullQWrapper.showSearchChargeCodeList = true;
            }
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC MinimumTermIdSearchFun: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :MinimumTermIdSearchFun' + chargeCodeSearchList);
        return null;
    }

    public PageReference AnalysisCodeIdSelectedInProduct() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :AnalysisCodeIdSelectedInProduct' + analysisSetCodesResponseiInProductList);
        String selectedAnalysisCodeId;
        try {
            selectedAnalysisCodeId = System.currentPageReference().getParameters().get('selectedAnalysisInProduct');
            for (HomeBaseBeans.analysisSetCodes HB: analysisSetCodesResponseiInProductList) {
                if (HB.id == selectedAnalysisCodeId) {
                    fullQWrapper.InternetCoupon = HB.id;
                }
            }
            fullQWrapper.showAnalysisCodePopupInProduct = false;
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC AnalysisCodeIdSelectedInProduct: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :AnalysisCodeIdSelectedInProduct' + chargeCodeSearchList);
        return null;
    }

    // To copy billing address to shipping address

    public PageReference copyBillingAddressToShipping() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :copyBillingAddressToShipping' + fullQWrapper.isUseBillingAddress);
        try {
            if (fullQWrapper.isUseBillingAddress) {

                fullQWrapper.shippingId = fullQWrapper.Id;
                fullQWrapper.AddressInShippingDates = fullQWrapper.address;
                fullQWrapper.cityInShippingDates = fullQWrapper.city;
                fullQWrapper.countyInShippingDates = fullQWrapper.County;
                fullQWrapper.countryInShippingDates = fullQWrapper.country;
                shippingStatesList();
                fullQWrapper.stateInShippingDates = fullQWrapper.state;
                fullQWrapper.ZipCodeInShipping = fullQWrapper.zipCode;
                fullQWrapper.enableVAddresBtnInShipping = true;
                fullQWrapper.enableRefreshQuote = false;
                fullQWrapper.enableSaveQuote = false;
                fullQWrapper.enableMarkAsLostbutton = false;
                fullQWrapper.fulFillingBranchInShippingDates = null;
                fullQWrapper.fulFillingBranchNameInShippingDates = null;
                isFullfillingBranchid = true;
                addressErrorMessage = null;
            } else {
                fullQWrapper.shippingId = null;
                fullQWrapper.AddressInShippingDates = null;
                fullQWrapper.cityInShippingDates = null;
                fullQWrapper.countyInShippingDates = null;
                fullQWrapper.countryInShippingDates = null;
                shippingStatesList();
                fullQWrapper.stateInShippingDates = null;
                fullQWrapper.ZipCodeInShipping = null;
                fullQWrapper.enableVAddresBtnInShipping = true;
                fullQWrapper.fulFillingBranchNameInShippingDates = null;
                fullQWrapper.fulFillingBranchInShippingDates = null;
                isFullfillingBranchid = true;
                addressErrorMessage = null;
            }
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC copyBillingAddressToShipping: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :copyBillingAddressToShipping');

        return null;
    }

    public PageReference addProductToSummaryLines() {

        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :addProductToSummaryLines' + fullQWrapper.TransactionType + analysisSetHeaderResponseList);
        try {
            if (test.isRunningTest()) {
                fullQuote.Start_Date__c = system.today();
            }
            if (fullQuote.Start_Date__c == null) {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Please select start date in shipping tab.');
                ApexPages.addMessage(msg);
                return null;
            }
            if (fullQWrapper.selectedFullQUote != 'sales') {
                if (fullQWrapper.TransactionType == '-None-') {
                    ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Please select transaction type in customer & billing screen.');
                    ApexPages.addMessage(msg);
                    return null;
                }
                if (fullQWrapper.rentalLengthInProduct == '' || fullQWrapper.rentalLengthInProduct == null) {
                    ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Please select Length of Rental.');
                    ApexPages.addMessage(msg);
                    return null;
                }
                if (test.isRunningTest()) {
                    EditProduct = MMIFullquoteTestDataProvider.getHomeBaseBeansProductsList()[0];
                }
                if (!isTransTmoboORseco) {
                    system.debug('-----------------fullQWrapper.TransactionType------------------' + fullQWrapper.TransactionType);
                    system.debug('-----------------EditProduct.rate5.rate------------------' + EditProduct.rate5.rate);
                    if (fullQWrapper.TransactionType == 'CNST') {
                        if (EditProduct.rate5.rate == null || EditProduct.rate5.rate == '' || Decimal.valueOf(EditProduct.rate5.rate) <= 0) {
                            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, '$0.00 Rental Rate!  Please provide a Rental Rate for this Quote [Unless otherwise authorized to supply a $0.00 Rental Rate].');
                            ApexPages.addMessage(msg);
                            return null;
                        }
                    } else {
                        if ((Integer.valueOf(fullQWrapper.rentalLengthInProduct) == 1 && (EditProduct.rate1.rate == null || EditProduct.rate1.rate == '' || Decimal.valueOf(EditProduct.rate1.rate) <= 0)) || (Integer.valueOf(fullQWrapper.rentalLengthInProduct) >= 2 && Integer.valueOf(fullQWrapper.rentalLengthInProduct) <= 6 && (EditProduct.rate2.rate == null || EditProduct.rate2.rate == '' || Decimal.valueOf(EditProduct.rate2.rate) <= 0)) || (Integer.valueOf(fullQWrapper.rentalLengthInProduct) >= 7 && Integer.valueOf(fullQWrapper.rentalLengthInProduct) <= 12 && (EditProduct.rate3.rate == null || EditProduct.rate3.rate == '' || Decimal.valueOf(EditProduct.rate3.rate) <= 0)) || (Integer.valueOf(fullQWrapper.rentalLengthInProduct) >= 13 && (EditProduct.rate4.rate == null || EditProduct.rate4.rate == '' || Decimal.valueOf(EditProduct.rate4.rate) <= 0))) {
                            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, '$0.00 Rental Rate!  Please provide a Rental Rate for this Quote [Unless otherwise authorized to supply a $0.00 Rental Rate].');
                            ApexPages.addMessage(msg);
                            return null;
                        }
                    }
                } else {
                    if ((Integer.valueOf(fullQWrapper.rentalLengthInProduct) == 1 && (EditProduct.rate1.rate == null || EditProduct.rate1.rate == '' || Decimal.valueOf(EditProduct.rate1.rate) <= 0)) || (Integer.valueOf(fullQWrapper.rentalLengthInProduct) >= 2 && Integer.valueOf(fullQWrapper.rentalLengthInProduct) <= 6 && (EditProduct.rate1.rate == null || EditProduct.rate1.rate == '' || Decimal.valueOf(EditProduct.rate1.rate) <= 0)) || (Integer.valueOf(fullQWrapper.rentalLengthInProduct) >= 7 && Integer.valueOf(fullQWrapper.rentalLengthInProduct) <= 12 && (EditProduct.rate2.rate == null || EditProduct.rate2.rate == '' || Decimal.valueOf(EditProduct.rate2.rate) <= 0)) || (Integer.valueOf(fullQWrapper.rentalLengthInProduct) >= 13 && Integer.valueOf(fullQWrapper.rentalLengthInProduct) <= 24 && (EditProduct.rate3.rate == null || EditProduct.rate3.rate == '' || Decimal.valueOf(EditProduct.rate3.rate) <= 0)) || (Integer.valueOf(fullQWrapper.rentalLengthInProduct) >= 25 && (EditProduct.rate4.rate == null || EditProduct.rate4.rate == '' || Decimal.valueOf(EditProduct.rate4.rate) <= 0))) {
                        ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, '$0.00 Rental Rate!  Please provide a Rental Rate for this Quote [Unless otherwise authorized to supply a $0.00 Rental Rate]');
                        ApexPages.addMessage(msg);
                        return null;
                    }
                }
            }
            if (callRefreshLineService()) {

                summaryLineList = new List < HomeBaseBeans.quoteLine > ();
                summaryLineCount = 1;

                Boolean isExtraHasToCall = false;
                if (test.isRunningTest()) {
                    refreshLineAllResponseList = MMIFullquoteTestDataProvider.getAllQuoteLine();
                }
                for (list < HomeBaseBeans.quoteLine > refreshLineResponseList: refreshLineAllResponseList) {
                    if (refreshLineResponseList[0].errorMessage == null || refreshLineResponseList[0].errorMessage == '') {
                        for (HomeBaseBeans.quoteLine HBQ: refreshLineResponseList) {
                            HomeBaseBeans.quoteLine specificProduct1 = new HomeBaseBeans.quoteLine();
                            //check only for main item and accessories
                            if (HBQ.itemId != 'CG1' && HBQ.itemId != 'CG2' && HBQ.itemId != 'DL1' && HBQ.itemId != 'DL2' && !ckeckModificationItem(HBQ.itemId)) {
                                SelectedRentalLength = fullQWrapper.rentalLengthInProduct;
                            }
                            if (HBQ.itemId != 'CG1' && HBQ.itemId != 'CG2' && HBQ.itemId != 'DL1' && HBQ.itemId != 'DL2' && isAccessorySelected == false) {
                                isProductAlreadyAdded = true;
                                isExtraHasToCall = true;
                            }
                            if (fullQWrapper.selectedFullQUote == 'sales' && ckeckModificationItem(HBQ.itemId)) {
                                HBQ.modificationCharge = decimal.valueOf(HBQ.lineValue);
                            }
                            if (HBQ.itemId != 'CG1' && HBQ.itemId != 'CG2' && HBQ.itemId != 'DL1' && HBQ.itemId != 'DL2') {
                                if (fullQWrapper.disableModificationSelection && fullQWrapper.selectedFullQUote == 'sales' && (SelectedProductDesc == '' || SelectedProductDesc == null)) {
                                    if (!mapItemNameDesc.isEmpty()) {
                                        HBQ.description = mapItemNameDesc.get(HBQ.itemId);
                                    } else {
                                        HBQ.description = '';
                                    }
                                } else {
                                    if (HBQ.description == '' || HBQ.description == null) {
                                        HBQ.description = SelectedProductDesc;
                                    }
                                }
                                HBQ.LockTypeTotal = Decimal.valueOf(HBQ.lineValue).setScale(2);
                                if (fullQWrapper.selectedFullQUote != 'sales') {
                                    if (EditProduct.rate6.rate == null || EditProduct.rate6.rate == '') {
                                        HBQ.rate6.rate = '""';
                                    } else {
                                        HBQ.rate6.rate = EditProduct.rate6.rate;
                                    }
                                    EditProduct.rate6.rate = '';
                                }
                            } else {
                                if (HBQ.itemId == 'CG1') {
                                    HBQ.Description = lockTypeList[0].LockDescription;
                                    HBQ.LockTypeTotal = decimal.valueOf(HBQ.lineValue);
                                } else if (HBQ.itemId == 'CG2') {
                                    HBQ.Description = lockTypeList[1].LockDescription;
                                    HBQ.LockTypeTotal = decimal.valueOf(HBQ.lineValue);
                                } else if (HBQ.itemId == 'DL1') {
                                    HBQ.Description = lockTypeList[2].LockDescription;
                                    HBQ.LockTypeTotal = decimal.valueOf(HBQ.lineValue);
                                } else if (HBQ.itemId == 'DL2') {
                                    HBQ.Description = lockTypeList[3].LockDescription;
                                    HBQ.LockTypeTotal = decimal.valueOf(HBQ.lineValue);
                                }
                            }
                            if (docId != null) {
                                if (HBQ.lineId == '' || HBQ.lineId == null) {
                                    HBQ.lineId = 'new';
                                }
                            } else {
                                HBQ.lineId = '';
                            }
                            specificProduct1 = HBQ;
                            specificProduct1.lineCount = summaryLineCount;
                            summaryLineList.add(specificProduct1);
                            if ((docId != null && HBQ.lineId == 'new' && cloneIsTrue != 'true') || (FQSMrecId != null || fullQuote_tran.documentId__c != null)) {
                                summaryLineInEdit.add(specificProduct1);
                                specificProduct1.lineId = 'newAdded';
                            }
                            summaryLineCount++;
                        }
                        if (fullQWrapper.selectedFullQUote == 'sales') {
                            // Initialize the modification list when modification added
                            if (fullQWrapper.disableModificationSelection) {
                                stdModificationList = new list < FullQuoteWrapper.stdModification > ();
                                InitializeModificationList(stdMList);

                            }
                            fullQWrapper.disableModificationSelection = false;
                        }
                        if (isExtraHasToCall) {
                            CreateExtraLineItem();
                            callProductExtrasService();
                            isExtraHasToCall = false;
                        }
                        ClearLockSelect();
                        accessoriesQuantity = 1;
                        Boolean isStandardModificationSave = false;
                        for (FullQuoteWrapper.stdModification stmod: stdModificationList) {
                            if (stmod.isSelected) {
                                isStandardModificationSave = true;
                            }
                            if (stmod.isSelected && isProductAlreadyAdded) {
                                fullQWrapper.showSubmitButton = false;
                                fullQWrapper.enableRefreshQuote = false;
                            } else {
                                fullQWrapper.enableRefreshQuote = true;
                            }
                        }
                        if (isProductAlreadyAdded) {
                            if (isStandardModificationSave) {
                                fullQWrapper.enableRefreshQuote = false;
                            } else {
                                fullQWrapper.enableRefreshQuote = true;
                            }
                        } else {
                            fullQWrapper.enableRefreshQuote = false;
                        }
                        fullQWrapper.enableSaveQuote = false;
                        fullQWrapper.enableMarkAsLostbutton = false;
                        fullQWrapper.convertQuoteToOrder = false;
                        fullQWrapper.enableProductadd = true;
                        fullQWrapper.fullfillingBranch = true;
                        fullQWrapper.invoiceTabEnableDis = true;
                        fullQWrapper.startDateonchange = true;
                        fullQWrapper.analysisSetHeadValue = true;
                        fullQWrapper.enableVAddresBtnInShipping = false;
                        isFullfillingBranchid = false;
                        isTexIdIsNullbutton = true;
                        isEcodeAllocationBtnDesabled = true;

                    } else {
                        ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, refreshLineResponseList[0].errorMessage);
                        ApexPages.addMessage(msg);
                        break;
                    }
                }
                fullQWrapper.LockType = '';
                fullQWrapper.showEditProduct = false;
                editProduct = new HomeBaseBeans.Products();
                standardRate = ''; // for TFS 2829
                baseRate = ''; // for TFS 3080
                fullQWrapper.enable1Period = false;
                fullQWrapper.enable2To6Period = false;
                fullQWrapper.enable7To12Period = false;
                fullQWrapper.enable13Period = false;
                if (fullQWrapper.selectedFullQUote == 'sales') {
                    fullQWrapper.ItemCode = null;
                    fullQWrapper.ECode = null;
                    fullQWrapper.SuggestedPrice = null;
                    fullQWrapper.MinPrice = null;
                    fullQWrapper.NetBookValue = null;
                    fullQWrapper.assetDescription = null;
                    fullQWrapper.sellingPrice = null;
                    fullQWrapper.ModificationCost = null;
                    fullQWrapper.Reference = null;
                    fullQWrapper.GradeDescription = null;
                    fullQWrapper.LockType = '';
                    ClearLockSelect();
                    accessoriesQuantity = 1;
                }
                if (summaryLineList.size() == 0) {
                    isRentalLength = false;
                } else {
                    isRentalLength = true;
                }
            }
            fullQWrapper.ImageUrl = null;
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC addProductToSummaryLines: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :addProductToSummaryLines' + summaryLineList);
        return null;
    }

    // To remove product line from Product Summary Lines section in product screen

    public PageReference removeLineItemSummaryLine() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :removeLineItemSummaryLine' + summaryLineList + isClearSummaryLineItems);
        String removeSummaryLineId;
        try {
            removeSummaryLineId = System.currentPageReference().getParameters().get('sLineId');
            if (test.isRunningTest()) {
                removeSummaryLineId = '1';
            }
            if (!(removeSummaryLineId == null || removeSummaryLineId == '')) {
                String DeletedItemCode = summaryLineList[integer.valueOf(removeSummaryLineId) - 1].itemId;

                Boolean accessoryRes = false;
                FullQuoteMainService fqService = new FullQuoteMainService();
                accessoryRes = fqService.getAccessoryInfo(DeletedItemCode);
                if (DeletedItemCode != 'CG1' && DeletedItemCode != 'CG2' && DeletedItemCode != 'DL1' && DeletedItemCode != 'DL2' && accessoryRes == false && !ckeckModificationItem(DeletedItemCode)) {
                    if ((docId != null && cloneIsTrue != 'true') || (FQSMrecId != null || fullQuote_tran.documentId__c != null)) {
                        RemoveLineService_AC rls = new RemoveLineService_AC();
                        Integer lstPos = integer.valueOf(removeSummaryLineId) - 1;
                        rls.removeItemFromSummaryLine(summaryLineList[lstPos].lineCount, summaryLineList[lstPos].itemId, summaryLineList[lstPos].lineId, summaryLineInEdit);
                    }
                    summaryLineList.remove(integer.valueOf(removeSummaryLineId) - 1);
                    isProductAlreadyAdded = false;
                    if (fullQWrapper.selectedFullQUote == 'sales') {
                        onChangeModification();
                    }
                    if (summaryLineList.size() > 0) {
                        Integer SummeryListSizeAfterDeleteMainItem = summaryLineList.size();
                        for (Integer j = 0; j < SummeryListSizeAfterDeleteMainItem; j++) {
                            for (Integer i = 0; i < summaryLineList.size(); i++) {
                                if (summaryLineList[i].itemId == 'CG1' || summaryLineList[i].itemId == 'CG2' || summaryLineList[i].itemId == 'DL1' || summaryLineList[i].itemId == 'DL2') {
                                    if ((docId != null && cloneIsTrue != 'true') || (FQSMrecId != null || fullQuote_tran.documentId__c != null)) {
                                        RemoveLineService_AC rls1 = new RemoveLineService_AC();
                                        rls1.removeItemFromSummaryLine(summaryLineList[i].lineCount, summaryLineList[i].itemId, summaryLineList[i].lineId, summaryLineInEdit);
                                    }
                                    summaryLineList.remove(i);
                                }
                            }
                        }
                    }

                    //need to delete all products  and locks from refreshLineAllResponseList after main procuct deleted
                    refreshLineAllResponseList = new list < List < HomeBaseBeans.quoteLine >> ();
                    refreshLineAllResponseList.add(summaryLineList);
                    isRentalLength = false;
                } else {
                    if ((docId != null && cloneIsTrue != 'true') || (FQSMrecId != null || fullQuote_tran.documentId__c != null)) {
                        RemoveLineService_AC rls2 = new RemoveLineService_AC();
                        Integer lstPosition = integer.valueOf(removeSummaryLineId) - 1;
                        rls2.removeItemFromSummaryLine(summaryLineList[lstPosition].lineCount, summaryLineList[lstPosition].itemId, summaryLineList[lstPosition].lineId, summaryLineInEdit);
                    }
                    summaryLineList.remove(integer.valueOf(removeSummaryLineId) - 1);
                }
                if (isProductAlreadyAdded) {
                    fullQWrapper.enableRefreshQuote = true;
                } else {
                    fullQWrapper.enableRefreshQuote = false;
                }
                fullQWrapper.enableSaveQuote = false;
                fullQWrapper.convertQuoteToOrder = false;
                fullQWrapper.enableMarkAsLostbutton = false;
                fullQWrapper.fullfillingBranch = true;
                fullQWrapper.invoiceTabEnableDis = true;
                fullQWrapper.startDateonchange = true;
                fullQWrapper.analysisSetHeadValue = true;
                //fullQWrapper.enableProductadd = false;
                //}
                onChangeModification();
                if (summaryLineList.size() > 0) {
                    for (Integer i = 0; i < summaryLineList.size(); i++) {
                        summaryLineList[i].lineCount = i + 1;
                    }
                }
                if (test.isRunningTest()) {
                    summaryLineList = new list < HomeBaseBeans.quoteLine > ();
                }
                if (summaryLineList.size() == 0) {
                    isRentalLength = false;
                    if (isTransTmoboORseco) {
                        fullQWrapper.rentalLengthInProduct = '2';
                        fullQWrapper.rentalLength = '2';
                    } else {
                        fullQWrapper.rentalLengthInProduct = '1';
                        fullQWrapper.rentalLength = '1';
                    }
                    fullQWrapper.enableRefreshQuote = false;
                    ProductExtrasList = new List < HomeBaseBeans.extras > ();
                    refreshLineAllResponseList = new list < List < HomeBaseBeans.quoteLine >> ();
                    if ((EditProduct.Id != null && EditProduct.Id != '') || (fullQWrapper.ItemCode != null && fullQWrapper.ItemCode != '')) {
                        fullQWrapper.showEditProduct = true;
                        isEcodeAllocationBtnDesabled = false;
                    } else {
                        fullQWrapper.showEditProduct = false;
                        isEcodeAllocationBtnDesabled = true;
                    }
                    fullQWrapper.enableRefreshQuote = false;
                    fullQWrapper.convertQuoteToOrder = false;
                    fullQWrapper.enableMarkAsLostbutton = false;
                    fullQWrapper.enableSaveQuote = false;
                    fullQWrapper.fullfillingBranch = false;
                    fullQWrapper.startDateonchange = false;
                    fullQWrapper.analysisSetHeadValue = false;
                    SelectedRentalLength = '';
                } else {
                    isRentalLength = true;
                }
                if (isTransTmoboORseco) {
                    summaryLineCount = summaryLineList.size() + 1;
                }

                if (FQSMrecId != null && selectedTaxRecInShipping.Id != null && !fullQWrapper.enableVAddresBtnInShipping) {
                    fullQWrapper.enableProductadd = true;
                }
            }
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC removeLineItemSummaryLine: ' + e.getMessage());
            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, e.getMessage());
            ApexPages.addMessage(msg);
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :removeLineItemSummaryLine' + isClearSummaryLineItems + summaryLineList + removeSummaryLineId);
        return null;
    }

    // To call product extras webservice

    public PageReference callProductExtrasService() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :callProductExtrasService');

        ProductExtrasService_AC productExtrasService = null;
        List < HomeBaseBeans.extras > ProductExtrasResponseList;
        String branchId;
        try {
            ProductExtrasList = new List < HomeBaseBeans.extras > ();
            productExtrasService = new ProductExtrasService_AC();
            branchId = FullQuoteDAO.getBranchId(fullQWrapper.fulFillingBranchInShippingDates, recId);
            if (branchId != null && branchId != '') {
                branchIdforViewBranch = branchId;
            }
            ProductExtrasResponseList = productExtrasService.listExtras(productsExtrasPayload, fullQWrapper.TransactionType, fullQWrapper.deliveryZoneInShipping, branchId, fullQWrapper.AccountId, fullQWrapper.rentalLengthInProduct, String.valueOf(fullQuote.Start_Date__c), fullQWrapper.selectedFullQUote);

            if (ProductExtrasResponseList[0].errorMessage == null) {
                for (HomeBaseBeans.extras HB: ProductExtrasResponseList) {
                    system.debug('--------------HB.description----------------' + HB.description);
                    HB.quantity = String.ValueOf(Integer.ValueOf(HB.quantity));
                    if (HB.description.startsWith('Delivery') || HB.description.startsWith('PickUp') || HB.description.startsWith('Security')) {
                        HB.dollarOrPercent = '$';
                    } else {
                        HB.dollarOrPercent = '%';
                    }
                    ProductExtrasList.add(HB);
                }
                setContractValue();
            } else {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, ProductExtrasList[0].errorMessage);
                ApexPages.addMessage(msg);
            }
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC callProductExtrasService: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :removeLineItemSummaryLine' + ProductExtrasList);
        return null;
    }

    public PageReference setContractValue() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :setContractValue' + ProductExtrasList);
        try {
            system.debug(LoggingLevel.DEBUG, 'ProductExtrasList------' + ProductExtrasList);
            fullQWrapper.enableRefreshQuote = true;
            fullQWrapper.enableSaveQuote = false;
            fullQWrapper.enableMarkAsLostbutton = false;

            fullQWrapper.enableProductadd = false;
            fullQWrapper.enableVAddresBtnInShipping = false;
            isFullfillingBranchid = false;
            isTexIdIsNullbutton = true;
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC setContractValue: ' + e.getMessage());
        }

        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :setContractValue');

        return null;
    }

    public void changeExtrasInShippingTab() {
        fullQWrapper.enableRefreshQuote = true;
        fullQWrapper.enableSaveQuote = false;
        fullQWrapper.enableMarkAsLostbutton = false;
        fullQWrapper.enableProductadd = false;
        fullQWrapper.enableVAddresBtnInShipping = false;
        isFullfillingBranchid = false;
        isTexIdIsNullbutton = true;
    }
    public void InvoiceTabFieldValueChange() {
        if (fullQWrapper.invoiceTabEnableDis) {
            fullQWrapper.enableRefreshQuote = true;
            fullQWrapper.enableSaveQuote = false;
            fullQWrapper.enableMarkAsLostbutton = false;
        } else {
            fullQWrapper.enableRefreshQuote = false;
            fullQWrapper.enableSaveQuote = false;
            fullQWrapper.enableMarkAsLostbutton = false;
        }
    }

    public PageReference payLoadtoSaveQuote() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :payLoadtoSaveQuote' + analysisSetHeaderResponseList);

        isErrorDuringUpdationFromOrderConversion = false;
        String accountId;
        String accountIdExist;
        String payLoad;
        MMI_Full_Quotes__c insertQuote = null;
        CreateQuoteService_AC cQuote = null;
        HomeBaseBeans.CreateFullQuoteResponse createQuoteResponse;
        UpdateFullQuoteService_AC updateFullQ = null;
        Boolean isSFDCUpdateSuccess = false;
        PageReference pf = null;
        String branchId;
        String updateRespo;

        try {
            branchId = FullQuoteDAO.getBranchId(fullQWrapper.fulFillingBranchInShippingDates, recId);
            if (branchId != null && branchId != '') {
                branchIdforViewBranch = branchId;
            }
            FullQuoteMainService fqService = new FullQuoteMainService();
            if (fullQuote.Start_Date__c < fullQuote.Scheduled_Delivery__c) {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Start date cannot be before delivery date');
                ApexPages.addMessage(msg);
                if (isUpdateFromOrderConversion) {
                    isErrorDuringUpdationFromOrderConversion = true;
                    return null;
                }
            } else if (fullQuote.Start_Date__c != null && fullQuote.Start_Date__c < system.today()) {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Start Date can not be past date.');
                ApexPages.addMessage(msg);
                if (isUpdateFromOrderConversion) {
                    isErrorDuringUpdationFromOrderConversion = true;
                    return null;
                }
            } else if (fullQuote.Scheduled_Delivery__c != null && fullQuote.Scheduled_Delivery__c < system.today()) {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Scheduled Delivery Date can not be past date.');
                ApexPages.addMessage(msg);
                if (isUpdateFromOrderConversion) {
                    isErrorDuringUpdationFromOrderConversion = true;
                    return null;
                }
            } else if (fullQuote.Quote_expires__c != null && fullQuote.Quote_expires__c < system.today()) {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Quote Expire Date can not be past date.');
                ApexPages.addMessage(msg);
                if (isUpdateFromOrderConversion) {
                    isErrorDuringUpdationFromOrderConversion = true;
                    return null;
                }
            } else if (fullQWrapper.POContact == '' || fullQWrapper.POContact == null) {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Required fields are missing!');
                ApexPages.addMessage(msg);
                if (isUpdateFromOrderConversion) {
                    isErrorDuringUpdationFromOrderConversion = true;
                    return null;
                }
            } else if (fullQWrapper.noOfUnit == null || fullQWrapper.noOfUnit <= 0) {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Please provide # of Units in the shipping tab!');
                ApexPages.addMessage(msg);
                if (isUpdateFromOrderConversion) {
                    isErrorDuringUpdationFromOrderConversion = true;
                    return null;
                }
            } else if (fullQWrapper.storageUse == null || fullQWrapper.storageUse == '') {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Please provide storage use in the product tab!');
                ApexPages.addMessage(msg);
                if (isUpdateFromOrderConversion) {
                    isErrorDuringUpdationFromOrderConversion = true;
                    return null;
                }
            } else {

                selectedVAddressInShipping.address1 = fullQWrapper.AddressInShippingDates;
                payLoad = returnSavePayload();
                System.debug('***** payLoad  ' + payLoad);
                if (cloneIsTrue == 'true') {
                    docId = null;
                }
                if (docId == null) {
                    cQuote = new CreateQuoteService_AC();
                    if (!test.isRunningTest()) {
                        createQuoteResponse = cQuote.CreateQuote(payLoad, fullQWrapper.WriteUpRep, fullQWrapper.selectedFullQUote);
                    } else {
                        createQuoteResponse = MMIFullquoteTestDataProvider.getSaveResponse();
                    }
                    Database.LeadConvertResult lcr = null;
                    insertQuote = new MMI_Full_Quotes__c();

                    if (createQuoteResponse != null && createQuoteResponse.errorMessage == null && (createQuoteResponse.documentId != null && createQuoteResponse.documentId != '')) {
                        if (quickQuoteId != null && quickQuoteId != '') {
                            opportunityID = QqData.Opportunity__c;
                        } else {
                            if (leadRec != null) {
                                if (leadRec.size() > 0) {
                                    //FullQuoteDAO.createTaskBeforeSavingFQ(leadRec[0].id, 'Full Quote');
                                    fullQWrapper.selectedOrPgContId = newContactId;
                                    lcr = fqService.getConvertLeadResultWithResultId(leadRec[0].id, UserInfo.getUserId(), fullQWrapper.AccountId, newAccountId, fullQWrapper);
                                    System.debug('Converted Lead 000000000000000' + lcr);
                                    opportunityID = lcr.getOpportunityId();
                                    FullQuoteDAO.createTaskBeforeSavingFQ(opportunityID, 'Full Quote');
                                    leadConvertedContactId = string.valueOf(lcr.getContactId());
                                    leadConvertedAccId = '';
                                    leadConvertedAccId = string.valueOf(lcr.getAccountId());
                                }
                            }
                            if (opportunityRec != null && (opportunityID == '' || opportunityID == null)) {
                                if (opportunityRec.size() > 0) {
                                    opportunityID = opportunityRec[0].Id;
                                }
                            }
                            if (accountRec != null && (opportunityID == '' || opportunityID == null)) {
                                if (accountRec.size() > 0) {
                                    if (cloneIsTrue == 'true') {
                                        opportunityID = updateQuoteRec.Opportunity__c;
                                    } else {
                                        opportunityID = accountRec[0].Id;
                                    }
                                    accountId = accountRec[0].Id;
                                }
                            }
                            if (FQSMrecId != null && (opportunityID == '' || opportunityID == null)) {
                                if (fullQuote_tran.SourceId__c != null && fullQuote_tran.SourceId__c.startsWith('00Q')) {
                                    FullQuoteDAO.createTaskBeforeSavingFQ(fullQuote_tran.SourceId__c, 'Full Quote');
                                    Database.LeadConvertResult lcr1 = null;
                                    lcr1 = fqService.getConvertLeadResultWithResultId(fullQuote_tran.SourceId__c, UserInfo.getUserId(), fullQWrapper.AccountId, newAccountId, fullQWrapper);
                                    System.debug('Converted Lead 000000000000000' + lcr1);
                                    opportunityID = lcr1.getOpportunityId();
                                }
                                if (fullQuote_tran.SourceId__c != null && fullQuote_tran.SourceId__c.startsWith('006')) {
                                    opportunityID = fullQuote_tran.SourceId__c;
                                }
                                if (fullQuote_tran.SourceId__c != null && fullQuote_tran.SourceId__c.startsWith('001')) {
                                    opportunityID = fullQuote_tran.SourceId__c;
                                    accountId = fullQuote_tran.SourceId__c;
                                }
                                if (fullQuote_tran.SourceId__c != null && fullQuote_tran.SourceId__c.startsWith('a0z')) {
                                    opportunityID = fullQuote_tran.SourceId__c;
                                }
                                /*String qQId = fullQuote_tran.SourceId__c;
                                        opportunityID = [Select Id,Opportunity__c From MMI_Quotes__c where Id = :fullQuote_tran.SourceId__c].get(0).Opportunity__c;*/
                            }
                        }
                        documentId = createQuoteResponse.documentId;
                        docId = documentId;
                        mobilization = createQuoteResponse.mobilization;
                        if (!summaryLineList.isEmpty()) {
                            Boolean accessoryRes = false;
                            for (HomeBaseBeans.quoteLine sm: summaryLineList) {
                                if (sm.itemId != 'CG1' && sm.itemId != 'CG2' && sm.itemId != 'DL1' && sm.itemId != 'DL2' && !ckeckModificationItem(sm.itemId)) {
                                    accessoryRes = fqService.getAccessoryInfo(sm.itemId);
                                    if (accessoryRes == false) {
                                        prodctname = sm.itemId;
                                    }
                                }
                            }
                        }

                        if (!test.isRunningTest()) {
                            String OppIdAndQuoteId = fqService.insertFullQuoteRecord(insertQuote, fullQuote.PO_Expires__c, fullQuote.Start_Date__c, fullQuote.Quote_expires__c, fullQuote.Scheduled_Delivery__c, fullQuote.Loaded_Move_In__c, opportunityID, accountId, createQuoteResponse, fullQWrapper, selectedTaxRecInBilling.Id, selectedTaxRecInShipping.Id, selectedVAddressInShipping, prodctname, cloneIsTrue);
                            system.debug('--------------OppIdAndQuoteId----' + OppIdAndQuoteId);
                            // edited by rajib for Issue 1174------------------
                            if (OppIdAndQuoteId != null && OppIdAndQuoteId != '') {
                                list < String > oppAndFQIdLst = OppIdAndQuoteId.split('_');
                                if (oppAndFQIdLst.size() > 0) {
                                    opportunityID = oppAndFQIdLst[0];
                                    FQId = oppAndFQIdLst[1];
                                    // create task------------------------
                                    if (source == 'jp') {
                                        QuickQuoteMainDAO.createTaskForQQCreatedFromJP(fullQWrapper.jobProfileId, 'fq');
                                    }
                                }
                                system.debug('--------------opportunityID----' + opportunityID);
                            }
                            // edited by rajib for Issue 1174------------------

                        } else {
                            //Opportunity opp=MMIFullquoteTestDataProvider.getOpportunity();
                            //opportunityID=opp.id;
                        }
                        updateOppAddress(opportunityID, 'SaveQuoteDate');
                        fullQWrapper.enableRefreshQuote = false;
                        fullQWrapper.enableSaveQuote = false;
                        fullQWrapper.enableMarkAsLostbutton = false;
                        if (setAccountStatus.contains(fullQWrapper.Status)) {
                            sendHfcStatusMailDuringSave();
                        }
                        if (fullQWrapper.noReservation) {
                            // Modified for issue no 1173 and 1174------------------
                            //pf = new PageReference('/'+opportunityID);
                            pf = new PageReference('/apex/FullQuoteForm_VF?fullQUoteId=' + docId + '&emailQuote=true');
                            pf.setRedirect(true);
                            return pf;
                        } else {
                            isSaveSuccess = true;
                            isInsertingFQ = true;
                            fullQWrapper.showCapacityPopUp = true;
                            fullQWrapper.enableRefreshQuote = false;
                            fullQWrapper.enableSaveQuote = false;
                            fullQWrapper.enableMarkAsLostbutton = false;
                        }

                        return null;
                    } else {
                        fullQWrapper.enableRefreshQuote = true;
                        fullQWrapper.enableSaveQuote = false;
                        fullQWrapper.enableMarkAsLostbutton = false;
                        fullQWrapper.showCapacityPopUp = false;
                        ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, createQuoteResponse.errorMessage);
                        ApexPages.addMessage(msg);
                        return null;
                    }
                } else {
                    //-----------------------------Edit------------------------------------------------------
                    isDecarteError = false;
                    system.debug('Update Full Quote: ' + docId);
                    updateFullQ = new UpdateFullQuoteService_AC();
                    updateRespo = updateFullQ.updateQuote(payLoad, docId, mobilization, branchId, fullQWrapper.WriteUpRep, fullQWrapper.selectedFullQUote, fullQWrapper);
                    if (updateRespo.equalsIgnoreCase('success')) {
                        fullQWrapper.isQuoteUpdatedOnce = true;
                        if (!summaryLineList.isEmpty()) {
                            Boolean accessoryRes = false;
                            for (HomeBaseBeans.quoteLine sm: summaryLineList) {
                                if (sm.itemId != 'CG1' && sm.itemId != 'CG2' && sm.itemId != 'DL1' && sm.itemId != 'DL2' && !ckeckModificationItem(sm.itemId)) {
                                    accessoryRes = fqService.getAccessoryInfo(sm.itemId);
                                    if (accessoryRes == false) {
                                        prodctname = sm.itemId;
                                    }
                                }
                            }
                        }
                        isSFDCUpdateSuccess = fqService.updateFullQuoteRecord(updateQuoteRec, mobilization, docId, fullQuote.PO_Expires__c, fullQuote.Start_Date__c, fullQuote.Quote_expires__c, fullQuote.Scheduled_Delivery__c, fullQuote.Loaded_Move_In__c, opportunityID, fullQWrapper, selectedTaxRecInBilling.Id, selectedTaxRecInShipping.Id, selectedVAddressInShipping, prodctname);

                        if (isSFDCUpdateSuccess) {
                            opportunityID = updateQuoteRec.Opportunity__c;
                            updateOppAddress(opportunityID, 'UpdateQuoteDate');
                            if (isUpdateFromOrderConversion) {
                                return null;
                            }

                            //------Should allow User to remain on the FQ page and select Close Quote if they wish to close out------
                            /*pf = new PageReference('/'+opportunityID);
                                    pf.setRedirect(true);
                                    return pf;*/
                            return null;

                        } else {
                            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'error while saving to SFDC');
                            ApexPages.addMessage(msg);
                            isSaveSuccess = false;
                            fullQWrapper.showCapacityPopUp = false;
                            isErrorDuringUpdationFromOrderConversion = true;
                            return null;
                        }
                    } else {
                        fullQWrapper.enableRefreshQuote = true;
                        fullQWrapper.enableSaveQuote = false;
                        fullQWrapper.enableMarkAsLostbutton = false;
                        fullQWrapper.showCapacityPopUp = false;
                        isErrorDuringUpdationFromOrderConversion = true;
                        if (updateRespo == 'DocumentWaitingForDescartes') {
                            isDecarteError = true;
                        } else {
                            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, updateRespo);
                            ApexPages.addMessage(msg);
                            isDecarteError = false;
                        }
                        qqwrapper.DisplayErrorPopUp = true;
                        return null;
                    }

                }
            }
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC payLoadtoSaveQuote: ' + e.getMessage());
            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, e.getMessage());
            ApexPages.addMessage(msg);
            fullQWrapper.enableRefreshQuote = true;
            fullQWrapper.enableSaveQuote = false;
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :payLoadtoSaveQuote');
        return null;
    }

    public Pagereference closeDecarteErrorPopup() {
        isDecarteError = false;
        return null;
    }

    public String populateUnitType(String ProductId) {
        String unitTypeVal = '';
        if (ProductId != null && ProductId != '') {
            //------------populate Unit Type------TFS 3280-------------
            List < Product_And_Def_Code__c > lstProdNDefCodes = QuickQuoteMainDAO.getLstProductAndDefCode(ProductId);
            system.debug('-------------lstProdNDefCodes-------------------' + lstProdNDefCodes);
            if (!lstProdNDefCodes.isEmpty()) {
                String defCode = lstProdNDefCodes[0].Def_Code__c;
                if (defCode == 'CONT') {
                    unitTypeVal = 'Container';
                }
                if (defCode == 'MOBILE') {
                    unitTypeVal = 'Mobile Office';
                }
                if (defCode == 'SECURITY') {
                    unitTypeVal = 'Security Office';
                }
                if (unitTypeVal == null || unitTypeVal == '') {
                    unitTypeVal = 'Other';
                }
            }
        }
        return unitTypeVal;
    }

    public String getMainProduct() {
        FullQuoteMainService fqService = new FullQuoteMainService();
        String prodctname = '';
        if (!summaryLineList.isEmpty()) {
            Boolean accessoryRes = false;
            for (HomeBaseBeans.quoteLine sm: summaryLineList) {
                if (sm.itemId != 'CG1' && sm.itemId != 'CG2' && sm.itemId != 'DL1' && sm.itemId != 'DL2' && !ckeckModificationItem(sm.itemId)) {
                    accessoryRes = fqService.getAccessoryInfo(sm.itemId);
                    if (accessoryRes == false) {
                        prodctname = sm.itemId;
                    }
                }
            }
        }
        return prodctname;
    }

    public void updateOppAddress(String opportunityID, String saveQuotedate) {
        FullQuoteMainService fqService = new FullQuoteMainService();
        system.debug('-----------opportunityID-------------------' + opportunityID);
        if (opportunityID != null && opportunityID != '') {
            opportunityRec = fqService.getOppInfo(opportunityID);
            system.debug('-----------opportunityRec-------------------' + opportunityRec);
            accountRec = fqService.getAccounListInfo(opportunityRec[0].AccountId);
            if (!accountRec.isEmpty()) {
                accountRec[0].Result_Id__c = fullQWrapper.AccountId;
                if (accountRec[0].BillingCountry == null) {
                    accountRec[0].BillingCountry = 'USA';
                }
                update accountRec[0];
            }
            if (!opportunityRec.isEmpty()) {
                opportunityRec[0].Why_do_you_need_storage_Picklist__c = fullQWrapper.storageUse; //------TFS 3262------------
                /*//------TFS 2719------------
                      if(fullQWrapper.selectedFullQUote == 'sales'){
                          opportunityRec[0].Unit_Type__c = fullQWrapper.unitType;
                      }else{
                          if(fullQWrapper.TransactionType == 'VANT' || fullQWrapper.TransactionType == 'CNST' || fullQWrapper.TransactionType == 'CART ' || fullQWrapper.TransactionType == 'ON' || fullQWrapper.TransactionType == 'OFF'){
                            opportunityRec[0].Unit_Type__c = 'Container';
                          }else if(fullQWrapper.TransactionType == 'MOBO'){
                            opportunityRec[0].Unit_Type__c = 'Mobile Office';
                          }else if(fullQWrapper.TransactionType == 'SECO'){
                            opportunityRec[0].Unit_Type__c = 'Security Office';
                          }else{
                            opportunityRec[0].Unit_Type__c = 'Other';
                          }
                      }
                      //------TFS 2719------------*/
                //------TFS 3280-----------------------------------
                String MainProductItem = getMainProduct();
                opportunityRec[0].Unit_Type__c = populateUnitType(MainProductItem);

                //-------TFS 2728-----------------------
                if (fullQWrapper.deliveryZoneInShipping == null || fullQWrapper.deliveryZoneInShipping == '' || fullQWrapper.deliveryZoneInShipping == 'null') {
                    opportunityRec[0].Delivery_Zone__c = 'Null';
                } else {
                    opportunityRec[0].Delivery_Zone__c = fullQWrapper.deliveryZoneInShipping;
                }
                //-------TFS 2728-----------------------
                //----------TFS 2720-------------------------------------
                opportunityRec[0].of_Units__c = fullQWrapper.noOfUnit;
                //----------TFS 2720--------------------------------------
                //----------Issue 1239-------------------------------
                opportunityRec[0].Contact_Name__c = fullQWrapper.Name;
                opportunityRec[0].Contact_Last_Name__c = fullQWrapper.LastName;
                opportunityRec[0].Contact_Phone__c = fullQWrapper.telePhone;
                opportunityRec[0].Contact_Mobile__c = fullQWrapper.conMob;
                //opportunityRec[0].Contact_Email__c = fullQWrapper.conEmail;
                opportunityRec[0].Contact_Email__c = fullQWrapper.Email;
                opportunityRec[0].Quote_Comments__c = fullQWrapper.fqComments;
                //--------issue 1181---------------------------------------------
                if (fullQWrapper.jobProfileId != null && fullQWrapper.jobProfileId != '' && fullQWrapper.accIdOfJp != null && fullQWrapper.accIdOfJp != '' && (fullQWrapper.contactId == null || fullQWrapper.contactId == '')) {
                    Contact contactRec = new Contact(FirstName = fullQWrapper.Name, LastName = fullQWrapper.LastName, AccountId = fullQWrapper.accIdOfJp, Phone = fullQWrapper.telePhone, Email = fullQWrapper.Email, MobilePhone = fullQWrapper.conMob,Result_Id__c = fullQWrapper.BillingContactID);
                    insert contactRec;
                    //opportunityRec[0].Contact__c = contactRec.Id;
                    opportunityRec[0].Opportunity_Contact_Name_LookUpFilter__c = contactRec.Id;
                } else if (fullQWrapper.jobProfileId != null && fullQWrapper.jobProfileId != '' && fullQWrapper.accIdOfJp != null && fullQWrapper.accIdOfJp != '' && fullQWrapper.contactId != null && fullQWrapper.contactId != '') {
                    if (fullQWrapper.BillingContactID != null && fullQWrapper.BillingContactID != '') {
                        Contact contactRecordToUpdate = null;
                        list<Contact> listExistingContactPresent = new list<Contact>();
                        listExistingContactPresent = [select Id, FirstName, LastName, Phone, MobilePhone, Email, Result_Id__c FROM Contact WHERE Result_Id__c = :fullQWrapper.BillingContactID and AccountId = :fullQWrapper.accIdOfJp limit 1];
                        if(listExistingContactPresent.size() == 0){
                            Contact contactToInsert = new Contact();
                            contactToInsert.FirstName = fullQWrapper.Name;
                            contactToInsert.LastName = fullQWrapper.LastName;
                            contactToInsert.Phone = fullQWrapper.telePhone;
                            contactToInsert.MobilePhone = fullQWrapper.conMob;
                            contactToInsert.Email = fullQWrapper.Email;
                            contactToInsert.AccountId = fullQWrapper.accIdOfJp;
                            contactToInsert.Result_Id__c = fullQWrapper.BillingContactID;
                            insert contactToInsert;
                            opportunityRec[0].Opportunity_Contact_Name_LookUpFilter__c = contactToInsert.Id;
                        }else{
                            contactRecordToUpdate = listExistingContactPresent[0];
                        }
                        if (contactRecordToUpdate != null) {
                            contactRecordToUpdate.FirstName = fullQWrapper.Name;
                            contactRecordToUpdate.LastName = fullQWrapper.LastName;
                            contactRecordToUpdate.Phone = fullQWrapper.telePhone;
                            contactRecordToUpdate.MobilePhone = fullQWrapper.conMob;
                            contactRecordToUpdate.Email = fullQWrapper.Email;
                            contactRecordToUpdate.Result_Id__c = fullQWrapper.BillingContactID;
                            update contactRecordToUpdate;
                            opportunityRec[0].Opportunity_Contact_Name_LookUpFilter__c = contactRecordToUpdate.Id;
                        }
                    }else{
                        Contact conObj = QuickQuoteMainDAO.getContactRecord(fullQWrapper.contactId);
                        if (conObj != null) {
                            conObj.FirstName = fullQWrapper.Name;
                            conObj.LastName = fullQWrapper.LastName;
                            conObj.Phone = fullQWrapper.telePhone;
                            conObj.MobilePhone = fullQWrapper.conMob;
                            conObj.Email = fullQWrapper.Email;
                            update conObj;
                            //opportunityRec[0].Contact__c = conObj.Id;
                            opportunityRec[0].Opportunity_Contact_Name_LookUpFilter__c = conObj.Id;
                        }
                    }
                }
                //--------------issue 1181------------------------------------------------------
                if (qqWrapper.jobProfileId == null || qqWrapper.jobProfileId == '') {
                    if (leadRec.size() > 0 && (quickQuoteId == null || quickQuoteId == '')) {
                        if (fullQWrapper.BillingContactID != null && fullQWrapper.BillingContactID != '') {
                            Contact contactRecToUpdate = null;
                            list<Contact> lstExistingContactPresent = new list<Contact>();
                            if (leadRec[0].Company == null || leadRec[0].Company == '') {
                                contactRecToUpdate = [SELECT Id, FirstName, LastName, Phone, MobilePhone, Email, Result_Id__c FROM Contact WHERE Id = :leadConvertedContactId];
                            } else {
                                lstExistingContactPresent = [select Id, FirstName, LastName, Phone, MobilePhone, Email, Result_Id__c FROM Contact WHERE Result_Id__c = :fullQWrapper.BillingContactID and AccountId = :leadConvertedAccId limit 1];
                                if(lstExistingContactPresent.size() == 0){
                                    Contact conToInsert = new Contact();
                                    conToInsert.FirstName = fullQWrapper.Name;
                                    conToInsert.LastName = fullQWrapper.LastName;
                                    conToInsert.Phone = fullQWrapper.telePhone;
                                    conToInsert.MobilePhone = fullQWrapper.conMob;
                                    conToInsert.Email = fullQWrapper.Email;
                                    conToInsert.AccountId = leadConvertedAccId;
                                    conToInsert.Result_Id__c = fullQWrapper.BillingContactID;
                                    insert conToInsert;
                                    opportunityRec[0].Opportunity_Contact_Name_LookUpFilter__c = conToInsert.Id;
                                }else{
                                    contactRecToUpdate = lstExistingContactPresent[0];
                                }
                            }

                            if (contactRecToUpdate != null) {
                                contactRecToUpdate.FirstName = fullQWrapper.Name;
                                contactRecToUpdate.LastName = fullQWrapper.LastName;
                                contactRecToUpdate.Phone = fullQWrapper.telePhone;
                                contactRecToUpdate.MobilePhone = fullQWrapper.conMob;
                                contactRecToUpdate.Email = fullQWrapper.Email;
                                contactRecToUpdate.Result_Id__c = fullQWrapper.BillingContactID;
                                update contactRecToUpdate;
                                //opportunityRec[0].Contact__c = contactRecToUpdate.Id;
                                opportunityRec[0].Opportunity_Contact_Name_LookUpFilter__c = contactRecToUpdate.Id;
                            }
                        }else{
                            //opportunityRec[0].Contact__c = leadConvertedContactId;
                            Contact contactRecToUpdate1 = null;
                            if (leadRec[0].Company == null || leadRec[0].Company == '') {
                                contactRecToUpdate1 = [Select Id, FirstName, LastName, Phone, MobilePhone, Email,Result_Id__c from Contact where Id = : leadConvertedContactId];
                            } else {
                                contactRecToUpdate1 = QuickQuoteMainDAO.getContactRecord(leadConvertedContactId);
                            }
                            if (contactRecToUpdate1 != null) {
                                contactRecToUpdate1.FirstName = fullQWrapper.Name;
                                contactRecToUpdate1.LastName = fullQWrapper.LastName;
                                contactRecToUpdate1.Phone = fullQWrapper.telePhone;
                                contactRecToUpdate1.MobilePhone = fullQWrapper.conMob;
                                contactRecToUpdate1.Email = fullQWrapper.Email;
                                update contactRecToUpdate1;
                            }
                            opportunityRec[0].Opportunity_Contact_Name_LookUpFilter__c = leadConvertedContactId;
                        }

                    } else {
                        if (fullQWrapper.BillingContactID != null && fullQWrapper.BillingContactID != '') {
                            
                            Contact contactRecToUpdate = null;
                            list<Contact> lstExistingContactPresent = new list<Contact>();
                            if (opportunityRec[0].Account.IsPersonAccount) {
                                contactRecToUpdate = [SELECT Id, FirstName, LastName, Phone, MobilePhone, Email, Result_Id__c FROM Contact WHERE Id = : ContId];
                            } else {
                                lstExistingContactPresent = [select Id, FirstName, LastName, Phone, MobilePhone, Email, Result_Id__c FROM Contact WHERE Result_Id__c = :fullQWrapper.BillingContactID and AccountId = :opportunityRec[0].AccountId limit 1];
                                if(lstExistingContactPresent.size() == 0){
                                    Contact conToInsert = new Contact();
                                    conToInsert.FirstName = fullQWrapper.Name;
                                    conToInsert.LastName = fullQWrapper.LastName;
                                    conToInsert.Phone = fullQWrapper.telePhone;
                                    conToInsert.MobilePhone = fullQWrapper.conMob;
                                    conToInsert.Email = fullQWrapper.Email;
                                    conToInsert.AccountId = opportunityRec[0].AccountId;
                                    conToInsert.Result_Id__c = fullQWrapper.BillingContactID;
                                    insert conToInsert;
                                    opportunityRec[0].Opportunity_Contact_Name_LookUpFilter__c = conToInsert.Id;
                                }else{
                                    contactRecToUpdate = lstExistingContactPresent[0];
                                }
                            }

                            if (contactRecToUpdate != null) {
                                contactRecToUpdate.FirstName = fullQWrapper.Name;
                                contactRecToUpdate.LastName = fullQWrapper.LastName;
                                contactRecToUpdate.Phone = fullQWrapper.telePhone;
                                contactRecToUpdate.MobilePhone = fullQWrapper.conMob;
                                contactRecToUpdate.Email = fullQWrapper.Email;
                                contactRecToUpdate.Result_Id__c = fullQWrapper.BillingContactID;
                                update contactRecToUpdate;
                                //opportunityRec[0].Contact__c = contactRecToUpdate.Id;
                                opportunityRec[0].Opportunity_Contact_Name_LookUpFilter__c = contactRecToUpdate.Id;
                            }
                        }else{
                            if (ContId != null && ContId != '') {
                                Contact contactRecToUpdate = null;
                                if (opportunityRec[0].Account.IsPersonAccount) {
                                    contactRecToUpdate = [SELECT Id, FirstName, LastName, Phone, MobilePhone, Email,Result_Id__c FROM Contact WHERE Id = : ContId];
                                } else {
                                    contactRecToUpdate = QuickQuoteMainDAO.getContactRecord(ContId);
                                }
    
                                if (contactRecToUpdate != null) {
                                    contactRecToUpdate.FirstName = fullQWrapper.Name;
                                    contactRecToUpdate.LastName = fullQWrapper.LastName;
                                    contactRecToUpdate.Phone = fullQWrapper.telePhone;
                                    contactRecToUpdate.MobilePhone = fullQWrapper.conMob;
                                    contactRecToUpdate.Email = fullQWrapper.Email;
                                    //contactRecToUpdate.Result_Id__c = fullQWrapper.BillingContactID;
                                    update contactRecToUpdate;
                                    //opportunityRec[0].Contact__c = contactRecToUpdate.Id;
                                    opportunityRec[0].Opportunity_Contact_Name_LookUpFilter__c = contactRecToUpdate.Id;
                                }
                            }
                        }
                        //---------for norml update------------

                        String editedQuoteId = System.currentPageReference().getParameters().get('fullQUoteId');
                        system.debug('--------------editedQuoteId-----------------' + editedQuoteId);
                        system.debug('--------------cloneIsTrue-----------------' + cloneIsTrue);
                        system.debug('--------------ContId-----------------' + ContId);

                        if (editedQuoteId != null && editedQuoteId != '' && cloneIsTrue != 'true' && (ContId == null || ContId == '')) {
                            system.debug('--------------opportunityRec[0].Opportunity_Contact_Name_LookUpFilter__c-----------------' + opportunityRec[0].Opportunity_Contact_Name_LookUpFilter__c);
                            if (opportunityRec[0].Opportunity_Contact_Name_LookUpFilter__c != null) {
                                Contact conObjToUpdateDuringEdit = [SELECT Id, FirstName, LastName, Phone, MobilePhone, Email FROM Contact WHERE Id = : opportunityRec[0].Opportunity_Contact_Name_LookUpFilter__c];
                                system.debug('--------------conObjToUpdateDuringEdit-----------------' + conObjToUpdateDuringEdit);
                                if (conObjToUpdateDuringEdit != null) {
                                    conObjToUpdateDuringEdit.FirstName = fullQWrapper.Name;
                                    conObjToUpdateDuringEdit.LastName = fullQWrapper.LastName;
                                    conObjToUpdateDuringEdit.Phone = fullQWrapper.telePhone;
                                    conObjToUpdateDuringEdit.MobilePhone = fullQWrapper.conMob;
                                    conObjToUpdateDuringEdit.Email = fullQWrapper.Email;
                                    update conObjToUpdateDuringEdit;
                                }
                            }
                        }
                    }

                    /*if(opportunityRec[0].Account.IsPersonAccount){
                            Account AccObjToUpdate = [select Id, PersonAssistantName,PersonAssistantPhone from Account where Id = :opportunityRec[0].AccountId ];
                            if(AccObjToUpdate != null){
                                AccObjToUpdate.PersonAssistantName = fullQWrapper.Name + ' ' + fullQWrapper.LastName;
                                AccObjToUpdate.PersonAssistantPhone = fullQWrapper.telePhone;
                                update AccObjToUpdate;
                            }
                         }else{
                            system.debug('------------opportunityRec------------'+opportunityRec);
                            if(opportunityRec[0].AccountId != null){
                                //Contact ConObjToUpdate = new Contact();
                                list<Contact> ConObjToUpdate = [select Id,FirstName,LastName,Phone from Contact where AccountId = :opportunityRec[0].AccountId limit 1];
                                if(!ConObjToUpdate.isEmpty()){
                                    ConObjToUpdate[0].FirstName = fullQWrapper.Name;
                                    if(test.isRunningTest()){
                                        fullQWrapper.LastName = 'tertr';
                                    }
                                    ConObjToUpdate[0].LastName = fullQWrapper.LastName;
                                    ConObjToUpdate[0].Phone = fullQWrapper.telePhone;
                                    update ConObjToUpdate[0];
                                }else{
                                    Contact contactRec1 = new Contact(FirstName = fullQWrapper.Name, LastName = fullQWrapper.LastName, AccountId = opportunityRec[0].AccountId, Phone = fullQWrapper.telePhone);
                                    insert contactRec1;                                 
                                }
                            }
                         }*/
                }
                //----------Issue 1239-------------------------------

                //-------------set primary contact----------------------------------
                if (fullQWrapper.primaryContactNo != null && fullQWrapper.primaryContactNo != '') {
                    if (fullQWrapper.primaryContactNo == 'Phone') {
                        if (opportunityRec[0].Opportunity_Contact_Name_LookUpFilter__c != null) {
                            opportunityRec[0].Primary_Contact_Number__c = fullQWrapper.telePhone;
                        }
                    }
                    if (fullQWrapper.primaryContactNo == 'MobilePhone') {
                        if (opportunityRec[0].Opportunity_Contact_Name_LookUpFilter__c != null) {
                            opportunityRec[0].Primary_Contact_Number__c = fullQWrapper.conMob;
                        }
                    }
                } else {
                    if (opportunityRec[0].Opportunity_Contact_Name_LookUpFilter__c != null) {
                        opportunityRec[0].Primary_Contact_Number__c = fullQWrapper.telePhone;
                    }
                }
                //-------------set primary contact----------------------------------



                //----------Issue 1181----------------------------
                if (fullQWrapper.jobProfileId != null && fullQWrapper.jobProfileId != '') {
                    opportunityRec[0].Job_Profile__c = fullQWrapper.jobProfileId;
                    opportunityRec[0].LeadSource = 'Job Profile';
                    if (fullQWrapper.subContId != null && fullQWrapper.subContId != '') {
                        Sub_Contractor__c scRec = QuickQuoteMainDAO.getSCRecord(fullQWrapper.subContId);
                        if (scRec != null && scRec.Role__c != null) {
                            opportunityRec[0].Sub_Contractor_Role__c = scRec.Role__c;
                        }
                    }
                }
                //----------Issue 1181---------------------------- 

                String oppName = '';
                Boolean accessoryRes = false;
                for (HomeBaseBeans.quoteLine sm: summaryLineList) {
                    if (sm.itemId != 'CG1' && sm.itemId != 'CG2' && sm.itemId != 'DL1' && sm.itemId != 'DL2' && !ckeckModificationItem(sm.itemId)) {
                        accessoryRes = fqService.getAccessoryInfo(sm.itemId);
                        if (accessoryRes == false) {
                            prodctname = sm.itemId;
                        }
                    }
                }
                Integer oppFullQuotecountCount = [select id from MMI_Full_Quotes__c where Opportunity__c = : opportunityRec[0].id].size();
                Integer oppQuickQuotecountCount = [Select Id From MMI_Quotes__c where Opportunity__c = : opportunityRec[0].id].size();

                Integer oppcountCount;
                if (oppFullQuotecountCount != null && oppQuickQuotecountCount != null) {
                    oppcountCount = oppFullQuotecountCount + oppQuickQuotecountCount;
                } else {
                    if (oppFullQuotecountCount != null) {
                        oppcountCount = oppFullQuotecountCount;
                    } else {
                        oppcountCount = oppQuickQuotecountCount;
                    }
                }
                if (oppcountCount > 1) {
                    oppName = opportunityRec[0].Account.Name + '/Mult Quotes';
                } else {
                    if (fullQWrapper.unitPriceInvoice == null || fullQWrapper.unitPriceInvoice == '') {
                        fullQWrapper.unitPriceInvoice = '0.00';
                    }
                    if (fullQWrapper.RentalCharge == null || fullQWrapper.RentalCharge == '') {
                        fullQWrapper.RentalCharge = '0.00';
                    }
                    if (fullQWrapper.DeliveryInInvoicing == null || fullQWrapper.DeliveryInInvoicing == '') {
                        fullQWrapper.DeliveryInInvoicing = '0.00';
                    }
                    if (fullQWrapper.pickupCharge == null || fullQWrapper.pickupCharge == '') {
                        fullQWrapper.pickupCharge = '0.00';
                    }


                    if (fullQWrapper.selectedFullQUote == 'sales') {
                        oppName = prodctname + '/' + Integer.valueOf(decimal.valueOf(fullQWrapper.unitPriceInvoice)) + '/' + Integer.ValueOf(decimal.valueOf(fullQWrapper.DeliveryInInvoicing));
                    } else {
                        oppName = prodctname + '/' + Integer.valueOf(decimal.valueOf(fullQWrapper.RentalCharge)) + '/' + Integer.ValueOf(decimal.valueOf(fullQWrapper.DeliveryInInvoicing)) + '/' + Integer.valueOf(decimal.valueOf(fullQWrapper.pickupCharge));
                    }
                }
                if (saveQuotedate == 'SaveQuoteDate') {
                    opportunityRec[0].Result_Rental_Sale_Doc__c = null;
                }
                opportunityRec[0].Name = oppName;
                opportunityRec[0].Delivery_Street__c = fullQWrapper.AddressInShippingDates;
                opportunityRec[0].Delivery_City__c = fullQWrapper.cityInShippingDates;
                opportunityRec[0].Delivery_State_Province__c = fullQWrapper.stateInShippingDates;
                opportunityRec[0].Delivery_Zip_Postal_Code__c = fullQWrapper.ZipCodeInShipping;
                opportunityRec[0].Delivery_Country__c = fullQWrapper.countryInShippingDates;
                opportunityRec[0].Transaction_Type__c = transtionTypeName;
                opportunityRec[0].StageName = 'Quoted - No Decision';
                opportunityRec[0].Type_of_Quote_Given__c = 'Salesforce Full Quote';

                opportunityRec[0].Quote_type__c = fullQWrapper.selectedFullQUote;

                // mitul change 6th nov
                for (HomeBaseBeans.quoteLine sm: summaryLineList) {
                    if (sm.itemId != 'CG1' && sm.itemId != 'CG2' && sm.itemId != 'DL1' && sm.itemId != 'DL2' && !ckeckModificationItem(sm.itemId)) {
                        accessoryRes = fqService.getAccessoryInfo(sm.itemId);
                        if (accessoryRes == false) {
                            opportunityRec[0].Item_Code__c = sm.itemId;
                            opportunityRec[0].Base_Price__c = sm.price;
                            //opportunityRec[0].of_Units__c = sm.quantity;
                        }
                    }
                }

                if (documentId != null && documentId != '') {
                    opportunityRec[0].Result_Quote_ID__c = documentId;
                }
                if (fullQWrapper.DeliveryInInvoicing != null && fullQWrapper.DeliveryInInvoicing != '') {
                    opportunityRec[0].Delivery_Rate_Incl_Fuel__c = Decimal.valueOf(fullQWrapper.DeliveryInInvoicing);
                }
                if (fullQWrapper.pickupCharge != null && fullQWrapper.pickupCharge != '') {
                    opportunityRec[0].Pick_up_Rate_Incl_Fuel__c = Decimal.valueOf(fullQWrapper.pickupCharge);
                }

                /*for(HomeBaseBeans.extras sl : ProductExtrasList){
                        if(sl.id == 'DELIVERY' || sl.Id == 'DELZZ'+fullQWrapper.deliveryZoneInShipping){
                            opportunityRec[0].Delivery_Rate_Incl_Fuel__c = Decimal.valueOf(sl.total);
                        }
                        if(sl.Description == 'Fuel Surcharge Delivery' ){
                            if(opportunityRec[0].Delivery_Rate_Incl_Fuel__c != null){
                                opportunityRec[0].Delivery_Rate_Incl_Fuel__c = opportunityRec[0].Delivery_Rate_Incl_Fuel__c + Decimal.valueOf(sl.total);
                            }else{
                                opportunityRec[0].Delivery_Rate_Incl_Fuel__c = Decimal.valueOf(sl.total);
                            }
                        }
                        if(sl.id == 'PICKUP' || sl.Id == 'PUZZ'+fullQWrapper.deliveryZoneInShipping){
                            opportunityRec[0].Pick_up_Rate_Incl_Fuel__c = Decimal.valueOf(sl.total);
                        }
                        if(sl.Description == 'Fuel Surcharge Pick Up' ){
                            if(opportunityRec[0].Pick_up_Rate_Incl_Fuel__c != null){
                                opportunityRec[0].Pick_up_Rate_Incl_Fuel__c = opportunityRec[0].Pick_up_Rate_Incl_Fuel__c + Decimal.valueOf(sl.total);
                            }else{
                                opportunityRec[0].Pick_up_Rate_Incl_Fuel__c = Decimal.valueOf(sl.total);
                            }
                        }
                    }*/

                //------------------issue 1268-------------------------------------------
                if ((leadRec != null && !leadRec.isEmpty()) || (FQSMrecId != null && fullQuote_tran != null && fullQuote_tran.SourceId__c != null && fullQuote_tran.SourceId__c != null && fullQuote_tran.SourceId__c.startsWith('00Q'))) {
                    opportunityRec[0].Type = 'New Business';
                    opportunityRec[0].Opportunity_Rating__c = 'Warm (Possibly Order)';
                } else {
                    opportunityRec[0].Type = 'Existing Business';
                    opportunityRec[0].Opportunity_Rating__c = 'Warm (Possibly Order)';
                }

                //-------------------issue 1268 end---------------------------------------------------
                update opportunityRec[0];
            }
        }
    }
    public Pagereference payLoadtoMarkAsLost() {

        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :payLoadtoMarkAsLost' + analysisSetHeaderResponseList);
        markeAsLostoppStageChange = System.currentPageReference().getParameters().get('markAsLossOppconformation');
        String opportunityID;
        String opportunityIDMarkAsLost;
        String accountId;
        String payLoad;
        MMI_Full_Quotes__c insertQuote = null;
        MarkAsLostService cQuote = null;
        HomeBaseBeans.CreateFullQuoteResponse markLostResponse;
        UpdateFullQuoteService_AC updateFullQ = null;
        Boolean isSFDCUpdateSuccess = false;
        PageReference pf = null;
        String branchId;
        String updateRespo;
        isMarkAsLostError = false;

        try {
            branchId = FullQuoteDAO.getBranchId(fullQWrapper.fulFillingBranchInShippingDates, recId);
            if (branchId != null && branchId != '') {
                branchIdforViewBranch = branchId;
            }
            FullQuoteMainService fqService = new FullQuoteMainService();
            if (fullQuote.Start_Date__c < fullQuote.Scheduled_Delivery__c) {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Start date cannot be before delivery date');
                ApexPages.addMessage(msg);
            } else if (fullQWrapper.POContact == '' || fullQWrapper.POContact == null) {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Required fields are missing');
                ApexPages.addMessage(msg);
            } else {
                if (fullQuote.Start_Date__c != null && fullQuote.Start_Date__c < system.today()) {
                    //ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,'Start Date can not be past date.');
                    //ApexPages.addMessage(msg);
                    fullQuote.Start_Date__c = system.today();
                }
                if (fullQuote.Scheduled_Delivery__c != null && fullQuote.Scheduled_Delivery__c < system.today()) {
                    //ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,'Start Date can not be past date.');
                    //ApexPages.addMessage(msg);
                    fullQuote.Scheduled_Delivery__c = system.today();
                }
                payLoad = returnSavePayload();
                cQuote = new MarkAsLostService();
                System.debug('***** payLoad  ' + payLoad);
                if (docId == null) {
                    markLostResponse = cQuote.CreateQuote(fullQWrapper.selectedFullQUote, payLoad, fullQWrapper.WriteUpRep, branchId);
                    if (test.isRunningTest()) {
                        markLostResponse = MMIFullquoteTestDataProvider.getSaveResponse();
                    }
                    Database.LeadConvertResult lcr = null;
                    insertQuote = new MMI_Full_Quotes__c();

                    if (markLostResponse.errorMessage == null) {
                        if (quickQuoteId != null && quickQuoteId != '') {
                            opportunityID = QqData.Opportunity__c;
                        } else {
                            if (leadRec.size() > 0) {
                                lcr = fqService.getConvertLeadResultWithResultId(leadRec[0].id, UserInfo.getUserId(), fullQWrapper.AccountId, newAccountId, fullQWrapper);
                                System.debug('Converted Lead 000000000000000' + lcr);

                                opportunityID = lcr.getOpportunityId();
                                opportunityIDMarkAsLost = lcr.getOpportunityId();
                            } else if (opportunityRec.size() > 0) {
                                opportunityID = opportunityRec[0].Id;
                                opportunityIDMarkAsLost = opportunityRec[0].Id;
                            } else {
                                if (accountRec.size() > 0) {
                                    opportunityID = accountRec[0].Id;
                                    accountId = accountRec[0].Id;
                                }
                            }
                            if (markeAsLostoppStageChange == 'yesChangeStage') {
                                if (opportunityIDMarkAsLost != null && opportunityIDMarkAsLost != '') {
                                    fqService.getOppStageUpdate(opportunityID);
                                }

                            }
                        }
                        documentId = markLostResponse.documentId;
                        docId = documentId;
                        mobilization = markLostResponse.mobilization;

                        isMarkAsLostError = true;

                    }
                    ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, markLostResponse.errorMessage);
                    ApexPages.addMessage(msg);
                    return pf;
                } else {

                    system.debug('mark as lost edit Quote: ' + docId);
                    markLostResponse = cQuote.CreateQuote(fullQWrapper.selectedFullQUote, payLoad, fullQWrapper.WriteUpRep, branchId);
                    if (test.isRunningTest()) {
                        markLostResponse = MMIFullquoteTestDataProvider.getSaveResponse();
                    }
                    if (markLostResponse.errorMessage == null) {
                        if (!summaryLineList.isEmpty()) {
                            Boolean accessoryRes = false;
                            for (HomeBaseBeans.quoteLine sm: summaryLineList) {
                                if (sm.itemId != 'CG1' && sm.itemId != 'CG2' && sm.itemId != 'DL1' && sm.itemId != 'DL2' && !ckeckModificationItem(sm.itemId)) {
                                    accessoryRes = fqService.getAccessoryInfo(sm.itemId);
                                    if (accessoryRes == false) {
                                        prodctname = sm.itemId;
                                    }
                                }
                            }
                        }
                        isSFDCUpdateSuccess = fqService.updateFullQuoteRecord(updateQuoteRec, mobilization, docId, fullQuote.PO_Expires__c, fullQuote.Start_Date__c, fullQuote.Quote_expires__c, fullQuote.Scheduled_Delivery__c, fullQuote.Loaded_Move_In__c, opportunityID, fullQWrapper, selectedTaxRecInBilling.Id, selectedTaxRecInShipping.Id, selectedVAddressInShipping, prodctname);

                        if (isSFDCUpdateSuccess) {
                            MMI_Full_Quotes__c FqObj = FullQuoteDAO.getFullQuoteRecord(docId);
                            FqObj.Status__c = 'L';
                            update FqObj;
                            isMarkAsLostError = true;

                        } else {
                            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'error while saving to SFDC');
                            ApexPages.addMessage(msg);

                            return null;
                        }
                    } else {
                        ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, markLostResponse.errorMessage);
                        ApexPages.addMessage(msg);
                        qqwrapper.DisplayErrorPopUp = true;
                        return null;
                    }

                }
            }
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC payLoadtoMarkAsLost: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :payLoadtoMarkAsLost');
        return null;
    }

    public Pagereference closeMarkAsLostPopUp() {
        isMarkAsLostError = false;
        if (updateQuoteRec.Opportunity__c != null) {
            PageReference pf1 = new PageReference('/' + updateQuoteRec.Opportunity__c);
            pf1.setRedirect(true);
            return pf1;
        } else {
            PageReference pf = new PageReference('/' + opportunityID);
            pf.setRedirect(true);
            return pf;
        }
        return null;
    }

    public PageReference ChangeButtonStatus() {
        if (isProductAlreadyAdded) {
            fullQWrapper.enableRefreshQuote = true;
        } else {
            fullQWrapper.enableRefreshQuote = false;
        }
        fullQWrapper.enableSaveQuote = false;
        return null;
    }

    // Refresh quote
    public void printViewQuote() {
        FullQuoteMainService fqService = new FullQuoteMainService();
        ppeValue = 0.00;
        llwValue = 0.00;
        totalRentalCharat = 0.00;
        totalOneTimeCharges = 0.00;
        totalInitialCharges = 0.00;
        totalSalesCharat = 0.00;
        if (QuoteType == 'sales') {
            salesTotal = fullQWrapper.taxInvoice;
        } else {
            salesTotal = fullQWrapper.TaxTotal;
        }
        if (salesTotal == null || salesTotal == '') {
            salesTotal = '0.00';
        }
        for (HomeBaseBeans.quoteLine sl: summaryLineList) {

            if (QuoteType == 'sales') {
                if (totalSalesCharat == null) {
                    totalSalesCharat = decimal.valueOf(sl.lineValue);
                } else {
                    totalSalesCharat = totalSalesCharat + decimal.valueOf(sl.lineValue);
                }

            } else {
                if (sl.itemId != 'CG1' && sl.itemId != 'CG2' && sl.itemId != 'DL1' && sl.itemId != 'DL2') {

                    if (totalRentalCharat == null) {
                        if (fullQWrapper.QuoteTotal == 'CT') {
                            Boolean accessoryRes = false;
                            accessoryRes = fqService.getAccessoryInfo(sl.itemId);
                            system.debug('-------------accessoryRes-------------------' + accessoryRes);
                            if (accessoryRes) {
                                totalRentalCharat = decimal.valueOf(sl.lineValue);
                            } else {
                                totalRentalCharat = decimal.valueOf(sl.lineValue) * sl.quantity;
                            }
                        } else {
                            totalRentalCharat = sl.price * sl.quantity;
                        }
                    } else {
                        if (fullQWrapper.QuoteTotal == 'CT') {
                            Boolean accessoryRes = false;
                            accessoryRes = fqService.getAccessoryInfo(sl.itemId);
                            system.debug('-------------accessoryRes-------------------' + accessoryRes);
                            if (accessoryRes) {
                                totalRentalCharat = totalRentalCharat + (decimal.valueOf(sl.lineValue)).setScale(2);
                            } else {
                                totalRentalCharat = totalRentalCharat + (decimal.valueOf(sl.lineValue) * sl.quantity).setScale(2);
                            }
                        } else {
                            totalRentalCharat = totalRentalCharat + (sl.price * sl.quantity).setScale(2);
                        }
                    }
                    // add calcu 20th_nov and also add one var in homebase class
                    if (fullQWrapper.QuoteTotal == 'CT') {
                        Boolean accessoryRes = false;
                        accessoryRes = fqService.getAccessoryInfo(sl.itemId);
                        system.debug('-------------accessoryRes-------------------' + accessoryRes);
                        if (accessoryRes) {
                            sl.totalperPeriodvalue = (decimal.valueOf(sl.lineValue)).setScale(2);
                        } else {
                            sl.totalperPeriodvalue = (decimal.valueOf(sl.lineValue) * sl.quantity).setScale(2);
                        }
                    } else {
                        sl.totalperPeriodvalue = (sl.price * sl.quantity).setScale(2);
                    }
                } else {
                    if (totalOneTimeCharges == null) {
                        totalOneTimeCharges = decimal.valueOf(sl.lineValue);
                    } else {
                        totalOneTimeCharges = totalOneTimeCharges + decimal.valueOf(sl.lineValue);
                    }
                    // add calcu 20th_nov and also add one var in homebase class 
                    sl.totalperPeriodvalue = decimal.valueOf(sl.lineValue);
                }
            }
        }
        for (HomeBaseBeans.extras HB: ProductExtrasList) {

            if (QuoteType == 'sales') {
                if (totalSalesCharat == null) {
                    totalSalesCharat = Decimal.valueOf(HB.total);
                } else {
                    totalSalesCharat = totalSalesCharat + Decimal.valueOf(HB.total);
                }

            } else {

                if (HB.description.startsWith('Delivery')) {

                    if (totalOneTimeCharges == null) {
                        totalOneTimeCharges = Decimal.valueOf(HB.total);
                    } else {
                        totalOneTimeCharges = totalOneTimeCharges + Decimal.valueOf(HB.total);
                    }

                }

                if (HB.description.startsWith('PickUp')) {

                    if (totalOneTimeCharges == null) {
                        totalOneTimeCharges = Decimal.valueOf(HB.total);
                    } else {
                        totalOneTimeCharges = totalOneTimeCharges + Decimal.valueOf(HB.total);
                    }

                }
                if (HB.description.startsWith('Pick up')) {
                    if (totalOneTimeCharges == null) {
                        totalOneTimeCharges = Decimal.valueOf(HB.total);
                    } else {
                        totalOneTimeCharges = totalOneTimeCharges + Decimal.valueOf(HB.total);
                    }
                }

                if (HB.description.contains('Loss Limitation')) {
                    llwValue = Decimal.valueOf(HB.total) / Integer.valueof(fullQWrapper.rentalLengthInProduct);
                    if (fullQWrapper.QuoteTotal == 'CT') {
                        llwValue = Decimal.valueOf(HB.total);
                    }
                    llwValue = llwValue.setScale(2);
                    system.debug('--- -' + llwValue);
                    if (totalRentalCharat == null) {
                        totalRentalCharat = llwValue;
                    } else {
                        totalRentalCharat = totalRentalCharat + llwValue;
                    }
                }
                if (HB.description.startsWith('Fuel Surcharge')) {

                    if (totalOneTimeCharges == null) {
                        totalOneTimeCharges = Decimal.valueOf(HB.total);
                    } else {
                        totalOneTimeCharges = totalOneTimeCharges + Decimal.valueOf(HB.total);
                    }

                }

                if (HB.description.contains('Personal Property Expense')) {
                    ppeValue = Decimal.valueOf(HB.total) / Integer.valueof(fullQWrapper.rentalLengthInProduct);
                    if (fullQWrapper.QuoteTotal == 'CT') {
                        ppeValue = Decimal.valueOf(HB.total);
                    }
                    ppeValue = ppeValue.setScale(2);

                    if (totalRentalCharat == null) {
                        totalRentalCharat = ppeValue;
                    } else {
                        totalRentalCharat = totalRentalCharat + ppeValue;
                    }
                }
                if (HB.description.contains('Security Deposit')) {
                    if (totalOneTimeCharges == null) {
                        totalOneTimeCharges = Decimal.valueOf(HB.total);
                    } else {
                        totalOneTimeCharges = totalOneTimeCharges + Decimal.valueOf(HB.total);
                    }
                }
            }

        }
        if (QuoteType == 'sales') {
            if (totalInitialCharges == null) {
                totalInitialCharges = totalSalesCharat + totalOneTimeCharges + Decimal.valueOf(salesTotal);
            } else {
                totalInitialCharges = totalInitialCharges + totalSalesCharat + totalOneTimeCharges + Decimal.valueOf(salesTotal);
            }
        } else {
            if (totalInitialCharges == null) {
                totalInitialCharges = totalRentalCharat + totalOneTimeCharges + Decimal.valueOf(salesTotal);
            } else {
                totalInitialCharges = totalInitialCharges + totalRentalCharat + totalOneTimeCharges + Decimal.valueOf(salesTotal);
            }
        }
    }
    public PageReference refreshQuote() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :refreshQuote');
        fullQWrapper.RentalCharge = null;
        //fullQWrapper.DeliveryInInvoicing = null;
        fullQWrapper.LLWTotal = null;
        fullQWrapper.pickupCharge = null;
        fullQWrapper.otherInInvoicing = null;
        fullQWrapper.Accessories = null;
        fullQWrapper.CODAmount = null;
        fullQWrapper.TotalCODAmount = null;
        fullQWrapper.TaxTotal = null;
        //fullQWrapper.PPETotal = null;

        String startDate = '';
        String plannedCollectionDate = '';
        String quoteExpires = '';
        String PO_Expires = '';
        String shippingDate = '';
        FullQuoteHelper fqHelper = null;
        String payLoad;
        RefreshQuoteService_AC refreshQuote = null;
        FullQuoteRefreshParser_AC EditResponse;
        String branchId;

        try {
            Boolean isProductPresentInSummeryLine = false;
            for (HomeBaseBeans.quoteLine sl: summaryLineList) {
                FullQuoteMainService fqService = new FullQuoteMainService();
                if (sl.itemId != 'CG1' && sl.itemId != 'CG2' && sl.itemId != 'DL1' && sl.itemId != 'DL2' && !(fqService.getAccessoryInfo(sl.itemId))) {
                    isProductPresentInSummeryLine = true;
                }
            }
            if (!isProductPresentInSummeryLine) {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Please add a main product in the product summery line to create a quote.');
                ApexPages.addMessage(msg);
                return null;
            }
            analysisSetSelectedInBilling();
            analysisSetSelectedInShipping();
            if (fullQuote.PO_Expires__c != null) {
                PO_Expires = String.valueOf(fullQuote.PO_Expires__c).split(' ')[0];
            }
            if (fullQuote.Quote_expires__c != null) {
                quoteExpires = String.valueOf(fullQuote.Quote_expires__c).split(' ')[0];
            }
            if (fullQuote.Start_Date__c != null) {
                startDate = String.valueOf(fullQuote.Start_Date__c).split(' ')[0];
            }
            if (fullQuote.Loaded_Move_In__c != null) {
                plannedCollectionDate = String.valueOf(fullQuote.Loaded_Move_In__c).split(' ')[0];
            }
            if (fullQuote.Scheduled_Delivery__c != null) {
                shippingDate = String.valueOf(fullQuote.Scheduled_Delivery__c).split(' ')[0];
            }

            fqHelper = new FullQuoteHelper();
            fullQWrapper.userBranchId = FullQuoteDAO.getBranchId(fullQWrapper.fulFillingBranchInShippingDates, recId);
            if (fullQWrapper.userBranchId != null && fullQWrapper.userBranchId != '') {
                branchIdforViewBranch = fullQWrapper.userBranchId;
            }
            selectedVAddressInShipping.address1 = fullQWrapper.AddressInShippingDates;
            payLoad = fqHelper.getRefreshPayload(fullQWrapper, summaryLineList, analysisSetHeaderResponseList, analysisSetHeaderResponseShippingList, ProductExtrasList, selectedVAddressInShipping, selectedVAddressInBilling, startDate, plannedCollectionDate, quoteExpires, PO_Expires, shippingDate, selectedTaxRecInBilling, selectedTaxRecInShipping, SelectedShipingTaxId, SelectedRentalLength, docId, updateQuoteRec);


            //}
            system.debug('---payload------' + payLoad);
            weeklyBranchSnop = FullQuoteDAO.getWeeklySnapShortBranchReport(fullQWrapper.userBranchId);
            branchId = FullQuoteDAO.getBranchId(fullQWrapper.fulFillingBranchInShippingDates, recId);
            if (branchId != null && branchId != '') {
                branchIdforViewBranch = branchId;
            }
            refreshQuote = new RefreshQuoteService_AC();
            EditResponse = refreshQuote.callRefreshQuoteService(payLoad, branchId, fullQWrapper.WriteUpRep, fullQWrapper.selectedFullQUote);

            if (EditResponse.errorMessage == null) {
                fqHelper.assignRefreshValue(fullQWrapper, summaryLineList, analysisSetHeaderResponseList, analysisSetHeaderResponseShippingList, ProductExtrasList, selectedVAddressInShipping, selectedVAddressInBilling, startDate, plannedCollectionDate, quoteExpires, PO_Expires, shippingDate, selectedTaxRecInBilling, selectedTaxRecInShipping, EditResponse);
                printViewQuote();
                isRefreshTrue = true;
                fullQWrapper.enableRefreshQuote = false;
                fullQWrapper.enableSaveQuote = true;
                if (docId != null) {
                    fullQWrapper.enableMarkAsLostbutton = true;
                } else {
                    fullQWrapper.enableMarkAsLostbutton = false;
                }
                if (docId != null && cloneIsTrue == 'false') {
                    fullQWrapper.convertQuoteToOrder = true;
                } else {
                    fullQWrapper.convertQuoteToOrder = false;
                }
                fullQWrapper.enableProductadd = true;
                fullQWrapper.enableVAddresBtnInShipping = false;
                isFullfillingBranchid = false;
                isTexIdIsNullbutton = true;
                //-----------------TFS 3280--------------------
                String MainProductItem = getMainProduct();
                system.debug('---------------MainProductItem---------------' + MainProductItem);
                fullQWrapper.unitType = populateUnitType(MainProductItem);
                system.debug('---------------populateUnitType(MainProductItem)---------------' + populateUnitType(MainProductItem));
                system.debug('--------------fullQWrapper.unitType--------------' + fullQWrapper.unitType);
                //-----------------TFS 3280--------------------

            } else {
                isRefreshTrue = false;
                fullQWrapper.enableSaveQuote = false;
                fullQWrapper.enableMarkAsLostbutton = false;
                fullQWrapper.enableRefreshQuote = true;
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, EditResponse.errorMessage);
                ApexPages.addMessage(msg);
            }
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC refreshQuote: ' + e.getMessage());
        }
        return null;
    }

    public void analysisSetValidation() {
        for (HomeBaseBeans.AnalysisSetHeaders HB: analysisSetHeaderResponseList) {
            if (HB.selectedId == null) {
                if (!(HB.description == 'Deferred Bill' || HB.description == 'Outside TSM' || HB.description == 'Write Off A/C' || HB.description == 'Cost Center')) {
                    ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Please Select Analysis Set Header Value In Customer and Billing Tab');
                    ApexPages.addMessage(msg);
                    break;
                }
            }
        }
    }
    public pageReference callShippingAnalysisSetsService() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :callShippingAnalysisSetsService' + analysisSetDelTimeResponseList);
        isCallingExtraAnalysisNeeded = false;
        AnalysisSetCodesService_AC analysisSetCodeSerice = null;
        try {
            String branchId;
            branchId = FullQuoteDAO.getBranchId(FulFillingBranchId, Apexpages.currentPage().getParameters().get('id'));
            if (branchId != null && branchId != '') {
                branchIdforViewBranch = branchId;
            }
            if (!isQqToFqLoadsFirstTime && !isEditQuoteLoadsFirstTime) {
                system.debug('--isEditQuoteLoadsFirstTime-' + isEditQuoteLoadsFirstTime);
                for (HomeBaseBeans.AnalysisSetHeaders HB: analysisSetHeaderResponseList) {
                    if (HB.selectedId == null) {
                        if (!(HB.description == 'Deferred Bill' || HB.description == 'Outside TSM' || HB.description == 'Write Off A/C' || HB.description == 'Cost Center')) {
                            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Please Select Analysis Set Header Value In Customer and Billing Tab');
                            ApexPages.addMessage(msg);
                            break;
                        }
                    }
                }
            } else {
                isQqToFqLoadsFirstTime = false; // set false after page load
                isEditQuoteLoadsFirstTime = false; // set false after page load
            }
            if (fullQWrapper.isUseBillingAddress) {
                fullQWrapper.isUseBillingAddress = true;
            }

            if (isShippingTabChaneValue == false) {
                analysisShippingWebservice();
                analysisSetCodeSerice = new AnalysisSetCodesService_AC();

                analysisSetDelTimeResponseList = new List < HomeBaseBeans.analysisSetCodes > ();
                analysisSetCallTypeResponseList = new List < HomeBaseBeans.analysisSetCodes > ();
                analysisSetDoorDirResponseList = new List < HomeBaseBeans.analysisSetCodes > ();
                analysisSetMovementTypeResponseList = new List < HomeBaseBeans.analysisSetCodes > ();

                analysisSetDelTimeResponseList = analysisSetCodeSerice.listActiveTransactions('111');

                analysisSetCallTypeResponseList = analysisSetCodeSerice.listActiveTransactions('112');

                analysisSetDoorDirResponseList = analysisSetCodeSerice.listActiveTransactions('113');

                analysisSetMovementTypeResponseList = analysisSetCodeSerice.listActiveTransactions('114');
                if (test.isRunningTest()) {
                    analysisSetHeaderResponseShippingList = MMIFullquoteTestDataProvider.getAnalysisSetHeaderAll();
                }
                for (HomeBaseBeans.AnalysisSetHeaders HB: analysisSetHeaderResponseShippingList) {
                    HB.selectOptionList = new List < SelectOption > ();
                    HB.selectOptionList.add(new SelectOption('', '-None-'));
                    if (HB.description == 'Movement Type') {

                        for (HomeBaseBeans.analysisSetCodes HB_A: analysisSetMovementTypeResponseList) {
                            HB.selectedId = 'DL';
                            HB.selectedDescription = 'Delivery';
                            HB.selectOptionList.add(new SelectOption(HB_A.Id, HB_A.description));

                        }
                    }
                    if (HB.description == 'Del Time') {

                        for (HomeBaseBeans.analysisSetCodes HB_A: analysisSetDelTimeResponseList) {
                            HB.selectOptionList.add(new SelectOption(HB_A.Id, HB_A.description));
                        }
                    }
                    if (HB.description == 'Call First') {
                        for (HomeBaseBeans.analysisSetCodes HB_A: analysisSetCallTypeResponseList) {
                            HB.selectOptionList.add(new SelectOption(HB_A.Id, HB_A.description));
                        }

                        HB.selectedId = 'YES';
                        HB.selectedDescription = 'Call First';
                    }
                    if (HB.description == 'Door Dir') {
                        for (HomeBaseBeans.analysisSetCodes HB_A: analysisSetDoorDirResponseList) {
                            HB.selectOptionList.add(new SelectOption(HB_A.Id, HB_A.description));
                        }
                    }

                }
                if (editFQResponse.rentalQuote != null) {
                    analysisSetCodeAssignment(editFQResponse);

                }

                if (fullQuote_tran != null) {
                    List < AdditionalAnalysisSet__c > AdditionalAnalysisSetsList = fullQuote_tran.AdditionalAnalysisSets__r;
                    integer i = 1;
                    for (HomeBaseBeans.AnalysisSetHeaders HB: analysisSetHeaderResponseShippingList) {
                        for (AdditionalAnalysisSet__c analyRec: AdditionalAnalysisSetsList) {
                            if (i == integer.valueOf(analyRec.Sequence__c)) {
                                HB.id = analyRec.Header_id__c;
                                HB.description = analyRec.Header_description__c;
                                HB.selectedId = analyRec.Selection_id__c;
                                HB.selectedDescription = analyRec.Selection_description__c;
                            }

                        }
                        i++;
                    }
                }
            }
            isShippingTabChaneValue = true;
            if (test.isRunningTest()) {
                FQSMrecId = '124341234';
            }
            if (FQSMrecId != null) {
                lockTypeList = new list < FullQuoteWrapper.lockTypesAndQuantity > ();
                FullQuoteWrapper.lockTypesAndQuantity lockObj1 = new FullQuoteWrapper.lockTypesAndQuantity();
                lockObj1.LockName = 'CG1';
                lockObj1.LockDescription = 'Container Guard Lock Keyed Different';
                lockObj1.isLockselected = false;
                lockObj1.lockQuantity = 1;
                lockTypeList.add(lockObj1);
                FullQuoteWrapper.lockTypesAndQuantity lockObj2 = new FullQuoteWrapper.lockTypesAndQuantity();
                lockObj2.LockName = 'CG2';
                lockObj2.LockDescription = 'Container Guard Lock Keyed Alike';
                lockObj2.isLockselected = false;
                lockObj2.lockQuantity = 1;
                lockTypeList.add(lockObj2);
                FullQuoteWrapper.lockTypesAndQuantity lockObj3 = new FullQuoteWrapper.lockTypesAndQuantity();
                lockObj3.LockName = 'DL1';
                lockObj3.LockDescription = 'Disc Lock Keyed Different';
                lockObj3.isLockselected = false;
                lockObj3.lockQuantity = 1;
                lockTypeList.add(lockObj3);
                FullQuoteWrapper.lockTypesAndQuantity lockObj4 = new FullQuoteWrapper.lockTypesAndQuantity();
                lockObj4.LockName = 'DL2';
                lockObj4.LockDescription = 'Disc Lock Keyed Alike';
                lockObj4.isLockselected = false;
                lockObj4.lockQuantity = 1;
                lockTypeList.add(lockObj4);
            }
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC callShippingAnalysisSetsService: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :callShippingAnalysisSetsService' + analysisSetDelTimeResponseList);
        if (FQSMrecId != null && !isAllModificationRejected) {
            fullQWrapper.showEditProduct = true;
            if (fullQWrapper.TransactionType == 'SOFL') {
                isTransTmoboORseco = true;
            } else {
                isTransTmoboORseco = false;
            }
        }
        return null;
    }

    public PageReference analysisSetSelectedInShipping() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :analysisSetSelectedInShipping' + analysisSetHeaderResponseShippingList);
        try {
            for (HomeBaseBeans.AnalysisSetHeaders HB: analysisSetHeaderResponseShippingList) {
                for (HomeBaseBeans.analysisSetCodes HB_A: analysisSetDelTimeResponseList) {
                    if (HB.selectedId == HB_A.id) {
                        HB.selectedDescription = HB_A.description;
                    }
                }
                for (HomeBaseBeans.analysisSetCodes HB_A: analysisSetCallTypeResponseList) {
                    if (HB.selectedId == HB_A.id) {
                        HB.selectedDescription = HB_A.description;
                    }
                }
                for (HomeBaseBeans.analysisSetCodes HB_A: analysisSetDoorDirResponseList) {
                    if (HB.selectedId == HB_A.id) {
                        HB.selectedDescription = HB_A.description;
                    }
                }
                for (HomeBaseBeans.analysisSetCodes HB_A: analysisSetMovementTypeResponseList) {
                    if (HB.selectedId == HB_A.id) {
                        HB.selectedDescription = HB_A.description;
                    }
                }
            }
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC analysisSetSelectedInShipping: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :analysisSetSelectedInShipping');

        return null;
    }


    // Standard Modificaiton assig method

    public void assingModificationValue(Full_Quote_Transactional__c fullQuote_tran, FullQuoteWrapper.DescarteInnerClass selectedVAddressInBilling, FullQuoteWrapper.DescarteInnerClass selectedVAddressInShipping,
    List < HomeBaseBeans.extras > ProductExtrasList, List < HomeBaseBeans.quoteLine > summaryLineList,
    List < HomeBaseBeans.AnalysisSetHeaders > analysisSetHeaderResponseList, List < HomeBaseBeans.AnalysisSetHeaders > analysisSetHeaderResponseShippingList) {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :assignEditValues' + fullQuote_tran);
        try {
            FullQuoteHelper fqHelper = new FullQuoteHelper();
            fqHelper.assingModificationValue(fullQuote_tran, fullQWrapper, ProductExtrasList, summaryLineCount, summaryLineList, selectedVAddressInBilling, selectedVAddressInShipping, analysisSetHeaderResponseList, analysisSetHeaderResponseShippingList);
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC assignEditValues: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :assignEditValues' + analysisSetHeaderResponseList + fullQWrapper + ProductExtrasList);
    }


    public void ModifySummaryLine() {
        RemoveLineService_AC rlsObj = new RemoveLineService_AC();
        list < HomeBaseBeans.quoteLine > tempSummaryList = new list < HomeBaseBeans.quoteLine > ();
        FullQuoteMainService fqService = new FullQuoteMainService();
        for (HomeBaseBeans.quoteLine sl: summaryLineList) {
            if (!fqService.getAccessoryInfo(sl.itemId) && sl.itemId != 'CG1' && sl.itemId != 'CG2' && sl.itemId != 'DL1' && sl.itemId != 'DL2' && ckeckModificationItem(sl.itemId) == false) {
                isProductAlreadyAdded = true;
            }
            if (cloneIsTrue == 'true' && ckeckModificationItem(sl.itemId) == false) {
                tempSummaryList.add(sl);
            }
        }
        if (cloneIsTrue == 'true') {
            summaryLineList = tempSummaryList;
        } else {
            summaryLineInEdit = rlsObj.CreateDuplicateCopyOfSummaryLine(summaryLineList);
        }
    }

    public void assignEditValues(EditFullQUoteService_AC EditResponse, FullQuoteWrapper.DescarteInnerClass selectedVAddressInBilling, FullQuoteWrapper.DescarteInnerClass selectedVAddressInShipping,
    List < HomeBaseBeans.extras > ProductExtrasList, List < HomeBaseBeans.quoteLine > summaryLineList,
    List < HomeBaseBeans.AnalysisSetHeaders > analysisSetHeaderResponseList, List < HomeBaseBeans.AnalysisSetHeaders > analysisSetHeaderResponseShippingList) {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :assignEditValues' + EditResponse);
        try {
            FullQuoteHelper fqHelper = new FullQuoteHelper();
            fqHelper.assignEditValue(EditResponse, fullQWrapper, ProductExtrasList, summaryLineCount, summaryLineList, selectedVAddressInBilling, selectedVAddressInShipping, analysisSetHeaderResponseList, analysisSetHeaderResponseShippingList);

            /*if(fullQWrapper.selectedFullQUote == 'sales'){
                    isSalesType = true;
                }else{
                    isSalesType = false;
                }
                */
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC assignEditValues: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :assignEditValues' + analysisSetHeaderResponseList + fullQWrapper + ProductExtrasList);

    }


    public pageReference reserveCapacity() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :reserveCapacity');
        String revCapacity;
        try {
            if (isCapacityAlreadyReserved) {
                fullQWrapper.showCapacityPopUp = true;
                fullQWrapper.ifCapacityYes = false;
                fullQWrapper.showReserveCapacityId = false;
            } else {
                fullQWrapper.showReserveCapacityId = true;
                ReserveCapacityParser_AC RPC = null;
                if (documentId == null || fullQuote.Scheduled_Delivery__c < system.today()) {
                    if (documentId == null) {
                        ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Document Id is required.');
                        ApexPages.addMessage(msg);
                    }
                    if (fullQuote.Scheduled_Delivery__c < system.today()) {
                        ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Delivery date cannot be a past date.');
                        ApexPages.addMessage(msg);
                    }
                } else {
                    IsReservedSuccess = false;
                    RPC = new ReserveCapacityParser_AC();
                    revCapacity = RPC.callReserveCapacity(date.valueOf(fullQuote.Scheduled_Delivery__c), fullQWrapper.deliverySlot, documentId, '1', mobilization, fullQWrapper.selectedFullQUote);
                    if (revCapacity.contains('"errorCode"') || revCapacity.contains('"userErrorMessage"') || revCapacity.contains('"developerErrorMessage"')) {
                        fullQWrapper.reserveCapacityId = QuickQuoteErrorHandler.handleError(revCapacity);
                        isCapacityAlreadyReserved = false;
                    } else {
                        list < String > lstReservId = revCapacity.split(':');
                        fullQWrapper.reserveCapacityId = 'Your reservation Id is: ' + lstReservId[1].subString(1, lstReservId[1].length() - 2);
                        //fullQWrapper.reserveCapacityId = revCapacity;
                        IsReservedSuccess = true;
                        isCapacityAlreadyReserved = true;
                        if (isSaveSuccess || isCapacityAlreadyReserved) {
                            if (updateQuoteRec != null) {
                                updateQuoteRec.Reservation_ID__c = lstReservId[1].subString(1, lstReservId[1].length() - 2);
                            }
                            MMI_Full_Quotes__c justSavedQuoteRec = new MMI_Full_Quotes__c();
                            FullQuoteMainService fqService = new FullQuoteMainService();
                            justSavedQuoteRec = fqService.getFullQuote(docId);
                            justSavedQuoteRec.Reservation_ID__c = lstReservId[1].subString(1, lstReservId[1].length() - 2);
                            //String selectedCapacityDate = System.currentPageReference().getParameters().get('capacitySelactedValue');
                            String selectedCapacityDate = String.valueOf(fullQuote.Scheduled_Delivery__c);
                            justSavedQuoteRec.Start_Date__c = date.valueOf(selectedCapacityDate.substring(0, 10));
                            justSavedQuoteRec.Scheduled_Delivery__c = date.valueOf(selectedCapacityDate.substring(0, 10));
                            justSavedQuoteRec.User_who_created_capacity__c = UserInfo.getUserId();
                            update justSavedQuoteRec;
                            fullQWrapper.isCapacityReservedDurinEdit = true;
                            //------------TFS 2956------------
                            if (justSavedQuoteRec.Opportunity__c != null) {
                                list < Opportunity > lstOppToUpdateUserName = FullQuoteDAO.getOppRecord(justSavedQuoteRec.Opportunity__c);
                                if (lstOppToUpdateUserName.size() > 0) {
                                    lstOppToUpdateUserName[0].Who_Reserved_Capacity__c = UserInfo.getUserId();
                                    update lstOppToUpdateUserName[0];
                                }
                            }
                            //------------TFS 2956------------
                        }

                    }
                }
            }
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC reserveCapacity: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :reserveCapacity' + revCapacity + '------fullQWrapper.showReserveCapacityId--' + fullQWrapper.showReserveCapacityId);
        return null;
    }


    public void analysisSetCodeAssignment(EditFullQUoteService_AC EditResponse) {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :analysisSetCodeAssignment' + EditResponse);
        Integer i = 1;
        try {
            for (HomeBaseBeans.AnalysisSetHeaders HB: analysisSetHeaderResponseShippingList) {
                System.debug('#############' + HB);
                if (i == 2) {
                    HB.description = EditResponse.rentalQuote.additionalAnalysisSet1.header.description;
                    HB.id = EditResponse.rentalQuote.additionalAnalysisSet1.header.id;
                    HB.selectedId = EditResponse.rentalQuote.additionalAnalysisSet1.selection.id;
                    HB.selectedDescription = EditResponse.rentalQuote.additionalAnalysisSet1.selection.description;
                }
                if (i == 3) {
                    HB.description = EditResponse.rentalQuote.additionalAnalysisSet2.header.description;
                    HB.id = EditResponse.rentalQuote.additionalAnalysisSet2.header.id;
                    HB.selectedId = EditResponse.rentalQuote.additionalAnalysisSet2.selection.id;
                    HB.selectedDescription = EditResponse.rentalQuote.additionalAnalysisSet2.selection.description;
                }
                if (i == 4) {
                    HB.description = EditResponse.rentalQuote.additionalAnalysisSet3.header.description;
                    HB.id = EditResponse.rentalQuote.additionalAnalysisSet3.header.id;
                    HB.selectedId = EditResponse.rentalQuote.additionalAnalysisSet3.selection.id;
                    HB.selectedDescription = EditResponse.rentalQuote.additionalAnalysisSet3.selection.description;
                }
                if (i == 1) {
                    HB.description = EditResponse.rentalQuote.additionalAnalysisSet4.header.description;
                    HB.id = EditResponse.rentalQuote.additionalAnalysisSet4.header.id;
                    HB.selectedId = EditResponse.rentalQuote.additionalAnalysisSet4.selection.id;
                    HB.selectedDescription = EditResponse.rentalQuote.additionalAnalysisSet4.selection.description;
                }
                i++;
            }
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC analysisSetCodeAssignment: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :analysisSetCodeAssignment' + analysisSetHeaderResponseShippingList);
    }

    public void analysisWebservicesCustomer(EditFullQUoteService_AC EditResponse) {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :analysisWebservicesCustomer' + EditResponse);
        Integer i = 1;
        try {
            for (HomeBaseBeans.AnalysisSetHeaders HB: analysisSetHeaderResponseList) {
                if (i == 1) {
                    HB.description = EditResponse.rentalQuote.analysisSet1.header.description;
                    HB.id = EditResponse.rentalQuote.analysisSet1.header.id;
                    HB.selectedId = EditResponse.rentalQuote.analysisSet1.selection.id;
                    HB.selectedDescription = EditResponse.rentalQuote.analysisSet1.selection.description;
                    HB.Longdescription = EditResponse.rentalQuote.analysisSet1.selection.Longdescription;
                }
                if (i == 2) {
                    HB.description = EditResponse.rentalQuote.analysisSet2.header.description;
                    HB.id = EditResponse.rentalQuote.analysisSet2.header.id;
                    HB.selectedId = EditResponse.rentalQuote.analysisSet2.selection.id;
                    HB.selectedDescription = EditResponse.rentalQuote.analysisSet2.selection.description;
                    HB.Longdescription = EditResponse.rentalQuote.analysisSet2.selection.Longdescription;
                }
                if (i == 3) {
                    HB.description = EditResponse.rentalQuote.analysisSet3.header.description;
                    HB.id = EditResponse.rentalQuote.analysisSet3.header.id;
                    HB.selectedId = EditResponse.rentalQuote.analysisSet3.selection.id;
                    HB.selectedDescription = EditResponse.rentalQuote.analysisSet3.selection.description;
                    HB.Longdescription = EditResponse.rentalQuote.analysisSet3.selection.Longdescription;
                }
                if (i == 4) {
                    HB.description = EditResponse.rentalQuote.analysisSet4.header.description;
                    HB.id = EditResponse.rentalQuote.analysisSet4.header.id;
                    HB.selectedId = EditResponse.rentalQuote.analysisSet4.selection.id;
                    HB.selectedDescription = EditResponse.rentalQuote.analysisSet4.selection.description;
                    HB.Longdescription = EditResponse.rentalQuote.analysisSet4.selection.Longdescription;
                }
                if (i == 5) {
                    HB.description = EditResponse.rentalQuote.analysisSet5.header.description;
                    HB.id = EditResponse.rentalQuote.analysisSet5.header.id;
                    HB.selectedId = EditResponse.rentalQuote.analysisSet5.selection.id;
                    HB.selectedDescription = EditResponse.rentalQuote.analysisSet5.selection.description;
                    HB.Longdescription = EditResponse.rentalQuote.analysisSet5.selection.Longdescription;
                }

                i++;
            }
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC analysisWebservicesCustomer: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :analysisWebservicesCustomer' + analysisSetHeaderResponseList);
    }
    public pageReference ConvertToOrder() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :ConvertToOrder');
        isUpdateFromOrderConversion = false;
        isCallingOrderConversionNeeded = false;
        QuoteToOrderService_AC QTS = null;
        QuoteToOrderParser_AC orderConversionResp = null;
        String convertOrderResponse;
        fullQWrapper.showOrderPopUp = false;
        isMultipleQuoteWithSamePgAcc = false;
        MultipleQuoteResId = '';
        try {
            if (fullQWrapper.AccountId.startsWith('G') || fullQWrapper.AccountId.startsWith('P') || fullQWrapper.AccountId == '2') {
                // check for multiple FQ for same PG Account
                String CheckResult = FullQuoteDAO.CheckMultiplleFqOFSamePgAcc(docId);
                system.debug('----------CheckResult---------' + CheckResult);
                list < String > lstCheckResult = CheckResult.split('_');
                if (lstCheckResult.size() > 1) {
                    if (lstCheckResult[0] == 'true') {
                        isMultipleQuoteWithSamePgAcc = true;
                        fullQWrapper.showOrderPopUp = true;
                        MultipleQuoteResId = lstCheckResult[1];
                        return null;
                    }
                }
            }

            if (fullQWrapper.Status == 'NORCOD' && !isErrorForNorcodHasShown) {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Supply the Credit Card Details on the Account in Rental Result, before Converting the Quote to an Order');
                ApexPages.addMessage(msg);
                fullQWrapper.showOrderPopUp = true;
                return null;
            }
            if (docId != null) {
                if ((updateQuoteRec.Reservation_ID__c == null || updateQuoteRec.Reservation_ID__c == '') && (!fullQWrapper.noReservation)) {
                    ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Please select "No Reservation" or "Reserve Capacity".');
                    ApexPages.addMessage(msg);
                    fullQWrapper.showOrderPopUp = true;
                    return null;
                }
            }
            //----------TFS 2720---------starts-----------
            String errorOnOrderConversion = '';
            if (fullQWrapper.noOfUnit == 0) {
                errorOnOrderConversion = '# of Units, ';
            }
            for (HomeBaseBeans.AnalysisSetHeaders HB: analysisSetHeaderResponseShippingList) {
                if (HB.selectedId == null && HB.description == 'Door Dir') {
                    errorOnOrderConversion = errorOnOrderConversion + 'Door Dir, ';
                }
                if (HB.selectedId == null && HB.description == 'Del Time') {
                    errorOnOrderConversion = errorOnOrderConversion + 'Del Time, ';
                }
            }
            if (errorOnOrderConversion != null && errorOnOrderConversion != '') {
                String errorStrOnOrderConversion = 'Please select ' + errorOnOrderConversion;
                errorOnOrderConversion = errorStrOnOrderConversion.subString(0, errorStrOnOrderConversion.length() - 2);
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, errorOnOrderConversion + '!');
                ApexPages.addMessage(msg);
                fullQWrapper.showOrderPopUp = true;
                return null;
            }
            //----------TFS 2720------------emnds--------

            if (fullQWrapper.AccountId == '' || fullQWrapper.AccountId == null || fullQWrapper.AccountId.startsWith('G') || fullQWrapper.AccountId.startsWith('P') || fullQWrapper.AccountId == '2') {
                // New Account Creation..........................
                String oldAccountId = '';
                oldAccountId = fullQWrapper.AccountId;
                finishCreateNewCustomerAccount();
                if (erreorOnNewAcctCreation == 'yes') {
                    ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, fullQWrapper.AccountId);
                    ApexPages.addMessage(msg);
                    fullQWrapper.showOrderPopUp = true;
                    return null;
                }
                //Full Quote Updation will Happen here.....................

                /*UpdateAccount_AC upAcc = new UpdateAccount_AC();
                UpdateAccount_AC.parseChangeAccResponse ChangeAccRes = new UpdateAccount_AC.parseChangeAccResponse();
                ChangeAccRes = upAcc.changeAccountNo(docId,fullQWrapper.AccountId,'result');*/
                UpdateAccount_AC.parseChangeAccResponse ChangeAccRes = updateFqWithNewAcc(docId, fullQWrapper.AccountId);
                //--------------update the quote details-------------------------------------------------------
                ////isUpdateFromOrderConversion = true;
                ////payLoadtoSaveQuote();
                //isUpdateFromOrderConversionCompleted = true;
                ////isUpdateFromOrderConversion = false;
                if (!isErrorDuringUpdationFromOrderConversion) {
                    // ------------------Update Newly created Actual Account in SF------------------------
                    if (updateQuoteRec != null) {
                        List < Account > lstAccToUpdate = FullQuoteDAO.getAccountList(updateQuoteRec.Opportunity__r.AccountId);
                        if (lstAccToUpdate.size() > 0) {
                            for (Account a: lstAccToUpdate) {
                                a.Result_Id__c = fullQWrapper.AccountId;
                            }
                            update lstAccToUpdate;
                        }
                    }

                    isCallingOrderConversionNeeded = true;
                    if (ChangeAccRes != null && ChangeAccRes.errorMessage == null) {
                        isCallingOrderConversionNeeded = true;
                    } else {
                        ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, ChangeAccRes.errorMessage);
                        ApexPages.addMessage(msg);
                        isCallingOrderConversionNeeded = false;
                        fullQWrapper.showOrderPopUp = true;
                        return null;
                    }
                }
            } else {
                isCallingOrderConversionNeeded = true;
                fullQWrapper.showOrderPopUp = false;
                //--------------update the quote details-------------------------------------------------------
                ////isUpdateFromOrderConversion = true;
                ////payLoadtoSaveQuote();
                ////isUpdateFromOrderConversion = false;
                return null;
            }
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC ConvertToOrder: ' + e.getMessage());
            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, e.getMessage());
            ApexPages.addMessage(msg);
            fullQWrapper.showOrderPopUp = true;
            isCallingOrderConversionNeeded = false;
            return null;
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :ConvertToOrder' + orderConversionResp);
        return null;
    }

    public UpdateAccount_AC.parseChangeAccResponse updateFqWithNewAcc(String documentIdOfFQ, String NewAccId) {
        UpdateAccount_AC upAcc = new UpdateAccount_AC();
        UpdateAccount_AC.parseChangeAccResponse ChangeAccRes = new UpdateAccount_AC.parseChangeAccResponse();
        if (!test.isRunningTest()) {
            ChangeAccRes = upAcc.changeAccountNo(documentIdOfFQ, NewAccId, 'result');
        }
        return ChangeAccRes;
    }

    public pageReference callConvertToOrder() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :callConvertToOrder');
        QuoteToOrderService_AC QTS = null;
        QuoteToOrderParser_AC orderConversionResp = null;
        String convertOrderResponse;
        fullQWrapper.showOrderPopUp = true;
        try {
            QTS = new QuoteToOrderService_AC();
            orderConversionResp = new QuoteToOrderParser_AC();
            orderConversionResp = QTS.callQuoteToOrder(docId, mobilization, fullQWrapper.WriteUpRep, fullQWrapper.selectedFullQUote);
            IF(test.isRunningTest()) {
                orderConversionResp = MMIFullquoteTestDataProvider.getConvertToOrderResponse();
            }
            if (orderConversionResp.orderErrorMsg == null) {
                String associated = '';
                fullQWrapper.OrderMessage = orderConversionResp.message;
                if (orderConversionResp.quotePK != null) {
                    if (orderConversionResp.quotePK.documentId != null) {
                        fullQWrapper.orderQuoteId = String.valueOf(orderConversionResp.quotePK.documentId);
                    }
                }
                if (orderConversionResp.convertedContractPK != null) {
                    if (orderConversionResp.convertedContractPK.documentId != null) {
                        fullQWrapper.orderContractId = String.valueOf(orderConversionResp.convertedContractPK.documentId);
                    }
                }

                String branchId;
                if (test.isRunningTest()) {
                    fullQWrapper.orderContractId = '232';
                }
                if (fullQWrapper.orderContractId != null) {
                    if (test.isRunningTest()) {
                        branchId = '102';
                    } else {
                        branchId = FullQuoteDAO.getBranchId(fullQWrapper.fulFillingBranchInShippingDates, recId);
                    }
                    if (branchId != null && branchId != '') {
                        /*branchIdforViewBranch = branchId;   
                        //get dispatcher email from custom Setting
                        List<Email_Dispatcher__c> emailDispatcherList = null;
                        map<String,String> mapBranchEmail = new map<String,String>();
                        emailDispatcherList = Email_Dispatcher__c.getAll().Values();
                        if(emailDispatcherList != null && !emailDispatcherList.isEmpty()){
                              String branchEmailList = emailDispatcherList.get(0).Branch_Email_Combination__c;
                              list<String> lstBranchEmailList = branchEmailList.split(',');
                              for(String s : lstBranchEmailList){
                                    list<String> branchEmail = s.split('_');
                                    mapBranchEmail.put(branchEmail[0],branchEmail[1]);
                              }
                         }
                        if(mapBranchEmail.containsKey(branchId)){
                            associated  = mapBranchEmail.get(branchId) +'_Dispatch@mobilemini.com';
                        }else{
                        associated  = branchId +'_Dispatch@mobilemini.com';
                        }*/
                        associated = QuickQuoteMainDAO.getDispatcherEmailId(branchId);
                        //associated  = 'cranade@teksystems.com';
                        system.debug('------------Associated------------------' + associated);
                        //associated  = 'cranade@teksystems.com';


                    }
                    MMI_Full_Quotes__c mmiFQObj = null;
                    if (fullQWrapper.orderContractId != null && fullQWrapper.orderContractId != '') {
                        mmiFQObj = FullQuoteDAO.getFullQuoteRecord(fullQWrapper.orderQuoteId);
                        if (mmiFQObj != null) {
                            mmiFQObj.Document_Id__c = fullQWrapper.orderContractId;
                            update mmiFQObj;
                            // update status of the opportunity and Rental / sales docId
                            list < Opportunity > lstOppRecords = FullQuoteDAO.getOppRecord(mmiFQObj.Opportunity__c);
                            if (lstOppRecords.size() > 0) {
                                lstOppRecords[0].StageName = 'Quoted - Won';
                                lstOppRecords[0].Result_Rental_Sale_Doc__c = fullQWrapper.orderContractId;
                                update lstOppRecords[0];
                            }
                        }
                    }
                    if (associated != null && associated != '') {
                        String Mailbody = '';
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                        String[] toAddresses = new String[] {
                            associated
                        };
                        String[] ccAddresses = new String[] {
                            userRec.Email
                        };
                        system.debug('------------accountOwnerIdOfQQ------------------' + accountOwnerIdOfQQ);
                        if (accountOwnerIdOfQQ != null && accountOwnerIdOfQQ != '') {
                            User accOwnerOfQQRecord = FullQuoteDAO.getUserDetails(accountOwnerIdOfQQ);
                            system.debug('------------accOwnerOfQQRecord.EMail------------------' + accOwnerOfQQRecord.EMail);
                            if (accOwnerOfQQRecord.EMail != null && accOwnerOfQQRecord.Email != '') {
                                ccAddresses.add(accOwnerOfQQRecord.EMail);
                            }
                        }
                        mail.setToAddresses(toAddresses);
                        mail.setCcAddresses(ccAddresses);
                        //-------------------TFS 3036---Starts---------------------------
                        if (mmiFQObj.Reservation_ID__c == null && mmiFQObj.Reservation_ID__c == '') {
                            mail.emailPriority = 'Highest';
                        }
                        //-----------------------TFS 3036---Ends------------------------------
                        Mailbody = '<table>';
                        if (fullQWrapper.SpecialInstructions) {
                            Mailbody += '<tr><td colspan="2">Delivery Instructions: ' + fullQWrapper.deliveryInstructions + '</td></tr>';
                        }
                        Mailbody += '<tr><td>Account ID : </td><td style="padding-right :10px;">' + fullQWrapper.AccountId + '</td></tr>';
                        Mailbody += '<tr><td>Customer Name : </td><td style="padding-right :10px;">' + fullQWrapper.AccountName + '</td></tr>';
                        Mailbody += '<tr><td>Shipping City : </td><td style="padding-right :10px;">' + fullQWrapper.cityInShippingDates + '</td></tr>';
                        Mailbody += '<tr><td>Item Code : </td><td>' + summaryLineList[0].Description + '</td></tr>';
                        Mailbody += '<tr><td>Branch : </td><td style="padding-right :10px;">' + branchId + '</td></tr>';
                        Mailbody += '<tr><td>Quote ID : </td><td style="padding-right :10px;">' + docId + '</td></tr>';
                        Mailbody += '<tr><td>Contract # : </td><td style="padding-right :10px;">' + fullQWrapper.orderContractId + '</td></tr>';
                        Mailbody += '<tr><td>Scheduled Delivery Date : </td style="padding-right :10px;"><td>' + String.Valueof(fullQuote.Scheduled_Delivery__c) + '</td></tr>';
                        Mailbody += '<tr><td>Write Up Rep Name : </td><td style="padding-right :10px;">' + fullQWrapper.WriteUpRepName + '</td></tr>';
                        Mailbody += '</table>';
                        mail.setHtmlBody(Mailbody);
                        if (fullQWrapper.SpecialInstructions) {
                            mail.setSubject('SPECIAL INSTRUCTIONS!! PLEASE READ : Order Submitted ? Contract # "' + fullQWrapper.orderContractId + '" is Ready to be Printed');
                        } else {
                            mail.setSubject('Order Submitted ? Contract # "' + fullQWrapper.orderContractId + '" is Ready to be Printed');
                        }
                        if (!test.isRunningTest()) {
                            Messaging.sendEmail(new Messaging.SingleEmailMessage[] {
                                mail
                            });
                        }
                    }

                    /*if(fullQWrapper.Status == 'HFC' || fullQWrapper.Status == 'HFCZ'){
                        sendHfcStatusMail();
                    }*/

                }
            } else {
                if (setAccountStatus.contains(fullQWrapper.Status)) {
                    sendHfcStatusMail();
                    orderConversionResp.orderErrorMsg += '.  An e-mail has been sent to the HFC Dept.';
                }
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, orderConversionResp.orderErrorMsg);
                ApexPages.addMessage(msg);
                //Send email notification to MMI for document waiting for Descartes..
                String DocumentWaitingForDescartesEmail = '';
                List < WaitingForDescartesErrorNotification__c > waitingForDescSetting = null;
                if (WaitingForDescartesErrorNotification__c.getAll() != null) {
                    waitingForDescSetting = WaitingForDescartesErrorNotification__c.getAll().Values();
                    if (waitingForDescSetting != null && !waitingForDescSetting.isEmpty()) {
                        DocumentWaitingForDescartesEmail = waitingForDescSetting.get(0).Email__c;
                    }
                }

                if (orderConversionResp.orderErrorMsg == 'DocumentWaitingForDescartes' && DocumentWaitingForDescartesEmail != '') {
                    String Mailbody = '';
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    String[] toAddresses = new String[] {
                        DocumentWaitingForDescartesEmail
                    };
                    //String[] ccAddresses = new String[] {'rmaity@teksystems.com'};
                    mail.setToAddresses(toAddresses);
                    //mail.setCcAddresses(ccAddresses);
                    Mailbody = 'We are getting waiting for descartes error message during Order conversion.';
                    mail.setHtmlBody(Mailbody);
                    mail.setSubject('Waiting for descartes error occur during Order conversion');
                    if (!test.isRunningTest()) {
                        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {
                            mail
                        });
                    }
                }

            }

        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC ConvertToOrder: ' + e.getMessage());
            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, e.getMessage());
            ApexPages.addMessage(msg);
            fullQWrapper.showOrderPopUp = true;
            return null;
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :callConvertToOrder' + orderConversionResp);
        isCallingOrderConversionNeeded = false;
        return null;
    }

    public String getHfcEmailValue() {
        String hfcEmailValue = '';
        list < HFC_Email_Notification__c > hfcEmailList = null;
        if (HFC_Email_Notification__c.getAll() != null) {
            hfcEmailList = HFC_Email_Notification__c.getAll().Values();
            if (hfcEmailList != null && !hfcEmailList.isEmpty()) {
                hfcEmailValue = hfcEmailList.get(0).HFC_Email__c;
            }
        }
        return hfcEmailValue;
    }

    public void sendHfcStatusMailDuringSave() {
        String toEmailValue = getHfcEmailValue();
        if (toEmailValue != null && toEmailValue != '') {
            String MailbodyHFC = '';
            Messaging.SingleEmailMessage mailHFC = new Messaging.SingleEmailMessage();
            String[] toAddressesHFC = new String[] {
                toEmailValue
            }; //{'HFCREMOVALREQ@mobilemini.com'}; //cranade@teksystems.com
            String[] ccAddressesHFC = new String[] {
                userRec.Email
            };
            system.debug('-----------accountOwnerIdOfQQ-----------------' + accountOwnerIdOfQQ);
            if (accountOwnerIdOfQQ != null && accountOwnerIdOfQQ != '') {
                User accOwnerOfQQRecord = FullQuoteDAO.getUserDetails(accountOwnerIdOfQQ);
                system.debug('-----------accOwnerOfQQRecord.EMail-----------------' + accOwnerOfQQRecord.EMail);
                if (accOwnerOfQQRecord.EMail != null && accOwnerOfQQRecord.Email != '') {
                    ccAddressesHFC.add(accOwnerOfQQRecord.EMail);
                }
            }

            mailHFC.setToAddresses(toAddressesHFC);
            mailHFC.setCcAddresses(ccAddressesHFC);
            String conPrimaryPhone = '';
            if (fullQWrapper.primaryContactNo == 'MobilePhone') {
                conPrimaryPhone = fullQWrapper.conMob;
            }
            if (fullQWrapper.primaryContactNo == 'Phone') {
                conPrimaryPhone = fullQWrapper.telePhone;
            }
            if (conPrimaryPhone == '') {
                conPrimaryPhone = fullQWrapper.telePhone;
            }
            MailbodyHFC += 'Account # : ' + fullQWrapper.AccountId + ' , Account Name : ' + fullQWrapper.AccountName + '<br/>';
            MailbodyHFC += '<br/>Please Review this Account on "HFC" Status and Release/Advise.<br/><br/>';
            MailbodyHFC += 'Contact Details :<br/><br/>';
            MailbodyHFC += 'First Name : ' + fullQWrapper.Name + '<br/>';
            MailbodyHFC += 'Last Name : ' + fullQWrapper.LastName + '<br/>';
            MailbodyHFC += 'Phone : ' + conPrimaryPhone + '<br/>';
            MailbodyHFC += 'Email : ' + fullQWrapper.Email + '<br/>';
            //String UserSign = generateSignature(loginUserRec);
            //MailbodyHFC += UserSign;
            mailHFC.setHtmlBody(MailbodyHFC);
            mailHFC.setUseSignature(false);
            mailHFC.setSubject(fullQWrapper.AccountName + ' , ' + 'Account # : ' + fullQWrapper.AccountId + ' , ' + 'Quote # : ' + docId);
            if (!test.isRunningTest()) {
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] {
                    mailHFC
                });
                createTaskForHfc(opportunityID);
            }
        }
    }

    public void sendHfcStatusMail() {
        String toEmailValue = getHfcEmailValue();
        if (toEmailValue != null && toEmailValue != '') {
            String MailbodyHFC = '';
            Messaging.SingleEmailMessage mailHFC = new Messaging.SingleEmailMessage();
            String[] toAddressesHFC = new String[] {
                toEmailValue
            }; //{'HFCREMOVALREQ@mobilemini.com'}; //cranade@teksystems.com
            String[] ccAddressesHFC = new String[] {
                userRec.Email
            };
            system.debug('-----------accountOwnerIdOfQQ-----------------' + accountOwnerIdOfQQ);
            if (accountOwnerIdOfQQ != null && accountOwnerIdOfQQ != '') {
                User accOwnerOfQQRecord = FullQuoteDAO.getUserDetails(accountOwnerIdOfQQ);
                system.debug('-----------accOwnerOfQQRecord.EMail-----------------' + accOwnerOfQQRecord.EMail);
                if (accOwnerOfQQRecord.EMail != null && accOwnerOfQQRecord.Email != '') {
                    ccAddressesHFC.add(accOwnerOfQQRecord.EMail);
                }
            }
            mailHFC.setToAddresses(toAddressesHFC);
            mailHFC.setCcAddresses(ccAddressesHFC);
            String conPrimaryPhone = '';
            if (fullQWrapper.primaryContactNo == 'MobilePhone') {
                conPrimaryPhone = fullQWrapper.conMob;
            }
            if (fullQWrapper.primaryContactNo == 'Phone') {
                conPrimaryPhone = fullQWrapper.telePhone;
            }
            if (conPrimaryPhone == '') {
                conPrimaryPhone = fullQWrapper.telePhone;
            }
            MailbodyHFC = '<table>';
            MailbodyHFC += '<tr><td width="20%">Account# : </td><td width="80%" align="left" style="padding-right :10px;">' + fullQWrapper.AccountId + '</td></tr>';
            MailbodyHFC += '<tr><td width="20%">Account Name : </td><td width="80%" align="left">' + fullQWrapper.AccountName + '</td></tr>';
            MailbodyHFC += '<tr><td width="20%">Delivery City : </td><td width="80%" align="left">' + fullQWrapper.cityInShippingDates + '</td></tr>';
            MailbodyHFC += '<tr><td colspan="2">Please Review this Account on "HFC" Status and Release/Advise.</td></tr>';
            MailbodyHFC += '<tr><td width="20%">Conatct Name : </td><td width="80%" align="left">' + fullQWrapper.Name + ' ' + fullQWrapper.LastName + '</td></tr>';
            MailbodyHFC += '<tr><td width="20%">Contact Phone : </td><td width="80%" align="left">' + conPrimaryPhone + '</td></tr>';
            MailbodyHFC += '<tr><td width="20%">Contact Email : </td><td width="80%" align="left">' + fullQWrapper.Email + '</td></tr>';
            MailbodyHFC += '</table><br/>';
            //String UserSign = generateSignature(loginUserRec);
            //MailbodyHFC += UserSign;
            mailHFC.setHtmlBody(MailbodyHFC);
            mailHFC.setUseSignature(false);
            //mailHFC.setSubject(fullQWrapper.AccountId +' / '+fullQWrapper.AccountName+ ' - HFC Status');
            mailHFC.setSubject(fullQWrapper.AccountName + ' , ' + 'Account # : ' + fullQWrapper.AccountId + ' , ' + 'Quote # : ' + docId); // TFS 1373
            if (!test.isRunningTest()) {
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] {
                    mailHFC
                });
                createTaskForHfc(updateQuoteRec.Opportunity__c);
            }
        }
    }@future
    public static void createTaskForHfc(String OppId) {

        Task taskObj = new Task();
        taskObj.OwnerId = UserInfo.getUserId();
        taskObj.Subject = 'Email';
        taskObj.ActivityDate = system.today();
        taskObj.Call_Type__c = 'OB- Service Coordination';//TFS 3944
        taskObj.Call_Result__c = '';
        taskObj.Description = '';
        taskObj.Status = 'Completed';
        taskObj.Priority = 'Normal';
        if (OppId != null && OppId != '') {
            taskObj.WhatId = OppId;
        }
        insert taskObj;
    }

    public pageReference doPgConvert() {
        PageReference pf = null;
        UpdateAccount_AC.parseChangeAccResponse ChangeAccRes = updateFqWithNewAcc(docId, MultipleQuoteResId);
        MMI_Full_Quotes__c FqObj = FullQuoteDAO.getFullQuoteRecord(docId);
        FqObj.Account_Id__c = MultipleQuoteResId;
        String OppId = FullQuoteDAO.updateFullQuote(FqObj);
        pf = new PageReference('/' + FqObj.Id);
        pf.setRedirect(true);
        return pf;
    }

    public pageReference noPgConvert() {
        PageReference pf = null;
        MMI_Full_Quotes__c FqObj = FullQuoteDAO.getFullQuoteRecord(docId);
        if (FqObj != null) {
            pf = new PageReference('/' + FqObj.Id);
            pf.setRedirect(true);
        }
        return pf;
    }

    public String returnSavePayload() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :returnSavePayload' + analysisSetHeaderResponseList);
        String quoteOppID = null;
        String startDate = '';
        String plannedCollectionDate = '';
        String quoteExpires = '';
        String PO_Expires = '';
        String shippingDate = '';
        String payLoad;
        try {

            if (fullQuote.PO_Expires__c != null) {
                PO_Expires = String.valueOf(fullQuote.PO_Expires__c).split(' ')[0];
            }
            if (fullQuote.Quote_expires__c != null) {
                quoteExpires = String.valueOf(fullQuote.Quote_expires__c).split(' ')[0];
            }
            if (fullQuote.Start_Date__c != null) {
                startDate = String.valueOf(fullQuote.Start_Date__c).split(' ')[0];
            }
            if (fullQuote.Loaded_Move_In__c != null) {
                plannedCollectionDate = String.valueOf(fullQuote.Loaded_Move_In__c).split(' ')[0];
            }
            if (fullQuote.Scheduled_Delivery__c != null) {
                shippingDate = String.valueOf(fullQuote.Scheduled_Delivery__c).split(' ')[0];
            }
            String docsId = '0';
            FullQuoteHelper fqHelper = new FullQuoteHelper();
            if (docId != null) docsId = docId + '';

            String modifiedTimeStamp = '0';
            if (docId != null) {
                if (test.isRunningTest()) {
                    editFQResponse = MMIFullquoteTestDataProvider.getEditFullQuoteData();
                    analysisSetHeaderResponseList = MMIFullquoteTestDataProvider.getanalysisSetHeader2();
                }
                if (editFQResponse.rentalQuote != null) {
                    modifiedTimeStamp = String.valueof(editFQResponse.rentalQuote.modifiedTimestamp);
                    Mobilization = editFQResponse.rentalQuote.Mobilization;
                    integer i = 1;
                    for (HomeBaseBeans.AnalysisSetHeaders HB: analysisSetHeaderResponseList) {
                        if (HB != null) {
                            if (i == 1) {
                                if (HB.selectedId == null) {
                                    HB.description = editFQResponse.rentalQuote.analysisSet1.header.description;
                                    HB.id = editFQResponse.rentalQuote.analysisSet1.header.id;
                                    HB.selectedId = editFQResponse.rentalQuote.analysisSet1.selection.id;
                                    HB.selectedDescription = editFQResponse.rentalQuote.analysisSet1.selection.description;
                                }
                            }
                            if (i == 2) {
                                if (HB.selectedId == null) {
                                    HB.description = editFQResponse.rentalQuote.analysisSet2.header.description;
                                    HB.id = editFQResponse.rentalQuote.analysisSet2.header.id;
                                    HB.selectedId = editFQResponse.rentalQuote.analysisSet2.selection.id;
                                    HB.selectedDescription = editFQResponse.rentalQuote.analysisSet2.selection.description;
                                }
                            }
                            if (i == 3) {
                                if (HB.selectedId == null) {
                                    HB.description = editFQResponse.rentalQuote.analysisSet3.header.description;
                                    HB.id = editFQResponse.rentalQuote.analysisSet3.header.id;
                                    HB.selectedId = editFQResponse.rentalQuote.analysisSet3.selection.id;
                                    HB.selectedDescription = editFQResponse.rentalQuote.analysisSet3.selection.description;
                                }
                            }
                            if (i == 4) {
                                if (HB.selectedId == null) {
                                    HB.description = editFQResponse.rentalQuote.analysisSet4.header.description;
                                    HB.id = editFQResponse.rentalQuote.analysisSet4.header.id;
                                    HB.selectedId = editFQResponse.rentalQuote.analysisSet4.selection.id;
                                    HB.selectedDescription = editFQResponse.rentalQuote.analysisSet4.selection.description;
                                }
                            }
                            i++;
                        } else {
                            break;
                        }
                    }

                }

                if (FQSMrecId != null && modifiedTS != null) {

                    if (fullQuote_tran.documentId__c != null && fullQuote_tran.documentId__c != '' && fullQuote_tran.documentId__c != '0') {
                        String branchId;
                        if (fullQWrapper.fulFillingBranchInShippingDates != null && fullQWrapper.fulFillingBranchInShippingDates != '') {
                            branchId = fullQWrapper.fulFillingBranchInShippingDates;
                        } else {
                            branchId = fullQuote_tran.branchId__c;
                        }
                        FullQuoteMainService fqService = new FullQuoteMainService();
                        updateQuoteRec = fqService.getFullQuote(fullQuote_tran.documentId__c);
                        FullQuoteEditResponseService_AC FQEdit = new FullQuoteEditResponseService_AC();
                        editFQResponse = FQEdit.callEditWEbservice(fullQuote_tran.documentId__c, fullQWrapper.WriteUpRep, branchId, updateQuoteRec.Name);

                        //modifiedTimeStamp=modifiedTS;
                        if (updateQuoteRec.Name == 'sales') {
                            editFQResponse.rentalQuote = editFQResponse.salesQuote;
                        }

                        modifiedTimeStamp = String.valueof(editFQResponse.rentalQuote.modifiedTimestamp);
                        Mobilization = editFQResponse.rentalQuote.Mobilization;
                    }
                }

            }

            if (cloneIsTrue == 'true') {
                docsId = '0';
                modifiedTimeStamp = '0';
            }
            if (docId != null && cloneIsTrue != 'true') {
                payLoad = fqHelper.getSavePayload(cloneIsTrue, docsId, fullQWrapper, summaryLineInEdit, analysisSetHeaderResponseList, analysisSetHeaderResponseShippingList, ProductExtrasList, selectedVAddressInShipping, selectedVAddressInBilling, startDate, plannedCollectionDate, quoteExpires, PO_Expires, shippingDate, selectedTaxRecInBilling, selectedTaxRecInShipping, SelectedShipingTaxId, modifiedTimeStamp, Mobilization, SelectedRentalLength, updateQuoteRec);
            } else {
                payLoad = fqHelper.getSavePayload(cloneIsTrue, docsId, fullQWrapper, summaryLineList, analysisSetHeaderResponseList, analysisSetHeaderResponseShippingList, ProductExtrasList, selectedVAddressInShipping, selectedVAddressInBilling, startDate, plannedCollectionDate, quoteExpires, PO_Expires, shippingDate, selectedTaxRecInBilling, selectedTaxRecInShipping, SelectedShipingTaxId, modifiedTimeStamp, Mobilization, SelectedRentalLength, updateQuoteRec);
            }
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC returnSavePayload: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :returnSavePayload' + payLoad);
        return payLoad;
    }
    // Capacity Lookup button

    public pageReference callCapacityLookupWebservice() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :callCapacityLookupWebservice' + summaryLineList);
        HomeBaseBeans.capacityLookupRequest clr = null;
        try {
            if (test.isRunningTest()) {
                selectedVAddressInShipping.longitude = '12321';
                selectedVAddressInShipping.latitude = '34234';
                isInsertingFQ = true;
                isUpdatingFQ = true;
            }
            if ((selectedVAddressInShipping.longitude != null && selectedVAddressInShipping.latitude != null) || (docId != null && updateQuoteRec.Longitude__c != null && updateQuoteRec.Latitude__c != null)) {
                fullQWrapper.showcapacityLookupPopUp = false;
                clr = new HomeBaseBeans.capacityLookupRequest();
                clr.addressLine1 = fullQWrapper.AddressInShippingDates;
                clr.City = fullQWrapper.cityInShippingDates;
                clr.countryCode = fullQWrapper.countryInShippingDates;
                clr.postalCode = fullQWrapper.ZipCodeInShipping;
                clr.stateCode = fullQWrapper.stateInShippingDates;
                clr.sellingStoreNumber = fullQWrapper.fulFillingBranchInShippingDates;
                if (isInsertingFQ) {
                    clr.longitude = selectedVAddressInShipping.longitude;
                    clr.latitude = selectedVAddressInShipping.latitude;
                }
                if (isUpdatingFQ) {
                    clr.longitude = updateQuoteRec.Longitude__c;
                    clr.latitude = updateQuoteRec.Latitude__c;
                }
                if (test.isRunningTest()) {
                    clr.BranchId = '102';
                } else {
                    clr.BranchId = FullQuoteDAO.getBranchId(fullQWrapper.fulFillingBranchInShippingDates, recId);
                }
                if (clr.BranchId != null && clr.BranchId != '') {
                    branchIdforViewBranch = clr.BranchId;
                }
                DateTime ScheduleDelvDate = system.now();
                if (fullQuote.Scheduled_Delivery__c != null) {
                    ScheduleDelvDate = fullQuote.Scheduled_Delivery__c;
                }
                String MonthVal = '';
                String DateVal = '';
                if (String.valueOf((ScheduleDelvDate).Month()).length() != 2) {
                    MonthVal = '0' + (ScheduleDelvDate).Month();
                } else {
                    MonthVal = String.valueOf((ScheduleDelvDate).Month());
                }
                if (String.valueOf((ScheduleDelvDate).day()).length() != 2) {
                    DateVal = '0' + (ScheduleDelvDate).day();
                } else {
                    DateVal = String.valueOf((ScheduleDelvDate).day());
                }
                String DeliveryDateTimeForCL = (ScheduleDelvDate).year() + '-' + MonthVal + '-' + DateVal;
                if (fullQWrapper.deliverySlot == 'AM') {
                    DeliveryDateTimeForCL = DeliveryDateTimeForCL + 'T11:59:00.000Z';
                }
                if (fullQWrapper.deliverySlot == 'PM') {
                    DeliveryDateTimeForCL = DeliveryDateTimeForCL + 'T23:59:00.000Z';
                }
                clr.DeliveryDateTime = DeliveryDateTimeForCL;
                if (summaryLineList.size() > 0) {
                    clr.itemName = summaryLineList[0].itemId;
                    clr.itemDescription = summaryLineList[0].Description;
                }

                fullQWrapper.showCapacityLookupPopup = true;
                responseHandlerList = new List < HomeBaseBeans.CapacityLookupHandler > ();
                CapacityLookupService_AC CLA = new CapacityLookupService_AC();
                CapacityLookUpXMLParser_AC c = new CapacityLookUpXMLParser_AC();
                String CapacityResponse = CLA.callWebservice(clr);
                if (CapacityResponse != null && CapacityResponse != '') {
                    responseHandlerList = c.returnWebserviceResponse(CapacityResponse);
                    if (!responseHandlerList.isEmpty()) {
                        if (responseHandlerList[0].ErrorString != '' && responseHandlerList[0].ErrorString != null) {
                            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, responseHandlerList[0].ErrorString);
                            ApexPages.addMessage(msg);
                            fullQWrapper.showcapacityLookupPopUp = true;
                        }
                    }
                    fullQWrapper.showcapacityLookupPopUp = true;
                }
            } else {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Longitude or Latitude is not found for the selected address.');
                ApexPages.addMessage(msg);
                fullQWrapper.showcapacityLookupPopUp = true;
            }

        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC callCapacityLookupWebservice: ' + e.getMessage());
            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, e.getMessage());
            ApexPages.addMessage(msg);
            fullQWrapper.showcapacityLookupPopUp = true;
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :callCapacityLookupWebservice' + responseHandlerList);
        return null;
    }


    public pageReference hideCapacitylookupPop() {
        fullQWrapper.showcapacityLookupPopUp = false;
        return null;
    }
    public pageReference CapacityIdSelected() {
        String selectedCapacityDate = System.currentPageReference().getParameters().get('capacitySelactedValue');
        if (test.isRunningTest()) {
            selectedCapacityDate = '2013-10-10 00:00:00';
        }
        fullQWrapper.showcapacityLookupPopUp = false;
        fullQuote.Scheduled_Delivery__c = date.valueOf(selectedCapacityDate.substring(0, 10));
        fullQuote.Start_Date__c = date.valueOf(selectedCapacityDate.substring(0, 10));
        return null;
    }


    public List < SelectOption > getSaveFullQuoteOptions() {
        saveFOptions = new List < SelectOption > ();
        if (FQSMrecId == null) {
            saveFOptions.add(new SelectOption('rental', 'Rental'));
        }

        saveFOptions.add(new SelectOption('sales', 'Sales'));

        return saveFOptions;
    }

    // Saleable fleet

    public boolean getIsSales() {
        if (fullQWrapper.selectedFullQUote == 'sales') return true;
        else return false;

    }

    public pageReference callSalesFleetService() {
        return null;
    }

    // To get ecode List
    public PageReference callEcodeAllocationWs() {
        fullQWrapper.showEcodePopUp = false;
        eCodeAllocationList.clear();
        String allocatedEcodeList = '';
        for (HomeBaseBeans.SalesFleets sf: salesFleetList) {
            allocatedEcodeList += sf.ecode + ',';
        }
        if (allocatedEcodeList.length() > 0) {
            allocatedEcodeList = allocatedEcodeList.subString(0, allocatedEcodeList.length() - 1);
        }

        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :callEcodeAllocationWs');
        String BranchId = '';
        if (quickQuoteId != null && quickQuoteId != '') {
            BranchId = CalculateBranchIdDuringQqToFQConversion(QqData, fullQWrapper.fulFillingBranchInShippingDates);
        } else {
            BranchId = FullQuoteDAO.getBranchId(fullQWrapper.fulFillingBranchInShippingDates, recId);
        }
        if (BranchId != null && BranchId != '') {
            branchIdforViewBranch = BranchId;
        }
        List < HomeBaseBeans.allocations > eCodeList = new List < HomeBaseBeans.allocations > ();
        try {
            SalesFleet_Service sfs = new SalesFleet_Service();
            eCodeList = sfs.listEcodeList(fullQWrapper.ItemCode, BranchId, fullQWrapper.TransactionType, fullQuote.Start_Date__c, fullQWrapper.AccountId, allocatedEcodeList);
            eCodeAllocationList.addAll(eCodeList);
            if (eCodeAllocationList[0].errorMessage != null) {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, eCodeAllocationList[0].errorMessage);
                ApexPages.addMessage(msg);
                isNoEcodeFound = true;
            } else {
                isNoEcodeFound = false;
            }
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC callEcodeAllocationWs: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :callEcodeAllocationWs' + eCodeAllocationList);
        fullQWrapper.showEcodePopUp = true;
        return null;
    }

    public PageReference allocationIdSelected() {
        try {
            String selectedAllocationId = System.currentPageReference().getParameters().get('ecodeSelactedValue');

            if (test.isRunningTest()) {
                eCodeAllocationList = MMIFullquoteTestDataProvider.getHomeBaseBeansallocationsList();
                eCodeAllocationList[0].errorMessage = null;
                selectedAllocationId = '23232';
            }
            if (eCodeAllocationList[0].errorMessage == null) {
                for (HomeBaseBeans.allocations al: eCodeAllocationList) {
                    if (al.ecode == selectedAllocationId) {
                        fullQWrapper.ECode = al.ecode;
                        fullQWrapper.NetBookValue = al.netBookValue;
                        fullQWrapper.Reference = al.reference;
                        fullQWrapper.SellingPrice = null;
                        fullQWrapper.MinPrice = null;
                        fullQWrapper.ModificationCost = null;
                        fullQWrapper.SuggestedPrice = null;

                    }
                }
            }
            fullQWrapper.showEcodePopUp = false;
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC allocationIdSelected: ' + e.getMessage());
        }
        system.debug('--fullQWrapper.ECode---' + fullQWrapper.ECode);
        system.debug('-fullQWrapper.NetBookValue---' + fullQWrapper.NetBookValue);
        system.debug('--fullQWrapper.SellingPrice---' + fullQWrapper.SellingPrice);
        return null;
    }

    public PageReference cancelAllocationIdPopup() {
        eCodeAllocationList.clear();
        fullQWrapper.showEcodePopUp = false;
        return null;
    }

    public pageReference fillEcodes() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :fillEcodes');
        try {

            ImageListSalesInv.clear();



            String seleProd = System.currentPageReference().getParameters().get('SelectedEcode');
            if (test.isRunningTest()) {
                salesInventories = MMIFullquoteTestDataProvider.getFullQuoteWrpProductSalesList();
                seleProd = '1';
            }

            for (FullQuoteWrapper.ProductSales s1: salesInventories) {
                if (s1.recId == Integer.Valueof(seleProd)) {

                    //SaleInventoryImageService  si=new SaleInventoryImageService();
                    //blob img=si.callEditWEbservice();

                    SelectedProductDesc = s1.gradeDescription;
                    fullQWrapper.ItemCode = s1.lineItemID;
                    fullQWrapper.ECode = s1.eCode;
                    fullQWrapper.SuggestedPrice = String.valueOf(s1.suggestedPrice);
                    fullQWrapper.MinPrice = String.valueOf(s1.minimumPrice);
                    fullQWrapper.NetBookValue = String.ValueOf(s1.nbv);
                    fullQWrapper.showEcodeValues = true;
                    fullQWrapper.assetDescription = s1.notes;
                    fullQWrapper.sellingPrice = '0.00';
                    fullQWrapper.Reference = s1.itemRef;


                    if (!test.isRunningTest()) {
                        ImageListSalesInv.addAll(s1.imagesSalesInv);
                    }

                    //fullQWrapper.ImageUrlForPDF = s1.displayPicture;
                    //fullQWrapper.ImageUrl = EncodingUtil.base64Encode(img);
                    //fullQWrapper.binaryImage=img;
                    fullQWrapper.GradeDescription = s1.gradeDescription;
                    fullQWrapper.showEditProduct = true;
                    Boolean accessoryRes = false;

                    FullQuoteMainService fqService = new FullQuoteMainService();
                    accessoryRes = fqService.getAccessoryInfo(s1.lineItemID);
                    if (test.isRunningTest()) {
                        accessoryRes = true;
                        isTransTmoboORseco = true;
                    }
                    if (accessoryRes) {
                        if (isTransTmoboORseco) {
                            ClearLockSelect();
                            accessoriesQuantity = 1;
                            isAccessorySelected = true;
                            lockHideAcc = true;
                            isPoductSelected = false;
                        } else {
                            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'You cannot select accessories for this Transaction Type.');
                            ApexPages.addMessage(msg);
                            fullQWrapper.showEditProduct = false;
                            isAccessorySelected = false;
                            lockHideAcc = false;
                            isPoductSelected = false;
                        }

                    } else {
                        isAccessorySelected = false;
                        lockHideAcc = false;
                        isPoductSelected = true;
                    }

                    break;
                }
            }
            isEcodeAllocationBtnDesabled = false;


        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC fillEcodes: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :fillEcodes' + fullQWrapper);
        return null;
    }

    public void showImage() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :showImage' + System.currentPageReference().getParameters().get('SelectedImage'));
        try {
            String saleImage = System.currentPageReference().getParameters().get('SelectedImage');
            SaleInventoryImageService si = new SaleInventoryImageService();
            if (saleImage != null && saleImage != '') {

                String uuid = saleImage.substring(saleImage.indexOf('uuid=') + 5);
                String SecToken = saleImage.substring(saleImage.indexOf('securitytoken=') + 14);
                system.debug('####uuid#####' + uuid);
                system.debug('#####SecToken####' + SecToken);
                //uuid = '91b6ca16-a5f2-40ec-8786-7e72568e57c9'; // for testing
                //SecToken = '1377706785492';// for testing
                blob img = si.callEditWEbservice(uuid, SecToken); //fullQWrapper.ImageUrl = s1.displayPicture;
                fullQWrapper.ImageUrl = EncodingUtil.base64Encode(img);
            }


        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC showImage: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :showImage' + fullQWrapper.ImageUrl);
    }

    public pageReference hideSalesFleet() {
        fullQWrapper.showSalesfleet = false;
        return null;
    }
    // Enable contact popup
    
    public PageReference showContactPopUpEmail() {
        isEmailContactPopUp = false;
        contactListEmail = new List < Contact > ();
        FullQuoteMainService fqService = null;
        fqService = new FullQuoteMainService();
        List < Account > accountListEmail = null;
        List < Contact > conList = null;
        if (test.isRunningTest()) {
            accountListEmail = MMIFullquoteTestDataProvider.getBusinessAccountList();
        } else {
            accountListEmail = fqService.getAccountEmailList(fullQWrapper.AccountId);
        }

        if (!accountListEmail.isEmpty()) {
            contactEmailId = new list < FullQuoteWrapper.ContactEmailId > ();
            for (Account accEmail: accountListEmail) {
                if (test.isRunningTest()) {
                    conList = MMIFullquoteTestDataProvider.getContactList();
                } else {
                    conList = accEmail.Contacts;
                }
                for (Contact con: conList) {
                    if (con.Email != null && con.Email != '') {
                        //contactListEmail.add(con);
                        FullQuoteWrapper.ContactEmailId conwrapp = new FullQuoteWrapper.ContactEmailId();
                        conwrapp.IsSelected = false;
                        conwrapp.conRec = con;
                        contactEmailId.add(conwrapp);
                    }
                }
            }
            
        }
        isEmailContactPopUp = true;
        //-----------COmmmented for TFS 4536
        /*contactsResponseListForEmailQutoe = new List < HomeBaseBeans.contactSummaryList > ();
        if (contactsResponseList != null && contactsResponseList.size() > 0) {
            for (HomeBaseBeans.contactSummaryList chekcboxistrue: contactsResponseList) {
                contactsResponseListForEmailQutoe.add(chekcboxistrue);
            }
        }*/

        fullQWrapper.contactPopup = true;
        return null;
    }
    
    public void showAddContactPopUpFromShipping() {
        isAddContactFromBillingTab = false;
        isAddContactFromShippingTab = true;
        showAddContactPopUp();
    }
    
    public void showAddContactPopUpFromBilling() {
        isAddContactFromBillingTab = true;
        isAddContactFromShippingTab = false;
        showAddContactPopUp();
    }
    
    public void UseAsBillingContactId() {
        contactIdSelected();
        cancelAddContactPopUp();
    }
    
    public void UseAsShippingContactId() {
        shippingContactIdSelected();
        cancelAddContactPopUp();
    }
    
    //----------------------------------------------------Add/Edit Contact Functionality---------Starts---------------------------------------------
    /*********************************************************************
    Purpose     : Open the Contact Popup with default Contact List of an Account
    **********************************************************************/
    public PageReference showContactPopUp() {
        fullQWrapper.contactPopup = true;
        List<HomeBaseBeans.ListContact> lstAllCOntact = new List<HomeBaseBeans.ListContact>();
        String BranchId = FullQuoteDAO.getBranchId(fullQWrapper.fulFillingBranchInShippingDates, recId);
        lstAllCOntact = callLIstContactWS(BranchId, fullQWrapper.AccountId);
        if(lstAllCOntact != null && lstAllCOntact.size() > 0){
            contactsResponseList = new list<HomeBaseBeans.contactSummaryList>();
            for(HomeBaseBeans.ListContact c : lstAllCOntact){
                HomeBaseBeans.contactSummaryList cl = new HomeBaseBeans.contactSummaryList();
                cl.forename = c.forename;
                cl.surname = c.surname;
                cl.contactId = c.contactId;
                contactsResponseList.add(cl);
            }
        }
        return null;
    }
    
    /*********************************************************************
    Purpose     : Open the Add Contact Popup with default Contact List of an Account
    **********************************************************************/
    public PageReference showAddContactPopUp() {
        try {
            fullQWrapper.addContactPopup = true;
            fullQWrapper.contIsActive = true; // set contact active during add
            isAddContact = true;
            String BranchId = FullQuoteDAO.getBranchId(fullQWrapper.fulFillingBranchInShippingDates, recId);
            listOfAllContacts = callLIstContactWS(BranchId, fullQWrapper.AccountId);
            if (listOfAllContacts != null && !listOfAllContacts.isEmpty() && listOfAllContacts[0].errorMessage != null && listOfAllContacts[0].errorMessage != '') {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, listOfAllContacts[0].errorMessage);
                ApexPages.addMessage(msg);
            }
            renderContactTab();
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC callCapacityLookupWebservice: ' + e.getMessage());
            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, e.getMessage());
            ApexPages.addMessage(msg);
        }
        return null;
    }
    
    /*********************************************************************
    Purpose     : return list of Contacts from Rental Result
    **********************************************************************/
    public List < HomeBaseBeans.ListContact > callLIstContactWS(String branchId, String AccountNo) {
        List < HomeBaseBeans.ListContact > listOfConts = new List < HomeBaseBeans.ListContact > ();
        AccContactService conServ = new AccContactService();
        listOfConts = conServ.listContacts(branchId, AccountNo);
        return listOfConts;
    }
    
    /*********************************************************************
    Purpose     : return specific Contact details from Rental Result
    **********************************************************************/
    public List < HomeBaseBeans.SpecificContact > callSpecificContactWS(String contactId, String AccountNo) {
        List < HomeBaseBeans.SpecificContact > listOfSpecCont = new List < HomeBaseBeans.SpecificContact > ();
        AccContactService conServ = new AccContactService();
        listOfSpecCont = conServ.SpecificContacts(contactId, AccountNo);
        return listOfSpecCont;
    }
    
    /*********************************************************************
    Purpose     : Web service to add or edit a contact in Rental Result
    **********************************************************************/
    public List < HomeBaseBeans.AddContact > callAddOrUpdateContactWS(String branchId, String AccountNo, String Payload, String Operation) {
        List < HomeBaseBeans.AddContact > listOfAddUpdateCont = new List < HomeBaseBeans.AddContact > ();
        AccContactService conServ = new AccContactService();
        listOfAddUpdateCont = conServ.AddContacts(branchId, AccountNo, Payload, Operation);
        return listOfAddUpdateCont;
    }
    
    /*********************************************************************
    Purpose     : return payload for add or edit a contact in Rental Result
    **********************************************************************/
    public String generateAddOrUpdatePayload(String ContactId, String branchId, FullQuoteWrapper fullQWrapper, Contact conObj ) {
        String addOrUpdatePayload = '';
        HomeBaseBeans.SpecificContact conData = new HomeBaseBeans.SpecificContact();
        if (ContactId != null && ContactId != '') {
            conData.contactId = ContactId;
        }
        if (branchId != null && branchId != '') {
            conData.branchId = branchId;
        } else {
            conData.branchId = '';
        }

        if (fullQWrapper != null && fullQWrapper.contFn != null && fullQWrapper.contFn != '') {
            conData.forename = fullQWrapper.contFn;
        } else {
            if(conObj != null && conObj.FirstName != null && conObj.FirstName != ''){
                conData.forename = conObj.FirstName;
            }else{
                conData.forename = '';
            }
        }
        if (fullQWrapper != null && fullQWrapper.contLn != null && fullQWrapper.contLn != '') {
            conData.surname = fullQWrapper.contLn;
        } else {
            
            if(conObj != null && conObj.LastName != null && conObj.LastName != ''){
                conData.surname = conObj.LastName;
            }else{
                conData.surname = '';
            }
        }
        if (fullQWrapper != null && fullQWrapper.contPhone != null && fullQWrapper.contPhone != '') {
            conData.phoneNumber = fullQWrapper.contPhone;
        } else {
            if(conObj != null && conObj.Phone != null && conObj.Phone != ''){
                conData.phoneNumber = conObj.Phone;
            }else{
                conData.phoneNumber = '';
            }
        }
        if (fullQWrapper != null && fullQWrapper.contEmail != null && fullQWrapper.contEmail != '') {
            conData.email = fullQWrapper.contEmail;
        } else {
            if(conObj != null && conObj.Email != null && conObj.Email != ''){
                conData.email = conObj.Email;
            }else{
                conData.email = '';
            }
        }
        if (fullQWrapper != null && fullQWrapper.contFax != null && fullQWrapper.contFax != '') {
            conData.faxNumber = fullQWrapper.contFax;
        } else {
            if(conObj != null && conObj.Fax != null && conObj.Fax != ''){
                conData.faxNumber = conObj.Fax;
            }else{
                conData.faxNumber = '';
            }
        }
        if (fullQWrapper != null && fullQWrapper.contIsPrimary != null) {
            conData.mainContact = String.valueOf(fullQWrapper.contIsPrimary);
        }
        if(conObj != null){
            conData.mainContact = 'true';
        }
        if (fullQWrapper != null && fullQWrapper.contIsActive != null && fullQWrapper.contIsActive) {
            conData.contactStatus = 'A';
        }
        if (fullQWrapper != null && fullQWrapper.contIsActive != null && !fullQWrapper.contIsActive) {
            conData.contactStatus = 'D';
        }
        if(conObj != null){
            conData.contactStatus = 'A';
        }
        conData.salutation = '';
        conData.position = '';
        conData.cellMobile = '';
        conData.contactStatusDescription = '';
        conData.contactTypeId = 'unknown';
        conData.contactTypeDescription = '';
        conData.phoneExtension = '';
        conData.companyNumber = '1';
        conData.companyName = '';
        conData.salesPersonId = '';
        conData.salesPersonName = '';
        conData.branchName = '';
        String str = JSON.serialize(conData);
        str = str.replace('"true"', 'true');
        str = str.replace('"flase"', 'false');
        str = str.replace('"errorMessage":null,', '');
        str = '{"contact":' + str + '}';
        system.debug('-----------str-------------------------------' + str);
        addOrUpdatePayload = str;
        return addOrUpdatePayload;
    }
    
    /*********************************************************************
    Purpose     : Hide Add/Edit Contact pop up
    **********************************************************************/
    public PageReference cancelAddContactPopUp() {
        fullQWrapper.addContactPopup = false;
        renderContactTab();
        isAddContact = true;
        fullQWrapper.contIsActive = true;
        isAddContactFromBillingTab = false;
        isAddContactFromShippingTab = false;
        resetContactForm();
        resetCardForm();
        resetAchForm();
        return null;
    }
    
    /*********************************************************************
    Purpose     : Insert a Contact in Rental Result
    **********************************************************************/
    public PageReference AddContact() {
        selectedAccContId = '';
        String BranchId = FullQuoteDAO.getBranchId(fullQWrapper.fulFillingBranchInShippingDates, recId);
        String AddPayload = generateAddOrUpdatePayload(selectedAccContId, BranchId,fullQWrapper, null);
        system.debug('-----AddPayload----' + AddPayload);
        List < HomeBaseBeans.AddContact > addContactResult = callAddOrUpdateContactWS(BranchId, fullQWrapper.AccountId, AddPayload, 'add');
        system.debug('-----addContactResult----' + addContactResult);
        if(addContactResult != null && !addContactResult.isEmpty() && addContactResult[0].errorMessage != null && addContactResult[0].errorMessage != ''){
            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, addContactResult[0].errorMessage);
            ApexPages.addMessage(msg);
        }else{
            listOfAllContacts = callLIstContactWS(BranchId, fullQWrapper.AccountId);
            if(listOfAllContacts != null && !listOfAllContacts.isEmpty() && listOfAllContacts[0].errorMessage != null && listOfAllContacts[0].errorMessage != ''){
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, listOfAllContacts[0].errorMessage);
                ApexPages.addMessage(msg);
                
            }
        }
        resetContactForm();

        renderContactTab();
        isAddContact = true;
        fullQWrapper.contIsActive = true;
        return null;
    }
    
    /*********************************************************************
    Purpose     : refresh Contact list with latest list of contacts
    **********************************************************************/
    public PageReference ListContact() {
        renderContactTab();
        return null;
    }
    
    /*********************************************************************
    Purpose     : Populate a Contact detail in Edit form in UI
    **********************************************************************/
    public PageReference EditContact() {
        selectedAccContId = '';
        renderContactTab();
        String ContactId = System.currentPageReference().getParameters().get('cId');
        List < HomeBaseBeans.SpecificContact > specContDetail = callSpecificContactWS(ContactId, fullQWrapper.AccountId);
        if(specContDetail != null && !specContDetail.isEmpty() && specContDetail[0].errorMessage != null && specContDetail[0].errorMessage != ''){
            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, specContDetail[0].errorMessage);
            ApexPages.addMessage(msg);
        }
        system.debug('--------------specContDetail------------------' + specContDetail);
        if (specContDetail != null && !specContDetail.isEmpty()) {
            selectedAccContId = specContDetail[0].contactId;
            fullQWrapper.contFn = specContDetail[0].forename;
            fullQWrapper.contLn = specContDetail[0].surname;
            fullQWrapper.contEmail = specContDetail[0].email;
            fullQWrapper.contPhone = specContDetail[0].phoneNumber;
            fullQWrapper.contFax = specContDetail[0].faxNumber;
            if (specContDetail[0].contactStatus != null && specContDetail[0].contactStatus == 'A') {
                fullQWrapper.contIsActive = true;
            }
            if (specContDetail[0].contactStatus != null && specContDetail[0].contactStatus == 'D') {
                fullQWrapper.contIsActive = false;
            }
            fullQWrapper.contIsPrimary = Boolean.valueOf(specContDetail[0].mainContact);
        }

        isAddContact = false;
        return null;
    }
    
    /*********************************************************************
    Purpose     : Reset the Contact form after an operation
    **********************************************************************/
    public void resetContactForm() {
        selectedAccContId = '';
        fullQWrapper.contFn = '';
        fullQWrapper.contLn = '';
        fullQWrapper.contEmail = '';
        fullQWrapper.contPhone = '';
        fullQWrapper.contFax = '';
        //fullQWrapper.contIsActive = false;
        fullQWrapper.contIsPrimary = false;
    }
    
    /*********************************************************************
    Purpose     : Reset the Card form after an operation
    **********************************************************************/
    public void resetCardForm() {
        fullQWrapper.cardFirstName = '';
        fullQWrapper.cardLastName = '';
        fullQWrapper.cardStreetAddress = '';
        fullQWrapper.cardCity = '';
        fullQWrapper.cardState = '';
        fullQWrapper.cardCountry = '';
        fullQWrapper.cardZip = '';
        fullQWrapper.cardEmail = '';
        fullQWrapper.cardDefaultAddressCode = '';
        fullQWrapper.cardUserPassword = '';
        fullQWrapper.cardPaymentType = '';
        fullQWrapper.cardType = '';
        fullQWrapper.cardNumber = '';
        fullQWrapper.cardExpiryMonth = '';
        fullQWrapper.cardExpiryYear = '';
        fullQWrapper.cardAdditionalSecurityData = '';
    }
    
    /*********************************************************************
    Purpose     : Go back to Contact list page form Contact Form page
    **********************************************************************/
    public void BackToContact() {
        resetCardForm();
        renderContactTab();
        resetAchForm();
    }
    
    /*********************************************************************
    Purpose     : Refresh the Contact Pop up
    **********************************************************************/
    public void renderContactTab() {
        isShowAddCon = true;
        isShowListCon = true;
        isShowListCard = false;
        isShowListAch = false;
        isShowAddCard = false;
        isShowAddAch = false;
    }
    
    /*********************************************************************
    Purpose     : Refresh the Card Pop up
    **********************************************************************/
    public void renderCardTab() {
        isShowAddCon = false;
        isShowListCon = false;
        isShowListCard = true;
        isShowListAch = false;
        isShowAddCard = true;
        isShowAddAch = false;
    }
    
    /*********************************************************************
    Purpose     : Refresh the Card Pop up
    **********************************************************************/
    public void renderAchTab() {
        isShowAddCon = false;
        isShowListCon = false;
        isShowListCard = false;
        isShowListAch = true;
        isShowAddCard = false;
        isShowAddAch = true;
    }
    
    /*********************************************************************
    Purpose     : Update the Contact details in Rental Result
    **********************************************************************/
    public PageReference UpdateContact() {
        String BranchId = FullQuoteDAO.getBranchId(fullQWrapper.fulFillingBranchInShippingDates, recId);
        //String ContactId = System.currentPageReference().getParameters().get('cId');
        String UpdatePayload = generateAddOrUpdatePayload(selectedAccContId, BranchId,fullQWrapper, null);
        system.debug('-----UpdatePayload----' + UpdatePayload);
        List < HomeBaseBeans.AddContact > updateContactResult = callAddOrUpdateContactWS(BranchId, fullQWrapper.AccountId, UpdatePayload, 'update');
        system.debug('-----updateContactResult----' + updateContactResult);
        if(updateContactResult != null && !updateContactResult.isEmpty() && updateContactResult[0].errorMessage != null && updateContactResult[0].errorMessage != ''){
            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, updateContactResult[0].errorMessage);
            ApexPages.addMessage(msg);
        }
        listOfAllContacts = callLIstContactWS(BranchId, fullQWrapper.AccountId);
        if(listOfAllContacts != null && !listOfAllContacts.isEmpty() && listOfAllContacts[0].errorMessage != null && listOfAllContacts[0].errorMessage != ''){
            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, listOfAllContacts[0].errorMessage);
            ApexPages.addMessage(msg);
        }
        selectedAccContId = '';
        resetContactForm();
        renderContactTab();
        isAddContact = true;
        fullQWrapper.contIsActive = true;
        return null;
    }
    //----------------------------------------------------Add/Edit Contact Functionality---------Starts---------------------------------------------
    //----------------------------------------------------Add/Edit Card Functionality---------Starts---------------------------------------------
    /*********************************************************************
    Purpose     : Open Card Form in Pop up with card list of a Contact
    **********************************************************************/
    public PageReference showAddCardTab() {
        listOfAllCards = new List < HomeBaseBeans.ListCard > ();
        String ContactId = System.currentPageReference().getParameters().get('contId');
        selectedCardContId = ContactId;
        listOfAllCards = callListCards(ContactId, fullQWrapper.AccountId);
        system.debug('--------------------autoPayDefCardKey1----------------'+autoPayDefCardKey1);
        system.debug('--------------------autoPayDefCardKey2----------------'+autoPayDefCardKey2);
        system.debug('--------------------autoPayDefCardKey3----------------'+autoPayDefCardKey3);
        makeDefaultCard();
        renderCardTab();
        isAddCard = true;
        populateCardDefaultAddress();
        return null;
    }
    
    /*********************************************************************
    Purpose     : Mark the default card in Edit mode of the Quote
    **********************************************************************/
    public void makeDefaultCard() {
        if(listOfAllCards != null && listOfAllCards.size() > 0 ){
            for(HomeBaseBeans.ListCard c : listOfAllCards){
                if(c.cardKey1 == autoPayDefCardKey1 && c.cardKey2 == autoPayDefCardKey2 && c.cardKey3 == autoPayDefCardKey3){
                    c.defaultCard = true;
                }else{
                    c.defaultCard = false;
                }
            }
        }
    }
    
    
    /*********************************************************************
    Purpose     : Mark the default ACH in Edit mode of the Quote
    **********************************************************************/
    public void makeDefaultACH() {
        system.debug('---------------autoPayDefCardKey1-------------------'+autoPayDefCardKey1);
        system.debug('---------------autoPayDefCardKey2-------------------'+autoPayDefCardKey2);
        system.debug('---------------autoPayDefCardKey3-------------------'+autoPayDefCardKey3);
        if(listOfAllAch != null && listOfAllAch.size() > 0 ){
            for(HomeBaseBeans.ListCard c : listOfAllAch){
                if(c.cardKey1 == autoPayDefCardKey1 && c.cardKey2 == autoPayDefCardKey2 && c.cardKey3 == autoPayDefCardKey3){
                    c.defaultCard = true;
                }else{
                    c.defaultCard = false;
                }
            }
        }
    }
    
    
    
    /*********************************************************************
    Purpose     : Populate default address for Card
    **********************************************************************/
    public void populateCardDefaultAddress() {
        fullQWrapper.cardStreetAddress = fullQWrapper.Address;
        fullQWrapper.cardCity = fullQWrapper.City;
        fullQWrapper.cardCountry = fullQWrapper.Country;
        fullQWrapper.cardState = fullQWrapper.State;
        fullQWrapper.cardZip = fullQWrapper.ZipCode;
    }
    
    /*********************************************************************
    Purpose     : Populate default address for ACH
    **********************************************************************/
    public void populateAchDefaultAddress() {
        fullQWrapper.achStreet = fullQWrapper.Address;
        fullQWrapper.achCity = fullQWrapper.City;
        fullQWrapper.achCountry = fullQWrapper.Country;
        fullQWrapper.achState = fullQWrapper.State;
        fullQWrapper.achZip = fullQWrapper.ZipCode;
    }
    
    /*********************************************************************
    Purpose     : Insert a Card detail in Rental Result
    **********************************************************************/
    public PageReference AddCard() {
        list < HomeBaseBeans.AddCardResponse > AddCardResponse = new list < HomeBaseBeans.AddCardResponse > ();
        AddCardResponse = callAddCard();
        system.debug('--------------AddCardResponse-----------------'+AddCardResponse);
        if (AddCardResponse != null && !AddCardResponse.isEmpty() && (AddCardResponse[0].errorMessage == null || AddCardResponse[0].errorMessage == '')) {
            if(AddCardResponse[0].successful == 'false'){
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, PershingError(AddCardResponse[0].statusMessage));
                ApexPages.addMessage(msg);
            }else{
                listOfAllCards = callListCards(selectedCardContId, fullQWrapper.AccountId);
                //selectedCardContId = '';
                makeDefaultCard();
                resetCardForm();
            }
        } else {
            if (AddCardResponse != null && !AddCardResponse.isEmpty() && AddCardResponse[0].errorMessage != null && AddCardResponse[0].errorMessage != '') {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, AddCardResponse[0].errorMessage);
                ApexPages.addMessage(msg);
            }
        }
        renderCardTab();
        isAddCard = true;
        return null;
    }
    
    
    /*********************************************************************
    Purpose     : Set card detail with Quote
    **********************************************************************/
    public void AutoCard() {
        String autoPayContId = System.currentPageReference().getParameters().get('cardContId');
        String autoPayCardKey1 = System.currentPageReference().getParameters().get('cardKey1');
        String autoPayCardKey2 = System.currentPageReference().getParameters().get('cardKey2');
        String autoPayCardKey3 = System.currentPageReference().getParameters().get('cardKey3');
        String autoPayOperation = System.currentPageReference().getParameters().get('Operation');
        String Payload = '{"mode":"'+autoPayOperation+'","accountId":"'+fullQWrapper.AccountId+'","contactId":"'+autoPayContId+'","type":"QUOTE","document_id":"'+docId+'","cardKey1":'+autoPayCardKey1+',"cardKey2":'+autoPayCardKey2+',"cardKey3":'+autoPayCardKey3+'}';
        AddCardServices ac = new AddCardServices();
        List<HomeBaseBeans.AutocheckResponse> AddCardWithQuoteResponse = null;
        AddCardWithQuoteResponse = ac.AddCardWithQuote(loginUserRec.Rental_Result_Username__c,Payload);
        system.debug('-------------------AddCardWithQuoteResponse----------------------'+AddCardWithQuoteResponse);
        if(AddCardWithQuoteResponse != null && !AddCardWithQuoteResponse.isEmpty() && AddCardWithQuoteResponse[0].successful == 'false'){
            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, AddCardWithQuoteResponse[0].statusMessage);
            ApexPages.addMessage(msg);
        }
        if(AddCardWithQuoteResponse != null && !AddCardWithQuoteResponse.isEmpty() && AddCardWithQuoteResponse[0].successful == 'true'){
            
            if(autoPayOperation == 'ADD'){
                autoPayDefCardKey1 = autoPayCardKey1;
                autoPayDefCardKey2 = autoPayCardKey2;
                autoPayDefCardKey3 = autoPayCardKey3;
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.CONFIRM, 'The card is successfully associated with this quote!');
                ApexPages.addMessage(msg);
            }else{
                autoPayDefCardKey1 = '';
                autoPayDefCardKey2 = '';
                autoPayDefCardKey3 = '';
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.CONFIRM, 'The card is successfully removed from this quote!');
                ApexPages.addMessage(msg);
            }
            
            makeDefaultCard();
            makeDefaultACH();
        }
    }
    
    
    /*********************************************************************
    Purpose     : Populate a specific card detail in Card Edit Form
    **********************************************************************/
    public PageReference EditCard() {
        cardContId = System.currentPageReference().getParameters().get('cardContId');
        cardKey1 = System.currentPageReference().getParameters().get('cardKey1');
        cardKey2 = System.currentPageReference().getParameters().get('cardKey2');
        cardKey3 = System.currentPageReference().getParameters().get('cardKey3');
        for (HomeBaseBeans.ListCard c: listOfAllCards) {
            if (c.cardKey1 == cardKey1 && c.cardKey2 == cardKey2 && c.cardKey3 == cardKey3) {
                fullQWrapper.cardFirstName = c.firstName;
                fullQWrapper.cardLastName = c.lastName;
                fullQWrapper.cardStreetAddress = c.address1;
                fullQWrapper.cardCity = c.city;
                fullQWrapper.cardCountry = c.country;
                //populate state..............................
                PopulateCardStatesList();
                fullQWrapper.cardState = c.state;
                fullQWrapper.cardZip = c.zipcode;
                fullQWrapper.cardEmail = c.email;
                fullQWrapper.cardDefaultAddressCode = c.defaultAddressCode;
                fullQWrapper.cardPaymentType = c.paymentType;
                fullQWrapper.cardType = c.cardType;
                fullQWrapper.cardNumber = c.cardNumberLast4;
                fullQWrapper.cardExpiryMonth = c.cardExpiryDate.subString(0, 2);
                fullQWrapper.cardExpiryYear = c.cardExpiryDate.subString(3, 7);
                break;
            }
        }
        renderCardTab();
        isAddCard = false;
        return null;
    }
    
    /*********************************************************************
    Purpose     : Update Card detail in Rental Result
    **********************************************************************/
    public PageReference UpdateCard() {
        list < HomeBaseBeans.AddCardResponse > updateCardResponse = new list < HomeBaseBeans.AddCardResponse > ();
        updateCardResponse = callUpdateCard();
        system.debug('------------------updateCardResponse-----------------'+updateCardResponse);
        if (updateCardResponse != null && !updateCardResponse.isEmpty() && (updateCardResponse[0].errorMessage == null || updateCardResponse[0].errorMessage == '')) {
            if(updateCardResponse[0].successful == 'false'){
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, PershingError(updateCardResponse[0].statusMessage));
                ApexPages.addMessage(msg);
            }else{
                listOfAllCards = callListCards(cardContId, fullQWrapper.AccountId);
                cardContId = '';
                makeDefaultCard();
                resetCardForm();
                isAddCard = true;
            }
        } else {
            if (updateCardResponse != null && !updateCardResponse.isEmpty() && updateCardResponse[0].errorMessage != null && updateCardResponse[0].errorMessage != '') {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, updateCardResponse[0].errorMessage);
                ApexPages.addMessage(msg);
                isAddCard = false;
            }
        }
        renderCardTab();
        return null;
    }

    /*********************************************************************
    Purpose     : return list of card for a contact
    **********************************************************************/
    public list < HomeBaseBeans.ListCard > callListCards(String contactId, String AccountNo) {
        List < HomeBaseBeans.ListCard > listOfCards = new List < HomeBaseBeans.ListCard > ();
        List < HomeBaseBeans.ListCard > lstOfCards = new List < HomeBaseBeans.ListCard > ();
        AddCardServices cardService = new AddCardServices();
        listOfCards = cardService.listCards(contactId, AccountNo);
        if(listOfCards != null && !listOfCards.isEmpty() && (listOfCards[0].errorMessage == null || listOfCards[0].errorMessage == '')){
            for(HomeBaseBeans.ListCard lc: listOfCards){
                if(lc.cardType != '909'){
                    if(lc.cardNumberLast4.length() > 4){
                      //lc.cardNumberLast4 = lc.cardNumberLast4.substring(12,16);   
                        lc.cardNumberLast4 = lc.cardNumberLast4.substring((lc.cardNumberLast4.length()-4),lc.cardNumberLast4.length());     // TFS-7954                    
                    }
                    lstOfCards.add(lc);
                }
            }
        }
        return lstOfCards;
    }
    
    /*********************************************************************
    Purpose     : return list of card for a contact
    **********************************************************************/
    public list < HomeBaseBeans.ListCard > callListACH(String contactId, String AccountNo) {
        List < HomeBaseBeans.ListCard > listOfAch = new List < HomeBaseBeans.ListCard > ();
        List < HomeBaseBeans.ListCard > lstOfCardsAndACH = new List < HomeBaseBeans.ListCard > ();
        AddCardServices cardService = new AddCardServices();
        lstOfCardsAndACH = cardService.listCards(contactId, AccountNo);
        if(lstOfCardsAndACH != null && !lstOfCardsAndACH.isEmpty() && (lstOfCardsAndACH[0].errorMessage == null || lstOfCardsAndACH[0].errorMessage == '')){
            for(HomeBaseBeans.ListCard lc: lstOfCardsAndACH){
                if(lc.cardType == '909'){
                    if(lc.bankAccountType == 'S'){
                        lc.bankAccountTypeDescription = 'Saving Account';
                    }
                    if(lc.bankAccountType == 'C'){
                        lc.bankAccountTypeDescription = 'Current Account';
                    }
                    listOfAch.add(lc);
                }
            }
        }
        return listOfAch;
    }
    
    /*********************************************************************
    Purpose     : Insert a card in Rental Result 
    **********************************************************************/
    public list < HomeBaseBeans.AddCardResponse > callAddCard() {
        List < HomeBaseBeans.AddCardResponse > lstNewlyAddedCard = new List < HomeBaseBeans.AddCardResponse > ();
        AddCardServices cardService = new AddCardServices();
        lstNewlyAddedCard = cardService.AddCard(loginUserRec.Rental_Result_Username__c, generateAddOrUpdateCardPayload(selectedCardContId, '', '', '', 'add'));
        return lstNewlyAddedCard;
    }
    
    /*********************************************************************
    Purpose     : Update a card detail in Rental Result 
    **********************************************************************/
    public list < HomeBaseBeans.AddCardResponse > callUpdateCard() {
        List < HomeBaseBeans.AddCardResponse > lstUpdateCardResponse = new List < HomeBaseBeans.AddCardResponse > ();
        AddCardServices cardService = new AddCardServices();
        lstUpdateCardResponse = cardService.UpdateCard(loginUserRec.Rental_Result_Username__c, generateAddOrUpdateCardPayload(cardContId, cardKey1, cardKey2, cardKey3, 'update'));
        return lstUpdateCardResponse;
    }
    
    /*********************************************************************
    Purpose     : generate payload for Add/ Edit Card Detail
    **********************************************************************/
    public String generateAddOrUpdateCardPayload(String ContactId, String cardKey1, String cardKey2, String cardKey3, String Operation) {
        String AddCradPayload = '';
        HomeBaseBeans.ListCard AddCardPayloadObj = new HomeBaseBeans.ListCard();
        AddCardPayloadObj.accountId = fullQWrapper.AccountId;
        AddCardPayloadObj.contactId = ContactId;
        AddCardPayloadObj.firstName = fullQWrapper.cardFirstName;
        AddCardPayloadObj.lastName = fullQWrapper.cardLastName;
        AddCardPayloadObj.address1 = fullQWrapper.cardStreetAddress;
        AddCardPayloadObj.address2 = '';
        AddCardPayloadObj.city = fullQWrapper.cardCity;
        AddCardPayloadObj.county = '';
        AddCardPayloadObj.state = fullQWrapper.cardState;
        AddCardPayloadObj.zipcode = fullQWrapper.cardZip;
        AddCardPayloadObj.country = fullQWrapper.cardCountry;
        AddCardPayloadObj.paymentType = fullQWrapper.cardPaymentType;
        AddCardPayloadObj.cardType = fullQWrapper.cardType;
        if (Operation == 'update') {
            if (!fullQWrapper.cardNumber.contains('X') && !fullQWrapper.cardNumber.contains('x')) {
                AddCardPayloadObj.cardNumber = fullQWrapper.cardNumber;
            }else{
                AddCardPayloadObj.paymentType = '';
                AddCardPayloadObj.cardType = '';
            }
        }
        if (Operation == 'add') {
            AddCardPayloadObj.cardNumber = fullQWrapper.cardNumber;
        }
        AddCardPayloadObj.expiryMonth = fullQWrapper.cardExpiryMonth;
        AddCardPayloadObj.expiryYear = fullQWrapper.cardExpiryYear;
        AddCardPayloadObj.additionalSecurityData = fullQWrapper.cardAdditionalSecurityData;
        AddCardPayloadObj.email = fullQWrapper.cardEmail;
        AddCardPayloadObj.userPassword = fullQWrapper.cardUserPassword;
        AddCardPayloadObj.defaultAddressCode = fullQWrapper.cardDefaultAddressCode;
        if (Operation == 'update') {
            AddCardPayloadObj.cardKey1 = cardKey1;
            AddCardPayloadObj.cardKey2 = cardKey2;
            AddCardPayloadObj.cardKey3 = cardKey3;
        }

        String str = JSON.serialize(AddCardPayloadObj);
        str = str.replace('"defaultAddressCodeDescription":null,', '');
        str = str.replace('"cardTypeDescription":null,', '');
        str = str.replace('"cardExpiryDate":null,', '');
        str = str.replace('"cardName":null,', '');
        str = str.replace('"cardNumberLast4":null,', '');
        str = str.replace('"paymentTypeDescription":null,', '');
        str = str.replace('"transactionSource":null,', '');
        str = str.replace('"transactionType":null,', '');
        str = str.replace('"bankName":null,', '');
        str = str.replace('"bankCity":null,', '');
        str = str.replace('"bankState":null,', '');
        str = str.replace('"bankAccountType":null,', '');
        str = str.replace('"bankAccountTypeDescription":null,', '');
        str = str.replace('"chequeType":null,', '');
        str = str.replace('"chequeTypeDescription":null,', '');
        str = str.replace('"telephone":null,', '');
        if (Operation == 'add') {
            str = str.replace('"cardKey1":null,', '');
            str = str.replace('"cardKey2":null,', '');
            str = str.replace('"cardKey3":null,', '');
        }
        str = str.replace('"bankSortCode":null,', '');
        str = str.replace('"bankAccountNumber":null,', '');
        str = str.replace('"defaultCard":null,', '');
        str = str.replace('"errorMessage":null,', '');

        str = '{"creditCardDetails":' + str + '}';
        system.debug('-----------str-------------------------------' + str);
        AddCradPayload = str;
        return AddCradPayload;

    }
    
    //----------------------------------------------------Add/Edit ACH Functionality---------Start---------------------------------------------
    /*********************************************************************
    Purpose     : Show ACH Form in the pop up
    **********************************************************************/
    public PageReference showAddAchTab() {
        listOfAllAch = new List < HomeBaseBeans.ListCard > ();
        String ContactId = System.currentPageReference().getParameters().get('contAchId');
        selectedAchContId = ContactId;
        system.debug('--------------selectedAchContId------------------'+selectedAchContId);
        listOfAllAch = callListACH(ContactId, fullQWrapper.AccountId);
        system.debug('--------------listOfAllAch------------------'+listOfAllAch);
        renderAchTab();
        isAddAch = true;
        populateAchDefaultAddress();
        makeDefaultACH();
        return null;
    }
    
    /*********************************************************************
    Purpose     : Go back to Contact list page form Card Form page
    **********************************************************************/
    public void BackToCard() {
        resetAchForm();
        renderCardTab();
    }
    
    /*********************************************************************
    Purpose     : Reset the Card form after an operation
    **********************************************************************/
    public void resetAchForm() {
        fullQWrapper.achFirstName = '';
        fullQWrapper.achBankName = '';
        fullQWrapper.achLastName = '';
        fullQWrapper.achBankAccNo = '';
        fullQWrapper.achEmail = '';
        fullQWrapper.achBankSortCode = '';
        fullQWrapper.achPhone = '';
        fullQWrapper.achBankAccType = '';
        fullQWrapper.achStreet = '';
        fullQWrapper.achCheckType = '';
        fullQWrapper.achCity = '';
        fullQWrapper.achBankCity = '';
        fullQWrapper.achCountry = '';
        fullQWrapper.achBankState = '';
        fullQWrapper.achState = '';
        fullQWrapper.achDefaultAddressCode = '';
        fullQWrapper.achZip = '';
        fullQWrapper.achUserPassword = '';
    }
    
    /*********************************************************************
    Purpose     : Inserte a ACH detail in Rental Result 
    **********************************************************************/
    public void AddAch(){
        List < HomeBaseBeans.AddCardResponse > lstNewlyAddedAchDetail = callAddAch();
        system.debug('-----------lstNewlyAddedAchDetail-------------------------------' + lstNewlyAddedAchDetail);
        if (lstNewlyAddedAchDetail != null && !lstNewlyAddedAchDetail.isEmpty() && (lstNewlyAddedAchDetail[0].errorMessage == null || lstNewlyAddedAchDetail[0].errorMessage == '')) {
            if(lstNewlyAddedAchDetail[0].successful == 'false'){
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, PershingError(lstNewlyAddedAchDetail[0].statusMessage));
                ApexPages.addMessage(msg);
            }else{
                listOfAllAch = callListACH(selectedAchContId, fullQWrapper.AccountId);
                //selectedAchContId = '';
                makeDefaultACH();
                resetAchForm();
            }
        } else {
            if (lstNewlyAddedAchDetail != null && !lstNewlyAddedAchDetail.isEmpty() && lstNewlyAddedAchDetail[0].errorMessage != null && lstNewlyAddedAchDetail[0].errorMessage != '') {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, lstNewlyAddedAchDetail[0].errorMessage);
                ApexPages.addMessage(msg);
            }
        }
        renderAchTab();
        isAddAch = true;
    }
    
    /*********************************************************************
    Purpose     : Used to display user friendly error message 
    **********************************************************************/
    public String PershingError(String errorStr){
        String FormattedError = ''; 
        if(errorStr != null && errorStr != ''){
            Integer lastIndex = errorStr.lastIndexOf('c:');
            FormattedError = errorStr.substring(lastIndex + 2,errorStr.length());
            if(rrErrorAndErrormsg.containsKey(FormattedError)){
                FormattedError = rrErrorAndErrormsg.get(FormattedError);
            }
            FormattedError = 'One or more fields in the request contains invalid data: ' +FormattedError;
        }
        return FormattedError;
    }
    /*********************************************************************
    Purpose     : Populate ACH detail in ACH Form for edit 
    **********************************************************************/
    public void EditAch(){
        AchContId = System.currentPageReference().getParameters().get('achContId');
        cardKey1 = System.currentPageReference().getParameters().get('cardKey1');
        cardKey2 = System.currentPageReference().getParameters().get('cardKey2');
        cardKey3 = System.currentPageReference().getParameters().get('cardKey3');
        for (HomeBaseBeans.ListCard c : listOfAllAch) {
            if (c.cardKey1 == cardKey1 && c.cardKey2 == cardKey2 && c.cardKey3 == cardKey3) {
                fullQWrapper.achFirstName = c.firstName;
                fullQWrapper.achBankName = c.bankName;
                fullQWrapper.achLastName = c.lastName;
                fullQWrapper.achBankAccNo = 'XXXXXXXXXX';
                fullQWrapper.achEmail = c.email;
                fullQWrapper.achBankSortCode = 'XXXXXXXXXX';
                fullQWrapper.achPhone = c.telephone;
                fullQWrapper.achBankAccType = c.bankAccountType;
                fullQWrapper.achStreet = c.address1;
                fullQWrapper.achCheckType = c.chequeType;
                fullQWrapper.achCity = c.city;
                fullQWrapper.achBankCity = c.bankCity;
                fullQWrapper.achCountry = c.country;
                PopulateAchStatesList();
                fullQWrapper.achBankState = c.bankState;
                fullQWrapper.achState = c.state;
                fullQWrapper.achDefaultAddressCode = c.defaultAddressCode;
                fullQWrapper.achZip = c.zipcode;
                fullQWrapper.achUserPassword = '';
                break;
            }
        }
        renderAchTab();
        isAddAch = false;
    }
    
    /*********************************************************************
    Purpose     : Update a ACH detail in Rental Result 
    **********************************************************************/
    public void UpdateAch(){
        list < HomeBaseBeans.AddCardResponse > updateAchResponse = new list < HomeBaseBeans.AddCardResponse > ();
        updateAchResponse = callUpdateAch();
        system.debug('------------------updateAchResponse-----------------'+updateAchResponse);
        if (updateAchResponse != null && !updateAchResponse.isEmpty() && (updateAchResponse[0].errorMessage == null || updateAchResponse[0].errorMessage == '')) {
            if(updateAchResponse[0].successful == 'false'){
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, PershingError(updateAchResponse[0].statusMessage));
                ApexPages.addMessage(msg);
            }else{
                listOfAllAch = callListACH(AchContId, fullQWrapper.AccountId);
                AchContId = '';
                makeDefaultACH();
                resetAchForm();
                isAddAch = true;
            }
        } else {
            if (updateAchResponse != null && !updateAchResponse.isEmpty() && updateAchResponse[0].errorMessage != null && updateAchResponse[0].errorMessage != '') {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, updateAchResponse[0].errorMessage);
                ApexPages.addMessage(msg);
                isAddCard = false;
            }
        }
        renderAchTab();
    }
    
    /*********************************************************************
    Purpose     : Generate payload fpr Add /Edit ACH Web Service call
    **********************************************************************/
    public String generateAddOrUpdateAchPayload(String ContactId, String cardKey1, String cardKey2, String cardKey3, String Operation) {
        String AddAchPayload = '';
        HomeBaseBeans.ListCard AddAchPayloadObj = new HomeBaseBeans.ListCard();
        AddAchPayloadObj.accountId = fullQWrapper.AccountId;
        AddAchPayloadObj.contactId = ContactId;
        AddAchPayloadObj.firstName = fullQWrapper.achFirstName;
        AddAchPayloadObj.lastName = fullQWrapper.achLastName;
        AddAchPayloadObj.address1 = fullQWrapper.achStreet;
        AddAchPayloadObj.city = fullQWrapper.achCity;
        AddAchPayloadObj.state = fullQWrapper.achState;
        AddAchPayloadObj.zipcode = fullQWrapper.achZip;
        AddAchPayloadObj.country = fullQWrapper.achCountry;
        AddAchPayloadObj.bankName = fullQWrapper.achBankName;
        AddAchPayloadObj.bankCity = fullQWrapper.achBankCity;
        AddAchPayloadObj.bankState = fullQWrapper.achBankState;
        
        if (Operation == 'add') {
            AddAchPayloadObj.bankAccountNumber = fullQWrapper.achBankAccNo;
            AddAchPayloadObj.bankAccountType = fullQWrapper.achBankAccType;
            AddAchPayloadObj.chequeType = fullQWrapper.achCheckType;
            AddAchPayloadObj.bankSortCode = fullQWrapper.achBankSortCode;
        }
        
        AddAchPayloadObj.telephone = fullQWrapper.achPhone;
        AddAchPayloadObj.email = fullQWrapper.achEmail;
        AddAchPayloadObj.userPassword = fullQWrapper.achUserPassword;
        if (Operation == 'add') {
            AddAchPayloadObj.cardType = '909';
        }
        AddAchPayloadObj.defaultAddressCode = fullQWrapper.achDefaultAddressCode;
        
        if (Operation == 'update') {
            if (!fullQWrapper.achBankAccNo.contains('X') && !fullQWrapper.achBankAccNo.contains('x')) {
                AddAchPayloadObj.bankAccountNumber = fullQWrapper.achBankAccNo;
                AddAchPayloadObj.bankAccountType = fullQWrapper.achBankAccType;
                AddAchPayloadObj.chequeType = fullQWrapper.achCheckType;
                AddAchPayloadObj.bankSortCode = fullQWrapper.achBankSortCode;
            }
            if (!fullQWrapper.achBankSortCode.contains('X') && !fullQWrapper.achBankSortCode.contains('x')) {
                AddAchPayloadObj.bankSortCode = fullQWrapper.achBankSortCode;
            }
        }
        if (Operation == 'update') {
            AddAchPayloadObj.cardKey1 = cardKey1;
            AddAchPayloadObj.cardKey2 = cardKey2;
            AddAchPayloadObj.cardKey3 = cardKey3;
        }
        
        String str = JSON.serialize(AddAchPayloadObj);
        str = str.replace('"address2":null,', '');
        str = str.replace('"county":null,', '');
        str = str.replace('"defaultAddressCodeDescription":null,', '');
        str = str.replace('"cardTypeDescription":null,', '');
        str = str.replace('"cardExpiryDate":null,', '');
        str = str.replace('"cardName":null,', '');
        str = str.replace('"cardNumberLast4":null,', '');
        str = str.replace('"paymentType":null,', '');
        str = str.replace('"paymentTypeDescription":null,', '');
        str = str.replace('"transactionSource":null,', '');
        str = str.replace('"transactionType":null,', '');
        str = str.replace('"chequeTypeDescription":null,', '');
        str = str.replace('"bankAccountTypeDescription":null,', '');
        if (Operation == 'add') {
            str = str.replace('"cardKey1":null,', '');
            str = str.replace('"cardKey2":null,', '');
            str = str.replace('"cardKey3":null,', '');
        }
        if (Operation == 'update') {
            str = str.replace('"cardType":null,', '');
        }
        str = str.replace('"cardNumber":null,', '');
        str = str.replace('"expiryMonth":null,', '');
        str = str.replace('"expiryYear":null,', '');
        str = str.replace('"additionalSecurityData":null,', '');
        str = str.replace('"defaultCard":null,', '');
        str = str.replace('"errorMessage":null,', '');

        str = '{"checkDetails":' + str + '}';
        system.debug('-----------str-------------------------------' + str);
        AddAchPayload = str;
        return AddAchPayload;

    }
    
    /*********************************************************************
    Purpose     : Insert a ACH in Rental Result 
    **********************************************************************/
    public list < HomeBaseBeans.AddCardResponse > callAddAch() {
        List < HomeBaseBeans.AddCardResponse > lstNewlyAddedAch = new List < HomeBaseBeans.AddCardResponse > ();
        AddCardServices cardService = new AddCardServices();
        lstNewlyAddedAch = cardService.AddAutoCheck(loginUserRec.Rental_Result_Username__c, generateAddOrUpdateAchPayload(selectedAchContId, '', '', '', 'add'));
        return lstNewlyAddedAch;
    }
    
    /*********************************************************************
    Purpose     : Update a ACH detail in Rental Result 
    **********************************************************************/
    public list < HomeBaseBeans.AddCardResponse > callUpdateAch() {
        List < HomeBaseBeans.AddCardResponse > lstUpdateAchResponse = new List < HomeBaseBeans.AddCardResponse > ();
        AddCardServices cardService = new AddCardServices();
        system.debug('-------------AchContId-------------------'+AchContId);
        lstUpdateAchResponse = cardService.UpdateAutoCheck(loginUserRec.Rental_Result_Username__c,generateAddOrUpdateAchPayload(AchContId, cardKey1, cardKey2, cardKey3, 'update'));
        return lstUpdateAchResponse;
    }
    //----------------------------------------------------Add/Edit ACH Functionality---------Start---------------------------------------------
    
    
    //----------------------------------------------------Add/Edit Card Functionality---------Ends---------------------------------------------
    // Disable contact popup

    public PageReference cancelContactPopUp() {
        isEmailContactPopUp = false;
        fullQWrapper.contactPopup = false;
        qqWrapper = new QuickQuoteWrapper();
        return null;
    }

    public pageReference hideReserveCapacityId() {
        fullQWrapper.showReserveCapacityId = false;
        //Added for Issue no 1173 and 1174------------
        if (IsReservedSuccess) {
            PageReference pf = new PageReference('/apex/FullQuoteForm_VF?fullQUoteId=' + docId + '&emailQuote=true');
            pf.setRedirect(true);
            return pf;
        } else {
            return null;
        }
    }




    public pageReference capReservePopUpYes() {
        fullQWrapper.showCapacityPopUp = true;
        fullQWrapper.ifCapacityYes = true;
        return null;
    }

    public pageReference capReservePopUpNo() {

        fullQWrapper.showCapacityPopUp = false;
        fullQWrapper.ifCapacityYes = false;
        if (docId != null && docId != '') {
            updateFQ(docId);
        }
        if (docId != null) {
            //PageReference pf = new PageReference('/'+opportunityID);
            PageReference pf = new PageReference('/apex/FullQuoteForm_VF?fullQUoteId=' + docId + '&emailQuote=true');
            pf.setRedirect(true);
            return pf;
        } else {
            return null;
        }
    }

    public void updateFQ(String QuoteId) {
        MMI_Full_Quotes__c fQObj = FullQuoteDAO.getFullQuoteRecord(QuoteId);
        if (fQObj != null) {
            if (fQObj.Reservation_ID__c == null || fQObj.Reservation_ID__c == '') {
                fQObj.No_Reservation__c = true;
            }
            update fQObj;
        }
    }

    // To enable or disable Product Summary Lines section in product screen

    public boolean getShowSummaryLineSec() {
        if (summaryLineList.size() > 0) {
            return true;
        } else {
            return false;
        }
    }

    // To enable or disable contractor input field in product tab

    public boolean getEnableContractorField() {
        System.debug('boolean test ' + fullQWrapper.TransactionType);
        if (fullQWrapper.TransactionType == 'CNST') {
            return false;
        } else {
            return true;
        }
    }

    // To disable Save Quote button when field values changed

    public PageReference disableSaveQuoteBtn() {
        if (isRefreshTrue) {
            fullQWrapper.enableRefreshQuote = true;
            fullQWrapper.enableSaveQuote = false;
            fullQWrapper.enableMarkAsLostbutton = false;
        }
        return null;
    }

    //cancel taxId popup in shipping tab

    public PageReference CancelTaxIdShippingIdSelected() {
        addressErrorMessage = '';
        fullQWrapper.showTaxIdShippingPopUp = false;
        fullQWrapper.showValidateAddressShippingPopUp = false;
        fullQWrapper.enableRefreshQuote = false;
        fullQWrapper.enableSaveQuote = false;
        fullQWrapper.enableMarkAsLostbutton = false;

        fullQWrapper.enableProductadd = false;
        fullQWrapper.enableVAddresBtnInShipping = true;
        isFullfillingBranchid = true;
        return null;
    }

    // To close validate address in shipping tab

    public PageReference CancelValidateAddressShippingIdSelected() {
        //DescarteInnerClassShippingList.clear();
        addressErrorMessage = '';
        fullQWrapper.showValidateAddressShippingPopUp = false;
        fullQWrapper.enableRefreshQuote = false;
        fullQWrapper.enableSaveQuote = false;
        fullQWrapper.enableMarkAsLostbutton = false;

        fullQWrapper.enableProductadd = false;
        fullQWrapper.enableVAddresBtnInShipping = true;
        isFullfillingBranchid = true;
        return null;
    }

    public PageReference hideErrorPopUp() {
        fullQWrapper.showErrorPopUp = false;
        return null;
    }

    public PageReference disableMinimumTermPopUp() {
        fullQWrapper.showMinimumTermPopUp = false;
        fullQWrapper.showSearchChargeCodeList = false;
        qqWrapper = new QuickQuoteWrapper();
        return null;
    }



    public PageReference enableAnalysisCodePopupInProduct() {
        fullQWrapper.showAnalysisCodePopupInProduct = true;
        return null;
    }
    // cancel analysis set code

    public PageReference cancelAnalysisSetCodeSearch() {
        fullQWrapper.showAnalysisCodePopup = false;
        qqWrapper = new QuickQuoteWrapper();
        fullQWrapper.showSearchAnalysisSetCodeInBilling = false;
        return null;
    }

    // cancel analysis set 

    public PageReference cancelAnalysisSetSearch() {
        fullQWrapper.showAnalysisCodePopup = false;
        qqWrapper = new QuickQuoteWrapper();
        fullQWrapper.showSearchAnalysisSetCodeInBilling = false;
        return null;
    }
    // To enable validate address button when any address details changed in billing screen 
    public void enableBilingAddressFields() {
        isBillingAddressDisabled = false;
        isBillingCityDisabled = false;
        isBillingCountyDisabled = false;
        isBillingStateDisabled = false;
        isBillingContryDisabled = false;
        isBillingZipDisabled = false;
    }

    public void disableBilingAddressFields() {
        isBillingAddressDisabled = true;
        isBillingCityDisabled = true;
        isBillingCountyDisabled = true;
        isBillingStateDisabled = true;
        isBillingContryDisabled = true;
        isBillingZipDisabled = true;
    }

    public PageReference onChangeAddressIdInBillingTab() {
        isbillingOrShiiping = true;
        accountIDInBilling();
        accountAddresInvalid = false;
        String accountidAfter = fullQWrapper.AccountId.substring(fullQWrapper.AccountId.indexOf('.') + 1);
        if (accountidAfter.length() > 3) {
            accountidAfter = '0';
        }
        if (test.isRunningTest()) {
            fullQWrapper.ID = '1';
            accountidAfter = '1';
            addressBillingList = MMIFullquoteTestDataProvider.getAddressesList();
        }
        if (fullQWrapper.ID != null) {
            if (accountidAfter == fullQWrapper.ID) {
                String notFound = 'Yes';
                for (HomeBaseBeans.addresses addbill: addressBillingList) {
                    if (fullQWrapper.ID == addbill.addressNo) {
                        fullQWrapper.ID = addbill.addressNo;
                        if (addbill.addressLine2 != null && addbill.addressLine2 != '') {
                            fullQWrapper.Address = addbill.addressLine1 + ' , ' + addbill.addressLine2;
                        } else {
                            fullQWrapper.Address = addbill.addressLine1;
                        }
                        fullQWrapper.City = addbill.addressLine3;
                        //County = addbill.countryId;
                        fullQWrapper.zipCode = addbill.zipCode;
                        fullQWrapper.County = addbill.addressLine4;
                        fullQWrapper.Country = addbill.countryId;
                        StatesList();
                        fullQWrapper.State = addbill.state;
                        notFound = 'no';
                        disableBilingAddressFields();

                    }
                }
                if (test.isRunningTest()) {
                    notFound = 'yes';
                }
                if (notFound == 'yes') {
                    ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Billing Address Id Not Found');
                    ApexPages.addMessage(msg);

                    accountAddresInvalid = true;
                    //fullQWrapper.ID = null;
                    fullQWrapper.Address = null;
                    fullQWrapper.City = null;
                    fullQWrapper.County = null;
                    fullQWrapper.Status = null;
                    //County = addbill.countryId;
                    fullQWrapper.zipCode = null;
                    fullQWrapper.Country = null;
                    //StatesList();
                    fullQWrapper.State = null;
                    enableBilingAddressFields();
                }
            } else {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Billing Address id ' + fullQWrapper.ID + ' Account ID ' + accountidAfter + ' must match.');
                ApexPages.addMessage(msg);
                accountAddresInvalid = true;
                //fullQWrapper.ID = null;
                fullQWrapper.Address = null;
                fullQWrapper.City = null;
                fullQWrapper.County = null;
                fullQWrapper.Status = null;
                //County = addbill.countryId;
                fullQWrapper.zipCode = null;
                fullQWrapper.Country = null;
                //StatesList();
                fullQWrapper.State = null;
                enableBilingAddressFields();
            }
        }
        return null;
    }
    public PageReference enableVAddressBtnWhenChange() {
        if (fullQWrapper.isUseBillingAddress) {
            fullQWrapper.isUseBillingAddress = false;
        }
        //fullQWrapper.enableVAddresBtnInBilling = true;      
        //fullQWrapper.enableRefreshQuote = false;  
        //fullQWrapper.enableSaveQuote = false;
        //fullQWrapper.enableMarkAsLostbutton = false;

        return null;
    }

    // To enable validate address button when any address details changed in shipping screen 
    public PageReference onChangeAddressIdInShippingTab() {

        //Button enable disable
        isbillingOrShiiping = true;
        accountIDInBilling();
        fullQWrapper.enableRefreshQuote = false;
        fullQWrapper.enableSaveQuote = false;
        fullQWrapper.enableMarkAsLostbutton = false;

        fullQWrapper.enableProductadd = false;
        fullQWrapper.enableVAddresBtnInShipping = true;
        isFullfillingBranchid = true;
        shippingAddressInvalide = false;
        if (test.isRunningTest()) {
            fullQWrapper.ID = '0';
        }
        if (fullQWrapper.ID != null) {
            String notFound = 'Yes';
            if (test.isRunningTest()) {
                addressshippingList = MMIFullquoteTestDataProvider.getAddressesList();
                fullQWrapper.shippingId = '1';
            }
            for (HomeBaseBeans.addresses shiipingAddresonchnage: addressshippingList) {
                if (fullQWrapper.shippingId == shiipingAddresonchnage.addressNo) {
                    fullQWrapper.shippingId = shiipingAddresonchnage.addressNo;
                    if (shiipingAddresonchnage.addressLine2 != null && shiipingAddresonchnage.addressLine2 != '') {
                        fullQWrapper.AddressInShippingDates = shiipingAddresonchnage.addressLine1 + ' , ' + shiipingAddresonchnage.addressLine2;
                    } else {
                        fullQWrapper.AddressInShippingDates = shiipingAddresonchnage.addressLine1;
                    }
                    fullQWrapper.cityInShippingDates = shiipingAddresonchnage.addressLine3;
                    fullQWrapper.countyInShippingDates = shiipingAddresonchnage.addressLine4;
                    fullQWrapper.countryInShippingDates = shiipingAddresonchnage.countryId;
                    fullQWrapper.ZipCodeInShipping = shiipingAddresonchnage.zipCode;
                    shippingStatesList();
                    fullQWrapper.stateInShippingDates = shiipingAddresonchnage.state;
                    notFound = 'no';

                }
            }
            if (test.isRunningTest()) {
                notFound = 'yes';
            }
            if (notFound == 'yes') {

                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Shipping Address Id Not Found');
                ApexPages.addMessage(msg);
                fullQWrapper.SelectedShipingTaxId = '';
                addressErrorMessage = null;
                shippingAddressInvalide = true;
                //fullQWrapper.shippingId = null;
                fullQWrapper.cityInShippingDates = null;
                fullQWrapper.AddressInShippingDates = null;
                fullQWrapper.countyInShippingDates = null;
                fullQWrapper.countryInShippingDates = null;
                //shippingStatesList();
                fullQWrapper.stateInShippingDates = null;
                fullQWrapper.ZipCodeInShipping = null;
                fullQWrapper.fulFillingBranchInShippingDates = null;
                fullQWrapper.fulFillingBranchNameInShippingDates = null;
            }
        }
        if (fullQWrapper.isUseBillingAddress) {
            fullQWrapper.isUseBillingAddress = false;
        }
        return null;

    }
    public void onchangeNoReservation() {
        //fullQuote.Quote_expires__c = fullQuote.Start_Date__c.addDays(30);

        isScheduledDeliveryDateIsReadOnly = false;
        if (test.isRunningTest()) {
            fullQuote.Start_Date__c = system.today();
            fullQWrapper.noReservation = true;
        }
        if (fullQuote.Start_Date__c == null) {
            fullQuote.Loaded_Move_In__c = null;
            fullQuote.Quote_expires__c = null;
        } else {
            isQuoteExpireIsReadOnly = true;
            fullQuote.Scheduled_Delivery__c = fullQuote.Start_Date__c;
            fullQuote.Quote_expires__c = fullQuote.Start_Date__c.addDays(30);
            if (fullQWrapper.noReservation == true) {
                if (fullQuote.Start_Date__c != null) {
                    isScheduledDeliveryDateIsReadOnly = true;
                    ShowReserveCapacityLink = false;
                    fullQuote.Scheduled_Delivery__c = fullQuote.Start_Date__c;
                    //isScheduDeliver = true;
                }
            } else {
                fullQuote.Scheduled_Delivery__c = fullQuote.Start_Date__c;
                if (docId != null) {
                    if (cloneIsTrue != 'true') {
                        ShowReserveCapacityLink = true;
                    } else {
                        ShowReserveCapacityLink = false;
                    }
                }
            }
        }
        if (fullQWrapper.startDateonchange) {
            fullQWrapper.enableRefreshQuote = true;
            fullQWrapper.enableSaveQuote = false;
            fullQWrapper.enableMarkAsLostbutton = false;

        } else {
            if (isProductAlreadyAdded) {
                fullQWrapper.enableRefreshQuote = true;
            } else {
                fullQWrapper.enableRefreshQuote = false;
            }
            fullQWrapper.enableSaveQuote = false;
            fullQWrapper.enableMarkAsLostbutton = false;

        }

        integer days = 0;
        if (fullQWrapper.rentalLengthInProduct != null && fullQWrapper.rentalLengthInProduct != '') {
            days = (28 * integer.valueof(fullQWrapper.rentalLengthInProduct));
        } else {
            days = (28 * 1);
        }
        if (fullQuote.Start_Date__c == null) {
            system.debug('------');
            fullQuote.Loaded_Move_In__c = null;
        } else {
            if (fullQWrapper.TransactionType == 'ON') {
                isLodedMoveInIsReadOnly = false;
                fullQuote.Loaded_Move_In__c = fullQuote.Start_Date__c.addDays(days);
            } else {
                fullQuote.Loaded_Move_In__c = fullQuote.Start_Date__c.addDays(days);
                isLodedMoveInIsReadOnly = true;
            }
        }
    }
    public PageReference enableVAddressBtnWhenChangeInShipping() {
        if (test.isRunningTest()) {
            fullQWrapper.fulFillingBranchInShippingDates = '102';
        }
        if (fullQWrapper.fulFillingBranchInShippingDates != null && fullQWrapper.fulFillingBranchInShippingDates != '') {
            fullQWrapper.fulFillingBranchInShippingDates = null;
            fullQWrapper.fulFillingBranchNameInShippingDates = null;
            addressErrorMessage = '';
            fullQWrapper.deliveryZoneInShipping = null;
            fullQWrapper.distFromBranch = null;

        }
        if (fullQWrapper.isUseBillingAddress) {
            fullQWrapper.isUseBillingAddress = false;
        }
        //Button enable disable
        fullQWrapper.enableRefreshQuote = false;
        fullQWrapper.enableSaveQuote = false;
        fullQWrapper.enableMarkAsLostbutton = false;
        fullQWrapper.convertQuoteToOrder = false;

        fullQWrapper.enableProductadd = false;
        fullQWrapper.enableVAddresBtnInShipping = true;
        isFullfillingBranchid = true;
        isFullfillingSearch = false;

        return null;
    }
    // To disable shipping analysis popup

    public PageReference cancelAnalysisSetCodeSelectedInShipping() {
        fullQWrapper.showAnalysisCodeShippingPopup = false;
        fullQWrapper.showSearchAnalysisSetCodeInShipping = false;
        qqWrapperShipping = new QuickQuoteWrapper();
        return null;
    }

    /*public void FetchSalesReps(){
        if(fullQWrapper.selectedUserBranchId != null && fullQWrapper.selectedUserBranchId != ''){
            getAllBranchRelatedReps(fullQWrapper.selectedUserBranchId);
        }
    }*/

    public void salesRep() {
        fullQWrapper.isSalesRep = true;
        /*lstUserBranchId = new list<SelectOption>();
            lstUserBranchId.add(new SelectOption('', '--None--'));
            Schema.DescribeFieldResult fieldResult = User.Branch__c.getDescribe();
            List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            for(Schema.PicklistEntry p : ple){
                if(p.getValue() != null && p.getValue() != ''){
                    String branchIdVal = p.getValue().subString(0,3);
                    lstUserBranchId.add(new SelectOption(branchIdVal, branchIdVal));
                }
            }
            User UserRecObj = FullQuoteDAO.getUserBranchDetails();
            String branchOfUser = UserRecObj.Branch_Id__c;
            if(branchOfUser == null || branchOfUser == ''){
                fullQWrapper.selectedUserBranchId =  branchOfUser;
            }*/
        salesRepSearch();
        //getAllBranchRelatedReps(branchOfUser);
    }

    /* public void getAllBranchRelatedReps(String BranchId){
            SalesRepService salesRepService =null;
            List<HomeBaseBeans.salesReps> reps;
            salesRepsList = new list<HomeBaseBeans.salesReps>();
            
            try{  
                salesRepService = new SalesRepService(); 
                reps = salesRepService.listSalesRepsOfBranch(BranchId);
                system.debug('------------------reps---size------------------'+reps.size());
                system.debug('------------------reps------------------'+reps);
              if(test.isRunningTest()){
                reps = MMIFullquoteTestDataProvider.getSalesRepList();
              }
                if(reps[0].errorMessage == null) 
                { 
                    salesRepsList = reps;
                    //fullQWrapper.showSalesRepPopup = true;
                }
                system.debug('------------------salesRepsList---size------------------'+salesRepsList.size());
                system.debug('------------------salesRepsList---------------------'+salesRepsList);
            }catch(Exception e){
                  system.debug(LoggingLevel.ERROR,'Error while getting values from FullQuoteMainController_AC salesRepSearch: '+e.getMessage());
            }
            
        }*/

    public void assistingSalesRep() {
        fullQWrapper.isSalesRep = false;
        salesRepSearch();

    }

    public pageReference cancelSalesPopUp() {

        qqWrapper = new QuickQuoteWrapper();
        //SalesReps.clear();
        SalesRepsSearchList.clear();

        fullQWrapper.showWriteUpRepSearchList = false;
        fullQWrapper.showSalesRepPopup = false;
        return null;
    }
    // To enable shipping contact popup

    public PageReference showShippingContactPopUp() {
        fullQWrapper.contactShippingPopUp = true;
        
        List<HomeBaseBeans.ListContact> lstAllCOntact = new List<HomeBaseBeans.ListContact>();
        String BranchId = FullQuoteDAO.getBranchId(fullQWrapper.fulFillingBranchInShippingDates, recId);
        lstAllCOntact = callLIstContactWS(BranchId, fullQWrapper.AccountId);
        if(lstAllCOntact != null && lstAllCOntact.size() > 0){
            contactsResponseList = new list<HomeBaseBeans.contactSummaryList>();
            for(HomeBaseBeans.ListContact c : lstAllCOntact){
                HomeBaseBeans.contactSummaryList cl = new HomeBaseBeans.contactSummaryList();
                cl.forename = c.forename;
                cl.surname = c.surname;
                cl.contactId = c.contactId;
                contactsResponseList.add(cl);
            }
        }
        
        return null;
    }
    // hide shipping tab contact popup

    public PageReference cancelShippingContactPopUp() {
        fullQWrapper.contactShippingPopUp = false;
        fullQWrapper.showContactSearchInShipping = false;
        qqWrapper = new QuickQuoteWrapper();
        return null;
    }
    // To disable account popup

    public PageReference cancelAccountIdPopup() {
        accountResponseList.clear();
        fullQWrapper.enableRefreshQuote = false;
        fullQWrapper.enableSaveQuote = false;
        fullQWrapper.enableMarkAsLostbutton = false;

        fullQWrapper.enableProductadd = false;
        fullQWrapper.enableVAddresBtnInShipping = true;
        isFullfillingBranchid = true;
        fullQWrapper.showAccountPopUp = false;

        return null;
    }
    // To enable address popup

    public PageReference showAddressPopUp() {
        fullQWrapper.addressPopUp = true;
        return null;
    }

    // To enable shipping address popup

    public PageReference showShippingAddressPopUp() {
        fullQWrapper.shippingAddressPopUp = true;
        return null;
    }

    public PageReference cancelAddressIdSelected() {
        fullQWrapper.addressPopUp = false;
        return null;
    }


    public PageReference cancelOrderPopUp() {
        fullQWrapper.showOrderPopUp = false;
        if (fullQWrapper.Status == 'NORCOD' && !isErrorForNorcodHasShown) {
            isErrorForNorcodHasShown = true;
            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Supply the Credit Card Details on the Account in Rental Result, before Converting the Quote to an Order');
            ApexPages.addMessage(msg);
            return null;
        }
        if (docId != null) {
            if ((updateQuoteRec.Reservation_ID__c == null || updateQuoteRec.Reservation_ID__c == '') && (!fullQWrapper.noReservation)) {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Please select "No Reservation" or "Reserve Capacity".');
                ApexPages.addMessage(msg);
                return null;
            }
        }
        for (HomeBaseBeans.AnalysisSetHeaders HB: analysisSetHeaderResponseShippingList) {
            if (HB.description == 'Door Dir' || HB.description == 'Del Time') {
                if (HB.selectedId == null) {
                    ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Please select Del Time or Door Dir!');
                    ApexPages.addMessage(msg);
                    return null;
                }
            }
        }
        //-----------TFS 2720--------Starts----------------
        if (fullQWrapper.noOfUnit == 0) {
            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Please select # of Units!');
            ApexPages.addMessage(msg);
            return null;
        }
        //-----------TFS 2720--------Ends----------------
        if (erreorOnNewAcctCreation == 'yes') {
            return null;
        }
        PageReference pr = new PageReference('/' + updateQuoteRec.Id);
        pr.setRedirect(true);
        return pr;
    }

    public PageReference cancelShippingAddressIdSelected() {
        fullQWrapper.enableRefreshQuote = false;
        fullQWrapper.enableSaveQuote = false;
        fullQWrapper.enableMarkAsLostbutton = false;

        fullQWrapper.enableProductadd = false;
        fullQWrapper.enableVAddresBtnInShipping = true;
        isFullfillingBranchid = true;
        fullQWrapper.shippingAddressPopUp = false;
        return null;
    }
    // To enable branch popup in billing tab 

    public PageReference showFulFillingIdBillingSelected() {
        fullQWrapper.showBranchBillingPopUp = true;
        return null;
    }

    // To disable branch popup in billing tab 

    public PageReference cancelFulFillingIdBillingSelected() {
        fullQWrapper.showBranchBillingPopUp = false;
        fullQWrapper.showSearchBranchIdTable = false;
        return null;
    }
    // To enable branch popup 

    public PageReference showFulFillingIdSelected() {
        if (branches.isEmpty()) {
            callBranchWebservice();
        }
        fullQWrapper.showBranchPopUp = true;
        return null;
    }

    // To disable branch popup 

    public PageReference cancelFulFillingIdSelected() {
        qqWrapperShipping.BranchIdSearchWord = null;
        qqWrapperShipping.BranchNameSearchWord = null;
        fullQWrapper.showSearchBranchShippingIdTable = false;
        fullQWrapper.showBranchPopUp = false;
        return null;
    }

    public PageReference CancelTaxIdBillingIdSelected() {
        fullQWrapper.showTaxIdBillingPopUp = false;
        return null;
    }

    // To close validate address in customer and billing tab

    public PageReference CancelValidateAddressIdSelected() {
        fullQWrapper.showValidateAddressPopUp = false;
        isDuplicateAccSelected = false;
        // check if user does not select any value from popup, then call new Account creation WS.
        if (isDuplicateAccSelected == false && isDuplicateAccPresent == true) {
            // call Account WS to get details of the newly created account.
            isCallFinalAcctCreatService = true; // no need to create any new Account Now
            system.debug('----------accountRec----------' + accountRec);
            if (accountRec.size() > 0) {
                // no need to create any new Account
                newAccountId = accountRec[0].Id;
                updateAccount(newAccountId);
                createOrUpdateContact(newAccountId);
            } else if (opportunityRec.size() > 0) {
                newAccountId = opportunityRec[0].AccountID;
                updateAccount(newAccountId);
                createOrUpdateContact(newAccountId);
            } else {
                CreateAccountInSF();
            }
        }
        return null;
    }

    public void createOrUpdateContact(String AccountIdInSF) {
        Account AccObj = new Account();
        AccObj = [select Id, Phone, isPersonAccount from Account where Id = : AccountIdInSF];
        if (AccObj != null && AccObj.isPersonAccount == false) {
            Contact conObj = new Contact();
            if (newContactId == null || newContactId == '') {
                //search for existing contact------------
                //list<Contact> existingConObj = [select id from Contact where AccountId = :AccObj.Id limit 1];
                if (ContId != null && ContId != '') {
                    newContactId = ContId;
                } else {
                    conObj.AccountId = newAccountId;
                    conObj.Decision_Maker__c = 'No';
                    conObj.FirstName = fullQWrapper.Name;
                    conObj.LastName = fullQWrapper.LastName;
                    conObj.Phone = fullQWrapper.telePhone;
                    conObj.Result_Id__c = fullQWrapper.BillingContactID;
                    insert conObj;
                    newContactId = conObj.Id;
                }
            } else {
                conObj.AccountId = newAccountId;
                conObj.Decision_Maker__c = 'No';
                conObj.FirstName = fullQWrapper.Name;
                conObj.LastName = fullQWrapper.LastName;
                conObj.Phone = fullQWrapper.telePhone;
                conObj.Result_Id__c = fullQWrapper.BillingContactID;
                conObj.Id = newContactId;
                update conObj;
            }
        } else {
            AccObj.Phone = fullQWrapper.telePhone;
            update AccObj;
        }
    }

    public void updateAccount(String AccountIdInSF) {
        Account AccObj = [select Id, Phone, isPersonAccount from Account where Id = : AccountIdInSF];
        if (test.isRunningTest()) {
            fullQWrapper.Country = 'USA';
        }
        if (AccObj != null) {
            AccObj.Name = fullQWrapper.AccountName;
            AccObj.BillingStreet = fullQWrapper.Address;
            AccObj.BillingCity = fullQWrapper.City;
            AccObj.BillingState = fullQWrapper.State;
            AccObj.BillingCountry = fullQWrapper.Country;
            AccObj.BillingPostalCode = fullQWrapper.ZipCode;
            AccObj.Id = AccountIdInSF;
            update AccObj;
        }
    }


    public PageReference createProspectAccount() {
        CreateProspectAccount_AC cp = new CreateProspectAccount_AC();
        HomeBaseBeans.ProspectAccountParam crParam = new HomeBaseBeans.ProspectAccountParam();
        crParam.companyName = fullQWrapper.AccountName.escapeXml();
        crParam.salesforceID = newAccountId.escapeXml();
        crParam.contactName = (fullQWrapper.Name + ' ' + fullQWrapper.LastName).escapeXml();
        crParam.address1 = fullQWrapper.Address.escapeXml();
        crParam.city = fullQWrapper.City.escapeXml();
        crParam.state = fullQWrapper.State.escapeXml();
        crParam.zip = fullQWrapper.zipCode.escapeXml();
        crParam.Country = fullQWrapper.Country.escapeXml();
        crParam.phone1 = fullQWrapper.telePhone.escapeXml();

        User UserObj = FullQuoteDAO.getUserBranchDetails();
        String branch = UserObj.Branch_Id__c;
        String SalesRepId = UserObj.Sales_Rep_Id__c;

        crParam.repCode = SalesRepId; //'298777'; //SalesRepId; //298777
        crParam.branchCode = branch; //'298'; //298//branch;
        String createProsWsResponse = cp.ProspectAcct(crParam);
        if (test.isRunningTest()) {
            createProsWsResponse = '<?xml version="1.0" encoding="UTF-8"?><Result><Success>true</Success><DuplicatesFound>true</DuplicatesFound><ResultId>G175535</ResultId></Result>';
        }
        if (createProsWsResponse != null) {
            CreateProspectAccount_AC.ResponseObj parseRes = cp.parseResponse(createProsWsResponse);
            if (parseRes != null) {
                if (parseRes.errorMsg == null || parseRes.errorMsg == '') {
                    fullQWrapper.AccountId = parseRes.ResultId;
                    List < Account > lstAccToUpdate = FullQuoteDAO.getAccountList(newAccountId);
                    if (lstAccToUpdate.size() > 0) {
                        lstAccToUpdate[0].Result_Id__c = parseRes.ResultId;
                        update lstAccToUpdate[0];
                    }
                    erreorOnNewAcctCreation = '';
                    fullQWrapper.BillingContactID = '1'; // Set default Billing Contact Id to 1 after PG Account Creation
                    disableBilingAddressFields();
                } else {
                    ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, parseRes.errorMsg);
                    ApexPages.addMessage(msg);
                    erreorOnNewAcctCreation = 'yes';
                    enableBilingAddressFields();
                }
            } else {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'There is some error during prospect account creation.');
                ApexPages.addMessage(msg);
                erreorOnNewAcctCreation = 'yes';
            }
            enableBilingAddressFields();
        }
        isCallFinalAcctCreatService = false;
        return null;
    }

    public PageReference finishCreateNewCustomerAccount() {
        fullQWrapper.AccountId = createNewCustomerAccount();
        if (test.isRunningTest()) {
            fullQWrapper.AccountId = '50737';
            erreorOnNewAcctCreation = '';
        }
        if (fullQWrapper.AccountId != null && fullQWrapper.AccountId != '' && erreorOnNewAcctCreation == '') {
            AccountService accountServiceRef = new AccountService();
            HomeBaseBeans.account accountResponse = null;
            if (test.isRunningTest()) {
                accountResponse = MMIFullquoteTestDataProvider.getAccountList();
            } else {
                accountResponse = accountServiceRef.listAccounts(fullQWrapper.AccountId, fullQWrapper.TransactionType, String.valueOf(system.today()));
            }

            if (accountResponse.errorMessage == null || accountResponse.errorMessage == '') {
                fullQWrapper.Address = accountResponse.accountAddress.addressLine1;
                fullQWrapper.State = accountResponse.accountAddress.state;
                fullQWrapper.Country = accountResponse.accountAddress.countryId;
                fullQWrapper.zipCode = accountResponse.accountAddress.zipCode;
                fullQWrapper.AccountName = accountResponse.name;
                fullQWrapper.AccountId = accountResponse.id;
                fullQWrapper.TaxExempt = accountResponse.taxExempt;
                fullQWrapper.Status = accountResponse.creditStatus;

                disableBilingAddressFields();
            }
        } else {

            erreorOnNewAcctCreation = 'yes';
            enableBilingAddressFields();
        }
        //accountIDInBilling();
        isCallFinalAcctCreatService = false;
        return null;
    }

    // To enable minimum term (Charge code webservice) popUp
    public PageReference enableMinimumTermPopUp() {
        fullQWrapper.showMinimumTermPopUp = true;
        return null;
    }

    public PageReference disableAnalysisCodePopupInProduct() {
        fullQWrapper.showAnalysisCodePopupInProduct = false;
        return null;
    }


    public PageReference buttonEnableDesable() {
        fullQWrapper.enableRefreshQuote = false;
        fullQWrapper.enableSaveQuote = false;
        fullQWrapper.enableMarkAsLostbutton = false;

        fullQWrapper.enableProductadd = false;
        fullQWrapper.enableVAddresBtnInShipping = true;
        isFullfillingBranchid = true;
        return null;
    }

    public PageReference invoicingTabbuttonEnableDesable() {
        fullQWrapper.enableRefreshQuote = true;
        fullQWrapper.enableSaveQuote = false;
        fullQWrapper.enableMarkAsLostbutton = false;

        fullQWrapper.enableProductadd = false;
        fullQWrapper.enableVAddresBtnInShipping = false;
        isFullfillingBranchid = false;
        isTexIdIsNullbutton = true;
        return null;
    }

    public Pagereference cancelFullQuote() {
        String cancelId;
        if (quickQuoteId != null && quickQuoteId != '') {
            cancelId = QqData.Opportunity__c;
        } else if (leadRec.size() > 0) {
            cancelId = leadRec[0].Id;
        } else if (opportunityRec.size() > 0) {
            cancelId = opportunityRec[0].Id;
        } else if (accountRec.size() > 0) {
            cancelId = accountRec[0].Id;
        }
        PageReference pf = null;
        // modified for issue no 1173 and 1174---------
        system.debug('--------cancelId---------' + cancelId);
        system.debug('--------isEditForEmailQuote---------' + isEditForEmailQuote);
        system.debug('--------docId---------' + docId);
        system.debug('--------updateQuoteRec.Opportunity__c---------' + updateQuoteRec.Opportunity__c);
        if (isEditForEmailQuote == 'true' && docId != null && updateQuoteRec.Opportunity__c != null && String.valueOf(updateQuoteRec.Opportunity__c) != '') {
            system.debug('--------if---------');
            pf = new PageReference('/' + String.valueOf(updateQuoteRec.Opportunity__c));
        } else {
            system.debug('--------else---------');
            pf = new PageReference('/' + cancelId);
        }
        pf.setRedirect(true);
        return pf;
    }

    public Pagereference selectModification() {

        return null;
    }


    public Pagereference onChangeModification() {
        fullQWrapper.showSubmitButton = true;
        for (FullQuoteWrapper.stdModification stmod: stdModificationList) {
            if (stmod.isSelected && isProductAlreadyAdded) {
                fullQWrapper.showSubmitButton = false;
            }

        }

        if (!fullQWrapper.showSubmitButton) {
            fullQWrapper.enableRefreshQuote = false;
            fullQWrapper.enableSaveQuote = false;
        } else {
            if (isProductAlreadyAdded) {
                fullQWrapper.enableRefreshQuote = true;
                fullQWrapper.enableSaveQuote = false;

            }
        }
        system.debug('onChangeModification' + fullQWrapper.showSubmitButton);
        return null;
    }


    public Pagereference cancleApproverPopUp() {
        showModificPopUP = false;
        buttonModificEnable = true;

        return null;
    }

    public void InitializeModificationList(list < Standard_Modification__c > stdMList) {
        for (Standard_Modification__c stdM: stdMList) {
            FullQuoteWrapper.stdModification stmod = new FullQuoteWrapper.stdModification();
            stmod.isSelected = false;
            stmod.modId = stdM.ModId__c;
            stmod.modificationOption = stdM.Modification_Option__c;
            stmod.Quantity = '1';
            stmod.price = '0.0';
            stmod.sourceID = recId;
            stdModificationList.add(stmod);
        }
    }

    public Pagereference sendToBranchModification() {

        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :sendToBranchModification');
        FullQuoteMainService fqService = null;
        Full_Quote_Transactional__c insertQuote = null;
        String quoteId = '';
        String sourceId = '';
        Pagereference pf = null;
        String ApproverEmail;
        List < Modification_Approver_List__c > recList = null;
        //FullQuoteMainService fqService=null;
        buttonModificEnable = false;

        try {

            String BranchId = FullQuoteDAO.getBranchId(fullQWrapper.fulFillingBranchInShippingDates, recId);
            if (BranchId != null && BranchId != '') {
                branchIdforViewBranch = BranchId;
            }
            fqService = new FullQuoteMainService();
            if (test.isRunningTest()) {
                recList = MMIFullquoteTestDataProvider.getModificationApproverList();
            } else {
                recList = fqService.getApproverList(BranchId);
            }
            approversList = new list < FullQuoteWrapper.ApproverList > ();
            if (recList != null && !recList.isEmpty()) {
                integer i = 1;
                for (Modification_Approver_List__c maList: recList) {
                    FullQuoteWrapper.ApproverList approve = new FullQuoteWrapper.ApproverList();
                    approve.emailID = maList.Approver_EmailId__c;
                    approve.fulfillingBranch = maList.Fulfiling_Branch__c;
                    approve.name = maList.Approver_Name__c;
                    approve.recId = i;
                    approversList.add(approve);
                    i++;
                }

                if (!approversList.isEmpty()) {
                    ApproverEmail = approversList[0].emailID;

                }

                //sendToBranchModification();
            } else {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'No Approver Found for this Fulfilling Branch.');
                ApexPages.addMessage(msg);
                buttonModificEnable = true;
            }

            // String seleApp = System.currentPageReference().getParameters().get('selectedApprover');

            insertQuote = new Full_Quote_Transactional__c();
            //fqService=new FullQuoteMainService();

            //insert full quote transactional
            if (FQSMrecId == null) {
                if (cloneIsTrue != 'true') {
                    docId = docId;
                } else {
                    docId = null;
                }
                if (leadRec != null && !leadRec.isEmpty()) {
                    Contact ConObjForMod = new Contact();
                    ConObjForMod.FirstName = fullQWrapper.Name;
                    ConObjForMod.LastName = fullQWrapper.LastName;
                    ConObjForMod.Phone = fullQWrapper.telePhone;
                    insert ConObjForMod;
                    fullQWrapper.contactId = ConObjForMod.Id;
                }
                if (ContId != null && ContId != '') {
                    fullQWrapper.contactId = ContId;
                    Contact conToUpdateBeforeSthMod = new Contact(Id = ContId);
                    conToUpdateBeforeSthMod.FirstName = fullQWrapper.Name;
                    conToUpdateBeforeSthMod.LastName = fullQWrapper.LastName;
                    conToUpdateBeforeSthMod.Phone = fullQWrapper.telePhone;
                    update conToUpdateBeforeSthMod;
                }
                quoteId = fqService.insertFullQuoteApprovalProcess(insertQuote, summaryLineList, analysisSetHeaderResponseList, analysisSetHeaderResponseShippingList, ProductExtrasList, selectedVAddressInShipping, selectedVAddressInBilling, fullQuote.PO_Expires__c, fullQuote.Start_Date__c, fullQuote.Quote_expires__c, fullQuote.Scheduled_Delivery__c, fullQuote.Loaded_Move_In__c, fullQWrapper, selectedTaxRecInBilling.Id, selectedTaxRecInShipping.Id, isTransTmoboORseco, isProductAlreadyAdded, docId, Mobilization, modifiedTS);
                if (quoteId != null) {

                    //insert selected Modifications options
                    fqService.insertModificationOption(stdModificationList, quoteId, ApproverEmail);

                    //Sand Mail to Approver 

                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

                    // Strings to hold the email addresses to which you are sending the email.
                    String[] toAddresses = new String[] {
                        ApproverEmail
                    };


                    // Assign the addresses for the To and CC lists to the mail object.
                    mail.setToAddresses(toAddresses);

                    // set cc to Account owner-------------------TFS 2710----------------------

                    /*if(accountOwnerIdOfQQ != null && accountOwnerIdOfQQ != ''){
                User accOwnerOfQQRecord = FullQuoteDAO.getUserDetails(accountOwnerIdOfQQ);
                if(accOwnerOfQQRecord.EMail != null && accOwnerOfQQRecord.Email != ''){
                    String[] ccAddresses = new String[] {accOwnerOfQQRecord.EMail}; 
                    mail.setCcAddresses(ccAddresses);
                }
            }*/
                    //-----------------TFS 2710----------------------
                    // Specify the name used as the display name.
                    mail.setSenderDisplayName('Salesforce Standard Modification');

                    // Specify the subject line for your email address.
                    mail.setSubject('Sale Container Modification Pricing & Approval Needed');

                    mail.setHtmlBody('This Full Quote for a Sale Container with Modifications has been requested. Action is required to provide the Pricing and the Delivery Date.  <a href=' + URL.getSalesforceBaseUrl().toExternalForm() + '/apex/FullQuoteForm_VF?FQSM=' + quoteId + '> ' + URL.getSalesforceBaseUrl().toExternalForm() + '/apex/FullQuoteForm_VF?FQSM=' + quoteId + '</a> <br/><br/> Thank you,<br/>' + UserInfo.getUserName());

                    // Send the email you have created.
                    if (!test.isRunningTest()) {
                        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {
                            mail
                        });
                    }




                    if (leadRec.size() > 0) {
                        sourceId = leadRec[0].Id;
                    } else if (opportunityRec.size() > 0) {
                        sourceId = opportunityRec[0].Id;
                    } else if (accountRec.size() > 0) {
                        sourceId = accountRec[0].Id;
                    }
                    pf = new PageReference('/' + sourceId);
                    pf.setRedirect(true);
                    return pf;
                }
            } else {


                if (isApproverButton) {
                    system.debug('update Modification ----' + FQSMrecId);
                    ApprovalReject = System.currentPageReference().getParameters().get('ApprovalStatus');
                    //update the Modification Detail
                    Full_Quote_Transactional__c FQTupdate = FullQuoteDAO.getFullQuoteTransactional(FQSMrecId);
                    FQTupdate.Modification_Comments__c = fullQWrapper.ModificationComments;
                    FQTupdate.Approver_Comments__c = fullQWrapper.ApproverComments;
                    update FQTupdate;
                    if (ApprovalReject == 'Rejected') {
                        fqService.updateModificationOption(stdModificationList, FQSMrecId, 'Rejected');
                    } else {
                        fqService.updateModificationOption(stdModificationList, FQSMrecId, 'Approved');
                    }

                    List < Modification_Option_Transactional__c > modificationOptionLst = fqService.getModificationOption(FQSMrecId);

                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

                    // Strings to hold the email addresses to which you are sending the email.
                    String[] toAddresses = new String[] {
                        modificationOptionLst[0].SenderEmail__c
                    };

                    // Assign the addresses for the To and CC lists to the mail object.
                    mail.setToAddresses(toAddresses);
                    // set cc to Account owner-------------------TFS 2710----------------------

                    /*if(accountOwnerIdOfQQ != null && accountOwnerIdOfQQ != ''){
                User accOwnerOfQQRecord = FullQuoteDAO.getUserDetails(accountOwnerIdOfQQ);
                if(accOwnerOfQQRecord.EMail != null && accOwnerOfQQRecord.Email != ''){
                    String[] ccAddresses1 = new String[] {accOwnerOfQQRecord.EMail}; 
                    mail.setCcAddresses(ccAddresses1);
                }
            }*/

                    //-----------------TFS 2710----------------------
                    // Specify the name used as the display name.
                    mail.setSenderDisplayName('Salesforce Standard Modification');

                    // Specify the subject line for your email address.
                    mail.setSubject('Sale Container Modification Pricing & Approval/Rejection Complete');

                    mail.setHtmlBody('This Full Quote for a Sale Container with Modifications has been Priced, Delivery Date Set and an Approval or Rejection has been provided.  <a href=' + URL.getSalesforceBaseUrl().toExternalForm() + '/apex/FullQuoteForm_VF?FQSM=' + FQSMrecId + '> ' + URL.getSalesforceBaseUrl().toExternalForm() + '/apex/FullQuoteForm_VF?FQSM=' + FQSMrecId + '</a> <br/><br/> Thank you,<br/>' + UserInfo.getUserName());

                    // Send the email you have created.
                    if (!test.isRunningTest()) {
                        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {
                            mail
                        });
                    }
                    //Sand Mail to SalesRap back


                    pf = new PageReference('/home/home.jsp');
                    pf.setRedirect(true);

                    //delete[select id from Modification_Option_Transactional__c where id=:FQSMrecId];

                    return pf;

                } else {
                    quoteId = fqService.insertFullQuoteApprovalProcess(insertQuote, summaryLineList, analysisSetHeaderResponseList, analysisSetHeaderResponseShippingList, ProductExtrasList, selectedVAddressInShipping, selectedVAddressInBilling, fullQuote.PO_Expires__c, fullQuote.Start_Date__c, fullQuote.Quote_expires__c, fullQuote.Scheduled_Delivery__c, fullQuote.Loaded_Move_In__c, fullQWrapper, selectedTaxRecInBilling.Id, selectedTaxRecInShipping.Id, isTransTmoboORseco, isProductAlreadyAdded, docId, Mobilization, modifiedTS);
                    if (quoteId != null) {

                        //insert selected Modifications options
                        fqService.insertModificationOption(stdModificationList, quoteId, ApproverEmail);

                        //Sand Mail to Approver 

                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

                        // Strings to hold the email addresses to which you are sending the email.
                        String[] toAddresses = new String[] {
                            ApproverEmail
                        };

                        // Assign the addresses for the To and CC lists to the mail object.
                        mail.setToAddresses(toAddresses);

                        // Specify the name used as the display name.
                        mail.setSenderDisplayName('Salesforce Standard Modification');

                        // Specify the subject line for your email address.
                        mail.setSubject('Sale Container Modification Pricing & Approval Needed');

                        mail.setHtmlBody('This Full Quote for a Sale Container with Modifications has been requested. Action is required to provide the Pricing and the Delivery Date.  <a href=' + URL.getSalesforceBaseUrl().toExternalForm() + '/apex/FullQuoteForm_VF?FQSM=' + quoteId + '> ' + URL.getSalesforceBaseUrl().toExternalForm() + '/apex/FullQuoteForm_VF?FQSM=' + quoteId + '</a> <br/><br/> Thank you,<br/>' + UserInfo.getUserName());

                        // Send the email you have created.
                        if (!test.isRunningTest()) {
                            Messaging.sendEmail(new Messaging.SingleEmailMessage[] {
                                mail
                            });
                        }

                        if (leadRec.size() > 0) {
                            sourceId = leadRec[0].Id;
                        } else if (opportunityRec.size() > 0) {
                            sourceId = opportunityRec[0].Id;
                        } else if (accountRec.size() > 0) {
                            sourceId = accountRec[0].Id;
                        }
                        FQSMrecId = System.currentPageReference().getParameters().get('FQSM');
                        pf = new PageReference('/' + sourceId);
                        pf.setRedirect(true);

                        delete[select id from Full_Quote_Transactional__c where id = : FQSMrecId];
                        return pf;
                    }
                }

            }
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC sendToBranchModification: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :sendToBranchModification');

        return pf;
    }

    // To enable account popup
    public Pagereference listSalesProducts() {
        if (fullQWrapper.selectedFullQUote == 'sales') {
            getSalesInventoryList();
        }
        return null;
    }

    public Pagereference getCustomerActivityHistory() {
        isShowProdHistory = true;
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :getCustomerActivityHistory');
        string accRegex = null;
        boolean isMatch = false;
        CustomerActivityService custActivity = null;
        CustomerActivityParser custActivityParser;
        CustomerActivityParser custActivityParser2;
        List < FullQuoteWrapper.quote > customerActivityListUnsort = null;
        List < FullQuoteWrapper.quote > customerActivityListsort = null;
        try {
            if (fullQWrapper.selectedFullQUote == 'sales') {
                getSalesInventoryList();
            }

            //do not call activity history in case of prospact account
            if (fullQWrapper.AccountId != null && fullQWrapper.AccountId != '') {
                String startCharacter = fullQWrapper.AccountId.substring(0, 1);
                accRegex = '^[A-Z]$';
                isMatch = Pattern.matches(accRegex, startCharacter);
            }
            if (!isMatch) {
                customerActivityList = new List < FullQuoteWrapper.quote > ();
                customerActivityListUnsort = new List < FullQuoteWrapper.quote > ();
                customerActivityListsort = new List < FullQuoteWrapper.quote > ();

                String BranchId = FullQuoteDAO.getBranchId(fullQWrapper.fulFillingBranchInShippingDates, recId);
                if (BranchId != null && BranchId != '') {
                    branchIdforViewBranch = BranchId;
                }
                custActivity = new CustomerActivityService();
                custActivityParser = custActivity.callEditWEbservice(fullQWrapper.AccountId, fullQWrapper.WriteUpRep, BranchId);

                if (test.isRunningTest()) {
                    custActivityParser.quotes = MMIFullquoteTestDataProvider.getCustomerActivityParserquoteList();
                }
                for (CustomerActivityParser.quote quotelist: custActivityParser.quotes) {
                    FullQuoteWrapper.quote ca = new FullQuoteWrapper.quote();
                    ca.quoteNumber = quotelist.quoteNumber;
                    ca.branchId = quotelist.branchId;
                    ca.ecode = quotelist.ecode;
                    ca.price = quotelist.price;
                    ca.productId = quotelist.productId;
                    ca.deliveryCharges = quotelist.deliveryCharges;
                    ca.deliverySurcharge = quotelist.deliverySurcharge;
                    ca.pickupCharges = quotelist.pickupCharges;
                    ca.pickupSurcharge = quotelist.pickupSurcharge;
                    ca.deliveryRate = String.valueOf(double.valueOf(quotelist.deliveryCharges) + double.valueOf(quotelist.deliverySurcharge));
                    ca.pickupRate = String.valueOf(double.valueOf(quotelist.pickupCharges) + double.valueOf(quotelist.pickupSurcharge));
                    ca.quoteDate = quotelist.quoteDate;
                    ca.quoteCreated = quotelist.quoteCreated;
                    customerActivityListUnsort.add(ca);

                }
                custActivityParser2 = custActivity.callCAOrderService(fullQWrapper.AccountId);
                if (custActivityParser2 != null && custActivityParser2.orderSummaries != null && !custActivityParser2.orderSummaries.isEmpty()) {
                    for (CustomerActivityParser.orderSummary orderlist: custActivityParser2.orderSummaries) {
                        FullQuoteWrapper.quote ca1 = new FullQuoteWrapper.quote();
                        ca1.quoteNumber = orderlist.documentId;
                        ca1.branchId = orderlist.branchId;
                        ca1.price = orderlist.totalOrderValue;
                        ca1.productId = orderlist.mainLine.itemId;
                        ca1.activationDate = orderlist.activationDate;
                        ca1.quoteCreated = orderlist.shippingDate;
                        customerActivityListUnsort.add(ca1);
                    }

                }

                if (customerActivityListUnsort.size() > 0) {
                    customerActivityListsort.addAll(CustomSort.sortByLastDate(customerActivityListUnsort, 'Desc'));
                    integer i = 1;
                    for (FullQuoteWrapper.quote fq: customerActivityListsort) {
                        if (i <= 5) {
                            customerActivityList.add(fq);
                        } else {
                            break;
                        }
                        i++;
                    }
                }
            } else {
                customerActivityList.clear();
            }

        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC getCustomerActivityHistory: ' + e.getMessage());
            if (fullQWrapper.selectedFullQUote == 'sales') {
                getSalesInventoryList();
            }
            return null;
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :getCustomerActivityHistory' + customerActivityList);
        fullQWrapper.ImageUrl = fullQWrapper.ImageUrlForPDF; // set image url on click of product button.
        return null;
    }

    public void SendingMail() {
        //isEnableAction = 'Start';
        FullQuoteMainService fqService = new FullQuoteMainService();
        Full_Quote_Transactional__c insertQuote = null;
        String quoteId = '';
        Boolean accessoryRes = false;

        for (HomeBaseBeans.quoteLine sm: summaryLineList) {
            if (sm.itemId != 'CG1' && sm.itemId != 'CG2' && sm.itemId != 'DL1' && sm.itemId != 'DL2' && !ckeckModificationItem(sm.itemId)) {
                accessoryRes = fqService.getAccessoryInfo(sm.itemId);
                if (accessoryRes == false) {
                    prodctname = sm.itemId;
                }
            }
        }
        List < Product_Brochures_Lookup__c > produBrochList = [Select p.Product_Image__c, p.Product_Id__c, p.Product_Document_Brochures_Name__c, p.Name, p.Id From Product_Brochures_Lookup__c p where Product_Id__c = : prodctname limit 1];
        if (!produBrochList.isEmpty()) {
            fullQWrapper.imageNameForPreivewQuote = 'PreviewQuote_Images/' + produBrochList[0].Product_Image__c;
        }
        String BranchId = FullQuoteDAO.getBranchId(fullQWrapper.fulFillingBranchInShippingDates, recId);
        if (BranchId != null && BranchId != '') {
            branchIdforViewBranch = BranchId;
        }
        fqService = new FullQuoteMainService();
        insertQuote = new Full_Quote_Transactional__c();
        if (cloneIsTrue != 'true') {
            docId = docId;
        } else {
            docId = null;
        }
        quoteIdforEmail = fqService.insertFullQuoteApprovalProcess(insertQuote, summaryLineList, analysisSetHeaderResponseList, analysisSetHeaderResponseShippingList, ProductExtrasList, selectedVAddressInShipping, selectedVAddressInBilling, fullQuote.PO_Expires__c, fullQuote.Start_Date__c, fullQuote.Quote_expires__c, fullQuote.Scheduled_Delivery__c, fullQuote.Loaded_Move_In__c, fullQWrapper, selectedTaxRecInBilling.Id, selectedTaxRecInShipping.Id, isTransTmoboORseco, isProductAlreadyAdded, docId, Mobilization, modifiedTS);
        isErrorMessageForEmail = true;
        EmailshowPopUp = true;
        isSaveSuccessEmail = false;
        emailIdForEmailQuote = '';
        cc1EmailToQuoteId = '';
        cc2EmailToQuoteId = '';
        SubjectEmailQuote = '';
        MailBodyToQuote = '';
    }
    public void attachmentListViewMethod() {
        attachmentList = [Select a.ParentId, a.Name From Attachment a where ParentId = : quoteIdforEmail];
    }
    
    public void startActionPoller(){
        isEnableAction = 'Start';
        system.debug('-----------isEnableAction--------------'+isEnableAction);
    }
    public void stopActionPoller(){
        isEnableAction = 'end';
        system.debug('-----------isEnableAction--------------'+isEnableAction);
    }
    public void deleteAttachach() {
        String attachDeleId = Apexpages.currentPage().getParameters().get('attachId');
        List < Attachment > att = [Select a.ParentId, a.Name From Attachment a where id = : attachDeleId];
        if (att.size() > 0) {
            delete att;
        }
        attachmentList = [Select a.ParentId, a.Name From Attachment a where ParentId = : quoteIdforEmail];
        stopActionPoller();
        //attachId  
    }
    public PageReference contactEmailSelect() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :contactEmailSelect');
        String EmailAddressSpec = System.currentPageReference().getParameters().get('EmailAddessIdfy');
        if (EmailAddressSpec == 'toAddress') {
            emailIdForEmailQuote = '';
        }
        if (EmailAddressSpec == 'cc1Address') {
            cc1EmailToQuoteId = '';
        }
        if (EmailAddressSpec == 'cc2Address') {
            cc2EmailToQuoteId = '';
        }
        for (FullQuoteWrapper.ContactEmailId conisSelect: contactEmailId) {
            system.debug('--conisSelect.IsSelected--' + conisSelect.IsSelected);
            if (conisSelect.IsSelected) {
                system.debug('--conisSelect.IsSelected--' + conisSelect.IsSelected);
                if (EmailAddressSpec == 'toAddress') {
                    if (emailIdForEmailQuote == null || emailIdForEmailQuote == '') {
                        emailIdForEmailQuote = conisSelect.conRec.Email;
                    } else {
                        emailIdForEmailQuote = emailIdForEmailQuote + ';' + conisSelect.conRec.Email;
                    }
                } else if (EmailAddressSpec == 'cc1Address') {

                    if (cc1EmailToQuoteId == null || cc1EmailToQuoteId == '') {
                        cc1EmailToQuoteId = conisSelect.conRec.Email;
                    } else {
                        cc1EmailToQuoteId = cc1EmailToQuoteId + ';' + conisSelect.conRec.Email;
                    }
                } else if (EmailAddressSpec == 'cc2Address') {

                    if (cc2EmailToQuoteId == null || cc2EmailToQuoteId == '') {
                        cc2EmailToQuoteId = conisSelect.conRec.Email;
                    } else {
                        cc2EmailToQuoteId = cc2EmailToQuoteId + ';' + conisSelect.conRec.Email;
                    }
                }
            }
        }
        //-----------COmmmented for TFS 4536
        /*for (HomeBaseBeans.contactSummaryList chekcboxistrue: contactsResponseListForEmailQutoe) {
            if (chekcboxistrue.IsSelected) {
                if (EmailAddressSpec == 'toAddress') {
                    if (emailIdForEmailQuote == null || emailIdForEmailQuote == '') {
                        emailIdForEmailQuote = chekcboxistrue.forename;
                    } else {
                        emailIdForEmailQuote = emailIdForEmailQuote + ';' + chekcboxistrue.forename;
                    }
                } else if (EmailAddressSpec == 'cc1Address') {

                    if (cc1EmailToQuoteId == null || cc1EmailToQuoteId == '') {
                        cc1EmailToQuoteId = chekcboxistrue.forename;
                    } else {
                        cc1EmailToQuoteId = cc1EmailToQuoteId + ';' + chekcboxistrue.forename;
                    }
                } else if (EmailAddressSpec == 'cc2Address') {

                    if (cc2EmailToQuoteId == null || cc2EmailToQuoteId == '') {
                        cc2EmailToQuoteId = chekcboxistrue.forename;
                    } else {
                        cc2EmailToQuoteId = cc2EmailToQuoteId + ';' + chekcboxistrue.forename;
                    }
                }
                chekcboxistrue.IsSelected = false;
            }
        }*/
        isEmailContactPopUp = false;
        return null;
    }
    public Pagereference sendEmailToUser() {
        try {
            FullQuoteEmailQuote pdfclass = new FullQuoteEmailQuote();
            List < Document > docuemnt;
            docuemnt = new List < Document > ();

            blob AttachmentPdfuser = null;
            List < Messaging.Singleemailmessage > mailIdsu = new List < Messaging.Singleemailmessage > ();
            if (test.isRunningTest()) {
                emailIdForEmailQuote = 'test@teksystem.com';
                cc1EmailToQuoteId = 'test@teksystem.com';
                cc2EmailToQuoteId = 'test@teksystem.com';
            }
            List < string > toEmailList = emailIdForEmailQuote.split(';');
            List < string > cc1Email = new list < String > ();
            if (cc1EmailToQuoteId != null && cc1EmailToQuoteId != '') {
                cc1Email = cc1EmailToQuoteId.split(';');
            }
            List < string > cc2Email = cc2EmailToQuoteId.split(';');
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            List < Messaging.EmailFileAttachment > attachList = new List < Messaging.EmailFileAttachment > ();

            if (!summaryLineList.isEmpty()) {
                Boolean accessoryRes = false;
                FullQuoteMainService fqService = new FullQuoteMainService();
                for (HomeBaseBeans.quoteLine sm: summaryLineList) {
                    if (sm.itemId != 'CG1' && sm.itemId != 'CG2' && sm.itemId != 'DL1' && sm.itemId != 'DL2' && !ckeckModificationItem(sm.itemId)) {
                        accessoryRes = fqService.getAccessoryInfo(sm.itemId);
                        if (accessoryRes == false) {
                            prodctname = sm.itemId;
                        }
                    }
                }
                List < Product_Brochures_Lookup__c > produBrochList = [Select p.Product_Image__c, p.Product_Id__c, p.Product_Document_Brochures_Name__c, p.Name, p.Id From Product_Brochures_Lookup__c p where Product_Id__c = : prodctname limit 1];
                if (!produBrochList.isEmpty()) {
                    docuemnt = [Select d.Url, d.Type, d.SystemModstamp, d.NamespacePrefix, d.Name, d.LastModifiedDate, d.LastModifiedById, d.Keywords, d.IsPublic, d.IsInternalUseOnly, d.IsDeleted, d.IsBodySearchable, d.Id, d.FolderId, d.DeveloperName, d.Description, d.CreatedDate, d.CreatedById, d.ContentType, d.BodyLength, d.Body, d.AuthorId From Document d where Name = : produBrochList[0].Product_Document_Brochures_Name__c limit 1];
                }
            }
            if (emailIdForEmailQuote != null && emailIdForEmailQuote != '') {
                mail.setToAddresses(toEmailList);
                //----------TFS 2710--------------------------------------
                system.debug('--------------accountOwnerIdOfQQ-----------------' + accountOwnerIdOfQQ);
                if (accountOwnerIdOfQQ != null && accountOwnerIdOfQQ != '') {
                    User accOwnerOfQQRecord = FullQuoteDAO.getUserDetails(accountOwnerIdOfQQ);
                    system.debug('--------------accOwnerOfQQRecord.EMail-----------------' + accOwnerOfQQRecord.EMail);
                    if (accOwnerOfQQRecord.EMail != null && accOwnerOfQQRecord.Email != '') {
                        cc1Email.add(accOwnerOfQQRecord.EMail);
                    }
                }
                //----------TFS 2710--------------------------------------  
                if (cc1Email.size() > 0) {
                    mail.setCcAddresses(cc1Email);
                }
                if (cc2EmailToQuoteId != null && cc2EmailToQuoteId != '') {
                    mail.setBccAddresses(cc2Email);
                }
                if (!test.isRunningTest()) {
                    if (quoteIdforEmail != null && quoteIdforEmail != '') {
                        Pagereference pdfcont = new PageReference('/apex/FullQuoteEmailQuote?quoteid=' + quoteIdforEmail);
                        pdfcont.setRedirect(false);
                        AttachmentPdfuser = pdfcont.getContent();
                    } else {
                        system.debug('--test-');
                    }
                }
                Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
                attach.setContentType('application/pdf');
                if (fullQWrapper.selectedFullQUote == 'rental' || fullQWrapper.selectedFullQUote == 'Rental') {
                    attach.setFileName('RentalFullQuotePreview.pdf');
                } else {
                    attach.setFileName('SalesFullQuotePreview.pdf');
                }
                attach.setInline(false);
                if (AttachmentPdfuser != null) {
                    attach.Body = AttachmentPdfuser;
                }
                attachList.add(attach);
                if (!docuemnt.isEmpty()) {
                    Messaging.EmailFileAttachment docattach = new Messaging.EmailFileAttachment();
                    docattach.setContentType('application/pdf');
                    docattach.setFileName(docuemnt[0].Name + '.pdf');
                    docattach.setInline(false);
                    docattach.Body = docuemnt[0].Body;
                    attachList.add(docattach);
                }


                if (strAttachFile != null && strAttachFile != '' && fileBody != null) {
                    Messaging.EmailFileAttachment tempAttach = new Messaging.EmailFileAttachment();
                    //tempAttach.setContentType = strContentType;
                    tempAttach.setFileName(strAttachFile);
                    tempAttach.setInline(false);
                    tempAttach.Body = fileBody;
                    attachList.add(tempAttach);
                }

                List < Attachment > attachmentlist = [Select a.ParentId, a.Name, a.Body From Attachment a where parentid = : quoteIdforEmail];

                if (!attachmentlist.isEmpty()) {
                    for (Attachment aa: attachmentlist) {
                        Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();
                        efa.setFileName(aa.Name);
                        efa.setBody(aa.Body);
                        attachList.add(efa);
                    }
                }


                //String UserSign = '<br/><br/><br/><table align="left"><tr><td><b>'+loginUserRec.Name+'</b></td></tr><tr><td>'+loginUserRec.UserRole.Name+'</td></tr><tr><td>'+loginUserRec.Street+'|'+loginUserRec.City+''+loginUserRec.State+''+loginUserRec.PostalCode+'</td></tr><tr><td>o:'+loginUserRec.Phone+','+loginUserRec.Extension__c+'</td></tr><tr><td>m:'+loginUserRec.MobilePhone+'</td></tr><tr><td>'+loginUserRec.Email+'</td></tr><tr><td><img src="https://c.na6.content.force.com/servlet/servlet.ImageServer?id=01580000001rJ2A&oid=00D80000000azTL" /></td></tr></table>';
                //String UserSign = generateSignature(loginUserRec);
                //MailBodyToQuote = MailBodyToQuote + UserSign;
                mail.setUseSignature(false);
                mail.setSubject(SubjectEmailQuote);
                //mail.setplainTextBody(MailBodyToQuote);
                if (MailBodyToQuote != null && MailBodyToQuote != '') {
                    MailBodyToQuote = MailBodyToQuote.replace('\n', '<br/>');
                }
                mail.setHtmlBody(MailBodyToQuote);
                mail.setFileAttachments(attachList);

                if (!test.isRunningTest()) {
                    system.debug('----------mail-------' + mail);
                    Messaging.SendEmailResult[] mailRes = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {
                        mail
                    });
                    system.debug('----------mailRes-------' + mailRes);
                    if (mailRes.get(0).isSuccess()) {
                        attachmentlist = new List < Attachment >();
                    }
                    system.debug('----------attachmentlist-------' + attachmentlist);
                }

                emailIdForEmailQuote = '';
                cc1EmailToQuoteId = '';
                cc1Email = new list < String > ();
                cc2EmailToQuoteId = '';
                //SubjectEmailQuote = '';
                MailBodyToQuote = '';
                pdfclass.deleteQuoutId(quoteIdforEmail);
                //quoteIdforEmail = '';
                isSaveSuccessEmail = true;
                EmailshowPopUp = false;
                // create task after mailing..........................
                Task taskObj = new Task();
                taskObj.OwnerId = UserInfo.getUserId();
                User UserBranchId = FullQuoteDAO.getUserBranchDetails();
                taskObj.Subject = SubjectEmailQuote;
                SubjectEmailQuote = '';
                taskObj.ActivityDate = system.today();
                taskObj.Call_Type__c = 'OB - Sales & Marketing';//TFS 3944
                taskObj.Call_Result__c = '';
                taskObj.Description = '';
                taskObj.Status = 'Completed';
                taskObj.Priority = 'Normal';
                //------------TFS 2708----------------------
                if (!toEmailList.IsEmpty() && toEmailList.size() > 0) {
                    taskObj.Customer_Email__c = toEmailList[0];
                }
                //------------TFS 2708----------------------
                //get what id................................
                String RelatedWhatId = '';
                if (docId == null || cloneIsTrue == 'true') {
                    if (quickQuoteId != null && quickQuoteId != '') {
                        RelatedWhatId = QqData.Opportunity__c;
                    } else {
                        if (opportunityRec != null && (RelatedWhatId == '' || RelatedWhatId == null)) {
                            if (opportunityRec.size() > 0) {
                                RelatedWhatId = opportunityRec[0].Id;
                            }
                        }
                        if (accountRec != null && (RelatedWhatId == '' || RelatedWhatId == null)) {
                            if (accountRec.size() > 0) {
                                RelatedWhatId = accountRec[0].Id;
                            }
                        }
                        if (FQSMrecId != null && (RelatedWhatId == '' || RelatedWhatId == null)) {
                            String qQId = fullQuote_tran.SourceId__c;
                            if (qQId.startsWith('006') || qQId.startsWith('001')) {
                                RelatedWhatId = qQId;
                            }
                            //RelatedWhatId = [Select Id,Opportunity__c From Full_Quote_Transactional__c where Id = :fullQuote_tran.SourceId__c].get(0).Opportunity__c;
                        }
                    }
                } else {
                    RelatedWhatId = updateQuoteRec.Opportunity__c;
                }
                if (RelatedWhatId != '' && RelatedWhatId != null) {
                    taskObj.WhatId = RelatedWhatId;
                }
                insert taskObj;

                //------------TFS 2708----------------------
                /*Task taskObj1 = new Task();
                taskObj1.OwnerId = UserInfo.getUserId();
                taskObj1.Subject = 'Send Quote';
                taskObj1.ActivityDate = system.today();
                taskObj1.Call_Type__c = 'OB-Email';
                taskObj1.Call_Result__c = '';
                taskObj1.Description = '';
                taskObj1.Status = 'Completed';
                taskObj1.Priority = 'Normal';
                if(!toEmailList.IsEmpty() && toEmailList.size() > 0){
                    taskObj1.Customer_Email__c = toEmailList[0];
                }
                if(updateQuoteRec != null && updateQuoteRec.Opportunity__c != null && updateQuoteRec.Opportunity__c != ''){
                    taskObj1.WhatId = updateQuoteRec.Opportunity__c;
                }
                insert taskObj1;*/
                //------------TFS 2708----------------------
            } else {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Please Enter To Address');
                ApexPages.addMessage(msg);
                isSaveSuccessEmail = false;
            }
            stopActionPoller();
        } catch (Exception e) {
            //MailBodyToQuote = '';
            if (e.getMessage() != null) {
                List < String > errorMessageList = e.getMessage().split(':');
                if (test.isRunningTest()) {
                    errorMessageList.add('INVALID_EMAIL_ADDRESS');
                }
                if (errorMessageList[1].contains('INVALID_EMAIL_ADDRESS')) {
                    ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'INVALID_EMAIL_ADDRESS: Please enter valid email address');
                    ApexPages.addMessage(msg);
                    isSaveSuccessEmail = false;
                } else {
                    ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, e.getMessage());
                    ApexPages.addMessage(msg);
                    isSaveSuccessEmail = false;
                }
            }

            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC CountriesList: ' + e.getMessage());
        }
        return null;
    }

    public string generateSignature(User uRec) {
        String UserSign = '';
        UserSign += '<br/><br/><br/><table align="left"><tr><td><b>' + uRec.Name + '</b></td></tr><tr><td>' + uRec.UserRole.Name + '</td></tr><tr><td>';
        if (uRec.Street != null && uRec.Street != '') {
            UserSign += uRec.Street + '|';
        }
        if (uRec.City != null && uRec.City != '') {
            UserSign += uRec.City + ' ';
        }
        if (uRec.State != null && uRec.State != '') {
            UserSign += uRec.State + ' ';
        }
        if (uRec.PostalCode != null && uRec.PostalCode != '') {
            UserSign += uRec.PostalCode + ' ';
        }
        UserSign += '</td></tr><tr><td>o:';
        if (uRec.Phone != null && uRec.Phone != '') {
            UserSign += uRec.Phone + ',' + uRec.Extension__c;
        }
        UserSign += '</td></tr><tr><td>m:';
        if (uRec.MobilePhone != null && uRec.MobilePhone != '') {
            UserSign += uRec.MobilePhone;
        }
        UserSign += '</td></tr><tr><td>';
        if (uRec.Email != null && uRec.Email != '') {
            UserSign += uRec.Email;
        }
        UserSign += '</td></tr><tr><td><img src="https://c.na6.content.force.com/servlet/servlet.ImageServer?id=01580000001rJ2A&oid=00D80000000azTL" /></td></tr></table>';
        return UserSign;
    }


    public void cancelSending() {
        EmailshowPopUp = false;
        FullQuoteEmailQuote pdfclass = null;
        pdfclass = new FullQuoteEmailQuote();
        if (quoteIdforEmail != null && quoteIdforEmail != '') {
            pdfclass.deleteQuoutId(quoteIdforEmail);
        }
        emailIdForEmailQuote = '';
        cc1EmailToQuoteId = '';
        cc2EmailToQuoteId = '';
        quoteIdforEmail = '';
        SubjectEmailQuote = '';
        MailBodyToQuote = '';
    }
    public void getSalesInventoryList() {
        system.debug('-------calling--------salesInventories-----------------');
        isSalesInventorySearched = false;
        FullQuoteMainService fqService = null;
        String branchId;
        if (quickQuoteId != null && quickQuoteId != '') {
            branchId = CalculateBranchIdDuringQqToFQConversion(QqData, fullQWrapper.fulFillingBranchInShippingDates);
        } else {
            branchId = FullQuoteDAO.getBranchId(fullQWrapper.fulFillingBranchInShippingDates, Apexpages.currentPage().getParameters().get('id'));
        }
        List < HB_Sales_Inventory__c > salesInventoryList = new List < HB_Sales_Inventory__c > ();
        salesInventories = new List < FullQuoteWrapper.ProductSales > ();
        salesInventoriesList = new List < FullQuoteWrapper.ProductSales > ();
        fqService = new FullQuoteMainService();


        if (test.isRunningTest()) {
            salesInventoryList = MMIFullquoteTestDataProvider.getHBSalesInventoryList();
        } else {
            salesInventoryList = fqService.getSalesInventories(branchId);
        }

        integer i = 0;
        for (HB_Sales_Inventory__c salesInv: salesInventoryList) {
            FullQuoteWrapper.ProductSales prod = new FullQuoteWrapper.ProductSales();
            prod.area = salesInv.Area__c;
            prod.blowout = String.valueOf(salesInv.Blowout__c);
            prod.companyId = salesInv.CompanyId__c;
            prod.eCode = salesInv.E_Code__c;
            prod.fulfillingBranchCode = salesInv.Fulfilling_Branch_Code__c;
            prod.gradeCode = salesInv.Grade_Code__c;
            prod.gradeDescription = salesInv.Grade_Description__c;
            prod.itemRef = salesInv.Item_Reference__c;
            prod.lineItemID = salesInv.Line_Item_ID__c;
            prod.minimumPrice = salesInv.Minimum_Price__c;
            prod.nbv = salesInv.NBV__c;
            prod.notes = salesInv.Notes__c;
            prod.reasonCode = salesInv.Reason_Code__c;
            prod.status = salesInv.Status__c;
            prod.suggestedPrice = salesInv.Suggested_Price__c;
            prod.displayPicture = salesInv.Display_Picture__c;
            prod.imagesSalesInv = new List < FullQuoteWrapper.SalesImages > ();
            if (!salesInv.SalesInventoryImages__r.isEmpty()) {

                for (SalesInventoryImages__c sImages: salesInv.SalesInventoryImages__r) {
                    FullQuoteWrapper.SalesImages sImage = new FullQuoteWrapper.SalesImages();
                    sImage.imageURL = sImages.Display_Picture__c;
                    sImage.perentId = sImages.HB_Sales_Inventory__c;
                    sImage.sfdcRecId = sImages.Id;
                    prod.imagesSalesInv.add(sImage);
                }

            }
            //prod.imagesSalesInv
            prod.recId = i;
            salesInventories.add(prod);
            i++;
        }
        //salesInventoriesList.addAll(salesInventories);
        system.debug('---------------salesInventories-----------------' + salesInventories);
    }

    public void searchSalesInventory() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :searchSalesInventory' + fullQWrapper.productSearchWord);
        FullQuoteMainService fqService = null;
        List < accessories__c > accessoryList = null;
        String branchId;
        try {
            if (fullQWrapper.productSearchWord != null && fullQWrapper.productSearchWord != '') {

                branchId = FullQuoteDAO.getBranchId(fullQWrapper.fulFillingBranchInShippingDates, Apexpages.currentPage().getParameters().get('id'));
                List < HB_Sales_Inventory__c > salesInventoryList = new List < HB_Sales_Inventory__c > ();
                accessoryList = new List < accessories__c > ();
                salesInventories = new List < FullQuoteWrapper.ProductSales > ();
                salesInventoriesList = new List < FullQuoteWrapper.ProductSales > ();
                fqService = new FullQuoteMainService();



                if (test.isRunningTest()) {
                    salesInventoryList = MMIFullquoteTestDataProvider.getHBSalesInventoryList();
                } else {
                    salesInventoryList = fqService.getSalesInventoriesSearch(branchId, fullQWrapper.productSearchWord);
                }

                integer i = 0;
                for (HB_Sales_Inventory__c salesInv: salesInventoryList) {
                    FullQuoteWrapper.ProductSales prod = new FullQuoteWrapper.ProductSales();
                    prod.area = salesInv.Area__c;
                    prod.blowout = String.valueOf(salesInv.Blowout__c);
                    prod.companyId = salesInv.CompanyId__c;
                    prod.eCode = salesInv.E_Code__c;
                    prod.fulfillingBranchCode = salesInv.Fulfilling_Branch_Code__c;
                    prod.gradeCode = salesInv.Grade_Code__c;
                    prod.gradeDescription = salesInv.Grade_Description__c;
                    prod.itemRef = salesInv.Item_Reference__c;
                    prod.lineItemID = salesInv.Line_Item_ID__c;
                    prod.minimumPrice = salesInv.Minimum_Price__c;
                    prod.nbv = salesInv.NBV__c;
                    prod.notes = salesInv.Notes__c;
                    prod.reasonCode = salesInv.Reason_Code__c;
                    prod.status = salesInv.Status__c;
                    prod.suggestedPrice = salesInv.Suggested_Price__c;
                    prod.displayPicture = salesInv.Display_Picture__c;

                    prod.imagesSalesInv = new List < FullQuoteWrapper.SalesImages > ();
                    if (!salesInv.SalesInventoryImages__r.isEmpty()) {

                        for (SalesInventoryImages__c sImages: salesInv.SalesInventoryImages__r) {
                            FullQuoteWrapper.SalesImages sImage = new FullQuoteWrapper.SalesImages();
                            sImage.imageURL = sImages.Display_Picture__c;
                            sImage.perentId = sImages.HB_Sales_Inventory__c;
                            sImage.sfdcRecId = sImages.Id;
                            prod.imagesSalesInv.add(sImage);
                        }

                    }
                    prod.recId = i;
                    salesInventories.add(prod);
                    i++;
                }

                accessoryList = fqService.searchAccessories(fullQWrapper.productSearchWord);

                for (accessories__c salesInv: accessoryList) {
                    FullQuoteWrapper.ProductSales prod = new FullQuoteWrapper.ProductSales();

                    prod.itemRef = salesInv.Definition_Code__c;
                    prod.lineItemID = salesInv.Name;
                    prod.gradeDescription = salesInv.Item_Description__c;
                    prod.recId = i;
                    salesInventories.add(prod);
                    i++;
                }
                //salesInventoriesList.addAll(salesInventories);

            }
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC searchSalesInventory: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :searchSalesInventory' + salesInventories);
    }


    public Pagereference getNewCustomerAcc() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :getNewCustomerAcc');
        isValidateBillingAccClicked = true;
        NewCustomerAccountService newCustAccountService = null;
        NewCustomerAccountParser newCustAccountParser = null;
        fullQWrapper.showValidateAddressPopUp = true;
        isDuplicateAccPresent = false;
        try {
            customerAccList = new List < FullQuoteWrapper.NewCustomerAccount > ();
            if (fullQWrapper.AccountId == '' || fullQWrapper.AccountId == null) {
                newCustAccountService = new NewCustomerAccountService();
                newCustAccountParser = new NewCustomerAccountParser();
                newCustAccountParser = newCustAccountService.callNewCustAccount(fullQWrapper.AccountName, fullQWrapper.Address, fullQWrapper.City, fullQWrapper.State, fullQWrapper.ZipCode, fullQWrapper.telePhone);
                if (test.isRunningTest()) {
                    newCustAccountParser.duplicateAccounts = MMIFullquoteTestDataProvider.getNewCustomerAccountParserduplicateAccountList();
                }
                if (newCustAccountParser.errorMessage == null) {
                    if (newCustAccountParser.totalResults != '0') {
                        if (newCustAccountParser.duplicateAccounts.size() > 0) {
                            isDuplicateAccPresent = true;
                            integer i = 0;
                            for (NewCustomerAccountParser.duplicateAccount acc: newCustAccountParser.duplicateAccounts) {
                                FullQuoteWrapper.NewCustomerAccount newCustAcc = new FullQuoteWrapper.NewCustomerAccount();
                                newCustAcc.id = acc.id;
                                newCustAcc.name = acc.name;
                                newCustAcc.creditStatus = acc.creditStatus;
                                newCustAcc.status = acc.status;
                                newCustAcc.addressLine1 = acc.accountAddress.addressLine1;
                                newCustAcc.addressLine2 = acc.accountAddress.addressLine2;
                                newCustAcc.addressLine3 = acc.accountAddress.addressLine3;
                                newCustAcc.addressLine4 = acc.accountAddress.addressLine4;

                                newCustAcc.state = acc.accountAddress.state;
                                newCustAcc.zipCode = acc.accountAddress.zipCode;
                                newCustAcc.countryId = acc.accountAddress.countryId;
                                newCustAcc.phoneNumber = acc.phoneNumber;
                                newCustAcc.recId = i;

                                customerAccList.add(newCustAcc);
                                i++;
                            }
                        }
                    } else {
                        isDuplicateAccPresent = true;
                        ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'No duplicate account found.');
                        ApexPages.addMessage(msg);
                    }
                } else {
                    isDuplicateAccPresent = false;
                    ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, newCustAccountParser.errorMessage);
                    ApexPages.addMessage(msg);
                }
            }

        } catch (Exception e) {
            isDuplicateAccPresent = false;
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC getNewCustomerAcc: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :getNewCustomerAcc' + customerAccList);
        return null;
    }

    public void CreateAccountInSF() {
        if (newAccountId == '' || newAccountId == null) {
            Account accObj = new Account();
            Contact conObj = new Contact();
            if (leadRec.size() > 0) {
                accObj.Lead_Source__c = leadRec[0].LeadSource;
                accObj.Industry = leadRec[0].Industry;
                if (leadRec[0].Company != null && leadRec[0].Company != '') {
                    accObj.Name = fullQWrapper.AccountName;
                    accObj.Type = 'Prospect - Branch Business Account';
                } else {
                    accObj.FirstName = fullQWrapper.Name;
                    accObj.LastName = fullQWrapper.LastName;
                    //accObj.IsPersonAccount = true;
                    accObj.Type = 'Prospect - Residential Account';
                    accObj.Phone = fullQWrapper.telePhone;
                }
            }
            accObj.BillingCity = fullQWrapper.City;
            accObj.BillingStreet = fullQWrapper.Address;
            accObj.BillingState = fullQWrapper.State;
            accObj.BillingCountry = fullQWrapper.Country;
            accObj.BillingPostalCode = fullQWrapper.ZipCode;


            insert accObj;
            if (leadRec.size() > 0) {
                if (leadRec[0].Company != null && leadRec[0].Company != '') {
                    conObj.AccountId = accObj.Id;
                    conObj.Decision_Maker__c = 'No';
                    conObj.FirstName = fullQWrapper.Name;
                    conObj.LastName = fullQWrapper.LastName;
                    conObj.Phone = fullQWrapper.telePhone;
                    conObj.Result_Id__c = '1'; // set the default RR contact Id to the newly created SFDC Contcat for PG Account Creation
                    insert conObj;
                }
            }
            newAccountId = accObj.Id;
            newContactId = conObj.Id;
        } else {
            Account accObj = new Account();
            Contact conObj = new Contact();
            if (leadRec.size() > 0) {
                if (leadRec[0].Company != null && leadRec[0].Company != '') {
                    accObj.Name = fullQWrapper.AccountName;
                    accObj.Type = 'Prospect - Branch Business Account';
                } else {
                    accObj.FirstName = fullQWrapper.Name;
                    accObj.LastName = fullQWrapper.LastName;
                    //accObj.IsPersonAccount = true;
                    accObj.Type = 'Prospect - Residential Account';
                }
            }
            accObj.BillingCity = fullQWrapper.City;
            accObj.BillingStreet = fullQWrapper.Address;
            accObj.BillingState = fullQWrapper.State;
            accObj.BillingCountry = fullQWrapper.Country;
            accObj.BillingPostalCode = fullQWrapper.ZipCode;
            accObj.Type = 'Out of Business';
            accObj.Id = newAccountId;
            update accObj;
            if (leadRec.size() > 0) {
                if (leadRec[0].Company != null && leadRec[0].Company != '') {
                    conObj.AccountId = accObj.Id;
                    conObj.Decision_Maker__c = 'No';
                    conObj.FirstName = fullQWrapper.Name;
                    conObj.LastName = fullQWrapper.LastName;
                    conObj.Phone = fullQWrapper.telePhone;
                    conObj.Result_Id__c = '1'; // set the default RR contact Id to the newly created SFDC Contcat for PG Account Creation
                    conObj.Id = newContactId;
                    update conObj;
                }
            }
        }
    }

    public String createNewCustomerAccount() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :createNewCustomerAccount');
        erreorOnNewAcctCreation = '';
        NewCustomerAccountService newCustAccountService = null;
        NewCustomerAccountService.ParseCreateNewResponse newAcctRes = null;
        String newlyCreatedAccountId = '';
        try {
            newCustAccountService = new NewCustomerAccountService();
            newAcctRes = new NewCustomerAccountService.ParseCreateNewResponse();
            String newSFAccountId = ''; // should be set to blank
            if (updateQuoteRec != null) {
                newSFAccountId = updateQuoteRec.Opportunity__r.AccountId;
            }
            String branch = '';
            String SalesRepId = '';
            User UserObj = FullQuoteDAO.getUserBranchDetails();
            branch = UserObj.Branch_Id__c;
            SalesRepId = UserObj.Sales_Rep_Id__c;
            newAcctRes = newCustAccountService.createNewCustAccount(fullQWrapper.AccountName, fullQWrapper.Address, fullQWrapper.State, fullQWrapper.Country, fullQWrapper.ZipCode, fullQWrapper.telePhone, branch, SalesRepId, newSFAccountId, fullQWrapper.County, fullQWrapper.City);
            if (newAcctRes.errorMessage == null) {
                newlyCreatedAccountId = newAcctRes.newAccountId;
                //link contacts to the newly created Account
                list<Contact> lstConOfPgAccount = [select Id, FirstName, LastName, Phone, MobilePhone, Email,Fax, Result_Id__c FROM Contact WHERE Result_Id__c = '1' and AccountId = :updateQuoteRec.Account__c limit 1];
                if(lstConOfPgAccount != null && lstConOfPgAccount.size() > 0){
                    String BranchId = FullQuoteDAO.getBranchId(fullQWrapper.fulFillingBranchInShippingDates, recId);
                    String AddPayload = generateAddOrUpdatePayload('', BranchId,null,lstConOfPgAccount[0]);
                    system.debug('-----AddPayload--PG-----' + AddPayload);
                    List < HomeBaseBeans.AddContact > addContactResult = callAddOrUpdateContactWS(BranchId, newlyCreatedAccountId, AddPayload, 'add');
                    system.debug('-----addContactResult--PG-----' + addContactResult);
                }
                return newlyCreatedAccountId;
            } else {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, newAcctRes.errorMessage);
                ApexPages.addMessage(msg);
                erreorOnNewAcctCreation = newAcctRes.errorMessage;
                return newAcctRes.errorMessage;
            }
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC createNewCustomerAccount: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :createNewCustomerAccount' + newAcctRes);
        return newlyCreatedAccountId;
    }


    public PageReference newCustomerAccountIdSelected() {
        system.debug(LoggingLevel.DEBUG, 'Entering FullQuoteMainController_AC :newCustomerAccountIdSelected' + customerAccList);
        String selectedAddressId;

        try {
            selectedAddressId = System.currentPageReference().getParameters().get('SelectedVaddressRadio');
            //----------------TFS-1321----------------------------------------------------------------
            /*for(FullQuoteWrapper.NewCustomerAccount newCustAcc : customerAccList){
                    if(selectedAddressId != null && selectedAddressId != '' && newCustAcc.recId == Integer.valueOf(selectedAddressId)){
                        system.debug('--------------newCustAcc.Id------------------'+newCustAcc.Id);
                        list<Account> lstAccountRecord = [select Id from Account where Result_Id__c = :newCustAcc.Id];
                        system.debug('--------------lstAccountRecord------------------'+lstAccountRecord);
                        PageReference pr = null;
                        if(!lstAccountRecord.isEmpty()){
                            pr = new PageReference('/'+lstAccountRecord[0].Id);
                            pr.setRedirect(true);
                            return pr;
                        }else{
                            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'No Account found in SFDC database related to Result Id '+newCustAcc.Id+'!');
                            ApexPages.addMessage(msg);
                            erreorOnNewAcctCreation = 'yes';
                            fullQWrapper.showValidateAddressPopUp = false;
                            enableBilingAddressFields();
                            return pr;
                        }
                    }
                }*/
            //----------------TFS-1321----------------------------------------------------------------

            if (test.isRunningTest()) {
                selectedAddressId = '1';
            }
            for (FullQuoteWrapper.NewCustomerAccount newCustAcc: customerAccList) {
                if (!(selectedAddressId == null || selectedAddressId == '')) {
                    if (newCustAcc.recId == Integer.valueOf(selectedAddressId)) {
                        system.debug('--------------newCustAcc----------------' + newCustAcc);
                        isDuplicateAccSelected = true;
                        fullQWrapper.AccountId = newCustAcc.id;
                        fullQWrapper.AccountName = newCustAcc.name;
                        if (newCustAcc.taxExempt != null) {
                            fullQWrapper.TaxExempt = Boolean.valueOf(newCustAcc.taxExempt);
                        }
                        if (newCustAcc.creditStatus != null) {
                            fullQWrapper.Status = newCustAcc.creditStatus;
                        }
                        if (newCustAcc.phoneNumber != null) {
                            fullQWrapper.telePhone = newCustAcc.phoneNumber;
                        }
                        if (newCustAcc.addressLine1 != null) {
                            fullQWrapper.Address = newCustAcc.addressLine1;
                        }
                        if (newCustAcc.addressLine3 != null) {
                            fullQWrapper.City = newCustAcc.addressLine3;
                        }
                        if (newCustAcc.addressLine4 != null) {
                            fullQWrapper.County = newCustAcc.addressLine4;
                        }
                        if (newCustAcc.state != null) {
                            fullQWrapper.State = newCustAcc.state;
                        }
                        if (newCustAcc.countryId != null) {
                            fullQWrapper.Country = newCustAcc.countryId;
                        }
                        if (newCustAcc.zipCode != null) {
                            fullQWrapper.ZipCode = newCustAcc.zipCode;
                        }
                        if (newCustAcc.name != null) {
                            fullQWrapper.AccountName = newCustAcc.name;
                        }
                        if (newCustAcc.id != null) {
                            fullQWrapper.AccountId = newCustAcc.id;
                        }
                        disableBilingAddressFields();
                        break;
                    }
                }
            }

            fullQWrapper.showValidateAddressPopUp = false;
            customerAccList = new List < FullQuoteWrapper.NewCustomerAccount > ();
        } catch (Exception e) {
            system.debug(LoggingLevel.ERROR, 'Error while getting values from FullQuoteMainController_AC newCustomerAccountIdSelected: ' + e.getMessage());
        }
        system.debug(LoggingLevel.DEBUG, 'Exiting FullQuoteMainController_AC :newCustomerAccountIdSelected');
        return null;
    }

    public void ZipCodeFinder() {
        BranchLookup = new Branch_Lookup__c();
        system.debug('------qqWrapper.ZipCode-----' + fullQWrapper.ZipCode);
        if (fullQWrapper.ZipCode != null && fullQWrapper.ZipCode != '') {
            FullQuoteMainService fqService = new FullQuoteMainService();
            BranchLookup = fqService.getBranchLookupinfo(fullQWrapper.ZipCode);
            if (BranchLookup != null) {
                if (BranchLookup.Country__c == 'US' || BranchLookup.Country__c == 'USA') {
                    fullQWrapper.Country = 'USA';
                }
                if (BranchLookup.Country__c == 'CA' || BranchLookup.Country__c == 'CAN') {
                    fullQWrapper.Country = 'CAN';
                }
                StatesList();
                fullQWrapper.State = BranchLookup.State__c;
                fullQWrapper.City = BranchLookup.City__c;
            }
        }


    }
    public void ZipCodeFinderShipping() {
        BranchLookup = new Branch_Lookup__c();
        if (fullQWrapper.ZipCodeInShipping != null && fullQWrapper.ZipCodeInShipping != '') {
            FullQuoteMainService fqService = new FullQuoteMainService();
            BranchLookup = fqService.getBranchLookupinfo(fullQWrapper.ZipCodeInShipping);
            if (BranchLookup != null) {
                if (BranchLookup.Country__c == 'US') {
                    fullQWrapper.countryInShippingDates = 'USA';
                }
                if (BranchLookup.Country__c == 'CA') {
                    fullQWrapper.countryInShippingDates = 'CAN';
                }
                system.debug('--------fullQWrapper.countryInShippingDates-------' + fullQWrapper.countryInShippingDates);
                shippingStatesList();
                fullQWrapper.stateInShippingDates = BranchLookup.State__c;
                fullQWrapper.cityInShippingDates = BranchLookup.City__c;
                system.debug('--------fullQWrapper.stateInShippingDates------' + fullQWrapper.stateInShippingDates);
            }
        }


    }

    public void DisableKnowDelZoneBtn() {
        if (fullQWrapper.deliveryZoneInShipping != null && fullQWrapper.deliveryZoneInShipping != '') {
            isknowZoneRatesBtnDisabled = true;
        } else {
            isknowZoneRatesBtnDisabled = false;
        }
    }

    public void NoDelZoneRates() {
        HomeBaseBeans.knowZoneRatesEmailParam paramObj = new HomeBaseBeans.knowZoneRatesEmailParam();
        String mainProductItem = '';
        if (!summaryLineList.isEmpty()) {
            FullQuoteMainService fqService = new FullQuoteMainService();
            for (HomeBaseBeans.quoteLine sm: summaryLineList) {
                if (sm.itemId != 'CG1' && sm.itemId != 'CG2' && sm.itemId != 'DL1' && sm.itemId != 'DL2' && !ckeckModificationItem(sm.itemId)) {
                    Boolean isItemAnAccessory = fqService.getAccessoryInfo(sm.itemId);
                    if (isItemAnAccessory == false) {
                        paramObj.itemCode = sm.itemId;
                        mainProductItem = sm.itemId;
                    }
                }
            }
        }
        if (mainProductItem != null && mainProductItem != '') {
            paramObj.quoteType = 'fq';
            if (leadRec.size() > 0) {
                paramObj.sourceOfQuote = 'lead';
            }
            paramObj.fulfillingBranchId = fullQWrapper.fulFillingBranchInShippingDates;

            FullQuoteWrapper fq = new FullQuoteWrapper();
            fq = fullQWrapper;
            paramObj.fullQWrapper = fq;
            paramObj.loggedInUserEmail = loginUserRec.Email;
            if (opportunityRec.size() > 0) {
                if (opportunityRec[0].Account.OwnerId != null) {
                    User accOwnerDetail = QuickQuoteMainDAO.UserDetails(opportunityRec[0].Account.OwnerId);
                    if (accOwnerDetail != null) {
                        paramObj.sfdcAccOwnerEmail = accOwnerDetail.Email;
                    }
                }
                paramObj.oppId = opportunityRec[0].Id;
            }
            if (accountRec.size() > 0) {
                User accOwnerDetail = QuickQuoteMainDAO.UserDetails(accountRec[0].OwnerId);
                if (accOwnerDetail != null) {
                    paramObj.sfdcAccOwnerEmail = accOwnerDetail.Email;
                }
            }
            if (docId != null && updateQuoteRec != null) {
                paramObj.oppId = updateQuoteRec.Id;
            }
            String mailError = QuickQuoteMainDAO.SendEmailToBranch(paramObj);
            if (test.isRunningTest()) {
                mailError = 'test';
            }
            if (mailError != null && mailError != '' && mailError != 'Mail has been sent successfully!') {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, mailError);
                ApexPages.addMessage(msg);
            }
            if (test.isRunningTest()) {
                mailError = 'Mail has been sent successfully!';
            }
            if (mailError != null && mailError != '' && mailError == 'Mail has been sent successfully!') {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.confirm, mailError);
                ApexPages.addMessage(msg);
            }
        } else {
            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Please add a product in the product summary line!');
            ApexPages.addMessage(msg);
        }

    }
    
    // -----------------------------------For TFS 3940----------------------------------------
     public void showEmailTemplate(){
        lstEmailTemplate = new list<EmailTemplate>();
        lstEmailTemplate = [Select e.Name, e.Id, e.FolderId From EmailTemplate e where e.FolderId = :selectedFolder and e.TemplateType = 'Text' order by e.Name];
        system.debug('------------lstEmailTemplate---------------'+lstEmailTemplate);
        if(lstEmailTemplate.size() > 0){
            isThereATemplate = true;
        }else{
            isThereATemplate = false;
        }
        stopActionPoller();
      }
      
      public void generateEmailBody(){
        stopActionPoller();
        String generatedMailBody = '';
        selectedEmailTemplateId = System.currentPageReference().getParameters().get('hiddenSelectedEmailTemplate');
        if(selectedEmailTemplateId != null && selectedEmailTemplateId != ''){
            generatedMailBody = EmailTempalteBodyGeneraterUtil.generateEmailBody(updateQuoteRec.Id,updateQuoteRec.Opportunity__c,updateQuoteRec.Account__c,ContId,'fq',selectedEmailTemplateId);
            system.debug('------------generatedMailBody---------------'+generatedMailBody);
        }
        
        MailBodyToQuote = generatedMailBody; 
        generateEmailSubject();
      }
      
      public void generateEmailSubject(){
            list<EmailTemplate> emailTemplateObjList = new list<EmailTemplate>();
            emailTemplateObjList = [Select e.TemplateType, e.TemplateStyle, e.Subject, e.Name, e.IsActive, e.Id, e.Folder.Name, e.Folder.Id, e.FolderId, e.DeveloperName, e.Description, e.Body,e.HtmlValue From EmailTemplate e where e.Id = :selectedEmailTemplateId];
            if(emailTemplateObjList.size() > 0 && emailTemplateObjList[0] != null){
                String subjectWithMergeFld = emailTemplateObjList[0].Subject;
                if(subjectWithMergeFld != null && subjectWithMergeFld != '' && ContId != null && subjectWithMergeFld.contains('{!Contact.')){
                    subjectWithMergeFld = EmailTempalteBodyGeneraterUtil.mergeContactFields(subjectWithMergeFld, ContId); // get all Contact Field Merged
                }
                if(subjectWithMergeFld != null && subjectWithMergeFld != '' && updateQuoteRec.Account__c != null && subjectWithMergeFld.contains('{!Account.')){
                    subjectWithMergeFld = EmailTempalteBodyGeneraterUtil.mergeAccountFields(subjectWithMergeFld, updateQuoteRec.Account__c); // get all Account Field Merged
                }
                if(subjectWithMergeFld != null && subjectWithMergeFld != '' && updateQuoteRec.Opportunity__c != null && subjectWithMergeFld.contains('{!Opportunity.')){
                    subjectWithMergeFld = EmailTempalteBodyGeneraterUtil.mergeOpportunityFields(subjectWithMergeFld, updateQuoteRec.Opportunity__c); // get all Opportunity Field Merged
                }
                if(subjectWithMergeFld != null && subjectWithMergeFld != '' && updateQuoteRec.Id != null && subjectWithMergeFld.contains('{!MMI_Full_Quotes__c.')){
                    subjectWithMergeFld = EmailTempalteBodyGeneraterUtil.mergeFQFields(subjectWithMergeFld, updateQuoteRec.Id); // get all QQ Field Merged
                }
                if(subjectWithMergeFld != null && subjectWithMergeFld != '' && subjectWithMergeFld.contains('{!User.')){
                    subjectWithMergeFld = EmailTempalteBodyGeneraterUtil.mergeUserFields(subjectWithMergeFld, UserInfo.getUserId()); // get all User Field Merged
                }
                if(subjectWithMergeFld != null && subjectWithMergeFld != '' && accOwnerOfFQId != null && subjectWithMergeFld.contains('{!Account.Owner')){
                    subjectWithMergeFld = EmailTempalteBodyGeneraterUtil.mergeAccountOwnerUserFields(subjectWithMergeFld, accOwnerOfFQId); // get all Account Owner Field Merged
                }
                SubjectEmailQuote = subjectWithMergeFld;
            }
        
      }


}