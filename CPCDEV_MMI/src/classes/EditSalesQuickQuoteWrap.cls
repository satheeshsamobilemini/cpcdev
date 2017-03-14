public with sharing class EditSalesQuickQuoteWrap {
   // ................ Edit ...............
   // public QuickQuote quickQuote;
    
  //  public class QuickQuote{
       
   // }
   //   public EditSalesQuickQuoteWrap(){
         //   shippingAddress=new ShippingAddress();
     // }
      
       public String lead;
        public String transactionId;
        public String accountId;
        public String ecode;
        public String salesRep;
        public String transport;
        public String operatorId;
        public String companyId;
        public String certificate;
        public String rate;
        public String lineValue;
        public String modificationCharge;
        public String rentalPPETotal;
        public String pickUpTotal;
        public String transportSurchargeTotal;
        public String pickupSurchargeTotal;
        public String llwTotal;
        public String locksPrice;
        public String locksTotal;
        public String taxTotal;
        public String codAmount;
        public String productId;
        public String branchId;
        public String quickQuoteTotal;
        public boolean includeLLW;
        public boolean fuelSurcharge;
        public String dateFrom;
        public String id;
        public String duration;
        public String locksQty;
        public String status;
        public boolean salesQuoteConvertible;
        public boolean rentalQuoteConvertible;
        public ShippingAddress shippingAddress3;
        
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
	
	public EditSalesQuickQuoteWrap parse(String json) {
		
		return (EditSalesQuickQuoteWrap) System.JSON.deserialize(json, EditSalesQuickQuoteWrap.class);
	}
	
}