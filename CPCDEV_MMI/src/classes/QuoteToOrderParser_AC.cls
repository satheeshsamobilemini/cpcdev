public with sharing class QuoteToOrderParser_AC {

	public cls_quotePK quotePK;
	public String message;	//Quote conversionsucceeded.
	public cls_convertedContractPK convertedContractPK;
	public class cls_quotePK {
		public Integer companyId;	//1
		public Integer documentId;	//100000549
		public String type;	//rental
		public Decimal mobilization;	//1
	}
	public class cls_convertedContractPK {
		public Integer companyId;	//1
		public Integer documentId;	//100000304
		public String type;	//rental
		public Decimal mobilization;	//1
	}
	
	
	public String orderErrorMsg {get;set;}
	public QuoteToOrderParser_AC parseResponse(String jsonRespo){
		return (QuoteToOrderParser_AC) System.JSON.deserialize(jsonRespo, QuoteToOrderParser_AC.class);
	}


}