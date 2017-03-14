/**
* (c) 2015 TEKsystems Global Services
*
* Name           : FullQuoteUKMainController
* Created Date   : 18 March, 2015 @ 1130
* Created By     : TEK - Shankar Rao
* Purpose        : Product & Agreed value wrapper class used by 'FullQuoteUKMainController' class.
* 
**/
public class ProductsAgreedWrapper {
        public Product_UK__c pdtItem {get; set;}
        public String pdtAgreedValue {get; set;}
        public Boolean selected {get; set;}
        public String accessoryQuantity {get; set;}
        public String accessoryFrequency {get; set;}
        
        public ProductsAgreedWrapper(Product_UK__c forProduct, String pdtAgreedValue){
            this.pdtItem = forProduct;
            this.pdtAgreedValue = pdtAgreedValue;
            selected = false;
            accessoryQuantity = '1';
            accessoryFrequency = '';
        }
}