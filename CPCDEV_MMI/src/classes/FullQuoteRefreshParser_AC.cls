public with sharing class FullQuoteRefreshParser_AC {

	public String errorMessage{get;set;}
	public class BillingContactDetails {
		public String id;
		public String name;
		public String tel;
		public String fax;
		public String email;
		public String mobile;
	}

	public class Rate1 {
		public String rate;
		public String description;
		public Boolean editable;
	}

	public class RentalQuote {
		public String documentId;
		public String companyId;
		public String transactionId;
		public String salesRep1;
		public String salesRep1Name;
		public String salesRep2;
		public String salesRep2Name;
		public String narrative1;
		public String narrative2;
		public String instructionText;
		public String status;
		public String modifiedTimestamp;
		public BillingContactDetails billingContactDetails;
		public String reference;
		public String poExpires;
		public String creditApproval;
		public String taxExemptAuthorisation;
		public Boolean taxExempt;
		public String quoteTotal;
		public List<Lines> lines;
		public AnalysisSet1 analysisSet1;
		public AnalysisSet1 analysisSet2;
		public AnalysisSet1 analysisSet3;
		public AnalysisSet1 analysisSet4;
		public String analysisSet5;
		public AnalysisSet1 additionalAnalysisSet1;
		public AnalysisSet1 additionalAnalysisSet2;
		public AnalysisSet1 additionalAnalysisSet3;
		public AnalysisSet1 additionalAnalysisSet4;
		public String additionalAnalysisSet5;
		public String termsCode;
		public String invoicedBalance;
		public String lastInvoiceDate;
		public String writeUpRepCommission;
		public String nscRepCommission;
		public String portalContact;
		public String portalContactEmail;
		public Boolean alreadyRegistered;
		public String homeOwner;
		public String creditStatus;
		public String poRequired;
		public Boolean viewDocumentIn;
		public Boolean emailPortalLink;
		public String messageDetails;
		public String reservationId;
		public String accountId;
		public String startDate;
		public String plannedCollectionDate;
		public String billingAddressId;
		public BillingAddress billingAddress;
		public List<Extras> extras;
		public String quoteExpires;
		public String certificateOfInsurance;
		public String delivery;
		public String rentalCharge;
		public String pickUp;
		public String accessories;
		public String llw;
		public String other;
		public String codAmount;
		public String tax;
		public String totalCodAmount;
		public String hireTerms;
		public String customerText1;
		public String type;
		public String mobilization;
		public String branchId;
		public String ytdSales;
		public String shippingDate;
		public String shippingAddressId;
		public ShippingAddress shippingAddress;
		public ShippingContactDetails shippingContactDetails;
		public String shippingInstructions;
		public String rentalLength;
	}
	
	public class salesQuote{
		public String documentId;
		public String companyId;
		public String transactionId;
		public String salesRep1;
		public String salesRep1Name;
		public String salesRep2;
		public String salesRep2Name;
		public String narrative1;
		public String narrative2;
		public String instructionText;
		public String status;
		public String modifiedTimestamp;
		public BillingContactDetails billingContactDetails;
		public String reference;
		public String poExpires;
		public String creditApproval;
		public String taxExemptAuthorisation;
		public Boolean taxExempt;
		public String quoteTotal;
		public List<Lines> lines;
		public AnalysisSet1 analysisSet1;
		public AnalysisSet1 analysisSet2;
		public AnalysisSet1 analysisSet3;
		public AnalysisSet1 analysisSet4;
		public AnalysisSet1 analysisSet5;
		public AnalysisSet1 additionalAnalysisSet1;
		public AnalysisSet1 additionalAnalysisSet2;
		public AnalysisSet1 additionalAnalysisSet3;
		public AnalysisSet1 additionalAnalysisSet4;
		public AnalysisSet1 additionalAnalysisSet5;
		public String termsCode;
		public String invoicedBalance;
		public String lastInvoiceDate;
		public String writeUpRepCommission;
		public String nscRepCommission;
		public String portalContact;
		public String portalContactEmail;
		public Boolean alreadyRegistered;
		public String homeOwner;
		public String creditStatus;
		public String poRequired;
		public Boolean viewDocumentIn;
		public Boolean emailPortalLink;
		public String messageDetails;
		public String reservationId;
		public String accountId;
		public String startDate;
		public String plannedCollectionDate;
		public String billingAddressId;
		public BillingAddress billingAddress;
		public List<Extras> extras;
		public String quoteExpires;
		public String certificateOfInsurance;
		public String delivery;
		public String rentalCharge;
		public String pickUp;
		public String accessories;
		public String llw;
		public String other;
		public String codAmount;
		public String tax;
		public String totalCodAmount;
		public String hireTerms;
		public String customerText1;
		public String type;
		public String mobilization;
		public String branchId;
		public String ytdSales;
		public String shippingDate;
		public String shippingAddressId;
		public ShippingAddress shippingAddress;
		public ShippingContactDetails shippingContactDetails;
		public String shippingInstructions;
		public String rentalLength;
		
		
		public String orderGoods;
		public String extrasTotal;
		public String orderTotal;
		
		
	}

	public class Lines {
		public String itemId;
		public String ecode;
		public String reference;
		public String description;
		public String lineValue;
		public String quantity;
		public String price;
		public Boolean invoiceDiscountApplicable;
		public String lockItemCode;
		public String lineId;
		public String internetCoupon;
		public ChargeCode chargeCode;
		public Rate1 rate1;
		public Rate1 rate2;
		public Rate1 rate3;
		public Rate1 rate4;
		public Rate1 rate5;
		public Rate1 rate6;
		public Rate1 rate7;
		public Rate1 rate8;
		public String commission1;
		public String commission2;
		public String commission3;
		public String commission4;
		public String netBookValue;
	}

	public class Extras {
		public String id;
		public String description;
		public String quantity;
		public String price;
		public String total;
		public Rate1_Z rate1;
		public Rate1_Z rate2;
		public Rate1_Z rate3;
		public Rate1_Z rate4;
		public Rate1_Z rate5;
		public Rate1_Z rate6;
		public Rate1_Z rate7;
		public Rate1_Z rate8;
		public Boolean include;
		public Boolean mandatory;
		public Boolean priceEditable;
		public Boolean quantityEditable;
		public Boolean quantityRequired;
	}

	public class BillingAddress {
		public String name;
		public String address1;
		public String address2;
		public String address3;
		public String address4;
		public String state;
		public String countryId;
		public String crossStreet1;
		public String crossStreet2;
		public String taxId;
		public String deliveryZone;
		public String cityZone;
		public String zoneWarning;
		public String latitude;
		public String longitude;
		public String oldPostalCode;
		public String zipCode;
		public String distanceFromBranch;
		public String distanceBranch;
		public String fulfillingBranchId;
		public String fulfillingBranchName;
	}

	public class ShippingContactDetails {
		public String id;
		public String name;
		public String tel;
		public String fax;
		public String email;
		public String mobile;
	}

	public class Header {
		public String id;
		public String description;
	}

	public class ShippingAddress {
		public String name;
		public String address1;
		public String address2;
		public String address3;
		public String address4;
		public String state;
		public String countryId;
		public String crossStreet1;
		public String crossStreet2;
		public String taxId;
		public String deliveryZone;
		public String cityZone;
		public String zoneWarning;
		public String latitude;
		public String longitude;
		public String oldPostalCode;
		public String zipCode;
		public String distanceFromBranch;
		public String distanceBranch;
		public String fulfillingBranchId;
		public String fulfillingBranchName;
	}

	public class AnalysisSet1 {
		public Header header;
		public Selection selection;
	}

	public RentalQuote rentalQuote;
	public salesQuote salesQuote;

	public class Rate1_Z {
		public String rate;
		public String description;
		public Boolean editable;
	}

	public class Selection {
		public String id;
		public String description;
	}
	
	public class ChargeCode {
		public String description;
		public Boolean active;
		public String id;
	}
	
	
	public  FullQuoteRefreshParser_AC parseRefreshResponse(String json) {		
		
		return (FullQuoteRefreshParser_AC) System.JSON.deserialize(json, FullQuoteRefreshParser_AC.class);
	}
	
	static testMethod void testParse() {
		
		FullQuoteRefreshParser_AC obj = new FullQuoteRefreshParser_AC();
		FullQuoteRefreshParser_AC.BillingContactDetails  objBiling = new FullQuoteRefreshParser_AC.BillingContactDetails();
		FullQuoteRefreshParser_AC.Rate1 rate = new FullQuoteRefreshParser_AC.Rate1();   
		FullQuoteRefreshParser_AC.RentalQuote rentQ = new FullQuoteRefreshParser_AC.RentalQuote();  
		FullQuoteRefreshParser_AC.salesQuote saleQ = new FullQuoteRefreshParser_AC.salesQuote();  
		FullQuoteRefreshParser_AC.Lines line = new FullQuoteRefreshParser_AC.Lines(); 
		FullQuoteRefreshParser_AC.Extras extr = new FullQuoteRefreshParser_AC.Extras(); 
		FullQuoteRefreshParser_AC.BillingAddress bill = new FullQuoteRefreshParser_AC.BillingAddress();   
		FullQuoteRefreshParser_AC.ShippingContactDetails shipin = new FullQuoteRefreshParser_AC.ShippingContactDetails();   
		FullQuoteRefreshParser_AC.Header  head = new FullQuoteRefreshParser_AC.Header(); 
		FullQuoteRefreshParser_AC.ShippingAddress shipadd = new FullQuoteRefreshParser_AC.ShippingAddress();   
		FullQuoteRefreshParser_AC.AnalysisSet1 anay = new FullQuoteRefreshParser_AC.AnalysisSet1(); 
		FullQuoteRefreshParser_AC.Rate1_Z rate1z =  new FullQuoteRefreshParser_AC.Rate1_Z(); 
		FullQuoteRefreshParser_AC.Selection  selecti = new FullQuoteRefreshParser_AC.Selection(); 
		FullQuoteRefreshParser_AC.ChargeCode chardcode = new FullQuoteRefreshParser_AC.ChargeCode(); 
		
		   
	}
}