public with sharing class FullQuoteWrapper {
	
	 public String userBranchId{get;set;}
	
	public Integer noOfUnit {get;set;}
	// Sales Full QUote Invoicing fields
	
	public String unitPriceInvoice{get;set;}
	public String BillDiscountInvoice{get;set;}
	public String extrasInvoice{get;set;}
	public String deliveryInvoice{get;set;}
	public String totalInvoice{get;set;}
	public String taxInvoice{get;set;}
	public String SelectedShipingTaxId{get;set;} 
	
	// For input fields in FullQuoteForm_VF page
	public String QouteStatus{get;set;}
	public String TransactionType {get;set;}
	public String startDate{get;set;}
	public String Quoteexpires{get;set;} 
	public String POExpiresdate{get;set;}
	public String LoadedMoveIn{get;set;}
	public String ScheduledDelivery{get;set;}
	public String imageNameForPreivewQuote{get;set;}
	
	
	
	
	public String WriteUpRep {get;set;}
	public String WriteUpRepName {get;set;}
	public String AssistingRep {get;set;}
	public String AssistingRepName {get;set;}
	public String AccountName {get;set;}
	public String AccountId {get;set;}
	public String BillingContactID {get;set;}
	public String ID {get;set;}
	public boolean TaxExempt {get;set;}
	public String Status {get;set;}
	public String Name {get;set;}
	public String LastName {get;set;}
	
	public String conMob {get;set;}
	public String conEmail {get;set;}
	public String primaryContactNo {get;set;}
	public String selectedUserBranchId {get;set;}
	
	
	public String Name1 {get;set;}
	public String telePhone {get;set;}
	public String Address {get;set;}
	public String Fax {get;set;}
	public String Email {get;set;}
	public String City {get;set;}
	public String POContact {get;set;} 
	public String Country {get;set;}
	public String POExpires {get;set;} 
	public String State {get;set;}
	public String County {get;set;}	
	public String zipCode {get;set;}
	public String CreditApproval {get;set;}
	public String TaxExemptAuthorization {get;set;}
	public String JoborLocation {get;set;}
	public String CODInstructions {get;set;}
	public String QuoteTotal {get;set;}
	public String AdSource {get;set;}
	public String CustomerType {get;set;}
	public String Deferred {get;set;}
	public String OutsideRep {get;set;}
	public String CertofInsurance {get;set;} 
	
	public String fulFillingBranchInBilling {get;set;}
	public String fulFillingBranchNameInBilling {get;set;}
	
	// for Invoicing input values

	public String RentalCharge {get;set;}
	public String Terms {get;set;}
	public String PPETotal {get;set;} 
	public String TermsCode {get;set;}
	public String LLWTotal {get;set;} 
	public String InvoicedBalance {get;set;}
	public String DeliveryFee {get;set;}  
	public String LastInvoice {get;set;} 
	public String ReturnFee {get;set;}
	public String YTDSales {get;set;} 
	public String FuelSurchargeFee {get;set;}
	public String LocksTotal {get;set;}
	public String Accessories {get;set;}
	public String TaxTotal {get;set;}
	public String CODAmount {get;set;}
	public String TotalCODAmount {get;set;}
	public String hireNotes {get;set;}
	public String DeliveryInInvoicing {get;set;}
	public String otherInInvoicing {get;set;}
	
	// input values for Product edit section
	public String ItemCode {get;set;}
	public String Reference {get;set;}
	 public transient String ImageUrl {get;set;}
	public String ImageUrlForPDF{get;set;}
	public String ECode {get;set;}
	public String SuggestedPrice {get;set;}
	public String MinPrice {get;set;}
	public String NetBookValue {get;set;}
	public String sellingPrice {get;set;}
	public String assetDescription {get;set;}
	public String GradeDescription {get;set;}
	public String ModificationCost {get;set;}
	public boolean showEcodeValues{get;set;}
	public String MMI {get;set;}
	public String LengthOfRental {get;set;}
	public String InternetCoupon {get;set;}
	public String minimumTerm {get;set;}
	public String national {get;set;}
	public String LockType {get;set;}
	
	public boolean isLead {get;set;}
	public String ModificationComments {get;set;}
	public String ApproverComments {get;set;}
	
	
	// Shipping and Dates VF page input values
	   
	public String rentalLength {get;set;}   	
	public String shippingId {get;set;}   	
	public String NameInShippingDates {get;set;}   
	public String deliveryContactId {get;set;}
	public String AddressInShippingDates {get;set;}
	public String NameInShippingDates1 {get;set;}
	public String cityInShippingDates {get;set;}
	public String countyInShippingDates {get;set;}
	public String stateInShippingDates {get;set;}
	public String countryInShippingDates {get;set;}
	public String fulFillingBranchInShippingDates {get;set;}
	public String fulFillingBranchNameInShippingDates {get;set;}
	public String telInShippingDates {get;set;}
	public String faxInShippingDates {get;set;}
	public String emailInShippingDates {get;set;}
	public String crossStreetInShippingDates {get;set;}
	public String crossStreet2InShippingDates {get;set;}
	public String certOfInsurenceInShippingDates {get;set;}
	public String cityZoneInShippingDates {get;set;}
	public String ZipCodeInShipping {get;set;}	
	public String delTime {get;set;}
	public String delTimeDesc {get;set;}
	public String callFirst {get;set;}
	public String callFirstDesc {get;set;}
	public boolean noReservation {get;set;}
	public String doorDir {get;set;}
	public String doorDirDesc {get;set;}
	public String movementType {get;set;}
	public String movementTypeDesc {get;set;}
	public String appearance {get;set;}
	public String deliverySlot {get;set;}
	public String distFromBranch {get;set;}
	public String deliveryCharge {get;set;} 
	public String pickupCharge {get;set;} 
	public String deliveryInstructions {get;set;}
	public Decimal LLWTotalInShipping {get;set;}
	public String deliveryZoneInShipping {get;set;}
	public Decimal fuelSurchargeInShipping {get;set;}
	public boolean isUseBillingAddress {get;set;}
				
	// for product tab inputs
	
	public String productSearchWord {get;set;}
	public String ProductType {get;set;}
	public String ProductSize {get;set;}
	public boolean PrimaryOnly {get;set;}
	public String deliverySetUp {get;set;}
	public String returnTearDown {get;set;}
	
	public boolean SideRollDoors {get;set;}
    public boolean EndRollDoors {get;set;} 
    public boolean RecordStorage {get;set;}
    public boolean HighCubes {get;set;}
    public boolean Shelving {get;set;}
    public String rentalLengthInProduct {get;set;} 			
	public boolean isCapacityReservedDurinEdit {get;set;}
			
	public String analysisSetSelectedId {get;set;}		
	
	 public boolean isSalesRep{get;set;}
	 public boolean SpecialInstructions {get;set;} //TFS 3035
	 public String storageUse {get;set;} //TFS 3262
	
	 
	 public String sourceId {get;set;}	
	 public String unitType {get;set;}	// TFS 2719
	 
	 //fq from jp
     public String jobProfileId {get;set;}
     public String subContId {get;set;}
     public String contactId {get;set;}
     public String accIdOfJp {get;set;}
     public String selectedOrPgContId {get;set;}
	 public Boolean isQuoteUpdatedOnce {get;set;}
	 public String fqComments {get;set;}	
	
	 public class lockTypesAndQuantity
        {
            public String LockName {get;set;}
            public String LockDescription {get;set;}
            public Boolean isLockselected {get;set;}
            public Integer lockQuantity {get;set;}
            public String LockPrice {get;set;}
        } 
	 
	 public class stateInnerClass
        {
                public String companyId {get;set;}
                public String countryId {get;set;}
                public String Id {get;set;}
                public String Name {get;set;}
        }  		
        
	
		 public class AddressInnerClass
	    {
	        public String Id {get;set;}
	        public String taxAreaStatus {get;set;}
	        public String country {get;set;}
	        public String countryDescription {get;set;}
	        public String country1 {get;set;}
	        public String state {get;set;}
	        public String stateDescription {get;set;}
	        public String city {get;set;}
	        public Boolean isSelected {get;set;}
	        public Integer RecUniqId {get;set;}
	    }
	    
	         public class DescarteInnerClass
        {
                public String companyId {get;set;}      
                public String branchId {get;set;}
                public String address1 {get;set;}
                public String address2 {get;set;}
                public String address3 {get;set;}
                public String address4 {get;set;}
                public String countryId {get;set;}
                public String state {get;set;}
                public String zipCode {get;set;}
                public String crossStreet1 {get;set;}
                public String crossStreet2 {get;set;}
                public String taxId {get;set;}
                public String distanceFromBranch {get;set;}
                public String deliveryZone {get;set;}
                public String zoneWarning {get;set;}
                public String latitude {get;set;}
                public String longitude {get;set;}
                public String distanceBranch {get;set;}
                public String fulfillingBranch {get;set;}
                public String fulfillingBranchName {get;set;}
                public String oldPostalCode {get;set;}
                public boolean isSelected {get;set;}
                public Integer RecUniqId {get;set;}             
        }
        
        public boolean showValidateAddressPopUp {get;set;}
        public boolean showValidateAddressShippingPopUp {get;set;}
        	public boolean showTaxIdShippingPopUp {get;set;}
        	public boolean showTaxIdBillingPopUp {get;set;}
        public boolean showBranchPopUp {get;set;}
        public boolean addressPopUp {get;set;}
    	public boolean shippingAddressPopUp {get;set;}
    	public boolean showAccountPopUp {get;set;}
    	public boolean showEcodePopUp {get;set;}
    	public boolean contactShippingPopUp {get;set;}
    	//---added for Contcat add / edit----------------------------
    	public String contFn {get;set;}
    	public String contLn {get;set;}
    	public String contEmail {get;set;}
    	public String contPhone {get;set;}
    	public String contFax {get;set;}
    	public boolean contIsPrimary {get;set;}
    	public boolean contIsActive {get;set;}
    	public boolean addContactPopup {get;set;}
    	//---added for Card add / edit----------------------------
    	public String cardFirstName {get;set;}
    	public String cardLastName {get;set;}
    	public String cardStreetAddress {get;set;}
    	public String cardCity {get;set;}
    	public String cardState {get;set;}
    	public String cardCountry {get;set;}
    	public String cardZip {get;set;}
    	public String cardEmail {get;set;}
    	public String cardDefaultAddressCode {get;set;}
    	public String cardUserPassword {get;set;}
    	public String cardPaymentType {get;set;}
    	public String cardType {get;set;}
    	public String cardNumber {get;set;}
    	public String cardExpiryMonth {get;set;}
    	public String cardExpiryYear {get;set;}
    	public String cardAdditionalSecurityData {get;set;}
    	public boolean addCardPopup {get;set;}
    	
    	
    	//---added for ACH add / edit----------------------------
    	public String achFirstName {get;set;}
    	public String achBankName {get;set;}
    	public String achLastName {get;set;}
    	public String achBankAccNo {get;set;}
    	public String achEmail {get;set;}
    	public String achBankSortCode {get;set;}
    	public String achPhone {get;set;}
    	public String achBankAccType {get;set;}
    	public String achStreet {get;set;}
    	public String achCheckType {get;set;}
    	public String achCity {get;set;}
    	public String achBankCity {get;set;}
    	public String achCountry {get;set;}
    	public String achBankState {get;set;}
    	public String achState {get;set;}
    	public String achDefaultAddressCode {get;set;}
    	public String achZip {get;set;}
    	public String achUserPassword {get;set;}
    	
    	
    	
    	public boolean showAnalysisCodePopup {get;set;}
    	public boolean contactPopup {get;set;}
    	
    	public boolean showEditProduct {get;set;}
    	public boolean showMinimumTermPopUp {get;set;}
    	public boolean showAnalysisCodePopupInProduct {get;set;}
    	public boolean showBranchBillingPopUp {get;set;}
    	public boolean showAnalysisCodeShippingPopup {get;set;}
    	public boolean showErrorPopUp {get;set;} 						// To show error popup
    	public boolean showSearchBranchIdTable {get;set;} 				// To show fulfilling branch search list in billing
    	public boolean showSearchBranchShippingIdTable {get;set;} 		// To show fulfilling branch search list in shipping
    	public boolean showSearchAnalysisSetCodeInBilling {get;set;} 	// To show analysis search list in billing screen
    	public boolean showSearchAnalysisSetCodeInShipping {get;set;} 	// To show analysis search list in shipping screen
    	public boolean showSearchChargeCodeList {get;set;} 				// To show charge code search list in product screen
    	public boolean showWriteUpRepSearchList {get;set;}				// To show write up rep search list in billing screen
    	public boolean showAssistingRepSearchList {get;set;}			// To show assisting rep search list in billing screen
    	public boolean showContactSearchInBilling {get;set;}			// To show contact search list in billing screen
    	public boolean showContactSearchInShipping {get;set;}			// To show contact search list in shipping screen
    	
    	public boolean enable1Period {get;set;}
    	public boolean enable2To6Period {get;set;}
    	public boolean enable7To12Period {get;set;}
    	public boolean enable13Period {get;set;}  
    	
    	public boolean enableVAddresBtnInBilling {get;set;}    // To enable the validate address button in billing screen
    	
    	// Variables to enable or disable buttons
    	
    	public boolean enableRefreshQuote {get;set;}
    	public boolean enableSaveQuote {get;set;}
    	public boolean convertQuoteToOrder{get;set;}
    	public Boolean enableProductadd{get;set;}
    	public boolean enableVAddresBtnInShipping {get;set;} // To enable the validate address button in shipping screen
    	public boolean enableMarkAsLostButton{get;set;}	  
    	public boolean fullfillingBranch{get;set;}
		public boolean invoiceTabEnableDis{get;set;}
    	 
    	public boolean startDateonchange{get;set;}
    	public boolean analysisSetHeadValue{get;set;}
    	
    	public boolean isBillingAddressValidated {get;set;}
    	public boolean isShippingAddressValidated {get;set;}  	
    	 
    	
    	 public boolean showCapacityLookupPopup{get;set;}
    	 public String selectedFullQUote{get;set;}
    	public boolean showSalesfleet{get;set;}
    	
    	public boolean showSalesRepPopup{get;set;}
    	   public String reserveCapacityId{get;set;}
     public boolean showReserveCapacityId{get;set;}
     
    public List<HomeBaseBeans.AnalysisSetHeaders> analysisSetHeaderLstNew {get;set;}
    
     public boolean showOrderPopUp {get;set;}
     public String OrderMessage {get;set;}
     public String orderQuoteId {get;set;}
     public String orderContractId {get;set;}
     
      
     public boolean showCapacityPopUp {get;set;}
       public boolean ifCapacityYes {get;set;} 
     
     public class stdModification
     {
     	    public String modId {get;set;}
            public String price {get;set;}
            public String modificationOption {get;set;}
            public Boolean isSelected {get;set;}
            public String Quantity {get;set;}
            public Boolean isSubmmited {get;set;}
            public Boolean isApproved {get;set;}
            public Boolean isRejected {get;set;}
            public String Submitter {get;set;}
            public String Approver {get;set;}
            public DateTime WorkflowActionDateTime {get;set;}
            public String WorkflowStatus {get;set;}
            public Boolean isModificationCompleted {get;set;}
            public Integer sequence {get;set;}
            public String sourceID {get;set;}
                  
        } 
        
         public boolean disableModificationPrice {get;set;}
         public boolean disableModificationSelection {get;set;}
         public boolean showSubmitButton {get;set;}
	 
        
        
        public class ApproverList
     {
     	    public String emailID {get;set;}
            public String fulfillingBranch {get;set;}
            public String name {get;set;}
            public integer recId {get;set;}
          
        } 
 
        
        public class quote {
			public String quoteNumber{get;set;}
			public double mobilisation{get;set;}
			public String region{get;set;}
			public String quoteCreated{get;set;}
			public String quoteDate{get;set;}
			public String salesRep{get;set;}
			public String documentType{get;set;}
			public String transactionCode{get;set;}
			public String itemDefinitionCode{get;set;}
			public String itemDescription{get;set;}
			public String ecode{get;set;}
			public String binLocation{get;set;}
			public String price{get;set;}
			public String deliveryCharges{get;set;}
			public String deliverySurcharge{get;set;}
			public String pickupCharges{get;set;}
			public String pickupSurcharge{get;set;}
			public String branchId{get;set;}
			public String productId{get;set;} 
			public String deliveryRate{get;set;}
			public String pickupRate{get;set;}
			public String activationDate{get;set;}
			
			//for Order list


	    }
	    
	    public class ProductSales {
			public String area{get;set;}
			public String blowout{get;set;}
			public String companyId{get;set;}
			public String displayPicture{get;set;}
			public String eCode{get;set;}
			public String fulfillingBranchCode{get;set;}
			public String gradeCode{get;set;}
			public String gradeDescription{get;set;}
			public String itemRef{get;set;} 
			public String lineItemID{get;set;}
			public double minimumPrice{get;set;}
			public double nbv{get;set;}
			public String notes{get;set;}
			public String reasonCode{get;set;}
			public String status{get;set;}
			public double suggestedPrice{get;set;}
			public integer recId{get;set;}
			public List<SalesImages> imagesSalesInv{get;set;}
	 
	    }
	    
	    public class SalesImages{
	    	public String imageURL{get;set;}
			public String perentId{get;set;}
			public String sfdcRecId{get;set;}
	    }
	    
	    
public class NewCustomerAccount {
			public String name{get;set;}
			public String invoicedBalance{get;set;}
			public String lastInvoiceDate{get;set;}
			public String taxExemptionCertificate{get;set;} 
			public String taxExempt{get;set;}
			public String creditStatus{get;set;}
			public String duplicateNo{get;set;}
			public String dateCreated{get;set;}
			public String createdBy{get;set;}
			public String status{get;set;}
			public String phoneNumber{get;set;}
			public String salesforceId{get;set;}
			public String addressType{get;set;}
			public String accountType{get;set;}
			public String id{get;set;}
			public String ytdSales{get;set;}
			
			public String addressNo{get;set;}
			public String addressLine1{get;set;}
			public String addressLine2{get;set;}
			public String addressLine3{get;set;}
			public String addressLine4{get;set;}
			public String state{get;set;}
			public String countryId{get;set;}
			public String zipCode{get;set;}
			
			public integer recId {get;set;}
			
	
	    }
	    
	     public class ContactEmailId {
			public Contact conRec{get;set;}
			public Boolean IsSelected{get;set;}
	     }
	    
	     
	     public class productTypes
    {
        public boolean isSelected{get;set;}
        public String productType{get;set;}
        public Integer RecUniqId {get;set;}      
    }
    
    public class productSizes
    {
        public boolean isSelected{get;set;}
        public String productSize{get;set;}
        public Integer RecUniqId {get;set;}      
    }
	    
	     
}