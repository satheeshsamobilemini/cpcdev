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
private class TestNewCustomerAccountParser {

    static testMethod void myUnitTest() {
    
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
		
		
		NewCustomerAccountParser newCustomerAccpar = new NewCustomerAccountParser();
		newCustomerAccpar.parse(json);
		
		
		NewCustomerAccountParser.duplicateAccount duplicatAcc = new NewCustomerAccountParser.duplicateAccount(); 
		NewCustomerAccountParser.address address = new NewCustomerAccountParser.address();
		NewCustomerAccountParser.analysisDetail analysDe = new NewCustomerAccountParser.analysisDetail();
		
    }
}