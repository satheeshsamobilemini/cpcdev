/**************************************************************************
Name:  HomeBaseBeans()
Copyright ? 2013  MMI
----------------------------------------------------------------------
Purpose:
This class is wrapper class to hold the response from MMI webservices 
-----------------------------------------------------------------------
History:

VERSION  AUTHOR                 DATE        DETAIL              
1.0  -  TEKsystems             11/2/2013   INITIAL DEVELOPMENT  
**************************************************************************/
public with sharing class HomeBaseBeans 
{
	// Generic address class
	
	public class AddressBean
	{
		public String street{get;set;}
		public String city{get;set;}
		public String state{get;set;}
		public String country{get;set;}
		public String zip{get;set;}
		public String county{get;set;}
		public String transactionType{get;set;}
		public String BranchId {get;set;}
		public String crossStreet{get;set;}
		public String fulfillingId{get;set;}
		public String fulfillingName{get;set;}
	}
	
	
	// Product search class
	
	public class ProductSearch
	{
		public String pattern{get;set;}
		public String defId{get;set;}
		public boolean primaryOnly{get;set;}
		public Integer minsize{get;set;}
		public Integer maxsize{get;set;}
		public String QuoteType{get;set;}
	}
	
	// Branch response inner class 
	
	    public class Branches
	    {
	        public String id{get;set;}
	        public String name{get;set;}
	        
	        public boolean isSelected {get;set;}
	        public String errorMessage{get;set;}
	    }
    
    // Quick Quote request formation class
    
    	public class QuickQuoteRefreshFormat
    	{
    		public String LeadOppName{get;set;}
    		public String tyleofQuoute{get;set;}
    		public String Delivery{get;set;}
    		public String Transport{get;set;}
    		public Integer Qty{get;set;}
    		public Integer Duration{get;set;}
    		public String FulfillingBranch{get;set;}
    		public String Product{get;set;}
    		public Date PrDate{get;set;}
    		public String TransactionType{get;set;}
    		public String Rate{get;set;}
    		public Integer Locks{get;set;}
    		public boolean isIncludeLLW{get;set;}
    		public boolean isFuelSurcharge{get;set;}
    		public String Address{get;set;}
    		public String City{get;set;}
    		public String State{get;set;}
    		public String country{get;set;}
    		public String zipcode{get;set;}
    		public String TaxId{get;set;}
    		public String TaxTotal{get;set;}
    		public String Devzone{get;set;}
    		public String BranchId{get;set;}
    		public String ecode{get;set;}
    		public String modificationCharge{get;set;}
    	}
    	
    // State response inner class
        public class States
        {               
                public String companyId ;
                public String countryId ;
                public String id ;
                public String Name ;
                public String errorMessage{get;set;}
                public States(String cmyId, String cuntryId, String Id, String name)
                {
                        this.Name = name;
                        this.companyId = cmyId;
                        this.countryId = cuntryId;
                        this.id = Id;
                }
                
                public States()
                {
                	
                }
        } 
        
    // Country resonse inner class
    	public class countries
        {               
                public String id ;
                public String Name ;
                public String errorMessage{get;set;}
                public countries( String Id, String name)
                {
                        this.Name = name;
                        this.id = Id;
                }
                
                public countries()
                {
                	
                }
        }
        
    // Transaction response inner class
    
    	public class transactions
        {
                public String Id;
                public String description;
                public String errorMessage{get;set;}
                public transactions(String id,String description)
                {
                        this.Id = Id;
                        this.description = description;
                }
                
                public transactions()
                {}
        }
        
    // Descartes Address Lookup inner class
    
	    public class webAddresses
	    {
	        public String companyId;
	        public String branchId;
	        public String address1;
	        public String address2;
	        public String address3;
	        public String address4;
	        public String state;
	        public String zipCode;
	        public String countryId;
	        public String crossStreet1;
	        public String crossStreet2;
	        public String taxId;
	        public String distanceFromBranch;
	        public String deliveryZone;
	        public String zoneWarning;
	        public String latitude;
	        public String longitude;
	        public String distanceBranch;
	        public String fulfillingBranchId;
	        public String fulfillingBranchName;
	        public String oldPostalCode;
	        public String errorMessage{get;set;}
	        public boolean isSelected {get;set;}
	        
	        public webAddresses()
                {}
                
	        public webAddresses(String cmyId, String branchId, String addr1, String addr2, String addr3, String addr4,
	                                                String state, String zipCode, String countryId, String cStreet1, String cStreet2, String taxId,
	                                                String distanceFromBranch, String deliveryZone, String zoneWarning, String latitude, String longitude,
	                                                String distanceBranch, String fulfillingBranchId, String fulfillingBranchName, String oldPostalCode )
	        {
	                this.companyId = cmyId;
	                this.branchId = branchId;
	                this.address1 = addr1;
	                this.address2 = addr2;
	                this.address3 = addr3;
	                this.address4 = addr4;  
	                this.state = state;
	                this.zipCode = zipCode;
	                this.countryId = countryId;
	                this.crossStreet1 = cStreet1;
	                this.crossStreet2 = cStreet2;
	                this.taxId = taxId;
	                this.distanceFromBranch = distanceFromBranch;
	                this.deliveryZone = deliveryZone;
	                this.zoneWarning = zoneWarning;
	                this.latitude = latitude;
	                this.longitude = longitude;
	                this.distanceBranch = distanceBranch;
	                this.fulfillingBranchId = fulfillingBranchId;
	                this.fulfillingBranchName = fulfillingBranchName;
	                this.oldPostalCode = oldPostalCode;
	        }
	    }
	    
	 // Validate address response inner class
	 
	 	public class TaxIds
        {
                public String Id {get;set;}
                public String taxAreaStatus {get;set;}
                public String country {get;set;}
                public String countryDescription {get;set;}
                public String country1 {get;set;}
                public String state {get;set;}
                public String stateDescription {get;set;}
                public String city {get;set;}
                public String errorMessage{get;set;}
                public boolean isSelected {get;set;}
                public Integer RecUniqId {get;set;}
                
                public TaxIds()
                {}
                
                public TaxIds(String Id, String tas, String country, String CouDesc, String country1, String state, String stateDesc, String city)
                {
                        this.Id = Id;
                        this.taxAreaStatus = tas;
                        this.country = country;
                        this.countryDescription = CouDesc;
                        this.country1 = country1;
                        this.state = state;
                        this.stateDescription = stateDesc;
                        this.city = city; 
                }
        }
        
   // Product webservice inner class
   
    public class Products{
    	
        public String Id {get;set;}
        public String Description {get;set;}
        public String qtyAvail {get;set;}
        public String qtyFree {get;set;}
        public String qtyWip {get;set;}
        public String qtyWip1 {get;set;}
        public String qtyWip2 {get;set;}
        public String qtyWip3 {get;set;}
        public String qtyWip4 {get;set;}
        public String qtyWip5 {get;set;}
        public String qtyWip6 {get;set;}
        public String qtyWip7 {get;set;}
        public String qtyWip8 {get;set;}
        public String qtyWip9 {get;set;}
        public String qtyWip10 {get;set;}
        public String HILRM {get;set;}
        public String qtyRented {get;set;}
        public String UtilPercent {get;set;}
        public String thumbnailUrl {get;set;}
        
        public String qtyReserved {get;set;}
        public String qtyTotal {get;set;}
        public String commission1 {get;set;}
        public String commission2 {get;set;}
        public String commission3 {get;set;}
        public String commission4 {get;set;}      
        public String llw {get;set;}
        public String ppe {get;set;}
        public String mainFeature {get;set;}
        public rates rate1 {get;set;}
        public rates rate2 {get;set;}
        public rates rate3 {get;set;}
        public rates rate4 {get;set;}
        public rates rate5 {get;set;}
        public rates rate6 {get;set;}
        public rates rate7 {get;set;}
        public rates rate8 {get;set;}
        public String errorMessage{get;set;}
        public boolean isSelected {get;set;} 
        public Integer lineCount {get;set;} 
        public String LockType {get;set;} 
        
        public Decimal quantity {get;set;}
        public String lineValue {get;set;}                        
        
        public Products()
                {}
                
        public Products(String Id, String des , String qtyavail, String qFree, String qWip, String qReserved,
                                         String qTotal, String cmm1,String cmm2,String cmm3,String cmm4,String llw, String ppe, String mainFeature)
                                        
        {
                this.Id = Id;
                this.Description = des;
                this.qtyAvail = qtyavail;               
                              
                this.qtyFree = qFree;
                this.qtyWip = qWip;
                this.qtyReserved = qReserved;
                this.qtyTotal = qTotal;
                this.commission1 = cmm1;
                this.commission2 = cmm2; 
                this.commission3 = cmm3;
                this.commission4 = cmm4;
                this.llw = llw;
                this.ppe = ppe;
                this.mainFeature = mainFeature;
                               
                rate1 = new rates();
                rate2 = new rates();
                rate3 = new rates();
                rate4 = new rates();
                rate5 = new rates();
                rate6 = new rates();
                rate7 = new rates();
                rate8 = new rates();                
                
        }
    } 
    
    // Specific product webservice innerclass
    
    public class product
    {
    	public String id {get;set;}
    	public String description {get;set;}
    	public boolean ecoded {get;set;}
    	public String qtyAvail {get;set;}
    	public String qtyFree {get;set;}
    	public String qtyWip {get;set;}
    	public String qtyReserved {get;set;}
    	public String qtyTotal {get;set;}
    	public String chargeCode {get;set;}
    	
    	public String commission1 {get;set;}
        public String commission2 {get;set;}
        public String commission3 {get;set;}
        public String commission4 {get;set;} 
    	
    	public rates rate1 {get;set;}
        public rates rate2 {get;set;}
        public rates rate3 {get;set;}
        public rates rate4 {get;set;}
        public rates rate5 {get;set;}
        public rates rate6 {get;set;}
        public rates rate7 {get;set;}
        public rates rate8 {get;set;}
        
        public String errorMessage {get;set;}
        
        public product()
        	{}
        	
        public product(String id, String description, boolean ecoded, String qtyAvail, String qtyFree, String qtyWip,
        				String qtyReserved, String qtyTotal, String chargeCode, String commission1, String commission2,
        				String commission3, String commission4)
        {
        	this.id = id;
        	this.description = description;
        	this.ecoded = ecoded;
        	this.qtyAvail = qtyAvail;
        	this.qtyFree = qtyFree;
        	this.qtyWip = qtyWip;
        	this.qtyReserved = qtyReserved;
        	this.qtyTotal = qtyTotal;
        	this.chargeCode = chargeCode;
        	
        	this.commission1 = commission1;
            this.commission2 = commission2; 
            this.commission3 = commission3;
            this.commission4 = commission4;
        	
        	rate1 = new rates();
            rate2 = new rates();
            rate3 = new rates();
            rate4 = new rates();
            rate5 = new rates();
            rate6 = new rates();
            rate7 = new rates();
            rate8 = new rates();   
        	
        }
        
    }   
    
    public class rates
    {
        public String rate{get;set;}
        public String description{get;set;}
        public boolean editable{get;set;}
        
        public rates()
        {
        	
        }
        
        public rates(String rate,String description)
        {
        	this.rate = rate;
        	this.description = description;
        }
        
    }
    
     public class payment
    {
        public Double payment{get;set;}
        public date dueDate{get;set;}
        
        public payment()
        {
        	
        }
        
        public payment(Double payment,Date dueDate)
        {
        	this.payment = payment;
        	this.dueDate = dueDate;
        }
        
    }
    
    
    // Quick Quote Refresh Inner Class
    
    public class quickQuoteRefresh
        {
                public String lead{get;set;}
                public String transactionId{get;set;}
                public String accountId{get;set;}
                public String ecode{get;set;}
                public String productId{get;set;}
                public String salesRep{get;set;}
                public String transport{get;set;}
                public String operatorId{get;set;}
                public String companyId{get;set;}
                public String certificate{get;set;}
                public String branchId{get;set;}
                public String rate{get;set;}
                public String lineValue{get;set;}
                public String modificationCharge{get;set;}
                public String rentalPPETotal{get;set;}
                public String transportTotal{get;set;}
                public String transportSurchargeTotal{get;set;}
                public String pickupSurchargeTotal{get;set;}
                public String llwTotal{get;set;}
                public String locksPrice{get;set;}
                public String locksTotal{get;set;}
                public String taxTotal{get;set;}
                public String pickUpTotal{get;set;}
                public String codAmount{get;set;}
                public String quickQuoteTotal{get;set;}
                public String reoccurringCharge{get;set;}
                public String locksQty{get;set;}
                public String multipleUnitsQty{get;set;}
                public String dateFrom{get;set;}
                public String id{get;set;}
                public String duration{get;set;}
                public String status{get;set;}
                public String includeLLW{get;set;}
                public String fuelSurcharge{get;set;}
                public String salesQuoteConvertible{get;set;}
                public String rentalQuoteConvertible{get;set;}
                public shippingAddress2 shippingAddress2 ;
                public String errorMessage{get;set;}
                
             /*   public quickQuoteRefresh()
                {}
                
                
                public quickQuoteRefresh(String lead,String transactionId,
                 String accountId,
                 String ecode,
                 String productId,
                 String salesRep,
                 String transport,
                 String operatorId,
                 String companyId,
                 String certificate,
                 String branchId,
                 String rate,
                 String lineValue,
                 String modificationCharge,
                 String rentalPPETotal,
                 String transportTotal,
                 String transportSurchargeTotal,
                 String pickupSurchargeTotal,
                 String llwTotal,
                 String locksPrice,
                 String locksTotal,
                 String taxTotal,
                 String pickUpTotal,
                 String codAmount,
                 String quickQuoteTotal,
                 String reoccurringCharge,
                 String locksQty,
                 String multipleUnitsQty,
                 String dateFrom,
                 String id,
                 String duration,
                 String status,
                 String includeLLW,
                 String fuelSurcharge,
                 String salesQuoteConvertible,
                 String rentalQuoteConvertible)
                {
                        this.lead = lead;
                        this.transactionId = transactionId;
                         this.accountId = accountId;
                         this.ecode = ecode;
                         this.productId = productId;
                         this.salesRep = salesRep; 
                         this.transport = transport;
                         this.operatorId = operatorId;
                         this.companyId = companyId;
                         this.certificate = certificate;
                         this.branchId = branchId;
                         this.rate = rate;
                         this.lineValue = lineValue;
                         this.modificationCharge = modificationCharge;
                         this.rentalPPETotal = rentalPPETotal; 
                         this.transportTotal = transportTotal;
                         this.transportSurchargeTotal = transportSurchargeTotal;
                         this.pickupSurchargeTotal = pickupSurchargeTotal;
                         this.llwTotal = llwTotal;
                         this.locksPrice = locksPrice;
                         this.locksTotal = locksTotal;
                         this.taxTotal = taxTotal;
                         this.pickUpTotal = pickUpTotal;
                         this.codAmount = codAmount;
                         this.quickQuoteTotal = quickQuoteTotal;
                         this.reoccurringCharge = reoccurringCharge;
                         this.locksQty = locksQty;
                         this.multipleUnitsQty = multipleUnitsQty;
                         this.dateFrom = dateFrom;
                         this.id = id;
                         this.duration = duration;
                         this.status = status;
                         this.includeLLW = includeLLW;
                         this.fuelSurcharge = fuelSurcharge;
                         this.salesQuoteConvertible = salesQuoteConvertible;
                         this.rentalQuoteConvertible = rentalQuoteConvertible;
                         shippingAddress2 = new shippingAddress2();
                }*/
                
                
        }
        
        public class shippingAddress2
        {
                public shippingAddress2(){}
                public String address1{get;set;}
                public String address2{get;set;}
                public String address3{get;set;}
                public String address4{get;set;}
                public String state{get;set;}
                public String zipCode{get;set;}
                public String countryId{get;set;}
                public String crossStreet1{get;set;}
                public String crossStreet2{get;set;}
                public String taxId{get;set;}
                public String distanceFromBranch{get;set;}
                public String deliveryZone{get;set;}
                public String zoneWarning{get;set;}
                public String latitude{get;set;}
                public String longitude{get;set;}
                public String distanceBranch{get;set;}
                public String fulfillingBranchId{get;set;}
                public String fulfillingBranchName{get;set;}
                public String oldPostalCode{get;set;}
                public String addressValidated{get;set;}
                
                public shippingAddress2(String address1,
                                        String address2,
                                        String address3,
                                        String address4,
                                        String state,
                                        String zipCode,
                                        String countryId,
                                        String crossStreet1,
                                        String crossStreet2,
                                        String taxId,
                                        String distanceFromBranch,
                                        String deliveryZone,
                                        String zoneWarning,
                                        String latitude,
                                        String longitude,
                                        String distanceBranch,
                                        String fulfillingBranchId,
                                        String fulfillingBranchName,
                                        String oldPostalCode,
                                        String addressValidated)
                                        {
                                                this.address1 = address1; 
                                                this.address2 = address2; 
                                                this.address3 = address3; 
                                                this.address4 = address4; 
                                                this.state = state; 
                                                this.zipCode = zipCode; 
                                                this.countryId = countryId; 
                                                this.crossStreet1 = crossStreet1; 
                                                this.crossStreet2 = crossStreet2; 
                                                this.taxId = taxId; 
                                                this.distanceFromBranch = distanceFromBranch;
                                                this.deliveryZone = deliveryZone;
                                                this.zoneWarning = zoneWarning; 
                                                this.latitude = latitude; 
                                                this.longitude = longitude; 
                                                this.distanceBranch = distanceBranch; 
                                                this.fulfillingBranchId = fulfillingBranchId; 
                                                this.fulfillingBranchName = fulfillingBranchName; 
                                                this.oldPostalCode = oldPostalCode; 
                                                this.addressValidated = addressValidated; 
                                        }
        }
        
        // Create Quick Quote Request
        
        public class CreateQuickQuoteRequest
        {
        	public String Duration{get;set;}
        	public String LeadOppName{get;set;}
        	public String transport{get;set;}
        	public String transactionId{get;set;}
        	public String rate{get;set;}
        	public String rentalPPETotal{get;set;}
        	public String quickQuoteTotal{get;set;}
        	public String dateFrom{get;set;}
        	public String state{get;set;}
        	public String countryId{get;set;}
        	public String address1{get;set;}
        	public String address2{get;set;}
        	public String address3{get;set;}
        	public String address4{get;set;}
        	public String zipCode{get;set;}
        	public String taxId{get;set;}
        	public String fulfillingBranchId{get;set;}
        	public String accountId{get;set;}
        	public String productId{get;set;}
        	public String branchId{get;set;}
        	public String llwTotal{get;set;}
        	public String locksTotal{get;set;}
        	public String taxTotal{get;set;}
        	public String codAmount{get;set;}
        	public String includeLLW{get;set;}
        	public String fuelSurcharge{get;set;}
        	public String locksQty{get;set;}
        	public String companyId{get;set;}
        	public String operatorId{get;set;}
        	public String salesRep{get;set;}
        	public String status{get;set;}
        	
        }
        
        public class CreateQuoteResponse
		{
			public String documentId{get;set;}
			public String errorMessage{get;set;}
		}
		
		// For full quote create response
		
		public class CreateFullQuoteResponse
		{
			public String companyId {get;set;}
			public String documentId {get;set;}
			public String type {get;set;}
			public String mobilization {get;set;}
			
			public String errorMessage {get;set;}
		}
	
		// Full Quote Billing Contact ID response inner class
		
		public class contactSummaryList
		{			
			public String surname {get;set;}
			public String contactId {get;set;}
			public String emailId {get;set;}
			public String forename {get;set;}
			
			public String phoneNumber{get;set;}
			public String email{get;set;}
			public String position{get;set;}
			public String cellMobile{get;set;}
			public String contactStatus{get;set;}
			public String contactStatusDescription{get;set;}
			public String contactTypeId{get;set;}
			public String contactTypeDescription{get;set;}
			public String mainContact{get;set;}
			public String phoneExtension{get;set;}
			public String faxNumber{get;set;}
			public String companyNumber{get;set;}
			public String companyName{get;set;}
			public String salesPersonId{get;set;}
			public String salesPersonName{get;set;}
			public String branchId{get;set;}
			public String branchName{get;set;}
			
			
			
			public String errorMessage{get;set;}
			public boolean isSelected {get;set;}
			
			public contactSummaryList()
				{}
			
			public contactSummaryList(String surname,
									  String contactId,
									  String emailId,
									  String forename)
									  {
									  	   this.surname = surname;
									  	   this.emailId = emailId;
									  	   this.contactId = contactId;
									  	   this.forename = forename;						  	
									  }
			
		}
		
		// Full Quote specific contact response inner class
		
		public class contact
		{
			public String surname {get;set;}
			public String position {get;set;}
			public String email {get;set;}
			public String contactId {get;set;}
			public String forename {get;set;}
			public String telNumber {get;set;}
			public String telMobile {get;set;}
			public String errorMessage {get;set;}
			
			public contact()
				{}
				
			public contact(String surname,
						   String position,
						   String email,
						   String contactId,
						   String forename,
						   String telNumber,
						   String telMobile)
						   {
						   		this.surname = surname;
						   		this.position = position;
						   		this.email = email;
						   		this.contactId = contactId;
						   		this.forename = forename;
						   		this.telNumber = telNumber;
						   		this.telMobile = telMobile;
						   }
		}
		
		// Full Quote Analysis Headers inner class
		
		public class AnalysisSetHeaders
		{
				public String id{get;set;}
				public String description{get;set;}
				public String Longdescription{get;set;}
				public String errorMessage{get;set;}
				public boolean isSelected {get;set;}
				public String selectedId {get;set;}
				public String selectedDescription {get;set;}				
				public boolean isEnabled {get;set;}
				public List<SelectOption> selectOptionList {get;set;}
		}	
		
		// Full Quote Analysis Codes inner class
		
		
		public class analysisSetCodes
		{
				public String id{get;set;}
				public String description{get;set;}
				public String Longdescription{get;set;}
				public String errorMessage{get;set;}
				public boolean isSelected {get;set;}
		}
		
		// Full Quote Address inner Class
		
		public class addresses
		{
				public String addressNo{get;set;}
				public String addressLine1{get;set;}
				public String addressLine2{get;set;}
				public String addressLine3 {get;set;}
				public String addressLine4{get;set;}
				public String state{get;set;}
				public String zipCode{get;set;}
				public String countryId {get;set;}
				public String County{get;set;}
				
				public boolean isInvoiceAddress{get;set;}
				public boolean isDeliveryAddress {get;set;}
				public boolean invoiceAddress{get;set;}
				public boolean deliveryAddress {get;set;}
				
				public boolean isSelected {get;set;}
				public String errorMessage{get;set;}
		}
		
		// Full Quote Accounts Service inner class
		
		public class account
		{
			public String name {get;set;}
			public String id {get;set;}
			public decimal invoicedBalance {get;set;}
			public String lastInvoiceDate {get;set;}
			public String salesTerms {get;set;}
			public String termsCode {get;set;}
			public Decimal ytdSales {get;set;}
			public String rentalTerms {get;set;}
			public String taxExemptionCertificate {get;set;}
			public boolean taxExempt {get;set;}
			public String creditStatus {get;set;}
			public String certificateOfInsurance {get;set;}
			
			public accountAddress accountAddress {get;set;}
			public list<analysisDtls> analysisDetails{get;set;}
			public boolean isSelected {get;set;}
			public String errorMessage{get;set;}
			
			public account()
				{
					analysisDetails = new list<analysisDtls>();
				}
			
			public account(String name, 
						   String id,
						   Decimal invoicedBalance,
						   String lastInvoiceDate,
						   String salesTerms,
						   String termsCode,
						   Decimal ytdSales,
						   String rentalTerms,
						   String taxExemptionCertificate,
						   boolean taxExempt,
						   String creditStatus,
						   String certificateOfInsurance)
			{
				this.name = name;
				this.id = id;
				this.invoicedBalance = invoicedBalance;
				this.lastInvoiceDate = lastInvoiceDate;
				this.salesTerms = salesTerms;
				this.termsCode = termsCode;
				this.ytdSales = ytdSales;
				this.rentalTerms = rentalTerms;
				this.taxExemptionCertificate = taxExemptionCertificate;
				this.taxExempt = taxExempt;
				this.creditStatus = creditStatus;
				this.certificateOfInsurance = certificateOfInsurance;
				
				accountAddress = new accountAddress();
			}
		}
		
		public class analysisDtls{
			public String longDescription {get;set;}
			public String setCodeId {get;set;}
			public String setCodeInternal {get;set;}
			public String setLabel {get;set;}
			public String setNumber {get;set;}
			public String shortDescription {get;set;}
			public String slotNumber {get;set;}
			public String type {get;set;}
		}		
		
		
		public class accountAddress
		{
				public String addressNo{get;set;}
				public String addressLine1{get;set;}
				public String addressLine2{get;set;}
				public String addressLine3 {get;set;}
				public String addressLine4{get;set;}
				public String zipCode{get;set;}
				public String countryId {get;set;}
				
				public String state {get;set;}
				
				public String lastInvoiceDate{get;set;}
				public String taxExemptionCertificate{get;set;}
				public String taxExempt{get;set;}
				public String creditStatus{get;set;}
				public String salesTerms{get;set;}
				public String termsCode{get;set;}
				public String certificateOfInsurance{get;set;}
				public String id{get;set;}
				public String ytdSales{get;set;}
				public String rentalTerms{get;set;}
				
				public String errorMessage{get;set;}
				
				public accountAddress(){}
				
				public accountAddress(String addressNo,
									  String addressLine1,
									  String addressLine2,
									  String addressLine3,
									  String addressLine4,
									  String zipCode,
									  String countryId,
									  String lastInvoiceDate,
									  String taxExemptionCertificate,
									  String taxExempt,
									  String creditStatus,
									  String salesTerms,
									  String termsCode,
									  String certificateOfInsurance,
									  String id,
									  String ytdSales,
									  String rentalTerms,
									  String state)									  
				{
					this.addressNo = addressNo;
					this.addressLine1 = addressLine1;
					this.addressLine2 = addressLine2;
					this.addressLine3 = addressLine3;
					this.addressLine4 = addressLine4;
					this.zipCode =  zipCode;
					this.countryId = countryId;
					this.lastInvoiceDate = lastInvoiceDate;
					this.taxExemptionCertificate = taxExemptionCertificate;
					this.taxExempt = taxExempt;
					this.creditStatus = creditStatus;
					this.salesTerms = salesTerms;
					this.termsCode = termsCode;
					this.certificateOfInsurance = certificateOfInsurance;
					this.id = id;
					this.ytdSales = ytdSales;
					this.rentalTerms = rentalTerms; 
					
					this.state = state; 
				}
		}
		
		// Full Quote Sales Rep Inner Class
		
		public class salesReps
		{
			public string id{get;set;}
			public string branchId{get;set;}
			public string name{get;set;}
			public boolean isSelected {get;set;}
			public String errorMessage{get;set;}
		}	
		
		public class salesRepsId
		{
			public string id{get;set;}
			public string name{get;set;}
			public String errorMessage{get;set;}
		}	
		
		
		// Full Quote Refresh Quote inner class	
		
		public class rentalQuote
		{
		  /*	
			public Decimal documentId {get;set;}
			public Decimal companyId {get;set;}
			public String transactionId {get;set;}
			public String salesRep1 {get;set;}
			public String salesRep1Name {get;set;}
			public String salesRep2 {get;set;}
			public String salesRep2Name {get;set;}
			public String narrative1 {get;set;}
			public String narrative2 {get;set;}
			public String instructionText {get;set;}
			public String status {get;set;}
			public String modifiedTimestamp {get;set;}
		  */	
			//public billingContactDetails billingContactDetails;
		  /*	
			public String reference {get;set;}
			public String poExpires {get;set;}
			public String creditApproval {get;set;}
			public String taxExemptAuthorisation {get;set;}
			public boolean taxExempt {get;set;}
			public String quoteTotal {get;set;}
		  */
			//public lines[] lines;
			
	        //public analysisSet analysisSet1;
	       // public analysisSet analysisSet2;
	       // public analysisSet analysisSet3;
	        //public analysisSet analysisSet4;
	        
	        //public analysisSet analysisSet5;
	        
	        //public additionalAnalysisSet additionalAnalysisSet1;
	       // public additionalAnalysisSet additionalAnalysisSet2;
	        //public additionalAnalysisSet additionalAnalysisSet3;
	        //public additionalAnalysisSet additionalAnalysisSet4;
	       // public additionalAnalysisSet additionalAnalysisSet5;
	        
	        public String termsCode {get;set;}
	        public Decimal invoicedBalance {get;set;}
	        public String lastInvoiceDate {get;set;}
	        public String writeUpRepCommission {get;set;}
	        public String nscRepCommission {get;set;}
	        public String portalContact {get;set;}
	        public String portalContactEmail {get;set;}
	        public boolean alreadyRegistered {get;set;}
	        public String homeOwner {get;set;}
	        public String creditStatus {get;set;}
	        public String poRequired {get;set;}
	        public boolean viewDocumentIn {get;set;}
	        public boolean emailPortalLink {get;set;}
	        public String messageDetails {get;set;}
	        public String reservationId {get;set;}
	        public String accountId {get;set;}
	        public String startDate {get;set;}
	        public String plannedCollectionDate {get;set;}
	        public Decimal billingAddressId {get;set;}
	        
	       // public billingAddress billingAddress;
	        
	        //public extras[] extras;
	     
			public String quoteExpires {get;set;}
	      /*  
	        public String certificateOfInsurance {get;set;}
	        public Decimal delivery {get;set;}
	        public Decimal rentalCharge {get;set;}
	        public Decimal pickUp {get;set;}
	        public Decimal accessories {get;set;}
	        public Decimal llw {get;set;}
	        public Decimal other {get;set;}
	        public Decimal codAmount {get;set;}
	        public Decimal tax {get;set;}
	        public Decimal totalCodAmount {get;set;}
	        public String hireTerms {get;set;}
	        public String customerText1 {get;set;}
	        public String type {get;set;}
	        public Decimal mobilization {get;set;} 
	        public String branchId {get;set;}
	        public Decimal ytdSales {get;set;}
	       */
	        public String shippingDate {get;set;}
	        public Decimal shippingAddressId {get;set;}
	        
	        //public shippingAddress shippingAddress;
	        //public shippingContactDetails shippingContactDetails;
	        
	        public String shippingInstructions {get;set;}
	        public Decimal rentalLength {get;set;}
	        
	       
	        public rentalQuote(String termsCode,Decimal invoicedBalance,String lastInvoiceDate,String writeUpRepCommission,String nscRepCommission,
	        				   String portalContact,String portalContactEmail,boolean alreadyRegistered,String homeOwner,String creditStatus,
	        				   String poRequired,boolean viewDocumentIn,boolean emailPortalLink,String messageDetails,String reservationId,
	        				   String accountId,String startDate,String plannedCollectionDate,Decimal billingAddressId,String quoteExpires,
	        				   String shippingDate,Decimal shippingAddressId,String shippingInstructions,Decimal rentalLength)	        				   
	        {
	        	this.termsCode = termsCode;
	        	this.invoicedBalance = invoicedBalance;
	        	this.lastInvoiceDate = lastInvoiceDate;
	        	this.writeUpRepCommission = writeUpRepCommission;
	        	this.nscRepCommission = nscRepCommission;
	        	this.portalContact = portalContact;
	        	this.portalContactEmail = portalContactEmail;
	        	this.alreadyRegistered = alreadyRegistered;
	        	this.homeOwner = homeOwner;
	        	this.creditStatus = creditStatus;
	        	this.poRequired = poRequired;
	        	this.viewDocumentIn = viewDocumentIn;
	        	this.emailPortalLink = emailPortalLink;
	        	this.messageDetails = messageDetails;
	        	this.reservationId = reservationId;
	        	this.accountId = accountId;
	        	this.startDate = startDate;
	        	this.plannedCollectionDate = plannedCollectionDate;
	        	this.billingAddressId = billingAddressId;
	        	this.quoteExpires = quoteExpires;
	        	this.shippingDate = shippingDate;
	        	this.shippingAddressId = shippingAddressId;
	        	this.shippingInstructions = shippingInstructions;
	        	this.rentalLength = rentalLength;
	        	
	        	//billingContactDetails = new billingContactDetails();
	        	//lines = new List<lines>();
	        	//analysisSet1 = new analysisSet();
	        	//analysisSet2 = new analysisSet();
	        	//analysisSet3 = new analysisSet();
	        	//analysisSet4 = new analysisSet();	
	        	//analysisSet5 = new analysisSet();
	        	
	        	//additionalAnalysisSet1 = new additionalAnalysisSet();	
	        	//additionalAnalysisSet2 = new additionalAnalysisSet();
	        	//additionalAnalysisSet3 = new additionalAnalysisSet();
	        	//additionalAnalysisSet4 = new additionalAnalysisSet();
	        	//additionalAnalysisSet5 = new additionalAnalysisSet(); 
	        	
	        	//billingAddress = new billingAddress();  
	        	
	        	//extras = new List<extras>();     	
	        }
	        
		}
		
		public class billingContactDetails
		{
			public String id {get;set;}
			public String name {get;set;}
			public String tel {get;set;}
			public String fax {get;set;}
			public String email {get;set;}
			public String mobile {get;set;}
			
			public billingContactDetails()
				{}
			
			public billingContactDetails(String id,
										 String name,
										 String tel,
										 String fax,
										 String email,
										 String mobile)
			{
				 this.id =id;
				 this.name = name;
				 this.tel = tel;
				 this.fax =fax;
				 this.email = email;
				 this.mobile = mobile;
			}
		}
		
		public class lines
		{
			public String itemId {get;set;}
			public String ecode {get;set;}
			public String reference {get;set;}
			public String description {get;set;}
			public Decimal lineValue {get;set;}
			public Decimal quantity {get;set;}
			public Decimal price {get;set;}
			public boolean invoiceDiscountApplicable {get;set;}
			public String lockItemCode {get;set;}
			public String lineId {get;set;}
			public String internetCoupon {get;set;}
			public String chargeCode {get;set;}
			
			public rates1 rate1;
	        public rates1 rate2;
	        public rates1 rate3;
	        public rates1 rate4;
	        public rates1 rate5;
	        public rates1 rate6;
	        public rates1 rate7;
	        public rates1 rate8;
	        
	        public Decimal commission1 {get;set;}
	        public Decimal commission2 {get;set;}
	        public Decimal commission3 {get;set;}
	        public Decimal commission4 {get;set;}
	        
	        public lines()
	        	{ }
	        	
	      /*  public lines(String itemId,String ecode,String reference,String description,Decimal lineValue,Decimal quantity,Decimal price,
	                     boolean invoiceDiscountApplicable,String lockItemCode,String lineId,String internetCoupon,String chargeCode,
	                     Decimal commission1,Decimal commission2,Decimal commission3,Decimal commission4)
	        {
	        	this.itemId = itemId;
	        	this.ecode = ecode;
	        	this.reference = reference;
	        	this.description = description;
	        	this.lineValue = lineValue;
	        	this.quantity = quantity;
	        	this.price = price;
	        	this.invoiceDiscountApplicable = invoiceDiscountApplicable;
	        	this.lockItemCode = lockItemCode;
	        	this.lineId = lineId;
	        	this.internetCoupon = internetCoupon;
	        	this.chargeCode = chargeCode;
	        	this.commission1 = commission1;
	        	this.commission2 = commission2;
	        	this.commission3 = commission3;
	        	this.commission4 = commission4;
	        	
	        	rate1 = new rates1();
	        	rate2 = new rates1();
	        	rate3 = new rates1();
	        	rate4 = new rates1();
	        	rate5 = new rates1();
	        	rate6 = new rates1();
	        	rate7 = new rates1();	
	        	rate8 = new rates1();        	
	        }
	        	 */       
	         
		}
		
		// for rates in lines innerclass in rentalQuote
		
		public class rates1
	    {
	        public String rate{get;set;}
	        public String description{get;set;}
	        public boolean editable{get;set;}
	        
	        public rates1()
	           { }	        
	       
	        public rates1(String rate,String description,boolean editable)
	        {
	        	this.rate = rate;
	        	this.description = description;
	        	this.editable = editable;
	        }
	        
	    }
		
		public class analysisSet
		{
			public header header;
			public selection selection;
			
			public analysisSet()
			{
				header = new header();
				selection = new selection();
			}
		}
		
		public class additionalAnalysisSet
		{
			public header header;
			public selection selection;
			
			public additionalAnalysisSet()
			{
				header = new header();
				selection = new selection();
			}
		}
		
		public class header
		{
			public String id {get;set;}
			public String description {get;set;}
			
			public header()
				{}
			
			public header(String Id, String description)
			{
				this.id = Id;
				this.description = description;
			}
		} 
		
		public class selection
		{ 
			public String id {get;set;}
			public String description {get;set;}
			public String Longdescription {get;set;}
			
			public selection()
				{}
			
			public selection(String Id, String description, string Longdescription)
			{
				this.id = Id;
				this.description = description;
				this.Longdescription = Longdescription; 
			}
		}
		
		public class billingAddress
		{
			public String name {get;set;}
			public String address1 {get;set;}
			public String address2 {get;set;}
			public String address3 {get;set;}
			public String address4 {get;set;}
			public String state {get;set;}
			public String countryId {get;set;}
			public String crossStreet1 {get;set;}
			public String crossStreet2 {get;set;}
			public String taxId {get;set;}
			public String deliveryZone {get;set;}
			public String cityZone {get;set;}
			public String zoneWarning {get;set;}
			public String latitude {get;set;}
			public String longitude {get;set;}
			public String oldPostalCode {get;set;}
			public String zipCode {get;set;}
			public String distanceFromBranch {get;set;}
			public String distanceBranch {get;set;}
			public String fulfillingBranchId {get;set;}
			public String fulfillingBranchName {get;set;}
			
			public billingAddress()
				{ }
			
			public billingAddress(String name,String address1,String address2,String address3,String address4,String state,
								  String countryId,String crossStreet1,String crossStreet2,String taxId,String deliveryZone,
								  String cityZone,String zoneWarning,String latitude,String longitude,String oldPostalCode,
								  String zipCode,String distanceFromBranch,String distanceBranch,String fulfillingBranchId,
								  String fulfillingBranchName)
			{
				this.name = name;
				this.address1 = address1;
				this.address2 = address2;
				this.address3 = address3;
				this.address4 = address4;
				this.state = state;
				this.countryId = countryId;
				this.crossStreet1 = crossStreet1;
				this.crossStreet2 = crossStreet2;
				this.taxId = taxId;
				this.deliveryZone = deliveryZone;
				this.cityZone = cityZone;
				this.zoneWarning = zoneWarning;
				this.latitude = latitude;
				this.longitude = longitude;
				this.oldPostalCode = oldPostalCode;
				this.zipCode = zipCode;
				this.distanceFromBranch = distanceFromBranch;
				this.distanceBranch = distanceBranch;
				this.fulfillingBranchId = fulfillingBranchId;
				this.fulfillingBranchName = fulfillingBranchName;				
			}
		}
		
		public class extras
		{
			public String id {get;set;}
			public String description {get;set;}
			public String quantity {get;set;}
			public String price {get;set;}
			public String total {get;set;}
			public String dollarOrPercent {get;set;}	
			
			public rates rate1;
	        public rates rate2;
	        public rates rate3;
	        public rates rate4;
	        public rates rate5;
	        public rates rate6;
	        public rates rate7;
	        public rates rate8;
	        
	        public boolean include {get;set;}
	        public boolean mandatory {get;set;}
	        public boolean priceEditable {get;set;}
	        public boolean quantityEditable {get;set;}
	        public boolean quantityRequired {get;set;}
	        
	        public String errorMessage {get;set;}
	        
	        public extras()
	           {}
	        
	        public extras(String id,
							 String description,
							 String quantity,
							 String price,
							 String total,
							 boolean include,
							 boolean mandatory,
							 boolean priceEditable,
							 boolean quantityEditable,
							 boolean quantityRequired
							 ) 
							 
			{
				this.id = id;
				this.description = description;
				this.quantity = quantity;
				this.price = price;
				this.total = total;
				this.include = include;
				this.mandatory = mandatory;
				this.priceEditable = priceEditable;
				this.quantityEditable = quantityEditable;
				this.quantityRequired = quantityRequired;
				
				rate1 = new rates();
				rate2 = new rates();
				rate3 = new rates();
				rate4 = new rates();
				rate5 = new rates();
				rate6 = new rates();
				rate7 = new rates();
				rate8 = new rates();
			
			}
	        
		}
		
		public class shippingAddress
		{
			public String name {get;set;}
			public String address1 {get;set;}
			public String address2 {get;set;}
			public String address3 {get;set;}
			public String address4 {get;set;}
			public String state {get;set;}
			public String countryId {get;set;}
			public String crossStreet1 {get;set;}
			public String crossStreet2 {get;set;}
			public String taxId {get;set;}
			public String deliveryZone {get;set;}
			public String cityZone {get;set;}
			public String zoneWarning {get;set;}
			public String latitude {get;set;}
			public String longitude {get;set;}
			public String oldPostalCode {get;set;}
			public String zipCode {get;set;}
			public Decimal distanceFromBranch {get;set;}
			public String distanceBranch {get;set;}
			public String fulfillingBranchId {get;set;}
			public String fulfillingBranchName {get;set;} 
			
			public shippingAddress()
				{ }
				
			public shippingAddress(String name,String address1,String address2,String address3,String address4,String state,
								   String countryId,String crossStreet1,String crossStreet2,String taxId,String deliveryZone,
								   String cityZone,String zoneWarning,String latitude,String longitude,String oldPostalCode,
								   String zipCode,Decimal distanceFromBranch,String distanceBranch,String fulfillingBranchId,
								   String fulfillingBranchName)
			{
				this.name = name;
				this.address1 = address1;
				this.address2 = address2;
				this.address3 = address3;
				this.address4 = address4;
				this.state = state;
				this.countryId = countryId;
				this.crossStreet1 = crossStreet1;
				this.crossStreet2 = crossStreet2;
				this.taxId = taxId;
				this.deliveryZone = deliveryZone;
				this.cityZone = cityZone;
				this.zoneWarning = zoneWarning;
				this.latitude = latitude;
				this.longitude = longitude;
				this.oldPostalCode = oldPostalCode;
				this.zipCode = zipCode;
				this.distanceFromBranch = distanceFromBranch;
				this.distanceBranch = distanceBranch;
				this.fulfillingBranchId = fulfillingBranchId;
				this.fulfillingBranchName = fulfillingBranchName;
			}
			
		}
		
		public class shippingContactDetails
		{
			public String id {get;set;}
			public String name {get;set;}
			public String tel {get;set;}
			public String fax {get;set;}
			public String email {get;set;}
			public String mobile {get;set;}	
			
			public shippingContactDetails()
				{ }
			
			public shippingContactDetails(String id,String name,String tel,String fax,String email,String mobile)
			{
				this.id = id;
				this.name = name;
				this.tel = tel;
				this.fax = fax;
				this.email = email;
				this.mobile = mobile;				
			}
		}
		
		// Refresh line
		public class quoteLine
		{
			public String itemId {get;set;}
			public String ecode {get;set;}
			public String reference {get;set;}
			public String description {get;set;}
			public String lineValue {get;set;}
			public Decimal quantity {get;set;}			
			public Decimal price {get;set;}
			public Decimal totalperPeriodvalue{get;set;}
			public Decimal estimatedCost {get;set;}
			public Decimal payment {get;set;}
			public Decimal modificationCharge {get;set;}				
			public String internetCoupon {get;set;}
			public String lockItemCode {get;set;}
			
			public Decimal commission1 {get;set;}
			public Decimal commission2 {get;set;}
			public Decimal commission3 {get;set;}
			public Decimal commission4 {get;set;}
			public boolean invoiceDiscountApplicable {get;set;} 
			
			public rates rate1 {get;set;}
			public rates rate2 {get;set;}
			public rates rate3 {get;set;}
			public rates rate4 {get;set;}
			public rates rate5 {get;set;}
			public rates rate6 {get;set;}
			public rates rate7 {get;set;}
			public rates rate8 {get;set;}
			
			public chargeCodes chargeCode;
			
			public String errorMessage{get;set;}
			public Integer lineCount {get;set;}
			public boolean isSelected {get;set;} 
						
			public String LockType {get;set;}
			public String SelectedAccountId {get;set;}
			public String SelectedPeriod {get;set;}
			public String SelectedFromDate {get;set;}
			public String SelectedRate1 {get;set;}
			public String SelectedRate2 {get;set;}
			public String SelectedRate3 {get;set;}
			public String SelectedRate4 {get;set;}
			public Decimal LockTypeTotal {get;set;}
			
			public String lineId {get;set;}
			public String removeLine {get;set;}
			
			public Decimal gpPercent {get;set;}
			public Decimal netBookValue {get;set;}
			public String paymentType {get;set;}
			public payment payment1 {get;set;}
			public payment payment2 {get;set;}
			public payment payment3 {get;set;}
			public boolean isAccessories {get;set;}
			public String itemType {get;set;}
			
			public quoteLine()
				{}
				
			public quoteLine(String itemId,
							 String ecode,
							 String reference,
							 String description,
							 String lineValue,
							 Decimal quantity,
							 Decimal price,
							 String internetCoupon,
							 String lockItemCode,
							 Decimal commission1,
							 Decimal commission2,
							 Decimal commission3,
							 Decimal commission4,
							 boolean invoiceDiscountApplicable)
							 
			{
				this.itemId = itemId;
				this.ecode = ecode;
				this.reference = reference;
				this.description = description;
				this.lineValue = lineValue;
				this.quantity = quantity;
				this.price = price;
				this.internetCoupon = internetCoupon;
				this.lockItemCode = lockItemCode;
				this.commission1 = commission1;
				this.commission2 = commission2;
				this.commission3 = commission3;
				this.commission4 = commission4;
				this.invoiceDiscountApplicable = invoiceDiscountApplicable;
				
				rate1 = new rates();
				rate2 = new rates();
				rate3 = new rates();
				rate4 = new rates();
				rate5 = new rates();
				rate6 = new rates();
				rate7 = new rates();
				rate8 = new rates();
				
				payment1 = new payment();
				payment2 = new payment();
				payment3 = new payment();
				
				chargeCode = new chargeCodes();
			}
						
		}
		public class chargeCodes
		{
			public String id {get;set;}
			public String description {get;set;}
			public boolean active {get;set;}
			public String chargeCode {get;set;}
			public String errorMessage{get;set;} 
			public boolean isSelected {get;set;}
			
			public chargeCodes()
				{}
				
			public chargeCodes(String id,String description,boolean active, String chargeCode)
			{
				this.id = id;
				this.description = description;
				this.active = active; 
				this.chargeCode = chargeCode;
			}
		}
		
		
		public class SalesFleets{
    	
        public String productId {get;set;}
        public String productDescription {get;set;}
        public String ecode {get;set;}
        public String reference {get;set;}
        public String ImageUrl {get;set;}
        public String grade {get;set;}
        public String suggestedPrice {get;set;}
        public String minimumPrice {get;set;}
        public String netBookValue {get;set;}
        public String commissionBonusReason {get;set;}
        public String notes {get;set;}
        public String errorMessage{get;set;}
    
		}
		
		public class allocations{
			public String ecode {get;set;}
			public String reference {get;set;}
			public list<String> holdText {get;set;}
			public String status {get;set;}
			public String availableDate {get;set;}
			public String sale {get;set;}
			public String reserved {get;set;}
			public String allocated {get;set;}
			public String sell {get;set;}
			public String agedMonths {get;set;}
			public String cost {get;set;}
			public String price {get;set;}
			public String discount {get;set;}
			public String netBookValue {get;set;}
			public String pickUp {get;set;}
			public String reRented {get;set;}
			
			 public String errorMessage{get;set;}
			
		}
	
	/*******************************************************************
                    Product Extras Classes
    ********************************************************************/
    
   
    
	public class Extras2
    {
    	public Extras2(){}
	      public String id{get;set;}
	      public String description{get;set;}
	      public Integer quantity{get;set;}
	      public String price{get;set;}
	      public String total{get;set;}
	      
	      public boolean include{get;set;}
	      public boolean mandatory{get;set;}
	      public boolean priceEditable{get;set;}
	      public boolean quantityEditable{get;set;}
	      public boolean quantityRequired{get;set;}
	      
	      public String errorMessage{get;set;}
	      public rates rate1 {get;set;}
			public rates rate2 {get;set;}
			public rates rate3 {get;set;}
			public rates rate4 {get;set;}
			public rates rate5 {get;set;}
			public rates rate6 {get;set;}
			public rates rate7 {get;set;}
			public rates rate8 {get;set;}
			
			public Extras2(String id,
							 String description,
							 Integer quantity,
							 String price,
							 String total,
							 boolean include,
							 boolean mandatory,
							 boolean priceEditable,
							 boolean quantityEditable,
							 boolean quantityRequired
							 )
							 
			{
				this.id = id;
				this.description = description;
				this.quantity = quantity;
				this.price = price;
				this.total = total;
				this.include = include;
				this.mandatory = mandatory;
				this.priceEditable = priceEditable;
				this.quantityEditable = quantityEditable;
				this.quantityRequired = quantityRequired;
				
				rate1 = new rates();
				rate2 = new rates();
				rate3 = new rates();
				rate4 = new rates();
				rate5 = new rates();
				rate6 = new rates();
				rate7 = new rates();
				rate8 = new rates();
				
			
			
			} 
    }    
    
    public class CapacityLookupHandler
    {
    	public String dateVal{get;set;}
		public String mileage{get;set;}
		public String storeNumber{get;set;}
		public String storeType{get;set;}
		public String depotGroup{get;set;}
		public String amCapacity{get;set;}
		public String pmCapacity{get;set;}
		public String noPrefCapacity{get;set;}
		public String ErrorString {get;set;}
	
    }
   
   public class capacityLookupRequest
   {
   		public String itemName{get;set;}
   		public String addressLine1{get;set;}
   		public String city{get;set;}
   		public String countryCode{get;set;}
   		public String postalCode{get;set;}
   		public String stateCode{get;set;}
   		public String crossStreet1{get;set;}
   		public String crossStreet2{get;set;} 
   		public String itemDescription{get;set;}
   		public String volume{get;set;}
   		public String sellingStoreNumber{get;set;}
   		public String longitude {get;set;}
        public String latitude {get;set;}
        public String BranchId {get;set;}
        public String DeliveryDateTime {get;set;}
   }
   
    public class orderAndDeliveries{
   		public String accountId{get;set;}
   		public String accountName{get;set;}
   		public String activationDate{get;set;}
   		public String branchId{get;set;}
   		public String companyNumber{get;set;}
   		public String documentId{get;set;}
   		public MainLine mainLine{get;set;}
   		public String mobilization{get;set;} 
   		public String salesRep1{get;set;}
   		public String salesRep2{get;set;}
   		public String shippingContactName{get;set;}
   		public String shippingContactNumber {get;set;}
        public String shippingDate {get;set;}
        public String totalCODAmount {get;set;}
        public String transactionId {get;set;}
        public String type {get;set;}
        
        public String PPE {get;set;}
        public String LLW {get;set;}
        public String deliveryFuelSurcharge {get;set;}
        public String pickUpFuelSurcharge {get;set;}
        
        public String errorMessage {get;set;}
   }
   
   public class MainLine{
   		public String id {get;set;}
   		public String itemId {get;set;}
   		public String qty {get;set;}
   		public String total {get;set;}
   		public String unitPrice {get;set;}
   	
   }
   
   public class OrderAndDeliveriesParam{
   		public String quoteType {get;set;}
   		public String UserRepId {get;set;}
   		public String AccountId {get;set;}
   		public String Status {get;set;}
   		public String StartDate {get;set;}
   		public String endDate {get;set;}
   		public String Offset {get;set;}
   	
   }
   
   public class orderDetails{ 
   		public list<ExtraInOrderDetails> extras {get;set;}
   		public String errorMessage {get;set;}
   		
   		public orderDetails(){
   			extras = new list<ExtraInOrderDetails>();
   		}
   }
   
   public class ExtraInOrderDetails{
   		public String deliveryCharges {get;set;}
   		public String deliverySurcharge {get;set;}
   		public String pickupCharges {get;set;}
   		public String pickupSurcharge {get;set;}
   		public String llwCharges {get;set;}
   		public String ppeCharges {get;set;} 
   		public String errorMessage {get;set;}
   }
   
   public class ProspectAccountParam{
   		public String companyName {get;set;}
   		public String salesforceID {get;set;}
   		public String contactName {get;set;}
   		public String address1 {get;set;}
   		public String city {get;set;}
   		public String state {get;set;} 
   		public String zip {get;set;}
   		public String Country {get;set;}
   		public String phone1 {get;set;}
   		public String repCode {get;set;}
   		public String branchCode {get;set;}
   }
   
   public class knowZoneRatesEmailParam
	{
		public String quoteType {get;set;}
		public String sourceOfQuote {get;set;}
		public String fulfillingBranchId {get;set;}
		public String loggedInUserEmail {get;set;}
		public String sfdcAccOwnerEmail {get;set;}
		public String accountNo {get;set;}
		public String oppId {get;set;} // TFS 3945
		public String accountName {get;set;}
		public String itemCode {get;set;}
		public FullQuoteWrapper fullQWrapper {get;set;}
		public QuickQuoteWrapper qqWrapper {get;set;}
	}
   
   public class ListContact
	{
		public String contactId{get;set;}
		public String forename{get;set;}
		public String surname{get;set;}
		public String errorMessage{get;set;}
	}
	
	public class SpecificContact
	{
		public String contactId{get;set;}
		public String salutation{get;set;}
		public String forename{get;set;}
		public String surname{get;set;}
		public String phoneNumber{get;set;}
		public String email{get;set;}
		public String position{get;set;}
		public String cellMobile{get;set;}
		public String contactStatus{get;set;}
		public String contactStatusDescription{get;set;}
		public String contactTypeId{get;set;}
		public String contactTypeDescription{get;set;}
		public String mainContact{get;set;}
		public String phoneExtension{get;set;}
		public String faxNumber{get;set;}
		public String companyNumber{get;set;}
		public String companyName{get;set;}
		public String salesPersonId{get;set;}
		public String salesPersonName{get;set;}
		public String branchId{get;set;}
		public String branchName{get;set;}
		public String errorMessage{get;set;}
	}
	
	public class AddContact
	{
		public String newContactId{get;set;}
		public String errorMessage{get;set;}
	}
	
	public class UpdateContact
	{
		public String contactId{get;set;}
		public String salutation{get;set;}
		public String forename{get;set;}
		public String surname{get;set;}
		public String cellMobile{get;set;}
		public String email{get;set;}
		public String phoneNumber{get;set;}
		public String phoneExtension{get;set;}
		public String faxNumber{get;set;}
		public String contactTypeId{get;set;}
		public String contactStatus{get;set;}
		public String mainContact{get;set;}
		public String position{get;set;}
		public String salesPersonId{get;set;}
		public String companyNumber{get;set;}
		public String branchId{get;set;}
		public String errorMessage{get;set;}
	}
	
	
	public class ListCard
	{
		public String accountId{get;set;}
		public String contactId{get;set;}
		public String firstName{get;set;}
		public String lastName{get;set;}
		public String address1{get;set;}
		public String address2{get;set;}
		public String city{get;set;}
		public String county{get;set;}
		public String state{get;set;}
		public String zipcode{get;set;}
		public String country{get;set;}
		public String email{get;set;}
		public String defaultAddressCode{get;set;}
		public String defaultAddressCodeDescription{get;set;}
		public String cardType{get;set;}
		public String cardTypeDescription{get;set;}
		public String cardExpiryDate{get;set;}
		public String cardName{get;set;}
		public String cardNumberLast4{get;set;}
		public String paymentType{get;set;}
		public String paymentTypeDescription{get;set;}
		public String transactionSource{get;set;}
		public String transactionType{get;set;}
		public String bankName{get;set;}
		public String bankCity{get;set;}
		public String bankState{get;set;}
		public String bankAccountType{get;set;}
		public String bankAccountTypeDescription{get;set;}
		public String chequeType{get;set;}
		public String chequeTypeDescription{get;set;}
		public String telephone{get;set;}
		public String cardKey1{get;set;}
		public String cardKey2{get;set;}
		public String cardKey3{get;set;}
		
		public String cardNumber{get;set;}
		public String expiryMonth{get;set;}
		public String expiryYear{get;set;}
		public String additionalSecurityData{get;set;}
		public String userPassword{get;set;}
		
		
		public String bankSortCode{get;set;}
		public String bankAccountNumber{get;set;}
		
		
		public String errorMessage{get;set;}
		
		public Boolean defaultCard{get;set;}
	}
	
	public class AddCardResponse
	{
		public String statusCode{get;set;}
		public String statusMessage{get;set;}
		public String decision{get;set;}
		public String authorizationReference{get;set;}
		public String successful{get;set;}
		public String cardKey1{get;set;}
		public String cardKey2{get;set;}
		public String cardKey3{get;set;}
		public String errorMessage{get;set;}
	}
	
	public class AutocheckResponse
	{
		public String successful{get;set;}
		public String statusMessage{get;set;}
		public String errorMessage{get;set;}
	}
   
}