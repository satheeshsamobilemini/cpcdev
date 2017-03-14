public with sharing class QuickQuoteWrapper {
    
    public String DateString{get;set;}

    // ............. Error Message Display .............
    public boolean DisplayErrorPopUp{get;set;}
    public String tabStyle{get;set;}
    
    public String BranchIdSearchWord {get;set;}
    public String BranchNameSearchWord {get;set;}  
    
    public String analysisIdSearchWord {get;set;}
    public String analysisNameSearchWord {get;set;} 
    
    public String chargeCodeIdSearchWord {get;set;}
    public String chargeCodeNameSearchWord {get;set;}
    
    public String writeUpRepIdSearchWord {get;set;}
    public String writeUpRepSearchBranchId {get;set;}  // TFS 4028
    public String writeUpRepNameSearchWord {get;set;}
    
    public String assistingRepIdSearchWord {get;set;}
    public String assistingRepSearchBranchId {get;set;}  // TFS 4028
    public String assistingRepNameSearchWord {get;set;}
    
    public String contactIdSearchWord {get;set;}
    public String contactFNameSearchWord {get;set;}
    public String contactLNameSearchWord {get;set;}
    //Added for issue 1238----------------
    public String oppContactName {get;set;}
    public String oppContactLastName {get;set;}
    public String oppContactPhone {get;set;}
    //Added for issue 1238---------------
    //------TFS----user Comments---------------
    public String oppContactMob {get;set;}
    public String oppContactEmail {get;set;}
    public String primaryContactNo {get;set;}
    
    public String securityDeposit {get;set;}
    public String ExtraRecurringTax {get;set;}
    //------TFS----user Comments---------------
    public String LeadOppName {get;set;}
    public String Transport {get;set;}
    public String FulfillingBranch {get;set;}
    public String Product {get;set;}
    public String DateFrom {get;set;}
    public Integer Quantity {get;set;}
    public String Duration {get;set;}
    public String TransactionType {get;set;} 
    public String Rate {get;set;}
    public String Rate1 {get;set;}
    public String Rate2 {get;set;}
    public String Rate3 {get;set;}
    public String Rate4 {get;set;}
    public String Rate5 {get;set;}
    public String Rate6 {get;set;}
    public String Rate7 {get;set;}
    public String Rate8 {get;set;}
    public boolean isIncludeLLW {get;set;}
    public boolean isFuelSurcharge {get;set;}
    public Integer Locks {get;set;}
    public String DeveloperZone{get;set;}
    public String Rental_PP_E {get;set;}
    public String Delivery {get;set;}
    public String tyleofQuoute{get;set;}
    public String PickUp {get;set;}
    public String FuelSurcharge {get;set;}
    public String delFuelSurcharge {get;set;}
    public String pickupFuelSurcharge {get;set;}
    public String LLW {get;set;}
    public String LocksAmount {get;set;}
    public String Tax {get;set;}
    public String COD {get;set;}
    public String QuickQuote {get;set;}
    public String UserBranchId{get;set;}
    public String Rental_PP_E_Total {get;set;}
    public String DeliveryTotal {get;set;}
    public String PickUpTotal {get;set;}
    public String FuelSurchargeTotal {get;set;}
    public String LLWTotal {get;set;}
    public String LocksAmountTotal {get;set;}
    public String TaxTotal {get;set;}
    public String CODTotal {get;set;}
    public String QuickQuoteTotal {get;set;}
    public String DeliveryFuel {get;set;}
    public String DeliveryFuelTotal {get;set;}
    public String ReturnFuel {get;set;}
    public String ReturnFuelTotal {get;set;}
    public String RecurringMonthlyCharges {get;set;}
    public String RecurringMonthlyChargesTotal {get;set;}
    public String OneTimeCharges {get;set;}
    public String OneTimeChargesTotal {get;set;}
    public String TaxId {get;set;}
    public String SourceOfQQ {get;set;}
    public String selectedOrConvertedContactId {get;set;}
    
    
    
    // Lead Address
    public String Address {get;set;}
    public String City {get;set;}
    public String Country {get;set;}
    public String State {get;set;}
    public String ZipCode {get;set;}
    
    // Product search popup
    public String productSearchWord {get;set;}
    public boolean PrimaryOnly {get;set;}
    public String ProductType {get;set;}  
    public String ProductSize {get;set;}
    public boolean SideRollDoors {get;set;}
    public boolean EndRollDoors {get;set;} 
    public boolean RecordStorage {get;set;}
    public boolean HighCubes {get;set;}
    public boolean Shelving {get;set;} 
    public String distanceFromBranch{get;set;}
    public String CrossStreets{get;set;}
    
    // capacity lookup
    public String deliverySlot{get;set;}
    public String productDescToInsert{get;set;}
    public String longitudeToInsert{get;set;}
    public String latitudeToInsert{get;set;}
    
    //qq from jp
     public String jobProfileId {get;set;}
     public String subContId {get;set;}
     public String contactId {get;set;}
     public String accountId {get;set;}
     public String unitType {get;set;} // TFS 2719
     
    
    public class InnerProductClass
    {
        public String PID {get;set;}
        public String PDescription {get;set;}
        public String PQtyAvail {get;set;}
        public String PQtyFree {get;set;}
        public String PQtyWip {get;set;}
        public String PQtyReserved {get;set;}  
        public String PQtyTotal {get;set;}
        public String PRate1 {get;set;} 
        public String PRate2 {get;set;}
        public String PRate3 {get;set;}
        public String PRate4 {get;set;}
        public String PRate5 {get;set;}
        public String PRate6 {get;set;}
        public String PRate7 {get;set;}
        public String PRate8 {get;set;}
        public String PCommission1 {get;set;}
        public String PCommission2 {get;set;}
        public String PCommission3 {get;set;}
        public String PCommission4 {get;set;}
        public String Pllw {get;set;}
        public String ppe {get;set;}
        public String mainFeature {get;set;}
        public boolean  isSelected {get;set;}
        public Integer RecUniqId {get;set;}
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
     
      public class stateInnerClass
      {
            public String companyId {get;set;}
            public String countryId {get;set;}
            public String Id {get;set;}
            public String Name {get;set;}
      }
        

    public class showbranches
    {
        public boolean isSelected{get;set;}
        public String Id{get;set;}
        public String Name{get;set;}
        public Integer RecUniqId {get;set;}      
    }
    
    
    // ......... Show Buttons .........
     public boolean showValidateAddress{get;set;}
     public boolean showProdSelect{get;set;}
     public boolean showRefreshQUote{get;set;}
     public boolean showSaveButton{get;set;}
     public boolean showSearchError{get;set;}
     public boolean disableReCalcBtn{get;set;}   
       
     public Boolean disableAddressOkButton{get;set;}
     public boolean dispDescAddrPopUp {get;set;}
     public Boolean disableTaxOkButton{get;set;}
     public boolean dispBranchPopUp{get;set;}
     public boolean showProduct{get;set;}
     public boolean showProductPopup{get;set;}
     public boolean showAddressPopup{get;set;}
     public boolean showSearchBranchIdTable {get;set;}
     
     public String address1{get;set;}
     public String address2{get;set;}
     public String address3{get;set;}
     public String address4{get;set;}
     public String state2{get;set;}
     public String zipCode2{get;set;}
     public String countryId2{get;set;}
     public String BranchId{get;set;}
     
        
    //Quick Quote Sales Fleets Wpapper
    public String ecode{get;set;}
    public String netBookValue{get;set;}
    public String marketValue{get;set;}
    public String branchGross{get;set;}
    public String delivaryRate{get;set;}
    public String modificationTotal{get;set;}
    public String totalTax{get;set;}
    public String totalCost{get;set;}
    public String sellingPrice{get;set;}
    public String suggestedPrice{get;set;}
    public String viewBranchUrl{get;set;}
    public String minimumPrice {get;set;}
    public String MarketValueRange20S{get;set;}
	public String MarketValueRange20ZS{get;set;}
    public String MarketValueRange40S{get;set;}
    public String MarketValueRange40ZS{get;set;}
    
    
    //Discovery section
    
    public String Whydoyouneedstorage{get;set;}
    public String Whenwillyouneedyourunit{get;set;}
    public String Whatwillyoubestoring{get;set;}
    public String Howoftenwillyouneedtoaccess{get;set;}
    public String Howlongwillyouneedyourunit{get;set;}
    public String Whoisgoingtobeaccessingyourunit{get;set;}
    public String QuoteComments{get;set;}
    public String followUpTaskComments {get;set;} // TFS 3033
    public boolean ResidentialOnSite{get;set;}
    
    
    public class SalesFleetWapper{
        public String productId {get;set;}
        public String productDescription {get;set;}
        public String ecode {get;set;}
        public String reference {get;set;}
        public String grade {get;set;}
        public String suggestedPrice {get;set;} 
        public String minimumPrice {get;set;}
        public String netBookValue {get;set;}
        public String commissionBonusReason {get;set;}
        public String notes {get;set;}
        public String errorMessage{get;set;}
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
			public integer RecUniqId{get;set;}
	
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