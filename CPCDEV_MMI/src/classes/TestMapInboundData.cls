@isTest
public class TestMapInboundData {
   public static testMethod void testContoller() {
        MapInboundData MID = new MapInboundData();
        MID.mapInboundXmlData('<books><book>My Book</book><book>Your Book</book></books>');
        MapInboundData.handleSpecialChar('SJFJK]]DHAGVKJ[hjdhj]fd');
        MapInboundData.mapInboundXmlData360Partners('<books><book>My Book</book><book>Your Book</book></books>');
        MapInboundData.ContactInfo conInfo = new MapInboundData.ContactInfo();
        MapInboundData.Address  add= new MapInboundData.Address();
        MapInboundData.QuestionWithAnswers answ = new MapInboundData.QuestionWithAnswers();
        MapInboundData.Quoter  qu = new MapInboundData.Quoter();
        MapInboundData.LeadClass lc = new MapInboundData.LeadClass();
      
   }
}