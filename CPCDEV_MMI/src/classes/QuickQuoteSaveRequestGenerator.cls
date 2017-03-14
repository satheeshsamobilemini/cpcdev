public with sharing class QuickQuoteSaveRequestGenerator {
     
     public String getQuickQuoteRefreshRequest(QuickQuoteWrapper qqWrapper,String branchId, String dateVal,String salesRep, String qqType){
     	//string branchId=null;
		String reqaddress='{}';
		Map<boolean,integer> IntMap=null;
		
		IntMap = new Map<boolean, integer>();
        IntMap.put(true,1);
        IntMap.put(false,0);
		           if(qqType=='Rental'){
		            SaveRentalQQRequest RQrequest=new SaveRentalQQRequest();
					
					QuickQuoteWrap qqWrap=new QuickQuoteWrap();
					
					qqWrap.duration=Integer.valueOf(qqWrapper.Duration);
					qqWrap.lead=qqWrapper.LeadOppName;
					qqWrap.transport=qqWrapper.Transport;
					qqWrap.transactionId=qqWrapper.TransactionType;
					qqWrap.rate=qqWrapper.Rate;
					//qqWrap.modificationCharge=QQRF.modificationCharge;
					qqWrap.rentalPPETotal=qqWrapper.Rental_PP_E;
					qqWrap.quickQuoteTotal=qqWrapper.QuickQuote;
					qqWrap.dateFrom=dateVal;
					qqWrap.productId=qqWrapper.Product;
					//qqWrap.ecode=QQRF.ecode;
					qqWrap.llwTotal=qqWrapper.LLW;
					qqWrap.locksTotal=qqWrapper.LocksAmount;
					qqWrap.taxTotal=qqWrapper.Tax;
					qqWrap.codAmount=qqWrapper.COD;
					
					qqWrap.branchId=branchId;
					qqWrap.includeLLW=IntMap.get(qqWrapper.isIncludeLLW);
					qqWrap.fuelSurcharge=IntMap.get(qqWrapper.isFuelSurcharge);
					qqWrap.locksQty=qqWrapper.Locks;
					qqWrap.companyId=1;
					qqWrap.operatorId='result';
					qqWrap.salesRep=salesRep;
					qqWrap.status='Active';
					
					Address address=new Address();
					address.state=qqWrapper.State;
					address.countryId=qqWrapper.country;
					address.address1=qqWrapper.Address;
					address.address2='';
					address.address3=qqWrapper.City;
					address.address4='';
					address.zipCode=qqWrapper.zipcode;
					address.taxId=qqwrapper.TaxId;
					address.fulfillingBranchId=branchId;
					
					
					qqWrap.shippingAddress=address;
					
					RQrequest.quickQuote=qqWrap;
	
				      reqaddress = JSON.serialize(RQrequest);
				    return reqaddress; 
				      
		           }else{
		           	
		           	SaveSalesQQRequest RQrequest=new SaveSalesQQRequest();
					
					QuickQuoteSalesWrap qqWrap=new QuickQuoteSalesWrap();
					
					qqWrap.duration=Integer.valueOf(qqWrapper.Duration);
					qqWrap.lead=qqWrapper.LeadOppName;
					//qqWrap.ecode=qqWrapper.ecode;
					qqWrap.ecode='';
					qqWrap.transport=qqWrapper.Transport;
					qqWrap.transactionId=qqWrapper.TransactionType;
					qqWrap.rate=qqWrapper.Rate;
					//qqWrap.modificationCharge=QQRF.modificationCharge;
					qqWrap.rentalPPETotal=qqWrapper.Rental_PP_E;
					qqWrap.transportSurchargeTotal=qqwrapper.FuelSurcharge;
					qqWrap.quickQuoteTotal=qqWrapper.QuickQuote;
					qqWrap.dateFrom=dateVal;
					qqWrap.productId=qqWrapper.Product;
					//qqWrap.ecode=QQRF.ecode;
					qqWrap.llwTotal=qqWrapper.LLW;
					qqWrap.locksTotal=qqWrapper.LocksAmount;
					qqWrap.taxTotal=qqWrapper.Tax;
					qqWrap.codAmount=qqWrapper.COD;
					
					qqWrap.branchId=branchId;
					qqWrap.includeLLW=IntMap.get(qqWrapper.isIncludeLLW);
					qqWrap.fuelSurcharge=IntMap.get(qqWrapper.isFuelSurcharge);
					qqWrap.locksQty=qqWrapper.Locks;
					qqWrap.companyId=1;
					qqWrap.operatorId='result';
					qqWrap.salesRep=salesRep;
					qqWrap.status='Active';
					
					Address address=new Address();
					address.state=qqWrapper.State;
					address.countryId=qqWrapper.country;
					address.address1=qqWrapper.Address;
					address.address2='';
					address.address3=qqWrapper.City;
					address.address4='';
					address.zipCode=qqWrapper.zipcode;
					address.taxId=qqwrapper.TaxId;
					address.fulfillingBranchId=branchId;
					
					qqWrap.shippingAddress=address;
					RQrequest.quickQuote=qqWrap;
				    reqaddress = JSON.serialize(RQrequest);
				    return reqaddress;
		       }
				
     }


    public class SaveRentalQQRequest {
       public QuickQuoteWrap quickQuote;
	}
	public class SaveSalesQQRequest {
       public QuickQuoteSalesWrap quickQuote;
	}
	public class QuickQuoteWrap {
		    public Integer duration;
			public String lead;
			public String transport;
			public String transactionId;
			public String rate;
			public String rentalPPETotal;
			public String quickQuoteTotal;
			public String dateFrom;
			public Address shippingAddress;
			public String productId;
			//public String ecode;
			public String branchId;
			public String llwTotal;
			public String locksTotal;
			public String taxTotal;
			public String codAmount;
			public Integer includeLLW;
			public Integer fuelSurcharge;
			public Integer locksQty;
			public Integer companyId;
			public String operatorId;
			public String salesRep;
			public String status;
			
	    }
	    
	    public class QuickQuoteSalesWrap {
		    public Integer duration;
			public String lead;
			public String ecode;
			public String transport;
			public String transactionId;
			public String rate;
			public String rentalPPETotal;
			public String transportSurchargeTotal;
			public String quickQuoteTotal;
			public String dateFrom;
			public Address shippingAddress;
			public String productId;
			//public String ecode;
			public String branchId;
			public String llwTotal;
			public String locksTotal;
			public String taxTotal;
			public String codAmount;
			public Integer includeLLW;
			public Integer fuelSurcharge;
			public Integer locksQty;
			public Integer companyId;
			public String operatorId;
			public String salesRep;
			public String status;
			
	    }
	
	public class Address {
		    public String state;
			public String countryId;
			public String address1;
			public String address2;
			public String address3;
			public String address4;
			public String zipCode;
			public String taxId;
			//public String deliveryZone;
			public String fulfillingBranchId;
		
	    }
	public String removeSpecialCharacters(String InputString){
     		if(InputString != null || InputString == ''){
	     		InputString = InputString.trim();
	     		InputString = InputString.replace('"', '\\"');
	     		InputString = InputString.replace('\n', ' ');
	     		InputString = InputString.replace('<br/>', ' ');
	     		InputString = InputString.replace('\r', ' ');
	    
	     		return InputString;
     		}else{
     			return '';
     		}
     	}	    
	 
}