@isTest
public class TestLeadPostController {
  public static testMethod void testContoller() {
      LeadPostController LPC = NEW LeadPostController();
       LPC.xml = 'testdata';
       LPC.insertLeads();
       LPC.getPageURL();
  }
}