public with sharing class CustomerActivityParser {
        public String totalResults;
		public String nextLink;
		public String prevLink;
		public String firstLink;
		public String lastLink;
		public quote[] quotes;
		public orderSummary[] orderSummaries;
		
        public class quote {
			public String quoteNumber;
			public double mobilisation;
			public String region;
			public String quoteCreated;
			public String quoteDate;
			public String salesRep;
			public String documentType;
			public String transactionCode;
			public String itemDefinitionCode;
			public String itemDescription;
			public String ecode;
			public String binLocation;
			public String price;
			public String deliveryCharges;
			public String deliverySurcharge;
			public String pickupCharges;
			public String pickupSurcharge;
			public String branchId;
			public String productId;

	    }
	    
	    public class orderSummary {
			public String accountId;
			public String accountName;
			public String documentId;
			public double mobilization;
			public String companyNumber;
			public String salesRep1;
			public String salesRep2;
			public String transactionId;
			public mainLines mainLine;
			public String totalOrderValue;
			public String totalCODAmount;
			public String activationDate; 
			public String type;
			public String branchId;
			public String shippingContactName;
			public String shippingContactNumber;
			public String shippingDate;
			
	    }
	    
	    
	    public class mainLines {
			public String itemId;
			public String itemDescription;
			public String qty;
			public String unitPrice;
			public String total;
			public String id;
	    }
	   
	   
	    
	    public CustomerActivityParser parse(String json) {
		//System.debug('********************'+(EditFullQUoteService_AC) System.JSON.deserialize(json, EditFullQUoteService_AC.class));
		//return (EditFullQUoteService_AC) System.JSON.deserialize(json, EditFullQUoteService_AC.class);
		return (CustomerActivityParser) System.JSON.deserialize(json, CustomerActivityParser.class);
	}
      
}