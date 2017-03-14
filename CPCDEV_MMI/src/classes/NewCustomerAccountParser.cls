public with sharing class NewCustomerAccountParser {
	
        public String totalResults;
		public String nextLink;
		public String prevLink;
		public String firstLink;
		public String lastLink;
		public String duplicatesFound;
		public String accountType;
		public String addressType;
		public String errorMessage{get;set;}
	   

		public duplicateAccount[] duplicateAccounts;
		
	    public class duplicateAccount {
		
		    public String name;
			public address accountAddress;
			public String invoicedBalance;
			public String lastInvoiceDate;
			public String taxExemptionCertificate;
			public String taxExempt;
			public String creditStatus;
			public analysisDetail[] analysisDetails;
			public String duplicateNo;
		    public String dateCreated;
			public String createdBy;
			public String status;
			public String phoneNumber;
			public String salesforceId;
			public String addressType;
			public String accountType;
			public String id;
			public String ytdSales;
			
			
			
	    }
	    
	    public class address {
		    public String addressNo;
			public String addressLine1;
			public String addressLine2;
			public String addressLine3;
			public String addressLine4;
			public String state;
			public String countryId;
			public String zipCode;
	    }
	    
	     public class analysisDetail {
		    
	    }
	   
	   
	    
	    public NewCustomerAccountParser parse(String json) {
		//System.debug('********************'+(EditFullQUoteService_AC) System.JSON.deserialize(json, EditFullQUoteService_AC.class));
		//return (EditFullQUoteService_AC) System.JSON.deserialize(json, EditFullQUoteService_AC.class);
		return (NewCustomerAccountParser) System.JSON.deserialize(json, NewCustomerAccountParser.class);
	}



}