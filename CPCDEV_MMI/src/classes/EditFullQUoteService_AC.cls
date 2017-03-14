public with sharing class EditFullQUoteService_AC 
{
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
		public Long modifiedTimestamp;
		public BillingContactDetails billingContactDetails;
		public String reference;
		public String startDate;
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
		public String hireNotes; //---------------TFS 2870
		public String salesTerms;
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
		//-------------------TFS 4692------------	
		public String shippingReference;
		public String cardKey1;
		public String cardKey2;
		public String cardKey3;
		
		public String rentalLength;
		public String orderTotal;
		public String extrasTotal;
		public String orderGoods;
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
		public String removeLine;
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
		
		
		public String gpPercent;
		public String netBookValue;
		public String paymentType;
		public String payment1;
		public String payment2;
		public String payment3;
		public String estimatedCost;
		
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

	public class ChargeCode {
		public String description;
		public Boolean active;
		public String id;
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

	public RentalQuote rentalQuote;
	public RentalQuote salesQuote;

	public class AnalysisSet1 {
		public Header header;
		public Selection selection;
	}

	public class Rate1_Z {
		public String rate;
		public String description;
		public Boolean editable;
	}

	public class Selection { 
		public String id;
		public String description;
		public String longDescription;
	}

	
	public EditFullQUoteService_AC parse(String json) {
		//System.debug('********************'+(EditFullQUoteService_AC) System.JSON.deserialize(json, EditFullQUoteService_AC.class));
		//return (EditFullQUoteService_AC) System.JSON.deserialize(json, EditFullQUoteService_AC.class);
		return (EditFullQUoteService_AC) System.JSON.deserialize(json, EditFullQUoteService_AC.class);
	}
	
	static testMethod void testParse() {
		String json = '{'+
		'    \"rentalQuote\": {'+
		'        \"documentId\": 126025351,'+
		'        \"companyId\": 1,'+
		'        \"transactionId\": \"ON\",'+
		'        \"salesRep1\": \"1234\",'+
		'        \"salesRep1Name\": \"Lavanya Shivara\",'+
		'        \"salesRep2\": \"1234\",'+
		'        \"salesRep2Name\": \"Lavanya Shivara\",'+
		'        \"narrative1\": \"\",'+
		'        \"narrative2\": \"\",'+
		'        \"instructionText\": \"\",'+
		'        \"status\": \"Q\",'+
		'        \"modifiedTimestamp\": 1366615671000,'+
		'        \"billingContactDetails\": {'+
		'            \"id\": \"\",'+
		'            \"name\": \"ALLEN CONSTRUCTION CO///CCA\",'+
		'            \"tel\": \"972-293-7846\",'+
		'            \"fax\": \"\",'+
		'            \"email\": \"\",'+
		'            \"mobile\": null'+
		'        },'+
		'        \"reference\": \"REQUIRED\",'+
		'        \"poExpires\": null,'+
		'        \"creditApproval\": \"\",'+
		'        \"taxExemptAuthorisation\": \"\",'+
		'        \"taxExempt\": false,'+
		'        \"quoteTotal\": \"FI\",'+
		'        \"lines\": ['+
		'            {'+
		'                \"itemId\": \"10S2\",'+
		'                \"ecode\": \"\",'+
		'                \"reference\": \"\",'+
		'                \"description\": \"10\' CONTAINER\",'+
		'                \"lineValue\": \"0.00\",'+
		'                \"quantity\": 1,'+
		'                \"price\": \"0.00\",'+
		'                \"invoiceDiscountApplicable\": false,'+
		'                \"lockItemCode\": null,'+
		'                \"lineId\": 1,'+
		'                \"internetCoupon\": \"\",'+
		'                \"chargeCode\": {'+
		'                    \"description\": null,'+
		'                    \"active\": false,'+
		'                    \"id\": \"MONTHLY\"'+
		'                },'+
		'                \"rate1\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": \"1 Period\",'+
		'                    \"editable\": true'+
		'                },'+
		'                \"rate2\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": \"2-6 Periods\",'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate3\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": \"7-12 Periods\",'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate4\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": \"13+ Periods\",'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate5\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": \"Contractor\",'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate6\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": \"National\",'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate7\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": \"Xmas Rate\",'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate8\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": \"Min Xmas\",'+
		'                    \"editable\": false'+
		'                },'+
		'                \"commission1\": \"0.00\",'+
		'                \"commission2\": \"0.00\",'+
		'                \"commission3\": \"0.00\",'+
		'                \"commission4\": \"0.00\"'+
		'            }'+
		'        ],'+
		'        \"analysisSet1\": {'+
		'            \"header\": {'+
		'                \"id\": 102,'+
		'                \"description\": \"Ad Source\"'+
		'            },'+
		'            \"selection\": {'+
		'                \"id\": \"DM\",'+
		'                \"description\": \"Direct Mail\"'+
		'            }'+
		'        },'+
		'        \"analysisSet2\": {'+
		'            \"header\": {'+
		'                \"id\": 103,'+
		'                \"description\": \"Customer Type\"'+
		'            },'+
		'            \"selection\": {'+
		'                \"id\": \"2\",'+
		'                \"description\": \"Retail Trade\"'+
		'            }'+
		'        },'+
		'        \"analysisSet3\": {'+
		'            \"header\": {'+
		'                \"id\": 110,'+
		'                \"description\": \"Deferred\"'+
		'            },'+
		'            \"selection\": {'+
		'                \"id\": \"YES\",'+
		'                \"description\": \"Yes\"'+
		'            }'+
		'        },'+
		'        \"analysisSet4\": null,'+
		'        \"analysisSet5\": null,'+
		'        \"additionalAnalysisSet1\": {'+
		'            \"header\": {'+
		'                \"id\": 111,'+
		'                \"description\": \"Del Time\"'+
		'            },'+
		'            \"selection\": {'+
		'                \"id\": \"1PM\",'+
		'                \"description\": \"Priority PM\"'+
		'            }'+
		'        },'+
		'        \"additionalAnalysisSet2\": {'+
		'            \"header\": {'+
		'                \"id\": 112,'+
		'                \"description\": \"Call First\"'+
		'            },'+
		'            \"selection\": {'+
		'                \"id\": \"YES\",'+
		'                \"description\": \"Call First\"'+
		'            }'+
		'        },'+
		'        \"additionalAnalysisSet3\": {'+
		'            \"header\": {'+
		'                \"id\": 113,'+
		'                \"description\": \"Door Dir\"'+
		'            },'+
		'            \"selection\": {'+
		'                \"id\": \"DPCMM\",'+
		'                \"description\": \"MMI Cab\"'+
		'            }'+
		'        },'+
		'        \"additionalAnalysisSet4\": {'+
		'            \"header\": {'+
		'                \"id\": 114,'+
		'                \"description\": \"Movement Type\"'+
		'            },'+
		'            \"selection\": {'+
		'                \"id\": \"DR\",'+
		'                \"description\": \"Dry Run\"'+
		'            }'+
		'        },'+
		'        \"additionalAnalysisSet5\": {'+
		'            \"header\": {'+
		'                \"id\": 115,'+
		'                \"description\": \"Appearance\"'+
		'            },'+
		'            \"selection\": {'+
		'                \"id\": \"VIMP\",'+
		'                \"description\": \"Very Important\"'+
		'            }'+
		'        },'+
		'        \"termsCode\": \"New Customer\",'+
		'        \"invoicedBalance\": \"0.00\",'+
		'        \"lastInvoiceDate\": null,'+
		'        \"writeUpRepCommission\": null,'+
		'        \"nscRepCommission\": null,'+
		'        \"portalContact\": \"\",'+
		'        \"portalContactEmail\": \"\",'+
		'        \"alreadyRegistered\": false,'+
		'        \"homeOwner\": \"\",'+
		'        \"creditStatus\": \"HFCZ\",'+
		'        \"poRequired\": \"Optional\",'+
		'        \"viewDocumentIn\": false,'+
		'        \"emailPortalLink\": false,'+
		'        \"messageDetails\": null,'+
		'        \"reservationId\": null,'+
		'        \"accountId\": \"10492\",'+
		'        \"startDate\": \"2013-05-02\",'+
		'        \"plannedCollectionDate\": \"2013-05-29\",'+
		'        \"billingAddressId\": 0,'+
		'        \"billingAddress\": {'+
		'            \"name\": \"ALLEN CONSTRUCTION CO///CCA\",'+
		'            \"address1\": \"326 COOPER STREET BLDG A 1\",'+
		'            \"address2\": \"\",'+
		'            \"address3\": \"CEDAR HILL\",'+
		'            \"address4\": \"\",'+
		'            \"state\": \"TX\",'+
		'            \"countryId\": \"USA\",'+
		'            \"crossStreet1\": null,'+
		'            \"crossStreet2\": null,'+
		'            \"taxId\": null,'+
		'            \"deliveryZone\": null,'+
		'            \"cityZone\": 0,'+
		'            \"zoneWarning\": null,'+
		'            \"latitude\": null,'+
		'            \"longitude\": null,'+
		'            \"oldPostalCode\": null,'+
		'            \"zipCode\": \"75104-2628\",'+
		'            \"distanceFromBranch\": null,'+
		'            \"distanceBranch\": null,'+
		'            \"fulfillingBranchId\": null,'+
		'            \"fulfillingBranchName\": null'+
		'        },'+
		'        \"extras\": ['+
		'            {'+
		'                \"id\": \"DELIVERY\",'+
		'                \"description\": \"Delivery\",'+
		'                \"quantity\": 1,'+
		'                \"price\": \"90.00\",'+
		'                \"total\": \"90.00\",'+
		'                \"rate1\": {'+
		'                    \"rate\": \"90.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate2\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate3\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate4\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate5\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate6\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate7\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate8\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"include\": true,'+
		'                \"mandatory\": true,'+
		'                \"priceEditable\": true,'+
		'                \"quantityEditable\": false,'+
		'                \"quantityRequired\": false'+
		'            },'+
		'            {'+
		'                \"id\": \"PICKUP\",'+
		'                \"description\": \"Pick up\",'+
		'                \"quantity\": 1,'+
		'                \"price\": \"90.00\",'+
		'                \"total\": \"90.00\",'+
		'                \"rate1\": {'+
		'                    \"rate\": \"90.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate2\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate3\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate4\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate5\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate6\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate7\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate8\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"include\": true,'+
		'                \"mandatory\": true,'+
		'                \"priceEditable\": true,'+
		'                \"quantityEditable\": false,'+
		'                \"quantityRequired\": false'+
		'            },'+
		'            {'+
		'                \"id\": \"DELFSCG\",'+
		'                \"description\": \"Fuel Surcharge Delivery\",'+
		'                \"quantity\": 1,'+
		'                \"price\": \"18.00\",'+
		'                \"total\": \"18.00\",'+
		'                \"rate1\": {'+
		'                    \"rate\": \"18.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate2\": {'+
		'                    \"rate\": \"25.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate3\": {'+
		'                    \"rate\": \"45.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate4\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate5\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate6\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate7\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate8\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"include\": true,'+
		'                \"mandatory\": true,'+
		'                \"priceEditable\": false,'+
		'                \"quantityEditable\": false,'+
		'                \"quantityRequired\": false'+
		'            },'+
		'            {'+
		'                \"id\": \"PUFSCG\",'+
		'                \"description\": \"Fuel Surcharge Pick Up\",'+
		'                \"quantity\": 1,'+
		'                \"price\": \"18.00\",'+
		'                \"total\": \"18.00\",'+
		'                \"rate1\": {'+
		'                    \"rate\": \"18.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate2\": {'+
		'                    \"rate\": \"25.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate3\": {'+
		'                    \"rate\": \"45.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate4\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate5\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate6\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate7\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate8\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"include\": true,'+
		'                \"mandatory\": true,'+
		'                \"priceEditable\": false,'+
		'                \"quantityEditable\": false,'+
		'                \"quantityRequired\": false'+
		'            },'+
		'            {'+
		'                \"id\": \"PPE1\",'+
		'                \"description\": \"Personal Property Expense\",'+
		'                \"quantity\": 1,'+
		'                \"price\": \"4.20\",'+
		'                \"total\": \"0.00\",'+
		'                \"rate1\": {'+
		'                    \"rate\": \"4.20\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate2\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate3\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate4\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate5\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate6\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate7\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"rate8\": {'+
		'                    \"rate\": \"0.00\",'+
		'                    \"description\": null,'+
		'                    \"editable\": false'+
		'                },'+
		'                \"include\": true,'+
		'                \"mandatory\": true,'+
		'                \"priceEditable\": false,'+
		'                \"quantityEditable\": false,'+
		'                \"quantityRequired\": false'+
		'            }'+
		'        ],'+
		'        \"quoteExpires\": \"2013-05-22\",'+
		'        \"certificateOfInsurance\": \"On-Site - Not Applicable\",'+
		'        \"delivery\": \"108.00\",'+
		'        \"rentalCharge\": \"0.00\",'+
		'        \"pickUp\": \"108.00\",'+
		'        \"accessories\": \"0.00\",'+
		'        \"llw\": \"0.00\",'+
		'        \"other\": \"0.00\",'+
		'        \"codAmount\": \"0.00\",'+
		'        \"tax\": \"17.82\",'+
		'        \"totalCodAmount\": \"233.82\",'+
		'        \"hireTerms\": \"Net 10\",'+
		'        \"customerText1\": \"\",'+
		'        \"type\": \"rental\",'+
		'        \"mobilization\": 1,'+
		'        \"branchId\": \"106\",'+
		'        \"ytdSales\": 0,'+
		'        \"shippingDate\": \"2013-05-01\",'+
		'        \"shippingAddressId\": 0,'+
		'        \"shippingAddress\": {'+
		'            \"name\": \"ALLEN CONSTRUCTION CO///CCA\",'+
		'            \"address1\": \"326 COOPER STREET BLDG A 1\",'+
		'            \"address2\": \"\",'+
		'            \"address3\": \"CEDAR HILL\",'+
		'            \"address4\": \"\",'+
		'            \"state\": \"TX\",'+
		'            \"countryId\": \"USA\",'+
		'            \"crossStreet1\": \"\",'+ 
		'            \"crossStreet2\": \"\",'+
		'            \"taxId\": \"441133680\",'+ 
		'            \"deliveryZone\": \"\",'+
		'            \"cityZone\": 0,'+
		'            \"zoneWarning\": null,'+
		'            \"latitude\": null,'+
		'            \"longitude\": null,'+
		'            \"oldPostalCode\": null,'+
		'            \"zipCode\": \"75104-2628\",'+
		'            \"distanceFromBranch\": 0,'+
		'            \"distanceBranch\": null,'+
		'            \"fulfillingBranchId\": \"106\",'+
		'            \"fulfillingBranchName\": \"Dallas\"'+
		'        },'+
		'        \"shippingContactDetails\": {'+
		'            \"id\": \"\",'+
		'            \"name\": \"James Collins\",'+
		'            \"tel\": \"\",'+
		'            \"fax\": \"\",'+
		'            \"email\": \"\",'+
		'            \"mobile\": \"\"'+
		'        },'+
		'        \"shippingInstructions\": \"\",'+
		'        \"rentalLength\": 1'+
		'    }'+
		'}';
		EditFullQUoteService_AC obj = new EditFullQUoteService_AC();
		obj.parse(json);
		System.assert(obj != null);
	}
	
	
	
}