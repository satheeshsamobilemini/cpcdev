@isTest
public class TestEditSalesQuickQuoteWrap {
     public static testMethod void testContoller() {
          EditSalesQuickQuoteWrap.ShippingAddress ESSA = new EditSalesQuickQuoteWrap.ShippingAddress();
          EditSalesQuickQuoteWrap ES =new EditSalesQuickQuoteWrap();
         String Json = '{"name":'+'"test"'+'}';
          ES.parse(json);
     }
}